Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9529BCD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:36:06 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10830.1781685364293832487
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:36:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=fTLw7GqT;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.47, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPJyS/SXN9tfJaV7tJ5WStc99QhBJlanijQxjPPAUWPBWp8LXod38Tc9X9f/MEI4RldcoCfUo1I3SclNqKC0kdOJ9GLHzYerSrzQk6sQrteFhKTwGH489NGCeiGK8qStmYocnYWcXW1QuhrLwLZlGih7x62MqwQhsnBS4G5SLI1HgEshd2dEUK8asEpLoiYAKJEXwNwWNnM1AQshcsuThS4trtK1SdtwgtyvhoalJlpvBOiHED8TmF/fDFbLAPBnYNk53uIIEo7K+bKibDE84pbaCEVggo+YbohRUjNbErEsqw46wZ/jIZsop86CFaiRXrHP8RT7TKaW4HqPiIu/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reVuIpWQgdGq50eZs6NHBf4OGvDfXwcG3g37bdWaYT8=;
 b=hlvhocVjBrVXPQnPv727AenlQpQaErAfz8KnH1alw/hP943jQk6cj0XyKRk3FyxKiDow6wk7TeyyHXXbG8OSaLuVaS+8BLJqbciGan8T32Q0AJC5/YjhuM48HJ6oqOjQQ/hvhwh8v9a6JVnKLspYtQJ5yeb5ojbi4GPCLxvEzxwyd/YdAQO/ymanv5FDniTs0zeAcJdwmPg4xLMTkk/71q9Iyxfr8ZoNNYkYNJ0Rkzal8BR57q7b+Yk8Ir3fG5tTY93igZKibe9EQwAvHYLSyo2wBrC/ZtoxWQr6z8WrSZbrJrA7Y3/mAgiyVplu2fbU+5R5ocvLtqAH1nkOsGyGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reVuIpWQgdGq50eZs6NHBf4OGvDfXwcG3g37bdWaYT8=;
 b=fTLw7GqTk1ok4iyrAN1c8LzEZoV8mnYn8nhBTQKlf51CTaFzTpAX6g4pylUDN7H/QkVPFgZoTIl/b8JC3PVYojNPTimBCvNiwTjllfj+58gCFcVrtNInq6/qRdwoFaBRHyHjvfCDp7Wl8Q7VlHm7aZKJSogi4a7a86TLZLlAKCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYYPR01MB13245.jpnprd01.prod.outlook.com (2603:1096:405:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:36:00 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:36:00 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 12/24] spi: rzv2h-rspi: store RX interrupt in state
Date: Wed, 17 Jun 2026 10:34:50 +0200
Message-ID: <20260617083502.1074160-13-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYYPR01MB13245:EE_
X-MS-Office365-Filtering-Correlation-Id: 9317e61f-bdec-40e3-cfb3-08decc4b7591
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|52116014|376014|1800799024|56012099006|11063799006|22082099003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: 
	y7usf76T0DhGfrQDMX3Ijh0Qna8tx3RgJa+K2BB1iQj5TGglphaonHosL59QgmR6xPrUlZWwc7VJZ3gx0GdVWHTWJIaMTwF9ugNPppYcud7XwZgGd2BcAZZ6quw+jXnZI/5mAOAVkdMojS65oRg2bXcP9BKxa7Q8xajnXjW6aM7H0u+Mz20wBvSERyC4A4FXIQY5uDgFy5bzL1P1U7FZhNWrWRtVxdkTNTTM64uF1C0SgorY/ZSgDl3XOPNbqLV4O0FloVPefNJf3e3YbPQyr8JnJWZPYbu87QlmI/4q00HCl9krx0vltKInVh/4huTz63jt3CJcoXDROZMWg2nrmTXg+vq+V9Qwqng9gFV4Wc5imwClDkpdvSidHGSRDBYZWwqlAFVHM3VyGY6VpEReqdTBV3fhg+jqxvTVd9PMoEk36gg6uAb09EsOFlEPNqymbVd889uU7w2AsDMBXwlm8+Ze5CMiRzIWf7dJUBKf0x+dztADm7lDQYWE485T7ZlD4Xwbg/paz2aTamPafwYX3b4t7QxUTcFfmRHYPn4FXJ6p8oNS91L0AQFh60Njc8wDrpXUo876RPmSvOK3fYofHCzRqKVM7aMTAlr5USXY1LDkyMV+C4lVY7mvWCXOVE4KVi0ehUIx5PUz5Gg7olQEhAM9HxKJuB53vsRG6nadCQXwg0beOz/oSsf/w/ssfVnWwbjuyd18uqCikmEDztNNtA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rSpevxd/rOH+0mLE5VfzEN1g7Lr9ncGvTlVQ6ewAVrqe4k2ItUOZu2SeYp5M?=
 =?us-ascii?Q?s7hKRgdcz0t6yD7RrXewKkMImP2kR0m1xPks5uiN7wijNm2F0uRQ/7YcBmSW?=
 =?us-ascii?Q?XFVF6Mej0Xa9Lg9Efd25dt/kVj/QY280YeikubMMwXaPbPnLto54r2TVyq4f?=
 =?us-ascii?Q?MAhX0QA56830LeLU8U4L3bI/TpES5pApnYimOa49ppxbEwqfMUdlzuzkf6KT?=
 =?us-ascii?Q?UPD3OVQFbg8rnRgkPrC0tAScwk6rGzorn5cVifg16iF2EXzv1KfR6acXn7uv?=
 =?us-ascii?Q?qffjLbAg5BiS3n16hwmfits3XI56LHoZvNK/r4BUpQDrPC5lsM6mIhQi9L0i?=
 =?us-ascii?Q?tnG8G+q+qrG4vWTi7XGw5+TpBK+CXDqJZh86TgGkIinxB1XCDkH88dZYyKxD?=
 =?us-ascii?Q?cNwbLJPm/3dcl+zre4xBETSD+gumoJJKEWHLDyOXGqAnFqXJWqhL/MLAbUBo?=
 =?us-ascii?Q?cDzGk99JF9h8sqdT4mRpH6AFEnZQCNmN/XxEPUZRsqmHuAnHusJ7dplcFIrC?=
 =?us-ascii?Q?2VnkB+7J1iIdINP/KulyzU0vhN77aTNoRl3kk+ugZG7QvLKPuFjydop5uvct?=
 =?us-ascii?Q?tl1rcT/sCdsM1+LI3d7TszSP9UDtUGRGU8DZJwH9r7phv+rdKRRSlWLfl+wi?=
 =?us-ascii?Q?C8uLK7ctn4STEiipZbaS1sgFA8YfRgPJRku4wKhRqPsqBMNJ2Ncb/cnbycMu?=
 =?us-ascii?Q?7BnmFlYEtVwdk7T0pKTTxr+VRGPTPz4s1nms4nWcJpIp3DQITyeGLxVeR98p?=
 =?us-ascii?Q?DopQA+czcXFQGSTyRqKKCysAYKmF1fAsJvglcPaTiN8X2TDePlVFprWZs+cP?=
 =?us-ascii?Q?CFYa1VXbHwDr1t60Y2xVL5uETJiDjTSLRzyY56wn4JR3LnvQ88DZ5KlJw1qc?=
 =?us-ascii?Q?iWYvBGXDWC4FBD253dyq1vnQUxmDluTOcAYc9RcekHghW9vaD7GvDMKnBbr1?=
 =?us-ascii?Q?Ftpf7b4yONFd4WQcGSkQKBOSLOpykYNFWvtoNzKS4auEbfhud4LPIaeKejUE?=
 =?us-ascii?Q?Y1R9o3t0h9n3vXISgFVoMWT2blcqQJrxZV5lF9STxT7SxrSRHFkbZTbYiRau?=
 =?us-ascii?Q?AeTy/z1h1HwppamsPY4Fph0beBFxLtrcPhO41ZM0MoD+pEqlm5OrX4cC5iw+?=
 =?us-ascii?Q?MUDO7qUz4iTI8bJ01sOdgijORCBx0Z8xGL751l83iqHW/1jaTvDQvRsFLhAF?=
 =?us-ascii?Q?I1HjibaqFO41MuQxdyUzWVgXnlrL+u7AuC2miK+x93PFz1dkq/hkW6z3FS9X?=
 =?us-ascii?Q?B3z6C0vO4A+AdRW/rrAfZVSJx1ZhQKmccoRvr2urLWB0jB3kRkqWOmrZ4JGr?=
 =?us-ascii?Q?8xQjIaa47oF+57Yd30A1Lg9GzP1s8uUvAc4bPZWhfVTVjClVEadZRUgRvOR9?=
 =?us-ascii?Q?MnJysxH1czXPZfBUK2XooeObCBDWB6SqchzIuqebQiMr8nn3PXaxQe7LdjDt?=
 =?us-ascii?Q?2yREi2t+HDAM+Zj8skwuvezgiQLF1urP5KOenMLWthIAlU2lz8fHu5euTNH1?=
 =?us-ascii?Q?7jBqMh+FrkOPWlgaEJrl+N5HeUaN3FBIgvMBBmMRhyDdcpwYcntePtVQWfbi?=
 =?us-ascii?Q?xApRPibCgFLVLR7rWwPLlXmFlb58ofNs/N27T+R/NPwEIE2B61qkAJfiQcwl?=
 =?us-ascii?Q?hRBK8NgoXCU2/xur751NZIDDiZ2DedTjKFcf7BTGuG/8oOf3r1jMhfPgoVdo?=
 =?us-ascii?Q?4OGT2esIt+p/3RtcNUOH+WAroEFYUeTH0i4ZDbK1qOhzHlQHaGbyVbFa7S+S?=
 =?us-ascii?Q?DddpACZxbp17rEeN1jUH8UAJj0idLCAVMkVhPgxMHCp9o0yB28dF?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9317e61f-bdec-40e3-cfb3-08decc4b7591
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:36:00.3934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuCtFVc4SjnqcHXo8USOgC5kHilcKgmUbBcTFZG715raq+xwE5gU5i1Akik/q593R3di/wX32G9ToPmPjRPC4xvVh9yO4zlgY+KNzMqZiaUhckFyVk95vBmkfgBoSrPe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13245
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:36:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23204

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 28b590bd4c6a051ec61cf286a46a8b14846e6fcf upstream.

In preparation for implementing DMA support, store the RX interrupt
number in the private state, to allow disabling it during DMA.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251201134229.600817-6-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 6163ada3ccbb..50fd7ddef58d 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -100,6 +100,7 @@ struct rzv2h_rspi_priv {
 	struct clk *pclk;
 	wait_queue_head_t wait;
 	unsigned int bytes_per_word;
+	int irq_rx;
 	u32 last_speed_hz;
 	u32 freq;
 	u16 status;
@@ -534,8 +535,8 @@ static int rzv2h_rspi_probe(struct platform_device *pde=
v)
 	struct rzv2h_rspi_priv *rspi;
 	struct reset_control *reset;
 	struct clk_bulk_data *clks;
-	int irq_rx, ret, i;
 	long tclk_rate;
+	int ret, i;
=20
 	controller =3D devm_spi_alloc_host(dev, sizeof(*rspi));
 	if (!controller)
@@ -580,13 +581,13 @@ static int rzv2h_rspi_probe(struct platform_device *p=
dev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(reset),
 				     "cannot get tresetn reset\n");
=20
-	irq_rx =3D platform_get_irq_byname(pdev, "rx");
-	if (irq_rx < 0)
-		return dev_err_probe(dev, irq_rx, "cannot get IRQ 'rx'\n");
+	rspi->irq_rx =3D platform_get_irq_byname(pdev, "rx");
+	if (rspi->irq_rx < 0)
+		return dev_err_probe(dev, rspi->irq_rx, "cannot get IRQ 'rx'\n");
=20
 	init_waitqueue_head(&rspi->wait);
=20
-	ret =3D devm_request_irq(dev, irq_rx, rzv2h_rx_irq_handler, 0,
+	ret =3D devm_request_irq(dev, rspi->irq_rx, rzv2h_rx_irq_handler, 0,
 			       dev_name(dev), rspi);
 	if (ret) {
 		dev_err(dev, "cannot request `rx` IRQ\n");
--=20
2.54.0


