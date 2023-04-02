Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A8FC7619A
	for <webhook@archiver.kernel.org>; Sun,  2 Apr 2023 18:34:09 +0000 (UTC)
Subject: Re: [PATCH 4.4 0/3] ALSA: control: Fix locking around snd_ctl_elem_read/write
To: cip-dev@lists.cip-project.org
From: "Alexander Grund" <theflamefire89@gmail.com>
X-Originating-Location: Dresden, Saxony, DE (79.254.4.138)
X-Originating-Platform: Linux Firefox 111
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Sun, 02 Apr 2023 11:34:02 -0700
References: <ZCmtowC1mia0A1Cx@duo.ucw.cz>
In-Reply-To: <ZCmtowC1mia0A1Cx@duo.ucw.cz>
Message-ID: <24425.1680460442746826724@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="sOqiE5ZD4geONGmun3Vx"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 02 Apr 2023 18:34:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11143

--sOqiE5ZD4geONGmun3Vx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>=20
> Second option is to cherry-pick these:

That's exactly what I did here. From my submissions to the upstream kernels=
 I was told that a 0/x EMail is required for a multi-commit change.

I haven't found a guideline how to submit patches to CIP kernels, so I just=
 followed that procedure. See: https://lists.cip-project.org/g/cip-dev/mess=
age/11117 https://lists.cip-project.org/g/cip-dev/message/11118 https://lis=
ts.cip-project.org/g/cip-dev/message/11119

It seems that was wrong. So can you tell me please how to submit patches to=
 CIP in the future and whether the current mails are acceptable (despite th=
e minor description changes requested there)?

Thanks,

Alex

--sOqiE5ZD4geONGmun3Vx
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<blockquote>Second option is to cherry-pick these:</blockquote>
<p>That's exactly what I did here. From my submissions to the upstream kern=
els I was told that a 0/x EMail is required for a multi-commit change.</p>
<p>I haven't found a guideline how to submit patches to CIP kernels, so I j=
ust followed that procedure. See: <a href=3D"https://lists.cip-project.org/=
g/cip-dev/message/11117" target=3D"_blank" rel=3D"noopener">https://lists.c=
ip-project.org/g/cip-dev/message/11117</a> <a href=3D"https://lists.cip-pro=
ject.org/g/cip-dev/message/11118" target=3D"_blank" rel=3D"noopener">https:=
//lists.cip-project.org/g/cip-dev/message/11118</a> <a href=3D"https://list=
s.cip-project.org/g/cip-dev/message/11119" target=3D"_blank" rel=3D"noopene=
r">https://lists.cip-project.org/g/cip-dev/message/11119</a><br /><br />It =
seems that was wrong. So can you tell me please how to submit patches to CI=
P in the future and whether the current mails are acceptable (despite the m=
inor description changes requested there)?<br /><br />Thanks,</p>
<p>Alex</p>

--sOqiE5ZD4geONGmun3Vx--

