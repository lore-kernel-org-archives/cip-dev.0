Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D179C54E58
	for <webhook@archiver.kernel.org>; Wed, 13 Mar 2024 10:03:51 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
 by mx.groups.io with SMTP id smtpd.web11.12798.1710324223453036303
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Mar 2024 03:03:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=RWPJBjzf;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=zoPOQB6b;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.160, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1710324204; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AiAXd6LmidSRlff4ytSW8EtYvn1sa/VgQXRBd52dcto92b3t9sOjHPQGn8oS6skJyx
    PIxetH8CsxZx4Sy3zljJ6P9mRSCRpC8cjXP5c4sCAq8X3OfCypAaHxrQ/AeRNalXuQ3N
    50702Mob1lBpljd93Z+zNphgq77GlE1Gno7CmJz1RKF1+o1QSkSfOlt0SSLap+BS2DgI
    b/33ixK5jW5IoD95PUwB6gbiVF6UbHpuYxvmkJmak0SRccmJ88YznrZl8xZnPaZdwy6/
    50KINDrCRfAXMw5Nb8zBGl7zSqE6US/XjqHaJ+4jSXAbfzv2/GTTtu90Pip2glooeTq5
    zGAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710324204;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=hWGGXVLmM7c1b8jTxNTeNGYmRur97gOmBLGup94Id/4=;
    b=WQ+S0M022xdQRtLfWi6lm11jUUOJpluK6MrzC6DJPOIRJgd8xFiuR17afNtc729cdB
    smhT+JQVVJdB92T1QNOg5+6mXvfOXt1RJIb4df5OP3wtZhQ2K4BuuqEcvbHnPiNmq6uk
    zBlWhek9+1UIiDX+EsuWtoDvqpgOoDqpuunOjrnDXzQp08XrK+5T1O3SOloBp/MDVyfZ
    m3fLjI661WtgG3oL1C/POsPU7MOPNy9YPZaoQesBUC7NSQoHenS5E1ys0QFGV2GRV9sm
    wmC1YY7eUZOJAnOqPYp4Nv3SyXZMHOt1SAcfLBYMzC3/rt86bqVHe+kLUWuivBj9nc9I
    nKVg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710324203;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=hWGGXVLmM7c1b8jTxNTeNGYmRur97gOmBLGup94Id/4=;
    b=RWPJBjzfFBYn3faIEphP54HLwwHLOLZFmkGP/fRHlXtKTy91535s0DeZamv5qc8P8w
    vurvNEzyDA91QOPhq7Pfbh4UvuyZhblEA+5s0cW3wGJ/LFkKKEJorVVqqMRmrvcZBoyA
    zU/IFcIyLdJN8KlS3GNdvtJcAXvJJGCuaDS/QKE13wLen72Fe8wzEXInBfCBHo94WnV8
    KaUGbMQ+4wjOljF25AoVu99NvYg/ncvi1WSUN06+gxd0O79JcF5UAqhXCQoCy2aM5fmW
    XF2NMLuTnp0FQQPqplDng/NTNyXNTVyV8si+ozB+J8WhBvn/7m8L3WsIWFejfh9YyHyD
    GtgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710324203;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=hWGGXVLmM7c1b8jTxNTeNGYmRur97gOmBLGup94Id/4=;
    b=zoPOQB6beElI2xQcAB7S/Ej1WnHqBrhiRF4vtp+4bXV4xZBFDMD4RIZV9nq/mUKrOF
    Cqa6m0TT783OAYfCK3CA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKDH+Phm8yA="
Received: from ox-live-app405.back.ox.d0m.de
    by smtp-ox.front (RZmta 50.2.1 AUTH)
    with ESMTPSA id z3e56602DA3M3Fd
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Wed, 13 Mar 2024 11:03:22 +0100 (CET)
Date: Wed, 13 Mar 2024 11:03:22 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <304938565.3488174.1710324202521@webmail.strato.com>
Subject: [ANNOUNCE] Release v4.4.302-cip85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev60
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Mar 2024 10:03:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15289

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip85. The linux-4.4.y-cip tree's base version has been updated to v4.4-st50. The trees are up-to-date with kernel 4.19.308. This is the first release based on the 4.19.y patch stream.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip85:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      73293d3cb91e2dd661422c4d62a95edd1e8e16a4
    Fixed CVEs:
      CVE-2023-46838: xen-netback: don't produce zero-size SKB frags
      CVE-2023-52436: f2fs: explicitly null-terminate the xattr list
      CVE-2023-52444: f2fs: fix to avoid dirent corruption
      CVE-2023-52445: media: pvrusb2: fix use after free on context disconnection
      CVE-2023-52449: mtd: Fix gluebi NULL pointer dereference caused by ftl notifier
      CVE-2023-52469: drivers/amd/pm: fix a use-after-free in kv_parse_power_table
      CVE-2023-52587: IB/ipoib: Fix mcast list locking
      CVE-2023-52594: wifi: ath9k: Fix potential array-index-out-of-bounds read in ath9k_htc_txstatus()
      CVE-2023-52598: s390/ptrace: handle setting of fpc register correctly
      CVE-2023-52599: jfs: fix array-index-out-of-bounds in diNewExt
      CVE-2023-52600: jfs: fix uaf in jfs_evict_inode
      CVE-2023-52601: jfs: fix array-index-out-of-bounds in dbAdjTree
      CVE-2023-52602: jfs: fix slab-out-of-bounds Read in dtSearch
      CVE-2023-52603: UBSAN: array-index-out-of-bounds in dtSplitRoot
      CVE-2023-52604: FS:JFS:UBSAN:array-index-out-of-bounds in dbAdjTree
      CVE-2023-52605: ACPI: extlog: fix NULL pointer dereference check
      CVE-2024-1086: netfilter: nf_tables: reject QUEUE/DROP verdict parameters
      CVE-2024-26600: phy: ti: phy-omap-usb2: Fix NULL pointer dereference for SRP
      CVE-2024-26609: netfilter: nf_tables: reject QUEUE/DROP verdict parameters
      CVE-2024-26624: af_unix: fix lockdep positive in sk_diag_dump_icons()
      CVE-2024-26625: llc: call sock_orphan() at release time

Best regards,
Ulrich Hecht

