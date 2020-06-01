Return-Path: <SRS0=nFTH=7O=lists.cip-project.org=bounce+64572+4655+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD27C433E0
	for <cip-dev@archiver.kernel.org>; Mon,  1 Jun 2020 11:14:10 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4498206E2
	for <cip-dev@archiver.kernel.org>; Mon,  1 Jun 2020 11:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BGm+xrDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4498206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4655+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jWwkYY4521723xnKgQToBMjU; Mon, 01 Jun 2020 04:14:09 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.97])
 by mx.groups.io with SMTP id smtpd.web12.34507.1591010047488880351
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Jun 2020 04:14:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjbvYNfPv7LrX6ddAKFTIfapMEVPL3Abkjjop25JAJLIjAMzzzrrnZN+jsN2YaodfwOAgLsyNz99BztZsxTVELW58MUf/AUjOzm4hSvyw7qO0ffOJDpUJ1lEDTOxX0y3CMW9r8IBeocQQOf4x0ADtA1Hup/29n2pj0fcF5x1S0ledWpRSLZstCjodL4P9lia/STqUpfX1pYWMVWZvcXTq8bkXSRPg42Ropo6OLvY7RZtgRz2Gbi3YfDmNXTvrSZEZn+LcLNQQtb5HnwI5g4q4tlJ+yRgAQkcbjPNZTRTa0cd+Q4E16i5us9BC+QU2n/T/IWFq1Jp9k1R4yCuJvAw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0b9YIkCkzJ29445wex0tA+N2R7JQnv1iz/6kBxHaQc=;
 b=Lt/oS9wkNFrQGToxL9slFkbql3j3EXSMdMwMuaXJTqEpOeMEmLAVtS667V0/tTSHNXPW82D/KwLR1/ZQQFRN28S607X7vfRoeV8TS00PoILZc9fH+VmAzGeQuw2yhHadwNSxdCkDoH64MDp55cDAvaXf4LYYCgQwX57HZKoKcT06KlmMsCAhS68hTJsb0tWTeSC+jRzakmj8PKaRIw+ul0fEKYob1XkgOWJlm3kKq2AtsByweY5dyOZkaeoZ7rDcWJ1yzthgB0eMACUbQ25idqIhOKA98Veh3pypb3A24uoupXJKbEnsetkWLCAljZX4qWxg1sg9MDrtC21jydsTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com (2603:1096:604:6e::21)
 by OSAPR01MB2289.jpnprd01.prod.outlook.com (2603:1096:603:1b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 1 Jun
 2020 11:14:05 +0000
X-Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::95a1:fced:dcb:8ca3]) by OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::95a1:fced:dcb:8ca3%6]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 11:14:04 +0000
From: "Marian-Cristian Rotariu" <marian-cristian.rotariu.rb@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: Chris Paterson <Chris.Paterson2@renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: Re: [cip-dev] [PATCH v4.4.y-cip] ARM: dts: iwg20d-q7-common: Add LCD support
Thread-Topic: [cip-dev] [PATCH v4.4.y-cip] ARM: dts: iwg20d-q7-common: Add LCD
 support
Thread-Index: AQHWM7GDsb80CT+ktkG4UCP9h7+uGai7bxjAgAgzhJA=
Date: Mon, 1 Jun 2020 11:14:03 +0000
Message-ID: 
 <OSAPR01MB502894936BCCC76DCBEE8CFFAE8A0@OSAPR01MB5028.jpnprd01.prod.outlook.com>
References: 
 <1590534014-2203-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <OSBPR01MB2983BF3C515D310B603EF90192B10@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB2983BF3C515D310B603EF90192B10@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ccacc5d-0432-47cb-5052-08d8061ce501
x-ms-traffictypediagnostic: OSAPR01MB2289:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSAPR01MB2289CC3C2C847CF61F2F9332AE8A0@OSAPR01MB2289.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 Oe9s93BPHVsGPpjMGzNbi/03hyhXmY/Nm+4wejhcXmGYyx6vJJ+ssT6ff3a92NAWl3EFivbSvh3n8c/1xU/pL1iqn5LrseuVX0RbK9CQ+UOYnfHB61fx39BOtVa4AqUXtC0Hm18Bx3uu9w51nlKVVkxjgb9Nkrml9Eyx6TQa0tObYyYHnTbCHs6LDZ4Jq49qaWxU4YFPkrfgLOH0ZRCGwsnY1s9RiR+Y2OiCW+3OwEi4prpV00uH6jSJEIPFTHcS70VE1K5ljD83qSeDw7Yne/SwU8YT7mT/zIcZHnQF8P/pBWdl2g4q2WTzx3LOOx6pcp3RSj+/GU+B+zKTgqrL5BLAUDuQkOPJoH1Nn+y0FGCrBFMca/DJ/7SdJFwwqoemIMkH/mmjBRI9mrIu0bFXDA==
x-ms-exchange-antispam-messagedata: 
 kZSGhoc746nhArTLh4eOabaU/qvhJ3n9L7e0f5YQp4orxF6M5qvKcJEmsPlsa3IHxpZruHHSx14iJ2JQPMLAIDFoSEdkHl+se+rxrWwAVD9nhp6By+j1CRYPS8IW0YOOefPmnqyJnZc+u6QYcz1PBpuZp+D0t6794vLc4DJXpPZqKuJW+Rl+82wbh2fMRrXyMXwbsKCrzna1ZoiaCbkX6NcFmyqJ1j6ucVO8JxW3XC/7h5+jsAdQ7DdNRwwgrBa4nDkstPZOtlahIoKCSC753PWYqn53/AstHjotnSKFJmFd9dcqP8mZ2MDF+lqYGTHxbSmroKLXmOZJ078KvC0ls9eBuX2phbhbONPd7qjxjlTfAW4f95V0nPryKHqL7eGGr5X5jhXm9k5nsgYlOpKPNRBYaj+F/kLNqJMCc+7Cm/u4j0MXlc9M9HJegIYk8EgjkGHrT0Pv67ZnA14S26oR+n+53N9cav2rL7SBKfXNRCtwdSJDuN0DtJ4RQMu6k8FU
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccacc5d-0432-47cb-5052-08d8061ce501
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2020 11:14:03.9397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GEp99zIZ59URPjuW181ApdSCdftEsD/vRbrMGCrV3YxjA/nDyJSC1l8V72MumxJaac+ZqaloE/iP8TL9dik2jAVxmtU6rhFaZAEOUQ7ol1kXdONoI7Y8YKTLiQWCtv0V1ylH8iPn8RNzIT0YXWyGKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2289
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: lYYptvQqXSsgLSEZSM9vzClix4520388AA=
Content-Type: multipart/mixed; boundary="0PxiMx5PATC5l0zgPlAZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591010049;
 bh=eV7Rm9jA7SOreXHL1v2tQDiOQ+CnOysoBylwXGdzG5Q=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=BGm+xrDo17odu+6+aNxgrL4ktHdDHmdteBKdWXBwFo29vjBEpVWE2fpq+TKJ/aZ4LPr
 /zMkZ14ObRRGIkQOLLq7tl/Uc59WJidl1T6ED/Keq0O4LtNbzIqRSLkq9ZK9s+Rp3xymY
 UGTaKLoLF9CaOfAqpqKSMB3vekY9ZcDquPI=

--0PxiMx5PATC5l0zgPlAZ
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgTm9idWhpcm8sDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXchDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcg
PGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbg0KPiBCZWhhbGYgT2YgTm9idWhpcm8g
SXdhbWF0c3UgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50OiAyNyBNYXkgMjAyMCAw
NzowNg0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gQ2M6IENocmlzIFBh
dGVyc29uIDxDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb20+OyBGYWJyaXppbyBDYXN0cm8NCj4g
PGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtjaXAtZGV2
XSBbUEFUQ0ggdjQuNC55LWNpcF0gQVJNOiBkdHM6IGl3ZzIwZC1xNy1jb21tb246IEFkZA0KPiBM
Q0Qgc3VwcG9ydA0KPiANCj4gSGksDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gPiBbbWFpbHRvOmNp
cC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnXSBPbiBCZWhhbGYgT2YgTWFyaWFuLUNyaXN0aWFu
DQo+ID4gUm90YXJpdQ0KPiA+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDI3LCAyMDIwIDg6MDAgQU0N
Cj4gPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gPiBDYzogQ2hyaXMgUGF0
ZXJzb24gPGNocmlzLnBhdGVyc29uMkByZW5lc2FzLmNvbT47DQo+ID4gZmFicml6aW8uY2FzdHJv
Lmp6QHJlbmVzYXMuY29tDQo+ID4gU3ViamVjdDogW2NpcC1kZXZdIFtQQVRDSCB2NC40LnktY2lw
XSBBUk06IGR0czogaXdnMjBkLXE3LWNvbW1vbjogQWRkDQo+ID4gTENEIHN1cHBvcnQNCj4gPg0K
PiA+IEZyb206IEZhYnJpemlvIENhc3RybyA8ZmFicml6aW8uY2FzdHJvQGJwLnJlbmVzYXMuY29t
Pg0KPiA+DQo+ID4gY29tbWl0IDZmODlkZDllOTMyNWQwNWIxZjU0ZDg2MGRiYmM4NGI0MmFhNDA3
NTkgdXBzdHJlYW0uDQo+ID4NCj4gPiBUaGUgaXdnMjBkIGNvbWVzIHdpdGggYSA3IiBjYXBhY2l0
aXZlIHRvdWNoIHNjcmVlbiwgdGhlcmVmb3JlIGFkZA0KPiA+IHN1cHBvcnQgZm9yIGl0Lg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm9AYnAu
cmVuZXNhcy5jb20+DQo+ID4gQWNrZWQtYnk6IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGlu
Y2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NCj4gPiBMaW5rOg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3IvMTU3MzY2MDI5Mi0xMDYyOS0xMS1naXQtc2VuZC1lbWFpbC1mYWJyaXppby4NCj4g
PiBjYXN0cm9AYnAucmVuZXNhcy5jb20NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHZWVydCBVeXR0ZXJo
b2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPiAocmVtb3ZlDQo+ID4gdGhlIExWRFMgZGVj
b2RlciBhcyB0aGVyZSBpcyBubyBkcml2ZXIgZm9yIGl0OyBhZGQgcGFuZWwgdGltaW5ncyB0bw0K
PiA+IHBhbmVsIG5vZGUgc2luY2UgdGhlIExWRFMgZHJpdmVyIHJlYWRzIHRoZW0gb2ZmIHRoZSBw
YW5lbCBEVCBub2RlKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmlhbi1DcmlzdGlhbiBSb3Rhcml1
IDxtYXJpYW4uYy5yb3Rhcml1QGdtYWlsLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm0vYm9v
dC9kdHMvaXdnMjBkLXE3LWNvbW1vbi5kdHNpIHwgODENCj4gPiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDgxIGluc2VydGlvbnMoKykNCj4g
Pg0KPiANCj4gSSB0aGluayB5b3UgZm9yZ2V0IGFkZGluZyBhIGZpeCB0byBhcmNoL2FybS9ib290
L2R0cy9pd2cyMGQtcTctZGJjbS1jYS5kdHNpLg0KDQpDYW4geW91IHBsZWFzZSBiZSBtb3JlIHNw
ZWNpZmljPyBUaGVyZSBzaG91bGQgbm90IGJlIGEgY29uZmxpY3QgYmV0d2VlbiB0aGUgdHdvIGRl
dg0KYm9hcmQgY29uZmlndXJhdGlvbnMuIEkgZG91YmxlIGNoZWNrZWQgdGhlIHR3byBkdHMsIGJ1
dCBpdCBzZWVtcyB0byBiZSBubyBpc3N1ZSBhbmQgdGhleQ0KcmVzZW1ibGUgd2hhdCBpcyBpbiB0
aGUgdXBzdHJlYW0ga2VybmVsLg0KDQpDaGVlcnMsDQpNYXJpYW4NCg==

--0PxiMx5PATC5l0zgPlAZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4655): https://lists.cip-project.org/g/cip-dev/message=
/4655
Mute This Topic: https://lists.cip-project.org/mt/74489071/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--0PxiMx5PATC5l0zgPlAZ--
