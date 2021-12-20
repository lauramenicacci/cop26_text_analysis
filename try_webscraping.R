##polite webscraping

# criteria for polite code:
# only download if file does not exist yet
# pause between queries
# stay identifiable with "From" header field

baseurl <- "https://www.theguardian.com/environment/cop26-glasgow-climate-change-conference-2021?page="
pageurl <- paste0(seq(1, 33, 1))
pages_list <- paste0(baseurl, pageurl)
pages_list[1:5] #33 pages until 18 oct = 2 weeks before cop 
headlineslist <- c()

folder <- "C:/Users/laura/Desktop/guardian_htmls/"
dir.create(folder)
for (i in 1:length(pages_list)) {headlineslist[i] <- paste0("page", i)}

for (i in 1:length(pages_list))  { if (!file.exists(paste0(folder, headlineslist[i]))) {  
  try(download.file(pages_list[i], 
                    destfile = paste0(folder, headlineslist[i], ".html"), 
                    header = c(`User-Agent` = R.Version()$version.string, `From` = "212166@hertie-school.org")))
  Sys.sleep(runif(1, 1, 2)) 
}}

list.files(folder, pattern = ".*",full.names = TRUE)


#############

for (page in pages_list){
  url_parsed <- read_html(page)
  
  headings_nodes <- html_elements(url_parsed, xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "fc-date-headline", " " ))] | //*[contains(concat( " ", @class, " " ), concat( " ", "js-headline-text", " " ))]')
  
  headlines <- html_text2(headings_nodes)
  headlineslist <- append(headlineslist, headlines)
  #all_headlines <- append(all_headlines, headlineslist)
}

