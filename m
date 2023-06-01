Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6262FC77B7E
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 08:18:28 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
 by mx.groups.io with SMTP id smtpd.web11.26152.1685607503259288621
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 01:18:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=Nao6gUvn;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.218, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1685607500; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZJTrZY4N2DrpDC0VzAb6CMTZBGPrRFTKWUzygj+Cq7a0+Ewdhv3gQHfVaswn8riRMy
    +V8bjujdBB8KCOdF8UtWXSOKOLwrBSGjtlzW0atHHJKPUqi+l/HPXIzkP7ELZawwjhOV
    XJFK7bwR44LOrWkyal8EZv2Y4KpKwZvAmVIFa5ayHjQEwXPMbwZPJP/m00x5UtSw0/4/
    o+aVyg+TdJm5IOj99pcfoN1Pzzc7wU1B2xVJNbdQpvjljDNJKJ1AmLj9hsSLXWEwmR75
    4LmtemLWFZF0JrSQP/xzgZFA8eV3XeCc1v4aaqOC1zJRFgMIPLpzZnH9cthuO3bmfDKi
    egRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685607500;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=6/bmYjAsfjpXDSuO+8c/TksjN51tkSWQkIxexsPDrBw=;
    b=CXzSYoM2CGnhgvtgodD6EpSDxIejhP0OgE3hHMe8S8+8jo03ndq//ds4Nu5+tKUbf9
    4w01DQsCyWGQATJ7bGItDaf/ORsVWWm9aOFQ0oaUDSo6smDIDB/ips7J+nsLocsHp4VU
    jEBQ8NgpGUAngXg8xa+KRnXScH7c70Gm5ShDQF//xWvSJDm5zjPgeT+2B70trYnQHRrz
    XQ++BCm40XysUqOM87UYjHE7WdekHGpc6cxU/xCNusmhNAOHaDIyZxZRqzVjXjwmwLqT
    GzgLXrHnln/qs6+70/7sfgBKNkHBE2iB6QZRFDDiAteFVcIfBzj60egpLnpahWEuv3CI
    XvXw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685607500;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=6/bmYjAsfjpXDSuO+8c/TksjN51tkSWQkIxexsPDrBw=;
    b=Nao6gUvnw5TqvlDWK4PFcGlBFViPV0D5Uody+aypXubr0m6xJRgUvO3ZzMnEb50yXZ
    WQLzF9ekVyfQ0Gql06VjXsbClcn2rUbkshP4acyZUCnmrb+Dg8+1w2JLw1ige0mSmAoE
    C5mDHEpeddE3cskhHBb0QYKEq7qMPS+Z3w96kL5Rps+EwWJHTtBTDvkX/ZXVruniMULB
    QeTeXN9fgGsydy5hEuWqvr7tLsovsszahJJu5oW59wmsmtxteEBwTTiKXMrzbvwqxAIE
    CEF3imp1YQqSOMRVjRII+N8yr6SyWcnAYJZa1hq97caf2eo4zKFN8iAQ3748cTouWf0s
    1rFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685607500;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=6/bmYjAsfjpXDSuO+8c/TksjN51tkSWQkIxexsPDrBw=;
    b=TByz4NprJfcY/Awhh2tdc5HLVaufPQ9Fa3s5aDAdwHCPHegvMKvoSG8ADws8HrfArk
    hUXYJ3AOdAgEMvY55mAQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCt/7N+Odk="
Received: from ox-live-app402.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.4.0 AUTH)
    with ESMTPSA id N2af97z518IK1xe
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 1 Jun 2023 10:18:20 +0200 (CEST)
Date: Thu, 1 Jun 2023 10:18:20 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Message-ID: <1864470219.2230353.1685607500584@webmail.strato.com>
Subject: Request for reviews for 4.4-st41, 4.4-cip76
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev43
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 08:18:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11720

Hi!

Here are the manual backports for the upcoming 4.4-st41 and 4.4-cip76 releases that should be reviewed, and that can currently be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

Trivial backports:

** m | 998080b96 c77065 o+ | i2c: omap: Fix standard mode false ACK readings
** m | 911c66cfc 8ee3b0 .+ | drm/rockchip: Drop unbalanced obj unref
** m | 6378f4810 40882d o+ | NFSv4.1: Always send a RECLAIM_COMPLETE after establishing lease
** m | bd89073fc 28a65b o  | nilfs2: do not write dirty data after degenerating to read-only
** m | 7dd95a282 4c0b48 o  | ext4: improve error recovery code paths in __ext4_remount()
** m | 5a229d21b 2220ea o  | ext4: add bounds checking in get_max_inline_xattr_value_size()
** m | 8e7655da8 a939d1 o+ | netlink: annotate accesses to nlk->cb_running
** m | 021d30d05 04e827 o  | serial: 8250: Reinit port->pm on port specific driver unbind
** m | 1afc51187 9be24f .  | mcb-pci: Reallocate memory region to avoid memory overlapping
** m | 1a0b65dad a398d5 o  | usb-storage: fix deadlock when a scsi command timeouts more than once
** m | 0c9f71a5b d2b005 o  | serial: Add support for Advantech PCI-1611U card
** m | d5fb07429 9b5a04 o  | nilfs2: fix use-after-free bug of nilfs_root in nilfs_evict_inode()

Equally trivial backports, but with differences in context large enough to warrant a second look:

** m | edfe57aed 0ba9e3 o+ | serial: 8250: Add missing wakeup event reporting
** m | 74400353b a8e478 o+ | drm/probe-helper: Cancel previous job before starting new one

Thanks!

CU
Uli

