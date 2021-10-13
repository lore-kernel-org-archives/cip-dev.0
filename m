Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB483C433EF
	for <webhook@archiver.kernel.org>; Wed, 13 Oct 2021 14:01:48 +0000 (UTC)
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.8574.1634133706688798674
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Oct 2021 07:01:47 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 19DE1icT017267
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 13 Oct 2021 16:01:45 +0200
Received: from [139.25.0.14] ([139.25.0.14])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 19DE1iRh026925;
	Wed, 13 Oct 2021 16:01:44 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/4] swupdate: Move handler to
 own recipe
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20211013134053.1400723-1-Quirin.Gylstorff@siemens.com>
 <20211013134053.1400723-2-Quirin.Gylstorff@siemens.com>
 <1094a516-23d5-cc51-e787-d13c2f42acde@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Message-ID: <34ab1f03-a798-8d7d-c616-496846c69e56@siemens.com>
Date: Wed, 13 Oct 2021 16:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1094a516-23d5-cc51-e787-d13c2f42acde@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Oct 2021 14:01:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6819
Message-ID: <20211013140144.g8-n2DpjX9gFCBwonyvQSUPDG0W4g_eaMBIZ8RC77GY@z>



On 10/13/21 3:47 PM, Jan Kiszka wrote:
> Plural or singular? Can a generic swupdate-handler package container
> multiple handlers? Or will it only ever provide a single handler? In the
> latter case, make this "swupdate-handler" as well.

An handler package could contain multiple handlers. Currently we have 
only swupdate-handler-roundrobin.

Quirin

