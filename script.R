
edital = ("data-raw/PETROBRAS_edital_de_abertura_n_1.pdf")
txt <- pdftools::pdf_text(pdf=edital)
lines <- pdftools::pdf_text(pdf=edital) |> 
  readr::read_lines()

# -------------------------------------------------------------------------

# Páginas de interesse
page_35 = txt[35] |> readr::read_lines()
page_36 = txt[36] |> readr::read_lines()

ds1 = page_35[28:52] |> stringr::str_squish()
ds2 = page_36[6:16] |> stringr::str_squish()


arrumar_dados = function(text){
  
  n = length(text)
  
  init_ = paste(text[1], text[2], sep=" ")
  
  for (i in 3:n) {
    init_ = paste(init_,text[i], sep=" ")
  }
  
  init_ = init_ |> stringr::str_split("\\. ")
  
  tab = tibble::as_tibble(init_[[1]])
  
  return(tab)
  
}

tab_1 = arrumar_dados(text=ds1)

tab_2 = arrumar_dados(text=ds2)

tab_final = dplyr::bind_rows(tab_1, tab_2)




title_subt = tab_final[1,1] |> dplyr::pull(value)

title = title_subt |> stringr::str_sub(start = 1L, end = 26L)
subtitle = title_subt |> stringr::str_sub(start = 30L, end = -1L)

tab_final[1,1] = subtitle

colnames(tab_final) = title
   
tab_final |> writexl::write_xlsx('Disciplinas_DS_Petrobas.xlsx')






