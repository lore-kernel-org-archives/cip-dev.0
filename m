Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD2DC5DF87
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:02 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.15])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7157.1787318218052366676
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2026 06:16:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=pG8qqo+a;
 spf=pass (domain: renesas.com, ip: 52.101.229.15, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpfUO/QSMoeoStCqn3wzO+SNVktrbxkicMiCvBmSbW+M8Oa34T+MiQM5hM3ff1L6WdF+diXhzCggX9WnFzMBOeq9yQkxFNiibljpRfDazFx8wnMJ85ontk0hzY/EQRuYlix8e29W2Km9PSCBlYhT5A8YycErFz/oPVCUu/v2EKueW1rPLNgSxfK8DjXUABuUMzr/SvUpk3cMvDs6/VC/wBS+SdCdkRrHwqNu3ZEIK4nUNhljROIeSwdegOrUAGeSB1rdfi6g2w54K+0UpBNYIKW19DK8qVTVjC0z7slskftdiD+LwpwIOxxHp7tvJiYXGiIXHqxwgy3rvZyT73Zh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrIVnBjMs0Ro68uZqcr/OFuGEEpM172qpkaB994o3jg=;
 b=M41oXeTXOdOjyJagB1sRXAJrNTMI87xgKLyzMPcvSrYsClQR5WCP9PX8Xkk1ISQ1sJhn5Ga9ic+SjvhcZOM3Z/D3EcnXDUjPFpUF6sMwlISbca/OTD44XZtzfy5zHXhjMuN2X+HQMyKiGCCaiq/AIuJMWzJIYh8uBX56GVHMw+OVFdPdF8+Q8M5KGlmTpr8qG8+H147a9ji54K+aDr24siXFS1yJjF/xiwm4rcgpX06V4qHnS8/K9xL4+Q47YDDl+pdvwqksZ5iKYtUy58nYvetSqBYfH+IvfCNzWXzZ6QqfIDHkXsMYq+xIhx0U5JWqLKgV2SHC5MWtbYUg7JoBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrIVnBjMs0Ro68uZqcr/OFuGEEpM172qpkaB994o3jg=;
 b=pG8qqo+amNRhRj3wjxdGuJ/BSEzRUmIv5hhlY+5DjSsp6r5WSG1hqf/U2kRwHiD7vaoezv/cSR0H51/H99xKOo0mKod/rI6SazCXT0p/MCe+a6aUJfp1DP+cKyHrARPgBt0Du55vpel1w5TDMWoqRpcMYh/YYBQcfMXkY9HReyU=
Received: from TYCPR01CA0206.jpnprd01.prod.outlook.com (2603:1096:405:7a::17)
 by TYYPR01MB7005.jpnprd01.prod.outlook.com (2603:1096:400:d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 13:16:52 +0000
Received: from TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7a:cafe::14) by TYCPR01CA0206.outlook.office365.com
 (2603:1096:405:7a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 13:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005022.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 13:16:52 +0000
Received: from demon-pc.localdomain (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 1FD3430000A3;
	Fri, 21 Aug 2026 22:16:50 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 03/18] net: phylink: add phylink_prepare_resume()
Date: Fri, 21 Aug 2026 16:15:39 +0300
Message-ID: <20260821131554.638741-4-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005022:EE_|TYYPR01MB7005:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3d79dc6e-fc9c-4387-4311-08deff867736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|10067099003|22082099003|18002099003|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	5P95dZugE3JDwhwhHXGpf2Ekj/bZkbAy9JIBykBebtXyPUc89VlZpHhDA8xUxcLy2d2j0Paq846Z/P7PuxdWtzJnA11UE3BqfiUEeJi9D4K6ZjDxogebokun/yFOox+KL8dulWKTf32OY6jMb1ttFFaba5KvupLbSmwosefGzZ7vWB8Nsugk+mJ6PsxCtEY+emGsSCxvIYW57PKg/CZb6ukxNl+L5bGfaEAZWXICldL4NN2tPqNCkt/2nz2zIL2tBjp5aS6dXMl0rEbTJUF0uLG/kLfQCc08zCeYXdPicYJUIDHiU67KyIZfYpgH6bcW+bsLooiqRQDpGspSEJxaudFou+TrrJLj11Hon4THAK8Y4GsXurzuQuCJXk5c3BMFXksK5QfI9CRuOJMXkYRvO1RnXsJbcJGmPar4TRYu2jDw0H4LD1Z/b6AuZwg5pNQJ7Ni42zeYaoo4qyTVp5LMsBMQwpVcTxTVyZtxj9HCDS9NTpJPsaBxQTGA0bTNJRi3nPQZImoOP3Q+HkQxFChEUHKAiH8Mid5xQ4ViNOuQMuZ08Co/JBqrYslyvAdWRwey7kH/S2z4HGaRRvxcusLaTc+UuVr+RldEjWZ3FqMoO3Zbm7e2IgtACM0w1VxBFHBHDb+kukRfK/hIE07e7uc8zYhBzpZxW0oAMKiG0qb0Qwk=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	bb2LYHdWx2Eg8/2HeKgtVP3tr/0cnjHZLmYofHsTTtRe3gBmKPAshO23azzBlN8+zJf1OSm/D3pCD4hgclOwcgRAS5oygVQ1Rknl+8Tn8+vjVA29gmG8oY1UV60O2kRa+2/Gcg1uzbAFDjze2gWmeKaJ8HsAQ08npTzNW/hF94+LR1lH0KPtEw3OKvTFhHrY66sHT0zJhRTQuyRqAUAHVg7c3xT+Bfhtb/J0KiBL1YlHS/P+8AtdYmyvq1KMKD3x0zarleKVG9wcaWk9rr/E1b9rbieBmbQ7Jjl7JHN8LqBqXTXrP93ibwspZ6uB5Pe85KtX4zlmZ3wuX6VAiRHKj/ySbxUCXJ/PQCFqFOa5z54UomJlFlroGesh7aoEZjogaHzDZOQxJg930Gc1wTpQcV9zBZvG+XyieCOg1S7vJAqijRl8LvvWnKJW8Lp2sKet
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 13:16:52.3411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d79dc6e-fc9c-4387-4311-08deff867736
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7005
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 13:17:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23959

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

commit 367f1854d442b33c4a0305b068ae40d67ccd7d6a upstream.

When the system is suspended, the PHY may be placed in low-power mode
by setting the BMCR 0.11 Power down bit. IEEE 802.3 states that the
behaviour of the PHY in this state is implementation specific, and
the PHY is not required to meet the RX_CLK and TX_CLK requirements.
Essentially, this means that a PHY may stop the clocks that it is
generating while in power down state.

However, MACs exist which require the clocks from the PHY to be running
in order to properly resume. phylink_prepare_resume() provides them
with a way to clear the Power down bit early.

Note, however, that IEEE 802.3 gives PHYs up to 500ms grace before the
transmit and receive clocks meet the requirements after clearing the
power down bit.

Add a resume preparation function, which will ensure that the receive
clock from the PHY is appropriately configured while resuming.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/E1tvO6V-008Vjb-AP@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/net/phy/phylink.c | 25 +++++++++++++++++++++++++
 include/linux/phylink.h   |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index e6f3963739ad..5f5f032ba630 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2353,6 +2353,31 @@ void phylink_suspend(struct phylink *pl, bool mac_wo=
l)
 }
 EXPORT_SYMBOL_GPL(phylink_suspend);
=20
+/**
+ * phylink_prepare_resume() - prepare to resume a network device
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ *
+ * Optional, but if called must be called prior to phylink_resume().
+ *
+ * Prepare to resume a network device, preparing the PHY as necessary.
+ */
+void phylink_prepare_resume(struct phylink *pl)
+{
+	struct phy_device *phydev =3D pl->phydev;
+
+	ASSERT_RTNL();
+
+	/* IEEE 802.3 22.2.4.1.5 allows PHYs to stop their receive clock
+	 * when PDOWN is set. However, some MACs require RXC to be running
+	 * in order to resume. If the MAC requires RXC, and we have a PHY,
+	 * then resume the PHY. Note that 802.3 allows PHYs 500ms before
+	 * the clock meets requirements. We do not implement this delay.
+	 */
+	if (pl->config->mac_requires_rxc && phydev && phydev->suspended)
+		phy_resume(phydev);
+}
+EXPORT_SYMBOL_GPL(phylink_prepare_resume);
+
 /**
  * phylink_resume() - handle a network device resume event
  * @pl: a pointer to a &struct phylink returned from phylink_create()
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 5c01048860c4..62d09a7e7869 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -610,6 +610,7 @@ void phylink_start(struct phylink *);
 void phylink_stop(struct phylink *);
=20
 void phylink_suspend(struct phylink *pl, bool mac_wol);
+void phylink_prepare_resume(struct phylink *pl);
 void phylink_resume(struct phylink *pl);
=20
 void phylink_ethtool_get_wol(struct phylink *, struct ethtool_wolinfo *);
--=20
2.55.0


