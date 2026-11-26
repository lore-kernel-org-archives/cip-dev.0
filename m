Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.11])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.286.1795708121473175353
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:48:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=psHRFpw9;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.11, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbCsavHxD72Aq/USPcwoI8iJqlYOGi/H2fd8rRIkkc8TP1yp0xkDfjOAwNr8a0++kiNpM+Q/o510rtPv7J/kTIITpP0bh7EhAFvYynNNNt9x859si+K8UDFQNeAIqrOHJd7yHUPOxxmDdpuBMCBO3KXhc1BpeH6jaYjvLVSuXiqRDEcEJ54lNmZfHgy5E8YdYpJ7OW1ZqHpDx7KAgUHP/QUEuxfwJhEYE1oj+9ov0Mkw2GGSjOONKPWgi6XygmGL/EEKWFZWGjHxufmUu3WJ6YEt89+dH+cBcmqWPddpsVJdgCvfuhFShtrqL/Z3n9XaZXSIlBaAyRgeo122pEqj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGkuHeJSuR8oZBYYrq/Br8gYiK9kZ81H7fr7nLfI3QI=;
 b=FZ6jx4BZaVz+w8u9u8aZCJy5BTvf/EJ/10GADuRAJBFJgCKNK37ZbUF/KAnGPV9jbQScKSehw38gCYsdktzdoCxvroCvOdfCLp4C/uCtW4BwmW4N6OJGuZhoZn19wt8O8dvyJ9dRgmmS6ZFY7FRAVPBYQd3xp92tGzrmW0KF6RgoT/XYLx5NT3USqCOJnS4NLEM/dw+/LLTtIPNLUjgRoJzVAzNSdYlbHHKmnFyWlyj3wRrbf1Y9jV6zuyHh3OnMVoIvPrW1XkewMcJCPEAj0MOiqx/kZsRv4AZmE4bKfYDcICMc+V/tvfhaNh9lTTFSI/UJhfMLM7mUIOKDGPCxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGkuHeJSuR8oZBYYrq/Br8gYiK9kZ81H7fr7nLfI3QI=;
 b=psHRFpw9Vw1qFYixPCKn2wkd7IC6iLM5n+Cuw+7Rhf8M4d70dXi5/MdurQMhKydzBwJqLtFbGYSRnUYZ8YYRFWcVabWMuNDVip/WbGrRLiz0n8L/mrmo79diCmKTBazbJZ7JQzyIjepsDi2oR2uN225aWXJTgABZ/5dm78y7FME=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB12784.jpnprd01.prod.outlook.com
 (2603:1096:604:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:48:39 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:48:39 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 10/27] dmaengine: sh: rz-dmac: Add device_tx_status() callback
Date: Thu, 26 Nov 2026 16:47:30 +0100
Message-ID: <20261126154747.3832917-11-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OSCPR01MB12784:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8573db-08bf-4715-7553-08df4bd4bda8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|23010399003|366016|376014|1800799024|38350700014|261102123227099003|10067099003|11063799006|56012099006|261026121527099003|261026130827099003|261026140227099003|261026135527099003|261028144727099003|261022113327099003|261021130227099003|261021121427099003|261021133027099003|261021123027099003|261021135927099003|261022105027099003|261022075727099003|261022115727099003|261009221227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iosdRZevbs64GpXmPJmSm0a/cyQ/dRWfYQj7kGvsxXFbjwiFu4xHu5/IVGNcyWzmmKOc9xMHqVhQZFuIkBz1urw0MnEdexFXRxh1VCR7jv3G0xozYjWl7ZkVcmjrlRNx/X5fLHrQNHHTnZzYvcK18wcQOMLK2ESXsJutlzPcWL3pOrdBAnKzMHa/MAMp7BbDH4pA7Vhp6nIjmJEEyaGVLoru9x36NXiF4kN4xswK99ZxA7afzXnmnbCtj2+N9yqCjgYXBWqy55mZrT/ysUcCzneiMI4TfHGrZCvuoBWJ98op7UeF5m8NAJb7CnnDCyg7BEbKef1sUAf7C4+H9+LFxtrQGAWdNG5EFKZRIYi6eelnpRNXpIDVR1vrWIKW+2AygOgSMeLEK7FNiG5757WZf35MJisJrgmtG++rha/eiJegS+pCDY69OhQlpLLLxy02994ME1PMuzumYvvVGLq0l9UCQM0P2nVmHLqimaoiQXDzjGfjMNvgmw6WD78x2XrlR6ggztlUZwc8N65rR0HycaOSxkYFaAy2Bcwut/QpgxrhvUz+iQPGSocwojRZx+gsgvlRxsGJlWJotJv9C5ZAGuPHhgZwQz0ClJMJlDV/uHWzhYWNYPz4vUFXU+5yrcu/YMAAIczcI0dGWpWXew5sc+cVX0Xx3Y40M7Z/BH0lMzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(366016)(376014)(1800799024)(38350700014)(261102123227099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026130827099003)(261026140227099003)(261026135527099003)(261028144727099003)(261022113327099003)(261021130227099003)(261021121427099003)(261021133027099003)(261021123027099003)(261021135927099003)(261022105027099003)(261022075727099003)(261022115727099003)(261009221227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bc1/N00f/wsYosKXx1bXSV37vvSmPbzpwMSNAaeQNa0v8pTnro9n8Qz+ZZa+?=
 =?us-ascii?Q?m6kI5bbeeGuln/v7zdLQmvHg98rWWBe35Sire/M30aZN3+5kc1NzlpT8TXPk?=
 =?us-ascii?Q?TVKnxL+KuhvFVgIKaa1BzxEYN36ZCiuL2yCKXVFGnkQxv7qKZIUGqX8MrFg/?=
 =?us-ascii?Q?Aujb0Ff+dQy1nm5Rnsvu7GZbCLdrqNSXIsS9qpC/MX9CSxZn5HCOZu1zNkPZ?=
 =?us-ascii?Q?LbL/csqsR5il9BOVOUtgTN64GMS6uICy6ceWIm4icIIKFDb1ejfttRuboVdm?=
 =?us-ascii?Q?RfxB5MhQ0B9LuZYHi2f1i2ZCc4txq2lxDuzQlIgWPlYJFX4FxL4ETX2X7Qr0?=
 =?us-ascii?Q?wY4wGVgrW86rxlj8NAQm9n+5SwvH9IgeMDjLX63W+IGtbkj3JVMsxcHc8Zkx?=
 =?us-ascii?Q?EgwT72Ypa/3UIwBC4XvLlB6jqZM2SQx4wLZlxHph/gC3mOfibhkM6Momwoir?=
 =?us-ascii?Q?Ox1u8h+VVpbjw+SvLy2tYhWHVCezHWaE+STDN65Q7f010hSrnG/Jn4dU8ks1?=
 =?us-ascii?Q?GOqlFUVkwaMo7YUA1mqkKWwoXGK0rjX7yVNuGWkfl4BDgd4PdqrvKdRoQuyN?=
 =?us-ascii?Q?9qUARqWLSX3FimKnlM0s+FqoZkCbaaZqcaL0Y9e6haKx7g3RfO0GYr7/H5nX?=
 =?us-ascii?Q?OBG2NvQX8/0Zt7nHUBI91QrL+q88gdj0bojUueHY+uH8iaTLA96tn62J+V0N?=
 =?us-ascii?Q?woMhTe3tTqdwAH+F8NFcBlcA05zKwIKiLlPc74RmS+fg5NjjsCID1I0Dii/+?=
 =?us-ascii?Q?YYiDQqPwQxKwd/y4IEOnbNGM83iWwVHsJet5xdnVjrShZfUoFr59Lh1QfsgR?=
 =?us-ascii?Q?S5mOJy0+21uHrRv+tQpoPWYdlYFbx2hBoX16oBlQoRUPh8LMG2rQmdfbI/3M?=
 =?us-ascii?Q?G3TB2buR9dVOZHMsjeMc9pW+n3Cme68ASoWa2KikmKBEqdyu0yO1zc+1g1bG?=
 =?us-ascii?Q?oudRqP90/QggvEr09sPY6mbQowU06QTs+5ViBZmsMUnMv5Vobhc6/lQWGSVv?=
 =?us-ascii?Q?WOUK+oEnmTYJEoVgt8ivsMkIKT6k33hA+x1/1fkOokmyyKYEQeWSTBSdS205?=
 =?us-ascii?Q?wNcnDzhON+CKiNCqm60lA8b1JU/sxwHUxXkMmRKML6gl3B62MalFLbNGvgXi?=
 =?us-ascii?Q?p8+LVsJ8w/dIiB4QMZmsGUr8eFpgR7wyuogm9JjDiVXpB4KVrv1nMYWNsDO1?=
 =?us-ascii?Q?+Vxewc2M+70rLjLkNqpzv+/M1ue2VyruVr+8gXwuCLqvILpaGw8Y8QxNHYpO?=
 =?us-ascii?Q?nOi733Q+lPrBVJWWmD/4IQ370WAG0joa49ylPvKfB2X2IlCGH/LuVVVuG5/Q?=
 =?us-ascii?Q?PzjgOvp0DumqAOcPh1sAP6vTWACibTvxYKvLQKm74jF6jmEz0W/F8IjsGQFu?=
 =?us-ascii?Q?QE8gUSYbUEw0gcLv1bitJGF66S3iqTcxYRq7mDCHdw77hQYwHKdJ3nqMpwZj?=
 =?us-ascii?Q?aciw2xul7iYeU+kiYMzOyGn8SiYjEQNe2oHSbInFJiFBM4niiHm5jNit60lA?=
 =?us-ascii?Q?dePm1vhZAQM3dxrGHeQRtnm/e5AhebYO2Vzu+JjSPFn+Z1fewhTQ9d/L+Wdy?=
 =?us-ascii?Q?EIQDe/VudRKPh5hwSnFDd/sQmRjBeRtkrgb/IQR2HRzR83ho6WlVlbIcA4a3?=
 =?us-ascii?Q?O0m4xyb2jDRRO2NaMYvhTosJhw1CWk/qTIPHDCgOhsJzGBhBQV673YjIw3O4?=
 =?us-ascii?Q?knAxBUrYmqosenvHSeQCsSBsS2o96bJzSU0xtDxUs8EYZPADdkTVWKsW31mY?=
 =?us-ascii?Q?1fHIoV8cfJl/VAYdarR+IY41fyqLxRnZ/bV3yTlALqTz1JrPZw38?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8573db-08bf-4715-7553-08df4bd4bda8
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:48:39.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RirdduUoHFo0V6GaHEuGTjUajWp414cxdSW9AIrZJcUEG1c6lHYmL4fZee/y8fSEd7hXWwRdOD3sNbFs6uHSlicDwA7Zw7PZlrD5Al0kERjcwebPvJ0DhqKoxe2DL1du
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:48:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25160
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
index b4ec34a86f91..bf0d7b6f5511 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -123,10 +123,12 @@ struct rz_dmac {
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
@@ -675,6 +677,145 @@ static void rz_dmac_device_synchronize(struct dma_cha=
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
@@ -993,6 +1134,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine =3D &dmac->engine;
 	dma_cap_set(DMA_SLAVE, engine->cap_mask);
 	dma_cap_set(DMA_MEMCPY, engine->cap_mask);
+	engine->residue_granularity =3D DMA_RESIDUE_GRANULARITY_BURST;
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
=20
@@ -1000,7 +1142,7 @@ static int rz_dmac_probe(struct platform_device *pdev=
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

