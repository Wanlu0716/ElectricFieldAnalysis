#!/bin/bash -l

python cube2xyz.py -f x.cube -o x.dat -A
python cube2xyz.py -f y.cube -o y.dat -A
python cube2xyz.py -f z.cube -o z.dat -A

filter_p=0.5
filter_m=-0.5
rau_minus=1.66
rau_plus=1.67
rc_minus=1.70
rc_plus=1.71

xcoordau=$(awk '{print $3}' x.cube | head -n 7 | tail -n 1)
ycoordau=$(awk '{print $4}' x.cube | head -n 7 | tail -n 1)
zcoordau=$(awk '{print $5}' x.cube | head -n 7 | tail -n 1)

xcoord_au=$(echo "($xcoordau*0.529177 )" | bc -l)
ycoord_au=$(echo "($ycoordau*0.529177 )" | bc -l)
zcoord_au=$(echo "($zcoordau*0.529177 )" | bc -l)

xcoordc1=$(awk '{print $3}' x.cube | head -n 21 | tail -n 1)
ycoordc1=$(awk '{print $4}' x.cube | head -n 21 | tail -n 1)
zcoordc1=$(awk '{print $5}' x.cube | head -n 21 | tail -n 1)

xcoord_c1=$(echo "($xcoordc1*0.529177 )" | bc -l)
ycoord_c1=$(echo "($ycoordc1*0.529177 )" | bc -l)
zcoord_c1=$(echo "($zcoordc1*0.529177 )" | bc -l)

xcoordc2=$(awk '{print $3}' x.cube | head -n 25 | tail -n 1) 
ycoordc2=$(awk '{print $4}' x.cube | head -n 25 | tail -n 1) 
zcoordc2=$(awk '{print $5}' x.cube | head -n 25 | tail -n 1)

xcoord_c2=$(echo "($xcoordc2*0.529177 )" | bc -l)
ycoord_c2=$(echo "($ycoordc2*0.529177 )" | bc -l)
zcoord_c2=$(echo "($zcoordc2*0.529177 )" | bc -l)

echo $xcoord_au 
echo $ycoord_au 
echo $zcoord_au 
echo $xcoord_c1 
echo $ycoord_c1 
echo $zcoord_c1 
echo $xcoord_c2 
echo $ycoord_c2 
echo $zcoord_c2 

awk '{ if (sqrt(($1-'$xcoord_au')*($1-'$xcoord_au')+($2-'$ycoord_au')*($2-'$ycoord_au')+($3-'$zcoord_au')*($3-'$zcoord_au'))>='$rau_minus' && sqrt(($1-'$xcoord_au')*($1-'$xcoord_au')+($2-'$ycoord_au')*($2-'$ycoord_au')+($3-'$zcoord_au')*($3-'$zcoord_au'))<='$rau_plus' && $4<='$filter_p' && $4>='$filter_m' ) print $4}' x.dat >> xau_filter.txt

awk '{ if (sqrt(($1-'$xcoord_au')*($1-'$xcoord_au')+($2-'$ycoord_au')*($2-'$ycoord_au')+($3-'$zcoord_au')*($3-'$zcoord_au'))>='$rau_minus' && sqrt(($1-'$xcoord_au')*($1-'$xcoord_au')+($2-'$ycoord_au')*($2-'$ycoord_au')+($3-'$zcoord_au')*($3-'$zcoord_au'))<='$rau_plus' && $4<='$filter_p' && $4>='$filter_m' ) print $4}' y.dat >> yau_filter.txt

awk '{ if (sqrt(($1-'$xcoord_au')*($1-'$xcoord_au')+($2-'$ycoord_au')*($2-'$ycoord_au')+($3-'$zcoord_au')*($3-'$zcoord_au'))>='$rau_minus' && sqrt(($1-'$xcoord_au')*($1-'$xcoord_au')+($2-'$ycoord_au')*($2-'$ycoord_au')+($3-'$zcoord_au')*($3-'$zcoord_au'))<='$rau_plus' && $4<='$filter_p' && $4>='$filter_m' ) print $4}' z.dat >> zau_filter.txt

awk '{ if (sqrt(($1-'$xcoord_c1')*($1-'$xcoord_c1')+($2-'$ycoord_c1')*($2-'$ycoord_c1')+($3-'$zcoord_c1')*($3-'$zcoord_c1'))>='$rc_minus' && sqrt(($1-'$xcoord_c1')*($1-'$xcoord_c1')+($2-'$ycoord_c1')*($2-'$ycoord_c1')+($3-'$zcoord_c1')*($3-'$zcoord_c1'))<='$rc_plus' && $4<='$filter_p' && $4>='$filter_m' ) print $4}' x.dat >> xc1_filter.txt

awk '{ if (sqrt(($1-'$xcoord_c1')*($1-'$xcoord_c1')+($2-'$ycoord_c1')*($2-'$ycoord_c1')+($3-'$zcoord_c1')*($3-'$zcoord_c1'))>='$rc_minus' && sqrt(($1-'$xcoord_c1')*($1-'$xcoord_c1')+($2-'$ycoord_c1')*($2-'$ycoord_c1')+($3-'$zcoord_c1')*($3-'$zcoord_c1'))<='$rc_plus' && $4<='$filter_p' && $4>='$filter_m' ) print $4}' y.dat >> yc1_filter.txt

awk '{ if (sqrt(($1-'$xcoord_c1')*($1-'$xcoord_c1')+($2-'$ycoord_c1')*($2-'$ycoord_c1')+($3-'$zcoord_c1')*($3-'$zcoord_c1'))>='$rc_minus' && sqrt(($1-'$xcoord_c1')*($1-'$xcoord_c1')+($2-'$ycoord_c1')*($2-'$ycoord_c1')+($3-'$zcoord_c1')*($3-'$zcoord_c1'))<='$rc_plus' && $4<='$filter_p' && $4>='$filter_m' ) print $4}' z.dat >> zc1_filter.txt

awk '{ if (sqrt(($1-'$xcoord_c2')*($1-'$xcoord_c2')+($2-'$ycoord_c2')*($2-'$ycoord_c2')+($3-'$zcoord_c2')*($3-'$zcoord_c2'))>='$rc_minus' && sqrt(($1-'$xcoord_c2')*($1-'$xcoord_c2')+($2-'$ycoord_c2')*($2-'$ycoord_c2')+($3-'$zcoord_c2')*($3-'$zcoord_c2'))<='$rc_plus' && $4<='$filter_p' && $4>='$filter_m' ) print $4}' x.dat >> xc2_filter.txt

awk '{ if (sqrt(($1-'$xcoord_c2')*($1-'$xcoord_c2')+($2-'$ycoord_c2')*($2-'$ycoord_c2')+($3-'$zcoord_c2')*($3-'$zcoord_c2'))>='$rc_minus' && sqrt(($1-'$xcoord_c2')*($1-'$xcoord_c2')+($2-'$ycoord_c2')*($2-'$ycoord_c2')+($3-'$zcoord_c2')*($3-'$zcoord_c2'))<='$rc_plus' && $4<='$filter_p' && $4>='$filter_m' ) print $4}' y.dat >> yc2_filter.txt

awk '{ if (sqrt(($1-'$xcoord_c2')*($1-'$xcoord_c2')+($2-'$ycoord_c2')*($2-'$ycoord_c2')+($3-'$zcoord_c2')*($3-'$zcoord_c2'))>='$rc_minus' && sqrt(($1-'$xcoord_c2')*($1-'$xcoord_c2')+($2-'$ycoord_c2')*($2-'$ycoord_c2')+($3-'$zcoord_c2')*($3-'$zcoord_c2'))<='$rc_plus' && $4<='$filter_p' && $4>='$filter_m' ) print $4}' z.dat >> zc2_filter.txt

field_xau=$(awk '{ sum += $1 } END { if (NR > 0) printf("%f", sum / NR) }' xau_filter.txt)
field_yau=$(awk '{ sum += $1 } END { if (NR > 0) printf("%f", sum / NR) }' yau_filter.txt)
field_zau=$(awk '{ sum += $1 } END { if (NR > 0) printf("%f", sum / NR) }' zau_filter.txt)

field_xc1=$(awk '{ sum += $1 } END { if (NR > 0) printf("%f", sum / NR) }' xc1_filter.txt)
field_yc1=$(awk '{ sum += $1 } END { if (NR > 0) printf("%f", sum / NR) }' yc1_filter.txt)
field_zc1=$(awk '{ sum += $1 } END { if (NR > 0) printf("%f", sum / NR) }' zc1_filter.txt)

field_xc2=$(awk '{ sum += $1 } END { if (NR > 0) printf("%f", sum / NR) }' xc2_filter.txt)
field_yc2=$(awk '{ sum += $1 } END { if (NR > 0) printf("%f", sum / NR) }' yc2_filter.txt)
field_zc2=$(awk '{ sum += $1 } END { if (NR > 0) printf("%f", sum / NR) }' zc2_filter.txt)


echo $field_xau 
echo $field_yau 
echo $field_zau
echo $field_xc1
echo $field_yc1
echo $field_zc1
echo $field_xc2
echo $field_yc2
echo $field_zc2

#Au-C1 bond
echo "Au-C1 bond"
av1_x=$(echo "($field_xau + $field_xc1)/2.0" | bc -l)
av1_y=$(echo "($field_yau + $field_yc1)/2.0" | bc -l)
av1_z=$(echo "($field_zau + $field_zc1)/2.0" | bc -l)

echo $av1_x
echo $av1_y
echo $av1_z


norm1=$(echo "sqrt((($xcoord_au)-($xcoord_c1))*(($xcoord_au)-($xcoord_c1))+(($ycoord_au)-($ycoord_c1))*(($ycoord_au)-($ycoord_c1))+(($zcoord_au)-($zcoord_c1))*(($zcoord_au)-($zcoord_c1)))" | bc -l)
echo "Bond length"
echo $norm1

norm1_x=$(echo " ((($xcoord_c1)-($xcoord_au))/$norm1)" | bc -l)
norm1_y=$(echo " ((($ycoord_c1)-($ycoord_au))/$norm1)" | bc -l)
norm1_z=$(echo " ((($zcoord_c1)-($zcoord_au))/$norm1)" | bc -l)
echo $norm1_x
echo $norm1_y
echo $norm1_z

FieldAuC1=$(echo "(($av1_x*$norm1_x+$av1_y*$norm1_y+$av1_z*$norm1_z)*5142.20652)" | bc -l)
echo "Au-C1 Projected Field"
echo $FieldAuC1

#Au-C2 bond
echo "Au-C2 bond"
av2_x=$(echo "($field_xau + $field_xc2)/2.0" | bc -l)
av2_y=$(echo "($field_yau + $field_yc2)/2.0" | bc -l)
av2_z=$(echo "($field_zau + $field_zc2)/2.0" | bc -l)

echo $av2_x
echo $av2_y
echo $av2_z


norm2=$(echo "sqrt((($xcoord_au)-($xcoord_c2))*(($xcoord_au)-($xcoord_c2))+(($ycoord_au)-($ycoord_c2))*(($ycoord_au)-($ycoord_c2))+(($zcoord_au)-($zcoord_c2))*(($zcoord_au)-($zcoord_c2)))" | bc -l)
echo "Bond length"
echo $norm2

norm2_x=$(echo " ((($xcoord_c2)-($xcoord_au))/$norm2)" | bc -l)
norm2_y=$(echo " ((($ycoord_c2)-($ycoord_au))/$norm2)" | bc -l)
norm2_z=$(echo " ((($zcoord_c2)-($zcoord_au))/$norm2)" | bc -l)
echo $norm2_x
echo $norm2_y
echo $norm2_z

FieldAuC2=$(echo "(($av2_x*$norm2_x+$av2_y*$norm2_y+$av2_z*$norm2_z)*5142.20652)" | bc -l)
echo "Au-C2 Projected Field"
echo $FieldAuC2

#C1-C2 bond
echo "C1-C2 bond"
av3_x=$(echo "($field_xc1 + $field_xc2)/2.0" | bc -l)
av3_y=$(echo "($field_yc1 + $field_yc2)/2.0" | bc -l)
av3_z=$(echo "($field_zc1 + $field_zc2)/2.0" | bc -l)

echo $av3_x
echo $av3_y
echo $av3_z


norm3=$(echo "sqrt((($xcoord_c1)-($xcoord_c2))*(($xcoord_c1)-($xcoord_c2))+(($ycoord_c1)-($ycoord_c2))*(($ycoord_c1)-($ycoord_c2))+(($zcoord_c1)-($zcoord_c2))*(($zcoord_c1)-($zcoord_c2)))" | bc -l)
echo "Bond length"
echo $norm3

norm3_x=$(echo " ((($xcoord_c2)-($xcoord_c1))/$norm3)" | bc -l)
norm3_y=$(echo " ((($ycoord_c2)-($ycoord_c1))/$norm3)" | bc -l)
norm3_z=$(echo " ((($zcoord_c2)-($zcoord_c1))/$norm3)" | bc -l)
echo $norm3_x
echo $norm3_y
echo $norm3_z

FieldC1C2=$(echo "(($av3_x*$norm3_x+$av3_y*$norm3_y+$av3_z*$norm3_z)*5142.20652)" | bc -l)
echo "C1-C2 Projected Field"
echo $FieldC1C2




