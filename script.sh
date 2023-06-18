commands[0]="isort . --check-only"
commands[1]="mypy --config-file setup.cfg"

errors=()


for cmd in "${commands[@]}"; do
    res=$($cmd 2>&1 >/dev/null)
    if [ $? -ne 0 ]; then
        errors+=("$res")
    fi
done


if [ ${#errors[@]} -gt 0 ]; then
    for err in "${errors[@]}"; do
     echo "$err"
    done
    exit 1
fi
