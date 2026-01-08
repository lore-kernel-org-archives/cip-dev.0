Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0698D14897
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 03:00:30 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23701.1767841228522213262
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 19:00:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=QR6eN0v+;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=x6pwfFt1;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.50, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1767841201; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Qh2yxpo/s62uJXRmikXf8tVRl1MWcguoqHD4WIc+CtXrLP6Y1uPA0p4JTwTPJPg1OM
    mWR+uhogMQvamK+Or25V2S9dYLsQ2sciPGNu+gn91C9XclJmHe2icaAIoKI/vNLLrTDY
    Gosh3N8q35yVnTms7ZfcAbi61wzHo6rgHc2H3ftm8uN0Tw+gKvezsrLS7Q2yVCsryAHR
    fPRgXESEYpzrrzVvb+MuQzjHRX+oG5JFMqBA8dTarY51ln+7VyNEDOWWCBTTMuGH46vs
    Alz+fmUNuE00DcGl04Awzp//2ef9wTMQ0CWT+taZINuPct8/KcaAjZ/55Ccg6MZpY5ox
    s2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767841201;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=y9vTEe4s67NI04p9P1kvigvlQy21oa+HIEMJjvBpAWk=;
    b=EHXbnCqLLMusvMlxs6Vuj7qR6wg+VV0RkdW8v4IWCSCJiyu+1ZtUx/G8QEVhaI9d/2
    XY7ipZxrk6lx6GMIv4ww5TqsMlCFD+VQgo/s6ii4JS2oPaRTKeYCcdjlVuKM0NJETKgK
    dCEphs+DhdUWwiNqkWiM1A+jv6/JLz3ZwU7QX/Tfum6KL4Vz5Oe+l1YBu78VvaEpqizC
    N+yw0mbiif1YwsdVImxWqbTHbqCI6/dli8kx3QHpbw3dpEhAHnvH1hx6N7hduHVZ4cn6
    V0WHrt8zXmS5F27tAbt0ki5ItpUva8Q+GN2VsWyzivhn9Qua1sJTnE1LZR8891Poo/hi
    YYvA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767841201;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=y9vTEe4s67NI04p9P1kvigvlQy21oa+HIEMJjvBpAWk=;
    b=QR6eN0v+3u0dYf88Ci1IhuASnZl5tqhPyWiPKUy6fkxQp1TWSwlwT5Jh9ZTA9qTRUd
    2cCzVIbIDW/F+IUu7BtaWIKNmPCjlySfvnzk3Jzr2qeU+glFFup/cgOEYbWY5fOtYz/i
    jLK79MK62wgHxB6KdxPdce1vMMrVdIV8qmExXIObT6HDZ+pS0TjgYFcq8hoqCxmN4Hja
    59bVnVBWgOEFET/A+Mk9Az0FLDA71pPL73RvsBSlPTO7wrHn5RHxnLd6QFWwe89DQQg5
    Y3jr9fqmNFAl1ybvB8YXEwWLQGYl+j9aUP/vL5/9XicYw3GC9Bh2/0MV9N871yHtfxbN
    Eczw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767841201;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=y9vTEe4s67NI04p9P1kvigvlQy21oa+HIEMJjvBpAWk=;
    b=x6pwfFt13XzKsyp0aypNvy36wHYdzZMCXn7ZmcmNsJXQ/0BCopMlopYTn6gAHhMMO/
    SXjggXB05xZQPzuBcNDg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGvRy6JA=="
Received: from open-xchange-core-mw-gw-33.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 54.1.0 AUTH)
    with ESMTPSA id zfda17208301VkU
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 8 Jan 2026 04:00:01 +0100 (CET)
Date: Thu, 8 Jan 2026 04:00:00 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <2103148841.426261.1767841200981@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.19.325-cip127
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 46776
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 03:00:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21431

Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip127. The linux-4.19.y-cip tree's base version has been updated to v4.19-st11. The trees are up-to-date with kernel 5.4.302 and include relevant patches from 5.10.247.
This is the last release based on the 5.4 LTS patch stream; future releases will be based on 5.10 LTS.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/

  v4.19.325-cip127:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      6b680c057fd57fa9a38b4a9e76f7196f7159b4c4
    Fixed CVEs:
      CVE-2024-47666: scsi: pm80xx: Set phy->enable_completion only when we wait for it
      CVE-2025-21887: ovl: fix UAF in ovl_dentry_update_reval by moving dput() in ovl_link_up
      CVE-2025-39866: fs: writeback: fix use-after-free in __mark_inode_dirty()
      CVE-2025-40040: mm/ksm: fix flag-dropping behavior in ksm_madvise
      CVE-2025-40083: net/sched: sch_qfq: Fix null-deref in agg_dequeue
      CVE-2025-40211: ACPI: video: Fix use-after-free in acpi_video_switch_brightness()
      CVE-2025-40248: vsock: Ignore signal/timeout on connect() if already established
      CVE-2025-40253: s390/ctcm: Fix double-kfree
      CVE-2025-40254: net: openvswitch: remove never-working support for setting nsh fields
      CVE-2025-40259: scsi: sg: Do not sleep in atomic context
      CVE-2025-40263: Input: cros_ec_keyb - fix an invalid memory access
      CVE-2025-40264: be2net: pass wrb_params in case of OS2BMC
      CVE-2025-40271: fs/proc: fix uaf in proc_readdir_de()
      CVE-2025-40275: ALSA: usb-audio: Fix NULL pointer dereference in snd_usb_mixer_controls_badd
      CVE-2025-40278: net: sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak
      CVE-2025-40280: tipc: Fix use-after-free in tipc_mon_reinit_self().
      CVE-2025-40281: sctp: prevent possible shift-out-of-bounds in sctp_transport_update_rto
      CVE-2025-40282: Bluetooth: 6lowpan: reset link-local header on ipv6 recv path
      CVE-2025-40283: Bluetooth: btusb: reorder cleanup in btusb_disconnect to avoid UAF
      CVE-2025-40304: fbdev: Add bounds checking in bit_putcs to fix vmalloc-out-of-bounds
      CVE-2025-40308: Bluetooth: bcsp: receive data only if registered
      CVE-2025-40309: Bluetooth: SCO: Fix UAF on sco_conn_free
      CVE-2025-40312: jfs: Verify inode mode when loading from disk
      CVE-2025-40315: usb: gadget: f_fs: Fix epfile null pointer access after ep enable.
      CVE-2025-40317: regmap: slimbus: fix bus_context pointer in regmap init calls
      CVE-2025-40321: wifi: brcmfmac: fix crash while sending Action Frames in standalone AP Mode
      CVE-2025-40322: fbdev: bitblit: bound-check glyph index in bit_putcs*
      CVE-2025-40331: sctp: Prevent TOCTOU out-of-bounds write
      CVE-2025-40342: nvme-fc: use lock accessing port_state and rport state
      CVE-2025-40345: usb: storage: sddr55: Reject out-of-bound new_pba
      CVE-2025-40363: net: ipv6: fix field-spanning memcpy warning in AH output
      CVE-2025-68168: jfs: fix uninitialized waitqueue in transaction manager
      CVE-2025-68177: cpufreq/longhaul: handle NULL policy in longhaul_exit
      CVE-2025-68185: nfs4_setup_readdir(): insufficient locking for ->d_parent->d_inode dereferencing
      CVE-2025-68192: net: usb: qmi_wwan: initialize MAC header offset in qmimux_rx_fixup
      CVE-2025-68194: media: imon: make send_packet() more robust
      CVE-2025-68204: pmdomain: arm: scmi: Fix genpd leak on provider registration failure
      CVE-2025-68217: Input: pegasus-notetaker - fix potential out-of-bounds access
      CVE-2025-68220: net: ethernet: ti: netcp: Standardize knav_dma_open_channel to return NULL on error
      CVE-2025-68229: scsi: target: tcm_loop: Fix segfault in tcm_loop_tpg_address_show()
      CVE-2025-68241: ipv4: route: Prevent rt_bind_exception() from rebinding stale fnhe
      CVE-2025-68245: net: netpoll: fix incorrect refcount handling causing incorrect cleanup
      CVE-2025-68285: libceph: fix potential use-after-free in have_mon_and_osd_map()
      CVE-2025-68286: drm/amd/display: Check NULL before accessing
      CVE-2025-68288: usb: storage: Fix memory leak in USB bulk transport
      CVE-2025-68289: usb: gadget: f_eem: Fix memory leak in eem_unwrap
      CVE-2025-68302: net: sxgbe: fix potential NULL dereference in sxgbe_rx()
      CVE-2025-68308: can: kvaser_usb: leaf: Fix potential infinite loop in command parsers
      CVE-2025-68312: usbnet: Prevents free active kevent
      CVE-2025-68331: usb: uas: fix urb unmapping issue when the uas device is remove during ongoing data transfer
      CVE-2025-68339: atm/fore200e: Fix possible data race in fore200e_open()
      CVE-2025-68734: isdn: mISDN: hfcsusb: fix memory leak in hfcsusb_probe()

Best regards,
Ulrich Hecht

