Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93466CCFA1A
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:44 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10032.1762416699966621552
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hYYxKGJd;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47754547a38so5043535e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416698; x=1763021498; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcO6bxC5sutfLiJ12bSbwxhOLw6VToCiNt9uC70tff4=;
        b=hYYxKGJd4tV/lVBDFCtc9u+U3D5V73bwTv4G34BkidinkUD45bleUi7x216s5l5B9O
         PTpMp2FSqLEap62xcuxBq38Zi1Q5Og2LuBBjnn+2wfkoK/PILh1KrJX+aUNX130LWXpw
         d51AFs9HkKsHFc6nV2y5072vH9NDYQgtb6eP73KrKA0ZJHK9A+Eu741xr+Y/aQrn/odz
         wy/6mGmKJWcqwRi3z6RhWVbDbKX40vueA5+4ZBtEG2pqHCk5TV51ni8TbbSabhHWGky9
         w8lPXDGMEprNoO9w+GD/KGFrX6qg4vZnWmujBmIev3y+KCv8SSxOZfD8gV40t/6awWQ0
         AQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416698; x=1763021498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcO6bxC5sutfLiJ12bSbwxhOLw6VToCiNt9uC70tff4=;
        b=G5P+eQpXLy5ML6efmp5qDUkFVES4LKcxcNN4OPnUZlhVLujBw/iAINIIA8runiC9oV
         SBJVXgTEKWHpU4bBUmSaHwCT6MNMQNlyIccz7O0L6toGtH0jP0OBcLne993l26FaAdaZ
         q5Z10aQJOP4HQwgYf5K7bqXMMmE+w+Y3D72JqYOte1rl+Zaej+OeRWfp2os3ijY5qhKm
         doEry55BP0IHLm5/I0YXDwcbgj8fDBgjPb3/bSwbuT2diWRVIFfjOLNdXnUKPkOLGRb2
         5adEzy2iON98s/LEnSR0xW677pMI+eBaysP6y2ZuVlENqvuxXZeOc8UrWQymayNJp/KP
         TYow==
X-Forwarded-Encrypted: i=1; AJvYcCVPj2oY3mBC+C+zuZF9Vpfy0rebu4KKWtQeSa7iZBEYa92PGTtJyqoNjmNCbOSi5Qz1G02JGBIa@lists.cip-project.org
X-Gm-Message-State: AOJu0YwW1aYddyqLmIkklx9dTLt0BADIbJxq3fkq8l5wrQkhZFMSmYZw
	SMcBz4PKk/W9t/mwdA5hRjb7DotFASUeRUJY1CzgLp+hCZkP2t18PxcK4u8FwnoMJkQ=
X-Gm-Gg: ASbGnctBFTtU4K9eBQH1obevAEw6z2bY+LuPMoYJKeLh7TkQ/rwoV9sn98nkWAVtYz9
	GPb+Q8KR3v9VzNKGIhAsSgCUoUKFVGeOLl5ZBP2MfOq9EtqfAYXMdi4ntgVyNYqCqjq125WuvDC
	r15NSgcSIK4uCtRQzLz0KZqYbZSZ0xJQmSlfZqwit3xp3Yu8AmDJ28YYpoYtBVIF/oNgUDcXfXi
	di5PUPykP/f/V+m3zhC3zhrej4Eq2j2H1qUvd16PiHQwtzt4XlKOba4AxMuh34pil10pzJdqWA4
	QFze0Ux+UsrqjFw0N1lS6shrSLO6ikNmlkbe2BWqBVYi/LF7udneeEBIdwkRJyAP+SVbVjWbeJf
	49j5r4LqrPyYigA4fxWHxZrnXZ8x6ZAn17TlDYnJpVzwyljS6l/Wd6soXPeT7R6KABoBwzf4oxj
	Rzd9ZwJKaXu9KBjZ75jJrabQiUJBv//g==
X-Google-Smtp-Source: AGHT+IESVf7sKz1tE4GXsgKNO5+UWZfLJD7JqgV0f5/tj9nUZkUeBsdfWpCHurG01I/rgqLioZr9NQ==
X-Received: by 2002:a05:600c:5488:b0:477:4483:f491 with SMTP id 5b1f17b1804b1-4775cdc53e0mr49505975e9.10.1762416698266;
        Thu, 06 Nov 2025 00:11:38 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:36 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 02/23] of: Add of_machine_compatible_match()
Date: Thu,  6 Nov 2025 10:11:11 +0200
Message-ID: <20251106081132.2574638-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20395

From: Michael Ellerman <mpe@ellerman.id.au>

commit c029b22f8a98e14988f800d5c0176a9eaec3c8db upstream.

We have of_machine_is_compatible() to check if a machine is compatible
with a single compatible string. However some code is able to support
multiple compatible boards, and so wants to check for one of many
compatible strings.

So add of_machine_compatible_match() which takes a NULL terminated
array of compatible strings to check against the root node's
compatible property.

Compared to an open coded match this is slightly more self
documenting, and also avoids the caller needing to juggle the root
node either directly or via of_find_node_by_path().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231214103152.12269-1-mpe@ellerman.id.au
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/of/base.c  | 21 +++++++++++++++++++++
 include/linux/of.h |  6 ++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 788706579419..f61e2c1f7777 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -580,6 +580,27 @@ int of_device_compatible_match(const struct device_node *device,
 }
 EXPORT_SYMBOL_GPL(of_device_compatible_match);
 
+/**
+ * of_machine_compatible_match - Test root of device tree against a compatible array
+ * @compats: NULL terminated array of compatible strings to look for in root node's compatible property.
+ *
+ * Returns true if the root node has any of the given compatible values in its
+ * compatible property.
+ */
+bool of_machine_compatible_match(const char *const *compats)
+{
+	struct device_node *root;
+	int rc = 0;
+
+	root = of_find_node_by_path("/");
+	if (root) {
+		rc = of_device_compatible_match(root, compats);
+		of_node_put(root);
+	}
+
+	return rc != 0;
+}
+
 /**
  * of_machine_is_compatible - Test root of device tree for a given compatible value
  * @compat: compatible string to look for in root node's compatible property.
diff --git a/include/linux/of.h b/include/linux/of.h
index 44e432dbf67f..30d641eab476 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -394,6 +394,7 @@ extern int of_alias_get_id(struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
 
 extern int of_machine_is_compatible(const char *compat);
+bool of_machine_compatible_match(const char *const *compats);
 
 extern int of_add_property(struct device_node *np, struct property *prop);
 extern int of_remove_property(struct device_node *np, struct property *prop);
@@ -787,6 +788,11 @@ static inline int of_remove_property(struct device_node *np, struct property *pr
 	return 0;
 }
 
+static inline bool of_machine_compatible_match(const char *const *compats)
+{
+	return false;
+}
+
 static inline bool of_console_check(const struct device_node *dn, const char *name, int index)
 {
 	return false;
-- 
2.43.0


