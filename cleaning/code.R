install.packages("dplyr")

library(dplyr)

#semester dateの整形
#列名を変更
semester_data_2_1 <- semester_data_2 %>% rename(unitid = x1, instnm = x2, semester = x3, quarter = x4, year = x5, Y = x6)
#データを結合させる
combined_data <- rbind(semester_data_1, semester_data_2_1)
#Y列を削除する
combined_data_1 <- combined_data %>% select(-Y)

# 新しい列を追加して、quarterからsemesterに変わった年を記録
combined_data_2 <- combined_data_1 %>%
  group_by(unitid) %>%  # unitidでグループ化
  mutate(change_year = ifelse(semester == 1 & lag(quarter) == 1, year, NA)) %>%  # 変換された年を記録
  mutate(change_year = ifelse(all(is.na(change_year)), NA, min(change_year, na.rm = TRUE))) %>%  # 最初に変わった年を取得
  ungroup()  # グループ化を解除

# semester_dammy 列を追加する
combined_data_3 <- combined_data_2 %>%
  mutate(semester_dammy = ifelse(year >= change_year, 1, 0))