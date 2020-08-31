Return-Path: <SRS0=s/QL=CJ=lists.cip-project.org=bounce+64572+5344+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE13CC433E2
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 23:03:47 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC592071B
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 23:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="oz112fvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC592071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5344+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id A1cDYY4521723xopoiUQrYQ2; Mon, 31 Aug 2020 16:03:46 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.819.1598915024041106390
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Aug 2020 16:03:45 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 07VN3gM3026504; Tue, 1 Sep 2020 08:03:42 +0900
X-Iguazu-Qid: 34tKBCMUDZlAWqgEOC
X-Iguazu-QSIG: v=2; s=0; t=1598915022; q=34tKBCMUDZlAWqgEOC; m=sYUvYNcNGtYvSoQfM4jg4cROOU5yfq9+8v6mlF1JshA=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1510) id 07VN3fXP021333;
	Tue, 1 Sep 2020 08:03:41 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx2.toshiba.co.jp  with ESMTP id 07VN3fJL007980
	for <cip-dev@lists.cip-project.org>; Tue, 1 Sep 2020 08:03:41 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc03.toshiba.co.jp  with ESMTP id 07VN3fws013295
	for <cip-dev@lists.cip-project.org>; Tue, 1 Sep 2020 08:03:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZ/zz1/NQKPfcsjjFrbTJf9gGOiLOwwuFFmK5cYC3SbZeul4MLaXL128OQBT+vHTx4jRA4MrdqtbX6qcvANf5JRIb+qiipojK88uVY/6+wAWhJq6JCWXM/Unuo3Eya6KI/UAsIOytsUs5oF+rCeOCWItbZ0HBiVn4yfSNx+hXw4KdYz4nJ3SZCKRtmYIH6KM0Z2IgKMrUI3uDfPDk6jky9oPp1p7j5S1ymotQOrKhGiA6woqEkgwnsN4N9CMMRwFhMhHuCevOHq2cdbBrC0fsTzmaK+m6MqzBeHETRcvKvr3IgPNrBeXPgIx2gB5Nk+7f2bTtQ8/cAXnNHN3+cbhLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79tSVg2zXUkqKo2DCecZkjIfyyE2wq5Rf2Xa7X2RB6w=;
 b=HhQ57kRhgO2QhAfVw02RRZsSJUUHFEnF8aPgtbTYbqZyRXAo614pTzmxUIjjQDDfojVDhu5vQzmhQNY09cp4+Ds6ZOeKjfr4y70PxUUoldy5fFkpRXfmTUvcxzM7zvtja0gIvFcbEjMy0wh4S/odAvbXJg7x4Qt0wsepK7DrFp3RcxzQ7SlhRFJvvJCmPg5wMgF3FNIGKLN4DIYaMZwFJFuGIjONADIuCs6s3tihoGV28cPKZXt9hd5EG+Ms13FB5vioYHmj+8TPj8OZBbkvW18tTaFoimeMqBt7nr9hHkhkJYdztsdvAaxfuDZPUs6pw0jO8Dl2CuZV45YWWMRATQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH 3/3] linux-cip Switch to gitlab source and update to 4.19.140-cip33
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 3/3] linux-cip Switch to gitlab
 source and update to 4.19.140-cip33
Thread-Index: AQHWf3grHiDtU1kQ6U+QcYRFStuL3qlS1B/Q
Date: Mon, 31 Aug 2020 23:03:39 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983FE1E312CD4BA40B8FDFD92510@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <cover.1598865682.git.jan.kiszka@siemens.com>
 <162be0421d8f27072b2476f95c6d2df9aa09b5f6.1598865682.git.jan.kiszka@siemens.com>
In-Reply-To: <162be0421d8f27072b2476f95c6d2df9aa09b5f6.1598865682.git.jan.kiszka@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5858c6b0-abf4-40ca-c2c6-08d84e021928
x-ms-traffictypediagnostic: OSBPR01MB2070:
x-microsoft-antispam-prvs: <OSBPR01MB2070571BAA37DEDC94EF044192510@OSBPR01MB2070.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XwVK8JsAiezSGUD/3Y95p4zOvLCiVWLq1NpI/elC3nFz1c0wcc2Z48aL3rXVDmGiBA0djK0UN/SEVhdvI2hDzUvepAIV8lAKMVBIFgEUvf2g1fT7SPQNbmbPF9ZTEmVhLvbvV0GZx9Cwafs+mUOt/JChIpQ5HYIE+E9ydB11GDtBT9WCUZGPaxP9Q3XJCwPvNI0GFr+LFVFXbgyvxN1P3ipeRKE2N3gnZjwf0ffUwzhPiyX1Yb8jw4DD9ItL0IVUKm+RhIeKfXJiYx4+NHrQclg8YO0f5WWgTiCHbXPrafQrvWwKIqQ1/2SKHA88aFfd7llU4ERTA9koE1UhWMAxo2F+rJpLwBusHHlACkZRtq7+pWXmMlWYFiBEnFJwVCdZLeV77oGtoMoSkCtM5Kas8Q==
x-ms-exchange-antispam-messagedata: cswmdoQWTrP9WWcRvechZIpbgPqaNj0QvXwFifaNTdR4Hx5q9nQMOm1BnELN9Dl0eIjMCSPTMl/hreVNrds+2lR7pMma1340C1G/TjlUnOBuOYgeOZrrQaHQSvREs0UQV7gJzCbhZD6ClwmxJ7dRbiqP2W4qgSxgFVG42EoBI/wEpQ+17eG1KtW31mMaNjJn07kScWFeZY/vJG4lKZLFVM2Ho0NnisGpJ6ufEYnRPQGydAahLW7qbqAHqoQfi7Gpzr1gtKZEE6AybjlsAcxxMeV5ehp9fD2Xp4hWexofjhvbNDebfPIiZClBmGgNF5LaEN/2ZqMVFkmHbQviaSXE7kx5qM4jTnIKSepk8x8EQB0Ayko4W+0VQm6XF9uP4UPP3+HVSnDP7PhuvNZaYlYNAYzecTtuVGgFRjbQNiQQMwJwP69yrUb37H6Ig1XHG3y4Qm4XwyR6ff9tOYpyXRupGvXm0KiSUPg4owcu5/V66QH/LOzy8EUb/iZG2EiqiZ/xUAICABkK9QGkMRIxxuGoEYdOnXGlPnNRebK/8d5i2bMoDH/j0vjKfCDm6xWQS+Qb0dABpgOh6I5KMSSvGZ0cGAyTqD/ylLaGsT4Xd199WNR+WVHXXrXJ2V+hrRdsj7BfXxVPabo7Mn7uJ/UVZiIKPg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5858c6b0-abf4-40ca-c2c6-08d84e021928
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 23:03:39.1538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 04Ik0j+oyd5435xNdDJ7NK2RPZNcRKIrLKaO2a01ipj7hl77bwNNe/YDMCM8pRwt9dT59ZhFSBAatcGctqwhcl5BeW/YVt7qWxFhFnD4Lw0oyEymPgPuROCYOqSexaOq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2070
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: k98dMwGM7QiL5oXjDvBygfkmx4520388AA=
Content-Type: multipart/mixed; boundary="Kgg7LpHm1vraGgv3bOQI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598915026;
 bh=KPr5RkCEhz/zIFcWUBueblqU2n8avBoxD6xMtLW08Ec=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=oz112fvgDCVskrnkBvX/BKcQ+z6+9TLBapXjt8n/G63VaUQc6yQ9i/Z1TOx5C24mudm
 irnp9G9ZSZHJIpO5Uvxaw+JjKJdDg6M2xEAcnrYaeAidflz7JmEMnmXL7HC6pnzXgj/1W
 S5ipvGLyNVrwDFUgF8Za6I5NfpUbmRg3aiw=

--Kgg7LpHm1vraGgv3bOQI
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIEphbiBLaXN6a2ENCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMzEsIDIwMjAg
NjoyMSBQTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gQ2M6IGl3YW1h
dHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz77y377yj4pev77yh77yj77y0KSA8bm9i
dWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+IFN1YmplY3Q6IFtjaXAtZGV2XSBbaXNh
ci1jaXAtY29yZV1bUEFUQ0ggMy8zXSBsaW51eC1jaXAgU3dpdGNoIHRvIGdpdGxhYiBzb3VyY2Ug
YW5kIHVwZGF0ZSB0byA0LjE5LjE0MC1jaXAzMw0KPiANCj4gRnJvbTogSmFuIEtpc3prYSA8amFu
Lmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gDQo+IFRoZSBzd2l0Y2ggaXMgbmVlZGVkIGFzIGtlcm5l
bC5vcmcgc25hcHNob3QgdGVuZCB0byBmYWlsIHRvbyBvZnRlbi4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IC0tLQ0KPiAgcmVjaXBl
cy1rZXJuZWwvbGludXgvbGludXgtY2lwLWNvbW1vbi5pbmMgICAgICAgICAgICAgICAgICAgICB8
IDQgKysrLQ0KPiAgcmVjaXBlcy1rZXJuZWwvbGludXgvbGludXgtY2lwLXJ0LWNvbW1vbi5pbmMg
ICAgICAgICAgICAgICAgICB8IDIgLS0NCj4gIHJlY2lwZXMta2VybmVsL2xpbnV4L2xpbnV4LWNp
cC1ydF80LjE5LjEzNS1jaXAzMS1ydDEzLmJiICAgICAgfCAyICstDQo+ICByZWNpcGVzLWtlcm5l
bC9saW51eC9saW51eC1jaXAtcnRfNC40LjIzMS1jaXA0Ny1ydDMwLmJiICAgICAgIHwgMiArLQ0K
PiAgLi4uaW51eC1jaXBfNC4xOS4xMzgtY2lwMzIuYmIgPT4gbGludXgtY2lwXzQuMTkuMTQwLWNp
cDMzLmJifSB8IDIgKy0NCj4gIHJlY2lwZXMta2VybmVsL2xpbnV4L2xpbnV4LWNpcF80LjQuMjMw
LWNpcDQ3LmJiICAgICAgICAgICAgICAgfCAyICstDQo+ICA2IGZpbGVzIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gIHJlbmFtZSByZWNpcGVzLWtlcm5lbC9saW51
eC97bGludXgtY2lwXzQuMTkuMTM4LWNpcDMyLmJiID0+IGxpbnV4LWNpcF80LjE5LjE0MC1jaXAz
My5iYn0gKDY3JSkNCj4gDQo+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWtlcm5lbC9saW51eC9saW51
eC1jaXAtY29tbW9uLmluYyBiL3JlY2lwZXMta2VybmVsL2xpbnV4L2xpbnV4LWNpcC1jb21tb24u
aW5jDQo+IGluZGV4IDBjNzY4MzUuLjdlMDkwOTAgMTAwNjQ0DQo+IC0tLSBhL3JlY2lwZXMta2Vy
bmVsL2xpbnV4L2xpbnV4LWNpcC1jb21tb24uaW5jDQo+ICsrKyBiL3JlY2lwZXMta2VybmVsL2xp
bnV4L2xpbnV4LWNpcC1jb21tb24uaW5jDQo+IEBAIC0yMCwxMCArMjAsMTIgQEAgZGVmIGNvbmRp
dGlvbmFsKHZhcmlhYmxlLCBjaGVja3ZhbHVlLCB0cnVldmFsdWUsIGZhbHNldmFsdWUsIGQpOg0K
PiAgcmVxdWlyZSByZWNpcGVzLWtlcm5lbC9saW51eC9saW51eC1jdXN0b20uaW5jDQo+IA0KPiAg
U1JDX1VSSSArPSAiIFwNCj4gLSAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9jaXAvbGludXgtY2lwLmdpdC9zbmFwc2hvdC9saW51eC1jaXAtJHtQVn0u
dGFyLmd6IFwNCj4gKyAgICBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWtlcm5l
bC9saW51eC1jaXAvLS9hcmNoaXZlL3Yke1BWfS9saW51eC1jaXAtdiR7UFZ9LnRhci5neiBcDQoN
CkkgdGhvdWdodCBpdCB3b3VsZCBiZSBnb29kIHRvIHVzZSBhIFVSTCBhcyBhIHZhcmlhYmxlIGFu
ZCBvdmVyd3JpdGUgaXQuDQpJcyBpdCBkaWZmaWN1bHQgYmVjYXVzZSB0aGUgaGFzaCBvZiB0aGUg
ZmlsZSBjaGFuZ2VzIGRlcGVuZGluZyBvbiB0aGUgbWlycm9yPw0KDQo+ICAgICAgIg0KPiANCj4g
IFNSQ19VUklfYXBwZW5kID0gIiAke0Bjb25kaXRpb25hbCgiVVNFX0NJUF9LRVJORUxfQ09ORklH
IiwgIjEiLCBcDQo+IA0KPiAiZ2l0Oi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAta2VybmVs
L2NpcC1rZXJuZWwtY29uZmlnLmdpdDtwcm90b2NvbD1odHRwcztkZXN0c3VmZml4PWNpcC1rZXJu
ZWwtY29uZmlnO25hbWU9Yw0KPiBpcC1rZXJuZWwtY29uZmlnIiwgXA0KPiAgICAgICJmaWxlOi8v
JHtLRVJORUxfREVGQ09ORklHfSIsZCl9Ig0KPiAgU1JDUkVWX2NpcC1rZXJuZWwtY29uZmlnID89
ICJjYTI0ZDk2NWFkZjc3NzMwY2FmMWNkMzJiZGZjZmZkNjllMzY5NTAyIg0KPiArDQo+ICtTID0g
IiR7V09SS0RJUn0vbGludXgtY2lwLXYke1BWfSINCj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMta2Vy
bmVsL2xpbnV4L2xpbnV4LWNpcC1ydC1jb21tb24uaW5jIGIvcmVjaXBlcy1rZXJuZWwvbGludXgv
bGludXgtY2lwLXJ0LWNvbW1vbi5pbmMNCj4gaW5kZXggZDE4MjM1OC4uZGZmYjc3YiAxMDA2NDQN
Cj4gLS0tIGEvcmVjaXBlcy1rZXJuZWwvbGludXgvbGludXgtY2lwLXJ0LWNvbW1vbi5pbmMNCj4g
KysrIGIvcmVjaXBlcy1rZXJuZWwvbGludXgvbGludXgtY2lwLXJ0LWNvbW1vbi5pbmMNCj4gQEAg
LTEzLDggKzEzLDYgQEAgcmVxdWlyZSBsaW51eC1jaXAtY29tbW9uLmluYw0KPiANCj4gIFNSQ19V
UkkgKz0gImZpbGU6Ly9wcmVlbXB0LXJ0LmNmZyINCj4gDQo+IC1TID0gIiR7V09SS0RJUn0vbGlu
dXgtY2lwLSR7UFZ9Ig0KPiAtDQo+ICBkb19wcmVwYXJlX2J1aWxkX3ByZXBlbmQoKSB7DQo+ICAg
ICAgY2F0ICR7V09SS0RJUn0vcHJlZW1wdC1ydC5jZmcgPj4gJHtXT1JLRElSfS8ke0tFUk5FTF9E
RUZDT05GSUd9DQo+ICB9DQo+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWtlcm5lbC9saW51eC9saW51
eC1jaXAtcnRfNC4xOS4xMzUtY2lwMzEtcnQxMy5iYg0KPiBiL3JlY2lwZXMta2VybmVsL2xpbnV4
L2xpbnV4LWNpcC1ydF80LjE5LjEzNS1jaXAzMS1ydDEzLmJiDQo+IGluZGV4IDc0MTRmMjMuLjgy
MGMxYWIgMTAwNjQ0DQo+IC0tLSBhL3JlY2lwZXMta2VybmVsL2xpbnV4L2xpbnV4LWNpcC1ydF80
LjE5LjEzNS1jaXAzMS1ydDEzLmJiDQo+ICsrKyBiL3JlY2lwZXMta2VybmVsL2xpbnV4L2xpbnV4
LWNpcC1ydF80LjE5LjEzNS1jaXAzMS1ydDEzLmJiDQo+IEBAIC0xMSw0ICsxMSw0IEBADQo+IA0K
PiAgcmVxdWlyZSBsaW51eC1jaXAtcnQtY29tbW9uLmluYw0KPiANCj4gLVNSQ19VUklbc2hhMjU2
c3VtXSA9ICIzYzNlNDljNGFkMGRhZTNkZTQwOWQ1MWE1YjhmNmRmMTYzZjdjYzU0MzUwNzY0ZDdj
MDE5NzQxOTQ3YTM4M2RiIg0KPiArU1JDX1VSSVtzaGEyNTZzdW1dID0gImI4MjdmNDViOGY5N2I3
MWIzOTE3Yzg0YjQzZmQ2NTkzMDMwZDAxZWE3MjYxZDNiZTZjMTVhNzYyNTAzMDg3NDMiDQo+IGRp
ZmYgLS1naXQgYS9yZWNpcGVzLWtlcm5lbC9saW51eC9saW51eC1jaXAtcnRfNC40LjIzMS1jaXA0
Ny1ydDMwLmJiDQo+IGIvcmVjaXBlcy1rZXJuZWwvbGludXgvbGludXgtY2lwLXJ0XzQuNC4yMzEt
Y2lwNDctcnQzMC5iYg0KPiBpbmRleCA4ODgxMDcxLi5lMTNmYzE0IDEwMDY0NA0KPiAtLS0gYS9y
ZWNpcGVzLWtlcm5lbC9saW51eC9saW51eC1jaXAtcnRfNC40LjIzMS1jaXA0Ny1ydDMwLmJiDQo+
ICsrKyBiL3JlY2lwZXMta2VybmVsL2xpbnV4L2xpbnV4LWNpcC1ydF80LjQuMjMxLWNpcDQ3LXJ0
MzAuYmINCj4gQEAgLTExLDQgKzExLDQgQEANCj4gDQo+ICByZXF1aXJlIGxpbnV4LWNpcC1ydC1j
b21tb24uaW5jDQo+IA0KPiAtU1JDX1VSSVtzaGEyNTZzdW1dID0gImQxZmY4MzY2NTQ1NTgzMDEy
OWY5YTIxOTcwMDBhYmJlNzQ0MGQzMGUyOWIzNzUwNGM4MjMyNGM3NzdmMGViZjUiDQo+ICtTUkNf
VVJJW3NoYTI1NnN1bV0gPSAiZTdhMGM3YjhlNGQ5MWY1MmNiYzJlZTE3YTU0NmQxYWZiYzVmY2Zl
ZDk1YmE0NGRkMTEzZTUzNGZhYjNhMTU3ZSINCj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMta2VybmVs
L2xpbnV4L2xpbnV4LWNpcF80LjE5LjEzOC1jaXAzMi5iYiBiL3JlY2lwZXMta2VybmVsL2xpbnV4
L2xpbnV4LWNpcF80LjE5LjE0MC1jaXAzMy5iYg0KPiBzaW1pbGFyaXR5IGluZGV4IDY3JQ0KPiBy
ZW5hbWUgZnJvbSByZWNpcGVzLWtlcm5lbC9saW51eC9saW51eC1jaXBfNC4xOS4xMzgtY2lwMzIu
YmINCj4gcmVuYW1lIHRvIHJlY2lwZXMta2VybmVsL2xpbnV4L2xpbnV4LWNpcF80LjE5LjE0MC1j
aXAzMy5iYg0KPiBpbmRleCA1OWFmZDhlLi45ZTk1OGMwIDEwMDY0NA0KPiAtLS0gYS9yZWNpcGVz
LWtlcm5lbC9saW51eC9saW51eC1jaXBfNC4xOS4xMzgtY2lwMzIuYmINCj4gKysrIGIvcmVjaXBl
cy1rZXJuZWwvbGludXgvbGludXgtY2lwXzQuMTkuMTQwLWNpcDMzLmJiDQo+IEBAIC0xMSw0ICsx
MSw0IEBADQo+IA0KPiAgcmVxdWlyZSBsaW51eC1jaXAtY29tbW9uLmluYw0KPiANCj4gLVNSQ19V
Uklbc2hhMjU2c3VtXSA9ICI2YjRkY2UyZmY0OTRiOWE0Y2FiMjEyYWY4NTViNzgwNDg3NTZkYzZl
YTNmMTM2ZTI1NTUyYjBlODMyZTkzZWI2Ig0KPiArU1JDX1VSSVtzaGEyNTZzdW1dID0gImY2YTlh
ZWM2ODQ4YTU4OTdjOTBiYWZkYTVhOWViYTAxMGMwM2Q1ZDBjZjk5NTA4YWRmYjFjZjdhMmY0YWY5
ZTUiDQo+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWtlcm5lbC9saW51eC9saW51eC1jaXBfNC40LjIz
MC1jaXA0Ny5iYiBiL3JlY2lwZXMta2VybmVsL2xpbnV4L2xpbnV4LWNpcF80LjQuMjMwLWNpcDQ3
LmJiDQo+IGluZGV4IDIzMDNkNDkuLmFmNDk0NDEgMTAwNjQ0DQo+IC0tLSBhL3JlY2lwZXMta2Vy
bmVsL2xpbnV4L2xpbnV4LWNpcF80LjQuMjMwLWNpcDQ3LmJiDQo+ICsrKyBiL3JlY2lwZXMta2Vy
bmVsL2xpbnV4L2xpbnV4LWNpcF80LjQuMjMwLWNpcDQ3LmJiDQo+IEBAIC0xMSw0ICsxMSw0IEBA
DQo+IA0KPiAgcmVxdWlyZSBsaW51eC1jaXAtY29tbW9uLmluYw0KPiANCj4gLVNSQ19VUklbc2hh
MjU2c3VtXSA9ICI4ZTkxMzc0ODAxZGE2N2JjMjQwYjA4Y2QwZDYxYTFiNTI4YzIzYzg3MGNmNzNi
YTMzY2M4ZjAyMTk4ZjZjNTMxIg0KPiArU1JDX1VSSVtzaGEyNTZzdW1dID0gIjNmZjMzZTQ5NzA2
NGJhOGU3ZDliNWUxZWU1NzVjNmE5MzYxNTRmYTgyMTY3NzQ3ODJjYmMwZGIyZTRiNzFjZGYiDQo+
IC0tDQo+IDIuMjYuMg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=

--Kgg7LpHm1vraGgv3bOQI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5344): https://lists.cip-project.org/g/cip-dev/message=
/5344
Mute This Topic: https://lists.cip-project.org/mt/76530564/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Kgg7LpHm1vraGgv3bOQI--
