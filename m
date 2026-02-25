Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6462DFD376C
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 15:52:44 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48367.1772034759791098283
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 07:52:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=hOnNP6Vx;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1330684-2026022515523731bfe00b6d00020749-dnhiwt@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026022515523731bfe00b6d00020749
        for <cip-dev@lists.cip-project.org>;
        Wed, 25 Feb 2026 16:52:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3K4aSNcavCMrtzT2ojPeEOXGYSeJgFEA74aSTavRUCg=;
 b=hOnNP6Vx0Bs7AK12ROe4qhv/CPkCkBK8nUIpSLDwcj7oP3gDhjkoCXmg21U8Asjgs0eUNr
 a40X3D8S49VsS8tTvx8JUTI/JUZzZ5eb+cVIve4qnyATWbQ8CDvrRkkhjM3r36Nf/rFlncjf
 LzhZWxJwl02qARF2b4AROlV/zU8iiEbhO6j3nz9zuKGO6g/Y7EPeAklVXfnqF0JaGLjlKac2
 NF8YpGnL53Ce4OUNdOYNtk+6YzAuLRIZ3DJYP0PP/g0JVFjJEMUBuYSRojH9LhCi673l2HWK
 sY5BchhsqyV1V5GwCWU+o8L36EsP48da0agNaWAv1zUqzNSRTa+rJdkw==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v4 2/2] swupdate: Fix unintended modification of the image in swupdate class
Date: Wed, 25 Feb 2026 16:52:26 +0100
Message-ID: <20260225155226.534978-3-alexander.heinisch@siemens.com>
In-Reply-To: <20260225155226.534978-1-alexander.heinisch@siemens.com>
References: <20260225155226.534978-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 15:52:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21984

From: Alexander Heinisch <alexander.heinisch@siemens.com>

classes-recipe/swupdate.bbclass provides the imaging capabilities to
create swu files (that can be enabled via IMAGE_FSTYPES) and thus is
inherited via IMAGE_CLASSES to all images no matter if swupdate (swu
generation) is used or not.

Thus, we shall not modifiy the image (rootfs) in swupdate class and
modifications of the image should be done in swupdate.inc rather than
the swupdate IMAGE_FSTYPES class.

The image specific parts to enable and install swupdate for a
particular image (recipe) is handled in recipes-
core/images/swupdate.inc. Thus, modifications on the image should be
handled there.

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 classes-recipe/swupdate.bbclass | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/classes-recipe/swupdate.bbclass b/classes-recipe/swupdate.bbclass
index 59dab9f..d92d55f 100644
--- a/classes-recipe/swupdate.bbclass
+++ b/classes-recipe/swupdate.bbclass
@@ -39,6 +39,8 @@ SWU_KERNEL_ARTIFACT_NAME = "${@ '${SWU_DELTA_UPDATE_KERNEL_ARTIFACT}' \
 SWU_IMAGE_FILE ?= "${IMAGE_FULLNAME}"
 SWU_DESCRIPTION_FILE ?= "sw-description"
 SWU_ADDITIONAL_FILES ?= "${SWU_KERNEL_ARTIFACT_NAME} ${SWU_ROOTFS_ARTIFACT_NAME}"
+
+# Including swupdate.inc in CIP_IMAGE_OPTIONS enables signing by default.
 SWU_SIGNED ??= ""
 SWU_SIGNATURE_EXT ?= "sig"
 SWU_SIGNATURE_TYPE ?= "cms"
@@ -52,8 +54,6 @@ IMAGE_TYPEDEP:swu = "${@ '${SWU_DELTA_UPDATE_ARTIFACT_TYPE}' \
     else '${SWU_UPDATE_ARTIFACT_TYPE}' }"
 
 IMAGER_INSTALL:swu += "cpio coreutils"
-IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
-
 
 IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
 IMAGE_SRC_URI:swu += "file://${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
-- 
2.47.3


