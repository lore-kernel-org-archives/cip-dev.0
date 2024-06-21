Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAF6C27C4F
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 10:52:29 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.70036.1718967138933076106
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Jun 2024 03:52:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=O7xa9/zs;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202406211052152346c5b90d97622ee2-3ecxrm@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202406211052152346c5b90d97622ee2
        for <cip-dev@lists.cip-project.org>;
        Fri, 21 Jun 2024 12:52:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=ju6orkbP9e59pbgkve/TgEASDy7mcc4dCxl4uf7cq6Y=;
 b=O7xa9/zsr1aECtYksWYUkkClVEoWOSrMcWTcMS51wgMMC/N2PsxsPV2IcmiTXbyvnTEy3q
 soYf6lDax5iov3SQ/T9wS2/HuPm+GBa97sPzyKeNfrI7XwIJyGxBr/p5j/cgOkjXov+kakY5
 p2PiyVmOQIH5FukD4wEbvzvvTFxYQ=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 0/2] fixes and documentation
Date: Fri, 21 Jun 2024 12:12:27 +0200
Message-ID: <20240621105215.2233044-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Jun 2024 10:52:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16312

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add documentation to generate uefi compatible certificates from the
Debian snakeoil keys to use in the LAVA test infrastructure.

Add broken_system_clock for device with no battery puffered clock.

Quirin Gylstorff (2):
  doc: Add section howto generate the a efi auth file from snakeoil
    certs
  encryption: assume broken_system_clock for e2fsck before resize

 doc/README.secureboot.md                      | 20 ++++++++++++++++---
 .../files/encrypt_partition.script            |  7 ++++++-
 2 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.43.0


