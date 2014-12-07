library("rvest")
library("magrittr")

mainDir <- "C:/Users/Markus/Pictures/gocomics/"
# 
subDir <- "thebarn"

dir.create(file.path(mainDir, subDir))
setwd(file.path(mainDir, subDir))

for(yy in 2011:2011){
  yys <- sprintf("%02d", yy)
  for(mm in 1:12){
    mms <- sprintf("%02d", mm)
    for(dd in 1:31){
      
      if(!((mm==2||mm==4||mm==6||mm==9||mm==11)&&(dd==31))) {
        
        dds <- sprintf("%02d", dd)
        
        pgurl <- paste("http://www.gocomics.com/", subDir, "/",
                       yys, "/", mms, "/", dds, sep = "")
        src <- html(pgurl) %>%
                 html_nodes("img.strip") %>%
                 .[[1]] %>%
                 html_attr("src")
  
        dest <- paste(subDir, yys, mms, dds, ".png", sep="")
        
        message(dest)
        
        download.file(src, destfile=dest, mode="wb")
        
      }
    }
  }
}