Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1366C04FFE
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 13:22:02 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
 by mx.groups.io with SMTP id smtpd.web10.12233.1715174512522091234
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 May 2024 06:21:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=ZB+8giex;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=QGKz6/1X;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.216, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1715174488; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Iu0p+ADXEx0PkXkwX7SlftPHBVsWRafbh98Oi8IP6YPEpmnO1+eGNo9HeKbzmgfevg
    kjpYWbHhkkAtURU5OyVJGPLQ1oc53Nqi5YQ327Q7Iop2jcCPqjnWyZ2AfFuUImeqZA0k
    +nziR347i/Szpt58RfgOcAjVknyRQz13B+gt9Mdv7clYakayrQYmmcP5tNuhiNAy+xfi
    y04n7VruqoZmM43x9qysTzFwkTayJ+juw5daxg9i/ubFhbJkT1TOybxUafOVOJPL9lsl
    sOfZrkAoi29rOuHnbTux8YV2HvfIS5o5uYHYzSKGyUGFtLdsIOT77gn8TZa+X3g6CJzc
    yoTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1715174488;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=hnAxxWipdKufjTqoej5UXPslfhBFW6uWVeKMi+VOqDo=;
    b=plOAcECZmhkOtYnIUN0oYPYkDXzkqHvUQj1zG++uvQrl1+p65Y/308BkfV/V2qG6uG
    yCenC28bHdVTFCeNaMgcKf+fRQoQedmhiQ7Z9flJ8ukuEwWJo1sajo/6ZQqxDgmk5vHj
    YpMuZyrcnymohjaLzBn0H3BAzMaikt3sSrDt1ancPL8hkac3MWsL4914rd/unSREQDGc
    xyvLcWqwCyyTq2uVMXZgQs3g5JUWiEnI7HleNIcdM1PXoW1CsBiTmqUxomf+QAMUKDB2
    bJxdDUKF9CgKSv1oXanrpsCpLM8+pFHVNjSkWwAZew32lpTu32LRmmD1q2LHU2cGFdWz
    +FcA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1715174487;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=hnAxxWipdKufjTqoej5UXPslfhBFW6uWVeKMi+VOqDo=;
    b=ZB+8giexTV8DomcQk3zDexxUphRVOVHF5i5RBKfXv4k9XCMPih0qlAOmSuBJNSzxiK
    oCc2H055xOh5HZlPQ3iU2t4BC6sApxzdfGIj51SCwxVogtRENSLAPNIEM52dE6FN62xv
    +aCch5Qlnmw6yoUjBWTggvKf9DkrOiePZjYYSbAvN2qxes6kAhuFB+XszLoxsCE3t6nz
    BPrd3sD4YNi8I8kfs1DYrBqdfQFotKrP42NMoeaRNpelK4eL0U5aQRODSsFC1+1zR0mf
    2Rblr4bTyWmBx81dvPDsAGsw8xMVpg3l4UN9j7sJRxWnnvtGRgsghmcQuHRKqtCPHmJJ
    cWww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1715174487;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=hnAxxWipdKufjTqoej5UXPslfhBFW6uWVeKMi+VOqDo=;
    b=QGKz6/1XXkHBkRXOhemO6c2/h7cEbkMa8OsZdlBvESc4HQbVZgg5ByUcFEZT0Ii8oj
    HiIMC6ypRqgybDUWwUDg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7oKNYMuRPGHqNLlPQ1COXxkLaOKhogcq0A3ukKl5MCt"
Received: from ox-live-app204.back.ox.d0m.de
    by smtp-ox.front (RZmta 50.5.0 AUTH)
    with ESMTPSA id z08c3e048DLPuS3
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Wed, 8 May 2024 15:21:25 +0200 (CEST)
Date: Wed, 8 May 2024 15:21:25 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <468289932.3431212.1715174485792@webmail.strato.com>
Subject: [ANNOUNCE] Release v4.4.302-cip87
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev61
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 May 2024 13:22:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15860

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip87. The linux-4.4.y-cip tree's base version has been updated to v4.4-st52. The trees are up-to-date with kernel 4.19.313-rc1.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip87:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      ebf863bf45b2a7c261d41713bc751839878a577d
    Fixed CVEs:
      CVE-2022-48627: vt: fix memory overlapping when deleting chars in the buffer
      CVE-2023-52620: netfilter: nf_tables: disallow timeout for anonymous sets
      CVE-2024-24857: Integer overflow bug was found in bluetooth device driver
      CVE-2024-24858: Race condition bug in bluetooth driver causes DoS
      CVE-2024-24859: Race condition bug in sniff_{min,max}_interval_set() in bluetooth driver causes DoS
      CVE-2024-26920: tracing/trigger: Fix to return error if failed to alloc snapshot
      CVE-2024-26934: USB: core: Fix deadlock in usb_deauthorize_interface()
      CVE-2024-26981: nilfs2: fix OOB in nilfs_set_de_type
      CVE-2024-26993: fs: sysfs: Fix reference leak in sysfs_break_active_protection()
      CVE-2024-26994: speakup: Avoid crash on very long word
      CVE-2024-26999: serial/pmac_zilog: Remove flawed mitigation for rx irq flood
      CVE-2024-27000: serial: mxs-auart: add spinlock around changing cts state
      CVE-2024-27001: comedi: vmk80xx: fix incomplete endpoint checking
      CVE-2024-27008: drm: nv04: Fix out of bounds access
      CVE-2024-27013: tun: limit printing rate when illegal packet received by tun dev
      CVE-2024-27020: netfilter: nf_tables: Fix potential data-race in __nft_expr_type_get()

Best regards,
Ulrich Hecht

