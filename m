Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA15C02194
	for <webhook@archiver.kernel.org>; Tue,  4 Feb 2025 00:48:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.104839.1738630098212599436
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Feb 2025 16:48:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=YOjweMAN;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=
	1738630064;x=1739839664;bh=Si4bOR8QQPaDpVUBhSkWZmqPbmWYfv7MTbe/67PUgP0=;b=YOj
	weMAN1C7Hy43el+MI+4tlorZWJMOStJCuiKBnVLs06pIiRqTYZDyHLFaJxw0SbRPtx6mjQ1WxxwYI
	0uS4dwEkZLjAm9ObomImZG67hDJDqGbBnajtIiiDPm/8vAPVLqn/DYbSL94lcu2sKfxI5sWibyD24
	BNNYnr+V9beLLZtc/4MWCC6HGQPZmCOgKh8/2pMrFv8Dph+8Pl0IzUlEwtuSJ2a8eVG58F0kJ82Yt
	42B+zZFjAb7zR/RmsgMMsGtXWj4jcf0asUq8YzUlXmm97oH3hxYCZDRSQI2dSsNp19hzxXZYybZOK
	ISi4Qlk5whf5B5zI9pL3xwOXea7APNA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 5140lgJN4066260; Tue, 4 Feb 2025 09:47:43 +0900
X-Iguazu-Qid: 2rWh5b6vESC8CgKcan
X-Iguazu-QSIG: v=2; s=0; t=1738630062; q=2rWh5b6vESC8CgKcan; m=hDviWYt8PzLl5GDgSBVLdPWMXaTHyLbrfYk/J+DCCfU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 5140leUm491300
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 09:47:40 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 4.9 v1 0/2] Fix repeated WARNING in unpin_current_cpu()
Date: Tue,  4 Feb 2025 09:46:02 +0900
X-TSB-HOP2: ON
Message-Id: <1738629964-11977-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Feb 2025 00:48:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17740

This is a patch series for v4.4-rt and v4.9-rt to resolve problem that
WARNING in unpin_current_cpu() happens repeatedly while kernel is booting.
Please see commit message of the second patch (2/2) for more details about
the problem and how it's resolved. The first patch (1/2) is a preparation
for the fix (2/2), considering compatibility issue in future updates.

As the both v4.4-rt and v4.9-rt have been EOL already, it's not expected
that this series is applied to the branches anymore.
On the other hand, the Civil Infrastructure Platform Project (CIP)
has been maintaining its 4.4 SLTS RT kernel[1][2] based on v4.4-rt,
and needs to fix the problem above by this series.

It is much appreciated if RT experts could take a look at the series
and give feedbacks about its way to resolve the problem, which is
based on the same approach as changes happend around v4.14-rt.

[1] https://wiki.linuxfoundation.org/civilinfrastructureplatform/start#kernel_maintainership
[2] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt

Kazuhiro Hayashi (2):
  init: Introduce system_scheduling flag for allocate_slab()
  mm: slub: allocate_slab() enables IRQ right after scheduler starts

 include/linux/kernel.h |  1 +
 init/main.c            | 12 ++++++++++++
 mm/slub.c              |  3 ++-
 3 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.30.2



