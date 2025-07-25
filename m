Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E958C87FCA
	for <webhook@archiver.kernel.org>; Fri, 25 Jul 2025 15:55:46 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
 by mx.groups.io with SMTP id smtpd.web10.22848.1753458943788854267
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Jul 2025 08:55:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=mmtRw0Vp;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=psgzOMjT;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.218, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1753458928; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZGzzCQ2aJPpOSmJs8OVy9eJnIrAzOb71g5BB9gDZuD3nNwC+GNOfCt5N2Ud4PpaHPM
    RTRNrEh01ISHln4VvHCMIvIFhqHP4AKUKcbDis4tYMk/0+HTR/3qqecR04cXPnkF8PPr
    3drsvO2G7meKHJkd4UR5TjVghK33iVNVanMVnPG+z4zN4nEr0Gi2nSU+bbWoXnmJwwou
    GHjd12Aydllo4kuhcf3mPJhHVhd8L8SAqJbDOOB2pwiPYBj9Gc/LbvJ1lCkWWNVjLbT4
    Nb/tufdPIRifsfeTJO6TKGhOY/YOpR6zM8wtOep26PBqlwDC/pzAxE/29O/nBYojG03b
    7aaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1753458928;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=DEiSMFiZtN1t5N2RmowKfK6ZvbJSqXwdi3GnLcnleac=;
    b=osefniqCFrbRMsKk9lqJQ+JmnX/J/ML45uPnjU6EBcAZ/84vDE2bxZ9HfC4Qa4IywM
    Tmp514xlinQ1naO2HJkKuXHJzpXJg5vzeuhXeR+nd/sxyy08KZd/30hcNRofMHkjwG1o
    5f2q/hwQvE1vdA7ml0GOx+wf81nTxwn93UZwl6BoyCtTgGTwHLLfigouwCmQ1OMNz83P
    C8sVekzbsPH4Kjoj/R0O+McIsWsncAgGQrKPNsYPL/ZhsPdtDxAcFjSaqAWzdhgLLCpa
    asxYL8/4YLj4lSi7ITHBvuBs57ocpI3oMZjiql4MNhKUfKASeVhPafWurRp28to14ODr
    825g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1753458928;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=DEiSMFiZtN1t5N2RmowKfK6ZvbJSqXwdi3GnLcnleac=;
    b=mmtRw0VprUyJSCyZ9ZfDHdJVDEo+PpC/9a9rVlADsctT54gBWsesL/I14V3DZ5ACpo
    z2bw69PrrxXV2X0vxKapwmGfCGTTip2z6rnwu9ksf9K3EaRCDkP3Sf0Ql7iAk/XKAnta
    OL/kEIHFFOSc4ez1Dd1+LMORabrPtJ5UnmjsrNkTI3Wfo9sjC858U/ClSvsKcZ5FX1MK
    sn6Vm1qqd+ehVNjmRWLHx4oQpGqzdTvTGKHejFpS9TT4MUzsYZWsWd6ZnCQZ5WhqYMPE
    /0TJz5jE5kkDs/wPDPSB9MYWKJb453+6J6BstOs1ZmUdAkaVJmE+wQT0Rvmn/6M+o7LV
    xX5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1753458928;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=DEiSMFiZtN1t5N2RmowKfK6ZvbJSqXwdi3GnLcnleac=;
    b=psgzOMjTaYIh0UK6htvfHgld7NYH8KwS05eUY8XQB4GlJWEKxi3frxCmLjt2hEdGD9
    dYglWCxeRa7AKdfh3ADg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hewKXd5F4sJQ=="
Received: from open-xchange-core-mw-gw-13.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 52.1.2 AUTH)
    with ESMTPSA id z5ff6216PFtSSVQ
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 25 Jul 2025 17:55:28 +0200 (CEST)
Date: Fri, 25 Jul 2025 17:55:28 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <158891858.150095.1753458928281@webmail.strato.de>
Subject: Request for review for 4.4-st66, 4.4-cip101
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.36.55
X-Originating-Port: 58570
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Jul 2025 15:55:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19595

Hi!

Here are the manual backports for the upcoming 4.4 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

a2f74f85cb66d vxlan: Annotate FDB data races
f158152d3d705 hwmon: (gpio-fan) Add missing mutex locks
8c643c0ff20e7 platform/x86: dell_rbu: Stop overwriting data buffer
495e3a4a467f4 net: dlink: add synchronization for stats update
4ed3668110bcc wifi: p54: prevent buffer-overflow in p54_rx_eeprom_readback()
c6eb7a3b1735c net/mlx4_en: Prevent potential integer overflow calculating Hz
9d5e1398442b0 nilfs2: do not propagate ENOENT error from nilfs_btree_propagate()
47ba411d24712 can: bcm: add locking for bcm_op runtime updates
945b6360fe7eb x86/nmi: Add an emergency handler in nmi_desc & use it in nmi_shootdown_cpus()
1e212aea72d77 rtc: ds1307: stop disabling alarms on probe
74518f09c042a NFSv4: Treat ENETUNREACH errors as fatal for state recovery
5f03c37e98316 ARM: dts: am335x-bone-common: Add GPIO PHY reset on revision C3 board

Thanks for having a look!

CU
Uli

