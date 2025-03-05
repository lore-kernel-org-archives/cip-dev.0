Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72357C19F32
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 08:39:51 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.9259.1741163982186040073
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Mar 2025 00:39:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=VP0z6PrL;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E8FE10382C18;
	Wed,  5 Mar 2025 09:39:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741163980; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=0kJobBQst+tcRF2DyZA7OswUvC196ArjdbOp/R5k5jw=;
	b=VP0z6PrLTdTCDTcwwxwx2ycZSDDE2kGJy6Yw4NW+4JGZrFVew9NiyPxXG1oGcvYaFfWGyZ
	mXQvB6XvZHQHnWE29isZsndnFus6A0Cpyo/JCRlcRoOdhn/NHiIUSlOzsksRIAltuF6Ec6
	h0QNTeXORSiS2/cQEeLm+Os0xS9kjk0EnaWL/X3HRyVhOuqUGcWwuj7ol5Qgqt3aIFKO0K
	9lZU1eSSiHFKg3OrYiPZjuZ5/tdi38rREY6vuuUQrSMgK2rdo7w7GJPfHBNH327V/AUo6F
	Lm8pXgRimJwdjsJr+rxfWEuld6VV0dV9EogCg4OzQaNSNm6oxyy+wh1dqzIvLg==
Message-ID: <0b4f74da-b1d7-46ab-b15e-465cbff39db3@denx.de>
Date: Wed, 5 Mar 2025 09:39:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] initramfs-crypt-hook: implement 'noencrypt' option
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20250304130743.2812183-1-ch@denx.de>
 <20250304130743.2812183-3-ch@denx.de>
 <c98de579-e33f-486f-b964-4f4a0aebd1d5@siemens.com>
 <12212010-abfc-4e1d-a6bc-0a89754c2b86@denx.de>
 <014850ef-8627-4266-baa0-136d39f3e88e@siemens.com>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <014850ef-8627-4266-baa0-136d39f3e88e@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Mar 2025 08:39:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18033

On 2025-03-05 9:27 am, Jan Kiszka wrote:
>>> "themselves" - where is the plural coming from?
>> There is the rule: "He, she, it; das S muss mit"
>>
> "the fallback system... would not encrypt it itself" - it's only one
> fallback system from my reading of the sentence.

They/them is not necessarily plural, but as I said, I changed it to `on 
its own`, for the next version.

https://en.wikipedia.org/wiki/Singular_they

-- 
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de


