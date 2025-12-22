Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB2DE6748D
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 06:08:19 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.75259.1766383694686573420
 for <cip-dev@lists.cip-project.org>;
 Sun, 21 Dec 2025 22:08:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=lq58F7xi;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=RcQoITGO;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.220, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1766383684; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=e6Kt9nKuHD+kqzQAFSWq3ztUGCzDRpTkqMOLJY8EK/7dYyxHAAGlmYAIQZmXiyENKo
    C9odX2yEOQoc5WZ9glHMSPMpkWnQ7ExzsZ3fVBh7lBko4q3txqAoS7KMBiaLlDdenXGd
    7cqa5TTTJr9VZFQr/6aQ14CwBP1lCsqEgzm0UJZ6VgTmZiTHGhioZ3cbpTFskUi1Aehx
    8f1mo9tgReCfEDeHGluc/EFxiQrG5yU/MWBVuFevvTX5XgilIfc27jQDp9My47NjWy78
    4FzhJhKOKpi1V2/uBH9hVHccV6FCXedIF9ut5E/dW54g+1wx2VGhHJnPrZpTBiqVSAlt
    71BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1766383684;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=mpmAtZIlAc7s43Nulwi1PRD3xJAMbxx6ClNnOuy9hBQ=;
    b=gBGy3xDKrokCNQFZrAE4wnb28jr6CcK5NKb+dUL93MnxnwQyxbU6C9dn2ybT12PkCT
    RvqWzQdiepFXThFY21MT0axL3U4KBByiC9ha+bmla+49iNO+qfgVd5XZOoBksmk5maLp
    5wgWBJ4IUYQ7xDh9PZajru2HlV2z9EJSQNpF7t/zHMBmfZjAUMdMECUTry0pN738U1iH
    HZEq4YScgX7UneXwPi9jxddSooK49Uq0vshXHXrLSiBIwRIRpxoUVkSv9agf/mVTowW7
    EFmIYpckH81Td/rZNlShxC55b0NoJhWksugczGx8u6zZimcvCpmR+UhbbLf2xSSicW5T
    H8PA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1766383684;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=mpmAtZIlAc7s43Nulwi1PRD3xJAMbxx6ClNnOuy9hBQ=;
    b=lq58F7xiRt5kqDdbMe4CqOn2W4ytkoPFQG2lSEywVCV8hsTqCUHN87P86pAKzKNwIW
    aS+lkfTaNrqw6JbUNUQ2tjYT+s8df5m/4N1Mf9QJ2H0XhrYyKHq3Q2kbqYAPubAU+XW2
    N+dRvBUwvKFeYKO+pY2t0dYw7qHnHtg0l3SHt885Dzq/UboBstG29Ke0Fy2BNiX8veWf
    1gODO2Ro1szsiB3Bet6BXDvfQnjajshJCuQbpytGUyawQe+23lbir5WLjyT59J4ED8F7
    r8JJ4IekAQWm/q+t2njRlacXwK924w9c/lhwvjgputFpdaeO0/JspgbFRzjP4Wzhuemh
    Yncw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1766383684;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=mpmAtZIlAc7s43Nulwi1PRD3xJAMbxx6ClNnOuy9hBQ=;
    b=RcQoITGOxyrTTurymlaxCgNyreb4pf+M9M2X2VhIh9a6dNBre8RXBtYzYRm82FTaop
    U0zTbhz5/qkqBdRC98AA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGvRy6JA=="
Received: from open-xchange-core-mw-gw-9.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 54.1.0 AUTH)
    with ESMTPSA id zfda171BM683hin
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 22 Dec 2025 07:08:03 +0100 (CET)
Date: Mon, 22 Dec 2025 07:08:03 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <512263003.35605.1766383683487@webmail.strato.de>
Subject: Request for review for 4.19-st11, 4.19-cip127
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 53338
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 06:08:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21183

Hi!

Here are the manual backports for the upcoming 4.19 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

0b4f892d4caa usb: uas: fix urb unmapping issue when the uas device is remove during ongoing data transfer
d5e8379424542 scsi: pm80xx: Set phy->enable_completion only when we
82c4ffb49e987 drm/amd/display: Check NULL before accessing
772b21d2f0317 wifi: ath10k: Fix connection after GTK rekeying
7da6f50f7d7a5 pinctrl: single: fix bias pull up/down handling in pin_config_set
80bf4633c7043 libceph: fix potential use-after-free in have_mon_and_osd_map()
495e4a086b69a nvme-fc: use lock accessing port_state and rport state
d6c1721463a61 net: netpoll: fix incorrect refcount handling causing incorrect cleanup
df6e18b2a9179 net: ethernet: ti: netcp: Standardize knav_dma_open_channel to return NULL on error
aa71fdcea176e tipc: Fix use-after-free in tipc_mon_reinit_self().
92396463b534a sctp: prevent possible shift-out-of-bounds in sctp_transport_update_rto
4051e60b1c5fc Bluetooth: btusb: reorder cleanup in btusb_disconnect to avoid UAF
ef3aaa87ec116 net: ravb: Enforce descriptor type ordering
dd2973f30a943 wifi: brcmfmac: fix crash while sending Action Frames in standalone AP Mode
22a3a715eb41f net/sched: sch_qfq: Fix null-deref in agg_dequeue

Thanks for having a look!

CU
Uli

