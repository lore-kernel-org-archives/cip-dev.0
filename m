Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBB4C54E55
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 09:07:53 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.17656.1709629665956422006
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 01:07:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=K8nhiefK;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-2024030509073333192822425b35ff84-0nmwrp@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2024030509073333192822425b35ff84
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Mar 2024 10:07:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=ETJGu2zVGYxWPMYJH5DssxUGWLbLoEiLm5+GQSebUww=;
 b=K8nhiefKknDSrjhvXGdLaJRGRHdtWvdiHxe1eu70lx2RwfUMIgl1Gtg5IbQNP6NL8iRjtB
 SIlfIKpJMgEMjWZzxJZ2pBDwMIPuFOkl46I3j1yDRYU6APqSPownKLe/36QoFO+Fv/zWeye9
 QQXNuUtugSlxKcBuZ1k0dSVTU6iyk=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 0/4] Version updates, snapshot-based RISC-V
Date: Tue,  5 Mar 2024 10:07:29 +0100
Message-Id: <cover.1709629653.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 09:07:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15212

See patches for details.

Jan

Jan Kiszka (4):
  linux-cip: Update to 4.19.306-cip107-rt35 and 6.1.80-cip16[-rt9]
  Switch sid-based riscv64 back to a snapshot
  Update Isar to release 0.10
  linux-cip: Update cip-kernel-config

 conf/distro/cip-core-sid.conf                                 | 3 +++
 conf/distro/cip-debian-sid-snapshot.list                      | 2 ++
 kas-cip.yml                                                   | 2 +-
 recipes-kernel/linux/cip-kernel-config.inc                    | 4 ++--
 ...99-cip105-rt34.bb => linux-cip-rt_4.19.306-cip107-rt35.bb} | 2 +-
 ...t_6.1.75-cip14-rt8.bb => linux-cip-rt_6.1.80-cip16-rt9.bb} | 2 +-
 .../{linux-cip_6.1.75-cip14.bb => linux-cip_6.1.80-cip16.bb}  | 2 +-
 7 files changed, 11 insertions(+), 6 deletions(-)
 create mode 100644 conf/distro/cip-debian-sid-snapshot.list
 rename recipes-kernel/linux/{linux-cip-rt_4.19.299-cip105-rt34.bb => linux-cip-rt_4.19.306-cip107-rt35.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.75-cip14-rt8.bb => linux-cip-rt_6.1.80-cip16-rt9.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_6.1.75-cip14.bb => linux-cip_6.1.80-cip16.bb} (59%)

-- 
2.35.3


