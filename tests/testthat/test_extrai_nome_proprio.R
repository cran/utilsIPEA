test_that("nomes proprios", {
  nomes <- c("Carlos das Neves", "Pedro dos Anjos", "Maria Juvelina")
  nomes_proprios <- c("CARLOS","PEDRO","MARIA")
  nomes_retorno <- extrai_NomeProprio(nomes)
  expect_equal(c("nome", "NomeProprio"), names(nomes_retorno))
  expect_equal(nomes_proprios, nomes_retorno$NomeProprio)
})
