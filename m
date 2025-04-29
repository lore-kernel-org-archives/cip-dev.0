Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA91C369DC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 12:24:56 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web10.18471.1745929493010073481
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 05:24:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=lxFcRFww;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac25d2b2354so883840166b.1
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 05:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745929491; x=1746534291; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pc6ZR1NpCVtm9PnknEzbXci8JnVP4BKFlZUUaZpWbBI=;
        b=lxFcRFwwFpivuCAgCoXEsQbRf6KcwuEmRRFZLX/yXhbEBqqr4YXH13dLu+sM65P4wy
         Z5rSLsyhdyb2TS6jhkASBLVIAiZuq7hLAwUdB3CSwyOYldUageeH68AQIaht01TeUzbC
         mRYGL4UF2my3QxhlXYWpmCAzQNI1Dfmroj55Tc/EGab5of6ev4L1WBGb7yLQabiY1FLp
         C20K5GvJmDqPdwxqK0miBzDFOzGEFjCxgPS7sYBgxD91wHhW0mvYK3dOCU8Gykk+uoCY
         GapNVSxDtOVpIgssJ7WTdBOqdw+eP5QZjuP+ja5w87J9bBxaI+l5uOurNUvlNFMj6dc0
         q8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745929491; x=1746534291;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pc6ZR1NpCVtm9PnknEzbXci8JnVP4BKFlZUUaZpWbBI=;
        b=qYOO6j8A1qqBfsUfhTWr8N0uc/zcPiU/QlpBNKXArovDbAAEiqdX4SZ5HxlBfJOWl3
         a+6/pZMVr6JWDZERiPelzWwSmEpBE5NVU3BCzTqs5+1uxEsVrYWWmvT+BH9i0k5qfMmT
         ECjDDJYA5OsL9AlQbh1fFM2BJr1cBWFT4Z+wRdBjBOqFJvjTqh4BYmSb5Jv/G7Gsv3id
         BogpuTZffLbJdDSJ9QhRgqr1bGh2uhiE+n5qTA8sepNYEAScKVjoqnrKLWlEiOrREzwv
         Ag7nfLqjnKCGvo5ap5Sp8ByYSXsQB3mzuC0XxFlZubMrPTcjDwvHDnngqQfrbq3HNuRL
         NKwA==
X-Forwarded-Encrypted: i=1; AJvYcCXyiyvcPQXjaecZ2PLXm0vARDt51zhtuJFghqnYWqDvsRhHGTYXqAiX9vMnM4Hgf1tnsW+Mi69y@lists.cip-project.org
X-Gm-Message-State: AOJu0Yxa0hr5yVYh9O5IrhYPj/XiMO8MvArxDjqCwxJGQjNukDnXSBzk
	NDNjGcc5PhKJfN8lyyt2HYQnp36ikJRHtas6+ldbUUhLr8eFlO1kWrIwy4XZzW0=
X-Gm-Gg: ASbGncuFeBSVlrmMmpzl/LY8YyXtg3lHtvc4Hqi1B/Ma3OdINjt7dYpo2EHm/1LAAk8
	Tclf7I3MtpqFB9bj5tqCXTpBRMiUrLqWHjWu2EpksBfu7H2ktTitxKVBR1mcdDtg8lN4N4MdmCU
	jIzDsa9355G0LT/0PHsljpLRzIH979jaZI2QAKqNjS5i6Zpm0JLEEIv7ewbhaHIhAMuX6EDua4X
	E5ce0nfURRYqOR9MGtqz1CmN39pqr1NIOdguK0fa0Y8tjq6Yo+qEhadqKLTdMLHFzgN/nP0KO3s
	UGIaPQYI17seep7WjTXIWtAa5vTTKvtjeXbg32KzQ+ue8xqu/A==
X-Google-Smtp-Source: AGHT+IHmd8yK8hPTs+1ZtOeeGbdFmtzgZ/dyw7LE3UCCCMO2L4v46Dgm+fIWwHAm1vEvj29aDn9g/w==
X-Received: by 2002:a17:907:2da3:b0:ace:3643:1959 with SMTP id a640c23a62f3a-acec4b404d3mr348801466b.7.1745929491173;
        Tue, 29 Apr 2025 05:24:51 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7016f6424sm7549846a12.42.2025.04.29.05.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 05:24:50 -0700 (PDT)
Message-ID: <103ba099-d12a-404a-ba93-118d61dfc929@tuxon.dev>
Date: Tue, 29 Apr 2025 15:24:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH v6.1.y-cip 0/3] RZ/G3S: Backport DMA
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
References: <20250428050051.3081705-1-claudiu.beznea.uj@bp.renesas.com>
 <aBChjSNF4X9pEdot@duo.ucw.cz>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <aBChjSNF4X9pEdot@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 12:24:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18711

Hi, Pavel,

On 29.04.2025 12:53, Pavel Machek wrote:
> Hi!
> 
>> Series backports the Renesas RZ/G3S DMA support to v5.10.y CIP.
> 
> Applied. I had to fix up 3/ patch as the dts changed and it no longer
> applied. It was trivial enough, so I believe I got it right.

I checked it. All good. Thank you for taking care of it!

Claudiu

> 
> Best regards,
> 								Pavel


