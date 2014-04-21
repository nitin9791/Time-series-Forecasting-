.BG
.FN readmhts
.TL
Input a time series in the Hipel-McLeod time series datasets
.DN
All data files in this collection which have an extension such as
.1, .2 , etc.  can be input to S with this function. In general
the this format has a title string as the first record. Lines 
immediately following the title string are comments if there is
a # in column 1. For a univariate time series, the remaining 
records are just the time series in any format in chronological 
order. For multivariate time series, the first variate is given 
as the first block of records, the second variate as the next block 
of records and so forth. Note that the extension, .1, .2, etc. refers
to the dimension of the time series (1=univariate, 2=bivariate, etc.).
.CS
readmhts(file, freq=1, start=1, nx=0)
.RA
.AG file
Data file for a time series. First line contains a title string.
The lines immediately following the title string that begin with
a # character are comments and these are ignored. The remaining lines 
contain the time series in chronological order.
.OA
.AG freq
seasonal period, eg 12 for monthly data
.AG start
starting date if applicable otherwise 1 
.AG nx
number of covariate series
.RT
a ts data type is returned. The title is added to this data type as
an additional attribute with name "title".
.SE
You are prompted to determine if the series is univariate, bivariate or 
multivariate. In the multivariate case (k>2), you are prompted for the number
of variates, k.
.KW time series
.WR


