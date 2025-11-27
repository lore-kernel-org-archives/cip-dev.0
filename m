Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55A2CFD2F6
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 09:46:45 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15211.1764236799004576444
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Nov 2025 01:46:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=dyTZVOVi;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=iXIaxnns;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.22, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1764236768; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UUER1i0WcGuh4NBDkE3FQ0YorLpnJkAUVSMqjB3/x6ZWSUclJgZE7Pxf2Drt2ArrCk
    ycMBlU/aSaWR2mYkmYsI9tJ7iBidWpwT9p/I8dc9XbB0gMz91yLMVkoKbNNf6qui7LDM
    UWONicIZagC/wvY4frwaPyeLOyfQknUYMu/r3oAwIuC5ooODAql+9brUsUuikELiep2Y
    QwGZ/el7fNtyWi1N5sOYZUMfQ+oF9xqIbfezTWlMWaiGYWh7jIiEeZbJuKnF2wAScGYG
    eZ8gS30gZJTXj255YDRbTnXX20vl/V0QceGHbm3E/LMq1l1OKYWqOR9zlPT3SI9ZK/xb
    9erA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764236768;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=4m45x78cDSJ5PUDObpj3ALIo43p3H3eNVzdrbKLwF5Y=;
    b=dPsJS1wTFFzBD1NvGoBjYhKsipCoanoH0fJyOr7/XjUwkleG6jU+FoxmAJA9koV0A2
    XFuBzKlVUqtNFdM9udg5SNzIMx0I+uOdlzEeyY1dN0MwQsmRADtNHGZulHZYY/vYUmZc
    1gP4jjoSTkr9gY0+no0rk+Pcy9OEeOFBAGfvPyITPB+p0Fzb7pjh//lXpffx/e7DFu3W
    tag1dz8f/Vu7xbfI3IbcQRg2zQ50wmp+pRYNnWAwxwqrmwjdUNmOHyGlMn2dksl4XWlE
    Z5haGjWz5caE1SnIoz0h2/eMfHOcCSF61RSQte0uNNHpNW+jozNB1qxQUeFoJuh3rpZ7
    SZtw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764236768;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=4m45x78cDSJ5PUDObpj3ALIo43p3H3eNVzdrbKLwF5Y=;
    b=dyTZVOVizPdV+7F+O3nE4j/ou4nViOQKK0BwPAr8TDVnPKBZVcXAISIq/IlKi2zPTb
    4ZDGCSTIjWKP9XuSj2DJU09InWGVsiphV/DuyMEQhVoYcEASFbnYfNQZ+Nqk2DoYzubn
    iE9udTrwR+1mkFIeChyd4Fhk6RQdaXnDuiBKnkIH55IXdaXd8cyeOOzyKNtbK5mZkcBQ
    iJfLu+bDZ2ZA2ztfADp0smGu+QskLQfz7wnPjwjPhEuMK/q3CUIz5nyfhxmYiXGSPYlI
    LOcI2QQU8Zg+S4D6RxoV7oNtF+y4YSKVwKaMBTfJHCgFS6HfNkJtg1EqN6dNL1qiS9NK
    dD0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764236768;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=4m45x78cDSJ5PUDObpj3ALIo43p3H3eNVzdrbKLwF5Y=;
    b=iXIaxnns0ELck4zMXHvwhO+OTGQrT4AGKlH3l6KBP+kciRQTi60Ff/A/EerWmmKsSf
    W4W2NSgyt1sJ8FolYaDQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGvsCPiA=="
Received: from open-xchange-core-mw-gw-4.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 54.0.0 AUTH)
    with ESMTPSA id zd62e41AR9k7QZT
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 27 Nov 2025 10:46:07 +0100 (CET)
Date: Thu, 27 Nov 2025 10:46:07 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1352238535.420047.1764236767134@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip105
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.93
X-Originating-Port: 59012
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Nov 2025 09:46:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20741

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip105. The linux-4.4.y-cip tree's base version has been updated to v4.4-st70. The trees are up-to-date with kernel 4.19-st10.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip105:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      ecbd673b76d3b0583f9119c467e175a331dac5fd
    Fixed CVEs:
      CVE-2025-39994: media: tuner: xc5000: Fix use-after-free in xc5000_release
      CVE-2025-39996: media: b2c2: Fix use-after-free causing by irq_check_work in flexcop_pci_remove
      CVE-2025-39998: scsi: target: target_core_configfs: Add length check to avoid buffer overflow
      CVE-2025-40001: scsi: mvsas: Fix use-after-free bugs in mvs_work_queue
      CVE-2025-40018: ipvs: Defer ip_vs_ftp unregister during netns cleanup
      CVE-2025-40026: KVM: x86: Don't (re)check L1 intercepts when completing userspace I/O
      CVE-2025-40030: pinctrl: check the return value of pinmux_ops::get_function_name()
      CVE-2025-40035: Input: uinput - zero-initialize uinput_ff_upload_compat to avoid info leak
      CVE-2025-40042: tracing: Fix race condition in kprobe initialization causing NULL pointer dereference
      CVE-2025-40044: fs: udf: fix OOB read in lengthAllocDescs handling
      CVE-2025-40049: Squashfs: fix uninit-value in squashfs_get_parent
      CVE-2025-40055: ocfs2: fix double free in user_cluster_connect()
      CVE-2025-40088: hfsplus: fix slab-out-of-bounds read in hfsplus_strcasecmp()
      CVE-2025-40105: vfs: Don't leak disconnected dentries on umount
      CVE-2025-40106: comedi: fix divide-by-zero in comedi_buf_munge()
      CVE-2025-40112: sparc: fix accurate exception reporting in copy_{from_to}_user for Niagara
      CVE-2025-40115: scsi: mpt3sas: Fix crash in transport port remove by using ioc_info()
      CVE-2025-40116: usb: host: max3421-hcd: Fix error pointer dereference in probe cleanup
      CVE-2025-40118: scsi: pm80xx: Fix array-index-out-of-of-bounds on rmmod
      CVE-2025-40124: sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC III
      CVE-2025-40125: blk-mq: check kobject state_in_sysfs before deleting in blk_mq_unregister_hctx
      CVE-2025-40126: sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC
      CVE-2025-40140: net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast
      CVE-2025-40153: mm: hugetlb: avoid soft lockup when mprotect to large memory area
      CVE-2025-40178: pid: Add a judgment for ns null in pid_nr_ns
      CVE-2025-40186: tcp: Don't call reqsk_fastopen_remove() in tcp_conn_request().
      CVE-2025-40198: ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()
      CVE-2025-40200: Squashfs: reject negative file sizes in squashfs_read_inode()
      CVE-2025-40205: btrfs: avoid potential out-of-bounds in btrfs_encode_fh()

Best regards,
Ulrich Hecht

