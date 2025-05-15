Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845F7C2D0CD
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 12:36:34 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
 by mx.groups.io with SMTP id smtpd.web10.11346.1747312586545672063
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 May 2025 05:36:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=pjUu98tL;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=ZqX4KXJm;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.221, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1747312562; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=e4vbdm16p1p1bFSy2AfG8DCfcuu4Dnit53gT8daEAtAbAOByFQ9QdE25QpCHPZlT2m
    kImcvobP8oBgc7SnxQe3U4MqKObGo85VSwrIQvyXV7kInW9hudCplcmDotyiZ3acQkJx
    qVInahFMewuUk3RyltWbgipcJo0LrC4obksh89gfBr+dWjpBqTOROWebRC8+Fhhj41ym
    ZHAdtW/W1HA1fAiP8+YJ7LMoRWtD3z0C/weTdISaHMJmZt2P85C1LqsKv41oi2FnQqso
    3eJczE7ApCkHTojVJZoiPnngs9PxTXwrLOlw9kthCI7LUg3eGCGwh7+UP/kurNhP9Ni+
    U63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1747312562;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=8xLWFbJvczzTLzBv1aqMB1ECAVavxL3tHkRCdcbH6wE=;
    b=DgWQmBYKgD9tArTgqiPkAOH2GRIXojKYm/543L8/cp9Koqy08VhbH+ZY6Wo5VgSKsy
    GOiIpJdSja5F4RXcCe5oscpIy/jM0mHarXMlu6JNG9Dxg0dDRl1efk72KWyk8YH4SvwP
    HVBX88DCTAGGo0Lq0nrLhHVsGalQAOoKtmbzkvP932hadQ0dC1qunhhioDy0sXQjVS4m
    hbb3kDyG0GnTQ3rpkg0GKms6mpBpxJIkkcGn3G9T08t3i5qgzXnhXeG7uQKO7ndm+OvR
    F1RXzODOYmEdbxJCzEXbvBekflp08rU9cWChlsnAkbQtHoEN/0p8771cEfeixChvJoA4
    pXrg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1747312562;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=8xLWFbJvczzTLzBv1aqMB1ECAVavxL3tHkRCdcbH6wE=;
    b=pjUu98tLykbFybYevsEFyPG/8bcStof+lYYL5uIg7/uiIRvP96Tjp4EYbqG7E4FFGt
    9h5T2ZU14REWo5/XpgXe3jiX6BrCT3J6tL+kWKeFQwLTRdVcFdutJWUPjcRtq0Scudkl
    /aaweolHcgFJrjsIiMOvt9VUci0KDof0EO4Rc9FuMKlDNv/bxB01QiiFems2+YyfrBgP
    WCsEfNLq4PhdXtrQtdVTAg9eRqaDpmedoInVCGn4ytWQvPNwzS0d2+9Fe9bCt9uppgrp
    /W8pBVar36ts8Jv1dJkgfSID8RowbE3T/lPeLpZcz28C4GKMOK13U3GiOw5kLapkoIzO
    z1Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1747312562;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=8xLWFbJvczzTLzBv1aqMB1ECAVavxL3tHkRCdcbH6wE=;
    b=ZqX4KXJmSMPueLXhx1yZYiUmiFPkwrR3lBecjBLTIFlgIXQk0tU40wkeDLAc6z4By+
    H2BzxugsoKI2iURoIbAw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6fd76vq"
Received: from open-xchange-core-mw-gw-14.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a34014FCa2SnA
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 15 May 2025 14:36:02 +0200 (CEST)
Date: Thu, 15 May 2025 14:36:01 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <585489375.340335.1747312561927@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip99
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.33.60
X-Originating-Port: 60522
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 May 2025 12:36:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18911

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip99. The linux-4.4.y-cip tree's base version has been updated to v4.4-st64. The trees are up-to-date with kernel 4.19-st4.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip99:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      e6c5131ebe8aa7b802f05d277d357a9c80c32da2
    Fixed CVEs:
      CVE-2025-21638: sctp: sysctl: auth_enable: avoid using current->nsproxy
      CVE-2025-21640: sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
      CVE-2025-21992: HID: ignore non-functional sensor in HP 5MP Camera
      CVE-2025-21993: iscsi_ibft: Fix UBSAN shift-out-of-bounds warning in ibft_attr_show_nic()
      CVE-2025-21996: drm/radeon: fix uninitialized size issue in radeon_vce_cs_parse()
      CVE-2025-22004: net: atm: fix use after free in lec_send()
      CVE-2025-22007: Bluetooth: Fix error code in chan_alloc_skb_cb()
      CVE-2025-22018: atm: Fix NULL pointer dereference
      CVE-2025-22035: tracing: Fix use-after-free in print_graph_function_flags during tracer switching
      CVE-2025-22073: spufs: fix a leak on spufs_new_file() failure
      CVE-2025-22079: ocfs2: validate l_tree_depth to avoid out-of-bounds access
      CVE-2025-23136: thermal: int340x: Add NULL check for adev
      CVE-2025-39735: jfs: fix slab-out-of-bounds read in ea_get()
      CVE-2025-21971: net_sched: Prevent creation of classes with TC_H_ROOT

Best regards,
Ulrich Hecht

