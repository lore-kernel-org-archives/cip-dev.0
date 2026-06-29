Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BD4C43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 10:35:02 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.89301.1782729301439259466
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 03:35:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=VQdHwhYv;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=vH02V/wP;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.24, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1782729275; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=b5+gsJNm8lpJd8Zv9l1q7bvIdoyZCiT27RbsZQB9+OXavP+VcSprKRkj+0kt5xHfxF
    ZbBnjHlNuykl4B5qVsqLAeCa/RMiHxXyZqAXtISeATHVTAambh3lgqpNKqm8xVAKwzMU
    t7XOvpkbyP0b+KM3pWwmTOBKsQQ1GGUKx+yosmecrpmAdEuIILkw7Es/3dlE6zxCgO5A
    zWlZqmCpPs9FbpqfrGnbYY586g8h1LKclBuJ30kmceTOT57NPD35KWMFcUIh8CMy62+I
    05V1zFpEYeBr7cODZDoiHsrlBheKL4ZAES0dRN0q6knXTRlCkVsCDDenot1oc7IrrWRj
    ZSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1782729275;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=120/J5afTodsAWxtf7QXTimvd9Ss7powQpicbPbElb8=;
    b=BHKQ58cqoHtakagW11+oL4JbWn881ZV4XuVnwjDoTGTtf/8p/DrakMGsd+WGXV0XnM
    p8oCtf0Ejzz8fMgvwXIT5VIvyxTUqExP8wPSykeaq7WY6gmtRZEXc5h/iAhLu5s3IvKe
    qCDbgziXumkSJa4u4K6K2EFL6GWK4MF7TiBh62T9mZk7lb3mA0NftaF7F/BWG0YhY1XH
    frnUn5mlKvwxe8UE6Gd6dtDCLnSgAcSHbRRcA4kn54aX/LcfKfc2unzyPQOmOp02rrWJ
    1md/DLzduKD1SbRcp7agbrZrTnBBj7SVsB5z/YqDLnbbeaFN4fQTNIlVOo1RFlyH4P/B
    dJhw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1782729275;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=120/J5afTodsAWxtf7QXTimvd9Ss7powQpicbPbElb8=;
    b=VQdHwhYvHrZ0ET4yq7/DnG9BindCO6Wp8Z1aYG06T/W4PACVa/ZWGK7UNe7LiH1tIj
    ZYJy8ZvKlNvTZy1MJi2sPFLMvNeoDEqytweKQL0nq4A3k2m8HVZND156HF0cTUgxLgSB
    /Vbb99wXGtR0ysUab9B88vMRryVjZJ0KrrgTv0Z47I4I9bQg/Xy63w4daOUEZsLXvbvR
    sQpcZMKNmVz40Ab9wNuZXfwp0YwdnwMoIloxjBB+3At06zfCVAbgMS6b70TwMntXWTyA
    oR9OQTQ2NCm6RtL8kV5M/ZxfMf6YIIgAD2OLMICCpe0UjY+oL0TUzTw8So92uEvbr3ce
    fqYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1782729275;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=120/J5afTodsAWxtf7QXTimvd9Ss7powQpicbPbElb8=;
    b=vH02V/wPFIXLgWn9TEbxPLTJRbL1Xrydyi1gHx2sn96+iSRYcss7igDRAOfIT18F4Q
    FIXaRD1Cf6A1FLzHuhCw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKHE+Dw/YsQ="
Received: from open-xchange-core-mw-gw-21.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.5.6 AUTH)
    with ESMTPSA id z4c16d25TAYYHnT
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 29 Jun 2026 12:34:34 +0200 (CEST)
Date: Mon, 29 Jun 2026 12:34:34 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1029449999.62165.1782729274698@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.19.325-cip134
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.142
X-Originating-Port: 48214
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 10:35:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23301

Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip134. The linux-4.19.y-cip tree's base version has been updated to v4.19-st18. The trees are up-to-date with kernel 5.10.258.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/

  v4.19.325-cip134:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      774e9597d38ad0d067a1d50e502503224b74f9f5
    Fixed CVEs:
      CVE-2026-45981: s390/cio: Fix device lifecycle handling in css_alloc_subchannel()
      CVE-2021-47188: scsi: ufs: core: Improve SCSI abort handling
      CVE-2022-50073: net: tap: NULL pointer derefence in dev_parse_header_protocol when skb->dev is null
      CVE-2022-50552: blk-mq: use quiesced elevator switch when reinitializing queues
      CVE-2024-53213: net: usb: lan78xx: Fix double free issue with interrupt buffer allocation
      CVE-2025-38710: gfs2: Validate i_depth for exhash directories
      CVE-2026-23442: ipv6: add NULL checks for idev in SRv6 paths
      CVE-2026-23444: wifi: mac80211: always free skb on ieee80211_tx_prepare_skb() failure
      CVE-2026-31532: can: raw: fix ro->uniq use-after-free in raw_rcv()
      CVE-2026-31576: media: hackrf: fix to not free memory after the device is registered in hackrf_probe()
      CVE-2026-31577: nilfs2: fix NULL i_assoc_inode dereference in nilfs_mdt_save_to_shadow_map
      CVE-2026-31578: media: as102: fix to not free memory after the device is registered in as102_usb_probe()
      CVE-2026-31580: bcache: fix cached_dev.sb_bio use-after-free and crash
      CVE-2026-31581: ALSA: 6fire: fix use-after-free on disconnect
      CVE-2026-31583: media: em28xx: fix use-after-free in em28xx_v4l2_open()
      CVE-2026-31586: KVM: SEV: Protect *all* of sev_mem_enc_register_region() with kvm->lock
      CVE-2026-31588: KVM: x86: Use scratch field in MMIO fragment to hold small write values
      CVE-2026-31596: ocfs2: handle invalid dinode in ocfs2_group_extend
      CVE-2026-31597: ocfs2: fix use-after-free in ocfs2_fault() when VM_FAULT_RETRY
      CVE-2026-31598: ocfs2: fix possible deadlock between unlink and dio_end_io_write
      CVE-2026-31602:  ALSA: ctxfi: Limit PTP to a single page
      CVE-2026-31605: fbdev: udlfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
      CVE-2026-31607:  usbip: validate number_of_packets in usbip_pack_ret_submit()
      CVE-2026-31615: usb: gadget: renesas_usb3: validate endpoint index in standard request handlers
      CVE-2026-31616: usb: gadget: f_phonet: fix skb frags[] overflow in pn_rx_complete()
      CVE-2026-31617: usb: gadget: f_ncm: validate minimum block_len in ncm_unwrap_ntb()
      CVE-2026-31618: fbdev: tdfxfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
      CVE-2026-31619: ALSA: fireworks: bound device-supplied status before string array lookup
      CVE-2026-31622: NFC: digital: Bounds check NFC-A cascade depth in SDD response handler
      CVE-2026-31623: net: usb: cdc-phonet: fix skb frags[] overflow in rx_complete()
      CVE-2026-31624: HID: core: clamp report_size in s32ton() to avoid undefined shift
      CVE-2026-31625: HID: alps: fix NULL pointer dereference in alps_raw_event()
      CVE-2026-31626: staging: rtl8723bs: initialize le_tmp64 in rtw_BIP_verify()
      CVE-2026-31627: i2c: s3c24xx: check the size of the SMBUS message before using it
      CVE-2026-31629: nfc: llcp: add missing return after LLCP_CLOSED checks
      CVE-2026-31630: rxrpc: proc: size address buffers for %pISpc output
      CVE-2026-31634: rxrpc: fix reference count leak in rxrpc_server_keyring()
      CVE-2026-31637: rxrpc: reject undecryptable rxkad response tickets
      CVE-2026-31642: rxrpc: Fix call removal to use RCU safe deletion
      CVE-2026-31657: batman-adv: hold claim backbone gateways by reference
      CVE-2026-31664: xfrm: clear trailing padding in build_polexpire()
      CVE-2026-31673: af_unix: read UNIX_DIAG_VFS data under unix_state_lock
      CVE-2026-31681: netfilter: xt_multiport: validate range encoding in checkentry
      CVE-2026-31684: net: sched: act_csum: validate nested VLAN headers
      CVE-2026-31685: netfilter: ip6t_eui64: reject invalid MAC header for all packets
      CVE-2026-31686: mm/kasan: fix double free for kasan pXds
      CVE-2026-31696: rxrpc: Fix missing validation of ticket length in non-XDR key preparsing
      CVE-2026-31698: crypto: ccp: Don't attempt to copy PDH cert to userspace if PSP command failed
      CVE-2026-31699: crypto: ccp: Don't attempt to copy CSR to userspace if PSP command failed
      CVE-2026-31701: ALSA: caiaq: take a reference on the USB device in create_card()
      CVE-2026-43080: l2tp: Drop large packets with UDP encap
      CVE-2026-43085: netfilter: nfnetlink_log: initialize nfgenmsg in NLMSG_DONE terminator
      CVE-2026-43089: xfrm_user: fix info leak in build_mapping()
      CVE-2026-43093: xsk: tighten UMEM headroom validation to account for tailroom and min frame
      CVE-2026-43104: drm/vc4: Fix a memory leak in hang state error path
      CVE-2026-43105: drm/vc4: Fix memory leak of BO array in hang state
      CVE-2026-43493: crypto: pcrypt - Fix handling of MAY_BACKLOG requests
      CVE-2026-43496: net/sched: sch_red: Replace direct dequeue call with peek and qdisc_dequeue_peeked
      CVE-2026-43502: net/rds: handle zerocopy send cleanup before the message is queued
      CVE-2026-45834: Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_state_change_cb()
      CVE-2026-45835: Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_new_connection_cb()
      CVE-2026-45836: Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
      CVE-2026-45838: bpf: fix end-of-list detection in cgroup_storage_get_next_key()
      CVE-2026-45840: openvswitch: cap upcall PID array size and pre-size vport replies
      CVE-2026-45841: netfilter: nfnetlink_osf: fix divide-by-zero in OSF_WSS_MODULO
      CVE-2026-45842: slip: reject VJ receive packets on instances with no rstate array
      CVE-2026-45843: slip: bound decode() reads against the compressed packet length
      CVE-2026-45844: netfilter: arp_tables: fix IEEE1394 ARP payload parsing
      CVE-2026-45986: crypto: ccree - fix a memory leak in cc_mac_digest()
      CVE-2026-45994: ibmasm: fix OOB reads in command_file_write due to missing size checks
      CVE-2026-46004: ALSA: caiaq: Handle probe errors properly
      CVE-2026-46018: ALSA: usb-audio: stop parsing UAC2 rates at MAX_NR_RATES
      CVE-2026-46019: crypto: atmel-aes - Fix 3-page memory leak in atmel_aes_buff_cleanup
      CVE-2026-46022: misc: ibmasm: fix OOB MMIO read in ibmasm_handle_mouse_interrupt()
      CVE-2026-46023: dm mirror: fix integer overflow in create_dirty_log()
      CVE-2026-46033: crypto: authencesn - reject short ahash digests during instance creation
      CVE-2026-46040: inotify: fix watch count leak when fsnotify_add_inode_mark_locked() fails
      CVE-2026-46043: RDMA/rxe: Validate pad and ICRC before payload_size() in rxe_rcv
      CVE-2026-46046: ext4: fix missing brelse() in ext4_xattr_inode_dec_ref_all()
      CVE-2026-46048: ALSA: caiaq: fix usb_dev refcount leak on probe failure
      CVE-2026-46049: ALSA: ctxfi: Add fallback to default RSR for S/PDIF
      CVE-2026-46051: md/raid5: fix soft lockup in retry_aligned_read()
      CVE-2026-46064: ibmasm: fix heap over-read in ibmasm_send_i2o_message()
      CVE-2026-46070: md/raid5: validate payload size before accessing journal metadata
      CVE-2026-46077: crypto: atmel-tdes - fix DMA sync direction
      CVE-2026-46088: ALSA: control: Validate buf_len before strnlen() in snd_ctl_elem_init_enum_names()
      CVE-2026-46098: net: caif: clear client service pointer on teardown
      CVE-2026-46102: net: strparser: fix skb_head leak in strp_abort_strp()
      CVE-2026-46108: ipmi:si: Return state to normal if message allocation fails
      CVE-2026-46109: usb: ulpi: fix memory leak on ulpi_register() error paths
      CVE-2026-46120: ip6_gre: Use cached t->net in ip6erspan_changelink().
      CVE-2026-46122: wifi: b43: enforce bounds check on firmware key index in b43_rx()
      CVE-2026-46124: isofs: validate block number from NFS file handle in isofs_export_iget
      CVE-2026-46127: RDMA/ocrdma: Don't NULL deref uctx on errors in ocrdma_copy_pd_uresp()
      CVE-2026-46128: ipmi: Check event message buffer response for bad data
      CVE-2026-46133: RDMA/rxe: Reject unknown opcodes before ICRC processing
      CVE-2026-46146: ALSA: usb-audio: Avoid potential endless loop in convert_chmap_v3()
      CVE-2026-46149: scsi: target: configfs: Bound snprintf() return in tg_pt_gp_members_show()
      CVE-2026-46161: md/raid10: fix divide-by-zero in setup_geo() with zero far_copies
      CVE-2026-46163: wifi: b43legacy: enforce bounds check on firmware key index in RX path
      CVE-2026-46177: ipmi: Add limits to event and receive message requests
      CVE-2026-46184: sound: ua101: fix division by zero at probe
      CVE-2026-46187: wifi: rsi: fix kthread lifetime race between self-exit and external-stop
      CVE-2026-46198: batman-adv: fix integer overflow on buff_pos
      CVE-2026-46206: batman-adv: reject new tp_meter sessions during teardown
      CVE-2026-46212: batman-adv: bla: prevent use-after-free when deleting claims
      CVE-2026-46219: spi: mpc52xx: fix use-after-free on unbind
      CVE-2026-46220: drm/amdgpu/sdma4: replace BUG_ON with WARN_ON in fence emission
      CVE-2026-46227: sctp: revalidate list cursor after sctp_sendmsg_to_asoc() in SCTP_SENDALL
      CVE-2026-46231: batman-adv: bla: put backbone reference on failed claim hash insert
      CVE-2026-46233: batman-adv: bla: only purge non-released claims
      CVE-2026-46243: smb: client: reject userspace cifs.spnego descriptions
      CVE-2026-46273: ibmveth: Disable GSO for packets with small MSS
      CVE-2026-46275: Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths
      CVE-2026-46301: spi: topcliff-pch: fix use-after-free on unbind
      CVE-2026-46303: isofs: validate Rock Ridge CE continuation extent against volume size
      CVE-2026-46304: nvmet: avoid recursive nvmet-wq flush in nvmet_ctrl_free
      CVE-2026-46307: wifi: ath5k: do not access array OOB
      CVE-2026-43075: ocfs2: fix out-of-bounds write in ocfs2_write_end_inline
      CVE-2026-43076: ocfs2: validate inline data i_size during inode read
      CVE-2026-43110: wifi: brcmfmac: validate bsscfg indices in IF events
      CVE-2026-43111: HID: roccat: fix use-after-free in roccat_report_event
      CVE-2026-43113: wifi: wl1251: validate packet IDs before indexing tx_frames
      CVE-2026-43117: btrfs: tracepoints: get correct superblock from dentry in event btrfs_sync_file()
      CVE-2026-43281: mailbox: Prevent out-of-bounds access in fw_mbox_index_xlate()
      CVE-2026-43494: net/rds: reset op_nents when zerocopy page pin fails
      CVE-2026-43497: fbdev: udlfb: add vm_ops to dlfb_ops_mmap to prevent use-after-free
      CVE-2026-43503: net: skbuff: propagate shared-frag marker through frag-transfer helpers
      CVE-2026-46044: ipmi:ssif: Clean up kthread on errors
      CVE-2026-46151: usb: usblp: fix heap leak in IEEE 1284 device ID via short response
      CVE-2026-46167: usb: usblp: fix uninitialized heap leak via LPGETSTATUS ioctl
      CVE-2026-46294: dm: fix a buffer overflow in ioctl processing
      CVE-2026-46300: Fragnesia: the Dirty Frag vulnerability class
      CVE-2026-52914: batman-adv: fix fragment reassembly length accounting
      CVE-2026-52915: netfilter: ip6t_hbh: reject oversized option lists
      CVE-2026-52916: batman-adv: frag: disallow unicast fragment in fragment
      CVE-2026-52919: batman-adv: fix tp_meter counter underflow during shutdown
      CVE-2026-52920: netfilter: xt_policy: fix strict mode inbound policy matching
      CVE-2026-52921: netfilter: ipset: stop hash:* range iteration at end
      CVE-2026-52922: batman-adv: dat: handle forward allocation error
      CVE-2026-52925: vrf: Fix a potential NPD when removing a port from a VRF
      CVE-2026-52926: batman-adv: clear current gateway during teardown
      CVE-2026-52931: batman-adv: tp_meter: avoid use of uninit sender vars
      CVE-2026-52955: libceph: Fix potential out-of-bounds access in crush_decode()
      CVE-2026-52957: libceph: Fix potential null-ptr-deref in decode_choose_args()
      CVE-2026-52962: ceph: fix a buffer leak in __ceph_setxattr()
      CVE-2026-52963: ALSA: usb-audio: Bound MIDI endpoint descriptor scans
      CVE-2026-52972: crypto: af_alg - Cap AEAD AD length to 0x80000000
      CVE-2026-52982: net: usb: rtl8150: fix use-after-free in rtl8150_start_xmit()
      CVE-2026-52984: net/sched: netem: fix queue limit check to include reordered packets
      CVE-2026-52986: netfilter: nf_conntrack_sip: don't use simple_strtoul
      CVE-2026-52993: tipc: fix double-free in tipc_buf_append()
      CVE-2026-52995: net/rds: zero per-item info buffer before handing it to visitors
      CVE-2026-52998: netfilter: nfnetlink_osf: fix potential NULL dereference in ttl check
      CVE-2026-52999: netfilter: nfnetlink_osf: fix out-of-bounds read on option matching
      CVE-2026-53001: netfilter: xtables: restrict several matches to inet family
      CVE-2026-53002: netfilter: conntrack: remove sprintf usage
      CVE-2026-53004: sctp: fix OOB write to userspace in sctp_getsockopt_peer_auth_chunks
      CVE-2026-53006: ipv6: fix possible UAF in icmpv6_rcv()
      CVE-2026-53016: crypto: ccp - copy IV using skcipher ivsize
      CVE-2026-53021: scsi: target: core: Fix integer overflow in UNMAP bounds check
      CVE-2026-53037: HID: usbhid: fix deadlock in hid_post_reset()
      CVE-2026-53039: ocfs2: validate group add input before caching
      CVE-2026-53040: ocfs2: validate bg_bits during freefrag scan
      CVE-2026-53041: ocfs2: fix listxattr handling when the buffer is full
      CVE-2026-53043: ocfs2/dlm: validate qr_numregions in dlm_match_regions()
      CVE-2026-53045: memory: tegra124-emc: Fix dll_change check
      CVE-2026-53047: efi/capsule-loader: fix incorrect sizeof in phys array reallocation
      CVE-2026-53050: quota: Fix race of dquot_scan_active() with quota deactivation
      CVE-2026-53059: dm log: fix out-of-bounds write due to region_count overflow
      CVE-2026-53060: dm cache metadata: fix memory leak on metadata abort retry
      CVE-2026-53062: dm cache policy smq: fix missing locks in invalidating cache blocks
      CVE-2026-53064: dm cache: fix null-deref with concurrent writes in passthrough mode
      CVE-2026-53065: ASoC: sti: use managed regmap_field allocations
      CVE-2026-53073: Bluetooth: hci_ldisc: Clear HCI_UART_PROTO_INIT on error
      CVE-2026-53075: ppp: require CAP_NET_ADMIN in target netns for unattached ioctls
      CVE-2026-53082: net: hamradio: 6pack: fix uninit-value in sixpack_receive_buf
      CVE-2026-53088: net: bcmgenet: fix off-by-one in bcmgenet_put_txcb
      CVE-2026-53093: wifi: brcmfmac: Fix error pointer dereference
      CVE-2026-53112: wifi: rtlwifi: pci: fix possible use-after-free caused by unfinished irq_prepare_bcn_tasklet
      CVE-2026-53128: drbd: Balance RCU calls in drbd_adm_dump_devices()
      CVE-2026-53130: fs/omfs: reject s_sys_blocksize smaller than OMFS_DIR_START
      CVE-2026-53287: audit: fix incorrect inheritable capability in CAPSET records
      CVE-2026-53294: mailbox: mailbox-test: don't free the reused channel
      CVE-2026-53295: mailbox: add sanity check for channel array
      CVE-2026-53296: mailbox: mailbox-test: free channels on probe error
      CVE-2026-53304: scsi: sg: Resolve soft lockup issue when opening /dev/sgX
      CVE-2026-53306: tty: hvc_iucv: fix off-by-one in number of supported devices
      CVE-2026-53309: ocfs2/dlm: fix off-by-one in dlm_match_regions() region comparison
      CVE-2026-53320: nilfs2: reject zero bd_oblocknr in nilfs_ioctl_mark_blocks_dirty()

Best regards,
Ulrich Hecht

