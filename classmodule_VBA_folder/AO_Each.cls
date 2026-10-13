VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "AO_Each"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'Arm Object Properties
  Public nm As String                                                           'Property of Name
  Public typ As String                                                          'Property of Type
  Public Ar_F As Double                                                         'Property of Area Front
  Public Ar_S As Double                                                         'Property of Area Side
  Public mass As Double                                                         'Property of Massa (Kg)
  Public mass_u As Double                                                       'Property of Massa Per Unit (Kg)
  Public fld_u As Double                                                        'Property of Fixload Per Unit (N)
  Public fld As Double                                                          'Property Fixload (N)
  Public h_dst As Double                                                        'Property of Height Distance
  Public aof As Double                                                          'Property of Fix Angle
  Public nc As Double                                                           'Property of nnC
  Public qt As Integer                                                          'Property of Quantity
  Public z As Double                                                            'Property of Z or Height of arm
  Public T_Length As Double                                                     'Property of Total Length
  Public CH As Double                                                           'Property of Center of Height
'
'Calcu Arm Object Properties
  Public kz As Double                                                           'Property of Kz
  Public q_b_kz As Double
  Public q_wpr As Double                                                        'Property of Wind Pressure
  Public cf As Double                                                           'Property of Coefisien
  Public AoA  As Double                                                         'Property of Angle of attack
  Public sin_AoA As Double                                                      'Property of Sin(AoA)
  Public cos_AoA As Double                                                      'Property of Cos(AoA)
'
'Winload Properties
  Public wlf_U As Double                                                        'Property of Windload Area Front per unit
  Public wls_U As Double                                                        'Property of Windload Area Side per unit
  Public wl_f As Double                                                         'Property of Winload Area Front
  Public wl_s As Double                                                         'Property of Winload Area Side
  Public wld_f_U As Double                                                      'Property of Windload Area Front per unit with Direct Angle
  Public wld_s_U As Double                                                      'Property of Windload Area Side per unit with Direct Angle
  Public wld_f As Double                                                        'Property of Windload Area Front with Direct Angle
  Public wld_s As Double                                                        'Property of Windload Area Side with Direct Angle
  Public wld_U As Double                                                        'Property of Windload per unit with Direct Angle
  Public wld As Double                                                          'Property of Windload with Direct Angle
  Public wld_X As Double                                                        'Property of windload in X axis
  Public wld_Y As Double                                                        'Property of windload in Y axis
'
'Seismic Load Properties
  Public ELa As Double                                                          'Property of Seismic Load for Arm
  '
'Moment Properties
  Public M_fld As Double                                                        'Property of Moment due to Fixload at Pole
  Public M_wld As Double                                                        'Property of Moment due to Winload at Pole
  Public M_wld_p As Double                                                      'Property of Moment due to Winload at Pole
  Public M_wld_f As Double                                                      'Property of Moment due to Winload Front
  Public M_wld_s As Double                                                      'Property of Moment due to Winload Side
  Public M_wld_X As Double                                                      'property of Moment due to windloa in X axis
  Public M_wld_Y As Double                                                      'property of Moment due to windloa in Y axis
  '
  Public M_sl As Double                                                         'Property of Moment due to Horizontal Seismic Load
  Public M_slp As Double                                                        'Property of Moment due to Horizontal Seismic Load at Pole
  Public M_Fld_ang As Double                                                    'Property of Moment due to Fixload of Arm base on Directional Angle of Attack
  Public M_Fld_X As Double                                                      'Property of Moment due to Fixloadd of arm on pole with X axis
  Public M_Fld_Y As Double                                                      'Property of Moment due to Fixloadd of arm on pole with Y axis
'
'Torque Moment Properties
  Public M_Torq_wL As Double                                                    'Property of Moment Torque due to Winload of Arm
  Public M_Torq_wL_f As Double                                                  'Property of Moment Torque due to Winload Front of Arm
  Public M_Torq_wL_s As Double                                                  'Property of Moment Torque due to Winload Side of Arm
  Public M_Torq_sL As Double                                                    'Property of Moment Torque due to Seismic Load of Arm
')

Public Sub AO_Value(ByVal row_n As Integer)                                     'Method for Read Arm Object Value
'
  nm = Sheet1.Cells(row_n, 2).Value
  typ = Sheet1.Cells(row_n, 3).Value
  Ar_F = Sheet1.Cells(row_n, 4).Value
  Ar_S = Sheet1.Cells(row_n, 5).Value
  mass_u = Sheet1.Cells(row_n, 6).Value
  h_dst = Sheet1.Cells(row_n, 7).Value
  aof = Sheet1.Cells(row_n, 8).Value                                            'degree
  nc = Sheet1.Cells(row_n, 9).Value
  qt = Sheet1.Cells(row_n, 10).Value
  mass = Fkb_SF(mass_u * qt, 3)
  fld_u = Fkb_SF(mass_u * 9.81, 3)
  fld = Fkb_SF(fld_u * qt, 3)
'
End Sub
')

Public Sub Arm_as_AO(ByVal row_n As Integer)                                   'Method for define Z and Total Length of Arm Object based on Arm Height
'
  T_Length = Sheet1.Cells(row_n, 5).Value
  z = Sheet1.Cells(row_n, 7).Value
'
End Sub
')

Public Sub q_wp()                                                               'Method for Calculation Wind Pressudre of Arm
'
'Calculation for WindPressure
  anos = inos(3)
  fst = fstr(4)
  '
  Dim Ds_air As Double
  Dim Vo As Double
  '
  For j = 0 To anos - 1
    Dim each_A As Arm_Spec                                                      'Declare each_A as an object of the Arm_Spec class
    Set each_A = New Arm_Spec
    '
    each_A.Arm_Value fst + 50 * j                                              'call Arm_Value method, "fst + 100 * j" is the argument for procedure
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
      kz = f_kz(each_A.z)
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
  Next j
'
End Sub
')

Public Sub Calc_Cf()                                                            'Method for Calculation Coefisien of Arm
'
  anos = inos(3)
  fst = fstr(4)
  '
  For j = 0 To anos - 1
    Dim each_A As Arm_Spec                                                      'Declare each_A as an object of the Arm_Spec class
    Set each_A = New Arm_Spec
    '
    each_A.Arm_Value fst + 50 * j                                              'call Arm_Value method, "fst + 100 * j" is the argument for procedure
    '
    'Calculation for Coefisien
    cf = Fkb_SF(nc, 3)
    '
    If D_st = 1 Then
      kz = f_kz(each_A.z)
      cf = Fkb_SF(nc * kz, 3)
    End If
  Next j
'
End Sub
')

Public Sub Calc_Angle_of_Attack(ByVal AoW As Double)                            'Method for Fix Angle of Arm
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

Public Sub Calc_wld()                                                           'Method for Calculation Winload of Arm
'
  'Calculation for Winload Front and Side Per Unit
  wlf_U = Fkb_SF(Ar_F * cf * q_wpr, 3)
  wls_U = Fkb_SF(Ar_S * cf * q_wpr, 3)
  '
  'Calculation for Winload Front and Side
  wl_f = Fkb_SF(Ar_F * cf * q_wpr * qt, 3)
  wl_s = Fkb_SF(Ar_S * cf * q_wpr * qt, 3)
  '
  'Calculation for Winload Front per unit with Direct Angle
  wld_f_U = Fkb_SF((wlf_U * Abs(sin_AoA)), 3)
  '
  'Calculation for Winload Side per unit with Direct Angle
  wld_s_U = Fkb_SF((wls_U * Abs(cos_AoA)), 3)
  '
  'Calculation for Winload Front with Direct Angle
  wld_f = Fkb_SF((wl_f * Abs(sin_AoA)), 3)
  '
  'Calculation for Winload Side with Direct Angle
  wld_s = Fkb_SF((wl_s * Abs(cos_AoA)), 3)
  '
  'Calculation for Winload per Unit
  wld_U = Fkb_SF((wlf_U * Abs(sin_AoA)) + (wls_U * Abs(cos_AoA)), 3)
  '
  'Calculation for Winload
  wld = Fkb_SF((wl_f * Abs(sin_AoA)) + (wl_s * Abs(cos_AoA)), 3)
'
End Sub
')

Public Sub calc_wld_XY(ByVal AoW As Double)
'
  'Calculate Moment windload of AO in X and Y direction
  wld_X = Fkb_SF(wld * RInt3(Cos(AoW + phi)), 3)
  wld_Y = Fkb_SF(wld * RInt3(Sin(AoW)), 3)
  '
End Sub
')

Public Sub Moment_fld()                                                         'Method for Calculation Moment Fixload of Arm
'
  'Calculation for Moment of Fixload on Arm
  M_fld = Fkb_SF(fld * h_dst, 3)
'
End Sub
')

Public Sub Moment_wld()                                                         'Method for Calculation Moment Winload of Arm
'
  'Calculation for Moment of Winload on Arm
  M_wld = Fkb_SF(wl_f * h_dst, 3)
'
End Sub
')

Public Sub Center_Height(ByVal h_pjt As Double)                                 'Method for Calculation Center of Height
'
  'Calculation for Center of Height
  CH = z - h_pjt
  '
End Sub
')

Public Sub Moment_wld_P()                                                       'Method for Calculation Moment on Pole
'
  'Calculation for Moment Windload Front
  M_wld_f = Fkb_SF(CH * wl_f * Abs(sin_AoA), 3)
  '
  'Calculation for Moment Winload Side
  M_wld_s = Fkb_SF(CH * wl_s * Abs(cos_AoA), 3)
  '
  'Calculation for Moment of Winload on Pole
  M_wld_p = Fkb_SF(CH * wld, 3)
'
End Sub
')

Public Sub Moment_wld_XY()
'
  'Calculate Moment due to windload in X and Y axis
  M_wld_X = Fkb_SF(CH * wld_Y, 3)
  M_wld_Y = Fkb_SF(CH * wld_X, 3)
  '
End Sub

Sub Calc_SeismicLoad()                                                          'Method for Calculation Seismic Load
'
  Seismic_Coefisien                                                             'call Seismic_Coefisien
  '
  'Calculation for Seismic Load
  ELa = Fkb_SF(EQr * EQa * mass, 3)                                             'ELa = Seismic Load Arm
'
End Sub
')

Public Sub Moment_Seismic_Load()                                                'Method for Calculation Moment Seismic Load Arm
'
  'Calculation for Moment due to Seismic Load
  M_sl = Fkb_SF(ELa * h_dst, 3)
'
End Sub
')

Public Sub Moment_Seismic_LoadP()                                               'Method for Calculation Moment due to Horizontal Load Seismic Load at Pole
'
  'Calculation for Moment due to Horizontal Load Seismic Load at Pole
  M_slp = Fkb_SF(CH * ELa, 3)
'
End Sub
')

Public Sub Moment_fld_Angle()                                                   'Method for Calculation Moment Fixload of Arm base on Directional Angle of Attack
'
  'Calculation for Moment due to Fixload of Arm base on Directional Angle of Attack
   M_Fld_ang = Fkb_SF(fld * h_dst * cos_AoA, 3)
'
End Sub
')

Public Sub Moment_Fixload_XY()
'
  'Calculate moment due to fixload in XY axis
  M_Fld_X = Fkb_SF(fld * h_dst * RInt3(Sin(aof * (-1))), 3)
  M_Fld_Y = Fkb_SF(fld * h_dst * RInt3(Cos(aof)), 3)
  '
End Sub

Public Sub Torq_Moment_Windload()                                               'Method for Calculation Moment Torq due to Winload
'
  'Calculation for Torque Moment around the Main Pillar
  M_Torq_wL_f = Fkb_SF(Abs((wl_f * sin_AoA)) * h_dst * sin_AoA, 3)
  '
  M_Torq_wL_s = Fkb_SF(Abs((wl_s * cos_AoA)) * h_dst * sin_AoA, 3)
  '
  'Calculation for Torque Moment around the Main Pillar
  M_Torq_wL = Fkb_SF(M_Torq_wL_f + M_Torq_wL_s, 3)
  '
End Sub
')

Public Sub Torq_Moment_Seismic()                                                'Method for Calculation Moment Torq due to Seismic Load
'
  'Calculation for Torque Moment around the Main Pillar
  M_Torq_sL = Fkb_SF(ELa * h_dst * sin_AoA, 3)
  '
End Sub
')















































































