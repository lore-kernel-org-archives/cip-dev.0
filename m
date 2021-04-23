Return-Path: <SRS0=QiA6=JU=lists.cip-project.org=bounce+64572+6388+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8500AC433ED
	for <cip-dev@archiver.kernel.org>; Fri, 23 Apr 2021 18:40:55 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBC2613F2
	for <cip-dev@archiver.kernel.org>; Fri, 23 Apr 2021 18:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBC2613F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6388+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dMbDYY4521723xJNdWnjp0iz; Fri, 23 Apr 2021 11:40:54 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.528.1619203252777083696
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Apr 2021 11:40:53 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C0CA91C0B76; Fri, 23 Apr 2021 20:40:49 +0200 (CEST)
Date: Fri, 23 Apr 2021 20:40:49 +0200
From: "Pavel Machek" <pavel@denx.de>
To: Neal Caidin <ncaidin@linuxfoundation.org>
Cc: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, wens@csie.org
Subject: Re: [cip-dev] umn.edu situation and its effects on stable/cip
Message-ID: <20210423184049.GB9453@duo.ucw.cz>
References: <20210423105756.GA22991@duo.ucw.cz>
 <CAODMxs+xAquxDmtbC_4OUk=34HEm3HBAxbZ00kaeVYMZgHnrzg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODMxs+xAquxDmtbC_4OUk=34HEm3HBAxbZ00kaeVYMZgHnrzg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 0FevGGnfgDNcr1Vd78z4zQjDx4520388AA=
Content-Type: multipart/mixed; boundary="DJYgQfEwh1TDHecx9WrY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619203254;
 bh=QTEtn1W2Iev1OmfXuCPOvsWyNzqZBj3yy50xoZcDtM0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ZUJX7N9RFLADqmC3PHTl5Um2H3tFxt8mFhFcsH1P5DmWFTZUPEBxdDR8Lm/+D1FlR3W
 cV8Cc3RxAhi3a99yX23ghqzydvWmRdSorziMBAbeWNmU4aCeRMdGK5NlLirigsVwKLeRm
 MPdHuS7w6B4lSW0IvcTobMG8L2Ke/K+W9Tw=

--DJYgQfEwh1TDHecx9WrY
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline

--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> A Linux Foundation colleague has offered to do an analysis for projects to
> assess the situation.
>=20
> "I can run an analysis of ... source code looking for commits from the two
> PhDs who are currently known, and also look for any commits from an @umn.=
edu
> email address."
>=20
> If this is of interest, I'll look into this offer further.

Well, there's big series from Greg:

Date: Wed, 21 Apr 2021 14:57:55 +0200
=46rom: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 000/190] Revertion of all of the umn.edu commits
Message-Id: <20210421130105.1226686-1-gregkh@linuxfoundation.org>

If noone commented on the patch, yet, analysing it may not be bad
idea. There is a lot of fixes in there, and we don't want to revert
those.

(But I believe this is so hot issue that there will be enough manpower
on it.)

Best regards,

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYIMUsQAKCRAw5/Bqldv6
8pX2AJ9eK0Kmsiv8ZBzl5S35YvMSbdLQFgCfbZR2TD4yRjZf1vlqOOVlz8Q5uuE=
=geXB
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--

--DJYgQfEwh1TDHecx9WrY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6388): https://lists.cip-project.org/g/cip-dev/message=
/6388
Mute This Topic: https://lists.cip-project.org/mt/82307678/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--DJYgQfEwh1TDHecx9WrY--
