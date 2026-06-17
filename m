Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5E3CD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:30:44 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10728.1781685033650250753
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:30:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=nZkwMCma;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.41, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsn1xeOALa/GkPpKc4brYQ7XZfmMEHOfS86jXcXC/4sFiHuCWF8jSQOuF5sbpfpyxGyqf85ioEtZyxn71iQ7LpggoXF/JLM3shTzzl0HArvK3KrnjxK//JDIcnN2X6WMX1ifG/fQl0QL3Yxr1dZcv8Ynr9O9GU+7CmrEtCPx/JRkYvNaXmiXRD4z2uUdNMkdr5JJtJNK5q7xKZzh5RoeVO2gzDUvW5kwArrHKX/klsrDSJ/rovuGPUF6xDZeHplp69L0Va2tCntVHLWtGdkEbEyfZzoYp4r5cqIGcu9HB+zpJ5N6te2gj/VyFtwn2xmf1PRTimO/vqzy6YUIO6EL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTYvZs2QjFeXjFEysxk2O3kpy0KBxNxjlvM12uNr+oY=;
 b=o7mm7EHBZaCp2KjGMnMvfM2WRG4R62TgeBD+JhnYBNSuGNf1lOX/wff9vpJcN0vPL2JQ/2ZwK/LS/a7Xkrp+FDCp8dEGP2nNuHBZQebjUHEi1sI46i3fOxhYSJIdB9/rpiEpevPfCuO1DrZVSdfbqKgfi+3iyq12tU4jQoQ0RFcFx+XZncb8LpDST5S2FIsIE2WY5iA7BW8G9Y+zEJGS/kbEy3AhQ3waS4Gb6Hd2V9lynxtbsRzIt2pSP7zQTxkwkFOMx31FgZlHCC7WnXhW1xBC2I6APeu6+9AgRHY3igndYPSxGYiodeMx1p2cAAAcVfqeMWbfdLV+ZZzG4hv9lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTYvZs2QjFeXjFEysxk2O3kpy0KBxNxjlvM12uNr+oY=;
 b=nZkwMCmaHvgMSCIF4axl158GfOBKc1zZ1iNHDmJlhfFfr0L4nek3w7KmmyWkSYK8n9m0WbJk6y+ub1k9Grg+dcdUv5meEfZbXnIHqkcW/vlzZ6O2fFo/xyYbs7CyIHp9uxPl0frjRpxRLwP+0HLsDFuZmrafAvM4JcWBvhxhoJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8217.jpnprd01.prod.outlook.com (2603:1096:604:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:30:31 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:30:31 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 02/32] spi: Introduce internal spi_xfer_is_dma_mapped() helper
Date: Wed, 17 Jun 2026 10:29:33 +0200
Message-ID: <20260617083003.1071543-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b65957-f5f0-4fb0-210a-08decc4ab1d3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|56012099006|11063799006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	CdGrSbLf5W9SGpGliBGYtopTp/OU2Fy9/JG2Cay8o0Jvzct0H4Vsmy8SbaJHVoyptJ+248GipwhG3W+nNkR1i7ONTqQSI4EAHbG57A4dtHbLf67JE8QvrY/JvuZzZwCarJsjv94pfaaHKYcYpLNgMdq41k1ugBTpSDQLEU5LAKn3MtnpMcJifwX9cbuU9PLq+7lP5FoDwOMS1toCsa38Wy5jzXkfHafpYF8KAl/n3E7uBmcjlphWLoT2SFT8AA1Jj4t0nzXqyEUYVCCQ9ALVS1Ts9rvfhv9dBVGF8s6j4FF77l5k30WFxzGVFvvdfyHYfQDBdk3if8tmNRog/CcvrYwnrNFkq+PEb2EbGOaFu5DBRMaTXJ/E30h33COJ0g4lirLHul8WEsXyumVLFBGnU9KTp01pRAf2RTjIMSWn5ppaUMDcef8lEgbjswQ0sVCyVx8pEAUrqo39JjvILpYF3nDJv8kNllpC/B/MeQlBwqdNgr+mKBUKbIWVM0wK+EkOUiOVQQZs7SyoZ1E9EJvpCaIM7fT3mE3TaCrePr3igfPU90MN+27dChg0ZhqpSn1WFfjqSb9QPdJ12V9iu0eObebXGbCeQkCVcq+6vmaFmtyF7FDBI9jXGQaiSG3tTR6jGV8qytshAsZaD0ewJF92s0xpxsCB0QkGCRd7niLVnxyGRvgz+j3/+zbX8w72gtC0nEYEC5x2suwA57sJgpOiawR+LxzJKTAM5ItJEfvGw9nP6r6PSqMQHiOkrFpVqA+I
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0v5KLk+YP6le5KU5cuOuRSPEWW4dkq6KMED4JbAsZiajGmdH1KcO8e4JK1iB?=
 =?us-ascii?Q?+J6j2TFCwwktZRFSr94qY0uQ0qx5hG58GVSyVFlYVPpgBB+r+lQPShgnpHFS?=
 =?us-ascii?Q?mo01uXEYiVNtU/whVSQlIxHX22tzWGJycMrOcLDym6236fObuhKqnFkbsFLq?=
 =?us-ascii?Q?FcMYeNW5pB2ekiHJ0NzpsqxvAiIM/Wlo4VHNCYZyMp9MYztB+zQUBQfD9b9+?=
 =?us-ascii?Q?Hgc1sIOF1j/nTUgAqHguvGfI90s0teJhMmJ4E7tGpRFQZmDMwwiZ2hkJfZcb?=
 =?us-ascii?Q?aTn+zatuRFGqFvM/83xG5zz+kh5jBDKspuIRVvswnB9RlQHWHPChEyyQwQJ1?=
 =?us-ascii?Q?DOn9Zml332oykC52BbD5wyJRLzo1BkDLSGgc+uaQKdhIRNE4hfK3ZYofieQ9?=
 =?us-ascii?Q?NC5bYz/7lEigj6Xzb1oEHdb+yDMQf0lHCEHxLN8+O3vPQ68d4FU6r9kNuFn4?=
 =?us-ascii?Q?o0gYmFyhIlxkvNFBxqTCVjhGLKIhnjqZaBjjyDn2XHUeNFhiMEjfVmLtpCD9?=
 =?us-ascii?Q?J8SdL3+4xo/bqK510Us+W2qb9yemv4caR3fJdq5wjBFetRvtDrBzxY5AlsXN?=
 =?us-ascii?Q?sfmonU1gqLbF9VLLltd3koB+V7CySJF8tc58RlmX1CRjBF18jynevo9B1v1p?=
 =?us-ascii?Q?DwBx4CtIbAie0nOQDg09qKRsCTDVX8x0c2DBq8mWzTNvw33HnZLz7WkcT0wX?=
 =?us-ascii?Q?W0whuL7dm8RbkuWwu+3BUsq0qpScgT2h9WNJVGGK6aupHhEAMF2p7Ks3gDMc?=
 =?us-ascii?Q?1S8AJxR4RAXpngiCiZpUeFosMt7c6Czfa8i+9R1GiXezIcfYQk4YpzN/Hwpa?=
 =?us-ascii?Q?NYgw1gzX6zl0fh+cQOTIoNHTxLXgJXjWXLCNIq2dEflwQXWacKl3sh/JfrVy?=
 =?us-ascii?Q?b5ionJ71kFIjYSZD8NpXKxCrjp+j52yBrcQLqVBDyFgMqRQ8ZC4wICOWIYlE?=
 =?us-ascii?Q?2yBRS6wjpcGAW+DhhYtS5ad6wJlJuOzAOntgkvwFXmsq6DxLmt7+fRanTz7y?=
 =?us-ascii?Q?L9lEP2hHpRR4jCwRBpRaMRI2fks2Ilk4etsea1ULk3e4Ovd16QF8y2S8Ev7S?=
 =?us-ascii?Q?rudjU53JbpSNmotAmui1pNkMGyhMFekSVIkmyJ1BhwJlLD/6jasRxdnUuiCj?=
 =?us-ascii?Q?Ed9Ds/Hdh91Hs1O+0/YSDbvzGAdI0UiDwZ4FmMafG6Ln/UnecgAt0QZaXla9?=
 =?us-ascii?Q?wF3yxVLo/TPZoR0+6duF1Ss36mHIO9ObzFrgU15Ad7THfoYC0FkQ3rrvB4RS?=
 =?us-ascii?Q?ZJ6R3hZx3Db08aURpJ1Ica6jxL8VNg6Wdh7TVytyCJjkaRp3ckEfgIoBqn9M?=
 =?us-ascii?Q?VdwgRO0xMWABG7Q4JcVbI95OgGslnkmAOnnd6qYh3/bhUSzDK4XNAWQ/Tn2u?=
 =?us-ascii?Q?pNuoL3xaa0uamHnEIxuNzpcv6+08sWuoQzCkmSUVaJEO0WvoU3e82neUkPvA?=
 =?us-ascii?Q?tANdgMjgs3jGY/aS4731VKNz1IHBZos3bYhONHFmXbS+XwrSg99DGQbDtvBb?=
 =?us-ascii?Q?zISMZgN6rHJuAgDpZNLNOjrzmi8fS/c/OIHKZeqvKnCKlua9uJ2VdeOouLTg?=
 =?us-ascii?Q?614sLXT+rXBNmjAFMpmoYbcf+R+xsmDeRTOwEHD3cdMPvYSq3zOf3iCO6FPn?=
 =?us-ascii?Q?LPNuvkJXdfEkkB6/WdVC7iUV7STOvyfzJupfqzTEnxhliaO3yCLB9HMWYFum?=
 =?us-ascii?Q?EPK7rt+pmRL8x1bjnu4JZA0ISu0Bz5BcrtiNTJ/jvfjpXXquOmbnelr0xqvJ?=
 =?us-ascii?Q?kPyv9FCIIJyMCYqgb5tuBP7q63M1gUR8FBCm0KPNfYGXT1MOp+XJ?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b65957-f5f0-4fb0-210a-08decc4ab1d3
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:30:31.7677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVtgYXMW4MDK/lOA9lb48NBethcus6C/4VMnLU0bHVtA3HrrC/pSWEDkMQMh9sf8IVlktDI31asPaAgsUsgC8g1L+Js/ig3uktJMgQvr2Xay3NjsTSOEjEyAKOQHt4XH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8217
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:30:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23161

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit 0535cf64e4b1ead224fbbe1c25c81221a298c5e4 upstream.

There are few drivers that use the same pattern to check if the transfer
is DMA mapped or not. Provide a helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Link: https://lore.kernel.org/r/20240531194723.1761567-2-andriy.shevchenko@=
linux.intel.com
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/internals.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/internals.h b/drivers/spi/internals.h
index 4a28a8395552..47a87c2a6979 100644
--- a/drivers/spi/internals.h
+++ b/drivers/spi/internals.h
@@ -40,4 +40,12 @@ static inline void spi_unmap_buf(struct spi_controller *=
ctlr,
 }
 #endif /* CONFIG_HAS_DMA */
=20
+static inline bool spi_xfer_is_dma_mapped(struct spi_controller *ctlr,
+					  struct spi_device *spi,
+					  struct spi_transfer *xfer)
+{
+	return ctlr->can_dma && ctlr->can_dma(ctlr, spi, xfer) &&
+	       ctlr->cur_msg_mapped;
+}
+
 #endif /* __LINUX_SPI_INTERNALS_H */
--=20
2.54.0


