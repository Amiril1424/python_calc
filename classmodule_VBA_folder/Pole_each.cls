VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Pole_each"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'Pole Property
  Public mtr As String                                          'Property of Material
  Public typ As String                                          'Property of Type
  Public dia_L As Double                                        'Property of Diameter Lower
  Public dia_U As Double                                        'Property of Diameter Upper
  Public thc_L As Double                                        'Property of Thickness Lower
  Public thc_U As Double                                        'Property of Thickness Upper
  Public nm As String                                           'Property of Name
  Public z As Double                                            'Property of Height
  Public qt As Double                                           'Property of Quantity
'
'Allowance Stress Property
  Public f_b As Double                                          'Property of fb
  Public s_fb As Double                                         'Property of sfb
  Public s_fs As Double                                         'Property of sfs
  Public s_fc As Double                                         'Property of sfc
'
'Pole Spec Property
  Public Sec_A As Double                                        'Property of Section Area
  Public sec_mod As Double                                      'Property of Section Modulus
  Public M_Ine As Double                                        'Property of Moment of Inertia
  Public Ip As Double                                           'Property Second Moment of Area of Lower Main Column
  Public Rad_G As Double                                        'Property of Radius Gyration
'
'Calcu Pole Property
  Public Length As Double                                       'Property of Length
  Public taper_ratio As Double                                  'Property of Taper Ratio
  Public taper_typ As String                                    'Property of Type Taper
  Public Dia_sec As Double                                      'Property of Diameter in Section Evaluation
  Public mass_m As Double                                       'Property of Massa Per meter in Kg/m
  Public mass As Double                                         'Property of Massa in kg (Kg)
  Public fld_m As Double                                        'Property of FixLoad per Meter (N)
  Public fld As Double                                          'Property of Fixload in Newton (N)
'
  Public kz As Double                                           'Property of Kz
  Public q_b_kz As Double
  Public q_wpr As Double                                        'Property of Wind Pressure
  Public Vo As Double                                           'Property of Wind Speed
  Public AoA  As Double                                         'Property of Angle of Atack
  Public cf As Double                                           'Property of Coefisien
  Public nc As Double                                           'Property of nnc
  Public HBp As Double
  Public B_val_p As Double
  Public Area As Double                                         'Property of Area in m
  Public Area_mm As Double                                      'Property of Area in mm
  Public WnL As Double                                          'Property of Winload Per Section
  Public WnL_X As Double                                        'Property of Winload X axis
  Public WnL_Y As Double                                        'Property of Winload Y axis
'
  Public Cp As Double                                           'Property of Center Point
  Public Lcp As Double                                          'Property of Length Center Point
  Public MwL As Double                                          'Property of Moment due to Winload
  Public MwL_X As Double                                        'Property of Moment due to Winload X axis
  Public MwL_Y As Double                                        'Property of Moment due to Winload Y axis
'
'Seismic Load Property
  Public ELp As Double                                          'Property of Seismic Load for Pole
  Public MSL As Double                                          'Property of Moment due to Horizontal Seismic Load
')

Sub Pole_Value(ByVal row_n As Integer)                          'Method for Read Value of Pole
'
  nm = Sheet1.Cells(row_n, 2).Value
  mtr = Sheet1.Cells(row_n, 3).Value
  typ = Sheet1.Cells(row_n, 4).Value
  dia_L = Sheet1.Cells(row_n, 5).Value
  dia_U = Sheet1.Cells(row_n, 6).Value
  thc_L = Sheet1.Cells(row_n, 7).Value
  thc_U = Sheet1.Cells(row_n, 8).Value
  z = Sheet1.Cells(row_n, 9).Value
  qt = Sheet1.Cells(row_n, 10).Value
'
End Sub
')

Public Sub Calc_Length(ByVal h_s As Double)                     'Method for Calculate Length of Pole
'
  Length = z - h_s
'
End Sub
')

Public Sub calc_taper_ratio(ByVal h_total As Double)            'Method for Calculate Taper Ratio of Pole
'
  Dim Length_full As Double
  '
  Length_full = z - h_total
  '
  'Calculate Taper ratio
  If typ = "Straight" Then
    taper_ratio = 0
  ElseIf typ = "Taper" Then
    taper_ratio = (dia_L - dia_U) / Length_full
  End If
  '
  'Calculate Type of Taper
  If typ = "Taper" Then
    If taper_ratio = 0.01 Then
      taper_typ = " 1/100テーパー柱"                             'If taper ratio is 0.01 (1/100 Tapered Pillar)
    Else
      taper_typ = " 温間スピニングテーパー柱"                    'If taper ratio is not 0.01 (Spinning Taper)
    End If
  ElseIf typ = "Straight" Then
    taper_typ = ""                                               'If typ is "Straight", set Taper Type to empty
  End If
'
End Sub
')

Public Sub Calc_Diameter_Section()                              'Method for Calculate Diameter of Pole
'
  'Calculate Diameter of Lower pole at specific Height Section
  If typ = "Straight" Then
    Dia_sec = dia_L
  ElseIf typ = "Taper" Then
    Dia_sec = Fkb_SF(dia_U + taper_ratio * Length, 4)
  End If
  '
End Sub
')

Public Sub Po_Spec()                                            'Method for Read Value of Pole
'
  'Calculation for Allowance Stress
  f_b = fb(mtr)
  s_fb = sfb(mtr)
  s_fs = sfs(mtr)
  s_fc = sfc(mtr)
'  '
  'Calculation for Section Area
  Sec_A = Fkb_SF((Cross_Ap(Dia_sec, thc_L)), 3)
  '
  'Calculation for Section Modulus
  sec_mod = Fkb_SF(Sec_Mdl(Dia_sec, thc_L), 3)
  '
  'Calculation for Moment Of Inertia
  M_Ine = Fkb_SF(Inas_Mp(Dia_sec, thc_L), 3)
  '
  'Calculation for Second Moment of Area of Lower Main Column
  Ip = Fkb_SF(M_Ine * 2, 3)
  '
  'Calculation for Radius Gyration
  Rad_G = Fkb_SF(Rad_Gy(Dia_sec, thc_L), 3)
'
End Sub
')

Public Sub Calc_Fixload()                                       'Method for Calculate Fixload of Pole
'
'Calculation for Fixload of Straight Pole Type
  If typ = "Straight" Then
    'Calculation for Massa per Meter (kg/m)
    mass_m = Fkb_SF((fl_u(dia_L, thc_L)), 3)
    'Calculation for Massa pole after multiple with Length
    mass = Fkb_SF((fL_s(dia_L, thc_L, Length)), 3)
    'Calculation for Fixload per Meter (N/m)
    fld_m = Fkb_SF(mass_m * 9.81, 3)
    'Calculation for Fixload (N)
    fld = Fkb_SF(mass * 9.81, 3)

'Calculate Fixload of Taper Pole Type
  ElseIf typ = "Taper" Then
    'Calculation for Massa per Meter (kg/m)
    mass_m = Fkb_SF((FL_t_u(Dia_sec, dia_U, thc_L, thc_U)), 3)
    'Calculation for Massa pole after multiple with Length
    mass = Fkb_SF((FL_T(Dia_sec, dia_U, thc_L, thc_U, Length)), 3)
    'Calculation for Fixload per Meter (N/m)
    fld_m = Fkb_SF(mass_m * 9.81, 3)
    'Calculation for Fixload (N)
    fld = Fkb_SF(mass * 9.81, 3)
  End If
'
End Sub
')

Public Sub q_wp()                                               'Method for Calculate Wind Pressure of Pole
'
  'Calculation for Wind Pressure
  Dim Ds_air As Double
  '
  If D_st = 1 Then
    Ds_air = Act_comn(6)
    Vo = Sheet1.Range("D6")
    q_wpr = Fkb_SF(0.6 * Ds_air * Vo ^ 2, 3)
  ElseIf D_st = 2 Or D_st = 3 Then
    Ds_air = 1.23
    Vo = 60
    q_wpr = Fkb_SF(0.5 * Ds_air * Vo ^ 2, 4)
  ElseIf D_st = 4 Then
    Ds_air = 1.23
    Vo = 40
    q_wpr = Fkb_SF(0.5 * Ds_air * Vo ^ 2, 3)
  ElseIf D_st = 5 Then
    Ds_air = 1.23
    Vo = 50
    q_wpr = Fkb_SF(0.5 * Ds_air * Vo ^ 2, 3)
  ElseIf D_st = 6 Then
    kz = f_kz(z)
    Ds_air = Act_comn(6)
    Vo = Sheet1.Range("D21")
    q_wpr = Fkb_SF(0.6 * Ds_air * Vo ^ 2, 3)
    q_b_kz = q_wpr * 1.42 * kz
    If q_b_kz > 2350 Then
      q_wpr = Fkb_SF(q_b_kz, 3)
      q_wpr = Fkb_SF((q_wpr), 3)
    Else
      q_wpr = 2350
    End If
  End If
'
End Sub
')

Public Sub Calc_Cf()                                            'Method for Calculate Coefisien of Pole
'
  B_val_p = dia_L
  HBp = Length / (B_val_p * 0.001)
  '
  'Calculation for of nnC
  If D_st = 1 Or D_st = 6 Then
    If HBp <= 1 Then
      nc = 0.7
    ElseIf HBp > 1 And HBp < 8 Then
      nc = (2 / 7 * HBp + 0.67144)
    ElseIf HBp >= 8 Then
      nc = 0.9
    End If
  Else
    nc = 0.7
  End If
  '
  'Calculation for Cf
  cf = Fkb_SF(nc, 3)
  '
  If D_st = 1 Then
    kz = f_kz(z)
    cf = Fkb_SF(nc * kz, 3)
  End If
'
End Sub
')

Sub Calc_Area()                                                 'Method for Calculate Area of Pole
'
 'Calculation for Area of Straight Pole Type
  If typ = "Straight" Then
    Area = Fkb_SF(((dia_L * Length) / 10 ^ 6), 3)
  'Calculation for Area of Taper Pole Type
  ElseIf typ = "Taper" Then
    Area = Fkb_SF((((Dia_sec + dia_U) / 2) * Length) / 10 ^ 6, 3)
  End If
 '
  'Calculation for Area of Straight Pole Type
  If typ = "Straight" Then
    Area_mm = Fkb_SF((dia_L * Length), 3)
  'Calculation for Area of Taper Pole Type
  ElseIf typ = "Taper" Then
    Area_mm = Fkb_SF((((Dia_sec + dia_U) / 2) * Length), 3)
  End If
'
End Sub
')

Sub Calc_Winload()                                              'Method for Calculate Winload of Pole
'
  'Calculation for Winload
  WnL = Fkb_SF((q_wpr * cf * Area), 3)
'
End Sub
')

Public Sub Calc_Windload_XY(ByVal AoW As Double)
'
  'Calculate windload in X and Y axis
  WnL_X = Fkb_SF(WnL * RInt3(Cos(AoW + phi)), 3)
  WnL_Y = Fkb_SF(WnL * RInt3(Sin(AoW)), 3)
  '
  
End Sub
')

Public Sub Center_Point()                                       'Method for Calculate Center Point of Pole
'
  'Calculation for Center Point
  If typ = "Straight" Then
    Cp = Fkb_SF(Length / 2, 3)
  ElseIf typ = "Taper" Then
    Cp = Fkb_SF((Length / 3) * ((2 * dia_U + Dia_sec) / (dia_U + Dia_sec)), 3)
  End If
'
End Sub
')

Public Sub Length_Center_Point(ByVal h_pjt As Double)           'Method for Calculate Length Center Point of Pole
'
  'Calculation for Length Center Point
  Lcp = Fkb_SF(Cp + z - Length - h_pjt, 3)
'
End Sub
')

Public Sub Moment_Wl()                                          'Method for Calculate Moment due to Winload of Pole
'
  'Calculation for Moment Winload
  MwL = Fkb_SF(Lcp * WnL, 3)
'
End Sub
')

Public Sub Moment_Wl_XY()
'
  'Calculate Moment in X and Y axis
  MwL_X = Fkb_SF(Lcp * WnL_Y, 3)
  MwL_Y = Fkb_SF(Lcp * WnL_X, 3)
  '
  
End Sub
')

Sub Calc_SeismicLoad()                                          'Method for Calculate Seismic Load of Pole
'
  Seismic_Coefisien                                             'call Seismic_Coefisien
  '
  'Calculation for Seismic Load
  ELp = Fkb_SF(EQr * EQa * mass, 3)                             'ELp = Seismic Load of Pole
'
End Sub
')

Public Sub Moment_Seismic_Load()                                'Method for Calculate Moment due to Seismic Load of Pole
'
  'Calculation for Moment due to Horizontal Load Seismic Load
  MSL = Fkb_SF(Lcp * ELp, 3)
'
End Sub
')






























