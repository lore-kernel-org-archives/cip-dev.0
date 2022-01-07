Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB31C433EF
	for <webhook@archiver.kernel.org>; Fri,  7 Jan 2022 10:24:32 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web10.4951.1641551062016106959
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jan 2022 02:24:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=qH/5rD0i;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.51,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ed1-f51.google.com with SMTP id bm14so20318592edb.5
        for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jan 2022 02:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sAQYEDCYwKweaFmbBM9XZlQ3Q8nTFfIsbf86UyHPVU=;
        b=qH/5rD0ieVNshqlRnt0j99t8AZIUtZoHz+a5xMIlF6tctcfrfm3c6Z4whV7uCIPP1N
         qMbk+CWb8IVOrgFTw6SizCp7PXvl50O2oDFFb48bdj9h9W6pGsBzRQNlU+TaxcqP5VnT
         bSRPnGVKlxMp10b/bVH6DsZz4x4r3PY3ANbjpQKMJktw1mOQDwRp6JTyC+SHhuXrKnkI
         OWf4ozkyRxUdXmjQsHTzboT8OxSEihQf6cz2UZxh0fxX+S/OiigGUdLQJruNMJRcCDiz
         QUP7XPA1VXQm6g+3MIBZtSOUMKgrFqDymzV0zG4eC0n6RsG1LKf7nldU6rGxh591Ye1B
         Td8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sAQYEDCYwKweaFmbBM9XZlQ3Q8nTFfIsbf86UyHPVU=;
        b=XmlT35LXYcQQOImfLuH0q98WL7X/J7Zu11Y7rIm31L9DoKYFc9c4rAKNEM1tpycCz4
         I6UAwL8DI0AoCTfuwqM/XkXZREgCA8ZknadERr7aiwYPpTonqp65MAHtqCxwnbtj2Tre
         rVm8rMSshkbzhNElUc1q98lF6caGTgI4LztBnxvoexHuRmaIInDhIAGkz08TNfafMYRM
         pENTd68nq7Je4jyGAIpkdhRlqLyIGfg6jK7sp+08z00AIFym3CXz5oaBkk2lFQMealzz
         x3+xREmik+I9UkpEk3bPKCaMR5yhb4EN8ijNVg7qtCNKuq/hTLT8iFlH3JOgSJ/3+2pe
         /K9w==
X-Gm-Message-State: AOAM530mlDLJobJXdd0aV0+4Ia6s+XcpeTRFjAm4MT73tkf3quIt9wjC
	fVqOR72QrujNH2oGANU5rdIdBpTOcgfFJe/raNQXkG+E9g==
X-Google-Smtp-Source: 
 ABdhPJz/FCkGc1VHM7KGd/B/DY0Xa70n4AQcBaUzrVBUkoihPhud6sN16r+oIYtVwEN3hmrnQSqxOQXaYE0MJVDiHw8=
X-Received: by 2002:a05:6402:524a:: with SMTP id
 t10mr62223741edd.42.1641551060593;
 Fri, 07 Jan 2022 02:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
 <20220106111614.218823-5-alice.ferrazzi@miraclelinux.com>
 <c8e9fcb9-eded-90fb-98cc-f766a7a9fbf3@siemens.com>
 <CANgtXuMOv+rJYyEMC0CgZsap0YETmAt30S5ia5x6+W+ppKKRoQ@mail.gmail.com>
 <65c523ba-cfaa-877c-e36c-1f0a6eec4602@siemens.com>
In-Reply-To: <65c523ba-cfaa-877c-e36c-1f0a6eec4602@siemens.com>
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Fri, 7 Jan 2022 19:23:44 +0900
Message-ID: 
 <CANgtXuNUWt4ez6O5pgeJid3avitUq=fiOnVQk_+opA+Q-aTf+A@mail.gmail.com>
Subject: Re: [isar-cip-core][PATCH 4/4] enable cip-core-image-kernelci
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jan 2022 10:24:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7344

On Fri, Jan 7, 2022 at 7:07 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 07.01.22 11:02, Alice Ferrazzi wrote:
> > On Thu, Jan 6, 2022 at 11:12 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 06.01.22 12:16, Alice Ferrazzi wrote:
> >>> enable CIP core image KernelCI to be built with gitlab pipeline
> >>> and uploaded to the KernelCI storage using KernelCI API.
> >>> enable cip-core-image-kernelci to be built for amd64, arm and arm64.
> >>>
> >>> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> >>> ---
> >>>  .gitlab-ci.yml | 40 +++++++++++++++++++++++++++++++++++++++-
> >>>  1 file changed, 39 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> >>> index e7db8c1..784343b 100644
> >>> --- a/.gitlab-ci.yml
> >>> +++ b/.gitlab-ci.yml
> >>> @@ -9,6 +9,7 @@ variables:
> >>>    targz: disable
> >>>    dtb: none
> >>>    deploy: enable
> >>> +  deploy_kernelci: disable
> >>>
> >>>  stages:
> >>>    - build
> >>> @@ -37,7 +38,8 @@ default:
> >>>      - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi;
> >>>      - echo "Building ${base_yaml}"
> >>>      - kas build ${base_yaml}
> >>> -    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
> >>> +    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi;
> >>> +    - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
> >>
> >> Does gitlab-ci forces us to add that closing ; to the last-but-one
> >> command? If so, better add it to the new from the beginning.
> >>
> >
> > I'm just following the syntax that is already there.
> > The gitlab-ci.yml file syntax preceding my commit is also doing same
> > thing of adding that closing ; to the last-but-one command.
> > You can check it here
> > https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/.gitlab-ci.yml#L40
> >
>
> Then, if the closing semicolon is needed, add it to the new line as well
> to avoid having to touch that when adding the next one.

sorry I'm not understanding what you want me to do.
The closing semicolon is needed to the last-but-one command.
Adding it to the last command break the script.

-- 
Thanks,
Alicef

======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

