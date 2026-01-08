Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BFFD1488E
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 02:01:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22803.1767837650275236589
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 18:00:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=gBo6yrv3;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1767837644;x=1769047244;bh=5qaLLRKedNYLCvdTT3YqiqKAWe10FD+4Ll0lK
	FE6Kfs=;b=gBo6yrv3FEAt9uj2fnhyf8oDAdRIIAX8u25pKLjsKcaUKkMzWU2OmxqaKLiRYGzVgDW
	bf+bBVmLDlnebuac22j/vHgtWXYt8SPbhUYd10MsWZGesZdxH3T5weQ+uE4CamLfl7vT+TQZpbpor
	J7Nr/ktyLu9YlQ65nrwF8oJxen6eg7nK3JguP3han8J71LHx0B0LBRcM/a5GI34H5tsBhkqHHAw9w
	sH4hAxmDm6TyKTKZGZIcswLbonnjc5JO64N81YB8k58rvvlCHPPksrhgEksIaiE0IGHPeP7BvE1/s
	XH86rzeazhxJ7rwLtAegADZxq0ic9tfkYrSSZKp/sBZA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 60820hDv1060286; Thu, 8 Jan 2026 11:00:43 +0900
X-Iguazu-Qid: 2rWhnGXnD1gHJIdihZ
X-Iguazu-QSIG: v=2; s=0; t=1767837642; q=2rWhnGXnD1gHJIdihZ; m=KRXK8e+AnzmapY30TNOUh1npP4zATvbffVF1uRae8Ok=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dmp5j4WrNz1xnc; Thu,  8 Jan 2026 11:00:41 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sl0c4LYdmDTXgncn23/YodGbtnsKG8IGNuVlpub94h8XlQJ2ipU2uUXY0zx3QOZsFsxDoMDVc4ix9y89hIcGLaBM23jWMM5LG7FgloG95khW80Xj3d2nOvs+WOklNbgXHl2pghSYT3vlq5SDtOwO6PSbzVKRhaGFYSUuAwpN54wfozpcNQY89RyHeAEQxJfwyBCHicE3YRJzcVmtFhfCE2dX+QW3XYOd8BfFbVcCKvXGTbTMPtmAdHf23xpwYaJPGEebxAPNyRPgWSw44lGerfijnYy7S6MOYsRD57PmbCLoIqiYJob0tSgZrRGr9pZYI+QIjwALidlPdhSbwRd6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXCLGoar28tnhMFv7in7SQ4r6BTRMHbw2unVdazXV3Y=;
 b=OSUCI8rrJNN+fe8uOZz7d4sa487vpT3y/Dl48W0J98p6emIA+zRt4zK0Fla/wnhF1jOC0sU42lSDxAWCXxP0V9e3B0x6Kc5RTyPvRChMDLdntXosm/JYMHhnkOH0zM0Oj8+2lL2tOk8E261VqMJ2f4QRQUTl/qGhHAXhO/2Futx/Pzy6EtULWUSbuXvU+KRi/jGJ5cDAEJU8a958I6QlikkxPWYGn6wxOesf0jBS65xlDh29/1yXNCtBz3pDwzhfZiKEtJC4AJxdaR/Hl/4oB78pKpV/YIYsUACip6CZsTbKb3+XkzM1wYsaDDtXUXYFFvOBIcVgOlmQqOwSp41xNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <biju.das.au@gmail.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip v2 00/24] Add suspend/resume support for RZ/G3E
 CANFD
Thread-Topic: [PATCH 6.12.y-cip v2 00/24] Add suspend/resume support for
 RZ/G3E CANFD
Thread-Index: AQHcfwHuAywIbq5gJUWdUWZ5yuoqcrVGvRmAgADJoHA=
Date: Thu, 8 Jan 2026 02:00:38 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818CD670AF6905B74BADC91CD85A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
 <aV5mR8hWfrCqPoqD@duo.ucw.cz>
In-Reply-To: <aV5mR8hWfrCqPoqD@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB8813:EE_
x-ms-office365-filtering-correlation-id: f6d89ec6-e1ea-4d7d-5511-08de4e59b833
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|14052099004;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?QkpxaWpaK09GSzVtT293dngzellzMWVGcFBEdWVWdTdkcGhGcHhMMEJy?=
 =?iso-2022-jp?B?RTRjRHR6SytuUzdLR1VZUTE3ejZMOURpb3BVYW43UUVJSFZ5bEkrUEc3?=
 =?iso-2022-jp?B?VEJEeFdhd09jSE1EWXBlV0pjQzdtS2tMN3c2L1FLM1M1Wm5CeWlWeld6?=
 =?iso-2022-jp?B?c29jNlhtNmhyaURjVlIvajJGdndUUi9qL0htZU9xeXlQd1lkZnkya1FD?=
 =?iso-2022-jp?B?eHJFQmdydWZxYTBidmZYTFRta0Q5cmxOd2tRbkhtWlVzYmEvVVc1WmhD?=
 =?iso-2022-jp?B?bXdwQjFGNXJYcHp2bTE1T0J6ZTRnMHAraHJpMmR0UHVoWElqYW1SUTFB?=
 =?iso-2022-jp?B?M1A0SmloaG9zRlZrRGQ4anhKQ2gvUzlZeTRiNGhsd0tXcDRrSzhsdENn?=
 =?iso-2022-jp?B?bGhVTXI4bG1kT2tzZkRHN0tQTDVEK0NYNitZMWwwWllURGV2NU9sSDNL?=
 =?iso-2022-jp?B?L0pIeHlJeERjNkhUbVRQRDd2RklmY3EvSzJIaEJrSDBRQTM5bVV3WnFx?=
 =?iso-2022-jp?B?UlRtUzdXblArdFUxYVJDenFBOG9EVU5NYXpsZ0R3RW5tcStNRFQ3SFNO?=
 =?iso-2022-jp?B?c1dVV2ZZVVovcXEyWkZCWndsdDltRkgraC8zRDRwWVE3c3ZaVGNqNFky?=
 =?iso-2022-jp?B?bVlqVnp5NlJtVWNFNTcrMmxFVW5KenliSGJFSDkreG11MlY0RGRpSTJs?=
 =?iso-2022-jp?B?c1d3RUZrcVJxaldIMEloRjVubFZKMFQrdXpwTllKZFBrSmlSRU9zbzFw?=
 =?iso-2022-jp?B?TytYN01wSzZ0aWpvYml0bVR0OXVVejE4bk9veTI2Q3BkUHdpUUM4L0g2?=
 =?iso-2022-jp?B?cExzMDlsQWNOQ2htOEpmNFcxUlVReDBiVDVkS0w5ZDVXQ1J5SmNTVmda?=
 =?iso-2022-jp?B?MVhsSW1rNzZ1Kzk3MGpuSmg1cDhLRGxWTjVwQjl6NXFDeWU4cDh0L25z?=
 =?iso-2022-jp?B?cS81SnFkYUNYcjBuUVZJczBiZjZEdXRwdlRmZXVsU05ETDI0a0Z2Rm1q?=
 =?iso-2022-jp?B?SUpBV2dRallQYjRwc0g3QlYxRC95NndubmJ3cHR1VUdmYUdFWjhTVDFn?=
 =?iso-2022-jp?B?Q1lQaVgxVE56T3BZUEZBelJxbG1pVjd0UzZoV2VZcTlJQlBSQVVDMC9k?=
 =?iso-2022-jp?B?VjM0QUhxQlpXMnlnVzcveTZqam5zQll4RlVnS0oyZGxqa0JSYmlCZmts?=
 =?iso-2022-jp?B?ZkpLMnFmM01LRUZxMkIvbUJLazNTV3VIRFhzTmtXeUlHaEMybVNZUmpI?=
 =?iso-2022-jp?B?MzU3akxMeW14aVdOWGt0c0g4VDh2bG5GSnMrcTBaTXNHVWdqbmF4dnNj?=
 =?iso-2022-jp?B?UFE4QVFZZk1WTUpIdE9HZCt3bXFkaXhGNDdjUXd0RHlOK0ZmbXdvK0Vv?=
 =?iso-2022-jp?B?SCtaRXVPQXpiY3IvRndzckdJWlZweW1IbXVxMWRXUlQvR0VvNnhPN1kr?=
 =?iso-2022-jp?B?VDV2QUJyd3RwWE14OUxnenoveUpsTkJseDloWXFUY3FjcFpRQ29EdXhK?=
 =?iso-2022-jp?B?V0RhUVNuV0J2bHJqcEVocitRWVkvL05QckFIdWgwaXhkRmZodWQ3Zm5u?=
 =?iso-2022-jp?B?ekttLzl2dDlMem1HT3ozRUlXbFpZdjdWaWVlSy9HMlRiMTJRN3pzd3JK?=
 =?iso-2022-jp?B?cjBBT0NBam5OWXk5YmY5eFZjZXgwWEhJVnlKSStFOXZQcytwSnh6ZDEy?=
 =?iso-2022-jp?B?TGJNWFV6NEwyeUIyMzBwU0d6MkJqSUs1K0RXSU1oRThPdXRDNWFBSXR1?=
 =?iso-2022-jp?B?TDBJK0N5L3YrbEZKRWwxRGJoVG1DbGwzVE9rdWEyU3FnY1NOZnNmWEZY?=
 =?iso-2022-jp?B?R0xsK0VmWktkY2k0QlR4Vm14aGFtdUZ5SXlEZTBrdW9leXEyc2lUSFVY?=
 =?iso-2022-jp?B?UDd1ZjR3K2JLL0JlMVNOdFhPcTdYYVRwVmVPeHJTZGlMemlYQkZuRGNX?=
 =?iso-2022-jp?B?c29jWkVFUkoyZmM3UHBNVjg4K2ZMZk02dXFzV1EwWXlGRXN6SEtFaTVp?=
 =?iso-2022-jp?B?c0RVbFpYUmlkNVpuRi95TGp3dE5CRUd2ZmxqM0w3R2lVWkZROGFPeC8x?=
 =?iso-2022-jp?B?R1FaSnhHM0VrKzRHOGZncFkxeGp1NnBTU0dEMkpaamZXR0JXM0JQNlhL?=
 =?iso-2022-jp?B?WUlSRUpjZEpQVDBGcCtLaGhRczY5YkVBOHJjNjk0STYxK2dUVGZBeGtV?=
 =?iso-2022-jp?B?U1RreUlIVGpiVnRlN0Rhd1BkMGUwRWdW?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(14052099004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VHNmYVViK1JXUkdCVWphZk42RHB0Y1hERzk3Z3FteHpkQm9WcjhCQUl4?=
 =?iso-2022-jp?B?VWJmYjNLZzJ0VC8vRjBJVVJjejFiTHRaVE1XNlYySy9DNVBtdFhGSUEz?=
 =?iso-2022-jp?B?QnZJT0ExRC9wTVlBZ1NmQzN0emQ3SUtwMTExRW1uU3R2RlJUeGppcGlS?=
 =?iso-2022-jp?B?N1diTEVac1pXc3BPa2ZRRkV5U0QxckVxUXFGY3lKTk50eCtsb1d5L1Rr?=
 =?iso-2022-jp?B?UUpqODNiZC9oNEQ2SUthaGNVSU4zM01iT3hjR3RCb2NRQzhoNVhDclkx?=
 =?iso-2022-jp?B?SWtVVWZVY2RkYkhydDdRd1FIVWg0eE4yT0srZG9DTkhJTlg2UC94TGlC?=
 =?iso-2022-jp?B?TmdmMyt5UEo0MTMybFZWTHFFTXRpNXhucXpJVFBTek95SW1Ka0o2VHlG?=
 =?iso-2022-jp?B?RXhzeGx1aWdHU2U5eENYNDd6TUc2M1B4Z3pxNExra0VxR2U3ZGwrL245?=
 =?iso-2022-jp?B?cDVXWmswcVlqUE5IUHcwTUdwRjB2N1R1ZjBndURFRE5yMlltV3d3ODFw?=
 =?iso-2022-jp?B?b1ZhT3RkNkZ0LzY2QW16eVNYeGNjTHJRTGJqWmp6RGh4Z1JoRDYwMzh6?=
 =?iso-2022-jp?B?NFExK0tIcDRtbVp1K2xZVVF0dXREWkttVTJ5SkdDRFdDKzc5Q0lTZTE4?=
 =?iso-2022-jp?B?S1d2VU5xeURDVzdPOHpzcDBSM1o4RTF4cHZmeVBHT0hSMG1pMEdPdDJo?=
 =?iso-2022-jp?B?TERDNHk3bVhtSmgvVFJUc3JhRnNwWlpPWStWUWsxN2RkcXlaRlkvdlZn?=
 =?iso-2022-jp?B?aDdBVmtRZ05FL2ExQTgzcmhIYW9tNmRMbHg5clBJbGdSUXhEaUZWU21N?=
 =?iso-2022-jp?B?MFZIdkZNZ1VoQ3ZyQi9mbGFYWjNNK2RjYXhnaDltTTRrVHluYW9UbFFh?=
 =?iso-2022-jp?B?REJablh1dmVXZ05QS0Q3UUVkNU9SVkFOYTNuM3RjZ1RGVUtNVDFmWlA0?=
 =?iso-2022-jp?B?SHRmQ0hVdVREYTdwL05CK2tOQkhtQXN5QUMwenJERG0xMFJiRFdVYlBT?=
 =?iso-2022-jp?B?a1NudlJoV1dMTCs3eVZkak9FUjlST1JyRFNyL2MzdUc0RHBkWFEyREMw?=
 =?iso-2022-jp?B?TFFINmdvcU9EYUIxZHdoOVE1NXY5Q0Q3WDU2K09BeVQySnVLNlo3U0xV?=
 =?iso-2022-jp?B?VTNmU3B2eU5DNnhYSXlDekZFZEJBelJnRjlQZnV4SHhnY00rYjhzMlpl?=
 =?iso-2022-jp?B?aldacXhobFVOd2t6aHVST3Q5b0wvZEVPaUg1M2FZb3IzVVFBOUpScUZm?=
 =?iso-2022-jp?B?NDNMcCtnQ1lMOTVLenRKQXZlVEZpLzBTYmFFSWRiempjVHIrd2diSEJj?=
 =?iso-2022-jp?B?bU1JQUJ3V2lxSnZqL2MrQTNwWEFjV0pzUzdmSWZnUno4YmpXTTdhMXox?=
 =?iso-2022-jp?B?M3prMGJkbTVSZFhKYzBYYTJWWlZ1RDFBb2ZGanFMWXBVd3ErVUFwQjd0?=
 =?iso-2022-jp?B?VzNkK2lNR2pVNUY4QUU5OUJPa2d2Y2g1bVUveFJuOWROdmZsQkpMOEN5?=
 =?iso-2022-jp?B?SnhtdFBZYXJNYjZXRUZXK2haN3JsSDJSa2RBcGV5cjRJaXVGckpCcktV?=
 =?iso-2022-jp?B?UkxmNUxxbXZWY09laHRIQ0xWZ0h4ZXFNQkdHTDhNSGVXWWVLbU5mbTlF?=
 =?iso-2022-jp?B?cnVHOVZLekxENzZBM3JROTg3NTNIbXFUc0dvRHozUmwvbGNreHFMaTN4?=
 =?iso-2022-jp?B?eml6K0M3U01kaThjVElNV1ZISjZ4ZWRoaUQ3dGNrWWlETzNpcXJ1SllK?=
 =?iso-2022-jp?B?bXZMM0lRMFlNeDgvYkVvOUQrVVlxVFV5YklqVFF5b1pXT21oajB5NS9u?=
 =?iso-2022-jp?B?by9OZHdQRUVKQ0s4M2R1M0NFS1d5OE1ZWlhCQWkyOTg0aGNpaDYvZDlY?=
 =?iso-2022-jp?B?VUlrOXlUOEgxQWpvaWZvN3FTbmdZL2N4bjR2ZU1MdE8zSHVJQ1hxZVVH?=
 =?iso-2022-jp?B?Mm9odlRQZjNtVm1lUWtScXN5WXVwVlNBbDRMZmJOQUFjclFzODl0RzdG?=
 =?iso-2022-jp?B?WDBTRHdOMGE5bnViSk8vTDdZZE1JbFpLT1o3L0NOMXR4Mmo1c1NlK3R3?=
 =?iso-2022-jp?B?TlhMMzBUYjVJMktnVHMrZ0xJczc1WFhYWUlBWDhyLzgvSEc1SlU4RXhk?=
 =?iso-2022-jp?B?eWJsYThmWTNuMWoweEFxN1g5U05McEtMWHA1K0UrN2dyK3V0NVNDK0lN?=
 =?iso-2022-jp?B?SEJSOFBQamxkaXZuT2ZBOWEwZmZUV2lPWjg4bGw3R2dtSWVpalJ6dmdH?=
 =?iso-2022-jp?B?Kyt3QnorU05NdmN4MXZHNHhGT2JKSENXb2N3R3BBREZjemZRQUxXRi9B?=
 =?iso-2022-jp?B?cDU4aEgzT0JXNDQreEFBeTZ6QjRPUDQ5dFRvbFhWSU9URmZIY1NKRWND?=
 =?iso-2022-jp?B?eTZlbUY4aUNkNjBwMzJOQmdWNTk1dWJxeS9UVEFKSXB5RzJqbEF5YlFF?=
 =?iso-2022-jp?B?cEFRT2RPRjNDZTF0b2Y1eWJ1ODJsdkJ6S29PL2tUU2VZVWp6MU51eC95?=
 =?iso-2022-jp?B?UjI3cGVWSTFFaFRIbE5odTd6QzBNTTZoMUR5VEZqOWR5Qkc1YWEvc0Zz?=
 =?iso-2022-jp?B?MDdYdFdHVT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d89ec6-e1ea-4d7d-5511-08de4e59b833
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 02:00:38.2110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HtKLJf3viB70cq92KE3zyve17WHzk7cDO1lIIdsyYP1VMnNJciXWeAOjsdn4xeEIQCy+Mh+65olHfFVHnDOOJHUDP7WTsGJghEAIaRV/Vn/6KVF94mXuxvBMgpr/0Qd8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8813
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 02:01:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21424

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Wednesday, January 7, 2026 10:57 PM
> To: Biju <biju.das.au@gmail.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C=1B(B
> =1B$B#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Biju Das
> <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [PATCH 6.12.y-cip v2 00/24] Add suspend/resume support for
> RZ/G3E CANFD
>=20
> Hi!
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Add suspend/resume support for RZ/G3E CANFD. On RZ/G3E using PSCI,
> > s2ram powers down the SoC. After resume, reinitialize the hardware for
> > CANFD operations. All the patches in this series are cherry picked
> > from mainline.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20

Looks OK to me, too.
I applied this with Pavel's reviewed-by tag.

> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


