Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA7BC433EF
	for <webhook@archiver.kernel.org>; Thu,  3 Feb 2022 11:23:21 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.7849.1643887399698250437
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Feb 2022 03:23:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=quirin.gylstorff@siemens.com header.s=fm1
 header.b=UMA8Wt6+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226,
 mailfrom: fm-51332-2022020311231205585f16578fbf95c1-dhppxm@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 2022020311231205585f16578fbf95c1
        for <cip-dev@lists.cip-project.org>;
        Thu, 03 Feb 2022 12:23:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=quirin.gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ZybPh/ZYzS8gbrk4rrDl+JN7hvy47uq/kS5SR5gnSe8=;
 b=UMA8Wt6+9Pc9bjE8L9PD6lPLeSXrU19C0aDQMIajibUixlXs4dPrf/8zk2o8z2YDb3RGop
 8d1AZbV7D2VcgZi0ZXJ4fPPlmmVtIVwgeLS7OoKVJAd3CMX+W/ov5ntz4b+aQm0qi5johP5F
 npMnB9AE9QTYkcJ1s50GKfS27SHz0=;
Message-ID: <12d61c6e-faa5-ca5b-3c0b-b5a9808c6ff1@siemens.com>
Date: Thu, 3 Feb 2022 12:23:11 +0100
MIME-Version: 1.0
Subject: Re: [isar-cip-core v2 0/2] Add necessary steps to verify swupdate
Content-Language: en-US
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 jan.kiszka@siemens.com, Chris Paterson <chris.paterson2@renesas.com>
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
 akihiro27.suzuki@toshiba.co.jp,
 Cedric Hombourger <Cedric_Hombourger@mentor.com>
References: <52fae1ea-25fc-e692-2b51-e503681d2efb@siemens.com>
 <20220201153502.14230-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: quirin.gylstorff@siemens.com
Organization: Siemens
In-Reply-To: <20220201153502.14230-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Feb 2022 11:23:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7568

Hi,

On 2/1/22 16:35, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> The current isar-cip-core provides verification of successful swupdate
> but lacks the recipe to verify swupdate-rollback feature, the below
> patches provides the necessary script to verify swupdate-rollback.
> 
> Shivanand Kunijadar (2):
>    Add recipe to cause kernel panic during system boot
>    README.swupdate.md: add readme file with steps to verify swupdate
> 
>   doc/README.swupdate.md                        | 208 ++++++++++++++++++
>   kas/opt/kernel-panic.yml                      |  18 ++
>   .../kernel-panic/files/sysrq-panic.service    |  10 +
>   recipes-core/kernel-panic/kernel-panic.bb     |  24 ++
>   4 files changed, 260 insertions(+)
>   create mode 100644 doc/README.swupdate.md
>   create mode 100644 kas/opt/kernel-panic.yml
>   create mode 100644 recipes-core/kernel-panic/files/sysrq-panic.service
>   create mode 100644 recipes-core/kernel-panic/kernel-panic.bb
> 


Should we try to automate this with LAVA. With 
https://github.com/siemens/mtda it should be possible.

@Chris what are your thoughts.

Kind regards

Quirin

