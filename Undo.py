import os

def clean_sql_files_in_place(folder_path):
    for filename in os.listdir(folder_path):
        if filename.endswith('.sql'):
            file_path = os.path.join(folder_path, filename)

            with open(file_path, 'r', encoding='utf-8') as f:
                lines = f.readlines()

            output_lines = []
            inside_multiline_comment = False

            for line in lines:
                stripped = line.strip()

                # Start of multiline comment
                if not inside_multiline_comment and stripped.startswith("/*"):
                    inside_multiline_comment = True
                    output_lines.append(line)
                    continue

                # Inside multiline comment
                if inside_multiline_comment:
                    output_lines.append(line)
                    if "*/" in stripped:
                        inside_multiline_comment = False
                    continue

                # Single-line comment
                if stripped.startswith("--"):
                    output_lines.append(line)
                    continue

                # Ignore SQL code lines
                continue

            # Overwrite original file
            with open(file_path, 'w', encoding='utf-8') as f:
                f.writelines(output_lines)

            print(f"✔ Cleaned: {filename}")

    print("\n✅ All files cleaned in place.")

# Example usage
folder_path = r'C:\Users\Satish\Desktop\SQL\SQL-Leetcode-Challenge\Medium' 
clean_sql_files_in_place(folder_path)
