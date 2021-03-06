[Setup]
AppID=WinIPBroadcast
AppName=WinIPBroadcast
AppVerName=WinIPBroadcast 1.2
AppVersion=1.2
AppPublisher=Etienne Dechamps
AppPublisherURL=https://github.com/dechamps/WinIPBroadcast
AppSupportURL=https://github.com/dechamps/WinIPBroadcast
AppUpdatesURL=https://github.com/dechamps/WinIPBroadcast
AppContact=etienne@edechamps.fr

OutputDir=.
OutputBaseFilename=WinIPBroadcast-1.2

DefaultDirName={pf}\WinIPBroadcast
AppendDefaultDirName=no

LicenseFile=LICENSE.txt


[Files]
Source:"WinIPBroadcast.exe"; DestDir: "{app}"; Flags: ignoreversion; BeforeInstall: StopService
Source:"src\*"; DestDir:"{app}\src"; Flags: ignoreversion recursesubdirs createallsubdirs
Source:"LICENSE.txt"; DestDir:"{app}"; Flags: ignoreversion 
Source:"README.txt"; DestDir:"{app}"; Flags: ignoreversion isreadme

[Registry]
Root: HKLM; Subkey: "SOFTWARE\WinIPBroadcast"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\WinIPBroadcast"; ValueType: string; ValueName: "InstallDir"; ValueData: "{app}"; Flags: deletevalue
Root: HKLM; Subkey: "SOFTWARE\WinIPBroadcast"; ValueType: string; ValueName: "Version"; ValueData: "1.2"; Flags: deletevalue

[Run]
Filename: "{app}\WinIPBroadcast.exe"; Parameters: "install"; StatusMsg: "Installing service..."; Flags: runhidden
Filename: "{sys}\net.exe"; Parameters: "start WinIPBroadcast"; StatusMsg: "Starting service..."; Flags: runhidden

[UninstallRun]
Filename: "{sys}\net.exe"; Parameters: "stop WinIPBroadcast"; Flags: runhidden; RunOnceId: "StopService"
Filename: "{app}\WinIPBroadcast.exe"; Parameters: "remove"; Flags: runhidden; RunOnceId: "RemoveService"

[code]
procedure StopService();
var
	ResultCode : Integer;
begin
	Exec(ExpandConstant('{sys}') + '\net.exe', 'stop WinIPBroadcast', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
end;
