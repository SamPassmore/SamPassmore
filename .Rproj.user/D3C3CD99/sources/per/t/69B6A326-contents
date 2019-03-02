+++
title = "How to use bayestraitr"

date = 2018-09-09T00:00:00
# lastmod = 2018-09-09T00:00:00

draft = false  # Is this a draft? true/false
toc = true  # Show table of contents? true/false
type = "docs"  # Do not modify.

# Add menu entry to sidebar.
linktitle = "bayestraitr 101"
[menu.tutorial]
  parent = "R Packages"
  weight = 1
+++

I've been using BayesTraits for the last year or so, and had developed some packages to make it easy to create data for BayesTraits and to read in the output - which I've put into the R package `bayestraitr`.

You can check out the code and some more examples on the [github page](https://github.com/SamPassmore/bayestraitr)

Here I will walk through how to use it! 

## Installing

To install this package run this line:

`devtools::install_github('SamPassmore/bayestraitr')`

and load with

`library(bayestraitr)`

## Reading output files

There are three functions in this package at the moment for reading in BayesTrait *.Log files, *.Schedule files, & *.Stones

`log = bt_read.log('./bayestrait_output/Artiodactyl.txt.Log.txt')`

Will return a dataframe of the log matrix. The file header are contained as an attribute which can be accessed by using `attributes(log)$settings`

`schedule = bt_read.schedule('./bayestrait_output/Artiodactyl.txt.Schedule.txt')`

This returns one data.frame with the contents of the Schedule file.

`stones = bt_read.stones('./bayestrait_output/Artiodactyl.txt.Stones.txt')`

This returns a list of 2 items. stones_sampling holds the logging for the stones sampling, & marginal_likelihood holds the marginal log-likelihood. The stones file header can be found in the attributes by using the code `attributes(stones)$settings`

## Writing input files

The function `bt_write` takes various tree types (e.g. phylo & multiphylo) and data.frame input and writes them as input files for BayesTraits.

This function is probably a bit temperamental. Please log any issues you have with it.

```
library(ape)
tree = read.nexus('bayestraits_output/Artiodactyl.trees')
data = read.csv('bayestraits_output/Artiodactyl.tsv', sep = "\t")
rownames(data) = data$taxa
bt_write(tree = tree, data = data, variables = 'trait1', filename = 'test')
```