Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9917FC36010
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 08:01:51 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.6339.1743753708531001635
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Apr 2025 01:01:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm2 header.b=V54QHiTn;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1321639-20250404080141cef22749330b83a153-m_exik@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250404080141cef22749330b83a153
        for <cip-dev@lists.cip-project.org>;
        Fri, 04 Apr 2025 10:01:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=fjYiBbAYy+W+s0j5xh6GhjWjwUMqcJWZ00Euxhv/bH8=;
 b=V54QHiTnNt1eAA+QdAYRsooqos2oxHwgynaJIL/vml2lEsDtOeW6SnM9z0VV0OdJNG4DLB
 aCrz816CngUdI8A+efwFpEM3s6c0E57jMFQonDd7lJhNiBvjcz0zD2sU7GQbp4+0LeevnURz
 Hv5ApdbqyRFJrweiAb0p/V4uTzqfdJ801baRKu2HNBhoo9AGtBAljHoh3ORwj6gW4Uuv7PVR
 xWGoE2feuZ4QOPrPVthsHIexRTPnzh1XkhapLkyaoUszGIDdh0gganrRXCbOkA/iMEC1LrVM
 15rbdxOraUYMoSIupHvnJse7GzcnWg1zkxma5cS83YrXcntpCtbTtsJw==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] swupdate: add vardep on SWU_HW_COMPAT
Date: Fri,  4 Apr 2025 10:01:22 +0200
Message-ID: <20250404080122.855379-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Apr 2025 08:01:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18478

The generation of the sw-description file depends on this variable, but
as it is read in a python function, the dependency to its value cannot
be detected by bitbake. We now explicitly add it to the vardeps of the
prefunc, as the transitively called function cannot have vardeps.

Fixes: ad089e6 ("make name, version and hw-compat available via bb")
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/swupdate.bbclass | 1 +
 1 file changed, 1 insertion(+)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 05291ee..61e4fe1 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -74,6 +74,7 @@ IMAGE_TEMPLATE_VARS:swu = " \
 # TARGET_IMAGE_UUID needs to be generated before completing the template
 addtask transform_template after do_generate_image_uuid
 
+do_extend_sw_description[vardeps] += "SWU_HW_COMPAT"
 python do_extend_sw_description() {
     cmds = d.getVar("SWU_EXTEND_SW_DESCRIPTION")
     if cmds is None or not cmds.strip():
-- 
2.49.0


