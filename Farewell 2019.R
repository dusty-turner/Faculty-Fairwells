library(tidyverse)
library(lubridate)
library(ggrepel)

farewell = read_csv("farewell2019.csv")

farewell = 
  farewell %>% 
  mutate(totaltime = TimeEnd- TimeStart) %>%
  mutate(mysum = cumsum(as.numeric(totaltime))) %>%
  mutate(mysum = as.integer(mysum)) %>%
  mutate(Team = paste(Presenter,Receiver,sep = "/")) %>%
  # mutate(date = paste(Day,TimeStart)) %>%
  # mutate(TimeStart = mdy_hms(date)) %>%
  # mutate(date = paste(Day,TimeEnd)) %>%
  # mutate(TimeEnd = mdy_hms(date))
  filter(Receiver!="Wolberg")

farewell %>%
  select(date,TimeStart)


farewell %>% 
  group_by(Speaker) %>%
  mutate(time = min(TimeStart)) %>%
  ungroup() %>%
  ggplot(aes(x=TimeStart, y = fct_reorder(Team, Order))) +
  geom_segment(aes(x=TimeStart, xend=TimeEnd, yend=Team, color = Speaker),size=12) +
  geom_label_repel(aes(label = Speaker, x=(TimeEnd+TimeStart)/2), size = 2.5) +
  theme(legend.position = "none") +
  xlab("Minutes") +
  ylab("Presenter") +
  ggtitle("Who Talks Most?: An Army Math Awards Presentation Story") +
  theme_light() +
  theme(legend.position="none") 

