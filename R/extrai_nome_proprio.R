#' Check Brazilian names
#'
#' \code{extrai_NomeProprio} Parse Brazilian names and returns given names, surnames and gender
#'
#' @param x List, character or factor with names to be parsed.
#' @param surname If TRUE, the list of surnames is returned.
#' @param gender If TRUE, the list of gender based on the names is returned.
#' @param stringdist if TRUE, make a prediction based on the string distance of Jaro-Winkler between the source data and the input.
#' @param spaces if TRUE, returns the names without spaces. If FALSE, it compress all the blank spaces.
#'
#' @import data.table RCurl
#' @importFrom stringdist stringdist
#' @importFrom stringdist amatch
#' @importFrom stringr str_extract
#' @importFrom stringr str_trim
#' @importFrom stringr str_replace_all
#' @importFrom stringr str_replace
#' @importFrom utils data
#' @importFrom utils write.table
#' @return Returns a data.table
#'
#' @export
# extrai_NomeProprio <- function(x, surname = FALSE, gender = FALSE, stringdist = TRUE, spaces = TRUE){
#   dir_base <- file.path(str_replace_all(find.package("utilsIPEA"),"\\\\","/"),"data")
#   if(file.exists(file.path(dir_base,"name_gender.csv"))){
#     return(extrai_NomeProprio_(x = x, surname = surname, gender = gender, stringdist = stringdist, spaces = spaces, dir_base = dir_base))
#   } else {
#     print("Downloading source data...")
#     url_base <- getURL("https://raw.githubusercontent.com/ipea/utilsIPEA/base_nomes/nomes.csv")
#     dir.create(dir_base)
#     write.table(url_base,file.path(dir_base,"name_gender.csv"), sep = ",", quote = FALSE)
#     return(extrai_NomeProprio_(x = x, surname = surname, gender = gender, stringdist = stringdist, spaces = spaces, dir_base = dir_base))
#   }
# }
#
#
# find_strdist <- function(um_primeiro,dois_primeiros,tres_primeiros,base_nomes){
#   pos <- amatch(c(um_primeiro,dois_primeiros,tres_primeiros),base_nomes$V1, method = "jw", maxDist = 0.7)
#   pes1 <- stringdist(um_primeiro, base_nomes$V1[pos[1]], method = "jw")
#   pes2 <- stringdist(dois_primeiros, base_nomes$V1[pos[2]], method = "jw")
#   pes3 <- stringdist(tres_primeiros, base_nomes$V1[pos[3]], method = "jw")
#   minimo <- suppressWarnings(min(pes1,pes2,pes3, na.rm = TRUE))
#   retorno <- ifelse( minimo == pes1, base_nomes$V1[pos[1]],
#                      ifelse( minimo == pes2, base_nomes$V1[pos[2]],
#                              ifelse( minimo == pes3, base_nomes$V1[pos[3]],
#                                      NA)))
#   return(retorno)
# }
#
#
# extrai_NomeProprio_ <- function(x, surname, gender, stringdist, spaces, dir_base){
#   NomeProprio <- NULL
#   um_primeiro <- NULL
#   dois_primeiros <- NULL
#   tres_primeiros <- NULL
#   nome <- NULL
#   . <- NULL
#   base_nomes <- NULL
#   V2 <- NULL
#   #Carrega bases necessárias e variáveis--------------------------
#   #base_nomes <- suppressMessages(fread("data/names_gender.csv"))
#   base_nomes <- suppressMessages(fread(file.path(dir_base,"name_gender.csv")))
#   patternOneName <- "^[a-zA-Z0-9_]+"
#   patternTwoNames <- "^[a-zA-Z0-9_]+\\s[a-zA-Z0-9_]+"
#   patternThreeNames <- "^[a-zA-Z0-9_]+\\s[a-zA-Z0-9_]+\\s[a-zA-Z0-9_]+"
#
#   #Trata os dados de entrada --------------------------------------
#   names <- setDT(data.frame(nome = toupper(x)))
#
#   #Separa nomes---------------------------------------------------
#   names[,um_primeiro := str_extract(nome,patternOneName)]
#   names[,dois_primeiros := str_extract(nome,patternTwoNames)]
#   names[,tres_primeiros := str_extract(nome,patternThreeNames)]
#
#   if(stringdist == TRUE){
#     names[, NomeProprio := ifelse(tres_primeiros %in% base_nomes$V1, tres_primeiros,
#                                   ifelse(dois_primeiros %in% base_nomes$V1, dois_primeiros,
#                                          ifelse(um_primeiro %in% base_nomes$V1, um_primeiro,
#                                                 ifelse(!is.na(find_strdist(um_primeiro, dois_primeiros, tres_primeiros,base_nomes)), find_strdist(um_primeiro, dois_primeiros, tres_primeiros,base_nomes),
#                                                        um_primeiro))))]
#   }
#
#   if(stringdist == FALSE){
#     names[, NomeProprio := ifelse(tres_primeiros %in% base_nomes$V1, tres_primeiros,
#                                   ifelse(dois_primeiros %in% base_nomes$V1, dois_primeiros,
#                                          str_extract(names$nome,patternOneName)))]
#   }
#
#   if(surname == TRUE){
#     names[,surname := ifelse(str_replace_all(NomeProprio," ","") == str_extract(nome,"^[A-Z]+"), str_replace(nome,"^[A-Z]+\\s",""),
#                                str_trim(str_replace(nome, NomeProprio, "")))]
#   }
#   if(gender == TRUE){
#     names[,gender := base_nomes[NomeProprio,,on="V1"][,.(V2)]]
#
#   }
#
#   if(spaces == FALSE){
#     names[,NomeProprio := str_replace_all(NomeProprio," ","")]
#     if(surname == TRUE){
#       names[,surname := str_replace_all(surname," ","")]
#     }
#   }
#
#   names[,dois_primeiros := NULL]
#   names[,tres_primeiros := NULL]
#   names[,um_primeiro := NULL]
#   names[,nome := NULL]
#
#   if(surname == FALSE & gender == FALSE){
#     return(names[,NomeProprio])
#   }
#
#   return(as.data.frame(names))
# }


