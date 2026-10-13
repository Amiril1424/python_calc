VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "OHW_each"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'OHW Properties
  Public fl_m As Double                                     'Property of Weight in Kg/m
  Public fld_m As Double                                    'Property of Weight in N/m
  Public Dia As Double                                      'Property of Diameter
  Public z As Double                                        'Property of Height
  Public span As Double                                     'Property of Span
  Public span_m As Double                                   'Property of Span in meter
  Public sag_rt As Double                                   'Property of Sagging Ratio
  Public nc As Double                                       'Property of Coefisien
  Public aof As Double                                      'Property of Fix Angle
  Public AoV As Double                                      'Property of Vertical Angle
  Public nm As String                                       'Property of Name
  Public cos_Aov As Double                                  'Property of Cos Vertical Angle
'
'Calcu OHW Properties
  Public kz As Double                                       'Property of Kz
  Public q_b_kz As Double
  Public q_wpr As Double                                    'Property of Wind Pressure
  Public cf As Double                                       'Property of Coefisien
  Public AoA As Double                                      'Property of Angle of Atack
  Public sin_AoA As Double                                  'Property of sin AoA
  Public cos_AoA As Double                                  'Property of cos AoA
  Public Ar As Double                                       'Property of Area
  Public Ar_Dir As Double                                   'Property of Area with Direction
  Public fL As Double                                       'Property of Fixload OHW in Kg
  Public fld As Double                                      'Property of Fixload OHW in Newton
  Public CH As Double                                       'Property of Center of Height
  '
'Winload Properties
  Public wld As Double                                      'Property of Windload OHW
  Public wld_Dir As Double                                  'Property of Windload OHW with Direction
  Public M_wld As Double                                    'Property of Moment Due to Windload
  Public wld_X As Double                                    'Property of Moment du to Winload X axis
  Public wld_Y As Double                                    'Property of Moment due to Winload Y axis
  Public M_wl_X As Double                                   'Property of Moment Due to Windload X axis
  Public M_wl_Y As Double                                   'Property of Moment Due to Windload Y axis
'
'Seismic Load Properties
  Public ELw As Double                                      'Property of Seismic Load for OHW
    '
'Moment Seismic Load Properties
  Public MSL As Double                                      'Property of Moment due to Horizontal Seismic Load
'
'Tension Winload Properties
  Public wlF_c As Double                                    'Property of Fixload, Windload Combination
  Public wlF_c0 As Double                                   'Property of Fixload, Windload Combination in 0 degree --> for Fixload Pw
  Public wlF_c90 As Double                                  'Property of Fixload, Windload Combination in 90 degree --> for Straight Pw
  Public wlF_c45 As Double                                  'Property of Fixload, Windload Combination in 45 degree --> for Oblique Pw
  '
  Public Tns_wL As Double                                   'Property of Tension due to Windload
  Public Tns_wL0 As Double                                  'Property of Tension due to Windload in 0 degree --> for Tension due to Fixload
  Public Tns_wL90 As Double                                 'Property of Tension due to Windload in 90 degree --> for Tension due to Straight wind
  Public Tns_wL45 As Double                                 'Property of Tension due to Windload in 45 degree --> for Tension due to Oblique wind
  Public Tns_wL_X As Double                                 'Property of Tension due to windload in X axis
  Public Tns_wL_Y As Double                                 'Property of Tension due to windload in Y axis
  '
  Public M_Tns_wL As Double                                 'Property of Moment Tension due to Windload
  Public M_Tns_wL_ang As Double                             'Property of Moment Tension after calculate with angle
  Public M_Tns_wL_X As Double                               'Property of Moment Tension due to windload in X axis
  Public M_Tns_wL_Y As Double                               'Property of Moment Tension due to windload in Y axis
'
'Tension Seismic Load Properties
  Public Tns_sL As Double                                   'Property of Tension due to Seismic Load
  Public M_Tns_sL As Double                                 'Property of Moment Tension due to Seismic Load
  Public M_Tns_sL_ang                                       'Property of Moment Tension due to Seismic Load after calculate with angle
')

Public Sub OHW_Value(ByVal row_n As Integer)                'Method for Read Value of OHW
'
  nm = Sheet1.Cells(row_n, 2).Value
  fl_m = Sheet1.Cells(row_n, 3).Value
  Dia = Sheet1.Cells(row_n, 4).Value
  z = Sheet1.Cells(row_n, 5).Value
  span = Sheet1.Cells(row_n, 6).Value
  sag_rt = Sheet1.Cells(row_n, 7).Value
  nc = Sheet1.Cells(row_n, 8).Value
  aof = Sheet1.Cells(row_n, 9).Value
  AoV = Sheet1.Cells(row_n, 10).Value
  '
  'For calculate COS
  cos_Aov = RInt3(Cos((AoV / 180) * phi))
'
End Sub
')

Public Sub Calc_Fixload()                                   'Method for Calculate Fixload of OHW
'
  'Calculation for Fixload (N)
  fld_m = fl_m * 9.81
  span_m = span / 1000
  fL = Fkb_SF(fl_m * (span / 2000) / Cos((AoV / 180) * phi), 3)
  fld = Fkb_SF(fL * 9.81, 3)
'
End Sub
')


Public Sub q_wp()                                           'Method for Calculate Wind Pressure of OHW
'
  'Calculation for Wind Pressure
  Dim Ds_air As Double
  Dim Vo As Double
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

Public Sub Calc_Cf()                                        'Method for Calculate Coefisien of OHW
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

Public Sub Calc_Angle_of_Attack(ByVal AoW As Double)        'Method for Fix Angle of Arm
'
  'Calculation for Angle of Attack
  AoA = ((aof / 180) * phi - AoW)
  '
  'Result of sin and cos cannot use Sig Fig, because sometime value of cos (radian of 90) = 0.000000000000157, it is not read as 0, but read as the result
  'Calculation for Sin AoA
  sin_AoA = RInt3(Sin(AoA))
  '
  'Calculation for Cos AoA
  cos_AoA = RInt3(Cos(AoA))
'
End Sub
')

Public Sub Calc_Area()                                      'Method for Calculate Area of OHW
'
  'Calculation for Area
  Ar = Fkb_SF((Dia / 1000 * span / 2000) / Cos((AoV / 180) * phi), 3)
'
End Sub
')

Public Sub Calc_wld()                                       'Method for Calculate Winload of OHW
'
  'Calculation for Winload
  wld = Fkb_SF(Ar * cf * q_wpr, 3)
  '
  'Calculation for Winload with Direction
  wld_Dir = Fkb_SF(Ar * cf * q_wpr * Abs(sin_AoA), 3)
'
End Sub
')

Public Sub calc_wld_XY(ByVal AoW As Double)
'
  'Calculate windload in X and Y axis
  wld_X = Fkb_SF(wld_Dir * RInt3(Cos(AoW + phi)), 3)
  wld_Y = Fkb_SF(wld_Dir * RInt3(Sin(AoW)), 3)
  '
End Sub
')

Public Sub Center_Height(ByVal h_pjt As Double)             'Method for Calculate Center Height of OHW
'
  'Calculation for Center of Height
  CH = z - h_pjt
  '
End Sub
')

Public Sub Moment_wld()                                     'Method for Calculate Moment due to Winload of OHW
'
  'Calculation for Moment due to Winload
  M_wld = Fkb_SF(CH * wld * Abs(sin_AoA), 3)
'
End Sub
')

Public Sub Moment_wld_XY()
'
  'Calculate Moment in X and Y axis
  M_wl_X = Fkb_SF(CH * wld_Y, 3)
  M_wl_Y = Fkb_SF(CH * wld_X, 3)
  '
End Sub
')

Public Sub Calc_SeismicLoad()                               'Method for Calculate Seismic Load of OHW
'
  Seismic_Coefisien                                         'call Seismic_Coefisien
  '
  'Calculation for Seismic Load
  ELw = Fkb_SF(EQr * EQa * fL, 3)                           'ELw = Seismic Load OHW
  '
End Sub
')

Public Sub Moment_Seismic_Load()                            'Method for Calculate Moment due to Seismic Load of OHW
'
  'Calculation for Moment due to Horizontal Load Seismic Load
  MSL = Fkb_SF(CH * ELw, 3)
'
End Sub
')

Public Sub Calc_Pressure_Wind()                             'Method for Calculate Pressure Wind of OHW
'
  'Calculation for Winload and Fixload combine of OHW
  wlF_c = Fkb_SF(Sqr(fld_m ^ 2 + (Fkb_SF(q_wpr * cf * (Dia / Cos((AoV / 180)) / 1000), 3) * sin_AoA) ^ 2), 4)
  '
  'calculate for reporting only in OHW page
  wlF_c0 = Fkb_SF(Sqr(fld_m ^ 2 + (Fkb_SF(q_wpr * cf * (Dia / Cos((AoV / 180)) / 1000) * Sin(0), 3)) ^ 2), 4)
  wlF_c90 = Fkb_SF(Sqr(fld_m ^ 2 + (Fkb_SF(q_wpr * cf * (Dia / Cos((AoV / 180)) / 1000) * Sin(phi / 2), 3)) ^ 2), 4)
  wlF_c45 = Fkb_SF(Sqr(fld_m ^ 2 + (Fkb_SF(q_wpr * cf * (Dia / Cos((AoV / 180)) / 1000) * Sin(phi / 4), 3)) ^ 2), 4)
  '
'
End Sub
')

Public Sub Calc_Tension_wind()                              'Method for Calculate Tension due to Winload of OHW
'
  'Calculation for Tension due to Winload
  Tns_wL = Fkb_SF((wlF_c * (span / 1000) ^ 2) / (8 * (span / 1000) * (sag_rt / 100)), 3)
  '
  'calculate for reporting only in OHW page
  Tns_wL0 = Fkb_SF((wlF_c0 * (span / 1000) ^ 2) / (8 * (span / 1000) * (sag_rt / 100)), 3)
  Tns_wL90 = Fkb_SF((wlF_c90 * (span / 1000) ^ 2) / (8 * (span / 1000) * (sag_rt / 100)), 3)
  Tns_wL45 = Fkb_SF((wlF_c45 * (span / 1000) ^ 2) / (8 * (span / 1000) * (sag_rt / 100)), 3)
  '
End Sub
')

Public Sub Calc_Tension_Wind_XY()
'
  Tns_wL_X = Fkb_SF(Tns_wL * RInt3(Cos(aof)), 3)
  Tns_wL_Y = Fkb_SF(Tns_wL * RInt3(Sin(aof + phi)), 3)
  '
End Sub
')

Public Sub Moment_Tension_wind()                            'Method for Calculate Moment Tension due to Winload of OHW
'
  'Calculation for Moment Tension due to Winload
'  M_Tns_wL = Fkb_SF(Tns_wL * CH, 3)
  '
  'Calculation for Moment Tension after Calculate with Angle
  M_Tns_wL_ang = Fkb_SF(Tns_wL * CH * cos_AoA, 3)
'
End Sub
')

Public Sub Moment_tension_wind_XY()
'
  'Calculate Moment Tension in X and Y direction
  M_Tns_wL_X = Fkb_SF(Tns_wL_Y * CH, 3)
  M_Tns_wL_Y = Fkb_SF(Tns_wL_X * CH, 3)
  '
End Sub
')

Public Sub Calc_Tension_SeismicLoad()                       'Method for Calculate Tension due to Seismic Load of OHW
'
  'Calculation for Tension due to seismic Load
  Tns_sL = Fkb_SF(((fld_m / Cos((AoV / 180))) * (span / 1000) ^ 2) / (8 * (span / 1000) * (sag_rt / 100)), 3)
'
End Sub
')

Public Sub Moment_Tension_SeismicLoad()                     'Method for Calculate Moment due to Seismic Load of OHW
'
  'Calculation for Moment Tension due to seismic Load
'  M_Tns_sL = Fkb_SF(Tns_sL * CH, 3)
  '
  'Calculation for Moment Tension after Calculate with Angle
  M_Tns_sL_ang = Fkb_SF(Tns_sL * CH * cos_AoA, 3)
'
End Sub









