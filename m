Return-Path: <johnxw@amazon.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EDCE7717F
	for <webhook@archiver.kernel.org>; Fri, 13 Dec 2024 18:05:48 +0000 (UTC)
Subject: Issue with the latest commit from master regarding initramfs-hook
To: cip-dev@lists.cip-project.org
From: "JohnW" <johnxw@amazon.com>
X-Originating-Location: Puyallup, Washington, US (174.21.60.212)
X-Originating-Platform: Mac Firefox 132
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 13 Dec 2024 10:05:39 -0800
Message-ID: <Atyk.1734113139634423310.wcyy@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="0A31vjAh1imicncOih96"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Dec 2024 18:05:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17420

--0A31vjAh1imicncOih96
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I am seeing the following error when building my image with the latest comm=
it from master. (2024-12-13 18:01:20 - INFO =C2=A0 =C2=A0 - Repository isar=
-cip-core checked out to b3b30a1b411db10012d9b4c79fd5d2b400c68eb9)

>=20
> build/../isar-cip-core/recipes-initramfs/initramfs-abrootfs-hook/initramf=
s-abrootfs-hook_0.2.bb:12:
> Could not include required file recipes-initramfs/initramfs-hook/hook.inc
>=20

It seems like the initramfs-hook recipe is no longer there?

Thanks,
John

--0A31vjAh1imicncOih96
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>&nbsp;</div>
<div>I am seeing the following error when building my image with the latest=
 commit from master. (2024-12-13 18:01:20 - INFO &nbsp; &nbsp; - Repository=
 isar-cip-core checked out to b3b30a1b411db10012d9b4c79fd5d2b400c68eb9)</di=
v>
<div>&nbsp;</div>
<blockquote>
<div>build/../isar-cip-core/recipes-initramfs/initramfs-abrootfs-hook/initr=
amfs-abrootfs-hook_0.2.bb:12: Could not include required file recipes-initr=
amfs/initramfs-hook/hook.inc</div>
</blockquote>
<div>&nbsp;</div>
<div>It seems like the initramfs-hook recipe is no longer there?</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>John</div>

--0A31vjAh1imicncOih96--

