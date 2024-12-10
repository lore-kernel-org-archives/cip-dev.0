Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE53DE77180
	for <webhook@archiver.kernel.org>; Tue, 10 Dec 2024 22:41:57 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.15009.1733848985462516994
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Dec 2024 08:43:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm2 header.b=mCVuPTm5;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1321639-202412101643014b7eeb66209e296f43-zdohs1@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202412101643014b7eeb66209e296f43
        for <cip-dev@lists.cip-project.org>;
        Tue, 10 Dec 2024 17:43:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=qtIoWwytdCrxpx7rFrN1bQGo3TKcOu6bPqJVoP18dHg=;
 b=mCVuPTm58Vp1Y0gl4ZdfTkkmaJMtasaWyovxIp+PTn/nxB6Rpm81OQQOMmQB0Twt7DStQJ
 Kj+T6pRzQ50tOXVjkykT8DrZfBrpS2KCnSBTKhwIDoV/S9d2I2RdwuNZ9LBUhQpxJhW8BXHs
 wLhSY31EoKJFcYDTtlc+wPAUwfkXRXpV8603Hw1zqRhDYW9USo22gWbVSwe5fFnSavh1o2m/
 DEFNv7ZpYj3p+XZPiKtg9h2bviUdUIj+Hx12EpF6sFVIG/VTXGusUPVeXZsISZNDvZOrvKuc
 0qmK6y+miFOmXpAv3EgFZnvBr6Cm0tNiHM6wiK+fUf4V7ecE5QLQFTdw==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] exclude boot and var in squashfs
Date: Tue, 10 Dec 2024 17:42:56 +0100
Message-Id: <20241210164256.2674390-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Dec 2024 22:41:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17393

These dirs are anyways not used in a ro-rootfs. boot is over-mounted by
systemd via sd boot protocol, implemented by EBG. var is deployed empty.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/squashfs.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
index b39be0c..cebda70 100644
--- a/classes/squashfs.bbclass
+++ b/classes/squashfs.bbclass
@@ -22,7 +22,7 @@ def get_free_mem():
 
 IMAGER_INSTALL:squashfs += "squashfs-tools"
 
-SQUASHFS_EXCLUDE_DIRS ?= ""
+SQUASHFS_EXCLUDE_DIRS ?= "boot var"
 SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
 SQUASHFS_CREATION_ARGS ?= ""
 
-- 
2.39.5


