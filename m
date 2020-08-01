Return-Path: <SRS0=80T1=BN=lists.cip-project.org=bounce+64572+5080+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31D2C433DF
	for <cip-dev@archiver.kernel.org>; Mon,  3 Aug 2020 11:27:57 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427D32076B
	for <cip-dev@archiver.kernel.org>; Mon,  3 Aug 2020 11:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="c+9pdHAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427D32076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5080+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 87PYYY4521723xyqBSjol7U3; Mon, 03 Aug 2020 04:27:57 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.119])
 by mx.groups.io with SMTP id smtpd.web12.7699.1596275743803732831
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2020 02:55:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6IQVYMyI5yaSWexWGWRvwLeKZ+iy/i0Om+0jHvruzDMhJLWxCDIwg5jNaUqP1t61YVovAX8IcrGlWyYh/ZpC+u/QjIfX7u2g9dHSZIl5WLqij4T3BV9TMLIHXwlZ3q+lxEhykH06yIFord4IPiw2y6QN7325bcyi6WGNZk1a6IGHVqenWgvFJfMrRJRPgqAq7N+S8C1BN9oviNNanix8cau3uQLNYmp+8um3/yKBwC8cV6cQmasuGXxVGbVhpxtRdGXL2NbhVVlAcM65KEOTN5cRpC6OAOKik945StXxY1GPVRYSKc0x/xETEshCxDxmfkQQxDv0Tuujt8nKsYE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4IJYTfmTEHjGGhKfQ92Q5fa+V8OwSD3r1MSZDNziUg=;
 b=DCjWrZLqtGbNZZdtmmmWsLIA9iqq+b4qBlE8Jp2Y7dyrcCveOgwLfF/qKwUTuoJQC0+6XjMBIvEtyyyYi3Wb5H/vnNViJGWBzvg50ZmbI+HvEmrXJFNlrwiBAjJ5zqGCs31mp8/hzQwAA48zouZBPo4XXd0U8EKVngww46rjWOLVnBcAfIM7KzV0SV2X0viYYZjNnPabGs4DosPfb8JYpta5VD/SH2TGMvTTZcPEWaRfpiJ1E+tHD6cSvnZxGVLYadNuh/wvtk71VjFaFQyl9RoQ4gQpX9tl40QSMdXmZmPpX3k3LB/IJURKuMUhZtsAi3l+2Em/76Y0MJFQfLFuCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TYAPR01MB2093.jpnprd01.prod.outlook.com
 (2603:1096:404:8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Sat, 1 Aug
 2020 09:55:39 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee%7]) with mapi id 15.20.3239.020; Sat, 1 Aug 2020
 09:55:39 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Enable touchscreen
Thread-Topic: [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Enable touchscreen
Thread-Index: AQHWZZbnsBKZiSmbzk29U0spVTxALqkfUcEAgABhkJCAAmzwAIAA5+og
Date: Sat, 1 Aug 2020 09:55:39 +0000
Message-ID: 
 <TYBPR01MB530995FF767174D9F1C083AF864F0@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <20200729105621.8242-1-biju.das.jz@bp.renesas.com>
 <OSBPR01MB2983E426B309BE9BA68FAC3392710@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <TYBPR01MB5309707BB448C3DE7D5F282686710@TYBPR01MB5309.jpnprd01.prod.outlook.com>
 <OSBPR01MB2983E85BDA4101EF8C01318A924E0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB2983E85BDA4101EF8C01318A924E0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [31.49.74.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4df2ddf-2e10-419e-3abe-08d836010be7
x-ms-traffictypediagnostic: TYAPR01MB2093:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TYAPR01MB2093F5A3BE1119999E239B5F864F0@TYAPR01MB2093.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 OS4PTbs6pdfW368MbL53Zjp7EuaPyYf3uzRsQEYaCAKEEh5qztpi5/4UaRREYcfvO2mWsLjxVF4vjNtFg4hcN++XIb5mHsSS+HFjchQSDB7V5xbnNvAFhNS9pwSVgm0Nq1XT3OuMqpMK5MJE/m5ux2sfGGbD4Rho8sEvRGPcsh1hpLGrCZDE32Thw+XuCYYcw38w1KqXemURIJgPY0xOxD94JkZUt8RVYOAZ0dCSVdrx+Ti9LQZrr68CYM+3oUXZcNKUDjH3nwDF4gqdUcG4OLLP6wSbPQ5/PvSiXwLksyLYlaGTGhFPjsXU3eImSzfpk85Pj+6rs4vXHXhrsxbhYfMMVcbyyy41V8y+jPKJo0Nb1gf4/fXt0CTvmpjTK+dLhXDGgs9zkbfC82m2xDZ8cw==
x-ms-exchange-antispam-messagedata: 
 Y/NzjgqiuZ63SZiEt47XWA/vVQu4HpVeWnV+pxn4AxOnWgq6O6ZGvVInVvi9n47eYJHyi8dg3DkBDgIMsucZjw7LRNxD1F903SBPJ19cKkXWDNCRG2bIrL2boX/X+mxxXdWB2i5L0Fv+bRuc7hO0IXxUH7CdND/MTU9sFngEBy6YQUk4Vpo/TpJv0F0hAvbjUxL8c3vhOKGWRJ+cllafDOxNgSODh+/oPbEDJM/U3ce9rMUB0A8LGjdblDs0xW2wnTGBjrN2GEM5JbTdVB2EhChgmfyWQvv9fBX4+zQysyIpl+ozFVIYXN3XzmIyWgubhGcD+AXe44AiAEQ+khsYoIeMRZx3sni2mYuL5auUNpxJiRDOj2jplqF/zwBTU53jjyIubTLeS5/TdjKjpVUSA0AC5St7QC2lttFWbfHLLlRc1jsbro+fJr6bWg+g33Z5d+nh2VivTLBpER48FdikGJo4KOzL4wMISoqoTHxzcaJHLSjH6DcqPjUdbDUIkTWHxMO5yXp9DXNG0x9GuRaDC5vfyZv6DGx2C0uUWhqPfVbxGGxZdV+ixnmpEeW1UjUE4L3us/KI2SGRcrdH0Zov4eXrl68+rSebjCjn+nzf6UZu/zXRJze61qULZf+g9ecdT4yvS6mPvRsvXcqt71Xf0Q==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4df2ddf-2e10-419e-3abe-08d836010be7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2020 09:55:39.4450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9PinByJ4ZOuyNk7S15hvzNGMCQMi3YHg5hWA7lpwU0u7DwWq6JG+PGMfoq/44CHGF81YxNykEmUZZbv10Wjpu6KqRkag+so8Sxv014SvpMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2093
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1ZvnYkzQeoZOdlPBOT6J9doPx4520388AA=
Content-Type: multipart/mixed; boundary="bVAqKzLNoz3Bq2OX4t7C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596454077;
 bh=SuJsp0towRSF7GnBCb5oTuy/RkyQwIvHTeh8XNRZNP4=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=c+9pdHAv2t/94AkiL6ZG5zRlUjK8ZoLxl2d0OaB9uyPmpoCMupYIEho+sOGT58oC9yy
 XilE+0TYKf3IqRUSVYaxJWOyDs8ooGwxgMvmS72WaDxLWds8eOdDWvuj5eWrHuF79lRnD
 eixH+mPd+YrkefZSjGASyqlyDbTiVqCNWlY=

--bVAqKzLNoz3Bq2OX4t7C
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgTm9idWhpcm8tU2FuLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiBTdWJqZWN0
OiBSRTogW1BBVENIIDQuNC55LWNpcF0gQVJNOiBkdHM6IGl3ZzIyZC1zb2RpbW06IEVuYWJsZSB0
b3VjaHNjcmVlbg0KPg0KPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggNC40LnktY2lwXSBBUk06IGR0
czogaXdnMjJkLXNvZGltbTogRW5hYmxlDQo+ID4gdG91Y2hzY3JlZW4NCj4gPg0KPiA+IEhpIE5v
YnVoaXJvLXNhbiwNCj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KPiA+DQo+ID4g
PiBTdWJqZWN0OiBSRTogW1BBVENIIDQuNC55LWNpcF0gQVJNOiBkdHM6IGl3ZzIyZC1zb2RpbW06
IEVuYWJsZQ0KPiA+ID4gdG91Y2hzY3JlZW4NCj4gPiA+DQo+ID4gPiBIaSwNCj4gPiA+DQo+ID4g
PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IEJpanUgRGFzIFtt
YWlsdG86YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb21dDQo+ID4gPiA+IFNlbnQ6IFdlZG5lc2Rh
eSwgSnVseSAyOSwgMjAyMCA3OjU2IFBNDQo+ID4gPiA+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZzsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLMNCj4g77y3
77yjDQo+ID4gPiDil6/vvKHvvKPvvLQpDQo+ID4gPiA+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9z
aGliYS5jby5qcD47IFBhdmVsIE1hY2hlaw0KPiA8cGF2ZWxAZGVueC5kZT4NCj4gPiA+ID4gQ2M6
IENocmlzIFBhdGVyc29uIDxjaHJpcy5wYXRlcnNvbjJAcmVuZXNhcy5jb20+OyBCaWp1IERhcw0K
PiA+ID4gPiA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+OyBQcmFiaGFrYXIgTWFoYWRldiBM
YWQNCj4gPiA+ID4gPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4g
PiA+ID4gU3ViamVjdDogW1BBVENIIDQuNC55LWNpcF0gQVJNOiBkdHM6IGl3ZzIyZC1zb2RpbW06
IEVuYWJsZQ0KPiA+ID4gPiB0b3VjaHNjcmVlbg0KPiA+ID4gPg0KPiA+ID4gPiBGcm9tOiBNYXJp
YW4tQ3Jpc3RpYW4gUm90YXJpdQ0KPiA+ID4gPiA8bWFyaWFuLWNyaXN0aWFuLnJvdGFyaXUucmJA
YnAucmVuZXNhcy5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IGNvbW1pdCA5OWFlNzhmMWZjM2E3M2M4
OGZlNzI2YzY3NmFlOTYzY2U3MjJiZjIwIHVwc3RyZWFtLg0KPiA+ID4gPg0KPiA+ID4gPiBJbiBv
bmUgb2YgdGhlIGlXYXZlLUcyMkQgZGV2ZWxvcG1lbnQgYm9hcmQgdmFyaWFudHMsIGNhbGxlZA0K
PiA+ID4gPiBHZW5lcmljIFNPRElNTSBEZXZlbG9wbWVudCBQbGF0Zm9ybSwgd2UgaGF2ZSBhbiBM
Q0Qgd2l0aA0KPiA+ID4gPiB0b3VjaHNjcmVlbi4gVGhlIHJlc2lzdGl2ZSB0b3VjaCBjb250cm9s
bGVyLCBTVE1QRTgxMSBpcyBvbiB0aGUNCj4gPiA+ID4gZGV2ZWxvcG1lbnQgYm9hcmQgYW5kIGlz
IGNvbm5lY3RlZCB0aHJvdWdoIHRoZSBpMmM1IG9mIHRoZSBSWi1HMUUuDQo+ID4gPiA+DQo+ID4g
PiA+IEFkZGl0aW9uYWxseSwgdGhpcyBjb250cm9sbGVyIHNob3VsZCBnZW5lcmF0ZSBhbiBpbnRl
cnJ1cHQgdG8gdGhlDQo+ID4gPiA+IENQVSBhbmQgaXQgaXMgY29ubmVjdGVkIHRocm91Z2ggR1BJ
TzQsNCB0byB0aGUgR0lDLg0KPiA+ID4gPg0KPiA+ID4gPiBUb3VjaCB3YXMgdGVzdGVkIHdpdGgg
b25lIG9mIG91ciBpVy1SYWluYm9XLUcyMkQtU09ESU1NIFJaL0cxRQ0KPiA+ID4gPiBkZXZlbG9w
bWVudCBwbGF0Zm9ybXMuDQo+ID4gPiA+DQo+ID4gPiA+IE1vcmUgZGV0YWlscyBvbiB0aGUgaVdh
dmUgd2Vic2l0ZToNCj4gPiA+ID4gaHR0cHM6Ly93d3cuaXdhdmVzeXN0ZW1zLmNvbS9yei1nMWUt
c29kaW1tLWRldmVsb3BtZW50LQ0KPiBraXQuaHRtbA0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBNYXJpYW4tQ3Jpc3RpYW4gUm90YXJpdQ0KPiA+ID4gPiA8bWFyaWFuLWNyaXN0aWFu
LnJvdGFyaXUucmJAYnAucmVuZXNhcy5jb20+DQo+ID4gPiA+IExpbms6DQo+ID4gPiA+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3IvMTU4MzMzNjY1MC0yNTg0OC0xLWdpdC1zZW5kLWVtYWlsLW1h
cmlhbg0KPiA+ID4gPiAtY3JpDQo+ID4gPiA+IHN0aWFuLnJvdGFyaXUucmJAYnAucmVuZXNhcy5j
b20NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5l
c2FzQGdsaWRlci5iZT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFz
Lmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+ID4NCj4gPiA+IFRoZXJlIHNlZW1zIHRvIGJlIG5vIGlz
c3VlIHdpdGggdGhpcyBwYXRjaCwgYnV0IHdlIGFsc28gbmVlZCB0bw0KPiA+ID4gdXBkYXRlIGRl
ZmNvZm5pZy4NCj4gPg0KPiA+IFdlIG5lZWQgdG8gZW5hYmxlIHRoZSBiZWxvdyBjb25maWdzIGlu
IHNobW9iaWxlX2RlZmNvbmZpZy4gQ3VycmVudGx5DQo+ID4gdGhpcyBjb25maWdzIGFyZSBub3Qg
ZW5hYmxlZCBpbiBNYWlubGluZS4gTm90IHN1cmUgd2Ugc2hvdWxkIHVwc3RyZWFtIHRoaXMNCj4g
YW5kIGJhY2twb3J0IGl0IG9yIEp1c3QgZW5hYmxlIGl0IGluIGNpcC1rZXJuZWwtY29uZmlnPyBQ
bGVhc2UgbGV0IG1lIGtub3cuDQo+ID4NCj4gPiBDT05GSUdfTUZEX1NUTVBFPXkNCj4gPiBDT05G
SUdfU1RNUEVfSTJDPXkNCj4gPiBDT05GSUdfVE9VQ0hTQ1JFRU5fU1RNUEU9eQ0KPg0KPiBGaXJz
dCwgSSB0aGluayBpdCdzIGEgZ29vZCB0byBwb3N0IHRoZSBwYXRjaCB0byBlbmFibGUgdGhpcyB0
byBVcHN0cmVhbS4NCg0KU3VyZSB3aWxsICBkby4NCg0KQ2hlZXJzLA0KQmlqdQ0KDQoNClJlbmVz
YXMgRWxlY3Ryb25pY3MgRXVyb3BlIEdtYkgsIEdlc2NoYWVmdHNmdWVocmVyL1ByZXNpZGVudDog
Q2Fyc3RlbiBKYXVjaCwgU2l0eiBkZXIgR2VzZWxsc2NoYWZ0L1JlZ2lzdGVyZWQgb2ZmaWNlOiBE
dWVzc2VsZG9yZiwgQXJjYWRpYXN0cmFzc2UgMTAsIDQwNDcyIER1ZXNzZWxkb3JmLCBHZXJtYW55
LCBIYW5kZWxzcmVnaXN0ZXIvQ29tbWVyY2lhbCBSZWdpc3RlcjogRHVlc3NlbGRvcmYsIEhSQiAz
NzA4IFVTdC1JRE5yLi9UYXggaWRlbnRpZmljYXRpb24gbm8uOiBERSAxMTkzNTM0MDYgV0VFRS1S
ZWcuLU5yLi9XRUVFIHJlZy4gbm8uOiBERSAxNDk3ODY0Nw0K

--bVAqKzLNoz3Bq2OX4t7C
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5080): https://lists.cip-project.org/g/cip-dev/message=
/5080
Mute This Topic: https://lists.cip-project.org/mt/75862490/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--bVAqKzLNoz3Bq2OX4t7C--
