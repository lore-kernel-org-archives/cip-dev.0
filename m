Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BE4C6FD1D
	for <webhook@archiver.kernel.org>; Thu, 23 Mar 2023 13:43:40 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.72965.1679579014313176784
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Mar 2023 06:43:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=ct5dp0F3;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-202303231343318844bad39616498b76-d8mpux@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202303231343318844bad39616498b76
        for <cip-dev@lists.cip-project.org>;
        Thu, 23 Mar 2023 14:43:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=UCFml8zW0QjvXfghXdenuNmPPa+3j8VPBy/iPQXdIEg=;
 b=ct5dp0F301Okkg3ywZCUQExtEH2Xz6FxQPqqJ1AYUh528+RYUlI8858TO3qL+6LlkMkgZ8
 n8dr+oAB191M30QnjQ8Qyvk7/98dzCe8dPYwabJjU0xNjmhnIJdcSm4fAD+vmd1hMTP61Qy6
 T26T3lnwxK0iL5W74ZkWVNYOzcm8U=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 0/3] Enable TPM-based encrypted data partition also for qemu-arm/arm64
Date: Thu, 23 Mar 2023 14:43:27 +0100
Message-Id: <cover.1679579010.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Mar 2023 13:43:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11102

Simple follow-up to the already existing enabling for x86, so I think we
can safely squeeze this after rc1 and before final 1.0.

Jan

Jan Kiszka (3):
  linux-cip: Bump cip-kernel-config revision
  kconfig: Allow to select encryption also for qemu-arm and qemu-arm64
  start-qemu: Add TPM support also for arm and arm64

 Kconfig                                   | 2 +-
 recipes-kernel/linux/linux-cip-common.inc | 2 +-
 start-qemu.sh                             | 8 +++++++-
 3 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.35.3


