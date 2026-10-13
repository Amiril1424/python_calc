VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "DO_each"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'Direct Object Properties
  Public nm As String                                           'Property of Name
  Public typ As String                                          'Property of Type
  Public Ar_F As Double                                         'Property of  Area Front
  Public Ar_S As Double                                         'Property of Area Side
  Public fL As Double                                           'Property of Weight
  Public fl_n As Double                                         'Property of weight in Newton
  Public z As Double                                            'Property of Height
  Public nc As Double                                           'Property of nnC
  Public qt As Integer                                          'Property of Quantity
  Public aof As Double                                          'Property of Fix Angle
  Public CH As Double                                           'Property of Center of Height
'
'Calcu Direct Object Properties
  Public fld As Double                                          'Property of Fixload in Kg
  Public fld_n As Double                                        'Property of Fixload in Newton
'
  Public kz As Double                                           'Property of Kz
  Public q_b_kz As Double
  Public q_wpr As Double                                        'Property of Wind Pressure
  Public cf As Double                                           'Property of Coefisien
  Public AoA  As Double                                         'Property of Angle of Atack
  Public sin_AoA As Double                                      'Property of Sin(AoA)
  Public cos_AoA As Double                                      'Property of Cos(AoA)
'
'Winload Properties
  Public wlf_U As Double                                        'Property of Windload Area Front per unit
  Public wls_U As Double                                        'Property of Windload Area Side per unit
  Public wl_f As Double                                         'Property of Winload Area Front
  Public wl_s As Double                                         'Property of Winload Area Side
  Public wld_U As Double                                        'Property of Windload per unit with Direct Angle
  Public wld As Double                                          'Property of Windload with Direct Angle
  Public wld_X As Double                                        'property of windload in direction X
  Public wld_Y As Double                                        'Property of windload in direction Y
'
'Seismicload Properties
  Public ELd As Double                                          'Property of Seismic Load for DO
'
'Moment Winload Properties
  Public M_wld_f As Double                                      'Property of Moment due to Winload Front
  Public M_wld_s As Double                                      'Property of Moment due to Winload Side
  Public M_wld As Double                                        'Property of Moment due to Winload
  Public M_wld_X As Double                                      'Property of Moment due to Winload X axis
  Public M_wld_Y As Double                                      'Property of Moment due to Winload Y axis
  '
'Moment Seismic Properties
  Public MSL As Double                                          'Property of Moment due to Horizontal Seismic Load
')

Public Sub Do_Value(ByVal row_n As Integer)                     'Method for Read Value of Direct Object
'
  nm = Sheet1.Cells(row_n, 2).Value
  typ = Sheet1.Cells(row_n, 3).Value
  Ar_F = Sheet1.Cells(row_n, 4).Value
  Ar_S = Sheet1.Cells(row_n, 5).Value
  fL = Sheet1.Cells(row_n, 6).Value
  z = Sheet1.Cells(row_n, 7).Value
  nc = Sheet1.Cells(row_n, 8).Value
  qt = Sheet1.Cells(row_n, 9).Value
  aof = Sheet1.Cells(row_n, 10).Value                           'degree
  fld = Fkb_SF(fL * qt, 3)
  fl_n = Fkb_SF(fL * 9.81, 3)
  fld_n = Fkb_SF(fl_n * qt, 3)
'
End Sub
')

Public Sub q_wp()                                               'Method for Calculation Wind Pressure of Direct Object
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

Public Sub Calc_Cf()                                            'Method for Calculation Coefisien of Direct Object
'
  'Calculation for Coefisien
  cf = Fkb_SF(nc, 3)
  '
  If D_st = 1 Then
    kz = f_kz(z)
    cf = Fkb_SF(nc * kz, 3)
  End If
'
End Sub
')

Public Sub Calc_Angle_of_Atack(ByVal AoW As Double)                   'Method for Calculation Angle of Attack of Direct Object
'
  'Calculation for angle of atack
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

Public Sub Calc_wld()                                           'Method for Calculation Winload of Direct Object
'
  'Calculation for Winload Front and Side Per Unit
  wlf_U = Fkb_SF(Ar_F * cf * q_wpr, 3)
  wls_U = Fkb_SF(Ar_S * cf * q_wpr, 3)
  '
  'Calculation for Winload Front and Side
  wl_f = Fkb_SF(Ar_F * cf * q_wpr * qt, 3)
  wl_s = Fkb_SF(Ar_S * cf * q_wpr * qt, 3)
  '
  If typ = "Directional" Then
    'Calculation for Winload per Unit with Direct Angle
    wld_U = Fkb_SF((wlf_U * Abs(sin_AoA)) + (wls_U * Abs(cos_AoA)), 3)
    '
    'Calculation for Winload with Direct Angle
    wld = Fkb_SF((wl_f * Abs(sin_AoA)) + (wl_s * Abs(cos_AoA)), 3)
    '
  ElseIf typ = "Omni" Then
    '
    'Calculation for Winload per Unit, because of Omni, windload side same with windload front
    wld_U = wlf_U
    '
    'Calculation for Winload because of Omni, windload side same with windload front
    wld = wl_f
  End If
'
End Sub
')

Public Sub calc_wld_XY(ByVal AoW As Double)
'
  'Calculate windload with X and Y axis
  wld_X = Fkb_SF(wld * RInt3(Cos(AoW + phi)), 3)
  wld_Y = Fkb_SF(wld * RInt3(Sin(AoW)), 3)
  '
End Sub
')

Sub Calc_SeismicLoad()                                          'Method for Calculation Seismic Load of Direct Object
'
  Seismic_Coefisien                                             'call Seismic_Coefisien
  '
  'Calculation for Seismic Load
  ELd = Fkb_SF((EQr * EQa * fld), 3)                            'ELd = Seismic Load Direct Object
  '
End Sub
')

Public Sub Center_Height(ByVal h_pjt As Double)                 'Method for Calculation Center Height of Direct Object
'
  'Calculation for Center of Height
  CH = z - h_pjt
  '
End Sub
')

Public Sub Moment_wld()                                         'Method for Calculation Moment due to Winload of Direct Object
'
  If typ = "Directional" Then
    'Calculation for Moment Windload Front
    M_wld_f = Fkb_SF(CH * wl_f * Abs(sin_AoA), 3)
    '
    'Calculation for Moment Winload Side
    M_wld_s = Fkb_SF(CH * wl_s * Abs(cos_AoA), 3)
    '
    'Calculation for Moment Winload
    M_wld = Fkb_SF(CH * wld, 3)
   '
  ElseIf typ = "Omni" Then
   '
   'Calculation for Moment Windload Front
    M_wld_f = Fkb_SF(CH * wl_f, 3)
    '
    'Calculation for Moment Winload Side
    M_wld_s = Fkb_SF(CH * wl_s, 3)
    '
    'Calculation for Moment Winload
    M_wld = Fkb_SF(CH * wld, 3)
  End If
'
End Sub
')

Public Sub Moment_wld_XY()
'
  'Calculate moment with X and Y axis
  M_wld_X = Fkb_SF(CH * wld_Y, 3)
  M_wld_Y = Fkb_SF(CH * wld_X, 3)
  '
End Sub
')

Public Sub Moment_Seismic_Load()                                'Method for Calculation Moment due to Seismic Load of Direct Object
'
  'Calculation for Moment due to Horizontal Load Seismic Load
  MSL = Fkb_SF(CH * ELd, 3)
'
End Sub
')






































