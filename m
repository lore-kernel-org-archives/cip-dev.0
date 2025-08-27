Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6507EC8303F
	for <webhook@archiver.kernel.org>; Wed, 27 Aug 2025 04:07:59 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web11.7174.1756267674856708991
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Aug 2025 21:07:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=TmjruV+X;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61c3360bbaeso5083953a12.1
        for <cip-dev@lists.cip-project.org>; Tue, 26 Aug 2025 21:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756267673; x=1756872473; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZwnLievb22SktmkAr8zkvrCBW0t118ThJoFE2W3mRXU=;
        b=TmjruV+XLaxBtkuuoLCsZsS63DqcocbQJf/EfILpKfvFsAjFSi7bdmqUYdY8sADSW5
         StPeElrwE1/hAcDki6KZJKW3kbhRNf781eMjagWAVSakKGRNV2fY7jRug8B6g+7GKLUa
         S5pWlP7yH+J4FnFPD+1EMkx09kGLhSzSa/FmEd45j0aASap4Lp+EZbjkjq+1y0naKelK
         Lh/Sz99d4QIAq/QE2vwNct088HXIqRZUlpSTi7u+plk43GBsLPPqVHiX5NJf1csd9+1O
         dOka3oXDpH3KTMHu2KKvQCIXzYUBlJp1pcQAV7Ho01caDl/e5UDD1lqtB5Fg7MKoq4Ge
         Cg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756267673; x=1756872473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwnLievb22SktmkAr8zkvrCBW0t118ThJoFE2W3mRXU=;
        b=J1ba9nGwC/gJytp6h3PjJN86mz7bnbhqpdqZDyDZ1HRJh0CpH/uYn4UfxL3MJHwKQP
         aGtsywLMV2bnpknWSJ9fGevyhNCthZXle5dD+eCn9p6jW2BSOKUC7zsHaN/XZmFucRg/
         gVE8guEx0BCLWjG5wVDeV2jsni0ouKqyWHqtz610RDbZW7X4yaxfBhjupL6XEbtuLQ10
         lOg908FLDgMMp8kiTDnu1Md7HDq8t72mMHrGrwHVaaezZMxJya5Zbw52dTgYLui0o2on
         Tpj6sP/e22zcKlaNRclpvWSn/EyaBpuYv9mA7rxGGpA6iAhmsjiZMMH1wCnXFY9zIlJc
         N1Og==
X-Gm-Message-State: AOJu0YwYNAVQ05HM1AldF2T2pG6AJECSlw08ukajjgQv1DJ/6Jeaipkm
	HFBIJtfe74d1dPqn/ZSS5+8A2AE2XQb4DPOpVsd/tM7awh384KPPiSuvmDiWysl89f8=
X-Gm-Gg: ASbGnctimBq7/j56ytNGVPK4OWx2Hqhzhvlbh2ib2sLkDDQ2xBfYOMeunaYuQ/nAZpX
	tgzFglF5yFZw+ZdVs0Mx9TWe0FjD6J6FZq7dypLtn9arb0A0/dEtPWYapP2Gn85e0FTo4+cwdlV
	v9U8HTKtGGqemxRyeAxs3qo6RMA/hpwZKO5f7Xt3uCJhWwZNStscRdRtDYUwXduskzUIgR0oO6N
	Zm7D8SERZi/0+G/wnS3rH01ZSq6CdwJR9m8nHfauw3kCIiVoXUWzbWSxJ2I85tHVc4LBRx6BGyW
	905fOsainUjdL8g462fR1qQoZS4cNvfHkDsQ6QBU61JIDBQu6orh63Z+DG4yaOeSTwD9WEdHKVA
	GZxAhZFbH8V47OPFXwPFq4CK+4CUInSTRWxjjlg8NLPUkvXGAIxrQKc0Peug12lZ+zmUdQXz7IH
	7Qh4BsVqFwBw==
X-Google-Smtp-Source: AGHT+IFLY0YH8NFRsRdtqnYOi0mmXbJt0qU168ySpGoeHzY1f+pChblXuXGjm0+xF7LDb6yeGiXLMA==
X-Received: by 2002:a05:6402:1e8e:b0:61c:3379:7915 with SMTP id 4fb4d7f45d1cf-61c33798213mr11177707a12.3.1756267673259;
        Tue, 26 Aug 2025 21:07:53 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:6103:4200:8b1:3f01:309c:b069? ([2a02:2f04:6103:4200:8b1:3f01:309c:b069])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c877af155sm3485290a12.49.2025.08.26.21.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 21:07:52 -0700 (PDT)
Message-ID: <1f2c8328-4bc6-41ae-b16f-a230dfa58a42@tuxon.dev>
Date: Wed, 27 Aug 2025 07:07:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.1.y-cip] arm64: dts: renesas: rzg3s-smarc-som:
 Fix Ethernet aliases
To: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de
Cc: cip-dev@lists.cip-project.org
References: <20250827035801.568246-1-claudiu.beznea.uj@bp.renesas.com>
 <185F839D71CDD190.28709@lists.cip-project.org>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <185F839D71CDD190.28709@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Aug 2025 04:07:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19969

Hi, CIP maintainers,

On 8/27/25 06:58, claudiu beznea via lists.cip-project.org wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> commit be4e4dd8a1994e5730dfdb8dfaf1f2418f8a199d upstream.

This commit is integrated in v6.12 CIP thus, there is no similar backport for v6.12.

Thank you,
Claudiu

> 
> Fix typos in the Ethernet aliases.  U-Boot uses the ethernetX (X={0, 1,
> ..., N}) aliases to update the DTB with the MAC addresses.  The
> ethernetX or ethX aliases are not used by the Linux RAVB driver.
> 
> Fixes: 932ff0c802c6 ("arm64: dts: renesas: rzg3s-smarc-som: Enable the Ethernet interfaces")
> Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://lore.kernel.org/r/20240328065738.3049316-1-claudiu.beznea.uj@bp.renesas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>   arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> index 3f050a28f2a7..3d707c9c6e46 100644
> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> @@ -20,8 +20,8 @@ aliases {
>   #if SW_CONFIG3 == SW_OFF
>   		mmc2 = &sdhi2;
>   #else
> -		eth0 = &eth0;
> -		eth1 = &eth1;
> +		ethernet0 = &eth0;
> +		ethernet1 = &eth1;
>   #endif
>   	};
>   
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19968): https://lists.cip-project.org/g/cip-dev/message/19968
> Mute This Topic: https://lists.cip-project.org/mt/114912638/8377987
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [claudiu.beznea@tuxon.dev]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


