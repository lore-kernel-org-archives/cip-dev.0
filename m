Return-Path: <SRS0=hvoq=7R=lists.cip-project.org=bounce+64572+4697+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF6FC433DF
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 08:46:05 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A25302075B
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 08:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="kJSOCmAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25302075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4697+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id FkQwYY4521723xFITRjekTT0; Thu, 04 Jun 2020 01:46:05 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.9574.1591260363938423532
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jun 2020 01:46:04 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5C0B51C0BD2; Thu,  4 Jun 2020 10:46:02 +0200 (CEST)
Date: Thu, 4 Jun 2020 10:46:01 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, JohnsonCH.Chen@moxa.com
Subject: Re: [cip-dev] [PATCH RESEND 4.4.y-cip 03/15] PM / OPP: Add {opp-microvolt|opp-microamp}-<name> binding
Message-ID: <20200604084601.GA18541@duo.ucw.cz>
References: <20200604041745.28886-1-wens@csie.org>
 <20200604041745.28886-4-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20200604041745.28886-4-wens@csie.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: BQVNbLzU1RW5SxrVYaE5Q0iBx4520388AA=
Content-Type: multipart/mixed; boundary="dpd6DmlkGtbsbOVgM9r7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591260365;
 bh=l+jg/ASvD5POMEZk8miBmEtC9Ez5aWcdVYULEZ4OK8o=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=kJSOCmAsGXe2J7mK6y28lseQNjBzm9DBRBUYEt/7XaINZHfspAVdEJH25b+BcMUpmLK
 s7uqdghCq2reLHUgAlJwmGiGRWBWfg3jw7Rbui6/CNfMBa/Aup7o4zJmhmKWxfa9vIKD7
 fKuvFGtgua/8f00QPhw/c9eGKeGIu1Au+zY=

--dpd6DmlkGtbsbOVgM9r7
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Viresh Kumar <viresh.kumar@linaro.org>
>=20
> commit ffdb8cc7a27c89175e541e68e2a73f1f63ab8c6b upstream.
>=20
> Depending on the version of hardware or its properties, which are only
> known at runtime, various properties of the OPP can change. For example,
> an OPP with frequency 1.2 GHz, may have different voltage/current
> requirements based on the version of the hardware it is running on.
>=20
> In order to not replicate the same OPP tables for varying values of all
> such fields, this commit introduces the concept of opp-property-<name>.
> The <name> can be chosen by the platform at runtime, and OPPs will be
> initialized depending on that name string. Currently support is extended
> for the following properties:
> - opp-microvolt-<name>
> - opp-microamp-<name>

That's really quite "interesting" design. I wondered if devicetree
people are okay with that.

> If the name string isn't provided by the platform, or if it is provided
> but doesn't match the properties present in the OPP node, we will fall
> back to the original properties without the -<name> string, if they are
> available.
>=20
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>

But, interestingly, their review tag is missing...?

As this is mainline, I don't think we need to do anything here. I
wonder how this kind of "wildcard" property names will play with new
yml format or automatic device tree checks.

Best regards,
								Pavel

> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -100,6 +100,14 @@ Optional properties:
>    Entries for multiple regulators must be present in the same order as
>    regulators are specified in device's DT node.
> =20
> +- opp-microvolt-<name>: Named opp-microvolt property. This is exactly si=
milar to
> +  the above opp-microvolt property, but allows multiple voltage ranges t=
o be
> +  provided for the same OPP. At runtime, the platform can pick a <name> =
and
> +  matching opp-microvolt-<name> property will be enabled for all OPPs. I=
f the
> +  platform doesn't pick a specific <name> or the <name> doesn't match wi=
th any
> +  opp-microvolt-<name> properties, then opp-microvolt property shall be =
used, if
> +  present.
> +
>  - opp-microamp: The maximum current drawn by the device in microamperes
>    considering system specific parameters (such as transients, process, a=
ging,
>    maximum operating temperature range etc.) as necessary. This may be us=
ed to

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXti0yQAKCRAw5/Bqldv6
8n/1AJ0duivs9FP1Br8DUpa5MV+KwCWn5wCeJ5470VMV+qBXXwO3gGqTX2XZCG0=
=IO2r
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--

--dpd6DmlkGtbsbOVgM9r7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4697): https://lists.cip-project.org/g/cip-dev/message=
/4697
Mute This Topic: https://lists.cip-project.org/mt/74665629/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--dpd6DmlkGtbsbOVgM9r7--
