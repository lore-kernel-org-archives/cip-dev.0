Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B68DC677C4
	for <webhook@archiver.kernel.org>; Wed, 11 Jun 2025 09:52:47 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
 by mx.groups.io with SMTP id smtpd.web11.3695.1749635560961793902
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Jun 2025 02:52:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=qlD1Mvk5;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=XCVtdYme;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.220, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1749635539; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nKwjSQi/HRuOXI/5rnX8TaD7uRunmlz9Au2j1ARrg08ZHHhYSr0rm7NpZbMfk2ABBi
    D8sJaXj6wHYb81YhotJy3CYZ7qKQbLR0TCgepa1BSXE9wzJcafF/p25nBvQaHojM7MLK
    YB+xO1ZOy7o+5UM1Bv+3PnGZzdfONWc4oPrOsSVPK9Iagmq2o4NibaLPQ+B37Ab0Ole7
    Jvtl61wzPyynzgMj+3Zr3kylGj2YP2yFKXCuA4VznkVs+fdwN9vA8aTrKd0AELCr9oho
    e5aTgA3+botsyOXbxhq3uTaXKhPlL3fjuAl1PlINlNpBoLqEt33J9g1O+7CLUPwiqwMv
    ZcsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1749635539;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=wlPDlI6xKTgWK8Bb5BXnuDSSF0/nK4YZahErdWRG+js=;
    b=QhXDmSm+FiM5FsZtntWs4y9DOOqN5D2/Ok5IKWPSbvcJWAmiWM6Tx1Btcrq5aipWEF
    BpQ5vNCqTf2Gz13Hcbt5PecKKNkJQdZWEMajAScilcIjEctusLt852mhZmlHU12Qt7Pt
    zpOWaa9jz3KNEMEeFHyVBvgFHBCCxfecu3hvfB80Do3LBTdwpSPjp/Z00LOl17zyTgk6
    WC1jz1HYss8FUL48jPdEvaZQXWcwgzMj/mWJFTCwo5fIQv1B5AIjeWNRB9ZUAq4CSQk5
    lRuy5dpMutITzlpsFeY9phwIhRULYq9oQ3fSGANMc/TMai8W++3Ak7z4AgwQBc4rgPZi
    3aLw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1749635539;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=wlPDlI6xKTgWK8Bb5BXnuDSSF0/nK4YZahErdWRG+js=;
    b=qlD1Mvk5ksvt34NiATwhOiumaRp/nW+epCXdY5I/AcHX5q0kpk86+T2EEI1gX9nxYW
    oqt1hR7d/S5P8mUx1k9rK8e9bt57hdFGt65asj1yqO20P6fDxiMWmpcTMfsYeYy3czx7
    TqByb2r2WosLoYF44Sr5D88oqn3mIIN8+FM+svQ1vhdsjKxLTY2R7FqSLfOUri0ugvxu
    t5X2gTMlojR1J9qjtjlVolAzV18Lg8mT7F9inU1Uz+FXAo4+RV/5vGl0aQ7J0yaIhp1F
    X5UUjagVWbbm8KSf8cAWNkbpKVxp58sjXk+zPF7r3Ceg+dnbM5mkkkbXYEiUho1DsxVD
    nuaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1749635539;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=wlPDlI6xKTgWK8Bb5BXnuDSSF0/nK4YZahErdWRG+js=;
    b=XCVtdYmeA5BKf+Pe6yikww4Cl44Y+lUZrRX6RHCploObfxMHBAhG+Be2hSzSejCNuc
    yFZkgpBmEb3WjPDozUCA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6fd76vq"
Received: from open-xchange-core-mw-gw-36.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a34015B9qI3PC
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 11 Jun 2025 11:52:18 +0200 (CEST)
Date: Wed, 11 Jun 2025 11:52:18 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <890123726.143312.1749635538410@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.19.325-cip121
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.36.53
X-Originating-Port: 46928
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Jun 2025 09:52:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19025

Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip121. The linux-4.19.y-cip tree's base version has been updated to v4.19-st5. The trees are up-to-date with kernel 5.4.293.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/

  v4.19.325-cip121:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      3237eeb37d4b43b59ddbb9d45fcce28a18e43e68
    Fixed CVEs:
      CVE-2021-47352: virtio-net: Add validation for used length
      CVE-2024-50154: tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().
      CVE-2025-21681: openvswitch: fix lockup on tx to unregistering netdev with carrier
      CVE-2025-23140: misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
      CVE-2025-23142: sctp: detect and prevent references to a freed transport in sendmsg
      CVE-2025-23150: ext4: fix off-by-one error in do_split
      CVE-2025-23157: media: venus: hfi_parser: add check to avoid out of bound access
      CVE-2025-23158: media: venus: hfi: add check to handle incorrect queue size
      CVE-2025-23159: media: venus: hfi: add a check to handle OOB in sfr region
      CVE-2025-23163: net: vlan: don't propagate flags on open
      CVE-2025-37738: ext4: ignore xattrs past end
      CVE-2025-37740: jfs: add sanity check for agwidth in dbMount
      CVE-2025-37741: jfs: Prevent copying of nlink with value 0 from disk inode
      CVE-2025-37749: net: ppp: Add bound checking for skb data on ppp_sync_txmung
      CVE-2025-37757: tipc: fix memory leak in tipc_link_xmit
      CVE-2025-37758: ata: pata_pxa: Fix potential NULL pointer dereference in pxa_ata_probe()
      CVE-2025-37780: isofs: Prevent the use of too small fid
      CVE-2025-37781: i2c: cros-ec-tunnel: defer probe if parent EC is not present
      CVE-2025-37785: ext4: fix OOB read when checking dotdot dir
      CVE-2025-37789: net: openvswitch: fix nested key length validation in the set() action
      CVE-2025-37792: Bluetooth: btrtl: Prevent potential NULL dereference
      CVE-2025-37794: wifi: mac80211: Purge vif txq in ieee80211_do_stop()
      CVE-2025-37796: wifi: at76c50x: fix use after free access in at76_disconnect
      CVE-2025-37797: net_sched: hfsc: Fix a UAF vulnerability in class handling
      CVE-2025-37810: usb: dwc3: gadget: check that event count does not exceed event buffer length
      CVE-2025-37817: mcb: fix a double free bug in chameleon_parse_gdd()
      CVE-2025-37823: net_sched: hfsc: Fix a potential UAF in hfsc_dequeue() too
      CVE-2025-37824: tipc: fix NULL pointer dereference in tipc_mon_reinit_self()
      CVE-2025-37829: cpufreq: scpi: Fix null-ptr-deref in scpi_cpufreq_get_rate()
      CVE-2025-37838: HSI: ssi_protocol: Fix use after free vulnerability in ssi_protocol Driver Due to Race Condition
      CVE-2025-37839: jbd2: remove wrong sb->s_sequence check
      CVE-2025-37840: mtd: rawnand: brcmnand: fix PM resume warning
      CVE-2025-37841: pm: cpupower: bench: Prevent NULL dereference on malloc failure
      CVE-2025-37851: fbdev: omapfb: Add 'plane' value check
      CVE-2025-37857: scsi: st: Fix array overflow in st_setup()
      CVE-2025-37858: fs/jfs: Prevent integer overflow in AG size calculation
      CVE-2025-37862: HID: pidff: Fix null pointer dereference in pidff_find_fields
      CVE-2025-37881: usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()
      CVE-2025-37892: mtd: inftlcore: Add error check for inftl_read_oob()
      CVE-2025-37940: ftrace: Add cond_resched() to ftrace_graph_set_hash()
      CVE-2025-37982: wifi: wl1251: fix memory leak in wl1251_tx_work
      CVE-2025-37983: qibfs: fix _another_ leak
      CVE-2025-37989: net: phy: leds: fix memory leak

Best regards,
Ulrich Hecht

