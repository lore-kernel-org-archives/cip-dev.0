Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AA6FEA82E
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 08:35:35 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17935.1774427730993803708
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Mar 2026 01:35:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Rwcyn5tP;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486ff201041so42302405e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2026 01:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1774427729; x=1775032529; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RCtDJu/kAq530BQvFbzb4xnmE1YMXOgf3umy/Sh5bbw=;
        b=Rwcyn5tPMtDtSkC8dMbfH6Bx9fECpATuJttBvDwEtJyJe5QRUGrY2DBLNF7Farv9kP
         3yjpO4sESbBMlckzOA3QJHhSKtFgGNs262Skd4WEhDyG+wcJznQFSiIt0U0jsMv1uY/+
         r/CoWESWXbyByoJ5fia/8IyBwS6DgrM0at7eB81KttPNbtWWSYrmmckgRxZs36hwNNh6
         a+erOh/KAvrw9v5eYs8MAHLE8pjNOCFWmXUX+Fig5fY5cK+4SbR9n9r7IJUZF9U2KrSI
         UQKFXBdWRPRP4fsqyjCFB4DQogHdZhQIwDlPiQ4aAFekr3X+FRPIIXCHPGDUdf0oD8sG
         qX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774427729; x=1775032529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCtDJu/kAq530BQvFbzb4xnmE1YMXOgf3umy/Sh5bbw=;
        b=HUqYeYogUmIUluMo7gY0y/zb/fe4WCHDncsrqBjvoWW4BiqXKagud2XQHTAoOtBRzt
         H4jhgv8cHR75SZjD8VqBfW83E8gcg3xZt5mqNdjkRg5/oyRvfMGjJP+4Mueb1i0OkNmw
         2yEeKfURxfBg52oaQJMnTzixSUvle1baiOf+d6H5m3bzvRC9DSJC+RLhlSFXaN5sonmU
         CCfP9WOU5OiysWPmVUvq6SRwTrvDlp42EkwTMyxgtc2QB7+/8YCZuo2st8fnKOtfeg7n
         NFqiNt0VqWiuk9xHHQq8MZOk9Gj/5xdXfSKlmutzDVeLbier3Zl8Vu13Q547xDWcWomq
         JOZg==
X-Forwarded-Encrypted: i=1; AJvYcCVSzj0ORnDDv+t8Bjjj57QZyCbA5CDNInGVpI3LZynkF8DCgei/nIMNYzcnYLzBoDx3jJADl9EB@lists.cip-project.org
X-Gm-Message-State: AOJu0YyQ38v9gVc3Ysc0Q3/2KiBLT8oIW8s6nKItKLI2cN7zNlpWw5Tt
	F3WR/A9rSSpiBtyqNBLpgHSTh7KqaucTUGwhuytLaU1cBxFeQFrVCZCnwd9YOY9eo7I=
X-Gm-Gg: ATEYQzxEc1nCsaa/Gu1651EMXFNAn7g9ODhkWm9IwUW668zTmihjWJM2wjF+UKL8aMR
	JMb+1p0Q7NQfvJrEcacbeyUri6b/kvX3HG3uJJycuBd6EDvS1v0IjuKkUJfO4dJkZv4riUufWqM
	IjTeyYG4utHYXUiz8/iiR0ztlC+0DFyBSxUshpfUOcGGgIc15/mXKQCwl6ciG/UIjrdx6FMJ+sY
	5TITd5JbXembFgK8213qQACY29AXyFmfLd1qy8CDHQcE5Z33lJer90VgRrgTBluRMjM0X8LU2ny
	TxunprkCt8pjzw7PMABZnm/vPlftfRFB/eE/6f2EXzCgd+pMSNuK8cj2CR3x60yviniBNGH6AIy
	RcdV3nH+CcxZoOtIeK22BIvSdlq3YnP8n+cFncO6tQAXuCl6SxgGY5oEMq30j1hN7UxivbKNYCu
	cYVpNRh8onaTIIU/nSF7OIml3IkfRR0xY=
X-Received: by 2002:a05:600c:4447:b0:485:17a7:b9c7 with SMTP id 5b1f17b1804b1-48715fd4d49mr34443065e9.10.1774427729121;
        Wed, 25 Mar 2026 01:35:29 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871a937bdfsm45736255e9.9.2026.03.25.01.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 01:35:28 -0700 (PDT)
Message-ID: <9a8674d5-0298-4c4a-a3a1-38a702e6cccd@tuxon.dev>
Date: Wed, 25 Mar 2026 10:35:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y-cip 12/28] reset: make shared pulsed reset controls
 re-triggerable
To: Pavel Machek <pavel@nabladev.com>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
 <20260311110357.1938200-13-claudiu.beznea.uj@bp.renesas.com>
 <acJbYxKGAB4lxGQr@duo.ucw.cz>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <acJbYxKGAB4lxGQr@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2026 08:35:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22557

Hi, Pavel,

On 3/24/26 11:37, Pavel Machek wrote:
> Hi!
> 
>> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
>> index 662867435fbe..4d1cd09096f5 100644
>> --- a/drivers/reset/core.c
>> +++ b/drivers/reset/core.c
>> @@ -325,6 +358,46 @@ int reset_control_reset(struct reset_control *rstc)
>>   }
>>   EXPORT_SYMBOL_GPL(reset_control_reset);
>>   
>> +/**
>> + * reset_control_rearm - allow shared reset line to be re-triggered"

I'll send an upstream patch for it.

Thank you for your review,
Claudiu

