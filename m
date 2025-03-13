Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB60C28B2E
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 12:44:31 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.13749.1741869863839988427
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 05:44:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=I4FhTeEp;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 235A31020999D;
	Thu, 13 Mar 2025 13:44:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741869861; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=hV6537O3N+eNaHV/1P7LdUffkJuB2eK+oUmu5mHtNv0=;
	b=I4FhTeEpAk2PUOviA5QUGVsD0v8+AbOY4GloOOKdihXsjofBCsTwwR1O7VTS0IXC7egBh3
	6rhhCDeqREFd94nswtmLpm7o4l8BhgV13AVXp9La0Tz+V8ANbPzy6oB5W3LymmaWk0etKR
	QrT8TtyfWvaZAFZPs9IMf5z1P+btWtiUKdBUDE4jwbQQSv8qWY8+mmoH5b8iKtsVbS+25h
	gQHeQXN87u4s4pdDi3AWkfkgbB+qn9N2+L2i7Eeyp4jB8nV8pPuI/SzhJHACPm/v/3eice
	s5JSUkWuG4AtkPObKl2T7eUUy0jW5o/c3xVQ66HL+nSc1DjkI0BYSMWjtED2LA==
Date: Thu, 13 Mar 2025 13:44:18 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: Script sharing
Message-ID: <Z9LTIqIVKZnqQzZw@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KaVL2JGOMbENE/Wk"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 12:44:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18195


--KaVL2JGOMbENE/Wk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

So... some of the polished scripts are in
git@gitlab.com:cip-project/cip-kernel/lts-commit-list.git repository,
directory bin.

But I guess there are some not-so polished script.

This is what I'm using for testing, called testhash. Yeah, especially
testing mainline trees is tricky, and results need to be checked in
web browser. Better solution would be welcome.

#!/bin/bash
# git checkout -b delme-613
# git diff ..linux-4.4.y-cip -- .gitlab-ci.yml | git apply
# git add -f .gitlab-ci.yml
# git commit -m 'add needed testing'

# git push -f git@gitlab.com:cip-project/cip-kernel/linux-cip.git 8a522bf2d=
4f788306443d36b26b54f0aedcdfdbe:refs/heads/ci/pavel/linux-4.4.y-cip-rt

RT=3Dlinux-test
if [ "a$1" =3D=3D "art" ]; then
    echo Requested rt test
    RT=3Dlinux-6.1.y-cip-rt
    shift
fi

if [ "a$1" !=3D "a" ]; then
    echo https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/=
$RT
    git push -f git@gitlab.com:cip-project/cip-kernel/linux-cip.git $1:refs=
/heads/ci/pavel/$RT

    # https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/lin=
ux-rc
    #git push -f git@gitlab.com:cip-project/cip-kernel/linux-cip.git $1:ci/=
pavel/linux-rc
else
    echo Need a hash
fi

And these are notes designed for copy-pasting I'm using to do -rt
releases. (Normal releases are slightly easier). I guess I can put it
into bin/ directory, too, but it would be tricky to turn it into
polished script.

Best regards,
								Pavel


BR=3DX.X

~/cip/k
git remote update
git log rt/v$BR-rt -- localversion-rt
git log origin/linux-$BR.y-cip -- localversion-cip

V=3D$VB-$CIP-$CRT
echo "$V ($RT) branch $BR"

# base version
git checkout linux-$BR.y-cip-rt
git merge ...
# rt verse potrebuji git rm localversion-rt; git commit
# increase version in localversion-cip-rt .
git add localversion-cip-rt
echo -$CRT `cat localversion-cip-rt` -$CIP  `cat localversion-cip`
git commit -m "Mark this as $V ($RT) release." -m '' -m 'Signed-off-by: Pav=
el Machek <pavel@denx.de>' localversion-cip-rt
=2E/testhash ...

# https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/linux-4.19.y-cip=
-rt

git checkout origin/linux-$BR.y-cip-rebase
# Pokud potrebuju starsi strom, lze git checkout v4.19.280-cip96-rebase
git checkout -b b$V-rebase
git log...
# Pokud je stejny base pro rt a cip...
git rebase -i v$VB --onto v$VB-$RT
# 4.4: cca 937 patchu.
# 4.19: cca 965 patchu.
# 5.10: cca 1140 patchu.
# 6.1: cca 505 patchu.
# Prvni by mel byt "CIP: Add a number to the version suffix".
git diff ..linux-$BR.y-cip-rt
git diff ..linux-$BR.y-cip-rt | git apply
git rm localversion-rt; git add localversion-cip-rt
git commit -m "Mark this as $V ($RT) (-rebase) release." -m '' -m 'Signed-o=
ff-by: Pavel Machek <pavel@denx.de>'

# v4.19.50-cip3-rt2-rebase
# v4.19.72-cip10-rt3 2c7eef0cfbb904f96032adea865661799a912e04
git checkout b$V-rebase
git tag -s v$V-rebase -m "Signing -cip-rt release" -u 95DBFAF2
git push -f --follow-tags origin b$V-rebase:linux-$BR.y-cip-rt-rebase

git checkout linux-$BR.y-cip-rt
git tag -s v$V -m "Signing -cip-rt release" -u 95DBFAF2
git push --follow-tags

# It is neccessary to have "cip rt" checked out.
git checkout linux-$BR.y-cip-rt
=2E./bin/git-archive-signer

dmutt -n
m jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, Chris.Paterson2@re=
nesas.com
Subject: [ANNOUNCE] v

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rt-rebase

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip-rt-rebase

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
								Pavel



--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--KaVL2JGOMbENE/Wk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9LTIgAKCRAw5/Bqldv6
8nNpAJ0V0x36Q614zgld4FK86cgiClCcOQCfdr2YPTT1vXLUo+Us5ffmbolxEac=
=mh9f
-----END PGP SIGNATURE-----

--KaVL2JGOMbENE/Wk--

