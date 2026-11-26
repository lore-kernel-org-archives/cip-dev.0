Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.422.1795708465405904928
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:54:25 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=OsXKBrul;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.32, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJSZojjIlraOoJaSjsnkO7pqHXFFQakLW/f9Il4o1jFI3J+AEJGrudbDbxq2oe+rVPS6i6o+4EZXrOv9Bkel1Ji43OrIGvh4NmLXqTKY1M6LkZOTlcmkyfdWXivYg+psfDssYcfxyLV2Em9rD/ySO2qBBbUnMSaKgcqx9nVX1oU22onqlus/7vkUHXjyd58EPTizmwQC54x375sqTMldWBBJj85+jRg/Q/5J4LILmAeUBnoYMyUZasFrl8gW2vnVacC4cKQ5HJZpxcf0YULqwCkiSBEoNIOd/4gWIDyUYQHZNFAplZUcJ/ROzghmTgh70a++hiuAXu/v77h1b3A/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1e/HJjHr/Sv7+0V/VfBjJIZvLx7jn20YXIe2STcI1yk=;
 b=JUsHxxgLrvR6F7gdce3TGBYAxirLKZwl4CEsZSwKT6WLH8ICh+a3CqG6XeuLemh/M0eqpBqkWSpO7F5CLe3HOCiNXnLf3LOICbkCbKJo+AVvPR/HrThx8Z+uoAsFM/11HWSMCwD6J3xOKJKxJu7eHNxLFij0Ipf7A8DO9U7fh6h6RksWmFv1Pj093K9tW2cLWpYOuQBBjczELOfE2VXCYUHwHeGK6Za4jK6AkdYfJPsweKwwkOr+4kxpLytLk9YmGw8dZz4LYzeaU7bmk8ICej1/eVqXkOQEM3hsjHcaZMUGYjij6vweSK9xXhfiFnirJ30G9S+y4wK7TB+InV4Zew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1e/HJjHr/Sv7+0V/VfBjJIZvLx7jn20YXIe2STcI1yk=;
 b=OsXKBrul4ooIX4fhj2KKBo0BgWKOP9Nw7HPgIJSJHHtQwrgGtiiTVjEZKcjvVbULOCeha8fC5W8RNo/qwNIP7ZFDR0Vzt+yB6mONXMfYKI5GY+OIVF51CvgqDxqoI2U+7cK7MSSunvdkHvbVMNs5zkNLe/M7F8e4fqiqUEmlc/U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS9PR01MB16957.jpnprd01.prod.outlook.com
 (2603:1096:604:410::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:54:23 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:54:22 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 12/12] spi: rzv2h-rspi: Add suspend/resume support
Date: Thu, 26 Nov 2026 16:53:21 +0100
Message-ID: <20261126155321.3834347-13-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155321.3834347-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155321.3834347-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::20) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OS9PR01MB16957:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ecf882-f193-49c0-ce46-08df4bd58a08
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|38350700014|261021121427099003|56012099006|10067099003|11063799006|261028144727099003|261022105027099003|261026140227099003|261021123027099003|261102123227099003|261022075727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lqm4P1oCBvPHaClEjhdnRAIUMtiyRaDsFwR+RwIOMJ/4oHQaB2O2Aq/MWFR6M6XZlIX4p7Ubl3lxOPNUVzWtxG7NJXT0uZ2ofPcFPKnTkF0B9s1vo5cS4AP9i6EBWjjx1jH2Xe53KRuMrgnFHsYAVIZYX4WfoNOdqimEDoOAYQh1Zh9sU6PUMl4hQFLYsMxKw9Q256Fdu76J9Vf5IXPOCZ5u3JWdKilYEZQ+G/fbL0XAQ5YAAwwa95IuPEr5E4r13so5KbnNR7KbvEkaXaEDpLonxHQb5pCX5EnK4f2ez/TCgU+/v+WeWQu4nPEUqoZAXp7G5+9BPHZJgTPkxKjb55dHkQTEORoJ/wmtex1QcijFSKVkhlrnDtawVDaxlCjwQwBSCUUqFYJpyM/kIqHXe5HKdD8NTN3SSA+K364V6B8Vaa5QNZSXCAJIz1k8l3rjD1ufetHBklQxdlAjYTuzlmb1jZEuj8v3QPPbc1sEbsUkhZWUD/MoU/J/fYy+isxT8sghSUwC7d0v26AuggGNChaK0YlpmAuEIK7T/RxbX3E5MPDNNHm2tYFCF3jBplYxw6Rj16jSFeai4lhjRlyONO1WtLFckzGzSBaV/a9gZgnXY84nMamY4GNlZw5xtGeaKFuTnQs9xhHIhKLNQB9Sc674ArazVW2iZgmMEP4Lv0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(38350700014)(261021121427099003)(56012099006)(10067099003)(11063799006)(261028144727099003)(261022105027099003)(261026140227099003)(261021123027099003)(261102123227099003)(261022075727099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/+L6YsUYokk651+rQvmhzW1snvv36Zmk4wSlGNAINAUsFGVuFpgOQli5t1/J?=
 =?us-ascii?Q?BNNlLBmiR+nYJDvv1/9dcGMgG9bC5ZTcNASCGNMz4ZvVe+AX12aApn58MrWf?=
 =?us-ascii?Q?kNkvYvTxFXWLslaPFsaH9JGupE/R2rv2eIxApQMYpTf0umwiCCK8bxgmipYs?=
 =?us-ascii?Q?cZzdnDcFc91cZYYrLXr0J4CG36SNClWzS3EC0JlQCYGPOChj6rrCdvQBb8oC?=
 =?us-ascii?Q?T1gES1YkB3DtJzEKCuYp8aCjxBZWRYScpHTmSAx3y92qARvtBsBN37ouBVtO?=
 =?us-ascii?Q?Frm40pK4nG8Ns+UyCEOi9RWNRaHuwXmKsHrsTri6urCTNyjvz3R+a5MRqv5u?=
 =?us-ascii?Q?4uc97i63q4fGIWCaXNSAHIvt17jg0AMP5mgGLyCa34/6nHuenYSIGNVN6gIh?=
 =?us-ascii?Q?cgIC3ioUPtxhaZq1ZS6ar1avaSbeNjMQoMq04JKWo4Cb+h3ElQNEGlLPIBm6?=
 =?us-ascii?Q?r9EmWJt6+Hdi6RfJtdMvXjUw7ye4Syo9SmMhCxPlBNGmDTtC6YINl7hlcJu6?=
 =?us-ascii?Q?LOqUr41LwR3TYwvS0IYF3W4SSGZmyqc/kbQDY8MgMI2Vufd2SvKCC9hU86Iy?=
 =?us-ascii?Q?CJcrygamSao8BTtNsbXivgQMFivn7HZ2j7M1xGfA9awgx69wgrZf2KHU3MBb?=
 =?us-ascii?Q?9v2LbIxeMki5j6bfPOWTMrxdm5c50GWbRe3RgQXP1/dyE940+Kf4hc+aS0NW?=
 =?us-ascii?Q?ynjqmPTyBIAq0EIZ4GhVbheUZHZHZI0/z/GUfvzzc9qvgCIsXRR0WCdG0cFc?=
 =?us-ascii?Q?OqXD8Uo2nlu46U/u4wNzbTEb8oLRyEW5df3/sfzpM7GDWpkl38D4kPRYHvit?=
 =?us-ascii?Q?Szt79Iibdb83eCdS4UesGokVfXxDK1Fz07u/FlP5SIPjKhqjvyiHrXqg/gzd?=
 =?us-ascii?Q?hV2KWex+29f/HxendhxpQ96BDeYQ9MvA+1f/aytPgMRigdsxubL4ltCNr84+?=
 =?us-ascii?Q?cl3v6WJR1VDOf/K7DP1mfCAJK52drpwGK1kwhGAsYLWcOG4fdJI6z+t1/HYg?=
 =?us-ascii?Q?rEafpZHCMaCR5RdrA3jZJczmaUsy4ujDLxL9bFKpSlMGVyIRN2JfAZyf53tH?=
 =?us-ascii?Q?aexoVFFHF9PfTbhtocwNf6QHZXVSBR65wg2gl3lGgrp3DBSHHwrk5D0AMSek?=
 =?us-ascii?Q?pRjxeCr7GYo9gEotZax/7YxkDzvs3GQhs3gaJZMSWEC2F1DIYWQSYaSivCaF?=
 =?us-ascii?Q?jGIqGlxo/K6LJd+kMHDNH68MDV6OAULTdyNQuERju76k/B4eSP29JwzRLvIs?=
 =?us-ascii?Q?nhr+7UB2VSPh4zYZq35cc6KpjfY9UIV0Di2ed5slQGvHYlK/B7NRftqs4uO9?=
 =?us-ascii?Q?Fxr7X8IxCG1ygpqUkQG45oljabnjf9TI8nJScx7ZpiXfckJi14/Gc3r26s44?=
 =?us-ascii?Q?UaFWMmul94RMSxMJUqc/VxydgZmRc3jWpZ4DIjR83kRfO6QHkee0MOjn9/RM?=
 =?us-ascii?Q?KJEOq8UpmMCc+Asao3Zq+3yW8qHOcgaoeQXeJIorHKt29deO2+GE551z4dhK?=
 =?us-ascii?Q?or/QM4ApS3sw1UZcS144cZzp/PELGaSZ+XrpSS4PIC6WVUGdr+yHrD0ypho9?=
 =?us-ascii?Q?gfJtUeE+D1hpZwjZGJhWkBRfJ0BbvfRJlxnQe0FR7zMJ7AVPLiPvtjjSMk60?=
 =?us-ascii?Q?J3SL0Nck/iUtcFyVHb0BcRaXptBPvE8SlOmNvCK4Vtw0mA4FlOzLXOvNd6m2?=
 =?us-ascii?Q?Px5D8gHVQTvgPg49jc2fdyllnRjGZT8k/LRnHfCANpctZTVyReA9NrPazngo?=
 =?us-ascii?Q?ffDXi8VEG50up76SkJZZWFwG7EKXPYgLvoFb0S3BGz3SJZpQul+6?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ecf882-f193-49c0-ce46-08df4bd58a08
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:54:22.8685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JICHvwkh6WnZNZ3suXdrhofsiKCBVxXwB0+xG3O+wE0YN6Je9lL1F6LGRNhjPinQqQibU2s2wTc00a3eYaS9grNA+MbblAgl/48YEoEJ8qOlYK6b2wczYRAMkG8ZtGlA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:54:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25190
Content-Type: text/plain; charset="utf-8"

commit 2cf4ad412f90f54597be95a6ce297d016d2fbef9 upstream.

Add suspend/resume support to the rzv2h-rspi driver by implementing
suspend and resume callbacks that delegate to spi_controller_suspend()
and spi_controller_resume() respectively.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260608202509.3651345-1-tommaso.merciai.xr@=
bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 3049521ec61f..cd49b85e0b0f 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -825,6 +825,23 @@ static int rzv2h_rspi_probe(struct platform_device *pd=
ev)
 	return ret;
 }
=20
+static int rzv2h_rspi_suspend(struct device *dev)
+{
+	struct rzv2h_rspi_priv *rspi =3D dev_get_drvdata(dev);
+
+	return spi_controller_suspend(rspi->controller);
+}
+
+static int rzv2h_rspi_resume(struct device *dev)
+{
+	struct rzv2h_rspi_priv *rspi =3D dev_get_drvdata(dev);
+
+	return spi_controller_resume(rspi->controller);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(rzv2h_rspi_pm_ops, rzv2h_rspi_suspend,
+				rzv2h_rspi_resume);
+
 static const struct rzv2h_rspi_info rzv2h_info =3D {
 	.find_tclk_rate =3D rzv2h_rspi_find_rate_fixed,
 	.tclk_name =3D "tclk",
@@ -852,6 +869,7 @@ static struct platform_driver rzv2h_rspi_drv =3D {
 	.driver =3D {
 		.name =3D "rzv2h_rspi",
 		.of_match_table =3D rzv2h_rspi_match,
+		.pm =3D pm_sleep_ptr(&rzv2h_rspi_pm_ops),
 	},
 };
 module_platform_driver(rzv2h_rspi_drv);
--=20
2.54.0

