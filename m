Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13536CD98C6
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 06:34:29 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39602.1781159661519808744
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Jun 2026 23:34:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=y66IIWoG;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.172, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7defee656dcso52713587b3.0
        for <cip-dev@lists.cip-project.org>; Wed, 10 Jun 2026 23:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781159660; cv=none;
        d=google.com; s=arc-20240605;
        b=gVaNKuG4EHqd8yO8XdvgNaqgEvLDK17ZzF5tCfeVBFWH532HJ87Pi2yMussXGkMZl4
         jgP64U6RaX+BAzVKEbgk9rj0GYckUdiITdJHJ2fbqk9P7wXeXHVg4ViRvgKY9HAdUzaU
         KmKykescbe/cVUAKKrHKoIhKp/41RsnvT9l+UvP+WMXuqrt2MXai0N/Wn8UAZ5Bxdwfx
         Fh+D9VMQv8OhYox+IKflZN1ZEktX5BtpgY4Pp1YsY7RBGSso2syC8rLqRbnQpHCaeQiQ
         /6Wa3jEj9CYhLtZ7BxDty0jZsHEElkcheKlJzZBl1dzq7vqvqlQFK3XnLvemjvYSi0cC
         0+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f5+CdZgC31U+PYbdAYSyCDbx005+nK5lopbpbp8ji00=;
        fh=TKnUO5H0/SHOG5E2xt2hiOHSMeYkP2viblmO0veQLUg=;
        b=lW/NsVjlqVlc01wlHNBwBvAxxklLumvc6OOOoMC2DKw8cdsaAYJVFNDSIK53dTCawl
         navhXKlgpY2tWzRtY/4sA3WaDMygwMyPpfz3zxJ6X7WeZ4teIZj+UifAZ1357Pfa5fic
         ysfAIxk1Gdpot8Uxrc2s/ktVw0vCEHfzw+jp/pbbcN6U2Jtr8Q7+a0pqS364wt4/YJXG
         c77n02ibONY0GbBA3/mxLGJ09qU/YiORtSrGJmRYkF5XnhIyhpm3SVUihJTvGNHNGcE5
         HOlm2ggo1BsAG+uNhYhOITd6e1IHEoSW5kycMt+Soa4okqKFM+1MkkIxUgATWMNMng8w
         fJiA==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1781159660; x=1781764460; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5+CdZgC31U+PYbdAYSyCDbx005+nK5lopbpbp8ji00=;
        b=y66IIWoGIJbG4VeYGx+qXIVwjrG8jtNzE7qDxWWeMzsLk/shOYGd22JidEGNot7TLx
         HX/RMtOavGDe3r6WIwH92A5caSzQXOg+dszTt69phwvEf9PzJnrsowh/ejwK0lxCwpfu
         9vgY6Na/n0rzKnUypRaCiATOKFMYxTeCxDsDHYZB5ZxeE5qtaZ9oiSzXJSGwbs0vLrI9
         fc2I2aDuqv92AF+/6QIeaECfJ8f74d+OJLBmfIurBt8RBKJ5ReQj1DxXS36o7RRe6ycs
         eitNHFwHrmr0APoEIMCg9IiyJaQ+BcCywe5gV9Dqmty2yck4YpGdSJYQqIEkgvoOj8Wy
         MYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781159660; x=1781764460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f5+CdZgC31U+PYbdAYSyCDbx005+nK5lopbpbp8ji00=;
        b=c9w04VAPl9zuwdr1mt2iJ2voQEP7wyYeAwnbPTJTifSYMFyTHFj7TdIeOWYYkvKFHo
         MbriSv2Bc4HYuptYQ5LwoufyZ2wLUotrKgbl0AvvroHS3v/VdI1uhQAaM0SzGHksW9A1
         dtyX+7faAJMQMbvoUKI7DYPMMXIAXXhlPXO10t9WKCtL52lM0hyQdckc9xCicAi4YR16
         u1fOU/RCmkA/MebSWf1ApOwNwEoVlcNDzDebIzdB53B/kFGoKBuVN4Xw8jb3ikkZ6GAA
         2P2jFO+5baTKyFRUutti0EM5swVFXMkzgkmKWaix5ShqFzFlicYgbfVb5ufDBc1iL4Gm
         JwTg==
X-Gm-Message-State: AOJu0YxoG3d5kS1oq3ipti+zhTHW2E5XJG/d9IpzEVtbXuuQtMXgk9+4
	poNe77ApbRWpLK6fKTf4U3GevgyNyAuPTGXDTi9zRNv9h0dNCsvbuq3NYhTXPyqmBx1cFWvSKAC
	TOwxzckiV9HZqhOW53NLGkidJSvSsdQWyav6ibJ3/dg==
X-Gm-Gg: Acq92OGIhxAmK80f+SsK9q9d2B6bJzkLHDTBeJZznaJ5ZrzlzIuH8exGN9lzUagSwIt
	eVTOZxb8ZmQnfGNB39osglg3nJ8a/30cNfldfmql7+si4/wOuiB7yyK13Kj4630koez0w3aX6A/
	nDpBIunYViuEexTkfiVysNvqZgwcLO4husvzRomsuPpznUR9/+VpZQWMiFwljWlwQLOc1fEkm69
	s5me7w0hG1BK1SA+/QfXgxzcj0XPSSOzJoMhWDz6w3Hil68Ix1gYUNCSn4jf8iJ0wj1YmkQjiwk
	/kKQtcURRniEsUz6tSI=
X-Received: by 2002:a05:690c:710a:b0:7bd:7d69:764b with SMTP id
 00721157ae682-7f658705f5cmr14383727b3.39.1781159660516; Wed, 10 Jun 2026
 23:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <7baa2d90-e789-468c-a14c-cf7cd26c129b@siemens.com>
In-Reply-To: <7baa2d90-e789-468c-a14c-cf7cd26c129b@siemens.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 11 Jun 2026 15:33:44 +0900
X-Gm-Features: AVVi8Cd5ZBFpSPhlOwiCYIfOu-lFaUKQm6SoawD-PLYzAH5TKzJ1pEUwo9MV6xk
Message-ID: <CAODzB9oh9rh=CLqucjMi-a_mw8edsBAvtx7ZQjREOX3E+teXRg@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: jan.kiszka@siemens.com
Cc: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 06:34:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23059

Hi.

I'll be absent today.

On Thu, Jun 11, 2026 at 3:01=E2=80=AFPM Jan Kiszka via lists.cip-project.or=
g
<jan.kiszka=3Dsiemens.com@lists.cip-project.org> wrote:
>
> Hi all,
>
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
>
>     irc:irc.libera.chat:6697/cip
>
> The IRC meeting is scheduled to UTC (GMT) 12:00:
>
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2026&mo=
nth=3D6&day=3D11&hour=3D12&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D=
37&p5=3D241&p6=3D248
>
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     13:00     14:00     20:00     21:00
>
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/06/cip.2026-06-04=
-12.01.log.html
>
> * Action items
> * Kernel maintenance updates
> * Kernel release status [*]
> * Kernel testing
> * AOB
>    - AI-assisted backport reviews, continue discussion
>
> Jan
>
> [*]
> Date the data is created: Thu Jun 11 06:00:40 AM UTC 2026
> linux-4.4.y-cip: interval 30 day
>   latest version release date: Tue May 19 02:53:20 PM UTC 2026
>   limit date: Thu Jun 18 02:53:20 PM UTC 2026
>   Status: On track
> linux-4.4.y-cip-rt: interval 60 day
>   latest version release date: Mon May 25 11:40:18 AM UTC 2026
>   limit date: Fri Jul 24 11:40:18 AM UTC 2026
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version release date: Thu May 28 07:36:48 AM UTC 2026
>   limit date: Sat Jun 27 07:36:48 AM UTC 2026
>   Status: On track
> linux-4.19.y-cip-rt: interval 60 day
>   latest version release date: Tue May 12 11:56:37 AM UTC 2026
>   limit date: Sat Jul 11 11:56:37 AM UTC 2026
>   Status: On track
> linux-5.10.y-cip: interval 30 day
>   latest version release date: Fri May 15 10:25:33 PM UTC 2026
>   limit date: Sun Jun 14 10:25:33 PM UTC 2026
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version release date: Mon May  4 10:49:51 AM UTC 2026
>   limit date: Fri Jul  3 10:49:51 AM UTC 2026
>   Status: On track
> linux-6.1.y-cip: interval 30 day
>   latest version release date: Fri May 15 10:28:23 PM UTC 2026
>   limit date: Sun Jun 14 10:28:23 PM UTC 2026
>   Status: On track
> linux-6.1.y-cip-rt: interval 60 day
>   latest version release date: Mon Apr 13 11:43:31 AM UTC 2026
>   limit date: Fri Jun 12 11:43:31 AM UTC 2026
>   Status: On track
> linux-6.12.y-cip: interval 15 day
>   latest version release date: Tue Jun  9 12:04:00 AM UTC 2026
>   limit date: Wed Jun 24 12:04:00 AM UTC 2026
>   Status: On track
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#23058): https://lists.cip-project.org/g/cip-dev/messa=
ge/23058
> Mute This Topic: https://lists.cip-project.org/mt/119752865/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [masami.ichika=
wa@miraclelinux.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

