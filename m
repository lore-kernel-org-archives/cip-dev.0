Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C467C48BEF
	for <webhook@archiver.kernel.org>; Fri, 16 Feb 2024 15:30:31 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.21579.1708097428383147988
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Feb 2024 07:30:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=pqiqGNqy;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20240216153025e4f8b739bce10d687a-q438_1@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240216153025e4f8b739bce10d687a
        for <cip-dev@lists.cip-project.org>;
        Fri, 16 Feb 2024 16:30:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=WBH+mA0lO2bYBGzGx8b/+Yg0QFg6FV7dfNSaLOCvKXA=;
 b=pqiqGNqyHDZTrNQpjOfvJh+vdLlugZYk9AK3teVlEePzvJHxJw6dKmRG3iLJJlaYcUmgGI
 B0+I5U0VftKp+5iSdP0uLLydlN8zzi0wGpasI7optP4Y7Ds/Y7fOjDrXK8be8Nj71czKiRWT
 I7vue1R6JTHi0LsUbNKlSnHv3Vsuo=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 4/4] doc/README.swupdate.md: Add documentation for hardware compatibility
Date: Fri, 16 Feb 2024 16:30:05 +0100
Message-ID: <20240216153024.260416-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240216153024.260416-1-Quirin.Gylstorff@siemens.com>
References: <20240216153024.260416-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Feb 2024 15:30:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15017

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.swupdate.md | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index 1c94699..0f179c4 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -21,6 +21,16 @@ window is still possible.
 If the variable `SWU_EBG_UPDATE` is set to `"1"` the update is also stored in
 the `*.swu` file.
 
+## SWUpdate Hardware compatibility
+
+The variable `SWU_HW_COMPAT` contains a space separate list of
+compatible hardware revisions.
+SWUpdate checks the compatibility against `/etc/hwrevision`, see
+[hardware-compatibility in the SWUpdate documentation.](https://sbabic.github.io/swupdate/sw-description.html#hardware-compatibility)
+
+For testing purpose the content of `/etc/hwrevision` can be set with
+the variable `MACHINE_HW_VERSION`.
+
 # Building and testing the CIP Core image
 
 Set up `kas-container` as described in the [top-level README](../README.md).
-- 
2.43.0


