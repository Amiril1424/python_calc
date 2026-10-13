VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Arm_Part"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'=========================================================== Properties Collection ==============================================================================
'Collection Property for Total
  Public total_fls As Collection                                            'Property Collection of Total Fixload
  Public total_wls As Collection                                            'Property Collection of Total Winload
  Public total_sls As Collection                                            'Property Collection of Total Seismic Load
'
'Collection Property for Moment due to Fixload
  Public total_mfls As Collection                                           'Property Collection of Total Moment due to Fixload
  Public stress_mfls As Collection                                          'Property Collection of Stress Moment due to Fixload
  Public safety_val_mfls As Collection                                      'Property Collection of Safety Value Moment due to Fixload
  Public safety_rslt_mfls As Collection                                     'Property Collection of Safety Result Moment due to Fixload
  '
'Collection Property for Moment due to Winload
  Public total_Mwls As Collection                                           'Property Collection of Total Moment due to Winload
  Public stress_mwls As Collection                                          'Property Collection of Stress Moment due to Winload
  Public safety_val_mwls As Collection                                      'Property Collection of Safety Value Moment due to Winload
  Public safety_rslt_mwls As Collection                                     'Property Collection of Safety Result Moment due to Winload
  '
'Collection Property for Moment due to Seismic Load
  Public total_Msls As Collection                                           'Property Collection of Total Moment due to Seismic Load
  Public stress_msls As Collection                                          'Property Collection of Stress Moment due to Seismic Load
  Public safety_val_msls As Collection                                      'Property Collection of Safety Value Moment due to Seismic Load
  Public safety_rslt_msls As Collection                                     'Property Collection of Safety Result Moment due to Seismic Load
  '
'Collection Property for Moment Combine
  Public m_com_wl_fl_s As Collection                                        'Property Collection of Moment Combine when Windload and Fixload are applied
  Public m_com_sl_fl_s As Collection                                        'Property Collection of Moment Combine when Seismic Load and Fixload are applied
'
'================================================================== Properties =================================================================================
'Property for Total
  Public total_fl As Double                                                 'Property of Total Fixload
  Public total_wl As Double                                                 'Property of Total Winload
  Public total_sl As Double                                                 'Property of Total Seismic Load
  
'Property for Moment due to Fixload
  Public total_mfL As Double                                                'Property of Total Moment due to Fixload
  Public stress_MfL As Double                                               'Property of Stress Moment due to Fixload
  Public safety_val_mfl As Double                                           'Property of Safety Value Moment due to Fixload
  Public safety_rslt_mfl As String                                          'Property of Safety Result Moment due to Fixload
  '
'Property for Moment due to Winload
  Public total_mwl As Double                                                'Property of Total Moment due to Winload
  Public stress_MwL As Double                                               'Property of Stress Moment due to Winload
  Public safety_val_mwl As Double                                           'Property of Safety Value Moment due to Winload
  Public safety_rslt_mwl As String                                          'Property of Safety Result Moment due to Winload
  '
'Property for Moment due to Seismic Load
  Public Total_Msl As Double                                                'Property of Total Moment due to Seismic Load
  Public stress_MsL As Double                                               'Property of Stress Moment due to Seismic Load
  Public safety_val_msl As Double                                           'Property of Safety Value Moment due to Seismic Load
  Public safety_rslt_msl As String                                          'Property of Safety Result Moment due to Seismic Load
  '
'Property for Moment Combine
  Public m_com_wl_fl As Double                                              'Property of Moment Combine when Windload and Fixload are applied
  Public m_com_sl_fl As Double                                              'Property of Moment Combine when Seismic Load and Fixload are applied
')

Private Sub Class_Initialize()                                              'Method for Initialize Properties Collection
'Set Collection Total
 Set total_fls = New Collection                                             'Initialize Collection for Properties of Total Fixload
 Set total_wls = New Collection                                             'Initialize Collection for Properties of Total Winload
 Set total_sls = New Collection                                             'Initialize Collection for Properties of Total Seismic Load
 
'Set Collection Moment due to Fixload
  Set total_mfls = New Collection                                           'Initialize Collection for Properties of Total Moment due to Fixload
  Set stress_mfls = New Collection                                          'Initialize Collection for Properties of Stress Moment due to Fixload
  Set safety_val_mfls = New Collection                                      'Initialize Collection for Properties of Safety Value Moment due to Fixload
  Set safety_rslt_mfls = New Collection                                     'Initialize Collection for Properties of Safety Result Moment due to Fixload
  '
'Set Collection Moment due to Winload
  Set total_Mwls = New Collection                                           'Initialize Collection for Properties of Total Moment due to Winload
  Set stress_mwls = New Collection                                          'Initialize Collection for Properties of Stress Moment due to Winload
  Set safety_val_mwls = New Collection                                      'Initialize Collection for Properties of Safety Value Moment due to Winload
  Set safety_rslt_mwls = New Collection                                     'Initialize Collection for Properties of Safety Result Moment due to Winload
 '
'Set Collection Moment due to Seismic Load
  Set total_Msls = New Collection                                           'Initialize Collection for Properties of Total Moment due to Seismic Load
  Set stress_msls = New Collection                                          'Initialize Collection for Properties of Stress Moment due to Seismic Load
  Set safety_val_msls = New Collection                                      'Initialize Collection for Properties of Safety Value Moment due to Seismic Load
  Set safety_rslt_msls = New Collection                                     'Initialize Collection for Properties of Safety Result Moment due to Seismic Load
  '
'Set Collection Moment Combine
  Set m_com_wl_fl_s = New Collection                                        'Initialize Collection for Properties of Moment Combine when Windload and Fixload are applied
  Set m_com_sl_fl_s = New Collection                                        'Initialize Collection for Properties of Moment Combine when Seismic Load and Fixload are applied
'
End Sub
')

Public Sub Calc_Total_Fixload()                                             'Method for Calculation Total Fixload of Arm
  '
  anos = inos(3)
  fst = fstr(4)
  '
  Dim each_A As Arm_Spec                                                    'Declare each_A as an object of the Arm_Spec class
  Set each_A = New Arm_Spec
  '
  For j = 0 To anos - 1
    each_A.Arm_Value fst + 50 * j                                           'call Arm_Value method on the Arm_Spec class, "fst + 50 * i" is the argument for procedure
    each_A.Arm_Specification                                                'call Arm_Specification method on the Arm_Spec class
    '
    total_fl = 0                                                            'Initialize Total Fixload to zero
    For k = 0 To Aonos(j) - 1
      Dim each_Ao As AO_Each                                                'Declare each_AO as an object of the AO_Each class
      Set each_Ao = New AO_Each
      '
      each_Ao.AO_Value fst + 10 + k + 50 * j                                'call AO_Value method on the AO_Each class, "fst + 10 + k + 50 * j" is the argument for procedure
      '
      total_fl = total_fl + each_Ao.fld                                     'Calculate Total Fixload
    Next k
    '
    'Make collection
    total_fls.Add Fkb_SF(total_fl, 3)                                        'Add the Property of Total Fixload to the collection
  Next j
'
End Sub
')

Public Sub Calc_Total_Winload()                                             'Method for Calculation Total Winload of Arm
  '
  anos = inos(3)
  fst = fstr(4)
  '
  Dim each_A As Arm_Spec                                                    'Declare each_A as an object of the Arm_Spec class
  Set each_A = New Arm_Spec
  '
  For j = 0 To anos - 1
    each_A.Arm_Value fst + 50 * j                                           'call Arm_Value method on the Arm_Spec class, "fst + 50 * i" is the argument for procedure
    each_A.Arm_Specification                                                'call Arm_Specification method on the Arm_Spec class
    '
    total_wl = 0                                                            'Initialize Total Moment due to Winload to zero
    For k = 0 To Aonos(j) - 1
      Dim each_Ao As AO_Each                                                'Declare each_AO as an object of the AO_Each class
      Set each_Ao = New AO_Each
      '
      each_Ao.AO_Value fst + 10 + k + 50 * j                                'call AO_Value method on the AO_Each class, "fst + 10 + k + 50 * j" is the argument for procedure
      each_Ao.q_wp                                                          'call q_wp method on the AO_Each class
      each_Ao.Calc_Cf                                                       'call Calc_Cf method on the AO_Each class
      each_Ao.Calc_wld                                                      'call Calc_wld method on the AO_Each class
      '
      total_wl = total_wl + each_Ao.wl_f                                    'Calculate Total Winload
    Next k
    '
    'Make collection
    total_wls.Add Fkb_SF(total_wl, 3)                                       'Add the Property of Total Winload to the collection
  Next j
'
End Sub
')

Public Sub Calc_Total_Seismicload()                                         'Method for Calculation Total Seismic Load of Arm
  '
  anos = inos(3)
  fst = fstr(4)
  '
  Dim each_A As Arm_Spec                                                    'Declare each_A as an object of the Arm_Spec class
  Set each_A = New Arm_Spec
  '
  For j = 0 To anos - 1
    each_A.Arm_Value fst + 50 * j                                           'call Arm_Value method on the Arm_Spec class, "fst + 50 * j" is the argument for procedure
    each_A.Arm_Specification                                                'call Arm_Specification method on the Arm_Spec class
    '
    total_sl = 0                                                            'Initialize total seismic load to zero
    For k = 0 To Aonos(j) - 1
      Dim each_Ao As AO_Each                                                'Declare each_AO as an object of the AO_Each class
      Set each_Ao = New AO_Each
      '
      each_Ao.AO_Value fst + 10 + k + 50 * j                                'call AO_Value method on the AO_Each class, "fst + 10 + k + 50 * j" is the argument for procedure
      each_Ao.Calc_SeismicLoad                                              'call Calc_SeismicLoad method on the AO_Each class
      '
      total_sl = total_sl + each_Ao.ELa                                     'Calculate Total Seismic Load
    Next k
      '
    'Make collection
    total_sls.Add Fkb_SF(total_sl, 3)                                       'Add the Property of Total Seismic Load to the collection
  Next j
'
End Sub
')

Public Sub Arm_Strength_Inspect_Mfl()                                       'Method for Calculation Arm Strength Inspection Moment due to Fixload of Arm
'
  anos = inos(3)
  fst = fstr(4)
  '
  Dim each_A As Arm_Spec                                                    'Declare each_A as an object of the Arm_Spec class
  Set each_A = New Arm_Spec
  '
  For j = 0 To anos - 1
    each_A.Arm_Value fst + 50 * j                                           'call Arm_Value method on the Arm_Spec class, "fst + 50 * i" is the argument for procedure
    each_A.Arm_Specification                                                'call Arm_Specification method on the Arm_Spec class
    '
    total_mfL = 0                                                           'Initialize Total Moment due to Fixload to zero
    For k = 0 To Aonos(j) - 1
      Dim each_Ao As AO_Each                                                'Declare each_AO as an object of the AO_Each class
      Set each_Ao = New AO_Each
      '
      each_Ao.AO_Value fst + 10 + k + 50 * j                                'call AO_Value method on the AO_Each class, "fst + 10 + k + 50 * j" is the argument for procedure
      each_Ao.Moment_fld                                                    'call Moment_fld_A method on the AO_Each class
      '
      total_mfL = total_mfL + each_Ao.M_fld                                 'Calculate Total Moment due to Fixload
    Next k
    '
    total_mfL = Fkb_SF(total_mfL, 3)
    '
    stress_MfL = Fkb_SF(total_mfL / each_A.sec_mod, 3)                      'Calculate Stress Moment due to Fixload
    safety_val_mfl = Fkb_SF(stress_MfL / each_A.f_b, 3)                     'Calculate Safety Value Moment due to Fixload
    '
    If safety_val_mfl <= 1 Then                                             'Safety Result, if Safety Value <= 1 the result is OK else NG
      safety_rslt_mfl = "O.K"
    Else
      safety_rslt_mfl = "N.G"
    End If
    '
    'Make collection
    total_mfls.Add total_mfL                                                'Add the Property of Total Moment due to Fixload to the collection
    stress_mfls.Add stress_MfL                                              'Add the Property of Stress Moment due to Fixload to the collection
    safety_val_mfls.Add safety_val_mfl                                      'Add the Property of Safety Value Moment due to Fixload to the collection
    safety_rslt_mfls.Add safety_rslt_mfl                                    'Add the Property of Safety Result Moment due to Fixload to the collection
  Next j
'
End Sub
')

Public Sub Arm_Strength_Inspect_Mwl()                                        'Method for Calculate Arm Strength Inspection Moment due to Winload of Arm
'
  anos = inos(3)
  fst = fstr(4)
  '
  Dim each_A As Arm_Spec                                                    'Declare each_A as an object of the Arm_Spec class
  Set each_A = New Arm_Spec
  '
  For j = 0 To anos - 1
    each_A.Arm_Value fst + 50 * j                                           'call Arm_Value method on the Arm_Spec class, "fst + 50 * i" is the argument for procedure
    each_A.Arm_Specification                                                'call Arm_Specification method on the Arm_Spec class
    '
    total_mwl = 0                                                           'Initialize Total Moment due to Winload to zero
    For k = 0 To Aonos(j) - 1
      Dim each_Ao As AO_Each                                                'Declare each_AO as an object of the AO_Each class
      Set each_Ao = New AO_Each
      '
      each_Ao.AO_Value fst + 10 + k + 50 * j                                'call AO_Value method on the AO_Each class, "fst + 10 + k + 50 * j" is the argument for procedure
      each_Ao.q_wp                                                          'call q_wp method on the AO_Each class
      each_Ao.Calc_Cf                                                       'call Calc_Cf method on the AO_Each class
      each_Ao.Calc_wld                                                      'call Calc_wld method on the AO_Each class
      each_Ao.Moment_wld                                                    'call Moment_wld_A method on the AO_Each class
      '
      total_mwl = total_mwl + each_Ao.M_wld                                 'Calculate Total Moment due to Winload
    Next k
    '
    total_mwl = Fkb_SF(total_mwl, 3)
    '
    'Make collection
    total_Mwls.Add total_mwl                                                'Add the Property of Total Moment due to Winload to the collection
   '
    For i = 1 To total_Mwls.Count
      m_com_wl_fl = Fkb_SF(Sqr(total_mfls.Item(i) ^ 2 + total_Mwls.Item(i) ^ 2), 3)      'Calculate Moment Combine when Windload and Fixload are applied
    Next i
    
    stress_MwL = Fkb_SF(m_com_wl_fl / each_A.sec_mod, 3)                     'Calculate Stress Moment due to Winload
      '
    safety_val_mwl = Fkb_SF(stress_MwL / each_A.s_fb, 3)                     'Calculate Safety Value Moment due to Winload
    '
    If safety_val_mwl <= 1 Then                                              'Safety Result, if Safety Value <= 1 the result is OK else NG
      safety_rslt_mwl = "O.K"
    Else
      safety_rslt_mwl = "N.G"
    End If
    '
    'Make collection
    m_com_wl_fl_s.Add m_com_wl_fl                                            'Add the Property of Moment Combine when Windload and Fixload to the collection
    stress_mwls.Add stress_MwL                                               'Add the Property of Stress Moment due to Winload to the collection
    safety_val_mwls.Add safety_val_mwl                                       'Add the Property of Safety Value Moment due to Winload to the collection
    safety_rslt_mwls.Add safety_rslt_mwl                                     'Add the Property of Safety Result Moment due to Fixload to the collection
  Next j
'
End Sub
')

Public Sub Arm_Strength_Inspect_Msl()                                        'Method for Calculate Arm Strength Inspection Moment due to Seismic Load of Arm
'
  anos = inos(3)
  fst = fstr(4)
  '
  Dim each_A As Arm_Spec                                                    'Declare each_A as an object of the Arm_Spec class
  Set each_A = New Arm_Spec
  '
  For j = 0 To anos - 1
    each_A.Arm_Value fst + 50 * j                                           'call Arm_Value method on the Arm_Spec class, "fst + 50 * j" is the argument for procedure
    each_A.Arm_Specification                                                'call Arm_Specification method on the Arm_Spec class
    '
    Total_Msl = 0                                                           'Initialize total moment seismic load to zero
    For k = 0 To Aonos(j) - 1
      Dim each_Ao As AO_Each                                                'Declare each_AO as an object of the AO_Each class
      Set each_Ao = New AO_Each
      '
      each_Ao.AO_Value fst + 10 + k + 50 * j                                'call AO_Value method on the AO_Each class, "fst + 10 + k + 50 * j" is the argument for procedure
      each_Ao.Calc_SeismicLoad                                              'call Calc_SeismicLoad method on the AO_Each class
      each_Ao.Moment_Seismic_Load                                           'call Moment_Seismic_Load method on the AO_Each class
      '
      Total_Msl = Total_Msl + each_Ao.M_sl                                  'Calculate Total Moment due to Seismic Load
    Next k
    '
    Total_Msl = Fkb_SF(Total_Msl, 3)
    '
    'Make collection
    total_Msls.Add Total_Msl                                                'Add the Property of Total Moment due to Seismic Load to the collection
    '
    For i = 1 To total_Msls.Count
      m_com_sl_fl = Fkb_SF(Sqr(total_Msls.Item(i) ^ 2 + total_mfls.Item(i) ^ 2), 3)     'Calculate Moment Combine when Windload and Fixload are applied
    Next i
    '
    stress_MsL = Fkb_SF(m_com_sl_fl / each_A.sec_mod, 3)                                'Calculate Stress Moment due to Seismic Load
    '
    safety_val_msl = Fkb_SF(stress_MsL / each_A.s_fb, 3)                                'Calculate Safety Value Moment due to Seismic Load
    '
    If safety_val_msl <= 1 Then                                              'Safety Result, if Safety Value <= 1 the result is OK else NG
      safety_rslt_msl = "O.K"
    Else
      safety_rslt_msl = "N.G"
    End If
    '
    'Make collection
    m_com_sl_fl_s.Add m_com_sl_fl                                           'Add the Property of Moment Combine when Seismic Load and Fixload to the collection
    stress_msls.Add stress_MsL                                              'Add the Property of Stress Moment due to Seismic Load to the collection
    safety_val_msls.Add safety_val_msl                                      'Add the Property of Safety Value Moment due to Seismic Load to the collection
    safety_rslt_msls.Add safety_rslt_msl                                    'Add the Property of Safety Result Moment due to Seismic Load to the collection
  Next j
'
End Sub
')



















































