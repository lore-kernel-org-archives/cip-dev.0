Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB5DC3DA40
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:10:55 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.8634.1716970253661455566
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:10:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=TPt0flS3;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4202cea9a2fso14144095e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970252; x=1717575052; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yfM9PqjJzcRP3D5IlsUWqrorPDN5bZe/Rv5u+w2hyc=;
        b=TPt0flS3QUDXQOmyxahN5VOknduFTp7bL6Ra1tZAxvIn7NnyZxWJ5L0k+z+i8Nue3f
         CuUy+QrXD9bXK5zF/BBGzgbLZeCJZ37KvPez4OxJijhGMA71pbZ3MTrjIrL5EBNP95lV
         xG0hG2rzE1Yw6lwFih3zWlSXdbkGSC+OTE8YbaJZO5IOttvrMS+k2evvEL2/QOmBnGmM
         Ee2G8j/tFSpixC8/dUAH4bMl4XfHFN7oGUu8db6fs7bIoG8rUzG2Lu1P5nXraGrx7B0G
         eF0bnrGq4ZFZEP0H48Japtia6hQnZF8Zg6OYSz/vN5u2EXgLia7GK597TfjEXM4vzszA
         2/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970252; x=1717575052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yfM9PqjJzcRP3D5IlsUWqrorPDN5bZe/Rv5u+w2hyc=;
        b=Kn4+bqGbK/dxsz1Y0WHjg8dEuqJUtRXUTHD1sYNJ3AWPedCYPfnP9fpYZyXY4aLvA8
         Wqz0sCtR9fYbCx4oAE7/1CJ1L1fG+tq/cdanDYnA/WP5ss86mQa4F0GlndUh29k5cPkv
         5vlvAU4Dubx3gs+td5zZ79YKtMmMWZvo39bxpW26AzMozGYbl35c6u7bTT6Pk5IuUL2m
         jyoD4QHO2Ql6hqKnVRyIUUM28grce2IRZEzVwtC3iisVlcGRf4BCI58YYwL3sCEhzCwa
         BTqt3uKC6HRrJd8qXfHKeLczpiGn4YoqflnY0IZ1P3JNtx8LWVhQfZwf9kN4ZqgkrjyP
         UI/w==
X-Gm-Message-State: AOJu0YxhG5y4i2yzMYJNR9VOs8XJTPr4mdLCrGBSjk2iVoBgF15uAyST
	37mmalmusCRJtRH6nrB7HAMC3BzaAD7m7JxkNP2n8UzPx/LAYptbH8TvO2+Isy8=
X-Google-Smtp-Source: AGHT+IGxOH7jN0JJSAHcNUw+y1THhmoPFLB5dQIwVgf5sjLH/v7h2IvhxQrCENrZqfl9Y3CEpFN/jA==
X-Received: by 2002:a1c:4b0b:0:b0:418:5ed2:5aa6 with SMTP id 5b1f17b1804b1-42108a1fa4dmr131588055e9.31.1716970252152;
        Wed, 29 May 2024 01:10:52 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:10:51 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 07/47] pinctrl: renesas: rzg2l: Fix locking in rzg2l_dt_subnode_to_map()
Date: Wed, 29 May 2024 11:09:59 +0300
Message-Id: <20240529081039.639010-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:10:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15987

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
index bd54ab706654..32ca9da27d11 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -443,6 +443,16 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
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
@@ -470,16 +480,6 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
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


