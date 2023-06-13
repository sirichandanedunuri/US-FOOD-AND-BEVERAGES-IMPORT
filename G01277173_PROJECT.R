install.packages("package")
install.packages("readr")
install.packages("RColorBrewer")
library(RColorBrewer)
library(tidyverse)
library(readr)
library(ggmap)
library(plyr)
library(sf)
library(ggplot2)
library(rworldmap)
library(plotly)

# What are the major source countries of imports to United States?
ImportCountries <- read_csv("C:/Users/sirir/OneDrive/Desktop/AIT 580/AIT 580 PROJECT/ImportCountries.csv")
view(ImportCountries)
SourceCountries <- joinCountryData2Map( ImportCountries,nameJoinColumn="Countries",
                                        joinCode="NAME" )
colourPalette <- RColorBrewer::brewer.pal(9,'OrRd') 
Plot <- mapCountryData( SourceCountries,
                        nameColumnToPlot='TotalExpenditurespentfrom1999to2017',
                        mapTitle="Major Source Countries of Imports for United States from 1999 to 2017",
                        catMethod='fixedWidth', borderCol="black", lwd=1,
                        colourPalette=colourPalette,
                        numCats=9) 

do.call(addMapLegend, c(Plot
                        ,legendLabels="all"
                        ,legendWidth=0.5
                        ,legendIntervals="TotalExpenditurespentfrom1999to2017"))



# How much expenditure is spent on import of each food type from 1999 to 2017?
ImportData <- read_csv("ImportsData.csv")
View(ImportData)
ImportData3 <- aggregate(ImportData$Import_Value_In_MillionDollars, by=list(Food_Type=ImportData$Food_Type,Year=ImportData$Year), FUN=sum)
ImportData3
colnames(ImportData3) <- c("Food_Type","Year", "Import_Value")
ggplot(ImportData3, mapping=aes(x = Year,y=Import_Value,color=Food_Type)) + 
  geom_point(mapping=aes(x = Year,y=Import_Value),size=1.5) +
  geom_line(mapping=aes(x = Year,y=Import_Value),size=0.7) +
  labs(x = "Year",
       y = "Value spent on different food types(Million Dollars)",
       title = "Expenditure on different food categories by United States from 1999 to 2017", fill = "Food_Type")+
  theme(
    plot.title = element_text(color="royalblue4" , size=18, face="bold",hjust = 0.5),
    axis.title.x = element_text(size=14, face="bold"),
    axis.title.y = element_text( size=14, face="bold")
  ) +
  theme(legend.position = 'top')


# How much expenditure is spent on imports per year from 1999 to 2017?
ImportData4 <- aggregate(ImportData$Import_Value_In_MillionDollars, by=list(Year=ImportData$Year), FUN=sum)
ImportData4 
colnames(ImportData4) <- c("Year","Value_Spent_on_Imports")
myplot <- ggplot(ImportData4, mapping=aes( y=Value_Spent_on_Imports,x =Year)) + 
  geom_point(mapping=aes(x =Year,y=Value_Spent_on_Imports),color="red",size=1.2) +
  geom_smooth(method = loess,mapping=aes(x =Year,y=Value_Spent_on_Imports)) +
  ggtitle("Expenditure on Imports of Food and Beverages by United States from 1999 to 2017") +
  xlab("Year") + ylab("Value spent on Imports(Million Dollars)") + theme_gray() +
  scale_y_continuous(labels = function(y) format(y, scientific = FALSE)) 
myplot + theme(
  plot.title = element_text(color="royalblue4" , size=18, face="bold",hjust = 0.5),
  axis.title.x = element_text(size=14, face="bold"),
  axis.title.y = element_text( size=14, face="bold")
) 


# How much quantity of food and beverages are imported to the country?

ImportData6 <- aggregate(ImportData$ImportQuantity_In_1000metrictons, by=list(Year=ImportData$Year), FUN=sum)
ImportData6
colnames(ImportData6) <- c("Year","Quantity_of_Imports")
myplot <- ggplot(ImportData6, aes( y=Quantity_of_Imports,x =Year)) + 
  geom_bar(position="stack", stat="identity") + 
  ggtitle("Volume of United States Imports by Food Type from the year 1999 to 2017") +
  xlab("Year") + ylab("Quantity of Imports(1000 metric tons)") + theme_gray()+ 
  geom_col(fill ="steelblue") 
myplot + theme(
  plot.title = element_text(color="royalblue4" , size=18, face="bold",hjust = 0.5),
  axis.title.x = element_text(size=14, face="bold"),
  axis.title.y = element_text( size=14, face="bold")) + 
  geom_line(mapping=aes(x = Year,y=Quantity_of_Imports),binwidth=2,color="red",size=1.2);


# What is the Annual growth percentage of each food type from 1999 to 2017?
box_fills <- c("steelblue","cadetblue","darkseagreen","darkslategray1","Coral","burlywood","beige",
               "azure4","cyan4","aquamarine","mistyrose","plum4","darksalmon","tan4")
ggplot(ImportData, aes(fill=Food_Type, y=Annual_Growth_In_ImportQuantity, x=Year)) + 
  geom_bar(stat="identity") + 
  scale_fill_manual(values = box_fills) +
  geom_text(aes(label = Annual_Growth_In_ImportQuantity),size = 2, hjust = 0.5, vjust = 2, position="stack")+
  xlab("Year") + ylab("Annual Growth Percent") + 
  ggtitle("Annual Growth Percent of Food Categories from 1999 to 2017")+
  theme(plot.title = element_text(hjust=0.5,size = 10, face = "bold"),legend.position = 'top')+
  theme(
    plot.title = element_text(color="royalblue4" , size=18, face="bold",hjust = 0.5),
    axis.title.x = element_text(size=14, face="bold"),
    axis.title.y = element_text( size=14, face="bold")) 




