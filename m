Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41ACC433F5
	for <webhook@archiver.kernel.org>; Wed,  9 Mar 2022 21:37:22 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.2449.1646861841408172171
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Mar 2022 13:37:22 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D53331C0B77; Wed,  9 Mar 2022 22:37:16 +0100 (CET)
Date: Wed, 9 Mar 2022 22:37:16 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
	masami.ichikawa@miraclelinux.com
Subject: Fun ahead -- speculation problems being patched in 5.10.105
Message-ID: <20220309213716.GA9983@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Mar 2022 21:37:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7684


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

It looks like 5.10.105 will be "fun" release. There's big series of
arm64 related speculation tweaks, including

 |61f85b56f 558c30 o: 5.10| arm64: Mitigate spectre style branch history si=
de channels

And apparently there are some problems on x86-64 side, too:

 |d185aa3cb e9b601 .: 5.10| x86/speculation: Update link to AMD speculation=
 whitepaper
 |edc29f23a eafd98 o: 5.10| x86/speculation: Warn about Spectre v2 LFENCE m=
itigation
 |67997c824 0de05d o: 5.10| x86/speculation: Warn about eIBRS + LFENCE + Un=
privileged eBPF + SMT

We have seen worse stuff for a hardware bug mitigation before. Scary
thing here is that arm64 patches are queued against 5.10 but not 4.19
or earlier.

Let me reiterate again that using complex out-of-order CPU is a bad
idea if you care about security.

Let me reiterate that JITs such as eBPF are complex/dangerous and
especially unpriviledged eBPF is risky.

v |316f1dd5e 44a391 o: 5.10| x86/speculation: Include unprivileged eBPF sta=
tus in Spectre v2 mitigation reporting

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYikeDAAKCRAw5/Bqldv6
8sjaAJ47hef9a+elO0OiBWv7LO2UAN6FkgCfR4OzaO8oHz7qUpBAZeM2aM3tY/g=
=uIl3
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--

