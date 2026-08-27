Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A8BC61DCB
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 06:23:06 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30489.1787811782170974286
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 23:23:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=S7zmiIiv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-202608270622591416033911000207ca-ysr44e@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202608270622591416033911000207ca
        for <cip-dev@lists.cip-project.org>;
        Thu, 27 Aug 2026 08:22:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8wrMiX9dn/cScYdbzB5YmHv0mdfwXhmXIosEGVOLSyY=;
 b=S7zmiIivrwcH34hJpYKxo4dRGyZGdkdsmIefASui0J6ql33YPu0jPkXln8ao43NhcrE7yF
 PLxbSd8KOLpZPKbq29oyaKOHN9BGeXvaV2Z5MTl/g/rar3xvuy5w6PKWcvIsqpbY07L/Malm
 YjpSqCAWWXr1WQz73XZkPN+/CR3iwqUoSLrTz2wETeUnqxNm5PXyKx+5HjHPDTkWmYymLsb3
 GqjJqh5F3EMn5r7vY/5gqHsHXeDxRukA0XSlD185psFNqEEV+CiLHYYoSGF0KBHvFnlVQVP9
 aWnfpG5mXKji1d1SJcu4+/sj21E23fY9pseQzwUstGcLk/VApFFWiG6A==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Felix Moessbauer <felix.moessbauer@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Michael Adler <michael.adler@siemens.com>
Subject: [isar-cip-core][PATCH v3 4/5] update README.md for rootless build
Date: Thu, 27 Aug 2026 08:22:56 +0200
Message-ID: <fd1223cbad9062cc9598e0170f487d70f69a2783.1787811777.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787811777.git.jan.kiszka@siemens.com>
References: <cover.1787811777.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Aug 2026 06:23:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24035

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
[Jan: adjust wording, reference kas docs]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 README.md | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/README.md b/README.md
index 05291744..f84adadc 100644
--- a/README.md
+++ b/README.md
@@ -10,10 +10,9 @@ from scratch.
 
 ## Building Target Images
 
-Install docker or podman and make sure you have required permissions to start
-privileged containers. For docker, you need to be part of respective docker
-group (`sudo usermod -aG docker <USER>`). Privileged podman requires sudo
-rights for the caller (`<USER> ALL=(root) SETENV: /usr/bin/podman` in sudoers).
+Install docker or podman. For true unprivileged builds, podman is recommended.
+See [kas documentation](https://kas.readthedocs.io/en/latest/userguide/kas-container.html)
+for more details.
 
 Open up the image configuration menu and select the desired target and its
 options:
-- 
2.47.3


