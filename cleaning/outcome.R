library(dplyr)
library(readxl)
library(purrr)

# Excelファイルが保存されているディレクトリのパス
folder_path <- "C:/Users/zwill/Downloads/warmup training package/warmup training package/01_data/raw/outcome"

# フォルダ内のすべてのExcelファイルのリストを取得し、読み込んでリストに格納
file_list <- list.files(path = folder_path, pattern = "*.xlsx", full.names = TRUE)

# ファイルを一括で読み込み、リストに保存
data_list <- file_list %>% 
  map(read_excel)

#data_listのデータセットを結合する(そのまま縦に)
outcome_data<- bind_rows(data_list)

# パーセンテージを0から1のスケールに変換
outcome_data_2 <- outcome_data %>%
  mutate(scale_womengradrate4yr = women_gradrate_4yr * 0.01)

#各列のデータの形式を確認する
str(outcome_data_2$m_4yrgrads)
str(outcome_data_2$m_cohortsize)
str(outcome_data_2$totcohortsize)
str(outcome_data_2$tot4yrgrads)

#scale_mengradrate4yrを追加し、男子学生の卒業率を計算する
outcome_data_2 <- outcome_data_2 %>%
  mutate(m_4yrgrads = as.numeric(m_4yrgrads))

outcome_data_3 <- outcome_data_2 %>%
  mutate(scale_mengradrate4yr = m_4yrgrads / m_cohortsize)

#scale_totgradrate4yrを追加し、男女合計の卒業率を計算する
outcome_data_3 <- outcome_data_3 %>%
  mutate(totcohortsize = as.numeric(totcohortsize))

outcome_data_4 <- outcome_data_3 %>%
  mutate(scale_totgradrate4yr = tot4yrgrads / totcohortsize)

#scale_列の数字を有効数字3桁に丸める
outcome_data_4 <- outcome_data_4 %>%
  mutate(scale_womengradrate4yr = signif(scale_womengradrate4yr, 3))
outcome_data_4 <- outcome_data_4 %>%
  mutate(scale_mengradrate4yr = signif(scale_mengradrate4yr, 3))
outcome_data_4 <-outcome_data_4 %>%
  mutate(scale_totgradrate4yr = signif(scale_totgradrate4yr, 3))

#1991~2010までのデータセットにする
outcome_data_5 <- outcome_data_4 %>%
  filter(year >= 1991 & year <= 2010)

# outcome_data_5 と covariates_5 に共通する unitid だけを持つ outcome_data_6のデータセットを作成
outcome_data_5 <- outcome_data_5 %>%
  mutate(unitid = as.double(unitid))

covariates_5 <- covariates_5 %>%
  mutate(unitid = as.double(unitid))

outcome_6 <- semi_join(outcome_data_5, covariates_5, by = "unitid")



