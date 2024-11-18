Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65D2D43FE2
	for <webhook@archiver.kernel.org>; Mon, 18 Nov 2024 07:01:05 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
 by mx.groups.io with SMTP id smtpd.web10.34883.1731913256756786043
 for <cip-dev@lists.cip-project.org>;
 Sun, 17 Nov 2024 23:00:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=WwSmy4ZZ;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=TgulYwOJ;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.163, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1731913250; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lk7S24S9Kbyij0L39DAxoTFdCtwc0r+DlLZKXsRi3g1QJ51hFLvcnERGAQbeeWp5nm
    cB17xJ2ujkJZSCl0BW+PB1FoBpsSNY4vtcrRTL4YVg+KrLdwE36/PPbnueub5GNpyMKT
    dbsrM+XSf+OTg1znAEXHfJGzC4B/Wzb4qR8hf1MAUbQtYE49/1WujDhr4tju6ytnW0vk
    sfHtNCzWshPegD4K9CRDkZcccrlSh0xHyG1pnwBI9CbtgecqdG3t5XsmF75Sz2k13tvd
    gln59UP9uT5SiOcW27sYR4oye+NfQM9m4qIOP6JsGVnzIcWgzTDRksgY8YnZhZqUkM3p
    /hdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1731913250;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=l1Nr5v5RNStD23R5qDVXYFyOz6ZAdWq3lnp1TzjM2HM=;
    b=WRAITsw4HkH26G7KLe1BJfD6qDg+V+HZCa1+SQLaql5zoEr3b+UYBIKaWMTSszlzCr
    j/Lemon69eucLMt5ssHw1sAfXg13wlv/4yHt3Ri4nJbLduJDggrw0rgqn+VeWUHlIrfo
    hvtO8ZYLGhBPcz7GjngWJ7/8dv0dPjRjOr6fMdTruQ388IwSw8FSB8DSC4pMEpG13c14
    Qrrd7ufvqvXAMDwpfRRcvQln54TzfFkNdJQ1wib8+lh3H59bsmovNP5brcgJnl6wc4I/
    KiNH3uSo9rA8sGxf/+p+mA3Zgn+RU9cR4ZK2wySAzieVFKo6plwmYGhzoHvx6it/GZaK
    brjw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1731913250;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=l1Nr5v5RNStD23R5qDVXYFyOz6ZAdWq3lnp1TzjM2HM=;
    b=WwSmy4ZZGLFluyfTanFncvjC5/kbaEyXsfdis8PMxYCs8yitzgjqW80SZvem0npW5a
    763kSeQaUON339DJyOKIiNU49Pto6e6ivoj8yUUeroCmsxd4jHOpfXqUd9Eo12pbhKFt
    pRE00VN6nPv2n3uWCDpC7g+byyFp3iDGt9USU+0lAYEu1iMWvqoqp0zPTRF+JZCYZx8i
    UTl3IKyFF0pU69wdscCASXRyf4cIdlYSwp8vX9osIJLedFUxvAB/87iUDPUbcklHC79R
    ryqTipPdfPN7i7iZhq3fdz/Achz1BseJnXyP9XWfsytU+JMJ+POOYd5MUNv80V8dywpc
    zSWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1731913250;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=l1Nr5v5RNStD23R5qDVXYFyOz6ZAdWq3lnp1TzjM2HM=;
    b=TgulYwOJ9bWx+1BBn7GAm8/O4Wo7InVAVlvdeAthH5CFpxlMY+hc1U9BPEVOpGtHBC
    ++8G66vnJQ5v/5uUt0BQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaR1GvtKuIw=="
Received: from ox-live-app201.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.11 AUTH)
    with ESMTPSA id z9fbae0AI70oyq9
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 18 Nov 2024 08:00:50 +0100 (CET)
Date: Mon, 18 Nov 2024 08:00:50 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1048687374.465216.1731913250080@webmail.strato.de>
Subject: Request for reviews for 4.4-st58, 4.4-cip93
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev69
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Nov 2024 07:01:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17259

Hi!

Here's the manual backports to review for the next 4.4 release which, as always, can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

810047a5a2d59 xhci: Fix Link TRB DMA in command ring stopped completion event
514f5ac9c1666 selinux: improve error checking in sel_write_load()
a2b280ab0ae0b nilfs2: fix kernel bug due to missing clearing of buffer delay flag
3bcf6988dfd1a drm/amd: Guard against bad data for ATIF ACPI method
86191495e89b8 RDMA/cxgb4: Fix RDMA_CM_EVENT_UNREACHABLE error for iWARP
3ab089df2d674 nilfs2: propagate directory read errors from nilfs_find_entry()
f39491c638d21 CDC-NCM: avoid overflow in sanity checking
56c693c3da940 net: ipv6: ensure we call ipv6_mc_down() at most once
0544747431c07 tcp: fix tcp_enter_recovery() to zero retrans_stamp when it's safe
2d384ff2d55e3 SUNRPC: Fix integer overflow in decode_rc_list()
2e666ea559b34 rtc: at91sam9: fix OF node leak in probe() error path
bec0bfe9b401f ext4: update orig_path in ext4_find_extent()
e6bc59e0c89e7 ext4: fix slab-use-after-free in ext4_split_extent_at()
e01afdabeaffc ext4: avoid ext4_error()'s caused by ENOMEM in the truncate path
1ac1d775e3a60 aoe: fix the potential use-after-free problem in more places
f164fee72b643 ocfs2: reserve space for inline xattr before attaching reflink tree
bfe7a9a5b48c4 ext4: fix i_data_sem unlock order in ext4_ind_migrate()
49dd4925f15ef ACPI: EC: Do not release locks during operation region accesses
19e2758d6c70e sctp: set sk_state back to CLOSED if autobind fails in sctp_listen_start
43c8bfae4c2a5 fs: Fix file_set_fowner LSM hook inconsistencies
58779420cf48b netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr_put()
8b7c662950e81 ntb: intel: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
66b2e36a28fce RDMA/cxgb4: Added NULL check for lookup_atid
32e5edc296e1a nilfs2: fix potential null-ptr-deref in nilfs_btree_insert()
6832f76bf7d42 ext4: avoid OOB when system.data xattr changes underneath the filesystem
89278fdddd51e kthread: fix task state in kthread worker if being frozen
0994d75c1648c kthread: add kthread_work tracepoints
cad9f4314a05e drm/rockchip: vop: Allow 4096px width scaling
65dc79e557302 gpio: prevent potential speculation leaks in gpio_device_get_desc()

There's also a fix for a previous backport:

c4a2255b27149 nilfs2: fix incorrect use of nilfs_error()

Thank you for having a look.

CU
Uli

