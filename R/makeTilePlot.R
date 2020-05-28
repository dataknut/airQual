#' \code{makeTilePlot} makes a geom_tile() plot using `fillVar` to 
#' colour the tiles.
#'
#' @param dt the data to plot
#' @param xVar the variable to use for the x axis
#' @param xLab the x axis label
#' @param yVar the variable to use for the y axis
#' @param yLab the y axis label
#' @param fillVar the variable to use to colour the tile fill
#' @author Ben Anderson, \email{b.anderson@@soton.ac.uk} (original)
#' @export
#' @family plots
#'
makeTilePlot <- function(dt, xVar, xLab, yVar, yLab, fillVar){
  p <- ggplot2::ggplot(dt, aes(x = get(xVar), 
                               y = get(yVar),
                               fill = get(fillVar)
  )
  ) +
    geom_tile() +
    scale_fill_continuous(low = "green", high = "red", name = "Value") +
    labs(x = xLab,
         y = yLab) +  
    theme(legend.position="bottom")
  return(p)
}