#!/usr/bin/env bash

this_dir=$(pwd)
test_dir=$(dirname $(pwd))/gnulib_test

rm -rf "$test_dir"
mkdir -p "$test_dir"

module_list=$(find modules -name '*tests' | sed -e 's|^modules/||g' -e 's|-tests$||g' | sort | head -n 32)

for module in $module_list
do
    columns=$(tput cols)
    header="****************************************"
    printf "%*s\n" $(((${#header}+$columns)/2)) "$header"
    printf "%*s\n" $(((${#module}+$columns)/2)) "$module"
    printf "%*s\n" $(((${#header}+$columns)/2)) "$header"

    cd "$this_dir" || exit 1

    if ! ./gnulib-tool --create-testdir --dir="$test_dir/$module" "$module" 1>/dev/null;
    then
        echo "Failed to prepare $module"
        continue
    fi

    cd "$test_dir/$module" || exit 1

    if ! ./configure;
    then
        echo "Failed to configure $module"
        continue
    fi

    if ! make;
    then
        echo "Failed to make $module"
        continue
    fi

    if ! make check;
    then
        echo "Failed to test $module"
        continue
    fi

    echo "Finished testing $module"
done