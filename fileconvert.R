# settings

size_of_file_limit_in_megs = 100

#select file

a_file_name <- file.choose()

# orignal filename
file_path_without_ext <- strsplit(a_file_name, "\\.")[[1]][1]
file_ext <- strsplit(a_file_name, "\\.")[[1]][2]
file_basename <- basename(a_file_name)

print (paste("filename is", file_basename))

timestamp <- format(Sys.time(), "%y%m%d%H%M")

# new filename
file_name <- paste0(file_path_without_ext, "-", timestamp, ".", file_ext)
file_path_without_ext <- strsplit(file_name, "\\.")[[1]][1]
file_ext <- strsplit(file_name, "\\.")[[1]][2]
file_basename <- basename(file_name)
if (file_ext == "NA") file_ext <-""

print (paste("new filename is", file_basename))


print("reading started...")
print("...it may take some time..")
print("...please wait...")
dataset <- read.csv(a_file_name)
print("reading finished")
print("conversion started...")

# add row_nums
row_num <- 1:nrow(dataset)
dataset  <- cbind(row_num, dataset)
print("added row_nums as an extra column")


size_of_input_file_in_bytes <- object.size(dataset)
size_of_input_file_in_megs <- size_of_input_file_in_bytes / (1024 * 1024)

print(paste("size of file is",size_of_input_file_in_bytes,"Bytes"))


if (size_of_input_file_in_megs > size_of_file_limit_in_megs) {
  print("splitting file in pieces")
  
  # calculate number of files
  
  num_of_data_points_input_file <- nrow(dataset) * ncol(dataset)
  
  size_per_datapoint_in_bytes = size_of_input_file_in_bytes / num_of_data_points_input_file
  size_per_datapoint_in_megs  = size_per_datapoint_in_bytes / 10 ^ 6
  
  num_data_points_per_piece <-
    size_of_file_limit_in_megs / size_per_datapoint_in_megs
  num_rows_per_piece <-
    floor(num_data_points_per_piece / ncol(dataset))
  num_pieces <- floor((nrow(dataset) / num_rows_per_piece)) + 1
  
  # write pieces
  print(
    paste(
      "splitting",
      file_basename,
      "into",
      num_pieces,
      "pieces",
      "each with",
      num_rows_per_piece,
      "rows"
    )
  )
  
  for (i in 1:num_pieces) {
    start_index <- (num_rows_per_piece * (i - 1)) + 1
    end_index  <- start_index + num_rows_per_piece - 1
    
    if (i == num_pieces)
      end_index <- nrow(dataset)
    
    print (paste("piece", i, "rows from",  start_index, "to", end_index))
    
    piece_name <-
      paste0(file_path_without_ext, "_", i, ".", file_ext)
    print(piece_name)
    
    if (file.exists(piece_name))
      file.remove(piece_name)
    
    write.csv(dataset[start_index:end_index,], file = piece_name, row.names = FALSE)
    
  }
} else {
  write.csv(dataset, file = file_name, row.names = FALSE)
}

print ("conversion finished")
