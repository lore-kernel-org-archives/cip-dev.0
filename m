Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBECC4345F
	for <webhook@archiver.kernel.org>; Sun, 21 Apr 2024 23:45:18 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mx.groups.io with SMTP id smtpd.web11.32697.1713708903959434375
 for <cip-dev@lists.cip-project.org>;
 Sun, 21 Apr 2024 07:15:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=meGvwpVc;
 spf=pass (domain: kernel.org, ip: 139.178.84.217, mailfrom: krzk@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4AAC660BC3;
	Sun, 21 Apr 2024 14:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFF2C113CE;
	Sun, 21 Apr 2024 14:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713708902;
	bh=c2DbnHT7TQMy9HD1UsFgbFRJH5+n/JyYaKTQS/1f3QU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=meGvwpVckIoU9n4XlZcc+wARxKyriKNqEWMn65aX93Njjn6lye+6QUwdTGljnOnxY
	 dgQT6Gjn8yFPV+4uoTmR8VClKsVRl/boWQN4Ratm0WeLjKK12Zu+AVjsc3CDZTg3FG
	 Avl8l3oGMkXceDtrGCF7tRCRJIVKbEZOF4uJSV9GQwxwAIg3Rt65nLP4gu3yCZFtNW
	 NWxktb+zFj2dStunOmhQ+dMxxahaXGASN2WWZnvq4N38p9sAs1nhYj3mQfHGvUVivi
	 6gYlJkUQk4mFXhRkNANAAPC0di2vS2ejzfPDF6KnmZ/1ugRwO11eMdfR9KgYT5fYB4
	 rW7RFlrt2ilZA==
Message-ID: <8bc364cf-fc6f-43f4-aa23-d9ea224080f7@kernel.org>
Date: Sun, 21 Apr 2024 16:14:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y-cip 00/36] Add IA55 interrupt controller support
To: Pavel Machek <pavel@denx.de>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, nobuhiro1.iwamatsu@toshiba.co.jp,
 cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
 <11c7f37d-d18d-4120-ad04-8efc3dec8305@kernel.org>
 <ZiLJe38ZgWbYC7P2@duo.ucw.cz>
 <ad85fa92-5b70-4b47-83c0-a2d307538934@kernel.org>
 <ZiUejtwUYcdfRVoj@duo.ucw.cz>
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZiUejtwUYcdfRVoj@duo.ucw.cz>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 21 Apr 2024 23:45:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15718

On 21/04/2024 16:11, Pavel Machek wrote:
> Hi!
> 
>>>> Please use same tooling as stable is using, so you will produce
>>>> "X-stable: review" header. Or any other header which will allow people
>>>> to filter out huge CIP mailings when using lei/lore, just like we filter
>>>> out the stable ones.
>>>
>>> I'm confused, what should such header mean and what would you like to
>>> filter?
>>
>> Meaning would be the same as in stable process. Why CIP is doing this
>> differently?
>>
>> What we all are filtering? Emails from stable and CIP. It's way too
>> much. Many of us have several filters on lei for specific paths in
>> kernel, because lei successfully allows to replace the MAINTAINER entry.
>> stable and CIP postings are picked up by such filters, because they
>> touch the same paths. And it's not  just one email, it's entire thread,
>> like 200 patches from stable. CIP is somehow smaller but still.
>> Therefore the filter has AND NOT for mentioned header - I can nicely
>> remove all stable postings which I am not interested at all.
> 
> Why not simply ignore everything on cip-dev? We have rule that
> everything applied to -cip has to be upstream first.

Because it is simpler to ignore one tag for all backports. But sure, I
will ignore everything from all folks listed here.

Best regards,
Krzysztof


