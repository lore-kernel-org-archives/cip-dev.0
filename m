Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0880FC282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 16:24:06 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
 by mx.groups.io with SMTP id smtpd.web10.1022.1742315036641741906
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Mar 2025 09:23:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=Juszcc+n;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=P+7h28GK;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.162, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1742315019; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DEWQPe6P45VoKfn046Bq3Nwd/H7c8cxbFYeTAAekgk3QwpCNerVzEpqfFH1f1JHa/K
    LZI0yxAmZaJmC9+9t4WJfs++46BJ+3Fg54vjHPSv7W2D08GLwmRfaKgL1PHsSWf+3Z2F
    ryNLSSdCEr1qo4GmSGhLQ+E0CHmisbo8vErfBqsE63Fntd4gG04yg/DslZeYPqG9N9Im
    A0yHJXje7mdGF5aia45HT/tywI0wsT6fmRT9Gi2voM8NRLU26Xdwi9pxRap87OFE1qXc
    boCXxOW1WiCqzlPNj5moAHJIRxu9f1ASZtnfKr9uoe7d89TxCQatdQCQRc0PnFzfYbti
    nS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742315019;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=ptLcoEF4hXAvL0I/0+IwAQWnhHwfFL8NF6RQyDA0oRQ=;
    b=Pcm5KM+iqIivHAF2TDPu0dT5saBKtrfk8gDGt1RgL0K2Fo7bguWRQkpFTN40PmZU/t
    0RnnmtJDu7O/WtaPkSOcPlSKxxB8JO2fH6ksj9zU5FM5kAs5O3b+hcQSTQgcJ+X2PY+b
    c/ZiT1HfJdr5T6ahO4LiFS7KKfyfqVKLxXJSSGGZMsqflam7odksyh3sQ3NTLVOm8iUF
    /A90tuEaNlklJzrLOAMDlbP4XAIgB4X7nZoys6qBLiV32NUwe5ebb4qFeYl8Fswh5ylG
    ePSOeVnmBtsmMCUO7oPkk6lfBQ/0IpQ8ednwidC22k8VVCCuihKv1NZJmSx/98hRe+ei
    i9QQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742315019;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=ptLcoEF4hXAvL0I/0+IwAQWnhHwfFL8NF6RQyDA0oRQ=;
    b=Juszcc+nCjqaQnKFIEVkQXxck7b4TlYBp+cW6QYqYDcUvQEnH/GA6AoJmI2EzpIt+M
    EqBuDYKWnUvomXfKiLCLdnhiClV2L655aDm0eoWfGV4U9dmhe7Ib9LQql6KQDqu1t293
    S1Vk1605vGSabxn3+yF0JysPSyQgtgsr+Cil2az1jBLyfL4jU4v96KBa2Ct4AB9yTxz3
    9aIHJREa2YYok0UjVGmTdThnpuI1IceW9nlAkCuMpnROEIqGkPmjsp1cW1eHjDuq1955
    7eqcY+yuB4WUGCLybwAIzy6Lm+vd+T5X8PfjiYWD5rwIdY1CRSgL4zNYJAN9nAu1exvM
    qzCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742315019;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=ptLcoEF4hXAvL0I/0+IwAQWnhHwfFL8NF6RQyDA0oRQ=;
    b=P+7h28GKh6LAKWK7FlvmD/15Jc4u5Tuz+OuNFt0XC35ACHZnfILz/dNZdlkSa5+ys3
    SoYP6QkLgddNdBHiJxDg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzotGZsghGuyX3LvXid7Q=="
Received: from ox-live-app404.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a34012IGNcyBj
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 18 Mar 2025 17:23:38 +0100 (CET)
Date: Tue, 18 Mar 2025 17:23:38 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <2023206950.3535045.1742315018957@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip97
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
 <cip-dev@lists.cip-project.org>; Tue, 18 Mar 2025 16:24:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18240

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip97. The linux-4.4.y-cip tree's base version has been updated to v4.4-st62. The trees are up-to-date with kernel 4.19-st2.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip97:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      b48a88b0af82df2317ae2b3d48c78d1bd86c8568
    Fixed CVEs:
      CVE-2023-35827: net: ravb: Fix possible UAF bug in ravb_remove
      CVE-2023-52509: ravb: Fix use-after-free issue in ravb_tx_timeout_work()
      CVE-2024-47707: ipv6: avoid possible NULL deref in rt6_uncached_list_flush_dev()
      CVE-2024-56631: scsi: sg: Fix slab-use-after-free read in sg_release()
      CVE-2024-57904: iio: adc: at91: call input_free_device() on allocated iio_dev
      CVE-2024-57908: iio: imu: kmx61: fix information leak in triggered buffer
      CVE-2024-57911: iio: dummy: iio_simply_dummy_buffer: fix information leak in triggered buffer
      CVE-2024-57913: usb: gadget: f_fs: Remove WARN_ON in functionfs_bind
      CVE-2024-57948: mac802154: check local interfaces before deleting sdata list
      CVE-2025-21638: sctp: sysctl: auth_enable: avoid using current->nsproxy
      CVE-2025-21639: sctp: sysctl: rto_min/max: avoid using current->nsproxy
      CVE-2025-21640: sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
      CVE-2025-21664: dm thin: make get_first_thin use rcu-safe list first function
      CVE-2025-21687: vfio/platform: check the bounds of read/write syscalls
      CVE-2025-21689: USB: serial: quatech2: fix null-ptr-deref in qt2_process_read_urb()
      CVE-2025-21694: fs/proc: fix softlockup in __read_vmcore (part 2)
      CVE-2025-21699: gfs2: Truncate address space when flipping GFS2_DIF_JDATA flag

Best regards,
Ulrich Hecht

