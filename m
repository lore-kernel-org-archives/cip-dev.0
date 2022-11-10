Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8EEC43217
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 08:33:49 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.4482.1668069220633367675
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Nov 2022 00:33:41 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B7A5D1C09F3; Thu, 10 Nov 2022 09:33:36 +0100 (CET)
Date: Thu, 10 Nov 2022 09:33:36 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries this week
Message-ID: <Y2y3YIfTzTX0FVwX@duo.ucw.cz>
References: <CAODzB9pTzPzkeG7W6uY-E5ivktoXzv5=tQ77QnC7qNbk-h1udg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWhv0RVF/jf6M9eJ"
Content-Disposition: inline
In-Reply-To: <CAODzB9pTzPzkeG7W6uY-E5ivktoXzv5=tQ77QnC7qNbk-h1udg@mail.gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Nov 2022 08:33:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9994


--JWhv0RVF/jf6M9eJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * New CVEs
>=20
> CVE-2022-42895: Bluetooth: L2CAP: Fix attempting to access uninitialized =
memory
>=20
> CVSS v3 score is not provided.
>=20
> An accessing uninitialized variable bug was found in
> l2cap_parse_conf_req() in net/bluetooth/l2cap_core.c
> The efs variable is on the stack. It is initialized when the type
> variable is L2CAP_CONF_EFS.
> So, if type isn't L2CAP_CONF_EFS and rfc.mode is L2CAP_MODE_ERTM, then
> accessing uninitialized variable bug occurs.
>=20
> It looks 4.4 is affected by this issue too.
>=20
> Fixed status
> mainline: [b1a2cd50c0357f243b7435a732b4e62ba3157a2e]

Fix is queued for 5.10.154 and corresponding 4.9 kernel.

> CVE-2022-43945: A buffer overflow bug was found in nfsd
>=20
> CVSS v3 score is 7.5 HIGH.
>=20
> The Linux kernel NFSD implementation prior to versions 5.19.17 and
> 6.0.2 are vulnerable to buffer overflow. NFSD tracks the number of
> pages held by each NFSD thread by combining the receive and send
> buffers of a remote procedure call (RPC) into a single array of pages.
> A client can force the send buffer to shrink by sending an RPC message
> over TCP with garbage data added at the end of the message. The RPC
> message with garbage data is still correctly formed according to the
> specification and is passed forward to handlers. Vulnerable code in
> NFSD is not expecting the oversized request and writes beyond the
> allocated buffer space.
>=20
> nfsd3_proc_read() and nfsd_proc_read() changed to set argp->count
> value adding an extra min_t() macro.
> nfsd_init_dirlist_pages() and nfsd3_init_dirlist_pages() changed the
> process of setting buf->buflen value.
> However, 4.4, 4.19, 5.10 use different ways to set these values. So,
> even if these kernels are vulnerable, it needs a different way to fix
> them.
>=20
> Fixed status
> mainline: [00b4492686e0497fdb924a9d4c8f6f99377e176c,
> 640f87c190e0d1b2a0fcb2ecf6d2cd53b1c41991,
>   401bc1f90874280a80b93f23be33a0e7e2d1f912,
> fa6be9cc6e80ec79892ddf08a8c10cabab9baf38]
> stable/5.15: [dc7f225090c29a5f3b9419b1af32846a201555e7,
> 071a076fd1b763aa6fe478efa047e0a549ba9c22,
>   2be9331ca6061bc6ea32247266f45b8b21030244,
> 75d9de25a6f833dd0701ca546ac926cabff2b5af]
> stable/6.0: [f59c74df82f6ac9d2ea4e01aa3ae7c6c4481652d,
> 279274e31270c28b86feffe5e166d4088f22317b,
>   1868332032eccbab8c1878a0d918193058c0a905,
> 309f29361b6bfae96936317376f1114568c5de19]

Hmm. I don't see these  queued for 5.10. OTOH embedded systems are
normally NFS clients (and only during development), not NFS servers.

In 5.10.152, we fixed buffer overrun in nfsd, but that may be
different one:

 |0b06ecf29 788f71 o: 5.10| NFSD: Add common helpers to decode void args an=
d encode void results
 |78ad3a430 ebcd8e o: 5.10| NFSD: Update the NFSv2 GETATTR argument decoder=
 to use struct xdr_stream
 |8505cb6e4 8c293e o: 5.10| NFSD: Update the NFSv2 READ argument decoder to=
 use struct xdr_stream
 |827277f03 401bc1 o: 5.10| NFSD: Protect against send buffer overflow in N=
FSv2 READ
 |4204e1a23 c1346a o: 5.10| NFSD: Replace the internals of the READ_BUF() m=
acro
 |8bda97f4a cbd9ab o: 5.10| NFSD: Replace READ* macros in nfsd4_decode_comm=
it()
 |21b51f620 957536 o: 5.10| NFSD: Update GETATTR3args decoder to use struct=
 xdr_stream
 |fea1935a8 be63bd o: 5.10| NFSD: Update READ3arg decoder to use struct xdr=
_stream
 |fb4bb09fc 0cb4d2 o: 5.10| NFSD: Fix the behavior of READ near OFFSET_MAX
 |9748f4210 fa6be9 o: 5.10| NFSD: Protect against send buffer overflow in N=
FSv3 READ

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--JWhv0RVF/jf6M9eJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY2y3YAAKCRAw5/Bqldv6
8jHsAJ49nhrfs8mx2wBkWBvfZUlnsmLfgACfahZ1cJsmK/6iseqIoiFit6Eis5E=
=BxYB
-----END PGP SIGNATURE-----

--JWhv0RVF/jf6M9eJ--

