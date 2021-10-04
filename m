Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91010C433EF
	for <webhook@archiver.kernel.org>; Mon,  4 Oct 2021 12:13:14 +0000 (UTC)
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web09.8410.1633349593394989512
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Oct 2021 05:13:14 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 194CD7qM016289
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 4 Oct 2021 14:13:08 +0200
Received: from [167.87.3.213] ([167.87.3.213])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 194CD7p0031831
	for <cip-dev@lists.cip-project.org>; Mon, 4 Oct 2021 14:13:07 +0200
X-Mozilla-News-Host: news://lore.kernel.org:119
To: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Duplicate messages in archive
Message-ID: <cb92b212-2b64-3517-0ab6-7300bd83f752@siemens.com>
Date: Mon, 4 Oct 2021 14:13:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Oct 2021 12:13:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6773

Hi all,

did anyone already examined or reported that all messages to cip-dev now
seem to get archived twice on lore.kernel.org? See e.g.
https://lore.kernel.org/cip-dev/TYAPR01MB6252C6286EDCA87D7DB8B10892AE9@TYAPR01MB6252.jpnprd01.prod.outlook.com/T/#t

They also appear twice via nntp, that's how I noticed, but are likely
not sent twice to subscribers.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

