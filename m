Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10603.1794480831563334622
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2026 02:53:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=UFn0/m4t;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=JwYSeipN;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.22, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1794480814; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VswB/NHkC4DUPAXpmCIdFR9FrDUvXlRaFO9PAi4Qba0iJUUxDFpm0PDl1bnu6Jhmyu
    IJwgE+2AilIC78Llqu39SyZP+S/hTpJBlHO0Q47TffcvoAHF6SUIBoA+zGDwPXzOt2J3
    GXN2H/aL9QUf2SnL8c6XAsKpi4blY2JV2bMmzIxD39c7tO5IOkH8lL7FGQKthwQksubb
    R8KrrgqK04bsZtNA4SXtFzVv8c7pipftLkP6XSXBXw/lD7oBY9t07pyvgWp8WqyeCge0
    AoqymG3TJsJWQqAORaSMhG/Kajz2ZPFstkTDtb7Cy/vg7hveTnvf33DDmhvtxWf2tbV7
    EflA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794480814;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=t1OE7YqzkHXLmGIbyWLImlNJ4K0tmvk730OFqWxRzpI=;
    b=sjnFeUEyKxFdFJRGFbkL0tjoe1pytXhvPASR2xQ4dee5cDTdvuzm7kK2GBPBw+PEU4
    Lgy9SIltVptSu8so2ov09T+V3fmY5tWunhJyEls/BGuEcISXfMAKNBlLTLaaw/0MJnhm
    5xmaK87y1RiEhI0QJlbC8oYk60z4rtn8kx2v9z9uajCNnUqGNA0cd/wWTCxe+EE15Spi
    CcmbM97urQOmTUEj84CjaAsQ5P6L525N6yRoTy7/YX3xUcXiEhRIi3cnYGu8pP8dw+u+
    ErzBmWe2Ol6ebRN8ihMHL9R+2CNXnIsJ4G3VYFUsdHd2GMe2BlYfnE6VIAiH8wzM75We
    NUXA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794480814;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=t1OE7YqzkHXLmGIbyWLImlNJ4K0tmvk730OFqWxRzpI=;
    b=UFn0/m4t9SDzWJJ4rkPljYkiqnXpUQG7Sphhuk/w3oIcTdBtYixvguIYdIY2JCyKky
    EqZStn7C1OArqfB3JehiY0qaDknCZySH+HfLTaS4hD14QaRBUxP+Izzg/nKFO4Jh1lsK
    10MjqQKXZN63PkbqZ6kO6Uc4oNoBy7kO1hn9U7ET2jh/sotWIegrRD6gUXmhWbU257Ek
    RGyD8t5HLcD39/cm8FtPMbuwuwwnkRWQCCcUuLDboAxCpvI5sTi4tIsRzx1e5EeZo0mY
    kUOx13+9rTtHy2LlIaEPQnR45+vFMxhzi2a89fKRe9T0ugWz1yBF33LNr2mbH8rHh8oT
    FlEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794480814;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=t1OE7YqzkHXLmGIbyWLImlNJ4K0tmvk730OFqWxRzpI=;
    b=JwYSeipNmpy9LXoh3q/RSq6fW4K0zCe88tp8DJ5ZzXVgOV5DwFgysHcF5b74zffy2I
    6ju5IVUNBAUsxTDoP6DQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzotGZvghOuyX/LuaP4"
Received: from open-xchange-core-mw-gw-7.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.6.3 AUTH)
    with ESMTPSA id z81ed22ACArX8mH
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 12 Nov 2026 11:53:33 +0100 (CET)
Date: Thu, 12 Nov 2026 11:53:33 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <179686212.779511.1794480813521@webmail.strato.de>
Subject: Request for review for 4.4-st81, 4.4-cip116
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.154
X-Originating-Port: 56430
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 10:53:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24782

Hi!

Here are the adapted backports for the upcoming 4.4 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

There's a total of 63, all written by LLM. 9 backports could be avoided as a result of the policy change to not fix minor resource leaks anymore.

0678ba1d91f1fc ipv4: free inet_opt and ireq_opt after an RCU grace period
6992d07fe08294 ipv4: validate checksum_start before completing checksum
516aeeed1f4544 net: lock the socket in sock_gettstamp()
02abab677e2efc fou: Fix use-after-free in fou_create()
51f033c4d0f4a6 net: openvswitch: conntrack: avoid modifying shared unconfirmed ct entry
e41ac4afeb7630 net/sched: hhf: cap hh_flows_limit at change time
317f524cba418b i2c: smbus: reject oversized block transfers in the common path
4740ddf01b1054 bonding: use skb_cow_head() in bond_do_alb_xmit() and rlb_arp_xmit()
99840dcba4bbab drm/virtio: Fix a NULL vs ERR_PTR() bug in virtio_gpu_user_framebuffer_create()
422f2d885c52e2 NFSv4/pnfs: key the data server cache on the NFS version
dce200e82c6f1c NFS: Always clear an invalid mapping when attempting a buffered write
d0405cc37214e4 ocfs2: synchronize heartbeat callbacks with o2net teardown
de019f34d297bc remoteproc: fix OOB read via signed offset in rsc_table_for_each_entry()
c209dc789a5269 locking/lockdep: Fix NULL pointer dereference in __lock_set_class()
bba681c13326c2 remoteproc: Prevent crash handling to race with rproc_del()
9b57ec0f79e09a mtd: rawnand: validate ONFI extended parameter page sections
fcb74440ceb6db net: cap advertised IP tunnel headroom
46d3860ebbf69c xfs: bounds-check buffer log item's dirty bitmap
97f7d54897bc15 net/sched: reject overly deep qdisc hierarchies
45e37ee018b2a4 Bluetooth: RFCOMM: fix NULL dereference of dlc->session in RFCOMM_CONNINFO
91a10ae67d13e7 fou: reject omitted FOU_ATTR_IPPROTO on FOU_ENCAP_DIRECT
d3edc0675a65bd vlan: ensure sufficient headroom in vlan_dev_hard_header()
40f23873865f06 net/sched: sch_teql: fix shadowed err in __teql_resolve()
7c95b2f29a9881 ip_gre: Reject enabling collect metadata through changelink
9cf53efa707596 net: gue: reject invalid REMCSUM offsets
468b5d17f124fa netfilter: nfnetlink_queue: hold nfnl mutex in event notifier
9d22a336c52bd1 wifi: mwifiex: bound the pairwise-cipher OUI walk to the IE length
0addefee126b60 wifi: libertas_tf: fix UAF in lbtf_free_adapter()
cba34dfccbb21c wifi: brcmsmac: fix UAF in brcms_free_timer()
595e0b5907a27e mmc: sh_mmcif: initialize IRQ-thread mutex before requesting interrupt
3f202a19646201 ipv6: mcast: extend RCU protection in igmp6_send()
5e7b306c1080da ipv6: fix fib6 walker UAF on seq stop
b50168c411b6f2 af_packet: Don't cast tpacket_hdr.tp_len to int in tpacket_parse_header().
8d7e2cd180ddd3 libceph: Reject monmaps advertising zero monitors
647d41546f37db f2fs: validate inline dentry name lengths before conversion
9dae0813764664 vsock: use sk_acceptq_is_full() helper in all transports
e8a0d58f2e1006 hsr: broadcast netlink notifications in the device's net namespace
99257d4fde5637 serial: 8250: fix possible ISR soft lockup
1011f6c1430da1 batman-adv: dat: atomically update mac addresses
d8e973f09a8ddf net/sched: bound qdisc_pkt_len to prevent qdisc soft lockup
84f6ae2ce2f234 ipvs: fix integer overflow in ftp helper port/address parsing
f01e96b215bb0f ocfs2: fix circular locking dependency in ocfs2_init_acl()
2087bea3600a0e ubi: fastmap: Allocate memory with GFP_NOFS in ubi_update_fastmap
dafe559887f41d nilfs2: fix infinite loop in nilfs_clean_segments()
fcbd723647cc16 HID: core: quiesce input in hid_hw_stop() to prevent use-after-free
28018bb5fa868c batman-adv: bla: avoid CRC corruption due to parallel claim add
2ff44d5a262ac8 scsi: qla2xxx: Fix cs84xx use-after-free on host teardown
9c3be302ec7407 scsi: qla2xxx: Hold vport reference in qla24xx_report_id_acquisition()
7023f7762813ad HID: rmi: fix OOB access with undersized RMI reports
4fc59357cec1f1 net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
cd3b72973734d5 net: skbuff: don't touch shared zerocopy state in skb_tx_error()
772158fa7e45b1 slip: fix use-after-free in sl_sync()
60fc714151aaed sctp: drop a chunk if its transport was removed
62d1f162001c5c udf: reject VAT indexes equal to the entry count
260d16f787c177 SUNRPC: always drain cache_cleaner before destroying a cache_detail
519fe2eec1fe61 Bluetooth: RFCOMM: serialize security confirmation handling
4fef0b4ac79c04 dm array: reject an array block whose value size is not the caller's
da6a4ce3362b3c usb: gadget: f_fs: Prevent deadlock during ep0 read loop
1cedba6e741f46 USB: serial: option: fix slab OOB read in interrupt URB callback
5f615a89990ff0 usb: gadget: f_tcm: keep port count until LUN teardown completes
a767cdc13753b7 inet: frags: strip GSO state from fragments before reassembly
2bc33c6be52dd3 HID: hyperv: validate initial device info bounds
fd680ee3712dad packet: use consistent hard_header_len in non-ring send paths

Thanks for having a look!

CU
Uli
