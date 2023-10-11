Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F08CD6E64
	for <webhook@archiver.kernel.org>; Wed, 11 Oct 2023 12:50:31 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web10.15638.1697028623425923253
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Oct 2023 05:50:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=HUukXPMR;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.43, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50573e85ee0so8177691e87.3
        for <cip-dev@lists.cip-project.org>; Wed, 11 Oct 2023 05:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1697028621; x=1697633421; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0e1A9Ul4bkn/YvSVRB4rOON+61uiqnZ6SLkhUNCAbK8=;
        b=HUukXPMRdDwgvKeGMql6m8tIChC8BEoor1D9NbksPi4WpYAkM+FgCAsYPkhZp6SpDo
         Q2Lvg2SEHKkN0z4SI/yy1GHmXCGIVZHLWQANnhLCf1YNhNYqaNz8KR9iWTnN5/0R6hkM
         vlaIcFvCmopSzPvpja4pZFv9ZHK5PYDpwY+Zu4HgThL5woAiM+So31OiXTiTN8IfFgMy
         jGTUDsPZCTWgIHNh14+iT8QgXPzYX8c+oGqaxydRtwougsawvbwauuDtAQN566Y/mA56
         SHMBAiv0WwwsAx52ZBV6su04MlxcoZ0LAMms66fgHfAFihKzcBSvz8Q8Qw4pChMCCgE8
         aTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697028621; x=1697633421;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0e1A9Ul4bkn/YvSVRB4rOON+61uiqnZ6SLkhUNCAbK8=;
        b=CgYmWIEa70lnpw72h6+1+3v6V/5Lr4BpEyCcIycrwgnO988kVhxtxQ3WjO3kfJbU7E
         Q82YuuEt0/DTIqR6mMnL5MkgJXIZOrLS8axj6cMDbj2GB/Dbtjsn5U0eQmkxXz1ghbCC
         gd02iTI9ebYbjRfSs0tBTy7VEt+T0Tvvqo57w5CPwMjJPOmFd1EogApQChDzrYCPZTna
         EZIoi8b8D7uMwpLnjtxA6PFdNWNJo5WgM3zfkzB8QtwTZYma3j0YUOe841c5tLKGBUt4
         2FUUax7tgIQiHet5hKZHg/IlEXu6egjlaY64xmT1ICiZyWdjTPyfZyLXHMJQnctKZmJM
         IxFA==
X-Gm-Message-State: AOJu0YyS3ziRRIhqH0JFp01cIpDDrG2ZFftnd3sFTeg3cCvq70gpJdzk
	jjia6Lnf4vhFkpk3SMRkUvFpP4Xi4gnFtOHAw2yp7SgsaHzeqPbBQA==
X-Google-Smtp-Source: AGHT+IGatboKon5Cn0sY9s/vdLxeZUqylbvRTLgw+CAUW/Jv8N1PKtqb2W85d5u8CsKUIRFzFPYKuO0nO562n/sEfdo=
X-Received: by 2002:a05:6512:36c9:b0:506:932b:ce11 with SMTP id
 e9-20020a05651236c900b00506932bce11mr9202474lfs.30.1697028620994; Wed, 11 Oct
 2023 05:50:20 -0700 (PDT)
MIME-Version: 1.0
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Wed, 11 Oct 2023 21:49:42 +0900
Message-ID: <CANgtXuMzwXGo0emY-P3brn9wUWu8-MuSWfzzA3X+rwpj+Aaa0w@mail.gmail.com>
Subject: Absent CIP Kernel WG IRC weekly meeting 2023/10/12
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Oct 2023 12:50:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13387

Hi,

I will be missing CIP IRC weekly meeting 2023/10/12 for personal reasons

Thanks

