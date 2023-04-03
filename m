Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525E4C77B6C
	for <webhook@archiver.kernel.org>; Mon,  3 Apr 2023 17:13:16 +0000 (UTC)
Subject: Re: [PATCH 4.4 3/3] ALSA: control: use counting semaphore as write lock for ELEM_WRITE operation
To: cip-dev@lists.cip-project.org
From: "Alexander Grund" <theflamefire89@gmail.com>
X-Originating-Location: Dresden, Saxony, DE (79.254.25.230)
X-Originating-Platform: Linux Firefox 111
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 03 Apr 2023 10:13:06 -0700
References: <913352448.1492969.1680512218678@webmail.strato.com>
In-Reply-To: <913352448.1492969.1680512218678@webmail.strato.com>
Message-ID: <6415.1680541986353766715@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="I1ENuNLUWcoqS1lXGrt0"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Apr 2023 17:13:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11159

--I1ENuNLUWcoqS1lXGrt0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>=20
> Please add backports commit id.

I would have added this below the first line (after an empty line):
>=20
> commit 5bbb1ab5bd0b01c4f0b19ae03fdfec487f839517 upstream.

Would that have been correct? Or would something else have been required in=
 addition?

>=20
>=20
>=20
> Normally, even for small changes, you would re-format the whole series
> with "git format-patch --cover-letter --subject-prefix 'PATCH v2'" and
> send it all again with git send-mail, adding a note to the cover letter o=
n
> what has changed in this revision.
>=20
>=20

So it isn't a problem that this opens a new (series of) threads instead of =
replying to the mails requesting the changes, is it?

I use `git send-email` directly (I have set sendemail.annotate=3Dtrue & sen=
demail.confirm=3Dalways), so my command would have looked like this: `git s=
end-email --cover-letter --subject-prefix=3D"PATCH v2" --suppress-cc=3Dall=
=C2=A0 --to=3Dcip-dev@lists.cip-project.org cip/linux-4.4.y-st..fix-alsa` w=
hich is basically how I created the current 4 mails.

I'm wondering if this is correct, especially as I used the prefix "PATCH 4.=
4" before to denote that it is meant for the 4.4.y branch. This doesn't see=
m to be required, so what should I use as the prefix instead for a (future)=
 patch/patch series?

Anyway I noticed you already applied the commits fixing the mentioned issue=
s before tagging, thanks!

I'd still appreciate a reply or a link to a page answering those question i=
f one already exists, so the process can be smoother next time.
Thanks a lot!

--I1ENuNLUWcoqS1lXGrt0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<br />
<blockquote>Please add backports commit id.</blockquote>
I would have added this below the first line (after an empty line):
<blockquote>commit 5bbb1ab5bd0b01c4f0b19ae03fdfec487f839517 upstream.</bloc=
kquote>
<p>Would that have been correct? Or would something else have been required=
 in addition?</p>
<br />
<blockquote>
<p>Normally, even for small changes, you would re-format the whole series w=
ith "git format-patch --cover-letter --subject-prefix 'PATCH v2'" and send =
it all again with git send-mail, adding a note to the cover letter on what =
has changed in this revision.</p>
</blockquote>
<p>So it isn't a problem that this opens a new (series of) threads instead =
of replying to the mails requesting the changes, is it?</p>
<p>I use `git send-email` directly (I have set sendemail.annotate=3Dtrue &a=
mp; sendemail.confirm=3Dalways), so my command would have looked like this:=
 `git send-email --cover-letter --subject-prefix=3D"PATCH v2" --suppress-cc=
=3Dall&nbsp; --to=3Dcip-dev@lists.cip-project.org cip/linux-4.4.y-st..fix-a=
lsa` which is basically how I created the current 4 mails.</p>
<p>I'm wondering if this is correct, especially as I used the prefix "PATCH=
 4.4" before to denote that it is meant for the 4.4.y branch. This doesn't =
seem to be required, so what should I use as the prefix instead for a (futu=
re) patch/patch series?<br /><br />Anyway I noticed you already applied the=
 commits fixing the mentioned issues before tagging, thanks!</p>
<p>I'd still appreciate a reply or a link to a page answering those questio=
n if one already exists, so the process can be smoother next time.<br />Tha=
nks a lot!</p>

--I1ENuNLUWcoqS1lXGrt0--

