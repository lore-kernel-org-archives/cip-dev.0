Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2709C02181
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 07:44:00 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web10.6730.1737704624979603859
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jan 2025 23:43:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=CDlcy7f5;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa6a92f863cso375631466b.1
        for <cip-dev@lists.cip-project.org>; Thu, 23 Jan 2025 23:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737704623; x=1738309423; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fZKRvDVQM9HlxYWaX0VTCLszctaSPhpXrUBNc+KQSg=;
        b=CDlcy7f5O4Iu0aUvPlkuYZB80lD3so/dU8JinAB/9gypsNNu4xS0srXRDwV1d2bVFT
         8AIfegc8ykbwsGx9sdfFtydDz43KLo1x6deRQKLq6+5Eqob+8ZpfpeV5Un6jjlsMhIrP
         w2rr6/9sfcHE8kpOGwMRW2JxyKAlG4jza+NmdDyG1F3KRF3dARXVQOeU4Df/KiaM2LmR
         uP0yadujXqS+IH51LNvjXkWsR/rm+bIotUdv4UMpKwqJkTNj7xbmXzDFoXTXCr899H8H
         XHIASLa6h+JUaL1bQTjH3vrdZNiUFhwsm0cIA0DzxOWT5JYHrA6Y7itnHneJiSlqqvba
         WfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737704623; x=1738309423;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fZKRvDVQM9HlxYWaX0VTCLszctaSPhpXrUBNc+KQSg=;
        b=OBK6qAq+nGo49YGFOfxKhzGgXswFUM3KKrUMoel9jyaWEaSUF5i0KVWmfgZsmf8/w5
         ZvvLx8CmNviUBQVLjQAwv+6T2/fpxaSMOGFIyMkZ3F0gHx/MRy5jNGLS5WH7a6R7Bj//
         ogGSg8XhJhtMs5gbG/WUFqMAiLp7SadEMX8PHuDt4OUz5fZtR7YL2tYLDFm0N2KMvroE
         DG6I1xiMxdQu2f9ZztvPYLLGx+KzEYGTdtbaYMPVofg4UesN2/CEk7bwEXmJggeQbKY7
         EBZAzJ3rwwcN1FuygBAZFgismB6KlyZ1ILRc7ej8oXtJ5FOR+eVoUksdpJqeP/4lP30q
         71kg==
X-Gm-Message-State: AOJu0YziUs74Q/a6hQubHDnZ8LCYfua+jgA4LpaUve3xYPkWNUOZ1Uv9
	OBbe4U3YzTt7GVCa5iBzYEn5kfRe3B2mewqk27WgkCoFrjG1Uw2j/2Kv3JMiOethaCnfWf8i8z5
	3
X-Gm-Gg: ASbGncsfV8PrxqISD6X5ILlsi0g4/e3265SsjOokt86PEcvvC0yrZA1/T5ODMBAYse1
	dmZfl7hS65f1m62JmMUue2VP526T6WkRKW8QNWknVkl+4noclV4r9JNsIjjAwhsSdQYvzIV6cSW
	n6wT1z8m6mEfoqsJO/yEOgDkIOQLti8IkRgbfn4kfqM4UwVLw89c3yE+b6DpQh8CJ4ekzRmed6Z
	E1i5H1lNodVVB6o0E0wpvGvQG9eN/0S70HeHV6Dua5WGEXby1pCLfcBYwAKihWkNlQXTwuYuWkG
	qtJ6UYlNaZBh
X-Google-Smtp-Source: AGHT+IFV+qFCVdpiCbi/m+uXEcpllWFJORgz4FDxZW99IJEDFDOmaGxq3Fz9ypKNmF8JZSl6voLGYg==
X-Received: by 2002:a17:906:c781:b0:ab6:4fa6:71e2 with SMTP id a640c23a62f3a-ab64fa6724amr791131566b.22.1737704623261;
        Thu, 23 Jan 2025 23:43:43 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e62970sm84526666b.44.2025.01.23.23.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 23:43:42 -0800 (PST)
Message-ID: <48c70eef-f489-49f8-a7e7-02fc24a51913@tuxon.dev>
Date: Fri, 24 Jan 2025 09:43:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH v6.1.y-cip 01/14] clk: Add Sunplus SP7021 clock
 driver
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
 <20250122115120.2885015-2-claudiu.beznea.uj@bp.renesas.com>
 <OS0PR01MB6388CDA2AEED05007496E31892E02@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <00ac7a78-c715-4027-864f-15433cafa129@tuxon.dev>
 <Z5Jhe0daf2R/nH0j@duo.ucw.cz>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <Z5Jhe0daf2R/nH0j@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 07:44:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17615

Hi, Pavel,

On 23.01.2025 17:34, Pavel Machek wrote:
> Hi!
> 
>>> I understand that the SP7021 driver itself is unrelated to Renesas SoCs or this patch series.
>>> However, would you consider applying the patch as is without deleting the driver?
>>
>> Sure!
> 
> That would be one option. Another would be to apply just the
> include/linux/clk-provider.h with different title/changelog,
> explaining this adds only generic function and where it is originally
> from.

I'll go with this.

Thank you,
Claudiu

> 
> Best regards,
> 								Pavel


