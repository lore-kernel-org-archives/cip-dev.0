Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9712AFED2C3
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 03:28:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13657.1773286130962882911
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 20:28:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=hveVRcTJ;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1773286128;x=1774495728;bh=N4cgtnAuBrS4NUvWh7odsPFlocFNYYi9BiTon
	XcYje4=;b=hveVRcTJ3O2Vr6+N33TDpRNFQEx8GwTNzD+AOOdGO4dRD3stMbH8FAq6L85cdaYpgGV
	8cCZE7ichcKyppRBhDecAhKoMuoxz9ei6rMW1X7QsK14vf49esXLqFaux3rdxWUv9S9BdLomz6dTB
	CKh8mAd4SD++TM3VHenJbg27gYcIkG6AnuR/UZsRrRD1cCY0w2CoSYmosFZs/oafKmaxH4OL2BuOO
	74xVAV3In4mZZp9pRxnkM5YWYGg44wUMRSpdLiy1DvAU0W9wN1RfqX6WmWFsAqOYgCucDUfPF14u2
	XcjB+rqQ2RkGNknSwVqx6YW/lfUF2+HUyEVCRBlvE00w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 62C3SmRn2562835; Thu, 12 Mar 2026 12:28:48 +0900
X-Iguazu-Qid: 2rWgk9kdw5QEMkTp20
X-Iguazu-QSIG: v=2; s=0; t=1773286128; q=2rWgk9kdw5QEMkTp20; m=ulss0whDKXk7rVma8pQXvDbZ588rketQssBA7p4K3tk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fWY4H4czqz4vyh; Thu, 12 Mar 2026 12:28:47 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9ok/Fv4q0Gi5dC7RMLuNdJEto4Ptf1R8JFfLoyceHax3F5FuifnkVShu6UVvk4h6FO+ov8F7vWil4EglLAJxe3UHPrdwl1ZaZ2r+mGqN3oz9i6PcFZbvtC/OHUGaA7VJ+Wi8h8Nwdwcd603zeWlDvYGlLggmasJUEjjCmFhqK5pYn3a4Zy0ofZ8PWVU5svn5pwtiRbGAEwqdM+PDOwB3FjTq1G+POclfnICWgDaZFsktDs+E7xs19RsCmmFhQiDmmyIFJ07r7fz9ox5P78mMwbagX9Ynv+JjOCD5mnDmlwdKdDzt+KGUynajR2//uyQf3B4/2Jju6/xsUYD7+ekQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojZB5eFyd5TQ1ZwUMkbFoqjo/15XRPiRAVeYlECH2Cs=;
 b=vj/Zk+dCGMehL7UR7YTMC5WJ1O+q0jB52w7pAwnKADkwo5q742n7OH2m7vbdhFmKKaQZKs46I92wG0OePuZ1yjrBnaLTNqI5EyPKsgpVwB9SiQlW2SgXLoKNJ+0bfQIQe2GmZ4m44KRh8XLC59mFMqhfw83sbNlkPnulNawi6HDtDeXLC3ljGr7hORQhsTU3BRDv6ElXQKQvF7hVDNVOTEcizFRboLIuT6Jz4/hQPTLc1GeenYjaPOC/UQTq8Tq5v3xYJcIQ+Bzth/V8gV2bnL1Jh66qNl48r84521kLBOhwyKow9Q/1MEnUKQqpdym+eUKek3eJNt0SY7gYRFZh+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cosmin-gabriel.tanislav.xa@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
Subject: RE: [PATCH 6.12.y-cip v3 00/17] Add RSPI support for RZ/T2H and
 RZ/N2H
Thread-Topic: [PATCH 6.12.y-cip v3 00/17] Add RSPI support for RZ/T2H and
 RZ/N2H
Thread-Index: AQHcr9Zt8oT5m3eB9k60E04iS9TVQLWqP+QA
Date: Thu, 12 Mar 2026 03:28:41 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148182366C8AFD477E17F8097CD44A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260309150619.761962-1-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20260309150619.761962-1-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB13060:EE_
x-ms-office365-filtering-correlation-id: bbb7a54f-0705-4742-d08f-08de7fe77529
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|14052099004|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 
 Guf7wQ5jfx5f/DVFn10/b5STCA+aO9GTQ9Wd/zbs/p+5+4tIscoXQMR0qArQfYlSxtBoq3gWYIGxmZpIyn4zah13fzNIKKAFS69LlhqVc7guljmepmeyzFNPFFkMylJ/kX28jd/LCRqxGJ59F4bFlwD9RMowH/FgSHt3exUr0M7C1idmg8rXf/+kSOyykxPH6YUxFah4/aBW64LRXLLZXBmbMUwxD9SVuY/e7DzWNxDBaw71HQ2WzIC42ZYNpkvy5jCa7XnbeIppwuD2g5+GuXO3tClJhTohZ0NnVtoHR0zSpF+srVPVQERYMImTUCTbMMffG1JAl5kSmwXM39PewWAIfxY6HGpi6NQJ/LmZ9+l9GBJVZDUX6Td2Qk2dhsr1mDczIQ8MFDde8NoKuml7BUSlUtD7kKfN+RWZnsfyHRkRYQ6GgQceDJ0BXfEQJ4cEuAUAi5tm9zDF9Gp2Jio6VUgTAFNzFcQm/1L58LQ52eLSfEs7EkLAWLLBrJhSCH13b4oVW1XNNWZhjo0u9qkIHWc/J2lmM7XNM+aD+DF8wOK1CPzHdBkGXOxVc1r2u6GemRehDCIQ37Ro9YdZpazmI0e+Hl/AKqlUKGuJWJD9mgfPOaRqVtBgTAnTUKjeboYxDaXFBSaQDGgF3us3bBkRhygTlUfdo0vUiHJmC4pgS/Vdf9fI92XNwhuZkwRy/PI/ega+UhyE35snWQaM4xpD18TCnj5ibXfESy8ItyKY8OxU+XgmgD3hOVGhax87sBudvyj/lqcFCwgYXcTmTBf3hEHDRIt7lAn5dXdVgQClYlg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(14052099004)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZWNlZ2w2dkhLZnVVMVkzOEVHRlhuN1JwMEJEVlkvUU9BYUpDNVpTTXp4?=
 =?iso-2022-jp?B?aDByZHRITVluSXFHZWxIUXc4dDdxWHl1c2ZwZm9rR0RrYy84ZEp1VHBL?=
 =?iso-2022-jp?B?NXp1NXRMeTJUNkd3NjU1S0lOOFd0dnFJSi9tWlhzZ2FQbitiN1E0Ly9u?=
 =?iso-2022-jp?B?S2xLTy9SZ21zQWRTaGpQRUd2aVh1dXhWSFBDUFFzNGpCdlpzMnZSTitL?=
 =?iso-2022-jp?B?WXVyZTB6aGZycDFCakpWTlpGVWVxOHJjSWc4cTJEcVVXdXhzTkRQSGMv?=
 =?iso-2022-jp?B?cyt6YWVuWTZaNk9wdHdZaE5VdWQ3cVlxV0ovMXE5QWVVRTRqa3BlYlYy?=
 =?iso-2022-jp?B?WFptZ1I5UVR6QmZvUWdMa20ydStXLyt2RTNuZUhQQjFXaWFRbmFiNXdZ?=
 =?iso-2022-jp?B?d01CUDQyMUJXL0E5NktZQ0dBOWg5ZkRMSnEzRE1TUEVJL2h1VnlyZkt1?=
 =?iso-2022-jp?B?R1VQTzFySXNIdW5sR2tUMGxKRzl5ZEdvZVQ0UERBbGJNVWYxT2dpOXRw?=
 =?iso-2022-jp?B?RHFjWlpVeFJkRXF5V29YajA0UWhwbFBaRWdEcGRlRE5SalVJTDk2NUhZ?=
 =?iso-2022-jp?B?Z01ycngrWWFGSzBrazk0Wko3STk4R0s5a211TE9rb1owVllWWjZhK2VR?=
 =?iso-2022-jp?B?U3g2dHhlOUxYeFN0M3ZtNmZRR0NUUTd0ZmYvRHlwb0d6WXNOZTNPMGxJ?=
 =?iso-2022-jp?B?MDVPQzNDOWUwdFR4T0h4T2YrSFp0ZUs5SUxmZ0dkUmRtaG1yazZTb1dy?=
 =?iso-2022-jp?B?STVtMktqbGlSM1RtVXdWM0RNU1Zpd2U5ZDFxYzZYOXhPWFp3aUlpQ1oy?=
 =?iso-2022-jp?B?RmZjVmtVcHVRazFoTEtvQnZCd0pMUnUya0dzLzBJWHNmY1kzcXJHTVZI?=
 =?iso-2022-jp?B?UVY2NSttZ293L1d0dW1EbEVqdjJYTW9yYTZhTU55N05oL2s0K0s0V0dH?=
 =?iso-2022-jp?B?M0ZNRUswVUNIRGZ3WjQzbDBsVGNQOVJhVjB6a3BoK0w2ejBKUkZ6SDZG?=
 =?iso-2022-jp?B?UVBBSExPS3JYNFhadCtQWmpjUzN1OFRTNEtsaGFZYUREdmF6b2orOVMy?=
 =?iso-2022-jp?B?ekdmTHdxeFEvd1Y5REpHaXJpS0N3WDNMMUNtaklEQU9NNnpYSHZBeUps?=
 =?iso-2022-jp?B?bEdFSEd2UWNQVW5zaUhGUmVoNDVIcHgwVVZlaWtPd3E0ZStUTnJmRENU?=
 =?iso-2022-jp?B?L3kxZU9oaEVQL2l1ak1ReEhvaGlEU2JKN0kxYVl2eWpOMllaNHZ6TllE?=
 =?iso-2022-jp?B?UDFVQ3NCYWtIM2tPMFpGeWU5dTErZkpKcmVPRnJYM2JBMG5Pb2wwd2Fw?=
 =?iso-2022-jp?B?aFpZR2pGUGRLa1VPTzhMWTFqV1BIc2dXMVVyeXN3Y1ZIYjBZNUdjNWoz?=
 =?iso-2022-jp?B?aW5VZkRxMlRmWEtTSHloelMwOXNCL0xSRG1KcFRQQmx1VkRFRmlrQ0li?=
 =?iso-2022-jp?B?ZWZqM0xBZDQ2d0MzclFYeGVjSDg0dFVSTE8zNTE1TU93SitRM1JxTjRH?=
 =?iso-2022-jp?B?dTNkcjdGeFhQcXIxYVpxcFpvZ1V0UHowdTV4QjdOS095TkQzTHR2ajlm?=
 =?iso-2022-jp?B?a0cwR3BtMXFSUkFPUlVMNktGbjN4ZlFlM2Nydms2d3hPSExWV0s0YzhP?=
 =?iso-2022-jp?B?Zlp1M25lZVI1VUJiQk1FRTIvMzhYUUpXc084NW1DUGVwRUtEZGFKRVFS?=
 =?iso-2022-jp?B?WDNRTzVSTzdiOFNnZENvWElJcDVaZ3AwZXovdkdxU3R0QXBxaTAvVTRQ?=
 =?iso-2022-jp?B?SG81bis4eElMcVIrTUx6MFpraTRJbHkyUGx2UnR1K2ZOTUtibjNBdXMx?=
 =?iso-2022-jp?B?Y1NFRzc4QUtkTUd2Mlk4bkcrK2xWMThmL3VxTDUzdWIxdVIyUGtwbUhj?=
 =?iso-2022-jp?B?M29WUG1TbVFpc3VtKzhkSnJOTTd0UGk3Unk4bVIzNzdBYUdDSTQyLzR2?=
 =?iso-2022-jp?B?UHNIU0NlOVFtV2lxZ3p4VElyZTJkY3p6amFmdVFvQ08rYXhpN3dXUndC?=
 =?iso-2022-jp?B?aGRsOHlaK0JyZEV1STg4c05UUWdIanJXcU1VSUxCZVpxc25xQ2tmdEM5?=
 =?iso-2022-jp?B?dzBkY2JQOWMzM0NjWHFrWjlVTHc0VGhTVS9Pc0RBbmRaYVlwcDMzeklC?=
 =?iso-2022-jp?B?NFB1SnNUZzJrZnFUbm5MTUZ5TjVBbzNrbWFnV1ByeUgwMHRNTDd2WnFT?=
 =?iso-2022-jp?B?TnNqbE91bUs5UHhNNWRmYWJ2VTRNcGd4aEFZU1RRSUN5c3F2Mi9uTVpE?=
 =?iso-2022-jp?B?RmxsQmlXclZOeW91bG9IVjUyK0VCdVlSbTk5UUsvL3pYcEZyQWp4cnpD?=
 =?iso-2022-jp?B?dnU0eFlYOHBaRjlVc3N2SGUvckgzNGtVcmJxc21yUXJJclFxallwbTY4?=
 =?iso-2022-jp?B?emJuZUhJRDVzWlZGZllEL2lFajhRems3ZHU0Wm5wY0xMQjVId3JlbFA2?=
 =?iso-2022-jp?B?QWlhWGZoV2h5c1dmWUJiTVY4Y2NpY29jUUhmSXBVUUowRTNQYTFHcTVs?=
 =?iso-2022-jp?B?UmQxcWZ0cEhOWmZudVlUNzVoNndIUlZvSFFEczYrRHJ0OUpBNGF1SlFU?=
 =?iso-2022-jp?B?RHcxTEN5Yz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	cA4Gt4/iGd4moqhGmmu34R0JNBpccI65MQBDnKYyP25cWcI8ByuVY6l5+5hCkSKKvYF20f8Xin3zKhns85v9ClqV1BK1D8HVt9Ei0zH6wOvX9mol88ZR5eAHxcv241Hxzl34VIe98WoHVZKdhuiHJkBG9ahFx3Q/KbwN1QMCa0qOSBXGnPqHGKWV0NwLoDpUKJt6ziTEaVZWJYcp57hHleydH2zKhCSE95OcYybWmFnRQwapePcTF5APMeHr0HD5Le2sbC1pCMfyTUYUg3Oh7bL9vU2o/BnHOtoG4wKTLpO+iFAT/uT9uZrIlvDQqUHmeo9HZwwgHmY+AypqOmc6nA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb7a54f-0705-4742-d08f-08de7fe77529
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 03:28:41.2591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjzHdU9aGjKNP/GEuI1zrJxEcHTWWCVuSHKlg+PwLI5vTaMkwwDMmPJx21q8ikk0Di4T4GUrX/yw8us650cQEDrYJrtfsmEWqJS+j96/iGqJBUmW074G+IhIepFZ3EvU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13060
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 03:28:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22350

Hi all,

> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: Tuesday, March 10, 2026 12:06 AM
> To: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: [PATCH 6.12.y-cip v3 00/17] Add RSPI support for RZ/T2H and RZ/N=
2H
>=20
> This series adds RSPI support for the Renesas RZ/T2H (R9A09G077) and RZ/N=
2H (R9A09G087) SoCs.
>=20
> RZ/T2H and RZ/N2H support is implemented as part of the RZ/V2H RSPI drive=
r, and, as such, the RZ/V2H RSPI driver had
> to be backported.
>=20
> Patches were cherry-picked from upstream kernel.
>=20
> This series applies on top of my previously submitted series [1] (to avoi=
d a conflict in
> drivers/clk/renesas/r9a09g077-cpg.c mainly).
>=20
> [1]:
> https://patchwork.kernel.org/project/cip-dev/cover/20260303165351.914437-=
1-cosmin-gabriel.tanislav.xa@renesas.co
> m/
>=20
> V3:
>  * describe changes made to apply on top of CIP
>=20
> V2:
>  * remove internal Reviewed-by tags
>=20
> Cosmin Tanislav (14):
>   clk: renesas: r9a09g077: Add SPI module clocks
>   spi: rzv2h-rspi: make resets optional
>   spi: rzv2h-rspi: make FIFO size chip-specific
>   spi: rzv2h-rspi: make clocks chip-specific
>   spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
>   spi: rzv2h-rspi: avoid recomputing transfer frequency
>   spi: rzv2h-rspi: make transfer clock rate finding chip-specific
>   spi: rzv2h-rspi: add support for using PCLK for transfer clock
>   spi: rzv2h-rspi: add support for variable transfer clock
>   spi: rzv2h-rspi: add support for loopback mode
>   spi: rzv2h-rspi: add support for RZ/T2H and RZ/N2H
>   spi: dt-bindings: renesas,rzv2h-rspi: document RZ/T2H and RZ/N2H
>   arm64: dts: renesas: r9a09g077: Add SPI nodes
>   arm64: dts: renesas: r9a09g087: Add SPI nodes
>=20
> Fabrizio Castro (3):
>   spi: dt-bindings: Document the RZ/V2H(P) RSPI
>   spi: Add driver for the RZ/V2H(P) RSPI IP
>   arm64: defconfig: Enable the RZ/V2H(P) RSPI driver
>=20
>  .../bindings/spi/renesas,rzv2h-rspi.yaml      | 138 ++++
>  arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  72 ++
>  arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  72 ++
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/clk/renesas/r9a09g077-cpg.c           |  22 +-
>  drivers/spi/Kconfig                           |   8 +
>  drivers/spi/Makefile                          |   1 +
>  drivers/spi/spi-rzv2h-rspi.c                  | 687 ++++++++++++++++++
>  8 files changed, 1000 insertions(+), 1 deletion(-)  create mode 100644
> Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
>  create mode 100644 drivers/spi/spi-rzv2h-rspi.c
>=20

I reviewed this series, looks good to me.
I can apply if tests are OK and there are no other comments.
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/238000661=
4

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


