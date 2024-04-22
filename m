Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAD0C4345F
	for <webhook@archiver.kernel.org>; Mon, 22 Apr 2024 04:43:59 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web10.11041.1713761033822709538
 for <cip-dev@lists.cip-project.org>;
 Sun, 21 Apr 2024 21:43:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GD1JHJ9V;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so4560432a12.3
        for <cip-dev@lists.cip-project.org>; Sun, 21 Apr 2024 21:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713761031; x=1714365831; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/kkTdRTc6DieSWRiXHkSMjxOrT0o0t3EENye0dtYJCg=;
        b=GD1JHJ9VoCv8tka7hFWnNLoMGJiY6IRDcKuZHAL8Q05UQCT3nnwdFJro0NQPtngn4y
         x3Qs0UlhSzjUoBAUCVozE7fKM/su+Q54bQ4+CcnHRNmoHIX0H85HsRyS3eh6ZdLWu0TX
         7gcTOCGcEGoa7EAgP2MZ8OeHxzYA0G0leGZioOw0DSej4yTj8pktrSSAPuOPb52qTjUV
         oCaRK6S6OrZdHmjh+qKi7MtivFHEKWAnDkKochp33ebiLTYDXUIbQt8YJ3P1oIjndFhw
         DNW8nbce3eUD4BGTgSq7of9WLYeTUuvPNt46orQtaAhU0JACwjaBarYZXZgUjJADFM+Y
         xvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713761031; x=1714365831;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kkTdRTc6DieSWRiXHkSMjxOrT0o0t3EENye0dtYJCg=;
        b=SXzbQJtZnbioLyOwStnnzzuRmZDlaJg7tMxYJt6Tkfkf11SVKg1A89F2WZVdZq/W0h
         SypYFNrLfpTAIDdyhJ3nskR2gRoB3EpkmmqB2l+iOV1hsA0J4sMarCtJgg40gcuBtIPc
         5kzptStlTfUaCuS+Ycq5vCfolJ/KeNqkbq4eFtnlfq9WO8VQ9zAiuUFM2kYY4VNJoOdn
         lO0viKUsw0hQIohCwpMUsh6DlZvXp6yaWt/YFFoqD9BywHoyt+yiKOrzzwejJXxTiWiP
         qdq0AT95cX+G5osk0TWTtMuGdRJT8txsUa1E1Q91tfgyVRiTuSySvDJ2ucmTzawpXpCh
         W9bg==
X-Forwarded-Encrypted: i=1; AJvYcCWLV+BoFmzieU2yoOPoNpo466fhrwJCSuGCk+6KJOSsNR5mnVP5tS/WlHqw1zBbfKJxLgFfejoUrgu9kSvt0cY7uojkOL8lDddvcUNBDw==
X-Gm-Message-State: AOJu0YywINJjrJ4zSfzgp02qzRFjsUwXdM2xcXlJyfgiGbx6+r2a85yK
	pV7xJzIiWLKv+3Q1QPbV2h4IxXd2lpcMGXkjoCBWD/kxpVRGzOBFFIwhmaH+xTU=
X-Google-Smtp-Source: AGHT+IHjQ09iSKC1JNTVyfWx/rQVqKKU0rhLmUqfa7csVy4s+aE1eceLtT8SqpWcFEtGgsR/NJ91NA==
X-Received: by 2002:a17:907:7247:b0:a55:b345:63ec with SMTP id ds7-20020a170907724700b00a55b34563ecmr1612105ejc.15.1713761031545;
        Sun, 21 Apr 2024 21:43:51 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id k15-20020a170906128f00b00a473a1fe089sm5261695ejb.1.2024.04.21.21.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 21:43:51 -0700 (PDT)
Message-ID: <a2e1c86f-9600-48b6-bebd-bd2a223a3530@tuxon.dev>
Date: Mon, 22 Apr 2024 07:43:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y-cip 17/53] clk: renesas: rzg2l: Add support for
 RZ/G3S PLL
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
 <20240419081742.3496709-18-claudiu.beznea.uj@bp.renesas.com>
 <ZiUgTsFF7W7+wvqW@duo.ucw.cz>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <ZiUgTsFF7W7+wvqW@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Apr 2024 04:43:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15719

Hi, Pavel,

On 21.04.2024 17:18, Pavel Machek wrote:
> Hi!
> 
>> +++ b/drivers/clk/renesas/rzg2l-cpg.c
>> @@ -714,11 +719,43 @@ static const struct clk_ops rzg2l_cpg_pll_ops = {
>> +static unsigned long rzg3s_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
>> +						   unsigned long parent_rate)
>> +{
> ...
>> +	val = readl(priv->base + GET_REG_SAMPLL_CLK1(pll_clk->conf));
>> +
>> +	pr = 1 << FIELD_GET(RZG3S_DIV_P, val);
>> +	/* Hardware interprets values higher than 8 as p = 16. */
>> +	if (pr > 8)
>> +		pr = 16;
> 
> What does "p" mean in the above comment. Should it say "pr"?

Yes, it should be "pr". I'll update it in upstream kernel.

Thank you,
Claudiu Beznea

> 
> Best regards,
> 							Pavel

