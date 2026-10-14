Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A428CC6B1A
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 15:21:54 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16519.1791991305066575727
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Oct 2026 08:21:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=QPqwoqhq;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5bce4e278baso1234848e87.0
        for <cip-dev@lists.cip-project.org>; Wed, 14 Oct 2026 08:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1791991303; x=1792596103; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MZWEbE07bljpKv2qt6mLlhE8tihwNgXXx0U+Cr/xO/Y=;
        b=QPqwoqhqU9CGd3yG/qGaTHlS+Eupo3B/zqAFK822QMpGoSQx0w/DZD0fbhQY3OFwpZ
         H/1UIGbOLF7MDy8sLHLxaS570Ml001JES1yXJqjoib3kCi+u0oRGF8vWY11ZbXqSdnsF
         Qph+usDr7A38g7JrkesQ1CZCuN5KCevRa71v+NRH0KEs47a4XR6LFOk+Pm9QE29yWkGe
         0Urdj53AdkyQ4wY/mq0YFQ78bDmRh+Rh19bv5Tgcu80KNotBGXmQq8LIatY+ndnMpjr+
         fsTSdgza+LzAROoyCzZ4S+9rr8bslHVRnhs5UcxoYfQf81g92H9rIK7PHWs63n37Ffpo
         kF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991303; x=1792596103;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MZWEbE07bljpKv2qt6mLlhE8tihwNgXXx0U+Cr/xO/Y=;
        b=eFYbWVq7Jom2Rh0DGw+7XYhzJhtnAGasOKihC8Wac2Twq4DcXisHV3oA5ReT7wx1dt
         hv8LUOTKfECNgt5hUUAi9h488ed93EmzdtLQgYEMN+vb0RfxTy43z2qCkSMWbxlzZqsr
         e2MrdPo0oVCCHjKOwnxe9gOWWNIEMJBUDGghbuzfzrjfjc6XeqcyBGc9jW/Kn2O4n9ee
         EL9Vf4LRvAWDu7fJX4rCxJ4dtLIeMGg3K3+CmDib9cDktTtpRzudgmv+mo3SRI5qz46A
         4nZNVY8o1gp3Ccteldzg/M8fLl8j1ikHLtiZJrIQb6Uf+65w1O39iHXebhQiUwfiztn3
         xRfg==
X-Forwarded-Encrypted: i=1; AKwUvBzmmlm3pTSZBzFfPqxdMGhPSyDCdiXEDSvR3z5LMCxVdf6D5fg101JbdY+AdX/qx3SCTw3UrwQz@lists.cip-project.org
X-Gm-Message-State: AFq9FYKqP1kLg2tC0qSe54JAod7QzawHXDK1JlZNEwK9yNhaIxqSjSwS
	ek6AICDDNrIdrt/KjZg2giB3Q9O1j28lORPFTICEG/Rhs9jX/xbvmHZ2pyBabAgu1hQ=
X-Gm-Gg: AYBFou1/685s2lq469hVMXECAvUQw5wdbSlOXg9sp8gX8+G4kDmxCy9e2H9LkicOgQN
	aqE6r/NZBRn2RjorSdtZvyXHAXkbl00qNLRMENTjrQsSMLSxH2FWedSX/KnBuWU5oXwbTU7sgRL
	+BzVjh8OUxf1nAnpKTw+vgFyXckBfSTBBemIbqwCZQJOWq6rjvcyHnt8sC8ykN0I8EMouWZoetg
	FogABsn7A08XMbcmRlAZVsLKUQOm0K4CVMzBaQX0qcC8haqIN10Y0CuWz+J4VvxG0vS96aALJ9H
	wM3of8UYtHkvVHj290/ivvPNqKWzsiNKz9MWyNWKCMTIgiVujDrhAEzOUV5qNkw2JvJpbetUjMx
	8kkRVJKYO7uEV/jQmNsDXZfqpy1/i38KLD9IIqRAHGcNoDymuyAic+HixFRFzOSTbfZDjvsdC7D
	CMLdMVYnNYgtDeNjUy/nDOS+ZQ9U4nSP6cNQi5QyrekfY/FMmb26IrfAHxQaXxdJh0709ll2I4m
	44BDhM=
X-Received: by 2002:a05:6512:3186:b0:5ba:3e55:88ce with SMTP id 2adb3069b0e04-5bcdd512299mr5107499e87.21.1791991302676;
        Wed, 14 Oct 2026 08:21:42 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967affsm11323965f8f.1.2026.10.14.08.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 08:21:41 -0700 (PDT)
Message-ID: <8a486bae-dede-4fa3-a9f2-7519d9629a0d@tuxon.dev>
Date: Wed, 14 Oct 2026 18:21:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 3/3] soc: renesas: rz-sysc: Convert to
 common field_get() helper
To: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, john.madieu.xa@bp.renesas.com,
 biju.das.jz@bp.renesas.com
References: <1791930919-10628-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1791930919-10628-4-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <1791930919-10628-4-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Oct 2026 15:21:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24463



On 10/14/26 01:35, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
> From: Geert Uytterhoeven<geert+renesas@glider.be>
> 
> commit 610c4408a2f7a09a00f656459e762ee1e21bbd7b upstream.
> 
> Drop the driver-specific field_get() macro, in favor of the globally
> available variant from <linux/bitfield.h>.
> 
> Signed-off-by: Geert Uytterhoeven<geert+renesas@glider.be>
> Reviewed-by: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>
> Signed-off-by: Yury Norov (NVIDIA)<yury.norov@gmail.com>
> [iwamatsu: Drop '#undef field_get']
> Signed-off-by: Nobuhiro Iwamatsu<nobuhiro.iwamatsu.x90@mail.toshiba>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

