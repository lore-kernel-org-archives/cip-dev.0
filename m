Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70AAC55822
	for <webhook@archiver.kernel.org>; Tue,  4 Aug 2026 13:43:45 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16743.1785851019801276356
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Aug 2026 06:43:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=Bm+Dwqt3;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=djB1MVHa;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.50, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1785850990; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Fiz5lp1AA97iwWCZ3CWHZz4YXrgRkhtr0cAV84DoekhafS4Ff2hCooP+iTf0IocnnC
    ZzzxI0AZfJWmcLAXDhn3obM/7hsUAIYNbdMUdZJ1R93hQrEhzx+yh7ET3v0ggpvp7lJB
    agnArEX1VdAhGoKt7F9yE7N9oa3ZaIaPWuhLsqJ7TCu2bm40twh4x6ePM4JsrTBDjiKW
    D93nHlWqWGKzfGhsRwIxBZifq4tvK425IsHEotbalk0WkCZq4sc7M35MXKf62GVLMiaz
    8FMCHQk1Bf+spQRE3PTVxrikYvLs8tLPNN2OWWXCwUX3OllaNChn2dufa2QInmdrLsrv
    +s8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785850990;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=vNaMOVWqpqcQYPovYo4vSvPCciq5QtjfWTYRHoKok2E=;
    b=UYhJUzP0bz4P8HfE3ISql0kOGMx4FQ3fWfBLHjGX21Vt3EPZkg4usOcvL6H+3wjjsf
    fZhUcM9ZKUCGDLGOGSF3CD6+/sJXEAG+RVaWGMbb9xMcEujkLRLDyVVy5qEd6ld+jSta
    phEa+09g3RxYTpEqzSKkCVainO48e+ev1pRmdJSEt85MBDILHzEoXWNp5Cf3zZnY+muc
    SaRdAG73ukU9OcmG0hrcl2IB83GCG9pDfO9vVJSD2Q7p4vbQfjEN3azFwbFl7vgPa00h
    Cx3cu12QKfP3UVpmnGcOD9YnSZ9tZ68x4BIyCmldNou8iqLIxfJ64VOwSrM2vLBmZhCN
    7bfg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785850990;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=vNaMOVWqpqcQYPovYo4vSvPCciq5QtjfWTYRHoKok2E=;
    b=Bm+Dwqt34lRaygqqIREG3y/eY7BXg5tvmK/7iglsYNrF4Wg15w5O2mh7ncQ381wgcj
    wG4VhXN7AiHrJ4jRGAoAAJIyjodwYDQaj9QvJ/HFES4LLRmpSbSGtwSFitkmVgaCXiTQ
    PED5KWxvN8UyWCz4uunWOPdYUkh0WmFkPJ6Hv/o4OirAJFgo3KYQrZYL0nmbzeiIFIKb
    DG18T8dne6x+f4v9WXS+CPVU7Jb/PWr4NF+9AdE5GqKrmzMNQDLbZhExkde1lknpBWSZ
    R7/xeWWq34fdHaF8Le7KwFrs+RzibaptILTv4sRINKn1da+t1GFzcRrTXySOzg3kSh27
    JAPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785850990;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=vNaMOVWqpqcQYPovYo4vSvPCciq5QtjfWTYRHoKok2E=;
    b=djB1MVHaGfTyA3OTJ+sH4MywP6F95U5ybBHxbQcyy0IK6aFYYltxNw8ID8H8UFS9XK
    Jyvstfpe+prlUsWJKeAQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKfF+CjmMA=="
Received: from open-xchange-core-mw-gw-16.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.5.6 AUTH)
    with ESMTPSA id zec9ec274DhABEJ
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 4 Aug 2026 15:43:10 +0200 (CEST)
Date: Tue, 4 Aug 2026 15:43:10 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1672269011.888387.1785850990322@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.19.325-cip135
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.152
X-Originating-Port: 52638
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Aug 2026 13:43:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23865

Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip135. The linux-4.19.y-cip tree's base version has been updated to v4.19-st19. The trees are up-to-date with kernel 5.10.260.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/

  v4.19.325-cip135:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      ba1643922563de1987b5cb0ed4a4b869ae1c3147
    Fixed CVEs:
      CVE-2021-47211: ALSA: usb-audio: fix null pointer dereference on pointer cs_desc
      CVE-2022-50114: net: 9p: fix refcount leak in p9_read_work() error handling
      CVE-2025-40164: usbnet: Fix using smp_processor_id() in preemptible code warnings
      CVE-2025-68340: team: Move team device type change at the end of team_port_add
      CVE-2025-10263: TLBI errata in some Arm-based CPUs may allow writes to resources owned by a higher exception level, potentially allowing privilege escalation
      CVE-2025-23131: dlm: prevent NPD when writing a positive value to event_done
      CVE-2026-46331: net/sched: fix pedit partial COW leading to page cache corruption
      CVE-2026-52909: ip6_vti: set netns_immutable on the fallback device.
      CVE-2026-52910: bpf: Free reuseport cBPF prog after RCU grace period.
      CVE-2026-52924: sctp: purge outqueue on stale COOKIE-ECHO handling
      CVE-2026-52929: sctp: stream: fully roll back denied add-stream state
      CVE-2026-52930: ipc/shm: serialize orphan cleanup with shm_nattch updates
      CVE-2026-52939: net/rds: fix NULL deref in rds_ib_send_cqe_handler() on masked atomic completion
      CVE-2026-52946: fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync signaling
      CVE-2026-52948: i2c: dev: prevent integer overflow in I2C_TIMEOUT ioctl
      CVE-2026-53138: drm/amd/display: Bound VBIOS record-chain walk loops
      CVE-2026-53146: thunderbolt: Limit XDomain response copy to actual frame size
      CVE-2026-53148: thunderbolt: Clamp XDomain response data copy to allocation size
      CVE-2026-53149: thunderbolt: Bound root directory content to block size
      CVE-2026-53150: thunderbolt: Reject zero-length property entries in validator
      CVE-2026-53157: net: phonet: free phonet_device after RCU grace period
      CVE-2026-53176: IB/isert: Reject login PDUs shorter than ISER_HEADERS_LEN
      CVE-2026-53177: bnxt_en: Fix NULL pointer dereference
      CVE-2026-53181: vsock/vmci: fix sk_ack_backlog leak on failed handshake
      CVE-2026-53186: RDMA/srp: bound SRP_RSP sense copy by the received length
      CVE-2026-53189: mm/huge_memory: update file PMD counter before folio_put()
      CVE-2026-53194: USB: serial: kl5kusb105: fix bulk-out buffer overflow
      CVE-2026-53195: USB: serial: io_ti: fix heap overflow in build_i2c_fw_hdr()
      CVE-2026-53196: USB: serial: io_ti: fix heap overflow in get_manuf_info()
      CVE-2026-53208: Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
      CVE-2026-53212: netfilter: nft_tunnel: fix use-after-free on object destroy
      CVE-2026-53218: netfilter: nft_exthdr: fix register tracking for F_PRESENT flag
      CVE-2026-53219: netfilter: x_tables: avoid leaking percpu counter pointers
      CVE-2026-53221: ip6_vti: fix incorrect tunnel matching in vti6_tnl_lookup()
      CVE-2026-53223: net: guard timestamp cmsgs to real error queue skbs
      CVE-2026-53225: sctp: fix uninit-value in __sctp_rcv_asconf_lookup()
      CVE-2026-53227: net: openvswitch: fix possible kfree_skb of ERR_PTR
      CVE-2026-53228: ipv6: sit: reload inner IPv6 header after GSO offloads
      CVE-2026-53245: net/802/mrp: fix vector attribute parsing in mrp_pdu_parse_vecattr
      CVE-2026-53249: ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
      CVE-2026-53255: Bluetooth: MGMT: validate advertising TLV before type checks
      CVE-2026-53256: Bluetooth: RFCOMM: hold listener socket in rfcomm_connect_ind()
      CVE-2026-53263: 6lowpan: fix off-by-one in multicast context address compression
      CVE-2026-53265: dm cache policy smq: check allocation under invalidate lock
      CVE-2026-53266: netfilter: bridge: make ebt_snat ARP rewrite writable
      CVE-2026-53268: netfilter: conntrack_irc: fix possible out-of-bounds read
      CVE-2026-53270: ipvs: clear the svc scheduler ptr early on edit
      CVE-2026-53273: tee: optee: prevent use-after-free when the client exits before the supplicant
      CVE-2026-53325: agp/amd64: Fix broken error propagation in agp_amd64_probe()
      CVE-2026-53329: drm/amd/display: Use krealloc_array() in dal_vector_reserve()
      CVE-2026-53352: signal: clear JOBCTL_PENDING_MASK for caller in zap_other_threads()
      CVE-2026-53385: vc_screen: fix null-ptr-deref in vcs_notifier() during concurrent vcs_write
      CVE-2026-53397: nfsd: fix posix_acl leak on SETACL decode failure
      CVE-2026-63794: KVM: SVM: Fix page overflow in sev_dbg_crypt() for ENCRYPT path
      CVE-2026-63796: ocfs2: reject oversized group bitmap descriptors
      CVE-2026-63814: f2fs: validate ACL entry sizes in f2fs_acl_from_disk()
      CVE-2026-63831: mac802154: llsec: add skb_cow_data() before in-place crypto
      CVE-2026-63834: batman-adv: tp_meter: restrict number of unacked list entries
      CVE-2026-63836: batman-adv: tp_meter: avoid divide-by-zero for dec_cwnd
      CVE-2026-63868: net: garp: fix unsigned integer underflow in garp_pdu_parse_attr
      CVE-2026-63870: ieee802154: 6lowpan: only accept IPv6 packets in lowpan_xmit()
      CVE-2026-64188: net: qualcomm: rmnet: fix endpoint use-after-free in rmnet_dellink()
      CVE-2026-64191: i2c: stub: Reject I2C block transfers with invalid length
      CVE-2026-64249: fpga: region: fix use-after-free in child_regions_with_firmware()
      CVE-2026-31449: ext4: validate p_idx bounds in ext4_ext_correct_indexes
      CVE-2026-31451: ext4: replace BUG_ON with proper error handling in ext4_read_inline_folio
      CVE-2026-31700: net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()
      CVE-2026-31715: f2fs: fix UAF caused by decrementing sbi->nr_pages[] in f2fs_write_end_io()
      CVE-2026-43492: lib/crypto: mpi: Fix integer underflow in mpi_read_raw_from_sgl()
      CVE-2026-45991: udf: fix partition descriptor append bookkeeping
      CVE-2026-46021: thermal: core: Fix thermal zone governor cleanup issues
      CVE-2026-46052: ceph: only d_add() negative dentries when they are unhashed
      CVE-2026-46056: Bluetooth: hci_event: fix potential UAF in SSP passkey handlers
      CVE-2026-46069: wifi: mwifiex: fix use-after-free in mwifiex_adapter_cleanup()
      CVE-2026-46086: net: bridge: use a stable FDB dst snapshot in RCU readers
      CVE-2026-46091: media: rc: igorplugusb: heed coherency rules
      CVE-2026-46103: can: ucan: fix devres lifetime
      CVE-2026-46159: btrfs: fix btrfs_ioctl_space_info() slot_count TOCTOU which can lead to info-leak
      CVE-2026-46160: btrfs: fix missing last_unlink_trans update when removing a directory
      CVE-2026-46180: wifi: brcmfmac: Fix potential use-after-free issue when stopping watchdog task
      CVE-2026-46191: fbcon: Avoid OOB font access if console rotation fails
      CVE-2026-46196: tracepoint: balance regfunc() on func_add() failure in tracepoint_add_func()
      CVE-2026-46208: batman-adv: stop tp_meter sessions during mesh teardown
      CVE-2026-46292: pmdomain: core: Fix detach procedure for virtual devices in genpd
      CVE-2026-52927: netfilter: ebtables: fix OOB read in compat_mtw_from_user
      CVE-2026-52934: batman-adv: tvlv: reject oversized TVLV packets
      CVE-2026-52943: net: skbuff: fix missing zerocopy reference in pskb_carve helpers
      CVE-2026-53080: net/sched: cls_fw: fix NULL dereference of "old" filters before change()
      CVE-2026-53357: Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()
      CVE-2026-53358: Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()
      CVE-2026-63887: scsi: target: iscsi: Bound iscsi_encode_text_output() appends to rsp_buf
      CVE-2026-63888: scsi: target: iscsi: Fix CRC overread and double-free in iscsit_handle_text_cmd()
      CVE-2026-63890: scsi: fcoe: Reject FIP descriptors with zero fip_dlen in CVL walker
      CVE-2026-63891: thunderbolt: property: Cap recursion depth in __tb_property_parse_dir()
      CVE-2026-63892: thunderbolt: property: Reject dir_len < 4 to prevent size_t underflow
      CVE-2026-63893: thunderbolt: property: Reject u32 wrap in tb_property_entry_valid()
      CVE-2026-63897: USB: serial: mct_u232: fix missing interrupt-in transfer sanity check
      CVE-2026-63898: USB: serial: mct_u232: fix memory corruption with small endpoint
      CVE-2026-63899: USB: serial: mxuport: fix memory corruption with small endpoint
      CVE-2026-63900: USB: serial: keyspan: fix missing indat transfer sanity check
      CVE-2026-63901: USB: serial: digi_acceleport: fix memory corruption with small endpoints
      CVE-2026-63902: USB: serial: cypress_m8: validate interrupt packet headers
      CVE-2026-63903: USB: serial: belkin_sa: validate interrupt status length
      CVE-2026-63904: usb: usbtmc: check URB actual_length for interrupt-IN notifications
      CVE-2026-63908: Input: atmel_mxt_ts - fix boundary check in mxt_prepare_cfg_mem
      CVE-2026-63912: xfrm: esp: restore combined single-frag length gate
      CVE-2026-63913: netfilter: conntrack: tcp: do not force CLOSE on invalid-seq RST without direction check
      CVE-2026-63914: xfrm: route MIGRATE notifications to caller's netns
      CVE-2026-63915: nfc: hci: fix out-of-bounds read in HCP header parsing
      CVE-2026-63916: HID: wacom: Fix OOB write in wacom_hid_set_device_mode()
      CVE-2026-63917: ip6: vti: Use ip6_tnl.net in vti6_changelink().
      CVE-2026-63920: ipv6: validate extension header length before copying to cmsg
      CVE-2026-63921: ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().
      CVE-2026-63924: ipv6: exthdrs: refresh nh pointer after ipv6_hop_jumbo()
      CVE-2026-63927: usb: dwc2: Fix use after free in debug code
      CVE-2026-63928: USB: serial: omninet: fix memory corruption with small endpoint
      CVE-2026-63930: iio: buffer: hw-consumer: fix use-after-free in error path
      CVE-2026-63933: iio: gyro: adis16260: fix division by zero in write_raw
      CVE-2026-63934: iio: gyro: itg3200: fix i2c read into the wrong stack location
      CVE-2026-63942: parport: Fix race between port and client registration
      CVE-2026-63948: Bluetooth: L2CAP: fix chan ref leak in l2cap_chan_timeout() on !conn
      CVE-2026-63954: hpfs: fix a crash if hpfs_map_dnode_bitmap fails
      CVE-2026-63956: USB: serial: cypress_m8: fix memory corruption with small endpoint
      CVE-2026-63957: USB: serial: safe_serial: fix memory corruption with small endpoint
      CVE-2026-63960: usb: typec: wcove: don't write past struct pd_message in wcove_read_rx_buffer()
      CVE-2026-63961: usb: typec: altmodes/displayport: validate count before reading Status Update VDO
      CVE-2026-63971: sctp: fix race between sctp_wait_for_connect and peeloff
      CVE-2026-63991: Bluetooth: 6lowpan: check skb_clone() return value in send_mcast_pkt()
      CVE-2026-63993: vxlan: do not reuse cached ip_hdr() value after skb_tunnel_check_pmtu()
      CVE-2026-64002: ipv4: free net->ipv4.sysctl_local_reserved_ports after unregister_net_sysctl_table()
      CVE-2026-64004: net/iucv: fix locking in .getsockopt
      CVE-2026-64005: net/smc: Do not re-initialize smc hashtables
      CVE-2026-64007: netfilter: synproxy: refresh tcphdr after skb_ensure_writable
      CVE-2026-64010: nfc: llcp: Fix use-after-free race in nfc_llcp_recv_cc()
      CVE-2026-64011: nfc: llcp: Fix use-after-free in llcp_sock_release()
      CVE-2026-64012: net/sched: sch_sfb: Replace direct dequeue call with peek and qdisc_dequeue_peeked
      CVE-2026-64014: Input: usbtouchscreen - clamp NEXIO data_len/x_len to URB buffer size
      CVE-2026-64090: batman-adv: tt: avoid empty VLAN responses
      CVE-2026-64091: batman-adv: tt: fix TOCTOU race for reported vlans
      CVE-2026-64094: batman-adv: bla: avoid NULL-ptr deref for claim via dropped interface
      CVE-2026-64095: batman-adv: bla: avoid double decrement of bla.num_requests
      CVE-2026-64118: qed: fix double free in qed_cxt_tables_alloc()
      CVE-2026-64234: tty: serial: pch_uart: add check for dma_alloc_coherent()
      CVE-2026-64237: Input: elan_i2c - validate firmware size before use
      CVE-2026-64240: media: rc: igorplugusb: fix control request setup packet
      CVE-2026-64242: usb: gadget: net2280: Fix double free in probe error path
      CVE-2025-38250: Bluetooth: hci_core: Fix use-after-free in vhci_flush()
      CVE-2026-23204: net/sched: cls_u32: use skb_header_pointer_careful()
      CVE-2026-31489: spi: meson-spicc: Fix double-put in remove path
      CVE-2026-43052: wifi: mac80211: check tdls flag in ieee80211_tdls_oper
      CVE-2026-46006: drm/nouveau: fix u32 overflow in pushbuf reloc bounds check
      CVE-2026-46107: dm-thin: fix metadata refcount underflow
      CVE-2026-52912: netfilter: nf_queue: hold bridge skb->dev while queued
      CVE-2026-53167: fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios
      CVE-2026-53264: net/sched: act_api: use RCU with deferred freeing for action lifecycle
      CVE-2026-53354: arm64: errata: Mitigate TLBI errata on various Arm CPUs

Best regards,
Ulrich Hecht

