Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5323BC28B21
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:28:12 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.10351.1741170491195440577
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Mar 2025 02:28:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=U0LSx96x;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20250305102809f698b4bd7a8909e2de-1buo5o@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250305102809f698b4bd7a8909e2de
        for <cip-dev@lists.cip-project.org>;
        Wed, 05 Mar 2025 11:28:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=mfp83q5KqANMRRxWkCBcUXp7NHghhl0lLoz2b8hZihI=;
 b=U0LSx96xH0uFCOXiR1/NEabYMglGqtiyIfc8lqC73J+8OwF2JcX6jxk1ZI3WeNxVN5J+0T
 VfHaJNzy7G/wyhDvZGQmqPZjEC6uHA1ZUM5T0CkG8kEE1Fhlk+cDngy0OGscZogonzBDmM8a
 BylUE687MczTQEfBIYe2tAhBGcMsQr3FIGOlcABgdnXOvZo25N81eUO86kRGo21aieBxM2ax
 /4nidnY7YNhIPydNzTgD12dtZEe5J39e49UfAxQbZqh0EYcX0nuYXomHTicdPMB8DOx7e1KW
 gTiajIZzjn26SeXCDKpzx31kRjqavTqwREUXE7C6IlC7lUFwCMUBWMrw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 5/6] Add Kconfig option for separate home partition
Date: Wed,  5 Mar 2025 11:27:44 +0100
Message-ID: <20250305102807.2614514-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250305102807.2614514-1-Quirin.Gylstorff@siemens.com>
References: <20250305102807.2614514-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Mar 2025 10:28:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18037

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Kconfig b/Kconfig
index 3c246fa..40eee9d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -241,6 +241,12 @@ config IMAGE_FULL_ENCRYPTION
 	  If the partitions contain secrets the first boot must occur in a secure
 	  location.
 
+config SEPARATE_HOME_PARTITION
+	bool "Separate Home Partition"
+	help
+	  This adds a separate home partition to the build image instead of moving
+	  home to the var partition.
+
 config KAS_INCLUDE_DATA_ENCRYPTION
 	string
 	default "kas/opt/encrypt-data.yml" if IMAGE_DATA_ENCRYPTION
@@ -249,6 +255,10 @@ config KAS_INCLUDE_FULL_ENCRYPTION
 	string
 	default "kas/opt/encrypt-all.yml" if IMAGE_FULL_ENCRYPTION
 
+config KAS_INCLUDE_HOME_PARTITION
+	string
+	default "kas/opt/separate-home-partition.yml" if SEPARATE_HOME_PARTITION
+
 config WDOG_TIMEOUT
 	int "EFI Boot Guard watchdog timeout in seconds"
 	default 60
-- 
2.47.0


