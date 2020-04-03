Return-Path: <SRS0=hSFH=5T=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31196C43331
	for <cip-dev@archiver.kernel.org>; Fri,  3 Apr 2020 21:47:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF84A2078C
	for <cip-dev@archiver.kernel.org>; Fri,  3 Apr 2020 21:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF84A2078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AD48487A9C;
	Fri,  3 Apr 2020 21:47:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NBzDGPLbFpog; Fri,  3 Apr 2020 21:47:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E51C58791E;
	Fri,  3 Apr 2020 21:47:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDCAEC07FF;
	Fri,  3 Apr 2020 21:47:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12940C07FF;
 Fri,  3 Apr 2020 21:47:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0A3E78791E;
 Fri,  3 Apr 2020 21:47:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3cvPStMiOKls; Fri,  3 Apr 2020 21:47:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3A206878ED;
 Fri,  3 Apr 2020 21:47:13 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id B5B801C3720; Fri,  3 Apr 2020 23:47:08 +0200 (CEST)
Date: Fri, 3 Apr 2020 23:47:08 +0200
From: Pavel Machek <pavel@denx.de>
To: Kento Yoshida <kento.yoshida.wz@renesas.com>
Message-ID: <20200403214708.GA32080@duo.ucw.cz>
References: <TYAPR01MB2399241EB327E673BD6F48EFDFC60@TYAPR01MB2399.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB2399241EB327E673BD6F48EFDFC60@TYAPR01MB2399.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Python 3.x vs 2.7
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1325243163782668675=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>


--===============1325243163782668675==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> FYI, unfortunately we couldn't find the alternative package for system ba=
ckup. The duplicity is the best package for us from the license and num of =
dependencies point of view.
> See the following.
>

> <duplicity>
> Encryption: Yes
> Schedule backup: No
> Incremental backup: Yes
> License: GPL v2
> Dependencies count (aprox): 80
> Reference: http://duplicity.nongnu.org/features.ht

I'm not sure what your exact requirements are, but have you considered
"tar"? It should be possible to pipe its output to aespipe (and
possibly other tools) to get encryption, and it should be able to do
incremental backups...

Best regards,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXoeu3AAKCRAw5/Bqldv6
8utZAKCptA2U5XWc2PwHd/S1Ixfcguph0gCbBSVSSou3R4Tahv2zCIo4LQOQMig=
=R0Vi
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

--===============1325243163782668675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============1325243163782668675==--
