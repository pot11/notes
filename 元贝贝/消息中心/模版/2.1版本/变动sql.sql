UPDATE ylx_boot_dev.yl_message_center_template t SET t.sms_template_content = '${doctorName}医生邀请您完成《${questionName}》，请及时打开元骁健康小程序填写，谢谢，拒收请回复R', t.send_type_param = '{
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
              }' WHERE t.id = 62

UPDATE ylx_boot_dev.yl_message_center_template t SET t.sms_template_content = '${doctorName}医生提醒${patientName}的${planContent}，请打开元骁健康小程序查看详情', t.send_type_param = '{
                  "smsParam": {
                      "isAvailable": true,
                      "smsChannel": "1",
                      "smsType": "1",
                      "templateId": "SMS_498195343"
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
              }' WHERE t.id = 93

UPDATE ylx_boot_dev.yl_message_center_template t SET t.sms_template_content = '${patientName}有一个${doctorName}医生的${reserveService}将会在${reserveTime}开始，请及时打开元骁健康小程序，进入问诊诊室等待医生发起邀请', t.voice_template_content = '您好，您预约的${doctorName}医生的视频问诊将在${minutes}分钟后开始，您可以打开元骁健康小程序等待医生发起邀请。感谢您的接听，祝您早日康复', t.send_type_param = '{
                  "smsParam": {
                      "isAvailable": true,
                      "smsChannel": "1",
                      "smsType": "1",
                      "templateId": "SMS_498170325"
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
                      "templateId": "TTS_326285131"
                  }
              }' WHERE t.id = 65

UPDATE ylx_boot_dev.yl_message_center_template t SET t.voice_template_content = '您好，您预约的${doctorName}医生的视频问诊已开始，医生正在给您发起视频通话请求，请尽快打开元骁健康小程序进入视频通话。感谢您的接听，祝您早日康复', t.send_type_param = '{
                  "voiceCallParam": {
                      "isAvailable": true,
                      "templateId": "TTS_326205118"
                  }
              }' WHERE t.id = 104


UPDATE ylx_boot_dev.yl_message_center_template t SET t.sms_template_content = '${patientName}有一个${doctorName}医生的${inquiryType}问诊已经分配了问诊开始时间为${allocateTime}，请及时打开元骁健康小程序确认', t.send_type_param = '{
                  "smsParam": {
                      "isAvailable": true,
                      "smsChannel": "1",
                      "smsType": "1",
                      "templateId": "SMS_498285360"
                  }
              }' WHERE t.id = 112


UPDATE ylx_boot_dev.yl_message_center_template t SET t.voice_template_content = '您好，您预约的电话通话已开始，对方正在给您发起语音通话请求，请尽快打开元骁健康小程序进入语音通话。感谢您的接听，祝您早日康复', t.send_type_param = '{
                  "voiceCallParam": {
                      "isAvailable": true,
                      "templateId": "TTS_326205116"
                  }
              }' WHERE t.id = 116

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
              }' WHERE t.id = 94

UPDATE ylx_boot_dev.yl_message_center_template t SET t.sms_template_content = '${patientName}患者与您预约的${inquiryTime}的${inquiryType}问诊将在${minutes}分钟后开始，请及时打开元骁健康医生端APP进入诊室', t.voice_template_content = '医生您好，元贝贝互联网医院提醒您，${patientName}患者与您预约的视频问诊将在5分钟后开始，请按时打开元骁健康医生端APP，进入问诊页面发起视频通话。感谢您的接听。', t.send_type_param = '{
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
                      "templateId": "TTS_326125127"
                  }
              }' WHERE t.id = 85


 UPDATE ylx_boot_dev.yl_message_center_template t SET t.voice_template_content = '医生您好，元贝贝互联网医院提醒您，${patientName}患者与您预约的视频问诊已与10分钟前开始，请尽快打开元骁健康医生端APP，进入问诊页面发起视频通话。感谢您的接听。', t.send_type_param = '{
                  "voiceCallParam": {
                      "isAvailable": true,
                      "templateId": "TTS_326280128"
                  }
              }' WHERE t.id = 103


UPDATE ylx_boot_dev.yl_message_center_template t SET t.sms_template_content = '您有一项${patientName}患者的${itemType}待办事项需要处理，请及时打开元骁健康小程序处理
              跳转：app待办事项的医生回访页面', t.send_type_param = '{
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
                      "templateId": "SMS_498300303"
                  }
              }' WHERE t.id = 106


UPDATE ylx_boot_dev.yl_message_center_template t SET t.sms_template_content = '您给${patientName}患者分配的${allocateTime}的${inquiryType}问诊，患者请求重新分配，理由：${reason}，请及时打开元骁健康医生端APP处理', t.send_type_param = '{
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
              }' WHERE t.id = 114