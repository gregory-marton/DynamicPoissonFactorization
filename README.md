Dynamic Poisson factorization (dPF)
===================================

This repository provides the dynnormprec (Dynamic Normal Poisson factorization) recommendation tool.

Reference
---------

Dynamic Poisson factorization
by Laurent Charlin, Rajesh Ranganath, James McInerney and David Blei,
Rec'Sys 2015.

Acknowledgements
----------------

This code is built from a fork of Prem Gopalan's Poisson factorization
code (https://github.com/premgopalan/hgaprec).


Installation
------------

Required libraries: gsl, gslblas, pthread, openMP

On Linux/Unix run

  `aclocal && automake --add-missing && ./configure && make`

On Mac OS (untested):

Automake may not be properly installed even with XCode. You may need
to get that, and

before you can successfully `configure`. An error about an outdated
'missing' file is indicative.

The location of the required gsl, gslblas, pthread, and openMP
libraries may need to be specified:

E.g. with macports

  `./configure LDFLAGS="-L/opt/local/lib" CPPFLAGS="-I/opt/local/include" && make`

Or with homebrew,

  `./configure CXX=g++-6 LDFLAGS="-L/usr/local/Cellar/gsl/2.2.1/lib" CFLAGS="-stdlib=libstdc++ -I/usr/local/Cellar/gsl/2.2.1/include" && make`

If you `make install`, the binary 'dynnormprec' will be installed in /usr/local/bin unless a
different prefix is provided to configure. (See `./INSTALL`.)


Running
-------

./dynnormprec -dir data\_dir -n num\_users -m num\_items -k num\_factors [-rfreq] [-vprior] [-binary-data]

*Required arguments*

- -dir <string>    path to dataset directory with 3 files:
   		    train.tsv, test.tsv, validation.tsv
		    (for examples, see data/)
- -n <int>	  number of users
- -m <int>	  number of items
- -k <int>	  number of factors

*Optional arguments*

- -rfreq <int>	  assess convergence and compute other stats every <int> number of iterations
		  [default: 10]
- -vprior         set variance hyperparameters [default 10]
- -non-binary-data	  treat observed data as non-binary (warning the code is untested w/o this option) [default false]
- -num_threads    set the number of parallel threads to run [default 1]
- -tpl            length of each time period (measured in seconds) [default 6*30 days ~ 6 months]

Example
--------

1. Input data. To run inference you need 4 files: {train,test,validation,test_users}.tsv in tab-separated format.
   See the lastFM files in `dat/`. To use this dataset you will first need
   to uncompress the data files (e.g., for train.tsv.gz `gunzip
   train.tsv.gz` and similarly with validation.tsv.gz and test.tsv.gz)

2. Running the command. We recommend running dynnormprec using the following options:

 `./src/dynnormprec -n 992 -m 983 -dir dat/ -k 5 -rfreq 10 -vprior 10 -num_threads TH;`

  - TH is the number of available CPUs on the machine.
  - Changing the number of factors and the variance hyperparameters will
      have an effect on the quality of the resulting model.
