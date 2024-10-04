% Function to parse vertices from an OBJ file
function vertices = read_obj_vertices(obj_filename)
    fid = fopen(obj_filename, 'r');
    vertices = [];
    while ~feof(fid)
        line = fgetl(fid);
        if startsWith(line, 'v ')
            % Split line by spaces
            parts = strsplit(line);
            % Extract the x, y, z coordinates of the vertex
            x = str2double(parts{2});
            y = str2double(parts{3});
            z = str2double(parts{4});
            % Add the vertex to the list
            vertices = [vertices; x, y, z];
        end
    end
    fclose(fid);
end

% Function to write convex hull vertices to an OBJ file
function write_obj_convex_hull(vertices, faces, output_filename)
    fid = fopen(output_filename, 'w');
    % Write vertices
    for i = 1:size(vertices, 1)
        fprintf(fid, 'v %f %f %f\n', vertices(i, 1), vertices(i, 2), vertices(i, 3));
    end
    % Write faces (indexing in OBJ starts at 1)
    for i = 1:size(faces, 1)
        fprintf(fid, 'f %d %d %d\n', faces(i, 1), faces(i, 2), faces(i, 3));
    end
    fclose(fid);
end

% Main script
input_obj = 'rabbit.obj';        % Input OBJ file with vertices
output_obj = 'convex_hull.obj'; % Output OBJ file for convex hull

% Step 1: Read vertices from the OBJ file
vertices = read_obj_vertices(input_obj);

% Step 2: Compute the convex hull of the vertices
K = convhulln(vertices);

% Step 3: Write the convex hull to a new OBJ file
write_obj_convex_hull(vertices, K, output_obj);

disp('Convex hull OBJ file created successfully.');
