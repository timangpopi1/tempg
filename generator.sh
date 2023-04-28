KernelBuildDate="$(date +'%d%m%y')"
Changelog="changelog_${KernelBuildDate}.txt"
for i in $(seq 6);
do
        export After_Date=$(date --date="$i days ago" +%m-%d-%Y)
        k=$(expr ${i} - 1)
	    export Until_Date=$(date --date="$k days ago" +%m-%d-%Y)

	    # Line with after --- until was too long for a small ListView
	    echo '====================' >> $Changelog;
	    echo  "     "$Until_Date    >> $Changelog;
	    echo '====================' >> $Changelog;
	    # Cycle through every repo to find commits between 2 dates
        if [ ! -z "$REPO_EXEC" ]; then
	        $REPO_EXEC forall -pc 'git log --pretty=format:"%h  %s  [%cn]" --decorate --after=$After_Date --until=$Until_Date' >> $Changelog
        fi
	echo >> $Changelog;
        echo >> $Changelog;
done
