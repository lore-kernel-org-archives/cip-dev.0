Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C825C43458
	for <webhook@archiver.kernel.org>; Tue,  7 Jul 2026 13:50:58 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.174850.1783432248260338503
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jul 2026 06:50:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=FNRnlsTg;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=GEzhSwt9;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.22, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1783432236; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kswxAflPcNI+UddPmDr9f/H8wBIVzG6zSNe6i4lPBOLwb9XVTN8avPSaau2BYY9tir
    UAidkPK04N++3F1LzW2Q5/LLBgNRxECeXUS9OTw4tHHQMH6GgIJMSQvCHBnFz94zx+nX
    NQ90FQbo6nDSOLFdJ8rdm6slsBJVZ8+KMxl8pzYQwS7fpqs4X0RU1zyjha80fzQcizXO
    +0QO9d0D5zczTOYdJ6aVSHAzGIgEJd1ejwQ0mWp6xQNyKHpJcumFr3qwqoW3A+y7xXWB
    w7BVs05JrblQq9g3GEaXRLCsTiAO2Fe8+7yglBfpc8lthnOXKNy8mHLBYJ8bYFQFFqJ5
    vk4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783432236;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=sjGg7eOHygxxXc1mu/uDVDHf7KBpiQ/Bh/hca27KLSQ=;
    b=PM2hOcJOC5T2noVlsev3Vl87xZKjmlAVqpdLbimLiDaCLmcxcelvA0DPTQU+YzAAXg
    lnDNB+v/ctXBAt8E9qNVRy2Vho3aw6RywGctRu5tVT7AQZ3FcOOJXs0aa7KOFFA6gwV/
    EXcPn5O8UqPG875BY8VWADO9o1EG7OxxSYC3fbflniJB4T7oUSVGwp2QGUuzi/KcFweP
    YYe4jklCuBgY4FOS/AdISJr45z1XJ/xjCgPnzu/nHcuFQn1/Td4W8GfyUTOelcx0J+e1
    MMrTVs3Otf9skmSpByvLxwBjrUIAk34y8zgeoGJMGjnadDs7255sdFRAhsxh3VtWB8X6
    lhlg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783432236;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=sjGg7eOHygxxXc1mu/uDVDHf7KBpiQ/Bh/hca27KLSQ=;
    b=FNRnlsTgKpjK8dzRfvs36vB9QqVbZMfDSxchPuGBIY1Ln7+zZHZ2/ZnII5NTbyjyeW
    uRwgNoFBcOZJnyCPsZ7AbaIP7gjOy+9ums8tSv8B4GQ7/YgRHZzk7oleRdc1+Q5LG5QU
    kas+6keeQRGbLrLnxRWwlOgVkl5K/7mpyd94CVmRBw3sY8l3mEPLrZ31bSDafXBs3Bls
    5qCSfjOHRI2359e2c6pLa1ofHEUC9bGtFvvb0r2OfOwxbXNw0d9/3diHXdh0hrYUqBUX
    2qkTMkY8HZI1ISGqmewBAWTQR57Cmx+cZRp6OCSarUWRv2SVTgKAxVBvAhdbuHqbgCIv
    C0Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783432236;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=sjGg7eOHygxxXc1mu/uDVDHf7KBpiQ/Bh/hca27KLSQ=;
    b=GEzhSwt9P/HSPsqjzgWMN8at9yKLEKSwCl9/rpwYcPk0yLjSxKpA65JoQeDCXqZbbx
    0WehTUXXJkcUFNOzNHAg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKHE+Dw/YsQ="
Received: from open-xchange-core-mw-gw-36.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.5.6 AUTH)
    with ESMTPSA id z4c16d267Doatg7
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 7 Jul 2026 15:50:36 +0200 (CEST)
Date: Tue, 7 Jul 2026 15:50:36 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <396580511.533337.1783432236611@webmail.strato.de>
Subject: Request for review for 4.4-st78, 4.4-cip113
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.142
X-Originating-Port: 47990
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jul 2026 13:50:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23473

Hi!

Here are the manual backports for the upcoming 4.4 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

6fc536e081b4e cdrom, scsi: sr: propagate read-only status to block layer via set_disk_ro()
a70db8dc8aa2d bcache: fix cached_dev.sb_bio use-after-free and crash
d6dc394717b9d can: mcp251x: add error handling for power enable in open and resume
270f518e2aab7 batman-adv: tt: fix negative tt_buff_len
b9d56f0fa7881 batman-adv: tt: fix negative last_changeset_len
2ea84dbb4204d batman-adv: frag: disallow unicast fragment in fragment
3075eb7fe5a6a batman-adv: fix fragment reassembly length accounting
5c81177e39927 batman-adv: clear current gateway during teardown
516397de58548 net: usb: rtl8150: fix use-after-free in rtl8150_start_xmit()
2c14f681cb8ca netfilter: nf_conntrack_sip: don't use simple_strtoul
a177703144795 netfilter: arp_tables: fix IEEE1394 ARP payload parsing
90d4b856cc573 netfilter: conntrack: remove sprintf usage
a5e1c4172bf7b sctp: fix OOB write to userspace in sctp_getsockopt_peer_auth_chunks
a4e3e33596f1b HID: usbhid: fix deadlock in hid_post_reset()
b2df99543367b ALSA: core: Validate compress device numbers without dynamic minors
a856ea763a0c8 batman-adv: bla: put backbone reference on failed claim hash insert
420d73ca52ee2 batman-adv: bla: only purge non-released claims
283a66b993a78 batman-adv: bla: prevent use-after-free when deleting claims
1f1f946bac592 power: supply: max17042: avoid overflow when determining health
0bd353e476ab2 fbdev: udlfb: add vm_ops to dlfb_ops_mmap to prevent use-after-free
e27540595d282 md/raid5: fix soft lockup in retry_aligned_read()
16b4cbdf426d7 lib/ts_kmp: fix integer overflow in pattern length calculation
f03a0d998b054 ALSA: control: Validate buf_len before strnlen() in snd_ctl_elem_init_enum_names()
7d2c7f0155186 gfs2: Validate i_depth for exhash directories
06c757446f45d rxrpc: reject undecryptable rxkad response tickets
f842b70abca24 wifi: brcmfmac: validate bsscfg indices in IF events

Thanks for having a look!

CU
Uli

