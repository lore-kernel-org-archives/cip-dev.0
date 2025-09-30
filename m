Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFE6CAC5B8
	for <webhook@archiver.kernel.org>; Tue, 30 Sep 2025 15:45:41 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
 by mx.groups.io with SMTP id smtpd.web11.28724.1759247138586987129
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Sep 2025 08:45:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=aInWnRmR;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.217, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1759247120; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Pc/MdKTs6Q191B3J7cOSZuRKfN+8vSzczEaM2xjR9w75InMaAI3leBybwrTjcE8KG+
    irLh1QkPvlZj5ej1AcdNqhN/9v4nP86UlqypWVEDb1RNo6C3hTi0DQQyxFRBSnqPdwcl
    z8myo3SaDZo7Y05dNFUP8zA40+j4t6ng35SLvcAs6gWCIUwJPGNtUZ9/DAx1wTuLz7W/
    KsQgpii5lLSkdHqzB8RP4ujMBV4+xmrivPojZmoMdwzz8nkDfn6BkLFbKwHUneAopJb9
    zGBPSU1wQzcOqjQl1oqD02JayINM3Mx7rmIK2Kag59HkqHr9RN8iGhdWJaLrtp+5FVsI
    Gzyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1759247120;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=xu3ZGlHadp3jIM9o5uYVFATWHlHXyaiqp3/bkGRiDnw=;
    b=UaYoosBd0O4Iu707Z0qZ8h5/VRAy48ghrc+N+a2gMcI7oXo9qACrnePfFwP6nyR2eT
    /TTqndS3xoSyaO+AOKO4wEcTQbhEhnEwwBoEOURDX4d5JMHsNX4Ua7FNB+KyGfHCPkK7
    lCTk313IRh3luQIcw91mFOwA+ZouXuQFh0yGys7SVljGeX9lcCqsHDR+56FSRcMoSWZv
    yXFq8a1GR44SkG9HK5tjV8XhnP1JoW1Z2RugmXW2uG+S+H9sQ7ZaQ6H1cmcLrFPfgiXa
    MnoCHmDp8R4Txo3FDJTxqYfaKSaGc7ookCD9lo5RUxr5B9jGYYAcoU56AZRL/y4IoDrc
    C6Xw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1759247120;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=xu3ZGlHadp3jIM9o5uYVFATWHlHXyaiqp3/bkGRiDnw=;
    b=aInWnRmRH5jlw7osVg3Qw3yn1fqPHaWIa0Xqb58g6t4B77FPeS2eflCJ/xJsuUw1ZM
    nNuDeq299rmjgkNoJ7XOcwOglLCcAdLtz5wPY9wwwlR+cFT7SnuymybRldoYzUNoFunu
    EyC5tnACdm0JeTeD6raAIIvZo8I4Cc3ia9QatUCsRgQdQPYJRe8dXOEm1bXtCDElCzuO
    IrNaYtcjmcWkZXQ3ZNQeyxE7VKiKEmZfBp7boz+4nms6jfZ6NzgVqvKUtPcNr4GA08GZ
    3w1Hrc1epLSp5xLcTSxIatcb9Oahw8aGZxKy76gUN9oIL8ch/+SySEg0xfvJLMfXJQ5L
    bNyA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKzK+A+UOEY="
Received: from open-xchange-core-mw-gw-24.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 53.3.2 AUTH)
    with ESMTPSA id z9d9a518UFjJSmc
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 30 Sep 2025 17:45:19 +0200 (CEST)
Date: Tue, 30 Sep 2025 17:45:19 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1255129980.179592.1759247119782@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip103
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.83
X-Originating-Port: 48308
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Sep 2025 15:45:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20152

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip103. The linux-4.4.y-cip tree's base version has been updated to v4.4-st68. The trees are up-to-date with kernel 4.19-st8.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip103:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      2cfa12e66e2a133325b1b0316db9ad378dfc531a
    Fixed CVEs:
      CVE-2024-56597: jfs: fix shift-out-of-bounds in dbSplit
      CVE-2024-53237: Bluetooth: fix use-after-free in device_for_each_child()
      CVE-2024-57996: net_sched: sch_sfq: don't allow 1 packet limit
      CVE-2025-37752: net_sched: sch_sfq: move the limit validation
      CVE-2025-38468: net/sched: Return NULL when htb_lookup_leaf encounters an empty rbtree
      CVE-2025-38470: net: vlan: fix VLAN 0 refcount imbalance of toggling filtering during runtime
      CVE-2025-38473: Bluetooth: Fix null-ptr-deref in l2cap_sock_resume_cb()
      CVE-2025-38474: usb: net: sierra: check for no status endpoint
      CVE-2025-38482: comedi: das6402: Fix bit shift out of bounds
      CVE-2025-38483: comedi: das16m1: Fix bit shift out of bounds
      CVE-2025-38494: HID: core: do not bypass hid_hw_raw_request
      CVE-2025-38495: HID: core: ensure the allocated report buffer can contain the reserved report ID
      CVE-2025-38497: usb: gadget: configfs: Fix OOB read on empty string write
      CVE-2025-38529: comedi: aio_iiro_16: Fix bit shift out of bounds
      CVE-2025-38530: comedi: pcl812: Fix bit shift out of bounds
      CVE-2025-38538: dmaengine: nbpfaxi: Fix memory corruption in probe()
      CVE-2025-38539: tracing: Add down_write(trace_event_sem) when adding trace event
      CVE-2025-38555: usb: gadget : fix use-after-free in composite_dev_cleanup()
      CVE-2025-38565: perf/core: Exit early on perf_mmap() fail
      CVE-2025-38569: benet: fix BUG when creating VFs
      CVE-2025-38572: ipv6: reject malicious packets in ipv6_gso_segment()
      CVE-2025-38574: pptp: ensure minimal skb length in pptp_xmit()
      CVE-2025-38602: iwlwifi: Add missing check for alloc_ordered_workqueue
      CVE-2025-38604: wifi: rtl818x: Kill URBs before clearing tx status queue
      CVE-2025-38612: staging: fbtft: fix potential memory leak in fbtft_framebuffer_alloc()
      CVE-2025-38617: net/packet: fix a race in packet_set_ring() and packet_notifier()
      CVE-2025-38618: vsock: Do not allow binding to VMADDR_PORT_ANY
      CVE-2025-38630: fbdev: imxfb: Check fb_add_videomode to prevent null-ptr-deref
      CVE-2025-38639: netfilter: xt_nfacct: don't assume acct name is null-terminated
      CVE-2025-38663: nilfs2: reject invalid file types when reading inodes
      CVE-2025-38677: f2fs: fix to avoid out-of-boundary access in dnode page
      CVE-2025-38680: media: uvcvideo: Fix 1-byte out-of-bounds read in uvc_parse_format()
      CVE-2025-38691: pNFS: Fix uninited ptr deref in block/scsi layout
      CVE-2025-38693: media: dvb-frontends: w7090p: fix null-ptr-deref in w7090p_tuner_write_serpar and w7090p_tuner_read_serpar
      CVE-2025-38694: media: dvb-frontends: dib7090p: fix null-ptr-deref in dib7090p_rw_on_apb()
      CVE-2025-38697: jfs: upper bound check of tree index in dbAllocAG
      CVE-2025-38698: jfs: Regular file corruption check
      CVE-2025-38699: scsi: bfa: Double-free fix
      CVE-2025-38700: scsi: libiscsi: Initialize iscsi_conn->dd_data only if memory is allocated
      CVE-2025-38701: ext4: do not BUG when INLINE_DATA_FL lacks system.data xattr
      CVE-2025-38712: hfsplus: don't use BUG_ON() in hfsplus_create_attributes_file()
      CVE-2025-38713: hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
      CVE-2025-38721: netfilter: ctnetlink: fix refcount leak on table dump
      CVE-2025-38724: nfsd: handle get_client_locked() failure in nfsd4_setclientid_confirm()
      CVE-2025-38727: netlink: avoid infinite retry looping in netlink_unicast()
      CVE-2025-39676: scsi: qla4xxx: Prevent a potential error pointer dereference
      CVE-2025-39691: fs/buffer: fix use-after-free when call bh_read() helper
      CVE-2025-39714: media: usbtv: Lock resolution while streaming
      CVE-2025-39724: serial: 8250: fix panic due to PSLVERR
      CVE-2025-39743: jfs: truncate good inode pages when hard link is 0
      CVE-2025-39751: ALSA: hda/ca0132: Fix buffer overflow in add_tuning_control
      CVE-2025-39756: fs: Prevent file descriptor table allocations exceeding INT_MAX
      CVE-2025-39782: jbd2: prevent softlockup in jbd2_log_do_checkpoint()
      CVE-2025-39794: ARM: tegra: Use I/O memcpy to write to IRAM
      CVE-2025-39812: sctp: initialize more fields in sctp_v6_from_sk()
      CVE-2025-39813: ftrace: Fix potential warning in trace_printk_seq during ftrace_dump
      CVE-2025-39817: efivarfs: Fix slab-out-of-bounds in efivarfs_d_compare
      CVE-2025-39828: atm: atmtcp: Prevent arbitrary write in atmtcp_recv_control().

Best regards,
Ulrich Hecht

