Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7122DC88E4D
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 10:16:27 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36233.1789121779235164731
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 03:16:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=Y21us1nJ;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=0Zzfj8yT;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.166, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1789121749; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CWGxoo6h4ncJY1ij7epTRrAbRl2beN4taxEZ+nY5yQPgsEKBMTPi5djjc/P9YCOIUR
    jIW+zKSipo47YcvD27HXWZhYg4ImgOIN41aC2CHy1wwzPE5ONtJKs18mhtfq49ybUYHT
    CYUXDdSSDjmaieARJvoK7JXazY06krwxOUWVpvfa9iAony6Rdx1J0UakR8DIJ9aN02x2
    h9Zi5RrGqNd1H2smM0eAIcoRvR3+2RmekXRQ+7bx0+w0vl8Pnx107VO+aljrUXSihy+4
    OExwhBl4tLss9uARY6m8uNnSgCn7yHZDqFp1IZrLux5nhW3KyhQT/+NilKxNB+5AV8Bf
    L/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1789121749;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Hh8TImz+YJI5fGLdPPJ+iAHhAvbuKHSwM/pKLNFdnjE=;
    b=gBfaSlvamhYDYGuZBmVMGCMYicHJ1tppdi/fVHtubATrXEUJc0RF8PlyU3SsknOwh6
    /V7/+Wz3fD9O08KU85Nyp/51bD5MZdqgYoI+dfveWrZy4eazP9Dyfuq41tKNA1mDK/3r
    UvG7YLGCwErg5cwgDnuPdYQaZQXhdqAZTrgLMHVckJHDhgHk5In5nm9eEIvmcLKQp2ox
    /OPOvf66cJK5zJf8UNJ99rWOgNFOTHGRHFV1MHLsVq+Ke/OpOAPwybD7JumLYWHkJKOC
    AAu8LksmugIqbgVamnPXJjFogjqHmRdYfs8aoi8MyMCcFJV9kQWM6QmxQvEBH66UggYk
    g6+Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789121749;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Hh8TImz+YJI5fGLdPPJ+iAHhAvbuKHSwM/pKLNFdnjE=;
    b=Y21us1nJVtSwUn1W80OQ01frrvHqWStVzp92Y+7/SDLoRHXQ6yT1X5MactRWYg7qLf
    3JwSaDUNfJiAh0yDi/30qLVhUzFM21UB/yzq4qV564vfK0Ctcxd7ZBQrkOMRC4wBIFB4
    qDA1nZa/w9qLCVr/IwOCFi6FyjLtBJXCJ4g423ONx97WZlWUSbfeCM1pC4hi2puz9Khg
    I4YdWIojRRYpS7Ie415ZByyRLoY3ixhZ4P12uCZDKViQ5+VhYckcPby8NelzOueC1M9f
    lRVhDT9rS8khzISKU3JCsz8Zj7gDTeVHqtEr8yvActPFY8Xogs9oLTjrjnpaPuY9qbDq
    I7rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789121749;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Hh8TImz+YJI5fGLdPPJ+iAHhAvbuKHSwM/pKLNFdnjE=;
    b=0Zzfj8yTjx6ElgLwiIfgvIoUDSSevQ3a5lZcfN0On6aYCSXD4hlML9tw09s8G98Hq8
    Y8XjquUul9iJ4s09xoBA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKHK+AR2fLw="
Received: from open-xchange-core-mw-gw-0.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.6.2 AUTH)
    with ESMTPSA id ze24d928BAFnjQw
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 11 Sep 2026 12:15:49 +0200 (CEST)
Date: Fri, 11 Sep 2026 12:15:49 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1432043768.88457.1789121749469@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.19.325-cip136
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.154
X-Originating-Port: 35678
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 10:16:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24130

Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip136. The linux-4.19.y-cip tree's base version has been updated to v4.19-st20. The trees are up-to-date with kernel 5.10.266.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/

  v4.19.325-cip136:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      596368289cc36e634b7c43a93e9e81b117692845
    Fixed CVEs:
      CVE-2022-48785: ipv6: mcast: use rcu-safe version of ipv6_get_lladdr()
      CVE-2024-50125: Bluetooth: SCO: Fix UAF on sco_sock_timeout
      CVE-2025-38524: rxrpc: Fix recv-recv race of completed call
      CVE-2026-31408: Bluetooth: SCO: Fix use-after-free in sco_recv_frame() due to missing sock_hold
      CVE-2026-31650: mmc: vub300: fix use-after-free on disconnect
      CVE-2026-64540: usbnet: gl620a: fix out-of-bounds read in genelink_rx_fixup()
      CVE-2026-64543: tipc: fix use-after-free of the discoverer in tipc_disc_rcv()
      CVE-2026-64544: crypto: asymmetric_keys - fix OOB read in pefile_digest_pe_contents
      CVE-2026-64546: drm/edid: fix OOB read in drm_parse_tiled_block()
      CVE-2026-64547: net: usb: net1080: validate packet_len before pad-byte access in rx_fixup
      CVE-2026-64549: Bluetooth: bpa10x: avoid OOB read of revision string in bpa10x_setup()
      CVE-2026-64551: sctp: validate STALE_COOKIE cause length before reading staleness
      CVE-2026-64553: net: psample: fix info leak in PSAMPLE_ATTR_DATA
      CVE-2026-64562: KVM: nVMX: Hide shadow VMCS right after VMCLEAR
      CVE-2026-64563: rhashtable: clear stale iter->p on table restart
      CVE-2026-64564: sctp: don't free the ASCONF's own transport in DEL-IP processing
      CVE-2026-64565: Input: ims-pcu - fix heap-buffer-overflow in ims_pcu_process_data()
      CVE-2026-64571: wifi: p54: validate RX frame length in p54_rx_eeprom_readback()
      CVE-2026-64572: ipv4: fib: free fib_alias with kfree_rcu() on insert error path
      CVE-2026-64582: RDMA/rxe: Fix a use-after-free problem in rxe_mmap
      CVE-2026-64583: usb: gadget: udc: bdc: free IRQ and drain func_wake_notify before teardown
      CVE-2026-64584: usb: gadget: f_midi: cancel pending IN work before freeing the midi object
      CVE-2026-68106: drm/amdgpu: fix division by zero with invalid uvd dimensions
      CVE-2026-68117: tipc: clear sock->sk on the failed-insert path in tipc_sk_create()
      CVE-2026-68121: pppoe: reload header pointer after dev_hard_header()
      CVE-2026-68123: openvswitch: fix GSO userspace truncation underflow
      CVE-2026-68125: mac802154: llsec: reject frames shorter than the authentication tag
      CVE-2026-68127: ila: reload IPv6 header after pskb_may_pull in checksum adjust
      CVE-2026-68135: net: hip04: fix RX buffer leak on build_skb failure
      CVE-2026-68137: net/x25: fix use-after-free in x25_kill_by_neigh()
      CVE-2026-68140: net/iucv: fix use-after-free of a severed iucv_path
      CVE-2026-68141: net/af_iucv: fix NULL deref in afiucv_hs_callback_syn()
      CVE-2026-68142: geneve: require CAP_NET_ADMIN in the device netns for changelink
      CVE-2026-68143: net: slip: serialize receive against buffer reallocation
      CVE-2026-68144: phonet: pep: fix use-after-free in pep_get_sb()
      CVE-2026-68146: ftrace: Add global mutex to serialize trace_parser access
      CVE-2026-68151: binfmt_elf_fdpic: only honour the first PT_INTERP
      CVE-2026-68153: libceph: remove debugfs files before client teardown
      CVE-2026-68154: libceph: reject zero bucket types in crush_decode
      CVE-2026-68156: libceph: refresh auth->authorizer_buf{,_len} after authorizer update
      CVE-2026-68158: libceph: Fix multiplication overflow in decode_new_up_state_weight()
      CVE-2026-68160: ceph: fix pre-auth out-of-bounds read on snaptrace in ceph_handle_caps()
      CVE-2026-68175: tracing: Fix resource leak on mmiotrace trace_pipe close
      CVE-2026-68176: tracing: Fix mmiotrace possible NULL dereferencing of hiter->dev
      CVE-2026-68182: comedi: comedi_parport: deal with premature interrupt
      CVE-2026-68184: cdrom: fix stack out-of-bounds read in CDROMVOLCTRL
      CVE-2026-68187: exec: fix unsigned loop counter wrap in transfer_args_to_stack()
      CVE-2026-68188: Bluetooth: RFCOMM: Fix session UAF in set_termios
      CVE-2026-68192: wifi: brcmfmac: make release_scratchbuffers idempotent
      CVE-2026-68197: wifi: mwifiex: fix NULL dereference when the AP has HT-cap but no HT-oper
      CVE-2026-68198: wifi: ath6kl: fix use-after-free in aggr_reset_state()
      CVE-2026-68199: wifi: ath6kl: fix OOB access from firmware ADDBA window size
      CVE-2026-68202: ALSA: seq: close a re-opened queue timer in the destructor
      CVE-2026-68204: media: vivid: check for vb2_is_busy() when toggling caps
      CVE-2026-68212: media: saa7134: Fix a possible memory leak in saa7134_video_init1
      CVE-2026-68213: media: rtl2832_sdr: Return queued buffers on start_streaming() failure
      CVE-2026-68214: media: rtl2832: fix use-after-free in rtl2832_remove()
      CVE-2026-68215: media: radio-si476x: Unregister v4l2_device on probe failure
      CVE-2026-68216: media: pwc: Return queued buffers on start_streaming() failure
      CVE-2026-68217: media: pwc: Drain fill_buf on start_streaming() failure
      CVE-2026-68218: media: pci: dm1105: Free allocated workqueue
      CVE-2026-68222: media: msi2500: Return queued buffers on start_streaming() failure
      CVE-2026-68226: media: cx23885: add ioremap return check and cleanup
      CVE-2026-68227: media: cx231xx: fix devres lifetime
      CVE-2026-68231: media: airspy: Return queued buffers on start_streaming() failure
      CVE-2026-68234: drm/amdgpu: fix bo->pin leaking in amdgpu_bo_create_reserved
      CVE-2026-68277: drm/dp/mst: fix OOB reads on 2-byte fields in sideband reply parsers
      CVE-2026-68278: drm/dp/mst: fix buffer overflows in sideband chunk accumulation
      CVE-2026-68279: drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply parsers
      CVE-2026-68294: net: qrtr: restrict socket creation to the initial network namespace
      CVE-2026-68297: tipc: fix u16 MTU truncation in media and bearer MTU validation
      CVE-2026-68299: vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for Geneve packets
      CVE-2026-68300: sctp: auth: verify auth requirement when auth_chunk is NULL
      CVE-2026-68304: wifi: brcmfmac: fix 802.1X-SHA256 call trace warning
      CVE-2026-68313: tipc: fix infinite loop in __tipc_nl_compat_dumpit
      CVE-2026-68315: sctp: validate stream count in sctp_process_strreset_inreq()
      CVE-2026-68320: sctp: fix auth_chunk_list capacity check in sctp_auth_ep_add_chunkid
      CVE-2026-68322: rds: Fix inet6_addr_lst NULL dereference when IPv6 is disabled
      CVE-2026-68326: wifi: mwifiex: bound uAP association event IEs to the event buffer
      CVE-2026-68327: wan: wanxl: Only reset hardware after BAR mapping
      CVE-2026-68328: nfp: Check resource mutex allocation
      CVE-2026-68335: rds: drop incoming messages that cross network namespace boundaries
      CVE-2026-68338: net/packet: avoid fanout hook re-registration after unregister
      CVE-2026-68344: usb: atm: ueagle-atm: reject descriptors that confuse probe and disconnect
      CVE-2026-68350: wifi: carl9170: fix OOB read from off-by-two in TX status handler
      CVE-2026-68351: wifi: carl9170: bound memcpy length in cmd callback to prevent OOB read
      CVE-2026-68352: wifi: ath6kl: fix OOB read from firmware IE lengths in connect event
      CVE-2026-68353: wifi: ath6kl: fix OOB read from firmware num_msg in TX complete handler
      CVE-2026-68354: firewire: net: Fix fragmented datagram reassembly
      CVE-2026-68357: watchdog: pretimeout: Fix UAF in watchdog_unregister_governor()
      CVE-2026-68363: wifi: ath9k: hif_usb: don't dereference hif_dev after re-arming firmware request
      CVE-2026-68365: USB: serial: io_edgeport: cap received transmit credits
      CVE-2026-68366: usb: gadget: uvc: clamp SEND_RESPONSE length to the response buffer
      CVE-2026-68368: usb: gadget: f_ncm: validate datagram bounds in ncm_unwrap_ntb()
      CVE-2026-68370: usb: gadget: dummy_hcd: prevent fifo_req reuse during giveback
      CVE-2026-68373: wifi: at76c50x-usb: avoid length underflow in at76_guess_freq()
      CVE-2026-68376: sctp: fix auth_hmacs array size in struct sctp_cookie
      CVE-2026-68377: net/sched: act_tunnel_key: Defer dst_release to RCU callback
      CVE-2026-68395: ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is registered
      CVE-2026-68397: net/iucv: take a reference on the socket found in afiucv_hs_rcv()
      CVE-2026-68403: wifi: brcmfmac: initialize SDIO data work before cleanup
      CVE-2026-68405: wifi: mac80211: free AP_VLAN bc_buf SKBs outside IRQ lock
      CVE-2026-68410: wifi: libertas: fix memory leak in helper_firmware_cb()
      CVE-2026-68413: wifi: ipw2100: fix potential memory leak in ipw2100_pci_init_one()
      CVE-2026-68425: IB/mad: Drop unmatched RMPP responses before reassembly
      CVE-2026-68428: KVM: x86/mmu: Fix use-after-free on vendor module reload
      CVE-2026-68430: drm/amdgpu/gfx8: drop unecessary BUG_ON()
      CVE-2026-68432: vxlan: require CAP_NET_ADMIN in the device netns for changelink
      CVE-2026-68433: libceph: bound get_version reply decode to front len
      CVE-2026-68434: serial: 8250_mid: Fix NULL function pointer dereference on DNV/ICX-D/SNR platforms
      CVE-2026-68449: ata: sata_dwc_460ex: fix infinite loop in NCQ tag completion bit-scanning
      CVE-2026-68456: usb: atm: ueagle-atm: wait for pre-firmware load in .disconnect()
      CVE-2026-68466: mtd: rawnand: lpc32xx_slc: fail DMA transfer on completion timeout
      CVE-2026-68469: wifi: mwifiex: fix permanently busy scans after multiple roam iterations
      CVE-2026-68474: powerpc/spufs: fix out-of-bounds access in spufs_mem_mmap_access()
      CVE-2026-68475: reset: sunxi: fix memory region leak on ioremap failure
      CVE-2026-68478: memstick: ms_block: reject a card that reports too many blocks
      CVE-2026-68479: Bluetooth: btrtl: validate firmware patch bounds
      CVE-2026-72005: wifi: rt2x00: avoid full teardown before work setup in probe
      CVE-2026-72010: cgroup/cpuset: rebind mm mempolicy to effective_mems, not mems_allowed
      CVE-2026-72014: drbd: reject data replies with an out-of-range payload size
      CVE-2026-72015: fs/resctrl: Fix double-add of pseudo-locked region's RMID to free list
      CVE-2026-72019: macsec: don't read an unset MAC header in macsec_encrypt()
      CVE-2026-72020: ipvs: reset full ip_vs_seq structs in ip_vs_conn_new
      CVE-2026-72021: ipvs: use parsed transport offset in SCTP state lookup
      CVE-2026-72022: llc: fix SAP refcount leak in llc_ui_autobind()
      CVE-2026-72024: mac802154: remove interfaces with RCU list deletion
      CVE-2026-72025: s390/monwriter: Reject buffer reuse with different data length
      CVE-2026-72033: orangefs: keep the readdir entry size 64-bit in fill_from_part()
      CVE-2026-72036: net/sched: sch_multiq: Replace direct dequeue call with peek and qdisc_dequeue_peeked
      CVE-2026-72038: net: liquidio: fix BAR resource leak on PF number failure
      CVE-2026-72039: bnx2x: fix potential memory leak in bnx2x_alloc_mem_bp()
      CVE-2026-72047: ieee802154: ca8210: fix pointer truncation in kfifo on 64-bit
      CVE-2026-72048: ieee802154: ca8210: fix cas_ctl leak on spi_async failure
      CVE-2026-72049: ieee802154: admin-gate legacy LLSEC dump operations
      CVE-2026-72051: net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink
      CVE-2026-72052: net: ip6_gre: require CAP_NET_ADMIN in the device netns for changelink
      CVE-2026-72053: net: ipip: require CAP_NET_ADMIN in the device netns for changelink
      CVE-2026-72054: net: ip_vti: require CAP_NET_ADMIN in the device netns for changelink
      CVE-2026-72055: net: ip6_vti: require CAP_NET_ADMIN in the device netns for changelink
      CVE-2026-72061: net: sit: require CAP_NET_ADMIN in the device netns for changelink
      CVE-2026-72066: cpu: hotplug: Bound hotplug states sysfs output
      CVE-2026-72067: cpu: hotplug: Preserve per instance callback errors
      CVE-2026-72070: wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()
      CVE-2026-72073: mmc: vub300: fix use-after-free on probe failure
      CVE-2026-72074: Input: ims-pcu - fix type confusion in CDC union descriptor parsing
      CVE-2026-72076: Input: ims-pcu - fix out-of-bounds read in ims_pcu_irq() debug logging
      CVE-2026-72078: Input: ims-pcu - validate control endpoint type
      CVE-2026-72079: Input: ims-pcu - fix use-after-free and double-free in disconnect
      CVE-2026-72083: scsi: target: core: Fix iSCSI ISID use-after-free in REGISTER AND MOVE
      CVE-2026-72096: dm-verity: make error counter atomic
      CVE-2026-72105: dm-log: fix a bitset_size overflow on 32bit machines
      CVE-2026-72107: dm era: fix out-of-bounds memory access for non-zero start sector
      CVE-2026-72108: dm thin metadata: fix metadata snapshot consistency on commit failure
      CVE-2026-72113: can: bcm: add missing device refcount for CAN filter removal
      CVE-2026-72114: can: bcm: validate frame length in bcm_rx_setup() for RTR replies
      CVE-2026-72115: can: bcm: track a single source interface for ANYDEV timeout/throttle ops
      CVE-2026-72116: can: bcm: fix stale rx/tx ops after device removal
      CVE-2026-72117: can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
      CVE-2026-72118: can: bcm: fix CAN frame rx/tx statistics
      CVE-2026-72119: can: bcm: extend bcm_tx_lock usage for data and timer updates
      CVE-2026-72120: can: bcm: add missing rcu list annotations and operations
      CVE-2026-72121: can: bcm: add locking when updating filter and timer values
      CVE-2026-72123: can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF
      CVE-2026-72135: tpm: Make the TPM character devices non-seekable
      CVE-2026-72136: xfrm: xfrm_interface: require CAP_NET_ADMIN in the device netns for changelink
      CVE-2026-72138: xen/gntdev: fix error handling in ioctl
      CVE-2026-72142: i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)
      CVE-2026-72153: irqchip/crossbar: Use correct index in crossbar_domain_free()
      CVE-2026-72157: net: thunderbolt: Fix frags[] overflow by bounding frame_count
      CVE-2026-72159: ocfs2: reject non-inline dinodes with i_size and zero i_clusters
      CVE-2026-72160: ocfs2: reject dinodes with non-canonical i_mode type
      CVE-2026-72164: ocfs2: avoid moving extents to occupied clusters
      CVE-2026-72166: net/9p: fix infinite loop in p9_client_rpc on fatal signal
      CVE-2026-72170: 9p: skip nlink update in cacheless mode to fix WARN_ON
      CVE-2026-72171: mtd: slram: remove failed entries from the device list
      CVE-2026-72181: mips: sched: Fix CPUMASK_OFFSTACK memory corruption
      CVE-2026-72215: MIPS: DEC: Ensure 32-bit stack location for o32 prom_printf()
      CVE-2026-72223: nvdimm/btt: Free arena sub-allocations on discover_arenas() error path
      CVE-2026-72224: nvdimm/btt: Free arenas on btt_init() error paths
      CVE-2026-72226: batman-adv: tt: prevent TVLV OOB check overflow
      CVE-2026-72228: batman-adv: frag: fix primary_if leak on failed linearization
      CVE-2026-72230: batman-adv: frag: free unfragmentable packet
      CVE-2026-72231: batman-adv: tt: avoid request storms during pending request
      CVE-2026-72232: batman-adv: ensure minimal ethernet header on TX
      CVE-2026-72233: batman-adv: bla: reacquire gw address after skb realloc
      CVE-2026-72234: batman-adv: access unicast_ttvn skb->data only after skb realloc
      CVE-2026-72235: batman-adv: retrieve ethhdr after potential skb realloc on RX
      CVE-2026-72238: x86/boot: Validate console=uart8250 baud rate to fix early boot hang
      CVE-2026-72240: mfd: sm501: Fix reference leak on failed device registration
      CVE-2026-72242: selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()
      CVE-2026-72245: gpu: host1x: Fix device reference leak in host1x_device_parse_dt() error path
      CVE-2026-72247: netfilter: nf_conncount: fix zone comparison in tuple dedup
      CVE-2026-72250: netfilter: nf_conntrack_reasm: guard mac_header adjustment after IPv6 defrag
      CVE-2026-72251: netfilter: nf_nat_sip: reload possible stale data pointer
      CVE-2026-72256: netfilter: xt_cluster: reject template conntracks in hash match
      CVE-2026-72265: fbdev: nvidia: fix potential memory leak in nvidiafb_probe()
      CVE-2026-72269: fbdev: uvesafb: fix potential memory leak in uvesafb_probe()
      CVE-2026-72282: KVM: Move kvm_io_bus_get_dev() locking responsibilities to callers
      CVE-2026-72289: KVM: arm64: vgic: Check the interrupt is still ours before migrating it
      CVE-2026-72296: net: ife: require ETH_HLEN to be pullable in ife_decode()
      CVE-2026-72297: net: atm: reject out-of-range traffic classes in QoS validation
      CVE-2026-72298: net: qrtr: fix 32-bit integer overflow in qrtr_endpoint_post()
      CVE-2026-72307: mlxsw: fix refcount leak in mlxsw_sp_vrs_lpm_tree_replace()
      CVE-2026-72316: dm era: fix NULL pointer dereference in metadata_open()
      CVE-2026-72319: ipvs: ensure inner headers in ICMP errors are in headroom
      CVE-2026-72322: ipv6: mcast: Fix potential UAF in MLD delayed work
      CVE-2026-72326: net/sched: cake: reject overhead values that underflow length
      CVE-2026-72339: qede: fix off-by-one in BD ring consumption on build_skb failure
      CVE-2026-72348: netfilter: ip6tables: mark malformed IPv6 extension headers for hotdrop
      CVE-2026-72349: netfilter: xt_rateest: fix u64 truncation in xt_rateest_mt()
      CVE-2026-72350: netfilter: xt_u32: reject invalid shift counts
      CVE-2026-72351: gue: validate REMCSUM private option length
      CVE-2026-72374: afs: Fix callback service message parsers to pass through -EAGAIN
      CVE-2026-72392: ipv6: fib6: fix NULL deref in fib6_walk_continue() on multi-batch dump
      CVE-2026-72396: hwmon: adm1275: Prevent reading uninitialized stack
      CVE-2026-72400: seg6: validate SRH length before reading fixed fields
      CVE-2026-72406: net: sungem: fix probe error cleanup
      CVE-2026-72409: net: mvneta: re-enable percpu interrupt on resume
      CVE-2026-72418: netfilter: nf_conncount: prevent connlimit drops for early confirmed ct
      CVE-2026-72421: ipv4: fib: Don't ignore error route in local/main tables.
      CVE-2026-72428: bpf: Fix stack slot index in nospec checks
      CVE-2026-72435: netfilter: ipset: fix order of kfree_rcu() and rcu_assign_pointer()
      CVE-2026-72441: ieee802154: fix kernel-infoleak in dgram_recvmsg()
      CVE-2026-72450: xfrm: validate selector family and prefixlen during match
      CVE-2026-72481: iio: magnetometer: ak8975: fix potential kernel stack memory leak
      CVE-2026-72483: usb: host: max3421: Fix shift-out-of-bounds in max3421_hub_control()
      CVE-2026-72484: staging: most: video: avoid double free on video register failure
      CVE-2026-72489: staging: nvec: fix use-after-free in nvec_rx_completed()
      CVE-2026-72491: net/9p: fix race condition on rdma->state in trans_rdma.c
      CVE-2026-72502: tcp: ipv6: clamp default adverting MSS to avoid GSO_BY_FRAGS (0xFFFF)
      CVE-2026-74255: tipc: fix UAF in tipc_l2_send_msg()
      CVE-2026-74262: kcm: use WRITE_ONCE() when changing lower socket callbacks
      CVE-2026-74267: net/sched: sch_codel: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
      CVE-2026-74276: spi: xilinx: use FIFO occupancy register to determine buffer size
      CVE-2026-74279: crypto: cavium/cpt - fix DMA cleanup using wrong loop index
      CVE-2026-74282: tipc: prevent snt_unacked underflow on CONN_ACK
      CVE-2026-74283: tipc: require net admin for TIPCv2 netlink mutators
      CVE-2026-74284: net/sched: sch_hfsc: Don't make class passive twice
      CVE-2026-74287: sctp: validate embedded address parameter length
      CVE-2026-74288: net: fib_rules: Don't dump dying fib_rule in fib_rules_dump().
      CVE-2026-74330: configfs: fix lockless traversals of ->s_children
      CVE-2026-74331: firmware_loader: Fix recursive lock in device_cache_fw_images()
      CVE-2026-74340: wifi: wcn36xx: fix OOB read from firmware count in PRINT_REG_INFO indication
      CVE-2026-74348: ocfs2/dlm: require a ref for locking_state debugfs open
      CVE-2026-74349: ocfs2: reject FITRIM ranges shorter than a cluster
      CVE-2026-74351: ocfs2: rebase copied fsdlm LVB pointers in locking_state
      CVE-2026-74382: net/sched: cls_bpf: prevent unbounded recursion in offload rollback
      CVE-2026-74398: ipv6: addrconf: bail out of dad_failure when state is no longer POSTDAD
      CVE-2026-74408: wifi: ath9k: fix OOB access from firmware tx status queue ID
      CVE-2026-74416: drm/radeon: fix memory leak in radeon_ring_restore() on lock failure
      CVE-2026-74427: afs: Fix netns teardown to cancel the preallocation charger
      CVE-2026-74432: rxrpc: Fix leak of released call in recvmsg(MSG_PEEK)
      CVE-2026-74436: rxrpc: serialize kernel accept preallocation with socket teardown
      CVE-2026-74453: drm/vc4: Zero the tile state data array before each BIN job
      CVE-2026-74455: can: peak_usb: validate uCAN receive record lengths
      CVE-2026-74456: can: peak_usb: peak_usb_start(): fix double free of transfer buffer on URB submit error
      CVE-2026-74457: can: peak_usb: add bounds check for USB channel index
      CVE-2026-74458: can: kvaser_usb_leaf: kvaser_usb_leaf_wait_cmd(): validate received command extents
      CVE-2026-74463: i2c: jz4780: Cache host clock rate at probe to prevent CCF prepare_lock deadlock
      CVE-2026-74464: net: openvswitch: fix skb leak on flow key update failure during ct
      CVE-2026-74469: sctp: prevent peer transport count overflow
      CVE-2026-74471: tracing: Check return value of __register_event() in trace_module_add_events()
      CVE-2026-74473: vxlan: use pskb_network_may_pull() in route_shortcircuit()
      CVE-2026-74475: vxlan: use neigh_ha_snapshot() in route_shortcircuit()
      CVE-2026-74478: um: vector: fix use-after-free in vector_mmsg_rx()
      CVE-2026-74480: net: bridge: stop fast-leave after deleting a port group
      CVE-2026-74482: mm/huge_memory: unlock i_mmap_rwsem before releasing after-split folios
      CVE-2026-74485: binfmt_misc: reject a flag character as the field delimiter
      CVE-2026-74488: wifi: mwifiex: use the subframe length when parsing A-MSDU TDLS frames
      CVE-2026-74495: igbvf: Fix leak in TX DMA error cleanup
      CVE-2026-74497: ALSA: usb-audio: Clamp frame size in implicit-feedback mode
      CVE-2026-74498: ALSA: usb-audio: Fix DMA buffer out-of-bounds write when fill_max is set
      CVE-2026-74499: ALSA: usb-audio: fix OOB write in snd_usbmidi_akai_output()
      CVE-2026-74505: ALSA: 6fire: Fix UAF at error handling during probe
      CVE-2026-74507: Bluetooth: HIDP: validate numbered report payloads
      CVE-2026-74508: Bluetooth: HIDP: reject frames without a transaction header
      CVE-2026-74512: audit: fix potential use-after-free in audit_del_rule()
      CVE-2026-74519: pinctrl: devicetree: don't free uninitialized dev_name on error path
      CVE-2026-74525: net: sxgbe: free TX rings on RX allocation failure
      CVE-2026-74547: hwmon: (adt7470) Fix busy-loop and I2C flooding in update thread
      CVE-2026-74556: scsi: libiscsi_tcp: Bound SCSI Response data segment to the connection buffer
      CVE-2026-74557: scsi: libiscsi: Fix stale-data leak into the SCSI sense buffer
      CVE-2026-74563: rds: tcp: hold the RCU lock across ipv6_chk_addr() in rds_tcp_laddr_check()
      CVE-2026-74564: netfilter: xt_hashlimit: validate hashtable supports XT_HASHLIMIT_RATE_MATCH
      CVE-2026-74569: netfilter: nf_conntrack_sip: widen NAT rewrite delta to s32 in sip_help_tcp()
      CVE-2026-74577: net: mpls: initialize rtm_tos in mpls_getroute()
      CVE-2026-74580: vhost: reset the vring metadata cache on vring reconfiguration
      CVE-2026-74583: net/sched: cls_route: fix fastmap use-after-free on filter
      CVE-2026-74585: thunderbolt: Bound the DROM dual link port number before indexing sw->ports
      CVE-2026-74586: sctp: clear new_transport when removing a peer
      CVE-2026-74587: sctp: fix use-after-free of cached ASCONF chunk
      CVE-2026-74588: sctp: keep chunk->transport in step with the list it is queued on
      CVE-2026-74597: ip6_tunnel: clear skb2->cb[] in ip6ip6_err()
      CVE-2026-74598: ipv6: fix Route Information option length validation
      CVE-2026-74609: tipc: read le->link under the node lock in tipc_node_link_down()
      CVE-2026-74613: vsock/virtio: avoid refilling the RX queue after teardown
      CVE-2026-74630: ipv6: prevent in6_dev_get() from resurrecting inet6_dev
      CVE-2026-74648: staging: rtl8723bs: validate monitor transmit frame lengths
      CVE-2026-74651: staging: rtl8723bs: fix OOB read in rtw_get_wpa_ie()
      CVE-2026-74654: serial: 8250_dma: Clear stale RX state on shutdown
      CVE-2026-74658: futex: Prevent robust futex exit race some more
      CVE-2026-74660: netfilter: ebt_nflog: pin the NFLOG backend
      CVE-2026-74664: net: openvswitch: reallocate update replies for mismatched IDs
      CVE-2026-74669: ipvs: clear IPv4 options after rebasing tunnel ICMP errors
      CVE-2026-74673: Input: evdev - fix information leak in evdev_pass_values()
      CVE-2026-74675: vt: stabilize tty reference in kbd_keycode with tty_port_tty_get
      CVE-2026-74679: usb: gadget: f_ncm: Use unsigned int for ndp_index
      CVE-2026-74680: usb: atm: cxacru: properly kill rcv_urb on error in cxacru_cm()
      CVE-2026-74682: ALSA: usb-audio: fix OOB write on Type II inbound URBs
      CVE-2026-74683: Input: evdev - sanitize event type index when fetching event masks
      CVE-2026-74688: sctp: clear control chunk transport if it is being removed
      CVE-2026-74701: net/openvswitch: check Ethernet header length in key_extract()
      CVE-2026-74704: net/sched: sch_cake: drop WARN_ON(1) for malformed packets in ACK filter
      CVE-2026-74705: udp: fix potential use-after-free in tunnel segmentation
      CVE-2026-74726: bonding: alb: re-check primary_is_promisc under RTNL in bond_alb_monitor
      CVE-2026-74730: NFS: Pin the 'struct nfs_server' during a FREE_STATEID call
      CVE-2026-43499: rtmutex: Use waiter::task instead of current in remove_waiter()
      CVE-2026-46116: xfrm: defensively unhash xfrm_state lists in __xfrm_state_delete
      CVE-2026-52942: netfilter: nf_log: validate MAC header was set before dumping it
      CVE-2026-53163: locking/rtmutex: Skip remove_waiter() when waiter is not enqueued
      CVE-2026-53392: NFSv4/flexfiles: reject zero filehandle version count
      CVE-2026-53399: nfsd: release layout stid on setlease failure
      CVE-2026-53400: i2c: core: fix adapter registration race
      CVE-2026-63803: hdlc_ppp: sync per-proto timers before freeing hdlc state
      CVE-2026-63806: KVM: Replace guest-triggerable BUG_ON() in ioeventfd datamatch with get_unaligned()
      CVE-2026-63818: f2fs: validate orphan inode entry count
      CVE-2026-63828: apparmor: mediate the implicit connect of TCP fast open sendmsg
      CVE-2026-63829: net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink
      CVE-2026-64189: netfilter: ipset: fix race between dump and ip_set_list resize
      CVE-2026-64266: fuse: re-lock request before returning from fuse_ref_folio()
      CVE-2026-64270: Input: mms114 - reject an oversized device packet size
      CVE-2026-64271: Input: touchwin - reset the packet index on every complete packet
      CVE-2026-64276: Input: synaptics-rmi4 - bound the F30 keymap to the GPIO/LED count
      CVE-2026-64280: fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
      CVE-2026-64298: NFSv4: include MAY_WRITE in open permission mask for O_TRUNC
      CVE-2026-64299: tracing: Prevent out-of-bounds read in glob matching
      CVE-2026-64304: crypto: qat - validate RSA CRT component lengths
      CVE-2026-64306: crypto: drbg - Fix returning success on failure in CTR_DRBG
      CVE-2026-64312: crypto: pcrypt - restore callback for non-parallel fallback
      CVE-2026-64313: crypto: ecc - Fix carry overflow in vli multiplication
      CVE-2026-64317: isofs: bound Rock Ridge symlink components to the SL record
      CVE-2026-64318: partitions: aix: bound the pp_count scan to the ppe array
      CVE-2026-64322: udf: validate sparing table length as an entry count, not a byte count
      CVE-2026-64323: udf: validate VAT header length against the VAT inode size
      CVE-2026-64324: udf: validate free block extents against the partition length
      CVE-2026-64330: usb: typec: tcpm: Validate SVID index in svdm_consume_modes()
      CVE-2026-64331: usbip: vudc: fix NULL deref in vep_dequeue()
      CVE-2026-64332: USB: ulpi: fix memory leak on registration failure
      CVE-2026-64333: USB: serial: digi_acceleport: fix write buffer corruption
      CVE-2026-64334: USB: serial: digi_acceleport: fix hard lockup on disconnect
      CVE-2026-64335: USB: serial: digi_acceleport: fix broken rx after throttle
      CVE-2026-64337: usb: mtu3: unmap request DMA on queue failure
      CVE-2026-64338: USB: misc: uss720: unregister parport on probe failure
      CVE-2026-64342: USB: iowarrior: fix use-after-free on disconnect
      CVE-2026-64343: USB: ldusb: fix use-after-free on disconnect race
      CVE-2026-64345: usb: gadget: f_printer: take kref only for successful open
      CVE-2026-64347: usb: gadget: composite: fix dead empty check in the USB_DT_OTG handler
      CVE-2026-64348: usb: free iso schedules on failed submit
      CVE-2026-64351: net: usb: kalmia: bound RX frame length in kalmia_rx_fixup()
      CVE-2026-64359: nilfs2: reject CLEAN_SEGMENTS ioctl with out-of-range segment numbers
      CVE-2026-64360: hfs/hfsplus: zero-initialize buffer in hfs_bnode_read
      CVE-2026-64361: hfs/hfsplus: fix u32 overflow in check_and_correct_requested_length
      CVE-2026-64363: HID: appleir: fix UAF on pending key_up_timer in remove()
      CVE-2026-64370: posix-cpu-timers: Fix pid refcount leak in do_cpu_nanosleep() error path
      CVE-2026-64372: cpufreq: pcc: fix use-after-free and double free in _OSC evaluation
      CVE-2026-64373: cpufreq: Fix hotplug-suspend race during reboot
      CVE-2026-64374: sched/rt: Have RT_PUSH_IPI be default off for non PREEMPT_RT
      CVE-2026-64378: writeback: fix race between cgroup_writeback_umount() and inode_switch_wbs()
      CVE-2026-64381: smb: client: Fix next buffer leak in receive_encrypted_standard()
      CVE-2026-64403: Bluetooth: L2CAP: validate option length before reading conf opt value
      CVE-2026-64406: Bluetooth: fix UAF in bt_accept_dequeue()
      CVE-2026-64408: Bluetooth: bnep: pin L2CAP connection during netdev registration
      CVE-2026-64411: netfilter: ebtables: terminate table name before find_table_lock()
      CVE-2026-64412: netfilter: ebtables: module names must be null-terminated
      CVE-2026-64422: net: ipv4: bound TCP reordering sysctl writes and MTU probe sizes
      CVE-2026-64423: ipv4: igmp: remove multicast group from hash table on device destruction
      CVE-2026-64429: gpio: eic-sprd: use raw_spinlock_t in the irq startup path
      CVE-2026-64434: Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref
      CVE-2026-64436: net: af_key: initialize alg_key_len for IPComp states
      CVE-2026-64442: staging: rtl8723bs: fix OOB reads in IE loops in issue_assocreq() and join_cmd_hdl()
      CVE-2026-64448: smb: client: restrict implied bcc[0] exemption to responses without data area
      CVE-2026-64452: 6lowpan: fix NHC entry use-after-free on error path
      CVE-2026-64455: USB: chaoskey: Fix slab-use-after-free in chaoskey_release()
      CVE-2026-64465: usb: xhci: Fix sleep in atomic context in xhci_free_streams()
      CVE-2026-64468: binder: fix UAF in binder_free_transaction()
      CVE-2026-64469: binder: fix UAF in binder_thread_release()
      CVE-2026-64470: Bluetooth: btusb: fix use-after-free on marvell probe failure
      CVE-2026-64471: Bluetooth: btusb: fix use-after-free on registration failure
      CVE-2026-64478: ALSA: usb-audio: avoid kobject path lookup in DualSense match
      CVE-2026-64483: ALSA: firewire: isight: bound the sample count to the packet payload
      CVE-2026-64484: ALSA: es1938: check snd_ctl_new1() return value
      CVE-2026-64487: ALSA: caiaq: fix out-of-bounds read in the Traktor Kontrol S4 input parser
      CVE-2026-64488: ALSA: aoa: check snd_ctl_new1() return value
      CVE-2026-64495: iio: gyro: bmg160: bail out when bandwidth/filter is not in table
      CVE-2026-64496: iio: event: Fix event FIFO reset race
      CVE-2026-64500: iio: adc: lpc32xx: Initialize completion before requesting IRQ
      CVE-2026-64503: iio: accel: kxsd9: fix runtime PM imbalance on write_raw() error
      CVE-2026-64504: iio: accel: bmc150: clamp the device-reported FIFO frame count
      CVE-2026-64505: usb: gadget: function: rndis: add length check for header
      CVE-2026-64510: ACPI: NFIT: core: Fix acpi_nfit_init() error cleanup
      CVE-2026-64589: i2c: core: fix NULL-deref on adapter registration failure
      CVE-2026-64593: btrfs: do not trim a device which is not writeable
      CVE-2026-64594: usb: gadget: f_fs: initialize reset_work at allocation time
      CVE-2026-64602: iio: adc: spear: Initialize completion before requesting IRQ
      CVE-2026-68082: libceph: fix two unsafe bare decodes in decode_lockers()
      CVE-2026-68088: usb: gadget: function: rndis: add length check to response query
      CVE-2026-68091: HID: wacom: stop hardware after post-start probe failures
      CVE-2026-68132: super: fix emergency thaw deadlock on frozen block devices
      CVE-2026-68159: libceph: bound pg_{temp,upmap,upmap_items} length to CEPH_PG_MAX_SIZE
      CVE-2026-68162: sctp: avoid auth_enable sysctl UAF during netns teardown
      CVE-2026-74479: net: pktgen: fix proc entry use-after-free
      CVE-2026-74601: ring-buffer: Use current_context for safe per-CPU buffer swap
      CVE-2026-74631: net: smc: fix splice entry lifetime imbalance in smc_rx_splice
      CVE-2026-74635: fbdev: bitblit: bound-check glyph index in bit_cursor()
      CVE-2026-74746: netfilter: flowtable: publish GC-visible tuple last
      CVE-2026-74748: netfilter: ipset: fix refcount race between list:set GC and swap
      CVE-2026-80528: ceph: avoid fs reclaim while using current->journal_info
      CVE-2026-80540: drm/amdgpu: Fix UVD decode image min size calculation
      CVE-2026-80541: drm/amdgpu: validate GEM_CREATE domain combinations
      CVE-2026-80558: libceph: Avoid using invalid osd indices from primary_temp
      CVE-2026-80561: libceph: fix multiple unsafe decodes in decode_locker()
      CVE-2026-80568: Input: synaptics-rmi4 - block s_input when F54 queue is busy
      CVE-2026-80574: Input: focaltech - fix array out-of-bounds in focaltech_process_rel_packet
      CVE-2026-80591: f2fs: fix listxattr handling of corrupted xattr entries
      CVE-2026-80593: hwmon: (asus_atk0110) Check package count before accessing element
      CVE-2026-80594: Input: ims-pcu - fix potential infinite loop in CDC union descriptor parsing
      CVE-2026-80595: Input: ims-pcu - add response length checks
      CVE-2026-80599: batman-adv: dat: ensure accessible eth_hdr proto field
      CVE-2026-80601: batman-adv: gw: acquire ethernet header only after skb realloc
      CVE-2026-80603: netfilter: nf_conntrack_irc: fix parse_dcc() off-by-one OOB read
      CVE-2026-80605: HID: picolcd: prevent NULL pointer dereference in picolcd_send_and_wait()
      CVE-2026-80619: apparmor: fix potential UAF in aa_replace_profiles
      CVE-2026-80622: char: tlclk: fix use-after-free in tlclk_cleanup()
      CVE-2026-80626: powerpc/perf: fix preempt count underflow in fsl_emb_pmu_del
      CVE-2026-80630: net/sched: sch_fq_codel: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
      CVE-2026-80644: ocfs2: don't BUG_ON an invalid journal dinode
      CVE-2026-80645: rapidio/tsi721: prevent a bad dereference in tsi721_db_dpc()
      CVE-2026-80646: ipv6: guard against possible NULL deref in __in6_dev_stats_get()
      CVE-2026-80659: mmc: vub300: defer reset until cmd_mutex is unlocked
      CVE-2026-80664: netfilter: xt_nat: reject unsupported target families
      CVE-2026-80681: vxlan: re-fetch eth header after route_shortcircuit()
      CVE-2026-80706: can: softing: fw_parse(): validate firmware record spans
      CVE-2026-80714: ipvs: do not propagate one-packet flag to synced conns
      CVE-2026-80717: sctp: validate Adaptation Indication parameter length
      CVE-2026-80718: mm/percpu-km: fix bitmap overflow and accounting in pcpu_create_chunk()
      CVE-2026-80731: net: remove CAP_SYS_RAWIO zero-padding in dev_validate_header
      CVE-2026-80732: ata: pata_sl82c105: fix bridge revision use-after-free
      CVE-2026-80733: net: remove WARN_ON_ONCE() from sk_mc_loop()
      CVE-2026-80752: Input: psxpad-spi - set driver data before use
      CVE-2026-80754: Input: synaptics-rmi4 - fix F55 transmitter electrode count typo
      CVE-2026-80757: selinux: reject a class permission count below its inherited common
      CVE-2026-80875: ipvs: use parsed transport offset in TCP state lookup
      CVE-2026-80876: ring-buffer: Fix event length with forced 8-byte alignment
      CVE-2026-80881: ocfs2: fix buffer head management in ocfs2_read_blocks()
      CVE-2026-80886: serial: msm: Disable DMA for kernel console UART
      CVE-2026-80890: sctp: reject stale cookies with mismatched verification tags
      CVE-2026-80908: drm/amdgpu: Reject UVD message with dimensions above 4096
      CVE-2026-80909: drm/amdgpu: Reject UVD message with invalid number of h265 refs

Best regards,
Ulrich Hecht

