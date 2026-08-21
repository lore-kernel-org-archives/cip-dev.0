Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED9AC5DF97
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:13 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7128.1787318222901253469
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2026 06:17:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=PbKK01VO;
 spf=pass (domain: renesas.com, ip: 40.107.74.53, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xI8OxGItqBwlFVBLvAaCWWGjE81C0KxTsOSU794xdSSCObXQYaPVkD5f8XG7dKFFq6dDIfgw94fMYOSQ8n4TBZRl+v9PlP09+Z4RDW3L07dBvG024YfS2RxG4DzKmSI7+mPsFsnM7K4ey3VRHEHXjSq0/+MawOkqYPGEym2mtuX+EmrPPkC9UaFoKYUkppctuEtG/8vweiUKvhR7Z3HqaSJztzms0Qs7Z3dX4j1qeSdeHHiPSe7yafsh9tUdZbr1EN47Wnq+HP2WYbvPOesPLovncLA3GxXSzEz/s9XYbfeGMek99ZigcfApIO0ClDI4FJrfVN64Ac5riaHv0aSWUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeejzSeuoFy2iW/M4JCgVl1QYMyOT3Y76XRcnqelsN4=;
 b=U6tGuUOh+QanvAUmg7XYt7S7fP4Xoosgmobnyy+JFhcaOyxbwsxRzWKzSXDr+KUacwoDnAHvY32Ww08+dhgg7v2AJw089OcNnDt4goArSwS8NHO4aAbRBbw8eKtwd/5GSEwvwExFtRNjL9izuO43ujhro2Z0qOjiUbbzzxCfLEAbSLNJlMUH268hxEUMvSmo2l9TW1QYjrAFr3GhkdNNynK4+jsS4r8cjnSU7aOfXxF4xz6SbKcbJLlSFuzUku++YUXrpVXjUXb2I5g4NyfrHIzZ78F7bgE/bXz+pjrH7o2ZqTI+mAJZdA/r2pAcDIYW85t/sSEIEEXvHuKlsWrOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeejzSeuoFy2iW/M4JCgVl1QYMyOT3Y76XRcnqelsN4=;
 b=PbKK01VObAFXTMi9FCpFAsFCE0DsmbL4rWjrXg7gC3270BWsmZpCcpZ1qIgh8TDzW9Ux52ZHT1Zp/TgwOao1vDqMO/MvOL7JWUhIElPVflTK+oD8pKZ5n4C9ivUw2cpvhwEvREmcyofIKfJe9WxvvQfZ2LNEPN0/QymLqi0KqJE=
Received: from OS7P301CA0023.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:26b::12)
 by TYYPR01MB15678.jpnprd01.prod.outlook.com (2603:1096:405:293::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 13:16:57 +0000
Received: from OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26b:cafe::33) by OS7P301CA0023.outlook.office365.com
 (2603:1096:604:26b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 13:16:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20F.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 13:16:55 +0000
Received: from demon-pc.localdomain (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 8C82E3000374;
	Fri, 21 Aug 2026 22:16:54 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 05/18] net: stmmac: address non-LPI resume failures properly
Date: Fri, 21 Aug 2026 16:15:41 +0300
Message-ID: <20260821131554.638741-6-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20F:EE_|TYYPR01MB15678:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6524a3d6-2233-42bf-322b-08deff867954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|13003099007|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	jLkiLgpZadQlJA6YiFgp/CCEY8kMe5of+gKz06x+c1QoPuv1G8pjB5f2lTCLi9ms2/A43Jcs4DM8Vl2nQy+0mcOFvdWiI+S+pJSVIeZ0Z8kjqDfZD6671AnWCSGH/xW0fvTWprt8ZlkYXeBHMGKwbhxmW4UniEPnKfIGkhgAXVPUk7fIMgeA2laHY8oX3TRvBhy0BX0hHHqz397+982OXkb2uhREHCtbYDlmkTefJzexzoUS1bFwnalIUWA5HEN034QNDySTSIRXpKkaYoFwpFoDuTDSrocHscynW/thrhjL89Gjwi722CHk7gsn1aDcXEH7tqdn6hjdDhuKxTUlKm9YzbJ+36CJ5YR4/vEzBo2cntZqnDNgHIPn/22DV06vrlMkbqYQD1MUlgjNJ11u+KRcNt9u5364uPH17XNAG73lhd5+S7DXTnftIPGziMHuuJvi6++lIeEof+swVPt2CasnttXfExVqcGQb5Pazplf9/jrskGux6bic3HzgJsplt5TbrFT7UDsyK7KytEwYhrL6cA//3ehujXyus0NWtge0L1fLrhiCmP2ZV3oFW0uNhgudtiDgeV4MHN7JD9OIU9IN1fG/vY1yDItPb/hl2GL5AvKJyd7/knf3HWSInq2gbU1+DEEAFpEJLnXEkN4AFw==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(13003099007)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	wAbPjbPiKRk81SQWBapVnQ+S6Hp64iq3CMLoWSTlThJARbf/YbqiNyZjbdhNJWZnnZbZJmYwxgbS74Mkvx4ZUrKMv9+tV3Jvl8cseVGaC9X3ZwFjw4B4Ddx5cWVmPLk9gC3CDde3qZOEKxCYBu4tHTF+CdbV+VwVq7u0rh28UsM6HebNUODuLh0KVdtdbiZMRF8MZQqHPyLVi9Gdz5yZ5IpZCLOl91F4L9wFAMcjSQM4e+EavxzW2HjMvJRXic0JQAQfm37m6jV9NnHeTpvCPAFTaW7B3zL0/UaOkN/f4gwM57x4v6jojdecCeKDjegoHFwtwLQ88usN1Z/SSN5VNlPRM75fr45HwUo92Ruf3V+pseXzUqZi/F6VJzhlGmJKKMGjJOlX0NwoN3j/KNKgZSBdm+eA/ad57nYHdwkd3bD7IwhhK4idlFuuIIjt3RUm
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 13:16:55.8805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6524a3d6-2233-42bf-322b-08deff867954
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15678
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 13:17:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23962

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

commit ef43e5132895ad59b45e38855d32e966bb7434d9 upstream.

The Synopsys Designware GMAC core databook requires all clocks to be
active in order to complete software reset, which we perform during
resume.

However, IEEE 802.3 allows a PHY to stop its clocks when placed in
low-power mode, which happens when the system is suspended and WoL
is not enabled.

As an attempt to work around this, commit 36d18b5664ef ("net: stmmac:
start phylink instance before stmmac_hw_setup()") started phylink
early, but this has the side effect that the mac_link_up() method may
be called before or during the initialisation of GMAC hardware.

We also have the socfpga glue driver directly calling phy_resume()
also as an attempt to work around this.

In a previous commit, phylink_prepare_resume() has been introduced
to give MAC drivers a way to ensure that the PHY is resumed prior to
their initialisation of their MAC hardware. This commit adds the call,
and moves the phylink_resume() call back to where it should be before
the aforementioned commit.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/E1tvO6a-008Vjh-FG@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_main.c
index 8187e6934668..cccf44b47909 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -8044,12 +8044,12 @@ int stmmac_resume(struct device *dev)
 	}
=20
 	rtnl_lock();
-	phylink_resume(priv->phylink);
-	if (device_may_wakeup(priv->device) && !priv->plat->pmt)
-		phylink_speed_up(priv->phylink);
-	rtnl_unlock();
=20
-	rtnl_lock();
+	/* Prepare the PHY to resume, ensuring that its clocks which are
+	 * necessary for the MAC DMA reset to complete are running
+	 */
+	phylink_prepare_resume(priv->phylink);
+
 	mutex_lock(&priv->lock);
=20
 	stmmac_reset_queues_param(priv);
@@ -8074,6 +8074,15 @@ int stmmac_resume(struct device *dev)
 	stmmac_enable_all_dma_irq(priv);
=20
 	mutex_unlock(&priv->lock);
+
+	/* phylink_resume() must be called after the hardware has been
+	 * initialised because it may bring the link up immediately in a
+	 * workqueue thread, which will race with initialisation.
+	 */
+	phylink_resume(priv->phylink);
+	if (device_may_wakeup(priv->device) && !priv->plat->pmt)
+		phylink_speed_up(priv->phylink);
+
 	rtnl_unlock();
=20
 	netif_device_attach(ndev);
--=20
2.55.0


