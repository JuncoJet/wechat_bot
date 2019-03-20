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
   Begin VB.Timer Timer1 
      Interval        =   1000
      Left            =   1680
      Top             =   1320
   End
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
Dim txt

Function urlGet(url)
    Set XMLHTTP = CreateObject("Microsoft.XMLHTTP")
    With XMLHTTP
        .Open "GET", url, False
        .send
        urlGet = .responseText
    End With
    Set XMLHTTP = Nothing
End Function

Function urlPost(url, data)
    Set XMLHTTP = CreateObject("Microsoft.XMLHTTP")
    With XMLHTTP
        .Open "POST", url, False
        .setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
        .send data
        urlPost = .responseText
    End With
    Set XMLHTTP = Nothing
End Function

Private Sub Form_Load()
    If App.PrevInstance Then
        End
    End If
End Sub

Private Sub Timer1_Timer()
    If txt <> Text1 Then
        txt = Text1
        List1.AddItem urlPost("http://127.0.0.1:8080/fc_test", "q=" & txt)
    End If
End Sub
