Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC173C61DA4
	for <webhook@archiver.kernel.org>; Thu, 16 Feb 2023 03:45:56 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.2678.1676519152779423585
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Feb 2023 19:45:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=Yq+4jP5B;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-72506-20230216034550f6165c7896adc41199-9tsk7q@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230216034550f6165c7896adc41199
        for <cip-dev@lists.cip-project.org>;
        Thu, 16 Feb 2023 04:45:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Gd+DzsYI2y8SpMSvbCti/U3UPJKgvtrSpciqXV5cDRw=;
 b=Yq+4jP5BMgwgDWVqUlFkPyyjZCzmhsTZan4O26fFGG3PQs0/Wrxt+JktN1jplssyrIMzmA
 BqaJcdkDrUn3a04lhdufVSV4fJWKAXIRqY15OOWIMpQ/AjHMpG/p96vuQ/jSbjebdaCHmPgK
 dejx3ZzxpHOo+ku9EHpQJnt8DVFBU=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v5 5/8] make sw-description spec compliant
Date: Thu, 16 Feb 2023 03:45:15 +0000
Message-Id: <20230216034518.1993074-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Feb 2023 03:45:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10705

Remove the filesystem attribute from the images object, as this can only
be applied to files objects.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 recipes-core/images/swu/sw-description.tmpl | 1 -
 1 file changed, 1 deletion(-)

diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
index 05125e6..01c5f53 100644
--- a/recipes-core/images/swu/sw-description.tmpl
+++ b/recipes-core/images/swu/sw-description.tmpl
@@ -17,7 +17,6 @@ software =
             device = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}";
             type = "roundrobin";
             compressed = "zlib";
-            filesystem = "ext4";
             properties: {
                         subtype = "image";
                         configfilecheck = "/etc/os-release@not_match@IMAGE_UUID=${TARGET_IMAGE_UUID}";
-- 
2.34.1


