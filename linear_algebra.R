

#
v1 <- matrix(c(3,-1,2), ncol = 1)
v2 <- matrix(c(2,4,-1), ncol = 1)
dot_prod1 <- sum(v1*v2)
dot_prod2 <- t(v1) %*% v2

abs(t(v1) %*% v2)

norm(v1, type = "E") * norm(v2, type = "E")

#
A <- matrix(1:9, ncol = 3)
v <- matrix(c(1,-1,2), ncol = 1)
matvect1 <- A %*% V

#orthogonal
v1 <- matrix(c(2,3), ncol = 1)
v2 <- matrix(c(4,4), ncol = 1)
p <- v2 * ((t(v1) %*% v2) / (t(v2) %*% v2))

#determinant
A <- matrix(1:9, ncol = 3)
det(A) #0 means singular

#inverse
B <- matrix(c(4,2,-1,2,0,6,3,7,-3), ncol = 3)
det(B) #-134 non singular
inv_B <- solve(B)
print(inv_B)

#rank
rank_A <- qr(A)$rank
print(rank_A)

#linear
A <- cbind(c(1,2,2),c(3,5,3), c(-1,4,-1))
b <- matrix(c(4,19,7), ncol = 1)
Ab <- cbind(A, b)
print(Ab)

dim(A) #3
qr(A)$rank #3
solve(A,b)

#cramer
D <- det(A)
L <- list(Dx = A, Dy = A, Dz = A)
for(i in 1:length(L)){
  L[[i]][,i] <- b
}

sapply(L, det) / D

#generalized inverse
library(MASS)
ginv(A)
ginv(A) %*% b

#eigen
A <- matrix(c(2, sqrt(2), sqrt(2),1), ncol = 2)
eigen_A <- eigen(A)
str(eigen_A)

print(eigen_A$values)
print(eigen_A$vectors)

eigen_A$vectors[,1] %*% eigen_A$vectors[,2]

#LU decomposition
library(Matrix)
A <- cbind(c(1,2,2),c(3,5,3),c(-1,4,-1))
lu_A <- lu(A)
lue_A <- expand(lu_A) #expand decomposiiton into factors

print(lue_A$L)
print(lue_A$U)
lue_A$L %*% lue_A$U
lue_A$P %*% (lue_A$L %*% lue_A$U)

#QR decompostion
qr_A <- qr(A)
qr_Q <- qr.Q(qr_A)
print(qr_Q)

qr_R <- qr.R(qr_A)
print(qr_R)

dim(A)
dim(qr_Q)
dim(qr_R)

qr_Q %*% qr_R

t(qr_Q) %*% qr_Q #identitiy matrix

#solve Ax = b using QR
b <- c(4,19,7)
solve(qr_R) %*% t(qr_Q) %*% b

#or
qr.solve(A,b)

#cholesky decomposition
c <- matrix(c(9.84, 10.38, 49.88, 10.38, 40.60, 62.66, 49.88, 10.38, 40.60, 62.66, 49.88, 62.66, 270.20), ncol = 3)

eigen(c)$values

H <- chol(c)
print(H)
t(H) %*% H

#spectral/eigen decompostion
A <- matrix(c(1,2,2,3,5,3,-1,4,-1), ncol = 3)
eigen_A <- eigen(A)
v <- eigen_A$vectors
L <- diag(eigen_A$values)
v %*% L %*% solve(v)

#singular value decompostion
svd_A <- svd(A)
print(svd_A)

#finding generalized inverse using SVD
A1 <- matrix(c(1,2,3,5,-1,4), ncol = 3)
A1

solve(A1) #error as not square matrix

svd_A1 <- svd(A1)
U <- svd_A1$u
V <- svd_A1$v
D <- diag(svd_A1$d)

v %*% solve(D) %*% t(U)
#or
ginv(A1)





















