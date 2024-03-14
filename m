Return-Path: <johnxw@amazon.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F96C54E5D
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 18:38:51 +0000 (UTC)
Subject: Re: Full disk encryption
To: cip-dev@lists.cip-project.org
From: "JohnW" <johnxw@amazon.com>
X-Originating-Location: US (15.248.7.27)
X-Originating-Platform: Mac Firefox 123
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 14 Mar 2024 11:38:48 -0700
References: <03cd1e82-b8c2-4e41-ae87-cc38fe795840@siemens.com>
In-Reply-To: <03cd1e82-b8c2-4e41-ae87-cc38fe795840@siemens.com>
Message-ID: <17515.1710441528822094454@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="OSsv0D9vvWPXFTGgwEmj"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 18:38:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15307

--OSsv0D9vvWPXFTGgwEmj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

I currently have 2 partitions: 1 for " /boot" and 1 for " /" (exclude /boot=
). I think the boot partition is the one that cannot be encrypted. My goal =
is to encrypt the other one. Have the ability in the recipe to configure a =
default LUKS password to bind to a TPM slot (so that we can auto unlock the=
 disk during boot).

Regards,
John

--OSsv0D9vvWPXFTGgwEmj
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,<br /><br />I currently have 2 partitions: 1 for "<em>/boot"</em> an=
d 1 for "<em>/"</em> (exclude /boot). I think the boot partition is the one=
 that cannot be encrypted. My goal is to encrypt the other one. Have the ab=
ility in the recipe to configure a default LUKS password to bind to a TPM s=
lot (so that we can auto unlock the disk during boot). <br /><br />Regards,=
<br />John

--OSsv0D9vvWPXFTGgwEmj--

