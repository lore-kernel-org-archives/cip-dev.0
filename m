Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1627C433FE
	for <webhook@archiver.kernel.org>; Wed, 13 Oct 2021 14:02:47 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web10.8666.1634133766482490456
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Oct 2021 07:02:47 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 19DE2hrj030261
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 13 Oct 2021 16:02:44 +0200
Received: from [167.87.2.42] ([167.87.2.42])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 19DE2hFc028091;
	Wed, 13 Oct 2021 16:02:43 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/4] swupdate: Move handler to
 own recipe
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20211013134053.1400723-1-Quirin.Gylstorff@siemens.com>
 <20211013134053.1400723-2-Quirin.Gylstorff@siemens.com>
 <1094a516-23d5-cc51-e787-d13c2f42acde@siemens.com>
 <34ab1f03-a798-8d7d-c616-496846c69e56@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5cdd639d-93df-4e07-4302-9e41e391f8c0@siemens.com>
Date: Wed, 13 Oct 2021 16:02:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <34ab1f03-a798-8d7d-c616-496846c69e56@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Oct 2021 14:02:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6820

On 13.10.21 16:01, Gylstorff Quirin wrote:
> 
> 
> On 10/13/21 3:47 PM, Jan Kiszka wrote:
>> Plural or singular? Can a generic swupdate-handler package container
>> multiple handlers? Or will it only ever provide a single handler? In the
>> latter case, make this "swupdate-handler" as well.
> 
> An handler package could contain multiple handlers. Currently we have
> only swupdate-handler-roundrobin.
> 

Ok, thanks for clarifying.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

