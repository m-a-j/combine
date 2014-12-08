library("rvest")
library("magrittr")

mainDir <- "C:/Users/Markus/Pictures/gocomics"
# subDir: cartoon name == folder name
subDir <- "peanuts"

dir.create(file.path(mainDir, subDir))
setwd(file.path(mainDir, subDir))

for(yy in 1974:1974){
  yys <- sprintf("%02d", yy)
  for(mm in 1:12){
    mms <- sprintf("%02d", mm)
    for(dd in 1:31){
      
      if(!((mm==2||mm==4||mm==6||mm==9||mm==11)&&(dd==31))) {
        
        dds <- sprintf("%02d", dd)
        dest <- paste(subDir, yys, mms, dds, ".png", sep="")
        
        if(!file.exists(dest)) {
          
          pgurl <- paste("http://www.gocomics.com/", subDir, "/",
                         yys, "/", mms, "/", dds, sep = "")
          pghtml <- html(pgurl)
          nodes <- html_nodes(x = pghtml, "img.strip")
          # choose the last link (to highest resolution image)
          imgsrc <- html_attr(x = nodes[[length(nodes)]], "src")

          message(paste("Downloading ", dest, "...", sep=""))
          download.file(imgsrc, destfile=dest, mode="wb", quiet = T)
          #rstudio::viewer(url = dest)
        
        } else {
          message(paste(dest,"already exists"))
        }        
      }
    }
  }
}