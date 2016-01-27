library(rmarkdown)

clean <- function(outputs=TRUE)
{
  files <- dir()[grep(dir(), pattern="([.]md|[.]log|[.]tex)")]
  if (outputs)
    files <- c(files, dir()[grep(dir(), pattern="([.]pdf|[.]html)")])
  
  file.remove(files)
  invisible()
}

make_handouts <- function(files)
{
  for (file in files)
    rmarkdown::render(file)
  
  invisible()
}



files <- dir()[grep(dir(), pattern="[.]Rmd")]
clean()
make_handouts(files)
