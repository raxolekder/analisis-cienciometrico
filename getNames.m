function nodenames=getNames(G, ids)
nodenames=cell.empty;
for i=1:length(ids)
    nodenames(i)=G.Nodes.Name(ids(i));
end

end
