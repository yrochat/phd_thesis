# please see https://github.com/yrochat/phd_thesis/blob/master/README.md before first use

# this command will delete everything in your working space

rm(list=ls())

# choose any working directory
# everything is stocked inside : data and scripts

setwd("~/Dropbox/DHLab/PhD_thesis/")

library(igraph)
library(xtable)
library(ggplot2)
library(scales)
library(RColorBrewer)
library(gridExtra)

# to modify the vertex frame width : use "fcircle" as shape
source("init/vertex_frame_width.R")

# Here is what we obtain after executing "main0.R"

# confessions		# the index of characters, pages and chapters
# livres			# to which chapter a page corresponds

# g 				# final graph : giant component of g3

# g1.bip 			# bipartite graph with co-occurrences +/- 1
# g1	 			# projected on nodes 
# g1.list			# list of projections with varying thresholds
# sub.g1.list	# corresponding giant components

# g0.bip			# bipartite graph with page co-occurrences
# g0				# projected on nodes
# g0.list			# list of projections with varying thresholds
# sub.g0.list	# corresponding giant components

# g1, g2, g3, g4, ... g[n] # graphs with threshold equal to [n]
# gchap				# graphs for chapters
# gx				# contracted graph around the plot

############################################
### GENERATION OF NAIVE AND FINAL GRAPHS ###
############################################

# source("init/0_1_graph_generation.R")
load("data/data0a.Rdata")

###############################
### GENERATION OF SUBGRAPHS ###
###############################

# source("init/0_2_subgraph_generation.R")
load("data/data0b.Rdata")

############################################
### GENERATION OF SUBGRAPHS PER CHAPTERS ###
############################################

# source("init/0_3_subgraph_chapters.R")
load("data/data0c.Rdata")

##############################################
### GENERATION OF LAYOUT FOR THE SUBGRAPHS ###
##############################################

# source("init/0_4_layout_generation.R")
load("data/data0z.Rdata")

################################################
### GENERATION OF THE PLOT CONTRACTION GRAPH ###
################################################

# source("init/0_5_contraction.R")
load("data/data0y.Rdata")




# this is for the initialisation/loading
# then for the visulisation/analysis comes "main.R"