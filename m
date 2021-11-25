Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27544C433EF
	for <webhook@archiver.kernel.org>; Thu, 25 Nov 2021 07:12:19 +0000 (UTC)
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web09.9143.1637824334582453855
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 23:12:15 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AP7CCq4007214
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 25 Nov 2021 08:12:12 +0100
Received: from [167.87.72.134] ([167.87.72.134])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AP7CCLU019739
	for <cip-dev@lists.cip-project.org>; Thu, 25 Nov 2021 08:12:12 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Message-ID: <7858d3cf-d7de-e395-0602-0185287f3275@siemens.com>
Date: Thu, 25 Nov 2021 08:12:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Nov 2021 07:12:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7011

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today.

Please note that we moved from Freenode to libera.chat. Our channel is
the following:

    irc:irc.libera.chat:6667/cip

Furthermore note that the IRC meeting is now scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2021&month=11&day=25&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:

https://irclogs.baserock.org/meetings/cip/2021/11/cip.2021-11-18-13.00.log.html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu & alicef
  2. Look into S3 artifact upload issues - patersonc
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

