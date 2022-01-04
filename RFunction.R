library('move')
library("ggplot2")

rFunction <-  function(data) {
  data$heading <- unlist(lapply(angle(data), function(x) c(as.vector(x), NA)))
    
    if(length(levels(trackId(data)))==1){
      dataDF <- data.frame(heading=data$heading,indv=namesIndiv(data))
      headingHist <- ggplot(dataDF, aes(heading))+geom_histogram(bins=100)+facet_grid(~indv)+ theme_bw()+ scale_x_continuous("Heading (deg)", breaks=c(-180,-90,0,90,180), labels=c("-180(S)","-90(W)","0(N)","90(E)","180(S)"), limits=c(-180,180))
      pdf(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"), "heading_histogram.pdf"))
      print(headingHist)
      dev.off()
    } else {
    pdf(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"), "heading_histogram.pdf"))
      headingHistAll <- ggplot(data@data, aes(heading))+geom_histogram(bins=100)+ ggtitle("All Individuals") +theme_bw()+ scale_x_continuous("Heading (deg)", breaks=c(-180,-90,0,90,180), labels=c("-180(S)","-90(W)","0(N)","90(E)","180(S)"), limits=c(-180,180))
    print(headingHistAll)
    lapply(split(data), function(x){
      dataDF <- data.frame(heading=x$heading, indv=namesIndiv(x)) 
      headingHist <- ggplot(dataDF, aes(heading))+geom_histogram(bins=100)+facet_grid(~indv)+ theme_bw()+ scale_x_continuous("Heading (deg)", breaks=c(-180,-90,0,90,180), labels=c("-180(S)","-90(W)","0(N)","90(E)","180(S)"), limits=c(-180,180))
      print(headingHist)
    })
    dev.off() 
    
  }
  return(data)
}
