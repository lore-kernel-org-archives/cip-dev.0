Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63899C7115A
	for <webhook@archiver.kernel.org>; Wed, 18 Jun 2025 15:43:34 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
 by mx.groups.io with SMTP id smtpd.web11.2154.1750261406970443592
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Jun 2025 08:43:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=s0FgwEaL;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=U0G6o6vY;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.221, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1750261386; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=W3I5LLeuF+vgZQJmnqW/ZLu8JDBe5bHTp8iday2z9hnHAmsz86CSAi/fmH9XC64zDN
    3LTz8S6CUxpqt34h76tAIDHE/65o16N0kd4+Hkr62opIQSoPK5PV07pYEp5WaceJRhbH
    RxYCQiD0F6/YWv9XUutyXPaD8KFkOuDe42hk64XR2GpHZbzoPe3u3j889NJ9ZLlHAHZd
    JBz3XgWPcZbtI32o8r+r5wiZ3dTeghMQMm7bAZsvn2y/RDhs9Ix7Tc5jUAg5we4z7MJu
    OMFpZ67LBzU8eOrMt12jQW42VRl94xXT8nD9zhAdzyFgR9+gctTXRcZfEn1J/04VAiXs
    t8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1750261386;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=lHy1GnVWgX72j/YMCHzU4NMFuavAm/lQD9PDU1FLAhk=;
    b=FNhcl1HsyG6FNj+x75+gDrvGIreZrHPQiq0i86tylO9kgGDQbBbzdtpojCukmpkMyo
    sm8zPW/Q9RFzpBGIiX9I9SeOY9M44JBR/AFrC83kfQzWUQeUnADwOds1FMkAoH0OlB9l
    N0q5lsUWGd3NHIOvwQiGB/pOjcBYyqg2AjadqgwJNjN9c4vjqPvoXiU6eOK9FWggmkjc
    GSyha4bPn0kph1/zpfHsBjkPTqamC/ReB2VdqEhS6ztQuKq4EX0VzVVkxqBrJ+ghKXBE
    7gQnkkahxigOJfwfi/IweYr2zYe3g9b6BInw8AfYVtkRq7j76xXuzorlqFV5RX3PNb8F
    RcJg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1750261386;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=lHy1GnVWgX72j/YMCHzU4NMFuavAm/lQD9PDU1FLAhk=;
    b=s0FgwEaLnCPztLu25Zp72cUMp6dajPTf09hOMtp4ek8ALGO9DgNWHMblNIDejem582
    YN/d+nkVrSA0i/fDL9Et5yoc1pPuybY3UZL67iT78j6Gj60AWXNlBjQEkRWc6PF6+hey
    PPA2we7swD7jQegk+jLtcbAhZvE3aoT4Edj4UL/VG50H2DsM8KtTGSY9JxyPoRkeKpLz
    WKXRXdwx1VlKi9OELEM0Fa2tpoLx4KrQrJCgzUxtnZyN454tkUh9LEWkmU41yVsRhqGl
    K2MvVLs44BCSEG5trcSPrKi301l9YYjzTdtUkfEacykQdQXmwiSmFglaDnGRKlvKT//h
    OqaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1750261386;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=lHy1GnVWgX72j/YMCHzU4NMFuavAm/lQD9PDU1FLAhk=;
    b=U0G6o6vY38aQwnd9w6WJuajDYFqFlQroKpPOkgjLF4xIat2iq+Gx6lAAOLPakMpjF3
    s/JnGcSCiYyFrN4TmUDQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6fd76vq"
Received: from open-xchange-core-mw-gw-27.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a34015IFh5UuX
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 18 Jun 2025 17:43:05 +0200 (CEST)
Date: Wed, 18 Jun 2025 17:43:05 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1248809954.332938.1750261385692@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.36.53
X-Originating-Port: 42696
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jun 2025 15:43:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19133

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip100. The linux-4.4.y-cip tree's base version has been updated to v4.4-st65. The trees are up-to-date with kernel 4.19-st5.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip100:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      84a149c05261c75dafef2f88f17bd42db7356b2c
    Fixed CVEs:
      CVE-2025-21681: openvswitch: fix lockup on tx to unregistering netdev with carrier
      CVE-2025-23150: ext4: fix off-by-one error in do_split
      CVE-2025-23163: net: vlan: don't propagate flags on open
      CVE-2025-37740: jfs: add sanity check for agwidth in dbMount
      CVE-2025-37741: jfs: Prevent copying of nlink with value 0 from disk inode
      CVE-2025-37749: net: ppp: Add bound checking for skb data on ppp_sync_txmung
      CVE-2025-37758: ata: pata_pxa: Fix potential NULL pointer dereference in pxa_ata_probe()
      CVE-2025-37780: isofs: Prevent the use of too small fid
      CVE-2025-37781: i2c: cros-ec-tunnel: defer probe if parent EC is not present
      CVE-2025-37785: ext4: fix OOB read when checking dotdot dir
      CVE-2025-37789: net: openvswitch: fix nested key length validation in the set() action
      CVE-2025-37796: wifi: at76c50x: fix use after free access in at76_disconnect
      CVE-2025-37810: usb: dwc3: gadget: check that event count does not exceed event buffer length
      CVE-2025-37817: mcb: fix a double free bug in chameleon_parse_gdd()
      CVE-2025-37823: net_sched: hfsc: Fix a potential UAF in hfsc_dequeue() too
      CVE-2025-37838: HSI: ssi_protocol: Fix use after free vulnerability in ssi_protocol Driver Due to Race Condition
      CVE-2025-37839: jbd2: remove wrong sb->s_sequence check
      CVE-2025-37841: pm: cpupower: bench: Prevent NULL dereference on malloc failure
      CVE-2025-37851: fbdev: omapfb: Add 'plane' value check
      CVE-2025-37857: scsi: st: Fix array overflow in st_setup()
      CVE-2025-37858: fs/jfs: Prevent integer overflow in AG size calculation
      CVE-2025-37862: HID: pidff: Fix null pointer dereference in pidff_find_fields
      CVE-2025-37892: mtd: inftlcore: Add error check for inftl_read_oob()
      CVE-2025-37940: ftrace: Add cond_resched() to ftrace_graph_set_hash()
      CVE-2025-37982: wifi: wl1251: fix memory leak in wl1251_tx_work
      CVE-2025-37983: qibfs: fix _another_ leak

Best regards,
Ulrich Hecht

