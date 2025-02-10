Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E567DC021AE
	for <webhook@archiver.kernel.org>; Mon, 10 Feb 2025 06:56:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.45359.1739170601641434793
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Feb 2025 22:56:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=MJt84YKY;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=
	1739170573;x=1740380173;bh=eIDWcM0KogPPmKrBjSMbQIpMtOC6EBMofc0Z3HAgAV0=;b=MJt
	84YKYY5VXTFdcObt/53systNGTThRv/k8pMkmmAQqrGtjxxmbXU/iECFb1W1F1VcGOfc8moNnzTeU
	llgiSDXUcz2v91nKxlfKBPoABTWGWQkB/yi6FpVqDCP9Oc8Xvh3B8hNutqgDn1J7w9wnzaBmViB66
	SWuwm3+JMahFYHPORK29X0IjF9etHqC9oMviK91du2U/ikKJlR8AApQ+S05yH90gey5gokiCRAsDj
	+siD5n4cEdKWVLZA19Q4kv2udv8GFFD21/85Bhoefa2WwJlpEHEbVTBQaNfmQ2EZsmY8/9odF71R7
	Og4ABstELMBIES7P4pc7d6eio7C3Wng==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 51A6uDjw789617; Mon, 10 Feb 2025 15:56:13 +0900
X-Iguazu-Qid: 2yAbUt1VDugivVrfoT
X-Iguazu-QSIG: v=2; s=0; t=1739170568; q=2yAbUt1VDugivVrfoT; m=hnpNrPuiNSf4u5s4rMPLy/NabaEX9XJOJJLONHi0Mec=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 51A6u6Yr482868
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:06 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 00/17] Backport fixes that depends on SYSTEM_SCHEDULING
Date: Mon, 10 Feb 2025 15:55:28 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Feb 2025 06:56:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17782

This is an alternative to another series[1].

The primary purpose of this series for v4.4-rt is to resolve problem that
WARNING in unpin_current_cpu() happens repeatedly while kernel is booting.
Please see commit message of the last patch (17/17) for more details
about the problem and how it's resolved.

This series consists of the following parts:

1-16: A patch series backported from mainline[2]. Its original purpose
      is to enable earlier might_sleep() and smp_processor_id(), but
      another role here is to introduces SYSTEM_SCHEDULING for 17.
17:   A fix for unpin_current_cpu() WARNING picked up from changes in
      v4.14-rt, which requires SYSTEM_SCHEDULING by the series above.

The commits from the backported series below are adjusted to v4.4-rt.
See comments around "Conflicts" in each commit for details.

ef284f5c Adjusted to handle 82611c14 not in v4.4.
b903dfb2 Ignored. The target code is added by d7b05582, but it's for
         deferred IOMMU support which should not be backported.
ff48cd26 Adjusted to handle cf775444 not in v4.4.

As v4.4-rt have been EOL already, it's not expected that this series
is applied to the branch anymore.
On the other hand, the Civil Infrastructure Platform Project (CIP)
has been maintaining its 4.4 SLTS RT kernel[3][4] based on v4.4-rt,
and needs to fix the problem above by this series.

It is much appreciated if RT experts could take a look at the series
and give feedbacks, especially about whether changes by the backported
series such as adding a new system_state are acceptable in regular
RT kernel maintenance so far and in the future (i.e. mainline based).

[1] https://lore.kernel.org/linux-rt-devel/Z6Nf32YB%2FJ0LMSPw@duo.ucw.cz/T/
[2] https://lore.kernel.org/all/20170516184231.564888231@linutronix.de/T/
[3] https://wiki.linuxfoundation.org/civilinfrastructureplatform/start#kernel_maintainership
[4] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt

Kazuhiro Hayashi (1):
  mm: slub: allocate_slab() enables IRQ right after scheduler starts

Thomas Gleixner (16):
  init: Pin init task to the boot CPU, initially
  arm: Adjust system_state check
  arm64: Adjust system_state check
  x86/smp: Adjust system_state check
  metag: Adjust system_state check
  powerpc: Adjust system_state check
  ACPI: Adjust system_state check
  mm: Adjust system_state check
  cpufreq/pasemi: Adjust system_state check
  iommu/vt-d: Adjust system_state checks
  async: Adjust system_state checks
  extable: Adjust system_state checks
  printk: Adjust system_state checks
  mm/vmscan: Adjust system_state checks
  init: Introduce SYSTEM_SCHEDULING state
  sched/core: Enable might_sleep() and smp_processor_id() checks early

 arch/arm/kernel/smp.c            |  3 +--
 arch/arm64/kernel/smp.c          |  3 +--
 arch/metag/kernel/smp.c          |  3 +--
 arch/powerpc/kernel/smp.c        |  2 +-
 arch/x86/kernel/smpboot.c        |  2 +-
 drivers/acpi/pci_root.c          |  2 +-
 drivers/base/node.c              |  2 +-
 drivers/cpufreq/pasemi-cpufreq.c |  2 +-
 drivers/iommu/intel-iommu.c      |  4 ++--
 drivers/xen/manage.c             |  1 +
 include/linux/kernel.h           |  6 +++++-
 init/main.c                      | 27 ++++++++++++++++++++++-----
 kernel/async.c                   |  8 ++++----
 kernel/extable.c                 |  2 +-
 kernel/printk/printk.c           |  2 +-
 kernel/sched/core.c              |  4 +++-
 lib/smp_processor_id.c           |  2 +-
 mm/slub.c                        |  2 +-
 mm/vmscan.c                      |  2 +-
 19 files changed, 50 insertions(+), 29 deletions(-)

-- 
2.30.2



