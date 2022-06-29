Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0EAC43334
	for <webhook@archiver.kernel.org>; Wed, 29 Jun 2022 15:44:35 +0000 (UTC)
Subject: Re: [4.4.y] cred_getsecid hook
To: cip-dev@lists.cip-project.org
From: theflamefire89@gmail.com
X-Originating-Location: Dresden, Saxony, DE (217.254.152.199)
X-Originating-Platform: Linux Firefox 101
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 29 Jun 2022 08:44:31 -0700
References: <20220622120633.GB7458@duo.ucw.cz>
In-Reply-To: <20220622120633.GB7458@duo.ucw.cz>
Message-ID: <7356.1656517471464294518@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="wmR45h1ZFtWLT1mXdjw8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Jun 2022 15:44:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8624

--wmR45h1ZFtWLT1mXdjw8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>=20
> If CVE-2021-39686 is important to you, right way forward would be to
> backport neccessary changes to 4.9, first. We would rather not have
> changes in 4.4-st that are not present in 4.9.X.

Hi Pavel, thanks for the reply.

I'm happy to contribute what I have back to 4.9. Can you give me some guida=
nce on how I'd do that?
I've never contributed to the upstream kernel before but am confident in C/=
C++ and git and am maintaining an Android kernel fork.
In this case it should be pretty straight forward. All commits are from Goo=
gles android-mainline branch, backported where required, but mostly unchang=
ed and I have the upstream discussions from the kernel ML for reference. If=
 you are curious the 38 commits I want to backport to reduce the divergence=
 and then fix that CVE can be found at https://github.com/Flamefire/android=
_kernel_sony_msm8998/pull/24.

It will likely be easy enough to port them to the 4.9 branch but I'd need t=
o know how to have them applied and/or who to contact.

Best Regards,
Alex

PS: Greetings from Dresden, Germany

--wmR45h1ZFtWLT1mXdjw8
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<blockquote>If CVE-2021-39686 is important to you, right way forward would =
be to backport neccessary changes to 4.9, first. We would rather not have c=
hanges in 4.4-st that are not present in 4.9.X.</blockquote>
<p>Hi Pavel, thanks for the reply.</p>
<p>I'm happy to contribute what I have back to 4.9. Can you give me some gu=
idance on how I'd do that?<br />I've never contributed to the upstream kern=
el before but am confident in C/C++ and git and am maintaining an Android k=
ernel fork.<br />In this case it should be pretty straight forward. All com=
mits are from Googles android-mainline branch, backported where required, b=
ut mostly unchanged and I have the upstream discussions from the kernel ML =
for reference. If you are curious the 38 commits I want to backport to redu=
ce the divergence and then fix that CVE can be found at <a href=3D"https://=
github.com/Flamefire/android_kernel_sony_msm8998/pull/24" target=3D"_blank"=
 rel=3D"noopener">https://github.com/Flamefire/android_kernel_sony_msm8998/=
pull/24</a>.</p>
<p>It will likely be easy enough to port them to the 4.9 branch but I'd nee=
d to know how to have them applied and/or who to contact.<br /><br />Best R=
egards,<br />Alex</p>
<p>PS: Greetings from Dresden, Germany</p>

--wmR45h1ZFtWLT1mXdjw8--

