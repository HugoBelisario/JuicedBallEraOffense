# Juiced Ball Era Offense

## Final Project Report

Today, in Major League Baseball, it is clear that the composition of the ball has been altered to promote more offense in the form of extra base hits (doubles, triples, home runs). This has affected the run environment drastically while also driving up strikeout rates. Although I have a basic understanding of today’s offensive approach in professional baseball, I am curious to see what the most successful hitters do while observing what others lack in hitting the new baseball.What kind of approach do these hitters have against the elite pitching we are witnessing in the game today? Analysts are obsessed with terms like launch angle and exit velocity, however, these numbers solely cannot explain how players are surviving and thriving in these conditions. Are hitters having more success hitting certain pitches? Are players pulling the ball more instead of spraying the baseball to all parts of the field? Are mediocre hitters that way because of softer contact on the baseball? What range of launch angle is ideal to lift the ball up for more opportunities to succeed? We know the best hitters lift the ball constantly, but at what rates? Those are some of the many topics I plan to explore with this data.

The data provided by FanGraphs are comprised of standard and advanced statistics for position players or batters with a minimum of 1000 plate appearances during the so-called “juiced ball” era, specifically from 2016 to 2019 regular seasons. In addition, there are data on the particular pitches these batters faced and the way they made contact on each pitch with batted ball data. This will be joined by statistics that evaluate how valuable these players are and how good they have been in the past four seasons.

Baseball Savant’s Statcast search has information on all pitches thrown since the technology was implemented in 2014. In this case, I am looking at characteristics of the baseballs that were hit by those in the FanGraphs list of position players.I anticipate to join the data from Baseball Savant because it provides data not available on FanGraphs such as launch angle, launch speed, and weighted On-Base Average using launch speed/angle.

baseball_savant2 <- baseball_savant %>%
  select(-pitches, -player_id, -total_pitches, -pitch_percent, -(ba:woba), -hits, -abs, -(spin_rate:pos9_int_start_distance))
baseball_savant3 <- rename(baseball_savant2, Name = player_name)

(juiced_ball_era <- fangraphs2 %>% 
  inner_join(baseball_savant3, by = "Name"))
## # A tibble: 292 x 37
##    Name   Team      H    HR   AVG `BB%` `K%`    OPS   ISO BABIP `LD%` `GB%`
##    <chr>  <chr> <dbl> <dbl> <dbl> <chr> <chr> <dbl> <dbl> <dbl> <chr> <chr>
##  1 Mike … Ange…   580   146 0.307 18.4… 19.7… 1.06  0.303 0.336 22.7… 33.7…
##  2 J.D. … - - -   635   146 0.312 10.5… 23.4… 0.985 0.288 0.357 21.4… 42.0…
##  3 Aaron… Yank…   387   110 0.273 16.1… 31.6… 0.952 0.285 0.357 23.4… 38.4…
##  4 Juan … Nati…   274    56 0.287 16.2… 20.0… 0.937 0.248 0.323 19.6… 46.8…
##  5 Chris… - - -   690   119 0.308 11.6… 20.4… 0.934 0.234 0.354 22.1… 52.1…
##  6 Fredd… Brav…   680   123 0.303 12.2… 20.1… 0.944 0.246 0.346 28.7… 35.1…
##  7 Charl… Rock…   764   127 0.315 7.7 % 17.6… 0.934 0.243 0.346 24.0… 39.5…
##  8 Nolan… Rock…   729   157 0.303 9.8 % 15.6… 0.947 0.271 0.309 19.9… 36.2…
##  9 Joey … Reds    640    92 0.299 16.3… 16.3… 0.91  0.194 0.333 26.6… 39.2…
## 10 Josh … - - -   464   115 0.269 15.2… 21.2… 0.918 0.263 0.295 19.8… 41.0…
## # … with 282 more rows, and 25 more variables: `FB%` <chr>, `HR/FB` <chr>,
## #   `Pull%` <chr>, `Cent%` <chr>, `Oppo%` <chr>, `Soft%` <chr>,
## #   `Med%` <chr>, `Hard%` <chr>, wFB <dbl>, wSL <dbl>, wCB <dbl>,
## #   wCH <dbl>, `wFB/C` <dbl>, `wSL/C` <dbl>, `wCB/C` <dbl>, `wCH/C` <dbl>,
## #   `wRC+` <dbl>, wOBA <dbl>, Bat <dbl>, WAR <dbl>, WPA <dbl>,
## #   xwoba <dbl>, xba <dbl>, launch_speed <dbl>, launch_angle <dbl>
Key Rate Statistics
wRC+
Weighted Runs Created Plus (wRC+) is a rate statistic which attempts to credit a hitter for the value of each outcome rather than treating all hits or times on base equally, while also controlling for park effects and the current run environment. wRC+ is scaled so that league average is 100. In this EDA, I will use wRC+ and Above Average wRC+ to see discover relationships between this Batted Ball, Pitch Value, Advanced statistics.

wOBA and xwOBA
Weighted On-Base Average (wOBA) is a rate statistic which attempts to credit a hitter for the value of each outcome rather than treating all hits or times on base equally. Expected Weighted On-base Average (xwOBA) is formulated using exit velocity, launch angle and, on certain types of batted balls, Sprint Speed.

ISO
Isolated Power is the average number of extra bases per at bat, calculated several ways such as SLG minus AVG. This will not be used as often since it is not a definitive statistic when looking at the true value of a player.

Walk and Strikeout Rates
BB% (Walk Percentage) is the frequency with which the batter has walked, calculated as walks divided by plate appearances. Ever since the “Moneyball” revolution, the ability to get on base by drawing walks has displayed exeptional plate discipline and been valued more by MLB organizations. However, now that players are aware of the “juiced ball”, I wondered if they were sacrificing walks for more opportunities to put the ball in play. A BB% of 10% and 15% are considered above average and excellent, respectively.

juiced_ball_era$`BB%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`BB%`)) 
juiced_ball_era$`K%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`K%`)) 

ggplot(data = juiced_ball_era) +
  geom_hex(mapping = aes(x = `BB%`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `BB%`, y = `wRC+`), se = FALSE, color = "blue") +
  xlab("BB%") +
  ylab("wRC+") +
  ggtitle("BB% vs. wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = filter(juiced_ball_era, `wRC+` >= 115)) +
  geom_jitter(mapping = aes(x = `BB%`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `BB%`, y = `wRC+`), se = FALSE, color = "red") +
  xlab("BB%") +
  ylab("wRC+") +
  ggtitle("BB% vs. Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = juiced_ball_era) +
  geom_hex(mapping = aes(x = `BB%`, y = `wOBA`)) +
  geom_smooth(mapping = aes(x = `BB%`, y = `wOBA`), se = FALSE, color = "blue") +
  xlab("BB%") +
  ylab("wOBA") +
  ggtitle("BB% vs. wOBA") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = filter(juiced_ball_era, `wOBA` >= .340)) +
  geom_jitter(mapping = aes(x = `BB%`, y = `wOBA`)) +
  geom_smooth(mapping = aes(x = `BB%`, y = `wOBA`), se = FALSE, color = "red") +
  xlab("BB%") +
  ylab("wOBA") +
  ggtitle("BB% vs. Above Average wOBA") +
  theme(plot.title = element_text(hjust = 0.5)) 
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


Observing the relationships between both wRC+ and wOBA with BB%, we see that there are positive relationships. However, most of the players have average or below average rates concentrating in between 5% and 10%. It seems as if the more you walk, the more you are valuable in terms of wOBA and wRC+. When zooming into players with above average levels of wOBA and wRC+, the relationship is somewhat positive but much more indeterminate. Players who are overall very good are usually above 8% which proves that great hitters walk at least 10 times per 100 AB.

Previous to this new revolution of elite pitching and launch angles propelling home run rates, striking out constantly was scorned by organizations and fans. Nowadays, many players considered the best in the game are also those who strike out the most. The elite pitching has also made it harder to make contact.

ggplot(data = juiced_ball_era) +
  geom_jitter(mapping = aes(x = `K%`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `K%`, y = `wRC+`), se = FALSE, color = "blue") +
  xlab("K%") +
  ylab("wRC+") +
  ggtitle("K% vs. wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = filter(juiced_ball_era, `wRC+` >= 115)) +
  geom_jitter(mapping = aes(x = `K%`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `K%`, y = `wRC+`), se = FALSE, color = "red") +
  xlab("K%") +
  ylab("wRC+") +
  ggtitle("K% vs. Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = juiced_ball_era) +
  geom_jitter(mapping = aes(x = `K%`, y = `wOBA`)) +
  geom_smooth(mapping = aes(x = `K%`, y = `wOBA`), se = FALSE, color = "blue") +
  xlab("K%") +
  ylab("wOBA") +
  ggtitle("K% vs. wOBA") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = filter(juiced_ball_era, `wOBA` >= .340)) +
  geom_jitter(mapping = aes(x = `K%`, y = `wOBA`)) +
  geom_smooth(mapping = aes(x = `K%`, y = `wOBA`), se = FALSE, color = "red") +
  xlab("K%") +
  ylab("wOBA") +
  ggtitle("K% vs. Above Average wOBA") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


These plots prove that all types of hitters whether they are below, at, or above average in wRC+ and wOBA can have varying strikeout rates. Most of the players being observed are at average or worse levels (20% and over).

Batted Ball
Batted Ball Statistics
Line Drive Percentage (LB%) is the percentage of a batter’s balls in play that are line drives. Ground Ball Percentage (GB%) is the percentage of a batter’s balls in play that are groundballs. Fly Ball Percentage (FB%) is the percentage of a batter’s balls in play that are fly balls. There is no ideal batted ball distribution, but batters who hit a lot of line drives typically perform better than hitters who hit lots of fly balls or ground balls. Line drives go for hits most often, ground balls go for hits more often than fly balls, and fly balls are more productive than ground balls when they do go for hits (i.e. extra base hits). During this wave of home runs, defensive shifts, and strikeouts, players tend to lift the ball more often.

juiced_ball_era$`LD%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`LD%`)) 
juiced_ball_era$`GB%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`GB%`)) 
juiced_ball_era$`FB%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`FB%`)) 

ggplot(data = juiced_ball_era) +
  geom_jitter(mapping = aes(x = `LD%`, y = `wRC+`, color = "LD%")) +
  geom_smooth(mapping = aes(x = `LD%`, y = `wRC+`, color = "LD%"), se = FALSE) +
  geom_jitter(mapping = aes(x = `GB%`, y = `wRC+`, color = "GB%")) +
  geom_smooth(mapping = aes(x = `GB%`, y = `wRC+`, color = "GB%"), se = FALSE) +
  geom_jitter(mapping = aes(x = `FB%`, y = `wRC+`, color = "FB%")) +
  geom_smooth(mapping = aes(x = `FB%`, y = `wRC+`, color = "FB%"), se = FALSE) +
  xlab("Percentages") +
  ggtitle("Batted Ball vs. wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = filter(juiced_ball_era, `wRC+` >= 115)) +
  geom_jitter(mapping = aes(x = `LD%`, y = `wRC+`, color = "LD%")) +
  geom_smooth(mapping = aes(x = `LD%`, y = `wRC+`, color = "LD%"), se = FALSE) +
  geom_jitter(mapping = aes(x = `GB%`, y = `wRC+`, color = "GB%")) +
  geom_smooth(mapping = aes(x = `GB%`, y = `wRC+`, color = "GB%"), se = FALSE) +
  geom_jitter(mapping = aes(x = `FB%`, y = `wRC+`, color = "FB%")) +
  geom_smooth(mapping = aes(x = `FB%`, y = `wRC+`, color = "FB%"), se = FALSE) +
  xlab("Percentages") +
  ggtitle("Batted Ball vs. Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = juiced_ball_era) +
  geom_histogram(mapping = aes(x = `LD%`), color = "blue", binwidth = 1) +
  geom_histogram(mapping = aes(x = `GB%`), color = "red", binwidth = 1) +
  geom_histogram(mapping = aes(x = `FB%`), color = "green", binwidth = 1) +
  xlab("Percentages") +
  ggtitle("Batted Ball Distribution") +
  theme(plot.title = element_text(hjust = 0.5))


ggplot(data = filter(juiced_ball_era, `wRC+` >= 115)) +
  geom_histogram(mapping = aes(x = `LD%`), color = "blue", binwidth = 1) +
  geom_histogram(mapping = aes(x = `GB%`), color = "red", binwidth = 1) +
  geom_histogram(mapping = aes(x = `FB%`), color = "green", binwidth = 1) +
  xlab("Percentages") +
  ggtitle("Batted Ball Distribution for Players with Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))


Observing this data, one can infer that players tend to hit Fly Balls between 30% and 45% of the time, Ground Balls around 35% to 50% of the time, and Line Drives around 16% to 25% of the time because it is the most difficult to do out of the three. For above average ballplayers, they tend to hit Fly Balls 35% to 50%, less than 45% Ground Balls, and more than 20% Line Drives. All of these levels put these players above league average.

Batted Ball Direction
Pull Percentage (Pull%) is the percentage batted balls hit to the pull field. The field is divided up into three equal slices with the pull field being defined as the right field for left-handed hitters and left field for right-handed hitters. Center Percentage (Cent%) is the percentage batted balls hit to the middle of the field. Opposite Field Percentage (Oppo%) is the percentage of batted balls hit to the opposite field. The opposite field is left field for left-handed hitters and right field for right-handed hitters.

Using these statistics, we can infer that hitters in this era are pulling the ball less and spraying the ball to all parts of the field as an adjustment to the overwhelming number of defensive shifts over the past several seasons or sticking to pulling the ball since they are usually trying to lift it over the heads of the players.

juiced_ball_era$`Pull%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`Pull%`)) 
juiced_ball_era$`Cent%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`Cent%`)) 
juiced_ball_era$`Oppo%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`Oppo%`))

ggplot(data = juiced_ball_era) +
  geom_jitter(mapping = aes(x = `Pull%`, y = `wRC+`, color = "Pull%")) +
  geom_smooth(mapping = aes(x = `Pull%`, y = `wRC+`, color = "Pull%"), se = FALSE) +
  geom_jitter(mapping = aes(x = `Cent%`, y = `wRC+`, color = "Cent%")) +
  geom_smooth(mapping = aes(x = `Cent%`, y = `wRC+`, color = "Cent%"), se = FALSE) +
  geom_jitter(mapping = aes(x = `Oppo%`, y = `wRC+`, color = "Oppo%")) +
  geom_smooth(mapping = aes(x = `Oppo%`, y = `wRC+`, color = "Oppo%"), se = FALSE) +
  xlab("Percentages") +
  ggtitle("Batted Ball (Direction) vs. wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = filter(juiced_ball_era, `wRC+` >= 115)) +
  geom_jitter(mapping = aes(x = `Pull%`, y = `wRC+`, color = "Pull%")) +
  geom_smooth(mapping = aes(x = `Pull%`, y = `wRC+`, color = "Pull%"), se = FALSE) +
  geom_jitter(mapping = aes(x = `Cent%`, y = `wRC+`, color = "Cent%")) +
  geom_smooth(mapping = aes(x = `Cent%`, y = `wRC+`, color = "Cent%"), se = FALSE) +
  geom_jitter(mapping = aes(x = `Oppo%`, y = `wRC+`, color = "Oppo%")) +
  geom_smooth(mapping = aes(x = `Oppo%`, y = `wRC+`, color = "Oppo%"), se = FALSE) +
  xlab("Percentages") +
  ggtitle("Batted Ball (Direction) vs. Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = juiced_ball_era) +
  geom_histogram(mapping = aes(x = `Pull%`), color = "blue", binwidth = 5) +
  geom_histogram(mapping = aes(x = `Cent%`), color = "red", binwidth = 5) +
  geom_histogram(mapping = aes(x = `Oppo%`), color = "green", binwidth = 5) +
  xlab("Percentages") +
  ggtitle("Batted Ball Distribution (Field)") +
  theme(plot.title = element_text(hjust = 0.5))


ggplot(data = filter(juiced_ball_era, `wRC+` >= 115)) +
  geom_histogram(mapping = aes(x = `Pull%`), color = "blue", binwidth = 5) +
  geom_histogram(mapping = aes(x = `Cent%`), color = "red", binwidth = 5) +
  geom_histogram(mapping = aes(x = `Oppo%`), color = "green", binwidth = 5) +
  xlab("Percentages") +
  ggtitle("Batted Ball Distribution (Direction) for Players with Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))


From the scatter plots, one can say that the majority of players in this dataset tend to pull the ball around 30% to 50% of the time they put balls in play, while centering the ball and hitting balls the other way follow along with a range of 30% to 40% and 16% to 35%, respectively. This seems to be true among all players. The histogram shows that overall players send baseballs to the center of the ballpark about 35% of the time, to the opposite field at 25%, and to pull side 40% of the time. These are considered average levels for each category.

Quality of Contact
The notion of quality of contact is that the harder you hit the ball, the more of a chance it has to be a hit. Of course, there are other factors go into a ball becoming a hit such as ball placement and the defensive alignment. This can be a measure of true talent and can determine the direction of a player’s luck during a season. It takes two to three years for batted ball luck to even out. Here, we have four seasons enough to make certain inferences.

Soft% is the percentage of soft-hit batted balls. Med% is the percentage of medium-hit batted balls. Hard% is the percentage of hard-hit batted balls.

juiced_ball_era$`Soft%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`Soft%`)) 
juiced_ball_era$`Med%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`Med%`)) 
juiced_ball_era$`Hard%` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`Hard%`))

ggplot(data = juiced_ball_era) +
  geom_jitter(mapping = aes(x = `Soft%`, y = `wRC+`, color = "Soft%")) +
  geom_smooth(mapping = aes(x = `Soft%`, y = `wRC+`, color = "Soft%"), se = FALSE) +
  geom_jitter(mapping = aes(x = `Med%`, y = `wRC+`, color = "Med%")) +
  geom_smooth(mapping = aes(x = `Med%`, y = `wRC+`, color = "Med%"), se = FALSE) +
  geom_jitter(mapping = aes(x = `Hard%`, y = `wRC+`, color = "Hard%")) +
  geom_smooth(mapping = aes(x = `Hard%`, y = `wRC+`, color = "Hard%"), se = FALSE) +
  xlab("Percentages") +
  ggtitle("Batted Ball (Contact) vs. wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = filter(juiced_ball_era, `wRC+` >= 115)) +
  geom_jitter(mapping = aes(x = `Soft%`, y = `wRC+`, color = "Soft%")) +
  geom_smooth(mapping = aes(x = `Soft%`, y = `wRC+`, color = "Soft%"), se = FALSE) +
  geom_jitter(mapping = aes(x = `Med%`, y = `wRC+`, color = "Med%")) +
  geom_smooth(mapping = aes(x = `Med%`, y = `wRC+`, color = "Med%"), se = FALSE) +
  geom_jitter(mapping = aes(x = `Hard%`, y = `wRC+`, color = "Hard%")) +
  geom_smooth(mapping = aes(x = `Hard%`, y = `wRC+`, color = "Hard%"), se = FALSE) +
  xlab("Percentages") +
  ggtitle("Batted Ball (Contact) vs. Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = juiced_ball_era) +
  geom_histogram(mapping = aes(x = `Soft%`), color = "blue", binwidth = 1) +
  geom_histogram(mapping = aes(x = `Med%`), color = "red", binwidth = 1) +
  geom_histogram(mapping = aes(x = `Hard%`), color = "green", binwidth = 1) +
  xlab("Percentages") +
  ggtitle("Batted Ball Distribution (Contact)") +
  theme(plot.title = element_text(hjust = 0.5))


ggplot(data = filter(juiced_ball_era, `wRC+` >= 115)) +
  geom_histogram(mapping = aes(x = `Soft%`), color = "blue", binwidth = 2.5) +
  geom_histogram(mapping = aes(x = `Med%`), color = "red", binwidth = 2.5) +
  geom_histogram(mapping = aes(x = `Hard%`), color = "green", binwidth = 2.5) +
  xlab("Percentages") +
  ggtitle("Batted Ball Distribution (Contact) for Players with Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))


Med% and Soft% share negative relationships with wRC+ proving the more you hit at those levels the less you are able to contribute offensively while hitting at Hard% increases your likelihood of being an above average player in wRC+ levels. There is a positive relationship between Hard% and wRC+. For players with above average wRC+ they are usually at around 40% to 50% Hard% which is considered excellent, 35% to 48% Med% considered great, and 10% to 20% which is just about average and above.

Pitch Value
Pitch values attempts to find out how well a batter has hit against a certain pitch. They make use of the changes in average run expectancy from one count to another and while the changes in run expectancy between an 0-0 count and a 0-1 or 1-0 count are insignificant, when added up over the course of the season, you can get an idea of which pitch a hitter was best against. A score of zero is average, with negative scores being below average and positive scores being above average for both hitters.

wFB/C denotes the number of runs above average a batter was against a fastball per 100 pitches. The same applies to Sliders (wSL/C), Curveballs (wCB/C), and Changeups (wCH/C). These are the most common pitches thrown in the Major Leagues.

Since the baseball has been altered, it could be that players are just focusing on hitting the fastball and other hard pitches in each pitcher’s repertoire such as hard sliders and changeups. Pitchers nowadays are throwing heat and paired up with a bouncier ball can mean more emphasis on success against fastballs or types of pitches or 90 mph.

ggplot(data = juiced_ball_era) +
  geom_jitter(mapping = aes(x = `wFB/C`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `wFB/C`, y = `wRC+`), se = FALSE) +
  xlab("wFB/C") +
  ggtitle("wFB/C vs. wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = filter(juiced_ball_era, `wRC+` >= 115)) +
  geom_jitter(mapping = aes(x = `wFB/C`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `wFB/C`, y = `wRC+`), se = FALSE) +
  xlab("wFB/C") +
  ggtitle("wFB/C vs. Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = juiced_ball_era) +
  geom_jitter(mapping = aes(x = `wSL/C`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `wSL/C`, y = `wRC+`), se = FALSE) +
  xlab("wSL/C") +
  ggtitle("wSL/C vs. wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = filter(juiced_ball_era, `wRC+` >= 115)) +
  geom_jitter(mapping = aes(x = `wSL/C`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `wSL/C`, y = `wRC+`), se = FALSE) +
  xlab("wSL/C") +
  ggtitle("wSL/C vs. Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = juiced_ball_era) +
  geom_jitter(mapping = aes(x = `wCB/C`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `wCB/C`, y = `wRC+`), se = FALSE) +
  xlab("wCB/C") +
  ggtitle("wCB/C vs. wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = filter(juiced_ball_era, `wRC+` >= 115)) +
  geom_jitter(mapping = aes(x = `wCB/C`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `wCB/C`, y = `wRC+`), se = FALSE) +
  xlab("wCB/C") +
  ggtitle("wCB/C vs. Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = juiced_ball_era) +
  geom_jitter(mapping = aes(x = `wCH/C`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `wCH/C`, y = `wRC+`), se = FALSE) +
  xlab("wCH/C") +
  ggtitle("wCH/C vs. wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = filter(juiced_ball_era, `wRC+` >= 115)) +
  geom_jitter(mapping = aes(x = `wCH/C`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `wCH/C`, y = `wRC+`), se = FALSE) +
  xlab("wCH/C") +
  ggtitle("wCH/C vs. Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


As expected there is a positive relationship between wFB/C and wRC+ nothing the importance of having success against a fastball which is the type of pitch you are going to see most in a game. The lowest point is at -1 wFB/C. Players below this threshold are most likely not able to stay in the Major Leagues. This is different compared to other pitches that typically have the lowest point at around -2 to -2.5 in their respective pitch values. Above average players range from 0 to 2.5 wFB/C. wSL/C and wRC+ share a positive relationship until the 1 to 3 wSL/C range where it dips for an outlier. Most of the points in this plot are concentrated in between -1 and 0.5 meaning many players including those with above average wRC+ have been less successful against sliders. wCB/C and wRC+ also share a positive, but flatter relationship. Looking at this data you need to be at least average (0) against curveballs to be successful in the MLB or be able to stay in it. wCH/C against wRC+ is a bit curvy with many points congregating between -0.5 to 0.5 wCH/C. If I have not mentioned this before, the point with 180 wRC+ is Mike Trout, arguably the best player the game has ever seen. For above average players, it is evident that you need to be at least average against 3 out of the 4 pitches given here.

Baseball Savant
Launch Angle
Launch Angle represents the vertical angle at which the ball leaves a player’s bat after being struck. In today’s game, players are training themselves to hit the ball at 10 to 25 degrees typically for optimal results.

ggplot(data = juiced_ball_era) +
  geom_point(mapping = aes(x = `launch_angle`, y = `wRC+`)) +
  geom_smooth(mapping = aes(x = `launch_angle`, y = `wRC+`), se = FALSE, color = "red") +
  xlab("Launch Angle") +
  ylab("wRC+") +
  ggtitle("Launch Angle vs. wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = filter(juiced_ball_era, `wRC+` >= 115), mapping = aes(x = `launch_angle`, y = `wRC+`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("Launch Angle") +
  ylab("wRC+") +
  ggtitle("Launch Angle vs. Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


Most of the players with above average wRC+ possess a mean launch angle between 10 and 20 degrees. All the players in this dataset are scattered between 5 and 20 degrees. Both relationships are flat and basically tells us that players vary in launch angles and performance measures.

In addition, I also ran launch angle against xwOBA in Baseball Savant. I calculated the mean xwOBA value from the average of each season from 2016 to 2019 to distinguish those players who were above average in this rate statistic.

ggplot(juiced_ball_era, mapping = aes(x = `launch_angle`, y = `xwoba`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("Launch Angle") +
  ylab("xwOBA") +
  ggtitle("Launch Angle vs. xwOBA") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = filter(juiced_ball_era, `xwoba` >= .320), mapping = aes(x = `launch_angle`, y = `xwoba`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("Launch Angle") +
  ylab("xwOBA") +
  ggtitle("Launch Angle vs. Above Average xwOBA") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


These two plots show basically the same results as the previous two against wRC+, however, these are a bit more on the positive side regarding their relationships. This can be due to the fact that this xwOBA takes launch angle into consideration.

ggplot(data = juiced_ball_era) +
  geom_histogram(mapping = aes(x = `launch_angle`), binwidth = 5) +
  xlab("Launch Angle") +
  ggtitle("Launch Angle Distribution") +
  theme(plot.title = element_text(hjust = 0.5))


ggplot(data = filter(juiced_ball_era, `wRC+` >= 115)) +
  geom_histogram(mapping = aes(x = `launch_angle`), binwidth = 5) +
  xlab("Launch Angle") +
  ggtitle("Launch Angle Distribution Among Players with Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))


The histograms show that elite ballplayers fall between 10% and 20% distributing most of the players in the 15% range. Notice that in the histogram with all players the number of those with 10% is very high. This could mean that what separates great from average are launch angles above 10% hence tending to lift the ball more in the air.

Launch Speed
Launch speed or Exit Velocity measures the speed of the baseball as it comes off the bat, immediately after a batter makes contact. This tends to be similar with Hard% as the harder you hit the ball the more likely you will be successful in this sport. MLB players have the ability to hit balls at very high exit velocities but it is more valuable to have a decent average exit velocity to stay at the top.

ggplot(data = juiced_ball_era, mapping = aes(x = `launch_speed`, y = `wRC+`)) +
  geom_jitter() +
  geom_smooth(se = FALSE) +
  xlab("Launch Speed") +
  ylab("wRC+") +
  ggtitle("Launch Speed vs. wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = filter(juiced_ball_era, `wRC+`>= 115), mapping = aes(x = `launch_speed`, y = `wRC+`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("Launch Speed") +
  ylab("wRC+") +
  ggtitle("Launch Speed vs. wRC+") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(juiced_ball_era, mapping = aes(x = `launch_speed`, y = `xwoba`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("Launch Speed") +
  ylab("xwOBA") +
  ggtitle("Launch Speed vs. xwOBA") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = filter(juiced_ball_era, `xwoba` >= .320), mapping = aes(x = `launch_speed`, y = `xwoba`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("Launch Speed") +
  ylab("xwOBA") +
  ggtitle("Launch Speed vs. Above Average xwOBA") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


With the exception of Launch Speed against players with wRC+ of 115 or more, all of these plots show a positive relationship meaning the more average exit velocity the more valuable you are in rate statistics measures such as xwOBA and wRC+.

ggplot(data = juiced_ball_era) +
  geom_histogram(mapping = aes(x = `launch_speed`), binwidth = 2.5) +
  xlab("Launch Speed") +
  ggtitle("Launch Speed Distribution") +
  theme(plot.title = element_text(hjust = 0.5))


ggplot(data = filter(juiced_ball_era, `wRC+` >= 115)) +
  geom_histogram(mapping = aes(x = `launch_speed`), binwidth = 2.5) +
  xlab("Launch Speed") +
  ggtitle("Launch Speed Distribution Among Players with Above Average wRC+") +
  theme(plot.title = element_text(hjust = 0.5))


The histograms allow us to see that,typically, a mean launch speed of 90 mph and above separates above average players from subpar players. Several players disappeared from the first histogram from the 87.5 MPH bar meaning from there and below it is more difficult to be considered a great player in terms of wRC+.

Batted Ball Statistics and ISO
To see the relationship between ISO and LD%, GB%, and FB%, I created these plots to solidify the notion that lifting the from that 10 to 35 degree launch angles can clearly make an impact in a players’ power numbers.

juiced_ball_era$`HR/FB` = as.numeric(gsub("[\\%,]", "", juiced_ball_era$`HR/FB`)) 

ggplot(data = juiced_ball_era, mapping = aes(x = `FB%`, y = `ISO`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("FB%") +
  ylab("ISO") +
  ggtitle("FB% vs. ISO") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = filter(juiced_ball_era, `wRC+` >= 115), mapping = aes(x = `FB%`, y = `ISO`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("FB%") +
  ylab("ISO") +
  ggtitle("FB% vs. ISO") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = juiced_ball_era, mapping = aes(x = `LD%`, y = `ISO`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("LD%") +
  ylab("ISO") +
  ggtitle("LD% vs. ISO") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = filter(juiced_ball_era, `wRC+` >= 115), mapping = aes(x = `FB%`, y = `ISO`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("LD%") +
  ylab("ISO") +
  ggtitle("LD% vs. ISO") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = juiced_ball_era, mapping = aes(x = `GB%`, y = `ISO`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("GB%") +
  ylab("ISO") +
  ggtitle("GB% vs. ISO") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


ggplot(data = filter(juiced_ball_era, `wRC+` >= 115), mapping = aes(x = `GB%`, y = `ISO`)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("GB%") +
  ylab("ISO") +
  ggtitle("GB% vs. ISO") +
  theme(plot.title = element_text(hjust = 0.5))
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'


FB% and LD% have positive relationships with ISO. The more you lift the ball or hit the ball on a line, the better chance you have at going for extra bases. While higher GB% does the opposite posing a negative relationship with ISO as groundballs tend to be caught more often or stopped by an infielder or outfielder for a single most of the time if it is a hit.

Conclusion
During the Juiced Ball era, there have been many changes to the game besides the baseball. Players are revamping their swings using technology to tweak their mechanics to create steeper launch angles. Defensive shifts are used constantly and pitchers are throwing harder than ever before making it harder to make contact. Now, it depends on how players approach the game with these things in mind. The majority of above average players walked 8% or more and struck out 20% and over, similar to the below average players.These players hit Fly Balls 35%-50% of the time, less than 45% for Ground Balls, and more than 20% for Line Drives. All players were susceptible to pulling the ball 40% of the time, 25% to the opposite field, and 35% to the middle of the field. This average level across most observations shows that, despite the number of defensive shifts employed in the past few seasons, hitters tend to regress to these mean levels. In terms of quality of contact, the best out of this group hit at 40% to 50% Hard%, 35% to 48% Med%, and 10% to 20% which is above average. Using Pitch Values, I was able to see that players need to be at the very least average against 3 out of the 4 main pitches with emphasis on fastballs. Players with 10 to 25 degree launch angle and launch speeds of 90 MPH and above tend to generate the most offense. It was also proven that ISO numbers are better when hitters hit more Line Drives and Fly Balls. Later on I can compare the performance of players before 2016 and after Statcast had been created.
