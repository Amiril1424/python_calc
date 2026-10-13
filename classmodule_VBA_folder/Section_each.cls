VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Section_each"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'=========================================================== Properties Collection for Each Section of Pole ===========================================================================
'
'Fixload of Each Section Pole Collection Property
  Public total_fl_s As Collection                                                               'Property Collection of Total Fixload
  '
  Public total_wLd_s As Collection                                                              'Property Collection of Total Winload
  Public total_wLdX_s As Collection
  Public total_wLdY_s As Collection
  Public Hrztl_WlX_s As Collection
  Public Hrztl_WlY_s As Collection
  Public Rsltn_wL_s As Collection                                                               'Property Collection of Total Resultan Winload (Total Winload + Tension)
  '
  Public total_sLd_s As Collection                                                              'Property Collection of Total Seismicload
  Public Rsltn_sL_s As Collection                                                               'Property Collection of Total Resultan Seismicload (Total Seismicload + Tension)
  '
'Moment due to Fixload Collection Property for Each Section Pole
  Public strs_MfL_s As Collection                                                               'Property Collection of Stress Moment due to Fixload
  Public sfty_Mfl_s As Collection                                                               'Property Collection of Safety Value Moment due to Fixload
  Public sfty_rslt_Mfl_s As Collection                                                          'Property Collection of Safety Result Moment due to Fixload
  '
'Moment due to Windload Pole Collection Property for Each Section
  Public total_MwL_s As Collection                                                              'Property Collection of Total Moment due to Winload
  Public total_MwL_Xs As Collection
  Public total_MwL_Ys As Collection
  '
  Public MTot_wLX_s As Collection
  Public MTot_wLY_s As Collection
  Public Mcomb_wL_s As Collection                                                               'Property Collection of Moment Combine due to Winload (Moment Fixload, Moment Winload, Moment Tension)
  Public strs_MwL_s As Collection                                                               'Property Collection of Stress Moment Combine due to Winload
  Public sfty_Mwl_s As Collection                                                               'Property Collection of Safety Value Moment Combine due to Winload
  Public sfty_rslt_Mwl_s As Collection                                                          'Property Collection of Safety Result Moment Combine due to Winload
  '
'Moment due to Torsional (Torque) Pole Collection Property for Each Section
  Public strs_Mtorq_wL_s As Collection                                                          'Property Collection of Moment Torque (Torsional) Shear Stress due to Wind Load
  Public sfty_Mtorq_wL_s As Collection                                                          'Property Collection of Safety Value Torque (Torsional) due to Wind Load
  Public sfty_rslt_Mtorq_wL_s As Collection                                                     'Property Collection of Safety Result Torque (Torsional) due to Wind Load
  '
'Total Torque (Torsional) Maximal due to Windload Collection Property
  Public total_ts_max_wL As Collection                                                          'Property Collection of Torque (Torsional) Shear Stress Max Winload
  Public Total_comb_strs_wL As Collection                                                       'Property Collection of Maximum Combined Stress Winload
  Public sfty_comb_strs_wL_s As Collection                                                      'Property Collection of Safety Value Maximum Combined Stress Winload
  Public sfty_rslt_comb_strs_wL_s As Collection                                                 'Property Collection of Safety Result Maximum Combined Stress Winload
  '
'Moment due to Seismic Load Each Section Pole Collection Property
  Public total_MsL_s As Collection                                                              'Property Collection of Total Moment Seismic Load
  Public Mcomb_sL_s As Collection                                                               'Property Collection of Moment Combine due to Seismic Load
  Public strs_MsL_s As Collection                                                               'Property Collection of Stress Moment due to Seismic Load
  Public sfty_Msl_s As Collection                                                               'Property Collection of Safety Value Moment due to Seismic Load
  Public sfty_rslt_Msl_s As Collection                                                          'Property Collection of Safety Result Moment due to Seismic Load
  '
'Moment due to Torque (Torsional) due to Seismic Load Each Section Pole Collection Property
  Public strs_mtorq_sL_s As Collection                                                          'Property Collection of Stress Moment Torque (Torsional) due to Seismic Load
  Public sfty_Mtorq_sL_s As Collection                                                          'Property Collection of Safety Value Moment Torque (Torsional) due to Seismic Load
  Public sfty_rslt_Mtorq_sL_s As Collection                                                     'Property Collection of Safety Result Moment Torque (Torsional) due to Seismic Load
  '
'Total Tension Maximal due to Seismic Load Each Section Pole Collection Property
  Public total_ts_max_sL As Collection                                                          'Property Collection of Torsional Shear Stress Max Seismic Load
  Public Total_comb_strs_sL As Collection                                                       'Property Collection of Maximum Combine Stress Seismic Load
  Public sfty_comb_strs_sL_s As Collection                                                      'Property Collection of Safety Value Maximum Combine Stress Seismic Load
  Public sfty_rslt_comb_strs_sL_s As Collection                                                 'Property Collection of Safety Result Combine Stress Seismic Load

'=========================================================== Properties Collection for Any Height ==============================================================================
'
'Fixload Collection Property
  Public total_fl_anyH_s As Collection                                                          'Property Collection of Total Winload
 '
  Public total_wLd_anyH_s As Collection                                                         'Property Collection of Total Winload
  Public total_wLdX_anyH_s As Collection
  Public total_wLdY_anyH_s As Collection
  Public Hrztl_WlX_anyH_s As Collection
  Public Hrztl_WlY_anyH_s As Collection
  Public Rsltn_wL_anyH_s As Collection                                                          'Property Collection of Total Resultan Winload (Total Winload + Tension)
  '
  Public total_sLd_anyH_s As Collection                                                         'Property Collection of Total Seismicload
  Public Rsltn_sL_anyH_s As Collection                                                          'Property Collection of Total Resultan Seismicload (Total Seismicload + Tension)
  '
'Moment due to Fixload Any Height Property
  Public strs_MfL_anyH_s As Collection                                                          'Property Collection of Stress Moment due to Fixload
  Public sfty_Mfl_anyH_s As Collection                                                          'Property Collection of Safety Value Moment due to Fixload
  Public sfty_rslt_Mfl_anyH_s As Collection                                                     'Property Collection of Safety Result Moment due to Fixload
  '
'Moment due to Windload Any Height Property
  Public total_MwL_anyH_s As Collection                                                         'Property Collection of Total Moment due to Winload
  Public total_MwLX_anyH_s As Collection
  Public total_MwLY_anyH_s As Collection
  '
  Public MTot_wLX_anyH_s As Collection
  Public MTot_wLY_anyH_s As Collection
  Public Mcomb_wL_anyH_s As Collection                                                          'Property Collection of Moment Combine due to Winload
  Public strs_MwL_anyH_s As Collection                                                          'Property Collection of Stress Moment due to Winload
  Public sfty_Mwl_anyH_s As Collection                                                          'Property Collection of Safety Value Moment due to Winload
  Public sfty_rslt_Mwl_anyH_s As Collection                                                     'Property Collection of Safety Result Moment due to Winload
  '
'Moment due to Torque (Torsional) dur to Windload Any Height Property
  Public strs_mtorq_wL_anyH_s As Collection                                                     'Property Collection of Stress Moment Torque (Torsional) due to Winload
  Public sfty_Mtorq_wL_anyH_s As Collection                                                     'Property Collection of Safety Value Moment Torque (Torsional) due to Winload
  Public sfty_rslt_Mtorq_wL_anyH_s As Collection                                                'Property Collection of Safety Result Moment Torque (Torsional) due to Winload
  '
'Total Torque Maximal due to Windload Any Height Property
  Public total_ts_max_wL_anyH As Collection                                                     'Property Collection of Total Torque Maximal Winload
  Public Total_comb_strs_wL_anyH As Collection                                                  'Property Collection of Total Combine Stress Winload
  Public sfty_comb_strs_wL_anyH_s As Collection                                                 'Property Collection of Safety Value Combine Stress Winload
  Public sfty_rslt_comb_strs_wL_anyH_s As Collection                                            'Property Collection of Safety Result Combine Stress Winload
  '
'Moment due to Seismic Load Any Height Property
  Public total_MsL_anyH_s As Collection                                                         'Property Collection of Total Seismic Load
  Public Mcomb_sL_anyH_s As Collection                                                          'Property Collection of Moment Combine due to Seismic Load
  Public strs_MsL_anyH_s As Collection                                                          'Property Collection of Stress Moment due to Seismic Load
  Public sfty_Msl_anyH_s As Collection                                                          'Property Collection of Safety Value Moment due to Seismic Load
  Public sfty_rslt_Msl_anyH_s As Collection                                                     'Property Collection of Safety Result Moment due to Seismic Load
  '
'Moment due to Torque (Torsional) Any Height Property
  Public strs_mtorq_sL_anyH_s As Collection                                                     'Property Collection of Stress Moment Torque (Torsional) due to Seismic Load
  Public sfty_Mtorq_sL_anyH_s As Collection                                                     'Property Collection of Safety Value Moment Torque (Torsional) due to Seismic Load
  Public sfty_rslt_Mtorq_sL_anyH_s As Collection                                                'Property Collection of Safety Result Moment Torque (Torsional) due to Seismic Load
  '
'Total Torque Maximum due to Seismic Load Any Height Property
  Public total_ts_max_sL_anyH As Collection                                                     'Property Collection of Total Torque Maximal Seismic Load
  Public Total_comb_strs_sL_anyH As Collection                                                  'Property Collection of Total Combine Stress Seismic Load
  Public sfty_comb_strs_sL_anyH_s As Collection                                                 'Property Collection of Safety Value Combine Stress Seismic Load
  Public sfty_rslt_comb_strs_sL_anyH_s As Collection                                            'Property Collection of Safety Result Combine Stress Seismic Load

'=========================================================== Properties for Each Section of Pole ===================================================================================
'
'Maximum value of Moment due to Fixload from 8 Directional angle
  Public Max_Load_fix_A As Double                                                               'Property of Maximum Value of Moment due to Fixload Direction A
  Public Max_Load_fix_B As Double                                                               'Property of Maximum Value of Moment due to Fixload Direction B
  Public Max_Load_fix_OB As Double                                                              'Property of Maximum Value of Moment due to Fixload Direction Oblique
  Public Max_Load_fix_OB_45_225 As Double                                                       'Property of Maximum Value of Moment due to Fixload Direction Oblique 45 or 225
  Public Max_Load_fix_OB_135_315 As Double                                                      'Property of Maximum Value of Moment due to Fixload Direction Oblique 135 or 315
  '
'Angel Maximum of Moment Moment due to Fixload from 8 Directional Angle
  Public max_ang_A_FL As Double                                                                 'Property of Maximum Angle of Moment due to Fixload Direction A
  Public max_ang_B_FL As Double                                                                 'Property of Maximum Angle of Moment due to Fixload Direction B
  Public max_ang_OB_FL As Double                                                                'Property of Maximum Angle of Moment due to Fixload Direction Oblique
  Public max_ang_OB_FL_45_225 As Double                                                         'Property of Maximum Angle of Moment due to Fixload Direction Oblique 45 or 225
  Public max_ang_OB_FL_135_315  As Double                                                       'Property of Maximum Angle of Moment due to Fixload Direction Oblique 135 or 315
  '
'Index Maximum of Moment due to Fixload from 8 Directional Angle
  Public max_index_A_FL As Double                                                               'Property of Maximum Index of Moment due to Fixload Direction A
  Public max_index_B_FL As Double                                                               'Property of Maximum Index of Moment due to Fixload Direction B
  Public max_index_OB_FL As Double                                                              'Property of Maximum Index of Moment due to Fixload Direction Oblique
  Public max_index_OB_FL_45_225 As Double                                                       'Property of Maximum Index of Moment due to Fixload Direction Oblique 45 or 225
  Public max_index_OB_FL_135_315 As Double                                                      'Property of Maximum Index of Moment due to Fixload Direction Oblique 135 or 315
 '
'Maximum value of Moment combine (windload, Fixload, tension due to windload) from 8 Directional angle
  Public Max_Load_wind_A As Double                                                              'Property of Maximum Value of Moment due to Winload Direction A
  Public Max_Load_wind_B As Double                                                              'Property of Maximum Value of Moment due to Winload Direction B
  Public Max_Load_wind_OB As Double                                                             'Property of Maximum Value of Moment due to Winload Direction Oblique
  Public Max_Load_wind_OB_45_225 As Double                                                      'Property of Maximum Value of Moment due to Winload Direction Oblique 45 or 225
  Public Max_Load_wind_OB_135_315 As Double                                                     'Property of Maximum Value of Moment due to Winload Direction Oblique 135 or 315
  '
'Angel Maximum of Moment combine (windload, Fixload, tension due to windload) from 8 Directional angle
  Public max_ang_A_WL As Double                                                                 'Property of Maximum Angle of Moment due to Winload Direction A
  Public max_ang_B_WL As Double                                                                 'Property of Maximum Angle of Moment due to Winload Direction B
  Public max_ang_OB_WL As Double                                                                'Property of Maximum Angle of Moment due to Winload Direction Oblique
  Public max_ang_OB_WL_45_225 As Double                                                         'Property of Maximum Angle of Moment due to Winload Direction Oblique 45 or 225
  Public max_ang_OB_WL_135_315  As Double                                                       'Property of Maximum Angle of Moment due to Winload Direction Oblique 135 or 315
  '
'Index Maximum of Moment combine (windload, Fixload, tension due to windload) from 8 Directional angle
  Public max_index_A_WL As Double                                                               'Property of Maximum Index of Moment due to Winload Direction A
  Public max_index_B_WL As Double                                                               'Property of Maximum Index of Moment due to Winload Direction B
  Public max_index_OB_WL As Double                                                              'Property of Maximum Index of Moment due to Winload Direction Oblique
  Public max_index_OB_WL_45_225 As Double                                                       'Property of Maximum Index of Moment due to Winload Direction Oblique 45 or 225
  Public max_index_OB_WL_135_315 As Double                                                      'Property of Maximum Index of Moment due to Winload Direction Oblique 135 or315
  '
'Maximum value of Moment combine (Seismic Load, Fixload, tension due to Fixload) from 8 Directional angle
  Public Max_Load_EL_A As Double          'EL = Earthquake Load                                 'Property of Maximum Value of Moment due to Seismic Load Direction A
  Public Max_Load_EL_B As Double                                                                'Property of Maximum Value of Moment due to Seismic Load Direction B
  Public Max_Load_EL_OB As Double                                                               'Property of Maximum Value of Moment due to Seismic Load Direction Oblique
  Public Max_Load_EL_OB_45_225 As Double                                                        'Property of Maximum Value of Moment due to Seismic Load Direction Oblique 45 or 225
  Public Max_Load_EL_OB_135_315 As Double                                                       'Property of Maximum Value of Moment due to Seismic Load Direction Oblique 135 or 315
  '
'Angel Maximum of Moment combine (Seismic Load, Fixload, tension due to Fixload) from 8 Directional angle
  Public max_ang_A_EL As Double                                                                 'Property of Maximum Angle of Moment due to Seismic Load Direction A
  Public max_ang_B_EL As Double                                                                 'Property of Maximum Angle of Moment due to Seismic Load Direction B
  Public max_ang_OB_EL As Double                                                                'Property of Maximum Angle of Moment due to Seismic Load Direction Oblique
  Public max_ang_OB_EL_45_225 As Double                                                         'Property of Maximum Angle of Moment due to Seismic Load Direction Oblique 45 or 225
  Public max_ang_OB_EL_135_315  As Double
  '
'Index Maximum of Moment combine (Seismic Load, Fixload, tension due to Fixload) from 8 Directional angle
  Public max_index_A_EL As Double                                                               'Property of Maximum Index of Moment due to Seismic Load Direction A
  Public max_index_B_EL As Double                                                               'Property of Maximum Index of Moment due to Seismic Load Direction B
  Public max_index_OB_EL As Double                                                              'Property of Maximum Index of Moment due to Seismic Load Direction Oblique
  Public max_index_OB_EL_45_225 As Double                                                       'Property of Maximum Index of Moment due to Seismic Load Direction Oblique 45 or 225
  Public max_index_OB_EL_135_315 As Double                                                      'Property of Maximum Index of Moment due to Seismic Load Direction Oblique 135 or 315
'
'Fixload of Each Section Pole Property
  Public total_fl As Double                                                                     'Property Total Fixload
  Public Total_wld As Double                                                                    'Property Total Winload
  Public Total_wldX As Double
  Public Total_wldY As Double
  '
  Public Hrztl_WlX As Double                                                                    'Horizontal Load X axis
  Public Hrztl_WlY As Double                                                                    'Horizontal Load Y axis
  Public Rsltn_wL As Double                                                                     'Property of Total Resultan Winload (Total Winload + Tension)
  '
  Public Total_sld As Double                                                                    'Property Total Seismicload
  Public Rsltn_sL As Double                                                                     'Property of Total Resultan Seismicload (Total Seismicload + Tension)
  '
'Moment due to Fixload of Each Section Pole Property
  Public strs_MfL As Double                                                                     'Property Stress of Moment due to Fixload
  Public sfty_Mfl As Double                                                                     'Property Safety Value of Moment due to Fixload
  Public sfty_rslt_Mfl As String                                                                'Property Safety Result of Moment due to Fixload
'
'Moment due to Winload of Each Section Pole Property
  Public total_mwl As Double                                                                    'Property Total of Moment due to Winload
  Public Total_Mwl_X As Double
  Public Total_Mwl_Y As Double
  '
  Public MTot_wLX As Double
  Public MTot_wLY As Double
  Public M_Combine_wL As Double                                                                 'Property Moment Combine of Moment due to Winload
  Public strs_MwL As Double                                                                     'Prooperty Stress of Moment due to Winload
  Public sfty_Mwl As Double                                                                     'Property Safety Value of Moment due to Winload
  Public sfty_rslt_Mwl As String                                                                'Property Safety Result of Moment due to Winload
'
'Moment Torque (Torsional) due to Winload of Each Section Pole Property
  Public sheer_strs_mtorq_wL As Double                                                          'Property Sheer Stress Moment Torque (Torsional) due to Winload
  Public sfty_Mtorq_wL As Double                                                                'Property Safety Value Moment Torque (Torsional) due to Winload
  Public sfty_rslt_Mtorq_wL As String                                                           'Property Safety Result Moment Torque (Torsional) due to Winload
'
'Combine shear stress caused by dead load and Windload of Each Section Pole Property
  Public ts_max_wL As Double                                                                    'Property Torsional(Torque) Max Winload
  Public comb_strs_wL As Double                                                                 'Property Combine Stress Winload
  Public sfty_comb_strs_wL As Double                                                            'Property Safety Value Combine Stress Winload
  Public sfty_rslt_comb_strs_wL As String                                                       'Property Safety Result Combine Stress Winload
'
'Moment due to Seismic Load of Each Section Pole Property
  Public Total_Msl As Double                                                                    'Property Total of Moment due to Seismic Load
  Public M_Combine_sL As Double                                                                 'Property Moment Combine of Moment due to Seismic Load
  Public strs_MsL As Double                                                                     'Property Stress of Moment due to Seismic Load
  Public sfty_Msl As Double                                                                     'Property Safety Value of Moment due to Seismic Load
  Public sfty_rslt_Msl As String                                                                'Property Safety Result of Moment due to Seismic Load
'
'Moment Torque (Torsional) due to Seismic Load of Each Section Pole Property
  Public sheer_strs_mtorq_sL As Double                                                          'Property Sheer Stress Moment Torque (Torsional) due to Seismic Load
  Public sfty_Mtorq_sL As Double                                                                'Property Safety Value Moment Torque (Torsional) due to Seismic Load
   Public sfty_rslt_Mtorq_sL As String                                                          'Property Safety Result Moment Torque (Torsional) due to Seismic Load
'
'Combine shear stress caused by dead load and Seismic Load of Each Section Pole Property
  Public ts_max_sL As Double                                                                    'Property Torsional Max Seismic Load
  Public comb_strs_sL As Double                                                                 'Property Combine Stress Seismic Load
  Public sfty_comb_strs_sL As Double                                                            'Property Safety Value of Combine Stress Seismic Load
  Public sfty_rslt_comb_strs_sL As String                                                       'Property Safety Result of Combine Stress Seismic Load
  '
'============================================================== Properties for any Height ==============================================================================================
'
'Max value of Moment due to Fixload from 8 Directional angle
  Public Max_Load_fix_A_anyH As Double                                                          'Property of Maximum Value of Moment due to Fixload Any Height Direction A
  Public Max_Load_fix_B_anyH As Double                                                          'Property of Maximum Value of Moment due to Fixload Any Height Direction B
  Public Max_Load_fix_OB_anyH As Double                                                         'Property of Maximum Value of Moment due to Fixload Any Height Direction Oblique
  Public Max_Load_fix_OB_45_225_anyH As Double                                                  'Property of Maximum Value of Moment due to Fixload Any Height Direction Oblique 45 or 225
  Public Max_Load_fix_OB_135_315_anyH As Double                                                 'Property of Maximum Value of Moment due to Fixload Any Height Direction Oblique 135 or 315
  '
'Angel Max of Moment Moment due to Fixload from 8 Directional Angle
  Public max_ang_A_FL_anyH As Double                                                            'Property of Maximum Angle of Moment due to Fixload Any Height Direction A
  Public max_ang_B_FL_anyH As Double                                                            'Property of Maximum Angle of Moment due to Fixload Any Height Direction B
  Public max_ang_OB_FL_anyH As Double                                                           'Property of Maximum Angle of Moment due to Fixload Any Height Direction Oblique
  Public max_ang_OB_FL_45_225_anyH As Double                                                    'Property of Maximum Angle of Moment due to Fixload Any Height Direction Oblique 45 or 225
  Public max_ang_OB_FL_135_315_anyH  As Double                                                  'Property of Maximum Angle of Moment due to Fixload Any Height Direction Oblique 135 or 315
  '
'Index Max of Moment due to Fixload from 8 Directional Angle
  Public max_index_A_FL_anyH As Double                                                          'Property of Maximum Index of Moment due to Fixload Any Height Direction A
  Public max_index_B_FL_anyH As Double                                                          'Property of Maximum Index of Moment due to Fixload Any Height Direction B
  Public max_index_OB_FL_anyH As Double                                                         'Property of Maximum Index of Moment due to Fixload Any Height Direction Oblique
  Public max_index_OB_FL_45_225_anyH As Double                                                  'Property of Maximum Index of Moment due to Fixload Any Height Direction Oblique 45 or 225
  Public max_index_OB_FL_135_315_anyH As Double                                                 'Property of Maximum Index of Moment due to Fixload Any Height Direction Oblique 135 or 315
 '
'Max value of Moment combine (windload, Fixload, tension due to windload) from 8 Directional angle
  Public Max_Load_wind_A_anyH As Double                                                         'Property of Maximum Value of Moment due to Winload Any Height Direction A
  Public Max_Load_wind_B_anyH As Double                                                         'Property of Maximum Value of Moment due to Winload Any Height Direction B
  Public Max_Load_wind_OB_anyH As Double                                                        'Property of Maximum Value of Moment due to Winload Any Height Direction Oblique
  Public Max_Load_wind_OB_45_225_anyH As Double                                                 'Property of Maximum Value of Moment due to Winload Any Height Direction Oblique 45 or 225
  Public Max_Load_wind_OB_135_315_anyH As Double                                                'Property of Maximum Value of Moment due to Winload Any Height Direction Oblique 135 por 315
  '
'Angel Max of Moment combine (windload, Fixload, tension due to windload) from 8 Directional angle
  Public max_ang_A_WL_anyH As Double                                                            'Property of Maximum Angle of Moment due to Winload Any Height Direction A
  Public max_ang_B_WL_anyH As Double                                                            'Property of Maximum Angle of Moment due to Winload Any Height Direction B
  Public max_ang_OB_WL_anyH As Double                                                           'Property of Maximum Angle of Moment due to Winload Any Height Direction Oblique
  Public max_ang_OB_WL_45_225_anyH As Double                                                    'Property of Maximum Angle of Moment due to Winload Any Height Direction Oblique 45 or 225
  Public max_ang_OB_WL_135_315_anyH  As Double                                                  'Property of Maximum Angle of Moment due to Winload Any Height Direction Oblique 135 or 315
  '
'Index Max of Moment combine (windload, Fixload, tension due to windload) from 8 Directional angle
  Public max_index_A_WL_anyH As Double                                                          'Property of Maximum Index of Moment due to Winload Any Height Direction A
  Public max_index_B_WL_anyH As Double                                                          'Property of Maximum Index of Moment due to Winload Any Height Direction B
  Public max_index_OB_WL_anyH As Double                                                         'Property of Maximum Index of Moment due to Winload Any Height Direction Oblique
  Public max_index_OB_WL_45_225_anyH As Double                                                  'Property of Maximum Index of Moment due to Winload Any Height Direction Oblique 45 or 225
  Public max_index_OB_WL_135_315_anyH As Double                                                 'Property of Maximum Index of Moment due to Winload Any Height Direction Oblique 135 or 315
  '
'Max value of Moment combine (Seismic Load, Fixload, tension due to Fixload) from 8 Directional angle
  Public Max_Load_EL_A_anyH As Double          'EL = Earthquake Load                            'Property of Maximum Value of Moment due to Seismic Load Any Height Direction A
  Public Max_Load_EL_B_anyH As Double                                                           'Property of Maximum Value of Moment due to Seismic Load Any Height Direction B
  Public Max_Load_EL_OB_anyH As Double                                                          'Property of Maximum Value of Moment due to Seismic Load Any Height Direction Oblique
  Public Max_Load_EL_OB_45_225_anyH As Double                                                   'Property of Maximum Value of Moment due to Seismic Load Any Height Direction Oblique 45 or 225
  Public Max_Load_EL_OB_135_315_anyH As Double                                                  'Property of Maximum Value of Moment due to Seismic Load Any Height Direction Oblique 135 or 315
  '
'Angel Max of Moment combine (Seismic Load, Fixload, tension due to Fixload) from 8 Directional angle
  Public max_ang_A_EL_anyH As Double                                                            'Property of Maximum Angle of Moment due to Seismic Load Any Height Direction A
  Public max_ang_B_EL_anyH As Double                                                            'Property of Maximum Angle of Moment due to Seismic Load Any Height Direction B
  Public max_ang_OB_EL_anyH As Double                                                           'Property of Maximum Angle of Moment due to Seismic Load Any Height Direction Oblique
  Public max_ang_OB_EL_45_225_anyH As Double                                                    'Property of Maximum Angle of Moment due to Seismic Load Any Height Direction Oblique 45 or 225
  Public max_ang_OB_EL_135_315_anyH  As Double                                                  'Property of Maximum Angle of Moment due to Seismic Load Any Height Direction Oblique 135 or 315
  '
'Index Max of Moment combine (Seismic Load, Fixload, tension due to Fixload) from 8 Directional angle
  Public max_index_A_EL_anyH As Double                                                          'Property of Maximum Index of Moment due to Seismic Load Any Height Direction A
  Public max_index_B_EL_anyH As Double                                                          'Property of Maximum Index of Moment due to Seismic Load Any Height Direction B
  Public max_index_OB_EL_anyH As Double                                                         'Property of Maximum Index of Moment due to Seismic Load Any Height Direction Oblique
  Public max_index_OB_EL_45_225_anyH As Double                                                  'Property of Maximum Index of Moment due to Seismic Load Any Height Direction Oblique 45 or 225
  Public max_index_OB_EL_135_315_anyH As Double                                                 'Property of Maximum Index of Moment due to Seismic Load Any Height Direction Oblique 135 or 315
  '
'Fixload Property
  Public Total_fl_anyH As Double                                                                'Property Total Fixload
  '
  Public Total_wld_anyH As Double                                                               'Property Total Winload
  Public Total_wldX_anyH As Double
  Public Total_wldY_anyH As Double
  '
  Public Hrztl_WlX_anyH As Double                                                                    'Horizontal Load X axis
  Public Hrztl_WlY_anyH As Double                                                                    'Horizontal Load Y axis
  Public Rsltn_wL_anyH As Double                                                                'Property of Total Resultan Winload (Total Winload + Tension)
  '
  Public Total_sld_anyH As Double                                                               'Property Total Seismicload
  Public Rsltn_sL_anyH As Double                                                                'Property of Total Resultan Seismicload (Total Seismicload + Tension)
  '
'Moment due to Fixload Any Height Property
  Public strs_MfL_anyH As Double                                                                'Property Stress of Moment due to Fixload
  Public sfty_Mfl_anyH As Double                                                                'Property Safety Value of Moment due to Fixload
  Public sfty_rslt_Mfl_anyH As String                                                           'Property Safety Result of Moment due to Fixload

'
'Moment due to Winload Any Height Property
  Public total_MwL_anyH As Double                                                               'Property Total of Moment due to Winload
  Public total_MwLX_anyH As Double
  Public total_MwLY_anyH As Double
  '
  Public MTot_wLX_anyH As Double
  Public MTot_wLY_anyH As Double
  Public M_Combine_wL_anyH As Double                                                            'Property Moment Combine of Moment due to Winload
  Public strs_MwL_anyH As Double                                                                'Prooperty Stress of Moment due to Winload
  Public sfty_Mwl_anyH As Double                                                                'Property Safety Value of Moment due to Winload
  Public sfty_rslt_Mwl_anyH As String                                                           'Property Safety Result of Moment due to Winload
'
'Moment due to Seismic Load Any Height Property
  Public total_MsL_anyH As Double                                                               'Property Total of Moment due to Seismic Load
  Public M_Combine_sL_anyH As Double                                                            'Property Moment Combine of Moment due to Seismic Load
  Public strs_MsL_anyH As Double                                                                'Property Stress of Moment due to Seismic Load
  Public sfty_MsL_anyH As Double                                                                'Property Safety Value of Moment due to Seismic Load
  Public sfty_rslt_MsL_anyH As String                                                           'Property Safety Result of Moment due to Seismic Load
'
'Moment Torque (Torsional) due to Winload Any Height Property
  Public sheer_strs_mtorq_wL_anyH As Double                                                     'Property Sheer Stress Moment Torque (Torsional) due to Winload
  Public sfty_Mtorq_wL_anyH As Double                                                           'Property Safety Value Moment Torque (Torsional) due to Winload
  Public sfty_rslt_Mtorq_wL_anyH As String                                                      'Property Safety Result Moment Torque (Torsional) due to Winload
'
'Moment Torque (Torsional) due to Seismic Load Any Height Property
  Public sheer_strs_mtorq_sL_anyH As Double                                                     'Property Sheer Stress Moment Torque (Torsional) due to Seismic Load
  Public sfty_Mtorq_sL_anyH As Double                                                           'Property Safety Value Moment Torque (Torsional) due to Seismic Load
  Public sfty_rslt_Mtorq_sL_anyH As String                                                      'Property Safety Result Moment Torque (Torsional) due to Seismic Load
'
'Tension Max due to Winload Any Height Property
  Public ts_max_wL_anyH As Double                                                               'Property Tension Max Winload
  Public comb_strs_wL_anyH As Double                                                            'Property Combine Stress Winload
  Public sfty_comb_strs_wL_anyH As Double                                                       'Property Safety Value of Combine Stress Winload
  Public sfty_rslt_comb_strs_wL_anyH As String                                                  'Property Safety Result of Combine Stress Winload
'
'Tension Max due to Seismic Load Any Height Property
  Public ts_max_sL_anyH As Double                                                               'Property Tension Max Seismic Load
  Public comb_strs_sL_anyH As Double                                                            'Property Combine Stress Seismic Load
  Public sfty_comb_strs_sL_anyH As Double                                                       'Property Safety Value of Combine Stress Seismic Load
  Public sfty_rslt_comb_strs_sL_anyH As String                                                  'Property Safety Result of Combine Stress Seismic Load
')

Private Sub Class_Initialize()
'
'=========================================================== Initialize Collection for Each Section of Pole ==============================================================================================
'
'Initialize Load Height Joint Pole Property
  Set total_fl_s = New Collection                                                               'Initialize Collection for Total Fixload Property
  Set total_wLd_s = New Collection                                                              'Initialize Collection for Total Winload Property
  Set total_wLdX_s = New Collection
  Set total_wLdY_s = New Collection
  Set Hrztl_WlX_s = New Collection
  Set Hrztl_WlY_s = New Collection
  Set Rsltn_wL_s = New Collection                                                               'Initialize Collection for Total Resultan Winload (Total Winload + Tension)
  Set total_sLd_s = New Collection                                                              'Initialize Collection for Total Seismicload Property
  Set Rsltn_sL_s = New Collection                                                               'Initialize Collection for Total Resultan Seismicload (Total Seismicload + Tension)
  '
'Initialize Moment Fixload due to Fixload Height Joint Pole Property
  Set strs_MfL_s = New Collection                                                               'Initialize Collection for Stress Moment due to Fixload Property
  Set sfty_Mfl_s = New Collection                                                               'Initialize Collection for Safety Value Moment due to Fixload Property
  Set sfty_rslt_Mfl_s = New Collection                                                          'Initialize Collection for Safety Result Moment due to Fixload Property
  '
'Initialize Moment due to Winload Height Joint Pole Property
  Set total_MwL_s = New Collection                                                              'Initialize Collection for Total Moment due to Winload Property
  Set total_MwL_Xs = New Collection
  Set total_MwL_Ys = New Collection
  '
  Set MTot_wLX_s = New Collection
  Set MTot_wLY_s = New Collection
  Set Mcomb_wL_s = New Collection                                                               'Initialize Collection for Moment Combine Winload Property
  '
  Set strs_MwL_s = New Collection                                                               'Initialize Collection for Stress Moment due to Winload Property
  Set sfty_Mwl_s = New Collection                                                               'Initialize Collection for Safety Value Moment due to Winload Property
  Set sfty_rslt_Mwl_s = New Collection                                                          'Initialize Collection for Safety Result Moment due to Winload Property
  '
'Initialize Moment Torque due to Winload Height Joint Pole Property
  Set strs_Mtorq_wL_s = New Collection                                                          'Initialize Collection for Stress Moment Torsional due to Winload Property
  Set sfty_Mtorq_wL_s = New Collection                                                          'Initialize Collection for Safety Value Moment Torsional due to Winload Property
  Set sfty_rslt_Mtorq_wL_s = New Collection                                                     'Initialize Collection for Safety Result Moment Torsional due to Winload Property
  '
'Initialize Combine shear stress caused by dead load and windload Property
  Set total_ts_max_wL = New Collection                                                          'Initialize Collection for Torsional Shear Stress Max Winload Property
  Set Total_comb_strs_wL = New Collection                                                       'Initialize Collection for Maximum Combined Stress Winload Property
  Set sfty_comb_strs_wL_s = New Collection                                                      'Initialize Collection for Safety Value Maximum Combine Stress Winload Property
  Set sfty_rslt_comb_strs_wL_s = New Collection                                                 'Initialize Collection for Safety Result Maximum Combine Stress Winload Property
  '
'Initialize Moment due to Seismic Load  Height Joint Pole Property
  Set total_MsL_s = New Collection                                                              'Initialize Collection for Total Moment Seismic Load Property
  Set Mcomb_sL_s = New Collection                                                               'Initialize Collection for Moment Combine Seismic Load Property
  Set strs_MsL_s = New Collection                                                               'Initialize Collection for Stress Moment due to Seismic Load Property
  Set sfty_Msl_s = New Collection                                                               'Initialize Collection for Safety Value Moment due to Seismic Load Property
  Set sfty_rslt_Msl_s = New Collection                                                          'Initialize Collection for Safety Result Moment due to Seismic Load Property
  '
'Initialize Moment Torque (Torsional) due to Seismic Load Height Joint Pole Property
  Set strs_mtorq_sL_s = New Collection                                                          'Initialize Collection for Stress Moment Torque (Torsional) due to Seismic Load Property
  Set sfty_Mtorq_sL_s = New Collection                                                          'Initialize Collection for Safety Value Moment Torque (Torsional) due to Seismic Load Property
  Set sfty_rslt_Mtorq_sL_s = New Collection                                                     'Initialize Collection for Safety Result Moment Torque (Torsional) due to Seismic Load Property
  '
'Initialize Combine shear stress caused by dead load and Seismic Load Property
  Set total_ts_max_sL = New Collection                                                          'Initialize Collection for Torsional Shear Stress Max Seismic Load Property
  Set Total_comb_strs_sL = New Collection                                                       'Initialize Collection for Maximum Combined Stress Seismic Load Property
  Set sfty_comb_strs_sL_s = New Collection                                                      'Initialize Collection for Safety Value Maximum Combine Stress Seismic Load Property
  Set sfty_rslt_comb_strs_sL_s = New Collection                                                 'Initialize Collection for Safety Result Maximum Combine Stress Seismic Load Property
'
'=========================================================== Initialize Collection for Any Height ==============================================================================================
'
'Initialize Total Fixload Any Height Property
  Set total_fl_anyH_s = New Collection
  '
  Set total_wLd_anyH_s = New Collection                                                         'Initialize Collection for Total Winload Property
  Set total_wLdX_anyH_s = New Collection
  Set total_wLdY_anyH_s = New Collection
  '
  Set Hrztl_WlX_anyH_s = New Collection
  Set Hrztl_WlY_anyH_s = New Collection
  Set Rsltn_wL_anyH_s = New Collection                                                          'Initialize Collection for Total Resultan Winload (Total Winload + Tension)
  Set total_sLd_anyH_s = New Collection                                                         'Initialize Collection for Total Seismicload Property
  Set Rsltn_sL_anyH_s = New Collection                                                          'Initialize Collection for Total Resultan Seismicload (Total Seismicload + Tension)
  '
'Initialize Moment Fixload due to Fixload Any Height Property
  Set strs_MfL_anyH_s = New Collection                                                          'Initialize Collection for Stress Moment due to Fixload Property
  Set sfty_Mfl_anyH_s = New Collection                                                          'Initialize Collection for Safety Value Moment due to Fixload Property
  Set sfty_rslt_Mfl_anyH_s = New Collection                                                     'Initialize Collection for Safety Result Moment due to Fixload Property
  '
'Initialize Moment due to Winload Any Height Property
  Set total_MwL_anyH_s = New Collection                                                         'Initialize Collection for Total Moment due to Winload Property
  Set total_MwLX_anyH_s = New Collection
  Set total_MwLY_anyH_s = New Collection
  '
  Set MTot_wLX_anyH_s = New Collection
  Set MTot_wLY_anyH_s = New Collection
  Set Mcomb_wL_anyH_s = New Collection                                                          'Initialize Collection for Moment Combine Winload Property
  Set strs_MwL_anyH_s = New Collection                                                          'Initialize Collection for Stress Moment due to Winload Property
  Set sfty_Mwl_anyH_s = New Collection                                                          'Initialize Collection for Safety Value Moment due to Winload Property
  Set sfty_rslt_Mwl_anyH_s = New Collection                                                     'Initialize Collection for Safety Result Moment due to Winload Property
  '
'Initialize Moment due to Seismic Load Any Height Property
  Set total_MsL_anyH_s = New Collection                                                         'Initialize Collection for Total Seismic Load Property
  Set Mcomb_sL_anyH_s = New Collection                                                          'Initialize Collection for Moment Combine Seismic Load Property
  Set strs_MsL_anyH_s = New Collection                                                          'Initialize Collection for Stress Moment due to Seismic Load Property
  Set sfty_Msl_anyH_s = New Collection                                                          'Initialize Collection for Safety Value Moment due to Seismic Load Property
  Set sfty_rslt_Msl_anyH_s = New Collection                                                     'Initialize Collection for Safety Result Moment due to Seismic Load Property
  '
'Initialize Moment Torque due to Winload Any Height Property
  Set strs_mtorq_wL_anyH_s = New Collection                                                     'Initialize Collection for Stress Moment Torsional due to Winload Property
  Set sfty_Mtorq_wL_anyH_s = New Collection                                                     'Initialize Collection for Safety Value Moment Torsional due to Winload Property
  Set sfty_rslt_Mtorq_wL_anyH_s = New Collection                                                'Initialize Collection for Safety Result Moment Torsional due to Winload Property
  '
'Initialize Moment Torque (Torsional) due to Seismic Load Any Height Property
  Set strs_mtorq_sL_anyH_s = New Collection                                                     'Initialize Collection for Stress Moment Torque (Torsional) due to Seismic Load Property
  Set sfty_Mtorq_sL_anyH_s = New Collection                                                     'Initialize Collection for Safety Value Moment Torque (Torsional) due to Seismic Load Property
  Set sfty_rslt_Mtorq_sL_anyH_s = New Collection                                                'Initialize Collection for Safety Result Moment Torque (Torsional) due to Seismic Load Property
  '
'Initialize Total Tension Maximal due to Winload Any Height Property
  Set total_ts_max_wL_anyH = New Collection                                                     'Initialize Collection for Total Tension Max Winload Property
  Set Total_comb_strs_wL_anyH = New Collection                                                  'Initialize Collection for Total Combine Stress Winload Property
  Set sfty_comb_strs_wL_anyH_s = New Collection                                                 'Initialize Collection for Safety Value of Combine Stress Winload Property
  Set sfty_rslt_comb_strs_wL_anyH_s = New Collection                                            'Initialize Collection for Safety Result of Combine Stress Winload Property
  '
'Initialize Total Tension Maximal due to Seismic Load Any Height Property
  Set total_ts_max_sL_anyH = New Collection                                                     'Initialize Collection for Total Tension Max Seismic Load Property
  Set Total_comb_strs_sL_anyH = New Collection                                                  'Initialize Collection for Total Combine Stress Seismic Load Property
  Set sfty_comb_strs_sL_anyH_s = New Collection                                                 'Initialize Collection for Safety Value of Combine Stress Seismic Load Property
  Set sfty_rslt_comb_strs_sL_anyH_s = New Collection                                            'Initialize Collection for Safety Result of Combine Stress Seismic Load Property
End Sub
')

'==========================================
' These are methods for Each Section Pole
'==========================================
'
'
'
'====================================================== Total of Section Moment due to Fixload ===============================================================
'
Public Sub Calc_Total_Fixload()                                                                 'Method for calculation Total of Fixload (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    '
    Dim each_D As Do_kmpl                                                                       'Declare each_D as an object of the Do_kmpl class
    Set each_D = New Do_kmpl
    '
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    Dim each_A As Arm_Kmpl                                                                      'Declare each_A as an object of the Arm_Kmpl class
    Set each_A = New Arm_Kmpl
    '
    Dim each_W As OHW_Kmpl                                                                      'Declare each_W as an object of the OHW_Kmpl class
    Set each_W = New OHW_Kmpl
    '
    each_D.Assy h_pjt(i)                                                                        'Call Assy method on the Do_kmpl class, "h_pjt(i)" is the argument for procedure
    each_D.Total_Fixload                                                                        'Call Total_Fixload method on the Do_kmpl class
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_kmpl class, "h_pjt(i)" is the argument for procedure
    each_P.Total_Fixload                                                                        'Call Total_Fixload method on the Pole_kmpl class
    
    each_A.Assy h_pjt(i)                                                                        'Call Assy method on the Arm_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_A.Total_Fixload                                                                        'Call Total_Fixload method on the Arm_Kmpl class
     
    each_W.Assy h_pjt(i)                                                                        'Call Assy method on the OHW_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_W.Total_Fixload                                                                        'Call Total_Fixload method on the each_W class
    '
    'Calculation of Total of Fixload Each Section
    'For k = 1 To each_P.total_fls.Count
      For j = 1 To Drnos
        total_fl = Fkb_SF(each_D.total_fls.Item(j) + each_A.total_fls.Item(j) + _
                   each_W.total_fls.Item(j) + each_P.total_fls.Item(j), 3)
      '
      'Add Property Total_fl to Collection Property total_fl_s
       total_fl_s.Add total_fl
      Next j
    'Next k
    '
  Next i
'
End Sub
')

Public Sub Calc_Total_wl()                                                                      'Method for calculation Total of Winload (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    '
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    Dim each_D As Do_kmpl                                                                       'Declare each_D as an object of the Do_kmpl class
    Set each_D = New Do_kmpl
    '
    Dim each_A As Arm_Kmpl                                                                      'Declare each_A as an object of the Arm_Kmpl class
    Set each_A = New Arm_Kmpl
    '
    Dim each_W As OHW_Kmpl                                                                      'Declare each_W as an object of the OHW_Kmpl class
    Set each_W = New OHW_Kmpl
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_kmpl class, "h_pjt(i)" is the argument for procedure
    each_P.Total_Winload                                                                        'Call Total_Winload method on the Pole_kmpl class
    each_P.Total_Winload_X
    each_P.Total_Winload_Y
    '
    each_D.Assy h_pjt(i)                                                                        'Call Assy method on the Do_kmpl class, "h_pjt(i)" is the argument for procedure
    each_D.Total_Winload                                                                        'Call Total_Winload method on the Do_kmpl class
    each_D.Total_windload_X
    each_D.Total_windload_Y
    '
    each_A.Assy h_pjt(i)                                                                        'Call Assy method on the Arm_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_A.Total_Winload                                                                        'Call Total_Winload method on the Arm_Kmpl class
    each_A.Total_Winload_X
    each_A.Total_Winload_Y
    '
    each_W.Assy h_pjt(i)                                                                        'Call Assy method on the OHW_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_W.Total_Winload                                                                        'Call Total_Winload method on the each_W class
    each_W.Total_Winload_X
    each_W.Total_Winload_Y
    each_W.Total_tension_wLX
    each_W.Total_tension_wLY
    '
    'Calculation of Total of Winload Each Section
    'For k = 1 To each_P.total_wls.Count
      For j = 1 To Drnos
        Total_wld = Fkb_SF(each_P.total_wls.Item(j) + each_D.total_wls.Item(j) + _
        each_A.total_wls.Item(j) + each_W.total_wls.Item(j), 3)
        '
        'Calculation of Total of Winload Each Section in X axis
        Total_wldX = Fkb_SF(each_P.total_wlXs.Item(j) + each_D.total_wlXs.Item(j) + _
        each_A.total_wlXs.Item(j) + each_W.total_wlXs.Item(j), 3)
        '
        'Calculation of Total of Winload Each Section in Y axis
        Total_wldY = Fkb_SF(each_P.total_wlYs.Item(j) + each_D.total_wlYs.Item(j) + _
        each_A.total_wlYs.Item(j) + each_W.total_wlYs.Item(j), 3)
       
       'Add Property Total_wld to Collection Property total_wLd_s
        total_wLd_s.Add Total_wld
       '
       'Add Property Total_wld to Collection Property total_wLd_s
        total_wLdX_s.Add Total_wldX
        '
       'Add Property Total_wld to Collection Property total_wLd_s
        total_wLdY_s.Add Total_wldY
      Next j
    'Next k
    '
  Next i
'
End Sub
')

Public Sub Resultan_WnL()                                                                      'Method for Calculation Total Resultan Winload (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_W As OHW_Kmpl                                                                      'Declare each_W as an object of the OHW_Kmpl class
    Set each_W = New OHW_Kmpl
    '
    each_W.Assy h_pjt(i)                                                                        'Call Assy method on the OHW_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_W.Total_tension_wL                                                                     'Call Total_Mtension_wL method on the OHW_Kmpl class
    each_W.Total_tension_wLX
    each_W.Total_tension_wLY
    '
    Hrztl_WlX = 0
    Hrztl_WlY = 0
    Rsltn_wL = 0
    '
    For j = 0 To Drnos - 1
      'Calculation of Resultan Winload Each Section
      Hrztl_WlX = Fkb_SF(total_wLdX_s.Item(j + 1 + 8 * i) + each_W.total_tns_wLX.Item(j + 1), 3)
      '
      'Calculation of Resultan Winload Each Section
      Hrztl_WlY = Fkb_SF(total_wLdY_s.Item(j + 1 + 8 * i) + each_W.total_tns_wLY.Item(j + 1), 3)
      '
      'Calculation of Resultan Winload Each Section
      Rsltn_wL = Fkb_SF((Hrztl_WlX ^ 2 + Hrztl_WlY ^ 2) ^ 0.5, 3)
      '
      'Add Property to collection
      Hrztl_WlX_s.Add Hrztl_WlX
      '
      'Add Property to collection
      Hrztl_WlY_s.Add Hrztl_WlY
      
      'Add Property Rsltn_wL to Collection Property Rsltn_wL_s
      Rsltn_wL_s.Add Rsltn_wL
    Next j
  Next i
'
End Sub
')

Public Sub Calc_Total_sl()                                                                     'Method for calculation Total of Moment due to Seismicload (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
  '
    Dim each_D As Do_kmpl                                                                       'Declare each_D as an object of the Do_kmpl class
    Set each_D = New Do_kmpl
    '
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    Dim each_A As Arm_Kmpl                                                                      'Declare each_A as an object of the Arm_Kmpl class
    Set each_A = New Arm_Kmpl
    '
    Dim each_W As OHW_Kmpl                                                                      'Declare each_W as an object of the OHW_Kmpl class
    Set each_W = New OHW_Kmpl
    '
    each_D.Assy h_pjt(i)                                                                        'Call Assy method on the Do_kmpl class, "h_pjt(i)" is the argument for procedure
    each_D.Total_Seismicload                                                                    'Call Total_Seismicload method on the Do_kmpl class
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_kmpl class, "h_pjt(i)" is the argument for procedure
    each_P.Total_Seismicload                                                                    'Call Total_Seismicload method on the Pole_kmpl class
    '
    each_A.Assy h_pjt(i)                                                                        'Call Assy method on the Arm_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_A.Total_Seismicload                                                                    'Call Total_Seismicload method on the Arm_Kmpl class
    '
    each_W.Assy h_pjt(i)                                                                        'Call Assy method on the OHW_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_W.Total_Seismicload                                                                    'Call Total_Seismicload method on the OHW_Kmpl class
    '
    'For k = 1 To each_P.total_sls.Count
      For j = 1 To Drnos
        'Calculation Total of Seismicload Each Section
        Total_sld = Fkb_SF(each_D.total_sls.Item(j) + each_A.total_sls.Item(j) + _
                  each_P.total_sls.Item(j) + each_W.total_sls.Item(j), 3)
      '
      'Add Property Total_sld to  Collection Property total_sLd_s
       total_sLd_s.Add Total_sld
      Next j
    'Next k
  Next i
'
End Sub
')

Public Sub Resultan_sL()                                                                       'Method for Calculation Total Resultan Seismic Load (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_W As OHW_Kmpl                                                                      'Declare each_W as an object of the OHW_Kmpl class
    Set each_W = New OHW_Kmpl
    '
    each_W.Assy h_pjt(i)                                                                        'Call Assy method on the OHW_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_W.Total_tension_sL                                                                     'Call Total_tension_sL method on the OHW_Kmpl class
    '
    Rsltn_sL = 0
    For j = 0 To Drnos - 1
      'Calculation of Resultan Seismicload Each Section
      Rsltn_sL = Fkb_SF(total_sLd_s.Item(j + 1 + 8 * i) + (Abs(each_W.total_tns_sL.Item(j + 1))), 3)
      '
      'Add Property Rsltn_sL to Collection Property Rsltn_sL_s
      Rsltn_sL_s.Add Rsltn_sL
    Next j
  Next i
'
End Sub
')

Public Sub get_Max_Val_Fixload()                                                                'Method for Calculation to Get Maximum Value Moment due to Fixload (Each Section Pole)
'
  'Method to get maximum value from 8 Wind Derectional angle for each section
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_A As Arm_Kmpl                                                                      'Declare each_A as an object of the Arm_Kmpl class
    Set each_A = New Arm_Kmpl
    '
    each_A.Assy h_pjt(i)                                                                        'Call Assy method on the Arm_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_A.Total_MfL_Ang                                                                        'Call Total_MfL_Ang method on the Arm_Kmpl class
    '
    Max_Load_fix_A = 0
    For j = 0 To 1                                                                              'Index Direction A
      If Max_Load_fix_A <= Abs(each_A.total_mfls.Item(j + 1)) Then
        Max_Load_fix_A = Abs(each_A.total_mfls.Item(j + 1))
        max_ang_A_FL = AoW(j) * (180 / phi)
        max_index_A_FL = j
      End If
    Next j
    '
    Max_Load_fix_B = 0
    For j = 2 To 3                                                                              'Index Direction B
      If Max_Load_fix_B <= Abs(each_A.total_mfls.Item(j + 1)) Then
        Max_Load_fix_B = Abs(each_A.total_mfls.Item(j + 1))
        max_ang_B_FL = AoW(j) * (180 / phi)
        max_index_B_FL = j
      End If
    Next j
    '
    Max_Load_fix_OB = 0
    For j = 4 To 7                                                                              'Index Direction Oblique of 4 angles (45, 225, 135, or 315)
      If Max_Load_fix_OB <= Abs(each_A.total_mfls.Item(j + 1)) Then
        Max_Load_fix_OB = Abs(each_A.total_mfls.Item(j + 1))
        max_ang_OB_FL = AoW(j) * (180 / phi)
        max_index_OB_FL = j
      End If
    Next j
    '
    Max_Load_fix_OB_45_225 = 0
    For j = 4 To 5                                                                              'Index Direction Oblique of 2 angles (45 or 225)
      If Max_Load_fix_OB_45_225 <= Abs(each_A.total_mfls.Item(j + 1)) Then
        Max_Load_fix_OB_45_225 = Abs(each_A.total_mfls.Item(j + 1))
        max_ang_OB_FL_45_225 = AoW(j) * (180 / phi)
        max_index_OB_FL_45_225 = j
      End If
    Next j
    '
    Max_Load_fix_OB_135_315 = 0
    For j = 6 To 7                                                                              'Index Direction Oblique of 2 angles (135 or 315)
      If Max_Load_fix_OB_135_315 <= Abs(each_A.total_mfls.Item(j + 1)) Then
        Max_Load_fix_OB_135_315 = Abs(each_A.total_mfls.Item(j + 1))
        max_ang_OB_FL_135_315 = AoW(j) * (180 / phi)
        max_index_OB_FL_135_315 = j
      End If
    Next j
  Next i
'
End Sub
')

Public Sub Calc_Stress_MfL()                                                                    'Method for calculation Stress of Total Moment due to Fixload (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    Dim each_A As Arm_Kmpl                                                                      'Declare each_A as an object of the Arm_Kmpl class
    Set each_A = New Arm_Kmpl
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_kmpl class, "h_pjt(i)" is the argument for procedure
    '
    each_A.Assy h_pjt(i)                                                                        'Call Assy method on the Arm_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_A.Total_MfL_Ang                                                                        'Call Total_MfL_Ang method on the Arm_Kmpl class
    '
    For j = 0 To Drnos - 1
      'Calculation of Stress Total Moment due to Fixload Height of Joint Pole
      strs_MfL = Fkb_SF(Abs(each_A.total_mfls.Item(j + 1)) / each_P.pole_s.Item(j + 1 + 8 * i).sec_mod, 3)
      '
      'Add Property strs_MfL to Collection Property strs_MfL_s
      strs_MfL_s.Add strs_MfL
    Next j
  Next i
'
End Sub
')

Public Sub Calc_Safety_Mfl()                                                                    'Method for Calculation Safety of Total Moment due to Fixload (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_kmpl class, "h_pjt(i)" is the argument for procedure
    '
    For j = 0 To Drnos - 1
      'Calculation of Safety Total Moment due to Fixload Height of Joint Pole
      sfty_Mfl = Fkb_SF(strs_MfL_s.Item(j + 1 + 8 * i) / each_P.pole_s.Item(j + 1 + 8 * i).f_b, 3)
      '
      If sfty_Mfl < 1 Then
        sfty_rslt_Mfl = "O.K"
      Else
        sfty_rslt_Mfl = "N.G"
      End If
      '
      'Add Property sfty_Mfl to Collection Property sfty_Mfl_s
      sfty_Mfl_s.Add sfty_Mfl
      '
      'Add Property sfty_rslt_Mfl to Collection Property sfty_rslt_Mfl_s
      sfty_rslt_Mfl_s.Add sfty_rslt_Mfl
    Next j
  Next i
'
End Sub
')

'
'====================================================== Total of Section Moment due to Winload ===============================================================
'
Public Sub Calc_Total_Mwl_Ang()                                                                 'Method for Calculation Total of Moment due to Windload (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    '
    Dim each_D As Do_kmpl                                                                       'Declare each_D as an object of the Do_kmpl class
    Set each_D = New Do_kmpl
    '
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    Dim each_A As Arm_Kmpl                                                                      'Declare each_A as an object of the Arm_Kmpl class
    Set each_A = New Arm_Kmpl
    '
    Dim each_W As OHW_Kmpl                                                                      'Declare each_W as an object of the OHW_Kmpl class
    Set each_W = New OHW_Kmpl
    '
    each_D.Assy h_pjt(i)                                                                        'Call Assy method on the Do_kmpl class, "h_pjt(i)" is the argument for procedure
    each_D.Total_Mwl_Ang                                                                        'Call Total_Mwl_Ang method on the Do_kmpl class
    each_D.Total_Mwl_X
    each_D.Total_Mwl_Y
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_kmpl class, "h_pjt(i)" is the argument for procedure
    each_P.total_mwl                                                                            'Call Total_Mwl method on the Pole_kmpl class
    each_P.Total_Mwl_X
    each_P.Total_Mwl_Y
    '
    each_A.Assy h_pjt(i)                                                                        'Call Assy method on the Arm_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_A.Total_Mwl_Ang                                                                        'Call Total_Mwl_Ang method on the Arm_Kmpl class
    each_A.Total_Mwl_X
    each_A.Total_Mwl_Y
     
    each_W.Assy h_pjt(i)                                                                        'Call Assy method on the OHW_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_W.Total_Mwl_Ang                                                                        'Call Total_Mwl_Ang method on the each_W class
    each_W.Total_Mwl_X
    each_W.Total_Mwl_Y
    '
    'Calculation of Total of Moment due to Winload Height of Joint Pole
    'For k = 1 To each_P.total_Mwls.Count
      For j = 1 To Drnos
        total_mwl = Fkb_SF(each_D.total_Mwls.Item(j) + each_A.total_Mwls.Item(j) + _
                   each_W.total_Mwls.Item(j) + each_P.total_Mwls.Item(j), 3)
        '
        'X Axis
        Total_Mwl_X = Fkb_SF(each_D.total_MwL_Xs.Item(j) + each_A.total_MwL_Xs.Item(j) + _
                   each_W.total_MwL_Xs.Item(j) + each_P.total_MwL_Xs.Item(j), 3)
        '
        'Y Axis
        Total_Mwl_Y = Fkb_SF(each_D.total_MwL_Ys.Item(j) + each_A.total_MwL_Ys.Item(j) + _
                   each_W.total_MwL_Ys.Item(j) + each_P.total_MwL_Ys.Item(j), 3)
        '
        'Add Property total_wL to Collection Property total_MwL_s
        total_MwL_s.Add total_mwl
        '
        'X axis
        total_MwL_Xs.Add Total_Mwl_X
        '
        'Y axis
        total_MwL_Ys.Add Total_Mwl_Y
        '
      Next j
    'Next k
    '
  Next i
'
End Sub
')


Public Sub Total_Mcombine_Due_to_wL()                                                           'Method for Calculation Total Moment Combine due to Windload (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_A As Arm_Kmpl                                                                      'Declare each_A as an object of the Arm_Kmpl class
    Set each_A = New Arm_Kmpl
    '
    Dim each_W As OHW_Kmpl                                                                      'Declare each_W as an object of the OHW_Kmpl class
    Set each_W = New OHW_Kmpl
    '
    each_A.Assy h_pjt(i)                                                                        'Call Assy method on the Arm_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_A.Total_MfL_Ang                                                                        'Call Total_MfL_Ang method on the Arm_Kmpl class
    each_A.Total_MfL_X
    each_A.Total_MfL_Y
    '
    each_W.Assy h_pjt(i)                                                                        'Call Assy method on the OHW_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_W.Total_Mtension_wL                                                                    'Call Total_Mtension_wL method on the OHW_Kmpl class
    each_W.Total_Mtension_wLX
    each_W.Total_Mtension_wLY
    
    '
    M_Combine_wL = 0
    For j = 0 To Drnos - 1
      'Calculation of Bending Moment when Fixload and Winload are applied (Moment Combine) Height of Joint Pole
'      M_Combine_wL = Fkb_SF(Abs(each_A.total_mfls.Item(j + 1)) + total_MwL_s.Item(j + 1 + 8 * i) + _
'                    (Abs(each_W.total_Mtns_wL.Item(j + 1))), 3)
'
      MTot_wLX = Fkb_SF(Abs(each_A.total_mfl_Xs.Item(j + 1) + total_MwL_Xs.Item(j + 1 + 8 * i) + each_W.total_Mtns_wLX.Item(j + 1)), 3)
      
      MTot_wLY = Fkb_SF(Abs(each_A.total_mfl_Ys.Item(j + 1) + total_MwL_Ys.Item(j + 1 + 8 * i) + each_W.total_Mtns_wLY.Item(j + 1)), 3)

      M_Combine_wL = Fkb_SF((MTot_wLX ^ 2 + MTot_wLY ^ 2) ^ 0.5, 3)
      '
      'Total in X axis
      MTot_wLX_s.Add MTot_wLX
      
      'Total in Y axis
      MTot_wLY_s.Add MTot_wLY
      '
      'Add Property M_Combine_wL to Collection Property Mcomb_wL_s
      Mcomb_wL_s.Add M_Combine_wL
    Next j
  Next i
'
'Stop


End Sub
')

Public Sub get_Max_Val_wind()                                                                   'Method for Calculation to Get Maximum Value Moment due to Windload (Each Section Pole)
'
  'Method to get maximum value from 8 Wind Derectional angle for each section
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Max_Load_wind_A = 0
    For j = 0 To 1                                                                              'Index Direction A
      If Max_Load_wind_A < Mcomb_wL_s.Item(j + 1 + 8 * i) Then
        Max_Load_wind_A = Mcomb_wL_s.Item(j + 1 + 8 * i)
        max_ang_A_WL = AoW(j) * (180 / phi)
        max_index_A_WL = j
      End If
    Next j
    '
    Max_Load_wind_B = 0
    For j = 2 To 3                                                                              'Index Direction B
      If Max_Load_wind_B < Mcomb_wL_s.Item(j + 1 + 8 * i) Then
        Max_Load_wind_B = Mcomb_wL_s.Item(j + 1 + 8 * i)
        max_ang_B_WL = AoW(j) * (180 / phi)
        max_index_B_WL = j
      End If
    Next j
    '
    Max_Load_wind_OB = 0
    For j = 4 To 7                                                                              'Index Direction Oblique of 4 angles (45, 225, 135, or 315)
      If Max_Load_wind_OB < Mcomb_wL_s.Item(j + 1 + 8 * i) Then
        Max_Load_wind_OB = Mcomb_wL_s.Item(j + 1 + 8 * i)
        max_ang_OB_WL = AoW(j) * (180 / phi)
        max_index_OB_WL = j
      End If
    Next j
    '
    Max_Load_wind_OB_45_225 = 0
    For j = 4 To 5                                                                              'Index Direction Oblique of 2 angles (45 or 225)
      If Max_Load_wind_OB_45_225 < Mcomb_wL_s.Item(j + 1 + 8 * i) Then
        Max_Load_wind_OB_45_225 = Mcomb_wL_s.Item(j + 1 + 8 * i)
        max_ang_OB_WL_45_225 = AoW(j) * (180 / phi)
        max_index_OB_WL_45_225 = j
      End If
    Next j
    '
    Max_Load_wind_OB_135_315 = 0
    For j = 6 To 7                                                                              'Index Direction Oblique of 2 angles (135 or 315)
      If Max_Load_wind_OB_135_315 < Mcomb_wL_s.Item(j + 1 + 8 * i) Then
        Max_Load_wind_OB_135_315 = Mcomb_wL_s.Item(j + 1 + 8 * i)
        max_ang_OB_WL_135_315 = AoW(j) * (180 / phi)
        max_index_OB_WL_135_315 = j
      End If
    Next j
  Next i
'
End Sub
')

Public Sub Calc_Stress_MwL()                                                                    'Method for Calculation Stress of Total Moment due to Windload (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_kmpl class, "h_pjt(i)" is the argument for procedure
    '
    For j = 0 To Drnos - 1
      'Calculation Stress of Total Moment due to Winload Height of Joint Pole
      strs_MwL = Fkb_SF(Mcomb_wL_s.Item(j + 1 + 8 * i) / each_P.pole_s.Item(j + 1 + 8 * i).sec_mod, 3)
      '
      'Add Property strs_MwL to Collection Property strs_MwL_s
      strs_MwL_s.Add strs_MwL
    Next j
  Next i
'
End Sub
')

Public Sub Calc_Safety_Mwl()                                                                    'Method for Calculation Safety of Total Moment due to Windload (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
     each_P.Assy h_pjt(i)                                                                       'Call Assy method on the Pole_kmpl class, "h_pjt(i)" is the argument for procedure
    '
    For j = 0 To Drnos - 1
      'Calculation Safety of Total Moment due to Winload Height of Joint Pole
      sfty_Mwl = Fkb_SF(strs_MwL_s.Item(j + 1 + 8 * i) / each_P.pole_s.Item(j + 1 + 8 * i).s_fb, 3)
      '
      If sfty_Mwl < 1 Then
        sfty_rslt_Mwl = "O.K"
      Else
        sfty_rslt_Mwl = "N.G"
      End If
      '
      'Add Property sfty_Mwl to Collection Property sfty_Mwl_s
      sfty_Mwl_s.Add sfty_Mwl
      '
      'Add Property sfty_rslt_Mwl to Collection Property sfty_rslt_Mwl_s
      sfty_rslt_Mwl_s.Add sfty_rslt_Mwl
    Next j
  Next i
'
End Sub
')

'
'====================================================== Total of Section Moment Torque Moment Due to Windload ===============================================================
'
Public Sub Calc_Sheer_Stress_Mtorq_wL()                                                         'Method for Calculation Torsional Sheer Stress caused by Windload (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    Dim each_A As Arm_Kmpl                                                                      'Declare each_A as an object of the Arm_Kmpl class
    Set each_A = New Arm_Kmpl
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_kmpl class, "h_pjt(i)" is the argument for procedure
    '
    each_A.Assy h_pjt(i)                                                                        'Call Assy method on the Arm_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_A.Total_Mtorq_wL                                                                       'Call Total_Mtorq_wL method on the Arm_Kmpl class
    '
    For j = 0 To Drnos - 1
      'Calculation Torsional Sheer Stress caused by Winload Height of Joint Pole
      sheer_strs_mtorq_wL = Fkb_SF((Abs(each_A.Total_Mtorq_wL_s.Item(j + 1)) * _
                    each_P.pole_s.Item(j + 1).Dia_sec) / (2 * each_P.pole_s.Item(j + 1).Ip), 3)
      '
      'Add Property sheer_strs_mtorq_wL to Collection Property strs_Mtorq_wL_s
      strs_Mtorq_wL_s.Add sheer_strs_mtorq_wL
    Next j
  Next i
'
End Sub
')

Public Sub Calc_Safety_Mtorq_wL()                                                               'Method for Calculation Safety of Torsional Sheer Stress caused by Windload (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_kmpl class, "h_pjt(i)" is the argument for procedure
    '
    For j = 0 To Drnos - 1
      'Calculation Safety of Torsional Sheer Stress caused by Winload Height of Joint Pole
      sfty_Mtorq_wL = Fkb_SF(Abs(strs_Mtorq_wL_s.Item(j + 1 + 8 * i)) / each_P.pole_s.Item(j + 1 + 8 * i).s_fs, 3)
      '
      If sfty_Mtorq_wL < 1 Then
        sfty_rslt_Mtorq_wL = "O.K"
      Else
        sfty_rslt_Mtorq_wL = "N.G"
      End If
      '
      'Add Property sfty_Mtorq_wL to Collection Property sfty_Mtorq_wL_s
      sfty_Mtorq_wL_s.Add sfty_Mtorq_wL
      '
      'Add Property sfty_rslt_Mtorq_wL to Collection Property sfty_rslt_Mtorq_wL_s
      sfty_rslt_Mtorq_wL_s.Add sfty_rslt_Mtorq_wL
    Next j
  Next i
'
End Sub
')

'
'====================================================== Combine Shear Stress caused by Dead Load and Windload ===============================================================
'
Public Sub Calc_Ts_Sheer_Stress_Max_wL()                                                        'Method for Calculation Torsional Sheer Stress Maximal caused by Winload (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_kmpl class, "h_pjt(i)" is the argument for procedure
    '
    For j = 0 To Drnos - 1
      'Calculation Torsional Sheer Stress Maximal caused by Winload Height of Joint Pole
      ts_max_wL = Fkb_SF((Sqr(strs_MwL_s.Item(j + 1 + 8 * i) ^ 2 + 4 * _
                strs_Mtorq_wL_s.Item(j + 1 + 8 * i) ^ 2) / 2), 3)
      '
      'Add Property ts_max_wL to Collection Property total_ts_max_wL
      total_ts_max_wL.Add ts_max_wL
    Next j
  Next i
'
End Sub
')

Public Sub Calc_Max_Combined_Stress_wL()                                                        'Method for Calculation Maximum Combined Stress (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_kmpl class, "h_pjt(i)" is the argument for procedure
    '
    For j = 0 To Drnos - 1
      'Calculation Maximum Combined Stress (Bending Stress Winload and Torsional Shear Stress) Height of Joint Pole
      comb_strs_wL = Fkb_SF((Mcomb_wL_s.Item(j + 1 + 8 * i) / each_P.pole_s.Item(j + 1 + 8 * i).sec_mod) / 2 + _
                    total_ts_max_wL.Item(j + 1 + 8 * i), 3)
      '
      'Add Property comb_strs_wL to Collection Property Total_comb_strs_wL
      Total_comb_strs_wL.Add comb_strs_wL
    Next j
  Next i
'
End Sub
')

Public Sub Calc_Safety_Combined_Stress_wL()                                                     'Method for Calculation Safety Maximum Combined Stress (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_kmpl class, "h_pjt(i)" is the argument for procedure
    '
    For j = 0 To Drnos - 1
      'Calculation Safety Maximum Combined Stress Height of Joint Pole
      sfty_comb_strs_wL = Fkb_SF(Total_comb_strs_wL.Item(j + 1 + 8 * i) / _
                        each_P.pole_s.Item(j + 1 + 8 * i).s_fb, 3)
      '
      If sfty_comb_strs_wL < 1 Then
        sfty_rslt_comb_strs_wL = "O.K"
      Else
        sfty_rslt_comb_strs_wL = "N.G"
      End If
      '
      'Add Property sfty_comb_strs_wL to Collection Property sfty_comb_strs_wL_s
      sfty_comb_strs_wL_s.Add sfty_comb_strs_wL
      '
       'Add Property sfty_comb_strs_wL to Collection Property sfty_comb_strs_wL_s
      sfty_rslt_comb_strs_wL_s.Add sfty_rslt_comb_strs_wL
    Next j
  Next i
'
End Sub
')

'
'====================================================== Total of Section Moment due to Seismicload ===============================================================
'
Public Sub Calc_Total_Msl_Ang()                                                                 'Method for Calculation Total Moment due to Seismicload (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
  '
    Dim each_D As Do_kmpl                                                                       'Declare each_D as an object of the Do_kmpl class
    Set each_D = New Do_kmpl
    '
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    Dim each_A As Arm_Kmpl                                                                      'Declare each_A as an object of the Arm_Kmpl class
    Set each_A = New Arm_Kmpl
    '
    Dim each_W As OHW_Kmpl                                                                      'Declare each_W as an object of the OHW_Kmpl class
    Set each_W = New OHW_Kmpl
    '
    each_D.Assy h_pjt(i)                                                                        'Call Assy method on the Do_kmpl class, "h_pjt(i)" is the argument for procedure
    each_D.Total_Msl_Ang                                                                        'Call Total_Msl_Ang method on the Do_kmpl class
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_kmpl class, "h_pjt(i)" is the argument for procedure
    each_P.Total_Msl                                                                            'Call Total_Msl method on the Pole_kmpl class
    '
    each_A.Assy h_pjt(i)                                                                        'Call Assy method on the Arm_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_A.Total_Msl_Ang                                                                        'Call Total_Msl_Ang method on the Arm_Kmpl class
    '
    each_W.Assy h_pjt(i)                                                                        'Call Assy method on the OHW_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_W.Total_Msl_Ang                                                                        'Call Total_Msl_Ang method on the OHW_Kmpl class
    '
    'For k = 1 To each_P.total_Msls.Count
      For j = 1 To Drnos
        'Calculation Total of Moment due to Seismicload Height of Joint Pole
        Total_Msl = Fkb_SF(each_D.total_Msls.Item(j) + each_A.total_Msls.Item(j) + _
                  each_P.total_Msls.Item(j) + each_W.total_Msls.Item(j), 3)
      '
      'Add Property Total_Msl to  Collection Property total_MsL_s
       total_MsL_s.Add Total_Msl
      Next j
    'Next k
  Next i
'
End Sub
')

Public Sub Total_Mcombine_Due_to_sL()                                                           'Method for Calculation Moment Combine of Moment due to Seismic Load (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_A As Arm_Kmpl                                                                      'Declare each_A as an object of the Arm_Kmpl class
    Set each_A = New Arm_Kmpl
    '
    Dim each_W As OHW_Kmpl                                                                      'Declare each_W as an object of the OHW_Kmpl class
    Set each_W = New OHW_Kmpl
    '
    each_A.Assy h_pjt(i)                                                                        'Call Assy method on the Arm_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_A.Total_MfL_Ang                                                                        'Call Total_MfL_Ang method on the Arm_Kmpl class
    '
    each_W.Assy h_pjt(i)                                                                        'Call Assy method on the OHW_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_W.Total_Mtension_sL                                                                    'Call Total_Mtension_sL method on the OHW_Kmpl class
    '
    M_Combine_sL = 0
    For j = 0 To Drnos - 1
      'Calculation Moment Combine of Moment due to Seismic Load Height of Joint Pole
      M_Combine_sL = Fkb_SF(Abs(each_A.total_mfls.Item(j + 1)) + total_MsL_s.Item(j + 1 + 8 * i) _
                    + Abs(each_W.total_Mtns_sL.Item(j + 1)), 3)
      '
      'Add Property M_Combine_sL to Collection Property Mcomb_sL_s
      Mcomb_sL_s.Add M_Combine_sL
    Next j
  Next i
'
End Sub
')

Public Sub get_Max_Val_Seismicload()                                                            'Method for Calculation to Get Maximum Value Moment due to Seismic Load (Each Section Pole)
'
  'Method to get maximum value from 8 Wind Directional angle for each section
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Max_Load_EL_A = 0
    For j = 0 To 1                                                                              'Index Direction A
      If Max_Load_EL_A <= Mcomb_sL_s.Item(j + 1 + 8 * i) Then
        Max_Load_EL_A = Mcomb_sL_s.Item(j + 1 + 8 * i)
        max_ang_A_EL = AoW(j) * (180 / phi)
        max_index_A_EL = j
      End If
    Next j
    '
    Max_Load_EL_B = 0
    For j = 2 To 3                                                                              'Index Direction B
      If Max_Load_EL_B <= Mcomb_sL_s.Item(j + 1 + 8 * i) Then
        Max_Load_EL_B = Mcomb_sL_s.Item(j + 1 + 8 * i)
        max_ang_B_EL = AoW(j) * (180 / phi)
        max_index_B_EL = j
      End If
    Next j
    '
    Max_Load_EL_OB = 0
    For j = 4 To 7                                                                              'Index Direction Oblique of 4 angles (45, 225, 135, or 315)
      If Max_Load_EL_OB <= Mcomb_sL_s.Item(j + 1 + 8 * i) Then
        Max_Load_EL_OB = Mcomb_sL_s.Item(j + 1 + 8 * i)
        max_ang_OB_EL = AoW(j) * (180 / phi)
        max_index_OB_EL = j
      End If
    Next j
    '
    Max_Load_EL_OB_45_225 = 0
    For j = 4 To 5                                                                              'Index Direction Oblique of 2 angles (45 or 225)
      If Max_Load_EL_OB_45_225 <= Mcomb_sL_s.Item(j + 1 + 8 * i) Then
        Max_Load_EL_OB_45_225 = Mcomb_sL_s.Item(j + 1 + 8 * i)
        max_ang_OB_EL_45_225 = AoW(j) * (180 / phi)
        max_index_OB_EL_45_225 = j
      End If
    Next j
    '
    Max_Load_EL_OB_135_315 = 0
    For j = 6 To 7                                                                              'Index Direction Oblique of 2 angles (135 or 315)
      If Max_Load_EL_OB_135_315 <= Mcomb_sL_s.Item(j + 1 + 8 * i) Then
        Max_Load_EL_OB_135_315 = Mcomb_sL_s.Item(j + 1 + 8 * i)
        max_ang_OB_EL_135_315 = AoW(j) * (180 / phi)
        max_index_OB_EL_135_315 = j
      End If
    Next j
  Next i
'
End Sub
')

Public Sub Calc_Stress_MsL()                                                                    'Method for Calculation Stress of Moment due to Seismic Load (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_Kmpl class, "h_pjt(i)" is the argument for procedure
    '
    For j = 0 To Drnos - 1
      'Calculation Stress of Moment due to Seismic Load Height of Joint Pole
      strs_MsL = Fkb_SF(Mcomb_sL_s.Item(j + 1 + 8 * i) / each_P.pole_s.Item(j + 1 + 8 * i).sec_mod, 3)
      '
      'Add Property strs_MsL to Collection Property strs_MsL_s
      strs_MsL_s.Add strs_MsL
    Next j
  Next i
'
End Sub
')

Public Sub Calc_Safety_Msl()                                                                    'Method for Calculation Safety Value of Moment due to Seismic Load (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_P As Pole_kmpl
    Set each_P = New Pole_kmpl                                                                  'Declare each_P as an object of the Pole_kmpl class
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_Kmpl class, "h_pjt(i)" is the argument for procedure
    '
    For j = 0 To Drnos - 1
      'Calculation Safety Value of Moment due to Seismic Load Height of Joint Pole
      sfty_Msl = Fkb_SF(strs_MsL_s.Item(j + 1 + 8 * i) / each_P.pole_s.Item(j + 1 + 8 * i).s_fb, 3)
      '
      If sfty_Msl < 1 Then
        sfty_rslt_Msl = "O.K"
      Else
        sfty_rslt_Msl = "N.G"
      End If
      '
      'Add Property sfty_Msl to Collection Property sfty_Msl_s
      sfty_Msl_s.Add sfty_Msl
      '
      'Add Property sfty_rslt_Msl to Collection Property sfty_rslt_Msl_s
      sfty_rslt_Msl_s.Add sfty_rslt_Msl
    Next j
  Next i
'
End Sub
')
'
'====================================================== Total of Section Moment Torque Moment Due to Seismic Load ===============================================================
'
Public Sub Calc_Sheer_Stress_Mtorq_sL()                                                         'Method for Calculation Shear Stress of Moment Torque (Torsional) due to Seismic Load (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    Dim each_A As Arm_Kmpl                                                                      'Declare each_A as an object of the Arm_kmpl class
    Set each_A = New Arm_Kmpl
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_Kmpl class, "h_pjt(i)" is the argument for procedure
    '
    each_A.Assy h_pjt(i)                                                                        'Call Assy method on the Arm_Kmpl class, "h_pjt(i)" is the argument for procedure
    each_A.total_Mtorq_sL                                                                       'Call total_Mtorq_sL method on the Arm_Kmpl class
    '
    For j = 0 To Drnos - 1
      'Calculation Shear Stress of Moment Torque (Torsional) due to Seismic Load
      sheer_strs_mtorq_sL = Fkb_SF(Abs((each_A.total_Mtorq_sL_s.Item(j + 1)) * _
                    each_P.pole_s.Item(j + 1).Dia_sec) / (2 * each_P.pole_s.Item(j + 1).Ip), 3)
      '
      'Add Property sfty_Msl to Collection Property sfty_Msl_s
      strs_mtorq_sL_s.Add sheer_strs_mtorq_sL
    Next j
  Next i
'
End Sub
')

Public Sub Calc_Safety_Mtorq_sL()                                                               'Method for Calculation Safety Value of Moment Torque (Torsional) due to Seismic Load (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_Kmpl class, "h_pjt(i)" is the argument for procedure
    '
    For j = 0 To Drnos - 1
      'Calculation Safety Value of Moment Torque (Torsional) due to Seismic Load Height of Joint Pole
      sfty_Mtorq_sL = Fkb_SF(strs_mtorq_sL_s.Item(j + 1 + 8 * i) / each_P.pole_s.Item(j + 1 + 8 * i).s_fs, 3)
      '
      If sfty_Mtorq_sL < 1 Then
        sfty_rslt_Mtorq_sL = "O.K"
      Else
        sfty_rslt_Mtorq_sL = "N.G"
      End If
      '
      'Add Property sfty_Msl to Collection Property sfty_Msl_s
      sfty_Mtorq_sL_s.Add sfty_Mtorq_sL
      '
      'Add Property sfty_rslt_Mtorq_sL to Collection Property sfty_rslt_Mtorq_sL_s
      sfty_rslt_Mtorq_sL_s.Add sfty_rslt_Mtorq_sL
    Next j
  Next i
'
End Sub
')

'
'====================================================== Combine shear stress caused by dead load and Seismic Load ===============================================================
'
Public Sub Calc_Ts_Sheer_Stress_Max_sL()                                                        'Method for Calculation Shear Stress Maximal of Moment due to Seismic Load (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_Kmpl class, "h_pjt(i)" is the argument for procedure
    '
    For j = 0 To Drnos - 1
      'Calculation Shear Stress Maximal of Moment due to Seismic Load
      ts_max_sL = Fkb_SF((Sqr(strs_MsL_s.Item(j + 1 + 8 * i) ^ 2 + 4 * _
                strs_mtorq_sL_s.Item(j + 1 + 8 * i) ^ 2) / 2), 3)
      '
      'Add Property ts_max_sL to Collection Property total_ts_max_sL
      total_ts_max_sL.Add ts_max_sL
    Next j
  Next i
'
End Sub
')

Public Sub Calc_Max_Combined_Stress_sL()                                                        'Method for Calculation Maximal Combined Stress of Moment due to Seismic Load (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_Kmpl class, "h_pjt(i)" is the argument for procedure
    '
    For j = 0 To Drnos - 1
      'Calculation Maximal Combined Stress of Moment due to Seismic Load
      comb_strs_sL = Fkb_SF((Mcomb_sL_s.Item(j + 1 + 8 * i) / each_P.pole_s.Item(j + 1 + 8 * i).sec_mod) / 2 + _
                    total_ts_max_sL.Item(j + 1 + 8 * i), 3)
      '
      'Add Property comb_strs_sL to Collection Property Total_comb_strs_sL
      Total_comb_strs_sL.Add comb_strs_sL
    Next j
  Next i
'
End Sub
')

Public Sub Calc_Safety_Combined_Stress_sL()                                                     'Calculation dor Safety Combined Stress of Moment due to Seismic Load (Each Section Pole)
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    each_P.Assy h_pjt(i)                                                                        'Call Assy method on the Pole_Kmpl class, "h_pjt(i)" is the argument for procedure
    '
    For j = 0 To Drnos - 1
      'Calculation Safety Combined Stress of Moment due to Seismic Load Height of Joint Pole
      sfty_comb_strs_sL = Fkb_SF(Total_comb_strs_sL.Item(j + 1 + 8 * i) / _
                        each_P.pole_s.Item(j + 1 + 8 * i).s_fb, 3)
      '
      If sfty_comb_strs_sL < 1 Then
        sfty_rslt_comb_strs_sL = "O.K"
      Else
        sfty_rslt_comb_strs_sL = "N.G"
      End If
      '
      'Add Property sfty_comb_strs_sL to Collection Property sfty_comb_strs_sL_s
      sfty_comb_strs_sL_s.Add sfty_comb_strs_sL
      '
      'Add Property sfty_rslt_comb_strs_sL to Collection Property sfty_rslt_comb_strs_sL_s
      sfty_rslt_comb_strs_sL_s.Add sfty_rslt_comb_strs_sL
    Next j
  Next i
'
End Sub
')

'
'
'==========================================
'     These are methods for any Height
'==========================================
'
'
'
'====================================================== Total of Section Moment due to Fixload ===============================================================
'
Public Sub Calc_Total_Fixload_anyH(ByVal any_height As Double)                                'Method for Calculation Total of Fixload Any Height
'
  '
  Dim each_D As Do_kmpl                                                                       'Declare each_D as an object of the Do_kmpl class
  Set each_D = New Do_kmpl
  '
  Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
  Set each_P = New Pole_kmpl
  '
  Dim each_A As Arm_Kmpl                                                                      'Declare each_A as an object of the Arm_Kmpl class
  Set each_A = New Arm_Kmpl
  '
  Dim each_W As OHW_Kmpl                                                                      'Declare each_W as an object of the OHW_Kmpl class
  Set each_W = New OHW_Kmpl
  '
  each_D.Assy any_height                                                                      'Call Assy method on the Do_kmpl class, "any_height" is the argument for procedure
  each_D.Total_Fixload                                                                        'Call Total_Fixload method on the Do_kmpl class
  '
  each_P.Assy any_height                                                                      'Call Assy method on the Pole_kmpl class, "any_height" is the argument for procedure
  each_P.Total_Fixload                                                                        'Call Total_Fixload method on the Pole_kmpl class
  '
  each_A.Assy any_height                                                                      'Call Assy method on the Arm_Kmpl class, "any_height" is the argument for procedure
  each_A.Total_Fixload                                                                        'Call Total_Fixload method on the Arm_Kmpl class
   
  each_W.Assy any_height                                                                      'Call Assy method on the OHW_Kmpl class, "any_height" is the argument for procedure
  each_W.Total_Fixload                                                                        'Call Total_Fixload method on the OHW_Kmpl class
  '
  'Calculation of Total of Fixload Each Section
  'For k = 1 To each_P.total_fls.Count
    For j = 1 To Drnos
      Total_fl_anyH = Fkb_SF(each_D.total_fls.Item(j) + each_A.total_fls.Item(j) + _
                 each_W.total_fls.Item(j) + each_P.total_fls.Item(j), 3)
    '
    'Add Property Total_fl_anyH to Collection Property total_fl_anyH_s
     total_fl_anyH_s.Add Total_fl_anyH
    Next j
  'Next k
'
End Sub
')

Public Sub Calc_Total_wl_anyH(ByVal any_height As Double)                                     'Method for Calculation Total of Windload Any Height
'
  '
  Dim each_P As Pole_kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
  Set each_P = New Pole_kmpl
  '
  Dim each_D As Do_kmpl                                                                       'Declare each_D as an object of the Do_kmpl class
  Set each_D = New Do_kmpl
  '
  Dim each_A As Arm_Kmpl                                                                      'Declare each_A as an object of the Arm_Kmpl class
  Set each_A = New Arm_Kmpl
  '
  Dim each_W As OHW_Kmpl                                                                      'Declare each_W as an object of the OHW_Kmpl class
  Set each_W = New OHW_Kmpl
  '
  each_P.Assy any_height                                                                      'Call Assy method on the Pole_kmpl class, "any_height" is the argument for procedure
  each_P.Total_Winload                                                                        'Call Total_Winload method on the Pole_kmpl class
  each_P.Total_Winload_X
  each_P.Total_Winload_Y
  '
  each_D.Assy any_height                                                                      'Call Assy method on the Do_kmpl class, "any_height" is the argument for procedure
  each_D.Total_Winload                                                                        'Call Total_Winload method on the Do_kmpl class
  each_D.Total_windload_X
  each_D.Total_windload_Y
  '
  each_A.Assy any_height                                                                      'Call Assy method on the Arm_Kmpl class, "any_height" is the argument for procedure
  each_A.Total_Winload                                                                        'Call Total_Winload method on the Arm_Kmpl class
  each_A.Total_Winload_X
  each_A.Total_Winload_Y
  '
  each_W.Assy any_height                                                                      'Call Assy method on the OHW_Kmpl class, "any_height" is the argument for procedure
  each_W.Total_Winload                                                                        'Call Total_Winload method on the OHW_Kmpl class
  each_W.Total_Winload_X
  each_W.Total_Winload_Y
  '
  'Calculation of Total of Windload Each Section
  'For k = 1 To each_P.total_wls.Count
    For j = 1 To Drnos
      Total_wld_anyH = Fkb_SF(each_P.total_wls.Item(j) + each_D.total_wls.Item(j) + _
      each_A.total_wls.Item(j) + each_W.total_wls.Item(j), 3)
      '
      'X axis
      Total_wldX_anyH = Fkb_SF(each_P.total_wlXs.Item(j) + each_D.total_wlXs.Item(j) + _
      each_A.total_wlXs.Item(j) + each_W.total_wlXs.Item(j), 3)
      '
      'Y axis
      Total_wldY_anyH = Fkb_SF(each_P.total_wlYs.Item(j) + each_D.total_wlYs.Item(j) + _
      each_A.total_wlYs.Item(j) + each_W.total_wlYs.Item(j), 3)
    '
     'Add Property Total_wld to Collection Property total_wLd_s
      total_wLd_anyH_s.Add Total_wld_anyH
      '
      'X axis
      total_wLdX_anyH_s.Add Total_wldX_anyH
      '
      'Y axis
      total_wLdY_anyH_s.Add Total_wldY_anyH
    Next j
  'Next k
'
End Sub
')

Public Sub Resultan_WnL_anyH(ByVal any_height As Double)                                     'Method for Calculation Total Resultan of Windload Any Height
'
  Dim each_W As OHW_Kmpl                                                                     'Declare each_W as an object of the OHW_Kmpl class
  Set each_W = New OHW_Kmpl
  '
  each_W.Assy any_height                                                                     'Call Assy method on the OHW_Kmpl class, "any_height" is the argument for procedure
  each_W.Total_tension_wL                                                                    'Call Total_Mtension_wL method on the OHW_Kmpl class
  each_W.Total_tension_wLX
  each_W.Total_tension_wLY
  '
  Hrztl_WlX_anyH = 0
  Hrztl_WlY_anyH = 0
  Rsltn_wL_anyH = 0
  '
  For j = 0 To Drnos - 1
    'Calculate Horizontal Load X axis
    Hrztl_WlX_anyH = Fkb_SF(total_wLdX_anyH_s.Item(j + 1) + each_W.total_tns_wLX.Item(j + 1), 3)
    '
    'Calculate Horizontal Load Y axis
    Hrztl_WlY_anyH = Fkb_SF(total_wLdY_anyH_s.Item(j + 1) + each_W.total_tns_wLY.Item(j + 1), 3)
    '
    'Calculation of Resultan Winload
    Rsltn_wL_anyH = Fkb_SF((Hrztl_WlX_anyH ^ 2 + Hrztl_WlY_anyH ^ 2) ^ 0.5, 3)
    '
    'Add Property to collection
    Hrztl_WlX_anyH_s.Add Hrztl_WlX_anyH
    '
    'Add Property to collection
    Hrztl_WlY_anyH_s.Add Hrztl_WlY_anyH
    '
    'Add Property Rsltn_wL to Collection Property Rsltn_wL_s
    Rsltn_wL_anyH_s.Add Rsltn_wL_anyH
  Next j
'
End Sub
')

Public Sub Calc_Total_sl_anyH(ByVal any_height As Double)                                    'Method for Calculation Total of Seismic Load Any Height
'
  Dim each_D As Do_kmpl                                                                      'Declare each_D as an object of the Do_kmpl class
  Set each_D = New Do_kmpl
  '
  Dim each_P As Pole_kmpl                                                                    'Declare each_P as an object of the Pole_kmpl class
  Set each_P = New Pole_kmpl
  '
  Dim each_A As Arm_Kmpl                                                                     'Declare each_A as an object of the Arm_Kmpl class
  Set each_A = New Arm_Kmpl
  '
  Dim each_W As OHW_Kmpl                                                                     'Declare each_W as an object of the OHW_Kmpl class
  Set each_W = New OHW_Kmpl
  '
  each_D.Assy any_height                                                                     'Call Assy method on the Do_kmpl class, "any_height" is the argument for procedure
  each_D.Total_Seismicload                                                                   'Call Total_Seismicload method on the Do_kmpl class
  '
  each_P.Assy any_height                                                                     'Call Assy method on the Pole_kmpl class, "any_height" is the argument for procedure
  each_P.Total_Seismicload                                                                   'Call Total_Seismicload method on the Pole_kmpl class
  '
  each_A.Assy any_height                                                                     'Call Assy method on the Arm_Kmpl class, "any_height" is the argument for procedure
  each_A.Total_Seismicload                                                                   'Call Total_Seismicload method on the Arm_Kmpl class
  '
  each_W.Assy any_height                                                                     'Call Assy method on the OHW_Kmpl class, "any_height" is the argument for procedure
  each_W.Total_Seismicload                                                                   'Call Total_Seismicload method on the OHW_Kmpl class
  '
  For k = 1 To each_P.total_sls.Count
    For j = 1 To Drnos
      'Calculation Total of Seismicload Each Section
      Total_sld_anyH = Fkb_SF(each_D.total_sls.Item(j) + each_A.total_sls.Item(j) + _
                each_P.total_sls.Item(j) + each_W.total_sls.Item(j), 3)
    '
    'Add Property Total_sld to  Collection Property total_sLd_s
     total_sLd_anyH_s.Add Total_sld_anyH
    Next j
  Next k
'
End Sub
')

Public Sub Resultan_sL_anyH(ByVal any_height As Double)                                      'Method for Calculation Total Resultan Seismic Load Any Height
'
    Dim each_W As OHW_Kmpl                                                                   'Declare each_W as an object of the OHW_Kmpl class
    Set each_W = New OHW_Kmpl
    '
    each_W.Assy any_height                                                                   'Call Assy method on the OHW_Kmpl class, "any_height" is the argument for procedure
    each_W.Total_tension_sL                                                                  'Call Total_Mtension_wL method on the OHW_Kmpl class
    '
    Rsltn_sL = 0
    For j = 0 To Drnos - 1
      'Calculation of Resultan Seismicload Each Section
      Rsltn_sL_anyH = Fkb_SF(total_sLd_anyH_s.Item(j + 1 + 8 * i) + (Abs(each_W.total_tns_sL.Item(j + 1))), 3)
      '
      'Add Property Rsltn_sL to Collection Property Rsltn_sL_s
      Rsltn_sL_anyH_s.Add Rsltn_sL_anyH
    Next j
'
End Sub
')

Public Sub get_Max_Val_Fixload_anyH(ByVal any_height As Double)                             'Method for Calculation to Get Maximum Value of Moment due to Fixload Any Height
'
  'Method to get maximum value from 8 Wind Derectional angle for each section
  '
  Dim each_A As Arm_Kmpl                                                                    'Declare each_A as an object of the Arm_Kmpl class
  Set each_A = New Arm_Kmpl
  '
  each_A.Assy any_height                                                                    'Call Assy method on the Arm_Kmpl class, "any_height" is the argument for procedure
  each_A.Total_MfL_Ang                                                                      'Call Total_MfL_Ang method on the Arm_Kmpl class
  '
  Max_Load_fix_A_anyH = 0
  For j = 0 To 1                                                                            'Index Direction A Any Height
    If Max_Load_fix_A_anyH <= Abs(each_A.total_mfls.Item(j + 1)) Then
      Max_Load_fix_A_anyH = Abs(each_A.total_mfls.Item(j + 1))
      max_ang_A_FL_anyH = AoW(j) * (180 / phi)
      max_index_A_FL_anyH = j
    End If
  Next j
  '
  Max_Load_fix_B_anyH = 0
  For j = 2 To 3                                                                            'Index Direction B Any Height
    If Max_Load_fix_B_anyH <= Abs(each_A.total_mfls.Item(j + 1)) Then
      Max_Load_fix_B_anyH = Abs(each_A.total_mfls.Item(j + 1))
      max_ang_B_FL_anyH = AoW(j) * (180 / phi)
      max_index_B_FL_anyH = j
    End If
  Next j
  '
  Max_Load_fix_OB_anyH = 0
  For j = 4 To 7                                                                            'Index Direction Oblique of 4 angles (45, 225, 135, or 315) Any Height
    If Max_Load_fix_OB_anyH <= Abs(each_A.total_mfls.Item(j + 1)) Then
      Max_Load_fix_OB_anyH = Abs(each_A.total_mfls.Item(j + 1))
      max_ang_OB_FL_anyH = AoW(j) * (180 / phi)
      max_index_OB_FL_anyH = j
    End If
  Next j
  '
   Max_Load_fix_OB_45_225_anyH = 0
  For j = 4 To 5                                                                            'Index Direction Oblique of 2 angles (45 or 225) Any Height
    If Max_Load_fix_OB_45_225_anyH <= Abs(each_A.total_mfls.Item(j + 1)) Then
      Max_Load_fix_OB_45_225_anyH = Abs(each_A.total_mfls.Item(j + 1))
      max_ang_OB_FL_45_225_anyH = AoW(j) * (180 / phi)
      max_index_OB_FL_45_225_anyH = j
    End If
  Next j
  '
  Max_Load_fix_OB_135_315_anyH = 0
  For j = 6 To 7                                                                            'Index Direction Oblique of 2 angles (135 or 315) Any Height
    If Max_Load_fix_OB_135_315_anyH <= Abs(each_A.total_mfls.Item(j + 1)) Then
      Max_Load_fix_OB_135_315_anyH = Abs(each_A.total_mfls.Item(j + 1))
      max_ang_OB_FL_135_315_anyH = AoW(j) * (180 / phi)
      max_index_OB_FL_135_315_anyH = j
    End If
  Next j
'
End Sub
')

Public Sub Calc_Stress_MfL_anyH(ByVal any_height As Double)                                 'Method for Calculation Stress of Moment due to Fixload Any Height
'
  If Op_type = "Box_Type" Then
    Spec_OP_Box_Type
  ElseIf Op_type = "R_Type" Then
    Spec_OP_R_Type
  End If
  '
  Dim each_P As Pole_kmpl                                                                   'Declare each_P as an object of the Pole_kmpl class
  Set each_P = New Pole_kmpl
  '
  Dim each_A As Arm_Kmpl                                                                    'Declare each_A as an object of the Arm_kmpl class
  Set each_A = New Arm_Kmpl
  '
  each_P.Assy any_height                                                                    'Call Assy method on the Pole_Kmpl class, "any_height" is the argument for procedure
  '
  each_A.Assy any_height                                                                    'Call Assy method on the Arm_Kmpl class, "any_height" is the argument for procedure
  each_A.Total_MfL_Ang                                                                      'Call Total_MfL_Ang method on the Arm_Kmpl class
  '
  For j = 0 To 1
    'Calculation Stress of Moment due to Fixload Any Height
    strs_MfL_anyH = Fkb_SF(Abs(each_A.total_mfls.Item(j + 1)) / Z_OP_X, 3)
    '
    'Add Property strs_MfL_anyH to Collection Property strs_MfL_anyH_s
    strs_MfL_anyH_s.Add strs_MfL_anyH
  Next j
  '
  For j = 2 To 3
    'Calculation Stress of Moment due to Fixload Any Height
    strs_MfL_anyH = Fkb_SF(Abs(each_A.total_mfls.Item(j + 1)) / Z_OP_Y_Min, 3)
    '
    'Add Property strs_MfL_anyH to Collection Property strs_MfL_anyH_s
    strs_MfL_anyH_s.Add strs_MfL_anyH
  Next j
'    '
  For j = 4 To 7
    'Calculation Stress of Moment due to Fixload Any Height
    strs_MfL_anyH = Fkb_SF(Abs(each_A.total_mfls.Item(j + 1)) / Z_OP_Ob, 3)
    '
    'Add Property strs_MfL_anyH to Collection Property strs_MfL_anyH_s
    strs_MfL_anyH_s.Add strs_MfL_anyH
  Next j
'
End Sub
')

Public Sub Calc_Safety_Mfl_anyH(ByVal any_height As Double)                                 'Method for Calculation Safety Value of Moment due to Fixload Any Height
'
  pnos = inos(1)
  '
  Dim each_P As Pole_kmpl                                                                   'Declare each_P as an object of the Pole_kmpl class
  Set each_P = New Pole_kmpl
  '
  each_P.Assy any_height                                                                    'Call Assy method on the Pole_Kmpl class, "any_height" is the argument for procedure
  '
  p = each_P.pole_s.Count
  '
  For j = 0 To Drnos - 1
    'Calculation Safety of Moment due to Fixload Any Height
    sfty_Mfl_anyH = Fkb_SF(strs_MfL_anyH_s.Item(j + 1) / each_P.pole_s.Item(p).f_b, 3)   'Safety Value of Moment Due to Fixload
    '
    If sfty_Mfl_anyH < 1 Then                                                              'Safety Result of Moment Due to Fixload
      sfty_rslt_Mfl_anyH = "<　156 N/mm^2・・・O.K"
    Else
      sfty_rslt_Mfl_anyH = ">　156 N/mm^2・・・N.G"
    End If
    '
    'Add Property sfty_Mfl_anyH to Collection Property sfty_Mfl_anyH_s
    sfty_Mfl_anyH_s.Add sfty_Mfl_anyH
    '
    'Add Property sfty_rslt_Mfl_anyH to Collection Property sfty_rslt_Mfl_anyH_s
    sfty_rslt_Mfl_anyH_s.Add sfty_rslt_Mfl_anyH
  Next j
'
End Sub
')

'
'====================================================== Total of Section Moment due to Winload ===============================================================
'
Public Sub Calc_Total_Mwl_Ang_anyH(ByVal any_height As Double)                              'Method for Calculation Total Moment due to Winload Any Height
'
  Dim each_D As Do_kmpl                                                                     'Declare each_D as an object of the Do_kmpl class
  Set each_D = New Do_kmpl
  '
  Dim each_P As Pole_kmpl                                                                   'Declare each_P as an object of the Pole_kmpl class
  Set each_P = New Pole_kmpl
  '
  Dim each_A As Arm_Kmpl                                                                    'Declare each_A as an object of the Arm_Kmpl class
  Set each_A = New Arm_Kmpl
  '
  Dim each_Ohw As OHW_Kmpl                                                                  'Declare each_Ohw as an object of the OHW_Kmpl class
  Set each_Ohw = New OHW_Kmpl
  '
  each_D.Assy any_height                                                                    'Call Assy method on the Do_Kmpl class, "any_height" is the argument for procedure
  each_P.Assy any_height                                                                    'Call Assy method on the Pole_Kmpl class, "any_height" is the argument for procedure
  each_A.Assy any_height                                                                    'Call Assy method on the Arm_Kmpl class, "any_height" is the argument for procedure
  each_Ohw.Assy any_height                                                                  'Call Assy method on the OHW_Kmpl class, "any_height" is the argument for procedure
  '
  each_D.Total_Mwl_Ang                                                                      'Call Total_Mwl_Ang method on the Do_Kmpl class
  each_D.Total_Mwl_X
  each_D.Total_Mwl_Y
  '
  each_P.total_mwl                                                                          'Call Total_Mwl method on the Pole_Kmpl class
  each_P.Total_Mwl_X
  each_P.Total_Mwl_Y
  '
  each_A.Total_Mwl_Ang                                                                      'Call Total_Mwl_Ang method on the Arm_Kmpl class
  each_A.Total_Mwl_X
  each_A.Total_Mwl_Y
  '
  each_Ohw.Total_Mwl_Ang                                                                    'Call Total_Mwl_Ang method on the OHW_Kmpl class
  each_Ohw.Total_Mwl_X
  each_Ohw.Total_Mwl_Y
  '
  'For i = 1 To each_P.total_Mwls.Count
    For j = 1 To Drnos
      'Calculation Total of Moment due to Winload Any Height
      total_MwL_anyH = Fkb_SF(each_D.total_Mwls.Item(j) + each_A.total_Mwls.Item(j) + _
                 each_Ohw.total_Mwls.Item(j) + each_P.total_Mwls.Item(j), 3)
      '
      'X axis
      total_MwLX_anyH = Fkb_SF(each_D.total_MwL_Xs.Item(j) + each_A.total_MwL_Xs.Item(j) + _
                   each_Ohw.total_MwL_Xs.Item(j) + each_P.total_MwL_Xs.Item(j), 3)
      '
      'Y axis
      total_MwLY_anyH = Fkb_SF(each_D.total_MwL_Ys.Item(j) + each_A.total_MwL_Ys.Item(j) + _
                   each_Ohw.total_MwL_Ys.Item(j) + each_P.total_MwL_Ys.Item(j), 3)

      '
      'Add Property total_MwL_anyH to Collection Property total_MwL_anyH_s
      total_MwL_anyH_s.Add total_MwL_anyH
      '
      'X axis
      total_MwLX_anyH_s.Add total_MwLX_anyH
      '
      'X axis
      total_MwLY_anyH_s.Add total_MwLY_anyH
      '
    Next j
  'Next i
'
End Sub
')

Public Sub Total_Mcombine_Due_to_wL_anyH(ByVal any_height As Double)                        'Method for Calculation Total Moment Combine due to Winload Any Height
'
  '
  Dim each_A As Arm_Kmpl                                                                    'Declare each_A as an object of the Arm_kmpl class
  Set each_A = New Arm_Kmpl
  '
  Dim each_W As OHW_Kmpl                                                                    'Declare each_W as an object of the OHW_kmpl class
  Set each_W = New OHW_Kmpl
  '
  each_A.Assy any_height                                                                    'Call Assy method on the Arm_Kmpl class, "any_height" is the argument for procedure
  each_A.Total_MfL_Ang                                                                      'Call Total_MfL_Ang method on the Arm_Kmpl class
  each_A.Total_MfL_X
  each_A.Total_MfL_Y
  '
  each_W.Assy any_height                                                                    'Call Assy method on the OHW_Kmpl class, "any_height" is the argument for procedure
  each_W.Total_Mtension_wL                                                                  'Call Total_Mtension_wL method on the OHW_Kmpl class
  each_W.Total_Mtension_wLX
  each_W.Total_Mtension_wLY
  '
  M_Combine_wL_anyH = 0
  For j = 0 To Drnos - 1
    'Calculation Moment Combine of Moment due to Winload Any Height
'    M_Combine_wL_anyH = Fkb_SF(Abs(each_A.total_mfls.Item(j + 1)) + total_MwL_anyH_s.Item(j + 1) _
'                  + Abs(each_W.total_Mtns_wL.Item(j + 1)), 3)
    '
    MTot_wLX_anyH = Fkb_SF(Abs(each_A.total_mfl_Xs.Item(j + 1) + total_MwLX_anyH_s.Item(j + 1) + each_W.total_Mtns_wLX.Item(j + 1)), 3)
    '
    MTot_wLY_anyH = Fkb_SF(Abs(each_A.total_mfl_Ys.Item(j + 1) + total_MwLY_anyH_s.Item(j + 1) + each_W.total_Mtns_wLY.Item(j + 1)), 3)
    '
    M_Combine_wL_anyH = Fkb_SF((MTot_wLX_anyH ^ 2 + MTot_wLY_anyH ^ 2) ^ 0.5, 3)
    '
    'Total in X axis
    MTot_wLX_anyH_s.Add MTot_wLX_anyH
    '
    'Total in Y axis
    MTot_wLY_anyH_s.Add MTot_wLY_anyH
    '
    'Add Property M_Combine_wL_anyH to Collection Property Mcomb_wL_anyH_s
    Mcomb_wL_anyH_s.Add M_Combine_wL_anyH
  Next j
'
End Sub
')

Public Sub get_Max_Val_wind_anyH(ByVal any_height As Double)                                'Method for Calculation to Get Maximum Value of Winload Any Height
'
  'Method to get maximum value from 8 Wind Derectional angle for each section
  '
  Max_Load_wind_A_anyH = 0
  For j = 0 To 1                                                                            'Index Direction A Any Height
    If Max_Load_wind_A_anyH < Mcomb_wL_anyH_s.Item(j + 1) Then
      Max_Load_wind_A_anyH = Mcomb_wL_anyH_s.Item(j + 1)
      max_ang_A_WL_anyH = AoW(j) * (180 / phi)
      max_index_A_WL_anyH = j
    End If
  Next j
  '
  Max_Load_wind_B_anyH = 0
  For j = 2 To 3                                                                            'Index Direction B Any Height
    If Max_Load_wind_B_anyH < Mcomb_wL_anyH_s.Item(j + 1) Then
      Max_Load_wind_B_anyH = Mcomb_wL_anyH_s.Item(j + 1)
      max_ang_B_WL_anyH = AoW(j) * (180 / phi)
      max_index_B_WL_anyH = j
    End If
  Next j
  '
  Max_Load_wind_OB_anyH = 0
  For j = 4 To 7                                                                            'Index Direction Oblique of 4 angles (45, 225, 135, or 315) Any Height
    If Max_Load_wind_OB_anyH < Mcomb_wL_anyH_s.Item(j + 1) Then
      Max_Load_wind_OB_anyH = Mcomb_wL_anyH_s.Item(j + 1)
      max_ang_OB_WL_anyH = AoW(j) * (180 / phi)
      max_index_OB_WL_anyH = j
    End If
  Next j
  '
  Max_Load_wind_OB_45_225_anyH = 0
  For j = 4 To 5                                                                            'Index Direction Oblique of 2 angles (45 or 225) Any Height
    If Max_Load_wind_OB_45_225_anyH < Mcomb_wL_anyH_s.Item(j + 1) Then
      Max_Load_wind_OB_45_225_anyH = Mcomb_wL_anyH_s.Item(j + 1)
      max_ang_OB_WL_45_225_anyH = AoW(j) * (180 / phi)
      max_index_OB_WL_45_225_anyH = j
    End If
  Next j
  '
  Max_Load_wind_OB_135_315_anyH = 0
  For j = 6 To 7                                                                            'Index Direction Oblique of 2 angles (135 or 315) Any Height
    If Max_Load_wind_OB_135_315_anyH < Mcomb_wL_anyH_s.Item(j + 1) Then
      Max_Load_wind_OB_135_315_anyH = Mcomb_wL_anyH_s.Item(j + 1)
      max_ang_OB_WL_135_315_anyH = AoW(j) * (180 / phi)
      max_index_OB_WL_135_315_anyH = j
    End If
  Next j
'
End Sub
')

Public Sub Calc_Stress_MwL_anyH(ByVal any_height As Double)                                  'Method for Calculation Stress of Moment due to Windload Any Height
'
  pnos = inos(1)
  '
  If any_height = Hk Then
    If Op_type = "Box_Type" Then
      Spec_OP_Box_Type
    ElseIf Op_type = "R_Type" Then
      Spec_OP_R_Type
    End If
  End If
  '
  Dim each_P As Pole_kmpl                                                                    'Declare each_P as an object of the Pole_kmpl class
  Set each_P = New Pole_kmpl
  '
  each_P.Assy any_height                                                                     'Call Assy method on the Pole_Kmpl class, "any_height" is the argument for procedure
  '
  p = each_P.pole_s.Count
  '
  If any_height = Hk Then
    For j = 0 To 1
      'Calculation Stress of Moment due to Windload Any Height
      strs_MwL_anyH = Fkb_SF(Mcomb_wL_anyH_s.Item(j + 1) / Z_OP_X, 3)
      '
      'Add Property strs_MwL_anyH to Collection Property strs_MwL_anyH_s
      strs_MwL_anyH_s.Add strs_MwL_anyH
    Next j
  Else
    For j = 0 To Drnos - 1
      strs_MwL_anyH = Fkb_SF(Mcomb_wL_anyH_s.Item(j + 1) / each_P.pole_s.Item(p).sec_mod, 3)
       '
       'Add Property strs_MwL_anyH to Collection Property strs_MwL_anyH_s
      strs_MwL_anyH_s.Add strs_MwL_anyH
    Next j
  End If
  '
  If any_height = Hk Then
    For j = 2 To 3
      'Calculation Stress of Moment due to Windload Any Height
      strs_MwL_anyH = Fkb_SF(Mcomb_wL_anyH_s.Item(j + 1) / Z_OP_Y_Min, 3)
      '
      'Add Property strs_MwL_anyH to Collection Property strs_MwL_anyH_s
      strs_MwL_anyH_s.Add strs_MwL_anyH
    Next j
  Else
    For j = 0 To Drnos - 1
      strs_MwL_anyH = Fkb_SF(Mcomb_wL_anyH_s.Item(j + 1) / each_P.pole_s.Item(p).sec_mod, 3)
       '
       'Add Property strs_MwL_anyH to Collection Property strs_MwL_anyH_s
      strs_MwL_anyH_s.Add strs_MwL_anyH
    Next j
  End If
  '
  If any_height = Hk Then
    For j = 4 To 7
      'Calculation Stress of Moment due to Windload Any Height
      strs_MwL_anyH = Fkb_SF(Mcomb_wL_anyH_s.Item(j + 1) / Z_OP_Ob, 3)
      '
      'Add Property strs_MwL_anyH to Collection Property strs_MwL_anyH_s
      strs_MwL_anyH_s.Add strs_MwL_anyH
    Next j
  Else
    For j = 0 To Drnos - 1
      strs_MwL_anyH = Fkb_SF(Mcomb_wL_anyH_s.Item(j + 1) / each_P.pole_s.Item(p).sec_mod, 3)
      '
      'Add Property strs_MwL_anyH to Collection Property strs_MwL_anyH_s
      strs_MwL_anyH_s.Add strs_MwL_anyH
    Next j
  End If
'
End Sub
')

Public Sub Calc_Safety_Mwl_anyH(ByVal any_height As Double)                                  'Method for Calculation Safety of Moment due to Winload Any Height
'
  pnos = inos(1)
  '
  For i = 0 To pnos - 1
    Dim each_P As Pole_kmpl                                                                  'Declare each_P as an object of the Pole_kmpl class
    Set each_P = New Pole_kmpl
    '
    each_P.Assy any_height                                                                   'Call Assy method on the Pole_Kmpl class, "any_height" is the argument for procedure
    '
    p = each_P.pole_s.Count
    '
    For j = 0 To Drnos - 1
      'Calculation Safety Value of Moment due to Winload Any Height
      sfty_Mwl_anyH = Fkb_SF(strs_MwL_anyH_s.Item(j + 1) / each_P.pole_s.Item(p).s_fb, 3)
      '
      If sfty_Mwl_anyH < 1 Then                                                              'Safety Result of Moment Due to Winload
        sfty_rslt_Mwl_anyH = "<　235 N/mm^2・・・O.K"
      Else
        sfty_rslt_Mwl_anyH = ">　235 N/mm^2・・・N.G"
      End If
      
      'Add Property sfty_Mwl_anyH to Collection Property sfty_Mwl_anyH_s
      sfty_Mwl_anyH_s.Add sfty_Mwl_anyH
      '
      'Add Property sfty_rslt_Mwl_anyH to Collection Property sfty_rslt_Mwl_anyH_s
      sfty_rslt_Mwl_anyH_s.Add sfty_rslt_Mwl_anyH
    Next j
  Next i
'
End Sub
')

'====================================================== Total of Section Moment Torque Moment Due to Windload ===============================================================
'
Public Sub Calc_Sheer_Stress_Mtorq_wL_anyH(ByVal any_height As Double)                       'Method for Calculation Shear Stress of Moment Torque due to Windload Any Height Any Height
'
  pnos = inos(1)
  '
  If Op_type = "Box_Type" Then
    Spec_OP_Box_Type
  ElseIf Op_type = "R_Type" Then
    Spec_OP_R_Type
  End If
  '
  Dim each_P As Pole_kmpl                                                                    'Declare each_P as an object of the Pole_kmpl class
  Set each_P = New Pole_kmpl
  '
  Dim each_A As Arm_Kmpl                                                                     'Declare each_A as an object of the Arm_kmpl class
  Set each_A = New Arm_Kmpl
  '
  each_P.Assy any_height                                                                     'Call Assy method on the Pole_Kmpl class, "any_height" is the argument for procedure
  '
  each_A.Assy any_height                                                                     'Call Assy method on the Arm_Kmpl class, "any_height" is the argument for procedure
  each_A.Total_Mtorq_wL                                                                      'Call Total_Mtorq_wL method on the Arm_Kmpl class
  '
  p = each_P.pole_s.Count
  '
  For j = 0 To Drnos - 1
    'Calculation Shear Stress of Moment Torque due to Windload Any Height
    sheer_strs_mtorq_wL_anyH = Fkb_SF(Abs((each_A.Total_Mtorq_wL_s.Item(j + 1)) * _
                      each_P.pole_s.Item(p).Dia_sec) / (2 * Min_Ip_OP), 3)
    '
    'Add Property sheer_strs_mtorq_wL_anyH to Collection Property strs_mtorq_wL_anyH_s
    strs_mtorq_wL_anyH_s.Add sheer_strs_mtorq_wL_anyH
  Next j
'
End Sub
')

Public Sub Calc_Safety_Mtorq_wL_anyH(ByVal any_height As Double)                             'Method for Calculation Safety Value of Moment Torque due to Windload Any Height
'
  pnos = inos(1)
  '
  Dim each_P As Pole_kmpl                                                                    'Declare each_P as an object of the Pole_kmpl class
  Set each_P = New Pole_kmpl
  '
  each_P.Assy any_height                                                                     'Call Assy method on the Pole_Kmpl class, "any_height" is the argument for procedure
  '
  p = each_P.pole_s.Count
  '
  For j = 0 To Drnos - 1
    'Calculation Safety Value of Moment Torque due to Windload Any Height
    sfty_Mtorq_wL_anyH = Fkb_SF(strs_mtorq_wL_anyH_s.Item(j + 1) / _
                      each_P.pole_s.Item(p).s_fs, 3)                                         'Safety Value of Moment Torque due to Winload
    '
    If sfty_Mtorq_wL_anyH < 1 Then                                                          'Safety Result of Moment Torque due to Winload
      sfty_rslt_Mtorq_wL_anyH = "<　136 N/mm^2・・・O.K"
    Else
      sfty_rslt_Mtorq_wL_anyH = ">　136 N/mm^2・・・N.G"
    End If
    '
    'Add Property sfty_Mtorq_wL_anyH to Collection Property sfty_Mtorq_wL_anyH_s
    sfty_Mtorq_wL_anyH_s.Add sfty_Mtorq_wL_anyH
    '
    'Add Property sfty_rslt_Mtorq_wL_anyH to Collection Property sfty_rslt_Mtorq_wL_anyH_s
    sfty_rslt_Mtorq_wL_anyH_s.Add sfty_rslt_Mtorq_wL_anyH
  Next j
'
End Sub
')

'
'====================================================== Combine Shear Stress caused by Dead Load and Windload ===============================================================
'
Public Sub Calc_Ts_Sheer_Stress_Max_wL_anyH(ByVal any_height As Double)                      'Method for Calculation Maximum Shear Stress Value of Torque (Torsional) due to Winload Any Height
'
  '
  Dim each_P As Pole_kmpl                                                                    'Declare each_P as an object of the Pole_kmpl class
  Set each_P = New Pole_kmpl
  '
  each_P.Assy any_height                                                                     'Call Assy method on the Pole_Kmpl class, "any_height" is the argument for procedure
  '
  For j = 0 To Drnos - 1
    'Calculation Torque Stress Maximal due to Winload Any Height
    ts_max_wL_anyH = Fkb_SF((Sqr(strs_MwL_anyH_s.Item(j + 1) ^ 2 + 4 * _
                  strs_mtorq_wL_anyH_s.Item(j + 1) ^ 2) / 2), 3)
    '
    'Add Property ts_max_wL_anyH to Collection Property total_ts_max_wL_anyH
    total_ts_max_wL_anyH.Add ts_max_wL_anyH
  Next j
'
End Sub
')

Public Sub Calc_Max_Combined_Stress_wL_anyH(ByVal any_height As Double)                      'Method for Calculation Maximum Combined Stress Value of Windload Any Height
'
  '
  Dim each_P As Pole_kmpl                                                                    'Declare each_P as an object of the Pole_kmpl class
  Set each_P = New Pole_kmpl
  '
  each_P.Assy any_height                                                                     'Call Assy method on the Pole_Kmpl class, "any_height" is the argument for procedure
  '
  For j = 0 To Drnos - 1
    'Calculation Maximal Combined Stress due to Winload Any Height
    comb_strs_wL_anyH = Fkb_SF((strs_MwL_anyH_s.Item(j + 1) / 2 + _
                      total_ts_max_wL_anyH.Item(j + 1)), 3)
    '
    'Add Property comb_strs_wL_anyH to Collection Property Total_comb_strs_wL_anyH
    Total_comb_strs_wL_anyH.Add comb_strs_wL_anyH
  Next j
'
End Sub
')

Public Sub Calc_Safety_Combined_Stress_wL_anyH(ByVal any_height As Double)                   'Method for Calculation Maximum Safety Combined Stress Value of Windload Any Height
'
  pnos = inos(1)
  '
  Dim each_P As Pole_kmpl                                                                    'Declare each_P as an object of the Pole_kmpl class
  Set each_P = New Pole_kmpl
  '
  each_P.Assy any_height                                                                     'Call Assy method on the Pole_Kmpl class, "any_height" is the argument for procedure
  '
  p = each_P.pole_s.Count
  '
  For j = 0 To Drnos - 1
    'Calculation Safety Value Combined Stress due to Windload Any Height
    sfty_comb_strs_wL_anyH = Fkb_SF(Total_comb_strs_wL_anyH.Item(j + 1) / _
                          each_P.pole_s.Item(p).s_fb, 3)                                     'Safety Value of Maximum Combined Stress due to Windload
    '
    If sfty_comb_strs_wL_anyH < 1 Then                                                      'Safety Result of Maximum Combined Stress due to Windload
      sfty_rslt_comb_strs_wL_anyH = "<　235 N/mm^2・・・O.K"
    Else
      sfty_rslt_comb_strs_wL_anyH = ">　235 N/mm^2・・・N.G"
    End If
    '
    'Add Property sfty_comb_strs_wL_anyH to Collection Property sfty_comb_strs_wL_anyH_s
    sfty_comb_strs_wL_anyH_s.Add sfty_comb_strs_wL_anyH
    '
    'Add Property sfty_comb_strs_wL_anyH to Collection Property sfty_comb_strs_wL_anyH_s
    sfty_rslt_comb_strs_wL_anyH_s.Add sfty_rslt_comb_strs_wL_anyH
  Next j
'
End Sub
')

'
'====================================================== Total of Section Moment due to Seismic Load ===============================================================
'
Public Sub Calc_Total_Msl_Ang_anyH(ByVal any_height As Double)                               'Method for Calculation Total of Moment due to Seismic Load Any Height
'
  '
  Dim each_D As Do_kmpl                                                                      'Declare each_D as an object of the Do_kmpl class
  Set each_D = New Do_kmpl
  '
  Dim each_P As Pole_kmpl                                                                    'Declare each_P as an object of the Pole_kmpl class
  Set each_P = New Pole_kmpl
  '
  Dim each_A As Arm_Kmpl                                                                     'Declare each_A as an object of the Arm_kmpl class
  Set each_A = New Arm_Kmpl
  '
  Dim each_W As OHW_Kmpl                                                                     'Declare each_W as an object of the OHW_kmpl class
  Set each_W = New OHW_Kmpl
  '
  each_D.Assy any_height                                                                     'Call Assy method on the Do_Kmpl class, "any_height" is the argument for procedure
  each_P.Assy any_height                                                                     'Call Assy method on the Pole_Kmpl class, "any_height" is the argument for procedure
  each_A.Assy any_height                                                                     'Call Assy method on the Arm_Kmpl class, "any_height" is the argument for procedure
  each_W.Assy any_height                                                                     'Call Assy method on the OHW_Kmpl class, "any_height" is the argument for procedure
  '
  each_D.Total_Msl_Ang                                                                       'Call Total_Msl_Ang method on the Do_Kmpl class
  each_P.Total_Msl                                                                           'Call Total_Msl method on the Pole_Kmpl class
  each_A.Total_Msl_Ang                                                                       'Call Total_Msl_Ang method on the Arm_Kmpl class
  each_W.Total_Msl_Ang                                                                       'Call Total_Msl_Ang method on the OHW_Kmpl class
  '
  'For k = 1 To each_P.total_Msls.Count
    For j = 1 To Drnos
      'Calculation Total of Moment due to Seismic Load Any Height
      total_MsL_anyH = Fkb_SF(each_D.total_Msls.Item(j) + each_A.total_Msls.Item(j) + _
                each_P.total_Msls.Item(j) + each_W.total_Msls.Item(j), 3)
    '
    'Add Property total_sL_anyH to Collection Property total_MsL_anyH_s
     total_MsL_anyH_s.Add total_MsL_anyH
    Next j
  'Next k
'
End Sub
')

Public Sub Total_Mcombine_Due_to_sL_anyH(ByVal any_height As Double)                         'Method for Calculation Moment Combine due to Seismic Load Any Height
'
  Dim each_A As Arm_Kmpl                                                                     'Declare each_A as an object of the Arm_kmpl class
  Set each_A = New Arm_Kmpl
  '
  Dim each_W As OHW_Kmpl                                                                     'Declare each_W as an object of the OHW_kmpl class
  Set each_W = New OHW_Kmpl
  '
  each_A.Assy any_height                                                                     'Call Assy method on the Arm_Kmpl class, "any_height" is the argument for procedure
  each_A.Total_MfL_Ang                                                                       'Call Total_MfL_Ang method on the Arm_Kmpl class
  '
  each_W.Assy any_height                                                                     'Call Assy method on the OHW_Kmpl class, "any_height" is the argument for procedure
  each_W.Total_Mtension_sL                                                                   'Call Total_Mtension_sL method on the OHW_Kmpl class
  '
  M_Combine_sL_anyH = 0
  For j = 0 To Drnos - 1
    'Calculation Moment Combine of Moment due to Seismic Load Any Height
    M_Combine_sL_anyH = Fkb_SF(Abs(each_A.total_mfls.Item(j + 1)) + total_MsL_anyH_s.Item(j + 1) _
                      + Abs(each_W.total_Mtns_sL.Item(j + 1)), 3)
    '
    'Add Property M_Combine_sL_anyH to Collection Property Mcomb_sL_anyH_s
    Mcomb_sL_anyH_s.Add M_Combine_sL_anyH
  Next j
'
End Sub
')

Public Sub get_Max_Val_Seismicload_anyH(ByVal any_height As Double)                         'Method for Calculation to Get Maximum Value Moment due to Seismic Load Any Height
'
  'Method to get maximum value from 8 Wind Directional angle for each section
  '
  Max_Load_EL_A_anyH = 0
  For j = 0 To 1                                                                            'Index Direction A Any Height
    If Max_Load_EL_A_anyH <= Mcomb_sL_anyH_s.Item(j + 1) Then
      Max_Load_EL_A_anyH = Mcomb_sL_anyH_s.Item(j + 1)
      max_ang_A_EL_anyH = AoW(j) * (180 / phi)
      max_index_A_EL_anyH = j
    End If
  Next j
  '
  Max_Load_EL_B_anyH = 0
  For j = 2 To 3                                                                            'Index Direction B Any Height
    If Max_Load_EL_B_anyH <= Mcomb_sL_anyH_s.Item(j + 1) Then
      Max_Load_EL_B_anyH = Mcomb_sL_anyH_s.Item(j + 1)
      max_ang_B_EL_anyH = AoW(j) * (180 / phi)
      max_index_B_EL_anyH = j
    End If
  Next j
  '
  Max_Load_EL_OB_anyH = 0
  For j = 4 To 7                                                                            'Index Direction Oblique of 4 angles (45, 225, 135, or 315) Any Height
    If Max_Load_EL_OB_anyH <= Mcomb_sL_anyH_s.Item(j + 1) Then
      Max_Load_EL_OB_anyH = Mcomb_sL_anyH_s.Item(j + 1)
      max_ang_OB_EL_anyH = AoW(j) * (180 / phi)
      max_index_OB_EL_anyH = j
    End If
  Next j
  '
  Max_Load_EL_OB_45_225_anyH = 0
  For j = 4 To 5                                                                            'Index Direction Oblique of 2 angles (45 or 225) Any Height
    If Max_Load_EL_OB_45_225_anyH <= Mcomb_sL_anyH_s.Item(j + 1) Then
      Max_Load_EL_OB_45_225_anyH = Mcomb_sL_anyH_s.Item(j + 1)
      max_ang_OB_EL_45_225_anyH = AoW(j) * (180 / phi)
      max_index_OB_EL_45_225_anyH = j
    End If
  Next j
  '
  Max_Load_EL_OB_135_315_anyH = 0
  For j = 6 To 7                                                                            'Index Direction Oblique of 2 angles (135 or 315) Any Height
    If Max_Load_EL_OB_135_315_anyH <= Mcomb_sL_anyH_s.Item(j + 1) Then
      Max_Load_EL_OB_135_315_anyH = Mcomb_sL_anyH_s.Item(j + 1)
      max_ang_OB_EL_135_315_anyH = AoW(j) * (180 / phi)
      max_index_OB_EL_135_315_anyH = j
    End If
  Next j
'
End Sub
')

Public Sub Calc_Stress_MsL_anyH(ByVal any_height As Double)                                  'Method for Calculation Stress of Moment due to Seismic Load Any Height
'
  pnos = inos(1)
  '
  If any_height = Hk Then
    If Op_type = "Box_Type" Then
      Spec_OP_Box_Type
    ElseIf Op_type = "R_Type" Then
      Spec_OP_R_Type
    End If
  End If
  '
  Dim each_P As Pole_kmpl                                                                    'Declare each_P as an object of the Pole_kmpl class
  Set each_P = New Pole_kmpl
  '
  each_P.Assy any_height                                                                     'Call Assy method on the Pole_Kmpl class, "any_height" is the argument for procedure
  '
  p = each_P.pole_s.Count
  '
  If any_height = Hk Then
    For j = 0 To 1
      'Calculation Stress of Moment due to Winload Any Height
      strs_MsL_anyH = Fkb_SF(Mcomb_sL_anyH_s.Item(j + 1) / Z_OP_X, 3)
      '
      'Add Property strs_MsL_anyH to Collection Property strs_MsL_anyH_s
      strs_MsL_anyH_s.Add strs_MsL_anyH
    Next j
  Else
    For j = 0 To Drnos - 1
      strs_MsL_anyH = Fkb_SF(Mcomb_sL_anyH_s.Item(j + 1) / each_P.pole_s.Item(p).sec_mod, 3)
      '
      'Add Property strs_MsL_anyH to Collection Property strs_MsL_anyH_s
      strs_MsL_anyH_s.Add strs_MsL_anyH
    Next j
  End If
  '
  If any_height = Hk Then
    For j = 2 To 3
      'Calculation Stress of Moment due to Winload Any Height
      strs_MsL_anyH = Fkb_SF(Mcomb_sL_anyH_s.Item(j + 1) / Z_OP_Y_Min, 3)
      '
      'Add Property strs_MsL_anyH to Collection Property strs_MsL_anyH_s
      strs_MsL_anyH_s.Add strs_MsL_anyH
    Next j
  Else
    For j = 0 To Drnos - 1
      strs_MsL_anyH = Fkb_SF(Mcomb_sL_anyH_s.Item(j + 1) / each_P.pole_s.Item(p).sec_mod, 3)
      '
      'Add Property strs_MsL_anyH to Collection Property strs_MsL_anyH_s
      strs_MsL_anyH_s.Add strs_MsL_anyH
    Next j
  End If
  '
  If any_height = Hk Then
    For j = 4 To 7
      'Calculation Stress of Moment due to Winload Any Height
      strs_MsL_anyH = Fkb_SF(Mcomb_sL_anyH_s.Item(j + 1) / Z_OP_Ob, 3)
      '
      'Add Property strs_MsL_anyH to Collection Property strs_MsL_anyH_s
      strs_MsL_anyH_s.Add strs_MsL_anyH
    Next j
  Else
    For j = 0 To Drnos - 1
      strs_MsL_anyH = Fkb_SF(Mcomb_sL_anyH_s.Item(j + 1) / each_P.pole_s.Item(p).sec_mod, 3)
      '
      'Add Property strs_MsL_anyH to Collection Property strs_MsL_anyH_s
      strs_MsL_anyH_s.Add strs_MsL_anyH
    Next j
  End If
'
End Sub
')

Public Sub Calc_Safety_Msl_anyH(ByVal any_height As Double)                                  'Method for Calculation Safety Value of Moment due to Seismic Load Any Height
'
  pnos = inos(1)
  '
  Dim each_P As Pole_kmpl                                                                    'Declare each_P as an object of the Pole_kmpl class
  Set each_P = New Pole_kmpl
  '
  each_P.Assy any_height                                                                     'Call Assy method on the Pole_Kmpl class, "any_height" is the argument for procedure
  '
  p = each_P.pole_s.Count
  '
  For j = 0 To Drnos - 1
    'Calculation Safety Value of Moment due to Seismic Load Any Height
    sfty_MsL_anyH = Fkb_SF(strs_MsL_anyH_s.Item(j + 1) / each_P.pole_s.Item(p).s_fb, 3)       'Safety Value of Moment due to Seismic Load Any Height
    '
    If sfty_MsL_anyH < 1 Then                                                                'Safety Result of Moment due to Seismic Load Any Height
      sfty_rslt_MsL_anyH = "<　235 N/mm^2・・・O.K"
    Else
      sfty_rslt_MsL_anyH = ">　235 N/mm^2・・・N.G"
    End If
    '
    'Add Property sfty_MsL_anyH to Collection Property sfty_Msl_anyH_s
    sfty_Msl_anyH_s.Add sfty_MsL_anyH
    '
    'Add Property sfty_rslt_MsL_anyH to Collection Property sfty_rslt_Msl_anyH_s
    sfty_rslt_Msl_anyH_s.Add sfty_rslt_MsL_anyH
  Next j
'
End Sub
')

'
'====================================================== Total of Section Moment Torque Moment Due to Seismic Load ===============================================================
'
Public Sub Calc_Sheer_Stress_Mtorq_sL_anyH(ByVal any_height As Double)                       'Method for Calculation Shear Stress Moment Torque due to Seismic Load Any Height
'
  pnos = inos(1)
  '
  If Op_type = "Box_Type" Then
    Spec_OP_Box_Type
  ElseIf Op_type = "R_Type" Then
    Spec_OP_R_Type
  End If
  '
  Dim each_P As Pole_kmpl                                                                    'Declare each_A as an object of the Arm_kmpl class
  Set each_P = New Pole_kmpl
  '
  Dim each_A As Arm_Kmpl                                                                     'Declare each_P as an object of the Pole_kmpl class
  Set each_A = New Arm_Kmpl
  '
  each_P.Assy any_height                                                                     'Call Assy method on the Pole_Kmpl class, "any_height" is the argument for procedure
  '
  each_A.Assy any_height                                                                     'Call Assy method on the Arm_Kmpl class, "any_height" is the argument for procedure
  each_A.total_Mtorq_sL                                                                      'Call total_Mtorq_sL method on the Arm_Kmpl class
  '
  p = each_P.pole_s.Count
  '
  For j = 0 To Drnos - 1
    'Calculation Shear Stress Moment Torque due to Seismic Load Any Height
    sheer_strs_mtorq_sL_anyH = Fkb_SF(Abs((each_A.total_Mtorq_sL_s.Item(j + 1)) * _
                      each_P.pole_s.Item(p).Dia_sec) / (2 * Min_Ip_OP), 3)
    '
    'Add Property sheer_strs_mtorq_sL_anyH to Collection Property strs_mtorq_sL_anyH_s
    strs_mtorq_sL_anyH_s.Add sheer_strs_mtorq_sL_anyH
  Next j
'
End Sub
')

Public Sub Calc_Safety_Mtorq_sL_anyH(ByVal any_height As Double)                             'Method for Calculation Safety Value Moment Torque due to Seismic Load Any Height
'
  pnos = inos(1)
  '
  Dim each_P As Pole_kmpl                                                                    'Declare each_P as an object of the Pole_kmpl class
  Set each_P = New Pole_kmpl
  '
  each_P.Assy any_height                                                                     'Call Assy method on the Pole_Kmpl class, "any_height" is the argument for procedure
  '
  p = each_P.pole_s.Count
  '
  For j = 0 To Drnos - 1
    'Calculation Safety Value Moment Torque due to Seismic Load Any Height
    sfty_Mtorq_sL_anyH = Fkb_SF(strs_mtorq_sL_anyH_s.Item(j + 1) / each_P.pole_s.Item(p).s_fs, 3)
    '
    If sfty_Mtorq_sL_anyH < 1 Then                                                           'Safety Result of Moment Torque due to Seismic Load Any Height
      sfty_rslt_Mtorq_sL_anyH = "<　136 N/mm^2・・・O.K"
    Else
      sfty_rslt_Mtorq_sL_anyH = ">　136 N/mm^2・・・N.G"
    End If
    '
    'Add Property sfty_Mtorq_sL_anyH to Collection Property sfty_Mtorq_sL_anyH_s
    sfty_Mtorq_sL_anyH_s.Add sfty_Mtorq_sL_anyH
    '
    'Add Property sfty_rslt_Mtorq_sL_anyH to Collection Property sfty_rslt_Mtorq_sL_anyH_s
    sfty_rslt_Mtorq_sL_anyH_s.Add sfty_rslt_Mtorq_sL_anyH
  Next j
'
End Sub
')

'
'====================================================== Combine shear stress caused by dead load and Seismic Load ===============================================================
'
Public Sub Calc_Ts_Sheer_Stress_Max_sL_anyH(ByVal any_height As Double)                      'Method for Calculation Maximum Value of Torque (Torsional) Shear Stress due to Seismic Load Any Height
'
  '
  Dim each_P As Pole_kmpl                                                                    'Declare each_P as an object of the Pole_kmpl class
  Set each_P = New Pole_kmpl
  '
  each_P.Assy any_height                                                                     'Call Assy method on the Pole_Kmpl class, "any_height" is the argument for procedure
  '
  For j = 0 To Drnos - 1
    'Calculation Torque Shear Stress Maximal due to Seismic Load Any Height
    ts_max_sL_anyH = Fkb_SF((Sqr(strs_MsL_anyH_s.Item(j + 1) ^ 2 + 4 * _
                  strs_mtorq_sL_anyH_s.Item(j + 1) ^ 2) / 2), 3)
    '
    'Add Property ts_max_sL_anyH to Collection Property total_ts_max_sL_anyH
    total_ts_max_sL_anyH.Add ts_max_sL_anyH
  Next j
'
End Sub
')

Public Sub Calc_Max_Combined_Stress_sL_anyH(ByVal any_height As Double)                      'Method for Calculate Maximum Combined Stress due to Seismic Load Any Height
'
  '
  Dim each_P As Pole_kmpl                                                                    'Declare each_P as an object of the Pole_kmpl class
  Set each_P = New Pole_kmpl
  '
  each_P.Assy any_height                                                                     'Call Assy method on the Pole_Kmpl class, "any_height" is the argument for procedure
  '
  For j = 0 To Drnos - 1
    'Calculate Maximal Combined Stress due to Seismic Load Any Height
    comb_strs_sL_anyH = Fkb_SF((strs_MsL_anyH_s.Item(j + 1) / 2 + _
                      total_ts_max_sL_anyH.Item(j + 1)), 3)
    '
    'Add Property ts_max_sL_anyH to Collection Property total_ts_max_sL_anyH
    Total_comb_strs_sL_anyH.Add comb_strs_sL_anyH
  Next j
'
End Sub
')

Public Sub Calc_Safety_Combined_Stress_sL_anyH(ByVal any_height As Double)                   'Method for Calculate Safety Value of Maximum Combined Stress due to Seismic Load Any Height
'
  pnos = inos(1)
  '
  Dim each_P As Pole_kmpl                                                                    'Declare each_P as an object of the Pole_kmpl class
  Set each_P = New Pole_kmpl
  '
  each_P.Assy any_height                                                                     'Call Assy method on the Pole_Kmpl class, "any_height" is the argument for procedure
  '
  p = each_P.pole_s.Count
  '
  For j = 0 To Drnos - 1
    'Calculate Safety Value Combined Stress due to Seismic Load Any Height
    sfty_comb_strs_sL_anyH = Fkb_SF(Total_comb_strs_sL_anyH.Item(j + 1) / _
                          each_P.pole_s.Item(p).s_fb, 3)                                      'Safety Value of Maximum Combined Stress due to Seismic Load Any Height
    '
    If sfty_comb_strs_sL_anyH < 1 Then                                                       'Safety Result of Maximum Combined Stress due to Seismic Load Any Height
      sfty_rslt_comb_strs_sL_anyH = "<　235 N/mm^2・・・O.K"
    Else
      sfty_rslt_comb_strs_sL_anyH = ">　235 N/mm^2・・・N.G"
    End If
    '
    'Add Property sfty_comb_strs_sL_anyH to Collection Property sfty_comb_strs_sL_anyH_s
    sfty_comb_strs_sL_anyH_s.Add sfty_comb_strs_sL_anyH
    '
    'Add Property sfty_rslt_comb_strs_sL_anyH to Collection Property sfty_rslt_comb_strs_sL_anyH_s
    sfty_rslt_comb_strs_sL_anyH_s.Add sfty_rslt_comb_strs_sL_anyH
  Next j
'
End Sub
')

































