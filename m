Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4ABC7EE39
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 10:28:09 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.22])
 by mx.groups.io with SMTP id smtpd.web11.16546.1750674485062861037
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 03:28:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=fLXFAxj6;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.22, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5RpskmGIUWz3+y5R72oUxFDNfEnX6wL35l3O/oMv7Nn15hyIKhPoa5O46j5xrHuy1quR3BexRmDHjdirdsImR3uxjmW4Dm/biRA09dCXKzI4+PxvnqGpAlANbDvTUJAusCyF4a66JAdVWQ4ZzcuyWXQZ66xFyGOh6Ap9t1dAzh8YAtwGVI0WlAOC4fVkWWXS+a0PesdGUyYoZIaYoqwAlBt/23Fu+g5aLLeR7eDXQbmPSxEnoLLIFodZ4pj5G/PTmoG+tkHgaL3JWwH3IMfYfVjOPwfS4dyPg9DgeUupTzMd3D38acnsFGYHpSYo5t1Ec1P2fm7f64o3Tx8gQhmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpTbtUKXsjuG+Fj+J/Ud3Pn9yzRylIAzwWcf/0pYaJ4=;
 b=Bi3l1nNiJ/iVV2c+6hkvQM9eBkW+WpHnZFlmscD9fUuoAL14HTa0/95Y3H7UwjCJYe9ewT+P/abF5LJvj0DlGle4uRSr+gdYzUdCW8nbxejuKTKRvknyRTqYnf2r8w5nPizlrkKJXH6VImah78YgQp5xV871HAtIyMY0I+hH42zVlnwXQ8n/0iUnpfmk0ulmZ6euzX3gWLXHyRekzS54uYyJ3vj74nkfgvdfovcCxSVBzI5o7xVf+we+awOcrM69X5ETTsDwFN1sfBUXUdRYehAIyeVYe/rFUdG8AEAxsRyg4zPK6Di2s/L6h/XUFrcM/aryUo/+XnlSClbsnX2sIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpTbtUKXsjuG+Fj+J/Ud3Pn9yzRylIAzwWcf/0pYaJ4=;
 b=fLXFAxj64RkZeQ6NReFS0YsdniJkYHqpeFvIccUrSI4KO9XrIunPiQxzdZCfbueRCQYQvTKyfy4vtUz8jlsTdvrOSLnhfAFlrL+rwV6sC6nSNl7VtCZppMEyX2xqpuKzYZFKpF7nEUwUgxtibiJ5jVsS0FKAlyWMBfoPPOhfonM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS0PR01MB5747.jpnprd01.prod.outlook.com (2603:1096:604:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 10:28:01 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:28:01 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 3/8] clk: renesas: r9a09g047: Add WDT clocks and resets
Date: Mon, 23 Jun 2025 12:27:25 +0200
Message-ID: <20250623102730.1493286-4-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3fe66b16-5dd3-4aed-cfbc-08ddb240a169
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?D/zJZ9K48j6qJBmK+wGdInm339bhRuR/RzwLhTEQcmDOAUyYV4OV36sVZyXB?=
 =?us-ascii?Q?vMUojog3d9Ajr+z57iDBfsUHHnVKYhnpkKcmFUv1GrWC4836yq+26+1WpSeE?=
 =?us-ascii?Q?D+UTdc6OmkhiNIfJNxblnsfoonclW6bxEykuYMKNqPKIFQrpjmsdopzXvocM?=
 =?us-ascii?Q?ydYwCBSlTVzhJ37SH5qlO3Cb+XgIARjaBBxO5/Ia5H+nv6Q60qX8bqDRPvcI?=
 =?us-ascii?Q?AlbgUKUSSiJ2fZZ0eOoQmUwr38BU7AJYvcuOhGGGRovUevOl2Chi8SCAPAUl?=
 =?us-ascii?Q?PNfB3OSp+rJy8KHUjILFtziDAPwjviqQKGEBsYc68anaz6YmWpM//jip4G0s?=
 =?us-ascii?Q?LcKwD+pdpQ+GSeAq/k0NqvH3LOYB9WORSvCb6JWqR3EupDNb4sVNbYEkUGJ2?=
 =?us-ascii?Q?cSAVmto+pMOzWMv+mXSf2seuhd+aMfMpZo290Q7G1Qn8nTVlWyDwNouhlv8p?=
 =?us-ascii?Q?9ikI5vHa+KnxhtxB/QPXE5HQ/mZzlmPWdO6rkSCCMBF6dM95zu9AqlPhKFTY?=
 =?us-ascii?Q?+W6n6Vc14dd89p+Vg4HL9Bsj7gNUKoL4d+mdYJaWOFz4FXdwCz80sXzA9aT2?=
 =?us-ascii?Q?vRICv8fd1xT/TBHQsrx5wFco4zVEqvFJEyFJ4k3++aiwd/s+55wsibQOS0Pg?=
 =?us-ascii?Q?Cn/juNUnEdbE9z7iibUqfkhfh5Fs9HzIBTtcX0bTtybwLdLf42eROXXSNDeG?=
 =?us-ascii?Q?mSK+nBZHXqZE0zMJsGjQxga9/CqjOtfqSFexjoTTRN0TX8iC3W47ZlNHhN4S?=
 =?us-ascii?Q?aSlUhRLvLdomWLJqyzH4RHNsgMQ0MiooBmLCLXE54Hrw/9/kO+mlAjrbDHXX?=
 =?us-ascii?Q?pHXF9AEvVYt+EWlgB2LosE7c4ojMn1an/O+pUF0GrDWfZ5APAEm0c39Yng1W?=
 =?us-ascii?Q?zwRzjB2ZH+uF/BNPd7ynlJJMdgOrlRRYihZhVue7hDnlsiTueTj7bEENf8pr?=
 =?us-ascii?Q?igY8wlxKRenR4H4k/8+m1beYv+Kl8sW38eqN2ljC55bgxA/7/9j0Rf1EC9B7?=
 =?us-ascii?Q?sUK/I3UGy6ok7g5wkI9/SVbVezSya5WiCnKQoKwsbdr2WxLnptR3w+ZSRut+?=
 =?us-ascii?Q?sgMC/70vTZI9uTdCm/mGRDbfHjpPbmkgGLPmT6pT5GeYXMMD1wSU2RfPU72k?=
 =?us-ascii?Q?CG4v+P+o4LZAIFtfAHQss22fR2My2XolXLj3+r+wTnleWnE2ihVlHAOTcocP?=
 =?us-ascii?Q?nxqsjk4RkWCs7+o7Y3CsXafoz9gYlxP9wUUEaX3pNIvG/ts+M4qjZNlOcU1q?=
 =?us-ascii?Q?OR6XGtjPP6rmfGlWmxlqLOqY9WHP2IEmPJUhTe3VyIt9ZJV8dIPVTxJmDY1s?=
 =?us-ascii?Q?taZbKs1F1uyy0uugs2p8d4qTg5lBkzhAFsW5fISUMaCh4VOgolvEAcggmIaY?=
 =?us-ascii?Q?6kXqLR8uKO9Sr30qrEK2M55I0DOFKWhANtd8zmTT51+3turwEs5ct7DAoYmu?=
 =?us-ascii?Q?bNtGsAkc6g9tYufinMJorI1SiS41ynyxoqcMvJjvzszAg7l9DZ3Pz1Dqa0ZR?=
 =?us-ascii?Q?m3UuOwrbubsNQfo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OBZJonsuUBh9LR5rl0fPfQcgmAhU0sOTylqLeuzJWqAwWYwKlXHJ4Bsj2+cz?=
 =?us-ascii?Q?1XGzdH+sbA3C8y2XLecKneoBioY5I+oJHQa0/3kIwLyve33MO4drexigGMRH?=
 =?us-ascii?Q?Q56MAEuXD7PEEY09pF9mGZQ2rRJFcJbTW4lRBO1AmQLtUUACZ/73mufD3u/t?=
 =?us-ascii?Q?xA85gUZLQ869AE9eyhoKt3gRBzYr1fyiXWTxeDWNxz+xWfYTdWHCKKtoInQj?=
 =?us-ascii?Q?0bYP3NXxQ/LvkwUWglQjJ2PWn0J6tb/4l9mjlkVITnY6ia40Z1HqrMmJQQ//?=
 =?us-ascii?Q?vUk1AGVNMoJufDFMEO0EHWzCBkgDwn9V0iG2egNkkeKLSbi4/GlNGJl1Oyto?=
 =?us-ascii?Q?LIxiYTH7UW1K6L58KEPeloztAMfpLGmlSb57tIFhQLyVMgBkzaIMYLLZ2l83?=
 =?us-ascii?Q?S/jgT+A4m16zdpDSkmI9Tw8GFW9WnArcNPLuU0d6iUnqVXQ90QKm5SyYylVR?=
 =?us-ascii?Q?qbRNLaujXR3Tl4PkuIQZBYX/qVjVoipFYpk9l1BUi4FxtjmOalzYdf9Toe3H?=
 =?us-ascii?Q?zzNyvWpSd7LTTIvSGT8NjYFiDlb+w1r1QDlhnE5WYDEYVMUDBsCpmCqQ+rAk?=
 =?us-ascii?Q?yiNv8UwBcY00B4ONxPzPqPDpOVw31e994lmf7dgipgMTW5Lh2NbwmLV918//?=
 =?us-ascii?Q?f0EncRi0TZnxHbEBMAEz025g7tOT41kz7VEdDZrco4bBcPkcn/xstvTT2jRZ?=
 =?us-ascii?Q?212bv35yC9BwB+ClyOkpJrprIXwVdltYTLTPHjl8tiTe9MOBUW1JxQtap7YH?=
 =?us-ascii?Q?pfrLwUMFJvTJZ/8E5segNT1+wqRCJOs780geoFB3sguOcLeWrGzoLsF/NCEf?=
 =?us-ascii?Q?9ZgUJYt37zvpkS7CTqdaWJ1DZqFPfGlwHI5el8F2Q/RjCmQ6Lu4HV2lsv4k/?=
 =?us-ascii?Q?MQwRONht7CWtQ2Z7L8C9f1cQeGGNvV4E8nV/uxk6vcZJvx/DnUagkxVb/KKE?=
 =?us-ascii?Q?KJNYU9x7gX+FvnAM2CvrOgK31o8XPbCO+1FD1/chJhC605BANR+pNkWVLMnK?=
 =?us-ascii?Q?AGQ2Kc+tkmkdwAoa53hMs2sDFvDdeAVzQF96ZBEgFGO1fKg9Mkbtmm2UadJs?=
 =?us-ascii?Q?KRRBJXwybt90lOuATAuHuNNr5F2R0SWsxh8mVztlp1eeiQYpiV1XfrS8CM8b?=
 =?us-ascii?Q?9WfEXwNwGn+3UIm/FcdsLeYbBQsHYoOTsfdUPWLAjzLJO6a3KjUpKuXBqDMI?=
 =?us-ascii?Q?+ZP+yNbaah9RvYrEQjZIeLUxLk3Mb3iC2wbW6wNBItBRvmN3IKZiT+v0Y4PP?=
 =?us-ascii?Q?Gc/ZspGvP0A8FA394gsVlIT10APAfhd8fra5RceQ8PnKB6wYGrzbnmKRnrwk?=
 =?us-ascii?Q?KrLtyICV8O29roe/4ykg8yWuocofn4RcSaHmA0GacvLnKelt4uiAh9oxs3ok?=
 =?us-ascii?Q?IG43I8ArLuQAiVHR1oNuzaxVYmVGoKAY3SNN4k+g/p3wKURQhf+Mqyn8/fGI?=
 =?us-ascii?Q?2HzKHgEFTspjHF9d9nBNCQLNOF4lhmN+sgzJta3CrWQQbQCM007FtgjsZSSo?=
 =?us-ascii?Q?I2U3zm09Wluuus2kbAbYlSs4sQ5gcvC9X2aUSChVPUX2u9J9iRfDKEKAAKQM?=
 =?us-ascii?Q?awuwpfe2nUzXjK5GsZvX7hQ/BZdThT03fjuMa7NIpyVm3WnAK22z8nXxVAch?=
 =?us-ascii?Q?H/gTD1MH/Kg6fx5cELAHppE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe66b16-5dd3-4aed-cfbc-08ddb240a169
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:28:01.3383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TI2iq95sl+vFNR7gLnGGDYKTF83VVNkm+rWoT5n/OcwC9O/E8TqgjPzmE98rQNPCq4v8QZjDRrMhbhn//UYzgvO+dOwUVlCJMzRkkmgY6bePMoE53EYJTg4rfG3Ixv3s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5747
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 10:28:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19168

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 3c437d906f997a4e1495f59773b9a2544fff69ce upstream.

WDT0 reset is for CM33.  Add WDT[1-3] clock and reset entries.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250115103858.104709-3-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 536d922bed70..1886eab9ef9e 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -92,6 +92,18 @@ static const struct cpg_core_clk r9a09g047_core_clks[] _=
_initconst =3D {
 static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst =3D {
 	DEF_MOD_CRITICAL("gic_0_gicclk",	CLK_PLLDTY_ACPU_DIV4, 1, 3, 0, 19,
 						BUS_MSTOP(3, BIT(5))),
+	DEF_MOD("wdt_1_clkp",			CLK_PLLCLN_DIV16, 4, 13, 2, 13,
+						BUS_MSTOP(1, BIT(0))),
+	DEF_MOD("wdt_1_clk_loco",		CLK_QEXTAL, 4, 14, 2, 14,
+						BUS_MSTOP(1, BIT(0))),
+	DEF_MOD("wdt_2_clkp",			CLK_PLLCLN_DIV16, 4, 15, 2, 15,
+						BUS_MSTOP(5, BIT(12))),
+	DEF_MOD("wdt_2_clk_loco",		CLK_QEXTAL, 5, 0, 2, 16,
+						BUS_MSTOP(5, BIT(12))),
+	DEF_MOD("wdt_3_clkp",			CLK_PLLCLN_DIV16, 5, 1, 2, 17,
+						BUS_MSTOP(5, BIT(13))),
+	DEF_MOD("wdt_3_clk_loco",		CLK_QEXTAL, 5, 2, 2, 18,
+						BUS_MSTOP(5, BIT(13))),
 	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15,
 						BUS_MSTOP(3, BIT(14))),
 	DEF_MOD("riic_8_ckm",			CLK_PLLCM33_DIV16, 9, 3, 4, 19,
@@ -118,6 +130,9 @@ static const struct rzv2h_reset r9a09g047_resets[] __in=
itconst =3D {
 	DEF_RST(3, 0, 1, 1),		/* SYS_0_PRESETN */
 	DEF_RST(3, 8, 1, 9),		/* GIC_0_GICRESET_N */
 	DEF_RST(3, 9, 1, 10),		/* GIC_0_DBG_GICRESET_N */
+	DEF_RST(7, 6, 3, 7),		/* WDT_1_RESET */
+	DEF_RST(7, 7, 3, 8),		/* WDT_2_RESET */
+	DEF_RST(7, 8, 3, 9),		/* WDT_3_RESET */
 	DEF_RST(9, 5, 4, 6),		/* SCIF_0_RST_SYSTEM_N */
 	DEF_RST(9, 8, 4, 9),		/* RIIC_0_MRST */
 	DEF_RST(9, 9, 4, 10),		/* RIIC_1_MRST */
--=20
2.43.0


