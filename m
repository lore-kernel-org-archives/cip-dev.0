Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F323C4167D
	for <webhook@archiver.kernel.org>; Tue, 30 Nov 2021 11:47:32 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web10.75508.1638272850024153070
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Nov 2021 03:47:30 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AUBlRkw028311
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 30 Nov 2021 12:47:27 +0100
Received: from md2dvrtc.fritz.box ([139.22.40.121])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AUBlQAQ003770;
	Tue, 30 Nov 2021 12:47:27 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RESEND PATCH 3/9] linux-cip-common: Increase
 revision kernel config
Date: Tue, 30 Nov 2021 12:47:20 +0100
Message-Id: <20211130114726.351921-4-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130114726.351921-1-Quirin.Gylstorff@siemens.com>
References: <20211130114726.351921-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Nov 2021 11:47:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7042

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add support for verity and overlay fs.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/linux-cip-common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 1afec88..8fa8988 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -25,6 +25,6 @@ SRC_URI_append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
 
 SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
 
-SRCREV_cip-kernel-config ?= "cd5d43e99f4d5f20707d7ac1e721bb22d4c9e16e"
+SRCREV_cip-kernel-config ?= "4f80764b80a81f9590e927fb202f358465b322a6"
 
 S = "${WORKDIR}/linux-cip-v${PV}"
-- 
2.30.2


