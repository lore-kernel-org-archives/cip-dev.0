Return-Path: <SRS0=fB8E=CE=lists.cip-project.org=bounce+64572+5253+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A156BC433E1
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 06:42:26 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1794420738
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 06:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="tau2fLy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1794420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5253+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id aRPeYY4521723xqTvr06YCrx; Tue, 25 Aug 2020 23:42:25 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web11.7149.1598424143080507649
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2020 23:42:24 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 07Q6gBaH001768; Wed, 26 Aug 2020 15:42:11 +0900
X-Iguazu-Qid: 2wGrPVRPQOLjnizGcM
X-Iguazu-QSIG: v=2; s=0; t=1598424131; q=2wGrPVRPQOLjnizGcM; m=Y1aBTjO8RSuQSoRJreQLitdvHg06IHVvzcMlg35LQxE=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1113) id 07Q6g9gB031749;
	Wed, 26 Aug 2020 15:42:10 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx2.toshiba.co.jp  with ESMTP id 07Q6g9N6019963;
	Wed, 26 Aug 2020 15:42:09 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc03.toshiba.co.jp  with ESMTP id 07Q6g92T023978;
	Wed, 26 Aug 2020 15:42:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE6UEuj1dFyWJfMjCXi0nmoXVZg0W2XCAVCJ4nGqCWiSimRNYJj6PE6iZH2cN6IepBcg0GQjZqY/zHfjdC3jRBz/RbKPGgO+WNJt05p3SdXAxDcv67JhCxoJGnx1/bIDoltnmjmonsiEc9yzbFWb9QeH5D8gc7MhjXwpnWpH/9DXf5AfCznNyn6ctCitGtKtrTOKdvHPFhGBRnrtfw2lHO3jyKK0Eei+IRsreUFjjjVxobccJBxpAKTax6aDk+ItGQvrpA04srWRdY5Y8FjYbFDZ2QHB1dAMFpQVx7XuVVBL6dfyfvnKrMVzCoM42NLNj8Ae3uUonVyfpz5htUb2vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aG23Q+WJ0mDzdmFzKf3yu+iJwEufsGOHPJknPtizTY8=;
 b=Q17bd2SGu7/WJGmDtVMBQSI+xS4hf2al1KxoFkTTficiYE2YNLkMPweRWzU6vDwAWo5VIyUDYAUW85AyG/TnNfR8DYPwl+bOqnap4Op6dOaGdfy2GJn9S25Y/qAZgoC9m2Kl13ud3pCa5D59XYxWdTq8waNX/ys1hAOhsOmz1G1vTPD2lMPzZhgM0jPu3aq4s0FipUgK6WURq4+4eBSpn06hSzQxxaKv82W9hXbipy0H9Q3XaREs9dpT6N2422Xwap7dhORhvHHexbpfdZO48gi2cKS5UHWi3nhTDuLYjMNJp9PV/rn8FTeaPsqhHbXB8BQ0emxn01l77gdB/h00yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/10] Add OPP/Thermal/Timer/CAN[FD] support
Thread-Topic: [PATCH 4.19.y-cip 00/10] Add OPP/Thermal/Timer/CAN[FD] support
Thread-Index: AQHWeuLqmWl5e2xak0irZ8GFfKgDIqlJ8ePQ
Date: Wed, 26 Aug 2020 06:42:01 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983E8FF5E45905E0A28F52192540@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b903dd8-bdc5-4691-c9d8-08d8498b2393
x-ms-traffictypediagnostic: OSBPR01MB2870:
x-microsoft-antispam-prvs: <OSBPR01MB2870B98A083C32894622686592540@OSBPR01MB2870.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nK3KYq8HzFkwodw24RyZNl3aOPyWqFMgWr0j6B045tXz32tCK5LpAVraM2JHW4OZsWpXlHSKJZ4TCmNtdHZDJWi9fAjf1VrCH/9huAHzoxpP3qZV0EFx+g6RAxMyV5RlOBg3nVkxBCSqEiPckP9/btBob5DfxbwlacylguK6jSx+6dSHkDDYfxQmGZ4+nF8xPaE6Q22kxp/IywVwQpu7BVb9g4ljRDGkkJp3NkpqLNY1yiSJqCLUopNeRfgda8OlxmIl0zaBBPKK7Vkd8Snxs7XCYcYT2NLNnvRmZTRJBA3EO5jVxa5a2Mr6j36UDOVKSZy3GaxJCfeXS6MWTk7rohkSVwpMWDMQ9ixCpCcA6KptfVU0IfPG1bV4ulDhGLDTBKsS9IXN/oA0UjOg9bQ8Rw==
x-ms-exchange-antispam-messagedata: ewwQEDPC2VhEPfXeJ0DnK6eQbKkcPmO97nXfCoNFJC0W33FBwaVOo/KrDmsCmZXnY+TstN65Ff5i+W+KK5RmSqbjY2dJrRJkIfRER9fyfP0OByYnnTHZC03ZQEXd4I+ckky5q9tDVy+n0Nx+LPR2xogpVtcy4LkJNVgJgzESoCjnCpZE2GUq4ujVWwQXMAK3tDVAsnhu5vbdvt/WJzTSZRmceSWuajQ+NA+FNgyJdvnFxXePhWszo4TvRkVahaTU7KCE9oklyaq64C/U+Y53nD8m1hS0Sl27YCix8r1RXuAIHBqonmALYfZZVfs0UW+Pr9UJO9KJMLRkzN8plmHAgoMm5XedTzL/12mSSUZsiPqdiU3dpoF1+P7fqK7xYoxboNGZDuGtbKZnQvCL/8bnb0InKMHuKdiXRUpp3HlQQz2ce26e+mxkQ7mtDvIRyfqS8wa+YD4mVZDSFFFLAi/5ljl+HrP3OuJFS9ZVjyDeQNeKkfCo5BlbtF8pca8jBFXCeu+r8XxVGpHnAgCiM4Z+W+0Gduixy0puaZSkp/8YmVVGxr3oTcWGBd3eoITeD3uQ9TXs718SZNdsO/IeOMMBUMJRQjYTSHmd40xQbO+k4Hk0ulTfjGlw3ZAV3biwVtVXX7vRruvi2xuXqLPjljDuZQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b903dd8-bdc5-4691-c9d8-08d8498b2393
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 06:42:01.7995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YvHWAi3wb13LzzQY8ZitiVYtZOxfs6Z2Ma2d52Od7sqmL/NPLr/VPGmVNUDGv1e8X1VW6E+MFt5YHPjCaIffgBRBEqr8iJAX207R+aSc2gqExEi6Et+16iNEPusQjsnM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2870
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 9P99HVh1L267k6cuWYnzpVHax4520388AA=
Content-Type: multipart/mixed; boundary="5HnjBfTWoJAdIE6GCigl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598424145;
 bh=mlW3P1pfUsECds0kMXfNilzLIE04bCLhV+VDEf9f4A4=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=tau2fLy3wQ0a9G+NKp//9ckKUT3xCeVAjWvy1saQ8i4oCQysmORIAyc4bDFrmFaKsVo
 uo6QRE8yL4N2Dr84NecWV66LrEQTm0jKP1+zU9ZVsiQQiATUUzRNj/Llcu5bLn31pCqXL
 E3uhWyDAtj4iEiEfQCI/NuzCyoRdu9w/520=

--5HnjBfTWoJAdIE6GCigl
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmlqdSBEYXMgW21h
aWx0bzpiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbV0NCj4gU2VudDogVHVlc2RheSwgQXVndXN0
IDI1LCAyMDIwIDEwOjIyIFBNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsg
aXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQp
DQo+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IFBhdmVsIE1hY2hlayA8cGF2
ZWxAZGVueC5kZT4NCj4gQ2M6IENocmlzIFBhdGVyc29uIDxjaHJpcy5wYXRlcnNvbjJAcmVuZXNh
cy5jb20+OyBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+OyBQcmFiaGFrYXIg
TWFoYWRldiBMYWQNCj4gPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4N
Cj4gU3ViamVjdDogW1BBVENIIDQuMTkueS1jaXAgMDAvMTBdIEFkZCBPUFAvVGhlcm1hbC9UaW1l
ci9DQU5bRkRdIHN1cHBvcnQNCj4gDQo+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZCBSWi9HMkggU29D
IHN1cHBvcnQgZm9yIE9QUC9UaGVybWFsL1RpbWVyL0NBTltGRF0NCj4gdG8gNC4xOS55IGNpcCBr
ZXJuZWwuDQo+IA0KPiBBbGwgdGhlIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMgYXJlIGNoZXJyeS1w
aWNrZWQgZnJvbSBNTC4NCj4gDQo+IFRoaXMgcGF0Y2ggc2VyaWVzIGRlcGVuZCB1cG9uIFsxXQ0K
PiBbMV06IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9jaXAtZGV2L2xpc3Qv
P3Nlcmllcz0zMzY2MDkNCj4gDQo+IERpZW4gUGhhbSAoMSk6DQo+ICAgdGhlcm1hbC9kcml2ZXJz
L3JjYXJfZ2VuMzogRml4IHVuZGVmaW5lZCB0ZW1wZXJhdHVyZSBpZiBuZWdhdGl2ZQ0KPiANCj4g
R2VlcnQgVXl0dGVyaG9ldmVuICgxKToNCj4gICBjYW46IHJjYXJfY2FuOiBSZW1vdmUgdW51c2Vk
IHBsYXRmb3JtIGRhdGEgc3VwcG9ydA0KPiANCj4gTGFkIFByYWJoYWthciAoMSk6DQo+ICAgYXJt
NjQ6IGR0czogcmVuZXNhczogcjhhNzc0ZTE6IEFkZCBDQU5bRkRdIHN1cHBvcnQNCj4gDQo+IE1h
cmlhbi1DcmlzdGlhbiBSb3Rhcml1ICg1KToNCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiByOGE3
NzRlMTogQWRkIG9wZXJhdGluZyBwb2ludHMNCj4gICB0aGVybWFsOiByY2FyX2dlbjNfdGhlcm1h
bDogQWRkIHI4YTc3NGUxIHN1cHBvcnQNCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiByOGE3NzRl
MTogQWRkIFJaL0cySCB0aGVybWFsIHN1cHBvcnQNCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiBy
OGE3NzRlMTogQWRkIENNVCBkZXZpY2Ugbm9kZXMNCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiBy
OGE3NzRlMTogQWRkIFRNVSBkZXZpY2Ugbm9kZXMNCj4gDQo+IE5pa2xhcyBTw7ZkZXJsdW5kICgy
KToNCj4gICB0aGVybWFsOiByY2FyX2dlbjNfdGhlcm1hbDogUmVtb3ZlIHRlbXBlcmF0dXJlIGJv
dW5kDQo+ICAgdGhlcm1hbDogcmNhcl9nZW4zX3RoZXJtYWw6IEdlbmVyYXRlIGludGVycnVwdCB3
aGVuIHRlbXBlcmF0dXJlDQo+ICAgICBjaGFuZ2VzDQo+IA0KPiAgYXJjaC9hcm02NC9ib290L2R0
cy9yZW5lc2FzL3I4YTc3NGUxLmR0c2kgfCAzMjMgKysrKysrKysrKysrKysrKysrKysrLQ0KPiAg
ZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW4uYyAgICAgICAgICAgfCAgMjIgKy0NCj4gIGRy
aXZlcnMvdGhlcm1hbC9yY2FyX2dlbjNfdGhlcm1hbC5jICAgICAgIHwgIDM0ICstLQ0KPiAgaW5j
bHVkZS9saW51eC9jYW4vcGxhdGZvcm0vcmNhcl9jYW4uaCAgICAgfCAgMTggLS0NCj4gIDQgZmls
ZXMgY2hhbmdlZCwgMzQ3IGluc2VydGlvbnMoKyksIDUwIGRlbGV0aW9ucygtKQ0KPiAgZGVsZXRl
IG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvY2FuL3BsYXRmb3JtL3JjYXJfY2FuLmgNCj4gDQoN
CkkgcmV2aWV3ZWQgdGhpcyBwYXRjaCBzZXJpZXMuDQpMb29rcyBnb29kIHRvIG1lLg0KDQpCZXN0
IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCj4gLS0NCj4gMi4xNy4xDQoNCg==

--5HnjBfTWoJAdIE6GCigl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5253): https://lists.cip-project.org/g/cip-dev/message=
/5253
Mute This Topic: https://lists.cip-project.org/mt/76406704/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--5HnjBfTWoJAdIE6GCigl--
