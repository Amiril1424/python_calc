VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Arm_Kmpl"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'================================================================ Properties Collection ========================================================================================================
  Public arm_s As Collection                                                        'Collection for Arm Properties After Joint
  Public n_As As Collection                                                         'Property Collection for Number Index of Arm Each Section
  '
  Public total_fls As Collection                                                    'Collection for Total Fixload Properties
  Public total_wls As Collection                                                    'Collection for Total Winload Properties
  Public total_wlXs As Collection
  Public total_wlYs As Collection
  '
  Public total_sls As Collection                                                    'Collection for Total Seismic Load Properties
  
  Public total_mfls As Collection                                                   'Collection for Total Moment Fixload base on Directional Angle of Attack Properties
  Public total_mfl_Xs As Collection
  Public total_mfl_Ys As Collection
  '
  Public total_Mwls As Collection                                                   'Collection for Total Moment Winload base on Directional Angle of Attack Properties
  Public total_MwL_Xs As Collection
  Public total_MwL_Ys As Collection
  '
  Public total_Msls As Collection                                                   'Collection for Total Moment Seismic Load base on Directional Angle of Attack Properties
  Public Total_Mtorq_wL_s As Collection                                             'Collection for Total Moment Torsional due to Winload base on Directional Angle of Attack Properties
  Public total_Mtorq_sL_s As Collection                                             'Collection for Total Moment Torsional due to Seismic Load base on Directional Angle of Attack Properties
  '
'====================================================================== Properties =============================================================================================================
  Public n_A As Long                                                                'Property Number Index of Arm Each Section
  '
  Public fl_sum As Double                                                           'Property of Total Fixload
  Public wl_sum As Double                                                           'Property of Total Winload
  Public wlX_sum As Double
  Public wlY_sum As Double
  '
  Public sl_sum As Double                                                           'Property of Total Seismicload
  '
  Public mfl_ang_sum As Double                                                      'Property of Total Moment Fixload base on Directional Angle of Attack
  Public mfl_X_sum As Double
  Public mfl_Y_sum As Double
  '
  Public mwl_ang_sum As Double                                                      'Property of Total Moment Winload base on Directional Angle of Attack
  Public mwl_X_sum As Double
  Public mwl_Y_sum As Double
  '
  Public msl_ang_sum As Double                                                      'Property of Total Moment Seismic Load base on Directional Angle of Attack
  Public mtorq_wL As Double                                                         'Property of Total Moment Torsional due to Winload base on Directional Angle of Attack
  Public Mtorq_sL As Double                                                         'Property of Total Moment Torsional due to Seismic Load base on Directional Angle of Attack
')

Private Sub Class_Initialize()                                                      'Method for Initialize Properties Collection
'
  Set arm_s = New Collection                                                        'Initialize Collection for Arm Property
  Set n_As = New Collection                                                         'Initialize Property Collection for Number Index of Arm Each Section Property
  '
  Set total_fls = New Collection                                                    'Initialize Collection for Total Fixload Property
  Set total_wls = New Collection                                                    'Initialize Collection for Total Winload Property
  Set total_wlXs = New Collection
  Set total_wlYs = New Collection
  '
  Set total_sls = New Collection                                                    'Initialize Collection for Total Seismic Load Property
  '
  Set total_mfls = New Collection                                                   'Initialize Collection for Total Moment Fixload base on Directional Angle of Attack Property
  Set total_mfl_Xs = New Collection
  Set total_mfl_Ys = New Collection
  '
  Set total_Mwls = New Collection                                                   'Initialize Collection for Total Moment Winload base on Directional Angle of Attack Property
  Set total_MwL_Xs = New Collection
  Set total_MwL_Ys = New Collection
  '
  Set total_Msls = New Collection                                                   'Initialize Collection for Total Moment Seismic Load base on Directional Angle of Attack Property
  Set Total_Mtorq_wL_s = New Collection                                             'Initialize Collection for Total Moment Torsional due to Winload base on Directional Angle of Attack Property
  Set total_Mtorq_sL_s = New Collection                                             'Initialize Collection for Total Moment Torsional due to Seismic Load base on Directional Angle of Attack Property
'
End Sub
')

Public Sub Assy(ByVal h_obj As Double)                                              'Method for making a collection of Arm after joint
'
  anos = inos(3)
  fst = fstr(4)
  '
  'Calculation for Arm Object
  For j = 0 To anos - 1
    For k = 0 To Aonos(j) - 1
      For l = 0 To Drnos - 1
        Dim each_Ao As AO_Each                                                      'Declare each_AO as an object of the AO_Each class
        Set each_Ao = New AO_Each
        '
        each_Ao.Arm_as_AO fst + 50 * j                                              'Call Arm_Value method, "fst + 50 * i" is the argument for procedure
        '
        each_Ao.AO_Value fst + 10 + k + 50 * j                                      'Call AO_Value method on the AO_Each class, "fst + 10 + k + 50 * j" is the argument for procedure
        each_Ao.q_wp                                                                'Call q_wp method on the AO_Each class
        each_Ao.Calc_Cf                                                             'Call Calc_Cf method on the AO_Each class
        each_Ao.Calc_Angle_of_Attack AoW(l)                                         'Call Calc_Angle_of_Attack method on the AO_Each class, "AoW(l)" is the argument for procedure
        each_Ao.Calc_wld                                                            'Call Calc_wld method on the AO_Each class
        each_Ao.calc_wld_XY AoW(l)
        '
        each_Ao.Center_Height h_obj                                                 'Call Center_Height method on the AO_Each class, "h_obj" is the argument for procedure
        each_Ao.Moment_fld                                                          'Call Moment_fld_A method on the AO_Each class
        each_Ao.Moment_wld                                                          'Call Moment_wld_A method on the AO_Each class
        each_Ao.Moment_wld_P                                                        'Call Moment_wld method on the AO_Each class, "h_obj" is the argument for procedure
        each_Ao.Moment_wld_XY
        '
        each_Ao.Calc_SeismicLoad                                                    'Call Calc_SeismicLoad method on the AO_Each class
        each_Ao.Moment_Seismic_Load                                                 'Call Moment_Seismic_Load method on the AO_Each class
        each_Ao.Moment_Seismic_LoadP                                                'Call Moment_Seismic_LoadP method on the AO_Each class
        each_Ao.Moment_fld_Angle                                                    'Call Moment_fld_Angle method on the AO_Each class
        each_Ao.Moment_Fixload_XY
        '
        each_Ao.Torq_Moment_Windload                                                'Call Torq_Moment_Windload method on the AO_Each class
        each_Ao.Torq_Moment_Seismic                                                 'Call Torq_Moment_Seismic method on the AO_Each class
        '
        If each_Ao.z >= h_obj Then
          arm_s.Add each_Ao                                                         'Add each_ao object to the arm_s Collection
        End If
      Next l
    Next k
    If each_Ao.z >= h_obj Then
      n_As.Add 1 'to get number of AO for each section
    End If
  Next j
'
End Sub
')

Public Sub lebih_tinggi_arm()                                                        'Method for Calc Number of Arm above Each Section
'
  n_A = 0
  For i = 1 To n_As.Count
    n_A = n_A + n_As.Item(i)
  Next i
'
End Sub
')

Public Sub Total_Fixload()                                                          'Method for Calc Total Fixload
'
  For i = 0 To Drnos - 1
    fl_sum = 0
    For j = 0 To arm_s.Count / 8 - 1
      fl_sum = fl_sum + arm_s.Item(1 + i + 8 * j).fld                               'Calc Total Fixload
    Next j
    total_fls.Add Fkb_SF(fl_sum, 3)                                                 'Add the Property of Total Fixload to the Collection
  Next i
'
End Sub
')

Public Sub Total_Winload()                                                          'Method for Calc Total Winload
'
  For i = 0 To Drnos - 1
    wl_sum = 0
    For j = 0 To arm_s.Count / 8 - 1
      wl_sum = wl_sum + arm_s.Item(1 + i + 8 * j).wld                               'Calc Total Winload
    Next j
    total_wls.Add Fkb_SF(wl_sum, 3)                                                 'Add the Property of Total Winload to the Collection
  Next i
'
End Sub
')

Public Sub Total_Winload_X()                                                          'Method for Calc Total Winload
'
  For i = 0 To Drnos - 1
    wlX_sum = 0
    For j = 0 To arm_s.Count / 8 - 1
      wlX_sum = wlX_sum + arm_s.Item(1 + i + 8 * j).wld_X                               'Calc Total Winload X axis
    Next j
    total_wlXs.Add Fkb_SF(wlX_sum, 3)                                                 'Add the Property of Total Winload to the Collection
  Next i
'
End Sub
')

Public Sub Total_Winload_Y()                                                          'Method for Calc Total Winload
'
  For i = 0 To Drnos - 1
    wlY_sum = 0
    For j = 0 To arm_s.Count / 8 - 1
      wlY_sum = wlY_sum + arm_s.Item(1 + i + 8 * j).wld_Y                               'Calc Total Winload X axis
    Next j
    total_wlYs.Add Fkb_SF(wlY_sum, 3)                                                 'Add the Property of Total Winload to the Collection
  Next i
'
End Sub
')

Public Sub Total_Seismicload()                                                      'Method for Calc Total Seismicload
  '
  For i = 0 To Drnos - 1
    sl_sum = 0
    For j = 0 To arm_s.Count / 8 - 1
      sl_sum = sl_sum + arm_s.Item(1 + i + 8 * j).ELa                               'Calc Total Seismic Load
    Next j
    total_sls.Add Fkb_SF(sl_sum, 3)                                                 'Add the Property of Total Seismic Load to the Collection
  Next i
'

End Sub
')

Public Sub Total_MfL_Ang()                                                          'Method for calculate Total Moment Fixload base on Directional Angle of Arm
'
  For i = 0 To Drnos - 1
    mfl_ang_sum = 0
    For j = 0 To arm_s.Count / 8 - 1
      mfl_ang_sum = mfl_ang_sum + arm_s.Item(1 + i + 8 * j).M_Fld_ang               'Calc Total Moment due to Fixload base on Directional Angle
    Next j
    total_mfls.Add Fkb_SF(mfl_ang_sum, 3)                                           'Add the Property of Total Moment Fixload base on Directional Angle to the Collection
  Next i
'
End Sub
')

Public Sub Total_MfL_X()                                                          'Method for calculate Total Moment Fixload base on X axis
'
  For i = 0 To Drnos - 1
    mfl_X_sum = 0
    For j = 0 To arm_s.Count / 8 - 1
      mfl_X_sum = mfl_X_sum + arm_s.Item(1 + i + 8 * j).M_Fld_X               'Calc Total Moment due to Fixload base on X axis
    Next j
    total_mfl_Xs.Add Fkb_SF(mfl_X_sum, 3)                                           'Add the Property of Total Moment Fixload base on X axis
  Next i
'
End Sub
')

Public Sub Total_MfL_Y()                                                          'Method for calculate Total Moment Fixload base on Y axis
'
  For i = 0 To Drnos - 1
    mfl_Y_sum = 0
    For j = 0 To arm_s.Count / 8 - 1
      mfl_Y_sum = mfl_Y_sum + arm_s.Item(1 + i + 8 * j).M_Fld_Y               'Calc Total Moment due to Fixload base on Y axis
    Next j
    total_mfl_Ys.Add Fkb_SF(mfl_Y_sum, 3)                                           'Add the Property of Total Moment Fixload base on Y axis
  Next i
'
End Sub
')

Public Sub Total_Mwl_Ang()                                                          'Method for Calc Total Moment Winload base on Directional Angle of Arm
'
  For i = 0 To Drnos - 1
    mwl_ang_sum = 0
    For j = 0 To arm_s.Count / 8 - 1
      mwl_ang_sum = mwl_ang_sum + arm_s.Item(1 + i + 8 * j).M_wld_p                 'Calc Total Moment due to Winload base on Directional Angle
    Next j
    total_Mwls.Add Fkb_SF(mwl_ang_sum, 3)                                           'Add the Property of Total Moment Winload base on Directional Angle to the Collection
  Next i
'
End Sub
')

Public Sub Total_Mwl_X()                                                          'Method for Calc Total Moment Winload base on X axis of Arm
'
  For i = 0 To Drnos - 1
    mwl_X_sum = 0
    For j = 0 To arm_s.Count / 8 - 1
      mwl_X_sum = mwl_X_sum + arm_s.Item(1 + i + 8 * j).M_wld_X                 'Calc Total Moment due to Winload base on X axis
    Next j
    total_MwL_Xs.Add Fkb_SF(mwl_X_sum, 3)                                           'Add the Property of Total Moment Winload base on X axis to the Collection
  Next i
'
End Sub
')

Public Sub Total_Mwl_Y()                                                          'Method for Calc Total Moment Winload base on X axis of Arm
'
  For i = 0 To Drnos - 1
    mwl_Y_sum = 0
    For j = 0 To arm_s.Count / 8 - 1
      mwl_Y_sum = mwl_Y_sum + arm_s.Item(1 + i + 8 * j).M_wld_Y                 'Calc Total Moment due to Winload base on X axis
    Next j
    total_MwL_Ys.Add Fkb_SF(mwl_Y_sum, 3)                                           'Add the Property of Total Moment Winload base on X axis to the Collection
  Next i
'
End Sub
')

Public Sub Total_Msl_Ang()                                                          'Method for Calc Total Moment Seismic Load base on Directional Angle of Arm
'
  For i = 0 To Drnos - 1
    msl_ang_sum = 0
    For j = 0 To arm_s.Count / 8 - 1
      msl_ang_sum = msl_ang_sum + arm_s.Item(1 + i + 8 * j).M_slp                   'Calc Total Moment due to Seismic Load base on Directional Angle
    Next j
    total_Msls.Add Fkb_SF(msl_ang_sum, 3)                                           'Add the Property of Total Moment Seismic Load base on Directional Angle to the Collection
  Next i
'
End Sub
')

Public Sub Total_Mtorq_wL()                                                         'Method for Calc Total Moment Torque due to Winload base on Directional Angle of Arm
'
  For i = 0 To Drnos - 1
    mtorq_wL = 0
    For j = 0 To arm_s.Count / 8 - 1
      mtorq_wL = mtorq_wL + arm_s.Item(1 + i + 8 * j).M_Torq_wL                     'Calc Total Moment Torque due to Winload base on Directional Angle
    Next j
    Total_Mtorq_wL_s.Add Fkb_SF(mtorq_wL, 3)                                        'Add the Property of Total Moment Torque due to Winload base on Directional Angle to the Collection
  Next i
'
End Sub
')

Public Sub total_Mtorq_sL()                                                         'Method for Calc Total Moment Torque due to Seismic Load base on Directional Angle of Arm
'
  For i = 0 To Drnos - 1
    Mtorq_sL = 0
    For j = 0 To arm_s.Count / 8 - 1
      Mtorq_sL = Mtorq_sL + arm_s.Item(1 + i + 8 * j).M_Torq_sL                     'Calc Total Moment Torque due to Seismic Load base on Directional Angle
    Next j
    total_Mtorq_sL_s.Add Fkb_SF(Mtorq_sL, 3)                                        'Add the Property of Total Moment Torque due to Seismic Load base on Directional Angle to the Collection
  Next i
'
End Sub
')









































































