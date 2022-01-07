Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019CDC433EF
	for <webhook@archiver.kernel.org>; Fri,  7 Jan 2022 10:02:56 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web10.4800.1641549773095072154
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jan 2022 02:02:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=Vb47Kr8J;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.54,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ed1-f54.google.com with SMTP id m21so20338867edc.0
        for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jan 2022 02:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r1bpaPrwEUf7Kb32miTWFvRCog9gigwPtOj2ft6dTU4=;
        b=Vb47Kr8JwWAqkVZJLI2e+lI3/uo8syLjrnOylM1lkr7GSCcHWvSKJpB8wwdx+/wNan
         zdY1nqNgpZWe49VRbU8zqAmZILJa4trmXl2I8jo8tFd/1DkFqmcEFgb9iAWVH6TKzpH5
         Dpv8d2rHZkGoovbXEGBPkrZXIW7ll8eWMDxbc8bssurHEijh3JccjMotkgi0/1LzbfZj
         qkiFXvgimdOwt6/tYHvxznfmiRso83o9LGoVomwgfKI7Zud00R5WAfk9ZD1KhAFEdMD4
         d2weBT81vId8PBZXcECt2zQ4EOOmPJd+HBO3jhQnmXF9hjp614ddf9S5eH2R6d/KPW70
         OSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r1bpaPrwEUf7Kb32miTWFvRCog9gigwPtOj2ft6dTU4=;
        b=ylqunVe6Wd2i/iRiTVqw+PWA7PzKF0D3MNq/A36ojbGAX4Wvo85fhd5fVpU82Zd811
         V1PnNe8Ca0hUkV/06kVMjW+/9/6NQpZZhXRsd0WQhEO6B9xFn6GF6Int+tSHPXAo/Hka
         x26JQCEhB4vVTYH9RQSgVJ75JK55k4/E6kKasaVAKXZAwaV1WOG0KX2c0YHV6pfuQgRt
         76HxzE2XWQ9awzPhsKTkDdFNwN/UAShRheu+1yy1lhXDTSyEHp2S/srUxU1SHryFXV36
         uU2oXJBka9F6f7mDMD49Uo2ieH8QMbVt/dS/R0iQfByQf9C5jxcYL9+1WzW3skLhqrWS
         cJjw==
X-Gm-Message-State: AOAM533r4cMsjqcQOe9tmhtjzoaveDqnhZWmo3DrDT+eWdwG7PJA7UoA
	bpT3QmWRfeb23PfMzPzvViOxYaXF+sSRFwj0Ff5e
X-Google-Smtp-Source: 
 ABdhPJxRyLxlV8ju+fMtezze/Zd6jHTDqpUOQgRCQAFuY98J6iLyQKMnxRAcuQmk7nw67iP0GqGN+RkGgtrLUCJUXXc=
X-Received: by 2002:a17:906:974a:: with SMTP id
 o10mr48733562ejy.226.1641549771319;
 Fri, 07 Jan 2022 02:02:51 -0800 (PST)
MIME-Version: 1.0
References: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
 <20220106111614.218823-5-alice.ferrazzi@miraclelinux.com>
 <c8e9fcb9-eded-90fb-98cc-f766a7a9fbf3@siemens.com>
In-Reply-To: <c8e9fcb9-eded-90fb-98cc-f766a7a9fbf3@siemens.com>
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Fri, 7 Jan 2022 19:02:15 +0900
Message-ID: 
 <CANgtXuMOv+rJYyEMC0CgZsap0YETmAt30S5ia5x6+W+ppKKRoQ@mail.gmail.com>
Subject: Re: [isar-cip-core][PATCH 4/4] enable cip-core-image-kernelci
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jan 2022 10:02:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7338

On Thu, Jan 6, 2022 at 11:12 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 06.01.22 12:16, Alice Ferrazzi wrote:
> > enable CIP core image KernelCI to be built with gitlab pipeline
> > and uploaded to the KernelCI storage using KernelCI API.
> > enable cip-core-image-kernelci to be built for amd64, arm and arm64.
> >
> > Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > ---
> >  .gitlab-ci.yml | 40 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 39 insertions(+), 1 deletion(-)
> >
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index e7db8c1..784343b 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -9,6 +9,7 @@ variables:
> >    targz: disable
> >    dtb: none
> >    deploy: enable
> > +  deploy_kernelci: disable
> >
> >  stages:
> >    - build
> > @@ -37,7 +38,8 @@ default:
> >      - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi;
> >      - echo "Building ${base_yaml}"
> >      - kas build ${base_yaml}
> > -    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
> > +    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi;
> > +    - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
>
> Does gitlab-ci forces us to add that closing ; to the last-but-one
> command? If so, better add it to the new from the beginning.
>

I'm just following the syntax that is already there.
The gitlab-ci.yml file syntax preceding my commit is also doing same
thing of adding that closing ; to the last-but-one command.
You can check it here
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/.gitlab-ci.yml#L40

Thanks,
Alice

-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

