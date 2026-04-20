Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA3DF36C36
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 07:19:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14230.1776669563033919671
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Apr 2026 00:19:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=tyLZz2/V;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1776669559;x=1777879159;bh=flt7OICYWP68Nss5gBjFi6VEq0YHBuEPF3nMF
	dARh0g=;b=tyLZz2/V7XU6PZ5xuKDiEM3cz2gEgOGksQJkulLMXpNfUlpx4zDK8RxhUkF2FcPMZPU
	5qOgDwjC4RPE9JZUfGXv+afMEnLCaX0uYVku8AiMbjU98aJ5ynkRttmCUimRjBnta+MpkTR3bBXfP
	rTNP/5wFF94/zfedwp6IwZ/Y+fbNBKhyQdiMqgFZSP1HrKa3mKVV0N5ALIrl51JFNXEFEZT2NpzLL
	OWhKV/68zNE/T1Zbh3f86pKLxnXCGHmzI7q2wk9nofF00CCFH2RPqPNNxGkIRIbGpmkJP43V0UsC1
	frw425p9scVyEWrI2/OG9h8DQOoePHgmYMA0/uIjFEAQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 63K7JI46410086; Mon, 20 Apr 2026 16:19:19 +0900
X-Iguazu-Qid: 2rWhuNCmt1e42kdn7e
X-Iguazu-QSIG: v=2; s=0; t=1776669558; q=2rWhuNCmt1e42kdn7e; m=Ju/LMJkrAHMtrmrXpFbEYzfPs5cnwOpRARegNk5Bnc0=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fzcLF71F1z4vyt; Mon, 20 Apr 2026 16:19:17 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUktPNNgI3vxmExsLo1BMjrBpywU+pvsV+1EUZWIrz95J1L0lPG1ihGmjjAijdx9HqN161RsAII0P3yVHfRn8hyM0mySif4SxyhmD6+RTofWMiKgrHvWKuvPN7GXM0r/2A7oZl+6AfZVJFg+HW6fViMkpehrsJUE2yqt/kT6GigaXkNr9WESXFYKGoGnOORblrd4gw6h4oTBAZbRnE4oRJQzLFpRtG0ZX5Ux2SHwUAnJ5nksGvcLpYKG5uvbP7gdo29bI8kOmWe/S2BhcH28CpZnr37RzhUAuE5ZKzHJQEDL2Q/6LttF0xg7fPmKYrjW9F4p+4PkEfiNYW5DhcCB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlDwIXanR5kjhxARFtWMhWoeLHyqLa9rBL1u2kCdcrg=;
 b=pOIqNQT5K0l+EEWkxmWaD4SBYDdYFLQdpOTon0JIGO02afNn8mTTAnRrPKG0XChzoLOm1AcUEQFdheGWn3Y2sS3a5ERwJwoVPnCu2tHfIq+jQSI/IQEhyhrUNa+2wrvEcTX1yQGv+KVqoavjjbzp1bbLm8qKIFdRKcFyVX55WLd+TTyLfW+kov9Smg7uIYupSBL54PMp/6xjvwJV/HwvMWyrOQdBwDZKJvRkz6guy7f9Q5EsydUHhJkcKL3IlE8twVe+CxgWAbpYnqLVg5q9SYjCMTXFfHTz+FHmJ0zuWrFmtKdrTaDM9e1wUjH6XwJ0/ksPYtBYJj7cAtvfiff5VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <ovidiu.panait.rb@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/8] Add RSPI support for RZ/V2H and
 RZ/V2N
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/8] Add RSPI support for RZ/V2H and
 RZ/V2N
Thread-Index: AQHczNp/KrP9S0vVo0unK2fVpF4Li7XiLECAgAVlPmA=
Date: Mon, 20 Apr 2026 07:19:14 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818A42B47C1AC66A5BFE86ECD2F2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260415131919.95486-1-ovidiu.panait.rb@renesas.com>
 <aeFMHzrKwjPxRe0t@duo.ucw.cz>
In-Reply-To: <aeFMHzrKwjPxRe0t@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB7129:EE_
x-ms-office365-filtering-correlation-id: 03d468c8-ed89-4bcf-101f-08de9ead2074
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 ibgfpHjaFzrEdQaK6ANsmZlEIVvCZVmsWE4eKMjf791SqAWQL/T5qRDZ0sbyv7BjOacYmvuEVTJbUUBNNEC/Kt0JsN/YT8G7C5Gn01r+GeAFwWIiv2xmq6JU+WxP/+71FCZcdB8iaLYKBGK1cqHaTKU6NQv/Ov/h1mlZfFLceE/ul2U5dPspcmjHwrw7jTdJiKLzML2oHTM0vzNrGp4MdHFi3eoq0OK6knJVs6hsQ6XESYswDd+5F5K1MUSpEcsm9ruzfPI87atckUaTx/wHUhcIX8fjX9N5xnISk4I8zK5vRxWB4TsRkBp9fO2lXKKFBqcU6Ef0nP2EQw98X5fVj7e4O36PRHBCtsriAfiz2jj1z6IRQ9TVuHLs73eU6c2/C96LgUus0yHn4XzbrnBV5AynIT0ThkhWq2FwhH/HF8zUV8jj4v98ASfTiLxfxEXN8aMXsD4gQ6n8CphvVCAx41kGXYITVkeWKmH5HrFrUzMGJiBUaPD+SzFS3RNvvNkKowMKw6p/8yuHffIoYMJ6Nnu9vgSnSt8r9qqPZrMQefWyBzNlcxd/sm2g4Faz03taVVpdw4fOR5rZogwTJN+W8uSRjqYgLCIlffrEb9QgIWJkIKVAQxDeSFGmKG/H65DimfR9kj15PFc7tnOeZxA2YPLDDYwTKs8pXxQTXuCUxAONDItvNBX6QxjMlywJ/Jpboq/j5byOcfUsWHq49Q/YxkiMAVdW9EpyuirT1YgRvi0XKy9wc8koV6glQbX+uTYO3VUrGO00EMA+icyhedLTZzTfVS2/hMfxsWbVlDGS6r4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dGg1NnA4Q0lNZVhpTk4vNGluOWhVL0wxUnlCME1lNEJYSFhkb2VzOHVB?=
 =?iso-2022-jp?B?andrTkQwMGRYU3JRMWt0eFd4VnFJSnRqQ1NYOUdYZEhObE93SllSNHpp?=
 =?iso-2022-jp?B?K2R6SXF2ZXRRMllYcUNFejdBemVoMW90NGFuVmZCT0d5dGd4RXFxUTcy?=
 =?iso-2022-jp?B?WEc5RVBzZVFYT3FZRzczRmg3NENkMGZURURjRVl2Y0pCRzdZU3UrUUVj?=
 =?iso-2022-jp?B?cVFLVktSQ3JyUzQyNjNIdlZSWjdlYnlsU2d1bW9uR3AvTmplRnFCY1J4?=
 =?iso-2022-jp?B?dVlFLysxS0N4bkorV0JCV2Q3YzMySHJFa2orVGxvZEJQWXhhS2hVMXh4?=
 =?iso-2022-jp?B?SkFEQzQwQ25XTkNqOE1zV3Voam5wWmJUc0J5NzlDSVV1ZzJOakRVR1Qw?=
 =?iso-2022-jp?B?YVh6RldyRmg0cnV3MFN1MDVTSG5UOW9TUFpIUkdRSlBVbXFtYTR2aGJ6?=
 =?iso-2022-jp?B?ZDUzR0VUM1ZlNVFxUkZ6ODUxaVI3NjRuN240NlFzSWk3bitKbkJyWllh?=
 =?iso-2022-jp?B?a3gwd1FVU29pVUJlMFBUb1VXc2dZeEE1S0dXUTJkcVl0MHlsQWMxT1Jh?=
 =?iso-2022-jp?B?UkY2QVZjNllQMnpmNjNMZ2c1T1hXUU1IemVFL1dleTZIL1NGRlVCV1FY?=
 =?iso-2022-jp?B?VVpmRjg3SVFIODJpSDNxNXZubzZ1a2JhYmtWbngrVkp6Vk5nWmVZVE9H?=
 =?iso-2022-jp?B?dDVSTnBzclFkSUJFQXI2ZWVIM3hLMjZsekJuNG1PMXFNZlFtMVJWRjVX?=
 =?iso-2022-jp?B?OG0wMk9qaEU5VlVOdzN4UmlnZ2pYOFhVMm5UZjdQQXdraE9PQ0Y4RlRH?=
 =?iso-2022-jp?B?RkM0Z2c3V3dHRHNnVnhib25ZelRJRllrTFk3TDZHSzFoNUVQN1JFNVgv?=
 =?iso-2022-jp?B?Y21aMDVJbWdvWU1kdEgwbG1kTmxsM2lVQkw5SDBsdkNZN0FSaGVtbC9q?=
 =?iso-2022-jp?B?VUlqbUQzcDRIdjl5YzNXbmwvb3VnZkxHdXRVWSs1bVNrY0kyNGlta1FU?=
 =?iso-2022-jp?B?S05ZT3dpUkh4R0E5RXVaRW14V1hpdlRod1g3RGZZZTNVWGhRQTZGZTNK?=
 =?iso-2022-jp?B?N0hxY3NWdkQwVFhZKyt0Y3NXYUlsSzJjT1FId1JHTGV5R25pMlpkSzNm?=
 =?iso-2022-jp?B?a3duV09qMzdsQ29uOTZIaEEvWDc3Zm53MEhTVXVwS1BkV0QxQy83b3M0?=
 =?iso-2022-jp?B?NElmUFNyd0xlaGp2VUpRaWQ1L0RNY3ppcjRDOWt2azJvR0NpWlVpQXZX?=
 =?iso-2022-jp?B?R1YyYzdJNUV0ZE5VVWV6bU9RRTRtTFdkajc4M0lzVTl5b25KMjVycnVv?=
 =?iso-2022-jp?B?WHRIbFpGOHgrL3NSQXozdGhkbzU0b0RHTzVIMWJ3a1V1M0hETElPZHZp?=
 =?iso-2022-jp?B?UWtYVGprdFNjL05RZ1BJaE54ZFVjeXFQc2RsMkdKRGltQmwvS0toWmtz?=
 =?iso-2022-jp?B?SkxpMURVWUxKUlgxeEtXcjJCUStvdDdEc004UTBuUEdlckxEMnFIZHJU?=
 =?iso-2022-jp?B?VXJHY3dUK05WZWNKT0RTNi9QbUEwWFkveFRBU1FKam5haVRybkloS2pN?=
 =?iso-2022-jp?B?YytWVWVQb0tDUnRrOVlpdlFJVzFwcXB3NWFaVXZueHpBbWgxV3NjOGJn?=
 =?iso-2022-jp?B?MEpoNjkxVmVuVlVQS0RNQnNvTStRM1RRZEVjQ0RRQit1UXFmcHc3ODNJ?=
 =?iso-2022-jp?B?Z0tlVmlGZ09INGR4VFZWbE9jbUNqN1RpL0oyMEZEeW9JZW1VOEFJTGMv?=
 =?iso-2022-jp?B?Y0tXeDMvRnU1QnRUTC9wZ0pwN0VpaTUvbm9CMGxoRHM0N2hSbENrWGFN?=
 =?iso-2022-jp?B?MnFLRDliQVhPWTZUUmlsNHY0VGxRbERFdEkwM2Jub0ZHSTVKK0N2SUlZ?=
 =?iso-2022-jp?B?V0VSWFVsem4wY2VoaVBzdVBEcktKZkJ5dmIxc2RWcVAxMXdaWEZMdUV5?=
 =?iso-2022-jp?B?WDM0NDQ3OU45RGswV0xhb0lCa1BSWG1lNC9xRHFSc2x2a3VLYzg3RThO?=
 =?iso-2022-jp?B?N1V6SkJIMzRFeGZvYXJjaFFrVVVNbEg2dlhVTmxUN3JJa1MvYUpnU0pQ?=
 =?iso-2022-jp?B?bFl3OUZEK21IMXN1bmJpNUtLbVdFWHNaUUNuQWt4bWFBSGdtL1ZJRmNE?=
 =?iso-2022-jp?B?YWdzQ2ZDTkJJT3pPdDYzRHhqdTVQaGdEUHpnQzl2VU91N1JwY2hCNEh2?=
 =?iso-2022-jp?B?cnVaSEw0Wk9nWDFyQkRUSDZKK2Y4V09WKytOQkE3VXBwSDEvSEN1NkIv?=
 =?iso-2022-jp?B?cTFPOHdZdkVRZkRKN1FkZFVab2tPOXQrbFdNMVNWU2EvaGVOVjhhSTRW?=
 =?iso-2022-jp?B?KzZoM1A3eEY3UHU2Q2Zjc2xUY21EaGVMSEVTK2FMUG1BaUNId0R0Uzkv?=
 =?iso-2022-jp?B?Rk9rcU1SbWZJVHl4TlYvalBPSjVaQ09pYVNLd1g3VTBXc3RMRFpzRkxh?=
 =?iso-2022-jp?B?Rmh4b0MyZzZSdWpEQlhWV0RQd2FYVUhHbk9qdGdlL1QvRllHV2VMQjlS?=
 =?iso-2022-jp?B?a0poK3AwNWN6d0cvVUhIc2NnN2VEOGx1eGoxVDkvNitLdHFxZVVVMXZT?=
 =?iso-2022-jp?B?cDhtYzNxRT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	krqKkONOQ5jcY7IXLVxW3Hyk0VOYjWt5wnuAqGjSgYXH6u8Qesy9CsUOhcc9+ebaQ0lUWQbrB7Yd8X499FOIt6aQO83f+ZHNLm4m2/+CJ44XKwmHgQfYjRg0nTBuaiiveQlkmFAmmzui/qO/f+ri/LPaRY57d2tNGYoqIy+ZNs+zIXnh8UmLoc3BXmaaY4R/+QjwU4ZzvL1wBHhTIetsitTlMj5QOXbLtGaDL9wz0Wu8M1NDrpmyNTyUOWkkXZCQtFSBXl7XKLLk3tWWCk2dNyyDUG50jEoNSt753RJ65y04hGtSN6Pp0thz4YatGOiHSH4+tvuuF8p+RLbxsQiVtQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d468c8-ed89-4bcf-101f-08de9ead2074
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 07:19:14.3698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ZYNq9aOZTxOmnsw08Hc9Z0DhyvjDuZzMY4IuLBfM7LVaw+qO6loSTd3FMMKH++YjM1d5TZsaQVMlvLYcTFZ6COphvG24LdmAVLDOajvRUkSeZiGd2nrWbBjV0EZ1WPC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7129
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Apr 2026 07:19:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22765

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Friday, April 17, 2026 5:53 AM
> To: ovidiu.panait.rb@renesas.com
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/8] Add RSPI support for RZ/V2H =
and RZ/V2N
>=20
> Hi!
>=20
> > This series adds RSPI support for the Renesas RZ/V2H and RZ/V2N SoCs.
> >
> > Patches were cherry-picked from mainline kernel.
>=20
> I had some minor comments here, but those should be fixed in mainline, fi=
rst, so they should not block the merge.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I reviewed this series. It seems to be fine.
I will applied and push with Pavel's Reviewed-by tag.

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


