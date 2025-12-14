Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDD5D5B170
	for <webhook@archiver.kernel.org>; Sun, 14 Dec 2025 22:58:40 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24214.1765713991185379297
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Dec 2025 04:06:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UWnutCLD;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42e2d02a3c9so1634315f8f.3
        for <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 04:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765713989; x=1766318789; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pB022C85GNE7jmf8GwmplUMe86qfwYiVKacjU4G9uTY=;
        b=UWnutCLD1sEpDFqjK9o50HneIAMQU4XFRDc4pvETcfWU5BowYp9J4t7WRWZFpuNjhl
         B/8xC2oUW6tJnnN8I3JKFpW1RHmYvySUQEz1p6VS4PZgOcEadacPVhTzqYHSsglIzUax
         uXRpiUZKlGGuiwNRVsYoddCPsBtkPraQPW7gAXDL9tA0j1xX4LcYd5+141QWyeJAkuce
         BPu+t/uPhJGJ2rCz2QUJ17j/KoXfy6izIrsLzfaqHi2KVqNH7ia1o8Tme41al7wDkw6M
         QzkiTtWgqoWSpYZX9AdOlm7O7igAWZ/o7QxMXdWaDgZORb5VlYmhyFdgHLvOVGVX565B
         RQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765713989; x=1766318789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pB022C85GNE7jmf8GwmplUMe86qfwYiVKacjU4G9uTY=;
        b=uK8f691runDXW9if0fxHgm6ETVfCoovf4ob1EmxLWx/n0/AU6MaAFqa0Hu2j4hEFUf
         ojfLpn/9EYWBMTI2Nfp+WbbWXwsx2iISVOl8r88CybXQ69q4s1yYBfYhEWECVSBXw77O
         inCOk1nw//sKIwmXYHBFUNNmrHkC2436L9IwO/xbIa9SxTmQKjrcIjxQMA0/5o50tkMV
         T4N9T7J+ZNRRzqOVjVQf5nYXpT8RrrS5yPWQNktLcjsEq5+xKgqUeqmtJ0XPtc+IiE32
         YgIzeDQkGQMgwCaPnCW/FdRjsL1+HA9tGfIdwZljWIuSTyRnxVoRQuXaezHH5ZtITrNn
         rBJw==
X-Gm-Message-State: AOJu0Yzgmpgxk1N1L7ww5YF+3i1L/cJxeDzMRqUBRFBAY66RfrzubWCs
	CnNEG7KMzMkN6T/G/3yN+a+631LsFPulyE47ZX6i5D4KsUj3e5Yt4vZxy5Pi9Q==
X-Gm-Gg: AY/fxX7/54bv848BR1l/kWbDrBPX1vgSzQL4HskdF1XEGBjF+TVNWJOEmZp5nlXhCYv
	aj+o6sijD5Sd8xPtGxCYuzCHBUhWogFGb3U1FmV2yKQR+KGuNUNXkSxFCav476yrY0OX/eCiwqw
	oaXXuERubqxqeGw342xXxXHjDN0UqzHLDj7Cks6nyByBfYJBQOSO0YSkOYsPrvn7if77t8x9ef5
	G0bgN14Uzpn5fOzJ6HyQOdzEoocC64Y3bkRT9zF4eYhzLeS6qVCyS3XxfFnJT8pmnC/rIL8bXsz
	Km9QZLNFw8OZw6qMuCBSa6118gAHSydX768Hjs4PVsqJS7rni6OPBE0XbHuipKE2xenSu5Ws0gf
	Q6GvFHFDgxxKiCDPk+0GQb+K34dXBqtw/h9R2nBcklf00ZC9yeg41EYfqtVkEEPEOkv2ofRDU1f
	gVMyylhbZQE6XKp+7XCs8N5fpvDnguOQUJb5SJnfe08OuRiXBwIvHzLkc+1dt3LDJLOTxTt9o=
X-Google-Smtp-Source: AGHT+IG9Rre7PKSVrNwrOhwYNkqiYET/vVvM741YuALVJ2WWSnyDyQpvN3crWL/z+4eLDo5iQNfr4Q==
X-Received: by 2002:a05:6000:2c0d:b0:42b:323b:f138 with SMTP id ffacd0b85a97d-42fb48ff842mr8466646f8f.41.1765713684023;
        Sun, 14 Dec 2025 04:01:24 -0800 (PST)
Received: from biju.lan (host81-152-191-146.range81-152.btcentralplus.com. [81.152.191.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fb68866f3sm14523386f8f.36.2025.12.14.04.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 04:01:23 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 1/3] net: phy: micrel: Add PHY Auto/MDI/MDI-X set driver for KSZ9131
Date: Sun, 14 Dec 2025 12:01:17 +0000
Message-ID: <20251214120122.3784-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251214120122.3784-1-biju.das.jz@bp.renesas.com>
References: <20251214120122.3784-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 22:58:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21014

From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>

[ Upstream commit b64e6a8794d9d56f9713b6ceb9e3fdfc9c5f99af ]

Add support for MDI-X status and configuration for KSZ9131 chips

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Biju:
 squashed the commit 84383b5ef4cd21b4a67d ("net: phy: micrel: Fix
the KSZ9131 MDI-X status issue")]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/phy/micrel.c | 81 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index b8d1c0d207c4..63392514c894 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1256,6 +1256,8 @@ static int ksz9131_config_init(struct phy_device *phydev)
 	const struct device *dev_walker;
 	int ret;
 
+	phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
+
 	dev_walker = &phydev->mdio.dev;
 	do {
 		of_node = dev_walker->of_node;
@@ -1302,6 +1304,83 @@ static int ksz9131_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+#define MII_KSZ9131_AUTO_MDIX		0x1C
+#define MII_KSZ9131_AUTO_MDI_SET	BIT(7)
+#define MII_KSZ9131_AUTO_MDIX_SWAP_OFF	BIT(6)
+#define MII_KSZ9131_DIG_AXAN_STS	0x14
+#define MII_KSZ9131_DIG_AXAN_STS_LINK_DET	BIT(14)
+#define MII_KSZ9131_DIG_AXAN_STS_A_SELECT	BIT(12)
+
+static int ksz9131_mdix_update(struct phy_device *phydev)
+{
+	int ret;
+
+	if (phydev->mdix_ctrl != ETH_TP_MDI_AUTO) {
+		phydev->mdix = phydev->mdix_ctrl;
+	} else {
+		ret = phy_read(phydev, MII_KSZ9131_DIG_AXAN_STS);
+		if (ret < 0)
+			return ret;
+
+		if (ret & MII_KSZ9131_DIG_AXAN_STS_LINK_DET) {
+			if (ret & MII_KSZ9131_DIG_AXAN_STS_A_SELECT)
+				phydev->mdix = ETH_TP_MDI;
+			else
+				phydev->mdix = ETH_TP_MDI_X;
+		} else {
+			phydev->mdix = ETH_TP_MDI_INVALID;
+		}
+	}
+
+	return 0;
+}
+
+static int ksz9131_config_mdix(struct phy_device *phydev, u8 ctrl)
+{
+	u16 val;
+
+	switch (ctrl) {
+	case ETH_TP_MDI:
+		val = MII_KSZ9131_AUTO_MDIX_SWAP_OFF |
+		      MII_KSZ9131_AUTO_MDI_SET;
+		break;
+	case ETH_TP_MDI_X:
+		val = MII_KSZ9131_AUTO_MDIX_SWAP_OFF;
+		break;
+	case ETH_TP_MDI_AUTO:
+		val = 0;
+		break;
+	default:
+		return 0;
+	}
+
+	return phy_modify(phydev, MII_KSZ9131_AUTO_MDIX,
+			  MII_KSZ9131_AUTO_MDIX_SWAP_OFF |
+			  MII_KSZ9131_AUTO_MDI_SET, val);
+}
+
+static int ksz9131_read_status(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = ksz9131_mdix_update(phydev);
+	if (ret < 0)
+		return ret;
+
+	return genphy_read_status(phydev);
+}
+
+static int ksz9131_config_aneg(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = ksz9131_config_mdix(phydev, phydev->mdix_ctrl);
+	if (ret)
+		return ret;
+
+	return genphy_config_aneg(phydev);
+}
+
 #define KSZ8873MLL_GLOBAL_CONTROL_4	0x06
 #define KSZ8873MLL_GLOBAL_CONTROL_4_DUPLEX	BIT(6)
 #define KSZ8873MLL_GLOBAL_CONTROL_4_SPEED	BIT(4)
@@ -3336,6 +3415,8 @@ static struct phy_driver ksphy_driver[] = {
 	.soft_reset	= genphy_soft_reset,
 	.config_init	= ksz9131_config_init,
 	.config_intr	= kszphy_config_intr,
+	.config_aneg	= ksz9131_config_aneg,
+	.read_status	= ksz9131_read_status,
 	.handle_interrupt = kszphy_handle_interrupt,
 	.get_sset_count = kszphy_get_sset_count,
 	.get_strings	= kszphy_get_strings,
-- 
2.43.0


