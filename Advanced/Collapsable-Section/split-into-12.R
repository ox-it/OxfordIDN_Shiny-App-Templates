
list_of_numbers <- 1:16

scales::

floor(length(list_of_numbers) / 6)

?'%%'

12 %% 2 == 0

slice<-function(x,n) {
  N<-length(x);
  lapply(seq(1,N,n),function(i) x[i:min(i+n-1,N)])
}


split_into_columns <- function(data = NULL, column_width = NULL){
  if(length(data) %% column_width == 0){
    slice(1:10,  2)
  }
}
