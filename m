Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3312C5519F
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 16:03:55 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web08.8773.1649918024233354358
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 23:33:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=PyPxWcdO;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.45,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ed1-f45.google.com with SMTP id b24so5053487edu.10
        for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 23:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0jbeLL3Jn5oNDfmOtrDEf90udlhc5PTpnnnzfn1QU4=;
        b=PyPxWcdObd7rEEHLYYXhWPLEPvBN40wmTa/U+AmHopK1TPWispVBQeW3XUEY3UxgBg
         6a43cuwtbCLtqR0mLIvPKubSVbMR0wR59iU2sK/w8Bwlzs/9DAe1sXJOO8zvHPqbouMO
         yAUiQ6+B0qRp8DcbXanjtTkOU8eGDMfUu5HGTgouM8olkXOdXMQp3onDG1k15EUTyHLT
         WFsQGi9aX9MLFXWK86+ZMB1LGzJHWYZL2amsnjWEjaFd3uLwRQ8SzYh59s99PspgHH4A
         hL0ENz4WtYVUlcwndXmICnVwpl77zOqRfParFTXHpuinBYWEjozbi8LlPMj2ya0JD4Y3
         HGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0jbeLL3Jn5oNDfmOtrDEf90udlhc5PTpnnnzfn1QU4=;
        b=tKd8SV1RUXKVs8M1wHu5484YylKhdIDgqPwdGEYfniDqQi3CFs9RCXbAa/s93C6Jkp
         1MAZYY62QD7HN799ImqRj9y2SJnFWd1QT6phzZEa+Wxd3j2P8uI7qZ7Co80TNeSYD5KJ
         o9zBhbj0ncwPa5IQIcjOQUbgS+NWqLlvyN2W1ZXcf+s2Nwec4xoPziFuxQQRdeYUm8ym
         g/RPOkY1Z2jNHsHhEKuhC7Sa5HUc8jnA7D2TaVfIF0O9aLX4u2I7UAqf1XVGCUrkVwRt
         Dy9GFKQG/dxOoe59FhZrug1iP0hOF4IONYqtI5NvoiEZfpM0RCjSeke6JYV5S1XJRy4c
         zeWw==
X-Gm-Message-State: AOAM5317fVGQcStU/wo5iMXf4r7isgQRh8Dv5a2qdigQYrzIa/WbkPSG
	GO68RK6j1RbM0A95RsSPurdBKtDH2JuT2/J1GkLNRdSNbw==
X-Google-Smtp-Source: 
 ABdhPJwQSsPB1UzLO5M879n9Q5T451D55FzJUp4KxrgVWIKKyuI1n39ZP2O0UpESVbqFcf7mju4VWCTnZLCgeGlUkc4=
X-Received: by 2002:a05:6402:26d1:b0:41d:6b2:e5ca with SMTP id
 x17-20020a05640226d100b0041d06b2e5camr1360089edd.138.1649918022561; Wed, 13
 Apr 2022 23:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <76860af5-c727-1ca9-a572-ef505ed51aaa@siemens.com>
 <20220407090607.GA20233@duo.ucw.cz>
 <54e32f3a-cc78-2e6f-2414-9ee2e2791243@siemens.com>
In-Reply-To: <54e32f3a-cc78-2e6f-2414-9ee2e2791243@siemens.com>
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Thu, 14 Apr 2022 15:33:07 +0900
Message-ID: 
 <CANgtXuMvyv8=KB371-DY9TUuQKUsBA_pdvOq5Ec0yUUU0C+7LA@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Apr 2022 16:03:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8096

On Wed, Apr 13, 2022 at 6:12 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> Forgot to follow up on this:
>
> Are there any concerns among our participants to move this by one hour
> earlier?

Not from me.

>
> If no, the next logical question would then be:
>
> Stick with one hour earlier, or will this cause conflicts again on the
> end of DST in Autumn?
>

either works for me.

Thanks,
Alicef
-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

