X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.3259.1588235525224737309
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Apr 2020 01:32:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: akihiro27.suzuki@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 03U8VxV0000616; Thu, 30 Apr 2020 17:31:59 +0900
X-Iguazu-Qid: 2wHHQAbmuWZNFtgoBE
X-Iguazu-QSIG: v=2; s=0; t=1588235519; q=2wHHQAbmuWZNFtgoBE; m=J0ilh9c2Dx3WBQLCFLPhPAwqkoO/CYY8GR9/dRWULYs=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1110) id 03U8VwYx012278;
	Thu, 30 Apr 2020 17:31:58 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 03U8Vwel007142;
	Thu, 30 Apr 2020 17:31:58 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 03U8VvIS019564;
	Thu, 30 Apr 2020 17:31:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1fnY1MCOkcSqOHEWdoKSBMafrlUA+wA6LBABFh9wlwb/LDtwf2VITZmtSaGZoQQIBpgG5rjvt4nql/Nrkoj/SrrVlyM7OeaQKQggO8JAifU7ax6H53SH51P3pcq/3woQhLPgyJmmz7XN01UeLCxO4Od4q1zeR3HpHfh4/LyVAtH7pMbKvXEblIwPGrhx/a61NmM9HQsQTyYyhDRVcVFCNca5ctjLBYy6ndgVMiMPzPGYoetGoV1O9Rgf+LuGSft7YoCLPL3QwGD2zNupMnwB6myVpCi1ir0AlkbHfgQd9CmJTcIjFuyeNRyMj8cXXu3qDHXzb7GIyKGEj4VGjze6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgWnWSUfQ2ToGQesjL3msqCE8+SDRSgWfv/XxjqWQXc=;
 b=SmyS5hBIQbwBAv5d4NZC4EZAsUyn3EDkuTKs2DUYaU5jWNnCVkz7loJK9/vKASGZJ1oRf0L+awS0xSOy+rhzuj/UYP1hLqhfseFhKkhdwm/zBcfPfSMSZ7UZTJqINsJDAlc06vYvbx5f5vK6BjP9pf09TeSwDGQm3bpYkwE+Oi2hHbe2JkcHyjXZXuPW3qyQJhCfmD0jRsq8Pe2ohpGsLnzioS0sqEE3TtG4MHglVdvyM8aqwB4lsdYZi1gwBrCZujQJkB54K4m1Fe2533U7U09bvGAq/R+c1rs08p7TUdqiR+ovOfDvEs6h5hpU/pVDTVlBWJDMs6XM/8YM8hezmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Akihiro Suzuki" <akihiro27.suzuki@toshiba.co.jp>
To: <masashi.kudo@cybertrust.co.jp>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: [cip-dev] CIP IRC weekly meeting today
Thread-Index: AdYeii420HEWkZLJTG+HNfuVKCzjngAOb5uQAABLbLAAAQv2MA==
Date: Thu, 30 Apr 2020 08:31:54 +0000
X-TSB-HOP: ON
Message-ID: <OSYPR01MB53340597D64DF28E2F0AF26BD9AA0@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <TY2PR01MB497292B5ABFEA4BC5CC874F9A0AA0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <OSAPR01MB3667B7F6BD8666E1A789657E92AA0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
 <TY2PR01MB497278C2FC9FA3D574DBBA1CA0AA0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB497278C2FC9FA3D574DBBA1CA0AA0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=akihiro27.suzuki@toshiba.co.jp; 
x-originating-ip: [240f:7b:53f0:1:4d60:d599:32d0:8649]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1316b953-2520-4974-b79a-08d7ece0f030
x-ms-traffictypediagnostic: OSYPR01MB5320:
x-microsoft-antispam-prvs: <OSYPR01MB53203E6DB575B24E335943E9D9AA0@OSYPR01MB5320.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0389EDA07F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5334.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(5660300002)(66446008)(64756008)(66556008)(6916009)(66946007)(66476007)(478600001)(6506007)(53546011)(76116006)(7696005)(4326008)(2906002)(33656002)(966005)(186003)(71200400001)(9686003)(86362001)(55016002)(52536014)(81156014)(8936002)(316002)(8676002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vieVKfEiqgoo7aU0uCywMIDv8GTQMpU1giyCtEw0YlRtbkqy1s4LVPm92l+Dkfi9AaENNnrt51H1UsAS8YDDRzLhvmrb4r5YZSS0Lgy+e7OuR8RYU1fDh5c3GDUgZZshlaSgLDnIu2HSxA7Uk8XB4XZxplKLhyG40HZZJ6CBbsEGq1+wi7ZTGWl1gyOZDuvG7YPVCzYjGx3W1M8QYssgndESTfeRTt73Nta/U+rOX1QJZBJnrVdJd/v+yU1a94G+TaDkQM8kWOkL9hfjRLGYmAyuz5JB45FX6jfnyTVX4mYlPnBODad6TP5oU57DhtoyZb1TmWqOMLitwwmaskkLKmcCh3DOZ+7t0nPMYVUbjW5ZqFZbKnemaeW1oNWbKCZh8uo9tjSDfmXd6cj1De6l+7PESsXpoX3utVvKo4AECyCcKhOHks9tNy2o5goDMXGv1x5mgC/UHZiwuERQcacH36UBiVER51mpHAUqohLYYPLUJHr2XVAi3MIak4D+7olOxUPNtUECy/O1D/hNRGKUJw==
x-ms-exchange-antispam-messagedata: oO9FnPb0uOcdGqzz0dc7oysBwvlglRi5Lb7JelD1IjndVttddEg269/SigWBtKqWSHR71IhESVI950Ysxfw1ACWIRC6iX8A0AVAw75wMO4ve+K5d67Ms/2qFfeylRgRFoBqFZhVoBCMIkvyOrg0EVwyj2RTeBvEJQPoFs7kfMc97Dr8/3mTzNNqEg5LU2bvv+7bJfBKMWQhpfYVXvVsETOt8lpdbyjJx2WSaKrv6I5qeSy15W05WsHGDCNbwi8iJY5vRdEFXMsmjnSKeZfC9LKTsMZwRhegjfaWbFEEw8Vad9k1vNoByB67xnBiXqg8PzdU6oNbgkeHbLlbMipbHT1vW1xz9x4/cNMs5owBZN1PsNF4RVhB7fWwSrdiwjlVvF5rIkZPvtR4q16U+ensUzX0a942qie9EOa/qRLloN80oYsmCxNxeZ+F+/QWfLn+oa1T0BmTwb6Itn6fLhe4SY3VMljxlDHDKgkZjvk14K9IFFhVv98mOONUAWqsibNHQ/BJWvBPlQ8kOTOk/g/Hw07vj20Z+v0ZBXcgQ1LljAYk2FAozGo04ZFEqW9igxpjhRwMokLrxMWkmlrF3qdeuIL4TK5jIdBTwwizmpGt6xtH10ASKqXtdPHwj/6B0vdGGvOdUpBi8IT3QyEjlNc70zaHr4ad1QAqksnekaKGfTTge/boFhrYkXMCkgaqP35BlzDvPQsTz+rdyk46StVrQaQLWYyqEoPMlcNdyeJ2m6V2NNbZ/LHI3y5St66z+42x8TuVhLLtDlhq5bXC0/MUjkFR07x/5mgGN35hZW84k+M5Knh8F95qKotcePHE+OMobhfhCT9oLJsmcYUXqFqj+wHGZ58Yp+y88YhT0pDUbVhg=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1316b953-2520-4974-b79a-08d7ece0f030
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 08:31:54.2031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jaRF/MYFW1pTB7/aniIg8gam1C/+c+uqezxCaSxSBpVazPm0brRiDhjAYy9WwNO7o3cGdo6DC2zWBCqkm4cFtc6IDolQBk+txVQlpfEdRok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5320
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Content-Language: ja-JP
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

SGkgS3Vkby1zYW4NCg0KQXMgSXdhbWF0c3Utc2FuIHNhaWQsIEknbSBvbiB2YWNhdGlvbi4gU28g
SSdsbCBiZSBhYnNlbnQgdG9kYXkncyBJUkMgbWVldGluZy4NClNXIFVwZGF0ZXMgV0cgaGF2ZSBu
b3QgYW55IHVwZGF0ZXMgdGhpcyB3ZWVrLg0KDQpUaGFua3MsDQpTdXp1a2kNCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mIG1hc2FzaGkua3Vkb0Bj
eWJlcnRydXN0LmNvLmpwDQpTZW50OiBUaHVyc2RheSwgQXByaWwgMzAsIDIwMjAgNDo1OSBQTQ0K
VG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQpTdWJqZWN0OiBSZTogW2NpcC1kZXZd
IENJUCBJUkMgd2Vla2x5IG1lZXRpbmcgdG9kYXkNCg0KSGksIEl3YW1hdHN1LXNhbiwNCg0KVGhh
bmtzIGZvciB5b3VyIGVtYWlsLg0KVGhlbiwgc3RheSBzYWZlIGR1cmluZyB0aGlzIGdvbGRlbiB3
ZWVrIQ0KDQpCZXN0IHJlZ2FyZHMsDQotLQ0KTS4gS3Vkbw0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnPiBPbiBCZWhhbGYgT2YgTm9idWhpcm8gSXdhbWF0c3UNClNlbnQ6
IFRodXJzZGF5LCBBcHJpbCAzMCwgMjAyMCA0OjUzIFBNDQpUbzogY2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmcNClN1YmplY3Q6IFJlOiBbY2lwLWRldl0gQ0lQIElSQyB3ZWVrbHkgbWVldGlu
ZyB0b2RheQ0KDQpIaSBLdWRvLXNhbiwNCg0KSSBhbSBvbiB2YWNhdGlvbiBhbmQgY2Fubm90IGF0
dGVuZCBJUkMgbWVldGluZ3MgdG9kYXkuDQpBbmQgb3RoZXIgVG9zaGliYSBtZW1iZXJzIChEYW5p
ZWwtc2FuLCBTdXp1a2ktc2FuKSBhcmUgaW4gdGhlIHNhbWUgc2l0dWF0aW9uLg0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qu
b3JnIA0KPiBbbWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnXSBPbiBCZWhhbGYg
T2YgDQo+IG1hc2FzaGkua3Vkb0BjeWJlcnRydXN0LmNvLmpwDQo+IFNlbnQ6IFRodXJzZGF5LCBB
cHJpbCAzMCwgMjAyMCA5OjU3IEFNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9y
Zw0KPiBTdWJqZWN0OiBbY2lwLWRldl0gQ0lQIElSQyB3ZWVrbHkgbWVldGluZyB0b2RheQ0KPiAN
Cj4gSGkgYWxsLA0KPiANCj4gS2luZGx5IGJlIHJlbWluZGVkIHRvIGF0dGVuZCB0aGUgd2Vla2x5
IG1lZXRpbmcgdGhyb3VnaCBJUkMgdG8gZGlzY3VzcyB0ZWNobmljYWwgdG9waWNzIHdpdGggQ0lQ
IGtlcm5lbCB0b2RheS4NCj4gDQo+ICpQbGVhc2Ugbm90ZSB0aGF0IHRoZSBJUkMgbWVldGluZyB3
YXMgcmVzY2hlZHVsZWQgdG8gVVRDIChHTVQpIDA5OjAwIA0KPiBzdGFydGluZyBmcm9tIHRoZSBm
aXJzdCB3ZWVrIG9mIEFwci4gYWNjb3JkaW5nIHRvIFRTQyBtZWV0aW5nKiANCj4gaHR0cHM6Ly93
d3cudGltZWFuZGRhdGUuY29tL3dvcmxkY2xvY2svbWVldGluZ2RldGFpbHMuaHRtbD95ZWFyPTIw
MjAmbQ0KPiBvbnRoPTQmZGF5PTMwJmhvdXI9OSZtaW49MCZzZWM9MCZwMT0yMjQmcDI9DQo+IDE3
OSZwMz0xMzYmcDQ9MzcmcDU9MjQxJnA2PTI0OA0KPiANCj4gVVNXZXN0CVVTRWFzdAlVSwlERQlU
VwlKUA0KPiAwMjowMAkwNTowMAkxMDowMAkxMTowMAkxNzowMAkxODowMA0KPiANCj4gQ2hhbm5l
bDoNCj4gKiBpcmM6Y2hhdC5mcmVlbm9kZS5uZXQ6NjY2Ny9jaXANCj4gDQo+IExhc3QgbWVldGlu
ZyBtaW51dGVzOg0KPiBodHRwczovL2lyY2xvZ3MuYmFzZXJvY2sub3JnL21lZXRpbmdzL2NpcC8y
MDIwLzA0L2NpcC4yMDIwLTA0LTIzLTA5LjAwDQo+IC5sb2cuaHRtbA0KPiANCj4gQWdlbmRhOg0K
PiANCj4gKiBBY3Rpb24gaXRlbQ0KPiAxLiBDb21iaW5lIHJvb3QgZmlsZXN5c3RlbSB3aXRoIGtz
ZWxmdGVzdCBiaW5hcnkgLSBJd2FtYXRzdS1zYW4NCg0KTm8gdXBkYXRlLg0KDQo+IDIuIFN0cmVu
Z3RoZW4gc3VzdGFpbmFibGUgcHJvY2VzcyB0byBiYWNrcG9ydCBwYXRjaGVzIGZyb20gDQo+IE1h
aW5saW5lL0xUUyAtIEtlcm5lbCBUZWFtIDMuIFVwbG9hZCBhIGd1aWRlbGluZSBmb3IgcmVmZXJl
bmNlIA0KPiBoYXJkd2FyZSBwbGF0Zm9ybSBhZGRpdGlvbiAtIG1hc2FzaGk5MTANCj4gDQo+ICog
S2VybmVsIG1haW50ZW5hbmNlIHVwZGF0ZXMNCg0KSSByZXZpZXdkIHY0LjQuMjE5IGFuZCAyMjAu
DQoNCj4gKiBLZXJuZWwgdGVzdGluZw0KPiAqIENJUCBDb3JlDQo+ICogU29mdHdhcmUgdXBkYXRl
DQo+ICogQ0lQIFNlY3VyaXR5DQo+ICogQU9CDQo+IDEuIFNvbWUgdG9waWNzIGZyb20gVFNDIGNh
bGwNCj4gDQo+IFRoZSBtZWV0aW5nIHdpbGwgdGFrZSAzMCBtaW4sIGFsdGhvdWdoIGl0IGNhbiBi
ZSBleHRlbmRlZCB0byBhbiBob3VyIA0KPiBpZiBpdCBtYWtlcyBzZW5zZSBhbmQgdGhvc2UgaW52
b2x2ZWQgaW4gdGhlIHRvcGljcyBjYW4gc3RheS4gT3RoZXJ3aXNlLCB0aGUgdG9waWMgd2lsbCBi
ZSB0YWtlbiBvZmZsaW5lIG9yIGluIHRoZSBuZXh0IG1lZXRpbmcuDQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMsDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0KDQo+IC0tDQo+IE0uIEt1ZG8NCj4g
Q3liZXJ0cnVzdCBKYXBhbiBDby4sIEx0ZC4NCg==

