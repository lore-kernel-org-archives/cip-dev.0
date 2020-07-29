Return-Path: <SRS0=611t=BI=lists.cip-project.org=bounce+64572+5044+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA69C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 11:06:53 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11918207E8
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 11:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="vrq1f7/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11918207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5044+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 74eVYY4521723xbDeFEjEzug; Wed, 29 Jul 2020 04:06:52 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.114])
 by mx.groups.io with SMTP id smtpd.web10.993.1596005828944069711
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2020 23:57:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIzw1EaCrC5ZTwIPOjK5FaeDEfahMaA0450T7dOJuUqnhX6yJA7F8s3zyDCI42UHHfAfyWOCB+jP2VZZvPXu5om/MUrV+j/TCoB/IAdeJn1bdghRlKLSoMubgsfRZHtOY8XLII0fSgSniWeXvray3JExjFYZg8vVvo+IaHpkpe37/N0nVpYETCxozKTo88lAk1dkr2+POTnM1YcSeyUkg1aHuVV2TrPtA62zB5/xrfVY8vIolN0ngl6FRHa8+0s40klxdLJTn50k9Zn6PZpyPhii2r5zTlE4gFNYC4utwsl7TFMooB7njBdLZLPSuBczgD5ohVFuNT4NRWr5meqIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zH1VgBaarPl6ISqNKb9qAb9H0nIWxL5WwYvR6j3LmiE=;
 b=ZvUeaP6wvER2c3MYWUl7jxkxHh1X3cXOo12RX5QqtGXey7f9dla1TTcz1RofK878npoCror0B0LBHhBWDkQGD8F+ta/dgUA5vfkfUo+ZlPQFENBiWivEn4HkUnziBBnUeb3Gdso8O0h6Y9w3cpklKukNaSafY2HSGyepdVhKo912F2gWOVdY01lnk4TTPAOjA2E2batEVT5ih7dJFrYnLOqadhi+Ep2tNeLWYlyW7ANTgTsxuKvrW6ivf4R6JO4qJt0MiqKx68hjeGLfWMdqQ9rt5I5oYgk37Qo7xKKQB+eH383BOReAZl02GkNFqfOSskc0L0peA/KQEHcP4Pk7Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TYXPR01MB1773.jpnprd01.prod.outlook.com
 (2603:1096:403:11::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Wed, 29 Jul
 2020 06:57:05 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::590e:ebc:1f09:f160]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::590e:ebc:1f09:f160%7]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 06:57:05 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Chris
 Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/9] Add LCD Panel support for RZ/G1E board
Thread-Topic: [PATCH 4.4.y-cip 0/9] Add LCD Panel support for RZ/G1E board
Thread-Index: AQHWZMvx6OMO5lbmLEur9xBb/KYmDKkddQCAgACflYCAAAxJkA==
Date: Wed, 29 Jul 2020 06:57:05 +0000
Message-ID: 
 <TYBPR01MB53098A1CCA0417F8A87285CE86700@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
 <20200728204015.GA1012@bug>
 <OSBPR01MB29832471AA67B88DCAE5F92F92700@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB29832471AA67B88DCAE5F92F92700@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [31.49.74.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d53630cf-eaea-422f-ca97-08d8338c9acc
x-ms-traffictypediagnostic: TYXPR01MB1773:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TYXPR01MB177390704926309E74EB35B886700@TYXPR01MB1773.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 yBXtjGDs2WS0zKgoTuXvUv3ffrDgTytsM7hpNE8DllZ3RgskJoRoUKWjL7ZA7QSawLa7vXRmhaFKjhK+/MASIimlI9rnS6yddHQscQ726Q2JUehZc/4ec0PctRwaclm+/6yga81CxOHmTsIoe5GfGTUCO9BkzUQdQ0hV5hpfFkCEXAAb4VjoAQ9XYWrsz8Rat18KT21I/4qkkPn2QhCy5OwPS0QqtXXj+ASWq28wBNyq23+3Beq6gIecBL1X6MlP+QQwfwAO6255CxmxABv0RDWApLG2bK7TQp5qeVxEivrmpZRJPPMBph9YIo/R9tRJtKKtj1an6zkweL/Xnu0OIQ==
x-ms-exchange-antispam-messagedata: 
 OpRp+qUyZl83S06gKqgOzHxXJnXADLkNpvG7mt0z+DfishTUziJ5g52ZUAeprudLr9tYR/2zuH1jIt37drpPzVVKnXdV7pX7kycuvs+3EtZUsS4HFBXmZChe+2HKhdJejX/cyEl73DwKU76zVqJujaojvo2V59rApyMGaafXrB3UNxutbWYkxCYkglPzLSh6Ww5yRjTxlHmCs/i5KC408bbo3nMa5+EUsxO9iH0L+SXPUO6SGmAEiaPzqCm9wAw99czqdm0LA0YGfQN1tVo6b4x1ghUhF7opiuMWLHgTAWqR5Lhx0w0qMg6a+rYSaLQ88Gwjy7jS9wzvfRQATaHZsc5ejzeSfoTb4X4BAsleuPtdkvaDjbGKxlnBuY/GI18/acTIu/PTvGtqrWhjNGQhYxy1k+4XsW4D3zLrRYwn4xx0ck+rW5PcN41+8dLwsaYOauvsVjHEDO9mL+ul6OkfXKZzPafZr84KMS77yHw2LWk=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53630cf-eaea-422f-ca97-08d8338c9acc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 06:57:05.6922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzcVQ4Tdg+cE3hU+DRWM5KdpqTuw/LMGK5hdjNYbrGvja8qQACV442rocE2GwG7TI2RkTPOomL68eJFBRDdk0WEnWVup8ftL60vaIeytwKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1773
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: HK3RaOidnv11ounJIdTxUM1cx4520388AA=
Content-Type: multipart/mixed; boundary="05VUpgkOSC3Po2AY45zS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596020812;
 bh=wJ4zUtKLiNxiZmyRtdGCp0R+K97RfRaDlv9sCWshhhs=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=vrq1f7/amYIKSQxCeeQMlnIPfa5ydpgBQgqgOA7nd/yMV0KqDdXba7lrfO+pYBxjYZp
 Oc01Ew1PB6WNWO5cBYMnWmfd3ecLAqZPyMqH/QM3FEmbvXbr89eYJjpZBJb9UcAuMqyzW
 T3rLCS/cCf2qhPz62NfVyz+sGwEI/IPfwlo=

--05VUpgkOSC3Po2AY45zS
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgQWxsLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiBTdWJqZWN0OiBSRTogW1BB
VENIIDQuNC55LWNpcCAwLzldIEFkZCBMQ0QgUGFuZWwgc3VwcG9ydCBmb3IgUlovRzFFIGJvYXJk
DQo+DQo+IEhpIGFsbCwNCj4NCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZy
b206IFBhdmVsIE1hY2hlayBbbWFpbHRvOnBhdmVsQGRlbnguZGVdDQo+ID4gU2VudDogV2VkbmVz
ZGF5LCBKdWx5IDI5LCAyMDIwIDU6NDAgQU0NCj4gPiBUbzogQmlqdSBEYXMgPGJpanUuZGFzLmp6
QGJwLnJlbmVzYXMuY29tPg0KPiA+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsg
aXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKMNCj4g4pev77yh77yj
77y0KQ0KPiA+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IENocmlzIFBhdGVy
c29uDQo+ID4gPGNocmlzLnBhdGVyc29uMkByZW5lc2FzLmNvbT47IFByYWJoYWthciBNYWhhZGV2
IExhZA0KPiA+IDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+ID4g
U3ViamVjdDogUmU6IFtQQVRDSCA0LjQueS1jaXAgMC85XSBBZGQgTENEIFBhbmVsIHN1cHBvcnQg
Zm9yIFJaL0cxRQ0KPiA+IGJvYXJkDQo+ID4NCj4gPiBIaSENCj4gPg0KPiA+ID4gQWRkIExDRCBQ
YW5lbCBzdXBwb3J0IGZvciBpV2F2ZSBSWi9HMUUgYm9hcmQgYmFzZWQgb24gcjhhNzc0NSBTb0Mu
DQo+ID4gPg0KPiA+ID4gQmFja3BvcnRpbmcgdGhlIHBhbmVsIHBhdGNoIGFzIGl0IGlzLCByZXF1
aXJlcyBkcm0gYnJpZGdlIEFwaQ0KPiA+ID4gY2hhbmdlcywgd2hpY2ggaXMgbm90IHByZXNlbnQg
YXQgNC40IGtlcm5lbC4gU28gdXNlZCB0aGUgNC40IHJtDQo+ID4gPiBmcmFtZXdvcmsgdG8gYXR0
YWNoIHRoZSBzaW1wbGUgcGFuZWwgZHJpdmVyIHdpdGggcmdiIGNvbm5lY3Rvcg0KPiA+ID4gZHJp
dmVyLiBUaGUgcmdiIGNvbm5lY3RvciBpcyBiYXNlZCBvbiB0aGUgd29ya2RvbmUgZm9yIHRoZSBs
dmRzDQo+ID4gPiBjb25uZWN0b3IuIFRoZSBkaXNwbGF5IHBhbmVsIGJpbmRpbmcgcGF0Y2ggaXMg
YmFja3BvcnRlZCB0byA0LjQNCj4gPiA+IGtlcm5lbCxzaW5jZSB0aGUgbWFpbmxpbmUgdXNlcyB5
YW1sIGZpbGUgYW5kIGl0IGNvbmZsaWN0IHdpdGggY29ycmVzcG9uZGluZw0KPiAudHh0IGluIDQu
NCBrZXJuZWwuDQo+ID4gPg0KPiA+ID4gT3RoZXIgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcyBhcmUg
Y2hlcnJ5IHBpY2tlZCBmcm9tIG1haW5saW5lLg0KPiA+DQo+ID4gSSBkb24ndCBzZWUgYW55dGhp
bmcgd3Jvbmcgd2l0aCB0aGlzLCBzbyBJJ2xsIHRlc3QvYXBwbHkgaXQgaWYgbm9vbmUgb2JqZWN0
cy4NCj4gPg0KPg0KPiBJIGRpZG4ndCBzZWUgYW55IGlzc2V1ZSB0aGlzIHBhdGNoZSBzZXJpZXMu
DQo+IFRoZSBDSSB0ZXN0IGlzIGZpbmUsIHNvIEkgY29tbWl0Lg0KPg0KPiA+IEkgZ3Vlc3Mgd2Ug
Y291bGQgbGlrZSBwYXRjaGVzIGZvciBjaXAta2VybmVsLWNvbmZpZyByZXBvc2l0b3J5IHRvDQo+
ID4gYWN0dWFsbHkgZW5hYmxlIHRoaXMgaW4gb3VyIHRlc3RpbmcuLi4NCj4NCj4gKzEuDQoNClN1
cmUgSSB3aWxsIHNlbmQgYSBuZXcgbWVyZ2UgcmVxdWVzdCBmb3IgY2lwLWtlcm5lbC1jb25maWcu
DQoNCkNoZWVycywNCkJpanUNCg0KDQpSZW5lc2FzIEVsZWN0cm9uaWNzIEV1cm9wZSBHbWJILCBH
ZXNjaGFlZnRzZnVlaHJlci9QcmVzaWRlbnQ6IENhcnN0ZW4gSmF1Y2gsIFNpdHogZGVyIEdlc2Vs
bHNjaGFmdC9SZWdpc3RlcmVkIG9mZmljZTogRHVlc3NlbGRvcmYsIEFyY2FkaWFzdHJhc3NlIDEw
LCA0MDQ3MiBEdWVzc2VsZG9yZiwgR2VybWFueSwgSGFuZGVsc3JlZ2lzdGVyL0NvbW1lcmNpYWwg
UmVnaXN0ZXI6IER1ZXNzZWxkb3JmLCBIUkIgMzcwOCBVU3QtSUROci4vVGF4IGlkZW50aWZpY2F0
aW9uIG5vLjogREUgMTE5MzUzNDA2IFdFRUUtUmVnLi1Oci4vV0VFRSByZWcuIG5vLjogREUgMTQ5
Nzg2NDcNCg==

--05VUpgkOSC3Po2AY45zS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5044): https://lists.cip-project.org/g/cip-dev/message=
/5044
Mute This Topic: https://lists.cip-project.org/mt/75842037/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--05VUpgkOSC3Po2AY45zS--
