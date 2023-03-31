Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAB0C761A6
	for <webhook@archiver.kernel.org>; Fri, 31 Mar 2023 15:51:29 +0000 (UTC)
Subject: Re: [PATCH 4.4 3/3] ALSA: control: use counting semaphore as write lock for ELEM_WRITE operation
To: cip-dev@lists.cip-project.org
From: "Alexander Grund" <theflamefire89@gmail.com>
X-Originating-Location: Dresden, Saxony, DE (79.254.28.116)
X-Originating-Platform: Linux Firefox 111
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 31 Mar 2023 08:51:27 -0700
References: <TYWPR01MB942097E72E616833130EAAB292899@TYWPR01MB9420.jpnprd01.prod.outlook.com>
In-Reply-To: <TYWPR01MB942097E72E616833130EAAB292899@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Message-ID: <13330.1680277887470577775@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="WopI49LBrvQ9WdjJPv1U"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Mar 2023 15:51:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11139

--WopI49LBrvQ9WdjJPv1U
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2023 at 12:39 AM, Nobuhiro Iwamatsu wrote:

>=20
> Please add backports commit id.

Can you help me here please: What exactly should this look like?
I backported/cherry-picked this from 5bbb1ab5bd0b01c4f0b19ae03fdfec487f8395=
17 from the linux-4.14.y branch

Do I need to submit the updated patch as a new mail? If so how'd I do that,=
 e.g. with git send-mail?

--WopI49LBrvQ9WdjJPv1U
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2023 at 12:39 AM, Nobuhiro Iwamatsu wrote:<br />
<blockquote>Please add backports commit id.</blockquote>
Can you help me here please: What exactly should this look like?<br />I bac=
kported/cherry-picked this from 5bbb1ab5bd0b01c4f0b19ae03fdfec487f839517 fr=
om the linux-4.14.y branch<br /><br />Do I need to submit the updated patch=
 as a new mail? If so how'd I do that, e.g. with git send-mail?

--WopI49LBrvQ9WdjJPv1U--

