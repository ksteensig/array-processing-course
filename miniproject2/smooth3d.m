function [Rfb] = smooth3d(X_tensor,Ly,Lx,Lf)
    [Ny,Nx,Nf] = size(X_tensor);
    X_tensor = permute(X_tensor, [3,1,2]);
    
    Py = Ny-Ly+1;
    Px = Nx-Lx+1;
    Pf = Nf-Lf+1;
    
    Rf = zeros(Lx*Ly*Lf,Lx*Ly*Lf);
    
    for y=1:Py
        for x=1:Px
            for f=1:Pf
                z = X_tensor(f:(f+Lf-1),y:(y+Ly-1),x:(x+Lx-1));
                Rf = Rf + z(:)*z(:)';
            end
        end
    end
    
    Rf = Rf/(Py*Px*Pf);
    J = hankel([zeros(1,(Ly*Lx*Lf-1)) 1]);
    Rfb = 0.5 * (Rf + J*conj(Rf)*J);
end