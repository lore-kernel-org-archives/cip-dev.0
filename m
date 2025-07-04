Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53109C83F03
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:06:46 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.34])
 by mx.groups.io with SMTP id smtpd.web11.8454.1751619999565590256
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:06:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=o6nIPyNr;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.34, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZoXZoDSDUBAPhyX54ENrX3XXY90ORocDUUBe074TyOp0bRdfhEY3CIF48AT83AQCdHuXBCUrBpGe964sl7kQMaQZetdsPglnV/V+Q6ybbDXIFuNEM7n4kdT3OIjpcTeP5VYrtPNYzG635W5mmzLo/sAvviE2clc2125twV1CYA7MALpXa0f3SJDLg+SOJjrj7FEVhhFMpAYgICuIU6k8qu5nX5SZ3xvu6jJBAsE+UiFo5JhYpa6YKPhuojgz5ZXh/XlvL9s513f0uNKKtQArnLD53gA/tQC4hHQUJLu3yh7QT6fCGsLOoPIxwFv/VD87QuZ+UxRWBMbtc1EY6FsbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys12zyhAmABWAFTnkvDxMvQG8nfQxyFxi2VyF6ND+RI=;
 b=ZsgF6drg+T1NOVgnkd/KAqMGA5Q3DZAwmfhN+o/eznZMDTgSPMZRy2ybVZXek2Puv3yJgIl9f3bWyZxZH4+/sBHsXF0JFVyl2Ql5d7GJrMQYdH77tZE1s2ASZSj6w52VnCWdxnqZnMh/7qPtY76AnUJEsQtqMg0nEAOSvlvcEjItx9aKBifeKeFqM6nyJ2+NOAtslITkfIL3eEj4+myGgufrPkVVQvsTn4eczqmA5yl3MaZuRqQpU9yLEnDXNdp7stOnK+tNrKF6qWUYFtm3071RfgukUu4fGfaRxPp6YP9GpPSQSLr9liUeAxDXapLTw+az2kSxZksjbSJ+gO6WhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys12zyhAmABWAFTnkvDxMvQG8nfQxyFxi2VyF6ND+RI=;
 b=o6nIPyNrjfD5UDQx3sDfOFt5gG5QN3T+VCNt6qcyjsJ8wHzfPJSu9uCH9f/ngtqsG1WK6ebydTrxCAvu/2WgHjZjHrl7UOuwV6JviI/2qSfe/XKRr7BCymywvi9sPxPUbjgDZduRhVhXbwtrbaRbabn9MJwb9J2HBl4/wnfXIcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYYPR01MB13039.jpnprd01.prod.outlook.com (2603:1096:405:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 09:06:37 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:06:37 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 07/14] irqchip/renesas-rzv2h: Add struct rzv2h_hw_info with t_offs variable
Date: Fri,  4 Jul 2025 11:05:49 +0200
Message-ID: <20250704090556.669652-8-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYYPR01MB13039:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c82b05f-65db-4607-4b14-08ddbada14c8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aeA6BLP23C4hF4sv99/7ObG4h7N4EU2jII5E7i9N7fLMuTZhZadAVik78HDM?=
 =?us-ascii?Q?BKfcn+BEcjIJhP7Bv4UACcLlUyxbnTmCGBj5nfg4DUXUCLazqvPqv6yfm0xl?=
 =?us-ascii?Q?yaN2aNSpxAUfpcH4XA/WgGBvJW4AvPDKVHosVDPzkgE9cK8IxhNreyXMFj0Z?=
 =?us-ascii?Q?FozyoObPJCC01lsnooT/ZSILfTZQAcU4yn7zxO/1a9YWGTIKqOtdf7BpuZHa?=
 =?us-ascii?Q?U7XYY3tRBiiY8XgCOldLwgiBI8TSRU7tDyyzYHnCGZRI4Hcj1dagTlvK2x9z?=
 =?us-ascii?Q?sWPOgkbjqgnCKI4/50VimintrcYDEMDFfvssvc//n5D8ygz6oaovSFdOH/oQ?=
 =?us-ascii?Q?wjXcAvhIicgY2CAPchuRUb4Chu/XxP3oaHzMTC5rvj2MGGIRUReL/hDouBsM?=
 =?us-ascii?Q?7Le5xx9zvoufOIPelYtQLX9ETBZVj6t8B+FGP0PuBSA1/MbcOxevz+SmzB1n?=
 =?us-ascii?Q?W4Rfkj2mKphiYHZgDkEs40K8C3K/XlNsyboscrOla3t0AA+Q0i1eOlwVMazT?=
 =?us-ascii?Q?6XiGnLI3s5HOPv0veu8DqN0jYqSUMUYBhyEpfI+OB9kj8u8bj1YWBmdb0EcQ?=
 =?us-ascii?Q?JD/WgRlijXZ6f/jO4oXfOUxFTlWdKcv/kb8sD1JDqax1aLObIQLeI4MNuDOj?=
 =?us-ascii?Q?L+qGHMs0IzaI6zAAj3ROriK68/1zIi/htTb+ewbZBJcqs+R9KUUxtH2ueIkI?=
 =?us-ascii?Q?he0f13E00WuTdeXCz6AOzCzZsV0p82sWGgs9X39cdtpqXxR7oP8d+VSA/E/8?=
 =?us-ascii?Q?ZFnBpOqXibtWvDVCIKM1Ciuabz28DZ97Re4JmmNBL0y6Yc8oIapmRtuFi9s7?=
 =?us-ascii?Q?S+hjeltXbVWCZQZUhmDr9LfxlhrzpwajkkZfTANQuVvSqnT2dcFTi9LBtD37?=
 =?us-ascii?Q?JB68KJvnJhpY/8i3fFCjmRAr5cBt3NiRXrz9LxEO3GM0eiz/dwV8gkJKW5Jx?=
 =?us-ascii?Q?f92xDq+egUSit2koDcQbTRse/B/6kBhd3xfZFkgt6cUKO9Vnmud8Z+r8AA3v?=
 =?us-ascii?Q?yj7g6Gsu0Q4Ko1qW4z5NozJmtm/oYchvaEssxdzFdUI93jkFochYuxJgNSvP?=
 =?us-ascii?Q?RxT3zPNktqh006CZT6PkxoduOd4LQF1pYGEkV3NIYGffbkTcCjb7NquKhsT+?=
 =?us-ascii?Q?/jcWnFIlxNsOIjY1pMJlEcWzBIUBx28Nt4Q51Z/wBH1gxmsgJD3AZEb6CQZL?=
 =?us-ascii?Q?pbDSAzqdS+0XAXhzmi0HKEFcrEMrFkL+c9bP7cSFMo4ZM9kMr8AfHJFHzZQ/?=
 =?us-ascii?Q?4S7Jh8BiFzqOT3EMmM8gG4KoNFlPXl5xl0XPiOjskvf/xf6fSbS5m2jIhy+N?=
 =?us-ascii?Q?P4KQ+wp2YAVGCTy7h0U9IYG0u8KubsWjN8HsAzByBdcvSA6cPUgugPG/tpL9?=
 =?us-ascii?Q?ALVwewcNOIn6IWz01SsosuyDg57qxXKKYGfnZTjxUjOBuDSCe9ml9AU+9ZOB?=
 =?us-ascii?Q?es9qwHDd9VwQI8OPJXpIrzgRNb48tKwVn0EoN09nnVMtXr5oItT2BermTOPb?=
 =?us-ascii?Q?EZGYmMRDfbYVbpo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?s6c6LpcrD17kNjkg/Iuhovi1nMC0+9OTZU/K0x9hiuknivKfhC5J48KHP8gT?=
 =?us-ascii?Q?un0tirc0indKzdXdPxWW1ZgM7GAXd5v4TRG6JEayqbgUeeqhBCHsQh0ReHjF?=
 =?us-ascii?Q?kgwSlnpE69dYhrCIpDhRAh7UiKtQZF8pt3Zt0FlILWANezl0U+/yeobxAuh2?=
 =?us-ascii?Q?iCPW8dzegrwULRyqsdkQd9RXct6ZYXJ9tJvN4hdSr2sfCWNL5YOmGWDJ5dtw?=
 =?us-ascii?Q?1tTQ7TGgjgoB2vS9GLchd+1OQb5PttVbdphE0NvoJEYc1Pe0mKD+pKdjsmfv?=
 =?us-ascii?Q?DZc+Zz8Ts3mHcbDsIh2IdY+QKmhkRd0uj5larCzAhzonFkLjCuzG6rtZWVXQ?=
 =?us-ascii?Q?kE6ipP23YBzJrX2N2Q5mnE1idLL1dNYkYR8HkzKXwAS5/EtbR+JCnQEQH8XA?=
 =?us-ascii?Q?Ld5NZj5hwbg2MaW8ICSoviEsqXdZAZRI4SMXXn6ppVfyl4/869igwnQV9Gl4?=
 =?us-ascii?Q?WMOsB+QkSQxHYWnFe/xFADqbiice3RyqSqtyIZt4shMZ8ln7ObN838pgu1xY?=
 =?us-ascii?Q?TNElCHTnlywN2BDP2aN2zx4RijyeJm1FqAZCV47VTN7ZQibPOOuCnfsq8J7a?=
 =?us-ascii?Q?vehI43wSAHuvTgjLqwIQx/3hTH9/+GZZM/KtNYiacl0hzHIwmv61jT9HZLHh?=
 =?us-ascii?Q?9rbid+7hryJ6fCTWitz8PVflZHnl5K2Biya9IGLCFf2a9RwpTJcmzo7dtmN+?=
 =?us-ascii?Q?+OCbCJBPZJpOUm4iLtfRXhJRCRq8diXiu6CA31c4zylfb7zYa/Frx8GfKdCq?=
 =?us-ascii?Q?rBFSL7KvFg3WNAJh2u0q1KvOXBPiyiP/actOAVUqm2yH3cBdjaEksSUDGcTs?=
 =?us-ascii?Q?BXo/htP8cYtPEsSs28OXM0au5dYaDc9Xjy8vZmCbZcOacnGhq7sI3IdHjXcx?=
 =?us-ascii?Q?Yth3wsq9uZs0QxXkhkuctslxmic8xW4+6FK7yTOiQA4TbBIfsvFHHahTFam8?=
 =?us-ascii?Q?K9+RJ6UMRkaqJaBKu8vYFjeN7TEVuhJWRJhkMl5mEzqD1FzR9Llq4NiWH914?=
 =?us-ascii?Q?6z+YKVxThLO3nY+d8hskO43FgAc+0khdWSb3qDchlY8cD9q4K2TgMKyzvRx0?=
 =?us-ascii?Q?vSgBoM8DuJndA8X09/nJHlVbVrW8cSfWyj8A3Cdm8eQGKtLdqm9DiZi7BJux?=
 =?us-ascii?Q?kykdujywDb8alJzAMpT706ZrB+4aKT32M4ky4h1hZBmAe6/UgCeZkXxZ7u3B?=
 =?us-ascii?Q?iRrIzCSFJBkSbOAz9C7TGvrPA3RlB/mclhndh6FerjBcoenWmgs+DV0BqNS3?=
 =?us-ascii?Q?wOysk45DT3zSgYPsbAt/CfTBZ67pHPT5LrsJC0Hs3g+0cX7Au97CcLxbk5nq?=
 =?us-ascii?Q?RXPEPxoPG9pBtieieeT+stM/8meWNvJlCloMzST5GNNTCB//0vlOqVdpoz6q?=
 =?us-ascii?Q?EGZam8Ii6HqnrOW4itDUByHZZ/Ij3eU+KfhgdG3PDf/vhZ0k/1UyE07UV11y?=
 =?us-ascii?Q?xeGyBn6f6JIJRWRqtfKItA4+T7ZxdXtrk+Z+1KRSgF5xs33EsVfMfFQkKnKg?=
 =?us-ascii?Q?5R+6v/dZuK6OnOX1LQB1XanyUAu1oXdvaObXvj0ZtsV+P/Do7TqfIe0/qP1C?=
 =?us-ascii?Q?zNqIZ/BVvhFiSmkbq5aSrD+yjn584/+vvE+w+LzkxbYFwrpE/mCU7fEgdjDi?=
 =?us-ascii?Q?Gp7IvljO9UezQHIyp7HgYh0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c82b05f-65db-4607-4b14-08ddbada14c8
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:06:37.2182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzOHxTik4ALeGjMOScMWm+nlB2I2wPa5G7r8+ib+YFb0Hplxl1/6bOCbd0r+YGyHNoPOm5KcDHuaZk9/4GYrFx6oySxcmpehQzMsQjDDuO5tWKiwlGa51pgscoDFO4DF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:06:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19336

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 0a9d6ef64e5e917f93db98935cd09bac38507ebf upstream.

The ICU block on the RZ/G3E SoC is almost identical to the one found on
the RZ/V2H SoC, with the following differences:

 - The TINT register base offset is 0x800 instead of zero.
 - The number of GPIO interrupts for TINT selection is 141 instead of 86.
 - The pin index and TINT selection index are not in the 1:1 map
 - The number of TSSR registers is 16 instead of 8
 - Each TSSR register can program 2 TINTs instead of 4 TINTs

Introduce struct rzv2h_hw_info to describe the SoC properties and refactor
the code by moving rzv2h_icu_init() into rzv2h_icu_init_common() and pass
the variable containing hw difference to support both these SoCs.

As a first step add t_offs to the new struct and replace the hardcoded
constants in the code.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-8-biju.das.jz@bp.re=
nesas.com

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 46 +++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index d724f32dde8f..a2e831efc23f 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -80,16 +80,26 @@
 #define ICU_TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
 #define ICU_PB5_TINT				0x55
=20
+/**
+ * struct rzv2h_hw_info - Interrupt Control Unit controller hardware info =
structure.
+ * @t_offs:		TINT offset
+ */
+struct rzv2h_hw_info {
+	u16		t_offs;
+};
+
 /**
  * struct rzv2h_icu_priv - Interrupt Control Unit controller private data =
structure.
  * @base:	Controller's base address
  * @fwspec:	IRQ firmware specific data
  * @lock:	Lock to serialize access to hardware registers
+ * @info:	Pointer to struct rzv2h_hw_info
  */
 struct rzv2h_icu_priv {
 	void __iomem			*base;
 	struct irq_fwspec		fwspec[ICU_NUM_IRQ];
 	raw_spinlock_t			lock;
+	const struct rzv2h_hw_info	*info;
 };
=20
 static inline struct rzv2h_icu_priv *irq_data_to_priv(struct irq_data *dat=
a)
@@ -109,7 +119,7 @@ static void rzv2h_icu_eoi(struct irq_data *d)
 			tintirq_nr =3D hw_irq - ICU_TINT_START;
 			bit =3D BIT(tintirq_nr);
 			if (!irqd_is_level_type(d))
-				writel_relaxed(bit, priv->base + ICU_TSCLR);
+				writel_relaxed(bit, priv->base + priv->info->t_offs + ICU_TSCLR);
 		} else if (hw_irq >=3D ICU_IRQ_START) {
 			tintirq_nr =3D hw_irq - ICU_IRQ_START;
 			bit =3D BIT(tintirq_nr);
@@ -137,12 +147,12 @@ static void rzv2h_tint_irq_endisable(struct irq_data =
*d, bool enable)
 	tssel_n =3D ICU_TSSR_TSSEL_N(tint_nr);
=20
 	guard(raw_spinlock)(&priv->lock);
-	tssr =3D readl_relaxed(priv->base + ICU_TSSR(k));
+	tssr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(k));
 	if (enable)
 		tssr |=3D ICU_TSSR_TIEN(tssel_n);
 	else
 		tssr &=3D ~ICU_TSSR_TIEN(tssel_n);
-	writel_relaxed(tssr, priv->base + ICU_TSSR(k));
+	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(k));
 }
=20
 static void rzv2h_icu_irq_disable(struct irq_data *d)
@@ -245,8 +255,8 @@ static void rzv2h_clear_tint_int(struct rzv2h_icu_priv =
*priv, unsigned int hwirq
 	u32 bit =3D BIT(tint_nr);
 	int k =3D tint_nr / 16;
=20
-	tsctr =3D readl_relaxed(priv->base + ICU_TSCTR);
-	titsr =3D readl_relaxed(priv->base + ICU_TITSR(k));
+	tsctr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TSCTR);
+	titsr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(k));
 	titsel =3D ICU_TITSR_TITSEL_GET(titsr, titsel_n);
=20
 	/*
@@ -255,7 +265,7 @@ static void rzv2h_clear_tint_int(struct rzv2h_icu_priv =
*priv, unsigned int hwirq
 	 */
 	if ((tsctr & bit) && ((titsel =3D=3D ICU_TINT_EDGE_RISING) ||
 			      (titsel =3D=3D ICU_TINT_EDGE_FALLING)))
-		writel_relaxed(bit, priv->base + ICU_TSCLR);
+		writel_relaxed(bit, priv->base + priv->info->t_offs + ICU_TSCLR);
 }
=20
 static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
@@ -306,21 +316,21 @@ static int rzv2h_tint_set_type(struct irq_data *d, un=
signed int type)
=20
 	guard(raw_spinlock)(&priv->lock);
=20
-	tssr =3D readl_relaxed(priv->base + ICU_TSSR(tssr_k));
+	tssr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(tssr_k)=
);
 	tssr &=3D ~(ICU_TSSR_TSSEL_MASK(tssel_n) | tien);
 	tssr |=3D ICU_TSSR_TSSEL_PREP(tint, tssel_n);
=20
-	writel_relaxed(tssr, priv->base + ICU_TSSR(tssr_k));
+	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
=20
-	titsr =3D readl_relaxed(priv->base + ICU_TITSR(titsr_k));
+	titsr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(titsr=
_k));
 	titsr &=3D ~ICU_TITSR_TITSEL_MASK(titsel_n);
 	titsr |=3D ICU_TITSR_TITSEL_PREP(sense, titsel_n);
=20
-	writel_relaxed(titsr, priv->base + ICU_TITSR(titsr_k));
+	writel_relaxed(titsr, priv->base + priv->info->t_offs + ICU_TITSR(titsr_k=
));
=20
 	rzv2h_clear_tint_int(priv, hwirq);
=20
-	writel_relaxed(tssr | tien, priv->base + ICU_TSSR(tssr_k));
+	writel_relaxed(tssr | tien, priv->base + priv->info->t_offs + ICU_TSSR(ts=
sr_k));
=20
 	return 0;
 }
@@ -424,7 +434,8 @@ static void rzv2h_icu_put_device(void *data)
 	put_device(data);
 }
=20
-static int rzv2h_icu_init(struct device_node *node, struct device_node *pa=
rent)
+static int rzv2h_icu_init_common(struct device_node *node, struct device_n=
ode *parent,
+				 const struct rzv2h_hw_info *hw_info)
 {
 	struct irq_domain *irq_domain, *parent_domain;
 	struct rzv2h_icu_priv *rzv2h_icu_data;
@@ -488,6 +499,8 @@ static int rzv2h_icu_init(struct device_node *node, str=
uct device_node *parent)
 		goto pm_put;
 	}
=20
+	rzv2h_icu_data->info =3D hw_info;
+
 	/*
 	 * coccicheck complains about a missing put_device call before returning,=
 but it's a false
 	 * positive. We still need &pdev->dev after successfully returning from t=
his function.
@@ -503,6 +516,15 @@ static int rzv2h_icu_init(struct device_node *node, st=
ruct device_node *parent)
 	return ret;
 }
=20
+static const struct rzv2h_hw_info rzv2h_hw_params =3D {
+	.t_offs		=3D 0,
+};
+
+static int rzv2h_icu_init(struct device_node *node, struct device_node *pa=
rent)
+{
+	return rzv2h_icu_init_common(node, parent, &rzv2h_hw_params);
+}
+
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzv2h_icu)
 IRQCHIP_MATCH("renesas,r9a09g057-icu", rzv2h_icu_init)
 IRQCHIP_PLATFORM_DRIVER_END(rzv2h_icu)
--=20
2.43.0


