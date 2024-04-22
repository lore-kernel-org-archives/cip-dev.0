Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C88DC4345F
	for <webhook@archiver.kernel.org>; Mon, 22 Apr 2024 05:13:39 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.web10.11381.1713762786284356572
 for <cip-dev@lists.cip-project.org>;
 Sun, 21 Apr 2024 22:13:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=CYUm4iy0;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e69a51a33so3519178a12.1
        for <cip-dev@lists.cip-project.org>; Sun, 21 Apr 2024 22:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713762784; x=1714367584; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pmnUQBiGgk10V+Hk9e+RWDa4g+oBKGNgFLPj7POVIj8=;
        b=CYUm4iy09Ii3R0EAp4G41RP0kI7PtY9/wvC+5wEK94bh1z6f5Rt1uURyuMGJDz9UjW
         cZLHTjyGG0OPatqA0Xkhd9sL6nxnvZ/irLgApSn6mQTV2q0i8l8V2nonKiNR50bXq/eK
         BVg642IZE6FdItlnrj/lKWja5idp3+o7p1k16FbfJAiHg88g5WWSwrn5vAzuTA5vq0gL
         2LlYUwb6pmyOK420VwNAK3gA+WdIP/wnoPOVih8+mqjomAy/AaObJWhX0KDjDU5dxco/
         yfhRXIdINz/aDadHkosAWcWoeB+mroImI5K9Kze1aRfaX0quAgYyfw94PQMRIjzvhuGA
         NR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713762784; x=1714367584;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmnUQBiGgk10V+Hk9e+RWDa4g+oBKGNgFLPj7POVIj8=;
        b=mVj0kfti+/mgd+rL18vPz/SOkP4hBwSCCa2gPCS+2esVY4jBtS761k+pTDamep/io6
         CcVZgJDHtYUMRWLqRwSLrhHlcJikuU6hzA7RiokM0wNwlgUfKR0WaBUxMcxZ7S81cFJb
         M5V+NFmrp8gxinXfH76jV7DGiqbX0F02kr3IjLqz+foPOikpEtHMIRfKoVdjwKV2P5jz
         XFQXsg848UMIKA40z4qAoxhwQZSF9+PeBTp7DfatzteP7BhadPV18ad1HLQ8ctWXBHgY
         crYBChG8lCLpn6BY5TsH8seR2jrBTX/W3741/PaVVQCvKOZsVocM59mbs/v2iqLEtdww
         gBWA==
X-Forwarded-Encrypted: i=1; AJvYcCUI5cMdWWzQNG0AbDnBwocQIipJwybjaihjFU4cP6Hv6VR0WjGxrUkGThlmnlTvGzLJwn2TnzBgL9L4hgo3p27I1QiRW72q9tt5hWQcBw==
X-Gm-Message-State: AOJu0Yx3p8fZnHjolT8G1KdfrxcVRMzuAjYI1LAwBHx/fO3SJLgOavCl
	lxPAgUHesmT6R3f1fFy5ysO4HU8r8yz/tLjObJVu0eQoadReew84DYtpz8/F3O+kjR7fkR06Hq6
	7jR8=
X-Google-Smtp-Source: AGHT+IE5f/pS+Rq+xfDJmITFDP9qTAESFf3Ks6UU6Qejn1Q1rIBYL/eSWogF8vb7gqf4lw5ktKt+Sw==
X-Received: by 2002:a50:aa9a:0:b0:568:a4b6:9828 with SMTP id q26-20020a50aa9a000000b00568a4b69828mr6109572edc.30.1713762784349;
        Sun, 21 Apr 2024 22:13:04 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id l10-20020a056402124a00b00571bec923bcsm4809352edw.93.2024.04.21.22.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 22:13:03 -0700 (PDT)
Message-ID: <b3ed1890-5ef6-4b2d-9759-4c4cc1549362@tuxon.dev>
Date: Mon, 22 Apr 2024 08:13:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y-cip 13/53] clk: renesas: rzg2l: Simplify
 .determine_rate()
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
 <20240419081742.3496709-14-claudiu.beznea.uj@bp.renesas.com>
 <ZiUf3ofCxfqK2KJM@duo.ucw.cz>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <ZiUf3ofCxfqK2KJM@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Apr 2024 05:13:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15721



On 21.04.2024 17:17, Pavel Machek wrote:
> Hi!
> 
>> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>
>> commit bbceb13ce2c7b084bbbf2463ac8ac2b1f2bd2949 upstream.
>>
>> rzg2l_cpg_sd_clk_mux_determine_rate() is the same as
>> __clk_mux_determine_rate_closest(), so use the latter to save some LoC.
> 
> It is somewhat strange to use __ annotated function like this, but as

I see your point.

> it is already mainline, I guess everything is ok.
> 
> Best regards,
> 								Pavel

