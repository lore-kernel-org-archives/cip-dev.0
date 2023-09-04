Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F133C71153
	for <webhook@archiver.kernel.org>; Mon,  4 Sep 2023 09:26:52 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web10.44199.1693819606071500507
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Sep 2023 02:26:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=0aMldVxZ;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.171, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2bccda76fb1so19403781fa.2
        for <cip-dev@lists.cip-project.org>; Mon, 04 Sep 2023 02:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1693819604; x=1694424404; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GnIas+WNvcXi4NH4trhuIaY91A50P25cQpNCqCDV9tc=;
        b=0aMldVxZrWmknU8OQbZqCJ/Qj8G69m7b6LhRlwLMA90B9jyE+aG007gxxtrSzu4d32
         9zuaXkjuYqKdg/V80TyRqnIAyilQ7KI75DfU31o08QtS+SQ3BCPGwfFF5sW6LKJ4KMaQ
         4NPbRtGjhR2A7y3gQ06c0k65pWlHqjFy9AiP8qjcvuQXdynCEEtNqbu7d85RbVMkB+fc
         Y5ZTOQmwEeRQ6rZdwGrvY34x652CBfA7ftwGBc0+zyhzBshdu9VsEMzhJMGeaBnXKU+1
         Lw2O4QvbvL2hh2QwJ2bR9KRzgRzF99XlQ3rj26GwL66GeaERxNgiovzeLHqj5hllAoxD
         No9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693819604; x=1694424404;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GnIas+WNvcXi4NH4trhuIaY91A50P25cQpNCqCDV9tc=;
        b=jLp4cMwKV8I//4vwqCfUeRdrobwh7MYfDR8+uyaBbk5CK6dgdM6lIUyAJfvtqQkSYt
         Pl+7/rrkWozsSAEh9/6hjZ1wwoDSWUXkIO+a1IYH6gnOA1N3jJUYcV2AM6yfr5PEVkN7
         iRMCfJqJW8g4hjDsG7DYdflGsXsIba0QbOZSDpARMdVsqc12c5uF8P9GTar2Lwy9GHWQ
         XLgSwz34owTHs9+5SIIQJr7m3pn6RMfru1Zg9CHlDjKQnUAGAETzUApqYbXbw+6saEUf
         ko6EV9xonwWcXA8NDQxhPUtvoM21HJPfqn+2GZv8B1PIEy8x6OV0/zOMi2fVUQ8d55dO
         b8gA==
X-Gm-Message-State: AOJu0Yw5VfDvJTl7EpnzsqzOUpVB8yePqkOAsmcSqDyb4X5v1I0l66lv
	T2LsxU8A/ZkTtfFajVUzXLSHx+iLG56pHYh94ZEBMX5Y2E0eoZMIvg==
X-Google-Smtp-Source: AGHT+IGUPArLVfpILjUDNSNevsIJSQusRe6tlBJnglFLGUekZ9Lhs+nEH3CaGYXDe+6PByoLSptNvCljGqj1C62tBSc=
X-Received: by 2002:a2e:9194:0:b0:2ba:18e5:1063 with SMTP id
 f20-20020a2e9194000000b002ba18e51063mr6161058ljg.50.1693819604009; Mon, 04
 Sep 2023 02:26:44 -0700 (PDT)
MIME-Version: 1.0
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Mon, 4 Sep 2023 18:25:55 +0900
Message-ID: <CANgtXuPg7z=wcjU-GgLcHDfOAKP4TqGa3P0BVtXrEkjO5j3qRg@mail.gmail.com>
Subject: [cip-dev] Absent CIP IRC weekly meeting 2023/09/07
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Sep 2023 09:26:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12938

Hi,

I will be missing CIP IRC weekly meeting 2023/09/07 for personal reasons

Thanks

