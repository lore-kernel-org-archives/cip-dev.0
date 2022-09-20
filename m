Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535CEC54EE9
	for <webhook@archiver.kernel.org>; Tue, 20 Sep 2022 10:36:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web09.10116.1663670211107598586
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Sep 2022 03:36:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158,
 mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 28KAam5Y009284;
 Tue, 20 Sep 2022 19:36:49 +0900
X-Iguazu-Qid: 2wGr4d9xrkyTqvJ9fz
X-Iguazu-QSIG: v=2; s=0; t=1663670208; q=2wGr4d9xrkyTqvJ9fz;
 m=O8T6l8Ap+EIpj8I8h7kP4l0VBFlVN3guoogCU4p2lSU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 28KAalSV019007
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 20 Sep 2022 19:36:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gR/3msHNJO9qQyOb6UUHsU0Qrl3kjfUBvhUm81ZHRdxvI1GWwPYPdojKVXeMKKt/dJki2hNHgvddhEqDlhNqEkq6DKP4AhYOlh0laYIR5tz01zDDK+vMo1cYLTvcHt3GthOB71vo6WsnUwIJMjn1D7YOU9Jl/rQ4Agm0sI0CV2i/aGm7YTo7Jl+hS3WGYxMAOJR37TQZHd3QIbDFwZe1B9F0DlJzRiUzGd3fjtaIJIFYt5gM8QtFvqY6d8kt7sxB4BEA1DqzIZFrBIIE/8hO+zOyycRANeqofFKhM0wSvXOh9MapSM5CkA3r89Fc3IIDOpSL0KspXhUGQzsdS7Q1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2uW6OzWRyuO775Mpish5gJPf27+lQwaKieuwKtVTcY=;
 b=bQTf+WW9fAMqG+HLt/zAd5HDfoP4uOtYcROSOYRPxcevc4msHEEl6bRgh95qU0+CaCMZM7i+7U2KbPyXjrjTrbYx2xMTTh0pHdlnFYuyE9xzARh+kPIH42kpt0YxTdvygC8LdFFgKAhOo388vJW9vhy7veqXuAsrCehZtaa3QbhXIFF+LayVzGLz+JMaiouvha7kNC7/x1NAx+J0LprJHMOjGC3ULzBVUEPFz+7xxb3QPJTfq7Z2CEc9WPWmpPZ+yAuHc1veEza1hM9uEur5FqI2mANF2X3sdKZMuSaOZH2398eaSvvzrZipGtRjLMK0m0dri4dMruEQ0qKtYRVdQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core v2] README.swupdate.md: Add steps to
 verify SWUpdate on BBB
Thread-Topic: [cip-dev] [isar-cip-core v2] README.swupdate.md: Add steps to
 verify SWUpdate on BBB
Thread-Index: AQHYycK7LmHFWNafNEalxQ0yB0dsO63oIJOAgAADSXA=
Date: Tue, 20 Sep 2022 10:36:45 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB61475462E1DE7D2C7634937DC74C9@OS0PR01MB6147.jpnprd01.prod.outlook.com>
References: <d98e57e9-2219-6e09-582c-b465e9295193@siemens.com>
 <20220916114330.18443-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <cddf20b2-2763-8f2b-f313-54a95f32b15e@siemens.com>
In-Reply-To: <cddf20b2-2763-8f2b-f313-54a95f32b15e@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6147:EE_|OSZPR01MB9635:EE_
x-ms-office365-filtering-correlation-id: f5c84c68-fc67-4040-15c8-08da9af403d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 g8iaNyR230o95eEYJwYdpF9NA800SfwEj0HuEwW/f162+1NprcEszl6OVG3BCjIVSpR/mCO1Vsrcb5zAR+wqxThb2I62FgR5r54BzjqF0/aJwJtAh8aMV8y2ahiGyV6qzm+VKWw/1qhF01ZCjlEOV6ZQ7Z97k6fwQEWAxwjyZOVwenkH/VRd1iaj9cnVitqgFLffB7PCCzaAPf5z00C91fn5lf/P2Sdm1wFVETtCKpW8A/Og2IkDef6crINlbU8ApKyRboWmMmlyUnb2Gdo57qW2JqYqOqxSzahglnsyn5iTCSj7Ob5KTCDqlJ/3mSsIlkyGhcUOqFr2Acx0SShCYruFlqgqM5HpFNJWNrOYihdq2kSZ6c+az0NLnNSouw5sApwLH+mFuZEnf/0u1feuWH3jg3C9KI6tHKzk8l04yrSeOFvaVkWwLZdLB8Aj/rrkz2O6bpk0eFUI+zy1sUFSkZMHJDrBCSb6nz2kxaai2AbVBAHzP+cUmbGqYt97wEFBY+K/MukhicZcvCGHPCDB6a94/emu8e4IPtpOQrCjKQzMeLligzXEUVpB8i8OI/KbfqMyQ0Oc/BAQ4mUkSlbhj1lxil/85doJypEuQ3fq4dCoz5ukIyzAWwcgqGLmQNFeWiHWK9k+ADaVbXs9vIlyJ9MDkZqLvMCpn7BKqK7E/HRkMWdnF+kjZel+s5c0JzF38yXY+Ehb1EwVAXzlL5QkqCp+Ap/7H9puRLiKYROCTljdNKO0wVLLAOwb3UHeWsw2+HNaqfFIfq1IQ3wDu5ZzAQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6147.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199015)(2906002)(53546011)(38070700005)(7696005)(41300700001)(15650500001)(6506007)(64756008)(55016003)(8676002)(4326008)(33656002)(76116006)(107886003)(83380400001)(6916009)(66446008)(66556008)(66476007)(54906003)(52536014)(316002)(478600001)(71200400001)(86362001)(186003)(5660300002)(8936002)(66946007)(38100700002)(26005)(9686003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Z2kwSExmcldFMlp2bmljM0t0R091TXBGVTRvempDWHc2bUJEWDc0S2cwcjNv?=
 =?utf-8?B?VkY3Z04rMjhBOXNUeE1ub202S1hnVlBTS1VPRUI3SWp3VDhPSmZvR0JZSDJS?=
 =?utf-8?B?Y2xRK0N0SjZpd2lnM2tqRjMxeGhHSlRvS3VKdDVPc0lJa0QwcStlUHF2eSs1?=
 =?utf-8?B?UHUrTzBxNmFURHd4Ykg5Q3NvZWJkTEN6Q0krQU1ublgrTzNEbUdkdGwrVzQ1?=
 =?utf-8?B?L0VMeGNtV29YR2h1ckRYeTU3TFpCMWxqLzhtNUw5OWNlb1lYN3JuemVKL2xT?=
 =?utf-8?B?TXB4UGVrR0lqb1hWN2J2Ri9jUjluU3BzRWNwbzhwQVhXMG9TNG9NVHlpMDQy?=
 =?utf-8?B?dHhma0cvZ3pPK0hoN1VqbjRtT2g4WEN0Y2p6YjlJVHBaRXZ4VVdaWUlTYno5?=
 =?utf-8?B?WEoyd3NoNTJRZjZhb0IvQUNNTU16bkRsUzVINnRLZmo1aUNOYnp3RlNZSWU2?=
 =?utf-8?B?b3hzQ096Qms3WEVPNjYzR1BhVDRONCtQSytmTDVkQ0RLU3ZqZFR5TzRmQkFn?=
 =?utf-8?B?dXJjem9MT0dOa2taanBpZGJ1Ni9abWZUUUJ2UWtBeE5iSk4waW5wTXFNNFpO?=
 =?utf-8?B?VXRTVWVDdUt5Y0ozL2lqcUNCeTBteTVkaTZPU0pMZ2MrRWQvMHFEQTJHdHNK?=
 =?utf-8?B?Qm10SXU5cmtKU0R1Z29YWDk2bTVONm9WQ01yeUwybTRoeGYxNG1OSytkS2du?=
 =?utf-8?B?T0lEOWVESHNIdTlDZ3dpTllBL0M3amxtdzdzTlRtYkxwRFh4V0FEQzc2M09z?=
 =?utf-8?B?YTYvSUZkaFBnL0d6UVR2Uk1qRmppMHljcnBMMlhsbGVjS1ErWmxvQVkrU01G?=
 =?utf-8?B?QTcvSCtJR2lnamxCU0NnKzJXQzFKbW1wdytpTVZ0dEZPcGF1Y0E0a2h6Z0pJ?=
 =?utf-8?B?K3hla1NDSTVqOEg4RUZCQ2xSZXRnenZEUStlbFFFazdRRFlyUUdoallkVGo1?=
 =?utf-8?B?bXdTRW5RbzQreVVoUTB0OURoMWphdTh4bEZLTFQyVEFGVzlESDNTOGcrbStm?=
 =?utf-8?B?UFg1WHB1V3REMW5Oaldoa05tQVZHcXNsc1R4Q2VsMy9OTFZHTGFKbG4zQ3B3?=
 =?utf-8?B?MWNsbnAwRjhCQkhuZjlmZ29zbzNjbGNkclQ5eG5MWldFLzMyaStNU0cySzZo?=
 =?utf-8?B?Ry81cUtRd2pGYlRvV25aOU5wM3E1YWxoa1FpQkdTYURQRms3OW9EZVJOMjFZ?=
 =?utf-8?B?UzE5U1NxeVR6WjZsM1dQVG4vb1VTQnlGL2s4bkFjSFR6dkFqbzR2eXB0aCtG?=
 =?utf-8?B?OHJDRUs1VWhSUlJHRWg3d3J3NENXM0hQMU85bXdISTZHblBnaGwvVU9nTTVO?=
 =?utf-8?B?UHduc0MrNEE1YXhpOUZveGx1dVVWczFpblVOQnk0SGovbE9HRlQvb093dllv?=
 =?utf-8?B?dUgzU0wwNnpvUWpldUx6VjhTUkpUZXlJZUFURUZGVlMrZVdBbnRKc0FIVEtk?=
 =?utf-8?B?Wm1rVmtoY1VoaFJBZmF1NUhWdjJZcGRTQy9kZTc4b0pnaTlFREQ0eWVyYmNB?=
 =?utf-8?B?SWJ4MHE3ZlRjMFlhallab2ZybDhmTGtpaC9qUGhhR0NQbENsTW9ETWlRTUdK?=
 =?utf-8?B?em0xZTAwY0dndmtkNTl4bkJ1VGl2NllIQ0ZRWFppZUFFUm5uZjc2RzFsOGQ2?=
 =?utf-8?B?ZE5qME84NlpiRW5VS3E3NUxDek1zTE5IdEJWV3ZmV1RoWFY3SWVtR2R6QkRO?=
 =?utf-8?B?aVdXaXNwcGtGcTFIZjBjcGdaZTRhZXcrSldJQnJVTWozZFpVVC8zM1ErcS9S?=
 =?utf-8?B?amdocU1xb3lFRXpxbS9XK2FwSjY2ck0wblByeFRDcW9HZ3ZWeDc5TklHTzFM?=
 =?utf-8?B?M0RjeGJlRGE5dVRmdkNQUnQ4MUVjOGxGa3FxODFXa0JvOENrZzM1Ukp2MHRi?=
 =?utf-8?B?Y3RHTnRjTGxkQ0RtcUd4Mlk2QmtlcDRIVktJL2tlSW5VL1ZreU9iYmxJUFdU?=
 =?utf-8?B?a2swMUhVTDdZNkdRTyttSUpydEtVc3NqbzZUMUZmT0N3R3FDL3ZiMjA2WUE1?=
 =?utf-8?B?VUxsWWxSV2ZWZGdiSnd6ME9hWHEvVm53Q09rckxDc3U2Rzl3bUtLckQ4Nmtl?=
 =?utf-8?B?Sm93ZU9PUlVoQ3BUTTIzSVlvdWRwZVIrR0R4RjlNKy95Q1dZNHZvMG00bHBH?=
 =?utf-8?B?bTFYeUZkM28rMzEzbHkxK0JjeGg4UXJGQ1hxWGNEL0Z5TEEwM0pEN0hpSGlX?=
 =?utf-8?Q?/BV7kO6yBTvwIdqVVM6+tIw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6147.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f5c84c68-fc67-4040-15c8-08da9af403d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 10:36:45.2806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 K78u6EBcD7s2hUmw4IEEstM+sgFs7V4mgva2mrUXJMDByBJHZRoUiFGW4oAFsqoqzEz6jcdLM2dw5ugj/K9L89GgbQdu5a04W2l0FjIKVr1axjArJqIYHgw2h76lIUTf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9635
X-OriginatorOrg: toshiba-tsip.com
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Sep 2022 10:36:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9525

SGkgSmFuLCANCg0KPiBUaGlzIGlzIG1pc3NpbmcgYSBzdGVwOiBCdWlsZCBhIGRpZmZlcmVudCBp
bWFnZSBjb25maWd1cmF0aW9uLCBlLmcuDQo+IHN3aXRjaGluZyB0byB0aGUgUlQga2VybmVsLiBP
dGhlcndpc2UsIHlvdSBhcmUgbm93IHN1Z2dlc3RpbmcgdG8gZmxhc2ggdGhlIHNhbWUgU1dVIG9u
IHRoZSBkaXNrIGFzIHlvdSB3cml0ZSBhcyA+IGZ1bGwgaW1hZ2UsIGFuZCB3ZSBrbm93IHRoYXQg
dGhpcyBpcyBicm9rZW4gKHBsdXMgd2UgaGF2ZSBubyBlcnJvciBkZXRlY3Rpb24gZm9yIHRoYXQg
eWV0KS4NCg0KSSBoYXZlIG1lbnRpb25lZCBhIHJlZmVyZW5jZSBzZWN0aW9uICJidWlsZGluZy1h
bmQtdGVzdGluZy10aGUtY2lwLWNvcmUtaW1hZ2UiIGluIHRoZSByZWFkbWUgZm9yIEJCQiwgd2hp
Y2ggbWVhbnMgd2UgaGF2ZSB0byBjcmVhdGUgdHdvIGltYWdlcyAoTm9uLVJUIGFuZCBSVCkgYXMg
cGVyIHRoZSBzZWN0aW9uLiAgDQoNCkkgd2lsbCBjbGVhcmx5IG1lbnRpb24gaW4gQkJCIHNlY3Rp
b24gdG8gY3JlYXRlIHR3byBpbWFnZXMuICANCg0KVGhhbmtzICYgUmVnYXJkcw0KU2hpdmFuYW5k
IEsNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9m
IEphbiBLaXN6a2ENClNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAyMCwgMjAyMiAzOjQ2IFBNDQpU
bzoga3VuaWphZGFyIHNoaXZhbmFuZCjvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxT
aGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEtdHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZw0KQ2M6IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRp
bmcpIDxkaW5lc2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6X
IOWSjOWujyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpIDxrYXp1aGlybzMuaGF5YXNoaUB0b3No
aWJhLmNvLmpwPg0KU3ViamVjdDogUmU6IFtjaXAtZGV2XSBbaXNhci1jaXAtY29yZSB2Ml0gUkVB
RE1FLnN3dXBkYXRlLm1kOiBBZGQgc3RlcHMgdG8gdmVyaWZ5IFNXVXBkYXRlIG9uIEJCQg0KDQpP
biAxNi4wOS4yMiAxMzo0MywgU2hpdmFuYW5kLkt1bmlqYWRhckB0b3NoaWJhLXRzaXAuY29tIHdy
b3RlOg0KPiBGcm9tOiBTaGl2YW5hbmQgS3VuaWphZGFyIDxTaGl2YW5hbmQuS3VuaWphZGFyQHRv
c2hpYmEtdHNpcC5jb20+DQo+IA0KPiBNb3N0IG9mIHRoZSBzdGVwcyBhcmUgc2ltaWxhciBmb3Ig
Ym90aCBxZW11LWFtZDY0IGFuZCBCQkIgdGFyZ2V0cy4NCj4gQWRkIHJlZmVyZW5jZSBsaW5rIHdo
ZXJldmVyIHJlcXVpcmVkIGluc3RlYWQgb2YgcmVwZWF0aW5nIHN0ZXBzLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogU2hpdmFuYW5kIEt1bmlqYWRhciANCj4gPFNoaXZhbmFuZC5LdW5pamFkYXJAdG9z
aGliYS10c2lwLmNvbT4NCj4gLS0tDQo+ICBkb2MvUkVBRE1FLnN3dXBkYXRlLm1kIHwgMjUgKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kb2MvUkVBRE1FLnN3dXBkYXRlLm1kIGIvZG9jL1JFQURN
RS5zd3VwZGF0ZS5tZCBpbmRleCANCj4gMWIyNDJhMi4uOWJlMzQ5OCAxMDA2NDQNCj4gLS0tIGEv
ZG9jL1JFQURNRS5zd3VwZGF0ZS5tZA0KPiArKysgYi9kb2MvUkVBRE1FLnN3dXBkYXRlLm1kDQo+
IEBAIC0zMiw2ICszMiw4IEBAIENvcHkgDQo+IGBjaXAtY29yZS1pbWFnZS1jaXAtY29yZS1idWxs
c2V5ZS1xZW11LWFtZDY0LnN3dWAgZmlsZSBmcm9tIGB0bXBgIGZvbGRlciBpbiAgaG9zdCQgc2Nw
IC1QIDIyMjIyIC90bXAvY2lwLWNvcmUtaW1hZ2UtY2lwLWNvcmUtYnVsbHNleWUtcWVtdS1hbWQ2
NC5zd3Ugcm9vdEBsb2NhbGhvc3Q6DQo+ICBgYGANCj4gIA0KPiArIyMgU1dVcGRhdGUgdmVyaWZp
Y2F0aW9uDQo+ICsNCj4gIENoZWNrIHdoaWNoIHBhcnRpdGlvbiBpcyBib290ZWQsIGUuZy4gd2l0
aCBsc2JsazoNCj4gIGBgYA0KPiAgcm9vdEBkZW1vOn4jIGxzYmxrDQo+IEBAIC0yMTUsMyArMjE3
LDI2IEBAIHVzZXIgdmFyaWFibGVzOg0KPiAgDQo+ICANCj4gIGBgYA0KPiArDQo+ICsjIEJ1aWxk
aW5nIGFuZCB0ZXN0aW5nIHRoZSBDSVAgQ29yZSBpbWFnZSBmb3IgQkJCDQo+ICsNCj4gK0ZvbGxv
dyB0aGUgc3RlcHMgbWVudGlvbmVkIGluIHRoZSBzZWN0aW9uIFtCdWlsZGluZyBhbmQgdGVzdGlu
ZyB0aGUgQ0lQIENvcmUgaW1hZ2VdKFJFQURNRS5zd3VwZGF0ZS5tZCNidWlsZGluZy1hbmQtdGVz
dGluZy10aGUtY2lwLWNvcmUtaW1hZ2UpIGZvciBjcmVhdGluZyBpbWFnZXMgYW5kIC5zd3UgZmls
ZXMuDQo+ICstIFJlcGxhY2UgcWVtdS1hbWQ2NC55bWwga2FzIGZpbGUgd2l0aCBCQkIgYm9hcmQg
c3BlY2lmaWMgZmlsZSBpLmUgDQo+ICtiYmIueW1sDQo+ICstIC5zd3UgZmlsZSB3aWxsIGJlIGdl
bmVyYXRlZCBpbiB0aGUgZm9sbG93aW5nIGZvbGRlciANCj4gK2J1aWxkL3RtcC9kZXBsb3kvaW1h
Z2VzL2JiYi8NCj4gKw0KPiArRmxhc2ggdGhlIEJlYWdsZUJvbmUgQmxhY2sgaW1hZ2UgaW50byBT
RGNhcmQgYGBgIGhvc3QkIGRkIA0KPiAraWY9YnVpbGQvdG1wL2RlcGxveS9pbWFnZXMvYmJiL2Np
cC1jb3JlLWltYWdlLWNpcC1jb3JlLWJ1bGxzZXllLWJiYi53aWMgXA0KPiArICAgb2Y9L2Rldi88
bWVkaXVtLWRldmljZT4gYnM9MU0gc3RhdHVzPXByb2dyZXNzIGBgYA0KPiArDQo+ICtBZnRlciBm
bGFzaGluZyB0aGUgQkJCIGltYWdlIGludG8gU0QgY2FyZCwgbW91bnQgdGhlIFNEIGNhcmQgb24g
aG9zdCBQQyBhbmQgY29weSAuc3d1IGZpbGUgZGlyZWN0bHkgdG8gcm9vdCBwYXJ0aXRpb24gbGlr
ZSBiZWxvdy4NCg0KVGhpcyBpcyBtaXNzaW5nIGEgc3RlcDogQnVpbGQgYSBkaWZmZXJlbnQgaW1h
Z2UgY29uZmlndXJhdGlvbiwgZS5nLg0Kc3dpdGNoaW5nIHRvIHRoZSBSVCBrZXJuZWwuIE90aGVy
d2lzZSwgeW91IGFyZSBub3cgc3VnZ2VzdGluZyB0byBmbGFzaCB0aGUgc2FtZSBTV1Ugb24gdGhl
IGRpc2sgYXMgeW91IHdyaXRlIGFzIGZ1bGwgaW1hZ2UsIGFuZCB3ZSBrbm93IHRoYXQgdGhpcyBp
cyBicm9rZW4gKHBsdXMgd2UgaGF2ZSBubyBlcnJvciBkZXRlY3Rpb24gZm9yIHRoYXQgeWV0KS4N
Cg0KSmFuDQoNCj4gKw0KPiArYGBgDQo+ICtob3N0JCBzdWRvIGNwIHRtcC9jaXAtY29yZS1pbWFn
ZS1jaXAtY29yZS1idWxsc2V5ZS1iYmIuc3d1IA0KPiArLzxtbnQ+L2hvbWUvcm9vdC8gYGBgDQo+
ICsNCj4gK0Nvbm5lY3QgYSBzZXJpYWwgcG9ydCBjYWJsZSBiZXR3ZWVuIGhvc3QgUEMgYW5kIEJC
Qi4NCj4gK0luc2VydCBTRCBjYXJkIHRvIEJCQiwgaG9sZCBTMiBidXR0b24gd2hpbGUgYXBwbHlp
bmcgcG93ZXIgc3VwcGx5IHRvIEJCQi4NCj4gKw0KPiArRm9yIHZlcmlmeWluZyBzd3VwZGF0ZSBv
biBCQkIgdXNlIHRoZSBzYW1lIHN0ZXBzIGFzIG1lbnRpb25lZCBpbiBhYm92ZSBbU1dVcGRhdGUg
VmVyaWZpY2F0aW9uXShSRUFETUUuc3d1cGRhdGUubWQjc3d1cGRhdGUtdmVyaWZpY2F0aW9uKS4N
Cg0KLS0NClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkNvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVk
IExpbnV4DQoNCg==


