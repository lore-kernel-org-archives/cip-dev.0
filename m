Return-Path: <johnxw@amazon.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FA9C27C4F
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 03:31:44 +0000 (UTC)
Subject: Re: Adding swap space to the encrypted partition
To: cip-dev@lists.cip-project.org
From: "JohnW" <johnxw@amazon.com>
X-Originating-Location: Puyallup, Washington, US (174.21.53.213)
X-Originating-Platform: Mac Firefox 126
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 10 Jun 2024 20:31:41 -0700
References: <26684.1718045165094836518@lists.cip-project.org>
In-Reply-To: <26684.1718045165094836518@lists.cip-project.org>
Message-ID: <19666.1718076701122955939@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="fGwXbUXBJ58K6gLdK3Kr"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jun 2024 03:31:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16186

--fGwXbUXBJ58K6gLdK3Kr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I tried adding the following before the rootfs partition in the kickstart f=
ile.

>=20
> part swap --use-label --size 2G --label swap1 --fstype=3Dswap --fsoptions=
=3Dsw

and also tried updating https://github.com/ilbers/isar/blob/2c76d889035ea05=
114b1a31bb73b025c0247a278/scripts/lib/wic/plugins/imager/direct.py#L105 to =
allow swap to be added to the fstab. CRYPT_PARTITIONS has been updated to
>=20
>=20
> CRYPT_PARTITIONS =3D "swap1:swap:reencrypt platform:/:reencrypt"

also tried
>=20
> CRYPT_PARTITIONS =3D "swap1::reencrypt platform:/:reencrypt"

The image booted into initramfs and based on the debug log it says
>=20
> Begin: Encryption of /dev/sda2 ... cannot resize partition. unsupport
> fstype: swap

Regards,
John

--fGwXbUXBJ58K6gLdK3Kr
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I tried adding the following before the rootfs partition in the kickstart f=
ile.<br />
<blockquote>part swap --use-label --size 2G --label swap1 --fstype=3Dswap -=
-fsoptions=3Dsw</blockquote>
and also tried updating <a href=3D"https://github.com/ilbers/isar/blob/2c76=
d889035ea05114b1a31bb73b025c0247a278/scripts/lib/wic/plugins/imager/direct.=
py#L105" target=3D"_blank" rel=3D"noopener">https://github.com/ilbers/isar/=
blob/2c76d889035ea05114b1a31bb73b025c0247a278/scripts/lib/wic/plugins/image=
r/direct.py#L105</a> to allow swap to be added to the fstab. CRYPT_PARTITIO=
NS has been updated to
<blockquote>CRYPT_PARTITIONS =3D "swap1:swap:reencrypt platform:/:reencrypt=
"</blockquote>
also tried
<blockquote>CRYPT_PARTITIONS =3D "swap1::reencrypt platform:/:reencrypt"</b=
lockquote>
The image booted into initramfs and based on the debug log it says
<blockquote>Begin: Encryption of /dev/sda2 ... cannot resize partition. uns=
upport fstype: swap</blockquote>
Regards,<br />John

--fGwXbUXBJ58K6gLdK3Kr--

