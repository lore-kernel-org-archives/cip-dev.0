Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2867C83013
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:37:53 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.6])
 by mx.groups.io with SMTP id smtpd.web11.20590.1751452663975896042
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:37:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=F8+mbpzQ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.6, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTPHnNClhj1ltiCaj497pK3rMgRcvHEX4cxonzGYSPq3Ur2MvVmFPEYxwdw+L2gFcPFegPGVnm+r+8Q1JYDhei4Of2Ql2TA7flcrIU/fxwqGoKbDIHfru06MspBoc0rN//HoyxJGjzUDVE/QNLM6Jk7CRkerzE1nXRtqQB1mitN4kLj59uc0SIdTVA6G9Sk57BNb5fme4kRnXWPO7QccPzxdPmClXpLDfJypPmqqYGtyFgmv/Zz37SZueceGXqdtNaRaYjFjdbTgAFgOaZShCYWfbu9M6jLJchpOpPc59iNN1ARukAdyWM1niT150SvDykd0CoBsws0cKFFHtj2pQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBMDynYCnWpssBNu5+WenTqQs+KRVUU9mQvw2TqxCV0=;
 b=Ux70JiwOMmXyhmK+Y8AfatThKVilUJdvacVqUnA8BINWdtCflPvR5JKzgHlK6OpQKjk5JyXYZLH21VFmpRvuYedz+ZgWYgi6fLqRdJkYTiEbO/kiupl4XQEwrZdK2G479OfX/OQgV/FtHaCcB8zDVQK/fa/fniUw82jlphYKbye8o5vej4JdBj0Ggw5OYbQANN4ngpN+Y9COj06/oImaaHm8dZkG0co2FwCyM93I+0iG92CpolqkQYlwFnwW15pP7mbOCQ8hd+9NKcIDcUClTsY9F99ueuFmw7ZbWUd6n9oYJ27GQkIFeN0E4TIIu3u2DZsIoJ/0Pd85f11jztM/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBMDynYCnWpssBNu5+WenTqQs+KRVUU9mQvw2TqxCV0=;
 b=F8+mbpzQw0IqnU2Byy6OIaSU8SKr4UeLtTwRJHOidhRTMAek+fUvhcCtUSCCt1yNkDRUJqFoWm042baXktmwBbOi6ZcqVfaGhDwzI9q4fyyGv79Y6UCV8fW/5gGi7Ut29Y+X94PPlQKkTG27iKziUoaNSjDa675s/ad5e0CoPBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB14154.jpnprd01.prod.outlook.com (2603:1096:604:363::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:37:41 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:37:41 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 04/12] clk: renesas: r9a09g047: Add clock and reset signals for the TSU IP
Date: Wed,  2 Jul 2025 12:37:02 +0200
Message-ID: <20250702103710.117760-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB14154:EE_
X-MS-Office365-Filtering-Correlation-Id: 578ec638-d7f6-401b-f9fc-08ddb95478a5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?x8ebL7PF8l303lL+gdjuMdPtHcSmK1aKjBcoAwmlKoFP64LicJIHP1YHdsJ0?=
 =?us-ascii?Q?HaZbVtVkMrn5E2XiU7TuZxQOI/F9FC5TKtQDVp4Z49JHEayTOS8g9eqpCWYQ?=
 =?us-ascii?Q?mG6wVsknl7q073N5IrD6lKslpcQe9un1JJmoDUNMAqh2DLZlyyw+GWZSt70D?=
 =?us-ascii?Q?1yeWBjh3xMPwt4cwEIqHsO9dkUFuimWYdyKynuUTHbfEas1QHr7XO7uVG+uj?=
 =?us-ascii?Q?rtkYDM43XTk7qhw4pfrV44/5B/yiM+/9TdqeWghmWwWvD8/5uouOXWN70Fcf?=
 =?us-ascii?Q?XVxlRxF6SPhhZOD/30WQ5LKRafJhtxCrn2sa3NFQFF6yTmiPWuMjCiSHJ3h8?=
 =?us-ascii?Q?o4uWC7DzwikS2itSkI9w9+s5y/LbtWZxcqyzkOQNvJK+SLX+pwstK1Gqq0kC?=
 =?us-ascii?Q?BBNcAEJnwAX76CyoT7JCeo+LgoY62u5R+GxQ5h7S4Bow+SzvhNruN7/czydm?=
 =?us-ascii?Q?eMx+q+XBS6qeMcdWZJEeHDEGdSMt+FOQMlxOUF5eOA5qXR61Slqpvjg75UQw?=
 =?us-ascii?Q?1moCq7N7hOHGEWVcZeRaU0Y76fggCqdMdYb3vm2I63OXSjTKGYSSi5QWGd+U?=
 =?us-ascii?Q?ldNa2PnhM+a9j3IImLWl48+ZoqSw+I6bO5cXopl3j+D+JpwMEwU8aRaTbV74?=
 =?us-ascii?Q?YJpDnTe4819XhvaOd9rXGop7y53Xn70NuHl6Psg/TEsl2A5kuA9OlSdPAXjw?=
 =?us-ascii?Q?qbgkXWYlUiAbyaYsgiscGU+8hbJs2HtTMryniqFqsp/cGIowqIFN5beD3yYr?=
 =?us-ascii?Q?dQodfXJbtisoMljOUe9FhbM75HtuZmqPvPY+3JPASg1G6sNjVf4EBsrQyhco?=
 =?us-ascii?Q?GA4lprAI1GYdU4Be1LdljtihK29EnqTPXZh2PMMptxNSf3WGoCIIFAiOFwMd?=
 =?us-ascii?Q?VWN6mkff098Y8r3jinzYBVEe9NEXxuW0QedIjdwrckna5g277TVOnpVMVY4c?=
 =?us-ascii?Q?a5WHO6sE3dUTkASu4heWIkwGJJwOWowBh3LNN8tfecSPewIX6QRgjy9AHrIb?=
 =?us-ascii?Q?V2+tyqDM3QDMMG205VRQa1miSNHgS3M6as28tLHCJLoEPHcqtG+SnvzuA7nF?=
 =?us-ascii?Q?fUcgTNbV4xjAcAk1203YTDEtZ2YYownqzZQvVvqTxTVkdmhNzbfLalFRD4C9?=
 =?us-ascii?Q?YXpgvnM3G5dOP8LsXtOvQD0+CCxkUpjknFHpAyDkCFYf/OdIqNwQ5bp7lVLj?=
 =?us-ascii?Q?J4YQsz0XZs+fAMeWRYbytVgGtCmYgJl7D8mjuLFXfkXNdpxlIe9HIlLhyHyz?=
 =?us-ascii?Q?q/rph5oDpL9wJgDny0zrPhTihmyHKc4ySsRq4lr5aZ2uNqSTmaNphfrZmd8+?=
 =?us-ascii?Q?krfsnc67y2qHHcOYtRlBE2pAlpvhOFgbc3/5qpRPDaT3ToM05vBCjIJV9Hxd?=
 =?us-ascii?Q?442DlAlnq3lXCq/IQUUB3kDBINMCddw/Il+rF807oDx5G76XesTnfd6ohI9K?=
 =?us-ascii?Q?SELtHZ4/IQYQ1J4YHL74GH+m8ajShyvdnriGYoAiwTH55Us6fHwipZx/l2ZA?=
 =?us-ascii?Q?z+tyGSCA6RFZUPI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Zi+g0/g+ClK8aBbukvolt/xqn+GTA9q1cxGM4Dqsp48ml4EC0vfqVWwcey4d?=
 =?us-ascii?Q?6G590jmvfmIvzm6RgL3blaWhEfOGYn29WC2rZI0R4bUNPCl0vB0YY3AQq9tG?=
 =?us-ascii?Q?KzdiTXuXRINC2SUsqzfnl732nhaWCsfmfweQj3ZLvUz5n11jK0wCGEXRyluf?=
 =?us-ascii?Q?7b6yy4d/FzbXnLaXvPVhIJ4jZIelbbG7+b/NSjOewqDQiniIQ5CITmuQ0o2C?=
 =?us-ascii?Q?Kl0UVAS/pJVEEkQNN5VKkU5DGh4YdbJZrZg42s2fINjFTcs3TIAmZPYBukI5?=
 =?us-ascii?Q?19vL6NcSoyctdQAhAiPLPY1MDHj1psD3CqO9uf4o8do8onVIo91Q0zTCiovl?=
 =?us-ascii?Q?viDjNmYp1l2I9FeY36nmAMvJEGRlkig+nFK9ohHvShcoeO7+oqY6bZYX5VPJ?=
 =?us-ascii?Q?u50l0vPpPWrXNOd7prLRzjsyWPliiXqgBXqQN8+nIwDvIiOwn+XPAyAbL5bb?=
 =?us-ascii?Q?PzllHsF9/v0ei/s9w8WLofHi3qO+oKqF4A/HbsW3xKj0/vx1wPFpQGlOecNc?=
 =?us-ascii?Q?rC3j5/HmdxFuSos/jMk8n7Rq7aKqiUqWiY3gz2oRXCdwQ+6PjkTxIZRdfEL2?=
 =?us-ascii?Q?/0NGgQIqmvCL5SNCVm/DUlne/BghG4GjlJKUzk1BCL1a7vBtVMJnD8yrpJvo?=
 =?us-ascii?Q?dbBonNhcMWYkZCTWxIn5lNbTqJdkgUXa6UsCD0kVK7BM2RSNObvNVDVtRdpB?=
 =?us-ascii?Q?AUOy8P5WXdFZVWNz1exQ3voATNsx12oqGoKRf40N8eyndK2xBYrvO1SyK7c6?=
 =?us-ascii?Q?TUFPip/i+GVL7ljnQDsCr1jHzPa7tosdn9OZYqvtcEUHqLOpfPTabuHE3gJc?=
 =?us-ascii?Q?NWLEfbf+wPB9nDoPH3Od5xx3T/R0CBpM8cu03E3zzbanH79h/e+0O+frmHWR?=
 =?us-ascii?Q?fkpHavZ+PNh9ohpzeyDO2r9TET6pJzlgN/r3A+jRK1ORsQjxj2Td9ofzrCSC?=
 =?us-ascii?Q?TtNfshGMqFpFzXMqH0CocFzHsy7CzLFRduODUaJXxO3IxGfCsSL4zTxryiRJ?=
 =?us-ascii?Q?hnm4RDv/QYrZO0cBeGz8t0I7CXWcpTTYqwYOUV8baNCpBXec+UpT9gtwbQWL?=
 =?us-ascii?Q?2FDJQHpSoaMWasr1LDcNMM2P2lT5WoijccgCviVtdmdDL81O4Ggwx+2EUnEo?=
 =?us-ascii?Q?yMH/H4ak/aVNPQKKeTrF4SbdC03S1nVOrhG+I6cWKzaoS6nJljosAonX65kX?=
 =?us-ascii?Q?tdmk4LBIFPzkvc68bNeJfN062mQNheHR15IrIVe1bsJE+8/ovqDLpy50OhyG?=
 =?us-ascii?Q?o+EF0/qWbRVLAyAPo8oUXzRUHjXKaIS3/FEF/BrI0vJpYJpMUTfuN8WLpvQG?=
 =?us-ascii?Q?mR3hcKZATd0lNuxU+b6RWx6pEhXgML5T8nz08cn/YmutdaLWoWtvPLBTmegL?=
 =?us-ascii?Q?IXYawVQcg0IVEUG0IBuSlpRb5DQzlPFjt8JimJ04ZZEw3aQMbdC3Q+XoGbO/?=
 =?us-ascii?Q?5pVx0jOiP/SMqb60eCLnallgRb95ggSQvRRJaY6dC9nWub6UBLM2uvoxFq1y?=
 =?us-ascii?Q?lFafjSr37811w33WOhXcau62yomUjp4g6flfkfEsWAldNKidD9ybr5b1FPCV?=
 =?us-ascii?Q?W8yskKqPdykrwQt3AwMquc/psKgpwZ1zdPvU6lEa8q/R3Q0z1F0w1QrJ2HHD?=
 =?us-ascii?Q?XOVwqy0MQbu/HHlAb+At7hs=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 578ec638-d7f6-401b-f9fc-08ddb95478a5
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:37:40.9924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/YsifzQaxo6Wyn7A66r4E+1HQQPAnKXn+S1bvvX3pL6ciCNmEzlycu7S7jF1EvK4tGJaVjD0x4ZK9BLE7COYqQ5t0qNXLvByi8NOJRyvYNSrz3tqpfMl1JsZsOI4ZuW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:37:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19302

From: John Madieu <john.madieu.xa@bp.renesas.com>

commit e1a098330ef0555ad216e549a018d99aee7752c1 upstream.

Add required clocks and resets signals for the TSU IP available on the
Renesas RZ/G3E SoC

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250227122453.30480-3-john.madieu.xa@bp.rene=
sas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index ff015b3b4d2f..e9cf4342d0cf 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -183,6 +183,8 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[] =
__initconst =3D {
 						BUS_MSTOP(9, BIT(4))),
 	DEF_MOD("cru_0_pclk",			CLK_PLLDTY_DIV16, 13, 4, 6, 20,
 						BUS_MSTOP(9, BIT(4))),
+	DEF_MOD("tsu_1_pclk",			CLK_QEXTAL, 16, 10, 8, 10,
+						BUS_MSTOP(2, BIT(15))),
 };
=20
 static const struct rzv2h_reset r9a09g047_resets[] __initconst =3D {
@@ -211,6 +213,7 @@ static const struct rzv2h_reset r9a09g047_resets[] __in=
itconst =3D {
 	DEF_RST(12, 5, 5, 22),		/* CRU_0_PRESETN */
 	DEF_RST(12, 6, 5, 23),		/* CRU_0_ARESETN */
 	DEF_RST(12, 7, 5, 24),		/* CRU_0_S_RESETN */
+	DEF_RST(15, 8, 7, 9),		/* TSU_1_PRESETN */
 };
=20
 const struct rzv2h_cpg_info r9a09g047_cpg_info __initconst =3D {
--=20
2.43.0


