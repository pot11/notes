```java
package com.js.job.task;

import com.douyin.openapi.client.models.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.js.common.core.annotation.Excel;
import com.js.common.core.utils.DateUtils;
import com.js.common.core.utils.StringUtils;
import com.js.douyin.web.app.service.DouyinWebAppDataOpenFansPortraitDataService;
import com.js.douyin.web.app.service.DouyinWebAppDataOpenUserDataService;
import com.js.douyin.web.app.service.DouyinWebAppDataOpenVideoDataService;
import com.js.job.domain.*;
import com.js.job.mapper.*;
import com.js.job.vo.*;
import com.js.wechat.api.domain.WechatMiniProgramDouyinWebAppAuthorization;
import io.swagger.annotations.ApiModelProperty;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 抖音账号 数据每日数据分析定时任务（微信小程序业务库 ）
 *
 * @author zhengqiang
 * @date 2024/12/6 下午5:59
 */
@Component("wechatMiniProgramDouyinAccountDataAnalysisTask")
public class WechatMiniProgramDouyinAccountTask {

    /**
     *
     * 粉丝数（账号下昨日粉丝数）
     * 最新内容发布时间（账号下最新发布集森内容时间）
     * 未内容发布天数（当前时间 - 账号下最新发布集森内容时间）
     */
    @Autowired
    private ConversionDouyinClueMapper conversionDouyinClueMapper;
    @Autowired
    private DataAnalysisMapper dataAnalysisMapper;
    @Autowired
    private DataAnalysisDouyinVideoByDayDataAnalysisMapper dataAnalysisDouyinVideoByDayDataAnalysisMapper;
    @Autowired
    private DouyinWebAppDataOpenFansPortraitDataService douyinWebAppDataOpenFansPortraitDataService;
    @Autowired
    private ClipDouyinContentMapper clipDouyinContentMapper;
    @Autowired
    private WechatMiniProgramDouyinWebAppAuthorizationMapper wechatMiniProgramDouyinWebAppAuthorizationMapper;
    @Autowired
    private WechatMiniProgramDouyinAccountMapper wechatMiniProgramDouyinAccountMapper;
    @Autowired
    private WechatMiniProgramDouyinAccountDataAnalysisMapper wechatMiniProgramDouyinAccountDataAnalysisMapper;
    @Autowired
    private DouyinWebAppDataOpenVideoDataService douyinWebAppDataOpenVideoDataService;
    @Autowired
    private DouyinWebAppDataOpenUserDataService douyinWebAppDataOpenUserDataService;

    public void updateWechatMiniProgramDouyinVideoByDayDataAnalysisTask() {
        // 获取昨天、七天前、三十天前的日期
        Date yesterday = getYesterdayDate();
        Date sevenDaysAgo = getDaysAgoDate(7);
        Date thirtyDaysAgo = getDaysAgoDate(30);

        // 查询所有已授权的抖音号
        WechatMiniProgramDouyinWebAppAuthorization select = new WechatMiniProgramDouyinWebAppAuthorization();
        select.setDouyinWebAppAuthorizationStatus(1);
        select.setDelFlag(0);
        List<WechatMiniProgramDouyinWebAppAuthorization> wechatMiniProgramDouyinWebAppAuthorizations = wechatMiniProgramDouyinWebAppAuthorizationMapper.selectWechatMiniProgramDouyinWebAppAuthorizationList(select);
        Map<String, String> tokenMap = wechatMiniProgramDouyinWebAppAuthorizations
                .stream()
                .collect(Collectors.toMap(WechatMiniProgramDouyinWebAppAuthorization::getDouyinOpenId, WechatMiniProgramDouyinWebAppAuthorization::getAccessToken));

        // 昨日总粉丝数集合
        Map<String, Long> totalFansYesterDayMap = new HashMap<>();
        // 昨日新增粉丝数集合
        Map<String, Long> netGrowthFansMap = new HashMap<>();
        // 七日总粉丝数集合
        Map<String, Long> totalFansSevenDayMap = new HashMap<>();
        // 七日新增粉丝数集合
        Map<String, Long> netGrowthFansSevenDayMap = new HashMap<>();
        // 七日日均粉丝数集合
        Map<String, BigDecimal> dailyAverageFansSevenDayMap = new HashMap<>();
        // 三十日总粉丝数集合
        Map<String, Long> totalFansThirtyDayMap = new HashMap<>();
        // 三十日新增粉丝数集合
        Map<String, Long> netGrowthFansThirtyDayMap = new HashMap<>();
        // 三十日日均粉丝数集合
        Map<String, BigDecimal> dailyAverageFansThirtyDayMap = new HashMap<>();

        //粉丝数据
        tokenMap.forEach((douyinOpenId, token) -> {
            // 获取30天粉丝变化（千粉以上）
            UserFansResponse userFans1kData = douyinWebAppDataOpenUserDataService.getUserFansCount(30, douyinOpenId, token);
            if (userFans1kData.getData() != null && userFans1kData.getData().getGwErrorCode() == 0) {
                List<UserFansResponseDataResultListItem> resultList = userFans1kData.getData().getResultList();

                // 昨日数据
                UserFansResponseDataResultListItem yesterdayItem = resultList.get(resultList.size() - 1);
                UserFansResponseDataResultListItem dayBeforeYesterdayItem = resultList.get(resultList.size() - 2);
                Long totalFansYesterday = yesterdayItem.getTotalFans();
                Long totalFansDayBeforeYesterday = dayBeforeYesterdayItem.getTotalFans();
                totalFansYesterDayMap.put(douyinOpenId, totalFansYesterday);
                netGrowthFansMap.put(douyinOpenId, totalFansYesterday - totalFansDayBeforeYesterday);

                // 七天数据
                UserFansResponseDataResultListItem sevenDaysAgoItem = resultList.get(resultList.size() - 7);
                long sevenDaySum = resultList.subList(resultList.size() - 7, resultList.size()).stream()
                        .map(UserFansResponseDataResultListItem::getTotalFans)
                        .mapToLong(count -> count != null ? count : 0)
                        .sum();
                Long totalFansSevenDaysAgo = sevenDaysAgoItem.getTotalFans();
                totalFansSevenDayMap.put(douyinOpenId, totalFansYesterday);
                netGrowthFansSevenDayMap.put(douyinOpenId, totalFansYesterday - totalFansSevenDaysAgo);
                dailyAverageFansSevenDayMap.put(douyinOpenId, BigDecimal.valueOf(sevenDaySum / 7));

                // 三十日数据
                UserFansResponseDataResultListItem thirtyDaysAgoItem = resultList.get(0);
                long thirtyDaySum = resultList.stream().map(UserFansResponseDataResultListItem::getTotalFans)
                        .mapToLong(count -> count != null ? count : 0)
                        .sum();
                Long totalFansThirtyDaysAgo = thirtyDaysAgoItem.getTotalFans();
                totalFansThirtyDayMap.put(douyinOpenId, totalFansYesterday);
                netGrowthFansThirtyDayMap.put(douyinOpenId, totalFansYesterday - totalFansThirtyDaysAgo);
                dailyAverageFansThirtyDayMap.put(douyinOpenId, BigDecimal.valueOf(thirtyDaySum / 30));

            } else {
                // 默认值处理
                totalFansYesterDayMap.put(douyinOpenId, 0L);
                netGrowthFansMap.put(douyinOpenId, 0L);
                dailyAverageFansSevenDayMap.put(douyinOpenId, BigDecimal.ZERO);
                totalFansSevenDayMap.put(douyinOpenId, 0L);
                netGrowthFansSevenDayMap.put(douyinOpenId, 0L);
                dailyAverageFansSevenDayMap.put(douyinOpenId, BigDecimal.ZERO);
                totalFansThirtyDayMap.put(douyinOpenId, 0L);
                netGrowthFansThirtyDayMap.put(douyinOpenId, 0L);
                dailyAverageFansThirtyDayMap.put(douyinOpenId, BigDecimal.ZERO);
            }
        });

        // 查询全量抖音视频数据
        ClipDouyinContent selectClipDouyinContent = new ClipDouyinContent();
        selectClipDouyinContent.setDelFlag(0);
        selectClipDouyinContent.setDouyinReleaseStatus(1);
        List<ClipDouyinContent> allClipDouyinContentList = clipDouyinContentMapper.selectClipDouyinContentList(selectClipDouyinContent);
        // 按照 accountOperatorId, projectId 和 douyinOpenId 分组
        Map<String, List<ClipDouyinContent>> allGroupedContentsMap = allClipDouyinContentList.stream()
                .collect(Collectors.groupingBy(content ->
//                        content.getAccountOperatorId() + "_" +
                                content.getProjectId() + "_" +
                                content.getDouyinOpenId()
                ));

        // 过滤出昨天内抖音发布的内容
        List<ClipDouyinContent> yesterDayClipDouyinContentList = allClipDouyinContentList.stream()
                .filter(p -> isSameDay(p.getDouyinReleaseTime(), yesterday)).collect(Collectors.toList());
        Map<String, List<ClipDouyinContent>> groupedYesterDayContentsMap = yesterDayClipDouyinContentList.stream()
                .collect(Collectors.groupingBy(content ->
//                        content.getAccountOperatorId() + "_" +
                                content.getProjectId() + "_" +
                                        content.getDouyinOpenId()
                ));

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
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate today = LocalDate.now();
        LocalDate yesterdayConvert = today.minusDays(1);
        LocalDate sevenDaysAgoConvert  = today.minusDays(7);
        LocalDate thirtyDaysAgoConvert  = today.minusDays(30);

        // 昨日总量集合（按分组存储总量）
        Map<String, Long> likesYesterDayMap = new HashMap<>();
        Map<String, Long> commentsYesterDayMap = new HashMap<>();
        Map<String, Long> playsYesterDayMap = new HashMap<>();
        Map<String, Long> sharesYesterDayMap = new HashMap<>();
        // 七日总量集合（按分组存储总量）
        Map<String, Long> likesSevenDayMap = new HashMap<>();
        Map<String, Long> commentsSevenDayMap = new HashMap<>();
        Map<String, Long> playsSevenDayMap = new HashMap<>();
        Map<String, Long> sharesSevenDayMap = new HashMap<>();
        // 三十日总量集合（按分组存储总量）
        Map<String, Long> likesThirtyDayMap = new HashMap<>();
        Map<String, Long> commentsThirtyDayMap = new HashMap<>();
        Map<String, Long> playsThirtyDayMap = new HashMap<>();
        Map<String, Long> sharesThirtyDayMap = new HashMap<>();

        grouped30DayContentsMap.entrySet().stream()
                .forEach(entry -> {
                    String groupKey = entry.getKey();
                    List<ClipDouyinContent> contents = entry.getValue();

                    // 累计各指标数据
                    long totalLikesYesterday = 0L, totalLikesSevenDays = 0L, totalLikesThirtyDays = 0L;
                    long totalCommentsYesterday = 0L, totalCommentsSevenDays = 0L, totalCommentsThirtyDays = 0L;
                    long totalPlaysYesterday = 0L, totalPlaysSevenDays = 0L, totalPlaysThirtyDays = 0L;
                    long totalSharesYesterday = 0L, totalSharesSevenDays = 0L, totalSharesThirtyDays = 0L;

                    for (ClipDouyinContent content : contents) {
                        String accessToken = tokenMap.get(content.getDouyinOpenId());
                        if (StringUtils.isEmpty(accessToken)) {
                            continue;
                        }

                        // 获取点赞数据
                        ItemLikeResponse likeData = douyinWebAppDataOpenVideoDataService.getLikeData(
                                30, content.getDouyinItemId(), content.getDouyinOpenId(), accessToken);
                        if (likeData.getData() != null && likeData.getData().getGwErrorCode() == 0) {
                            Map<LocalDate, Long> likeDataByDate = likeData.getData().getResultList().stream()
                                    .collect(Collectors.toMap(
                                            item -> LocalDate.parse(item.getDate(), formatter),
                                            ItemLikeResponseDataResultListItem::getLike));
                            totalLikesYesterday += likeDataByDate.entrySet().stream()
                                    .filter(e -> e.getKey().equals(yesterdayConvert))
                                    .mapToLong(Map.Entry::getValue).sum();
                            totalLikesSevenDays += likeDataByDate.entrySet().stream()
                                    .filter(e -> !e.getKey().isBefore(sevenDaysAgoConvert) && !e.getKey().isAfter(today))
                                    .mapToLong(Map.Entry::getValue).sum();
                            totalLikesThirtyDays += likeDataByDate.entrySet().stream()
                                    .filter(e -> !e.getKey().isBefore(thirtyDaysAgoConvert) && !e.getKey().isAfter(today))
                                    .mapToLong(Map.Entry::getValue).sum();
                        }

                        // 获取评论数据
                        ItemCommentResponse commentData = douyinWebAppDataOpenVideoDataService.getCommentData(
                                30, content.getDouyinItemId(), content.getDouyinOpenId(), accessToken);
                        if (commentData.getData() != null && commentData.getData().getGwErrorCode() == 0) {
                            List<ItemCommentResponseDataResultListItem> commentResults = commentData.getData().getResultList();
                            totalCommentsYesterday += commentResults.stream()
                                    .filter(item -> LocalDate.parse(item.getDate(), formatter).equals(yesterdayConvert))
                                    .mapToLong(ItemCommentResponseDataResultListItem::getComment).sum();
                            totalCommentsSevenDays += commentResults.stream()
                                    .filter(item -> {
                                        LocalDate date = LocalDate.parse(item.getDate(), formatter);
                                        return !date.isBefore(sevenDaysAgoConvert) && !date.isAfter(today);
                                    }).mapToLong(ItemCommentResponseDataResultListItem::getComment).sum();
                            totalCommentsThirtyDays += commentResults.stream()
                                    .filter(item -> {
                                        LocalDate date = LocalDate.parse(item.getDate(), formatter);
                                        return !date.isBefore(thirtyDaysAgoConvert) && !date.isAfter(today);
                                    }).mapToLong(ItemCommentResponseDataResultListItem::getComment).sum();
                        }

                        // 获取播放数据
                        ItemPlayResponse playData = douyinWebAppDataOpenVideoDataService.getPlayData(
                                30, content.getDouyinItemId(), content.getDouyinOpenId(), accessToken);
                        if (playData.getData() != null && playData.getData().getGwErrorCode() == 0) {
                            Map<LocalDate, Long> playDataByDate = playData.getData().getResultList().stream()
                                    .collect(Collectors.toMap(
                                            item -> LocalDate.parse(item.getDate(), formatter),
                                            ItemPlayResponseDataResultListItem::getPlay));
                            totalPlaysYesterday += playDataByDate.entrySet().stream()
                                    .filter(e -> e.getKey().equals(yesterdayConvert))
                                    .mapToLong(Map.Entry::getValue).sum();
                            totalPlaysSevenDays += playDataByDate.entrySet().stream()
                                    .filter(e -> !e.getKey().isBefore(sevenDaysAgoConvert) && !e.getKey().isAfter(today))
                                    .mapToLong(Map.Entry::getValue).sum();
                            totalPlaysThirtyDays += playDataByDate.entrySet().stream()
                                    .filter(e -> !e.getKey().isBefore(thirtyDaysAgoConvert) && !e.getKey().isAfter(today))
                                    .mapToLong(Map.Entry::getValue).sum();
                        }

                        // 获取分享数据
                        ItemShareResponse shareData = douyinWebAppDataOpenVideoDataService.getShareData(
                                30, content.getDouyinItemId(), content.getDouyinOpenId(), accessToken);
                        if (shareData.getData() != null && shareData.getData().getGwErrorCode() == 0) {
                            Map<LocalDate, Long> shareDataByDate = shareData.getData().getResultList().stream()
                                    .collect(Collectors.toMap(
                                            item -> LocalDate.parse(item.getDate(), formatter),
                                            ItemShareResponseDataResultListItem::getShare));
                            totalSharesYesterday += shareDataByDate.entrySet().stream()
                                    .filter(e -> e.getKey().equals(yesterdayConvert))
                                    .mapToLong(Map.Entry::getValue).sum();
                            totalSharesSevenDays += shareDataByDate.entrySet().stream()
                                    .filter(e -> !e.getKey().isBefore(sevenDaysAgoConvert) && !e.getKey().isAfter(today))
                                    .mapToLong(Map.Entry::getValue).sum();
                            totalSharesThirtyDays += shareDataByDate.entrySet().stream()
                                    .filter(e -> !e.getKey().isBefore(thirtyDaysAgoConvert) && !e.getKey().isAfter(today))
                                    .mapToLong(Map.Entry::getValue).sum();
                        }
                    }

                    // 按分组存储到对应 Map 中
                    likesYesterDayMap.put(groupKey, totalLikesYesterday);
                    likesSevenDayMap.put(groupKey, totalLikesSevenDays);
                    likesThirtyDayMap.put(groupKey, totalLikesThirtyDays);

                    commentsYesterDayMap.put(groupKey, totalCommentsYesterday);
                    commentsSevenDayMap.put(groupKey, totalCommentsSevenDays);
                    commentsThirtyDayMap.put(groupKey, totalCommentsThirtyDays);

                    playsYesterDayMap.put(groupKey, totalPlaysYesterday);
                    playsSevenDayMap.put(groupKey, totalPlaysSevenDays);
                    playsThirtyDayMap.put(groupKey, totalPlaysThirtyDays);

                    sharesYesterDayMap.put(groupKey, totalSharesYesterday);
                    sharesSevenDayMap.put(groupKey, totalSharesSevenDays);
                    sharesThirtyDayMap.put(groupKey, totalSharesThirtyDays);
                });


        // 订单数据处理
        // 全量抖音视频id
        List<String> douyinVideoIds = allClipDouyinContentList.stream().filter(p -> StringUtils.isNotBlank(p.getDouyinVideoId())).map(ClipDouyinContent::getDouyinVideoId).collect(Collectors.toList());
        // 全量抖音订单数据
        List<ConversionDouyinOrder> allConversionDouyinOrderList = conversionDouyinClueMapper.selectConversionDouyinOrderListByContentIds(douyinVideoIds);
        // 昨天抖音订单map
        Map<String, List<ConversionDouyinOrder>> yesterDayConversionDouyinOrderMap = new HashMap<>();
        // 昨天抖音券码map
        Map<String, List<ConversionDouyinCertificate>> yesterDayConversionDouyinCertificateMap = new HashMap<>();
        // 昨天抖音线索map
        Map<String, List<ConversionDouyinClue>> yesterDayConversionDouyinClueMap = new HashMap<>();
        // 七天抖音订单map
        Map<String, List<ConversionDouyinOrder>> sevenDayConversionDouyinOrderMap = new HashMap<>();
        // 七天抖音券码map
        Map<String, List<ConversionDouyinCertificate>> sevenDayConversionDouyinCertificateMap = new HashMap<>();
        // 七天抖音线索map
        Map<String, List<ConversionDouyinClue>> sevenDayConversionDouyinClueMap = new HashMap<>();
        // 三十天抖音订单map
        Map<String, List<ConversionDouyinOrder>> thirtyDayConversionDouyinOrderMap = new HashMap<>();
        // 三十天抖音券码map
        Map<String, List<ConversionDouyinCertificate>> thirtyDayConversionDouyinCertificateMap = new HashMap<>();
        // 三十天抖音线索map
        Map<String, List<ConversionDouyinClue>> thirtyDayConversionDouyinClueMap = new HashMap<>();
        // 全量抖音订单id
        List<String> douyinOrderIds = allConversionDouyinOrderList.stream().map(ConversionDouyinOrder::getDouyinOrderId).collect(Collectors.toList());
        if (CollectionUtils.isNotEmpty(douyinOrderIds)){
            //-------------------昨天----------------------
            // 全量抖音券码
            List<ConversionDouyinCertificate> allConversionDouyinCertificateList = conversionDouyinClueMapper.selectConversionDouyinCertificateListByDouyinOrderIds(douyinOrderIds);
            // 昨日抖音券码
            List<ConversionDouyinCertificate> yesterDayConversionDouyinCertificateList = allConversionDouyinCertificateList.stream()
                    .filter(p -> isSameDay(p.getVerifyTime(), yesterday)).collect(Collectors.toList());
            // 昨天抖音券码map
            yesterDayConversionDouyinCertificateMap = yesterDayConversionDouyinCertificateList.stream()
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
            yesterDayConversionDouyinCertificateMap.remove(null);

            // 过滤出昨天的抖音订单信息
            List<ConversionDouyinOrder> yesterDayConversionDouyinOrderList = allConversionDouyinOrderList.stream()
                    .filter(p -> isSameDayByTimestamp(p.getPayTime(), yesterday)).collect(Collectors.toList());
            // 昨天抖音订单map
            yesterDayConversionDouyinOrderMap = yesterDayConversionDouyinOrderList.stream().filter(p -> StringUtils.isNotBlank(p.getDouyinCode()))
                    .collect(Collectors.groupingBy(p -> p.getProjectId() + "_" + p.getOpenId()));

            // 全量线索数据
            List<ConversionDouyinClue> allConversionDouyinClueList = conversionDouyinClueMapper.selectConversionDouyinClueListByVideoIds(douyinVideoIds);
            // 昨天线索数据
            List<ConversionDouyinClue> yesterDayConversionDouyinClueList = allConversionDouyinClueList.stream().filter(p -> stringToDate(p.getCreateTimeDetail(), "yyyy-MM-dd HH:mm:ss") != null)
                    .filter(p -> isSameDay(stringToDate(p.getCreateTimeDetail(), "yyyy-MM-dd HH:mm:ss"), yesterday)).collect(Collectors.toList());
            // 昨天抖音线索map
            yesterDayConversionDouyinClueMap = yesterDayConversionDouyinClueList.stream()
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
            yesterDayConversionDouyinClueMap.remove(null);

            //-------------------七天----------------------

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

            //-------------------三十天----------------------
            // 三十日抖音券码
            List<ConversionDouyinCertificate> thirtyDayConversionDouyinCertificateList = allConversionDouyinCertificateList.stream()
                    .filter(p -> p.getVerifyTime().after(thirtyDaysAgo) && isBeforeToday(p.getVerifyTime())).collect(Collectors.toList());
            // 三十天抖音券码map
            thirtyDayConversionDouyinCertificateMap = thirtyDayConversionDouyinCertificateList.stream()
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
            thirtyDayConversionDouyinCertificateMap.remove(null);

            // 过滤出三十天的抖音订单信息
            List<ConversionDouyinOrder> thirtyDayConversionDouyinOrderList = allConversionDouyinOrderList.stream()
                    .filter(p -> convertTimestampToDate(p.getPayTime()).after(thirtyDaysAgo) && isBeforeToday(convertTimestampToDate(p.getPayTime()))).collect(Collectors.toList());
            // 三十天抖音订单map
            thirtyDayConversionDouyinOrderMap = thirtyDayConversionDouyinOrderList.stream().filter(p -> StringUtils.isNotBlank(p.getDouyinCode()))
                    .collect(Collectors.groupingBy(p -> p.getProjectId() + "_" + p.getOpenId()));

            // 三十天线索数据
            List<ConversionDouyinClue> thirtyDayConversionDouyinClueList = allConversionDouyinClueList.stream().filter(p -> stringToDate(p.getCreateTimeDetail(), "yyyy-MM-dd HH:mm:ss") != null)
                    .filter(p -> stringToDate(p.getCreateTimeDetail(), "yyyy-MM-dd HH:mm:ss").after(thirtyDaysAgo) && isBeforeToday(stringToDate(p.getCreateTimeDetail(), "yyyy-MM-dd HH:mm:ss"))).collect(Collectors.toList());
            // 三十天抖音线索map
            thirtyDayConversionDouyinClueMap = thirtyDayConversionDouyinClueList.stream()
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
            thirtyDayConversionDouyinClueMap.remove(null);
        }

        // 查询所有 项目下运营人绑定的已授权 的抖音账号
        List<WechatMiniProgramDouyinAccountVO> wechatMiniProgramDouyinAccountVOS = wechatMiniProgramDouyinAccountMapper.selectAuthorizationProjectDouyinAccount();
        Map<String, List<WechatMiniProgramDouyinAccountVO>> groupDouyinAccountMap = wechatMiniProgramDouyinAccountVOS.stream()
                .collect(Collectors.groupingBy(content ->
//                        content.getAccountOperatorId() + "_" +
                                content.getProjectId() + "_" +
                                        content.getDouyinOpenId()
                ));

        //全部抖音账号数据分析表（微信小程序业务库）
        WechatMiniProgramDouyinAccountDataAnalysis temp = new WechatMiniProgramDouyinAccountDataAnalysis();
        List<WechatMiniProgramDouyinAccountDataAnalysis> update = wechatMiniProgramDouyinAccountDataAnalysisMapper.selectWechatMiniProgramDouyinAccountDataAnalysisList(temp);

        Map<String, WechatMiniProgramDouyinAccountDataAnalysis> wechatMiniProgramDouyinAccountDataAnalysisMap = update.stream().filter(p -> StringUtils.isNotBlank(p.getDouyinCode()))
                .collect(Collectors.toMap(douyinAccountDataAnalysis ->
//                        content.getAccountOperatorId() + "_" +
                        douyinAccountDataAnalysis.getProjectId() + "_" +
                                douyinAccountDataAnalysis.getDouyinOpenId(), item -> item));

        for (Map.Entry<String, WechatMiniProgramDouyinAccountDataAnalysis> stringListEntry : wechatMiniProgramDouyinAccountDataAnalysisMap.entrySet()) {
            String key = stringListEntry.getKey();
            //未授权的不再更新
            if (groupDouyinAccountMap.get(key) == null){
                continue;
            }
            //------------------------抖音账号数据-----------------------------
            // 总粉丝数
            Long totalFans = totalFansYesterDayMap.getOrDefault(key, 0L);
            //发布内容数(抖音账号投稿总数)
            Long releaseContentQuantity = 0L;
            //最新内容发布时间（集森内容）
            Date latestReleaseTime = null;
            //未发布内容天数（集森内容）
            Long notReleaseContentDays = 0L;
            //最新的集森发布内容时间
            List<ClipDouyinContent> clipDouyinContents = allGroupedContentsMap.get(key);
            if(CollectionUtils.isNotEmpty(clipDouyinContents)){
                releaseContentQuantity = Long.valueOf(clipDouyinContents.size());
                Optional<ClipDouyinContent> findFirst = clipDouyinContents.stream().sorted(Comparator.comparing(ClipDouyinContent::getDouyinReleaseTime).reversed()).findFirst();
                if (findFirst.isPresent()){
                    latestReleaseTime = findFirst.get().getDouyinReleaseTime();
                    // 获取当前日期的 Date 对象
                    Date currentDate = new Date();
                    // 计算两个日期之间的天数差
                    long diffInMillies = Math.abs(currentDate.getTime() - latestReleaseTime.getTime());
                    notReleaseContentDays = diffInMillies / (1000 * 60 * 60 * 24);
                }
            }
            // 账号发布频率（7天）
            BigDecimal publishContentFrequency = BigDecimal.valueOf(releaseContentQuantity / 7);

            //------------------------抖音内容数据-----------------------------
            //投稿数（昨日）
            Long contributionByDay = 0L;
            List<ClipDouyinContent> yesterDayClipDouyinContents = groupedYesterDayContentsMap.get(key);
            if(CollectionUtils.isNotEmpty(yesterDayClipDouyinContents)){
                contributionByDay = Long.valueOf(yesterDayClipDouyinContents.size());
            }
            //投稿数（七日）
            Long contributionSevenDay = 0L;
            List<ClipDouyinContent> sevenDayclipDouyinContents = groupedSevenDayContentsMap.get(key);
            if(CollectionUtils.isNotEmpty(sevenDayclipDouyinContents)){
                contributionSevenDay = Long.valueOf(sevenDayclipDouyinContents.size());
            }
            //投稿数（30日）
            Long contributionByThirty = 0L;
            List<ClipDouyinContent> thirtyDayClipDouyinContents = grouped30DayContentsMap.get(key);
            if(CollectionUtils.isNotEmpty(thirtyDayClipDouyinContents)){
                contributionByThirty = Long.valueOf(thirtyDayClipDouyinContents.size());
            }

            // 昨日
            Long yesterdayWorksLike = likesYesterDayMap.getOrDefault(key, 0L);
            Long yesterdayWorksComment = commentsYesterDayMap.getOrDefault(key, 0L);
            Long yesterdayWorksShare = sharesYesterDayMap.getOrDefault(key, 0L);
            Long yesterdayPlayCount = playsYesterDayMap.getOrDefault(key, 0L);
            BigDecimal yesterdayWeightedInteractionRate = calculateWeightedInteractionRate(yesterdayWorksLike, yesterdayWorksComment, yesterdayWorksShare, yesterdayPlayCount);
            
            //七日
            Long sevenDayWorksLike = likesSevenDayMap.getOrDefault(key, 0L);
            Long sevenDayWorksComment = commentsSevenDayMap.getOrDefault(key, 0L);
            Long sevenDayWorksShare = sharesSevenDayMap.getOrDefault(key, 0L);
            Long sevenDayplayCount = playsSevenDayMap.getOrDefault(key, 0L);
            BigDecimal sevenDayWeightedInteractionRate = calculateWeightedInteractionRate(sevenDayWorksLike, sevenDayWorksComment, sevenDayWorksShare, sevenDayplayCount);

            //三十日
            Long thirtyDayWorksLike = likesThirtyDayMap.getOrDefault(key, 0L);
            Long thirtyDayWorksComment = commentsThirtyDayMap.getOrDefault(key, 0L);
            Long thirtyDayWorksShare = sharesThirtyDayMap.getOrDefault(key, 0L);
            Long thirtyDayPlayCount = playsThirtyDayMap.getOrDefault(key, 0L);
            BigDecimal thirtyDayWeightedInteractionRate = calculateWeightedInteractionRate(thirtyDayWorksLike, thirtyDayWorksComment, thirtyDayWorksShare, thirtyDayPlayCount);

            BigDecimal dailyAverageFansByDay = BigDecimal.valueOf(totalFansYesterDayMap.getOrDefault(key, 0L));
            Long netGrowthFansByDay = netGrowthFansMap.getOrDefault(key, 0L);

            BigDecimal dailyAverageFansBySeven = dailyAverageFansSevenDayMap.getOrDefault(key, BigDecimal.ZERO);
            Long netGrowthFansBySeven = netGrowthFansSevenDayMap.getOrDefault(key, 0L);

            BigDecimal dailyAverageFansByThirty = dailyAverageFansThirtyDayMap.getOrDefault(key, BigDecimal.ZERO);
            Long netGrowthFansByThirty = netGrowthFansThirtyDayMap.getOrDefault(key, 0L);

            //------------------------抖音订单数据-----------------------------

            //新增售卖券数 昨日
            Long saledCertificateQuantityByDay = 0L;
            //新增售卖GMV 昨日
            BigDecimal saledGmvByDay = BigDecimal.ZERO;
            //新增核销券数 昨日
            Long fulfilCertificateQuantityByDay = 0L;
            //新增核销GMV 昨日
            BigDecimal fulfilGmvByDay = BigDecimal.ZERO;
            //线索数（昨日）
            Long clueQuantityByDay = 0L;

            // 昨日售卖券、售卖gmv
            List<ConversionDouyinOrder> yesterDayDouyinOrderList = yesterDayConversionDouyinOrderMap.get(key);
            if (CollectionUtils.isNotEmpty(yesterDayDouyinOrderList)) {
                saledCertificateQuantityByDay = yesterDayDouyinOrderList.stream()
                        .map(ConversionDouyinOrder::getCount)
                        .mapToLong(count -> count != null ? count : 0) // 将null转换为0
                        .sum();
                saledGmvByDay = new BigDecimal(yesterDayDouyinOrderList.stream()
                        .map(ConversionDouyinOrder::getReceiptAmount)
                        .mapToLong(count -> count != null ? count : 0) // 将null转换为0
                        .sum()).divide(BigDecimal.valueOf(100));// 分转换为元
            }
            // 昨日核销券、核销gmv
            List<ConversionDouyinCertificate> yesterdayConversionDouyinCertificateList = yesterDayConversionDouyinCertificateMap.get(key);
            if (CollectionUtils.isNotEmpty(yesterdayConversionDouyinCertificateList)) {
                fulfilCertificateQuantityByDay = (Long.valueOf(yesterdayConversionDouyinCertificateList.size()));
                // 求和昨日核销券的实收金额
                long sumReceiptAmount = yesterdayConversionDouyinCertificateList.stream()
                        .map(ConversionDouyinCertificate::getReceiptAmount) // 提取 ReceiptAmount
                        .filter(Objects::nonNull) // 过滤掉 null 值
                        .mapToLong(Long::longValue) // 转换为 long 值
                        .sum();
                // 核销 GMV (将金额转换为单位: 元)
                fulfilGmvByDay = BigDecimal.valueOf(sumReceiptAmount)
                        .divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP); // 保留两位小数，四舍五入
            }
            List<ConversionDouyinClue> conversionDouyinClues = yesterDayConversionDouyinClueMap.get(key);
            if(CollectionUtils.isNotEmpty(conversionDouyinClues)){
                clueQuantityByDay = Long.valueOf(conversionDouyinClues.size());
            }

            //新增售卖券数 七日
            Long saledCertificateQuantityBySeven = 0L;
            //新增售卖GMV 七日
            BigDecimal saledGmvBySeven = BigDecimal.ZERO;
            //新增核销券数 七日
            Long fulfilCertificateQuantityBySeven = 0L;
            //新增核销GMV 七日
            BigDecimal fulfilGmvBySeven  = BigDecimal.ZERO;
            //线索数（七日）
            Long clueQuantityBySeven = 0L;
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
            List<ConversionDouyinClue> conversionDouyinCluesBySeven = sevenDayConversionDouyinClueMap.get(key);
            if(CollectionUtils.isNotEmpty(conversionDouyinClues)){
                clueQuantityByDay = Long.valueOf(conversionDouyinClues.size());
            }

            //新增售卖券数 三十日
            Long saledCertificateQuantityByThirty = 0L;
            //新增售卖GMV 三十日
            BigDecimal saledGmvByThirty = BigDecimal.ZERO;
            //新增核销券数 三十日
            Long fulfilCertificateQuantityByThirty = 0L;
            //新增核销GMV 三十日
            BigDecimal fulfilGmvByThirty = BigDecimal.ZERO;
            //线索数（30日）
            Long clueQuantityByThirty = 0L;
            // 三十日售卖券、售卖gmv
            List<ConversionDouyinOrder> thirtyDayDouyinOrderList = thirtyDayConversionDouyinOrderMap.get(key);
            if (CollectionUtils.isNotEmpty(thirtyDayDouyinOrderList)) {
                saledCertificateQuantityByDay = thirtyDayDouyinOrderList.stream()
                        .map(ConversionDouyinOrder::getCount)
                        .mapToLong(count -> count != null ? count : 0) // 将null转换为0
                        .sum();
                saledGmvByDay = new BigDecimal(thirtyDayDouyinOrderList.stream()
                        .map(ConversionDouyinOrder::getReceiptAmount)
                        .mapToLong(count -> count != null ? count : 0) // 将null转换为0
                        .sum()).divide(BigDecimal.valueOf(100));// 分转换为元
            }
            // 三十日核销券、核销gmv
            List<ConversionDouyinCertificate> thirtyConversionDouyinCertificateList = thirtyDayConversionDouyinCertificateMap.get(key);
            if (CollectionUtils.isNotEmpty(thirtyConversionDouyinCertificateList)) {
                fulfilCertificateQuantityByDay = (Long.valueOf(thirtyConversionDouyinCertificateList.size()));
                // 求和三十日核销券的实收金额
                long sumReceiptAmount = thirtyConversionDouyinCertificateList.stream()
                        .map(ConversionDouyinCertificate::getReceiptAmount) // 提取 ReceiptAmount
                        .filter(Objects::nonNull) // 过滤掉 null 值
                        .mapToLong(Long::longValue) // 转换为 long 值
                        .sum();
                // 核销 GMV (将金额转换为单位: 元)
                fulfilGmvByDay = BigDecimal.valueOf(sumReceiptAmount)
                        .divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP); // 保留两位小数，四舍五入
            }
            List<ConversionDouyinClue> conversionDouyinCluesByThirty = thirtyDayConversionDouyinClueMap.get(key);
            if(CollectionUtils.isNotEmpty(conversionDouyinClues)){
                clueQuantityByDay = Long.valueOf(conversionDouyinClues.size());
            }

            WechatMiniProgramDouyinAccountDataAnalysis updateItem = stringListEntry.getValue();

            //总粉丝数 发布内容数 最新发布时间（账号最近一次发布内容的日期）集森内容）  未发布内容天数：3天 最近一次发布日期和当前时间的时长，当天为0，昨天为1，以此类推（集森内容）
            updateItem.setTotalFans(totalFans);
            updateItem.setReleaseContentQuantity(releaseContentQuantity);
            updateItem.setPublishContentFrequency(publishContentFrequency);
            updateItem.setLatestReleaseTime(latestReleaseTime);
            updateItem.setNotReleaseContentDays(notReleaseContentDays);

            updateItem.setContributionByDay(contributionByDay);
            updateItem.setPlayCountByDay(yesterdayPlayCount);
            updateItem.setWorksLikeByDay(yesterdayWorksLike);
            updateItem.setWorksShareByDay(yesterdayWorksShare);
            updateItem.setWorksCommentByDay(yesterdayWorksComment);
            updateItem.setWeightedInteractionRateByDay(yesterdayWeightedInteractionRate);
            updateItem.setDailyAverageFansByDay(dailyAverageFansByDay);
            updateItem.setNetGrowthFansByDay(netGrowthFansByDay);
//            updateItem.setHomepageAccessByDay();
            updateItem.setTotalFansByDay(totalFans);
            updateItem.setSaledCertificateQuantityByDay(saledCertificateQuantityByDay);
            updateItem.setSaledGmvByDay(saledGmvByDay);
            updateItem.setFulfilCertificateQuantityByDay(fulfilCertificateQuantityByDay);
            updateItem.setUlfilGmvByDay(fulfilGmvByDay);
            updateItem.setClueQuantityByDay(clueQuantityByDay);

            updateItem.setContributionBySeven(contributionSevenDay);
            updateItem.setPlayCountBySeven(sevenDayplayCount);
            updateItem.setWorksLikeBySeven(sevenDayWorksLike);
            updateItem.setWorksShareBySeven(sevenDayWorksShare);
            updateItem.setWorksCommentBySeven(sevenDayWorksComment);
            updateItem.setWeightedInteractionRateBySeven(sevenDayWeightedInteractionRate);
            updateItem.setDailyAverageFansBySeven(dailyAverageFansBySeven);
            updateItem.setNetGrowthFansBySeven(netGrowthFansBySeven);
//            updateItem.setHomepageAccessBySeven();
            updateItem.setTotalFansBySeven(totalFans);
            updateItem.setSaledCertificateQuantityBySeven(saledCertificateQuantityBySeven);
            updateItem.setSaledGmvBySeven(saledGmvBySeven);
            updateItem.setFulfilCertificateQuantityBySeven(fulfilCertificateQuantityBySeven);
            updateItem.setUlfilGmvBySeven(fulfilGmvBySeven);
            updateItem.setClueQuantityBySeven(clueQuantityBySeven);

            updateItem.setContributionByThirty(contributionByThirty);
            updateItem.setPlayCountByThirty(thirtyDayPlayCount);
            updateItem.setWorksLikeByThirty(thirtyDayWorksLike);
            updateItem.setWorksShareByThirty(thirtyDayWorksShare);
            updateItem.setWorksCommentByThirty(thirtyDayWorksComment);
            updateItem.setWeightedInteractionRateBThirty(thirtyDayWeightedInteractionRate);
            updateItem.setDailyAverageFansByThirty(dailyAverageFansByThirty);
            updateItem.setNetGrowthFansByThirty(netGrowthFansByThirty);
//            updateItem.setHomepageAccessByThirty();
            updateItem.setTotalFansByThirty(totalFans);
            updateItem.setSaledCertificateQuantityByThirty(saledCertificateQuantityByThirty);
            updateItem.setSaledGmvByThirty(saledGmvByThirty);
            updateItem.setFulfilCertificateQuantityByThirty(fulfilCertificateQuantityByThirty);
            updateItem.setUlfilGmvByThirty(fulfilGmvByThirty);
            updateItem.setClueQuantityByThirty(clueQuantityByThirty);

            updateItem.setUpdateBy("job");
            updateItem.setUpdateTime(DateUtils.getNowDate());
        }

        if (CollectionUtils.isNotEmpty(update)) {
            wechatMiniProgramDouyinAccountDataAnalysisMapper.batchUpdate(update);
        }
    }


    // 获取昨天的日期（去除时间部分）
    private static Date getYesterdayDate() {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -1); // 设置为昨天
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

    // 判断时间戳对应的日期是否为昨天
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


    /**
     * 计算加权互动率
     * 计算加权互动率 = (点赞数 * 0.2 + 评论数 * 0.5 + 分享数 * 0.3) / 播放量
     * @param worksLike 点赞数
     * @param worksComment 评论数
     * @param worksShare 分享数
     * @param playCount 播放量
     * @return 加权互动率（BigDecimal类型）
     */
    public static BigDecimal calculateWeightedInteractionRate(Long worksLike, Long worksComment, Long worksShare, Long playCount) {
        // 确保播放量不为零，避免除零错误
        if (playCount > 0) {
            double weightedInteractionRate = (worksLike * 0.2 + worksComment * 0.5 + worksShare * 0.3) / (double) playCount;
            return BigDecimal.valueOf(weightedInteractionRate);
        } else {
            // 如果播放量为零，返回零或其他默认值
            return BigDecimal.ZERO;
        }
    }

}

```