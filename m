Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF53C001E0
	for <webhook@archiver.kernel.org>; Thu, 13 Jul 2023 16:41:01 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.1675.1689266458903848820
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jul 2023 09:41:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=FXQHkdSh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-2023071316405680f54bf24595a530b9-yr6rzz@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2023071316405680f54bf24595a530b9
        for <cip-dev@lists.cip-project.org>;
        Thu, 13 Jul 2023 18:40:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=esrtYuo6+8Xaawh4Tk03AhFw1vqT9q/U5gIER4rLr60=;
 b=FXQHkdShHk302arlOgKfZSMQkcYYNbeMwpWVLJ0EFPKm04S2n8x7UXtQBXDNKCLUA9UVVi
 4Ajr8aya+dgc1KSkQXq5CeNs+9aKTKXU0NL5Wnw2rkmDEx560xEozS1sUZ9dpMxzYdom0aOO
 CJvpKRzua6pReUG0CNdd25UAwWkAk=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 1/3] recipe-devtools: Add recipe to sign SWUpdate update binaries
Date: Thu, 13 Jul 2023 18:40:53 +0200
Message-Id: <20230713164055.2786350-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230713164055.2786350-1-Quirin.Gylstorff@siemens.com>
References: <20230713164055.2786350-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jul 2023 16:41:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12334

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This adds the necessary recipes to provide a snakeoil for testing
sign updates and a recipe to for offical certificates.

The certificates creation can be found at [1].

[1]: https://sbabic.github.io/swupdate/signed_images.html?highlight=signing#usage-with-certificates-and-cms

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/cip-swupdate-snakeoil.cert.pem      | 30 +++++++++++
 .../files/cip-swupdate-snakeoil.key.pem       | 52 +++++++++++++++++++
 .../swupdate-certificates-key-snakeoil_0.1.bb | 17 ++++++
 .../swupdate-certificates-key.inc             | 31 +++++++++++
 .../swupdate-certificates-key_0.1.bb          | 15 ++++++
 .../swupdate-certificates-snakeoil_0.1.bb     | 16 ++++++
 .../swupdate-certificates.inc                 | 31 +++++++++++
 .../swupdate-certificates_0.1.bb              | 14 +++++
 8 files changed, 206 insertions(+)
 create mode 100644 recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.cert.pem
 create mode 100644 recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.key.pem
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates.inc
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb

diff --git a/recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.cert.pem b/recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.cert.pem
new file mode 100644
index 0000000..a44cb7d
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.cert.pem
@@ -0,0 +1,30 @@
+-----BEGIN CERTIFICATE-----
+MIIFKzCCAxOgAwIBAgIUEA0euuQB7ulZBzoFaG+/Fps82oEwDQYJKoZIhvcNAQEL
+BQAwJTESMBAGA1UECgwJU1dVcGRhdGUgMQ8wDQYDVQQDDAZ0YXJnZXQwHhcNMjMw
+NjIzMDk1NDA4WhcNMjMwNzIzMDk1NDA4WjAlMRIwEAYDVQQKDAlTV1VwZGF0ZSAx
+DzANBgNVBAMMBnRhcmdldDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIB
+ALO14EDb7Q/hXCJZbrl/UD2RytUb8Phh49iPpIOryJKqDEyGNhc03XzpkB5qMYEt
+vMN+UXRTLFvBIfrtukLzrpEm5jTPaSAciKD+nIGqNFbPXWl+KIy2lMTEqD9Se7lQ
+4u4fupZQp4adlsdjya0i9u9fnNbK25jCrPjQHf698eS1VR0YpXOqAqB9VFLeLdlj
+BCCmVBkhMTF/z7CvF7XsL7rqBG8F1yTg9qKTf/2C9Odc9sCtjy0wGt8NBSV2Cua3
+ifPNQtYdxPLR9ohyariMEsS3s0WVclUvctD6SwCmP0RNvwmKDyzlWerRTSvODw+8
++laD0vI2KIkgegzDiJGBF0DrfBrePqCHLeZztQHpHfTkcSAEP4hgg4ev2p5XV7lC
+1ed9UTHjhW+mmKJuJODgfsS7sQs8CqRGHYj95RrK14CG5PHebRWpSH3KcmROpsSl
+fUXQTSqth01welrL9/OEpO0vRlnL0FNrhjQFtgIR3djgxosoRuOL43g/ep1CtIwc
+ypFDemhgMKoUzc7KnQvGpG5FeqUSqqAlqclAKEfFNs4pvpc5mz3LUwdNkyIGkgqL
+Xuhnf1OkMDtMlZ5wvi+CTqYMX2KqXU8yz2Csf9uN54ojIGbWN73wCZA5JH7R8FqN
+PoKJ8csQTayQK5XBYP7XQV1CgnAJDxa/pEnMf4zLotG/AgMBAAGjUzBRMB0GA1Ud
+DgQWBBR2lBlS17x7xqB2kaLwEg1lJXpoLDAfBgNVHSMEGDAWgBR2lBlS17x7xqB2
+kaLwEg1lJXpoLDAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUAA4ICAQCe
+WK2TcfszS5EPeO4K6o7Zsr6tNkyAfP0oHm4gqAOfverfITctws/SIOdwLI79ljMq
+vUuSEzWRnx16TfzqBlnFNFEUPBknnk/KeHCXgz4XdyyLdS8cga1lCHc+yRVIcq53
+Z9KaLjbg/OmyJwVTehlJGnDF4QCOIzMO4Ha+O6Eyxu3ARp/x2QrzsfQ1U3KtMhAy
+NcBG/mupj8mwg3cfo10MmzzN4ioQUCIf5M6eg/8iDITgA51XqFpjf2fX1xusSBBe
+zuoy4Rz+Df1rGsUabAd7jKVXghS1+AE22ZPy6bnmV810ONb1H8MExFbGgdulYhmo
+zoH6H7h6LtKP0xVOZ6H87X4Hoi7YitQqCl+oaHUE2GzA97fm+rNXe84ekJvjUiEz
+Js3q1wXaegMr4LFmu9MPBSycJw54KtLfg2U0tIW6SD7dFlvD2f/qo7RtyEiE/Wfu
+Cm8ZvMUr+OuNAvQL/Ig08JgUKisTK3ARHFxMu9sEMsWoB7bTGvyiZ9mS/G2VIet4
+1pucvi89d9qXeZZ8PByHOEo0c7cu8lCmtIZoh0rdV3t8mxOZA1kFwYK2xahA6DT3
+J2me41iKb9l2aCbGBbUKiesu3CRLpPG8Ic8X5PPkbRlX5/Zza21AbM8jxX14ZAL8
+mkgMhzaLWIGo8ixvA8i7Fm/JunrIimDZaRjJrKuoMg==
+-----END CERTIFICATE-----
diff --git a/recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.key.pem b/recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.key.pem
new file mode 100644
index 0000000..5dd3d3b
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.key.pem
@@ -0,0 +1,52 @@
+-----BEGIN PRIVATE KEY-----
+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
+nFtyUBqMFy+r+QlyRfQbhfXxs7cW1/M=
+-----END PRIVATE KEY-----
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
new file mode 100644
index 0000000..fa2ce23
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Jan Kiszka <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+DEBIAN_DEPENDS += "swupdate-certificates-snakeoil"
+
+require swupdate-certificates-key.inc
+
+SWU_SIGN_KEY = "cip-swupdate-snakeoil.key.pem"
+
+DEBIAN_CONFLICTS = "swupdate-certificates-key"
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
new file mode 100644
index 0000000..3fafce0
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
@@ -0,0 +1,31 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Jan Kiszka <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-raw
+
+PROVIDES += "swupdate-certificates-key"
+
+SWU_SIGN_KEY ??= ""
+
+SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_KEY') if d.getVar('SWU_SIGN_KEY') else '' }"
+
+do_install() {
+    if [ -z ${SWU_SIGN_KEY} ] ]; then
+        bbfatal "You must set SWU_SIGN_KEY and provide the required file as artifacts to this recipe"
+    fi
+    TARGET=${D}/usr/share/swupdate-signing/
+    install -d -m 0700 ${TARGET}
+    install -m 0700 ${WORKDIR}/${SWU_SIGN_KEY} ${TARGET}/swupdate-sign.key
+}
+
+do_prepare_build:append() {
+    echo "Provides: swupdate-certificates-key" >> ${S}/debian/control
+}
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
new file mode 100644
index 0000000..45864fa
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Jan Kiszka <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+DEBIAN_DEPENDS += "swupdate-certificates"
+
+require swupdate-certificates-key.inc
+
+DEBIAN_CONFLICTS = "swupdate-certificates-key-snakeoil"
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
new file mode 100644
index 0000000..4e45b6b
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Jan Kiszka <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require swupdate-certificates.inc
+
+SWU_SIGN_CERT = "cip-swupdate-snakeoil.cert.pem"
+
+DEBIAN_CONFLICTS = "swupdate-certificates"
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
new file mode 100644
index 0000000..92f9715
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
@@ -0,0 +1,31 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Jan Kiszka <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-raw
+
+PROVIDES += "swupdate-certificates"
+
+SWU_SIGN_CERT ??= ""
+
+SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_CERT') if d.getVar('SWU_SIGN_CERT') else '' }"
+
+do_install() {
+    if [ -z ${SWU_SIGN_CERT} ] ]; then
+        bbfatal "You must set SWU_SIGN_CERT and provide the required file as artifacts to this recipe"
+    fi
+    TARGET=${D}/usr/share/swupdate-signing/
+    install -d -m 0700 ${TARGET}
+    install -m 0700 ${WORKDIR}/${SWU_SIGN_CERT} ${TARGET}/swupdate-sign.crt
+}
+
+do_prepare_build:append() {
+    echo "Provides: swupdate-certificates" >> ${S}/debian/control
+}
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
new file mode 100644
index 0000000..41d07a5
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
@@ -0,0 +1,14 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Jan Kiszka <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require swupdate-certificates.inc
+
+DEBIAN_CONFLICTS = "swupdate-certificates-snakeoil"
-- 
2.40.1


