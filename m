Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4CBC4332F
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 16:48:28 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web09.13318.1664902101744116780
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 09:48:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=SS5VSq0A;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225,
 mailfrom: fm-294854-20221004164819a8a5ea8ab85282ce68-aak75d@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20221004164819a8a5ea8ab85282ce68
        for <cip-dev@lists.cip-project.org>;
        Tue, 04 Oct 2022 18:48:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=+Qz6xLbS4XfMOwT8SXiB9nLUPHdDS3MSTHzoY1C52qI=;
 b=SS5VSq0Aw65OndCAU4K3OYIQn7QYvlkWP9EHDsjKiShcqpfcLH0zBsBj6w/z4vfJFo+jjD
 /8E7NGZdiD38WD3BuYXL36kmGwuAI6E/Z/NNaBG/sx4vc9XJMWi92MHk5ythhO4H20noJ7EV
 SxS5jN9z8smPfBqStUyXxyI0FZKd8=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 01/12] ci: Allow to set per-project
 DISTRO_APT_PREMIRRORS
Date: Tue,  4 Oct 2022 18:48:07 +0200
Message-Id: 
 <59a3e597e7867bb7f27e53432a9e6af88c4ffba5.1664902098.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1664902098.git.jan.kiszka@siemens.com>
References: <cover.1664902098.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 16:48:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9624

From: Jan Kiszka <jan.kiszka@siemens.com>

Can be helpful to work around deb.debian.org glitches, specifically when
the distance of a runner to its next mirror is well known.

To allow passing this to bitbake, kas has to list this variable
explicitly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 1 +
 kas-cip.yml    | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ce40b5d7..f7c8c889 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -22,6 +22,7 @@ default:
     - export no_proxy=$NO_PROXY
     - export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
     - export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
+    - export DISTRO_APT_PREMIRRORS=$DISTRO_APT_PREMIRRORS
 
 .build_base:
   stage: build
diff --git a/kas-cip.yml b/kas-cip.yml
index d005b812..4956da5c 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -41,3 +41,6 @@ local_conf_header:
     USERS += "root"
     # 'root'
     USER_root[password] = "oC3wEGl799tZU"
+
+env:
+  DISTRO_APT_PREMIRRORS: ""
-- 
2.35.3


