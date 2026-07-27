Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF45C531FC
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 15:18:13 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33698.1785165488619608579
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 08:18:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=DXVQMFLO;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=IpkvpN9E;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.22, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1785165473; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=C5WkIPkLTHagFY9JZZNdSqbhiRYNa2xX4CD6xERm8HZhjgZ+KzYf8Y9IxMd4VPfuo4
    C/McPY7PLvvf62mxmzwAZqyQvkWiHqtHAz+Rjy3zxKxSx3zQ70bcYMqULJsrnaNywddr
    go4Mlu3GS7vwRq/3AziDhafaAoRPUGVSwyd2+EEDs91fWAEYMXYMa1LOPgSEujJgnkeH
    LzO/oDumxyQP3wp0qZpjcOQn0gaO9yGBPcNSIU5a0lpAhx4pBsZmuPmaat2nPcvcyC1z
    jdTLP3Rv2IVUP9HQPk7jHyp2YaZgkZV0SkG96AhiXyFU9mdB+Li+21/eukSqpVqTA8yZ
    Pa9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785165473;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=eSuotabWMVIVM6CQutWXRZd3f8J7Isumr7Qto4IODqw=;
    b=YN0bt1osnwaNXTJnEWsj/0xT7NmGXXrjOU3iKogy0GUPtLCxLkwtaU8SaPH3W50Bti
    w1ZOad8gWDeumfmaoxZNnc9uvZJh1YcNfr90XGY1W8EtRtbWhK3e36JyKe8UhmuZiqSj
    eV0cL4l8iVS88ToQoeICUxJAmLEOG2Y6rURoXbqFewusfRvk2JUXyPkOYUA35T9/nsJS
    RhwTSlcYIX0GMmQJ8wyP15oZtj8oPoNLMG59VJ+dFLVDwOsQcy2SVRsknkxfXrevZ28y
    eO5PKLtvP38xkg91J+6ckQQwBKpLgNaS/6Lx2tHgnNGqkjI73Xh/7UaVW5zok4bZuhch
    rkow==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785165473;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=eSuotabWMVIVM6CQutWXRZd3f8J7Isumr7Qto4IODqw=;
    b=DXVQMFLOh24gUeH7J4kKxqKrmIGXY5XoGMrcSP5AUT3Nh7djEXO//M9It4dptHkUZk
    8YmRVFIU7DdUIK6CNXok0Ikrp3hd1r/I8KqPesHAb6y/GeXJ9LS4pL3K/zi1bk4+2zk8
    PVY9hYO2qFHtdswpWV86tQURosN50qj/+5PbtI3iHtAOrWTqsBXTuyuHwvhe1uNuLIhm
    PT/hW4LtAcCD33ppPPl2tKtzSHRW1QmlaEFtQF/gNSLd9AUc1/pX6zMHqHSQkAKMdpR/
    uZJ1V2ujapLtMhRTyZUPbmBKovkELBezWyjBXSsJjQaHAdEUa70ovEyi/y2srfwuqNwX
    9v+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785165473;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=eSuotabWMVIVM6CQutWXRZd3f8J7Isumr7Qto4IODqw=;
    b=IpkvpN9ES6bCV43XlBYs0UCpvYGN0/tmOiVMew0nB3So3Ji+UwJw0tduTviCtk3AaZ
    sRLTVn0BLWS77vxWlUCQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKfF+CjmMA=="
Received: from open-xchange-core-mw-gw-37.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.5.6 AUTH)
    with ESMTPSA id zec9ec26RFHrcmc
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 27 Jul 2026 17:17:53 +0200 (CEST)
Date: Mon, 27 Jul 2026 17:17:53 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <527172097.345263.1785165473174@webmail.strato.de>
Subject: Request for review for 4.19-st19, 4.19-cip135
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.152
X-Originating-Port: 52494
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 15:18:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23782

Hi!

Here are the manual backports for the upcoming 4.19 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

db198d6dc3936 nfsd: fix posix_acl leak on SETACL decode failure
bd323013cfee9 KVM: SVM: Fix page overflow in sev_dbg_crypt() for ENCRYPT path
b810867b83f20 batman-adv: tp_meter: restrict number of unacked list entries
ca96eb4f37da2 batman-adv: bla: annotate lasttime access with READ/WRITE_ONCE
86a17d8ec355b net/sched: fix pedit partial COW leading to page cache corruption
5ec48ec054322 arm64: errata: Mitigate TLBI errata on various Arm CPUs
b24d758d47d69 arm64: Add part number for Arm Cortex-A78AE
b68402df84402 iio: gyro: adis16260: fix division by zero in write_raw
f3a8383d5d486 scsi: target: iscsi: Fix CRC overread and double-free in iscsit_handle_text_cmd()
9f05da0b8dcfb Bluetooth: serialize accept_q access
b106698c9084b netfilter: nf_queue: hold bridge skb->dev while queued
50387c55b9106 mtd: spi-nor: sst: Fix write enable before AAI sequence
afa6edb63cc55 sched: Use u64 for bandwidth ratio calculations
43c19f228085a batman-adv: stop tp_meter sessions during mesh teardown
1a36cfc71bae3 Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
8bc3105c22af8 net/sched: act_api: use RCU with deferred freeing for action lifecycle
68d166edfbe56 thunderbolt: property: Reject u32 wrap in tb_property_entry_valid()
44b20b4fce209 xfrm: esp: restore combined single-frag length gate
9118dc9ac0a49 batman-adv: tt: avoid empty VLAN responses
e0f823e33114c batman-adv: tt: fix TOCTOU race for reported vlans

Thank you!

CU
Uli

