

####################
### Sous-réseaux ###
####################

# Pour faire la découpe par livre, il faut passer par la construction de chaque réseau,
# puisque l'information est au niveau du graphe biparti et pas de la projection
# et pour ça, comparer avec la version imprimée chez Slatkine

# les graphes obtenus par variation du threshold

g1.list <- c(list(g1), lapply(1:24, function(x) subgraph.edges(g1, E(g1)[weight>x])))
g0.list <- c(list(g0), lapply(1:24, function(x) subgraph.edges(g0, E(g0)[weight>x])))

############################
### Layouts sous-graphes ###
############################

for (i in 1:length(g1.list)) g1.list[[i]]$layout <- g1$layout[V(g1)$name %in% V(g1.list[[i]])$name,]
for (i in 1:length(g0.list)) g0.list[[i]]$layout <- g0$layout[V(g0)$name %in% V(g0.list[[i]])$name,]

# DEBUG
# sapply(g1.id.list, function(x) min(E(x)$weight))
# sapply(g0.id.list, function(x) min(E(x)$weight))

###############################
### Les composantes géantes ###
###############################

sub.g1.list <- lapply(g1.list, function(x) induced.subgraph(x, V(x)[clusters(x)$membership == which.max(clusters(x)$csize)]))
sub.g0.list <- lapply(g0.list, function(x) induced.subgraph(x, V(x)[clusters(x)$membership == which.max(clusters(x)$csize)]))

for (i in 1:length(sub.g1.list)) sub.g1.list[[i]]$layout <- g1$layout[V(g1)$name %in% V(sub.g1.list[[i]])$name,]
for (i in 1:length(sub.g0.list)) sub.g0.list[[i]]$layout <- g0$layout[V(g0)$name %in% V(sub.g0.list[[i]])$name,]

# DEBUG
# sapply(sub.g1.id.list, is.connected)
# sapply(sub.g0.id.list, is.connected)

##########################
### Choix du seuil = 2 ###
##########################

# le graphe avec les poids des arêtes > 1
g2 <- g1.list[[2]]

# # on repart du data frame dont on ne prend que les sommets du graphe précédent
# g2 <- graph.data.frame(input[input$full %in% V(g2)$name,], directed=FALSE)							# La création du graphe (qui est biparti, du coup)
# V(g2)$types <- FALSE																				# On donne l'étiquette FALSE aux personnages
# V(g2)[1:length(unique(input[input$full %in% V(g2)$name,]$page))]$types <- TRUE						# On donne l'étiquette TRUE aux pages

# # on projette :
# # Ce graphe est une projection à partir du graphe de tous les sommets et de toutes les arêtes,
# # mais dont nous ne conservons comme sous-ensemble de sommets que ceux qui apparaissaient encore
# # dans le graphe demandant des poids >= 3
# g2.id <- bipartite.projection(g2, type=V(g2)$types, multiplicity = TRUE)$proj2 

##################################
### Choix de seuils supérieurs ###
##################################

g3 <- g1.list[[3]]
g4 <- g1.list[[4]]
g5 <- g1.list[[5]]
g6 <- g1.list[[6]]
g7 <- g1.list[[7]]
g8 <- g1.list[[8]]
g9 <- g1.list[[9]]
g10 <- g1.list[[10]]
g11 <- g1.list[[11]]
g12 <- g1.list[[12]]
g13 <- g1.list[[13]]
g14 <- g1.list[[14]]
g15 <- g1.list[[15]]
g16 <- g1.list[[16]]
g17 <- g1.list[[17]]
g18 <- g1.list[[18]]
g19 <- g1.list[[19]]
g20 <- g1.list[[20]]
g21 <- g1.list[[21]]
g22 <- g1.list[[22]]
g23 <- g1.list[[23]]
g24 <- g1.list[[24]]
g25 <- g1.list[[25]]

######################################
### Options visuelles sous-graphes ###
######################################

# g1.list <- lapply(g1.list, function(x) {
	# V(x)$size <- 1 + log2(degree(x)+1)/2 											# taille des noeuds
	# V(x)$color <- "gray45"															# couleur des noeuds
	# V(x)$frame.color <- "black"
	# V(x)$shape <- "fcircle"
	# V(x)$frame.width <- .1
	# V(x)$label <- ""											# label (le nom qui s'affiche)
	# E(x)$width <- .1
	# E(x)$color <- "gray60"
	# x})		

# V(g1.list[[1]])$color <- "gray90"
# V(g1.list[[1]])$frame.color <- "#55555533"
# E(g1.list[[1]])$color <- "#55555533"

#####################
### Final network ###
#####################

g <- delete.vertices(g3, v = V(g3)[clusters(g3)$membership != 1])

#################################################################################################################################
save(	g, g2, g3, g4, g5, g6, g7, g8, g9, g10, g11, g12, g13, g14, g15, g16, g17, g18, g19, g20, g21, g22, g23, g24, g25,
		g0.list, g1.list,
		sub.g0.list, sub.g1.list,
		file="data/data0b.Rdata") ###
#################################################################################################################################


