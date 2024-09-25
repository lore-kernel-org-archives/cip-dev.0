Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CD6CF9C74
	for <webhook@archiver.kernel.org>; Wed, 25 Sep 2024 14:34:58 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.17721.1727274893511207723
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Sep 2024 07:34:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: chris.paterson2@renesas.com)
X-IronPort-AV: E=Sophos;i="6.10,257,1719846000"; 
   d="scan'208";a="219866481"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 25 Sep 2024 23:34:51 +0900
Received: from spl2-146.example.org (unknown [10.24.0.60])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E1C80400720E;
	Wed, 25 Sep 2024 23:34:50 +0900 (JST)
From: Chris Paterson <chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Sai Ashrith Sathujoda <sai.sathujoda@toshiba-tsip.com>
Subject: [isar-cip-core][PATCH] .gitlab-ci.yml: Use "large" runner for cve-checks job
Date: Wed, 25 Sep 2024 15:34:47 +0100
Message-Id: <20240925143447.2232845-1-chris.paterson2@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Sep 2024 14:34:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16918

We are seeing constant issues when using CIP's "small" GitLab runner for
the cve-checks job. Switching to the "large" runner seems to be reliable.

Reported-by: Sai Ashrith Sathujoda <sai.sathujoda@toshiba-tsip.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index bc98ec9634b0..6c92927f567d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -458,7 +458,7 @@ cve-checks:
   needs: []
   image: registry.gitlab.com/cip-project/cip-core/debian-cve-checker:build-latest
   tags:
-    - small
+    - large
   script:
     - scripts/run-cve-checks.sh
   when: manual
-- 
2.34.1


