Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2833.1793959416873106749
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Nov 2026 02:03:37 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: ucw.cz, ip: 46.255.230.98, mailfrom: pavel@ucw.cz)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 70D0E32984A; Fri, 06 Nov 2026 11:03:33 +0100 (CET)
Date: Fri, 6 Nov 2026 11:03:32 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st21, 4.19-cip137
Message-ID: <au2l9BFnAxo2l_Cq@duo.ucw.cz>
References: <1931298540.80350.1793132613065@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9AyjGrht4tCEB4Pt"
Content-Disposition: inline
In-Reply-To: <1931298540.80350.1793132613065@webmail.strato.de>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 06 Nov 2026 10:03:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24664


--9AyjGrht4tCEB4Pt
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
>

Some patches are ok, Reviewed-by: Pavel Machek
<pavel@nabladev.com>. There are some comments below.

e37dae2a4576c5, for example. That was an obvious two-liner, but it is
quite significant locking redone after backport. I'm afraid this
should get specific testing.

cbf63e3778be51 is example of different problem. That rmmod path is
likely seriously broken in 4.19-st20. That's why it got redesign in
mainline. It is still broken in 4.19-st21, that barrier won't fix it
with nf_flow_table_module_exit() missing. Nobody should unload modules
in production, and this risks regressions.

b9027a1c10a535 got minor comment.

Best regards,
								Pavel


a > b78ecf68a5560d ipv6: sr: enforce exact attribute length for SEG6_ATTR_D=
ST
a > 28db7b5b3dfc9c ipv6: do not let ipv6_find_hdr() return an offset past t=
he packet end
a > 59c0dbc48ea5e9 af_packet: fix integer overflow in prb_calc_retire_blk_t=
mo()
> 7582eb829827dd drm/virtio: fix object leak in virtio_gpu_resource_create_=
ioctl()
> 5fc852076e0f08 drm/virtio: fix object leak when drm_gem_handle_create() f=
ails
a > a27a4884b8c4af ipvs: revalidate ihl before icmp_send
a > 88588102ee3ad2 bpf: Fix out-of-bounds read of rtt_min in sock_ops
!! it probably does not matter, but we should do release consistently
before or after pm. I guess before. > b9027a1c10a535 i2c: at91: release DMA=
 channels on remove and probe error
a just a robustness against CAP_NET_ADMIN > 3975c809ff001e net/sched: hhf: =
cap hh_flows_limit at change time
!! dunno, two liner becomes quite complex > e37dae2a4576c5 net: lock the so=
cket in sock_gettstamp()
a> e1333865998044 tcp: do not let tcp_rmem be set below 4096
> ffc922c95d046b drm: Fix drm_pending_vblank_event leak in error path for o=
ut_fence_ptr
!! are you sure this is applicable? > cbf63e3778be51 netfilter: flowtable: =
hold reference on ct until flow is released
a > 2f3223465d9893 dma-coherent: report a failed reserved memory assignment
a > cbb22c9ad14604 iomap: iomap: fix memory corruption when recording error=
s during writeback

--9AyjGrht4tCEB4Pt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCau2l9AAKCRAw5/Bqldv6
8iD7AJwLHpGOeauBmOs2HVFFdpH0frbpAQCfa+iKwmsqpK/BKhQeyWwOzea70QQ=
=yG84
-----END PGP SIGNATURE-----

--9AyjGrht4tCEB4Pt--
