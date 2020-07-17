Return-Path: <SRS0=Prkl=A4=lists.cip-project.org=bounce+64572+4933+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86945C433E3
	for <cip-dev@archiver.kernel.org>; Fri, 17 Jul 2020 06:35:10 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D9422B4D
	for <cip-dev@archiver.kernel.org>; Fri, 17 Jul 2020 06:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BLWHHiHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D9422B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4933+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HvaWYY4521723xtYR7JSavqJ; Thu, 16 Jul 2020 23:35:09 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.6219.1594967706357656668
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2020 23:35:08 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 06H6YtPG002344; Fri, 17 Jul 2020 15:34:55 +0900
X-Iguazu-Qid: 2wHHQAbmwezwjwqyB9
X-Iguazu-QSIG: v=2; s=0; t=1594967694; q=2wHHQAbmwezwjwqyB9; m=RMnINBqC1c3KDDpvZwp18Mue5G6dSguiVkz/1BHSeA8=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1110) id 06H6YrIe033357;
	Fri, 17 Jul 2020 15:34:53 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 06H6YrY8024799;
	Fri, 17 Jul 2020 15:34:53 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 06H6Yrl5004970;
	Fri, 17 Jul 2020 15:34:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVdtyqwV3gTADGeWWRp/21nfu9LpUt4Y9CLR7W3f4zSvvT/j0VuFVog+QExOR2pDPCD33YzzjOW1PemgsiAHZOaSaHTBOlI6HSXnUJ7d6XvGVlLXXiA2R6H8NlcwCZs0KcjUtlirZ75pZ7hcw8ukkJGkTxXIIZi1jx+//BBGi53xGY0F8usyetOKuAVAMCK8yKIvMycLAo+KqOt9djevCtkS+1hLDgDcb73vsdsTAznZypFCgxdjk6Dypr4TcMePcGX/+NxAgzaiUb2nrfrtEyUDvJkTX+Z/9Ch2U+F3w6BFOji5zPgJhuvuW88G/uX+/4kBat1rDpZOrro7q79rBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B/jJGxAGgzK21fVCkdzlBFt/1NbM3n1CV12O2tnz8A=;
 b=fHiIOs9gPl69WIfZUPUBfrOO0jDM8nRnl7Ddx9OoyyMjy+/BznE8cwlUU9Pk1FuX//O8Of7MDVRmb04cqcmKd/Ou4WOwnTAo4Z/exMWlgceQ0LD6WkBbhHxEtlIy/p9tr/RbUEKM5zvrPiATKg9d4cuJ/x2PShNXLzooC7gpus2O6Hir9nR0VMsEU5IwnIAjKoXepG9w8J5zi3iaY9DrlnRYIHK8UL/+xseCvnxNPjutbJQQOUpP5GG8knurA57K3rnjh1LNEdghQbS0iq22VsbvUxyXfl73kkVnFLRMvaBepZIRZpxVjRp3mnuAHCMtoNIrF5qXddiOIUc/ff02hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] serial: sh-sci: Make sure status register SCxSR is read in correct sequence
Thread-Topic: [PATCH 4.4.y-cip] serial: sh-sci: Make sure status register
 SCxSR is read in correct sequence
Thread-Index: AQHWW3TrboPtyy8HS0eA3gyZrW15dqkLUGCQ
Date: Fri, 17 Jul 2020 06:34:51 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298306064FDC07010DDC9E2D927C0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <1594905847-54471-1-git-send-email-biju.das.jz@bp.renesas.com>
In-Reply-To: <1594905847-54471-1-git-send-email-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b355b3bc-8705-400d-e435-08d82a1b8265
x-ms-traffictypediagnostic: OSBPR01MB5062:
x-microsoft-antispam-prvs: <OSBPR01MB5062D0E800E6C99DEF9A36A3927C0@OSBPR01MB5062.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OyPV/AR9lZpGHpvVwwnDuLGv2v/QPey4MghJ2GkmFbcmyk4pJ9GLIFxqEU/PC+5zJHGuupE/NlAXBn8Qfyp29isRf2u2jthiHtSxHOTaCpNTjMc/9dcbphZZih26JbPSYlOV/QFkZCBqa1gnDwLowzTmUAEW/50DUkTjy6rCnEtejhdiQS5qkkWP1H8EfFhQA7qpi+R+eIUL/8MZ4KOvV1rwCNWXQmwUnU9U2QaaNZFaFvCrPFHPrzRBle7KbgPyB/OsJ1j2b9d3IEbaDyq3FWHl18BLJAGkeWUaYirzrJy+cKksfR44IuRaVT00x5Z0Rg0LVJa6cd/scUiLUI6kcGPCaw/jznxsTg2KOEj3cN2Df4FGUf0/YqXod6wmZlQsztVydW8YSekw2KbyUSUhqw==
x-ms-exchange-antispam-messagedata: LJsslTCWszKW6R302Io6dOlr1Z6xjD8MHtezIj8A4bc7xfAbzcGTixpxQHTpCnoF4NET0gXjSvtSaT13vFe76/rpfVGUgQKNDvaZ5V5fu+uoK28BQUWQsQYp93QA5oxrKWEz3ysvbBgDtGXd5HFJZnGQfdQeQ4Us0dgx+y07YTjP+dM8Mt8U0Tm4CMiia199f1aixQyZOUF996M6EH3ZHw5+I703RgEjPKdkYGCrDo1EP58simz2Bs8uDm0K09JmHcQ+lNedfxr3fOLgqIYCnjhbU7iraao808E8iVSAcw2CoQ8EE0sF/uxTA/s4EYN5ekjpZRxiVTR8EfAn8Fa9n6Oeet9OBXEJc33aOx9UPyzLKGtCP3FKS7oOo36GGazrhCNHen+iJSPXzGfqWQLTpIF3jy4Mk97es/7/aqFj7nJUvU5CKk4AIqPkyz+w63KswST54SFlQLwUGko6rvpnXsjtloVY/itjBIfPZXmfQUU=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b355b3bc-8705-400d-e435-08d82a1b8265
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 06:34:51.2035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xb/YjiEmnQfmqDWLOxT0iysUG9U/eKL0hqB3TJtC3Ygwq9uqz62crEsS0kgIV7BlWRmp/+Ksr+K4fmkNL9366zD6y+5CUu0+/mznp1ZYSya8o2G2CIn8y9fOWqwpcFcI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5062
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: OFrULpdEJHlgd0G0Dd7aMsSox4520388AA=
Content-Type: multipart/mixed; boundary="zLbbRuNnyd7mrdTyF6bL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594967709;
 bh=RiR9bCNskB5gaKUux/vxGLA0wEAoI1SAhqg5dYNL4Us=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=BLWHHiHiZ/xpkihIQdb+i1vxfaUAhD5oQIggEarwaqDoBdS2ybVX23+1hVc/VDh7z06
 fcTDpO3qLWDMjPkaEMuI9JVJ7XsHZQ2P7qQo6HnUnVa33QFrI2BjYuG1bcWLUNq5uttNu
 xPX0jADDCBzpcww8ueE02F+cdO0ZVGa9lS4=

--zLbbRuNnyd7mrdTyF6bL
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmlqdSBEYXMgW21h
aWx0bzpiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIEp1bHkg
MTYsIDIwMjAgMTA6MjQgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBp
d2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkN
Cj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgUGF2ZWwgTWFjaGVrIDxwYXZl
bEBkZW54LmRlPg0KPiBDYzogQ2hyaXMgUGF0ZXJzb24gPGNocmlzLnBhdGVyc29uMkByZW5lc2Fz
LmNvbT47IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT47IFByYWJoYWthciBN
YWhhZGV2IExhZA0KPiA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0K
PiBTdWJqZWN0OiBbUEFUQ0ggNC40LnktY2lwXSBzZXJpYWw6IHNoLXNjaTogTWFrZSBzdXJlIHN0
YXR1cyByZWdpc3RlciBTQ3hTUiBpcyByZWFkIGluIGNvcnJlY3Qgc2VxdWVuY2UNCj4gDQo+IEZy
b206IEthenVoaXJvIEZ1aml0YSA8a2F6dWhpcm8uZnVqaXRhLmpnQHJlbmVzYXMuY29tPg0KPiAN
Cj4gY29tbWl0IDNkYzRkYjM2NjIzNjYzMDZlNTRkZGNiZGE0ODA0YWNiMTI1OGU0YmEgdXBzdHJl
YW0uDQo+IA0KPiBGb3IgU0NJRiBhbmQgSFNDSUYgaW50ZXJmYWNlcyB0aGUgU0N4U1IgcmVnaXN0
ZXIgaG9sZHMgdGhlIHN0YXR1cyBvZg0KPiBkYXRhIHRoYXQgaXMgdG8gYmUgcmVhZCBuZXh0IGZy
b20gU0N4UkRSIHJlZ2lzdGVyLCBCdXQgd2hlcmUgYXMgZm9yDQo+IFNDSUZBIGFuZCBTQ0lGQiBp
bnRlcmZhY2VzIFNDeFNSIHJlZ2lzdGVyIGhvbGRzIHN0YXR1cyBvZiBkYXRhIHRoYXQgaXMNCj4g
cHJldmlvdXNseSByZWFkIGZyb20gU0N4UkRSIHJlZ2lzdGVyLg0KPiANCj4gVGhpcyBwYXRjaCBt
YWtlcyBzdXJlIHRoZSBzdGF0dXMgcmVnaXN0ZXIgaXMgcmVhZCBkZXBlbmRpbmcgb24gdGhlIHBv
cnQNCj4gdHlwZXMgc28gdGhhdCBlcnJvcnMgYXJlIGNhdWdodCBhY2NvcmRpbmdseS4NCj4gDQo+
IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogS2F6dWhpcm8g
RnVqaXRhIDxrYXp1aGlyby5mdWppdGEuamdAcmVuZXNhcy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IEhhbyBCdWkgPGhhby5idWkueWdAcmVuZXNhcy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEtBWlVN
SSBIQVJBREEgPGthenVtaS5oYXJhZGEucmhAcmVuZXNhcy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IExhZCBQcmFiaGFrYXIgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4N
Cj4gVGVzdGVkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJl
Pg0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzE1ODUzMzMwNDgtMzE4MjgtMS1n
aXQtc2VuZC1lbWFpbC1rYXp1aGlyby5mdWppdGEuamdAcmVuZXNhcy5jb20NCj4gU2lnbmVkLW9m
Zi1ieTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4g
U2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KDQpM
b29rcyBnb29kIHRvIG1lLg0KSSB3aWxsIG1lcmdlIGlmIG5vdGhpbmcgZWxzZSBpcyBtZW50aW9u
ZWQuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0KPiAtLS0NCj4gIGRyaXZlcnMvdHR5
L3NlcmlhbC9zaC1zY2kuYyB8IDEzICsrKysrKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
MCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdHR5L3NlcmlhbC9zaC1zY2kuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zaC1zY2kuYw0KPiBp
bmRleCAyMmY3MjAxLi4yYjViMzQyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwv
c2gtc2NpLmMNCj4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3NoLXNjaS5jDQo+IEBAIC03OTMs
OSArNzkzLDE2IEBAIHN0YXRpYyB2b2lkIHNjaV9yZWNlaXZlX2NoYXJzKHN0cnVjdCB1YXJ0X3Bv
cnQgKnBvcnQpDQo+ICAJCQkJdHR5X2luc2VydF9mbGlwX2NoYXIodHBvcnQsIGMsIFRUWV9OT1JN
QUwpOw0KPiAgCQl9IGVsc2Ugew0KPiAgCQkJZm9yIChpID0gMDsgaSA8IGNvdW50OyBpKyspIHsN
Cj4gLQkJCQljaGFyIGMgPSBzZXJpYWxfcG9ydF9pbihwb3J0LCBTQ3hSRFIpOw0KPiAtDQo+IC0J
CQkJc3RhdHVzID0gc2VyaWFsX3BvcnRfaW4ocG9ydCwgU0N4U1IpOw0KPiArCQkJCWNoYXIgYzsN
Cj4gKw0KPiArCQkJCWlmIChwb3J0LT50eXBlID09IFBPUlRfU0NJRiB8fA0KPiArCQkJCSAgICBw
b3J0LT50eXBlID09IFBPUlRfSFNDSUYpIHsNCj4gKwkJCQkJc3RhdHVzID0gc2VyaWFsX3BvcnRf
aW4ocG9ydCwgU0N4U1IpOw0KPiArCQkJCQljID0gc2VyaWFsX3BvcnRfaW4ocG9ydCwgU0N4UkRS
KTsNCj4gKwkJCQl9IGVsc2Ugew0KPiArCQkJCQljID0gc2VyaWFsX3BvcnRfaW4ocG9ydCwgU0N4
UkRSKTsNCj4gKwkJCQkJc3RhdHVzID0gc2VyaWFsX3BvcnRfaW4ocG9ydCwgU0N4U1IpOw0KPiAr
CQkJCX0NCj4gICNpZiBkZWZpbmVkKENPTkZJR19DUFVfU0gzKQ0KPiAgCQkJCS8qIFNraXAgImNo
YXJzIiBkdXJpbmcgYnJlYWsgKi8NCj4gIAkJCQlpZiAoc2NpX3BvcnQtPmJyZWFrX2ZsYWcpIHsN
Cj4gLS0NCj4gMi43LjQNCg0K

--zLbbRuNnyd7mrdTyF6bL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4933): https://lists.cip-project.org/g/cip-dev/message=
/4933
Mute This Topic: https://lists.cip-project.org/mt/75541395/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--zLbbRuNnyd7mrdTyF6bL--
