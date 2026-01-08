Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B963CF6A8E
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:00 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.27])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2987.1767864538289258226
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:28:58 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=TB5Qju6V;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.27, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibgPc89ZOCVRbGlnxB6h2757wXWpnryRs7D4yjPC0fD+23uiLf6DtgVjoN3Jk0KdtqQurqly3J9HYEluCw0yTwFn172U59/pkdaqHXaPW442UsvdKAAArUcTnL905pQ+v13Fgmuc2ciaMXCZM5E1fSMGoaw1cgBR4lQ/gKOhQ6IV/ofTkhgF43NOVn5ZboaPX9kaCsuGP8S+5KRbujfvWkSno7tAiJxwY8dbqBv0xEdUcKZyq3zve3Cwcf4pRkCjyYmGQhj8ro1TyicL6WwpEF/C4ynSBABalQ8zmyXmALbowPSYOFhjcQcOvrCWq8QO0pKK5berjrTtUlBQhLN7nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7UHIubcT1Z4dvqc76fi+jhhHXfRZ55SjxKzr28bphY=;
 b=MRGI9scPVRnsopwGVg7gtRhBBDKcodLjuym6apRQNL/Fxyv4AFsKhHa7gsDHwpCcibbMoKdMVMlxBuD+sTKiKjJ0RtNyQRXW4cxsJWb5JI/jtqRyStCsKpQ3oRDnNZ24up983rvy++K72m8DSab74QwoBPGl+ukYpQ7qelP22jcfv4DbKRg7+xCq5mZV00ybwB9HktLr552d8/fTgQDdbM5dn+YPEgXlPGdNEqAjwF/ugLwWdEk/cNq+K6Wnao+KQ3c6WwT4X5bNdBujuoHS6bmMpvNv7PGo2TTs6Kllr1An6avxt+rYMgIWG7LMQdgv1eK2krllidzbcXglip0FSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7UHIubcT1Z4dvqc76fi+jhhHXfRZ55SjxKzr28bphY=;
 b=TB5Qju6V9RsJdGFOAwrN8gmzhyKe4rQWKb8DAGrAQqwGSvjAVhOdrCOvTj4HCIoSbYrThvTJQ+UrtJZRHtK5QAF0XDVXgh9uwRFXWBvRVWZGX8nvKPl6Fxc+PmQEeSMQAGlQedrw7Ls3daVmIWzc8GsCZ6fKcNPYKm6bi1lXMvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB12872.jpnprd01.prod.outlook.com (2603:1096:405:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Thu, 8 Jan
 2026 09:28:54 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:28:54 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 03/22] i3c: controllers do not need to depend on I3C
Date: Thu,  8 Jan 2026 10:28:04 +0100
Message-ID: <20260108092823.489287-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB12872:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd7ff7a-ea2b-4280-4ed0-08de4e985766
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PHQfCdDb40KFKdcHMLBew4o7r7n71tckfehawhG9yqthHOzallWzf/XMPonQ?=
 =?us-ascii?Q?Ec5c+gL/mwGQ/q1A6zbikzXhM0NiW9BIhdVZig2nXK3WiNIvtjFhwiFUY1MS?=
 =?us-ascii?Q?hVjjTgJPRMAKZ9spF6NkZqBjJPaKTDOXIpIFM2TY0t71vL0jxUxrvMBCE6GF?=
 =?us-ascii?Q?dJK7tI1WNeNJxj4sla348pGHkG65w7QT6V7Y0VihflUPfToaaOOUzp5O0bPh?=
 =?us-ascii?Q?HByJ5F655XFAANFD0Y6eAtWAZBE6xCR374iyIh3nJEWy03aOgwx3sE9QUVZb?=
 =?us-ascii?Q?PHvNxo9h7mT60HLSm5aY+3/eOlyqdcUSGnNtOTINgcoUFMgpJUlNjchQE+g5?=
 =?us-ascii?Q?4e0E2TUz0KfsQqbxomKCLVOgvkxZ4IdBLepaIqXGD/8PLq7rgg/Ltxi0T2w1?=
 =?us-ascii?Q?7Ra9h3cJqHcHVkYvaZhnJBBfiRYHDaHO+CnvGNPx9vBVHkYI3eUDOdk0uYov?=
 =?us-ascii?Q?FIIWoeHFENlMHhpmVQnVlodt6DbLeqOZg5OpwzvsKBbrtgU85Gjm8O3f96aG?=
 =?us-ascii?Q?M+lHvdwiEB+sjQP+ltM7aOssX6LbVqtnHbceCf5owvCbHQ+OvUhyEU9z45lW?=
 =?us-ascii?Q?tkq8PGxB38XpOVm2ByL+pV27CRWY3/JSNR2vAPMh16CJmRFwWc50Kv2XEFPx?=
 =?us-ascii?Q?wljhxcnxhKERcg6eJghJ2XyfAtCoaZk+NtJn/NRqruXsAPaD/nQ19YfH+vMK?=
 =?us-ascii?Q?oDN8Y9aP/t2ZajjI31YXoJCUmoUJRdg2wjOi86lEZ7ylrLQCFRHqC3TFM3KH?=
 =?us-ascii?Q?YIHNQN8cZjMZDngC1jeUD1/kcqxSWxHarlz+EjF3TgJOEshYPZ0l06hPcQ8s?=
 =?us-ascii?Q?CUx3xbvv+/NvpSK4Ud7SIbP1Zmr6QiyYrH1wwUfYkrt1J8q+zYnFEZj9NkGX?=
 =?us-ascii?Q?brnEaD88O9aDCphkuC/b9LALUts1sDWFKsxv6Rn0C1kT65JMl1n6M1q5HjLq?=
 =?us-ascii?Q?E0Ul3IQZ8Cw15oyBGSKAS4WfzCwFeTOQsld3SopHsmSiudMobZ1goFXjSojt?=
 =?us-ascii?Q?/WMQqO2fORuu9ksaB/El0DkKHpHo41Tu3KuyYAKwqnMHixbEPTBVodrwhjY3?=
 =?us-ascii?Q?+qmwC8PF79yx9ou1yKmmjsi5pDBj9fwc5aITp0T86r3i9GAg/qBpfqMQg2hu?=
 =?us-ascii?Q?zT/nZlzGI5mcJDuK6GhGF139EY8HFERidjdqFYHnWmKha/gm57OTjjif174y?=
 =?us-ascii?Q?lC6GPZVks2K7rQtDyNW04Q+DL3BzF6H05Apadi1psRSQALXw5i4XCzrd3m0L?=
 =?us-ascii?Q?9mQvdPuCQaU00aAbLqvK7wLcpY9mXdbfI2G6Tb49bCPDVGzbNzcCPTsOX4GQ?=
 =?us-ascii?Q?0YXR3/JEtZYM5XZN2ahDqPEXksHonOJ0l1i9wVJxqSiW8W9rqmL5Ylr+Q3SK?=
 =?us-ascii?Q?QV/E7fZPn6vnZimqF7iTXQMSo7jKWMQuE6UiEhko3VwOhAPNJmpaQ1GNefmJ?=
 =?us-ascii?Q?7Ylaa8mgAiyjqPqvupDD7URT58kbQtyl1Z69Yc8Sum9iL7y3y0/bn12djxd4?=
 =?us-ascii?Q?QG6OLBw5Qj50ccE8adaGJs0y3uWf5zAK7O+E?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?b1z5rQS2hctVfSD4Vr3VgRPcuOZZr1tvYO63WADJByybKpgxbgqI8LaT6EfB?=
 =?us-ascii?Q?BWOTkkTphkXcJ2daUo13l9Ry8O5xp+EzB1kqtZdQoDS3akdSKaUScFv5bC+s?=
 =?us-ascii?Q?BcPqqMh8M3VY99Ri7XT6DyY/g+MvN+Y8toL/sa4Elk6bjGf5yIeE8mIWM/RC?=
 =?us-ascii?Q?BHxPgYo5z9BhtuqeZxxcrPQo4fJd0ilKHkziLgCHOupa2NT6BWfmBNn8wwW1?=
 =?us-ascii?Q?j8byF0wkeVoeBRZ2sKTcce6Uo8eMj+F9bnqe82DA0ji0Gb7+BEi0Ps9NFw4c?=
 =?us-ascii?Q?2+MTabRWlesUQ3D3Z/qpeJrb42gh1QH3Pk++9xD2KaSFEkERIS0li5ZVIuEF?=
 =?us-ascii?Q?kxehJ5d3PHVHu56Cq9R+C56rD+2IVZK5T+EVZ/EHbysprk6FBZ7u4+8L9WFg?=
 =?us-ascii?Q?KNqKBEA51xhhStNpgNrxN1ypmqNU6N1cF/JLjm3cBeOQQQ3kgGxBhCrUVFuk?=
 =?us-ascii?Q?M+FivQYhL/IaI7vL7j6BfmIgP7F1YJYd69N78R+z5k5ecFW12gde8krODLyA?=
 =?us-ascii?Q?qkkfeQ5TOy8lkuSEtTDqySqlFcwNLglr7XUM3spOA40asQQndPzq2aSB6D2d?=
 =?us-ascii?Q?1V8jbK1SA3HGD2AD5SnQfBjqYqtLngZiHN6i1miDCRYp/HiNWmVaLpTE7ANe?=
 =?us-ascii?Q?T/ofzfmMskHKktVqbjqM19xfyhTM4UoxCJfQeB7Ez1NHZdjAx/nrMblV5N/Q?=
 =?us-ascii?Q?ksWG5Tpe/v9jahxQOTBvGWpNda84Myamg2mQWTlv4dU838rOfnFxzGCxf41p?=
 =?us-ascii?Q?ZMF2hSTFz4hy/pLHyqNvCx7U55oPUBcoFJATlkvmTE7FYmCz4AadYGDfjDBJ?=
 =?us-ascii?Q?w8uHgaB8iPlkJyrYioF4q8cFk+vyzarUqkzVe7fhylbSzPNvScXXB72Ab3rx?=
 =?us-ascii?Q?H8B+fOOYW/yPTJ9YCHQC0tHcR1zQEXOytLJzqteSr4S62aK/Eb+aVwESis6r?=
 =?us-ascii?Q?rs6eNeAJJdfBCS4Qk5F+/838o8NdumFOXs/1GVn4Hp/zO+SDusVIcgpsqmrj?=
 =?us-ascii?Q?molyCkcMO2y6AkZQO6AfN3hEgZsKbkQN3w1nM9kWu8XzVDAEnrA7k+RL48kZ?=
 =?us-ascii?Q?JnzdlwoMPWdNL0u3hJb/8z4ZXKyGkzOWWi6nlSdZqORTU6lCkQADGA04hFJt?=
 =?us-ascii?Q?wwBLedz4xJsZ3awS2szlNZYQ7IVVAkl/u5RhKBIvAMbCEpXCW+qeN+ndyZRP?=
 =?us-ascii?Q?ytkpAxST6zDWFFDIGMly3QL8AJGWyNf2yXeLw1DdT61BRrnSB+8nOnXLuzG9?=
 =?us-ascii?Q?2lRkx3wGSSaRdIjhHmwxE7zXm0Pl+dcCebPkgoWHvBaEo6+/jIi0mQ9ogvfR?=
 =?us-ascii?Q?dBlVBnQ924astuiUob4lChTHiKYCmgYgfdIYtghGPSs702WwxP7xewHm/rIe?=
 =?us-ascii?Q?DgT1uYlKV+e3kRozetOpwzm2TfUGThIuuK93TB+dctmqGNQqqNlcgaYQpf7d?=
 =?us-ascii?Q?81j+58O943RfJOmnbPaLPo3jWhoJ4GaBgeqF1EaAbM7fccvbUm0EBG/r4myG?=
 =?us-ascii?Q?Gdw8Apxd5O5pJUC4hGR4GDNRnbWQwRFmSio76EL5A9vt/J6U2aBdMnZmjRgy?=
 =?us-ascii?Q?nQsLMTX9ImamBLuzA2oW2KAmddFMR9SfqCUSsplrAgyNqHJ4XTXyvEdiLxJr?=
 =?us-ascii?Q?1ZVGZFcMoWhMbWyIgQv3vHuLXoSedPkry56oRFuDUIVfBe2+rU63UtVk6N/M?=
 =?us-ascii?Q?bq5Dc9xtgMoM5um3CB/97c3dpVONzdGHShkdWhdcfrJJG+fIZUdSaXJjYl/c?=
 =?us-ascii?Q?w6PViqmMt+xz70S7BTaz+6Prh0+a0dRwiqfykS/PgAYrcWr0rama?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd7ff7a-ea2b-4280-4ed0-08de4e985766
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:28:54.5042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: va6BzmL7N/0wL/axWbu52n5ywHDW59DtJtaK51pX0h8ATGl3S3DhOViW8tb+uB7RkJKI4nZDEqK8WQ5ZEpC2oasUSSM2rDeUKIPPOUZQjPBSpVKYNzP+fT1GEzgRC61U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12872
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21439

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 00286d7d643d3c98e48d9cc3a9f471b37154f462 upstream.

The Kconfig file for controller drivers is only sourced if the I3C
symbol is enabled. No need to check for that in individual drivers.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20250506075247.1545-2-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i3c/master/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
index 3b8f95916f46..b5e20b28f107 100644
--- a/drivers/i3c/master/Kconfig
+++ b/drivers/i3c/master/Kconfig
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config CDNS_I3C_MASTER
 	tristate "Cadence I3C master driver"
-	depends on I3C
 	depends on HAS_IOMEM
 	depends on !(ALPHA || PARISC)
 	help
@@ -9,7 +8,6 @@ config CDNS_I3C_MASTER
=20
 config DW_I3C_MASTER
 	tristate "Synospsys DesignWare I3C master driver"
-	depends on I3C
 	depends on HAS_IOMEM
 	depends on !(ALPHA || PARISC)
 	# ALPHA and PARISC needs {read,write}sl()
@@ -24,7 +22,6 @@ config DW_I3C_MASTER
=20
 config SVC_I3C_MASTER
 	tristate "Silvaco I3C Dual-Role Master driver"
-	depends on I3C
 	depends on HAS_IOMEM
 	depends on !(ALPHA || PARISC)
 	help
@@ -32,7 +29,6 @@ config SVC_I3C_MASTER
=20
 config MIPI_I3C_HCI
 	tristate "MIPI I3C Host Controller Interface driver (EXPERIMENTAL)"
-	depends on I3C
 	depends on HAS_IOMEM
 	help
 	  Support for hardware following the MIPI Aliance's I3C Host Controller
--=20
2.43.0


