Ny = 71;
Nx = 66;
Nf = 101;
Kt = 101;
f = 7.5e9;
d = 0.01;
c = 3e8;
l = c/f;

% Definition of array
N_row = 71;
N_column = 66; 
L1 = 71;
L2 = 10;
idx_array = getSubarray(N_row, N_column, L1, L2, 1);

%idx_tau = 1:length(tau); %Note: We can also truncate the delay range if desired
%Nf = length(idx_tau);

r_array = r(:, idx_array);

a = @(theta) exp(-1i*2*pi/l * [cos(theta); sin(theta)].'*r_array);
g = @(tau) exp(-1i*2*pi * (0:(Nf-1)) * tau);

theta = linspace(0,2*pi,Nf)';

X_test = X';
X_test = X_test(:,idx_array);
X_test = X_test(:);

%tau = linspace(0,100,Kt); %(0:Kt-1)/Kt;
u = @(theta,tau) kron(a(theta)', g(tau)');

[Theta,Tau] = meshgrid(theta,linspace(0,1,Kt));

%PB = @(theta,tau) norm(u(theta,tau)'*X_test(:))^2;
%PB = @(theta,tau) u(theta,tau)'*R*u(theta,tau)/(norm(u(theta,tau))^4);
%PC = @(theta,tau) 1/(u(theta,tau)'*Ri*u(theta,tau));

Ly = 4;
Lx = 4;
Lf = 10;

X_tensor = reshape(X_synthetic, [N_row,N_column,Nf]);
X_tensor = X_tensor(1:L1,1:L2,1:Nf);
Rf = smooth3d_forward(X_tensor, Ly, Lx, Lf);
Rfi = inv(Rf);

Z = zeros(Kt,Nf);

for i=1:Nf
    for j=1:Kt
        u_ = u(Theta(j,i), Tau(j,i));
        u_ = reshape(u_, [Nf,L1,L2]);
        u_ = u_(1:Lf,1:Ly,1:Lx);
        u_ = u_(:);
        Z(j,i) = 1/(u_'*Rfi*u_);
        %Z(j,i) = u_'*Rf*u_;
    end
end

surf(rad2deg(Theta), Tau, 10*log10(abs(Z)))
%zlim([-20,30])

%figure(6);
%plot(Theta(1,:),10*log10(abs(Z(1,:))))
%for i=1:size(smc_param.AoA)
%    if (smc_param.AoA(i) > 0)
%        xline((smc_param.AoA(i)),'--r')
%    else
%        xline((smc_param.AoA(i)+2*pi),'--r')
%    end
%end
%xline(pi/2, '--g')
%xline(3*pi/2, '--g')