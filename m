Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D86CF6A97
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:20 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2997.1767864555184238165
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:29:15 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FBtAea8n;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.16, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5fqOHGttE7r2K9UAS84mKaSJKXq+jWrBrsqfkWr6HY1NRDqzsgYJDTVCvQTvDv/eryCk9ygcrkFZk1EifNxezBeRm1QEWZ4XXqodgwu5Qn2lwCQqAmv9sL6Pk1ZzMZqeVcIOKUBx4zbCNwNIGZ+A79SXaGQ91altICH/MYZN8HaXpiwH4+bRmbjPMDJeTSyKncjIaKNJ/erhTkzF3ArdOcC3+PpX5Fs1Xg0Ex2eLxSQvF3D83GSe4CaBDj7h1UNqKM+AQH9mYw/zOlSdJHxESV0wxAyNuVzQqKKNvIGMfB59Z2k9r5R/JTBS/8Q/eLxnQXPZ2aebkNkAl8J2A6SEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQ6oYINJU0rxnd1PDEcFmvMhqH/nxdxcshqfvXM4cZ4=;
 b=xi4/TvFZ0KfwA+plvHulO5lZdUKRfAUd2NNxTPvJ9BEG3wNz3tpR9H/wep01rhc1Z4B0eQnRoUHhPnkhMQUp5DOAx9KzrGQmQr8LeZQd2M2clZUtiI5Tminaw10kTKZgxPUqxIS/l7NO/QlWq1OiiWpumxNd51cqon9OMmHtFRyyPayBp0jserI9LGTYagzyVWbBll5/nbf1myUusGtHtjo6gDxoBaL4NVvm5JrHE+jJE+WJPMMaMI/up7h/DpJJmwVVRAxUWWquvtazySbCXrHDMOagwk+HbPj0KKkgCGa/3GHh+rujb3Y5gfbhNRW3b/N2LXBgfNPh9C+psrD9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQ6oYINJU0rxnd1PDEcFmvMhqH/nxdxcshqfvXM4cZ4=;
 b=FBtAea8nCU9HdI7CeA2XA/J+kKRUpCOYcJduEqFcI1iGO7g2rH+BB3xv5QR2+xNN+bXZPjFiLh5W97aDm0psS/rl0kDp72Q1eQ9BW4H/ELpeFaFI4jVxz/48PHbYNWvWAgML33SUXJLpR+2VBxx3CX59LZHQLyTnzGsVAtrsLJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14750.jpnprd01.prod.outlook.com (2603:1096:405:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:29:13 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:29:13 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 09/22] i3c: master: Add helpers for DMA mapping and bounce buffer handling
Date: Thu,  8 Jan 2026 10:28:10 +0100
Message-ID: <20260108092823.489287-10-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14750:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a802ba0-dc5b-4099-f6a4-08de4e986288
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LVopJ6K1pt4eDaP0rMcj6eNdPCw8sxvtx7vbvyyk+7v3TpFgduHsD37Heq2S?=
 =?us-ascii?Q?GIcYCwQhDLChQkmpQPPzWkUIxoe+Gw23GMbMBZ1FuYmFJ6E7f7CAXse1lRMY?=
 =?us-ascii?Q?XkE+VH2gnwxGENmsDrUaJE5sNQDa9IYK4gHNHq92dZK2E0KZ/7fiRRLiK2z4?=
 =?us-ascii?Q?C9mpMwJjUrUuFBLsfa3xKGtoLWZ1LuT7zm7/S+9mN+zI7rZP5RboiuMl/BN+?=
 =?us-ascii?Q?V5SoB7GcqSLpBKf9pPk9+5TQmkBK+LrT3OuIk5ryM/Nb1OZ1OHGZy3efHpE8?=
 =?us-ascii?Q?JcRUDC76f8nRKieSdajy8TRstVjsDpxst+UJOkvR9ERcCitDX11jHooQBX6u?=
 =?us-ascii?Q?HmH7k6L+SrDoJZgsTUSrEik6t0MaGBYqjeOFlQ5pbG+XoTpXwsfO+WpSNs+A?=
 =?us-ascii?Q?jizmCKzPIU3TYIThNkhWPCcgw1/7ZegzzyVppjoQPo3wk7PmFeg+qrU/MuvW?=
 =?us-ascii?Q?8Tr0ODyyIU3UM1TNdb0umAHOHN4GazaTbO12YZsw5LS2Zy+fDxH/ND6qHfsB?=
 =?us-ascii?Q?W0KaaOxb2bU8maN+qCYpxfS92O1e2WpqN34rW6AbJB8ns/3TU6YMXfT0J3cC?=
 =?us-ascii?Q?7/sFnVuXB71TdyzNqaI8gG/xF4KQmXTi+8nPq+oSPY08PEnRtAWtx8RJf+3C?=
 =?us-ascii?Q?2tIzCpv5pcCnQYAuHSF/eTmQQjYQC6gm46e6Ar2K+ljZwwsKYpyWpRLevK3K?=
 =?us-ascii?Q?DcEX7PBAj/TqwlYLQw8XzT9KR44SEFS+5DLuM2lAxXrwMrup2KraWToRClpt?=
 =?us-ascii?Q?/FwvlKlgkLTpmPqbSN7lBSvsQsP96JZn4iMbv3vAXcI++gdNrSWflHt5e61B?=
 =?us-ascii?Q?IPNiAAknmI3lUuDi1Cek1In+FQkMnQCm4oeJ9vJBaOoyQnsVuV3++6wB6HIs?=
 =?us-ascii?Q?IcW1wBdnWSASUgxGtrMjDRaKDGIg2iN+A+44RlKVf0oBgz4V64zZ8PSjDMCZ?=
 =?us-ascii?Q?UxpRV8U5vWZpgWt7skyhSXxzdwQL5JuhJLBFekWgwHM3CylGzEfbNuTYZrry?=
 =?us-ascii?Q?NHj6TRR61fsJTUOfwmF2UzzpXjkH8Je4Cy+GEh6BKpWljszDN6GTc+h+LvdI?=
 =?us-ascii?Q?mduN4YDnNMLFuJXBZU98P5tN176hyu6Z2GQrbiwCLLa22G7TIP6lq62jCZwE?=
 =?us-ascii?Q?UntpNnP20yX/XAIqmPwmXQtv0u62VCtHPF5ijEFfguqkfasNkYb9ab6M9FjU?=
 =?us-ascii?Q?WGXo7eJ7ZQW7QBcKqc5TUBPoIjIn8UkFeoP2YfL1KU7GSZIRf4jjiL2edWkn?=
 =?us-ascii?Q?RPxGmgz6JNAaj584Rb1BKqP8WCrKI1gJzDnWMTNnN5sqZj5Yqrs9zsKw3yLX?=
 =?us-ascii?Q?jT/Khmwumnoef9SEpYbOzNWHCYp8hhUVzvyzQIoVqfPubahSqDIGqsrZ6wbm?=
 =?us-ascii?Q?v0C/CovW75oAA8Km7PFH65jN97Xinh3tmyXMcyakZRsNtjJplMgyKavTFhJE?=
 =?us-ascii?Q?2GR01Zn6vbJvq+0lhNS+7Mom7IRCwxYZgS2sLAz4Ckds8aDC/OFsj2ND85MA?=
 =?us-ascii?Q?EetMoVHnMP6+1tMp7T9pM9FFXff/IPkmXe9c?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?y72WTbKAjiAfDhLzlGPjA1dZSnPEV+kEYqFssi2DDEYRFK3gK3lc9hl2QhLW?=
 =?us-ascii?Q?jdlDIRMCv1Ki252O1g5EOo+CTfVxr3A+1I9ggUPa5z/5fBmCHwvuqsXPufOz?=
 =?us-ascii?Q?XC8BBbWX4BxuK+F9eeCAIZj3p571EXJEgBNjqzHuQhCrWmQiLjydowgYflYo?=
 =?us-ascii?Q?Bdzt9LZiDr2FWmrLnwXh3UHLK+50U/sKrYJgVFuKHdVCD6ByFCjfX+6g736S?=
 =?us-ascii?Q?TzcHdXoujXTI8UPwU2QcMAoAVKhrTmGDmkOjEFE/w3oJAjEMO2XLVT8zNCaJ?=
 =?us-ascii?Q?ZrbgmoNafiH4yWrbn1D4R5zErdYVJu75rPd3rc/JqoSWruEnNWeb/hzMUaPt?=
 =?us-ascii?Q?KqPtIf+vaGny6wtsAiCmvfALM3JDr7F2St3qAN2qitjcEKLaWpHum9y4DHDY?=
 =?us-ascii?Q?gVTceltzOChjaB2MoqZTqAWCP7elQPepVc/gCw9oKCz+m9/H3aU25mrn1vgx?=
 =?us-ascii?Q?tiQzQ9+goWof1mJMRnpmoNNYr9MOthBRWobBAJeJXCCCOwi4D29kfq7N+ZLB?=
 =?us-ascii?Q?EeWHToE6yOlJCO87A86mVrQPyujg1050r4lhb1LW1sb1ThTO07+NvzraX26U?=
 =?us-ascii?Q?AcfEfp4Xo06WqT6D4FZcNQf9pMxoNUyl2kjbJaGlCa2nqw29nLD5vySQTKCS?=
 =?us-ascii?Q?BNnBQMwa4+lzHyeRAvGa1tsqo7sYLeb4MX3zzMORKB6odR3tmYQVSvRNCqbJ?=
 =?us-ascii?Q?PFVFtuOkXCwy9Uxu/ajPHXfWa4nKhcjcAWdpfWiLRAtuPOqyk3IURjiSK8CO?=
 =?us-ascii?Q?IrliCj5xSTFaZojrJzZsirLbrUE91405CDTGXHkVJBmpQ9Q40AL31B1NGRvO?=
 =?us-ascii?Q?N4ySqamYEhtWHwPrv2xy5k/hwztSFGybOy1uMNEJVcxtP7PcmiD/vP5EbjME?=
 =?us-ascii?Q?6+ObKhtm/O7lJinULUuCRQWyTvmk63YORBmIY/z5LCNoogKnKknCJ2nSmESp?=
 =?us-ascii?Q?UWB38oZ7cZ1OPqP7JjFZTSYoz8C/cFYvF2yZXToD9soj1NrDX0e9w0g3XRCl?=
 =?us-ascii?Q?E+Q3yJYbWUy24wsBkjgW9gIuDWG5d6HA6JHG8+f24qXiNax0s3Gla7Lrg3Hv?=
 =?us-ascii?Q?Vvh2KBZ2tQUpZCBkb+uRtTBCtLlrbKCQp3uZM79WPIwgs6xF3wMeonX4O3HO?=
 =?us-ascii?Q?aC6cw/bl9fN0/1RdyvhFs4eN98XGpCdPNfshqXzld2t3mLRWQ86W7+AX1o+W?=
 =?us-ascii?Q?cRtWPL2VGoG2UY9PQeTAeVXyPyQZO3XymalBoY0JwWhxtSKjhkXk2vAPsbL4?=
 =?us-ascii?Q?oRvbyIYdQvN57Y90VZNz0LQ1rCcCd1Q5VeNBry+RBrFROZNs7xkxqMDudA4d?=
 =?us-ascii?Q?imUhQthgYWw8MlbzmyGCDUczpUFG+4XIB2S3s+v5+thpLjFFCOZC3XRQsNnS?=
 =?us-ascii?Q?qTf9lO+9c82PWyqyjhuQjvsMaKN/TJ5Z0dSQkQwik6RSGT79Tmfz/1BDoc5J?=
 =?us-ascii?Q?E5Ig8bciVDyDs+XaOrMe/ToXX41BNM9YWTF/yCfhPSTCKNKILafJDuKKhL1l?=
 =?us-ascii?Q?zEeRT8vBeujDLnaGKgbaQfszYj9nvrs0AYMaRniEugbP8gBngh+DrrR3DwdX?=
 =?us-ascii?Q?7/mM4c71Elp35ZhyRVeZHIcO2IvqfS7dH0LFgkKZNkk0O9QS3aky7luq3eNt?=
 =?us-ascii?Q?pnaiStSQdhRr3l+KkWu8myiJ8A6NkvpeOggnBSW0WRzfkhldtBr9jJUzmtBB?=
 =?us-ascii?Q?b/IO+ZOtkxM3fD5ugu5sCvGBBhnyIv3gXJUfsjNS055Mc/N2WVQTALU0hgHm?=
 =?us-ascii?Q?ffayAXW9/JRueO5L3qP80O83Bv2o7dYVm3BKdkG4C13WDynVXzf+?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a802ba0-dc5b-4099-f6a4-08de4e986288
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:29:13.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qz/cN1s80xucsZ2f0dz5GgBhBIUqFIqtiUmcJ4EIRrFlwN35XF8irkRc1n/B5vcsDE2XYaWY3kWUgfZ+VN8H4b6yxWY48a5QlB3D1zKxoM1eP6gGZOYspWwIq/hpR8OJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21445

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

commit f8d9e56aeb87ce82ce8636cd176cc59b69aa0e41 upstream.

Some I3C controllers such as MIPI I3C HCI may pad the last DWORD (32-bit)
with stale data from the RX FIFO in DMA transfers if the receive length
is not DWORD aligned and when the device DMA is IOMMU mapped.

In such a case, a properly sized bounce buffer is required in order to
avoid possible data corruption. In a review discussion, proposal was to
have a common helpers in I3C core for DMA mapping and bounce buffer
handling.

Drivers may use the helper i3c_master_dma_map_single() to map a buffer
for a DMA transfer. It internally allocates a bounce buffer if buffer is
not DMA'able or when the driver requires it for a transfer.

Helper i3c_master_dma_unmap_single() does the needed cleanups and
data copying from the bounce buffer.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20250822105630.2820009-2-jarkko.nikula@linu=
x.intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i3c/master.c       | 74 ++++++++++++++++++++++++++++++++++++++
 include/linux/i3c/master.h | 26 ++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 3361b466c3fa..035dab33f85d 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -8,6 +8,7 @@
 #include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
@@ -1669,6 +1670,79 @@ int i3c_master_do_daa(struct i3c_master_controller *=
master)
 }
 EXPORT_SYMBOL_GPL(i3c_master_do_daa);
=20
+/**
+ * i3c_master_dma_map_single() - Map buffer for single DMA transfer
+ * @dev: device object of a device doing DMA
+ * @buf: destination/source buffer for DMA
+ * @len: length of transfer
+ * @force_bounce: true, force to use a bounce buffer,
+ *                false, function will auto check is a bounce buffer requi=
red
+ * @dir: DMA direction
+ *
+ * Map buffer for a DMA transfer and allocate a bounce buffer if required.
+ *
+ * Return: I3C DMA transfer descriptor or NULL in case of error.
+ */
+struct i3c_dma *i3c_master_dma_map_single(struct device *dev, void *buf,
+	size_t len, bool force_bounce, enum dma_data_direction dir)
+{
+	struct i3c_dma *dma_xfer __free(kfree) =3D NULL;
+	void *bounce __free(kfree) =3D NULL;
+	void *dma_buf =3D buf;
+
+	dma_xfer =3D kzalloc(sizeof(*dma_xfer), GFP_KERNEL);
+	if (!dma_xfer)
+		return NULL;
+
+	dma_xfer->dev =3D dev;
+	dma_xfer->buf =3D buf;
+	dma_xfer->dir =3D dir;
+	dma_xfer->len =3D len;
+	dma_xfer->map_len =3D len;
+
+	if (is_vmalloc_addr(buf))
+		force_bounce =3D true;
+
+	if (force_bounce) {
+		dma_xfer->map_len =3D ALIGN(len, cache_line_size());
+		if (dir =3D=3D DMA_FROM_DEVICE)
+			bounce =3D kzalloc(dma_xfer->map_len, GFP_KERNEL);
+		else
+			bounce =3D kmemdup(buf, dma_xfer->map_len, GFP_KERNEL);
+		if (!bounce)
+			return NULL;
+		dma_buf =3D bounce;
+	}
+
+	dma_xfer->addr =3D dma_map_single(dev, dma_buf, dma_xfer->map_len, dir);
+	if (dma_mapping_error(dev, dma_xfer->addr))
+		return NULL;
+
+	dma_xfer->bounce_buf =3D no_free_ptr(bounce);
+	return no_free_ptr(dma_xfer);
+}
+EXPORT_SYMBOL_GPL(i3c_master_dma_map_single);
+
+/**
+ * i3c_master_dma_unmap_single() - Unmap buffer after DMA
+ * @dma_xfer: DMA transfer and mapping descriptor
+ *
+ * Unmap buffer and cleanup DMA transfer descriptor.
+ */
+void i3c_master_dma_unmap_single(struct i3c_dma *dma_xfer)
+{
+	dma_unmap_single(dma_xfer->dev, dma_xfer->addr,
+			 dma_xfer->map_len, dma_xfer->dir);
+	if (dma_xfer->bounce_buf) {
+		if (dma_xfer->dir =3D=3D DMA_FROM_DEVICE)
+			memcpy(dma_xfer->buf, dma_xfer->bounce_buf,
+			       dma_xfer->len);
+		kfree(dma_xfer->bounce_buf);
+	}
+	kfree(dma_xfer);
+}
+EXPORT_SYMBOL_GPL(i3c_master_dma_unmap_single);
+
 /**
  * i3c_master_set_info() - set master device information
  * @master: master used to send frames on the bus
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index fd5f35b2385c..4188a6bdca12 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -549,6 +549,26 @@ struct i3c_master_controller {
 #define i3c_bus_for_each_i3cdev(bus, dev)				\
 	list_for_each_entry(dev, &(bus)->devs.i3c, common.node)
=20
+/**
+ * struct i3c_dma - DMA transfer and mapping descriptor
+ * @dev: device object of a device doing DMA
+ * @buf: destination/source buffer for DMA
+ * @len: length of transfer
+ * @map_len: length of DMA mapping
+ * @addr: mapped DMA address for a Host Controller Driver
+ * @dir: DMA direction
+ * @bounce_buf: an allocated bounce buffer if transfer needs it or NULL
+ */
+struct i3c_dma {
+	struct device *dev;
+	void *buf;
+	size_t len;
+	size_t map_len;
+	dma_addr_t addr;
+	enum dma_data_direction dir;
+	void *bounce_buf;
+};
+
 int i3c_master_do_i2c_xfers(struct i3c_master_controller *master,
 			    const struct i2c_msg *xfers,
 			    int nxfers);
@@ -566,6 +586,12 @@ int i3c_master_get_free_addr(struct i3c_master_control=
ler *master,
 int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 				  u8 addr);
 int i3c_master_do_daa(struct i3c_master_controller *master);
+struct i3c_dma *i3c_master_dma_map_single(struct device *dev, void *ptr,
+					  size_t len, bool force_bounce,
+					  enum dma_data_direction dir);
+void i3c_master_dma_unmap_single(struct i3c_dma *dma_xfer);
+DEFINE_FREE(i3c_master_dma_unmap_single, void *,
+	    if (_T) i3c_master_dma_unmap_single(_T))
=20
 int i3c_master_set_info(struct i3c_master_controller *master,
 			const struct i3c_device_info *info);
--=20
2.43.0


