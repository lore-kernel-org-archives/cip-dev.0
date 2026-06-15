Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE9ECD98C5
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 08:26:07 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.125126.1781511954377598651
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jun 2026 01:25:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=ugptWGtl;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.45, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hD0Q/cmd/j15Mdf6Y1PTw3qRYlw+/kivPhZHmOmPeViu2kIBIcv7P+HE8HnkMaMJLnYWGiffBtbEE8KOV2N4pPBnU+Ml4Ixem91JK9xxYbcsLGDdZ+XTs3eavDf+yLqkSOK5W1d5VYSOqalZXywH23avy2wuNFWRfd+4JDFAA7tgaB96rKHwrSSgQzgFl4MBXwmejtqj4aNFDlHoBIotj/c/nmLW2eTSEG31LPW1SlqjE1Og64lWNDJCtRB2EuHj2WI6MjKQw+wu+qqkY8Pxb0vqNXCjinFMPm7rnD2uqSrpL2aQyC14IZKI1ORBz+CnCog948lkz5Y7Nnh23TbnTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrdDOKc2v4Ntc2yreBpLe50YMAYmpTCmf351BWyJu9g=;
 b=UrDfCX1zVFW7dU5VTTMtvJpwWIu77gt+JMYkaS+0xjSSU72a8JDBAZCDCd9VA3vgXlYifyOG4qWSSqQlzEqtkuehGjnBeI0uu0n/V+gqIJ1GGJt8TnhkBewaQuA89JIcZ/8pGrRg70dlOkRriGKHF5lFg5mvfzwI9gJDn9g/FadFp0N+0gaveUBHMQkCTPpL8WjAkajNPoHEcnTlStpeM9pmZAmZW/Db2ecdgsDPlqavuOmd/65LHDjl6KC8piCMsbAJBaqT+twY1/srCLVduJnm2BEjQB/NsKFwcNVY/xeWa41OtV99qBZQeiFbZNUbXKmyTkus7vKlWXsVsgGILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrdDOKc2v4Ntc2yreBpLe50YMAYmpTCmf351BWyJu9g=;
 b=ugptWGtlBrgXguL3lK9n7k7e22i3phwqL4t3KujVF5O7doM67m1ayJ1Pt38sw/AHLib4R9HAqoc7HgWes+31T8/TEx99NUOIjSCg2zDBP+f7oyn4t7/Q1ES1Vlft2qKnVsvXT6MoCMcYJm1E6b4i7kULFbYffEKo9S1+dDxl3Z8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB17034.jpnprd01.prod.outlook.com (2603:1096:604:410::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 08:25:50 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 08:25:50 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>, "nobuhiro.iwamatsu.x90@mail.toshiba"
	<nobuhiro.iwamatsu.x90@mail.toshiba>, "pavel@nabladev.com"
	<pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 21/21] usb: renesas: Suppress binding
 attributes
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 21/21] usb: renesas: Suppress binding
 attributes
Thread-Index: AQHc+Y+haEmEo1k0l02s8bsIFTTJ97Y7+31QgANEdACAAAClcIAADJ4g
Date: Mon, 15 Jun 2026 08:25:50 +0000
Message-ID: 
 <TY3PR01MB113469BEC5232D3C9713D21D286E62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
 <20260611104532.2532863-22-claudiu.beznea@tuxon.dev>
 <TY3PR01MB113463A4C767A966DE71DE7CC86192@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5dd61d89-971a-4a8a-a95d-c3d9723f6566@tuxon.dev>
 <18B9314B608D99FF.312216@lists.cip-project.org>
In-Reply-To: <18B9314B608D99FF.312216@lists.cip-project.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB17034:EE_
x-ms-office365-filtering-correlation-id: 7bf7e0f9-1dcc-4a76-3d7f-08decab7b544
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|38070700021|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 qpM//5y0KiLkBy9W+FLhnzP1DdiOn0WMPQf9eGNViQSmFWZYn+e1drX5vhKjaTtEnte6gwJ8CtXA5DjhFj7jgxEmwHCaxV/OvnWe3mcJCiihPZL/F1/FmqqNtnM8kqRRNRMwnLezyvi32qf7nsAviSZkXE7JmD6y4DzR5tUylFBBgy5ClH0Cpq60p8mB9OxEfg2d8nt6OmpkZmWv+5w7nInL/5OhSAaGqcJMpI27UwJvVluIKfeZxA0mMKytAxqEMDORlb7dGO+6hdhh+ZYi2SeqgvOYiPQ1BswjMkdygov5hX3L9ciXFoGr7qX6+WnGggRl8mNe/mGA2Axx5dmDk2uHTwGlDNrMuZ1oyKRXA2GetasmAfrgnss8V4/V5VSUFIcGa1n9BUff36khsBy6gEZRKVEKJSVjTpZkyr6NY9pxJEImiDQ3N7BWny0FF6XJxdqRw0NsAGjERKwK7V5Kv5cwDio4eezWx1d+tQrvvLeDBXc1lqyls2gUfSjkmxdlWeVC0h9RbaRcYh9jev/Z1cAwW2miEFUZgOuoeh3CLh5DsA3Un62YZTWxHpSW7TZSGr79GbKd8V2WSFvqP0eCwxZGJKCb0OS3UGyg4YuNS69aYpEzIj7WDB6sWsrTRKsqcPqb6AfWMbRFY/9JzCcVqtlHmaq+3oIm5REvf7drFMZUB5FP+BcpEn/5ibdYH/TeIncF6Jrw0SwfX8/bbvyS/ot+o1te1TABHg65dA2608rAAfVDr1IrredDYSyPm56M
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RVVHY0VkM1U4K3BUSlJlSExWdHNRakhvYU93NGNPVm9jaEw0OGxSQWIwbzZG?=
 =?utf-8?B?TTNsVkNqeFIyd3BWUitEWTNNbkg3T0xXMzcyOFd4eFVOZEpnSkE4UWQ0M1dn?=
 =?utf-8?B?R2twcWZaYXhYL0tNWjBqcVE0eUsyekNtT1BpMDZQNjZzbnFTNE0rNmJkanNZ?=
 =?utf-8?B?MjdkWTJhNHJhSmFmT1d1RDE1VVZuREJhS2pQcWxlYmtTWVQ3Uk5QTE1xNFFV?=
 =?utf-8?B?ZitZQWlqci9ySHp6dUd2bjJta0VJMnNZT1kyYngxeEdMTXZBN0IyV3cwV1dU?=
 =?utf-8?B?M2lBVW1URDFjZy9sNDFQZTNPWDV3bWpHU0NWR1huNkl4ZGNNR1lWU3RNU0Fq?=
 =?utf-8?B?QTVNQmJ6R3pHNmxJTzRmOGZjejZaQlljUFRJdHN3QWt0Ym9DVzZxdXpDbG5I?=
 =?utf-8?B?b25nZmZjMTBjTkt3cVUzVUlGL09vbDZySDZLRklzT1NacWpiM3VRaHJjdm9y?=
 =?utf-8?B?TTN0ZG5jaUVNckJPaUlEMkc3cW55R2pLTlhxK0drVEgyY2RkOHB4M2hKc28y?=
 =?utf-8?B?N0FTTHNxMGpadHZpZWRQd3l4RXc2a3RNNG9iWXFETnVwM2lTbTdhYS9EWG5R?=
 =?utf-8?B?YXNlSUtTcE91S2tnSmJtMUg1dUpPR05ocjA3TzNkd0NMbFd4YlNnREVLZlh2?=
 =?utf-8?B?Uk8wOGovUDUwR2U0aFRlNmJ3Uk5seUFxN204blZDL0VFLzJHNmsvR3A1cFZI?=
 =?utf-8?B?eWVrN3NkQVMyRy9MbEdDNlQxek5XT0hZSE8xSVNYLzNZMlF5bFRPWTJDLytP?=
 =?utf-8?B?YjJzdEE1Q3pRRXA4YUE5QTBzalNjN3g5MVR0citCdEROVDNWNjh3STRLRDJh?=
 =?utf-8?B?Ni9QOXBXOUxLbVRqVGFBdW16cmJieGpaVzYxYVhROUJRUlZQclZjZk9QR21K?=
 =?utf-8?B?ZVBFR21IdWhwZkpvYlhSb1ZFOXk4bzJETUFVMCs3ZWFzWmNKK05FeStxdkRz?=
 =?utf-8?B?WE55blR4R0RoV0tBakhrZ3NnbS90Q0dJQWY5UE9Rb3grQSttYjJGZ00yVGpF?=
 =?utf-8?B?V3pPcHRUeTc2TVNnRDBPazJmRGJQSlA3K2JFU0FUZkJtTkd0bjZMc2pIUWxI?=
 =?utf-8?B?QVpiYXhUUmN1YTYvaE01QUpyUG53bTh4T2RlS01iMHJUNmZmSjBtbzhVZk1h?=
 =?utf-8?B?S3I0UlpxOXRpYU1DZDZua2RtSGtWaFBoK3UyOG5RUTkybUZabmtxcFJZR1F5?=
 =?utf-8?B?aUswK2xpeThTSGY2bW5OMkNQYTl1TTI3S2VzMmh1SDU1ck9LRlZENVlISjFB?=
 =?utf-8?B?ak5qS3BmTW5Pd2IwaFN1ekszdXp4OGNKYTdyc1JpMDAxbTZCSTMwaHY1aERa?=
 =?utf-8?B?U0UzUURITlIyYlpXclByYnRmcUIvVG1XUlN0dHhzZjBTS1R0aHcySEgyc1Zu?=
 =?utf-8?B?TUFnWEtnOUtKQm4wK2p1M2pEd0lTMzNVS0J5UW5obFNZRUVLY2tUaC8rSHNv?=
 =?utf-8?B?bjQ0bHVvcWNSRE9TVUlHekttblJOdjhYaitaVkd1K3J3TWE2MTRQR2MreTg5?=
 =?utf-8?B?WWk5N094SjA0MEpqdk1PUzBESGlSNGJPWS9Za0FXMUZmNkxRWmRXb2Izd1E2?=
 =?utf-8?B?bGxBaysrMlp5MlhUUENxeS9mekJJM1BTbXN2ekl0RFgzVVFrZW5KUmRacy9F?=
 =?utf-8?B?ZkFoaW0wcWJtOG1CUW9MZk0wcTA1b1ZpN0tZdTl6M2xYY1ppaUlUaFdnQXU4?=
 =?utf-8?B?YzZWOThtdkhUTml3eWpZeEs4TG1OOHBYNWU3Z2ppeG9UcGRQc2xWSitDbUt5?=
 =?utf-8?B?ZXNXdWl3V21OL2NvcnZIMm9mcmczbGhsSE8rakRLR2kzNUFIVldTS0JKRVlp?=
 =?utf-8?B?Ti9NdUJSNGRBNlRXOXpSYm8xQklBZHZvclFJTnB5bSs5eTFoZi81a3FMY3N6?=
 =?utf-8?B?V2VwMWJuazAreFl0YW5GVThCbFllUEpRSDlQYjVCUERhRnF6RzBlSkN0ZjRy?=
 =?utf-8?B?byswMWVaRlhkVmhiSXhOdVowNjQwM3ViMm9IT1FDQmVWUWtpbGFpckw5ZlpS?=
 =?utf-8?B?NHZIMlYzUS9XUVhHbFk0ZzBIN0hVbStEM2xkbEduWEovN1lNV2V5d2dCeG5B?=
 =?utf-8?B?UFN4YmRGTGNTL0xhSWMySGJWUVJZdnlSWkhKLzVkQk56NE9oY2VaT2dWRENp?=
 =?utf-8?B?aXhiQUNRS0tQbU5pOTc0YlA3NlNHT0JwbURSaTNUK0VTUFlKNUtpUzJOZ2Jx?=
 =?utf-8?B?YzM2dGYyaUZGcEwrdGw2M01sK0F6ZGkwekxlK0FMMCtaN0R3WFlQaFdLaThH?=
 =?utf-8?B?Yy9NQXI4YWhoR2xsMHczcUhiWnlqR1E5TmRDUjFaaU1DTVhwZ2Q0NlVZL2dL?=
 =?utf-8?B?R2oxQlk5S3hQZ1lVeWxQMGxXYzlNZEZCc09nOVYrUkV2eVhFZkhPUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf7e0f9-1dcc-4a76-3d7f-08decab7b544
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 08:25:50.1815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzMsqTtqzzqecNbFWydOKSu/ulWWDZJtcc4yQKqnKvvGiVg7pp9aGqUVXtbngudM4qfEXf0LiIk5vfa+T5fFeRBKLPgdkAYNdgTomP5NxPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17034
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jun 2026 08:26:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23137

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjaXAt
ZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+
IE9uIEJlaGFsZiBPZiBCaWp1IERhcyB2aWEgbGlzdHMuY2lwLQ0KPiBwcm9qZWN0Lm9yZw0KPiBT
ZW50OiAxNSBKdW5lIDIwMjYgMDg6NDINCj4gVG86IENsYXVkaXUuQmV6bmVhIDxjbGF1ZGl1LmJl
em5lYUB0dXhvbi5kZXY+OyBub2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhOyBwYXZl
bEBuYWJsYWRldi5jb20NCj4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1
YmplY3Q6IFJlOiBbY2lwLWRldl0gW1BBVENIIDYuMS55LWNpcCAyMS8yMV0gdXNiOiByZW5lc2Fz
OiBTdXBwcmVzcyBiaW5kaW5nIGF0dHJpYnV0ZXMNCj4gDQo+ID4gPg0KPiA+ID4gT24gbWFpbmxp
bmUgd2hpbGUgYWRkaW5nIFJaL0czTCBVU0IyLjAgaG9zdCBzdXBwb3J0LCBJIHVzZWQgdG8gZ2V0
DQo+ID4gPiBXQVJOX09OIGZvciByZWd1bGF0b3IgZW5hYmxlIGNvdW50IGR1cmluZyBQSFkgdW5i
aW5kL2JpbmQgYW5kIGlzDQo+ID4gPiBmaXhlZCBieVsxXQ0KPiA+DQo+ID4gSXMgbm90IGFib3V0
IHRoZSBoYXJtbGVzcyBXQVJOX09OKCkgYnV0IGZhaWx1cmVzIHRoYXQgbGVhZCB0byBzeXN0ZW0g
Y3Jhc2hlcy4NCj4gDQo+IExvb2tzIGl0IGlzIDYuMSBhbmQgNS4xMCByZWxhdGVkIGFzIEkgZG8g
bm90IHNlZSBhIHBhdGNoIHJlbGF0ZWQgdG8gdGhpcyBpbiA2LjEyDQoNClNpbmNlIG9uIGJpbmQv
dW5iaW5kIGluIG1haW5saW5lIHdvcmtzIGZpbmUsIGl0IGNvdWxkIGJlIHRoYXQgd2UgYXJlIG1p
c3Npbmcgc29tZSBwYXRjaA0KT24gNS4xMCBhbmQgNi4xDQoNCkkgd2lsbCBhdm9pZCByZXN0cmlj
dGluZyBiaW5kL3VuYmluZCBvbiB0aGVzZSBkZXZpY2VzIG9uIDYuMSBhbmQgNS4xMC4NCg0KQ2hl
ZXJzLA0KQmlqdQ0K

