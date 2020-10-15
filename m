Return-Path: <SRS0=lGqM=DW=lists.cip-project.org=bounce+64572+5580+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16905C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 15 Oct 2020 16:18:44 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D454122210
	for <cip-dev@archiver.kernel.org>; Thu, 15 Oct 2020 16:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="qq1bIYA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D454122210
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5580+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id A7U1YY4521723xl9PvpDdQ0i; Thu, 15 Oct 2020 09:18:42 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.117])
 by mx.groups.io with SMTP id smtpd.web10.16398.1602778719577572283
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Oct 2020 09:18:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmOxPeFc1V0cdrIWRCEVJmQvTYE/jGK1IUi1S71oNgYTA4lMO7EkHlFl2DpEgKV6mtxJCRK76Nb3Yqp7CkcG75PKTucMCw/UZ/sQ9TkNRZZirX88gOYkrFt/QSYujdWVrsbFojAmuSHlD1GB/Yf/w8ZuMIhLyKvgkNgJYY2Z8c62S+JIshtibdDcSRPEct+HbiSjsgdIKUq+CI+JR+dwZrvhl9Tc+yOWwJGooo08w4ssYTXyGj0VnNKAOIB9E+uudh9bFe5mbr8qa/KGKrdnujK6lK8xzr5ie5m4xz7BKHSjsNVt2ldt0848N6mGbc16HYtziKXVhSpOR8iFMPn0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XQaQs7YERHTh2g1j5K7RxqoDtmzTU2LBZhaUggSGig=;
 b=h2lmEPMJUK94cfBG6UWe2wIQdGlMM4y2pG0/EGhdMTHWyFEcgTVNQH4L0QLGZSKz+syPFhBsQqD1l1ND+QitFXldw6sR49ZMKo+kD6qFIu6W+l56a+V8FbnKm8EyX02bvQQX7OEX+nSwa3eQ7H/H7LwcBHT6tuj3/JbHDkAhKLSmWOg38FewqULtMyHsNvImww6BAvJ3KGwB4dTS6nYcjqHmloe7sv7G99m7vek0dlY6hZN6VXqTl99uNsM3j5Eyp1/mtx5aPdYd5bKzMRtVE7nUa53tT8a62XgZ438D4s5VPBWkdea4mbLMDs6n2Be/SiUW4plX5Erab/7eNAz+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB3863.jpnprd01.prod.outlook.com (2603:1096:604:45::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Thu, 15 Oct
 2020 16:18:36 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::cdbe:6988:b51c:51a3]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::cdbe:6988:b51c:51a3%6]) with mapi id 15.20.3455.035; Thu, 15 Oct 2020
 16:18:35 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek
	<pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] If you are using PCIe EP, speak up was Re: [RFC PATCH 4.19.y-cip 00/50] Add PCIe EP support for Renesas R-Car Gen3 and RZ/G2x
Thread-Topic: [cip-dev] If you are using PCIe EP, speak up was Re: [RFC PATCH
 4.19.y-cip 00/50] Add PCIe EP support for Renesas R-Car Gen3 and RZ/G2x
Thread-Index: AQHWoKK3exH1hEUZukOZtIVkSqUhZ6mW2nsAgAH+7dA=
Date: Thu, 15 Oct 2020 16:18:35 +0000
Message-ID: 
 <OSBPR01MB5048E2D4FD58D32BAF1A5524AA020@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201014093914.GB1866@amd>
In-Reply-To: <20201014093914.GB1866@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5888996a-c29e-4471-32df-08d87125f7d0
x-ms-traffictypediagnostic: OSBPR01MB3863:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB3863C7DAD600C0C054AA4E8DAA020@OSBPR01MB3863.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 Ph6W7DWKkB0NsDl8k0l2VgGWOVf1lrxA1TB0EG2Jqrb5s4N+58ZbyzfF12JKFZ4un7B2XWSEegIhjbfe/ldqoYXsXxqe6EiLvnWtnaiZVqbDIj5imakfIW8ZfxL1wLDnFotepT9IZeWnrRgOx2kaFIAHkjnVAw4Jz3zJj+MnL9oLEi6exEPei+XXrckHhtlLXmwrn5TxOIb0LmVrvoISK2tkPpt6Qh6Ks9Iwe6pv5X/YXNmoyxthcfDFSF0xbJAW3UKqOfjBv3zDgR2ZgBSWcV/S6xCCEbsY6E3+cw+UCMRG09E+mLBP2+jV2pYDsvk7PNOCDGZ3KExsJwm1j7FG5A==
x-ms-exchange-antispam-messagedata: 
 AhFg9CmqnDX+cV+wondpP6OWgyLCSrxBaKoONsGNMF/Z76b0wO3J3s1/y26d8TBMC9oHntIZ6T2f7lMLhH9IyOJh2zi5Rlrr1DM49v28W6fzKVoDVzLlf85WZ4taLN7GOMrYmPAueh/XBfdAczzxlbtiL/7bLL7ZHSzWBDfsvSgtM1rwxOECVeyiYBR8wYSa4qw3N1Jp7XNJ20UzZylH9WChblY+L9TxAHv/h0tI9tqp7Hk/+TCRo9ZJ/5WyiDu11yEV0wQH1BN3V7c4aD4hVhGc4PQwSFUU+N8Xh2wjtPYkq3yrclYfvs6gqZPQPET/yT7IeM2pXkZ5lsRwdUsJGVcuvNCOuNrCFfsb+IYSid310HO2oYGHm1ZKiAFUtcmmuWoZ4SMIEmCVYZSaUTx6uSWcgTKzI1DswZy4K9U5A1vqrd7rdqpdLa+NpkDKkydzrnB4pAy9F2yKYsbcMTjs44fGLl0hQxka97fwbrIwZKtTRg3n8SHZlyjyDweX0Bbn8gt3wZI2HYbEUf/eElK3bMEGKw0O0y6jtGl4Jvpja2WxOgkNy+rew5eMzAQagrInFNUCZvSKulgDcUcam5njz/Ia4k2O1tJ+hb5eS2zxyL9xxWGgb4jxKn2OblN4CQkIVldSgCGJHkQzWv5RUNeCsQ==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5888996a-c29e-4471-32df-08d87125f7d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 16:18:35.6221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /WrQxSKeEDcLx5lmQAKba0uebt8blmUPM82AF3Y19ZSYU6/Y6qZbqYHYVGn8CY6lyFtRPWyQgdsCoyMybLLBgliJUMp9ab3tXdyNe5lllP3J4UGDQDL802T2aTigF0Un
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3863
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XUbITB32VfyJKWcbGEb0wx8Mx4520388AA=
Content-Type: multipart/mixed; boundary="AO2lHqh7hKRRSEHF2u7u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602778722;
 bh=zrPopb/7MsY6iic56dZS5SZcEzulBtcH/18djXK6YWE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=qq1bIYA/Lwj3ue9XnzXmQWzIOqaC/cHiKmQXQ34UI5O1IWx8zgXZSaHKLJYuZzH4A8y
 xvheCQyXXu80whqIM5StT4F7WaphqFvj2fD7h4fokzVcBpgR1NqGk+fg+guKdtdQKVQ4I
 qg5cx8VXxM5YuwWSfKXGvicCCUlml2lojNI=

--AO2lHqh7hKRRSEHF2u7u
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUGF2ZWwsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBP
biBCZWhhbGYgT2YgUGF2ZWwgTWFjaGVrIHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU2Vu
dDogMTQgT2N0b2JlciAyMDIwIDEwOjM5DQo+IFRvOiBQcmFiaGFrYXIgTWFoYWRldiBMYWQgPHBy
YWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gQ2M6IGNpcC1kZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnOyBOb2J1aGlybyBJd2FtYXRzdSA8bm9idWhpcm8xLml3YW1hdHN1
QHRvc2hpYmEuY28uanA+OyBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+OyBCaWp1IERhcw0K
PiA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFtjaXAtZGV2XSBJZiB5
b3UgYXJlIHVzaW5nIFBDSWUgRVAsIHNwZWFrIHVwIHdhcyBSZTogW1JGQyBQQVRDSCA0LjE5Lnkt
Y2lwIDAwLzUwXSBBZGQgUENJZSBFUCBzdXBwb3J0IGZvciBSZW5lc2FzIFItQ2FyIEdlbjMgYW5k
DQo+IFJaL0cyeA0KPg0KPiBIaSENCj4NCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBhZGRzIHN1cHBv
cnQgZm9yIFBDSWUgRVAgb24gUmVuZXNhcyBSLUNhciBHZW4zIGFuZA0KPiA+IFJaL0cyeCBwbGF0
Zm9ybXMuDQo+DQo+IEkgcXVpY2tseSB3ZW50IHRocm91Z2ggYSBzZXJpZXMgYW5kIGNvZGUgc2Vl
bXMgcmVhc29uYWJseSBuaWNlLg0KPg0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3LiBUaGF04oCZ
cyBhIHJlbGllZiDwn5iKDQoNCj4gPiAqIFNpbmNlIHRoZSBjaGFuZ2VzIGFyZSBodWdlIEkgYW0g
c2VuZGluZyB0aGUgcGF0Y2hlcyBhcyBSRkMuDQo+DQo+IEFuZCB5ZXMsIGl0IGlzIHF1aXRlIGJp
Zywgd2hpY2ggbWlnaHQgYmUgYSBwcm9ibGVtLiBPVE9IIG9ubHkgUmVuZXNhcw0KPiBzZWVtcyB0
byBoYXZlIFBDSWUgRVAgZHJpdmVycyBlbmFibGVkIGluIHRoZWlyIENJUCBkZWZjb25maWdzLCBz
bw0KPiB0aGVyZSdzIGdvb2QgY2hhbmNlIG5vb25lIGVsc2UgaW4gQ0lQIHByb2plY3QgaXMgdXNp
bmcgdGhpcyBjb2RlLg0KPg0KRmluZ2VycyBjcm9zc2VkLg0KDQo+IFtJZiBzb21lb25lIGVsc2Ug
X2lzXyB1c2luZyBpdCBvciBpcyBjb25zaWRlcmluZyB1c2luZyBpdCwgcGxlYXNlDQo+IHNwZWFr
IHVwLl0NCj4NCj4gQ291bGQgd2UgZ2V0IGJldHRlciBleHBsYW5hdGlvbiBmb3IgMjQvIG9mIHRo
ZSBzZXJpZXM/IHNwaW5sb2NrIGlzDQo+IG9rYXkgYXMgbG9uZyBhcyBjb2RlIGluc2lkZSBkb2Vz
IG5vdCBzbGVlcCwgZG9lcyBub3QgbmVjY2Vzc2FyaWx5IGhhdmUNCj4gdG8gZG8gd2l0aCBpbnRl
cnJ1cHRzLg0KPg0KU3VyZSB0aGlzIHdhcyBjaGVycnkgcGlja2VkIGZyb20gdXBzdHJlYW0gSSBo
YXZlbuKAmXQgbW9kaWZpZWQgdGhlIGRlc2NyaXB0aW9uLiBNb3Jlb3ZlciB0aGlzIEkgaGFkIGlu
Y2x1ZGUgYmVjYXVzZSB0aGUgc3Vic2VxdWVudCBwYXRjaGVzIGNvdWxkIGFwcGx5IGNsZWFubHku
DQoNCkRvIHdhbnQgbWUgdG8ganVzdCBlbGFib3JhdGUgdGhlIGNvbW1pdCBtZXNzYWdlIHlvdSBt
ZWFuID8NCg0KPiBTaG91bGQgMzAvIGFuZCAzMS8gYmUgc3VibWl0dGVkIHRvIHN0YWJsZT8NCj4N
ClllcyBJIGRvIGFncmVlLg0KDQo+ID4gKiBSZXF1aXJlZCBFUCBmcmFtZXdvcmsgY2hhbmdlcyBh
bmQgZml4ZXMgYXJlIHBvcnRlZCBhcyB3ZWxsLg0KPiA+ICogQWxsIHRoZSBwYXRjaGVzIGhhdmUg
YmVlbiBjaGVlcnkgcGlja2VkIGZyb20gdXBzdHJlYW0ga2VybmVsLg0KPiA+ICogUGF0Y2hlcyBb
NDMsIDQ0LCA0NSwgNDYsIDQ4XS81MCBhcmUgcGlja2VkIGZyb20gbGludXgtbmV4dC4NCj4NCj4g
T2ssIHNvIHdlIGRlZmluaXRlbHkgd2FudCB0aGVtIGluIHVwc3RyZWFtLCBub3QgaW4gLW5leHQu
IEFuZCBpdCBtaWdodA0KPiBiZSBnb29kIHRvIHdhaXQgYSBiaXQgYWZ0ZXIgbWVyZ2UsIHNvIGl0
IGdldHMgc29tZSB0ZXN0aW5nIGluIHVwc3RyZWFtLg0KPg0KU3VyZSBJbGwgd2FpdCBmb3IgdGhl
bSwgKGZ5aSB0aGVzZSBhcmUganVzdCBkdCBiaW5kaW5nIGRvY3VtZW50YXRpb24gYW5kIFBDSS1J
RCBhZGRpdGlvbiBwYXRjaGVzKQ0KDQo+ID4gKiBJIHdhcyBza2VwdGljIHdpdGggcGF0Y2ggMzYv
NTAgIlJlbmFtZSBwY2llLXJjYXIuYyB0byBwY2llLXJjYXItaG9zdC5jIg0KPiA+ICAgdGhpcyBp
cyByZXF1aXJlZCBhcyBwYXRjaCAzOC81MCBhZGRzIGEgbmV3IGZpbGUgbmFtZWQgcGNpZS1yY2Fy
LmMuIE9wZW4NCj4gPiAgIGZvciBzdWdnZXN0aW9ucyBpZiB0aGlzIGNhbiBiZSBoYW5kbGVkIGRp
ZmZlcmVudGx5Lg0KPiA+ICogSW4gcGF0Y2ggMzcvNDggSSBoYXZlIGRyb3BwZWQgdGhlIGNoYW5n
ZXMgZm9yIGhvc3QgZHJpdmVyIGFzIHRoZSBwYXRjaA0KPiA+ICAgZG9lc24ndCBhcHBseSBjbGVh
bmx5IGFuZCBtYW51YWxseSBhcHBseWluZyBpdCB3YXMgcmVzdWx0aW5nIGluIGENCj4gPiAgIGJp
ZyBkaWZmLg0KPg0KPiBMZXQgbWUgdGFrZSBhIGxvb2sgYXQgdGhlc2UgaW4gYmlnZ2VyIGRldGFp
bC4NCj4NClN1cmUuDQoNCj4gPiAqIEFzIHRoZSBjaGFuZ2VzIHRvdWNoZXMgdGhyZWUgb3RoZXIg
Y29udHJvbGxlciBkcml2ZXJzIEkgaGF2ZSBidWlsZCB0ZXN0ZWQgdGhlbQ0KPiA+ICAgYXMgZG9u
ZSBzaW1pbGFybHkgd2hpbGUgdXBzdHJlYW1pbmcgUi1DYXIgR2VuMyBQQ0llIEVQIGRyaXZlci4N
Cj4NCj4gV2lsbCB0aGlzIGJlIHRlc3RlZCBzb21laG93IGJ5IG91ciBhdXRvbWF0ZWQgdGVzdHM/
DQo+DQpZb3UgbWVhbiB0aGUgUi1DYXIgR2VuMyBQQ0llIEVQIGRyaXZlciA/DQoNCkNoZWVycywN
ClByYWJoYWthcg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gUGF2ZWwNCj4gLS0NCj4gREVOWCBTb2Z0
d2FyZSBFbmdpbmVlcmluZyBHbWJILCAgICAgIE1hbmFnaW5nIERpcmVjdG9yOiBXb2xmZ2FuZyBE
ZW5rDQo+IEhSQiAxNjUyMzUgTXVuaWNoLCBPZmZpY2U6IEtpcmNoZW5zdHIuNSwgRC04MjE5NCBH
cm9lYmVuemVsbCwgR2VybWFueQ0KDQoNClJlbmVzYXMgRWxlY3Ryb25pY3MgRXVyb3BlIEdtYkgs
IEdlc2NoYWVmdHNmdWVocmVyL1ByZXNpZGVudDogQ2Fyc3RlbiBKYXVjaCwgU2l0eiBkZXIgR2Vz
ZWxsc2NoYWZ0L1JlZ2lzdGVyZWQgb2ZmaWNlOiBEdWVzc2VsZG9yZiwgQXJjYWRpYXN0cmFzc2Ug
MTAsIDQwNDcyIER1ZXNzZWxkb3JmLCBHZXJtYW55LCBIYW5kZWxzcmVnaXN0ZXIvQ29tbWVyY2lh
bCBSZWdpc3RlcjogRHVlc3NlbGRvcmYsIEhSQiAzNzA4IFVTdC1JRE5yLi9UYXggaWRlbnRpZmlj
YXRpb24gbm8uOiBERSAxMTkzNTM0MDYgV0VFRS1SZWcuLU5yLi9XRUVFIHJlZy4gbm8uOiBERSAx
NDk3ODY0Nw0K

--AO2lHqh7hKRRSEHF2u7u
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5580): https://lists.cip-project.org/g/cip-dev/message=
/5580
Mute This Topic: https://lists.cip-project.org/mt/77501866/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--AO2lHqh7hKRRSEHF2u7u--
