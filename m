Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A67C04A6A
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:45:29 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web11.162473.1692197123827636938
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:45:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=t0VjF1LZ;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.177, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so97988551fa.1
        for <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 07:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1692197122; x=1692801922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RUm3GkhIKboJESBtLhHG6k9fqtIiBP7pvr9Oi1tq1Mc=;
        b=t0VjF1LZPep0j/uhHj5rRXrXSBn8JF+oBRO8yPC16DpEz8PGCE3ai+QS826iN7Quvv
         /7OWzTXufLHYVEqBt0CcroQGD4C9/zaQKJHiPRH5wMRCpGo/6X6gdlmXpKZuAe+mZLkm
         aL/gwI3CyDChc/tq/ag5ixeSCe9RsMp2/v0dNLlN3wF4paW1yduUM3warEU+/XB/7ba1
         5VBCyO+GzPbIOuGWwnFPRbZd4DfQfbaroi/rNdEJ5S0FLEgjRfky5p0HOUfkxywo7uPw
         1OWUUVeG7dDp4A748W4/J9HUxeHlzeswk7ZUvqiKX6tVKAvkjadg5fi6O9cDnvdWjdW5
         tmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692197122; x=1692801922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUm3GkhIKboJESBtLhHG6k9fqtIiBP7pvr9Oi1tq1Mc=;
        b=ffj8Ea1d0wN4Hk0/yeGG5aUHeTHuFWaSXYZukHq2cu1+HkacqB7QupR248q1hU32gv
         ebWHF34AyNBElA2b5q7f1KNRpDD472HB7OR34hYRc5OcFwLJRkHMatCVV0IZ2EwM0ZTf
         aXxw9MThbWixKWP9lm6HTenU/kFO6rbv5viIL6525kUCG1nMdx2HEHFlnCQfzsWhbBoh
         8VAh689WMHBtxBi9savCIQweqBzLiQpwXFLJ3NQjILF/lnUdKMG6Mgsslu0cGka1pg4c
         Ng6HGPfpNzzNAbNe/9zQpsUWZQZ+nAM6/MRZFOnbQQlGM1rtdqpkWauK+HoLC1YCYbLV
         5dnQ==
X-Gm-Message-State: AOJu0YydysfU4XXDUQotnlpch+Y/tf1xc+LKiZJkSljyna7oNqh4HgAF
	Vt5QfxTMmuFGqNZxi3XGBHrCUR5JRQZEEZz2V5msK3UwuaXfgY4=
X-Google-Smtp-Source: AGHT+IE++IkGGOeTpeFyJ/nrpFs593gQ2/oj+DDkmME33Tqr30KAEyzarU5RVXqn9aXlQIQ5n56osbD1VZwYaHqXa88=
X-Received: by 2002:a2e:9b84:0:b0:2b9:cce3:a126 with SMTP id
 z4-20020a2e9b84000000b002b9cce3a126mr1820799lji.21.1692197122022; Wed, 16 Aug
 2023 07:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230816080300.5559-1-arisu.tachibana@miraclelinux.com>
 <e4fb5477-18a7-4c65-9caa-4d647dae6a07@siemens.com> <d9aa0410-78e0-4f60-b16a-ccaa3a8302e2@siemens.com>
In-Reply-To: <d9aa0410-78e0-4f60-b16a-ccaa3a8302e2@siemens.com>
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Wed, 16 Aug 2023 23:44:40 +0900
Message-ID: <CANgtXuMPBG=yJ9P4oH1JPNWNdK4TqhL0kpmD=jbLGKgttT9V7g@mail.gmail.com>
Subject: Re: [isar-cip-core][PATCH] .gitlab-ci: Create amd64 release
 variations for KernelCI
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:45:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12732

>
> Oh, and why only amd64? There is no need for other archs in that
> combination? Not that I'm keen on exploding our matrix further...

Currently I thought to work one arch at time and at first doing amd64,
in the future I could also work on other arches

>
> BTW, do we need the kernelci builds on every push, or should they be
> updated at a different pace? When are they consumed?

every push works ok for me

thanks,
Arisu

