Return-Path: <SRS0=7RAa=5I=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CDDC4332B
	for <cip-dev@archiver.kernel.org>; Mon, 23 Mar 2020 22:17:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD4E2073E
	for <cip-dev@archiver.kernel.org>; Mon, 23 Mar 2020 22:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD4E2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 392DC204ED;
	Mon, 23 Mar 2020 22:17:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id miwYEBNjDsxe; Mon, 23 Mar 2020 22:17:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 47AE0203B2;
	Mon, 23 Mar 2020 22:17:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EB68C0177;
	Mon, 23 Mar 2020 22:17:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D663C0177
 for <cip-dev@lists.cip-project.org>; Mon, 23 Mar 2020 22:17:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F09428550C
 for <cip-dev@lists.cip-project.org>; Mon, 23 Mar 2020 22:17:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YwzHoRU+Z7z0 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Mar 2020 22:17:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3AEBA81E53
 for <cip-dev@lists.cip-project.org>; Mon, 23 Mar 2020 22:17:26 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id B06AC1C0322; Mon, 23 Mar 2020 23:17:20 +0100 (CET)
Date: Mon, 23 Mar 2020 23:17:20 +0100
From: Pavel Machek <pavel@denx.de>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Message-ID: <20200323221720.GB7808@duo.ucw.cz>
References: <20200319110524.GA8475@duo.ucw.cz>
 <TYAPR01MB2285F2D82C8049EE8E7F073DB7F40@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <TYAPR01MB228523C8A226D17D38E7C3CDB7F40@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <5f2a3e394d6a5e9bc8b9e05df0b17c758c9c46fb.camel@codethink.co.uk>
 <20200319212357.GA28591@duo.ucw.cz>
 <TYAPR01MB2285AA6A0ED614311F861538B7F50@TYAPR01MB2285.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB2285AA6A0ED614311F861538B7F50@TYAPR01MB2285.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] realtime on de0-nano bisection
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
Content-Type: multipart/mixed; boundary="===============2609421520401949575=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>


--===============2609421520401949575==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > In the meantime:
> >
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/478548891
> > https://lava.ciplatform.org/scheduler/job/13037
> >
> > So yes, it seems this is not reproducible. Is it easy to make the test
> > run .. say 5 times?
>=20
> Just repeat the test case name 5 times in the gitlab-ci file.
> E.g. https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commit/791b840=
01ce05a9a26117a0c2de0e7250b343960
>

Thanks for useful trick. I'll try to remember it in case it is needed
again.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXnk1cAAKCRAw5/Bqldv6
8on6AJ9ZVzE3Lz6oqNQWgGgZq//4z0RBDACcDdYQXNWf57jUt0YIo65Q8umrn34=
=KgF2
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--

--===============2609421520401949575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============2609421520401949575==--
