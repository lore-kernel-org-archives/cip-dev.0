Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0D1CAC5A8
	for <webhook@archiver.kernel.org>; Mon, 22 Sep 2025 14:44:40 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
 by mx.groups.io with SMTP id smtpd.web10.53834.1758552273794405482
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Sep 2025 07:44:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=qJnmE1nM;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.218, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1758552254; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FdIq6+0iuPMMx3sMjFnNnPqd56PuI+EE5Pntyduko/2OodhUFJb/exstpKHGqPKABq
    Wbc2UQQ/oqhO+/nzv17qJ7QmOxfoxL9Hu5S1ip3IcHtzTjK/ACPnFO099hX/2RaMRAqZ
    44Qq/yAgsvGY5C/ElG2yXlQlaF2YL2Tw3zmQKAzUQv+HfpAhRBVRbimI0O8ouCyOrnYl
    R+TfQPyG5kqf+ocYZswQwVJW5iOuU1NJLt4MkQcjnr2X6w3zHOuJRXKBF/tOIZD0C2R2
    T+wAbRwwf5tsq8n9fSHqBJ/7Bt8797pnXKlHNTI/2zSvi1PrrfHTtmF2kQSAYkhyLq+g
    3t+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1758552254;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=ITXw8ddd5hLF+kkfbHFJSQKwYTwT8qsr5E/JQ12Aimc=;
    b=jWRI2t/nY19gt0QRplOPSxzq7Fln8v9qNK0MCFCa7LjJnxLud7e8nLAyogENi1GHr1
    KfKErMFULkfqRpaxl3pQ5jJecZXk8rurzD/7NaQe2wPG+6Tz/mudaNVeN4BVAx8ydSCE
    GpZDA5Hg4pjeM5ZVrRXVrL7fRPsXoenpPI+iQIuRSF+/vaMXY1Q0wQXiwix8cFClzC7t
    yq1L8hqVORUaRmEvMUGVIK4DDUZITgb9w3ZON4ltpMv2+MYTILhpMYk+Pu2t9fTPuwAo
    ZBmjIPLpj82KfFmdsu+5sTpZ2bsFJVXuMjIKQfysCeRlITGq33oVX+WWOXkQiHYOmYOt
    Ytgw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1758552254;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=ITXw8ddd5hLF+kkfbHFJSQKwYTwT8qsr5E/JQ12Aimc=;
    b=qJnmE1nMeh6mIMEt1TfS2VQMfxAWtKDdEH56+1VGf84R7H77g4PLvqiRHt/DXHrcNr
    O0f7sRepnNoU9g2GlebT06alu/AnezfWQ6X3yoHaJ6t8RHsRBPg0TyA5eBgck3qQd8NV
    OCLeW5FgWIAc2WKg8eezeHh3IzXkr/qxmgwgCNTiPgOlS2z1ZpOJf1D3bAxcto/zAEZz
    i6RT363p3qSgE1f6kZIKO0EjRGL0ptzwdFPkRN6zeod/VxAa1WhnJehjnqN0WeL9T7Qu
    tcYK/4gukiIFn0+0dFXFNthZySD5MdzoJXAzCgjP4MEtwyosyLyI8UZ4LSKL+NjrSe7e
    VUsw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKzK+A+UOEY="
Received: from open-xchange-core-mw-gw-30.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 52.1.2 AUTH)
    with ESMTPSA id z025ba18MEiDRnc
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 22 Sep 2025 16:44:13 +0200 (CEST)
Date: Mon, 22 Sep 2025 16:44:13 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <783054085.122881.1758552253280@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.19.325-cip124
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.83
X-Originating-Port: 45964
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Sep 2025 14:44:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20088

Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip124. The linux-4.19.y-cip tree's base version has been updated to v4.19-st8. The trees are up-to-date with kernel 5.4.298.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/

  v4.19.325-cip124:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      6ea7b609a0cdeea3232ae4b9f47472140c5beef2
    Fixed CVEs:
      CVE-2024-26958: nfs: fix UAF in direct writes
      CVE-2024-53237: Bluetooth: fix use-after-free in device_for_each_child()
      CVE-2025-21917: usb: renesas_usbhs: Flush the notify_hotplug_work
      CVE-2022-50327: ACPI: processor: idle: Check acpi_fetch_acpi_dev() return value
      CVE-2024-57996: net_sched: sch_sfq: don't allow 1 packet limit
      CVE-2025-37752: net_sched: sch_sfq: move the limit validation
      CVE-2025-37798: codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()
      CVE-2025-38177: sch_hfsc: make hfsc_qlen_notify() idempotent
      CVE-2025-38193: net_sched: sch_sfq: reject invalid perturb period
      CVE-2025-38347: f2fs: fix to do sanity check on ino and xnid
      CVE-2025-38375: virtio-net: ensure the received length does not exceed allocated size
      CVE-2025-38468: net/sched: Return NULL when htb_lookup_leaf encounters an empty rbtree
      CVE-2025-38470: net: vlan: fix VLAN 0 refcount imbalance of toggling filtering during runtime
      CVE-2025-38473: Bluetooth: Fix null-ptr-deref in l2cap_sock_resume_cb()
      CVE-2025-38474: usb: net: sierra: check for no status endpoint
      CVE-2025-38477: net/sched: sch_qfq: Fix race condition on qfq_aggregate
      CVE-2025-38480: comedi: Fix use of uninitialized data in insn_rw_emulate_bits()
      CVE-2025-38482: comedi: das6402: Fix bit shift out of bounds
      CVE-2025-38483: comedi: das16m1: Fix bit shift out of bounds
      CVE-2025-38487: soc: aspeed: lpc-snoop: Don't disable channels that aren't enabled
      CVE-2025-38494: HID: core: do not bypass hid_hw_raw_request
      CVE-2025-38495: HID: core: ensure the allocated report buffer can contain the reserved report ID
      CVE-2025-38497: usb: gadget: configfs: Fix OOB read on empty string write
      CVE-2025-38529: comedi: aio_iiro_16: Fix bit shift out of bounds
      CVE-2025-38530: comedi: pcl812: Fix bit shift out of bounds
      CVE-2025-38538: dmaengine: nbpfaxi: Fix memory corruption in probe()
      CVE-2025-38539: tracing: Add down_write(trace_event_sem) when adding trace event
      CVE-2025-38553: net/sched: Restrict conditions for adding duplicating netems to qdisc tree
      CVE-2025-38555: usb: gadget : fix use-after-free in composite_dev_cleanup()
      CVE-2025-38563: perf/core: Prevent VMA split of buffer mappings
      CVE-2025-38565: perf/core: Exit early on perf_mmap() fail
      CVE-2025-38569: benet: fix BUG when creating VFs
      CVE-2025-38572: ipv6: reject malicious packets in ipv6_gso_segment()
      CVE-2025-38574: pptp: ensure minimal skb length in pptp_xmit()
      CVE-2025-38577: f2fs: fix to avoid panic in f2fs_evict_inode
      CVE-2025-38578: f2fs: fix to avoid UAF in f2fs_sync_inode_meta()
      CVE-2025-38581: crypto: ccp - Fix crash when rebind ccp device for ccp.ko
      CVE-2025-38602: iwlwifi: Add missing check for alloc_ordered_workqueue
      CVE-2025-38604: wifi: rtl818x: Kill URBs before clearing tx status queue
      CVE-2025-38612: staging: fbtft: fix potential memory leak in fbtft_framebuffer_alloc()
      CVE-2025-38617: net/packet: fix a race in packet_set_ring() and packet_notifier()
      CVE-2025-38618: vsock: Do not allow binding to VMADDR_PORT_ANY
      CVE-2025-38630: fbdev: imxfb: Check fb_add_videomode to prevent null-ptr-deref
      CVE-2025-38635: clk: davinci: Add NULL check in davinci_lpsc_clk_register()
      CVE-2025-38639: netfilter: xt_nfacct: don't assume acct name is null-terminated
      CVE-2025-38650: hfsplus: remove mutex_lock check in hfsplus_free_extents
      CVE-2025-38652: f2fs: fix to avoid out-of-boundary access in devs.path
      CVE-2025-38663: nilfs2: reject invalid file types when reading inodes
      CVE-2025-38666: net: appletalk: Fix use-after-free in AARP proxy probe
      CVE-2025-38671: i2c: qup: jump out of the loop in case of timeout
      CVE-2025-38677: f2fs: fix to avoid out-of-boundary access in dnode page
      CVE-2025-38680: media: uvcvideo: Fix 1-byte out-of-bounds read in uvc_parse_format()
      CVE-2025-38691: pNFS: Fix uninited ptr deref in block/scsi layout
      CVE-2025-38693: media: dvb-frontends: w7090p: fix null-ptr-deref in w7090p_tuner_write_serpar and w7090p_tuner_read_serpar
      CVE-2025-38694: media: dvb-frontends: dib7090p: fix null-ptr-deref in dib7090p_rw_on_apb()
      CVE-2025-38696: MIPS: Don't crash in stack_top() for tasks without ABI or vDSO
      CVE-2025-38697: jfs: upper bound check of tree index in dbAllocAG
      CVE-2025-38698: jfs: Regular file corruption check
      CVE-2025-38699: scsi: bfa: Double-free fix
      CVE-2025-38700: scsi: libiscsi: Initialize iscsi_conn->dd_data only if memory is allocated
      CVE-2025-38701: ext4: do not BUG when INLINE_DATA_FL lacks system.data xattr
      CVE-2025-38708: drbd: add missing kref_get in handle_write_conflicts
      CVE-2025-38712: hfsplus: don't use BUG_ON() in hfsplus_create_attributes_file()
      CVE-2025-38713: hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
      CVE-2025-38714: hfsplus: fix slab-out-of-bounds in hfsplus_bnode_read()
      CVE-2025-38715: hfs: fix slab-out-of-bounds in hfs_bnode_read()
      CVE-2025-38718: sctp: linearize cloned gso packets in sctp_rcv
      CVE-2025-38721: netfilter: ctnetlink: fix refcount leak on table dump
      CVE-2025-38724: nfsd: handle get_client_locked() failure in nfsd4_setclientid_confirm()
      CVE-2025-38727: netlink: avoid infinite retry looping in netlink_unicast()
      CVE-2025-38729: ALSA: usb-audio: Validate UAC3 power domain descriptors, too
      CVE-2025-39676: scsi: qla4xxx: Prevent a potential error pointer dereference
      CVE-2025-39689: ftrace: Also allocate and copy hash for reading of filter files
      CVE-2025-39691: fs/buffer: fix use-after-free when call bh_read() helper
      CVE-2025-39709: media: venus: protect against spurious interrupts during probe
      CVE-2025-39710: media: venus: Add a check for packet size after reading from shared memory
      CVE-2025-39713: media: rainshadow-cec: fix TOCTOU race condition in rain_interrupt()
      CVE-2025-39714: media: usbtv: Lock resolution while streaming
      CVE-2025-39724: serial: 8250: fix panic due to PSLVERR
      CVE-2025-39730: NFS: Fix filehandle bounds checking in nfs_fh_to_dentry()
      CVE-2025-39742: RDMA: hfi1: fix possible divide-by-zero in find_hw_thread_mask()
      CVE-2025-39743: jfs: truncate good inode pages when hard link is 0
      CVE-2025-39751: ALSA: hda/ca0132: Fix buffer overflow in add_tuning_control
      CVE-2025-39756: fs: Prevent file descriptor table allocations exceeding INT_MAX
      CVE-2025-39757: ALSA: usb-audio: Validate UAC3 cluster segment descriptors
      CVE-2025-39766: net/sched: Make cake_enqueue return NET_XMIT_CN when past buffer_limit
      CVE-2025-39782: jbd2: prevent softlockup in jbd2_log_do_checkpoint()
      CVE-2025-39783: PCI: endpoint: Fix configfs group list head handling
      CVE-2025-39794: ARM: tegra: Use I/O memcpy to write to IRAM
      CVE-2025-39798: NFS: Fix the setting of capabilities when automounting a new filesystem
      CVE-2025-39808: HID: hid-ntrig: fix unable to handle page fault in ntrig_report_version()
      CVE-2025-39812: sctp: initialize more fields in sctp_v6_from_sk()
      CVE-2025-39813: ftrace: Fix potential warning in trace_printk_seq during ftrace_dump
      CVE-2025-39817: efivarfs: Fix slab-out-of-bounds in efivarfs_d_compare
      CVE-2025-39824: HID: asus: fix UAF via HID_CLAIMED_INPUT validation
      CVE-2025-39828: atm: atmtcp: Prevent arbitrary write in atmtcp_recv_control().

Best regards,
Ulrich Hecht

