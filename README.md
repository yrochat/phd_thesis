phd_thesis
==========

Data and scripts used for my PhD thesis in Digital Humanities called "Character Networks and Centrality", defended on 2014/09/19 and 2014/12/12 at [University of Lausanne](www.unil.ch).

The thesis can be downloaded here: http://infosciences.epfl.ch/record/203889?ln=en


First use
---------

The first time you use the script, you have the choice either to use the pre-compiled data, or to compile them yourselves. 
In the first case [main0.R](https://github.com/yrochat/phd_thesis/blob/master/main0.R) as it is. 
In the second case, open it – [main0.R](https://github.com/yrochat/phd_thesis/blob/master/main0.R) – and un-comment all the five "source" entries. 
This will load the initial data (the index) and read, sort and turn them into a bipartite graph, then project, sort clusters, etc. You won't need to do that again, and can keep the original file in the state it is now.

In our case here, the data files are [names.txt](https://github.com/yrochat/phd_thesis/blob/master/init/names.txt), that is a list of all characters along with a unique ID, and [apparitions_par_pages.txt](https://github.com/yrochat/phd_thesis/blob/master/init/apparitions_par_pages.txt). In the latter, each line is an occurrence. Columns are: 

1. The character unique ID
2. The volume 
3. The page
4. "n" if the occurrence is inside a footnote.
