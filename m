Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4ACD24456
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:15:38 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50849.1764872137276329921
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:15:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GzOhUDp7;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477632d9326so8839065e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872136; x=1765476936; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcO6bxC5sutfLiJ12bSbwxhOLw6VToCiNt9uC70tff4=;
        b=GzOhUDp7X8hC1T6C9fB/u28cPjGydR0nKLbi5LHJVMdQVrtiHqViMr8gr80xJ4nniq
         0O220etq3FTXg+jRFHMQRd1wbsG8PNTSDLA3yw1ZNFEw76cx8qQiLG8PFZrvEcouI4aY
         UGWuKK3wJQXMtaOJ3K/16G8vc3QjwSlZgsfPcqiWgtfqsKDzPoEDXNCoTb81A378U9tM
         Ip484K2pYa4lCW38+yT9eUhwIlojQ5PBbW06uiPW7sPQx3+qEtNfcuc6bv66ix0DwVVh
         oV3cDNamhI0PZ7EOMHL8hoaktNxXTk0pmVSmCDABrVBiLyh0eCnI/gji4AihlVRehVi4
         pAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872136; x=1765476936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rcO6bxC5sutfLiJ12bSbwxhOLw6VToCiNt9uC70tff4=;
        b=UwZh7yB4hN6RXXy/qujyiRhmR3hfO4ypCwFfIjpLdFekhJE1hdBFhBKklMO34SC0lg
         5uQksyhg4dXsP9S/E25tUwSzVinbZdJiI7DNFoWGIDSnzkue4umWba+yZmnJc27LVQks
         daHqOek5/aHTIGovwNIohGhJ8Meoqxo4HV0DTyxloeWkgLkDlXhMKPTK/WV5/eiM2ejr
         gsSt/uuabTdu+ZPeCFZBX8HkWhbrPikfr5YnbLt4yI7khXF1tivuApoQJG0By8yYr+sX
         gg4nLwSmJL1PBpqBfJmnQPYboQ9JxKJlUbJiUpBVSB4vHP+pfTK1u6e5pLJ5lRDOXSNJ
         b24g==
X-Forwarded-Encrypted: i=1; AJvYcCWJm7x1a9fpY/haRu8S4r5MV2TJQfr0iXgjtLwGXmunHw6BRb6Eytzr70KjDYfRk4E+MWnwxYxq@lists.cip-project.org
X-Gm-Message-State: AOJu0YzEy8FnbXQXOTvZVE8DCewGemrnrJoL4xHZ9IkY6fJVjqgL32TT
	L2nqRzNdcbBvHZCjMdPN3t7tPo7YVL+IZNodRgkiqbOWuNgRCicFI929EELyIjMqmZ48Ec7AqiB
	jGdMY
X-Gm-Gg: ASbGncsmUI1RZGQZEUn0EE9ai4HKS3u3MfD6kv15AUasVFd2s7qTHqvD6yjyr/cM02G
	tw0mPJwYR8qYvCO2LYenWwM2VZzCVmQeqmWrgKlkD0lTWkhT6sfLSsrMS1yZyUUXZwSeSsyXxUI
	OoQxW+qDaQJnhiFwGZ059MTr6g6CAhBVKFu8zJ9WPiWS62aCyE5GjMUnSsZETTTEc1colP4xClk
	rZ7ORlcV8R96bden8pZ/fXlPLOpLnZu+yVt7/2XZjxsVhBvtczYsNWGcCYh84osFna5Z2qqNKOY
	rllBfIopTp6sBqW1q1P6e/5+j+L9y2ys8JuQhzZraRy90nVmzSkCAQEPa/tsB90obKG60F20Hp2
	sYIz22S4W0YVQq0QRkkQzErJIya9FVKbXF1vy7K1xIAOKpZqU9Qz1SiaP6MzbTbg+pDH76jh5Oe
	lASZhXwRbdPfUD/nxa5g0sJPx/X932aa7Dscp3FCRf
X-Google-Smtp-Source: AGHT+IG8UEilExfJvO3PMkafN/Y6hpxJFGdNrLMsMSfTsJ0S6jYcq69xWetxeCO8K9QIJez5HqcJsw==
X-Received: by 2002:a05:600c:1f8f:b0:477:73cc:82c3 with SMTP id 5b1f17b1804b1-4792af3d2e9mr71795415e9.26.1764872135586;
        Thu, 04 Dec 2025 10:15:35 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930f286f4sm42953625e9.0.2025.12.04.10.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:15:35 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 02/19] of: Add of_machine_compatible_match()
Date: Thu,  4 Dec 2025 20:15:13 +0200
Message-ID: <20251204181530.689132-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:15:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20868

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


