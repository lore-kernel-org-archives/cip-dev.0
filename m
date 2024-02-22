Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C503FC48BEB
	for <webhook@archiver.kernel.org>; Thu, 22 Feb 2024 07:12:35 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.58])
 by mx.groups.io with SMTP id smtpd.web11.7888.1708585950958496043
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Feb 2024 23:12:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kBgXeKQs;
 spf=pass (domain: siemens.com, ip: 40.107.249.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mR7ky8eUyAxrfx1rXvRJOtocp9gJ6NrRaca4SkHZRIW8ncRd680IXdQ1FlKludF1GCikGN6SaVoxRKH3U0wxSbs9WBAM5iX0MHSzHetPqDMQJzPNdXeI+LFHtxVGE1yb3Brz/XMYM3ZxjFUqE6FT3LIR65XwhXHkThJShpkjwooad3Vp1rykcsNurrlTlmWR3Ezxja2aU3BQ4fTBsAacGHpvEnS+6oGYzq8aIM9JPQ3pmkWaqlO6SFeCcQwo48c9OBCRnM0c0hjCNk4qa0gheGzDWeOse7w3GaHVvp0Sup6E+HvKc6zK7UzND+yTuFD2IkJnbCrTItNoMzk+/7a3wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ubeSd6VE3kAaoTmZ4F/yQH7L/unaPoyMSxhG8BVXrw=;
 b=WRytjHg9anIIK5HBGEUw86ZjQQakUOL/h1nD1Ki+HTx2tlDTXn/YTTsHi+HXxxgIihdT3xFd64ZvhVOiiOBGFAtbvqEqkGxssz3hWsUbDLz0BkPMDt/7qxWHHzei49gzJZQuNVTBQ+03S2Ze5y14fris9SJPyWgus6OUmsGQwcDU3o0GIYjMOblh7jfTv1OtzzhIwTGg01pS3opaBT107K9MViuY6i//VHxgbszXw1bN+EL5eQp43iWVVklURF5MjKeFnH6/mqVWOAWZfJ357jZ3fVjUjt6blUlVdeZO0+QIKNogZr03m/IOYiD8jVYt32l4LolzRlxZwwPYHec6AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ubeSd6VE3kAaoTmZ4F/yQH7L/unaPoyMSxhG8BVXrw=;
 b=kBgXeKQsnd9br0asUcpWPR9Kc7wFehH9XoToWJUP0UMAjXKJ8+xDI+7oLCPpMC9tNmf/Bn24oSTALocvB0cZEeSyOHOPr5y8WSiD8Xlg47p21zYvjjc9Am9819asn4/c5e/heDmw2LWRZAZWOD4Ng+cdhmpEsXZwIQsR/kfUJXCS9dze2SdQ+JlF7fPGhVWtFzviAoupOcshq0or0PF/Etiya/Zcm+iN0cBjGhVZVtbP1t/sVV0vByW6smjnVoxIFUvbKmNCrvb/O3RQ/63rQ7lYL8hVt4E93EMA2KOZcCcp99+IBlFAhnS1Jf8+KtbA7D+a8szMVxyYWuy+QOcwrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7409.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:462::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 07:12:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 07:12:27 +0000
Message-ID: <fb2cca37-ee57-4cb3-ab48-e1eafce497b8@siemens.com>
Date: Thu, 22 Feb 2024 08:12:26 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db12062-a71a-4fba-1a3b-08dc3375a053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ewHxyHHSwFqXJGdFl5wWE3nidZwLZ3nteoeiVcIn/5oChcWNKPOw1yrkrszMY/WEnNW/SDHoX9Mt9oe4HNmuyuTh3mv6x/Adso4S66MKtTYnT1eus3QYnjzDITtWogTAiFGrFh+yf324HiIz8JVqMBvpt4839iBh/Cy+J0fLfgg4flT9lvY9sQQfqjoBSQz64or8E77abgiH/7MFWnnVmXKsWHbHx1F/38FggMMaCQ2Xf04tlmew1VQWv8UW0gPKY2OD3SPcYnZueClD4kLPtihncEpzmszh36O9GwIxFR5cBmfN8e8IuSwypxo1DSJxtH1TYuGoocfVEWHtN7QwG2/G+GQr+P4KBw9r6vLeef+LxAMjCCXiceC2vXYFN2QnFqwfYrW9o9ZTFpuqmHItk4tAqJ3KJtTqeAg2ScV9vwP1dG1wfp9YmQuo+e0OND2n4h9VwDV7CBzvHBF0EGI9pQ6OBm8mVLmcLdptWtzu8+Lsg93a0e3YcNIQjGF7rPHnC/xwrRIwlpn3PBpugOcaYg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NEwzR3VlQ2tERW5yUXF1Q002alMybXdpYmkveHN1bWljQ3BoemlmVzJEVzEw?=
 =?utf-8?B?bEMrY2FnaHB3ZW1FTE1Ea24wOWt4ZkRKQVMxbmhqRVBheEU2c09CcUdoUmZj?=
 =?utf-8?B?OXJOTUpVR295WmMxY0pkNGtaOWJwNUlSRnhHVzdpVWY0S0xvVHlLT1A0d2Zy?=
 =?utf-8?B?VVRydHQyQm8yWlJoRTlheWEvWUd6NkhkZGdYaWxDVXVrRWVSTThaT2RyN204?=
 =?utf-8?B?LzdrVm56Y0I5Q1RaMVhzNUx2T1lMOG5NREJvcElJMmN6ZmJPOWtBeDNaNEow?=
 =?utf-8?B?bmRxYTVwMTJEVUEwZFlBTmtPd0NyUG9MQzFrdG9OSlZDRUR2NlVPUjN1M2Y4?=
 =?utf-8?B?Y0hWRlE2eElIVzNwWDJ5QitXMURjUUFaQmRhTzdMTGgrKzZSdlYxeE9mV2gz?=
 =?utf-8?B?YTBVckMxZVNiV2tmU0QxeEZVZTl3L0pYWVJiRVYvTDg1M0Rsa2JFZlJST0pX?=
 =?utf-8?B?STV6VmtkcC8zMDFsdnF6SnAvZUttRzJMVU9jRkNzRk9SZGhxdjdaS2dQTWxt?=
 =?utf-8?B?ZnBOdlU1TTFEQlA0R3REa3pNOUZsU0pEN1VwWXcyakVCalZ1OTB4VmlZMVFo?=
 =?utf-8?B?bm82ZTUwQnJvSTBoSmVWR2dyc1o0eFJsU2RUZytwWERHdnk3VWpNZ0NFSjBu?=
 =?utf-8?B?eXlCMmdTWVgyWFNPVXo1UlAySHkzNE9Ja0lmcXB2THZZSlRIdnpPc0ZrRUgr?=
 =?utf-8?B?ckZNUjFvVzdrVmZ3U1ZhTnoyeHBtZys4LzVtMHZVM2wyTWF0MmZzMkY0NzNB?=
 =?utf-8?B?TlA0VDhZVHYvQnMxQmdNQWJ0T2RVL04wR1JQQ2NMN1FZTCs0MFVKdmVGTGFU?=
 =?utf-8?B?dDdyNDhadDJLZ3ZNSngwZVZ5dzBnQTZ3UGswelVPdGc1bHp2bmlsdG5GVWRK?=
 =?utf-8?B?Z1FQRW9wU2RXZUdEU2xGTS9WejN5WjRpNzBKQTgxbUZTRzRuZmlGR0dRTldn?=
 =?utf-8?B?WjZINzRnb0VqMm5rNU1pZXpvcmU3TmxKdnJDY3ViTGJoMy9Ea1kvcnNydVVx?=
 =?utf-8?B?N1dDcDFNUGVMcnlRVVd2eWgwTW9CbHdMYzRZbzJMTVI0bWVtblJuVzVWaG51?=
 =?utf-8?B?enczU2xrb2pJcjQ0ZS9tcVRkOFVwWVdPNVgxbGpMMnBVQU90Q1pQNXlhZDg1?=
 =?utf-8?B?VG1LbjlDaGlkL0tKcGttdEMzeWhIWDNOSmVDeVZMR3YwSW11N0JyZE9MWE5B?=
 =?utf-8?B?V1laODFCTmd2Q3dpenh1MUd4eE1WZ0RTY1AzUDZSYjFRaUxobytkdkQ4MkZ4?=
 =?utf-8?B?VC95NDZsa2JRcVRMZjNwWjQ3eHJrV0lsQTVORUNqaWttMzVVV1BlMFk5Mndo?=
 =?utf-8?B?Q3lHcWgyUG80NkF4WnVyMlJpTDdBd08ycmJvQjlqb2JZdjRwLzV4MXFrVlZW?=
 =?utf-8?B?VGhJOTNrT0FuTzJtUnczRk00MjlsNFN3dXdVaWtObElHcERuakFtYjE1a3Fi?=
 =?utf-8?B?LzN1QjJ0SE5jajg2eGtnaExGU3o3NXNPMUpJdGhVTG0zYnoxZHJxVnh5SWZZ?=
 =?utf-8?B?SGNFMzBxZUlCek1rSmkwU0JnMXVOOHVFSFhONDJiWTArV3FOdTVrSEc4cWZn?=
 =?utf-8?B?dDBhL1A0NGdKZUFLeEZYVnhaZEliZWNQZGVhLzB4cVgzRHZ3aEdsT0RmWTFy?=
 =?utf-8?B?VzhpWjFScjVmeVpoQlhKWGtkV2g5MWorRkFDcVc1RWVhd3ZNVWdES2EyaUFN?=
 =?utf-8?B?d0ppSXp3bUsxZXZKZzlWT3lzNGhLYnJjTzFxNkY2a0hTN1JzQUd5Yzc5eWp6?=
 =?utf-8?B?Sk9sbkRSQURvTUs1VFUxTGF3YXlIN0NXS3dsSGovSmREQXJIUzNLRHFPc0lu?=
 =?utf-8?B?MDhBcllTTzN4TVV4THhYUWs4b3ZicytHZWFGM1kydTJtVlJSdXdQL01ucUdD?=
 =?utf-8?B?UFNYUklpR21PRHFyaDFZL3RGckJRS3N0c0tYMUgzSkNqUk5lNGc3YWVaemk3?=
 =?utf-8?B?SnllTnd3Yi8rQm53eFYveFNtcHNCMjhSaTFHS0haY01jNFBhMDMxZU9XU0pr?=
 =?utf-8?B?UG5YeWR4Y2NDVXh0Q3phUTM5MnV2THR6anNrZ2ZLRkhBWVBCTzRuckl1Nm5m?=
 =?utf-8?B?OERQbld3Y3VrWERodVVnSXRwRkJtUmhidmZPa0s5RkJmYWRod2xoNFk0RW4x?=
 =?utf-8?B?UEVZSzE3TmUxcXhnRUNmcm5IbzQxbm9aVGtkS3I1UmpDcFRFZklicU1tekVu?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db12062-a71a-4fba-1a3b-08dc3375a053
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 07:12:27.4590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iuROI6LiuxXoMn7W8P3eOasa7Vim4es3q7KZHuoNYcmDYrFeeq2Q3sSM5/phW/mTMLReiUHnHPENuKj2GFdJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7409
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Feb 2024 07:12:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15058

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=2&day=22&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/02/cip.2024-02-15-13.02.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - Kernel as CNA, more CVE assignments to come - any impact?
  - turn off kernelci bot reporting to cip-dev

Jan

[*]
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
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Mon 05 Feb 2024 01:04:01 PM UTC
  limit date: Wed 06 Mar 2024 01:04:01 PM UTC
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon 05 Feb 2024 05:21:45 PM UTC
  limit date: Fri 05 Apr 2024 05:21:45 PM UTC
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Fri 02 Feb 2024 07:12:46 AM UTC
  limit date: Sat 17 Feb 2024 07:12:46 AM UTC
  Status: late
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Sat 03 Feb 2024 08:06:26 PM UTC
  limit date: Mon 04 Mar 2024 08:06:26 PM UTC
  Status: On track

