Return-Path: <d.kauschke154@googlemail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF64E77183
	for <webhook@archiver.kernel.org>; Thu, 12 Dec 2024 07:44:09 +0000 (UTC)
Subject: Re: [isar-cip-core][PATCH] initramfs-overlay-hook: Fix copy_exec input
To: cip-dev@lists.cip-project.org
From: d.kauschke154@googlemail.com
X-Originating-Location: Planegg, Bavaria, DE (145.253.133.129)
X-Originating-Platform: Linux Firefox 131
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 11 Dec 2024 23:44:08 -0800
References: <638b9f92-37be-4d7f-b64b-e95fc85da037@siemens.com>
In-Reply-To: <638b9f92-37be-4d7f-b64b-e95fc85da037@siemens.com>
Message-ID: <7374.1733989448108647982@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="RbSXcBGF8lFkojaZixpf"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Dec 2024 07:44:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17411

--RbSXcBGF8lFkojaZixpf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,
I encountered the same issue with the initramfs-overlay-hook.
I tested your patch successfully on the qemu-arm64 machine.

Thanks for the fix!

David

--RbSXcBGF8lFkojaZixpf
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>
<div>Hi Jan,</div>
<div>I encountered the same issue with the initramfs-overlay-hook.<br />I t=
ested your patch successfully on the qemu-arm64 machine.</div>
<div>&nbsp;</div>
<div>Thanks for the fix!</div>
<div>&nbsp;</div>
<div>David</div>
</div>

--RbSXcBGF8lFkojaZixpf--

