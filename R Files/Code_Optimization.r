##Data preparation

predict<-read_csv("Mon08_Predicts.csv")
predict<-predict[,-1]
#Decode geohash strings back into lat and lng
x<-gh_decode(predict$geohash)
predict<-cbind(predict,x[,2:3])
#Round the prediction to integers
predict<-predict%>%mutate(knn=round(knn_predict),arima=round(arima_predict),smooth=round(smooth_predict))%>%select(geohash,lat,lng,observed,knn,arima,smooth)
#Demand region
df_P<-predict%>%filter(arima>0)%>%arrange(desc(arima))%>%select(geohash,lat,lng,arima)
#Supply region
df_D<-predict%>%filter(arima<(-0))%>%mutate(arima=-arima)%>%arrange(desc(arima))%>%select(geohash,lat,lng,arima)


##Optimization
library(geosphere)
library(lpSolve)

#Compute the distance matrix and scale it by 1000 (convert m to km)
a=distm(cbind(df_P$lng,df_P$lat), cbind(df_D$lng,df_D$lat), fun = distHaversine)/1000

costs<-a #Cost Matrix
row.signs<-rep("<=",825) #Demand Constraints symbol
row.rhs<-df_P$arima # Demand Contraints 
col.signs<-rep("=",613) #Supply Constraints symbol
col.rhs<-df_D$arima #Supply Contraints 
res<-lp.transport(costs,"min",row.signs,row.rhs,col.signs,
                  col.rhs) # solve integer programming
final<-res$solution #optimized dispatch matrix


##SVD

SV<-svd(res$solution)
k=80
index_of_separability<-sum(SV$d[1:k]^2)/sum(SV$d^2)
new<-as.matrix(SV$u[,1:k])%*%diag(SV$d[1:k])%*%matrix(t(SV$v)[1:k,],nrow=k,ncol=613)
new<-round(new)

#Plot the main taxi trends on map
library(ggmap)
main_supply_region<-df_D[apply(new,2,sum)>0,]
main_demand_region<-df_P[apply(new,1,sum)>0,]
map <- get_map(center = c(lat = 40.74102, lon = -73.99431),zoom=13)
ggmap(map)+geom_point(data=main_supply_region,aes(x=lng,y=lat),color="light coral"
                      ,pch=15,cex=2)+geom_point(data=main_demand_region,aes(x=lng,y=lat),color="dodger blue",pch=15,cex=2)+ggtitle("Main Taxi Flow (k=80)")


#Find where there need more new taxis from taxi companies
supply<-apply(final,1,sum)
df_P['supply']<-supply
df_P['new']<-df_P$arima-df_P$supply
unmet_region<-df_P[df_P$new>0,]
fit <- kmeans(unmet_region[2:3], 3)#Cluster based on lat and lng
unmet_region['cluster']<-factor(fit$cluster)

NYCMap <- get_map("manhattan",zoom=12)
ggmap(NYCMap)+geom_point(data=unmet_region,aes(x=lng,y=lat),color="light coral",cex=0.5)+ggtitle("Extra taxi needed")
fit <- kmeans(unmet_region[2:3], 3)
unmet_region['cluster']<-factor(fit$cluster)

ggmap(NYCMap)+geom_point(data=unmet_region,aes(x=lng,y=lat,col=cluster1),cex=1,pch=15)+ggtitle("Extra taxi needed")
unmet_region['cluster1']<-factor(ifelse(unmet_region$lat>40.81,4,unmet_region$cluster))

unmet_region['cluster1']<-factor(ifelse(unmet_region$lng>-73.94,5,unmet_region$cluster1))

sum(unmet_region$new[unmet_region$cluster1==1])
sum(unmet_region$new[unmet_region$cluster1==2])
sum(unmet_region$new[unmet_region$cluster1==3])
sum(unmet_region$new[unmet_region$cluster1==4])
sum(unmet_region$new[unmet_region$cluster1==5])

#Drop the regions outside Manhattan
unmet_region<-unmet_region[unmet_region$cluster!=5,1:9]
#Plot
ggmap(NYCMap)+geom_point(data=unmet_region,aes(x=lng,y=lat,col=cluster),cex=1,pch=15)+ggtitle("Extra taxi needed")
