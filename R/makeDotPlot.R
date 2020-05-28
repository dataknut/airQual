#' \code{makeDotPlot} makes a geom_point() x/y plot using the viridis colour scheme to 
#' colour byVar.
#'
#' @param dt the data to plot
#' @param xVar the variable to use for the x axis
#' @param xLab the x axis label
#' @param yVar the variable to use for the y axis
#' @param yLab the y axis label
#' @param byVar the variable to use to colour different points
#' @author Ben Anderson, \email{b.anderson@@soton.ac.uk} (original)
#' @export
#' @family plots
#'

makeDotPlot <- function(dt, xVar, xLab, yVar, yLab, byVar){
  p <- ggplot2::ggplot(dt, aes(x = get(xVar), 
                               y = get(yVar),
                               colour = get(byVar)
                               )
  ) +
    geom_point(size = 1, shape = 2) + #get(byVar) # varies
    scale_colour_viridis_d(name = eval(byVar)) +
    labs(x = eval(xLab),
         y = eval(yLab)) +  
    theme(legend.position="bottom") +
    guides(colour = guide_legend(nrow = 2)) # forces 2 rows to legend
  return(p)
}