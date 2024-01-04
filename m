Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AA8C47073
	for <webhook@archiver.kernel.org>; Thu,  4 Jan 2024 07:07:30 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.82])
 by mx.groups.io with SMTP id smtpd.web11.48989.1704352039793572221
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jan 2024 23:07:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gvkDpoLz;
 spf=pass (domain: siemens.com, ip: 40.107.249.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rmf2x6QtYC3zBZCpQ6MOY20cYORopXzxVCe5riisyA0qlrmPXyusG60BfYBixyPcCZNj6+b1m/3zd5BhwyOzzT0X/cX+ihXdwWyCNSiO2jkoLeeUEEBfqD+RWulOQeq3i/gW0a0jUdDX9M6bZd2qswDoj8aqAmwTJnQ2R8XY1dRZzbhZTYdtcDCryQ8wB+wsNRIuhWDF0GVUzuJeVBNgvwgckibZcQ3DiaEKne7DVHYUcAuF9ZlsFOaabMegE/y/f2aLLJ3RrE1Fd+GbwmoxyqojOmg8c9yRUwRrX6CD74posIPCatZsLvsS7yo621F/DVr8a7mvaTy4M1pidf23mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pj6DY9GHltvG/3T6W75ahvmDWAmjUj4WcojhkQnACY0=;
 b=fiK9vTqwK8sSOa19VnUHFqmpNDolHW55W7D8pw9x2+HRTHGGVNAeaMvX/mr11fnDxraW+NFmhP623rqmURpxAPSBqI357qPlNdyg4Bd+9yK6apTltxJWIV/WQrMiq5VsPvS6mA+asxOT8E9yT0nuOJvPVmLXoSmrzpP/NBhc0RyeMtFEC7t/UMRlqGQsN38i3c6CoMj1GI5zOQMDWH+/zvoIqTs2Dd6kw/MH+PNJZTew6bvCKw6Lr7o7CEhruxhlqPzqhjaL1qBOqu6VXULnLwRI/9kUG7YKTx+9Rd3QUSjrRxhOBE1xrfT3RUGYUJEc4ljn0GpZttnRzjbK6opnKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj6DY9GHltvG/3T6W75ahvmDWAmjUj4WcojhkQnACY0=;
 b=gvkDpoLzXsq5wKfxW3kWZXBL5B1p910RqvSX9O4E+VyKVRXLCGsbJLqFw0L6pVdTWG18RDArrqIqSJG5XunkvkHmsZzs4or81prFGMS2/WTVfNuISIGag+uUP4m29fyVcg9qzry5T4mC7iTKlx+k3jjqLZ+nV5SdObH0KsAyJGs8AU0+CILbXGjoGwH8tsAL9pEh0sXmgsjO9VMn1Oifat/ZVRMFOJVFoPm3eBxphur0s6aSmHq7SQ4fbnHnWAR9NfX6QvkVgev6TOzbXTOGUimV/bCpUbDzKA34XMibAPM0iomPpmHAjES/eiYXGGbRxHigIIugWzvSFJ0Kf9UEhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6049.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 07:07:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 07:07:16 +0000
Message-ID: <be7ff984-301b-4133-a696-6d5dc9c6c278@siemens.com>
Date: Thu, 4 Jan 2024 08:07:14 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0290.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: f2421c73-54d5-470a-5e89-08dc0cf3c882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	S1/n2TJw5N6OdScspIEtJuR+fdKeQnXHZgktepiVSaxkXfzuym+ZVqw/13NjPIokhEbJkHklVfDZPojlp6+vgZqvEXI6geb6gLS9+PkzlVPnOgkK0H/9Mf9cBZ9nKhj1hJfDmGGkcNF3aG298fImxx2b+NGPKRHjkCZKKvSq9ptZiYHNqgooIhiLEoKIhma7K+71LkAjuGk91886/XFcExHNTkA3iWgVj4A/hURWyQHIgJmLJrVjeI9TMmZr3IqxRUK5wL1lyloZNp1rIYrBgBqIYAKK3OltQJ89GsEyMU6c5LZwiBvB3JYQjpeiBpLTIPOmaChQOr9syB7JpKX08maVLNL/OYLkcvs4aE138g8chrf4TlLIl8u7DHrzARR1bxCLG9NMbybz6jYqPvJpgnTiMIqdfRPH7kq/7S09AYBbB2lbqU4HCahll85buCdV9oxA8IEujRh2pVQ+JYK9gwDIG+sBdRGUBl4iJziTwHz5e+StFxeNHVIRPxJV9SqeayyHO8J/g4PqGJvSNCBscbiCew0vogSUQYgJHp/EIbJG4vFhPv4BkTVX3w1XOq/U+Hd+d4rmV8kvaU1GzAPjY3DHTYfKRY5tP7MWXthm6MVr9FxfKF/U/bR5S6yMXIxioFxlkYPDp9FHZ/v78BK8Mg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(26005)(2616005)(83380400001)(86362001)(31696002)(36756003)(82960400001)(5660300002)(44832011)(2906002)(4744005)(6512007)(6506007)(38100700002)(66556008)(66946007)(316002)(6916009)(66476007)(4001150100001)(41300700001)(6486002)(478600001)(8676002)(8936002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SzRTT3lhOXRjQjN3T3llOXBvOHNTNDlzblQwM3ZmZ2hBOE9YelVvQ0ZIc1FI?=
 =?utf-8?B?YTk5dWNnTzBxZ0M3L0doODhDZTFNZHBTbDZhZHNrdTlydElDc3hoNDUxcGxT?=
 =?utf-8?B?Z0Evc1lJRVBzRHhFN1pqczVYWjdvdUVVaUh6ZlNqNEwwOXJJajhMVWl2KzNs?=
 =?utf-8?B?aWtUbDhCa2s2M1g3eWN1bHROeVFNTkVNVUpVd3E1MWJXQ0lFTVM0eUZrNlVv?=
 =?utf-8?B?dDNiTFJCT2NUWjNPMU4rUld0aitwaWxOc1NxSlZNWUVHV2d1eVU1Wm9TMXdo?=
 =?utf-8?B?cW4yREdiQndEdzk1UXJUa0FWaTZnd2Rhb2xyQ1NBNmFncU5jN3JTM29qbGxW?=
 =?utf-8?B?ZmxUaDNuR2FaMnVxRmJOTGRFNXk3VU52Z3ZpSGEzUmRsaUI1SUlOWDdHbzh3?=
 =?utf-8?B?M0lpSWRtdC96L3hjZzkwam9rTVRsSmFOeEtYWXV3QVpib0JnVUJYK2x1Q0lU?=
 =?utf-8?B?ZFV6VHlKbUNFU2RiZWY4T1Y1Q3lYeFk4Y3ZITytYTVpOTFRobGdNME4xOHI5?=
 =?utf-8?B?VG8rVUM5eWoyQ25qcGhFTzRwNFk4SnBmVXhZdnZqVm9RajNQb3lJTGcwNkFH?=
 =?utf-8?B?UGRPVU1aWFk1Nk5ZYytCZmxTMzRxK3AvMjJYd0w0WWh0ZDRrWVZiQ3BsV3Zl?=
 =?utf-8?B?b2Jndm9HWFNmV3E3OUdmUlk1NG9FTmx5Sm0zcGwrRkpVU3hWUHpIdmFxdVlx?=
 =?utf-8?B?SHA1b0p1RXFmNklXeE5MRThCa0I2RmtKellVMWE5M1pVZDgyT05lZ3grME5X?=
 =?utf-8?B?R2M1Y2ZxTkE0ZHozRDQxajM4YmFDdFFsejc4SG0zSHNGK0JhWmlLWjlsNkNV?=
 =?utf-8?B?MjM5NFY2MldZWlNIQTRvVWNLcVpLREhOdWgvS3ovODM1ci9BcW1JdDVOcldM?=
 =?utf-8?B?TEpwbi8xcGFINEZKVmhyQ05OdTg0OGdpb0ZqaXRnRHpXdW0vTk9kM0tpZE8x?=
 =?utf-8?B?VEJHRVp5cjFhaXFTMUpFNDNxd3lvQVVibGFmamZyMDk2STdEcTdNMVpraDNJ?=
 =?utf-8?B?c3pJT2pQa1FjR2tRTXFsYkhpM2Vsb0QvbTNYT1IraUMvaFluU3lsNVU2Q0xP?=
 =?utf-8?B?eDFxTlpXTTVkZDJlTEwxUlpNU1VmRHZvOU9TaWNDUlpHNGNMSVpYRVRqQi9H?=
 =?utf-8?B?N2NqUktrOVdHQldSR01oR1Ird1R3eDFUSUZOL25MbmlITkZNbTR4UE1vTXk2?=
 =?utf-8?B?VWRaTHdVTVhrVDlMM3lXTnA3YjhQT1NqUyt3ZXF3dTFZMG0wMEtUbU9kYXJ3?=
 =?utf-8?B?NUlXL3M4VGhBeE82MkE2dUh2eWdnZzBpRHVQcnlhaFpQbUM3ZGhDblRwLy94?=
 =?utf-8?B?UjlsYmZuYlhnRjVaL2xQTGhSMTR0QlpxM2ZCQXc1T041MnBMMllFc1RnV2ox?=
 =?utf-8?B?ajV1blhQdHBkMGpWVUFvckQxK1NXREs4YWVPMnZPQW5kOVhNT2dvcnNndnVh?=
 =?utf-8?B?MlJIU0J0aENHVHk2UjhnSndLdGFWcGJWZVlNZWNLK1hQendqN1pRT1NPNnBw?=
 =?utf-8?B?SVB5eUdkMlJkYXBocGxxS05RWFhQdFc5ZG1CZnU5bFhhaEVRUFZ5QVBVbnMy?=
 =?utf-8?B?RUI0VDhYdXk0UWNWWFF2OHlzeVZZc0x1TXZDNUJyWnNTQTBTKzJzWWJhRW5r?=
 =?utf-8?B?QzZsN014UkNyYTdwWGhSOVdBQUJyak50NTR0ZGZEd3ZGY282WlVZQnNvSnJo?=
 =?utf-8?B?ZHJBOHUzU3R6S3ErbnNMNEg1YUw0NzgzblI0bHF6QWdNMUN2V1pnQnpzbGdC?=
 =?utf-8?B?eFZhWW5SdzZyS29uQWV3Vk9EeDBmYklYR1d1aGhaeERYclNxR2xJRXN3MTBV?=
 =?utf-8?B?dVhxcEJ3UlJ2ZG05WTRCbElHNWJvWmZQQjZSV2VGSW5JYlBFbWM3L0hpNnBV?=
 =?utf-8?B?WlZITUgwQ3pTQ0ZqS2RjRFFJanM2ZmRrME5IUkJMVHBickNXT1BTZkc3SUtt?=
 =?utf-8?B?MEhBZXhWVUl4VUtGOFdkNVBjNkhuQjcvaHV6Z3hDenJZcmp6NjQ3QndJbXhN?=
 =?utf-8?B?YmZqck9lUW1BRHZGUXNlS3hZWFgxQWVUenJoUjVIR1o0Qm9lREtoREM4Sm4v?=
 =?utf-8?B?VnJJWkxoRHJZUnA2MG5XTU9YbnJxQlNyQVlzS2lqOTVxbnVROUdWQms2UGp6?=
 =?utf-8?B?c0wzcEhkUTZ3ZGdZQWduRVJjUjdWVnFuNVVyVUJMUmxsY3BndFpTaS9UdnM2?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2421c73-54d5-470a-5e89-08dc0cf3c882
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 07:07:16.1573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htsboJVkXL33taSEiN6nApHBNi0nx2TnA0e80Qp2qWnnrVBk7tjTu9FAzag9TaUvSKfADBEFEJhx1kD/Tcguag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6049
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Jan 2024 07:07:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14254

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=1&day=4&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/12/cip.2023-12-21-13.02.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB

Jan

