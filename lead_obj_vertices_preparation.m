function visualize_obj_with_convex_hull(obj_filename)
    % Load the .obj file (vertices and faces)
    [vertices, faces] = load_obj(obj_filename);
    
    % Plot the original 3D model mesh (Rabbit)
    figure;
    trisurf(faces, vertices(:,1), vertices(:,2), vertices(:,3), ...
        'FaceColor', 'cyan', 'EdgeColor', 'none', 'FaceAlpha', 0.8);
    hold on;

    % Compute the convex hull
    K = convhulln(vertices);
    
    % Plot the convex hull edges
    for i = 1:size(K, 1)
        % Extract the points forming the convex hull edges
        hull_points = vertices(K(i,:), :);
        
        % Plot the convex hull edges in red
        plot3(hull_points([1 2 3 1], 1), hull_points([1 2 3 1], 2), hull_points([1 2 3 1], 3), ...
            'r-', 'LineWidth', 1.5);
    end

    % Aesthetic settings
    axis equal;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title('3D Model with Convex Hull Edges');
    grid on;
    hold off;
end

% Function to load vertices and faces from the OBJ file
function [vertices, faces] = load_obj(filename)
    fid = fopen(filename, 'r');
    vertices = [];
    faces = [];
    
    while ~feof(fid)
        line = fgetl(fid);
        
        % Parse vertex data (lines starting with "v")
        if startsWith(line, 'v ')
            data = sscanf(line, 'v %f %f %f');
            vertices = [vertices; data'];
        
        % Parse face data (lines starting with "f")
        elseif startsWith(line, 'f ')
            data = sscanf(line, 'f %d %d %d');
            faces = [faces; data'];
        end
    end
    
    fclose(fid);
end
