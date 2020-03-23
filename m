Return-Path: <SRS0=7RAa=5I=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150AFC4332B
	for <cip-dev@archiver.kernel.org>; Mon, 23 Mar 2020 22:16:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFFD2070A
	for <cip-dev@archiver.kernel.org>; Mon, 23 Mar 2020 22:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFFD2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 55BDF86807;
	Mon, 23 Mar 2020 22:16:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hz_JAVzHEH8y; Mon, 23 Mar 2020 22:16:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 11BA4867C6;
	Mon, 23 Mar 2020 22:16:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB713C0177;
	Mon, 23 Mar 2020 22:16:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D278C0177
 for <cip-dev@lists.cip-project.org>; Mon, 23 Mar 2020 22:16:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EFB3C203DF
 for <cip-dev@lists.cip-project.org>; Mon, 23 Mar 2020 22:16:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V3jbAOUQSHTE for <cip-dev@lists.cip-project.org>;
 Mon, 23 Mar 2020 22:16:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by silver.osuosl.org (Postfix) with ESMTPS id 4FAC5203B2
 for <cip-dev@lists.cip-project.org>; Mon, 23 Mar 2020 22:16:11 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 048661C013F; Mon, 23 Mar 2020 23:16:06 +0100 (CET)
Date: Mon, 23 Mar 2020 23:16:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andreas =?iso-8859-1?Q?Wei=DFel?= <andreas.weissel@gmail.com>
Message-ID: <20200323221606.GA7808@duo.ucw.cz>
References: <CAC4QREfMtM1MQBVf2ZhRbBstUkCBbny5pwWEd_dJ09GcQpyiHA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAC4QREfMtM1MQBVf2ZhRbBstUkCBbny5pwWEd_dJ09GcQpyiHA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Super long-term kernel support
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
Content-Type: multipart/mixed; boundary="===============1798654618774722259=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>


--===============1798654618774722259==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I have a question regarding the super long-term kernel support: can
> other commercial or non-commercial projects make use of such kernel
> versions like "linux-4.19.y-cip", i.e., use the CIP git repositories
> to address security issues (CVEs) in the Linux kernel even after the
> upstream long-term versions are no longer supported, or is this
> considered a service for members only?

Kernel is GPLed. If you get any version of kernel from anywhere, you
are basically welcome to use it any way you want. That's what GPL
says.

Check with your lawyers.

(Plus, CIP project is trying to be friendly member of community....)

Best regards,
									Pavel
(Not a lawyer, not speaking for anyone but my horse.)
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXnk1JgAKCRAw5/Bqldv6
8mvXAKC4UXO+ui5Gm+GqHe5A9iMO8w8AgwCfXGTTc6nX9dZdcPpcN7zLbCy/Dw4=
=e64Y
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--

--===============1798654618774722259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============1798654618774722259==--
