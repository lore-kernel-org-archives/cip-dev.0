Return-Path: <SRS0=Qz0f=OC=lists.cip-project.org=bounce+64572+6726+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0856C433EF
	for <cip-dev@archiver.kernel.org>; Sun, 12 Sep 2021 21:48:39 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0511A61056
	for <cip-dev@archiver.kernel.org>; Sun, 12 Sep 2021 21:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0511A61056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hmwYYY4521723xea0zOO19op; Sun, 12 Sep 2021 14:48:38 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web08.21246.1631483316198739216
 for <cip-dev@lists.cip-project.org>;
 Sun, 12 Sep 2021 14:48:37 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 18CLmH33011596; Mon, 13 Sep 2021 06:48:17 +0900
X-Iguazu-Qid: 34trVrK16Popyv9xR2
X-Iguazu-QSIG: v=2; s=0; t=1631483297; q=34trVrK16Popyv9xR2; m=XZW+VwfHGqj3v/eDTQ2IQdkcCG6HjWyNFA0ps4YE+xo=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1513) id 18CLmEid021981
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 13 Sep 2021 06:48:15 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id E7A171000ED;
	Mon, 13 Sep 2021 06:48:14 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 18CLmEFf030165;
	Mon, 13 Sep 2021 06:48:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Au4ggnvImDwHmR0ieMYxsSz70KTAaWWAZcb0gLf9Np7jooNrGHYPrtkl7zV5BuVkZSKg1l0RE7XzRHgr6yInZuBINrz2vlyBpIAClyU5+MDemfEDBiNZOTQRXgU03F5VIK43MHwub0e3cur+bUvXFRp6NkgtXFZAfC+XXgNBPL0RsJIurIKTuOl7S0MdyHRru9TKZ6JJJpMFyIo8g4M/zqjGMtTkd7yxzzMTxBS6FHtUq+eqMvt9oGRrZ5W1WDcAWTmaCIOAJ06grd4sbhGw1yVbdDSYvKkLWpnva+JEnMxEJDun91Ow15bqqHIfAk6ivmvY+XcOJh8guF25LQrg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TggpeYdZDpszHxXChVredCYiKbxEKcemrs4ZXXQULCE=;
 b=n3LrjaPEZJiv7jCWuk26KkSxuTRpzcS6GkXsjScdzpB5JOareZPTkiaVp3EsyqYPSLWrhZ0dYVVmTryoNf6CnWMN06lY1bKkWuut6414fMZwNCT6TS1MUK2o6Usgd+hFUd+3Vx6X9/hBjo1BOkASj+sz2sXuum98YSN3fTWf782mcnaafQz7uQHJUE57x9gYPwO9BaoszteBcvUAW8DYcHQctm2p2qNnz+OY4omurPNaOqLW8YVlFh0CQpR6mHHUm1UrtUYWy5X6TmPb4sEu+FLFTKc3ruNPRbMICXsf4UgoQsKkPXDVO33Yvtu+jgJNr5WmMLcx5EfrMlBh7meJcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@ucw.cz>
CC: <cip-dev@lists.cip-project.org>, <pavel@denx.de>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>,
        <uli@fpond.eu>, <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.206-cip57 and v4.4.283-cip62
Thread-Topic: [ANNOUNCE] Release v4.19.206-cip57 and v4.4.283-cip62
Thread-Index: AdenowjUUMCvGEfISJyQcrSeNDSKOQAI7roAABYxwEA=
Date: Sun, 12 Sep 2021 21:47:50 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB6252BD546FD3F1FAAC1C15F592D89@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <TYAPR01MB6252E924DEBEBBABA184CDE492D89@TYAPR01MB6252.jpnprd01.prod.outlook.com>
 <20210912111015.GA26423@amd>
In-Reply-To: <20210912111015.GA26423@amd>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94f7fd9b-bef0-42c8-120a-08d97636f7ff
x-ms-traffictypediagnostic: TYCPR01MB6913:
x-microsoft-antispam-prvs: <TYCPR01MB6913C59BFB0FBBA419C55D4C92D89@TYCPR01MB6913.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: wHBr79VGbD76tNcdMVFE77/G1GdsP0BNmvpnnCzTL9P1/mC0LLv8IfYIj04A+CwOmR0zm+a/nXpOJVTyg1DhtyVZhBCF3rM2NwfNUTO9gjivA+D06sB88CGNiyDPVcbudXRmLbtLBslfdJ+qooOMN6nsId0S2ersqXo4xReYdFqG24dstZaOdENF3Vmm/Fjh1dzOTzXIDDB7mLke1QB8Kf34uzAxacQdykLJhD9fCovd6sg3likM/+o30XNhP2d1p+lQAU7oWpetyZqAohBrPdyHwrQ4ntToxyY0dsH14pDrvWGdYHB4XeiK1OVQ718wjT0VoXrkbBovy5kQRFiVaP74Fxl38uVqz1+1uRh5ndc62YPDOu01E2pE758ulqVzZ3MVEAx5/hZ/2ZJdgCPq6P6yX6I0XSyaFgLB2ZDDGdkGupvyutlwtteheK1p+6L0kwqY1gDKpALHy14XDRUPfpk8nr1EUQs3Qn/6yWWt8mh4q3SvysqmsGur4BCRqGbvrcqtuc5eFU4MIByO7a0pFl9vsbLr4kVKMLcpyG+1Me3/fTNYSHO/Q9WSiPvXWvG8y8nv7EQlqQuQA1aVS73mBWZpv7++XaXfFcrnxZGLsp6DMXaVGcqIKRrcHRd/GY28UdUKI+I3+85HAjMPONwAt6QiYvRqCtbp0XRpUnTXudpCMtQq/y2pzx5hLyswbyLlocu5RNBWkbGpENCbtAKV49BbXqrVr1VfNL7ZBxQ2XKWvTApNaDfdtff2L51KZeuY++edkPPDAJ6F5Z4XAdK9YsmKI3MyDPa98Eo3wzwJHSw=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1luRU05MTdodFVkOGoxUExjbWgrb25KTXcxZmFnaDVEQWh0U3ByaGIvekdW?=
 =?utf-8?B?UnhGV3NvZHZmN2FpKzVSbVdpT0orcm4rRkllZERVMU0zWkVDVnVnalRVajRy?=
 =?utf-8?B?bDZsTHpUVnlJOCtVU0ZqMFdFbUlzbUdtWm5kOFpjV0NPWkk2RnpjM2ljdkhU?=
 =?utf-8?B?bU5LUVlmWWdoMUJVVWVibzZnSUdMTE91OHIxQnZYK1hGUTJPOVhaMDF4c3E4?=
 =?utf-8?B?RnYrRW41TDRCQlQzTmliSW9pMTI5MzZPeU13WklubmNubkc4RkNFcGZUUk9V?=
 =?utf-8?B?ZVJJWm5GMiswTGJ1QUVrTi9tbEU5dGdhTHAxV2Ixb2V4ODVPVzkxTEU3eElN?=
 =?utf-8?B?NmdrWXFxMm5GdnJ6NW5sOUxJVEp1MWRqQ3BDMHpaVlV6eWF0M2xGdVgrajE0?=
 =?utf-8?B?N2llcFgrbllwRndrT08razhPb290RW14b1l1ekIyU3NYWWlTOE4yNExYcUxV?=
 =?utf-8?B?U0taVm55eHFRUUsxNFBPOHF0VjlNYmRtUFZxaWtSZkI3WG44bElwQkRnTisr?=
 =?utf-8?B?U1Q3K1ZKNkFZZUdBOUhIV2lWaTJYY2dtc1ZHNDl4OXZwZjFwVmtwMTg2bDF6?=
 =?utf-8?B?WXQ5L1hUdlFNNzBlYzVmQzZhV1loajBxRUwvYi9MTk80bm5QRStUNE5DdXl4?=
 =?utf-8?B?bGJVdHdPRXBMdHIwcHFoZExJQ2g0ak9GTzJoZlpaN3VZVXhPUXRaTndpdkFu?=
 =?utf-8?B?RHFGL0x3cmU4U1JOMU1LcU1rbGJNTlpxRzFZY2g1ckpXb2cvMVR4YWladlNQ?=
 =?utf-8?B?RnJRTU1vZU0zQ21LREY1YnhNc1VucCtoVEdqUDNEdUcxTVVUQkNtOWM0MTZ6?=
 =?utf-8?B?VWVlUkpPclpsZlR6S2d3cFM3NWNjbXNqdG9OUWVlNzZTY0loUW9FRC8yLzFi?=
 =?utf-8?B?Y1F3dnZUVU9TMUxpOTQ5b05icjRnb1Q2ZVhSU2VkNEJIN1NoTkNqVHFYTzcx?=
 =?utf-8?B?ZVFUVURRd1djWnFNcitCa051OXMzaVBkUkNJMEN0R0ZTelNjeVpaVmczSzdx?=
 =?utf-8?B?MkovTk9xL3BGK2FJakgydVBsYUhmbU9VN2dyWFdRVVFxZ0FCMUFMWHJReGcx?=
 =?utf-8?B?bGJ1TDVKemlOZm9yRFBWb1pTZXRjL09IclVydDRaOU9ObjBaTzJOaCt3ZXNK?=
 =?utf-8?B?YVpvTjBVY0Jnd09pbjNMaWNZd2cwTTArRGF1T3lPTXJPRmRPQ2cwYWdvalhL?=
 =?utf-8?B?QTlOa0NVaWFWem5aek5ZRlVKRXhjYWE5ZEZUOGxHNXRnWDNtVFZ2cmVnVTFK?=
 =?utf-8?B?YW5vQkgzVDB1emZLM0NaOVpJTXVPTUU3c21KaXZsRXlDZW1GUU9YMGV3VzRH?=
 =?utf-8?B?ZTlyM0hxaS9PZ2t3WVl2MXJSMGM3cG10NGkydEtNMTZTTkFIaml5aXQ5Zkx0?=
 =?utf-8?B?bFl3S1pvSWpTaTgzYnd2VXM2N2taWnRUREhHeldyK29URTdBSmZLb3FUeDVy?=
 =?utf-8?B?YXFhdnE3MUIzUzBUY1g5bHMrdVNpbTM0ZVRObGFxMFFTRVBadU5VUFJBN0Qx?=
 =?utf-8?B?YTJ1dkFSMjY5N1BMeGpXWU9sZDdMQ1cyRENtTXp3NERSblZXUmZVbTE3cG1w?=
 =?utf-8?B?azgyU08wQ1M4djlKMHhlZGlaaXVxUXp5anB3THpneUx4Zy9MTWtSbW8xaGxI?=
 =?utf-8?B?YVE3eUJTYnZYMllaNjByWjRxQ0Y2SWl3NStNVyttNXZQOUVXSXZ1VlVpYnFR?=
 =?utf-8?B?Z3BnbExLVk5mMEx0S2puSTZXR1ZVcXJtV2lCT3ZyRDU0MVNQdVBZa2VYa2cx?=
 =?utf-8?Q?ahHiLYJaU1cT4oMsp+n0BiCpPV6nuW2Voh059GY?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f7fd9b-bef0-42c8-120a-08d97636f7ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2021 21:47:51.0138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JG8EgP+ZiqljyAh3f5+PdRistAPO7qGdJzdXQ+560YqdBIYeFhpAgd9en9DoNKYcdiLcJL/kWFDkYQmn+h7zk2FpdBjGZD+KLiTRaTB7rBgW+3BHw5HLhRresz4pX0RR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6913
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: v9MqO6w3W05DNxOL8lGUei7Ix4520388AA=
Content-Type: multipart/mixed; boundary="MjKWSXpOh6nlNDXwMG9m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1631483318;
 bh=wSbA/Y+v8IuAjckZV0yuSgyLDIA7RrUOmkSIp2Yzr4w=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=lvP/HsTNdKMj4bFKBlUBCi0566gdrEaJms+tSmXcYtq7a6wMbTkY3r5vI88oRnju2ga
 nIJ/507CbzqxUPrnWXudjJRd3sRXlwRR30v2B4683R39niWkC/WNttZfaiApZzvG2YuZQ
 mE0+hdkS1OJx6ohXUoQobv/GbC0MpKh/Dxs=

--MjKWSXpOh6nlNDXwMG9m
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUGF2ZWwsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwg
TWFjaGVrIFttYWlsdG86cGF2ZWxAdWN3LmN6XQ0KPiBTZW50OiBTdW5kYXksIFNlcHRlbWJlciAx
MiwgMjAyMSA4OjEwIFBNDQo+IFRvOiBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKW
oe+8s++8t++8o+KXr++8oe+8o++8tCkgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpw
Pg0KPiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IHBhdmVsQGRlbnguZGU7IG1h
c2FtaS5pY2hpa2F3YUBjeWJlcnRydXN0LmNvLmpwOyBDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5j
b207DQo+IHVsaUBmcG9uZC5ldTsgamFuLmtpc3prYUBzaWVtZW5zLmNvbQ0KPiBTdWJqZWN0OiBS
ZTogW0FOTk9VTkNFXSBSZWxlYXNlIHY0LjE5LjIwNi1jaXA1NyBhbmQgdjQuNC4yODMtY2lwNjIN
Cj4gDQo+IEhpIQ0KPiANCj4gPiBDSVAga2VybmVsIHRlYW0gaGFzIHJlbGVhc2VkIExpbnV4IGtl
cm5lbCB2NC4xOS4yMDYtY2lwNTcgYW5kIHY0LjQuMjgzLWNpcDYyLg0KPiA+IFRoZSBsaW51eC00
LjE5LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBiYXNlIHZlcnNpb24gZnJvbSB2NC4xOS4y
MDUNCj4gPiB0byB2NC4xOS4yMDYsIGFuZCB0aGUgbGludXgtNC40LnktY2lwIHRyZWUgaGFzIGJl
ZW4gdXBkYXRlZCBiYXNlIHZlcnNpb24NCj4gPiBmcm9tIHY0LjQuMjgxIHRvIHY0LjQuMjgzLg0K
PiA+DQo+ID4gWW91IGNhbiBnZXQgdGhpcyByZWxlYXNlIHZpYSB0aGUgZ2l0IHRyZWUgYXQ6DQo+
ID4NCj4gPiAgIHY0LjE5LjIwNi1jaXA1NzoNCj4gPiAgICAgcmVwb3NpdG9yeToNCj4gPiAgICAg
ICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jaXAvbGlu
dXgtY2lwLmdpdA0KPiANCj4gSSBzdGFydGVkIHVwZGF0aW5nIC1ydCB0byBuZXcgdmVyc2lvbnMs
IGJ1dCBpdCBsb29rcyBsaWtlDQo+IHY0LjE5LjIwNi1jaXA1NyBpcyBub3QgYXZhaWxhYmxlIGF0
DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NpcC9s
aW51eC1jaXAuZ2l0DQo+IC4gQ2FuIHlvdSByZWNoZWNrIHlvdSBkaWQgdGhlIGdpdCBwdXNoPw0K
DQpTb3JyeSwgSSBmb3Jnb3QgdG8gcHVzaCB0aGVzZS4gSSBqdXN0IHB1c2hlZC4NCg0KQmVzdCBy
ZWdhcmRzLA0KICBOb2J1aGlybw0K


--MjKWSXpOh6nlNDXwMG9m
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6726): https://lists.cip-project.org/g/cip-dev/message/=
6726
Mute This Topic: https://lists.cip-project.org/mt/85547773/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--MjKWSXpOh6nlNDXwMG9m--
