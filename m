Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E3CC25B76
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 13:19:47 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web11.9381.1718111979605692397
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Jun 2024 06:19:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=k3fJjjxb;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.177, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebdfe261f9so38433851fa.1
        for <cip-dev@lists.cip-project.org>; Tue, 11 Jun 2024 06:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1718111978; x=1718716778; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VoBhEoycQJiR6hlVbAlF1fRqLCa55t0pQ9scRnodupc=;
        b=k3fJjjxb9PcL5UKJVl+BbCrPt+WEg1VgJLlMtEjupwmiNlvbAoXwvBAol6eDpW8lXt
         2fP4Cm6ao+PIpXfDWZDj7xhgNKdIJz06ofQ/U2lgWQYpWj3veYBxXU5994L6AMG3PYRb
         LQfHqxoLQbUPY6PAHz0pNG02ZQAKFb+i1QyxpYxLewrgrXiEX4rGWfsVSTdJlhan1qZw
         CX6uD29y50o/zAQHehSuaWn+3jz4xLAuovTEkzotAi2vTS+I//5/3+H1MV75Ee95QBlk
         61rKdyz7jFyAcWyDufvWDPjv9ddXnabeDUjfBHK0BDeKW3x6gAsSU4GkISst9N66F9CX
         jLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718111978; x=1718716778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VoBhEoycQJiR6hlVbAlF1fRqLCa55t0pQ9scRnodupc=;
        b=EkZ44/G7Pim+isq6vMIbwT03/YxvKXlcxcu8G+2nYlS9hAFjWIgvaYOBs1wBC0Y5o0
         rMHttW1437cKgGJWjLzaQcGw4zmwg9R4kNZ/BfPoZhCw19RpWRPVQHSUVdbFC5KlQhFf
         XrE3RH3nim1tw8SWESPoGjjf8ieAYd1100YB4UsMuBtJoaALt2Fe6aWL5V4KZNgiyy6U
         cwCjXCuDdizztgJ8i28KzMAgzPU7vH75YetiAjxmgzO65RKOGZ8zXIXu0L0NtNLwTJh1
         Jo2yknRZRW0z+c3yUSx45QuelP7qMRDKeiyyXr67LsRs7lhtVUKdncGCS6UrrqkYzKPw
         z8PA==
X-Forwarded-Encrypted: i=1; AJvYcCVVBGD6BouO2T+x3cVeJfkXjvSj7BA4ZrlTfIEYJ37v0bBu3Fj0alaS6YByXizcD4AFkp+BxV3lQRn9XyiObTodHN5RbBZYQOoxpWMq3g==
X-Gm-Message-State: AOJu0Yztf8qr4G2KsqOKIlhjI68dXaIgpW6+ioXG/l6tDMfPHAocMtWf
	u9YNFBugKDipS+J1YMllI2Oxh8DbW4QZLR08oVy/t0y9CEs/6JW5pkvmUqYTKtM=
X-Google-Smtp-Source: AGHT+IGYyJjzq/kdOzFoZp3tn9Ypxnr+1VZsXtmdzKArWJKRRTy1v3igfTPGSjS8yOtkFVUekOF0Gg==
X-Received: by 2002:a2e:890d:0:b0:2ea:904e:481c with SMTP id 38308e7fff4ca-2eadcea97e0mr98977521fa.53.1718111977675;
        Tue, 11 Jun 2024 06:19:37 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805c9662sm757168866b.51.2024.06.11.06.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 06:19:36 -0700 (PDT)
Message-ID: <1f5796a1-0f6a-47fe-a870-d57a4771d809@tuxon.dev>
Date: Tue, 11 Jun 2024 16:19:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y-cip 00/19] Add suspend to RAM support for pin and
 IA55 IRQ controllers
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
References: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
 <ZmdvgdE0A0f/go/b@duo.ucw.cz>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <ZmdvgdE0A0f/go/b@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jun 2024 13:19:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16193

Hi, Pavel,

On 11.06.2024 00:26, Pavel Machek wrote:
> Hi!
> 
>> Series adds suspend to RAM support for PIN and IA55 IRQ controller.
>> Support is needed for RZ/G3S SoC.
>>
>> Along with it pin controller and IA55 interrupt controller drivers
>> were updated with enhancements.
>>
>> Series is split as follows:
>> - patch 01:      add clock and reset support for IA55 IRQ controller on
>>                  RZ/G3S
>> - patches 02-08: update the pin controller driver with fixes for spurious
>>                  interrupts when pin controller interrupt lines are routed
>>                  to IA55 IRQ controller
>> - patch 09:      add suspend to RAM support for pinctrl driver
>> - patch 10:      add suspend to RAM support for IA55 IRQ controler
>> - patches 11-14: documentation patches
>> - patches 15-19: update the device tree with IA55, gpio keys, PSCI
>>                  support
> 
> Thanks for the series. It looks pretty similar to 6.1 version.
> 
> I noticed "pinctrl: renesas: rzg2l: Select GPIOLIB_IRQCHIP and
> IRQ_DOMAIN_HIERARCHY" is missing from this version, should we have it,
> too?

This is already integrated in v5.10.y-cip:

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/drivers/pinctrl/renesas/Kconfig?h=linux-5.10.y-cip&id=c51f1776f4a935aa01c96286f93553c46e252daf

Thank you,
Claudiu Beznea

> 
> I can apply it if it passes testing and if there are no other
> comments.
> 
> Thanks and best regards,
> 								Pavel

