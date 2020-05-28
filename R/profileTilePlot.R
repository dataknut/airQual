#' \code{profileTilePlot} makes a `geom_tile()` plot from the dt passed in.
#' 
#' It assumes `obsDate` exists and uses this for the x axis with `time` (in hms 
#' format) as the y. It colours the tile using the `dt$value` variable.
#'
#' @param dt the data.table to plot
#' @param yLab the y axis label
#' @author Ben Anderson, \email{b.anderson@@soton.ac.uk} (original)
#' @export
#' @family plots
#'
profileTilePlot <- function(dt, yLab){
  p <- ggplot2::ggplot(dt, aes(x = obsDate,
                               y = time, 
                               fill = value)) +
    geom_tile() +
    scale_fill_continuous(low = "green", high = "red") +
    labs(x= "Date",
         y = "Time",
         fill = yLab) +
    theme(legend.position="bottom") +
    facet_grid(site ~ .)
  
  p <- p +
    scale_x_date(date_breaks = "2 day", date_labels =  "%a %d %b")  +
    theme(axis.text.x=element_text(angle=90, hjust=1)) +
    theme(strip.text.y.right = element_text(angle = 0, size = 7))
  # final plot - adds annotations
  return(p)
}