library('move')
library("ggplot2")

rFunction <-  function(data) {
  data$directionOfMovement <- unlist(lapply(angle(data), function(x) c(as.vector(x), NA)))
    
    if(length(levels(trackId(data)))==1){
      dataDF <- data.frame(directionOfMovement=data$directionOfMovement,indv=namesIndiv(data))
      directionOfMovementHist <- ggplot(dataDF, aes(directionOfMovement))+geom_histogram(bins=100)+facet_grid(~indv)+ theme_bw()+ scale_x_continuous("Direction of movement (deg)", breaks=c(-180,-90,0,90,180), labels=c("-180(S)","-90(W)","0(N)","90(E)","180(S)"), limits=c(-180,180))
      pdf(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"), "directionOfMovement_histogram.pdf"))
      print(directionOfMovementHist)
      dev.off()
    } else {
    pdf(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"), "directionOfMovement_histogram.pdf"))
      directionOfMovementHistAll <- ggplot(data@data, aes(directionOfMovement))+geom_histogram(bins=100)+ ggtitle("All Individuals") +theme_bw()+ scale_x_continuous("Direction of movement (deg)", breaks=c(-180,-90,0,90,180), labels=c("-180(S)","-90(W)","0(N)","90(E)","180(S)"), limits=c(-180,180))
    print(directionOfMovementHistAll)
    lapply(split(data), function(x){
      dataDF <- data.frame(directionOfMovement=x$directionOfMovement, indv=namesIndiv(x)) 
      directionOfMovementHist <- ggplot(dataDF, aes(directionOfMovement))+geom_histogram(bins=100)+facet_grid(~indv)+ theme_bw()+ scale_x_continuous("Direction of movement (deg)", breaks=c(-180,-90,0,90,180), labels=c("-180(S)","-90(W)","0(N)","90(E)","180(S)"), limits=c(-180,180))
      print(directionOfMovementHist)
    })
    dev.off() 
    
  }
  return(data)
}
