Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7987C47086
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:06 +0000 (UTC)
Received: from mta-64-227.flowmailer.net (mta-64-227.flowmailer.net
 [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.3438.1649834200604021533
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 00:16:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=RHpkLIny;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-2022041307163746d86e549f88a03708-srvv2h@rts-flowmailer.siemens.com)
Received: by mta-64-227.flowmailer.net with ESMTPSA id
 2022041307163746d86e549f88a03708
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 09:16:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=bDocXaCGhbhn7O/mO/yfrmCRILJstylRTdv2cMci6QI=;
 b=RHpkLInysiyV0CqiEw1ivA5Mwi++CwJH2nTcEmpU8xY7C9WGv/rZB+wNjzG1+iUxjhZhj0
 uWt6+NBIUf6RWTIod2VPVrx/zTPOiOcd7eEnfKQTJLH6bup2l0NHd0lFXRVsagfHL7UvUFL5
 Pls6IXXzzy4JtW0Ezj+JKr83SJjOw=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 01/19] start-qemu.sh: Add ssh access to guest
 from localhost
Date: Wed, 13 Apr 2022 09:16:18 +0200
Message-Id: 
 <0ab69754d5edbdb0ce740b460e3a4d80dc016da2.1649834193.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1649834193.git.jan.kiszka@siemens.com>
References: <cover.1649834193.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Apr 2022 15:48:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8057

From: Jan Kiszka <jan.kiszka@siemens.com>

Permit ssh logins to the guest from the host using port 22222
forwarding, but only from the local machine. This is useful, e.g., to
send an swu file into the VM for testing swupdate.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index e986791..c5cd9fa 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -117,7 +117,7 @@ shift 1
 QEMU_COMMON_OPTIONS=" \
 	-m 1G \
 	-serial mon:stdio \
-	-netdev user,id=net \
+	-netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 \
 	${QEMU_EXTRA_ARGS}"
 
 if [ -n "${SECURE_BOOT}" ]; then
-- 
2.34.1


