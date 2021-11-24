Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3707C433EF
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 12:08:02 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web08.5148.1637755680820129247
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 04:08:01 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AOC7w56011432
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 13:07:59 +0100
Received: from [139.22.38.174] ([139.22.38.174])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1AOC7wiH020777;
	Wed, 24 Nov 2021 13:07:58 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH 0/3] start-qemu.sh: Add some ease
 of use functionality
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20211124111221.300917-1-Quirin.Gylstorff@siemens.com>
 <d128127e-39a8-845d-58fa-ec501104e249@siemens.com>
 <35d6ecb7-5526-0abe-78a1-116fb456f3c1@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Message-ID: <fe21ac95-abc7-aa99-57e1-25c5e7800984@siemens.com>
Date: Wed, 24 Nov 2021 13:07:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <35d6ecb7-5526-0abe-78a1-116fb456f3c1@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 12:08:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6995



On 11/24/21 12:45 PM, Jan Kiszka wrote:
> On 24.11.21 12:44, Jan Kiszka wrote:
>> On 24.11.21 12:12, Q. Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> Fix booting of secure-boot image
>>> Parse .config.yaml for ease of use and reduced commandline clutter
>>>
>>> Quirin Gylstorff (3):
>>>    start-qemu.sh: set bootindex for SECURE_BOOT
>>>    start-qemu.sh: parse .config.yaml for ease of use
>>>    start-qemu.sh: Simplify qemu call
>>>
>>>   start-qemu.sh | 33 ++++++++++++++++++++++++---------
>>>   1 file changed, 24 insertions(+), 9 deletions(-)
>>>
>>
>> Definitely an improvement! But the fact that secure boot comes with a
>> different target image is not reflected yet.
>>
> 
> ...or is that only the case with your dm-verity series? Let me check.
> 
> Jan
> 

Only dm-verity introduces the new target.

Quirin

