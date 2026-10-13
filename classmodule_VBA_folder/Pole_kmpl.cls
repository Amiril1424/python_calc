VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Pole_kmpl"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'=========================================================== Properties Collection ==============================================================================
  Public pole_s As Collection                           'Property Collection for Pole Properties After Joint
  '
  Public total_fls As Collection                        'Collection for Total Fixload
  Public total_wls As Collection                        'Collection for Total Winload Properties
  Public total_wlXs As Collection                        'Collection for Total Winload Properties in X axis
  Public total_wlYs As Collection                        'Collection for Total Winload Properties in Y axis
  '
  Public total_sls As Collection                        'Collection for Total Seismic Load Properties
  '
  Public total_Mwls As Collection                       'Property Collection for Total Moment Winload base on Directional Angle of Attack Properties
  Public total_MwL_Xs As Collection                       'Property Collection for Total Moment Winload base on X axis Properties
  Public total_MwL_Ys As Collection                       'Property Collection for Total Moment Winload base on Y axis Properties
  '
  Public total_Msls As Collection                       'Property Collection for Total Moment Seismic Load base on Directional Angle of Attack Properties
  '
'=================================================================== Properties =================================================================================
  Public fl_sum As Double                               'Property of Total Fixload
  Public wl_sum As Double                               'Property of Total Winload
  Public wlX_sum As Double                               'Property of Total Winload in X axis
  Public wlY_sum As Double                               'Property of Total Winload in Y axis
  '
  Public sl_sum As Double                               'Property of Total Seismic Load
  '
  Public mwl_sum As Double                              'Property of Total Moment Winload base on Directional Angle of Attack
  Public mwl_X_sum As Double                              'Property of Total Moment Winload base on X axis
  Public mwl_Y_sum As Double                              'Property of Total Moment Winload base on Y axis
  '
  Public msl_sum As Double                              'Property of Total Moment Seismic Load base on Directional Angle of Attack
')

Private Sub Class_Initialize()                          'Method for Class Initialize Collection Property
'
  Set pole_s = New Collection                           'Initialize Collection for Pole Property
  '
  Set total_fls = New Collection                        'Initialize Collection for Total Fixload Property
  Set total_wls = New Collection                        'Initialize Collection for Total Winload Property
  Set total_wlXs = New Collection                        'Initialize Collection for Total Winload Property X axis
  Set total_wlYs = New Collection                        'Initialize Collection for Total Winload Property Y axis
  Set total_sls = New Collection                        'Initialize Collection for Total Seismic Load Property
  '
  Set total_Mwls = New Collection                       'Initialize Collection for Total Moment Winload base on Directional Angle of Attack Property
  Set total_MwL_Xs = New Collection
  Set total_MwL_Ys = New Collection
  '
  Set total_Msls = New Collection                       'Initialize Collection for Total Moment Seismic Load base on Directional Angle of Attack Property
'
End Sub
')

Public Sub Assy(ByVal h_obj As Double)                  'Method for making a Collection of Pole After Join of Pole
'
  pnos = inos(1)
  fst = fstr(2)
  '
  For j = 0 To pnos - 1
    For i = 0 To Drnos - 1
      Dim each_P As Pole_each                             'Declare each_P as an object of the Pole_each class
      Set each_P = New Pole_each
      '
      each_P.Pole_Value fst + j                           'call Pole_Value method on the Pole_each class, "fst + j" is the argument for procedure
      '
      each_P.calc_taper_ratio h_pjt(j)                    'Call calc_taper_ratio method on the Pole_each class
      '
        'This is for calculate length of Pole
        If h_obj > h_pjt(j) Then
          each_P.Calc_Length h_obj                          'call Calc_Length method on the Pole_each class, "h_obj" is the argument for procedure
        ElseIf h_obj <= h_pjt(j) Then
          each_P.Calc_Length h_pjt(j)                       'call Calc_Length method on the Pole_each class, "h_pjt(j)" is the argument for procedure
        End If
        '"if" need to control that when length is 0, no need to calculate and no need to put in collection
        If each_P.Length > 0 Then
          each_P.Calc_Diameter_Section                      'Call Calc_Diameter_Section method on the Pole_each class
          each_P.Po_Spec                                    'call Po_Spec method on the Pole_each class
          each_P.Calc_Fixload                               'call Calc_Fixload method on the Pole_each class
          each_P.q_wp                                       'call q_wp method on the Pole_each class
          each_P.Calc_Cf                                    'call Calc_Cf method on the Pole_each class
          each_P.Calc_Area                                  'call Calc_Area method on the Pole_each class
          each_P.Calc_Winload                               'call Calc_Winload method on the Pole_each class
          each_P.Calc_Windload_XY AoW(i)
          '
          each_P.Center_Point                               'call Center_Point method on the Pole_each class
          each_P.Length_Center_Point h_obj                  'call Length_Center_Point method on the Pole_each class, "h_obj" is the argument for procedure
          each_P.Moment_Wl                                  'call Moment_Wl method on the Pole_each class
          each_P.Moment_Wl_XY
          '
          each_P.Calc_SeismicLoad                           'call Calc_SeismicLoad method on the Pole_each class
          each_P.Moment_Seismic_Load                        'call Moment_Seismic_Load method on the Pole_each class
          '
          If each_P.z > h_obj Then
            pole_s.Add each_P                               'Add each_P object to the pole_s Collection
          End If
        End If
    Next i
  Next j
'
End Sub
')

Public Sub Total_Fixload()                              'Method for Calc Total Fixload
'
  For i = 0 To Drnos - 1
    fl_sum = 0
    For j = 0 To pole_s.Count / 8 - 1
      fl_sum = (fl_sum + pole_s.Item(1 + i + 8 * j).fld)              'calc Total Fixload
    Next j
    '
    total_fls.Add Fkb_SF(fl_sum, 3)                       'Add the Property of Total Fixload to the collection
  Next i
'
End Sub
')

Public Sub Total_Winload()                              'Method for Calc Total Winload
'
  For i = 0 To Drnos - 1
    wl_sum = 0
    For j = 0 To pole_s.Count / 8 - 1
      wl_sum = (wl_sum + pole_s.Item(1 + i + 8 * j).WnL)              'calc Total Winload
    Next j
    '
    total_wls.Add Fkb_SF(wl_sum, 3)                       'Add the Property of Total Winload to the collection
  Next i
'
End Sub
')

Public Sub Total_Winload_X()                              'Method for Calc Total Winload
'
  For i = 0 To Drnos - 1
    'Sum windload in X direction
    wlX_sum = 0
    For j = 0 To pole_s.Count / 8 - 1
      wlX_sum = (wlX_sum + pole_s.Item(1 + i + 8 * j).WnL_X)              'calc Total Winload X axis
    Next j
    '
    total_wlXs.Add Fkb_SF(wlX_sum, 3)                       'Add the Property of Total Winload to the collection
  Next i
'
End Sub
')

Public Sub Total_Winload_Y()                              'Method for Calc Total Winload
'
  'Sum windload in Y direction
  For i = 0 To Drnos - 1
    wlY_sum = 0
    For j = 0 To pole_s.Count / 8 - 1
      wlY_sum = (wlY_sum + pole_s.Item(1 + i + 8 * j).WnL_Y)              'calc Total Winload Y axis
    Next j
    '
    total_wlYs.Add Fkb_SF(wlY_sum, 3)                       'Add the Property of Total Winload to the collection
  Next i
'
End Sub
')

Public Sub Total_Seismicload()                          'Method for Calc Total Seismicload
'
  For i = 0 To Drnos - 1
    sl_sum = 0
    For j = 0 To pole_s.Count / 8 - 1
      sl_sum = (sl_sum + pole_s.Item(1 + i + 8 * j).ELp)              'calc Total Seismicload
    Next j
    '
    total_sls.Add Fkb_SF(sl_sum, 3)                       'Add the Property of Total Seismicload to the collection
  Next i
'
End Sub
')

Public Sub total_mwl()                                  'Method for Calc Total Moment Winload base on Directional Angle of Pole
'
  For i = 0 To Drnos - 1
    mwl_sum = 0
    For j = 0 To pole_s.Count / 8 - 1
      mwl_sum = (mwl_sum + pole_s.Item(1 + i + 8 * j).MwL)            'calc Total Moment due to Winload base on Directional Angle
    Next j
    '
    total_Mwls.Add Fkb_SF(mwl_sum, 3)                     'Add the Property of Total Moment Winload base on Directional Angle to the collection
  Next i
'
End Sub
')

Public Sub Total_Mwl_X()                                  'Method for Calc Total Moment Winload base on Directional Angle of Pole
'
  For i = 0 To Drnos - 1
    mwl_X_sum = 0
    For j = 0 To pole_s.Count / 8 - 1
      mwl_X_sum = (mwl_X_sum + pole_s.Item(1 + i + 8 * j).MwL_X)            'calc Total Moment due to Winload base on X axis
    Next j
    '
    total_MwL_Xs.Add Fkb_SF(mwl_X_sum, 3)                     'Add the Property of Total Moment Winload base on X axis to the collection
  Next i
'
'Stop

End Sub
')

Public Sub Total_Mwl_Y()                                  'Method for Calc Total Moment Winload base on Directional Angle of Pole
'
  For i = 0 To Drnos - 1
    mwl_Y_sum = 0
    For j = 0 To pole_s.Count / 8 - 1
      mwl_Y_sum = (mwl_Y_sum + pole_s.Item(1 + i + 8 * j).MwL_Y)            'calc Total Moment due to Winload base on Y axis
    Next j
    '
    total_MwL_Ys.Add Fkb_SF(mwl_Y_sum, 3)                     'Add the Property of Total Moment Winload base on Y axis to the collection
  Next i
'
End Sub
')

Public Sub Total_Msl()                                  'Method for Calc Total Moment Seismic Load base on Directional Angle of Pole
'
  For i = 0 To Drnos - 1
    msl_sum = 0
    For j = 0 To pole_s.Count / 8 - 1
      msl_sum = (msl_sum + pole_s.Item(1 + i + 8 * j).MSL)            'calc Total Moment due to Seismic Load base on Directional Angle
    Next j
    '
    total_Msls.Add Fkb_SF(msl_sum, 3)                     'Add the Property of Total Moment Seismic Load base on Directional Angle to the collection
  Next i
'
End Sub
')



