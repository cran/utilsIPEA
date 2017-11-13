#' Remove de da e dos of names .
#'
#' \code{remove_preposicao_nomes} return names without de, da e dos.
#'
#'
#' @param base A data table, data frame or character vector.
#' @param ... columns for apply the function
#' @param suffixo Suffix name for the new column.
#'
#' @import data.table
#' @importFrom stringr str_replace_all
#' @return the base parameter with a new column.
#'
#' @examples
#'    base <- data.frame(nome = c("João das Neves", "Pedro dos Anjos", "Maria das Gracas"))
#'    base <- remove_preposicao_nomes(base, "nome")
#' @export
#'
remove_preposicao_nomes <- function(base, ..., suffixo = "_semD"){
  return(funcao_generica(base, ..., suffixo = suffixo, FUN = remove_preposicao_nomes_coluna))

}

remove_preposicao_nomes_coluna <- function(nomes){
  subs <- " DA | DE | DOS | D. | DAS | A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | X | Z"
  subs <- paste(subs, tolower(subs), sep = "|")
  if(is.character(nomes)){
    return(str_replace_all(nomes, subs, " "))
  }
}

abrevia_nomes_meio_coluna<- function(nomes){
  novos_nomes <- sapply(nomes, USE.NAMES = F, function(nome){
    nomes_separados <- str_extract_all(nome, "(\\w+)", simplify = T)
    if(length(nomes_separados) <= 2) return(nome)
    n <- length(nomes_separados) - 1
    for(i in 2:n){
      nomes_separados[i] <- str_extract(nomes_separados[i], "^\\w{1}")
    }
    nome_corrigido<- paste(nomes_separados, collapse = " ")
    return(nome_corrigido)
  } )
  return(novos_nomes)
}


funcao_generica <- function(base, ..., suffixo, FUN){
  FUN <- match.fun(FUN)
  if(is.character(base)){
    return(FUN(base))
  }
  other_columns <- unlist(eval(substitute(alist(...))))
  stopifnot(length(other_columns) > 0)
  if(!is.data.table(base)){ setDT(base) }
  new_columns <- sapply(other_columns, function(x) paste0(x, suffixo))
  mapply( function(x, y){ set(base, j = x, value = FUN(base[[y]])) },
          new_columns, other_columns)

  return(base)

}


#' Abrevia o nome do meio.
#'
#' \code{abrevia_nome_meio} return names .
#'
#'
#' @param base A data table, data frame or character vector.
#' @param suffixo A character indicating the final part of the new columns' names
#' @param ... columns for apply the function
#'
#' @import data.table
#' @importFrom stringr str_replace_all
#' @importFrom stringr str_extract_all
#' @importFrom stringr str_extract
#' @return the base parameter with a new column.
#'
#' @examples
#'    base <- data.frame(nome = c("Carlos Pereira Neves", "Pedro Aparecido Anjos"))
#'    base <- remove_preposicao_nomes(base, "nome")
#' @export
#'
abrevia_nome_meio <- function(base, ..., suffixo = "_abrev"){
  return(funcao_generica(base, ..., suffixo = suffixo, FUN = abrevia_nomes_meio_coluna))

}
