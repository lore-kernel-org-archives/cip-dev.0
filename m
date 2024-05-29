Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D95C27C50
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:10:56 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.8631.1716970247802302655
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:10:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KWOlPtie;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4202c1d19d5so15374545e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970246; x=1717575046; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fjlegfyKRb6QQ90xhXZQTCayajy/7wzIQ9zeZ0At2c=;
        b=KWOlPtie1M/CIFkOemEGFqkxWou4JVKhIBf3lUllMy9JQHp7E5EL7P4Tp/hicsnljl
         0Le4sxtOqkHS2Qs9wY5UmbMuXoJL3gbULFArm+gqeOrSFqu6QHLelg4Iqo/HG/EODFYE
         eKadqOFgVBMABNpuc3jL9+pJ44QOvtnMGCGXi5ORtPkdotYc+ezUUQCxTE5oe9kAO9Pf
         MAgI9J1JtmoXpoDh8I2ZNr+rC4Zh20crfmTPWvyr4+InLZU03tFT9AMi5bctWN//RL90
         fJXsBzjR1yC8RHCnCz09fynQUGFBR/Fog2vIRYx6jF5T71zoAwKbUbX34YLnSOTTzZnW
         ChZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970246; x=1717575046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fjlegfyKRb6QQ90xhXZQTCayajy/7wzIQ9zeZ0At2c=;
        b=CJ7gd2oXBOJO0DQOI2JcEdvy+HS3+MngXK7RydrWpZKOK4wTyszAdhd0KXxFboa21u
         qw6IzXhtTkycJWXNvigzPBWRGV1c7nbJYwn/8WwcYErKwLNseGTkqQLyNvRJ9wWxtHy1
         bzaBMhwq5pZ210jLQCadVV9kOa47P/XJ436UE6WH+0FbegnYYHWp+xGvH9SCh5LKi0VP
         uXzlWBRxzXP9fw6zT+QtVZQrK103/AVNWKeoSbr4MoCpdZpAYaR8WooUO2vpjbu4elY3
         cKKdIYqlwPJY+Q4LGJjM9nBDQea76myq4b5+HULJHVNxYDiUcH5uGypSAZoEiWJOtCqt
         0nHQ==
X-Gm-Message-State: AOJu0YxnxcemtML95qNoPsxmajGuXM9nWOFLIBN/1DPkvnKoxRS9jQ62
	vWY8Zwcg3FkqTe2zf7GA+GLosAVhGwUgAnMtJl99dAdcz230MoXOIltjcufOWuc=
X-Google-Smtp-Source: AGHT+IFZgAhkkWmFkPkS3E71unhspzTp4bd3Z1k+m1/Y4MEGRveIxgbXEyb9QEZPBEkxRe2enS1QYQ==
X-Received: by 2002:a05:600c:4f94:b0:41b:fea6:6526 with SMTP id 5b1f17b1804b1-421089f8d2cmr95682425e9.33.1716970246156;
        Wed, 29 May 2024 01:10:46 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:10:45 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 03/47] pinctrl: renesas: rzg2l: Add pin configuration support for pinmux groups
Date: Wed, 29 May 2024 11:09:55 +0300
Message-Id: <20240529081039.639010-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:10:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15983

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit d3aaa7203a17e8399df41e7c3f088f51368b001c upstream.

On RZ/G3S different Ethernet pins need to be configured with different
settings (e.g. power-source needs to be set, RGMII TXC and TX_CTL pins
need output-enable).  Adjust the driver to allow specifying pin
configuration for pinmux groups.  With this, DT settings like the
following are taken into account by the driver:

    eth0_pins: eth0 {
	    tx_ctl {
		    pinmux = <RZG2L_PORT_PINMUX(1, 1, 1)>;  /* ET0_TX_CTL */
		    power-source = <1800>;
		    output-enable;
		    drive-strength-microamp = <5200>;
	    };
    };

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231207070700.4156557-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 480d4bba2704..329edc31ed00 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -372,8 +372,11 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		goto done;
 	}
 
-	if (num_pinmux)
+	if (num_pinmux) {
 		nmaps += 1;
+		if (num_configs)
+			nmaps += 1;
+	}
 
 	if (num_pins)
 		nmaps += num_pins;
@@ -458,6 +461,16 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	maps[idx].data.mux.function = name;
 	idx++;
 
+	if (num_configs) {
+		ret = rzg2l_map_add_config(&maps[idx], name,
+					   PIN_MAP_TYPE_CONFIGS_GROUP,
+					   configs, num_configs);
+		if (ret < 0)
+			goto remove_group;
+
+		idx++;
+	}
+
 	dev_dbg(pctrl->dev, "Parsed %pOF with %d pins\n", np, num_pinmux);
 	ret = 0;
 	goto done;
-- 
2.39.2


