Attribute VB_Name = "M_Func_Basic"

Public Function f_nnC(Lp As Double, dp As Double) As Double
'
  'Function to calc nnC of Pole
  Dim HpB As Double             'H/B value
  '
  'Calculate H/B
  'H = Length of Pole
  'B = Diameter of pole
  '
  HpB = RInt2(Lp / (dp / 1000))
  '
  If HpB <= 1 Then
    f_nnC = 0.7
  ElseIf HpB > 1 And HpB < 8 Then
    f_nnC = 0.2 / 7 * HpB + 0.67144
    f_nnC = RInt3(f_nnC)
  ElseIf HpB >= 8 Then
    f_nnC = 0.9
  End If
  '
End Function
')

Public Function f_kz(z_ob As Double) As Double
'
  Dim Hs As Double
  Dim zb As Double
  Dim aha As Double
  
  Hs = Act_comn(0)
  zb = Act_comn(1)
  aha = Act_comn(3)
  
  If Hs < zb Then
    f_kz = 1
  ElseIf Hs > zb And z_ob <= zb Then
    f_kz = (zb / Hs) ^ (2 * aha)
  ElseIf Hs > zb And z_ob > zb Then
    f_kz = (z_ob / Hs) ^ (2 * aha)
  End If
  
  f_kz = RInt3(f_kz)
'
End Function
')

'Function Allowance Stress
Public Function fb(material As String) As Long
'
  Select Case material
    Case "STK400"
      fb = 156
    Case "STK500"
      fb = 234
    Case "STK540"
      fb = 250
  End Select
'
End Function
')

Public Function sfb(material As String) As Long
'
  Select Case material
    Case "SGP"
      sfb = 170
    Case "STK400"
      sfb = 235
    Case "STK490"
      sfb = 325
    Case "STK500"
      sfb = 350
    Case "STK540"
      sfb = 375
    Case "STKR400"
      sfb = 235
  End Select
'
End Function
')

Public Function sfs(material As String) As Long
'
  Select Case material
    Case "STK400"
      sfs = 136
    Case "STK500"
      sfs = 202
    Case "STK540"
      sfs = 216
    Case "STKR400"
      sfs = 135
  End Select
'
End Function
')

Public Function sfc(material As String) As Long
'
  Select Case material
    Case "STK400"
      sfc = 235
    Case "STK500"
      sfc = 350
    Case "STK540"
      sfc = 375
  End Select
'
End Function
')

'Function for cross section Area Round pole [A] (cm^2)
Public Function Cross_Ap(DpL As Double, TpL As Double)
'
' DpL = Diameter Pole in mm
' TpL = Thickness Pole in mm

  Const pi_c As Double = 3.14159265358979
  
  Cross_Ap = pi_c / 4 * (DpL ^ 2 - (DpL - 2 * TpL) ^ 2) / 100
'
End Function
')

'Function for Moment Inertia of Round pole [I] (cm^4)
Public Function Inas_Mp(DpL As Double, TpL As Double)
'
' DpL = Diameter Pole in mm
' TpL = Thickness Pole in mm

  Const pi_c As Double = 3.14159265358979
  
  Inas_Mp = (pi_c / 64) * ((DpL ^ 4) - (DpL - 2 * TpL) ^ 4) / 10000
'
End Function
')

'Function for Section modulus of Round Pole [Z] (cm^3)
Public Function Sec_Mdl(DpL As Double, TpL As Double)
'
' DpL = Diameter Pole in mm
' TpL = Thickness Pole in mm

  Const pi_c As Double = 3.14159265358979
   
  Sec_Mdl = pi_c * (DpL ^ 4 - (DpL - TpL * 2) ^ 4) / (32 * DpL) / 1000
'
End Function
')

'Function for Radius Gyration (cm)
Public Function Rad_Gy(DpL As Double, TpL As Double)
'
' DpL = Diameter Pole in mm
' TpL = Thickness Pole in mm
 
  Rad_Gy = ((1 / 16) * (DpL ^ 2 + (DpL - 2 * TpL) ^ 2) / 100) ^ 0.5
'
End Function
')

'FL/m [flp_u] (Fix Load, weight of Straight Pipe [ N/m ]
'
Public Function fl_u(DpL As Double, TpL As Double)
  Const pi_c As Double = 3.14159265358979
'
  fl_u = RInt2((pi_c / 4) * (DpL ^ 2 - (DpL - 2 * TpL) ^ 2) _
           / 10 ^ 6 * 7850) * 9.80665
'
End Function
')

'FL [flp] (Fix Load, weight of Straight Pipe [ N ]
'
Public Function fL_s(DpL As Double, TpL As Double, Lp As Double)
'
  Const pi_c As Double = 3.14159265358979
'
  fL_s = RInt2((pi_c / 4) * (DpL ^ 2 - (DpL - 2 * TpL) ^ 2) _
         / 10 ^ 6 * 7850) * Lp * 9.80665
'
End Function
')

'FL/m [flp] (Fix Load, weight) of Taper Pipe [ N/m ]
Public Function FL_t_u(DL As Double, _
                       DU As Double, _
                       TL As Double, _
                       TU As Double)
'
  Const pi_c As Double = 3.14159265358979
'
  FL_t_u = RInt2((pi_c / 4) * (((DL - DU) / 2 + DU) ^ 2 _
         - (((DL - 2 * TL) - (DU - 2 * TU)) / 2 + (DU - 2 * TU)) ^ 2) _
         / 10 ^ 6 * 7850) * 9.80665
'
End Function
')

'FL [flp] (Fix Load, weight) of Taper Pipe [ N ]
Public Function FL_T(DL As Double, DU As Double, TL As Double, TU As Double, Lp As Double)
'
  Const pi_c As Double = 3.14159265358979
'
  FL_T = RInt2((pi_c * Lp / 4) * (((DL - DU) / 2 + DU) ^ 2 _
         - (((DL - 2 * TL) - (DU - 2 * TU)) / 2 + (DU - 2 * TU)) ^ 2) _
         / 10 ^ 6 * 7850) * 9.80665
'
End Function
')

'FL [flp] (Fix Load, weight of Rectangular Pipe [ N ]
'
Public Function FL_Rec_u(D As Double, W As Double, T As Double)
'
  FL_Rec_u = RInt2(0.0157 * T * (D + W - 3.287 * T)) * 9.80665 '(d * W - ((d - 2 * t) * (W - 2 * t))) * 10 ^ -6 * 7850 * 9.80665
'
End Function
')

'FL [flp] (Fix Load, weight of Rectangular Pipe [ N ]
'
Public Function FL_Rec(D As Double, W As Double, T As Double, Lp As Double)
'
  FL_Rec = RInt2(0.0157 * T * (D + W - 3.287 * T)) * 9.80665 * Lp  '(d * W - ((d - 2 * t) * (W - 2 * t))) * 10 ^ -6 * 7850 * 9.80665 * Lp
'
End Function
')

Public Function RInt0(ByVal aV As Double) As Double
  If aV > 0 Then
    RInt0 = Int(CDbl(aV * 1 + 0.5)) / 1      'Positive
  Else
    RInt0 = Fix(CDbl(aV * 1 - 0.5)) / 1      'Negative
  End If
End Function
')

Public Function RInt1(ByVal aV As Double) As Double
  If aV > 0 Then
    RInt1 = Int(CDbl(aV * 10 + 0.5)) / 10      'Positive
  Else
    RInt1 = Fix(CDbl(aV * 10 - 0.5)) / 10      'Negative
  End If
End Function
')

Public Function RInt2(ByVal aV As Double) As Double
  If aV > 0 Then
    RInt2 = Int(CDbl(aV * 100 + 0.5)) / 100    'Positive
  Else
    RInt2 = Fix(CDbl(aV * 100 - 0.5)) / 100    'Negative
  End If
'
End Function
')

Public Function RInt3(ByVal aV As Double) As Double
  If aV > 0 Then
    RInt3 = Int(CDbl(aV * 1000 + 0.5)) / 1000  'Positive
  Else
    RInt3 = Fix(CDbl(aV * 1000 - 0.5)) / 1000  'Negative
  End If
End Function
')

Public Function RInt4(ByVal aV As Double) As Double
  If aV > 0 Then
    RInt4 = Int(CDbl(aV * 10000 + 0.5)) / 10000  'Positive
  Else
    RInt4 = Fix(CDbl(aV * 10000 - 0.5)) / 10000  'Negative
  End If
End Function
')




