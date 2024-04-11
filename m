Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97395CD1284
	for <webhook@archiver.kernel.org>; Thu, 11 Apr 2024 09:03:45 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
 by mx.groups.io with SMTP id smtpd.web10.13186.1712826215992283847
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Apr 2024 02:03:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=BcdsEhag;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=aoGqJH3Q;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.23, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1712826196; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jrOXz2uoKkIuJUtLpVNfOVJG9iVBKPTRrZOZ5YDAyk9fJNv4EEmZHX6FFCQ4jFp1a4
    R06TytC+4oH2viJr09RaqfehFhESXek84geon0oOUdlD7F2HzQTE7LUSxeNNFWi/ZbAe
    giBfdyc4aWKNBbcnQljIf6KLr49qZ/Ebtx4kzfwO7b5vZ+lYWSwmc5o8WJBHoS6kEg2O
    Re1aTP3bJ2QdCCuR9IFkaZbaoC8fm8+R+K+hudH/Kuf0uIyr4/cYBqqs1DrdGHL1BzU6
    hpz3rP3imrHlKMWUPrRXrfW2sQvd/4VJrINtFhZ8yWAXAlo0RJM39znP5oZ720v7eyXe
    ghqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1712826196;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=w5gqCWI4tz5zJp+66tOGzIPErt1EjuSvga7Swoa6YZw=;
    b=Soahpu6UECU4RTokZDuS6t1oVykRvPtVkCRXH5+5Ky5Wny1Tdc8Obfg0PnMrGC5cDD
    lBOG4AC4T7H0oCfcZQAqXFVrKIU3whjI+H9mvDePJINURINFXPOAcSrOsRxm9KwWsdr9
    Q3hxGfD+eS4KQNyJ7jt/eSx9ueaQhWlIoNg0wPtJGUezBu9ish/QJumOX3oHux6qKwDp
    7o9c52v8qpWev88SyBLJAtnWb/HAbOllc83bOzDL1g/OgrMQE3Dj8yQQEM2zJs+qpk/R
    sDiRioPO1Cvdcru2aah8Ludds7VBc2bWJ8ZsD4hKX8eeJ6trF03hBT/Fg0kkY3IwhtDd
    iIFg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1712826196;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=w5gqCWI4tz5zJp+66tOGzIPErt1EjuSvga7Swoa6YZw=;
    b=BcdsEhag3+gISNje56I5TDleYyahL0O3n4gCMkwgCgtg1tTk/1I7s3McITcUcfeDvi
    dBjIX6bVbPbCO13vYuPysq+c8995TcjpqISbPYZlwPrQaR1EfHSbhmAm4XHvbwCpCooT
    i0l9wEwhdpg9sks/8FZ6skHH/yKK7vA+SY930pl6vO1nMBj4XuqV1MiKHMgt7TTPfjb8
    +F4blBtzj3zY8JYE44Ae3SlH/n0Si8XyLuxcr6lq4hZnnBWy1bNZVcfNP7KHEy4ZoYGv
    sHAlzvRV9LnAJVqLNzT5P35mgpOSh5x9DgZFEjbCzueD7C99IsYohqVXTn/ZGwmRvSXT
    JQKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1712826196;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=w5gqCWI4tz5zJp+66tOGzIPErt1EjuSvga7Swoa6YZw=;
    b=aoGqJH3Qe09javeBGB/LVZb/THCLxq5iaZivvRWfxOAFdaSp+axkDMM8m32VptNLV7
    mWNSTV43IsmLpCNJoEAA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7oKNYMuRvGHqNa13GvhtWeC6CRd93ajscjvWFwDo3mP"
Received: from ox-live-app401.back.ox.d0m.de
    by smtp-ox.front (RZmta 50.3.2 AUTH)
    with ESMTPSA id zaeee603B93F6bc
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 11 Apr 2024 11:03:15 +0200 (CEST)
Date: Thu, 11 Apr 2024 11:03:15 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1939545228.2074682.1712826195691@webmail.strato.com>
Subject: [ANNOUNCE] Release v4.4.302-cip86
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
 <cip-dev@lists.cip-project.org>; Thu, 11 Apr 2024 09:03:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15540

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip86. The linux-4.4.y-cip tree's base version has been updated to v4.4-st51. The trees are up-to-date with kernel 4.19.312-rc1.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip86:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      0671b46d2bb34cfceec8e46f0cbd9a2128462717
    Fixed CVEs:
      CVE-2023-47233: Use after Free bug in brcmf_cfg80211_detach
      CVE-2023-6270: AoE: improper reference count leads to use-after-free vulnerability
      CVE-2024-22099: NULL pointer dereference bug and buffer overflow vulnerabilities was found in the bluetooth subsystem
      CVE-2024-24861: Race condition bug was found in media/xc4000 device driver in xc4000 xc4000_get_frequency()
      CVE-2024-26642: netfilter: nf_tables: disallow anonymous set with timeout flag
      CVE-2024-26651: sr9800: Add check for usbnet_get_endpoints
      CVE-2024-26801: Bluetooth: Avoid potential use-after-free in hci_error_reset
      CVE-2024-26805: netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter

Best regards,
Ulrich Hecht

