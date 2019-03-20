VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "wechat_bot"
   ClientHeight    =   3000
   ClientLeft      =   150
   ClientTop       =   780
   ClientWidth     =   4560
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   ScaleHeight     =   3000
   ScaleWidth      =   4560
   StartUpPosition =   3  '窗口缺省
   Begin VB.ListBox List1 
      Height          =   2040
      Left            =   0
      TabIndex        =   1
      Top             =   960
      Width           =   4575
   End
   Begin VB.TextBox Text1 
      Height          =   975
      Left            =   0
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   0
      Width           =   4575
   End
   Begin VB.Menu m_fn 
      Caption         =   "功能(&F)"
      Begin VB.Menu m_on 
         Caption         =   "开关(&O)"
      End
      Begin VB.Menu m_uniq 
         Caption         =   "去重(&U)"
      End
   End
   Begin VB.Menu m_ref 
      Caption         =   "刷新(&R)"
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Function memmap Lib "getTextW.dll" () As Long
Private Declare Sub runform Lib "getTextW.dll" ()

Private Sub Form_Load()
    If App.PrevInstance Then
        End
    End If
End Sub

