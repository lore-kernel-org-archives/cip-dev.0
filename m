Received: from mail-ej2-f3.google.com (mail-ej2-f3.google.com [74.125.228.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12612.1794488353328205070
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2026 04:59:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fairphone.com header.s=fair header.b=5pkD0xe1;
 spf=pass (domain: fairphone.com, ip: 74.125.228.131, mailfrom: luca.weiss@fairphone.com)
Received: by mail-ej2-f3.google.com with SMTP id a640c23a62f3a-c50485c0cb8so170167466b.0
        for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 04:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794488351; x=1795093151; darn=lists.cip-project.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gt3zlIOqmzGm5Db219SO3epyXaLzlbmsmJHfpNTAouc=;
        b=5pkD0xe1v/HuOmeqttQ7OySDt/hev6etvwZcNBPwDOJXjy30qWLFiQIOFYj8tuO2e1
         fyLph9von635+Gf8g0kQuMQR1A4EnOaKz336Cg+kNn1hAzYw2hvmYnH+dG48MIgllt4o
         C9WGVUogrOn+A5H2CsgZEh0YS8FsCPcAIukZnsGKxk71+0Erv4+aa2oLRgExD5LuHpPK
         5Raf5UV1Hpq0geMnLhy3uEbBiEyW99RlvxXI46wo8KHRrfzG0xmwKTYo0O/Ry3cpZnem
         Ol37SrnAvMziHU8i4Quw5RdCX1kFrsF4wz0JjzvtWhqWggE0nS0b727j7Q6cdts2gVoU
         ne7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794488351; x=1795093151;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gt3zlIOqmzGm5Db219SO3epyXaLzlbmsmJHfpNTAouc=;
        b=Ad2L4CpB/Wq6xouzz4V/4ZL9McBiISZx6czf0m0AGTMLSjVyW/7/FuWVwx9Ay4icRk
         0j4Bk0RzbimXCM+xCbMUUyvJw86tBMDqyMrmatAbofGlLnALnxsRTwCcDJyXVXDtBTgK
         NXvURqGeTW0SBAq5vdN3tvmJU6S46sTqe/NS75ZYYMSiL/AjiUPX60jGPy8LWQAkPpYS
         vD4FizyPl4por9FQYt+uxzi+2i8PoYCTQAs0/zyKgSBAkQyA2jLSEHuAYy4f67wy0yYk
         tkkSAHUnOXV4Tjqz/x2n/88IGwfivMeMApphs6sEx2MM54K40U7vSPugZtNiuwKn8Qg9
         QTxg==
X-Gm-Message-State: APuU4Z86sK8IRdxHRvNfjUPyK1KT8qloKBh4rIVdwKOcj3jm0wo3EIol
	0DbkT7ory24mp5DR0eXNKarTO6FUFRLQq0OlDk0IHYlYWk8G1k+hYWsV+0/JywyQ+1VRKp9whVF
	rzqtM99Kl2A==
X-Gm-Gg: AYBFou0u9XlskHTdm2TzmfCqxYXvicCF+ezWd0rIx3BKyM9hx+/etNCO7K8gQeFAbzG
	Ietomn9FtK0A5TWk1wpqRP9Xe7dZKhw1szn60gqaNOR02M5wosakrgO2zWjfVBlFb72hUDw9Hq/
	tb6dLJm5TMJSeHAD2E9VoLdWXjh9K3kkgrOAyVXFOmIIYm2n+5ce/tOsWSxWPJzRzufVRZqQjnr
	snARCTdXj2Z7GQQoRLejW5a3ITjHW0rAArjfRELFeCrlfJwiBs6B+BOUkQG2zY//4lSzXd2tFwp
	sdCJYaG/kRQ1IfwjJmcqB6jGrm9gmKbefR+AA9gG7O+wZSCxewLl7YucIyPePfKcb0Y3FzyQo8K
	FwzK6s+SFGya+SE+rP1zpC1f8odXDeNhNPs3a3Q/loAxMu/2rTA0bAt46hGo2GrrH46Rg1TlluQ
	tv4ZbWRnGF741/WPgkRLgFEajOHf9tyDKgnp9qBu1HkqoYjLCXkq8LRRr9bM6Zd1wgEZX1wxqtX
	Y5Cf3J5IIfAzSxH8LCMjN91SITFzuySLpZnVa3lG+OUWoKmC+cHJMTO2uuobFV4CF+X808NWoCa
	VSeVINkW1u/P5i71P/24093w2Mak8hio/7zT4+OU/HmAJZr/+YzoBvBpls1QcJR688HFIq4lG0r
	lVudA4Zc=
X-Received: by 2002:a17:907:968e:b0:c37:8c7c:a840 with SMTP id a640c23a62f3a-c5066ad0a38mr458781766b.18.1794487854267;
        Thu, 12 Nov 2026 04:50:54 -0800 (PST)
Return-Path: <luca.weiss@fairphone.com>
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a63f8bbsm336768666b.60.2026.11.12.04.50.53
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:50:54 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 12 Nov 2026 13:50:45 +0100
Subject: [PATCH 4.19.y-cip 4/4] extract-cert: Wrap key_pass with '#ifdef USE_PKCS11_ENGINE'
MIME-Version: 1.0
Message-Id: <20261112-openssl4-419cip-v1-4-2f56859669bb@fairphone.com>
References: <20261112-openssl4-419cip-v1-0-2f56859669bb@fairphone.com>
In-Reply-To: <20261112-openssl4-419cip-v1-0-2f56859669bb@fairphone.com>
To: cip-dev@lists.cip-project.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794487852; l=2338;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=rLYFj+u00+QOm3MPdK+q7SUXUpD8KFg+HpJ2SH0G3RI=;
 b=gm64jlNT09w3Ieln9V9vxiGL6zBU6bAodjDYomCPj+BuVawk19ZmtrI3K/3CF+KrCujXvG2eV
 NXfjaejayfTBYz1SfS9u5n7U4YQyZjuyeG9NiG1j+o8rjNmD+52XtKt
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 07:57:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24818

From: Nathan Chancellor <nathan@kernel.org>

commit 4f96b7c68a9904e01049ef610d701b382dca9574 upstream.

A recent strengthening of -Wunused-but-set-variable (enabled with -Wall)
in clang under a new subwarning, -Wunused-but-set-global, points out an
unused static global variable in certs/extract-cert.c:

  certs/extract-cert.c:46:20: error: variable 'key_pass' set but not used [-Werror,-Wunused-but-set-global]
     46 | static const char *key_pass;
        |                    ^

After commit 558bdc45dfb2 ("sign-file,extract-cert: use pkcs11 provider
for OPENSSL MAJOR >= 3"), key_pass is only used with the OpenSSL engine
API, not the new provider API. Wrap key_pass's declaration and
assignment with '#ifdef USE_PKCS11_ENGINE' so that it is only included
with its use to clear up the warning. While this is a little uglier than
just marking key_pass with the unused attribute, this will make it
easier to clean up all code associated with the use of the engine API if
it were ever removed in the future. While in the area, use a tab for
the key_pass assignment line to match the rest of the file.

Cc: stable@vger.kernel.org
Fixes: 558bdc45dfb2 ("sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3")
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://patch.msgid.link/20260325-certs-extract-cert-key_pass-unused-but-set-global-v1-1-ecf94326d532@kernel.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 scripts/extract-cert.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/extract-cert.c b/scripts/extract-cert.c
index 73364ed31fd2..21d5013a367b 100644
--- a/scripts/extract-cert.c
+++ b/scripts/extract-cert.c
@@ -43,7 +43,9 @@ void format(void)
 	exit(2);
 }
 
+#ifdef USE_PKCS11_ENGINE
 static const char *key_pass;
+#endif
 static BIO *wb;
 static char *cert_dst;
 int kbuild_verbose;
@@ -132,7 +134,9 @@ int main(int argc, char **argv)
 
 	kbuild_verbose = atoi(getenv("KBUILD_VERBOSE")?:"0");
 
-        key_pass = getenv("KBUILD_SIGN_PIN");
+#ifdef USE_PKCS11_ENGINE
+	key_pass = getenv("KBUILD_SIGN_PIN");
+#endif
 
 	if (argc != 3)
 		format();

-- 
2.56.1

