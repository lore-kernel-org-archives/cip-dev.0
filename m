Return-Path: <SRS0=giqa=B5=lists.cip-project.org=bounce+64572+5156+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3711DC433E1
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 23:16:37 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946A6207DE
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 23:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="jINTeB85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946A6207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5156+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YffHYY4521723xDbqo9PS3Ql; Wed, 19 Aug 2020 16:16:36 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.100195.1597878993545244700
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Aug 2020 16:16:34 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 07JNGNTc032416; Thu, 20 Aug 2020 08:16:23 +0900
X-Iguazu-Qid: 34tMJPQphaN2skvhvo
X-Iguazu-QSIG: v=2; s=0; t=1597878983; q=34tMJPQphaN2skvhvo; m=RjkA8qh8VUaiNl2ssmVsf075Hf7qdVHn5JuF9+xYj2w=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 07JNGMCY028030;
	Thu, 20 Aug 2020 08:16:22 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx12.toshiba.co.jp  with ESMTP id 07JNGMJD024628;
	Thu, 20 Aug 2020 08:16:22 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc03.toshiba.co.jp  with ESMTP id 07JNGLli028337;
	Thu, 20 Aug 2020 08:16:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/4tiod6dFso9VgJVxDjb3BYPHs8E1PM6CCRQBdL7FNz48PgChNWIlRu83wf/QgT9ayYXnyJox6zDhu2DOV3Y87B5851HaxdvDStCDnUoP7unelz7oD/oWzxYajFREaoMKfI7umsmqFaEKUAyFk9LTnQUyb6PsnpFlwWTNsKFGPND3aoXIZv77bhFQaRyi1EzvL13pO2KQ0PrPj3LaxzuxZdYdh2LAz1QIDMf9rR/ZVL+tHV3B+/k6fsDL5oWtFy2LtjYj3Pp3goNpd5Q9eKWVLalVwQcvxnt3SxwYrIrEStLs4faB0it4NMV513LewSp0JMyCSnlD/ojy+r64J/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61nYLgeyHFy8DMT3uAshwD2ql++93vGB/B9mbyejVGU=;
 b=gWyFCENLv5YZfDBPRkU3CUCViHVOD52AWGeZULAjxtA8YCLCBeWxq3TfeP+kmNJVChPzWQqabg92trgg02R14aBuEKGM2dbnK/9cnuneLj7k9KIMXuMqMiuQv8AealGh/wNyv03K6zD60pqYWmX05o8BqALCwMDvDTmg94wEADo5A1Xn9YHOPumAC+1zxYquF3jKDVBNq2duMUG+hVGUrmQTC3VVmAStYcc1Hma71GRx2SzCMmGActMic22CFc5heiE33sCHO/Y1gmQyEiJNOFehci6xuWgmDw8/xQrKex6bjvNRk+EglJe5amj90pHL35k/W+ARhLZQxRkglHKAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <biju.das.jz@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <chris.paterson2@renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 2/2] drm: atomic helper: fix W=1 warnings
Thread-Topic: [PATCH 4.19.y-cip 2/2] drm: atomic helper: fix W=1 warnings
Thread-Index: AQHWcU1K6+wOlLYZ+UGbpWIvTd/OyKk2g78AgAmWHHA=
Date: Wed, 19 Aug 2020 23:16:19 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983EFF3C8CD4DDA63FCEF18925D0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200813083925.7830-1-biju.das.jz@bp.renesas.com>
 <20200813083925.7830-2-biju.das.jz@bp.renesas.com>
 <20200813204902.GB24086@duo.ucw.cz>
In-Reply-To: <20200813204902.GB24086@duo.ucw.cz>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bb79ce6-3985-4679-221b-08d84495e1a2
x-ms-traffictypediagnostic: OSBPR01MB2246:
x-microsoft-antispam-prvs: <OSBPR01MB224677F39CAA7C97C8D7CB3F925D0@OSBPR01MB2246.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:317;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pG64Q26E1U/iviKr+uodA441jceDIlL2V4muo/Uz4VmwULn0FxcPSDfJ9wYlr4CKvosSWMaOhGO+Vg3QS89fNdWPrEHJJxTgU3ghDt5xQhuE2OdMj82aXKG2daJKGVw0wn5KcYfKfwePAWOKhF7ODnnVYsI1IioFUw1SQoaqUUXUvccwn4p+5dA4K26Okr84q5iRPgO8701sH+lUlPLIKDzxW7230fLnCggoHxQWXudhpNgd5+L8Hcrle66t/ytQL+PWKTEzV4SI+uvlKMqQsH7fq5H3d0xi0/IXLC7pWQ97VRJFiQfBV/8WnNtPz3ckbUCWwzv1msCrCaTdgcE7NwOXs9GdkiMuar6rhvEO+dM=
x-ms-exchange-antispam-messagedata: KEHQ5Cwfxz1jMarRXsHhJkj27IxLWl0C9cAUh/jvOKNhCxTb7d8uLScuEIN+vDPWQmEwY5+yqdCmMq8LcCKOAF3ijZQ8HZLohpXviiI+a8A/5FFOjYqABgD/s95oDhSycjMtm2PSM+SQkDjncbcrN0xhR/41vZXNykuMOCYWIUoihWN8UvpRhjjfTD5xrLcVs3NFfez4K0TTayyW4R3IXDhX01pU0FaWVsjxNKK10ZnuJMLh0p2YGs+6ULH4YGuX52KPzWj3++7h+N3U7U4q6rywBV3xQd65zJneyllSjUvbqR+eb6zGoa2tJGF3CuQoFYav+KLRC+O+ESImVw93D9GJr8j4Gkj0Zy1a022a/pwhsCfEekCIp8/k4yUU7QpquMlPhnxFFFrvtKd4NMfmbCYboNwxIAGB8HamQhRZIzsV5cNodjsw1ddYYEsHyEXcH+37ol7T3RDTQBgbIui8KWb1+Nq+SK10y2nnWv1FqA3cr/eWSkZRgNIsGHWNNnI3EhJaiY55l7fJxJ/cKDMgxb4RNES6DjkdwthnkoIZn+5yR0PVBHq4h1pOD6BlpZ4UlLb6cWfrfjLWKWXQnAjJxpCMWytS0G8L7+99FUCK9FcAvmhQqDiupELm221mB9WjxFrUVFeJLIq8nOzGy+RApA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb79ce6-3985-4679-221b-08d84495e1a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 23:16:19.8610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HkhS1rk8HD2kApD8G8nCGANeSdO+K0gxy87w7k4o/YU6NeMI5/u35gbCiFrn38Hu4lOqv3+VhDZrRoQ+3deScNjGDYe+WNoSJVUEmkDHgXx77r5ImwlG7KQ/bHBCXUcQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2246
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: QJsZR6JwiCfeLXS01yWnhe01x4520388AA=
Content-Type: multipart/mixed; boundary="kareDyBHa8VhntEjRFj3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597878996;
 bh=Kglsb7iWUsn9Gpvu3j3xUcO+dz4siwfb8vjJlpIwRiw=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=jINTeB85cKoR9YAp9bUEWCXmB/gsUzAjG5bSw1NzhLMOgPOom9dH8gJ7Air7M4IWiPn
 wvXtx50UtoMTu2ywZXSYqUpK2HWihcWMwxSMFKM2hDmlCDhr5wOE0kAJie7wxFxK0HdDO
 /rnIFrzM4BwM7+4xvJF25krA5De63+w/MU8=

--kareDyBHa8VhntEjRFj3
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUGF2ZWwsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwg
TWFjaGVrIFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMTQs
IDIwMjAgNTo0OSBBTQ0KPiBUbzogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29t
Pg0KPiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGl3YW1hdHN1IG5vYnVoaXJv
KOWyqeadviDkv6HmtIsg4pah77yz77y377yj4pev77yh77yj77y0KQ0KPiA8bm9idWhpcm8xLml3
YW1hdHN1QHRvc2hpYmEuY28uanA+OyBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+OyBDaHJp
cyBQYXRlcnNvbiA8Y2hyaXMucGF0ZXJzb24yQHJlbmVzYXMuY29tPjsNCj4gUHJhYmhha2FyIE1h
aGFkZXYgTGFkIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggNC4xOS55LWNpcCAyLzJdIGRybTogYXRvbWljIGhlbHBlcjogZml4
IFc9MSB3YXJuaW5ncw0KPiANCj4gSGkhDQo+IA0KPiA+IEZyb206IEJlbmphbWluIEdhaWduYXJk
IDxiZW5qYW1pbi5nYWlnbmFyZEBzdC5jb20+DQo+ID4NCj4gPiBjb21taXQgYmY1ZDgzN2EwYTRj
ZWQ3Y2MyMjNiZWZjOWU3NmQ0YWQzMDY5N2QyNyB1cHN0cmVhbS4NCj4gPg0KPiA+IEZldyBmb3Jf
ZWFjaCBtYWNybyBzZXQgdmFyaWFibGVzIHRoYXQgYXJlIG5ldmVyIHVzZWQgbGF0ZXIgd2hpY2gg
bGVkDQo+ID4gdG8gZ2VuZXJhdGUgdW51c2VkLWJ1dC1zZXQtdmFyaWFibGUgd2FybmluZ3MuDQo+
ID4gQWRkICh2b2lkKShmb28pIGluc2lkZSB0aGUgbWFjcm9zIHRvIHJlbW92ZSB0aGVzZSB3YXJu
aW5ncw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gR2FpZ25hcmQgPGJlbmphbWlu
LmdhaWduYXJkQHN0LmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogRGFuaWVsIFZldHRlciA8ZGFuaWVs
LnZldHRlckBmZndsbC5jaD4NCj4gPiBMaW5rOiBodHRwczovL3BhdGNod29yay5mcmVlZGVza3Rv
cC5vcmcvcGF0Y2gvbXNnaWQvMjAxOTEwMDgxMjQyNTQuMjE0NC0xLWJlbmphbWluLmdhaWduYXJk
QHN0LmNvbQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5l
c2FzLmNvbT4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIGZpeGVzLiBBcHBsaWVkIGFuZCBwdXNoZWQg
b3V0Lg0KDQpUaGlzIHBhdGNoIGRvZXNuJ3Qgc2VlbSB0byBoYXZlIGJlZW4gcHVzaGVkIHlldC4N
CkNvdWxkIHlvdSBwdXNoIG1lPw0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IAkJCQkJCQkJCVBh
dmVsDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0KPiANCj4gLS0NCj4gREVOWCBTb2Z0
d2FyZSBFbmdpbmVlcmluZyBHbWJILCAgICAgIE1hbmFnaW5nIERpcmVjdG9yOiBXb2xmZ2FuZyBE
ZW5rDQo+IEhSQiAxNjUyMzUgTXVuaWNoLCBPZmZpY2U6IEtpcmNoZW5zdHIuNSwgRC04MjE5NCBH
cm9lYmVuemVsbCwgR2VybWFueQ0K

--kareDyBHa8VhntEjRFj3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5156): https://lists.cip-project.org/g/cip-dev/message=
/5156
Mute This Topic: https://lists.cip-project.org/mt/76165489/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--kareDyBHa8VhntEjRFj3--
