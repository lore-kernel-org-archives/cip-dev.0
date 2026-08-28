Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC18C61DC4
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 01:51:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.145.1787881910215925719
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Aug 2026 18:51:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=x4dfbe9U;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1787881901;x=1789091501;bh=rz
	IIeSvzRH4LoJfHtiV1j2A26m0IOU/gsKrNnz4AAH0=;b=x4dfbe9UIuVAK2FnzcqiU4etrQJvLHLA
	jvCc0mtOiduOk8Rt7+7lYu45TzxQOD4eFFqfualin5+yiD1g+xTDeKfabj9rPYJtV2YirUYGiCh34
	u1jecmE767ufwjF8Ap+WNShCVfp9Qyt1oS0xrWGbxJnuV4JZNsO8VC9AxMKXKVQ3pZrnWITCYbZMQ
	JLW6zr6j+frKrFQiyUZCjdzcZWeCY75zzXX77xlzYS+GvDAz9FxV0dryOjOgyCfjUM7uXK91SXOBe
	Gu25HG2laksoX3iNZSDYvGoNkfQzHxgKwFIYv52pTdOqU6eUIn4jLs74izNlCtmaN2Df+/BHPwWNx
	wQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 67S1peqF3144268; Fri, 28 Aug 2026 10:51:41 +0900
X-Iguazu-Qid: 2yAbwzVsw8FpWcPGvZ
X-Iguazu-QSIG: v=2; s=1; t=1787881900; q=2yAbwzVsw8FpWcPGvZ; m=sEI2CdG13ZeDel3nhUmZN2jti052DyDfPnYq2aFZkWU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hWLwC4GJhzyPk; Fri, 28 Aug 2026 10:51:39 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, claudiu.beznea.uj@bp.renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 5.10.y-cip 1/2] of: Change of_machine_is_compatible() to return bool
Date: Fri, 28 Aug 2026 10:51:36 +0900
X-TSB-HOP2: ON
Message-Id: <1787881897-6475-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1787881897-6475-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1787881897-6475-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Aug 2026 01:51:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24043

From: Michael Ellerman <mpe@ellerman.id.au>

commit cefdb366dcbe97908b6055595a15bf7689556bf8 upstream.

of_machine_is_compatible() currently returns a positive integer if it
finds a match. However none of the callers ever check the value, they
all treat it as a true/false.

So change of_machine_is_compatible() to return bool, which will allow
the implementation to be changed in a subsequent patch.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231214103152.12269-2-mpe@ellerman.id.au
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/of/base.c  | 5 ++---
 include/linux/of.h | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 3c92edc3d17f7..ca3e6e4bb2ec3 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -582,10 +582,9 @@ bool of_machine_compatible_match(const char *const *compats)
  * of_machine_is_compatible - Test root of device tree for a given compatible value
  * @compat: compatible string to look for in root node's compatible property.
  *
- * Return: A positive integer if the root node has the given value in its
- * compatible property.
+ * Return: true if the root node has the given value in its compatible property.
  */
-int of_machine_is_compatible(const char *compat)
+bool of_machine_is_compatible(const char *compat)
 {
 	struct device_node *root;
 	int rc = 0;
diff --git a/include/linux/of.h b/include/linux/of.h
index 5f4dd8db7a674..3726ae11430b1 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -399,7 +399,7 @@ extern int of_alias_get_alias_list(const struct of_device_id *matches,
 				   const char *stem, unsigned long *bitmap,
 				   unsigned int nbits);
 
-extern int of_machine_is_compatible(const char *compat);
+extern bool of_machine_is_compatible(const char *compat);
 bool of_machine_compatible_match(const char *const *compats);
 
 extern int of_add_property(struct device_node *np, struct property *prop);
-- 
2.39.5



