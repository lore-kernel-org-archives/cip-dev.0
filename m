Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90BBC98302
	for <webhook@archiver.kernel.org>; Tue, 22 Sep 2026 15:52:10 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13802.1790092325740988053
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Sep 2026 08:52:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=BycKlXFV;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=8yEB+0Hf;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.220, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1790092310; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mRSqQ+A0UExxsG3OaplexDrjbVcHAgTtU4dPrhe32OABai0o/X92q4O2L1xOGvtNrz
    fqH/9bfinURYam7W/53bHRMMnMcFrDqsOl2VaGuGOqvY0ztxMqcP7IKNhjRfC1q98NN9
    CHE7rL8zRf08xn7YpckyaOfLgKeb+Oz0sVHKUmWQ3U5M5U+lAdvhuJ5WeQFwwuN1vb+H
    Omc2YN8/CcvhuIiNUKznaEuYAoUMdaV3+SLkyGbRUfpUIcgd68GX/+pV5EnqrFU1Hf0T
    x79lpz5jusRfb4sV+8hUkn6Dtrmo+4rMEUvlEm9igsm6kwXcCYkItMDcBTnwSxOrXYEX
    uj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790092310;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=KCS2u7/LS0brEH0ndYsP7AfwZj4icUWSW4dRz8pV84s=;
    b=RnbhdLBuTYU38IGBXqMv2u0vvzucfle3L77WFJV2MH4j7MEXrRRMjqDeYBP6ExQIb8
    bUbrrsrHDgnBabZ7sDyAmjTqJOfQLMVbJgj2NOoES7AVYRCuxjMvvvT+GWdUtHQ3SHCM
    MehAlrlgDHuCR6fjZ6LGUikGpbBB17N4O0TrSxIbJvO4ZyzKgRbdQiLQCZNQ4oFDbQpo
    wJxara+osNmeLUT6okY8ejS8+Veqy34695VmwlEOgLNJ2zM4fGxo/JbW7t9CMb53L3M5
    ezz3pTIlu9CtjsjcFit2fCSIpdDCNzx2dIxMYzbPVl0jcCKCnkoImg4yLoS8Bc7DnIna
    uedQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790092310;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=KCS2u7/LS0brEH0ndYsP7AfwZj4icUWSW4dRz8pV84s=;
    b=BycKlXFVqihLiT40wPV6jRMptI4KhFdLCBvOH/NLqpM+gwOyUT3+FS0GFEiWDbjY0N
    ZdqGe9xM6glK31bxuIGJMCK3hH/ONIO/X/CQ9R4s0r6rp1Vh4N/nZfl4KCDdiJacfvuT
    Ay/Ti9qwoFT8RpPXvk1d+u3iBW8IIT25XBBQfks0yJ7b3r1K1yKjdcTtivdix0R6zHoC
    7CU1mG0FD6UMWchJ7xk68jjru9KNNJu1mbPIO3vTR/X5OdirD/bWqrQappLV4kphCVWD
    CokI9kAZWywhnVBxgUdTbMdyu6ud0F0ErFqftyxw58hDuMvF2rzVE9hZ7TUoz7HzhkGS
    KlGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790092310;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=KCS2u7/LS0brEH0ndYsP7AfwZj4icUWSW4dRz8pV84s=;
    b=8yEB+0HfRCjlVXP0DNhIDrICk/EGhlxulNw33uvrUXsZ+oNahrIQpilGNkx4qR3SX5
    kPq8cXRZDFIM7/KwPsCg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKbL+BrLItU="
Received: from open-xchange-core-mw-gw-19.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.6.2 AUTH)
    with ESMTPSA id ze24d928MFpnWo7
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 22 Sep 2026 17:51:49 +0200 (CEST)
Date: Tue, 22 Sep 2026 17:51:49 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1957665225.34596.1790092309178@webmail.strato.de>
Subject: Request for review for 4.4-st80, 4.4-cip115 (sit down for this one)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.154
X-Originating-Port: 39732
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Sep 2026 15:52:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24267

Hi!

Here are the manual backports for the upcoming 4.4 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

There's a total of 87; 13 by me, and 74 by LLM. (The latter are labeled with "Assisted-by: SLTR:qwen-3.8".)
Total manual backport ratio is 21%, slightly down from 22% for st79.

Speak up if you find a class of patches in here that we should not consider for backporting in the future.

d482fcdcb9cf5 net: ipip: require CAP_NET_ADMIN in the device netns for changelink
9447834f71856 net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink
66b209be16611 net: ip_vti: require CAP_NET_ADMIN in the device netns for changelink
f5d2ad74edde2 NFS: Pin the 'struct nfs_server' during a FREE_STATEID call
4acc604700f7f ocfs2: reject non-inline dinodes with i_size and zero i_clusters
33b3774667584 wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()
15fd6b8ab4e3f net: remove WARN_ON_ONCE() from sk_mc_loop()
f50d09ccb2a3c net: openvswitch: fix skb leak on flow key update failure during recirculation
f0bb3b226b24d audit: fix potential integer overflow in audit_log_n_string()
1e58c90011532 skbuff: introduce skb_pull_data
8a27878187716 tipc: prevent snt_unacked underflow on CONN_ACK
9681717544d1f ipv6: mcast: Fix potential UAF in MLD delayed work
e3b1657d6d49f vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for Geneve packets
ab0f8bfb5b96d xfrm: defensively unhash xfrm_state lists in __xfrm_state_delete
1ee9bb33f50c5 btrfs: do not trim a device which is not writeable
210f49c16babe HID: appleir: fix UAF on pending key_up_timer in remove()
f762e427204a5 netfilter: ipset: fix order of kfree_rcu() and rcu_assign_pointer()
104e962c0778d Bluetooth: fix UAF in bt_accept_dequeue()
160be80dcaa57 i2c: core: fix adapter registration race
023c8f3acebcc net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink
b8b285996937e smb: client: restrict implied bcc[0] exemption to responses without data area
62b9455b524a2 ftrace: Add global mutex to serialize trace_parser access
18e1b6863f2a2 wifi: ath6kl: fix use-after-free in aggr_reset_state()
c5d53c4091d2c libceph: Avoid using invalid osd indices from primary_temp
02be6f188f65b thunderbolt: Bound the DROM dual link port number before indexing sw->ports
06b62f64d461a tipc: read le->link under the node lock in tipc_node_link_down()
231cd04749bc8 ipv6: prevent in6_dev_get() from resurrecting inet6_dev
5b8317d3c81a7 serial: 8250_dma: Clear stale RX state on shutdown
00114c782ae76 net/sched: cls_route: fix fastmap use-after-free on filter
f2bc9e8652686 nfs4: take a reference on the nfs_client when running FREE_STATEID
334d24ff159be Bluetooth: SCO: Fix use-after-free in sco_recv_frame() due to missing sock_hold
483db7203c062 can: kvaser_usb_leaf: kvaser_usb_leaf_wait_cmd(): validate received command extents
c58ecae06d669 sctp: reject stale cookies with mismatched verification tags
a913bd184e356 net: sxgbe: check descriptor ring allocation failures
f6fa91ea743e3 libceph: Fix multiplication overflow in decode_new_up_state_weight()
2952ef3847619 can: bcm: add missing device refcount for CAN filter removal
f4fa2f7f36f2e sctp: fix auth_chunk_list capacity check in sctp_auth_ep_add_chunkid
0c6142e6d67bb wifi: mwifiex: bound uAP association event IEs to the event buffer
41cfceccec572 net/packet: avoid fanout hook re-registration after unregister
96efe281a700d sctp: fix auth_hmacs array size in struct sctp_cookie
13cf40380ac7b KVM: x86/mmu: Fix use-after-free on vendor module reload
2f8e39207d985 crypto: qat - fix restarting state leak on allocation failure
c57604391687e usb: free iso schedules on failed submit
72cc582c593d3 Bluetooth: btrtl: validate firmware patch bounds
2e6bd3beccff5 ipvs: use parsed transport offset in SCTP state lookup
6dfae728844cc batman-adv: ensure minimal ethernet header on TX
115ac4f85cafb dm era: fix out-of-bounds memory access for non-zero start sector
daf3aeba89057 sctp: validate STALE_COOKIE cause length before reading staleness
e24980505e80e batman-adv: dat: fix tie-break for candidate selection
67cccfa82ee2a batman-adv: dat: ensure accessible eth_hdr proto field
28454e9b9d7b7 netfilter: xt_nat: reject unsupported target families
725269d86933c netfilter: nf_conntrack_reasm: guard mac_header adjustment after IPv6 defrag
b20eb35fc03f3 xfrm: validate selector family and prefixlen during match
a37ab55bcf26c sctp: validate embedded address parameter length
dc3d23e8a71fe firmware_loader: Fix recursive lock in device_cache_fw_images()
8c3821a3e30e0 ocfs2: kill osb->system_file_mutex lock
cf6f717ba97b8 ipv6: addrconf: bail out of dad_failure when state is no longer POSTDAD
10b4440285691 udf: validate free block extents against the partition length
5235e88344349 USB: ldusb: fix use-after-free on disconnect race
e1dcc7378c58b cpufreq: Fix hotplug-suspend race during reboot
93f92255a8e24 usb: xhci: Fix sleep in atomic context in xhci_free_streams()
1c587a9ffd883 Bluetooth: btusb: fix use-after-free on registration failure
bb63ea73d42fe mtd: slram: remove failed entries from the device list
eb25e1a785e08 iio: event: Fix event FIFO reset race
7d9de25de4e61 ALSA: seq: close a re-opened queue timer in the destructor
df2f30604a58a hwmon: (adt7470) Fix PWM auto temp state array and bounds check
e90f5905b969e writeback: fix race between cgroup_writeback_umount() and inode_switch_wbs()
78d577bbaf103 ieee802154: admin-gate legacy LLSEC dump operations
e185d2261c3b2 xen/gntdev: fix error handling in ioctl
bd1df96ef03b3 mac802154: llsec: reject frames shorter than the authentication tag
4a213e8e0342d firewire: net: Fix fragmented datagram reassembly
92f8246ac2e21 serial: 8250_mid: Disable DMA for selected platforms
862c9946f58f7 bonding: 3ad: fix mux port state on oper down
df557ee6a8f64 netfilter: ipset: fix refcount race between list:set GC and swap
73525985f4cfa netfilter: nf_nat_sip: reload possible stale data pointer
9e91b03227707 ipvs: ensure inner headers in ICMP errors are in headroom
955e245507a80 netfilter: ip6tables: mark malformed IPv6 extension headers for hotdrop
043f0aeb2318a ocfs2: rebase copied fsdlm LVB pointers in locking_state
1c660ae5d6008 drm/dp/mst: fix buffer overflows in sideband chunk accumulation
ac92976c6b8cf scsi: scsi_debug: Negate wrapped memcmp() result
cb8aaf7b5039b sctp: prevent peer transport count overflow
f23deabbc8ed5 net: bridge: stop fast-leave after deleting a port group
d48d2e30cb848 ipv6: fib6: fix NULL deref in fib6_walk_continue() on multi-batch dump
ba4b6df2bd287 nfsd: release layout stid on setlease failure
488ea75b7f8e2 i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)
2c52f137c35f5 batman-adv: retrieve ethhdr after potential skb realloc on RX
6f4ce31e13833 libceph: reject zero bucket types in crush_decode

Thank you!

CU
Uli

