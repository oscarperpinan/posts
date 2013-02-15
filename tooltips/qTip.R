panel.circles <- function(x, y, identifier,...){
  grid.circle(x, y, r=unit(5, 'mm'),
              default.units='native',
              ## Add the identifier
              gp=gpar(fill='gray',...))
}

library(gridSVG)
library(lattice)

x <- rnorm(10)
y <- rnorm(10)
id <- seq_along(x)
df <- data.frame(x, y, id)

xyplot(y ~ x, data=df, panel=panel.circles)

tooltips <- sapply(seq_len(nrow(df)), function(i){
  point <- signif(df[i, ], 2)
  ## Text to be included in the 'title' attribute
  info <- paste('x = ', point$x, 
                   '<br />y = ', point$y, 
                   '<br />ID = ', point$id,
                sep='')
  imageURL <- 'http://developer.r-project.org/Logo/Rlogo-5.png'
  imageInfo <- paste("<img src=", imageURL, " width='50' />", sep='')
  paste(imageInfo, info, sep='<br />')
})
grid.ls()
grid.garnish("GRID.circle", grep=TRUE, group=FALSE, title=tooltips)

## jQuery
grid.script(file='http://code.jquery.com/jquery-1.8.0.min.js')
grid.script(file='js/jquery.qtip.js')
## Simple JavaScript code to initialize the qTip plugin
grid.script(file='js/myQtip.js')
## Produce the SVG graphic: the results of grid.garnish,
## grid.hyperlink and grid.script are converted to SVG code
gridToSVG('tooltipLattice.svg')

htmlBegin <- '<!DOCTYPE html>
  <html>
  <head>
  <title>Tooltips with jQuery and gridSVG</title>
  <link rel="stylesheet" type="text/css" href="css/jquery.qtip.css" />
  </head>
  <body>'
  
htmlEnd <- '</body>
  </html>'
  
svgText <- paste(readLines('tooltipLattice.svg'), collapse='\n')
  
writeLines(paste(htmlBegin, svgText, htmlEnd, sep='\n'),
             'tooltipLattice.html')
