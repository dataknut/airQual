#' \code{compareYearsPlot} makes a geom_line() plot using `colVar` to 
#' colour the lines. It assumes the x axis is a date.
#'
#' @param dt the data to plot
#' @param xVar the variable to use for the x axis
#' @param yVar the variable to use for the y axis
#' @param colVar the variable to use to colour the tile fill
#' @author Ben Anderson, \email{b.anderson@@soton.ac.uk} (original)
#' @export
#' @family plots
#'
compareYearsPlot <- function(dt, xVar, yVar, colVar){
  p <- ggplot2::ggplot(dt, aes(x = get(xVar), y = get(yVar), 
                               colour = as.factor(get(colVar)))) +
    geom_line() +
    scale_x_date(date_breaks = "7 day", date_labels =  "%a %d %b")  +
    theme(axis.text.x=element_text(angle=90, hjust=1)) +
    theme(legend.position="bottom") +
    scale_colour_discrete(name = "Period")
  return(p)
}