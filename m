Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3512C41513
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:05 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.8568.1716970260238349468
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=qVAjRk6J;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4211e42e362so15721635e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970259; x=1717575059; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnYK0FlMFdlJH+oB0H6OKLH8zMQrUGogAWbkopNk9zI=;
        b=qVAjRk6JtM+JzIKwt0XpTGrmQ2W+y59eybEVoSSkRzU3mu5LoJhmERl0UYSmlpWmR4
         Pj2kKgyc1Z9RJwTKr4X457Ohz94N6W0ac3xuSIcox6dsJivJCsgQUsxbHORbgN4lC1x8
         SH/3/rJvr2uA7vNItwHu9hI6XWuiPySbOOYtMVPCfBMw62ceaHL3lcoqW823nDQ+PQZh
         2/rrtL+6XVUTVf8vWj5L8mfg3R7JsTL70qwvpUUTtcfaqMtms14RyvBPEJ5VjFqQywqi
         e20a3fJy3IZanw/0dxzKh/PumVenUtaBtGne/4mietrIKX1gCqEzFk8Xa2CVvuVevxqD
         mnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970259; x=1717575059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnYK0FlMFdlJH+oB0H6OKLH8zMQrUGogAWbkopNk9zI=;
        b=vhIQn8lIbG71Iytu5rzp3dJ7Zz3lZsNcMem1rO5xCP64/PhVfaJisY1IpR17nS5HXY
         +BjH8tEgWLuLcHBDbSDbFgpdGjwMIzNJOfHEc2baENLQPxxqwvg4X2zj+WKtAttg5QKS
         dFc/M1WlKghWcsjDuNtaGhr349uv5M83cnPAHuoEtvr9hkY3IeR65HTqKuoVARANxw0c
         OZgNltqBULPrPCqafxU8hy4vnZjhIC6pGKOuSBuErdNaaS5yM8UQKHz9RT3LOh0KwFsR
         ObQWuC9hLqGwVLVmUEVUxW+NB8fYRrCIL4fRSYjW7s19UJgX/9QhEnq+CE7b2R+Yo/vv
         Nhpg==
X-Gm-Message-State: AOJu0YzU7gtCaCjeJQwdchjwfB0wK+eRB/U11TEPO8kooBeZKg9KE5Mc
	GE2PmQ8LBvzPTh6sD0NrdNGYCHqWl+ZY3Fe+kuzj64ou5DGrMbsK0UG0XRkNcX4=
X-Google-Smtp-Source: AGHT+IFqrrqrRkNBsCkMBzo40fxtOf9xmiBvPKn6nEI3XO6lCX01YD5UYeLnMAqtOb8jAvRJ57ELZA==
X-Received: by 2002:a05:600c:314d:b0:421:7ad:daab with SMTP id 5b1f17b1804b1-42108a4f606mr105500695e9.7.1716970258746;
        Wed, 29 May 2024 01:10:58 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:10:58 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 11/47] net: ravb: Make write access to CXR35 first before accessing other EMAC registers
Date: Wed, 29 May 2024 11:10:03 +0300
Message-Id: <20240529081039.639010-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15991

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit d78c0ced60d5e2f8b5a4a0468a5c400b24aeadf2 upstream.

Hardware manual of RZ/G3S (and RZ/G2L) specifies the following on the
description of CXR35 register (chapter "PHY interface select register
(CXR35)"): "After release reset, make write-access to this register before
making write-access to other registers (except MDIOMOD). Even if not need
to change the value of this register, make write-access to this register
at least one time. Because RGMII/MII MODE is recognized by accessing this
register".

The setup procedure for EMAC module (chapter "Setup procedure" of RZ/G3S,
RZ/G2L manuals) specifies the E-MAC.CXR35 register is the first EMAC
register that is to be configured.

Note [A] from chapter "PHY interface select register (CXR35)" specifies
the following:
[A] The case which CXR35 SEL_XMII is used for the selection of RGMII/MII
in APB Clock 100 MHz.
(1) To use RGMII interface, Set ‘H’03E8_0000’ to this register.
(2) To use MII interface, Set ‘H’03E8_0002’ to this register.

Take into account these indication.

Fixes: 1089877ada8d ("ravb: Add RZ/G2L MII interface support")
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index ef7ab9a3ff29..420d6926d33d 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -514,6 +514,15 @@ static void ravb_emac_init_gbeth(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 
+	if (priv->phy_interface == PHY_INTERFACE_MODE_MII) {
+		ravb_write(ndev, (1000 << 16) | CXR35_SEL_XMII_MII, CXR35);
+		ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 | CXR31_SEL_LINK1, 0);
+	} else {
+		ravb_write(ndev, (1000 << 16) | CXR35_SEL_XMII_RGMII, CXR35);
+		ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 | CXR31_SEL_LINK1,
+			    CXR31_SEL_LINK0);
+	}
+
 	/* Receive frame limit set register */
 	ravb_write(ndev, GBETH_RX_BUFF_MAX + ETH_FCS_LEN, RFLR);
 
@@ -536,14 +545,6 @@ static void ravb_emac_init_gbeth(struct net_device *ndev)
 
 	/* E-MAC interrupt enable register */
 	ravb_write(ndev, ECSIPR_ICDIP, ECSIPR);
-
-	if (priv->phy_interface == PHY_INTERFACE_MODE_MII) {
-		ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 | CXR31_SEL_LINK1, 0);
-		ravb_write(ndev, (1000 << 16) | CXR35_SEL_XMII_MII, CXR35);
-	} else {
-		ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 | CXR31_SEL_LINK1,
-			    CXR31_SEL_LINK0);
-	}
 }
 
 static void ravb_emac_init_rcar(struct net_device *ndev)
-- 
2.39.2


