Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA32CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:13 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.37])
 by mx.groups.io with SMTP id smtpd.web10.977.1755705965296790793
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=inlV6i0R;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.37, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClM7uOU79mHtKEu3NTMwXPJv3Ih5EK4CmU6Sq7pK1fqx0vA5tLYxRzAj+FpxdT2WrCTz9ifmNq08ko3E50cN5LHxNjVEuj3PCqUzFp4AMJeEBcABQB7yR1Jog9FnNq5I+C/7dJRB5f88xeXcWyLWLCWitPPFnKa4jLYzcLMWSNO4Cg2WvscypyYgV6SM8yExcL+QRLAbwsJoI/QY1rxUmcm7zGgBMFbKKz3esgdaDsSFtKvCaoZ0gHgr2lVPS512mCwiS1rcmnRUHpcq1AElSae7/5ZKVs7yCTsStAa7xg+C8RNTnBEc2n1TP6bKDKNMm4+yCQmu4SwyysXLJ/l8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGncGvSCzocRkku5S35R93NFgQkQtlxyPli3HsQf7J8=;
 b=FGimYedTtBtB124yUHvAf/8NwBofKZBrPKWx9n4IGFVKoBF7mABEr+t87K4OR+aCiSqiUUiefeUtaqpYAbvK7h1Du/1pWkSw+CKd+CAzS0QaTDctm08ylYshCTac01V8W4QXdiC9hoZm0iRoh0mxto2JnuowMyB6acCDPTRNj8wwoWga2L1cHTPhsUSV8Uuk8/1hRhPnu6rzFugxm8KGuqIDhnz5awdqn3942693emWuUWIohjWpBNdAwp3lEW+wUVZ22uHWIJX/G4VwbmpEmlNcoEOSUgBAoE7v+vh4G/dgdvGwR0V+sqEIJo1nAWI+rqP1zpAQjD4CZ0DoAM9nsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGncGvSCzocRkku5S35R93NFgQkQtlxyPli3HsQf7J8=;
 b=inlV6i0RNZLNoZZ/Kz7966IK8yIXUVQM5AMBUtTcMJjvRy/EDxw9b+wsv6n6fC/9kIFBUD2e9RBDkZDn8yaNw1prayvsbE1AuAEKVSH1ek84ddpmPoKOTaMVzpjUmsswU4Znq5knFTPCJI+DtPYyDUg00MFadTUjcF0JSMVLAHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:06:03 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:03 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 33/55] media: rzg2l-cru: rzg2l-core: Use devm_pm_runtime_enable()
Date: Wed, 20 Aug 2025 18:03:49 +0200
Message-ID: <20250820160413.801341-34-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYWPR01MB10458:EE_
X-MS-Office365-Filtering-Correlation-Id: c63b3129-6a97-475e-8d10-08dde0037653
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LL8/b+VW8bgIgacZCYS+9WW6ed4OpcH24dW9gaDebXahgu5hNEmvVryYASgY?=
 =?us-ascii?Q?wgeDm9AfmjBeHv85ryplchN8MDHbHmWK4gtcCoFOpZfQEgrypEZjxCjaE9IE?=
 =?us-ascii?Q?aowZXJvSXe49TL8qvl2Lf+Nj8uihxpYas2t9T/nJbnLfTRjGkRvNijlQfnFy?=
 =?us-ascii?Q?Ys1szSZq1PGDZd3MS5P1WV2fa1c/rycoHn4xl4es5cttZeAiWd2ylR76no+r?=
 =?us-ascii?Q?zG+GZM6dcv5lb8+YUvzfg/8xG1msA4/shrZVWts9TTAXYfQ6QfTGhLawAv1M?=
 =?us-ascii?Q?HLTwlyPX/AV4xgeIC1wFDpIbPGYE6FZ8cTQQckvQRvzcpb7d5yLf1C5DwWhM?=
 =?us-ascii?Q?GWtzyLw+87hV5LavmrTiudxxXBThh8euqkQazB/ubyBj3qq8Urqq3uhoOJR5?=
 =?us-ascii?Q?kjDVauB4Eh2eJANYKLBOKl73mV21+r0yjUg9QcZDaapZ8+QoRJS51ouswrWM?=
 =?us-ascii?Q?Fmfei157oYejVcTw8TvEN+p8qj20rOX4q/lCigsXCVFMYoLdaocMbEt4ZGiR?=
 =?us-ascii?Q?1dTO5uXtjAcMqgsiUuRQiRb01sEizw1J0MC8HK/Q0Ic5RWeOdvUQaj9pxysx?=
 =?us-ascii?Q?6B32qUh+Kg1fkpveoNKRldp2F7DSHHxfl1dlZ9gPAsHdUUnvNHz1bcKDBCNQ?=
 =?us-ascii?Q?X9LDk7Pa0wN6nsyL3KflFOd8LB86ufTf5kAeQwJHEVPMRjtDZ/Ehg8kVdk+3?=
 =?us-ascii?Q?IH8fDUCAdlhbuuNkLgW+M7RHJg94AuIfH4vQjEJ6FTB32jT6t+CGPISyo52C?=
 =?us-ascii?Q?ZcN/KFoSonA7AbjO0LUykMjXrxDp46guNjE1+fKStEzNde8nMSMEVLX5iDal?=
 =?us-ascii?Q?Eud/COIZ6wDQ6v1rnUjEbzgIXSB5wjwTiJ9ImxP2HWgknUM57mvXOUYZTSCE?=
 =?us-ascii?Q?wxyb4cYonijrsS2L18r6Ag2Hy05IlttiyhFJOePJLPproCR5/cOwqnqGM2MC?=
 =?us-ascii?Q?w5KGlytmBPbHacYYd+nQFJvjkKqNYX5pTTXzyCWnIEF0qLspeG9YBaQLBxpU?=
 =?us-ascii?Q?cZdbaeb1MYJ3S7U37TsJv/hN12HhcUPhHMTGD2lI3obHdNSzcNbNszmOdvjF?=
 =?us-ascii?Q?uMiFW3rbnAK5WmbSeRJfAngl+3Ej9lIaCOfNkI8I8vq8Lexar1ArUClEfEKB?=
 =?us-ascii?Q?8r+6gkTM3NAa0RBSpKgVjsOSknFeKKnPMMvTc6aa2+k3Yfhwahsj0uB6bRef?=
 =?us-ascii?Q?yLyQP/7+a09GxyPiwMEJX0EIcqzkLcAvlY3iUnnrOIXFSx/L6E8+puWui9QA?=
 =?us-ascii?Q?dLlD4BvD/lnPvQKvbBVNXLqEtg4nkot5F82U8u7KYSgvO3rgMGIkyvyDR+fv?=
 =?us-ascii?Q?D+AwGDvppIjWi59VJhkKo3ZD65lCLFznj6TxnbbwdOZROujOK0Dp5u94q1Fb?=
 =?us-ascii?Q?BVZ3fLfjA49BoFqMQgaVGiC/6Pf3UNT6emrmblYkr8/mUSLlSlMgjPVf1vKu?=
 =?us-ascii?Q?Q4tGkA2GKJWJljsY3d/cE5FnOEhlz20nVv2DQhqXRX6wGKSXPZRg/nC1Sti/?=
 =?us-ascii?Q?DkwOT9hCCXPP2WI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?W3LIODc5m0TY9e1w1uXgJS7WNFuK+GEJXnzW1lRi8m+ijULU+TwN/TCOVau3?=
 =?us-ascii?Q?We+mNhdFmeCpLx9kC4b3TbipUp7GSoyeEKKGj2PupWAvohbWUSL/hldUqKvG?=
 =?us-ascii?Q?nQyUrCmHNuaFfDqnPU7KlQRlyHU1IpK6JnyguIGJRcRIaN908j0nUQrSS+LX?=
 =?us-ascii?Q?4AfgCGYIn2eC2vb3E/g7XgRbUfPZBt38jUfXQEV0ZI79SQh+EoUnDM01ZNYz?=
 =?us-ascii?Q?ZQMNhvvxjCSRcDRHUIxnUmcSrNc4u8F3fK+f8VeTj93zDxYhcnL4DKJJeUbs?=
 =?us-ascii?Q?5IAAl/UZXWfCji84iLfJw1NDdzbf6Hg7zSqKgDS/kYNbm6FubxG4KecRAX05?=
 =?us-ascii?Q?8RLVYGJ2od3Skn8VeXdncmbkaRmtCzQDWq3pWa9EXkZuS0Oo31P+eB9tBQbo?=
 =?us-ascii?Q?UjU5ho02FJfUAXZAwMm1NnbWvTKNZ3Jy1bhreT6Ba7ViIViwzpERJ535uSxW?=
 =?us-ascii?Q?CwraEYCDhbYujOf7o8o+2smCZ5J1DQrz0d2zxThFt1Hw1fdkf+lMmydzpM5I?=
 =?us-ascii?Q?Az9/PU5DZg7UsnfbhvKRk6CtFxka5PKVQOUAGwnJAD1HFPmQrldPp4J/nL3K?=
 =?us-ascii?Q?pY/ORptaMovNhHD1mxyaNy5k6sPGAy/Uq3CCdab9nHg3iGcrYuoQpEnEY1Hh?=
 =?us-ascii?Q?ToVfIzM7h1/NNoxROPUlGzddZVbBdYYN3pioboQZx9kmX1mWBhq9SxrE9zOf?=
 =?us-ascii?Q?DqE0vmL86jzkj+ozqoXF/HMybEAEkAs5GSx8ccaMyr6c9h+2B4uWcvUinGZm?=
 =?us-ascii?Q?xFU2QjQhcYtFZpG+bc6tqBFSAkOFwhCJgOFZ87n4w6CFXAUCxtE5WmUrbnxD?=
 =?us-ascii?Q?mp9WM+AfdmlQ/g1luogf8S0Nt2l0DkeA9bKa6npmg5KiIqz6xCAmCcGdc2Vf?=
 =?us-ascii?Q?JQiVwQVsSnxekFDfUH85/NpNX9q5To4tW42+4ClrkhO2UDiN+I19wW+06iIF?=
 =?us-ascii?Q?kwv62hWPpPW2FExgttmJm2GFpeRE50RTU82V1jarSBHbIK5sngersWnAB4/7?=
 =?us-ascii?Q?p14+gJ4jAJLvQKyN8ziU6YJ8/CO7OOlZXkjO88X4D3BMna7ATQIB1xCPA+kl?=
 =?us-ascii?Q?wx40FdMj70GnajIb+LLdxEg0sMuvJEo6dCL4daltS6P8bZilLYsGMp+xVauo?=
 =?us-ascii?Q?Z1T9btTVR3llxQcMEVzzFeZjMkZgqXGm4IDHF8/ng/6M8ZDigCgoVwytrNST?=
 =?us-ascii?Q?KprkDRAmtf/0oBOi5aaEhgO3Cfv5RB5mGteUEosXLyFl8DRZAAy25X5EIb3y?=
 =?us-ascii?Q?znV6Zd+FprzDFdSCmkh5OBApS4pWdbI2I8cm6RyuDZ+5GO1yXnmz6H5Ijo9L?=
 =?us-ascii?Q?SvJfa8f5gjXbbJhalyXnmdB/mJYfoi3hDgqQRfkqjrx2A+IRIYLRvQ9OS9pc?=
 =?us-ascii?Q?4AW6jgI0fjvSWVJewPYkqQFmekIqkZcck6knG50Hlu1oiA/uQy1fghnffTed?=
 =?us-ascii?Q?kRwSViG2Ljy20WIGbsO0MiEoyZmjsJGo2E++rN9Zq9PJrBnaA8/2QXg2bT3U?=
 =?us-ascii?Q?yb/zaKXPcYzxu/6kOfGzHIT2r3YDc2D3CuBEWfLxudQqaHqgsb5nsOwyd8G/?=
 =?us-ascii?Q?scxpffjBdY7R0oOxXHUMJmKrgW/TeHNWqpL0yTKSv7iOqYfrd5JczESniXUt?=
 =?us-ascii?Q?Zy5Vr/Y+/eOFn6WNdkxMMQI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63b3129-6a97-475e-8d10-08dde0037653
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:03.4025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3C6X9sVerKjPg6Qp1XsJRYOZOOH/uro4PCGgckU2NJ+V/saauMs84kFggWsmTIE4HC7DYzH1iUP76VzHSIjDHR6I/uFaiMpFOEGzOZ3NF1rfwnFEmEWcVuL/Zc4pXKa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19858

commit 2fc8cfe06e7628de825d53128fd38b3f0e19c989 upstream.

Use newly added devm_pm_runtime_enable() into rzg2l_cru_probe() and
drop unnecessary pm_runtime_disable() from rzg2l_cru_probe() and
rzg2l_csi2_remove().

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-8-tommaso.merciai.xr@=
bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index a5fa2daf534a..1759b9369628 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -288,7 +288,9 @@ static int rzg2l_cru_probe(struct platform_device *pdev=
)
=20
 	cru->num_buf =3D RZG2L_CRU_HW_BUFFER_DEFAULT;
 	pm_suspend_ignore_children(dev, true);
-	pm_runtime_enable(dev);
+	ret =3D devm_pm_runtime_enable(dev);
+	if (ret)
+		goto error_dma_unregister;
=20
 	ret =3D rzg2l_cru_media_init(cru);
 	if (ret)
@@ -298,7 +300,6 @@ static int rzg2l_cru_probe(struct platform_device *pdev=
)
=20
 error_dma_unregister:
 	rzg2l_cru_dma_unregister(cru);
-	pm_runtime_disable(dev);
=20
 	return ret;
 }
@@ -307,8 +308,6 @@ static int rzg2l_cru_remove(struct platform_device *pde=
v)
 {
 	struct rzg2l_cru_dev *cru =3D platform_get_drvdata(pdev);
=20
-	pm_runtime_disable(&pdev->dev);
-
 	v4l2_async_nf_unregister(&cru->notifier);
 	v4l2_async_nf_cleanup(&cru->notifier);
=20
--=20
2.43.0


