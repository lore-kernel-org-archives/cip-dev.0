Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA86C3ABBF
	for <webhook@archiver.kernel.org>; Tue,  6 May 2025 12:08:14 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.74572.1746533291049297274
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 May 2025 05:08:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=M500LbK/;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-2025050612080828edbb5494969bde50-5stvu_@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2025050612080828edbb5494969bde50
        for <cip-dev@lists.cip-project.org>;
        Tue, 06 May 2025 14:08:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Y7rLhWIKspRB/8dcLACIOaEKXgJgw+zQmccEsYzRaRo=;
 b=M500LbK/oQ22Lxb5BBXb3qed6HAMbSpeP45oZ73qHmIiV39CCEY3Qhp3UEHTm9wT//qPdd
 +IJljQW7IIoNh7P/b6Na0HuvdUKurIpny47T+RlmhZRidXdsNYBWpkF/PDmJeV+FJlCPR9Rr
 RpwXFVDFHHAdWl3b0BYTlKudsCcgIwDI1jL7Ikt5MOsi+iHDSS+SgCCx51g75Pg1EJAnMq4f
 j5HPqGRaMwjKL00CetCfvfmrgekyumK7GD/ac5P4pPLQ1A0dbsIgB1v+4s+4VmiS+ze4uAzT
 uxHIhEasOUPfz4BpbcOWLlW8G2dr1clQlp/DzWNtVPIEoam7jXgzE/dQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 3/6] encrypt-data.yml: Add factory-reset information to encrypt-data
Date: Tue,  6 May 2025 14:07:45 +0200
Message-ID: <20250506120807.255675-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250506120807.255675-1-Quirin.Gylstorff@siemens.com>
References: <20250506120807.255675-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 May 2025 12:08:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18767

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/encrypt-data.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kas/opt/encrypt-data.yml b/kas/opt/encrypt-data.yml
index 3de76ab..4292d4c 100644
--- a/kas/opt/encrypt-data.yml
+++ b/kas/opt/encrypt-data.yml
@@ -15,3 +15,6 @@ header:
 local_conf_header:
   initramfs-option-encrypt-partitions: |
     OVERRIDES .= ":encrypt-partitions"
+  initramfs-factory-reset: |
+    INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE = "/dev/disk/by-partlabel/BOOT0"
+
-- 
2.47.0


