Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9D3CFA466
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 08:03:26 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11750.1763971405621005730
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 00:03:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=VCBCTaLa;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477563e28a3so26636605e9.1
        for <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 00:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763971404; x=1764576204; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vwRDAJPTgzgjJMnLu15BMrsgpoPH+wCrWJjS8D9xIVE=;
        b=VCBCTaLazZOcDU4a4wxV5D+q4tUNay4+ZE7L5pbB32pIcIgx2GShVRytUbbVNkXuga
         Cfw1yEk6ZoI6Snk5rnooxmbHv+NFK7W+BKhvoLxPztxv91nvVu/BWFteYTtiBHmpGzec
         feySF57ds5RB2YN+bqu69mNBZb9usLt4e4uVOYIfGMuZnWcAqdh9wClNU3vWYIMvpJRs
         Q8EYWl5eie6u7HjgPIdHPHA/15bp1bnr64x6kAjV6ti4MDFjTU1xC2beAFgX6zjZkhLV
         GG/93ODLiXmkkWBxgdGNc+bsv+HjeGkpWlBrz5hWWhQI7n/0HdXfbQTpmPjXG7JeAyyh
         HkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763971404; x=1764576204;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vwRDAJPTgzgjJMnLu15BMrsgpoPH+wCrWJjS8D9xIVE=;
        b=IQXCbAvIvhfqa2JPeBjxth1jrO7A5y+SR9rMtvJBMHkkAlVxJt/LJsmjNmzKMJM3HT
         aC/gNwEFWNu27ivoN+cEZW6snfyz/xZNslqt7SrbZQBfTkH6cnmLcKdt59N0vM005kMk
         e9gxDYzQBtxft/4vA+Btrwd2OZ38R/fLI5BSXvGfMFSY36PYXCTSWu7TVRKQyR5pEDBJ
         JP3N2tRM5cXx6RC/wqQj2IJGYsB+9A4cQbxniGGcj2pbtJImbI4SAQn9qpfFz5Xl9HII
         +FzqTUesw4w7qa6OzFDrdrSSnP+mAJSborAw5vMPJvpwkCoy+CrcomDAIIXRnonC8bq7
         YPZA==
X-Forwarded-Encrypted: i=1; AJvYcCV6vIGxNcM9CJeAKR6J+y5LAjWw6W2NOTTlKdCxsTij25D0x3WIUe3aQtLZYbuWDRvHMrS2l6dV@lists.cip-project.org
X-Gm-Message-State: AOJu0YyteUno53ANolk+4xa642QWYC6qWTpjv6CuqXfFCSZzje82JTE8
	uG0VBa/U32bJOL/arFyQvKiVPl/85TnMeasc6daehE34D6Vxrcy/viM/CiTxRSJVv7U=
X-Gm-Gg: ASbGncsrUoPXsRMKrQ7btM1DHdOhrF4UUDaIyPJvT+c2nt7I7NB+eXEkc6IMJSpxOQa
	xN6Pd2XC6EM56DP3lyH4s00EDVwd2Op30hWUQOTZUCplfXlf/NgvlhWTOVYMDbxvOGCIf3ivIp5
	xFHvyw+GKvFuY/gqIdQy+iuRr4RoKDuWewHLjb0FIPAfHwU/W0Yf212vKC00VhcyXSI9WQ8nTlH
	ajg93fyOME4uDB7Niqz9BwnZpkr+XvQf5t18cxmtaGW7+YcgurmFimzVpr1HFwtWVl75xWRXM6Z
	NLXXx5I7LT5sYI4DPgTNyUy9GSDJHjuIFneUTlCx1HNk8ZvuroxznsmJtHNdKPzRMZf8eQCg+sL
	zaBqmEHKDIYfGjKtXrynaPLz1IXNn715L6NBSWw/6dY7jtbM8rbcPCvJq8Jk8d3IEA49bGs/b8N
	E30Mto6WhzdKCUu9lKhuE=
X-Google-Smtp-Source: AGHT+IG2MndedfZmPjyHDzjg0YQgootPui3PO+XzNWmKjytEBilS8+WSIvDk/qvnAgs/bDz2BezNfg==
X-Received: by 2002:a7b:cbd3:0:b0:477:991c:a17c with SMTP id 5b1f17b1804b1-477b9ea90b7mr106035535e9.6.1763971403827;
        Mon, 24 Nov 2025 00:03:23 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb91f4sm27372217f8f.31.2025.11.24.00.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 00:03:23 -0800 (PST)
Message-ID: <df838a73-788b-4b4d-8c91-e2bbcc827cc0@tuxon.dev>
Date: Mon, 24 Nov 2025 10:03:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/22] RZ/{G2L, G2LC, G2UL, G3S,
 Five, V2L}: Backport MSTOP support
To: Biju Das <biju.das.jz@bp.renesas.com>, Pavel Machek <pavel@denx.de>
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
 <aQz1pgHaEQNgfdKa@duo.ucw.cz> <1875B18477989308.416970@lists.cip-project.org>
 <e4137de7-ef22-41ce-b2b5-a1d2762eeb4b@tuxon.dev>
 <aSBslxvWFIij/zGh@duo.ucw.cz>
 <111077d3-10ee-4c95-926c-e81f4c622c37@tuxon.dev>
 <TY3PR01MB113467C7D29D1ACED3381BDB386D3A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <TY3PR01MB113467C7D29D1ACED3381BDB386D3A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 08:03:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20701



On 11/23/25 11:15, Biju Das wrote:
> 
> 
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Behalf Of claudiu beznea via
>> Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/22] RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}: Backport MSTOP
>> support
>>
>> Hi, Pavel,
>>
>> On 11/21/25 15:43, Pavel Machek wrote:
>>> Hi!
>>>
>>>>> E.g. w/o MSTOP support, if a device is part of a clock PM domain, it
>>>>> uses
>>>>> devm_pm_runtime_enable() in its driver, if stressing unbind/bind I
>>>>> can reach the point where the rpm_idle() tries to runtime resume the
>>>>> device (in the unbind cleanup phase) while its clocks are not
>>>>> anymore part of its PM domain. If the driver has it's own runtime PM
>>>>> APIs as well that tries to access the IP registers, rpm_idle() will
>>>>> call driver RPM APIs and those will fail because the clocks are no
>>>>> longer enabled though PM domain. The issue is explained in the
>>>>> description of
>>>>> https://lore.kernel.org/all/20251106081218.2574950-6-claudiu.beznea.
>>>>> uj@bp.renesas.com
>>>>>
>>>>>> Could it be done
>>>>>> without changing semantics of existing functions?
>>>>>
>>>>> Other approaches I've tried on mainline are:
>>>>>
>>>>> 1/ open/close a devres group in bus drivers probe:
>>>>> -
>>>>> https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.u
>>>>> j@bp.renesas.com
>>>
>>>> One other solution would be to open a devres group in probe and close
>>>> it on probe failure path and on remove. This will have to be done for
>>>> each individual driver used by the RZ/{G2L, G2LC, G2UL, G3S, Five, V2L} SoCs.
>>>> With this, patches 01-11 from this series will be dropped.
>>>
>>> That looks like feasible solution to me.
>>>
>>>> The scope of the devres group would be to track each devm_* calls for
>>>> the device in question, starting from the point the devres group is
>>>> opened, ending to the point where the devres is closed, something like below:
>>>>
>>>> ---| any devm_ calls are attached to the group X |------> time
>>>>    ^                                             ^
>>>>    |                                             |
>>>>  open devres                                   close devres
>>>>   group X                                       group X
>>>>
>>>> When the devres group will be closed, all the devm actions or reset
>>>> callbacks (tracked from the moment the devres was opened) will be called.
>>>>
>>>> The devres group will be the last thing in the remove function and
>>>> last thing on the failure path of the probe, thus the approach will
>>>> change the drivers functionality in the way that all the drivers
>>>> following this pattern will behave like their probe will use no devm_ helpers.
>>>>
>>>> I'm going to send a PoC patch for the media drivers used by the
>>>> RZ/{G2L, G2LC, G2UL, V2L} SoCs in reply to this thread. Please let me
>>>> know how do you consider this approach.
>>>
>>> I'll take a look, but if mainline is happy, likely I'll be happy, too.
>>
>> In mainline the problem is already fixed by patches 01-11 from this series.
>> The PoC patch that I sent is intended for CIP kernels only, and, along with it, all the other drivers
>> used by the RZ/{G2L, G2LC, G2UL, G3S, Five, V2L} SoCs will have to be patched with something similar.
> 
> 
> What to do with Mali driver used in RZ/{G2L, G2LC, V2L} ? Mali driver is used by other vendors as well.
> Maybe special handling??

DT nodes for the Mali IP on RZ/{G2L, G2LC, V2L} have Renesas compatibles.
Taking into account these compatibles, the code could be adjusted to be
executed only for the Renesas SoCs.

Thank you,
Claudiu

