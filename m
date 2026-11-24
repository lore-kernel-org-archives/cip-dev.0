Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16273.1795520870500087079
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2026 03:47:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KXdISV6L;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a210470b49so43224865e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 24 Nov 2026 03:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1795520869; x=1796125669; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RCut23zoXNKQZmPuPdkWRCMWbnxFBmaOGaAYIoyZf7c=;
        b=KXdISV6LpjB9gcvfTs8PuBaykorslF/F4p50/2kIVGW8gKPuQqNFWy4K2y0E7Mbmws
         Sx03VeYJRLUC8a13lXFdQ4DWDEG4SJdYpsBdTtd04vtbLtnd0Qng5ZGs4BXPe9g0iUaG
         aFYLv1ZRqYH8sbirDU8NbpaeLNX6cqjev1x5yOxRyF3Ka8eUMnzHJ9cb7rWSlhePfyaB
         87/ohptoO8wXfWFkbnnu9Dszf7tzVkQT9r3jtbY7XNx6kHO72I9irv44IS+IwsuNkdq6
         qk71g2aFdStakYjlVcy4cD4QR4YvqxGrjCqELmzWhWA8vvCL+yNVMO7sJFkljuQuT/iP
         S4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795520869; x=1796125669;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RCut23zoXNKQZmPuPdkWRCMWbnxFBmaOGaAYIoyZf7c=;
        b=HnfvwWzaOJiCiBycEs4a0xLBtnDKjkD75AHEpmR7sgauq3lWHXchY33R06culHqXNR
         tzrI1rcBEGM1w6YZyZja82Q89lnrv/fqI6G/l77yNxlXcFVKONMzPGQyymK+iO63PYIE
         OXTJbnd5CAGhWzSVqufzw4lnH02f9Jnth+CBPR6xb0zBqJ0iJFZM5UJj/uvEjsc3bnIz
         tbuWIwkTxPiUCBcFRsbh6szhmS49LLT6XelD3B6cFWCeO5hMmq+KqiHH+uyDkbfHSU25
         vifeOlNPvy5XS4mTM2a9CeJknCcUp/yz8fCfwO5ULLmlSVARSAtLhXRMvb5SyAQUxmyv
         vyhg==
X-Gm-Message-State: APuU4Z84W0cj/j+NharQfc8io6T4uemUWThrLYjzliIOAdpAtO3f8WYU
	9+umeq+S93JLX9gKBOA5mALM0i1jkhX3ew7FQFQq2yKDe5wCU/A9sh03d3181/AysEk=
X-Gm-Gg: AZFdTZcdNf7SFVLFHPncAXXaM0HCwcQwwLNpriHOj3Q7CTLBKCqbdi13PAq9VUhF3Zg
	s7RAMrJiso3WjbjoukAxz3i1yFT+c2la+QjI3riXVXBT7qEPxKl2y8XYZA380wZdKbkhT01QyLw
	UnCwTZiyb+laMTg8nkROd4slP4UVTd65xswyOsjY8BBxLLLIAiE+GF5i6iQ158DIQ1ZsU7Qe1dH
	NEIiQlrZkFpSxSIUGr3ddBd9hLE/dfXaJfAxkjK1h2rx4Y7Mz6tthK5xS9CReg8qpt/m0BB/9XV
	Ne1Eg8iIyvJDYaWUa+An9F4kOwvaFaHPUUt8hGU0KgNgzXCjtA5f+fCy1sNlcDqQbjzUvbFz3JS
	YeSiB/w2eWcFiJAP1ALVNovTtm9slzi9XB7mlnLcr9HVCls/f4Upv3OTV8rEFOT9va7keVujQ23
	aO18Chsp92QgItsZIyer/oAnQBFOjDDgVqyXukrHe5tsleI7VcEloyMAQrQ+SbLtq5JQq+KplQt
	YAwEAalr2IJXRUqQJYUoFtjMe0pju0nQLIbCEPd6qL0PF2gIgtmr//0soeJm8JhoeUo72lnPNTR
	eQgBeMHrKD3uEFvAXYtFbcd0iThl855lKwmg
X-Received: by 2002:a05:600c:5249:b0:4bb:665c:a078 with SMTP id 5b1f17b1804b1-4bb8893a89bmr290141115e9.28.1795520868082;
        Tue, 24 Nov 2026 03:47:48 -0800 (PST)
Return-Path: <claudiu.beznea@tuxon.dev>
Received: from [192.168.50.4] ([82.78.167.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b3a7sm484962705e9.3.2026.11.24.03.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 03:47:47 -0800 (PST)
Message-ID: <ea842856-92ca-4df1-a28e-1abf85d5c524@tuxon.dev>
Date: Tue, 24 Nov 2026 13:47:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/69] i3c: Backport I3C support for
 Renesas RZ/G3S
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
 <TY7PR01MB14818259F230784C9BEE2DDD7CD442@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY7PR01MB14818259F230784C9BEE2DDD7CD442@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 24 Nov 2026 11:47:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25063
Content-Type: text/plain; charset="utf-8"; format="flowed"

Hi, Iwamatsu-san,

On 11/24/26 04:32, Nobuhiro Iwamatsu via cip-dev wrote:
> Hi Claudiu,
> 
> Thanks for your patches.
> 
>> -----Original Message-----
>> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>> Sent: Tuesday, November 17, 2026 8:45 PM
>> To: iwamatsu nobuhiro(岩松 信洋 □ＤＩＴＣ○ＣＰＴ)
>> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@nabladev.com
>> Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org
>> Subject: [PATCH 5.10.y-cip 00/69] i3c: Backport I3C support for Renesas
>> RZ/G3S
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Hi,
>>
>> Series backports the I3C support for the Renesas RZ/G3S. Along with it 2 client
>> drivers were backported, tmp108 and lm75, in a similar way it was done for
>> v6.1 [1] and v6.12 CIPs [2].
>>
>> Please provide your feedback.
> 
> We require the following commitments:
> 510d2358c466bf6588034f0d3b2266eed2bc0a51 i3c: master: dw: stop hardcoding initial speed

If there are no other comments on this series, would you like me to send it as 
reply to this thread (with --in-reply-to git-send-email option) or re-send the 
full series and add 510d2358c466 ("i3c: master: dw: stop hardcoding initial 
speed") ?

Thank you for your review,
Claudiu
