# Book_Cohen_R

- __Project Purpose:__ 
    This project goal was demonstating visualization and learning to use other's code and packages from github. I was inspired by code from STAT 4030: Programming in R Class which Shelby Taylor showed how to find the most common words in a book. I wanted to see if this was possible to do with the Bible and make a visualitation out of it. This was all for a personal curiousity of the data and visualization aspect, not for any client, but I hope to improve it to use once for church. 
- __Tools used:__ 
    The whole project is in R. All my code is on [bible.r script](https://github.com/ltcohen43/Book_Cohen_R/blob/main/scripts/bible.R). I used the R-package from github called [sacred](https://github.com/JohnCoene/sacred) This was a test of skills as I have never used github packages before, learning quickly how to connect to vscode instead of using my own data or built in R packages. I referenced code from Shelby Taylor that is in the end of the bible.r script and used code from this [website](https://semba-blog.netlify.app/11/06/2019/looking-at-the-bible-through-wordcloud-in-r/). I realized later that the script was breaking down tibbles of the text in the sacred package. This was something we learned later in the STAT 4490: Special Topics in Statistics with Jay Hathaway, so I was able to understand that part of the code later. I also learned how to play around with the different arguments in the ggworldcloud from ggplot in R.
- __Results:__ 
    The conclusion is that using the ggwordcloud is not as simple as it looks. One of the issues I ran into was some of the words being cut off in the picture. I unfortunately could not fix this at the moment, but I still see the visualization as something useful. For a church, it could draw attention to a sermon they will speak on the following week. In general, knowing the most common words to different texts could help with people doing advertising to know what is most important for people to see or understand from any field. 
    My next steps would be to fix the graphic to see the full words, and if another package is made with a different version of the Bible, try this to see if there would be any differences. 

## Folder structure

```
- readme.md
- scripts
---- bible.R
---- readme.md
- data (less than 100 Mb)
---- readme.md 
- documents
---- readme.md 
---- original_word_cloud.png 
---- word_cloud.png 
```