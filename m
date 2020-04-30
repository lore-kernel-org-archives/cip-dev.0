X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.2864.1588233197280736667
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Apr 2020 00:53:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 03U7rEkk022692; Thu, 30 Apr 2020 16:53:14 +0900
X-Iguazu-Qid: 34triqBKQnPsHhlDyv
X-Iguazu-QSIG: v=2; s=0; t=1588233193; q=34triqBKQnPsHhlDyv; m=onxWciz1W+jvwFQ1LtEnluuCJRz9gqTdLW0fnH6jpIg=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 03U7rDio000730;
	Thu, 30 Apr 2020 16:53:13 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 03U7rDJw000157
	for <cip-dev@lists.cip-project.org>; Thu, 30 Apr 2020 16:53:13 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 03U7rCc0008143
	for <cip-dev@lists.cip-project.org>; Thu, 30 Apr 2020 16:53:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNHPyqk+Sm74brjaAd7WofUFgl+aFrs6ZqnIaGCDLYvepgr1AooouNPILAlOQkoILLDwg3P6JI95gJiMyWFNADQxZ6N+lF8HL0DBF/KkuI7WRJHR/5eSo3r9CKYiZGyRu05bPVvZQJEFv4S585h83Yc7HQbKINuHIjmSl+qrGR4apwaZI5Yj0D4a/jyIDm74DahF2jxKUmgby7mAA3f9/qnhwRO/dmak70XoFsC/dM7+vX2BYdl/5M+odof750xrOdVqsajGXzpr5ASvW/IJ1uQe3GM2IuY1eE+8pufHz8CKbC3an5glXsrawmO370zZsf09oJx/78RvS5IBQZn1gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEBOtNEsPKRfmF9CS98nw5BWQyOkn2pK2c+WDANvFuc=;
 b=KqnAVrfrXcY7f8lQyalKf+hZXAyZh7KS7AJt2Hajyu9HABF/xeRupt2YK7FOxfE9CBpOk80byoEA85xx70fnJ8QjrF160RgOflIz/JaKa/W2dAtQp+nI050Fx/9/cN550jt6HHjlZfaJ4+YQ7oc4InSHnBS94Auk0m/2ORRh5UAMGlDU9t5FW9BIBMocslcvmP2MViW9nnwzmiPcJ4Q5QpUIquN+xdEWv+ZmpG+qmbWI1I7Cgb/jqpuKZ08Mn/8We0kwgnyJi3kYjSRvzfBbfPh7brhmUsBUvTUtYtjEtrABZ9Qv7MDtcBo1q1SDwztB2fLqQIuQ8KLNVuY+88A3dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdYeii420HEWkZLJTG+HNfuVKCzjngAOb5uQ
Date: Thu, 30 Apr 2020 07:53:11 +0000
X-TSB-HOP: ON
Message-ID: <OSAPR01MB3667B7F6BD8666E1A789657E92AA0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
References: <TY2PR01MB497292B5ABFEA4BC5CC874F9A0AA0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB497292B5ABFEA4BC5CC874F9A0AA0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
authentication-results: lists.cip-project.org; dkim=none (message not signed)
 header.d=none;lists.cip-project.org; dmarc=none action=none
 header.from=toshiba.co.jp;
x-originating-ip: [2405:6581:5360:1800:18a5:7534:3f8d:363f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73e16d35-ef23-4b7b-8f25-08d7ecdb87a3
x-ms-traffictypediagnostic: OSAPR01MB2212:
x-microsoft-antispam-prvs: <OSAPR01MB22126BA7172E68C17D8E4F2492AA0@OSAPR01MB2212.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0389EDA07F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xf2Is98/fnwPO4trlySlCQ0c4Az59iglynGaUI8oSYCwHjtVhvnQHlqR3HbWwerO3WxFcBHoEO487E9+lJgsC+SATbHLMXxG4bbxsMjd6F61atikw/TiYYMNNp5yF6HwKBlF0evEQiaVCjE2RREUr+4lLvkA+irdx52z3NFcoqJumQjhh092YUbYB5Ol4iVhv0AjliyETcjwvz+6IFkZ292lW2IXViyA0oKepakeNVSVJnsUWZIADjur6H7kWBykimJnoQrUcVoa9mWy8JiqHKjv+FCFvWRV7flHSAbMIYVuOaxftVpB4OhLAXx5SBRFu+r6inB4lZv613Sb8eykFVTvdxyBa/aB7HvDvFDGBs1+H74HlT4tnEjYs0ZLq8hMPwVLrGzKtUL7+cT7po3MtOgHUux6qUxFFwwIibk1+Tcx/Dwbp42uUuHb6GlMIVFb/+knTIw48L4h222uv2p5LHhoHYVxcjGsLy1d8vr56PxiLjgSOhrnsmh8h8j9oqEcoY+XfTAK2Ah7YrtoXyUy/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3667.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(66476007)(186003)(6916009)(76116006)(5660300002)(8936002)(316002)(71200400001)(53546011)(52536014)(6506007)(8676002)(9686003)(66556008)(55016002)(7696005)(33656002)(66946007)(2906002)(64756008)(66446008)(86362001)(478600001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 83fUQIJjkD5/3P3ILMR5r7sJEjXlewnYvRoGLajDeu/cFCEGGbzN8R0z8BLef/tINnV5He46Ht8ymnrwh1FAcCNwxkVlwNV1sdNQq9m+5FBSbcy27Zkvyodf+TH17dU/KiyXe9eAfQsWAsCjCkR0x78tNI3jdIuPMn0Jtuh5frDJw05KXxL8Dzsfc8GS+ZifHRVdl+ldVgwWadldb224XfFIav6uU9PlH7e7KZRewx8jJ0lX9+TcyFj7Kdez16PgB6isjUDnOeDWzjhf1gcEq8qelJYQYRxbI6DwrdA9BQAlU3cTcnLe4xZs0WmLzAysg6LKy5pIyV2spO2zvD/v0pjQfivDzGy4Rx8Xkb9Z2jJAvgPbSSuxlRiSOyjYSImCoTbyGIy59btr9/kvc4JtmxzC+fd7EBcLOJ9Fi0zvXBfYxwncBJb3e3kMY5RYn1GMtf4FSAukVbBG/Cb70emPZXuZrY5w3EsBFkYanaElzPVLJgL+Hby4wFy+NO2B8rHm/5BY0tLOFJRMf+JUCO/l+iSp1gdKxFPJLjqrP48byPp4La98Y18hAT8CFg3EIdFe7IYk3trEGV56Z58OCVhec8j/ufopXZYQrlt4nQquRV5LmbBhnvQo8dhzsQl/TJZMdABhz9uyNrcDlShK/G9DXXltrBYvUFKu00M90kTfUygmlQN2w2jqz9PL9v8MJihp6jJxMoL5USRF6l2OHzwhTVHvbI2J2D71UBQtQ8kq5AKX3Cl2/LGsa7nl4ZGsu+jZjRTmo3Kmda9I0UQlYnK1omKJhAUPzkLhIXOJeTw+MNkpgh81N7tQiMJwY2SGO5vKCuHxwyqqHK6e+1iIJR2DQDrHKPgbRuolipGoUsiq8iShBfgj/z3kgPE3Vo9lXJJu
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e16d35-ef23-4b7b-8f25-08d7ecdb87a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 07:53:11.3111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Is79Lkq8nQkcTAlnGL6mI17eCKzq58XMjFSZF0GkRgfSKbi9AqU3gcBYDdh9l0uCbg9kk2rcd/jmHXwsNixO0ZBrcIy1lNDtn6NJdJEXT+R5FaR+1oHOf11C1xauIGrF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2212
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Content-Language: ja-JP
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

SGkgS3Vkby1zYW4sDQoNCkkgYW0gb24gdmFjYXRpb24gYW5kIGNhbm5vdCBhdHRlbmQgSVJDIG1l
ZXRpbmdzIHRvZGF5Lg0KQW5kIG90aGVyIFRvc2hpYmEgbWVtYmVycyAoRGFuaWVsLXNhbiwgU3V6
dWtpLXNhbikgYXJlIGluIHRoZSBzYW1lIHNpdHVhdGlvbi4NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyBbbWFpbHRv
OmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnXSBPbiBCZWhhbGYgT2YNCj4gbWFzYXNoaS5r
dWRvQGN5YmVydHJ1c3QuY28uanANCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDMwLCAyMDIwIDk6
NTcgQU0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1YmplY3Q6IFtj
aXAtZGV2XSBDSVAgSVJDIHdlZWtseSBtZWV0aW5nIHRvZGF5DQo+IA0KPiBIaSBhbGwsDQo+IA0K
PiBLaW5kbHkgYmUgcmVtaW5kZWQgdG8gYXR0ZW5kIHRoZSB3ZWVrbHkgbWVldGluZyB0aHJvdWdo
IElSQyB0byBkaXNjdXNzIHRlY2huaWNhbCB0b3BpY3Mgd2l0aCBDSVAga2VybmVsIHRvZGF5Lg0K
PiANCj4gKlBsZWFzZSBub3RlIHRoYXQgdGhlIElSQyBtZWV0aW5nIHdhcyByZXNjaGVkdWxlZCB0
byBVVEMgKEdNVCkgMDk6MDAgc3RhcnRpbmcgZnJvbSB0aGUgZmlyc3Qgd2VlayBvZiBBcHIuIGFj
Y29yZGluZw0KPiB0byBUU0MgbWVldGluZyoNCj4gaHR0cHM6Ly93d3cudGltZWFuZGRhdGUuY29t
L3dvcmxkY2xvY2svbWVldGluZ2RldGFpbHMuaHRtbD95ZWFyPTIwMjAmbW9udGg9NCZkYXk9MzAm
aG91cj05Jm1pbj0wJnNlYz0wJnAxPTIyNCZwMj0NCj4gMTc5JnAzPTEzNiZwND0zNyZwNT0yNDEm
cDY9MjQ4DQo+IA0KPiBVU1dlc3QJVVNFYXN0CVVLCURFCVRXCUpQDQo+IDAyOjAwCTA1OjAwCTEw
OjAwCTExOjAwCTE3OjAwCTE4OjAwDQo+IA0KPiBDaGFubmVsOg0KPiAqIGlyYzpjaGF0LmZyZWVu
b2RlLm5ldDo2NjY3L2NpcA0KPiANCj4gTGFzdCBtZWV0aW5nIG1pbnV0ZXM6DQo+IGh0dHBzOi8v
aXJjbG9ncy5iYXNlcm9jay5vcmcvbWVldGluZ3MvY2lwLzIwMjAvMDQvY2lwLjIwMjAtMDQtMjMt
MDkuMDAubG9nLmh0bWwNCj4gDQo+IEFnZW5kYToNCj4gDQo+ICogQWN0aW9uIGl0ZW0NCj4gMS4g
Q29tYmluZSByb290IGZpbGVzeXN0ZW0gd2l0aCBrc2VsZnRlc3QgYmluYXJ5IC0gSXdhbWF0c3Ut
c2FuDQoNCk5vIHVwZGF0ZS4NCg0KPiAyLiBTdHJlbmd0aGVuIHN1c3RhaW5hYmxlIHByb2Nlc3Mg
dG8gYmFja3BvcnQgcGF0Y2hlcyBmcm9tIE1haW5saW5lL0xUUyAtIEtlcm5lbCBUZWFtDQo+IDMu
IFVwbG9hZCBhIGd1aWRlbGluZSBmb3IgcmVmZXJlbmNlIGhhcmR3YXJlIHBsYXRmb3JtIGFkZGl0
aW9uIC0gbWFzYXNoaTkxMA0KPiANCj4gKiBLZXJuZWwgbWFpbnRlbmFuY2UgdXBkYXRlcw0KDQpJ
IHJldmlld2QgdjQuNC4yMTkgYW5kIDIyMC4NCg0KPiAqIEtlcm5lbCB0ZXN0aW5nDQo+ICogQ0lQ
IENvcmUNCj4gKiBTb2Z0d2FyZSB1cGRhdGUNCj4gKiBDSVAgU2VjdXJpdHkNCj4gKiBBT0INCj4g
MS4gU29tZSB0b3BpY3MgZnJvbSBUU0MgY2FsbA0KPiANCj4gVGhlIG1lZXRpbmcgd2lsbCB0YWtl
IDMwIG1pbiwgYWx0aG91Z2ggaXQgY2FuIGJlIGV4dGVuZGVkIHRvIGFuIGhvdXIgaWYgaXQgbWFr
ZXMgc2Vuc2UgYW5kIHRob3NlIGludm9sdmVkIGluIHRoZSB0b3BpY3MNCj4gY2FuIHN0YXkuIE90
aGVyd2lzZSwgdGhlIHRvcGljIHdpbGwgYmUgdGFrZW4gb2ZmbGluZSBvciBpbiB0aGUgbmV4dCBt
ZWV0aW5nLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJv
DQoNCg0KPiAtLQ0KPiBNLiBLdWRvDQo+IEN5YmVydHJ1c3QgSmFwYW4gQ28uLCBMdGQuDQo=

