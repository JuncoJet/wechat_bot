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
      Begin VB.Menu m_auto 
         Caption         =   "自动回复(&A)"
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
Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Private Declare Function SetActiveWindow Lib "user32" (ByVal hwnd As Long) As Long
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
    m_on.Checked = True
End Sub

Private Sub m_auto_Click()
    m_auto.Checked = Not m_auto.Checked
End Sub

Private Sub m_on_Click()
    m_on.Checked = Not m_on.Checked
    Timer1.Enabled = m_on.Checked
End Sub

Private Sub m_ref_Click()
    txt = vbNullString
End Sub

Private Sub m_uniq_Click()
    m_uniq.Checked = Not m_uniq.Checked
End Sub

Private Sub Timer1_Timer()
    If txt <> Text1 Then
        txt = Text1
        t = urlPost("http://127.0.0.1:8080/turing", "q=" & txt)
        List1.AddItem t
        If m_auto.Checked Then
            '这里自动回复处理过程
            VB.Clipboard.Clear
            VB.Clipboard.SetText t, vbCFText
            h = FindWindow("WeChatMainWndForPC", "微信")
            SetActiveWindow h
            SendKeys "^v{ENTER}"
        End If
        If List1.ListCount > 10 Then
            List1.RemoveItem (0)
        End If
    End If
End Sub
