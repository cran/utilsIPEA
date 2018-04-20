#'
#'
#' \code{ident_erros_munic_galileo} Returns a new column called munmatch with true or false. This column identify where GALILEO failed
#'
#' @importFrom stringr str_replace_all str_detect str_count fixed
#' @importFrom dplyr %>%
#' @param base Data frame, data set with return from GALILEO
#' @param mun character, the name of the municipio.
#' @param match character, the column MatchAdress from GALILEO.
#' @param uf character, the name of the state.
#'
#' @return Returns a new column called munmatch with true or false.
#'
#' @export
#'
ident_erros_munic_galileo <- function(base, mun, match, uf){
  base <- as.data.table(base)
  mun <- as.character(mun)
  match <- as.character(match)
  Encoding(mun) <- "latin1"
  Encoding(match) <- "latin1"
  ufnovo <- NULL
  cepmatch <- NULL
  munstr <- NULL
  matchstr <- NULL
  munmatch <- NULL
  base[,ufnovo:=uf %>% iconv(to="ASCII//TRANSLIT", from = "latin1") %>% toupper() %>% str_replace_all(fixed("'"), "") %>% str_replace_all("D.(S||)\\b", "") %>%
         str_replace_all("[IY]","I") %>% str_replace_all("[ZS]","S") %>% str_replace_all("[JG]","G")]
  base[,cepmatch:=str_detect(match,",\\s[0-9]{5}")]
  base[,munstr:= mun %>% iconv(to="ASCII//TRANSLIT", from = "latin1") %>% toupper() %>% str_replace_all(fixed("'"), "") %>% str_replace_all(" D.(S||)\\b", "") %>%
         str_replace_all("[IY]","I") %>% str_replace_all("[ZS]","S")%>% str_replace_all("[JG]","G")]
  base[,matchstr:= match %>% iconv(to="ASCII//TRANSLIT", from = "latin1") %>% toupper() %>% str_replace_all(fixed("'"), "") %>% str_replace_all(" D.(S||)\\b", "") %>%
         str_replace_all("[IY]","I") %>% str_replace_all("[ZS]","S")%>% str_replace_all("[JG]","G")]
  base[,munmatch:= mapply(
    function(x,y,c,d){ifelse(str_count(y, ",")<=1,str_detect(y,paste(x,",",sep='')) & str_detect(y,toupper(d))
                             ,ifelse(str_count(y, ",")==2 && c==TRUE,str_detect(y,paste(x,",",sep='')) & str_detect(y,toupper(d)),str_detect(y,paste(", ",x,",",sep='')) & str_detect(y,toupper(d))))}
    ,munstr,matchstr,cepmatch,ufnovo)]

  base <- base[,!c("munstr", "matchstr", "ufnovo", "cepmatch"),with=F]
  return(base)
}
