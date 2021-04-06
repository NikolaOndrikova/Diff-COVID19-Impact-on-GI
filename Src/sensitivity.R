#### SENSITIVITY ANALYSIS

### TEMPORAL FALSIFICATION: NOROVIRUS ------------------------------------------
noro_overall_fit2019 <- NbinomTsglm(outcome_ts = noro_ts[1:226],
                                predictors = noro_vars[1:226,3:10])

noro_intervtest122019 <- interv_test(fit=noro_overall_fit, tau=195, 
                                 delta = 1, est_interv=TRUE)

noro_intervtest122019$p_value >= 0.05

### TEMPORAL FALSIFICATION: CAMPYLOBACTER --------------------------------------
campy_overall_fit2019 <- NbinomTsglm(outcome_ts = campy_ts[1:226],#[1:209],
                                 predictors = campy_vars[1:226,3:10]) # without covid vars

campy_intervtest122019 <- interv_test(fit=campy_overall_fit2019, tau=195, 
                                  delta = 0.85, est_interv=TRUE)

campy_intervtest122019$p_value >= 0.05

### SPECIFIC IMPACT ------------------------------------------------------------

### Norovirus
noro_specific_short <- NbinomTsglm(outcome_ts = noro_ts[174:278],
                                    predictors = noro_vars[174:278,1:10])

print(scoring(noro_specific_short)[c(1,4,6)])
summary(noro_specific_short, B = 500)
# results from the model considering 5-years
#Sarscov2	        -0.00370	CI:	-0.00923	0.000657
#Stringency_lag1	-0.02506	CI:	-0.03852	-0.013480

# # results from the model considering 2-years
#Sarscov2         -0.00326    CI:    -0.0100    0.00317
#Stringency_lag1  -0.03107    CI:    -0.0533   -0.01760


### Campylobacter
campy_specific_short <- NbinomTsglm(outcome_ts = campy_ts[174:278],
                                  predictors = campy_vars[174:278,1:10])

print(scoring(campy_specific_short)[c(1,4,6)])
summary(campy_specific_short, B = 500)
# results from the model considering 5-years
# Sarscov2	      -0.00076	CI:	-0.00308	0.00113
# Stringency_lag1	-0.01061	CI:	-0.01584	-0.00580

# # results from the model considering 2-years
#Sarscov2          0.000193    CI:   -0.00224    0.00248
#Stringency_lag1  -0.011273    CI:   -0.01720   -0.00571





