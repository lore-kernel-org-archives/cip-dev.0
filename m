Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77291C433EF
	for <webhook@archiver.kernel.org>; Tue,  5 Oct 2021 17:47:37 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.77.1633456055269259391
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Oct 2021 10:47:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 65D3D1C0B80; Tue,  5 Oct 2021 19:47:26 +0200 (CEST)
Date: Tue, 5 Oct 2021 19:47:25 +0200
From: Pavel Machek <pavel@denx.de>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: "Bhola, Bikram" <Bikram_Bhola@mentor.com>, Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Prompt timeouts on ipc227e board -- randomness related?
Message-ID: <20211005174725.GA15330@duo.ucw.cz>
References: <20210925200625.GA19637@duo.ucw.cz>
 <OSZPR01MB6877A8787F60CB9D584474CAB7A89@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <a34a0fcb84f449ef83e2843bec5a6d02@SVR-IES-MBX-03.mgc.mentorg.com>
 <OSZPR01MB68770F80AE64400871800F6EB7AF9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: 
 <OSZPR01MB68770F80AE64400871800F6EB7AF9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Oct 2021 17:47:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6791


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > We investigated the failure job and looks like before getting login pro=
mpt job
> > timeout is happening . In the job definition  file - job timeout is men=
tioned
> > 15mins and  sometimes due to slow network issue, it takes more time whi=
le
> > downloading, untar  and deploying image. So we are seeing timeout during
> > login prompt or in some cases in earlier stages also.  The work in prog=
ress to
> > double up the network bandwidth within a few weeks, which will reduce t=
he
> > occurrence of this type of issues.
>=20
> Thank you for your investigation.
> I've have increased the timeout as you have suggested:
> https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/merge_requests/=
49
>=20
> One additional thing I've noticed, the default x86 character delay during=
 boot is 500ms, which seems a long time inbetween each character sent to th=
e platform
> https://lava.ciplatform.org/scheduler/device/x86-simatic-ipc227e-01/devic=
edict#defline5
>=20
> Has a lower value for boot_character_delay ever been tried?>

Thank you, but that board seems to still have problems:

https://lava.ciplatform.org/scheduler/job/458108


expect-shell-connection: Wait for prompt ['root@ebsy-isar:~#'] (timeout 00:=
10:00)
Waiting using forced prompt support (timeout 00:05:00)
end: 2.3.5 expect-shell-connection (duration 00:00:00) [common]
start: 2.3.6 export-device-env (timeout 00:01:00) [common]
Sending with 500 millisecond of delay
export NFS_ROOTFS=3D'/var/lib/lava/dispatcher/tmp/458108/extract-nfsrootfs-=
5xpf3q6i'
root@ebsy-isar:~# export NFS_ROOTFS=3D'/var/lib/lava/dispatcher/tmp/458108/=
extract-nfsrootfs-5xpf3q6i'
export NFS_ROOTFS=3D'/var/lib/lava/dispatcher/tmp/458108/extract -nfsrootfs=
-5xpf3q6i'
Sending with 500 millisecond of delay
export NFS_SERVER_IP=3D'134.86.254.28'
export-device-env timed out after 60 seconds
end: 2.3.6 export-device-env (duration 00:01:00) [common]
case: export-device-env
case_id: 9715377
definition: lava

(Of course, I can't rule out kernel problem at the moment, but failing
at setting environment variable would be strange.)

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYVyPrQAKCRAw5/Bqldv6
8sXHAJ0Y/TAu4xYEiz2gYn0ZyVIQz7RcUQCfQlmAq0HfHg+KItF6D1rSlmduucU=
=ua7l
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--

