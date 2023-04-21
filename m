Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80073C77B76
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 14:23:42 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.13267.1682087017520335886
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 07:23:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=ev1vUpRI;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20230421142334ac584320e6c1dcfbfc-fs1imw@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230421142334ac584320e6c1dcfbfc
        for <cip-dev@lists.cip-project.org>;
        Fri, 21 Apr 2023 16:23:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=XSH9pZ0bvaskuPvePHGGT0aUvyqjBQRHwsRd8nLUM5o=;
 b=ev1vUpRIwvazd0rn+W0tW7/8GO7Hve8kzJWx4uvPaR2QZ5C4LdA4YMjOpnDcmTqXXfLbFV
 Ov6aeCBt8KhCHQ7rKiK2o9ZL/7FOtr3OIv1aztyySih8rxQ8CPEO2PlpD3mjwCjkM3lP0MyC
 z+Bt1Ss47Uwu2XJ+zPk8zqKQT13GQ=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 1/4] secure-boot-secrets: Use distro specific snakeoil certs and keys
Date: Fri, 21 Apr 2023 16:23:30 +0200
Message-Id: <20230421142333.3906250-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230421142333.3906250-1-Quirin.Gylstorff@siemens.com>
References: <20230421142333.3906250-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 14:23:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11316

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes the boot of Debian buster(10) with secure boot enabled.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/bookworm/PkKek-1-snakeoil.key       | 28 +++++++++++++++++++
 .../files/{ => bookworm}/PkKek-1-snakeoil.pem |  0
 .../files/{ => bullseye}/PkKek-1-snakeoil.key |  0
 .../files/bullseye/PkKek-1-snakeoil.pem       | 21 ++++++++++++++
 .../files/buster/PkKek-1-snakeoil.key         | 28 +++++++++++++++++++
 .../files/buster/PkKek-1-snakeoil.pem         | 19 +++++++++++++
 .../secure-boot-snakeoil_0.1.bb               |  4 +--
 7 files changed, 98 insertions(+), 2 deletions(-)
 create mode 100644 recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.key
 rename recipes-devtools/secure-boot-secrets/files/{ => bookworm}/PkKek-1-snakeoil.pem (100%)
 rename recipes-devtools/secure-boot-secrets/files/{ => bullseye}/PkKek-1-snakeoil.key (100%)
 create mode 100644 recipes-devtools/secure-boot-secrets/files/bullseye/PkKek-1-snakeoil.pem
 create mode 100644 recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.key
 create mode 100644 recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.pem

diff --git a/recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.key b/recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.key
new file mode 100644
index 0000000..24a5837
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.key
@@ -0,0 +1,28 @@
+-----BEGIN PRIVATE KEY-----
+MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDIi65d6LmojD5S
+9q8vE/LI2HHQboiO5/1KrFVc6kpxD6XdkJwpBoItYIfSls9CPnzvNWOAxR3hIeBd
+1U/prAPPxvQ1wuDLMXfWkcGaYHfPnme/YluAjnpuLH1MQcumgOzj5xYBvZZk+Rby
+tX/phH7FW4Tx+L1oBYnsfh3BSE/NTtEEHV1nXAXpa/dvyefWMlrlbwjfM5362lZz
+M6yrJGcOcWEyI66UYCIVO2Yhe/ZVF5B/tPGtd2oACz11xLeqLPM1WBjlekAG2Zi7
+UCPIvDCpdn5uVna2ZRQmJyDDdh0Ja2VMC19dkMd/5nOAI21O+FvYPOkBWYX8f4Dz
+DyVQlmIFAgMBAAECggEAERP8FFk2Pkk7IXuKbZroSPxNrO9Mx8avxkUou9Hj5v7r
+JBQliETanxyiVGetXLnPj9tfDt86bSqiXbtFo+OXK4GI2G8xD3y19NrSvt/KNC8M
+LLsmiasYd/tn7C+KNTKzebD7KcjIXu7ral3Ud8Flvk7N4oFJN+uI1E/lHsmWqigO
+X470lWWe+UkhoV7WtfaxDFnsXyBUg0ogkO+ftlnSjfnW4gyMourCaWJQs9ONnZl5
+4mqeQHSkVxZnMR/bACeuuCVhF2efXSg3OEHpxcwcl64Q551cQItm2bKdHDV1Zkr3
+5eS7WMQCpNYCgjQ4iOt9hjOe3B7+RpvzD9FPuiMUYQKBgQD2saG2ZJCKKbaH7eIb
+Jc1MRCIQ4UUvsTz/WJt9aLe/MOGgsBGucfWnjkM+CcvrrjEsdchSXr/C2jv0iP/a
+oD2anTnidUnhfgBCCrfEJP/nucvRAd9AtppV3M0ijPiMlPdw7SBhwEArgGD50YZD
+plStFG3pWQcb9bp9bQPV7s+cSQKBgQDQHGMmvhKE1dvsnhgNDbi5LCZzYTUiBfkW
+Me78kwoKLIgNZCSvG1V0gv2/r6SZh5zLEUlLdDKvdmo4erA3Wy9i4H8IfIqDp0ev
+MnJkVOPxyvyHRkosO7bFk0XF8EiOfm+K1Jdb2rfjvugUb/fQTDXZh57g2ENCRoS4
+H8hz37K/3QKBgHbLTSsuvCe8NIi6deJKztTGDn2AbTetKslvmtjGP42S9WPSxYDy
+obABIsJSJ1+jr0xQn5mCxOcI/kwgWMyn02KMCd7SSjSK34bt8FZE1vJ4lvxb4W0h
+QarNO/9CUUIpTgqUNb68vGn2VTyXuAcFpsr+BnuTAohlSVuyzmELse/5AoGBAKxA
+EsEqaWGRMSqz3+xOAyshI+Iz/ypeD0ETq19axOCO4z1SOhrFYQHCugxCcNayrFBX
+ynatgpZASMLeqaPn0Vzhu8Nmca9ucaLM+mmY6eJjxIii4RmjgzAdKY8fxq5KcEBU
+ncLlUXcruCPSWScLLTcTTamE1oawn4FWrS9bZDPxAoGAQHlEqLAmGAZADaj40kop
+RQIMz2IGw7VjLdDC0NaKgopx0CTF1ODfFH5e0l1eroyQIxYzl6be/oYc9x57GfzU
+VlPEYFsgwFg2nRKniqz/eUrriWfyblC23F7vQdW2un0eEbmgUnd9S4s9xikTYYyA
+8z18hsBaH0ZngalMu49G1aA=
+-----END PRIVATE KEY-----
diff --git a/recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.pem b/recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.pem
similarity index 100%
rename from recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.pem
rename to recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.pem
diff --git a/recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.key b/recipes-devtools/secure-boot-secrets/files/bullseye/PkKek-1-snakeoil.key
similarity index 100%
rename from recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.key
rename to recipes-devtools/secure-boot-secrets/files/bullseye/PkKek-1-snakeoil.key
diff --git a/recipes-devtools/secure-boot-secrets/files/bullseye/PkKek-1-snakeoil.pem b/recipes-devtools/secure-boot-secrets/files/bullseye/PkKek-1-snakeoil.pem
new file mode 100644
index 0000000..dd02a82
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/bullseye/PkKek-1-snakeoil.pem
@@ -0,0 +1,21 @@
+-----BEGIN CERTIFICATE-----
+MIIDdzCCAl+gAwIBAgIULTs+L+8XzClMGhAvyFIdsp/PYgUwDQYJKoZIhvcNAQEL
+BQAwSjELMAkGA1UEBhMCVVMxETAPBgNVBAgMCENvbG9yYWRvMRUwEwYDVQQHDAxG
+b3J0IENvbGxpbnMxETAPBgNVBAoMCFNuYWtlT2lsMCAXDTIwMDkwNzE4NDMyMloY
+DzIxMjAwODE0MTg0MzIyWjBKMQswCQYDVQQGEwJVUzERMA8GA1UECAwIQ29sb3Jh
+ZG8xFTATBgNVBAcMDEZvcnQgQ29sbGluczERMA8GA1UECgwIU25ha2VPaWwwggEi
+MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDIi65d6LmojD5S9q8vE/LI2HHQ
+boiO5/1KrFVc6kpxD6XdkJwpBoItYIfSls9CPnzvNWOAxR3hIeBd1U/prAPPxvQ1
+wuDLMXfWkcGaYHfPnme/YluAjnpuLH1MQcumgOzj5xYBvZZk+RbytX/phH7FW4Tx
++L1oBYnsfh3BSE/NTtEEHV1nXAXpa/dvyefWMlrlbwjfM5362lZzM6yrJGcOcWEy
+I66UYCIVO2Yhe/ZVF5B/tPGtd2oACz11xLeqLPM1WBjlekAG2Zi7UCPIvDCpdn5u
+Vna2ZRQmJyDDdh0Ja2VMC19dkMd/5nOAI21O+FvYPOkBWYX8f4DzDyVQlmIFAgMB
+AAGjUzBRMB0GA1UdDgQWBBRjuNXuXfh7mi8I3eTboeYGyFTa2zAfBgNVHSMEGDAW
+gBRjuNXuXfh7mi8I3eTboeYGyFTa2zAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3
+DQEBCwUAA4IBAQBW2ckn0APqBnwSiOXCWkMCnvY7K7UOfxAlotEsMFSrkzdEa4IE
+sn0+A3RV/r3HZGqIaE8GMsBqp8UiVIbL5H67dkqvJEke94/7wEUC16JSSOBc0Mac
+HeArDWsL/WIbzKiVcRrmgX+XwJFlsUN5UtR/feTHR08yiy5srSCIJEqli/cTrOxS
+JAgvWPLxcoFhOKf6Mi+nwWdrQEbpXvvv8Jv/qyyz5e/VmTRY0wIVmUjd+Yseu+5M
+3+cpKtlYaawMxVni5RibA0A12fm+i60fGPrkCNhascUrNY+Oppaf/h+QmKOwEM7h
+pqKXyGFQyU6dB6cFBQ/uD5IABUYuEOuL7VFY
+-----END CERTIFICATE-----
diff --git a/recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.key b/recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.key
new file mode 100644
index 0000000..b9e42c7
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.key
@@ -0,0 +1,28 @@
+-----BEGIN PRIVATE KEY-----
+MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDNQOknAPMOkujb
+K1VFKC39BZFiT9iNp7l9u6OK2rvddgu4Nn79Z/lTrOk5/J/Nf+XlHQoJX1dhQkXj
+tASY0KehamDdxF1GvL7cUhi12c0rXnUBnYvvg4jiwxfVqRIT4x9kWB08Vyb6fS4m
+BC69FgbJhpHo3XBuEn/aI45tr6xsrJxoqIvV9KOKnZyuIcD/TlxhKiZ1RP6tNRkA
+sV0JC45T6BfxGqGZ9ujxUQTsykTeeu8ehxAAWmHJiAbyNp2OCDKYTuxARkasGo6v
+AwMeK1umgY2U4jZV0WAvmNEoe4HrWIKSpOZJa5LiVs4QmaazqGFCdOe7/Irs7c0R
+Z6AA8yu1AgMBAAECggEBAKUb9THx+pObrAM6TYKvOqdSBkxubIYvCPDSs1EseXlB
+z1WlSOwx6ofcDVUfGbGmk9mFTaCSeGj9ddkg453GI0Ken0NmBZ60kFgNFmGazgd4
+GWluQbYvOjsnsxGlyqwCxSrkEsiKVwmjDy93p91lTZppTRBkqV9yNDTW62jiqzJT
+CzWimHWyPlK7MjfOyV/X/GD8rugr0F/ikugzVJXCIuhnO62ouU1Imo+Agb3jJM5h
+26CWerha8Nd6z6lvHM0g014gzL40JrxehqOkYp/6VF6qX37sTHyAw9J4RUQROC/L
+L+XYAAQZMv3GBJhkn6FOBlKuBmJLw01mTKXuNyGf1EECgYEA6cShh7uPJHeqqHpm
+ddt0DBgwFueH3pXPv1a6sDBt8P3PJ376p8X1QpoL30sZYc+cEXJcicoaq5NqrkJA
+NltHg00sHqyfEfaDS2sr38e5qWoD41BsFdbNmfe2SaunXmSZ7d/QD810l+UaRNCR
+doZcmeCFpcXRs0N1nc2C0w+Ya/ECgYEA4MYPCZ43lB1qeShUcaY/WFiWnJrNdoJR
+p9S7xhPAqpXmG19utc+geTvN+y8YqOVg1ICaXpfYV7BG7VdD3mLQTIxdai98Rl4r
+EBKrSGV6cyXkghaGeZHL2M9/FLxCZrfEpbzl82kacCJHCaiQiu9IVTsOabwoW68x
+Evfz1FHaEAUCgYAmPrc2n6bhjnprKetNaOPpfqOPe72s2tGsOiI85Q93l+6mRY34
+mNhxVwaON5kleXPNHuqo2FnYrDuN2uTqf7CJeLy5IAC+TZhZZGU/LUvgval5LRUh
+1Yy5nd9C2kR9mvPcCPvfOfvTRfYwP/csbvsDacozvtN6ApVhhdfbc/e54QKBgFZV
+PGlhT8+gDMlEaErOo/326MJ14vzlyR9BYm4OIC5lLODOouNKQETQZ6lWyY31rF9y
+ldhHUl0748I9hl/gbEk6kJa8bmtIuBmQUiGYeJPJth8RL8155mX8LL92H7r8Upem
+GlyHvhPb1pUrHXl/trSl3j9WedndTGgQvKKMXclRAoGBAKCwevyJrlhnvbZQzjyV
+zWPyy3028370nsTYnOBh2yVtPThcOCewp9THEy0FAVkMYqE1sdpAN51PdD5UPGFo
+RkXd/5HQTSDkVGHhO7VohXM/H/nNQgtotoDRSMkxTymQTHad5LNesi3dCEqa1gTC
+gyh89dCjF1p+mnLi0xITtkoA
+-----END PRIVATE KEY-----
diff --git a/recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.pem b/recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.pem
new file mode 100644
index 0000000..73936f7
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.pem
@@ -0,0 +1,19 @@
+-----BEGIN CERTIFICATE-----
+MIIDCTCCAfGgAwIBAgIUSbJC1oRCJUbGkwfWHscBeZrRHZcwDQYJKoZIhvcNAQEL
+BQAwFDESMBAGA1UECgwJU25ha2UgT2lsMB4XDTE5MTEwMTIyMDI1NVoXDTE5MTIw
+MTIyMDI1NVowFDESMBAGA1UECgwJU25ha2UgT2lsMIIBIjANBgkqhkiG9w0BAQEF
+AAOCAQ8AMIIBCgKCAQEAzUDpJwDzDpLo2ytVRSgt/QWRYk/Yjae5fbujitq73XYL
+uDZ+/Wf5U6zpOfyfzX/l5R0KCV9XYUJF47QEmNCnoWpg3cRdRry+3FIYtdnNK151
+AZ2L74OI4sMX1akSE+MfZFgdPFcm+n0uJgQuvRYGyYaR6N1wbhJ/2iOOba+sbKyc
+aKiL1fSjip2criHA/05cYSomdUT+rTUZALFdCQuOU+gX8Rqhmfbo8VEE7MpE3nrv
+HocQAFphyYgG8jadjggymE7sQEZGrBqOrwMDHitbpoGNlOI2VdFgL5jRKHuB61iC
+kqTmSWuS4lbOEJmms6hhQnTnu/yK7O3NEWegAPMrtQIDAQABo1MwUTAdBgNVHQ4E
+FgQUFD7OXb2T6sOysRo3hj2f15SX8I8wHwYDVR0jBBgwFoAUFD7OXb2T6sOysRo3
+hj2f15SX8I8wDwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEANZRB
+NFVUVZVehpj3QGbbSjp77m0V6JrEYn6u/XjLRFsUNw5Hh35UCR0HkKZ0cLgrVKb/
+8yL6LaYLOY6yDwEFWMtLXiF2S4noO8raEgW6A7DHawb2Y4ZNFRO4oBkyWbtd36Uu
+UfSszs2av048wb5J/pNedRSx8I/FiCNWummzpkBHzx023TdLPd8fmkmG7ZBpStN0
+Y//EE4DKTfHxAwt5w7WdZF5EY/KHPopnR+WSrdutRIK6zT+/+vKihtHYZbrv+7Ap
+K7xOM/zJ6E9vUROmuOhL3YL3MuLn5qHEvhM0eMxEAlCnSJlFkQE4/RXhDpZJYbR7
+x+PQllgoo4H6W30Dew==
+-----END CERTIFICATE-----
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb b/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb
index 24a5352..a446987 100644
--- a/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb
+++ b/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb
@@ -11,7 +11,7 @@
 
 require secure-boot-secrets.inc
 
-SB_KEY = "PkKek-1-snakeoil.key"
-SB_CERT = "PkKek-1-snakeoil.pem"
+SB_KEY = "${BASE_DISTRO_CODENAME}/PkKek-1-snakeoil.key"
+SB_CERT = "${BASE_DISTRO_CODENAME}/PkKek-1-snakeoil.pem"
 
 DEBIAN_CONFLICTS = "secure-boot-key"
-- 
2.39.2


