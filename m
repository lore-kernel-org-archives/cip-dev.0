Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336B6CA0EE0
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 08:13:20 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
 by mx.groups.io with SMTP id smtpd.web11.95609.1755072799463548639
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Aug 2025 01:13:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=kMaJIhfO;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=a5DPHEOb;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.218, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1755072788; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FQRZmqKdGFrQVauaQ+bXNXSdczMg5W9fM/EQbz4BDSuTr+rpE3nhzQvfwytv8732j9
    LXAZvbZbv4qMIG/sGlzn3YjyygH7A8PxEKFtf/yuvB1QLZwjheE43PJoPiIBbmF3uTw3
    dsCtPV8V4vsGkz5u7Pzdk7H3ESuSmKJWyoiGwzPJv+raxZiGEq/jURxbDa2Tom0guOnq
    J54gOK/XzvLB3BBFZRYcnhfeNfmyt98aS0RasGZTC8VBH2mRbTShDL+RL61Nj7+nUdYJ
    7L28ks8hmXZ9SX+QJBFGysd1iAyCcPgJNPfAZa6WB8XPCAiB30qCu6LfvSzsHxUuZGPA
    aEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1755072788;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=yL0HWths1fWru5sqg7W298POqRqdUV4Y+LrDN9Tf3bU=;
    b=RDdrmeXISavKGfJnL8WEC6KcrKEARMS/LNyGYYONDA6P+4BciV68GyJVA9GGmrRcA3
    WTiqPGutmz1EwwsR53YIMwh5g+uONHSYt9FX5mLtvfvOLBHM8KjFYdLglw0j12PW4X/b
    uD7WD5PGtMzzDAjFLZpDxywMjHqHbiS3duRlwCXzP+4BtP1vqYR0Q4yxheAHeND85bnc
    GUrJJjFO6iK13oBS0sXcQrN2rru0tRQMISM+CALIIe71F0zcEcTyM/tnWgsRia5VIEzS
    RXieUi1SNM3rwLWlR8cBcM2FdhqDntjEpsoTjJ0s21uqx60Vr4HHwYahLSGGg6PdkwSq
    71Uw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755072788;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=yL0HWths1fWru5sqg7W298POqRqdUV4Y+LrDN9Tf3bU=;
    b=kMaJIhfObMol1I2S9s+0fwiIDMQb7hj+rU6j4BZY82jusEe123NEOlDbEfkjAJYjVE
    gy0JmGYHM9Ll0xDam7kX2XsLn+0SfChhi8QIbs0gYiLiObAYlWAj9mJ4Zz8IDiyWbmVT
    MKBS1IJ77/uGGxhvsjc/ECUMzREsbdeGwoxywjR4S0+uo7aiX8f7HBbSSpCzziROHF0M
    m9X8o5XVOVswXAAIKpoqFU/2jPHXRbbu/3FB3plWZpB9Ez+RT3v2TdrZE1H4HFGHH+Tq
    cTktBZDywDaBf1GmcdPE4gCveXB9At4u8Fc5cetVKaY+s9mZXHGDpWJ5LsuHRYTvcnVG
    yvgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755072787;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=yL0HWths1fWru5sqg7W298POqRqdUV4Y+LrDN9Tf3bU=;
    b=a5DPHEObGbScyAW756vtkbWPsQQ/JhhnlPSs5yXUi9HyWecZ/K/r4MOKBijJMsjsvd
    YJ3CrjesnqaP+NUuM8DQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hewKXd5F4sJQ=="
Received: from open-xchange-core-mw-gw-9.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 52.1.2 AUTH)
    with ESMTPSA id z5ff6217D8D7b8H
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 13 Aug 2025 10:13:07 +0200 (CEST)
Date: Wed, 13 Aug 2025 10:13:07 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <2044856947.285232.1755072787301@webmail.strato.de>
Subject: Request for review for 4.19-st7 4.19-cip123
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.36.55
X-Originating-Port: 35746
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Aug 2025 08:13:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19722

Hi!

Here are the manual backports for the upcoming 4.19 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

2d06b88d7b674 net/sched: Abort __tc_modify_qdisc if parent class does not exist
81ef51e1ea6d3 mtk-sd: Prevent memory corruption from DMA map failure
20521203f5e28 mmc: mediatek: use data instead of mrq parameter from msdc_{un}prepare_data()
3048009716dad scsi: qla4xxx: Fix missing DMA mapping error in qla4xxx_alloc_pdu()
8589bbe304882 btrfs: don't abort filesystem when attempting to snapshot deleted subvolume
6bffeee62f0d8 VMCI: fix race between vmci_host_setup_notify and vmci_ctx_unset_notify
466ceb3aaec13 tty: serial: uartlite: register uart driver in init

Thanks for having a look!

CU
Uli

