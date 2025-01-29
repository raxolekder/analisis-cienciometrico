
function [Boxes,centraldist] =memb(G,rb)
 
Boxes={};
 nnodes=numnodes(G);
 d=distances(G,'Method','unweighted');
 noncentre=zeros(1,nnodes); %0 = non centre; 1 centre
 uncovered=zeros(1,nnodes); %0= no covered 
 emass=zeros(1,nnodes);
 coveredcentre=noncentre+uncovered;
 %Repeat steps (ii) and (iii) until all nodes are either covered or centres
while min(coveredcentre)==0 
    %ii For all non-centre nodes (including the already covered nodes) calculate the excluded
    %mass, and select the node p with the maximum excluded mass as the next centre.
    for i=1: length(noncentre)    
        if noncentre(i)==0        
            emass(i)=excludedmass(rb,i,d,uncovered);    
        else
            emass(i)=-Inf; %%because these nodes are centre
        end        
    end    
    maximum=max( emass);
    [M,I]=find(emass==maximum);       
    p=I(randi(length(I)));
    
    noncentre(p)=1;
    uncovered(p)=1;
     emass(p)=-Inf;
   
    %iii Mark all the nodes with chemical distance less than rB from p as covered.(iv)
    uncovered=marknodescovered(p,rb,uncovered,d);
coveredcentre=noncentre+uncovered;
end %while

%PART II
%box construction
% I Give a unique box id to every centre node.}
centraldist=zeros(nnodes,4);
% II For all nodes calculate the ‘central distance’, which is the chemical distance to
%its nearest centre. The central distance has to be less than rB
%all centre nodes have a central distance equal to 0.
for i=1: length(noncentre) 
    
    if noncentre(i)==1
        centraldist(i,1)=i;%nodeid
        centraldist(i,2)=0;%distance antes bueno
        centraldist(i,3)=i;%centre
    else
        centraldist(i,1)=i;%nodeid        
        [idnocentre,dis]=centraldistance(i,rb,noncentre,d);   
        centraldist(i,2)=dis;%distance antes bien
        centraldist(i,3)=idnocentre;%centre
%         if i==1 &&rb>=2
%         i
%         idnocentre
%         dis
%         end
    end
end
%III Sort the non-centre nodes in a list according to increasing central distance
 centraldist=sortrows(centraldist,2,'ascend');
 %IV For each non-centre node i, at least one of its neighbours has a central distance less
 %than its own. Assign to i the same id with this neighbour. If there exist several such
% neighbours, randomly select an id from these neighbours. Remove i from the list.
while min(centraldist(:,4))==0
    %for i=1: lenthg(centraldist)----
    for i=1: size(centraldist,1)
        ncnode=centraldist(i,1);
        if noncentre(ncnode)==1
            centraldist(i,4)=1; %%removed from the list
        end
        if noncentre(ncnode)==0   &&  centraldist(i,4)==0   
            nei = neighbors(G, findnode(G,int2str(ncnode)));
            [id,centraldist]=box(i,centraldist,nei);            
            centraldist(i,3)=id;
            centraldist(i,4)=1; %%removed
            %centraldist=sortrows(centraldist,2,'ascend'); %debug
            %break; %debug
        end
        
    end
    centraldist=sortrows(centraldist,2,'ascend'); %estaba buena

end
%%extrac the boxes and thier nodes
[M,cIdx]=find(noncentre==1);
numboxes=length(cIdx);
for i=1:numboxes
   [nidx,M]= find(centraldist(:,3)==cIdx(i));%nodes that belong to a box
   boxl=zeros(1,length(nidx));
   for j=1:length(nidx)
      boxl(j)=centraldist(nidx(j),1); %%recovr node id 
    
   end
   Boxes{i}=boxl;
end
end




function [id,centraldist]=box(idxnode, centraldist,nei)
id=-1;
index=zeros(1,length(nei));

for i=1:length(nei)
    [idx,M]=find(centraldist(:,1)==nei(i));
    index(i)=idx;
end

for i=1:length(index)

    if centraldist(index(i),2)<centraldist(idxnode,2)
        centraldist(idxnode,3)=centraldist(index(i),3); 
        %centraldist(idxnode,2)=centraldist(index(i),2); %antes bien
        id=centraldist(index(i),3); 
    end
end
if id==-1 
%     if centraldist(idxnode,1)==57 || centraldist(idxnode,1)==27 || centraldist(idxnode,1)==61
%         z=0;
%     end 
%         %%choose the enter node of one of his neiboirs
%     %%this warant intraboxconnection
    idxneib=index(randi(length(index)));
    id=centraldist(idxneib,3); 
    %centraldist(idxnode,2)=centraldist(idxneib,2); antes bien

end
end


function [id,cdistance]=centraldistance(node,rb,noncentre,distances)
cdistance=inf;

[M,idcentre]=find(noncentre==1);
    for i=1:length(idcentre) %%%depure
        if  distances(node,idcentre(i))<rb && distances(node,idcentre(i))<=cdistance
                cdistance=distances(node,idcentre(i));  
                id=idcentre(i);
        end        
    end

end

%For a given burning radius rB, we define the ‘excluded mass’ of a node as the number of uncovered nodes
 %within a chemical distance less than rB.
function emass =excludedmass(rb,node,distances,uncovered)
emass=0;
for i=1:length(uncovered)
    if isinf(distances(node,i))&& uncovered(i)== 1             
            continue;
    end
      
    if distances(node,i)<rb && uncovered(i)== 0             
         emass=emass+1;
    end
    

end


end


function uncovered=marknodescovered(node,rb,uncovered,distances)
    
for i=1:length(uncovered)
    if isinf(distances(node,i))&& uncovered(i)== 1             
            continue;
    end
      
    if distances(node,i)<rb && uncovered(i)== 0             
         uncovered(i)=1;
    end
    
end
end