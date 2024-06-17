Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0FEC27C6E
	for <webhook@archiver.kernel.org>; Mon, 17 Jun 2024 09:32:54 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
 by mx.groups.io with SMTP id smtpd.web11.52190.1718616772910934142
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jun 2024 02:32:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=Pv3dmR8d;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=mzlW43uY;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.221, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1718616755; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ayAf3DWtSL3nEMdMSiPWi22+G2cMDy9OdffWTtyeX+SBpoMK8yrquFMimOsaQg1Rie
    u0QklUmubp9jDkymTzEBZ1plAaZ3B513pafjC0yaME7zRORxnM+RnYmNQBnlb3P097KM
    +rSJX3GE9TEX1buMvLF3kFEJ5eELmW75xMjSNMqy5dlu4GjxmGUc8v4gGGqUBUc4/nWp
    QGRkuZghOnE+yDl6xKrPITUZtEwjN3t234R5qBV27GuTf++FqFxfTxoXLkFFO7c8ZGTa
    r4zbWKnKoh/cfq0ohVgUGuKBpRc9H9Zu2cbRkoghw6OPqFKR7OMp/B6kRhPF6m4OKW+W
    //YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1718616755;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=RWZpY9Ff37fXZ163qnZmAOtrov4UD1MxpbaXd1DYHQI=;
    b=RimgMhKi4rqOtC1ABTE4HrUt+BF0xlWKsfQjchV7S71QB2KZIU9rJKQVhUd4qj1ssx
    003Xl6Fy5dA3A+GVChJUC/GTxrytMOnyPO3drzZ1qokfeu28yUdSg/Gq6C69bcHS8RNe
    68KZW/iKN8rD87m55k1wJWeTcghULiq5YgRlKf+497ZaU6j3HMDKb/kCHlLTTya+8ai8
    piPwJNazC92p33YVzdRBHQsmTx7JsQGVcdK8APGwckDfHcx3aJDmmbNU37aR02yo8FvS
    Zx1+i/9I7oni89CSnHHclZa6tGZU20A+A6u1DIjBeRH27oiDBRPp1cO4DYgbLBlWaFw0
    rB8A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1718616755;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=RWZpY9Ff37fXZ163qnZmAOtrov4UD1MxpbaXd1DYHQI=;
    b=Pv3dmR8dlblrsAV31qtMXmk8e6Z9OTbaPASbhM4P7Wl1qEkY3rbbDOM/mSGynuK6ba
    3q8Ixdp9AeaWZi09lo65m71t4MlzdsKnlx46ykgifXFQHODZxdJX3hqvstHjF8CY5m4K
    YdAQVD2IQuGC9a5xirbwvSSvc95siDi+aogqTldu5io7WqxA72lPsRNSpKFm+glyb6ro
    osMHVIHHwayQtNhpSpZJhA9gN5x0xMbQ/4deJ83AoZbadL9UDI1cIqs1yPvXjjh3I7Nz
    9Crc04BNvIoL7cgwN4gJdN51FN3d6EQa48hJbywKUDnpXs3dLN1ciOxch8vK+VxsaPAz
    uUNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1718616755;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=RWZpY9Ff37fXZ163qnZmAOtrov4UD1MxpbaXd1DYHQI=;
    b=mzlW43uYCvE0FQJl9at1Q0xI1wLxlFLxTnUTml84HHVlzRChix1zI5p9l9wcwzfZwD
    4PYILnj4UuhHVJvxzHAg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7sKNcZuec1/lEjXyi1DCFOscFCe8bGtzH2tsY51y9cL"
Received: from ox-live-app204.back.ox.d0m.de
    by smtp-ox.front (RZmta 50.5.0 AUTH)
    with ESMTPSA id z07fa705H9WYcwD
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 17 Jun 2024 11:32:34 +0200 (CEST)
Date: Mon, 17 Jun 2024 11:32:34 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1298562246.263897.1718616754337@webmail.strato.com>
Subject: [ANNOUNCE] Release v4.4.302-cip88
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev65
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Jun 2024 09:32:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16258

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip88. The linux-4.4.y-cip tree's base version has been updated to v4.4-st53. The trees are up-to-date with kernel 4.19.316, up to and including commit "x86/insn: Fix PUSH instruction in x86 instruction decoder opcode map". The remaining commits from 4.19.316 will be considered for the next release in order to avoid further delays.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip88:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      bffa4a10103910f87f99a27cf26a0ac17a612b58
    Fixed CVEs:
      CVE-2024-26923: af_unix: Fix garbage collector racing against connect()
      CVE-2024-27399: Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_timeout
      CVE-2024-27401: firewire: nosy: ensure user_length is taken into account when fetching packet contents
      CVE-2024-35947: dyndbg: fix old BUG_ON in >control parser
      CVE-2024-36016: tty: n_gsm: fix possible out-of-bounds in gsm0_receive()
      CVE-2024-36886: tipc: fix UAF in error path
      CVE-2024-36902: ipv6: fib6_rules: avoid possible NULL dereference in fib6_rule_action()
      CVE-2024-36919: scsi: bnx2fc: Remove spin_lock_bh while releasing resources after upload
      CVE-2024-36934: bna: ensure the copied buf is NUL terminated
      CVE-2024-36941: wifi: nl80211: don't free NULL coalescing rule
      CVE-2024-36946: phonet: fix rtm_phonet_notify() skb allocation
      CVE-2024-36950: firewire: ohci: mask bus reset interrupts between ISR and bottom half
      CVE-2024-36954: tipc: fix a possible memleak in tipc_buf_append
      CVE-2024-36960: drm/vmwgfx: Fix invalid reads in fence signaled events
      CVE-2024-36964: fs/9p: only translate RWX permissions for plain 9P2000

Best regards,
Ulrich Hecht

