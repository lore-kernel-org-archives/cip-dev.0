Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289BCCD5BD1
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 07:24:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5594.1779953055774502678
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 May 2026 00:24:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=UBwe8epQ;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1779953053;x=1781162653;bh=i8ogHtB/AFylr6m5DzzxYAcvLvNffI1h9QRu0
	laZw1k=;b=UBwe8epQ7VxamIKQign1SgQyYs4096Ngv2v2nJvDkxa9PzzIRwfEhhvW6IrKx00okbg
	bIupXCW04nX88fEIYhPdUqP2uYW0zywimmLJR+fb8c2DQ8APrxWlTrXPCouBHP2amaYBjRp101v3r
	1qXl72crJKxwsDvaocrn0SrFoMXATiZDtav0Ct6rZj2lwv7kwF1fb5qrHm/apTkJHppKzZL2W0yQX
	c9q+b7aYWkOk/oqoWvK1jpocePf+bHrkdRrj9/9x0hA+U9OItvPMDfmCNSB0Rwcw369DWYLkcLs3K
	6qw0Wly/j9Y0p05KZDbYz1/Bwp7oEEfSLFF+7rAtCm4A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 64S7ODQN2845948; Thu, 28 May 2026 16:24:13 +0900
X-Iguazu-Qid: 2yAb6z3jL67YmCme4h
X-Iguazu-QSIG: v=2; s=0; t=1779953052; q=2yAb6z3jL67YmCme4h; m=91KNKbx4Ouds5cyZoWsnUUAN8tDEy4jEmg/uphW+DIM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gQyfN1nLGzyPQ; Thu, 28 May 2026 16:24:12 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CX+bJrVt6R62yyylXLdm8KBar5Hkh/+nh9tHG53Kony15Gzk938c/OcCseh5ziDE+Gce3PG0E85ulkaUozRTKVo7Ag281RjrBlXC58aBrYssqL+qXgnQH3McRB8PHPw075M421cn842lLoi0siHmyQABAOeRd03kDaBxIMsYOMhNttOZbv/+Qr69MG5wxw5MGa/arw1ITIpO7fmEOlruvsGNWr+gM2Xwqv+xwAUCM/fp2WrgXcZl9uJvlfFIsRVonP/mi8+TTXXuNw6FjKouPPRa921sK0mp4Y/r6qEB9w7pL4mOyr6sbzyg7s/8VW9CR8n6DYE9uxG2HBYFHm9Mog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8ogHtB/AFylr6m5DzzxYAcvLvNffI1h9QRu0laZw1k=;
 b=Bqn4tEt2ZwvqydRZ2dr4iPux8O2jTd7p+jnVQbx8JyiOa25pA2oxSG/+RjFGzmWNijMd/j1jPLLOUYOp5KHoluClKtea6hBI7tkyvHLNKM/vpO7iEAJfXcguESsIzkjxUCV1sGiD6YKhkDT50HJIPyqIT+DnEoOMYKC1XuePLwYYxx0yMHDfvS3K0NhhBrmk50GWKEKxXXxGQeA+H2ygyk/8Raxnc3DlsPyR16Dm4cRkdRfo00zwU6mr3nzysJw9TIw4NKetlt/2NMoDEalXfIBfvfPWdZziF7gi7F+pPSFkFJozH4ggrMZjK6alI8cOl1AgC200qGec+0xWu0LwGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip 0/9] i2c: riic: Driver enhancements
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 0/9] i2c: riic: Driver enhancements
Thread-Index: AQHc7fP4/cRn4ffxV0ayOqjNPfToBLYiYAMAgACpjSA=
Date: Thu, 28 May 2026 07:24:09 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818A9DBBB81FADB51383899CD092@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ahde-JBeE7BGLuJh@duo.ucw.cz>
In-Reply-To: <ahde-JBeE7BGLuJh@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB10318:EE_
x-ms-office365-filtering-correlation-id: 1457ab48-1913-436a-4876-08debc8a1bdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: 
 P0j3/ifHQrQDjh7OunVnVowMKsm3toNLAKeQ2J7XrqWnWdlja5gi4m+ALszt4SMTvEbwYL9k+x85iwBted+BhWYMCVidmEpvVnFLJ0+7lh0Ct5Es7Yw/ev3G1rlyxoLpEmjnjw4waaKSPmqyBu9LxN5vgizmxFUuRDGI5NXawDWiDuH8MW+gKaF7sfitO8LkHA343L/qqOok9KtytWJA2BIt/f5u/X+bdIHvxXMwvo5miHwi11YACW+PZluYS2yIJngy7VLV/kkTiBdnIvBEQy6u3msGYtaNTHKP8ENMLrcw9NVgNCDkAUCYAFxSusjEQCm8Tj+oeqBviWps1O1696IdlYtM2IFWnS7rAJuQwfIV6o+AQHGf/dwnP2KOxih7TuSyThylwWf1f86V3V+/bBpeBqRkKOOdaWzslDYfBPjSSw7UhvWlvc/FC5CZfJdoXNqbOfmcABHzZDXEvNdBbnMIP7CxcfJmwZVx/tvUr4hKKJUsTWmHr3QQcs4hu57FWBjVmnUlpmjPwk6Z8aeTjAiP2uFGQj7U1RsmiJdodZVSL/5s5R85DUMXRneKHoz/XW41sbvqBTQF0f/Oj0jguwWAfSfXc4T+aV2v0trCC7HpNGmBJ5PGkRlRBYWVY+U07aW+hbb8hVTIGexMf4CSQ835ZWHUM8J90eV2Euud1ENFteY8IevXTHZh9dZWTsNkXB89PGo2t5QGF4gjobNMgSSeU9GkP0UxuEZ/i7pKKAgaUAqREeZ46nPD6fykaQvv
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dHpDeVl3MjZTLytuRmpkTVJyZjBCOXN5N2lPWlIvTUtmeHA0YTFOZnUwdFha?=
 =?utf-8?B?Rmd4dVA3cis5bDhEaVFTcWlDdjUvWVdZR2pRek15U21EUEdqTVFUSkhRTnhD?=
 =?utf-8?B?WklHcndMYVJRMXB6NFpvK2daS3JNbkFmU3NBZ0lTYXhqcFBWU1VQa3VEdjdW?=
 =?utf-8?B?WnpHR0QzNDVTdk11TkpwZ3NwTmQwQmVxaitXQnRZM3ZZMWFkZFp3UkViYXFK?=
 =?utf-8?B?bitmRk50OVZ1T3NoREJkMlkrWE9scmVBQU5MU2ZlT3BML2VncTdHandNTGhz?=
 =?utf-8?B?S0FJVWJqb052QVFwQ0dNSk1WMmVaeXc5WGd3cUprWTNpSUhBM2kzSWNLMFdG?=
 =?utf-8?B?M2lvYXVST0F4RGVlVWVVRjhwNExlbHFoWEJQazRubVpBTytteUl1RmxiTDlo?=
 =?utf-8?B?QzNuUFFBWXQxcldkekVCOXNTVlBoRXl6SUp2OGwraElscWtVZVFvbnpHKzJp?=
 =?utf-8?B?U293bXh1aWVzTVUwa24wdFBHZ3lDRmdGUVpzd0EzQURCTE9JSldtZUlzZHh0?=
 =?utf-8?B?UU5rc21wQk5BVXhkY2kxY25iSVZIQUJ6MEwzWGtGNmRFS3B2dGtyUXEzRVNL?=
 =?utf-8?B?R21FRGowVVZ1TFpQUVlISkw4MmJsOTd5L2FUc2p6Q3laeWt6SjNTMEdFUHBx?=
 =?utf-8?B?ajh5UXFISUZxWUVZNW5DWUROUVFBMzNXdUZEZDIwdkxvR2tKcTBOZnpnU3BQ?=
 =?utf-8?B?Nkg0LzZXWlBDNTVXb0REb1A4SXgwN0kzRGZTbXlVc0laZzF3WGVIdjV0T3ZX?=
 =?utf-8?B?d2JkRGMrdHkrQ3dtWkdySnVGZ2FnOVloRUt0bmY1R0FYUEhQY25aT2lldmtu?=
 =?utf-8?B?dHJ2TmJKY0RYVm95T3lFNW41WHE4Y2FlVHJTL0dOYm52SmluRHFxUWhIVDUv?=
 =?utf-8?B?RDlmTjY3T1FSK1Jka0g3RC9HaGZWY0tVTUhlb2hCbmwyMXV5cGtRY1BDSTAx?=
 =?utf-8?B?UytIT1VqZGRnZmZTcEEzWkhGZWlvMWFtQzVKYVlNbDBGQUQvTmpyQjJVbnNt?=
 =?utf-8?B?TzR4b3NrTVArQ3U2d0VTd05xQWZiRHY0dkJDNTQ3MldjNVAxYkV0cXQ3MTR6?=
 =?utf-8?B?dzU5SUd4dlFpNmVONDh1YjV4dXp4M3BjaEJWemErUUwvN00yU0JUSWU3L25k?=
 =?utf-8?B?eGNiVDBKYkxlYmdxQTBWNGtvR2ljODFoVW0yVFFjRjdQekNvNkVicEgyRUNq?=
 =?utf-8?B?ODBpaTZQSHlCVGJ4OUJLQ3d0bEQ4NzhZbnY5V3E1TUw0OU8zUXF1OGoyQmZ6?=
 =?utf-8?B?R3EyUncvL29BYk54WHJxaWpRbWdKb01QdG1zRFhUc2ZSbGF4KzFlVlN5VUVt?=
 =?utf-8?B?bHh0Um95VHNMWjZ1VEx2dmV0WElLQnVDKy9CQ01rNllXWHhFc3JsblZiRHpu?=
 =?utf-8?B?bUkwU1oxK0wxOEdLUXcybXREM24zcG1vMkRDeFFpNFQzRFlFUXlFQ3U1RUd0?=
 =?utf-8?B?MHl3NlZIZkp5QXdvU0U0c3U0TUlEWVg0WGZRMzZxZHRkSUNOUkorZnpRbUQ3?=
 =?utf-8?B?eEZBcEgzNWptdCttT3VoSU92SFdmY21FbVhudXlzS3lxY3M4SUc2Z2pOMkxn?=
 =?utf-8?B?SE55QXlPTS9RMTd6N21raUY5dURad3puWGNlc0NoZFNRbWEvQzlTSkU0YkdW?=
 =?utf-8?B?eVZjZElVdVFjWi9vcSs2Uk8xc25RK0xmRHFxZW11UHI2c01HVlppcjFhY21j?=
 =?utf-8?B?RlA5OGFpbTllTktiT0VnMTBUNlcwazhRSVpNRFRzVUd3ZXVBWElMOE1PbEZE?=
 =?utf-8?B?MVBqV2hpZUpBMVZmR3FzMUk3YmVIenR6KzF3czQ3MVpvbG10S2c3MHo3K25E?=
 =?utf-8?B?ZlRFc2ppN1UwZG9nOXkrRmd5Qm9FaWFwRmRPb1hhUkVWakJneG1aN1BKSmR0?=
 =?utf-8?B?bzkzeWwxU3BKL3JNa2dDT25paDNWSmlVSVNwMFAycTN5SGNEaUJ6allDZThj?=
 =?utf-8?B?TUpUTklPcEc3Rzg3VWNoN21wOGNsR2xZUmxYQ1FkV1pzUDVsRzlOZ1pkVjVv?=
 =?utf-8?B?NFJGdUZGdkc2VFNUSXlQVloyMDlsWE41L2dKVHU1YVIrRzhWa25QTFUyb3lO?=
 =?utf-8?B?aEQrMGdhbGNyRm1IVHBsS1YrTDBRTmxWeHJiUCtBRjRRM2pmZy9KYlEvYmdR?=
 =?utf-8?B?aGZFY2FUYlBWeWwyeEwyTWpCRVQ1MGxkNEtVRWNMZ3YyRlVFbE9nT3pUbkx5?=
 =?utf-8?B?RHY3bUhaZUxJbHdQUG44dTZpK2JkbTl3by9DQjU5TGJoZkcyNUxoVS8zQllJ?=
 =?utf-8?B?SGVVTHBZTUhmMjd6OXlaY0pOY1N0OU1hVTdLcGdyK0tHWktJNVl5aXQ1dlk4?=
 =?utf-8?B?TUx5TW9PbkZOekxtbEllQXY3RENZUHRiZGRWVE1KOTA3K3ZpOXYyaUVDSlVO?=
 =?utf-8?Q?Xcl/ld5fqsBz/Cbo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	DOtRv2L+2A9JidKE/BGZFLpzAbHfoT4cAhqohcRCDhgfPaweKXBKtD66FH9aFFdYHA5FN4/iiIsz57f+Ca3SNzAGl0wf2c5zZJVzfPlSXqCkzo5OHjsywweKBgmjJxp9ic2zXnswfzykzp7SvNKQuJCSj3zIAhnrKqPqxV5N7WhElx/SzFDhL/6cOSk32SaPCDurc/r966KP34PR2qbOEMYwFpmo/2Ol8xWIEO1u8tkVSeNYkyg6T2EXnJxYgixm4bBGHkIUP/QSJvdwQ4SzLdy/xgNbrQp34TqV18aeqmWSzF/Jy8fTq3luzNfnlJIPavd+ogbsR+LJCqfHQ4ONyA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1457ab48-1913-436a-4876-08debc8a1bdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 07:24:09.1866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W6AaQy5xhjw3vSe+u3zSBIpJFxZ7RqnkbE5RkLZiG36hjpp8RPr22Cxko8Ujn0aseeixh22wXsePYOtDqYv4o3/lwJOJWcf3LS6QuugrKal7+3rEpK0u5mrRFA2U/CRx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10318
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 May 2026 07:24:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23034

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbiBCZWhh
bGYgT2YgUGF2ZWwgTWFjaGVrIHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU2VudDogVGh1
cnNkYXksIE1heSAyOCwgMjAyNiA2OjE2IEFNDQo+IFRvOiBMYWQgUHJhYmhha2FyIDxwcmFiaGFr
YXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+IENjOiBjaXAtZGV2QGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZzsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvKTvvKnv
vLTvvKPil4vvvKPvvLDvvLQpDQo+IDxub2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJh
PjsgUGF2ZWwgTWFjaGVrIDxwYXZlbEBuYWJsYWRldi5jb20+OyBCaWp1IERhcw0KPiA8YmlqdS5k
YXMuanpAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW1BBVENIIDUu
MTAueS1jaXAgMC85XSBpMmM6IHJpaWM6IERyaXZlciBlbmhhbmNlbWVudHMNCj4gDQo+IEhpIQ0K
PiANCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBhaW1zIHRvIGFkZCBJMkMgYnVzIHJlY292ZXJ5IHN1
cHBvcnQgdG8gdGhlIFJlbmVzYXMNCj4gPiBSSUlDIGRyaXZlci4gQWxvbmcgd2l0aCBhZGRpbmcg
STJDIGJ1cyByZWNvdmVyeSB0cml2aWFsIGNsZWFudXANCj4gPiBwYXRjaGVz4oCLIGhhdmUgYWxz
byBiZWVuIGJhY2twb3J0ZWQuDQo+ID4NCj4gPiBBbGwgdGhlIHBhdGNoZXMgaGF2ZSBiZWVuIGNo
ZXJyeS1waWNrZWQgZnJvbSB0aGUgdXBzdHJlYW0ga2VybmVsLg0KPiANCj4gVGhpcyBsb29rcyBv
a2F5IHRvIG1lLiBEbyB5b3UgcGxhbiB0byBkbyBtb3JlIGJhY2twb3J0cyB0byA1LjEwPw0KPiAN
Cj4gUmV2aWV3ZWQtYnk6IFBhdmVsIE1hY2hlayA8cGF2ZWxAbmFibGFkZXYuY29tPg0KPiANCj4g
SSBjYW4gYXBwbHkgdGhlIHNlcmllcyBpZiBpdCBwYXNzZXMgdGVzdGluZyBhbmQgdGhlcmUgYXJl
IG5vIG90aGVyIGNvbW1lbnRzLg0KDQpJIHJldmlld2VkIHRoaXMgc2VyaWVzLCBzbyBsb29rcyBn
b29kIHRvIG1lIHRvby4NCkkgd2lsbCBhcHBseSB0aGlzIHNlcmllcyB3aXRoIFBhdmVsJ3MgUmV2
aWV3ZWQtYnkgdGFnLg0KDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBhdmVsDQoN
CkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==


