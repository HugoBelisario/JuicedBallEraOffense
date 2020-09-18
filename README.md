# Juiced Ball Era Offense

## Final Project Report

Today, in Major League Baseball, it is clear that the composition of the ball has been altered to promote more offense in the form of extra base hits (doubles, triples, home runs). This has affected the run environment drastically while also driving up strikeout rates. Although I have a basic understanding of today’s offensive approach in professional baseball, I am curious to see what the most successful hitters do while observing what others lack in hitting the new baseball.What kind of approach do these hitters have against the elite pitching we are witnessing in the game today? Analysts are obsessed with terms like launch angle and exit velocity, however, these numbers solely cannot explain how players are surviving and thriving in these conditions. Are hitters having more success hitting certain pitches? Are players pulling the ball more instead of spraying the baseball to all parts of the field? Are mediocre hitters that way because of softer contact on the baseball? What range of launch angle is ideal to lift the ball up for more opportunities to succeed? We know the best hitters lift the ball constantly, but at what rates? Those are some of the many topics I plan to explore with this data.

The data provided by FanGraphs are comprised of standard and advanced statistics for position players or batters with a minimum of 1000 plate appearances during the so-called “juiced ball” era, specifically from 2016 to 2019 regular seasons. In addition, there are data on the particular pitches these batters faced and the way they made contact on each pitch with batted ball data. This will be joined by statistics that evaluate how valuable these players are and how good they have been in the past four seasons.

Baseball Savant’s Statcast search has information on all pitches thrown since the technology was implemented in 2014. In this case, I am looking at characteristics of the baseballs that were hit by those in the FanGraphs list of position players.I anticipate to join the data from Baseball Savant because it provides data not available on FanGraphs such as launch angle, launch speed, and weighted On-Base Average using launch speed/angle.

## Key Rate Statistics

### wRC+
Weighted Runs Created Plus (wRC+) is a rate statistic which attempts to credit a hitter for the value of each outcome rather than treating all hits or times on base equally, while also controlling for park effects and the current run environment. wRC+ is scaled so that league average is 100. In this EDA, I will use wRC+ and Above Average wRC+ to see discover relationships between this Batted Ball, Pitch Value, Advanced statistics.

### wOBA and xwOBA
Weighted On-Base Average (wOBA) is a rate statistic which attempts to credit a hitter for the value of each outcome rather than treating all hits or times on base equally. Expected Weighted On-base Average (xwOBA) is formulated using exit velocity, launch angle and, on certain types of batted balls, Sprint Speed.

### ISO
Isolated Power is the average number of extra bases per at bat, calculated several ways such as SLG minus AVG. This will not be used as often since it is not a definitive statistic when looking at the true value of a player.

### Walk and Strikeout Rates
BB% (Walk Percentage) is the frequency with which the batter has walked, calculated as walks divided by plate appearances. Ever since the “Moneyball” revolution, the ability to get on base by drawing walks has displayed exeptional plate discipline and been valued more by MLB organizations. However, now that players are aware of the “juiced ball”, I wondered if they were sacrificing walks for more opportunities to put the ball in play. A BB% of 10% and 15% are considered above average and excellent, respectively.

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/BB%25vswRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/BB%25vsAAwRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/BB%25vswOBA.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/BB%25vsAAwOBA.png)

Observing the relationships between both wRC+ and wOBA with BB%, we see that there are positive relationships. However, most of the players have average or below average rates concentrating in between 5% and 10%. It seems as if the more you walk, the more you are valuable in terms of wOBA and wRC+. When zooming into players with above average levels of wOBA and wRC+, the relationship is somewhat positive but much more indeterminate. Players who are overall very good are usually above 8% which proves that great hitters walk at least 10 times per 100 AB.

Previous to this new revolution of elite pitching and launch angles propelling home run rates, striking out constantly was scorned by organizations and fans. Nowadays, many players considered the best in the game are also those who strike out the most. The elite pitching has also made it harder to make contact.

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/K%25vswRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/K%25vsAAwRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/K%25vswOBA.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/K%25vsAAwOBA.png)

These plots prove that all types of hitters whether they are below, at, or above average in wRC+ and wOBA can have varying strikeout rates. Most of the players being observed are at average or worse levels (20% and over).

## Batted Ball

### Batted Ball Statistics
Line Drive Percentage (LB%) is the percentage of a batter’s balls in play that are line drives. Ground Ball Percentage (GB%) is the percentage of a batter’s balls in play that are groundballs. Fly Ball Percentage (FB%) is the percentage of a batter’s balls in play that are fly balls. There is no ideal batted ball distribution, but batters who hit a lot of line drives typically perform better than hitters who hit lots of fly balls or ground balls. Line drives go for hits most often, ground balls go for hits more often than fly balls, and fly balls are more productive than ground balls when they do go for hits (i.e. extra base hits). During this wave of home runs, defensive shifts, and strikeouts, players tend to lift the ball more often.

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/BattedBallPlayersvswRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/BattedBallPlayervsAAwRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/BattedBallDistPlayers.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/BattedBallDistPlayerAAwRC%2B.png)


Observing this data, one can infer that players tend to hit Fly Balls between 30% and 45% of the time, Ground Balls around 35% to 50% of the time, and Line Drives around 16% to 25% of the time because it is the most difficult to do out of the three. For above average ballplayers, they tend to hit Fly Balls 35% to 50%, less than 45% Ground Balls, and more than 20% Line Drives. All of these levels put these players above league average.

### Batted Ball Direction
Pull Percentage (Pull%) is the percentage batted balls hit to the pull field. The field is divided up into three equal slices with the pull field being defined as the right field for left-handed hitters and left field for right-handed hitters. Center Percentage (Cent%) is the percentage batted balls hit to the middle of the field. Opposite Field Percentage (Oppo%) is the percentage of batted balls hit to the opposite field. The opposite field is left field for left-handed hitters and right field for right-handed hitters.

Using these statistics, we can infer that hitters in this era are pulling the ball less and spraying the ball to all parts of the field as an adjustment to the overwhelming number of defensive shifts over the past several seasons or sticking to pulling the ball since they are usually trying to lift it over the heads of the players.

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/BattedBallDirectionvswRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/BattedBallDirectionvsAAwRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/BattedBallDirectionAAwRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/BattedBallField.png)

From the scatter plots, one can say that the majority of players in this dataset tend to pull the ball around 30% to 50% of the time they put balls in play, while centering the ball and hitting balls the other way follow along with a range of 30% to 40% and 16% to 35%, respectively. This seems to be true among all players. The histogram shows that overall players send baseballs to the center of the ballpark about 35% of the time, to the opposite field at 25%, and to pull side 40% of the time. These are considered average levels for each category.

### Quality of Contact
The notion of quality of contact is that the harder you hit the ball, the more of a chance it has to be a hit. Of course, there are other factors go into a ball becoming a hit such as ball placement and the defensive alignment. This can be a measure of true talent and can determine the direction of a player’s luck during a season. It takes two to three years for batted ball luck to even out. Here, we have four seasons enough to make certain inferences.

Soft% is the percentage of soft-hit batted balls. Med% is the percentage of medium-hit batted balls. Hard% is the percentage of hard-hit batted balls.

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/BattedBallvswRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/BattedBallDistwRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/BattedBallDist.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/BattedBallDistAAwRC%2B.png)

Med% and Soft% share negative relationships with wRC+ proving the more you hit at those levels the less you are able to contribute offensively while hitting at Hard% increases your likelihood of being an above average player in wRC+ levels. There is a positive relationship between Hard% and wRC+. For players with above average wRC+ they are usually at around 40% to 50% Hard% which is considered excellent, 35% to 48% Med% considered great, and 10% to 20% which is just about average and above.

## Pitch Value
Pitch values attempts to find out how well a batter has hit against a certain pitch. They make use of the changes in average run expectancy from one count to another and while the changes in run expectancy between an 0-0 count and a 0-1 or 1-0 count are insignificant, when added up over the course of the season, you can get an idea of which pitch a hitter was best against. A score of zero is average, with negative scores being below average and positive scores being above average for both hitters.

wFB/C denotes the number of runs above average a batter was against a fastball per 100 pitches. The same applies to Sliders (wSL/C), Curveballs (wCB/C), and Changeups (wCH/C). These are the most common pitches thrown in the Major Leagues.

Since the baseball has been altered, it could be that players are just focusing on hitting the fastball and other hard pitches in each pitcher’s repertoire such as hard sliders and changeups. Pitchers nowadays are throwing heat and paired up with a bouncier ball can mean more emphasis on success against fastballs or types of pitches or 90 mph.

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/FB:CvswRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/FB:CvsAAwRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/SL:CvswRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/SL:CvsAAwRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/CB:CvswRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/CB:CvsAAwRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/CH:CvswRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/CH:CvsAAwRC%2B.png)

As expected there is a positive relationship between wFB/C and wRC+ nothing the importance of having success against a fastball which is the type of pitch you are going to see most in a game. The lowest point is at -1 wFB/C. Players below this threshold are most likely not able to stay in the Major Leagues. This is different compared to other pitches that typically have the lowest point at around -2 to -2.5 in their respective pitch values. Above average players range from 0 to 2.5 wFB/C. wSL/C and wRC+ share a positive relationship until the 1 to 3 wSL/C range where it dips for an outlier. Most of the points in this plot are concentrated in between -1 and 0.5 meaning many players including those with above average wRC+ have been less successful against sliders. wCB/C and wRC+ also share a positive, but flatter relationship. Looking at this data you need to be at least average (0) against curveballs to be successful in the MLB or be able to stay in it. wCH/C against wRC+ is a bit curvy with many points congregating between -0.5 to 0.5 wCH/C. If I have not mentioned this before, the point with 180 wRC+ is Mike Trout, arguably the best player the game has ever seen. For above average players, it is evident that you need to be at least average against 3 out of the 4 pitches given here.

## Baseball Savant
### Launch Angle
Launch Angle represents the vertical angle at which the ball leaves a player’s bat after being struck. In today’s game, players are training themselves to hit the ball at 10 to 25 degrees typically for optimal results.

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/LaunchAnglevswRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/LaunchAnglevs.AAwRC%2B.png)

Most of the players with above average wRC+ possess a mean launch angle between 10 and 20 degrees. All the players in this dataset are scattered between 5 and 20 degrees. Both relationships are flat and basically tells us that players vary in launch angles and performance measures.

In addition, I also ran launch angle against xwOBA in Baseball Savant. I calculated the mean xwOBA value from the average of each season from 2016 to 2019 to distinguish those players who were above average in this rate statistic.

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/LaunchAnglevswOBA.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/LaunchAnglevsAAwOBA.png)

These two plots show basically the same results as the previous two against wRC+, however, these are a bit more on the positive side regarding their relationships. This can be due to the fact that this xwOBA takes launch angle into consideration.

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/LaunchAngleDist.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/LaunchAngleDistvsAAwRC%2B.png)

The histograms show that elite ballplayers fall between 10% and 20% distributing most of the players in the 15% range. Notice that in the histogram with all players the number of those with 10% is very high. This could mean that what separates great from average are launch angles above 10% hence tending to lift the ball more in the air.

## Launch Speed
Launch speed or Exit Velocity measures the speed of the baseball as it comes off the bat, immediately after a batter makes contact. This tends to be similar with Hard% as the harder you hit the ball the more likely you will be successful in this sport. MLB players have the ability to hit balls at very high exit velocities but it is more valuable to have a decent average exit velocity to stay at the top.

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/LaunchSpeedvswRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/LaunchSpeedvsAAwRC%2B.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/LaunchSpeedvsxwOBA.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/LaunchSpeedvsAAwOBA.png)

With the exception of Launch Speed against players with wRC+ of 115 or more, all of these plots show a positive relationship meaning the more average exit velocity the more valuable you are in rate statistics measures such as xwOBA and wRC+.

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/LaunchSpeedDistribution.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/LaunchSpeedDistAAwRC%2B.png)

The histograms allow us to see that,typically, a mean launch speed of 90 mph and above separates above average players from subpar players. Several players disappeared from the first histogram from the 87.5 MPH bar meaning from there and below it is more difficult to be considered a great player in terms of wRC+.

## Batted Ball Statistics and ISO
To see the relationship between ISO and LD%, GB%, and FB%, I created these plots to solidify the notion that lifting the from that 10 to 35 degree launch angles can clearly make an impact in a players’ power numbers.

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/FB%25vsISO2.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/FB%25vsISO1.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/LD%25vsISO2.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/LD%25vsISO1.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/GB%25vsISO2.png)

![alt text](https://github.com/HugoBelisario/JuicedBallEraOffense/blob/master/Visualizations/GB%25vsISO1.png)

FB% and LD% have positive relationships with ISO. The more you lift the ball or hit the ball on a line, the better chance you have at going for extra bases. While higher GB% does the opposite posing a negative relationship with ISO as groundballs tend to be caught more often or stopped by an infielder or outfielder for a single most of the time if it is a hit.

## Conclusion
During the Juiced Ball era, there have been many changes to the game besides the baseball. Players are revamping their swings using technology to tweak their mechanics to create steeper launch angles. Defensive shifts are used constantly and pitchers are throwing harder than ever before making it harder to make contact. Now, it depends on how players approach the game with these things in mind. The majority of above average players walked 8% or more and struck out 20% and over, similar to the below average players.These players hit Fly Balls 35%-50% of the time, less than 45% for Ground Balls, and more than 20% for Line Drives. All players were susceptible to pulling the ball 40% of the time, 25% to the opposite field, and 35% to the middle of the field. This average level across most observations shows that, despite the number of defensive shifts employed in the past few seasons, hitters tend to regress to these mean levels. In terms of quality of contact, the best out of this group hit at 40% to 50% Hard%, 35% to 48% Med%, and 10% to 20% which is above average. Using Pitch Values, I was able to see that players need to be at the very least average against 3 out of the 4 main pitches with emphasis on fastballs. Players with 10 to 25 degree launch angle and launch speeds of 90 MPH and above tend to generate the most offense. It was also proven that ISO numbers are better when hitters hit more Line Drives and Fly Balls. Later on I can compare the performance of players before 2016 and after Statcast had been created.
