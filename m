Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD55C41513
	for <webhook@archiver.kernel.org>; Sat, 29 Jun 2024 06:28:08 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web10.1305.1719642478893416739
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Jun 2024 23:27:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=TOKdey6K;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-294854-202406290627567efb1f3d56ac501111-ex6yaf@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202406290627567efb1f3d56ac501111
        for <cip-dev@lists.cip-project.org>;
        Sat, 29 Jun 2024 08:27:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ASRq8iMSEm7bmJIZFNe3NFCAFvzjPtePBjD9n0b5Ne4=;
 b=TOKdey6KtAifYUkVeQ9aXyYbUmuRCKEHB6rYFTm3byL8+OnnlJ3lPnD9lkOJVSVlu/72Gv
 BRN9ILFZQFodQSnXQQIyz3nxfwhh1RZPAkMwnY7nW/84DQjjtIqPSYavWc2pB+0GVFsYEwR2
 Wrg/6oxpbDicJMAh9eRmAWYnz/cUE=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Ashrith Sathujoda <sai.sathujoda@toshiba-tsip.com>
Subject: [isar-cip-core][PATCH 4/4] ci: submit_lava: Reduce validate_jobs to handle only a single one
Date: Sat, 29 Jun 2024 08:27:54 +0200
Message-ID: <306d108ad904f0c8c4afa31fa0f34fa80a51e3a8.1719642474.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1719642474.git.jan.kiszka@siemens.com>
References: <cover.1719642474.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 29 Jun 2024 06:28:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16345

From: Jan Kiszka <jan.kiszka@siemens.com>

We switched to one job per invocation already in 6bc117569001.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/submit_lava.sh | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index 6bf844bf..092819cd 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -196,25 +196,20 @@ is_device_online () {
 	return 1
 }
 
-# This method is added with the intention to check if all the jobs are valid before submit
-# If even a single definition is found to be invalid, then no job shall be submitted until
-# it is fixed by the maintainer
-validate_jobs () {
-	local ret=0
-	for JOB in "${job_dir}"/*.yml; do
-		# shellcheck disable=2086
-		if lavacli $LAVACLI_ARGS jobs validate "$JOB"; then
-			echo "$JOB is a valid definition"
-			if ! submit_job $JOB; then
-				clean_up
-				exit 1
-			fi
-		else
-			echo "$JOB is not a valid definition"
-			ret=1
+# This method checks if the job is valid before submitting it later on.
+validate_job () {
+	# shellcheck disable=2086
+	if lavacli $LAVACLI_ARGS jobs validate "${job_dir}"/*.yml; then
+		echo "$JOB is a valid definition"
+		if ! submit_job $JOB; then
+			clean_up
+			exit 1
 		fi
-	done
-	return $ret
+	else
+		echo "$JOB is not a valid definition"
+		return 1
+	fi
+	return 0
 }
 
 get_first_xml_attr_value() {
@@ -237,6 +232,7 @@ get_junit_test_results () {
 }
 
 set_up
+
 create_job "$TEST" "$TARGET"
 
 if ! validate_jobs; then
-- 
2.43.0


