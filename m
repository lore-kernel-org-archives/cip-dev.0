Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA660E6895B
	for <webhook@archiver.kernel.org>; Thu, 31 Oct 2024 08:22:45 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web10.7842.1730362953821047041
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Oct 2024 01:22:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=21j6f2Tv;
 spf=pass (domain: miraclelinux.com, ip: 209.85.216.43, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e91403950dso496899a91.3
        for <cip-dev@lists.cip-project.org>; Thu, 31 Oct 2024 01:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1730362953; x=1730967753; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/owQvRID5HYH+toNSXIOwjjv0wE2Jc/jBp3GLwxB9Jw=;
        b=21j6f2Tv71y3ZNRGTN/mLSsKqfwjNSLKirPhXcnnoOApFmlnSdTlKnmp9TUqhaME7Z
         vtsGKHCa/ZD6SymS1xE3RMBXTyT2D/ImMRI2uCD06Ab42uItZqlgqb3R0n9ZUi1u4iHz
         jFa33oFkD9ZV+HvkN29r7Or2Y6PyEtAKX/I6eAJEOc0rsxl4pWwvYLMeQ/zkA08Zr2Bt
         15vOlatJSniLUS9sKBvvcFCG9v9fx2fS4/ii4ScqJqdG9ZYazKHWKWCwT1SrP+Uo37Xm
         SGxrEmHujTrKmZFsiQrgqBUkwdYOG6nY1EcBcHIKcSwgnDPbnAhLbdfQxemr560D0oC1
         kk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730362953; x=1730967753;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/owQvRID5HYH+toNSXIOwjjv0wE2Jc/jBp3GLwxB9Jw=;
        b=woM/tH50o7dLP2KBZAxRvzXJjrl1jJnMqWRSPGmcLFoaPogUT7MSkfbib3GPNi/k0E
         TuajYYv9WABQH4HoX835+NBifpgfqBxzhVjExLs/ReTXJ/njJ1YgfLE9PuI6nZwTchqK
         tywpE8iwbfEr17+DAJBJD0wbuah/tfNu9NZ8gs1d9LUY/q63MbvPoSgwtfPEMPt+USfN
         l6aDPipbJzcD+Kj7AJfIgiBSrLi3mBwmPXi91+ogVXBH84vliqYTxJ54vkwh0vnCrQJC
         HSdjvwXb6U6XWKB6Xeut4hmqQ32O39cPP1lbCoUz5tpUpEfGemhpzRP5oVDb7MHyXD04
         x4jg==
X-Gm-Message-State: AOJu0Yx4owDOaUUMFp2ajnqVzz7EvG/HKWB7dbftxZaC3xrDymwlXdb3
	csxTYBC7oJkNjbL5j+621yricScUIYXNQq5dWejxITsZAl3Fr3cZ6/ja1ztfFc+7iUAYOLVorw7
	okMzwKaRuVC8DVv5ChU+qHAkROiwMFaabHTwvXi6OKnZ/lr9gMQ==
X-Google-Smtp-Source: AGHT+IGq2008V3GoUvpT7OdSmY6lky26yV18pGtP83uBerd+SV4QXLyfB6LxorE/JoYtstZZ3OthYCNCGS5eGMfvaiE=
X-Received: by 2002:a17:90a:e10a:b0:2e5:8392:afe7 with SMTP id
 98e67ed59e1d1-2e8f0d65883mr20419870a91.0.1730362953162; Thu, 31 Oct 2024
 01:22:33 -0700 (PDT)
MIME-Version: 1.0
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Thu, 31 Oct 2024 17:21:57 +0900
Message-ID: <CANgtXuNXafvoYGxbym-eBW1eoJELY0M9e6wuOKBZRn5XB4Nfhw@mail.gmail.com>
Subject: IRC meeting
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Oct 2024 08:22:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17125

Hello

for personal reasons,
I will not attend today IRC meeting.

Thanks,
Arisu

