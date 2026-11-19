Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.833.1795110946690967282
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2026 09:55:47 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=JkrW97ze;
 spf=pass (domain: renesas.com, ip: 52.101.228.9, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjJ27bAJPAFKjveKNerN9DsLZJeTYuloll0osOnhwsyLuXGocSFxRfVpZCvh81cRMv0r8eXjeWexgor+aZ7WZ4Ngkan3kk/clGxWBuXXy6NEcsNNkfQYY3sWfbm9KE89Nlh1MaQ+Kx44+GQXu3jaDQ8KcOrC5voq5WvmiyDE7Fgbea1kMBRNoiQsQj5TXi4yoeI59i7kXAC7cQUlYQXtwKqbxTiIcJNitfDFfACweQuEwRt3JmiJUthe8qVUQN4c9wv8Z99JchBONov78PVn0JikBPeN0cyqOls0KWG1KnErX7JjIhlwsjQE6o5h3x11A1bEV/ovWZgJVyXMeTekJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/b4jTKpevWX3doQ/8rSWQ5iIuQOa9wPVZP4ty9edrM=;
 b=nTa4s3yp3YjwzPRwv3fTGlQiNKhbvrDwZihmA8cJaweXWXL3EqFOtZt92kijAt+kpzgiQzey3nxSQkCx6WoQB/2mmcex4dJjY8C+dTfB6WKEeC2R/3aOQDrpxQq9zRzmFfgT06zEw+dBdIfwpMSEr/FHQ66qmP+rv82/FUdFYZ16ngBfE0bBOE+I7WOeYzmuukgxhjx/PzdoXiIJcf4JAi7GzMOywYrr8NfTATcLSyId7oTWLtFbGF2WTLZprZwnXnjpB1A+WcSQfCnxi3KQx3zh+tKfVHjQhJhF8BW7OAX/770DDbqwrzuJv3U6iEwM3rhGiyumfy+TiJ66RBX0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/b4jTKpevWX3doQ/8rSWQ5iIuQOa9wPVZP4ty9edrM=;
 b=JkrW97zeEo2M+w6kjlo1QIVTS6cTZW2M0Cnv76BJguAP6B2pgjpOSHcNVkfCmvEqMwZF21CZCMGVDoq1utsD7nyKpKyi38xpECP/qTWeRUxn8Gp6G4sJgZ7RXwNKt69QimMWTMQ+vgdtbVugySB2oGZRQyC3OZVMMQEVVdQd5ow=
Received: from TYCP286CA0257.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:455::8)
 by OS9PR01MB319028.jpnprd01.prod.outlook.com (2603:1096:604:547::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 17:55:42 +0000
Received: from TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455:cafe::91) by TYCP286CA0257.outlook.office365.com
 (2603:1096:400:455::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 19 Nov 2026 17:55:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD8.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 17:55:42 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.9])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 437D33000253;
	Fri, 20 Nov 2026 02:55:41 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 4.19.y-cip 4/8] mmc: renesas_sdhi: remove double clear of automatic correction
Date: Thu, 19 Nov 2026 17:55:29 +0000
Message-ID: <20261119175533.110210-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119175533.110210-1-ovidiu.panait.rb@renesas.com>
References: <20261119175533.110210-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: ovidiu.panait.rb@renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD8:EE_|OS9PR01MB319028:EE_
X-MS-Office365-Filtering-Correlation-Id: af515296-30db-458a-60c6-08df46665457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|10067099003|261021123027099003|11063799006|56012099006|261022105027099003|261026140227099003|261028144727099003|261026121527099003|261009223027099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 1MZY2QQ11UdLZ/0Zl78CX/ZyoVIYwT0fGB7iwJZY3H4iFZTDyjmIjB3+saqGkCZPY2L0Fv7qil5VWe3+8tgvsF4VtJXQW+sEobs9IpiXoo7WWKo1Nx5Ud8n942zYRwKnY5HX+Ydw8yGOk5R+S6DURdHXKkXVpGSDS/lo+8a87/wnEJSv/1/AU6VUqF0eOL12iewb8bDwcyoz1ALg4JhLnntq6UvvDdindEWrNoliDzDb1x3hmemBYwT67nkf7dw6Y02mMuTUrn2uMMa5WI9SGE4pJiyyDPYh6kK+kVQhJcjCdM2OpT/KwcNrAZ4fmIvi2X7itV8CK5Q96/8oO4Ok9HOt6qDWRScB/3KuhLAyiUCLll23fEA0Ore3u0Gy2dwJCAzbYaQ2MLTOIWnv7KoH5oGWR46AoEB87OA4Uig5SAi+YqM9yIpv5v8dsRdjOREvuClM7QC6TnlFC/CDlkbNqv/FVktIaG4SwK2xy0NQgBZ6pgguq4dmzONn+a2bF3+PReMBXPvll+FMD8bf2Ay2dXb6gSDBOktANHZY4WL/YDDD5V9z0usLUT5LXx6ly0HCd/miWt0+lMGYA9zFEYsk+w1+H5y1Sbe6/WgcPr9XbHYO3sqSq2slHqFB51muK5E2ptW0v5+sRKhvFK9zqIFkHRrGLOTt5z5LX9REzXK8fNM=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(10067099003)(261021123027099003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261009223027099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4S2MTkz6GjzbqfiqxSU3/ZcV94/AH2eFoCq8cdNwnmYFMLOV6W02OYlEjsHmzc9u/Z/c/4ZCOK7Dk9RCRyKeXa0efwJn5D8Ck0CVefTVENuyQYBMekpxbMc+F12m33Y9sD1kv+O8/VSx8V9fFJz0EQL4BKVPMUtbW4t+RfxIpDRD9MQVrfuhDQRWb5NH/YfIBrYyZATnU4G7WJUq8hWFvoddHFokPJt6PFTuvRrZV0BSd46T3PQxcLEcyDj1G0BUkqQ46F5KfIXrwv8eR81wIRU1Z9iJbYQPObdvNObkJITtRnjCWqPfkxwa084Czi0DWC5f6MLhGQHMTx2TA0vJsdp4/apOIxIi30Y0lxuA6wZwqUQG7GsScKQOb6q/4JgafKX5M4YugTOpIKAV6MU2E5jjoICwD4qnFSiL/PF+9Yo0HVcy1RLyUyGKIo/HqfFr
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:55:42.5013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af515296-30db-458a-60c6-08df46665457
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB319028
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 17:55:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25020
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 44f54e701205d78e78bbac67d764a8833c2717c1 upstream.

hw_reset() clears the automatic correction bit twice. I couldn't find
anything in the docs recommending that. Removing one of them didn't
cause any regressions here, so keep it simple.

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20191217114034.13290-2-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesa=
s_sdhi_core.c
index 1d5d1b8cc340..572880df60f7 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -553,10 +553,6 @@ static void renesas_sdhi_hw_reset(struct tmio_mmc_host=
 *host)
 		       ~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
 		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
=20
-	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL,
-		       ~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
-		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
-
 	if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
 		sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK,
 					     TMIO_MASK_INIT_RCAR2);
--=20
2.34.1

