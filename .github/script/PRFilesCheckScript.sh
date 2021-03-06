#!/bin/bash
#Define variable to store result of git diff and pattmatch state of matching file            
PattFound="False"      


CHANGED_FILES=$(git diff --name-only origin/"$BASEBRANCH"...origin/"$HEADBRANCH")
#changing format of variable to array 


#iterate each file to match with pattern mentioned in TGT_Files in format of path/prefix-of-file or path


       # make newlines the only separator



for i in  $CHANGED_FILES
  do
  
	 for j in  $TGT_PATH
		 do	
			echo $i searching  $j		 
			 #matching files with Path pattern TGT_PATH
			 if [[ ("$i" == "$j"* )]]; then
			 
				#will exit the internal loop if match found
				PattFound="True"
				break
			 
			 else
			 
				PattFound="False"
				
			 fi
		 done
   
	 #after each iteration if any files found which is not under the TGT_PATH patter workflow will exit 
	 if [[ ("$PattFound" == "False" )]]; then
		  echo "PR contains changes which cannot be auto-approve"
		  echo "::set-output name=comment::unintented files changed"
		  exit 0
	 fi
  done

#Getting info of files changed in PR 
git diff --unified=0 origin/"$BASEBRANCH"...origin/"$HEADBRANCH" >File.txt
		
 


# removing base line with -- and getting remaing info of the Files changed
				
	grep -v '^\-\-' File.txt >FilterFile.txt



if grep -q '^\-' FilterFile.txt; then
	echo "PR contains files with deleted or modified lines!!"
	echo "::set-output name=comment::Lines were Deleted or Modified"
	exit 0
else
	echo "PR safe for labeling and Auto approve!!"
	echo "::set-output name=comment::Pass"
fi

