Received: from mail-ej2-f9.google.com (mail-ej2-f9.google.com [74.125.228.137])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12605.1794488317995396355
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2026 04:58:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fairphone.com header.s=fair header.b=nhmyiuz0;
 spf=pass (domain: fairphone.com, ip: 74.125.228.137, mailfrom: luca.weiss@fairphone.com)
Received: by mail-ej2-f9.google.com with SMTP id a640c23a62f3a-c41bc914672so243326966b.1
        for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 04:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794488316; x=1795093116; darn=lists.cip-project.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xgHURDM7wtdcFApMzyMhMEHvB/uzrzi4z0a5yC45Zxc=;
        b=nhmyiuz0l1F/0HX557msWzCKxxrQoGmHngY01QOMfM8E8sA7c/pqm5MEVebCVvpbjp
         5UuB1RfShKMEjxnazOXqRLq5t7O4aeBdKKj+pVlodxjJpxs1Af2vd7p7bwJRkkIurCBE
         AU/ek/xJcqCxB3skD9i1HWckOTOAFIXNKd5GZpMeBCy8Nri7CuqaLE7UuBSLgDywhufD
         e0SkVkm//u2UwW/3Knzh13RSiyyIVeFmimJD2nav9z27a7aiU/apKhV6+rRXgKcjhDb7
         eucWRSOefJ0fQDNpTUj3/B8VkCp7MWSq9bZVSeNHhSOLSw9BcoWsjUIJJg0UH37FNbSV
         zzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794488316; x=1795093116;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xgHURDM7wtdcFApMzyMhMEHvB/uzrzi4z0a5yC45Zxc=;
        b=bWD9y0npItjkBZU/uX0b9K9s1u07UzV4PX7LJHS0v3l3jYKzeAdd8NqjUQlyy9wVsH
         8jkVvBIHPr5n3eE87sLVwi0V/35F1FtkNoghcRop+abNOf+U5Ty+iW/gcFzgWjhUwE05
         AK4lIWvphPCn3ymEqA9CdyiJU8UAKciePrqIgKJ0h8qonxhkyWJ/2y7azNprD2LKwWjF
         wBWFzEK5j/LnACU02hhpph6gVdW/AUpO2qRum+wj7ZJSVkzUlcSuXmMZS4trR+KujTli
         FTLurzI+vZBaMjcKPDdWU7+cSlxq+6iHjvOD/llCY5QGjHbDY4qEa9o204fsVLVCsQ87
         CfsQ==
X-Gm-Message-State: APuU4Z9mcQdDJj/UeUlgX/X6CcQ0gEoTrrxvI3qNhPjwNFByfbbjsyOz
	8fM00jxmIDAemPEdQR2Tif6YgdNmNOJgWGWdQKpMXYjakdCZpepGkMRjaAinhNI1DMKVzSmFPaZ
	vvsikMEwCWA==
X-Gm-Gg: AYBFou35oqjG1DiOz4gJS5SyOEnmcIMu/oZybbqRHcllfEeM++XhqbyFp7bqHTbmCpu
	7lWHCuOy2ZrhRA3cPWwnDaqHQ5qvfTSrapz8jg+XYr0zHlBrX6e2TPdhPTVnHt9mVMK1bxb8/4l
	v+OErfUOh+7aUJ76D5Thsf+I+UfFdjjfjElmU9Zzj/J4XydUhJymXFFBEd73Ai5dlOkX+fBBvTZ
	0wlfYZHInZHo2qDWsnGVNICWLJnc9r537B+pnOtM52dlny+RfDHXb3HATw+XXa0UGiRNWmxwtwD
	vpXQqBacZ5AoxLvN5tAhZaZOPNF8El7Mj5DexrdwRR5u6+oJvdRHTLJYd1qMNBJ8lka61qqyLOO
	ZWwF53ro+c8NnMQJyoz2TNubfTk2iEJoHS3zvjPHeix94aeeBoxdWdj7wzCFJfVOEdQQNq1liT0
	15O7SAireh/Sj1swWWOOeqZZZbIiML7CeXQIr10yewqKDwCh1t0vUsE/9GXQ3tGHcSeoKEZMAnj
	SFcY2eBKHFVt01/tjgKcPQaWUbxiDpQgofm53cuX7Ax2GCqA2v7x6jNzAf1m52/X11BmriOOdeY
	K3nPIvGk9nr2Kc1JMkB3NW1OpPIyf7M1CvKDrlkIoeJzQhn31eDmVGX6RhHy+RuV2qXp5TwOfnP
	sVjoeVl2p8fvFk41sVdclDevkYHZI
X-Received: by 2002:a17:907:96a3:b0:c3e:f39b:2286 with SMTP id a640c23a62f3a-c50662becd5mr473362466b.0.1794487853819;
        Thu, 12 Nov 2026 04:50:53 -0800 (PST)
Return-Path: <luca.weiss@fairphone.com>
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a63f8bbsm336768666b.60.2026.11.12.04.50.53
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:50:53 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 12 Nov 2026 13:50:44 +0100
Subject: [PATCH 4.19.y-cip 3/4] sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
MIME-Version: 1.0
Message-Id: <20261112-openssl4-419cip-v1-3-2f56859669bb@fairphone.com>
References: <20261112-openssl4-419cip-v1-0-2f56859669bb@fairphone.com>
In-Reply-To: <20261112-openssl4-419cip-v1-0-2f56859669bb@fairphone.com>
To: cip-dev@lists.cip-project.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794487852; l=8391;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=wBgbnPjXsU3JcK+e4rbWs6E3bQMlp/MsyaZ/7ZV9cTM=;
 b=C7nOgG32eOOZrPG3+zv3/8DrVIGUoy8Wyr4fDyJR2jbNsh13cuz7+09c3dQtOhefeTuRv4PQY
 0w5bfqFi8DcBQjEm5lO2V3n3xa0kKlTSOSAhFbxX9xYIvWi1D0HH/PJ
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 07:57:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24815

From: Jan Stancek <jstancek@redhat.com>

commit 558bdc45dfb2669e1741384a0c80be9c82fa052c upstream.

ENGINE API has been deprecated since OpenSSL version 3.0 [1].
Distros have started dropping support from headers and in future
it will likely disappear also from library.

It has been superseded by the PROVIDER API, so use it instead
for OPENSSL MAJOR >= 3.

[1] https://github.com/openssl/openssl/blob/master/README-ENGINES.md

[jarkko: fixed up alignment issues reported by checkpatch.pl --strict]

Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 scripts/extract-cert.c | 103 +++++++++++++++++++++++++++++++++++--------------
 scripts/sign-file.c    |  95 +++++++++++++++++++++++++++++++--------------
 2 files changed, 139 insertions(+), 59 deletions(-)

diff --git a/scripts/extract-cert.c b/scripts/extract-cert.c
index f54644f74e37..73364ed31fd2 100644
--- a/scripts/extract-cert.c
+++ b/scripts/extract-cert.c
@@ -21,17 +21,18 @@
 #include <openssl/bio.h>
 #include <openssl/pem.h>
 #include <openssl/err.h>
-#include <openssl/engine.h>
-
+#if OPENSSL_VERSION_MAJOR >= 3
+# define USE_PKCS11_PROVIDER
+# include <openssl/provider.h>
+# include <openssl/store.h>
+#else
+# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
+#  define USE_PKCS11_ENGINE
+#  include <openssl/engine.h>
+# endif
+#endif
 #include "ssl-common.h"
 
-/*
- * OpenSSL 3.0 deprecates the OpenSSL's ENGINE API.
- *
- * Remove this if/when that API is no longer used
- */
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-
 #define PKEY_ID_PKCS7 2
 
 static __attribute__((noreturn))
@@ -61,6 +62,66 @@ static void write_cert(X509 *x509)
 		fprintf(stderr, "Extracted cert: %s\n", buf);
 }
 
+static X509 *load_cert_pkcs11(const char *cert_src)
+{
+	X509 *cert = NULL;
+#ifdef USE_PKCS11_PROVIDER
+	OSSL_STORE_CTX *store;
+
+	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
+		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
+	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
+		ERR(1, "OSSL_PROVIDER_try_load(default)");
+
+	store = OSSL_STORE_open(cert_src, NULL, NULL, NULL, NULL);
+	ERR(!store, "OSSL_STORE_open");
+
+	while (!OSSL_STORE_eof(store)) {
+		OSSL_STORE_INFO *info = OSSL_STORE_load(store);
+
+		if (!info) {
+			drain_openssl_errors(__LINE__, 0);
+			continue;
+		}
+		if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_CERT) {
+			cert = OSSL_STORE_INFO_get1_CERT(info);
+			ERR(!cert, "OSSL_STORE_INFO_get1_CERT");
+		}
+		OSSL_STORE_INFO_free(info);
+		if (cert)
+			break;
+	}
+	OSSL_STORE_close(store);
+#elif defined(USE_PKCS11_ENGINE)
+		ENGINE *e;
+		struct {
+			const char *cert_id;
+			X509 *cert;
+		} parms;
+
+		parms.cert_id = cert_src;
+		parms.cert = NULL;
+
+		ENGINE_load_builtin_engines();
+		drain_openssl_errors(__LINE__, 1);
+		e = ENGINE_by_id("pkcs11");
+		ERR(!e, "Load PKCS#11 ENGINE");
+		if (ENGINE_init(e))
+			drain_openssl_errors(__LINE__, 1);
+		else
+			ERR(1, "ENGINE_init");
+		if (key_pass)
+			ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0), "Set PKCS#11 PIN");
+		ENGINE_ctrl_cmd(e, "LOAD_CERT_CTRL", 0, &parms, NULL, 1);
+		ERR(!parms.cert, "Get X.509 from PKCS#11");
+		cert = parms.cert;
+#else
+		fprintf(stderr, "no pkcs11 engine/provider available\n");
+		exit(1);
+#endif
+	return cert;
+}
+
 int main(int argc, char **argv)
 {
 	char *cert_src;
@@ -86,28 +147,10 @@ int main(int argc, char **argv)
 		fclose(f);
 		exit(0);
 	} else if (!strncmp(cert_src, "pkcs11:", 7)) {
-		ENGINE *e;
-		struct {
-			const char *cert_id;
-			X509 *cert;
-		} parms;
+		X509 *cert = load_cert_pkcs11(cert_src);
 
-		parms.cert_id = cert_src;
-		parms.cert = NULL;
-
-		ENGINE_load_builtin_engines();
-		drain_openssl_errors(__LINE__, 1);
-		e = ENGINE_by_id("pkcs11");
-		ERR(!e, "Load PKCS#11 ENGINE");
-		if (ENGINE_init(e))
-			drain_openssl_errors(__LINE__, 1);
-		else
-			ERR(1, "ENGINE_init");
-		if (key_pass)
-			ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0), "Set PKCS#11 PIN");
-		ENGINE_ctrl_cmd(e, "LOAD_CERT_CTRL", 0, &parms, NULL, 1);
-		ERR(!parms.cert, "Get X.509 from PKCS#11");
-		write_cert(parms.cert);
+		ERR(!cert, "load_cert_pkcs11 failed");
+		write_cert(cert);
 	} else {
 		BIO *b;
 		X509 *x509;
diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index bb3fdf1a617c..7070245edfc1 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -27,17 +27,18 @@
 #include <openssl/evp.h>
 #include <openssl/pem.h>
 #include <openssl/err.h>
-#include <openssl/engine.h>
-
+#if OPENSSL_VERSION_MAJOR >= 3
+# define USE_PKCS11_PROVIDER
+# include <openssl/provider.h>
+# include <openssl/store.h>
+#else
+# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
+#  define USE_PKCS11_ENGINE
+#  include <openssl/engine.h>
+# endif
+#endif
 #include "ssl-common.h"
 
-/*
- * OpenSSL 3.0 deprecates the OpenSSL's ENGINE API.
- *
- * Remove this if/when that API is no longer used
- */
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-
 /*
  * Use CMS if we have openssl-1.0.0 or newer available - otherwise we have to
  * assume that it's not available and its header file is missing and that we
@@ -106,28 +107,64 @@ static int pem_pw_cb(char *buf, int len, int w, void *v)
 	return pwlen;
 }
 
+static EVP_PKEY *read_private_key_pkcs11(const char *private_key_name)
+{
+	EVP_PKEY *private_key = NULL;
+#ifdef USE_PKCS11_PROVIDER
+	OSSL_STORE_CTX *store;
+
+	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
+		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
+	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
+		ERR(1, "OSSL_PROVIDER_try_load(default)");
+
+	store = OSSL_STORE_open(private_key_name, NULL, NULL, NULL, NULL);
+	ERR(!store, "OSSL_STORE_open");
+
+	while (!OSSL_STORE_eof(store)) {
+		OSSL_STORE_INFO *info = OSSL_STORE_load(store);
+
+		if (!info) {
+			drain_openssl_errors(__LINE__, 0);
+			continue;
+		}
+		if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY) {
+			private_key = OSSL_STORE_INFO_get1_PKEY(info);
+			ERR(!private_key, "OSSL_STORE_INFO_get1_PKEY");
+		}
+		OSSL_STORE_INFO_free(info);
+		if (private_key)
+			break;
+	}
+	OSSL_STORE_close(store);
+#elif defined(USE_PKCS11_ENGINE)
+	ENGINE *e;
+
+	ENGINE_load_builtin_engines();
+	drain_openssl_errors(__LINE__, 1);
+	e = ENGINE_by_id("pkcs11");
+	ERR(!e, "Load PKCS#11 ENGINE");
+	if (ENGINE_init(e))
+		drain_openssl_errors(__LINE__, 1);
+	else
+		ERR(1, "ENGINE_init");
+	if (key_pass)
+		ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0), "Set PKCS#11 PIN");
+	private_key = ENGINE_load_private_key(e, private_key_name, NULL, NULL);
+	ERR(!private_key, "%s", private_key_name);
+#else
+	fprintf(stderr, "no pkcs11 engine/provider available\n");
+	exit(1);
+#endif
+	return private_key;
+}
+
 static EVP_PKEY *read_private_key(const char *private_key_name)
 {
-	EVP_PKEY *private_key;
-
 	if (!strncmp(private_key_name, "pkcs11:", 7)) {
-		ENGINE *e;
-
-		ENGINE_load_builtin_engines();
-		drain_openssl_errors(__LINE__, 1);
-		e = ENGINE_by_id("pkcs11");
-		ERR(!e, "Load PKCS#11 ENGINE");
-		if (ENGINE_init(e))
-			drain_openssl_errors(__LINE__, 1);
-		else
-			ERR(1, "ENGINE_init");
-		if (key_pass)
-			ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0),
-			    "Set PKCS#11 PIN");
-		private_key = ENGINE_load_private_key(e, private_key_name,
-						      NULL, NULL);
-		ERR(!private_key, "%s", private_key_name);
+		return read_private_key_pkcs11(private_key_name);
 	} else {
+		EVP_PKEY *private_key;
 		BIO *b;
 
 		b = BIO_new_file(private_key_name, "rb");
@@ -136,9 +173,9 @@ static EVP_PKEY *read_private_key(const char *private_key_name)
 						      NULL);
 		ERR(!private_key, "%s", private_key_name);
 		BIO_free(b);
-	}
 
-	return private_key;
+		return private_key;
+	}
 }
 
 static X509 *read_x509(const char *x509_name)

-- 
2.56.1

