Return-Path: <SRS0=Vr9f=EM=lists.cip-project.org=bounce+64572+5754+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01B4C2D0A3
	for <cip-dev@archiver.kernel.org>; Fri,  6 Nov 2020 09:16:38 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732D7206ED
	for <cip-dev@archiver.kernel.org>; Fri,  6 Nov 2020 09:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Vxlz6LBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732D7206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5754+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5VFAYY4521723xXdXQq1MtVg; Fri, 06 Nov 2020 01:16:34 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.115])
 by mx.groups.io with SMTP id smtpd.web11.9498.1604654193250387378
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Nov 2020 01:16:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlCX2Xz0I9BpFCvT418p58Q5AK9khrrlJLnVbv/9NUTr72q3B+Fq8esrygYQ2w1xHocW76mOJIEnqOBxq10kTedPbTuHBTH3LrgyFvAbpSICFVTW1b+S2ZC1+PUo3hdqFUFIhMc7VVXdrl6Zp/+BrAby/TQJTQPV3pQ780HTDd3PI8gPdl+63jr9/J8TQPELWraBL+2xCJFzbMlhpdxjHqgjYrIo8LwpU+87sar9j40qcpdMd1ltFK7MdVrPS8UGt5x9LOhtiDCozoIgUOKKQmcIFge0F5dzwE4ID0c8hkydWBDGA5VCQQDUool0YiNpLnF/ROHuT5uaXemihc86Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gri4IVrZW6V2SFuXklljsCsgsGf2AL9OWQzJwGIHzY=;
 b=jLvqsFGnsSjLwNwvksM0LWNEQleLr2K9B+4P1TOL1EzPy/WJPC6BYkBmR8R/Td7NlMz5bA0ni0PP9ltN+jf9EPQwVtL+CRE6SGjw5Io1Hnqst15f0liZw6t29hCbxdiUB8vX2DhCmKZO0m9WgNWpWAn75FTnfRhgNsyX9ons9d+NPjVE+BpfbiQI1JWftxENPJSfVIrdaoRXOimRLzTwFsI5K4RKTGtYwFI38pytQAfRkmVbkYZFzwnS18uVY14+yY25j53+Sxkf1WCRfEVCbmVuibi/iX2nIIbDBE5xCpp+2bRB6LMl9B+2eKXVQvwKxIulMTvBR47HWYoGNANROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OS3PR01MB5847.jpnprd01.prod.outlook.com (2603:1096:604:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 09:16:29 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 09:16:29 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/6] Renesas RZ/G2H add USB{2,3} support
Thread-Topic: [PATCH 4.19.y-cip 0/6] Renesas RZ/G2H add USB{2,3} support
Thread-Index: AQHWs2ziTg+QkcR3CkOqEOPWC/O+ZKm6sLSAgAAjK9A=
Date: Fri, 6 Nov 2020 09:16:29 +0000
Message-ID: 
 <OSBPR01MB5048D9061E0034C730CE6B04AAED0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201105095039.4751-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201105121203.GA11467@duo.ucw.cz>
 <OSBPR01MB2983B5BB3FC2BBF6AD90C97392ED0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB2983B5BB3FC2BBF6AD90C97392ED0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2c99245-67f5-4b4f-c285-08d88234a582
x-ms-traffictypediagnostic: OS3PR01MB5847:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OS3PR01MB584705775F7D8F64BFEA0E90AAED0@OS3PR01MB5847.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 e54c2LbI5C41MN5XkfU7SJ39XnSe0hlVVh7FXPxkElTaOUSp41BYmuERZktlh00cfV7s3ih+RlTwEBpvpjA1BnxXGMXsY8XWJJyBj0+O3SMIQg+v6TYRWFfr8cFzOVhU8rKGeymnWKzhqrPLCrjeAER4QOA0YJqSwx4aN5H4S1qzy/pnK127YmIeX4GRdwd8XPYzzw+5qWiNA7iUMJbQhiqiH+dAG+lX0U3+EI9rZkgc4troKHkMUa2tOqk2iR1yIbcvF6B89IzKVXxDzZVOI7j0Xyqo7sczAP7zwepU+7HdPTpIaQhpYG87sZptYvVrDa7qteZH5NPk+0RYcpBy0g==
x-ms-exchange-antispam-messagedata: 
 b8MTYwqdbtNNzeU4vmEs5Ki/g1MrJrPAoQo7uUEFvjzLf2FqGTTMRhClayq0lpW1pBQJzOdsnZtEmjKWjioZ8RIBZlDIPgzvkSsI9NtnUfUlPEivyTm0ufpTfROZyP9C8GJfTkt2XF39bMcVcRaAQu9CY9DuSXzLdVpvs30Wmmlr1DCm+oR9eh4uywk72SRoO8L9t56rT+MuKcPBU5pNNgOBpfFb2vmkvTHMD58A1cQD83PuNBjPqFMkVFHjzbGmYvJxbM7l0rrInSYNPyqjMHh2ejRjqhMRlpItgtUFSHgyfWcVyHXHoobqWyY4HmO+txpSZD4kh8wAJkPOi1mENBGUIHmVRIqzmkxKmopXV1KCnUf7J0dUgznG1ZvR7Zpd8etIle6YbzD8IGtqcm3o10kYpLRVtggLm/EcMkyRHco6YDKS6ijwSxcGMhGr/VT6NPLj8Lhv1w/vQWll6PwHN53inTTCEh5Xoc/7y9Z2KPFXb9kzUOjwc3F/qKICEDxTp+LkNhBYx+Ox7Z9TUzu9p+umtLu/FDDKA6GN+ZSDNuDTjhuQgP6eeh51e4HGkXj1AtwDh18dxia0ggcMEkRY6/0ZYzvWnjP/rPJlWJHgThgb7nDzw79Vh9gkoltk+Z9E76x3c1Djqydc97+sgX8NDg==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c99245-67f5-4b4f-c285-08d88234a582
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 09:16:29.8436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6W/XmEUPJZTwqO6bBpoW6AmB96rjH+VcadN+XGpYRSC9+yGyRX3MawBdpmPVcFz/dA9/9QGFDYr1itSTKzOOqCmHrp1QM/PgSJMM45dswfC+qHC7BaBxCSUdOqVdbdfp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5847
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5b3cDy81noBintQ168HgzyHtx4520388AA=
Content-Type: multipart/mixed; boundary="rptWG0ycW52zouVdLSCF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604654194;
 bh=/p1kp/prwYmhGWgGAp8i/GKW0iDFoFXjn5f+I53rNto=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Vxlz6LBX3hAc1duZCrbRKkQtWZRKYH2c4VyRVyrcnLfNq3Q4xnUzmMZNnaQPwKaLmGy
 iOX31OiRqVCHzGDBY+4tqv0p8wKlT3+Bmx0IMDAipaPb365WIvTeCnKjDn4jVPTSG+/Mn
 mLF47GU1F161rINXsl8nqWoCJXt/vwd+hOY=

--rptWG0ycW52zouVdLSCF
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgTm9idWhpcm8sUGF2ZWwsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogbm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanAgPG5vYnVoaXJvMS5pd2FtYXRzdUB0
b3NoaWJhLmNvLmpwPg0KPiBTZW50OiAwNiBOb3ZlbWJlciAyMDIwIDA3OjEwDQo+IFRvOiBwYXZl
bEBkZW54LmRlOyBQcmFiaGFrYXIgTWFoYWRldiBMYWQgPHByYWJoYWthci5tYWhhZGV2LWxhZC5y
akBicC5yZW5lc2FzLmNvbT4NCj4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBC
aWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFU
Q0ggNC4xOS55LWNpcCAwLzZdIFJlbmVzYXMgUlovRzJIIGFkZCBVU0J7MiwzfSBzdXBwb3J0DQo+
IA0KPiBIaSwNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBQ
YXZlbCBNYWNoZWsgW21haWx0bzpwYXZlbEBkZW54LmRlXQ0KPiA+IFNlbnQ6IFRodXJzZGF5LCBO
b3ZlbWJlciA1LCAyMDIwIDk6MTIgUE0NCj4gPiBUbzogTGFkIFByYWJoYWthciA8cHJhYmhha2Fy
Lm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+IENjOiBjaXAtZGV2QGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZzsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfv
vKPil6/vvKHvvKPvvLQpDQo+ID4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsg
UGF2ZWwgTWFjaGVrIDxwYXZlbEBkZW54LmRlPjsgQmlqdSBEYXMNCj4gPGJpanUuZGFzLmp6QGJw
LnJlbmVzYXMuY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC4xOS55LWNpcCAwLzZdIFJl
bmVzYXMgUlovRzJIIGFkZCBVU0J7MiwzfSBzdXBwb3J0DQo+ID4NCj4gPiBIaSENCj4gPg0KPiA+
ID4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBVU0J7MiwzfSBzdXBwb3J0IHRvIFJlbmVzYXMgUlov
RzJIIFNvQy4NCj4gPiA+DQo+ID4gPiBBbGwgdGhlIHBhdGNoZXMgaGF2ZSBiZWVuIGNoZXJyeS1w
aWNrZWQgZnJvbSBMaW51eCB2NS4xMC1yYzIuDQo+ID4NCj4gPiBTZXJpZXMgbG9va3Mgb2sgdG8g
bWUgYW5kIHBhc3NlcyBvdXIgdGVzdGluZywgSSBjYW4gYXBwbHkgaXQgaWYgdGhlcmUNCj4gPiBh
cmUgbm8gb3RoZXIgY29tbWVudHMuDQo+IA0KPiBMb29rcyBnb29kIHRvIG1lIHRvby4gSSBhcHBs
aWVkIGFuZCBwdXNoZWQgdG8ga2VybmVsLm9yZy4NCj4gDQpUaGFuayB5b3UgZm9yIHRoZSByZXZp
ZXcgYW5kIGFjY2VwdGFuY2UuDQoNCkNoZWVycywNClByYWJoYWthcg0KDQo=

--rptWG0ycW52zouVdLSCF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5754): https://lists.cip-project.org/g/cip-dev/message=
/5754
Mute This Topic: https://lists.cip-project.org/mt/78047670/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--rptWG0ycW52zouVdLSCF--
