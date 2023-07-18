Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26064EB64DC
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 17:00:45 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.1274.1689699636726838901
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jul 2023 10:00:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=kASUP3hL;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-202307181700339af388c753839e8cf7-uqfazv@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202307181700339af388c753839e8cf7
        for <cip-dev@lists.cip-project.org>;
        Tue, 18 Jul 2023 19:00:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=TqchA7dLfNwWzTogoaozu2gGT0qJ8YmDv58+xLyIJB0=;
 b=kASUP3hL8neWa37WdJZbzMTKSNGbbigE/V+BcWZaa9/sGvqxrz5h2arDoVTLKSzmgv6Kh/
 T4uKQljaBIQdwkRZvc0L1Kv4TcKPlippZeUrph3FfZhDLtAGwcASqwwWM70hokL8mp40F8VB
 QXiQc7Ws8KNHUTLJsXbc362G5ss60=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 5.10.y-cip 0/2] watchdog: iTCO_wdt: Backport patches to enable handle_boot_enabled=0
Date: Tue, 18 Jul 2023 19:00:30 +0200
Message-Id: <cover.1689699632.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 17:00:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12413

These patches are needed in order to make iTCO_wdt respect
handle_boot_enabled=0, i.e. to step back from a running watchdog until
userspace picks it up. Up to 5.16, the driver simply stopped the
watchdog which could have created a non-monitored window during boot-up
in the handover from the firmware starting it to userspace (typically
sytemd) safely driving. E.g., any infinite loops in the initramfs would
could have created a locked-up system.

These patches were proposed to the watchdog maintainers for official
stable integration  [1] but received no reaction so far. As the issue is critical for
CIP's OTA software update integration, let's use the CIP path instead.

I don't have any test setup for 4.19, so I'm only proposing this for
5.10 here.

Jan

[1] https://lore.kernel.org/linux-watchdog/e9c2d0a5-9618-b616-3be3-826cc0665388@siemens.com/T/#t

Mika Westerberg (2):
  watchdog: iTCO_wdt: No need to stop the timer in probe
  watchdog: iTCO_wdt: Set NO_REBOOT if the watchdog is not already
    running

 drivers/watchdog/iTCO_wdt.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

-- 
2.35.3


