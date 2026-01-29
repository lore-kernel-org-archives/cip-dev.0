Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EDAD358DD
	for <webhook@archiver.kernel.org>; Thu, 29 Jan 2026 08:20:15 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10662.1769674814644533648
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Jan 2026 00:20:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=CdhgNOE/;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so6963595e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 29 Jan 2026 00:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769674813; x=1770279613; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wl+2utSIf97k3DB7hMJtRzqKw+kCu522EgCbo7RRySY=;
        b=CdhgNOE/YkGaNkW6sZyt4Ie5TSw0KYxcqMOGKto5gUxa2vKoX3+NvbbnUwQG2LLC/h
         TE6abIy+qgXPwRAS4pCJJJIXm5ym7keHYqo58dj0get6amBviwV/5oegGTtUjwmPtAUC
         Mmq3+DrOFap5MYBw+bbOfSx4VK9OFz540G7Q1zND3GlJI3i3qSCm2aZsWYU0abmVdIGd
         PFUAr1YIBLYBMZ6xe3tKTZ/p1iNpK3NFzXgIORERfQFyeJTydP05ehQVWDrNpfT50dTF
         7ALoPh8dnEEtaLREuK6Dnp8So/3fUav7k4iAiJKJ1Jon47Hpobgup3S/i4aGSPay9xZP
         xmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769674813; x=1770279613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wl+2utSIf97k3DB7hMJtRzqKw+kCu522EgCbo7RRySY=;
        b=aaYYBK4+ClD4HU+nYJqz5jLXah9+xI+IyKE/BrH48D900F6gGSF2uj44mS2vXVnd87
         Hg1cqKPh2TNrI4A1V2jr1c/OePlptfXHZ7txyP3T9X+TwVp7RCoYxM+OASgZpE14p3wk
         t0iZZ21cO1R9xQAInfT5BFX+tc7hWXMbmXY22rVo6eToAupBOxNYiqX9CnGGmvVGPoyq
         8+YXe9MZgGJ+HZFPUTbbQn86vU5YMHmgDIRSXy5qU9ls6fN20CErHCNSSzHDSG/rrbQ8
         NGHItNaQtL2QCkOTzxVtNhPLR85CwBqC+S4oNR20+/Oo/2ageq3IMDNjcw/O4DFYh84E
         8YMw==
X-Forwarded-Encrypted: i=1; AJvYcCU2ZyTnK4t5zRiHkPcYbyzpj9Or+nYPhHmzB9L1Z7uwLZOKOJ4slidgJ7RCq8M5ZjVev+FPX1TM@lists.cip-project.org
X-Gm-Message-State: AOJu0YwEK40WjwAizcpfjSBeIPYusgzT0u8+9DgLU+DX10DQCzQNkv1x
	/uElu+PXXB4yfhV3nKdNsnQifLRqRGaaaqvsuGlrkhTY26dYOz4XuLDvjlajzCOg738=
X-Gm-Gg: AZuq6aJKIPEVjKrXpPj6IpRwHhkftweHSBBsHSXzm4GGXW29b6SfIYOlGtFT8vS2E/+
	J3dbez7CM3HWUhw2RyaoaOc3sAZURAj+PCc7Nf0na1roYLnTm4KP0iofgkHXrDI1HnSeQQo9NTI
	8/P1lbd8a30BMmFHb1VUJ1k12+0tWfdEkUYSwOdQMIVxLGXluh1RtZxdLjKIj5NR523bYhrxUc5
	4JrVk3NHABNZHDGNyQPwo47uc204FcisXnFRpyBpf7BhIazcJPv62Inax6++BoWI1DhxF5D0up7
	aeOMV2HHhrAATDWjnyQt+Rxbl38oOuYQnbZQvtMCF+Qiw7mf146s1YxBR386g3S2FIdm/OClhcV
	ECbE1+9rK9mHxU7sC0I9YA8PlxdHSUUWP8bktB0jr+N/uS/9wV9TT5zocp66S+7wxGG1xUONBU4
	dhnvg/39MHhRKL8L4W6w==
X-Received: by 2002:a05:600c:3154:b0:47e:e57d:404 with SMTP id 5b1f17b1804b1-48069c2d565mr105610685e9.16.1769674812839;
        Thu, 29 Jan 2026 00:20:12 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-481a5d4b5ebsm5664165e9.2.2026.01.29.00.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 00:20:11 -0800 (PST)
Message-ID: <a1425ad5-8313-44f0-8ed6-af70be7e8e40@tuxon.dev>
Date: Thu, 29 Jan 2026 10:20:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.1.y-cip] thermal/drivers/renesas/rzg3s: Fix
 inverted reset logic in devm cleanup
To: ovidiu.panait.rb@renesas.com, cip-dev@lists.cip-project.org,
 pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba
References: <20260128125840.6801-1-ovidiu.panait.rb@renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260128125840.6801-1-ovidiu.panait.rb@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Jan 2026 08:20:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21787

Hi, Ovidiu,

On 1/28/26 14:58, Ovidiu Panait via lists.cip-project.org wrote:
> The devm reset callback that should undo the reset_control_deassert() done
> during probe is incorrectly calling reset_control_deassert() again,
> instead of reset_control_assert().
> 
> Fix this by calling reset_control_assert() and rename the callback
> function accordingly.
> 
> Fixes: 8b53b0bf10a3 ("thermal/drivers/renesas/rzg3s: Add thermal driver for the Renesas RZ/G3S SoC")
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Thank you for fixing this!

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

