Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2BDCA0ED1
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 15:21:58 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
 by mx.groups.io with SMTP id smtpd.web10.78235.1755530515578670694
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Aug 2025 08:21:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=PiOBTZ2v;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=Ks+DeagQ;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.165, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1755530487; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DfxwkfthGprt/NlFB9uY69cMvQr47BNOkXDQ0jLi7+Uy9yBagZYpZ0Abp5+yv/uMxh
    sN6wDUrItWrNjyRGdiwU5/oMjuCuVul6//8dpShuWtFN/BYcnD/vWXLc5KIu5c8uI45B
    6BIid4irq7PCMzWsYox4nZioIXZUxz5XN2BOrrir2F/kL1+qX7rUULlg8gkFnytMvCs/
    I7hnkExtCwxRapLVOXl4gfBVwqOewEQiqen/wCMC5cKIvcy9S/RBXYnLzmFpaBkpwHjq
    oxmbR2nK6nAU355ep8lv+Hrsuq1BV8iS9DvqHAwumoVriqzjerzYX6iz2mP3jPgixOo/
    qaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1755530487;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=i3rMJUBKpgXgNCqnzKAgZVvVqMGI43egZFOj+auUqto=;
    b=XQCH6P9G8HkJ7LT3AuEeIEhusMCM3hnaCWQZmcGnKx/8XR3YqEolkYo1MEK/IvqQ54
    +a2D7rb7oMfRFACueB/k4S2IvxyusEIGnfoz5zgu0axOEm+DtUK4oCzZ7hJI+LQpwcid
    kyOI+fNPdkgNiYRfDRCcWWam+NRVuCIiCVAZs/NZh1/QY3Z6TGWVL3ObU4g8kxYwJd/0
    yMP5VzaBakhfdTp6Lusxp1J2Tgs9W5hAseBcv+Nukj8McO0IsMEP6Yk+wm9FimMhZo+x
    22CUE+LnZPPBwjK5EoZwQwi5E/AherVeeNfOWB/takime3u1zmrwG7D7ITj3DBo1HoDL
    GxHw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755530487;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=i3rMJUBKpgXgNCqnzKAgZVvVqMGI43egZFOj+auUqto=;
    b=PiOBTZ2vOmmkoLPiriMdpbBOpzPy2AWcwKI9XIyuvmCh2KtnOuAHS3tLg3dRYATSOT
    /VvEZWJidbs45zXd1xXVeC/CbyflJ9/L1yY3BtgebV8giSUTeL1m+FthJqHco+NbM3Hh
    dKxkxzsKjLdB13qqCQBdXa3Z4mKMn2NF8KXgvSzUMlA2ok+qllht1QN/Ii/F0kbNDE3m
    XK34HsDZTcrnWB11NF7FbDx3iN2+UnVisrZD72uuqViwUtWy29Fu7jNEkHwNUo6Yl3mG
    a4+Z79zDDUfdCP0FT3yUheOylUeBX42sApN5yqUALCECWaC5CMAr57e07c44PTod21XR
    cSJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755530487;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=i3rMJUBKpgXgNCqnzKAgZVvVqMGI43egZFOj+auUqto=;
    b=Ks+DeagQb8B78z8j0AbTKIMhHLFVaD8CZlmgAqzWxjneAwBsvnTDPbOa9MydsLR2mW
    TSYN4Alad3gn5BMZoRCg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKLG+KwQlg=="
Received: from open-xchange-core-mw-gw-29.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 52.1.2 AUTH)
    with ESMTPSA id z5ff6217IFLRsIW
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 18 Aug 2025 17:21:27 +0200 (CEST)
Date: Mon, 18 Aug 2025 17:21:27 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1602384696.84101.1755530487321@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.19.325-cip123
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.77
X-Originating-Port: 45770
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Aug 2025 15:21:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19754

Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip123. The linux-4.19.y-cip tree's base version has been updated to v4.19-st7. The trees are up-to-date with kernel 5.4.296.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/

  v4.19.325-cip123:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      1e9cb006c55b0164de79c50947377a71deca9975
    Fixed CVEs:
      CVE-2024-26644: btrfs: don't abort filesystem when attempting to snapshot deleted subvolume
      CVE-2024-49935: ACPI: PAD: fix crash in exit_round_robin()
      CVE-2025-38102: VMCI: fix race between vmci_host_setup_notify and vmci_ctx_unset_notify
      CVE-2025-38211: RDMA/iwcm: Fix use-after-free of work objects after cm_id destruction
      CVE-2025-38226: media: vivid: Change the siize of the composing
      CVE-2025-38230: jfs: validate AG parameters in dbMount() to prevent crashes
      CVE-2025-38245: atm: Release atm_dev_mutex after removing procfs in atm_dev_deregister().
      CVE-2025-38249: ALSA: usb-audio: Fix out-of-bounds read in snd_usb_get_audioformat_uac3()
      CVE-2025-38350: net/sched: Always pass notifications when child class becomes empty
      CVE-2025-38377: rose: fix dangling neighbour pointers in rose_rt_device_down()
      CVE-2025-38386: ACPICA: Refuse to evaluate a method if arguments are missing
      CVE-2025-38391: usb: typec: altmodes/displayport: do not index invalid pin_assignments
      CVE-2025-38401: mtk-sd: Prevent memory corruption from DMA map failure
      CVE-2025-38403: vsock/vmci: Clear the vmci transport packet properly when initializing it
      CVE-2025-38406: wifi: ath6kl: remove WARN on bad firmware input
      CVE-2025-38445: md/raid1: Fix stack memory use after return in raid1_reshape
      CVE-2025-38448: usb: gadget: u_serial: Fix race condition in TTY wakeup
      CVE-2025-38457: net/sched: Abort __tc_modify_qdisc if parent class does not exist
      CVE-2025-38458: atm: clip: Fix NULL pointer dereference in vcc_sendmsg()
      CVE-2025-38459: atm: clip: Fix infinite recursive call of clip_push().
      CVE-2025-38460: atm: clip: Fix potential null-ptr-deref in to_atmarpd().
      CVE-2025-38464: tipc: Fix use-after-free in tipc_conn_close().
      CVE-2025-38465: netlink: Fix wraparounds of sk->sk_rmem_alloc.
      CVE-2025-38404: usb: typec: displayport: Fix potential deadlock
      CVE-2025-38513: wifi: zd1211rw: Fix potential NULL pointer dereference in zd_mac_tx_to_dev()
      CVE-2025-38514: rxrpc: Fix oops due to non-existence of prealloc backlog struct
      CVE-2025-38515: drm/sched: Increment job count before swapping tail spsc queue
      CVE-2025-38540: HID: quirks: Add quirk for 2 Chicony Electronics HP 5MP Cameras
      CVE-2025-38542: net: appletalk: Fix device refcount leak in atrtr_create()
      CVE-2025-38546: atm: clip: Fix memory leak of struct clip_vcc.

Best regards,
Ulrich Hecht

