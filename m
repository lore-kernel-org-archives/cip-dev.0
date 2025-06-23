Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B91C7115B
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 10:28:29 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.67])
 by mx.groups.io with SMTP id smtpd.web11.16553.1750674499375190184
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 03:28:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=U2jCBurL;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.67, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPaIzsBE96GBQgTLPZ4/zH0lvEqtY6TpEmqdYqlsKzDGaCknfwR+1YpUzB+kbyy5wgfBrNaPDGJICPgVT2QyexqaohYGbJ78ztb8BtidgRtp4u7xEl6+7urjmv0vQd8u5ghdtPnhAja20ZxOqc4ZrFicEYJC6XuU0vsarQh9nzUO+WbeNPMzY+gFpxkcbGA5UFWglw5MGSYrv0LAvT9m2mUfG41j5hM51hAuAGvYXEFxLChq25qNfzj0EY5ZwnSC+3ThDaEAI0iydVVuT0fQbRKARX7Y74ebATqilLfo5SK2fYhFMNA9DawYVxhMiy7nJNu0mSbxL59o6ET1/KC+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyXZQlwAYVXIQPMWuRw6iLJqtJ/RJkjwS5zdGZlUD5k=;
 b=yf9N0JRculRYrjrhqxEqoWUzCSPyE5bpDI4cQfzT8/jscNLlldX4rXJvF09nqQWirI9HQmZjmQ+VAqZ7VoorLEdS+rrBf3ReiTz56HKSS9TrSPzhScGFxCDKJYtBRjNs3RZB4ZvBOvU3q2liVU2bOHz1LvCP6OZ29HtIjBomEuIwIqbLxEwiIEsVkkip6hbG5Pah2M+Lz8vYWhZBfOPeDfyGtuq3B8De5JLCSvVLoypXX+yLdOaOknxL4NhzaK1Fhly607w7y2pmy/pAjRbuXxRQIjsn0kBeE4frNEl7ykg55As1GWkRBZX/d50M8fX5CjMkFabVSeDWudBQcGJSPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyXZQlwAYVXIQPMWuRw6iLJqtJ/RJkjwS5zdGZlUD5k=;
 b=U2jCBurLf0y1NSSVisFZA2gfd5ewKbEjxZHVnQBTGhc5QYgPGM9QEksr52ZeTyx4dEy0h+HEmOTs4JZ9giA029KAjF7FYFt2XZt8MnMH2R96Esv9L8dq8ay79XKgl7Cz69xyss3tB5X91n2WSW4tjPYCPWUwcaa/t1R64edgGYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS0PR01MB5747.jpnprd01.prod.outlook.com (2603:1096:604:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 10:28:15 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:28:15 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 8/8] arm64: defconfig: Enable Renesas RZ/V2H(P) Watchdog driver
Date: Mon, 23 Jun 2025 12:27:30 +0200
Message-ID: <20250623102730.1493286-9-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623102730.1493286-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623102730.1493286-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS0PR01MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a05a40-9039-4472-75e8-08ddb240a99a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?76T+uXNBEZY5r4tT20Ac7FFLwtwaszcQgbWPlnvMVVkNYiLEB5lD5+b6jkou?=
 =?us-ascii?Q?1oPTBYqP2w/L4QDS+WhKzUecghTdQxBkgrskmGkMWN7rUcQj1bC1DAzGLuGt?=
 =?us-ascii?Q?487Sxhq2WlTBgbgB6xFW5re3b4iMfCypGrpLbCxTVTxAP4mzDFY18vZDGesT?=
 =?us-ascii?Q?y+zUZPOrEIhqXZ9v5J6Q6B8dqB1uCVGcQVBY3Q3jLHPPCQuZjjnHfVrH9QzP?=
 =?us-ascii?Q?nf38Vs5WyuzDvmcbbMtG+4B3d/EdlehZLEcE+2PofuZmEi3yIg0CseAT92MS?=
 =?us-ascii?Q?2R4yvcUpp0rwhliIDZpOMNrrogObQlfdfs/TauU9L0Cquf4zhQGNqMdXcHRF?=
 =?us-ascii?Q?b1VHEQOYvQMDCeGX3iV6KMJRMBAQ4SG1Nuu7I1uSmgEOiWIOPpzFAdUfr3Rs?=
 =?us-ascii?Q?O+KB6QYAUl8xnVUoKI9V0pD1Bt4hUuCpBpTA+iwaO4D5k950krycFyrS0RrZ?=
 =?us-ascii?Q?leXvvruPIZ75odS90GfKmF3pku+YjmGl+CgX2h7HF5HRc7bX7vYYJB6rejra?=
 =?us-ascii?Q?Tdu+CtqGG/tcZclgRYFnAdzM7gl1MSU//03wDhFcmzr9tcgiIO/kKMMOvgam?=
 =?us-ascii?Q?CO0Qlzf3PqUbD+N98NLKg20sUKSWNSkpzJMwZFL8ZpRHShQgM5N+eBvXMtVo?=
 =?us-ascii?Q?lnYE4RaOXHaYlhAGIx7thCesN1ji5eGQNKbpqwl8NgGc+J6pDO7YT04Kj1z8?=
 =?us-ascii?Q?cvloG0x4kX+kkqqbGBYgPEJh3Ku9vm+eQ9xN94jW7NcJi6Nl6N7iZjYx9OuZ?=
 =?us-ascii?Q?R+nMdGph1Zia61lU+KJHBAl2pBlG988+J1xTIWuNIVnnAJ2/AJYfdhGkhYOz?=
 =?us-ascii?Q?5i+lLiRpah1BixH/ZiSAE04oIraYXwkbfncaST3jeYUWRG/kWLyIAK3ufC22?=
 =?us-ascii?Q?iAdto4pHdNBBu1mr07F0uVqlY/gQs3e1i56xaQnpmjVqbM8ZAERi59ul5ni+?=
 =?us-ascii?Q?Lmw1f12LGGqvtzvU9tDN+cQ4Ewj6cq2DlJseNqrBctyc0CdlcMoL6+BV6g5J?=
 =?us-ascii?Q?q/Sh5+BoRsTB5/f1OQUC0U2pJ/5MOpInZjjFnhb/ANx2KSyo/MLbGadcSy9E?=
 =?us-ascii?Q?512bfLhLXTWagukRV7M0rfoVg8BrZcRJ5EXi184Kcc1h23SeILDZWPlfvh4r?=
 =?us-ascii?Q?ko13podEDC17QjcUYg9J9YzDgUU/KjZsSfJQeFOKwYlhl8V1y+Radlk3rSYc?=
 =?us-ascii?Q?oPcpzDjWmQGZS7J6T/FCNsP69yXomiFNaVlFZLm60epTG00J/URuKl4BKvFc?=
 =?us-ascii?Q?aTHhllBU/VsVAwGYRSna8EHzH3+faZMbgB1FzJAOGSao9pBUTi8zFBY3snsr?=
 =?us-ascii?Q?J3AASFgxTKojvjKWVWDERT+Glx5+0pC2cnoJGOupZQVPYEVkPpKAazUvIefe?=
 =?us-ascii?Q?vEekDWKxdTT+Spg7cpJATX8Jg+oF6r9qGiJIBWKqnMB6whAnoNtNxqBl8quN?=
 =?us-ascii?Q?nJ/1Sn/iEHIkqMfp2D3aYFv5Hf4h8ZWP6ITcmMpI227o57ilK0hennbnxYnR?=
 =?us-ascii?Q?C5Mlra6S3cpzOVk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mnIg8YqGyUHu0UAeKAJzZ1OUYJG0rc1CxXbRmpDmCE5i5JSv+FZS/lCgLpXm?=
 =?us-ascii?Q?sELdvd+4mS6ui/GdQba9NSZ0nRfWED7DzSW5jVto4jAJMSQeA/IAkCt1C2e5?=
 =?us-ascii?Q?8e1fFWn21GNWFppdoy1UFHU5C/5aHdaloFr3+g6mbhAjPCjQJYJ38XIxBpK1?=
 =?us-ascii?Q?hAd/YH+3l526M+u9AdI0Uz4hrntiKUnEPrxDyi4ZQfCC851FC4JV5EKoL41x?=
 =?us-ascii?Q?7RXlCMVWlAHI8CJ/z/QtbRei7A5wGjtu1cikv2I/mVtQDV8zn74D55N9sujw?=
 =?us-ascii?Q?sOLAGgsiazLz6lVrMXKXKYj+bvWpwMbM1iT+Eu41Q2qQf+T2Jyo34BIBVZRt?=
 =?us-ascii?Q?kjMIPKxODFOgb0HKtP2RbgjB0Yr9BvB7VYg4DV4r/8j8EQk3Pn4m3hAYPZZb?=
 =?us-ascii?Q?bEKOro5DwK3lz4uiwUxhJwD0E4Nea+tlsvmU3OWXI9QVQoO5NIi1gD928Hvd?=
 =?us-ascii?Q?rSK7irVzp3psFVwwtANEWq+4TLvkyMvk9GoAyvM2z4X1bqJ792v0hs4ap9ky?=
 =?us-ascii?Q?Ba4h7c7nA1t0a95bn6JcfSQlRSmJFBRWNVMyswG3gpdKx7CXJFyZ7RM64LlU?=
 =?us-ascii?Q?LFt/uEB9VUwViWk52Io1gxJLkn9/Qkamw3hSjNxZuJ/2FvNLktbVvc7QYiz9?=
 =?us-ascii?Q?jVnVlGA/fir9JJ1+Dv8cUJpJ91AKJqJvgiQYzLs6UmTe+/1bIt4fq++5NIbL?=
 =?us-ascii?Q?kdaKvvsqV2lhEeTV4KUYelGDHJtgCw8uTxlwutl1gt4V08AZQSkIf9j8s5Ny?=
 =?us-ascii?Q?3puRhPhePXBvF8vPM8+WAbwAP0ShYLKjf4FzcqBM+KAn7e5ttauOh9f3XMKE?=
 =?us-ascii?Q?CZDMVgwIjgLGmZ+mJOt9CaIQwnXla1U91e9aTzQM6hoxI4SqtjLastAp/XpZ?=
 =?us-ascii?Q?Shk+kGwuR5EctqytSvRWkXk8/bFxvWmuMbyCusRmKTKPJdlbBxMvdRoRg1wt?=
 =?us-ascii?Q?DgBrcmOGIXHmO7wyPHhuYcEJaFBQhf0KWbrgfQLpHMcgBT1ySDdIXnmKnXQR?=
 =?us-ascii?Q?8q7tjnigFjYHAkxyLGHqE9UjszLLVLSfoj1m+wF4Xb128S6mx/YjTMBYoeYM?=
 =?us-ascii?Q?p23ICaE8og89lk/phKXRS+Ka5GyOx1434QNFe6VjI5LQmPBc95js69TrsMkS?=
 =?us-ascii?Q?EjWXY+tghaxcR9H2pNXhqbL5licWr3kcJd0jFSMd0ir+spfN8z+Cd39jDf77?=
 =?us-ascii?Q?Iki1Si0ey38GlIgavyvCrS0Wvi550ufP1L2+sIsgtf572i/ia03/LI4NnWJZ?=
 =?us-ascii?Q?RMKqeRGjk+GRf3UgQ/ysrkrMlcQV1dpslP2cmUK8SXxNqm0ZtUJBIFoIqePr?=
 =?us-ascii?Q?qgKpppKhAlhuHSha62FORbjEwm8hQJpQxwN1joxWtX3uKZJmmUNc0A8gGJp2?=
 =?us-ascii?Q?vDYMsXNmXVX7eiBmXdDF6ZxrhATLC0p3LHDXVg5a6TGAUE75PtGcXr2ZWvFQ?=
 =?us-ascii?Q?pnJ4h3wdvjLq4YTFHBzKeE4WdIhN+K/BALkZ8LiDvqw6nEYjWvJWNp4PLNqB?=
 =?us-ascii?Q?YUWAOB4ob48UDrYTRR1BGWS9wVIAByb+V737zLGq5wo2yw2uRAEcv4KQ/oiu?=
 =?us-ascii?Q?hLH1dKAqpxWQxGny0p51IvzUKIys4qEIFO0Idt+iIKw2UjqiqoBK1JJn89vA?=
 =?us-ascii?Q?XdcXQFVwytTFBeNLN8yxsqQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a05a40-9039-4472-75e8-08ddb240a99a
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:28:15.3417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3LqSPxbb/nEZYmFMrG527eg91aI+mYXQAYN+BeE7VXFw9j4msKEDCccfgSF18d6uAvTwVi0kRP7SkEVeJfM/5DQYM/UXvatAbjYuwgbO0C58wyQiCiDhBN6x+7sDtkU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5747
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 10:28:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19173

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 5ad0a0c7917dc434ee28da765186dabc81172e3c upstream.

Enable the watchdog driver for the Renesas RZ/V2H(P) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241112093412.20093-1-prabhakar.mahadev-lad.=
rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e99fc8006025..b65eb4e67244 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -636,6 +636,7 @@ CONFIG_MESON_WATCHDOG=3Dm
 CONFIG_ARM_SMC_WATCHDOG=3Dy
 CONFIG_RENESAS_WDT=3Dy
 CONFIG_RENESAS_RZG2LWDT=3Dy
+CONFIG_RENESAS_RZV2HWDT=3Dy
 CONFIG_UNIPHIER_WATCHDOG=3Dy
 CONFIG_PM8916_WATCHDOG=3Dm
 CONFIG_BCM2835_WDT=3Dy
--=20
2.43.0


