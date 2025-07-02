Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3600C7EE30
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:36:03 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.59])
 by mx.groups.io with SMTP id smtpd.web11.20547.1751452555834169188
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:35:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=dCeuUUtw;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.59, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVdk4mPLniwOZ82JmHEhLQe2ZiAPykDRmiWIal8gJ8WpJ4MNWiY2BVjFpYQ4jss0lTyonKISkzXp6L+wlH/ayTc36TktMpvoJAtfJs3pPf2lVUz4GZIXt+k8YKmnRuJYohHUwB3qyfrbJ4w1NwJLRY826LgaAE20bEg92IDY5/qDZDUlX06wPutcb6pXszjIJrwnPQpLOX2N33lkuOz2fbf8VA4Owu9QKA1HSvQWfW2VDiWGsDUW8OgbVpRyeOjU8bnULIUUiRR319+F2I8GiOMh62orbdJfGk59q45Cg19PfNEcCikzwx+4OZUsyyx96/r2XikAs5eAhjHdV5fFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S314am/H92fEIpWYJ1WDuZsq/3mGQrGStUTcxm7enn8=;
 b=uEc7QVDzOLQkQDw+hSEpXIIouaGwwxHwW48FRq4XRfJccwvt1kOgreCv9gSllPuYAYebVdAHb8ZZDfDcwMwKuyb5AhF4JdKuOvrW70Ol0vzVeLQODMxEGwdnK5p8MXV3bBRs/pC1aoCInJLvUbXgC8ftdF4cVH4A7vbctjF4TvRevhUNDXywX+CrKdtx9N0NK77Vv4V2Pf5boavHOn6QerIrRu7hdV4OkYSigaJNxRcFA+/Z9IM8BRhmgM206PKfvjl5OCvHDJjKmdAn/E9J643XWZY+h47R4z+g1pOUFBxMvN3sOthYj2y7iZ+6zpahcQoGT4cVYrMDbyZ9N4hIjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S314am/H92fEIpWYJ1WDuZsq/3mGQrGStUTcxm7enn8=;
 b=dCeuUUtwCKzfj6UHl+XyNRgDuQ1HYMuW3f/hlkFCXaihu0w/UwHA+6+7qVVoTy5BPLVfgPYlGk4d7vX2xVp/9Yb8UTc+1X+k3zxUyPDhvfuXaeyTW47tbeu20KTksrTSj7wivyKiWQU7JcjJmYqWqP6FvJ9tAbh6ndftu3MQTw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB14154.jpnprd01.prod.outlook.com (2603:1096:604:363::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:35:54 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:35:53 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 02/12] clk: renesas: r9a09g047: Add CRU0 clocks and resets
Date: Wed,  2 Jul 2025 12:35:15 +0200
Message-ID: <20250702103525.117166-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB14154:EE_
X-MS-Office365-Filtering-Correlation-Id: f533ff0e-e61b-4bd4-739c-08ddb95438a1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?M2DL1TZe8VRu3bFLPmeamZeBI3OhXHsCFnGzwXZVcoDw21LDevKDiNf9Ui6l?=
 =?us-ascii?Q?ABnr71saK47DdLevlLTcEa7I+Jn/NFaMg6YWvLwSf/az381UkggID2JErcq9?=
 =?us-ascii?Q?e/y7db3nba/zZ1qlfhTUj5BheCxzcYjkZf8HgnVYL/OeaJKBN1PG6wAsTe7m?=
 =?us-ascii?Q?j8w29z9LtCR/M2XQsN3/NeaADOlMUTcJLfIly3nSYkZ3izN3vWu5Km4fW6nm?=
 =?us-ascii?Q?6XIcgjl6cCONKOpj9YmjBk//pu6iYzgqNvdRiDHaC/H4LxFndQ1oNZ3knb+N?=
 =?us-ascii?Q?gskhtModiCfQoOYdT9z1IxEEXuzLmyqnnJSDu+pOpo0327tTGmQZGwcSYzkT?=
 =?us-ascii?Q?aq4b1ibxIJQcNJSysT5lgPFogXeyMfoBNWjnsp+ppNpQ4FB5aMK3zIR1j/ka?=
 =?us-ascii?Q?A7RTaInpXumFXKkjMp3Rt8eupzP4FlE+tPNHOzadHdn4OfvYD/Qev2CBBgto?=
 =?us-ascii?Q?7ONSy8dlJn6Jf5Gwh0gtB0I2Po875/40/3qTkzRmMFdHM5sNc0d9slKiHEHy?=
 =?us-ascii?Q?sxs4LJ4UeoIX5zVojB7smY/QbNr6gvhSh4D90z8Sj1q36A83M2XzMopgKEAh?=
 =?us-ascii?Q?aysd0hV6snq3rko2cZaQPBUC8TDbFot3xfRvH9FQ0lvQzRXM/TDqvmB1EqlA?=
 =?us-ascii?Q?OsM/TgoFldzBXbWYp9fSd0kNTLnkjk1I1aNTcBf+G7oM+LFRt1CCLJbXAsN+?=
 =?us-ascii?Q?Wfw+KWG/yULMOBh2h/m6MNaeFCsm6o8MiEz4NdKxjrsDzyDvk4wKmqR4wcAM?=
 =?us-ascii?Q?aARfesr50LdjOmBT9Iw919YiPAwAoyJIwd3a86cJoTHzdm01ihgo4i33LNpn?=
 =?us-ascii?Q?sx/b1FOWqtoVuw0ZfuC4ScVxVpv+QLgr22jU9oZR0DOVoX7KKjG73onSMPR6?=
 =?us-ascii?Q?3UmxLsrwg5l3FvFrMo9zXKjp64kPVZELiWWYmw/PE+M6s585IpKp8aMJ+eGZ?=
 =?us-ascii?Q?jw+7gSoto7jdsU/TNMLvNwqFI9nKbLoCZWY8Z4BStKtvHCn+59zkz+rFtw7f?=
 =?us-ascii?Q?vJDnQDfrB5rjxjTq9oeurZo3VjpeX4MEOu9KFv4ccJ/kNmS9GQSnk2jylDny?=
 =?us-ascii?Q?ZuM45E3+Fw1VbUcwMEnPr2iLxKzPuRa0oiDnT61zyKGVfyt4dTrjGVtiXPSr?=
 =?us-ascii?Q?AnaLcYrQsVhBLkyPbol3LQGkoSgENqykE4xcSl1sCVlz2lQgfurl2zzr+vEs?=
 =?us-ascii?Q?/zYArIbelaAj3nvvEafQ6a6U2aIy40DYAPZ6U5tXGrxaf47yiSWDYI+LiRMQ?=
 =?us-ascii?Q?DOtnRH7jkO5ekH00iSwhKLWt7t7imMODO2eeRRjbM94lMgYRUDHRGk3pg+Ml?=
 =?us-ascii?Q?GhGfwWr0jBN/TXoQ7NS7IxEjnTQqq13mdrnuTOS021b9Xhh7OtRJ/7Lt5k93?=
 =?us-ascii?Q?tJzd5SPDlPeOKVHMyEQ3ULCw0VbAWEySrPR1VdqTIT0R2gDLXTZe/e3I7Hpp?=
 =?us-ascii?Q?xKzrgvGNEAX0JilCM1C+XXWa/yh/p3/sE1pp6URkopDMdLk/SuJDkfyaDLiW?=
 =?us-ascii?Q?5VScrSpfnAhi2l8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gTNGIfNqSX4AhU31aj/v6SduHApLCF8ci/bVKYdLQqmZ7SuykstrklJ+fVab?=
 =?us-ascii?Q?p3vsHcdTRP0JMD64rQR4ZhmpJcUw5sZqourkYA2EaARQKPOlczalYHeyOyeI?=
 =?us-ascii?Q?wHXCQKnYSc+Ix38L1vslxW58zdBwdlzEbgBTV3G2WHvhx2eW+7HgtTk25SEo?=
 =?us-ascii?Q?O0AsszpAbptAr6AcGgg7ZbIFiRArw1otsZos9jSfmYl6L5uUi0SLSZFyK+hM?=
 =?us-ascii?Q?l6tZo3yXe3h3szQGCYrgRZlhBVhuQ4Ixyq+oZrxzySBMZyODT1eNNCZvecKX?=
 =?us-ascii?Q?RKqfKj7kSsrr4aGjrCpxWweNKaA6z8PXkjnPww/HStCoNrQeOehaxh/fuUxu?=
 =?us-ascii?Q?nuhAiDhYo6I773HWV9ttB/S+7OJqmG4SlYZiHOkxTXIrp14KCNClsaXl4/K7?=
 =?us-ascii?Q?7UG4o+jNIYBmDkX5qdjnVS4GjVyu4fbjGbxvw6rzEH0yx3Tt3hPSj4aESJUM?=
 =?us-ascii?Q?a2PBo+4gTSYJF0OXik89F0mcCARCbfZlE41aN/TLgmdc9Tnvc5ACDtK2URrI?=
 =?us-ascii?Q?ajQhHTs5PPQf5xR9z8bwpFlv71+iehQ5erR4OogT3TrtZhxHKTiCIofmhzDU?=
 =?us-ascii?Q?2nnE8AlQQALkv0CdsU0izTFU8NtEGTVgTlpFHzAi5d/3zX3dT0fzNygbDRMa?=
 =?us-ascii?Q?TLf9xFsN4YFxnt/7f4ZYp7a7mED0qpcVXehklYI0DUse7MPZ0m6b8Wefjqhw?=
 =?us-ascii?Q?b3Q9MLA1OwRmBO5IcqfrOrBvWVFQ7UC1cMzRRiXkEAoXQdNNwPsPZ1h18TQD?=
 =?us-ascii?Q?xbvAyTAjsb09UPq8JQfKd8yuxesXQwk2U+io2D63oUo4eDfjzFxPLgLKNpkj?=
 =?us-ascii?Q?ZZzx2uqfgLQfL/xCklO9zwLzd+7vjDaasI3mkIFy+rAvQ9Fcp7sg5OGQG9di?=
 =?us-ascii?Q?vewX9dlkLMAjUrX74fZGJGDyYk8ymzreMCxqUwxHKoOdDbSFFIZmbNtD6k7X?=
 =?us-ascii?Q?Hs4UTSBhCcAu5F0Dx38x12TK1aeBIISZ+3Y+BzoIYfDOyKz/9rdtl4obicO8?=
 =?us-ascii?Q?jaTkSvFqdJnldM3AIP3TT6bvde5QHvL/MAGYPSjkJrN4oAcMHbagF+4dc5iY?=
 =?us-ascii?Q?3PhJy9V/A3lc7wORzCJ/YH6U7VFmOBmFt7XmEff+iR+/Gbdrht+xLG4hga74?=
 =?us-ascii?Q?LsELH8ocZORxx+Rs+NPTjBlF/qsAY1L36DOVqq+qg4sI8TdUgEI+PRSeNEsV?=
 =?us-ascii?Q?8tRaOB0HoGypI4E9/W0N1FaeaM/wmEizDwXVSrJ7mXS5GOJymze1OZpfz8hH?=
 =?us-ascii?Q?/ZB8ThdLzqYoDOOqrPeC6JdmwvJuxcfYMDsJDNf/pXx6h2GWCZwVTY/2amhj?=
 =?us-ascii?Q?cTQuMNjGDVHTuCoLKEuTH1mo3NQIpPfczkNnMPMAk3sgRAT+NM6qtFrn8fMr?=
 =?us-ascii?Q?ib34Q8lrVezi0WsK0ewVJds2fFmkS0Uah3I5ig/pliHdQRHgV/hjLjMAJYoT?=
 =?us-ascii?Q?FeNFCv1jC873JHGkRV95i1h5e2ktlqjIbiZ+CQK8DxMSAJv5EfMhnKQ9n1aY?=
 =?us-ascii?Q?uWpdoqz/Yar2CCuPEIfrtfBD0iMRajRjX6M+nrwdp9/k7TVuQH9b44yx2dSM?=
 =?us-ascii?Q?OQvAWk0u9lLALhfniir6UTF85Sie6royOwBXhSqskHcjqs6c1Vb8n2Fp4ccR?=
 =?us-ascii?Q?E7m+QaIxpyW1PAy1j9zYKpk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f533ff0e-e61b-4bd4-739c-08ddb95438a1
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:35:53.7948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNSB/3Fsh7Bb63bY/ECicH8qTzTYqeSH6B+fC4k/8SrGfpjO4OZuY5CkNFWMZV9sCyu/fvOvUfeX58QvVTsJgFAnrhFJjCGd60JKmt+dsJGgZzz8t58Ezcopjcfki875
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:36:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19287

From: Tommaso Merciai <tomm.merciai@gmail.com>

commit 037800c252d9c470b74d76aa23475d41e238251f upstream.

Add support for CRU0 clocks and resets along with the corresponding
divider.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250210114540.524790-2-tommaso.merciai.xr@bp=
.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 51fd24c20ed5..5d02031219d8 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -28,6 +28,7 @@ enum clk_ids {
 	CLK_PLLCLN,
 	CLK_PLLDTY,
 	CLK_PLLCA55,
+	CLK_PLLVDO,
=20
 	/* Internal Core Clocks */
 	CLK_PLLCM33_DIV16,
@@ -35,7 +36,10 @@ enum clk_ids {
 	CLK_PLLCLN_DIV8,
 	CLK_PLLCLN_DIV16,
 	CLK_PLLDTY_ACPU,
+	CLK_PLLDTY_ACPU_DIV2,
 	CLK_PLLDTY_ACPU_DIV4,
+	CLK_PLLDTY_DIV16,
+	CLK_PLLVDO_CRU0,
=20
 	/* Module Clocks */
 	MOD_CLK_BASE,
@@ -49,6 +53,12 @@ static const struct clk_div_table dtable_1_8[] =3D {
 	{0, 0},
 };
=20
+static const struct clk_div_table dtable_2_4[] =3D {
+	{0, 2},
+	{1, 4},
+	{0, 0},
+};
+
 static const struct clk_div_table dtable_2_64[] =3D {
 	{0, 2},
 	{1, 4},
@@ -69,6 +79,7 @@ static const struct cpg_core_clk r9a09g047_core_clks[] __=
initconst =3D {
 	DEF_FIXED(".pllcln", CLK_PLLCLN, CLK_QEXTAL, 200, 3),
 	DEF_FIXED(".plldty", CLK_PLLDTY, CLK_QEXTAL, 200, 3),
 	DEF_PLL(".pllca55", CLK_PLLCA55, CLK_QEXTAL, PLL_CONF(0x64)),
+	DEF_FIXED(".pllvdo", CLK_PLLVDO, CLK_QEXTAL, 105, 2),
=20
 	/* Internal Core Clocks */
 	DEF_FIXED(".pllcm33_div16", CLK_PLLCM33_DIV16, CLK_PLLCM33, 1, 16),
@@ -78,7 +89,11 @@ static const struct cpg_core_clk r9a09g047_core_clks[] _=
_initconst =3D {
 	DEF_FIXED(".pllcln_div16", CLK_PLLCLN_DIV16, CLK_PLLCLN, 1, 16),
=20
 	DEF_DDIV(".plldty_acpu", CLK_PLLDTY_ACPU, CLK_PLLDTY, CDDIV0_DIVCTL2, dta=
ble_2_64),
+	DEF_FIXED(".plldty_acpu_div2", CLK_PLLDTY_ACPU_DIV2, CLK_PLLDTY_ACPU, 1, =
2),
 	DEF_FIXED(".plldty_acpu_div4", CLK_PLLDTY_ACPU_DIV4, CLK_PLLDTY_ACPU, 1, =
4),
+	DEF_FIXED(".plldty_div16", CLK_PLLDTY_DIV16, CLK_PLLDTY, 1, 16),
+
+	DEF_DDIV(".pllvdo_cru0", CLK_PLLVDO_CRU0, CLK_PLLVDO, CDDIV3_DIVCTL3, dta=
ble_2_4),
=20
 	/* Core Clocks */
 	DEF_FIXED("sys_0_pclk", R9A09G047_SYS_0_PCLK, CLK_QEXTAL, 1, 1),
@@ -154,6 +169,12 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[]=
 __initconst =3D {
 						BUS_MSTOP(8, BIT(4))),
 	DEF_MOD("sdhi_2_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 14, 5, 14,
 						BUS_MSTOP(8, BIT(4))),
+	DEF_MOD("cru_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 2, 6, 18,
+						BUS_MSTOP(9, BIT(4))),
+	DEF_MOD_NO_PM("cru_0_vclk",		CLK_PLLVDO_CRU0, 13, 3, 6, 19,
+						BUS_MSTOP(9, BIT(4))),
+	DEF_MOD("cru_0_pclk",			CLK_PLLDTY_DIV16, 13, 4, 6, 20,
+						BUS_MSTOP(9, BIT(4))),
 };
=20
 static const struct rzv2h_reset r9a09g047_resets[] __initconst =3D {
@@ -177,6 +198,9 @@ static const struct rzv2h_reset r9a09g047_resets[] __in=
itconst =3D {
 	DEF_RST(10, 7, 4, 24),		/* SDHI_0_IXRST */
 	DEF_RST(10, 8, 4, 25),		/* SDHI_1_IXRST */
 	DEF_RST(10, 9, 4, 26),		/* SDHI_2_IXRST */
+	DEF_RST(12, 5, 5, 22),		/* CRU_0_PRESETN */
+	DEF_RST(12, 6, 5, 23),		/* CRU_0_ARESETN */
+	DEF_RST(12, 7, 5, 24),		/* CRU_0_S_RESETN */
 };
=20
 const struct rzv2h_cpg_info r9a09g047_cpg_info __initconst =3D {
--=20
2.43.0


