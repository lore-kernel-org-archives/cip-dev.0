Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12608.1794488342628362987
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2026 04:59:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fairphone.com header.s=fair header.b=a8347Z1w;
 spf=pass (domain: fairphone.com, ip: 209.85.218.44, mailfrom: luca.weiss@fairphone.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso684086566b.2
        for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 04:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794488341; x=1795093141; darn=lists.cip-project.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ilr8CVH7Zkw2exgPl53KoqpTgAno6D1DsInSxLBj60=;
        b=a8347Z1wDWDd/mVFz+3jP+FmPgv1Yy1xWcu3uabmq4gYtVvdpKiuUoxplzGCJPEMtK
         +ZTziP2QNSqFGWSl73+pa8plAwSWnpkzebxCgX0BzEj3c6e9OVzfEnyRlnHbZXZ1w6tv
         lXOONSL4POrefQhrYXSlgJ/bIdkIH/92LuRT1Yt7xfHZWvFI/i0aUbmwJvrErgulVN4l
         e1uKxD2hyJqaVNtjeLxxVcDmZc09es8Relhc40CjezX2yGLd3vGUNw2tGDO/hSt1rgbt
         1S+wcK+eQNncm60iLzrXSxQLP65zNRCMgylYvNWqNbbhQfc1eY+3e73XjJjxA49Z2Ak1
         QnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794488341; x=1795093141;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ilr8CVH7Zkw2exgPl53KoqpTgAno6D1DsInSxLBj60=;
        b=YuGoXyu9vp9/lXBrPLvk6raUvWygkwki5UWcMmAONbGLeh6ish1taEsPagxwd+J6Uk
         ifrM7Bl0pftU9ijJGSwr9d3yDswehCpEMLHV4z1m2bcATJMh5FKm/XTROosVIzHCjlAr
         DVvzvnszEGnIV3bJ7+aUfI+6ss7TOFPJcYhhXuldXHsdW1byFQBDLh/g6YuokBcXm8xY
         12SxDlLsxz3pKNUFmASkE1owlFUw2SloaY82EsrK8svFT4B4h8gRbhc9MXoxEHtv//JA
         jmwkWPurxAZZjrF4MmwXsBVoeCQtezNPNw3hP/EQvUvplTYXkf2wEOslthsMGgMkNr6C
         c4rg==
X-Gm-Message-State: APuU4Z+dS18yJtXHoFym7PzDL0pz6TWpK5AMHOA4e4T91+ekrpkRcFyi
	LfmKX3O2pXF98DTCyI85XBHzlHCPB65jFnfPJ04KiiZDEOsJNEvCUggCMVa36Bkutamx74AKh4M
	BMKV7Bes=
X-Gm-Gg: AYBFou3YcfUp/+YnqQdr16WXBRbif7LB17AaSM5/CQyO0308I6LkEnBZhP1PqGr6aKX
	CCkKL25J5mYg7rzQCqXyheXcZfV+pptaeDZlE5zHT9xTEpRFRUWU+YeUbQTgizC4qn/wP5e9MHg
	TDW3xT9HuEfAaUMigqcb90dMDy0d42PFD6fssIMI/jug3PSqhVbTRE3NILuvv8DEF+mb5IR3//5
	FGv7yS+LiaB/CPlMY+SA0e+zS+rIdonKyuBz3jX1AcYIFxqkA/6sCRWiXGewlwQtuMjQnZ6DWq6
	OOl7Fh/MM05rQ42w6tMsJzFTFaaDvzgT9hah+KK0ErT8zGfLoLLeutTB6WFAMj9q6NFuTiD2OsK
	CIANSXGWBil7E6cPU2q9bceBbnqyKKGMMD8ojHflDGXPgvb3yTs3bS+vzEtjuFvGE//iRo0NMow
	fS3hU/JPfDd/ByZ/01lhDuPTKBqqqYsVooMM8i97CfIFcF2Y4EdhMVaatIZ+WNjKNQEryYSx2o6
	WPwHraoYY6w33VKFkm7eDklGoLebjZQ/tqmvXe/QqAxv6oC3KlI6xFXcLDxKCsb35W3UHdNoEC+
	t0M+MsXNObh9CKGGURXz+S9SHbgDMnWyvOwMkqHGdwDLO1cadhM/x0TZjLppX6nhkNTy3PJA8y+
	t614cGg3/2mpWVD5BHSoiEDfP5Z9J
X-Received: by 2002:a17:906:9fc4:b0:c41:5a0e:3356 with SMTP id a640c23a62f3a-c5066cf82b8mr462104066b.41.1794487852925;
        Thu, 12 Nov 2026 04:50:52 -0800 (PST)
Return-Path: <luca.weiss@fairphone.com>
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a63f8bbsm336768666b.60.2026.11.12.04.50.52
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:50:52 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 12 Nov 2026 13:50:42 +0100
Subject: [PATCH 4.19.y-cip 1/4] sign-file,extract-cert: move common SSL helper functions to a header
MIME-Version: 1.0
Message-Id: <20261112-openssl4-419cip-v1-1-2f56859669bb@fairphone.com>
References: <20261112-openssl4-419cip-v1-0-2f56859669bb@fairphone.com>
In-Reply-To: <20261112-openssl4-419cip-v1-0-2f56859669bb@fairphone.com>
To: cip-dev@lists.cip-project.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794487851; l=4709;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=hdgclLy9agyI/b+evCi0uL+yRVCHsBr44pi+i+wWNo0=;
 b=6ra9HjmNo/FhsQATvGktQv6Lga2fq4UKvRa7Hoky+MPvB2kxq1eokHSeg+mjo18yUtjxnj6lE
 UokDfU7W1ccC+3u40D6U2dgQEoU/x57Rj6oAOk57BlKJcWPQQDIsEus
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 07:57:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24816

From: Jan Stancek <jstancek@redhat.com>

commit 300e6d4116f956b035281ec94297dc4dc8d4e1d3 upstream.

Couple error handling helpers are repeated in both tools, so
move them to a common header.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[luca.weiss@fairphone.com: Backport to 4.19]
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 MAINTAINERS            |  1 +
 scripts/extract-cert.c | 37 ++-----------------------------------
 scripts/sign-file.c    | 37 ++-----------------------------------
 scripts/ssl-common.h   | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 70 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9990ce776a85..8606d3726848 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3462,6 +3462,7 @@ S:	Maintained
 F:	Documentation/admin-guide/module-signing.rst
 F:	certs/
 F:	scripts/sign-file.c
+F:	scripts/ssl-common.h
 F:	scripts/extract-cert.c
 
 CERTIFIED WIRELESS USB (WUSB) SUBSYSTEM:
diff --git a/scripts/extract-cert.c b/scripts/extract-cert.c
index dd1a4bd706a2..44c1bf031c9b 100644
--- a/scripts/extract-cert.c
+++ b/scripts/extract-cert.c
@@ -23,6 +23,8 @@
 #include <openssl/err.h>
 #include <openssl/engine.h>
 
+#include "ssl-common.h"
+
 /*
  * OpenSSL 3.0 deprecates the OpenSSL's ENGINE API.
  *
@@ -40,41 +42,6 @@ void format(void)
 	exit(2);
 }
 
-static void display_openssl_errors(int l)
-{
-	const char *file;
-	char buf[120];
-	int e, line;
-
-	if (ERR_peek_error() == 0)
-		return;
-	fprintf(stderr, "At main.c:%d:\n", l);
-
-	while ((e = ERR_get_error_line(&file, &line))) {
-		ERR_error_string(e, buf);
-		fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
-	}
-}
-
-static void drain_openssl_errors(void)
-{
-	const char *file;
-	int line;
-
-	if (ERR_peek_error() == 0)
-		return;
-	while (ERR_get_error_line(&file, &line)) {}
-}
-
-#define ERR(cond, fmt, ...)				\
-	do {						\
-		bool __cond = (cond);			\
-		display_openssl_errors(__LINE__);	\
-		if (__cond) {				\
-			err(1, fmt, ## __VA_ARGS__);	\
-		}					\
-	} while(0)
-
 static const char *key_pass;
 static BIO *wb;
 static char *cert_dst;
diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 12acc70e5a7a..39ba58db5d4e 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -29,6 +29,8 @@
 #include <openssl/err.h>
 #include <openssl/engine.h>
 
+#include "ssl-common.h"
+
 /*
  * OpenSSL 3.0 deprecates the OpenSSL's ENGINE API.
  *
@@ -83,41 +85,6 @@ void format(void)
 	exit(2);
 }
 
-static void display_openssl_errors(int l)
-{
-	const char *file;
-	char buf[120];
-	int e, line;
-
-	if (ERR_peek_error() == 0)
-		return;
-	fprintf(stderr, "At main.c:%d:\n", l);
-
-	while ((e = ERR_get_error_line(&file, &line))) {
-		ERR_error_string(e, buf);
-		fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
-	}
-}
-
-static void drain_openssl_errors(void)
-{
-	const char *file;
-	int line;
-
-	if (ERR_peek_error() == 0)
-		return;
-	while (ERR_get_error_line(&file, &line)) {}
-}
-
-#define ERR(cond, fmt, ...)				\
-	do {						\
-		bool __cond = (cond);			\
-		display_openssl_errors(__LINE__);	\
-		if (__cond) {				\
-			err(1, fmt, ## __VA_ARGS__);	\
-		}					\
-	} while(0)
-
 static const char *key_pass;
 
 static int pem_pw_cb(char *buf, int len, int w, void *v)
diff --git a/scripts/ssl-common.h b/scripts/ssl-common.h
new file mode 100644
index 000000000000..e6711c75ed91
--- /dev/null
+++ b/scripts/ssl-common.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/*
+ * SSL helper functions shared by sign-file and extract-cert.
+ */
+
+static void display_openssl_errors(int l)
+{
+	const char *file;
+	char buf[120];
+	int e, line;
+
+	if (ERR_peek_error() == 0)
+		return;
+	fprintf(stderr, "At main.c:%d:\n", l);
+
+	while ((e = ERR_get_error_line(&file, &line))) {
+		ERR_error_string(e, buf);
+		fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
+	}
+}
+
+static void drain_openssl_errors(void)
+{
+	const char *file;
+	int line;
+
+	if (ERR_peek_error() == 0)
+		return;
+	while (ERR_get_error_line(&file, &line)) {}
+}
+
+#define ERR(cond, fmt, ...)				\
+	do {						\
+		bool __cond = (cond);			\
+		display_openssl_errors(__LINE__);	\
+		if (__cond) {				\
+			errx(1, fmt, ## __VA_ARGS__);	\
+		}					\
+	} while (0)

-- 
2.56.1

