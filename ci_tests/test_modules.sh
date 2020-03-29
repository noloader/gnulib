#!/usr/bin/env bash

this_dir=$(pwd)
test_dir=$(dirname "$(pwd)")/gnulib_test

rm -rf "$test_dir"
mkdir -p "$test_dir"

# Result file is dumped to screen at end of testing
result_file=$(pwd)/result.txt

# TODO: determine a methodology
module_list=$(find modules -name '*-tests' | sed -e 's|^modules/||g' \
              -e 's|-tests$||g' -e 's|-c++$||g' | sort | uniq | head -n 48)

# Eventual return code
failed_tests=0

# For BSD testing on Cirrus CI
if [ -n "$(command -v gmake)" ]; then
    MAKE=$(command -v gmake)
else
    MAKE=make
fi

for module in $module_list
do
    header="****************************************"
    printf "%s\n" "${header}" | tee -a "$result_file"
    printf "%s\n" "${module}" | tee -a "$result_file"

    cd "$this_dir" || exit 1

    if ! ./gnulib-tool --create-testdir --dir="$test_dir/$module" "$module" 1>/dev/null;
    then
        printf "%s\n" "Failed to prepare $module" | tee -a "$result_file"
        failed_tests=$((failed_tests+1))
        continue
    fi

    cd "$test_dir/$module" || exit 1

    if ! ./configure;
    then
        printf "%s\n" "Failed to configure $module" | tee -a "$result_file"
        failed_tests=$((failed_tests+1))
        cat config.log
        continue
    fi

    # Travis offers two cores
    if ! ${MAKE} -j 3;
    then
        printf "%s\n" "Failed to make $module" | tee -a "$result_file"
        failed_tests=$((failed_tests+1))
        continue
    fi

    if ! ${MAKE} check;
    then
        printf "%s\n" "Failed to test $module" | tee -a "$result_file"
        failed_tests=$((failed_tests+1))
        continue
    fi

    printf "%s\n" "${color_green}Tested $module OK" | tee -a "$result_file"
done

exit "$failed_tests"
