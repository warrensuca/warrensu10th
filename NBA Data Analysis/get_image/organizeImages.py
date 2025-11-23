import os
import shutil


os.makedirs("images", exist_ok=True)

# look at all files in current directory
for file in os.listdir("."):
    if file.endswith(".png"):
        shutil.move(file, os.path.join("images", file))