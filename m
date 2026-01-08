Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF038CF6AB0
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:20 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3046.1767864673469472532
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:31:13 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=uZHu3vsf;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.4, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXSH/58IwM2wKaiqNJL126IaHBa9QEN5JIWVk33uOQoNQp4PED1cOdNMJwIuOmPj14lZy0FxAcwZtoSLFcHaf0hdu6NnHjHh0eEE94WXlr1y5g9nURfPAJhUTvQ6qxW5Mwue38PL1XPuOLpC9lpWm49CsNbsj87Gg/3SQ/BL9iM1xk1OnDZSFZvrv4bEB2vXKvrXDe9aTaEeKP1bIsLITFuyguYl5ngmVVjY5oIXi858FRmenh7rZxG5QcImGQQAfrsSzu1ajySTnrX2k7VNja38JN2FpFJX6GWPCpC388K1q2Omu0f2YD00r/bZLg2AF1axS3Zibjzovxzdb19ISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qOQ1xiw43q8QUchmT9ETmvpJ1kZJeczpFZPDukLT+c=;
 b=ga68NF4F+Kn1EDPauEinfHD/LAky2Ssb2u79SzcYD2z8LdWe6ivybOgSDd9RaSOfah1VzEaBTaMOachme6rgRbHSjNSRvCAkMxPeRyprVyoOhOgMd8d3b7n6CxmXHxdSWUhRg3bb4U7I0gKqj4c3W0NawKODWiMAybFA/P6UwVug0A8Yq+ubsc6VnOvLSuDbeVgHaDx0PArjlBo1Jd9sfkIrPzpIu940LaXGoPCoPhB06KCc77c5kA9wQxzISrJIVOtRgyJDnp3lsP5K3Tssjgl9IU62MFMUmvcdjSb6yjO58ag/yYMksH0tw7GtLp2dk9dHrtG2XQ4EIyxZUxhIjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qOQ1xiw43q8QUchmT9ETmvpJ1kZJeczpFZPDukLT+c=;
 b=uZHu3vsfIbfsruaBtoyNxb9yd/QU72rrQ7pIuqyk2iuN3hnh5OGZRhS1lqy5bvmL9bRuwfqGDMTgDiuekhqp9H3oy8M9Tf7np/vDFAo2vEf0qlyO2JBWE7xzlhWIkB+2SNv9tx+TJsJxT8RZeTVjAUXH4IiavRlSEN4L2D6QLSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14326.jpnprd01.prod.outlook.com (2603:1096:405:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Thu, 8 Jan
 2026 09:31:11 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:31:11 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 09/19] i3c: master: Add helpers for DMA mapping and bounce buffer handling
Date: Thu,  8 Jan 2026 10:30:13 +0100
Message-ID: <20260108093023.489513-10-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14326:EE_
X-MS-Office365-Filtering-Correlation-Id: 174cadb3-2de6-4454-88d9-08de4e98a8c7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?S3y0Zabo59hPOKIxXmapEv8Z1Is9EctYJ4mCwC4wwl1m9XcFX2X20R3OJxwc?=
 =?us-ascii?Q?MXC3etHQq4UArNN2aM7EBD9oVDugrWtG2IvEnSUon0441FM1AZMmWzO5/WON?=
 =?us-ascii?Q?J3TYIuOLgjaW0Dt42kiCmzZELs3J/B4NziGa6WuCB+Um2uUdDXQ13ycJeP9N?=
 =?us-ascii?Q?M0NKH01DlQHLbYTPSFr3IMWasf+fhLjd4nz3QjF0FrEEF1s/y3EHZzGCkPWx?=
 =?us-ascii?Q?ahMsTcEYAa4rtMrj4KBJaZKSEQnPhts0X0h+AyoFZOg59yzDXo2xWip/sv4N?=
 =?us-ascii?Q?HMEiymMvIieSZgIvu3X8eg8fEZSngKRWxADbl3obiW3ZeHw2noPwUloCwd37?=
 =?us-ascii?Q?6ktq057D0wtZtnLekW5N11vH9kYlRqMir1e3YvYnY0SmM83RWlEtrt9NZks1?=
 =?us-ascii?Q?Ve0JlFlSxKgRKBBiiumBwkip15VJLiZ71Xp7mmxkwQiZZRQ1Pqi2/SdKGNh3?=
 =?us-ascii?Q?460eCBywB3pwTv6lvhFejHdrGOglY9IjE8L1ePiZorfrtIlwYE3jFSeXSCB4?=
 =?us-ascii?Q?hez24jCwekRHck6r75++HuSUneVMm3RS0ZgqqobXZ6LKHF6Iwwx5sfEZDXHh?=
 =?us-ascii?Q?B81FXOYNV6CfZ8DadVNgnXo0n9OORqtft3iclYAxmikx7j1HtmAWRoDnZzCo?=
 =?us-ascii?Q?gWfy+eU6zulu5sRyOLAvdr8GgaARj1BYziVCo/ObePTOrCW5yGb5+8SrBtlK?=
 =?us-ascii?Q?QmfkxxkTNcaBvp76OQYdJA71oQ3LjQlxsobotK0u1fI8yb8a5VJA+/q1b68h?=
 =?us-ascii?Q?N6XWGAU3wUEK+pfQJ5bZGqw5NWrhJg1R+jAdPfuwHfvQiVQtdKrFopgigwMD?=
 =?us-ascii?Q?7BE8L49+dUWnSsBz+aMJYsPK4dvgt0Ft+BPTgBiAsa7w98bSRDgy13fLeqpd?=
 =?us-ascii?Q?/4duNALt3puM8Xh8Lrw7Yr/PBrM2BXRK/3S/TKSxirIG2oZyELBggW+Ng1q2?=
 =?us-ascii?Q?sNp796TUUrqfOgR2mxBGfHiDj99trwotkRv+sF95Yojcys7mGtgEV+3c1k3s?=
 =?us-ascii?Q?Cd3iDsKYxbmGz9MMrk/q+1Qjx0Z9nsfxLVbjWqQp+6h7fL0CEMrJnCZWOQYm?=
 =?us-ascii?Q?2mZCtw84imS5qb7qDIBx6vFXEEiDH2eVn1Ajws2BdXJLlodCW0TtReIyJFqU?=
 =?us-ascii?Q?/AgbQrEWF2rxdvSrQ0Q8WDMyNuqENzSAk63KnERPRQ7xRykR165I6jzLXTa2?=
 =?us-ascii?Q?0nuX2DTwHy3SDafy6xfdxS+okgNJnX0fEDhcIhH+eReZ4qotBlFjhjUlwNw5?=
 =?us-ascii?Q?+poErSgM7/7+600BjaQKwkoFHrRzdhu8NqamxXBZanGjBzTnBTcpPN4yxfGq?=
 =?us-ascii?Q?XjfeJuBtyf/EPLaXhd1553cPwBqn0XbIudOGOtYTpv+BKME4ro/NKrF8vyam?=
 =?us-ascii?Q?YdUEtliS+x0EZb4nNyjxm+kqg6TkVtmRg0p/8+y2ez36XoWybXAmYt7iVSL8?=
 =?us-ascii?Q?Sw0OFey61Q76PzrIbJ5mYx0MenfsNpekKOGfbH6QRYIxr3p0h2mVUUJQ0fon?=
 =?us-ascii?Q?JBHIq+E80biWVFmqpM+tHmObPfG/tENR5Cry?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5EB1OozJvAJXYQDWxIf8id506IEnnNijM7vKajEz/MhtSoSSlSAHt8u0epeN?=
 =?us-ascii?Q?F7th/QZ/skcKj58iI10kgwhcPWlwtSQn0Vki7ZTyst3x2JTLBcMdjP+B9FR9?=
 =?us-ascii?Q?4ZBpiMZfIZJtThoXCXokJRXJz0TvXtzRx70q8i6QMrIsxFGhz86XyfW/FAcR?=
 =?us-ascii?Q?kgwRVTgVAqLQ1EeZg17Jwyf5483YbdGKLc6EurVnq8E6YDztNlYkFGwaLKTF?=
 =?us-ascii?Q?2lXjcvHRApYkHrKfoysLmSkXgr2xWkwJO41PJWQdt0H2+PJHvzgp0m1E+qyK?=
 =?us-ascii?Q?XjUx22Ci4XkTJrUMAu6JmBryrezpTL8cZZrSKEZn9/114Xb2QKKnyP7XJVv3?=
 =?us-ascii?Q?BBZhs4CqrZUtM4uCkUpcFOxLibRr6oZESJiTNnc6D4Us4f3zbA4EV1s7YNO3?=
 =?us-ascii?Q?IA4gjSrlZfwQr1xhzCC+2JlF+KJSPWuGO+7zaujYfK3+BBAup+REOO4o01NX?=
 =?us-ascii?Q?5l66NRbfCMxLIPz46+gcGwc3OePAgP50h+NXgZ2IDO6Pd48WDN1dvh9agTn0?=
 =?us-ascii?Q?2Z6pTUReBnNESXoKSt0VGL2lTpUY104muEypODABR79L/X6JE3QPaxfTiFPU?=
 =?us-ascii?Q?2FNriyXBWqkPdkacJ2YQ/RPBHkfk0ERKfSkDwln9KAtPkY0r9VMRlMK5nu6f?=
 =?us-ascii?Q?Q/u3Br333cevv5hOZvoCaiDUYvdS9c/RFibMzoQRIBEW/okP8cnPmcbDQUeB?=
 =?us-ascii?Q?gbFqS2wVfFxL8Sq1hJDsa9g7n3bE3vaEGvzKrkgWkE0Yu8VepDmqz9QKurr0?=
 =?us-ascii?Q?OAR9jSMf6E6X+4vLCDYF3in19yViaGtSdI4HxlV3V/7IqVRoBl94pGKy0Vr9?=
 =?us-ascii?Q?yiTlZh6tps4WWqup33oL+JL3ZK7sKBkvuw9CMMnW/iWmKXbJoQQGLnGwE50Y?=
 =?us-ascii?Q?oSvejZADEL3+Lmp1glpQa8knv7v0twTJBadDQ8Vtg0TiuBo5nvF8ePl/MGTf?=
 =?us-ascii?Q?sVx6s49MkjW2jg4enMF+fXc2j60JKWobhFZFMgVeiwyXtBVpsF+/C03MSahZ?=
 =?us-ascii?Q?fnFSwo7Zggzrlo4sAXrt9WJeAGor9PhaViUIEl6ypSDAx3BtLdBJIMJorZoK?=
 =?us-ascii?Q?66/jbHIutMXwCbR4KzyPgt33eVFiFraQmOWRl+xwNCPz15sIvAXuTCfca2TL?=
 =?us-ascii?Q?fxqLu3jQw+mxyTPvT5v+vLICoHCqjeXpMBB29ma/hobtwBOBE878LZubZb4p?=
 =?us-ascii?Q?7O7lRZE4A5ZICUFdZYA89Zas5rwxTZh3/4fJx1RbJM/e1McE/dpGOo01hxx2?=
 =?us-ascii?Q?AzvPzAg6/y/o7p74GaWOZHwWeOQql872kPT9wCIr9is/WDztQ4dbzy1tY6WS?=
 =?us-ascii?Q?SeiuJTtntHJ4zkMIO1rdEpQeSwn+oYSEclIcsFlCV44OYel2CS9Bm9ZUOrRr?=
 =?us-ascii?Q?2btJzR+pTqAuFrgk0UCcPZbh1DmDxxlYDHPbC2TWUGzGS1BAHnHVZP8u5RPE?=
 =?us-ascii?Q?DnBrCmmkMKuqwDH4BOwJsWQ9Zw5faKgvFGQxNqBgRf5oSv+CUMTb+WYety9a?=
 =?us-ascii?Q?pPQswT2cMxVzPOiT8GzUHayJyZTEJ93z2NNZo3ZaTem0jUGGX9YOHfvaAeyi?=
 =?us-ascii?Q?snnuaGDKuNv04MiCPhehSIm0I2LdzvWwAM7Ohbwi8L4TvaqV0L+kNUDdyfMx?=
 =?us-ascii?Q?nhbDaFd7Bii+D6BNJdZhneLQ8EA0Slf6uP0TH3L8DPpJl5LMUnYtzTbM8jOu?=
 =?us-ascii?Q?zkh98fJYdCT6MYml09JQN2aobjY6pWcFUCRla0wOLAFLEr1q1JOnekLmvc0J?=
 =?us-ascii?Q?sUNFY82pi2KKa2nZYbCNiGcfdOWRRfjIi4e4Abfzd755eRx14xpi?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174cadb3-2de6-4454-88d9-08de4e98a8c7
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:31:11.0131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCLoBElRtsS1GHStnntEVtUtUjw0BbE9R0D2skPMNoVvFUEbV0KXgGtPxx0HQO2e32GOX4QBTt+cC7Lgl/g/TxIYfQKo3KNxpv1ATRC1klyv8QWH9mYWUPtmyK/8AXjT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14326
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:31:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21468

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
index 8e41c15d2c97..4675c72eea1b 100644
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
@@ -1727,6 +1728,79 @@ int i3c_master_do_daa(struct i3c_master_controller *=
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
index 043f5c7ff398..c52a82dd79a6 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -558,6 +558,26 @@ struct i3c_master_controller {
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
@@ -575,6 +595,12 @@ int i3c_master_get_free_addr(struct i3c_master_control=
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


