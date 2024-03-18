Return-Path: <wq.wang@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDBDC54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 11:45:14 +0000 (UTC)
Subject: Re: [isar-cip-core][RFC v1 4/6] Add Delta update support with rdiff_image and delta handler
To: cip-dev@lists.cip-project.org
From: "Wang, Qi" <wq.wang@siemens.com>
X-Originating-Location: CN (120.136.21.80)
X-Originating-Platform: Windows Chrome 122
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 18 Mar 2024 04:45:05 -0700
References: <20240307074612.1996609-5-Adithya.Balakumar@toshiba-tsip.com>
In-Reply-To: <20240307074612.1996609-5-Adithya.Balakumar@toshiba-tsip.com>
Message-ID: <30877.1710762305388883203@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="41MljYqD49E5aLmgPwhz"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 11:45:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15348

--41MljYqD49E5aLmgPwhz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

One suggestion for rdiff delta update:
It should be more resource efficient to create delta image from the=C2=A0rd=
iff signature of old image, instead of from the whole old image file.
So that user doesn't need to save the whole old image file, just need to sa=
ve the small signature file.
At least we can provide this option for user to choose.

--41MljYqD49E5aLmgPwhz
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

One suggestion for rdiff delta update:<br />It should be more resource effi=
cient to create delta image from the&nbsp;rdiff signature of old image, ins=
tead of from the whole old image file.&nbsp;<br />So that user doesn't need=
 to save the whole old image file, just need to save the small signature fi=
le.<br />At least we can provide this option for user to choose.

--41MljYqD49E5aLmgPwhz--

