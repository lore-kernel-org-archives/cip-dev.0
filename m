Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D5CC4828F
	for <webhook@archiver.kernel.org>; Thu,  8 Feb 2024 10:23:26 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.14798.1707387799427382135
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Feb 2024 02:23:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=HNLAhUIy;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20240208102315133cd02db8b0db2995-7k1t7a@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240208102315133cd02db8b0db2995
        for <cip-dev@lists.cip-project.org>;
        Thu, 08 Feb 2024 11:23:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=fB/VSxTKRDuhmCQcDadD/s/dmrq1N39EXg1YZkv+VYM=;
 b=HNLAhUIyv/eH+an04B9NkT0Q/xNpyOdSihVfgqbI00snPigP5jAw7OyQps79KIJaeTVcW/
 Tx0qzi4wJAXtUye6uu1Okm/xHvch7VW7cEyTqu8WvoMCBG2I2/A3BqfdqX2sfhCt++bXxHUR
 aJflUlC9+stxSCzyC2IwwweKcLkPo=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [PATCH] Update certificates for sid
Date: Thu,  8 Feb 2024 11:22:43 +0100
Message-ID: <20240208102314.169456-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Feb 2024 10:23:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14918

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Debian updated the snakeoil certificate[1].

[1]: https://salsa.debian.org/qemu-team/edk2/-/commit/892a23a65fc397c784bc905b4235f7efede102a3

This fixes issue #97

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/97

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../secure-boot-secrets/files/sid             |  1 -
 .../files/sid/PkKek-1-snakeoil.key            | 27 +++++++++++++++++++
 .../files/sid/PkKek-1-snakeoil.pem            | 23 ++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)
 delete mode 120000 recipes-devtools/secure-boot-secrets/files/sid
 create mode 100644 recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.key
 create mode 100644 recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.pem

diff --git a/recipes-devtools/secure-boot-secrets/files/sid b/recipes-devtools/secure-boot-secrets/files/sid
deleted file mode 120000
index 91bf492..0000000
--- a/recipes-devtools/secure-boot-secrets/files/sid
+++ /dev/null
@@ -1 +0,0 @@
-bullseye
\ No newline at end of file
diff --git a/recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.key b/recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.key
new file mode 100644
index 0000000..193de62
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.key
@@ -0,0 +1,27 @@
+-----BEGIN RSA PRIVATE KEY-----
+MIIEowIBAAKCAQEAyIuuXei5qIw+UvavLxPyyNhx0G6Ijuf9SqxVXOpKcQ+l3ZCc
+KQaCLWCH0pbPQj587zVjgMUd4SHgXdVP6awDz8b0NcLgyzF31pHBmmB3z55nv2Jb
+gI56bix9TEHLpoDs4+cWAb2WZPkW8rV/6YR+xVuE8fi9aAWJ7H4dwUhPzU7RBB1d
+Z1wF6Wv3b8nn1jJa5W8I3zOd+tpWczOsqyRnDnFhMiOulGAiFTtmIXv2VReQf7Tx
+rXdqAAs9dcS3qizzNVgY5XpABtmYu1AjyLwwqXZ+blZ2tmUUJicgw3YdCWtlTAtf
+XZDHf+ZzgCNtTvhb2DzpAVmF/H+A8w8lUJZiBQIDAQABAoIBABET/BRZNj5JOyF7
+im2a6Ej8TazvTMfGr8ZFKLvR4+b+6yQUJYhE2p8colRnrVy5z4/bXw7fOm0qol27
+RaPjlyuBiNhvMQ98tfTa0r7fyjQvDCy7JomrGHf7Z+wvijUys3mw+ynIyF7u62pd
+1HfBZb5OzeKBSTfriNRP5R7JlqooDl+O9JVlnvlJIaFe1rX2sQxZ7F8gVINKIJDv
+n7ZZ0o351uIMjKLqwmliULPTjZ2ZeeJqnkB0pFcWZzEf2wAnrrglYRdnn10oNzhB
+6cXMHJeuEOedXECLZtmynRw1dWZK9+Xku1jEAqTWAoI0OIjrfYYzntwe/kab8w/R
+T7ojFGECgYEA9rGhtmSQiim2h+3iGyXNTEQiEOFFL7E8/1ibfWi3vzDhoLARrnH1
+p45DPgnL664xLHXIUl6/wto79Ij/2qA9mp054nVJ4X4AQgq3xCT/57nL0QHfQLaa
+VdzNIoz4jJT3cO0gYcBAK4Bg+dGGQ6ZUrRRt6VkHG/W6fW0D1e7PnEkCgYEA0Bxj
+Jr4ShNXb7J4YDQ24uSwmc2E1IgX5FjHu/JMKCiyIDWQkrxtVdIL9v6+kmYecyxFJ
+S3Qyr3ZqOHqwN1svYuB/CHyKg6dHrzJyZFTj8cr8h0ZKLDu2xZNFxfBIjn5vitSX
+W9q3477oFG/30Ew12Yee4NhDQkaEuB/Ic9+yv90CgYB2y00rLrwnvDSIunXiSs7U
+xg59gG03rSrJb5rYxj+NkvVj0sWA8qGwASLCUidfo69MUJ+ZgsTnCP5MIFjMp9Ni
+jAne0ko0it+G7fBWRNbyeJb8W+FtIUGqzTv/QlFCKU4KlDW+vLxp9lU8l7gHBabK
+/gZ7kwKIZUlbss5hC7Hv+QKBgQCsQBLBKmlhkTEqs9/sTgMrISPiM/8qXg9BE6tf
+WsTgjuM9UjoaxWEBwroMQnDWsqxQV8p2rYKWQEjC3qmj59Fc4bvDZnGvbnGizPpp
+mOniY8SIouEZo4MwHSmPH8auSnBAVJ3C5VF3K7gj0lknCy03E02phNaGsJ+BVq0v
+W2Qz8QKBgEB5RKiwJhgGQA2o+NJKKUUCDM9iBsO1Yy3QwtDWioKKcdAkxdTg3xR+
+XtJdXq6MkCMWM5em3v6GHPceexn81FZTxGBbIMBYNp0Sp4qs/3lK64ln8m5Qttxe
+70HVtrp9HhG5oFJ3fUuLPcYpE2GMgPM9fIbAWh9GZ4GpTLuPRtWg
+-----END RSA PRIVATE KEY-----
diff --git a/recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.pem b/recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.pem
new file mode 100644
index 0000000..7cd2487
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.pem
@@ -0,0 +1,23 @@
+-----BEGIN CERTIFICATE-----
+MIID1zCCAr+gAwIBAgIUDMG7xGGEPj+ABvbflim0PNb/loowDQYJKoZIhvcNAQEL
+BQAwejELMAkGA1UEBhMCVVMxETAPBgNVBAgMCENvbG9yYWRvMRUwEwYDVQQHDAxG
+b3J0IENvbGxpbnMxETAPBgNVBAoMCFNuYWtlT2lsMS4wLAYDVQQDDCVTbmFrZU9p
+bCBUZXN0IEtleSBmb3IgRUZJIFNlY3VyZSBCb290MCAXDTIzMDUxOTIzMTE0NVoY
+DzIwNTMwNTE3MjMxMTQ1WjB6MQswCQYDVQQGEwJVUzERMA8GA1UECAwIQ29sb3Jh
+ZG8xFTATBgNVBAcMDEZvcnQgQ29sbGluczERMA8GA1UECgwIU25ha2VPaWwxLjAs
+BgNVBAMMJVNuYWtlT2lsIFRlc3QgS2V5IGZvciBFRkkgU2VjdXJlIEJvb3QwggEi
+MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDIi65d6LmojD5S9q8vE/LI2HHQ
+boiO5/1KrFVc6kpxD6XdkJwpBoItYIfSls9CPnzvNWOAxR3hIeBd1U/prAPPxvQ1
+wuDLMXfWkcGaYHfPnme/YluAjnpuLH1MQcumgOzj5xYBvZZk+RbytX/phH7FW4Tx
++L1oBYnsfh3BSE/NTtEEHV1nXAXpa/dvyefWMlrlbwjfM5362lZzM6yrJGcOcWEy
+I66UYCIVO2Yhe/ZVF5B/tPGtd2oACz11xLeqLPM1WBjlekAG2Zi7UCPIvDCpdn5u
+Vna2ZRQmJyDDdh0Ja2VMC19dkMd/5nOAI21O+FvYPOkBWYX8f4DzDyVQlmIFAgMB
+AAGjUzBRMB0GA1UdDgQWBBRjuNXuXfh7mi8I3eTboeYGyFTa2zAfBgNVHSMEGDAW
+gBRjuNXuXfh7mi8I3eTboeYGyFTa2zAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3
+DQEBCwUAA4IBAQBBxlfo6MxBN44mXBIhE/QUbJZ+bo/Vrqv2DIZqOlV5+Sk6KnK8
+X9Rz2IJwoqLjB6cW9yInk5P/QS45880K1fDT/lu5/2U64i3l1ZFK75qLDCn4/khF
+birV2U6LBZpxLe3UvXk3xZMoUPzvT2rhrsf78G0pSmAnP8li8Co8F6hTjQzB8IgC
+DpYVATCoWBH6GhudtjUp+CJSyGApdL+HKX6i6oD7vutvWYBf0Hx5r1NrqIv31Y4V
+bhwvK5zajFamj/VYeVy7/roqD06hNF1ImhsuBOqoJlKu+cHMGN9DOJqjGup1T9aI
+2dpEOK5vbKXFrox/yCLgXmUkdwZ3BK4lcxCq
+-----END CERTIFICATE-----
-- 
2.43.0


