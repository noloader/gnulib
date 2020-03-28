#!/usr/bin/env bash

this_dir=$(pwd)
test_dir=$(dirname $(pwd))/gnulib_test

rm -rf "$test_dir"
mkdir -p "$test_dir"

result_file=$(pwd)/result.txt
module_list=$(find modules -name '*tests' | sed -e 's|^modules/||g' -e 's|-tests$||g' | sort | head -n 32)

# Eventual return code
failed_rests=0

for module in $module_list
do
    columns=$(tput cols)
    header="****************************************"
    printf "%*s\n" $(((${#header}+$columns)/2)) "$header" | tee -a "$result_file"
    printf "%*s\n" $(((${#module}+$columns)/2)) "$module" | tee -a "$result_file"
    printf "%*s\n" $(((${#header}+$columns)/2)) "$header" | tee -a "$result_file"

    cd "$this_dir" || exit 1

    if ! ./gnulib-tool --create-testdir --dir="$test_dir/$module" "$module" 1>/dev/null;
    then
        echo "Failed to prepare $module" | tee -a "$result_file"
        failed_rests=$((failed_rests+1))
        continue
    fi

    cd "$test_dir/$module" || exit 1

    if ! ./configure;
    then
        echo "Failed to configure $module" | tee -a "$result_file"
        failed_rests=$((failed_rests+1))
        continue
    fi

    # Travis offers two cores
    if ! make -j 3;
    then
        echo "Failed to make $module" | tee -a "$result_file"
        failed_rests=$((failed_rests+1))
        continue
    fi

    if ! make check;
    then
        echo "Failed to test $module" | tee -a "$result_file"
        failed_rests=$((failed_rests+1))
        continue
    fi

    echo "Tested $module OK" | tee -a "$result_file"
done

exit "$failed_rests"
