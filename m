Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365BCC433FE
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 14:50:01 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.8446.1665499795040869725
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Oct 2022 07:49:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: chris.paterson2@renesas.com)
X-IronPort-AV: E=Sophos;i="5.95,176,1661785200";
   d="scan'208";a="136176922"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 Oct 2022 23:49:52 +0900
Received: from renesas-ubuntu18.ree.adwin.renesas.com (unknown [10.226.93.15])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C452B400419E;
	Tue, 11 Oct 2022 23:49:51 +0900 (JST)
From: Chris Paterson <chris.paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
	Chris Paterson <chris.paterson2@renesas.com>
Subject: [PATCH 4.4.y-st] gitlab-ci: Add configuration for CIP's GitLab CI
 pipelines
Date: Tue, 11 Oct 2022 15:49:40 +0100
Message-Id: <20221011144940.24071-1-chris.paterson2@renesas.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 14:50:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9723

Actual pipelines are defined externally [0] to save on churn in the kernel
tree.

[0] https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 .gitlab-ci.yml | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 .gitlab-ci.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
new file mode 100644
index 000000000000..ad0593601dbb
--- /dev/null
+++ b/.gitlab-ci.yml
@@ -0,0 +1,3 @@
+include:
+  - https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/raw/master/linux-cip-pipeline.yml
+  - https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/raw/master/trees/linux-4.4.y-st.yml
-- 
2.37.1


