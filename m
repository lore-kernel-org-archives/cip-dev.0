Return-Path: <johnxw@amazon.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA97C27C52
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 22:49:46 +0000 (UTC)
Subject: Re: Adding swap space to the encrypted partition
To: cip-dev@lists.cip-project.org
From: "JohnW" <johnxw@amazon.com>
X-Originating-Location: Puyallup, Washington, US (174.21.53.213)
X-Originating-Platform: Mac Firefox 126
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 06 Jun 2024 15:49:42 -0700
References: <35bd7c87-c345-4d45-8053-27c0cafe489d@siemens.com>
In-Reply-To: <35bd7c87-c345-4d45-8053-27c0cafe489d@siemens.com>
Message-ID: <7313.1717714182247115411@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="Q6YeFaClPD5YHEVeTlru"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jun 2024 22:49:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16131

--Q6YeFaClPD5YHEVeTlru
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Quirin,

I attempted to add a swap space within the wks file. However it created a s=
wap space outside the encrypted partition.

We have devices that does not have large RAM where the swap space is needed=
 to keep things running, so it is necessary for us to include a swap space =
within our partition.

Regards,
John

--Q6YeFaClPD5YHEVeTlru
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Quirin,<br /><br />I attempted to add a swap space within the wks file. =
However it created a swap space outside the encrypted partition.<br /><br /=
>We have devices that does not have large RAM where the swap space is neede=
d to keep things running, so it is necessary for us to include a swap space=
 within our partition. <br /><br />Regards,<br />John

--Q6YeFaClPD5YHEVeTlru--

