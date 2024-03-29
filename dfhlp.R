# vi: ft=r fdm=marker

# Is {{{1
################################################################

#' Test type of a data frame.
#'
#' This method tests if the columns of a data frame are all of the same type.
#'
#' @param   df      The data frame.
#' @param   type    The type you expect the columns to have. It must be one of the R base types: 'character', 'factor', 'integer', 'numeric' or 'logical'.
#'
#' @return  \code{TRUE} or \code{FALSE}.
#'
#' @examples
#' # Test if a data frame contains only integers
#' df <- data.frame(a = c(1, 4), b = c(6, 5))
#' df.is(df, 'integer') # should return FALSE since in R all integers are converted to numeric by default.
#' df.is(df, 'numeric') # should return TRUE.
#' 
#' @export
df.is <- function(df, type) {
	return(all(vapply(df, function(v) methods::is(v, type), FUN.VALUE = FALSE)))
}

# Force numeric {{{1
################################################################

#' Convert data frame to numeric.
#'
#' Converts integer columns of a data frame into numeric.
#'
#' @param df    The data frame.
#' @param cols  The set of columns to convert to numeric. By default (when set to \code{NULL}) all integer columns are converted. Set it to a character vector containing the names of the columns you want to convert, or ton integer vector containing the indices of the columns. Can be used to force conversion of non integer columns.
#'
#' @return The converted data frame.
#'
#' @examples
#' # Convert an integer data frame
#' df <- data.frame(a = as.integer(c(1, 4)), b = as.integer(c(6, 5)))
#' df <- df.force.numeric(df)
#'
#' @export
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

#' Data frame loading from a file.
#'
#' Reads a data frame from a file and possibly convert integer columns to numeric. This method calls the built-in \code{read.table()} method and then \code{df.force.numeric()}.
#'
#' @param   file            The path to the file you want to load. See \code{read.table()\} documentation for more information.
#' @param   force.numeric   If set to TRUE, all integer columns will be converted to numeric.
#'
#' @return  The loaded data frame.
#'
#' @examples
#' \dontrun{}
#' # Load a data frame from a file and convert integer columns
#' df <- df.read.table('/my/path/to/my/csv/file.csv', sep = ',', force.numeric = TRUE)
#' }
#'
#' @export
df.read.table <- function(file, force.numeric = FALSE, ...) {

	df <- read.table(file, ...)

	if (is.logical(force.numeric) && force.numeric)
		df <- df.force.numeric(df)

	else if (is.integer(force.numeric) || is.character(force.numeric))
		df <- df.force.numeric(df, cols = force.numeric)

	return(df)
}
