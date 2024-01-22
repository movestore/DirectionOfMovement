library('move2')
library("ggplot2")
library("sf")
library("units")
library("lwgeom")

## ToDo: add windrose plot as optional

rFunction <-  function(data, setunits){
  
  if(!st_crs(data)[[1]]=="EPSG:4326"){
    dataLL <- st_transform(data,crs="EPSG:4326")
  }
  if(st_crs(data)[[1]]=="EPSG:4326"){
    dataLL <- data
  }
  
  dataLL$directionOfMovement <- mt_azimuth(dataLL, units=setunits)
  if(setunits=="rad"){
    setbreaks <- c(-pi,-(pi/2),0,(pi/2),pi)
    setlim <- c(-pi,pi)
  }
  if(setunits=="degrees"){
    setbreaks <- c(-180,-(180/2),0,(180/2),180)
    setlim <- c(-180,180)
  }
    
    if(length(levels(as.factor(mt_track_id(dataLL))))==1){
      dataDF <- data.frame(directionOfMovement=drop_units(dataLL$directionOfMovement),indv=unique(mt_track_id(dataLL)))
      directionOfMovementHist <- ggplot(dataDF, aes(directionOfMovement))+geom_histogram(bins=100)+facet_grid(~indv)+ theme_bw()+ scale_x_continuous("Direction of movement (rad)", breaks=setbreaks, labels=c("-180(S)","-90(W)","0(N)","90(E)","180(S)"), limits=setlim)
      pdf(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"), "directionOfMovement_histogram.pdf"))
      print(directionOfMovementHist)
      dev.off()
    }else {
    pdf(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"), "directionOfMovement_histogram.pdf"))
      directionOfMovementHistAll <- ggplot(dataLL, aes(drop_units(directionOfMovement)))+
        geom_histogram(bins=100)+ ggtitle("All Individuals") +theme_bw()+ 
        scale_x_continuous("Direction of movement (rad)", breaks=setbreaks, labels=c("-180(S)","-90(W)","0(N)","90(E)","180(S)"), limits=setlim)
    print(directionOfMovementHistAll)
    lapply(split(dataLL, mt_track_id(dataLL)), function(x){
      dataDF <- data.frame(directionOfMovement=drop_units(x$directionOfMovement), indv=unique(mt_track_id(x))) 
      directionOfMovementHist <- ggplot(dataDF, aes(directionOfMovement))+geom_histogram(bins=100)+facet_grid(~indv)+ theme_bw()+ scale_x_continuous("Direction of movement (rad)", breaks=setbreaks, labels=c("-180(S)","-90(W)","0(N)","90(E)","180(S)"), limits=setlim)
      print(directionOfMovementHist)
    })
    dev.off() 
    }
  data$directionOfMovement <- dataLL$directionOfMovement
  return(data)
}
