Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C1BD14898
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 03:01:30 +0000 (UTC)
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23765.1767841283032059762
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 19:01:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=twHjJJUf;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=GWD3yeLb;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.168, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1767841261; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GpRR4w78Dk6tMAQ3Qto+dtnIoQ83+vC7UTpoFFMWuDECRCwWVHc+ncz34Q26Y4x7fr
    97iYRd2E54+6pI6eRj59c+1nN9o7BjoIXCzTOLwaCcxc23V9JV29lal4AUh5eo96VTq3
    soZv2KAezZR55pgBntOY2YJNTg9FNrQkk3Zpzm0PgrGrzcvrnzBKJMXujUdqr+rUIxpA
    4K+aXn74NaKDJ4HSv7BfoEGUFwcpC5kpegLwNwmhHYk9CGy0VmEIHJBGtYcoVS4L513X
    PjVwn+mkBSsZt25vviPnu3zIej9cH1j6Eh0kIwClrUsVU5ApGPs5ojDZhHG5L8z5a/Mr
    oKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767841261;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=928LoR+7nIZ2oV+JuIma7HiB6PL86PQStPZG21NyXRw=;
    b=Ulht5GW8LZg+UmUvLzKPH+yJcAOHMKFGlj14IHk99ldfBu8zBaHXPbS2ltd8C/Bt3r
    f/QvHkwdg7H8kNCUAoei4FdxLpArPlZwHKaey6BO5GIfXciXOpyGdocXUTVF52E3/keU
    H2qqoPz9xw72KJ4wR5S50iRYfRjVbySxLS3V0BZL09QsxuUvhZrakup1g+OiYXRnBE07
    vcE/nKLerA1tRYprUhworN9HYu9zDvtgwnBQ2870A5vwm4U6Dv5SVUVmsvNpbsdPRtQB
    7IPngbiXzjeSpWz+gwHW3Iwslf1M8ruUMi6NF6/QJM6sQa2DbWFML3WJKUFLwbH5jKx1
    3g7A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767841261;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=928LoR+7nIZ2oV+JuIma7HiB6PL86PQStPZG21NyXRw=;
    b=twHjJJUfwM067qD4PgK18JhQ/9BrKlREcUa9ya8oBbI4o8ealXlSGNR9qeERBGCqI8
    X9Amw0ud3FsHlj4wXkftPT4G/PvNHFS/oQ7MNLdecWB3WWg0FkRGwaYrH0VnPqV3gX1+
    K/afiNNYfftrLXH1cNrnQlkRJbpl0HxbSBf1CXmJ6tWwRtz4KwOQS+bAwDy5oaZJpFBI
    oVDjAqCp/BlECud1nL3sOag3pqOgBaDSDwMQSS4dA+8NAMqTUnkA74KfJA607lwc0Gu5
    i2+Z/lZyyetyNI+tG9UHkXdaDfcA/r79d5MAqiwRF1NWmojoNAYK81ojO00PyOboSFP3
    gyEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767841261;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=928LoR+7nIZ2oV+JuIma7HiB6PL86PQStPZG21NyXRw=;
    b=GWD3yeLbsqvnfk11+nBKZ0ZKDdoXwDmBaHHXgQNk0AImalllvVtVZZB5PscxlYqCwQ
    hGDAX6KejsBdSUA93aCw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGvRy6JA=="
Received: from open-xchange-core-mw-gw-33.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 54.1.0 AUTH)
    with ESMTPSA id zfda17208311Vki
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 8 Jan 2026 04:01:01 +0100 (CET)
Date: Thu, 8 Jan 2026 04:01:01 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <412566056.426263.1767841261029@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip106
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 46760
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 03:01:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21432

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip106. The linux-4.4.y-cip tree's base version has been updated to v4.4-st71. The trees are up-to-date with kernel 4.19-st11.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip106:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      c97310ca688eb68384906f39428c5ed41f27ef86
    Fixed CVEs:
      CVE-2024-47666: scsi: pm80xx: Set phy->enable_completion only when we wait for it
      CVE-2025-39866: fs: writeback: fix use-after-free in __mark_inode_dirty()
      CVE-2025-40040: mm/ksm: fix flag-dropping behavior in ksm_madvise
      CVE-2025-40083: net/sched: sch_qfq: Fix null-deref in agg_dequeue
      CVE-2025-40211: ACPI: video: Fix use-after-free in acpi_video_switch_brightness()
      CVE-2025-40253: s390/ctcm: Fix double-kfree
      CVE-2025-40259: scsi: sg: Do not sleep in atomic context
      CVE-2025-40264: be2net: pass wrb_params in case of OS2BMC
      CVE-2025-40271: fs/proc: fix uaf in proc_readdir_de()
      CVE-2025-40281: sctp: prevent possible shift-out-of-bounds in sctp_transport_update_rto
      CVE-2025-40282: Bluetooth: 6lowpan: reset link-local header on ipv6 recv path
      CVE-2025-40283: Bluetooth: btusb: reorder cleanup in btusb_disconnect to avoid UAF
      CVE-2025-40304: fbdev: Add bounds checking in bit_putcs to fix vmalloc-out-of-bounds
      CVE-2025-40308: Bluetooth: bcsp: receive data only if registered
      CVE-2025-40309: Bluetooth: SCO: Fix UAF on sco_conn_free
      CVE-2025-40312: jfs: Verify inode mode when loading from disk
      CVE-2025-40321: wifi: brcmfmac: fix crash while sending Action Frames in standalone AP Mode
      CVE-2025-40322: fbdev: bitblit: bound-check glyph index in bit_putcs*
      CVE-2025-40345: usb: storage: sddr55: Reject out-of-bound new_pba
      CVE-2025-40363: net: ipv6: fix field-spanning memcpy warning in AH output
      CVE-2025-68168: jfs: fix uninitialized waitqueue in transaction manager
      CVE-2025-68177: cpufreq/longhaul: handle NULL policy in longhaul_exit
      CVE-2025-68185: nfs4_setup_readdir(): insufficient locking for ->d_parent->d_inode dereferencing
      CVE-2025-68194: media: imon: make send_packet() more robust
      CVE-2025-68241: ipv4: route: Prevent rt_bind_exception() from rebinding stale fnhe
      CVE-2025-68245: net: netpoll: fix incorrect refcount handling causing incorrect cleanup
      CVE-2025-68288: usb: storage: Fix memory leak in USB bulk transport
      CVE-2025-68289: usb: gadget: f_eem: Fix memory leak in eem_unwrap
      CVE-2025-68302: net: sxgbe: fix potential NULL dereference in sxgbe_rx()
      CVE-2025-68312: usbnet: Prevents free active kevent
      CVE-2025-68331: usb: uas: fix urb unmapping issue when the uas device is remove during ongoing data transfer
      CVE-2025-68339: atm/fore200e: Fix possible data race in fore200e_open()
      CVE-2025-68734: isdn: mISDN: hfcsusb: fix memory leak in hfcsusb_probe()

Best regards,
Ulrich Hecht

