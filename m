Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE53C433EF
	for <webhook@archiver.kernel.org>; Fri, 19 Nov 2021 06:43:33 +0000 (UTC)
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web09.5462.1637304212644508250
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Nov 2021 22:43:33 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AJ6hTsX031035
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Nov 2021 07:43:29 +0100
Received: from [139.22.32.112] ([139.22.32.112])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AJ6hSWc028540;
	Fri, 19 Nov 2021 07:43:29 +0100
Subject: Re: [isar-cip-core v2 0/3] Security extensions for bullseye image
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <16B7FCBA2ADC61EA.22891@lists.cip-project.org>
 <20211117105437.4621-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <62dde81b-6daf-daaa-7120-10a9ea6db024@siemens.com>
Date: Fri, 19 Nov 2021 07:43:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211117105437.4621-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Nov 2021 06:43:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6958

On 17.11.21 11:54, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> This patch series enable security extension for bullseye image.
> 
> It fixes the below two problems
> - package not found due to dependency package names are changed in
>   bullseye version, so remove the dependency packages and allowed
>   package manager to install correct package names.
> - package not found due to main package name is changed in bullseye
>   version, so install the packages based on DISTRO version selected.
> 
> venkata pyla (3):
>   cip-core-image-security: remove unnecessary dependency package names
>   cip-core-image-security: Install packages based on DISTRO version
>   Kconfig: Enable Security extensions for bullseye image
> 
>  Kconfig                                        |  1 -
>  recipes-core/images/cip-core-image-security.bb | 15 ++++++++++-----
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 

thanks, applied

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

