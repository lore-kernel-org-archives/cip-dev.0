Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE84CD4F54
	for <webhook@archiver.kernel.org>; Wed, 20 May 2026 11:16:10 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9771.1779275760490643341
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 May 2026 04:16:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=jRHhfXOE;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=LrYMZZRC;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.219, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1779275734; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HrMHwVbK26UEKIn1CtjrTPKTTpeHcG/VouGYR34wOJyUbctAzbFJq2Vg1cO9pZCyfv
    q9wFqLNP7bI8T6sUGr9WACv+SMRSs6IN43/L7Xbw4U2ivnFQfWMRq3ZFCF8Ib0GQxwJv
    ieHuahloj3PHJjNBoe4UdTQiC2muoM5Yg52RXBtO9yapWYBOmJ1Z04QWAWSAMjc8Xlri
    C6HNpc5gfZN/xbLqVoLDry420RBE7cmx6+Qol4Ov/F7sKIMY8EFaK00P5nuPKZb2HrwH
    guTUjp1+jGj2tKrra18PsrAgwqQlin4wh5LR9sorBGBtehKGnFHd/RMkVAEw8+iBPpVl
    9EdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779275734;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=/w8RduUSFqq1Ktqki1FXzWQSUAyuoVKL1sOsXUnsb+A=;
    b=r0CiVLN6nL0GpAl0NPjbz+TAa5MaJzdANMDYLx2gN3tPEvJCes3GKVeRvZfkaNxQQM
    CxhN6bnGwnPDx8baiuE5lw/rdcs1muowsaozenBI5rfPrIMlO2zBdfRhYjPWOztvo4bg
    y5Qg4MoWOYbKSGKiYp48GcegeMY55n55yNOKlaVq3HOryIPUryZc+UmgmLQRtzQH/Nh/
    ejTCi75RDN/srHJA0K1b3PqPgeodyOHcYirk5irQ8BzMqiHqhMqHsprZxNhUJe1FMwqx
    Aru7skb0JOZl9qfdODaLaorVQNN0RyUGbeXBLVje6BRc7JdTrgM9jvZRM97lmfuADvyd
    cAaQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779275734;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=/w8RduUSFqq1Ktqki1FXzWQSUAyuoVKL1sOsXUnsb+A=;
    b=jRHhfXOEM1Y5DCq21hJKmsSyXbKn7MnrD7nlsoDJdX/NUllyWa1WvxvyAAwuPJObbn
    UhODzAAskHfzDawpFyjkbbH9TbPuLq6TPVbXqAeqIgGAkqkn3aXCBZTwwtgHxBNmIL19
    RTczEwJARlFrWDDJ+cM+DhvLvgiaZm0tnMAwRaiINrGPTGN9CgUAxN4RQbupQ/QUuGXI
    WDAsmmGdXkUkQNrVz3kdTZTxvzZpou7tjA0IRVW7iogG6Ra1edQkVeYjr3JgxvDcxacL
    FOmAMNEvRuRmX03riWhpy8v6S6KNqi7jA4y5lqQDXWgDMZgBDS4WjHlCaXbwRnMq1qio
    1xJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779275734;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=/w8RduUSFqq1Ktqki1FXzWQSUAyuoVKL1sOsXUnsb+A=;
    b=LrYMZZRC6sgK3DkhD47Ar0J48JrwRQ3cjzftNX33EZNwZ2LdZC2yzZxVdaPKkB21cW
    xugfGVY6A5TAhn8Q9EDw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKDG+LdTmA=="
Received: from open-xchange-core-mw-gw-16.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e24KBFX6Pu
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 20 May 2026 13:15:33 +0200 (CEST)
Date: Wed, 20 May 2026 13:15:33 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1481865007.142047.1779275733476@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip111
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.134
X-Originating-Port: 56980
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 May 2026 11:16:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22984

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip111. The linux-4.4.y-cip tree's base version has been updated to v4.4-st76. The trees are up-to-date with kernel 4.19-st16.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip111:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      90c0c4bac1b0e1fc4663395c5eb4e488ed372815
    Fixed CVEs:
      CVE-2025-38693: media: dvb-frontends: w7090p: fix null-ptr-deref in w7090p_tuner_write_serpar and w7090p_tuner_read_serpar
      CVE-2025-39764: netfilter: ctnetlink: remove refcounting in expectation dumpers
      CVE-2025-54505: x86/CPU: Fix FPDSS on Zen1
      CVE-2026-23253: media: dvb-core: fix wrong reinitialization of ringbuffer on reopen
      CVE-2026-23277: net/sched: teql: fix NULL pointer dereference in iptunnel_xmit on TEQL slave xmit
      CVE-2026-23279: wifi: mac80211: fix NULL pointer dereference in mesh_rx_csa_frame()
      CVE-2026-23281: wifi: libertas: fix use-after-free in lbs_free_adapter()
      CVE-2026-23286: atm: lec: fix null-ptr-deref in lec_arp_clear_vccs
      CVE-2026-23290: net: usb: pegasus: validate USB endpoints
      CVE-2026-23293: net: vxlan: fix nd_tbl NULL dereference when IPv6 is disabled
      CVE-2026-23303: smb: client: Don't log plaintext credentials in cifs_set_cifscreds
      CVE-2026-23307: can: ems_usb: ems_usb_read_bulk_callback(): check the proper length of a message
      CVE-2026-23312: net: usb: kaweth: validate USB endpoints
      CVE-2026-23339: nfc: nci: free skb on nci_transceive early error paths
      CVE-2026-23356: drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()
      CVE-2026-23365: net: usb: kalmia: validate USB endpoints
      CVE-2026-23367: wifi: radiotap: reject radiotap with unknown bits
      CVE-2026-23372: nfc: rawsock: cancel tx_work before socket teardown
      CVE-2026-23388: Squashfs: check metadata block offset is within range
      CVE-2026-23396: wifi: mac80211: fix NULL deref in mesh_matches_local()
      CVE-2026-23398: icmp: fix NULL pointer dereference in icmp_tag_validation()
      CVE-2026-23403: apparmor: fix memory leak in verify_header
      CVE-2026-23439: udp_tunnel: fix NULL deref caused by udp_sock_create6 when CONFIG_IPV6=n
      CVE-2026-23452: PM: runtime: Fix a race condition related to device removal
      CVE-2026-23455: netfilter: nf_conntrack_h323: check for zero length in DecodeQ931()
      CVE-2026-23457: netfilter: nf_conntrack_sip: fix Content-Length u32 truncation in sip_help_tcp()
      CVE-2026-23458: netfilter: ctnetlink: fix use-after-free in ctnetlink_dump_exp_ct()
      CVE-2026-23460: net/rose: fix NULL pointer dereference in rose_transmit_link on reconnect
      CVE-2026-23462: Bluetooth: HIDP: Fix possible UAF
      CVE-2026-31393: Bluetooth: L2CAP: Validate L2CAP_INFO_RSP payload length before access
      CVE-2026-31399: nvdimm/bus: Fix potential use after free in asynchronous initialization
      CVE-2026-31402: nfsd: fix heap overflow in NFSv4.0 LOCK replay cache
      CVE-2026-31405: media: dvb-net: fix OOB access in ULE extension header tables
      CVE-2026-31415: ipv6: avoid overflows in ip6_datagram_send_ctl()
      CVE-2026-31416: netfilter: nfnetlink_log: account for netlink header size
      CVE-2026-31417: net/x25: Fix overflow when accumulating packets
      CVE-2026-31423: net/sched: sch_hfsc: fix divide-by-zero in rtsc_min()
      CVE-2026-31424: netfilter: x_tables: restrict xt_check_match/xt_check_target extensions for NFPROTO_ARP
      CVE-2026-31427: netfilter: nf_conntrack_sip: fix use of uninitialized rtp_addr in process_sdp
      CVE-2026-31428: netfilter: nfnetlink_log: fix uninitialized padding leak in NFULA_PAYLOAD
      CVE-2026-31447: ext4: reject mount if bigalloc with s_first_data_block != 0
      CVE-2026-31452: ext4: convert inline data to extents when truncate exceeds inline size
      CVE-2026-31464: scsi: ibmvfc: Fix OOB access in ibmvfc_discover_targets_done()
      CVE-2026-31466: mm/huge_memory: fix folio isn't locked in softleaf_to_folio()
      CVE-2026-31469: virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
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
      CVE-2026-31670: net: rfkill: prevent unlimited numbers of rfkill events from being created
      CVE-2026-31671: xfrm_user: fix info leak in build_report()
      CVE-2026-31674: netfilter: ip6t_rt: reject oversized addrnr in rt_mt6_check()
      CVE-2026-31679: openvswitch: validate MPLS set/set_masked payload length
      CVE-2026-31680: net: ipv6: flowlabel: defer exclusive option free until RCU teardown
      CVE-2026-31683: batman-adv: avoid OGM aggregation when skb tailroom is insufficient
      CVE-2026-31728: usb: gadget: u_ether: Fix race between gether_disconnect and eth_stop
      CVE-2026-31738: vxlan: validate ND option lengths in vxlan_na_create
      CVE-2026-31747: comedi: me4000: Fix potential overrun of firmware buffer
      CVE-2026-31748: comedi: me_daq: Fix potential overrun of firmware buffer
      CVE-2026-31749: comedi: ni_atmio16d: Fix invalid clean-up after failed attach
      CVE-2026-31751: comedi: dt2815: add hardware detection to prevent crash
      CVE-2026-31759: usb: ulpi: fix double free in ulpi_register_interface() error path
      CVE-2026-31773: Bluetooth: SMP: derive legacy responder STK authentication from MITM state
      CVE-2026-31776: ALSA: ctxfi: Fix missing SPDIFI1 index handling
      CVE-2026-31778: ALSA: caiaq: fix stack out-of-bounds read in init_card
      CVE-2026-43011: net/x25: Fix potential double free of skb
      CVE-2026-43020: Bluetooth: MGMT: validate LTK enc_size on load
      CVE-2026-43026: netfilter: ctnetlink: zero expect NAT fields when CTA_EXPECT_NAT absent
      CVE-2026-43037: ip6_tunnel: clear skb2->cb[] in ip4ip6_err()
      CVE-2026-43040: net: ipv6: ndisc: fix ndisc_ra_useropt to initialize nduseropt_padX fields to zero to prevent an info-leak
      CVE-2026-43047: HID: multitouch: Check to ensure report responses match the request
      CVE-2026-43050: atm: lec: fix use-after-free in sock_def_readable()
      CVE-2026-43051: HID: wacom: fix out-of-bounds read in wacom_intuos_bt_irq
      CVE-2026-43068: ext4: avoid allocate block from corrupted group in ext4_mb_find_by_goal()
      CVE-2026-43327: USB: dummy-hcd: Fix locking/synchronization error
      CVE-2026-43334: Bluetooth: SMP: force responder MITM requirements before building the pairing response
      CVE-2026-43340: comedi: Reinit dev->spinlock between attachments to low-level drivers
      CVE-2026-43363: x86/apic: Disable x2apic on resume if the kernel expects so
      CVE-2026-43381: nouveau/dpcd: return EBUSY for aux xfer if the device is asleep
      CVE-2026-43383: net/tcp-md5: Fix MAC comparison to be constant-time
      CVE-2026-43407: libceph: Fix potential out-of-bounds access in ceph_handle_auth_reply()
      CVE-2026-43425: usb: image: mdc800: kill download URB on timeout
      CVE-2026-43427: usb: class: cdc-wdm: fix reordering issue in read code path
      CVE-2026-43430: usb: yurex: fix race in probe
      CVE-2026-43445: e1000/e1000e: Fix leak in DMA error cleanup
      CVE-2026-43450: netfilter: nfnetlink_cthelper: fix OOB read in nfnl_cthelper_dump_table()
      CVE-2026-43452: netfilter: x_tables: guard option walkers against 1-byte tail reads
      CVE-2026-43458: serial: caif: hold tty->link reference in ldisc_open and ser_release
      CVE-2026-43472: unshare: fix unshare_fs() handling

Best regards,
Ulrich Hecht

