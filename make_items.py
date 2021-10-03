import os
import os.path
assert os.path.exists("project.godot")
from datetime import datetime

for root, dirs, files in os.walk("scenes/items", topdown=False):
    for name in files:
        path_to_mesh = os.path.join(root, name)
        words = os.path.splitext(name)[0].split('_')
        node_name = ''.join(w.capitalize() for w in words)
        item_name = ' '.join(w.capitalize() for w in words)
        node_path = f"items/{node_name}.tscn"
        with open(node_path,'w') as f:
            f.write(f"""[gd_scene load_steps=3 format=2]

[ext_resource path="res://items/GameItem.tscn" type="PackedScene" id=1]
[ext_resource path="res://{path_to_mesh}" type="PackedScene" id=2]

[node name="{node_name}" instance=ExtResource( 1 )]
item_name = "{item_name}"

[node name="Spatial" parent="Mesh" index="0" instance=ExtResource( 2 )]
""")
