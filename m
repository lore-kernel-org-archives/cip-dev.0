Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6443C02198
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 02:12:16 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
 by mx.groups.io with SMTP id smtpd.web11.2514.1739239934176260848
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Feb 2025 18:12:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=i+jv7bNT;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=RVcup2Y+;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.219, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1739239912; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IP/eoUkH0VXttyL4foUKv1TO8u3Ny+xT5V2C0Ez8CZusxI/B2sY68zjV2ZapQ6AMzY
    r+lPurGXtSCFk2qdKG9Gqp9EP26rYylgn227ha7tcIJJJ5RTtfU/WP7wVOJu+69HC1RT
    lbDu9o+hszyjpixJTsk2jNEsLtXbv8YlGgjggF2Hfky1fliIDXY8EWxkJFcSlxHCBepJ
    CrxnKkJAYrV0rkIHKq7kJ018RGnEaVRN8p//wl5fNKr9g4fpTIJ6hQxlhSmRr6YYfMFr
    DyNTfh72WXgHl/nUKtyQIjqoRj7aJACRm4zEJz/+9GeFKy1zEsUQ7nu3ubP2FNGCZKbM
    mqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1739239912;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=mg9FrriZ70CqMoq3MnxXz0dnfKln+snAhZMU56l8+Pg=;
    b=Jrz9C0G4WV/X/3pA5WRRe1zatH4fiKWrqwZfaQkwI3G0uHrSIqq4cy3Dsia7KCQG2v
    d5LnHcwFQm5Ehi2lCO8ERbX6EYZ1c/NxXl4A/GUznbzIoTeUwPlq/IvEksYP2JKP8Uy0
    PN7T4PI6Juma9buKcYuKNax0eahLazPxAGf9B6XmzQBz49w3nj9ccrXtPyQwNGQC2YzN
    A4CFQL1K488WK0zyja31znGxIzR80eM36hzY7pFr/fr8dWyNMv9iC139g2SjKn7U0CYl
    F0xLKIb3di8VFJI5TaVpnUW9kgU+4OzxmZ0xta7Kt7G6Zl5eAL/WsNpoXq5VgHBTbvof
    byZw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1739239912;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=mg9FrriZ70CqMoq3MnxXz0dnfKln+snAhZMU56l8+Pg=;
    b=i+jv7bNTI+JQAYJsD0t6VXki3qQm3PCoCnuxCt4vEkKa09mOZIRj1/6/GZFZXpwF9n
    fwSnhopwhiIVW7SmrDe9ry33GX9/5zYg9PppnpWzTcSHJu3lgQFAm/Tb+1EwQa9+eYsy
    /F7EwOFU2HjOoQYdgI9h7FzcD2csldxCWDciYtGQcJUof7Jb4kHBzkQpIvuPTwc+1CRM
    laqzVt6RiX2kuqXNBisox78oj7CCnpmfU38JXDKbgSyt8xEOFnpXyMpjmfexhI0Ek/yY
    plrx74qG5Hz2jE4eoT+5HmRHYyFr6LsdaV6MLTXkWGqDU0azqJp4a600Pb0mCN6piaiP
    801g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1739239912;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=mg9FrriZ70CqMoq3MnxXz0dnfKln+snAhZMU56l8+Pg=;
    b=RVcup2Y+HfXfz7T2ZWGuYJIZ6x2z7crxUP9dHQHfKIzZSLV7EzC5u5iT9DeAyl8gaB
    qMZgaQC2xGPtJztUA/Dg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaR1GvSyJdw=="
Received: from ox-live-app205.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.23 AUTH)
    with ESMTPSA id z0a38411B2BqEQ7
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 11 Feb 2025 03:11:52 +0100 (CET)
Date: Tue, 11 Feb 2025 03:11:52 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1733593115.596079.1739239912119@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.19.325-cip117
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev73
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Feb 2025 02:12:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17800

Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip117. The linux-4.19.y-cip tree's base version has been updated to v4.19-st1. The trees are up-to-date with kernel 5.4.289. This is the first 4.19 release maintained exclusively by CIP.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/

  v4.19.325-cip117:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      2601508bd51c960b81522d6ab4f3f80dc9e4fcef
    Fixed CVEs:
      CVE-2024-48881: bcache: revert replacing IS_ERR_OR_NULL with IS_ERR again
      CVE-2024-50051: spi: mpc52xx: Add cancel_work_sync before module remove
      CVE-2024-52332: igb: Fix potential invalid memory access in igb_init_module()
      CVE-2024-53150: ALSA: usb-audio: Fix out of bounds reads when finding clock sources
      CVE-2024-53164: net: sched: fix ordering of qlen adjustment
      CVE-2024-53198: xen: Fix the issue of resource not being properly released in xenbus_dev_probe()
      CVE-2024-53240: Backend can crash Linux netfront
      CVE-2024-53680: ipvs: fix UB due to uninitialized stack access in ip_vs_protocol_init()
      CVE-2024-53690: nilfs2: prevent use of deleted inode
      CVE-2024-55916: Drivers: hv: util: Avoid accessing a ringbuffer not initialized yet
      CVE-2024-56569: ftrace: Fix regression with module command in stack_trace_filter
      CVE-2024-56570: ovl: Filter invalid inodes with missing lookup function
      CVE-2024-56574: media: ts2020: fix null-ptr-deref in ts2020_probe()
      CVE-2024-56576: media: i2c: tc358743: Fix crash in the probe error path when using polling
      CVE-2024-56581: btrfs: ref-verify: fix use-after-free after invalid ref action
      CVE-2024-56587: leds: class: Protect brightness_show() with led_cdev->led_access mutex
      CVE-2024-56593: wifi: brcmfmac: Fix oops due to NULL pointer dereference in brcmf_sdiod_sglist_rw()
      CVE-2024-56595: jfs: add a check to prevent array-index-out-of-bounds in dbAdjTree
      CVE-2024-56596: jfs: fix array-index-out-of-bounds in jfs_readdir
      CVE-2024-56597: jfs: fix shift-out-of-bounds in dbSplit
      CVE-2024-56598: jfs: array-index-out-of-bounds fix in dtReadFirst
      CVE-2024-56600: net: inet6: do not leave a dangling sk pointer in inet6_create()
      CVE-2024-56601: net: inet: do not leave a dangling sk pointer in inet_create()
      CVE-2024-56602: net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
      CVE-2024-56603: net: af_can: do not leave a dangling sk pointer in can_create()
      CVE-2024-56605: Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
      CVE-2024-56606: af_packet: avoid erroring out after sock_init_data() in packet_create()
      CVE-2024-56619: nilfs2: fix potential out-of-bounds memory access in nilfs_find_entry()
      CVE-2024-56629: HID: wacom: fix when get product name maybe null pointer
      CVE-2024-56630: ocfs2: free inode when ocfs2_get_init_inode() fails
      CVE-2024-56634: gpio: grgpio: Add NULL check in grgpio_probe
      CVE-2024-56637: netfilter: ipset: Hold module reference while requesting a module
      CVE-2024-56643: dccp: Fix memory leak in dccp_feat_change_recv
      CVE-2024-56644: net/ipv6: release expired exception dst cached in socket
      CVE-2024-56650: netfilter: x_tables: fix LED ID check in led_tg_check()
      CVE-2024-56659: net: lapb: increase LAPB_HEADER_LEN
      CVE-2024-56670: usb: gadget: u_serial: Fix the issue that gs_start_io crashed due to accessing null pointer
      CVE-2024-56691: mfd: intel_soc_pmic_bxtwc: Use IRQ domain for USB Type-C device
      CVE-2024-56723: mfd: intel_soc_pmic_bxtwc: Use IRQ domain for PMIC devices
      CVE-2024-56724: mfd: intel_soc_pmic_bxtwc: Use IRQ domain for TMU device
      CVE-2024-56748: scsi: qedf: Fix a possible memory leak in qedf_alloc_and_init_sb()
      CVE-2024-56766: mtd: rawnand: fix double free in atmel_pmecc_create_user()
      CVE-2024-56767: dmaengine: at_xdmac: avoid null_prt_deref in at_xdmac_prep_dma_memset
      CVE-2024-56769: media: dvb-frontends: dib3000mb: fix uninit-value in dib3000_write_reg
      CVE-2024-56770: net/sched: netem: account for backlog updates from child qdisc
      CVE-2024-56779: nfsd: fix nfs4_openowner leak when concurrent nfsd4_open occur
      CVE-2024-56780: quota: flush quota_release_work upon quota writeback
      CVE-2024-56781: powerpc/prom_init: Fixup missing powermac #size-cells
      CVE-2024-57802: netrom: check buffer length before accessing it
      CVE-2024-57849: s390/cpum_sf: Handle CPU hotplug remove during sampling
      CVE-2024-57850: jffs2: Prevent rtime decompress memory corruption
      CVE-2024-57884: mm: vmscan: account for free pages to prevent infinite Loop in throttle_direct_reclaim()
      CVE-2024-57889: pinctrl: mcp23s08: Fix sleeping in atomic context due to regmap locking
      CVE-2024-57900: ila: serialize calls to nf_register_net_hooks()
      CVE-2024-57901: af_packet: fix vlan_get_protocol_dgram() vs MSG_PEEK
      CVE-2024-57902: af_packet: fix vlan_get_tci() vs MSG_PEEK
      CVE-2024-57931: selinux: ignore unknown extended permissions
      CVE-2024-57938: net/sctp: Prevent autoclose integer overflow in sctp_association_init()
      CVE-2024-57946: virtio-blk: don't keep queue frozen during system suspend

Best regards,
Ulrich Hecht

