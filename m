Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F010CD98D2
	for <webhook@archiver.kernel.org>; Sun, 14 Jun 2026 14:57:51 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.110684.1781449060108982327
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Jun 2026 07:57:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm2 header.b=cXzgNocZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-1324425-20260614145736111a4797aa000207c6-zxpdpy@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260614145736111a4797aa000207c6
        for <cip-dev@lists.cip-project.org>;
        Sun, 14 Jun 2026 16:57:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=43gg9LDGKbH56DnFgYOgqTQqAY/io05CHdeMiO0UvmE=;
 b=cXzgNocZwf/vVvALNmyIe6OPmcdGfrVnwt/Q47iff83by3yzpw+Enb1InGs4hcmqzWaRZw
 y64JHKJfY6vqb/plDmDYG6NYvXYyAL10tqdD3vLxvWo4aPoMzBaQO4+SzADH723xQwpNwXTx
 gk8PBOrUDglesAMUP5k4aMDTJk81RFj+oidKQQoKZALKNs9nCcD2LM0ntvKWGOrwEntY/eTu
 xPiksEX6TB2j1ELqCOp1pQ2Sfq1k8GjJwGQmEeHcSmp51sm4WDXsoiDm0mYhpjKFOO2sDGWh
 i63bHCt8t127Y3vNNdASAyuJ5tHzlBwEcObgH69yABDxZM+fgawJ3Llw==;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: srinuvasan <srinuvasan.a@siemens.com>
Subject: [isar-cip-core] [PATCH 1/2] shtab: mark package as arch-all
Date: Thu, 11 Jun 2026 02:57:45 +0530
Message-Id: <20260610212746.22275-1-srinuvasan.a@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Jun 2026 14:57:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23133

From: srinuvasan <srinuvasan.a@siemens.com>

Recent Isar cross-build profile changes add the
`--no-arch-all` option to sbuild, causing shtab to fail
during the build as it is an architecture-independent
package.

Set `DPKG_ARCH = "all"` to fix the build failure.

Ref: https://github.com/ilbers/isar/commit/327fb313

Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
---
 recipes-python/shtab/python-shtab_1.5.5-4.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-python/shtab/python-shtab_1.5.5-4.bb b/recipes-python/shtab/python-shtab_1.5.5-4.bb
index 8ccef35..03e0aed 100644
--- a/recipes-python/shtab/python-shtab_1.5.5-4.bb
+++ b/recipes-python/shtab/python-shtab_1.5.5-4.bb
@@ -11,6 +11,8 @@
 
 inherit dpkg-gbp
 
+DPKG_ARCH = "all"
+
 MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
 
 SRC_URI += " \
-- 
2.39.5


