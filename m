Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B0EC64EC4
	for <webhook@archiver.kernel.org>; Thu,  9 Mar 2023 21:35:15 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.3780.1678397712034927002
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Mar 2023 13:35:13 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CF8441C0AC1; Thu,  9 Mar 2023 22:35:08 +0100 (CET)
Date: Thu, 9 Mar 2023 22:35:08 +0100
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: Request for reviews for 4.4-st38/4.4-cip73
Message-ID: <ZApRDHkYvu2bOgZM@duo.ucw.cz>
References: <1010789948.2703824.1677492030810@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lJXnA1CKZOSFAhfU"
Content-Disposition: inline
In-Reply-To: <1010789948.2703824.1677492030810@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Mar 2023 21:35:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10971


--lJXnA1CKZOSFAhfU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4-st38/4.4-cip73 release=
 that should be reviewed, and can currently be found in https://git.kernel.=
org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc :
>

I managed to review most of them.

These are ok:

a > ff1d923b1cbd mm/swapfile: add cond_resched() in get_swap_pages()
a > c2242a203f81 fbcon: Check font dimension limits
a > 0697f3908a1c ipv6: ensure sane device mtu in tunnels
a > 6e1a18831ef9 net: ravb: Fix possible hang if RIS2_QFF1 happen
a not a minimum fix> e15755dd0185 EDAC/device: Respect any driver-supplied =
workqueue polling value
a not really stable material > 1e5047422011 net: mlx5: eliminate anonymous =
module_init & module_exit
a not really stable material > 8f0e3e6f2ec8 amd-xgbe: TX Flow Ctrl Register=
s are h/w ver dependent
a cargo cult programming > 30a61de78f81 usb: gadget: f_ncm: fix potential N=
ULL ptr deref in ncm_bitrate()
a not really worth the work > 70ccdf253245 usb: core: hub: disable autosusp=
end for TI TUSB8041
a > 9c336605666d USB: hub: Fix the broken detection of USB3 device in SMSC =
hub
a > 93215b524bdf hvc/xen: lock console list traversal
a > e22ac280fe43 qlcnic: prevent ->dcb use-after-free on qlcnic_dcb_enable(=
) failure
a > f38b21843014 nilfs2: fix underflow in second superblock position calcul=
ations
a just an API tweak, do we have 1/ of the series? > 9a977a3c8fab mm: hugetl=
b: proc: check for hugetlb shared PMD in /proc/PID/smaps
a > f09f686242e2 SUNRPC: ensure the matching upcall is in-flight upon downc=
all
a > 97494d49b7e0 NFSv4.x: Fail client initialisation if state manager threa=
d can't run

(comments there are really nothing you can do much, but I'd not bother
backporting 1e5047422011 and 8f0e3e6f2ec8).

I believe we should be taking this one. It is mostly theoretical bug,
backport is extensive and we really have no way of testing it:

! syscaller -> theoretical bug. This would really need testing. They
were deleting code from ack_complete. Lets... not? > 57059c01a09d nfc:
pn533: Wait for out_urb's completion in pn533_usb_send_frame()

I'd cite commit # being backported on the first one, and I'll need to
take second look at these:

! cite commit # of the patch being backported? > 7672af7c726f ALSA: pcm: Mo=
ve rwsem lock inside snd_ctl_elem_read to prevent UAF
! NL_SET_ERR_MSG? > e6f2bae11168 net: sched: disallow noqueue for qdisc cla=
sses
>

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lJXnA1CKZOSFAhfU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZApRDAAKCRAw5/Bqldv6
8iOcAKCDdUaXVFUmixfEQAG1aby778Y7SwCfXgJt+ec14iJ0GhVipVlvAiMkFXI=
=jDuw
-----END PGP SIGNATURE-----

--lJXnA1CKZOSFAhfU--

