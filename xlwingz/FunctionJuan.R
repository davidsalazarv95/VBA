
multiples_regresiones <- function(df, fondos, indices) {
  
  # Formula de regresión
  formula <- as.formula(paste('ret_fondo ~', paste(colnames(df)[indices], collapse='+')))
  
  regresiones <- df %>%
    gather(key = "fondo", value = "ret_fondo", fondos) %>%
    group_by(fondo) %>% # para cada fondo corra la misma regresión
    do(mk = (lm(formula, data = .)))
  
  # Arreglemos la regresión en un dataframe
  cosa <- tidy(regresiones, mk)
  cosa$std.error <- NULL
  cosa$p.value <- NULL
  
  temp <- cosa
  temp$statistic <- NULL
  beta <- temp %>%
    spread(term, estimate)
  
  temp2 <- cosa
  temp2$estimate <- NULL
  t_stat <- temp2 %>%
    spread(term, statistic)
  
  beta[["term"]] <- "Beta"
  t_stat[["term"]] <- "t-statistic"
  
  final <- bind_rows(beta, t_stat) %>%
    arrange(fondo)
  
  final
}
