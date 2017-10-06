#' Remove de da e dos of names .
#'
#' \code{remove_preposicao_nomes} return names without de, da e dos.
#'
#'
#' @param base A data table, data frame or character vector.
#' @param ... columns for apply the function
#'
#' @import data.table
#' @importFrom stringr str_replace_all
#' @return the base param with a new column.
#'
#' @examples
#'    base <- data.frame(nome = c("João das Neves", "Pedro dos Anjos", "Maria das Gracas"))
#'    base <- remove_preposicao_nomes(base, "nome")
#' @export
#'

# retira "DE" "DA" e "DOS" dos nomes
remove_preposicao_nomes <- function(base, ...){
  subs <- " DA | DE | DOS | D. | DAS | A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | X | Z"
  subs <- paste(subs, tolower(subs), sep = "|")
  if(is.character(base)){
    return(str_replace_all(base, subs, " "))
  }
  other_columns <- unlist(eval(substitute(alist(...))))
  stopifnot(length(other_columns) > 0)
  if(!is.data.table(base)){ setDT(base) }
  new_columns <- sapply(other_columns, function(x) paste0(x,"_semD"))
  mapply( function(x, y){ set(base, j = x, value = str_replace_all(base[[y]], subs, " ")) },
        new_columns, other_columns)

  return(base)

}


#' Abrevia o nome do meio.
#'
#' \code{abrevia_nome_meio} return names .
#'
#'
#' @param base A data table, data frame or character vector.
#' @param ... columns for apply the function
#'
#' @import data.table
#' @importFrom stringr str_replace_all
#' @importFrom stringr str_extract
#' @return the base param with a new column.
#'
#' @examples
#'    base <- data.frame(nome = c("João Pereira Neves", "Pedro Aparecido Anjos", "Maria Joaquina Gracas"))
#'    base <- remove_preposicao_nomes(base, "nome")
#' @export
#'
abrevia_nome_meio <- function(base, ...){
  if(is.character(base)){
    return(abrevia_nomes_meio_coluna(base))
  }
  other_columns <- unlist(eval(substitute(alist(...))))
  stopifnot(length(other_columns) > 0)
  if(!is.data.table(base)){ setDT(base) }
  new_columns <- sapply(other_columns, function(x) paste0(x, "_abrev"))
  mapply( function(x, y){ set(base, j = x, value = abrevia_nomes_meio_coluna(base[[y]])) },
          new_columns, other_columns)

  return(base)

}

abrevia_nomes_meio_coluna<- function(nomes){
  novos_nomes <- sapply(nomes, USE.NAMES = F, function(nome){
    first<- str_extract(nome, "^[A-Z-a-z]+(?=\\s)")
    last<- str_extract(nome, "[A-Z-a-z]+$")
    mid <- str_trim(str_replace_all(nome, "^[A-Z-a-z]+|[A-Z-a-z]+$",""))
    mid<- ifelse(is.na(mid),"",mid) %>%
      str_trim() %>%
      str_extract_all("^[A-Z-a-z]|\\s[A-Z-a-z]", simplify = T) %>%
      str_trim() %>%
      paste(collapse = " ")
    nome_corrigido<- paste(first,mid,last, sep = " ") %>% str_replace_all("\\s+"," ")
    return(nome_corrigido)
  } )
  return(novos_nomes)
}


