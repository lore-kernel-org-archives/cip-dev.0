Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA10CAC5B7
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 06:00:36 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.4683.1758780027976908398
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Sep 2025 23:00:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=htQwVRkm;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20250925060024c6b5899b6d00020786-ui7yg9@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250925060024c6b5899b6d00020786
        for <cip-dev@lists.cip-project.org>;
        Thu, 25 Sep 2025 08:00:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Ttoe/BBo+Ft67XarX0nlxsZJ7eCBA2tULgNLH1KMsB8=;
 b=htQwVRkmMCDSNxF7PPFLmPs75lzJ/ve0eQE72CoY4MJ48lbGHFIsBtqPIwutCEHlKPKD25
 9gxUD2+6cLDTYNbYHQc7IxphDcvQexb/+aVCgWEM8f+Mh+Va/Ca3nvG8GVMykcs0xscKan32
 CjYsl7uy4colKR5Bhsp3lMlLc2ACb3Te1rQMmT/9wIRAuNhKQCBq483t2HH7koT96J5b5Efv
 f/ZYEYc4AZ9JbYk441ceyJC3l/aWeS5oX7OP3m79ZBqxAM90C4U5WZUnqAf2ahq1WlVhU6q0
 IZ9HcyuMa3Va0wsYhwIDZUN05J0O5YSxNic9mR+f4xkL3SsNjAnTJvKw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v8 2/8] Factory-reset-helper file is incompatible with encrypt-partitions
Date: Thu, 25 Sep 2025 07:59:14 +0200
Message-ID: <20250925060009.1711605-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250925060009.1711605-1-Quirin.Gylstorff@siemens.com>
References: <20250925060009.1711605-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Sep 2025 06:00:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20126

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The partition which contains the reset-marker is encrypted and therefore
a factory reset cannot be detected. Print an error if this incompatible
combination is selected.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../factory-reset-helper/factory-reset-helper-file_0.1.bb   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb b/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
index 8d82663..ec29262 100644
--- a/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
+++ b/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
@@ -17,3 +17,9 @@ FACTORY_RESET_MARKER_STORAGE_DEVICE ?= "/dev/disk/by-partlabel/var"
 FACTORY_RESET_TYPE = "file"
 
 DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, bsdextrautils"
+
+python do_check_compatibility() {
+    if "encrypt-partitions" in d.getVar('OVERRIDES'):
+        bb.error("This recipe is incompatible with encrypt-partitions")
+}
+addtask check_compatibility after do_fetch before do_install
-- 
2.51.0


