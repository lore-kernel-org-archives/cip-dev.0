Return-Path: <david.kauschke.ext@zeiss.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D93CA1016
	for <webhook@archiver.kernel.org>; Mon,  8 Sep 2025 07:50:02 +0000 (UTC)
Subject: Re: [isar-cip-core][QUESTION] initramfs-overlay-hook: tmpFS for overlay storage
To: cip-dev@lists.cip-project.org
From: david.kauschke.ext@zeiss.com
X-Originating-Location: Munich, Bavaria, DE (188.195.217.206)
X-Originating-Platform: Linux Firefox 142
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 08 Sep 2025 00:49:54 -0700
References: <b844bdcbffd7352de6dc18e9a3ee1368fcd26177.camel@siemens.com>
In-Reply-To: <b844bdcbffd7352de6dc18e9a3ee1368fcd26177.camel@siemens.com>
Message-ID: <1657.1757317794982820595@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="pjR714jLrK4S9pfXEpXP"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Sep 2025 07:50:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20020

--pjR714jLrK4S9pfXEpXP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your help Alexander, Jan and Quirin!

Topic can be closed.

After discussion and your informations, I plan to switch to this approach:

1) Use /var as the overlay storage path and encrypt the /var partition.
2) Symlink /home to /var/home, so the only persistent partition is /var (fo=
llowing the move-homedir-var recipe).

This way, there=E2=80=99s no major divergence from the upstream CIP layer, =
while the encrypted /var partition addresses the security concerns.

David

--pjR714jLrK4S9pfXEpXP
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Thank you for your help Alexander, Jan and Quirin!</div>
<div>&nbsp;</div>
<div>Topic can be closed.</div>
<div>&nbsp;</div>
<div>After discussion and your informations, I plan to switch to this appro=
ach:</div>
<div>&nbsp;</div>
<div>1) Use /var as the overlay storage path and encrypt the /var partition=
.</div>
<div>2) Symlink /home to /var/home, so the only persistent partition is /va=
r (following the move-homedir-var recipe).</div>
<div>&nbsp;</div>
<div>This way, there&rsquo;s no major divergence from the upstream CIP laye=
r, while the encrypted /var partition addresses the security concerns.</div=
>
<div>&nbsp;</div>
<div>David</div>

--pjR714jLrK4S9pfXEpXP--

