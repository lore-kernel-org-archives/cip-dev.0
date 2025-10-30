Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1CACCF9F0
	for <webhook@archiver.kernel.org>; Thu, 30 Oct 2025 10:03:25 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
 by mx.groups.io with SMTP id smtpd.web10.22439.1761818604334651294
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Oct 2025 03:03:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=Qj7qbvfC;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.50, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1761818580; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SenMpU9wkQVMF7gfhMyPH8AAqfhaveNEwN/uwyo7Xp27KhAYJ60WuJK3t471CdvcHy
    i9g5fuvOW924B5aKtj3YbGVmGafEW+dwJQOd7Rii/iUoi1k7pNuCGExAu1zz9dZnO5RE
    cDBBHFIk4Yp2Yx3SGqo9UqOL+kn3pHGImiXWxg1h4+2FQrp+vBeXWzyD1GSp27yHcFkQ
    9qMx49MG7NSEMD0icm/JQxQmKOqSTfpzPlNz2nd/G8C6/PdyLvPIAfFL6uezA62wyNkO
    YFKKaIcVXTmgm0vmrLiSVImtcoH0hSRgHwkVkeXsZKnCW9e9t7C5VrsXusw06EenNG78
    3X4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1761818580;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=jGXzNXN+pAQLUDcRBfzBTGYTNei2x3jBIW3nC4/KoqI=;
    b=DYKLoQOeuCW2RgNmnsBkS2Z8q3raWS4zAHaGpW/DjOeoBFAypDrsVVfLmPDcFALLm1
    SaEuCJVW3mQi0mtuGwU/wDpuAFyupVsSWtgZbrWWd5JRfIiLSlh7bbaf8suz+0hbKJqU
    b/y0jiO5EL8QdTo6TFrseer9+wJFKp6Yzczna0z2kSpiTUQs7ukeCsWCvzq4pp9YmPUr
    RPkWTXxxAP5qNjtqlFZbXVjj7JX0WOtMMnYKPO613mPlyQwBFozi5L9T5wV4tlzG0Sg0
    1gpjcwCnjxZQ4YtAAbsoCdz5ERR0oHfbfhHX4ypMA/lVyPlidnQ7bya2p2Em/sVFVXhJ
    m/dw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1761818580;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=jGXzNXN+pAQLUDcRBfzBTGYTNei2x3jBIW3nC4/KoqI=;
    b=Qj7qbvfCiPQaJvyN/yc+80Y4+BsveRQTReKp4WAh343NDb5BS4lIjWFiYXve26ZNdg
    CqofbfODk1Dv/Qyw98HvHI7KthWVx3i4b6HufVmQg7fDk1Nfn/3DKDjMybqiiprvSOxI
    te6mauDfXwN8C64M5vfpVRzJ3uJT/n2oc0TcmxSW5DAvOqfIfkqbCdCWF8mQ5eXOxKGP
    +9MADhT8vwLZf4xpMbCwifPZHX6XyDB2l6KMDFwCCCvrKyU8Jk+PeUedkdh7H22Qu+/m
    bHOyTLx8zlj9QgKTZhwbPXwoo4NWfE95TTbkmFzlc/z2xxM6264ecMBhB+4swPFyQE/V
    FuQQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6Xd5KZrFg=="
Received: from open-xchange-core-mw-gw-36.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 53.4.2 AUTH)
    with ESMTPSA id z2815319UA30L7p
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 30 Oct 2025 11:03:00 +0100 (CET)
Date: Thu, 30 Oct 2025 11:03:00 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <2115994085.174609.1761818580269@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip104
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.93
X-Originating-Port: 57454
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Oct 2025 10:03:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20284

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip104. The linux-4.4.y-cip tree's base version has been updated to v4.4-st69. The trees are up-to-date with kernel 4.19-st9.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip104:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      9e1869f0ddca0c8329895558db8a18b0f7558b3c
    Fixed CVEs:
      CVE-2025-23143: net: Fix null-ptr-deref by sock_lock_init_class_and_name() and rmmod.
      CVE-2025-37968: iio: light: opt3001: fix deadlock due to concurrent flag access
      CVE-2025-39839: batman-adv: fix OOB read/write in network-coding decode
      CVE-2025-39846: pcmcia: Fix a NULL pointer dereference in __iodyn_find_io_region()
      CVE-2025-39847: ppp: fix memory leak in pad_compress_skb
      CVE-2025-39848: ax25: properly unshare skbs in ax25_kiss_rcv()
      CVE-2025-39860: Bluetooth: Fix use-after-free in l2cap_sock_cleanup_listen()
      CVE-2025-39869: dmaengine: ti: edma: Fix memory allocation size for queue_priority_map
      CVE-2025-39885: ocfs2: fix recursive semaphore deadlock in fiemap call
      CVE-2025-39902: mm/slub: avoid accessing metadata when pointer is invalid in object_err()
      CVE-2025-39911: i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path
      CVE-2025-39920: pcmcia: Add error handling for add_interval() in do_validate_mem()
      CVE-2025-39945: cnic: Fix use-after-free bugs in cnic_delete_task
      CVE-2025-39967: fbcon: fix integer overflow in fbcon_do_set_font
      CVE-2025-39986: can: sun4i_can: populate ndo_change_mtu() to prevent buffer overflow
      CVE-2025-40011: drm/gma500: Fix null dereference in hdmi teardown
      CVE-2025-40020: can: peak_usb: fix shift-out-of-bounds issue

Best regards,
Ulrich Hecht

