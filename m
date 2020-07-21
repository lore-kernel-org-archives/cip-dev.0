Return-Path: <SRS0=olAQ=BA=lists.cip-project.org=bounce+64572+4944+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B70C433E0
	for <cip-dev@archiver.kernel.org>; Tue, 21 Jul 2020 07:16:02 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075B020B1F
	for <cip-dev@archiver.kernel.org>; Tue, 21 Jul 2020 07:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dHl5qT/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075B020B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4944+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id V2zcYY4521723xDMODB2HWka; Tue, 21 Jul 2020 00:16:01 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.104])
 by mx.groups.io with SMTP id smtpd.web11.13803.1595314840176661912
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2020 00:00:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ki16Ox6lk70CEh4AQAu9IBIyoSR9kHpl2aTTrJciiWaZxOyskWCsdp8xRVRk+JGxCPbgnTG1U9ARt6zkCFbSdlIjCNr4IbsoFzACmEDE83vUB13kkFayVpm7wGTinMWnHr80HEypauH33G9oN48zOeHIbSJIcLWq1/ipBTw5W8YlFHiGyXgxlE8lx1AZJqYKuO9ycnkQgGi5dNNgkPdBNaxkBlSE+qTrXD+bchCA7nlCsaymWYD3skWGtbTcTCufTzNRlYoKWlHOTQaquPYKwFuEcWlC7EAw6AoFBRSHxbxuqpTSze5J+xGIMWm4WuSSLJMlyzWaA8SFsElFbEG9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCF+08X8rCN9gcC2ojdkC9HxOl+VdgD1kE8TJ3uB1j0=;
 b=Q93410drVajdzXNizZ2wdgR34EotBWChjJP9Z/92pvlTgGWtgJQ2snqrP45Gc46iDMUmfanCP/D8+b78iecKZD4mgGbLLZn7tvNmeynyktWn/SLF9HGZeN5RsOvsWdREuRUf3shpPsDPjoBdPzTCM1uzLsum+yWxdU5K1NwByW0rvogoUveNcomhAiwsjotvqANRg1USOse3ox9AGcH5Ij9AJ7G/yAZIik2gOxiJwBfocs9ZcMhQnEPGm5gHv4FW+TJgJUOuSzLdsUZJQVi4r+fbpjNhrPSHzNDTH3e9EXh81liUC6e6Prlj6ilaLinn+N4oX1bhiONhVeBJ7CT3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TY2PR01MB3323.jpnprd01.prod.outlook.com
 (2603:1096:404:da::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Tue, 21 Jul
 2020 07:00:36 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::590e:ebc:1f09:f160]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::590e:ebc:1f09:f160%7]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 07:00:36 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Chris
 Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 2/2] arm64: defconfig: Enable additional support for Renesas platforms
Thread-Topic: [PATCH 4.19.y-cip 2/2] arm64: defconfig: Enable additional
 support for Renesas platforms
Thread-Index: AQHWXr8Oe1+8oPc+cE2rAWnENJSSjqkQ9AEAgAA+ZYCAAGkbIA==
Date: Tue, 21 Jul 2020 07:00:36 +0000
Message-ID: 
 <TYBPR01MB5309444A07C2154A8BC9E83986780@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <1595267543-32854-1-git-send-email-biju.das.jz@bp.renesas.com>
 <1595267543-32854-2-git-send-email-biju.das.jz@bp.renesas.com>
 <20200720210008.GB9879@amd>
 <OSBPR01MB2983171CA949DF2DA8967BED92780@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB2983171CA949DF2DA8967BED92780@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [31.49.74.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e0e7ce31-ba7f-4b6a-b54b-08d82d43c53a
x-ms-traffictypediagnostic: TY2PR01MB3323:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TY2PR01MB33237C8884C98D849F4327CC86780@TY2PR01MB3323.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 ntreqRvrU9OZRBJT8kvklMniNwqlphLKKzI2XvcG650u7YJRfHRvo1AMMbSEnXYMhNdNjJTXGaK1aXHGpmGHf0owcgDVBw+xDDGO9OOsmlpKqdnYeGwic97blSGDzTLd5K2lYztmy0y0tsBqDJLr8Ijx7+uD0LUsJdut81Fq4e/0mZ4pJav8b9bC+v0lAqqGv6/hR5e5QsUsA5pyXgTR2sX/mCBWkssjfP9FvG6nyqP6+w2KVmYoMqWyevoBZL/QV/tasUjgy8EkOE6WgLLSfzailQ0sQjH/EBLoa6RDupMFKgCENGGjBSc0tI1C/OvV8crfdufNy+UWVhjelS97LA==
x-ms-exchange-antispam-messagedata: 
 zgX7f5yrAcUOBDpsW4sWHo8HqXW1yvkx2cTbywFJWIrCzBIQ3NZ2fgxA7SjTEhBvVjfDE3VwRH7t12U5OsnCmQnUXOeUfkys+QTlyCW3PaSLtS2C0NOaIcTyzRAtEhvdZG60vvfm9tTAGP3++TuGygKX/Xxul5mrvsv4egBfw/8ToRhl9Hfa0zdSGDNk4P9OWpXoxouwxDLlq5rKwOLxudC5zVoXte7ORUuRR3b3mw3TjcWBzCuH/cMKVS5JHn+e+o2Hn2fMT8QxLXACfMaYKSaoRgeD9K9kNR/nIIBBKmU0aMhGTrTjGJpgCrodAQa3kSjCl1PMHmn/X3Q8vP7YsW+m1m33H/nEClU+Pcg8oY9gl4b+zwlQACZs6ldplDh4UtTCIjEMYxE5w+bvkft8mtqsJaWWGgelfkEtS7nJ99hSGqCuC229J7p7REQPKLuEiwTkPu1Elv3clYTwLXnNdNfYhj8e/tyPMyUAUDAS3HE=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e7ce31-ba7f-4b6a-b54b-08d82d43c53a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 07:00:36.5503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /rp8WXMvrLTGDWpfk4F9a4Wkt022tk2RWzMgkniB6qza56WN7i2zHrwMVuxvg9DfgCaNbUNvSuPOMx8WETEL2b0Bnt9N5V/RJ3jaGPMBT9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3323
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: s8eQ1eeIAM8peqcj4mHhLIyTx4520388AA=
Content-Type: multipart/mixed; boundary="xojMSr9GRLgRAWdiMskX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595315761;
 bh=Y14rFhVE5Mz4iMqKCa+JKadLCYAFwMBpyr5w1thaNdA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=dHl5qT/NBYkdLO6YTYzOTZ6yexnKAC/PIt/A8jULOB/fFnHL0ps2jfWjCrlrrwHT7EK
 eMwHEmDb1OyCIcucHNt2fB9xq/V0I+4xmrXZ0XH5sks4miABqqTO1/EPsNyWEn3OGeIDt
 CNBIMxI+oxt9TFnd/8TbHXkPDNW0FCO4+X4=

--xojMSr9GRLgRAWdiMskX
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUGF2ZWwgYW5kIE5vYnVoaXJvLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBub2J1aGlybzEuaXdhbWF0c3VAdG9z
aGliYS5jby5qcA0KPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+IFNlbnQ6
IDIxIEp1bHkgMjAyMCAwMTo0Mw0KPiBUbzogcGF2ZWxAZGVueC5kZTsgQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5v
cmc7IENocmlzIFBhdGVyc29uDQo+IDxDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb20+OyBQcmFi
aGFrYXIgTWFoYWRldiBMYWQNCj4gPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2Fz
LmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCA0LjE5LnktY2lwIDIvMl0gYXJtNjQ6IGRlZmNv
bmZpZzogRW5hYmxlIGFkZGl0aW9uYWwNCj4gc3VwcG9ydCBmb3IgUmVuZXNhcyBwbGF0Zm9ybXMN
Cj4NCj4gSGksIGFsbA0KPg0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJv
bTogUGF2ZWwgTWFjaGVrIFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gPiBTZW50OiBUdWVzZGF5
LCBKdWx5IDIxLCAyMDIwIDY6MDAgQU0NCj4gPiBUbzogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJw
LnJlbmVzYXMuY29tPg0KPiA+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgaXdh
bWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKMNCj4g4pev77yh77yj77y0
KQ0KPiA+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IFBhdmVsIE1hY2hlayA8
cGF2ZWxAZGVueC5kZT47DQo+ID4gQ2hyaXMgUGF0ZXJzb24gPGNocmlzLnBhdGVyc29uMkByZW5l
c2FzLmNvbT47IFByYWJoYWthciBNYWhhZGV2IExhZA0KPiA+IDxwcmFiaGFrYXIubWFoYWRldi1s
YWQucmpAYnAucmVuZXNhcy5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCA0LjE5LnktY2lw
IDIvMl0gYXJtNjQ6IGRlZmNvbmZpZzogRW5hYmxlDQo+ID4gYWRkaXRpb25hbCBzdXBwb3J0IGZv
ciBSZW5lc2FzIHBsYXRmb3Jtcw0KPiA+DQo+ID4gT24gTW9uIDIwMjAtMDctMjAgMTg6NTI6MjMs
IEJpanUgRGFzIHdyb3RlOg0KPiA+ID4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCty
ZW5lc2FzQGdsaWRlci5iZT4NCj4gPiA+DQo+ID4gPiBjb21taXQgYmY5ZTMzM2VjMGQ1NGY3NDI4
ZDkxOTJhZDQwM2MzY2I1MjM1ODRjNyB1cHN0cmVhbQ0KPiA+ID4NCj4gPiA+IEluY3JlYXNlIGJ1
aWxkIGFuZCB0ZXN0IGNvdmVyYWdlIGJ5IGVuYWJsaW5nIHN1cHBvcnQgZm9yIG1vcmUNCj4gPiA+
IGhhcmR3YXJlIHByZXNlbnQgb24gUmVuZXNhcyBTb0NzIGFuZCBib2FyZHM6DQo+ID4gPiAgIC0g
Ui1DYXIgQ0FOIGFuZCBDQU4tRkQgY29udHJvbGxlcnMsDQo+ID4NCj4gPiBPaywgSSBjYW4gYXBw
bHkgdGhpcyBpZiB0aGVyZSBhcmUgbm8gY29tbWVudHMuDQo+DQo+IEJvdGggcGF0Y2hlcyBzZWVt
IHRvIGJlIG9rYXkgdG8gbWUuDQo+IEkgd2lsbCBwdXNoIHRvIHJlcG9zaXRvcnkgaWYgdGhlcmUg
aXMgbm8gcHJvYmxlbSBpbiBvdXIgdGVzdC4NCj4NCj4gPg0KPiA+IFNob3VsZCB3ZSBoYXZlIHNv
bWUgdXBkYXRlcyBmb3IgY2lwLWtlcm5lbC1jb25maWc/DQo+ID4NCj4NCj4gKzEuDQo+IEl0IHNo
b3VsZCBiZSB1cGRhdGVkIGFzIHdlbGwuDQoNClllcyBXaWxsIGRvLg0KDQpSZWdhcmRzLA0KQmlq
dQ0KDQoNClJlbmVzYXMgRWxlY3Ryb25pY3MgRXVyb3BlIEdtYkgsIEdlc2NoYWVmdHNmdWVocmVy
L1ByZXNpZGVudDogQ2Fyc3RlbiBKYXVjaCwgU2l0eiBkZXIgR2VzZWxsc2NoYWZ0L1JlZ2lzdGVy
ZWQgb2ZmaWNlOiBEdWVzc2VsZG9yZiwgQXJjYWRpYXN0cmFzc2UgMTAsIDQwNDcyIER1ZXNzZWxk
b3JmLCBHZXJtYW55LCBIYW5kZWxzcmVnaXN0ZXIvQ29tbWVyY2lhbCBSZWdpc3RlcjogRHVlc3Nl
bGRvcmYsIEhSQiAzNzA4IFVTdC1JRE5yLi9UYXggaWRlbnRpZmljYXRpb24gbm8uOiBERSAxMTkz
NTM0MDYgV0VFRS1SZWcuLU5yLi9XRUVFIHJlZy4gbm8uOiBERSAxNDk3ODY0Nw0K

--xojMSr9GRLgRAWdiMskX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4944): https://lists.cip-project.org/g/cip-dev/message=
/4944
Mute This Topic: https://lists.cip-project.org/mt/75687531/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--xojMSr9GRLgRAWdiMskX--
