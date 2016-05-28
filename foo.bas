Imports System.Text

Public NotInheritable Class AboutBox1

    Private Sub AboutBox1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        ' Set the title of the form.
        Dim ApplicationTitle As String
        If My.Application.Info.Title <> "" Then
            ApplicationTitle = My.Application.Info.Title
        Else
            ApplicationTitle = System.IO.Path.GetFileNameWithoutExtension(My.Application.Info.AssemblyName)
        End If
        Me.Text = String.Format("About {0}", ApplicationTitle)
        ' Initialize all of the text displayed on the About Box.
        ' TODO: Customize the application's assembly information in the "Application" pane of the project 
        '    properties dialog (under the "Project" menu).
        LabelProductName.Text = My.Application.Info.ProductName
        LabelVersion.Text = String.Format("Version {0}", My.Application.Info.Version.ToString)
        LabelCopyright.Text = My.Application.Info.Copyright
        LabelCompanyName.Text = My.Application.Info.CompanyName
        Dim desc As StringBuilder = New StringBuilder
        desc.AppendLine(My.Application.Info.Description)
        desc.AppendLine()
        desc.AppendLine(String.Format("ConnectionString: {0}",Program.ActualConnectionString))
        desc.AppendLine()
        ' TODO: Resolve app.config discrepancy between VB and C# (ie. Program.Settings vs Settings or some such) 
        desc.AppendLine(String.Format("Number of ActiveStations: {0}", Program.Settings.StationCount))
        desc.AppendLine(String.Format("This Station: {0}", Program.Settings.ThisStation))
        '''''desc.AppendLine(String.Format("Sync Timer:{0} seconds", Program.Settings.TimerSeconds))

        'desc.AppendLine(String.Format("Logging Enabled: {0}", Program.Settings.LoggingEnabled))
        desc.AppendLine(String.Format("Log file: {0}{1}",
                            Program.Settings.LogFileLocation,
                            Program.Settings.LogFile))
        TextBoxDescription.Text = desc.ToString

    End Sub

    Private Sub OKButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles OKButton.Click
        Me.Close()
    End Sub

End Class

