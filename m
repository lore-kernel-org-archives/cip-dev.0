Return-Path: <SRS0=lWK+=DP=lists.cip-project.org=bounce+64572+5507+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB61C4363C
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 05:45:37 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9B72087D
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 05:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Xr96JDSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9B72087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5507+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Vor7YY4521723xS6E63ApoVl; Wed, 07 Oct 2020 22:45:36 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web11.5393.1602135933911431674
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Oct 2020 22:45:35 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 0985jI5k017723; Thu, 8 Oct 2020 14:45:18 +0900
X-Iguazu-Qid: 2wHHOqOUeYe7936OCR
X-Iguazu-QSIG: v=2; s=0; t=1602135917; q=2wHHOqOUeYe7936OCR; m=1wWfaxWtUVcTQdwcimUIs7rjTT9EDjAc+MOlIW/dVSc=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1112) id 0985jFPp014713;
	Thu, 8 Oct 2020 14:45:16 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0985jFAG026951;
	Thu, 8 Oct 2020 14:45:15 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0985jFQw008788;
	Thu, 8 Oct 2020 14:45:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGKKbUF1Ll1oQHvrcuGw1ljTLBq5Lkx7z4b49d2yX3Ce4FYQ2NudR9eChw4jnYXing3zjVoX0Kbw7Uq9tf9e50uoomxJg78JHSt8r6F4SvcZOfGf6jnKd5BAg+9wWZyzCEuy2z9/Kx6qcfVQc7hrYDEeN2poTJjNmM0DhmbTywR/85hTHexAcGZVwpBPdu7wWwbgiNNz/7Em4JfBozbkBtHxuGCM+Q0wTsqGN6vnhWVUZIKPFEvBHLmZNjETC6Idc14c8G9ZjCF7MWtx6GampzXMw14GxZzngq8elioqTs/BHB23h1Ft+UyjdNN7mNXXSG1HMsTa/dg6N2LFMUh6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4qKwlyjpvOECaA/TB2PfRjF7LLL0oASwk1woTppGHk=;
 b=A3RzWIkxGgGtTRyppqikCh8CrkU5PazeQO+qqsziRuvEmq+fojBsgpvG81+YDSBiOvaobJMyNAW1dIddkMJXToeRUNjQicIIH6LQ3uVG2ukO2IU0jtZ6tzWkCBH1v/q99VVTUFVZb9vD2X4DNn9FR6QBqahbzlAlBNlyhe2CPbU7W56HWeLaMO09DfHZGuunde4C/t5j3op8dTNWQNrAAbh9GGEvw3lnXYxdUe0Y042XCelqxonuTnOF0pG45R1sfWXRMtqjxlqce0T7pbYr9U1bK/By4AVbsPyOyYHLjPiOrNTT7Hduv8JItKxOphVlp3sCdxIpqr7oHJm33smZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>,
        <SZ.Lin@moxa.com>, <ben.hutchings@codethink.co.uk>,
        <Chris.Paterson2@renesas.com>
Subject: Re: [cip-dev] [ANNOUNCE] v4.19.148-cip35-rt15
Thread-Topic: [cip-dev] [ANNOUNCE] v4.19.148-cip35-rt15
Thread-Index: AQHWmi3HbeDruN0ZlkG2LoC92+G9x6mH5dqAgAATW4CAAhzRMIABKiPAgAFXcACAAJvFoIAAA0YQ
Date: Thu, 8 Oct 2020 05:45:13 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29830A20D0091432F1D9354E920B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201004090653.GA18130@amd>
 <TYAPR01MB23984E9AECF0CDEE4B32B7F1B70F0@TYAPR01MB2398.jpnprd01.prod.outlook.com>
 <20201004213905.GA8065@duo.ucw.cz>
 <163B547D5FFC3079.30511@lists.cip-project.org>
 <OSBPR01MB2983148027370F1B4D02B0B6920D0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <20201007201102.GB32003@duo.ucw.cz>
 <OSBPR01MB29838595D7430E92E750A188920B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB29838595D7430E92E750A188920B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c699ddef-af8b-4028-95c7-08d86b4d53be
x-ms-traffictypediagnostic: OSBPR01MB3749:
x-microsoft-antispam-prvs: <OSBPR01MB3749A13DA2D04348B3E2EF4E920B0@OSBPR01MB3749.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:462;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5sNqHB9rKW/BRbZyLwvU0NprU7tPjDV7bQrV3H9wg6KPHvv2QYQQCcez71vg3MgPqiclydXoVtx0HQRsepj884aRRDCB8secHoM+fL0UyyNKqpDGPTnDhMVMQi1D1Wxbkz4pfNZUKUqZbzC3rzwBwlrBeJ+8Hqs7nvMgRdPPVjzyAMMdVaMOpPIUhL9d4iA6AvSKhXle7eSQYD93zv9v4ub3mO3c75utzZbE7DTa5+NCbTILH/eECmp3se3LTuu9ePiw6eivZjyJqMJr8ZrapWmWoxmfL3AzC33ehJfMFPFoT8wFfWi+r78wftzoRnLWxRMhjwNNijj0aWnEh4X0jC8lQWx2IC0F9QVTWjOQJxslTYewxy6CMQzSTHDmKx86F2u5J4oOCl4Ko7bHX1yqeQ==
x-ms-exchange-antispam-messagedata: sOckacKY7B1v3ZQ1b2EeH3mfNhr0IT1h0ctLcDabB9k/X7ULDYS4GDKKOHmIZAv+lBqTCcnE8S39rO/mcbf7BNNYeZUxjKG9O9Gikr/OaVEGCQejUnUBdkE/zSXw0vyDkOj1k0LxkPtzFaU8KaxdKjwOUrBlE+1m2L3HvM1/zBr9XlTzKgP3ihZ7Js7v3vNRwFN0GIcUbsG+lgRyEg5vcrvdcc1jif+/svfWOMjSUyxYw+91+F9bJYK+UzSmXj/kzbxWbQqsvr+z+clMpWZcg2G8RU40dOLHsncJDoE7tAfxa1ACeNc8neXvF8cJeFBoPJmOWX8pQGzK06OmRDenoeW7iuVRnnxdd9rHa/jKuoASw05X9pr7AFlcxQFKV3tSE9QgKSVCNZk2o8o64iDkNoTo4WQ772SrHGXmwew7oxG5CbuWgsf2XbgyJSPuQDBa/cWvxm+Qb8lz08yBTtbhFGdZsKbezlnXsXl+aa5TUCE/jRvFOEB9CQdQIcmolZ/O72VXLVZSRuK+vhfzHqnRwRYsm8lV+Eq/dA+EhXN9Gb2o2yRtupRSJM2JRPfJT1oTGNmaPUT5k5ajqDc/11gCE+1jFj9o40LDMMV5syoZ58BycBkA0rtNo7crsZ7VgmH6Fe2/0U3sFwv4pDvS+IBwIw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c699ddef-af8b-4028-95c7-08d86b4d53be
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 05:45:13.3398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EC/m7Z2IN84kwzSzrt0NWiQPwf0q5sDojLKT6WnSEIPL3/p+V7yVhfbBUM/Q8UoKrtWwUVjz3J8bpksiHdQvHRvO/MhMNuwFUicyAJ5+vIVR3QNy7zNjpeb0bOMHDJIj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3749
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: QGV08t2O8qxNlJymZTHorKMUx4520388AA=
Content-Type: multipart/mixed; boundary="uZuM4msWQnkoLsUc0CnX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602135936;
 bh=hDmTp4HFrgz59b4EoYdIQN8s0o5gZ4fEFpAp1peEcWA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Xr96JDSo3M4F9g0GImHkBuIIFO6M34xDMlpQc7D847XBSKutHW1A3dtOs8w/EMbfTlz
 mKpt+jSwBDf280KmNcnXAThS/0Nz6y3Pu72DY/QX+8/x4S2vMVJ5YKQsBhxacIZUlYJEg
 b6ByAAb1YQz+BAtp8JYHQb1zOgweLfeZXs0=

--uZuM4msWQnkoLsUc0CnX
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogaXdhbWF0c3Ugbm9i
dWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpDQo+IFNlbnQ6IFRo
dXJzZGF5LCBPY3RvYmVyIDgsIDIwMjAgMjozMiBQTQ0KPiBUbzogUGF2ZWwgTWFjaGVrIDxwYXZl
bEBkZW54LmRlPg0KPiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGphbi5raXN6
a2FAc2llbWVucy5jb207IFNaLkxpbkBtb3hhLmNvbTsgYmVuLmh1dGNoaW5nc0Bjb2RldGhpbmsu
Y28udWs7DQo+IENocmlzLlBhdGVyc29uMkByZW5lc2FzLmNvbQ0KPiBTdWJqZWN0OiBSRTogW2Np
cC1kZXZdIFtBTk5PVU5DRV0gdjQuMTkuMTQ4LWNpcDM1LXJ0MTUNCj4gDQo+IEhpIFBhdmVsLA0K
PiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFBhdmVsIE1hY2hl
ayBbbWFpbHRvOnBhdmVsQGRlbnguZGVdDQo+ID4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgOCwg
MjAyMCA1OjExIEFNDQo+ID4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah
77yz77y377yj4pev77yh77yj77y0KSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+
DQo+ID4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBwYXZlbEBkZW54LmRlOyBq
YW4ua2lzemthQHNpZW1lbnMuY29tOyBTWi5MaW5AbW94YS5jb207DQo+ID4gYmVuLmh1dGNoaW5n
c0Bjb2RldGhpbmsuY28udWs7IENocmlzLlBhdGVyc29uMkByZW5lc2FzLmNvbQ0KPiA+IFN1Ympl
Y3Q6IFJlOiBbY2lwLWRldl0gW0FOTk9VTkNFXSB2NC4xOS4xNDgtY2lwMzUtcnQxNQ0KPiA+DQo+
ID4gSGkhDQo+ID4NCj4gPiA+IEZZSToNCj4gPiA+ICBodHRwczovL3BhdGNod29yay5vemxhYnMu
b3JnL3Byb2plY3QvbmV0ZGV2L3BhdGNoLzIwMjAwOTIyMDcyOTMxLjIxNDgtMS1nZWVydCtyZW5l
c2FzQGdsaWRlci5iZS8NCj4gPiA+DQo+ID4NCj4gPiBZZXMsIGFuZCB0aGUgcmV2ZXJ0IGlzIG5v
dyBxdWV1ZWQgdG8gNC4xOS1zdGFibGUsIHRvby4NCj4gPg0KPiA+IFNvLi4gd2hhdCBkbyB3ZSB3
YW50IHRvIGRvIGhlcmU/DQo+ID4NCj4gPiBXZSBjYW4gbWVyZ2UgNC4xOS4xNTEgdG8gLWNpcCB3
aGVuIGl0IGlzIHJlbGVhc2VkLCBhbmQgSSBjYW4gdGhlbg0KPiA+IHJlbGVhc2UgbmV3IC1jaXAt
cnQgdGhhdCB3b3JrcyBvbiByZW5lc2FzIGJvYXJkcy4uLg0KPiANCj4gWWVzLCBJIHRoaW5rIHNv
Lg0KPiBQZXJoYXBzIDQuMTkuMTUxIHdpbGwgYmUgcmVsZWFzZWQgdGhpcyB3ZWVrZW5kLiBBbmQg
dGhpcyB3ZWVrIGlzIHRoZSByZWxlYXNlIHdlZWsgb2YgdGhlIENJUCBrZXJuZWwuDQoNClNvcnJ5
LCB0aGlzIG1heSBiZSB3cm9uZy4NCklmIDE1MSBpc24ndCByZWxlYXNlZCB0aGlzIHdlZWtlbmQs
IEknbGwgY2hlcnJ5IHBpY2sgdGhpcyBjb21taXQsIGFuZCByZWxlYXNlIG5ldyBDSVAga2VybmVs
Lg0KDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFi
bGUvbGludXgtc3RhYmxlLXJjLmdpdC9jb21taXQvP2g9bGludXgtNC4xOS55JmlkPTFmYTU4NDhm
YWU0MDk1MTFlZGEyYzZlZTRmOGFkOWU0MmEwY2IzYzENCg0KPiBBbmQgSSB0aGluayB3ZSBjYW4g
dXNlIGl0IHRvIHJlbGVhc2UgdGhlIGNpcC1ydCB0cmVlLg0KPiANCg0KQmVzdCByZWdhcmRzLA0K
ICAgTm9idWhpcm8NCg==

--uZuM4msWQnkoLsUc0CnX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5507): https://lists.cip-project.org/g/cip-dev/message=
/5507
Mute This Topic: https://lists.cip-project.org/mt/77295090/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--uZuM4msWQnkoLsUc0CnX--
