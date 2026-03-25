Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C562FEA834
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 08:37:33 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17559.1774427851228380253
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Mar 2026 01:37:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=RHg/CfNo;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fda2a389so39131695e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2026 01:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1774427850; x=1775032650; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i66C/32ugekBRWdS7Lxlv5fanlNCDbuWBZMuzwp4emM=;
        b=RHg/CfNohrTKbFHjZdBXOQeRk2Kar6S7JNAkP93gZ5ZV6pS3BSik00TIfIvDnEzVD/
         dlVsMyfUFC68fE7TUy+WsLAO17CTzA6pyUPSc+mDfdqHZO2GcBJ8/mull8n1QXBTvxxg
         MRw+tz1WOvOxXl3CEtbjM436j5Z314jc3d0SbsDJdfvNWSSQ0psaWZ3+7AcScNbE18zs
         FUNDO0UXvKvsTAlSee9tcatYfrTMEY6OcLghDpVQAiE82/erwPRMz79ddOrpTTUv/m97
         0fo0smGdwSbD+9x13kJR2hLQie+RzrK8Ij0CCEZKUSUng9JZWVrPLsWBCotax8zggEsx
         VZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774427850; x=1775032650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i66C/32ugekBRWdS7Lxlv5fanlNCDbuWBZMuzwp4emM=;
        b=HcDVjCxA3vZT8oKNXVfugD0eaNENY4bgF435zZRwZ+dV89K/UbrCeajRtM7vvvZBvt
         7argg5ghToj+4hBdwKP41vRhmqLe7H3iHkMYs7llXNXxFhnfJviJHd3o2JxMsCpuSDqb
         ZKOYopMnxJYSulNwACnibmT1Zkl9AYCHvd8kTXs4Iv1TFOkTrDYvvA8UIpNcdCa/OqGe
         jW0arzqr8IrKBwzLdXVHVjmd0JMoBKBWhHjV2xyru6IIXdjeirVp8IjqX7QuQqc2MclB
         NL62oRKxF4b95rBRpttMauQ1GL5F7Fl4BV9bMlM1VnFI2iXITwkHcoDLgitX3b/YaDk2
         pyhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1fwnBTNh1flKILyOOM/FNETM8qL6TxPvSuL1Pgh2XivSyCXOcoAc2W+4QJhL/UYyRqRidWq1a@lists.cip-project.org
X-Gm-Message-State: AOJu0YxLi+LvB6P/zHhczlTR/mxjCYR4GhSSTVOZotYtHTHnvD2H9jhV
	DY8KIK+8N5NB0dXeJLtPtimy967K/8dQDUTzCA6ILQy7PYjsRBVMEdgpOrZS1Hl12aI=
X-Gm-Gg: ATEYQzzM0FlreRwO5G5ddvY6zpt1IKdpYejrERlgGqVTIMuQzBrxHlMki05O9Kdjn9Q
	gYg0oeQKLVPl1B93abWkOArE1xYTn00PVU0gqhPr7FzTN/4Da8MzOK7xd5Wlec6rXXEAxUfHRUw
	/d1e+WT5BwNv4oI6rrqvaer17izNtiEOswM8ZE0yB7S44s1dhys7xj7SvsgZ25nlIkzQvZ+gETn
	iJXz1n830sa1kQRCXMidC7n3ksRBlJE3vo65MyrADvo9GUxFCX/eRTD6xYkMdbDz/KbjfSxsruK
	E7LRXPwk1ABs9p9TSXPLMylmv1TMp2om+kFRpwThG0wc24uXTbP7gIlpW640wiVybmdKizdWWNI
	R+6PeYx1kAEGM+bpIDOsUfW+faeIR+cScRz/NywBO31s0NAZUTyDIvm+cvGf8aZjctMn49n68J4
	847qC5OEuOrbMuEEKs4ADAViwSnpzpezo=
X-Received: by 2002:a05:600c:6088:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-48715fff77amr36919555e9.13.1774427849614;
        Wed, 25 Mar 2026 01:37:29 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711693a08sm154283465e9.2.2026.03.25.01.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 01:37:29 -0700 (PDT)
Message-ID: <90f83c6c-1af4-4bb5-95fd-4be8ac4207cb@tuxon.dev>
Date: Wed, 25 Mar 2026 10:37:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y-cip 07/28] lib/bitmap: add bitmap_{read,write}()
To: Pavel Machek <pavel@nabladev.com>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
 <20260311110357.1938200-8-claudiu.beznea.uj@bp.renesas.com>
 <acJZg1O-1aB15Oyl@duo.ucw.cz>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <acJZg1O-1aB15Oyl@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2026 08:37:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22560

Hi, Pavel,

On 3/24/26 11:29, Pavel Machek wrote:
> Hi!
> 
>> From: Syed Nayyar Waris <syednwaris@gmail.com>
>>
>> commit 63c15822b8dd02a2423cfd92232245ace3f7a11b upstream.
>>
>> The two new functions allow reading/writing values of length up to
>> BITS_PER_LONG bits at arbitrary position in the bitmap.
>>
>> The code was taken from "bitops: Introduce the for_each_set_clump macro"
>> by Syed Nayyar Waris with a number of changes and simplifications:
>>   - instead of using roundup(), which adds an unnecessary dependency
>>     on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
>>   - indentation is reduced by not using else-clauses (suggested by
>>     checkpatch for bitmap_get_value());
>>   - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
>>     and bitmap_write();
>>   - some redundant computations are omitted.
>>
>> +++ b/include/linux/bitmap.h
>> @@ -601,6 +605,79 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
>>   	map[index] |= value << offset;
>>   }
>>   
>> +/**
>> + * bitmap_read - read a value of n-bits from the memory region
>> + * @map: address to the bitmap memory region
>> + * @start: bit offset of the n-bit value
>> + * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG
>> + *
>> + * Returns: value of @nbits bits located at the @start bit offset within the
>> + * @map memory region. For @nbits = 0 and @nbits > BITS_PER_LONG the return
>> + * value is undefined.
>> + */
>> +static inline unsigned long bitmap_read(const unsigned long *map,
>> +					unsigned long start,
>> +					unsigned long nbits)
>> +{
>> +	size_t index = BIT_WORD(start);
>> +	unsigned long offset = start % BITS_PER_LONG;
>> +	unsigned long space = BITS_PER_LONG - offset;
>> +	unsigned long value_low, value_high;
>> +
>> +	if (unlikely(!nbits || nbits > BITS_PER_LONG))
>> +		return 0;
> 
> If someone attempts to read more than bits_per_long, we silently give
> him 0. That sounds like recipe for hard-to-debug problem when the code
> designed for 64-bit system is ran on 32-bit.

The documentation states it explicitly:

"For @nbits = 0 and @nbits > BITS_PER_LONG the return value is undefined."

> 
> I'd expect WARN_ON here.

According to [1] the use of WARN()/WARN_ON() seems discouraged nowadays [1]


[1] https://lwn.net/Articles/969923/

> 
>> +static inline void bitmap_write(unsigned long *map, unsigned long value,
>> +				unsigned long start, unsigned long nbits)
>> +{
>> +	size_t index;
>> +	unsigned long offset;
>> +	unsigned long space;
>> +	unsigned long mask;
>> +	bool fit;
>> +
>> +	if (unlikely(!nbits || nbits > BITS_PER_LONG))
>> +		return;
> 
> And similary here.

Documentation also states "For @nbits == 0 and @nbits > BITS_PER_LONG no writes 
are performed."

Please let me know how would you like me to proceed with it.

Thank you for your review,
Claudiu

