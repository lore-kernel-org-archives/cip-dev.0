Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D916EC48BF6
	for <webhook@archiver.kernel.org>; Thu,  7 Mar 2024 08:41:38 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.42])
 by mx.groups.io with SMTP id smtpd.web10.18840.1709800894247460474
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Mar 2024 00:41:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mlIpZgk0;
 spf=pass (domain: siemens.com, ip: 40.107.8.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IX7N+u3Nx6G62lbppDbNdr6jGqthBd7Q+ed1seg0i3Ny0tFnCJCHa1lfiVL+B6lyaTR1zWuMi0YdaM1sx+WFNF/8syliZj+vQloZfy3WU0KvfAXpQGgCAAnE/GevZkmqajDS57+3nl39Wdqxk+WTkIqxjx8ZSWZfbSe2kqQgg+q4gs/7yM+HXTLAaFhW8i80K9JtrQyerQn7u/y1pwj2t7aITHCjXJcGmndk7Yr0A3XG+zagHlGYPxsQDs1qMSQGRbM+W5lbegCQlDrOXD/kd6EMmkIPol0rdinwrzCPXpHKMQKIF2mPUjRyybJXfkArlbyueCsu04+uFZYwXd0ngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXlxpQtzEK0KZKvMRBO5TEFL9vI8HLoaEtaZstSgn/I=;
 b=NLxKjK3ZcaOxruU4LbhYbZXBJfBjBn+WgzYjfBbeNm+S6XQGHb0pr3KFESpfh4HeSxZ23uFp8axmVkPbuzt/b5NAyiu2HUwE0Covv4v8k4e8zlnjWXUOD5PNEmAwkayqYDfHOK4J/ZhLU44c8xmZO++70Ttvz8+8/oFi9BeooC8eIzDwj1a4ETUtHKU2ZuK1sy53pfOOij/Al2vaK8ERO4YS0YJjVzNMWCqg3TLx9DJ//PyZiihLlOU1p8WdIhqOki3IV2yNKhYohT83IGYUkvhAc2zG6GFYAre7DXgLqM5HV6utD86LgNqhdWzqoPeVzQ1zrlTN/BeuNApyG6mmSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXlxpQtzEK0KZKvMRBO5TEFL9vI8HLoaEtaZstSgn/I=;
 b=mlIpZgk0k7SOZMmzCGEYD4FQEqGFe+nQVBOIQNeWYmtBkznGZCXIjdpjOYMily32w0nZaEPp1MjP4VpK9MLlz1SCPrY3D2ubxfYqNgv9ArTU+ZxzwCy8mAhNxxkX/WmlZyBzP6m2u2lMxFIinCyWY8QQ/CpKQ10FaBF6GyisNGvLPaYRYuyDmfLh4NeDsguNIXp2tqes1Mce+LsQk0J24UG+qX/Wl1GiQtL6ZyXibW0K60onNMOSKKISaV5zQHGBPDkCznFD8bhTIAvdn8JX7FCD4D4j/HIT5Qb027geQe9bL4f9nAIcQH1aA+P7lMtyOf1nKTWOEgZRrrLUWa7yEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3781.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:167::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 08:41:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 08:41:30 +0000
Message-ID: <aa46b60b-8e1e-4a6e-ba84-bdf9d77982eb@siemens.com>
Date: Thu, 7 Mar 2024 09:41:28 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3781:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d358f22-5ccd-4b21-9071-08dc3e8262e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	C9WeIqv+GXkHkLYJK+qtBgjBwKPib/X7ovLrZtb+Te2G4aC7zLcjBgUJX0pT3OvhyrnkqvoD5Ct0SaLiO1Vguso9lL6KmirwYEkkreK5ZP442bDfuVusAmRdLuw+lJdi0oEJtW4LG+Fk1ILNPz3o/rHjFCHTvZnm8BbmtwahUOFE+iDHemr+i4HjLO1dtqijzVz+utnlrlZVuDRhHnhAxiJp4FQWTAliQ049zZCrrTV91mcz6yyaKEjlbRzm7n2w5lZc89ZTdQt4UNpMF5UbpXJvmKve/aSo7GEdEnJ3l72QumLIaFLhYgxpLhPVe+VnGxLoJDwnJowq1JK6Wl5jxJfRtJZWlYcO1txlGDcCpW/vB3UngSUV/JVpNlE3vcHHL3rUKuxlx1c1wLAtOk2vkV0B/o17LDdDEAqUU0sHV/ZHIevG0Gm1kdf6U4itdXt1BtL+gHrnqBSfi9MgatDHDNYkn2QWy69gHTEDEKDQ6FXSB7e3eiOkZdXuEtjN7j0X9wKqVycw1ltc6UDM9qy287bl59ZtTYHDXD6BsJLj46Y7D/hEcka85Hc2V9Vf/yptLAtjegczmIKEY1c6VBlSR9RScFcxJ5MI/ZxcX+oLbs8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aHJRUlNkT1BMZHc2dG8xY3JoZTB0V0RGRkhFMHBaN1pqNFNZeldic1ZTTm84?=
 =?utf-8?B?Zm5jYStLMjlOVU13Wnd0aWNUYkZvWGtTckMrZXVRZUtaUmNielNpQnM5dlFP?=
 =?utf-8?B?NlRMeHZHYks0bERyQ1lNZkZOS1VTNXY5TmpGTTVmWWd2RFlIMWEwZEZXNXl6?=
 =?utf-8?B?UHBJNzZPRXl0NXR4SGdnT1VMYW96elFhdWRwUW5UWVZYTDViRW54Z2JDSU9p?=
 =?utf-8?B?R1lJdTk2S2FiTkp2TFBubGRlQnRQMUxOUmNDazVaZnBQUld1bk5YcCswU25s?=
 =?utf-8?B?RnRRY0xvNFZaL01qSGZZemhYd0w4UFJTWGNzR1BTYXJYSHpjVUI1cnk0ZTdm?=
 =?utf-8?B?VDJveVBaS3IzQ1pWVEhRYWF4Smc0VkRBRW1UbmVoL3E2N0dZbThtYkhEQXQz?=
 =?utf-8?B?bURlY1lHVTA3anpFT25tOE12UlNKT2tVWjV1ZzUwM09HeTdUTHFjMnVoNUV2?=
 =?utf-8?B?S2lremUrekJBaGxxNWtNckZQQlYrRXlIYmtVZWttaGd3WlJzRlVuN2YzTmtu?=
 =?utf-8?B?cXU3bXZCcjNNNWFTN1dKMmEzN2lLOFdLUTU2WDd0MTNYbWFRTms5aWYzRDlJ?=
 =?utf-8?B?ZVRnays2TW9YZ2N2c3ZWeVdzK3JLcFhKbXAwQzY3M0pwMkZrQlkzZjE2VkQz?=
 =?utf-8?B?SzJqaGdsN01hdGJaaFNGZ0lYN3I4cGtyazVLR05BOGVYdzY5a2tTLzVlVWtx?=
 =?utf-8?B?VWNyU0pVMWczU3dDT0hFbUl1c013b1dGVnhKUUZ2amROUmpPZlZaM3lEQXEv?=
 =?utf-8?B?SUQyMEpFWEh1eDVVdWlheERyZXE2U3hFU3N5NGV6Yyt4cWUvRS9RRG1jeUg1?=
 =?utf-8?B?L0J2cFVOL2dkcVNSUXRVUzVBV291czRQMkJtTFpPazUrUEhmcGVkZUR2dWht?=
 =?utf-8?B?M3p6ZCtHTVY4VnRsV0V4dU1zYk1vNFNRbjBWS3dpN25jWVJBbFY2QXRYQUVU?=
 =?utf-8?B?Ykx6QitKTm1DWnNZU3dlazkxRjNrTVRwYyt5K0dETXlIZVpiTWhpWXRDZk1h?=
 =?utf-8?B?MkdyeVNiVjdQcGhiRjZEVnh1YWtwS3FucU1jTU5BVkpoRFFuV1h3bDFuaWFT?=
 =?utf-8?B?TmdGYk1WN01NTVluN0JIMmNYZkJMZWxlUGNUK1BCRlA2L0RhaWFTRHVJM2FF?=
 =?utf-8?B?VHRlWnNCOVEvMFdCT3JPL0tEY0dwUGVmdjRmV0xISWVwT1NyZmZPZFM3QTBX?=
 =?utf-8?B?SGlaMExrN3NDZW5oSkVQMGM4NWFUNmRoSXo2NFZ4aWl0MGlZdGpmdWVYL2dy?=
 =?utf-8?B?OGhWTU9WTWNHVVZnL0FNdWNZbHlmQmxjZzg4TXBRR2FIenpzelJqQ2NWdDM5?=
 =?utf-8?B?aHlwbUlDcy9VTHV2K1I5aVZ4cENpWE9tR0RZRjFqNml4SnBnc00wM0haRlQw?=
 =?utf-8?B?NDFSWmY1eE95ZHNjM2NwRkVFV0tnSVlOODZKTkkvYi9jeFRYRVg1TllyblJk?=
 =?utf-8?B?WDhwK0czaHRZS3hveVRVaEoyVzJWazNQQ0pzTkZZaDZiV0w5bDhGQjhXelhJ?=
 =?utf-8?B?d0Q4NTlyZU5tY3dMWHJ0Vy9KaktPNjBLODdHT1YvMGsvZHNrYlczbzd5Zit0?=
 =?utf-8?B?anhZaFp0T2g4eVZuNlk4TkdEOHBlUitxbFdZL0d5NjBmZE9WOFhwK2QzQXZI?=
 =?utf-8?B?Y2VDZHYwMjE4TERKT1RMK3BJMFpVRGZjSm1Zekc4TWgxR0hCRGtBNmMzOU15?=
 =?utf-8?B?ZXIySDlrSnRhNU1ubUpMWkdqUmtuZGZHcW1LY1VpcHdOVkFHdEhlbnEvV2pR?=
 =?utf-8?B?NlcrVEZMWW1Zd2hrMXZxaGU3RUQ4UVVnc3ZmM2NJVTE3cWpybS93YTZwU3Fp?=
 =?utf-8?B?ME1tRE1XTkd4dENRRS9SMnRGUGFFU2J5TU4wSGlCd1pTa0NJNnU4bitpeUZi?=
 =?utf-8?B?NHBmZUUzNytBQ1ZvTDRwTERRRVhNS3dCOXdud2RpbjBPRWZUa0szQnFMY29a?=
 =?utf-8?B?RGFiR3R6Y1lrYStnNDl5a2FVWEdtNnNsR1VnZHJ2M0F6OW96dFlYVEMzWDI3?=
 =?utf-8?B?T0VjMUliVzdtOXRKM3BFS3l5QTFsNjNLSXB1SnZxNko4ZGtudFUxWldTejJB?=
 =?utf-8?B?dmprM1haZ0RlTGpKRWtBdWp4OXJjbzA0cnFPeHhLM1ZML0w5bGU5a1ZCdWww?=
 =?utf-8?B?SzJRaGp4cnZ4cGtWVW0vL2E1bUtBUTQ3blQ2TFRNSG9oR3kxc1dUS2Z5QkZY?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d358f22-5ccd-4b21-9071-08dc3e8262e6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 08:41:30.6564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7t+gF6NQX3ulZyPKFDtZK1Ikd9XQl9C6NaOwRbhIal+F/KFkgr2CQtOUS10o4q4kNB8XCVz9dbBa6kn3f9x3Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3781
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Mar 2024 08:41:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15259

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=3&day=7&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/02/cip.2024-02-29-13.05.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
  - migrate kernelci bot reports away from cip-dev [Chris]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

[*]
Date the data is created: Thu 07 Mar 2024 08:41:06 AM UTC
linux-4.4.y-cip: interval 30 day
  latest version release date: Fri 02 Feb 2024 03:27:15 AM UTC
  limit date: Sun 03 Mar 2024 03:27:15 AM UTC
  Status: late
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Wed 03 Jan 2024 10:54:06 AM UTC
  limit date: Sun 03 Mar 2024 10:54:06 AM UTC
  Status: late
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu 15 Feb 2024 09:08:09 AM UTC
  limit date: Sat 16 Mar 2024 09:08:09 AM UTC
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Fri 01 Mar 2024 08:49:23 PM UTC
  limit date: Tue 30 Apr 2024 08:49:23 PM UTC
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Mon 05 Feb 2024 01:04:01 PM UTC
  limit date: Wed 06 Mar 2024 01:04:01 PM UTC
  Status: late
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon 05 Feb 2024 05:21:45 PM UTC
  limit date: Fri 05 Apr 2024 05:21:45 PM UTC
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Sat 02 Mar 2024 09:15:14 PM UTC
  limit date: Sun 17 Mar 2024 09:15:14 PM UTC
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Sun 03 Mar 2024 05:34:51 PM UTC
  limit date: Tue 02 Apr 2024 05:34:51 PM UTC
  Status: On track

