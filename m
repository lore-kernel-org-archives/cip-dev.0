Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030C5C35FF1
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 13:18:51 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
 by mx.groups.io with SMTP id smtpd.web11.8640.1741699124031913643
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Mar 2025 06:18:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=bs83oB3m;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=Bw9zGcB/;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.221, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1741699102; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fRf5mo2QWfUnePoEagm6V9zaqtbYUarUC2hbILOub+BgyxYkyGCF5X02qCL1Zhug6C
    IWHCtCsPSMY39ZqSwZVDgTnmvLPrtw/zrZEQgNYcxQ/9ekmP5vfAwycP/PFDMLtskek4
    5RrS1+HsF8iJVkY8UsRQsGM5SSkx4s7z6XQ0gLmog6bdXDY8qd2TcAIs2XT+4Pld/Qm4
    BiI1Fzv5TrAJHSkQX90IOQPqC/aKsPlN9j35NtXiMYCgVzDeBEyyfDB/QxAbSn5OvUOS
    jSFvzdvJxONBs2iazfi9J9yFbxFcCo36jopo0JaNNLWZ8gB5uaQeEZDzeSJVyKuIoFdY
    dasw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1741699102;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Dd8zLkCbkAQdPfy3lufEVRG94eWqM52rz+VBooWhBwA=;
    b=Nc4rxU/3DiT/UzABNfVmmLgZYcuYMfdvlEwCPGQQsUKEPfDD/SjwscWqpr8uYLxbHr
    0AGajCxzwHElEUr2eY3RYuBb7QOVqTW9YjCxkqLvcRawQwa4bh8jwWfWUOBEfWxwp0Lt
    K+ysfuMp2YpGLBgYiImxZQKu80xMK8mKk/Wu50BFw6Lrp+NH9QIS11YW6uJTK+u/1DhK
    jQBu9pxFrmC5CDZPBOxRK8kWEk+SOvJ5cXbVSIEHYz7Y5bQFBYgIFuaDXcDPm6I+H5RN
    aBJ9nCRcxpL2WVS7DtQE90Qjz+AslCYZdNLXuIYTVhENwrnQCVZGlM4ASbdfMiMhUmtC
    G+Dw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1741699102;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Dd8zLkCbkAQdPfy3lufEVRG94eWqM52rz+VBooWhBwA=;
    b=bs83oB3m/sliontnxcjdrBbkXU7eHlk7m344kRVqaYVoMmKs22QkNo4qi9evnEcXF7
    Bdqdbi4yBZxE1I06CtR+a65WemWr+8x63fH8JcWEggW6ka7Kbq6qK1AAvl7qoOneWrGy
    4djj6hGChMwNywpThD/v2a3XoiTaKBKvtZaf2uZfM5/3WXgSBNvrfd2uw3/z37d4paom
    bPpRdoHRNDIR3n0Ykn5luJPYUOP486PuEGeLDIk3w0y6y7XukodJcHXcHJK1bvpmao2+
    fNXx+EnX3KOJQcUC0Bi2gPFTaeMvrBb36MRomBfnCqB1lo+j1GIWts5M4S9lPl+rmwL2
    s7vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1741699102;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Dd8zLkCbkAQdPfy3lufEVRG94eWqM52rz+VBooWhBwA=;
    b=Bw9zGcB/1EnWtLbsU4mLEMaICK2FyNBQQgtT8VehhNpl0/KiYNtjnbLPM54hjKUL+a
    CUlIvZwWZv67WxRKG8CQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzotGZsghGuyXrLvf2q/w=="
Received: from ox-live-app305.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a34012BDILSpI
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 11 Mar 2025 14:18:21 +0100 (CET)
Date: Tue, 11 Mar 2025 14:18:21 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <550411128.4870384.1741699101645@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.19.325-cip118
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev73
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Mar 2025 13:18:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18085

Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip118. The linux-4.19.y-cip tree's base version has been updated to v4.19-st2. The trees are up-to-date with kernel 5.4.290.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/

  v4.19.325-cip118:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      897293ec51a382f6f3534a971e06a3440c7c92ca
    Fixed CVEs:
      CVE-2023-35827: net: ravb: Fix possible UAF bug in ravb_remove
      CVE-2023-52509: ravb: Fix use-after-free issue in ravb_tx_timeout_work()
      CVE-2024-53124: net: fix data-races around sk->sk_forward_alloc
      CVE-2024-56631: scsi: sg: Fix slab-use-after-free read in sg_release()
      CVE-2024-57892: ocfs2: fix slab-use-after-free due to dangling pointer dqi_priv
      CVE-2024-57904: iio: adc: at91: call input_free_device() on allocated iio_dev
      CVE-2024-57906: iio: adc: ti-ads8688: fix information leak in triggered buffer
      CVE-2024-57908: iio: imu: kmx61: fix information leak in triggered buffer
      CVE-2024-57911: iio: dummy: iio_simply_dummy_buffer: fix information leak in triggered buffer
      CVE-2024-57912: iio: pressure: zpa2326: fix information leak in triggered buffer
      CVE-2024-57913: usb: gadget: f_fs: Remove WARN_ON in functionfs_bind
      CVE-2024-57922: drm/amd/display: Add check for granularity in dml ceil/floor helpers
      CVE-2024-57929: dm array: fix releasing a faulty array block twice in dm_array_cursor_end
      CVE-2024-57948: mac802154: check local interfaces before deleting sdata list
      CVE-2025-21638: sctp: sysctl: auth_enable: avoid using current->nsproxy
      CVE-2025-21639: sctp: sysctl: rto_min/max: avoid using current->nsproxy
      CVE-2025-21640: sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
      CVE-2025-21664: dm thin: make get_first_thin use rcu-safe list first function
      CVE-2025-21687: vfio/platform: check the bounds of read/write syscalls
      CVE-2025-21689: USB: serial: quatech2: fix null-ptr-deref in qt2_process_read_urb()
      CVE-2025-21694: fs/proc: fix softlockup in __read_vmcore (part 2)
      CVE-2025-21699: gfs2: Truncate address space when flipping GFS2_DIF_JDATA flag
      CVE-2024-47707: ipv6: avoid possible NULL deref in rt6_uncached_list_flush_dev()
      CVE-2024-49936: net/xen-netback: prevent UAF in xenvif_flush_hash()

Best regards,
Ulrich Hecht

