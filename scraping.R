#Scraping 


baseurl <- "https://www.theguardian.com/environment/cop26-glasgow-climate-change-conference-2021?page="
pageurl <- paste0(seq(1, 33, 1))
pages_list <- paste0(baseurl, pageurl)
pages_list[1:5] #33 pages until 18 oct = 2 weeks before cop --> I LOOKED AT IT BY HAND, IS THERE A WAY TO LOOK INTO IT AUTOMATICALLY? (NOT URGENT)
headlineslist <- c()
dateslist <- c()

#all_headlines = list()
for (page in pages_list){
  url_parsed <- read_html(page)
  
  headings_nodes <- html_elements(url_parsed, xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "fc-date-headline", " " ))] | //*[contains(concat( " ", @class, " " ), concat( " ", "js-headline-text", " " ))]')
  
  headlines <- html_text2(headings_nodes)
  headlineslist <- append(headlineslist, headlines)
  #all_headlines <- append(all_headlines, headlineslist)
}

headlineslist <- unique(headlineslist)

# We iterate over the length of headlineslist, if we detect a match of "2021" in the headlineslist we recognise it as a date, and copy it into our dateslist. Note we keep the same position the date had in headlines. In the case were we don't find a date in the headlineslist, we fill the spot in dateslist with the previous entry (dateslist[i] <- dateslist[i-1]).

for (i in 1:length(headlineslist)){
  if(grepl("2021", headlineslist[i]) == TRUE){
    dateslist[i] <- headlineslist[i]
  }
  else if (grepl("2021", headlineslist[i]) == FALSE) {
    dateslist[i] <- dateslist[(i-1)]
  }
}

# First combining both our lists into a dataframe, such that each headline is associated with a date, and then removing all rows in which headlines = dates since we no longer need these for reference.  

cop26 <- cbind(as.data.frame(headlineslist), as.data.frame(dateslist)) %>% 
  filter(headlineslist != dateslist) %>% 
  rename("Headlines" = "headlineslist", "Dates" = "dateslist")
