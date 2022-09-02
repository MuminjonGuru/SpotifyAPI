unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent;

type
  TFormMain = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    BtnFetchTracks: TButton;
    Edit3: TEdit;
    BtnGetLyrics: TButton;
    Edit4: TEdit;
    BtnUserData: TButton;
    Memo1: TMemo;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    NetHTTPClient1: TNetHTTPClient;
    NetHTTPRequest1: TNetHTTPRequest;
    StyleBook1: TStyleBook;
    RESTClient2: TRESTClient;
    RESTRequest2: TRESTRequest;
    RESTResponse2: TRESTResponse;
    procedure BtnFetchTracksClick(Sender: TObject);
    procedure BtnGetLyricsClick(Sender: TObject);
    procedure BtnUserDataClick(Sender: TObject);
    procedure NetHTTPRequest1RequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.fmx}

uses
  System.JSON;

procedure TFormMain.BtnFetchTracksClick(Sender: TObject);
begin
  NetHTTPRequest1.Get(Format('https://api.apilayer.com/spotify/album_tracks?apikey=%s&id=%s', [Edit1.Text, Edit2.Text]));
end;

procedure TFormMain.BtnGetLyricsClick(Sender: TObject);
begin
  RESTClient1.ResetToDefaults;
  RESTClient1.Accept := 'application/json';
  RESTClient1.AcceptCharset := 'UTF-8, *;q=0.8';
  RESTClient1.BaseURL := Format('https://api.apilayer.com/spotify/track_lyrics?apikey=%s&id=%s', [Edit1.Text, Edit3.Text]);
  RESTResponse1.ContentType := 'application//json';

  RESTRequest1.Execute;

  Memo1.Lines.Clear;
  Memo1.Lines.Add(RESTResponse1.Content);
end;

procedure TFormMain.BtnUserDataClick(Sender: TObject);
begin
  RESTClient2.ResetToDefaults;
  RESTClient2.Accept := 'application/json';
  RESTClient2.AcceptCharset := 'UTF-8, *;q=0.8';
  RESTClient2.BaseURL := Format('https://api.apilayer.com/spotify/user_profile?apikey=%s&id=%s', [Edit1.Text, Edit4.Text]);
  RESTResponse2.ContentType := 'application//json';

  RESTRequest2.Execute;

  Memo1.Lines.Clear;
  Memo1.Lines.Add(RESTResponse2.Content);
end;

procedure TFormMain.NetHTTPRequest1RequestCompleted(const Sender: TObject;
  const AResponse: IHTTPResponse);
begin
  Memo1.Lines.Add(AResponse.ContentAsString(TEncoding.Default));
end;

end.
