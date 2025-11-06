Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB8CCCFA03
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:35 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10059.1762416744993080344
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=qSthkVBa;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4710683a644so4348855e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416743; x=1763021543; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCB6ErHg3HBJCpKTkqNetM5X8qwre32JJAbUTZr6jzA=;
        b=qSthkVBaf2bmJrhrEIYL3FxbFcLGuVrjZovEcU0UDwiktJVR1tFWRlvh0htymROVKs
         a5CFv6Xn64n4VZvj9LniZW9+Jx0Sf9wk1o/AmnI7PRBBOKd5zKrRCDiIO+GA/Vz1G5Qa
         fbyZrvSnAr1eW7e1vigy5AKPn19aB3c8dC8uKAXj/GWertx3hZqqibTKjOeG8xzH+aeT
         dmGT1jiAnEdaf0grEVG8Lkadxo8knaTKK2sdokRKtfVxj9OHxo7GqfJIKJRru+9TFWzJ
         DOV4kD5/C4ponAnKdrLF6hKZe41nHzzSRYBaIQdSPdzVveCjfVxiv96biGu4HBWuwd84
         3YVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416743; x=1763021543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCB6ErHg3HBJCpKTkqNetM5X8qwre32JJAbUTZr6jzA=;
        b=C9UW607NBHaMkAo4aD6GATkmmLB1vqeJmURpQoHxco/2B1zSkJ+UK6zjRQetF/Go4u
         9O7ExQ+Mle96ejc9UxkB+/hBRloRqWu/cpx4/jY2BKjQEJZzFCaNqrnjQq77LpAKErZ5
         GxXN/5gUj4i1ShmLIQWGGY1cOelp7eY3j9ZeKjTSbjNbYZ1Eo5xvM1j3bzDwHuIbvCLN
         VZm2FbKgJBIT4wAgjz/iIV6B+vKHUSCEpPS6hIDwvTkbpYM8wXMBwMk11lY2O0+2Ot9x
         u+S5QAb5PrZI8udcX4vF1Nd3JT/H/M9oOu1MtyB6nhATNxCaK8MbSdv++QXBAxtjs3Hg
         0OXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhGC3kfQD8SC6hORJLAT5v2SsP5bWmVOo4tH2pjw/0mSkTfhqiHMFFhJjdm3yDTqecKlm5/gPn@lists.cip-project.org
X-Gm-Message-State: AOJu0Yxm+5kt/BTzx+24b7Xy8g1iqUQ7lHyBimb/uBliVe72WTdsKZVT
	0kUzNh1Zu6fYp6wF48AApBXr8ZTI3qZW7GE/St6Zg/Uh9W68uABAABfN9sTBVWLJkKA=
X-Gm-Gg: ASbGncvW8vyz1OsaHnV3li8ZMOj5FRVodgqEiVIAnEAPjiJJKdgZ4ftPiYMXgYoQgyN
	QkVyASO8PlqvQIYQK7n0SyJ5IA5oWolg/3p/KbU7JqyLv8e31N07J2j92LQIb+bfccGvSo2BD3I
	D0dn/VMH99Wong1aiYtGafbubcRYVfylAoN4EMSYpMIiaujmlNhxu1taKoW1V32CA+m3eXMYor0
	7y7PYHCH+oC0ajy/cMsMPnLhA8ehmLQwuiWDdx53mg9QR0ncxDStdX+CFX6S/EBM0LW0HJWXxYF
	O50e+CAnjKNqMs9KFX9LxApmDMqqSRfiB14tAJz2nNOXQd+W3hh47HA/9YeXB25xoXvEFGgOYBn
	5Zb6xovZiqPfSdQ4ldV4/atgNPaCuUuxBPLBJmnpxnT/fVk9sqMX0OKazfyRt195ByNFgKOyG76
	gvjah912rEhtFfGA1e3UQmEGa6mfgQ0w==
X-Google-Smtp-Source: AGHT+IHRG+pOnWo2NdzcX+R1pg453fhfhMzaQurHVdv+0tVgRLUZjLpXmF80KHiLLEcEYDIi04XfBw==
X-Received: by 2002:a05:600c:1385:b0:477:63b4:e77f with SMTP id 5b1f17b1804b1-47763b4eb67mr15699395e9.0.1762416743382;
        Thu, 06 Nov 2025 00:12:23 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eceaed27sm2486647f8f.27.2025.11.06.00.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:22 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 02/22] of: Add of_machine_compatible_match()
Date: Thu,  6 Nov 2025 10:11:58 +0200
Message-ID: <20251106081218.2574950-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20419

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
index 1029173ded4d..013549c61be2 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -557,6 +557,27 @@ int of_device_compatible_match(struct device_node *device,
 	return score;
 }
 
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
index 4ed8dce624e7..65c0e3105809 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -398,6 +398,7 @@ extern int of_alias_get_alias_list(const struct of_device_id *matches,
 				   unsigned int nbits);
 
 extern int of_machine_is_compatible(const char *compat);
+bool of_machine_compatible_match(const char *const *compats);
 
 extern int of_add_property(struct device_node *np, struct property *prop);
 extern int of_remove_property(struct device_node *np, struct property *prop);
@@ -794,6 +795,11 @@ static inline int of_remove_property(struct device_node *np, struct property *pr
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


