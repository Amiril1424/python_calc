VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Arm_Spec"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'Arm Property
  Public nm As String                                       'Property of Name
  Public Dia As Double                                      'Property of Diameter
  Public thc As Double                                      'Property of Thickness
  Public T_Length As Double                                 'Property of Total Length
  Public Exp_Length As Double                               'Property of Exposure Length
  Public z As Double                                        'Property of Height
  Public mtr As String                                      'Property of Material
  Public Lc As Double                                       'Property of Length Center
'
'Allowance Stress Property
  Public f_b As Double                                      'Property of fb
  Public s_fb As Double                                     'Property of sfb
  Public s_fs As Double                                     'Property of sfs
  Public s_fc As Double                                     'Property of sfc
'
'Arm Spec Property
  Public Sec_A As Double                                    'Property of Section Area
  Public sec_mod As Double                                  'Property of Section Modulus
  Public M_Ine As Double                                    'Property of Moment of Inertia
  Public Ip As Double                                       'Property Second Moment of Area of Lower Main Column
  Public Rad_G As Double                                    'Property of Radius Gyration
'
'Calcu Arm Property
  Public mass_m As Double                                   'Property of Fixload of arm per meter
  Public mass As Double                                     'Property of Fixload of arm
  Public fld_m As Double                                    'Property of Fixload of arm per meter in Newton
  Public fld As Double                                      'Property of Fixload of arm in Newton
  Public Ar_F As Double                                     'Property of Area Front
  Public Ar_S As Double                                     'Property of Area Side
  Public Ar_F_mm As Double                                  'Property of Area Front in mm
  Public Ar_S_mm As Double                                  'Property of Area Side in mm
')

Public Sub Arm_Value(ByVal row_n As Integer)                'Method for Read Arm Value
'
  nm = Sheet1.Cells(row_n, 2).Value
  Dia = Sheet1.Cells(row_n, 3).Value
  thc = Sheet1.Cells(row_n, 4).Value
  T_Length = Sheet1.Cells(row_n, 5).Value
  Exp_Length = Sheet1.Cells(row_n, 6).Value
  z = Sheet1.Cells(row_n, 7).Value
  mtr = Sheet1.Cells(row_n, 8).Value
'
End Sub
')

Public Sub Arm_Specification()                                       'Method for Calculation Arm Spec
'
'Calculate Allowance Stress
  f_b = fb(mtr)
  s_fb = sfb(mtr)
  s_fs = sfs(mtr)
  s_fc = sfc(mtr)
  '
'Calculate Section Area
  Sec_A = Fkb_SF(Cross_Ap(Dia, thc), 4)
  '
'Calculate Section Modulus
  sec_mod = Fkb_SF(Sec_Mdl(Dia, thc), 3)
  '
'Calculate Moment Of Inatia
  M_Ine = Fkb_SF(Inas_Mp(Dia, thc), 3)
  '
'Calculate Second Moment of Area of Lower Main Column
  Ip = Fkb_SF(M_Ine * 2, 3)
  '
'Calculate Radius Gyration
  Rad_G = Fkb_SF((Rad_Gy(Dia, thc)), 3)
'
End Sub
')

Public Sub Fixload()                                        'Method for Calculation Fixload of Arm
'
'Calculate Massa per Meter (kg/m)
  mass_m = Fkb_SF((fl_u(Dia, thc)), 3)
'Calculate Massa pole after multiple with Length
  mass = Fkb_SF((fL_s(Dia, thc, T_Length)), 3)
  '
'Calculate Massa per Meter (N/m)
  fld_m = Fkb_SF(mass_m * 9.81, 3)
'Calculate Massa per Meter (N/m)
  fld = Fkb_SF(mass * 9.81, 3)
'
End Sub
')

Public Sub Area()                                           'Method for Calculation Area of Arm
'
'Area of Arm
  Ar_F = Fkb_SF((Dia / 1000) * (Exp_Length / 1000), 3)
'For Side Area in Arm single round type, side area always 0
  Ar_S = Fkb_SF(0, 3)
  '
'Area of Arm
  Ar_F_mm = Fkb_SF(Dia * Exp_Length, 3)
  '
'For Side Area in Arm single round type, side area always 0
  Ar_S_mm = Fkb_SF(0, 3)
'
End Sub
')

Public Sub Center_Length()                                  'Method for Calculation Center Length of Arm
'
'Calculate Center Length of Arm
'For now as first submisson, type of arm only 1 (SIngle Round Straight), so the formula only 1
'Still not consider Lc if Arm Taper
  Lc = T_Length / 2
'
End Sub
')

  

