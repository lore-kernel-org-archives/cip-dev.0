Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19154.1795530717478544185
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2026 06:31:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=LtAPr6ux;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so39550595e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 24 Nov 2026 06:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1795530716; x=1796135516; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BWtG5lsM6e7FSH4LXnVB9wSe809foPtoao6D1nfnQbk=;
        b=LtAPr6uxFRgrRy4IuCkivbmoZ4S2WvjTE/y7XjrsapYTetY83CS+WPO6av5539XY9g
         oeYrP8mbBUPc+13Lm3s+urop0L3cBxakKg+89MK+Xix9wwzpOyvOPzWlpjexCn4ZfOaT
         BtjRDTf9IWy6jPX6SCMrkJWR0l/82KAuX4Rgb2N/80BHAEaPcXS6/GoI9nc/Z4jbtVSZ
         gL6+pytDZ8nn4flIIUt1rPw0vChJQIbGC+hpU6/iEFJ0er15aKI2XhYNPeQ9WUXhe3DZ
         V+z0CL+5BGYwC/NOGcx7K2xRXZgYHWnAu8x97BYNzH+gSQqy43drMXjJNgzM+HFRyVSs
         7XyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530716; x=1796135516;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BWtG5lsM6e7FSH4LXnVB9wSe809foPtoao6D1nfnQbk=;
        b=wv9Hxd7+gV7K/Eu58FoYKMWyQNrJww8TysBJXYyBeh1BhN5HhXgvbANU6BdscPuPtN
         Ra0smnAI72fWlD8aIJUSHbc5UDLS6N3EswYRWL2+l96hQNm63rgdEF2ynXGm1PZW/veq
         BN/T9/RRnvEbq9eXkEENtE+BoV3Z2QWIv+WvURgSdYNTROdzWlPZVcZXucY1j/QAuuXH
         K3nLpkyJIOmgviAINNN3zn1gWkfk+hm7Sk2x/Jxu5wPE/4GCy6Ak53SXpWLEYSRNAlKp
         v66hTjw23j05AnKDRdihkC3XLVqXHY+cmjLRLh64i1L1qFFnouk3fOxzWtEBCrb+6KYk
         FFUw==
X-Forwarded-Encrypted: i=1; AL+hErGxBl4W4s2djk3Dc8njLBy/U4Ee1Tr0lZRw/Xk44nMKYYFrxifhRYDGMFLCvr69eezkZ2uDWk3N@lists.cip-project.org
X-Gm-Message-State: APuU4Z9YlF4oEfQCkDryUOgRO8QUYhXMr7r3CMZWLaSbgEwLL+GGeFc/
	iNkMTKCN8CogPs39lQT2+EYDBCPhv4UUYVjUnV0XBndPPRvSj5wa4MUWus5IEmuFWm4=
X-Gm-Gg: AZFdTZfloaM/gfhI+pGrHxFVc1T7oqYDB2lOs0oVGztMElHj6jKdoU4PQfUYapPxMJB
	e7/V/9HYYOFjMM7amx9SVlh0nLStZUAD4NJLOBvwfYFAvYeZ3JVYIAUpkUosaJ3yyXqlUE5M0JJ
	nr54TaUyP+W31/O8vi2p5dnNk1jLGByQVUEFXjXjCwsCpWhgwJTdjLOYpiRmkNn3deH9B0nv13E
	EfNrntPrJHVr7sbHBlJ5Vl5lfdSbVRdOtBNxk7L3HLxNbjm36nuW47fdgr0aQxe0yZhYjJDeuIQ
	BhDew632QG7/+ZzJPBZW2TxFhVTxTpcjImaWRetZPJ44EUIlkNM+NBRXxm7sLbPHYpoDqoC8RMU
	7HsybLGe58rakO+GFXfLTtc+ECLDmAhH/dn/goI9FpKqO/5XPAoABaSehYLI61VuKevq2XFmO/s
	vYp3ySAa8+Q8wmmB3IA5iTaNWmi0xd3gyQOkdiTsEGhmIJSHOeSzYC7PExBLXUmsaobr0zhk8ZC
	MFOxLEHmyHk9M9Md0FnojiEwzLcd95FyPM4gMkqgpmPY9RL9Ib+YWQHJnVNojQ70fFowjHaxpPt
	gFIFlPCGKV3ujp88P+foNjf2kLSgclrl7m3u
X-Received: by 2002:a05:600c:1549:b0:4bb:6f45:2a77 with SMTP id 5b1f17b1804b1-4bb8880abf7mr292491775e9.11.1795530715536;
        Tue, 24 Nov 2026 06:31:55 -0800 (PST)
Return-Path: <claudiu.beznea@tuxon.dev>
Received: from [192.168.50.4] ([82.78.167.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906e4ce6sm241829075e9.4.2026.11.24.06.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 06:31:55 -0800 (PST)
Message-ID: <b3f35295-d9b7-4c21-9ebe-39131ea3e68d@tuxon.dev>
Date: Tue, 24 Nov 2026 16:31:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/69] i3c: Backport I3C support for
 Renesas RZ/G3S
To: Pavel Machek <pavel@nabladev.com>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
 <TY7PR01MB14818259F230784C9BEE2DDD7CD442@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <ea842856-92ca-4df1-a28e-1abf85d5c524@tuxon.dev>
 <awV6ffvCg6wqqpoi@duo.ucw.cz>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <awV6ffvCg6wqqpoi@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 24 Nov 2026 14:31:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25066



On 11/24/26 13:52, Pavel Machek wrote:
> Hi!
> 
>>>> Please provide your feedback.
>>>
>>> We require the following commitments:
>>> 510d2358c466bf6588034f0d3b2266eed2bc0a51 i3c: master: dw: stop hardcoding initial speed
>>
>> If there are no other comments on this series, would you like me to send it
>> as reply to this thread (with --in-reply-to git-send-email option) or
>> re-send the full series and add 510d2358c466 ("i3c: master: dw: stop
>> hardcoding initial speed") ?
> 
> If the 510d2358c466 can goes before or after the series, just submit
> it separately. Otherwise please start a new thread.


It applies cleanly on top of this series. I've submitted it separately: 
https://lore.kernel.org/cip-dev/20261124121540.2804633-1-claudiu.beznea@tuxon.dev/T/#u

Thank you,
Claudiu
