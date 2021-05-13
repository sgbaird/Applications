(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



(* ::Input::Initialization:: *)
Notation`AutoLoadNotationPalette=False;
BeginPackage["LatticePlane`","Notation`"];
Notation`AutoLoadNotationPalette=True;
Unprotect@@Names["LatticePlane`*"];
Unprotect[Evaluate[Context[]<>"*"]];
(*Unprotect[Evaluate[Context[]<>"*"]];*)
ClearAll@@Names["LatticePlane`*"];
ClearAll["LatticePlane`Private`*"];


(* ::Input::Initialization:: *)
Off[General::spell1];
Off[Symbolize::boxSymbolExists];(*subscripted symbols*)
Symbolize[ParsedBoxWrapper[SubscriptBox["_","_"]]];(*this is the internal representation of Symbolize suggested by Jason Harris for Mma package, see https://groups.google.com/g/comp.soft-sys.math.mathematica/c/rhIhi-v_D5E?pli=1*)
On[Symbolize::boxSymbolExists];


(* ::Input::Initialization:: *)
ParseHKL::usage="ParseHKL[hklIn]";
Reciprocal::usage="Reciprocal[hklIn";
AssignAxis::usage="AssignAxis[n,valIn,\[Gamma]]";
AssignAxes::usage="AssignAxes[\[ScriptCapitalI],\[Gamma]]";
GetPositions::usage="GetPositions[\[ScriptCapitalI]]";
OneDimension::usage="OneDimension[\[ScriptCapitalI],\[Gamma]]";
TwoDimension::usage="TwoDimension[\[ScriptCapitalI],\[Gamma]]";
MillerToPlane::usage="MillerToPlane[hkl,\[Gamma]]";
UnitCell::usage="UnitCell[xyz]";
InterplanarAngle::usage="InterplanarAngle[hkl1,hkl2,lattice]";
DegenerateMesh::usage="DegenerateMesh[v]";
TotalIntersectionArea::usage="TotalIntersectionArea[\[ScriptCapitalT],\[ScriptCapitalB]]";


(* ::Input::Initialization:: *)
Begin["`Private`"];


(* ::Input::Initialization:: *)
ParseHKL[hklIn_]:=Module[{hkl},
hkl=hklIn/.{OverBar->Minus,0->Indeterminate};
If[Length@hkl==4,hkl=hkl[[{1,2,4}]],hkl]
]


(* ::Input::Initialization:: *)
Reciprocal[hklIn_]:=1/ParseHKL@hklIn


(* ::Input::Initialization:: *)
AssignAxis[n_,valIn_,\[Gamma]_,OptionsPattern[{"BasisVectors"->Null}]]:=Module[{val,B},
val=If[Length@valIn==0,valIn,valIn[[n]]];
B=OptionValue["BasisVectors"];
(*tri=SASTriangle[a,\[Gamma],b]\[LeftDoubleBracket]1\[RightDoubleBracket];*)
If[B===Null,
Switch[n,1,{val,0,0},2,{val,val,0}*{Cos[(*90\[Degree]-*)\[Gamma]],Sin[(*90\[Degree]-*)\[Gamma]],0},3,{0,0,val}],
B[[n]]val
]
]


(* ::Input::Initialization:: *)
AssignAxes[\[ScriptCapitalI]_,\[Gamma]_,OptionsPattern[{"BasisVectors"->Null}]]:=Module[{},
MapThread[AssignAxis[#1,#2,\[Gamma],"BasisVectors"->OptionValue["BasisVectors"]]&,{{1,2,3},\[ScriptCapitalI]}]
]


(* ::Input::Initialization:: *)
GetPositions[\[ScriptCapitalI]_]:=Flatten@Position[NumberQ/@\[ScriptCapitalI],#]&/@{True(*p*),False(*f*)}


(* ::Input::Initialization:: *)
Options[OneDimension]={"BasisVectors"->Null};
OneDimension[\[ScriptCapitalI]_,\[Gamma]_,OptionsPattern[]]:=Module[{p,f,p1,f1,f2,f3,\[ScriptCapitalO],\[ScriptCapitalA],\[ScriptCapitalB],B},
B=OptionValue["BasisVectors"];
opts="BasisVectors"->B;
{p,f}=GetPositions@\[ScriptCapitalI];
p1=p[[1]];
{f1,f2}=f;
f3=Complement[Range[3],f];
If[B===Null,
\[ScriptCapitalO]=AssignAxis[p1,\[ScriptCapitalI],\[Gamma]],
\[ScriptCapitalO]=(B[[f3]]\[ScriptCapitalI][[f3]])[[1]]
];
\[ScriptCapitalA]=AssignAxis[f1,1,\[Gamma],opts];
\[ScriptCapitalB]=AssignAxis[f2,1,\[Gamma],opts];
InfinitePlane[\[ScriptCapitalO],{\[ScriptCapitalA],\[ScriptCapitalB]}]
]


(* ::Input::Initialization:: *)
TwoDimension[\[ScriptCapitalI]_,\[Gamma]_,OptionsPattern[{"BasisVectors"->Null}]]:=Module[{p,f,p1,p2,f1,\[ScriptCapitalO],\[ScriptCapitalA],\[ScriptCapitalB]},
{p,f}=GetPositions@\[ScriptCapitalI];
{p1,p2}=p[[ ;;2]];
f1=f[[1]];
{f2,f3}=Complement[Range@3,f];
B=OptionValue["BasisVectors"];
If[B===Null,
\[ScriptCapitalO]=AssignAxis[p1,\[ScriptCapitalI],\[Gamma]];\[ScriptCapitalA]=AssignAxis[p2,\[ScriptCapitalI],\[Gamma]],
\[ScriptCapitalO]=B[[f2]]\[ScriptCapitalI][[f2]];\[ScriptCapitalA]=B[[f3]]\[ScriptCapitalI][[f3]]
];
\[ScriptCapitalB]=AssignAxis[f1,1,\[Gamma]];
If[B===Null,
InfinitePlane[{0,0,0},{\[ScriptCapitalA]-\[ScriptCapitalO],\[ScriptCapitalB]}],
InfinitePlane[\[ScriptCapitalA],{\[ScriptCapitalA]-\[ScriptCapitalO],\[ScriptCapitalB]}]
]
]


(* ::Input::Initialization:: *)
MillerToPlane[hkl_,\[Gamma]_.,OptionsPattern[{"BasisVectors"->Null}]]:=Module[{\[ScriptCapitalI],p1,p,f,B},
B=OptionValue["BasisVectors"];
\[ScriptCapitalI]=Reciprocal[hkl];
{p,f}=GetPositions@\[ScriptCapitalI];
Switch[Length@p(*number of real-valued dimensions*),1,OneDimension[\[ScriptCapitalI],\[Gamma],"BasisVectors"->B],2,TwoDimension[\[ScriptCapitalI],\[Gamma],"BasisVectors"->B],3,InfinitePlane@AssignAxes[\[ScriptCapitalI],\[Gamma],"BasisVectors"->B]]
]


(* ::Input::Initialization:: *)
ReadXYZ[xyzpath_]:=Import[xyzpath,"Table"][[3;;,2;;4]];


(* ::Input::Initialization:: *)
UnitCell[xyz_]:=Module[{\[ScriptCapitalM],\[ScriptP],\[ScriptCapitalC],P,i,\[ScriptCapitalN],\[ScriptCapitalO]},
\[ScriptCapitalM]=Region`Mesh`MergeCells@ConvexHullMesh@xyz;
\[ScriptP]=MeshCoordinates@\[ScriptCapitalM];
\[ScriptP]=\[ScriptP](1+$MachineEpsilon);
\[ScriptCapitalC]=MeshCells[\[ScriptCapitalM],1][[;;,1]];
(*\[ScriptM]={\[ScriptCapitalC]\[LeftDoubleBracket]#\[RightDoubleBracket],\[ScriptP]\[LeftDoubleBracket]#\[RightDoubleBracket]}&/@Range@Length@\[ScriptP];
\[ScriptCapitalN]=Select[\[ScriptM],ContainsAny[#\[LeftDoubleBracket]1\[RightDoubleBracket],{1}]&]\[LeftDoubleBracket];;,2\[RightDoubleBracket];*)
P=Position[\[ScriptCapitalC],_?(ContainsAny[#,{1}]&),1]//Flatten;
i=DeleteCases[Flatten[\[ScriptCapitalC][[P]]],1];
\[ScriptCapitalN]=\[ScriptP][[i]];
\[ScriptCapitalO]=\[ScriptP][[1]];(*\[ScriptCapitalN]=Nearest[\[ScriptP]\[LeftDoubleBracket]2;;\[RightDoubleBracket],\[ScriptCapitalO],3];*)
Parallelepiped[\[ScriptCapitalO],\[ScriptCapitalN]]
]


(* ::Input::Initialization:: *)
InterplanarAngle[hkl1_,hkl2_,lattice_:"cubic"]:=Module[{h1,k1,l1,h2,k2,l2},
{h1,k1,l1}=ParseHKL@hkl1/. Indeterminate\[RightArrow]0;
{h2,k2,l2}=ParseHKL@hkl2/. Indeterminate\[RightArrow]0;Switch[lattice,"cubic",ArcCos[ (h1 h2+k1 k2+l1 l2)/(\:f000h12+k12+l12\:f006 \:f000h22+k22+l22\:f006)],"hexagonal",Null,"tetragonal",Null,"trigonal",Null,"monoclinic",Null,"triclinic",Null,"orthorhombic",Null]]


(* ::Input::Initialization:: *)
DegenerateMesh[v_]:=Module[{\[ScriptCapitalR],\[ScriptCapitalN]},\[ScriptCapitalR]=DelaunayMesh@DimensionReduce@v;
\[ScriptCapitalN]=Range@Length@v;
\[ScriptCapitalT]=Last@MeshCells@\[ScriptCapitalR]/. Polygon\[RightArrow]Simplex/. MapThread[#1\[RightArrow]#2&,{\[ScriptCapitalN],v}]]


(* ::Input::Initialization:: *)
TotalIntersectionArea[\[ScriptCapitalT]_,\[ScriptCapitalB]_]:=Table[Area@RegionIntersection[t,b],{t,\[ScriptCapitalT]},{b,\[ScriptCapitalB]}]/. Undefined\[RightArrow]Sequence@@{}//Flatten//Total


(* ::Input::Initialization:: *)
End[];
On[General::spell1];
Protect@@Names["LatticePlane`*"];
(*Protect[Evaluate[Context[]<>"*"]];*)
EndPackage[];


