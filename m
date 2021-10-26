Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA4CC433F5
	for <webhook@archiver.kernel.org>; Tue, 26 Oct 2021 08:21:10 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web08.9344.1635236468932253107
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Oct 2021 01:21:09 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 19Q8L6Pv001801
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 26 Oct 2021 10:21:06 +0200
Received: from [139.22.35.64] ([139.22.35.64])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 19Q8L5As020656;
	Tue, 26 Oct 2021 10:21:06 +0200
Subject: Re: [isar-cip-core][PATCH 0/2] kas update and menu support
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <cover.1634924446.git.jan.kiszka@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Message-ID: <149e6d13-9472-8a5a-ca37-b16416a9fd6f@siemens.com>
Date: Tue, 26 Oct 2021 10:21:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cover.1634924446.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Oct 2021 08:21:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6841

Hi,

On 10/22/21 7:40 PM, Jan Kiszka wrote:
> With kas 2.6 being released, this now allows to adopt the new "menu"
> feature and make the various image flavors and options more accessible.
> 
> Quirin, please have a look if I modeled the dependencies for secure boot
> and SWUpdate correctly, exposed reasonable combinations and didn't
> forget something useful.

I check it and all option are there.

Quirin

> 
> @all: Please play a bit with the options and check if you find anything
> that does not work (crowd-sourced randconfig...).
> 
> Thanks,
> Jan
> 
> Jan Kiszka (2):
>    Update to kas 2.6
>    Add kconfig menu
> 
>   .gitlab-ci.yml                       |   2 +-
>   Kconfig                              | 146 +++++++++++++++++++++++++++
>   README.md                            |  39 ++++---
>   kas/opt/ebg-secure-boot-base.yml     |   2 +-
>   kas/opt/ebg-secure-boot-snakeoil.yml |   2 +-
>   kas/opt/ebg-snakeoil-swu.yml         |   4 +-
>   kas/opt/ebg-swu.yml                  |   4 +-
>   7 files changed, 177 insertions(+), 22 deletions(-)
>   create mode 100644 Kconfig
> 






