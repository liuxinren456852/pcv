function [normal_one noncompute max_sort dis_vect center] = compute_normal_NWR_EACH6_ExraFea(points , local_W , ran_num , inner_threshold)

num = size(points , 1) ;
normal_one = zeros(3,1) ;
max_sort = 0 ;
noncompute = 0 ;
x = ones(1 , 3) ;
y = ones(num , 1) ;
dis_vect = zeros(num , 1) ;
center = zeros(3 , 1) ;

for i = 1 : ran_num
    ran_id = [randperm(num , 3)]; 
    poins_3 = points(ran_id , :) ; 
    
    mp = (x*poins_3)./3 ; 
    points_center = points - y * mp ;
    tmp = points_center(ran_id , :); 
    C = tmp'*tmp./size(poins_3 , 1); 
    [V,~] = eig(C);  
    fix_normal = V(:,1); 
    
    temp_dis = (points_center*fix_normal).^2;
    
    dis = exp(-temp_dis./min( inner_threshold.^2 ) ); 
    
    cur_sort = dis' * local_W * dis ;

    if cur_sort > max_sort
        max_sort = cur_sort;
        normal_one = fix_normal' ;
        dis_vect = temp_dis ;
        center = mp ; 
    end
    
end

if sum(normal_one.*normal_one) == 0
    normal_one = [1,0,0] ;
    noncompute = 1 ;
end
