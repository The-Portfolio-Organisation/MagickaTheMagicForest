extends ImmediateGeometry

func _ready():
	begin(Mesh.PRIMITIVE_TRIANGLES);
	set_normal(Vector3(0, 1, 0))
	set_uv(Vector2(1, 1))
	var n_pts = 30
	var i = 0
	while i < n_pts:
		var a = 2*i*(PI/n_pts);
		var pos = Vector3(0,0,0);
		
		begin(Mesh.PRIMITIVE_TRIANGLES);
		set_normal(Vector3(0, 1, 0))
		set_uv(Vector2(1, 1))
		
		add_vertex(pos);
		
		pos = 100*Vector3(cos(a) - float(i%5)/float(n_pts), 0, sin(a) + float(i%3)/float(n_pts));
		add_vertex(pos);
		print(pos)
		
		i+=1;
		a = 2*i*(PI/n_pts);
		
		pos = 100*Vector3(cos(a) - float(i%5)/float(n_pts), 0, sin(a) + float(i%3)/float(n_pts));
		add_vertex(pos);
		print(pos)
		print("-------")
		
		end();
	end()
	
