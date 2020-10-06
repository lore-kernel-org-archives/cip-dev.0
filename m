Return-Path: <SRS0=PfuY=DN=lists.cip-project.org=bounce+64572+5499+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD631C41604
	for <cip-dev@archiver.kernel.org>; Tue,  6 Oct 2020 06:49:51 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC98920757
	for <cip-dev@archiver.kernel.org>; Tue,  6 Oct 2020 06:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="OD/Czoad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC98920757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5499+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NEpFYY4521723xqzYs6vU5t8; Mon, 05 Oct 2020 23:49:50 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.8630.1601966987862666182
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Oct 2020 23:49:49 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 0966nPdD001284; Tue, 6 Oct 2020 15:49:25 +0900
X-Iguazu-Qid: 34trFsjbvlqLCXRtbz
X-Iguazu-QSIG: v=2; s=0; t=1601966965; q=34trFsjbvlqLCXRtbz; m=/ghK1IMM9R5ZjX4+TyP6DQFyxbu3/5XYGNL1XbtWRHw=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1512) id 0966nNmI026793;
	Tue, 6 Oct 2020 15:49:24 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0966nNgq022753;
	Tue, 6 Oct 2020 15:49:23 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0966nMG7005153;
	Tue, 6 Oct 2020 15:49:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2cBh3Ax/l+PyQfoGiwbSS7CZpZsl7KdorELISw8AyYqpK699ya6999k3mkBbYjyxa5J1pFAxEVekOUKVaWXwruWc9TCx5RdFhQ4DiwlmGOLrOAL4IcDwZMw3pwTXIJVM8Ma/4/ExKRGJnEQFiaYX7o6EcTGuKd9HKSWM7JDrCZF04YDh8HDM95CzuYOKcxiICNAyQSRKe7CgZzToOAjjRbli3+ynIO4SymqSkhe6JjwpWvVdwKWSWlI/dRB9piZSpXb6fB0ZpsUzgk6qibIZna1M/WWx07QylLlmk4o9G9pOydHHWx0yIP03saFWVFLxyUwK1If46MhWcCxmzPZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAVRuwOfs36tvzDxH6a9FZR1qHefS7H+xYaFoaj1BM0=;
 b=IrcDq2vJ38dzjumIvqO7RBmrhwI6lLVZzQytst71n/Ukr/HaCdTXzQeDKdQQQNABdMiQ5orZJ8L971Dod7TORs8U5Ejuo+TFwaT05L1W5v88nxlYEwtzMqQ4kGVTE3HD2oQUKtVOg3YQ/aBHC6V11Zs90QkgjeQwZkqtuTG2TaSigdYwkvotI6gAoJYvfFrC1Jl0mv+BvasLc9JadMWPBLrcTafyIP/qaD3+ASNNR7rStA3zsmf01nLnviqtVn+p0LNDiyjMPKIKkSqNfkb8OAQzO0BpVoqwRkYiJMki+zUiv5r9EOTNUY07AT9t6fSSiH4cXm3fyZN4pf+XHX9Siw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <pavel@denx.de>
CC: <jan.kiszka@siemens.com>, <SZ.Lin@moxa.com>,
        <ben.hutchings@codethink.co.uk>, <Chris.Paterson2@renesas.com>
Subject: Re: [cip-dev] [ANNOUNCE] v4.19.148-cip35-rt15
Thread-Topic: [cip-dev] [ANNOUNCE] v4.19.148-cip35-rt15
Thread-Index: AQHWmi3HbeDruN0ZlkG2LoC92+G9x6mH5dqAgAATW4CAAhzRMA==
Date: Tue, 6 Oct 2020 06:49:20 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983C3000BC4BDB86017CC69920D0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201004090653.GA18130@amd>
 <TYAPR01MB23984E9AECF0CDEE4B32B7F1B70F0@TYAPR01MB2398.jpnprd01.prod.outlook.com>
 <20201004213905.GA8065@duo.ucw.cz>
In-Reply-To: <20201004213905.GA8065@duo.ucw.cz>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b08b522d-4d8b-465f-78ae-08d869c3f3f5
x-ms-traffictypediagnostic: OSAPR01MB2417:
x-microsoft-antispam-prvs: <OSAPR01MB2417035824B2D4AC682C458A920D0@OSAPR01MB2417.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KZot9iz47YI6qHjI45P25suMwtPnBImvNDCNGSy2fcEV9HhZNIP/An66DdPhTsXELHbjRRKDdffWVTMQnIbQ9e5NC7VuNqw6Yy168HurX/CG5F8k/8UFNgAZfyZmjYHE0FvTN/iidXSdtYSGpjaBJnkxhUwLD5udGxVtS0xbVrLfhUBsLJuHVazPBwvHQS4MJyuYlyZO3BGIUjct6NGKtmnBgvy6UGq1vAYG3XQg97mRIulcLfmkUVEd0chhod/vlsOluWcKPaIxknDeuWJOm4SiaJiF8JrTNSzu4VunQsEQAIr+QsstyeBnvNSoH1jBLzJ4rvFzNFYgxqlOrC/QPrjUHTy47e5eyhaAewLJRLvi8WSVC9Ou7Niozsf5ndKb7JrIK2zYl34phrV43jIAwg==
x-ms-exchange-antispam-messagedata: EhdAIq6bypBZ39djz9dKmMXBIQtod3LgxUdAdQ0KNl+JaYD/3JLLcgarWL49lOdD54RL9ribmgtCfgaxzXcAw2yIwhmx6mO9HJOaVIKFVmJimmV3pT0+yNaP071fuj+1CrlUCX4g9MEh/3idi10tyQCoWGT9JI0uchW0Q7mJNwcYyJBfLrrsyYYZIXyyWtwwdeAPcNT6qFKt/ktxY1GHhM637hExCGr/Tn/zVblOcpl5BzZFL2LPGnT1hYT4yfREfp7aKH6ltpSdfNXd7NSHS7sYXnMXREYsM/eXsp8EAoKjGEEolhjW4AKZsouxXZ4W/wYBe7tTLm/9n8Kn/aSXkj0btirR4pU1e/hd40xWbyo1e713bPDMd/+A22nMiP4EWkXM/jYFYUJ2ARqfsO2qFa2CSFSKgT5cwXSgVH3+TYe3SLKjm1PtO39f8fhL/hUqQVa4ggIvzQJU0ZbRbEcDDE3mi6ZSFUj89ATZBbUfbCpjCOpVoBL038OcQ1WgL5ZVamGARgCqav0Y6CaVvaJ87qUnqeYBMF/lgwzJ14OkbpgngeOsoANmGkcLfJ0eMEmon66TKR1+FU48agAwO2CunQoeIKR45m+OyHFFvrm+BumBeL4aTRZWnLOcXo/DywyUO/ni0KYEkQN8h4Zu0MOcNw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08b522d-4d8b-465f-78ae-08d869c3f3f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 06:49:20.4985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKkP9nyiImWDb4ojFzmtJEn0/ZoMPeN2KREdjDzbTqGxoZ+5OrRLvEPvktStmgVUKnqJdgkIvxGtZ2mSO4vb9/KdV3MqTx+bujyuVRDInbepOXGKGPnqruV7g+K5C3HM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2417
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ihk1xvKZKzySg8I3YC1fw9MVx4520388AA=
Content-Type: multipart/mixed; boundary="jLyAbqa5Acu7Jf6Vqgdm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601966990;
 bh=zvWGNBHe80oQEwjcfp3SlMeihKr+d+N+56rCtrE5Ii0=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=OD/Czoadgqj6ElVmKvN05iNOZsY9xxl3JDi1bQ97cyJ9nxpPDzX/f0Fxs5O26Gfv6ei
 eL+Hb31KRCejIZpANN1FQMbdqR06zfuE69R5+oRIo30KhJzeDx5uP/FHTzXR7hM8vi5B0
 xLngc3Iz+Ab+4wZK/iONkmszcn26scANcdU=

--jLyAbqa5Acu7Jf6Vqgdm
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNClRoaXMgaXNzdWUgc2VlbXMgdG8gb2NjdXIgcmFuZG9tbHkuDQoNCiMgY2lwK3J0IGtl
cm5lbCANCk5HOiBodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi81NzEy
OQ0KICAgIGh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIvam9iLzU3ODQyDQpP
SzogaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvNTc4NTENCiAgICBo
dHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi81Nzg0MQ0KDQojIDQuMTku
MTQ4K2NpcCBrZXJuZWwNCk5HOiBodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVy
L2pvYi81ODgzNg0KT0s6IGh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIvam9i
LzU4ODM3DQoNCg0KV2UgbWF5IG5lZWQgdG8gY29uZmlybSB0aGVzZSByZWxhdGlvbnNoaXBzIHdp
dGggQ0lQIGtlcm5lbCBwYXRjaGVzLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJv
amVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10gT24gQmVoYWxm
IE9mIFBhdmVsIE1hY2hlaw0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgNSwgMjAyMCA2OjM5IEFN
DQo+IFRvOiBDaHJpcyBQYXRlcnNvbiA8Q2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tPg0KPiBD
YzogUGF2ZWwgTWFjaGVrIDxwYXZlbEBkZW54LmRlPjsgamFuLmtpc3prYUBzaWVtZW5zLmNvbTsg
Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IFNaLkxpbkBtb3hhLmNvbTsNCj4gYmVuLmh1
dGNoaW5nc0Bjb2RldGhpbmsuY28udWsNCj4gU3ViamVjdDogUmU6IFtjaXAtZGV2XSBbQU5OT1VO
Q0VdIHY0LjE5LjE0OC1jaXAzNS1ydDE1DQo+IA0KPiBIaSENCj4gDQo+ID4gPiBOZXcgcmVhbHRp
bWUgdHJlZXMgc2hvdWxkIGJlIGF2YWlsYWJsZSBhdCBrZXJuZWwub3JnLg0KPiA+ID4NCj4gPiA+
IFRyZWVzIGFyZSBhdmFpbGFibGUgYXQNCj4gPiA+DQo+ID4gPiBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jaXAvbGludXgtDQo+ID4gPiBjaXAuZ2l0L2xv
Zy8/aD1saW51eC00LjE5LnktY2lwLXJ0DQo+ID4gPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC9jaXAvbGludXgtDQo+ID4gPiBjaXAuZ2l0L2xvZy8/aD1s
aW51eC00LjE5LnktY2lwLXJ0LXJlYmFzZQ0KPiA+ID4NCj4gPiA+IEFuZCB0aGVpciBjb250ZW50
IHNob3VsZCBiZSBpZGVudGljYWwuDQo+ID4NCj4gPiBUaGFuayB5b3UgZm9yIHRoZSByZWxlYXNl
Lg0KPiA+DQo+ID4gPg0KPiA+ID4gVGhpcyBwYXRjaCBtZXJnZXMgNC4xOS4xNDgtc3RhYmxlIGlu
dG8gLWNpcC1ydCAoYmVjYXVzZSB0aGF0J3Mgd2hhdA0KPiA+ID4gcmVjZW50IC1ydCBpcyBiYXNl
ZCBvbiwgYW5kIG9sZGVyIC1ydCB0cmVlIGlzIHRvbyBvbGQpLiBVbmZvcnR1bmF0ZWx5LA0KPiA+
ID4gdGhhdCBicmluZ3MgcmVncmVzc2lvbiB3aXRoIGV0aGVybmV0IG9uIFJlbmVzYXMgQXJtNjQg
dGFyZ2V0cywgd2hpY2gNCj4gPiA+IHdpbGwgcHJldmVudCBib290LCBhbmQgZmFpbCB0ZXN0cyBl
dGMuDQo+ID4gPg0KPiA+ID4gS2VybmVsIHRoYXQgc2hvdWxkIHdvcmsgb2sgb24gUmVuZXNhcyBB
cm02NCBtYWNoaW5lcyBjYW4gYmUgb2J0YWluZWQNCj4gPiA+IGJ5IHJldmVydGluZyBmYjNhNzgw
ZTdhNzZjZjhlZmIwNTVmODMyMmVjMDM5OTIzY2VlNDFmICJyYXZiOiBGaXhlZCB0bw0KPiA+ID4g
YmUgYWJsZSB0byB1bmxvYWQgbW9kdWxlcyIgb24gdG9wIG9mIC1jaXAtcnQgcmVsZWFzZS4NCj4g
Pg0KPiA+IFNvIHdlJ3JlIHJlbGVhc2luZyBhIEtlcm5lbCB0aGF0IHdlIGtub3cgZG9lc24ndCBi
b290IG9uIG9uZSBvZiBDSVAncyByZWZlcmVuY2UgcGxhdGZvcm1zPw0KPiA+IE9yIGRpZCB5b3Ug
YWxyZWFkeSByZXZlcnQgdGhlIGFib3ZlIHBhdGNoIGFzIHBhcnQgb2YgeW91ciByZWxlYXNlPw0K
PiANCj4gWWVzLCBJIGRpZCB0aGF0LCBhcyB0aGUgY2hhbmdlbG9nIGV4cGxhaW5zLiBTb3JyeS4N
Cj4gDQo+IEkgaGFkIHRvIHNlbGVjdCBmcm9tIGZldyBiYWQgb3B0aW9uczogNC4xOS4xNDctcnQg
cmVsZWFzZSBpcyBub3QNCj4gYXZhaWxhYmxlIGFuZCBwcmV2aW91cyByZWxlYXNlIGlzIHRvbyBv
bGQuIFNvIC1jaXAtcnQgaXMgYmFzZWQgb24NCj4gNC4xOS4xNDgtcnQsIGFuZCBpdCBicmluZ3Mg
aW4gdGhlIGJhZCBjb21taXQuDQo+IA0KPiBJIHRob3VnaHQgYWJvdXQgcmV2ZXJ0aW5nIGl0IGZv
ciByZWxlYXNlLCBidXQgYWxsIEknZCBnZXQgd291bGQgYmUNCj4gcmVqZWN0cywgYXMgaXQgcmVh
bGx5IG5lZWRzIHRvIGJlIHNvbHZlZCBpbiAtY2lwLCBub3QgLWNpcC1ydC4NCj4gDQo+IFByb3Bl
ciBzb2x1dGlvbiBpcyBsaWtlbHkgdXBkYXRpbmcgNC4xOS1jaXAgdG8gNC4xOS4xNDgsIGZpcnN0
LiAgVGhlbg0KPiBmaWd1cmluZyBvdXQgd2hhdCBpcyB0aGUgY2xlYW4gd2F5IHRvIHNvbHZlIHRo
ZSBwcm9ibGVtLCBhbmQgdGhlbg0KPiBjcmVhdGluZyBuZXcgLXJ0IHJlbGVhc2UuIEJ1dCB0aGF0
IHdpbGwgbGlrZWx5IHRha2UgbW9yZSB0aGFuIGZldw0KPiBkYXlzLCBhbmQgaXQgd2lsbCBlbmQg
dXAgd2l0aCBkaWZmZXJlbnQgcmVsZWFzZSBudW1iZXIuDQo+IA0KPiBJIGNhbiBjcmVhdGUgbmV3
IC1jaXAtcnQgcmVsZWFzZSB3aGVuIHRoYXQgaXMgZG9uZS4NCj4gDQo+IEJlc3QgcmVnYXJkcywN
Cj4gCQkJCQkJCQlQYXZlbA0KPiAtLQ0KPiBERU5YIFNvZnR3YXJlIEVuZ2luZWVyaW5nIEdtYkgs
ICAgICAgTWFuYWdpbmcgRGlyZWN0b3I6IFdvbGZnYW5nIERlbmsNCj4gSFJCIDE2NTIzNSBNdW5p
Y2gsIE9mZmljZTogS2lyY2hlbnN0ci41LCBELTgyMTk0IEdyb2ViZW56ZWxsLCBHZXJtYW55DQo=

--jLyAbqa5Acu7Jf6Vqgdm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5499): https://lists.cip-project.org/g/cip-dev/message=
/5499
Mute This Topic: https://lists.cip-project.org/mt/77295090/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--jLyAbqa5Acu7Jf6Vqgdm--
