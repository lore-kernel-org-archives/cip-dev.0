Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148E9C4452A
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 13:36:30 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9237.1784554583717981449
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jul 2026 06:36:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=V1atbujp;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=2Bm9Omkc;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.163, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1784554557; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bOb+eXFkEHAczmky3tuI3rpV4WcX6wB8swoDlhFIITfahubqkw9uvN+PKr0h7xEQYP
    vGiSH2PrSefa6Ri+bc0wOiNLqPsBh5wuMgFoPpgtjBLboKfzWNrj4qP1sgyd0aFOhi15
    BlfgSvvpdvw9GJ0arFrc5mVqAyUFmPmbVtrFzpaskB2uPc+QExqKR8j8PeQIgzRdfPUB
    EbxoOk+SftQ8Yor9EznqBtLQS70Dk5MNY15iwbXq+12Lwx7RHtvmV/GSLB3MKbGQpMGG
    4wa4+XSH90ZKIQkajJ2wHxvfh4F4sRkxfAkNd0zZl1TMSrMMQw5aKwxau7qj5y7nvmCR
    e9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784554557;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=GrZDQEjGgQ13hfE1/Lhy0hTz9TawySsmIS8+qcx6NAk=;
    b=jpu8wmP0j/vlDZGXxp7FzSGVnLnuDHlP2rOQNbttzzVfHyzJqB5c7NNUZ0ijAlEx6i
    zXaDiPR4d9xgLZY6ZA+LEdL/TYrL9z6LABJFnZtn9qylJ7+vZacEjCipb5gaO8IaxRmG
    KQo06gjBi329d1UXuCOCMdMn46ZYi69fZrcjqOqzJOPSLuEqWoKv5dm3uNejY41xIlmw
    QjF008ZcXWBBp8A7Q0znvqe5SJeHvdzvUsRc7DejjkmWiwOIW91lQNmW71jhsmjduNJ7
    LjpiaKR8LkpyDCIMjKICD+DpmE+h7TCgx3H1yH32pC845gJZNUOt6zZi869kDkhUJMPh
    /oLw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784554557;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=GrZDQEjGgQ13hfE1/Lhy0hTz9TawySsmIS8+qcx6NAk=;
    b=V1atbujp7z6dEcX2Ld9h/QhOcXMFxZ4TqAHvoa5eYW++QpsyQjwJppxd0JSkY7lj3X
    UMvjAsjKYmda0bNg1ohwOD9uPCzh8UnR805xhj9buEs8hSkvcaEp3E+wGX0/0Q3UlTjS
    F3gdlheRsO79rPE3KMMMumYrBGIH4Y2Wwi0hVAJOD8BUUCcGqQwqbhkRZsxdIMtfSKCV
    9Z3IEEq50DOrV4f04eeGsR8Oupm6ALlBz2/ub3/YMfFAIgomeBPRYoevQelGTWsAaX+y
    se0eTe2kjSKzMghcZyBID6fHxMz4CiUf7OwblTH2yFy5cfWVKH96awtXGHlC8Xvo8Qme
    u+dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784554557;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=GrZDQEjGgQ13hfE1/Lhy0hTz9TawySsmIS8+qcx6NAk=;
    b=2Bm9OmkcRsFFBgrGLZa12LJc3Z24ZYbdnT87HTRiA310DIKnNGq7PK1u4Ox94/7AIm
    XNMoFcGI9bwDXAFevUBA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzotGZvghOuyH3Qoll8Aco="
Received: from open-xchange-core-mw-gw-10.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.5.6 AUTH)
    with ESMTPSA id zec9ec26KDZu9Q9
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 20 Jul 2026 15:35:56 +0200 (CEST)
Date: Mon, 20 Jul 2026 15:35:56 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <525648223.705966.1784554556531@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip113
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.142
X-Originating-Port: 55494
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 13:36:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23678

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip113. The linux-4.4.y-cip tree's base version has been updated to v4.4-st78. The trees are up-to-date with kernel 4.19-st18.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip113:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      52c08e0854141dde9bb9a907429858b9fafb84ae
    Fixed CVEs:
      CVE-2025-38710: gfs2: Validate i_depth for exhash directories
      CVE-2026-23444: wifi: mac80211: always free skb on ieee80211_tx_prepare_skb() failure
      CVE-2026-31532: can: raw: fix ro->uniq use-after-free in raw_rcv()
      CVE-2026-31576: media: hackrf: fix to not free memory after the device is registered in hackrf_probe()
      CVE-2026-31578: media: as102: fix to not free memory after the device is registered in as102_usb_probe()
      CVE-2026-31580: bcache: fix cached_dev.sb_bio use-after-free and crash
      CVE-2026-31583: media: em28xx: fix use-after-free in em28xx_v4l2_open()
      CVE-2026-31588: KVM: x86: Use scratch field in MMIO fragment to hold small write values
      CVE-2026-31596: ocfs2: handle invalid dinode in ocfs2_group_extend
      CVE-2026-31602:  ALSA: ctxfi: Limit PTP to a single page
      CVE-2026-31605: fbdev: udlfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
      CVE-2026-31616: usb: gadget: f_phonet: fix skb frags[] overflow in pn_rx_complete()
      CVE-2026-31618: fbdev: tdfxfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
      CVE-2026-31619: ALSA: fireworks: bound device-supplied status before string array lookup
      CVE-2026-31622: NFC: digital: Bounds check NFC-A cascade depth in SDD response handler
      CVE-2026-31623: net: usb: cdc-phonet: fix skb frags[] overflow in rx_complete()
      CVE-2026-31624: HID: core: clamp report_size in s32ton() to avoid undefined shift
      CVE-2026-31627: i2c: s3c24xx: check the size of the SMBUS message before using it
      CVE-2026-31629: nfc: llcp: add missing return after LLCP_CLOSED checks
      CVE-2026-31634: rxrpc: fix reference count leak in rxrpc_server_keyring()
      CVE-2026-31664: xfrm: clear trailing padding in build_polexpire()
      CVE-2026-31673: af_unix: read UNIX_DIAG_VFS data under unix_state_lock
      CVE-2026-31681: netfilter: xt_multiport: validate range encoding in checkentry
      CVE-2026-31696: rxrpc: Fix missing validation of ticket length in non-XDR key preparsing
      CVE-2026-31701: ALSA: caiaq: take a reference on the USB device in create_card()
      CVE-2026-43075: ocfs2: fix out-of-bounds write in ocfs2_write_end_inline
      CVE-2026-43076: ocfs2: validate inline data i_size during inode read
      CVE-2026-43080: l2tp: Drop large packets with UDP encap
      CVE-2026-43089: xfrm_user: fix info leak in build_mapping()
      CVE-2026-43110: wifi: brcmfmac: validate bsscfg indices in IF events
      CVE-2026-43111: HID: roccat: fix use-after-free in roccat_report_event
      CVE-2026-43113: wifi: wl1251: validate packet IDs before indexing tx_frames
      CVE-2026-43281: mailbox: Prevent out-of-bounds access in fw_mbox_index_xlate()
      CVE-2026-43496: net/sched: sch_red: Replace direct dequeue call with peek and qdisc_dequeue_peeked
      CVE-2026-45834: Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_state_change_cb()
      CVE-2026-45835: Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_new_connection_cb()
      CVE-2026-45836: Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
      CVE-2026-45842: slip: reject VJ receive packets on instances with no rstate array
      CVE-2026-45843: slip: bound decode() reads against the compressed packet length
      CVE-2026-45844: netfilter: arp_tables: fix IEEE1394 ARP payload parsing
      CVE-2026-45981: s390/cio: Fix device lifecycle handling in css_alloc_subchannel()
      CVE-2026-45992: [REJECTED]: ALSA: caiaq: Fix potentially leftover ep1_in_urb at error path
      CVE-2026-45994: ibmasm: fix OOB reads in command_file_write due to missing size checks
      CVE-2026-46004: ALSA: caiaq: Handle probe errors properly
      CVE-2026-46018: ALSA: usb-audio: stop parsing UAC2 rates at MAX_NR_RATES
      CVE-2026-46022: misc: ibmasm: fix OOB MMIO read in ibmasm_handle_mouse_interrupt()
      CVE-2026-46023: dm mirror: fix integer overflow in create_dirty_log()
      CVE-2026-46033: crypto: authencesn - reject short ahash digests during instance creation
      CVE-2026-46048: ALSA: caiaq: fix usb_dev refcount leak on probe failure
      CVE-2026-46049: ALSA: ctxfi: Add fallback to default RSR for S/PDIF
      CVE-2026-46051: md/raid5: fix soft lockup in retry_aligned_read()
      CVE-2026-46064: ibmasm: fix heap over-read in ibmasm_send_i2o_message()
      CVE-2026-46077: crypto: atmel-tdes - fix DMA sync direction
      CVE-2026-46088: ALSA: control: Validate buf_len before strnlen() in snd_ctl_elem_init_enum_names()
      CVE-2026-46098: net: caif: clear client service pointer on teardown
      CVE-2026-46108: ipmi:si: Return state to normal if message allocation fails
      CVE-2026-46122: wifi: b43: enforce bounds check on firmware key index in b43_rx()
      CVE-2026-46124: isofs: validate block number from NFS file handle in isofs_export_iget
      CVE-2026-46127: RDMA/ocrdma: Don't NULL deref uctx on errors in ocrdma_copy_pd_uresp()
      CVE-2026-46128: ipmi: Check event message buffer response for bad data
      CVE-2026-46149: scsi: target: configfs: Bound snprintf() return in tg_pt_gp_members_show()
      CVE-2026-46151: usb: usblp: fix heap leak in IEEE 1284 device ID via short response
      CVE-2026-46161: md/raid10: fix divide-by-zero in setup_geo() with zero far_copies
      CVE-2026-46163: wifi: b43legacy: enforce bounds check on firmware key index in RX path
      CVE-2026-46167: usb: usblp: fix uninitialized heap leak via LPGETSTATUS ioctl
      CVE-2026-46177: ipmi: Add limits to event and receive message requests
      CVE-2026-46184: sound: ua101: fix division by zero at probe
      CVE-2026-46187: wifi: rsi: fix kthread lifetime race between self-exit and external-stop
      CVE-2026-46198: batman-adv: fix integer overflow on buff_pos
      CVE-2026-46212: batman-adv: bla: prevent use-after-free when deleting claims
      CVE-2026-46219: spi: mpc52xx: fix use-after-free on unbind
      CVE-2026-46231: batman-adv: bla: put backbone reference on failed claim hash insert
      CVE-2026-46233: batman-adv: bla: only purge non-released claims
      CVE-2026-46273: ibmveth: Disable GSO for packets with small MSS
      CVE-2026-46294: dm: fix a buffer overflow in ioctl processing
      CVE-2026-46301: spi: topcliff-pch: fix use-after-free on unbind
      CVE-2026-46303: isofs: validate Rock Ridge CE continuation extent against volume size
      CVE-2026-46307: wifi: ath5k: do not access array OOB
      CVE-2026-52914: batman-adv: fix fragment reassembly length accounting
      CVE-2026-52915: netfilter: ip6t_hbh: reject oversized option lists
      CVE-2026-52916: batman-adv: frag: disallow unicast fragment in fragment
      CVE-2026-52920: netfilter: xt_policy: fix strict mode inbound policy matching
      CVE-2026-52922: batman-adv: dat: handle forward allocation error
      CVE-2026-52926: batman-adv: clear current gateway during teardown
      CVE-2026-52955: libceph: Fix potential out-of-bounds access in crush_decode()
      CVE-2026-52962: ceph: fix a buffer leak in __ceph_setxattr()
      CVE-2026-52963: ALSA: usb-audio: Bound MIDI endpoint descriptor scans
      CVE-2026-52972: crypto: af_alg - Cap AEAD AD length to 0x80000000
      CVE-2026-52982: net: usb: rtl8150: fix use-after-free in rtl8150_start_xmit()
      CVE-2026-52986: netfilter: nf_conntrack_sip: don't use simple_strtoul
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
      CVE-2026-53059: dm log: fix out-of-bounds write due to region_count overflow
      CVE-2026-53060: dm cache metadata: fix memory leak on metadata abort retry
      CVE-2026-53075: ppp: require CAP_NET_ADMIN in target netns for unattached ioctls
      CVE-2026-53093: wifi: brcmfmac: Fix error pointer dereference
      CVE-2026-53112: wifi: rtlwifi: pci: fix possible use-after-free caused by unfinished irq_prepare_bcn_tasklet
      CVE-2026-53130: fs/omfs: reject s_sys_blocksize smaller than OMFS_DIR_START
      CVE-2026-53287: audit: fix incorrect inheritable capability in CAPSET records
      CVE-2026-53294: mailbox: mailbox-test: don't free the reused channel
      CVE-2026-53295: mailbox: add sanity check for channel array
      CVE-2026-53296: mailbox: mailbox-test: free channels on probe error
      CVE-2026-53304: scsi: sg: Resolve soft lockup issue when opening /dev/sgX
      CVE-2026-53306: tty: hvc_iucv: fix off-by-one in number of supported devices
      CVE-2026-53309: ocfs2/dlm: fix off-by-one in dlm_match_regions() region comparison
      CVE-2026-53320: nilfs2: reject zero bd_oblocknr in nilfs_ioctl_mark_blocks_dirty()
      CVE-2026-31607:  usbip: validate number_of_packets in usbip_pack_ret_submit()
      CVE-2026-31637: rxrpc: reject undecryptable rxkad response tickets
      CVE-2026-31685: netfilter: ip6t_eui64: reject invalid MAC header for all packets
      CVE-2026-43493: crypto: pcrypt - Fix handling of MAY_BACKLOG requests
      CVE-2026-53369: udf: reject descriptors with oversized CRC length
      CVE-2026-63860: RDMA/core: Prefer NLA_NUL_STRING
      CVE-2026-64088: batman-adv: tt: fix negative tt_buff_len
      CVE-2026-64089: batman-adv: tt: fix negative last_changeset_len
      CVE-2026-64096: batman-adv: mcast: fix use-after-free in orig_node RCU release
      CVE-2026-64103: scsi: isci: Fix use-after-free in device removal path
      CVE-2026-64113: ixgbevf: fix use-after-free in VEPA multicast source pruning
      CVE-2026-64114: ipv4: raw: reject IP_HDRINCL packets with ihl < 5
      CVE-2026-64115: vsock/vmci: fix UAF when peer resets connection during handshake
      CVE-2026-64125: net: bcmgenet: keep RBUF EEE/PM disabled
      CVE-2026-64133: ALSA: asihpi: Fix potential OOB array access at reading cache
      CVE-2026-64177: phonet/pep: disable BH around forwarded sk_receive_skb()
      CVE-2026-64178: Bluetooth: bnep: Fix UAF read of dev->name
      CVE-2026-64185: sysfs: don't remove existing directory on update failure

Best regards,
Ulrich Hecht

