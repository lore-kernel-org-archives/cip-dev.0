Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A31C61DCB
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 01:51:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.178.1787881910216139497
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Aug 2026 18:51:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=PEFRkX/+;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	Content-Transfer-Encoding;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1787881901;x=1789091501;bh=BMGgHO+X1qXG4ImKc3AL5m5ZqHvvbprPVmBNG0qPKWw=;b=PEF
	RkX/+XHjMG5hsh1pju07OKwf1jH0YdTmEmzzwqtWrpEZVkTz4nZRyVCo7HMGS20+f9MS8pCMivnKw
	LI2ryDbCwXlzAdJff435bkKXLQWEUqgwFgizTfPZsxB/bxkeaNA70XDPeHO7MT1f68L6cTtgjs7qT
	C+fZCJMwPESKq8xy1b7NeuqTpT7b9Z5DXltJDTaDt/KAiP37v85VLs1KsaDWHyQbLpPk7r2saS/fW
	2LqsRnmPW3Xb78adogFQpCoo3EVFwhpu99bPXa/0EUJeHw6t9KghtDNHZuLi1UQxBiPSzZxJczaN4
	LEIxokOat9xBL+YVOsEMQYT50FR2Nbg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 67S1peeP3072992; Fri, 28 Aug 2026 10:51:40 +0900
X-Iguazu-Qid: 2yAbeCtgx24hX5aKn6
X-Iguazu-QSIG: v=2; s=1; t=1787881900; q=2yAbeCtgx24hX5aKn6; m=SamK2yaRQCdbuGJwy+J0CeY4/6OzNc0t2jZAHVvSM40=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hWLwC3PHNzyPj; Fri, 28 Aug 2026 10:51:39 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, claudiu.beznea.uj@bp.renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 5.10.y-cip 2/2] of: Reimplement of_machine_is_compatible() using of_machine_compatible_match()
Date: Fri, 28 Aug 2026 10:51:37 +0900
X-TSB-HOP2: ON
Message-Id: <1787881897-6475-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1787881897-6475-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1787881897-6475-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Aug 2026 01:51:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24041

From: Christophe Leroy <christophe.leroy@csgroup.eu>

commit 1ac8205f907517a306b661212496fedce79d7cc5 upstream.

of_machine_compatible_match() works with a table of strings.
of_machine_is_compatible() is a simplier version with only one string.

Re-implement of_machine_is_compatible() by setting a table of strings
with a single string then using of_machine_compatible_match().

Suggested-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231214103152.12269-3-mpe@ellerman.id.au
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Fixes: 22cb10519e8f (”of: Add of_machine_compatible_match()“)
---
 drivers/of/base.c  | 21 +--------------------
 include/linux/of.h | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index ca3e6e4bb2ec3..896df5acf6931 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -577,26 +577,7 @@ bool of_machine_compatible_match(const char *const *compats)
 
 	return rc != 0;
 }
-
-/**
- * of_machine_is_compatible - Test root of device tree for a given compatible value
- * @compat: compatible string to look for in root node's compatible property.
- *
- * Return: true if the root node has the given value in its compatible property.
- */
-bool of_machine_is_compatible(const char *compat)
-{
-	struct device_node *root;
-	int rc = 0;
-
-	root = of_find_node_by_path("/");
-	if (root) {
-		rc = of_device_is_compatible(root, compat);
-		of_node_put(root);
-	}
-	return rc;
-}
-EXPORT_SYMBOL(of_machine_is_compatible);
+EXPORT_SYMBOL(of_machine_compatible_match);
 
 /**
  *  __of_device_is_available - check if a device is available for use
diff --git a/include/linux/of.h b/include/linux/of.h
index 3726ae11430b1..32be78c366a30 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -399,9 +399,21 @@ extern int of_alias_get_alias_list(const struct of_device_id *matches,
 				   const char *stem, unsigned long *bitmap,
 				   unsigned int nbits);
 
-extern bool of_machine_is_compatible(const char *compat);
 bool of_machine_compatible_match(const char *const *compats);
 
+/**
+ * of_machine_is_compatible - Test root of device tree for a given compatible value
+ * @compat: compatible string to look for in root node's compatible property.
+ *
+ * Return: true if the root node has the given value in its compatible property.
+ */
+static inline bool of_machine_is_compatible(const char *compat)
+{
+	const char *compats[] = { compat, NULL };
+
+	return of_machine_compatible_match(compats);
+}
+
 extern int of_add_property(struct device_node *np, struct property *prop);
 extern int of_remove_property(struct device_node *np, struct property *prop);
 extern int of_update_property(struct device_node *np, struct property *newprop);
-- 
2.39.5



