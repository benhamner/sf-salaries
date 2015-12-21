
output/Salaries.csv:
	mkdir -p output
	python src/combine.py

csv: output/Salaries.csv

working/noHeader/Salaries.csv: output/Salaries.csv
	mkdir -p working/noHeader
	tail +2 $^ > $@

output/database.sqlite: working/noHeader/Salaries.csv
	-rm output/database.sqlite
	sqlite3 -echo $@ < src/import.sql
db: output/database.sqlite

output/hashes.txt: output/database.sqlite
	-rm output/hashes.txt
	echo "Current git commit:" >> output/hashes.txt
	git rev-parse HEAD >> output/hashes.txt
	echo "\nCurrent ouput md5 hashes:" >> output/hashes.txt
	md5 output/*.csv >> output/hashes.txt
	md5 output/*.sqlite >> output/hashes.txt
hashes: output/hashes.txt

release: output/database.sqlite output/hashes.txt
	zip -r -X output/release-`date -u +'%Y-%m-%d-%H-%M-%S'` output/*

all: csv db hashes release

clean:
	rm -rf working
	rm -rf output
