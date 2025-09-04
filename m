Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4012DCAC580
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 09:52:39 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web11.35129.1756979555041637586
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Sep 2025 02:52:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=PXu9CIYV;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-202509040952326bf517ed9c00020791-s7onct@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202509040952326bf517ed9c00020791
        for <cip-dev@lists.cip-project.org>;
        Thu, 04 Sep 2025 11:52:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=5EeyCH6FYL/P/Iu+GJEwxmMf7Qtdv+aB64+Uf1vLlJc=;
 b=PXu9CIYV2DJkw7qHDr030Fj22IoyZVwxtcKmCadbDKkHyGBcd+9gL33kZ/ISkrkTWHu9wa
 oLCEQTZJpm7zgGJU4aITdWhAFHRdvQqR+tAtc8VKD+CaPQjzzoXo5CAHAnPPmPRahZWOfAlr
 Pvt0wMTtaq5Gw+qvWPBo3PVkO1/fe2OenfA8GAv5pvjWI60CnqdkmuhLpvRv/kZJ+AoxQ7ro
 OAOpM9i4zwKhMVtwjyMdOuCF4Eh8ZrfjLnnxcF1wGdeiiX11HNLNYAq/sXLyMa1xopAnLzaW
 8sX4R44Ca4637/ZbbGLpy4KwdqNsxUgmqvAWUgyIwrNoyYZUmgF4qzXA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v5 4/7] Add factory-reset information to encrypt-data
Date: Thu,  4 Sep 2025 11:39:27 +0200
Message-ID: <20250904095231.2039819-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250904095231.2039819-1-Quirin.Gylstorff@siemens.com>
References: <20250904095231.2039819-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Sep 2025 09:52:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20011

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/encrypt-data.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kas/opt/encrypt-data.yml b/kas/opt/encrypt-data.yml
index 3de76ab..4292d4c 100644
--- a/kas/opt/encrypt-data.yml
+++ b/kas/opt/encrypt-data.yml
@@ -15,3 +15,6 @@ header:
 local_conf_header:
   initramfs-option-encrypt-partitions: |
     OVERRIDES .= ":encrypt-partitions"
+  initramfs-factory-reset: |
+    INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE = "/dev/disk/by-partlabel/BOOT0"
+
-- 
2.50.1


