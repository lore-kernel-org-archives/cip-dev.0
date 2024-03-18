Return-Path: <wq.wang@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BFEC54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 11:51:44 +0000 (UTC)
Subject: Re: [isar-cip-core][RFC v1 4/6] Add Delta update support with rdiff_image and delta handler
To: cip-dev@lists.cip-project.org
From: "Wang, Qi" <wq.wang@siemens.com>
X-Originating-Location: CN (120.136.21.80)
X-Originating-Platform: Windows Chrome 122
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 18 Mar 2024 04:51:35 -0700
References: <20240307074612.1996609-5-Adithya.Balakumar@toshiba-tsip.com>
In-Reply-To: <20240307074612.1996609-5-Adithya.Balakumar@toshiba-tsip.com>
Message-ID: <12640.1710762695350873490@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="0dR4BFrLgRhebLuHoUnc"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 11:51:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15350

--0dR4BFrLgRhebLuHoUnc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

using fixed URL for downloading zchunk file might not be a good idea, e.g. =
user might not know the IP address / domain of the webserver when generatin=
g the delta image.
one possible way is to change the configuration of delta update handler, to=
 support relative url (or other parameters), and combine the url when downl=
oading.

--0dR4BFrLgRhebLuHoUnc
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

using fixed URL for downloading zchunk file might not be a good idea, e.g. =
user might not know the IP address / domain of the webserver when generatin=
g the delta image.<br />one possible way is to change the configuration of =
delta update handler, to support relative url (or other parameters), and co=
mbine the url when downloading.

--0dR4BFrLgRhebLuHoUnc--

