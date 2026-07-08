Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B57AC43458
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 21:44:27 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19481.1783547064483091394
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 14:44:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=qsGKQsPp;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1783547060;x=1784756660;bh=KHHxSCgPBVPi5qvbX1dpuWJm/dWNpaxbsO5RS
	jCDv9g=;b=qsGKQsPpVkQcILex0dExZSPcj9qeNYKOqqSapCWK/GBzGxbPfFcumLR69q/37rRU6D2
	IAh8Tpv9WWekCAEZofFLbZTLt2EWXqdOD2XnkMaxFlii+Rtwp2gzTpJqbr2SALAGKZN9BZ3zdrGBf
	vPJjzTm+VvAiiJ5JJMC5R0Ycd+isB7fq/sRg1wSVC1n1E8nGiEIsxK1GCCIrST97uUxYw3hNWzKHh
	5ERLR9qmreX7eYyGPwcd1Icds5kynMAURXNmvQnvknmW7WPwGszPkqSw1DEguuSoSsUapwq6qnZ0x
	bRVlyxVy9tUI36SFV8p1wtYEK5BSaUCKCzm0vUxlHmgg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 668LiK1X2173588; Thu, 9 Jul 2026 06:44:20 +0900
X-Iguazu-Qid: 2yAar7SANfgo7f6zfX
X-Iguazu-QSIG: v=2; s=1; t=1783547059; q=2yAar7SANfgo7f6zfX; m=CVOOnhbGPyxbRamXgOm5zlEnlm7TA9ICNC4ru7VMaVk=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gwWnv1yFZz1xnZ; Thu,  9 Jul 2026 06:44:19 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pps9dHFSR1qgiMv7dBidwc31ftGO5NUtJM6c9IY98m5OqD+usbL+HOrQtfhCm/YITUyK3Yiwf8tmgqwXb8NDdNm8W6d3E+w4fmKQBKRK1DGA6mEtvlMg072uQ0dhTeVTGQcHp7FMnvpTE8T+qpC0Gjc44RAHikjTAt3Zy0juU4/5XSPKC+O6EXyheNGL58zwLiMeuGLI2rfBCTSbf5U7ZQDA/UayheKc3KNpAxHOambu2PIQS08TztRaLEdySL7RUA3rBT9zuZ0YKH/jaA2sIZGUP5hldTs8GA5gcZ77wkoKmbiNy2JngHw9iURmYBICNOwpqUJrXM+9ENFU2VILCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0z1ITA8QpVqbhkxk91vjGI9R4Jl5Zp8ajSkDV6YPvw=;
 b=De0TJGwesDi5m0iDsxhsJ5+vi/qZWvq5zwUAzVi+est0S0/7cYAZzrzJD7mQQf7vxZP6IM70NhIbsXPCz5M9cuVFN1si6m3awbD1M8fbiI3rIWtd8i59ysherHKXSsRVwvlrYazZW9zNqiVpSNz9hpteO8DSShinN8Cr98A2MAQslFYu2iAn0Dp5zF6bWr4e52IeaKV0lyFj+znICW0oCJaVInsM/XyqM/t1FUi2vZeB4x8KCmFFpUNJXIIZ4Tm/YqfEssMHq5VNTDOKPYsXSJDsDHQcrgtKcyDRY4/r+ArQnqPVDwBEnam9s+htODazel4YJ1ujQXvGg+bORGYB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <biju.das.au@gmail.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/26] Add RZ/G3L IA55 support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 00/26] Add RZ/G3L IA55 support
Thread-Index: AQHdCtPYZZsdljBfs0SRqWzEl+a5LbZkGlaAgAAU1TA=
Date: Wed, 8 Jul 2026 21:44:16 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148184C559B9FCE4ED0F456AECDFF2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
 <ak6yWxbsPgT8X18c@duo.ucw.cz>
In-Reply-To: <ak6yWxbsPgT8X18c@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB15943:EE_
x-ms-office365-filtering-correlation-id: 5443dc40-f131-4baa-a0b9-08dedd3a0f18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|11063799006|18002099003|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info: 
 3xFGzPuX0R3IES6EsfHALWN5LbFQuQpi0bYTKwSvI/lCr51kjuqh/mtspxO+wacTMBnc3A/tjQceQ/ZQmupjNQX2JVJ3jNrPpMgreepiFRDyFRCZWZO//6gPmx9glNvQ8oI4nn3r07BgjaJVrAKl/3bQ5M1t+k/NbVkTzgWV0ofpnXy7ISct0iv3oWpZCIytWSz3M3JHn5I1jbFbaqlpv+3zx3L24FSULWCWuX1TQMlTsSttPtV8ySP1nSMaZ84oqNrFn3xAqz/Q8ZE/olxLoe140cVZsA1CGe2dBwAHFTQ/VZXfR4C+IpHLg4OKvqbGwQopGJkWGX6sYYqKjqAJ3ugoCU8vCY37bwiFeQioHitRcTJ/uDr3cTloI1Go/RGor/YcQNpE169N+gM1n/CLFEi3ci7lyqeiqSta2p4kbTt3NRrWv7yh5iUzA3wX09IeNUP2hMiD3PmT7G1VJxdNPBlJUZU+KLEHXpXCcBHB52yvOOeVNLZ04JNB5akSzvBvuY6SD/YJWjk4EEFD+tDubWOiuAGYCc1M9TKdZvptVzvgcpvgP3QMZWPnVr5CsqrcqjpwOBJbresKjKaOVZj+yCFHf/++kV5rdRD21hpnzDa8oniTlb+3iuFmkUpyZBT4wO+HJcAGwjMCyR4yZJWIXYKP1laLUZ5M5Mlj7wSDH+YGuQBkjAOPgERgbknQQOza573dutL3Do8DjXuwIzTKNpjqc1v1wReKv+MeFKApY4k=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(11063799006)(18002099003)(4143699003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Y003d0xGNXVmYUdwVEcxOXd6azBaZ203YlBkUlduajV5UjNhNGVXYmlj?=
 =?iso-2022-jp?B?YVNpLzdJeGI3U292ZVJIMlBzUjE2em1kSjlJaFdKVWN0ZVhJRzlTWHQr?=
 =?iso-2022-jp?B?eFZtSENTcGp1clA4dUdnWkxJbC9ONDRGTjFTWjlnUWp6bmk1MjVPeXZ5?=
 =?iso-2022-jp?B?bGw2S1pGVzhQR2lMVTJYVTNDMVpxZmdYRnErYXlWT2FPZTJvQkNjTjV5?=
 =?iso-2022-jp?B?MDlBeTkwRGQ2RTZjWjRlMDVoUjVKcVpLZzgzK0Urcm8zaXpwaWJxdCt5?=
 =?iso-2022-jp?B?aE8wYnI2SWlnM0M4MEhWR0p6ckVGVXZpSXRVVVpTUEhySlZtdmZ2cVpk?=
 =?iso-2022-jp?B?RTRaY1ZrVGNjVERrcVhRb202aDFlWFhNSWJ4OFhpakFhRENDclJwenlv?=
 =?iso-2022-jp?B?ODdqQk5LVFRFTUZyNHAvTHhpOE9JZXpyLzFLb3FSQ3pWZlNaVGs0U1J3?=
 =?iso-2022-jp?B?aC83clBVMlNLcmxlVmRPTEVIUksxN0xwUGdGOVZMMGYwRU5mWGc5bTY1?=
 =?iso-2022-jp?B?dVQzOVhXNklJbXhwRDJ4aCtiQkZNTWZrczAvdUN6djZVR0JoRXJxWEIz?=
 =?iso-2022-jp?B?QzI4QnczbzUvb2hoYUxWQTk2NVgzQkYvV2dDUjVXRGFEVXNWZk9yMVhT?=
 =?iso-2022-jp?B?cGs2dTJuS0liUlhzUi9pQk80TVUxZDhzOE9idnh0OXByS0lUQnNtL0Vs?=
 =?iso-2022-jp?B?VjlOU2l1WjBTRmQvUmdwVTFqNXpaSkxSbXZ3SWhUWnB4VExWcHFzVThL?=
 =?iso-2022-jp?B?UUxrMFlxMCt0MmJVeW1EdUdETG10ZGUzUmFpS2lNRlNyN1pOOUgzbmR2?=
 =?iso-2022-jp?B?cG91L0pwT0JlRHNEdkkvVEhxcU9vUDlVL1NIaVI0K2RNZ2x2RWt6THBr?=
 =?iso-2022-jp?B?WWJrUHdMQThpQm1odThxT1IyUjh4QnBqRXU1U1NHYWRZQ1ppT3EybGpx?=
 =?iso-2022-jp?B?YTIySkp1dDZITEZBbmsyeVlmUCtCaDRTaGQ1bzNJQmIyMllYRC9jQ1RT?=
 =?iso-2022-jp?B?RU1YeEJpRkRjSzFBblRrczVrRUt4YzAxNnlpNXFsWE52Yms1TUFaL2tB?=
 =?iso-2022-jp?B?a0tNY01nL3A5SDhSR0thcHpFdW5CdU5hNnJ0ZHFZVDVmNmVDQTZNT25H?=
 =?iso-2022-jp?B?SEZacDF0OHFOakpneU9zWHhaSkoyMEhkdHcwbnFJNVJtVUVyMDY1eEFx?=
 =?iso-2022-jp?B?dXlsRlVuQlQ1NE1Zbk84ZHNnSUpKTWRobXRuNTlFTkZIRG41T3Z5SGZw?=
 =?iso-2022-jp?B?ekkvOGxOZko5aVZweEp1bFU1Z0pHWHNnWUVQSjVYaVVhMlZZWFhwYWpi?=
 =?iso-2022-jp?B?MDA3UVhTWUpLUXNDd1M3ZmtXN2RBV0ZURkVrem52R2lrNEJ5Q3gySytJ?=
 =?iso-2022-jp?B?UkxtR0ZhTVArcFZJRm8vQWJ0S1VoUG9xK2d6V2tpdUdLTzAwQTNybjNU?=
 =?iso-2022-jp?B?U1owZmlzZWx5dDlnWHViZWtCSG4xYkpqNXZyYlpJcUhCaTdCS1VCenhi?=
 =?iso-2022-jp?B?Q2pJMGJrV2NtR1Jibm42NmkvQ1lOSzdhRytBNGN1N3dTMTNXNFhoclFT?=
 =?iso-2022-jp?B?Vy80RlJUdlV1UGw5MzNzNXFqZUU2Wm9JYm1vS1QyRms3RUZ2VEtUUUJm?=
 =?iso-2022-jp?B?T0Q0d3FMY2FQYkVYSmpRMTBVUUZlbVNZQ3dtWFBNUkN2M0NqYkJWejF4?=
 =?iso-2022-jp?B?TVZzc0drTlZPSHd0RU1UWTJIYjB3ZjBGTkNVaDk2TWY5cEhyY0pQdEs3?=
 =?iso-2022-jp?B?a0hvOU1jRkNzektIMmx2ayt3U293c013bkJnMHBtVzhyTlVuTWUxNnhQ?=
 =?iso-2022-jp?B?SGtzTytEc1lVaTNmNlNGUlM5SmI2ZG9peWRlcW1tckpuaHlSVTRIZ1lU?=
 =?iso-2022-jp?B?TnBKcm1LamxPQVk4OGxtZG5kQlUwRkgySTgyY3FCY3B3cm5oRHc4ZGtj?=
 =?iso-2022-jp?B?emtUdGIwMlVvd1lNV2MzUHM0WjhJWEw3OTBtMzdLZW96TElZZFMzVmZH?=
 =?iso-2022-jp?B?eFlLaGs4enZHWlBSSXhDUDF1TnpHTnRVYS9UaXNOOXc1RWZIb3VGcnJw?=
 =?iso-2022-jp?B?N0FNc1hENUlRaG5NcGppM0crYUk0WVVnODZWR3h4TW5ENk8vUEV3a0ZT?=
 =?iso-2022-jp?B?WThvZzR6aUVaNGRoUzZMcnhFSVd3MEVwWDVjblorMkZyRGZXUkw1Nk9w?=
 =?iso-2022-jp?B?a1A4VGg5ckJiTTVtdHJpamVnSzZVbEozb1BxT2FwSTlUcjIxeHBQbEZB?=
 =?iso-2022-jp?B?UkNKWitjc3M1dWtic1hhZHZwNzlwKzV1anpaK0hRQmlxQmdIUzFseVJH?=
 =?iso-2022-jp?B?TkpiR1dhcTVUYXR3Z1ZBY1FMYWtlM2hncSttLzZxMmhDc05aNG12ai9i?=
 =?iso-2022-jp?B?NDgrK3N1QzZkQlZ1MUNlRTJVM1lHbnJrNm9EME1sUjFzZ3p0N09QU2FN?=
 =?iso-2022-jp?B?Z0pxNE92RDN0TmhlWEFVYlNnb0VXK2VMS2MvMDY4VGdOQU02NFdxeWVT?=
 =?iso-2022-jp?B?WlNwbWQ2L0dWbWZBMWE3WVBNdWZFclJSczhpbDNkMDkybFh6Z2Z0QTJY?=
 =?iso-2022-jp?B?S1ZWamt3Zz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	XT0z1DM5zadlslfxKY6ukjMHAtci3YaMN1qTyiFnYtkRe1ClausplHddWrklus9fKO9Ip2hh164Ygb/QtkZY6/UQiVpMNfu9PRbGclthppMoK7pv6VZ0UH9WQ/oBtVybLzSCu9Zm1xlNyWutLGY+KfkS4zPeFZ9RanavbOD7ganR1OG2M4xmVPp4at8QMZgwzSWxez97zVuhs16OgWwFpp8iRNrl2AB6MLKw9jx3GlN1l2eaVMjnQu626RMPRssQ0sZoV0sMD7sVvMgJBF79gjiZf1l4Kobt/JbQfHthfQuS73PEfwns1PzlFCz8YHC7Guyms0PQUVw+E+vw3LS0bg==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5443dc40-f131-4baa-a0b9-08dedd3a0f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 21:44:16.4000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pn/S2cLSBz6EOCn5GHgw3yhCTA08CMaqjU/w0lutpEyVZYYurHn/JSMftTEPK81WUK2LXm45D0olbSQ9NZndtEtXG3RM9XEm5+BD8OwrjQjhu/P4slwiC3iK8sC3Y1C4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15943
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 21:44:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23548

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half
> Of Pavel Machek via lists.cip-project.org
> Sent: Thursday, July 9, 2026 5:26 AM
> To: Biju <biju.das.au@gmail.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>; Biju Das <biju.das.jz@bp.renesas.com>; Lad
> Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/26] Add RZ/G3L IA55 support
>=20
> Hi!
>=20
> > The IRQC block on the RZ/G3L SoC is almost identical to the one found
> > on the RZ/G2L SoC, with the following differences:
> >
> >  - The number of GPIO interrupts for TINT selection is 113 instead of 1=
23.
> >  - The pin index and TINT selection index are not in the 1:1 map.
> >  - The number of external interrupts are 16 instead of 8, out of these
> >    8 external interrupts are shared with TINT.
>=20
> >  .../renesas,rzg2l-irqc.yaml                   | 157 ++---
> >  drivers/irqchip/irq-renesas-rzg2l.c           | 627
> ++++++++++++++----
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20

Thanks, I applied with your Reviewed-by tag.

> However... this is unused for the moment, right? I don't see dts changes =
that
> would actually activate the support.

That's true.
We do need an update commit for dts. And this is already in upstream.
Biju, do you plan to post for this?

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


