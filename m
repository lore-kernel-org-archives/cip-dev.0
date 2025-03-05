Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48029C282E3
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:28:12 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.10352.1741170491347955657
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Mar 2025 02:28:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=GWjWRhIb;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-202503051028098623b9e296d82d5974-30f8dc@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202503051028098623b9e296d82d5974
        for <cip-dev@lists.cip-project.org>;
        Wed, 05 Mar 2025 11:28:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=9pc9QZZQMSQa7lOYFyJM6LfH3ztkuRZUeWsEgyn7DcA=;
 b=GWjWRhIblKcZ+V8pyAGqsXytP0swT4+ofJXyHM9Dj7OQYoSlXssR/WzvqLeDHmxKIXbe6x
 YMay51NgjWlkDw7FHinCDdzjG43ivP+Fbw+7cqDkjqGdL5W4jNyZIiiT05XpwfUivN76Brti
 hl+QgYpop56Svd2XaBBYifwNmnjN7qb4vomB7CoH80RTLgbowqgxfakYekUaDi/pMU/+b6R1
 huzDI7xi0BC4Cu+c78vIgFh5Ln9D/2ojvxtoDpTHcGdBRt59yBLkwUznOoV/24Gt8L5vLrOu
 TegD4oQ6feTzNdw6v43NU/c5Hhe3kdj4pK17GQ7gv9XT4vfVwF5DwgRQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 6/6] add ci variable for separate home partition
Date: Wed,  5 Mar 2025 11:27:45 +0100
Message-ID: <20250305102807.2614514-7-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18035

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4df521b..72d3af8 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -27,6 +27,7 @@ variables:
   build_swu_v2: disable
   swupdate_version: default
   test_function: swupdate
+  separate_home_partition: disable
 
 stages:
   - build
@@ -59,6 +60,7 @@ default:
     - if [ "${use_rt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/rt.yml"; fi
     - if [ "${extension}" != "none" ]; then base_yaml="${base_yaml}:kas/opt/${extension}.yml"; fi
     - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz.yml"; fi
+    - if [ "${separate_home_partition}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/separate-home-partition.yml"; fi
     - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
     - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
     - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
@@ -232,6 +234,7 @@ build:x86-uefi-secure-boot:
     watchdog: disable
     security_test: enable
     build_swu_v2: enable
+    separate_home_partition: enable
 
 build:qemu-amd64-swupdate:
   extends:
-- 
2.47.0


