#!/bin/bash

file_id="1n-2n_ZOTMleqa8qZ2nB8ALAbGFyN4-LJ"
name_file="pokemon_usage.csv"

#download
wget -q --no-check-certificate "https://docs.google.com/uc?export=download&id=$file_id" -O "$name_file"

print_help() {
    message=$1


    cat <<EOF
    ██╗████████╗░░░░░░░█████╗░░██╗░░
    ██║╚══██╔══╝░░░░░░██╔══██╗░██║░░
    ██║░░░██║░░░█████╗██║░░██║░██║░░
    ██║░░░██║░░░╚════╝██║░░██║░██║░░
    ██║░░░██║░░░░░░░░░╚█████╔╝░██║░░
    ╚═╝░░░╚═╝░░░░░░░░░░╚════╝░░╚═╝░░
    Welcome to Pokemon Analysis CLI!

EOF
    echo -e "     \e[31m$message\e[0m"

    cat <<EOF

    Usage:
      ./pokemon_analysis.sh <file.csv> <command> [options]

    Commands:
      --info            Show summary of Pokemon usage
      --sort <column_number>   Sort data by specified column
        column: 
$available_column
      --grep <name>     Search Pokemon by name
      --filter <type>   Filter Pokemon by type
      -h, --help        Show this help message

EOF
}

if [ $# -lt 2 ]; then
    print_help "Not enough arguments provided."
    exit 1
fi

FILE=$1
COMMAND=$2
OPTION=$3
available_column=$(awk -F, 'NR==1 { for (i=1; i<=NF; i++) print "\t\t" i ". " $i }' $FILE)


if [ ! -f "$FILE" ]; then
    echo "File $FILE does not exist."
    exit 1
fi

case $COMMAND in
    --info)
        echo "Summary of $FILE"
        cat pokemon_usage.csv | sort -t, -k2 -nr | head -1 | awk -F, '{print "Highest Adjusted Usage: "$1 " " $2}'
        cat pokemon_usage.csv | sort -t, -k3 -nr | head -1 | awk -F, '{print "Highest Raw Usage: "$1 " " $3 " uses"}'
        ;;

    --sort)
	if [ -z "$OPTION" ]; then
            print_help "no column number provided."
            exit 1
        fi

        n=$(head -1 $FILE | awk -F, '{print NF}')
	case_stmt="case \$OPTION in"
	for ((i=1; i<=n; i++)); do
	    case_stmt+="
            $i) COL=$i ;;"
	done
	case_stmt+="
            *) print_help \"Invalid sort column \$OPTION\"; exit 1 ;;
        esac"

        eval "$case_stmt"
	        (head -n 1 "$FILE" && tail -n +2 "$FILE" | sort -t, -k$COL,$COL $([ "$OPTION" == "1" ] && echo "" || echo "-nr"))
        ;;

    --grep)
        if [ -z "$OPTION" ]; then
            print_help "no search term provided."
            exit 1
        fi
        (head -n 1 "$FILE" )
	awk -F',' -v opt="$OPTION" 'tolower($1) ~ tolower(opt) {print; found=1} END {if (!found) print "Pokemon Not found"}' $FILE | sort -t, -k2 -nr
        ;;

    --filter)
        if [ -z "$OPTION" ]; then
            print_help "no filter option provided."
            exit 1
        fi
	(head -n 1 "$FILE")
        awk -F, -v type="$OPTION" 'tolower($4) == tolower(type) || tolower($5) == tolower(type)' $FILE | sort -t, -k2 -nr
        ;;
    -h|--help)
        print_help
        ;;
    *)
        print_help "Unknown command $COMMAND."
        exit 1
        ;;
esac
