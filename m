Return-Path: <SRS0=HF/9=OZ=lists.cip-project.org=bounce+64572+6791+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F50C433F5
	for <cip-dev@archiver.kernel.org>; Tue,  5 Oct 2021 17:47:38 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D997613A9
	for <cip-dev@archiver.kernel.org>; Tue,  5 Oct 2021 17:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D997613A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id CzGCYY4521723xUhazceGYyt; Tue, 05 Oct 2021 10:47:37 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.77.1633456055269259391
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Oct 2021 10:47:36 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 65D3D1C0B80; Tue,  5 Oct 2021 19:47:26 +0200 (CEST)
Date: Tue, 5 Oct 2021 19:47:25 +0200
From: "Pavel Machek" <pavel@denx.de>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: "Bhola, Bikram" <Bikram_Bhola@mentor.com>, Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] Prompt timeouts on ipc227e board -- randomness related?
Message-ID: <20211005174725.GA15330@duo.ucw.cz>
References: <20210925200625.GA19637@duo.ucw.cz>
 <OSZPR01MB6877A8787F60CB9D584474CAB7A89@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <a34a0fcb84f449ef83e2843bec5a6d02@SVR-IES-MBX-03.mgc.mentorg.com>
 <OSZPR01MB68770F80AE64400871800F6EB7AF9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSZPR01MB68770F80AE64400871800F6EB7AF9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: owMstOGtmDZ8P2yYFal9FkVdx4520388AA=
Content-Type: multipart/mixed; boundary="FYiPlgGeXCKnGmeZ3Fu0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633456057;
 bh=ATN4/KkRUeQCJhh8YnbKIvaN+QP5CgEbVUnaS8zelss=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Q8+2LZBogfMDxRaSOkDHbsHaVHrU6TmyshDTm9K5uIZkapVyQpCAFMPaZb63Zkh94wV
 nkl/LhfNvPNYEvI6spoRmowEO7CV1pFFwNv+7soEdzwneaQo7tsLPKijQ+fyqh9IbHhnp
 DnSAdVtBjxrOxHz2SjSoUb1DDyCq2v+SKeI=
Message-ID: <20211005174725.xT0_5GFiXCldxxNKHTHSmbAAxFWrRVby84MpVn8uWhY@z>

--FYiPlgGeXCKnGmeZ3Fu0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline

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

--FYiPlgGeXCKnGmeZ3Fu0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6791): https://lists.cip-project.org/g/cip-dev/message/=
6791
Mute This Topic: https://lists.cip-project.org/mt/85867572/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--FYiPlgGeXCKnGmeZ3Fu0--
