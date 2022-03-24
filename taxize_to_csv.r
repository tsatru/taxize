
library(taxize)


record_tsn_faltantes <- itis_getrecord(list_faltantes)
class(record_tsn)

temp = unique(unlist(lapply(record_tsn, names)))

df_acumulado_faltantes <- data.frame(tsn=character(),
                           autorship=character(),
                           updateDate=character(),
                           acceptedNames=character(),
                           rankName=character(),
                           taxonUsageRating=character(),
                           stringsAsFactors=FALSE)



i <- 0
for(i in 1:(length(record_tsn_faltantes)-1))  {
  #for(name in tsn_record){
  tsn <- record_tsn_faltantes[[i]]$acceptedNameList$tsn
  autorship <- record_tsn_faltantes[[i]]$taxonAuthor$authorship
  updateDate <- record_tsn_faltantes[[i]]$taxonAuthor$updateDate
  acceptedNames <- record_tsn_faltantes[[i]]$acceptedNameList$acceptedNames
  rankName <- record_tsn_faltantes[[i]]$taxRank$rankName
  taxonUsageRating <- record_tsn_faltantes[[i]]$usage$taxonUsageRating
  newRow <- data.frame(tsn=tsn,autorship=autorship,updateDate=updateDate, acceptedNames=acceptedNames,rankName=rankName, taxonUsageRating=taxonUsageRating) 
  df_acumulado_faltantes <- rbind(df_acumulado_faltantes, newRow)
  i<-i+1
  print(i)
}

table = 'acumulado_itis_faltantes'
dbWriteTable(db, table, value = df_acumulado_faltantes, append = FALSE, row.names = FALSE)




##########################todos los registros ######################################
i <- 0
for(i in 1:(length(record_tsn)-1))  {
  #for(name in tsn_record){
  tsn <- record_tsn[[i]]$acceptedNameList$tsn
  autorship <- record_tsn[[i]]$taxonAuthor$authorship
  updateDate <- record_tsn[[i]]$taxonAuthor$updateDate
  acceptedNames <- record_tsn[[i]]$acceptedNameList$acceptedNames
  rankName <- record_tsn[[i]]$taxRank$rankName
  taxonUsageRating <- record_tsn[[i]]$usage$taxonUsageRating
  newRow <- data.frame(tsn=tsn,autorship=autorship,updateDate=updateDate, acceptedNames=acceptedNames,rankName=rankName, taxonUsageRating=taxonUsageRating) 
  df_acumulado <- rbind(df_acumulado, newRow)
  i<-i+1
  print(i)
}
table = 'acumulado_itis'
dbWriteTable(db, table, value = df_acumulado, append = FALSE, row.names = FALSE)

