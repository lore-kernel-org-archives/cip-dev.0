Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.474.1795708583622263499
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:56:24 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=gTUVLW5G;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.21, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJIUFonjhVtjboeLJ0wrZ5HS0/q1yU/Ld9q+IVKUOHcJBVQwaix59zahlebt+cZVMC1OdC01XfqEN8M+6k6/jZfPfDjBpohU1oH5Xz3vDQ334kOtrCKmsK41BNFJTE1Q6D0N4VWrTm7EHrf8ReUuKk+GFBeNbvUgfxNjIj+1uCOa0Zp3Gi2ZkyBW/rk6fVLSB10lokgo87ifypCq7JR9IQm9ZvuUpVkhCepCXMdo4bLcMbVWKjDXLogjyuAgbNHdlu2u6bgAUPCyCnyRM2+oevj/LnZjovTfofXkkYax+fBseX+PMGAoanGU9AHq7kqzmq0c36CLdOATjzzoi/eCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yP7HEqspqA7w5T6efYTuCf0lcHysUKBh27/65kPBxPE=;
 b=j6vdMTx5Z/Rz+nYwmbBY8cVlYl7ymJIfVfaaV1wSIgIpFco5CIRupXPG4jbQZt6BN4WGEmM0ty/SdDLLWzddvwLFa+Zj8awKn6o9D4zicPwGt5a6Jqb2YUAPaV8/kU/Rbfm8TBw8c23yPbGCcihsrcPfcwezy4V+o4fSk2MWtbst/SexThbyWrgf11iRajkJaFSqEl19rmXb/8W5eGIgoFixJeUHK/dXxOp+rpEVtk2Edz3j3S/bdty0R2lZBWNGoBfLK1YV9SfKzS4LP1N0gRuGn6fZVxpeVWKz59rRHkqd0gS6E53hblgbjjgx2YUMxN2m3YznupM7epBKgSrIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP7HEqspqA7w5T6efYTuCf0lcHysUKBh27/65kPBxPE=;
 b=gTUVLW5G/8ns1/4yaAhzG3guxoC3ST+BVgxI7edXY5upPcLyM+QOmCDk4k4bxCkHzAoEFdO2SjOj5iEySZpu3mMYjF+HB6p/IszK8eA5LzdqF1CDqg8PfU55Hu1qPX99Kyz1NswV4yP8QjMvV1nGe3zgpY8E1VE87FoP3UqmRZ8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS9PR01MB16957.jpnprd01.prod.outlook.com
 (2603:1096:604:410::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:56:22 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:22 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 06/23] dmaengine: sh: rz-dmac: Add device_tx_status() callback
Date: Thu, 26 Nov 2026 16:55:28 +0100
Message-ID: <20261126155545.3834937-7-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To OSOPR01MB295138.jpnprd01.prod.outlook.com (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OS9PR01MB16957:EE_
X-MS-Office365-Filtering-Correlation-Id: fe34f147-4182-425e-80d0-08df4bd5d190
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|38350700014|261021121427099003|56012099006|10067099003|11063799006|261026130827099003|261028144727099003|261022105027099003|261022115727099003|261022113327099003|261026140227099003|261021133027099003|261026135527099003|261021130227099003|261021123027099003|261102123227099003|261026121527099003|261022075727099003|261021135927099003|261009221227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TP3CdtBWVqK20tIn8pLka63vjAv3joRgF40WLkP9RaljVoPiyO8O+HCBRXYut5Sj7AeeCwlNuiqx7443VmZfvWU+LYrQUsOJp+JvW2UFgpv9BC7/Br3rpEGi/UkG9ta/qT+diU34gdo9RJrbBvyKUxkxoljvJF5pPXCqnXB0fledJidrCr+XXwBYNKFtTSFDUbsgaVanMVpoDL9eMrIJE3nhhvSr5ohx3h5sda2xdz63t624lUbd4XoQg94OF6L2gH3oBnsW3+vK5zjh7ft5JBpXW9xE66YEdpsxfaUAwQzakiUVWKD8jPYfALrM4l1BfQF1u1oaaveGx6KElaAqCwmIrCvpV+Vmri6vIoqEnRMS0VBnWTeEW4FN2DNgz/nfndLz0NhJTUbetyK2G/Z5zFL3dm+i8kL4lu5SOvfJ0S2mkLmzf1BiDHuuwsjh5cJfUvRRu6RiOlSBtO6EcSXczKpQp91naFkJUBpLgrCIA3gJvil1ZRgLmI2rTCnVWx2S4EHCYJFMYJauHnEy6zjLuyxnYeKjvWBW3ZfG9gJqijhfa3gxN2CXFPcQkGSWhGeC8vVL1IGechXqiig/Up0i1rUfZ/uZYETOY6/Nr3fHoqODL/xPZMSwK79vba2Ue8gI72i8OXzWAtVcI5fEP9kpuoLib6KmGRuUbdFcxl2N7BU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(38350700014)(261021121427099003)(56012099006)(10067099003)(11063799006)(261026130827099003)(261028144727099003)(261022105027099003)(261022115727099003)(261022113327099003)(261026140227099003)(261021133027099003)(261026135527099003)(261021130227099003)(261021123027099003)(261102123227099003)(261026121527099003)(261022075727099003)(261021135927099003)(261009221227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vn1wyU3HfMdBAJdt3ldJDugSlfw8O0J9D/G3vX88mAA/8FR4BegPD9JkpjmE?=
 =?us-ascii?Q?YYhvhshJZ4A95IQsw7etAKUZGBBgb5u+EFBcbM1pdYCp0wdfAuoB75Tdmy2X?=
 =?us-ascii?Q?PU9LuRIvGroBKBLE5CbiZCo5qIaVmmdjJtyhMBaPBvzNj5EsHw+051Vy4IFt?=
 =?us-ascii?Q?n5wuvXOulWlI+Ih3bhCcEktwJtoTjo1iahzxrYUJ6m3fHxvridM1C8sEYCkU?=
 =?us-ascii?Q?fl6ZOoYzz9lQDniRbLaPWWWdZEcDhVYqubXEoAc1AtJcl082M9UPH9CRI/Ds?=
 =?us-ascii?Q?zYE6kxD6SwxnAEuMV4vJFqnCR+lhwZWoH8zg2zV0Xufd5/JMT1WYxfrC+x6Z?=
 =?us-ascii?Q?wzc0S8jW6w4BUJVOpylwUZvcr6hzy5YR5fb6ubYDruzKUySj97+k+U/OXqdS?=
 =?us-ascii?Q?xj4gzqvgrgFKi/+28LvQ5h/lhMqJMJlOUINlPAgg/3E/CiEAumz2yjJ8z/X/?=
 =?us-ascii?Q?Ev1TNZCSD/Z05R3UnkWSjKoxmW1WNTMExioQjb216T8GG/IKntObSQu9PUtv?=
 =?us-ascii?Q?26ud+7dbNYt31xcYINKYOe/Dh1nzVp6KK0tTGaReaC5GZtKWEzL+9SooLFl5?=
 =?us-ascii?Q?tYy4Y9cz+Sb+iBWq2BXeL+NDzfzHchJm4e5C5ff38+cXPgdEO+QUNXgN7g+5?=
 =?us-ascii?Q?9CoQN7Il7BU9SQoHUDEiuBfHDnP+qx8t9kTJ8o4ASq9/LC/gCOMhFqFSvXwQ?=
 =?us-ascii?Q?XdJfRkRenDMj9izl3pw32wvrvFEObpbW/GjHb3m6B3keM42EoLevEgCUcb8t?=
 =?us-ascii?Q?kVoro/lGKtjcgbyIDwoAOMkF/gl6nSRMWK49jKt84/onRPyB+NrFxOxJVHas?=
 =?us-ascii?Q?dvEZTnKd6CxPZu7Fng+OA8KKEc0irZYRZMH+/ULYxp9G3J8XIv58adEsYB1a?=
 =?us-ascii?Q?F3aZhn39d9VjiKFt+h5Fu1eD5aSOcs895uRZ3JLjsXGM0NDTZHl6kOWCCwYF?=
 =?us-ascii?Q?goJMFFIbGYTNVoakYOa5kOwtFMbjJfe2FvX8uG9Pqalrf7yC6inLYl3O4+nf?=
 =?us-ascii?Q?/alha7yodhsU8bS67rOz/LzXOAyYRj8yIrVoczln0hLFLHNWT5mjmx+Rq2sU?=
 =?us-ascii?Q?WBYDqhNRsChYIFMuUoEx8jKqVXZ5pmHWLQYyxMvy+T4fyhRCVMfLIKJ9uNGj?=
 =?us-ascii?Q?T1nejJsJxZMBHmQXwZfybhTLIvblrdU0/7RzzWB5q/2ei9V+anlbT5+nxKcT?=
 =?us-ascii?Q?ee7nxZagIuqt94SQ68UZiM0qUbQloG0OwbhnAdW/QD71xOZTJLioG6JYiSbi?=
 =?us-ascii?Q?FT0GcwkhcKx9ahH3HLD0Cj5jodm+57YfYju2D6b4ACYoy3J20cfE7YwUycMZ?=
 =?us-ascii?Q?L1C5ESrBLvuFLL+kOE3XddCouj4VdxknkWM9G/u4Y3FIE0ZQp82NUuRYUpUQ?=
 =?us-ascii?Q?DHns+MRmnPTCNfbsWzml6KazV60rM+FecTS/6HMFuCg4YU0MruIyz4gMOReU?=
 =?us-ascii?Q?1qeh+cf5jx1x7fyTDP6qu/eiNWzrgo+rvtINm09ailXAFaYuBI4g558w6lgP?=
 =?us-ascii?Q?TpKLoWzUbLbgPgwJRPeK793aRbaL7D7b1s+KZveCoyfKJX3v4nzOPmK5ZRlZ?=
 =?us-ascii?Q?ZDd153nD1W5ou4S61xTXFR6FbA1ZF2oGHGpJ42/p9dbcLasmKyjyEbC9Ebe6?=
 =?us-ascii?Q?zYeL8m6crqtfSgJ3YMtdIdf5ZWOZDy0ROgfB5geEsV+1qjjlJe37twkt9f9E?=
 =?us-ascii?Q?VCUja2rJlIR0M4VcC1585i59Yhow+DVd+eLrRAvf8EcBnLJ/G9IkknQTGjd8?=
 =?us-ascii?Q?uBEqaUP+/2YLnpy32c8O4CT5linm22hKIKtEPAeKyFMh43Z5DSh3?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe34f147-4182-425e-80d0-08df4bd5d190
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:22.6541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7lfa5BJUgiu/3Hk4g9xjhTJVhqcy1lvi4hfnt4vDDVsS95WxYDChb0oyLQxF2D1n28kYCDNAjFtwTKisdPOPwCluJFw63QIZN6rQ/t8hXavF7R0ZDCCIq9A0uqBpkc8n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:56:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25197
Content-Type: text/plain; charset="utf-8"

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 21323b118c16d287355e6497e1098ce1ca348bd6 upstream.

The RZ/G2L SCIFA driver uses dmaengine_prep_slave_sg() to enqueue DMA
transfers and implements a timeout mechanism on RX to handle cases where
a DMA transfer does not complete. The timeout is implemented using an
hrtimer.

In the hrtimer callback, dmaengine_tx_status() is called (along with
dmaengine_pause()) to retrieve the transfer residue and handle incomplete
DMA transfers.

Add support for the device_tx_status() callback.

Co-developed-by: Long Luu <long.luu.ur@renesas.com>
Signed-off-by: Long Luu <long.luu.ur@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Co-developed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260316133252.240348-8-claudiu.beznea.uj@bp=
.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 144 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 531515b2719c..b518c3d9c00f 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -124,10 +124,12 @@ struct rz_dmac {
  * Registers
  */
=20
+#define CRTB				0x0020
 #define CHSTAT				0x0024
 #define CHCTRL				0x0028
 #define CHCFG				0x002c
 #define NXLA				0x0038
+#define CRLA				0x003c
=20
 #define DCTRL				0x0000
=20
@@ -676,6 +678,145 @@ static void rz_dmac_device_synchronize(struct dma_cha=
n *chan)
 	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_=
no);
 }
=20
+static struct rz_lmdesc *
+rz_dmac_get_next_lmdesc(struct rz_lmdesc *base, struct rz_lmdesc *lmdesc)
+{
+	struct rz_lmdesc *next =3D ++lmdesc;
+
+	if (next >=3D base + DMAC_NR_LMDESC)
+		next =3D base;
+
+	return next;
+}
+
+static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *chan=
nel, u32 crla)
+{
+	struct rz_lmdesc *lmdesc =3D channel->lmdesc.head;
+	struct dma_chan *chan =3D &channel->vc.chan;
+	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
+	u32 residue =3D 0, i =3D 0;
+
+	while (lmdesc->nxla !=3D crla) {
+		lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+		if (++i >=3D DMAC_NR_LMDESC)
+			return 0;
+	}
+
+	/* Calculate residue from next lmdesc to end of virtual desc */
+	while (lmdesc->chcfg & CHCFG_DEM) {
+		residue +=3D lmdesc->tb;
+		lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+	}
+
+	dev_dbg(dmac->dev, "%s: VD residue is %u\n", __func__, residue);
+
+	return residue;
+}
+
+static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
+				    dma_cookie_t cookie)
+{
+	struct rz_dmac_desc *current_desc, *desc;
+	enum dma_status status;
+	u32 crla, crtb, i;
+
+	/* Get current processing virtual descriptor */
+	current_desc =3D list_first_entry(&channel->ld_active,
+					struct rz_dmac_desc, node);
+	if (!current_desc)
+		return 0;
+
+	/*
+	 * If the cookie corresponds to a descriptor that has been completed
+	 * there is no residue. The same check has already been performed by the
+	 * caller but without holding the channel lock, so the descriptor could
+	 * now be complete.
+	 */
+	status =3D dma_cookie_status(&channel->vc.chan, cookie, NULL);
+	if (status =3D=3D DMA_COMPLETE)
+		return 0;
+
+	/*
+	 * If the cookie doesn't correspond to the currently processing virtual
+	 * descriptor then the descriptor hasn't been processed yet, and the
+	 * residue is equal to the full descriptor size. Also, a client driver
+	 * is possible to call this function before rz_dmac_irq_handler_thread()
+	 * runs. In this case, the running descriptor will be the next
+	 * descriptor, and will appear in the done list. So, if the argument
+	 * cookie matches the done list's cookie, we can assume the residue is
+	 * zero.
+	 */
+	if (cookie !=3D current_desc->vd.tx.cookie) {
+		list_for_each_entry(desc, &channel->ld_free, node) {
+			if (cookie =3D=3D desc->vd.tx.cookie)
+				return 0;
+		}
+
+		list_for_each_entry(desc, &channel->ld_queue, node) {
+			if (cookie =3D=3D desc->vd.tx.cookie)
+				return desc->len;
+		}
+
+		list_for_each_entry(desc, &channel->ld_active, node) {
+			if (cookie =3D=3D desc->vd.tx.cookie)
+				return desc->len;
+		}
+
+		/*
+		 * No descriptor found for the cookie, there's thus no residue.
+		 * This shouldn't happen if the calling driver passes a correct
+		 * cookie value.
+		 */
+		WARN(1, "No descriptor for cookie!");
+		return 0;
+	}
+
+	/*
+	 * We need to read two registers. Make sure the hardware does not move
+	 * to next lmdesc while reading the current lmdesc. Trying it 3 times
+	 * should be enough: initial read, retry, retry for the paranoid.
+	 */
+	for (i =3D 0; i < 3; i++) {
+		crla =3D rz_dmac_ch_readl(channel, CRLA, 1);
+		crtb =3D rz_dmac_ch_readl(channel, CRTB, 1);
+		/* Still the same? */
+		if (crla =3D=3D rz_dmac_ch_readl(channel, CRLA, 1))
+			break;
+	}
+
+	WARN_ONCE(i >=3D 3, "residue might not be continuous!");
+
+	/*
+	 * Calculate number of bytes transferred in processing virtual descriptor=
.
+	 * One virtual descriptor can have many lmdesc.
+	 */
+	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, crla);
+}
+
+static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
+					 dma_cookie_t cookie,
+					 struct dma_tx_state *txstate)
+{
+	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	enum dma_status status;
+	u32 residue;
+
+	status =3D dma_cookie_status(chan, cookie, txstate);
+	if (status =3D=3D DMA_COMPLETE || !txstate)
+		return status;
+
+	scoped_guard(spinlock_irqsave, &channel->vc.lock)
+		residue =3D rz_dmac_chan_get_residue(channel, cookie);
+
+	/* if there's no residue, the cookie is complete */
+	if (!residue)
+		return DMA_COMPLETE;
+
+	dma_set_residue(txstate, residue);
+
+	return status;
+}
+
 /*
  * -----------------------------------------------------------------------=
------
  * IRQ handling
@@ -994,6 +1135,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine =3D &dmac->engine;
 	dma_cap_set(DMA_SLAVE, engine->cap_mask);
 	dma_cap_set(DMA_MEMCPY, engine->cap_mask);
+	engine->residue_granularity =3D DMA_RESIDUE_GRANULARITY_BURST;
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
=20
@@ -1001,7 +1143,7 @@ static int rz_dmac_probe(struct platform_device *pdev=
)
=20
 	engine->device_alloc_chan_resources =3D rz_dmac_alloc_chan_resources;
 	engine->device_free_chan_resources =3D rz_dmac_free_chan_resources;
-	engine->device_tx_status =3D dma_cookie_status;
+	engine->device_tx_status =3D rz_dmac_tx_status;
 	engine->device_prep_slave_sg =3D rz_dmac_prep_slave_sg;
 	engine->device_prep_dma_memcpy =3D rz_dmac_prep_dma_memcpy;
 	engine->device_config =3D rz_dmac_config;
--=20
2.54.0

