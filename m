Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F72C77B75
	for <webhook@archiver.kernel.org>; Mon,  8 May 2023 23:34:58 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
 by mx.groups.io with SMTP id smtpd.web11.867.1683588889825922006
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 May 2023 16:34:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=VkhlhvOT;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.177, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-393f3360b06so290241b6e.3
        for <cip-dev@lists.cip-project.org>; Mon, 08 May 2023 16:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1683588888; x=1686180888;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rg75KXfxVWY0Br5p4RgMsBNM9zloVwvXbPeQyP95lfs=;
        b=VkhlhvOTG6Pm0j3SAYQ9qQFtaqd0OwkeVPcObhnmhl/85xwxb4ElTwD0baOsCN/0/3
         VoihJpV/X7yIusgl8KY0c17u2A6nlZcynJc93IskmYQQdjvzVRPqTkEmoHCPMykqvRDf
         qzndGWN+gB14ETpCufU48CEXiUkKVQ8vdxk5Q+dBdO/6Nx37xxhFtXrXUv/c4yVVjUds
         xJKFbooW7wxLeUzAJ9G7VYaDw0tR4D+nFLPEc/34k8K8lpMw0hMR5+PewTJOfmeMRVhY
         Bys0vz5SU3CQ6yDDImDDxqEqvEewzXdOLE+PzZ6cmS1GcbkZkgRjD/G6rJZ9VO102f45
         97ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683588888; x=1686180888;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rg75KXfxVWY0Br5p4RgMsBNM9zloVwvXbPeQyP95lfs=;
        b=h6Was4l5Gh2+NsEKlSliVd+xuSY1Bb9gZNbuXBFDtcgK+jP6VtzMwe504kGDijXEa+
         Q4kkSdm29an4w2u85s+IfnZG7v1PJSj96OoYW8d9zdrgkBQsbhwlcwxxp6ysT2TBaKt8
         awMjoHMrx0qVNchDg5TmLZeUwPjnmSgy5LiRLv+EVtI7xoW2+MVNz+m8Ghc78dpprIv2
         ar/qRr9aRNNbytPq6QBuqAM+ZOKR8tgY+1YZWgnC0YSbpdo9zrN0sCM5HzR46K3qa65d
         mGkRy2VYBGJs0Szr+K7v/6wHth7uBU3FWK5ud1ojWas+aeoDTQRHRBNU7qaTrWlnAsTi
         WXjg==
X-Gm-Message-State: AC+VfDwYobaQccMHM6xp/puHUe6yd7ROrIK2OGZiuaXh9ZPAm03KgXQb
	1VtG1sSKnfbBzTApfs1wXEr48ZvNRhv61dSWuXP3DSktU/njlP9s0Mk=
X-Google-Smtp-Source: ACHHUZ79ph/pTr0eWNK42JKSmoCdRDtQSIC85Vbre55YMN4LwVJZ8edftpsgfCV2LvTDInY8XPj9RTDKlrWdPt3MxeY=
X-Received: by 2002:a05:6808:43:b0:38e:1558:852f with SMTP id
 v3-20020a056808004300b0038e1558852fmr325095oic.32.1683588888340; Mon, 08 May
 2023 16:34:48 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Tue, 9 May 2023 08:34:12 +0900
Message-ID: <CAODzB9oaJ73uvgppYvcOBbM2xLNB1LQW34TZbjA3gd+bkAKaVg@mail.gmail.com>
Subject: Size limit in the cip-kernel-sec repository?
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 May 2023 23:34:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11417

Hi !

When I push commits to the cip-kernel-sec repository
(https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec), I get the
following message.

$ git push cip master
Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 4 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 457 bytes | 457.00 KiB/s, done.
Total 4 (delta 3), reused 0 (delta 0)
remote:
remote: ========================================================================
remote:
remote:    Your push has been rejected, because this repository has exceeded
remote:     its size limit of 0 Bytes by 400 MB. Please contact your GitLab
remote:                   administrator for more information.
remote:
remote: ========================================================================
remote:
To gitlab.com:cip-project/cip-kernel/cip-kernel-sec.git
   78850bfd..92d679f5  master -> master

Even Though, I get the message, commits are pushed successfully.
I can see commits in the gitlab's UI.

Do we need something in the repository setting?

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

