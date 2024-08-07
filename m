Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375D1C3DA7F
	for <webhook@archiver.kernel.org>; Wed,  7 Aug 2024 12:03:19 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
 by mx.groups.io with SMTP id smtpd.web10.31652.1723032178010849145
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Aug 2024 05:02:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=jXGSn9ir;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=p3IyU1qs;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.22, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1723032160; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Qts59lgFskxalgw6oncDbGUXLgsoFaBkCXBsl60H6lStX8A3feRJPdOmswHFwdvNH3
    SoXJ093YRoI/uAcEJcOi7nnW+/9LMCgl+79chB6X33IFCR1h2JC6OHI09/kuJ2WHrrxy
    uPfkWCBfzcivtaG8tGCY9TTIbY0vCgHIMmXuHvlHa8egC+2HCGrgkNdAFa6sAvaMbkp/
    Nm+86KyzRx5VwmdfgBzO9m0vkYwDWaIFmJv3KPb4lFNtmOAnATn/M30T5YmzVPrsIalW
    c2Q96IlUwtapk9LvjkyTaKJFIf98VfOI/L4TB/00i+cw2D/VbsZeyhP9CHdvVmGp85AA
    Y3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1723032160;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=+3VJ/aXIQzdjzqwNuUnCpfr0Shi+4b0PtaTYxai9Zx0=;
    b=EdjjKfh8b33yc5TNIs+lgiwdX8eu74EvneO2pK6FtBJkOiqwXlemTe1pvcj+/rA/gO
    TFwCCCAUNmHQ9faXtiGtSLvhjXxaFzXbWPsWWAE2PZXK1dDSCwJQr1iNg63RjbwZAxXG
    Y3DJ+zENUP39KHVgrnjNGSgEqh2uvhjP1+4moMXcsN1feM5CdNs8LWvlegv3KA8TJpV6
    eoUkg7D3eek62EGxzdweDlvc6VDT4Tnt7iZk+231XfWY1sSXXu/9PeX7O+pScDAvweHn
    47br48AaGpGpGDWxdRscdT0D+UksQQcQzyW0wQlgC8RE/FwHU46GeW6D83gROaF1qjyf
    eHuA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1723032160;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=+3VJ/aXIQzdjzqwNuUnCpfr0Shi+4b0PtaTYxai9Zx0=;
    b=jXGSn9irARYyFydIAuc3cZzxv6T7Wcyw/vSoAlpiyr87fHJ4WiKyEK4RDbvNTm8Y9K
    Domf1qM5SY/8Brrqqw82DfOywEFmWtnd3WpZzpIgKERfPn8dKvDGvtdvMdIdyHMxzSOk
    tnRxHWYxlxFDiNl7r1RlNG2gPHMrr8aP7vuwCjIv4BJ07jY9Ad0qVs3PvwCQtz8TWaGk
    xwjQnFWhOmLOPq1M9TpSVCF+7t3LCwuD4jTH4fu9NGKkw3fQYPV9BqZpKF+e5eAbigoy
    NRGP4GdKKh+ieQorWJrsJfDkPH8XsB2U46BwUvlFKdTISuhiyjV+n/A5nQS7JEzMWSa5
    Mncg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1723032160;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=+3VJ/aXIQzdjzqwNuUnCpfr0Shi+4b0PtaTYxai9Zx0=;
    b=p3IyU1qsbHH+Mto+za0AtzCMH3QDkAr2tcIvrpSCnNQw8aPOvHRdtZa2YMxGfwGUfj
    C1C3GGDZjGvEBofZNSAg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7oKNYMuRfGHqdez7mZQjqCOMPS13Ww2eFsaIxefx6BY"
Received: from ox-live-app104.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.1.0 AUTH)
    with ESMTPSA id z5d8cb077C2e3vL
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Wed, 7 Aug 2024 14:02:40 +0200 (CEST)
Date: Wed, 7 Aug 2024 14:02:39 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1159690395.3858009.1723032159983@webmail.strato.com>
Subject: [ANNOUNCE] Release v4.4.302-cip90
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev67
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Aug 2024 12:03:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16756

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip90. The linux-4.4.y-cip tree's base version has been updated to v4.4-st55. The trees are up-to-date with kernel 4.19.319.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip90:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      1c0b45a5d75c157a5d6fddc34a587ff83d924b1f
    Fixed CVEs:
      CVE-2022-3566: tcp: Fix data races around icsk->icsk_af_ops.
      CVE-2022-3567: ipv6: Fix data races around sk->sk_prot.
      CVE-2024-36894: usb: gadget: f_fs: Fix race between aio_cancel() and AIO request complete
      CVE-2024-37078: nilfs2: fix potential kernel bug due to lack of writeback flag waiting
      CVE-2024-38619: usb-storage: alauda: Check whether the media is initialized
      CVE-2024-39469: nilfs2: fix nilfs_empty_dir() misjudgment and long loop on I/O errors
      CVE-2024-39499: vmci: prevent speculation leaks by sanitizing event in event_deliver()
      CVE-2024-39501: drivers: core: synchronize really_probe() and dev_uevent()
      CVE-2024-39509: HID: core: remove unnecessary WARN_ON() in implement()
      CVE-2024-40902: jfs: xattr: fix buffer overflow for invalid xattr
      CVE-2024-40904: USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages
      CVE-2024-40912: wifi: mac80211: Fix deadlock in ieee80211_sta_ps_deliver_wakeup()
      CVE-2024-40932: drm/exynos/vidi: fix memory leak in .get_modes()
      CVE-2024-40942: wifi: mac80211: mesh: Fix leak of mesh_preq_queue objects
      CVE-2024-40943: ocfs2: fix races between hole punching and AIO+DIO
      CVE-2024-40959: xfrm6: check ip6_dst_idev() return value in xfrm6_get_saddr()
      CVE-2024-40968: MIPS: Octeon: Add PCIe link status check
      CVE-2024-40974: powerpc/pseries: Enforce hcall result buffer validity and size
      CVE-2024-40981: batman-adv: bypass empty buckets in batadv_purge_orig_ref()
      CVE-2024-40984: ACPICA: Revert "ACPICA: avoid Info: mapping multiple BARs. Your kernel is fine."
      CVE-2024-40987: drm/amdgpu: fix UBSAN warning in kv_dpm.c
      CVE-2024-40988: drm/radeon: fix UBSAN warning in kv_dpm.c
      CVE-2024-41006: netrom: Fix a memory leak in nr_heartbeat_expiry()
      CVE-2024-41089: drm/nouveau/dispnv04: fix null pointer dereference in nv17_tv_get_hd_modes
      CVE-2024-41095: drm/nouveau/dispnv04: fix null pointer dereference in nv17_tv_get_ld_modes
      CVE-2024-41097: usb: atm: cxacru: fix endpoint checking in cxacru_bind()
      CVE-2024-42070: netfilter: nf_tables: fully validate NFT_DATA_VALUE on store to data registers
      CVE-2024-42084: ftruncate: pass a signed offset
      CVE-2024-42089: ASoC: fsl-asoc-card: set priv->pdev before using it
      CVE-2024-42090: pinctrl: fix deadlock in create_pinctrl() when handling -EPROBE_DEFER
      CVE-2024-42096: x86: stop playing stack games in profile_pc()
      CVE-2024-42097: ALSA: emux: improve patch ioctl data validation
      CVE-2023-52803: SUNRPC: Fix RPC client cleaned up the freed pipefs dentries
      CVE-2024-39487: bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()
      CVE-2024-41035: USB: core: Fix duplicate endpoint bug by clearing reserved bits in the descriptor
      CVE-2024-41044: ppp: reject claimed-as-LCP but actually malformed packets
      CVE-2024-41046: net: ethernet: lantiq_etop: fix double free in detach
      CVE-2024-42101: drm/nouveau: fix null pointer dereference in nouveau_connector_get_modes
      CVE-2024-42102: Revert "mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again"
      CVE-2024-42104: nilfs2: add missing check for inode numbers on directory entries
      CVE-2024-42105: nilfs2: fix inode number range checks
      CVE-2024-42106: inet_diag: Initialize pad field in struct inet_diag_req_v2
      CVE-2024-42115: jffs2: Fix potential illegal address access in jffs2_free_inode
      CVE-2024-42145: IB/core: Implement a limit on UMAD receive List
      CVE-2024-42148: bnx2x: Fix multiple UBSAN array-index-out-of-bounds
      CVE-2024-42153: i2c: pnx: Fix potential deadlock warning from del_timer_sync() call in isr
      CVE-2024-42154: tcp_metrics: validate source addr length
      CVE-2024-42223: media: dvb-frontends: tda10048: Fix integer overflow
      CVE-2024-26720: mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again
      CVE-2024-36484: net: relax socket state check at accept time.
      CVE-2024-41012: filelock: Remove locks reliably when fcntl/close race is detected
      CVE-2024-41015: ocfs2: add bounds checking to ocfs2_check_dir_entry()
      CVE-2024-41017: jfs: don't walk off the end of ealist
      CVE-2024-41020: filelock: Fix fcntl/close race recovery compat path
      CVE-2024-41059: hfsplus: fix uninit-value in copy_name
      CVE-2024-41063: Bluetooth: hci_core: cancel all works upon hci_unregister_dev()
      CVE-2024-41068: s390/sclp: Fix sclp_init() cleanup on failure
      CVE-2024-41072: wifi: cfg80211: wext: add extra SIOCSIWSCAN data check

Best regards,
Ulrich Hecht

