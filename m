Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A60C8303F
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:36:03 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.59])
 by mx.groups.io with SMTP id smtpd.web11.20547.1751452555834169188
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:35:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=qhB+G4Nu;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.59, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKJ27uKWgB4//Sb47PSy+hq4lOi7BRp+dazg47RFXwYdJucv4YIYBeN7jntX5yOE5iWplUAVa2jI3wF14pW3mFrp3jCyAtZf9hIEOLLI80/f4mPLh1aYYyXySEuuiRKAilo0iA9jP5DitkSwkQkN77aFJUgyXjfsggsNI8PELuksAxDs3ocDdeugEz4uFiCB49HzTDTwUKMOvldUr5coBivFM9yoRnLr7Iak9mqIJfFE9ZkzB8SvmlpDFJT7yw6JenJLY3Sk9oE6vAfcs0rGlkwTkp0TianqE5C9vO8blOBkYBAl9LCU25AgiIBXq64zSOJ9WJaxsDYGIfywkjfCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfEwFozWOXMtxQqrSwmPu5I7AJPWuUeUjZZXbFYJqcs=;
 b=cYUtaZAeopI/B/rEaIHsCXp7gSRJwcVtUNzrvnO07qGevJo3tiQdY31nddNPo06Y5Ymmdg/tVdNOKOI9mhOtz2tLoQXe0kcjjP5/UTqFRvWuxFjcIlSu3Z8lgSOGT3fGGXgiiEifD/1Il4SEnCL6WVUkoJaSqbY1cmdbz6e1yNIOrK4ASUHiQHOEY9dd3oE5YRMtD8wMnmQEc+MJMJLyqE1o7Hb8kwjRwPjQOMVhzw95/aSZU6VdXLciA2KKZLIUq6LmijGF9PwltRVAr1u+wESLUzuBy/460FSF7twzThvLM0usb5ACwbjAOOpSbrqJ90pDHrUpwcSHlGPbo86JHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfEwFozWOXMtxQqrSwmPu5I7AJPWuUeUjZZXbFYJqcs=;
 b=qhB+G4NuD1yFPl8f5vlQjOKitIXhj172aKXTLAHLBIGWzE58qo9D/sBbDAR7LMUy2fQ7SREY+s7461SnxMTdt4ZkkvFsr1ZYU/agGojv0uo0DLQf+EpG0Gp0YjYnWoEL6Iiv1WFcAhNAroKx3vq64FSm3Fxv+qVHJZ3Atg39JMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB14154.jpnprd01.prod.outlook.com (2603:1096:604:363::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:35:51 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:35:51 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 01/12] clk: renesas: r9a09g047: Add ICU clock/reset
Date: Wed,  2 Jul 2025 12:35:14 +0200
Message-ID: <20250702103525.117166-2-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8cae83a3-5d60-4e5a-515b-08ddb954370c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?eON1FPfocgHP+MBJjhtLbyn2YLjrCauHEm1378wayzxjVGuulqT7IW1beRqs?=
 =?us-ascii?Q?s5vKrmdE2Z+4qgI/Xwjm7bzrNmCd9mqCM+XQCV7QHLb2URE5ytIyWsFzqpGS?=
 =?us-ascii?Q?Z6+mk0SuedRxBrn3xxu+uyzqnOWT8a4oigtsuZlfWrNO13Mg5a1oER6HYlxi?=
 =?us-ascii?Q?keKCBHH738ZqeB4PyuY4Sscl9izN+cWSRCikN5/KJGGPNnZhKlFswnAYZH07?=
 =?us-ascii?Q?KqzyhdmbwWGXUH8+p8hi0kiLwQzdH9wJJvoXu99u8RIu/JUqYLqZ+dlDs6P9?=
 =?us-ascii?Q?LVYcufpGO6O6MiJ4pOwyVqAN0EbrwSDxngIR1/qte/rjISyZTZIgWCXy9Sfu?=
 =?us-ascii?Q?oFt6Le4CCTclTdCpb1Aj8ei+1+WJDPBEQeV06m/tlR0A0NPzdYLX4laoWKdu?=
 =?us-ascii?Q?HPyfUiHwHhZv4rLMHDunK86AohhGwg4+wbFA8ieltgZvOOfT0ST5vBAhPWYg?=
 =?us-ascii?Q?4SzVipIqeCS7F1wAWCCu9zJKt2PcTUHpNNOn0TfQ6+l4lV/x2IMQ3J1AxXYg?=
 =?us-ascii?Q?KhP+KftIV/GSyBHTnFog95ZbO+ZX5UsHce+dPwm0lFc1jboJVRSQdMVTBNdN?=
 =?us-ascii?Q?HmEkSa0sWsQw59lKCCQz0D7G4SSB1HFu+xSz9p2Y0kWbqoOuo7Gm3cmLqX38?=
 =?us-ascii?Q?PzFs3Htxcf/2AXRfs4JmGcYDe95vQNAWgr+2pL72V7zQYEqoLe65uLLvChUg?=
 =?us-ascii?Q?HAz+qI/CsnFSNwwRGusY36o5Pzvi+4Ga4Ntn0EUzftUSuafDjvmTbSPKALT5?=
 =?us-ascii?Q?ZPw4yLe8ddQqFwqYciPDt9nu4AgEkXueGym3h+wdAavTe/ckB2xWk4vmy3jR?=
 =?us-ascii?Q?YYrTa4rCP/OV317F0KC7BL06bN021cREg3EMFPt2PEVjgCHsyFkWGcC8N6lw?=
 =?us-ascii?Q?Vk51nUx6CwMzEot5K3Hr+xehA+SzEU30++sZjW5qoZDfXsQyjy6Q4WgeBj7L?=
 =?us-ascii?Q?Vim366zARc1N6WfV0NkB8MMKYOzgoycZlkJ8uok+R1INHB3xBVm30H9GF/qa?=
 =?us-ascii?Q?XWaBoMnk7EzBhYkMp03BuklrxycOE+26V6J6Z/yRvcyBfI/tnTmYnpXA+Mlt?=
 =?us-ascii?Q?eeZpYEh49wVaPnOG0/zGh1pCngsbXTu/NVAykTBUmTP053v4p4bVJCLT0/K1?=
 =?us-ascii?Q?VF1sgB0546anYoVWlh5LqPlhWk/Zyh9e7SxVvjJ8O3HWpsbs+C0VUZnbDPHU?=
 =?us-ascii?Q?Fnf0SPcwoDpeB6Tu987jLlU9Mbg5P+R4Is1b922HHjzHX3zsjXJIzaLQs5nw?=
 =?us-ascii?Q?TcdmAq3yr9wer6qxR6mgsEYCiwdpM7WXiWn4N3UCMPfwZ+1WNDBel87okxrS?=
 =?us-ascii?Q?RWP9iOy78eJqcqX/MKfsBGa9HcIQzAcadDjmCi2qCn9QVEakftoIrUXWOMWx?=
 =?us-ascii?Q?IexlR526V9VMVnlVztUA6r9NV+Z6ZVGKpNbe6a4I9EEJoDySm3l6tWwzZZak?=
 =?us-ascii?Q?ZrW4iVbcHpfh/akDfdCrAZLmfqNwqYmh1dTr2Zje45zXOk8V/NYDGwo5VNIN?=
 =?us-ascii?Q?ZQHRkMbSiZ4IP8U=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Y/+I/GXeqzu/3/VtcrzOKmL62NYnLtTfDc8ZO/KQjD3Vg1bbkc33PHvWglOS?=
 =?us-ascii?Q?wiuP3vocC9GLL5K4Is+i+4WAxZ/bf8T3BQymdIM3UxeSH8Gjy2HmQNMCIDNr?=
 =?us-ascii?Q?WWMq9yozs7PA9G3zNMKAbQNVTIpKaiarZ5nWU/Ew8KAh444u8aA5M6+HMqBO?=
 =?us-ascii?Q?gcNbMPaupSDgVe+6KByxtiLFWlgkR6rUQk3eS4TUA2mI81riakuvFafQjK/c?=
 =?us-ascii?Q?B/PtYALoHsSApU2x6qawF92fi/vGGneS7Xu9/pSRJJer2cwxhYLEZt4uy7Mk?=
 =?us-ascii?Q?5hD53qOyZA4QjGN4mKJpkrLyeE0fKnFzMjBnnZa5IoNRPUwnDyuGTHKdLnMo?=
 =?us-ascii?Q?oENbJ8p1vMB9p2oTxta0jsOukg921GvpB5nIaoqtNWuPsFbHfA//Ju/aYrH6?=
 =?us-ascii?Q?Enj+FOV72fhSfGqgVPykZftiABfjSSe+n8xcVSwP7wV6aLBCyv4+ukA02+40?=
 =?us-ascii?Q?hPmM7uK0i8ErCl1oFdjkfE36bNvLFZPbWTegxzmjG9d9scJqOb+lK9rcc2y/?=
 =?us-ascii?Q?IFi2zcQeon/I4phqLz+VIbM3tYEtFTU41BvemgIFeAvvCd8U262pW/zzDkKK?=
 =?us-ascii?Q?/M5Bklf6eYCzKzHofW/PYWmbXHZiwePOh9WrtWN+f+yuDyellayXQ9Ue8x7B?=
 =?us-ascii?Q?6oZtFjn90t0hgrFKOpSNiNIxY/odWri3Ve42gXxSkBBCDrnZHn0zP38hsx2t?=
 =?us-ascii?Q?c5cHlubO79L46J4xbftx+otICpBBfFcHvHiytWA69jzbk7FBWOKq9NVsfbt9?=
 =?us-ascii?Q?q+t3wKOHtcrC4JDUnZzybh4t001Dl/hl9Uxys38eoY4bHobZHtM0y17GSw9D?=
 =?us-ascii?Q?hxdwE065Lr6mzipXu2vrIop/XCGY4VyuUztsX+0RXRoGljuENuHW1x9y5Djy?=
 =?us-ascii?Q?WfXvhc4LdoMXgZdmLQmzlBMzT6dpEW8bpTVyxpW0Kr63o1s8RHlhDteo+4zw?=
 =?us-ascii?Q?cbOqupKlxVpHE0tjoR2UAG6uAzGMyCorWk+ggF74M9+Z45CwX3FEW2uvQXB1?=
 =?us-ascii?Q?sMrycyszMRNux/JK//2f68sthGskBuWhThG6wlH+szNXJZK+bCLA7A3Zddtd?=
 =?us-ascii?Q?0pRcTR8nEQGxe+wSYvJ9YAywN+Kg7IXkIg383kCV1OAj5P/WGsT9H1tlpT9L?=
 =?us-ascii?Q?Vj+HOGniWYQ5pmMdT3cXAW1lAR0MeW3ruf8ywst6oMoHJbuXNpMw6CmXzlhi?=
 =?us-ascii?Q?TkaPXlnaSKexkG5P7KaxHDdr8Mii30sxOfXWjDpc0gGd+ttpt7R5yUs64vua?=
 =?us-ascii?Q?mpkUYmHEHNXYzu0kAqCp869MwVO7PiR+rEoOHZtyuQS8E6/SpfD2EkNKtmRD?=
 =?us-ascii?Q?Fraa4uu2ZnQmIn5AC8Eho0eg7mSa9PJ9IL6IrplVHq0GTyw1/JMWchPX0LBU?=
 =?us-ascii?Q?6xvu+1tnluWnHgw0YKg51L29WKAKBrdV0HUz63MNEo2NS41NSlFs1ScN8MFP?=
 =?us-ascii?Q?oYJSf8nTCvv/MsSYPkHfOEGbKdrmpFon033V+JFVUhULLLwpa0SwUFdaujbg?=
 =?us-ascii?Q?Efpr+Z2nqSvnHii50eJy1mcUZnaEI6dFsB75GpVD6ZuUfPIIl6vWeg81y8qf?=
 =?us-ascii?Q?DGLY4J90GWw9b7DCn0q2VfMJb94JHHMZBs7aLkXRfLTpXD5u57Z2/WsVN7u2?=
 =?us-ascii?Q?lyZ6Z90D9lCZztWFkvEjyMo=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cae83a3-5d60-4e5a-515b-08ddb954370c
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:35:50.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BP0K4hVZLfclkYm9UdpClE/nlOdebxE0VZC5W+N4jk3XMWohaxNdz9Tlfm7CAVUWkjB9NlboBer/cDqMNe2LXabSKMqCde1Mt8cmLnSAotzMWtFK1W6VSy+INOm1m0QX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:36:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19286

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 5a1cb35ba37ada76ae486fbac7b249322dd1a5c3 upstream.

Add ICU clock and reset entries.

Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250128104714.80807-3-biju.das.jz@bp.renesas=
.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 133582317490..51fd24c20ed5 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -94,6 +94,8 @@ static const struct cpg_core_clk r9a09g047_core_clks[] __=
initconst =3D {
 };
=20
 static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst =3D {
+	DEF_MOD_CRITICAL("icu_0_pclk_i",	CLK_PLLCM33_DIV16, 0, 5, 0, 5,
+						BUS_MSTOP_NONE),
 	DEF_MOD_CRITICAL("gic_0_gicclk",	CLK_PLLDTY_ACPU_DIV4, 1, 3, 0, 19,
 						BUS_MSTOP(3, BIT(5))),
 	DEF_MOD("wdt_1_clkp",			CLK_PLLCLN_DIV16, 4, 13, 2, 13,
@@ -156,6 +158,7 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[] =
__initconst =3D {
=20
 static const struct rzv2h_reset r9a09g047_resets[] __initconst =3D {
 	DEF_RST(3, 0, 1, 1),		/* SYS_0_PRESETN */
+	DEF_RST(3, 6, 1, 7),		/* ICU_0_PRESETN_I */
 	DEF_RST(3, 8, 1, 9),		/* GIC_0_GICRESET_N */
 	DEF_RST(3, 9, 1, 10),		/* GIC_0_DBG_GICRESET_N */
 	DEF_RST(7, 6, 3, 7),		/* WDT_1_RESET */
--=20
2.43.0


