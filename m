Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E13CFD313
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 13:21:18 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16437.1763990470582463267
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 05:21:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GeYijLt3;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso41733425e9.0
        for <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 05:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763990469; x=1764595269; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=msfnT0YkHfsJ+0G4y9Sab4MOt0QwhfzC61JysRBbIRE=;
        b=GeYijLt3TW7uC0S9FqLJjPaX0rf2hh3pnI8FF6m48100Uw82pktJ9Nga3bss1POxSd
         jGuEBNqEVw8M6SyXn5atIUY/7pZCdQWbmcOstop1q29Lm6vbu1Up6DR4kI9Oae7KWb90
         zdZsCANjm8p7oURMLu3WZ1ht0qk4ZXwCI9A65N/geikEVhIVXKLCRghFgmKEITZ0Srqx
         d+XUx6u8F/CNrk4A5YbdxNBlvzjd7Kv8PNlppGySD07MIoPAH3dj6pH1262+O5HLbduD
         nwD4tquqqFeOG+zha5TrsezJ5GPteLx6opHGeUXhICuJYU8AFxkkRSaswlEk9VC0KpDW
         6XIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763990469; x=1764595269;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=msfnT0YkHfsJ+0G4y9Sab4MOt0QwhfzC61JysRBbIRE=;
        b=kQ1R2nM/sFgfZ5h2SZiVg18ul7tNtXZWEkkBIn3y5+T5RFowhWBFw/vDAkV6fCNRU3
         MjtNIqQVq/FrZht2Y87DQqBe5J/fbj2xc6r1GhzNLOuk8m42dJkfOK0KNuRduBy3ciNh
         Yxfb/05jBSzfA+JydRBa2zCa766bkCKamMjW6p2cUAf1CZPWqUoKqGUu6DChNR48BQA+
         MldhZxk0I6nf9L7svlnp0hWWhixVztqwvhofItKT+vIJfW7EuWditReSU4eFtTgsz2rT
         /Uxr8PlFO6B3zjiiTEgswKwINwy/qEFIfp5N2aF45j6T0XyFjWYu9H3Mje4G7winbADk
         cyNA==
X-Forwarded-Encrypted: i=1; AJvYcCWwAcjvrj2KNEAIj+jGAJGoAxL2WN+feEUZOT3CIV7pi1FHKP4LD6T4trI50ox4u0ImAf+Ery9p@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx3FrJjVY1ckUdRrGd9krlLTt/hJHcJm/72H5lQd3fBar5m7Eys
	lt8gx/bmMgkKdFRasZLwYUxo5prHb1Wgi/MBXI4xAss7p6Fz3cI5KmW1kZ2ywfRqqvg=
X-Gm-Gg: ASbGncsz21QZ9GbIDn67z85Zl3L+4trST1r1sPtcUYJjeH9GrMgtFpff9Y3A+FMp8b8
	sBSYL8t5Hs8LYm8daRb9ZrI4ridD8J9jA+QZRGKKoC0RCRqwBEQP6lSUd2ORz7YRP5dJGxRC55z
	BHQ5U4/kh7DRotSBmJolrwQOTZ0e2n10c39JCCCSM8WXOx+kO+tpv+umtp7aJKf5YDfpH8MhBst
	OR0ZIw2JQE3Aa+UkTM2/xFn+PdjOdo+YsUA+94RuPTUdctVYuKI+UzvCfZAywfKBwfjLz1Cci43
	syuytAD7Z22R42BmblR7sYTRwsOMf0pXvPuvBsPDJVrya7WQsO62mNJ4PrudZffSGfDODWMjcai
	4UIyFnTEjyCmY5cdV27vw5jCup5+aHCwEAL2YpBnJ1ru6fHBFHUYv0K9vWLnSztkJWdeXp/CTc+
	6on/08KR190fZM/z6jhxo=
X-Google-Smtp-Source: AGHT+IH9aV0HqAOVZ+TnPfjGGuQk5iPiTazy05vnKnhS5lWaQ49mwB2o+xyHMdspno7UVaFKqjmYFg==
X-Received: by 2002:a05:600c:3595:b0:477:755b:5587 with SMTP id 5b1f17b1804b1-477c0184b34mr116215735e9.8.1763990468650;
        Mon, 24 Nov 2025 05:21:08 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf216ddasm193111205e9.0.2025.11.24.05.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 05:21:08 -0800 (PST)
Message-ID: <33863cee-c6ab-4b3d-9bcf-82ef2c8b597c@tuxon.dev>
Date: Mon, 24 Nov 2025 15:21:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/22] RZ/{G2L, G2LC, G2UL, G3S,
 Five, V2L}: Backport MSTOP support
To: Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
 <aQz1pgHaEQNgfdKa@duo.ucw.cz> <1875B18477989308.416970@lists.cip-project.org>
 <e4137de7-ef22-41ce-b2b5-a1d2762eeb4b@tuxon.dev>
 <aSBslxvWFIij/zGh@duo.ucw.cz>
 <111077d3-10ee-4c95-926c-e81f4c622c37@tuxon.dev>
 <TY3PR01MB113467C7D29D1ACED3381BDB386D3A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <df838a73-788b-4b4d-8c91-e2bbcc827cc0@tuxon.dev>
 <aSQvAIPPOVe7dAuF@duo.ucw.cz>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <aSQvAIPPOVe7dAuF@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 13:21:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20714

Hi, Pavel,

On 11/24/25 12:10, Pavel Machek wrote:
> Hi!
> 
>>>>>> I'm going to send a PoC patch for the media drivers used by the
>>>>>> RZ/{G2L, G2LC, G2UL, V2L} SoCs in reply to this thread. Please let me
>>>>>> know how do you consider this approach.
>>>>>
>>>>> I'll take a look, but if mainline is happy, likely I'll be happy, too.
>>>>
>>>> In mainline the problem is already fixed by patches 01-11 from this series.
>>>> The PoC patch that I sent is intended for CIP kernels only, and, along with it, all the other drivers
>>>> used by the RZ/{G2L, G2LC, G2UL, G3S, Five, V2L} SoCs will have to be patched with something similar.
>>>
>>>
>>> What to do with Mali driver used in RZ/{G2L, G2LC, V2L} ? Mali driver is used by other vendors as well.
>>> Maybe special handling??
>>
>> DT nodes for the Mali IP on RZ/{G2L, G2LC, V2L} have Renesas compatibles.
>> Taking into account these compatibles, the code could be adjusted to be
>> executed only for the Renesas SoCs.
> 
> Ok, so we have two solutions:
> 
> 1) one requires small changes to unrelated drivers in the tree
> 
> 2) one that is only touching Renesas code, but is not mainline, an is
> not going mainline
> 
> Neither is good. I don't believe there's another possibility?

I don't know another one at the moment, too.

> 
> I'd still like to know how much power this saves, and if we really
> need to have this in 5.10.

I'll ask internal HW team about it and. In parallel, I'll try on my side to
check the exposed board rails to see if there is any diff in terms of power
consumption w/ and w/o this feature.

> 
> It looks to me like 1) is less bad, and we may have to live with it,
> but I'd like to get confirmation from other stakeholders at this
> point.I t may be best discussed at thursday's IRC meeting. (Do you
> want to join? :-) ).

I'll be there.

Thank you,
Claudiu

