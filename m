Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DC7CA5FD4
	for <webhook@archiver.kernel.org>; Thu,  1 Oct 2026 23:52:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.821.1790898718795959609
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Oct 2026 16:51:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=YiGq+/pq;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1790898716;x=1792108316;bh=ZCPGy5Q6ApxsXc86h1oDfkOJd0MTSuPqJvmdd
	bM9aSA=;b=YiGq+/pqiPpoAv/oYE7XjqCpUmhs3+yB9eyChYJsfpv+pIN2SbDFFAyami/wRt8VXSc
	qoZkOz98nCyM295a4EeXib39EbL99Z20G4Cyd+eTjf0GST1ygVYdRfTOEVgLq6bAlLklCfJeVTrpp
	N4XQxxS8rL/kEVjwr4Z2AgvFI+GLF18LvXKxxwYcwg2NchRu7iMg7NA9egC68Q8t/RfcVrEvhVqAp
	lBUm04oI8tE4FBoiANuG6SynwXNnRSFvpy6F4YJ0QWLfgRLsRsefn+qT0kS0admXr/lQluSxL83ll
	dYzDxMO/ZWz44BtTHqOCP+aZFB7+7dPDAiRN6fCdcESw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 691Npt5a1701674; Fri, 2 Oct 2026 08:51:55 +0900
X-Iguazu-Qid: 2rWgJYzA68gVzq53Ni
X-Iguazu-QSIG: v=2; s=1; t=1790898715; q=2rWgJYzA68gVzq53Ni; m=XEkoNctDTDnIP7HSalPjnwINZBM5Lj+/AJRQadrdpso=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hwpbv2p6gz1xng; Fri,  2 Oct 2026 08:51:55 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdoHX5nzeTaMlrso9vrtoIP9O71YN6ZIU/MAQJbTTKj4bAlAfwX+4AqkRuaooUOvoCL9Irvgy+6NWL3nwtcY3IuuatXI9Ec37mNDCkaKyi3IoqYpb+YeDjTLaMyRFctJzERHND/3Utrse5bSuWHTWjTdFH/OtSDsyxfhYuhL+gzjEMvcptAHhQscm3kNDD27d0TdhyYPn7k8ZYyHWp4dJoPyr0JC9JYRrwdij+D9+ORKEMOmNJMVUSeOgCcqwjC6MK+4y/uCVaQuVuWCbxP18LhlJo/vqrkwcVhhg9ay273qnwf9qJMrLDH4xUfxHbf3LMFoOQwyeid8SXmNuW93bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfl0INGWlHeLZ0sIeJPynuQWS9hrirNQMdUtksaGN8Y=;
 b=oST+ABZVCiNdgS4pOmgX6RJzCWqL0+dzNGZ14knwI1ugmKP/BD/PUQvHbvT3n+6OfhJnEifOe7+jkbq+vPpHZ6lUAbpku4H9otyDWUG02OZ6ZCKdD31wHjFgOKtWkbUdUsMmY/oqc+K6Jkca3lufDHLR3bwUoxIV6s677FbIxDjZsbitx0BFFnakzXVebSfJWtTbLS8cjtZtFioy1VzdQ0yKd8vjmFIZ6RzLo+HZcJGWrYI2Xu9IPpS18kUNJFUTiFzhKmUW/14CPqBWHhYSgelr3wmyCTDFK1+z9PduvtVaRgzNI9OZn1PVkbnBw0cFeRTAOyeg1I+QWJuA6R8Ehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <claudiu.beznea@tuxon.dev>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 5.10.y-cip 0/4] Backport RZ/G2{E,H,N,M} iommu properties
Thread-Topic: [PATCH 5.10.y-cip 0/4] Backport RZ/G2{E,H,N,M} iommu properties
Thread-Index: AQHdUO25cT8xXzDIPkeTsFFpiQlPGrboelkAgADjMHA=
Date: Thu, 1 Oct 2026 23:51:48 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818E6C5018E7516B4A83F8ACD8A2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260930150929.597001-1-claudiu.beznea@tuxon.dev>
 <ar4zSql9jPk3V1JV@duo.ucw.cz>
In-Reply-To: <ar4zSql9jPk3V1JV@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY1PR01MB10704:EE_
x-ms-office365-filtering-correlation-id: 621f3907-3cae-46a7-91a6-08df2016f560
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 fWNRx3bNiMNB0n5NMy8Qrb+HaajS+QhpC3K6eFixgtBUPbE+MH0j9etudEPSN7V5tOR6I1Lc6g6FRiVgMkYQa/qXALSyiFjzVMPi7MBUSnicL3oGO5vurtvGAc8JhqDr++GVR7mSbWdXcS3PigeVFzJd8Ebkycmp1Xn8B7yoZmaRR12O2bx3ghihUqvjIcJU98ippnAK3V9IJcw+3eanlQS918gQ+KbbQStg9bjnjDUBOerUXSnMNGwZYTqKRWEiUQDDaUxyWvs0bk8me4deHK5m6ih5yzwYO4kvOg9SjPGsV9r2tvaetPjwckwOgkGSYR9dtHMlefBugFwBtTuskov4QCLVWNPugJCrK9y/iwPozR/B2SwCu1nA6M1VPyLqWu7VL8haTfxDxz9iXfIocYiSgVf/OW46XH8gpy2gdE/lMWTHykqRShiMgoeUuweX85BO+mGsa3lJAiyKvGbOSJshHfLE/vvBph74sIWvuvotKC4kh3ef4YTFvTWfAXyEmxw01K1btrVdwnx3wllu5l7ciCE2jFApl1hRg+DiDTGw31BtPA8aME7mz2jLzy3HvMFqWyFFy9SWPW8S+hHAViuAWLZ0PzO7C0bOpJIKfLd9yy4Db5UH0ZYtyuuY1rrBxxXriBsVo7qpjIvfAUqY8tBFxSjge2K4UN2j6q5cmSvXQIfFivl+1W768SW3IjbL5qDVdrf+/56yTC1gyP5Pmw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QlZ6Q1JrN0lYMEZ1eURUTmVVc0QxMHNXeUorSlp4U2ZXcUk5bE82dVR1?=
 =?iso-2022-jp?B?d0gvMnhYNGFoQXdqbFpoY1FkOTFpYzlURkJwZVdSTDVqQ2l5akVTb2pz?=
 =?iso-2022-jp?B?MU5yd3VFbVlldEFMcklYTlBMVS9NR2Vaa25Zek5QMUxOekQ3QVFFa2Vk?=
 =?iso-2022-jp?B?RytnVHdoZit3bG5WQVRMOXlhMUtrU3BXaFZXaWt3YkFXWno0Z0UwVTdI?=
 =?iso-2022-jp?B?QkxWajdkTEtSMEpyeUd1VWR6ZERnM2x0MjU3d2tTMVBXVmY5TTBBcFYr?=
 =?iso-2022-jp?B?a3dqU29mS0FNc1prdnpHanFjUTJkY1JhM3pCQmtKck9kTEVycDZNSEk2?=
 =?iso-2022-jp?B?UFFoSUU0TXp3SlRZTm0vaW9XVXprLzUrc0FsNEVZSXN6NEZ5Y1owaUxM?=
 =?iso-2022-jp?B?cG9RMXlkTGN4T0ZxQkRNVGVVMlJERU5MK2JUMlZhbjhoSUt4SzlSUU1C?=
 =?iso-2022-jp?B?TVI4K0ZQR2pib3JmOXd2bUoyaDFzS1I4dXhKelBoc3hVWDcyaVBwSHpG?=
 =?iso-2022-jp?B?UXM0ZTNzVjhhZXJtc3JGblRDbXVrVEh4c252T3grVFdtOHZ2bkRUUlMr?=
 =?iso-2022-jp?B?ZW5qYTR5VTFnYWswSWdWSmg2NzlRdit6Q3NYL2g0MU1LSzBndGw1Z0xN?=
 =?iso-2022-jp?B?VmZvUi9BUVR0b1l3K0VTaVdFWWQ3MitkSTJvOEhlUWE4M3AwYXB0U2dB?=
 =?iso-2022-jp?B?YklYZW0xT0lxU1l5aXZaOThXUi9VZjBwZzF0U3daY3NXaXh6Qmg0RWlO?=
 =?iso-2022-jp?B?emhQK1psb2xybGhLaFRUS1Y2VUVPY1MzTDY2cjZ5VERKWmpsb01VNnlF?=
 =?iso-2022-jp?B?SEE3dHVxTkFFdG41VEF5YThBcjRkMlEwbWdBQTFmbzBiWnlZb3YxUERo?=
 =?iso-2022-jp?B?cDdvdE1nZ2lrUC9yNjAwSklaSUUwTVhBRjIzVm4xeG5tcEd6OTNqS01r?=
 =?iso-2022-jp?B?Yno3QlpObGFsRldqOEpEb2ZZNHZzZ2FNVHBwSEdpRlBBeDhTU3FwUXNS?=
 =?iso-2022-jp?B?QVVGMjZsMEhqamZIb1MzOWpMdWJ6aWEwby8zR1o5TlZIcnZwcTBVSnEz?=
 =?iso-2022-jp?B?aUlNeGIxRy9XamMyRjlLSEtzYlRVVldldllKMmpGR1NKRVo4dG1ZemJI?=
 =?iso-2022-jp?B?eEpOSDNRNC8yNW9FWXBIa1pqelgyWVczMXp2Tm42MHNLbVkvb28rS01H?=
 =?iso-2022-jp?B?MDZnY1VGcWZ5TzZpNEFvdERyd0RBS2VuRXJsdDYycWdYQXRmQjg0S1lp?=
 =?iso-2022-jp?B?UVpsOHM0bExyL2FZZFpPS0srNkdWUnIrTTZ3Skp0RjdIVm1BZk04eXcz?=
 =?iso-2022-jp?B?SjM0V3hld3VyUExQMmdkYUlVVHlVZ0l0ZjU4MVVPZ2lqbXBRRFpBVjZq?=
 =?iso-2022-jp?B?ckE5TWhEazdTeHdDaUprQytQbTUwK2NldGM5WnhqaDBDVllMZXVSNy9v?=
 =?iso-2022-jp?B?SlN1eGJ5eWRqT3NldE9COURNUU1MSjg0anQxWnRCSDlGVy9XWStaNzNQ?=
 =?iso-2022-jp?B?bGtWR0NETW5qLzhBK01abHVENnZIN0QwNXBLQjlMUjIzNVR2V29JSGkv?=
 =?iso-2022-jp?B?ekxSK2Q4NFV6ZUcra0dBVFVZUEFxMFc2RDNoOU5yRGhxTnBGd2t5cmxa?=
 =?iso-2022-jp?B?ZnlsTjVnZnkwSndLMTFPd3FFNU5tNnhFeXZmcERSMnc4OVYxRFQySHNT?=
 =?iso-2022-jp?B?a1F3UDA5Sm84NVdKeldDUGVlNkl2MmRKNStSSnBzOGRQbVNmbVdPdk5Q?=
 =?iso-2022-jp?B?NHJCR2ttb0hmNkRIMGExMnhaTHJSaWNnTlljM0ZCWTcxWG9ONExTUFdR?=
 =?iso-2022-jp?B?MXlvU1ZlKzJEWGlsaGN5dzdWSXprT1ZuR3Q3aVJ3bTZPaXB4NWhGVFdF?=
 =?iso-2022-jp?B?UXV5VDMvTU1lSVVla2IyT0RFbnlVaFRWdjY2blhRZ091aXpYWGkvRGVQ?=
 =?iso-2022-jp?B?M0dCRVRLUzFpVkFJTnhmRGZ0ZnZmaHhlbnZIT1BmdjBVUlo5TGxlbVpH?=
 =?iso-2022-jp?B?ZUQzNE9SejJmb2Z2bnNOM0Jmb3BnR0tFeWJkWGN3cHJjeXhJcmNLTzNp?=
 =?iso-2022-jp?B?MkU0SlorcjJZbnkvUHd1SXFOd3ZpN2N2U3kxcVFJRVR6N2tQb2plbWlp?=
 =?iso-2022-jp?B?VC9TMG5DN244RWtPUjZCMDg5SmtJbXBtcjJxQWtLRGZLWk5oYU04VUor?=
 =?iso-2022-jp?B?UlJuZVoyZ25ZTmNza3U0aHA5TVA2M3ZYN21hMmtjeWoyVlo1Zk5SZk1y?=
 =?iso-2022-jp?B?MW1DcTdoYUxkZG5CbG9YMkNmNkNVaGpPZ3IyclgwT3Z1RU9DRWphOXJs?=
 =?iso-2022-jp?B?c2hPNzF0ODFjOTN6c29uV0VWK01DdDJCNjFlNWwvZGpHZ3hNV3BMclNv?=
 =?iso-2022-jp?B?aTl6RkUvcTZpeTZJQjBCRE15ZVVTaFBXMUFWc1JNTnhDOWFJSFpva2Rl?=
 =?iso-2022-jp?B?L0dxNjB0eFNJR2Fva3RWQ1VOQU1IdVR1cVlmbnZ0bTlYVzEwNWhEcy9x?=
 =?iso-2022-jp?B?K1RrZ3NyNkhGcHVBUTN3M0dmY0FOYUVwbHRaUjJhWnppK3JVZHE2REVZ?=
 =?iso-2022-jp?B?YzVRK0RhQT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	BFl3iUAD+wQXb7tV4/biAXxfFIXRDqd99ZQ2mX87bHRSjUL6PmmNrVxMbb3AoYaSHWkNLBOugO9Q+Q3TXi2K4RXrpAkShC4PtAaWoCSG1QJm2KzHxZAMfB9C6WL/N1QO6f7FKWdYqrjp1PyAfjfWppO7MZWoGRHnxqDy8Ye5bfqOmJiy4eaJbP7V+uKr5S6R+d+Ryw4HX4hN/kCsPnUIilGsfjG5cMvS4vyc+7aKS9vKKehpBcaSToUKfl2uH8iFSHnL/ks/0cwfPuJKqdJZBJUzWGB4fl4sCgllXjWR5uL1xXkZebpS9X6GbI8y6a/ZB3SnVE1VIyVf/PWwPKY0IA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 621f3907-3cae-46a7-91a6-08df2016f560
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 23:51:48.7862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5IB2bWBXHD9wbgr0FLTk2VpPLDr420KXAxo8AwtTmgcohmt6j3RaTIQpvtFxV2nEy+zSdqy7GHMasmCZwV7p23rmH+XIXK0UJb36iicFA8OsDB+wPplrZmioyRv/OT2d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10704
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Oct 2026 23:52:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24400

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Thursday, October 1, 2026 7:18 PM
> To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@nabladev.com;
> cip-dev@lists.cip-project.org
> Subject: Re: [PATCH 5.10.y-cip 0/4] Backport RZ/G2{E,H,N,M} iommu
> properties
>=20
> Hi!
>=20
> > Series backports the missing IOMMU properties for RZ/G2{E,H,N,M} SoCs.
> > Without these, some boards fail to boot when CONFIG_MODULES=3Dy and no
> > other modules are enabled.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I also reviewed this series. Looks good to me too.
I applied with Pavel's Reviewed-by tag.

Thanks,
  Nobuhiro


