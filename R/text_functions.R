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
