VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Do_kmpl"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'=========================================================== Properties Collection ==============================================================================
  Public do_s As Collection                                             'Property Collection for Direct Object Properties After Joint
  Public n_Ds As Collection                                             'Property Collection for Number Index of DO Each Section
  '
  Public total_fls As Collection                                        'Collection for Total Fixload
  Public total_wls As Collection                                        'Collection for Total Winload Properties
  Public total_sls As Collection                                        'Collection for Total Seismic Load Properties
  '
  Public total_wlXs As Collection                                        'Collection for Total Winload X axis Properties
  Public total_wlYs As Collection                                        'Collection for Total Winload Y axis Properties
  '
  Public total_Mwls As Collection                                       'Property Collection for Total Moment Winload base on Directional Angle of Attack Properties
  Public total_Msls As Collection                                       'Property Collection for Total Moment Seismnic Load base on Directional Angle of Attack Properties
  '
  Public total_MwL_Xs As Collection                                       'Property Collection for Total Moment Winload base on X axis
  Public total_MwL_Ys As Collection                                       'Property Collection for Total Moment Winload base on Y axis
'
'=================================================================== Properties =================================================================================
  Public n_D As Long                                                    'Property Number Index of DO Each Section
  '
  Public fl_sum As Double                                               'Property of Total Fixload
  Public wl_sum As Double                                               'Property of Total Winload
  Public wlX_sum As Double                                               'Property of Total Winload in X axis
  Public wlY_sum As Double                                               'Property of Total Winload in Y axis
  Public sl_sum As Double                                               'Property of Total Seismicload
  '
  Public mwl_ang_sum As Double                                          'Property of Total Moment Winload base on Directional Angle of Attack
  Public mwl_X_sum As Double                                            'Property of Total Moment Winload base on X axis
  Public mwl_Y_sum As Double                                            'Property of Total Moment Winload base on Y axis
  '
  Public msl_ang_sum As Double                                          'Property of Total Moment Seismic Load base on Directional Angle of Attack

')

Private Sub Class_Initialize()                                          'Method for Initialize Properties Collection
'
  Set do_s = New Collection                                             'Initialize Property Collection for Direct Object Property
  Set n_Ds = New Collection                                             'Initialize Property Collection for Number Index of DO Each Section Property
  '
  Set total_fls = New Collection                                        'Initialize Collection for Total Fixload Property
  Set total_wls = New Collection                                        'Initialize Collection for Total Winload Property
  Set total_sls = New Collection                                        'Initialize Collection for Total Seismic Load Property
  '
  Set total_wlXs = New Collection                                        'Initialize Collection for Total Winload X axis Property
  Set total_wlYs = New Collection                                        'Initialize Collection for Total Winload Y axis Property
  '
  Set total_Mwls = New Collection                                       'Initialize Property Collection for Total Moment Winload base on Directional Angle of Attack Property
  Set total_MwL_Xs = New Collection                                       'Initialize Property Collection for Total Moment Winload base on X axis
  Set total_MwL_Ys = New Collection                                       'Initialize Property Collection for Total Moment Winload base on Y axis
  '
  Set total_Msls = New Collection                                       'Initialize Property Collection for Total Moment Seismic Load base on Directional Angle of Attack Property
'
End Sub
')

Public Sub Assy(ByVal h_obj As Double)                                  'Method for making a Collection of Direct Object Properties After Joint
'
  dnos = inos(2)
  fst = fstr(3)
  '
  For j = 0 To dnos - 1
    For i = 0 To Drnos - 1
      Dim each_D As DO_each                                             'Declare each_D as an object of the DO_each class
      Set each_D = New DO_each
      '
      each_D.Do_Value fst + j                                           'call Do_Value method on the DO_each class, "fst + j" is the argument for procedure
      each_D.q_wp                                                       'call q_wp method on the DO_each class
      each_D.Calc_Cf                                                    'call Calc_Cf method on the DO_each class
      each_D.Calc_Angle_of_Atack AoW(i)                                 'call Calc_Angle_of_Atack method on the DO_each class, "AoW(i)" is the argument for procedure
      each_D.Calc_wld                                                   'call Calc_wld method on the DO_each class
      each_D.calc_wld_XY AoW(i)
      each_D.Calc_SeismicLoad                                           'call Calc_SeismicLoad method on the DO_each class
      each_D.Center_Height h_obj                                        'call Center_Height method on the DO_each class, "h_obj" is the argument for procedure
      each_D.Moment_wld                                                 'call Moment_wld method on the DO_each class
      each_D.Moment_wld_XY
      each_D.Moment_Seismic_Load                                        'call Moment_Seismic_Load method on the DO_each class
      '
      If each_D.z >= h_obj Then
      do_s.Add each_D                                                   'Add each_D object to the do_s Collection
      End If
    Next i
    If each_D.z >= h_obj Then
      n_Ds.Add 1 'to get number of AO for each section
    End If
  Next j
'
End Sub
')

Public Sub lebih_tinggi_Do()                                            'Method for Calc Number of Arm above Each Section
'
  n_D = 0
  For i = 1 To n_Ds.Count
    n_D = n_D + n_Ds.Item(i)
  Next i
'
End Sub
')

Public Sub Total_Fixload()                                              'Method for Calc Total Fixload
'
  For i = 0 To Drnos - 1
    fl_sum = 0
    For j = 0 To do_s.Count / 8 - 1
      fl_sum = fl_sum + do_s.Item(1 + i + 8 * j).fld_n                  'calc Total Fixload
    Next j
    total_fls.Add Fkb_SF(fl_sum, 3)                                     'Add the Property of Total Fixload to the Collection
  Next i
'
End Sub
')

Public Sub Total_Winload()                                              'Method for Calc Total Winload
'
  For i = 0 To Drnos - 1
    wl_sum = 0
    For j = 0 To do_s.Count / 8 - 1
      wl_sum = wl_sum + do_s.Item(1 + i + 8 * j).wld                    'calc Total Winload
    Next j
    total_wls.Add Fkb_SF(wl_sum, 3)                                     'Add the Property of Total Winload to the Collection
  Next i
'
End Sub
')

Public Sub Total_windload_X()
'
  'Sum windload in X direction
  For i = 0 To Drnos - 1
    wlX_sum = 0
    For j = 0 To do_s.Count / 8 - 1
      wlX_sum = wlX_sum + do_s.Item(1 + i + 8 * j).wld_X                    'calc Total Winload
    Next j
    total_wlXs.Add Fkb_SF(wlX_sum, 3)                                     'Add the Property of Total Winload to the Collection
  Next i
  '
End Sub
')

Public Sub Total_windload_Y()
'
  'Sum windload in X direction
  For i = 0 To Drnos - 1
    wlY_sum = 0
    For j = 0 To do_s.Count / 8 - 1
      wlY_sum = wlY_sum + do_s.Item(1 + i + 8 * j).wld_Y                    'calc Total Winload
    Next j
    total_wlYs.Add Fkb_SF(wlY_sum, 3)                                     'Add the Property of Total Winload to the Collection
  Next i
  '
End Sub
')

Public Sub Total_Seismicload()                                          'Method for Calc Total Seismic Load
  '
  For i = 0 To Drnos - 1
    sl_sum = 0
    For j = 0 To do_s.Count / 8 - 1
      sl_sum = sl_sum + do_s.Item(1 + i + 8 * j).ELd                    'calc Total Seismic Load
    Next j
    total_sls.Add Fkb_SF(sl_sum, 3)                                     'Add the Property of Total Seismic Load to the Collection
  Next i
'

End Sub
')

Public Sub Total_Mwl_Ang()                                              'Method for Calc Total Moment Winload base on Directional Angle
'
  For i = 0 To Drnos - 1
    mwl_ang_sum = 0
    For j = 0 To do_s.Count / 8 - 1
      mwl_ang_sum = mwl_ang_sum + do_s.Item(1 + i + 8 * j).M_wld        'Calc Total Moment due to Winload base on Directional Angle
    Next j
    total_Mwls.Add Fkb_SF(mwl_ang_sum, 3)                               'Add the Property of Total Moment Winload base on Directional Angle to the collection
  Next i
'
End Sub
')

Public Sub Total_Mwl_X()                                              'Method for Calc Total Moment Winload base on X axis
'
  For i = 0 To Drnos - 1
    mwl_X_sum = 0
    For j = 0 To do_s.Count / 8 - 1
      mwl_X_sum = mwl_X_sum + do_s.Item(1 + i + 8 * j).M_wld_X        'Calc Total Moment due to Winload base on X axis
    Next j
    total_MwL_Xs.Add Fkb_SF(mwl_X_sum, 3)                               'Add the Property of Total Moment Winload base on X axis to the collection
  Next i
'
End Sub
')

Public Sub Total_Mwl_Y()                                              'Method for Calc Total Moment Winload base on X axis
'
  For i = 0 To Drnos - 1
    mwl_Y_sum = 0
    For j = 0 To do_s.Count / 8 - 1
      mwl_Y_sum = mwl_Y_sum + do_s.Item(1 + i + 8 * j).M_wld_Y        'Calc Total Moment due to Winload base on X axis
    Next j
    total_MwL_Ys.Add Fkb_SF(mwl_Y_sum, 3)                               'Add the Property of Total Moment Winload base on X axis to the collection
  Next i
'
End Sub
')
    
Public Sub Total_Msl_Ang()                                              'Method for Calc Total Moment Seismic Load base on Directional Angle
'
  For i = 0 To Drnos - 1
    msl_ang_sum = 0
    For j = 0 To do_s.Count / 8 - 1
      msl_ang_sum = msl_ang_sum + do_s.Item(1 + i + 8 * j).MSL          'Calc Total Moment due to Seismic Load base on Directional Angle
    Next j
    total_Msls.Add Fkb_SF(msl_ang_sum, 3)                               'Add the Property of Total Moment Seismic Load base on Directional Angle to the collection
  Next i
'
End Sub
')


