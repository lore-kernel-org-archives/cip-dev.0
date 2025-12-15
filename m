Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82642D59D99
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 09:45:23 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.5])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44794.1765791915930052703
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 01:45:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=QHJ4QH4B;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.5, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDI4ZVKqaXmrNwqxJEsrPNalqFodpcrXx1pt/GKZz3svK9krOPsEnE0ypoHq80elcQqCmrtanZoW3TeUhH6SXB8GVtqhA5ybCBSuMtVbLhcHmRT+7linSf2uHF8nR40qLT3YfZ0tGlRmeZybZNK9oeceEfOmHQwIvKw8D5mM7DVlp5PXM4rLoegg0lNf6KVkxLAmcouVvJviLXrjK0gpJJq56yU4VFGm/TJqZjvoQ156Xres8i48Ct9RXLOZxWNcfwKZBrEmqwJqyzaQrSKMnRompl0UyluECCdKATgrvRl6rSkZ6CHYctp8ensOoYSWaSOcAL9dklElUDnU3GniQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeJPjNr6gczBUOwN7FcOzrQ5irOJ0GDKxxZrHpSSWZQ=;
 b=uxFSPiOX3YPQmmM86pZEm+Rt+kqNV4JEewkXvgVx2p1jYxNNBVCkmm748zR/hIoySdpW52CWKqUPCMcT/hKb5+XVoENymTepODYCVWPs9LrQg9LjEf4t+sp8reed1Q2tUxoXwiFUPWjDeOS2Xb421nnjjigBB7K+/Crg0F/5k5jAlkbpohGSTQ4mcxMVT/oXIsYbRpDX3vXm9Ye0PtQzHmm9iWC7P9XB5cvb13XqFRjSirxjmOfSvtm/ReWWmmJfEH/0EkxqEnsH/dRxaEfUbrvJL+gnvnn4VxlQvRpmfxzStAB5WBvklDzll4A5wSnpR4P3gz0GdB24zXjqbFUjLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeJPjNr6gczBUOwN7FcOzrQ5irOJ0GDKxxZrHpSSWZQ=;
 b=QHJ4QH4Bc54yKpX8x1DuxswjmCmNfOSNe9edd2VS3dQbR5Cxfa8M7lmwt9OZf1c9xa5aFRXN7vNkS9qa+Fr/ikBqCDjZiv3J3Si0Rve/MmpT4Kidb7fRMUOYGNw+Gk++/iGl8JBxMBg7l8G02BVSrTpaiyrSa5XJuahnZoiPk4o=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB11283.jpnprd01.prod.outlook.com (2603:1096:400:36e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Mon, 15 Dec
 2025 09:45:11 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9434.001; Mon, 15 Dec 2025
 09:45:11 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 3/3] net: stmmac: dwmac-renesas-gbeth: Add PM
 suspend/resume callbacks
Thread-Topic: [PATCH 6.1.y-cip 3/3] net: stmmac: dwmac-renesas-gbeth: Add PM
 suspend/resume callbacks
Thread-Index: AQHcbPFh/l7RFXMbsUWb6FQjv0vWV7UidRVw
Date: Mon, 15 Dec 2025 09:45:11 +0000
Message-ID: 
 <TY3PR01MB11346D5D98B7E8EF45CB992C386ADA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251214120122.3784-1-biju.das.jz@bp.renesas.com>
 <20251214120122.3784-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251214120122.3784-4-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB11283:EE_
x-ms-office365-filtering-correlation-id: 66843b19-044c-4a7d-4b3f-08de3bbea424
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?zO54RtpFbbeVHZkg8sE3Ox8fQFasPKvvXeOEn4cjdtK7WBMqJhPVRhayxqiv?=
 =?us-ascii?Q?e5pstzowtWFW5easiHr8hDvJwq93rJpdKcGVhQI8KVkEhECWgdyM9xCrnqIv?=
 =?us-ascii?Q?Xgj/7FEhSEAcSZY62A3LQ9j5q6b+EM/KJlRxpuJ9srcWTYRgiH5RYwHd6P/r?=
 =?us-ascii?Q?hTp5w71dijUUuhhbLcTKO5cEjVDHkEfLGDy4Mxn4IU4QhLSEjlU2HIMSpFo3?=
 =?us-ascii?Q?YruPWoC93nG8O+7xYpwLnRbu0uL4jDQtb0qbZgDrYTishRIwOgEZK35lTk+V?=
 =?us-ascii?Q?m3bxN+a0WeOdWP40rHXQ4hjZJKnXSbj3EFw2rMUvUkEyUsDcypdemiNIyWGu?=
 =?us-ascii?Q?1lWE8n6VGhH/ioAy9J2wM+jZXV67dLelX5Ve7HDFl9L3+kPEK7W5zePZEx2V?=
 =?us-ascii?Q?mprreBywIgdaaJOvzf8LD4aKIdwBqeSc3VpjjGU9oGGD1+TClPRCqIhV6H/G?=
 =?us-ascii?Q?+pXiY0+/5wSYbPXZyBPCQDt9AX7DTy6D4btYDIRqFxuR4Y6f4MRleeby9qtb?=
 =?us-ascii?Q?YFpD7N77a3xuTVP2sfugr1rPrxAonAX4V7Oty3R5TBcyd3l7FeWU470y53ik?=
 =?us-ascii?Q?9TrLRkHc4k10UvP+XfCfSpFHUqyNukb4Obg5D2ZdG0Pxc3WyAikUrFVUTmHS?=
 =?us-ascii?Q?S3cSFUnso8xIJbpiv9yizYsmt/Dnebk3yQ4/Epl0+1GuAUv3ZkU3pfdnlIY8?=
 =?us-ascii?Q?hykZoxFg2uT2v9zaKPGbjWd+jVCtskXuw35YdRXez4h5wgGe9CMvSLBOqDgc?=
 =?us-ascii?Q?XrnJV/Tv5FaHZAf5ZnheUln99eovWUovfxLqoBb3NX+dUdnso38cmaedVTx5?=
 =?us-ascii?Q?ndxTbIP85vf4h9N69ABZnKws429f8ngyUi5t3yqRgeyvhYqyNWi2e12jqFvO?=
 =?us-ascii?Q?W8hhnoPybcBSC1gwBNoVXtP1ryp1s9j8EMMUXtEt7RPFtesTUOvEyM37Ctwx?=
 =?us-ascii?Q?ZamPIS1wnAPn7OlOSGkF6tsJxz6koJFk9XS7aND6JU0usko/tht4hqpLoQjA?=
 =?us-ascii?Q?8iQI0yzc0fYOAFlU5yoURSy4cpoxrvLNpvbi/4HzpC8CAFGJEXp+7yixEKOd?=
 =?us-ascii?Q?uRE5IwWyrahyyRbvT5N0wely46y8DDsbY/ZCGodNBqlgQjuf9frOiOOlRqig?=
 =?us-ascii?Q?i9ZktkWq5NYPsTfCTmge4EiI6vsg4c6L+hqG9upPwacHHA/CmZA1cLIjkdB4?=
 =?us-ascii?Q?HpC672uuNZiF4ortrsITf839Nip1byBspHGgIOXekVq0NA8YerzAvsaYuwL9?=
 =?us-ascii?Q?kZnM+LgfyycSJhmLvHRKeeQyGh732U1hT9kcghqLH1RUPIabxEQ8aPJIZ+gQ?=
 =?us-ascii?Q?lz0fqjOpnJtVAad39WTFT3VQvf+2HOxPcWru8Gp/lO45RYxvzH8Zlon22DtX?=
 =?us-ascii?Q?1fxK968htLjuYLJ8pJ3qG44fjWxle6Os9kuPza+Jw3IHZkd7OagONoSQYBuV?=
 =?us-ascii?Q?ZdDLB+dOYoASbIOescHH86CzgoFlc2T/CoKcQvxORx62lpqDIbgmfw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?u7jO6cEsTuvIylzN3STO3AubZ/ILyPD1zTg5rpom6G1rybuHn9ikwRqeuID9?=
 =?us-ascii?Q?USPtJx7V3ut4N63XZMoywgCEnWR6VA9kIFhKV5pPgKwnO8MmNCOosR792Qig?=
 =?us-ascii?Q?PzPHNTVKN0xohOEoa+CmXn/pJt3PN4E3nggn0i/YQqscYE6+6aL+GHzO+148?=
 =?us-ascii?Q?RIQn64+Zl/ZG8rUuZLT3fnFA2qLTFNgRkuCockc2fMjfVxtUZrbCgjeWPNxF?=
 =?us-ascii?Q?5dnwE1vj5Vvzy6fEriJtlJ0kH311RP0oM/OhpxwcduSDhzb9CU2kytfzqhdE?=
 =?us-ascii?Q?VzswZZCbbUxsMoL087ePBm95XG0cRTukd6yyH5x9qaxOWt0arK3LGX5vLRTO?=
 =?us-ascii?Q?G2TdMhfq+EvebDh0awvIBONkYgw5vW71DxtgMCDSt8uflEl7+/cAG+ED76GD?=
 =?us-ascii?Q?wlbaAwOA1M90JLn7J2yi4Lro9vE71e5BbR1mEVBjub8TlC+vZToI+x0jgfyJ?=
 =?us-ascii?Q?aZgSRZKQX8xnaBYN5Dk98Nw4ZHEPXQiKGu+8ao0xPLq58PDWNSgk56Q9LLm9?=
 =?us-ascii?Q?QV+2SPVOm0b2CB+CRTa7fqOLN5krWr9HtHbusRL1MZLz3+jBdsZZBw+l8MJY?=
 =?us-ascii?Q?Ne8vq24LTrJSPtV5P7KkWF11DS6ztYkNPX77SSxCBfiaokh6AMdws6WspucN?=
 =?us-ascii?Q?Wn9vj1rxHlLphvtN8gAJ1p8Cb4H9h/7DAYZyaU0rKgp8gpfWM8qRJyWRFee9?=
 =?us-ascii?Q?niALdy2KwAoTlPTgniH3t8RQWiADwu+9fiS+jnM0EPTjIna6A92PKLen7J+a?=
 =?us-ascii?Q?sE79Y0s0ryuvWaoeMT3YmT4E5CobBJDAqRYq72YTstnLjX0Rys0GKLmYZoK1?=
 =?us-ascii?Q?uF4IJBigobNEdJzXB9jk55t8ChBNChpMttPNWTRNmvHJITPQiUy9ktMqUH09?=
 =?us-ascii?Q?hyUbM9MG6D0lRwHBSlS11EudMUQrmSWkkRN3gsuima3HiEdN7VX3r7Wp6WJh?=
 =?us-ascii?Q?8ckC89QuVn/q/jq88knGnosj4vF4Ch0mtBVq2OWXCDWOOK0mC4+qFiSsQ8qH?=
 =?us-ascii?Q?Ek/58+cSwPpTl7Kl63RQzC3tojudUkLI60X6Ek+WzeJfMOh7kjoQ02N++LVX?=
 =?us-ascii?Q?fvbwcXUUVz+asUs/P/dl5yw+9mem6tb2y58fGubyNdQbrtFvATtuv231G++k?=
 =?us-ascii?Q?C/wgbV8eQQI3c12SsAryURI1Tf821Ti6OjKFbdQvL7uu+8WRwLkk48YBzI8z?=
 =?us-ascii?Q?UWVO+b9RTxaulBqugQr+pxYOBy+zz6IjMGwiz60thB9cCuWgxrUJxdD9kMi1?=
 =?us-ascii?Q?muGpLZ5oo4Diyss35XxQxRlmVxWti36QW6NaowwycgooujfuLpQsAEa0aKJn?=
 =?us-ascii?Q?PHOJx63PvkKQmyh9G9MMPttKXnYhD1CxVYMD8cQtyKd3Ds74KebOF8YDuIMw?=
 =?us-ascii?Q?yWD5X62mpWSwJt3CaLCYNdOSo6Y+5P3dA9H6maLlSk+xpU6wcw2+MDxM176d?=
 =?us-ascii?Q?ibxlEhsSIpO4Bh3UWa3Lb/HC3u/jxZDtVSVEE4JXL5sb4eeBgfvFALPlc8y/?=
 =?us-ascii?Q?uhtAvxCLGA3zUU/+RgsPhVf8kPIioEAWbjPe4L1D0gjl+nWwCYUkDWzXO/gv?=
 =?us-ascii?Q?nvGSBfqo5JQHI0KzxYplBHKT2SQ79Ki1NoLbXWJ5awp1lZutdj/NqDqfbeM3?=
 =?us-ascii?Q?Tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66843b19-044c-4a7d-4b3f-08de3bbea424
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 09:45:11.6241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BndcuqM85IGQYJEPin/gnMwqXk4kI0q0GhV1aNY4/67OkPwlAUXZqWyv0o5kQ3/i3tMujSkDK8s8uFGACuFvOYTftNqlQ5lYUpIJVouWiNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11283
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 09:45:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21038

+cc=20
nobuhiro.iwamatsu.x90@mail.toshiba as Nobuhiro Iwamatsu <nobuhiro1.iwamatsu=
@toshiba.co.jp>
bouncing.

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 14 December 2025 12:01
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhak=
ar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 3/3] net: stmmac: dwmac-renesas-gbeth: Add PM s=
uspend/resume callbacks
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
> index 4ed13375fd15..42cba9dd967c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> @@ -137,6 +137,7 @@ static struct platform_driver renesas_gbeth_driver =
=3D {
>  	.remove =3D renesas_gbeth_remove,
>  	.driver =3D {
>  		.name		=3D "renesas-gbeth",
> +		.pm		=3D &stmmac_pltfr_pm_ops,
>  		.of_match_table	=3D renesas_gbeth_match,
>  	},
>  };
> --
> 2.43.0


