(* Content-type: application/vnd.wolfram.cdf.text *)

(*** Wolfram CDF File ***)
(* http://www.wolfram.com/cdf *)

(* CreatedBy='Mathematica 12.0' *)

(***************************************************************************)
(*                                                                         *)
(*                                                                         *)
(*  Under the Wolfram FreeCDF terms of use, this file and its content are  *)
(*  bound by the Creative Commons BY-SA Attribution-ShareAlike license.    *)
(*                                                                         *)
(*        For additional information concerning CDF licensing, see:        *)
(*                                                                         *)
(*         www.wolfram.com/cdf/adopting-cdf/licensing-options.html         *)
(*                                                                         *)
(*                                                                         *)
(***************************************************************************)

(*CacheID: 234*)
(* Internal cache information:
NotebookFileLineBreakTest
NotebookFileLineBreakTest
NotebookDataPosition[      1088,         20]
NotebookDataLength[    425922,       7528]
NotebookOptionsPosition[    421108,       7428]
NotebookOutlinePosition[    423153,       7478]
CellTagsIndexPosition[    422817,       7466]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{

Cell[CellGroupData[{
Cell["Hamiltonian Monte Carlo for Bivariate Normal distribution", "DemoTitle",
 CellChangeTimes->{{3.81763621798999*^9, 
  3.8176362565984573`*^9}},ExpressionUUID->"78f83cfc-6770-414c-a033-\
2371b6fe21cf"],

Cell[CellGroupData[{

Cell["", "InitializationSection",ExpressionUUID->"9b05f870-aeb8-4b0a-ba25-fa4081eb5c94"],

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"hmc", "[", 
    RowBox[{
    "U_", ",", "dU_", ",", "ddU_", ",", "Dim_", ",", "BURNIN_", ",", 
     "EPISODE_", ",", "vanilla0_", ",", "switch_"}], "]"}], ":=", 
   RowBox[{"Module", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"CHAINS", "=", "5"}], ",", "\n", 
       RowBox[{"STEPS", "=", "5"}], ",", "qAll", ",", "pAll", ",", "Utotal", 
       ",", "Ktotal", ",", "Htotal", ",", "s", ",", "S", ",", "AS", ",", "ES",
        ",", "KtotalNew", ",", "dt", ",", "p", ",", "q0", ",", "UE", ",", 
       "\[Alpha]", ",", "q", ",", "j", ",", "Htotal1", ",", "Htotal2", ",", 
       "i", ",", "\n", 
       RowBox[{"ND", "=", 
        RowBox[{"NormalDistribution", "[", 
         RowBox[{"0", ",", "1"}], "]"}]}], ",", "\n", 
       RowBox[{"UD", "=", 
        RowBox[{"UniformDistribution", "[", "]"}]}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{"QS", "=", 
        RowBox[{"List", "[", "]"}]}], ",", "\n", 
       RowBox[{"vanilla", "=", "vanilla0"}], ",", 
       RowBox[{"dt1", "=", "0.000000001"}], ",", 
       RowBox[{"dt2", "=", "0.0001"}], ",", 
       RowBox[{"ACS", "=", 
        RowBox[{"{", "}"}]}]}], "}"}], ",", "\n", 
     RowBox[{
      RowBox[{"pAll", "=", 
       RowBox[{"RandomVariate", "[", 
        RowBox[{"ND", ",", 
         RowBox[{"{", 
          RowBox[{"CHAINS", ",", "Dim"}], "}"}]}], "]"}]}], ";", "\n", 
      RowBox[{"qAll", "=", 
       RowBox[{"RandomVariate", "[", 
        RowBox[{"ND", ",", 
         RowBox[{"{", 
          RowBox[{"CHAINS", ",", "Dim"}], "}"}]}], "]"}]}], ";", "\n", 
      RowBox[{"Utotal", "=", 
       RowBox[{"Sum", "[", 
        RowBox[{
         RowBox[{"Apply", "[", " ", 
          RowBox[{"U", ",", 
           RowBox[{"qAll", "[", 
            RowBox[{"[", "i", "]"}], "]"}]}], "]"}], ",", 
         RowBox[{"{", 
          RowBox[{"i", ",", "1", ",", "CHAINS"}], "}"}]}], "]"}]}], ";", "\n", 
      RowBox[{"Htotal1", "=", "Utotal"}], ";", "\n", 
      RowBox[{"Htotal2", "=", "Utotal"}], ";", "\n", 
      RowBox[{"For", "[", 
       RowBox[{
        RowBox[{"j", "=", "1"}], ",", 
        RowBox[{"j", "\[LessSlantEqual]", "EPISODE"}], ",", 
        RowBox[{"j", "++"}], ",", "\n", 
        RowBox[{
         RowBox[{"pAll", "=", 
          RowBox[{"RandomVariate", "[", 
           RowBox[{"ND", ",", 
            RowBox[{"{", 
             RowBox[{"CHAINS", ",", "Dim"}], "}"}]}], "]"}]}], ";", "\n", 
         RowBox[{"KtotalNew", " ", "=", " ", 
          RowBox[{"Sum", "[", 
           RowBox[{
            RowBox[{
             RowBox[{"If", "[", 
              RowBox[{"vanilla", ",", 
               RowBox[{
                RowBox[{"pAll", "[", 
                 RowBox[{"[", "i", "]"}], "]"}], ".", 
                RowBox[{"pAll", "[", 
                 RowBox[{"[", "i", "]"}], "]"}]}], ",", 
               RowBox[{
                RowBox[{"pAll", "[", 
                 RowBox[{"[", "i", "]"}], "]"}], ".", " ", 
                RowBox[{"LinearSolve", "[", 
                 RowBox[{
                  RowBox[{"Apply", "[", 
                   RowBox[{"ddU", ",", 
                    RowBox[{"qAll", "[", 
                    RowBox[{"[", "i", "]"}], "]"}]}], "]"}], ",", 
                  RowBox[{"pAll", "[", 
                   RowBox[{"[", "i", "]"}], "]"}]}], "]"}]}]}], "]"}], "/", 
             "2"}], ",", 
            RowBox[{"{", 
             RowBox[{"i", ",", "1", ",", "CHAINS"}], "}"}]}], "]"}]}], ";", 
         "\n", 
         RowBox[{"Utotal", "=", 
          RowBox[{"Sum", "[", 
           RowBox[{
            RowBox[{"Apply", "[", " ", 
             RowBox[{"U", ",", 
              RowBox[{"qAll", "[", 
               RowBox[{"[", "i", "]"}], "]"}]}], "]"}], ",", 
            RowBox[{"{", 
             RowBox[{"i", ",", "1", ",", "CHAINS"}], "}"}]}], "]"}]}], ";", 
         "\n", 
         RowBox[{"Htotal", "=", 
          RowBox[{"If", "[", 
           RowBox[{"vanilla", ",", "Htotal1", ",", "Htotal2"}], "]"}]}], ";", 
         "\n", 
         RowBox[{"dt", "=", 
          RowBox[{"If", "[", 
           RowBox[{"vanilla", ",", "dt1", ",", "dt2"}], "]"}]}], ";", "\n", 
         RowBox[{"Ktotal", "=", 
          RowBox[{"Htotal", "-", "Utotal"}]}], ";", "\n", 
         RowBox[{"pAll", "=", 
          RowBox[{"pAll", " ", 
           RowBox[{"Sqrt", "[", 
            RowBox[{"Abs", "[", 
             RowBox[{"Ktotal", "/", "KtotalNew"}], "]"}], "]"}]}]}], ";", 
         "\n", 
         RowBox[{"ES", "=", 
          RowBox[{"{", "}"}]}], ";", "\n", 
         RowBox[{"AS", "=", 
          RowBox[{"{", "}"}]}], ";", "\n", 
         RowBox[{"For", "[", 
          RowBox[{
           RowBox[{"i", "=", "1"}], ",", 
           RowBox[{"i", "<=", "CHAINS"}], ",", 
           RowBox[{"i", "++"}], ",", "\n", 
           RowBox[{
            RowBox[{"p", "=", 
             RowBox[{"pAll", "[", 
              RowBox[{"[", "i", "]"}], "]"}]}], ";", "\n", 
            RowBox[{"q", "=", 
             RowBox[{"qAll", "[", 
              RowBox[{"[", "i", "]"}], "]"}]}], ";", "\n", 
            RowBox[{"UE", "=", 
             RowBox[{"{", 
              RowBox[{"Apply", "[", " ", 
               RowBox[{"U", ",", "q"}], "]"}], "}"}]}], ";", "\n", 
            RowBox[{"q0", "=", "q"}], ";", "\n", 
            RowBox[{"For", "[", 
             RowBox[{
              RowBox[{
               RowBox[{"s", "=", "1"}], ";"}], ",", 
              RowBox[{"s", "<=", "STEPS"}], ",", 
              RowBox[{"s", "++"}], ",", "\n", 
              RowBox[{
               RowBox[{"p", "=", 
                RowBox[{"p", "-", 
                 RowBox[{"dt", " ", 
                  RowBox[{"Apply", "[", 
                   RowBox[{"dU", ",", "q"}], "]"}]}]}]}], ";", "\n", 
               RowBox[{"q", "=", 
                RowBox[{"q", "+", 
                 RowBox[{"dt", " ", 
                  RowBox[{"If", "[", 
                   RowBox[{"vanilla", ",", "p", ",", 
                    RowBox[{"LinearSolve", "[", 
                    RowBox[{
                    RowBox[{"Apply", "[", 
                    RowBox[{"ddU", ",", "q"}], "]"}], ",", "p"}], "]"}]}], 
                   "]"}]}]}]}], ";", "\n", 
               RowBox[{"UE", "=", 
                RowBox[{"Append", "[", 
                 RowBox[{"UE", ",", 
                  RowBox[{"Apply", "[", " ", 
                   RowBox[{"U", ",", "q"}], "]"}]}], "]"}]}]}]}], "]"}], ";", 
            "\n", 
            RowBox[{"ES", "=", 
             RowBox[{"Append", "[", 
              RowBox[{"ES", ",", "UE"}], "]"}]}], ";", "\n", 
            RowBox[{"\[Alpha]", "=", 
             RowBox[{"Exp", "[", 
              RowBox[{"Clip", "[", 
               RowBox[{
                RowBox[{
                 RowBox[{"Apply", "[", 
                  RowBox[{"U", ",", "q0"}], "]"}], "-", 
                 RowBox[{"Apply", "[", 
                  RowBox[{"U", ",", "q"}], "]"}]}], ",", 
                RowBox[{"{", 
                 RowBox[{
                  RowBox[{"-", "20"}], ",", "0"}], "}"}]}], "]"}], "]"}]}], 
            ";", "\n", 
            RowBox[{"AS", "=", 
             RowBox[{"Append", "[", 
              RowBox[{"AS", ",", 
               RowBox[{"N", "[", "\[Alpha]", "]"}]}], "]"}]}], ";", "\n", 
            RowBox[{"If", "[", 
             RowBox[{
              RowBox[{"\[Alpha]", "<", 
               RowBox[{"RandomVariate", "[", "UD", "]"}]}], ",", 
              RowBox[{"q", "=", "q0"}]}], "]"}], ";", "\n", 
            RowBox[{
             RowBox[{"qAll", "[", 
              RowBox[{"[", "i", "]"}], "]"}], "=", "q"}], ";", "\n", 
            RowBox[{"If", "[", 
             RowBox[{
              RowBox[{"j", ">", "BURNIN"}], ",", 
              RowBox[{"QS", "=", 
               RowBox[{"Append", "[", 
                RowBox[{"QS", ",", "q"}], "]"}]}]}], "]"}]}]}], "]"}], ";", 
         "\n", 
         RowBox[{"s", "=", 
          RowBox[{"Union", "[", 
           RowBox[{"Flatten", "[", 
            RowBox[{"Table", "[", 
             RowBox[{
              RowBox[{"Ordering", "[", 
               RowBox[{
                RowBox[{"ES", "[", 
                 RowBox[{"[", "i", "]"}], "]"}], ",", "1"}], "]"}], ",", 
              RowBox[{"{", 
               RowBox[{"i", ",", "1", ",", "CHAINS"}], "}"}]}], "]"}], "]"}], 
           "]"}]}], ";", "\n", 
         RowBox[{"S", " ", "=", 
          RowBox[{"Union", "[", 
           RowBox[{"Flatten", "[", 
            RowBox[{"Table", "[", 
             RowBox[{
              RowBox[{"Ordering", "[", 
               RowBox[{
                RowBox[{"ES", "[", 
                 RowBox[{"[", "i", "]"}], "]"}], ",", 
                RowBox[{"-", "1"}]}], "]"}], ",", 
              RowBox[{"{", 
               RowBox[{"i", ",", "1", ",", "CHAINS"}], "}"}]}], "]"}], "]"}], 
           "]"}]}], ";", "\n", 
         RowBox[{"If", "[", 
          RowBox[{
           RowBox[{"j", "<", "BURNIN"}], ",", "\n", 
           RowBox[{
            RowBox[{"If", "[", 
             RowBox[{
              RowBox[{
               RowBox[{
                RowBox[{"s", "==", 
                 RowBox[{"{", 
                  RowBox[{"1", ",", 
                   RowBox[{"STEPS", "+", "1"}]}], "}"}]}], "&&", 
                RowBox[{"S", "==", 
                 RowBox[{"{", 
                  RowBox[{"1", ",", 
                   RowBox[{"STEPS", "+", "1"}]}], "}"}]}]}], "||", " ", 
               RowBox[{
                RowBox[{"s", "==", 
                 RowBox[{"{", 
                  RowBox[{"STEPS", "+", "1"}], "}"}]}], "&&", 
                RowBox[{"S", "==", 
                 RowBox[{"{", "1", "}"}]}]}]}], ",", 
              RowBox[{"dt", "=", 
               RowBox[{"dt", " ", "1.1"}]}]}], "]"}], ";", "\n", 
            RowBox[{"If", "[", 
             RowBox[{
              RowBox[{
               RowBox[{"s", "==", 
                RowBox[{"{", "1", "}"}]}], " ", "||", " ", 
               RowBox[{"S", "==", 
                RowBox[{"{", 
                 RowBox[{"STEPS", "+", "1"}], "}"}]}]}], ",", 
              RowBox[{"dt", "=", 
               RowBox[{"dt", "/", "1.1"}]}]}], "]"}], ";", "\n", 
            RowBox[{"If", "[", 
             RowBox[{
              RowBox[{
               RowBox[{"Ktotal", ">", "0"}], "&&", 
               RowBox[{"KtotalNew", ">", "0"}]}], ",", "\n", 
              RowBox[{"If", "[", 
               RowBox[{
                RowBox[{
                 RowBox[{"Utotal", "<", "0"}], "&&", 
                 RowBox[{"Htotal", ">", 
                  RowBox[{"Utotal", "/", "100"}]}]}], ",", 
                RowBox[{"Htotal", "=", 
                 RowBox[{"Utotal", "/", "100"}]}], ",", "\n", 
                RowBox[{"If", "[", 
                 RowBox[{
                  RowBox[{
                   RowBox[{"Utotal", ">", "0"}], "&&", 
                   RowBox[{"Htotal", ">", 
                    RowBox[{"100", "Utotal"}]}]}], ",", 
                  RowBox[{"Htotal", "=", 
                   RowBox[{"100", "Utotal"}]}], ",", "\n", 
                  RowBox[{
                   RowBox[{"If", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"Mean", "[", "AS", "]"}], ">", ".9"}], ",", 
                    RowBox[{"Ktotal", "=", 
                    RowBox[{"Ktotal", " ", "1.1"}]}], ",", "\n", 
                    RowBox[{"If", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"Mean", "[", "AS", "]"}], "<", ".1"}], ",", 
                    RowBox[{"Ktotal", "=", 
                    RowBox[{"Ktotal", "/", " ", "1.1"}]}]}], "]"}]}], "]"}], 
                   ";", 
                   RowBox[{"Htotal", "=", 
                    RowBox[{"Ktotal", "+", "Utotal"}]}]}]}], "]"}]}], "]"}]}],
              "]"}], ";", "\n", 
            RowBox[{"If", "[", 
             RowBox[{"vanilla", ",", "\n", 
              RowBox[{
               RowBox[{"Htotal1", "=", "Htotal"}], ";", "\n", 
               RowBox[{"dt1", "=", "dt"}]}], ",", "\n", 
              RowBox[{
               RowBox[{"Htotal2", "=", "Htotal"}], ";", "\n", 
               RowBox[{"dt2", "=", "dt"}]}]}], "]"}]}]}], "]"}], ";", "\n", 
         RowBox[{"If", "[", 
          RowBox[{"switch", " ", ",", 
           RowBox[{"vanilla", "=", 
            RowBox[{"Not", "[", "vanilla", "]"}]}]}], "]"}]}]}], "]"}], ";", 
      "QS"}]}], "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"HessianH", "[", 
    RowBox[{"f_", ",", 
     RowBox[{"x_List", "?", "VectorQ"}]}], "]"}], ":=", 
   RowBox[{"D", "[", 
    RowBox[{"f", ",", 
     RowBox[{"{", 
      RowBox[{"x", ",", "2"}], "}"}]}], "]"}]}], ";"}], "\n", 
 RowBox[{
  RowBox[{
   RowBox[{"GradientG", "[", 
    RowBox[{"f_", ",", 
     RowBox[{"x_List", "?", "VectorQ"}]}], "]"}], ":=", 
   RowBox[{"D", "[", 
    RowBox[{"f", ",", 
     RowBox[{"{", 
      RowBox[{"x", ",", "1"}], "}"}]}], "]"}]}], ";"}]}], "Input",
 InitializationCell->True,
 CellChangeTimes->{{3.817633843841125*^9, 3.817633849845765*^9}, 
   3.817634892240004*^9, 3.817635006712412*^9, {3.817635329198214*^9, 
   3.81763533088124*^9}, {3.817635411395554*^9, 3.817635421688518*^9}, {
   3.817636396468627*^9, 3.817636413124454*^9}, {3.817636530436499*^9, 
   3.817636553204424*^9}, {3.8176366901479692`*^9, 3.817636693366036*^9}, {
   3.817638449885684*^9, 3.817638470000327*^9}, {3.8176432329474707`*^9, 
   3.817643238446237*^9}, {3.8176434649033546`*^9, 3.817643468639069*^9}, {
   3.817643715026099*^9, 3.8176437192077913`*^9}, {3.817698939067992*^9, 
   3.817698940231873*^9}},
 CellID->932801461,ExpressionUUID->"ff71f218-c1dc-4809-bc46-03bf0850163d"]
}, Closed]],

Cell[CellGroupData[{

Cell["", "ManipulateSection",ExpressionUUID->"e3171994-32be-49b2-ae5b-18585b4652e4"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Manipulate", "[", 
  RowBox[{
   RowBox[{"Module", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
      "\[Rho]", ",", "QS", ",", "SIGMA", ",", "U", ",", "dU", ",", "ddU"}], 
      "}"}], ",", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"\[Rho]", "=", 
       RowBox[{"N", "[", 
        RowBox[{"1", "-", 
         FractionBox["1", 
          SuperscriptBox["10", "i"]]}], "]"}]}], ";", "\[IndentingNewLine]", 
      RowBox[{"SIGMA", "=", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"1", ",", "\[Rho]"}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{"\[Rho]", ",", "1"}], "}"}]}], "}"}]}], ";", 
      "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"U", "[", 
        RowBox[{"x_", ",", "y_"}], "]"}], "=", 
       RowBox[{
        FractionBox["1", "2"], 
        RowBox[{"Simplify", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{"x", ",", "y"}], "}"}], ".", 
          RowBox[{"LinearSolve", "[", 
           RowBox[{"SIGMA", ",", 
            RowBox[{"{", 
             RowBox[{"x", ",", "y"}], "}"}]}], "]"}]}], "]"}]}]}], ";", 
      "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"dU", "[", 
        RowBox[{"x_", ",", "y_"}], "]"}], "=", 
       RowBox[{"GradientG", "[", 
        RowBox[{
         RowBox[{"U", "[", 
          RowBox[{"x", ",", "y"}], "]"}], ",", 
         RowBox[{"{", 
          RowBox[{"x", ",", "y"}], "}"}]}], "]"}]}], ";", 
      RowBox[{
       RowBox[{"ddU", "[", 
        RowBox[{"x_", ",", "y_"}], "]"}], "=", 
       RowBox[{"HessianH", "[", 
        RowBox[{
         RowBox[{"U", "[", 
          RowBox[{"x", ",", "y"}], "]"}], ",", 
         RowBox[{"{", 
          RowBox[{"x", ",", "y"}], "}"}]}], "]"}]}], ";", 
      RowBox[{"QS", "=", 
       RowBox[{"hmc", "[", 
        RowBox[{
        "U", ",", "dU", ",", "ddU", ",", "2", ",", "1000", ",", "2000", ",", 
         "True", ",", "True"}], "]"}]}], ";", 
      RowBox[{"ListPlot", "[", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"QS", ",", 
          RowBox[{"QS", ".", 
           RowBox[{"MatrixPower", "[", 
            RowBox[{"SIGMA", ",", 
             RowBox[{"-", ".5"}]}], "]"}]}]}], "}"}], ",", 
        RowBox[{"PlotStyle", "\[Rule]", 
         RowBox[{"Opacity", "[", "1", "]"}]}], ",", 
        RowBox[{"PlotLabel", "\[Rule]", "SIGMA"}], ",", 
        RowBox[{"PlotLegends", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{"\"\<Samples\>\"", ",", "\"\<Transformed\>\""}], "}"}]}], 
        ",", 
        RowBox[{"AspectRatio", "\[Rule]", "1"}]}], "]"}]}]}], "]"}], ",", 
   "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{"i", ",", "1", ",", "8", ",", "1"}], "}"}], ",", " ", 
   RowBox[{"SaveDefinitions", "\[Rule]", "True"}]}], "]"}]], "Input",
 CellChangeTimes->{{3.817665268692634*^9, 3.817665341312356*^9}, {
  3.81769894815724*^9, 3.817698971281098*^9}, {3.8176990201860857`*^9, 
  3.817699021720746*^9}},
 CellLabel->"(Debug) In[10]:=",
 CellID->207249874,ExpressionUUID->"5eba2f5c-6760-47e3-85ba-e7bf3a071ac0"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`i$$ = 6, Typeset`show$$ = True, 
    Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
    Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
    "\"untitled\"", Typeset`specs$$ = {{
      Hold[$CellContext`i$$], 1, 8, 1}}, Typeset`size$$ = {
    468., {197., 201.}}, Typeset`update$$ = 0, Typeset`initDone$$, 
    Typeset`skipInitDone$$ = False, $CellContext`i$9439$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, "Variables" :> {$CellContext`i$$ = 1}, 
      "ControllerVariables" :> {
        Hold[$CellContext`i$$, $CellContext`i$9439$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> 
      Module[{$CellContext`\[Rho]$, $CellContext`QS$, $CellContext`SIGMA$, \
$CellContext`U$, $CellContext`dU$, $CellContext`ddU$}, $CellContext`\[Rho]$ = 
         N[1 - 1/10^$CellContext`i$$]; $CellContext`SIGMA$ = {{
           1, $CellContext`\[Rho]$}, {$CellContext`\[Rho]$, 
            1}}; $CellContext`U$[
           Pattern[$CellContext`x$, 
            Blank[]], 
           Pattern[$CellContext`y$, 
            Blank[]]] = (1/2) Simplify[
            Dot[{$CellContext`x$, $CellContext`y$}, 
             
             LinearSolve[$CellContext`SIGMA$, {$CellContext`x$, \
$CellContext`y$}]]]; $CellContext`dU$[
           Pattern[$CellContext`x$, 
            Blank[]], 
           Pattern[$CellContext`y$, 
            Blank[]]] = $CellContext`GradientG[
           $CellContext`U$[$CellContext`x$, $CellContext`y$], \
{$CellContext`x$, $CellContext`y$}]; $CellContext`ddU$[
           Pattern[$CellContext`x$, 
            Blank[]], 
           Pattern[$CellContext`y$, 
            Blank[]]] = $CellContext`HessianH[
           $CellContext`U$[$CellContext`x$, $CellContext`y$], \
{$CellContext`x$, $CellContext`y$}]; $CellContext`QS$ = \
$CellContext`hmc[$CellContext`U$, $CellContext`dU$, $CellContext`ddU$, 2, 
           1000, 2000, True, True]; ListPlot[{$CellContext`QS$, 
           Dot[$CellContext`QS$, 
            MatrixPower[$CellContext`SIGMA$, -0.5]]}, PlotStyle -> Opacity[1],
           PlotLabel -> $CellContext`SIGMA$, 
          PlotLegends -> {"Samples", "Transformed"}, AspectRatio -> 1]], 
      "Specifications" :> {{$CellContext`i$$, 1, 8, 1}}, "Options" :> {}, 
      "DefaultOptions" :> {ControllerLinking -> True}],
     ImageSizeCache->{513., {241., 246.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    Initialization:>({$CellContext`\[Rho] = 
       0.9, $CellContext`QS = CompressedData["
1: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
tj2y3/K8ObYl+I09AF6w+hM=
        
        "], $CellContext`SIGMA = {{1, 0.9}, {0.9, 1}}, $CellContext`U[
         Pattern[$CellContext`x, 
          Blank[]], 
         Pattern[$CellContext`y, 
          Blank[]]] = (
         5.263157894736843 $CellContext`x^2 - (
          9.473684210526319 $CellContext`x) $CellContext`y + 
         5.263157894736844 $CellContext`y^2)/2, $CellContext`dU[
         Pattern[$CellContext`x, 
          Blank[]], 
         Pattern[$CellContext`y, 
          Blank[]]] = {(10.526315789473687` $CellContext`x - 
          9.473684210526319 $CellContext`y)/
         2, ((-9.473684210526319) $CellContext`x + 
          10.526315789473689` $CellContext`y)/2}, $CellContext`ddU[
         Pattern[$CellContext`x, 
          Blank[]], 
         Pattern[$CellContext`y, 
          Blank[]]] = {{
        5.263157894736843, -4.736842105263159}, {-4.736842105263159, 
        5.263157894736844}}, $CellContext`GradientG[
         Pattern[$CellContext`f, 
          Blank[]], 
         PatternTest[
          Pattern[$CellContext`x, 
           Blank[List]], VectorQ]] := 
       D[$CellContext`f, {$CellContext`x, 1}], $CellContext`HessianH[
         Pattern[$CellContext`f, 
          Blank[]], 
         PatternTest[
          Pattern[$CellContext`x, 
           Blank[List]], VectorQ]] := 
       D[$CellContext`f, {$CellContext`x, 2}], $CellContext`hmc[
         Pattern[$CellContext`U, 
          Blank[]], 
         Pattern[$CellContext`dU, 
          Blank[]], 
         Pattern[$CellContext`ddU, 
          Blank[]], 
         Pattern[$CellContext`Dim, 
          Blank[]], 
         Pattern[$CellContext`BURNIN, 
          Blank[]], 
         Pattern[$CellContext`EPISODE, 
          Blank[]], 
         Pattern[$CellContext`vanilla0, 
          Blank[]], 
         Pattern[$CellContext`switch, 
          Blank[]]] := 
       Module[{$CellContext`CHAINS = 5, $CellContext`STEPS = 
          5, $CellContext`qAll, $CellContext`pAll, $CellContext`Utotal, \
$CellContext`Ktotal, $CellContext`Htotal, $CellContext`s, $CellContext`S, \
$CellContext`AS, $CellContext`ES, $CellContext`KtotalNew, $CellContext`dt, \
$CellContext`p, $CellContext`q0, $CellContext`UE, $CellContext`\[Alpha], \
$CellContext`q, $CellContext`j, $CellContext`Htotal1, $CellContext`Htotal2, \
$CellContext`i, $CellContext`ND = NormalDistribution[0, 1], $CellContext`UD = 
          UniformDistribution[], $CellContext`QS = {}, $CellContext`vanilla = \
$CellContext`vanilla0, $CellContext`dt1 = 1.*^-9, $CellContext`dt2 = 
          0.0001, $CellContext`ACS = {}}, $CellContext`pAll = 
          RandomVariate[$CellContext`ND, {$CellContext`CHAINS, \
$CellContext`Dim}]; $CellContext`qAll = 
          RandomVariate[$CellContext`ND, {$CellContext`CHAINS, \
$CellContext`Dim}]; $CellContext`Utotal = Sum[
            Apply[$CellContext`U, 
             Part[$CellContext`qAll, $CellContext`i]], {$CellContext`i, 
             1, $CellContext`CHAINS}]; $CellContext`Htotal1 = \
$CellContext`Utotal; $CellContext`Htotal2 = $CellContext`Utotal; 
         For[$CellContext`j = 1, $CellContext`j <= $CellContext`EPISODE, 
           
           Increment[$CellContext`j], $CellContext`pAll = 
            RandomVariate[$CellContext`ND, {$CellContext`CHAINS, \
$CellContext`Dim}]; $CellContext`KtotalNew = Sum[If[$CellContext`vanilla, 
                Dot[
                 Part[$CellContext`pAll, $CellContext`i], 
                 Part[$CellContext`pAll, $CellContext`i]], 
                Dot[
                 Part[$CellContext`pAll, $CellContext`i], 
                 LinearSolve[
                  Apply[$CellContext`ddU, 
                   Part[$CellContext`qAll, $CellContext`i]], 
                  Part[$CellContext`pAll, $CellContext`i]]]]/
              2, {$CellContext`i, 
               1, $CellContext`CHAINS}]; $CellContext`Utotal = Sum[
              Apply[$CellContext`U, 
               Part[$CellContext`qAll, $CellContext`i]], {$CellContext`i, 
               1, $CellContext`CHAINS}]; $CellContext`Htotal = 
            If[$CellContext`vanilla, $CellContext`Htotal1, \
$CellContext`Htotal2]; $CellContext`dt = 
            If[$CellContext`vanilla, $CellContext`dt1, $CellContext`dt2]; \
$CellContext`Ktotal = $CellContext`Htotal - $CellContext`Utotal; \
$CellContext`pAll = $CellContext`pAll Sqrt[
               
               Abs[$CellContext`Ktotal/$CellContext`KtotalNew]]; \
$CellContext`ES = {}; $CellContext`AS = {}; 
           For[$CellContext`i = 1, $CellContext`i <= $CellContext`CHAINS, 
             
             Increment[$CellContext`i], $CellContext`p = 
              Part[$CellContext`pAll, $CellContext`i]; $CellContext`q = 
              Part[$CellContext`qAll, $CellContext`i]; $CellContext`UE = {
                
                Apply[$CellContext`U, $CellContext`q]}; $CellContext`q0 = \
$CellContext`q; 
             For[$CellContext`s = 1; 
               Null, $CellContext`s <= $CellContext`STEPS, 
               
               Increment[$CellContext`s], $CellContext`p = $CellContext`p - \
$CellContext`dt 
                 Apply[$CellContext`dU, $CellContext`q]; $CellContext`q = \
$CellContext`q + $CellContext`dt If[$CellContext`vanilla, $CellContext`p, 
                    LinearSolve[
                    
                    Apply[$CellContext`ddU, $CellContext`q], $CellContext`p]]; \
$CellContext`UE = Append[$CellContext`UE, 
                  Apply[$CellContext`U, $CellContext`q]]]; $CellContext`ES = 
              Append[$CellContext`ES, $CellContext`UE]; $CellContext`\[Alpha] = 
              Exp[
                Clip[
                Apply[$CellContext`U, $CellContext`q0] - 
                 Apply[$CellContext`U, $CellContext`q], {-20, 
                 0}]]; $CellContext`AS = Append[$CellContext`AS, 
                N[$CellContext`\[Alpha]]]; 
             If[$CellContext`\[Alpha] < 
               RandomVariate[$CellContext`UD], $CellContext`q = \
$CellContext`q0]; Part[$CellContext`qAll, $CellContext`i] = $CellContext`q; 
             If[$CellContext`j > $CellContext`BURNIN, $CellContext`QS = 
               Append[$CellContext`QS, $CellContext`q]]]; $CellContext`s = 
            Union[
              Flatten[
               Table[
                Ordering[
                 Part[$CellContext`ES, $CellContext`i], 1], {$CellContext`i, 
                 1, $CellContext`CHAINS}]]]; $CellContext`S = Union[
              Flatten[
               Table[
                Ordering[
                 Part[$CellContext`ES, $CellContext`i], -1], {$CellContext`i, 
                 1, $CellContext`CHAINS}]]]; 
           If[$CellContext`j < $CellContext`BURNIN, If[
               Or[
                
                And[$CellContext`s == {
                  1, $CellContext`STEPS + 1}, $CellContext`S == {
                  1, $CellContext`STEPS + 1}], 
                
                And[$CellContext`s == {$CellContext`STEPS + 
                   1}, $CellContext`S == {
                  1}]], $CellContext`dt = $CellContext`dt 1.1]; If[
               
               Or[$CellContext`s == {
                 1}, $CellContext`S == {$CellContext`STEPS + 
                  1}], $CellContext`dt = $CellContext`dt/1.1]; If[
               And[$CellContext`Ktotal > 0, $CellContext`KtotalNew > 0], 
               If[
                
                And[$CellContext`Utotal < 
                 0, $CellContext`Htotal > $CellContext`Utotal/
                  100], $CellContext`Htotal = $CellContext`Utotal/100, 
                If[
                 
                 And[$CellContext`Utotal > 0, $CellContext`Htotal > 
                  100 $CellContext`Utotal], $CellContext`Htotal = 
                 100 $CellContext`Utotal, 
                 If[Mean[$CellContext`AS] > 
                   0.9, $CellContext`Ktotal = $CellContext`Ktotal 1.1, 
                   If[
                   Mean[$CellContext`AS] < 
                    0.1, $CellContext`Ktotal = $CellContext`Ktotal/
                    1.1]]; $CellContext`Htotal = $CellContext`Ktotal + \
$CellContext`Utotal]]]; 
             If[$CellContext`vanilla, $CellContext`Htotal1 = \
$CellContext`Htotal; $CellContext`dt1 = $CellContext`dt, $CellContext`Htotal2 = \
$CellContext`Htotal; $CellContext`dt2 = $CellContext`dt]]; 
           If[$CellContext`switch, $CellContext`vanilla = 
             Not[$CellContext`vanilla]]]; $CellContext`QS]}; 
     Typeset`initDone$$ = True),
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output",
 CellChangeTimes->{3.817665256380991*^9, 3.817665344218412*^9, 
  3.817698848638335*^9, 3.8176989759101067`*^9, 3.8176990240059977`*^9},
 CellLabel->"(Debug) Out[10]=",
 CellID->1913502953,ExpressionUUID->"09e5c716-b11c-404c-9ee2-837c063d14fa"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["", "ManipulateCaptionSection",ExpressionUUID->"343ea5f6-a1e2-433e-a23a-ef37af0b05bb"],

Cell["\<\
Samples, the transformed samples using the covariance matrix, and the \
covariance matrix\
\>", "ManipulateCaption",
 CellChangeTimes->{{3.817699278669183*^9, 
  3.8176993250457697`*^9}},ExpressionUUID->"62c4c770-c515-46db-8779-\
e8362edab391"]
}, Open  ]],

Cell[CellGroupData[{

Cell["", "ThumbnailSection",ExpressionUUID->"8212c40d-46ef-4ecf-8636-6737412e60f3"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`i$$ = 5, Typeset`show$$ = True, 
    Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
    Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
    "\"untitled\"", Typeset`specs$$ = {{
      Hold[$CellContext`i$$], 1, 8, 1}}, Typeset`size$$ = {
    468., {193., 197.}}, Typeset`update$$ = 0, Typeset`initDone$$, 
    Typeset`skipInitDone$$ = False, $CellContext`i$9439$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, "Variables" :> {$CellContext`i$$ = 1}, 
      "ControllerVariables" :> {
        Hold[$CellContext`i$$, $CellContext`i$9439$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> 
      Module[{$CellContext`\[Rho]$, $CellContext`QS$, $CellContext`SIGMA$, \
$CellContext`U$, $CellContext`dU$, $CellContext`ddU$}, $CellContext`\[Rho]$ = 
         N[1 - 1/10^$CellContext`i$$]; $CellContext`SIGMA$ = {{
           1, $CellContext`\[Rho]$}, {$CellContext`\[Rho]$, 
            1}}; $CellContext`U$[
           Pattern[$CellContext`x$, 
            Blank[]], 
           Pattern[$CellContext`y$, 
            Blank[]]] = (1/2) Simplify[
            Dot[{$CellContext`x$, $CellContext`y$}, 
             
             LinearSolve[$CellContext`SIGMA$, {$CellContext`x$, \
$CellContext`y$}]]]; $CellContext`dU$[
           Pattern[$CellContext`x$, 
            Blank[]], 
           Pattern[$CellContext`y$, 
            Blank[]]] = $CellContext`GradientG[
           $CellContext`U$[$CellContext`x$, $CellContext`y$], \
{$CellContext`x$, $CellContext`y$}]; $CellContext`ddU$[
           Pattern[$CellContext`x$, 
            Blank[]], 
           Pattern[$CellContext`y$, 
            Blank[]]] = $CellContext`HessianH[
           $CellContext`U$[$CellContext`x$, $CellContext`y$], \
{$CellContext`x$, $CellContext`y$}]; $CellContext`QS$ = \
$CellContext`hmc[$CellContext`U$, $CellContext`dU$, $CellContext`ddU$, 2, 
           1000, 2000, True, True]; ListPlot[{$CellContext`QS$, 
           Dot[$CellContext`QS$, 
            MatrixPower[$CellContext`SIGMA$, -0.5]]}, PlotStyle -> Opacity[1],
           PlotLabel -> $CellContext`SIGMA$, 
          PlotLegends -> {"Samples", "Transformed"}, AspectRatio -> 1]], 
      "Specifications" :> {{$CellContext`i$$, 1, 8, 1}}, "Options" :> {}, 
      "DefaultOptions" :> {ControllerLinking -> True}],
     ImageSizeCache->{513., {237., 242.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    Initialization:>({$CellContext`\[Rho] = 
       0.9, $CellContext`QS = CompressedData["
1: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
tj2y3/K8ObYl+I09AF6w+hM=
        
        "], $CellContext`SIGMA = {{1, 0.9}, {0.9, 1}}, $CellContext`U[
         Pattern[$CellContext`x, 
          Blank[]], 
         Pattern[$CellContext`y, 
          Blank[]]] = (
         5.263157894736843 $CellContext`x^2 - (
          9.473684210526319 $CellContext`x) $CellContext`y + 
         5.263157894736844 $CellContext`y^2)/2, $CellContext`dU[
         Pattern[$CellContext`x, 
          Blank[]], 
         Pattern[$CellContext`y, 
          Blank[]]] = {(10.526315789473687` $CellContext`x - 
          9.473684210526319 $CellContext`y)/
         2, ((-9.473684210526319) $CellContext`x + 
          10.526315789473689` $CellContext`y)/2}, $CellContext`ddU[
         Pattern[$CellContext`x, 
          Blank[]], 
         Pattern[$CellContext`y, 
          Blank[]]] = {{
        5.263157894736843, -4.736842105263159}, {-4.736842105263159, 
        5.263157894736844}}, $CellContext`GradientG[
         Pattern[$CellContext`f, 
          Blank[]], 
         PatternTest[
          Pattern[$CellContext`x, 
           Blank[List]], VectorQ]] := 
       D[$CellContext`f, {$CellContext`x, 1}], $CellContext`HessianH[
         Pattern[$CellContext`f, 
          Blank[]], 
         PatternTest[
          Pattern[$CellContext`x, 
           Blank[List]], VectorQ]] := 
       D[$CellContext`f, {$CellContext`x, 2}], $CellContext`hmc[
         Pattern[$CellContext`U, 
          Blank[]], 
         Pattern[$CellContext`dU, 
          Blank[]], 
         Pattern[$CellContext`ddU, 
          Blank[]], 
         Pattern[$CellContext`Dim, 
          Blank[]], 
         Pattern[$CellContext`BURNIN, 
          Blank[]], 
         Pattern[$CellContext`EPISODE, 
          Blank[]], 
         Pattern[$CellContext`vanilla0, 
          Blank[]], 
         Pattern[$CellContext`switch, 
          Blank[]]] := 
       Module[{$CellContext`CHAINS = 5, $CellContext`STEPS = 
          5, $CellContext`qAll, $CellContext`pAll, $CellContext`Utotal, \
$CellContext`Ktotal, $CellContext`Htotal, $CellContext`s, $CellContext`S, \
$CellContext`AS, $CellContext`ES, $CellContext`KtotalNew, $CellContext`dt, \
$CellContext`p, $CellContext`q0, $CellContext`UE, $CellContext`\[Alpha], \
$CellContext`q, $CellContext`j, $CellContext`Htotal1, $CellContext`Htotal2, \
$CellContext`i, $CellContext`ND = NormalDistribution[0, 1], $CellContext`UD = 
          UniformDistribution[], $CellContext`QS = {}, $CellContext`vanilla = \
$CellContext`vanilla0, $CellContext`dt1 = 1.*^-9, $CellContext`dt2 = 
          0.0001, $CellContext`ACS = {}}, $CellContext`pAll = 
          RandomVariate[$CellContext`ND, {$CellContext`CHAINS, \
$CellContext`Dim}]; $CellContext`qAll = 
          RandomVariate[$CellContext`ND, {$CellContext`CHAINS, \
$CellContext`Dim}]; $CellContext`Utotal = Sum[
            Apply[$CellContext`U, 
             Part[$CellContext`qAll, $CellContext`i]], {$CellContext`i, 
             1, $CellContext`CHAINS}]; $CellContext`Htotal1 = \
$CellContext`Utotal; $CellContext`Htotal2 = $CellContext`Utotal; 
         For[$CellContext`j = 1, $CellContext`j <= $CellContext`EPISODE, 
           
           Increment[$CellContext`j], $CellContext`pAll = 
            RandomVariate[$CellContext`ND, {$CellContext`CHAINS, \
$CellContext`Dim}]; $CellContext`KtotalNew = Sum[If[$CellContext`vanilla, 
                Dot[
                 Part[$CellContext`pAll, $CellContext`i], 
                 Part[$CellContext`pAll, $CellContext`i]], 
                Dot[
                 Part[$CellContext`pAll, $CellContext`i], 
                 LinearSolve[
                  Apply[$CellContext`ddU, 
                   Part[$CellContext`qAll, $CellContext`i]], 
                  Part[$CellContext`pAll, $CellContext`i]]]]/
              2, {$CellContext`i, 
               1, $CellContext`CHAINS}]; $CellContext`Utotal = Sum[
              Apply[$CellContext`U, 
               Part[$CellContext`qAll, $CellContext`i]], {$CellContext`i, 
               1, $CellContext`CHAINS}]; $CellContext`Htotal = 
            If[$CellContext`vanilla, $CellContext`Htotal1, \
$CellContext`Htotal2]; $CellContext`dt = 
            If[$CellContext`vanilla, $CellContext`dt1, $CellContext`dt2]; \
$CellContext`Ktotal = $CellContext`Htotal - $CellContext`Utotal; \
$CellContext`pAll = $CellContext`pAll Sqrt[
               
               Abs[$CellContext`Ktotal/$CellContext`KtotalNew]]; \
$CellContext`ES = {}; $CellContext`AS = {}; 
           For[$CellContext`i = 1, $CellContext`i <= $CellContext`CHAINS, 
             
             Increment[$CellContext`i], $CellContext`p = 
              Part[$CellContext`pAll, $CellContext`i]; $CellContext`q = 
              Part[$CellContext`qAll, $CellContext`i]; $CellContext`UE = {
                
                Apply[$CellContext`U, $CellContext`q]}; $CellContext`q0 = \
$CellContext`q; 
             For[$CellContext`s = 1; 
               Null, $CellContext`s <= $CellContext`STEPS, 
               
               Increment[$CellContext`s], $CellContext`p = $CellContext`p - \
$CellContext`dt 
                 Apply[$CellContext`dU, $CellContext`q]; $CellContext`q = \
$CellContext`q + $CellContext`dt If[$CellContext`vanilla, $CellContext`p, 
                    LinearSolve[
                    
                    Apply[$CellContext`ddU, $CellContext`q], $CellContext`p]]; \
$CellContext`UE = Append[$CellContext`UE, 
                  Apply[$CellContext`U, $CellContext`q]]]; $CellContext`ES = 
              Append[$CellContext`ES, $CellContext`UE]; $CellContext`\[Alpha] = 
              Exp[
                Clip[
                Apply[$CellContext`U, $CellContext`q0] - 
                 Apply[$CellContext`U, $CellContext`q], {-20, 
                 0}]]; $CellContext`AS = Append[$CellContext`AS, 
                N[$CellContext`\[Alpha]]]; 
             If[$CellContext`\[Alpha] < 
               RandomVariate[$CellContext`UD], $CellContext`q = \
$CellContext`q0]; Part[$CellContext`qAll, $CellContext`i] = $CellContext`q; 
             If[$CellContext`j > $CellContext`BURNIN, $CellContext`QS = 
               Append[$CellContext`QS, $CellContext`q]]]; $CellContext`s = 
            Union[
              Flatten[
               Table[
                Ordering[
                 Part[$CellContext`ES, $CellContext`i], 1], {$CellContext`i, 
                 1, $CellContext`CHAINS}]]]; $CellContext`S = Union[
              Flatten[
               Table[
                Ordering[
                 Part[$CellContext`ES, $CellContext`i], -1], {$CellContext`i, 
                 1, $CellContext`CHAINS}]]]; 
           If[$CellContext`j < $CellContext`BURNIN, If[
               Or[
                
                And[$CellContext`s == {
                  1, $CellContext`STEPS + 1}, $CellContext`S == {
                  1, $CellContext`STEPS + 1}], 
                
                And[$CellContext`s == {$CellContext`STEPS + 
                   1}, $CellContext`S == {
                  1}]], $CellContext`dt = $CellContext`dt 1.1]; If[
               
               Or[$CellContext`s == {
                 1}, $CellContext`S == {$CellContext`STEPS + 
                  1}], $CellContext`dt = $CellContext`dt/1.1]; If[
               And[$CellContext`Ktotal > 0, $CellContext`KtotalNew > 0], 
               If[
                
                And[$CellContext`Utotal < 
                 0, $CellContext`Htotal > $CellContext`Utotal/
                  100], $CellContext`Htotal = $CellContext`Utotal/100, 
                If[
                 
                 And[$CellContext`Utotal > 0, $CellContext`Htotal > 
                  100 $CellContext`Utotal], $CellContext`Htotal = 
                 100 $CellContext`Utotal, 
                 If[Mean[$CellContext`AS] > 
                   0.9, $CellContext`Ktotal = $CellContext`Ktotal 1.1, 
                   If[
                   Mean[$CellContext`AS] < 
                    0.1, $CellContext`Ktotal = $CellContext`Ktotal/
                    1.1]]; $CellContext`Htotal = $CellContext`Ktotal + \
$CellContext`Utotal]]]; 
             If[$CellContext`vanilla, $CellContext`Htotal1 = \
$CellContext`Htotal; $CellContext`dt1 = $CellContext`dt, $CellContext`Htotal2 = \
$CellContext`Htotal; $CellContext`dt2 = $CellContext`dt]]; 
           If[$CellContext`switch, $CellContext`vanilla = 
             Not[$CellContext`vanilla]]]; $CellContext`QS]}; 
     Typeset`initDone$$ = True),
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output",
 CellChangeTimes->{3.817665256380991*^9, 3.817665344218412*^9, 
  3.817698848638335*^9, 3.8176989759101067`*^9, 3.8176990240059977`*^9},
 CellLabel->"(Debug) Out[10]=",
 CellID->299801647,ExpressionUUID->"41325725-c29d-4a4a-94c2-3b3f0bb13b9d"]
}, Open  ]],

Cell[CellGroupData[{

Cell["", "SnapshotsSection",ExpressionUUID->"c41a30ce-d578-468b-bdd1-e5c4cdcf666c"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`i$$ = 1, Typeset`show$$ = True, 
    Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
    Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
    "\"untitled\"", Typeset`specs$$ = {{
      Hold[$CellContext`i$$], 1, 8, 1}}, Typeset`size$$ = {
    468., {195., 200.}}, Typeset`update$$ = 0, Typeset`initDone$$, 
    Typeset`skipInitDone$$ = False, $CellContext`i$9439$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, "Variables" :> {$CellContext`i$$ = 1}, 
      "ControllerVariables" :> {
        Hold[$CellContext`i$$, $CellContext`i$9439$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> 
      Module[{$CellContext`\[Rho]$, $CellContext`QS$, $CellContext`SIGMA$, \
$CellContext`U$, $CellContext`dU$, $CellContext`ddU$}, $CellContext`\[Rho]$ = 
         N[1 - 1/10^$CellContext`i$$]; $CellContext`SIGMA$ = {{
           1, $CellContext`\[Rho]$}, {$CellContext`\[Rho]$, 
            1}}; $CellContext`U$[
           Pattern[$CellContext`x$, 
            Blank[]], 
           Pattern[$CellContext`y$, 
            Blank[]]] = (1/2) Simplify[
            Dot[{$CellContext`x$, $CellContext`y$}, 
             
             LinearSolve[$CellContext`SIGMA$, {$CellContext`x$, \
$CellContext`y$}]]]; $CellContext`dU$[
           Pattern[$CellContext`x$, 
            Blank[]], 
           Pattern[$CellContext`y$, 
            Blank[]]] = $CellContext`GradientG[
           $CellContext`U$[$CellContext`x$, $CellContext`y$], \
{$CellContext`x$, $CellContext`y$}]; $CellContext`ddU$[
           Pattern[$CellContext`x$, 
            Blank[]], 
           Pattern[$CellContext`y$, 
            Blank[]]] = $CellContext`HessianH[
           $CellContext`U$[$CellContext`x$, $CellContext`y$], \
{$CellContext`x$, $CellContext`y$}]; $CellContext`QS$ = \
$CellContext`hmc[$CellContext`U$, $CellContext`dU$, $CellContext`ddU$, 2, 
           1000, 2000, True, True]; ListPlot[{$CellContext`QS$, 
           Dot[$CellContext`QS$, 
            MatrixPower[$CellContext`SIGMA$, -0.5]]}, PlotStyle -> Opacity[1],
           PlotLabel -> $CellContext`SIGMA$, 
          PlotLegends -> {"Samples", "Transformed"}, AspectRatio -> 1]], 
      "Specifications" :> {{$CellContext`i$$, 1, 8, 1}}, "Options" :> {}, 
      "DefaultOptions" :> {ControllerLinking -> True}],
     ImageSizeCache->{513., {239., 244.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    Initialization:>({$CellContext`\[Rho] = 
       0.9, $CellContext`QS = CompressedData["
1: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
tj2y3/K8ObYl+I09AF6w+hM=
        
        "], $CellContext`SIGMA = {{1, 0.9}, {0.9, 1}}, $CellContext`U[
         Pattern[$CellContext`x, 
          Blank[]], 
         Pattern[$CellContext`y, 
          Blank[]]] = (
         5.263157894736843 $CellContext`x^2 - (
          9.473684210526319 $CellContext`x) $CellContext`y + 
         5.263157894736844 $CellContext`y^2)/2, $CellContext`dU[
         Pattern[$CellContext`x, 
          Blank[]], 
         Pattern[$CellContext`y, 
          Blank[]]] = {(10.526315789473687` $CellContext`x - 
          9.473684210526319 $CellContext`y)/
         2, ((-9.473684210526319) $CellContext`x + 
          10.526315789473689` $CellContext`y)/2}, $CellContext`ddU[
         Pattern[$CellContext`x, 
          Blank[]], 
         Pattern[$CellContext`y, 
          Blank[]]] = {{
        5.263157894736843, -4.736842105263159}, {-4.736842105263159, 
        5.263157894736844}}, $CellContext`GradientG[
         Pattern[$CellContext`f, 
          Blank[]], 
         PatternTest[
          Pattern[$CellContext`x, 
           Blank[List]], VectorQ]] := 
       D[$CellContext`f, {$CellContext`x, 1}], $CellContext`HessianH[
         Pattern[$CellContext`f, 
          Blank[]], 
         PatternTest[
          Pattern[$CellContext`x, 
           Blank[List]], VectorQ]] := 
       D[$CellContext`f, {$CellContext`x, 2}], $CellContext`hmc[
         Pattern[$CellContext`U, 
          Blank[]], 
         Pattern[$CellContext`dU, 
          Blank[]], 
         Pattern[$CellContext`ddU, 
          Blank[]], 
         Pattern[$CellContext`Dim, 
          Blank[]], 
         Pattern[$CellContext`BURNIN, 
          Blank[]], 
         Pattern[$CellContext`EPISODE, 
          Blank[]], 
         Pattern[$CellContext`vanilla0, 
          Blank[]], 
         Pattern[$CellContext`switch, 
          Blank[]]] := 
       Module[{$CellContext`CHAINS = 5, $CellContext`STEPS = 
          5, $CellContext`qAll, $CellContext`pAll, $CellContext`Utotal, \
$CellContext`Ktotal, $CellContext`Htotal, $CellContext`s, $CellContext`S, \
$CellContext`AS, $CellContext`ES, $CellContext`KtotalNew, $CellContext`dt, \
$CellContext`p, $CellContext`q0, $CellContext`UE, $CellContext`\[Alpha], \
$CellContext`q, $CellContext`j, $CellContext`Htotal1, $CellContext`Htotal2, \
$CellContext`i, $CellContext`ND = NormalDistribution[0, 1], $CellContext`UD = 
          UniformDistribution[], $CellContext`QS = {}, $CellContext`vanilla = \
$CellContext`vanilla0, $CellContext`dt1 = 1.*^-9, $CellContext`dt2 = 
          0.0001, $CellContext`ACS = {}}, $CellContext`pAll = 
          RandomVariate[$CellContext`ND, {$CellContext`CHAINS, \
$CellContext`Dim}]; $CellContext`qAll = 
          RandomVariate[$CellContext`ND, {$CellContext`CHAINS, \
$CellContext`Dim}]; $CellContext`Utotal = Sum[
            Apply[$CellContext`U, 
             Part[$CellContext`qAll, $CellContext`i]], {$CellContext`i, 
             1, $CellContext`CHAINS}]; $CellContext`Htotal1 = \
$CellContext`Utotal; $CellContext`Htotal2 = $CellContext`Utotal; 
         For[$CellContext`j = 1, $CellContext`j <= $CellContext`EPISODE, 
           
           Increment[$CellContext`j], $CellContext`pAll = 
            RandomVariate[$CellContext`ND, {$CellContext`CHAINS, \
$CellContext`Dim}]; $CellContext`KtotalNew = Sum[If[$CellContext`vanilla, 
                Dot[
                 Part[$CellContext`pAll, $CellContext`i], 
                 Part[$CellContext`pAll, $CellContext`i]], 
                Dot[
                 Part[$CellContext`pAll, $CellContext`i], 
                 LinearSolve[
                  Apply[$CellContext`ddU, 
                   Part[$CellContext`qAll, $CellContext`i]], 
                  Part[$CellContext`pAll, $CellContext`i]]]]/
              2, {$CellContext`i, 
               1, $CellContext`CHAINS}]; $CellContext`Utotal = Sum[
              Apply[$CellContext`U, 
               Part[$CellContext`qAll, $CellContext`i]], {$CellContext`i, 
               1, $CellContext`CHAINS}]; $CellContext`Htotal = 
            If[$CellContext`vanilla, $CellContext`Htotal1, \
$CellContext`Htotal2]; $CellContext`dt = 
            If[$CellContext`vanilla, $CellContext`dt1, $CellContext`dt2]; \
$CellContext`Ktotal = $CellContext`Htotal - $CellContext`Utotal; \
$CellContext`pAll = $CellContext`pAll Sqrt[
               
               Abs[$CellContext`Ktotal/$CellContext`KtotalNew]]; \
$CellContext`ES = {}; $CellContext`AS = {}; 
           For[$CellContext`i = 1, $CellContext`i <= $CellContext`CHAINS, 
             
             Increment[$CellContext`i], $CellContext`p = 
              Part[$CellContext`pAll, $CellContext`i]; $CellContext`q = 
              Part[$CellContext`qAll, $CellContext`i]; $CellContext`UE = {
                
                Apply[$CellContext`U, $CellContext`q]}; $CellContext`q0 = \
$CellContext`q; 
             For[$CellContext`s = 1; 
               Null, $CellContext`s <= $CellContext`STEPS, 
               
               Increment[$CellContext`s], $CellContext`p = $CellContext`p - \
$CellContext`dt 
                 Apply[$CellContext`dU, $CellContext`q]; $CellContext`q = \
$CellContext`q + $CellContext`dt If[$CellContext`vanilla, $CellContext`p, 
                    LinearSolve[
                    
                    Apply[$CellContext`ddU, $CellContext`q], $CellContext`p]]; \
$CellContext`UE = Append[$CellContext`UE, 
                  Apply[$CellContext`U, $CellContext`q]]]; $CellContext`ES = 
              Append[$CellContext`ES, $CellContext`UE]; $CellContext`\[Alpha] = 
              Exp[
                Clip[
                Apply[$CellContext`U, $CellContext`q0] - 
                 Apply[$CellContext`U, $CellContext`q], {-20, 
                 0}]]; $CellContext`AS = Append[$CellContext`AS, 
                N[$CellContext`\[Alpha]]]; 
             If[$CellContext`\[Alpha] < 
               RandomVariate[$CellContext`UD], $CellContext`q = \
$CellContext`q0]; Part[$CellContext`qAll, $CellContext`i] = $CellContext`q; 
             If[$CellContext`j > $CellContext`BURNIN, $CellContext`QS = 
               Append[$CellContext`QS, $CellContext`q]]]; $CellContext`s = 
            Union[
              Flatten[
               Table[
                Ordering[
                 Part[$CellContext`ES, $CellContext`i], 1], {$CellContext`i, 
                 1, $CellContext`CHAINS}]]]; $CellContext`S = Union[
              Flatten[
               Table[
                Ordering[
                 Part[$CellContext`ES, $CellContext`i], -1], {$CellContext`i, 
                 1, $CellContext`CHAINS}]]]; 
           If[$CellContext`j < $CellContext`BURNIN, If[
               Or[
                
                And[$CellContext`s == {
                  1, $CellContext`STEPS + 1}, $CellContext`S == {
                  1, $CellContext`STEPS + 1}], 
                
                And[$CellContext`s == {$CellContext`STEPS + 
                   1}, $CellContext`S == {
                  1}]], $CellContext`dt = $CellContext`dt 1.1]; If[
               
               Or[$CellContext`s == {
                 1}, $CellContext`S == {$CellContext`STEPS + 
                  1}], $CellContext`dt = $CellContext`dt/1.1]; If[
               And[$CellContext`Ktotal > 0, $CellContext`KtotalNew > 0], 
               If[
                
                And[$CellContext`Utotal < 
                 0, $CellContext`Htotal > $CellContext`Utotal/
                  100], $CellContext`Htotal = $CellContext`Utotal/100, 
                If[
                 
                 And[$CellContext`Utotal > 0, $CellContext`Htotal > 
                  100 $CellContext`Utotal], $CellContext`Htotal = 
                 100 $CellContext`Utotal, 
                 If[Mean[$CellContext`AS] > 
                   0.9, $CellContext`Ktotal = $CellContext`Ktotal 1.1, 
                   If[
                   Mean[$CellContext`AS] < 
                    0.1, $CellContext`Ktotal = $CellContext`Ktotal/
                    1.1]]; $CellContext`Htotal = $CellContext`Ktotal + \
$CellContext`Utotal]]]; 
             If[$CellContext`vanilla, $CellContext`Htotal1 = \
$CellContext`Htotal; $CellContext`dt1 = $CellContext`dt, $CellContext`Htotal2 = \
$CellContext`Htotal; $CellContext`dt2 = $CellContext`dt]]; 
           If[$CellContext`switch, $CellContext`vanilla = 
             Not[$CellContext`vanilla]]]; $CellContext`QS]}; 
     Typeset`initDone$$ = True),
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output",
 CellChangeTimes->{3.817665256380991*^9, 3.817665344218412*^9, 
  3.817698848638335*^9, 3.8176989759101067`*^9, 3.8176990240059977`*^9},
 CellID->316109030,ExpressionUUID->"d92329b3-1268-438c-85ac-aa59d3285fde"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`i$$ = 3, Typeset`show$$ = True, 
    Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
    Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
    "\"untitled\"", Typeset`specs$$ = {{
      Hold[$CellContext`i$$], 1, 8, 1}}, Typeset`size$$ = {
    468., {195., 200.}}, Typeset`update$$ = 0, Typeset`initDone$$, 
    Typeset`skipInitDone$$ = False, $CellContext`i$9439$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, "Variables" :> {$CellContext`i$$ = 1}, 
      "ControllerVariables" :> {
        Hold[$CellContext`i$$, $CellContext`i$9439$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> 
      Module[{$CellContext`\[Rho]$, $CellContext`QS$, $CellContext`SIGMA$, \
$CellContext`U$, $CellContext`dU$, $CellContext`ddU$}, $CellContext`\[Rho]$ = 
         N[1 - 1/10^$CellContext`i$$]; $CellContext`SIGMA$ = {{
           1, $CellContext`\[Rho]$}, {$CellContext`\[Rho]$, 
            1}}; $CellContext`U$[
           Pattern[$CellContext`x$, 
            Blank[]], 
           Pattern[$CellContext`y$, 
            Blank[]]] = (1/2) Simplify[
            Dot[{$CellContext`x$, $CellContext`y$}, 
             
             LinearSolve[$CellContext`SIGMA$, {$CellContext`x$, \
$CellContext`y$}]]]; $CellContext`dU$[
           Pattern[$CellContext`x$, 
            Blank[]], 
           Pattern[$CellContext`y$, 
            Blank[]]] = $CellContext`GradientG[
           $CellContext`U$[$CellContext`x$, $CellContext`y$], \
{$CellContext`x$, $CellContext`y$}]; $CellContext`ddU$[
           Pattern[$CellContext`x$, 
            Blank[]], 
           Pattern[$CellContext`y$, 
            Blank[]]] = $CellContext`HessianH[
           $CellContext`U$[$CellContext`x$, $CellContext`y$], \
{$CellContext`x$, $CellContext`y$}]; $CellContext`QS$ = \
$CellContext`hmc[$CellContext`U$, $CellContext`dU$, $CellContext`ddU$, 2, 
           1000, 2000, True, True]; ListPlot[{$CellContext`QS$, 
           Dot[$CellContext`QS$, 
            MatrixPower[$CellContext`SIGMA$, -0.5]]}, PlotStyle -> Opacity[1],
           PlotLabel -> $CellContext`SIGMA$, 
          PlotLegends -> {"Samples", "Transformed"}, AspectRatio -> 1]], 
      "Specifications" :> {{$CellContext`i$$, 1, 8, 1}}, "Options" :> {}, 
      "DefaultOptions" :> {ControllerLinking -> True}],
     ImageSizeCache->{513., {239., 244.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    Initialization:>({$CellContext`\[Rho] = 
       0.9, $CellContext`QS = CompressedData["
1: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
tj2y3/K8ObYl+I09AF6w+hM=
        
        "], $CellContext`SIGMA = {{1, 0.9}, {0.9, 1}}, $CellContext`U[
         Pattern[$CellContext`x, 
          Blank[]], 
         Pattern[$CellContext`y, 
          Blank[]]] = (
         5.263157894736843 $CellContext`x^2 - (
          9.473684210526319 $CellContext`x) $CellContext`y + 
         5.263157894736844 $CellContext`y^2)/2, $CellContext`dU[
         Pattern[$CellContext`x, 
          Blank[]], 
         Pattern[$CellContext`y, 
          Blank[]]] = {(10.526315789473687` $CellContext`x - 
          9.473684210526319 $CellContext`y)/
         2, ((-9.473684210526319) $CellContext`x + 
          10.526315789473689` $CellContext`y)/2}, $CellContext`ddU[
         Pattern[$CellContext`x, 
          Blank[]], 
         Pattern[$CellContext`y, 
          Blank[]]] = {{
        5.263157894736843, -4.736842105263159}, {-4.736842105263159, 
        5.263157894736844}}, $CellContext`GradientG[
         Pattern[$CellContext`f, 
          Blank[]], 
         PatternTest[
          Pattern[$CellContext`x, 
           Blank[List]], VectorQ]] := 
       D[$CellContext`f, {$CellContext`x, 1}], $CellContext`HessianH[
         Pattern[$CellContext`f, 
          Blank[]], 
         PatternTest[
          Pattern[$CellContext`x, 
           Blank[List]], VectorQ]] := 
       D[$CellContext`f, {$CellContext`x, 2}], $CellContext`hmc[
         Pattern[$CellContext`U, 
          Blank[]], 
         Pattern[$CellContext`dU, 
          Blank[]], 
         Pattern[$CellContext`ddU, 
          Blank[]], 
         Pattern[$CellContext`Dim, 
          Blank[]], 
         Pattern[$CellContext`BURNIN, 
          Blank[]], 
         Pattern[$CellContext`EPISODE, 
          Blank[]], 
         Pattern[$CellContext`vanilla0, 
          Blank[]], 
         Pattern[$CellContext`switch, 
          Blank[]]] := 
       Module[{$CellContext`CHAINS = 5, $CellContext`STEPS = 
          5, $CellContext`qAll, $CellContext`pAll, $CellContext`Utotal, \
$CellContext`Ktotal, $CellContext`Htotal, $CellContext`s, $CellContext`S, \
$CellContext`AS, $CellContext`ES, $CellContext`KtotalNew, $CellContext`dt, \
$CellContext`p, $CellContext`q0, $CellContext`UE, $CellContext`\[Alpha], \
$CellContext`q, $CellContext`j, $CellContext`Htotal1, $CellContext`Htotal2, \
$CellContext`i, $CellContext`ND = NormalDistribution[0, 1], $CellContext`UD = 
          UniformDistribution[], $CellContext`QS = {}, $CellContext`vanilla = \
$CellContext`vanilla0, $CellContext`dt1 = 1.*^-9, $CellContext`dt2 = 
          0.0001, $CellContext`ACS = {}}, $CellContext`pAll = 
          RandomVariate[$CellContext`ND, {$CellContext`CHAINS, \
$CellContext`Dim}]; $CellContext`qAll = 
          RandomVariate[$CellContext`ND, {$CellContext`CHAINS, \
$CellContext`Dim}]; $CellContext`Utotal = Sum[
            Apply[$CellContext`U, 
             Part[$CellContext`qAll, $CellContext`i]], {$CellContext`i, 
             1, $CellContext`CHAINS}]; $CellContext`Htotal1 = \
$CellContext`Utotal; $CellContext`Htotal2 = $CellContext`Utotal; 
         For[$CellContext`j = 1, $CellContext`j <= $CellContext`EPISODE, 
           
           Increment[$CellContext`j], $CellContext`pAll = 
            RandomVariate[$CellContext`ND, {$CellContext`CHAINS, \
$CellContext`Dim}]; $CellContext`KtotalNew = Sum[If[$CellContext`vanilla, 
                Dot[
                 Part[$CellContext`pAll, $CellContext`i], 
                 Part[$CellContext`pAll, $CellContext`i]], 
                Dot[
                 Part[$CellContext`pAll, $CellContext`i], 
                 LinearSolve[
                  Apply[$CellContext`ddU, 
                   Part[$CellContext`qAll, $CellContext`i]], 
                  Part[$CellContext`pAll, $CellContext`i]]]]/
              2, {$CellContext`i, 
               1, $CellContext`CHAINS}]; $CellContext`Utotal = Sum[
              Apply[$CellContext`U, 
               Part[$CellContext`qAll, $CellContext`i]], {$CellContext`i, 
               1, $CellContext`CHAINS}]; $CellContext`Htotal = 
            If[$CellContext`vanilla, $CellContext`Htotal1, \
$CellContext`Htotal2]; $CellContext`dt = 
            If[$CellContext`vanilla, $CellContext`dt1, $CellContext`dt2]; \
$CellContext`Ktotal = $CellContext`Htotal - $CellContext`Utotal; \
$CellContext`pAll = $CellContext`pAll Sqrt[
               
               Abs[$CellContext`Ktotal/$CellContext`KtotalNew]]; \
$CellContext`ES = {}; $CellContext`AS = {}; 
           For[$CellContext`i = 1, $CellContext`i <= $CellContext`CHAINS, 
             
             Increment[$CellContext`i], $CellContext`p = 
              Part[$CellContext`pAll, $CellContext`i]; $CellContext`q = 
              Part[$CellContext`qAll, $CellContext`i]; $CellContext`UE = {
                
                Apply[$CellContext`U, $CellContext`q]}; $CellContext`q0 = \
$CellContext`q; 
             For[$CellContext`s = 1; 
               Null, $CellContext`s <= $CellContext`STEPS, 
               
               Increment[$CellContext`s], $CellContext`p = $CellContext`p - \
$CellContext`dt 
                 Apply[$CellContext`dU, $CellContext`q]; $CellContext`q = \
$CellContext`q + $CellContext`dt If[$CellContext`vanilla, $CellContext`p, 
                    LinearSolve[
                    
                    Apply[$CellContext`ddU, $CellContext`q], $CellContext`p]]; \
$CellContext`UE = Append[$CellContext`UE, 
                  Apply[$CellContext`U, $CellContext`q]]]; $CellContext`ES = 
              Append[$CellContext`ES, $CellContext`UE]; $CellContext`\[Alpha] = 
              Exp[
                Clip[
                Apply[$CellContext`U, $CellContext`q0] - 
                 Apply[$CellContext`U, $CellContext`q], {-20, 
                 0}]]; $CellContext`AS = Append[$CellContext`AS, 
                N[$CellContext`\[Alpha]]]; 
             If[$CellContext`\[Alpha] < 
               RandomVariate[$CellContext`UD], $CellContext`q = \
$CellContext`q0]; Part[$CellContext`qAll, $CellContext`i] = $CellContext`q; 
             If[$CellContext`j > $CellContext`BURNIN, $CellContext`QS = 
               Append[$CellContext`QS, $CellContext`q]]]; $CellContext`s = 
            Union[
              Flatten[
               Table[
                Ordering[
                 Part[$CellContext`ES, $CellContext`i], 1], {$CellContext`i, 
                 1, $CellContext`CHAINS}]]]; $CellContext`S = Union[
              Flatten[
               Table[
                Ordering[
                 Part[$CellContext`ES, $CellContext`i], -1], {$CellContext`i, 
                 1, $CellContext`CHAINS}]]]; 
           If[$CellContext`j < $CellContext`BURNIN, If[
               Or[
                
                And[$CellContext`s == {
                  1, $CellContext`STEPS + 1}, $CellContext`S == {
                  1, $CellContext`STEPS + 1}], 
                
                And[$CellContext`s == {$CellContext`STEPS + 
                   1}, $CellContext`S == {
                  1}]], $CellContext`dt = $CellContext`dt 1.1]; If[
               
               Or[$CellContext`s == {
                 1}, $CellContext`S == {$CellContext`STEPS + 
                  1}], $CellContext`dt = $CellContext`dt/1.1]; If[
               And[$CellContext`Ktotal > 0, $CellContext`KtotalNew > 0], 
               If[
                
                And[$CellContext`Utotal < 
                 0, $CellContext`Htotal > $CellContext`Utotal/
                  100], $CellContext`Htotal = $CellContext`Utotal/100, 
                If[
                 
                 And[$CellContext`Utotal > 0, $CellContext`Htotal > 
                  100 $CellContext`Utotal], $CellContext`Htotal = 
                 100 $CellContext`Utotal, 
                 If[Mean[$CellContext`AS] > 
                   0.9, $CellContext`Ktotal = $CellContext`Ktotal 1.1, 
                   If[
                   Mean[$CellContext`AS] < 
                    0.1, $CellContext`Ktotal = $CellContext`Ktotal/
                    1.1]]; $CellContext`Htotal = $CellContext`Ktotal + \
$CellContext`Utotal]]]; 
             If[$CellContext`vanilla, $CellContext`Htotal1 = \
$CellContext`Htotal; $CellContext`dt1 = $CellContext`dt, $CellContext`Htotal2 = \
$CellContext`Htotal; $CellContext`dt2 = $CellContext`dt]]; 
           If[$CellContext`switch, $CellContext`vanilla = 
             Not[$CellContext`vanilla]]]; $CellContext`QS]}; 
     Typeset`initDone$$ = True),
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output",
 CellChangeTimes->{3.817665256380991*^9, 3.817665344218412*^9, 
  3.817698848638335*^9, 3.8176989759101067`*^9, 3.8176990240059977`*^9},
 CellID->1210265810,ExpressionUUID->"896a0515-f506-4626-a5d9-d3e37523c996"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`i$$ = 6, Typeset`show$$ = True, 
    Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
    Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
    "\"untitled\"", Typeset`specs$$ = {{
      Hold[$CellContext`i$$], 1, 8, 1}}, Typeset`size$$ = {
    468., {198., 202.}}, Typeset`update$$ = 0, Typeset`initDone$$, 
    Typeset`skipInitDone$$ = False, $CellContext`i$9439$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, "Variables" :> {$CellContext`i$$ = 1}, 
      "ControllerVariables" :> {
        Hold[$CellContext`i$$, $CellContext`i$9439$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> 
      Module[{$CellContext`\[Rho]$, $CellContext`QS$, $CellContext`SIGMA$, \
$CellContext`U$, $CellContext`dU$, $CellContext`ddU$}, $CellContext`\[Rho]$ = 
         N[1 - 1/10^$CellContext`i$$]; $CellContext`SIGMA$ = {{
           1, $CellContext`\[Rho]$}, {$CellContext`\[Rho]$, 
            1}}; $CellContext`U$[
           Pattern[$CellContext`x$, 
            Blank[]], 
           Pattern[$CellContext`y$, 
            Blank[]]] = (1/2) Simplify[
            Dot[{$CellContext`x$, $CellContext`y$}, 
             
             LinearSolve[$CellContext`SIGMA$, {$CellContext`x$, \
$CellContext`y$}]]]; $CellContext`dU$[
           Pattern[$CellContext`x$, 
            Blank[]], 
           Pattern[$CellContext`y$, 
            Blank[]]] = $CellContext`GradientG[
           $CellContext`U$[$CellContext`x$, $CellContext`y$], \
{$CellContext`x$, $CellContext`y$}]; $CellContext`ddU$[
           Pattern[$CellContext`x$, 
            Blank[]], 
           Pattern[$CellContext`y$, 
            Blank[]]] = $CellContext`HessianH[
           $CellContext`U$[$CellContext`x$, $CellContext`y$], \
{$CellContext`x$, $CellContext`y$}]; $CellContext`QS$ = \
$CellContext`hmc[$CellContext`U$, $CellContext`dU$, $CellContext`ddU$, 2, 
           1000, 2000, True, True]; ListPlot[{$CellContext`QS$, 
           Dot[$CellContext`QS$, 
            MatrixPower[$CellContext`SIGMA$, -0.5]]}, PlotStyle -> Opacity[1],
           PlotLabel -> $CellContext`SIGMA$, 
          PlotLegends -> {"Samples", "Transformed"}, AspectRatio -> 1]], 
      "Specifications" :> {{$CellContext`i$$, 1, 8, 1}}, "Options" :> {}, 
      "DefaultOptions" :> {ControllerLinking -> True}],
     ImageSizeCache->{513., {242., 247.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    Initialization:>({$CellContext`\[Rho] = 
       0.9, $CellContext`QS = CompressedData["
1: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
tj2y3/K8ObYl+I09AF6w+hM=
        
        "], $CellContext`SIGMA = {{1, 0.9}, {0.9, 1}}, $CellContext`U[
         Pattern[$CellContext`x, 
          Blank[]], 
         Pattern[$CellContext`y, 
          Blank[]]] = (
         5.263157894736843 $CellContext`x^2 - (
          9.473684210526319 $CellContext`x) $CellContext`y + 
         5.263157894736844 $CellContext`y^2)/2, $CellContext`dU[
         Pattern[$CellContext`x, 
          Blank[]], 
         Pattern[$CellContext`y, 
          Blank[]]] = {(10.526315789473687` $CellContext`x - 
          9.473684210526319 $CellContext`y)/
         2, ((-9.473684210526319) $CellContext`x + 
          10.526315789473689` $CellContext`y)/2}, $CellContext`ddU[
         Pattern[$CellContext`x, 
          Blank[]], 
         Pattern[$CellContext`y, 
          Blank[]]] = {{
        5.263157894736843, -4.736842105263159}, {-4.736842105263159, 
        5.263157894736844}}, $CellContext`GradientG[
         Pattern[$CellContext`f, 
          Blank[]], 
         PatternTest[
          Pattern[$CellContext`x, 
           Blank[List]], VectorQ]] := 
       D[$CellContext`f, {$CellContext`x, 1}], $CellContext`HessianH[
         Pattern[$CellContext`f, 
          Blank[]], 
         PatternTest[
          Pattern[$CellContext`x, 
           Blank[List]], VectorQ]] := 
       D[$CellContext`f, {$CellContext`x, 2}], $CellContext`hmc[
         Pattern[$CellContext`U, 
          Blank[]], 
         Pattern[$CellContext`dU, 
          Blank[]], 
         Pattern[$CellContext`ddU, 
          Blank[]], 
         Pattern[$CellContext`Dim, 
          Blank[]], 
         Pattern[$CellContext`BURNIN, 
          Blank[]], 
         Pattern[$CellContext`EPISODE, 
          Blank[]], 
         Pattern[$CellContext`vanilla0, 
          Blank[]], 
         Pattern[$CellContext`switch, 
          Blank[]]] := 
       Module[{$CellContext`CHAINS = 5, $CellContext`STEPS = 
          5, $CellContext`qAll, $CellContext`pAll, $CellContext`Utotal, \
$CellContext`Ktotal, $CellContext`Htotal, $CellContext`s, $CellContext`S, \
$CellContext`AS, $CellContext`ES, $CellContext`KtotalNew, $CellContext`dt, \
$CellContext`p, $CellContext`q0, $CellContext`UE, $CellContext`\[Alpha], \
$CellContext`q, $CellContext`j, $CellContext`Htotal1, $CellContext`Htotal2, \
$CellContext`i, $CellContext`ND = NormalDistribution[0, 1], $CellContext`UD = 
          UniformDistribution[], $CellContext`QS = {}, $CellContext`vanilla = \
$CellContext`vanilla0, $CellContext`dt1 = 1.*^-9, $CellContext`dt2 = 
          0.0001, $CellContext`ACS = {}}, $CellContext`pAll = 
          RandomVariate[$CellContext`ND, {$CellContext`CHAINS, \
$CellContext`Dim}]; $CellContext`qAll = 
          RandomVariate[$CellContext`ND, {$CellContext`CHAINS, \
$CellContext`Dim}]; $CellContext`Utotal = Sum[
            Apply[$CellContext`U, 
             Part[$CellContext`qAll, $CellContext`i]], {$CellContext`i, 
             1, $CellContext`CHAINS}]; $CellContext`Htotal1 = \
$CellContext`Utotal; $CellContext`Htotal2 = $CellContext`Utotal; 
         For[$CellContext`j = 1, $CellContext`j <= $CellContext`EPISODE, 
           
           Increment[$CellContext`j], $CellContext`pAll = 
            RandomVariate[$CellContext`ND, {$CellContext`CHAINS, \
$CellContext`Dim}]; $CellContext`KtotalNew = Sum[If[$CellContext`vanilla, 
                Dot[
                 Part[$CellContext`pAll, $CellContext`i], 
                 Part[$CellContext`pAll, $CellContext`i]], 
                Dot[
                 Part[$CellContext`pAll, $CellContext`i], 
                 LinearSolve[
                  Apply[$CellContext`ddU, 
                   Part[$CellContext`qAll, $CellContext`i]], 
                  Part[$CellContext`pAll, $CellContext`i]]]]/
              2, {$CellContext`i, 
               1, $CellContext`CHAINS}]; $CellContext`Utotal = Sum[
              Apply[$CellContext`U, 
               Part[$CellContext`qAll, $CellContext`i]], {$CellContext`i, 
               1, $CellContext`CHAINS}]; $CellContext`Htotal = 
            If[$CellContext`vanilla, $CellContext`Htotal1, \
$CellContext`Htotal2]; $CellContext`dt = 
            If[$CellContext`vanilla, $CellContext`dt1, $CellContext`dt2]; \
$CellContext`Ktotal = $CellContext`Htotal - $CellContext`Utotal; \
$CellContext`pAll = $CellContext`pAll Sqrt[
               
               Abs[$CellContext`Ktotal/$CellContext`KtotalNew]]; \
$CellContext`ES = {}; $CellContext`AS = {}; 
           For[$CellContext`i = 1, $CellContext`i <= $CellContext`CHAINS, 
             
             Increment[$CellContext`i], $CellContext`p = 
              Part[$CellContext`pAll, $CellContext`i]; $CellContext`q = 
              Part[$CellContext`qAll, $CellContext`i]; $CellContext`UE = {
                
                Apply[$CellContext`U, $CellContext`q]}; $CellContext`q0 = \
$CellContext`q; 
             For[$CellContext`s = 1; 
               Null, $CellContext`s <= $CellContext`STEPS, 
               
               Increment[$CellContext`s], $CellContext`p = $CellContext`p - \
$CellContext`dt 
                 Apply[$CellContext`dU, $CellContext`q]; $CellContext`q = \
$CellContext`q + $CellContext`dt If[$CellContext`vanilla, $CellContext`p, 
                    LinearSolve[
                    
                    Apply[$CellContext`ddU, $CellContext`q], $CellContext`p]]; \
$CellContext`UE = Append[$CellContext`UE, 
                  Apply[$CellContext`U, $CellContext`q]]]; $CellContext`ES = 
              Append[$CellContext`ES, $CellContext`UE]; $CellContext`\[Alpha] = 
              Exp[
                Clip[
                Apply[$CellContext`U, $CellContext`q0] - 
                 Apply[$CellContext`U, $CellContext`q], {-20, 
                 0}]]; $CellContext`AS = Append[$CellContext`AS, 
                N[$CellContext`\[Alpha]]]; 
             If[$CellContext`\[Alpha] < 
               RandomVariate[$CellContext`UD], $CellContext`q = \
$CellContext`q0]; Part[$CellContext`qAll, $CellContext`i] = $CellContext`q; 
             If[$CellContext`j > $CellContext`BURNIN, $CellContext`QS = 
               Append[$CellContext`QS, $CellContext`q]]]; $CellContext`s = 
            Union[
              Flatten[
               Table[
                Ordering[
                 Part[$CellContext`ES, $CellContext`i], 1], {$CellContext`i, 
                 1, $CellContext`CHAINS}]]]; $CellContext`S = Union[
              Flatten[
               Table[
                Ordering[
                 Part[$CellContext`ES, $CellContext`i], -1], {$CellContext`i, 
                 1, $CellContext`CHAINS}]]]; 
           If[$CellContext`j < $CellContext`BURNIN, If[
               Or[
                
                And[$CellContext`s == {
                  1, $CellContext`STEPS + 1}, $CellContext`S == {
                  1, $CellContext`STEPS + 1}], 
                
                And[$CellContext`s == {$CellContext`STEPS + 
                   1}, $CellContext`S == {
                  1}]], $CellContext`dt = $CellContext`dt 1.1]; If[
               
               Or[$CellContext`s == {
                 1}, $CellContext`S == {$CellContext`STEPS + 
                  1}], $CellContext`dt = $CellContext`dt/1.1]; If[
               And[$CellContext`Ktotal > 0, $CellContext`KtotalNew > 0], 
               If[
                
                And[$CellContext`Utotal < 
                 0, $CellContext`Htotal > $CellContext`Utotal/
                  100], $CellContext`Htotal = $CellContext`Utotal/100, 
                If[
                 
                 And[$CellContext`Utotal > 0, $CellContext`Htotal > 
                  100 $CellContext`Utotal], $CellContext`Htotal = 
                 100 $CellContext`Utotal, 
                 If[Mean[$CellContext`AS] > 
                   0.9, $CellContext`Ktotal = $CellContext`Ktotal 1.1, 
                   If[
                   Mean[$CellContext`AS] < 
                    0.1, $CellContext`Ktotal = $CellContext`Ktotal/
                    1.1]]; $CellContext`Htotal = $CellContext`Ktotal + \
$CellContext`Utotal]]]; 
             If[$CellContext`vanilla, $CellContext`Htotal1 = \
$CellContext`Htotal; $CellContext`dt1 = $CellContext`dt, $CellContext`Htotal2 = \
$CellContext`Htotal; $CellContext`dt2 = $CellContext`dt]]; 
           If[$CellContext`switch, $CellContext`vanilla = 
             Not[$CellContext`vanilla]]]; $CellContext`QS]}; 
     Typeset`initDone$$ = True),
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output",
 CellChangeTimes->{3.817665256380991*^9, 3.817665344218412*^9, 
  3.817698848638335*^9, 3.8176989759101067`*^9, 3.8176990240059977`*^9},
 CellID->367627099,ExpressionUUID->"e465f4ab-5fe1-44fd-a3d7-31a576007ada"]
}, Open  ]],

Cell[CellGroupData[{

Cell["", "DetailsSection",ExpressionUUID->"70af2d45-54fc-4ba5-90ca-38eff69d0ebb"],

Cell["https://github.com/dawning-phoenix/hmc", "DetailNotes",
 CellID->1815381080,ExpressionUUID->"0a813ad6-56f9-4ee1-a658-1f3a55b73f5f"]
}, Open  ]],

Cell[CellGroupData[{

Cell["", "ControlSuggestionsSection",ExpressionUUID->"06b2a395-5187-496d-92e8-973143bebf25"],

Cell[BoxData[
 TooltipBox[
  RowBox[{
   CheckboxBox[False], Cell[
   " Resize Images",ExpressionUUID->"7651bd46-1647-47cf-9721-ead9215ce822"]}],
  
  "\"Click inside an image to reveal its orange resize frame.\\nDrag any of \
the orange resize handles to resize the image.\""]], "ControlSuggestions",
 FontFamily->"Verdana",
 CellTags->
  "ResizeImages",ExpressionUUID->"239b5be9-f4ea-4afa-895d-53c5b18a2764"],

Cell[BoxData[
 TooltipBox[
  RowBox[{
   CheckboxBox[False], Cell[
   " Rotate and Zoom in 3D",ExpressionUUID->
    "fd174afa-e18b-4469-b6ff-641816ad6798"]}],
  RowBox[{
   "\"Drag a 3D graphic to rotate it. Starting the drag near the center \
tumbles\\nthe graphic; starting near a corner turns it parallel to the plane \
of the screen.\\nHold down \"", 
    FrameBox[
    "Ctrl", Background -> GrayLevel[0.9], FrameMargins -> 2, FrameStyle -> 
     GrayLevel[0.9]], "\" (or \"", 
    FrameBox[
    "Cmd", Background -> GrayLevel[0.9], FrameMargins -> 2, FrameStyle -> 
     GrayLevel[0.9]], 
    "\" on Mac) and drag up and down to zoom.\""}]]], "ControlSuggestions",
 FontFamily->"Verdana",
 CellTags->
  "RotateAndZoomIn3D",ExpressionUUID->"3e07d286-2915-42f8-ab95-170c432f3576"],

Cell[BoxData[
 TooltipBox[
  RowBox[{
   CheckboxBox[False], Cell[
   " Drag Locators",ExpressionUUID->"3e5b5ce1-3918-468b-a176-8044e8604b9d"]}],
  
  RowBox[{"\"Drag any locator (\"", 
    GraphicsBox[
     LocatorBox[
      Scaled[{0.5, 0.5}]], ImageSize -> 20], 
    "\", etc.) to move it around.\""}]]], "ControlSuggestions",
 FontFamily->"Verdana",
 CellTags->
  "DragLocators",ExpressionUUID->"d6914e30-e4cb-4688-b707-15a7768ac67e"],

Cell[BoxData[
 TooltipBox[
  RowBox[{
   CheckboxBox[False], Cell[
   " Create and Delete Locators",ExpressionUUID->
    "3cbe7682-c87d-48e5-820b-acc351907cdf"]}],
  RowBox[{"\"Insert a new locator in the graphic by holding down the \"", 
    FrameBox[
    "Alt", Background -> GrayLevel[0.9], FrameMargins -> 2, FrameStyle -> 
     GrayLevel[0.9]], 
    "\" key\\nand clicking where you want it to be. Delete a locator by \
clicking it\\nwhile holding down the \"", 
    FrameBox[
    "Alt", Background -> GrayLevel[0.9], FrameMargins -> 2, FrameStyle -> 
     GrayLevel[0.9]], "\" key.\""}]]], "ControlSuggestions",
 FontFamily->"Verdana",
 CellTags->
  "CreateAndDeleteLocators",ExpressionUUID->"59e78494-121d-4a22-9f28-\
a2774e753e69"],

Cell[BoxData[
 TooltipBox[
  RowBox[{
   CheckboxBox[False], Cell[
   " Slider Zoom",ExpressionUUID->"0f2f2fe1-0c20-4c63-875b-650ddfc4ace1"]}],
  RowBox[{"\"Hold down the \"", 
    FrameBox[
    "Alt", Background -> GrayLevel[0.9], FrameMargins -> 2, FrameStyle -> 
     GrayLevel[0.9]], 
    "\" key while moving a slider to make fine adjustments in the slider \
value.\\nHold \"", 
    FrameBox[
    "Ctrl", Background -> GrayLevel[0.9], FrameMargins -> 2, FrameStyle -> 
     GrayLevel[0.9]], "\" and/or \"", 
    FrameBox[
    "Shift", Background -> GrayLevel[0.9], FrameMargins -> 2, FrameStyle -> 
     GrayLevel[0.9]], "\" at the same time as \"", 
    FrameBox[
    "Alt", Background -> GrayLevel[0.9], FrameMargins -> 2, FrameStyle -> 
     GrayLevel[0.9]], 
    "\" to make ever finer adjustments.\""}]]], "ControlSuggestions",
 FontFamily->"Verdana",
 CellTags->
  "SliderZoom",ExpressionUUID->"7cb840fe-f796-4f74-8af7-437d2ac9429a"],

Cell[BoxData[
 TooltipBox[
  RowBox[{
   CheckboxBox[False], Cell[
   " Gamepad Controls",ExpressionUUID->
    "fcd01afe-0437-43f9-8dad-2e37f980da8e"]}],
  "\"Control this Demonstration with a gamepad or other\\nhuman interface \
device connected to your computer.\""]], "ControlSuggestions",
 CellChangeTimes->{3.35696210375764*^9, 3.3895522232313623`*^9},
 FontFamily->"Verdana",
 CellTags->
  "GamepadControls",ExpressionUUID->"bab9ff6f-30b5-42b8-a08e-ad7c333b70b5"],

Cell[BoxData[
 TooltipBox[
  RowBox[{
   CheckboxBox[False], Cell[
   " Automatic Animation",ExpressionUUID->
    "1dc8d759-d8b7-4e2c-b0af-e95e16affa3d"]}],
  RowBox[{"\"Animate a slider in this Demonstration by clicking the\"", 
    AdjustmentBox[
     Cell[
      GraphicsData[
      "CompressedBitmap", 
       "eJzzTSzJSM1NLMlMTlRwL0osyMhMLlZwyy8CCjEzMjAwcIKwAgOI/R/IhBKc\n\
/4EAyGAG0f+nTZsGwgysIJIRKsWKLAXGIHFmEpUgLADxWUAkI24jZs+eTaEt\n\
IG+wQKRmzJgBlYf5lhEA30OqWA=="], "Graphics", ImageSize -> {9, 9}, ImageMargins -> 
      0, CellBaseline -> Baseline], BoxBaselineShift -> 0.1839080459770115, 
     BoxMargins -> {{0., 0.}, {-0.1839080459770115, 0.1839080459770115}}], 
    "\"button\\nnext to the slider, and then clicking the play button that \
appears.\\nAnimate all controls by selecting \"", 
    StyleBox["Autorun", FontWeight -> "Bold"], "\" from the\"", 
    AdjustmentBox[
     Cell[
      GraphicsData[
      "CompressedBitmap", 
       "eJyNULENwyAQfEySIlMwTVJlCGRFsosokeNtqBmDBagoaZjAI1C8/8GUUUC6\n\
57h7cQ8PvU7Pl17nUav7oj/TPH7V7b2QJAUAXBkKmCPRowxICy64bRvGGNF7\n\
X8CctGoDSN4xhIDGGDhzFXwUh3/ClBKrDQPmnGXtI6u0OOd+tZBVUqy1xSaH\n\
UqiK6pPe4XdEdAz6563tx/gejuORGMxJaz8mdpJn7hc="], "Graphics", 
      ImageSize -> {10, 10}, ImageMargins -> 0, CellBaseline -> Baseline], 
     BoxBaselineShift -> 0.1839080459770115, 
     BoxMargins -> {{0., 0.}, {-0.1839080459770115, 0.1839080459770115}}], 
    "\"menu.\""}]]], "ControlSuggestions",
 FontFamily->"Verdana",
 CellTags->
  "AutomaticAnimation",ExpressionUUID->"34415e25-1ee2-4d1c-a834-cedf276ec71f"],

Cell[BoxData[
 TooltipBox[
  RowBox[{
   CheckboxBox[False], Cell[
   " Bookmark Animation",ExpressionUUID->
    "b88fb0af-ae03-4fb1-aeb8-0b6dc39c8663"]}],
  RowBox[{
   "\"See a prepared animation of this Demonstration by selecting\\n\"", 
    StyleBox["Animate Bookmarks", FontWeight -> "Bold"], "\" from the\"", 
    AdjustmentBox[
     Cell[
      GraphicsData[
      "CompressedBitmap", 
       "eJyNULENwyAQfEySIlMwTVJlCGRFsosokeNtqBmDBagoaZjAI1C8/8GUUUC6\n\
57h7cQ8PvU7Pl17nUav7oj/TPH7V7b2QJAUAXBkKmCPRowxICy64bRvGGNF7\n\
X8CctGoDSN4xhIDGGDhzFXwUh3/ClBKrDQPmnGXtI6u0OOd+tZBVUqy1xSaH\n\
UqiK6pPe4XdEdAz6563tx/gejuORGMxJaz8mdpJn7hc="], "Graphics", 
      ImageSize -> {10, 10}, ImageMargins -> 0, CellBaseline -> Baseline], 
     BoxBaselineShift -> 0.1839080459770115, 
     BoxMargins -> {{0., 0.}, {-0.1839080459770115, 0.1839080459770115}}], 
    "\"menu.\""}]]], "ControlSuggestions",
 FontFamily->"Verdana",
 CellTags->
  "BookmarkAnimation",ExpressionUUID->"f02275db-2154-43f7-a1b4-42980762fa16"]
}, Open  ]],

Cell["", "SearchTermsSection",ExpressionUUID->"7942ee06-8664-4240-8fd7-0881e8d7b4d0"],

Cell["", "RelatedLinksSection",ExpressionUUID->"e312c0c6-0530-419a-8f66-265a7186c0cd"],

Cell[CellGroupData[{

Cell["", "AuthorSection",ExpressionUUID->"8d5300bc-85ab-425d-8204-c7c917c080cd"],

Cell["Contributed by: Xiaopeng Xu", "Author",
 CellChangeTimes->{
  3.35696210375764*^9, {3.432333043774981*^9, 3.432333045441087*^9}, {
   3.817637480533227*^9, 
   3.817637483998908*^9}},ExpressionUUID->"fa3e0711-c9b5-4201-b186-\
3271eed29ca7"]
}, Open  ]]
}, Open  ]]
},
WindowSize->{1869, 1025},
WindowMargins->{{0, Automatic}, {0, Automatic}},
FrontEndVersion->"12.0 for Linux x86 (64-bit) (April 8, 2019)",
StyleDefinitions->FrontEnd`FileName[{"Wolfram"}, "Demonstration.nb", 
  CharacterEncoding -> "UTF-8"]
]
(* End of Notebook Content *)

(* Internal cache information *)
(*CellTagsOutline
CellTagsIndex->{
 "ResizeImages"->{
  Cell[414161, 7244, 410, 10, 24, "ControlSuggestions",ExpressionUUID->"239b5be9-f4ea-4afa-895d-53c5b18a2764",
   CellTags->"ResizeImages"]},
 "RotateAndZoomIn3D"->{
  Cell[414574, 7256, 783, 19, 24, "ControlSuggestions",ExpressionUUID->"3e07d286-2915-42f8-ab95-170c432f3576",
   CellTags->"RotateAndZoomIn3D"]},
 "DragLocators"->{
  Cell[415360, 7277, 438, 13, 24, "ControlSuggestions",ExpressionUUID->"d6914e30-e4cb-4688-b707-15a7768ac67e",
   CellTags->"DragLocators"]},
 "CreateAndDeleteLocators"->{
  Cell[415801, 7292, 739, 18, 24, "ControlSuggestions",ExpressionUUID->"59e78494-121d-4a22-9f28-a2774e753e69",
   CellTags->"CreateAndDeleteLocators"]},
 "SliderZoom"->{
  Cell[416543, 7312, 944, 23, 24, "ControlSuggestions",ExpressionUUID->"7cb840fe-f796-4f74-8af7-437d2ac9429a",
   CellTags->"SliderZoom"]},
 "GamepadControls"->{
  Cell[417490, 7337, 469, 11, 24, "ControlSuggestions",ExpressionUUID->"bab9ff6f-30b5-42b8-a08e-ad7c333b70b5",
   CellTags->"GamepadControls"]},
 "AutomaticAnimation"->{
  Cell[417962, 7350, 1564, 33, 24, "ControlSuggestions",ExpressionUUID->"34415e25-1ee2-4d1c-a834-cedf276ec71f",
   CellTags->"AutomaticAnimation"]},
 "BookmarkAnimation"->{
  Cell[419529, 7385, 1008, 23, 24, "ControlSuggestions",ExpressionUUID->"f02275db-2154-43f7-a1b4-42980762fa16",
   CellTags->"BookmarkAnimation"]}
 }
*)
(*CellTagsIndex
CellTagsIndex->{
 {"ResizeImages", 421467, 7439},
 {"RotateAndZoomIn3D", 421633, 7442},
 {"DragLocators", 421799, 7445},
 {"CreateAndDeleteLocators", 421971, 7448},
 {"SliderZoom", 422141, 7451},
 {"GamepadControls", 422303, 7454},
 {"AutomaticAnimation", 422473, 7457},
 {"BookmarkAnimation", 422646, 7460}
 }
*)
(*NotebookFileOutline
Notebook[{
Cell[CellGroupData[{
Cell[1510, 35, 205, 3, 77, "DemoTitle",ExpressionUUID->"78f83cfc-6770-414c-a033-2371b6fe21cf"],
Cell[CellGroupData[{
Cell[1740, 42, 88, 0, 350, "InitializationSection",ExpressionUUID->"9b05f870-aeb8-4b0a-ba25-fa4081eb5c94"],
Cell[1831, 44, 13690, 336, 1219, "Input",ExpressionUUID->"ff71f218-c1dc-4809-bc46-03bf0850163d",
 InitializationCell->True,
 CellID->932801461]
}, Closed]],
Cell[CellGroupData[{
Cell[15558, 385, 84, 0, 232, "ManipulateSection",ExpressionUUID->"e3171994-32be-49b2-ae5b-18585b4652e4"],
Cell[CellGroupData[{
Cell[15667, 389, 3066, 84, 279, "Input",ExpressionUUID->"5eba2f5c-6760-47e3-85ba-e7bf3a071ac0",
 CellID->207249874],
Cell[18736, 475, 78897, 1345, 499, "Output",ExpressionUUID->"09e5c716-b11c-404c-9ee2-837c063d14fa",
 CellID->1913502953]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[97682, 1826, 91, 0, 180, "ManipulateCaptionSection",ExpressionUUID->"343ea5f6-a1e2-433e-a23a-ef37af0b05bb"],
Cell[97776, 1828, 254, 6, 24, "ManipulateCaption",ExpressionUUID->"62c4c770-c515-46db-8779-e8362edab391"]
}, Open  ]],
Cell[CellGroupData[{
Cell[98067, 1839, 83, 0, 196, "ThumbnailSection",ExpressionUUID->"8212c40d-46ef-4ecf-8636-6737412e60f3"],
Cell[98153, 1841, 78896, 1345, 491, "Output",ExpressionUUID->"41325725-c29d-4a4a-94c2-3b3f0bb13b9d",
 CellID->299801647]
}, Open  ]],
Cell[CellGroupData[{
Cell[177086, 3191, 83, 0, 166, "SnapshotsSection",ExpressionUUID->"c41a30ce-d578-468b-bdd1-e5c4cdcf666c"],
Cell[177172, 3193, 78864, 1344, 495, "Output",ExpressionUUID->"d92329b3-1268-438c-85ac-aa59d3285fde",
 CellID->316109030],
Cell[256039, 4539, 78865, 1344, 495, "Output",ExpressionUUID->"896a0515-f506-4626-a5d9-d3e37523c996",
 CellID->1210265810],
Cell[334907, 5885, 78864, 1344, 501, "Output",ExpressionUUID->"e465f4ab-5fe1-44fd-a3d7-31a576007ada",
 CellID->367627099]
}, Open  ]],
Cell[CellGroupData[{
Cell[413808, 7234, 81, 0, 375, "DetailsSection",ExpressionUUID->"70af2d45-54fc-4ba5-90ca-38eff69d0ebb"],
Cell[413892, 7236, 137, 1, 24, "DetailNotes",ExpressionUUID->"0a813ad6-56f9-4ee1-a658-1f3a55b73f5f",
 CellID->1815381080]
}, Open  ]],
Cell[CellGroupData[{
Cell[414066, 7242, 92, 0, 131, "ControlSuggestionsSection",ExpressionUUID->"06b2a395-5187-496d-92e8-973143bebf25"],
Cell[414161, 7244, 410, 10, 24, "ControlSuggestions",ExpressionUUID->"239b5be9-f4ea-4afa-895d-53c5b18a2764",
 CellTags->"ResizeImages"],
Cell[414574, 7256, 783, 19, 24, "ControlSuggestions",ExpressionUUID->"3e07d286-2915-42f8-ab95-170c432f3576",
 CellTags->"RotateAndZoomIn3D"],
Cell[415360, 7277, 438, 13, 24, "ControlSuggestions",ExpressionUUID->"d6914e30-e4cb-4688-b707-15a7768ac67e",
 CellTags->"DragLocators"],
Cell[415801, 7292, 739, 18, 24, "ControlSuggestions",ExpressionUUID->"59e78494-121d-4a22-9f28-a2774e753e69",
 CellTags->"CreateAndDeleteLocators"],
Cell[416543, 7312, 944, 23, 24, "ControlSuggestions",ExpressionUUID->"7cb840fe-f796-4f74-8af7-437d2ac9429a",
 CellTags->"SliderZoom"],
Cell[417490, 7337, 469, 11, 24, "ControlSuggestions",ExpressionUUID->"bab9ff6f-30b5-42b8-a08e-ad7c333b70b5",
 CellTags->"GamepadControls"],
Cell[417962, 7350, 1564, 33, 24, "ControlSuggestions",ExpressionUUID->"34415e25-1ee2-4d1c-a834-cedf276ec71f",
 CellTags->"AutomaticAnimation"],
Cell[419529, 7385, 1008, 23, 24, "ControlSuggestions",ExpressionUUID->"f02275db-2154-43f7-a1b4-42980762fa16",
 CellTags->"BookmarkAnimation"]
}, Open  ]],
Cell[420552, 7411, 85, 0, 164, "SearchTermsSection",ExpressionUUID->"7942ee06-8664-4240-8fd7-0881e8d7b4d0"],
Cell[420640, 7413, 86, 0, 136, "RelatedLinksSection",ExpressionUUID->"e312c0c6-0530-419a-8f66-265a7186c0cd"],
Cell[CellGroupData[{
Cell[420751, 7417, 80, 0, 136, "AuthorSection",ExpressionUUID->"8d5300bc-85ab-425d-8204-c7c917c080cd"],
Cell[420834, 7419, 246, 5, 24, "Author",ExpressionUUID->"fa3e0711-c9b5-4201-b186-3271eed29ca7"]
}, Open  ]]
}, Open  ]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature Gw0x7rivJn7NKA1J5xg6ys7y *)
