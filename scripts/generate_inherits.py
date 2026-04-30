import xml.etree.ElementTree as ET
import os
import subprocess
import shutil

subprocess.run(
    [
        "git",
        "clone",
        "--depth=1",
        "--filter=blob:none",
        "--sparse",
        "https://github.com/godotengine/godot.git",
        "godot-repo",
    ],
    check=True,
)
subprocess.run(
    ["git", "-C", "godot-repo", "sparse-checkout", "set", "doc/classes"], check=True
)

classes_dir = "godot-repo/doc/classes"

inherits = {}
for filename in sorted(os.listdir(classes_dir)):
    if not filename.endswith(".xml"):
        continue
    class_name = filename[:-4]
    try:
        root = ET.fromstring(open(classes_dir + "/" + filename).read())
        parent = root.attrib.get("inherits", None)
        if parent:
            inherits[class_name] = parent
    except:
        pass

shutil.rmtree("godot-repo")

with open("output.lua", "w") as f:
    f.write("local inherits = {\n")
    for class_name, parent in sorted(inherits.items()):
        f.write(f'    ["{class_name}"] = "{parent}",\n')
    f.write("}\n")
    f.write("return inherits\n")
