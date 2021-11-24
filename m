Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63567C4332F
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 11:12:26 +0000 (UTC)
Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web11.4896.1637752344824730410
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 03:12:25 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.39, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AOBCM5S023533
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 12:12:22 +0100
Received: from md2dvrtc.fritz.box ([139.22.38.174])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AOBCLdx009575;
	Wed, 24 Nov 2021 12:12:22 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 2/3] start-qemu.sh: parse .config.yaml
 for ease of use
Date: Wed, 24 Nov 2021 12:12:20 +0100
Message-Id: <20211124111221.300917-3-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124111221.300917-1-Quirin.Gylstorff@siemens.com>
References: <20211124111221.300917-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 11:12:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6990

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Suggested-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 start-qemu.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 2c0a751..21b303a 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -20,13 +20,24 @@ usage()
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
 fi
-- 
2.30.2


