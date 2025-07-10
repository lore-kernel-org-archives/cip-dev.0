Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A11C83F18
	for <webhook@archiver.kernel.org>; Thu, 10 Jul 2025 07:57:32 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.45])
 by mx.groups.io with SMTP id smtpd.web10.3266.1752134247108512326
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Jul 2025 00:57:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=G3bcN5aw;
 spf=pass (domain: siemens.com, ip: 52.101.69.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBLtx71qJ57piLIGD4+2z00nvgv0yV8jSUmc1t0O1xubsUW2jabmcCluSfrTJ+E4A7U3DnEw//ZfakKzGMRpIanvz4tdwE61K8ppVxYz60NnTC94hl7UASonvIK2uFPrRogmaYIjTLNAQXq+avPbB8Y5DefCrHGD0zh0CR2PjxqElZAwPMustlf6nnt8YkKIyq2pitRhmhqLqPc5mQdw1cOnkBMGjaAdY5kgqpjU0wwwqanHp+coYgHcXbamkPJi9z7Uu5tGpWuMNyX6uJOlqz8ByF1WhWK2wl4ucMPUi4vewo7Wnfpy8x7xCWVBDxHBbwcj6D4PBZU9WUKLZIa7aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjRPP9f3mWHwn8uy7P5/1/hflB9rRCrjii36UQFdnSI=;
 b=hq7Hl1IJ3140wkhASvg7DU6bafiDUFU2esLj1VorgDwGAT72Q67rgFvXOk2uhkLQVCcITq80UuwmCU5T+ZhQSXfKc8j5wDzFfVUO6RnhFeIiooP1rAtH/+DSFFBvBdbf7wDcbxS68VlZB1ugfIyf9HM12dRsqgaW8cPQgFP/1sj1z4e1WjJJX2A6woMpymuT7sxVfA8jrdBzAr2UjuSY/BrF39figa5Lwv0bYhd6ellkg2/3IoBIbpBXeNFPTe+yIRp4KMikB/unsVMa/NZbsAJjdCdGn+mj2nKm/mH01tZxOcZw2fZFHuRBgDoTSIjIYoZ1qys2AVKMMpbTz8ZoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjRPP9f3mWHwn8uy7P5/1/hflB9rRCrjii36UQFdnSI=;
 b=G3bcN5awzfeq13qGZCnbECATzMFkk8aoUvV0QN4hYtW0gQL28h5yr+v3lBXh16peUEK6YeYKJ0RdNdDkuTot6EkOwpdQ+U40V8EE1IFm7BekV2KeJxdllHQ1rAp4nX+hVjwwr41U74b+rscKk5ef5BoYcqnBN8POXfdxONXksp42vCRu4x1iBFtGdDtU8o4aOykIRtEVLYsUFQ789HrOldVc42dxRisg+sc6GVfOb4FHBonzh1deNw1NglU0SpuAfBnjVXY1PHPu8ALEsc82gTz49AawMC4t7LhcGirs6W0vtQG7vnvEOhZEPZw5bxODrFbiWEvYCDDpxPyv89yC6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5618.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 10 Jul
 2025 07:57:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 07:57:23 +0000
Message-ID: <ef9c2e2b-96cb-427c-88f0-80a1acd59829@siemens.com>
Date: Thu, 10 Jul 2025 09:57:21 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0380.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 04679806-885b-440a-6271-08ddbf876749
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N0hvNWZzQUtpZXNxaUdWazdkV1g2aTgyMWpRYmxZK0x5RFdWRFo5SWdBY3Zk?=
 =?utf-8?B?L25lVHI3SmFHc2JXYTRlck5MbGh3eTVLb2F5MUkrMHNRaFdRb3FzYXFvaW5u?=
 =?utf-8?B?RnQ0QUxyYjFRS1ExdlRHRG9kaDUvWFhzeHJxMm1nb3dkdmhQOGk3K01VWjk5?=
 =?utf-8?B?UFBxd2R2bkdsM2tNUDFFR2xqTG5GV2pJMTg2RDRmMjFMTW5ROXczMHdTa3da?=
 =?utf-8?B?Z0xyQzBVaGRSL2lRWDg2czRtbDBUelkrZG52T01wV2Jpd3lYMGdvZS9LUkRm?=
 =?utf-8?B?QnErU1pLb1BBRHNtLzN5MVk2MkVGMWx5VzZBZjNmOUVQazY2WGRiRnYxb05Z?=
 =?utf-8?B?eGNtMENVRjgwRDlTam1zTGpuZXIvY2JCczlIc3BNMjZCYXFWOEg2SXpPSnJC?=
 =?utf-8?B?V284Y0V0NncvaStUMEJseHMwNGdNWEtHQnJka29qYmtKMzBURjlVL0NrdWx4?=
 =?utf-8?B?TFFDUUtDSzRSTHZ5YjV6OWY1UGxSdUcyVEpZbmNuaGVkTStQbUtKWkpRTUwr?=
 =?utf-8?B?djlrMVBQSmxxVTBsWm1wRE83ZHdoaU8zZExkcGZpK3J0VW1rYU51bmJVTHJ1?=
 =?utf-8?B?MlFuNFJteVZXa0hUUXlYblV1NUhiVUJaR3cxYW40aTVHdXZaNXR5S1JrRW4v?=
 =?utf-8?B?NC8rWUQ2Q1lWRlozMlM5cFJKZm9yNHlxQnZEYU90Rng3eEFFNzk3ZUxJenAw?=
 =?utf-8?B?OWd3MUJzNkdNanVUcHdKTzV2ZXA1cU9DdEFPZzlLTEc2bUxJQ2JRSUN0YUZk?=
 =?utf-8?B?YzZQNUV2RktodVZvQ1Q2bjBQZkFtUUxWaGREbmMwbFRzWXNTcVRxamR6UHNi?=
 =?utf-8?B?STZSeFljRUNkVzdZK1FnZlJzeHNvSEErY3pyY2E4VytoV3JvVkRUTnpmdW8y?=
 =?utf-8?B?UmhOSFR2WFVYRzY3T2c5NUsrM202M2xMcEJMSGpxOG96eHhxQmVBb2xJaTdy?=
 =?utf-8?B?Y21IZHptV2gvMi8yaDc4SktKWFBXc1QrbVVHYlNEbWpLTnE2Z3N2M2JvQkZo?=
 =?utf-8?B?ak9BaE1YbHROUkRTRVptUzBFdFU4M3c0UHIza1phL1NkOTUzT3FLZCs1U0Jk?=
 =?utf-8?B?TU0zMjV4ZGM2RmtDZXVPTFdEYitYcGs4SE8vM0t0cGJ6RXQ3dEc0ZWpPVWw4?=
 =?utf-8?B?eW9iNU9YWmJ3Q2VOYTRyOUJKN3Z5UHNTdXZibUlUNHdENEZxdWQ5VmN5RDlX?=
 =?utf-8?B?Wm1QZ3FONWFRQTdwVmdoYjhZRUdmWXk0Mlh6alFhQnltZWljbkk3cW0zRHF2?=
 =?utf-8?B?UWszZ0tpVFA3VmhzclZkYlRrVXpUU1Y1WjVDbDk5V2JrQ001b0lJL0oydVk5?=
 =?utf-8?B?ckJieTdFU1VEVm16SzZJejcyZmVGSUFneGdmUjAzTTFDYjVaNnhqS0p3YXhO?=
 =?utf-8?B?MUdSOTlOclloRXE5bE90R29LbFZ5WFd6eCtFMkYvY1Q0NXM5VERmdmcwODM0?=
 =?utf-8?B?VkJyS05pbW90RURhWm44NDlkTGVzYmdaV1FIUjIwTkZZSm9aNXFscUxPd2lG?=
 =?utf-8?B?SHRDL0FIemNIcTVUL1BZWXJsVGttVW1ZQjJzZWV3S1VUakdZQ2FxeUFJN09l?=
 =?utf-8?B?ZnZoVFdZNUl5ZUFFZTVsY3BUTmR5cmpDN1ZleUZvczhKZUE3Qk9JUWVZclpK?=
 =?utf-8?B?MWRaTVlXVWpDeUFDU0xqNXNnYzQzZjY2VzBlTHFqdE1ZMmZQSFhIUitzTmlz?=
 =?utf-8?B?ZmFrc2J1SVBVRFJYMTc0cXEzNjNrMk1RWFFpaTB6b0xPcmVxZDhra3hqM2FC?=
 =?utf-8?B?amVKL2xJYXY5a2RxQnYxYzYvT0xEcFdPUlhGSzU2OXEyVW5scCs3Rll0akJC?=
 =?utf-8?Q?A4L0FiNL7od/3mJt6Fmg6goXqLTu7zBqq2fXQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bk03RkNGdmR2cUphMWN0RzJnMTlhVVV3aWgxV01XaG5JVENlUGsvQzBIT3lG?=
 =?utf-8?B?bmkrWlR2MGlkczh3ZjVia3RIa0RiU1Izb0JQUE1BUm85WnM0R3ZSUE9abWdo?=
 =?utf-8?B?UmM1VjhVSmozNEJOVmIvcjg4L0d2ZTZuTVMxaW9xclFxaEwyVGV6TUN0dEMx?=
 =?utf-8?B?bVY5ZGVuRWRFQUpNaXFJL2RwdWRxd0Vyekx3Y0RrcloySEVjUlgzVE1NV2l1?=
 =?utf-8?B?NTlTcnM0MUt5eVdqQ0l6N1BraHkxMnE3SWtHSWx0ZnVoaE9oci9KUFFMRVpC?=
 =?utf-8?B?Ny94ZmYzNFYrZFZ2QlNDT2N2am9sZEQyN3UzSzNlY21heEZQUjRYd3FIU1VB?=
 =?utf-8?B?UW5qaHRKaUxnYmJKcFFma2J6dUNQYi9TT3UybjlHcG1NYXRCVHhLSWpKL0I5?=
 =?utf-8?B?VkFpakowY3JQZlQ5Z2p4amh6SDI1b1hpOTVRUVV4Ti9GTXdPa3JVYUxuVlFy?=
 =?utf-8?B?bjV1ZEtHdVBRenRRZ2o3dHdQZjcwS2F4Y0xNUWhqMTh2WlFrampUd0ZWTmZk?=
 =?utf-8?B?R2NpSFBuVENUTHJrbG5sbEFDdDlka253UmVnWDVXVWxrcUU4enRNRkY0WEdl?=
 =?utf-8?B?OTRmbVdLR3NSUGExQUhUeTB3MGFNWnhpQjFMbmFyRG14cG9tWE9KVDBUTEJ5?=
 =?utf-8?B?bkZYdEp1U0thY2ErYnAxOWQwVXQ4eVFmL0x3MElDcE9XSzgvOHZOWVgvay9F?=
 =?utf-8?B?dDNLZCtJMkxtQ0xmQjI4ZUNIZmNZcnRjekJYMGNOTFVBbThya1dSYzMvRVY1?=
 =?utf-8?B?QXM4V1pPWUZtdWpoWFpKZFY2d0lHOC9IU3RtdzZEaEhqaCt4Um9kM2swcnNw?=
 =?utf-8?B?b2haTUM5bkVMLzN5TlBEMkVldTdTNEFmM2VueHVEMDRkNVloY25tdW1vR092?=
 =?utf-8?B?SjVZUkV3K2wwdG9RMEY1UnRPcEFDaC9FZjVKUHJ3dFlCOENUMXFmOExkV1Ur?=
 =?utf-8?B?QkdTZlFNeGFUUnV4b3JENVRkQmZLMzJuNllnVkF0bWJjRzNIRlM4Qlo4NzRI?=
 =?utf-8?B?QzFvbkV2UU1vaGNYQ2s5aVo1YUwxc1lRNmtTODl5M0E0d1FDVnNDTVFZbjV5?=
 =?utf-8?B?aXdXVTVlQkJlZllDeFVqR2JoTkkzU2c2Y0NVcmlzUnpuTWZkWGd2UitIV09q?=
 =?utf-8?B?MEJYRlVCVU9sczM1M1FSYkY3UjFwNjB6bjIwZmpRVUdlNThtbG9LdGNRN0c3?=
 =?utf-8?B?YkVZbUUwdGs3ek5QVERlNjdEWnRTYmEvNkhqSDlBWXhYdk5DY0JuenJqcHVD?=
 =?utf-8?B?WmxreFN4YnpGUEZRZno4cVhOd1B0YUxRSUxqRitkZXVPUjFBbHpLUEYzTlBh?=
 =?utf-8?B?NWMyeXNzdWl2UllrOUxxSVpPZHhVZm9xdmVNVGV3aTEwNEdFRTMvNHJjN3dO?=
 =?utf-8?B?SWlqVkpLbTNXREM1cC9SYUd2SUJvai9VMWZPek5aYTNzUVY2NmZWNHprK3R0?=
 =?utf-8?B?YU1IK3VLTlcyKzZuUUhUeUsyYUNGN1NsUHVrbjVVVExYT1NJemJwMjFOZTR1?=
 =?utf-8?B?bFFlZ0ZDdFRFZU4yVkp2WjB1US9CS0FqU0Rma0EySXVsejRjNWVoMlQzL3dY?=
 =?utf-8?B?YmkvTWZCdDBCcjJJOHJ5ajk1YlhKL0xiVnQybEhwM2hVaTJqRjNYQjRTQjdx?=
 =?utf-8?B?T05GWFYvU2t3d2UxaHc1aVByRmJpay8rS1RWdXZkNUNPWkYyVFU1Y0crRzli?=
 =?utf-8?B?SUlUdnFqVXQrMGx5ZmlhaW5uS1ZQN2dBcTRVUTYwK25oL1h1bWFaZkJtWFJW?=
 =?utf-8?B?UjQzaU1idEs0MTRqREdvS21tME9iZzBDalZFUmI3OVgvNlFZM1RTZW5aTHp2?=
 =?utf-8?B?UEhmY0YvSS9KYUdROWY1MUU0WG50VUIvWW01bjBqMThzQnRHT2t1WkZ2dVgr?=
 =?utf-8?B?VjgyZXhZVThOcy9tUmptYlF6Nm4zWU1HRjFVdyszVWp1K0Y1b2Y1QU9tM1dG?=
 =?utf-8?B?dE1sNnJpeWhKWWYxaW5uTG5hM05qRjVIOWRYR1V4bXpNenhUbFd6OHhRZzFj?=
 =?utf-8?B?NTlrQk1XS1N1R2w2aWZocDIyK3IrOXExRDloaHJreksxdHlxbTBTU3kyYWhM?=
 =?utf-8?B?RzAvWHMrbjhFU2hWOUFmb29mUWtTZHI2Z21idWNaUU5zR1ZuUjR0RGVzZEdj?=
 =?utf-8?Q?/dOJ1sG3hpO48mYkKLTFFC4oQ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04679806-885b-440a-6271-08ddbf876749
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 07:57:23.2199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnktZOLj1ZZBn1+MVAOc4/mbGgLRhueOGSz/bBldEHmji0uCaXAq7XyQIXrnPFh077RbwUucDJTkofAwZrrQhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5618
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Jul 2025 07:57:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19391

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=7&day=10&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/07/cip.2025-07-03-13.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Jul 10 07:56:36 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Jun 18 08:46:56 AM UTC 2025
  limit date: Fri Jul 18 08:46:56 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Thu Jul  3 11:41:37 AM UTC 2025
  limit date: Mon Sep  1 11:41:37 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Wed Jun 11 08:39:43 AM UTC 2025
  limit date: Fri Jul 11 08:39:43 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed May 21 07:22:16 PM UTC 2025
  limit date: Sun Jul 20 07:22:16 PM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Mon Jun 16 10:52:06 PM UTC 2025
  limit date: Wed Jul 16 10:52:06 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Thu May 15 12:41:24 PM UTC 2025
  limit date: Mon Jul 14 12:41:24 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Wed Jun 11 02:12:44 AM UTC 2025
  limit date: Fri Jul 11 02:12:44 AM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Mon May  5 07:36:59 AM UTC 2025
  limit date: Fri Jul  4 07:36:59 AM UTC 2025
  Status: *Late*
linux-6.12.y-cip: interval 15 day
  latest version release date: Wed Jun 25 04:54:15 AM UTC 2025
  limit date: Thu Jul 10 04:54:15 AM UTC 2025
  Status: *Late*

