Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F33C43334
	for <webhook@archiver.kernel.org>; Thu, 16 Jun 2022 13:30:53 +0000 (UTC)
Subject: [4.4.y] cred_getsecid hook
To: cip-dev@lists.cip-project.org
From: theflamefire89@gmail.com
X-Originating-Location: Dresden, Saxony, DE (217.254.145.221)
X-Originating-Platform: Linux Firefox 101
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 16 Jun 2022 06:30:50 -0700
Message-ID: <PVAj.1655386250477927031.ATkI@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="uNCFNBrcJuaZfiAqDTUJ"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jun 2022 13:30:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8571

--uNCFNBrcJuaZfiAqDTUJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

While working on backporting the fix for CVE-2021-39686 in the Android-"ver=
sion" of the 4.4.y kernel I noticed the missing cred_getsecid hook introduc=
ed in e.g. 4.19.y by 3ec30113264a7bcd389f51d1738e42da0f41bb5a ( https://git=
.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=3Dlinux-4.=
19.y&id=3D3ec30113264a7bcd389f51d1738e42da0f41bb5a )

It seems the LSM security_* hooks haven't received updates for a while in t=
his kernel. E.g. a source of error due to missed list HEAD init is due to 0=
302e28dee643932ee7b3c112ebccdbb9f8ec32c ( https://git.kernel.org/pub/scm/li=
nux/kernel/git/cip/linux-cip.git/commit/?h=3Dlinux-4.19.y&id=3D0302e28dee64=
3932ee7b3c112ebccdbb9f8ec32c ) merging in 3dfc9b02864b19f4dab376f14479ee4ad=
1de6c9e ( https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git=
/commit/security/security.c?h=3Dlinux-4.19.y&id=3D3dfc9b02864b19f4dab376f14=
479ee4ad1de6c9e ) which makes the HEAD initialization shorter and more reli=
able but trying to get that commit in results in quite a bit of merge confl=
icts as hooks have been added/removed in 4.19 which is not yet in 4.4.

Anyway: Are there any plans to synchronize the hooks in 4.4 with those in m=
ore recent kernels?

Regards,
Alexander

--uNCFNBrcJuaZfiAqDTUJ
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>While working on backporting the fix for CVE-2021-39686 in the Android-"=
version" of the 4.4.y kernel I noticed the missing cred_getsecid hook intro=
duced in e.g. 4.19.y by <a href=3D"https://git.kernel.org/pub/scm/linux/ker=
nel/git/cip/linux-cip.git/commit/?h=3Dlinux-4.19.y&amp;id=3D3ec30113264a7bc=
d389f51d1738e42da0f41bb5a" target=3D"_blank" rel=3D"noopener">3ec30113264a7=
bcd389f51d1738e42da0f41bb5a</a><br /><br />It seems the LSM security_* hook=
s haven't received updates for a while in this kernel. E.g. a source of err=
or due to missed list HEAD init is due to <a href=3D"https://git.kernel.org=
/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=3Dlinux-4.19.y&amp;id=
=3D0302e28dee643932ee7b3c112ebccdbb9f8ec32c" target=3D"_blank" rel=3D"noope=
ner">0302e28dee643932ee7b3c112ebccdbb9f8ec32c</a> merging in <a href=3D"htt=
ps://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/secur=
ity/security.c?h=3Dlinux-4.19.y&amp;id=3D3dfc9b02864b19f4dab376f14479ee4ad1=
de6c9e" target=3D"_blank" rel=3D"noopener">3dfc9b02864b19f4dab376f14479ee4a=
d1de6c9e</a> which makes the HEAD initialization shorter and more reliable =
but trying to get that commit in results in quite a bit of merge conflicts =
as hooks have been added/removed in 4.19 which is not yet in 4.4.<br /><br =
/>Anyway: Are there any plans to synchronize the hooks in 4.4 with those in=
 more recent kernels?<br /><br />Regards,<br />Alexander</p>

--uNCFNBrcJuaZfiAqDTUJ--

