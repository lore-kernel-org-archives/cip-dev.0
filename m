Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FDBC83F2C
	for <webhook@archiver.kernel.org>; Mon,  4 Sep 2023 11:43:43 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.45778.1693827815905584752
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Sep 2023 04:43:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 559FA1C000B; Mon,  4 Sep 2023 13:43:32 +0200 (CEST)
Date: Mon, 4 Sep 2023 13:43:31 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: Request for reviews for 4.4-st44 4.4-cip79
Message-ID: <ZPXC40QtoXU/EYpO@duo.ucw.cz>
References: <1583308606.3395319.1693820637255@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Ks0kRy5+HeG8NdX"
Content-Disposition: inline
In-Reply-To: <1583308606.3395319.1693820637255@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Sep 2023 11:43:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12941


--1Ks0kRy5+HeG8NdX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> My apologies, this is a big one. Thankfully, most backports are of the tr=
ivial sort:

a-| 9559a3e60 f9c998 o  | x86/smp: Use dedicated cache-line for mwait_play_=
dead()
a -| f175f567b f8ef12 .+ | ARM: orion5x: fix d2net gpio initialization
!!incomplete,  _helper_init() needs same? -| 4ee69c91c 6eef7a o+ | netfilte=
r: conntrack: Avoid nf_ct_helper_hash uses after free
a -| f66069f9d 247c3d o  | ext4: fix wrong unit use in ext4_mb_clear_bb
a -| b3e17e6e6 a82d62 o+ | Revert "8250: add support for ASIX devices with =
a FIFO bug"
would not bother -- -| f35bd94b4 af73f2 o  | scsi: qla2xxx: Check valid rpo=
rt returned by fc_bsg_to_rport()
would not bother -- -| 005961bd8 00eca1 o  | scsi: qla2xxx: Pointer may be =
dereferenced
a -| 11b8e27ed 55c3b9 o+ | can: bcm: Fix UAF in bcm_proc_show()
a -| 8dc52c200 8ce884 f  | posix-timers: Ensure timer ID search-loop limit =
is valid
a -| 4793f9802 1aeb87 o+ | tcp: annotate data-races around tp->notsent_lowat
!!WRONG > ** m-| a276d17dc c55afc .  | usb: ohci-at91: Fix the unhandle int=
errupt when resume
a -| d3009700f c2a88e o+ | drm/client: Fix memory leak in drm_client_target=
_cloned
a -| f0f874147 3044b1 o+ | net/sched: cls_u32: No longer copy tcf_result on=
 update to avoid use-after-free
a -| 005f68d6b 949ad6 o+ | tcp_metrics: annotate data-races around tm->tcpm=
_stamp
a -| 38f1f09dc 8c4d04 o+ | tcp_metrics: annotate data-races around tm->tcpm=
_vals[]
I'd not bother backporting this -- -| e28208e21 404615 o  | ext2: Drop frag=
ment support
a -| 368684d3b 048c79 o  | ipv6: adjust ndisc_is_useropt() to also return t=
rue for PIO
a -| 8fad4df94 8a9896 o+ | net/packet: annotate data-races around tp->status
a -| 4eb1fca13 d6a95d    | quota: fix warning in dqgrab()

Most look okay to me. I'd not put too much work with READ_ONCE
annotations or qla2xxx warning tweaks, they don't really fix any real
bugs. "ext2: Drop fragment support" probably does not hurt, but surely
does not fix anything. I guess we can keep it when -stable took it,
but...

"usb: ohci-at91: Fix the unhandle interrupt when resume" is wrong, it
should do ohci_resume() once, not twice.

"netfilter: conntrack: Avoid nf_ct_helper_hash uses after free" is at
least incomplete -- nf_conntrack_helper_init() does not set the hash
to NULL in the error path. (Mainline does not have that bug, and code
change a lot there).

> These might need a closer look:

a | 70cc55f6c 1cba6c o+ | kexec: fix a memory leak in crash_shrink_memory()
a | 6fb4b3443 504a10 o  | gfs2: Don't deref jdesc in evict
a | 5df411bb8 8cda3e o+ | dmaengine: pl330: Return DMA_PAUSED when transact=
ion is paused

These look okay to me.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1Ks0kRy5+HeG8NdX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZPXC4wAKCRAw5/Bqldv6
8sxSAJ9JyR8nBicD8itQoPo2rxKMNvS6PwCbBydicdCmW7aoNtE2ApX/zagEITk=
=/VYe
-----END PGP SIGNATURE-----

--1Ks0kRy5+HeG8NdX--

