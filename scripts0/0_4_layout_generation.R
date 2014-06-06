

# # Le layout du graphe final, pris comme référence (= 3)
# g3$layout <- layout.norm(layout.fruchterman.reingold(g3, repulserad = vcount(g3)^2.5, niter = 1000), -1, 1, -1, 1)

# pdf("g3.pdf")
# plot(g3, vertex.label = "", vertex.size = 5, vertex.color = "white")
# dev.off()

# # Les layouts induits pour les graphes (< 3)

# g2$layout <- layout.random(g2) # already normalized \in [-1,1]^2

# i <- 1
# repeat {
	# g2$layout[V(g2)$name %in% V(g3)$name,] <- g3$layout
	# g2$layout <- layout.norm(layout.fruchterman.reingold(g2, niter = 5, repulserad = 1, maxdelta = 1, start = g2$layout, area = 1), -1, 1, -1, 1)
	# if (i == 100) break
	# else i <- i+1
# }

# V(g2)$color <- "white"
# V(g2)[V(g2)$name %in% V(g3)$name]$color <- "red"

# pdf("g2.pdf")
# plot(g2, vertex.label = "", vertex.size = 5)
# dev.off()



#################################################################################################
### Nouvelle tentative, cette fois en commençant par g1 puis en descendant à g3 et les autres ###
#################################################################################################

g1$layout <- layout.norm(layout.fruchterman.reingold(g1, niter = 1500, repulserad = vcount(g1)^2.75), -1, 1, -1, 1)

V(g1)$color <- "white"
V(g1)[V(g1)$name %in% V(g3)$name]$color <- "red"

# pdf("g1.pdf")
# plot(g1, vertex.label = "", vertex.size = 5, rescale = FALSE)
# dev.off()

# pdf("g2.pdf")
# plot(g2, vertex.label = "", vertex.size = 5, rescale = FALSE)
# dev.off()

# pdf("g3.pdf")
# plot(g3, vertex.label = "", vertex.size = 5, rescale = FALSE)
# dev.off()

##################################################
### Les layouts induits pour les graphes (> 1) ###
##################################################

g2$layout <- g1$layout[V(g1)$name %in% V(g2)$name,]
g3$layout <- g1$layout[V(g1)$name %in% V(g3)$name,]
g4$layout <- g1$layout[V(g1)$name %in% V(g4)$name,]
g5$layout <- g1$layout[V(g1)$name %in% V(g5)$name,]
g6$layout <- g1$layout[V(g1)$name %in% V(g6)$name,]
g7$layout <- g1$layout[V(g1)$name %in% V(g7)$name,]
g8$layout <- g1$layout[V(g1)$name %in% V(g8)$name,]
g9$layout <- g1$layout[V(g1)$name %in% V(g9)$name,]
g10$layout <- g1$layout[V(g1)$name %in% V(g10)$name,]
g11$layout <- g1$layout[V(g1)$name %in% V(g11)$name,]
g12$layout <- g1$layout[V(g1)$name %in% V(g12)$name,]
g13$layout <- g1$layout[V(g1)$name %in% V(g13)$name,]
g14$layout <- g1$layout[V(g1)$name %in% V(g14)$name,]
g15$layout <- g1$layout[V(g1)$name %in% V(g15)$name,]
g16$layout <- g1$layout[V(g1)$name %in% V(g16)$name,]
g17$layout <- g1$layout[V(g1)$name %in% V(g17)$name,]
g18$layout <- g1$layout[V(g1)$name %in% V(g18)$name,]
g19$layout <- g1$layout[V(g1)$name %in% V(g19)$name,]
g20$layout <- g1$layout[V(g1)$name %in% V(g20)$name,]
g21$layout <- g1$layout[V(g1)$name %in% V(g21)$name,]
g22$layout <- g1$layout[V(g1)$name %in% V(g22)$name,]
g23$layout <- g1$layout[V(g1)$name %in% V(g23)$name,]
g24$layout <- g1$layout[V(g1)$name %in% V(g24)$name,]
g25$layout <- g1$layout[V(g1)$name %in% V(g25)$name,]


# pdf("g3.pdf")
# plot(g3, vertex.label = "", vertex.size = 5)
# dev.off()

#################################################
### Les layouts pour les graphes par chapitre ###
#################################################

gchap[[1]]$layout <- g1$layout[V(g1)$name %in% V(gchap[[1]])$name,]
gchap[[2]]$layout <- g1$layout[V(g1)$name %in% V(gchap[[2]])$name,]
gchap[[3]]$layout <- g1$layout[V(g1)$name %in% V(gchap[[3]])$name,]
gchap[[4]]$layout <- g1$layout[V(g1)$name %in% V(gchap[[4]])$name,]
gchap[[5]]$layout <- g1$layout[V(g1)$name %in% V(gchap[[5]])$name,]
gchap[[6]]$layout <- g1$layout[V(g1)$name %in% V(gchap[[6]])$name,]
gchap[[7]]$layout <- g1$layout[V(g1)$name %in% V(gchap[[7]])$name,]
gchap[[8]]$layout <- g1$layout[V(g1)$name %in% V(gchap[[8]])$name,]
gchap[[9]]$layout <- g1$layout[V(g1)$name %in% V(gchap[[9]])$name,]
gchap[[10]]$layout <- g1$layout[V(g1)$name %in% V(gchap[[10]])$name,]
gchap[[11]]$layout <- g1$layout[V(g1)$name %in% V(gchap[[11]])$name,]
gchap[[12]]$layout <- g1$layout[V(g1)$name %in% V(gchap[[12]])$name,]

g$layout <- layout.norm(g1$layout[V(g1)$name %in% V(g)$name,], xmin = -1, xmax = 1, ymin = -1, ymax = 1)


#######################
### Attributes of G ###
#######################

V(g)$size <- .5 + log2(degree(g)+1)
V(g)$color <- "gray99"

V(g)$frame.color <- "black"
V(g)$shape <- "fcircle"
V(g)$frame.width <- 1
V(g)$label <- ""
V(g)$label.cex <- .5

E(g)$width <- .5
E(g)$color <- "gray10"



#################################################################################################################################
save(	g, g1, g2, g3, g4, g5, g6, g7, g8, g9, g10, g11, g12, g13, g14, g15, g16, g17, g18, g19, g20, g21, g22, g23, g24, g25,
		gchap,
#		g0.list, g1.list,
#		sub.g0.list, sub.g1.list,
		file="data/data0z.Rdata") ###
#################################################################################################################################




















