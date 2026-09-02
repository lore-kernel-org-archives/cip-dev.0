Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE02C61DD6
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 18:33:18 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2640.1788373987465703402
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 11:33:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=PA97dnzy;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=luUwLSdB;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.221, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1788373972; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HA8D6VO+EwQmsmja3cHNN2mOICpCcKcLSBseUHEg2hg6fHVZ1vrEoVc73cWzoQzSwT
    p9RYd32NR+OMY/K7kCmbN/sV2+uHxPWr/yQdUupp3C81C9WSp6CfGzqlcuJcUAEfw/Ju
    Mg84CNsBDeljBAtz11crSjtluP9Xp60U4uu6Uqy+QLnHJ0Qek3xnJWg3dTMaCxBu9aPx
    ZwJyBuxI/iYW1jT5bV8RxI/3n7qjiTNliU5rbVuVOMAoJhbp2Zxy1S+TX//Cyf2KonsK
    u4u0lsWKaHdeteOyp4vNuQpdLVoaNlo+jR2B2dTQ8HgfTWa+KaYrAJuxWZJTGeuqegkM
    NrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1788373972;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=GJKUVP5qB2li6hVZfDuYV1uwdw6v8HwRuP7uUwl5gfw=;
    b=fGPK5rEFLYtEVjXsGWffNfC3Ttn3WWloopIJFUsEp4e2HlO2m54JLbiAWG+NW39BMO
    pJmoyAQul+Lp+REJJm4H6eX6JCh0pE2S5n9ThQQG5PVPdePVRQWTsV99YhEWauKTzmZE
    KHJlhDEIGxQMSHdVbcRaUryx4Sa6W8QJWWfVwSxmzeiiqrh1WUpFKOj9uABwKDBdvifg
    Nvyt8IndpMkiut50yht6ngfdpc7ysayaWKoE3d1Zsv0TCQWZtvmXyR+wpNrcJcUCirU7
    TGUQ7H04Q1SfO9SoFR/VoncyqvLreqfJ46SUZoKjNQm9u7xVd0JkCNPhjdiuv9twZbxP
    vkHg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788373972;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=GJKUVP5qB2li6hVZfDuYV1uwdw6v8HwRuP7uUwl5gfw=;
    b=PA97dnzy360sL9m8UeoCm+UPzDEVQLnu2647vfMVLSU4CCQxBs7quQSlPInBdlWvPF
    xdyMtxApV9DSJcwhv1GfP+Bf9PQwukxY58t83SD5+Pw52tOp/Aq+1+/dVK5sOgF6eGwJ
    /cRPTHJglNGvCkZGMwHW0WuY9mHslNa7hbFxqLHcSy101+Rf8Kdw+GTzIVynZtsLjlLq
    tktxMsul1GQsVG/ZEkxR7HQjzLlMmmt5l0fv7Ri1o9fRc4DaG7trp+pw2kRfADA/svVe
    eQAqEb8O1WvCwonc6AIcH65g9GV5G+83/qdB9yhzLggcgueykA2lp3eu8zBcuklTGOa4
    qqEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788373972;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=GJKUVP5qB2li6hVZfDuYV1uwdw6v8HwRuP7uUwl5gfw=;
    b=luUwLSdB9UvdhX0KLW5FVDR1UUqTSPSaa+XICN74Rcs2PUrma6SKHVKRAp+bkqjLnt
    BXKr0EzBhGrbEH/A3jAQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKHK+AR2fLw="
Received: from open-xchange-core-mw-gw-10.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.6.2 AUTH)
    with ESMTPSA id ze24d9282IWp0kT
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 2 Sep 2026 20:32:51 +0200 (CEST)
Date: Wed, 2 Sep 2026 20:32:51 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <588742173.259606.1788373971804@webmail.strato.de>
Subject: Request for review for 4.19-st20, 4.19-cip136
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.154
X-Originating-Port: 35204
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 18:33:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24083

Hi!

Here are the "manual" backports for the upcoming 4.19 kernel release. There's a total of 68; 40 by me, and 28 by LLM. (The latter are labeled with "Assisted-by: SLTR:qwen-3.8".)

As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

27bcd94232ddc ipv6: mcast: Fix potential UAF in MLD delayed work
d03436150e4a9 drm/edid: fix OOB read in drm_parse_tiled_block()
4227b25379d71 drm/displayid: fix Tiled Display Topology ID size
43d3d995bf595 f2fs: validate orphan inode entry count
5021916ddfd36 ALSA: seq: close a re-opened queue timer in the destructor
6fe1ea5d01613 hwmon: (adt7470) Fix PWM auto temp state array and bounds check
c32d12e231163 writeback: fix race between cgroup_writeback_umount() and inode_switch_wbs()
725e862fe8b08 ieee802154: admin-gate legacy LLSEC dump operations
033fdbe334d3c xen/gntdev: fix error handling in ioctl
fdc9c5a408cfc rxrpc: Fix leak of released call in recvmsg(MSG_PEEK)
3ecdb8f5381c2 mac802154: llsec: reject frames shorter than the authentication tag
e05a9dca311e3 vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for Geneve packets
ae8427e05bc1a firewire: net: Fix fragmented datagram reassembly
837b739d485a8 serial: 8250_mid: Disable DMA for selected platforms
c9534ae294af2 bonding: 3ad: fix mux port state on oper down
0ee0719ebd182 crypto: af_alg - Remove zero-copy support from skcipher and aead
8d4d8938c938b apparmor: mediate the implicit connect of TCP fast open sendmsg
d1ae7480a5a50 netfilter: ipset: fix refcount race between list:set GC and swap
afe5bdeae11e4 btrfs: do not trim a device which is not writeable
c819b97d60589 xfs: use null daddr for unset first bad log block
82f3412405d88 HID: appleir: fix UAF on pending key_up_timer in remove()
f6b1dda2a3508 smb: client: Fix next buffer leak in receive_encrypted_standard()
598fd8e4db9ac iio: common: st_sensors: honour channel endianness in read_axis_data
a43c58057c539 netfilter: nf_nat_sip: reload possible stale data pointer
19f32fd717473 ipvs: ensure inner headers in ICMP errors are in headroom
a777755df8ee5 netfilter: ip6tables: mark malformed IPv6 extension headers for hotdrop
de57725fa7d0d rtc: ds1307: Fix off-by-one issue with wday for rx8130
27f698f798451 smb/client: preserve errors from smb2_set_sparse()
1afab31384e2e netfilter: ipset: fix order of kfree_rcu() and rcu_assign_pointer()
80f8dca831e42 tipc: prevent snt_unacked underflow on CONN_ACK
21754c9585fc3 tipc: require net admin for TIPCv2 netlink mutators
3face51d6506e net: fib_rules: Don't dump dying fib_rule in fib_rules_dump().
be43ba6f489b6 ocfs2: rebase copied fsdlm LVB pointers in locking_state
d145312da325f net/sched: cls_bpf: prevent unbounded recursion in offload rollback
21aebfc636b9c crypto: ecc - Fix carry overflow in vli multiplication
ea5470a093f6d Bluetooth: fix UAF in bt_accept_dequeue()
5fb906176753b net: ipv4: bound TCP reordering sysctl writes and MTU probe sizes
b06d8e05be8d6 drm/dp/mst: fix buffer overflows in sideband chunk accumulation
2ee87cc535310 net: ipip: require CAP_NET_ADMIN in the device netns for changelink
798716bc98db1 rxrpc: Fix notification vs call-release vs recvmsg
483240e3761eb libceph: fix multiple unsafe decodes in decode_locker()
4338c41c423b1 scsi: scsi_debug: Negate wrapped memcmp() result
e370b6e8d1a59 vhost: reset the vring metadata cache on vring reconfiguration
7d8fc6d0208be futex: Prevent robust futex exit race some more
3d3bcb5dd85d1 Input: evdev - fix information leak in evdev_pass_values()
a3e7176697ddd mm/huge_memory: unlock i_mmap_rwsem before releasing after-split folios
96c6f93b3ff66 sctp: prevent peer transport count overflow
39cf294824a31 net: bridge: stop fast-leave after deleting a port group
f0b272d10c9df mm/percpu-km: fix bitmap overflow and accounting in pcpu_create_chunk()
caba2e7b56939 ipv6: fib6: fix NULL deref in fib6_walk_continue() on multi-batch dump
5298659ef682c openvswitch: fix GSO userspace truncation underflow
031a2f99d475b vxlan: require CAP_NET_ADMIN in the device netns for changelink
e7383f6dbb6b9 can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF
bd5b04d67545f tipc: fix u16 MTU truncation in media and bearer MTU validation
fd119cc5d1ce0 net/sched: act_tunnel_key: Defer dst_release to RCU callback
231854d20f22b KVM: nVMX: Hide shadow VMCS right after VMCLEAR
c4bc9e59cd758 perf/x86/amd/core: Always use the NMI latency mitigation
a0aef239f4722 i2c: core: fix adapter registration race
6cff48ecf1d69 net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink
c7b13e80811aa nfsd: release layout stid on setlease failure
d75140d1212a2 i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)
e33cc57dadde8 selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()
b8c1bbd016710 net/openvswitch: check Ethernet header length in key_extract()
f965a98a469c3 net: ipv6: fix dif and sdif mismatch in raw6_icmp_error
7bdb312c113d2 smb: client: restrict implied bcc[0] exemption to responses without data area
8f223fbe6b2d4 batman-adv: retrieve ethhdr after potential skb realloc on RX
1c72d53630aa3 NFS: Pin the 'struct nfs_server' during a FREE_STATEID call
f1f7d30dcdfaa NFS: Decrement refcounts if allocating nfs_free_stateid_data fails

Thank you!

CU
Uli

