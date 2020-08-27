Return-Path: <SRS0=T8YO=CF=lists.cip-project.org=bounce+64572+5283+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DE7C433E3
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 11:35:25 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF29822CF7
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 11:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="r+NxDZX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF29822CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5283+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hJUZYY4521723xQWIYQzikqX; Thu, 27 Aug 2020 04:35:24 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.101])
 by mx.groups.io with SMTP id smtpd.web11.13545.1598512333003208976
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Aug 2020 00:12:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAHW7NT0k/i5EO959hhSZQOqG6VzyrwkISx41pjkUzorZ+Jnd3QXy2Qxr02fHpW5/rhqx28gT79OTC5qCdmypZtrvTRv6LVRRrMQKmF8urWDKz6IguVbPbPZKYb3KZZwoevEKh+rgC7ymg8yEDDgZz4LghTQYG3FRaTI1dj438VZIayLjnapd9NJzWdr3NWOArG7YFMXxXjdVyLI5DVROV4282Jli37c0TzPho1tnocsG1y5tiBuuWGcO82N0XPmriZovKC4ZB27PS/J5f9tEmZyv0/RbR2tdchXzT1Rp8l4xESs1s7qgiPu+xOMS+zmGPmgF0FgpDuwFvDFFgiolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVFvWjqNqu6tvvrSjPR6gVCF6kfjUflRNbOPs0ecRDM=;
 b=PPhAbxXqksNler6Ggh2JUcFKHEqPzWm95/6V+eM8hDEbqJgcJ70SW49rL47LFqMyRKj7uaz96Z8lva8evf4X7IzcDn2ai5nUhYh0xGM7NNmtINZDzf2pnnVMHRTXeB7RqqJz8F55eTD94q12FN9/gnnkH4DFnOk3fjIQ+75KBvwPJcuU1w6/UX7F1vQgUoHU8nLmaXsi64+zdXUPH1cxnfJ+Bh91A9kh+PBsty2nPRtL4aeGhNoEAlrBrS5337Qf4Uvq72mMXAvGFGdzE061d2Y/VtBVLh8w4LP8dpKGR1vhnXnBhfeA8FqPPSqTDPjH///snOYoiJBukLAIQ9TXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TYAPR01MB2528.jpnprd01.prod.outlook.com
 (2603:1096:404:90::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 07:12:09 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee%7]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 07:12:09 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
CC: Chris Paterson <Chris.Paterson2@renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/10] Add support for [H]SCIF/SDHI/I2C/RWDT/MSIOF
Thread-Topic: [PATCH 4.19.y-cip 00/10] Add support for
 [H]SCIF/SDHI/I2C/RWDT/MSIOF
Thread-Index: 
 AQHWe5sTPMVwRKFHTk6T2YjLVWDZRKlK7XkAgACTgfCAAAcvgIAAAGkwgAACM4CAAABJIA==
Date: Thu, 27 Aug 2020 07:12:09 +0000
Message-ID: 
 <TYBPR01MB5309DF39D17F1799EF822D2E86550@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
 <20200826214624.GB15974@amd>
 <TYBPR01MB53095251790B479E03B8D1F186550@TYBPR01MB5309.jpnprd01.prod.outlook.com>
 <20200827070003.GA20517@amd>
 <TYBPR01MB5309F4A53E0487828CB66B5686550@TYBPR01MB5309.jpnprd01.prod.outlook.com>
 <TYAPR01MB299093451ADBFF82CF94DECE92550@TYAPR01MB2990.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB299093451ADBFF82CF94DECE92550@TYAPR01MB2990.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [109.154.85.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6a4f6f0-e71d-4021-6d40-08d84a5883af
x-ms-traffictypediagnostic: TYAPR01MB2528:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TYAPR01MB2528F8F48125C1407931990186550@TYAPR01MB2528.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 KFy1vo+Q3s3GJOZ8eJA/mj56RHnOB2fd4C6IwHO/12TDY0VI8iCYCK/onhP10T+ypDtg+/TawmbwuK+oCVp1/QpYXYz+VfVd0khrig6EUdIme6qZrAiNIi1p7Ny2KJjriO1yWun/k2C5N8SUibvmL8wXOoRd9QrUFOBvphoMdgD2smNa/fE92evoYGnQqeTUUl32bt7Bv3Qdx3xIZhmr9mu53XTfNupfoQ7zZLI/nxsv+LOAUoiy2Xdstd80U9JaBvMvbT6tXmneaHak1EgOaoosvfKb5ViSi9J8iLg9mRTNW+9cuOtWZlFTPtCRQ/7gDhestadwLcAXLr+HiiGNWg==
x-ms-exchange-antispam-messagedata: 
 rx/OzLzmvIjH4+QW7WxOKAdAJrAPhms5KFF54OwX2v7Jr1u92qaFU2w6uRxHaE5yMpLzRZ8HuLDKygDzzlCK95X8zoVg/JOdAlBKdlztNedohkTtn95oo9RbPBejaUGbGSa9P6hst6c/yZjwDpzyMSo4evpCMYTLGOSepMaJ07gTTYjTNMJIZGQthKnjn/NBEWDbbTHKqAu4X0Zp9x3YivquiE/OGclWDYU63zhxFJgB3X8aSER7RwONQSjxaH8ulHQgN9ZQbd9eo8j4DNOJwGZLeQfGysIA4YCCZqxD/yvq+jAQH5oi3+iUKTniYv7js/+4EOHu3Xl0bUMtLo93RcF82DYGhAi9r0x4fCXzAtqZ9zdaTzVpfnHThHhF6CPwX+bWdmmAYbhqpnuF8OI/VC3/Qo9ixD2jT52vCTvAeI+JfbdCHafH6MLwf8T2MQa1Y1iZg+VLdmF9sG8upKAqG/D877BNhrW+Hi8BJv/0jsB6yBHiMA2RsdgPLSmfnfbziTgXDX23Z2HIWzc+y2z4YJXF1+e/CoYO6/hNwrKa+lozxxqcYbH9ki1BblB3cLk6lfT59RoGO/MJXu9bDQWXIXGO0l3kJH19ZTCi4YvrtovHr/9onpn3LSVenZr+kfz9JZYj3QOHwSwGjR/BT1+gLw==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a4f6f0-e71d-4021-6d40-08d84a5883af
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 07:12:09.8341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGWNOa0SSzgE7ew3O9RDr4uQo16xFkj/eb3QAPNbxf6JD0rOnmDIby/sYC1z5VlE3sXkAjaOXRfuoyinufETmi6tybo4CrzGzkV4QAUi9iE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2528
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 0NzS6MatzjdrVPIb9h97Sm45x4520388AA=
Content-Type: multipart/mixed; boundary="Y1G6gaIVCBwqs7lphJZa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598528124;
 bh=3z6KxCeVBYt81IUN6TMDa2x21dmdsKpMlpN3DbXk76Q=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=r+NxDZX4e2hcWx3jOrIkz+50gUgPd4c86+d34ygn1q5fPyruh04pPbXZr6SoQ2MSIP+
 Lj2m8V4jbXlJk+8IrRr5H2yyGtsq2M9hqnSh+XxIoU1xHEwCw6uAbiEN4TPD6FdhmIBI7
 l4FBzQJNOQL3N14vbTIe+KHOIk7Z69Dnl8Q=

--Y1G6gaIVCBwqs7lphJZa
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgTm9idWhpcm8sDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJF
OiBbUEFUQ0ggNC4xOS55LWNpcCAwMC8xMF0gQWRkIHN1cHBvcnQgZm9yDQo+IFtIXVNDSUYvU0RI
SS9JMkMvUldEVC9NU0lPRg0KPg0KPiBIaSwNCj4NCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+IEZyb206IEJpanUgRGFzIFttYWlsdG86YmlqdS5kYXMuanpAYnAucmVuZXNhcy5j
b21dDQo+ID4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAyNywgMjAyMCA0OjA3IFBNDQo+ID4gVG86
IFBhdmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT4NCj4gPiBDYzogQ2hyaXMgUGF0ZXJzb24gPENo
cmlzLlBhdGVyc29uMkByZW5lc2FzLmNvbT47DQo+ID4gY2lwLWRldkBsaXN0cy5jaXAtcHJvamVj
dC5vcmc7IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yzDQo+ID4g77y377yj
4pev77yh77yj77y0KSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+OyBQcmFiaGFr
YXINCj4gTWFoYWRldiBMYWQNCj4gPiA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVz
YXMuY29tPg0KPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggNC4xOS55LWNpcCAwMC8xMF0gQWRkIHN1
cHBvcnQgZm9yDQo+ID4gW0hdU0NJRi9TREhJL0kyQy9SV0RUL01TSU9GDQo+ID4NCj4gPiBIaSBQ
YXZlbCwNCj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KPiA+DQo+ID4gPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDQuMTkueS1jaXAgMDAvMTBdIEFkZCBzdXBwb3J0IGZvcg0KPiA+ID4g
W0hdU0NJRi9TREhJL0kyQy9SV0RUL01TSU9GDQo+ID4gPg0KPiA+ID4gSGkhDQo+ID4gPg0KPiA+
ID4gPiBUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCj4gPiA+ID4NCj4gPiA+ID4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIDQuMTkueS1jaXAgMDAvMTBdIEFkZCBzdXBwb3J0IGZvcg0KPiA+ID4gPiA+
IFtIXVNDSUYvU0RISS9JMkMvUldEVC9NU0lPRg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSGkhDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEFkZCBSWi9HMkggU29DIHN1cHBvcnQgZm9yIFtIXVNDSUYv
U0RISS9JMkMvUldEVC9NU0lPRiBvbg0KPiA+ID4gPiA+ID4gNC4xOS55LWNpcA0KPiA+ID4gPiA+
IGtlcm5lbC4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBBbGwgdGhlIHBhdGNoZXMgaW4gdGhp
cyBzZXJpZXMgYXJlIGNoZXJyeS1waWNlZCBmcm9tIE1MLA0KPiA+ID4gPiA+ID4gZXhjZXB0IFsx
XSB3aGljaCBpcyBhIG5ldyBwYXRjaCBzaW1pbGFyIHRvIHRoZSB3b3JrZG9uZSBmb3INCj4gPiA+
ID4gPiA+IG90aGVyIHNpbWlsYXIgU29DJ3MNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNlcmllcyBs
b29rcyBnb29kIHRvIG1lLiAoQnV0IGdpdGxhYiB0ZXN0aW5nIGRvZXMgbm90IHNlZW0gdG8NCj4g
PiA+ID4gPiB3b3JrLCBhbmQgaXQgd291bGQgYmUgZ29vZCB0byB0ZXN0IGl0IGJlZm9yZSBhcHBs
eWluZykuDQo+ID4gPiA+DQo+ID4gPiA+IEkgYW0gIG5vdCBzdXJlIGFib3V0IHRoZSBmYWlsdXJl
LiAgSWYgaXQgaXMgcmVsYXRlZCB0byB0ZXN0aW5nIG9uDQo+ID4gPiA+IFJaL0cySCBib2FyZCwg
dGhlbg0KPiA+ID4NCj4gPiA+IE5vLCBpdCBpcyBkZWZpbml0ZWx5IG5vdCByZWxhdGVkIHRvIHlv
dXIgYm9hcmRzLiBOb3RoaW5nIGV2ZXINCj4gPiA+IGJ1aWxkcy4uLiBpdCBjYW4ndCBiZSB5b3Vy
IGZhdWx0IG9yIGZhdWx0IG9mIHlvdXIgYm9hcmQsIGJ1dCBpdCBqdXN0IHByZXZlbnRzDQo+IHRl
c3RpbmcgOi0oLg0KPiA+DQo+ID4gSSBoYXZlIGFwcGxpZWQgdGhlIGVudGlyZSBzZXJpZXMgYW5k
IGl0IGJ1aWxkcyBmaW5lIGluIG15IGVudmlyb25tZW50IHdpdGgNCj4gbGludXgtNC4xOS55LWNp
cCg0LjE5LjEzOC1jaXAzMikuDQo+ID4gV2hhdCBpcyB0aGUgYnVpbGQgaXNzdWUgcmVsYXRlZCB0
byBnaXRsYWIgdGVzdGluZz8NCj4gPg0KPiBBcyBJIHdyaXRlIG90aGVyIG1haWwsIHRoaXMgc2Vl
bXMgdG8gYmUgYSBpc3N1ZSBpbiB0aGUgZW52aXJvbm1lbnQgdGhhdCBydW5zDQo+IGdpdGxhYiBy
dW5uZXIuDQoNCk9rLg0KDQpDaGVlcnMsDQpCaWp1DQoNCg0KUmVuZXNhcyBFbGVjdHJvbmljcyBF
dXJvcGUgR21iSCwgR2VzY2hhZWZ0c2Z1ZWhyZXIvUHJlc2lkZW50OiBDYXJzdGVuIEphdWNoLCBT
aXR6IGRlciBHZXNlbGxzY2hhZnQvUmVnaXN0ZXJlZCBvZmZpY2U6IER1ZXNzZWxkb3JmLCBBcmNh
ZGlhc3RyYXNzZSAxMCwgNDA0NzIgRHVlc3NlbGRvcmYsIEdlcm1hbnksIEhhbmRlbHNyZWdpc3Rl
ci9Db21tZXJjaWFsIFJlZ2lzdGVyOiBEdWVzc2VsZG9yZiwgSFJCIDM3MDggVVN0LUlETnIuL1Rh
eCBpZGVudGlmaWNhdGlvbiBuby46IERFIDExOTM1MzQwNiBXRUVFLVJlZy4tTnIuL1dFRUUgcmVn
LiBuby46IERFIDE0OTc4NjQ3DQo=

--Y1G6gaIVCBwqs7lphJZa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5283): https://lists.cip-project.org/g/cip-dev/message=
/5283
Mute This Topic: https://lists.cip-project.org/mt/76426354/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Y1G6gaIVCBwqs7lphJZa--
