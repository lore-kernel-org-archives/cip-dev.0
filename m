Return-Path: <SRS0=DSCO=AU=lists.cip-project.org=bounce+64572+4914+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4A0C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  9 Jul 2020 04:49:06 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AE7206A1
	for <cip-dev@archiver.kernel.org>; Thu,  9 Jul 2020 04:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="AJFhBSll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AE7206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4914+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gwEVYY4521723xNkdUoMgzvb; Wed, 08 Jul 2020 21:49:05 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.308.1594270142732726085
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 21:49:04 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 0694mreF027021; Thu, 9 Jul 2020 13:48:53 +0900
X-Iguazu-Qid: 34tr8v5ejdO25FAdBz
X-Iguazu-QSIG: v=2; s=0; t=1594270132; q=34tr8v5ejdO25FAdBz; m=V0ESzU5dsz8J9QFJNt4iuZCdxEcfvhB+k2KvkTPZcPU=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1511) id 0694moCO018038;
	Thu, 9 Jul 2020 13:48:51 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0694mo31000826;
	Thu, 9 Jul 2020 13:48:50 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 0694moQf017186;
	Thu, 9 Jul 2020 13:48:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lz7tIOX5vjBlJSGP8jv6xUokWB2kqUYL44qUCMwT6a+0R0B16cfoYpDHsvCIqa/KWM3yjHQ8N4Q70DdB5q/zvBIb6/jgfI0UW+whg4rZHrz8U+nxBX4Y1hqyrymUaz0iP7yJUcTUjF4UitZob2fSZkZWh2kOLdzvHFbqbWk+tS8Qrg2g4FkrFLTnYu1RBjdPdsOForI2QoEiwoT4/OuuiovS6v/n80C08P5c8tFugfmDlSS6hDAk098ypip7lH8bIr6iOZhjnsThmu1pP7UVRyg64EvyXWSswcHptY8kxruaW5NF4f9bnfa49+DgbAKDgtnQ5intpu0Ft3FD+9gEdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCKVhq4hV5cb0UyujnxwqnJxz9Nb2HXDm9BlR2xxwqk=;
 b=U0KSEsQZzh26cVIjvxbYJFG2oBfA93IQNYO1hyxSW3e9L3qd4YsJN0Ov5cXxoU+Ywp5Pdadz8uHIt540FYhFPNUS3X6J02jPc/T/bs2lDBUL25obE/TUT2x67WwPJNYFOyU0ZFVWCUCeiIdPOVQGuPMye1ajIp+1vQOoA2x3LjeXEh3Ou+MiQPFJkImaBBMW9ZC4T2MVmrdb9U3lMU2mSKVqoaGVTx4oLe4MWZ4qbq23mhn1KKJxSxtGHZjJj9AFpl8AhKov0f7Vs+5dWDGLO0R9HqyKJnwCPIuUjdX0TzIGvP0qY0qZmSCG3jJjahW9wYwGFJturxPQ99ochfHZQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <wens@csie.org>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <JohnsonCH.Chen@moxa.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 00/23] PM / OPP v2 & cpufreq backports part 2
Thread-Topic: [PATCH 4.4.y-cip 00/23] PM / OPP v2 & cpufreq backports part 2
Thread-Index: AQHWVT72Kt8eBmsOsUGVMXtkq6PDVqj+qPAw
Date: Thu, 9 Jul 2020 04:48:47 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298377C58247AB1B42B22E5792640@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200708154554.26450-1-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b64adb1b-fd4a-49da-abfb-08d823c35e85
x-ms-traffictypediagnostic: OSAPR01MB4819:
x-microsoft-antispam-prvs: <OSAPR01MB4819A5C8E83609F754DF095B92640@OSAPR01MB4819.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9cuvg+eRSb+e8IeZkDn1y2aGXUqsAKGV4NYHI+lmZq9q8etTZD/Sa7zUoqPhi2BSR/pTSVIjzLNiIVP65KnS6vJ9OV1BiYkncoMJH10zupMiHCDY3NM7AW7Y5fNiPXuRP27rOu9DUoAJzIvvPtVM3lLDmKmAp2tk6Fp2LXnAKTkoMQisDbHUxKDiG0/nxSslAtFdogpMBaQ4yBhAc12cZm8/KUtG38XboGcnMP93aQBECnwXqQGVIH03FZYeuVFazYvqIN+iUXb60ciOwwmTHHia6DveirQi7djYUccASgsYhEMN+VqKcqEJzZYRSflqX5ZY6cabEEdqtIVaQFSkXBY2PR5Dl8URQOPElbtHRmYAtLnuMMyrW7ugxMiijXUZvrYU5pRnJgFXBPfBDAQk+A==
x-ms-exchange-antispam-messagedata: cCZ4RNfEBG3cAlGvDvZnP85fRZ5vPvyICW9AOCS05ZpjwbDAzIPoogxD6pwBRRVFmnWbUqmEwYCLjb2TKppMITUh2TIvA7Y8yL4Z5GF4rIkX2LV7QOMC9Fuh9A8jw+9aC+eQRbv0RY99N4wwRkSM1bcznww23T2CLvype9eO9PKn+4v6W30AsmLHnMXIzz7Z+J7Lu18cxWoQwRIF3grb+TklH/fesZW9vrT7SqAAnKyPw7ZXwLYA8op8o6Cnt6TQz/xiqJ/B+yXg0subwiqcTchXXcto6vwOQMTFdXquwZZWJdufhNGu9YvXIMmgvQRGeU8i3je/NFATKOkhmbpVaqf0gkVGKV+FA9OeLJJur/vLm/I7Rhf/eXZ67/HTm9VebFfbNTUaMkjDTOZ2DccHYfMSTqVOTvVkw8zld2tgaA4qT1dCXHkRjj2mnDgvX4U2VExYK3yYO2D2F3RHWOHfuzV23jGXaJhWXAVMfRe3epw=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64adb1b-fd4a-49da-abfb-08d823c35e85
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 04:48:48.1300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RDmAdqRvXZjxxuqNPYRqSbv/X/LXISoGCLd03gFNzrPHr/eAXH544+2omQf6/C6WOU9TQWl6mIV98KUdq6oWNS+IOO3D3fZQl5zlHC3MXLXuw23drTVSx9Uz2/QKnxH4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4819
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: OYKPDV5F355mxkLo2j0JrfUlx4520388AA=
Content-Type: multipart/mixed; boundary="JghsHeJDO0vFh2FgsWSe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594270145;
 bh=XIGsEMkrs39YLodH7Umz9e4zVym/bvMrfwAcUdH5T7A=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=AJFhBSlluAvnko65vNtrZ2dn3CkPcNk9O9VQwkUQGveYhPDB6doKmfU29iUZmPPWxLw
 xb0oFlrBJ5JbN1PXKTVWNd8m0+WZ4W525ommXuTnce99RhurNKY57RfQCygKCILZf2MnY
 suN6Qij4wm0flZZ26CClLqd2C2sPMWzERSQ=

--JghsHeJDO0vFh2FgsWSe
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hlbi1ZdSBUc2Fp
IChNb3hhKSBbbWFpbHRvOndlbnNAY3NpZS5vcmddDQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDks
IDIwMjAgMTI6NDYgQU0NCj4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah
77yz77y377yj4pev77yh77yj77y0KSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+
OyBwYXZlbEBkZW54LmRlDQo+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgSm9o
bnNvbkNILkNoZW5AbW94YS5jb20NCj4gU3ViamVjdDogW1BBVENIIDQuNC55LWNpcCAwMC8yM10g
UE0gLyBPUFAgdjIgJiBjcHVmcmVxIGJhY2twb3J0cyBwYXJ0IDINCj4gDQo+IEhpIGV2ZXJ5b25l
LA0KPiANCj4gVGhpcyBpcyBwYXJ0IDIgb2YgTU9YQSdzIFBNIC8gT1BQIC8gY3B1ZnJlcSBiYWNr
cG9ydCBzZXJpZXMuIFRoZSB3aG9sZQ0KPiBzZXJpZXMgYWltcyB0byBiYWNrcG9ydCBwYXRjaGVz
IHJlbGF0ZWQgdG8gUE0gLyBPUFB2MiBhbmQgY3B1ZnJlcQ0KPiB3aGljaCB3ZXJlIGluY2x1ZGVk
IGluIHRoZSB2NC40IGtlcm5lbCBmcm9tIFRJJ3MgU0RLLiBUaGUgZW5kIGdvYWwgaXMNCj4gdG8g
aW5jbHVkZSBjcHVmcmVxLXRpIGFuZCBjb252ZXJ0IGFtMzN4eCB0byB1c2luZyBpdCBhbmQgT1BQ
djIuDQo+IA0KPiBQYXJ0IDIgaGVyZSBpbmNsdWRlcyBwYXRjaGVzIGZyb20gdGhlIHY0LjYgY3lj
bGUsIGFzIHdlbGwgYXMgYWRkaXRpb25hbA0KPiBmaXhlZCBmb3VuZCB0aHJvdWdoIEZpeGVzIHRh
Z3M6DQo+IA0KPiAgICAgOWY4ZWE5NjlkNWNmIFBNIC8gT1BQOiBnZXQvcHV0IHJlZ3VsYXRvcnMg
ZnJvbSBPUFAgY29yZQ0KPiAgICAgN2QzNGQ1NmVmMzM0IFBNIC8gT1BQOiBEaXNhYmxlIE9QUHMg
dGhhdCBhcmVuJ3Qgc3VwcG9ydGVkIGJ5IHRoZSByZWd1bGF0b3INCj4gICAgIDY1NWM5ZGY5NjE3
NSBQTSAvIE9QUDogSW50cm9kdWNlIGRldl9wbV9vcHBfZ2V0X21heF92b2x0X2xhdGVuY3koKQ0K
PiAgICAgMjE3NDM0NDc2NWY0IFBNIC8gT1BQOiBJbnRyb2R1Y2UgZGV2X3BtX29wcF9nZXRfbWF4
X3RyYW5zaXRpb25fbGF0ZW5jeSgpDQo+ICAgICA1MGY4Y2ZiZDU4OTcgUE0gLyBPUFA6IFBhcnNl
IGNsb2NrLWxhdGVuY3kgYW5kIHZvbHRhZ2UtdG9sZXJhbmNlIGZvciB2MSBiaW5kaW5ncw0KPiAg
ICAgZDU0OTc0YzI1MTNmIFBNIC8gT1BQOiBNYW5hZ2UgZGV2aWNlIGNsaw0KPiAgICAgNmEwNzEy
ZjZmMTk5IFBNIC8gT1BQOiBBZGQgZGV2X3BtX29wcF9zZXRfcmF0ZSgpDQo+ICAgICA4OTZkNmE0
YzBmNDEgY3B1ZnJlcTogZHQ6IENvbnZlcnQgZmV3IHByX2RlYnVnL2VycigpIGNhbGxzIHRvIGRl
dl9kYmcvZXJyKCkNCj4gICAgIDQ1N2U5OWU2MGE4ZiBjcHVmcmVxOiBkdDogUmVuYW1lICduZWVk
X3VwZGF0ZScgdG8gJ29wcF92MScNCj4gICAgIDM5MWQ5YWVmODE0NSBjcHVmcmVxOiBkdDogT1BQ
IGxheWVycyBoYW5kbGVzIGNsb2NrLWxhdGVuY3kgZm9yIFYxIGJpbmRpbmdzIGFzIHdlbGwNCj4g
ICAgIDA1MDc5NGFhZWJiYiBjcHVmcmVxOiBkdDogUGFzcyByZWd1bGF0b3IgbmFtZSB0byB0aGUg
T1BQIGNvcmUNCj4gICAgIDZkZWY2ZWE3NWU2ZCBjcHVmcmVxOiBkdDogVW5zdXBwb3J0ZWQgT1BQ
cyBhcmUgYWxyZWFkeSBkaXNhYmxlZA0KPiAgICAgNzU1Yjg4OGZmMDk4IGNwdWZyZXE6IGR0OiBS
ZXVzZSBkZXZfcG1fb3BwX2dldF9tYXhfdHJhbnNpdGlvbl9sYXRlbmN5KCkNCj4gICAgIDc4YzNi
YTVkZjk2YyBjcHVmcmVxOiBkdDogVXNlIGRldl9wbV9vcHBfc2V0X3JhdGUoKSB0byBzd2l0Y2gg
ZnJlcXVlbmN5DQo+ICAgICBkZjJjOGVjMjhlNzMgY3B1ZnJlcTogZHQ6IE5vIG5lZWQgdG8gZmV0
Y2ggdm9sdGFnZS10b2xlcmFuY2UNCj4gICAgIGRkMDJhM2Q5MjAwOCBjcHVmcmVxOiBkdDogTm8g
bmVlZCB0byBhbGxvY2F0ZSByZXNvdXJjZXMgYW55bW9yZQ0KPiAgICAgNzhlY2M1NjI0N2YwIFBN
IC8gT1BQOiBGaXggTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGNyYXNoIHdoZW4gZGlzYWJsaW5n
IE9QUHMNCj4gICAgIDBjNzE3ZDBmOWNiNCBQTSAvIE9QUDogSW5pdGlhbGl6ZSByZWd1bGF0b3Ig
cG9pbnRlciB0byBhbiBlcnJvciB2YWx1ZQ0KPiAgICAgYTVkYTY0NDc3ZWU3IFBNIC8gT1BQOiBG
aXggaW5jb3JyZWN0IGNvbW1lbnRzDQo+ICAgICAyYzI3MDlkYzY5MjEgUE0gLyBPUFA6IFJlbmFt
ZSBzdHJ1Y3R1cmVzIGZvciBjbGFyaXR5DQo+ICAgICBiMzE4NTU2NDc5Y2MgY3B1ZnJlcTogZHQ6
IERyb3Agc3RhbGUgY29tbWVudA0KPiAgICAgMjFmOGE5OWNlNjFiIFBNIC8gT1BQOiBSZW1vdmUg
dXNlbGVzcyBjaGVjaw0KPiAgICAgYzVjMmE5N2IzYWM3IFBNIC8gT1BQOiBVcGRhdGUgdm9sdGFn
ZSBpbiBjYXNlIGZyZXEgPT0gb2xkX2ZyZXENCj4gDQo+IE9mIHRoZXNlLA0KPiANCj4gICAgIGIz
MTg1NTY0NzljYyBjcHVmcmVxOiBkdDogRHJvcCBzdGFsZSBjb21tZW50DQo+IA0KPiB3YXMgZm91
bmQgd2hpbGUgbG9va2luZyB0aHJvdWdoIGdpdCBsb2dzLg0KPiANCj4gICAgIDIxZjhhOTljZTYx
YiBQTSAvIE9QUDogUmVtb3ZlIHVzZWxlc3MgY2hlY2sNCj4gICAgIGM1YzJhOTdiM2FjNyBQTSAv
IE9QUDogVXBkYXRlIHZvbHRhZ2UgaW4gY2FzZSBmcmVxID09IG9sZF9mcmVxDQo+IA0KPiB3ZXJl
IGZvdW5kIGJ5IGxvb2tpbmcgZm9yIGNvbW1pdCBoYXNoZXMgaW4gRml4ZXMgdGFncy4NCj4gQWxs
IG90aGVyIHBhdGNoZXMgd2VyZSBpbmNsdWRlZCBmcm9tIFRJJ3MgU0RLLg0KPiANCj4gVGhlIHBh
dGNoZXMgYXBwbHkgY2xlYW5seSBvbiB0b3Agb2YgbGludXgtNC40LnktY2lwLiBUaGUgbGFzdCBw
YXRjaA0KPiBpbnZvbHZlZCBzb21lIGJhY2twb3J0aW5nIGR1ZSB0byBwYXRoIGFuZCBjb2RlIGNo
YW5nZXMgYmV0d2VlbiB2NC42DQo+IGFuZCB2NC4xOC4NCj4gDQo+IFBsZWFzZSBoYXZlIGEgbG9v
ay4NCj4gDQo+IA0KDQpJJ3ZlIGxvb2tlZCBhdCB0aGVzZSBwYXRjaGVzIGFuZCB0aGV5IHNlZW0g
dG8gYmUgZmluZS4NCkkgYW0gdGVzdGluZyB0aGlzIHBhdGNoIGFzIA0KICBodHRwczovL2dpdGxh
Yi5jb20vY2lwLXByb2plY3QvY2lwLWtlcm5lbC9saW51eC1jaXAvLS9waXBlbGluZXMvMTY0NjAy
MzUyDQoNCg0KPiBSZWdhcmRzDQo+IENoZW5ZdQ0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJv
DQoNCj4gDQo+IA0KPiBKb24gSHVudGVyICgxKToNCj4gICBQTSAvIE9QUDogRml4IE5VTEwgcG9p
bnRlciBkZXJlZmVyZW5jZSBjcmFzaCB3aGVuIGRpc2FibGluZyBPUFBzDQo+IA0KPiBWaXJlc2gg
S3VtYXIgKDIxKToNCj4gICBQTSAvIE9QUDogZ2V0L3B1dCByZWd1bGF0b3JzIGZyb20gT1BQIGNv
cmUNCj4gICBQTSAvIE9QUDogRGlzYWJsZSBPUFBzIHRoYXQgYXJlbid0IHN1cHBvcnRlZCBieSB0
aGUgcmVndWxhdG9yDQo+ICAgUE0gLyBPUFA6IEludHJvZHVjZSBkZXZfcG1fb3BwX2dldF9tYXhf
dm9sdF9sYXRlbmN5KCkNCj4gICBQTSAvIE9QUDogSW50cm9kdWNlIGRldl9wbV9vcHBfZ2V0X21h
eF90cmFuc2l0aW9uX2xhdGVuY3koKQ0KPiAgIFBNIC8gT1BQOiBQYXJzZSBjbG9jay1sYXRlbmN5
IGFuZCB2b2x0YWdlLXRvbGVyYW5jZSBmb3IgdjEgYmluZGluZ3MNCj4gICBQTSAvIE9QUDogTWFu
YWdlIGRldmljZSBjbGsNCj4gICBQTSAvIE9QUDogQWRkIGRldl9wbV9vcHBfc2V0X3JhdGUoKQ0K
PiAgIGNwdWZyZXE6IGR0OiBDb252ZXJ0IGZldyBwcl9kZWJ1Zy9lcnIoKSBjYWxscyB0byBkZXZf
ZGJnL2VycigpDQo+ICAgY3B1ZnJlcTogZHQ6IFJlbmFtZSAnbmVlZF91cGRhdGUnIHRvICdvcHBf
djEnDQo+ICAgY3B1ZnJlcTogZHQ6IE9QUCBsYXllcnMgaGFuZGxlcyBjbG9jay1sYXRlbmN5IGZv
ciBWMSBiaW5kaW5ncyBhcyB3ZWxsDQo+ICAgY3B1ZnJlcTogZHQ6IFBhc3MgcmVndWxhdG9yIG5h
bWUgdG8gdGhlIE9QUCBjb3JlDQo+ICAgY3B1ZnJlcTogZHQ6IFVuc3VwcG9ydGVkIE9QUHMgYXJl
IGFscmVhZHkgZGlzYWJsZWQNCj4gICBjcHVmcmVxOiBkdDogUmV1c2UgZGV2X3BtX29wcF9nZXRf
bWF4X3RyYW5zaXRpb25fbGF0ZW5jeSgpDQo+ICAgY3B1ZnJlcTogZHQ6IFVzZSBkZXZfcG1fb3Bw
X3NldF9yYXRlKCkgdG8gc3dpdGNoIGZyZXF1ZW5jeQ0KPiAgIGNwdWZyZXE6IGR0OiBObyBuZWVk
IHRvIGZldGNoIHZvbHRhZ2UtdG9sZXJhbmNlDQo+ICAgY3B1ZnJlcTogZHQ6IE5vIG5lZWQgdG8g
YWxsb2NhdGUgcmVzb3VyY2VzIGFueW1vcmUNCj4gICBQTSAvIE9QUDogSW5pdGlhbGl6ZSByZWd1
bGF0b3IgcG9pbnRlciB0byBhbiBlcnJvciB2YWx1ZQ0KPiAgIFBNIC8gT1BQOiBGaXggaW5jb3Jy
ZWN0IGNvbW1lbnRzDQo+ICAgUE0gLyBPUFA6IFJlbmFtZSBzdHJ1Y3R1cmVzIGZvciBjbGFyaXR5
DQo+ICAgY3B1ZnJlcTogZHQ6IERyb3Agc3RhbGUgY29tbWVudA0KPiAgIFBNIC8gT1BQOiBSZW1v
dmUgdXNlbGVzcyBjaGVjaw0KPiANCj4gV2FsZGVtYXIgUnltYXJraWV3aWN6ICgxKToNCj4gICBQ
TSAvIE9QUDogVXBkYXRlIHZvbHRhZ2UgaW4gY2FzZSBmcmVxID09IG9sZF9mcmVxDQo+IA0KPiAg
ZHJpdmVycy9iYXNlL3Bvd2VyL29wcC9jb3JlLmMgICAgfCAxMDY2ICsrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLQ0KPiAgZHJpdmVycy9iYXNlL3Bvd2VyL29wcC9jcHUuYyAgICAgfCAgIDIy
ICstDQo+ICBkcml2ZXJzL2Jhc2UvcG93ZXIvb3BwL2RlYnVnZnMuYyB8ICAgODUgKystDQo+ICBk
cml2ZXJzL2Jhc2UvcG93ZXIvb3BwL29wcC5oICAgICB8ICAgNzQgKystDQo+ICBkcml2ZXJzL2Nw
dWZyZXEvY3B1ZnJlcS1kdC5jICAgICB8ICAzMDMgKysrLS0tLS0tDQo+ICBpbmNsdWRlL2xpbnV4
L3BtX29wcC5oICAgICAgICAgICB8ICAgMjcgKw0KPiAgNiBmaWxlcyBjaGFuZ2VkLCA5NzMgaW5z
ZXJ0aW9ucygrKSwgNjA0IGRlbGV0aW9ucygtKQ0KPiANCj4gLS0NCj4gMi4yNy4wDQoNCg==

--JghsHeJDO0vFh2FgsWSe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4914): https://lists.cip-project.org/g/cip-dev/message=
/4914
Mute This Topic: https://lists.cip-project.org/mt/75379082/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--JghsHeJDO0vFh2FgsWSe--
