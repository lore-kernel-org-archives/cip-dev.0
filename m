Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C05ECD343B
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 06:57:19 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33453.1777964231943214776
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 23:57:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=brsVYNrf;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-20260505065707914a3bce3300020736-4ysxks@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260505065707914a3bce3300020736
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 May 2026 08:57:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=vSqU5fyNaF/VARyg9I1UKDuYQCXCqDqVXV97NtUE8zI=;
 b=brsVYNrf6kpwPcQhNCL4Qd1TG0Ep3qp0G6z7lNIR6t7s/ZH24WEjiYnWrgrQecWBQ8f40b
 6mGZNPpCs1Xo/asaBwjMSXpuLOmlf2yuwkB/dckFpTt7cauk8F/OUnOTBVgm1KWRxfo50Ro0
 ukDV+czM8qYvQhyeryt4cMTEldm9t2jx6bozLCkrkv8WL227Z5C82Qk3PIgS75J43gjOKctj
 kcB9NQuh9cjYZEFnqZzb9T45KHJ6wpCvF9XusZhNO7sYPJTy4sC28YW5/VZnCs4x5HKZLpYF
 8V34uLldcYK6NcmAJWIXk8X95/aftdvx9Yrbqk+XY6jVZ+mSoqmF1Nyw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	Sebastian Siewior <bigeasy@linutronix.de>
Subject: [RFC][PATCH 6.12.y-cip 00/12] Backport PREEMPT-RT support for ARM 32-bit
Date: Tue,  5 May 2026 08:56:54 +0200
Message-ID: <cover.1777964226.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 06:57:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22868

A first attempt to backport the recently merged ARM 32-bit support of
PREEMPT-RT from 7.1 to 6.12-cip. Only lightly tested so far, first of
all looking for feedback regarding completeness.

This may also be valuable for 6.12-rt as this series should be able to
replace all patches tagged with {ARM:,arm:} in v6.12.79-rt17 - adding
Daniel.

Jan

Russell King (Oracle) (10):
  ARM: group is_permission_fault() with is_translation_fault()
  ARM: allow __do_kernel_fault() to report execution of memory faults
  ARM: fix hash_name() fault
  ARM: fix branch predictor hardening
  ARM: ensure interrupts are enabled in __do_user_fault()
  ARM: move vmalloc() lazy-page table population
  ARM: move is_permission_fault() and is_translation_fault() to fault.h
  ARM: use BIT() and GENMASK() for fault status register fields
  ARM: move FSR fault status definitions before fsr_fs()
  ARM: provide individual is_translation_fault() and
    is_permission_fault()

Sebastian Andrzej Siewior (1):
  ARM: 9463/1: Allow to enable RT

Thomas Gleixner (1):
  ARM: 9459/1: Disable jump-label on PREEMPT_RT

 arch/arm/Kconfig        |   3 +-
 arch/arm/mm/alignment.c |   6 +-
 arch/arm/mm/fault.c     | 222 +++++++++++++++++++++++-----------------
 arch/arm/mm/fault.h     |  42 ++++++--
 4 files changed, 173 insertions(+), 100 deletions(-)

-- 
2.47.3


