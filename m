Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FEEC636D7
	for <webhook@archiver.kernel.org>; Sun, 12 Feb 2023 22:54:23 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.7477.1676190510835088738
 for <cip-dev@lists.cip-project.org>;
 Sun, 12 Feb 2023 00:28:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=O+/T3uBN;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-72506-2023021208283213054ab711609acd42-mltxzq@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2023021208283213054ab711609acd42
        for <cip-dev@lists.cip-project.org>;
        Sun, 12 Feb 2023 09:28:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Gd+DzsYI2y8SpMSvbCti/U3UPJKgvtrSpciqXV5cDRw=;
 b=O+/T3uBN0XcgbJtBU+425ZbmrpzL80YXb4hyo83/p2W9a188J3OKZHQehSIGBvIUVQhyDv
 WIDVWliGCzWlOgdNNj0m84jtX0Kw89IP+rnEUBn1Op4VwmuyuNcdIWK5PTY+4b9or2fGtcXN
 eUn+rsoKGu4M98mRE4VXyQhA0jVz8=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v4 5/8] make sw-description spec compliant
Date: Sun, 12 Feb 2023 08:27:55 +0000
Message-Id: <20230212082758.1166262-6-felix.moessbauer@siemens.com>
In-Reply-To: <20230212082758.1166262-1-felix.moessbauer@siemens.com>
References: <20230212082758.1166262-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 12 Feb 2023 22:54:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10675

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


