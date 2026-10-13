VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "OHW_Kmpl"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'=========================================================== Properties Collection ==============================================================================
  Public ohw_s As Collection                                                        'Collection for OHW properties after joint
  Public n_Ws As Collection                                                         'Collection for Number Index of OHW Each Section
  '
  Public total_fls As Collection                                                    'Collection for Total Fixload
  Public total_wls As Collection                                                    'Collection for Total Winload Properties
  Public total_wlXs As Collection                                                    'Collection for Total Winload X axis
  Public total_wlYs As Collection                                                    'Collection for Total Winload Y axis
  '
  Public total_sls As Collection                                                    'Collection for Total Seismic Load Properties
  '
  Public total_Mwls As Collection                                                   'Collection for Total Moment Winload base on Directional Angle of Attack Properties
  Public total_MwL_Xs As Collection                                                   'Collection for Total Moment Winload base on X axis
  Public total_MwL_Ys As Collection                                                   'Collection for Total Moment Winload base on X axis
  '
  Public total_Msls As Collection                                                   'Collection for Total Moment Seismic Load base on Directional Angle of Attack Properties
  '
  Public total_tns_wL As Collection                                                 'Collection for Total Moment Tension due to Winload base on Directional Angle of Attack Properties
  Public total_tns_wLX As Collection                                                 'Collection for Total Moment Tension due to Winload base on X axis
  Public total_tns_wLY As Collection                                                 'Collection for Total Moment Tension due to Winload base on Y axis
'
  Public total_tns_sL As Collection                                                 'Collection for Total Moment Tension due to Seismic Load base on Directional Angle of Attack Properties
  Public total_Mtns_wL As Collection                                                'Collection for Total Moment Tension due to Winload base on Directional Angle of Attack Properties
  Public total_Mtns_wLX As Collection                                                'Collection for Total Moment Tension due to Winload base on X axis
  Public total_Mtns_wLY As Collection                                                'Collection for Total Moment Tension due to Winload base on Y axis
  '
  Public total_Mtns_sL As Collection                                                'Collection for Total Moment Tension due to Seismic Load base on Directional Angle of Attack Properties
  '
'=================================================================== Properties =================================================================================
  Public n_W As Long                                                                'Property of Number Index of OHW Each Section
  '
  Public fl_sum As Double                                                           'Property of Total Fixload
  Public wl_sum As Double                                                           'Property of Total Winload
  Public wlX_sum As Double                                                           'Property of Total Winload X axis
  Public wlY_sum As Double                                                           'Property of Total Winload Y axis
  '
  Public sl_sum As Double                                                           'Property of Total Seismicload
  '
  Public mwl_ang_sum As Double                                                      'Property of Total Moment Winload base on Directional Angle of Attack
  Public mwl_X_sum As Double                                                      'Property of Total Moment Winload base on X axis
  Public mwl_Y_sum As Double                                                      'Property of Total Moment Winload base on Y axis
  Public msl_ang_sum As Double                                                      'Property of Total Moment Seismic Load base on Directional Angle of Attack
  '
  Public Tns_wL_sum As Double                                                       'Property of Total Moment Tension due to Winload base on Directional Angle of Attack
  Public Tns_wLX_sum As Double                                                       'Property of Total Moment Tension due to Winload base on X axis
  Public Tns_wLY_sum As Double                                                       'Property of Total Moment Tension due to Winload base on Y axis
  '
  Public Tns_sL_sum As Double                                                       'Property of Total Moment Tension due to Seismic Load base on Directional Angle of Attack
  Public M_Tns_wL_sum As Double                                                     'Property of Total Moment Tension due to Winload base on Directional Angle of Attack
  Public M_Tns_wLX_sum As Double
  Public M_Tns_wLY_sum As Double
  '
  Public M_Tns_sL_sum As Double                                                     'Property of Total Moment Tension due to Seismic Load base on Directional Angle of Attack
')

Private Sub Class_Initialize()                                                      'Method for Initialize Properties Collection
  Set ohw_s = New Collection                                                        'Initialize Collection for OHW Property
  Set n_Ws = New Collection                                                         'Initialize Collection for Number Index of OHW Each Section Property
  '
  Set total_fls = New Collection                                                    'Initialize Collection for Total Fixload Property
  Set total_wls = New Collection                                                    'Initialize Collection for Total Winload Property
  Set total_wlXs = New Collection
  Set total_wlYs = New Collection
  '
  Set total_sls = New Collection                                                    'Initialize Collection for Total Seismic Load Property
  '
  Set total_Mwls = New Collection                                                   'Initialize Collection for Total Moment Winload base on Directional Angle of Attack Property
  Set total_MwL_Xs = New Collection
  Set total_MwL_Ys = New Collection
  '
  Set total_Msls = New Collection                                                   'Initialize Collection for Total Moment Seismic Load base on Directional Angle of Attack Property
  '
  Set total_tns_wL = New Collection                                                 'Initialize Collection for Total Moment Tension due to Winload base on Directional Angle of Attack Property
  Set total_tns_wLX = New Collection
  Set total_tns_wLY = New Collection
  '
  Set total_tns_sL = New Collection                                                 'Initialize Collection for Total Moment Tension due to Seismic Load base on Directional Angle of Attack Property
  '
  Set total_Mtns_wL = New Collection                                                'Initialize Collection for Total Moment Tension due to Winload base on Directional Angle of Attack Property
  Set total_Mtns_wLX = New Collection
  Set total_Mtns_wLY = New Collection
  '
  Set total_Mtns_sL = New Collection                                                'Initialize Collection for Total Moment Tension due to Seismic Load base on Directional Angle of Attack Property
'
End Sub
')

Public Sub Assy(ByVal h_obj As Double)                                              'Method for making a collection of OHW after joint
'
  fst = fstr(5)
  wnos = inos(4)
  '
  For i = 0 To wnos - 1
    For j = 0 To Drnos - 1
      Dim each_Ohw As OHW_each                                                      'Declare each_W as an object of the OHW_each class
      Set each_Ohw = New OHW_each
      '
      each_Ohw.OHW_Value fst + i                                                    'call OHW_Value method on the OHW_each class, "fst + i " is the argument for procedure
      each_Ohw.Calc_Fixload                                                         'call Calc_Fixload method on the OHW_each class
      each_Ohw.q_wp                                                                 'call q_wp  method on the OHW_each class
      each_Ohw.Calc_Cf                                                              'call Calc_Area method on the OHW_each class
      each_Ohw.Calc_Angle_of_Attack AoW(j)                                          'call Calc_Angle_of_Atack method on the OHW_each class, "AoW(j)" is the argument for procedure
      each_Ohw.Calc_Cf                                                              'call Calc_Cf method on the OHW_each class
      each_Ohw.Calc_Area                                                            'call Calc_Area method on the OHW_each class
      each_Ohw.Calc_wld                                                             'call Calc_wld method on the OHW_each class
      each_Ohw.calc_wld_XY AoW(j)
      '
      each_Ohw.Center_Height h_obj                                                  'call Center_Height method on the OHW_each class, "h_obj" is the argument for procedure
      each_Ohw.Moment_wld                                                           'call Moment_wld method on the OHW_each class
      each_Ohw.Moment_wld_XY
      '
      each_Ohw.Calc_SeismicLoad                                                     'call Calc_SeismicLoad method on the OHW_each class
      each_Ohw.Moment_Seismic_Load                                                  'call Moment_Seismic_Load method on the OHW_each class
      each_Ohw.Calc_Pressure_Wind                                                   'call Calc_Pressure_Wind method on the OHW_each class
      each_Ohw.Calc_Tension_wind                                                    'call calc_Tension_wind method on the OHW_each class
      each_Ohw.Calc_Tension_Wind_XY
      '
      each_Ohw.Moment_Tension_wind                                                  'call Moment_Tension_wind method on the OHW_each class
      each_Ohw.Moment_tension_wind_XY
      '
      each_Ohw.Calc_Tension_SeismicLoad                                             'call calc_Tension_SeismicLoad method on the OHW_each class
      each_Ohw.Moment_Tension_SeismicLoad                                           'call Moment_Tension_SeismicLoad method on the OHW_each class
    '
      If each_Ohw.z >= h_obj Then
        ohw_s.Add each_Ohw                                                          'Add each_Ohw object to the ohw_s Collection
      End If
    Next j
    If each_Ohw.z >= h_obj Then
      n_Ws.Add 1 'to get number of Ohw for each section
    End If
  Next i
'
End Sub
')

Public Sub lebih_tinggi_ohw()                                                       'Method for calculate number of arm above each section
'
  n_W = 0
  For i = 1 To n_Ws.Count
    n_W = n_W + n_Ws.Item(i)
  Next i
'
End Sub
')

Public Sub Total_Fixload()                                                          'Method for Calc Total Fixload
'
  For i = 0 To Drnos - 1
    fl_sum = 0
    For j = 0 To ohw_s.Count / 8 - 1
      fl_sum = fl_sum + ohw_s.Item(1 + i + 8 * j).fld                               'calc Total Fixload
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
    For j = 0 To ohw_s.Count / 8 - 1
      wl_sum = wl_sum + ohw_s.Item(1 + i + 8 * j).wld_Dir                           'calc Total Winload
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
    For j = 0 To ohw_s.Count / 8 - 1
      wlX_sum = wlX_sum + ohw_s.Item(1 + i + 8 * j).wld_X                           'calc Total Winload in X axis
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
    For j = 0 To ohw_s.Count / 8 - 1
      wlY_sum = wlY_sum + ohw_s.Item(1 + i + 8 * j).wld_Y                           'calc Total Winload in Y axis
    Next j
    total_wlYs.Add Fkb_SF(wlY_sum, 3)                                                 'Add the Property of Total Winload to the Collection
  Next i
'
End Sub
')

Public Sub Total_Seismicload()                                                      'Method for Calc Total Seismic Load
  '
  For i = 0 To Drnos - 1
    sl_sum = 0
    For j = 0 To ohw_s.Count / 8 - 1
      sl_sum = sl_sum + ohw_s.Item(1 + i + 8 * j).ELw                               'calc Total Seismic Load
    Next j
    total_sls.Add Fkb_SF(sl_sum, 3)                                                 'Add the Property of Total Seismic Load to the Collection
  Next i
'

End Sub
')

Public Sub Total_Mwl_Ang()                                                          'Method for Calc Total Moment Winload base on Directional Angle
'
  For i = 0 To Drnos - 1
    mwl_ang_sum = 0
    For j = 0 To ohw_s.Count / 8 - 1
      mwl_ang_sum = mwl_ang_sum + ohw_s.Item(1 + i + 8 * j).M_wld                   'Calc Total Moment due to Winload base on Directional Angle
    Next j
    total_Mwls.Add Fkb_SF(mwl_ang_sum, 3)                                           'Add the Property of Total Moment Winload base on Directional Angle to the collection
  Next i
'
End Sub
')

Public Sub Total_Mwl_X()                                                          'Method for Calc Total Moment Winload base on X axis
'
  For i = 0 To Drnos - 1
    mwl_X_sum = 0
    For j = 0 To ohw_s.Count / 8 - 1
      mwl_X_sum = mwl_X_sum + ohw_s.Item(1 + i + 8 * j).M_wl_X                   'Calc Total Moment due to Winload base on Directional Angle
    Next j
    total_MwL_Xs.Add Fkb_SF(mwl_X_sum, 3)                                           'Add the Property of Total Moment Winload base on Directional Angle to the collection
  Next i
'
End Sub
')

Public Sub Total_Mwl_Y()                                                          'Method for Calc Total Moment Winload base on Y axis
'
  For i = 0 To Drnos - 1
    mwl_Y_sum = 0
    For j = 0 To ohw_s.Count / 8 - 1
      mwl_Y_sum = mwl_Y_sum + ohw_s.Item(1 + i + 8 * j).M_wl_Y                   'Calc Total Moment due to Winload base on Directional Angle
    Next j
    total_MwL_Ys.Add Fkb_SF(mwl_Y_sum, 3)                                           'Add the Property of Total Moment Winload base on Directional Angle to the collection
  Next i
'
End Sub
')

Public Sub Total_Msl_Ang()                                                          'Method for Calc Total Moment Seismic Load base on Directional Angle
'
  For i = 0 To Drnos - 1
    msl_ang_sum = 0
    For j = 0 To ohw_s.Count / 8 - 1
      msl_ang_sum = msl_ang_sum + ohw_s.Item(1 + i + 8 * j).MSL                     'Calc Total Moment due to Seismic Load base on Directional Angle
    Next j
    total_Msls.Add Fkb_SF(msl_ang_sum, 3)                                            'Add the Property of Total Moment Seismic Load base on Directional Angle to the collection
  Next i
'
End Sub
')

Public Sub Total_tension_wL()                                                       'Method for Calc Total Moment Tension due to Winload base on Directional Angle
'
  For i = 0 To Drnos - 1
    Tns_wL_sum = 0
    For j = 0 To ohw_s.Count / 8 - 1
      Tns_wL_sum = Tns_wL_sum + ohw_s.Item(1 + i + 8 * j).Tns_wL                    'Calc Total Moment Tension due to Winload base on Directional Angle
    Next j
    total_tns_wL.Add Fkb_SF(Tns_wL_sum, 3)                                          'Add the Property of Total Moment Tension due to Winload base on Directional Angle to the collection
  Next i
'
End Sub
')

Public Sub Total_tension_wLX()                                                       'Method for Calc Total Moment Tension due to Winload base on X axis
'
  For i = 0 To Drnos - 1
    Tns_wLX_sum = 0
    For j = 0 To ohw_s.Count / 8 - 1
      Tns_wLX_sum = Tns_wLX_sum + ohw_s.Item(1 + i + 8 * j).Tns_wL_X                    'Calc Total Moment Tension due to Winload base on X axis
    Next j
    total_tns_wLX.Add Fkb_SF(Tns_wLX_sum, 3)                                          'Add the Property of Total Moment Tension due to Winload base on X axis to the collection
  Next i
'
End Sub
')

Public Sub Total_tension_wLY()                                                       'Method for Calc Total Moment Tension due to Winload base on Y axis
'
  For i = 0 To Drnos - 1
    Tns_wLY_sum = 0
    For j = 0 To ohw_s.Count / 8 - 1
      Tns_wLY_sum = Tns_wLY_sum + ohw_s.Item(1 + i + 8 * j).Tns_wL_Y                    'Calc Total Moment Tension due to Winload base on Y axis
    Next j
    total_tns_wLY.Add Fkb_SF(Tns_wLY_sum, 3)                                          'Add the Property of Total Moment Tension due to Winload base on Y axis to the collection
  Next i
'
End Sub
')

Public Sub Total_tension_sL()                                                       'Method for Calc Total Moment Tension due to Seismic Load base on Directional Angle
'
  For i = 0 To Drnos - 1
    Tns_sL_sum = 0
    For j = 0 To ohw_s.Count / 8 - 1
      Tns_sL_sum = Tns_sL_sum + ohw_s.Item(1 + i + 8 * j).Tns_sL                    'Calc Total Moment Tension due to Seismic Load base on Directional Angle
    Next j
    total_tns_sL.Add Fkb_SF(Tns_sL_sum, 3)                                          'Add the Property of Total Moment Tension due to Seismic Load base on Directional Angle to the collection
  Next i
'
End Sub
')

Public Sub Total_Mtension_wL()                                                      'Method for Calc Total Moment Tension due to Winload base on Directional Angle
'
  For i = 0 To Drnos - 1
    M_Tns_wL_sum = 0
    For j = 0 To ohw_s.Count / 8 - 1
      M_Tns_wL_sum = M_Tns_wL_sum + ohw_s.Item(1 + i + 8 * j).M_Tns_wL_ang          'Calc Total Moment Tension due to Winload base on Directional Angle
    Next j
    total_Mtns_wL.Add Fkb_SF(M_Tns_wL_sum, 3)                                       'Add the Property of Total Moment Tension due to Winload base on Directional Angle to the collection
  Next i
'
End Sub
')

Public Sub Total_Mtension_wLX()                                                      'Method for Calc Total Moment Tension due to Winload in X axis
'
  For i = 0 To Drnos - 1
    M_Tns_wLX_sum = 0
    For j = 0 To ohw_s.Count / 8 - 1
      M_Tns_wLX_sum = M_Tns_wLX_sum + ohw_s.Item(1 + i + 8 * j).M_Tns_wL_X          'Calc Total Moment Tension due to Winload base on X axis
    Next j
    total_Mtns_wLX.Add Fkb_SF(M_Tns_wLX_sum, 3)                                       'Add the Property of Total Moment Tension due to Winload base on Directional Angle to the collection
  Next i
'
End Sub
')

Public Sub Total_Mtension_wLY()                                                      'Method for Calc Total Moment Tension due to Winload in Y axis
'
  For i = 0 To Drnos - 1
    M_Tns_wLY_sum = 0
    For j = 0 To ohw_s.Count / 8 - 1
      M_Tns_wLY_sum = M_Tns_wLY_sum + ohw_s.Item(1 + i + 8 * j).M_Tns_wL_Y          'Calc Total Moment Tension due to Winload base on Y axis
    Next j
    total_Mtns_wLY.Add Fkb_SF(M_Tns_wLY_sum, 3)                                       'Add the Property of Total Moment Tension due to Winload base on Directional Angle to the collection
  Next i
'
End Sub
')

Public Sub Total_Mtension_sL()                                                      'Method for Calc Total Moment Tension due to Seismic Load base on Directional Angle
'
  For i = 0 To Drnos - 1
    M_Tns_sL_sum = 0
    For j = 0 To ohw_s.Count / 8 - 1
      M_Tns_sL_sum = M_Tns_sL_sum + ohw_s.Item(1 + i + 8 * j).M_Tns_sL_ang          'Calc Total Moment Tension due to Seismic Load base on Directional Angle
    Next j
    total_Mtns_sL.Add Fkb_SF(M_Tns_sL_sum, 3)                                       'Add the Property of Total Moment Tension due to Seismic Load base on Directional Angle to the collection
  Next i
'
End Sub
')





















