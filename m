Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924A8C54E41
	for <webhook@archiver.kernel.org>; Thu, 29 Feb 2024 10:36:42 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.48])
 by mx.groups.io with SMTP id smtpd.web11.21480.1709202996388829541
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Feb 2024 02:36:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Md2sCg4C;
 spf=pass (domain: siemens.com, ip: 40.107.22.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clLOMMyLBJhEsldEA4e4m/WfpvO3+jxSHAGYKqdCKJ8ontDc+f68qFrgmn+KbkTLYu3mtIZmNtSbLPJtdrRO82e6F1xcYvT4nUIs3gNazop5d2XJw5X7P7EqBvisjBi1JHFuskRAc42dA+hhdrmXlY8CJkuI80PLox2tSyFXyPFLrGojfTp832Oqq/TqTkB2pVztQGZr7IfzGdW5UDcUKgK7VJxsJYz7fMI6ge/OVs6u9k5BWHQ+uRPqDTNQ5BnBsj3RBM6Rx5HEls99gzG5iq4fMYcSGdx0e6KTj+x136OPhAyCUOnTUzppZrQsUxyVRfovnYfoU1duD/c+DhVJWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qP8fcCYM5YGatdHVRPQwGyv6xr3FmE8J4LeHgA1Qxk=;
 b=avznNuPgWMVjFCvJlUn9jfXCaq7q0t2EWAWCspNQxBepKaIsY3rdh2dwYcVIsSm0goI526bkW6x5LUWWGFgygmiCnVtfi+hegCEH4mnXPo10BZdzXPAmv6IQpdJa9w3vd/pv95Ur+gKYwB4rxJfKkaFUiMMzR5+DP9k4nG5LtNELj/ArKjfKEbeFyY7zsArZnSX92gcpEe3OsHTa5lZfnOhWHz7XNnvGZZnYUZ07E1KSHbQidzA64kdh1+giAlbW22SBw/TEhvfivz/lpeZQoAiFUZ/3Zx/NdokMfVxpw1e1zqtOctzCmb0SaJbvCtGrEZ2e0kkN6iwMbmTq7tqHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qP8fcCYM5YGatdHVRPQwGyv6xr3FmE8J4LeHgA1Qxk=;
 b=Md2sCg4CvNik5rO1crJIILha9O6Yb4ZjmC2jhDDY59BO62A+iS7Ni/WD7APaqf+z4bWQOTlwfYn0gGN+2xwJRVIvsPTZ2hxoRTM4q1Ok72XwehRq7/mfxhJuLuFUf7vFrcK5faT0B2IKlYn6EbuPgxkYfeNjlvjTkWvv4Tp61GoZDPEUGAjtlOsQQyKo7R25rLeg0RYzVeZWCzLUTviyvEfJYFn5PuEuK4InD+pnZgkTAdTFnoA88f/tBOQMPzxfe5s2L9WjA5kQdyLMahix/ef+yqXRzbTTMdH30gpOyPjfklmiQEKBIFyLqtZHDmKXeMPXhMjA0p9GE/H2dZF95w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5987.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 10:36:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 10:36:33 +0000
Message-ID: <9b591938-6a8a-4e07-a22e-e777f77ced49@siemens.com>
Date: Thu, 29 Feb 2024 11:36:31 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e63e90-c7d9-4914-2114-08dc39124c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OJr8JwPhUl8tsDvI6HDTOlm1GO9x3VtogJXud7HXJscTdmamrmlsyZNCVpFVFr8ITxYjD/0OU6oLX8TZ1pjoK45y2XjUSgVDrUeiHMgpGzpWKruhVUxUqcK4g7WrznvFqCXSS7hEyIjMdDap/kwqI0SlSODGuEoqRSQnYWJZiHV3917iUypIkMTIYBBn9oaGE5v4sRnEcrPgQ1KZNjZ4aPS0PCKiiEe7gdY/Xcb9FbPNKKl8adzPp/CFiipUAXknp9o87unJxkI38Uf6Fv+cgUGrexI97D+6jctUj8DUAZm1zMXRVIJ9yUFGwEcuRMg0MTSCnxmOvdOxbFnDlzE7d4Taih8QuXaAvcwu4fnur25bm8VovJZThgyds8ccOqWttBSVGCuMt3l4I3Y4fhtu8xJFAo7IjP+wEMUIWBAhLEkmC3k5JJWxuv4ehJFIgcl6PGB5vRflF0VGUkScNGwEJ5k5Uia0uLyRoEdLtWZznGOc90AS+WlyXD38E+AVFBLQ6K9SrYvUuaFa/DvHPT18B8aMGHhW3/ifVtNnNI+7/AQ0tmmESJJP27QHqO9ewZFCbadky7DBZLupfhYOictoVQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c09PZ1EyL2p4d3Vidk5qZ0p4b0p0Q0QwcWJuc3NrVEVRU2s1VFNLM1hTRUsw?=
 =?utf-8?B?NkZqS2NQenRxbmUrNjJNczFSaDFNR2pkTzhYYllHVVNJWW12YStwWUwzUFgz?=
 =?utf-8?B?TklXSVpLOXZGUWdIYitPVDdocTRtOHNuUjdDY1lybFpyUk1FdGdGaUZnYXl6?=
 =?utf-8?B?MDBVWDlNVXlibjhsVEN1L1F3TUVyRmhPbmRjL1gvM0dTUXdVbUhjSEU1TDFs?=
 =?utf-8?B?cys5UnYzcXp4K1NMdHJKY0s4L3BZOXluRmRTeEoybWNRMEJNQktkOXoxdHpl?=
 =?utf-8?B?NHhMOGtNQVFnaGtrYkNwRlhoVVdHR1AxNzlmT2orVGd4VTludGN4T0JTdVVa?=
 =?utf-8?B?akZKSkkrMDkvU25sdzBVM3QvME01QlVnMEp4OUpEQnU4OWhmQzVqczBvdGx4?=
 =?utf-8?B?M3ZHcWJkMTgxWVAwTGhPLzJsaEdpWVhWTGsrT3A1L0ExaXFSTTkwb2w0NGx4?=
 =?utf-8?B?WUVvckg4ME5QU1V4MThwVzhGbVNrNEQxWW4yRXNDYVZLS1VIN1lqQTVPU05G?=
 =?utf-8?B?Wk9yUnNmbDgrbkRjK1IyWXdITE1BcjRlQkxmSC9xYkx4bG1JdDlFOEZXem50?=
 =?utf-8?B?MHZiS05TbjN0WEdnWHVHRVEzQUFvUHhBL29FSndKL2ZITURzcVUrcXRpRjY2?=
 =?utf-8?B?K0RiSUp0WGtaTFQvZTlPK1VJRTV5ZHM4aVZXQUpEMGlpajN5elVDUVkyQkZC?=
 =?utf-8?B?Z0JFZDN1N0tnRWpSbVZBTUZRWnZUOWhkL25UYTV1RyszZWpnZHBuUjZDYjF6?=
 =?utf-8?B?eHlCbHcvTVladFNWZWtXVFFlU3ptc2hOZnREUE5DbW5WVFNPYnNuakp3dS94?=
 =?utf-8?B?SFBSRzF6RjhHWlF5a2RPeUxYR25wWFBTc1BmVExOVStJVTF6SEtITHhZdnNW?=
 =?utf-8?B?YUo5WnBOUkpiR3NYZ1dFbHpaQ2lKcmU3T3ZxR09MbUtpSlA2elNkSjZzT1VM?=
 =?utf-8?B?RTJGWElubnNGRnhsY1lEdEJTcllLRVRmdWZxNGNiU0c4blVWQVljSXBwejgz?=
 =?utf-8?B?NUZFZUxZVjk4MmY2TjRIR3ZYS2VtcmF1OFRzYUgwWUJiU2RWRW85ZGNUb1cx?=
 =?utf-8?B?Q1JsNURGeWRRV0xlcGhEbWZhSHF3dlYvYWN2UFZnNHBIaDJWUm9oQjFNUUI3?=
 =?utf-8?B?aVFUMWxEV2dHQkdiMUNxNUVBY05DaTJHcGVCbTBmQlhCN0xybXhsQXI4emdG?=
 =?utf-8?B?ZE9sOW5iOUhDT3FXa3FybExOdDNicEFVV3hjczJSd3NMdmlGd09XOHcxU0Zu?=
 =?utf-8?B?TWdQMDFsZFlBRHo5cURGWnJOd3Z1RmU5SjNFRkJXQ3pBazUzenhGci9EMW5W?=
 =?utf-8?B?VjNaamdnWkNKSEppWGFWQWYzbmttWk1KT0ZFRE9jRkIxdnhnZUliT3BnQXBI?=
 =?utf-8?B?dGRpb0o4UjE5bGV4d0Y5YWh2VUlMNWdJSEp6cVZhLzNZYTBmbkxHam1nNWI4?=
 =?utf-8?B?RVRBYXVSbThVeEFHV2kyYmE2VDZqbGlmSXdHV1JBYjQ5SVY4VnZzL1RERVFw?=
 =?utf-8?B?bDgwcFNqVlA3Ky83Y2cvby9sd2Zrb0c2UHQ0ZGR1UXE5ZlN4cXhkQ1NGZlox?=
 =?utf-8?B?ejJqYS9pYU5CenhWZVRVL3R3ZTJ1Vk5MTGRTSGVmNFV5Z2tmdGpBZVh6MVRt?=
 =?utf-8?B?cGRlanAzWFRMOFhPOXk2WHVScUNPaURNbmVlLytUUU0yUktKRmNYN2FmbXJp?=
 =?utf-8?B?Y2lEOExwY1JnT0tTUUdPekFUcWRxR0pMOGwwYUVMamh0dE1yQWlHeGhsYmlL?=
 =?utf-8?B?SmRVaVA1ZzVUMEZtbmxvaWJKZk0zRlpCa0kxdnMzS0VVOVBGUjdpTlYvVmNH?=
 =?utf-8?B?dUpCWGNiN29qL2dYNEZJSzhtYlBLNXFBdXB4YkpKdDAvS3ZaWVEvUWp5VUpy?=
 =?utf-8?B?ZVBwZ1l0WktzRDdFR0orTXNQMmFhZVBsN3RhNVVCWmsxRk5pY0JCek5xbjVa?=
 =?utf-8?B?RVorMElFMGk5Q2E4VzRiMko5MU5jUFJwZjRKZTFUZ3hwcTVicHoxZDFWV1RM?=
 =?utf-8?B?M3Q1bElZbnZGNjgwN0llLzlxaHVvY2hjd21sVGRtUXVReDNlTmpCSnM1djE5?=
 =?utf-8?B?aHp5dFNYUyswYzUvTmpPRXQvakFwVDBiMlcwYmswOVczdVBFRTB6U2ova0tm?=
 =?utf-8?Q?GC72GiEXfv7EWNdCPoNGcQZtW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e63e90-c7d9-4914-2114-08dc39124c1c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 10:36:32.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXDv1I7BmhgK5bm1QM0+OEyfSiNGcxFnqEq3C1EcCLrrQzm9lhqfQckvbrfv5ZFbuoqN3VxQocGCJDurBUjtNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5987
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Feb 2024 10:36:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15113

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=2&day=29&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/02/cip.2024-02-22-13.02.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
  - migrate kernelci bot reports away from cip-dev [Chris]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

PLEASE NOTE that I might be late for the meeting today. Please start without me in this case. 

Jan

[*]
Date the data is created: Thu 29 Feb 2024 10:32:45 AM UTC
linux-4.4.y-cip: interval 30 day
  latest version release date: Fri 02 Feb 2024 03:27:15 AM UTC
  limit date: Sun 03 Mar 2024 03:27:15 AM UTC
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Wed 03 Jan 2024 10:54:06 AM UTC
  limit date: Sun 03 Mar 2024 10:54:06 AM UTC
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu 15 Feb 2024 09:08:09 AM UTC
  limit date: Sat 16 Mar 2024 09:08:09 AM UTC
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Thu 28 Dec 2023 05:34:49 PM UTC
  limit date: Mon 26 Feb 2024 05:34:49 PM UTC
  Status: late
linux-5.10.y-cip: interval 30 day
  latest version release date: Mon 05 Feb 2024 01:04:01 PM UTC
  limit date: Wed 06 Mar 2024 01:04:01 PM UTC
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon 05 Feb 2024 05:21:45 PM UTC
  limit date: Fri 05 Apr 2024 05:21:45 PM UTC
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Thu 22 Feb 2024 12:31:25 PM UTC
  limit date: Fri 08 Mar 2024 12:31:25 PM UTC
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Sat 03 Feb 2024 08:06:26 PM UTC
  limit date: Mon 04 Mar 2024 08:06:26 PM UTC
  Status: On track

