#README FILE

##1. Extract Test Data
*Read the value data of the test folder
*Read the activity of the test folder
*Read the subjects of the test folder

##2. Extract Train Data
*Read the value data of the train folder
*Read the activity of the train folder
*Read the subjects of the train folder

##3. Extract Refence Data
*Read the columns names from the features file
*Read the activitys description from de activity file

At this point you have all the data you need, we can start the merge


##4. Union Similar tables
Considering that the initial data was separate in two groups, train y test, we should get then together again.
With te rbind() function we asing the append data:
*x for the value data
*y for the activitys
*subject for the subjects

##5. Filter columns
*Create a logical vector head_filter to indicate the features that contain the "mean" and "std" words.
*Assign the features vector to the name vector of the value data x
*Filter de columns using the logical vector

##6. Binding data
*Assign descriptive name to the subject and activity data
*Column Bind to the value data x

##7. Join Reference data
*Assgn descriptive name to the activity reference table
*Merge with the value data to append a new column with the descriptive activity

##8. Set descriptive variable names
*Create two vector, one with the patters of the columns names, and the other with te descriptive name.
*Replace each patter with the descriptive name in a for loop

At this point we complete the fist 4 steps of analysis. With this tidy data we create another data frame x5

##9. Create a Independent tidy data
* With the aggregate function we generate another data x5 with the mean of all the data grouping by activity and subject