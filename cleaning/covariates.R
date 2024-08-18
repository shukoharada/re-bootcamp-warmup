install.packages("stringr")
install.packages("tidyr")

library(dplyr)
library(stringr)
library(tidyr)

# rename() 関数で列名を変更
covariates_2 <- covariates %>%
  rename(unitid = university_id)

# stringr の str_replace_all() 関数を使って "aaaa" を取り除く
covariates_3 <- covariates_2 %>%
  mutate(unitid = str_replace_all(unitid, "aaaa", ""))

# pivot_widerを使ってcategoryの値を列名として展開
covariates_4 <- covariates_3 %>%
  pivot_wider(names_from = category, values_from = value)

#1991~2010までのデータセットにする
covariates_5 <- covariates_4 %>%
  filter(year >= 1991 & year <= 2010)

# outcome_data_5 と covariates_5 に共通する unitid だけを持つ covariates_6のデータセットを作成
covariates_6 <- semi_join(covariates_5, outcome_6, by = "unitid")

covariates_7 <- semi_join(covariates_6, semester_8, by = "unitid")

covariates_8 <- covariates_7 %>% filter(duplicated(unitid))
