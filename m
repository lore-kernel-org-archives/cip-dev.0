Return-Path: <SRS0=UayL=7P=lists.cip-project.org=bounce+64572+4662+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD06C433DF
	for <cip-dev@archiver.kernel.org>; Tue,  2 Jun 2020 12:29:03 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211B92053B
	for <cip-dev@archiver.kernel.org>; Tue,  2 Jun 2020 12:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="NH6ykWdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211B92053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4662+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id u5W9YY4521723x2Ce7aaA7BM; Tue, 02 Jun 2020 05:29:02 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.75])
 by mx.groups.io with SMTP id smtpd.web10.5066.1591079785927451755
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Jun 2020 23:36:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2Fvh82xlfZ3NZ2xMp3/K3pnCmZUSXhb7Wk7sLu4T7I9KVDBPB4swv1i4qT/52y4hStIV5WKMk3sk2qB7VjQ5nW5Xu2uBVP4vtZPgoN11KEf1FthQFHRRnVOMNnoPwXgAHX1sZl4pjnzNq9fx4dK6HPA8Dp4/n3dNezynUYT2LaJCf0pkAGH4uuhUlc+naf6e4GkX6yvMYfs4k4/ex8dsOKUVrCJ06eimiXVgHVDahxMcGyl1heXHL/fr8HPXB2nag/ujBeW97e5x+sqXb7suBLBh8KmF+KIHxqIRbujW3PPtNMO62enlOZdmNabv20ZFygEsHd5Nj2dTXDQ2hU5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVRUX/z8ylqMQOKOuCtn+5XddPPdG/vh+KMclxDxiuY=;
 b=O3PEQkXANQ0ngU73DYv9hmFloEPTQ/BTXFRKA3eX8yx1lK/qqwUiLVQgNt+ql16qmTpoIFiF66KXTApQVg8kqCCt7NB1VG7E0vyj62yRcC4lMSondIF6XZTLamJwj6RkvqO3tM3hzNDCetk9RGsCL8tKW9xHJTqfNzBFy3Er9GqTMKXZuSgpHBsoPsEH6OQJLA9A32iYDI5nBMDrG3OMJEgsBHPAS/dv7coXMc+A4yD3Ulx3cSMpVT+VnDq4iAsGuKgzgpWQExSvktt1EIgc5O4YRMkDvpr51JslU3N8EInBXVCy0lPKHF086HtzLfJd5G5IQ6PTJmfnqtu9ocV3Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
X-Received: from HK0PR01MB2450.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3c::12) by HK0PR01MB2355.apcprd01.prod.exchangelabs.com
 (2603:1096:203:79::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Tue, 2 Jun
 2020 06:36:23 +0000
X-Received: from HK0PR01MB2450.apcprd01.prod.exchangelabs.com
 ([fe80::e089:90c2:4697:70ac]) by HK0PR01MB2450.apcprd01.prod.exchangelabs.com
 ([fe80::e089:90c2:4697:70ac%2]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 06:36:23 +0000
From: =?utf-8?B?U1ogTGluICjmnpfkuIrmmbop?= <SZ.Lin@moxa.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Kernel config warning
Thread-Topic: [cip-dev] Kernel config warning
Thread-Index: AdY4YgxrtHSDBaMZSpup0T/oNPPVRAANwYUwAADQSgAAAuI0QA==
Date: Tue, 2 Jun 2020 06:36:23 +0000
Message-ID: 
 <HK0PR01MB24508BFDB58F4D39F1BED74DE28B0@HK0PR01MB2450.apcprd01.prod.exchangelabs.com>
References: 
 <OSAPR01MB2385ECC888BFA203140CA3CEB78A0@OSAPR01MB2385.jpnprd01.prod.outlook.com>
 <1614A0DCA25C7189.14405@lists.cip-project.org>
 <OSBPR01MB29835BC2A60802C0BD3958D0928B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB29835BC2A60802C0BD3958D0928B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: zh-TW, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [211.75.1.240]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1894ed52-a4ca-484e-b266-08d806bf44c5
x-ms-traffictypediagnostic: HK0PR01MB2355:
x-microsoft-antispam-prvs: 
 <HK0PR01MB23553058E53F86818E99A147E28B0@HK0PR01MB2355.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:114;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 piA1TXjXdVGAyONmAPEL1zhjLQ/rfYWDTOEJLa2PNDMZg8VNIeCyM6jvbvMOJIvF5cAwdxomYHJPk7hLKoHn0DGwSp9F5CrMMklcsNSEAmrZVYPupytCGuMdjAZH60LF42ETU8D8Tl8+zSjJC5QMOO4Mp68pWCuGcoZsCBSOxcEYk/adh5CEG0gKN/CDZJjm73fpQtyKeWBn6hxzUUr0fl0o61NBolNkgp2avlm0J5Hs/eyNtOgD+xrDe/5oH2LfFIK5+tfyoz6mjT4fuST6ZwKpXJrhQ+Y2UKgFyrrxCySe8GdRy914ulVjk7FiRpkB0bAl3beSW4s9Ya8siNEnvSizIlu/hmrqy8pzGcwQPTGjM1HzTHil+eIpoLmw55fmPNUDH4Y/DHfwtFJTCtZCvw==
x-ms-exchange-antispam-messagedata: 
 OlecxdlA/CC/2+O34SKFj0WIAmdE+WrbDnmB44Q7auseuBqVaPn5lsW1NqHLPhH2esSoqFdzREG4WVk86IR4sy41OkSOhhrBGTUUTDKd1OfU9dBRJKk2jJPENeDqQyiJnJANsavjjXwIBGXxreRTatvPWItc70ozqHcAnwyfcFszitbHs4WT/Nu0N/MHCoTBTwHMNSeS32Jc0AY8ecSIiSx3TAkeybdOzbGisVMeEEyXSInMmdW+dP3EZ3X5wJKQg5U0ZgTGYsci9ODdhVG1imYIY9lx39+48U9DASZiN3HCCbWRcGYMUSQ4d/qIKw3l5lEVy13g3JCu3tu1urVTF/UXoLyfK5Y/MKfcw+Ato+xyxvXAMAGA9WTqakM1htcCQV7oXnKwg6uNr83au4h9acFvY+CGWxMeKq7W353I0Y5xDzefdTqQo2W1YnXE+XBkxHcj+TyzqYeRgQqfMDS2yCwH7SzZUHApNRt6ShWOVjY=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1894ed52-a4ca-484e-b266-08d806bf44c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 06:36:23.3423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0aipDn+48rA0m1QSzPPwekI8k+0/CA+tkyyjaXcuHpWG+nAde4CzjAB7yrG56FvI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR01MB2355
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: vvMuCeCygTGi8EFz1h0GTkvVx4520388AA=
Content-Type: multipart/mixed; boundary="oeFVLYOsaFL2GxYt1X0R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591100942;
 bh=iPsV4fZqI5aiu03iAv76vEIMtcOiEgpE4aaj0DvfBQE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=NH6ykWdXMtJNG5yHHVsP7NUKxfCtvvcUS4vGEmwHxk7ZguAzs+oD6egzTTol4jR2Q/j
 V3hN7WDz6GHTU8/3r96R03SHcB1noq8nDDfEZ9LZHv4SfwHTW5W0Gg3zLdn2Mn9kRz5YZ
 zxeg3QqHa4ppHkvc5dC7Ku+DMwPvl2KaYeI=

--oeFVLYOsaFL2GxYt1X0R
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgSXdhbWF0c3Utc2FuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwDQo+IDxub2J1aGlybzEuaXdhbWF0c3VA
dG9zaGliYS5jby5qcD4NCj4gU2VudDogVHVlc2RheSwgSnVuZSAyLCAyMDIwIDE6MjQgUE0NCj4g
VG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IENjOiBTWiBMaW4gKOael+S4iuaZ
uikgPFNaLkxpbkBtb3hhLmNvbT4NCj4gU3ViamVjdDogUkU6IFtjaXAtZGV2XSBLZXJuZWwgY29u
ZmlnIHdhcm5pbmcNCj4gDQo+IEhpLA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+ID4gW21haWx0bzpj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10gT24gQmVoYWxmIE9mIE5vYnVoaXJvIEl3YW1h
dHN1DQo+ID4gU2VudDogVHVlc2RheSwgSnVuZSAyLCAyMDIwIDE6NTAgUE0NCj4gPiBUbzogY2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gPiBDYzogU1ouTGluQG1veGEuY29tDQo+ID4g
U3ViamVjdDogUmU6IFtjaXAtZGV2XSBLZXJuZWwgY29uZmlnIHdhcm5pbmcNCj4gPg0KPiA+IEhp
LA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogY2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gPiA+IFttYWlsdG86Y2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmddIE9uIEJlaGFsZiBPZiBDaHJpcyBQYXRlcnNvbg0KPiA+ID4gU2VudDog
VHVlc2RheSwgSnVuZSAyLCAyMDIwIDc6MTggQU0NCj4gPiA+IFRvOiBjaXAtZGV2QGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZw0KPiA+ID4gQ2M6IFNaLkxpbkBtb3hhLmNvbQ0KPiA+ID4gU3ViamVjdDog
W2NpcC1kZXZdIEtlcm5lbCBjb25maWcgd2FybmluZw0KPiA+ID4NCj4gPiA+IEhlbGxvIEtlcm5l
bCBtYWludGFpbmVycywNCj4gPiA+DQo+ID4gPiBJIHNhdyB0aGlzIHdhcm5pbmcgWzBdIGJ5IGNo
YW5jZSB0aGlzIGV2ZW5pbmcgd2hlbiBkb2luZyBhIGJ1aWxkIHdpdGggdGhlDQo+IG1veGFfbXhj
X2RlZmNvbmZpZyBbMV0gS2VybmVsIGNvbmZpZy4NCj4gPiA+DQo+ID4gPiBJcyB0aGlzIHNvbWV0
aGluZyB3ZSB3YW50IHRvIGNvcnJlY3Q/DQo+ID4NCj4gPiBUaGFua3MgZm9yIHlvdXIgcmVwb3J0
Lg0KPiA+IFJUQ19EUlZfRFMxMzc0X1dEVCBjYW4gbm90IHNldCAneScuIEkgd2lsbCB1cGRhdGUg
bW94YV9teGNfZGVmY29uZmlnLg0KPiA+DQo+IA0KPiBSVENfRFJWX0RTMTM3NF9XRFQgY2FuIG5v
dCBzZXQgJ20nLg0KPiBBbmQgSSB1cGRhdGVkIG1veGFfbXhjX2RlZmNvbmZpZyBhbmQgcHVzaGVk
Lg0KDQpOb3RlZCB3aXRoIHRoYW5rcy4NCg0KU1oNCg0KPiANCj4gPiA+DQo+ID4gPiBbMF0NCj4g
PiA+ICJhcmNoL2FybS9jb25maWdzL21veGFfbXhjX2RlZmNvbmZpZzo3NDU6d2FybmluZzogc3lt
Ym9sIHZhbHVlICdtJw0KPiBpbnZhbGlkIGZvciBSVENfRFJWX0RTMTM3NF9XRFQiDQo+ID4gPiBo
dHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWtlcm5lbC9saW51eC1jaXAvLS9qb2Jz
LzU0NjA2NTY4OA0KPiA+ID4gI0wxMjkgWzFdDQo+ID4gPiBodHRwczovL2dpdGxhYi5jb20vY2lw
LXByb2plY3QvY2lwLWtlcm5lbC9jaXAta2VybmVsLWNvbmZpZy8tL2Jsb2IvbQ0KPiA+ID4gYXN0
ZXIvNC40LnktY2lwL2FybS9tb3hhX214Y19kZWZjb25maWcNCj4gPiA+DQo+ID4gPiBLaW5kIHJl
Z2FyZHMsIENocmlzDQo+ID4NCj4gQmVzdCByZWdhcmRzLA0KPiAgIE5vYnVoaXJvDQo=

--oeFVLYOsaFL2GxYt1X0R
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4662): https://lists.cip-project.org/g/cip-dev/message=
/4662
Mute This Topic: https://lists.cip-project.org/mt/74616319/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--oeFVLYOsaFL2GxYt1X0R--
