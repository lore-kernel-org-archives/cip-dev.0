Return-Path: <SRS0=DkPG=7U=lists.cip-project.org=bounce+64572+4730+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA9CC433E0
	for <cip-dev@archiver.kernel.org>; Sun,  7 Jun 2020 23:25:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0B72067B
	for <cip-dev@archiver.kernel.org>; Sun,  7 Jun 2020 23:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="T3kJoZy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0B72067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4730+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HWBiYY4521723xklf8Sz1eXa; Sun, 07 Jun 2020 16:25:33 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.19093.1591572330603205328
 for <cip-dev@lists.cip-project.org>;
 Sun, 07 Jun 2020 16:25:32 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 057NPKJO015154; Mon, 8 Jun 2020 08:25:20 +0900
X-Iguazu-Qid: 34trvY1fGLaMr6atbE
X-Iguazu-QSIG: v=2; s=0; t=1591572320; q=34trvY1fGLaMr6atbE; m=B0U/TPzQYHB/XxQQKFEOJ97rSWy+F3lAteernw8GovQ=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1512) id 057NPJ8j021892;
	Mon, 8 Jun 2020 08:25:19 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 057NPJun018263;
	Mon, 8 Jun 2020 08:25:19 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 057NPIr4020684;
	Mon, 8 Jun 2020 08:25:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSx3wppODQaZlwwHyPQigjkfdrh4Qiya959f+yamLvMxGw4KLmMLjVSyeS73gW0fYWQmY4K6ygPd3yTOO5AIZL34qZ+cVwQoEmavCCLlcGPvozqwenBA9KUwr2NrhOFumcvI1ax1wn/1NjjiXlNfyjb5OyvkPDrpvPCoF9SaCrtezW3evWeEBRbWncy1s06DJNQuJT4DKt+ErA56VQw5wTVOj9XiL7BoFBXgP4gtQj4kDcKhRRLLmUFCBEAFoBD65Dhcd5pyJYjX4U1MC3f7aTbExQ8FvtQQwTNB6cxxqD9kFGpOF947GPgc91AFZ/4uqB+mWTgEC9d6H1m2MZWyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwNRFpTxUPpNz+Ftq8+qHHRVDI88eldMC8057aRf/2c=;
 b=XZy0WJafwo8N1LgxBxaOgk4sJ3QP1KuB+S+0bUaij2lzl8OcRu3LUWUsQfxuaynnYHjoIeWW2kf9X9Jd/m/7pScWmncD9UT/1NiOACppWGuf53+Xr83nXW9cuHlaSMUSjVYY2/m4wv9fkgASi46L1GCXncdbbL9C586Ca10TPaQh91wgczm0D1MMb+IQopSLP0CfBUFPXTWaPEepj3Sm0lD+jnUjCtR6yKam8iczGTcgB8pSpfH5PlX+E25m30BgkKaDsj/ZfoVCcQkE8BOURdov88OeKvUIaLeSlJJ4XmGVNXLVROSYyf5vIDZZ4r6PtD+DipFl2J3Z4AAbok1rbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <JohnsonCH.Chen@moxa.com>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][PATCH 4.4.y-cip 0/2] Add dts for Moxa UC-8100-ME-T platform
Thread-Topic: [cip-dev][PATCH 4.4.y-cip 0/2] Add dts for Moxa UC-8100-ME-T
 platform
Thread-Index: AdY7G2A7nn/CzWtOQAm/F+wBzLjLgQACmtiAAH86ABA=
Date: Sun, 7 Jun 2020 23:25:12 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983760B355EE8ACEE31252092840@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <HK2PR01MB32816DED0D73E7481744817CFA860@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <20200605104057.GA26010@duo.ucw.cz>
In-Reply-To: <20200605104057.GA26010@duo.ucw.cz>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62e251e8-2283-4b6f-fece-08d80b3a0863
x-ms-traffictypediagnostic: OSBPR01MB4199:
x-microsoft-antispam-prvs: <OSBPR01MB4199EECF1C1191435728285692840@OSBPR01MB4199.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ORAvjW6j92PVReIYcDAyYFJTvjdRQNmr5hcsbbW8IRMIZp9SC0us4C/jI7aF3qSdqLcxsoCWenmyrhznGDjcUNcwcPU0QDfIgtqWi0AYtyLcNyncj3wsOkzJjheWeAQ+KejBi9ITOt2QYSuBr/zA14sA0aOyUIOf5Ngp36HN8MRohGPZ+V2dvRlYMwMgZOxKGbqPgIzzP1p/uqw80/RqE0cd3hzp1cuQu8X0rb3SSCEjKmoDTvzHQckTkU4M94OtoS04maWN8pnJKqJODxZwJYuYExPiumuGuDWcw3Pxk8UyUfMzNjqultcN5JU86LdC7Gwdj87BceALEQG01IwNQg==
x-ms-exchange-antispam-messagedata: Fe0BG5+le/llGlneTSPz3KUfDOgb7n6xfkZJu/b9Z4HRy8sIU0UFRO7d+BbFiD5rNL1env1DDxg96/Zlh8gE3EGq5akwcH5U6jFOwpjCLgFQMMmOFeUQF16UdbkFrGjrMmCqu6g4WEBMQUEXkt8+TMUIb+cfZG11t4dy0Elv+9aXa68XUEli9+r67CzPFnchiDKjmp/9Anwml84t6RUsASvlnQ2eVi788ktuUn5C5pBJ6ZlYI93ewbmIThhLjfvWupF1R/9obsxOi8j9j/8+dYPAJAwVqh1PQ/yrnOVOMEi1vJtAMCiJqVJ9I1f1GG3GKMzPbUm7KAUpavN4OI1X62GZTbllVI1djNRCA740xk1fIdE/KcBsdK78k/gf/CT8V9bRJCqgC5UWKqKKW31A0tC4kLE8RSzIHlwxFBTDjH0l4Kxah7hjOxdk0651E7OWCGK0VEmMiHd97Hq8vFOMxN4+Hunvky2TEQvdt5GN0pQ=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e251e8-2283-4b6f-fece-08d80b3a0863
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2020 23:25:14.5457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +pTNeXEe2zOmLLWSTAKubTdlw9KBGBQg3MQl4KJCgLGCOnbL/IzJETa+NafLZdiMEbcJexl5L6JVskTrM3kL4a4SJKdaKaNPBQtOegp3e2YF6k97II3QWF7ietjveIAU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4199
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KlCLqowr4GiboTHMs6A3eevQx4520388AA=
Content-Type: multipart/mixed; boundary="kL3MdTA90OKLwGlKzeE5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591572333;
 bh=zmwIv9vfqEV/fKPmS+qe4YfWLGSWqOTxsrsuy5Khyxw=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=T3kJoZy80j6aw6HYB8x5QbNwpoteBr6EdTBKsHleS6juAZp4+yn8jB6KU2omVt07yYG
 D93eH8uzgKxBdULwvAEA0332KJnEmuGbWvCagI8wmEiX+KKyoCXzOnFXsfAn7aFL8ZkHu
 EuR47uRdoliPVAUJ/S/E2drBqI1IuwoTfI0=

--kL3MdTA90OKLwGlKzeE5
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwgTWFjaGVr
IFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gU2VudDogRnJpZGF5LCBKdW5lIDUsIDIwMjAgNzo0
MSBQTQ0KPiBUbzogSm9obnNvbiBDSCBDaGVuICjpmbPmmK3li7MpIDxKb2huc29uQ0guQ2hlbkBt
b3hhLmNvbT4NCj4gQ2M6IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz77y3
77yj4pev77yh77yj77y0KSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+OyBwYXZl
bEBkZW54LmRlOw0KPiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBS
ZTogW2NpcC1kZXZdW1BBVENIIDQuNC55LWNpcCAwLzJdIEFkZCBkdHMgZm9yIE1veGEgVUMtODEw
MC1NRS1UIHBsYXRmb3JtDQo+IA0KPiBIaSENCj4gDQo+ID4gTU9YQSBVQy04MTAwLU1FLVQgaXMg
YnVpbHQgYXJvdW5kIGEgQ29ydGV4LUE4IHByb2Nlc3NvciBmb3IgVEkgQU0zMzV4LA0KPiA+IGFu
ZCBpdCdzIGRlc2lnbmVkIGZvciBlbWJlZGRlZCBkYXRhIGFjcXVpc2l0aW9uIGFwcGxpY2F0aW9u
LiBIZXJlIHdlIGFkZA0KPiA+IHRoZSBkZXZpY2UgdHJlZSBhbTMzNXgtbW94YS11Yy04MTAwLW1l
LXQuZHRzLiBCZXNpZGVzLCBhbHNvIGFkZCBuZXcgRFQNCj4gPiBiaW5kaW5nIGZvciB0aGUgZURN
QTMgYmVjYXVzZSBmdW5jdGlvbiBvZiBlZG1hIGNyb3NzYmFyIGlzIHVzZWQgaW4NCj4gPiBVQy04
MTAwLU1FLVQsIGFuZCBtZW1vcnkgaXMgc2FmZSBmb3Igd2l0aCB0aGUgbmV3IGJpbmRpbmcuDQo+
ID4NCj4gPiAxLiBVc2UgdGhlIG5ldyBiaW5kaW5nIGZvciBlRE1BMyBvZiBhbTMzeHguDQo+ID4g
Mi4gQWRkIGR0cyBmb3IgTU9YQSBVQy04MTAwLU1FLVQNCj4gPg0KPiA+IEl0J3MgdGVzdGVkIHdp
dGggYSBNT1hBIFVDLTgxMDAtTUUtVCBwbGF0Zm9ybS4NCj4gDQo+IFNvIHRoaXMgaXMgcmVsYXRp
dmVseSBzaW1wbGUsIGFzIGl0IG9ubHkgYWZmZWN0cyBNb3hhIGNvZGUuIEFuZCBJIHNlZQ0KPiBu
b3RoaW5nIHdyb25nIHRoZXJlLg0KPiANCj4gSSdsbCBhcHBseSBpdCBpZiB0aGVyZSBhcmUgbm8g
b3RoZXIgY29tbWVudHMuDQoNCkkgcmV2aWV3ZWQgdGhpcyBwYXRjaCwgdGhlcmUgd2FzIG5vIHdy
b25nLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCg==

--kL3MdTA90OKLwGlKzeE5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4730): https://lists.cip-project.org/g/cip-dev/message=
/4730
Mute This Topic: https://lists.cip-project.org/mt/74689396/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--kL3MdTA90OKLwGlKzeE5--
