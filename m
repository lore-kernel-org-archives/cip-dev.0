Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D16FD0657
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 08:23:59 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16119.1773217430972683508
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 01:23:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=craLcjyu;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=zLjb14b1;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.221, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1773217406; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mx6GG1GvXuAOEnBaSYf1w8Q3i9evndCaBRzUzxL2syaE3HyEMofaKCcMJnsUj9FSnj
    ewhl7FSVzTMA9KqsrN0w7JimyA3+1ShBKHoOKTLf/w0KxPXkKUc43BiEelriyM/vJSes
    gdSqXnT1kiZI3aWjuEsFe2KSngoQ5QSshasOoV5/KEI7YSk5joAwePgCKrYb1a/hX6jW
    i/l1WfnGji2RcFgg18pwMuSOugBc9ybvntkEyC6RppGzguVtSuOxAp/s6Vl5uQzPTV9A
    yhxEhojlPBD6nVXJnwzfsNyfIXCDFJEn/YTMt4gfmgCxmzrdi+ET9n55ttB5CTscCpqY
    oJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1773217406;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=oQB73yS0OW1QGTRbnA98o7Rah130BtD6MiGGtkZlFTc=;
    b=KQwD7Adr5gYPuVKrhpaB4vTZgpaYTh7TqKr3LSf6WFH0CZjy2LF97IVGdPD+Xwa2db
    1WwO+Ie0BnB0ceMENuFYRtkkT/T3RvAbp6QckRF9e0DEmkdGmw+mVqFb/wiyJWHmyl4k
    TorQ92S/DCVoGZxHlbakkllwBPgL79ZeNTWg/6UWmZscC7niZaCtFfyaFr+9qtwyAEzr
    qe7/pqPLkXXbBSYQzA/yK1qQsSNPdQgceGVVLicZAJ9LsNWllqp19T+VpCUiavfv+6oQ
    Hmb2YJmNpWPYYLpp2Xw3aC1tsf5B+IcHpziXoeqoTvfgi27ieiNJtwRscWvUaVgrUcR6
    aAAg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1773217406;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=oQB73yS0OW1QGTRbnA98o7Rah130BtD6MiGGtkZlFTc=;
    b=craLcjyuLnWuZEynNAaXQ7mIsyp3U5It3JtCgqGwJe9Vi0EAa/YyBG7dVLehqJO1C2
    o1ghn5t8ukgnHZyuhwfgMOaQxbh7x35AHZFmKn+BISsd5He9hNNd2BH7EQ+PIztVGNMD
    of1x+0xj/iR3ul7UGkhhX629KJJsoEXyWBa8gEaVgs/8kywXCje+SoF6H71a3hAe60pb
    r8aYM4ge8ShyCSX2UJ8S9xq8oKoCat+53QTo7S/Neh/gGgBtYCMN4YD/ScGZp0JsGmgW
    xoP5lnozUnX1ofnPbT69Ht398tqQtJxKyhGzx0T+rE1/Xd7kcDKTC+hXiWcmZ35Jy49w
    mW8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1773217406;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=oQB73yS0OW1QGTRbnA98o7Rah130BtD6MiGGtkZlFTc=;
    b=zLjb14b10aKexzATSa/UDOJyVuykrCb9ex4AoB4bOba4PnRcGMMjI6XzNgcmIihplG
    HQAQ2mmo4QRP3+4+mYBQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRJGu7Yb"
Received: from open-xchange-core-mw-gw-16.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e22B8NOPyh
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 11 Mar 2026 09:23:24 +0100 (CET)
Date: Wed, 11 Mar 2026 09:23:24 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1080195231.96465.1773217404718@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.19.325-cip130
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 58130
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 08:23:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22244

Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip130. The linux-4.19.y-cip tree's base version has been updated to v4.19-st14. The trees are up-to-date with kernel 5.10.251.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/

  v4.19.325-cip130:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      ef917a8bed27ab284a27aa2e8e242bab707d7aa3
    Fixed CVEs:
      CVE-2022-50516: fs: dlm: fix invalid derefence of sb_lvbptr
      CVE-2025-71232: scsi: qla2xxx: Free sp in error path to fix system crash
      CVE-2025-71235: scsi: qla2xxx: Delay module unload while fabric scan in progress
      CVE-2025-71236: scsi: qla2xxx: Validate sp before freeing associated memory
      CVE-2025-71237: nilfs2: Fix potential block overflow that cause system hang
      CVE-2025-71238: scsi: qla2xxx: Fix bsg_done() causing double free
      CVE-2026-23222: crypto: omap - Allocate OMAP_CRYPTO_FORCE_COPY scatterlists correctly
      CVE-2026-23229: crypto: virtio - Add spinlock protection with virtqueue notification
      CVE-2026-23234: f2fs: fix to avoid UAF in f2fs_write_end_io()
      CVE-2026-23235: f2fs: fix out-of-bounds access in sysfs attribute read/write
      CVE-2026-23237: platform/x86: classmate-laptop: Add missing NULL pointer checks

Best regards,
Ulrich Hecht

