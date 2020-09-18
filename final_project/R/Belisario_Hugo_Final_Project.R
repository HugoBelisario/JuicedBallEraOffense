# Final Project -----------------------------------------------------------

# Hugo Belisario

# STAT 301-1 Data Science I

library(tidyverse)

fangraphs <- read_csv("FanGraphs Leaderboard.csv")

fangraphs2 <- fangraphs %>%
  select(-playerid, -`2B`, -`3B`, -(`FB%_1`:`CHv`))

View(fangraphs2)

baseball_savant <- read_csv("savant_data.csv")

View(baseball_savant)

baseball_savant2 <- baseball_savant %>%
  select(-pitches, -player_id, -total_pitches, -pitch_percent, -(ba:woba), -hits, -abs, -(spin_rate:pos9_int_start_distance))

View(baseball_savant2)

baseball_savant3 <- rename(baseball_savant2, Name = player_name)

(juiced_ball_era <- fangraphs2 %>% 
  inner_join(baseball_savant3, by = "Name"))

View(juiced_ball_era)

# Launch Angle against all players' wRC+ 

ggplot(data = juiced_ball_era) +
  geom_point(mapping = aes(x = `launch_angle`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `launch_angle`, y = `wRC+`), se = FALSE, color = "red") +
  xlab("Launch Angle") +
  ylab("wRC+")

# Launch Angle against above replacement level players (100)
ggplot(data = filter(juiced_ball_era, `wRC+` >= 100), mapping = aes(x = `launch_angle`, y = `wRC+`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("Launch Angle") +
  ylab("wRC+")
  
# Most of the above replacement level players are concentrated in between 10 and 20 degrees range.

# Launch Angle against xwoba

ggplot(juiced_ball_era, mapping = aes(x = `launch_angle`, y = `xwoba`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("Launch Angle") +
  ylab("xwOBA")

# Launch Angle against xwoba over average between 4 seasons

ggplot(data = filter(juiced_ball_era, `xwoba` >= .320), mapping = aes(x = `launch_angle`, y = `xwoba`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("Launch Angle") +
  ylab("xwOBA")

# Launch Speedagainst wRC+

ggplot(juiced_ball_era, mapping = aes(x = `launch_speed`, y = `wRC+`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("Launch Speed") +
  ylab("wRC+")

# Launch Speed against wRC+ above 100

ggplot(data = filter(juiced_ball_era, `wRC+`>= 100), mapping = aes(x = `launch_speed`, y = `wRC+`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("Launch Speed") +
  ylab("wRC+")

# Launch Speed against xwoba

ggplot(juiced_ball_era, mapping = aes(x = `launch_speed`, y = `xwoba`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("Launch Speed") +
  ylab("xwOBA")

# Launch Speed against xwoba above average

ggplot(data = filter(juiced_ball_era, `xwoba` >= .320), mapping = aes(x = `launch_speed`, y = `xwoba`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("Launch Speed") +
  ylab("xwOBA")

# Homeruns vs. Launch Angle 

ggplot(data = juiced_ball_era, mapping = aes(x = `launch_angle`, y = `HR`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("Launch Angle") +
  ylab("Home Runs")

# Homeruns > 20/year

ggplot(data = filter(juiced_ball_era, `HR` >= 80, `launch_angle` >= 10), mapping = aes(x = `launch_angle`, y = `HR`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("Launch Angle") +
  ylab("Home Runs")

# HR/FB 

ggplot(data = juiced_ball_era, mapping = aes(x = `launch_angle`, y = `hr.fb`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("Launch Angle") +
  ylab("HR/FB")

ggplot(data = juiced_ball_era, mapping = aes(x = `launch_angle`, y = `hr.fb.avg`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("Launch Angle") +
  ylab("HR/FB")

ggplot(data = juiced_ball_era, mapping = aes(x = `launch_speed`, y = `hr.fb`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("Launch Speed") +
  ylab("HR/FB")

# Batted Ball

# Line Drive, Ground Ball, Fly Ball Percentages

juiced_ball_era$`LD%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`LD%`)) 
juiced_ball_era$`GB%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`GB%`)) 
juiced_ball_era$`FB%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`FB%`)) 

ggplot(data = juiced_ball_era) +
  geom_point(mapping = aes(x = `LD%`, y = `wRC+`, color = "LD%")) +
  geom_smooth(mapping = aes(x = `LD%`, y = `wRC+`, color = "LD%"), se = FALSE) +
  geom_point(mapping = aes(x = `GB%`, y = `wRC+`, color = "GB%")) +
  geom_smooth(mapping = aes(x = `GB%`, y = `wRC+`, color = "GB%"), se = FALSE) +
  geom_point(mapping = aes(x = `FB%`, y = `wRC+`, color = "FB%")) +
  geom_smooth(mapping = aes(x = `FB%`, y = `wRC+`, color = "FB%"), se = FALSE) +
  xlab("Percentages") +
  ggtitle("Batted Ball vs. wRC+") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = filter(juiced_ball_era, `wRC+` >= 100)) +
  geom_point(mapping = aes(x = `LD%`, y = `wRC+`, color = "LD%")) +
  geom_smooth(mapping = aes(x = `LD%`, y = `wRC+`, color = "LD%"), se = FALSE) +
  geom_point(mapping = aes(x = `GB%`, y = `wRC+`, color = "GB%")) +
  geom_smooth(mapping = aes(x = `GB%`, y = `wRC+`, color = "GB%"), se = FALSE) +
  geom_point(mapping = aes(x = `FB%`, y = `wRC+`, color = "FB%")) +
  geom_smooth(mapping = aes(x = `FB%`, y = `wRC+`, color = "FB%"), se = FALSE) +
  xlab("Percentages") +
  ggtitle("Batted Ball vs. Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = juiced_ball_era) +
  geom_histogram(mapping = aes(x = `LD%`), color = "blue", binwidth = 1) +
  geom_histogram(mapping = aes(x = `GB%`), color = "red", binwidth = 1) +
  geom_histogram(mapping = aes(x = `FB%`), color = "green", binwidth = 1) +
  xlab("Percentages") +
  ggtitle("Batted Ball Distribution") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = filter(juiced_ball_era, `wRC+` >= 100)) +
  geom_histogram(mapping = aes(x = `LD%`), color = "blue", binwidth = 1) +
  geom_histogram(mapping = aes(x = `GB%`), color = "red", binwidth = 1) +
  geom_histogram(mapping = aes(x = `FB%`), color = "green", binwidth = 1) +
  xlab("Percentages") +
  ggtitle("Batted Ball Distribution for Players Above 100 wRC+") +
  theme(plot.title = element_text(hjust = 0.5))

# Pull, Center, Opposite Field Percentages

juiced_ball_era$`Pull%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`Pull%`)) 
juiced_ball_era$`Cent%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`Cent%`)) 
juiced_ball_era$`Oppo%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`Oppo%`))

ggplot(data = juiced_ball_era) +
  geom_point(mapping = aes(x = `Pull%`, y = `WAR`, color = "Pull%")) +
  geom_smooth(mapping = aes(x = `Pull%`, y = `WAR`, color = "Pull%"), se = FALSE) +
  geom_point(mapping = aes(x = `Cent%`, y = `WAR`, color = "Cent%")) +
  geom_smooth(mapping = aes(x = `Cent%`, y = `WAR`, color = "Cent%"), se = FALSE) +
  geom_point(mapping = aes(x = `Oppo%`, y = `WAR`, color = "Oppo%")) +
  geom_smooth(mapping = aes(x = `Oppo%`, y = `WAR`, color = "Oppo%"), se = FALSE) +
  xlab("Percentages") +
  ggtitle("Batted Ball (Field) vs. WAR") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = juiced_ball_era) +
  geom_point(mapping = aes(x = `Pull%`, y = `wRC+`, color = "Pull%")) +
  geom_smooth(mapping = aes(x = `Pull%`, y = `wRC+`, color = "Pull%"), se = FALSE) +
  geom_point(mapping = aes(x = `Cent%`, y = `wRC+`, color = "Cent%")) +
  geom_smooth(mapping = aes(x = `Cent%`, y = `wRC+`, color = "Cent%"), se = FALSE) +
  geom_point(mapping = aes(x = `Oppo%`, y = `wRC+`, color = "Oppo%")) +
  geom_smooth(mapping = aes(x = `Oppo%`, y = `wRC+`, color = "Oppo%"), se = FALSE) +
  xlab("Percentages") +
  ggtitle("Batted Ball (Field) vs. wRC+") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = filter(juiced_ball_era, `wRC+` >= 100)) +
  geom_point(mapping = aes(x = `Pull%`, y = `wRC+`, color = "Pull%")) +
  geom_smooth(mapping = aes(x = `Pull%`, y = `wRC+`, color = "Pull%"), se = FALSE) +
  geom_point(mapping = aes(x = `Cent%`, y = `wRC+`, color = "Cent%")) +
  geom_smooth(mapping = aes(x = `Cent%`, y = `wRC+`, color = "Cent%"), se = FALSE) +
  geom_point(mapping = aes(x = `Oppo%`, y = `wRC+`, color = "Oppo%")) +
  geom_smooth(mapping = aes(x = `Oppo%`, y = `wRC+`, color = "Oppo%"), se = FALSE) +
  xlab("Percentages") +
  ggtitle("Batted Ball (Field) vs. Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = juiced_ball_era) +
  geom_histogram(mapping = aes(x = `Pull%`), color = "blue", binwidth = 1) +
  geom_histogram(mapping = aes(x = `Cent%`), color = "red", binwidth = 1) +
  geom_histogram(mapping = aes(x = `Oppo%`), color = "green", binwidth = 1) +
  xlab("Percentages") +
  ggtitle("Batted Ball Distribution (Field)") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = filter(juiced_ball_era, `wRC+` >= 100)) +
  geom_histogram(mapping = aes(x = `Pull%`), color = "blue", binwidth = 1) +
  geom_histogram(mapping = aes(x = `Cent%`), color = "red", binwidth = 1) +
  geom_histogram(mapping = aes(x = `Oppo%`), color = "green", binwidth = 1) +
  xlab("Percentages") +
  ggtitle("Batted Ball Distribution (Field)") +
  theme(plot.title = element_text(hjust = 0.5))

# Soft Contact, Medium Contact, Hard Contact Percentages

juiced_ball_era$`Soft%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`Soft%`)) 
juiced_ball_era$`Med%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`Med%`)) 
juiced_ball_era$`Hard%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`Hard%`))

ggplot(data = juiced_ball_era) +
  geom_point(mapping = aes(x = `Soft%`, y = `wRC+`, color = "Soft%")) +
  geom_smooth(mapping = aes(x = `Soft%`, y = `wRC+`, color = "Soft%"), se = FALSE) +
  geom_point(mapping = aes(x = `Med%`, y = `wRC+`, color = "Med%")) +
  geom_smooth(mapping = aes(x = `Med%`, y = `wRC+`, color = "Med%"), se = FALSE) +
  geom_point(mapping = aes(x = `Hard%`, y = `wRC+`, color = "Hard%")) +
  geom_smooth(mapping = aes(x = `Hard%`, y = `wRC+`, color = "Hard%"), se = FALSE) +
  xlab("Percentages") +
  ggtitle("Batted Ball (Contact) vs. wRC+") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = filter(juiced_ball_era, `wRC+` >= 100)) +
  geom_point(mapping = aes(x = `Soft%`, y = `wRC+`, color = "Soft%")) +
  geom_smooth(mapping = aes(x = `Soft%`, y = `wRC+`, color = "Soft%"), se = FALSE) +
  geom_point(mapping = aes(x = `Med%`, y = `wRC+`, color = "Med%")) +
  geom_smooth(mapping = aes(x = `Med%`, y = `wRC+`, color = "Med%"), se = FALSE) +
  geom_point(mapping = aes(x = `Hard%`, y = `wRC+`, color = "Hard%")) +
  geom_smooth(mapping = aes(x = `Hard%`, y = `wRC+`, color = "Hard%"), se = FALSE) +
  xlab("Percentages") +
  ggtitle("Batted Ball (Contact) vs. Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = juiced_ball_era) +
  geom_histogram(mapping = aes(x = `Soft%`), color = "blue", binwidth = 1) +
  geom_histogram(mapping = aes(x = `Med%`), color = "red", binwidth = 1) +
  geom_histogram(mapping = aes(x = `Hard%`), color = "green", binwidth = 1) +
  xlab("Percentages") +
  ggtitle("Batted Ball Distribution (Contact)") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = filter(juiced_ball_era, `wRC+` >= 100)) +
  geom_histogram(mapping = aes(x = `Soft%`), color = "blue", binwidth = 1) +
  geom_histogram(mapping = aes(x = `Med%`), color = "red", binwidth = 1) +
  geom_histogram(mapping = aes(x = `Hard%`), color = "green", binwidth = 1) +
  xlab("Percentages") +
  ggtitle("Batted Ball Distribution (Contact)") +
  theme(plot.title = element_text(hjust = 0.5))

# Pitch Value

ggplot(data = juiced_ball_era) +
  geom_point(mapping = aes(x = `wFB/C`, y = `WAR`, color = "wFB/C")) +
  geom_smooth(mapping = aes(x = `wFB/C`, y = `WAR`, color = "wFB/C"), se = FALSE) +
  geom_point(mapping = aes(x = `wSL/C`, y = `WAR`, color = "wSL/C")) +
  geom_smooth(mapping = aes(x = `wSL/C`, y = `WAR`, color = "wSL/C"), se = FALSE) +
  geom_point(mapping = aes(x = `wCB/C`, y = `WAR`, color = "wCB/C")) +
  geom_smooth(mapping = aes(x = `wCB/C`, y = `WAR`, color = "wCB/C"), se = FALSE) +
  geom_point(mapping = aes(x = `wCH/C`, y = `WAR`, color = "wCH/C")) +
  geom_smooth(mapping = aes(x = `wCH/C`, y = `WAR`, color = "wCH/C"), se = FALSE) +
  xlab("Percentages") +
  ggtitle("Pitch Value vs. WAR") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = filter(juiced_ball_era, `wRC+` >= 120)) +
  geom_point(mapping = aes(x = `wFB/C`, y = `WAR`, color = "wFB/C")) +
  geom_smooth(mapping = aes(x = `wFB/C`, y = `WAR`, color = "wFB/C"), se = FALSE) +
  geom_point(mapping = aes(x = `wSL/C`, y = `WAR`, color = "wSL/C")) +
  geom_smooth(mapping = aes(x = `wSL/C`, y = `WAR`, color = "wSL/C"), se = FALSE) +
  geom_point(mapping = aes(x = `wCB/C`, y = `WAR`, color = "wCB/C")) +
  geom_smooth(mapping = aes(x = `wCB/C`, y = `WAR`, color = "wCB/C"), se = FALSE) +
  geom_point(mapping = aes(x = `wCH/C`, y = `WAR`, color = "wCH/C")) +
  geom_smooth(mapping = aes(x = `wCH/C`, y = `WAR`, color = "wCH/C"), se = FALSE) +
  xlab("Percentages") +
  ggtitle("Pitch Value vs. WAR") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = juiced_ball_era) +
  geom_point(mapping = aes(x = `wFB/C`, y = `wRC+`, color = "wFB/C")) +
  geom_smooth(mapping = aes(x = `wFB/C`, y = `wRC+`, color = "wFB/C"), se = FALSE) +
  geom_point(mapping = aes(x = `wSL/C`, y = `wRC+`, color = "wSL/C")) +
  geom_smooth(mapping = aes(x = `wSL/C`, y = `wRC+`, color = "wSL/C"), se = FALSE) +
  geom_point(mapping = aes(x = `wCB/C`, y = `wRC+`, color = "wCB/C")) +
  geom_smooth(mapping = aes(x = `wCB/C`, y = `wRC+`, color = "wCB/C"), se = FALSE) +
  geom_point(mapping = aes(x = `wCH/C`, y = `wRC+`, color = "wCH/C")) +
  geom_smooth(mapping = aes(x = `wCH/C`, y = `wRC+`, color = "wCH/C"), se = FALSE) +
  xlab("Percentages") +
  ggtitle("Pitch Value vs. wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
  
ggplot(data = juiced_ball_era) +
  geom_point(mapping = aes(x = `wFB/C`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `wFB/C`, y = `wRC+`), se = FALSE)

ggplot(data = juiced_ball_era) +
  geom_point(mapping = aes(x = `wSL/C`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `wSL/C`, y = `wRC+`), se = FALSE) 

ggplot(data = juiced_ball_era) +
  geom_point(mapping = aes(x = `wCB/C`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `wCB/C`, y = `wRC+`), se = FALSE) 

ggplot(data = juiced_ball_era) +
  geom_point(mapping = aes(x = `wCH/C`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `wCH/C`, y = `wRC+`), se = FALSE)

# Walk and Strikeout Rates

juiced_ball_era$`BB%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`BB%`)) 
juiced_ball_era$`K%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`K%`)) 

ggplot(data = juiced_ball_era) +
  geom_hex(mapping = aes(x = `BB%`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `BB%`, y = `wRC+`), se = FALSE, color = "blue") +
  xlab("BB%") +
  ylab("wRC+") +
  ggtitle("BB% vs. wRC+") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = filter(juiced_ball_era, `wRC+` >= 115)) +
  geom_jitter(mapping = aes(x = `BB%`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `BB%`, y = `wRC+`), se = FALSE, color = "red") +
  xlab("BB%") +
  ylab("wRC+") +
  ggtitle("BB% vs. Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = juiced_ball_era) +
  geom_hex(mapping = aes(x = `BB%`, y = `wOBA`)) +
  geom_smooth(mapping = aes(x = `BB%`, y = `wOBA`), se = FALSE, color = "blue") +
  xlab("BB%") +
  ylab("wOBA") +
  ggtitle("BB% vs. wOBA") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = filter(juiced_ball_era, `wOBA` >= .340)) +
  geom_jitter(mapping = aes(x = `BB%`, y = `wOBA`)) +
  geom_smooth(mapping = aes(x = `BB%`, y = `wOBA`), se = FALSE, color = "red") +
  xlab("BB%") +
  ylab("wOBA") +
  ggtitle("BB% vs. Above Average wOBA") +
  theme(plot.title = element_text(hjust = 0.5)) 
ggplot(data = juiced_ball_era) +
  geom_jitter(mapping = aes(x = `K%`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `K%`, y = `wRC+`), se = FALSE, color = "blue") +
  xlab("K%") +
  ylab("wRC+") +
  ggtitle("K% vs. wRC+") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = filter(juiced_ball_era, `wRC+` >= 115)) +
  geom_jitter(mapping = aes(x = `K%`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `K%`, y = `wRC+`), se = FALSE, color = "red") +
  xlab("K%") +
  ylab("wRC+") +
  ggtitle("K% vs. Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = juiced_ball_era) +
  geom_jitter(mapping = aes(x = `K%`, y = `wOBA`)) +
  geom_smooth(mapping = aes(x = `K%`, y = `wOBA`), se = FALSE, color = "blue") +
  xlab("K%") +
  ylab("wOBA") +
  ggtitle("K% vs. wOBA") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = filter(juiced_ball_era, `wOBA` >= .340)) +
  geom_jitter(mapping = aes(x = `K%`, y = `wOBA`)) +
  geom_smooth(mapping = aes(x = `K%`, y = `wOBA`), se = FALSE, color = "red") +
  xlab("K%") +
  ylab("wOBA") +
  ggtitle("K% vs. Above Average wOBA") +
  theme(plot.title = element_text(hjust = 0.5))

# ISO vs. FB%

juiced_ball_era$`HR/FB` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`HR/FB`)) 

ggplot(data = juiced_ball_era, mapping = aes(x = `FB%`, y = `ISO`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("FB%") +
  ylab("ISO") +
  ggtitle("FB% vs. ISO") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = filter(juiced_ball_era, `wRC+` >= 115), mapping = aes(x = `FB%`, y = `ISO`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("FB%") +
  ylab("ISO") +
  ggtitle("FB% vs. ISO") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = juiced_ball_era, mapping = aes(x = `LD%`, y = `ISO`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("LD%") +
  ylab("ISO") +
  ggtitle("LD% vs. ISO") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = filter(juiced_ball_era, `wRC+` >= 115), mapping = aes(x = `FB%`, y = `ISO`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("LD%") +
  ylab("ISO") +
  ggtitle("LD% vs. ISO") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = juiced_ball_era, mapping = aes(x = `GB%`, y = `ISO`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("GB%") +
  ylab("ISO") +
  ggtitle("GB% vs. ISO") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = filter(juiced_ball_era, `wRC+` >= 115), mapping = aes(x = `GB%`, y = `ISO`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("GB%") +
  ylab("ISO") +
  ggtitle("GB% vs. ISO") +
  theme(plot.title = element_text(hjust = 0.5))