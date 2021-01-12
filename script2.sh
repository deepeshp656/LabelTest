#Define variable to store result of git diff and pattmatch state of matching files
            PattFound="False"      
            
            CHANGED_FILES=$(git diff --name-only remotes/origin/$Base...remotes/origin/$Head )
            
            #changing format of variable to array 
            CHANGED_FILES_ARR=($CHANGED_FILES)
            Path=($TGT_PATH)

