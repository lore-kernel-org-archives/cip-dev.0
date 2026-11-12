Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12536.1794488184150836614
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2026 04:56:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fairphone.com header.s=fair header.b=vzuZl6+q;
 spf=pass (domain: fairphone.com, ip: 209.85.128.53, mailfrom: luca.weiss@fairphone.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so50084765e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 04:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794488182; x=1795092982; darn=lists.cip-project.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gnFpkWzGD3KJ0CuAAzxXHjO4uGYX4peowQwxJqpo+VY=;
        b=vzuZl6+qm8WntXTHKDUTQ9Za2FrpKk+46WKDtS68P1JgnXcyu/xQBD8sugoDOLCaV5
         XxmvbZidukxB0IFecAmYcnISmK3GFOXyhGuedr+61YgYbITdLqLVpcMNVg6bl/+dHBQg
         jTQnGL2AmCq/yU8jHbBvsabZM/Q96SQ6liA/C1z56QwP15P5QYf+WkSZYDjChe/jKhgi
         raBv8M10x+zYh/SS11D+DviGERJxY9E0hW/9TA9JeiF7iN7Y6rJqFt2/hnDU0mafCGXg
         WQPS+ECv9H6q7042+/wYjt3iPaMrfhDjhRjn+d84UNDZb4Q0AP+NsA2ZqutnCeB9tmpq
         iITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794488182; x=1795092982;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gnFpkWzGD3KJ0CuAAzxXHjO4uGYX4peowQwxJqpo+VY=;
        b=1r8QgKVLRO0CmFXOryjhkrUCIUJFEJerqpfYQshBRCeUvUmD8xXkEwIEbQKuh9ft0f
         UdRPKLRH5nYdljTR7/c4+WrO0thAlLdKLzXZ25+3gcmpj5Fw8mQpvNnUG36j14rfyx01
         gp6Uv0rvS7uCdseD4zP5yweKcOOTxlcmCSKiurT7FDp7eHo1mxifV/ZNMufcIvoiU79k
         Rx8QK0ephQI/GIX6PO9Eqy9I2QqDV7n4TRYXEcIYF2w2oKYxmi/Lp6K+DdXiQKdwQ1s7
         pLyAXKScFRKVWtnf9o4OM/bjNaPHsLdKvB83/ZXkCwV0hcsgukbaeOmcRvj5wbPRAb+i
         KY3A==
X-Gm-Message-State: APuU4Z9XzRPAW8ssAb4pLJ7ZvwVxYjCIbmoq33JJXFNnUMsh9b3BOtfX
	M63lMK++Wj0g4ARuL8msOtomsmx2u8aJwCRiPa8P7iLUQ4b4Ck1WohSH/tGy/gFKbzLb0xQExhS
	LmKRk7j8=
X-Gm-Gg: AYBFou18kUL3pP/uGLgVac1t5i9QEdELMRz+l98SLYfRYkCfypk17aE7cZXbpO54SZb
	5Xv60AdW9BA3kVNS5pI336gPKzJOkOtCogtqyTH4F8aJuu32ZsawhB7sFeb7bjPy7NAjn8Gf6vw
	sIVLY//ucW0kLU3DMprRtOOovkD3RSIhkvx8Vf+ETrsBAiWv3NTu8H0wVQEs504p6niDHdfBAd7
	MpdfzCoIPoHbGeHQBu8DQaIbrHda3MeTcMj0yL71CqZgrgQblaXFQJoqCzf/hYb4hBWE21ZRvjF
	QEqxnvw6noOkqqgT/j0sBMyK8E74CzonSF/OKbZSwlVmCI3sRR7veBL0K0ZRuuuw18+tFP11Nhj
	NezDc10bSmUtFV0Ze9+giBYEAex3N/i9CrEd3rAKQquRcVQAFYZrKijq9jWWvYYdIre608DoEeV
	lUcZ+4Tl7lj7gLNY9FsOf9b3kJyvRtx4zoaFc9k+cbYxbi7nQPzP6KARjEttpx6NV18TruQhkti
	BBqHy8r1Ra1XAh8YAlcQ8EgFkoay9LV4RrUtdws9xWEwu1tniUiQaSc30m9dMvymxW9rQykU22H
	TSKdEbnkkxaSJj/LE7yp4NMLKETKh9pJENCxWAQIdDq/WLvxm2FwbBBeBld0NNyBxPats4Z9Ylw
	zWA6Z+G4LU4dzqYVtuPS7juxpkKoO
X-Received: by 2002:a17:906:c103:b0:c4c:ddd1:cffa with SMTP id a640c23a62f3a-c5066b4301emr419500366b.29.1794487853370;
        Thu, 12 Nov 2026 04:50:53 -0800 (PST)
Return-Path: <luca.weiss@fairphone.com>
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a63f8bbsm336768666b.60.2026.11.12.04.50.53
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:50:53 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 12 Nov 2026 13:50:43 +0100
Subject: [PATCH 4.19.y-cip 2/4] sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
MIME-Version: 1.0
Message-Id: <20261112-openssl4-419cip-v1-2-2f56859669bb@fairphone.com>
References: <20261112-openssl4-419cip-v1-0-2f56859669bb@fairphone.com>
In-Reply-To: <20261112-openssl4-419cip-v1-0-2f56859669bb@fairphone.com>
To: cip-dev@lists.cip-project.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794487852; l=3673;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=WglCa27hory5nyi3b6F73EXgYM+uhEgW5YzVWVRyin0=;
 b=ld4iqU7XoAn2oMBP6ripHEXl6tzs66GWfeJCcxvODLM8oO08YaL9uJROmKU5Arcbp6pTl/0hm
 sK6SH3r4b4UDUmuVYeA0xWhwSrBRJMBKu6KEWXH+DnoMG+N6c5051vR
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 07:56:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24813

From: Jan Stancek <jstancek@redhat.com>

commit 467d60eddf55588add232feda325da7215ddaf30 upstream.

ERR_get_error_line() is deprecated since OpenSSL 3.0.

Use ERR_peek_error_line() instead, and combine display_openssl_errors()
and drain_openssl_errors() to a single function where parameter decides
if it should consume errors silently.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 scripts/extract-cert.c |  4 ++--
 scripts/sign-file.c    |  6 +++---
 scripts/ssl-common.h   | 23 ++++++++---------------
 3 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/scripts/extract-cert.c b/scripts/extract-cert.c
index 44c1bf031c9b..f54644f74e37 100644
--- a/scripts/extract-cert.c
+++ b/scripts/extract-cert.c
@@ -96,11 +96,11 @@ int main(int argc, char **argv)
 		parms.cert = NULL;
 
 		ENGINE_load_builtin_engines();
-		drain_openssl_errors();
+		drain_openssl_errors(__LINE__, 1);
 		e = ENGINE_by_id("pkcs11");
 		ERR(!e, "Load PKCS#11 ENGINE");
 		if (ENGINE_init(e))
-			drain_openssl_errors();
+			drain_openssl_errors(__LINE__, 1);
 		else
 			ERR(1, "ENGINE_init");
 		if (key_pass)
diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 39ba58db5d4e..bb3fdf1a617c 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -114,11 +114,11 @@ static EVP_PKEY *read_private_key(const char *private_key_name)
 		ENGINE *e;
 
 		ENGINE_load_builtin_engines();
-		drain_openssl_errors();
+		drain_openssl_errors(__LINE__, 1);
 		e = ENGINE_by_id("pkcs11");
 		ERR(!e, "Load PKCS#11 ENGINE");
 		if (ENGINE_init(e))
-			drain_openssl_errors();
+			drain_openssl_errors(__LINE__, 1);
 		else
 			ERR(1, "ENGINE_init");
 		if (key_pass)
@@ -273,7 +273,7 @@ int main(int argc, char **argv)
 
 		/* Digest the module data. */
 		OpenSSL_add_all_digests();
-		display_openssl_errors(__LINE__);
+		drain_openssl_errors(__LINE__, 0);
 		digest_algo = EVP_get_digestbyname(hash_algo);
 		ERR(!digest_algo, "EVP_get_digestbyname");
 
diff --git a/scripts/ssl-common.h b/scripts/ssl-common.h
index e6711c75ed91..2db0e181143c 100644
--- a/scripts/ssl-common.h
+++ b/scripts/ssl-common.h
@@ -3,7 +3,7 @@
  * SSL helper functions shared by sign-file and extract-cert.
  */
 
-static void display_openssl_errors(int l)
+static void drain_openssl_errors(int l, int silent)
 {
 	const char *file;
 	char buf[120];
@@ -11,28 +11,21 @@ static void display_openssl_errors(int l)
 
 	if (ERR_peek_error() == 0)
 		return;
-	fprintf(stderr, "At main.c:%d:\n", l);
+	if (!silent)
+		fprintf(stderr, "At main.c:%d:\n", l);
 
-	while ((e = ERR_get_error_line(&file, &line))) {
+	while ((e = ERR_peek_error_line(&file, &line))) {
 		ERR_error_string(e, buf);
-		fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
+		if (!silent)
+			fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
+		ERR_get_error();
 	}
 }
 
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
 #define ERR(cond, fmt, ...)				\
 	do {						\
 		bool __cond = (cond);			\
-		display_openssl_errors(__LINE__);	\
+		drain_openssl_errors(__LINE__, 0);	\
 		if (__cond) {				\
 			errx(1, fmt, ## __VA_ARGS__);	\
 		}					\

-- 
2.56.1

