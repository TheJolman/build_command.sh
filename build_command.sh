#!/bin/bash

# Function to compile all .cpp files in the current directory
build() {
    # Default output file name
    output_file="a.out"

    # Check for -o option to specify output file name
    while getopts ":o:" opt; do
        case $opt in
            o)
                output_file="$OPTARG"
                ;;
            \?)
                echo "Invalid option: -$OPTARG" >&2
                return 1
                ;;
            :)
                echo "Option -$OPTARG requires an argument." >&2
                return 1
                ;;
        esac
    done

    # Shift to remove parsed options
    shift $((OPTIND-1))

    # Compile all .cpp files
    clang++ *.cpp -o "$output_file"

    # Check if compilation was successful
    if [ $? -eq 0 ]; then
        echo "Compilation successful. Output file is $output_file."
    else
        echo "Compilation failed."
    fi
}

# Export the function to make it available as a command
export -f build

