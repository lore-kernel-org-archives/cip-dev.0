Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACF0CD4F3E
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:40:23 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6963.1778751618205762317
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:40:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YQzA0+oX;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.4, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FobqvBsT3OcJZQz6GTjJ0rdwJ2dbzg9VksiTyz++I/0kTU6+WhvajySHMYsElZUpm6QM4NkKO8CCcjk7MOjHBmTF2XaZWQrFtc6APMl9j+A1UHZ/pSrTgb07n3r2gnvi1qkvK6wxzCPbw1W96J0xHNNz4QuaAoNKTcJtlMK0Wp4O8SRXO/j/w1pfWSB7oh8diO5x20ImAp4cZ0Qbzk0nuFjyBE/mqBwUoTy67jJ7Bw/LYfcSTZCpEMH6QWFk7+Yd2ib8Q/MM9agZ1Mumg9NgWq2ml0petmKpKjjh7XzsOPmwtZFad3u9qpkPsczz/mI5uGdZX98TF6ZGLray4VGCeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4v4LBguXkMkFuOnnAC+92ZXUyjeouDbHQS7jq3Xl4Y=;
 b=C1UbplFFgiSBPelA4ryj9YFOwkXWQBxPSwbS+NPV+7wqXWNtwfJtCV21hj3HV4miLJl6+Iob81zhJ1csLdGePvWf/DbpALxizgSbIxebMTKo7OKu2/Soa2BdBaLqCgbKUVSwNEvh0M1RnAo3C6rVSD+NQpwE30l0ChldOSF+oxeLIHPFklFRiJq7a0XAVdYTDTqLQDWb/CloLfP2lApRG2r48IvnAP03XPDEdUeewcHvLxgOn5XlgcGz/lmp6nMW6lJOFclE6mjGh+IEv3rKPCfB23TcthZm0roPyCldPnqBP6Lo2GVo2nl8BtEH3hh7FYoMmZ627EZ/+xh9Rg98JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4v4LBguXkMkFuOnnAC+92ZXUyjeouDbHQS7jq3Xl4Y=;
 b=YQzA0+oXMjdXxWyispwfiFcRdHr/eV4ajGe2e1QzuUJw57xea5vu2lZF/SYDm2D0x6+DTgjC/aPFrfjYWD3PNV36ysZEBQ7ncmPN2KtK2p3NDbKlbk5qBZSsdabszH9ZveZYmrCMxqwPnWI1LR0gJ8qEVDVvcT0UNzW7YjG9ua0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYWPR01MB8821.jpnprd01.prod.outlook.com (2603:1096:400:16c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:40:15 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:40:15 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 04/17] PCI: rzg3s-host: Fix reset handling in probe error path
Date: Thu, 14 May 2026 09:39:22 +0000
Message-ID: <20260514093935.2212718-5-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
References: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::11) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TYWPR01MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6bb26a-6e94-4893-1646-08deb19ccd67
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: 
	bCmy0xZg6brROO/wtwbfxVmFfSbynVz772Z+t6rUCBptifWzVx+udO9plq5ibNDwee8Ch6tU8Z4lZBZlWDPENpJkBlOe5U5MxASm1rKseNntsKwIL2Y8V8LiVMrWkMGc+1mFG2OvV4Un2XpLPlew7dQfB87LgZydsCpCHtTcjsWd6lY+0pjYgKrEl4bvo7io+yrZvqCqUA9tnRGba4LTOQHmSYjMaQs1c/GhOJXXFb676zueiZ+8cjgq0T1UygRC5dVqBD3edzAJHWFJMENw6fy6S2xMWBqmpgoLKrdxoI8hn72ZPkcSVYJCzGmDWUtDngMiQ0SH2cmeyzalBijOYuHzjHBSkhatctu+qTLbiGhdjlGROivwYcgMsSD+DTc7U2N845hYsFRQ9/hHiZSEL+DaIvo0XDXSpumukZcCJxSODdP9sdNV9ViCWWXJ3YIVXzUB8SS5SlyCheFP1tzm9HGO7yOiE95SG5VVLHqbBdvwrd++4ChsDRMEcYn5L31uwyETgTO9F7bO1ZgW2LVMot/l7We9hvjE+/i9rQYc2jCdNiaGSWFD/zlIYSmVTcLi9Jyr+r7AHAOCAWfC1oFg/j3B1eNylJ9XCdDy+3OG0o3l8V0r4zQlzNm296Rya/4Tv/Zk9OCx9/TLfKH16dD3Ve/FiGMaXrsweyZQ8c/w5fq4gFR94QU3lzSUBhC7BVkD3ZpZ1rT7NIhwdxZ88aLwaQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?L9Q12vv1CZ/DTixzYXon+4H48qUhOBJrl0HmbZ6impoI0e9nhxFrtPv0qpqj?=
 =?us-ascii?Q?WkuGhpEV5CR3XGpC4R7K6UvG75PVtPhGBrGfgJMqdaWqqfPJwlZAEEO9BvJ5?=
 =?us-ascii?Q?ZnJ/+vRjVW6/XIwbhYEmTQ5nQABz/5xo27NQ3lA67BCJJWqe+9AYY1r2dGQv?=
 =?us-ascii?Q?QRipWeaOR8/I7+iX/xzBIrvE2VtQecpuHriDDKnTHGaSWQ+r75j4ioeva+mx?=
 =?us-ascii?Q?ufiCeGoak0Au4oNgsHUPUk9eWBZsjBTmYcZkKh8JVvHszv9uDnOQsyavNHDx?=
 =?us-ascii?Q?2yWy0QkoUfv+8UttdEgDpY+Ne2TZ9K6fvJMRr+TkHsz+iB7rk8J8qmQKK1Ho?=
 =?us-ascii?Q?5j4U8UKACxKaJ/4ebkRxJGwGatEL1cqLvZ3tdGYdoEOn+8jP/+NcLoNEuLkv?=
 =?us-ascii?Q?Y2s1wiwbIF7eX3ymHIqmI5zt9b+lciYDLIsdkkLXord8K/ot3MJT7x+0Z8IL?=
 =?us-ascii?Q?i7Kl6bMVfH/l7arSupaF8oDLuwyi45hUjtp8bGR+x6JYkAyyr4hFJ56xfRRM?=
 =?us-ascii?Q?xi8nwvqdKGE5207lrNIvPN2AW+G6TkcmzaCALrAu5ALkdEPOLXoFBw47oGfK?=
 =?us-ascii?Q?fMXZyqlY1wk1YYUbSHFwPmdufIHQIQVZXtnKLRwBTJEkf3PYSiOxcLSerCUE?=
 =?us-ascii?Q?68zBXCrY8dXhA9NmaWzk8rw4OK87T/RiSp0dFkKoA5gl5QC1lqNjmrUlCpJ2?=
 =?us-ascii?Q?nAkJeN3knEFGPRVNqdLZrLD+3GlypTGlxGt7VVG3e+9ma1qjrD0hSyVJA9se?=
 =?us-ascii?Q?nGmlh5BdQTO542+djXkcnbUE3FwybUZEvZ3xNWNQhLCN0Rjl4TfXu3jsyhHB?=
 =?us-ascii?Q?u/um4k64pWJiF8TLXe6PCzgIGF7mu4C6FTsWXCR1UcnIBsfg8o9pywJzKEDC?=
 =?us-ascii?Q?IKoZpxY6mPQeYWCsUccVpIMR1LCAXwHIhHruUCeeSA60+b2yOZE5OM/L0jut?=
 =?us-ascii?Q?LvJziz/9RjO31+Tkn8k5jaXlko7sp7aOPbwo4zG/UbarMsvYWBXHReBPjFOC?=
 =?us-ascii?Q?GCGkRdij1EZ6teBtVCsDTVmnT6Lf3E4Msa3W5kWBPJjIegvR3fNOAyzn8zvD?=
 =?us-ascii?Q?rEFgV6JZqi04C6X9pSova6UsHyK9CiX7FZ79d+OHrI+IYMj6AonYoIwcl5IO?=
 =?us-ascii?Q?J2WW8casafxHC7gfOuMzuuz6CQh/+yQXf06RLSgnEyK7/WfIwQMU7VsrADs7?=
 =?us-ascii?Q?ozNpxyGdXCFwphT5MFai4su3Hc9TlIDRnfTmHN/UU8uMsxRTu89fVyQTCRFh?=
 =?us-ascii?Q?6w+aj09vHQUJ2r8avR6FrnvFygp3kpnXpqrhXlwLJmc+/PLPp/nNnVmKHak4?=
 =?us-ascii?Q?T3bNmXXQGpA/oPBCSxoCznqRUGa0cT9BPRBUTNUTy92vGH+29UOARavkhhs0?=
 =?us-ascii?Q?nbUoZUAOHQP4ARCSqMa3aWhBf7OYncJu0i2A9wZHn4sT4s60WQ6XfyRmt+bV?=
 =?us-ascii?Q?g1lkwchavcGNMzRu8tEHUJtPgiVk0E9tiB5t6W+ng3ZdNLzNqrU1BfGdPvxh?=
 =?us-ascii?Q?LA6rfE6c+LJquiXFANcEyK/X/IS77K29qZ6ivSqi9xvEaGcVKbzOxbgJRMe/?=
 =?us-ascii?Q?033repZXOe9uUR5cMsTNI1iwhr1NN5WFbq5BVt8I6L2aFPF+7aVB5PU/6d+K?=
 =?us-ascii?Q?lsxQ+KWpE5En0MJs8si7l1tJpVGCojzedRChSYLImgj2ATzcFWbDhmOhKDk7?=
 =?us-ascii?Q?d2KYrU3x/scQxVR07+QhUbRHgV0mxGIPbtCVwZ8IaL2WyqqYSvR+ak9DbMQt?=
 =?us-ascii?Q?d6Vsuv6Ae6kx2WDiQKoyedYs8LDejHQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6bb26a-6e94-4893-1646-08deb19ccd67
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:40:15.6007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhkOVSqVbCbChbH/B1jo0uJPSRqFOZui7pG/YtF+gBEzU1DcuW08hmsI6mywNNhkhMiKX0HmrlXz5+V3K6pmpW1c6t3lptivwGtVY4UbruA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8821
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:40:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22938

[ Upstream commit d284389d4576e7c8040dc4cbb66876e539c6d064 ]

Fix incorrect reset_control_bulk_deassert() call in the probe error
path. When unwinding from a failed pci_host_probe(), the configuration
resets should be asserted to restore the hardware to its initial state,
not deasserted again.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260306143423.19562-2-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/control=
ler/pcie-rzg3s-host.c
index 46be4dba46be..5d524af316e4 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1611,8 +1611,7 @@ static int rzg3s_pcie_probe(struct platform_device *p=
dev)
=20
 host_probe_teardown:
 	rzg3s_pcie_teardown_irqdomain(host);
-	reset_control_bulk_deassert(host->data->num_cfg_resets,
-				    host->cfg_resets);
+	reset_control_bulk_assert(host->data->num_cfg_resets, host->cfg_resets);
 rpm_put:
 	pm_runtime_put_sync(dev);
 rpm_disable:
--=20
2.25.1


