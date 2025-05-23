Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84704C54F30
	for <webhook@archiver.kernel.org>; Fri, 23 May 2025 13:25:10 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.47931.1748006706509752272
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 May 2025 06:25:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=UHbcy/zq;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-20250523132503561dbe9ef39694a99a-nvdnxz@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250523132503561dbe9ef39694a99a
        for <cip-dev@lists.cip-project.org>;
        Fri, 23 May 2025 15:25:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=vENHg8duYjefysKwbfzRbaxKlsEr3qsrl0fqsRPb34E=;
 b=UHbcy/zq7JOb9QcpTiB6suyfgS/cFNfrgjheB0F655c75KEbJxr6oLc6tMmVpC7TS5Y0oh
 ZrFU6mb99MBh8Ubp+gC9Bn2P9PFVC/EDwntP5MdWPOq2xzdt+FDQ56aytZ4/SYq1rVXvqTAw
 kErRdlTDQOoCj+0l752QcHlHPgPFkyVaRc2NQz+hSmuABPxOJHOetwVASVhFl9aEbdo8W0wL
 xH5xeO59afc+EadhJfsAEqCmQu3zf5CuCNExzeRGWod7iNfiirkc4XDxGqX48IYRdY1VG+9B
 PBtlCyuDjV9xWMPgA9jSzseeUJqUA+F+RzJPrSm7rx/k8dlVknykdr8w==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 0/3] linux-cip: Add support for building branch heads
Date: Fri, 23 May 2025 15:24:59 +0200
Message-ID: <cover.1748006702.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 May 2025 13:25:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18941

This turned out to be trickier than I thought, but now it seems to work
fine. Please check.

Jan

Jan Kiszka (3):
  linux-cip: Prepare for building from git branches
  linux-cip: Add support for building head of development branches
  Expose kernel branch head recipes via kas option and Kconfig

 Kconfig                                       | 11 ++++++
 kas/opt/kernel-head.yml                       | 18 ++++++++++
 recipes-kernel/linux/linux-cip-common.inc     |  9 +----
 recipes-kernel/linux/linux-cip-head.inc       | 34 +++++++++++++++++++
 ...x-cip-common.inc => linux-cip-release.inc} | 11 ++----
 .../linux/linux-cip-rt_4.19-cip-head.bb       |  1 +
 .../linux-cip-rt_4.19.325-cip118-rt41.bb      |  2 +-
 .../linux/linux-cip-rt_4.4-cip-head.bb        |  1 +
 .../linux/linux-cip-rt_4.4.302-cip98-rt55.bb  |  2 +-
 .../linux/linux-cip-rt_5.10-cip-head.bb       |  1 +
 .../linux/linux-cip-rt_5.10.237-cip60-rt26.bb |  2 +-
 .../linux/linux-cip-rt_6.1-cip-head.bb        |  1 +
 .../linux/linux-cip-rt_6.1.134-cip41-rt22.bb  |  2 +-
 .../linux/linux-cip-rt_6.12-cip-head.bb       |  1 +
 .../linux/linux-cip_4.19-cip-head.bb          |  1 +
 .../linux/linux-cip_4.19.325-cip120.bb        |  2 +-
 .../linux/linux-cip_4.4-cip-head.bb           |  1 +
 .../linux/linux-cip_4.4.302-cip99.bb          |  2 +-
 .../linux/linux-cip_5.10-cip-head.bb          |  1 +
 .../linux/linux-cip_5.10.237-cip60.bb         |  2 +-
 .../linux/linux-cip_6.1-cip-head.bb           |  1 +
 .../linux/linux-cip_6.1.137-cip42.bb          |  2 +-
 .../linux/linux-cip_6.12-cip-head.bb          |  1 +
 .../linux/linux-cip_6.12.29-cip1.bb           |  2 +-
 24 files changed, 85 insertions(+), 26 deletions(-)
 create mode 100644 kas/opt/kernel-head.yml
 create mode 100644 recipes-kernel/linux/linux-cip-head.inc
 copy recipes-kernel/linux/{linux-cip-common.inc => linux-cip-release.inc} (50%)
 create mode 120000 recipes-kernel/linux/linux-cip-rt_4.19-cip-head.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_4.4-cip-head.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_5.10-cip-head.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.1-cip-head.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12-cip-head.bb
 create mode 120000 recipes-kernel/linux/linux-cip_4.19-cip-head.bb
 create mode 120000 recipes-kernel/linux/linux-cip_4.4-cip-head.bb
 create mode 120000 recipes-kernel/linux/linux-cip_5.10-cip-head.bb
 create mode 120000 recipes-kernel/linux/linux-cip_6.1-cip-head.bb
 create mode 120000 recipes-kernel/linux/linux-cip_6.12-cip-head.bb

-- 
2.43.0


