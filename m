Return-Path: <SRS0=6fXh=KF=lists.cip-project.org=bounce+64572+6438+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F07DC433ED
	for <cip-dev@archiver.kernel.org>; Mon, 10 May 2021 00:17:05 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7FB610CC
	for <cip-dev@archiver.kernel.org>; Mon, 10 May 2021 00:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7FB610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6438+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LVCoYY4521723xiHuwQ0x5Dr; Sun, 09 May 2021 17:17:03 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web12.25813.1620605821011223937
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 May 2021 17:17:02 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 14A0GwsP031691; Mon, 10 May 2021 09:16:59 +0900
X-Iguazu-Qid: 34trtbUtX9BdvjOyKI
X-Iguazu-QSIG: v=2; s=0; t=1620605818; q=34trtbUtX9BdvjOyKI; m=3pMyGZc5zS2ZyKuHWIXSzsrPeYzr7xTg4aSdDb0xdfA=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1511) id 14A0Gvfx011948
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 May 2021 09:16:58 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id B068B1000C3;
	Mon, 10 May 2021 09:16:57 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 14A0Gv4r025175;
	Mon, 10 May 2021 09:16:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkBd6kdlfXvKmzTnEEKbPmkR2GA3QngSsOQV7r+nWv0XirPt3kqg8zLPmkuZYyOiwpuyI6UX10zNKrlUtMfcTdnZLT/B5VA0u8Dv49IEbZ5XDjNGeY4WOzM6WNgHOp6LqKo2IDTcSe270C8gUpn33mVAsaA3Nq0ggdFerpIRqPwj0IHOmJg34Ki4A3vwq0yGEy2/a+m1H2t6OQRCVv0EKUsfzkkuRHs2Bwkx4WhBepmLt03uTPH/dJSSt+2iKtJ2fJ0juBT+Lf9hNAP5W5U8aoXeWznzg+bUzPhHgRHh+gzcl55JbmMGO4QJiSOys5R76IdHIatR4JEaHRkWt/mgfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlQ0rtsCYQKRpuvHJ6Q1RVC7eGy8p9Wuw0jB21ZZVzg=;
 b=LW+UHr0Gyf+K5tTnhsd3CHC9MGSp0Q4i9X+PhAhvK6AGD7eWhAzVxp5HGlFJN1ZuzWHlPxLhupCGnVTYzZ2/Q2fNoskhLmEDmhRJpu9OF5M+HM2YjLC1NH2aTGKWHChmVhYcmSUFOrdvQahGE4KgdjbSM8O/VW7KuB7homJxIdIcBj3i8aT6ZJQIqyqDWgimh/44L94ZPWjr9TGVRSvZwf0Tt/rQZjC2aqq59ksvN9ci5XmIyOfs/a3NSMW9OF+l6/A5r3hLuYqc+KQdM8aSboAzSJZ2R5D+qMY+T32HT4Hxlc5b8//tssLwpOpgYAS1Mr2v8eXkdJ+7TG6sQLxstA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [PATCH 2/2] [isar-cip-core] Add support qemu-arm
Thread-Topic: [PATCH 2/2] [isar-cip-core] Add support qemu-arm
Thread-Index: AQHXLB+DpuHlJPckeEudNc6i3iFepqrLOSgAgBDRk1A=
Date: Mon, 10 May 2021 00:16:53 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB625272D8CC851D6933BA9FFF92549@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20210408023230.388313-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210408023230.388313-2-nobuhiro1.iwamatsu@toshiba.co.jp>
 <80a1ebd0-9938-7bd5-2bee-90d0b3b67349@siemens.com>
In-Reply-To: <80a1ebd0-9938-7bd5-2bee-90d0b3b67349@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09ce4ce1-aa6f-456a-1ba2-08d91348ea46
x-ms-traffictypediagnostic: TYAPR01MB2990:
x-microsoft-antispam-prvs: <TYAPR01MB2990BD6CB511D3E9322511C892549@TYAPR01MB2990.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +xsUMSU0lxU+ZMNJ+sson4JuROxRopP9xX8YRl/QtaY/iQ78qQJzBKXvXsYgEY7x9uZGigfzK7SOGrbVYYZIqamOAN1kvNYDmvxsR87frk1GR1C0sGgbz/I2eWbwMteRAU/VQ8nJ6L7d0d3wFvwlL/qvV430InHmkR+YRjN8LwryFi0YcKkA1YhuhbUu2m5OIlqBlb0jG1+RCrNtsmM+svyU2wKLqlLdYftXSSgmK4+vt65r1L9iQPScpnIAoa/engBxMWiYc7fIDkag995UYzyfh0jam2ZlMLBy8R1GOa+tPee5HdguE1qQrsw1YR+Me04q2DfeuZm2QCTn5RZWe+JlymjWUHPf+pokZbUITK0PjXaf2J/UaDnWskmnhICOltFxyTEvoXS6ABj+Al37N6c97ugFh27JrEMKWlGxlucIiCBcXfiGn9A1Z3Trj7L72GjC06n9F32GN+PO2yPZ2i5d4npGu4zhf3aqrM4/IEGBP5dw4HROXNQK5XlkQKATrfF09+n+URIJiNp2Ay/pvDZFRwvCo0zE5mikziQn1QNvmSCGYVSdZbvVvLr/NLK9iFVooZs/LqNsnvIzAy/S/6xQF/hepuvKJtPoBe5oCkNjHY7fmactSYUZ+B1Hjujrn7UenJ5+duJkMghnQDmkMBcDhsdtKOePmgrDyVaHViU=
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZlpCTHZtbmloNzhJU1FpNXU3Ui81djBBNldkYks3d0FoNS85bVQ3ZHo2cDY3?=
 =?utf-8?B?SmdaaHF1eXA3OS9CeVRhcU1DSEo2ZHcySmFSSDhTSUM1S1FFSERscmJUbmNO?=
 =?utf-8?B?eHArM3ZMYnZtQUs3bllnWVFDa1IyMXZxeE9yVzRuek1xU29uRFVFKzNYeURa?=
 =?utf-8?B?SHJSVkhDcnRXVnIxanJzQ2FCbklRd1ZxOEFRS0E5dkIybGZRYXVaWGlSMWNx?=
 =?utf-8?B?V1I5aE9QSk5ha3k4Z2tHaElzV0M4eEN3QytGWjJMclNFaHJKZlZCVVNlenZS?=
 =?utf-8?B?WGllNHJXSkcySlg5dC8vYmZxZytvcGJ2aGNWWUpxRUJoUlNKeXpFLzRIdlZp?=
 =?utf-8?B?Tk1FNHBJU3ZQNTZXbjJJNTF0YXM4RXkzQkdUYkVHQ1hkb0hJQjMvTHRncG9p?=
 =?utf-8?B?YjFBRnhYTUVTOTNRNHhKbEJtOUQ5d21SMmdIc25VWVdwa3lDSDJIYTVvdkFL?=
 =?utf-8?B?UXhrS3BMYXJrdDFGOVhURzM0R3ZQZ2xuSHVlaEN5L2p2bG5WeWE2Y1IwZTZV?=
 =?utf-8?B?U1JsUy9qUnQ4QUw3cUFrWExhRU43eCtkc2dxaDJ1aVgvZjRyOWZYYk12Y25r?=
 =?utf-8?B?aWtJVGw0Q2t4TkVJY05INWd0MG9ZTGVFU1U2bXRIZWdYVFlCSFYxOE1hSFRx?=
 =?utf-8?B?SnVpczI1YzRFUHVNV2xzWHhTM2xYZXRmVytnU1g0TWwrZFBLQnlKYzBvY2tr?=
 =?utf-8?B?aGxxRlhmS0FwNExtWXd5Mzh2OG1pQjdreUZLcE9SREpSZUpSTXpXTGJXR1do?=
 =?utf-8?B?VXlWSUE0d3M0L2xvMnltcFZyZXk4NVhsd3BwRkk5WTNEZks2ZnBVTW9WODhH?=
 =?utf-8?B?d0lSSXdic3k1UU5OSHZnVEJUYWpSVENxNStSR3FNczZrU1ppcEpHdVV3NlZB?=
 =?utf-8?B?MEJnWC9JaXJNTUJzKzg3SmdTYUtERXJkdDJEVXh2TVppeEJHaHErRldWcTRK?=
 =?utf-8?B?b1puSWZuL3d2YW40Vnl1RVFod3U0R3J1K3hhcVJNTlZMTXFPWnVUVFlLR1dh?=
 =?utf-8?B?SVRaZ1d4S0ZaamVKZnFtYTBmTUdTOGM4R0lpRm9DakJlMEdVYVVBdjdETTJV?=
 =?utf-8?B?S3lwbFZHeVhRZmdKVmYrZjh5ZGFTQzE2disySXkycHZoVlZpYlc2eFlXbkIx?=
 =?utf-8?B?VlZoMkU2K2tacCs3WE1TM0dRNTh5S0ZFa01RdmdrSWEvMU5WeEFDc2IxTll6?=
 =?utf-8?B?dXVITy9oWjRoLzNoaVFpc1hiN3g3bnV4N0dzc2xaTmlnTTdZVm5oY3RyYzlF?=
 =?utf-8?B?MGRDU0dETzNGRDJDZloxMDNJTU1Gd1cxQzUyanA5aWc5cW1LWUhMR21pdVds?=
 =?utf-8?B?K0U0MXdXN1dnWU5tTERxQ3hySk5vT2ZvVkVySXpmb3h6LzhGL0tFQzMvTHAz?=
 =?utf-8?B?RzRXRzJqdnZpZTZ5NTRzSlM1S0N3TWs4OVhJd2svNlg3SXRrZ3AwQy9HbUxG?=
 =?utf-8?B?WmhucGswcnloSDE1ZHdKQVdLMEE3c0p6UFB2akZNNUxTY0xtM3NJSEMwZ3VQ?=
 =?utf-8?B?d2EvRExMSnJuWXgydzBKU09aMTFuREsyZFc3Q1FiT0U2RmJleCtKRXNPOU9l?=
 =?utf-8?B?TDhiY1hOVWU3OWZCUHJFdjJ3SS91RTVjV3ExRlVRRklhMFFjSWc2bW9yUS9L?=
 =?utf-8?B?MGJqZEo3L2pIMnVKS1ZVemhURzVKOUVpTGM1TE51T2hqaFdRZDZUdDVWMnha?=
 =?utf-8?B?bDBEc2tUUThUM2p3Um1nR0xxcWsvOE1zVzByZmFjVnVsYkliZlNPaDNRcEZF?=
 =?utf-8?Q?Br/Ffp2jN8pXtuX6IU=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ce4ce1-aa6f-456a-1ba2-08d91348ea46
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 00:16:53.8243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oPHvG6Fi1SoXWDj97vjgB6WjDXuh3JP6oMyA/aCMVmOhri0JogE7nGIRjgf4F6VQ2S++gk9mx/tMaHY8OFSRZUWaleqrseELjLqXox0KXqErKwN7vzOzf6Wfxzh/iQ4g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2990
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5o6LvaM5uPABCWlHR1q6NxjNx4520388AA=
Content-Type: multipart/mixed; boundary="vQvxJOb91IsyKcFTmoDL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620605823;
 bh=j9va5j9py8eGiCxUgZfKKIcFQqvJeuMkYusgNDDcW8A=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=jdfki9NIfnSMpN30k7/+LK9/hg487AOS2F1QVEW/6eeWqxk2VBhBqYNUWJ2jObrRRcD
 iH3c83tl8iJMzDB5toA3l64FvCS/Btn9XGmpw83EnxrwPfSrygn0lVNITV41swTrlNZTj
 elvtzd1y/279aJ6y46LQDk2H+KseN3IzjTA=

--vQvxJOb91IsyKcFTmoDL
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6
a2EgW21haWx0bzpqYW4ua2lzemthQHNpZW1lbnMuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgQXBy
aWwgMjksIDIwMjEgNDoyNSBQTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0
iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5j
by5qcD4NCj4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggMi8yXSBbaXNhci1jaXAtY29yZV0gQWRkIHN1cHBvcnQgcWVtdS1hcm0NCj4gDQo+
IE9uIDA4LjA0LjIxIDA0OjMyLCBOb2J1aGlybyBJd2FtYXRzdSB3cm90ZToNCj4gPiBUaGlzIGFk
ZHMgY29uZmlndXJhdGlvbiBmaWxlcyB0byBzdXBwb3J0IFFFTVUvYXJtLg0KPiA+IFRoaXMgaXMg
aW50ZW5kZWQgdG8gYmUgdXNlZCBmb3IgYSB0ZXN0IGltYWdlIG9mIExBVkEgb2YgQ0lQLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJvMS5pd2FtYXRz
dUB0b3NoaWJhLmNvLmpwPg0KPiA+IC0tLQ0KPiA+ICAuZ2l0bGFiLWNpLnltbCAgICAgICAgICAg
ICB8IDE5ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgY29uZi9tYWNoaW5lL3FlbXUtYXJtLmNv
bmYgfCAxNCArKysrKysrKysrKysrKw0KPiA+ICBrYXMvYm9hcmQvcWVtdS1hcm0ueW1sICAgICB8
IDE2ICsrKysrKysrKysrKysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA0OSBpbnNlcnRpb25z
KCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBjb25mL21hY2hpbmUvcWVtdS1hcm0uY29uZg0K
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQga2FzL2JvYXJkL3FlbXUtYXJtLnltbA0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhLy5naXRsYWItY2kueW1sIGIvLmdpdGxhYi1jaS55bWwNCj4gPiBpbmRleCAw
MWQ5NjA5Li5iNTNkOWNjIDEwMDY0NA0KPiA+IC0tLSBhLy5naXRsYWItY2kueW1sDQo+ID4gKysr
IGIvLmdpdGxhYi1jaS55bWwNCj4gPiBAQCAtODQsNiArODQsMTYgQEAgYnVpbGQ6cWVtdS1hcm02
NC1iYXNlOg0KPiA+ICAgICAgd2ljX3Rhcmd6OiBkaXNhYmxlDQo+ID4gICAgICB0YXJnejogZW5h
YmxlDQo+ID4NCj4gPiArYnVpbGQ6cWVtdS1hcm0tYmFzZToNCj4gPiArICBleHRlbmRzOg0KPiA+
ICsgICAgLSAuYnVpbGRfYmFzZQ0KPiA+ICsgIHZhcmlhYmxlczoNCj4gPiArICAgIHRhcmdldDog
cWVtdS1hcm0NCj4gPiArICAgIGV4dGVudGlvbjogc2VjdXJpdHkNCj4gPiArICAgIHVzZV9ydDog
ZGlzYWJsZQ0KPiA+ICsgICAgd2ljX3Rhcmd6OiBkaXNhYmxlDQo+ID4gKyAgICB0YXJnejogZW5h
YmxlDQo+ID4gKw0KPiA+ICAjIHRlc3QNCj4gPiAgYnVpbGQ6c2ltYXRpYy1pcGMyMjdlLXRlc3Q6
DQo+ID4gICAgZXh0ZW5kczoNCj4gPiBAQCAtMTI0LDMgKzEzNCwxMiBAQCBidWlsZDpxZW11LWFy
bTY0LXRlc3Q6DQo+ID4gICAgICBleHRlbnRpb246IHRlc3QNCj4gPiAgICAgIHdpY190YXJnejog
ZGlzYWJsZQ0KPiA+ICAgICAgdGFyZ3o6IGVuYWJsZQ0KPiA+ICsNCj4gPiArYnVpbGQ6cWVtdS1h
cm0tdGVzdDoNCj4gPiArICBleHRlbmRzOg0KPiA+ICsgICAgLSAuYnVpbGRfYmFzZQ0KPiA+ICsg
IHZhcmlhYmxlczoNCj4gPiArICAgIHRhcmdldDogIHFlbXUtYXJtDQo+ID4gKyAgICBleHRlbnRp
b246IHRlc3QNCj4gPiArICAgIHdpY190YXJnejogZGlzYWJsZQ0KPiA+ICsgICAgdGFyZ3o6IGVu
YWJsZQ0KPiA+IGRpZmYgLS1naXQgYS9jb25mL21hY2hpbmUvcWVtdS1hcm0uY29uZiBiL2NvbmYv
bWFjaGluZS9xZW11LWFybS5jb25mDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRl
eCAwMDAwMDAwLi44MWEyMmMxDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2NvbmYvbWFj
aGluZS9xZW11LWFybS5jb25mDQo+ID4gQEAgLTAsMCArMSwxNCBAQA0KPiA+ICsjDQo+ID4gKyMg
Q0lQIENvcmUsIGdlbmVyaWMgcHJvZmlsZQ0KPiA+ICsjDQo+ID4gKyMgQ29weXJpZ2h0IChjKSBT
aWVtZW5zIEFHLCAyMDE5DQo+ID4gKyMgQ29weXJpZ2h0IChjKSBUT1NISUJBIENPUlBPUkFUSU9O
LCAyMDIxDQo+ID4gKyMNCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTUlUDQo+ID4g
KyMNCj4gPiArDQo+ID4gK0RJU1RST19BUkNIID0gImFybWhmIg0KPiA+ICsNCj4gPiArSU1BR0Vf
VFlQRSA/PSAiZXh0NC1pbWciDQo+ID4gK1VTRV9DSVBfS0VSTkVMX0NPTkZJRyA9ICIxIg0KPiA+
ICtLRVJORUxfREVGQ09ORklHID89ICJjaXAta2VybmVsLWNvbmZpZy80LjE5LnktY2lwL2FybS9x
ZW11X2FybV9kZWZjb25maWciDQo+ID4gZGlmZiAtLWdpdCBhL2thcy9ib2FyZC9xZW11LWFybS55
bWwgYi9rYXMvYm9hcmQvcWVtdS1hcm0ueW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
PiBpbmRleCAwMDAwMDAwLi45YmY5NzI4DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2th
cy9ib2FyZC9xZW11LWFybS55bWwNCj4gPiBAQCAtMCwwICsxLDE2IEBADQo+ID4gKyMNCj4gPiAr
IyBDSVAgQ29yZSwgZ2VuZXJpYyBwcm9maWxlDQo+ID4gKyMNCj4gPiArIyBDb3B5cmlnaHQgKGMp
IFNpZW1lbnMgQUcsIDIwMTkNCj4gPiArIyBDb3B5cmlnaHQgKGMpIFRPU0hJQkEgQ09SUE9SQVRJ
T04sIDIwMjENCj4gPiArIw0KPiA+ICsjIEF1dGhvcnM6DQo+ID4gKyMgIE5vYnVoaXJvIEl3YW1h
dHN1IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gPiArIw0KPiA+ICsjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBNSVQNCj4gPiArIw0KPiA+ICsNCj4gPiAraGVhZGVyOg0K
PiA+ICsgIHZlcnNpb246IDEwDQo+ID4gKw0KPiA+ICttYWNoaW5lOiBxZW11LWFybQ0KPiA+DQo+
IA0KPiBJdCBsb29rcyB0byBtZSB3ZSBoYXZlIHNvbWUgcmVncmVzc2lvbnMgaW4gbWFzdGVyICh3
aGljaCBkb2VzDQo+IGRlcGxveW1lbnQpLCBjYXVzZWQgYnkgdGhlc2UgY29tbWl0cy4gQ291bGQg
eW91IGhhdmUgYSBsb29rIGF0DQo+IA0KPiBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3Qv
Y2lwLWNvcmUvaXNhci1jaXAtY29yZS8tL3BpcGVsaW5lcy8yOTQyMDMyNzINCj4gDQoNCk9LLCB0
aGlzIGlzIGEgaXNzdWUgd2hlbiB1cGxvYWRpbmcgYSBidWlsdCBpbWFnZS4gSSBoYXZlIG5vdCBs
b29rZWQgaW50byANClRoZSBmZWF0dXRlIGluIGRldGFpbC4gSSB3aWxsIGZpeCB0aGlzLg0KDQo+
IFRJQSwNCj4gSmFuDQo+IA0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=

--vQvxJOb91IsyKcFTmoDL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6438): https://lists.cip-project.org/g/cip-dev/message=
/6438
Mute This Topic: https://lists.cip-project.org/mt/81933310/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--vQvxJOb91IsyKcFTmoDL--
