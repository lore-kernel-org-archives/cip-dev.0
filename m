Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D31C54F52
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 09:08:53 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7668.1785229723059185346
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2026 02:08:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 66S98fUE1246903; Tue, 28 Jul 2026 18:08:41 +0900
X-Iguazu-Qid: 2yAbYA1sggdVZLfvDE
X-Iguazu-QSIG: v=2; s=1; t=1785229721; q=2yAbYA1sggdVZLfvDE; m=kRYdRxNW4L6jYc7AUAIjZU1NSWEvvispgYD5OIGJ7io=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h8V4m74Ycz1xnZ; Tue, 28 Jul 2026 18:08:40 +0900 (JST)
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        kumar.dinesh.h95@mail.toshiba, kazuhiro.hayashi.f74@mail.toshiba
Subject: [isar-cip-core][PATCH v2 1/2] Enable the support of Debian forky based builds
Date: Tue, 28 Jul 2026 14:25:17 +0530
X-TSB-HOP2: ON
Message-Id: <20260728085519.3615499-2-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260728085519.3615499-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20260728085519.3615499-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Jul 2026 09:08:38.0120 (UTC) FILETIME=[AD277E80:01DD1E70]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 09:08:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23795

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

The .key & .pem files are addded using below .deb package,
https://snapshot.debian.org/file/d32d11a5aacbf5685b81e8176a27a6918e9b55fb/ovmf-generic_2025.11-5_all.deb

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 Kconfig                                       |  4 +++
 conf/distro/cip-core-forky.conf               | 13 ++++++++
 kas/opt/forky.yml                             | 15 ++++++++++
 .../files/forky/PkKek-1-snakeoil.key          | 30 +++++++++++++++++++
 .../files/forky/PkKek-1-snakeoil.pem          | 23 ++++++++++++++
 .../swupdate-certificates/files/forky         |  1 +
 start-qemu.sh                                 |  2 ++
 7 files changed, 88 insertions(+)
 create mode 100644 conf/distro/cip-core-forky.conf
 create mode 100644 kas/opt/forky.yml
 create mode 100644 recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key
 create mode 100644 recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.pem
 create mode 120000 recipes-devtools/swupdate-certificates/files/forky

diff --git a/Kconfig b/Kconfig
index 438234c..19f8e24 100644
--- a/Kconfig
+++ b/Kconfig
@@ -238,6 +238,9 @@ config DEBIAN_BOOKWORM
 config DEBIAN_TRIXIE
 	bool "trixie (13)"
 
+config DEBIAN_FORKY
+	bool "forky (14)"
+
 config DEBIAN_SID
 	bool "Sid (Unstable)"
 
@@ -249,6 +252,7 @@ config KAS_INCLUDE_DEBIAN
 	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
 	default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
 	default "kas/opt/trixie.yml" if DEBIAN_TRIXIE
+	default "kas/opt/forky.yml" if DEBIAN_FORKY
 	default "kas/opt/sid.yml" if DEBIAN_SID
 
 comment "Image features"
diff --git a/conf/distro/cip-core-forky.conf b/conf/distro/cip-core-forky.conf
new file mode 100644
index 0000000..7a868ce
--- /dev/null
+++ b/conf/distro/cip-core-forky.conf
@@ -0,0 +1,13 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corporation, 2026
+#
+# Authors:
+#  Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require conf/distro/debian-forky.conf
+require cip-core-common.inc
diff --git a/kas/opt/forky.yml b/kas/opt/forky.yml
new file mode 100644
index 0000000..6c4fcdc
--- /dev/null
+++ b/kas/opt/forky.yml
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corporation, 2026
+#
+# Authors:
+#  Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+distro: cip-core-forky
diff --git a/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key b/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key
new file mode 100644
index 0000000..dd7f492
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key
@@ -0,0 +1,30 @@
+-----BEGIN ENCRYPTED PRIVATE KEY-----
+MIIFHDBOBgkqhkiG9w0BBQ0wQTApBgkqhkiG9w0BBQwwHAQIs4RXCLmGLJgCAggA
+MAwGCCqGSIb3DQIJBQAwFAYIKoZIhvcNAwcECHer6014IEhGBIIEyO8O2zL8CJwV
+auQpWLJsMMWxu2aSh1WadX9+rg+O61mukuS4rQSH5shMQ2krZZKzyXx0q8+2AySD
+EtDXwhLvep60gUxOoNqK1+l3AxSFfIGOY8NC6yW67VX+G09ajWpgHj3ox63VRW8v
+6mA8TFWYbOIwB8J7ScF4NszVwyiUnW13oKi7svoBM3LYYG2IMvre+gOvyMGfM8uv
+X3txcYqAjhRV6n7vGo9LRLIIRSPKzaJbm/W7nT38LRUJP8JMSQUOPKgeEwQvOTVZ
++1kd7WeaGZrjagTDM4yhBjpOmB3D8aeT6xkjBlUwuddPzbdi0N7GrU520RcJMjxt
+JMyOgabHKUKmPTX4m0ZCKi2jSILi7/6fBF+TZDxpakLwAwpTzm6kXArXb6AYtTEX
+GPihB4O69ZgEc90jp3EnZt7HtKZn1HTbPNQAlWgvESgJ7hWHnTlM5Obqnyb78tj5
+VdcOfTSQRYmw4Rh/lSUX0vQLhdmYSVLiMFFvT4IepXZgQ6McIdcvqoVrPgr0HoVz
+5YILZdmbs80VcgYL853lMfQ84kRwUcw8jNyz7mBK7V7rE5QhaF5lunZ/R41ZRXRy
+1ys1rNvLPvtOq/K51+A9U+h5lLM9LjeoOR+IUk2Vg4aIap+Z+lxbImH0gcJTrpem
+ctA/2sBjLN7w811EjB/Tlu2awzbsKLpIDFVGHiGBI2zb41gtPd2RkijmiZab6nuM
+ETg4ad3GscMoa++01oX/lrnVe386ECSjurmThb7I01eTNZrBlNsLyBeFzlEIEoBR
+TqUXHLiDACxzL6U4vWzdnvVrCOW9fwvJJqChj7Wy822w2LXxVhOryNujBmZCmOht
+mgDaJ15QiF+DACcX6VoBbm/462z+9Skxa0DqGwGzMOD5HldwvQSyZSykk/BzGFWP
+rXfLYoMjN+dgA/yNfem64ayGsmoPUAjnsE4YasD58UVO0XwwtdMGJSOVmkdyWMcM
+t+lN74kX/gmIvciK06N6prBfowgBEIJ6ev2dzlydSN8rGORmQ+OFzjP14rT0O+1Q
+O48yR2ZZ9jl4YPUKSFJ3EUc/Qt9vO+chNiNYSy6TABGXur0WWiDvGURG9K5fWTqq
+U2KydSRoYD5iF0caOgMZecNhZV+4CX927j3XuuKKx49qTAt3WMtmJ/UQFHMtQ833
+XDFWHpEKDImfHfyiB1f8bOmqYmPuE6Shup0UMJsMFel4QVJM0Jn9+wHw/0qqPiS3
+a769S/u9U2dfyZY5PfymY8UjFRMDtLaUoJSRaGp6RNc6LynuMMKdzho0GwvL3+m9
+xKLDbbks8hVdmtcxxDKiio+F0hp3yc/2PyA/VGAlARiGp7876WTCZox9Bwnf6lkS
+k9eYLSabe/r3Ag1SbWEGpFk3VO37qCyfp2xTfrHXK1ZJlvFwj3FFSprUaMrV+81K
+FCEcSozXpVsQ7e7d11A7S8rTbtp09Q/J2oxyR0A9lk/ia5Qd/xwbPl4QJcWK2Jar
+K3yFK8VrUNib7CjI1kdB479KIllD8oK6druBkzwGzFxDtcl47RlfkqW96XSQT7x/
+h/YKSLcpMx9x9TJd2GDKj2t4oE9eGTBC0YbdH+HJNSrjEsWkjgY6Uw++S6VzKvQZ
+DDsMJfxwcChc2zKRou+BFA==
+-----END ENCRYPTED PRIVATE KEY-----
diff --git a/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.pem b/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.pem
new file mode 100644
index 0000000..7cd2487
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.pem
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
diff --git a/recipes-devtools/swupdate-certificates/files/forky b/recipes-devtools/swupdate-certificates/files/forky
new file mode 120000
index 0000000..2719d00
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/files/forky
@@ -0,0 +1 @@
+../../secure-boot-secrets/files/forky
\ No newline at end of file
diff --git a/start-qemu.sh b/start-qemu.sh
index d12fa23..2fb9c9c 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -45,6 +45,8 @@ if [ -z "${DISTRO_RELEASE}" ]; then
 		DISTRO_RELEASE="bookworm"
 	elif grep -s -q "DEBIAN_TRIXIE: true" .config.yaml; then
 		DISTRO_RELEASE="trixie"
+	elif grep -s -q "DEBIAN_FORKY: true" .config.yaml; then
+		DISTRO_RELEASE="forky"
 	elif grep -s -q "DEBIAN_SID: true" .config.yaml; then
 		DISTRO_RELEASE="sid"
 	else
-- 
2.39.5



