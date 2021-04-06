# Custom functions to make the code look cleaner

NbinomTsglm <- function(outcome_ts, predictors){
  ### function with our model definition
  
  set.seed(123589)
  model_fit <- tsglm(ts = outcome_ts,
                     xreg = predictors,
                     model = list(past_obs=c(1)),
                     distr = "nbinom", link = 'log') 
  return(model_fit)
}

DateSeqs <- function(start='2015-6-29',intervention='2020-3-16',end='2020-6-22'){
  start = as.Date(start)
  intervention= as.Date(intervention)
  end = as.Date(end)
  date_seqs = list(whole_period =seq(start, end,'week'),
                   intervention_period = seq(intervention, end,'week'))
  return(date_seqs)
}


WouldHaveBeenPlotPrep <- function(outcome_ts, predictors, start, nahead, dateseqs){
  ### start is an index of the intervention start,
  ### nahead is the number of data points to predict
  
  set.seed(123589)
  ENDi = start - 1 
  
  model_fit <- tsglm(ts = outcome_ts[1:ENDi],
                     xreg = predictors[1:ENDi,],
                     model = list(past_obs=c(1)),
                     distr = "nbinom", link = 'log') 

  could_be = predict(model_fit, n.ahead = nahead, 
                     newxreg = predictors[start:(ENDi+nahead),])
  
  #browser()
  ### 95% forecast parametric bootstrap interval
  predictions <- cbind.data.frame(
    as.numeric(could_be$interval[,1]),
    as.numeric(could_be$interval[,2]), 
    dateseqs$intervention_period)
  names(predictions) <- c("Lower", "Upper", "Date")
  
  comparison <- data.frame(
    # fitted values and (mean) predictions
    c(as.numeric(model_fit$fitted.values[1:ENDi]),
      as.numeric(could_be$pred)),
    # actual data and dates 
    as.numeric(outcome_ts[1:(ENDi+nahead)]),
    dateseqs$whole_period)
  names(comparison) <- c("Fitted", "Actual", "Date")
  
  prepared_data = left_join(comparison, predictions, by="Date")
  
  return(prepared_data)
}


WouldHaveBeenPlot <- function(prepared_data, taili = length(prepared_data)){
  
  suppressPackageStartupMessages(library(ggplot2))
  suppressPackageStartupMessages(library(dplyr))
  suppressPackageStartupMessages(library(scales))
  
  ### Join intervals to the forecast
  noro_plot <- tail(prepared_data, taili)
  
  gg <- ggplot(data=noro_plot, aes(x=Date)) +
          geom_line(aes(y=Actual, colour = "Actual"), size=1.4, alpha=0.80) +
          geom_line(aes(y=Fitted, colour = "Fitted"), size=1.2, linetype=2, alpha=0.80) +
          scale_colour_manual(values=c(Actual="#168866",Fitted="#7d0190")) +
          theme_bw() + theme(legend.title = element_blank()) + ylab("") + xlab("") +
          geom_ribbon(aes(ymin=Lower, ymax=Upper), fill='#7d0190', alpha=0.2) +
          #scale_x_continuous(breaks = seq(min(prepared_data$Date),max(prepared_data$Date), by = 30))+
          scale_x_date(date_breaks = "months", labels = date_format("%b-%Y"))+
          theme(text = element_text(size=16),
                legend.position = 'none',
                axis.text.x=element_text(angle = 35, hjust = 1))
  return(gg)
}