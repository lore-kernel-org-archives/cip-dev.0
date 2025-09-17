Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E54CAC5A0
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 08:01:21 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.17577.1758096070430720474
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Sep 2025 01:01:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=dp6ZxGYG;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-20250917080106b559c840f00002079a-t2rgix@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250917080106b559c840f00002079a
        for <cip-dev@lists.cip-project.org>;
        Wed, 17 Sep 2025 10:01:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=2B8xyRs8S2PDq6ku9qdE0IHm5V65rDIfAzWoLVE0tEE=;
 b=dp6ZxGYGLNKIb5opd0YAhV2Y8dbsw42dDmaE3acj0wIDAJRhsHsMSyZ1nNSff6qbN9PV78
 3pDuIrYdywzIQZfcqF5/dsx+mVsOd9sk4dI6Yv/Ewtrf+DVw2NHNyzmBP0MTzQPnLdgy7seX
 i2CS2c25uusbz+5Ytf2ruSBksDXOf9FJHqMp+s2XGe3fAPDUTW3wfT1A5KrP+ljKvG/SYZEj
 /ZRoZ2NDWpKNwGIe8yQrB9vKutiM2ky5t3CjBXLOpINYVkCXrY/NLrnUMYGMzbxn8mgkG6qR
 GsqVReR3KnxkA9qQpivkxfsLOG9COw9n9bwuxeAhl9TGlxwwna5KSmxA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 0/3] ci improvements
Date: Wed, 17 Sep 2025 10:01:03 +0200
Message-ID: <cover.1758096066.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Sep 2025 08:01:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20069

Primarily speeds up lava jobs by using our own container.

Jan

Jan Kiszka (3):
  ci: Do not attach cve-checks to scheduled pipelines
  ci: Add job to build own lavacli container for tests
  ci: Switch test jobs to self-built lavacli container

 .gitlab-ci.yml             | 22 +++++++++++++++++++---
 scripts/Dockerfile.lavacli | 17 +++++++++++++++++
 scripts/submit_lava.sh     |  2 --
 3 files changed, 36 insertions(+), 5 deletions(-)
 create mode 100644 scripts/Dockerfile.lavacli

-- 
2.51.0


