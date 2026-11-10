Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3218.1794346050871227349
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Nov 2026 13:27:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=clKqrCk5;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BA8AE10DBB8;
	Tue, 10 Nov 2026 22:27:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794346044;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=l1jzo6BtIhl60oL9AXuixiZdBW+XLMznTWYaAwwU5vA=;
	b=clKqrCk5xTroNAO0Ahi7H1hjnREKE1DoAVumsAYIWd/e6b+C1M1X43Yq397/Mxe2adP3Gk
	f52LjJsdV+4DCr9/z44zm2JPsvSVQBdUZbhnaj9beR0eoxTXYC7WBEFYNFGddr4p1FzrGk
	TF2Jwf9Upn6vpageKEuSf+DOX5TMoJSzELZAKdoCr8sxVKQcjnOufS0lEdJ/Gv1eyRgSS4
	IJ5dA411OyFCPjc2lkOPkYt+dTUXubKounM1SUKyF9Hj5WyJCcHSMvxlTaF4WIE6mVD5u3
	nd3wxDHbg0V0KWu2IFyoAAyNKPe0CRb21TlY37AKmP5bA8JFUODsyWTqE4JWaA==
Date: Tue, 10 Nov 2026 22:27:19 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st21, 4.19-cip137
Message-ID: <avOMN_cVRLv1uH9o@duo.ucw.cz>
References: <1931298540.80350.1793132613065@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PiVxIwggLik0UFTH"
Content-Disposition: inline
In-Reply-To: <1931298540.80350.1793132613065@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 10 Nov 2026 21:27:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24735


--PiVxIwggLik0UFTH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the adapted backports for the upcoming 4.19 kernel release. Ther=
e's a total of 95; 1 written by me, 2 by Qwen-3.8-27B and 92 by Qwen-3.8-Fl=
ash-Next. (The latter are labeled with "Assisted-by: SLTR:qwen-3.8" and "As=
sisted-by: SLTR:qwen-3.8-flash-next", respectively.)
>=20
> As always they can be found in https://git.kernel.org/pub/scm/linux/kerne=
l/git/cip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc

As usual, lines marked with "^a" are patches I reviewed. Reviewed-by:
Pavel Machek <pavel@nabladev.com>

I believe f6c6a70da060ea is a bit too complex for us.

Best regards,
								Pavel


a I would not change comment in the backport > 15dca0467fbc1b i2c: smbus: r=
eject oversized block transfers in the common path
a > ad002df2ef4324 ipv4: fib: bound automatic table ID allocation
a > 36d5575a8baded net: mpls: clear inner_protocol when the last label is p=
opped
a > 0eceef464ddb41 cpufreq: initialize policy rwsem before sysfs publication
a > 7a85d5bf37497f cpufreq: zero-initialize policy cpumask before sysfs pub=
lication
> f33862037392e3 macvlan: inherit needed_headroom and needed_tailroom from =
lowerdev
> 8c7a3c69bd6c75 drm/amd/display: set new_stream to NULL after release
a > fab55095a265ba net/sched: cls_api: Don't replay RTM_GETCHAIN in tc_ctl_=
chain().
a > 7dbaf7cbcc17f2 bonding: use skb_cow_head() in bond_do_alb_xmit() and rl=
b_arp_xmit()
a > c991dca2b3c361 net/sched: act_api: budget all shared attributes in noti=
fy skbs
> 7d08f3c8750eb2 drm/virtio: Fix a NULL vs ERR_PTR() bug in virtio_gpu_user=
_framebuffer_create()
a > efc263c2c0b10b wifi: libertas: reject short monitor TX frames
> b32f72a205795a xen/front-pgdir-shbuf: free grant reference head on errors
a just a robustness > cba01a9b47aaf1 net: stmmac: xgmac2: disable RBUE in d=
efault RX interrupt mask
a > 7a599b7230d280 wifi: nl80211: Increase ie_len size to prevent truncated=
 IEs in new peer notifications
a > e6c0bfb715a6d7 ASoC: codecs: pcm3168a: Drop CONFIG_PM-conditional prepr=
oc directive
!! just a network namespacing, quite complex > f6c6a70da060ea rds: filter R=
DS_INFO_* getsockopt by caller's netns
> 98f4c9eafa9d27 scsi: pm8001: Reject firmware update in fatal error state
> f0a0787eb48b2a thunderbolt: Set tb->root_switch to NULL when domain is st=
opped
> 6fe4d16722f049 NFSv4/pnfs: key the data server cache on the NFS version
> af43e84cb9da3b NFS: Always clear an invalid mapping when attempting a buf=
fered write
a > 5b5b707281db3c lwt_bpf: Restore reserved headroom after xmit program
a this is subtle way to return with retval =3D 0; I guess that's okay > 05f=
ef2249c1be1 firmware_loader: do not queue completed sysfs fallback requests
> 81db1e6ec46877 ocfs2: synchronize heartbeat callbacks with o2net teardown
> 7383d078e76942 remoteproc: fix OOB read via signed offset in rsc_table_fo=
r_each_entry()
> 3d73e501fdc537 perf intel-pt: Fix off-by-one in auxtrace_info minimum siz=
e check
a > 1b1ebee1d17f8b tty: clear cdev pointer after cdev_add() failure
a > af6929005c4a3a serial: amba-pl011: unprepare console clock on unregister
a > 6434896a882257 wifi: mt76: mt76x02: do not WARN on invalid rx descripto=
r length
a > 65d7661a2a2887 locking/lockdep: Fix NULL pointer dereference in __lock_=
set_class()
> 9590d724daf3f2 remoteproc: Prevent crash handling to race with rproc_del()
a two sbs batteries are pretty unusual config > 1d2cfeed814ebf power: suppl=
y: sbs-battery: Use a per-device serial number buffer
> f535e3674afd1c RDMA/srpt: Pass the mapped task attribute to target_init_c=
md()
> d7b349ebdfdafc ASoC: meson: Keep link pointers valid on realloc failure
> d38f463c73bccc tty: hvc: restrict HVC_DCC to ARMv6+ and ARM64
> 3f78220d000d94 xfrm6: fix out-of-bounds write in xfrm6_input_addr() when =
secpath is full
> 1b1bd4efd7d8a1 iommu/amd: Prevent SB IOAPIC from overriding IVRS validati=
on errors
> 05c7c199894226 soc: samsung: exynos-pmu: fix of_node refcount leak in exy=
nos_get_pmu_regmap()
> 4939afd8061ba8 HID: roccat: bound device-supplied profile index
> 3c1c45a994001e bpf: Enforce expected_attach_type for tailcall compatibili=
ty
> efff42e7625928 tcp: clear sock_ops cb flags before force-closing a child =
socket
> e8453ec6b7f770 xhci: fix lost bounce buffers on TDs spanning several ring=
 segments
> 8eb84d0751f98b drm: Fix drm_crtc_commit leak if signaled when PAGE_FLIP_E=
VENT is used
> f0e7e4f141ca70 scsi: qla2xxx: Zero SFP DMA buffer in FRU/I2C bsg handlers
> aec9df1263875c batman-adv: dat: avoid unaligned fault in IP extraction
> 53a94e6cc49ffe mtd: rawnand: validate ONFI extended parameter page sectio=
ns
> c8846b93ddcb6e HID: wacom: validate report length in wacom_intuos_pro2_bt=
_irq
> a8a753f7fc41b0 scsi: core: Fill in DMA padding bytes in scsi_alloc_sgtabl=
es()
> 303a77ac1be15b selinux: reject an unclaimed class value in security_get_c=
lasses()
> 4fae216b4a1760 tcp: fix potential race in tcp_v6_syn_recv_sock()
> 393c2ca46a3b27 fsnotify: Fix stale object mask after concurrent mark upda=
tes
> 83cb9c25f3391f openvswitch: Fix CT limit teardown use-after-free
> aeca4496f07b9b netfilter: nf_queue: pin bridge device while NFQUEUE holds=
 fake dst
> aea3fa3f950c8c net: cap advertised IP tunnel headroom
> ce12d5b2bdee84 net: openvswitch: fix flow mask use-after-free on flow del=
etion
> f139bc5bef5bc9 power: supply: max17040: synchronize work cancellation on =
suspend
> 7c74c8f9a71e98 sctp: fix stream->outcnt underflow on duplicate RECONF res=
ponses
> 7869f195dfe0a9 SUNRPC: harden gss_unwrap_resp_priv length checks
> d93d0c0458686d SUNRPC: harden gss_krb5_unwrap_v2 against short tokens
> f57c93fdce94d3 SUNRPC: Guard svcauth_gss_release() dispatch on rq_auth_st=
at
> d10d5ffbde1f9b sunrpc: route to a populated pool in svc_pool_for_cpu()
> b86a2634b755b9 nfsd: add fh_want_write() for early-verified SETATTR in nf=
sd_proc_setattr()
> 3af3a1546df5c8 ALSA: aloop: Fix racy access at PCM trigger
> 3a1fe75c4db943 mm/swap: reject swapon() on filesystem-level encrypted fil=
es
> 4084800d553361 selinux: switch two allocations to use kzalloc_objs()
> b29f321b90465e ipv6: mcast: Fix use-after-free when processing MLD queries
> 68018695bfef2c xfs: bounds-check buffer log item's dirty bitmap
> fe55a808ff6078 KVM: arm64: Retry fault if vma_lookup() results become inv=
alid
> 9ef244c1264489 inet: frags: publish queues before arming timer
> 9779b445f542b2 packet: synchronize pressure clearing with ring reconfigur=
ation
> 86ce0c431c5480 net/sched: reject overly deep qdisc hierarchies
> 13115d704fea78 serial: amba-pl011: synchronize DMA teardown
>=20
> Thanks for having a look!
>=20
> CU
> Uli

--=20

--PiVxIwggLik0UFTH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavOMNwAKCRAw5/Bqldv6
8hYdAJ9QtkZnDCse8euqSi+/PQ/7rerv9gCfdx2dfIYkCnqUlwtJpy9BCBleQGE=
=32K3
-----END PGP SIGNATURE-----

--PiVxIwggLik0UFTH--
