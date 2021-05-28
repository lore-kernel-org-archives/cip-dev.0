Return-Path: <SRS0=jw6R=KX=lists.cip-project.org=bounce+64572+6479+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D19C4708C
	for <cip-dev@archiver.kernel.org>; Fri, 28 May 2021 08:29:28 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01E361278
	for <cip-dev@archiver.kernel.org>; Fri, 28 May 2021 08:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01E361278
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6479+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Y2RKYY4521723x9Q7QuXAtFL; Fri, 28 May 2021 01:29:27 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.5662.1622190565797929114
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 May 2021 01:29:26 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D0A861C0B76; Fri, 28 May 2021 10:29:22 +0200 (CEST)
Date: Fri, 28 May 2021 10:29:21 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: CVE status was Re: [cip-dev] CIP IRC weekly meeting today
Message-ID: <20210528082921.GA28312@amd>
References: <TY2PR01MB4972D72BA28167827F3DDC92A0239@TY2PR01MB4972.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB4972D72BA28167827F3DDC92A0239@TY2PR01MB4972.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jv6rz3D7Dxab8gPDH0fv4PUJx4520388AA=
Content-Type: multipart/mixed; boundary="eJWSC6xayX314DvHUXva"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622190567;
 bh=NFc6l6deVFD3BU3dlnQn3WW0pV2D5bobccMtWgyX3JI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=tF5D42NMTiC2Kv5O/bK55np14EJQ3anYPkEV+VvzXQ0ygavdGnbCNqTmj+PCBm2P+Y2
 Go3ueur3WRBlpDIsoaJyIQaASIX3TIF7fjzBZaNB6zG+i+wzTvO9aqyupGS25gXKUAbNL
 nD6U4jo8esduSIzPegfvdpEZSi99LMFKk9Y=

--eJWSC6xayX314DvHUXva
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> 3. Monitor the status of CVE-2021-3444 and CVE-2021-20292 (3/25) -  Kerne=
l Team

I'll look into these.

> 4. Monitor the status of CVE-2021-29650 (4/1) - Kernel Team

This one is 4.4-stable branch and is expected to be released in
4.4.271. This can be closed.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCwqeEACgkQMOfwapXb+vJXLACeJSIzkfPIj+zkjgmY+QmV+MAl
vMcAoMNMsHPz7/68r4kiMTNP6FTwZalt
=v/LP
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

--eJWSC6xayX314DvHUXva
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6479): https://lists.cip-project.org/g/cip-dev/message=
/6479
Mute This Topic: https://lists.cip-project.org/mt/83144657/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--eJWSC6xayX314DvHUXva--
