UPDATE ylx_boot_dev.yl_message_center_template t SET t.sms_template_content = '${doctorName}医生邀请您完成《${questionName}》，请及时打开元骁健康小程序填写，谢谢', t.send_type_param = '{
                                "smsParam": {
                                    "isAvailable": true,
                                    "smsChannel": "1",
                                    "smsType": "1",
                                    "templateId": "SMS_498295341"
                                },
                                "appInBoxParam": {
                                    "isAvailable": true,
                                    "appInBoxType": "1"
                                }
                            } ' WHERE t.template_code = 'pt_question_0000001';

UPDATE ylx_boot_dev.yl_message_center_template t SET t.sms_template_content = '您好，${doctorName}医生提醒${patientName}的${planContent}，请打开元骁健康小程序查看详情', t.send_type_param = '{
                                "smsParam": {
                                    "isAvailable": true,
                                    "smsChannel": "1",
                                    "smsType": "1",
                                    "templateId": "SMS_498105401"
                                },
                                "wxPublicChatParam": {
                                    "isAvailable": true,
                                    "wxType": "1",
                                    "templateId": "2C42iXyq--UchmGrK3vrPoPrDw9QF0DmLu6jNGwHfGs"
                                },
                                "appInBoxParam": {
                                    "isAvailable": true,
                                    "appInBoxType": "2"
                                }
                            } ' WHERE t.template_code = 'pt_plan_0000001';

UPDATE ylx_boot_dev.yl_message_center_template t SET t.sms_template_content = '您好，您申请的${doctorName}医生的${reserveService}将于${reserveTime}开始，请打开“元骁健康”小程序，等待医生发起邀请', t.voice_template_content = '您好，元贝贝互联网医院提醒您，您预约的${doctorName}医生的视频问诊即将开始，您可以打开元骁健康小程序等待医生发起邀请。感谢您的接听，祝您早日康复', t.send_type_param = '{
                                "smsParam": {
                                    "isAvailable": true,
                                    "smsChannel": "1",
                                    "smsType": "1",
                                    "templateId": "SMS_498325400"
                                },
                                "wxPublicChatParam": {
                                    "isAvailable": true,
                                    "wxType": "2",
                                    "templateId": "VXhxZzYV4ayRV8qCR2d2Jv_hz0J98j1sYxL7JuEy52w"
                                },
                                "appInBoxParam": {
                                    "isAvailable": true,
                                    "appInBoxType": "3"
                                },
                                "voiceCallParam": {
                                    "isAvailable": true,
                                    "templateId": "TTS_326290133"
                                }
                            }', t.template_param = '[
                  {
                      "codeDesc": "就诊人",
                      "code": "patientName",
                      "wxCode": "thing2"
                  },
                  {
                      "codeDesc": "预约时间",
                      "code": "reserveTime",
                      "smsCode": "reserveTime",
                      "wxCode": "time3"
                  },
                  {
                      "codeDesc": "医生姓名",
                      "code": "doctorName",
                      "smsCode": "doctorName",
                      "voiceCode": "doctorName",
                      "wxCode": "thing4"
                  },
                  {
                      "codeDesc": "预约服务",
                      "code": "reserveService",
                      "smsCode": "reserveService",
                      "wxCode": "thing5"
                  },
                  {
                      "codeDesc": "备注",
                      "wxCode": "thing6"
                  }
              ]' WHERE t.template_code = 'pt_inquiry_0000003';

UPDATE ylx_boot_dev.yl_message_center_template t SET t.voice_template_content = '您好，元贝贝互联网医院提醒您，您预约的${doctorName}医生的视频问诊已开始，医生正在给您发起视频通话请求，请尽快打开元骁健康小程序进入视频通话。感谢您的接听，祝您早日康复', t.send_type_param = '{
                                "voiceCallParam": {
                                    "isAvailable": true,
                                    "templateId": "TTS_326290134"
                                }
                            }' WHERE t.template_code = 'pt_inquiry_0000008';

UPDATE ylx_boot_dev.yl_message_center_template t SET t.sms_template_content = '您好，${patientName}的${packageNameAndType}将于${days}天后过期，您可以打开“元骁健康”小程序，及时关注权益使用情况。如有疑问，可咨询相关工作人员', t.send_type_param = '{
                  "smsParam": {
                      "isAvailable": true,
                      "smsChannel": "1",
                      "smsType": "1",
                      "templateId": "SMS_498265382"
                  },
                  "appInBoxParam": {
                      "isAvailable": true,
                      "appInBoxType": "3"
                  }
              }' WHERE t.template_code = 'pt_member_0000001';

UPDATE ylx_boot_dev.yl_message_center_template t
SET t.template_param  = '[
                  {
                      "codeDesc": "就诊人"
                  },
                  {
                      "codeDesc": "医生姓名",
                      "smsCode": "doctorName"
                  },
                  {
                      "codeDesc": "问诊类型",
                      "smsCode": "inquiryType"
                  },
                  {
                      "codeDesc": "分配时间",
                      "smsCode": "allocateTime"
                  },
              ]',
    t.sms_template_content = '您好，您申请的${doctorName}医生的${inquiryType}问诊，医生已将问诊开始时间分配在${allocateTime}，请及时打开“元骁健康”小程序进行确认',
    t.send_type_param   = '{
                                "smsParam": {
                                    "isAvailable": true,
                                    "smsChannel": "1",
                                    "smsType": "1",
                                    "templateId": "SMS_498190396"
                                }
                            }'
WHERE t.template_code = 'pt_inquiry_0000009';

UPDATE ylx_boot_dev.yl_message_center_template t SET t.voice_template_content = '您好，您预约的电话通话已开始，对方正在给您发起语音通话请求，请尽快打开元骁健康小程序进入语音通话。感谢您的接听，祝您早日康复', t.send_type_param = '{
                  "voiceCallParam": {
                      "isAvailable": true,
                      "templateId": "TTS_326205116"
                  }
              }' WHERE t.template_code = 'pt_inquiry_00000011';


UPDATE ylx_boot_dev.yl_message_center_template t SET t.sms_template_content = '已通知${patientName}患者${planContent}，打开元骁健康医生端APP查看详情', t.send_type_param = '{
                  "appPushParam": {
                      "isAvailable": true
                  },
                  "appInBoxParam": {
                      "isAvailable": true,
                      "appInBoxType": "2"
                  },
                  "smsParam": {
                      "isAvailable": true,
                      "smsChannel": "1",
                      "smsType": "1",
                      "templateId": "SMS_498175358"
                  }
              }' WHERE t.template_code = 'dc_plan_0000001';

UPDATE ylx_boot_dev.yl_message_center_template t SET t.sms_template_content = '医生您好，${patientName}患者续费了您的${packageNameAndSpu}', t.send_type_param = '{
                  "appInBoxParam": {
                      "isAvailable": true,
                      "appInBoxType": "3"
                  },
                  "smsParam": {
                      "isAvailable": true,
                      "smsChannel": "1",
                      "smsType": "1",
                      "templateId": "SMS_498200382"
                  }
              }' WHERE t.template_code = 'dc_member_0000003';

UPDATE ylx_boot_dev.yl_message_center_template t SET t.sms_template_content = '医生您好，${patientName}患者申请了您的${inquiryType}问诊，请尽快接诊', t.send_type_param = '{
                  "appPushParam": {
                      "isAvailable": true
                  },
                  "appInBoxParam": {
                      "isAvailable": true,
                      "appInBoxType": "3"
                  },
                  "smsParam": {
                      "isAvailable": true,
                      "smsChannel": "1",
                      "smsType": "1",
                      "templateId": "SMS_498220376"
                  }
              }' WHERE t.template_code = 'dc_inquiry_0000001';

UPDATE ylx_boot_dev.yl_message_center_template t SET t.sms_template_content = '医生您好，${patientName}患者与您预约的${inquiryTime}的${inquiryType}问诊将在${minutes}分钟后开始，请您及时进入“元骁健康医生端”APP，发起与患者的通话', t.voice_template_content = '医生您好，元贝贝互联网医院提醒您，${patientName}患者与您预约的视频问诊即将开始，请按时打开元骁健康医生端APP，进入问诊页面发起视频通话。感谢您的接听', t.send_type_param = '{
                                "appInBoxParam": {
                                    "isAvailable": true,
                                    "appInBoxType": "3"
                                },
                                "appPushParam": {
                                    "isAvailable": true
                                },
                                "smsParam": {
                                    "isAvailable": true,
                                    "smsChannel": "1",
                                    "smsType": "1",
                                    "templateId": "SMS_498325340"
                                },
                                "voiceCallParam": {
                                    "isAvailable": true,
                                    "templateId": "TTS_326270146"
                                }
                            }' WHERE t.template_code = 'dc_inquiry_0000004';

 UPDATE ylx_boot_dev.yl_message_center_template t SET t.voice_template_content = '医生您好，元贝贝互联网医院提醒您，${patientName}患者与您预约的视频问诊已与10分钟前开始，请尽快打开元骁健康医生端APP，进入问诊页面发起视频通话。感谢您的接听。', t.send_type_param = '{
                  "voiceCallParam": {
                      "isAvailable": true,
                      "templateId": "TTS_326280128"
                  }
              }' WHERE t.template_code = 'dc_inquiry_0000006';

UPDATE ylx_boot_dev.yl_message_center_template t SET t.sms_template_content = '医生您好，您有一项${patientName}患者的${itemType}待办事项需要处理，请及时打开元骁健康小程序处理', t.send_type_param = '{
                                "appPushParam": {
                                    "isAvailable": true
                                },
                                "appInBoxParam": {
                                    "isAvailable": true,
                                    "appInBoxType": "3"
                                },
                                "smsParam": {
                                    "isAvailable": true,
                                    "smsChannel": "1",
                                    "smsType": "1",
                                    "templateId": "SMS_498095406"
                                }
                            }' WHERE t.template_code = 'dc_todo_0000001';


UPDATE ylx_boot_dev.yl_message_center_template t SET t.sms_template_content = '医生您好,您给${patientName}患者分配的${allocateTime}的${inquiryType}问诊，患者请求重新分配，理由：${reason}，请及时打开元骁健康医生端APP处理', t.send_type_param = '{
                  "appInBoxParam": {
                      "isAvailable": true,
                      "appInBoxType": "3"
                  },
                  "appPushParam": {
                      "isAvailable": true
                  },
                  "smsParam": {
                      "isAvailable": true,
                      "smsChannel": "1",
                      "smsType": "1",
                      "templateId": "SMS_498215341"
                  }
              }' WHERE t.template_code = 'dc_inquiry_0000008';