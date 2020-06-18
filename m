Return-Path: <SRS0=Lt4i=77=lists.cip-project.org=bounce+64572+4804+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDF3C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 18 Jun 2020 07:27:20 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA6B21548
	for <cip-dev@archiver.kernel.org>; Thu, 18 Jun 2020 07:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="JQ/bORai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA6B21548
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4804+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Kq8IYY4521723xraJ1osk3pP; Thu, 18 Jun 2020 00:27:19 -0700
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.118])
 by mx.groups.io with SMTP id smtpd.web11.2381.1592465237590251845
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jun 2020 00:27:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6u/jz0jd4ViMhapDIX8KLVmtTTuX+OeCMt+h65+HJHTLUz8FDhk8N/pY+W9eeOZCfCnYkLGFVHHMTS6CtWRo0/jCTz0iWG0fcaie87MglF1jd6kiLXpNVBMv3aHnqis4NALG9S1qeZ5aMrxMAYbX3Ee2kyjbak1m8LvF9+6Nw3c+YgO3MyMiL1IFH2GmvssiSBttzC7L39ChqdS12uu9T5arF0LYNdZyURgLJOM5zBt4fVEmlCIjULodfaV3rTSHXRIfa5OzCp6+s5kDbO1v3r6WS/ohcrrOLqx3aTTSC0Uj9w+NdI1/pTyP2Zsy/gwkREWJ+bTGLBWD4Bu/fkQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQj3ievdkb2bmiA8EJvqCgZt/LqAx7FCga1yc2r6GYM=;
 b=EQiz7AY6Tg4YJDJ5H5e46I2vSmBFvKxrvhyOwDwXtTMWrU9OHvH3n+HHYs+CCnvWUsOb210VoLnXXTvhMbuiFEM28LQyvoLZwR5eXqsBDKEuzSx6zb4zsnnS8eQZvONl6MOxplALsaFl8v9gBOenbK9KP9+KUtGE2mmVQXeetqtgJnspkn95SaiKklPHneNoqFqbP2XtmDSTT2htIPYXD7MTVJ58cj0SSaC16m0mLGkMminnyMFKRkveRqpYHKEkq8KEx44HL++CfZqF+bmChO9aQmovNlR1rKxet4y12I+xuTtdQRE28OFt887XV/toHvTIZ3JOsAXoKuIRDSDCQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB4956.jpnprd01.prod.outlook.com (2603:1096:404:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 07:27:13 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 07:27:12 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: [cip-dev] CIP IRC weekly meeting today
Thread-Index: AdZFBivWuOLGgeYmT9uB8s67CZkn1wAOfFlQAABmiJA=
Date: Thu, 18 Jun 2020 07:27:12 +0000
Message-ID: 
 <TY2PR01MB49720DA22555E9110F3EF324A09B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB4972E56562DC57F5B8298721A09B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <OSBPR01MB2983E460267AF655E16E83FD929B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB2983E460267AF655E16E83FD929B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2a85d09-dfb7-44b9-9563-08d8135904fd
x-ms-traffictypediagnostic: TY2PR01MB4956:
x-microsoft-antispam-prvs: 
 <TY2PR01MB4956DD4B81346026CEB085F5A09B0@TY2PR01MB4956.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 ZZEe3NSCchc/VAkHsncxwwe3NubXuAZRqnPw4hEqyAzJGIekL0vXXK1+dkfD+Edjc9tJBjhDkKvlBWNoHcSzhcGDYu598CPoo9k7yf2Ua7uycHEBkYbLEM/Rc7C85jFHDbNH2Sux+uXKtZAHIEfhuPsQm8+X7PrdTj5aG6x7MDTqLKCB2kzD85HTkKapXjjQM437dSXUazpdpf+h7mHUGYnfbx2+BDMTnFe+1kH3kUPiKXdD5pJXBVr1cWI+Olc89yRUjiIqJ1EHSTuyrhZkgU17JsCdHkHSkwJJwkKZXc8q8xTTjLP7ft0ItdPOozQmP4o5Oe82yApJg0blVv7YKbmXmZPXeMXOg3Vs1IDSEdLmyrj0i8ATlptKSdjzXr8qHRlhtyM8zFdIMCJzerHQww==
x-ms-exchange-antispam-messagedata: 
 ++fd0MufwE3UXKd9pcEsYp2dskgk3vXKCHcnPyHwTcg8kO0bSb0cY9gmsDKeds6YkbbAIKLlUVYK9xPS74WkNQLSMXu+Mypwn/bZB97ckCUMy5Fl08LMOekwl9klJAGk9M1LimMiXuSns02wP598Ie2BvN2IUIw0kbFcQvqLjbguC985j17wb3XVfLByTKH6FIf2lJ5UXveX4YLqXdya+NsWU31FVSNM56Eqh4oWt+wjsid0IOGP20+fHIrYShMIbQK+yxsrBr8zTOC/giYBb//IWb50e+avckebkOZW++CFZrvqqlQf2Zl+qIIOijb9wiDnWBCA1qvJqzF/9ewTMZDcM6Opfju3BVwjxZvLD7FBgx/lefE7iAsDL62iarJGNWBdAdKa2gJQ1HFfZ6D/earTg1/IGro1Lsj2c7hNMlGMJCQL8UXAYHsnsDBR4OF115lxFEF/nOjzvs29uxUl5VtR3Qxo/AwZJM282OB9jLIQwNK8u6/lUhbxwCZwKE3w
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a85d09-dfb7-44b9-9563-08d8135904fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 07:27:12.8630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8Qjeq3MFfQ81z0K9PqSHGtOlc041ykCqU3vH/o61BlDYv7HSgVNzec7ZImxqMUNE9KEgPqDG9a0KRSstSpUutJ6BwHiCovi02Up3tzr0zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4956
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UqCEUjrVSOzPOXjg9IrlCpU6x4520388AA=
Content-Type: multipart/mixed; boundary="aGAVKej7GbHSzKopDqJ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1592465239;
 bh=8zDU/eFbZUwgPTS1Fqs/gEbaSBX5T8YkZDvSEJO/PJY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=JQ/bORaiwtoDrULvkIxcbAwZpdmL3DOOyY5/hs1hmZwtK0iCUD62no/fLn+RjbGbr5Y
 Nk1Pgk8cZcb47pgscpoglVdHmh6MsaaIr0UrOXPspM37EBW5fwd5qYJJYPeuFdPJ+tV/K
 HEJftI8D1BmqFVN4L5YR8e5sVKDf4wDnCzE=

--aGAVKej7GbHSzKopDqJ0
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksIEl3YW1hdHN1LXNhbiwNCg0KVGhhbmtzIGZvciB5b3VyIHVwZGF0ZXMuIEJ1dCwgaG93IGFi
b3V0IHRoZSBmb2xsb3dpbmc/DQoNCj4gICA1LiBJc3N1ZXMgdG8gYmUgZml4ZWQgZm9yIHN3dXBk
YXRlICJjb3B5cmlnaHQgY29ycmVjdGlvbiBhbmQgc2Fsc2EgDQo+IENJIHRlc3RpbmciIC0gaXdh
bWF0c3UNCg0KQmVzdCByZWdhcmRzLA0KLS0NCk0uIEt1ZG8NCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxp
c3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mIE5vYnVoaXJvIEl3YW1hdHN1DQpTZW50
OiBUaHVyc2RheSwgSnVuZSAxOCwgMjAyMCA0OjE5IFBNDQpUbzogY2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmcNClN1YmplY3Q6IFJlOiBbY2lwLWRldl0gQ0lQIElSQyB3ZWVrbHkgbWVldGlu
ZyB0b2RheQ0KDQpIaSwNCg0KSSBjYW4gbm90IGF0dGVuZCBJUkMgbWVldGluZyB0b2RheSwgc29y
cnkuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgDQo+IFttYWlsdG86Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5v
cmddIE9uIEJlaGFsZiBPZiANCj4gbWFzYXNoaS5rdWRvQGN5YmVydHJ1c3QuY28uanANCj4gU2Vu
dDogVGh1cnNkYXksIEp1bmUgMTgsIDIwMjAgOToyMCBBTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmcNCj4gU3ViamVjdDogW2NpcC1kZXZdIENJUCBJUkMgd2Vla2x5IG1lZXRp
bmcgdG9kYXkNCj4gDQo+IEhpIGFsbCwNCj4gDQo+IEtpbmRseSBiZSByZW1pbmRlZCB0byBhdHRl
bmQgdGhlIHdlZWtseSBtZWV0aW5nIHRocm91Z2ggSVJDIHRvIGRpc2N1c3MgdGVjaG5pY2FsIHRv
cGljcyB3aXRoIENJUCBrZXJuZWwgdG9kYXkuDQo+IA0KPiAqUGxlYXNlIG5vdGUgdGhhdCB0aGUg
SVJDIG1lZXRpbmcgd2FzIHJlc2NoZWR1bGVkIHRvIFVUQyAoR01UKSAwOTowMCANCj4gc3RhcnRp
bmcgZnJvbSB0aGUgZmlyc3Qgd2VlayBvZiBBcHIuIGFjY29yZGluZyB0byBUU0MgbWVldGluZyog
DQo+IGh0dHBzOi8vd3d3LnRpbWVhbmRkYXRlLmNvbS93b3JsZGNsb2NrL21lZXRpbmdkZXRhaWxz
Lmh0bWw/eWVhcj0yMDIwJm0NCj4gb250aD02JmRheT0xOCZob3VyPTkmbWluPTAmc2VjPTAmcDE9
MjI0JnAyPQ0KPiAxNzkmcDM9MTM2JnA0PTM3JnA1PTI0MSZwNj0yNDgNCj4gDQo+IFVTV2VzdAlV
U0Vhc3QJVUsJREUJVFcJSlANCj4gMDI6MDAJMDU6MDAJMTA6MDAJMTE6MDAJMTc6MDAJMTg6MDAN
Cj4gDQo+IENoYW5uZWw6DQo+ICogaXJjOmNoYXQuZnJlZW5vZGUubmV0OjY2NjcvY2lwDQo+IA0K
PiBMYXN0IG1lZXRpbmcgbWludXRlczoNCj4gaHR0cHM6Ly9pcmNsb2dzLmJhc2Vyb2NrLm9yZy9t
ZWV0aW5ncy9jaXAvMjAyMC8wNi9jaXAuMjAyMC0wNi0xMS0wOS4wMA0KPiAubG9nLmh0bWwNCj4g
DQo+IEFnZW5kYToNCj4gDQo+ICogQWN0aW9uIGl0ZW0NCj4gICAxLiBDb21iaW5lIHJvb3QgZmls
ZXN5c3RlbSB3aXRoIGtzZWxmdGVzdCBiaW5hcnkgLSBpd2FtYXRzdQ0KDQpObyB1cGRhdGUuDQoN
Cj4gICAyLiBQb3N0IExUUCByZXN1bHRzIHRvIEtlcm5lbENJIC0gcGF0ZXJzb25jDQo+ICAgMy4g
QXNrIGJvYXJkIG93bmVycyB0byByZXZpZXcgcmVmZXJlbmNlIHBsYXRmb3JtIGNvbmZpZ3MgdG8g
b3B0aW1pemUgYmFja3BvcnRpbmcgLSBtYXNhc2hpOTEwDQo+ICAgNC4gQ2hlY2sgQ1ZFIGFuZCBQ
YXRjaCwgQmx1ZXRvb3RoIEJBSVMgYXR0YWNrIChDVkUtMjAyMC0xMDEzNSkgLSANCj4gaXdhbWF0
c3UNCg0KTm8gdXBkYXRlLg0KTm8gdXBkYXRlICAvIHdvcmsgY2FuIGJlIHNlZW4gZXZlbiBpbiBV
cHN0cmVhbSBldGMuDQoNCj4gICA1LiBJc3N1ZXMgdG8gYmUgZml4ZWQgZm9yIHN3dXBkYXRlICJj
b3B5cmlnaHQgY29ycmVjdGlvbiBhbmQgc2Fsc2EgDQo+IENJIHRlc3RpbmciIC0gaXdhbWF0c3UN
Cj4gDQo+IE5vdGU6IFRoZSBmb2xsb3dpbmdzIGFyZSAyMDIwIEtlcm5lbCBUZWFtIFJvYWRtYXAg
c3R1ZmYuIElmIHRoZXJlIGFyZSANCj4gYW55IHByb2dyZXNzZXMgSSB3aWxsIHJlcG9ydCBhdCB0
aGUgIktlcm5lbCBtYWludGVuYW5jZSB1cGRhdGVzIiBpbiBmdXR1cmUuDQo+ICAgKy4gU3RyZW5n
dGhlbiBzdXN0YWluYWJsZSBwcm9jZXNzIHRvIGJhY2twb3J0IHBhdGNoZXMgZnJvbSBNYWlubGlu
ZS9MVFMgLSBLZXJuZWwgVGVhbQ0KPiAgICsuIFVwbG9hZCBhIGd1aWRlbGluZSBmb3IgcmVmZXJl
bmNlIGhhcmR3YXJlIHBsYXRmb3JtIGFkZGl0aW9uIC0gDQo+IG1hc2FzaGk5MTANCj4gDQo+ICog
S2VybmVsIG1haW50ZW5hbmNlIHVwZGF0ZXMNCg0KSSByZXZpZXdlZCBMVFMtcmMuIEkgc2VuZCBh
IGNvbW1lbnQuDQoNCj4gKiBLZXJuZWwgdGVzdGluZw0KPiAqIFNvZnR3YXJlIHVwZGF0ZQ0KPiAq
IENJUCBTZWN1cml0eQ0KPiAqIEFPQg0KPiANCj4gVGhlIG1lZXRpbmcgd2lsbCB0YWtlIDMwIG1p
biwgYWx0aG91Z2ggaXQgY2FuIGJlIGV4dGVuZGVkIHRvIGFuIGhvdXIgDQo+IGlmIGl0IG1ha2Vz
IHNlbnNlIGFuZCB0aG9zZSBpbnZvbHZlZCBpbiB0aGUgdG9waWNzIGNhbiBzdGF5LiBPdGhlcndp
c2UsIHRoZSB0b3BpYyB3aWxsIGJlIHRha2VuIG9mZmxpbmUgb3IgaW4gdGhlIG5leHQgbWVldGlu
Zy4NCj4gDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0KPiBCZXN0IHJlZ2FyZHMsDQo+
IC0tDQo+IE0uIEt1ZG8NCj4gQ3liZXJ0cnVzdCBKYXBhbiBDby4sIEx0ZC4NCg==

--aGAVKej7GbHSzKopDqJ0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4804): https://lists.cip-project.org/g/cip-dev/message=
/4804
Mute This Topic: https://lists.cip-project.org/mt/74949757/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--aGAVKej7GbHSzKopDqJ0--
