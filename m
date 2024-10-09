Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88953CEF151
	for <webhook@archiver.kernel.org>; Wed,  9 Oct 2024 09:37:29 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
 by mx.groups.io with SMTP id smtpd.web10.12207.1728466646542978073
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Oct 2024 02:37:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=s8KEm1ig;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=4imFnuGu;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.52, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1728466626; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WrJGeC34g9rdD8P9O8cA2nBWuetaSSDeOZ/Vs4e3vzcmWN/Xwdq1V0ZPZcaz/YIUHa
    sbxBcIQ/1QIp3nnshzbsyNnCgWUXG3y/q2Y1Mvu62yQ5B5FXPf0iLJ+w/CBDMrfBoghd
    DnmmOfAQSAg+Xibe+rQ0/LMyOmotUlcuHP0udsz3mZ8oXHcCaLf7G+V/tcKCWsAUqNDH
    Z3Eow+NGJcP4NNnSYzRbnHTGF/kYSbw9fBJybD0NG5VjfGtU2/Eso0G9JfBkVRmR70Ec
    6QQVtde/FoezJN2Yl2iUlIjywmPrl/7WT/YXeIWafv8fqOm6vr6WjP3IUJ5TDAxfP/4C
    Rg/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1728466626;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Hx1F4kUUTGlJKgCng8OFT74fOciC3ahw7Zmehpu8K8Q=;
    b=hT/9XvnMvDZu//OqGJOQAv7Ot6Nly4TG9KDFyakKOqIjTwMk2B6lvHL9BAGYvy3cFu
    GtxqnTRZ+r5ld1yxEz9H9iBe5e07BzFePYjbjSOoS3O8aGl5sUxEgdwV3sub2Uea1KKH
    W4Y4vdaBZE64UrPLFjKQQyhzTk9+xswrXwRQ3d4x6wseEY3PURFHDe+c+w1zwHpCexf1
    g5SPyINqBrj0yAcuWRq70lV9iCt9Qm8TAIwO2VZ5ZXpzKTvDavxzpy6SYxCBR0xfEaHB
    BeG/YOY6Z31389qcfEHYVfVdEQljXIeoN3M8k3fbloh4Di4ue3uM5ipC+CeNl4KXO56w
    tA4g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1728466626;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Hx1F4kUUTGlJKgCng8OFT74fOciC3ahw7Zmehpu8K8Q=;
    b=s8KEm1igmHMCg+b1OgA8FXfUd7lDnKUEGwKy/y1vuwXS/R4zQAC4NW4mFuu10P9qD8
    F7Jr7qOprl/QiDGnwro9H3ZJQCK9p+nzruiw8JKYIthG6kz4hD9zVM9/ymqnr8qgD7h8
    d0+JVD2ilsIO3EQO5ob/+0G78xkTw4cSWdTzmgeabQ5U7tpJNIe0uF7yZNt9f6e8fhGs
    FD94OYJnct5Fxviqs5Jg4HpbIzqPKWIg3qysiAkiLXyiooUjvtoNQ+9P/vlW8PGkxXg8
    MZlxzCyfqW+K4uRni1xhVAfD2mmy2WwpobbEfk1BaJ1nnuTeVzzSpLo6EvqsRt20OsC8
    6g2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1728466626;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Hx1F4kUUTGlJKgCng8OFT74fOciC3ahw7Zmehpu8K8Q=;
    b=4imFnuGuB8UGWAjwXFVsxqVJX4TkNAFh6N1lorUnOpj1xN2rovTvPgmyNy8vzhamhz
    MbS9gvOz3ZOYE5ELKvBA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaR1GvSyJdw=="
Received: from ox-live-app303.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0d2fd0999b55IL
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Wed, 9 Oct 2024 11:37:05 +0200 (CEST)
Date: Wed, 9 Oct 2024 11:37:05 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <277614385.3214684.1728466625718@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip92
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev68
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Oct 2024 09:37:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17019

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip92. The linux-4.4.y-cip tree's base version has been updated to v4.4-st57. The trees are up-to-date with kernel 4.19.322.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip92:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      da1013db74d9050b1b2af15209d6153ab85eb718
    Fixed CVEs:
      CVE-2021-33655: When sending malicous data to kernel by ioctl cmd FBIOPUT_VSCREENINFO,kernel will write memory out of bounds.
      CVE-2023-31083: BUG: general protection fault in hci_uart_tty_ioctl
      CVE-2024-42246: net, sunrpc: Remap EPERM in case of connection failure in xs_tcp_setup_socket
      CVE-2024-43854: block: initialize integrity buffer to zero before writing it to media
      CVE-2024-43884: Bluetooth: MGMT: Add error handling to pair_device()
      CVE-2024-44947: fuse: Initialize beyond-EOF page contents before setting uptodate
      CVE-2024-44987: ipv6: prevent UAF in ip6_send_skb()
      CVE-2024-44998: atm: idt77252: prevent use after free in dequeue_rx()
      CVE-2024-45008: Input: MT - limit max slots
      CVE-2024-45021: memcg_write_event_control(): fix a user-triggerable oops
      CVE-2024-45028: mmc: mmc_test: Fix NULL dereference on allocation failure
      CVE-2024-46673: scsi: aacraid: Fix double-free on probe failure
      CVE-2024-46674: usb: dwc3: st: fix probed platform device ref count on probe error path
      CVE-2024-46721: apparmor: fix possible NULL pointer dereference
      CVE-2024-46723: drm/amdgpu: fix ucode out-of-bounds read warning
      CVE-2024-46738: VMCI: Fix use-after-free when removing resource in vmci_resource_remove()
      CVE-2024-46743: of/irq: Prevent device address out-of-bounds read in interrupt map walk
      CVE-2024-46744: Squashfs: sanity check symbolic link size
      CVE-2024-46750: PCI: Add missing bridge lock to pci_bus_lock()
      CVE-2024-46755: wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id()
      CVE-2024-46756: hwmon: (w83627ehf) Fix underflows seen when writing limit attributes
      CVE-2024-46757: hwmon: (nct6775-core) Fix underflows seen when writing limit attributes
      CVE-2024-46758: hwmon: (lm95234) Fix underflows seen when writing limit attributes
      CVE-2024-46759: hwmon: (adc128d818) Fix underflows seen when writing limit attributes
      CVE-2024-46777: udf: Avoid excessive partition lengths
      CVE-2024-46780: nilfs2: protect references to superblock parameters exposed in sysfs
      CVE-2024-46781: nilfs2: fix missing cleanup on rollforward recovery error
      CVE-2024-46800: sch/netem: fix use after free in netem_dequeue
      CVE-2024-42228: drm/amdgpu: Using uninitialized value *size when calling amdgpu_vce_cs_reloc
      CVE-2024-46722: drm/amdgpu: fix mc_data out-of-bounds read warning
      CVE-2024-46829: rtmutex: Drop rt_mutex::wait_lock before scheduling
      CVE-2024-46840: btrfs: clean up our handling of refs == 0 in snapshot delete
      CVE-2024-46844: um: line: always fill *error_out in setup_one_line()

Best regards,
Ulrich Hecht

