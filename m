Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E54C5DF89
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:12 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7161.1787318222338674258
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2026 06:17:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=J5pJ5MF5;
 spf=pass (domain: renesas.com, ip: 40.107.74.46, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHCEJ09d37NjyJ/eF/OsUDZBnYrM5QYBxpky4zQ7EUSQE9HXrNgJXFUmaIHR3chEafEiCRmMs3kkJ2i1xyEipiIKSFFzdm5JtjGzRlnwP6VYhpCk6fnZiUlGjwV7t5PJ65/GlDrOeMAhiFmSYRcpMXKnCNIDngoGtIR2GycvF0DqLViVAXamdT8rrNV/hLaNBaml9gDajrgS8tpTQPGwRkcA8R1qyp59EINFchoVFCEi4y/pH5+/29jWPF25DwI7yJL9vrQFBIc4MwaRNQytHK/H/Zi5SZ435SAhbdVGWDtIb1cq1pfSIEVVRm7q/5tjEUMij08PMioK0RnkqXKifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdt2kd6ydIvTlkXUxDCzdVR9RKt6FS+lWX5HVFIHXPE=;
 b=ttcDyW5meh5T6WZtfavM0EBYbUVX9ekyEPjKrhfoO28jYq2zQil6r5DAnhIro2TpByeUpvH7AA3HsPNyoITbTHm85/k+9BzOWDq4hFgx2SeasYm/hVNoQwgif507hnCpsL4amkX5fBUxHQ9TBLZsWU+zVgh52tXFqDwDY/T6M8KMC++mdfs+HE6Mcrh6nk+W0sDq2of3jjU088O0HJr27GP+mCnq0FBoJ0Z04Tv6eg5Hcx9rdhiuUzofE2FeQocH+9Ut47UbYZY8zxBN2WgM7/BdXPyvnon255bYtlfrYKhrf1ioOMq9wDKbIFIex8MZ8WdBAwNs2YHuWXBnslE+Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdt2kd6ydIvTlkXUxDCzdVR9RKt6FS+lWX5HVFIHXPE=;
 b=J5pJ5MF5PxWZqQJ7faknoQO9KykBEjjvsQwTWXDkwDQnNeS569ZSYITgRIEbjKS2zXLGjPYIrNNxphcec75mIknq9c5coYBx96hUt9fN9GZ1J6OJIo9lBsVz6FPN/Z/koxus3qRdxYNBnqFk7G3jKSiM4HoQZ47XA7UNk64BzA4=
Received: from OS0PR01CA0030.jpnprd01.prod.outlook.com (2603:1096:604:25::17)
 by OS9PR01MB15186.jpnprd01.prod.outlook.com (2603:1096:604:3ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 13:16:54 +0000
Received: from OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:25:cafe::50) by OS0PR01CA0030.outlook.office365.com
 (2603:1096:604:25::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 13:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20E.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 13:16:54 +0000
Received: from demon-pc.localdomain (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id D3DF93000374;
	Fri, 21 Aug 2026 22:16:52 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 04/18] net: stmmac: simplify phylink_suspend() and phylink_resume() calls
Date: Fri, 21 Aug 2026 16:15:40 +0300
Message-ID: <20260821131554.638741-5-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20E:EE_|OS9PR01MB15186:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 34199a5a-b575-4f2a-3f66-08deff867851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|13003099007|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	41FQbzMhhwmBhFaEr6yXrRS55NZiuebvwDP+aprKYsQsmWl/6p3pgqUoLu0nse7/VUN4Ut2bZ90mNHFRD4+9VGLIpINaW4s8yXg+vMwA/mD4UWXaTIlePAUoLNX7xG8ZUQVSrD/dDjpP5i++I7K+8HpqqC6FzjEGWIb+xqIpHPDri4ZACB2inDKG+Se7d6YDVdOGl3Z5JJvThOI/Q/UpGCpDPgPhg5IfjpzR/gLH2esj1mjtXkJHCCu2hsWb2q13R4QFElB11fQQj4OEy7B8ctK7GlsIRM95mVkNjiWHng39cf3qeizD+H+T2ElIa2nZyeL/NQUbT4lSeSck3lvwPnpKubZiQlFgW+QAx982dPFVibgXja50f+QHsCF3zkRckpPPoMcxJDmW4yPtGH2cYUfMmIfP+nI32XrWKwuzMYIZYzHxXcvp/unbdQOBD/3SVsIp9r0rYOh2oshgHdG6fLwvk2msrWCFRXuA7ytKzqhjkg8bKxBS+UYBAg6dgR0msxF93yUkXgmlihCemxB+DzkWe98QLOKDZgr0cSOyLPurnxC3XOAXYodeuuKnR54PcpzUlx6dIm1Dkxj+sG9hfn9pbn1OaQajMH3DhH5B+xZxWdgJNe6BjKr1Ebiq3HIiOQQ2yttROaddjaaTLNuUvw==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(13003099007)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	lm8PIhjyYhF8HijmJNKDFwKTJXHTgYyPiRS6gfkxE5MC8GLxRILkL/0q6Qu51/xmxakatbYBqM6wWLcoL+j9lQUIKVWjJGjfxlBajA8fJOXX6WVD0I8RKfKNFb6qNM82dDJN/+z1sLkVftsROBN/Plw1qqLd38UqvFI+oRNDoHLZOrDIu6FhbzNrVmqB0ED+xsrseCSJo8C4RZC/muwG6aMWY39EcaWblBtRLgnxDa77TTj4HxOsfPaYw48QzDmBQkaOtJOI2ud0wPhacJ8juAxDUi+UAjKikuVV6RHrUCxvjya/j+GA/emtLrrMqje/tzVHWEnBiu/zJ9+uysYnwy5cBniNisuNNZ3WOBXILobCE67DrLxW5loMwUmctCWfebTkSqniQnx6W5XWjGzJTDS0POzOL65nVV33FtoE4DF6bMSmvm0g9vycbo3ATsFJ
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 13:16:54.1830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34199a5a-b575-4f2a-3f66-08deff867851
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15186
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 13:17:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23961

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

commit f732549eb303d7e382f5101b82bb6852ad4ad642 upstream.

Currently, the calls to phylink's suspend and resume functions are
inside overly complex tests, and boil down to:

	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
		call phylink
	} else {
		call phylink and
		if (device_may_wakeup(priv->device))
			do something else
	}

This results in phylink always being called, possibly with differing
arguments for phylink_suspend().

Simplify this code, noting that each site is slightly different due to
the order in which phylink is called and the "something else".

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/E1tpQL1-005St4-Hn@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 22 +++++++------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_main.c
index 6cdf9ddfabfc..8187e6934668 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7950,13 +7950,11 @@ int stmmac_suspend(struct device *dev)
 	mutex_unlock(&priv->lock);
=20
 	rtnl_lock();
-	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
-		phylink_suspend(priv->phylink, true);
-	} else {
-		if (device_may_wakeup(priv->device))
-			phylink_speed_down(priv->phylink, false);
-		phylink_suspend(priv->phylink, false);
-	}
+	if (device_may_wakeup(priv->device) && !priv->plat->pmt)
+		phylink_speed_down(priv->phylink, false);
+
+	phylink_suspend(priv->phylink,
+			device_may_wakeup(priv->device) && priv->plat->pmt);
 	rtnl_unlock();
=20
 	if (priv->dma_cap.fpesel)
@@ -8046,13 +8044,9 @@ int stmmac_resume(struct device *dev)
 	}
=20
 	rtnl_lock();
-	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
-		phylink_resume(priv->phylink);
-	} else {
-		phylink_resume(priv->phylink);
-		if (device_may_wakeup(priv->device))
-			phylink_speed_up(priv->phylink);
-	}
+	phylink_resume(priv->phylink);
+	if (device_may_wakeup(priv->device) && !priv->plat->pmt)
+		phylink_speed_up(priv->phylink);
 	rtnl_unlock();
=20
 	rtnl_lock();
--=20
2.55.0


