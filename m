Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E70C369CB
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 11:31:36 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
 by mx.groups.io with SMTP id smtpd.web11.6179.1745407887192713581
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Apr 2025 04:31:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=fycmDEyf;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=Sdwfo6rP;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.161, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1745407866; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=q0A+sr1xANsJseW6su2IYijXHMuBPe7nVYLOi3bYuvGm7CNQp2Bq6BH2/5OGEJeuV5
    /8v28s55II1Yff86JWKv+G5P1SSfJkO5McdmZNQRAyzHfT3g33p6O4t0I9MDs0/FUaip
    eGX9GTVgIVl4PJJCPO3LyWdZYYCdl/IrW7tGdAMpBh9Zncfz8g/GvpWJyvu+EfGCL/S5
    Ap+eu9LlD9RXHPxliKT6yCjUSYvNw/EtYPPG93nx4lnsem+1ru+Jl7qRRsJetaYv8452
    5ZKrGlp7kfyiaxnOh01s9hD+c3fg2SDXAde9h14WFF4bCCOMzaG1L62xbapvNfsWEGT0
    D3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1745407866;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=MTAphDsaL+LnA1OoNHfTYey7COBModvXWZblM6OG1bU=;
    b=cQ2kJg4XrFFsitq8Jgycyfb1BoIjA4t+GXR4I8rwEnUdPlmmxmUYiN3+oPQ96R4c2+
    ywRzvNdenV7aPgDDfz2MPtr+K+LwDOMqSlFKkFfb1kJ01illpMduqIao2MSsW09iG8BH
    hY0DSORTggoq6yJ4Vd31PrAoH5De0YdrXQf+klb8C5xb38iol1OF2ZIteexU/Apyfyr4
    pRkxrjPkA+e5yHCACOObWPllNT/XYONlBhnxw5VOFZLwqGhgNXXqnL8KVzpPGDlfz45Y
    LlfBZQPFOPkl1CNGLeLIMj4hW89uw+we6XSDaozL+op88rhTCObtkvmhmkul9hBisMkI
    HE1A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1745407866;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=MTAphDsaL+LnA1OoNHfTYey7COBModvXWZblM6OG1bU=;
    b=fycmDEyfKLZoFisCPMpl5EuhUf2qEs/nPAF/u5aZPRRDc0KIw4zM+XoiE1HJlcIKLr
    rQDj9JZTDaodDKLH0PsLf0CrhJRHjzJtiq6Go4AwYVoLBoXBKvBPCVd3CZWKKhFhbFX1
    NB+NdqsmXp1rxaglrSo+ChhoD8vij6c0owbswIJuNWsAGjdG8Az0nKiNooPfEiYEZsCp
    +U0AltXvUJ2Ed2l2SBmxxvjTAiL/WMocKmtpouIfHNKZAy2/kHlo1end9Fu45YSuDZMT
    Eg71Yl+HKHZY10CWf/iBXjX8zNNqvLfEcfri9caO1Nx74DE9khqHGVp4ZU2dFi+/RjZ5
    O4dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1745407866;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=MTAphDsaL+LnA1OoNHfTYey7COBModvXWZblM6OG1bU=;
    b=Sdwfo6rPeHzOGOPL9J2l5KeYcDKjDvLEMymZbPSuOdOBC4spxJj45Rnh31oqimBfsy
    LiefAn3hVf7FvAy//rDg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKfH+OC9FUs="
Received: from open-xchange-core-mw-gw-34.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a34013NBV6ATe
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 23 Apr 2025 13:31:06 +0200 (CEST)
Date: Wed, 23 Apr 2025 13:31:05 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1002260918.214761.1745407865966@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip98
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.33.60
X-Originating-Port: 57252
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Apr 2025 11:31:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18566

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip98. The linux-4.4.y-cip tree's base version has been updated to v4.4-st63. The trees are up-to-date with kernel 4.19-st3.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip98:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      284b07c3e0e9a3ec29d758ef062480647c7eae47
    Fixed CVEs:
      CVE-2024-26982: Squashfs: check the inode number is not the invalid value of zero
      CVE-2024-50055: driver core: bus: Fix double free in driver API bus_register()
      CVE-2024-57973: rdma/cxgb4: Prevent potential integer overflow on 32bit
      CVE-2024-57980: media: uvcvideo: Fix double free in error path
      CVE-2024-57981: usb: xhci: Fix NULL pointer dereference on certain command aborts
      CVE-2024-58001: ocfs2: handle a symlink read error correctly
      CVE-2024-58009: Bluetooth: L2CAP: handle NULL sock pointer in l2cap_sock_alloc
      CVE-2024-58014: wifi: brcmsmac: add gain range check to wlc_phy_iqcal_gainparams_nphy()
      CVE-2024-58017: printk: Fix signed integer overflow when defining LOG_BUF_LEN_MAX
      CVE-2024-58020: HID: multitouch: Add NULL check in mt_input_configured
      CVE-2024-58071: team: prevent adding a device which is already a team device lower
      CVE-2024-58090: sched/core: Prevent rescheduling when interrupts are disabled
      CVE-2025-21702: pfifo_tail_enqueue: Drop new packet when sch->limit == 0
      CVE-2025-21715: net: davicom: fix UAF in dm9000_drv_remove
      CVE-2025-21718: net: rose: fix timer races against user threads
      CVE-2025-21721: nilfs2: handle errors that nilfs_prepare_chunk() may return
      CVE-2025-21735: NFC: nci: Add bounds checking in nci_hci_create_pipe()
      CVE-2025-21736: nilfs2: fix possible int overflows in nilfs_fiemap()
      CVE-2025-21744: wifi: brcmfmac: fix NULL pointer dereference in brcmf_txfinalize()
      CVE-2025-21749: net: rose: lock the socket in rose_bind()
      CVE-2025-21753: btrfs: fix use-after-free when attempting to join an aborted transaction
      CVE-2025-21760: ndisc: extend RCU protection in ndisc_send_skb()
      CVE-2025-21762: arp: use RCU protection in arp_xmit()
      CVE-2025-21763: neighbour: use RCU protection in __neigh_notify()
      CVE-2025-21764: ndisc: use RCU protection in ndisc_alloc_skb()
      CVE-2025-21765: ipv6: use RCU protection in ip6_default_advmss()
      CVE-2025-21772: partitions: mac: fix handling of bogus partition table
      CVE-2025-21776: USB: hub: Ignore non-compliant devices with too many configs or interfaces
      CVE-2025-21785: arm64: cacheinfo: Avoid out-of-bounds write to cacheinfo array
      CVE-2025-21787: team: better TEAM_OPTION_TYPE_STRING validation
      CVE-2025-21811: nilfs2: protect access to buffers with no active references
      CVE-2025-21814: ptp: Ensure info->enable callback is always set
      CVE-2025-21835: usb: gadget: f_midi: fix MIDI Streaming descriptor lengths
      CVE-2025-21846: acct: perform last write from workqueue
      CVE-2025-21858: geneve: Fix use-after-free in geneve_find_dev().
      CVE-2025-21877: usbnet: gl620a: fix endpoint checking in genelink_bind()
      CVE-2025-21898: ftrace: Avoid potential division by zero in function_stat_show()
      CVE-2025-21904: caif_virtio: fix wrong pointer check in cfv_probe()
      CVE-2025-21909: wifi: nl80211: reject cooked mode if it is set along with other flags
      CVE-2025-21910: wifi: cfg80211: regulatory: improve invalid hints checking
      CVE-2025-21916: usb: atm: cxacru: fix a flaw in existing endpoint checks
      CVE-2025-21920: vlan: enforce underlying device type
      CVE-2025-21925: llc: do not use skb_get() before dev_queue_xmit()
      CVE-2025-21948: HID: appleir: Fix potential NULL dereference at raw event handle

Best regards,
Ulrich Hecht

