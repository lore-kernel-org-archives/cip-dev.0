Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F21CCD3444
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 11:29:08 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9353.1778153338535011212
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 May 2026 04:28:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=snvkoS0s;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=Eeo2XDWD;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.167, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1778153236; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=W6n9kHybmL9KnhxX8H1xBZLapodt5vZe7tKoMXj+Gps4ss+wGntao9y0CAU/dMiBCJ
    kTPX5NWQCrVeIVSUf2FrTbR9edQX+FCk4lXxieyBVaLhnONBmXlQV3+GWNGlmxndCyK6
    9Yi+QvVF1XlVrm4qD8WjPcwdeu6lzf4v8z2YS0dLM5RI4895x52J0EIAefwyi6oWtMZH
    +ppKtMEXU43iD7vZiSDDHWbQS5DfKpJwb4tUvFomkpvqHgJKZKOfcZu7YgJIbhiBoRdE
    dY9Q7tKhN9QGFy2tQi0HaE3IPa2NkwiljLH1PN6hRo98VBkD3J71Ku22uNRqPBWwcObt
    a33g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1778153236;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=pWKBdb+sJRPO9BpfYyZJ4nk9EG7UA7wvQFFtrjgizuM=;
    b=pYlxtxD2szlz59TyNV7fetG6wOlM0N+LLRukB2uinlpTmFydKWjaTTDw2CZ/w1hCtH
    E3m+6WhNSgNOwvTbEPN5fwr7i+0JcGfnRX6WM1GfzZ1h/NrPV+4eHVv8WvArgi/WTf8y
    I/xoX5hH+95tYrPv6dMDpt63EyuM2TYLS9217NI/m4DT+b1LNtdleJwPSoLAnBS9XXWb
    SwZ9f0tkw2uHs32EidWOrRMMPGA5buhirb0C67Ztu6cxjvSzfTkBPi5cD6pIURdUhoD3
    iVm7F2wIurfs9uzNBK6fnuT1vFYWZieeFf+vAWG95Cy4YvmHt54aGs8lfMp+P5zjBbl2
    wMVg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1778153236;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=pWKBdb+sJRPO9BpfYyZJ4nk9EG7UA7wvQFFtrjgizuM=;
    b=snvkoS0sVGGZxKIg31Quhywm7rYoY8GFxg0jDXZ2MlfxyivwKOp8EogXi5WfTt+ZjQ
    wTz/kkAAhp48AXvPryejcWh7ltpR7kaOrIFBRhdv3j6DudjivbsFmo9uofsoVnT0OguZ
    GJq+i5BtZcByrBj0JDQBtrwWCeWwHoYagultAtikY+UofR+x0QXXdDMnlSMaQgVglIYA
    OsSS4h4gxIjwBw+qKTjYzyusy79pnyRuBCwj/KIy4pA437Ou86Y2htmf0o5u0W1cbNVP
    ikXu9K80iVnhBwk5Mef35j6Hhg2fVxCFL1EJeSl9WGN19bzMo+QSYSqzJslEZmq7VWdZ
    em4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1778153236;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=pWKBdb+sJRPO9BpfYyZJ4nk9EG7UA7wvQFFtrjgizuM=;
    b=Eeo2XDWDp+HzGZFkAIkH8Z0PH5S7alhtsR7ExuQK6BcITN+FX7/LUbn2P4aWGTtc/z
    SqefCAQDIM+eL+9craAg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKDG+LdTmA=="
Received: from open-xchange-core-mw-gw-8.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e247BRFLUv
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 7 May 2026 13:27:15 +0200 (CEST)
Date: Thu, 7 May 2026 13:27:15 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <466138934.704670.1778153235328@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.19.325-cip132
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.88
X-Originating-Port: 33982
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 May 2026 11:29:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22904

Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip132. The linux-4.19.y-cip tree's base version has been updated to v4.19-st16. The trees are up-to-date with kernel 5.10.254.
This release includes fixes for CVE-2026-31431.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/

  v4.19.325-cip132:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      a0cf0e1623b28b1d20f9626f32809952b7a40f15
    Fixed CVEs:
      CVE-2025-38693: media: dvb-frontends: w7090p: fix null-ptr-deref in w7090p_tuner_write_serpar and w7090p_tuner_read_serpar
      CVE-2025-39764: netfilter: ctnetlink: remove refcounting in expectation dumpers
      CVE-2025-54505: x86/CPU: Fix FPDSS on Zen1
      CVE-2026-23253: media: dvb-core: fix wrong reinitialization of ringbuffer on reopen
      CVE-2026-23268: apparmor: fix unprivileged local user can do privileged policy management
      CVE-2026-23269: apparmor: validate DFA start states are in bounds in unpack_pdb
      CVE-2026-23277: net/sched: teql: fix NULL pointer dereference in iptunnel_xmit on TEQL slave xmit
      CVE-2026-23279: wifi: mac80211: fix NULL pointer dereference in mesh_rx_csa_frame()
      CVE-2026-23281: wifi: libertas: fix use-after-free in lbs_free_adapter()
      CVE-2026-23286: atm: lec: fix null-ptr-deref in lec_arp_clear_vccs
      CVE-2026-23290: net: usb: pegasus: validate USB endpoints
      CVE-2026-23291: nfc: pn533: properly drop the usb interface reference on disconnect
      CVE-2026-23293: net: vxlan: fix nd_tbl NULL dereference when IPv6 is disabled
      CVE-2026-23298: can: ucan: Fix infinite loop from zero-length messages
      CVE-2026-23303: smb: client: Don't log plaintext credentials in cifs_set_cifscreds
      CVE-2026-23304: ipv6: fix NULL pointer deref in ip6_rt_get_dev_rcu()
      CVE-2026-23307: can: ems_usb: ems_usb_read_bulk_callback(): check the proper length of a message
      CVE-2026-23312: net: usb: kaweth: validate USB endpoints
      CVE-2026-23318: ALSA: usb-audio: Use correct version for UAC3 header validation
      CVE-2026-23339: nfc: nci: free skb on nci_transceive early error paths
      CVE-2026-23356: drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()
      CVE-2026-23362: can: bcm: fix locking for bcm_op runtime updates
      CVE-2026-23365: net: usb: kalmia: validate USB endpoints
      CVE-2026-23367: wifi: radiotap: reject radiotap with unknown bits
      CVE-2026-23372: nfc: rawsock: cancel tx_work before socket teardown
      CVE-2026-23381: net: bridge: fix nd_tbl NULL dereference when IPv6 is disabled
      CVE-2026-23388: Squashfs: check metadata block offset is within range
      CVE-2026-23391: netfilter: xt_CT: drop pending enqueued packets on template removal
      CVE-2026-23396: wifi: mac80211: fix NULL deref in mesh_matches_local()
      CVE-2026-23397: nfnetlink_osf: validate individual option lengths in fingerprints
      CVE-2026-23398: icmp: fix NULL pointer dereference in icmp_tag_validation()
      CVE-2026-23403: apparmor: fix memory leak in verify_header
      CVE-2026-23404: apparmor: replace recursive profile removal with iterative approach
      CVE-2026-23405: apparmor: fix: limit the number of levels of policy namespaces
      CVE-2026-23406: apparmor: fix side-effect bug in match_char() macro usage
      CVE-2026-23407: apparmor: fix missing bounds check on DEFAULT table in verify_dfa()
      CVE-2026-23408: apparmor: Fix double free of ns_name in aa_replace_profiles()
      CVE-2026-23409: apparmor: fix differential encoding verification
      CVE-2026-23420: wifi: wlcore: Fix a locking bug
      CVE-2026-23439: udp_tunnel: fix NULL deref caused by udp_sock_create6 when CONFIG_IPV6=n
      CVE-2026-23452: PM: runtime: Fix a race condition related to device removal
      CVE-2026-23455: netfilter: nf_conntrack_h323: check for zero length in DecodeQ931()
      CVE-2026-23456: netfilter: nf_conntrack_h323: fix OOB read in decode_int() CONS case
      CVE-2026-23457: netfilter: nf_conntrack_sip: fix Content-Length u32 truncation in sip_help_tcp()
      CVE-2026-23458: netfilter: ctnetlink: fix use-after-free in ctnetlink_dump_exp_ct()
      CVE-2026-23460: net/rose: fix NULL pointer dereference in rose_transmit_link on reconnect
      CVE-2026-23462: Bluetooth: HIDP: Fix possible UAF
      CVE-2026-31393: Bluetooth: L2CAP: Validate L2CAP_INFO_RSP payload length before access
      CVE-2026-31396: net: macb: fix use-after-free access to PTP clock
      CVE-2026-31399: nvdimm/bus: Fix potential use after free in asynchronous initialization
      CVE-2026-31402: nfsd: fix heap overflow in NFSv4.0 LOCK replay cache
      CVE-2026-31405: media: dvb-net: fix OOB access in ULE extension header tables
      CVE-2026-31415: ipv6: avoid overflows in ip6_datagram_send_ctl()
      CVE-2026-31416: netfilter: nfnetlink_log: account for netlink header size
      CVE-2026-31417: net/x25: Fix overflow when accumulating packets
      CVE-2026-31421: net/sched: cls_fw: fix NULL pointer dereference on shared blocks
      CVE-2026-31422: net/sched: cls_flow: fix NULL pointer dereference on shared blocks
      CVE-2026-31423: net/sched: sch_hfsc: fix divide-by-zero in rtsc_min()
      CVE-2026-31424: netfilter: x_tables: restrict xt_check_match/xt_check_target extensions for NFPROTO_ARP
      CVE-2026-31427: netfilter: nf_conntrack_sip: fix use of uninitialized rtp_addr in process_sdp
      CVE-2026-31428: netfilter: nfnetlink_log: fix uninitialized padding leak in NFULA_PAYLOAD
      CVE-2026-31431: crypto: algif_aead - Revert to operating out-of-place
      CVE-2026-31447: ext4: reject mount if bigalloc with s_first_data_block != 0
      CVE-2026-31452: ext4: convert inline data to extents when truncate exceeds inline size
      CVE-2026-31464: scsi: ibmvfc: Fix OOB access in ibmvfc_discover_targets_done()
      CVE-2026-31466: mm/huge_memory: fix folio isn't locked in softleaf_to_folio()
      CVE-2026-31469: virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
      CVE-2026-31494: net: macb: use the current queue number for stats
      CVE-2026-31498: Bluetooth: L2CAP: Fix ERTM re-init and zero pdu_len infinite loop
      CVE-2026-31504: net: fix fanout UAF in packet_release() via NETDEV_UP race
      CVE-2026-31508: net: openvswitch: Avoid releasing netdev before teardown completes
      CVE-2026-31510: Bluetooth: L2CAP: Fix null-ptr-deref on l2cap_sock_ready_cb
      CVE-2026-31512: Bluetooth: L2CAP: Validate PDU length before reading SDU length in l2cap_ecred_data_rcv()
      CVE-2026-31515: af_key: validate families in pfkey_send_migrate()
      CVE-2026-31546: net: bonding: fix NULL deref in bond_debug_rlb_hash_show
      CVE-2026-31552: wifi: wlcore: Return -ENOMEM instead of -EAGAIN if there is not enough headroom
      CVE-2026-31628: x86/CPU: Fix FPDSS on Zen1
      CVE-2026-31649: net: stmmac: fix integer underflow in chain mode
      CVE-2026-31651: mmc: vub300: fix NULL-deref on disconnect
      CVE-2026-31658: net: altera-tse: fix skb leak on DMA mapping error in tse_start_xmit()
      CVE-2026-31659: batman-adv: reject oversized global TT response buffers
      CVE-2026-31661: wifi: brcmsmac: Fix dma_free_coherent() size
      CVE-2026-31662: tipc: fix bc_ackers underflow on duplicate GRP_ACK_MSG
      CVE-2026-31665: netfilter: nft_ct: fix use-after-free in timeout object destroy
      CVE-2026-31667: Input: uinput - fix circular locking dependency with ff-core
      CVE-2026-31668: seg6: separate dst_cache for input and output paths in seg6 lwtunnel
      CVE-2026-31670: net: rfkill: prevent unlimited numbers of rfkill events from being created
      CVE-2026-31671: xfrm_user: fix info leak in build_report()
      CVE-2026-31672: wifi: rt2x00usb: fix devres lifetime
      CVE-2026-31674: netfilter: ip6t_rt: reject oversized addrnr in rt_mt6_check()
      CVE-2026-31679: openvswitch: validate MPLS set/set_masked payload length
      CVE-2026-31680: net: ipv6: flowlabel: defer exclusive option free until RCU teardown
      CVE-2026-31682: bridge: br_nd_send: linearize skb before parsing ND options
      CVE-2026-31683: batman-adv: avoid OGM aggregation when skb tailroom is insufficient
      CVE-2026-31720: usb: gadget: f_uac1_legacy: validate control request size
      CVE-2026-31721: usb: gadget: f_hid: move list and spinlock inits from bind to alloc
      CVE-2026-31728: usb: gadget: u_ether: Fix race between gether_disconnect and eth_stop
      CVE-2026-31738: vxlan: validate ND option lengths in vxlan_na_create
      CVE-2026-31747: comedi: me4000: Fix potential overrun of firmware buffer
      CVE-2026-31748: comedi: me_daq: Fix potential overrun of firmware buffer
      CVE-2026-31749: comedi: ni_atmio16d: Fix invalid clean-up after failed attach
      CVE-2026-31751: comedi: dt2815: add hardware detection to prevent crash
      CVE-2026-31752: bridge: br_nd_send: validate ND option lengths
      CVE-2026-31759: usb: ulpi: fix double free in ulpi_register_interface() error path
      CVE-2026-31761: iio: gyro: mpu3050: Move iio_device_register() to correct location
      CVE-2026-31762: iio: gyro: mpu3050: Fix irq resource leak
      CVE-2026-31763: iio: gyro: mpu3050: Fix incorrect free_irq() variable
      CVE-2026-31773: Bluetooth: SMP: derive legacy responder STK authentication from MITM state
      CVE-2026-31776: ALSA: ctxfi: Fix missing SPDIFI1 index handling
      CVE-2026-31778: ALSA: caiaq: fix stack out-of-bounds read in init_card
      CVE-2026-31781: drm/ioc32: stop speculation on the drm_compat_ioctl path
      CVE-2026-31786: Buffer overflow in drivers/xen/sys-hypervisor.c
      CVE-2026-31787: xen/privcmd: fix double free via VMA splitting
      CVE-2026-31788: 
      CVE-2026-43011: net/x25: Fix potential double free of skb
      CVE-2026-43014: net: macb: properly unregister fixed rate clocks
      CVE-2026-43015: net: macb: fix clk handling on PCI glue driver removal
      CVE-2026-43020: Bluetooth: MGMT: validate LTK enc_size on load
      CVE-2026-43026: netfilter: ctnetlink: zero expect NAT fields when CTA_EXPECT_NAT absent
      CVE-2026-43027: netfilter: nf_conntrack_helper: pass helper to expect cleanup
      CVE-2026-43028: netfilter: x_tables: ensure names are nul-terminated
      CVE-2026-43030: bpf: Fix regsafe() for pointers to packet
      CVE-2026-43033: crypto: authencesn - Do not place hiseq at end of dst for out-of-place decryption
      CVE-2026-43037: ip6_tunnel: clear skb2->cb[] in ip4ip6_err()
      CVE-2026-43038: ipv6: icmp: clear skb2->cb[] in ip6_err_gen_icmpv6_unreach()
      CVE-2026-43040: net: ipv6: ndisc: fix ndisc_ra_useropt to initialize nduseropt_padX fields to zero to prevent an info-leak
      CVE-2026-43043: crypto: af-alg - fix NULL pointer dereference in scatterwalk
      CVE-2026-43047: HID: multitouch: Check to ensure report responses match the request
      CVE-2026-43050: atm: lec: fix use-after-free in sock_def_readable()
      CVE-2026-43051: HID: wacom: fix out-of-bounds read in wacom_intuos_bt_irq
      CVE-2026-43068: ext4: avoid allocate block from corrupted group in ext4_mb_find_by_goal()
      CVE-2026-43069: Bluetooth: hci_ll: Fix firmware leak on error path
      CVE-2026-43077: crypto: algif_aead - Fix minimum RX size check for decryption
      CVE-2026-43078: crypto: af_alg - Fix page reassignment overflow in af_alg_pull_tsgl
      CVE-2026-43159: staging: rtl8723bs: fix null dereference in find_network

Best regards,
Ulrich Hecht

