```java
package com.js.job.task;

import com.douyin.openapi.client.models.*;
import com.js.common.core.utils.DateUtils;
import com.js.common.core.utils.StringUtils;
import com.js.common.core.utils.bean.BeanUtils;
import com.js.douyin.web.app.service.DouyinWebAppDataOpenUserDataService;
import com.js.douyin.web.app.service.DouyinWebAppDataOpenVideoDataService;
import com.js.job.domain.*;
import com.js.job.mapper.*;
import com.js.job.vo.*;
import com.js.wechat.api.domain.WechatMiniProgramDouyinWebAppAuthorization;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 抖音账号数据七日数据分析定时任务
 *
 * @author zhengqiang
 * @date 2024/12/6 下午2:59
 */
@Component("douyinAccountBySevenTask")
public class DouyinAccountBySevenTask {
    @Autowired
    private DataAnalysisMapper dataAnalysisMapper;
    @Autowired
    private ConversionDouyinClueMapper conversionDouyinClueMapper;
    @Autowired
    private WechatMiniProgramDouyinAccountMapper wechatMiniProgramDouyinAccountMapper;
    @Autowired
    private DouyinWebAppDataOpenVideoDataService douyinWebAppDataOpenVideoDataService;
    @Autowired
    private ClipDouyinContentMapper clipDouyinContentMapper;
    @Autowired
    private DouyinWebAppDataOpenUserDataService douyinWebAppDataOpenUserDataService;
    @Autowired
    private DataAnalysisDouyinVideoBySevenDataAnalysisMapper dataAnalysisDouyinVideoBySevenDataAnalysisMapper;
    @Autowired
    private WechatMiniProgramDouyinWebAppAuthorizationMapper wechatMiniProgramDouyinWebAppAuthorizationMapper;

    public void updateDouyinVideoBySevenDataAnalysisTask() {
        //待插入七天天抖音账号数据分析
        List<DataAnalysisDouyinVideoBySevenDataAnalysis> insert = new ArrayList<>();
        //待更新的每天抖音账号数据分析
        List<DataAnalysisDouyinVideoBySevenDataAnalysis> updateList = new ArrayList<>();
        // 获取七天日期
        Date yesterday = getYesterdayDate();
        // 获取七天日期
        Date sevenDaysAgo = getDaysAgoDate(7);
        // 获取三十天前的日期
        Date thirtyDaysAgo = getDaysAgoDate(30);
        // 查询所有已授权的抖音号
        WechatMiniProgramDouyinWebAppAuthorization select = new WechatMiniProgramDouyinWebAppAuthorization();
        select.setDouyinWebAppAuthorizationStatus(1);
        select.setDelFlag(0);
        List<WechatMiniProgramDouyinWebAppAuthorization> wechatMiniProgramDouyinWebAppAuthorizations = wechatMiniProgramDouyinWebAppAuthorizationMapper.selectWechatMiniProgramDouyinWebAppAuthorizationList(select);
        Map<String, String> tokenMap = wechatMiniProgramDouyinWebAppAuthorizations
                .stream()
                .collect(Collectors.toMap(WechatMiniProgramDouyinWebAppAuthorization::getDouyinOpenId, WechatMiniProgramDouyinWebAppAuthorization::getAccessToken));

        // 七日总粉丝数集合
        Map<String, Long> totalFansSevenDayMap = new HashMap<>();
        // 七日新增粉丝数集合
        Map<String, Long> netGrowthFansSevenDayMap = new HashMap<>();
        // 七日日均粉丝数集合
        Map<String, BigDecimal> dailyAverageFansSevenDayMap = new HashMap<>();

        //粉丝数据
        tokenMap.forEach((douyinOpenId, token) -> {
//            UserFansDataResponse userFans100Data = douyinWebAppDataOpenFansPortraitDataService.getUserFansData(douyinOpenId, token);
//            UserFansDataResponseData data = userFans100Data.getData();
//            UserFansDataResponseDataFansData fansData = data.getFansData();
//            Integer totalFansYesterday = fansData.getAllFansNum();
//            //获取前天的粉丝总数
//            Integer totalFansBeforeYesterday = dataAnalysisDouyinVideoBySevenDataAnalysisMapper.getTotalFansBeforeYesterday(douyinOpenId, yesterday);
//            //获取7天粉丝变化（千粉以上）
            UserFansResponse userFans1kData = douyinWebAppDataOpenUserDataService.getUserFansCount(7, douyinOpenId, token);
            if (userFans1kData.getData() != null && userFans1kData.getData().getGwErrorCode() == 0){
                List<UserFansResponseDataResultListItem> resultList = userFans1kData.getData().getResultList();
                long sum = resultList.stream().map(UserFansResponseDataResultListItem::getTotalFans)
                        .mapToLong(count -> count != null ? count : 0) // 将null转换为0
                        .sum();
                UserFansResponseDataResultListItem yesterdayUserFansResponseDataResultListItem = resultList.get(resultList.size() - 1);
                UserFansResponseDataResultListItem sevenDayUserFansResponseDataResultListItem = resultList.get(0);
                Long totalFansYesterday = yesterdayUserFansResponseDataResultListItem.getTotalFans();
                Long totalFansSevenday = sevenDayUserFansResponseDataResultListItem.getTotalFans();
                totalFansSevenDayMap.put(douyinOpenId, totalFansYesterday);
                netGrowthFansSevenDayMap.put(douyinOpenId, Long.valueOf(totalFansYesterday - totalFansSevenday));
                dailyAverageFansSevenDayMap.put(douyinOpenId, BigDecimal.valueOf(sum / 7));
            }else{
                totalFansSevenDayMap.put(douyinOpenId, 0L);
                netGrowthFansSevenDayMap.put(douyinOpenId, 0L);
                dailyAverageFansSevenDayMap.put(douyinOpenId, BigDecimal.ZERO);
            }
        });

        // 查询全量抖音视频数据
        ClipDouyinContent selectClipDouyinContent = new ClipDouyinContent();
        selectClipDouyinContent.setDelFlag(0);
        selectClipDouyinContent.setDouyinReleaseStatus(1);
        List<ClipDouyinContent> allClipDouyinContentList = clipDouyinContentMapper.selectClipDouyinContentList(selectClipDouyinContent);
        // 按照 accountOperatorId, projectId 和 douyinOpenId 分组
//        Map<String, List<ClipDouyinContent>> allGroupedContentsMap = allClipDouyinContentList.stream()
//                .collect(Collectors.groupingBy(content ->
////                        content.getAccountOperatorId() + "_" +
//                                content.getProjectId() + "_" +
//                                content.getDouyinOpenId()
//                ));

        // 过滤出七天内抖音发布的内容
        List<ClipDouyinContent> sevenDayClipDouyinContentList = allClipDouyinContentList.stream()
                .filter(p -> p.getDouyinReleaseTime().after(sevenDaysAgo) && isBeforeToday(p.getDouyinReleaseTime())).collect(Collectors.toList());
        Map<String, List<ClipDouyinContent>> groupedSevenDayContentsMap = sevenDayClipDouyinContentList.stream()
                .collect(Collectors.groupingBy(content ->
//                        content.getAccountOperatorId() + "_" +
                                content.getProjectId() + "_" +
                                        content.getDouyinOpenId()
                ));
        // 过滤出30天内抖音发布的内容
        List<ClipDouyinContent> thirtyDayClipDouyinContentList = allClipDouyinContentList.stream().filter(p -> p.getDouyinReleaseTime() != null)
                .filter(p -> p.getDouyinReleaseTime().after(thirtyDaysAgo) && isBeforeToday(p.getDouyinReleaseTime())).collect(Collectors.toList());
        Map<String, List<ClipDouyinContent>> grouped30DayContentsMap = thirtyDayClipDouyinContentList.stream()
                .collect(Collectors.groupingBy(content ->
//                        content.getAccountOperatorId() + "_" +
                                content.getProjectId() + "_" +
                                        content.getDouyinOpenId()
                ));

        // 遍历分组后的内容
        // 七日总量集合（按分组存储总量）
        Map<String, Long> likesMap = new HashMap<>();
        Map<String, Long> commentsMap = new HashMap<>();
        Map<String, Long> playsMap = new HashMap<>();
        Map<String, Long> sharesMap = new HashMap<>();
        grouped30DayContentsMap.entrySet().stream()
                .forEach(entry -> {
                    List<ClipDouyinContent> contents = entry.getValue();
                    // 获取所有视频的点赞量
                    long totalLikes = contents.stream()
                            .mapToLong(content -> {
                                String accessToken = tokenMap.get(content.getDouyinOpenId());
                                if (StringUtils.isEmpty(accessToken)) {
                                    return 0L;
                                }
                                ItemLikeResponse likeData = douyinWebAppDataOpenVideoDataService.getLikeData(
                                        7, content.getDouyinItemId(), content.getDouyinOpenId(), accessToken
                                );
                                if (likeData.getData() != null && likeData.getData().getGwErrorCode() == 0) {
                                    List<ItemLikeResponseDataResultListItem> resultList = likeData.getData().getResultList();
                                    if (CollectionUtils.isNotEmpty(resultList)) {
                                        return resultList.stream().map(ItemLikeResponseDataResultListItem::getLike).mapToLong(count -> count != null ? count : 0).sum();
                                    }
                                }
                                return 0L;
                            }).sum();

                    // 获取所有视频的评论量
                    long totalComments = contents.stream()
                            .mapToLong(content -> {
                                String accessToken = tokenMap.get(content.getDouyinOpenId());
                                if (StringUtils.isEmpty(accessToken)) {
                                    return 0L;
                                }
                                ItemCommentResponse commentData = douyinWebAppDataOpenVideoDataService.getCommentData(
                                        7, content.getDouyinItemId(), content.getDouyinOpenId(), accessToken
                                );
                                if (commentData.getData() != null && commentData.getData().getGwErrorCode() == 0) {
                                    List<ItemCommentResponseDataResultListItem> resultList = commentData.getData().getResultList();
                                    if (CollectionUtils.isNotEmpty(resultList)) {
                                        return resultList.stream().map(ItemCommentResponseDataResultListItem::getComment).mapToLong(count -> count != null ? count : 0).sum();
                                    }
                                }
                                return 0L;
                            }).sum();

                    // 获取所有视频的播放量
                    long totalPlays = contents.stream()
                            .mapToLong(content -> {
                                String accessToken = tokenMap.get(content.getDouyinOpenId());
                                if (StringUtils.isEmpty(accessToken)) {
                                    return 0L;
                                }
                                ItemPlayResponse playData = douyinWebAppDataOpenVideoDataService.getPlayData(
                                        7, content.getDouyinItemId(), content.getDouyinOpenId(), accessToken
                                );
                                if (playData.getData() != null && playData.getData().getGwErrorCode() == 0) {
                                    List<ItemPlayResponseDataResultListItem> resultList = playData.getData().getResultList();
                                    if (CollectionUtils.isNotEmpty(resultList)) {
                                        return resultList.stream().map(ItemPlayResponseDataResultListItem::getPlay).mapToLong(count -> count != null ? count : 0).sum();
                                    }
                                }
                                return 0L;
                            }).sum();

                    // 获取所有视频的分享量
                    long totalShares = contents.stream()
                            .mapToLong(content -> {
                                String accessToken = tokenMap.get(content.getDouyinOpenId());
                                if (StringUtils.isEmpty(accessToken)) {
                                    return 0L;
                                }
                                ItemShareResponse shareData = douyinWebAppDataOpenVideoDataService.getShareData(
                                        7, content.getDouyinItemId(), content.getDouyinOpenId(), accessToken
                                );
                                if (shareData.getData() != null && shareData.getData().getGwErrorCode() == 0) {
                                    List<ItemShareResponseDataResultListItem> resultList = shareData.getData().getResultList();
                                    if (CollectionUtils.isNotEmpty(resultList)) {
                                        return resultList.stream().map(ItemShareResponseDataResultListItem::getShare).mapToLong(count -> count != null ? count : 0).sum();
                                    }
                                }
                                return 0L;
                            }).sum();

                    // 将每个统计量分别存储到对应的 Map 中
                    likesMap.put(entry.getKey(), totalLikes);
                    commentsMap.put(entry.getKey(), totalComments);
                    playsMap.put(entry.getKey(), totalPlays);
                    sharesMap.put(entry.getKey(), totalShares);
                });

        // 订单数据处理
        // 售卖券数
//        Map<String, Long> saledCertificateQuantityMap = new HashMap<>();
//        // 售卖gmv
//        Map<String, Long> saledGmvMap = new HashMap<>();
//        // 核销券数
//        Map<String, Long> fulfilCertificateQuantityMap = new HashMap<>();
//        // 核销gmv
//        Map<String, Long> fulfilGmvMap = new HashMap<>();
        // 全量抖音视频id
        List<String> douyinVideoIds = allClipDouyinContentList.stream().filter(p -> StringUtils.isNotBlank(p.getDouyinVideoId())).map(ClipDouyinContent::getDouyinVideoId).collect(Collectors.toList());
        // 全量抖音订单数据
        List<ConversionDouyinOrder> allConversionDouyinOrderList = conversionDouyinClueMapper.selectConversionDouyinOrderListByContentIds(douyinVideoIds);
//        // 全量抖音订单map
//        Map<String, List<ConversionDouyinOrder>> allConversionDouyinOrderMap = allConversionDouyinOrderList.stream().filter(p -> StringUtils.isNotBlank(p.getDouyinCode()))
//                .collect(Collectors.groupingBy(p -> p.getProjectId() + "_" + p.getOpenId()));

        // 七天抖音订单map
        Map<String, List<ConversionDouyinOrder>> sevenDayConversionDouyinOrderMap = new HashMap<>();
        // 七天抖音券码map
        Map<String, List<ConversionDouyinCertificate>> sevenDayConversionDouyinCertificateMap = new HashMap<>();
        // 七天抖音线索map
        Map<String, List<ConversionDouyinClue>> sevenDayConversionDouyinClueMap = new HashMap<>();
        // 全量抖音订单id
        List<String> douyinOrderIds = allConversionDouyinOrderList.stream().map(ConversionDouyinOrder::getDouyinOrderId).collect(Collectors.toList());
        if (CollectionUtils.isNotEmpty(douyinOrderIds)){
            // 全量抖音券码
            List<ConversionDouyinCertificate> allConversionDouyinCertificateList = conversionDouyinClueMapper.selectConversionDouyinCertificateListByDouyinOrderIds(douyinOrderIds);
            // 七日抖音券码
            List<ConversionDouyinCertificate> sevenDayConversionDouyinCertificateList = allConversionDouyinCertificateList.stream()
                    .filter(p -> p.getVerifyTime().after(sevenDaysAgo) && isBeforeToday(p.getVerifyTime())).collect(Collectors.toList());
            // 七天抖音券码map
            sevenDayConversionDouyinCertificateMap = sevenDayConversionDouyinCertificateList.stream()
                    .filter(certificate -> StringUtils.isNotBlank(certificate.getDouyinOrderId()))
                    .collect(Collectors.groupingBy(certificate -> {
                        // 找到对应的订单信息
                        ConversionDouyinOrder order = allConversionDouyinOrderList.stream()
                                .filter(o -> o.getDouyinOrderId().equals(certificate.getDouyinOrderId()))
                                .findFirst().orElse(null);
                        // 如果订单存在，则使用 ProjectId 和 OpenId 生成 key
                        return order != null ? order.getProjectId() + "_" + order.getOpenId() : null;
                    }, Collectors.toList()));
            // 删除 key 为 null 的无效数据
            sevenDayConversionDouyinCertificateMap.remove(null);

            // 过滤出七天的抖音订单信息
            List<ConversionDouyinOrder> sevenDayConversionDouyinOrderList = allConversionDouyinOrderList.stream()
                    .filter(p -> convertTimestampToDate(p.getPayTime()).after(sevenDaysAgo) && isBeforeToday(convertTimestampToDate(p.getPayTime()))).collect(Collectors.toList());
            // 七天抖音订单map
            sevenDayConversionDouyinOrderMap = sevenDayConversionDouyinOrderList.stream().filter(p -> StringUtils.isNotBlank(p.getDouyinCode()))
                    .collect(Collectors.groupingBy(p -> p.getProjectId() + "_" + p.getOpenId()));

            // 全量线索数据
            List<ConversionDouyinClue> allConversionDouyinClueList = conversionDouyinClueMapper.selectConversionDouyinClueListByVideoIds(douyinVideoIds);
            // 七天线索数据
            List<ConversionDouyinClue> sevenDayConversionDouyinClueList = allConversionDouyinClueList.stream().filter(p -> stringToDate(p.getCreateTimeDetail(), "yyyy-MM-dd HH:mm:ss") != null)
                    .filter(p -> stringToDate(p.getCreateTimeDetail(), "yyyy-MM-dd HH:mm:ss").after(sevenDaysAgo) && isBeforeToday(stringToDate(p.getCreateTimeDetail(), "yyyy-MM-dd HH:mm:ss"))).collect(Collectors.toList());
            // 七天抖音线索map
            sevenDayConversionDouyinClueMap = sevenDayConversionDouyinClueList.stream()
                    .filter(p -> p.getVideoId() != null)
                    .collect(Collectors.groupingBy(douyinClue -> {
                        // 找到对应的订单信息
                        ClipDouyinContent clipDouyinContent = allClipDouyinContentList.stream()
                                .filter(content -> Objects.equals(content.getDouyinVideoId(), douyinClue.getVideoId()))
                                .findFirst().orElse(null);
                        // 如果订单存在，则使用 ProjectId 和 OpenId 生成 key
                        return clipDouyinContent != null ? clipDouyinContent.getProjectId() + "_" + clipDouyinContent.getDouyinOpenId() : null;
                    }, Collectors.toList()));
            // 删除 key 为 null 的无效数据
            sevenDayConversionDouyinClueMap.remove(null);
        }

        // 查询所有 项目下运营人绑定的已授权 的抖音账号
        List<WechatMiniProgramDouyinAccountVO> wechatMiniProgramDouyinAccountVOS = wechatMiniProgramDouyinAccountMapper.selectAuthorizationProjectDouyinAccount();
        Map<String, List<WechatMiniProgramDouyinAccountVO>> groupDouyinAccountMap = wechatMiniProgramDouyinAccountVOS.stream()
                .collect(Collectors.groupingBy(content ->
//                        content.getAccountOperatorId() + "_" +
                                content.getProjectId() + "_" +
                                        content.getDouyinOpenId()
                ));

        for (Map.Entry<String, List<WechatMiniProgramDouyinAccountVO>> entry : groupDouyinAccountMap.entrySet()) {
            String key = entry.getKey();
            List<WechatMiniProgramDouyinAccountVO> value = entry.getValue();
            //新增线索数
            Long clueQuantityByDay = 0L;
            //新增售卖券数 七日
            Long saledCertificateQuantityByDay = 0L;
            //新增售卖GMV 七日
            BigDecimal saledGmvByDay = BigDecimal.ZERO;
            //新增核销券数 七日
            Long fulfilCertificateQuantityByDay = 0L;
            //新增核销GMV 七日
            BigDecimal fulfilGmvByDay = BigDecimal.ZERO;

            DataAnalysisDouyinVideoBySevenDataAnalysis dataAnalysisDouyinVideoBySevenDataAnalysis = new DataAnalysisDouyinVideoBySevenDataAnalysis();
            WechatMiniProgramDouyinAccountVO item = value.get(0);
            dataAnalysisDouyinVideoBySevenDataAnalysis.setDouyinOpenId(item.getDouyinOpenId());
            dataAnalysisDouyinVideoBySevenDataAnalysis.setDouyinCode(item.getDouyinCode());
            dataAnalysisDouyinVideoBySevenDataAnalysis.setAccountOperatorId(item.getAccountOperatorId());
            dataAnalysisDouyinVideoBySevenDataAnalysis.setProjectId(item.getProjectId());
            // 粉丝数据
            dataAnalysisDouyinVideoBySevenDataAnalysis.setTotalFans(totalFansSevenDayMap.getOrDefault(item.getDouyinOpenId(), 0L));
            dataAnalysisDouyinVideoBySevenDataAnalysis.setDailyAverageFans(dailyAverageFansSevenDayMap.getOrDefault(item.getDouyinOpenId(), BigDecimal.ZERO));
            dataAnalysisDouyinVideoBySevenDataAnalysis.setNetGrowthFans(netGrowthFansSevenDayMap.getOrDefault(item.getDouyinOpenId(), 0L));
            // 内容数据
            List<ClipDouyinContent> clipDouyinContents = groupedSevenDayContentsMap.get(key);
            if(CollectionUtils.isNotEmpty(clipDouyinContents)){
                dataAnalysisDouyinVideoBySevenDataAnalysis.setContribution(Long.valueOf(clipDouyinContents.size()));
            }else {
                dataAnalysisDouyinVideoBySevenDataAnalysis.setContribution(0L);
            }
            // 计算加权互动率 = (点赞数 * 0.2 + 评论数 * 0.5 + 分享数 * 0.3) / 播放量
            long worksLike = likesMap.getOrDefault(key, 0L);
            long worksComment = commentsMap.getOrDefault(key, 0L);
            long worksShare = sharesMap.getOrDefault(key, 0L);
            long playCount = playsMap.getOrDefault(key, 0L);

            dataAnalysisDouyinVideoBySevenDataAnalysis.setWorksLike(worksLike);
            dataAnalysisDouyinVideoBySevenDataAnalysis.setWorksComment(worksComment);
            dataAnalysisDouyinVideoBySevenDataAnalysis.setWorksShare(worksShare);
            dataAnalysisDouyinVideoBySevenDataAnalysis.setPlayCount(playCount);
//            dataAnalysisDouyinVideoBySevenDataAnalysis.setHomepageAccess();

            // 确保播放量不为零，避免除零错误
            if (playCount > 0) {
                double weightedInteractionRate = (worksLike * 0.2 + worksComment * 0.5 + worksShare * 0.3) / (double) playCount;
                dataAnalysisDouyinVideoBySevenDataAnalysis.setWeightedInteractionRate(BigDecimal.valueOf(weightedInteractionRate));
            } else {
                // 如果播放量为零，设置加权互动率为零或其他默认值
                dataAnalysisDouyinVideoBySevenDataAnalysis.setWeightedInteractionRate(BigDecimal.ZERO);
            }

            // 订单数据
            // 七日售卖券、售卖gmv
            List<ConversionDouyinOrder> sevenDayDouyinOrderList = sevenDayConversionDouyinOrderMap.get(key);
            if (CollectionUtils.isNotEmpty(sevenDayDouyinOrderList)) {
                saledCertificateQuantityByDay = sevenDayDouyinOrderList.stream()
                        .map(ConversionDouyinOrder::getCount)
                        .mapToLong(count -> count != null ? count : 0) // 将null转换为0
                        .sum();
                saledGmvByDay = new BigDecimal(sevenDayDouyinOrderList.stream()
                        .map(ConversionDouyinOrder::getReceiptAmount)
                        .mapToLong(count -> count != null ? count : 0) // 将null转换为0
                        .sum()).divide(BigDecimal.valueOf(100));// 分转换为元
            }
            // 七日核销券、核销gmv
            List<ConversionDouyinCertificate> sevenConversionDouyinCertificateList = sevenDayConversionDouyinCertificateMap.get(key);
            if (CollectionUtils.isNotEmpty(sevenConversionDouyinCertificateList)) {
                fulfilCertificateQuantityByDay = (Long.valueOf(sevenConversionDouyinCertificateList.size()));
                // 求和七日核销券的实收金额
                long sumReceiptAmount = sevenConversionDouyinCertificateList.stream()
                        .map(ConversionDouyinCertificate::getReceiptAmount) // 提取 ReceiptAmount
                        .filter(Objects::nonNull) // 过滤掉 null 值
                        .mapToLong(Long::longValue) // 转换为 long 值
                        .sum();
                // 核销 GMV (将金额转换为单位: 元)
                fulfilGmvByDay = BigDecimal.valueOf(sumReceiptAmount)
                        .divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP); // 保留两位小数，四舍五入
            }
            dataAnalysisDouyinVideoBySevenDataAnalysis.setSaledCertificateQuantity(saledCertificateQuantityByDay);
            dataAnalysisDouyinVideoBySevenDataAnalysis.setSaledGmv(saledGmvByDay);
            dataAnalysisDouyinVideoBySevenDataAnalysis.setFulfilCertificateQuantity(fulfilCertificateQuantityByDay);
            dataAnalysisDouyinVideoBySevenDataAnalysis.setFulfilGmv(fulfilGmvByDay);
            List<ConversionDouyinClue> conversionDouyinClues = sevenDayConversionDouyinClueMap.get(key);
            if(CollectionUtils.isNotEmpty(conversionDouyinClues)){
                clueQuantityByDay = Long.valueOf(conversionDouyinClues.size());
            }
            dataAnalysisDouyinVideoBySevenDataAnalysis.setClueQuantity(clueQuantityByDay);

            dataAnalysisDouyinVideoBySevenDataAnalysis.setCreateBy("job");
            dataAnalysisDouyinVideoBySevenDataAnalysis.setCreateTime(DateUtils.getNowDate());
            dataAnalysisDouyinVideoBySevenDataAnalysis.setUpdateBy("job");
            dataAnalysisDouyinVideoBySevenDataAnalysis.setUpdateTime(DateUtils.getNowDate());
            insert.add(dataAnalysisDouyinVideoBySevenDataAnalysis);
        }
        if (CollectionUtils.isNotEmpty(insert)) {
            dataAnalysisDouyinVideoBySevenDataAnalysisMapper.batchInsert(insert);
        }
    }

    // 获取七天的日期（去除时间部分）
    private static Date getYesterdayDate() {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -1); // 设置为七天
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        return cal.getTime();
    }

    // 获取指定天数前的日期
    private static Date getDaysAgoDate(int days) {
        Date currentDate = new Date();
        long millisAgo = currentDate.getTime() - (long) days * 86400000L;
        Date date = new Date(millisAgo);
        date.setHours(0);
        date.setMinutes(0);
        date.setSeconds(0);
        return date;
    }

    // 判断日期是否为同一天
    private static boolean isSameDay(Date date1, Date date2) {
        if (date1 == null || date2 == null) {
            return false;
        }
        Calendar cal1 = Calendar.getInstance();
        Calendar cal2 = Calendar.getInstance();
        cal1.setTime(date1);
        cal2.setTime(date2);
        return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR)
                && cal1.get(Calendar.MONTH) == cal2.get(Calendar.MONTH)
                && cal1.get(Calendar.DAY_OF_MONTH) == cal2.get(Calendar.DAY_OF_MONTH);
    }

    // 判断日期是否在今天之前
    private static boolean isBeforeToday(Date date) {
        Date today = removeTime(new Date());
        return date.before(today);
    }

    // 去除时间部分，保留日期
    private static Date removeTime(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        return cal.getTime();
    }

    // 将时间戳转换为 Date 对象
    private static Date convertTimestampToDate(long timestamp) {
        Date date = new Date(timestamp * 1000);
        date.setHours(0);
        date.setMinutes(0);
        date.setSeconds(0);
        return date;
    }

    // 判断时间戳对应的日期是否为七天
    private static boolean isSameDayByTimestamp(long timestamp, Date date) {
        Date dateFromTimestamp = removeTime(new Date(timestamp * 1000));
        Date dateOnly = removeTime(date);
        return isSameDay(dateFromTimestamp, dateOnly);
    }

    /**
     * 将字符串转换为 Date 类型
     *
     * @param dateStr   要转换的日期字符串
     * @param formatStr 日期格式，例如 "yyyy-MM-dd HH:mm:ss"
     * @return 转换后的 Date 对象，如果格式不正确则返回 null
     */
    public static Date stringToDate(String dateStr, String formatStr) {
        if (dateStr == null || formatStr == null) {
            return null;
        }
        SimpleDateFormat dateFormat = new SimpleDateFormat(formatStr);
        try {
            return dateFormat.parse(dateStr);
        } catch (Exception e) {
            return null;
        }
    }
}

```