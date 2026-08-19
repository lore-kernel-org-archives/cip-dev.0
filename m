Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4AFC5DF81
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 02:13:12 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24079.1787105584417455105
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Aug 2026 19:13:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=vuUW89JS;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1787105580;x=1788315180;bh=Yn
	cgnGQ3I9ZRH4pKRAkM/O+dvhv5fXKAtXi95Y9YAQI=;b=vuUW89JS53TlxD9qJuCJNSHL7RLjqnnH
	RcZgnYib3j81Xo6bKQl9I3YPXoB7dEkUCUST2xvzjYr5/5gF6TsptS3DWxeWQeqf/bW2bkEWQD/5I
	mrTnRH2foPAzsbnV2cfgROmxksCodwlzPVnxEO7eI+8XfKqOrR4D23M426Xc7ZsmmVhfj++lG3LNz
	ghpCw6RfrWQ4QMvYgcVyaMnqHasp02i0DNadx0S1VI5qMdGFFgim4hXN/jOCY3iLLIln0b2dSLaKr
	wlGuG81xGXrlkWYhAx9H+qwkv7F4uiISY/SvvmW35XRDunHUkUrfKIRK01tC+y1IGqmFi9TLA9pPi
	UQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 67J2CxI52767258; Wed, 19 Aug 2026 11:13:00 +0900
X-Iguazu-Qid: 2rWhi97bTcOVpReWNb
X-Iguazu-QSIG: v=2; s=1; t=1787105579; q=2rWhi97bTcOVpReWNb; m=FSsNeX9s/Uz8bCuidByNBtolL53kt8Ivg7eolWIBUVQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hPqpy6lWTz4vys; Wed, 19 Aug 2026 11:12:58 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, claudiu.beznea.uj@bp.renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.1.y-cip 2/2] of: Reimplement of_machine_is_compatible() using of_machine_compatible_match()
Date: Wed, 19 Aug 2026 11:12:57 +0900
X-TSB-HOP2: ON
Message-Id: <1787105577-3655-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1787105577-3655-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1787105577-3655-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Aug 2026 02:13:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23949

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
Fixes: 3c134b7b41d ("of: Add of_machine_compatible_match()")
---
 drivers/of/base.c  | 21 +--------------------
 include/linux/of.h | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 84d00f141210e..e27824378fbf3 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -600,26 +600,7 @@ bool of_machine_compatible_match(const char *const *compats)
 
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
index 0e7dcee4d14b0..3f60394017ca8 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -393,9 +393,21 @@ extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
 extern int of_alias_get_id(struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
 
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
2.51.0



