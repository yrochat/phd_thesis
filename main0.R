rm(list=ls())

setwd("~/Dropbox/DHLab/PhD_thesis/")

library(igraph)
library(xtable)
library(ggplot2)
library(scales)
library(RColorBrewer)
library(gridExtra)

# g 				# final graph : giant component of g3

# g1  	 			# bipartite graph with co-occurrences +/- 1
# g1.id	 			# projected on nodes 
# g1.id.list		# list of projections with varying thresholds
# sub.g1.id.list	# corresponding giant components

# g0				# bipartite graph with page co-occurrences
# g0.id				# projected on nodes
# g0.id.list		# list of projections with varying thresholds
# sub.g0.id.list	# corresponding giant components

# to modify the vertex frame width : use "fcircle" as shape
source("scripts/9_vertex_frame_width.R")

####################################################
### GENERATION DU GRAPHE NAIF ET DU GRAPHE FINAL ###
####################################################

# source("scripts0/0_1_graph_generation.R")

load("data/data0a.Rdata")

###################################
### GENERATION DES SOUS-GRAPHES ###
###################################

# source("scripts0/0_2_subgraph_generation.R")

load("data/data0b.Rdata")

#################################################
### GENERATION DES SOUS-GRAPHES DES CHAPITRES ###
#################################################

# source("scripts0/0_3_subgraph_chapters.R")

load("data/data0c.Rdata")

###############################################
### GENERATION DES LAYOUTS DES SOUS-GRAPHES ###
###############################################

# source("scripts0/0_4_layout_generation.R")

load("data/data0z.Rdata")

#################################################
### GENERATION DU GRAPHE CONTRACTE DU COMPLOT ###
#################################################

# source("scripts0/0_5_contraction.R")

load("data/data0y.Rdata")



# and then comes "main.R"