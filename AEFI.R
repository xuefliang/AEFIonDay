wants <- c("stringr")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
library(stringr)
#设置工作目录
setwd("C:\\Users\\xuefliang\\Desktop\\")
aefi <- read.csv("C:\\Users\\xuefliang\\Desktop\\AEFI个案信息.csv",skip = 1,header = T,stringsAsFactors = F)

#重复个案
aefi$疫苗1.接种日期 <- as.Date(substr(aefi$疫苗1.接种日期,1,10))
subaefi <- subset(aefi,select = c("县.区.","乡.镇.","姓名","性别","出生日期","疫苗1.接种日期"))
write.csv(subaefi[duplicated(subaefi),],"个案重复.csv")

#县级未审核
subaefi <- subset(aefi,aefi$县级审核状态=="未审核",select = c("县.区.","乡.镇.","姓名","性别","出生日期","县级审核状态"))
write.csv(subaefi,"县级未审核.csv")

#市级未审核
subaefi <- subset(aefi,aefi$市级审核状态=="未审核" & aefi$初步分类=="待定",select = c("县.区.","乡.镇.","姓名","性别","出生日期","市级审核状态","初步分类"))
write.csv(subaefi,"市级未审核.csv")

#省级未审核
subaefi <- subset(aefi,aefi$省级审核状态=="未审核" & aefi$初步分类=="待定",select = c("县.区.","乡.镇.","姓名","性别","出生日期","省级审核状态","初步分类"))
write.csv(subaefi,"省级未审核.csv")

#初步临床诊断不能为空
subaefi <- subset(aefi,aefi$初步分类=="一般反应" & aefi$初步临床诊断=="",select = c("县.区.","乡.镇.","姓名","性别","出生日期","初步分类","初步临床诊断"))
write.csv(subaefi,"初步临床诊断不能为空.csv")

#最终临床诊断不能为空
subaefi <- subset(aefi,aefi$初步分类=="待定" & aefi$最终临床诊断=="",select = c("县.区.","乡.镇.","姓名","性别","出生日期","初步分类","最终临床诊断"))
write.csv(subaefi,"最终临床诊断不能为空.csv")

#无调查报告
subaefi <- subset(aefi,aefi$初步分类=="待定" & aefi$有无附件=="无",select = c("县.区.","乡.镇.","姓名","性别","出生日期","初步分类","有无附件"))
write.csv(subaefi,"无调查报告.csv")

#异常反应分级
subaefi <- subset(aefi,aefi$反应分类=="异常反应" & aefi$如为异常反应.机体损害程度=="",select = c("县.区.","乡.镇.","姓名","性别","出生日期","反应分类","如为异常反应.机体损害程度"))
write.csv(subaefi,"异常反应分级.csv")

#无发热红肿硬结其他症状的一般反应
subaefi <- subset(aefi,aefi$发热.腋温..范围=="无" & aefi$局部红肿.直径cm.范围=="无" &aefi$局部硬结.直径cm.范围=="无" & aefi$其它症状=="" & aefi$初步分类=="一般反应",select = c("县.区.","乡.镇.","姓名","性别","出生日期","反应分类","其它症状","发热.腋温..范围","局部红肿.直径cm.范围","局部硬结.直径cm.范围"))
write.csv(subaefi,"无发热红肿硬结其他症状的一般反应.csv")

#无发热红肿硬结仅有皮疹的一般反应
subaefi <- subset(aefi,aefi$发热.腋温..范围=="无" & aefi$局部红肿.直径cm.范围=="无" &aefi$局部硬结.直径cm.范围=="无" &str_detect(aefi$其它症状, "[皮疹]") & aefi$反应分类=="一般反应" & nchar(aefi$其它症状)==3,select = c("县.区.","乡.镇.","姓名","性别","出生日期","反应分类","其它症状","发热.腋温..范围","局部红肿.直径cm.范围","局部硬结.直径cm.范围"))
write.csv(subaefi,"无发热红肿硬结仅有皮疹的一般反应.csv")

#其它症状包含皮疹分类为一般反应者(可疑)
subaefi <- subset(aefi,str_detect(aefi$其它症状, "[皮疹]") & aefi$反应分类=="一般反应",select = c("县.区.","乡.镇.","姓名","性别","出生日期","反应分类","其它症状"))
write.csv(subaefi,"其它症状包含皮疹分类为一般反应者(可疑).csv")

#无发热红肿和硬结的一般反应(可疑)
subaefi <- subset(aefi,aefi$发热.腋温..范围=="无" & aefi$局部红肿.直径cm.范围=="无" &aefi$局部硬结.直径cm.范围=="无" & aefi$初步分类=="一般反应",select = c("县.区.","乡.镇.","姓名","性别","出生日期","反应分类","其它症状","发热.腋温..范围","局部红肿.直径cm.范围","局部硬结.直径cm.范围"))
write.csv(subaefi,"无发热红肿和硬结的一般反应(可疑).csv")


