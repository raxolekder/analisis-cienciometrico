function cellBoxes=boxcoveringmemb(A)
nnodes=size(A);
nnodes=nnodes(1,1);
for i=1:nnodes
     nodenames{i}=int2str(i);
 end
 G=graph(A,nodenames);
i=1; 
boxesl={};
while length(boxesl)~=1
          
 [boxesl,~]=memb(G,i);
 cellBoxes{i} =boxesl;

i=i+1;
end 

end
