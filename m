Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABC8CA5FF0
	for <webhook@archiver.kernel.org>; Mon,  5 Oct 2026 14:16:26 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21115.1791209784755008988
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Oct 2026 07:16:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=nBwOzJBX;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=Cnj/sUWN;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.22, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1791209758; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MHAtxmh34rTpc0jMKCn64vbM8xYHcU4hoG0F1GGrQnjFLwIGYBhiem8B73PU0AFXTu
    o+rK0TRKdXhTbVv6Rwm6+jnHKEUZanPoReJd7+ryOmqLSWZALwcLfCMFlZ02uf0tsWzo
    fAtrRLKWLJjRCfa4+cq7VmURn0qkdeleTlvgHZVzhCKinh50cGOKyNiQLWatIAIdzeuj
    v02KA37j2Clfgrscj3MbsvycJmpFUnYWV21XBRmHn+eG2z4Gtx7zOj8zrfQd9Vg/3n5Y
    Ea88PvBT7CNgvx1EWiw7Co5w/vkSfWPzVSyK6pUWpeAi0kbUnxTMKfUFY4HNbFPMx2EZ
    Oajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791209758;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=4MGbBaisg9a5NNgDKIUCrNVdsI8UkDPDWE6hlRMSvEM=;
    b=WzSEa+e35MBNkcrnoIJuv2iOmJMJHuNZqU2V1tOOqHRP58hHUzx4I35HseFIHyiu7K
    maqRTrrxgqbUrL4Dt4GoqoV7RiAHLDSlzRky8dn2rKTK6uyQDiJ/s+JEnPQul5MnzhOz
    qg+ptLNKWupYgDOpwklBgKyn1HfFJ98XBHrWMhwUvnbVpT/WVaSmEPhmVZxfK345Mnf/
    dbz3bgger/W9xOON2PXbkjkYb3z22aoHwvNiRZUxG74NbUNtdQpw5BlTwoT9FpwectK2
    piw/0CcyHqPSwYqHS14wXRw+3gAvEFlsPGEaLXon1UAgaRTk2tiRByG69Qx0IDrYJZaf
    Q8Bw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791209758;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=4MGbBaisg9a5NNgDKIUCrNVdsI8UkDPDWE6hlRMSvEM=;
    b=nBwOzJBXnwgTYPXgUd8FXTivem3f+wT8cxK/W59WlQfkYWFyCvd0WefehbpJotVHNt
    1zg8N5/iOIWost2/vZYB9r5cX7m9Vz8JdQJDUY2TqllBuGSqtvRDbzIFBjHpV3fK/tKk
    Au9gez9tA35BcmDpHijUwbyghQBGD1DeXAiwJIXZXjw2NY4WRvqpHlhfKC10Nsp6nMVw
    4vG198yopmvuakPTvZHOfOi0TD/lRB7oaVKnYaFAUD+Pgu1W1uN6b/aPGDMcptJHh4Pa
    c7rFDNSuyTKBToYqeAhfDBTNhTIKUPmMeSjk3emHRBGRLo7ySz2nwz2LR/At+prA37+r
    W7Pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791209758;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=4MGbBaisg9a5NNgDKIUCrNVdsI8UkDPDWE6hlRMSvEM=;
    b=Cnj/sUWNeNSPWerLcmyoEU4a1Qv/W5GuPH681liL8QbF/taHRZ7RZ9Cp2filYsAhRW
    C5JWdA4gdQk2hBsm7PBw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzotGZvghOuyX/LuaP4"
Received: from open-xchange-core-mw-gw-9.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.6.2 AUTH)
    with ESMTPSA id z041b2295EFwUBl
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 5 Oct 2026 16:15:58 +0200 (CEST)
Date: Mon, 5 Oct 2026 16:15:58 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1912379436.490229.1791209758430@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip115
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.154
X-Originating-Port: 40942
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Oct 2026 14:16:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24428

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip115. The linux-4.4.y-cip tree's base version has been updated to v4.4-st80. The trees are up-to-date with kernel 4.19-st20.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip115:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      ce0c89486248308598c697be9099afb301b41e53
    Fixed CVEs:
      CVE-2022-48785: ipv6: mcast: use rcu-safe version of ipv6_get_lladdr()
      CVE-2026-31408: Bluetooth: SCO: Fix use-after-free in sco_recv_frame() due to missing sock_hold
      CVE-2026-31650: mmc: vub300: fix use-after-free on disconnect
      CVE-2026-46116: xfrm: defensively unhash xfrm_state lists in __xfrm_state_delete
      CVE-2026-53392: NFSv4/flexfiles: reject zero filehandle version count
      CVE-2026-53399: nfsd: release layout stid on setlease failure
      CVE-2026-53400: i2c: core: fix adapter registration race
      CVE-2026-63806: KVM: Replace guest-triggerable BUG_ON() in ioeventfd datamatch with get_unaligned()
      CVE-2026-63829: net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink
      CVE-2026-64266: fuse: re-lock request before returning from fuse_ref_folio()
      CVE-2026-64270: Input: mms114 - reject an oversized device packet size
      CVE-2026-64271: Input: touchwin - reset the packet index on every complete packet
      CVE-2026-64298: NFSv4: include MAY_WRITE in open permission mask for O_TRUNC
      CVE-2026-64306: crypto: drbg - Fix returning success on failure in CTR_DRBG
      CVE-2026-64312: crypto: pcrypt - restore callback for non-parallel fallback
      CVE-2026-64317: isofs: bound Rock Ridge symlink components to the SL record
      CVE-2026-64318: partitions: aix: bound the pp_count scan to the ppe array
      CVE-2026-64322: udf: validate sparing table length as an entry count, not a byte count
      CVE-2026-64323: udf: validate VAT header length against the VAT inode size
      CVE-2026-64324: udf: validate free block extents against the partition length
      CVE-2026-64333: USB: serial: digi_acceleport: fix write buffer corruption
      CVE-2026-64334: USB: serial: digi_acceleport: fix hard lockup on disconnect
      CVE-2026-64335: USB: serial: digi_acceleport: fix broken rx after throttle
      CVE-2026-64342: USB: iowarrior: fix use-after-free on disconnect
      CVE-2026-64343: USB: ldusb: fix use-after-free on disconnect race
      CVE-2026-64345: usb: gadget: f_printer: take kref only for successful open
      CVE-2026-64347: usb: gadget: composite: fix dead empty check in the USB_DT_OTG handler
      CVE-2026-64348: usb: free iso schedules on failed submit
      CVE-2026-64351: net: usb: kalmia: bound RX frame length in kalmia_rx_fixup()
      CVE-2026-64363: HID: appleir: fix UAF on pending key_up_timer in remove()
      CVE-2026-64370: posix-cpu-timers: Fix pid refcount leak in do_cpu_nanosleep() error path
      CVE-2026-64372: cpufreq: pcc: fix use-after-free and double free in _OSC evaluation
      CVE-2026-64373: cpufreq: Fix hotplug-suspend race during reboot
      CVE-2026-64374: sched/rt: Have RT_PUSH_IPI be default off for non PREEMPT_RT
      CVE-2026-64378: writeback: fix race between cgroup_writeback_umount() and inode_switch_wbs()
      CVE-2026-64403: Bluetooth: L2CAP: validate option length before reading conf opt value
      CVE-2026-64406: Bluetooth: fix UAF in bt_accept_dequeue()
      CVE-2026-64408: Bluetooth: bnep: pin L2CAP connection during netdev registration
      CVE-2026-64411: netfilter: ebtables: terminate table name before find_table_lock()
      CVE-2026-64423: ipv4: igmp: remove multicast group from hash table on device destruction
      CVE-2026-64434: Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref
      CVE-2026-64436: net: af_key: initialize alg_key_len for IPComp states
      CVE-2026-64448: smb: client: restrict implied bcc[0] exemption to responses without data area
      CVE-2026-64452: 6lowpan: fix NHC entry use-after-free on error path
      CVE-2026-64455: USB: chaoskey: Fix slab-use-after-free in chaoskey_release()
      CVE-2026-64465: usb: xhci: Fix sleep in atomic context in xhci_free_streams()
      CVE-2026-64471: Bluetooth: btusb: fix use-after-free on registration failure
      CVE-2026-64483: ALSA: firewire: isight: bound the sample count to the packet payload
      CVE-2026-64484: ALSA: es1938: check snd_ctl_new1() return value
      CVE-2026-64487: ALSA: caiaq: fix out-of-bounds read in the Traktor Kontrol S4 input parser
      CVE-2026-64488: ALSA: aoa: check snd_ctl_new1() return value
      CVE-2026-64496: iio: event: Fix event FIFO reset race
      CVE-2026-64504: iio: accel: bmc150: clamp the device-reported FIFO frame count
      CVE-2026-64505: usb: gadget: function: rndis: add length check for header
      CVE-2026-64540: usbnet: gl620a: fix out-of-bounds read in genelink_rx_fixup()
      CVE-2026-64544: crypto: asymmetric_keys - fix OOB read in pefile_digest_pe_contents
      CVE-2026-64547: net: usb: net1080: validate packet_len before pad-byte access in rx_fixup
      CVE-2026-64551: sctp: validate STALE_COOKIE cause length before reading staleness
      CVE-2026-64564: sctp: don't free the ASCONF's own transport in DEL-IP processing
      CVE-2026-64565: Input: ims-pcu - fix heap-buffer-overflow in ims_pcu_process_data()
      CVE-2026-64571: wifi: p54: validate RX frame length in p54_rx_eeprom_readback()
      CVE-2026-64572: ipv4: fib: free fib_alias with kfree_rcu() on insert error path
      CVE-2026-64583: usb: gadget: udc: bdc: free IRQ and drain func_wake_notify before teardown
      CVE-2026-64593: btrfs: do not trim a device which is not writeable
      CVE-2026-64594: usb: gadget: f_fs: initialize reset_work at allocation time
      CVE-2026-64602: iio: adc: spear: Initialize completion before requesting IRQ
      CVE-2026-68088: usb: gadget: function: rndis: add length check to response query
      CVE-2026-68121: pppoe: reload header pointer after dev_hard_header()
      CVE-2026-68125: mac802154: llsec: reject frames shorter than the authentication tag
      CVE-2026-68137: net/x25: fix use-after-free in x25_kill_by_neigh()
      CVE-2026-68140: net/iucv: fix use-after-free of a severed iucv_path
      CVE-2026-68141: net/af_iucv: fix NULL deref in afiucv_hs_callback_syn()
      CVE-2026-68144: phonet: pep: fix use-after-free in pep_get_sb()
      CVE-2026-68146: ftrace: Add global mutex to serialize trace_parser access
      CVE-2026-68151: binfmt_elf_fdpic: only honour the first PT_INTERP
      CVE-2026-68153: libceph: remove debugfs files before client teardown
      CVE-2026-68154: libceph: reject zero bucket types in crush_decode
      CVE-2026-68156: libceph: refresh auth->authorizer_buf{,_len} after authorizer update
      CVE-2026-68158: libceph: Fix multiplication overflow in decode_new_up_state_weight()
      CVE-2026-68160: ceph: fix pre-auth out-of-bounds read on snaptrace in ceph_handle_caps()
      CVE-2026-68162: sctp: avoid auth_enable sysctl UAF during netns teardown
      CVE-2026-68175: tracing: Fix resource leak on mmiotrace trace_pipe close
      CVE-2026-68176: tracing: Fix mmiotrace possible NULL dereferencing of hiter->dev
      CVE-2026-68182: comedi: comedi_parport: deal with premature interrupt
      CVE-2026-68184: cdrom: fix stack out-of-bounds read in CDROMVOLCTRL
      CVE-2026-68188: Bluetooth: RFCOMM: Fix session UAF in set_termios
      CVE-2026-68192: wifi: brcmfmac: make release_scratchbuffers idempotent
      CVE-2026-68197: wifi: mwifiex: fix NULL dereference when the AP has HT-cap but no HT-oper
      CVE-2026-68198: wifi: ath6kl: fix use-after-free in aggr_reset_state()
      CVE-2026-68199: wifi: ath6kl: fix OOB access from firmware ADDBA window size
      CVE-2026-68202: ALSA: seq: close a re-opened queue timer in the destructor
      CVE-2026-68204: media: vivid: check for vb2_is_busy() when toggling caps
      CVE-2026-68213: media: rtl2832_sdr: Return queued buffers on start_streaming() failure
      CVE-2026-68215: media: radio-si476x: Unregister v4l2_device on probe failure
      CVE-2026-68216: media: pwc: Return queued buffers on start_streaming() failure
      CVE-2026-68217: media: pwc: Drain fill_buf on start_streaming() failure
      CVE-2026-68218: media: pci: dm1105: Free allocated workqueue
      CVE-2026-68222: media: msi2500: Return queued buffers on start_streaming() failure
      CVE-2026-68226: media: cx23885: add ioremap return check and cleanup
      CVE-2026-68231: media: airspy: Return queued buffers on start_streaming() failure
      CVE-2026-68277: drm/dp/mst: fix OOB reads on 2-byte fields in sideband reply parsers
      CVE-2026-68278: drm/dp/mst: fix buffer overflows in sideband chunk accumulation
      CVE-2026-68279: drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply parsers
      CVE-2026-68299: vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for Geneve packets
      CVE-2026-68300: sctp: auth: verify auth requirement when auth_chunk is NULL
      CVE-2026-68313: tipc: fix infinite loop in __tipc_nl_compat_dumpit
      CVE-2026-68320: sctp: fix auth_chunk_list capacity check in sctp_auth_ep_add_chunkid
      CVE-2026-68326: wifi: mwifiex: bound uAP association event IEs to the event buffer
      CVE-2026-68327: wan: wanxl: Only reset hardware after BAR mapping
      CVE-2026-68335: rds: drop incoming messages that cross network namespace boundaries
      CVE-2026-68338: net/packet: avoid fanout hook re-registration after unregister
      CVE-2026-68344: usb: atm: ueagle-atm: reject descriptors that confuse probe and disconnect
      CVE-2026-68350: wifi: carl9170: fix OOB read from off-by-two in TX status handler
      CVE-2026-68351: wifi: carl9170: bound memcpy length in cmd callback to prevent OOB read
      CVE-2026-68352: wifi: ath6kl: fix OOB read from firmware IE lengths in connect event
      CVE-2026-68353: wifi: ath6kl: fix OOB read from firmware num_msg in TX complete handler
      CVE-2026-68354: firewire: net: Fix fragmented datagram reassembly
      CVE-2026-68363: wifi: ath9k: hif_usb: don't dereference hif_dev after re-arming firmware request
      CVE-2026-68365: USB: serial: io_edgeport: cap received transmit credits
      CVE-2026-68366: usb: gadget: uvc: clamp SEND_RESPONSE length to the response buffer
      CVE-2026-68370: usb: gadget: dummy_hcd: prevent fifo_req reuse during giveback
      CVE-2026-68373: wifi: at76c50x-usb: avoid length underflow in at76_guess_freq()
      CVE-2026-68376: sctp: fix auth_hmacs array size in struct sctp_cookie
      CVE-2026-68397: net/iucv: take a reference on the socket found in afiucv_hs_rcv()
      CVE-2026-68403: wifi: brcmfmac: initialize SDIO data work before cleanup
      CVE-2026-68410: wifi: libertas: fix memory leak in helper_firmware_cb()
      CVE-2026-68413: wifi: ipw2100: fix potential memory leak in ipw2100_pci_init_one()
      CVE-2026-68425: IB/mad: Drop unmatched RMPP responses before reassembly
      CVE-2026-68428: KVM: x86/mmu: Fix use-after-free on vendor module reload
      CVE-2026-68433: libceph: bound get_version reply decode to front len
      CVE-2026-68449: ata: sata_dwc_460ex: fix infinite loop in NCQ tag completion bit-scanning
      CVE-2026-68456: usb: atm: ueagle-atm: wait for pre-firmware load in .disconnect()
      CVE-2026-68469: wifi: mwifiex: fix permanently busy scans after multiple roam iterations
      CVE-2026-68474: powerpc/spufs: fix out-of-bounds access in spufs_mem_mmap_access()
      CVE-2026-68475: reset: sunxi: fix memory region leak on ioremap failure
      CVE-2026-68478: memstick: ms_block: reject a card that reports too many blocks
      CVE-2026-68479: Bluetooth: btrtl: validate firmware patch bounds
      CVE-2026-72005: wifi: rt2x00: avoid full teardown before work setup in probe
      CVE-2026-72010: cgroup/cpuset: rebind mm mempolicy to effective_mems, not mems_allowed
      CVE-2026-72014: drbd: reject data replies with an out-of-range payload size
      CVE-2026-72020: ipvs: reset full ip_vs_seq structs in ip_vs_conn_new
      CVE-2026-72021: ipvs: use parsed transport offset in SCTP state lookup
      CVE-2026-72022: llc: fix SAP refcount leak in llc_ui_autobind()
      CVE-2026-72024: mac802154: remove interfaces with RCU list deletion
      CVE-2026-72025: s390/monwriter: Reject buffer reuse with different data length
      CVE-2026-72036: net/sched: sch_multiq: Replace direct dequeue call with peek and qdisc_dequeue_peeked
      CVE-2026-72039: bnx2x: fix potential memory leak in bnx2x_alloc_mem_bp()
      CVE-2026-72049: ieee802154: admin-gate legacy LLSEC dump operations
      CVE-2026-72051: net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink
      CVE-2026-72053: net: ipip: require CAP_NET_ADMIN in the device netns for changelink
      CVE-2026-72054: net: ip_vti: require CAP_NET_ADMIN in the device netns for changelink
      CVE-2026-72055: net: ip6_vti: require CAP_NET_ADMIN in the device netns for changelink
      CVE-2026-72061: net: sit: require CAP_NET_ADMIN in the device netns for changelink
      CVE-2026-72070: wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()
      CVE-2026-72074: Input: ims-pcu - fix type confusion in CDC union descriptor parsing
      CVE-2026-72076: Input: ims-pcu - fix out-of-bounds read in ims_pcu_irq() debug logging
      CVE-2026-72078: Input: ims-pcu - validate control endpoint type
      CVE-2026-72079: Input: ims-pcu - fix use-after-free and double-free in disconnect
      CVE-2026-72083: scsi: target: core: Fix iSCSI ISID use-after-free in REGISTER AND MOVE
      CVE-2026-72105: dm-log: fix a bitset_size overflow on 32bit machines
      CVE-2026-72107: dm era: fix out-of-bounds memory access for non-zero start sector
      CVE-2026-72108: dm thin metadata: fix metadata snapshot consistency on commit failure
      CVE-2026-72113: can: bcm: add missing device refcount for CAN filter removal
      CVE-2026-72138: xen/gntdev: fix error handling in ioctl
      CVE-2026-72142: i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)
      CVE-2026-72153: irqchip/crossbar: Use correct index in crossbar_domain_free()
      CVE-2026-72159: ocfs2: reject non-inline dinodes with i_size and zero i_clusters
      CVE-2026-72164: ocfs2: avoid moving extents to occupied clusters
      CVE-2026-72171: mtd: slram: remove failed entries from the device list
      CVE-2026-72181: mips: sched: Fix CPUMASK_OFFSTACK memory corruption
      CVE-2026-72215: MIPS: DEC: Ensure 32-bit stack location for o32 prom_printf()
      CVE-2026-72223: nvdimm/btt: Free arena sub-allocations on discover_arenas() error path
      CVE-2026-72226: batman-adv: tt: prevent TVLV OOB check overflow
      CVE-2026-72231: batman-adv: tt: avoid request storms during pending request
      CVE-2026-72232: batman-adv: ensure minimal ethernet header on TX
      CVE-2026-72234: batman-adv: access unicast_ttvn skb->data only after skb realloc
      CVE-2026-72235: batman-adv: retrieve ethhdr after potential skb realloc on RX
      CVE-2026-72238: x86/boot: Validate console=uart8250 baud rate to fix early boot hang
      CVE-2026-72240: mfd: sm501: Fix reference leak on failed device registration
      CVE-2026-72245: gpu: host1x: Fix device reference leak in host1x_device_parse_dt() error path
      CVE-2026-72250: netfilter: nf_conntrack_reasm: guard mac_header adjustment after IPv6 defrag
      CVE-2026-72251: netfilter: nf_nat_sip: reload possible stale data pointer
      CVE-2026-72256: netfilter: xt_cluster: reject template conntracks in hash match
      CVE-2026-72265: fbdev: nvidia: fix potential memory leak in nvidiafb_probe()
      CVE-2026-72269: fbdev: uvesafb: fix potential memory leak in uvesafb_probe()
      CVE-2026-72297: net: atm: reject out-of-range traffic classes in QoS validation
      CVE-2026-72316: dm era: fix NULL pointer dereference in metadata_open()
      CVE-2026-72319: ipvs: ensure inner headers in ICMP errors are in headroom
      CVE-2026-72322: ipv6: mcast: Fix potential UAF in MLD delayed work
      CVE-2026-72348: netfilter: ip6tables: mark malformed IPv6 extension headers for hotdrop
      CVE-2026-72350: netfilter: xt_u32: reject invalid shift counts
      CVE-2026-72351: gue: validate REMCSUM private option length
      CVE-2026-72392: ipv6: fib6: fix NULL deref in fib6_walk_continue() on multi-batch dump
      CVE-2026-72406: net: sungem: fix probe error cleanup
      CVE-2026-72421: ipv4: fib: Don't ignore error route in local/main tables.
      CVE-2026-72435: netfilter: ipset: fix order of kfree_rcu() and rcu_assign_pointer()
      CVE-2026-72441: ieee802154: fix kernel-infoleak in dgram_recvmsg()
      CVE-2026-72450: xfrm: validate selector family and prefixlen during match
      CVE-2026-72483: usb: host: max3421: Fix shift-out-of-bounds in max3421_hub_control()
      CVE-2026-72489: staging: nvec: fix use-after-free in nvec_rx_completed()
      CVE-2026-74276: spi: xilinx: use FIFO occupancy register to determine buffer size
      CVE-2026-74282: tipc: prevent snt_unacked underflow on CONN_ACK
      CVE-2026-74284: net/sched: sch_hfsc: Don't make class passive twice
      CVE-2026-74287: sctp: validate embedded address parameter length
      CVE-2026-74331: firmware_loader: Fix recursive lock in device_cache_fw_images()
      CVE-2026-74348: ocfs2/dlm: require a ref for locking_state debugfs open
      CVE-2026-74349: ocfs2: reject FITRIM ranges shorter than a cluster
      CVE-2026-74351: ocfs2: rebase copied fsdlm LVB pointers in locking_state
      CVE-2026-74398: ipv6: addrconf: bail out of dad_failure when state is no longer POSTDAD
      CVE-2026-74408: wifi: ath9k: fix OOB access from firmware tx status queue ID
      CVE-2026-74416: drm/radeon: fix memory leak in radeon_ring_restore() on lock failure
      CVE-2026-74456: can: peak_usb: peak_usb_start(): fix double free of transfer buffer on URB submit error
      CVE-2026-74457: can: peak_usb: add bounds check for USB channel index
      CVE-2026-74458: can: kvaser_usb_leaf: kvaser_usb_leaf_wait_cmd(): validate received command extents
      CVE-2026-74463: i2c: jz4780: Cache host clock rate at probe to prevent CCF prepare_lock deadlock
      CVE-2026-74464: net: openvswitch: fix skb leak on flow key update failure during ct
      CVE-2026-74469: sctp: prevent peer transport count overflow
      CVE-2026-74471: tracing: Check return value of __register_event() in trace_module_add_events()
      CVE-2026-74473: vxlan: use pskb_network_may_pull() in route_shortcircuit()
      CVE-2026-74475: vxlan: use neigh_ha_snapshot() in route_shortcircuit()
      CVE-2026-74479: net: pktgen: fix proc entry use-after-free
      CVE-2026-74480: net: bridge: stop fast-leave after deleting a port group
      CVE-2026-74495: igbvf: Fix leak in TX DMA error cleanup
      CVE-2026-74497: ALSA: usb-audio: Clamp frame size in implicit-feedback mode
      CVE-2026-74498: ALSA: usb-audio: Fix DMA buffer out-of-bounds write when fill_max is set
      CVE-2026-74499: ALSA: usb-audio: fix OOB write in snd_usbmidi_akai_output()
      CVE-2026-74507: Bluetooth: HIDP: validate numbered report payloads
      CVE-2026-74508: Bluetooth: HIDP: reject frames without a transaction header
      CVE-2026-74512: audit: fix potential use-after-free in audit_del_rule()
      CVE-2026-74519: pinctrl: devicetree: don't free uninitialized dev_name on error path
      CVE-2026-74525: net: sxgbe: free TX rings on RX allocation failure
      CVE-2026-74547: hwmon: (adt7470) Fix busy-loop and I2C flooding in update thread
      CVE-2026-74556: scsi: libiscsi_tcp: Bound SCSI Response data segment to the connection buffer
      CVE-2026-74557: scsi: libiscsi: Fix stale-data leak into the SCSI sense buffer
      CVE-2026-74569: netfilter: nf_conntrack_sip: widen NAT rewrite delta to s32 in sip_help_tcp()
      CVE-2026-74583: net/sched: cls_route: fix fastmap use-after-free on filter
      CVE-2026-74585: thunderbolt: Bound the DROM dual link port number before indexing sw->ports
      CVE-2026-74586: sctp: clear new_transport when removing a peer
      CVE-2026-74587: sctp: fix use-after-free of cached ASCONF chunk
      CVE-2026-74588: sctp: keep chunk->transport in step with the list it is queued on
      CVE-2026-74597: ip6_tunnel: clear skb2->cb[] in ip6ip6_err()
      CVE-2026-74598: ipv6: fix Route Information option length validation
      CVE-2026-74601: ring-buffer: Use current_context for safe per-CPU buffer swap
      CVE-2026-74609: tipc: read le->link under the node lock in tipc_node_link_down()
      CVE-2026-74630: ipv6: prevent in6_dev_get() from resurrecting inet6_dev
      CVE-2026-74635: fbdev: bitblit: bound-check glyph index in bit_cursor()
      CVE-2026-74654: serial: 8250_dma: Clear stale RX state on shutdown
      CVE-2026-74660: netfilter: ebt_nflog: pin the NFLOG backend
      CVE-2026-74664: net: openvswitch: reallocate update replies for mismatched IDs
      CVE-2026-74669: ipvs: clear IPv4 options after rebasing tunnel ICMP errors
      CVE-2026-74675: vt: stabilize tty reference in kbd_keycode with tty_port_tty_get
      CVE-2026-74679: usb: gadget: f_ncm: Use unsigned int for ndp_index
      CVE-2026-74680: usb: atm: cxacru: properly kill rcv_urb on error in cxacru_cm()
      CVE-2026-74682: ALSA: usb-audio: fix OOB write on Type II inbound URBs
      CVE-2026-74683: Input: evdev - sanitize event type index when fetching event masks
      CVE-2026-74688: sctp: clear control chunk transport if it is being removed
      CVE-2026-74726: bonding: alb: re-check primary_is_promisc under RTNL in bond_alb_monitor
      CVE-2026-74730: NFS: Pin the 'struct nfs_server' during a FREE_STATEID call
      CVE-2026-74748: netfilter: ipset: fix refcount race between list:set GC and swap
      CVE-2026-80540: drm/amdgpu: Fix UVD decode image min size calculation
      CVE-2026-80558: libceph: Avoid using invalid osd indices from primary_temp
      CVE-2026-80574: Input: focaltech - fix array out-of-bounds in focaltech_process_rel_packet
      CVE-2026-80593: hwmon: (asus_atk0110) Check package count before accessing element
      CVE-2026-80594: Input: ims-pcu - fix potential infinite loop in CDC union descriptor parsing
      CVE-2026-80595: Input: ims-pcu - add response length checks
      CVE-2026-80599: batman-adv: dat: ensure accessible eth_hdr proto field
      CVE-2026-80601: batman-adv: gw: acquire ethernet header only after skb realloc
      CVE-2026-80603: netfilter: nf_conntrack_irc: fix parse_dcc() off-by-one OOB read
      CVE-2026-80605: HID: picolcd: prevent NULL pointer dereference in picolcd_send_and_wait()
      CVE-2026-80622: char: tlclk: fix use-after-free in tlclk_cleanup()
      CVE-2026-80626: powerpc/perf: fix preempt count underflow in fsl_emb_pmu_del
      CVE-2026-80644: ocfs2: don't BUG_ON an invalid journal dinode
      CVE-2026-80645: rapidio/tsi721: prevent a bad dereference in tsi721_db_dpc()
      CVE-2026-80659: mmc: vub300: defer reset until cmd_mutex is unlocked
      CVE-2026-80664: netfilter: xt_nat: reject unsupported target families
      CVE-2026-80681: vxlan: re-fetch eth header after route_shortcircuit()
      CVE-2026-80706: can: softing: fw_parse(): validate firmware record spans
      CVE-2026-80714: ipvs: do not propagate one-packet flag to synced conns
      CVE-2026-80717: sctp: validate Adaptation Indication parameter length
      CVE-2026-80731: net: remove CAP_SYS_RAWIO zero-padding in dev_validate_header
      CVE-2026-80732: ata: pata_sl82c105: fix bridge revision use-after-free
      CVE-2026-80757: selinux: reject a class permission count below its inherited common
      CVE-2026-80875: ipvs: use parsed transport offset in TCP state lookup
      CVE-2026-80876: ring-buffer: Fix event length with forced 8-byte alignment
      CVE-2026-80881: ocfs2: fix buffer head management in ocfs2_read_blocks()
      CVE-2026-80886: serial: msm: Disable DMA for kernel console UART
      CVE-2026-80890: sctp: reject stale cookies with mismatched verification tags
      CVE-2026-80909: drm/amdgpu: Reject UVD message with invalid number of h265 refs

Best regards,
Ulrich Hecht

