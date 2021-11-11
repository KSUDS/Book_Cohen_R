 

# devtools::install_github("JohnCoene/sacred") # nolint

pacman::p_load(magrittr, ggwordcloud, tm, sacred, RColorBrewer, tidyverse, tidytext) # nolint
httpgd::hgd()
httpgd::hgd_browse()

# https://semba-blog.netlify.app/11/06/2019/looking-at-the-bible-through-wordcloud-in-r/ # nolint


scripture <- sacred::king_james_version

bible <- scripture %>%
  group_by(book) %>%
  mutate(linenumber = row_number(),
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]",
                                                 ignore_case = TRUE)))) %>%
  ungroup()

tidy_books <- bible %>%
  tidytext::unnest_tokens(word, text)


## Notice the data format ##

tidy_books

## Count Up Most Common Words ##
  
tidy_books %>%
  dplyr::count(word, sort = TRUE)
  

## Anti_Join with stop_words df ##

data("middle_english_stopwords")
stop_words[1:5, 1]

tidy_books %>%
  dplyr::anti_join(middle_english_stopwords, by = "word") %>%
  dplyr::count(word, sort = TRUE)

#### Word cloud ####

heaven <- scripture %>%
filter(book == "mat", psalm == 13) %>%
  select(text)

heaven_corpus <- heaven %>%
    tm::VectorSource() %>%
    tm::VCorpus()
  

to_Space <- content_transformer(function(x, pattern) gsub(pattern, " ", x)) # nolint
  
heaven_corpus <- heaven_corpus %>%
    tm_map(to_Space, "/") %>%
    tm_map(to_Space, " ") %>%
    tm_map(to_Space, "\\|")

heaven_corpus <-  heaven_corpus %>%
  tm_map(FUN = content_transformer(tolower)) %>% # Convert the text to lower case # nolint
  tm_map(FUN = removeNumbers) %>% # Remove numbers
  tm_map(removeWords, stopwords("english")) %>% # Remove english common stopwords # nolint
  tm_map(removeWords, c("ye", "O", "unto", "yet", "thee", "wherein", "neither", "shall", # nolint
                        "saith", "host", "will", "offer", "say")) %>%   # Remove words # nolint
  tm_map(removePunctuation) %>%   # Remove punctuations
  tm_map(stripWhitespace)


heaven_corpus_tb <-  heaven_corpus %>%
  tm::TermDocumentMatrix(control = list(removeNumbers = TRUE,
                                        stopwords = TRUE,
                                        stemming = TRUE)) %>%
  as.matrix() %>%
  as.data.frame() %>%
  tibble::rownames_to_column() %>%
  dplyr::rename(word = 1, freq = 2) %>%
  dplyr::arrange(desc(freq))


ggplot(data = heaven_corpus_tb,
       aes(label = word, size = freq, col = as.character(freq))) +
  geom_text_wordcloud(rm_outside = TRUE, max_steps = 1,
                      grid_size = 1, eccentricity = .9) +
  scale_size_area(max_size = 15) +
  scale_color_brewer(palette = "Paired", direction = -1) +
 theme_void()
ggsave(file = "original_word_cloud.png", width = 15, height = 6)

heaven_corpus_tb <-  heaven_corpus_tb %>%
  dplyr::mutate(angle = 90 * sample(c(0, 1), n(), replace = TRUE, prob = c(60, 40))) # nolint
  
#rotated words= image
ggplot(data = heaven_corpus_tb,
       aes(label = word, size = freq, angle = angle, col = as.character(freq))) + # nolint
  geom_text_wordcloud(rm_outside = TRUE, max_steps = 1,
                      grid_size = 1, eccentricity = .9) +
  scale_size_area(max_size = 15) +
  scale_color_brewer(palette = "Paired", direction = -1) +
  theme_void()
  ggsave(file = "word_cloud.png", width = 15, height = 6)

# the example- Credit: Shelby Taylor- 4030 class

library(tidyverse)
library(janeaustenr)
library(tidytext)

## Don't worry about this part too much right now- makes code in readable format## # nolint

original_books <- austen_books() %>%
  group_by(book) %>%
  mutate(linenumber = row_number(),
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]",
                                                 ignore_case = TRUE)))) %>%
  ungroup()

tidy_books <- original_books %>%
  tidytext::unnest_tokens(word, text)

## Notice the data format ##

tidy_books

 ## Count Up Most Common Words ##

 tidy_books %>%
  dplyr::count(word, sort = TRUE)

## Anti_Join with stop_words df ##
 
data("stop_words")
stop_words[1:5, 1]

tidy_books %>%
  dplyr::anti_join(stop_words, by = "word") %>%
  dplyr::count(word, sort = TRUE)
