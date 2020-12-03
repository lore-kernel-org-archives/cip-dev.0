Return-Path: <SRS0=vEsr=FH=lists.cip-project.org=bounce+64572+5935+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B59C63777
	for <cip-dev@archiver.kernel.org>; Thu,  3 Dec 2020 08:55:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C16422203
	for <cip-dev@archiver.kernel.org>; Thu,  3 Dec 2020 08:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C16422203
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5935+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yr7vYY4521723xqQ8PEdRRDS; Thu, 03 Dec 2020 00:55:31 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.118])
 by mx.groups.io with SMTP id smtpd.web12.7440.1606985730176375251
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Dec 2020 00:55:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYSIyTGtrmfCsb3BW+7Q4ZQWyXqyTdbog6yJctNWXOA4lsJ1IY/u9QB+SAWOF4AIH4CBh0iy2Wk9WQaicUiDc09UV6+ve4TkvavWXKupdUbWzfz+ODexOU2A3e/cbs9B7R2Ae+FmksvtyXd6xr6PfFdifv6crVVmy+JQDyta9hwq0ecy3Pkayne5iXDuW56RpTIb8w1/bYZAK0SLFLD+3cMRq1VZJAv1V0pRBWtdfOdjUn6VrkU1KcLDl3d9xDO0nty14VmsqgWCumYQzIQw+RovGP92vvy3G8dafzZ4uQSZG4HqXz3HmmbhQGqn+SRwXDvph1g5sU2iLVuY1TwVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R03tuiEDFMxZkbTFEyBvYbDxPzDSePW1yuwZq05Kwck=;
 b=cZL0bAXP4V24iOVcPii7jU70NeUZKjcYF7SfuudB7yoiY7zSFkynF64arBir8VYeYSLa9tLXlQYV+8Hl+syVzBFooo2SSO7IXZG/s7pkxuSjSrK/ZpYuuFIQUvG0pU+36t9WQX/6UDCq4VpVrVQnWm5CmMb2AMK7W7kTlHyUBtmVEM25Xa3yWB11+MJHCyZMVpj0nkYxwVaoT+rq+Tr8JD3Ly4vw0WJdU4Xcib7EUG5/XnYwHHCylyriofDiHIkmw+omeBT33YEDH8HkcYbim/WB6OfPDQbhrdQKqI6g+4N38GAWGBFpIBA8DpTM9odegmjyZQSQFZDjrQpnnnLXLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OS0PR01MB5474.jpnprd01.prod.outlook.com (2603:1096:604:a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Thu, 3 Dec
 2020 08:55:27 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3632.019; Thu, 3 Dec 2020
 08:55:27 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v2 4.4.y-cip 00/11] Renesas RZ/G1x add SoC detection support
Thread-Topic: [PATCH v2 4.4.y-cip 00/11] Renesas RZ/G1x add SoC detection
 support
Thread-Index: AQHWx8RTZDo1/fBov06t4gZlff4zdKnkqJOAgABrbqA=
Date: Thu, 3 Dec 2020 08:55:27 +0000
Message-ID: 
 <OSBPR01MB5048174358C54D8549D9AE5FAAF20@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201201083938.32688-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201201092822.GB4219@duo.ucw.cz>
 <OSBPR01MB298357DC462CE3BB01390EC592F20@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB298357DC462CE3BB01390EC592F20@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47e74ad5-83a2-43d4-8a6c-08d897692e14
x-ms-traffictypediagnostic: OS0PR01MB5474:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OS0PR01MB5474A8A0AC5E15988E00A703AAF20@OS0PR01MB5474.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 23u5tbhunMqU5Vpm9jE46pue4zp3JpA/HhJjcc82sP4OTjs9DLYPBP+TEAC4LyzVxcuiaYmcVmhV8pwPtHDNBSB66HxzIo+SIR/3QoVqpAJre1H/OT+pu1NcpQzIZYZ1okpKAWN1oS/apfs8b99omsnuhKcazrPt0++IwZNzEm9ht4ncl1zT7Lu9aIrGBrxYYn3KKX1uu1uEt488iTK7oveFvvy7OU/6kpLa/jyNxiW2pXEpqCRdDyp2GN5qitcwqQwXf+mDKkiigMFDHr8JYcCyq6yFjU9rLbQjh6XCDoSTKPuTHqVlAOq/DXSoYk9y9BSsvf/9eCYKuk/VXeguhQ==
x-ms-exchange-antispam-messagedata: 
 =?utf-8?B?WFRIVGhIWjRPRG1CaG1PK0RYeUs3d09zcXgyK0dNb3BEQkQ3ekhOZjJFbHFQ?=
 =?utf-8?B?OEkrNEQ1Snl1YVlOK2pxNlFlZWZtL1pzYzVLYXdFWVMwbnJCM1ZucWpFQTB4?=
 =?utf-8?B?bGVJMjlpQTZGT2RoQmZtMWsvODN1YWYyRmtlUzZpaWllam5qbXI2bjllUTMv?=
 =?utf-8?B?ck5VNDVkZEJvdHNnTEwzQlVlVUJmbDFoa3FHL001T2o5VlVCZ1kyMjVRb3Mz?=
 =?utf-8?B?dXpoNEQ0cG1KWUlySEhLNXRIeGU3TEZVYmRWYjBheTRVSkNYUGlMcFppVEMx?=
 =?utf-8?B?WjBjajU1SVRFWHpzSXM5Q2ZYa3pSRzRMOVIvSHdVUUljZy94YzBnc2hXcU1n?=
 =?utf-8?B?UWNtQkk5WWo3V2xRMDlLQklqc1A1V1Y2NitzQ3hmeEFQV2NnTFBicGxxTkV6?=
 =?utf-8?B?V3lQaXdTcWdYSFZ4WlpTWjYyc2R3aFZPTmpvdC9uN2tYVUFGalJsVjY4TDN3?=
 =?utf-8?B?WG8vb1JWZFZxS2lFeERMdDRUdXR3dDhWVzBkRHZoLzlGdTZaaWRzTjEzM1Zr?=
 =?utf-8?B?blo2U2k3RVVPeHN3MUtrS2lVVDN0NWZXTVJmRFRFQXVrMXRDTGtpd1kvOVZj?=
 =?utf-8?B?TWwrYlZtTHIvbE1GTUVCOUYwT09RNWJhWDZGRWhLaEhGSXh1YWx2ZGNPbC9y?=
 =?utf-8?B?RG0veW1iMW03bEdEelJZQytSVWd2aWNMeHMxMWtKOStDL1prdDRnay9JOFdM?=
 =?utf-8?B?dnl1TGZQaE54dlhXZUpQTWVaVXpuZWNpTVQ4WitORjlGYlZTY3JNb3lmanBB?=
 =?utf-8?B?Z0hYSTJFS0ZidTYvcUtrR3F0MCtQRlpNbWtSeTRycnJ4VTA4cytjVitBNUxm?=
 =?utf-8?B?NXdOcWhPWGR5bkhEL0JQV1gzN3BVZ0dtWXIwUWV3ZU1BZEVEcWlGUldpVUdP?=
 =?utf-8?B?UmptZ2ZKL1B6V0pnejdEQ3ExazZuZ1llZzdYWFlKM2NZTDRUWmE5UFlPZE5x?=
 =?utf-8?B?YTRSUk56em5HS3ZoK3BVL0k5Y0VLWDd2OFp1NGlVN1BFUDFUUUpZZXRPWklY?=
 =?utf-8?B?bWwvYUFHMVcvU0c1NzhXLzhLd1JvdWNnamRENm9peDRwL0dSYzRvbW5PWE04?=
 =?utf-8?B?WXJZMVkzak9FZm5tWmYzM09qWmp2YjhLNTl4VnQ3ZHlBVHFzTXBFdEVEcWJv?=
 =?utf-8?B?eHg3VTVyemFrbjBiRm5Wd1NUZDYzc1QzQmppMDhNTTUxVlY3bXkvaXJGeWY3?=
 =?utf-8?B?RSt6WkhTdWhpdDZNZHJ1UVBsV2JXdmtpOU5lYVhRRGgxMDJPZUkxYlFzN3Aw?=
 =?utf-8?B?cUQ0WEZlcDVWaGMveWFaaDNidHFRYy9PMzJkc08xYTFRUWEvTjZ6SXRIK0lq?=
 =?utf-8?Q?QyZ94qb/UTGcU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e74ad5-83a2-43d4-8a6c-08d897692e14
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 08:55:27.2394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HgAE6fF60CJnhkAon9QbMHm0GcyYLl5RQ0TWB3+Rtpy4DZ8OIFZHOnj/XwyvWKeDYNwfrAlFkG8w1pY83Ydn7aeZDkJDA2hzY8DLMtXeHuoQm4HJZwA9D2mzx5Uzk622
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5474
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uqkzA72wVc6FMBG64TTeINetx4520388AA=
Content-Type: multipart/mixed; boundary="SJ1ifouWzNUOeDwZy2Cd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606985731;
 bh=5iYNY8dFevwioFBVp8KH1TEoDF70gaW+ZM02y2eLvtk=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=J2CGXtQvJp/Vu8qGBEL5W3HkeKo+bVozloq8mQQHXv5I14xQeGbs7zfKatvzcbwfsHb
 MUUJzwZ9uYM0+5JoFegN8tpixTHK97+yVx2DWq3Dieaie9mv1PcOUf09Fi7ohVEcMXa3F
 ybzhuDtk6dKNWP8EH2IPgpV4uc3s02auNR8=

--SJ1ifouWzNUOeDwZy2Cd
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgTm9idWhpcm8sIFBhdmVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwIDxub2J1aGlybzEuaXdhbWF0c3VA
dG9zaGliYS5jby5qcD4NCj4gU2VudDogMDMgRGVjZW1iZXIgMjAyMCAwMjoyOQ0KPiBUbzogcGF2
ZWxAZGVueC5kZTsgUHJhYmhha2FyIE1haGFkZXYgTGFkIDxwcmFiaGFrYXIubWFoYWRldi1sYWQu
cmpAYnAucmVuZXNhcy5jb20+DQo+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsg
QmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BB
VENIIHYyIDQuNC55LWNpcCAwMC8xMV0gUmVuZXNhcyBSWi9HMXggYWRkIFNvQyBkZXRlY3Rpb24g
c3VwcG9ydA0KPiANCj4gSGksDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gRnJvbTogUGF2ZWwgTWFjaGVrIFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gPiBTZW50OiBU
dWVzZGF5LCBEZWNlbWJlciAxLCAyMDIwIDY6MjggUE0NCj4gPiBUbzogTGFkIFByYWJoYWthciA8
cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+IENjOiBjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDi
lqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpDQo+ID4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJh
LmNvLmpwPjsgUGF2ZWwgTWFjaGVrIDxwYXZlbEBkZW54LmRlPjsgQmlqdSBEYXMNCj4gPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNC40Lnkt
Y2lwIDAwLzExXSBSZW5lc2FzIFJaL0cxeCBhZGQgU29DIGRldGVjdGlvbiBzdXBwb3J0DQo+ID4N
Cj4gPiBIaSENCj4gPg0KPiA+ID4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBTb0MgZGV0ZWN0aW9u
IHN1cHBvcnQgZm9yIFJlbmVzYXMgUlovRzF4IFNvQydzLg0KPiA+ID4NCj4gPiA+IEFsbCB0aGUg
cGF0Y2hlcyBhcGFydCBmcm9tIHs3LCA5LCAxMX0vMTEgaGF2ZSBiZWVuIGNoZXJyeSBwaWNrZWQg
ZnJvbQ0KPiA+ID4gTGludXggdjUuMTAtcmM2DQo+ID4NCj4gPiBTZXJpZXMgbG9va3MgZ29vZCB0
byBtZSwgSSBjYW4gYXBwbHkgaXQgaWYgdGhlcmUgYXJlIG5vIG90aGVyDQo+ID4gY29tbWVudHMu
DQo+IA0KPiBJIGFwcGxpZWQgYW5kIHB1c2hlZCB0aGlzIHNlcmllcy4NCj4gDQpUaGFuayB5b3Ug
Zm9yIHRoZSByZXZpZXcgYW5kIGFjY2VwdGFuY2UuDQoNCkNoZWVycywNClByYWJoYWthcg0KDQo+
IEJlc3QgcmVnYXJkcywNCj4gICBOb2J1aGlybw0KDQo=

--SJ1ifouWzNUOeDwZy2Cd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5935): https://lists.cip-project.org/g/cip-dev/message=
/5935
Mute This Topic: https://lists.cip-project.org/mt/78628858/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--SJ1ifouWzNUOeDwZy2Cd--
