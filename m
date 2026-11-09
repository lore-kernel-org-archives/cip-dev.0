Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3947.1794223245921900463
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 03:20:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=WIRH9jrq;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20261109112042abfd8433bf000207d6-dpjr1y@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20261109112042abfd8433bf000207d6
        for <cip-dev@lists.cip-project.org>;
        Mon, 09 Nov 2026 12:20:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=yaBWQSGqFQeUkafqycRZfX/RgpDgNiHXi2omhTSXC4U=;
 b=WIRH9jrqo7dfwXAuNdtJrqB+EPuEBsfbvKAQXGxemuW46Zt2iONZkXLD5NTUk9Ae0qeuXd
 qrSlojscEANeQj79vSJ/C4D81LrB11aMGr/Efsdylxo+m9hXXnHKi2ftVevQ3rV0dasIJ+Ye
 xH6hYdcYniRZTwgs7x0vFxGyChDYwIS4F7uu+niseJEejGCp6a07Ze9Q4rUnm8fjYGncKtEp
 fP7YPhUB7MhIOqZ6nhg/ZvS7Ilq1xkgzUWOUphroW3meaz10PR6jWD1kvnbHtcgmMNd1+mqp
 Ifx5a49T63vLqFkHlaaZ+B5oiGjVjT7v4z42Rn88cIoN4fdDzEbf1rbQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: Daniel Wagner <wagi@monom.org>,
	Bryan Brattlof <bb@ti.com>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Pasquale Nieddu <pasquale.nieddu@siemens.com>
Subject: [PATCH 6.12.y-cip v2 0/6] Backport PREEMPT-RT support for ARM 32-bit
Date: Mon,  9 Nov 2026 12:20:35 +0100
Message-ID: <cover.1794223241.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 11:20:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24698
Content-Type: text/plain; charset="utf-8"

As a full backport via stable was rejected, this is targeting CIP 6.12
with the required changes from upstream to enable PREEMPT-RT on ARM
32-bit.

The series was derived from the ARM-specific backlog in v6.12-rt-rebase,
only reconstructing it from the corresponding upstream commits - maybe
worth to consider for stable-rt as well.

Jan

Sebastian Andrzej Siewior (5):
  ARM: 9423/1: vfp: Provide vfp_state_hold() for VFP locking.
  ARM: 9424/1: vfp: Use vfp_state_hold() in vfp_sync_hwstate().
  ARM: 9425/1: vfp: Use vfp_state_hold() in vfp_support_entry().
  ARM: 9426/1: vfp: Move sending signals outside of vfp_state_hold()ed
    section.
  ARM: 9463/1: Allow to enable RT

Thomas Gleixner (1):
  ARM: 9459/1: Disable jump-label on PREEMPT_RT

 arch/arm/Kconfig         |  3 +-
 arch/arm/vfp/vfpmodule.c | 74 ++++++++++++++++++++++++++++------------
 2 files changed, 55 insertions(+), 22 deletions(-)

-- 
2.47.3

