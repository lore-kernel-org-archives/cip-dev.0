Return-Path: <vadym.haidamaka@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BC4C61DA4
	for <webhook@archiver.kernel.org>; Fri,  3 Feb 2023 18:16:51 +0000 (UTC)
Subject: Re: 4.9 SLTS support
To: cip-dev@lists.cip-project.org
From: vadym.haidamaka@gmail.com
X-Originating-Location: US (145.224.105.157)
X-Originating-Platform: Linux Chrome 109
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 03 Feb 2023 10:16:42 -0800
References: <TYCPR01MB10588D0EFCE97911D45387F55B7D19@TYCPR01MB10588.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB10588D0EFCE97911D45387F55B7D19@TYCPR01MB10588.jpnprd01.prod.outlook.com>
Message-ID: <23585.1675448202773788237@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="2HXyvmjlNKBL3k6jHN4s"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Feb 2023 18:16:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10588

--2HXyvmjlNKBL3k6jHN4s
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

Thanks for the clarification. I understand that maintaining a lot of old LT=
S Linux kernels requires huge resources. At the moment, we don't have enoug=
h expertise to be a kernel maintainer.
Just wondering, maybe you need help with Python, Go, or CI/CD in the CIP pr=
oject?

> If you have time, I'd be interested to hear more about your use case for =
continuing to use v4.9.

We are checking if it's possible to use one of the Simcom communication mod=
ules, but only Linux 4.9 is supported for now. From a security point of vie=
w, it's not good to use or rely on components that are not maintained.

Vadym Haidamaka

--2HXyvmjlNKBL3k6jHN4s
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hello Chris,</div>
<div>&nbsp;</div>
<div>Thanks for the clarification. I understand that maintaining a lot of o=
ld LTS Linux kernels requires huge resources. At the moment, we don't have =
enough expertise to be a kernel maintainer.</div>
<div>Just wondering, maybe you need help with Python, Go, or CI/CD in the C=
IP project?</div>
<div>&nbsp;</div>
<div>&gt; If you have time, I'd be interested to hear more about your use c=
ase for continuing to use v4.9.</div>
<div>&nbsp;</div>
<div>We are checking if it's possible to use one of the Simcom communicatio=
n modules, but only Linux 4.9 is supported for now. From a security point o=
f view, it's not good to use or rely on components that are not maintained.=
</div>
<div>&nbsp;</div>
Vadym Haidamaka

--2HXyvmjlNKBL3k6jHN4s--

