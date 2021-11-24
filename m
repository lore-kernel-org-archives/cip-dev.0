Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FF5C433EF
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 15:19:23 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.76.1637767162567683626
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 07:19:23 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AOFJKEY032272
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 16:19:21 +0100
Received: from [139.22.38.174] ([139.22.38.174])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1AOFJK66012854;
	Wed, 24 Nov 2021 16:19:20 +0100
Subject: Re: [cip-dev] [PATCH v2 0/3] start-qemu.sh: Add some ease of use
 functionality
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
References: <20211124143131.939349-1-Quirin.Gylstorff@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Message-ID: <5bf305a6-11dd-422d-fca9-c09c5e140c0f@siemens.com>
Date: Wed, 24 Nov 2021 16:19:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211124143131.939349-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 15:19:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7007

Hi Jan,

please Ignore v2. I sent the changes in a extra patchset.

Quirin

On 11/24/21 3:31 PM, Quirin Gylstorff via lists.cip-project.org wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Fix booting of secure-boot image
> Parse .config.yaml for ease of use and reduced commandline clutter
> 
> Changes V2:
>   - Add Sentence to README
>   - Add default cip-core-image-security
> 
> Quirin Gylstorff (3):
>    start-qemu.sh: set bootindex for SECURE_BOOT
>    start-qemu.sh: parse .config.yaml for ease of use
>    start-qemu.sh: Simplify qemu call
> 
>   README.md     |  6 ++++--
>   start-qemu.sh | 36 +++++++++++++++++++++++++++---------
>   2 files changed, 31 insertions(+), 11 deletions(-)
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#7000): https://lists.cip-project.org/g/cip-dev/message/7000
> Mute This Topic: https://lists.cip-project.org/mt/87281974/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


