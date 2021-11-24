Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9140C433F5
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 11:45:30 +0000 (UTC)
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.5166.1637754329446554386
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 03:45:30 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AOBjQJp029778
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 12:45:26 +0100
Received: from [167.87.0.79] ([167.87.0.79])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AOBjQOs004692;
	Wed, 24 Nov 2021 12:45:26 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH 0/3] start-qemu.sh: Add some ease
 of use functionality
From: Jan Kiszka <jan.kiszka@siemens.com>
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20211124111221.300917-1-Quirin.Gylstorff@siemens.com>
 <d128127e-39a8-845d-58fa-ec501104e249@siemens.com>
Message-ID: <35d6ecb7-5526-0abe-78a1-116fb456f3c1@siemens.com>
Date: Wed, 24 Nov 2021 12:45:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d128127e-39a8-845d-58fa-ec501104e249@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 11:45:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6993

On 24.11.21 12:44, Jan Kiszka wrote:
> On 24.11.21 12:12, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Fix booting of secure-boot image
>> Parse .config.yaml for ease of use and reduced commandline clutter
>>
>> Quirin Gylstorff (3):
>>   start-qemu.sh: set bootindex for SECURE_BOOT
>>   start-qemu.sh: parse .config.yaml for ease of use
>>   start-qemu.sh: Simplify qemu call
>>
>>  start-qemu.sh | 33 ++++++++++++++++++++++++---------
>>  1 file changed, 24 insertions(+), 9 deletions(-)
>>
> 
> Definitely an improvement! But the fact that secure boot comes with a
> different target image is not reflected yet.
> 

...or is that only the case with your dm-verity series? Let me check.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

