Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E288C3DA4A
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.10])
 by mx.groups.io with SMTP id smtpd.web10.34452.1741778703331941954
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:25:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=vb3Uhibw;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.10, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/9P4SxpE69rknDW3TT7L9M/eA0uY5BYTRsGuoDOsrcyuycuvjM8lJFf1eMjLRiXlSdfnHxa9BOu9tatSes65LAUjHKGzrgpf4zUMl9vlzm13+ugg+3p9lWkTA6A3BRMBumEdCNYedwhndufD82V9a9Z0Yz9GeLDS08SEK6dqX0vnkBGMNVSdN74AyR0WsYoYmvD+plFYn21kdN7JYz0ejle2ty+2sQKWlrHn+/5CP63MTsmRvItEceCgtdi24FxJq2p5v6bPkdRDMHOoMct3VEql1Vuj7sfLy//kbTpyZ2vSvRFEnQT+2GB5cGAUgCU4q5jjrrDPQGSxSG0rwc9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JLxfKC1Kuoi6LhviUeE3Smd8wWGnKmLoMQf8EP7c8w=;
 b=GQWzcdONO5WE9LR6pyX4YpV4G7IWN0PyWlG2jFyUMHN78w/JBMqs9b8DLhbgDiGgIUrIhc9qWnzQcDjEPLtmjkimajDRU1ZLDAJcryPeQaKTZcZ/bKPAy07u1DZ0n5Cc7kROQf9zdSouHp/x331StXfpMQfFzQVbG8+wcxEMX1Z7vslHaBqOQH7j5vsm1DQnJJQ6qRQGp1WI1hTws069bMaXDBE/a//mMvssKZ9xJOWBfGwUTXTaa0F/2evQdXfocMBQQV1V05X9QHE1TSX++3C5kNoc6f8rfHVltNUVHHwtzeP2yR6wo6jRRZ7CROJGxAM/PhKCWb7K321HArVbBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JLxfKC1Kuoi6LhviUeE3Smd8wWGnKmLoMQf8EP7c8w=;
 b=vb3UhibwYcCDh0EuFl10CZ2fWX5q5iOoK+v7wtHhceu6tMfggRy81bSBgju+8pIVjMfpZpxTMxomh+d/PoyBQBaTkkjvImsWpQJ71S/Wmnc2kjkUmrn0KLiGpP5bxC0LdZSpCk7TK/qXiPcfC0NXLz6wZE4qf3Gt6LAUg/ScMy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12752.jpnprd01.prod.outlook.com (2603:1096:604:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:25:01 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:25:01 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 29/85] pinctrl: renesas: rzg2l: Allow more bits for pin configuration
Date: Wed, 12 Mar 2025 12:22:06 +0100
Message-ID: <20250312112302.1605750-30-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12752:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df8d923-ea7d-4ac0-b58a-08dd61588752
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?l/wWNUlGOvavxzxJHg6GL5SM28KKg/DJq+YCvft2KChSg1UQLeIpuOFWymBq?=
 =?us-ascii?Q?N3nhiQPqkSmiHtIoebpZrWkwIoKIJeueLyYmiOOaN1yZk/SgF0ShUfG2qUHW?=
 =?us-ascii?Q?qcYcsRc9w1KXBkAtspBYk1JgtoP7S6aS2Y+b695UDBS2n2cMYvSRZsen7ae+?=
 =?us-ascii?Q?glrGdw3uXOadkO6B+NA6OGQL0pXVXqSbE6tLXmgfdF3rCNxN5/1JO55JCp4W?=
 =?us-ascii?Q?qI8ZOsCQh5MO7MBhl0xopbNZJ+BWM7nvpDHM4o30IsY613wso1Lf2qWDOP9Y?=
 =?us-ascii?Q?zMLpJBFSeoT5Yfa2aBDEWdfdzIKgYlhl3VB3m488YR90JKgpLsu+T5m+oClo?=
 =?us-ascii?Q?Nl8T8cLix/HpD6JCcsWscMaL+TS/PCSAtGd8tQVA7elYyVtq2s+G0yk+7Sf6?=
 =?us-ascii?Q?2SX+It0jK2ucBottdyQ4fkKwVgI3DOSycxn+rFyWVVoOSYAMlezm2XcjO48I?=
 =?us-ascii?Q?jfZ80ZvbM+vaZ1GU7mpVzOBU9IRoeryQnTtnwwNTjT90Y+txs+vY3uXxK8I3?=
 =?us-ascii?Q?+unuU5u5JYaBWrGYSVtsccHw6MMJ3LEcHSP0/A2tj0v1A9UWkx4Hxr3WxK5J?=
 =?us-ascii?Q?ouMW5BrgQnrIZmnwt13Gw3ZQXxtdrSa/xYuiLG/xH4wWZ3Ryz2ibBwBRnv6U?=
 =?us-ascii?Q?6uVZmfqkWotmjQRAOB1iQg5Wi0nnLhXepQkLPRduaaA7vMeOHwUwWqc8vm/y?=
 =?us-ascii?Q?o0UyiDIZt55fwbj8zCb3GbjDS4jV98gmix2yL2iEjIzKNpKad1NT99f0T1e4?=
 =?us-ascii?Q?+b1w2HbVlaEWy77BA4UKTCNuElQ35zF/65qFDvo/5cb9TNdnoB3M2Ey5fwBN?=
 =?us-ascii?Q?fWhC9ZbQKFBTltgEHsYY6GotCzeE2lu7gB2F9+C0Wgg7WzIdnYrJ4uIe4cje?=
 =?us-ascii?Q?PlucJZe0nqFkBTXwyP3WiwtDIItHWbwvvvrlQA4QCNgV+ZmpuoB2O3Rx+WqH?=
 =?us-ascii?Q?Peth7vL3BEelh0kd3H28832+gB4CfVPupbueqrGfF8pRt2ILsLoMtUakOjpR?=
 =?us-ascii?Q?T6uD1LCCYsDjzLbHjbFxdKsLXyYWLx/JMuaY/3z6P08w4oqMWOjcnHirE0We?=
 =?us-ascii?Q?SjsgGvWd8aZcTChRoq62Z+bHrt5zGH7Ei8zv9dMCjnHJcHpiBnFuMYPtE1KG?=
 =?us-ascii?Q?ZpaAXbt3/PVl8lvjkn4uXnD2WvzdvmzvUvr/dG2P5pWUZV7TIk5egUt2KUAR?=
 =?us-ascii?Q?WjnNfeoMaOvdRPRa4O5E4HciAJkOwoVIcLtcwm0pemj7uNWtqJVd+T3qgdOj?=
 =?us-ascii?Q?v9FFvV0pKk09gvgIVn99kGIh6XKLfyA9BB3YzIZyEl7TxSa39f0W2F21zIi0?=
 =?us-ascii?Q?6eVttiz6ZHdvLQml6N7+mhodb9wAcVCX7gaesfQW1QmtggTe0TfmBw4dRwxI?=
 =?us-ascii?Q?lOnQrcze9v0i0SNZH9Kjbj9HMx4shLOfbPC8ZnkyOcFEbMoRMjdfjYJ/fZYZ?=
 =?us-ascii?Q?LZkQdpFIFEwgWMF6Mr9pWh6ktqsXjBES?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SMNO6Y+KRKFajan2QNlInr91Va31KmvBU05Pyq5zziutFxn7jFaid1wdX8WG?=
 =?us-ascii?Q?eRe1COOjDzAtISwiS4uPhBxQGZOl+dGoSb3+yKlEVc6IPc8vCyW5rw41h6uL?=
 =?us-ascii?Q?izYCPWJHF5L0Bh17BMSn1dU7P7+cEDYLyYZviGqjp3T23suFa5xxH/g1DPox?=
 =?us-ascii?Q?QSOY3c7lVFr3F4zipSSTLa5IFmMXPA+VIBO1VhUnKQf/z2FfY4NvqfYrTGLS?=
 =?us-ascii?Q?Me1II/iZnNzKYPdettVRR43dGaH7XuwtxMGhFgNHjzB2ZQ53DwY00k9V358u?=
 =?us-ascii?Q?m03sz4y5TBMRXfIXLK3dt1eB4Z0vkRubYMGX2OsGuzYIuDaPV04MmI8HAO5u?=
 =?us-ascii?Q?WMHkof5bFBR/VOn5bwcY13NcJ2qp8SogG0DPkoVYhQWlBR33G+kBZ7N0VZWC?=
 =?us-ascii?Q?aRlbpggqZpXOU/CyILBLjf/pcQayDJYu1BJD5siqRD/EwjmxY88/QHrW/zhJ?=
 =?us-ascii?Q?hPdWC4NscNpimL91BpBbHo3lKFLluEkZrPxKNpZvsX2UvyWpjuxrZE4HGHDl?=
 =?us-ascii?Q?ohVp6E3b0kb9foVaPnG9AGrxYQqPM5TWyj5lZ2DzB4SRSqLCdFvfV3XamEN4?=
 =?us-ascii?Q?b0nwI7jGe+o3NVQ8Huyn0XoeEi16mLUiqofVhkje5Df5NWgRMsR/WLfAKcrl?=
 =?us-ascii?Q?K2YDxPMJYNHVdWb+GbENM+ZGof7tU81uxmvANwP7K5CQtFPX71ANfbiJkhWN?=
 =?us-ascii?Q?5PMcuqWaAJxoiQdP6c+ToKiZXpDsNPQ9JGGr81h4MnAj+SDGYPTBsI/O2leD?=
 =?us-ascii?Q?O4a312I2A5xajYEJsS5wdnfhUkTSdsISlFnIAvYU9JhR8+3l0JQsqyN1TeH5?=
 =?us-ascii?Q?EdRL3Gio/j1a8mUjxdiZP4r5J73Mtfx0QKyY9wur7mmRLESg4BM0dqtLltNG?=
 =?us-ascii?Q?v+bUWP+1Qb0yF6EfccanCEHytlMIElUYke0vwNhwf3vRdxPBM6+oSP4qDN+D?=
 =?us-ascii?Q?zu/cyUZsZZYtJpjxBdfLm9kqSFI9r//+nZ0hLWhK8MpGc1F6z1+ZPEYSJ4Wy?=
 =?us-ascii?Q?60tBHueulLVBGwq/gmjsPgpUnSoKFaeIlG08E4Ok/czorjiHIa2qSlFpRb6A?=
 =?us-ascii?Q?/w9ySJmbEAcSyJE1T6ATD2ELUwyQuTL8CHAIYShohG/EpCTnAPewieyrLmEz?=
 =?us-ascii?Q?c/3wTLD7G1wYhnzvCSL2pLOafGwZsx+OQLg53loGMB5R6ivaHaqtl5nQaQLF?=
 =?us-ascii?Q?HAgIoOsDdZKaiCoDgG/ZXunkZjmDUHQkiPHLWGSKw4RLZ0yRhbuUVzsMsQZi?=
 =?us-ascii?Q?G7P3p3eyIkp2SmpDoLgvolU9khglf4SxEUFOEQYdORQuDwgRhy8wgoCxjenh?=
 =?us-ascii?Q?fLBwxADikh0OJzg6dYRfH3RxUkMVhUmGEzZe7DeMc3nu7XCp8AcIirXM9n9r?=
 =?us-ascii?Q?TRhv1FTC3qToNqs/wKFAEwVaEF7PMqRE2Kifc9OFP//GmNbCvgkGb8MWWjkZ?=
 =?us-ascii?Q?T+PTlJg5xtKVBsr5FFKOcKI/Pr6etSZFekPjVO6xBvS5dMm546HOUY/n9tV8?=
 =?us-ascii?Q?ZJxWudJ2N7M9F9x5H6CfLwrgVC5FCOH+QWz1f8sFHSqyMrKmRzc2FJ5poCDw?=
 =?us-ascii?Q?qLkYqxmbrSt2LnZhpV0tkWmKrwbNzGWyNJXCtqaVZezG/Ha41y87w385Pg38?=
 =?us-ascii?Q?3ZBgmXc0zkIcgjYmXPXSjLk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df8d923-ea7d-4ac0-b58a-08dd61588752
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:25:01.5348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUbtqg7T1E9LwfqTIjJKH4ighmj79nLaKuwBbzXTQTw557hbFnG6NbAsnJeI3dqNa+cDmRVZTZptBoqJfxOLFPOTfX8Imhks4kM7TqD1reBrM7ZAYkdhDKNr6E3Poi6u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12752
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18121

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 8081a03793d3276c50d55a6f561872168eccf944 upstream.

The pin configuration bits have been growing for every new SoCs being
added for the pinctrl-rzg2l driver which would mean updating the macros
every time for each new configuration.  To avoid this allocate additional
bits for pin configuration by relocating the known fixed bits to the very
end of the configuration.

Also update the size of 'cfg' to 'u64' to allow more configuration bits
in the 'struct rzg2l_variable_pin_cfg'.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://lore.kernel.org/r/20240530173857.164073-4-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 30 ++++++++++++++-----------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index cbb4780fb2d0..33eff02c6206 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -77,9 +77,9 @@
 					 PIN_CFG_FILNUM | \
 					 PIN_CFG_FILCLKSEL)
=20
-#define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(35, 28)
-#define PIN_CFG_PIN_REG_MASK		GENMASK(27, 20)
-#define PIN_CFG_MASK			GENMASK(19, 0)
+#define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(62, 55)
+#define PIN_CFG_PIN_REG_MASK		GENMASK_ULL(54, 47)
+#define PIN_CFG_MASK			GENMASK_ULL(46, 0)
=20
 /*
  * m indicates the bitmap of supported pins, a is the register index
@@ -101,8 +101,8 @@
  * (b * 8) and f is the pin configuration capabilities supported.
  */
 #define RZG2L_SINGLE_PIN		BIT_ULL(63)
-#define RZG2L_SINGLE_PIN_INDEX_MASK	GENMASK(30, 24)
-#define RZG2L_SINGLE_PIN_BITS_MASK	GENMASK(22, 20)
+#define RZG2L_SINGLE_PIN_INDEX_MASK	GENMASK_ULL(62, 56)
+#define RZG2L_SINGLE_PIN_BITS_MASK	GENMASK_ULL(55, 53)
=20
 #define RZG2L_SINGLE_PIN_PACK(p, b, f)	(RZG2L_SINGLE_PIN | \
 					 FIELD_PREP_CONST(RZG2L_SINGLE_PIN_INDEX_MASK, (p)) | \
@@ -240,9 +240,9 @@ struct rzg2l_dedicated_configs {
  * @pin: port pin
  */
 struct rzg2l_variable_pin_cfg {
-	u32 cfg:20;
-	u32 port:5;
-	u32 pin:3;
+	u64 cfg:47;
+	u64 port:5;
+	u64 pin:3;
 };
=20
 struct rzg2l_pinctrl_data {
@@ -1081,7 +1081,8 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_d=
ev *pctldev,
 	const struct pinctrl_pin_desc *pin =3D &pctrl->desc.pins[_pin];
 	u64 *pin_data =3D pin->drv_data;
 	unsigned int arg =3D 0;
-	u32 off, cfg;
+	u32 off;
+	u64 cfg;
 	int ret;
 	u8 bit;
=20
@@ -1185,7 +1186,8 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_d=
ev *pctldev,
 	u64 *pin_data =3D pin->drv_data;
 	enum pin_config_param param;
 	unsigned int i, arg, index;
-	u32 cfg, off;
+	u32 off;
+	u64 cfg;
 	int ret;
 	u8 bit;
=20
@@ -2413,9 +2415,9 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_=
pinctrl *pctrl, bool suspen
=20
 	for (u32 port =3D 0; port < nports; port++) {
 		bool has_iolh, has_ien;
-		u32 off, caps;
+		u64 cfg, caps;
 		u8 pincnt;
-		u64 cfg;
+		u32 off;
=20
 		cfg =3D pctrl->data->port_pin_configs[port];
 		off =3D RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
@@ -2459,12 +2461,14 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2=
l_pinctrl *pctrl, bool suspen
 static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pc=
trl, bool suspend)
 {
 	struct rzg2l_pinctrl_reg_cache *cache =3D pctrl->dedicated_cache;
+	u64 caps;
+	u32 i;
=20
 	/*
 	 * Make sure entries in pctrl->data->n_dedicated_pins[] having the same
 	 * port offset are close together.
 	 */
-	for (u32 i =3D 0, caps =3D 0; i < pctrl->data->n_dedicated_pins; i++) {
+	for (i =3D 0, caps =3D 0; i < pctrl->data->n_dedicated_pins; i++) {
 		bool has_iolh, has_ien;
 		u32 off, next_off =3D 0;
 		u64 cfg, next_cfg;
--=20
2.43.0


