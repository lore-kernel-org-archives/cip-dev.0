Return-Path: <konstantin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC47C4332F
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 21:38:23 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.web08.13129.1665524302406555976
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Oct 2022 14:38:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Jn9hgBQX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.160.171, mailfrom: konstantin@linuxfoundation.org)
Received: by mail-qt1-f171.google.com with SMTP id f22so5167908qto.3
        for <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 14:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwvC2rVzFiuqhbakJo0TvtjAAIOFhueHSsZ4ZzK/Riw=;
        b=Jn9hgBQXI5HHF97EdIJ8tNWSF0w1O2kq86uv0iOpeddceXdNa9mQxZTuOjMlj5ozBT
         OdKeOXYpttDX8kCbz3PTl1TA44Z7gL9AuYU65xDdiRZpyc+jCz/Qn4HnqCqSCXjV/msW
         qG98Q3CsLHMlzxzTE9iOTB0GKrNkDXYYmXVRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwvC2rVzFiuqhbakJo0TvtjAAIOFhueHSsZ4ZzK/Riw=;
        b=Pg/N61t2VSNysfwx4/Rq4mQkZJtswJiSFKBq0NnXxGpoZYfX6/+4XPJf42TVCdWqfl
         SrC9ZdGipawyNV8PmvvFC5EMIJH8B6UOjlhbmjLcYGftlUFcYAyx2JHat/6JmgCeNke4
         TDivOEdFxJxGdh9rAW15/Op8OFJBzeVoxZVZmqKyxSrwinSPINtFxstV37di42+WWx0y
         rM+6IPAiRT1z2Yle3xaHjcnvzRF2CM3aR1LCTgclRfHijz4005BfiHwZeJu1d+QrN/WT
         HIIbo1em71XPChwXMurLXN/sRXOtBUySzN6mDp2Kzp0739rFMmDoHRptae7jFr56yFge
         DGVA==
X-Gm-Message-State: ACrzQf2ebMnH/bQBg/6MihX61Lv1e9T2bSKguANmSblX7akcEDhu+boG
	SYPzNJhvW0XT9sWrdPlI0lJHGeBjr9vaiQ==
X-Google-Smtp-Source: AMsMyM4cZZhWcYGFpXJ514asaGqBSN39QwzzU59Sv1Hjf1Xcs5WKT8ySMK1wgWk1wxrxILEfnk3mZw==
X-Received: by 2002:a05:622a:3ca:b0:398:db76:9072 with SMTP id k10-20020a05622a03ca00b00398db769072mr13417739qtx.301.1665524301177;
        Tue, 11 Oct 2022 14:38:21 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id j9-20020ac85f89000000b00399fe4aac3esm5728578qta.50.2022.10.11.14.38.20
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 14:38:20 -0700 (PDT)
Date: Tue, 11 Oct 2022 17:38:19 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: cip-dev@lists.cip-project.org
Subject: Re: Troubleshooting missing lore messages
Message-ID: <20221011213819.eww6rx5sfzv2zw2k@meerkat.local>
References: <20221011210911.2ufn3yqpg43habc4@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221011210911.2ufn3yqpg43habc4@meerkat.local>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 21:38:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9735

On Tue, Oct 11, 2022 at 05:09:11PM -0400, Konstantin Ryabitsev wrote:
> I apologize for the noise.

Et maintenant, on suit en français, parce que porquoi pas.
E por que não em português, me pergunto?

-K

