using ITensors
using Printf

function main()
  N = 100
  sites = spinOneSites(N)

  ampo = AutoMPO(sites)
  for j=1:N-1
    add!(ampo,"Sz",j,"Sz",j+1)
    add!(ampo,0.5,"S+",j,"S-",j+1)
    add!(ampo,0.5,"S-",j,"S+",j+1)
  end
  H = toMPO(ampo)

  psi0 = randomMPS(sites)

  sweeps = Sweeps(5)
  maxdim!(sweeps,10,20,100,100,200)
  cutoff!(sweeps,1E-10)
  @show sweeps

  energy,psi = dmrg(H,psi0,sweeps)
  @printf("Final energy = %.12f\n",energy)
end
main()
