#' Remove de da e dos of names .
#'
#' \code{contar_letras} return number of any letters on alphabet for each column.
#'
#'
#' @param base A data table, data frame or character vector.
#' @param columns for apply the function
#' @param suffix Suffix name for the new column.
#'
#' @import data.table
#' @return a data.table number of any letters on alphabet for each column
#'
#' @examples
#'    base <- data.frame(nome = c("João das Neves", "Pedro dos Anjos", "Maria das Gracas"))
#'    base <- contar_letras(base, "nome")
#' @export
#'
contar_letras <- function(base, columns, suffix = NULL){
  stopifnot(is.character(columns))
  ret <- lapply(columns, function(column){
    re <- data.table(a=str_count(base[[column]], 'a|A|\u00E1|\u00C1|\u00E2|\u00C2|\u00E3|\u00C3|\u00E0|\u00C0'),
                     b=str_count(base[[column]], 'b|B'),
                     c=str_count(base[[column]], "c|C|\u00E7|\u00C7"),
                     d=str_count(base[[column]], 'd|D'),
                     e=str_count(base[[column]], "e|E|\u00E9|\u00C9|\u00EA|\u00CA|\u00E8|\u00C8"),
                     f=str_count(base[[column]], 'f|F'),
                     g=str_count(base[[column]], 'g|G'),
                     h=str_count(base[[column]], 'h|H'),
                     i=str_count(base[[column]], 'i|I|\u00ED|\u00CD|\u00EE|\u00CE|\u00EC|\u00CC'),
                     j=str_count(base[[column]], 'j|J'),
                     k=str_count(base[[column]], 'k|K'),
                     l=str_count(base[[column]], 'l|L'),
                     m=str_count(base[[column]], 'm|M'),
                     n=str_count(base[[column]], 'n|N'),
                     o=str_count(base[[column]], 'o|O|\u00F0|\u00F4|\u00D4|\u00F3|\u00D3|\u00F5|\u00D5|\u00F2|\u00D2'),
                     p=str_count(base[[column]], 'p|P'),
                     q=str_count(base[[column]], 'q|Q'),
                     r=str_count(base[[column]], 'r|R'),
                     s=str_count(base[[column]], 's|S'),
                     t=str_count(base[[column]], 't|T'),
                     u=str_count(base[[column]], 'u|U|\u00FA|\u00DA|\u00FB|\u00DB|\u00F9|\u00D9'),
                     v=str_count(base[[column]], 'v|V'),
                     w=str_count(base[[column]], 'w|W'),
                     x=str_count(base[[column]], 'x|X'),
                     y=str_count(base[[column]], 'y|Y'),
                     z=str_count(base[[column]], 'z|Z'))
    if(is.null(suffix)){
      setnames(re, names(re),paste(names(re), column, sep = "_") )
    }else{
      setnames(re, names(re),paste(names(re), suffix, sep = "_") )
    }
  })
  return(do.call(cbind, lapply(ret, data.table, stringsAsFactors=FALSE)))
}
