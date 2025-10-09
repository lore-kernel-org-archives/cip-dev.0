Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C753CCA470
	for <webhook@archiver.kernel.org>; Thu,  9 Oct 2025 05:41:54 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.5366.1759988512428794943
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Oct 2025 22:41:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm2 header.b=Nq9djsnd;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1324425-20251009054147e175ac735c00020735-g4uvta@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251009054147e175ac735c00020735
        for <cip-dev@lists.cip-project.org>;
        Thu, 09 Oct 2025 07:41:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=HFEgBWxxf5vCL1yMA8LtjJOBYVfQJWniTefohRBaciI=;
 b=Nq9djsndtrNQcRTbVv9LyLM5VD5iiD6xOE5J6LObIRj0FDrzeAiQcMRRCzsGzR2TusWkWc
 AxAd7+43bgG3naCVAFXDPo7NflFK4m1nFli4UnuLuauKH60Rq1d/1idKfxIJiOelxjhKWBOn
 fxL/v8RpDHWo8o2xg2aObVINXD86/Uko4CVMDS+nYPc5PdbQQ0X4PEjoYtS/Nv/YAOz9m32R
 L010S89Ka7Zqo+93uGhazY80e+1mWmGO8LfD91dCJJhwdd/q4as5eWm6oZUIVkpgtnAUIVx4
 HqBelBv5ZEkGy9OTvZTWmWP9/e4AOiaeJxAPVMNYhErfvPkUp85+h/ZQ==;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] kas: Update to 4.8.2
Date: Thu,  9 Oct 2025 11:14:48 +0530
Message-Id: <20251009054448.4134620-1-srinuvasan.a@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Oct 2025 05:41:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20163

From: Srinuvasan A <srinuvasan.a@siemens.com>

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 kas-container | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kas-container b/kas-container
index 0e99898..476724c 100755
--- a/kas-container
+++ b/kas-container
@@ -27,7 +27,7 @@
 
 set -e
 
-KAS_CONTAINER_SCRIPT_VERSION="4.8.1"
+KAS_CONTAINER_SCRIPT_VERSION="4.8.2"
 KAS_IMAGE_VERSION_DEFAULT="${KAS_CONTAINER_SCRIPT_VERSION}"
 KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
 KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
@@ -454,6 +454,7 @@ done
 [ -n "${KAS_CMD}" ] || usage
 
 KAS_EXTRA_BITBAKE_ARGS=0
+KAS_FILES=
 
 # parse kas sub-command options
 while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
@@ -686,12 +687,9 @@ if [ -n "${SSTATE_MIRRORS}" ]; then
 	set -- "$@" -e "SSTATE_MIRRORS=${SSTATE_MIRRORS}"
 fi
 
-# propagate timezone information
-if [ -f "/etc/localtime" ]; then
-	set -- "$@" -v "$(realpath -e "/etc/localtime")":/etc/localtime:ro
-fi
-if [ -f "/etc/timezone" ]; then
-	set -- "$@" -v "$(realpath -e "/etc/timezone")":/etc/timezone:ro
+# propagate timezone information to entrypoint (requires systemd 239)
+if command -v timedatectl >/dev/null; then
+	set -- "$@" -e "KAS_HOST_TZ=$(timedatectl show -p Timezone --value 2>/dev/null)"
 fi
 
 for var in TERM KAS_DISTRO KAS_MACHINE KAS_TARGET KAS_TASK KAS_CLONE_DEPTH \
-- 
2.34.1


