Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135E6CD98EE
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:35:36 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10980.1781685328902119747
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:35:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Pjp7yESk;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.4, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcNBBsjc08Q/Ri5aZyb87Dz2nwulggPgasm+7BBM5nSKw6okLRJ/h1BYvtvYD9aGg+weNkW5e0f1C28X603dZZtVLJd95nWw5UQULiOrkqXkgFQ9+nWEobiKVwjp4G125EKDyU0UEwaJQkBxswOd+xTwXaQDRBu96ZNfGknNwwy6CbJCdO2KJpYacVDOVrt3RRuRF5fFcBbz40NR1+U/oIm+xAde47tdmVs7O7m0LzqdSv7eaMOQoAuGqh2HSeXVDppMF+bj+qbbXVwbsqQe+vcAAM97jhHTzUasZFXWoBLm0+8zaLv4IJhCFV9WS1kxCh9VVSmw1vS8B20Ddf3jiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKBPJBQ84PaAPK40ZoLMerFDTID+6V95ddec6EAty8M=;
 b=xbGX6i4y0zN3N1DV+dk8WqXz8Pn1KGK5v2IiFdj8uJcMD6XzeDdH7XAOwzSPIYN8LfzqaGf1IF3tI+AqmlUKgLMxR2YdNSI5dmsjQBSmgcv96teJfakOsDNKAOjfEoCNtYlklu/xWUqD2SX0CeGcEwY2HeFeKglq5MDkKywRoR0AMTzetJCgxnLVjykzKnFTqcDECGerY9djhpwxCQZOaD6m6x90KXctwdayP7/JNW9ER+OA0SJ48EhgPvZD27RH3UHyP1SJMvBO9euOSmxDqCzorwOTyJq1TbM7kLRsjIIPeTTX3lIplA5F/ku1ZUoG9RHb+InS5Y5UdXKacCs0fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKBPJBQ84PaAPK40ZoLMerFDTID+6V95ddec6EAty8M=;
 b=Pjp7yESkUOywN3DqDdN4wDLptZmtn1mlBbyuXz5CTBotYiE8PJe/Zysh2vT6OWas+AxWZb7jTKlLdcURAOXNSHLpqb77NWKUc8+60UrM1eYR55psFJ6HJ2Ippxuz3Fk9tFXOSJJDHzJ+Moo95XL6vCLmqrbMIX0flXwMCq2mWeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYYPR01MB13245.jpnprd01.prod.outlook.com (2603:1096:405:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:35:26 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:35:26 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 01/24] dmaengine: Add devm_dma_request_chan()
Date: Wed, 17 Jun 2026 10:34:39 +0200
Message-ID: <20260617083502.1074160-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYYPR01MB13245:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a62e584-b43f-49d8-68a9-08decc4b6130
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|52116014|376014|1800799024|56012099006|11063799006|6133799003|22082099003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: 
	vNc+bA4RcgCjRSsydZnno0Y9Do4x1mnCYRFDOiIMbFMIjOhNAPY9wzMp4sHdk2GdYuMc20egQpOQuAiABJMtgxPZXi9HvV6k8kfAx7HI88DELkKlT3+OO2DQisqxo/klFjEGvb5QqktQ5gfAz8WVUYAS6QMI8jcoT0YBCGnBY4ZX3d/7fAl54+2tNQFS+dXpPDc4Pe/qZ95LiBrfZxE5YoGG0sTBWf9g9jxn/8bxzkMcRTKKF0NoxK1EIooripFHweaJH4EaiqxuOyDiTjxcnsnfI+EFa2hGw4yAhU28PN9OOSIvD2lafNi9k7skvQAr40tvndjYf8VIcPlgT0iY7QXisqBQvcXYygz3/fgf7sAx6onSAzC2RtiObpAginjeMff+yeTekifmrauv5ysHIiW6HMU4XTmKnTZ9M7uue8u376HwNLnEhIRGKXhEnlOWbpVvWqvxmPgN/WKb5/RnvMR9A9AnNqT4sxDugLi+8iOPLyVzFgIOE7rGZmglOuq5jxic5neJEsDFzS1Y572rfHnhtE0xcObpz6+dguN1vsU9pfvyqho4vBMAwuYzzYpvcFgraAi+P0igHnYdoN1OAxIY8x7Mx8AElw0UwfG/00WCE7yeHjszL8VuzO4J6ydE8DcvDK8oEzoGqytnBTnpCWEW80LYbktZ7PVG333xUHSzM5gYnJZzs3P+b48Q7ha3uqmnUYF/VBxIvPAxWqOtY4LXgWw+MMgj9k0G1U6pK0g4AL/yCdrrDTJirUSjmP8/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(22082099003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Zp91trIorOIeZULvHPkeV5+/tj07d8QzIpoibp65tZb/iE49ohaXmWO2EjLf?=
 =?us-ascii?Q?Mydkz5ybcshQ9PjtwW0+IasHmiMAJ49hW5w60WENnR90NAhF8UCRHV2HOhN7?=
 =?us-ascii?Q?vG/8GKnNS+P0qQObCyyMCpI02ykovI60br6sIc5PfiAndrqjxpusEAKfHA/E?=
 =?us-ascii?Q?VbDP3usEK22XwQYH1Vv0lZ6ZDjnMd3YJhWC5ZpumNFQpIGHOti43iIFY/LqC?=
 =?us-ascii?Q?XkLKiuP4b7OfR49WagcCDGHEumwxg68xBdl7L3Jm+IMXSUfAYYL2rCiBd0id?=
 =?us-ascii?Q?Er9Lagkw1sBUT3VjIrCRb1xf15A1umSusaaOV3ynTFj0uDRPujGJQ60vFFGc?=
 =?us-ascii?Q?9W/9hQ4Wzb5kqFTEuAxVF3e9eCDeS+fy9f09R3YApJP/rGXBRNwjmWI+YXT2?=
 =?us-ascii?Q?YsMy+cuYv7TazCNqwc+UvTjGr2F1vJ5EPqBuJ4HMYp+hqZqEFNvJodxONmUE?=
 =?us-ascii?Q?MnI0aWfDYK5610LExY+cruWAC6Oi1KA0IrbDf1rUY8eOGkINnmtd+zQDM40T?=
 =?us-ascii?Q?P/Yaz09CgdQZwxg2XgaQRMiv6Utm//PTeO7nmMYrTY3OK10dRw+d73vsJNIG?=
 =?us-ascii?Q?abTsxLgNRAW2TkecKeyiTmo225hYKFQ1DS37VocGzanKbTBQp9iRNNK1882u?=
 =?us-ascii?Q?AcbhB9IOpO4ASh7oNB9uZOf/VIT0zmIYKZfinmAFx9HqOy7tVj6X1+Q/lNCm?=
 =?us-ascii?Q?k9uNRjqCdZauQWtUCpuj2cAEHwb+O/7H79dfZg+zYXlVmbLwTXj8eX3fCNjP?=
 =?us-ascii?Q?NXXgHliYUsRq7GtHwXaBpl7GC/hf9olARE3yyP5fNBV9xBqQw0Bs1AzFPWmM?=
 =?us-ascii?Q?RSDaN4gQKjTN4NrT8HeBl6T6AZ4+lUy/GijiYsiVE5gA5DZ33gBzbNOQzohw?=
 =?us-ascii?Q?p+fcfABXhVux/l7YDgZwWcTomqie0Wz/taDgk8pZQV6JG8Cobvg9+UGen0Xo?=
 =?us-ascii?Q?lbCI5w3yYK3rBVYozIj+iUJELD/vFca5/RpUCgwotbW/HWhxZKOKMwNM4e4h?=
 =?us-ascii?Q?3NyJiy7EIIFNu6h7kLyHH/JeTq/vRYDbSQNy2L2dIlz4FDfXK8SadjrNs+Nr?=
 =?us-ascii?Q?UOvQMtP7CmGR8jDnkOPwf83fy3cgq4DPQqlxhIVxp0S7Fjt7QxMmsdKCxbHM?=
 =?us-ascii?Q?QBlI1TLsEuq9gdeBQeU+LCxRfP5K1J/yjiQXtYs0kA+Nc7krywgiY3mb0Yvj?=
 =?us-ascii?Q?M9dRHlcoEWjNjiJrOPD9BcwQWxqNyf5/oN94KujYSVc9yqTXx+Ym1k5tazdQ?=
 =?us-ascii?Q?upqvCvtHRzjIpbldW3l7jklY/5LoHn6F2JSCe5tlf23PiyEcjC7Sq4pZRR0e?=
 =?us-ascii?Q?vvbr7KNpSNpNBkuW3y2slfAq0r+Q0FXU6Oy5+HN4Il4TvNewzoSx5ijpk9fi?=
 =?us-ascii?Q?CscChhpi4tMp/YmzcVmB1CJm8vhbv2C7KsPeLkVLTKqoKJ8TzPAoijFFATOO?=
 =?us-ascii?Q?ZQgBfK75yrnp0YgB0cr6g6jdSlz/E7T+m8Ym3LNJwtYKpG/ecLWDP1KN27Zr?=
 =?us-ascii?Q?8hHsyrMgLm60IsVFhgo4pZdI6OUQqAHKYATq/5W8TbNLSSZEls15w57Jqe4U?=
 =?us-ascii?Q?ZO/Q03OLdok0XPzkgpZJsml66JZhSH8LA5GqI8tp72znwSHxwYlukvr6K6FA?=
 =?us-ascii?Q?oeMNT8AGCKyd0sGyBO7QYQInT5voiJWmCP0k49XGQswRh0Vl1Dg5uSi2aqvk?=
 =?us-ascii?Q?5FK1EeUkVQxUdnToKiQx2xNlNVg7RCsTUr7LV6Xo2iJZBY2ulQnFYaRV4VgI?=
 =?us-ascii?Q?bzCVAKYEtsq+YObySN+fIIkCwcGcLODLk9vnC/JhztEQEeXcdSO6?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a62e584-b43f-49d8-68a9-08decc4b6130
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:35:26.1862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5TZnROsa8uIlfEXLlPInR0Xm8mEXSEnBmHXVrfuAJGXQlJDMhhjDwQZFfGAn7xuot+BvP3Zobx8wWgDjbWDMMeynXXJ77txe6v1dl+RPSKL4GoIW0BiptfFGSq+A1G2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13245
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:35:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23193

From: Bence Cs=C3=B3k=C3=A1s <csokas.bence@prolan.hu>

commit 08bf1663c21a3e815eda28fa242d84c945ca3b94 upstream.

Expand the arsenal of devm functions for DMA devices, this time for
requesting channels.

Signed-off-by: Bence Cs=C3=B3k=C3=A1s <csokas.bence@prolan.hu>
Link: https://lore.kernel.org/r/20250610082256.400492-2-csokas.bence@prolan=
.hu
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/dmaengine.c   | 30 ++++++++++++++++++++++++++++++
 include/linux/dmaengine.h |  7 +++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c1357d7f3dc6..02c29d26ac85 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -926,6 +926,36 @@ void dma_release_channel(struct dma_chan *chan)
 }
 EXPORT_SYMBOL_GPL(dma_release_channel);
=20
+static void dmaenginem_release_channel(void *chan)
+{
+	dma_release_channel(chan);
+}
+
+/**
+ * devm_dma_request_chan - try to allocate an exclusive slave channel
+ * @dev:	pointer to client device structure
+ * @name:	slave channel name
+ *
+ * Returns pointer to appropriate DMA channel on success or an error point=
er.
+ *
+ * The operation is managed and will be undone on driver detach.
+ */
+
+struct dma_chan *devm_dma_request_chan(struct device *dev, const char *nam=
e)
+{
+	struct dma_chan *chan =3D dma_request_chan(dev, name);
+	int ret =3D 0;
+
+	if (!IS_ERR(chan))
+		ret =3D devm_add_action_or_reset(dev, dmaenginem_release_channel, chan);
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	return chan;
+}
+EXPORT_SYMBOL_GPL(devm_dma_request_chan);
+
 /**
  * dmaengine_get - register interest in dma_channels
  */
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index b137fdb56093..631519552c5a 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1521,6 +1521,7 @@ struct dma_chan *__dma_request_channel(const dma_cap_=
mask_t *mask,
=20
 struct dma_chan *dma_request_chan(struct device *dev, const char *name);
 struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
+struct dma_chan *devm_dma_request_chan(struct device *dev, const char *nam=
e);
=20
 void dma_release_channel(struct dma_chan *chan);
 int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)=
;
@@ -1557,6 +1558,12 @@ static inline struct dma_chan *dma_request_chan_by_m=
ask(
 {
 	return ERR_PTR(-ENODEV);
 }
+
+static inline struct dma_chan *devm_dma_request_chan(struct device *dev, c=
onst char *name)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline void dma_release_channel(struct dma_chan *chan)
 {
 }
--=20
2.54.0


