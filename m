Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C033C433F5
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 01:55:30 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 by mx.groups.io with SMTP id smtpd.web11.4917.1646877328452451631
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Mar 2022 17:55:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=Y2UN9Tzi;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.41,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f41.google.com with SMTP id
 j7-20020a4ad6c7000000b0031c690e4123so5056488oot.11
        for <cip-dev@lists.cip-project.org>;
 Wed, 09 Mar 2022 17:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tsgyARvf18vWUJuyigdX7Y6JueFzSeAaV+IobRuq7Sk=;
        b=Y2UN9Tzim1Cxueykm8bVBY3Z79ODy3zr0a4saxB7meECCxuUEqAkNAVdALm5JyTiVW
         ftMhutoi5WKtjjfOEuALtUFpoMiuO16hYVycdczbAkyCqPSEZnIjZTKbskZ09xycj1LP
         7VeupB252JpFpmrM6QQvaVV3uqpqO6ioN9ItduURKGir/4vB8JmSp/MY/Dyy2fzGEWUu
         sTq25Vzym4iNRXF416PEwv906z2Gz0psPNd1LaxtKmWc7BDtA5NHrj0rOBPwQf+ihl78
         P623V3dduN5zjxVQKpXyENFA5GWKKkr1DYAQ+Pz9QLWItn7ozGJaXTsHUfU3prMVjial
         qUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tsgyARvf18vWUJuyigdX7Y6JueFzSeAaV+IobRuq7Sk=;
        b=keI2HNlvem7gSGfwry8OGelPbLtSX+z/vAYWvkAjaWAYy6YgYBdCelYZa/VWBpoupR
         8IJ6BZ4iyTGDYnlzKxb/hUSpJv21i+MfTyUkeBc0FI1aZ7h1Y7BnGvYz1q3wta8eLNnY
         SLnKPWU4whu5gHt+fycQ7x5f0lYxCD+RdAqmSPWLeGNuYIiaQWpZVItCRhSw4gURb97G
         wr2NMvXx0xiuZ4dSlk8mtVDIy+NT/suY97nDHtjQ+e1rGIAeqkaGgMfxu9CIGNWF/4JD
         bLMYAUPy4+1W+r6QfK/zpwgaGOQHMT65iiVJEIfsMHD6qHCAUC4W3P6OraCVmEOW2vyq
         jU+g==
X-Gm-Message-State: AOAM530WjETmvzGDPHBh5kjMdo1E+su5qj7WmNA1xLGCoVxEdpcnr7yG
	UvAJd3ABzqsD/Sx1zVtflEvkOM2z4Sh7dDomN0Ck+g==
X-Google-Smtp-Source: 
 ABdhPJzFm2+h8Q0TeAZ7mbJzG9BHo1qQAJ5c4cNqXOUTHKoWy861+xF7Z8TeoZ1VDP0StQ3NcBnZKmRxZbnTO50jc3I=
X-Received: by 2002:a05:6870:e254:b0:da:33a5:53bb with SMTP id
 d20-20020a056870e25400b000da33a553bbmr1408752oac.299.1646877327652; Wed, 09
 Mar 2022 17:55:27 -0800 (PST)
MIME-Version: 1.0
References: <20220309213716.GA9983@duo.ucw.cz>
In-Reply-To: <20220309213716.GA9983@duo.ucw.cz>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 10 Mar 2022 10:54:51 +0900
Message-ID: 
 <CAODzB9o6wFepMjL+AT+JRvO_52+xwn2=kv51JO6izVdKUZ_K=g@mail.gmail.com>
Subject: Re: Fun ahead -- speculation problems being patched in 5.10.105
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Mar 2022 01:55:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7686

HI !

On Thu, Mar 10, 2022 at 6:37 AM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> It looks like 5.10.105 will be "fun" release. There's big series of
> arm64 related speculation tweaks, including
>
>  |61f85b56f 558c30 o: 5.10| arm64: Mitigate spectre style branch history side channels
>
> And apparently there are some problems on x86-64 side, too:
>
>  |d185aa3cb e9b601 .: 5.10| x86/speculation: Update link to AMD speculation whitepaper
>  |edc29f23a eafd98 o: 5.10| x86/speculation: Warn about Spectre v2 LFENCE mitigation
>  |67997c824 0de05d o: 5.10| x86/speculation: Warn about eIBRS + LFENCE + Unprivileged eBPF + SMT
>
> We have seen worse stuff for a hardware bug mitigation before. Scary
> thing here is that arm64 patches are queued against 5.10 but not 4.19
> or earlier.
>
> Let me reiterate again that using complex out-of-order CPU is a bad
> idea if you care about security.
>
> Let me reiterate that JITs such as eBPF are complex/dangerous and
> especially unpriviledged eBPF is risky.
>

That's true. We saw lots of CVEs which recommended disabling unprivileged eBPF.
It is difficult to achieve both safety and usefulness :(

> v |316f1dd5e 44a391 o: 5.10| x86/speculation: Include unprivileged eBPF status in Spectre v2 mitigation reporting
>
> Best regards,
>                                                                 Pavel
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

