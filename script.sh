commands[0]="isort . --check-only"
commands[1]="mypy --config-file setup.cfg"

errors=()
set +e

for cmd in "${commands[@]}"; do
    res=$($cmd)
    if [ $? -ne 0 ]; then
        echo $res
        errors+=("$res")
    fi
done


if [ ${#errors[@]} -gt 0 ]; then
    for err in "${errors[@]}"; do
     echo "$err"
    done
fi
exit 1

