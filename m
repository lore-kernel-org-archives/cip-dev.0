Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805C4E7717F
	for <webhook@archiver.kernel.org>; Tue, 17 Dec 2024 02:03:33 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.7128.1733910910361504527
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 01:55:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm2 header.b=iSvpiNMe;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1321639-202412110955073844123a5e5daa6eb9-jcb_lv@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202412110955073844123a5e5daa6eb9
        for <cip-dev@lists.cip-project.org>;
        Wed, 11 Dec 2024 10:55:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=WNalhAQXzP5D46IOdSBd92sPiTvV3WxjlwtRaJSbSgo=;
 b=iSvpiNMe7+146NLa5O4MbwyDBCe2eSxumgmAgU2F1sen7FREQfkeHj7zYZ8ar3fMZ0Net4
 dRn2yzupXCXktm/1HduOO69TTkssCwu5aVeNidf/mlrtaFyA7YLOx+g5JdLvayf+K6zmxugO
 9OnsbPlw+DalUn98cQN/3KufCMPgVMSZvxCEEUWlfFpzgY3DiWcsqN1/XzIWn4s8RJnP3IuE
 QNAFwDIoel0fWksoxqVxL7ieHz1uElK/CQFixSUZxFx1U8c3V76qwIKpJUTaISrA6grllWKi
 nqODmlrINfNqjeVymm6ERtuKdlTTQGo7qC5tK8oOZH9ZU25C/TSkWTFg==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v2 1/3] fix expansion of erofs exclude dirs
Date: Wed, 11 Dec 2024 10:54:54 +0100
Message-Id: <20241211095456.2735691-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Dec 2024 02:03:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17432

When defining erofs exclude dirs, these are expanded and appended to the
erofs creation args. However, this only works if the target variable
exists and is of the correct type (string).

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/erofs.bbclass | 1 +
 1 file changed, 1 insertion(+)

diff --git a/classes/erofs.bbclass b/classes/erofs.bbclass
index 95e7be3..189c1ea 100644
--- a/classes/erofs.bbclass
+++ b/classes/erofs.bbclass
@@ -19,6 +19,7 @@ python __anonymous() {
     exclude_directories = d.getVar('EROFS_EXCLUDE_DIRS').split()
     if len(exclude_directories) == 0:
         return
+    args = ""
     # Use regex to exclude only content of the directory.
     # This allows to use the directory as a mount point.
     for dir in exclude_directories:
-- 
2.39.5


