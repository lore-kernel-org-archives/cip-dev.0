Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B136C433EF
	for <webhook@archiver.kernel.org>; Thu, 14 Oct 2021 06:10:37 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web09.5574.1634191831340002076
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Oct 2021 23:10:32 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 19E6ASU5015128
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 14 Oct 2021 08:10:28 +0200
Received: from [167.87.2.42] ([167.87.2.42])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 19E6ARnF004158
	for <cip-dev@lists.cip-project.org>; Thu, 14 Oct 2021 08:10:28 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Message-ID: <84786ae4-0286-050a-5206-770eae06edc6@siemens.com>
Date: Thu, 14 Oct 2021 08:10:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Oct 2021 06:10:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6823
Message-ID: <20211014061027._wR7GECir6LnHCp6fCnS9gcdgOf691hCdg8r0Dy9nLQ@z>

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today.

Please note that we moved from Freenode to libera.chat. Our channel is
the following:

    irc:irc.libera.chat:6667/cip

Furthermore note that the IRC meeting is now scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2021&month=10&day=14&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:

https://irclogs.baserock.org/meetings/cip/2021/10/cip.2021-10-07-13.01.log.html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu & alicef
  2. Document new LAVA domains in wiki - patersonc
  3. Look into S3 artifact upload issues - patersonc
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


