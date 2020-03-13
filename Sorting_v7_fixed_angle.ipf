//Copyright Abdul Rahman Mohtasebzadeh 2020
//This notice and this permission notice shall be included in all copies or
//substantial portions of the Software. If you use you have to cite or reference

#pragma rtGlobals=1		// Use modern global access method.

function sortang_v7()
variable b
variable c

NewDataFolder root:tryFolders:tests
Newdatafolder root:tryFolders:tests:AveragedPhi
Newdatafolder root:tryFolders:tests:All_sorted_R
Newdatafolder root:tryFolders:tests:Phi_R
Newdatafolder root:tryFolders:tests:Phi_IM

wave All_points_x,All_points_y,waveNy, waveNx

//make 


		For (b=0; b < numpnts(All_points_x); b+=1)
        	
        		 string wNameX = "point"+num2str(b)+"x"
        		 duplicate/o All_points_x, $wNameX
       	 	 wave waveNx =$wnamex
        		 WAVENx= All_points_x[b]        

			 string wNameY = "point"+num2str(b)+"y"
        		 duplicate/o All_points_y, $wNameY
        		 wave waveNy =$wnamey
        		 WAVENy= All_points_y[b]        

 	
 			string rPx = "Rx"+num2str(b)+"ToAll"
    			string rPy = "Ry"+num2str(b)+"ToAll"
    			string Ar = "R"+num2str(b)
    		 
    			duplicate/o All_points_x, $rPx, $rPy, $Ar
   			wave rPxWave=$rPx, rPyWave=$rPy, Rwaves=$Ar
    		 
    		 
    			rPxWave=(All_points_x-wavenx)^2		
     			rPyWave=(All_points_y-waveny)^2	
     			Rwaves = sqrt(rPyWave+rPxWave)
    		 
    		 
    			string bol = "Concat"+num2str(b)+"xyr"
      			Duplicate /o Rwaves , $bol
      		
      		
      			Wave bolit=$bol
      			Concatenate  {All_points_x,All_points_y},bolit
    		 
    		 
    		 
    		 	string dataR= "Sorted"+"R"+num2str(b)
      			duplicate /o Rwaves , $dataR
      			wave Rsorted=$dataR
      			Extract /o Rwaves , Rsorted , Rwaves >=7 && Rwaves <=12 
      		
      			string dataBolit= "Sorted"+"BOL"+num2str(b)
      			duplicate /o Rwaves , $dataBolit
      			wave BolSort=$dataBolit
      		
      			Extract /o bolit , BolSort , bolit >=7 && bolit <=12 
      		
      		
      					string consort = "ConSORT"+num2str(b)+"rxy"
		
		Duplicate /o bolit , $consort
		wave consi=$consort 
		
		MatrixOP/O index = col(consi,0)
		index = index[p] > 7 && index[p] < 12 ? p : NaN
		Wavetransform zapNaNs index
		Make/O/N=(numpnts(index),3) $consort = bolit[index[p]][q]

 			
			string recon = "recon"+num2str(b)+"rxy"
			string recon_col0 = "R"+num2str(b)+"recon"
    			string recon_col1 = "NearbyR"+num2str(b)+"x"
    			string recon_col2 = "NearbyR"+num2str(b)+"y"
    			
    			wave RC1=$recon_col1
    			wave RC2=$recon_col2							//added these two waves for my new forloop
			
		 	wave beson=$recon
		 	
		Duplicate /o consi, beson
		Duplicate /o beson, $recon, $recon_col0, $recon_col1 ,$recon_col2
	
			
				redimension /n=(Dimsize(beson,0)) $recon_col0												//	uncom		
				redimension /n=(Dimsize(beson,0)) $recon_col1												//	uncom	
				redimension /n=(Dimsize(beson,0)) $recon_col2											//	uncom

		wave	rec0=$recon_col0, rec1=$recon_col1, rec2=$recon_col2
		
				rec0=beson[p][0]																		//	uncom
				rec1=beson[p][1]																		//	uncom
				rec2=beson[p][2]																		//	uncom

 		
 		//added 
 	
 		
 		
 			string Angles= "Angle"+"R"+num2str(b)
      			duplicate /o $dataR , $Angles
      		//	Angles=atan(DataR[])* 180/pi
 		
 		
 		
 		
      		
      		// PART 4: for each point in sortes concatenated waves , and gives them names 	
      			
      			string EachPointFolder = "PointR"+num2str(b)+"xy" 
			
      			NewDataFolder root:tryFolders:tests:$EachPointFolder
			//NewDataFolder root:tryFolders:tests:EachR
      				
      				
      				MoveWave root:tryFolders:$dataR,  root:tryFolders:tests:$(EachPointFolder):
 				MoveWave root:tryFolders:$Angles,  root:tryFolders:tests:$(EachPointFolder):
      				MoveWave root:tryFolders:$wNameX,  root:tryFolders:tests:$(EachPointFolder):
      				MoveWave root:tryFolders:$wNameY,  root:tryFolders:tests:$(EachPointFolder):
      				MoveWave root:tryFolders:$consort,  root:tryFolders:tests:$(EachPointFolder):
      				MoveWave root:tryFolders:$recon_col1, root:tryFolders:tests:$(EachPointFolder):
      				MoveWave root:tryFolders:$recon_col2, root:tryFolders:tests:$(EachPointFolder):
      				
      			
      			//	MoveWave root:tryFolders:$Ar,  root:tryFolders:EachR
      				
      				
   killwaves/a/z 				



 					    DFREF tests = GetDataFolderDFR()
					//	  string WaveNear = "NearbyR"+num2str(b)+"xy" 
					    String folderName
				    Variable numDataFolders = CountObjectsDFR(tests, 4)
 
				    Variable i
			Variable/C ci = sqrt(-1)
   			//	Variable/C cv1 = cmplx(Cos_Angles,Sin_Angles)
   			//	Variable/C ci=cmplx(0,1)
   				
					  		for(i = 0; i < numDataFolders; i += 1)
								  FolderName = GetIndexedObjNameDFR(tests, 4, i)
 					 			 SetDataFolder ":'" + folderName + "':"
    					  			  // you can write some code here or use another function to do what you want
     								 //	  SetDataFolder ":'" +WaveNear + "':"
     					 	
     				
    							string PntX= "x"+num2str(b)
    					 	//	Make/o /n=(numpnts($Angles)) root:tryFolders:tests:$(EachPointFolder):bobbski
     					 		Duplicate/o root:tryFolders:tests:$(EachPointFolder):$Angles , root:tryFolders:tests:$(EachPointFolder):$PntX     					 		
     					 		wave PointX= root:tryFolders:tests:$(EachPointFolder):$Pntx
     					 		PointX = waveNx[b]
     					 
     					 		string PntY= "Y"+num2str(b)
    					 	//	Make/o /n=(numpnts($Angles)) root:tryFolders:tests:$(EachPointFolder):bobbski
     					 		Duplicate/o root:tryFolders:tests:$(EachPointFolder):$Angles , root:tryFolders:tests:$(EachPointFolder):$PntY
     					 		wave PointY= root:tryFolders:tests:$(EachPointFolder):$PntY
     					 		PointY = waveNy[b]
     					 		
     			
     					 		wave RC1=root:tryFolders:tests:$(EachPointFolder):$recon_col1
							wave RC2=root:tryFolders:tests:$(EachPointFolder):$recon_col2	
     					 		
     					 		
     					 		string difsX= "X"+num2str(b)+"difference"
    					 	//	Make/o /n=(numpnts($Angles)) root:tryFolders:tests:$(EachPointFolder):bobbski
     					 		Duplicate/o root:tryFolders:tests:$(EachPointFolder):$Angles , root:tryFolders:tests:$(EachPointFolder):$difsX
     					 		wave DifferenceX=root:tryFolders:tests:$(EachPointFolder):$difsX
     					 	//	wave RC1=root:tryFolders:$recon_col1
     					 		DifferenceX = RC1[p]-PointX[p]
     					 		
     					 		
     					 		string difsY= "Y"+num2str(b)+"difference"
    					 	//	Make/o /n=(numpnts($Angles)) root:tryFolders:tests:$(EachPointFolder):bobbski
     					 		Duplicate/o root:tryFolders:tests:$(EachPointFolder):$Angles , root:tryFolders:tests:$(EachPointFolder):$difsY
     					 		wave DifferenceY=root:tryFolders:tests:$(EachPointFolder):$difsY
     					 	//	wave RC2=root:tryFolders:$recon_col2
     					 		DifferenceY = RC2[p]-PointY[p]
     					 		
     					 		
     					 
     					 		string Angs= "Angs"+num2str(b)
    					 	//	Make/o /n=(numpnts($Angles)) root:tryFolders:tests:$(EachPointFolder):bobbski
     					 		Duplicate/o root:tryFolders:tests:$(EachPointFolder):$Angles , root:tryFolders:tests:$(EachPointFolder):$Angs
     					 		wave Angles_each = root:tryFolders:tests:$(EachPointFolder):$Angs
     					 		Angles_each = atan(DifferenceY[p]/DifferenceX[p])*180/Pi
     					 		
     					 		
     					 		
     					 		string Angs6= "6_Angs"+num2str(b)
    					 	//	Make/o /n=(numpnts($Angles)) root:tryFolders:tests:$(EachPointFolder):bobbski
     					 		Duplicate/o root:tryFolders:tests:$(EachPointFolder):$Angles , root:tryFolders:tests:$(EachPointFolder):$Angs6
     					 		wave Angles_each6 = root:tryFolders:tests:$(EachPointFolder):$Angs6
     					 		Angles_each6 = 6*Angles_each
     					 		
     					 		
     					 		
     					 		string cosAng= "CosAngs"+num2str(b)
    					 	//	Make/o /n=(numpnts($Angles)) root:tryFolders:tests:$(EachPointFolder):bobbski
     					 		Duplicate/o root:tryFolders:tests:$(EachPointFolder):$Angles , root:tryFolders:tests:$(EachPointFolder):$cosAng
     					 		wave Cos_Angles = root:tryFolders:tests:$(EachPointFolder):$cosAng
     					 		Cos_Angles = cos(Angles_each6)
     					 		
     					// 		Variable/C ci = sqrt(-1)
     					 		
     					 		string sinAng= "SinAngs"+num2str(b)
    					 	//	Make/o /n=(numpnts($Angles)) root:tryFolders:tests:$(EachPointFolder):bobbski
     					 		Duplicate /o root:tryFolders:tests:$(EachPointFolder):$Angles , root:tryFolders:tests:$(EachPointFolder):$sinAng
     					 		wave Sin_Angles = root:tryFolders:tests:$(EachPointFolder):$sinAng
     					 		Sin_Angles = sin(Angles_each6)
     					 		
     					 		
     					 		string iSin= "iSin"+num2str(b)
    					 	//	Make/o /n=(numpnts($Angles)) root:tryFolders:tests:$(EachPointFolder):bobbski
     					 		make /c/n=(numpnts(Angles_each)) root:tryFolders:tests:$(EachPointFolder):$iSin
     					 	//	Duplicate/o root:tryFolders:tests:$(EachPointFolder):$Angles , root:tryFolders:tests:$(EachPointFolder):$iSin
     					 		wave /c i_sin = root:tryFolders:tests:$(EachPointFolder):$iSin
     					 		i_sin  = (ci)*Sin_Angles
     					 		
     					 		
     					 		string Complexi= "Cmp"+num2str(b)
     					 		make /c/n=(numpnts(Angles_each)) root:tryFolders:tests:$(EachPointFolder):$Complexi
     					 		wave /C Complex_wave=root:tryFolders:tests:$(EachPointFolder):$Complexi
     							
     							Complex_wave = cmplx(Cos_Angles,Sin_Angles)
     							
     							string Sums= "Sums"+num2str(b)
    					 	//	Make/o /n=(numpnts($Angles)) root:tryFolders:tests:$(EachPointFolder):bobbski
     					 		make /c/n=1 root:tryFolders:tests:$(EachPointFolder):$Sums
     					 	//	Duplicate/o root:tryFolders:tests:$(EachPointFolder):$Angles , root:tryFolders:tests:$(EachPointFolder):$iSin
     					 		wave /c Sum_of_waves= root:tryFolders:tests:$(EachPointFolder):$Sums
     					 		Sum_of_waves  = Sum(Complex_wave)
     						
     							variable numbs=(numpnts(Angles_each)							// used this is better 
     																						//the other way of doing so is to do a wavestats /wavestats /c=2 cmp23 for complex part 
     																						//and wavestats cmp23 for real part, then move each third element of
     																						// vector WAVESTAT into a new complex wave that i would have to creat, 
     							
     							string Phi= "Phi"+num2str(b)
    					 	//	Make/o /n=(numpnts($Angles)) root:tryFolders:tests:$(EachPointFolder):bobbski
     					 		make /c/n=1 root:tryFolders:tests:$(EachPointFolder):$Phi
     					 	//	Duplicate/o root:tryFolders:tests:$(EachPointFolder):$Angles , root:tryFolders:tests:$(EachPointFolder):$iSin
     					 		wave /c Phi_real= root:tryFolders:tests:$(EachPointFolder):$Phi
     					 		Phi_real  = Sum_of_waves/numbs						//this better be labeled as Phi_r , because it is still not real its just complex and i am calculating conjugate in next line
     							
     							string PhiConj= "PhiConj"+num2str(b)
     							Duplicate/o root:tryFolders:tests:$(EachPointFolder):$Phi , root:tryFolders:tests:$(EachPointFolder):$PhiConj
     							wave /c Phi_Imaginary= root:tryFolders:tests:$(EachPointFolder):$PhiConj
     							Phi_Imaginary = conj(Phi_real)
     							
     							string Multip= "Muliptlied"+num2str(b)
     							Duplicate/o root:tryFolders:tests:$(EachPointFolder):$Phi , root:tryFolders:tests:$(EachPointFolder):$Multip
     							wave /c Multiplied= root:tryFolders:tests:$(EachPointFolder):$Multip
     							Multiplied = Phi_real * Phi_Imaginary
     							
     							string M= "M"+num2str(b)
     							make /n=1 root:tryFolders:tests:$(EachPointFolder):$M
     						//	Duplicate/o root:tryFolders:tests:$(EachPointFolder):$Phi , root:tryFolders:tests:$(EachPointFolder):$M
     							wave EM= root:tryFolders:tests:$(EachPointFolder):$M
     							EM[1] = Multiplied[1]
     							
     					 	//	Variable/C cv1 = cmplx(Cos_Angles,Sin_Angles)
     					 	//	Variable/C Complex_wave = cmplx(Cos_Angles,Sin_Angles)
     					 	
     			//		string Complexi1= "C"+num2str(b)
     					 //		duplicate/c/o root:tryFolders:tests:$(EachPointFolder):$Complexi, root:tryFolders:tests:$(EachPointFolder):$Complexi1
     					 //		wave Complex_wave1=root:tryFolders:tests:$(EachPointFolder):$Complexi
     							
     						
     							
     							Duplicate/o root:tryFolders:tests:$(EachPointFolder):$M , root:tryFolders:tests:AveragedPhi:$M
     							Duplicate/o root:tryFolders:tests:$(EachPointFolder):$dataR , root:tryFolders:tests:All_sorted_R:$dataR
     							Duplicate/o root:tryFolders:tests:$(EachPointFolder):$Phi , root:tryFolders:tests:Phi_R:$Phi
     							Duplicate/o root:tryFolders:tests:$(EachPointFolder):$PhiConj , root:tryFolders:tests:Phi_IM:$PhiConj
						 Endfor
     					
    		  
   				  SetDataFolder root:tryFolders
      	//	killwaves /A/Z	
    		EndFor
SetDataFolder root:tryFolders:tests:AveragedPhi
	Concatenate /NP WaveList("M*", ";","DIMS:1"), root:tryFolders:tests:AveragedPhi:outWave
	
SetDataFolder root:tryFolders:tests:All_sorted_R
	Concatenate /NP WaveList("SortedR*", ";","DIMS:1"), root:tryFolders:tests:All_sorted_R:All_R_waves

SetDataFolder root:tryFolders:tests:Phi_R
	Concatenate /NP WaveList("Phi*", ";","DIMS:1"), root:tryFolders:tests:Phi_R:ow_phi_r	
	
SetDataFolder root:tryFolders:tests:Phi_IM
	Concatenate /NP WaveList("PhiConj*", ";","DIMS:1"), root:tryFolders:tests:Phi_IM:ow_phi_im
END 
 
