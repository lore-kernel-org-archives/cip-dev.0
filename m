Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEA3C43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 18:23:54 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.156745.1783362223959707523
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Jul 2026 11:23:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ZJNwuwpw;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.57, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjY7TzxwNJBeIXB6JU7a0Yjtw5S62DCrD0FiCejjrA6pAY7SgtWfOrv95munfOGoeFFSn25alv0f3qxYs1ojzj8UAyWdtL5DrF7R36F4xdZ4iEdcIAePXPErOZeEHHawXTnInn4eX/DeLJkKWH6GA3lbE2zj6cPHcYzGtRzjuNQBrp5e6iGCxtKl9bMmANNhMVRQqjQE1mGHKaW7JxY5ySQks8HyWkvNBdsSxMNY6gXR1w0lIlj6wGPwLYTK/+AlogTf9y6aJbFNvatBCsVMfGJy9CLaz5cez2unwvCFUYqpuCluZ2YDl+lYOmFQMhm5NIxq4iTfImkA1Ze/eCyK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ft6B8xJ2eVyK5NDcBvd0tPdxxCdUUO/6Ij0OzLgGdPQ=;
 b=HXeohNkTQsruGXB7gotY39lRRXPjfV/q4TGzNAZyMO3gA3/RdoJPc0D0ETuZcfg82GeHJhBgDoUpRFc566UHtzOd6rGldz5kkADbuAVSoB9NEO6fBc/N8CcZIP+uo/gPYysYDt2jEZijLVtO3vBK0+E+dKhFafwsUuWrLcqI6zKQQFKRMVkugGoJBQcg2MZcBj+R6CipXJTmC80mdY0TUHflNH514k7woZD+NtQH/9VozVEK25g7OL1LWpJct/lCTJQSh/AqjTeP29h1uOki81QDfIrNTJlnQkF04KNtZnZUqWyZql9rJcHnH1AiZ6HSKDkn/mAzKo7yN2NFDIDJxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ft6B8xJ2eVyK5NDcBvd0tPdxxCdUUO/6Ij0OzLgGdPQ=;
 b=ZJNwuwpwvkKmJLxigEKDZAsJT/pCANrbFsppiUaWSREeE+Tb+krAkl3NQ7+GHgS3ZUtO0awubLVwbnOrdvcDMl/LrfBaCVIc0fnVaZIPr+kvcSRzPlh/lxxiCbKWIQ6ztA09y8BluKz2klgivwdzxdX4Ja7EgLr7Ek+ysXHP2wc=
Received: from OS7PR01CA0224.jpnprd01.prod.outlook.com (2603:1096:604:252::8)
 by OS7PR01MB17108.jpnprd01.prod.outlook.com (2603:1096:604:457::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Mon, 6 Jul 2026
 18:23:38 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:252:cafe::20) by OS7PR01CA0224.outlook.office365.com
 (2603:1096:604:252::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 18:23:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 6 Jul 2026 18:23:38 +0000
Received: from Ubuntu-22.. (ed-eng-lt-ism.diasemi.com [10.24.0.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 1571D3000154;
	Tue,  7 Jul 2026 03:23:36 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 4/8] memory: renesas-rpc-if: Fix duplicate device name on multi-instance platforms
Date: Mon,  6 Jul 2026 19:23:24 +0100
Message-ID: <20260706182328.5237-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|OS7PR01MB17108:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3461594f-e174-401b-e404-08dedb8bb320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	ZtV9Y1fmmhS21WTnWn88pohV+ANfQrVCXSXKSvX2rr9B9P1PKPWH9CVFbt/ElQSbIDurcXdvq1jiTVjzb370TFKKqYd2Yd+b+vgPywBysyeC7J1SV+/Ns5j9PZMD5TLsKs/Vzwy4CgUJL2AM3J3e6pS83MbV7jsNYODDtaxBNEytbSHyW8fnfoahlogpnC2+uJnPltRqrMPAlH4OERXddZBpGgOHD6e4daAzxYR3FCP3SGJlOaCx510HPFLvHSwPBXTmPjHF2xLk8tN05eRJFauXXgwf8YuTIFLJDhkxCrgFZfSIqm6NUL811HaKHSOA1BkV1Dg43tAZqxR4EoCjTWpuYK21N7HyTXmjmg5j3iy2WLzPUQT1AAaIYFWvsj2WA1QVarfli7blqtnZh8HJ4wi3csww3EIcZazQH1gpvtsQ3aQSRS14nsve3E40KHAvcywl70Wvxe8RInuYRFDaBx656apY+6f1l3mAo7VCNwq+y9D0r9RgUK2v/c1U3q6xHZzRWJjsooT33nqBMxTa5gYRqIAbZRjnK5wuTOF+CmtrggRGCjniBOEi6dIPIaJUvVTPFEOTAwmo9lVAedo+ue4vosRGis/ipUDuGdcFQ3LsGcBqLipJe7fAdgFzemHbnnq1TulRM5lYG3Fw9AU1euYoL8U/YMi0Ji8C5vha5l0=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	9cRu7AUfUkJG1PS5ArIwDafTyvMa48mlE1shQzItZjXN44m/TF/4jAl25TwruNxMxEtr67LmpkcSN56sDg0OnCX0f7GHNGuGT2qWv6E6DkYmP8eQ0RSDRjqmRzMJpCc3w3Wud3S8r+5VrPovBNSy5GXg47Si/6WfmF0aL8M6Gft3xd7+9tkmXNUw6pzlA9z3IrxTCGoqhavrWhtAffUAPntZPhBFuwdHopvZvEORUWpe5fzxu5o6bLLCASsDuA2v2KbuxMEwWoHyXE7FjoBrrwcXOGzdw2BF9i1Dd0pl+pih4CGGOgDvzOdFZ74oEQUYASlgyOygAj/fIv4DUf+NV/zihLexOlzT/k07EuAJcQJ5/NviBqtE7tJxpHAEy9oIlTFGNK4cehDQXYtu9cV7MhM18kXOPUXAb5Hmq1LKTNWkeAx5j7XXmDwGM1xnf/kt
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:23:38.4758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3461594f-e174-401b-e404-08dedb8bb320
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB17108
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Jul 2026 18:23:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23466

commit 3fcf9f334d272989b57acc7b94d4eac717206118 upstream.

On platforms with multiple xSPI instances, the driver fails to probe
additional instances due to duplicate sysfs entries:

  [   86.878242] sysfs: cannot create duplicate filename '/bus/platform/dev=
ices/rpc-if-spi'

This occurs because platform_device_alloc() uses pdev->id for the device
ID, which may be PLATFORM_DEVID_NONE (-1) for multiple instances, causing
all instances to attempt registration with the same name.

Fix this by using PLATFORM_DEVID_AUTO instead, which automatically assigns
unique IDs to each device instance, allowing multiple xSPI controllers to
coexist without naming conflicts.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20260515115202.1515577-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-i=
f.c
index 543e03b8aba8..2fd947ba5cce 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -1038,7 +1038,7 @@ static int rpcif_probe(struct platform_device *pdev)
 					     "cannot get enabled spi clk\n");
 	}
=20
-	vdev =3D platform_device_alloc(name, pdev->id);
+	vdev =3D platform_device_alloc(name, PLATFORM_DEVID_AUTO);
 	if (!vdev)
 		return -ENOMEM;
 	vdev->dev.parent =3D dev;
--=20
2.43.0


