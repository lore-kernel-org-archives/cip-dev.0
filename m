Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88796C7EE39
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:48:52 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.65])
 by mx.groups.io with SMTP id smtpd.web10.423.1750690130688908500
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:48:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=UqoANXSw;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.65, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPFhKm+HVVw6XXCpfHimR9LzT0RZjyrg//UVSWES3hH8BK0MPOrsvlyTpqPkYVacvMRGwsgNP82bPLnCfaIOkBZ8LxKn70j4xDw12dDoqZainfFe1rwNfXKrS1zKsX3K2iIL8r9kWR+A6Brx2v21AdDpfRiRPZ7ecR8+CkSWDVdClFFb5O054y3mDOrlsvhOZNvsygogrTqTxY3hRaDs8XS8yVJWFrfRamh4c5iQIUaTK+jpCZEX467CFYrFEDjZ//Gk8PRRZSQw80XDM7ym9g1MXG+kcD7qI3IL67MeLdxPfllbF2ewyLMT5KgtWvwpd3MeYLwVCXJxg7e/H/QNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cg6iCfN6wM7L8Utd3d2vPeza1lsICCPn27pT/yeZBJs=;
 b=Svk6Otw9A1BBuR3Ax+8zItZpDqEJsmPQvA2c5ghbA8fwwbBaI23/bfFVb8V34t28GHA1L3CWPxJKbuu/GZtPekcFR+8ZJGooscMJk85nhR0Erj76fZRndXbyTUMQYj87hpD2Sq2e3BgHaez3G3P8FGe4OeWpA8Fzlr+TcZr/wrLGgnoxxagkiIkCyyQZz3kG3NcZmb9+bRXhYohXo/nluLS6Gl4lICosehVtBIJZR8yBgIgZ+BXpwdnZs25X+AVMpWwkL8fevizLACV5mchyHUfiTrtOoO7eaYsyQGYaQximokKWFE3GaZNqm2fb1N+/H8pehMQ+dbW/L+FXKkVEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cg6iCfN6wM7L8Utd3d2vPeza1lsICCPn27pT/yeZBJs=;
 b=UqoANXSwrRuwfDJFxxTI4S3HOksdNXmYo+Iec4DOcYsXz3/hY1nam67vqjcBpajgp5UKL9/YrUFdgOVtCu6EV8iDyy2y3JOf+j0TeEeZqdGM4dzaHGpuhUMy0KX/Buu6hdUXN1K4dma0nxVB9F3iE5ikZCqLHhciFWZlTs6GQFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYAPR01MB5851.jpnprd01.prod.outlook.com (2603:1096:404:8057::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 14:48:50 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:48:50 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 05/10] mmc: renesas_sdhi: Use of_get_available_child_by_name()
Date: Mon, 23 Jun 2025 16:48:12 +0200
Message-ID: <20250623144817.2119838-6-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYAPR01MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: c719f77e-3a0c-4637-897b-08ddb26510ef
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Ouy8F6QdIt6G4k0EOJvxumGfVnC12C9oceGHWG5ZVHLMVbbK7WEAMApzRtTk?=
 =?us-ascii?Q?/wC/5mCFFbdLcNiXglqOaIejjiBBIyGft2Te3VnXIESi53UGZB1If2jaYoq1?=
 =?us-ascii?Q?izvZQJts1zk660c49ucxpydg31Oacgbn5uh1JghzykgFNkuKLS9MJKKlDD37?=
 =?us-ascii?Q?iMI0LG4byhZjrPP2NoYqld+dJjc1rKbsBBXMofv74ltNXXImlz7o/egFtPpe?=
 =?us-ascii?Q?opxmriKr9BP02vh92ZQrZq8m/ljGpykJ0j/en4tTNQ7InzTF0h9TIWkDZxgC?=
 =?us-ascii?Q?J/oMnyw0WkXBMiLsUciNIOINi8OWY26/lZ874p3eYXt/4k9NV2eToMP5Z3mD?=
 =?us-ascii?Q?fZV7z6Ell2vBYXsOv/1PM3w8s/gSTlr3fgaBKmCOMGz2U3G5R9jX3B1H6moI?=
 =?us-ascii?Q?2gzWa0FlKqTH7tJKFy+vu4ZauM8ECrdJi8xWEHzjvQwupPYHVeg2FiHsTSZV?=
 =?us-ascii?Q?hDNDWqyyo7XridRdtLJP2Rx7IKKQMVYPiIJoC9dqV27WADNjmynzSTq/IDKM?=
 =?us-ascii?Q?O9ONLoWWxAPeIyMTDeWHK3Kng/Lx5I24wzMG/jM5QcpCfmqbCpw5UB+yUus8?=
 =?us-ascii?Q?RibxaB0xpYmrVlNfzL6Xj1sGjuT/rTHklffhtzCqGtaWheSYawbyJDGZfQ4C?=
 =?us-ascii?Q?rUbh00wNWcTiJnelzoUMBZ/4Pz7nFdeyH5NwMky3pF+/eZ2dtBmK2K04nUQT?=
 =?us-ascii?Q?UFNFzkTWztXHIOr5XOfuj4FhiejXq8Wx95xh+jrmB0ROJB+qYiSP60dkASI4?=
 =?us-ascii?Q?hRLYKX+QMdvGiwm/PpjLxnTguVkvywXvQU3oER8r1gBfqDPMfaQ7OIEbGzCY?=
 =?us-ascii?Q?+q9z43u6fl11RaJEoajl+b/8VrZq/VQKqkZEwMHmxaH6hNjsR3ijl3tmUzVq?=
 =?us-ascii?Q?+qGDo9OQQHxqz17K0Xah7pNiLzb2rjDpMtK3gppvsuySQ+aOc6rssVUuBWqh?=
 =?us-ascii?Q?tuk0qlVh8ZqSf80uRSCm0WVk7gJ8D3PGI4gGFdMSKZZWqwQkWx4grTVXNTWL?=
 =?us-ascii?Q?rdtgP4QySO2LniX0Fg9CXK9hATdO04k9uXdPNPAO4vosF6oeETRc62m7vnzK?=
 =?us-ascii?Q?rY3PCtYrZwLfyUnJtvgjxRf2auk5pCB/VzfvtalbcNKREDinq36nbx8LhkpD?=
 =?us-ascii?Q?fGxcJkiMF1x9wXuYFPz+/EBeCSUej+PNO32rwlccAbcW7HP0uxpe/LoQOcu8?=
 =?us-ascii?Q?TABoVsxpPR8wnALYpuBSVP2tehwOmEuKRiTHlqRBhJ1oyi8xfog/puvF3YZR?=
 =?us-ascii?Q?yMgZFkz8i3YF+STP6RjrdSfp3umRTJ+jNRi6/QCDwbdKOpSUKZuVuTQRpyaQ?=
 =?us-ascii?Q?ZmgWpEAXLQPt9g7rjztWV7MuBSDsFi7va9SxRfzNtvO8bIRR2svIpgyGVD7/?=
 =?us-ascii?Q?FWK9sJs3L0WkkutKDqS5G+4qV0q191mjQWMORg6EHYNU6aSqewiaicOo4MMR?=
 =?us-ascii?Q?jhrbmynrVqZXrxWcFl/ilxNGRFB0LSoaw+1HRu2aC1oMkDnvNlDggYJam5ts?=
 =?us-ascii?Q?9pDlvZLBKjBmBYQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?njemTenPAHSWNVghKlDN4BiDNNwW12jVnYlAaQXIkwqsmvnO9GENKUuSx3iB?=
 =?us-ascii?Q?mQImE9aZfER0fGpRDc9vxzkKQRyRufs+dUCU6EZdRA8t6k7R1skyPrsaBRTd?=
 =?us-ascii?Q?fj0jsSydLkB0YJsHP8FZMBwyL5VhEyXc6Vrrg18yp3vrYoE/b28LdgOEUpXp?=
 =?us-ascii?Q?BT0/FcFnISSrmjVd9A+DtQqOJTXluPFXRPtdGf3pDEuJFB87dUkHua1Sth3W?=
 =?us-ascii?Q?RaTRWZbrVu24WBKVZ/BIJDJCpOFD3mwRYLb6ptOs4H+1kiwOdIv8Dte4iQ67?=
 =?us-ascii?Q?jq5fR1ypgdzQl66YCr2QHtyq9QU3bhpdvs4nHU1Fcw8tkTLdpyJS2N/YrbSF?=
 =?us-ascii?Q?pDmBQAm82h7QeAtUXF6VUZHdWv2mkdzBt/bV66hx+F18gilXf8ZXsAxgnn4t?=
 =?us-ascii?Q?ICSnGJXbPcsJoJuoKALMuyhwp6WLyqXacLnlsQ91+j4Y6IjIg29TN9tVeNW/?=
 =?us-ascii?Q?srJVI5vbbW0+QAkkHgvvB4MULnYi9Dn3nVXyxOsFE+jXDNlnLRCJ2RCutBnW?=
 =?us-ascii?Q?HZaqZhhrwt8FCkoq0ofsVIhciIOEcYSQAaRIqv7357UmunDSTqmzg5QWxJSr?=
 =?us-ascii?Q?ASI0ThZiuIZtN12oh2pNWRgAvidcZB2TAEbubA5U9A7MtLZOvhO/6jjBZByX?=
 =?us-ascii?Q?Tb6jHUk1gK58FKyuWVtKQtPIQrCeki2j+Vfm5gjc+raiVS9ZQw0nuPDLEJ+0?=
 =?us-ascii?Q?8kab/IQXltcCuVulIkwIiGyW8g2BgpfB+PmTZI/VOiocm6tMuNpNBOvVvbtl?=
 =?us-ascii?Q?kQBUiuUFoXYB1kgUjhYJ/1TqGe/J562gp+HXgRNGXSA5zSRscXgcIUfXFrq1?=
 =?us-ascii?Q?RGW2yBKSE6E3+k5WZELDW4q3BVyPw0TGwfNVY7nfKcacpfm3DfOzqoqwXWqD?=
 =?us-ascii?Q?hr0glxN+RDEXEoDDgXsAD7kSyszP7AudFRbrOUQfRkJff49E202qw6iUte5i?=
 =?us-ascii?Q?zOROJvWiXC182AHJ+pFszAfPozqTU8L0eh4a2ohbdtdpqcTS+2YOo/fDAytH?=
 =?us-ascii?Q?dQ+KnIcoW24QzkBh6yhZOvIAm2eF9PS/Bv+nMNWWr+VdG+6OYU/cmDOpRyAx?=
 =?us-ascii?Q?E/KcbI0bDx9bH6dx1nX36BFFGMyiMEo4xeGTgnGTc3KIzzsJXZ++UpGNZbLo?=
 =?us-ascii?Q?BNM3GRNWnCt0uWZNAWMuM1KlDcEMaPFRTsn1/Lh9RXtkddZpm6eqGhzT90QS?=
 =?us-ascii?Q?pLuM9yz66EsE7eDrNax6tiTa2M6s7EZjxN6KtJvJJAPB3fWi9c+P/S+PgfG2?=
 =?us-ascii?Q?EuBiX2q9LI5yYs2EZ+0w1eQCrJQpOVbLtslhhzOTZrtfF0ley2NfNMl5yOHc?=
 =?us-ascii?Q?CK5zhMTEPf4zFA7fKXmbJDLkVYweDg6TBqx230KAcGsIdfnmgFCplDuoWkMv?=
 =?us-ascii?Q?gLNMHKlfnl5VHM5W9DxCZuWMkJmftfJUyDfAjxTU37mEB8w05j9pqdOnLIa9?=
 =?us-ascii?Q?pHU0naW+muz24Lk5YnCuxpnCmD761DqGvRzZnK649SQRnV3BABRQ5fGG/POX?=
 =?us-ascii?Q?ibwc4YNKO/XvJLTv3b1HQJS5UFvDdfvFQnt5UKxb13rHVuAurkKLLmGmnrP+?=
 =?us-ascii?Q?jZpCeIOPAWh7oznx4PrAsTwtpMA06AWABTOvqqhP7W4mwcM9gBnQBASUY45K?=
 =?us-ascii?Q?gYTEB/bSlpaPm+xVTTU6P2k=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c719f77e-3a0c-4637-897b-08ddb26510ef
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:48:50.2958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fo9bbYxgwB88ISCGIYss90iAtAWcVxAfY66nhunc35QNTVOC3KSKtHhXn238AiDBb+V0u+P81+ZgCGkPBBnL4ulNfxedeF83vzMTxf9xlqPN89MZC4Kf4lT19NK5R3GG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5851
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:48:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19210

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 18da3ecdbaf6f140eb45818fd848b85d2c414db6 upstream.

Use the helper of_get_available_child_by_name() to simplify
renesas_sdhi_probe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20250407092144.35268-1-biju.das.jz@bp.renes=
as.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesa=
s_sdhi_core.c
index 8c83e203c516..862c279be4b3 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1166,12 +1166,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (ret)
 		goto efree;
=20
-	rcfg.of_node =3D of_get_child_by_name(dev->of_node, "vqmmc-regulator");
-	if (!of_device_is_available(rcfg.of_node)) {
-		of_node_put(rcfg.of_node);
-		rcfg.of_node =3D NULL;
-	}
-
+	rcfg.of_node =3D of_get_available_child_by_name(dev->of_node, "vqmmc-regu=
lator");
 	if (rcfg.of_node) {
 		rcfg.driver_data =3D priv->host;
 		rdev =3D devm_regulator_register(dev, &renesas_sdhi_vqmmc_regulator, &rc=
fg);
--=20
2.43.0


