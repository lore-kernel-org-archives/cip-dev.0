Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC03C43219
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 15:17:49 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.47.1637767067520717410
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 07:17:48 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AOFHjUw030750
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 16:17:45 +0100
Received: from md2dvrtc.fritz.box ([139.22.38.174])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AOFHiVq005533;
	Wed, 24 Nov 2021 16:17:45 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 1/2] start-qemu.sh: Add defaults for
 IMAGE_SECURITY
Date: Wed, 24 Nov 2021 16:17:43 +0100
Message-Id: <20211124151744.949054-2-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124151744.949054-1-Quirin.Gylstorff@siemens.com>
References: <20211124151744.949054-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 15:17:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7005

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

for ease of use

Suggested-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 start-qemu.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/start-qemu.sh b/start-qemu.sh
index 4817790..a92e9f4 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -40,6 +40,9 @@ fi
 
 if [ -z "${TARGET_IMAGE}" ];then
 	TARGET_IMAGE="cip-core-image"
+	if grep -s -q "IMAGE_SECURITY: true" .config.yaml; then
+		TARGET_IMAGE="cip-core-image-security"
+	fi
 fi
 
 case "$1" in
-- 
2.30.2


