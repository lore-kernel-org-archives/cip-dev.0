Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359A9C433EF
	for <webhook@archiver.kernel.org>; Tue, 23 Nov 2021 13:31:10 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.11200.1637674268944978992
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Nov 2021 05:31:09 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1ANDV59H021470
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 23 Nov 2021 14:31:06 +0100
Received: from [167.87.35.152] ([167.87.35.152])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1ANDV5OV019865
	for <cip-dev@lists.cip-project.org>; Tue, 23 Nov 2021 14:31:05 +0100
To: cip-dev@lists.cip-project.org
References: <20211119132915.unoqty5scuaxvdsw@MD1ZFJVC.ad001.siemens.net>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Subject: Re: [cip-dev][isar-cip-core]RFC v2 4/9] Create a initrd with support
 for dm-verity
Message-ID: <71e951f8-043f-613c-2c3e-7c6934ded034@siemens.com>
Date: Tue, 23 Nov 2021 14:31:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211119132915.unoqty5scuaxvdsw@MD1ZFJVC.ad001.siemens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Nov 2021 13:31:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6967



On 11/19/21 2:29 PM, Christian Storm via lists.cip-project.org wrote:
>>>> diff --git a/recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl b/recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl
>>>> new file mode 100644
>>>> index 0000000..c4f3dc4
>>>> --- /dev/null
>>>> +++ b/recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl
>>>> @@ -0,0 +1,68 @@
>>>> +#!/bin/sh
>>>> +prereqs()
>>>> +{
>>>> +    # Make sure that this script is run last in local-top
>>>> +    local req
>>>> +    for req in "${0%/*}"/*; do
>>>> +        script="${req##*/}"
>>>> +        if [ "$script" != "${0##*/}" ] && [ "$script" != "cryptroot" ]; then
>>>
>>> Hm, so you explicitly enumerate all scripts except for cryptroot so that
>>> you run (hopefully right?) thereafter.
>>> Isn't it sufficient to make cryptroot dependent on this?
>>> Looks too verbose and complicated...
>>
>> It is the same scripting as cryptroot uses in Debian 11 which inspired this
>> script. See [1].
>> [1]: https://salsa.debian.org/cryptsetup-team/cryptsetup/-/blob/debian/latest/debian/initramfs/scripts/local-top/cryptroot
> 
> Anyway, this doesn't answer the questions?
> 
> 
> 
> Kind regards,
>     Christian


The `verity.script` should executed as last script in the local-top init 
phase. if the cryptroot script exists `verity.script` is the second last 
script.

If the package `cryptsetup-initramfs` is always installed an entry in 
the cryptroot script would be enough. We have currently no dependency to
`cryptsetup-initramfs`.

If we want to change the cryptroot dependency we need to patch the 
necessary scripts/packages. Patching other packages is something I like 
to avoid for this feature.


Quirin

> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#6960): https://lists.cip-project.org/g/cip-dev/message/6960
> Mute This Topic: https://lists.cip-project.org/mt/87092657/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

--

