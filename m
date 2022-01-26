Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B218C2BA4C
	for <webhook@archiver.kernel.org>; Wed, 26 Jan 2022 11:44:38 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web10.11524.1643197476469626522
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jan 2022 03:44:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=dcK7ZpcE;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.50,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ed1-f50.google.com with SMTP id m11so68479530edi.13
        for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jan 2022 03:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HuKx0wQFKb1g6ePfUbfhAszwUrXIM3pyJ3uORm/RYVI=;
        b=dcK7ZpcEVoxU1HOYqSX5KVMMzemPZ14qJCwZU/a8hq3QXjoOyULwr7CzR7ZgzF+hUS
         BfYaSr/wypJJaU+0pYSJ29VKFcJ+D0M08azicSzxaR9pyy3b0/ky1EuLb85hTeeD7wJ0
         aFW3V8/aaw3bm2ml0yHnN+1rUCp1/25gVPCkzq0jbTZUUb1WzN2Bz7ZVd5ek0i0YQ/Ej
         Nfw8C7+IhPQO/WZkrHD6lLrLo3agiodBgMc8JdIkh5VIEywTAdalEcf6d8Ge8pZbqd2u
         U8cdj1OXoWQbslPwkFp0MfTTrM7MaA5fKhbIdOzHBPLQ7dySOHC1S8kYz1XUxdkC9ZDp
         l9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HuKx0wQFKb1g6ePfUbfhAszwUrXIM3pyJ3uORm/RYVI=;
        b=ln2u9IG29qkUBhsYVTYFXvnFB96sgpgQjQbiuuMXAlTP37cKzDF/Nsq3wgCuiY1j09
         sCHiyPoRUkd02WhaEUs983h8MgZH6K/07h59i7Gef9ZMJX9I1YTSb5BPz80uLzc5geV6
         srSRNpD6CKWB12q2xQGuDXnWYgHFRwc/8ebEsU/RB9mZEQtU1oinE8/QPelnO3wALH3s
         ppA2w8qypmeP4mJ0IBAqQbXUV3uGbVKt0HnyE5Xq6RPEaOURQIBVfifac6aDDLd/Du1f
         kwA8qse4CwzSAQA9asmT8SMh9E7hl9ZJRJlp/7GofDZLNO15LOcvbyi//XDnwY2WEzw7
         Rf5A==
X-Gm-Message-State: AOAM530dWNXzDEFrx22CMrSRMYAQ0s4ff8fzo6UwUOCnCDkiX0ZuLeN0
	RJNQM4mswsGVGiOKdhXt2GAp+0BGEt6FyyxJVCuU
X-Google-Smtp-Source: 
 ABdhPJxFhuzU0PrO+tWgrxuI+F/v5YoLui39Cbo5GKis4IKamT2IP99Y5zYOhIjtD2hWdP9mzub5ZuCGke5o9GNWFqs=
X-Received: by 2002:aa7:c04e:: with SMTP id
 k14mr24235769edo.131.1643197474812;
 Wed, 26 Jan 2022 03:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20220120125418.236990-1-alice.ferrazzi@miraclelinux.com>
 <5de7f456-6428-ed67-de99-797058f6ede5@siemens.com>
 <CANgtXuMcfX6JUBj_pf46Ukhd9rMK1j53a+E53jseUmzXkVQu2Q@mail.gmail.com>
 <45e2a270-d6af-23ef-21bd-e608bb295621@siemens.com>
In-Reply-To: <45e2a270-d6af-23ef-21bd-e608bb295621@siemens.com>
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Wed, 26 Jan 2022 20:43:56 +0900
Message-ID: 
 <CANgtXuPvyVDYrk_CnLKtjEe4H2btxTprGRWX1-xJqOEno3=gXw@mail.gmail.com>
Subject: Re: [isar-cip-core][PATCH v2 0/4] Add cip-core-image-kernelci
 building and uploading system
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jan 2022 11:44:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7487

On Wed, Jan 26, 2022 at 7:37 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 26.01.22 11:27, Alice Ferrazzi wrote:
> > On Wed, Jan 26, 2022 at 6:37 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 20.01.22 13:54, Alice Ferrazzi wrote:
> >>> This patch series add a new image with settings for
> >>> KernelCI.
> >>>
> >>> This new image is called cip-core-image-kernelci and is
> >>> based on isar-cip-core general image with some changes
> >>> needed for make it work with KernelCI and taken from
> >>> KernelCI image base settings.
> >>> The cip-core-image-kernelci images are built by GitlabCI
> >>> and uploaded to KernelCI production fileserver.
> >>> https://storage.kernelci.org/images/rootfs/cip/
> >>>
> >>> These patches are already integrated in the
> >>> isar-cip-core:alicef/kernelci_master_refactor repository branch
> >>> and are generating the images that are currently
> >>> used by KernelCI.
> >>>
> >>> cip-core-image-kernelci as been tested and are
> >>> already used in KernelCI production with good results.
> >>> https://linux.kernelci.org/test/job/stable-rc/branch/queue%2F5.14/kernel/v5.14.17-9-g9f7eecaa70b3/plan/baseline-cip-nfs/
> >>>
> >>> v2:
> >>> * drop trailing semicolon from gitlab-ci.yml
> >>>
> >>
> >> Didn't you also want to de-duplicate the customization recipe, build
> >> kernelci on top of the common one?
> >>
> > from my understanding we decided to don't go in that way,
> > because changes in the common part could break the more generics
> > KernelCI settings.
> >
>
> Fork where there is relevant different, use the same one where there is
> not. Duplicating files/99-silent-printk.conf and files/ethernet is
> surely pointless. The latter will actually cause unneeded maintenance
> efforts when adding new boards.
>
> Please also avoid needless diffs between the recipes so that they can be
> re-aligned easily when boards are added.
>
> And I still think we will eventually miss the wireless setting from the
> generic customization packages in kernelci, ie. the only real difference
> in those recipes now.

Is not as we are adding dmesg.sh script (please check the next commit).
KernelCI have a different environment than CIP current gitlab testing.

That's why the last time we decided to merge as is.
https://lists.cip-project.org/g/cip-dev/topic/88235357#7341
https://lists.cip-project.org/g/cip-dev/message/7337
https://lists.cip-project.org/g/cip-dev/message/7340





--
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

