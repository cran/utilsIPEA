# utilsIPEA  [![Build Status](https://travis-ci.org/ipea/utilsIPEA.svg?branch=master)](https://travis-ci.org/ipea/utilsIPEA)
This package has the most common functions used at IPEA.

## Installation

The package is on CRAN, so to install it just the command:

```{r eval=FALSE}
install.packages("utilsIPEA") 
````

## Contributing 

To add new functions to this package, it is needed to create a new breach with the new code and submit a 
pull request to branch master. 

To create the new branch using git command line use the command:

```{r eval=FALSE}
git checkout -b name_of_new_branch
````

To do it on RStudio just click on Tools >> Shell. On the new opened window type the command above. 

After adding the new code and [**tests**](http://r-pkgs.had.co.nz/tests.html#test-tests) commit the changes to the git repository and check on [travis](https://travis-ci.org/ipea/utilsIPEA) 
if it has been build correctly. 

Now, the code is ready to be incorporated to master branch. To do so, a [pull request](https://help.github.com/articles/about-pull-requests/) has to be made to branch master. 



