Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C925FE95A82
	for <webhook@archiver.kernel.org>; Sun,  8 Oct 2023 14:26:30 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.31952.1696734952477941822
 for <cip-dev@lists.cip-project.org>;
 Sat, 07 Oct 2023 20:15:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=N+zaBMH7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-72506-202310080315500fada700a795f34e68-taxkvh@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202310080315500fada700a795f34e68
        for <cip-dev@lists.cip-project.org>;
        Sun, 08 Oct 2023 05:15:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=gXrHrS2kI4vvCjF8UukET2sEFAf4OPP3z3t0JYOSWMo=;
 b=N+zaBMH7MkNpBXDTCRe6GcfVs7j+ny3Dl3YG1iITYgmfPXjJUqx0gAOnRWT52UdW42gd7l
 8RTnEqYVgAI0giN7p6SpBV28Zr616Qkd6vZdjNJss6o5BSyYzMas3VeQOzeykzg1K1jWmcRy
 AlgOEqJIKZNvK+nX2xqyQc/0tKnCk=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/4] make deploy-ovmf compatible with schroot imaging
Date: Sun,  8 Oct 2023 11:15:26 +0800
Message-Id: <20231008031529.1338834-2-felix.moessbauer@siemens.com>
In-Reply-To: <20231008031529.1338834-1-felix.moessbauer@siemens.com>
References: <20231008031529.1338834-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 08 Oct 2023 14:26:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13310

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 recipes-core/images/deploy-ovmf.inc | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/recipes-core/images/deploy-ovmf.inc b/recipes-core/images/deploy-ovmf.inc
index 0ec8762..cdab118 100644
--- a/recipes-core/images/deploy-ovmf.inc
+++ b/recipes-core/images/deploy-ovmf.inc
@@ -11,11 +11,15 @@
 # This recipe deploys the OVMF binaries to run the image in QEMU
 # Note: x86 only
 
-IMAGER_INSTALL += "ovmf"
+INSTALL_deploy_ovmf_binaries += "ovmf"
 
+do_deploy_ovmf_binaries[network] += "${TASK_USE_SUDO}"
 do_deploy_ovmf_binaries[cleandirs] += "${DEPLOY_DIR_IMAGE}/OVMF"
+do_deploy_ovmf_binaries[depends] += "${SCHROOT_DEP}"
 do_deploy_ovmf_binaries() {
-    cp -v ${BUILDCHROOT_DIR}/usr/share/OVMF/*.fd ${DEPLOY_DIR_IMAGE}/OVMF
+    imager_run -p -d ${PP_WORK} -- <<'EOIMAGER'
+        cp -v /usr/share/OVMF/*.fd ${PP_DEPLOY}/OVMF/
+EOIMAGER
 }
+addtask deploy_ovmf_binaries before do_image
 
-addtask deploy_ovmf_binaries after do_install_imager_deps before do_image
-- 
2.39.2


