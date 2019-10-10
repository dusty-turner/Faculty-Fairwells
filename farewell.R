library(tidyverse)
library(lubridate)
library(zoo)
library(forcats)

farewell = read_csv("farewell.csv")
farewell

farewell = 
farewell %>% 
  mutate(totaltime = TimeEnd- TimeStart) %>%
  mutate(mysum = cumsum(as.numeric(totaltime))) %>%
  mutate(mysum = as.integer(mysum))
  # mutate(mysum = rollsum(totaltime,2, fill = 0, align = "right"))
# present = farewell$Presenter

# farewell %>%
#   ggplot(aes(y=order,x=mysum/60, color = as.numeric(totaltime))) +
#   geom_step() +
#   scale_y_continuous(breaks = 1:19, labels = present) +
#   scale_x_continuous(breaks = c(0,25,50,75,100,125,150),labels = c(0,25,50,75,100,125,150)) +
#   xlab("Minutes") +
#   ylab("Presenter") +
#   theme(legend.position="none")
# 
# 
# as.POSIXct(farewell$`Time End`)
# 
# difftime(farewell$`Time End`,farewell$`Time Start`)
# 
# 
# as_datetime(farewell$tims) %>% minute()
# 
# 
# factor(farewell$Presenter)
# 
# rownames(farewell) = farewell$Presenter
# 
# 
# farewell$order = c(1:19)
# fct_reorder(farewell$Presenter, farewell$TimeStart)
# # farewell$Presenter_ordered <- factor(data$Presenter,levels=c("Hartley", "Yankovich", "Watts", "LaPorte", "Bacon", "Lindquist", "Pulleyblank", "Wattenberg", "Charbenau", "Boucher", "Arney"))

farewell %>% 
ggplot(aes(x=TimeStart, y = fct_reorder(farewell$Presenter, farewell$TimeStart))) +
  geom_segment(aes(x=TimeStart, xend=TimeEnd, yend=Presenter, color = Presented),size=12) +
  geom_text(aes(label = Presented, x=(TimeEnd+TimeStart)/2), size = 2.5) +
  theme(legend.position = "none") +
  xlab("Minutes") +
  ylab("Presenter") +
  ggtitle("Who Talks Most: An Army Math Awards Presentation Story") +
  theme_light() +
  theme(legend.position="none") 

class(farewell$TimeStart)

# farewell$ordered = factor(farewell$Presenter, levels = c("Hartley", "Yankovich", "Watts", "LaPorte", "Bacon", "Lindquist", "Pulleyblank", "Wattenberg", "Charbenau", "Boucher", "Arney"))

