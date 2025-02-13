Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9B5C0219D
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 11:26:01 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (AS8PR03CU001.outbound.protection.outlook.com [52.101.71.48])
 by mx.groups.io with SMTP id smtpd.web10.9062.1739445950342950147
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Feb 2025 03:25:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ofm9i4Kg;
 spf=pass (domain: siemens.com, ip: 52.101.71.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVETnJcfzEnYxPrO2oDOYOtra9oAS+WSmTUwjW+bOvgN55M9EYmOxUwDIyizLUCbGkssaCE0yq8mMDx3U3AmIO2SMiav4fK6s2vKYnsNsq310Nl9e01CLEp10YQI3KIDPHmo3b3c4hLmJgjCew0U4p+ADCTiBrFCDdFMguQY+dg3skCfuRFKcxxzDFhsoDhydJ1Wk0WW9t6wTsL3THxv60/Ze92l++NIyeL0YJehm22GTZ8ELVF94ElU+LK9zVKZdW1BmrX3R316L6E8Fe0hq7ZM7sUyoDmzNPbNmMf14gv9zqSEQXHrbyjefv+65bwS/xAXfEe0ETut+cvSHR2/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqXJ8JZd3QE36ClsKu+TGtYXyXgvYFuNyVI/NbVH7Do=;
 b=dihbDznSbm9CWQSMWVc/zd+zw1+TedAqCDk7J2u9yiG4nzC36DvVVxb2QLoox3Sfd3aOGb0OjeSehgcPZwjkKV98wFsbkqJBSej2HIrHqEa9q85Gn2iteUS4Ap27L4CEZHWs7VBv6jfDPxq9uTZO390ue30YS/A50Lm2TB5+dG1NOI1man3nLARpm+zfFTd+LKFi+QpG5/LUceJWWL5h8SidDdu12DGXYbt4MG8Ih0LvBZiNsVaEcqTLHsQQp3g3BlXYQE17hGC9Ywi4+sRe8/uRqa742T1TguA9TSSBWm+FQMNwXwU3gZDLyLy2I4BMfiTvVAhnxciqVvuv4zIk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqXJ8JZd3QE36ClsKu+TGtYXyXgvYFuNyVI/NbVH7Do=;
 b=Ofm9i4KgOVjygqMD0+VwZ40CA56h07rF5qK38PaHAKhaKBv1Pc/akO9TYbon9AbsK65wnXYq8UPqpXrBRY9Rw6zHjVsJgqoyq6MQi1aINlf6jV5my/msv1fG+YbC25iJcX+RHH7w7t72wK0tKoDw0X4xVNUbGgRpvXnQnhOPPdHWTjs0QdZxdpqJq7Q2NYj3yj5KCuL763hR6RDdydAEgR7VPON7bJ+U57YhPqIal8fUazMdhoCIUejmw9OZkJKYd6r5sKv/ywtzfgG2Z606jjh54UGjDwAWzfb3qSlVxhWvQUBEQAhyFZKw+OK1MAnJo9VXb/64NOYaKbL6MUXx1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7685.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:649::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.9; Thu, 13 Feb
 2025 11:25:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 11:25:47 +0000
Message-ID: <38d125ca-683f-4619-aac2-c2a0e54489b3@siemens.com>
Date: Thu, 13 Feb 2025 12:25:46 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f26d79d-2299-41d0-6299-08dd4c2129d0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?K1ZWK3JocXo4dkZEckNTUHRjL01zUkZIRnFmVE5NaXliZ2pGTXIxS2hvSjlT?=
 =?utf-8?B?MEhWa0Nqd1ppQThoUWd5S1BDZHVyUmxkdC8zRm51NDJTdUpHY3NoR1YzZjNW?=
 =?utf-8?B?MzF4eTd3OGlJbjBOZjNnZEJrV2ZKTDJkdXNtQzhxaGo3Y3lsUVN3NmtOT3VH?=
 =?utf-8?B?aWFGR0JlUW1ObFc1Mzg1QW8zbDVkbW1uUzNjMGptTk04WGhBNUYrVU9URWpN?=
 =?utf-8?B?RE15NVpZZHJENGtVSllLZ2g2ZE9ISXZtU2t5bWVmdm44bWM5NmI3VmI5bG5I?=
 =?utf-8?B?WUE3QjM4dUJmSktGaVExSFZIOXgxT1Z1T0R1VVhJZEtYRy9XenZvQ2RZeXpt?=
 =?utf-8?B?dFhQVktqeDI4blBpbUxBSzJNNm9kL09jNndRd1hsVnF2NUtZbEd3b1o5dThn?=
 =?utf-8?B?VStidDhjaHlidUErV09GTGlEMTh2cHhXelVhUytmR3VPQ1RKa0hMZURvNmxO?=
 =?utf-8?B?YzB0QVpHR1VYeXczZVo3VG4va3Z3RWlnQmJsMDJpcmV2cE9RdlVueFBEK0V4?=
 =?utf-8?B?R3pUU2xOOHFKaG1yS3FHQmdQMnFONGMrWTFxUWpSUkFBL2k4K3U1c3BCNUw5?=
 =?utf-8?B?d0FVOSt0c3pXMFVZU0tqT2QyTDhHS0dCZHpBYVdVYkdjRkZ1MEhuMEl0MWNZ?=
 =?utf-8?B?d2I5SlluOW5ubjN6VzNtMEZKWVFRdzl3amdRUnB1ZEMyaUlNcldFSHdvVmpp?=
 =?utf-8?B?SFhvNXVyNEkxUzNpeUNDSGNsRXpWNjV1TDkremxoYnpXRWc0clE2QmVRQTNz?=
 =?utf-8?B?UjdEUUFiL0hCeFpUL1U5ZkhsZ3o5cy9iWjYwOXJMUDBER0J5TVRzMDgwL0Ji?=
 =?utf-8?B?NWF6d3VPYVdoektQdDNuMUtmYkdrbnZ1UHY1U2dXME53cFd0cm15L0RqTjJi?=
 =?utf-8?B?VkplOUdxU0NFNUFpU3RWaS9mZWNSMFBsSlZzZFFCMjU0Ni9iNXI0NjQ3RFZn?=
 =?utf-8?B?WWIySlB0ckxtQmVvWGhqb0xZMjVTaDc3bk9sS3ZySC96TjlPR0FMdEZ2c0hE?=
 =?utf-8?B?U0NBcVlVN1JUT21CR3M2WnIreUMvMzVtdjA1MzFvVWhtTVIrWnpFZ1EzYmds?=
 =?utf-8?B?MWV1UHR4Q3lQQmp5OVRuZkhNbWcxc1N2NU5XeVR2NEExSEp3YndNK0YzdXcz?=
 =?utf-8?B?MC9QVjIzN3BZKzlOVjdoTkJUTHhybWpCWllPK1hIRmwxOERJOENpOGRLWFlU?=
 =?utf-8?B?cmJZbldJZ2ZWOG1EbmZPV2lQOU11bThSalNUWUhjREptWWdNMDFYSTFmdWhM?=
 =?utf-8?B?OS9HbWxwK2s0SkM0S2pTMUh5Zy96RU5NZC9sNysrbnU5cTdSenVsS2Nha01L?=
 =?utf-8?B?RFRFWWpSUG02NDdkcVNrdi9qK3lPbFRoSUxEQnFQaGpLRzdMMlNhdnBOUmp5?=
 =?utf-8?B?enVDT0NETnZaSG40K0p5NGpMaktIV2dGaE95b05Ha2NoM3RWVEVXUmRVU0Y4?=
 =?utf-8?B?Ulh0WWgwaVNrY1EzZjhndDcvME5YRXhTQ2RnT3R6czNld2FZSlpna3oyd24v?=
 =?utf-8?B?OXhkdXNBY1VwclJ2ekRtby9pRkZ1VWJDOS9WOHpYcnFyVklEZ1Zkcy9mc0J1?=
 =?utf-8?B?UXZaQ0ZZVEFrKzEvbEZySUFZS3VaR0FCUkhjVzQzRG1GMG9KcUhxdlhCNEdo?=
 =?utf-8?B?cVpNVjVCRkNTbmxzRWpwc25QazdGZm5MR04xRU9xeWxXWjBhV0g3SXBIWmRT?=
 =?utf-8?B?T0VjZk1FTSt5UXFEcmgyVnZvRS83emhsSHpnVVV0RlUrMjE4TW5INjI1MzNU?=
 =?utf-8?Q?aGP7Rgas/39QF0fjtoKF1BGr+e9fy3LoV6YpSr+?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b1hQcS9XclJMak8rT1I2V2JkeVhHLzNLT09NdGgrZEJZdzBKc1VUZmxIODI5?=
 =?utf-8?B?Y0VZUnBjTmNiOHBZbXhmK0kzRlN5TlZscUhEQmNYT1Znc0ppZnpYWTlIaGNQ?=
 =?utf-8?B?b3dIaVJ0cjY5dG4yQjlZUTBaUnN6dG14R25HZmUvTGc2dkJudC96bzd4c0w0?=
 =?utf-8?B?bU9BakJOSGNXMlVCSjdiSE8raHRCOThTNHFnUlk4SFpEWFBZeFBQSGgyandl?=
 =?utf-8?B?WGhrbCt2ZEhBalloYkJHcTFZWjhEMmpUNm9seFNnL1VvR1p6VXQ4TjlLNzYy?=
 =?utf-8?B?NjlxVFRuVnNFV1d4T1IvKzZVa0daQ29CYk1telp4cmNuQkVjdzYxN2FFSjh3?=
 =?utf-8?B?bHBkSUpHdnczS0NVUU5YV2RPdUtmYnAyRGw5WGxIdVp6S2g0SC94MkhWUk00?=
 =?utf-8?B?TGFvSE9MbnN5SDVjRlhHTVVjZityVVZ1Szc3ODdRdVYzaGxtaS82cStjRjhK?=
 =?utf-8?B?MmhhMTNBM1RBR0VnOFdJbzgxM1FIMml2SVkvTTVYN2VSUWdiMEdpQXZXUW9M?=
 =?utf-8?B?T2VsWVAxa0VYZklDbWhwd2dtdjR1RzRualpCeHg1QnlrRFdWS1J6MGZneUQ0?=
 =?utf-8?B?cVRMcmZJOFpvdjR0VzhjODhVcENjcE5sNTdiL3A2ZWJlNzRwQ1N0bnU4d1Z0?=
 =?utf-8?B?Vkd0Zm1JQ2VUUjZ3V3FvR3FsQ3d6a0tJRUdVWWhpbU5JUVNRQmFhaWNNd3ZK?=
 =?utf-8?B?SjVrMENVdjl4MUNBRDREQmMvSFc5VTBNUkFqSmxkUHFHd0dnbmlmZXdxaVFN?=
 =?utf-8?B?U1BwcWtJR3BtUDdZQWl6Yks2dUVpeElidG9pNitGNG9RMlZ2aXBKa2tiY2do?=
 =?utf-8?B?Vm42VlZtMW5nWTZzamZxVWNWOXNub3ZiNEZYeWU3SGoybzF5eTFHZzRZQWt0?=
 =?utf-8?B?S0dMeFc2cSsveC8yUkpUWXZXMDRGbzFEcUY1MGlINnM2TmdqRmZ4ZXo1NWNW?=
 =?utf-8?B?eTF0VGVjZGxpVFFUL3VCSm1kbmVqVU1maHRZTEhmQXZZS1dPSk5MUmpqUGZP?=
 =?utf-8?B?aERiQ0NRWFJPa2YwaTNRQ1d1RG1oRUQzUVhyQm1zYUcvOENLOERBQ00zMXA0?=
 =?utf-8?B?bDM0Y2E0a1orSjg0cU5BU2svWFVxSmpVTDlpTUF3N1FIRGtKTUE2V0Vhd2Ur?=
 =?utf-8?B?QzE0ajlITktYd2NoNys4Q3l2aTB4ZUZmcUc3aHNEcE1pOUpYaHRnYzRubExM?=
 =?utf-8?B?dldHdkljM2ZFdmQwenFkdFNWMG1GOTFZbnU0cmw5dHUva2JzUFZrNUJJMWth?=
 =?utf-8?B?VUMwVUpXTEt4aFRDRTFicmxoQ3JYK1B1WXdVQ1dPZUVpSDBadVl1MGRSVENm?=
 =?utf-8?B?S0VMeE1tc214VjVQVFZsK3V2UjUvK3JqVFZKaGZndEwzM21nSTB1MUgyQVNX?=
 =?utf-8?B?SlowQmI5anJxdFdXQldrVDl5cFhCMjczNUtDM2U5aVZJdGgxUHNPWGlpbmVV?=
 =?utf-8?B?SzlUbWFBMy8wc2JwbzlCWWhSNldZdm1PUUxkeEd0dHlUTGFtU3VnZGZPOElz?=
 =?utf-8?B?R2pKSEdxUEtuVUVldkJCUXorallvUWNlOGs0aWVvYmttMEEwNkJQN2d0QWpB?=
 =?utf-8?B?VjliUlFFbDlhZUdRbmxZU2hkaWgzL1pkaHI0UXh5T21YRk04VWd2UDhLSzZI?=
 =?utf-8?B?eHY0ZHlKNzF6c2NaNjJkeEwzSVhKYjd3TWN2TG5aaWo1TGJTYTJnWll0M3Bh?=
 =?utf-8?B?dHEzWHloU3hrMzlzQzFrZm9hdXBNL0p2SXd0OTVnY1RFMjdsSlo5TkxIQXRv?=
 =?utf-8?B?Z1Z1RitiMTkzRFNIZkFJYng5R2dlcVZ0WkdXV3llc3cwblBZQ2hBQ1JHeGFN?=
 =?utf-8?B?akg2ZzE5ajJrL0cramRVL3phMkhyUFJNdTVGOUxybTErSXFOVjZsVnprK1hB?=
 =?utf-8?B?Ukk1T1NMNHAxdkU4VUxjQjBlUDJzK3JDbXRrdDBBckRWdUVFSU5GYUVURDU0?=
 =?utf-8?B?T1RhZkhubG9BNG5MOE84eGZ0RHc0VHBWR2hyOExYdVZrZDRUSUs0QklNMDky?=
 =?utf-8?B?QzdPL3Uvc3U0SWZnUG4xSWViektoWC9rcjluaUh2UHBVdzFyeFBrbmQzbTls?=
 =?utf-8?B?N20vNU9TR05OWDFEaGNnMzgwWnU0YmVlRTNJM0F3NnZYcmlmemJQQWx3WXJH?=
 =?utf-8?B?Tmo3NWh3eFJuNmNnN3FBUndzUkRhNWtyYk5ZUnpTQ1QvaVNPNVhQQk5XSDVs?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f26d79d-2299-41d0-6299-08dd4c2129d0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 11:25:47.7236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03YA1iHifEF3pV1zHafqxej9otO6DfOH2CTsdyr0rKQzlgpgFe/zI37FZ+gIOpISSlAq0H9ERiPefv0pTjdIaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7685
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Feb 2025 11:26:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17830

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=2&day=13&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/02/cip.2025-02-06-13.02.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Thu Feb 13 07:52:32 AM UTC 2025
  limit date: Sat Mar 15 07:52:32 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Thu Dec 12 10:45:41 AM UTC 2024
  limit date: Mon Feb 10 10:45:41 AM UTC 2025
  Status: Late
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Feb 10 02:15:53 AM UTC 2025
  limit date: Wed Mar 12 02:15:53 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Jan 14 11:41:15 AM UTC 2025
  limit date: Sat Mar 15 11:41:15 AM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Tue Jan 14 02:41:29 AM UTC 2025
  limit date: Thu Feb 13 02:41:29 AM UTC 2025
  Status: Late
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Tue Jan 28 02:45:55 PM UTC 2025
  limit date: Sat Mar 29 02:45:55 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Tue Jan 28 09:48:17 PM UTC 2025
  limit date: Wed Feb 12 09:48:17 PM UTC 2025
  Status: Late
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Wed Jan 29 09:12:10 AM UTC 2025
  limit date: Fri Feb 28 09:12:10 AM UTC 2025
  Status: On track

