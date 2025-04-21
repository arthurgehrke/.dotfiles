#!/bin/zsh

echo "Available folders in $(pwd):"
echo "0) All folders (recursive)"

folders=()
i=1
for dir in */ ; do
    echo "$i) $dir"
    folders+=("$dir")
    ((i++))
done

read "?Select folder: " selection

if [[ "$selection" =~ '^[0-9]+$' ]]; then
    if [[ "$selection" -eq 0 ]]; then
        TARGET_DIR="."
    elif (( selection >= 1 && selection <= $#folders )); then
        TARGET_DIR="${folders[$((selection))]%/}"
    else
        echo "Invalid option."
        exit 1
    fi
else
    echo "Invalid input."
    exit 1
fi

echo ""
echo "🔍 Scanning '$TARGET_DIR' for duplicate files (by name and size)..."

tmpfile=$(mktemp)

find "$TARGET_DIR" -type f | while read -r file; do
    name=$(basename "$file")
    [[ "$name" == .* || "$name" == ._* ]] && continue
    [[ -e "$file" ]] && size=$(stat -f%z "$file" 2>/dev/null) && echo "$size|$name|$file"
done | sort > "$tmpfile"

# Agrupar arquivos por chave: tamanho_nome
typeset -A groups

while IFS='|' read -r size name path; do
    key="${size}_${name}"
    if [[ -z "${groups[$key]}" ]]; then
        groups["$key"]="$path"
    else
        groups["$key"]+=$'\n'"$path"
    fi
done < "$tmpfile"

rm "$tmpfile"

found_duplicates=0

for key in ${(k)groups}; do
    paths=("${(@f)groups[$key]}")
    if (( ${#paths[@]} > 1 )); then
        found_duplicates=1
        filename="${key#*_}"
        filesize="${key%%_*}"

        echo ""
        echo "🔁 Duplicated file: $filename"
        echo "   Size: ${filesize} bytes"
        for p in $paths; do
            echo " - $p"
        done

        echo ""
        echo "Prompting for each file in this group:"
        for file in $paths; do
            while true; do
                read "?Delete '$file'? [y/n/o]: " answer
                case "$answer" in
                    y|Y)
                        /bin/rm "$file" && echo "🗑️ Deleted: $file"
                        break
                        ;;
                    n|N|"")
                        echo "❌ Skipped: $file"
                        break
                        ;;
                    o|O)
                        echo "📂 Opening: $file"
                        /usr/bin/open "$file"
                        ;;
                    *)
                        echo "Please type y (delete), n (skip), or o (open)."
                        ;;
                esac
            done
        done
    fi
done

if (( ! found_duplicates )); then
    echo "✅ No duplicate files found."
fi
