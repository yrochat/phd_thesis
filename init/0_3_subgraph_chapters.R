


################################
### Création du graphe FINAL ###
################################

confessions2 <- confessions1 <- confessions

# toutes les pages n des confessions sont transformées en page n-1,n
# l'opération se fait pour chaque entrée du tableau "confessions"
confessions1$page1 <- paste(sprintf("%03d",confessions$page-1, sep=""), sprintf("%03d",confessions$page, sep=""), sep="")

# toutes les pages n des confessions sont transformées en page n,n+1
# l'opération se fait pour chaque entrée du tableau "confessions"
confessions2$page1 <- paste(sprintf("%03d",confessions$page, sep=""), sprintf("%03d",confessions$page+1, sep=""), sep="")

input <- rbind(confessions1[,c(5,2,3,4)],confessions2[,c(5,2,3,4)])

# Le nombre de duplicata
# sum(duplicated(input))

# cette ligne c'est si on veut pas compter double pour les co-occurrences même page
# mais ça fait tomber drastiquement le nombre de sommets !!!
input <- unique(input)

gchap <- list()

for (i in 1:12) {
	g.temp <- graph.data.frame(input[input$type == i,], directed=FALSE)							# La création du graphe (qui est biparti, du coup)
	V(g.temp)$types <- FALSE																	# On donne l'étiquette FALSE aux personnages
	V(g.temp)[1:length(unique(input[input$type == i,]$page))]$types <- TRUE										# On donne l'étiquette TRUE aux pages

# On fait la projection sur les noeuds FALSE, c'est-à-dire que deux
# personnages sont liés s'ils étaient connectés dans le graphe biparti
# à la même page des Confessions

	gchap[[i]] <- bipartite.projection(g.temp, type=V(g.temp)$types, multiplicity = TRUE)$proj2 
}

rm(confessions1, confessions2, input)


#################################################################################################################################
save(	gchap,
		file="data/data0c.Rdata") 
#################################################################################################################################












