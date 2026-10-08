Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DEBCA6007
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 10:22:06 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12133.1791454924408009128
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Oct 2026 03:22:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=@fpond.eu header.s=strato-dkim-0002 header.b=G4eA0eRt;
 dkim=fail reason="dkim: signature did not verify: dkim: invalid Ed25519 signature" header.i=@fpond.eu header.s=strato-dkim-0003 header.b=281C+y3d;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.164, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1791454899; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZAPWQXHmQORuD3d2u029cRbwwt7N/Wk2dZE0lICCV4aPF8o7+Q+2BoGNo1x8qx/j7D
    Qx05blbj43vpqz/4jTTSDklTWC3qqrpW1ZjVDqTylqf5f3Tbeso02Xi2156ZmgOXwUAf
    u0HxOYh/ZQaqn8JyICmkvtwDvhPfL93nwbJ2TXUv/jxpPWIX6uiKTCYoif438JNY+lpB
    v+Hc0fMuDG29fYcFmHItFraBHoXa2Ow1rNqm9t8F4TS+ivUYRWWEKCGEshrzE54Jm7zC
    R8GKxXva2SHDzk10SeONqmoGCPvQq8Tq1ZJvTDcI/nm9f9poCiWiX4zq4lGFqPV3qhtG
    W68g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791454899;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=In1qHKp8oCuQd5ToeJHV2zSRvpjH5e4wwnFZSt2gLF0=;
    b=jBPOIgRhP2U0uRyk9940+ZdHbKC/b9NPHdXrssIgdeVJBriM8EeHvWX4L47FWPQSgv
    EYZVPjshWN4e+rmkP3w1k/tK+Jn0xxMTriV1/M7lSy+9YygB9SGMyb6yhRymz+BLppJg
    QQymJv+VOZxQhx+vT3A5w6A0WAXB9pvsYFXmmTOTxgZytJFHjaPFccOH7qeHc7yXD9Tu
    +BKoiYc9kjLhfvPH6j81Kd9KHWtZyK50Ry5COOEkkeAu1ZIL77cKseUfqtZ2qqWxMinN
    DA03J12GJdH5/KeDfCnwnU6mNnRAjKB9q6vKo9KWH9VLrKV2tFugE6o2Wt3rue1H8KKN
    b0zQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791454899;
    s=strato-dkim-0002; d=fpond.eu;
    h=Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=In1qHKp8oCuQd5ToeJHV2zSRvpjH5e4wwnFZSt2gLF0=;
    b=G4eA0eRtV3O4jvmBrt2XT7XR5ObDX0RluBBliWbjYuQDEvt7VPgciznMjObMKEuRU9
    IZyZQAia4+2bRTYwGQULS7UmOrSHjC16nqaqei9brMK/xPTgY3EvTatZ45GYoRt7aEHo
    x4g5oAR06GVEZ+R/u+JSpzh5sIG0hREUT/zBGvLwKpAWotVxtAw0uc3VNVc3bXICWoww
    MatBLHLty5zPOvF7l0WpdZz9srUAhgoKflJPBrsGVa1h+/VTo1iP9DFyaottB5cTP7Ic
    W26Ky6MJEu7Aq/yCyeBa7tipRSypMkDgDYeGCKK5bzAaAZhRi5GcfEqYLedHqbULBwJk
    sV9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791454899;
    s=strato-dkim-0003; d=fpond.eu;
    h=Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=In1qHKp8oCuQd5ToeJHV2zSRvpjH5e4wwnFZSt2gLF0=;
    b=281C+y3d2TXJUG5VHWR5tKho69cLsV9eJ9qRLyu4Ar6IJEaQHaqSfotj8wUhBkhDQZ
    NIifZiygXjxDqQ5+2zDQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73dmm4I5W0/AvB7rMQA6gxtqV2JmsF"
Received: from ehlo.thunderbird.net
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id z041b2298ALcipT
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 8 Oct 2026 12:21:38 +0200 (CEST)
Date: Thu, 08 Oct 2026 12:21:37 +0200
From: Ulrich Hecht <uli@fpond.eu>
To: jan.kiszka@siemens.com,
 "Jan Kiszka via lists.cip-project.org" <jan.kiszka=siemens.com@lists.cip-project.org>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Pavel Machek <pavel@nabladev.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Arisu Tachibana <arisu.tachibana@miraclelinux.com>,
 Masami Ichikawa <masami.ichikawa@miraclelinux.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP kernel lunch
User-Agent: Thunderbird for Android
In-Reply-To: <a473fa93-b5d3-49a9-98b8-f1cdf6a86ee5@siemens.com>
References: <06640825-6f58-484e-b9e5-5e5349938fd0@siemens.com> <a473fa93-b5d3-49a9-98b8-f1cdf6a86ee5@siemens.com>
Message-ID: <2C2DAC8B-A0F7-4989-BFEB-84C32F4FCD2A@fpond.eu>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary=----LUAF48FEMR7C54CY7RHHWPYW9NLKYR
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Oct 2026 10:22:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24438

------LUAF48FEMR7C54CY7RHHWPYW9NLKYR
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

I'm at the booth=2E

On 8 October 2026 11:23:16 CEST, "Jan Kiszka via lists=2Ecip-project=2Eorg=
" <jan=2Ekiszka=3Dsiemens=2Ecom@lists=2Ecip-project=2Eorg> wrote:
>On 29=2E09=2E26 13:53, Jan Kiszka wrote:
>> Hi all, CIP kernel WG members and beyond,
>>=20
>> if your are attending OSS Prague: How about having lunch together on
>> Thursday (Oct 8, 12:20) and chatting about CIP kernel topics a this cha=
nce?
>>=20
>
>Just a reminder that we are meeting today for lunch=2E
>
>At the same time a clarification that there won't be an IRC meeting
>today=2E We will be back to regular schedule next week again=2E
>
>See you,
>Jan
>
>--=20
>Siemens AG, Foundational Technologies
>Linux Expert Center

------LUAF48FEMR7C54CY7RHHWPYW9NLKYR
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div dir=3D"auto">I'm at the booth=2E</div><br><br=
><div class=3D"gmail_quote"><div dir=3D"auto">On 8 October 2026 11:23:16 CE=
ST, "Jan Kiszka via lists=2Ecip-project=2Eorg" &lt;jan=2Ekiszka=3Dsiemens=
=2Ecom@lists=2Ecip-project=2Eorg&gt; wrote:</div><blockquote class=3D"gmail=
_quote" style=3D"margin: 0pt 0pt 0pt 0=2E8ex; border-left: 1px solid rgb(20=
4, 204, 204); padding-left: 1ex;">
<pre class=3D"net-thunderbird-android__plain-text-message-pre"><div dir=3D=
"auto">On 29=2E09=2E26 13:53, Jan Kiszka wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin-bottom: 1ex; --net-thunderbird-android__bl=
ockquote-default-border-color: #729fcf;"><div dir=3D"auto">Hi all, CIP kern=
el WG members and beyond,<br><br>if your are attending OSS Prague: How abou=
t having lunch together on<br>Thursday (Oct 8, 12:20) and chatting about CI=
P kernel topics a this chance?<br><br></div></blockquote><div dir=3D"auto">=
<br>Just a reminder that we are meeting today for lunch=2E<br><br>At the sa=
me time a clarification that there won't be an IRC meeting<br>today=2E We w=
ill be back to regular schedule next week again=2E<br><br>See you,<br>Jan<b=
r><br></div></pre></blockquote></div></body></html>
------LUAF48FEMR7C54CY7RHHWPYW9NLKYR--

