function [labels,clust_centers,cost] = manifold_kmeans_sphere(points,N_clusters,max_iter)

Npts = length(points);

rand_pts = randperm(Npts);

clust_idx = rand_pts(1:N_clusters);

clust_centers = points([clust_idx]);
labels = [];


cur_iter = 1;
eps=1.0000e-009;
while(cur_iter <=max_iter)
    
    %%%%% Assign each point to a cluster
    for i = 1:Npts
        
        clust_dists = zeros(1,N_clusters);
        
        for j = 1:N_clusters
            
             %%% REPLACE WITH DISTANCE BETWEEN QUATERNIONS
            clust_dists(j) = rdist(points{i},clust_centers{j});
           
        end
        
        closest = find(clust_dists == min(clust_dists));
        
        labels(i) = closest;
    end
    
    
    %%%%% Compute clustering cost
    
    cost = 0;
   
    for i = 1:N_clusters
        
        clust_members = find(labels == i);
        
        clust_points = points([clust_members]);
        temp = 0;
        
        
        for j = 1:length(clust_points)
            
          %%% REPLACE WITH DISTANCE BETWEEN QUATERNIONS
            temp  = temp +rdist(clust_centers{i},clust_points{j});
        end
        
        
        cost = cost + temp;
        
    end
    cc(cur_iter)=cost;
    cost
    %%%%%% Now recompute cluster centers
    
    n_iter_karcher = 10;
    
    for i = 1:N_clusters
        
        clust_members = find(labels == i);
        
        clust_points = points([clust_members]);
        
        if(length(clust_points) == 0)
            rand_pt_idx = round(1 + (length(points) - 1) *rand(1));
            clust_center = points{rand_pt_idx};
        else
             %%% REPLACE WITH MEAN ON QUATERNION
            clust_center = sphere_extrinsic_mean(clust_points);
        end
        
        clust_centers{i} = clust_center;
    end
    
     if(cur_iter>1)&&(abs(cc(cur_iter)-cc(cur_iter-1))<eps)
        break;
    end
    cur_iter = cur_iter + 1
    %disp('Iteration %d',cur_iter);
    
    

    
end

return;
