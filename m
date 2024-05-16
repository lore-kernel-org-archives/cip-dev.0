Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704DCC25B74
	for <webhook@archiver.kernel.org>; Thu, 16 May 2024 05:24:55 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.56])
 by mx.groups.io with SMTP id smtpd.web10.5937.1715837093532293064
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 May 2024 22:24:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=L3aGaufF;
 spf=pass (domain: siemens.com, ip: 40.107.21.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNn4YjyPEstU3Ho6TPP3K7iniygedIT17zwDTeURabO9krouS0lhgHF7MTajLMKIesawHaczoG+reWeyZ1ta0e3zjwdqLq6J2u6kT06yfoLDK+mhoncYNEGL3xkxmumlni5QZQCuHpLOsmptaQWw+scaWPMVyFxICSjiuR7iNVi8Fdb7gzzfaWUE3FA+8b1/MEzb5upLBHrxhEZTZyVAY3yAkSLre0yidrJyJPt31ffw3odPjy62Cov8yv5WrGcFnWQ2KrE6V+yznQ918HIMoQgzET+mSd7vbo2cFc32eS2o2s43ejs8fOCPKQceKdaMKUwJm0Qe5uRiYCJqkgdaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blgw3eipm+mmLRcbBgR9eCrZR+7s1zK9G+UCjUP1GsI=;
 b=RniO2GRBx2MxOywoHvYjteFjJiahIjLNl+eJYslTiCJt6pZ4FkuLqlUZyQzi5eV2ZpWivFSEhJ8evIhcqziSbEySADPF6jwnQHIWBIr64cxd88BnXPVdBUbia8bq2iZbp5YlyPynM8RB4VNfrQalmVn/lMqhYISyc2F/IK+m3nvBaQwHAbEBiPUsvaETsuLDHjOoyXI1fKuGhLvlP1MIwtFXyksiDWZkMbJR5w1XZfCiURPsVWtniVwGPrRvnZr5U4vVVkf8K83b4dDsUXilsFLpxI6oksUUQwP25pqBpKQWMzK72i8r2idLDrha1ZFd0LvL/PdMbxKGwAmmdvvSSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blgw3eipm+mmLRcbBgR9eCrZR+7s1zK9G+UCjUP1GsI=;
 b=L3aGaufFxHrr3QPf1W42Mn6yJLsYPv9llSdo16JolIUZTt/nRsHTaphdWkpQWpFQqqvNbvP0ulyzwEh2ZZDyPzMzpR8wHnMDIY4I/eQQIB/+AEykKFiYMdyZ7ksjmmXJWMKRfNBbL5kMHK7HgzXYDH45OkN/mWD66m4xat0mo3O76sSar5Y0ta8mtrJ/r+CpeqlhKHsALclC6RTBCPSltHygMjLjwNNOoD4F3gLXFrXV15hG/k0jYa1Fd5zaqY248zZm0D+nIyXmgoTKN+dXksyMzJ3cDqCyu3HaV/Adpa69It/RNLFgXKTnC9wTwtHVKkF+jzULOf/6R01rOwHFUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:333::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 05:24:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.026; Thu, 16 May 2024
 05:24:50 +0000
Message-ID: <00f28daa-1540-4e09-a476-32fd2570402d@siemens.com>
Date: Thu, 16 May 2024 07:24:47 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5404:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc5bd09-6a19-495a-fe98-08dc7568821a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TWVJcllqd1p4YTQyc0xyMkxSVWtUaHdGN2VBYTZHaWs1Qkt5bDluSFZEQUNB?=
 =?utf-8?B?V1dyUEpEL0NTYVk3OGVsci9FRDFnS3hoRWxQdUhDNTVDMmhFaGpJN3JQekd6?=
 =?utf-8?B?endPdzhTK0NJWnhkdWNZSVYyczhOQWZ2UkE0aCtrSThWQW9pU1R4UU5zT1A3?=
 =?utf-8?B?bDJwbEk3ZE9LVVFnVnQrTjA2K2JDYzVYS0FlaDY1a2NnQS9DT2d2aTVZNTBU?=
 =?utf-8?B?TXk5VS9xRElhRS9STXJBNU9wMHV3ZmQwRVJBbDZ1ZXlYZWxCbUNXSW40MUdi?=
 =?utf-8?B?T0ZGSFVITm1FaGp0RXJBM2lQUGJlYVFwSUFrUlhwVkpmOGRsV0N6N1VEMHdy?=
 =?utf-8?B?QStjdWZhVlR2dTNxY0ZwaWhYWjh2Q3VNUVRuV0xXbFJLa2FwN3dSai9Wc0t1?=
 =?utf-8?B?V2MrMXNRTmRPR0d4anByUTQ5dG9VY0xBNnJVWGFFTkVCMHlrTWwxQXIvSkda?=
 =?utf-8?B?c3lPZDd2TXRrT1dQcTVNN3RkRzRsdlorOWRDQnhNdHFZV28xVTZMNkdmWE5K?=
 =?utf-8?B?VnJCL0lzaDg5Wkl2RmcyeHdVWEJtNFgzc2V6Z1ZNT2dHV243ZFMrMVl5S01Z?=
 =?utf-8?B?SUNEekFLVUNSb1pJelJSekNJS1g4TWo0RjNldm1sNGtna29vdysyRE5iN0VV?=
 =?utf-8?B?cGNDbG4vS0c3SDFQenptUFJqeTlHMUlMdVNrR0FWTDIvYVg0OTNNbVYrUENq?=
 =?utf-8?B?aU5wczVYZnZrTEIyKy9BcXRnTGczQVVwWGFiNFB5eU1BbWtRcnhWSGdMZFo3?=
 =?utf-8?B?aHdiU0wwV2F4M1NsY2gxNTVWZ2YxOE41NWd0dzdSa3dwb3hQQWZCanNFeEIy?=
 =?utf-8?B?NWRKTllma3g4NlVNQ2xNZDBEaHpKWUV1bngvMW02d3Vsd3oycXUvemFaZGVH?=
 =?utf-8?B?SUw2V1gydzNxMkh5SGFUcEF5dGQ5TkZHak9FQVBiV3ZFOWxWMGh5dmluTk1v?=
 =?utf-8?B?Q3hWc1pXN1NTejQreGlhUlh0aU9VNm4zYVczUmowVllZTldIU2ZiUG9lMnBa?=
 =?utf-8?B?dkhOZy9qVXNmTkxscEFnNUpZVGcrVzVDM0JkcVF1QmhnYWx6YmNqOE5tYmhQ?=
 =?utf-8?B?a0tyUlZpY3lwOS9WZ0RYMUE3TjZjTHJ5QjErN2RUMFdFQlR1V3JSWkoxYllG?=
 =?utf-8?B?ZUFMbTRYSlRYZFZndy9uLzdnL3hEbG9CZWpJUjNWVGNxaVpaL1oxWGd5TG55?=
 =?utf-8?B?MHZnc2h2WTlCMFBYTXJzT1JHWjY5WXREb2N4M3BuTllaSjIvMGVBc2JsQTFw?=
 =?utf-8?B?VjM3bng5d2daeUlybDhjQ01UbStURlczaWdiZWVZanFuaEpHUUNtM0RCZGlH?=
 =?utf-8?B?UFJaOHo4MkEwKy91WHh6TGlYSDQ5QVZ4b0Q4Q280N2t5WE9EcThqQXR6SkZD?=
 =?utf-8?B?d3R6bWMxR0EycGprc3F3blY1NGFHZ1ltWmVHa0xqVkR0bEtraTBEVGtsZXIw?=
 =?utf-8?B?c1ZRemNaVmJFWG9HM1AwZi95VzV1eGxNMlJ2S2l0RnBKSWRwRVBidTRpbGZx?=
 =?utf-8?B?YUI1RDNQc2oxMTRHYTNNV2lCbjhoZEx1QXBIVzNKNlpOK3ppMDJYaXY2cHN3?=
 =?utf-8?B?VlNZaE5Tc05aWnJDTkRTRkF1UnlFbEhBSWZMZjB6MjhEUERrU3hjWEZUcWM4?=
 =?utf-8?Q?X6/2Ben70/jyGaPqc8DP9IvR8clofmDB4a9q7oZCkNvk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OG9za0Z6dGtKcXVjeVpKRkRrMlNZRC9UY2hranNGNmFyQkt0OUNxRGNMMHZ4?=
 =?utf-8?B?eXU4bEIzU0tsd3F2dDlFR1IzQU9xWGd3dEFBM2ZNVi9XT3lhMUxTN01RdmxO?=
 =?utf-8?B?Q2k4QVJTdkFrZDYxaVlVSmtyY0NmZ3ZJN0FsL1BscmVCek80dHZuU2JZM3E2?=
 =?utf-8?B?V3Y0aWptRkFwSThqcEJscUEzOGR2aTJMdE1sZ3B5VzVuRW9pcDdMU1F0d2dz?=
 =?utf-8?B?NnkxcmNrUFB6VTRtMnZ0YSs3ays5NjY5TWVGbXVVcVRmRVRxWTdjR3hRUFFp?=
 =?utf-8?B?WFBMN1R1L0RTa2hkVDMrYWcwN0ZuUXpuSi9tVDhHRkIxeU55R2xxLzZEMUtR?=
 =?utf-8?B?eHpwRGtRM3BYaTgweXhFM0FYSjFKYUVxdHZ4T3oyMjF2YkxQZElScDF4Mk5q?=
 =?utf-8?B?cTBlWnEwMHV0TUtLSmdoRFVLamErcG1PYW9Mczh4UGVvSjluVXM4bHNiYnVF?=
 =?utf-8?B?Z3I1WEtQT2FCREphSlpvcU81VmllK0R4Q2M2UmczWHpORzhtRGNySlBxbEZB?=
 =?utf-8?B?dGh0REZNUFp4OGthSjY1aVJESmM0N0M0YnRjdjhiVnNBeGNLeFlqaEluWjZp?=
 =?utf-8?B?RkFoTU5XdkhiL3ZKZUE0ek5RSmtRZzkxWjdjVVB0Z3lZQVBINm1vb2ZDeEZw?=
 =?utf-8?B?SmoyZCt6azFzQS9jQm9ZWi90SUUrbXpVTnpyTmNOVjJDSFdrQ1BXOE92NGRm?=
 =?utf-8?B?cWljMVlQVmZnS3o5L2p3NTkxTVp2alVIRENjQ1p5Ym81M3BPOTdteWRKSWpN?=
 =?utf-8?B?MW0xZVVubzJZUTZKaWZmOFRMUXVNL1ZRak5IYjdNdjhHUkMyOG1FYnFDK2Iz?=
 =?utf-8?B?ZlFiV3drMU1VWmlCVGN0NDk1VXJ5eUVyb3RTQ0U2Umt1UmVyMXZoS2lNcFph?=
 =?utf-8?B?QlYvY0lNNXVSQjhtUklSSjBmQjk5MnNROVB0Wnl2QTFoN1hlcW9aczJTUng4?=
 =?utf-8?B?RnNSdnFHUEtSc1NDZDhDV0VkbnRHbmRJUldVZitzNHBhNmdhR3RtejB4WlFS?=
 =?utf-8?B?V2JpWEpQUW5BbDhjNmJOSEF4d1N1eDJJUUFhYjVWb2FYRmtrSXJidGpWcEl2?=
 =?utf-8?B?eDVpMVJzTG10Szh0YTAxMS9mbndScjFkQmY5WmtzQ2NxN2wxRWlqZHdzWDBC?=
 =?utf-8?B?c0xDSGo2QUdDay9qMkxFWjUyNW5OZURxMng1SjdFMG1IcW1ReU9mY2dIeE03?=
 =?utf-8?B?RCt5RDkyTTBiMGJsZ0JyL2l3SXpsZ29ReWlCSW8wcVpLSUQ4TVBlUkxqMTht?=
 =?utf-8?B?a3YxTEtmalN0SkdlK3BYZkoxU0pGZDVVN0tpRHlBSVY1cWRwbnBQbllKOVVX?=
 =?utf-8?B?MmNGRSswUnBaaDNuSXlVOEpXRVN2MjVXZVlDQ29Oa2VtaDl4NjV3VnYyaXNJ?=
 =?utf-8?B?T05pWnVaSG1VMUN3WTBVUU1kc2ZwZFcxSGVPMndlcU9teFpqT0YvYm9PNnFJ?=
 =?utf-8?B?d1RSa1NVVFdZeXBnLytTZG1BSUFMUGNJdDlVaWNmUU5hdmNpNlNLZ25uVGpK?=
 =?utf-8?B?NEJTdHJ6S09oV0VoM3BRdGc2MTMvMWpoS3pTK1A1bTQzL2hUQSsyNWtqaUd2?=
 =?utf-8?B?WThWTEJtVkYyWiswZVVCeEs2RlhIVUo3Q3NnemFiVWo2THlYaFBobkgvcld1?=
 =?utf-8?B?QzVFazdGMlpWdHJENTE0RmxuVFRhMm80R0hud3Q5cS9rTElINGQxSU93MjJL?=
 =?utf-8?B?QVh5aXVydC9URXVLcjZFTFpuRVEvUVZZQ256L0dEQXNLY2wya2N5YkF6dVgr?=
 =?utf-8?B?WEdNSDBtQjB3aC9SSm53dHB3ZHZWRFFrM0hmSi9xdmVmK2VtSHJwUzFNR3Vn?=
 =?utf-8?B?aVhuRSthUmpGa2U2a09HU0VMakg4OVJhK1FCNHBsSm5DSk9Qek5EanczbTZY?=
 =?utf-8?B?OEY0VkZFeG5QVFhKTXBKS0I3SkVZOEpvNDhsOTdFUWh2Z2lDMEdXMTI5Ulc4?=
 =?utf-8?B?MEhmcnJicUUxdkFBS2drdTNyampFcUdmZDFoKzMveXRhaG5sRk5Ec1Y0dEg1?=
 =?utf-8?B?YWNGOTNYTWQzWFVFeVhzbFpKUHRITDRTWUp2WnRYc1RVVE1COWdtN0tuSnZo?=
 =?utf-8?B?M1VqODQyVGZKbFA2SVpZZ0JaUjhmbGk2NWhKemp5RTFaeFFrSnB6ZjFpZTJu?=
 =?utf-8?B?ZWJDSU5sRHllb1RGc05mVHFTWmlxL1I3VkxSZllXUHN4bE1MeHNFV1ErVW1T?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc5bd09-6a19-495a-fe98-08dc7568821a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 05:24:50.0316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4F3DTuvXX4EhLHtZwJ0GdywETORPdFWFPhSl5WAWt6+hYOtZnRU3s1AQOlSu8Hn/gWxiasxlxZciriz2JBbgKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5404
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 May 2024 05:24:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15901

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=5&day=16&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/05/cip.2024-05-09-13.02.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed 08 May 2024 10:31:09 AM UTC
  limit date: Fri 07 Jun 2024 10:31:09 AM UTC
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon 13 May 2024 07:50:32 AM UTC
  limit date: Fri 12 Jul 2024 07:50:32 AM UTC
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu 25 Apr 2024 11:55:36 AM UTC
  limit date: Sat 25 May 2024 11:55:36 AM UTC
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Fri 01 Mar 2024 08:49:23 PM UTC
  limit date: Tue 30 Apr 2024 08:49:23 PM UTC
  Status: *Late*
linux-5.10.y-cip: interval 30 day
  latest version release date: Thu 09 May 2024 04:32:32 AM UTC
  limit date: Sat 08 Jun 2024 04:32:32 AM UTC
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri 19 Apr 2024 09:32:00 AM UTC
  limit date: Tue 18 Jun 2024 09:32:00 AM UTC
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Tue 07 May 2024 12:32:11 PM UTC
  limit date: Wed 22 May 2024 12:32:11 PM UTC
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Tue 07 May 2024 02:34:00 PM UTC
  limit date: Thu 06 Jun 2024 02:34:00 PM UTC
  Status: On track

