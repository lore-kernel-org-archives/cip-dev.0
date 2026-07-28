Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C92FC54F4C
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 05:25:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5203.1785216339762520551
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 22:25:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=vbKaDv3B;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1785216337;x=1786425937;bh=OPxelorgoWWAhMLSp/COgrmb310H6iYtTW+IL
	x+jUis=;b=vbKaDv3BDCx/se8s2hPF5iESlIN8xSE+rglNAPQjExbyqFbi06So2vU6gXZVzDkuHsc
	P16ABAQHhYONd+jn5e1SP/X8QYDYG1Wr5XcZXWGAV6Pg5EFciIBuT2pF9ivvMFYy2LAWDn8Z4gMxG
	JCt9mQOfu19KgxRr4I/jejnB3tuGlOy7LGD/9wMO6YBGcwNQKzwHiHbTLbk9p17WbfKYSsxCis+Lm
	l2ne5l/5AzMJIEpsy0Yvozh8k5fb8CCTWnRRP3wprUIj3i4fb4RG0tFoeK14GcEMTEsEIH0thwd+7
	9/Otl4OiruQNokLfEIGm+mPVfuhUxdUt/VT62YO//ENw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 66S5PbPb458220; Tue, 28 Jul 2026 14:25:37 +0900
X-Iguazu-Qid: 2rWh1q7vhNx342hsNM
X-Iguazu-QSIG: v=2; s=1; t=1785216337; q=2rWh1q7vhNx342hsNM; m=digb6FKieiY4ntJBsfDXREvpqOraBK8ZgtBQ8nCFrpU=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h8P7N32wcz1xnf; Tue, 28 Jul 2026 14:25:36 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbspsI1zgTgFasXBrcDI1q3htli5VcFhyzP2ZrFRy96tFxaPV07Q2jikGftGJRZRCaBIYGt071ZP6eRmoNF/zyGUejcGdMK2ZR9QuNVgfKrTSh34ACBYgxPKNzyFw1ZhuRoBVGHnDNToXz0IZsc7HT+mAJxQHI1j5K8DB2OXDSNS1oiNh9BSkrvtH8ph6sWLWmc6HvDyuFpq6FixhgT19Zvn5nluNg7nyBCkEmZxPsjeGvacd4Kgf3SGM5O8bydgHLD5RYwnbiYAYxTF4I8dxvSR/2TaszAsCDdvJauP9qrIvDVsj9Ins4iuQvWwttWxVfGakf8z0lZqxGOmAQb9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQTf4pYk1Um6ycMrnHQP4j+iB+dIeh6BV6Blya79vSQ=;
 b=wIa2OOFgqSdYsFItJfeMAYJGID3AltNtS2Bahuy5jZuu+5cNAU3lSwF9cHmkzkm8694pQTt2TqGYwcmWNW0eChENP5LXOVtEdYBTsx6K00it3NjWeHhswvPCrXdwA2xwNwYeRCPL5Jn5tRN0Dp47nOTz4fcp3w8qXbYTTm/YhZJ0XTglLWPkebh2v1Blq09gQDiEO93BcojhHZBkKcl2eRBg3e96dsxnlSkfC2HkVahounccQ7DwUcj8aR7/6eN/6WVFVMBHYIpDc8d6ey71PYKS3YpgN8rian5l93mjbkCqnUZJZ1xKccw7rF86uQB5xF+2K72w5Je2p71Y4+6ltQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <claudiu.beznea@tuxon.dev>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 5.10.y-cip v2 00/27] Backport RZ/G3S USB support
Thread-Topic: [PATCH 5.10.y-cip v2 00/27] Backport RZ/G3S USB support
Thread-Index: AQHdDrFPlazEBiFSP02/Y0j+XBdxbLaBbOIAgAEYBFA=
Date: Tue, 28 Jul 2026 05:25:34 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818DA15727F4A8C4BDDA781CDCB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260708081046.3882290-1-claudiu.beznea@tuxon.dev>
 <amdRyvFNnVoYO2V_@duo.ucw.cz>
In-Reply-To: <amdRyvFNnVoYO2V_@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB13503:EE_
x-ms-office365-filtering-correlation-id: 787f7ed7-c0f5-4ebf-db9f-08deec68a635
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: 
 XkpKtQbF/qDtxYEfUhxiJ01iuL6NoNBpL/vHPRCFEB5cP5j9U/Wt47h/8UWGmsyYIXHFD15KZ2vEKpcBbOdXNW8JAL/4uH9pw37RJHKEt64oA5unGDkKfXOuGAf/LrA4TvrP4KOHi+dEi8Yiy6w9Tz6FZuSW40635cf8rvpN04ko4ckcluQhHLCSPjWMyDeMVvTTB4WouqzUvKZ5m/9ZJ8vkNGOOpdoMh5CD1ihk0tQmB94Z41fl5vn5N61ffL49unI8nKQCt8rIbIYgF3ZeO60OINduHd7AA+RB/aFVmgo97RghfY9rmOWRtcIX4iUK4GIQdPY8UrJCDVsKJdILKsMsP2Crvn2QGBtEuaVap2VY1dHgw4bOVqQrNh+CCntDyI1I2aIvkOU56qL5lPixUAO1WkrG2u3uCplOQgXmB1kXtF6NkRC5hyev93UMfuuxfQ1nXytgbkbAXvnfHK/7u6CCN36749Ea5VxhB9fp/4TLCwazJY2Af/kHZIBdTlkJB23kSlhcA/y1SfHBBIFVlIu4/zCkf9dzp03tNK71qRaZc+h3HCVC2yq0LBrNDt/bw1ANHgJEtmgWYB7ja1ND+RtUChDEVPQmZMT4/YnApEuu4ENpQgSyX1fNM6la+YDJ3nSDxAsJX3bxnOs1a5STvJASqgbkRwuFP5ZWEBES4LYY84cWmrwHqpc1KokKCgSkuVsRLif1mUaXk5emmmDcdw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?R2E3N2JoSkdsYUhVanVWdW85S2tZVSt3NTFNNkpvMWppck9wWURCRnph?=
 =?iso-2022-jp?B?OGNmRDFmVElJSHI5NDZxT0RKeTc2Z1FBdVZvUG05bFJLcVhyZ25meHhw?=
 =?iso-2022-jp?B?Nk9QeTZKZ3gvMVkxYjNjeGlnQkdoWS9PNy9hVHJUVkwvWjhrMnV2Tlcr?=
 =?iso-2022-jp?B?LzBVR0dud1V1T21zTkpZcExzcUZIU1FPSFB5ZjV4MHUwNVQzb095VUEv?=
 =?iso-2022-jp?B?N3htZEVwZENEWUgva0tsZzJ0S1ZuRjYxSUF4RU1BNGlBSTdVUzlzUXRN?=
 =?iso-2022-jp?B?cjkxcmZxdnhYZDZsaWozY2h5b3c1ZFdWTUZMd3hBdVVaTDZ1NkI4ZHlS?=
 =?iso-2022-jp?B?Y0huOFF1UlNPbTA4VmtVMjFtaEFrRDNlN1U1Z3pYTFZ2T0dMOXo2M2Nh?=
 =?iso-2022-jp?B?cUlQTXJpcnJFYXJ4UXpNTFdSeDNwemZCUUErYUs1KzQ5YktUTkpNYXZD?=
 =?iso-2022-jp?B?ZVBmZVZ3dFByZmx4MXlXdzRYYmI4NitjR1VWR1ROTmowOVJ5VzArL0dJ?=
 =?iso-2022-jp?B?WE1pdi9VT2h0cm5FRGpaWWJMMk5qNDZZSS9aUFJid0FnV0FndU41bHor?=
 =?iso-2022-jp?B?a2l5c1BkcHpPRlpqZ1NBVS9QMUV0TmZSVUZMNWpHK3V2T1JJWlJrNVV2?=
 =?iso-2022-jp?B?ck9Za2xiRHZDdHg4UmYydHYvSjR6R3hKMlY2RytocEZkL1JzQVo5Si82?=
 =?iso-2022-jp?B?V3MrVHhwRGVYamdoYmVlSDY1a0xjNjFUWUtyWW9vczAwZjhvQlVsL1Yw?=
 =?iso-2022-jp?B?ZG9FY0EvalUrOFFpSVpKc1VYamRQOEE5NkhQRnM2T3YyVDdWUlBUcW8v?=
 =?iso-2022-jp?B?RDRIcGtYM1o1UmhCdStuamIvSEtiTXpDTzloWDBiYkVyMlNxZ0FrQzFM?=
 =?iso-2022-jp?B?NzNIUktWdC8rNTc0VlBGVndOQnRnSXViOFViV0NTdnVST1JlYSs5dExq?=
 =?iso-2022-jp?B?L3Z2SkhkSFU0RHFjTHVudm9MTHFvS09EaVQvT2JTb3dLZ3VOdUViMWRQ?=
 =?iso-2022-jp?B?ZkdQQUVvcVZ5TndUYnA2cjN0aEppVG95d2kzL2hnNUlmWU1qejBaOXhj?=
 =?iso-2022-jp?B?Q3R1UEx1VlBhS1RSWW1ERS9vUEVPdFMzM1BiSzRkWkNxN3k0ZkdYdjln?=
 =?iso-2022-jp?B?UkcvRjVvZ0s5NE5DdHRvSlNxY1gybEkvNVJlVC9YL0doT2V6OUkvaXdk?=
 =?iso-2022-jp?B?emszd2d5djA3M1MyRUdsQS90clQ4b3RjNHR5S0FRU05NcjVVbWh1SHdh?=
 =?iso-2022-jp?B?V2VPWG42bHBHWE5sTlBWRTUySUtJL3hEQVpHKzBjYVh6Q1F6cUR0MFZ1?=
 =?iso-2022-jp?B?SnRUY1RmcWZwTjEwQW8vMm1XTlFMTERkbFpXY3RYcFhWTjNWa3VLZlJp?=
 =?iso-2022-jp?B?SzNjcmR6UUt6eVpTNC9kZU5BMlRVL21rRFZaRlk5d3RKdnFCRzltS2ND?=
 =?iso-2022-jp?B?T3RpZmhoV3YySG5HbTEzcDBxVlN4RExhNUUwUC9aNjh1WU9vVnZJTms0?=
 =?iso-2022-jp?B?Q0ZDMERkd1EzOTRYSWhaZWVldERzZDZyK3NXTXlrRFBXZFJQUm1HTEV3?=
 =?iso-2022-jp?B?QWg5WXhsY2M4aEFuQkF1em0rVnl2VXdkZDlWb2VtNnM0M1YyRDV0N09C?=
 =?iso-2022-jp?B?bHc0cnBSblVyaTFkSHMxRkxDZmR4UWZJV2J1aFNxeFZFaXVvRW40RGpo?=
 =?iso-2022-jp?B?TCsxZEhvaStacHpzZUVmZTU3aDNyQUo4eDdGekRsanhSYktpcU9zTmht?=
 =?iso-2022-jp?B?aTQvWDU2TGZoRGg4VXNwQnhJREVMeEl6UVRBNXRFanE3OWpJb3FvZGQr?=
 =?iso-2022-jp?B?NnpLYkJOMExNb2o4aTlQeTB2dmZpVmhGM3ZtVWxDOXEwSkFMQ2FuZGxV?=
 =?iso-2022-jp?B?ZVdzcjVRVU9VM1F0Vm5OMjRMWWxJcFl2QytyVmhVQW1NaWFpRmI3cVlB?=
 =?iso-2022-jp?B?a1dsOUw2MWV3TzEyTEFiV0FwdzU2TVJsSmFqOUlJSmhkZ1YzTmJaM2Rq?=
 =?iso-2022-jp?B?NWlhMEZSY01LcHR3YmpMaFVOU3ZLaG1CMTRiUDQ5RUcvbHBadGdQbXQy?=
 =?iso-2022-jp?B?b2FHKzJrQlVzcTdZbC9JSzV5UkxTNE0ycXQ5T2xpcW5pemxwcWVzdlVZ?=
 =?iso-2022-jp?B?NFJUN3JtSjJEaWJObzdpUGRZOEtoeExRUjZYUXBGdmQyMEZ4RWFFWGlt?=
 =?iso-2022-jp?B?RXhxTVZrUDd6WjJtSDM4QnRyZFFUd2tUWWFjSS92SWFrSS9xaFF4T2p5?=
 =?iso-2022-jp?B?R3NnL2wvTHdpcnNFOWFoZGF5K0g0bk9sd0Qwc3dmK0tDMnhJQWNtVVV0?=
 =?iso-2022-jp?B?KzloSVQ1N09ObVc5amZtMGlON3ZIZVIyckJCMko1NlNTUmRXRDVBVkJD?=
 =?iso-2022-jp?B?STRCdU9lYmM1a2MyZmZRSEJmaDhFMlA2RnNIZWpWRkNDOURNY0pTZkJ4?=
 =?iso-2022-jp?B?R1NxQWlDc3lwanEyZlFpUHVzZXdCRWU4bSs5R1RJT0I5czJNelU4M1Uv?=
 =?iso-2022-jp?B?UHdYQUZEVGx4SGwyQVIrOWkvQ2g1MkVuREsvcStPeEx5SmtnS2NnNTRq?=
 =?iso-2022-jp?B?Z0MvYk9tdz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	U/EpqvEuTj+641G0z/GKrymQtBrzNKJJBawwByGWvCQ0OnOPi/GfAWJmiSkN/i1XvqfLvuLI3jTCSgXL0lXA24lZJ0RQW4gvtVwcdVKXIF/jWzwdelTx8F4tmEA2Pjo3HmWjO22x/p/9KY/6Hlds16ibkO+6DihmKhinPPMYDi77YCtKJ+NB/Kffi08blYFOEu+hLy1hj8i3kQS86AVvzFT6n3BadOGMcf4sQKgOgrKnhVb4f1H41db86VBpaivLQP3X+IyzzLWmgooRvOOa7rYH5ncETXLxoqvsYhFjaKoDcECaFZjQKgyj3YJF/RCx0LtQpvByzFTfEfpfYqf0QA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787f7ed7-c0f5-4ebf-db9f-08deec68a635
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 05:25:34.2407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwdZtV+7jc0KxWASIN90Hu/w5LiqEjrg0iDYEyCsRVFfNfBWM9mLAShn619xPBwdhNYi8fkyrtGxrch4sESbITAKkCatEmaTAAFGRZETXRj3KMDR8J8YjMFKRP2qSa82
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13503
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 05:25:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23789

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Monday, July 27, 2026 9:41 PM
> To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@nabladev.com;
> cip-dev@lists.cip-project.org
> Subject: Re: [PATCH 5.10.y-cip v2 00/27] Backport RZ/G3S USB support
>=20
> Hi!
>=20
> > Patches backport the Renesas RZ/G3S USB support.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20

I reviewed this series, looks good to me too.
I applied with Pavel's Reviewed-by tag and pushed.

> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


