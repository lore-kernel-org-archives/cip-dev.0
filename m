Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0DFC25B7E
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:14:47 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.8666.1716970482219965953
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:14:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=DX3yIjm2;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42108739ed8so21276645e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970480; x=1717575280; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHh2pleIRZ1rKE1GWIGdwl0+YNzoXTQUs9P6cBWt538=;
        b=DX3yIjm2uiXd/GQPrqT3S6Q7L/qCiLl1rG7UeGaGhPiduxPTHZHWvU4ZgB8FsuCJge
         iLyeRbn4Ng4RlRWkWaP1ZZbT7ILfLK5cxwMst6MuJ1T38Wyj05gY8bInkdGBKHZohgLn
         ns8UwA0j3x/4TX5DAQ4vffhdwJ9avlCzoafFgNQJqNx6JEoz8U3r7h8jz9SB1kQGxJcg
         2Bo4fIMkCpSUuScArN5/khzLf2E9QxtThy1g6W1JHjThU1SPg1IUITlEjkbqpNJXSu7H
         seoUzc3LmLm0/SL/90nMDQVqEg3nTCPKmW2GR0Xor3hYyL2N0T1ni6rBLvnoOk8a4G6q
         LcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970480; x=1717575280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHh2pleIRZ1rKE1GWIGdwl0+YNzoXTQUs9P6cBWt538=;
        b=ksveguegjhCldL1z287Iz2jzHxWV599GIIB1NC6uauHd8Ct7hSz5Gl98lTVaGOhyqd
         tXAslfoQgTdSzM3RUoHcf1w9GzX9BTgztPB2IAoYsm6lPXF+MJLaTkd+Srkyh7soXdeI
         Sb61m0/ghXd5Wvmod19HMxwbOEos8NzCUHmNDal5vA1OrDxeihVQkPIGpQSjTDSoc7F9
         jKOQsn2jLunHQwdVWWbbf4so8B4caEPoMHshZLdV4HWZJeDqFBjcd8yuPFN2XSayxIwD
         hwE4RrE+14oSZE7LPOltd7oOM9JL+5Ss0TYQjCQVrUTpLqUPchA6s7WhszK2rba1nY8y
         gp8w==
X-Gm-Message-State: AOJu0YyFo1LSdyVZuYRoUdA9B9b47tE9PbOjCDqbqW3KsgOeMgrI2zaH
	hVCYQkuGF9zRA26h386rcacPQ77+Fh+vCseGqF9HbVF35SO0RXXAiQvcx9PiPMs=
X-Google-Smtp-Source: AGHT+IF4WZDm8GHz6qUJpgtYZ1E1yEXY4lN2JHZ0M2mOwrO1uScfUvJ6PyFjatmQEGVxm8Dq/aEogQ==
X-Received: by 2002:a05:600c:3152:b0:421:757:4d3e with SMTP id 5b1f17b1804b1-42108a40f7emr167031025e9.16.1716970480598;
        Wed, 29 May 2024 01:14:40 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:14:40 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 03/33] pinctrl: renesas: rzg2l: Add pin configuration support for pinmux groups
Date: Wed, 29 May 2024 11:14:04 +0300
Message-Id: <20240529081434.639519-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:14:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16031

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
index abc4dd44b950..e38a1ddcfc0c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -375,8 +375,11 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
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
@@ -461,6 +464,16 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
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


