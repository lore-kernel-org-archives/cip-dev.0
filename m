Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CF7D0BB6B
	for <webhook@archiver.kernel.org>; Thu, 24 Oct 2024 07:56:26 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.8633.1729752663802890068
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Oct 2024 23:51:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kulkarni.vinayak@siemens.com header.s=fm1 header.b=fAR0Iykw;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1327949-202410240651001ac67d6a2f126a70e3-_ydg5q@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202410240651001ac67d6a2f126a70e3
        for <cip-dev@lists.cip-project.org>;
        Thu, 24 Oct 2024 08:51:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=kulkarni.vinayak@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=A1vmt7TarYFTNWiKSw3sesnXJCQHQ8QzdmFjgVIlv4g=;
 b=fAR0Iykw4C0ei5ovzmIWOXsQv584pvUv/+0Z/FsZS6/TJNXOf+BF/tdEAqBKTk2ljMuvw9
 wmBTavk/gxUB3kPZ60s9aVeZ7QGCbsSh0H8jMmiAt0e1dqoPMhMGaGhb7JOZtZfJE1X2NQiT
 BnmaTBpxp6gO3lwZthMl7QUasKEDtttrwhzYO5pVSJOKjkyysB15s2h7r+LLLAAz7Ny8hF3Q
 6KrY8fgnnYiucR34gJM3hGa5grQM7TOpPwUaRTkwUhkWQUOF7F8SEIBLCfvJ0rySlKFHBu8z
 b1dRNR5J/gWhWuHDBR126A7m+CcDSF0ad1vtFOSgXAXIOmHYM2XLpg+w==;
From: "kulkarni.vinayak" <kulkarni.vinayak@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: "kulkarni.vinayak" <kulkarni.vinayak@siemens.com>
Subject: [PATCH] localversion-cip-rt: make correction to -rt16
Date: Thu, 24 Oct 2024 12:20:45 +0530
Message-Id: <20241024065045.549653-1-kulkarni.vinayak@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1327949:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Oct 2024 07:56:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17075

Update to proper version matching the tag.

Signed-off-by: kulkarni.vinayak <kulkarni.vinayak@siemens.com>

diff --git a/localversion-cip-rt b/localversion-cip-rt
index 3eedd3bbecbb..1199ebade17b 100644
--- a/localversion-cip-rt
+++ b/localversion-cip-rt
@@ -1 +1 @@
--rt15
\ No newline at end of file
+-rt16
-- 
2.30.2


