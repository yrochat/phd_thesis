

# Importing and reading table
# of IDs and APPEARING PAGES
res.df <- read.table(	"data/apparitions_par_pages.txt", 
						sep="\t", 
						stringsAsFactors = FALSE,
						col.names = c("id", "volume", "page", "externe"))
head(res.df)

# $externe takes as values "n" or nothing.
# In the "n" case, interpretation is that the name appears in the footnotes.
# Watch out ! Names appearing in theoretical introductions or essays
# won't be denoted with "n". The texts under scope have to be cut
# from the first to the last page.

# Cette fois on lit les noms des personnes citées
res <- readLines("data/names.txt")

res <- strsplit(res, split = "\t")
res.df2 <- do.call(rbind, res)
res.df2 <- as.data.frame(res.df2, stringsAsFactors = FALSE)

colnames(res.df2) <- c("id", "full")

# On transpose les noms des sommets dans le tableau des occurrences !!! Peut être très long !
res <- merge(res.df, res.df2, by.x = "id", by.y = "id")

# On va supprimer les noms des intervenants extérieurs à l'histoire
res <- res[!(res$externe == "n"),]

relations <- res

###################
### BASIC STATS ###
###################

# Combien de personnages dans la table
length(unique(res.df2$full))

# Combien de personnages cités dans les commentaires ou footnotes
length(unique(res.df$id[res.df$externe == "n"]))

# Combien de personnages cités par Rousseau
length(unique(res.df$id[res.df$externe == ""]))

###############################
### FICHIER DES CONFESSIONS ###
###############################


# Pour tout afficher dans l'ordre
#
# relations[order(relations$volume, relations$page),]

confessions <- relations[which((relations$volume == 1 & relations$page >= 65) | (relations$volume == 2 & relations$page <= 847)),]						# On extrait uniquement les Confessions

# chapitrage
livres <- data.frame(	page=65:847, 
						type=c(
							"intro1",					# page 65, aucun nom n'apparaît sur cette page !
							"vide",						# page 66
							rep("1",length(67:115)),
							"vide",						# page 116
							rep("2",length(117:167)),
							"vide",						# page 168
							rep("3",length(169:220)),
							rep("4",length(221:269)),
							"vide",						# page 270
							rep("5",length(271:326)),
							rep("6",length(327:380)),
							"intro2",					# page 381, 
							"vide",						# page 382
							rep("7",length(383:471)),
							"vide",						# page 472
							rep("8",length(473:538)),
							rep("9",length(539:637)),
							"vide",						# page 638
							rep("10",length(639:704)),
							rep("11",length(705:758)),
							rep("12",length(759:847))
							), stringsAsFactors = FALSE)

confessions <- merge(confessions, livres, by.x = "page", by.y = "page")

confessions <- confessions[,c(1,5,6,2)]									# pour que nom et numéro de page apparaissent dans le bon ordre

###################
### BASIC STATS ###
###################

# Combien de personnages dans les Confessions
length(unique(confessions$full))


###############################
### Création du graphe NAIF ###
###############################

# toutes les versions 0 des graphes correspondent aux graphes dont la co-occurrence est sur la page, sans les pages adjacentes

# Ici le graphe biparti
g0.bip <- graph.data.frame(confessions, directed=FALSE)
V(g0.bip)$types <- FALSE
V(g0.bip)[1:length(unique(confessions$page))]$types <- TRUE

# Ici le graphe projeté
g0 <- bipartite.projection(g0.bip, type=V(g0.bip)$types, multiplicity = TRUE)$proj2 


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

g1.bip <- graph.data.frame(input, directed=FALSE)							# La création du graphe (qui est biparti, du coup)
V(g1.bip)$types <- FALSE													# On donne l'étiquette FALSE aux personnages
V(g1.bip)[1:length(unique(input$page))]$types <- TRUE						# On donne l'étiquette TRUE aux pages

# Pour se faire une idée de la taille des noms des gens
# nchar(V(g)[types == FALSE]$name)

# On fait la projection sur les noeuds FALSE, c'est-à-dire que deux
# personnages sont liés s'ils étaient connectés dans le graphe biparti
# à la même page des Confessions

g1 <- bipartite.projection(g1.bip, type=V(g1.bip)$types, multiplicity = TRUE)$proj2 

rm(confessions1, confessions2, input, relations, res, res.df, res.df2)

V(g1)$id <- 1:vcount(g1)

g1$layout <- layout.norm(layout.fruchterman.reingold(g1, repulserad = vcount(g1)^2.5, niter = 1000), -1, 1, -1, 1)
g0$layout <- g1$layout




#################################################################################################################################
save(	g0, g1,
		g0.bip, g1.bip,
		confessions, livres, 
		file="data/data0a.Rdata") ###
#################################################################################################################################























