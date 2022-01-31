Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7B8C433F5
	for <webhook@archiver.kernel.org>; Mon, 31 Jan 2022 00:01:34 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web09.25922.1643587291737191903
 for <cip-dev@lists.cip-project.org>;
 Sun, 30 Jan 2022 16:01:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=ThWasQG2;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.46,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f46.google.com with SMTP id
 g15-20020a9d6b0f000000b005a062b0dc12so11439365otp.4
        for <cip-dev@lists.cip-project.org>;
 Sun, 30 Jan 2022 16:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RoB9oUNu6RN+uU7d9RL8w4mbzYhsOelXUCiQ9rCI0g8=;
        b=ThWasQG29S0rWZAsq7b7TNPHdLDyFtbUYC9fBFUhIPcM4tkfHCEUYe0GJwgAlRipRu
         lcyBT4YXR5rZ8DlGVmClYhg/9AkmO7SZhKSbmaqwQRUcDGEEFEYX5S7Wif1Lafcsgn1U
         XFCknFfb549xPlWDgn4UpRjMg+l08ghCAfcUQqEYErcbDXe8Q1oyBUqLI7f0zb0W/kGm
         vHaAeY+pwcr/Agmkds6/4f+bEPkK5CLA9DzkmqGkMrVgzwWU6CxjjelqaGgQ0wAqwGY/
         7NE8GtWMKlK0xH185Z5EjxRXTO7hMryGK2oJ9XXnMyR2rua9CQAMPwRw7FacBPXBZLKC
         GXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RoB9oUNu6RN+uU7d9RL8w4mbzYhsOelXUCiQ9rCI0g8=;
        b=g9vbwPMTlmCiZeMAMUkoUHZp5lBjR/s3e151G4WG8VSerT2151buCVseJ+pFiL+jTX
         wX434Ry3spk3uusOgUJFtOOwfWi/tXLbHj3hzZuNoc7AjX3HKUtR1va6j1cbUpt93MIj
         qfExyhSPcafWDeUtYgC0eKqst5oGYmUAmWMe5N4jfibRfQGUOR9y87SJlc9KLWbLQTkf
         xWV1PmdazYs43L2tltaGNz0CopELrnLcGh9I2hQv2bTjbx4ac7KKG057Jh1vnc3uZm20
         lZM5nCxqb64pZtUTLKkpprZUHGd9JZ74bYiqvevuNjw9VCV7P5Uj7/Vkv3uzcCKvifTn
         d3sA==
X-Gm-Message-State: AOAM533DrdQXrL2S6M/aQseG0WLUZ0NOsS7KvdnDPzOXSkKfKMz9sdQs
	nSbdEtJYv6FUul7tV3i3u8KAoZHIXVIKnDBPu5B8SEkoNpSNmw==
X-Google-Smtp-Source: 
 ABdhPJxRpRjL/pslzy24G0R3eHzOHef+lzG2ByomwqT+LTjyJ9UdbYw9qiSbDfzlCy+80A5biurKUsVa+TTeI+YXu78=
X-Received: by 2002:a9d:6d13:: with SMTP id
 o19mr10372575otp.232.1643587290283;
 Sun, 30 Jan 2022 16:01:30 -0800 (PST)
MIME-Version: 1.0
References: 
 <CAODzB9oLrBx-866T7ywB4CT4o4Nvkk8WrH-X+DGzsSMt=NswGA@mail.gmail.com>
 <20220129210347.GA27693@duo.ucw.cz>
In-Reply-To: <20220129210347.GA27693@duo.ucw.cz>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Mon, 31 Jan 2022 09:00:54 +0900
Message-ID: 
 <CAODzB9rTUkKmDsLszDvci47oW5Ua7Oc-S01-w5_BYXk9ukUaSQ@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries in this week
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Jan 2022 00:01:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7520

Hi !

On Sun, Jan 30, 2022 at 6:03 AM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
> >
>
> > CVE-2022-0330: drm/i915: Flush TLBs before releasing backing store
> >
> > CVSS v3 score is not provided
> >
> > Vulnerability in the i915 driver. Without an active IOMMU malicious
> > userspace can gain access (from the
> > code executing on the GPU) to random memory pages.
> >
> > Fixed status
> >
> > mainline: [7938d61591d33394a21bdd7797a245b65428f44c]
>
> Wow. This must have been important. It looks like 5.10.95 (+4.4 and
> 4.19) was released just to get this fixed. Fix is "interesting" but...
> it should be fixed.
>

Yes. Stable kernels were fixed :)

stable/4.14: [eed39c1918f1803948d736c444bfacba2a482ad0]
stable/4.19: [b188780649081782e341e52223db47c49f172712]
stable/4.4: [db6a2082d5a2ebc5ffa41f7213a544d55f73793a]
stable/4.9: [84f4ab5b47d955ad2bb30115d7841d3e8f0994f4]
stable/5.10: [6a6acf927895c38bdd9f3cd76b8dbfc25ac03e88]
stable/5.15: [8a17a077e7e9ecce25c95dbdb27843d2d6c2f0f7]
stable/5.16: [ec1b6497a2bc0293c064337e981ea1f6cbe57930]
stable/5.4: [1b5553c79d52f17e735cd924ff2178a2409e6d0b]


> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#7517): https://lists.cip-project.org/g/cip-dev/message/7517
> Mute This Topic: https://lists.cip-project.org/mt/88710351/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129101/4520416/1465703922/xyzzy [masami.ichikawa@miraclelinux.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

