function [size,namenodesingiant]=giantComponent(G)
    bins = conncomp(G); %%antes eliminar type weak --numero de componentes
    numComponents=max(bins);
    %searc for giant component
    m=0;
    nunberofgiant=0;  %modificar para que sean mayores a 1
    for i=1:numComponents
        nincom=bins(bins==i);
        compsize=length(nincom);
        if compsize>m
            m=compsize;
            nunberofgiant=i;
        end
    end
    nodesingiant=find(bins==nunberofgiant);
    namenodesingiant=getNames(G,nodesingiant);
    %size=m; anterior
    size=length(nodesingiant);
end