Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D04EC54754
	for <webhook@archiver.kernel.org>; Tue, 20 May 2025 12:43:52 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.19994.1747745027012003524
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 May 2025 05:43:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Yz4z+Dnd;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-202505201243433db269a9f46d01a8d0-phason@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202505201243433db269a9f46d01a8d0
        for <cip-dev@lists.cip-project.org>;
        Tue, 20 May 2025 14:43:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=iGd1hFnmWvXXXZJQqaBpMGIQHETvNaWfZqERKywel0c=;
 b=Yz4z+Dnd13hfrRLnAcWvzxIjndh4EF5MLYrHaQUJfZPSxr2+ZuF0vhRq0A0iAV9IqXaJXF
 W56TiG6u3h4LcMQZ5qxTlgUIPybuvTz0AJgoGl+QY8Z/T8+QkLkQGwPZball9D4b/tyAv9mU
 xcapOEEHH4099zskS554aZX28zyAfLnWEX0q7sv4qv7cRsxSkA+Y/TNRdhtFfGTlXDXvDz/P
 5mKSV5zMN19U+A98DC7c3WIe2PCjyoLEF/hRj9sumvOH6YAiFjed2EM1MDTYbONy1oh79D/I
 uRT5wfnhnPRd2W6cvoAwBenJD5nmRSnnsN3IVCygCLCeQr04Ar2TF+Tw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 0/4] Add support for 6.12 CIP kernel and more
Date: Tue, 20 May 2025 14:43:38 +0200
Message-ID: <cover.1747745022.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 May 2025 12:43:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18929

See patches for details.

Jan

Jan Kiszka (4):
  linux-cip: Fold rt-specific include into a single file
  linux-cip: Bump cip-kernel-config revision
  Add support for CIP kernel 6.12
  trixie: Drop pinning on snapshot version

 Kconfig                                       |  4 +++
 conf/distro/cip-core-common.inc               |  3 +-
 conf/distro/cip-core-trixie.conf              | 10 ++-----
 kas/opt/6.12.yml                              | 18 +++++++++++
 recipes-kernel/linux/cip-kernel-config.inc    |  2 +-
 recipes-kernel/linux/linux-cip-common.inc     |  3 +-
 recipes-kernel/linux/linux-cip-rt-common.inc  | 15 ----------
 .../linux-cip-rt_4.19.325-cip118-rt41.bb      |  4 +--
 .../linux/linux-cip-rt_4.4.302-cip98-rt55.bb  |  4 +--
 .../linux/linux-cip-rt_5.10.237-cip60-rt26.bb |  4 +--
 .../linux/linux-cip-rt_6.12.29-cip1.bb        |  1 +
 .../linux/linux-cip_6.12.29-cip1.bb           | 10 +++++++
 scripts/update-linux-cip.sh                   | 30 +++++++++++--------
 13 files changed, 65 insertions(+), 43 deletions(-)
 create mode 100644 kas/opt/6.12.yml
 delete mode 100644 recipes-kernel/linux/linux-cip-rt-common.inc
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.29-cip1.bb
 create mode 100644 recipes-kernel/linux/linux-cip_6.12.29-cip1.bb

-- 
2.43.0


