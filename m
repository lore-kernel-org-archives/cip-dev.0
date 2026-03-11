Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1F0105D28E
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:09 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18259.1773227045258333379
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Lcz1Qs13;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso126803875e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227043; x=1773831843; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6+CDHrprbOQAVZteZovHsL0QErEJashGNcPn4z7Cr4=;
        b=Lcz1Qs13ecyVWDBkThZy8YUWg1l1C5L/LBXyF4Yq9ooBv3/6VnaWZCTaJ3IBf9ICR7
         m3tjK0LJFq7TBDLe0t22hgZsO0dWCnoOqTbebOPl5RihEVw+dKwyuXcygIcodx2biIAB
         bHh7dlDfQHmquw5OKzUlidTcBkOyOn7qidfIuAC4AaIH3AD3G8ZxkwUCpKMZ3wJ4meDt
         0l90qNQm8boV9Rcz+fk13vEw0vMvVd20Msljayuk2lT3NHtcc4TeK2ttchReUdXz8c8a
         eBfiI6/SXFahftpDSpCPjHnFDeHnRPGf9n6p4T054lqThoRrpCTp2AZLJWyA05au0DIM
         82AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227043; x=1773831843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O6+CDHrprbOQAVZteZovHsL0QErEJashGNcPn4z7Cr4=;
        b=NYh67afiLY5fRkinzvq7JKfJtuFfu7DArdXKMC2eC5sQSSUqHiB3f4OBU2MkxQya33
         jRi7RN25HCw6cl86eSyJiP2093+hVRGpZyhXk7rFpRkDbkX6Ay8ZAG9Cow71h8r6HEnM
         RDWRYHv07cKJTvxQSimT0OCBTwzBlkIkv8ClAu2KtLwJxzri7DwfufU3zdxincEanyfS
         FuB2RROZMNObVUd8BRSF1xHh8g30Z/Y7o+5CLMj5MRiH/a8qEBwCYrA6EHo2Glaoh7dm
         4rlOijUdKqjlQ6Wn1vPXF3oCpEVfov7FVSms6mnEMPdTLKwasX/FfyjBWbdaMBy4IhSH
         GKDg==
X-Gm-Message-State: AOJu0YxaiuewexDICiekGsi8+vSi3zCnbRr9xaX+xndimk0AuGEDnlJ6
	MisK72uGVjfHGjOgOHTyvE/4G0CH2a/4Xt0IyJ50Vaax+CaCpaJmi6CQ1NUm8b6cydNNyIVsfih
	bEa+A
X-Gm-Gg: ATEYQzxNMLbs2Ci3udN/qhPJm0nbU9f9T3G2AeVxNnZQNbeu57la7MyuHzqvfU9YpK9
	Mop2lub/33yLxY7SXBeJhVlmDZqFBGlI8IGuQKrfZtIUbtBMDBI4XL/E0Vvz3LnyIRNCjHz/8WD
	hv+Isi1p79F4uQzojVKCmwEaeKwPEXEwKgSJEh4zlHMVnRk6KsV07BYP1+oDK+pbyRQ9n/qBYTx
	0NSoRBZNzoiWPNrE4zAQYBK97okmDEUok/jDf8oP/rjLFCxTSzY+JOEBeHMkGyEM2y42t/aPPBC
	Jairc+NQKD0QrM1KDnKaQOPW7ZArgeiHkgJ8cS9ZPp+LwFWFjJoQkQLNqJQ6qQkAz9MNI9JuFgV
	s71p1Vh+GR8R8ElywrtuGQPTYaRmZGbRin2+N6+kceNtEUu67PUPrgECc1xCpYSfwp6oKidLc3r
	Z0qWU6EpCQTRJX6JfallO3cMCTSq/Ow4QXTr7XYqi1HQ89uCASdSiN
X-Received: by 2002:a05:600c:19cf:b0:485:3f17:425 with SMTP id 5b1f17b1804b1-4854b10131fmr34060215e9.21.1773227043450;
        Wed, 11 Mar 2026 04:04:03 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:03 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 03/28] mfd: syscon: Add of_syscon_register_regmap() API
Date: Wed, 11 Mar 2026 13:03:32 +0200
Message-ID: <20260311110357.1938200-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22282

From: Peter Griffin <peter.griffin@linaro.org>

commit 769cb63166d90f1fadafa4352f180cbd96b6cb77 upstream.

The of_syscon_register_regmap() API allows an externally created regmap
to be registered with syscon. This regmap can then be returned to client
drivers using the syscon_regmap_lookup_by_phandle() APIs.

The API is used by platforms where mmio access to the syscon registers is
not possible, and a underlying soc driver like exynos-pmu provides a SoC
specific regmap that can issue a SMC or hypervisor call to write the
register.

This approach keeps the SoC complexities out of syscon, but allows common
drivers such as  syscon-poweroff, syscon-reboot and friends that are used
by many SoCs already to be re-used.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Tested-by: Will McVicker <willmcvicker@google.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240621115544.1655458-2-peter.griffin@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
[claudiu.beznea: fixed conflict in syscon.h by keeping the previous
 definitions for the conflicting lines and the newly introduced one from
 this patch]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mfd/syscon.c       | 48 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/syscon.h |  9 +++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 4d536a097e8c..381a71a57d0e 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -178,6 +178,54 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 	return syscon->regmap;
 }
 
+/**
+ * of_syscon_register_regmap() - Register regmap for specified device node
+ * @np: Device tree node
+ * @regmap: Pointer to regmap object
+ *
+ * Register an externally created regmap object with syscon for the specified
+ * device tree node. This regmap will then be returned to client drivers using
+ * the syscon_regmap_lookup_by_phandle() API.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int of_syscon_register_regmap(struct device_node *np, struct regmap *regmap)
+{
+	struct syscon *entry, *syscon = NULL;
+	int ret;
+
+	if (!np || !regmap)
+		return -EINVAL;
+
+	syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
+	if (!syscon)
+		return -ENOMEM;
+
+	/* check if syscon entry already exists */
+	spin_lock(&syscon_list_slock);
+
+	list_for_each_entry(entry, &syscon_list, list)
+		if (entry->np == np) {
+			ret = -EEXIST;
+			goto err_unlock;
+		}
+
+	syscon->regmap = regmap;
+	syscon->np = np;
+
+	/* register the regmap in syscon list */
+	list_add_tail(&syscon->list, &syscon_list);
+	spin_unlock(&syscon_list_slock);
+
+	return 0;
+
+err_unlock:
+	spin_unlock(&syscon_list_slock);
+	kfree(syscon);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_syscon_register_regmap);
+
 struct regmap *device_node_to_regmap(struct device_node *np)
 {
 	return device_node_get_regmap(np, false);
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index 7f20e9b502a5..dd5f972ffcdf 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -28,6 +28,8 @@ extern struct regmap *syscon_regmap_lookup_by_phandle_args(
 					const char *property,
 					int arg_count,
 					unsigned int *out_args);
+int of_syscon_register_regmap(struct device_node *np,
+			      struct regmap *regmap);
 #else
 static inline struct regmap *device_node_to_regmap(struct device_node *np)
 {
@@ -59,6 +61,13 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle_args(
 {
 	return ERR_PTR(-ENOTSUPP);
 }
+
+static inline int of_syscon_register_regmap(struct device_node *np,
+					struct regmap *regmap)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
 
 #endif /* __LINUX_MFD_SYSCON_H__ */
-- 
2.43.0


