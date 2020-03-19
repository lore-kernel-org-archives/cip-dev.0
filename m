Return-Path: <SRS0=K/mb=5E=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65005C4332D
	for <cip-dev@archiver.kernel.org>; Thu, 19 Mar 2020 21:24:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C0E2072C
	for <cip-dev@archiver.kernel.org>; Thu, 19 Mar 2020 21:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C0E2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F1163857D1;
	Thu, 19 Mar 2020 21:24:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gH00MpANboBU; Thu, 19 Mar 2020 21:24:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2209C86E41;
	Thu, 19 Mar 2020 21:24:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1039DC07FF;
	Thu, 19 Mar 2020 21:24:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71685C07FF
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 21:24:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6084888146
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 21:24:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fr7vULleSooD for <cip-dev@lists.cip-project.org>;
 Thu, 19 Mar 2020 21:24:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4B1A288120
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 21:24:03 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 1B5C81C0320; Thu, 19 Mar 2020 22:23:59 +0100 (CET)
Date: Thu, 19 Mar 2020 22:23:58 +0100
From: Pavel Machek <pavel@denx.de>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Message-ID: <20200319212357.GA28591@duo.ucw.cz>
References: <20200319110524.GA8475@duo.ucw.cz>
 <TYAPR01MB2285F2D82C8049EE8E7F073DB7F40@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <TYAPR01MB228523C8A226D17D38E7C3CDB7F40@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <5f2a3e394d6a5e9bc8b9e05df0b17c758c9c46fb.camel@codethink.co.uk>
MIME-Version: 1.0
In-Reply-To: <5f2a3e394d6a5e9bc8b9e05df0b17c758c9c46fb.camel@codethink.co.uk>
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
Content-Type: multipart/mixed; boundary="===============3477853244801550388=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>


--===============3477853244801550388==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > From: cip-dev <cip-dev-bounces@lists.cip-project.org> On Behalf Of Ch=
ris
> > > Paterson
> > > Sent: 19 March 2020 11:23
> > >=20
> > > Hello Pavel,
> > >=20
> > > > From: Pavel Machek <pavel@denx.de>
> > > > Sent: 19 March 2020 11:05
> [...]
> > > > like tests are unreliable (and even my basic assumptions may be wor=
th
> > > > re-testing).
> > > >=20
> > > > Can you help? I'll be away from console for a few hours now.
> > >=20
> > > I'll get bisecting.
> >=20
> > Last 'good' patch is: 2089f853a8c3 ("drm/i915: disable tracing on
> > -RT")
> > The first 'bad' path is: c82fe0af5e58 ("drm/i915: skip
> > DRM_I915_LOW_LEVEL_TRACEPOINTS with NOTRACE")
> >=20
> > Don't ask me why c82fe0af5e58 causes a boot issue on the de0-nano
> > board but at least it's a starting point for you.
> [...]
>=20
> When bisection finds a commit touching code that you're not even
> building, the answer should not be "don't ask me why" but "this is not
> a reproducible bug".

That's my job, I guess. I asked for bisect and got bisect
(thanks!). And yes, I have to agree:

In the meantime:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/478548891
https://lava.ciplatform.org/scheduler/job/13037

So yes, it seems this is not reproducible. Is it easy to make the test
run .. say 5 times?

I'm starting to suspect

pick fc9f4631a290 irqwork: push most work into softirq context

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXnPi7QAKCRAw5/Bqldv6
8vb7AKCKLT4biw/nbyaA089nKBTOJ5nFrwCgrWTpM86zJyuIV+IitrkJWh41zLk=
=Help
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

--===============3477853244801550388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============3477853244801550388==--
