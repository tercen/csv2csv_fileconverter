# cvs2cvs file converter

#### Description
`cvs2cvs` converts a cvs file by adding a `row_num` column and splitting the original cvs file into pieces.

##### Usage

__How to run__

Run the following for Windows:

`git clone https://github.com/tercen/csv2csv_fileconverter`

`cd csv2csv_fileconverter`

double click `run-win.bat` 

A dialog appears for user to choose a csv file to convert

__Input file__

Takes a cvs file as input

__Parameters__

`size_of_file_limit_in_megs` represents the max size allowed


`RSCRIPT_EXE` represents the location of the RScript.exe

__Output file__

Same name as the input file but with a timestamp


##### Details

It converts a cvs file by adding a `row_name` column.
The file is split into pieces, if the file size is greater than the value of `size_of_file_limit_in_megs`.

#### References

##### See Also

#### Examples
