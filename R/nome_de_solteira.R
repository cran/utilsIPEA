#' Return women single's name
#'
#' \code{nome_de_solteira} Return women single's name using the husband last name.
#'
#' @param nome_casada Character, married woman's name
#' @param nome_conjuge character, husband's name.
#'
#' @return Returns a list of possible names
#'
#' @examples
#'   nome_de_solteira(nome_casada = "Maria Conceicao da Costa", nome_conjuge = "Mario Silva da Costa")
#' @export
#'
nome_de_solteira <- function(nome_casada, nome_conjuge){

  nome_casada <- remove_preposicao_nomes(nome_casada)
  nome_conjuge <- remove_preposicao_nomes(nome_conjuge)
  nome_separado_casada <- unlist(strsplit(nome_casada, "\\W+"))
  nome_separado_conjuge <- unlist(strsplit(nome_conjuge, "\\W+"))
  nomes_presentes <- sapply(nome_separado_conjuge, function(sobrenome) any(nome_separado_casada == sobrenome))
  sobrenome <- nome_separado_conjuge[nomes_presentes]

  sobrenome_split <- lapply(sobrenome, function(x) nome_separado_casada[!(nome_separado_casada %in% x)])

  return(lapply(sobrenome_split, function(x) paste(x, collapse = " ")))
}
