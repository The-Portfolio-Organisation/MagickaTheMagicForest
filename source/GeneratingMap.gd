extends Spatial

export(PackedScene) var tree;
export(PackedScene) var rock;

export(int) var noise_period = 80;
export(int) var noise_octave = 6;

export(Vector2) var map_size = Vector2(400,400);
export(int) var map_depth = 200;
export(int) var map_width = 200;
export(int) var steepness = 60;
export(Texture) var texture;

func _ready():
	var rng = RandomNumberGenerator.new();
	
	var noise = OpenSimplexNoise.new();
	noise.period = noise_period;
	noise.octaves = noise_octave;
	
	var plane_mesh = PlaneMesh.new();
	plane_mesh.size = map_size;
	plane_mesh.subdivide_depth = map_depth;
	plane_mesh.subdivide_width = map_width;
	
	var surface_tool = SurfaceTool.new();
	surface_tool.create_from(plane_mesh, 0);
	
	var array_plane = surface_tool.commit();
	
	var data_tool = MeshDataTool.new();
	data_tool.create_from_surface(array_plane, 0);
	
	for i in range(data_tool.get_vertex_count()):
		var vertex = data_tool.get_vertex(i);
		if vertex.x * vertex.z > 0:
			vertex.y = noise.get_noise_3d(vertex.x, vertex.y, vertex.z) * steepness * vertex.x * vertex.y;
		else:
			vertex.y = noise.get_noise_3d(vertex.x, vertex.y, vertex.z) * steepness/5;
		
		if vertex.y < -5 and vertex.x < 0:
			vertex.y = -5;
		
		rng.randomize()
		var rnd_nbr = rng.randi_range(-10, 10)
		if vertex.x < 0 and vertex.y < 15 and rnd_nbr > 7:
			spawn_scene(rock, vertex, 5);
			
		if vertex.x > 0 and vertex.y < 15 and rnd_nbr > 9:
			spawn_scene(tree, vertex + Vector3(0,15,0), 15);

		if int(abs(vertex.x)) == map_size.x / 2 or int(abs(vertex.z)) == map_size.y / 2:
			for j in range(0,15):
				spawn_scene(tree, vertex + Vector3(0,(30*j) + 15,0), 15);
		
		data_tool.set_vertex(i, vertex);
		
	for i in range(array_plane.get_surface_count()):
		array_plane.surface_remove(i);
		
	data_tool.commit_to_surface(array_plane);
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES);
	surface_tool.create_from(array_plane, 0);
	surface_tool.generate_normals();
	
	var mesh_instance = MeshInstance.new();
	mesh_instance.mesh = surface_tool.commit();
	mesh_instance.create_trimesh_collision();
	
	var material = SpatialMaterial.new();
	material.albedo_texture = texture;
	material.uv1_scale = Vector3(5, 5, 5);
	material.uv2_scale = Vector3(5, 5, 5);
	mesh_instance.material_override = material;
	
	add_child(mesh_instance);

func spawn_scene(scene, pos, scale):
	var inst = scene.instance();
			
	inst.translation = pos;
	inst.scale = inst.scale * scale;
	add_child(inst);
