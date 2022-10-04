Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81FDC4167D
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 16:48:28 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web12.13159.1664902102442526022
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 09:48:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=efxm9h5c;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228,
 mailfrom: fm-294854-2022100416482063c653e4cefcd82a59-1mgxo_@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 2022100416482063c653e4cefcd82a59
        for <cip-dev@lists.cip-project.org>;
        Tue, 04 Oct 2022 18:48:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=VTsgqBnA+3Ia3iFXyG5gvjrDSSH50yTF1RgYJiAQEWU=;
 b=efxm9h5cje+1BVcP2sWB6nCZJGKAbc7MQMr4YJC2sBBHpB6e7kgB+DvQ/kcTMZyPfIFBLN
 x8pz1IDspLV4z+eorqPK6T5HGROgT/EvYhiOUJawPaAMM/egUlHPov8CDmjIl/elW2/x90nb
 Cxnp+oI+PIvwYXwux/WuH4RVx0j0Q=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 04/12] start-qemu: Rework usage output
Date: Tue,  4 Oct 2022 18:48:10 +0200
Message-Id: 
 <abc5d5e565d79e6def6b854f697ed7ab09579c47.1664902098.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1664902098.git.jan.kiszka@siemens.com>
References: <cover.1664902098.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 16:48:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9631

From: Jan Kiszka <jan.kiszka@siemens.com>

Avoid "echo -e", not supported with all shells.

Refactor the environment help to make it better readable. Add missing
variables at this chance.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index bcc7a518..c8d4f47c 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -13,10 +13,13 @@
 usage()
 {
 	echo "Usage: $0 ARCHITECTURE [QEMU_OPTIONS]"
-	echo -e "\nSet QEMU_PATH environment variable to use a locally " \
-		"built QEMU version"
-	echo -e "\nSet SWUPDATE_BOOT environment variable to boot swupdate image." \
-	echo -e "\nSet SECURE_BOOT environment variable to boot a secure boot environment."
+	echo
+	echo "Environment variables (default to settings in .config.yml):"
+	echo "  QEMU_PATH         use a locally built QEMU version"
+	echo "  SWUPDATE_BOOT     boot swupdate image"
+	echo "  SECURE_BOOT       start a secure boot environment"
+	echo "  DISTRO_RELEASE    select a specific Debian release"
+	echo "  TARGET_IMAGE      select a specific image type"
 	exit 1
 }
 
-- 
2.35.3


