Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB93C4321E
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 14:31:37 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web08.6698.1637764295713034963
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 06:31:36 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AOEVWiv008616
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 15:31:33 +0100
Received: from md2dvrtc.fritz.box ([139.22.38.174])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1AOEVVLR022964;
	Wed, 24 Nov 2021 15:31:32 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: [PATCH v2 2/3] start-qemu.sh: parse .config.yaml for ease of use
Date: Wed, 24 Nov 2021 15:31:30 +0100
Message-Id: <20211124143131.939349-3-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124143131.939349-1-Quirin.Gylstorff@siemens.com>
References: <20211124143131.939349-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 14:31:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7003

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Suggested-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 README.md     |  6 ++++--
 start-qemu.sh | 16 +++++++++++++++-
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/README.md b/README.md
index 53ef679..bd707a4 100644
--- a/README.md
+++ b/README.md
@@ -38,8 +38,10 @@ Run, e.g.,
 
     ./start-qemu.sh x86
 
-when having built a QEMU AMD64 image. A security image for QEMU can be started
-like this:
+when having built a QEMU AMD64 image. Using the image configuration menu will
+initialize variables used by start-qemu.sh with fitting defaults.
+
+A security image for QEMU can be started like this:
 
     TARGET_IMAGE=cip-core-image-security ./start-qemu.sh x86
 
diff --git a/start-qemu.sh b/start-qemu.sh
index 2c0a751..94c3611 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -20,15 +20,29 @@ usage()
 	exit 1
 }
 
+if grep -s -q "IMAGE_SECURE_BOOT: true" .config.yaml; then
+	SECURE_BOOT="true"
+fi
+
 if [ -n "${QEMU_PATH}" ]; then
 	QEMU_PATH="${QEMU_PATH}/"
 fi
 
 if [ -z "${DISTRO_RELEASE}" ]; then
-  DISTRO_RELEASE="buster"
+	if grep -s -q "DEBIAN_BULLSEYE: true" .config.yaml; then
+		DISTRO_RELEASE="bullseye"
+	elif grep -s -q "DEBIAN_STRETCH: true" .config.yaml; then
+		DISTRO_RELEASE="stretch"
+	else
+		DISTRO_RELEASE="buster"
+	fi
 fi
+
 if [ -z "${TARGET_IMAGE}" ];then
 	TARGET_IMAGE="cip-core-image"
+	if grep -s -q "IMAGE_SECURITY: true" .config.yaml; then
+		TARGET_IMAGE="cip-core-image-security"
+	fi
 fi
 
 case "$1" in
-- 
2.30.2


