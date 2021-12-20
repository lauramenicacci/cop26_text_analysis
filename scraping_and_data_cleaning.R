################################################################################
# Scraping
################################################################################

baseurl <- "https://www.theguardian.com/environment/cop26-glasgow-climate-change-conference-2021?page="
pageurl <- paste0(seq(1, 33, 1))
pages_list <- paste0(baseurl, pageurl)
pages_list[1:5] #33 pages until 18 oct = 2 weeks before cop 
headlineslist <- c()

################################################################################
# If you would like to download the scraped headlines, execute the code below,
# but don't forget your manners!
################################################################################
# criteria for polite code:
# only download if file does not exist yet
# pause between queries
# stay identifiable with "From" header field


#folder <- "C:/Users/laura/Desktop/guardian_htmls/"
#dir.create(folder)
#for (i in 1:length(pages_list)) {headlineslist[i] <- paste0("page", i)}
#
#for (i in 1:length(pages_list))  { if (!file.exists(paste0(folder, headlineslist[i]))) {  
#  try(download.file(pages_list[i], 
#                    destfile = paste0(folder, headlineslist[i], ".html"), 
#                    header = c(`User-Agent` = R.Version()$version.string, `From` = "212166@hertie-school.org")))
#  Sys.sleep(runif(1, 1, 2)) 
#}}
#
#list.files(folder, pattern = ".*",full.names = TRUE)


################################################################################

for (pages_list in folder){
  url_parsed <- read_html(pages_list)
  
  headings_nodes <- html_elements(url_parsed, xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "fc-date-headline", " " ))] | //*[contains(concat( " ", @class, " " ), concat( " ", "js-headline-text", " " ))]')
  
  headlines <- html_text2(headings_nodes)
  headlineslist <- append(headlineslist, headlines)
  #all_headlines <- append(all_headlines, headlineslist)
}

################################################################################
# Data Cleaning
################################################################################

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
  rename("Headlines" = "headlineslist", 
         "Dates" = "dateslist")

cop26$Dates<- as.Date(dmy(cop26$Dates) , format = "%d %B %Y")

customized_stopwords<- add_row(stop_words , word= c("cop26", "glasgow","climate","change")) #crisis

words_list<- cop26 %>% 
  unnest_tokens(word, 
                Headlines, 
                token = "regex", 
                pattern = "\\s+|[[:punct:]]+") %>%
  anti_join(customized_stopwords) %>% 
  arrange(Dates)
