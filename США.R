

terror.USA <- subset(terror, country_txt == "United States")
write.csv(terror.USA, "The Global Terrorism Database - USA 1970-2017.csv")
terror.USA <- read.csv("The Global Terrorism Database - USA 1970-2017.csv")
terror.count <- subset(terror.USA, select = c(iyear, nkill))
terror.count$nkill[is.na(terror.count$nkill)] <- 0
terror.count$nacts <- 1

terror.count <- summarise(group_by(terror.count, iyear), sum(nkill), sum(nacts))
terror.count <- gather(terror.count, key, value, -iyear)
terror.count$key <- as.factor(terror.count$key)
levels(terror.count$key) <- c("теракты", "убитые")



terror.US <- subset(terror.USA, select = c(iyear))
terror.US <- count(terror.US, iyear)
terror.US$Country <- "США"
ggplot(terror.US, aes(x = iyear, y = n, colour = Country))+
  geom_line()+
  geom_point()+
  ggtitle("Террористическая активность в США") +
  labs(x = "\n
       Источник: Университет Мэриленда", 
       y = "количество", colour = " ")+
  #theme_fivethirtyeight()+
  theme_fivethirtyeight()