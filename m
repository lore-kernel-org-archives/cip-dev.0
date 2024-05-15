Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFCBC25B75
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 11:38:11 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web11.12492.1715773081134547634
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 May 2024 04:38:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=tozc3QSK;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.41, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51f45104ef0so7398025e87.3
        for <cip-dev@lists.cip-project.org>; Wed, 15 May 2024 04:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1715773079; x=1716377879; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7QMuR8h1yz6Yl5qNZ68FGO1zxuzyVFqbYvPLWXN78I0=;
        b=tozc3QSK/1z4SLcgS7RLwpXpit1vrtJwE3wgBmnIBwo7ygTAquZN4GKXVhRRLtdtkc
         nwun10H0H/6XIDRrow+28XCgEG51GfH16G+4lxOE3rg7SzGlO67R3eB70v6m3jros7tq
         tFNj1PaRTMdKBO8vOYPHTRgZdkbIMrrNArALE3iOGnNb5VdyjoBDozlGElWIisZk68LG
         2BdfdcVFQZLfBBtw8X5fqkLni6tz3IEm5Me5nBtyxx+Fos9P7fBfmreva6KbvGqCCa5v
         kl1b/or4Ms/K+gMzyA3LsnmvnHhvj9gNvJ3pTCCp+ovlQMBEdD3vR2w1p2/OHXI3yzst
         DyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715773079; x=1716377879;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7QMuR8h1yz6Yl5qNZ68FGO1zxuzyVFqbYvPLWXN78I0=;
        b=FRZfOWODLcdblOR3m8ai0Ef6e9tWbxNVSC8Y8Gds/jFz+WQyViZYxA0Pv/ACUkO2Rj
         oq8XaMg4TT+5kKXuRXtoMXSMiWakqPqCrV5HkNcOCEJIPfW79pPZ/HicQ9QUW6ltuPok
         bVggCQREoq4IcmdvsyHJ2EdS79GM9H+MDnWJr+fy3+tbK+sH7OYcVvmhyQFATBCbw0Cn
         wcZpRvvMiKyRc5fziRjw8o8/73rXVTmsgaoUPh9L8ShUi/Y5nGn1zlOWrSeyYNC5CbOU
         cEh0dJKIylu1JnAhKQRJl4MZ8VdCPQ7dBImY1kt92Z3fbEJ5k3EbuW6bgR/gAYerE62P
         oL4g==
X-Gm-Message-State: AOJu0Yyo/1Kaw/cBxNeqzEckXsZql6IqdZR7S7b+doQ+WxUiy9+hmBB0
	PhP01ezNPWgZfesveInmW4DbntccpxXLMqo2nAyOaRwWf6f2zwRs28kRy1DjDyTMDAXcDodBJ/7
	2mMq6My923Z6w2ZJoTj826a+1CkLh6q/IT+MdyBeKagcqu6lU+A==
X-Google-Smtp-Source: AGHT+IEbEoe+Fb2vgxZ8cHGwCe2sjvx2YbJ2YyAPnGtxqkTPTfrj+jkib2IXvPddfk5PorrnHOX9Ip+5ZMvd00zKzTQ=
X-Received: by 2002:ac2:424d:0:b0:521:b2b5:60ea with SMTP id
 2adb3069b0e04-5220fb6b131mr9871603e87.23.1715773078807; Wed, 15 May 2024
 04:37:58 -0700 (PDT)
MIME-Version: 1.0
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Wed, 15 May 2024 20:37:22 +0900
Message-ID: <CANgtXuOZdu+b0L9UxgtsY_HrjAgMvxZXKxEkws0LykR_jR5=Zg@mail.gmail.com>
Subject: [cip-dev] IRC meeting
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 May 2024 11:38:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15896

Hello

for personal reasons,
I will not attend tomorrow IRC meeting.

Thanks,
Arisu

