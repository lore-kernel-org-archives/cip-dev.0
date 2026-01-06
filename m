Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7A6CDC19F
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 13:22:10 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89300.1767704252708157081
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:57:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=gourav.singh.ext@siemens.com header.s=fm1 header.b=HralJmMv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1333022-202601061247261ecef799ea00020740-b4_nkz@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202601061247261ecef799ea00020740
        for <cip-dev@lists.cip-project.org>;
        Tue, 06 Jan 2026 13:47:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=gourav.singh.ext@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=GkigTzxU/sJ5HR8gnWQRPUkICtTGFcMI7MXf8Y5t7nA=;
 b=HralJmMvnDOautUlcd5vFeLXYrZzbuhTazniKpEFU5kZ3tuTNg9NQusaDpV1L9UT5sLj7s
 PFiY9ntPshSs1P7lOsEaNCVyjxAWeVy/DJujTPxQ3z2Ul6Krn9CFYwxIqAhScc/h4mj5J9bt
 R5eTnYgW8F4ZpeNe7y8JgQRx4DVNK2QxLylpVDzOFTzUijANGDL5ZsWj9IpRrLguWgKT/VwZ
 hngGNAAzVlbk1qMo5E0fqcZ3hw5j3gBZgeGpkLb64J6xHj0PPvZf4OQXV5G2La1kL4+r9gLf
 ebrWn2HuERYwn/Hm5OfAPYr4wRMYVUuEZtqvhZ3lq5nsTWQT9lxMTPnA==;
From: Gourav Singh <gourav.singh.ext@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Shivanand.Kunijadar@toshiba-tsip.com,
	Gourav Singh <gourav.singh.ext@siemens.com>
Subject: [isar-cip-core][PATCH v2] fix(security): install systemd-cryptsetup for LUKS userspace support on Trixie
Date: Tue,  6 Jan 2026 18:17:12 +0530
Message-Id: <20260106124712.930274-1-gourav.singh.ext@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1333022:519-21489:flowmailer
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 13:22:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21379

systemd (>= 256-2) split cryptsetup tools into a separate systemd-cryptsetup
package which is only Recommends. On minimal Debian Trixie images this
causes LUKS devices to be unlocked in kernel space but not exposed in
userspace (/dev/mapper).
Ref: https://salsa.debian.org/systemd-team/systemd/-/commit/65e0731d3a0360fe9816a24be459fc2d2b8becb3

Installing systemd-cryptsetup will restore expected LUKS behavior.

Related to issue: https://gitlab.com/cip-project/cip-testing/cip-security-tests/-/issues/8

Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
---
 recipes-core/images/cip-core-image-security.bb | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
index 8a8c695..d14f749 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -33,7 +33,12 @@ IMAGE_PREINSTALL += " \
 	passwd \
 	login \
 	util-linux \
+    systemd-cryptsetup \
 "
+# Remove systemd-cryptsetup from older versions as it’s only available in Trixie and later.
+IMAGE_PREINSTALL:remove:bullseye = " systemd-cryptsetup"
+IMAGE_PREINSTALL:remove:buster = " systemd-cryptsetup"
+IMAGE_PREINSTALL:remove:bookworm = " systemd-cryptsetup"

 CIP_IMAGE_OPTIONS ?= ""
 require ${CIP_IMAGE_OPTIONS}
--
2.39.5


