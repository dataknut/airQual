#' \code{addWeekendsDateTime} adds rectangles around the weekends from March 2020 onwards
#' to plots where the x-axis is a dateTime.
#'
#' @param p the plot to add them to
#' @param yMin the smallest y value
#' @param yMax the largest y value
#' @author Ben Anderson, \email{b.anderson@@soton.ac.uk} (original)
#' @export
#' @family plots
#'

addWeekendsDateTime <- function(p, yMin, yMax){
  p <- p + annotate("rect", xmin = lubridate::as_datetime("2020-03-07 00:00:00"),
                    xmax = lubridate::as_datetime("2020-03-08 23:59:59"),
                    ymin = yMin, ymax = yMax,
                    alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("rect", xmin = lubridate::as_datetime("2020-03-14 00:00:00"),
             xmax = lubridate::as_datetime("2020-03-15 23:59:59"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("rect", xmin = lubridate::as_datetime("2020-03-21 00:00:00"),
             xmax = lubridate::as_datetime("2020-03-22 23:59:59"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("rect", xmin = lubridate::as_datetime("2020-03-28 00:00:00"),
             xmax = lubridate::as_datetime("2020-03-29 23:59:59"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("rect", xmin = lubridate::as_datetime("2020-04-04 00:00:00"),
             xmax = lubridate::as_datetime("2020-04-05 23:59:59"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("rect", xmin = lubridate::as_datetime("2020-04-10 00:00:00"),
             xmax = lubridate::as_datetime("2020-04-13 23:59:59"), # Easter
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("text", x = lubridate::as_datetime("2020-04-10 00:00:00"),
             y = yMax*myParams$labelPos,
             label = "Easter") + # Easter
    annotate("rect", xmin = lubridate::as_datetime("2020-04-18 00:00:00"),
             xmax = lubridate::as_datetime("2020-04-19 23:59:59"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("rect", xmin = lubridate::as_datetime("2020-04-25 00:00:00"),
             xmax = lubridate::as_datetime("2020-04-26 23:59:59"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("rect", xmin = lubridate::as_datetime("2020-05-02 00:00:00"),
             xmax = lubridate::as_datetime("2020-05-03 23:59:59"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("rect", xmin = lubridate::as_datetime("2020-05-08 00:00:00"),
             xmax = lubridate::as_datetime("2020-05-10 23:59:59"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("text", x = lubridate::as_datetime("2020-05-08 00:00:00"),
             y = yMax*myParams$labelPos,
             label = "VE Day") + # VE Day
    annotate("rect", xmin = lubridate::as_datetime("2020-05-16 00:00:00"),
             xmax = lubridate::as_datetime("2020-05-17 23:59:59"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill) +
    annotate("rect", xmin = lubridate::as_datetime("2020-05-23 00:00:00"),
             xmax = lubridate::as_datetime("2020-05-24 23:59:59"),
             ymin = yMin, ymax = yMax,
             alpha = myParams$weAlpha, fill = myParams$weFill)
  return(p)
}