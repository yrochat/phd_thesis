phd_thesis
==========

Data and scripts used for my Ph.D. thesis on character network analysis. As of today (2014/06/06), the thesis hasn't been defended yet (this will probably happen end of summer).


First use
---------

The first time you use the script, you have the choice either to use the pre-compiled data, or to compile them yourselves. In the first case [main0.R](https://github.com/yrochat/phd_thesis/blob/master/main0.R) as it is. In the second case, open it – [main0.R](https://github.com/yrochat/phd_thesis/blob/master/main0.R) – and un-comment all the five "source" entries. This will load the initial data (the index) and read, sort and turn them into a bipartite graph, then project, sort clusters, etc. You won't need to do that again, and can keep the original file in the state it is now.