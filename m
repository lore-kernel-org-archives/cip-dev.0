Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BFAC30658
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 07:55:36 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.12467.1720166134391226389
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 00:55:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=itldsDA2;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: ch@denx.de)
Received: from [10.88.0.225] (dslb-084-063-248-163.084.063.pools.vodafone-ip.de [84.63.248.163])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: ch@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3D32587F9F;
	Fri,  5 Jul 2024 09:55:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720166132;
	bh=Vwbw2+hhwjBfyAvzlWkkdeZ1XX2FTGVVG3mesvur6BU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=itldsDA2SKysKhKDTd3t0OzWmkpypZM6xO4W1ISPCbJ/o0nHrbJRX1OZaKx6bwBU9
	 Pm3DG88By293V3+X5eK4pxCa+xtuvkW6K01lnPlIX48zDntF6BC6LnaCqZ78wMs+Me
	 dJKtRvhT1PbC7zxiCHLP/+ncJGY7pDjvP9a4Rh39WFDE/ReTq5w5RF5Tzbi5x9Gw3N
	 uL8pQi8il7rWe8KgdxPtdCDtQJbieUfn9C1CorWQIsq56H/DGrW/WOtzmR2r168PAP
	 6SM5a5OTJrk5yNAC117wF/tXjiLU66mapqQEmIGShi8y5Y1cDUEe0giKMGVRQrKXlz
	 Z9P3D6Lotn15w==
Message-ID: <f8734192-f1f7-4cb1-bff8-edc950eb390e@denx.de>
Date: Fri, 5 Jul 2024 09:55:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swupdate.bbclass: make swu_files entries unique
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20240703114242.1896508-1-ch@denx.de>
 <7a7ed1e59a5682144aaaad819fbbd1264f3ece34.camel@siemens.com>
 <204be939-3a9e-4210-9194-a70ac83640da@denx.de>
 <349d4345-dfa5-4925-b9da-8217b6caca64@siemens.com>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <349d4345-dfa5-4925-b9da-8217b6caca64@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 07:55:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16388

Hi Jan,

On 2024-07-04 11:45 pm, Jan Kiszka wrote:
> On 04.07.24 15:29, Claudius Heine wrote:
>> Hi Felix,
>>
>> On 2024-07-04 2:15 pm, MOESSBAUER, Felix wrote:
>>> On Wed, 2024-07-03 at 13:42 +0200, Claudius Heine wrote:
>>>> In case a sw-description contains multiple entries of the same file,
>>>> swu_files will contains multiples of the same file and thus later
>>>> operations fail.
>>>
>>> Hi, I'm wondering how that can happen, but OK.
>>
>> How it happens that there are multiple mentions of the same file in a
>> sw-description, or how it happens that it fails?
>>
>> Multiple instances of the same file happens when the swupdate software
>> collections are used to implement A/B update:
>> https://sbabic.github.io/swupdate/sw-description.html#software-collections
>>
>> There the same image can be flashed to different devices.
>>
> 
> That's a pattern we can avoid these days by using the roundrobin
> handler, see recipes-core/images/swu/sw-description.tmpl. Doesn't make
> the collection pattern wrong and this fix unneeded.

I'm not sure I fully understand your last sentence, but I know about the 
roundrobin handler and used it in other projects before, however AFAIK 
it is something specific to isar-cip-core. I haven't seen this used in 
other projects outside of that.

 From what I experienced, outside of isar-cip-core, the software 
collection approach is much more common. There we have swupdate wrapper 
scripts, that figure out which software collection should be used, and 
call swupdate accordingly.
> 
> Still, you may want to check if there is a real need to have an own
> sw-description.tmpl downstream - or if there is anything missing in the
> upstream template to make it even more useful.

The round-robin handler and the isar-cip-core specific 
sw-description.tmpl might work well enough for projects that start with 
isar-cip-core, but some projects might want to switch from something 
else to isar-cip-core gradually, while preserving update compatibility, 
or have project-specific use-cases and handlers where it doesn't make 
sense to pull in the complexity into isar-cip-core itself.

The platform I am working with, doesn't support EFI, has a two grub 
bootloaders with custom scripts that chainload another, has embedded lua 
scripts in the sw-description, wrapper scripts to implement platform 
specific ways to trigger different parts of the update process 
separately, very specific partition layout, and so on.

Preventing alternative ways to implement the product-layer from a 
base-layer makes it difficult to adopt it.

IMO having a default isar-cip-core way, is great, but it should be 
possible to go a custom route as well, and to deactivate or change 
whatever is necessary. IMO, this is generally how bitbake meta-layers 
should work. Otherwise people will either require to carry downstream 
patches to layers, which should only be done in very specific 
circumstances, or have to copy & modify classes and files into their 
layers, which will also make development and maintenance more difficult.

regards,
Claudius

-- 
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de

