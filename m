Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A7AC433EF
	for <webhook@archiver.kernel.org>; Fri, 11 Mar 2022 14:08:33 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web09.5465.1647007712159546303
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Mar 2022 06:08:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=quirin.gylstorff@siemens.com header.s=fm1
 header.b=U8lebFkH;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226,
 mailfrom: fm-51332-2022031114082701d1eeca4f760cf0bf-6v76v7@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 2022031114082701d1eeca4f760cf0bf
        for <cip-dev@lists.cip-project.org>;
        Fri, 11 Mar 2022 15:08:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=quirin.gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=TPXyGDkmML7BSbZB+M8j/bqTzuygAq6yOnKYapVxnkI=;
 b=U8lebFkHxCLLiXxBreRqKFbtXO36LMzNm4C5Q9+N7L76PPu6XK4ltc2deh0bwqhru9Go5u
 zenDDD1CabuiEZ9YA8DF7XuSZDkCzv+FNI6KmLWu50SIcZeyK4IqSchU/gwsjVbj4uvcJLGE
 r2+fhGfINrODekSdS0jbaRfvovLCo=;
Message-ID: <ccfe24e1-3872-5046-9935-521b44cd8ff6@siemens.com>
Date: Fri, 11 Mar 2022 15:08:27 +0100
MIME-Version: 1.0
Subject: Re: [isar-cip-core][PATCH 0/2] SWUpdate-related cleanups
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <cover.1646938228.git.jan.kiszka@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <cover.1646938228.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Mar 2022 14:08:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7694



On 3/10/22 19:50, Jan Kiszka wrote:
> Primarily auto-compression for SWU_ADDITIONAL_FILES.
> 
> Jan
> 
> Jan Kiszka (2):
>    Drop redundant SWU_DESCRIPTION_FILE assignment
>    swupdate-img: Add support for automatically compressing files
> 
>   classes/compress_swupdate_rootfs.bbclass | 21 ---------------------
>   classes/secure-swupdate-img.bbclass      |  4 +---
>   classes/swupdate-img.bbclass             | 15 +++++++++++++++
>   classes/wic-swu-img.bbclass              |  5 +----
>   recipes-core/images/secureboot.inc       |  4 +---
>   recipes-core/images/swupdate.inc         |  4 ++--
>   6 files changed, 20 insertions(+), 33 deletions(-)
>   delete mode 100644 classes/compress_swupdate_rootfs.bbclass
> 

Looks good to me.

Quirin

