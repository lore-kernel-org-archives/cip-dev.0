Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF36D11708
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:21:38 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3934.1764667289525522672
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:21:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=Ktbe5zDu;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-2025120209212197cf9b3a01000207a9-jff3e3@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2025120209212197cf9b3a01000207a9
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 Dec 2025 10:21:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=X39NS4xsJtdzgRRatDdniUMaflJfJjyjAKx0ma8jJMg=;
 b=Ktbe5zDuOqv+MGNy2+wDWmUaC76Qh1NWP/Ik7PXyW8i3zEZ6W6T3ZaIiVCgsfI6K/zIrUq
 LoxtOmJEj5z/vBNf22VneEY6TESDSbKDcIfyNW/rP2JkJ7hcypvpZt7O/QUgdti6afT7Ht9G
 GM8+G11YwVKbU8WAw3eZq/vEcqqYg/EnLtpQd5zd3ORM+lzIKD7UYgtYOqJVfr6KuhZjuMiq
 scgM0ydFw1ksrK1bae5192Zce0jA7YAIRr/U+aopCZ5lxvMVVFoh2kYhaZsBsTnzf265947N
 AfMXGQEMLTCRlc0FboKj0VIXverxeQVEUPxnmCqOoeD+hAtMhJ8jmyZw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 06/14] ci: Inject image version into common cip-core-image.inc
Date: Tue,  2 Dec 2025 10:21:11 +0100
Message-ID: <e5d8e96643b4de333c25894970c6dd39e78ec601.1764667279.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1764667279.git.jan.kiszka@siemens.com>
References: <cover.1764667279.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 09:21:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20793

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to use "build_swu_v2" also for other images than security.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 28b235d1..697de681 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -83,7 +83,7 @@ default:
               cp build/tmp/deploy/images/${target}/*.squashfs build/previous-image;
           fi;
           cp build/tmp/deploy/images/${target}/linux.efi build/previous-image;
-          echo "PV = \"2.0\"" >> recipes-core/images/cip-core-image-security.bb;
+          echo "PV = \"2.0\"" >> recipes-core/images/cip-core-image.inc;
           kas build ${base_yaml}:kas/opt/delta-update.yml;
           scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} swu;
       fi
-- 
2.51.0


