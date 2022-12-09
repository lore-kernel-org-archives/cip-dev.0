Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EF9C4708E
	for <webhook@archiver.kernel.org>; Fri,  9 Dec 2022 14:58:34 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.3427.1670597912960763741
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Dec 2022 06:58:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=norjc7f9;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20221209145830abb8439215c135a80b-3ktnd_@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20221209145830abb8439215c135a80b
        for <cip-dev@lists.cip-project.org>;
        Fri, 09 Dec 2022 15:58:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Nd1w0n63Fn4jbjZ2Q4HKKGEWZDUQZxoV1EGYEmo8EJo=;
 b=norjc7f9R2R8Qjk/htnYUN1SaldZdzUhp3aSsEuHumqy73t/kQ8Gb+PMYJ8845ZbvPfwGH
 O8e0vsxbcllug8MSYFcWTH8MTim8AY1Y1vhfaE5ReYih7iRGogGJCAKjgISx3iZbBFxG7Gt5
 qvwP8elPactFSuQY6frw+PBb+cjQI=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 4/4] recipe-core/images: Integrate configfilecheck into sw-description
Date: Fri,  9 Dec 2022 15:58:27 +0100
Message-Id: <20221209145827.1309521-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20221209145827.1309521-1-Quirin.Gylstorff@siemens.com>
References: <20221209145827.1309521-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Dec 2022 14:58:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10173

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/files/sw-description.tmpl | 1 +
 recipes-core/images/swupdate.inc              | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
index 1c0db02..f7105c7 100644
--- a/recipes-core/images/files/sw-description.tmpl
+++ b/recipes-core/images/files/sw-description.tmpl
@@ -20,6 +20,7 @@ software =
             filesystem = "ext4";
             properties: {
                         subtype = "image";
+                        configfilecheck = "/etc/os-release@not_match@IMAGE_UUID=${TARGET_IMAGE_UUID}";
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


