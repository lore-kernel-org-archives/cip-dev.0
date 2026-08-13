Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8726C5B572
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 04:55:48 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.63])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12364.1786596946986681216
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Aug 2026 21:55:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Se+nLsAh;
 spf=pass (domain: siemens.com, ip: 52.101.84.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipG5cPBTu1sfJx0TWuqd4e8bV9onW7V0Ijc8hepHpE0LJ2amVeUqgsYx99PcRIJ+7P6GBy8rPVc6SkaINTN0E+GGvwSRKUXU3zhxVhMpkOeDY5OsmyVfrwcNHbhDn9ndNgLHRcU07KUTDeJSpVW6fckdTjMbHEIMEdp1554OOpaeRKDhXy2WKLNCn55sk7r/+QZ5qBX2muSLzm1vPq/LR6QBXcz0VoRn5JyuX9vxOro6DkJz0igQNoVzq2Kb1UkFmJk6O/9S3FjVGbBMw6r19Z8hyy/Fb7UynSWr7yj+rPVvbdLfmY6hhlcmI7nofm6+3i/ZwsudnYdAQmvkJ/b1nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wroVG3wRxo9xvu24Jx8T2HjP5xDbOXoo2clh7p6aRoU=;
 b=zNKg/ZfZxBHHbLGhAryTzV70XlX+m1turvOAXUFRs0HDYc0WgiMORvbKwzMh+JWbDOj3R4U3g/cqoQuEnUOhyCQZA8YExqwCBYf/WzeJbEh5SB/GDE+5oX2YsXvRQ0ReU9MmGSFD6jn2YVAn/F8X/szrUVQH45Y3PaI9TfbsPN2DpnnXLYmHq+fWYx3JbNbWYiYh4Hk4O2ID0rRimIr8thf17lHMqUwXmaaysWjsvtHXyEgpzKEp9PhfRMd1vUVQYZfSjDfrDvsQSj/KaHnnNcMSukkgmdbFkgRa1f2Z+Ga8Wjv0Lg99Uqg5VzDcsOcJjpweItn7SX7W0vxNNnSOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wroVG3wRxo9xvu24Jx8T2HjP5xDbOXoo2clh7p6aRoU=;
 b=Se+nLsAhMH6qSm1H1suuRQMcqu7hsg8FjAR3nMS4u0H07VB9GxnnRQwGY4fSwqC+EO6p4+rKvf7qycjaLZFQtdgnLBZIWHMfdkAo+Q0jMvof+9lRausHBYA5Zdj/7jbTU26UrwBb2WurHgHPvUeSCEUthodXPGokbFw2Adt97rAAh6M0y4DLFK2W3FIDFk+Dtxj67FQXpCEpsoKKm1sspqAItljdHfoQkNrXPkXBpg3QQWpRJZdDW35xBxxpFJM3NNFPGXoyPuAGH4eW+zUKh94JheQjH2IVbyn3fy13TeDjn5HxPitCZ78ZPWhbqQMEhH8dzWbzDz4d+tpnmsrXAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3258.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 04:55:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 04:55:43 +0000
Message-ID: <7a99ab77-bbab-46db-bd0f-159cc493da02@siemens.com>
Date: Thu, 13 Aug 2026 06:55:42 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3258:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ef9981-ddf0-4f83-bfe8-08def8f7210c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|56012099006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	3pyqIRvU1luGpWpnzwzDyXoN/5m4he0UiizG2PpRg2K/2/+qX51O0wyx+rqUbaq8/2Y9iWRv4OYCYl1CsctIJHieKBYGi+91QiuQAjE65WKCdx/QvI4VfCu+fU2Pahxs8XCuK+kX1RsifhnoKBxoPYOPqAXwoNM67SseadwkbDJ7Mo+jWO7Gb6CpR2RL6Eo0vDWqEr78zC2qg2cX717GIsf10RJ1bcYcNH89s2xVUoqaOP4dwOXKIsreMs3o2CVBNpdaElP3JQxMTwRA6olgxLhnanPipyJ8o7ph5WCJrJtXKSuErEPlzzcPzNs2WMiTBpdhFdUyDfcmpjCKJ6PvasiYaOnCwuM6ovlFn+2DJDl3RHkbVGcnffDpXy+WrXYdS7dYth05pZEuoUaVQJCo7ZksM/dq4Nb6ABtz/RW9kUrF7Dn5womdnSXCX+sBR0fCrh6tqm5PV86Dm0jtXo8iK9O6K9uHxlHTnu+NQE/S2CoZcFYVN0JqjqoBkmfXuoQfsDQP3NhZep9tJFg6K8VK6wHrbrjAIZ7W1E+KZ/48XjRzQU4QNPRSltSQjP1tR/jr5M+svbCkYKXVjx8V9ooC4dFlEz3EW4foRc7vFurMZY0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UDNBQ2E0czFYb1hUNzJqK0RFQUZ1NVVqT3MxNGRZTW5ONHlSQnVvR1VWdGxW?=
 =?utf-8?B?KzBwM3lpMDhpZyt0VVBzQlJCSmp1MWtWYzhPUW9XOCtRdG84UkYvdUxzNjRV?=
 =?utf-8?B?Y2xUaDJDWFNPcHFROHB6czNyKzNGK0hxOUF0WTBmLzBNYUJJQ0N3bW91eHAr?=
 =?utf-8?B?U04zc0lUOHVoTXRVYW1qTHpxdFQ0dmI5QWJZalo2emF5bWFOTTdEL0RTVUV5?=
 =?utf-8?B?TUhXR1R5dWZrTXE4NkYwU0w3OUhVNWJ4ZlBnZjRMNndERy85Z00ydjRPMjQv?=
 =?utf-8?B?OFNPdXhtVEUvMnZFWmhTMDlUWFh4elM0cUtUQ1IxLzdCTis3WkVkM2JQUW1y?=
 =?utf-8?B?eXFmQ0xvTFRBNDFsb3h3VjcrTzYrc0ErOTdTZE80SXNiT0Z5WGpzdlRNQ1R3?=
 =?utf-8?B?NXQ1T0lFSFZ5NFZLOVplU2pPeVM5TFc1UnBQM0NaTkdSRFkxQ1dEaW1KTlFG?=
 =?utf-8?B?ekV5NGdZTWdKV1ArMzhOenhzSmFxWk5JMVBpZDVFZFZ0d2FyZE4vblF1M3hS?=
 =?utf-8?B?SmRlell3QnNQcUIrekZpMDRGa1ZEWittb3pCM2E5STA2R2MxUURmWi90bUw5?=
 =?utf-8?B?cWtQMWpEOXRSYkJlMnlzYXFhY1lnLy9oUVZocWRTcHJtMy95WVh2M1crMnlO?=
 =?utf-8?B?MFR5TVJZTk84UnhKeHE4L1Q3MlJ3WFFSU0YrK0dlTllIZ2p1VVZXZW1xNkYr?=
 =?utf-8?B?a0VsOVpqb1V1M2dHd3lsVXJEeWphRlNBc2FGZ2dZV2NwQ3FxK1MxNDhDQWJr?=
 =?utf-8?B?cldTZGJtQ2ZLSWowYWlBd05MZFF2eWk3ckIxWkdmWVhaQjJ6ZkNkbDNWUzN4?=
 =?utf-8?B?QmMvZjJieGJkeUd1ZHNXa2MyakhaamgzWll2dXJBS29lUEFmcVpUNEJNQytN?=
 =?utf-8?B?VzVVVG5YYXdiNjF2VlFGbjVBa0kxOVFJTjZCVjdjTS9pbzQ4ZGdVN0VGMnBz?=
 =?utf-8?B?c3hVM3J3U290V2JpSDN1YWJnMVZuSHFWRnZoRzBaeS9tZmQ0aExCZFJwc1Yz?=
 =?utf-8?B?ZXhQcmMrcVFTOTBqalI5QnVPR0llMDRpOHJGODlXYW5MaFBuNU1GRTA4d3Qv?=
 =?utf-8?B?aGcwRmwzd3Bpcmk2MUlOVDNmMEh3aTgra3FBZzlSU2x6UTdyaTYxR3Fhd2l3?=
 =?utf-8?B?Q2JjZy84ZW5vRWtDUTZMTXUxWWdOaHlJeUZ2a0V1YVN4RmRmZXErbHNJdjJW?=
 =?utf-8?B?U2lFcWZ5SkFBLzR3bzVkNzUrdVZWVG9EUVh0M3hCcUJyMFdTaTVNS1ZwUHF3?=
 =?utf-8?B?K1VqbTVJWDZFVE8rbUxFNGVqLzkzNFVpWWZMVitrN2FSZTc3MHZ5eUJwbXM2?=
 =?utf-8?B?MzQvb3RsR2NVM0FJT1lEdUdsVjE0QUJxZGxrS0d4dHV2aWVJSzJ4aTJENVln?=
 =?utf-8?B?VjdoKytuUFRvTkRnTUtSS1hnWGNBK2ZzamJyRFNhRXl0Wmxxc2tOYkI5QzVo?=
 =?utf-8?B?VWxKeGJ3akxOQnpYVVMzYzZVcTBBMVMvdmpzS0VYSDk4NFkvcUw5NEF0QlVj?=
 =?utf-8?B?TnpiLytmOEJ6QVVGZzI1MzVKNDhlajV2SHBQUHZ1NHc3bnZ6NnRjZ2pCamVN?=
 =?utf-8?B?c3BOckxwdXBER2JXV0REOUVzeS9yUk9oaDhtdjJqVTVKbDBCeE9aamlDcXdw?=
 =?utf-8?B?RXNzRjdrUktnQk1KY1hleDFFNVhGMW9EMXBTUU10T3pCRmIveXlEVWhTUVUx?=
 =?utf-8?B?TXNEb3ZSTmJBQ2o3NFlZVDBoUVMraEo1RmhOWUpXaTZNVGI1TnE0TlplbDRw?=
 =?utf-8?B?S0JSQmYyLzB6VHVwOWY3ZzE0eTNxWlZmRUc1bU8rQzVxc0hUdU1NVXdNemUv?=
 =?utf-8?B?S2NYUVYwVjN3MFhFNEk1OUVjVjM1Z2ROL1hlQ0tBZFBMc3hNY0VXblFEZDJL?=
 =?utf-8?B?MWtNd3k1RExqSUJzaVByK0VZRzltWE11bmVBdzFBRnhNaDl6OFE5cUQydzJz?=
 =?utf-8?B?MFNFVmlHRVpBR09yM2RQR1luSE9ZdFVqVExyUS8xUHJSOWJkbnZQWlhDZDc0?=
 =?utf-8?B?eU0vSjRGRS8rUEpnajhJcWxZUkw4MngwY0o1SUQrUXA2d1VERVU5NWI0UldY?=
 =?utf-8?B?OVN2R2ZJWlpZN0dtZ1RpRXpxS0tBS3d1bjZrRlUxUUJIcmxwMlJFR0ZUOXUw?=
 =?utf-8?B?OUxqUU1BNFMvTkl3aHI5UnFjbnhoUzRjSzhoamVrUFRYQ0xKTFgyd0Eyc25E?=
 =?utf-8?B?K0dSYy8xSFBGUHU0cTNqbUdEeStYaGlRNEV4SmJpUWNMcUhKZ2g0YzRqQlBl?=
 =?utf-8?B?Y2d6NFg1ZUFkNGJscENoaUNvcFBlWVNzM0IyUVJmT3Q1b1MxMmsySGVCdmxs?=
 =?utf-8?B?VkRrREF4TXNHeFdBM3ZMbHZLdWNyNEhCN1ljUCt2RjZvdFA5ZjFRZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ef9981-ddf0-4f83-bfe8-08def8f7210c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 04:55:42.9918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyPo6XfaCr7et4qGTEzKry5FfaRHS4Uuk5GYWLp1pw12JBKtnYp2Fcr4h2n0hYyQjllb2a0bWEyJKj3r6hhd2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3258
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 04:55:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23908

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=8&day=13&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/08/cip.2026-08-06-12.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Aug 13 04:51:28 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Mon Jul 20 10:00:31 AM UTC 2026
  limit date: Wed Aug 19 10:00:31 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Thu Jul 30 09:07:13 AM UTC 2026
  limit date: Mon Sep 28 09:07:13 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Tue Aug  4 12:34:28 PM UTC 2026
  limit date: Thu Sep  3 12:34:28 PM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed Jul 22 07:47:57 PM UTC 2026
  limit date: Sun Sep 20 07:47:57 PM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Aug  7 04:22:30 AM UTC 2026
  limit date: Sun Sep  6 04:22:30 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon Jul 13 07:40:40 AM UTC 2026
  limit date: Fri Sep 11 07:40:40 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Fri Aug  7 08:15:19 AM UTC 2026
  limit date: Sun Sep  6 08:15:19 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Tue Jun 16 12:51:56 PM UTC 2026
  limit date: Sat Aug 15 12:51:56 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Fri Aug  7 03:53:04 AM UTC 2026
  limit date: Sat Aug 22 03:53:04 AM UTC 2026
  Status: On track

