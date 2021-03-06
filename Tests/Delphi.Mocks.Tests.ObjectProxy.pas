unit Delphi.Mocks.Tests.ObjectProxy;

interface

uses
  Rtti,
  SysUtils,
  TestFramework,
  Delphi.Mocks;

type
  TSimpleObject = class(TObject)
  private
    FCreateCalled: Cardinal;
  public
    constructor Create;
    property CreateCalled: Cardinal read FCreateCalled;
  end;

  TMultipleConstructor = class
  private
    FCreateCalled: Cardinal;
  public
    constructor Create(Dummy: Integer);overload;
    constructor Create;overload;
    property CreateCalled: Cardinal read FCreateCalled;
  end;

  TTestObjectProxy = class(TTestCase)
  published
    procedure ProxyObject_Calls_The_Create_Of_The_Object_Type;
    procedure ProxyObject_MultipleConstructor;
  end;

implementation

uses
  Delphi.Mocks.ObjectProxy;

const
  G_CREATE_CALLED_UNIQUE_ID = 909090;

{ TTestObjectProxy }

procedure TTestObjectProxy.ProxyObject_Calls_The_Create_Of_The_Object_Type;
var
  objectProxy: IProxy<TSimpleObject>;
begin
  objectProxy := TObjectProxy<TSimpleObject>.Create;

  CheckEquals(objectProxy.Proxy.CreateCalled, G_CREATE_CALLED_UNIQUE_ID);
end;

procedure TTestObjectProxy.ProxyObject_MultipleConstructor;
var
  objectProxy: IProxy<TMultipleConstructor>;
begin
  objectProxy := TObjectProxy<TMultipleConstructor>.Create;

  CheckEquals(objectProxy.Proxy.CreateCalled, G_CREATE_CALLED_UNIQUE_ID);
end;

{ TSimpleObject }

constructor TSimpleObject.Create;
begin
  FCreateCalled := G_CREATE_CALLED_UNIQUE_ID;
end;

{ TMultipleConstructor }

constructor TMultipleConstructor.Create(Dummy: Integer);
begin

end;

constructor TMultipleConstructor.Create;
begin
  FCreateCalled := G_CREATE_CALLED_UNIQUE_ID;
end;

initialization
  TestFramework.RegisterTest(TTestObjectProxy.Suite);
end.
