Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E67C43217
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 12:45:10 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.6817.1668084309315125821
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Nov 2022 04:45:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=A8OxpVas;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202211101245076551a2dc238d0e8b85-kgxgur@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202211101245076551a2dc238d0e8b85
        for <cip-dev@lists.cip-project.org>;
        Thu, 10 Nov 2022 13:45:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=s5GDnWBxhx2d8GmnNA16L7NvAuK8amJCp/1mCmqYc4U=;
 b=A8OxpVas9QzZqAUkoSSjRkgHjQOb/MmJDQdfKgxgL72w04RIUInalS1HDzvThPWLzYfHyw
 +mt+xhdV77EPVi3t/rebvBUIciudOXxiYOGilX76Nx1p6B+BDbKcaC/dP4c1hJXuQMawJlBL
 8tLCbBGxXQ/u5c8gd72OHsMcy0azA=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christian.storm@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 5/5] recipe-core/images: Integrate uuidcheck into sw-description
Date: Thu, 10 Nov 2022 13:45:03 +0100
Message-Id: <20221110124503.274124-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20221110124503.274124-1-Quirin.Gylstorff@siemens.com>
References: <20221110124503.274124-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Nov 2022 12:45:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10001

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/files/sw-description.tmpl | 1 +
 recipes-core/images/swupdate.inc              | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
index 1c0db02..a9a6069 100644
--- a/recipes-core/images/files/sw-description.tmpl
+++ b/recipes-core/images/files/sw-description.tmpl
@@ -20,6 +20,7 @@ software =
             filesystem = "ext4";
             properties: {
                         subtype = "image";
+                        uuidcheck = "${TARGET_IMAGE_UUID}";
             };
             sha256 = "${ROOTFS_PARTITION_NAME}-sha256";
     });
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 6cf9bb1..0ba3a0e 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -23,6 +23,9 @@ FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
 SRC_URI += "file://sw-description.tmpl"
 TEMPLATE_FILES += "sw-description.tmpl"
 
-TEMPLATE_VARS += "ROOTFS_PARTITION_NAME"
+do_transform_template[vardeps] += "TARGET_IMAGE_UUID"
+addtask do_transform_template before do_swupdate_binary after do_generate_image_uuid
+
+TEMPLATE_VARS += "ROOTFS_PARTITION_NAME TARGET_IMAGE_UUID"
 
 SWU_ADDITIONAL_FILES += "linux.efi ${ROOTFS_PARTITION_NAME}"
-- 
2.35.1


