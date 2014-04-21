"readmhts"<-
function(file = "", freq = 1, start = 1, nx = 0)
{
	cat(title <- scan(file, what = "", sep = "\n", n = 1))
	commentcount <- 1
	while("#" == substring(scan(file, what = "", sep = "\n", n = 1, skip = 
		commentcount), first = 1, last = 1)) {
		commentcount <- commentcount + 1
	}
	cat("\n Univariate Time Series? (Y/N)")
	ans <- (as.character(readline()))[1]
	if(ans == "N" | ans == "n") {
		cat("\n Bivariate Time Series? (Y/N)")
		ans <- (as.character(readline()))[1]
		if(ans == "N" | ans == "n") {
			cat("\n Enter the integer of variates:")
			nx <- (as.integer(readline()))[1]
		}
		else {
			nx <- 1
		}
	}
	else {
		nx <- 0
	}
	cat("\n start = ")
	start <- as.numeric(eval(parse(text = readline())))
	cat("\n frequency = ")
	freq <- as.integer(readline())
	if(nx == 0) {
		x <- scan(file = file, skip = commentcount)
		mhts <- ts(x, start = start, frequency = freq)
	}
	else {
		x <- matrix(scan(file = file, skip = commentcount), ncol = nx + 
			1)
		if(nx == 1) {
			namests <- c("Y-series", "X-series")
			ts(x, frequency = freq, start = start, names = namests)
		}
		else {
			namests <- c("Y-series", paste(paste("X", 1:nx, sep = 
				""), "series", sep = "-"))
			mhts <- ts(x, frequency = freq, start = start, names = 
				namests)
		}
	}
	i <- nchar(title)
	while(substring(title, first = i, last = i) == " ") {
		i <- i - 1
	}
	title2 <- substring(title, first = 1, last = i)
	title2
	attr(mhts, "title") <- title2
	mhts
}
