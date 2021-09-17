program nanocage

implicit none

character(100) :: line
integer*8 :: i,grid,j
INteger :: zau,zc1,zc2
real*8 :: aux,auy,auz,c1x,c1y,c1z,c2x,c2y,c2z,cx_auc1,cy_auc1,cz_auc1,cx_auc2,cy_auc2,cz_auc2,cx_c1c2,cy_c1c2,cz_c1c2
real*8 :: nline,cons=0.00,damp_auc1,tmp_auc1_x,ffa_auc1_x,tdamp_auc1,r_auc1,damp_auc2,tmp_auc2_x,ffa_auc2_x,tdamp_auc2,r_auc2
real*8 :: damp_c1c2,tmp_c1c2_x,ffa_c1c2_x,tdamp_c1c2,r_c1c2
real*8 :: tmp_auc1_y,ffa_auc1_y,tmp_auc1_z,ffa_auc1_z,tmp_auc2_y,ffa_auc2_y,tmp_auc2_z,ffa_auc2_z
real*8 :: tmp_c1c2_y,ffa_c1c2_y,tmp_c1c2_z,ffa_c1c2_z
real*8 :: ex_auc1,ey_auc1,ez_auc1,ex_auc2,ey_auc2,ez_auc2,ex_c1c2,ey_c1c2,ez_c1c2
real*8 :: auc1_p,auc2_p,c1c2_p
real*8 :: norm_auc1,norm_auc2,norm_c1c2
real*8 :: unit_auc1_x,unit_auc1_y,unit_auc1_z,unit_auc2_x,unit_auc2_y,unit_auc2_z,unit_c1c2_x,unit_c1c2_y,unit_c1c2_z
real*8, dimension (:), allocatable :: xx,yx,zx,ex,xy,yy,zy,ey,xz,yz,zz,ez

open (1, FILE='x.cube') ! read file to get reference atom coordinates
open (2, FILE='x.dat') ! read EField of x-direction
open (3, FILE='y.dat') ! read EField of y-direction
open (4, FILE='z.dat') ! read EField of z-direction
open (5, FILE='result.dat') ! write file

do i=1,6
  read(1,'(A)') line
end do
read(1,*) zau,cons,aux,auy,auz

do i=1,13
  read(1,'(A)') line
end do
read(1,*) zc1,cons,c1x,c1y,c1z

do i=1,3
  read(1,'(A)') line
end do
read(1,*) zc2,cons,c2x,c2y,c2z

cx_auc1=(aux+c1x)/2.0*0.529177
cy_auc1=(auy+c1y)/2.0*0.529177
cz_auc1=(auz+c1z)/2.0*0.529177

cx_auc2=(aux+c2x)/2.0*0.529177
cy_auc2=(auy+c2y)/2.0*0.529177
cz_auc2=(auz+c2z)/2.0*0.529177

cx_c1c2=(c1x+c2x)/2.0*0.529177
cy_c1c2=(c1y+c2y)/2.0*0.529177
cz_c1c2=(c1z+c2z)/2.0*0.529177

norm_auc1=sqrt((aux-c1x)**2 + (auy-c1y)**2 + (auz-c1z)**2 )*0.529177
norm_auc2=sqrt((aux-c2x)**2 + (auy-c2y)**2 + (auz-c2z)**2 )*0.529177
norm_c1c2=sqrt((c1x-c2x)**2 + (c1y-c2y)**2 + (c1z-c2z)**2 )*0.529177

write(5,*) "Each bond length"
write(5,*) "Au-C1",char(9),norm_auc1
write(5,*) "Au-C2",char(9),norm_auc2
write(5,*) "C1-C2",char(9),norm_c1c2

unit_auc1_x=(c1x-aux)/norm_auc1*0.529177
unit_auc1_y=(c1y-auy)/norm_auc1*0.529177
unit_auc1_z=(c1z-auz)/norm_auc1*0.529177

unit_auc2_x=(c2x-aux)/norm_auc2*0.529177
unit_auc2_y=(c2y-auy)/norm_auc2*0.529177
unit_auc2_z=(c2z-auz)/norm_auc2*0.529177

unit_c1c2_x=(c2x-c1x)/norm_c1c2*0.529177
unit_c1c2_y=(c2y-c1y)/norm_c1c2*0.529177
unit_c1c2_z=(c2z-c1z)/norm_c1c2*0.529177

write(5,*) "Each bond unit vector"
write(5,*) "Au-C1",char(9),unit_auc1_x,unit_auc1_y,unit_auc1_z
write(5,*) "Au-C2",char(9),unit_auc2_x,unit_auc2_y,unit_auc2_z
write(5,*) "C1-C2",char(9),unit_c1c2_x,unit_c1c2_y,unit_c1c2_z

grid=0
do while (.true.)
read(2,*,end=100) nline
grid=grid+1
enddo
100 continue

allocate (xx(grid))
allocate (yx(grid))
allocate (zx(grid))
allocate (ex(grid))
allocate (xy(grid))
allocate (yy(grid))
allocate (zy(grid))
allocate (ey(grid))
allocate (xz(grid))
allocate (yz(grid))
allocate (zz(grid))
allocate (ez(grid))

!do j=1,grid
!  read(2,*) xx(j),yx(j),zx(j),ex(j)
!end do

tdamp_auc1=0.0
tdamp_auc2=0.0
tdamp_c1c2=0.0

ffa_auc1_x=0.0
ffa_auc2_x=0.0
ffa_c1c2_x=0.0
ffa_auc1_y=0.0
ffa_auc2_y=0.0
ffa_c1c2_y=0.0
ffa_auc1_z=0.0
ffa_auc2_z=0.0
ffa_c1c2_z=0.0

rewind(2)
do j=1,grid
  read(2,*) xx(j),yx(j),zx(j),ex(j)
  read(3,*) xy(j),yy(j),zy(j),ey(j)
  read(4,*) xz(j),yz(j),zz(j),ez(j)
  r_auc1=sqrt((cx_auc1-xx(j))**2 + (cy_auc1-yx(j))**2 + (cx_auc1-zx(j))**2 )
  r_auc2=sqrt((cx_auc2-xx(j))**2 + (cy_auc2-yx(j))**2 + (cx_auc2-zx(j))**2 )
  r_c1c2=sqrt((cx_c1c2-xx(j))**2 + (cy_c1c2-yx(j))**2 + (cx_c1c2-zx(j))**2 )

  if (r_auc1>=1.0) then
          damp_auc1=1.0/(r_auc1*r_auc1)
  else if (r_auc1<1.0) then
          damp_auc1=1.0
  end if

  tmp_auc1_x=ex(j)*damp_auc1
  ffa_auc1_x=ffa_auc1_x+tmp_auc1_x
  tmp_auc1_y=ey(j)*damp_auc1
  ffa_auc1_y=ffa_auc1_y+tmp_auc1_y
  tmp_auc1_z=ez(j)*damp_auc1
  ffa_auc1_z=ffa_auc1_z+tmp_auc1_z

  tdamp_auc1=tdamp_auc1+damp_auc1

  if (r_auc2>=1.0) then
          damp_auc2=1.0/(r_auc2*r_auc2)
  else if (r_auc2<1.0) then
          damp_auc2=1.0
  end if

  tmp_auc2_x=ex(j)*damp_auc2
  ffa_auc2_x=ffa_auc2_x+tmp_auc2_x
  tmp_auc2_y=ey(j)*damp_auc2
  ffa_auc2_y=ffa_auc2_y+tmp_auc2_y
  tmp_auc2_z=ez(j)*damp_auc2
  ffa_auc2_z=ffa_auc2_z+tmp_auc2_z
  
  tdamp_auc2=tdamp_auc2+damp_auc2

  if (r_c1c2>=1.0) then
          damp_c1c2=1.0/(r_c1c2*r_c1c2)
  else if (r_c1c2<1.0) then
          damp_c1c2=1.0
  end if

  tmp_c1c2_x=ex(j)*damp_c1c2
  ffa_c1c2_x=ffa_c1c2_x+tmp_c1c2_x
  tmp_c1c2_y=ey(j)*damp_c1c2
  ffa_c1c2_y=ffa_c1c2_y+tmp_c1c2_y
  tmp_c1c2_z=ez(j)*damp_c1c2
  ffa_c1c2_z=ffa_c1c2_z+tmp_c1c2_z

  tdamp_c1c2=tdamp_c1c2+damp_c1c2
end do

ex_auc1=ffa_auc1_x/tdamp_auc1*5142.20652
ey_auc1=ffa_auc1_y/tdamp_auc1*5142.20652
ez_auc1=ffa_auc1_z/tdamp_auc1*5142.20652
ex_auc2=ffa_auc2_x/tdamp_auc2*5142.20652
ey_auc2=ffa_auc2_y/tdamp_auc2*5142.20652
ez_auc2=ffa_auc2_z/tdamp_auc2*5142.20652
ex_c1c2=ffa_c1c2_x/tdamp_c1c2*5142.20652
ey_c1c2=ffa_c1c2_y/tdamp_c1c2*5142.20652
ez_c1c2=ffa_c1c2_z/tdamp_c1c2*5142.20652

write(5,*) "Each bond in each direction:"
write(5,*) "Au-C1_X",char(9),ex_auc1
write(5,*) "Au-C1_Y",char(9),ey_auc1
write(5,*) "Au-C1_Z",char(9),ez_auc1
write(5,*) "Au-C2_X",char(9),ex_auc2
write(5,*) "Au-C2_Y",char(9),ey_auc2
write(5,*) "Au-C2_Z",char(9),ez_auc2
write(5,*) "C1-C2_X",char(9),ex_c1c2
write(5,*) "C1-C2_Y",char(9),ey_c1c2
write(5,*) "C1-C2_Z",char(9),ez_c1c2


auc1_p=ex_auc1*unit_auc1_x+ey_auc1*unit_auc1_y+ez_auc1*unit_auc1_z
auc2_p=ex_auc2*unit_auc2_x+ey_auc2*unit_auc2_y+ez_auc2*unit_auc2_z
c1c2_p=ex_c1c2*unit_c1c2_x+ey_c1c2*unit_c1c2_y+ez_c1c2*unit_c1c2_z

write(5,*) "Projected electric field on bond"
write(5,*) "Au-C1",char(9),auc1_p
write(5,*) "Au-C2",char(9),auc2_p
write(5,*) "C1-C2",char(9),c1c2_p

deallocate (xx)
deallocate (yx)
deallocate (zx)
deallocate (ex)
deallocate (xy)
deallocate (yy)
deallocate (zy)
deallocate (ey)
deallocate (xz)
deallocate (yz)
deallocate (zz)
deallocate (ez)

close(1)
close(2)
close(3)
close(4)
close(5)

end program

