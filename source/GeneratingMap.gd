extends Spatial

export(PackedScene) var tree;
export(PackedScene) var rock;

export(int) var noise_period = 80;
export(int) var noise_octave = 6;

export(Vector2) var map_size = Vector2(400,400);
export(int) var map_depth = 200;
export(int) var map_width = 200;
export(Texture) var texture;

func _ready():
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
	
	var data_tool = MeshDataTool.new()
	data_tool.create_from_surface(array_plane, 0);
	
	for i in range(data_tool.get_vertex_count()):
		var vertex = data_tool.get_vertex(i);
		vertex.y = noise.get_noise_3d(vertex.x, vertex.y, vertex.z) * 60;
		
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
