#' \code{addWeekendsDate} adds rectangles around the weekends from March 2020 onwards
#' to plots where the x-axis is a date
#'
#' @param p the plot to add them to
#' @param yMin the smallest y value
#' @param yMax the largest y value
#' @author Ben Anderson, \email{b.anderson@@soton.ac.uk} (original)
#' @export
#' @family plots
#'

addWeekendsDate <- function(p, yMin, yMax){
  p <- p + annotate("rect", xmin = as.Date("2020-03-07"),
                    xmax = as.Date("2020-03-09"),
                    ymin = yMin, ymax = yMax,
                    alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("rect", xmin = as.Date("2020-03-14"),
             xmax = as.Date("2020-03-16"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("rect", xmin = as.Date("2020-03-21"),
             xmax = as.Date("2020-03-23"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("rect", xmin = as.Date("2020-03-28"),
             xmax = as.Date("2020-03-30"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("rect", xmin = as.Date("2020-04-04"),
             xmax = as.Date("2020-04-06"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("rect", xmin = as.Date("2020-04-10"),
             xmax = as.Date("2020-04-14"), # Easter
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("text", x = as.Date("2020-04-10"),
             y = yMax*myParams$labelPos,
             label = "Easter 2020") + # Easter
    annotate("rect", xmin = as.Date("2020-04-18"),
             xmax = as.Date("2020-04-20"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("rect", xmin = as.Date("2020-04-25"),
             xmax = as.Date("2020-04-27"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("rect", xmin = as.Date("2020-05-02"),
             xmax = as.Date("2020-05-04"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("rect", xmin = as.Date("2020-05-08"),
             xmax = as.Date("2020-05-11"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("text", x = as.Date("2020-05-08"),
             y = yMax*myParams$labelPos,
             label = "VE Day 2020") + # VE Day
    annotate("rect", xmin = as.Date("2020-05-16"),
             xmax = as.Date("2020-05-18"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("rect", xmin = as.Date("2020-05-23"),
             xmax = as.Date("2020-05-25"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("rect", xmin = as.Date("2020-05-30"),
             xmax = as.Date("2020-06-01"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill)
  return(p)
}