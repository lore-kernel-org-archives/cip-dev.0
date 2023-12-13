Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86D0C4167D
	for <webhook@archiver.kernel.org>; Wed, 13 Dec 2023 13:54:32 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.34579.1702468970369071805
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Dec 2023 04:02:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=pQWBgrQu;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1321639-20231213120247af30686742cdeeaf40-_1rp4x@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20231213120247af30686742cdeeaf40
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Dec 2023 13:02:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=WGO69o8igJGWufeWGBjbmBw2WrGUJKGjmCZmUB7z3oU=;
 b=pQWBgrQutkbkBPlEbkiD/QugPI7xcuEGkZn8VC7sayqENsy+VeWin5Fl+sTeDs0p8N4NKI
 eNCtAea2NZavjQYvDzNJw3rEVNsCObXZAKaaqYbMZsfj1oT8KnBwfxY8dhpwKsCMO343JMvW
 7uwJ8/ZWlox7fe0Ac21L0P1MtZL5w=;
Message-ID: <b95374d4eb3344bfd135ec5605d6f6b395578418.camel@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate-certificates*.inc: Add missing FILESEXTRAPATHS
From: Moessbauer Felix <felix.moessbauer@siemens.com>
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>, 
	cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Date: Wed, 13 Dec 2023 20:02:43 +0800
In-Reply-To: <1bd6fc08-38cc-4bdf-83d8-96f56cfdbce7@siemens.com>
References: <20231212141556.1616031-1-Quirin.Gylstorff@siemens.com>
	 <9b8314f6059fca9fb270921b8ce53e2149ec40f6.camel@siemens.com>
	 <1bd6fc08-38cc-4bdf-83d8-96f56cfdbce7@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Dec 2023 13:54:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14068

On Wed, 2023-12-13 at 12:45 +0100, Gylstorff Quirin wrote:
>=20
>=20
> On 12/13/23 04:27, Moessbauer Felix wrote:
> > On Tue, 2023-12-12 at 15:12 +0100, Quirin Gylstorff wrote:
> > > From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> > >=20
> > > This allows to include the files in downstream layers.
> > >=20
> > > Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> > > ---
> > > =C2=A0=C2=A0.../swupdate-certificates/swupdate-certificates-key.inc=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > | 2
> > > ++
> > > =C2=A0=C2=A0.../swupdate-certificates/swupdate-certificates.inc=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > | 2
> > > ++
> > > =C2=A0=C2=A02 files changed, 4 insertions(+)
> > >=20
> > > diff --git a/recipes-devtools/swupdate-certificates/swupdate-
> > > certificates-key.inc b/recipes-devtools/swupdate-
> > > certificates/swupdate-certificates-key.inc
> > > index d3d2e16..2c67e89 100644
> > > --- a/recipes-devtools/swupdate-certificates/swupdate-
> > > certificates-
> > > key.inc
> > > +++ b/recipes-devtools/swupdate-certificates/swupdate-
> > > certificates-
> > > key.inc
> > > @@ -11,6 +11,8 @@
> > > =C2=A0=20
> > > =C2=A0=C2=A0inherit dpkg-raw
> > > =C2=A0=20
> > > +FILESEXTRAPATHS:prepend :=3D "${FILE_DIRNAME}/files:"
> > > +
> > > =C2=A0=C2=A0PROVIDES +=3D "swupdate-certificates-key"
> > > =C2=A0=20
> > > =C2=A0=C2=A0SWU_SIGN_KEY ??=3D ""
> > > diff --git a/recipes-devtools/swupdate-certificates/swupdate-
> > > certificates.inc b/recipes-devtools/swupdate-
> > > certificates/swupdate-
> > > certificates.inc
> > > index 6673383..564dda4 100644
> > > --- a/recipes-devtools/swupdate-certificates/swupdate-
> > > certificates.inc
> > > +++ b/recipes-devtools/swupdate-certificates/swupdate-
> > > certificates.inc
> > > @@ -11,6 +11,8 @@
> > > =C2=A0=20
> > > =C2=A0=C2=A0inherit dpkg-raw
> > > =C2=A0=20
> > > +FILESEXTRAPATHS:prepend :=3D "${FILE_DIRNAME}/files:"
> >=20
> > Hi, did you check if this is compatible with sstate caching? We
> > must
> > avoid adding absolute paths to the signatures, as otherwise this
> > breaks
> > caching on the gitlab-cloud-ci runners.
>=20
> This should not be the case as it is added=20
> recipes-devtools/swupdate-certificates/files/swu-sign-cms scripts.
>=20
> I checked it with sstate-lint and it didn;t find any problems in=20
> isar-cip-core.

Ok, thanks for the clarification.

Felix

>=20
> Best regards,
> Quirin
>=20
> >=20
> > You can check that with the isar-sstate lint script.
> >=20
> > Best regards,
> > Felix
> >=20
> > > +
> > > =C2=A0=C2=A0PROVIDES +=3D "swupdate-certificates"
> > > =C2=A0=20
> > > =C2=A0=C2=A0SWU_SIGN_CERT ??=3D ""
> >=20


