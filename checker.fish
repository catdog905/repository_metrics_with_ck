#!/usr/bin/env fish

set file_path "repositories.txt"

# Check if the file exists
if test -f $file_path
    # Read the file line by line
    for line in (cat $file_path)
        # Execute your commands for each line
        echo "Processing: $line"
	set last_word (basename $line)
        echo "Name: $last_word"
	if contains $last_word (ls -1 collected_metrics)
		echo "Skipping: $last_word"
		continue
	end
        git clone $line
	mkdir collected_metrics/$last_word
	cd collected_metrics/$last_word
	java -jar /home/yaroslav/GithubRepos/ck/target/ck-0.7.1-SNAPSHOT-jar-with-dependencies.jar ../../$last_word
	cd ../../
	rm -r $last_word
        # Add more commands as needed
    end < $file_path
else
    echo "File not found: $file_path"
end

