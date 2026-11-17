Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1243.1794931899705809159
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 08:11:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=qbbMQugT;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=giDHRwXm;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.161, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1794931869; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QtPBlk7tOEeDRk5ZVYo6Nlb0PWjnuNwXUhzprU6h/RK6y7xPqo11uCMZ8gPa6ljwVj
    zmOBi3gjMFkIHiehMhdWu4LuJy+oWQwByrWBL2g3vMwqKkPkzWwO6FBT2qI3eZfqIaVq
    KFqiBNjCgU/s3r/pwagDxtkaokM7Q7OjPix4vgRFHmzNL6q4p2yB4OKWCzv+zPH4xGB1
    liFXUROGg1IQ/aFk2FC4z16rru4bUlcMyEHSzlzSfur111UfGqsjp80p6Gy2DS65Hvde
    hXDFc9y6g/cwh+AA0nE3txmnh378GIcY2+bJMV2aTdTBQkKE5qrItumwb7WnAhngC+re
    r1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794931869;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=nq/3MkB2bftaz8luvgfxvDt7zyQAvbU5fQsxjx8HMrA=;
    b=YOBhtFBrSbB5MCvMcj4a/zhwC4MWQTQbDcDW1W7eima9/OHGvQB8guBHkPcB/S8fja
    s555ZB/b2a1aJBoee3yJGfPNQ9LWEpWJ5MxY4+F1Z7wzFBFehlmDRJ0xU2FPKeO25pNe
    e/wSkT/58vmQbwzJbgbiKwoqcr4sMoosBSg7j0Wm+aE8BntTwAIY+x7sx616AG4RGMlD
    o9sGuXDpMD9UeDz4NIAAvFhfUHYzMgbXckuuA2RIku7dz8ZqXqW15BQHwhhth4qFxcSw
    C/FY3ORHFLlBV3D/TqJR6V9fzw2dHNjOaCTLnLN+WZu672z/JhsYprq1QwEzt4fWo7b/
    O/0w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794931869;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=nq/3MkB2bftaz8luvgfxvDt7zyQAvbU5fQsxjx8HMrA=;
    b=qbbMQugTBb5YuBeNqAYO4MYlidoLgc5eJsv1a15rdLXWXoovF6BohlfXhtRzj0qR7i
    DfXRqtemQIyrsY7TE0kglV/olB3X5LrOrIWlJpFTcIdp7lyUTKHQvBBp6c8oEkyp9BYx
    9EC9v/8UR4aiu9tUeDc872GJCEAIdO0Wcjvz80U9sw2s76Pyy5bim/quKp8i7pKEJBQy
    BO7/fp8EThr5xpbbQY6gPK5ZelggNMw5Zbd7X1c2RuPU5g3bhw/LFJNVjuqnEsTaMW79
    5DMPaP+sYBvb/C0Ha720iyLUPer37nrhCs1R1ZpC6PQpy+0vHak31TcbH5iDZCtnW0IO
    kQdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794931869;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=nq/3MkB2bftaz8luvgfxvDt7zyQAvbU5fQsxjx8HMrA=;
    b=giDHRwXmrv2twpX9fZUG6JGmgaqePicFcs6rKtz3cYN4pQL7axuymhTFsOnQ6B/Pu+
    ulgfi9L7H6BHIwPW1QAg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzotGZvghOuyX/LuaP4"
Received: from open-xchange-core-mw-gw-7.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.6.3 AUTH)
    with ESMTPSA id z81ed22AHGB8VAm
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 17 Nov 2026 17:11:08 +0100 (CET)
Date: Tue, 17 Nov 2026 17:11:08 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1116996891.1239030.1794931868691@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip116
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.154
X-Originating-Port: 37030
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 16:11:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24944

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip116. The linux-4.4.y-cip tree's base version has been updated to v4.4-st81. The trees are up-to-date with kernel 4.19-st21.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip116:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      e5b7cf3a31a3280485ecbd28e460139ce327210e
    Fixed CVEs:
      CVE-2024-58094: jfs: add check read-only before truncation in jfs_truncate_nolock()
      CVE-2024-58095: jfs: add check read-only before txBeginAnon() call
      CVE-2025-21759: ipv6: mcast: extend RCU protection in igmp6_send()
      CVE-2026-100070: netfilter: nf_nat_sip: rewind offset when NAT shrinks the packet
      CVE-2026-23191: ALSA: aloop: Fix racy access at PCM trigger
      CVE-2026-43088: net: af_key: zero aligned sockaddr tail in PF_KEY exports
      CVE-2026-43198: tcp: fix potential race in tcp_v6_syn_recv_sock()
      CVE-2026-53275: ipv6: mcast: Fix use-after-free when processing MLD queries
      CVE-2026-64581: xfrm: fix sk_dst_cache double-free in xfrm_user_policy()
      CVE-2026-68155: libceph: Reject monmaps advertising zero monitors
      CVE-2026-74460: can: ems_usb: validate CPC message lengths
      CVE-2026-74496: fou: Fix use-after-free in fou_create()
      CVE-2026-74582: packet: use consistent hard_header_len in non-ring send paths
      CVE-2026-74626: NTB: ntb_netdev: Preserve RX queue depth on allocation failure
      CVE-2026-74662: inet: frags: publish queues before arming timer
      CVE-2026-74663: net/sched: reject overly deep qdisc hierarchies
      CVE-2026-74666: packet: synchronize pressure clearing with ring reconfiguration
      CVE-2026-80536: xfs: bounds-check buffer log item's dirty bitmap
      CVE-2026-80562: gpio: ml-ioh: use raw_spinlock_t for the register lock
      CVE-2026-80590: inet: frags: strip GSO state from fragments before reassembly
      CVE-2026-80765: HID: hyperv: validate initial device info bounds
      CVE-2026-80767: HID: sensor: custom: Fix use-after-free in enable_sensor
      CVE-2026-80781: HID: core: fix OOB read of field->usage in hid_set_field()
      CVE-2026-80782: HID: magicmouse: do not keep a stale msc->input if no input is claimed
      CVE-2026-80793: ipv4: reject undersized MTUs in ip_do_fragment()
      CVE-2026-80794: nfc: nci: fix uninit-value in the RF discover/activated NTF handlers
      CVE-2026-80795: nfc: nci: fix out-of-bounds write in nci_target_auto_activated()
      CVE-2026-80796: nfc: nci: add data_len bound checks to activation parameter extractors
      CVE-2026-80798: nfc: llcp: reject PDUs shorter than the LLCP header
      CVE-2026-80801: nfc: microread: validate target discovery payload lengths
      CVE-2026-80802: nfc: fdp: bound the device-reported read length and fix an skb leak
      CVE-2026-80803: nfc: digital: clamp SENSF_RES length to the destination buffer
      CVE-2026-80807: nilfs2: reject invalid block index in GC ioctl
      CVE-2026-80809: ocfs2: fix missing metadata reservation for large xattrs
      CVE-2026-80814: rndis_host: add overflow check in rndis_rx_fixup()
      CVE-2026-80819: Bluetooth: RFCOMM: take rfcomm_mutex for the deferred setup accept
      CVE-2026-80823: nfc: st21nfca: validate ATR_REQ length against the received frame
      CVE-2026-80826: USB: c67x00: fix use-after-free in c67x00_add_iso_urb()
      CVE-2026-80827: USB: serial: option: fix slab OOB read in interrupt URB callback
      CVE-2026-80829: ALSA: usb-audio: fix OOB write in snd_usbmidi_novation_output()
      CVE-2026-80830: usb: core: Add lock to usb_wakeup_notification()
      CVE-2026-80831: crypto: mxs-dcp - fix source scatterlist length access
      CVE-2026-80843: xfrm: fix xfrm_state_construct() auth-trunc leak
      CVE-2026-80844: xfrm: ah6: validate routing header segments_left
      CVE-2026-80854: usb: gadget: f_tcm: keep port count until LUN teardown completes
      CVE-2026-80888: drm/vmwgfx: drop dma_buf reference on foreign-fd prime import
      CVE-2026-80918: HID: core: fix number/pointer type confusion on long items
      CVE-2026-80949: wifi: brcmfmac: Fix memory leak in brcmf_sdio_read_control()
      CVE-2026-80963: dm-stats: fix a crash if allocation of per-cpu data fails
      CVE-2026-80965: ALSA: serial-u16550: Check card index validity at probe
      CVE-2026-80966: ALSA: portman2x4: Check card index validity at probe
      CVE-2026-80968: ALSA: mts64: Check card index validity at probe
      CVE-2026-80969: ALSA: mpu401: Check card index validity at probe
      CVE-2026-80971: ALSA: bcd2000: clear the URB pointers on disconnect
      CVE-2026-80973: ALSA: 6fire: bound the MIDI event length from the device
      CVE-2026-80977: net: skbuff: don't touch shared zerocopy state in skb_tx_error()
      CVE-2026-80978: net: cap advertised IP tunnel headroom
      CVE-2026-80988: NTB: ntb_transport: Fail TX enqueue when the QP link is down
      CVE-2026-80994: net: openvswitch: fix flow mask use-after-free on flow deletion
      CVE-2026-81001: slip: fix use-after-free in sl_sync()
      CVE-2026-81003: net/iucv: filter frames in afiucv_hs_rcv() by ingress device
      CVE-2026-89440: mmc: via-sdmmc: stop card-detect handling on probe failure
      CVE-2026-89461: power: supply: max17040: synchronize work cancellation on suspend
      CVE-2026-89469: power: supply: lp8727: fix use-after-free in lp8727_release_irq()
      CVE-2026-89478: sctp: drop a chunk if its transport was removed
      CVE-2026-89479: sctp: stop processing a packet once its association is deleted
      CVE-2026-89487: openvswitch: only skb_tx_error() a packet we are about to drop
      CVE-2026-89489: openrisc: fix arbitrary kernel memory access via or1k_atomic syscall
      CVE-2026-89490: ocfs2: fix readdir position truncation on 32-bit kernels
      CVE-2026-89493: ocfs2: validate rl_used against rl_count in refcount block validator
      CVE-2026-89495: ocfs2: bound namelen in dlm_migrate_request_handler
      CVE-2026-89504: regulator: as3722_get_regulator_dt_data: fix premature of_node_put leaving dangling of_node pointer
      CVE-2026-89524: wifi: ath6kl: clamp assoc request/response lengths before subtracting IE offsets
      CVE-2026-89525: udf: reject VAT indexes equal to the entry count
      CVE-2026-89538: SUNRPC: Reject krb5 v2 wrap tokens with oversized ec field
      CVE-2026-89540: sunrpc: init gssp_lock before publishing proc entry
      CVE-2026-89541: SUNRPC: harden gss_unwrap_resp_priv length checks
      CVE-2026-89542: SUNRPC: harden gss_krb5_unwrap_v2 against short tokens
      CVE-2026-89548: SUNRPC: always drain cache_cleaner before destroying a cache_detail
      CVE-2026-89549: sunrpc: route to a populated pool in svc_pool_for_cpu()
      CVE-2026-89551: SUNRPC: xdr_buf_trim: clamp buf->len to avoid underflow
      CVE-2026-89563: ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()
      CVE-2026-89569: Bluetooth: RFCOMM: serialize security confirmation handling
      CVE-2026-89573: dm array: reject an array block whose value size is not the caller's
      CVE-2026-89575: dm raid1: reserve space for NUL-terminator in build_constructor_string()
      CVE-2026-89576: dm-era: fix shadowed superblock leak on take-snap failure
      CVE-2026-89582: bnx2x: fix double free in bnx2x_init_firmware() error path
      CVE-2026-89596: forcedeth: fix off-by-one when saving/restoring non-PCI config space
      CVE-2026-89597: fbdev: uvesafb: unregister connector callback on init failure
      CVE-2026-89605: ecryptfs: release message context on send failure
      CVE-2026-89606: ecryptfs: reject too-small tag 70 packets
      CVE-2026-89607: ecryptfs: reject oversized encrypted_key_size in parse_tag_3_packet
      CVE-2026-89609: ecryptfs: hold msg ctx list lock when cleaning daemon queue
      CVE-2026-89626: HID: sensor: custom: Fix field sysfs group cleanup on failure
      CVE-2026-89627: HID: roccat: free buffered reports when destroying device
      CVE-2026-89628: HID: picolcd: clamp eeprom debugfs read to bytes actually received
      CVE-2026-89643: audit: avoid dropping live tree ref on fsnotify rule autoremove
      CVE-2026-89649: ceph: bound xattr value length in __build_xattrs()
      CVE-2026-89697: nfsd: add fh_want_write() for early-verified SETATTR in nfsd_proc_setattr()
      CVE-2026-89726: lib/ucs2_string.c: fix out-of-bounds read in ucs2_strnlen()
      CVE-2026-89732: usb: gadget: f_fs: Prevent deadlock during ep0 read loop
      CVE-2026-89749: tracing: Fix crash passing ERR_PTR to kthread_stop()
      CVE-2026-89777: vfio/pci: clear vdev->msi_perm after freeing it on init failure
      CVE-2026-89783: xfrm6: fix out-of-bounds write in xfrm6_input_addr() when secpath is full
      CVE-2026-89784: SUNRPC: check rpc_sockaddr2uaddr() return value in rpcb_register_inet4/6
      CVE-2026-89843: scsi: qla2xxx: Zero-init bsg stack buffers to avoid info leak
      CVE-2026-89845: scsi: qla2xxx: Avoid req_q_map double-read in qla2x00_error_entry()
      CVE-2026-89846: scsi: qla2xxx: Bound rsp_info_len to avoid OOB sense-data read
      CVE-2026-89852: scsi: qla2xxx: Zero mailbox struct in qla2x00_get_firmware_state()
      CVE-2026-89854: scsi: qla2xxx: Fix cs84xx use-after-free on host teardown
      CVE-2026-89861: scsi: qla2xxx: Hold vport reference in qla24xx_report_id_acquisition()
      CVE-2026-89865: scsi: qla2xxx: Zero SFP DMA buffer in FRU/I2C bsg handlers
      CVE-2026-89878: media: s2255: check firmware size before reading trailing marker
      CVE-2026-89879: media: s2255: bound JPEG frame size before copying into the buffer
      CVE-2026-89890: media: go7007: defer the ALSA v4l2 put until card release
      CVE-2026-89893: media: cx23885: cancel NetUP CI work before teardown
      CVE-2026-89895: media: cobalt: Avoid freeing ALSA private data twice
      CVE-2026-89924: KVM: s390: Fix old_data leak in guest debug error path
      CVE-2026-89925: KVM: s390: Fix memory leak in guest debug handling
      CVE-2026-89936: iio: dac: m62332: Fix regulator reference count imbalance
      CVE-2026-89949: batman-adv: dat: avoid unaligned fault in IP extraction
      CVE-2026-89951: batman-adv: fix stale receive device on merged fragments
      CVE-2026-89952: mtd: rawnand: validate ONFI extended parameter page sections
      CVE-2026-89953: mtd: mtdoops: free page bitmap when the backing MTD is removed
      CVE-2026-89964: parisc: eisa: Fix infinite loop when parsing invalid IRQ value
      CVE-2026-89997: dm: fix resume-vs-remove race
      CVE-2026-90000: HID: rmi: fix OOB access with undersized RMI reports
      CVE-2026-90011: scsi: target: iscsi: Reserve a terminator byte for the login payload
      CVE-2026-90020: USB: gadget: fix NULL pointer dereference in gadget_dev_ioctl()
      CVE-2026-90031: usb-storage: ene_ub6250: fix race between scan work and probe
      CVE-2026-90033: ALSA: usb-audio: fix OOB write in snd_usbmidi_us122l_output()
      CVE-2026-90034: usb: image: mdc800: change kmalloc() to kzalloc()
      CVE-2026-90049: net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
      CVE-2026-90055: usb: atm: usbatm: fix invalid ci_range initialization
      CVE-2026-90058: net/sched: bound qdisc_pkt_len to prevent qdisc soft lockup
      CVE-2026-90068: ASoC: dapm: Fix off-by-one check on the second enum channel
      CVE-2026-90071: net/sched: sch_teql: restore skb->dev on the slave failure path
      CVE-2026-90073: net/sched: hhf: clamp quantum before hhf_change() to avoid overflow
      CVE-2026-90088: Bluetooth: RFCOMM: Validate MTU in rfcomm_apply_pn() to prevent infinite loop
      CVE-2026-90102: NFSv4/pnfs: key the data server cache on the NFS version
      CVE-2026-90103: NFSv4.2: fix LAYOUTSTATS send buffer exhaustion
      CVE-2026-90141: ipvs: fix integer overflow in ftp helper port/address parsing
      CVE-2026-90151: NFSv4: remove callback IDR entry on client allocation failure
      CVE-2026-90203: Squashfs: check block offset is not negative
      CVE-2026-90216: ubi: Fix rollback for explicit UBI device numbers
      CVE-2026-90225: nfc: llcp: read llcp_sock->local under the socket lock in getsockopt
      CVE-2026-90226: nfc: llcp: avoid userspace overflow on invalid optlen
      CVE-2026-90245: fbdev: kyro: Validate overlay viewport coordinates
      CVE-2026-90283: hugetlbfs: release subpool on fill_super failure
      CVE-2026-90295: cpufreq: imx6q: fix out-of-bounds write when probed more than once
      CVE-2026-90302: ocfs2: synchronize heartbeat callbacks with o2net teardown
      CVE-2026-90307: RDMA/srp: fix heap information leak on a truncated SRP_CRED_REQ
      CVE-2026-90314: remoteproc: fix OOB read via signed offset in rsc_table_for_each_entry()
      CVE-2026-90318: fat: release buffer head after rebuilding parent
      CVE-2026-90327: phonet: pep: do not write beyond optlen in getsockopt
      CVE-2026-90334: tty: clear cdev pointer after cdev_add() failure
      CVE-2026-90395: power: supply: isp1704_charger: cancel work on remove
      CVE-2026-90415: RDMA/cxgb4: free STAG index when TPT entry write fails
      CVE-2026-90420: nilfs2: fix infinite loop in nilfs_clean_segments()
      CVE-2026-90431: remoteproc: Prevent crash handling to race with rproc_del()
      CVE-2026-90434: isofs: release zisofs block pointer buffer head
      CVE-2026-92498: wifi: ath6kl: avoid buffer overreads in WMI event handlers
      CVE-2026-92521: ACPI: PCI: Clear driver_data on all paths that free the acpi_pci_root
      CVE-2026-92522: ACPI: processor: validate MADT IOAPIC entry bounds
      CVE-2026-93048: mtd: part: reject MTDPART_OFS_RETAIN in mtd_add_partition()
      CVE-2026-93049: mtd: mtdswap: Avoid freeing registered blktrans device twice
      CVE-2026-93055: UDF symlink pathComponent header OOB read
      CVE-2026-93108: RDMA/ipoib: Drain RCU callbacks during module teardown
      CVE-2026-93141: usb: gadget: r8a66597: avoid double free of ep0_req in probe error path
      CVE-2026-93188: HID: roccat: bound device-supplied profile index
      CVE-2026-93189: HID: core: quiesce input in hid_hw_stop() to prevent use-after-free
      CVE-2026-93203: batman-adv: bla: avoid CRC corruption due to parallel claim add
      CVE-2026-93204: batman-adv: dat: atomically update mac addresses
      CVE-2026-93206: PCI/proc: Use file_ns_capable() when checking config space read access
      CVE-2026-93213: of: fix out-of-bounds read in of_alias_scan() stem parser
      CVE-2026-93252: ocfs2: fix circular locking dependency in ocfs2_init_acl()
      CVE-2026-93261: locking/lockdep: Fix NULL pointer dereference in __lock_set_class()
      CVE-2026-93286: net: appletalk: fix NULL pointer dereference in aarp_send_ddp()
      CVE-2026-93287: i2c: smbus: reject oversized block transfers in the common path
      CVE-2026-93782: vhost-scsi: flush backend after device ioctls
      CVE-2026-93783: Bluetooth: RFCOMM: validate skb length in rfcomm_recv_frame
      CVE-2026-93785: cifs: validate idmap key payload length
      CVE-2026-93803: wifi: libipw: fix key index receive bound checks
      CVE-2026-93808: ALSA: usb-audio: caiaq: validate EP1 reply lengths
      CVE-2026-93815: net: au1000: move free_irq out of the close-time spinlocked section
      CVE-2026-93816: f2fs: validate inline dentry name lengths before conversion
      CVE-2026-97408: Bluetooth: L2CAP: validate connectionless PSM length
      CVE-2026-97411: net: ibm: emac: mal: fix potential system hang in mal_remove()
      CVE-2026-97417: netfilter: nf_conntrack: use get_unaligned_be32() in tcp_sack()
      CVE-2026-97418: ALSA: es18xx: check control allocation before private data setup
      CVE-2026-97419: hsr: broadcast netlink notifications in the device's net namespace
      CVE-2026-97430: xhci: Prevent queuing new commands if xhci is inaccessible
      CVE-2026-97443: perf/ftrace: Fix WARNING in __unregister_ftrace_function
      CVE-2026-97452: ACPICA: Prevent adding invalid references
      CVE-2026-97472: ipv6: addrconf: fix temp address generation after prefix deprecation
      CVE-2026-97481: serial: 8250: fix possible ISR soft lockup
      CVE-2026-97482: usb: gadget: goku_udc: avoid NULL deref of dev->driver in INT_USBRESET log
      CVE-2026-97483: usb: core: hcd: fix possible deadlock in rh control transfers
      CVE-2026-97486: hpfs: handle set_blocksize failures
      CVE-2026-97487: jfs: handle set_blocksize failures
      CVE-2026-97488: qnx4: handle set_blocksize failures
      CVE-2026-97489: bfs: handle set_blocksize failures
      CVE-2026-97502: mmc: davinci: avoid NULL deref of host->data in IRQ handler
      CVE-2026-97507: media: dm1105: fix missing error check for dma_alloc_coherent
      CVE-2026-97572: bnxt_en: Propagate RX ring init failures in bnxt_init_nic()
      CVE-2026-97598: ipv4: fib: bound automatic table ID allocation
      CVE-2026-97601: ieee802154: 6lowpan: fix NULL dereference in lowpan_newlink
      CVE-2026-97612: net: mpls: clear inner_protocol when the last label is popped
      CVE-2026-97905: cpufreq: zero-initialize policy cpumask before sysfs publication
      CVE-2026-97931: ALSA: us122l: Prevent write upgrades for read mappings
      CVE-2026-97940: ipv6: fix fib6 walker UAF on seq stop
      CVE-2026-97952: sunvdc: unmap LDC cookies when the descriptor send fails
      CVE-2026-97954: net/rds: fix tcp stream corruption with large pages
      CVE-2026-97995: virtio_console: do not free control-out buffers on remove
      CVE-2026-97998: netfilter: nfnetlink_log: cope with concurrent instance destruction
      CVE-2026-98011: net/sched: hhf: clamp quantum in change and init paths
      CVE-2026-98025: net: usb: cx82310_eth: drop URB after 0xffff reboot sentinel to prevent partial_data heap overflow
      CVE-2026-98066: ALSA: caiaq: Fix potential double-free at error path
      CVE-2026-98074: bonding: do not clear curr_active_slave prematurely when releasing all slaves
      CVE-2026-98077: netfilter: nf_conntrack_sip: fix OOB read in sip_skip_whitespace()
      CVE-2026-98078: ipvs: fix reversed sequence option serialization
      CVE-2026-98094: staging: fbtft: make dirty_lock IRQ-safe
      CVE-2026-98095: af_packet: Don't cast tpacket_hdr.tp_len to int in tpacket_parse_header().
      CVE-2026-98157: EDAC/device_sysfs: Use kstrtouint() for poll_msec to prevent truncation
      CVE-2026-98158: ppp_async: drop the errored frame instead of resetting its headroom
      CVE-2026-98185: wifi: mwifiex: validate scan response extents
      CVE-2026-98186: wifi: mwifiex: bound the pairwise-cipher OUI walk to the IE length
      CVE-2026-98187: wifi: p54: require a full exp_if record in PDR_INTERFACE_LIST
      CVE-2026-98188: wifi: p54: validate curve data length in the calibration curve converters
      CVE-2026-98194: wifi: libertas_tf: fix UAF in lbtf_free_adapter()
      CVE-2026-98195: wifi: iwlegacy: fix broadcast stations deallocation
      CVE-2026-98196: wifi: brcmsmac: fix UAF in brcms_free_timer()
      CVE-2026-98197: hwmon: (w83791d) remove fan/pwm 4-5 sysfs group on remove
      CVE-2026-98201: Input: zero ff_effect before compat copy in input_ff_effect_from_user
      CVE-2026-98205: Input: evdev - zero absinfo before partial copy in EVIOCSABS
      CVE-2026-98207: mmc: spi: reset bytes_xfered before retrying CRC failures
      CVE-2026-98208: mmc: sdio_uart: fix xmit_fifo leak when the port table is full
      CVE-2026-98217: IB/mlx4: Fix use-after-free on pkey sysfs registration failure
      CVE-2026-98234: net/sched: hhf: cap hh_flows_limit at change time
      CVE-2026-98241: ipv6: xfrm: use full sockets in local error paths
      CVE-2026-98251: openvswitch: avoid reallocating confirmed conntrack labels
      CVE-2026-98255: tcp: exclude old ACKs from tcp fast path
      CVE-2026-98262: ata: libahci: clear PxCLBU and PxFBU for AHCI_HFLAG_32BIT_ONLY
      CVE-2026-98276: net: lock the socket in sock_gettstamp()
      CVE-2026-98298: dmaengine: mmp_pdma: fix wrong sg length in mmp_pdma_prep_slave_sg()
      CVE-2026-98302: net: fddi: skfp: fix NULL deref when setting the MAC address while down
      CVE-2026-98308: ALSA: hda: trace PCM open only after assigning a stream
      CVE-2026-98314: ALSA: pcm: set timer->private_data before registering the PCM timer
      CVE-2026-98340: wifi: cfg80211: only group hidden BSSes with beacon entries
      CVE-2026-98345: wifi: cfg80211: check IP header size in cfg80211_classify8021d()
      CVE-2026-98348: wifi: libipw: reject too-short association responses
      CVE-2026-98349: wifi: libipw: reject too-short beacon and probe responses
      CVE-2026-98362: clk: scpi: bound-check DVFS index in scpi_dvfs_recalc_rate
      CVE-2026-98404: drm/virtio: Fix a NULL vs ERR_PTR() bug in virtio_gpu_user_framebuffer_create()
      CVE-2026-98419: drop_monitor: fix out-of-bounds write in reset_per_cpu_data()
      CVE-2026-98422: wifi: mac80211: reset the AP_VLAN tailroom counter on ifdown
      CVE-2026-98432: ipv4: free inet_opt and ireq_opt after an RCU grace period
      CVE-2026-98455: Bluetooth: RFCOMM: fix NULL dereference of dlc->session in RFCOMM_CONNINFO
      CVE-2026-98457: Bluetooth: L2CAP: validate frame length before control and FCS access
      CVE-2026-98460: Bluetooth: hci_sock: reject out-of-range OCF values
      CVE-2026-98461: Bluetooth: hci_sock: validate event length before filtering
      CVE-2026-98481: nfc: port100: reject frames whose declared length exceeds the received data
      CVE-2026-98482: nfc: llcp: drop truncated I/RR/RNR PDUs in nfc_llcp_recv_hdlc()
      CVE-2026-98485: netfilter: ip6t_rt: fix zero-address non-strict match out-of-bounds read
      CVE-2026-98488: net: atl1e: fix soft lockup on out-of-range hw_next_to_clean read
      CVE-2026-98489: net: atl1c: fix soft lockup on out-of-range tpd_cons read
      CVE-2026-98491: net: openvswitch: conntrack: avoid modifying shared unconfirmed ct entry
      CVE-2026-98494: net: atl1: fix soft lockup on out-of-range cmb_tpd_next_to_clean read
      CVE-2026-98516: drm/nouveau: Fix bridge reference leak in nv1a_ram_new()
      CVE-2026-98526: llc: reserve device headroom for allocated frames
      CVE-2026-98532: ipv6: do not let ipv6_find_hdr() return an offset past the packet end
      CVE-2026-98541: fou: reject omitted FOU_ATTR_IPPROTO on FOU_ENCAP_DIRECT
      CVE-2026-98547: af_packet: fix integer overflow in prb_calc_retire_blk_tmo()
      CVE-2026-98548: sctp: discard the rest of the packet on a stale-cookie error
      CVE-2026-98554: vlan: ensure sufficient headroom in vlan_dev_hard_header()
      CVE-2026-98555: llc: fix skb UAF and leaks on llc_mac_hdr_init() failure
      CVE-2026-98569: ip_gre: Reject enabling collect metadata through changelink
      CVE-2026-98573: net: skbuff: fix pull-bound underflow in skb_checksum_setup_ipv6()
      CVE-2026-98576: nfc: llcp: fix slab-out-of-bounds reads when logging service names
      CVE-2026-98577: nfc: llcp: fix WKS SAP hijacking via prefix match in nfc_llcp_wks_sap()
      CVE-2026-98578: nfc: st21nfca: validate ISO15693 inventory length
      CVE-2026-98581: nfc: llcp: Fix list corruption / refcount desync in nfc_llcp_recv_dm()
      CVE-2026-98582: nfc: st21nfca: validate received frame size
      CVE-2026-98583: nfc: nfcmrvl: validate helper command length before pull
      CVE-2026-98594: tg3: clean up PHYLIB resources on probe failure
      CVE-2026-98597: net: usb: sr9700: include receive overhead in the length check
      CVE-2026-98600: Bluetooth: RFCOMM: Reject short EA=0 frames in rfcomm_recv_frame()
      CVE-2026-98610: net/sched: sch_hfsc: bound the classify inner-filter walk with a drift budget
      CVE-2026-98612: net: usb: catc: bound the RX packet length in catc_rx_done()
      CVE-2026-98614: sctp: avoid livelock while updating retransmit path
      CVE-2026-98621: net: gue: reject invalid REMCSUM offsets
      CVE-2026-98623: drm/nouveau/clk: fix list cursor use after loop in nvkm_clk_ustate_update
      CVE-2026-98624: netfilter: nfnetlink_queue: hold nfnl mutex in event notifier
      CVE-2026-98636: squashfs: Add dictionary size range check to prevent shift-out-of-bounds
      CVE-2026-98879: isofs: handle set_blocksize failures
      CVE-2026-98886: drm/gma500: return errors from Oaktrail HDMI I2C reads
      CVE-2026-98890: wifi: libertas: reject short monitor TX frames
      CVE-2026-98891: wifi: mac80211: validate deauth frame length before reason access
      CVE-2026-98902: md/raid5: let stripe batch bm_seq comparison wrap-safe
      CVE-2026-98912: ALSA: seq: oss: Reject reads that cannot fit the next event
      CVE-2026-99999: ipv4: validate checksum_start before completing checksum

Best regards,
Ulrich Hecht
