Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F07ECF6A8F
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:10 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.40])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2992.1767864544907232297
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:29:05 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FRTtHotR;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.40, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3PyJuqur1ThE1jqru8NZ1E+RdC1ktr1k7I9/ydUjvMwZtcn77jFSJt5QNhDxz6moaClwHbiu/Qp/mBjtWE4EhGvPP3es/LjThyPtBRZtpW6RIft01O2bf4lpuMwtlptMhOuy6p1so1nsRN2tZQs01HisJAFXFpgW+XO8NuvoAaosVDRt3L1EjyIEhml1p79nT5d+REm4wVgmbL2ch0Z9pqj6B+DLybfvC/6bV+sjMTFrCJDTrE9KfRYsp15Ls3mnkI3kT2Bk5OyJGhxC1WHHDKP6zv9Xsb/7kF3UtGtaQh3b8dpx50P0Uutv3DkasOrupfvdliPnMuZLV98RlcCWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6J5/KdZPPZxA390+5zMUcliFJ1XAYmT6I3zv+YPISw=;
 b=GqMy57jFa4e5eYOnKfbVc5a6bEAxG7Voi2bMeiVHMulSRYwje0fCPVSUQ5Lzkxq9ydF4auwHnhOeGFUQ8nAjjRr4e3vLEm+UeTPf/ik9+KAdDKAA02ATB8NXCQS7t0+4HFOFNGWPuSHNbKZtwkwRFl27fH2DNQ0lS8VaHFw4WTc7oxxXm1KGyIhzYAp3ARVIJ8SChi9wr77XgAi14JG7yO+1Yl+Bz50YdLMbG0clw/OyvZtUY0ed3D5pj0wrwlf7fEQprzKmLREbajHqC5OV/U+dvLW1CMLsXM5kjB7QrQiSv0oNYMGhjE93acgHvZlc1/TXuZBUTcfRLt8275mm/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6J5/KdZPPZxA390+5zMUcliFJ1XAYmT6I3zv+YPISw=;
 b=FRTtHotRx9Iv7ont7EPzvCPDsgBOeUXXrxA9kT5hD/hLLZiiUfeIjjKDm/DzwI3YrwBMNw2gx/5PjJxVOwVq4yBCSnGp4YvraLUESxu2ssbNPV/HPbtRNW+Rr3G8YXp3UebStPNEvv//OleQxnQk/i0KaeVHEAX3WS7Yt6Hdx8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB12872.jpnprd01.prod.outlook.com (2603:1096:405:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Thu, 8 Jan
 2026 09:29:03 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:29:03 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 06/22] i3c: Remove the const qualifier from i2c_msg pointer in i2c_xfers API
Date: Thu,  8 Jan 2026 10:28:07 +0100
Message-ID: <20260108092823.489287-7-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB12872:EE_
X-MS-Office365-Filtering-Correlation-Id: fccfd2de-7dc5-4cd1-1985-08de4e985ce7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?NpffOjDpFX+bx1zfR5hLfutP0sgVNVHk4iQnXjP/8Z7mY45LxUE8l0+8X8Vl?=
 =?us-ascii?Q?nZuGc9/2Ir14gEeJolgLNfV/rvxwTLW5pQ/fDaK4FB5Wm1byeqdeLlQ0QzIw?=
 =?us-ascii?Q?BtgVwjSvvwKlb4V9TrEtmNY3E/vubWfhTCHApdGUKBN3ECxJXraxHazuZclh?=
 =?us-ascii?Q?WHJ0RLBttP7NCXWJc0VaiYAOrZhALYoWR6D/0W5Dkk2Oj+4DhRRUxrCg3wgS?=
 =?us-ascii?Q?KN0gesAG8EXhrQITBe7q/t5dvReUGRXMCLIyEWCua1cIigBAYmhJEGfGSnpf?=
 =?us-ascii?Q?5YOiBzWb6ONw/vChE040dBS2ExR5R5rvZTMwHM2El8uX75FIgy3fUv4fySuO?=
 =?us-ascii?Q?Ji1XLGIt8JFjhFHYCVJ/HjEu6s3t748Kky0f2XAOjocX7ryLPIU63CssuNnd?=
 =?us-ascii?Q?XMt1y9UlTMnXdPDNVzIQiCr25pMiJfOo8LyuWpeQOWZMU1FgjrJ3REggmUMZ?=
 =?us-ascii?Q?nuuAS/tjpwc7+6LhtMswtnaSlGE5rT2wTvl5iOi708mDAee9iG9x409SCD4O?=
 =?us-ascii?Q?dUS5GpHvyXxA7lMgulM0pIPSRAtI4H6hBzOfKmdA+0BaXxHmgpsN5t86YVjB?=
 =?us-ascii?Q?Re0AzL7qhG+lY3OMdq0A4WnEj0tSdFDYR7GmXpznqKS3OTp/eWjKqH39qcP1?=
 =?us-ascii?Q?p6FDPOpVJcgC1Pe27pwjUV4IagoR8YVJvp0InPAAU9i3WVIW/Vcw59WQA03A?=
 =?us-ascii?Q?cKwDUMMG2jZLr92v8up33n59JmGEMDdSF2ahYw1krwoEcyw1LkbV+yU8uJ6p?=
 =?us-ascii?Q?+TBOqgdn8I29fLnTbvRBcHJm1Vjk4hhzphIBFRiZ/2z9W7QiXNTY9ZcKNd9R?=
 =?us-ascii?Q?51Vbcaiu1SZZJEORU3EChhe5hHGgAeXum7KinNnjYNy/onYH5tlQqi0yWDnx?=
 =?us-ascii?Q?uOd8Vr+zptwzX6fIYrnbunq2Yytfdsf+MO50c2t5pyCB94v/X4hiNP/8/B6G?=
 =?us-ascii?Q?UfaNW59zbOllK8hWXxbsM2TXM5xfqHUUbAKwsBfFvfSvMbYXFmJJeStpbXR/?=
 =?us-ascii?Q?C1oX4GzMOzxhp0cw1+ilUtFOLIslSKw2H9XHw4Q0RTzEN4p8i7eVCXm6Jbla?=
 =?us-ascii?Q?fNKpYu1LPJjYV6MtfZBlDHhZUpid76wxu+nmDbP9NY5myPx4O4QsfaSHFewr?=
 =?us-ascii?Q?049+jLTl19wRFIo7m5GpUCcyGP0YhTc6kv6XNFV3FOAxZWWtDt+eDtXQQV3g?=
 =?us-ascii?Q?VN9DTfDyD5VyZw2S8fKTaVXHCWWMr45EyaZNsfAefCplxdstH2HuxPUj0iwM?=
 =?us-ascii?Q?MAJWLJNesS7s6Zr+xv6EPLWRzqfdakEqrUreliqkdP+ZJW/Qc9fauhr6OTOM?=
 =?us-ascii?Q?E8xHXqbLPJ74GLu9K4km0RofsBodJgsfTmVbzxffu1YvxBgX70t2kKPSedhN?=
 =?us-ascii?Q?ykXanNdNovVm9EU2BcqwPE1HMgQUwWaLmUgb5WN5uapgLi6xPnm/G+VQIFiv?=
 =?us-ascii?Q?SCYMdUnUmiD5V33Z9QSsKuXNV97075bHLvBVm62THUwwQDFKAzSVL+DKAbtW?=
 =?us-ascii?Q?bELztHDqmnAxza5OYG3bAgVbFlMFNg7+1P8I?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bz8HkMJd3kjOsgHMAUK3cD5HXzATibhW9ynGBRrujEIz7c/d0TOTMW29xIpQ?=
 =?us-ascii?Q?/4gnovRqd07VmOQl8s2jAVhIx9KkdTUVdJQxEFkYv6P2AyBQdtIr1IBqltrJ?=
 =?us-ascii?Q?0TVlJWApdrFs7UlX1vF14rZPO0VOFbxccJ/AMncyV501/VVA1ptOd3v9/eC0?=
 =?us-ascii?Q?IrAKL2PlUZN4SHv+sqbfGbQmyjsDiEtVpxQNBR09ZB04pS4tQhz5PO6WDdFy?=
 =?us-ascii?Q?lNU39Gfhpx1fojhuYiAXJig6Ehm2ELh0zrCHouo0Brec8bKvQC3qUCYj7GPO?=
 =?us-ascii?Q?plY647sZlEYEflqMc5uZRetaYZplyyd799c7xBnDFT+LgOy8fhRYe6IHBSmM?=
 =?us-ascii?Q?arTpSrM/aFfD9HjcKupSrJEVLLHXpybqXYUSmzVNnmIWj8cxxk8AOXMg8I4f?=
 =?us-ascii?Q?FJzBmoxKOPFNKzgB0JteTei47PzaII8rPqfANDC770AirFWx5dI/PtTdlIkX?=
 =?us-ascii?Q?9LpAV8VzJkUgS+NvEj6Y4r+IlGuEC9Nh+drZ2ajlyarzia94+D5coaXmZig1?=
 =?us-ascii?Q?gWEEfS7zarUyDMK1jgdZPp11GLLg0D7VTJ/6URKtV4SII9f5Z8v+hyBHKqGd?=
 =?us-ascii?Q?v9XwihOYKT3aK4fl23tJgYoxG6pdVD8TY7ADi6KR7bw/AomWspq0GC6+xLif?=
 =?us-ascii?Q?NlawfzP9HLGwuNAjHnTLmu2YFLnwEPo7WlAmbeJ/i6yxdsZRyqVwbya6rfnl?=
 =?us-ascii?Q?fpk1oEPb3uSeF7HvdumIw0lQJF6rv7Pnwn38FS03IFFiiWdUDsdELNZL99/b?=
 =?us-ascii?Q?AmrwEcCZQ5j2x8Y8mqW/jaWBPexrBWN8qX0PeP5rHRS1oEa+qcU/44/oNgIF?=
 =?us-ascii?Q?7FtpTTIuKOlYRD6Y5ir+zhUt8mmJVqtCFCcgXQlXgJR1k3oFhSOLimdHl8Zg?=
 =?us-ascii?Q?873JPjzoJ5ldarNGQmBOOjnBln17soSWwFFoDaddTWuLbwz6/CYRAlTFvuNL?=
 =?us-ascii?Q?pgZGMd5q5IbyP0VSJrUv7k9reHuBxHkEVYjtiWILbrH6LnxOSV1F3Vdvk1RW?=
 =?us-ascii?Q?ctxRjatZ9Lhj4ZBAAJOmbU6XAQvQ4w3ErbHdlwD2SShj873kMW1FY95RHvIi?=
 =?us-ascii?Q?7UY5iOHw7RHK0dTg4RyFqwB7ZFDusC8G0sZ+p+4W1jFdyPe7L6iSjXSQi4YI?=
 =?us-ascii?Q?ghT1SbYc2k+J/o5xTQnu0a4punXo3jg+iW2Fag5gkE8oe81EbTRF89oztKOQ?=
 =?us-ascii?Q?LTiFn8BVO3WGAf5ACR6XvY+UeuIA3x7eNteJ/ZJupiVstMkUOXGWTYu1UK0/?=
 =?us-ascii?Q?RSOLOeRH0LQNAc6iKKsRvrqizMbJ0MZx9XuU+cKjtwKZyBCXhjb+GprYWWyK?=
 =?us-ascii?Q?hPYJHcWd6Y2HEiYBFUZpcKmqRopvCK5lMXPYSe9eYlqcVRbsVcg685xh1nEh?=
 =?us-ascii?Q?dUuXriZTzCYaLvm3H2bvabQehd0H8OgyzVENTDFWCYz8awDn9KbFHZiRPfUn?=
 =?us-ascii?Q?xrV69+ctELCwapRh0qDoYgP0AdcwRgDQXPbBonR6KVuNd6ReeesjH8kn4NGg?=
 =?us-ascii?Q?8nkkR9xrLyZPwt7MxDFlp4Q2oB1ima7m6dr93EjeRIwoeiOgVw23sqaeLdwq?=
 =?us-ascii?Q?ed0RlR4ClhQH8dqIC+D/pjs2KNOZUYnLPg2jAhJMkopNUD6U34yJxJfB9Zoq?=
 =?us-ascii?Q?211TzgUSQ88EGAxphL54UlLlyG0WwYNZoZShJmQrfv0GqOR3E7mifgD4F1ym?=
 =?us-ascii?Q?kt+zBJjB71pckrym1TTRZNhCJha9gK4QHwFlXxjOCXgTvmKvSTXfI6pHfqEu?=
 =?us-ascii?Q?+caU333gjtNpmPurHxCGxkmDWDnob4u4hdJwhjwKyGlXnxiNrPy9?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fccfd2de-7dc5-4cd1-1985-08de4e985ce7
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:29:03.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mz+n+G1jGbnFNWbTHzSWNVs3asDIpSzRQ7R+9IwZMAW7FZVipO2BUC25j8NbVz2wRwK9O4dpMBvUcaK/qt1LFflVw2O8gvJp25GRn1meofQQcUDEIGfjiwN+WQax3NVL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12872
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21442

From: Billy Tsai <billy_tsai@aspeedtech.com>

commit 6866c91f8c2327546d850d5a85025fb81e2089bf upstream.

The change is necessary to enable the use of the
`i2c_get_dma_safe_msg_buf()` API, which requires a non-const
`struct i2c_msg *` to operate. The `i2c_get_dma_safe_msg_buf()` function
ensures safe handling of I2C messages when using DMA, making it essential
for scenarios where DMA transfers are involved. By removing the `const`
qualifier, this patch allows drivers to prepare and manage DMA-safe
buffers directly.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Link: https://lore.kernel.org/r/20250204091702.4014466-1-billy_tsai@aspeedt=
ech.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i3c/master/dw-i3c-master.c     | 2 +-
 drivers/i3c/master/i3c-master-cdns.c   | 2 +-
 drivers/i3c/master/mipi-i3c-hci/core.c | 2 +-
 drivers/i3c/master/svc-i3c-master.c    | 2 +-
 include/linux/i3c/master.h             | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c=
-master.c
index b72f6dce18b4..49e495509632 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -968,7 +968,7 @@ static void dw_i3c_master_detach_i3c_dev(struct i3c_dev=
_desc *dev)
 }
=20
 static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
-				   const struct i2c_msg *i2c_xfers,
+				   struct i2c_msg *i2c_xfers,
 				   int i2c_nxfers)
 {
 	struct dw_i3c_i2c_dev_data *data =3D i2c_dev_get_master_data(dev);
diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-=
master-cdns.c
index c5a37f58079a..ba3df9f6c578 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -814,7 +814,7 @@ static int cdns_i3c_master_priv_xfers(struct i3c_dev_de=
sc *dev,
 }
=20
 static int cdns_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
-				     const struct i2c_msg *xfers, int nxfers)
+				     struct i2c_msg *xfers, int nxfers)
 {
 	struct i3c_master_controller *m =3D i2c_dev_get_master(dev);
 	struct cdns_i3c_master *master =3D to_cdns_i3c_master(m);
diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mi=
pi-i3c-hci/core.c
index f9bc58366a72..48bc86253877 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -329,7 +329,7 @@ static int i3c_hci_priv_xfers(struct i3c_dev_desc *dev,
 }
=20
 static int i3c_hci_i2c_xfers(struct i2c_dev_desc *dev,
-			     const struct i2c_msg *i2c_xfers, int nxfers)
+			     struct i2c_msg *i2c_xfers, int nxfers)
 {
 	struct i3c_master_controller *m =3D i2c_dev_get_master(dev);
 	struct i3c_hci *hci =3D to_i3c_hci(m);
diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i=
3c-master.c
index fda472d84549..fd12536affbf 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1477,7 +1477,7 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_d=
esc *dev,
 }
=20
 static int svc_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
-				    const struct i2c_msg *xfers,
+				    struct i2c_msg *xfers,
 				    int nxfers)
 {
 	struct i3c_master_controller *m =3D i2c_dev_get_master(dev);
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index a82a3d5b00e1..5fb114f10623 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -466,7 +466,7 @@ struct i3c_master_controller_ops {
 	int (*attach_i2c_dev)(struct i2c_dev_desc *dev);
 	void (*detach_i2c_dev)(struct i2c_dev_desc *dev);
 	int (*i2c_xfers)(struct i2c_dev_desc *dev,
-			 const struct i2c_msg *xfers, int nxfers);
+			 struct i2c_msg *xfers, int nxfers);
 	int (*request_ibi)(struct i3c_dev_desc *dev,
 			   const struct i3c_ibi_setup *req);
 	void (*free_ibi)(struct i3c_dev_desc *dev);
--=20
2.43.0


