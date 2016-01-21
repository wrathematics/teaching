library(rmarkdown)

clean <- function(outputs=TRUE)
{
  files <- dir()[grep(dir(), pattern="([.]md|[.]log|[.]tex)")]
  if (outputs)
    files <- c(files, dir()[grep(dir(), pattern="([.]pdf|[.]html)")])
  
  file.remove(files)
  invisible()
}

make_slides <- function(files)
{
  for (file in files)
    rmarkdown::render(file)
  
  invisible()
}

make_handouts <- function(files)
{
  newoutput <- "output:
  pdf_document:
    toc: true
    toc_depth: 1
    includes:
      in_header: include/header.tex"
  
  for (file in files)
  {
    txt <- readLines(file)
    start <- which(grepl(txt, pattern="output:"))
    end <- which(grepl(txt, pattern="^---"))[2] - 1
    txt[start] <- newoutput
    txt <- paste0(txt[-((start+1):end)], collapse="\n")
    
    newfile <- sub(x=file, pattern="[.]", replacement="_handout.")
    writeLines(txt, newfile)
    
    rmarkdown::render(newfile)
    
    file.remove(newfile)
  }
  
  clean(outputs=FALSE)
}



files <- dir()[grep(dir(), pattern="[.]Rmd")]
clean()
make_slides(files)
make_handouts(files)
