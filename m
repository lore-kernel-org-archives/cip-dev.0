Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E00C54FC6
	for <webhook@archiver.kernel.org>; Fri, 23 May 2025 14:48:01 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web10.49811.1748011672246570552
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 May 2025 07:47:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=YTtRFmzF;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-294854-20250523144748c9b60bd34ca36a4e6a-gbwwuv@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250523144748c9b60bd34ca36a4e6a
        for <cip-dev@lists.cip-project.org>;
        Fri, 23 May 2025 16:47:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=D+6LeO5/3PD5xLGmfjxJP2848xFrgh46iCdelPotCac=;
 b=YTtRFmzFxxIH78eQEgtquIuA0awc4iZOO8suVNQJzihcsuOJFCSADfgwCigja20J+RgCLD
 /ndHSDk4rPxbwGbfumWGAepd2hbswfgpZU9+PqFxEYzJS0ZHtFzGVp158n3fReCUUic7kq/z
 nnqCxb2mXjwKPJ9daP7deSWkswpEAY1oZgs+vicpCQ1mwhV9lDHZ6WMQM2TvdoqQmfvfaEnx
 vsFvhQyR0cNN5tMreQz01Zc7VGaLbLF6H2TvRKiDVm+N3Q7O3hOEYJwuiBGrakTUYPUAkHZ4
 7LKrZnlTTHldSc6R3NOqij27khiBv37FCb9wCSpRrhCtEQhQWqc0ZxpQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Subject: [isar-cip-core][PATCH v2 0/5] linux-cip: Add support for building branch heads, cleanups
Date: Fri, 23 May 2025 16:47:42 +0200
Message-ID: <cover.1748011667.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 May 2025 14:48:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18946

Changes in v2:
 - fix update-linux-cip.sh script
 - shellcheck cleanups for the latter
 - 4.19.325-cip120-rt42 kernel recipe update

This turned out to be trickier than I thought, but now it seems to work
fine. Please check.

Jan

Jan Kiszka (5):
  linux-cip: Prepare for building from git branches
  linux-cip: Add support for building head of development branches
  Expose kernel branch head recipes via kas option and Kconfig
  scripts/update-linux-cip.sh: Address shellcheck findings
  linux-cip: Update to 4.19.325-cip120-rt42

 Kconfig                                       | 11 ++++++
 kas/opt/kernel-head.yml                       | 18 ++++++++++
 recipes-kernel/linux/linux-cip-common.inc     |  9 +----
 recipes-kernel/linux/linux-cip-head.inc       | 34 +++++++++++++++++++
 ...x-cip-common.inc => linux-cip-release.inc} | 11 ++----
 .../linux/linux-cip-rt_4.19-cip-head.bb       |  1 +
 ...b => linux-cip-rt_4.19.325-cip120-rt42.bb} |  4 +--
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
 scripts/update-linux-cip.sh                   | 26 +++++++-------
 25 files changed, 99 insertions(+), 40 deletions(-)
 create mode 100644 kas/opt/kernel-head.yml
 create mode 100644 recipes-kernel/linux/linux-cip-head.inc
 copy recipes-kernel/linux/{linux-cip-common.inc => linux-cip-release.inc} (50%)
 create mode 120000 recipes-kernel/linux/linux-cip-rt_4.19-cip-head.bb
 rename recipes-kernel/linux/{linux-cip-rt_4.19.325-cip118-rt41.bb => linux-cip-rt_4.19.325-cip120-rt42.bb} (57%)
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


