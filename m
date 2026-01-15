Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41960D33A10
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:33:51 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31250.1768466021177633369
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:33:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KNgaCFyf;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64dfb22c7e4so3087751a12.1
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466019; x=1769070819; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCB6ErHg3HBJCpKTkqNetM5X8qwre32JJAbUTZr6jzA=;
        b=KNgaCFyfKKPzYqNMBevXvFamLi+aPREPfVFe7FXcOAEtqrweG614IZ20USNngrxCaF
         aCVFz3NA8x+cfiQ3QPRfPTQhsjgov69XLujqHoR/5203b5VvyqiK8ngozNxFdOPtrEfJ
         FlTnOsmYkK243IaWLyqAZxUMUpdJVZJTUeMi1SBKBLEfKDYAmFE6dPIy+p7ZO0Uf/hKz
         oyKQ0Q8cN3vBSUHlrV1EKDSsziqokdM2Iw/0skWpd6djaX2GGpyHY6O918AMM85vkQOK
         E3/X14bteS1DAVwKY7g/6ROwkstDJDlFmEhRVN3KewWnDdcs3EtSgnxCb1erldrqQwwp
         EpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466019; x=1769070819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CCB6ErHg3HBJCpKTkqNetM5X8qwre32JJAbUTZr6jzA=;
        b=LynV6MvTdMyb1ST+CAfMFkt07jHbKr9L6d/D0k0PmAbcMCdVTK4z+PehpD2Hly4z74
         6yS0fVjpYuBLs4ffsQyfP4UdDiEwMZPkGbhiEStVPN5HU4o134hc0Pv37+vHJNUp11Fw
         jfzyZQbI4cA25IXiWMSA9cFfAywANIZdPL3SAPGxt3kSJyaS4O1VspKKlOtWHjp4XzWf
         RZcOB+vkLW3Xn9PJ+TsDisCZRKbhSDOSkQpEFJaj4BFIIhiDeGWV9F3K5pj3kCw4kYOm
         jiLV4p0w3++VQWyZ8t6XXXOZYH3QKWhoo+7C4LviAggzoaCn9ZW5HJ6dSAIKxCOcmt9n
         3lXw==
X-Gm-Message-State: AOJu0YyBnKHlt++sFLEva4I3RcL3u1tIu+bLeP9eBmaChhBZ7xNXaiwC
	pEbMmZOtAtznVLlGFm1ZBSo6NZSn1pVek31ZjuAZE+QUPLAF8hAYnVvBgJWQG/NOQkWzLiPFvDw
	YOF//
X-Gm-Gg: AY/fxX4LOGCI4x9LRVwqkDRMJvK5AXeOWTlQxHdIRhe7BxB9sGG3FHWGz3oQN8hF37l
	TgzmrapXDFnzhXY/UE1CeJZE0J75f1YZ8GhTNdgBj3DuvViJ0FmZv7pCjs7vr7YZQDwjwOWplJ1
	v3M4W4GPo9b5EjRsg35zCIGb2OlwsmJ0T6V2IHe4/I4obmj1QTvyI0KJphSVI9xa/KUplKh/NG4
	NzzUpE3uIjJcwfjJGVo0wq0iGRP5LSHc3Vc156Ta2EQCk7lkrDHsmFRNKLCYM5Kx15uVbsjUt2I
	Co6NfjPylD8br3L581FHs3lrT9Ja7I9Q3VRg3GcjtuHJB45fhNsZWET1TjblsCC0eSH6VxmFM3Y
	S95bMBwNwJADxjdFDfoZZXYWwjvAXy1goMhBWnUVKPhJSDjJh0m4j5IaIr7Dlczbm5Vc+30T7hC
	e67gGYKkZ53B95qes9xACFTgAoTd3x4txNMsiLJCqv//CUT3RCYDVqhVeAFxZu1k12URWWCYGG9
	nnu
X-Received: by 2002:a17:907:2d8e:b0:b3a:8070:e269 with SMTP id a640c23a62f3a-b8777b24ce5mr206054566b.14.1768466019281;
        Thu, 15 Jan 2026 00:33:39 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8731f0718asm833387066b.67.2026.01.15.00.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:33:38 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v3 02/18] of: Add of_machine_compatible_match()
Date: Thu, 15 Jan 2026 10:33:16 +0200
Message-ID: <20260115083332.1063820-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:33:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21563

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


