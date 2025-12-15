Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DEBD59D99
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 09:45:53 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.26])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44798.1765791946544387383
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 01:45:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=gdVG+IZE;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.26, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxlxtiZ/Ljjv8rOF+uiD5vOwKPeNnnalo+2E0OiZK7a6A4ol3Gc4dnHMp0Rl+6AuzzraU1z1/YmQF6hsTz+RfPGP0JybBJMPcmrzmA7fmrE7RHLkC/al3qegSJc8wyprAr2Y12zyQkH2Ym5135cqf9dVue/fGqluVUVIIBCX327V1jA9pr91jAtwM0SIKUgNoIsJncGtROQ9bEEykmUjrv44cUOALRUpncsKPTCCHaXaRvQF0ByY4ZCQiQl3Z5MCR95vx2SSrCtdpYodxAChs/iw4SguBaZpUxYUzLLQP/nWpKUmNCTBJj+WJxkmSLT+ZcZLqDm+Nf5kRNhB3t00Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLu/eey++SMHW6a6R4WwwfF39o/5Hk2/Wd0gf6JH/rM=;
 b=jN9r+XP5PBjvQURTf7glNv63Yid8SEwRPSMyxRD+onQwU/WTadp0hpyLLQompygrOq3YppLY1mTnOekB7t0ZHDC4UAUwDaSRnQ5lZPhxaJOhfIsPHwq5nMrKiEWbR5OozUAjaaT1mTh7WgKPkZ7aYU23R7p9Vte0cQg3+eyawM2mhuF+Qtb6NitDyGRQa2cFtuLSX9uztm4CMueOlDiQ61y8OPRB+hua9Dimw272/27b5lJ+d/5sEOQc6YX4TFJwUWUMdAu2cwfmHsnIsO1vY2tzOEBtVznGdFHa97GmKpiRkTy5ONjLbR57VNz6iOu6JAsVN/OpvdA1Vk/eK7Oatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLu/eey++SMHW6a6R4WwwfF39o/5Hk2/Wd0gf6JH/rM=;
 b=gdVG+IZEOZNy5igeii/BBV0qPdlC3iSVoO6/R0RaNHxogijlvaxzUNJNMg6BLaqNJF7vSuxCtvjy5uefEwB8UrCBphz33hMbt1/s0D0ly/T6sTt3VFwfh2wvf1eMhqfVT0a6P5aAcmq+AhyWHc5llYhif4Jo5WFho2ZhwmxGVTA=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11729.jpnprd01.prod.outlook.com (2603:1096:604:242::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Mon, 15 Dec
 2025 09:45:42 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9434.001; Mon, 15 Dec 2025
 09:45:42 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip] net: stmmac: dwmac-renesas-gbeth: Add PM
 suspend/resume callbacks
Thread-Topic: [PATCH 6.12.y-cip] net: stmmac: dwmac-renesas-gbeth: Add PM
 suspend/resume callbacks
Thread-Index: AQHcbPGj7HDUQTMfQkWyYBYJE7QAbbUidTtg
Date: Mon, 15 Dec 2025 09:45:42 +0000
Message-ID: 
 <TY3PR01MB1134604BDB9B8CBD0A39ABA0886ADA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251214120313.3924-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251214120313.3924-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11729:EE_
x-ms-office365-filtering-correlation-id: 6d47fa7b-b1f1-4620-09cf-08de3bbeb660
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?LDe3my6V7qk13kBXH2YYGIxec+imaI6mwRYjJqfKPda+z1zpLcrIMCPebpsX?=
 =?us-ascii?Q?2SiF46dle+KVaH1tc+XAbom/yL20hsqdRtV9ggDebK7Xq3nEfAACP1zGm99f?=
 =?us-ascii?Q?J27FE7OKwQ2+KJcQX1K5rYILL9DrtVzY8DKE34S4BVXdHoSAW1Xq7PAKIR9q?=
 =?us-ascii?Q?ikEWXL2XZoBx5Spz0vDTZ+XB+A2WGniJ3Pnd3etys3ainI5KJs+4aoRahTsw?=
 =?us-ascii?Q?e2F0cvzOjm/FXUpymMtgk//TR3LN/gL3XNrwAdSQi+yw5bwT3uYgnouXJgU5?=
 =?us-ascii?Q?CK2Tx87evxEcMSoBfViOzJS6ns91HNv5BKr7FL5Pgs1YwL7dFh38Nf4pbrfy?=
 =?us-ascii?Q?JEx63Dxzg4op2TVFb1YlV8b+SM10pTY8brVpCFNsbKuQb6aVql66IzU5fBWL?=
 =?us-ascii?Q?iKKaVXHXfHt1AaHUGoH49pZBmWNfIOWnRfO+9gYs/08DWbY9YfP+W/henXKD?=
 =?us-ascii?Q?1ulmtsY7FvEhIgfsCnfeesBKqoAcY5WzL0DOWW5WlGFlHZOrqDoTgImpwlzf?=
 =?us-ascii?Q?JmHGJLi9zbHNglCE98DSP6a8eY4o6ViV+UR1j9Oihhzo9SYHG6S5J7IHi0G9?=
 =?us-ascii?Q?X5VxEtoKRi0GrIRE9/T5UvjK9IYBGLtVBf0BoQg/G+xI95cGKnM7LIGINOp7?=
 =?us-ascii?Q?nYGEbOQXhw5C7sXJV5h84AkdB7A7nrFN8zqqJXPcKrnnJ3tXDBpPcdvb5mzs?=
 =?us-ascii?Q?7vRdkvlnJWyAWo252IbsT3/Zp0fqAmSiQTRgMGFmGt0KXCDwhYYMxkDslenM?=
 =?us-ascii?Q?YNP8HPq2RZG9yOaRrMVxddmPLjDhuViz9s4gHzipRDbTG0GEu+moG9GQqfzg?=
 =?us-ascii?Q?VW3vd+pP/BNnmCnwI0acuoSLBiDJiSjkSkRsKdH+Bj54uYfY8QOnwBIJnBnR?=
 =?us-ascii?Q?P4Wivr3woOJPqhqGeIO+xXrahrA7+PFZG5H6c/zE8SITvX9fAsDuqQnDf55i?=
 =?us-ascii?Q?d+McNG5sJAf+pik/SKmcckbQPxdQCDgFSLxKMgbFTWGurZMg8C1jbVf5J7Uf?=
 =?us-ascii?Q?Ov/I1yS2JK2R19rwqtM5NgkN7AK6iGycjwcXbogz0BN0iI3VnEbeQAwx+AdC?=
 =?us-ascii?Q?rv9wWyGezkYK1j+ZCSoeg2oOtCTyf+RMp44cUKVt15taI6txgLvI8K7GdDCD?=
 =?us-ascii?Q?NQSQv0t1Eyewc7w/IlJB7rt/SNXjvl9fSh134WAbBNY231hGqQyoNFNI9HzC?=
 =?us-ascii?Q?e3Fttsy1LPmMTF/c8gzpNB4cKqbvMrcf5XQb/2Sbr2C+zZVG3EBQNnkx84A7?=
 =?us-ascii?Q?2uEPyI66hTKwpLQzQZFt4Aowx4m7V1M77MYiCwx0WgXXvnUNXdzXa30sYJK3?=
 =?us-ascii?Q?Yi6qfGyxFp8wkcTntMYcbG1+spd4BbcDvNt56ingjoiaECGd3jWwOl3rXrdO?=
 =?us-ascii?Q?v7CJk9MyjzOH/JhKhycJf7XgOd5K3sKt5IBIQKYqkotPFXwVkUiuOYZpMGym?=
 =?us-ascii?Q?SI1xRjvgPk84I6S11Xrg3BsSFE/ze1ziDeIJ4c9tRwOrs7PGr4rEvA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?GWk4rEl5QZ8x7QmuoZikDIISorwUYupj5IdDyLX3b+yXFgw2zzJfhvhSWw8f?=
 =?us-ascii?Q?EVEgNa7dAj2SJZoce5xQ02rXHJ13hAQKVLGES1t9JsoTduLGvHj12Sgz6QPJ?=
 =?us-ascii?Q?4fyS4if2cCdNhuISNuP5u6D4cPojw1gSpBUysCMBSxUYJxY6G6hh0OF32bNa?=
 =?us-ascii?Q?JEj7hVOk+MNxFMhHWiyCfW/2H7wxOecjFnmINmh3zPKSO3FPGT33Ngr9zSBb?=
 =?us-ascii?Q?hUgJiKm3i3ikiJcxi3jADQnhDYvU/Kmv73iLLH+hATvhNEn/uY2pRpAhSLdP?=
 =?us-ascii?Q?nCXXvHCSOY0bUS8RNwESjV0nOUUH+/8/xH3E6ZuTaaEEKvEomBEp9fcY/Pq/?=
 =?us-ascii?Q?ckawBHO1CZw/xJ3IO8xtUQnQU6kToVJmS9aVg4DDOfoRUFrlUMGP5NFktZMa?=
 =?us-ascii?Q?lHSOEAeLmhGBe1NtCdUhVYxknkdSWk3nKDcMZX4Xwl9TJNxQDLza7DGL2keE?=
 =?us-ascii?Q?9CQxD7uRaKZUNffwQJkaHdVBCMS4sK7gVYy1Nn0RTc1KIlsslda+R4+mmwfX?=
 =?us-ascii?Q?2FRRBOKnFqeRnqOS6WKJihfWya/VyIm3zwRGZAWrM9UeL4pvLsfT55HvAZBJ?=
 =?us-ascii?Q?VL8zpjAzQPDLS1P9Q1CA1JhkLE2x7U6R2FSifUuGYH0r6hfYHvQkKosVmZRI?=
 =?us-ascii?Q?yC/yha66I9aHykgKUq/YilKbyWYnRSAFxbxEt3uPNiG1RA/Ng0wxjEsSe/is?=
 =?us-ascii?Q?joylUjhbDXN8H0qW/f9cjEjcIgYq45h3abifOcCe7fgKNAqmvyXboFiitqGZ?=
 =?us-ascii?Q?rNARsCYfMOqNFDiKYUIdORIizM+NaSIHVZPa3yjvGKJCDTxqWUbv1xnQQPen?=
 =?us-ascii?Q?70pL4+s1tFUZXXHj1urZRTgASkW8cE0QKMFhgTtHfJChteiK5PUalY+mLa+t?=
 =?us-ascii?Q?dwkS8eFm2JhwGT2HbIkNOmykNo5ca/2sHXgl9J/b/w1VL6JR/6nah3QHfQ/f?=
 =?us-ascii?Q?u2YP0lV4bagYJDEHP3nsgDCCPb0aa4kCDtuvrVc4jsHOmVZLkVDOrJyuj18s?=
 =?us-ascii?Q?yV5E43zlWR95Fz5sa0NImzR/+sv+kojeB9kg3VJMsTO8Z95K/zXEWSDD+5Eo?=
 =?us-ascii?Q?yJ1xgkpjwGc4jANpYZjNw1K0JLQsyNdoatFjdaYn3b1iEhgcUDg40j5lYoD6?=
 =?us-ascii?Q?w/d8jDBXGSN4dqoQO46WblkR90Y8pHkIqnvKmtPybDyIRuaLdYESSiWoMfRk?=
 =?us-ascii?Q?Nimca3fwmhi+uiAXBhXTadHmxqqj6v/r2oYus8nxMVk6NPQc0ryUfpxN6Ip4?=
 =?us-ascii?Q?2YS7uHhlEi+WjCJ5b4yWfEHxTcuQQfa0gPxLw+iIZPXL7UgM7ACj3mEfnJYq?=
 =?us-ascii?Q?d23N7itAlLedFULg1Lr+o/49KMtzCbIqny39Ax17IE4ErEru65erw/eJA8ED?=
 =?us-ascii?Q?aUzYLqv8MtDsZlPi5dSqCpWWCwIu4AVdPpNyP8RtNEnpaale5YHxQpK3C6i2?=
 =?us-ascii?Q?ZDX1oA+OshmmkVNGYn56o9zMB+n4v/gwTyl2fvViHR0KGTdUNDHN81AAluA8?=
 =?us-ascii?Q?gj3b3d70ALeD/VMkFgNvUJbYAURPv45HQtIfvRbvb6S0qXMh6vJ8ofWzvqqs?=
 =?us-ascii?Q?6ELcsvKUJIdAo4XsHf0RamIOwMX8m7NobtZHlI1DSsbVEkH/zxDGR1I8BTZ1?=
 =?us-ascii?Q?qA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d47fa7b-b1f1-4620-09cf-08de3bbeb660
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 09:45:42.2742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IKQe61Q3C4eu3StYpQ80kFOD5ilGFTN+F8YN6cYveSXAQ1as4xaiVTmEBJB5X5otcw98MYmAwWLK/7ecS5OU3Uvwlb3Fsm61TAtjL+dFKBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11729
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 09:45:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21040

+cc=20
nobuhiro.iwamatsu.x90@mail.toshiba as Nobuhiro Iwamatsu <nobuhiro1.iwamatsu=
@toshiba.co.jp>
bouncing.

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 14 December 2025 12:03
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhak=
ar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: [PATCH 6.12.y-cip] net: stmmac: dwmac-renesas-gbeth: Add PM susp=
end/resume callbacks
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> [ Upstream commit 72b4612af36fec844857415f14fd07126dc4499a ]
>=20
> Add PM suspend/resume callbacks for RZ/G3E SMARC EVK.
>=20
> The PM deep entry is executed by pressing the SLEEP button and exit from =
entry is by pressing the
> power button.
>=20
> Logs:
> root@smarc-rzg3e:~# PM: suspend entry (deep) Filesystems sync: 0.115 seco=
nds Freezing user space
> processes Freezing user space processes completed (elapsed 0.002 seconds)=
 OOM killer disabled.
> Freezing remaining freezable tasks
> Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> printk: Suspending console(s) (use no_console_suspend to debug)
> NOTICE:  BL2: v2.10.5(release):2.10.5/rz_soc_dev-162-g7148ba838
> NOTICE:  BL2: Built : 14:23:58, Jul  5 2025
> NOTICE:  BL2: SYS_LSI_MODE: 0x13e06
> NOTICE:  BL2: SYS_LSI_DEVID: 0x8679447
> NOTICE:  BL2: SYS_LSI_PRR: 0x0
> NOTICE:  BL2: Booting BL31
> renesas-gbeth 15c30000.ethernet end0: Link is Down Disabling non-boot CPU=
s ...
> psci: CPU3 killed (polled 0 ms)
> psci: CPU2 killed (polled 0 ms)
> psci: CPU1 killed (polled 0 ms)
> Enabling non-boot CPUs ...
> Detected VIPT I-cache on CPU1
> GICv3: CPU1: found redistributor 100 region 0:0x0000000014960000
> CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
> CPU1 is up
> Detected VIPT I-cache on CPU2
> GICv3: CPU2: found redistributor 200 region 0:0x0000000014980000
> CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
> CPU2 is up
> Detected VIPT I-cache on CPU3
> GICv3: CPU3: found redistributor 300 region 0:0x00000000149a0000
> CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
> CPU3 is up
> dwmac4: Master AXI performs fixed burst length 15c30000.ethernet end0: No=
 Safety Features support
> found 15c30000.ethernet end0: IEEE 1588-2008 Advanced Timestamp supported=
 15c30000.ethernet end0:
> configuring for phy/rgmii-id link mode
> dwmac4: Master AXI performs fixed burst length 15c40000.ethernet end1: No=
 Safety Features support
> found 15c40000.ethernet end1: IEEE 1588-2008 Advanced Timestamp supported=
 15c40000.ethernet end1:
> configuring for phy/rgmii-id link mode OOM killer enabled.
> Restarting tasks: Starting
> Restarting tasks: Done
> random: crng reseeded on system resumption
> PM: suspend exit
>=20
> 15c30000.ethernet end0: Link is Up - 1Gbps/Full - flow control rx/tx root=
@smarc-rzg3e:~# ifconfig end0
> 192.168.10.7 up root@smarc-rzg3e:~# ping 192.168.10.1 PING 192.168.10.1 (=
192.168.10.1) 56(84) bytes of
> data.
> 64 bytes from 192.168.10.1: icmp_seq=3D1 ttl=3D64 time=3D2.05 ms
> 64 bytes from 192.168.10.1: icmp_seq=3D2 ttl=3D64 time=3D0.928 ms
>=20
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Link: https://patch.msgid.link/20250717071109.8213-1-biju.das.jz@bp.renes=
as.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> index 8bd554bf94f9..2f1ddaa2c6e4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> @@ -136,6 +136,7 @@ static struct platform_driver renesas_gbeth_driver =
=3D {
>  	.probe  =3D renesas_gbeth_probe,
>  	.driver =3D {
>  		.name		=3D "renesas-gbeth",
> +		.pm		=3D &stmmac_pltfr_pm_ops,
>  		.of_match_table	=3D renesas_gbeth_match,
>  	},
>  };
> --
> 2.43.0


