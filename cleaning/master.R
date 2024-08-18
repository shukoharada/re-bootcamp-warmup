outcome_6 <- outcome_6 %>% distinct(unitid, .keep_all = TRUE)
covariates_7 <- covariates_7 %>% distinct(unitid, .keep_all = TRUE)

# outcome_6 と covariates_7 を unitid で結合
result <- left_join(outcome_6, covariates_7, by = "unitid")

# result と semester_data_7 を unitid で結合
master <- left_join(result, semester_8, by = "unitid")
