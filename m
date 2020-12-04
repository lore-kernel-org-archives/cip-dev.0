Return-Path: <SRS0=KZBP=FI=lists.cip-project.org=bounce+64572+5945+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F086C4361A
	for <cip-dev@archiver.kernel.org>; Fri,  4 Dec 2020 17:48:18 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 759CF22A83
	for <cip-dev@archiver.kernel.org>; Fri,  4 Dec 2020 17:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759CF22A83
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5945+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XMZ8YY4521723x4dHXkqMZxG; Fri, 04 Dec 2020 09:48:16 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.18156.1607104095616512840
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Dec 2020 09:48:16 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 85C1C1C0B93; Fri,  4 Dec 2020 18:48:10 +0100 (CET)
Date: Fri, 4 Dec 2020 18:48:10 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>,
	"kernel-build-reports@lists.linaro.org" <kernel-build-reports@lists.linaro.org>,
	"kernelci-results@groups.io" <kernelci-results@groups.io>
Subject: Re: [cip-dev] cip/linux-4.4.y-cip usb: 4 runs, 2 regressions (v4.4.243-cip51-21-g1d9a9094c010)
Message-ID: <20201204174810.GA8507@duo.ucw.cz>
References: <5fc87876.1c69fb81.a7e0a.0844@mx.google.com>
 <20201204164008.GB1781@duo.ucw.cz>
 <OSAPR01MB238504B0E42A849BF97CF39AB7F10@OSAPR01MB2385.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSAPR01MB238504B0E42A849BF97CF39AB7F10@OSAPR01MB2385.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WgcgSBn1rYV89QBv0jTAGLDJx4520388AA=
Content-Type: multipart/mixed; boundary="7T8pesQawHGymAIgyxis"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607104096;
 bh=o98OC/adE8Pcn6ptjxrYZayAd3CpOuekQ6f1FXaysjs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=FvQUK7HfJIv4BcVwFSWH4Jml0Kaujsg+pFT9YQDWkfEo8YlFMoaBMc7wUoWgrIfS9LH
 fmE9l1P6CfSO9KpZLwFA3e6lbclfPTApxPUDVmaUzXvy/CR83SdPy+rAVQF8U4/QLtYFo
 CbDTtWixjFSiou0j5qg/rPdpIgKRKdCwl1c=

--7T8pesQawHGymAIgyxis
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > *** gpg4o | HINT: Error while checking message with detached signature
> > (PGP/MIME signature)!
> > Couldn't locate the original MIME source of the mail to verify the sign=
ature!
> > gpg4oh32.dll:: func_IV Init OK ***
> >
> > Hello, bot. Can you speak english?
>=20
> Beep boop.
>=20
> I've recently enabled these email reports. They come from KernelCI.org.
> I meant to say yesterday, but forgot :(

No problem :-).

> > >=A0=A0=A0=A0 2020-12-03 05:04:20.968000+00:00=A0 [=A0=A0 18.800704] Fr=
eezing remaining
> > freezable tasks ... (elapsed 0.001 seconds) done.
> > >=A0=A0=A0=A0 2020-12-03 05:04:20.972000+00:00=A0 [=A0=A0 18.809224] Su=
spending console(s)
> > (use no_console_suspend to debug)
> > >=A0=A0=A0=A0 2020-12-03 05:04:23.674000+00:00=A0 [=A0=A0 18.865290] hu=
b 3-1:1.0: activate --> -
> > 113
> > >=A0=A0=A0=A0 2020-12-03 05:04:23.675000+00:00=A0 [=A0=A0 18.867538] PM=
: suspend of devices
> > complete after 51.550 msecs
> > >=A0=A0=A0=A0 2020-12-03 05:04:23.685000+00:00=A0 [=A0=A0 18.868293] PM=
: late suspend of
> > devices complete after 0.750 msecs
> > >=A0=A0=A0=A0 ... (66 line(s) more)
> >
> >
> > I'm not sure where you see failure here, plus I find it hard to
> > believe that we have broken anything between
> > v4.4.243-cip51-10-gd7466739b72e9 and v4.4.243-cip51-21-g1d9a9094c010.
>=20
> Looking at the full test log [0] it looks like a comparison (before.txt w=
ith after-freeze.txt) has gone wrong. Presumably some corrupt data?
>=20
> 05:04:29.997473  + lava-test-case compare-freeze --shell diff -u before.t=
xt after-f[   27.830724] <LAVA_SIGNAL_STARTTC compare-freeze>
> 05:04:30.009142  reeze.txt
> 05:04:30.009390  --- before.txt[   27.841181] <LAVA_SIGNAL_ENDTC compare-=
freeze>
> 05:04:30.009581  	2019-02-14 10:12:01.895000001 +0000
> 05:04:30.020487  +++ after-freeze.txt	2019-[   27.848337] <LAVA_SIGNAL_TE=
STCASE TEST_CASE_ID=3Dcompare-freeze RESULT=3Dfail>
> 05:04:30.020750  02-14 10:12:11.459256544 +0000
> 05:04:30.032157  @@ -1,4 +1,5 @@
> 05:04:30.032446   0424:9514
> 05:04:30.032634  +0424:ec00
> 05:04:30.032840   04f2:b443
> 05:04:30.033020   1d6b:0002
> 05:04:30.033195   1d6b:0002

This looks like USB id's. (1d6b: is Linux foundation, common in USB
hubs). So I believe this tells us that someone plugged in device
0424:ec00 -- ID 0424:ec00 Standard Microsystems Corp. SMSC9512/9514
Fast Ethernet Adapter ... and I don't think we have a bug to solve
here.

Best regards,

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX8p2WgAKCRAw5/Bqldv6
8tSwAJ9ouVMD+Emt274TwQz8riF6GZuQIQCfURlhVDymu939JBFS4dFbpQEef/o=
=cNfB
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

--7T8pesQawHGymAIgyxis
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5945): https://lists.cip-project.org/g/cip-dev/message=
/5945
Mute This Topic: https://lists.cip-project.org/mt/78682105/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--7T8pesQawHGymAIgyxis--
