# @author:Bernard Kim

#sample SFS with n=100. i exclude p=0 and p=1 as frequency classes
#neutral SFS with theta=1000
theta=1000
n=100
sfs = theta/1:(n-1)

#downsample to n_new=10
n_new=10

#initalize blank sfs
sfs_downsampled = rep(0,n_new-1)

#would rather vectorize but for clarity, for loop
#iterate over all frequency classes in old SFS
for (i in 1:(n-1)){
	#compute the hypergeometric pmf for one variant of frequency class i
	#note this won't sum to one cause i'm excluding p=0 and p=1
	#note this is the projected sfs for a single variant of freq i
	proj_i = dhyper(1:(n_new-1),i,n-i,n_new)
	
	#this should sum to 1
	#dhyper(0:(n_new),i,n-i,n_new)
	
	#multiply projected sfs for i variant by # of variants at that frequency
	#to get the total sfs for all variants at freq i
	proj_i = sfs[i]*proj_i
	
	#add this to the new sfs
	sfs_downsampled = sfs_downsampled + proj_i
	
	#move on to the next frequency class
}

#does downsampled sfs agree with theoretical expectation?
sfs_downsampled

#expected neutral SFS with n=10
theta/(1:(n_new-1))
