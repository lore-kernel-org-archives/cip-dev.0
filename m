Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FF0C433EF
	for <webhook@archiver.kernel.org>; Fri,  7 Jan 2022 13:41:19 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web12.6378.1641562877048388357
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jan 2022 05:41:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=ci5idntD;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.54,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ed1-f54.google.com with SMTP id u25so22332800edf.1
        for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jan 2022 05:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4FiYrAFRTyYCobs0EtE9uNyHjoFnzv8Crv7wvRm6CnU=;
        b=ci5idntD4W9MI7/ecbFF/UBgglyvpTtCder70XjV1pmpInUcxxzgqGIa+cNCcWEjF3
         lQduAhQLV+i1u+9MOKeFRy/tUV94df3T3H+n5s5gegjBhXTLkQKlOQfLRXHun7jDJ89O
         xhAPc2Fr7n3KaJhTx9SNHHY0JGZ8m++1kGM71tMk3kPgcOMmjOQWonpQod8cosz/UaBB
         FaVdivfm8THPdfvEa40Q7fzb6k1evIk7OBmVJUwjy4Va8H075XOfOsEhNGKfnB/7lmFd
         fEdffGYa+oVyPjjWqPcP0U+MlVN6smK4uT+EHN1QQPgSd3xOvto2kAEjgwGCRsDI2rKt
         DJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4FiYrAFRTyYCobs0EtE9uNyHjoFnzv8Crv7wvRm6CnU=;
        b=q0W/0OO745/4Mkbzq6EixPKRhJ+2omxzTTJG3X4xzPM1F9eDx1BGTH6zXktBWqTNy6
         aSMe3GL5mgx4MHg/j5aPDyH0My9c3PmH7PJya2PDWKdMWzFfu/GaUTT8c52qx2u8nnOs
         PRV8ykE1Jd1i+sNjzB4qKgm97j86qsgQo4lT4h2kduMI0dEGvK9Nde03qBTGR61AGIpN
         ZXxv+KA8HtLEQyEln5ANDBUcWoJcHFwmiHT2a4sPFpyfHzxHmYmi0OsAn8r1Gt6LABLS
         +itBQHGitigN1ImEJn7toshTTRVCK9R/tzWhbomiiOtGZiIFCO/NVXMOXxzTdltR4xet
         aUaQ==
X-Gm-Message-State: AOAM531ZXlM+97682jzl5nZwrkBiw9o/5LVHLqHbzxkm5KP48YuKKsfe
	MjfH5ol0RuqsD0Ajl+wT+5mSj3yu4EQ9vrTjmhdH
X-Google-Smtp-Source: 
 ABdhPJwa+D9Hg7VnB00lXHugWDUy/5X0NwF1ajKufId9q30CQSpbuo3Nq6RS4Q+T4AXGJdTYTZjB0jJYwBR+e2t2kJs=
X-Received: by 2002:a17:907:6e0d:: with SMTP id
 sd13mr50032944ejc.90.1641562875487;
 Fri, 07 Jan 2022 05:41:15 -0800 (PST)
MIME-Version: 1.0
References: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
 <20220106111614.218823-5-alice.ferrazzi@miraclelinux.com>
 <c8e9fcb9-eded-90fb-98cc-f766a7a9fbf3@siemens.com>
 <CANgtXuMOv+rJYyEMC0CgZsap0YETmAt30S5ia5x6+W+ppKKRoQ@mail.gmail.com>
 <65c523ba-cfaa-877c-e36c-1f0a6eec4602@siemens.com>
 <CANgtXuNUWt4ez6O5pgeJid3avitUq=fiOnVQk_+opA+Q-aTf+A@mail.gmail.com>
 <1a4f08d4-9a1e-5441-0a02-735618294e8f@siemens.com>
In-Reply-To: <1a4f08d4-9a1e-5441-0a02-735618294e8f@siemens.com>
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Fri, 7 Jan 2022 22:40:39 +0900
Message-ID: 
 <CANgtXuMojGBivk3E6aEhVwOC1W0SM2o2HpKzM=nHxPHDBEx_MQ@mail.gmail.com>
Subject: Re: [isar-cip-core][PATCH 4/4] enable cip-core-image-kernelci
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jan 2022 13:41:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7347

On Fri, Jan 7, 2022 at 8:18 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 07.01.22 11:23, Alice Ferrazzi wrote:
> > On Fri, Jan 7, 2022 at 7:07 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 07.01.22 11:02, Alice Ferrazzi wrote:
> >>> On Thu, Jan 6, 2022 at 11:12 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>>>
> >>>> On 06.01.22 12:16, Alice Ferrazzi wrote:
> >>>>> enable CIP core image KernelCI to be built with gitlab pipeline
> >>>>> and uploaded to the KernelCI storage using KernelCI API.
> >>>>> enable cip-core-image-kernelci to be built for amd64, arm and arm64.
> >>>>>
> >>>>> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> >>>>> ---
> >>>>>  .gitlab-ci.yml | 40 +++++++++++++++++++++++++++++++++++++++-
> >>>>>  1 file changed, 39 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> >>>>> index e7db8c1..784343b 100644
> >>>>> --- a/.gitlab-ci.yml
> >>>>> +++ b/.gitlab-ci.yml
> >>>>> @@ -9,6 +9,7 @@ variables:
> >>>>>    targz: disable
> >>>>>    dtb: none
> >>>>>    deploy: enable
> >>>>> +  deploy_kernelci: disable
> >>>>>
> >>>>>  stages:
> >>>>>    - build
> >>>>> @@ -37,7 +38,8 @@ default:
> >>>>>      - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi;
> >>>>>      - echo "Building ${base_yaml}"
> >>>>>      - kas build ${base_yaml}
> >>>>> -    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
> >>>>> +    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi;
> >>>>> +    - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
> >>>>
> >>>> Does gitlab-ci forces us to add that closing ; to the last-but-one
> >>>> command? If so, better add it to the new from the beginning.
> >>>>
> >>>
> >>> I'm just following the syntax that is already there.
> >>> The gitlab-ci.yml file syntax preceding my commit is also doing same
> >>> thing of adding that closing ; to the last-but-one command.
> >>> You can check it here
> >>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/.gitlab-ci.yml#L40
> >>>
> >>
> >> Then, if the closing semicolon is needed, add it to the new line as well
> >> to avoid having to touch that when adding the next one.
> >
> > sorry I'm not understanding what you want me to do.
> > The closing semicolon is needed to the last-but-one command.
> > Adding it to the last command break the script.
> >
>
> Are you really sure about the closing semicolon?
>
> https://gitlab.com/jan-kiszka/ci-test/-/jobs/1951623081
> https://gitlab.com/jan-kiszka/ci-test/-/blob/semicolon/.gitlab-ci.yml

you are right. I just checked my pipeline backlog and found that some
months ago,
I just checked for both without ; and not the case of both having it.
Still we are changing the syntax already present and used.
is it ok to use a new syntax? if is ok I can send a revision.

Thanks,
Alicef
-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

