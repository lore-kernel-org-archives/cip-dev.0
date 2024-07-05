Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B22DC3271F
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 08:21:46 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.12703.1720167703149255390
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 01:21:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=qj3wo8eL;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: ch@denx.de)
Received: from [10.88.0.225] (dslb-084-063-248-163.084.063.pools.vodafone-ip.de [84.63.248.163])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: ch@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1345C883BA;
	Fri,  5 Jul 2024 10:21:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720167701;
	bh=Vc4F6RemfJQxKo1elqKWtNpOOFA5VfxdPBwZRYgTUeQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=qj3wo8eL9sRIK1gOrycIeXu5KwqynRsEopFsEOJw9nsMBVup/mHM+wAjyJ3eYwhdD
	 WiJPAtg92m0940QzrBr6Wgy0Gh32OZAjvOOBcg0l0NiUdi/vjU3WcgOp9lceinDeTB
	 6B6OtZwEyR4QvNH4W/7UPKl6xxvNETnE5fLMY+vJElBEBhO42/uZB1Nc0D5XMQ9X6e
	 yovOfCZVMzWdoeWo7MkmbL9NEOgz/I5GG/DxCZgm6z+kzHqgtFfj2StygGska29bbb
	 agD9BKcdPd9YfgXUxF6yJL6XuqacWctZTeU3LOXL3v7PLbV3bQsNYn4CytzuZ78Bl0
	 h33UkEUrdZFdg==
Message-ID: <f70b4d0d-8c19-4469-86b1-feb7e9a2bf3b@denx.de>
Date: Fri, 5 Jul 2024 10:21:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swupdate.bbclass: make swu_files entries unique
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 Christian Storm <christian.storm@siemens.com>
References: <20240703114242.1896508-1-ch@denx.de>
 <7a7ed1e59a5682144aaaad819fbbd1264f3ece34.camel@siemens.com>
 <204be939-3a9e-4210-9194-a70ac83640da@denx.de>
 <349d4345-dfa5-4925-b9da-8217b6caca64@siemens.com>
 <f8734192-f1f7-4cb1-bff8-edc950eb390e@denx.de>
 <8fc0b73c-5185-4bd0-952d-7f01aa2a1a2b@siemens.com>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <8fc0b73c-5185-4bd0-952d-7f01aa2a1a2b@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 08:21:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16391

On 2024-07-05 10:08 am, Jan Kiszka wrote:
>>> That's a pattern we can avoid these days by using the roundrobin
>>> handler, see recipes-core/images/swu/sw-description.tmpl. Doesn't make
>>> the collection pattern wrong and this fix unneeded.
>> I'm not sure I fully understand your last sentence, but I know about the
>> roundrobin handler and used it in other projects before, however AFAIK
>> it is something specific to isar-cip-core. I haven't seen this used in
>> other projects outside of that.
> I mean I'm still happy to take your fix.

Got it now. Somehow my reading comprehension has forsaken me for that bit.

-- 
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de

