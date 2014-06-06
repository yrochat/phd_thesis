#############################
### All plot nodes as one ###
#############################

noms.complot <- c("Louise d'Épinay", "Grimm", "Diderot", "Baron d'Holbach", "d'Alembert", "Boufflers-Rouverel" #, "Choiseul", "Tronchin", "Voltaire"
)

# complot <- sapply(noms.complot, function(x) grep(x, V(g)$name))
# noms.complet <- V(g)[complot]$name

# grep("Voltaire", V(g)$name)
# grep("Tronchin", V(g)$name)

# contract.vertices : doesn't really work, result is weird

### We should build the network from scratch !
### and keep the layout !

#######################################
### Création du graphe FINAL ajusté ###
#######################################

### ATTENTION cette méthode fait la contraction avant la projection du graphe, ce qui fait qu'il y a tout d'un coup quelques personnes connectées au noeud contracté qui n'auraient pas dû l'être…

hey <- sapply(noms.complot, function(x) grep(x, confessions$full))
# contrôle :
# for (i in 1:length(hey)) print(confessions[hey[[i]],])

hey2 <- do.call(c, hey)
names(hey2) <- NULL

confessions3 <- confessions
confessions3$full[hey2] <- "Schemers"

confessions2 <- confessions1 <- confessions3

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

input <- input[!duplicated(input[,1:2]),]

gx.bip <- graph.data.frame(input, directed=FALSE)							# La création du graphe (qui est biparti, du coup)
V(gx.bip)$types <- FALSE													# On donne l'étiquette FALSE aux personnages
V(gx.bip)[1:length(unique(input$page))]$types <- TRUE						# On donne l'étiquette TRUE aux pages

# On fait la projection sur les noeuds FALSE, c'est-à-dire que deux
# personnages sont liés s'ils étaient connectés dans le graphe biparti
# à la même page des Confessions

gx <- bipartite.projection(gx.bip, type=V(gx.bip)$types, multiplicity = TRUE)$proj2 
gx <- subgraph.edges(gx, E(gx)[weight>2])
gx <- delete.vertices(gx, v = V(gx)[clusters(gx)$membership != 1])

rm(confessions1, confessions2, confessions3, input)

V(gx)$id <- 1:vcount(gx)

# les sommets : V(g1)$name[V(g1)$name %in% V(gx)$name]
# on prend leurs coordonnées
temp.layout <- g1$layout[V(g1)$name %in% V(gx)$name,]

# où sont les complotistes : grep("Schemers", V(gx)$name)
gx$layout <- rbind(temp.layout[1:(grep("Schemers", V(gx)$name)-1),], c(1,0), temp.layout[grep("Schemers", V(gx)$name):nrow(temp.layout),])

# tkplot(gx)
# tkplot(g)

# gx$layout <- layout.norm(tkplot.getcoords(8), xmin = -1, xmax = 1, ymin = -1, ymax = 1)

############
### PLOT ###
############

clusters(gx)

V(gx)$size <- .5 + log2(degree(gx)+1)
V(gx)$color <- "gray99"

V(gx)$color[grep("Schemers", V(gx)$name)] <- "grey70"

V(gx)$frame.color <- "black"
V(gx)$shape <- "fcircle"
V(gx)$frame.width <- 1
V(gx)$label <- ""
V(gx)$label.cex <- .5

E(gx)$width <- .5
E(gx)$color <- "gray10"

E(gx)[from("Schemers")]$color <- "grey70"

pdf("~/Dropbox/sharelatex/my_thesis/figs/ch5/contraction.pdf")
par(mar = c(0,0,0,0))
plot(gx)
dev.off()	




#################################################################################################################################
save(	gx, 
		file="data/data0y.Rdata") ###
#################################################################################################################################



# # 
# pdf("g1.pdf")
# plot(g1, vertex.label = "", vertex.size = .5, rescale = FALSE)
# dev.off()

# pdf("g.pdf")
# plot(g, vertex.label = "", vertex.size = .5, rescale = FALSE)
# dev.off()

# pdf("gx.pdf")
# plot(gx, vertex.label = "", vertex.size = .5, rescale = FALSE)
# dev.off()
