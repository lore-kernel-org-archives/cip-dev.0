Return-Path: <johnxw@amazon.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185A0C54E58
	for <webhook@archiver.kernel.org>; Fri, 22 Mar 2024 00:24:37 +0000 (UTC)
Subject: Re: [isar-cip-core][RFC 8/8] Add example to encrypt the rootfs
To: cip-dev@lists.cip-project.org
From: "JohnW" <johnxw@amazon.com>
X-Originating-Location: Seattle, Washington, US (174.21.127.130)
X-Originating-Platform: Mac Firefox 123
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 21 Mar 2024 17:24:28 -0700
References: <c9216a86-403f-4365-9668-c8c0a89445fa@siemens.com>
In-Reply-To: <c9216a86-403f-4365-9668-c8c0a89445fa@siemens.com>
Message-ID: <5367.1711067068951668876@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="Jilotgrimi7VOliDwReD"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Mar 2024 00:24:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15395

--Jilotgrimi7VOliDwReD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thanks for sharing the example.

I'm trying to build the example and test it on my device using an USB as bo=
ot media. I am getting Secure Boot Violation error (Invalid signature detec=
ted). Is there anything that I have to do to properly set up secure boot? I=
 see that the KAS config automatically include secure boot recipes if encry=
ption is selected.

If I disable secure boot from BIOS, I got a "ERROR: Cannot probe watchdog (=
Unsupported)" error while it tries to boot.

--Jilotgrimi7VOliDwReD
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thanks for sharing the example.<br /><br />I'm trying to build the example =
and test it on my device using an USB as boot media. I am getting Secure Bo=
ot Violation error (Invalid signature detected). Is there anything that I h=
ave to do to properly set up secure boot? I see that the KAS config automat=
ically include secure boot recipes if encryption is selected. <br /><br />I=
f I disable secure boot from BIOS, I got a "ERROR: Cannot probe watchdog (U=
nsupported)" error while it tries to boot.

--Jilotgrimi7VOliDwReD--

