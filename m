Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40527C4332F
	for <webhook@archiver.kernel.org>; Wed,  8 Nov 2023 11:44:36 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.11574.1699443874220385399
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Nov 2023 03:44:35 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: ucw.cz, ip: 46.255.230.98, mailfrom: pavel@ucw.cz)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3D1A61C0050; Wed,  8 Nov 2023 12:44:30 +0100 (CET)
Date: Wed, 8 Nov 2023 12:44:29 +0100
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for reviews for 4.4-st46, 4.4-cip81
Message-ID: <ZUt0nT0pkjiV5cOD@duo.ucw.cz>
References: <986159676.521058.1699328283618@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yd44BTcY3nNjVRap"
Content-Disposition: inline
In-Reply-To: <986159676.521058.1699328283618@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Nov 2023 11:44:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13538


--yd44BTcY3nNjVRap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4-st46 and 4.4-cip81 rel=
eases that should be reviewed and that can currently be found in
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinux-4.4.y-st-rc
>=20
> As always, most only required small context adjustments:

a ** m-| 96b58b9b3 4ff3ba .+ | powerpc/perf/hv-24x7: Update domain value ch=
eck
a just a robustness ** m-| e0eebcced 737dd8 o+ | ata: libahci: clear pendin=
g interrupt status
a ** m-| ee5732caa cce7fc o+ | serial: 8250_port: Check IRQ data before use
a ** m-| fb1084e63 7ee29f o+ | nilfs2: fix potential use after free in nilf=
s_gccache_submit_read_data()
a ** m-| b40f31d74 391478 o+ | i2c: i801: unregister tco_pdev in i801_probe=
() error path
a ** m-| 18e301e10 d7f393  + | IB/mlx4: Fix the size of a buffer in add_por=
t_entries()
a ** m-| 923b555ec 30188b o  | Revert "rtnetlink: Reject negative ifindexes=
 in RTM_NEWLINK"
a ** m-| a24ba12f4 8fb8a8  + | RDMA/cxgb4: Check skb value for failure to a=
llocate
a ** m-| ae40f2c3f 92d4ab o  | Bluetooth: vhci: Fix race when opening vhci =
device
a -- missing sign-off ** m-| f8d49412e a16eb2 o+ | KVM: x86: Mask LVTPC whe=
n handling a PMI
a ** m-| 56ff7abff 9e8bc2 .  | gpio: timberdale: Fix potential deadlock on =
&tgpio->lock
a ** m-| d9ce7d438 dcda16 o  | Bluetooth: hci_core: Fix build warnings

These looks ok to me. Minor note is that KVM one should probably be
signed-off by you.

> Slightly more involved:

a ** mo| f510d8ec0 b547b5 .+ | gpio: tb10x: Fix an error handling path in t=
b10x_gpio_probe()
a ** mo| ca0c4cc1d dac501 o  | HID: logitech-hidpp: Fix kernel crash on rec=
eiver USB disconnect
a ** mo| 209971d45 7b5add o+ | ixgbe: fix crash with empty VF macvlan list
a ** m+| 5bdf93a2f 427694 o+ | usb: gadget: ncm: Handle decoding of multipl=
e NTB's in unwrap call
a ** m+| 555e15e93 32671e o+ | perf: Disallow mis-matched inherited group r=
eads

These look ok to me, too.

> There are also a bunch of reverts fixing build failures in non-CIP config=
urations:

a 98c3c9673dfd9 Revert "usb: gadget: f_ncm: Add OS descriptor support"
a 607a9ba7667d2 Revert "pinctrl: avoid unsafe code pattern in find_pinctrl(=
)"
a a14a49dfa9693 Revert "x86/APM: drop the duplicate APM_MINOR_DEV macro"
a c0cb2cd552d1e Revert "IB/hfi1: Fix possible panic during hotplug remove"
a 23b3e2863a88a Revert "neighbour: Remove unused inline function neigh_key_=
eq16()"
>=20
> Thanks for having a look.

These look ok to me.

I also see Revert "pinctrl: amd: Use amd_pinconf_set() for all config optio=
ns"

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--yd44BTcY3nNjVRap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZUt0nQAKCRAw5/Bqldv6
8j5AAKCAgnWN1JIFmgwMNYANA/PTMOI1IQCgjgX02UVsa1sm+9XcLuzhEhfZo4Y=
=Qjq/
-----END PGP SIGNATURE-----

--yd44BTcY3nNjVRap--

