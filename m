Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D80C5DF82
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 02:13:02 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24077.1787105582169843940
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Aug 2026 19:13:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=mZqg1Fcc;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1787105579;x=1788315179;bh=8G
	ePD1dSDXoa5otPwHVf5Bp3t2uN9j59I8/I272jxRM=;b=mZqg1Fcck5Dmc3Tt2dMQdQTMhb4O/HPg
	BIOzY4w57DZ8zQT/KfnI4q4EdstJht42wd/d1dclkOWeoRW/UaWgX5eoe85jMDFqwhxBHJpZ6RrJK
	0/37Bc4GfIJFnEulvjj748O2Q+jTP6TcocBgPC8gGI7S2kbXKa4LsRdROxz74i0dij3zQsztSRmvY
	O3Mjkm+mDDupy0O8ik/LtOlBUUSKD8lEobwTSyo64Zith9O+3WNrOaV3wkp/2zGxcx8XUw2msF2f1
	9Irb16KNdwHRiVRcfv1JxEhfQQz1ri5o43MsUjYpaGmeUn4irQWQVvYhbqe/VGcGbEQvXKXp0cf9b
	8Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 67J2Cxso995100; Wed, 19 Aug 2026 11:12:59 +0900
X-Iguazu-Qid: 2yAbG25DVCLLIAElda
X-Iguazu-QSIG: v=2; s=1; t=1787105579; q=2yAbG25DVCLLIAElda; m=/WDx6nr/G+i8jESGIzfhnKEd8WQU3nC0VxjgyPYYLMw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hPqpy59bszyPg; Wed, 19 Aug 2026 11:12:58 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, claudiu.beznea.uj@bp.renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.1.y-cip 1/2] of: Change of_machine_is_compatible() to return bool
Date: Wed, 19 Aug 2026 11:12:56 +0900
X-TSB-HOP2: ON
Message-Id: <1787105577-3655-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1787105577-3655-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1787105577-3655-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Aug 2026 02:13:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23948

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
index 4d59c155a4cf9..84d00f141210e 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -605,10 +605,9 @@ bool of_machine_compatible_match(const char *const *compats)
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
index 30d641eab4761..0e7dcee4d14b0 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -393,7 +393,7 @@ extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
 extern int of_alias_get_id(struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
 
-extern int of_machine_is_compatible(const char *compat);
+extern bool of_machine_is_compatible(const char *compat);
 bool of_machine_compatible_match(const char *const *compats);
 
 extern int of_add_property(struct device_node *np, struct property *prop);
-- 
2.51.0



