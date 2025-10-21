Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95370CCD184
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 09:32:03 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
 by mx.groups.io with SMTP id smtpd.web10.7186.1761039116822087753
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Oct 2025 02:31:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=EaCWSakr;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.24, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1761039096; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Lod2qAhdi0cbrjqGX4OHstGhGUl2ABevdfLc1SnszF9m1RrrbIgqIGbdrhjjbdGWXD
    /EOdc4Tx7+53wttJvR2MCR/s44RdeWFZLNtSsVZQiEyRZGW1lfMOAStWOADEmhg47NgJ
    FBT2ndpRhPLFn2vCaY6hQickHjIdj3o9ePSu0by10aD7mtjxBm0o/GvH+MlI5+o0+tql
    1SnL/mts5iPL6NaRLiWmB/YzK+LE7MbtTQBd0x39II34LdkrO3er5XLsW0yT6tOMDKwS
    NDkK/pAICvG/UnYxKH2Arnh2hTNl/DHtCvJdJwtETEOwZI9D/qAfJoU52BCAig+MJ+Hc
    B0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1761039096;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=z3UQWQZDXakSlp6gRyrqwbu2w2vxt8SfVRQCIq/SNM4=;
    b=CPllJVATlNBK+Ay5zAoh5Ac1gxuuxuuqdDhQ/c0MYg5px1Oz7NXvxUp6cYwXqJcdLx
    9rDgkGPveyrTx67hJ3cAyP0ge+otwFYjCMVMiSma+piiUbbRVjXD+ub8xweAR9EYDKw0
    9MRiFcdGQizUtfg9nbOGbcH3wrtdIv2BwZFDVyEH86t3xqBlPjcbvj9fyKuyW4Ip+IHF
    4GXForMOSYB4207MyDmbChn+LrvuwKb7wfAVYMXw1YsBxrpgcUMxw9NumNKk5uVsY7Fm
    Dgorq1ZH6ht9CuAv0RHmDAi09PIEj1e/eF7nrVC25UVPvTyA3HjnJLwbO7vpJHcrRicH
    iiyA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1761039096;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=z3UQWQZDXakSlp6gRyrqwbu2w2vxt8SfVRQCIq/SNM4=;
    b=EaCWSakrVVnbJTDLYJM0NTwemul50YuwKmtwxocSL0hUntDlPG6defkMYXCFMj1mOC
    lQxrnKi6uxEQuZj5jV4I4QvsvmT5wsXQ+M94df8SjP0dqQxE18TFv5KTv1Y+4909pM4r
    IQ58YS9C5o9DJ63HltPbxP4e0jEccT++37D1qtThTGjNF3VeESvAdUGht6pjCGL1p4Og
    YPfjJ+Anu8nFwMJ5qUBCFQyukhIV6aIWI0SML+acZ+jsijGb/Ekm34o/ZP+JeAZjFv0A
    /hpi8pslQc8x7fbLW5txgx/6AfrPZIsJAAX3R95QJC+tBW81Dz219cGl4G3aJpUu2jy9
    ZGmg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hewKDd5BNnyw=="
Received: from open-xchange-core-mw-gw-5.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 53.4.2 AUTH)
    with ESMTPSA id z2815319L9ValIo
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 21 Oct 2025 11:31:36 +0200 (CEST)
Date: Tue, 21 Oct 2025 11:31:06 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <4337027.175672.1761039096556@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.19.325-cip125
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.93
X-Originating-Port: 39312
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Oct 2025 09:32:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20201

Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip125. The linux-4.19.y-cip tree's base version has been updated to v4.19-st9. The trees are up-to-date with kernel 5.4.300.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/

  v4.19.325-cip125:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      d68802a940fe1efb4315cbd06f2fc8d9c861aec3
    Fixed CVEs:
      CVE-2023-52935: mm/khugepaged: fix ->anon_vma race
      CVE-2025-21861: mm/migrate_device: don't add folio to be freed to LRU in migrate_device_finalize()
      CVE-2025-23143: net: Fix null-ptr-deref by sock_lock_init_class_and_name() and rmmod.
      CVE-2025-37968: iio: light: opt3001: fix deadlock due to concurrent flag access
      CVE-2025-39839: batman-adv: fix OOB read/write in network-coding decode
      CVE-2025-39846: pcmcia: Fix a NULL pointer dereference in __iodyn_find_io_region()
      CVE-2025-39847: ppp: fix memory leak in pad_compress_skb
      CVE-2025-39848: ax25: properly unshare skbs in ax25_kiss_rcv()
      CVE-2025-39853: i40e: Fix potential invalid access when MAC list is empty
      CVE-2025-39860: Bluetooth: Fix use-after-free in l2cap_sock_cleanup_listen()
      CVE-2025-39869: dmaengine: ti: edma: Fix memory allocation size for queue_priority_map
      CVE-2025-39876: net: fec: Fix possible NPD in fec_enet_phy_reset_after_clk_enable()
      CVE-2025-39883: mm/memory-failure: fix VM_BUG_ON_PAGE(PagePoisoned(page)) when unpoison memory
      CVE-2025-39885: ocfs2: fix recursive semaphore deadlock in fiemap call
      CVE-2025-39891: wifi: mwifiex: Initialize the chan_stats array to zero
      CVE-2025-39898: e1000e: fix heap overflow in e1000_set_eeprom
      CVE-2025-39902: mm/slub: avoid accessing metadata when pointer is invalid in object_err()
      CVE-2025-39911: i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path
      CVE-2025-39920: pcmcia: Add error handling for add_interval() in do_validate_mem()
      CVE-2025-39923: dmaengine: qcom: bam_dma: Fix DT error handling for num-channels/ees
      CVE-2025-39937: net: rfkill: gpio: Fix crash due to dereferencering uninitialized pointer
      CVE-2025-39945: cnic: Fix use-after-free bugs in cnic_delete_task
      CVE-2025-39953: cgroup: split cgroup_destroy_wq into 3 workqueues
      CVE-2025-39955: tcp: Clear tcp_sk(sk)->fastopen_rsk in tcp_disconnect().
      CVE-2025-39967: fbcon: fix integer overflow in fbcon_do_set_font
      CVE-2025-39968: i40e: add max boundary check for VF filters
      CVE-2025-39970: i40e: fix input validation logic for action_meta
      CVE-2025-39972: i40e: fix idx validation in i40e_validate_queue_map
      CVE-2025-39973: i40e: add validation for ring_len param
      CVE-2025-39985: can: mcba_usb: populate ndo_change_mtu() to prevent buffer overflow
      CVE-2025-39986: can: sun4i_can: populate ndo_change_mtu() to prevent buffer overflow
      CVE-2025-39987: can: hi311x: populate ndo_change_mtu() to prevent buffer overflow

Best regards,
Ulrich Hecht

