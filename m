Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BD8C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:28:30 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web11.18242.1713526106672274731
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:28:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Bv0eH2pe;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516ef30b16eso2325115e87.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526104; x=1714130904; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Y9JP35bv0y8jb/VeNEet4E4Ogx9WZiSdYZrFRiPKHA=;
        b=Bv0eH2pesgkyg1tfho+vkRQG5bd45my/f7YPhR/NjB/amLX9L/x7GXXDb0bo7HgzTj
         r+KIiLEWLl9BKoOVwmKbNm0MDLJYAfJvFvl1FhkvOW15GTJxS5zPB3lxdGHbygUpqsmt
         ExzNnHJQRFtUWSZ/4O50eW5DdLJO9mecZnK+dTJmOTNUraReGAvhnDw9WHlncQ65qzPC
         Cn9x1rF4p2sgx/PCnm1hTbw7g9aeQnOoy346vIgL36N3eFlmAassX6skU+aCOU7SkSbS
         7LFuTPC2yG/lHtxgmPk12kh170Cihk1ff23LhwKdUzQXjaHoQzLh8Q0t8gXYFXGbOOz5
         StOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526104; x=1714130904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Y9JP35bv0y8jb/VeNEet4E4Ogx9WZiSdYZrFRiPKHA=;
        b=f2thfiH+jEZXKPqO5Zr0VKQZbqE2W3k8jyxFGVJY86kRw+X/MzPePic+0cs77Wt9z4
         YEccHO2g9zatE2kAS3/Bx5d5pRZ6zxvnSa62v+hLUZtlQ35sGK63Cl6LoGqI8yvHhWFK
         DUBYYZnRNS9cCX5D3am7irvU8mz3XIW6mUNBZpWXp04AQhLhDRVASS+3CrzTRmrZW60r
         7FZebT+/iUN6gUFnSuGGUh+XaOkaHGrKiGf0koumpRLnjwiuQ+5EVWw+aQdFBzMyn/Uy
         20kcnh/kVlLf4hFuOG6XkaSZVeXWo3tuJrd0h1nkf8oudUfqSvwh1P/Xelf4J9nhkLj5
         cZyg==
X-Forwarded-Encrypted: i=1; AJvYcCU2lCcieA06nBOVZWaAwy+HQD3ith0n+K/X8jFn6XCGqhVa7PWDHYYp08aooAOpEgJScZwajowU91JWx92oEbZYQOHrxeQLmw25uqkMYg==
X-Gm-Message-State: AOJu0YyGH71RPy8++vPP1U/xd+Nlmi7D9kXx4W2VAn8DqaQmHCtLVwHt
	psZ06424w2t7JI+HPuzNFv+j9UU4KnomSHK8gYn3OBX7RFlo9pZNqin6zI1fdfs=
X-Google-Smtp-Source: AGHT+IHa6sEMT8Twt5fU3+vGc+qckOTH2TF7Uz630A20laqmrYpR0gI5nNHSEB++gTJodOWOGRZL1w==
X-Received: by 2002:a19:f51a:0:b0:516:d09b:cbd6 with SMTP id j26-20020a19f51a000000b00516d09bcbd6mr1002549lfb.15.1713526104326;
        Fri, 19 Apr 2024 04:28:24 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id m11-20020a1709060d8b00b00a525a18f748sm2070068eji.165.2024.04.19.04.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 04:28:23 -0700 (PDT)
Message-ID: <32c01a09-831b-4978-9bec-d93b04a1481b@tuxon.dev>
Date: Fri, 19 Apr 2024 14:28:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y-cip 00/53] Add initial support for the Renesas
 RZ/G3S SoC
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
 <ZiJCYMyD2rciVwq9@duo.ucw.cz>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <ZiJCYMyD2rciVwq9@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:28:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15650

Hi, Pavel,

On 19.04.2024 13:07, Pavel Machek wrote:
> Hi!
> 
>> This patch series adds initial support for The Renesas RZ/G3S (R9A08G045{S33})
>> SoC. The RZ/G3S device is a general-purpose microprocessor with a
>> single-core Arm® Cortex®-A55 (1.1GHz) and a dual-core Arm® Cortex®-M33 (250MHz),
>> perfect for an IOT gateway controller.
> 
> Ok, let me review this.
> 
> But parts of these are not in 6.1. I'd like to merge this no earlier
> than 5.10 changes.

I'll be posting the v6.1 version of this later this day.

Thank you,
Claudiu Beznea

> 
> Best regards,
> 								Pavel

