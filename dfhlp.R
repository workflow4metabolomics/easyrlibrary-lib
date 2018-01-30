# vi: ft=r fdm=marker

# Force numeric {{{1
################################################################

df.force.numeric <- function(df, cols = NULL) {

	if ( ! is.null(df)) {

		# Convert all columns
		if (is.null(cols))
			df <- as.data.frame(lapply(df, function(v) if (is.integer(v)) as.numeric(v) else v))

		# Convert only the specified columns
		else
			for (c in cols)
				df[[c]] <- as.numeric(df[[c]])
	}

	return(df)
}

# Read table {{{1
################################################################

df.read.table <- function(file, force.numeric = FALSE, ...) {

	df <- read.table(file, ...)

	if (is.logical(force.numeric) && force.numeric)
		df <- df.force.numeric(df)

	else if (is.integer(force.numeric) || is.character(force.numeric))
		df <- df.force.numeric(df, cols = force.numeric)

	return(df)
}
