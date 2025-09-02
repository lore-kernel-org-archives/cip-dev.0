Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66638CA0FFE
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 09:17:27 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
 by mx.groups.io with SMTP id smtpd.web11.72755.1756804636586017594
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Sep 2025 02:17:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=KHqiD4qI;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=nQYLYaxd;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.21, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1756804609; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JGN9JfhMccTyZd4iOLfDcJ4v/pIC5cdXwDhXpTpHb0AlylDGQSgtlNpLG6qcI5Bajd
    9PmwNp0tvinP7OveoXOp20M0mSSaaybovqGIgrqx6KReRUPI0/AGwlKhiZR3h6ICu0b7
    HXdEb49Z1kW1jGaD18u8Gg3v9yvNHREhRQt11FYzR1QRvZ7dbDk8a/JndvRuYiTeMaof
    vEyXWQDPAAJIQ/BLwlqjil8MUttzAUSAnCRfVt6uhxM1sKBIacYPZ/Kw0axA3C4X9ZQy
    kJiE8Ljfa1m6xxlbRtnrjxch5iG7/hwUe5Ja7V7J+zbNqHIH9R48PxVrxT1CDuEfnqnS
    6Reg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1756804609;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=xAxd+m8AcW2LDocq3HHo7BLaQgU5Z13HV15GYm4B7vE=;
    b=p+mtnJH0xlJlHN3I5qqn0y3LrrXMW1sJgJ4bGUAXqfjrTBdGxLBfhOmvC3o+YSOJfN
    UwsrbY1znRyRKrWCi0hl3ajspfOGIi4yG85Xz4+oTTYiTVu6E7EZU+W2k1JfMLzn4v6e
    G8HpF5/fCszfVbTCm2pTF6o4safTPp36dpJfqNuMwnBCyu4oliC+YLVJo6IGB0F62vEw
    i/XkaE26IcwhJNWnhowjtzWm/7aC4zGro6olz0VnfAPTaq7NN0P0ecNxUprxH+8BCpjz
    MhbhPaiBg3E9v2GKuwN6ezDv//4ctgKZkWdMraS3x5LcS71qtdVNqGysmCoqUx9m2FId
    bkyw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756804609;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=xAxd+m8AcW2LDocq3HHo7BLaQgU5Z13HV15GYm4B7vE=;
    b=KHqiD4qIkMLKLDW7PUQIiRFMXF56OGH3iNI5UdcyhZ69NFVFnS1Op3JgpgykBjSbLJ
    7FMxDrZRMkGjggPmzXIqfbByQagQNmndRZHWKyEAjt5pw6XmTInABnMo4/Jue4dWPDSY
    unuKoj5KnyKQTQ6TkHVL4QSfv/Ilp43ISZ5ugsS80GpJQmRP95bv8/XZBl6bK8ZOdsnZ
    T4X4JP9fwo0rXlpY85fr4Hv8iX6geGPg/Ceb99QVGUzINMN71wrqH01YY2zYLEv+wPRT
    810WFW0jaavjrbb75qo8fwdN7RsX9ZpNR4RV0HlBe9atD0g50DDaO43Pp5n1+4tce8F2
    oFdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756804609;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=xAxd+m8AcW2LDocq3HHo7BLaQgU5Z13HV15GYm4B7vE=;
    b=nQYLYaxd5PIAc0TsC2/+C3jr1PuBBkCgXxdhMP7tvFARGMlbszl4ZxhHXf8N/3n0NX
    nYw/OWNTD7iKNIqQsbCw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKLG+KwQlg=="
Received: from open-xchange-core-mw-gw-18.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 52.1.2 AUTH)
    with ESMTPSA id z5ff621829Gmiiy
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 2 Sep 2025 11:16:48 +0200 (CEST)
Date: Tue, 2 Sep 2025 11:16:48 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <2089869981.61985.1756804608743@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip102
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.83
X-Originating-Port: 53136
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Sep 2025 09:17:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19994

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip102. The linux-4.4.y-cip tree's base version has been updated to v4.4-st67. The trees are up-to-date with kernel 4.19-st7.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip102:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      1135330e0fe33041a44f5cd14819866b2aab7a08
    Fixed CVEs:
      CVE-2025-21917: usb: renesas_usbhs: Flush the notify_hotplug_work
      CVE-2024-26644: btrfs: don't abort filesystem when attempting to snapshot deleted subvolume
      CVE-2024-49935: ACPI: PAD: fix crash in exit_round_robin()
      CVE-2025-38102: VMCI: fix race between vmci_host_setup_notify and vmci_ctx_unset_notify
      CVE-2025-38230: jfs: validate AG parameters in dbMount() to prevent crashes
      CVE-2025-38245: atm: Release atm_dev_mutex after removing procfs in atm_dev_deregister().
      CVE-2025-38386: ACPICA: Refuse to evaluate a method if arguments are missing
      CVE-2025-38401: mtk-sd: Prevent memory corruption from DMA map failure
      CVE-2025-38403: vsock/vmci: Clear the vmci transport packet properly when initializing it
      CVE-2025-38406: wifi: ath6kl: remove WARN on bad firmware input
      CVE-2025-38445: md/raid1: Fix stack memory use after return in raid1_reshape
      CVE-2025-38448: usb: gadget: u_serial: Fix race condition in TTY wakeup
      CVE-2025-38459: atm: clip: Fix infinite recursive call of clip_push().
      CVE-2025-38460: atm: clip: Fix potential null-ptr-deref in to_atmarpd().
      CVE-2025-38465: netlink: Fix wraparounds of sk->sk_rmem_alloc.
      CVE-2025-38513: wifi: zd1211rw: Fix potential NULL pointer dereference in zd_mac_tx_to_dev()
      CVE-2025-38542: net: appletalk: Fix device refcount leak in atrtr_create()
      CVE-2025-38546: atm: clip: Fix memory leak of struct clip_vcc.

Best regards,
Ulrich Hecht

