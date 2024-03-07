Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813A7C48BF6
	for <webhook@archiver.kernel.org>; Thu,  7 Mar 2024 05:05:27 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web11.16392.1709787923078809257
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Mar 2024 21:05:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=di+eopW8;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.41, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513298d6859so428907e87.3
        for <cip-dev@lists.cip-project.org>; Wed, 06 Mar 2024 21:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1709787921; x=1710392721; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ah7IZjU1NIkjkJ/3bSBfPe6X+g5STjodG1biY7bTIF4=;
        b=di+eopW8xHmi+coXvcOP3pVyCTdiqTlnODhCob0k/HIZMDXMV5I4RNK/DiA/j8BZgu
         DSpPxENUUYez1i8PP5XPMt0RwlSHPr0eSfiQRvQtm5m6iOzR1xdFgJKmzbRbX0VQ3db5
         x2guiKt0sSqSnNT16fWc6hp21cO9WZh2IUUva+AVfzCw8p//J1L/2ZS4FbOQ72nCgnJ2
         oJ//+ySoA+jmvviV8/I5iKUyWbIbvaJxjqWw74gdjiw7sRfPyx6YjHVwC/h/qjd5rCAU
         SuZrBKUVdh+7PnzfzkQyxqg7DT6MR4KfOHVITJvSl0lLden4LVJGSEPfPf0Ymp39SClF
         +vIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709787921; x=1710392721;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ah7IZjU1NIkjkJ/3bSBfPe6X+g5STjodG1biY7bTIF4=;
        b=ShY0WtUDFhxCcVrKcR3nYmTYOl8ECsBM47c+nz6di3eANnTgriuC+ISbvxlt8jOMKZ
         xP3fBgedz/GWlg7fqD1LzppAn/Ry0teotq6JUMHqcA4fju213oKBfIYHY3XaPmh46lnG
         MDYTNj+WI8uzlOZyyevHN5hjNgBVkgWiLaUVH+Q7mvrLPVk/x0oRN3CQUdcKjMOmPJG3
         KmXJlsAU802aPTkbBUyQhw1xjGlbKS1bv0Q05Iu23d3ZzeHGG2MCt6OTZkwbgLdqki07
         tjhfpn/I8B9gmeJOk3HPGCHFTmcsEsmFNNpUi0Uwcb1mxHqYB/OpvwsJolGaYRdCqT4p
         3PWQ==
X-Gm-Message-State: AOJu0Yzsqzgejq23CuXGwEQMqpKL1rf0s81SlF9/9cA4pplSz7/7hfF8
	m5a8l0FRNTCEKUl5IJZir5MvYTehAzVAmSzEDe98T1SkGRpSIuhRiOkgkdy5Icnr71sbJIdq+wr
	OkbRhuegar9emnIHl6yPKRRMe89OO82bxCgB1c7Pd8ecFnKZ8Pg==
X-Google-Smtp-Source: AGHT+IELZslNqbI7yerIFHUpsOClXoPDCYRX/nQBlFciqFEeM1YKccw+5m/NXhhpEtodWDyT11dZn4HVioAQrzNu8Dk=
X-Received: by 2002:ac2:43ba:0:b0:513:5957:13ed with SMTP id
 t26-20020ac243ba000000b00513595713edmr556681lfl.30.1709787920358; Wed, 06 Mar
 2024 21:05:20 -0800 (PST)
MIME-Version: 1.0
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Thu, 7 Mar 2024 14:04:43 +0900
Message-ID: <CANgtXuM6+kCFaU2hhHrPVc2vKJVeWXb3i0nNC2pWdOp_gYZgbw@mail.gmail.com>
Subject: IRC meeting
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Mar 2024 05:05:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15251

Hello

for personal reasons,
I cannot attend today IRC meeting.

Thanks,
Arisu

