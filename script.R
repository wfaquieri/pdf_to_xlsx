
edital = ("data-raw/PETROBRAS_edital_de_abertura_n_1.pdf")
txt <- pdftools::pdf_text(pdf=edital)
lines <- pdftools::pdf_text(pdf=edital) |> 
  readr::read_lines()

cat(txt[1])

cat(txt[2])


# -------------------------------------------------------------------------

# Páginas de interesse
page_35 = txt[35] |> readr::read_lines()
page_36 = txt[36] |> readr::read_lines()

ds1 = page_35[28:52] |> stringr::str_squish()
ds2 = page_36[6:16] |> stringr::str_squish()



n = length(ds1)

init_ = paste(ds1[1], ds1[2], sep=" ")

for (i in 3:n) {
  init_ = paste(init_,ds1[i], sep=" ")
}


tab = init_ |> stringr::str_split("\\. ") 

tab_final = tibble::as_tibble(tab[[1]])

tab_final |> writexl::write_xlsx('Disciplinas_DS_Petrobas.xlsx')






