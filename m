Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47183FE51F0
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 09:13:41 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17054.1777022014572825758
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Apr 2026 02:13:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=oMQCh+S4;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=Eaq0NGhl;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.51, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1777021988; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Y4aALO+/Q3Du4LYOjVzmP7wt0Wl2cAyz/vLK2StaabpBGrciCi/k1OFM2P4wyktgMI
    gy4oVXYaXZmlXLrUJJpeEnNhWsGnPbdNeDy8mzHKWajX6LR4R4Wyg6sOykb9VBLQPbzE
    JNieACDj5WEttoLCvrL3/RHBlvZax0/fovmIIO+TD0v2wQUFjT2AvW9Q53y+OXs0j+iz
    qVGJRlGi8VB0nf4C0CUvYupVD5LCNihWAyWGwlneGekuxa4+ro6GDCDaD+GYCCLzP/nC
    jhrlLWOMym4MBzupm6l2nSCz3duIKu2mGid6wGkDPXcU8bXmZyO7GHSUkQb0deEjHU+o
    H+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1777021988;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=G1vcriIg3sNfGzhEpWFoROEU2M19NLVpATL5RjaXi38=;
    b=Jcfb5xYG8H5ie8aLX4eZgPBFN046FaS8TXWVF+VbrNZxID1M4RUAyDRlCcq9WVdyui
    Xka5HLJ0O9MNbh3JcKMBo8YHEzi7+ifs7kLNkvvl7BWzbhkV60sOQWgPMLM6C3aCGNNk
    0lc4fup0nNJPVR/37ripVEF3qhPQPA4RpLVPn2fOrCpZXOtyu/qnss2IzTM34kMB8fau
    qIloiVtasstDU5b8iyp0s9eib+/X2bo3i12R2soefjB4eMFeOeUrbin3nRs+3GXT2zEv
    TQWQYWrv1N7vlK45cgm4sb1/bnVdPW4MotmDId+wVt6XtrzhotgipzxYPJJ1v7pp7RZ5
    qCkA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1777021988;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=G1vcriIg3sNfGzhEpWFoROEU2M19NLVpATL5RjaXi38=;
    b=oMQCh+S4NwBlsnWy+zY9BLmWXYHTjrf5E99fmbesnTqIlSx/p3l4lIewdyU1D7E/A2
    0ElkcCPql+IncnvfiMbl5/uSmO3hXZ0UJ/w7XKZdYtxqnawhYBzDFpVyrpk5fQx2SeIE
    kL3a/6mOqe1CtUUsYUhO+0LpXQyw6LUPyIeVcAps92D3SnRq+6ByFfZHOMUKMaziiLt9
    kAMQmdNcKpklEYvUmkTDObyLQvqaBgIMaxJ2vN71ZnM7ktW0AU3b+CQmNPaMLa45N2Um
    8JRYttrMpxMM9EGhfGnPEF0JQFsRP2yl43hwneYg73TorW12ffHj0FFXwd0Q3KQMVpIK
    FDnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1777021988;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=G1vcriIg3sNfGzhEpWFoROEU2M19NLVpATL5RjaXi38=;
    b=Eaq0NGhlMbQCwFA8EHO3i6AvRaJ1GK3559k3a0aaT1T63w1OlPrbaNO56eSkdX9d8P
    04PVMJF08oXEBfMMcvDA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKDG+LdTmA=="
Received: from open-xchange-core-mw-gw-10.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e23O9D7LPr
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Apr 2026 11:13:07 +0200 (CEST)
Date: Fri, 24 Apr 2026 11:13:07 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <71097281.1249841.1777021987756@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip110
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.88
X-Originating-Port: 34536
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Apr 2026 09:13:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22807

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip110. The linux-4.4.y-cip tree's base version has been updated to v4.4-st75. The trees are up-to-date with kernel 4.19-st15.

You can get this release via the git tree or (hopefully soon) as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/
(Archive processing has succeeded, but the tarball has yet to show up. helpdesk@kernel.org has been notified.)

  v4.4.302-cip110:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      fa2e18c9d916ae13d85c6a8bfd2aa9df2c63ef54
    Fixed CVEs:
      CVE-2025-39889: Bluetooth: l2cap: Check encryption key size on incoming connection
      CVE-2025-71239: audit: add fchmodat2() to change attributes class
      CVE-2026-23241: audit: add missing syscalls to read class
      CVE-2026-31411: net: atm: fix crash due to unvalidated vcc pointer in sigd_send()

Best regards,
Ulrich Hecht

