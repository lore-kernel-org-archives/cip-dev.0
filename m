Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28239.1793132632458312158
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Oct 2026 13:23:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=VJdJ8rGS;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=TIDCOrMi;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.161, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1793132614; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Q90NF/pVPerVZ6ZSQtsjlamKeAaT5y/Y9GlHnVS2iuC9m4KDTSdQkd8+xuY+6VatGz
    inA4DbuSk+3hjHXOxvGNZjwLrvpM6GbCoTOfvklKFu84QkqWsmYEHWXvrxOgFVwKs4nt
    UAdMXv+Wg0Aq/a0VaZNwGJ9xbF3CFAvo2OJExJSCTORwqiRPPOX75GbtR5ZEqYECfwRx
    L6YDPOpq+x+g0OX/c3eetRjn90bVOhxIleTTbkI6Bdz2m3x7EYZhQb30qZX0+OswkIsO
    Sie4M92pwUZ9d79PHFNqMiWL9ahFVgkr7Olwre4xNMv9hlSHc9b1sn/w2e3jBB5yUqf9
    wpPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793132614;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=xSIJEDtTUhE/aus+uJjvv61zN8trZX1BfHtFgvIwl8Q=;
    b=kB+hTwpbXCj7aXAejxMglGWeVwPCSOtxziy2LsNWYa9NSVPYUvOxGfojBw3AwJ3nc/
    hrqpn8/kTA6wUW3gG5rXcXHUTEEnC1LDp9vrDWFdwOe4eji2woYHv+k/jj84YVS9l4X8
    4yu5h5jJ8baGLDr9xXcBtVRsZYEXTfzfVUcfYA9qkMaehzXnBmmkraJtjRZP0RvoZXbQ
    cirurRYWIjkLKTtDQQWQ+pdTkzn6+C1B8F3UZNckyy7sLDU8TOyPEhOMTCnBKLFOos05
    XDJPekvS+lnfPPja/EKhpkLiD+ppI02JuOs7Xs3cH+FxfjcCttrbvP3bwVZy5oDzEEqe
    UW+w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793132614;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=xSIJEDtTUhE/aus+uJjvv61zN8trZX1BfHtFgvIwl8Q=;
    b=VJdJ8rGSq5QUsI47TXSpYoLheSAVJRnxZ1jVD2FlsEGYvhbjYK10h/b31WroUyn8So
    cjj8qbt95VtBuuqKjov1ZwlXMl6h/v1icwUorUko6hWOYBckqu4XlhyI1Gq2nVutGkt5
    yPKK6/8pE3ufvrT4VtT/YwuNJrHhokSUDuui01zUzV/NPlZxul9mlxO0mEV8DxZBod4j
    A5YpUc53pni0KGhJV1AgB9SSNV+x1zHBJA1QhoSEWEE4s0dR1Wsk+4WOOodfN/0eIDIM
    du3tSTasttLX5q6FhyGqkb0re9CtqWB7VUKoLEIHYKEFOzBe76LVqrQbVcVAsEF5scRV
    PSjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793132614;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=xSIJEDtTUhE/aus+uJjvv61zN8trZX1BfHtFgvIwl8Q=;
    b=TIDCOrMiQ0OKWjufvVkkX+0T3rjuIanDFRtRqxczmiKaotIBDAcLMSsGL769GCs14b
    Jw2d+mZFFZNaNa+xlmAQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzotGZvghOuyX/LuaP4"
Received: from open-xchange-core-mw-gw-33.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.6.3 AUTH)
    with ESMTPSA id z81ed229RKNXyjP
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 Oct 2026 21:23:33 +0100 (CET)
Date: Tue, 27 Oct 2026 21:23:33 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1931298540.80350.1793132613065@webmail.strato.de>
Subject: Request for review for 4.19-st21, 4.19-cip137
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.154
X-Originating-Port: 60514
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 27 Oct 2026 20:23:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24553

Hi!

Here are the adapted backports for the upcoming 4.19 kernel release. There's a total of 95; 1 written by me, 2 by Qwen-3.8-27B and 92 by Qwen-3.8-Flash-Next. (The latter are labeled with "Assisted-by: SLTR:qwen-3.8" and "Assisted-by: SLTR:qwen-3.8-flash-next", respectively.)

As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

0f9dd2fd36dc88 ipv4: validate checksum_start before completing checksum
1aef1ed67bf592 netfilter: ip6t_rt: fix zero-address non-strict match out-of-bounds read
1772d2f27fe10f net: openvswitch: conntrack: avoid modifying shared unconfirmed ct entry
994be280b21cd2 net/sched: reject IDR error pointers when deleting actions
2548133fd1bde9 drm/nouveau: Fix gem reference leak in validate_init()
893066ca3560ef drm/nouveau: fix double-free in nvif_vmm_dtor
a91fd56ecf47a4 gpio: zynq: fix runtime PM leak on request error path
b78ecf68a5560d ipv6: sr: enforce exact attribute length for SEG6_ATTR_DST
28db7b5b3dfc9c ipv6: do not let ipv6_find_hdr() return an offset past the packet end
59c0dbc48ea5e9 af_packet: fix integer overflow in prb_calc_retire_blk_tmo()
7582eb829827dd drm/virtio: fix object leak in virtio_gpu_resource_create_ioctl()
5fc852076e0f08 drm/virtio: fix object leak when drm_gem_handle_create() fails
a27a4884b8c4af ipvs: revalidate ihl before icmp_send
88588102ee3ad2 bpf: Fix out-of-bounds read of rtt_min in sock_ops
b9027a1c10a535 i2c: at91: release DMA channels on remove and probe error
3975c809ff001e net/sched: hhf: cap hh_flows_limit at change time
e37dae2a4576c5 net: lock the socket in sock_gettstamp()
e1333865998044 tcp: do not let tcp_rmem be set below 4096
ffc922c95d046b drm: Fix drm_pending_vblank_event leak in error path for out_fence_ptr
cbf63e3778be51 netfilter: flowtable: hold reference on ct until flow is released
2f3223465d9893 dma-coherent: report a failed reserved memory assignment
cbb22c9ad14604 iomap: iomap: fix memory corruption when recording errors during writeback
e081a6b8380337 fou: Fix use-after-free in fou_create()
15dca0467fbc1b i2c: smbus: reject oversized block transfers in the common path
ad002df2ef4324 ipv4: fib: bound automatic table ID allocation
36d5575a8baded net: mpls: clear inner_protocol when the last label is popped
0eceef464ddb41 cpufreq: initialize policy rwsem before sysfs publication
7a85d5bf37497f cpufreq: zero-initialize policy cpumask before sysfs publication
f33862037392e3 macvlan: inherit needed_headroom and needed_tailroom from lowerdev
8c7a3c69bd6c75 drm/amd/display: set new_stream to NULL after release
fab55095a265ba net/sched: cls_api: Don't replay RTM_GETCHAIN in tc_ctl_chain().
7dbaf7cbcc17f2 bonding: use skb_cow_head() in bond_do_alb_xmit() and rlb_arp_xmit()
c991dca2b3c361 net/sched: act_api: budget all shared attributes in notify skbs
7d08f3c8750eb2 drm/virtio: Fix a NULL vs ERR_PTR() bug in virtio_gpu_user_framebuffer_create()
efc263c2c0b10b wifi: libertas: reject short monitor TX frames
b32f72a205795a xen/front-pgdir-shbuf: free grant reference head on errors
cba01a9b47aaf1 net: stmmac: xgmac2: disable RBUE in default RX interrupt mask
7a599b7230d280 wifi: nl80211: Increase ie_len size to prevent truncated IEs in new peer notifications
e6c0bfb715a6d7 ASoC: codecs: pcm3168a: Drop CONFIG_PM-conditional preproc directive
f6c6a70da060ea rds: filter RDS_INFO_* getsockopt by caller's netns
98f4c9eafa9d27 scsi: pm8001: Reject firmware update in fatal error state
f0a0787eb48b2a thunderbolt: Set tb->root_switch to NULL when domain is stopped
6fe4d16722f049 NFSv4/pnfs: key the data server cache on the NFS version
af43e84cb9da3b NFS: Always clear an invalid mapping when attempting a buffered write
5b5b707281db3c lwt_bpf: Restore reserved headroom after xmit program
05fef2249c1be1 firmware_loader: do not queue completed sysfs fallback requests
81db1e6ec46877 ocfs2: synchronize heartbeat callbacks with o2net teardown
7383d078e76942 remoteproc: fix OOB read via signed offset in rsc_table_for_each_entry()
3d73e501fdc537 perf intel-pt: Fix off-by-one in auxtrace_info minimum size check
1b1ebee1d17f8b tty: clear cdev pointer after cdev_add() failure
af6929005c4a3a serial: amba-pl011: unprepare console clock on unregister
6434896a882257 wifi: mt76: mt76x02: do not WARN on invalid rx descriptor length
65d7661a2a2887 locking/lockdep: Fix NULL pointer dereference in __lock_set_class()
9590d724daf3f2 remoteproc: Prevent crash handling to race with rproc_del()
1d2cfeed814ebf power: supply: sbs-battery: Use a per-device serial number buffer
f535e3674afd1c RDMA/srpt: Pass the mapped task attribute to target_init_cmd()
d7b349ebdfdafc ASoC: meson: Keep link pointers valid on realloc failure
d38f463c73bccc tty: hvc: restrict HVC_DCC to ARMv6+ and ARM64
3f78220d000d94 xfrm6: fix out-of-bounds write in xfrm6_input_addr() when secpath is full
1b1bd4efd7d8a1 iommu/amd: Prevent SB IOAPIC from overriding IVRS validation errors
05c7c199894226 soc: samsung: exynos-pmu: fix of_node refcount leak in exynos_get_pmu_regmap()
4939afd8061ba8 HID: roccat: bound device-supplied profile index
3c1c45a994001e bpf: Enforce expected_attach_type for tailcall compatibility
efff42e7625928 tcp: clear sock_ops cb flags before force-closing a child socket
e8453ec6b7f770 xhci: fix lost bounce buffers on TDs spanning several ring segments
8eb84d0751f98b drm: Fix drm_crtc_commit leak if signaled when PAGE_FLIP_EVENT is used
f0e7e4f141ca70 scsi: qla2xxx: Zero SFP DMA buffer in FRU/I2C bsg handlers
aec9df1263875c batman-adv: dat: avoid unaligned fault in IP extraction
53a94e6cc49ffe mtd: rawnand: validate ONFI extended parameter page sections
c8846b93ddcb6e HID: wacom: validate report length in wacom_intuos_pro2_bt_irq
a8a753f7fc41b0 scsi: core: Fill in DMA padding bytes in scsi_alloc_sgtables()
303a77ac1be15b selinux: reject an unclaimed class value in security_get_classes()
4fae216b4a1760 tcp: fix potential race in tcp_v6_syn_recv_sock()
393c2ca46a3b27 fsnotify: Fix stale object mask after concurrent mark updates
83cb9c25f3391f openvswitch: Fix CT limit teardown use-after-free
aeca4496f07b9b netfilter: nf_queue: pin bridge device while NFQUEUE holds fake dst
aea3fa3f950c8c net: cap advertised IP tunnel headroom
ce12d5b2bdee84 net: openvswitch: fix flow mask use-after-free on flow deletion
f139bc5bef5bc9 power: supply: max17040: synchronize work cancellation on suspend
7c74c8f9a71e98 sctp: fix stream->outcnt underflow on duplicate RECONF responses
7869f195dfe0a9 SUNRPC: harden gss_unwrap_resp_priv length checks
d93d0c0458686d SUNRPC: harden gss_krb5_unwrap_v2 against short tokens
f57c93fdce94d3 SUNRPC: Guard svcauth_gss_release() dispatch on rq_auth_stat
d10d5ffbde1f9b sunrpc: route to a populated pool in svc_pool_for_cpu()
b86a2634b755b9 nfsd: add fh_want_write() for early-verified SETATTR in nfsd_proc_setattr()
3af3a1546df5c8 ALSA: aloop: Fix racy access at PCM trigger
3a1fe75c4db943 mm/swap: reject swapon() on filesystem-level encrypted files
4084800d553361 selinux: switch two allocations to use kzalloc_objs()
b29f321b90465e ipv6: mcast: Fix use-after-free when processing MLD queries
68018695bfef2c xfs: bounds-check buffer log item's dirty bitmap
fe55a808ff6078 KVM: arm64: Retry fault if vma_lookup() results become invalid
9ef244c1264489 inet: frags: publish queues before arming timer
9779b445f542b2 packet: synchronize pressure clearing with ring reconfiguration
86ce0c431c5480 net/sched: reject overly deep qdisc hierarchies
13115d704fea78 serial: amba-pl011: synchronize DMA teardown

Thanks for having a look!

CU
Uli
