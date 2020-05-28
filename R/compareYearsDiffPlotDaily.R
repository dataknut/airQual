#' \code{compareYearsDiffPlotDaily} makes a geom_step() plot from the dt passed in by
#' aggregating dt to dates.
#' 
#' It assumes `compareYear` exists and has the values "2017-2019" and "2020". It compares the `value`
#' variable (doesn't care what it is) and prints min/max difference for info. 
#' Should use scales::percent() but doesn't.
#'
#' @param dt the data to plot
#' @author Ben Anderson, \email{b.anderson@@soton.ac.uk} (original)
#' @export
#' @family plots
#'
compareYearsDiffPlotDaily <- function(dt){
  baseDT <- dt[compareYear == "2017-2019", .(baseMean = mean(value),
                                             baseMedian = median(value)), 
               keyby = .(fixedDate, fixedDoW, compareYear)]
  testDT <- dt[compareYear == "2020", .(testMean = mean(value),
                                        testMedian = median(value)), 
               keyby = .(fixedDate, fixedDoW, compareYear, site)]
  
  setkey(baseDT, fixedDate, fixedDoW)
  setkey(baseDT, fixedDate, fixedDoW)
  
  plotDT <- baseDT[testDT] # auto drops non matches to 2020
  plotDT[, pcDiffMean := 100*(testMean - baseMean)/baseMean] # -ve value indicates lower
  plotDT[, pcDiffMedian:= 100*(testMedian - baseMedian)/baseMedian] # -ve value indicates lower
  plotDT[, pos := ifelse(pcDiffMean > 0 , "Pos", "Neg")] # want to colour the line sections - how?
  # final plot - adds annotations
  # use means for consistency with comparison plots where we use WHO thresholds (means)
  yMin <- min(plotDT$pcDiffMean)
  print(paste0("Max drop %:", round(yMin)))
  yMax <- max(plotDT$pcDiffMean)
  print(paste0("Max increase %:", round(yMax)))
  p <- ggplot2::ggplot(plotDT, aes(x = fixedDate, y = pcDiffMean 
                                   #color = pos, group=NA)
  )
  ) +
    geom_step() +
    scale_x_date(date_breaks = "2 days", date_labels =  "%a %d %b")  +
    theme(axis.text.x=element_text(angle=90, hjust=1, size = 5)) +
    labs(x = "Date",
         y = "% difference 2020 vs 2017-2019",
         caption = paste0(myParams$lockdownCap, myParams$weekendCap)) +  
    theme(legend.position="bottom") +
    geom_hline(yintercept = 0, linetype = 3)
  
  p <- addLockdownDate(p, yMin, yMax)
  
  p <- addWeekendsDate(p, yMin, yMax)
  
  p <- p + facet_grid(site ~ .) +
    theme(strip.text.y.right = element_text(angle = 90))
  
  # p <- p + geom_hline(yintercept = yMin, linetype = 3) # dotted
  # p <- p + annotate("text", x = myParams$lockDownEndDate,
  #                   y = yMin,
  #                   label = yMin) # 
  # 
  # p <- p + geom_hline(yintercept = yMax, linetype = 3)
  # p <- p + annotate("text", x = myParams$lockDownEndDate,
  #                   y = yMax,
  #                   label = yMax) # 
  
  return(p)
}
