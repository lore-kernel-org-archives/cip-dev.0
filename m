Return-Path: <SRS0=TFWE=CU=lists.cip-project.org=bounce+64572+5447+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937ABC2BC11
	for <cip-dev@archiver.kernel.org>; Fri, 11 Sep 2020 13:10:32 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9FA22285
	for <cip-dev@archiver.kernel.org>; Fri, 11 Sep 2020 13:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="H70rrHRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9FA22285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5447+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TqOwYY4521723xSJwwLelgsn; Fri, 11 Sep 2020 06:10:30 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web12.7604.1599829826951477912
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2020 06:10:28 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 08BDAEkk028429; Fri, 11 Sep 2020 22:10:15 +0900
X-Iguazu-Qid: 2wGrblJYF1IHeu76I6
X-Iguazu-QSIG: v=2; s=0; t=1599829814; q=2wGrblJYF1IHeu76I6; m=q7EtUx8y8og/L6ccijYGP6SXgQe23g2F5g95HpBbRks=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1110) id 08BDAD6l034345;
	Fri, 11 Sep 2020 22:10:13 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 08BDADbI027115;
	Fri, 11 Sep 2020 22:10:13 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 08BDACGO021685;
	Fri, 11 Sep 2020 22:10:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOguvDhrpu0lyCK3lX9UaIcFpiho68runKGhkakj+vgqzabjMNmJOpaClH2fCdmnrdrJdEm/l+DDNDFyEDLuRHZzlen9JtBwnpXcBtmJ7pmfc+Rab2OBVUnXeMea+EN78AOSZ4eSS8SlimDuhlNnm3JHb+FdLRnp0ABankVnUD5WWljvb7BxrCTP4k6rJ4qekVhsYEn9Q8f+BseXUE0Siicx6EGeAdU43OLaqxMhrLSVpwd7TXtJ4tDjRBqdu+KjB8rr1K0PbeAxGny8FQkt6OmgfkbTKlyf20leoFOS/NHZt9Nqy/LXInZG9jwbHUWhPQ2YkClrN2mGYc5hDFUG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJUHfr43d4pHgWsRXvJT8FMlZQWXYCkAYCrQ9/3RRZg=;
 b=KZwCoUcqZqrcNdu5/xJpdY5xrO1w0q3cyA7Dn8Fh0PJ41CkalIPtrHZBcmwSanNmCRJekSKtS1DcCCtYggaYL7J1P1SCt6XK9w6c0076pyEGf5WZlTqerDAuy7kp7YkHwLDvixQFP3xlYVc0fiWQ6CGucQoPHOj+ea4fKQLiYws/M6dqM3ZDQHeOM7BXedmwwBKTV5yQ71MIk1nxvQt/iEY5fWSU5XqIRLEfn+cV7W3ApuM4w10jVQx6t2iI2Xaq8aO/rJzCxV0zuWx9vokwOUF2uQZYFqMVDcu2f6omKoJXlEdfcbLfAorqesZDkC9wa7PmsK2/WJzBfqNzTxivug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/4] Add RZ/G1H Audio support
Thread-Topic: [PATCH 4.4.y-cip 0/4] Add RZ/G1H Audio support
Thread-Index: AQHWiDeS8SrWE1MEMkO0d4fGYaxdyaljZznA
Date: Fri, 11 Sep 2020 13:10:02 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB29901B8A1A5A2E227EF2E8BF92240@TYAPR01MB2990.jpnprd01.prod.outlook.com>
References: <20200911123201.7820-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200911123201.7820-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdb0337f-cae7-4d8e-6fd5-08d85653fe61
x-ms-traffictypediagnostic: TYAPR01MB4864:
x-microsoft-antispam-prvs: <TYAPR01MB486463855C38956505D84DC092240@TYAPR01MB4864.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vp3/Uxzz15g2DFv+tZPipGWbmYuh3k+9TsOsDvnVJy/VozAHvhKSQ7wShBR4njdicSHWW1lzsSYOleA9g7md+4lS+UVqUxxJ+H6LWfBWySB3E2hqo+kA+r5kMDYfA/1rAeJaULFzXWJleQiwazKoHk+xAtD0hjtWlAuHH3CNNv5UR1swWQ2E/FntpL3FEy6njhxFcwuxN8T+M6acqQVp58ZNu6Zfb2xSUaTcz8x0mNU3S2h1aHb34DjriZC52EOI25vWFlfIB4f9L8+6ewgRnnjAWhp+1ap+3GIueEkfZwVYKPfCgRQn0SFaYPk8TLUAqEvc0A3tuA/crxACp52cdDAcc3gsmYN4HmMY0k7gLqXp7z7T6Bn4N+6Mn1ZpQ2I1N7jT20GeMVDTKFRxwlj7Ag==
x-ms-exchange-antispam-messagedata: 6V1qyGvT9Pnyj/ruLXYXKlRhqq4DU7JpxqmO6KXGoRv1ylCPTzdTU8AdNtM+g9/GnwdgMxFH2EbffBcDwgxf1dgqN3vV74w7IiaqJUw/ok/q3Djs3bRlcTN73TutnKZnlpqnKGlVkb0UsCyXmbakrCDAvyYX93zx2/cDIFX4aC15OlMAF/gG8kJmonZjYHqf21cn4mTMfoiTuvUPBK8c9aspfSr2qwrtpVEBGIO+Yqz41erquxX25eQvM84yTMoKdNNVsqADGn231VMm4RwkrUB/Z1oFjaEimxbz3tct2H/opDRNNMGx0h7DYBjn5ecqlZ76T7BNTCUz6JWyEBiAIdWOoycdHu8F/740bnZ+arOyFfWLP0V50e6pss2PIDY4kUB7/UtFLMezrFQrTB7iI5L+wSPfxaeBaCr2dM+xceQUFKLkMv/NTPT/9Dh/YEC9schsHESqfXrUITb6GBGSsAYqMunc/eWhfdLG2xWh5dlMk1kpY3EOhiXgtWteI1r6j+puYeI/nhihH54AEDbjm13yIsWoNTcW6zEgZF6aOKBrx9IpKc6U16w9ArerqlZeOduOHrXNPfP2eh0pSPfjvsdUl0trfoJfGe4BAoGgVXwwyjoQXSAI5i0ABanK/VlvmkEpfb0oeI8iWOOyfC91YQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB2990.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb0337f-cae7-4d8e-6fd5-08d85653fe61
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 13:10:02.2188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWhRtuB6KePqCNCMD9438OV023ce6utkm9PoOaH+NEar3JlL8TmSDm5M8gxj/8mCq6L6RMt8AsRUK/oVStprqjaPx3RI3fGblefhpfP7tQaoD5a1I6TNTut7y0c55q8x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4864
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: utkNjDAgzPZwkhToczPrUA8tx4520388AA=
Content-Type: multipart/mixed; boundary="1XYGhMRXIE2r93qW9iyX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599829830;
 bh=jIh4NVgaE0QNvK3R/BbwtNNlR0/fZD69C0CKzSVms64=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=H70rrHRlbDzyUfEdzoL0nzp5Stxf6kFZvkQHKWyRqb12z7ziIO+Wwbc4yo0lNOnLOM0
 MyHqVPRWRsLaRGP0p33nM8M+q6r5ZB/YGkw1IWQqxoRh7s6Dta163LCusrWbjhb28TN7r
 M3n5rJAQY9g4lC6hj055vpsxVJMUDk94MMc=

--1XYGhMRXIE2r93qW9iyX
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgQmlqdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCaWp1IERh
cyBbbWFpbHRvOmJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tXQ0KPiBTZW50OiBGcmlkYXksIFNl
cHRlbWJlciAxMSwgMjAyMCA5OjMyIFBNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0
Lm9yZzsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHv
vKPvvLQpDQo+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IFBhdmVsIE1hY2hl
ayA8cGF2ZWxAZGVueC5kZT4NCj4gQ2M6IENocmlzIFBhdGVyc29uIDxjaHJpcy5wYXRlcnNvbjJA
cmVuZXNhcy5jb20+OyBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+OyBQcmFi
aGFrYXIgTWFoYWRldiBMYWQNCj4gPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2Fz
LmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDQuNC55LWNpcCAwLzRdIEFkZCBSWi9HMUggQXVkaW8g
c3VwcG9ydA0KPiANCj4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkIGF1ZGlvIHN1cHBvcnQgZm9yIGlX
YXZlIFJaL0cxSCBib2FyZCBiYXNlZCBvbg0KPiByOGE3NzQyIFNvQyB0byA0LjQueS1jaXAga2Vy
bmVsLiBBbGwgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcw0KPiBhcmUgY2hlcnJ5LXBpY2tlZCBmcm9t
IG1haW5saW5lLg0KPiANCj4gTGFkIFByYWJoYWthciAoNCk6DQo+ICAgZHQtYmluZGluZ3M6IEFT
b0M6IHJlbmVzYXMscnNuZDogQWRkIHI4YTc3NDIgc3VwcG9ydA0KPiAgIEFSTTogZHRzOiByOGE3
NzQyOiBBZGQgYXVkaW8gc3VwcG9ydA0KPiAgIEFSTTogZHRzOiByOGE3NzQyLWl3ZzIxZC1xNzog
RW5hYmxlIFNHVEw1MDAwIGF1ZGlvIGNvZGVjDQo+ICAgQVJNOiBkdHM6IHI4YTc3NDItaXdnMjFk
LXE3OiBTb3VuZCBETUEgc3VwcG9ydCB2aWEgRFZDIG9uIERUUw0KPiANCj4gIC4uLi9iaW5kaW5n
cy9zb3VuZC9yZW5lc2FzLHJzbmQudHh0ICAgICAgICAgICB8ICAgMSArDQo+ICBhcmNoL2FybS9i
b290L2R0cy9yOGE3NzQyLWl3ZzIxZC1xNy5kdHMgICAgICAgfCAxMDAgKysrKysrKw0KPiAgYXJj
aC9hcm0vYm9vdC9kdHMvcjhhNzc0Mi5kdHNpICAgICAgICAgICAgICAgIHwgMjcyICsrKysrKysr
KysrKysrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAzNzMgaW5zZXJ0aW9ucygrKQ0KPiANCg0K
SSByZXZpZXdkIHRoaXMgcGF0Y2ggc2VyaWVzLg0KTG9va3MgZ29vZCB0byBtZS4gSWYgSWYgbm8g
b2JqZWN0aW9uLCBJIHdpbGwgYXBwbHkgYW5kIHB1c2ggdGhpcy4NCkFuZCBJIGFtIHRlc3Rpbmcg
b24gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1rZXJuZWwvbGludXgtY2lwLy0v
cGlwZWxpbmVzLzE4ODgyNzIzOS4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K

--1XYGhMRXIE2r93qW9iyX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5447): https://lists.cip-project.org/g/cip-dev/message=
/5447
Mute This Topic: https://lists.cip-project.org/mt/76778357/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--1XYGhMRXIE2r93qW9iyX--
