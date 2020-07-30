Return-Path: <SRS0=kjZw=BJ=lists.cip-project.org=bounce+64572+5076+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53FEC433DF
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 11:53:32 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D9120838
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 11:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="EO2nrlHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D9120838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5076+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id N3tyYY4521723x6DFRasGWlE; Thu, 30 Jul 2020 04:53:31 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.128])
 by mx.groups.io with SMTP id smtpd.web11.3299.1596093038461679990
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jul 2020 00:10:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLQuyfugfMrfZWhOICaAhDJ5cZA1i2oFm0pYaUIfk0RjsB1viTe8GJ4cBAvOuhvgR3LA07OhBqsx/sdtGO1VCPrlmA1cGwKQ8Uq1XzLTUJAV90yb6L78fBCgP622qJN3ufLxvX2m7j+jttog7FsToSYDt8GlueAVqCn5T6tPUcw4ukwWN2GSIHxVuBEmS9bZZ0rgQIE3EsecGAAp0njKjsIjuznvo06HSfbTl5Qj8cN6ivk5mMJ+faruPXbKRmOVbc6WpY+xo1x6+Zz8SZTd1yAo5wBkXY9MwEmPiykEEq+SWi8xKSrchGfc6HzRFDGFCxZPOmv9IZmsVFHUHPN2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4S2KymVCEwyyW109lhadQDI5ni3DQqUgKoPmZHbfzH0=;
 b=W/emKVCH1+wycHrnCBKm85YWaUNFhTQx+FlpWZzDzC4yNoYm5twXM6Q1Su8rUu5Pn0epdPQ/lNi8N4gDm7ILCm2HY/E7WRekCbGw+bbjT12CEfFUdZMxJUFEtRcz+3B+lM4fm0uo7RuzBx8bNiDH1C/JnS79pv8ngEln1U2JrYWtcGi992+oUIU5ecQ0RvjO6DSKgCrGM3osmcl0iWfC1k82pKgyUTYNSxRb1YKOTWKZKqoau6/baYqQLziHHMRtl+vAiHpyMjSFZTYd2X2XdCO/kTXf6GsaCGL2J/3I6kMTUL5RWI+5xZCBW2LgccIXrDy04SNyF6k3hnGd53vDYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TYAPR01MB3773.jpnprd01.prod.outlook.com
 (2603:1096:404:be::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 30 Jul
 2020 07:10:34 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::590e:ebc:1f09:f160]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::590e:ebc:1f09:f160%7]) with mapi id 15.20.3216.034; Thu, 30 Jul 2020
 07:10:34 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Enable touchscreen
Thread-Topic: [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Enable touchscreen
Thread-Index: AQHWZZbnsBKZiSmbzk29U0spVTxALqkfUcEAgABhkJA=
Date: Thu, 30 Jul 2020 07:10:34 +0000
Message-ID: 
 <TYBPR01MB5309707BB448C3DE7D5F282686710@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <20200729105621.8242-1-biju.das.jz@bp.renesas.com>
 <OSBPR01MB2983E426B309BE9BA68FAC3392710@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB2983E426B309BE9BA68FAC3392710@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [31.49.74.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e70d1cd-1c92-4416-92e4-08d83457a713
x-ms-traffictypediagnostic: TYAPR01MB3773:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TYAPR01MB377366424B723C45230CF15F86710@TYAPR01MB3773.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 TiOf6W7Ntt6haMkoDiXrFb3eLVGZoPci+0KUQWnx7i9jPGbGb9P/TdkOC1FIQqOdIB66bQpgjcJrs1zOFmUMQLAXRwS069flf+s8mMKM9Kz1KY8kE5HzYcXreIXqYvWdfXj4rjg3NH6KmfOX5AoGJb9uKzdA/KsKbCSL48y9ztJd3rCHcVV0IkMGEdSONCJ1RKiCC82A86vkVuGmO1A9N69qVfWY93CO6uPu7+oYFQlPo97JOUZVkIeXB6bv+Ry2t6w7iVJ9wALMaHRX2vRPr4n4kQgUM3mFE06pZWVgndu/uhMsPSmuyYMgGI6yooPa8y79pSuxpZ8xjFqhQkPBs1I3960YS+xMhD1e5gBs11YGIl2Z/DkeEPdh9DI6H0vYcLHGA8LjoAsR/9A/X1wsdg==
x-ms-exchange-antispam-messagedata: 
 DcoFmHFyZCdJ+UwokZQkZCKym5mTGtoZVWzexGJNAji4R6PRMQ/dn3ltoLxQKD+zE/bJDg1s6ZoMw7Y58U1AGbSxWGoksME/NeSjw4VhmjKvlOTRtPRy37ZYkRo66pOBjV3HJW1fU13XjDQ3manQMi2Adv3E2KdmYtHcI1l7LTdlb5q2tQ9zc5Rq4+0MqntFquWRdHo4uqHf3oKrNznEy1ZJbQ+9vC+UNqc6bOPmO5sEC6hqtCSDAs15zehDJenJZcK9/xI0cZ8u5uy0Qp4YD0XfA1Tw6xB14xA34t8y+EVezruWv8ockjcHHiEV+ELgSpxITqTM6IZ2kRvdsfoh1gB5TpYcaATruOC/VEpaXTkMKX+ER1OubE9GvKbNhu+yN0UmdxQPswhYR7ZBh1uk4AcI8GWnAyUC0tAa+e/qe8pQ6bdOL3v1nexRo/LL4jNxkI+ummYZq2mrZn6K1/ZunkfdeX6ue2VcefLVdELYDrc=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e70d1cd-1c92-4416-92e4-08d83457a713
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 07:10:34.1756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 66TKBcNd1gPmclWwcaNaJ38f8zsb5YJ6bXpOjtFw9fsgGSR4fZXdR1L02uTnRNRj+t4x7KTRPouq6zKuyU8NXo2cAVDKLhCNEL6LOtJfSFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3773
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: lAlgtcwok89XH8AEDZNVKtjMx4520388AA=
Content-Type: multipart/mixed; boundary="sZkXfQgMS9gMZ5vACixx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596110011;
 bh=PP6kRm5ntrCUx6nzFegW84sENypZQ1sSTnLPgDrZtOw=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=EO2nrlHeu2rHFtZ7WZoJy57tzDQqHwDxV3A0FdCWD4bev6xyljIHHqCeCo4d8RHi26t
 3IS80vU/O9OaiIP3WYRN48ynEdRzzc/tSSAfSkJL4rq5p8lUNu/EKXVVNKEBPUhJ/YL9f
 K4LpFzeuVKJ2RmTuIuuq/Po1efT1fA2lbYE=

--sZkXfQgMS9gMZ5vACixx
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgTm9idWhpcm8tc2FuLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiBTdWJqZWN0
OiBSRTogW1BBVENIIDQuNC55LWNpcF0gQVJNOiBkdHM6IGl3ZzIyZC1zb2RpbW06IEVuYWJsZSB0
b3VjaHNjcmVlbg0KPg0KPiBIaSwNCj4NCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+IEZyb206IEJpanUgRGFzIFttYWlsdG86YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb21dDQo+
ID4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDI5LCAyMDIwIDc6NTYgUE0NCj4gPiBUbzogY2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg
4pah77yz77y377yjDQo+IOKXr++8oe+8o++8tCkNCj4gPiA8bm9idWhpcm8xLml3YW1hdHN1QHRv
c2hpYmEuY28uanA+OyBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+DQo+ID4gQ2M6IENocmlz
IFBhdGVyc29uIDxjaHJpcy5wYXRlcnNvbjJAcmVuZXNhcy5jb20+OyBCaWp1IERhcw0KPiA+IDxi
aWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT47IFByYWJoYWthciBNYWhhZGV2IExhZA0KPiA+IDxw
cmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+ID4gU3ViamVjdDogW1BB
VENIIDQuNC55LWNpcF0gQVJNOiBkdHM6IGl3ZzIyZC1zb2RpbW06IEVuYWJsZSB0b3VjaHNjcmVl
bg0KPiA+DQo+ID4gRnJvbTogTWFyaWFuLUNyaXN0aWFuIFJvdGFyaXUNCj4gPiA8bWFyaWFuLWNy
aXN0aWFuLnJvdGFyaXUucmJAYnAucmVuZXNhcy5jb20+DQo+ID4NCj4gPiBjb21taXQgOTlhZTc4
ZjFmYzNhNzNjODhmZTcyNmM2NzZhZTk2M2NlNzIyYmYyMCB1cHN0cmVhbS4NCj4gPg0KPiA+IElu
IG9uZSBvZiB0aGUgaVdhdmUtRzIyRCBkZXZlbG9wbWVudCBib2FyZCB2YXJpYW50cywgY2FsbGVk
IEdlbmVyaWMNCj4gPiBTT0RJTU0gRGV2ZWxvcG1lbnQgUGxhdGZvcm0sIHdlIGhhdmUgYW4gTENE
IHdpdGggdG91Y2hzY3JlZW4uIFRoZQ0KPiA+IHJlc2lzdGl2ZSB0b3VjaCBjb250cm9sbGVyLCBT
VE1QRTgxMSBpcyBvbiB0aGUgZGV2ZWxvcG1lbnQgYm9hcmQgYW5kDQo+ID4gaXMgY29ubmVjdGVk
IHRocm91Z2ggdGhlIGkyYzUgb2YgdGhlIFJaLUcxRS4NCj4gPg0KPiA+IEFkZGl0aW9uYWxseSwg
dGhpcyBjb250cm9sbGVyIHNob3VsZCBnZW5lcmF0ZSBhbiBpbnRlcnJ1cHQgdG8gdGhlIENQVQ0K
PiA+IGFuZCBpdCBpcyBjb25uZWN0ZWQgdGhyb3VnaCBHUElPNCw0IHRvIHRoZSBHSUMuDQo+ID4N
Cj4gPiBUb3VjaCB3YXMgdGVzdGVkIHdpdGggb25lIG9mIG91ciBpVy1SYWluYm9XLUcyMkQtU09E
SU1NIFJaL0cxRQ0KPiA+IGRldmVsb3BtZW50IHBsYXRmb3Jtcy4NCj4gPg0KPiA+IE1vcmUgZGV0
YWlscyBvbiB0aGUgaVdhdmUgd2Vic2l0ZToNCj4gPiBodHRwczovL3d3dy5pd2F2ZXN5c3RlbXMu
Y29tL3J6LWcxZS1zb2RpbW0tZGV2ZWxvcG1lbnQta2l0Lmh0bWwNCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IE1hcmlhbi1DcmlzdGlhbiBSb3Rhcml1DQo+ID4gPG1hcmlhbi1jcmlzdGlhbi5yb3Rh
cml1LnJiQGJwLnJlbmVzYXMuY29tPg0KPiA+IExpbms6DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvci8xNTgzMzM2NjUwLTI1ODQ4LTEtZ2l0LXNlbmQtZW1haWwtbWFyaWFuLWNyaQ0KPiA+
IHN0aWFuLnJvdGFyaXUucmJAYnAucmVuZXNhcy5jb20NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHZWVy
dCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4NCj4gVGhlcmUgc2Vl
bXMgdG8gYmUgbm8gaXNzdWUgd2l0aCB0aGlzIHBhdGNoLCBidXQgd2UgYWxzbyBuZWVkIHRvIHVw
ZGF0ZQ0KPiBkZWZjb2ZuaWcuDQoNCldlIG5lZWQgdG8gZW5hYmxlIHRoZSBiZWxvdyBjb25maWdz
IGluIHNobW9iaWxlX2RlZmNvbmZpZy4gQ3VycmVudGx5IHRoaXMgY29uZmlncyBhcmUgbm90IGVu
YWJsZWQgaW4NCk1haW5saW5lLiBOb3Qgc3VyZSB3ZSBzaG91bGQgdXBzdHJlYW0gdGhpcyAgYW5k
IGJhY2twb3J0IGl0IG9yIEp1c3QgZW5hYmxlIGl0IGluIGNpcC1rZXJuZWwtY29uZmlnPyBQbGVh
c2UgbGV0IG1lIGtub3cuDQoNCkNPTkZJR19NRkRfU1RNUEU9eQ0KQ09ORklHX1NUTVBFX0kyQz15
DQpDT05GSUdfVE9VQ0hTQ1JFRU5fU1RNUEU9eQ0KDQpDaGVlcnMsDQpCaWp1DQoNCg0KUmVuZXNh
cyBFbGVjdHJvbmljcyBFdXJvcGUgR21iSCwgR2VzY2hhZWZ0c2Z1ZWhyZXIvUHJlc2lkZW50OiBD
YXJzdGVuIEphdWNoLCBTaXR6IGRlciBHZXNlbGxzY2hhZnQvUmVnaXN0ZXJlZCBvZmZpY2U6IER1
ZXNzZWxkb3JmLCBBcmNhZGlhc3RyYXNzZSAxMCwgNDA0NzIgRHVlc3NlbGRvcmYsIEdlcm1hbnks
IEhhbmRlbHNyZWdpc3Rlci9Db21tZXJjaWFsIFJlZ2lzdGVyOiBEdWVzc2VsZG9yZiwgSFJCIDM3
MDggVVN0LUlETnIuL1RheCBpZGVudGlmaWNhdGlvbiBuby46IERFIDExOTM1MzQwNiBXRUVFLVJl
Zy4tTnIuL1dFRUUgcmVnLiBuby46IERFIDE0OTc4NjQ3DQo=

--sZkXfQgMS9gMZ5vACixx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5076): https://lists.cip-project.org/g/cip-dev/message=
/5076
Mute This Topic: https://lists.cip-project.org/mt/75862490/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--sZkXfQgMS9gMZ5vACixx--
