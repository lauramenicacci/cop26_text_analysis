# Sentiment analysis of COP26 headlines from a British outlet
This repository comprises all the material created and used for the Introduction to Data Science final project at the Hertie School, Berlin, taught by Simon Munzert in Fall 2021.
The project consists of an analysis of the sentiment from articles published by The Guardian, a British newspaper, during a specific period of time. Our aim is to analyse whether such a newspaper, representing in this case a small sample of the media outlet reality in UK, could present changes in the sentiment of content circulating in the period before, during and after COP26. 

# Project workflow
The project is structures as follows (1) webscraping: we retrieve the headlines text and the date from each article of The Guardian headlines during the specified period (second half of October - end of November) with the rvest package (2) data cleaning: we put the text and the date in the correct format in order to analyse it with lubridate and tidytext (3) sentiment analysis: through a differenct range of packages (tidytext, quanteda, dyplr) and three different dictionaries (Bing et al., AFINN and Lexicoder Sentiment Dictionary), we analyse the sentiment of the headlines in the different period of times from various perspectives. 

# Main steps of the sentiment analysis
The steps we followed for the sentiment analysis are: 
- explorative section of the retrieved headlines, in which we observed some of the most frequent words, and tried to understand whether they could fit for our analysis or just be removed as stopowords 
- first sentiment analysis, in which we joined the dataset with the Bing et al. dictionary, plotting it with dates and frequencies in an interactive plot 
- visualization of most frequent words between negative and positive
- visualization of the headlines' sentiment distribution using the LSD2015 dictionary 
- targeted sentiment analysis for the bigram 'Boris Johnson' with the LSD2015 dictionary, with similar visualization of the results
- topic modeling (?)

# Collaborators
Katalin Bayer

Laura Menicacci

Nassim Zoueini

# Resources
Young, L. & Soroka, S. (2012). Affective News: The Automated Coding of Sentiment in Political Texts]. doi: 10.1080/10584609.2012.671234 . Political Communication, 29(2), 205--231

Text Mining with R: A Tidy Approach (https://www.tidytextmining.com/index.html) 

Quanteda Tutorials (https://tutorials.quanteda.io/)

# License
The material in this repository is made available under the MIT license.

# Statement of contributions
Katalin Bayer, Laura Menicacci and Nassim Zoueini contributed equally for this project both in terms of workflow management and coding skills, in a truly collaborative spirit. 
