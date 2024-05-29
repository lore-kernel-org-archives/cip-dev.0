Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532AAC27C44
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:14:57 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.8672.1716970490505219304
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:14:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=b+hL4XHr;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-420180b5898so14217415e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970489; x=1717575289; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pa95+gA2J+pRQDBnGdJr3HYDcAsN/oEWKjQ0fMZXC70=;
        b=b+hL4XHrE07r6PLsTd3mcj4uhDLXzczAU8t2TDPOYNUGcjlCN+bx+b+hbkAxjf9FWY
         TzKdUtmloHtRxEYysOWJR20DeGHGkqW99JuUc8w5jHdgOWlhwJ06SvguABM9M0Iz8p+n
         Z9sYK5h3SA2uljWahSp+uxTXA/8smuqf2sxKJARE8gMu8zDItlbl5NIJ8kVHN99ii1wR
         Z2RyvwPKXFmzMEH6pH4E7NQaV43yDdnt/D5Knhpg5/H67ft+BhYiZOd1kAEb7xm8CgQ6
         PAlAgwFhwdHJRvAXIrt8LM7/CR8+BtLg3PD+k+sXXI3aYVKlWaVfKpKRLCODiHdlMYnp
         JRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970489; x=1717575289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pa95+gA2J+pRQDBnGdJr3HYDcAsN/oEWKjQ0fMZXC70=;
        b=KMMzF434tgQPtIILiMir3FXEpbNOuuqiArTUqgDzjxd+C1PB6P3lmHeZCo70lHpRmZ
         JLKPWQcxZh1U4CIjIr9SRmjPmPqYZIuRhXKHX8mGuJ8ifCbM3GVUdENniUrdCIOC0UZe
         D+X0xjJYj3FwRIYK9IAwjpsrvfjzC3aq4zN+29QVpcAkqYjfM64PIJgJSmTByQAP4S3H
         9i1y/FkGrRQ1UI5MmjvVeHVuHTWptk0NZxO2PouYQVlc2c7jeGL2KMxEdN9lFbA6GGjs
         mwt3B/0700nm/UD5vHylL5UO2H4hZ+7a75waExk0mga5o8vx9oztPEACDWM11XYLPnuA
         wz3g==
X-Gm-Message-State: AOJu0YzdrRqMJjTTiJB5+zxIJqPv2PsR5JCyGzDnNI+ekdrF4ijHOdRa
	IpUksfqNdlhsx5EcVCWyxAxTpz9c6b9+HFlNakr6SkyIkif3OnLtilho4g8HIhE=
X-Google-Smtp-Source: AGHT+IHHn1isi5bwxZ45jHP9d8aD51WDcwu1ANu1phKN/brkB/6VA7R9LHeFfdH3vkbwr5EzkrV3Iw==
X-Received: by 2002:a7b:ce14:0:b0:41a:b56c:2929 with SMTP id 5b1f17b1804b1-42108a0dbcdmr114742945e9.34.1716970488925;
        Wed, 29 May 2024 01:14:48 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:14:48 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 07/33] pinctrl: renesas: rzg2l: Fix locking in rzg2l_dt_subnode_to_map()
Date: Wed, 29 May 2024 11:14:08 +0300
Message-Id: <20240529081434.639519-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:14:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16035

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit bd433c25ca81b2ac6dca7ea288a8474eea4fb8a0 upstream.

Commit d3aaa7203a17 ("pinctrl: renesas: rzg2l: Add pin configuration
support for pinmux groups") introduced the possibility to parse pin
configuration for pinmux groups. It did that by calling
rzg2l_map_add_config() at the end of rzg2l_dt_subnode_to_map() and
jumping to the remove_group label in case rzg2l_map_add_config() failed.
But if that happens, the mutex will already be unlocked, thus this it will
lead to double mutex unlock operation. To fix this move the
rzg2l_map_add_config() call just after all the name argument is ready and
before the mutex is locked. There is no harm in doing this, as this only
parses the data from device tree that will be further processed by
pinctrl core code.

Fixes: d3aaa7203a17 ("pinctrl: renesas: rzg2l: Add pin configuration support for pinmux groups")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/f8c3a3a0-7c48-4e40-8af0-ed4e9d9b049f@moroto.mountain
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240115153453.99226-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 0277ebf3bcb6..c0d5bdd3a9c9 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -446,6 +446,16 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		name = np->name;
 	}
 
+	if (num_configs) {
+		ret = rzg2l_map_add_config(&maps[idx], name,
+					   PIN_MAP_TYPE_CONFIGS_GROUP,
+					   configs, num_configs);
+		if (ret < 0)
+			goto done;
+
+		idx++;
+	}
+
 	mutex_lock(&pctrl->mutex);
 
 	/* Register a single pin group listing all the pins we read from DT */
@@ -473,16 +483,6 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	maps[idx].data.mux.function = name;
 	idx++;
 
-	if (num_configs) {
-		ret = rzg2l_map_add_config(&maps[idx], name,
-					   PIN_MAP_TYPE_CONFIGS_GROUP,
-					   configs, num_configs);
-		if (ret < 0)
-			goto remove_group;
-
-		idx++;
-	}
-
 	dev_dbg(pctrl->dev, "Parsed %pOF with %d pins\n", np, num_pinmux);
 	ret = 0;
 	goto done;
-- 
2.39.2


