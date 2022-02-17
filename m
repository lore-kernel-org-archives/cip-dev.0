Return-Path: <masami256@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B39DC433EF
	for <webhook@archiver.kernel.org>; Thu, 17 Feb 2022 02:17:41 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web11.2642.1645064260655625640
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Feb 2022 18:17:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=RcVTrH2V;
 spf=pass (domain: gmail.com, ip: 209.85.167.50,
 mailfrom: masami256@gmail.com)
Received: by mail-lf1-f50.google.com with SMTP id i11so288918lfu.3
        for <cip-dev@lists.cip-project.org>;
 Wed, 16 Feb 2022 18:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2YgHo0H517WEj3fHcqk34QMO7WKaAwRwB1iGBO4O3xc=;
        b=RcVTrH2VmQ9hsnwJ+uSWt9LC62+Tu+CxjP5bYzCb5mNLHXXP+aSNuVVZI8FqVK++oD
         nUsVsr8qwJPmIYnGgufzWUi/L5mMd+mACMHe2n0mESWqT5RPSM30T6Dc1gXsEwtPXRXX
         yCAHivzPvVDIqK74I+YlSEke+ZFqKFvbJ9n1GeOkYHjvvgzk4DOoDVo4ekD2MrYLtb2V
         0N274r7kItJGfQlh4jkPmwCsLuBLQ31DOzXFb5SE6pfGBByjjOYiboq+kTBdzg6Pvra5
         AHR1JKeynACzC20Xft75g9HVvxd1AH+cIoAJJWHpYF/KsD2xUBmW0Yah4A6V310ApZMU
         AWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2YgHo0H517WEj3fHcqk34QMO7WKaAwRwB1iGBO4O3xc=;
        b=I2Qyd/4g35glS788RCiMBoBd2VU4dCcQZc31cqTM57jWI7qw4CWA7goX/Rr9G8k7bd
         gWCxmSvy1PUIn4Tzxa5POtOvl79n3Semxf4+FQE5E9trHqcNFzjfxODSPwwYvxNuzTTi
         Vn/B8eeoWz1JUk4PsnAdUgXbH5KszcTLSGP2bBs9cprz4UTj4u4PDJ8P7ava7gltVFQ4
         lTMgvWLhIQZ+fCzKQyzgMBYzqVFesgHdcrf/qZNatLbBOSbEYWVkHEhEN3Bf4Vtag1h1
         B6Ls/lXwlAeJjmeWBhRy3ml92zMI5e2lm5QE5W7o5jgT84pEH4Ijl+kOdTh0Ouks2SWu
         yt7g==
X-Gm-Message-State: AOAM5336wkYNWSUz4aRodKg9Jec0KwwTEZ3Rozl7rqYXWVUwRpRcr+qE
	txJREYCoPk3gCG/Wl0+GbSwB8EmEwkK0Iqxlqcc=
X-Google-Smtp-Source: 
 ABdhPJya2C3+CZoQtNYAKyl46BeYbp9OEJbKlmsbf+jPLnR2HoOFU7IicU9fpXYteV2gGWefNXnIX3svWiVuuP18vAo=
X-Received: by 2002:ac2:58cb:0:b0:443:3d32:7f21 with SMTP id
 u11-20020ac258cb000000b004433d327f21mr587391lfo.107.1645064258768; Wed, 16
 Feb 2022 18:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20220215234036.19800-1-masami256@gmail.com>
 <20220216121142.GB30035@blackbody.suse.cz>
In-Reply-To: <20220216121142.GB30035@blackbody.suse.cz>
From: Masami Ichikawa <masami256@gmail.com>
Date: Thu, 17 Feb 2022 11:17:27 +0900
Message-ID: 
 <CACOXgS8gpd+V=+iO5WnCXMuQakBMokTrwKfgp7TaC+D41SLc8w@mail.gmail.com>
Subject: Re: [PATCH for 4.4.y-cip] cgroup-v1: Require capabilities to set
 release_agent
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cip-dev@lists.cip-project.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tabitha Sable <tabitha.c.sable@gmail.com>, stable@kernel.org,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Masami Ichikawa <masami.ichikawa@cybertrust.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Feb 2022 02:17:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7628

On Wed, Feb 16, 2022 at 9:11 PM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
>
> Thanks for sharing this Masami, I've been looking into pre-cgroup_ns
> backport too.
>

Thank you for the review.

> On Wed, Feb 16, 2022 at 08:40:37AM +0900, Masami Ichikawa <masami256@gmai=
l.com> wrote:
> > [masami: Backport patch from 4.9. Adjust to use current_user_ns() to ge=
t current user_ns.
> > Fix conflict in cgroup_release_agent_write().]
>
> The condition to allow modifying release_agent is two-fold:
> a) caller is capabable(CAP_SYS_ADMIN),
> b) cgroup_ns is owned by init_user_ns.
>
> In pre-cgroup_ns kernels, it is IMO safer to consider all (=3Dthe only)
> cgroup_ns owned by init_user_ns.
>
> So the (positive) condition translates into capable(CAP_SYS_ADMIN) only.
>

I see.  Thank you for the details.
If we treat cgroup_ns as only cgroup_ns that are owned by
init_user_ns,  we don't have to have an extra check.

> [
> Additionally, there's invariant/implication
>   capable(CAP_XXX) -> (current_user_ns() =3D=3D &init_user_ns) ,
> so the expression
>   (current_user_ns() !=3D &init_user_ns) || !capable(CAP_SYS_ADMIN)
> simplifies to
>   !capable(CAP_SYS_ADMIN) .
> ]
>
>
> > @@ -2839,6 +2856,14 @@ static ssize_t cgroup_release_agent_write(struct=
 kernfs_open_file *of,
> >
> >       BUILD_BUG_ON(sizeof(cgrp->root->release_agent_path) < PATH_MAX);
> >
> > +     /*
> > +      * Release agent gets called with all capabilities,
> > +      * require capabilities to set release agent.
> > +      */
> > +     if ((of->file->f_cred->user_ns !=3D &init_user_ns) ||
> > +             !capable(CAP_SYS_ADMIN))
> > +                     return -EPERM;
> > +
>
> Following the reasoning above, the check simplifies too but it should be
> be against the opener, not the writer:
>   file_ns_capable(of->file, &init_user_ns, CAP_SYS_ADMIN)
>

Thanks. I got it.

> (It seems to be to be incorrect even in the original commit.
> So I'll send a patch there to rectify that.)
>
>
> Michal
>
>

Regards,
--=20
/**
* Masami Ichikawa
* personal: masami256@gmail.com
* fedora project: masami@fedoraproject.org
*/

