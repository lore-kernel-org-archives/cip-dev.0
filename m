Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7610ACDC19C
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 13:22:00 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88303.1767700449617588153
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:54:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=gourav.singh.ext@siemens.com header.s=fm1 header.b=C2iXKNau;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1333022-202601061144013b3613768500020761-kosxsz@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202601061144013b3613768500020761
        for <cip-dev@lists.cip-project.org>;
        Tue, 06 Jan 2026 12:44:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=gourav.singh.ext@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=/roWE2L949NgzTSjeMSkR3BuDynn6Zi/w7Sx8wI8BFs=;
 b=C2iXKNauChIUmVZGUM/963VgAKI9v/fmjdw3N67APRK1eUK8LqT21M4gqxwCBkNBg9Av+x
 GtuC+8KmXwErPen1/e0dn4+d7XckoBOWwwxp1bzk+6dukD5FQFc9jyi1O25zFFa22DP2GPlW
 egxL13jWZ913+SIbx/UjzcFeNfVtV2gLmqefnO4PoJNoiSFtvH4C9OlO2kCyP/y+LI62tn40
 rsVwZe98Vv3o2Jn+/257KZVnaPMAwu0Yi3EBWTqAGb0UF1HU7jNWIfQ1xgDQ4XdPBcug7Dnc
 wT+Icmll21o49KOSZC9WFj81t/rb0ricJeca/TD5iryd9Rf9/mMRNMjg==;
From: Gourav Singh <gourav.singh.ext@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Shivanand.Kunijadar@toshiba-tsip.com,
	Gourav Singh <gourav.singh.ext@siemens.com>
Subject: [isar-cip-core][PATCH] fix(security): install systemd-cryptsetup for LUKS userspace support on Trixie
Date: Tue,  6 Jan 2026 17:13:31 +0530
Message-Id: <20260106114331.924611-1-gourav.singh.ext@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1333022:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 13:22:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21378

systemd (>= 256-2) split cryptsetup tools into a separate systemd-cryptsetup
package which is only Recommends. On minimal Debian Trixie images this
causes LUKS devices to be unlocked in kernel space but not exposed in
userspace (/dev/mapper).
Ref: https://salsa.debian.org/systemd-team/systemd/-/commit/65e0731d3a0360fe9816a24be459fc2d2b8becb3

Installing systemd-cryptsetup will restore expected LUKS behavior.

Related to issue: https://gitlab.com/cip-project/cip-testing/cip-security-tests/-/issues/8

Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
---
 recipes-core/images/cip-core-image-security.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
index 8a8c695..1d62273 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -34,6 +34,8 @@ IMAGE_PREINSTALL += " \
 	login \
 	util-linux \
 "
+# Ensure LUKS devices are exposed in userspace on Debian Trixie (systemd 256 split)
+IMAGE_PREINSTALL:append:trixie = " systemd-cryptsetup"

 CIP_IMAGE_OPTIONS ?= ""
 require ${CIP_IMAGE_OPTIONS}
--
2.39.5


