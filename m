Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDCDCAC5B3
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 11:53:42 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web10.14951.1758628411444887208
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Sep 2025 04:53:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=qU2o8+7o;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-20250923115328b31b73ba2500020787-i03pva@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250923115328b31b73ba2500020787
        for <cip-dev@lists.cip-project.org>;
        Tue, 23 Sep 2025 13:53:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=YUYgOdb8o9HzCD1QjjBTl9MbJhgt9CiSZVsDYqFR8Eg=;
 b=qU2o8+7okqaO6aCh99Pmv3xfA57na2SRt+HutbsSDrilXSM94y1mYXwdEQ07Oqz/4yiTdV
 Vb5oK6fap5e3EstjjfMin7tq7A2LCCaXcJJxoPTX4PezwKhlhQp1XfHRAkR7Xbl2Bp3vg5hf
 Aj2X4UrJ38wtE3vxFhq+uLzpRqoF5Rfg3j3CFNJVjzcjRRY7e2cQdbh4SDhewaKc9u4d0x9c
 PhwMc+JrCyR//9U+V/HwarnXVYwiMRmVklxm0QuebM4XBMsU9jZhVjrNY7C8m3zK4Z2RoEGz
 Spt8N/IEGRIupCbRPaelpk0HOrMrCBCwyBO7PcWghvW1sSA4jwjSyYXg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v7 2/7] Factory-reset-helper file is incompatible with encrypt-partitions
Date: Tue, 23 Sep 2025 13:52:53 +0200
Message-ID: <20250923115319.335608-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250923115319.335608-1-Quirin.Gylstorff@siemens.com>
References: <20250923115319.335608-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 11:53:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20110

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The partition which contains the reset-marker is encrypted and therefore
a factory reset cannot be detected. Print an error if this incompatible
combination is selected.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../factory-reset-helper/factory-reset-helper-file_0.1.bb    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb b/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
index 8d82663..14870ce 100644
--- a/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
+++ b/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
@@ -17,3 +17,8 @@ FACTORY_RESET_MARKER_STORAGE_DEVICE ?= "/dev/disk/by-partlabel/var"
 FACTORY_RESET_TYPE = "file"
 
 DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, bsdextrautils"
+
+python __anonymous() {
+    if "encrypt-partitions" in d.getVar('OVERRIDES'):
+        bb.error("This recipe is incompatible with encrypt-partitions")
+}
-- 
2.50.1


