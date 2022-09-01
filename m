Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17DAECAAD3
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 13:49:23 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web08.12452.1662040155781745038
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Sep 2022 06:49:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=TuluuDIs;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-294854-20220901134912c10601d71a19bbcbd2-nqb2px@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20220901134912c10601d71a19bbcbd2
        for <cip-dev@lists.cip-project.org>;
        Thu, 01 Sep 2022 15:49:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=jjBGyCOVMLyD87HSAOq5Zgscb0qGt+xhvk9pif2sQKo=;
 b=TuluuDIsvvuDA3uxYQpdNnmZRtOgOauCC3RAoSTyFrWbGezBjgf1XW+2s87aMcgszuSboA
 vaHcEo/zhUuQbbzJGMJOnpYhuu/FH8NkdFyu7TDO3VFMNYHADqtJs4Qa4trI2QRmSvMXqDoa
 T41Nb+ckcAfDh0345p1AeEcIxwWiY=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 0/3] CI fixes and cleanups
Date: Thu,  1 Sep 2022 15:49:09 +0200
Message-Id: <cover.1662040151.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Sep 2022 13:49:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9422

See patches for details.

Jan

Jan Kiszka (3):
  ci: Switch qemu-amd64-secure-boot-buster to 5.10 kernel
  ci: Clean up redundant statements
  ci: Rename empty extension case

 .gitlab-ci.yml             | 11 +++--------
 scripts/deploy-cip-core.sh |  2 +-
 2 files changed, 4 insertions(+), 9 deletions(-)

-- 
2.35.3


