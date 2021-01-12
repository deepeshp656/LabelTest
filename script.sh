#Define variable to store result of git diff and pattmatch state of matching files
PattFound="False"      

CHANGED_FILES=$(git diff --name-only remotes/origin/${{ github.base_ref }}...remotes/origin/${{ github.head_ref }})

#changing format of variable to array 
CHANGED_FILES_ARR=($CHANGED_FILES)
Path=($TGT_PATH)



    echo "PR safe for labeling and Auto approve!!"
    echo "::set-output name=comment::Pass"
fi
