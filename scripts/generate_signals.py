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

signals = {}  # type: ignore
for filename in sorted(os.listdir(classes_dir)):
    if not filename.endswith(".xml"):
        continue
    class_name = filename[:-4]
    try:
        root = ET.fromstring(open(classes_dir + "/" + filename).read())
        sigs = root.findall(".//signals/signal")
        if sigs:
            signals[class_name] = []
            for s in sigs:
                params = []
                for p in s.findall("param"):
                    params.append(
                        {
                            "name": p.attrib.get("name", ""),
                            "type": p.attrib.get("type", ""),
                            "index": int(p.attrib.get("index", 0)),
                        }
                    )
                params.sort(key=lambda x: x["index"])  # type: ignore
                signals[class_name].append(
                    {
                        "name": s.attrib["name"],
                        "params": params,
                    }
                )
    except:
        pass

shutil.rmtree("godot-repo")

with open("output.lua", "w") as f:
    f.write("local signals = {\n")
    for class_name, sigs in sorted(signals.items()):
        f.write(f'    ["{class_name}"] = {{\n')
        for s in sigs:
            f.write(f"        {{\n")
            f.write(f'            name = "{s["name"]}",\n')
            f.write(f"            params = {{\n")
            for p in s["params"]:
                f.write(
                    f'                {{ name = "{p["name"]}", type = "{p["type"]}" }},\n'
                )
            f.write(f"            }},\n")
            f.write(f"        }},\n")
        f.write("    },\n")
    f.write("}\n")
    f.write("return signals\n")
