Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1DBC5B572
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 14:38:50 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8580.1787150324933890521
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Aug 2026 07:38:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=WV9WhKkI;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=lykj/3sb;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.217, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1787150293; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UvN6hMA0g8iiZ+jbdlGH61fdhrmLNaHu4aGh72gY0wbevtb0SvAmD4BOeZljtw+QD0
    neHWPIIXaHUxrBpgP5VBkj54XSyVPvktDQnGLbMDuxckDbtRMyZCvMTl1EYRyuRkW9vz
    17H0h+0f7Is46EqanM1Pgp/BCkQ0Vl9KjLs46Je0eFp8G7MYeqP7KC4GaGRK82L65Etw
    udKAm+D9EX2exFkffQMMlhKTpBxp+SAHppr65gBHX/6LdnlTGxMo4TXU4D/vOXokYWMH
    ORft8PtkCrdp4ErPrIBwjA5Bfcb5ZIq1nLAZumzuCePse6FF76X4ULQuTozcgaeV+f5h
    9/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787150293;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=2178XRuwwx4+32vsbGsmEBdQ7Wyks5VbcWYc+q05d0c=;
    b=SyQo0dl7y8Syk02uHEbX9oomQetWoAAnqkWpKAWHrzCRyCSXwvWB4Hioz3s9kyNd9A
    tRoM5lNZ/p63P8TtUQWbE5EgVilNMrBWIInIfEESHuyqkCgVDEmLWhnXQOdfDcObynXh
    QnPCXmqg2SVZma1QIZITTkzzkpkkyprnXqqMHUDOSRE8FgzIpgyu9/4vypp+gPojhFpY
    BsF74S6oqHzScOkRJFEV0pp1hz7Jcfu2djv++cb7sR/wFT2t4EP6GeDyBimOxA3HA+rw
    wn15586+L0TTG+fKVCJ4CWNqnReORRFULDOpwFJsF7tuZP/v98VZYaUJxOqQGVaLXTLr
    joaQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787150293;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=2178XRuwwx4+32vsbGsmEBdQ7Wyks5VbcWYc+q05d0c=;
    b=WV9WhKkIAkY39WVYN39+VkGHS346CPSf6E/j27qrfdkyn/QQcMfk0UeUaF9SoBXf2Y
    cWdYTOxkD4fqTXWsbtN2jTzChURlHTcOfPZWfft7mVSA890P2CBn0jErbHCTAJmXSzYj
    vzppCPpDI6+t+5Wd9FNoEygv7DVt4YJOpj982+eivzyqoEj5uRHBhVFLcXM/+DzPgywb
    huaZMBa387FGCDAMMXN6KKcRhcu4Wa2QlH/BkjFFykg4CcaEci5DwAQcYfKsvh54daxN
    77Zue5XOyPRGGah9f7XfSsm+9WinKlSsiVQHPCjb0CJiDkwXNNVVPoshsz2xBWnoUEzb
    jkVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787150293;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=2178XRuwwx4+32vsbGsmEBdQ7Wyks5VbcWYc+q05d0c=;
    b=lykj/3sbxLFgr47BJLaHP0GFu+HDBV4BIg3Jm7mA7KAbRzcyH/3T7qCn8LIb1MRaod
    xTSlCcOlgVqsbJqNblCQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6zd5FloUw=="
Received: from open-xchange-core-mw-gw-28.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.6.2 AUTH)
    with ESMTPSA id ze24d927JEcC7tW
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 19 Aug 2026 16:38:12 +0200 (CEST)
Date: Wed, 19 Aug 2026 16:38:12 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <2012362130.680732.1787150292144@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip114
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.154
X-Originating-Port: 50578
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Aug 2026 14:38:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23951

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip114. The linux-4.4.y-cip tree's base version has been updated to v4.4-st79. The trees are up-to-date with kernel 4.19-st19.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip114:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      c67c23ae791bfc624c927c9d9f02fe2c76a891b8
    Fixed CVEs:
      CVE-2021-47211: ALSA: usb-audio: fix null pointer dereference on pointer cs_desc
      CVE-2025-23131: dlm: prevent NPD when writing a positive value to event_done
      CVE-2025-38250: Bluetooth: hci_core: Fix use-after-free in vhci_flush()
      CVE-2026-23204: net/sched: cls_u32: use skb_header_pointer_careful()
      CVE-2026-31449: ext4: validate p_idx bounds in ext4_ext_correct_indexes
      CVE-2026-31451: ext4: replace BUG_ON with proper error handling in ext4_read_inline_folio
      CVE-2026-43052: wifi: mac80211: check tdls flag in ieee80211_tdls_oper
      CVE-2026-46006: drm/nouveau: fix u32 overflow in pushbuf reloc bounds check
      CVE-2026-46021: thermal: core: Fix thermal zone governor cleanup issues
      CVE-2026-46052: ceph: only d_add() negative dentries when they are unhashed
      CVE-2026-46056: Bluetooth: hci_event: fix potential UAF in SSP passkey handlers
      CVE-2026-46069: wifi: mwifiex: fix use-after-free in mwifiex_adapter_cleanup()
      CVE-2026-46107: dm-thin: fix metadata refcount underflow
      CVE-2026-46159: btrfs: fix btrfs_ioctl_space_info() slot_count TOCTOU which can lead to info-leak
      CVE-2026-46180: wifi: brcmfmac: Fix potential use-after-free issue when stopping watchdog task
      CVE-2026-46191: fbcon: Avoid OOB font access if console rotation fails
      CVE-2026-52909: ip6_vti: set netns_immutable on the fallback device.
      CVE-2026-52924: sctp: purge outqueue on stale COOKIE-ECHO handling
      CVE-2026-52927: netfilter: ebtables: fix OOB read in compat_mtw_from_user
      CVE-2026-52930: ipc/shm: serialize orphan cleanup with shm_nattch updates
      CVE-2026-52939: net/rds: fix NULL deref in rds_ib_send_cqe_handler() on masked atomic completion
      CVE-2026-52946: fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync signaling
      CVE-2026-52948: i2c: dev: prevent integer overflow in I2C_TIMEOUT ioctl
      CVE-2026-53157: net: phonet: free phonet_device after RCU grace period
      CVE-2026-53167: fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios
      CVE-2026-53181: vsock/vmci: fix sk_ack_backlog leak on failed handshake
      CVE-2026-53186: RDMA/srp: bound SRP_RSP sense copy by the received length
      CVE-2026-53194: USB: serial: kl5kusb105: fix bulk-out buffer overflow
      CVE-2026-53195: USB: serial: io_ti: fix heap overflow in build_i2c_fw_hdr()
      CVE-2026-53196: USB: serial: io_ti: fix heap overflow in get_manuf_info()
      CVE-2026-53208: Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
      CVE-2026-53221: ip6_vti: fix incorrect tunnel matching in vti6_tnl_lookup()
      CVE-2026-53225: sctp: fix uninit-value in __sctp_rcv_asconf_lookup()
      CVE-2026-53227: net: openvswitch: fix possible kfree_skb of ERR_PTR
      CVE-2026-53228: ipv6: sit: reload inner IPv6 header after GSO offloads
      CVE-2026-53245: net/802/mrp: fix vector attribute parsing in mrp_pdu_parse_vecattr
      CVE-2026-53249: ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
      CVE-2026-53256: Bluetooth: RFCOMM: hold listener socket in rfcomm_connect_ind()
      CVE-2026-53266: netfilter: bridge: make ebt_snat ARP rewrite writable
      CVE-2026-53268: netfilter: conntrack_irc: fix possible out-of-bounds read
      CVE-2026-53270: ipvs: clear the svc scheduler ptr early on edit
      CVE-2026-53325: agp/amd64: Fix broken error propagation in agp_amd64_probe()
      CVE-2026-53352: signal: clear JOBCTL_PENDING_MASK for caller in zap_other_threads()
      CVE-2026-53357: Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()
      CVE-2026-53358: Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()
      CVE-2026-53385: vc_screen: fix null-ptr-deref in vcs_notifier() during concurrent vcs_write
      CVE-2026-53397: nfsd: fix posix_acl leak on SETACL decode failure
      CVE-2026-63796: ocfs2: reject oversized group bitmap descriptors
      CVE-2026-63814: f2fs: validate ACL entry sizes in f2fs_acl_from_disk()
      CVE-2026-63831: mac802154: llsec: add skb_cow_data() before in-place crypto
      CVE-2026-63868: net: garp: fix unsigned integer underflow in garp_pdu_parse_attr
      CVE-2026-63870: ieee802154: 6lowpan: only accept IPv6 packets in lowpan_xmit()
      CVE-2026-63887: scsi: target: iscsi: Bound iscsi_encode_text_output() appends to rsp_buf
      CVE-2026-63888: scsi: target: iscsi: Fix CRC overread and double-free in iscsit_handle_text_cmd()
      CVE-2026-63890: scsi: fcoe: Reject FIP descriptors with zero fip_dlen in CVL walker
      CVE-2026-63897: USB: serial: mct_u232: fix missing interrupt-in transfer sanity check
      CVE-2026-63898: USB: serial: mct_u232: fix memory corruption with small endpoint
      CVE-2026-63900: USB: serial: keyspan: fix missing indat transfer sanity check
      CVE-2026-63901: USB: serial: digi_acceleport: fix memory corruption with small endpoints
      CVE-2026-63902: USB: serial: cypress_m8: validate interrupt packet headers
      CVE-2026-63903: USB: serial: belkin_sa: validate interrupt status length
      CVE-2026-63908: Input: atmel_mxt_ts - fix boundary check in mxt_prepare_cfg_mem
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
      CVE-2026-63933: iio: gyro: adis16260: fix division by zero in write_raw
      CVE-2026-63934: iio: gyro: itg3200: fix i2c read into the wrong stack location
      CVE-2026-63948: Bluetooth: L2CAP: fix chan ref leak in l2cap_chan_timeout() on !conn
      CVE-2026-63954: hpfs: fix a crash if hpfs_map_dnode_bitmap fails
      CVE-2026-63956: USB: serial: cypress_m8: fix memory corruption with small endpoint
      CVE-2026-63957: USB: serial: safe_serial: fix memory corruption with small endpoint
      CVE-2026-63971: sctp: fix race between sctp_wait_for_connect and peeloff
      CVE-2026-63991: Bluetooth: 6lowpan: check skb_clone() return value in send_mcast_pkt()
      CVE-2026-64002: ipv4: free net->ipv4.sysctl_local_reserved_ports after unregister_net_sysctl_table()
      CVE-2026-64004: net/iucv: fix locking in .getsockopt
      CVE-2026-64007: netfilter: synproxy: refresh tcphdr after skb_ensure_writable
      CVE-2026-64010: nfc: llcp: Fix use-after-free race in nfc_llcp_recv_cc()
      CVE-2026-64011: nfc: llcp: Fix use-after-free in llcp_sock_release()
      CVE-2026-64012: net/sched: sch_sfb: Replace direct dequeue call with peek and qdisc_dequeue_peeked
      CVE-2026-64014: Input: usbtouchscreen - clamp NEXIO data_len/x_len to URB buffer size
      CVE-2026-64090: batman-adv: tt: avoid empty VLAN responses
      CVE-2026-64091: batman-adv: tt: fix TOCTOU race for reported vlans
      CVE-2026-64094: batman-adv: bla: avoid NULL-ptr deref for claim via dropped interface
      CVE-2026-64191: i2c: stub: Reject I2C block transfers with invalid length
      CVE-2026-64234: tty: serial: pch_uart: add check for dma_alloc_coherent()
      CVE-2026-64237: Input: elan_i2c - validate firmware size before use
      CVE-2026-64242: usb: gadget: net2280: Fix double free in probe error path

Best regards,
Ulrich Hecht

