Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F6CC433F5
	for <webhook@archiver.kernel.org>; Thu, 25 Nov 2021 07:08:40 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web10.9297.1637824118557697745
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 23:08:39 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AP78ZMl008714
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 25 Nov 2021 08:08:36 +0100
Received: from [167.87.72.134] ([167.87.72.134])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AP78ZTj016999;
	Thu, 25 Nov 2021 08:08:35 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH 0/2] start-qemu add missing option
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20211124151744.949054-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bcfff246-b887-b5c3-e2c2-1df3ffb4bdc9@siemens.com>
Date: Thu, 25 Nov 2021 08:08:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211124151744.949054-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Nov 2021 07:08:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7010

On 24.11.21 16:17, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Add the missing option for cip-core-image-security.
> Add documentation for start-qemu.sh defaults from kas-container menu
> 
> Quirin Gylstorff (2):
>   start-qemu.sh: Add defaults for IMAGE_SECURITY
>   README: Add information about start-qemu-defaults with menu config
> 
>  README.md                | 6 ++++--
>  doc/README.secureboot.md | 7 +++++++
>  start-qemu.sh            | 3 +++
>  3 files changed, 14 insertions(+), 2 deletions(-)
> 

Both applied, I've just made the wording in README.md even clearer.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

