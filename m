Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A4FC001DE
	for <webhook@archiver.kernel.org>; Mon, 17 Jul 2023 10:54:26 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.5350.1689591261648138508
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jul 2023 03:54:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=oPBc9kL+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20230717105418dd1532cbf3f217ed4c-iouf2_@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230717105418dd1532cbf3f217ed4c
        for <cip-dev@lists.cip-project.org>;
        Mon, 17 Jul 2023 12:54:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=10z4h3JcZ7iGiL7dgMQCQn41u4ud2wUVz2gYJRsCmm4=;
 b=oPBc9kL+v7CUDwPZWq73oD4fSWeFndc2hm6K4Wqi/WaVRFjjyHr8sd8CAWVcUQgZX1YA7Q
 ImJM3ue5Z9P9ksac3ZSrUcKPQ5mdjlLI0Qb6PD0ysINGV2q8i03Y3VYnEas60h2XLdHztdFt
 l2ZPTBsJ2QK4jQHlyHv/KJvtayw38=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 1/3] recipe-devtools: Add recipe to sign SWUpdate update binaries
Date: Mon, 17 Jul 2023 12:54:15 +0200
Message-Id: <20230717105417.27761-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230717105417.27761-1-Quirin.Gylstorff@siemens.com>
References: <20230717105417.27761-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Jul 2023 10:54:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12366

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This also adds recipes with the Debian snakeoil key and
certificate to test signed updates.

For in-production new keys and certificates must be created.
[1] descripes the creation of keys and certificates.

To use non snakeoil certificates copy the certificates and keys to
recipes-devtools/swupdate-certificates/files/.

The following settings are necessary:
```
PREFERRED_PROVIDER_swupdate-certificates-key =
"swupdate-certificates-key"
PREFERRED_PROVIDER_swupdate-certificates =
"swupdate-certificates"
SWU_SIGN_KEY = "<name of the key file>"
SWU_SIGN_CERT = "<name of the certificate file>"
```

[1]: https://sbabic.github.io/swupdate/signed_images.html?highlight=signing#usage-with-certificates-and-cms

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/swupdate.inc              |  2 ++
 .../secure-boot-secrets/files/buster/bookworm |  1 +
 .../secure-boot-secrets/files/buster/bullseye |  1 +
 .../swupdate-certificates/files/bookworm      |  1 +
 .../swupdate-certificates/files/bullseye      |  1 +
 .../swupdate-certificates/files/buster        |  1 +
 .../swupdate-certificates-key-snakeoil_0.1.bb | 18 +++++++++++
 .../swupdate-certificates-key.inc             | 31 +++++++++++++++++++
 .../swupdate-certificates-key_0.1.bb          | 17 ++++++++++
 .../swupdate-certificates-snakeoil_0.1.bb     | 16 ++++++++++
 .../swupdate-certificates.inc                 | 31 +++++++++++++++++++
 .../swupdate-certificates_0.1.bb              | 14 +++++++++
 12 files changed, 134 insertions(+)
 create mode 120000 recipes-devtools/secure-boot-secrets/files/buster/bookworm
 create mode 120000 recipes-devtools/secure-boot-secrets/files/buster/bullseye
 create mode 120000 recipes-devtools/swupdate-certificates/files/bookworm
 create mode 120000 recipes-devtools/swupdate-certificates/files/bullseye
 create mode 120000 recipes-devtools/swupdate-certificates/files/buster
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates.inc
 create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb

diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 6a01abb..5d9cd58 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -12,6 +12,8 @@
 inherit image_uuid
 inherit read-only-rootfs
 
+SWU_SIGNED ?= "1"
+
 IMAGE_INSTALL += " swupdate"
 
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
diff --git a/recipes-devtools/secure-boot-secrets/files/buster/bookworm b/recipes-devtools/secure-boot-secrets/files/buster/bookworm
new file mode 120000
index 0000000..b7dbeb4
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/buster/bookworm
@@ -0,0 +1 @@
+../../secure-boot-secrets/files/bookworm
\ No newline at end of file
diff --git a/recipes-devtools/secure-boot-secrets/files/buster/bullseye b/recipes-devtools/secure-boot-secrets/files/buster/bullseye
new file mode 120000
index 0000000..3c7fe4f
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/buster/bullseye
@@ -0,0 +1 @@
+../../secure-boot-secrets/files/bullseye
\ No newline at end of file
diff --git a/recipes-devtools/swupdate-certificates/files/bookworm b/recipes-devtools/swupdate-certificates/files/bookworm
new file mode 120000
index 0000000..b7dbeb4
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/files/bookworm
@@ -0,0 +1 @@
+../../secure-boot-secrets/files/bookworm
\ No newline at end of file
diff --git a/recipes-devtools/swupdate-certificates/files/bullseye b/recipes-devtools/swupdate-certificates/files/bullseye
new file mode 120000
index 0000000..3c7fe4f
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/files/bullseye
@@ -0,0 +1 @@
+../../secure-boot-secrets/files/bullseye
\ No newline at end of file
diff --git a/recipes-devtools/swupdate-certificates/files/buster b/recipes-devtools/swupdate-certificates/files/buster
new file mode 120000
index 0000000..67d1534
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/files/buster
@@ -0,0 +1 @@
+../../secure-boot-secrets/files/buster
\ No newline at end of file
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
new file mode 100644
index 0000000..a0bbd50
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
@@ -0,0 +1,18 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+DEPENDS += "swupdate-certificates-snakeoil"
+DEBIAN_DEPENDS += "swupdate-certificates-snakeoil"
+
+require swupdate-certificates-key.inc
+
+SWU_SIGN_KEY = "${BASE_DISTRO_CODENAME}/PkKek-1-snakeoil.key"
+
+DEBIAN_CONFLICTS = "swupdate-certificates-key"
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
new file mode 100644
index 0000000..1b6b6dd
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
@@ -0,0 +1,31 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
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
index 0000000..2e99617
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+DEPENDS += "swupdate-certificates"
+DEBIAN_DEPENDS += "swupdate-certificates"
+
+require swupdate-certificates-key.inc
+
+DEBIAN_CONFLICTS = "swupdate-certificates-key-snakeoil"
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
new file mode 100644
index 0000000..22c7ce2
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require swupdate-certificates.inc
+
+SWU_SIGN_CERT = "${BASE_DISTRO_CODENAME}/PkKek-1-snakeoil.pem"
+
+DEBIAN_CONFLICTS = "swupdate-certificates"
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
new file mode 100644
index 0000000..0553c25
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
@@ -0,0 +1,31 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
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
index 0000000..2643aad
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
@@ -0,0 +1,14 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require swupdate-certificates.inc
+
+DEBIAN_CONFLICTS = "swupdate-certificates-snakeoil"
-- 
2.40.1


