Return-Path: <whyshall.dev@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF843C43458
	for <webhook@archiver.kernel.org>; Tue, 14 Jul 2026 05:10:41 +0000 (UTC)
Subject: Re: Urgent: Regarding Fixing of Security Vulnerabilities
To: cip-dev@lists.cip-project.org
From: "whyshall" <whyshall.dev@gmail.com>
X-Originating-Location: IN (196.1.111.120)
X-Originating-Platform: Linux Chrome 149
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 13 Jul 2026 22:10:32 -0700
References: <CAOksrezPuEAoJ86FHMS_ajoH0h7pe3usksyo84n5rF9RKHfu4g@mail.gmail.com> <CAOksrezPuEAoJ86FHMS_ajoH0h7pe3usksyo84n5rF9RKHfu4g@mail.gmail.com> <alVT63ojQwHf4n7f@duo.ucw.cz>
In-Reply-To: <alVT63ojQwHf4n7f@duo.ucw.cz>
Message-ID: <606502.1784005832694212955@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="QNW1Is1c48dIGdMg7Yn9"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Jul 2026 05:10:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23570

--QNW1Is1c48dIGdMg7Yn9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------------------------On Tue, Jul 14, 2026 at 02:39 AM, Pavel Mach=
ek wrote:

>=20
> Would you mind introducing yourself, your company, and your product?
> - This is Vishal Maheshwari (Senior Research Engineer) from Center for
> Development of Telematics, Delhi, working on an embedded product based on
> Linux kernel 4.19.94.

---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------------------------

>=20
> Normally, we would recommend 6.12 kernel branch if you are doing the
> migration, anyway.

- Can't port to this kernel as the driver support for a particular device i=
n our board based on *Linux Kernel* *4.19.94* is missing in the *6.12.x* ke=
rnel and don't have the *expertise* to port the *driver(s)* to the *6.12.x =
series*. So,=C2=A0 can upgrade to *linux-cip-4.19.325-cipX* kernel only.

---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------------------------

>=20
> Take a look at
> git@...:cip-project/cip-kernel/cip-kernel-sec.git .

Ok, will try to run this tool. Would this tool be able to list out *the sol=
ved and unsolved vulnerabilities* in *linux-cip-4.19.325-cipX* based on the=
 *.config file* modified as per our board ?

---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------------------------

Also, will the CIP community not be solving all the vulnerabilities associa=
ted with the *4.19.325* reported by websites like cve.org, cvedetails.com, =
NVD databse etc in their repository *linux-cip* (repo link:- https://gitlab=
.com/cip-project/cip-kernel/linux-cip.git ) in *linux-4.19.y-cip branch* ?
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
------------------------

--QNW1Is1c48dIGdMg7Yn9
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>
<p style=3D"line-height: 100%; margin-bottom: 0.2in;">---------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------On Tue, Jul 14, 2026 at 02:39 AM, Pavel Machek wrote:</p>
<blockquote>Would you mind introducing yourself, your company, and your pro=
duct?<br />&nbsp;- This is Vishal Maheshwari (Senior Research Engineer) fro=
m Center for Development of Telematics, Delhi, working on an embedded produ=
ct based on Linux kernel 4.19.94. &nbsp;</blockquote>
<p>------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------------------------------</p>
<blockquote>Normally, we would recommend 6.12 kernel branch if you are doin=
g the<br />migration, anyway.</blockquote>
<p style=3D"margin-bottom: 0in;">- Can't port to this kernel as the driver =
support for a particular device in our board based on <strong>Linux Kernel<=
/strong> <strong>4.19.94</strong> is missing in the <strong>6.12.x</strong>=
 kernel and don't have the <strong>expertise</strong> to port the <strong>d=
river(s) </strong>to the <strong>6.12.x series</strong>. So,&nbsp; can upgr=
ade to <strong>linux-cip-4.19.325-cipX</strong> kernel only.</p>
<p>------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------------------------------</p>
<blockquote>Take a look at<br />git@...:cip-project/cip-kernel/cip-kernel-s=
ec.git .</blockquote>
<p style=3D"margin-bottom: 0in;">Ok, will try to run this tool. Would this =
tool be able to list out <strong>the solved and unsolved vulnerabilities </=
strong>in<strong> &nbsp;linux-cip-4.19.325-cipX</strong> based on the<stron=
g>&nbsp;.config file</strong> modified as per our board ?</p>
<p style=3D"margin-bottom: 0in;">------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------------------------------------------------------------<br /><br /=
>Also, will the CIP community not be solving all the vulnerabilities associ=
ated with the <strong>4.19.325 </strong><em>reported by websites like cve.o=
rg, cvedetails.com, NVD databse etc </em>in their repository <strong>linux-=
cip</strong>(repo link:- <a href=3D"https://gitlab.com/cip-project/cip-kern=
el/linux-cip.git" target=3D"_blank" rel=3D"noopener">https://gitlab.com/cip=
-project/cip-kernel/linux-cip.git</a>) in <strong>linux-4.19.y-cip branch <=
/strong>?<em><br />--------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------------------------------------</em></p>
<p style=3D"line-height: 100%; margin-bottom: 0in;">&nbsp;</p>
</div>

--QNW1Is1c48dIGdMg7Yn9--

