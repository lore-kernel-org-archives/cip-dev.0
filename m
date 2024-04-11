Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEB6CD1284
	for <webhook@archiver.kernel.org>; Thu, 11 Apr 2024 09:59:05 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.45])
 by mx.groups.io with SMTP id smtpd.web11.13818.1712829544101684279
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Apr 2024 02:59:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=j3qrHvKW;
 spf=pass (domain: siemens.com, ip: 40.107.249.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6UU+KsOnquKjiNaC7PxX6ios5i+LeV2LxkRMYiY927HfvlVoMa0ohZBUDb6PeFEV18g6WNHJwgUHDD0wdzGbj0S9vr+tkJWXU8wEqgIvf4unIIhZD1XevV5HGDN89t8pbHIfwtBZ5lIRwBufvLzFxPRXkPKmhY7gB2rqwSqZ9qTjYXi3ikQeFKSi0a19bZrceG5vrj8ZNEgm+e+oS+Nzqu7y9exVaJi1AXBofpn8J/oKhOUKh1uNYIOB1O4RzQExQSvcd5us+qe7ji86LaflDTe35fUNbVO71cRjc2mLdbT7wQPGvENS6hhqMkEoTGdLHqciMIL6fe1tzB0oIaw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sp5EAQy294+NKklAit81TbStXFqFBTwHs0SxeXsG/Bc=;
 b=G2vbszbl9cAQ6Fgti9+j97Idmy5K+9LSeDFM5Km1f4snSqvJqBRKo2UQyRG1CroQ34CtrFqa6CUwHMIuUtA0KoZtY5l7d8VOv2mUFBRaV7sE+uhVgcguXUuEES4DVZsuRaAol/WtKsiWg7H3iW6QuS+tLeMUgTTkWgt8ZphdjlLyOaFl+ggkON3TUPIQE0WOyNYw0c3a5hm4iN+CZC6WjSufbjW00PuU+hWL5V54Oa7uYVFucPs//Q9L7thuCxxqmKxig82TlrwQQcj99iHxMMDa5kUNindshaTBwOvHVrrRrg3hx3F+TIP5nqQI3Jgb7g71i9YcO87YhRj9DywfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sp5EAQy294+NKklAit81TbStXFqFBTwHs0SxeXsG/Bc=;
 b=j3qrHvKWx+cddBedOZn2N+mUDoVVi0IaIO7NM0CbsKvdndp8ebezeb8lbaVsRtUq6XU5z8nQgfXteORI8/sWyglDaTB7u++fCnLQPWtBr1kQB6DkDyn+LGXLYzig3JSlTsg9le0xYJQJiP3Sqe/1FfXsaeU5bY2Q27joo/Pv4QrPqQ079Ak47vwjuGfoC6uaDiUclsW7QpS01T4LdAgg8y92zbOkM7Pu5ZF3ldYgyIyj69D9wUm44X+iat8vl90fMA+xMK4YnlzkJNvqUnwDgn60sa+gygACcN2vgb8wTGAz0APb6tjd1yxNZwpXPhgX13LlHzNfCEonqlLC3ebv9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:289::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 09:59:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 09:59:00 +0000
Message-ID: <6984ae65-b485-4403-9ffe-38fba09bc17b@siemens.com>
Date: Thu, 11 Apr 2024 11:58:58 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0115.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::44) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5349:EE_
X-MS-Office365-Filtering-Correlation-Id: eafa116f-3d4f-4e30-54f0-08dc5a0e02ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dj+B2rPO77aXY+ZPmAXfstJbn0n0ttACMq/amPi4JyGsIzQhLjuggs5vlhsszYeWjIvJAXXeApeS9IlVZkLflo52KZEhJo5PAFyzbLoHXjeSxTuaFyHLUR9s3aSGpUAPq5rjcAiS4PQHs43ay9au1LhsB64/b5uB6/SrGCCXTNFDaU42idOlGwt2h3yXF7MCI9xM99CO74+wzWpymQPcvP4GHd1zE7700wh+VXgvUzn6dxfbPCIlE4Dnyz4P872ZJDsjnVDOLy3uf4pQGjg4aSNhqOt4W7bo1w/PD2GDIpkFCbW0h/xwE6uX3v+c9iwzGemyoid7r98JdnD61gxgZ3hRmgw0/mt8qtF6xjzdVMeGVWACRKJMvKyOiLlu9l6rwjBpAhKxAyP8jsJWeSKbx/OnHmIUOXCwAu5YMIhCAdfQJBkK0DwBAm1KN6+iv7OpGenzjJJVk+Awam1H1lnxXnEVLnfDl/LootGADOdFC5oOpatzar1dCYp0S3ns+dLWcpKvSVuImwyhOQd09BnEyHi/owJ9uR+TWUxeGSc0iu2iVOaHzUTvlAXGT+HuKTAb1HtcPjxqe7zom6pnRiIoMfbx+oh7DU7QduWM2Qh4pWRhW8bTxpcCW15rtAfFmyTAO0KvaIWhRsotCh1M9PtCbRhDdMfoS8FAam9gyRY94pE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VjQ4S0FDUEdJMlI5ZlI2L2JLQ0RHM3Z4bjEvc3pEalJFQ016WVRDd2gzRzIr?=
 =?utf-8?B?WXJHQkZuVWNLcVYxVWxSVlplTFNpN0FxU2RBck43Zm56Tm1KaVFTaC94WkJQ?=
 =?utf-8?B?ZllpRk9VTGh5NzFoMGJmb3UzYko1bDFvS2thczVDanpFbHVQcVVwMGdUQzVy?=
 =?utf-8?B?MSszRzFDdklxb1FkZUZiZnhHN3dXMTVNeDJHbTJOamRPRXhhWTg5RmN2OThi?=
 =?utf-8?B?R3ZxZU5LNGJNaGhXUThPRzRraEZ4OHZQaDA4cDZBR3l5T1Jic1pSZnFDVzZ0?=
 =?utf-8?B?ejI4S01mNllJSmFSYlEvRlc1RE4yVHQ4WlF2Ni9OK2tTREJ6NzVxdDZPaEN3?=
 =?utf-8?B?Mk4zSGNJeFluM3JmWi93OUZ2Z3pqUWQyelpTdW9ERE1ZTHB4SGFmc0tWUTlh?=
 =?utf-8?B?dWhwakVnd2tUaWRyVEtIQ213OWRVRis3OG4yemlESzgzY09EMlZtT2tyN2xv?=
 =?utf-8?B?N0d5REE4VWt1WVRJbElMbkltWmxQWHpnWnUrKzZzOXJ1VmI4bTMzNE9TUzMv?=
 =?utf-8?B?TnZGNW1CenkrVHhNaDFaMDlmcFFzWWlnQm51Y04wVXFucjB5b2Y5MHUzVzhX?=
 =?utf-8?B?Nkl3M2xjOW11RHJ5a1F4emhCVVJYWndLRUlWb3ZjakROS0laQ2laL3o4em1D?=
 =?utf-8?B?VTlzb0RDOGo4Q1hIejdtSWhwdkU5TzN3MHgyVk5MVkpZN05tRWgzQTdQRWxw?=
 =?utf-8?B?TnFpQVV6Y3VzUGVSelU3T0tBbjQ1Q2pDTEZDRVpKOW81QkxaQUNTWS9ZV2Y1?=
 =?utf-8?B?VDZjMXlZRkpTUTI1T3ZBV0VnYVlrK2R6MEZMdTh2RUt0dlpMMWdac1hRd0tF?=
 =?utf-8?B?OEp2VVI3aFYveFhiWEVJaGRmS2dRUElJRSt2bGc5dWNmN29Db0F1UjZWcjRs?=
 =?utf-8?B?TVI0ZTlJaFZKdk90VmxoVWJpM08rS3BZbENveDV3Ky9TbktqNkM4QmZEWEM3?=
 =?utf-8?B?UysxRm9DNzJsWmQzVW0vY01sWFYwVDQyTlVicUtQeHhpT3FadTB0SW9vOGpY?=
 =?utf-8?B?Q2hUQjUxSUZxenpOWTc2ZzlpR0hjRUJHUUVCTVlrWHEwSXB0S2h4WXVNbk0z?=
 =?utf-8?B?UXZYUXNqWFhqK3UzN3lmZ01sUnJ1RUREdlU0OGdVaG92SzZZcFFDYkd6amQv?=
 =?utf-8?B?ZjJyV29pSHRPUlBSYVY1VnppQWlrNFFMVTJiM1Q3Q1RlMVRiQlFIL0xwUjVw?=
 =?utf-8?B?WFQ3VDVXaG94cVNLSlpZQXJtY3B1cXhvZ2F3QlFVTTlKV3JLY2UybTMzZlZG?=
 =?utf-8?B?UE1BTHdxWmxsdjhGUnliaUJWQ0V6QVNkbUdPTVpmREVlVTZIUTBEbjRCcWxL?=
 =?utf-8?B?T3QwV1NZUmQ3VlpwNzR6TnhCVUFMeHBBWTVTdzVrSEpJQ2lpVHE0UFMrTFpL?=
 =?utf-8?B?TXBmMHZsQVA4dG1sWnNBaEFYVFZUMzRKVGJrNUk5ZFhjblRnZkNPUDducUIz?=
 =?utf-8?B?RXk5bExrL3VuYzlXK3JrSWhzNUMxRnVuYVcybWdReFg5WHB5TFY5RTJrRERx?=
 =?utf-8?B?OWc2Yng4cWZ6MmtjK2RBWkNSbGpQNldQK0t3c05GdGZHZ203WW80YUxvSkcr?=
 =?utf-8?B?QkFVNWhIQ0dJZng2UTBhWEVkMzVmK2NVeXpXMTJpYmE0emszdnc3MVY3d1lH?=
 =?utf-8?B?Tkplc2xsMmxuOVpKYitWYlVZN2F6bUtiSVJvM2tGT1VNL0xzMWNwVEQ5NWtH?=
 =?utf-8?B?ZkFROUlpcERkeFZVd1hVTTFYanFsUVdXZ2ZSZjcxT3RpNkJPZXRnc2FVeTd2?=
 =?utf-8?B?Y0gvd3pzaVBRZElhVDZJVEcweWpucDBibFQzUTlIZ3FsRGdPcWVHc25NUHUx?=
 =?utf-8?B?MVROMjNNd0FJR1VPRjR3ZnIwTlRYWkdoL1l6dXNoNVg4eHk0TnpyRkxjQjZs?=
 =?utf-8?B?WGY5ZU9VQW9PU3ZibURHNG1JSHMyY082a2k3bjErbGd5cnFQRE95a2VULzAw?=
 =?utf-8?B?cFdXMkUxajJwalM4bUJFa0hTdXUvMDIyTWg4cGU4dVZiSjhKMmpKMVdpMStr?=
 =?utf-8?B?NlpYTkFTVXllK0N1eW5BSVBEazBpU2h4YXFYSEFRby9vMEIzQXkxbVIrRStS?=
 =?utf-8?B?L1QvRFVFUHQyWFNhK0JDWEtUL0ZsT1J5NGZweGJTK1VGQkVWNk5WZE11aUpB?=
 =?utf-8?B?eHAxTGFNRXU3Y3FZZXpmalBwU3c2SjNJYkJ6WXpGUnV0b2RkQVNLU2tGcnVt?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eafa116f-3d4f-4e30-54f0-08dc5a0e02ba
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 09:59:00.2662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMnefd+uXrR2ydZHLSnzR3tEsK0DtFFp19X4bYLSO681eKZb6OIs/ufpBwSFa9ZFzcXJK01RqmNH+SkYcxipPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5349
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Apr 2024 09:59:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15542

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=4&day=11&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/04/cip.2024-04-04-13.06.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed 10 Apr 2024 08:14:20 AM UTC
  limit date: Fri 10 May 2024 08:14:20 AM UTC
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon 18 Mar 2024 10:21:04 AM UTC
  limit date: Fri 17 May 2024 10:21:04 AM UTC
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Fri 22 Mar 2024 08:52:01 AM UTC
  limit date: Sun 21 Apr 2024 08:52:01 AM UTC
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Fri 01 Mar 2024 08:49:23 PM UTC
  limit date: Tue 30 Apr 2024 08:49:23 PM UTC
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed 03 Apr 2024 04:45:35 AM UTC
  limit date: Fri 03 May 2024 04:45:35 AM UTC
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon 05 Feb 2024 05:21:45 PM UTC
  limit date: Fri 05 Apr 2024 05:21:45 PM UTC
  Status: Late
linux-6.1.y-cip: interval 15 day
  latest version release date: Tue 02 Apr 2024 07:59:26 PM UTC
  limit date: Wed 17 Apr 2024 07:59:26 PM UTC
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Wed 03 Apr 2024 09:29:14 AM UTC
  limit date: Fri 03 May 2024 09:29:14 AM UTC
  Status: On track

