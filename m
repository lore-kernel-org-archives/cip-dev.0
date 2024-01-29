Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86BFC47DA9
	for <webhook@archiver.kernel.org>; Mon, 29 Jan 2024 10:47:45 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.12015.1706525254910690484
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jan 2024 02:47:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=a7Agwn3P;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-202401291047315da07b484e41cf6ff4-ofccsm@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202401291047315da07b484e41cf6ff4
        for <cip-dev@lists.cip-project.org>;
        Mon, 29 Jan 2024 11:47:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=q+hU5n6Zi5jk2jFJV1JiVj/SAH3YHbBLWfL1FluRB7Q=;
 b=a7Agwn3PQQliTlcQ/18Qfd5BltwdzGehgQdAMJRlWoxwMUe8twyGFvutu+m8CKMnMdpHUb
 KQZ/PLFtCiqLG35D7FGXtKXTUeT716HaHY0Va7VzA9GGjda5fdVVGsx7Kd7CliY/VRE1mJby
 rfKFoHIs/6ggpYURp1dtcK16VMSmw=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] start-qemu.sh: fix qemu with encrypted paritions
Date: Mon, 29 Jan 2024 11:47:12 +0100
Message-ID: <20240129104730.72927-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jan 2024 10:47:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14476

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

After commit 2586e10(start-qemu: Fix inclusion of QEMU_EXTRA_ARGS)
the tpm was no longer added to the qemu command which lead to the
following error if the option `IMAGE_DATA_ENCRYPTION` is enabled.
```
tpm device '/dev/tpmrm0' does not exists - cannot create a encrypted device!
```

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 start-qemu.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 98af971..9ec0f1c 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -161,13 +161,6 @@ if [ -z "${DISPLAY}" ]; then
 	esac
 fi
 
-QEMU_COMMON_OPTIONS=" \
-	-m 1G \
-	-serial mon:stdio \
-	-netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 \
-	${QEMU_EXTRA_ARGS} \
-	"
-
 if [ "$TPM2_ENCRYPTION" = "true" ] && [ -x /usr/bin/swtpm ]; then
 	SWTPM_DIR="${IMAGE_PREFIX}.swtpm"
 	mkdir -p "${SWTPM_DIR}"
@@ -187,6 +180,13 @@ if [ "$TPM2_ENCRYPTION" = "true" ] && [ -x /usr/bin/swtpm ]; then
 	fi
 fi
 
+QEMU_COMMON_OPTIONS=" \
+	-m 1G \
+	-serial mon:stdio \
+	-netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 \
+	${QEMU_EXTRA_ARGS} \
+	"
+
 if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 	case "${arch}" in
 		x86|x86_64|amd64)
-- 
2.43.0


