Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E80CCF9E9
	for <webhook@archiver.kernel.org>; Thu, 26 Sep 2024 08:50:15 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.69])
 by mx.groups.io with SMTP id smtpd.web11.38275.1727340611308652985
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Sep 2024 01:50:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=G1033MU2;
 spf=pass (domain: siemens.com, ip: 40.107.22.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BniprD9Yq/G/fJQkxWIkwYVwHSKPucrApWahZsUWQdIinbO1pqNuv4QIDbIO01WEwZ6t/VYObkfpPz507RyZqRUFbejUTnnfT5ZDDnjM+OgV0FCBsUEJdb0fHLvrtZykkhDSPRiw6JKaUWXgRNvyaeiRF1RFCcvyxxuYD7Xjk0S2WEh+KCqZwBLlQFQ8twiwjRn3/4OLrnLWZXLCiQj8devtOkygjIYcO1QCdXCvZyrreDPJVQkybE1Up8WDLqCljC/8f4Azi9EXWDSCjfmIPeuLQ6ZDQK0VahOg//lPfhGb1/LmCNeyjjbmeFuWHreumm7SjuoM7fbWHS2oXeJc5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qO403YqSELobgcsCTVl2LcWOUvFl23xqsf/eyCesAU=;
 b=uaGwUpE3jK8D1LIW74CLCb9oMcabmDSgocns4kXE2TsvQupiE42fn9sI0MOMZ2xeH/ODBSPMB1iGpTgooPa6jv4z/kdCvSHc55jtgHZ3PjGVhyidNNJBzWTn+x+Lg3HJqUGcOyfHmD978R6Xe30lmFiWcl7LY9VDNpxAS+ZMsNXFKeLqL60rnPRmgBuE1vycCdYU7vyoT0VF1ij2XaiSuqPE+KlKe4AN/cNcpPuKGkOkCwG4V5sSCmtuV3U0ZIPIQDndDIo21mdlMwqikT1Xf5i77IguGwRpFvD9fd6RJIYCjzIdPURjZW0p0XGhjgMaPEaQZxMnhGoTLdsNjnhuzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qO403YqSELobgcsCTVl2LcWOUvFl23xqsf/eyCesAU=;
 b=G1033MU299k8mXKJAXCRum38UI8MxwPHf3paRPn7r5fk0z0CCurseM0aqUtBvsRbZ+A7Mj0W81XlndvFW+MP+yc65m6fixlHIj00GC6I3L+WTGFwK6c2AaZ19BsI8RdHEKAonOaUGdhKCuNG02bvnB/Hq92l9xLtqQmBB1AWxT9m9MDNvAtss4QBHHm5kxS9DxEKoWMrNKmyiV+gk69FxLpvxazgczciRVFJeVb9iTojtzTVDMSJQeRSIhjsaDSTS+2Ju7HImBdil7ww+ZL0nRi8QUUf7Pvg/uicLoc3omJ0AKVTCNPZIq4W1yTAJmLe4DnfTLMJqE7mjpR1yrph4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8132.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:110::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Thu, 26 Sep
 2024 08:50:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 08:50:01 +0000
Message-ID: <7b343a70-725e-445d-84c9-86a4ece5d3b2@siemens.com>
Date: Thu, 26 Sep 2024 10:50:00 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d7d83b-a5ec-4bf9-ac57-08dcde083568
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MHp5Y3BWWWtjWlV0Qm5WU05tdC9MdklrZTNoSjBxaE9tK25NZVFwYnZYeGNs?=
 =?utf-8?B?bTlBd2U3U2JJM2pWU0xsM2VaTnhNaUFINFJLdDF0TG9SSG1LdksyQzEwL3Jy?=
 =?utf-8?B?blFoZ2dCTE9uU1AxTjdqRDhTdjBCVHh2TVoxMXZidmNBTHpRVDNOdmhha1lu?=
 =?utf-8?B?TmhHQmFqUUU0OEJZSHV0SUcveDh2OXY2WGxFbmNiLy9rclRqMUNWOXp3LzNZ?=
 =?utf-8?B?c3NLSFp6SGxGVTJ1NS9QS2ljb1VoOEhiMU5NaEppVlBTMyt4eHZmdlhrNkVL?=
 =?utf-8?B?Y2FSaDM1M0ttdWF5RmE4QmkxOXYrZnNoQngxVFp3azZKU2ZQVWp5Ri84Vnc5?=
 =?utf-8?B?RHozazJTWU9tMVNtZ0NDN1hWb0ROejc2VjE3cG1xd0xvZ0h0TWVDcU9WY0Y5?=
 =?utf-8?B?cTZPc01MN2JoT1FGdGJxSW1QK3hPemNkT3pRUVpCeDYyNmhZcXpYd3BZY2RF?=
 =?utf-8?B?cFp4RE1aYXc3ZG4xdTJaNFdaV212Rm1GV0FIUGRJUGRKaWtXOFIrTXBRS0F4?=
 =?utf-8?B?enpmN3p1QVRsVTVkbzMvVTM0VGNQN1B3SUsxV0lSWmVBMUYvbWloYVdVRkNl?=
 =?utf-8?B?UnF1eTlGZkFEcG9Ea1k1d1hpRTRPY0gvcHB1WWdiclQ3NDNHZlcyazNMWUp6?=
 =?utf-8?B?bkVEWkNCTW0vdzRsVGRhamNjUUowRjRsRGtXQytnMGJCOWtlZkN3cFZ6TXQ1?=
 =?utf-8?B?dENkZjd4QWpOUnFWTUZlYkp3R0ZtOFA1T2tSWk5jYURySjRQTk5jK2VyTWdo?=
 =?utf-8?B?dGZlTFl0am5LbmVQR2RZRkUrU0Nxa1ZjRitNOCtCK2RCRUpIeGlFVDNsbnNR?=
 =?utf-8?B?b3JaakRnRC9xKzFGL2dCdVNxYlpWRklRSkVLQ3hVbWhvUXVkT25OT3dlWkNG?=
 =?utf-8?B?K1Z2MVA2S2J6VHJiSnB6bGpmN3A1N1pHMzd0bVpXdjE0NndxNHBnUVNvZko5?=
 =?utf-8?B?VS9SazFNTnZBOTFZUmV4aWVaOGdtK2h6d0kzbUhEaUxlUDZUSXVobm5weVIz?=
 =?utf-8?B?TTBwdWF0NlZXQ05CbVQyaDVhUG9KcWRPTXV4K0svRisvOFVnOVU5cmp0QVA1?=
 =?utf-8?B?Z2ZlZ3RjM3BCcFdYRGUzYVFCU3A0WXZhTmhuc011VVhScDlsR0E0dmN0Yjcy?=
 =?utf-8?B?R3B3VkVJcFZteEF1dFhHNlFJd1hDUVpaTHFxcStPdDVEL1ErQXJEYVo1ZWM1?=
 =?utf-8?B?Tk5xWUdCK1lpNG1XUmxwclEzK1BGc1kwNVpUaDVrcnkyYjhVNWNwcmprRnZO?=
 =?utf-8?B?RnFTMmlDZ2loMVVQdmpsZTdULzBpeDA3MmdTeU5GdFM2M3QwRVkyYkJBR3Fz?=
 =?utf-8?B?ZXZJcWhLaGc1VTVMZm9ucVkrYWNhUUhDZEJCK2d6TzNNbm5GU215bGRGZW4w?=
 =?utf-8?B?bFhLdGtlNDYzQk56L3JRUk81V291T2t5cHJ3cjdlRFVLMFBxMUY4UXY3dUhr?=
 =?utf-8?B?Q3NsL0ZUZUNMN0xhendhbzNqcSt1ZTJEYzU4TnZJZHhpWUtyd2FWeFowUHRj?=
 =?utf-8?B?RExwYUFXUFNxM1lDUHlIM1NCMnFIUzNZcFczdGxHYlJQbGZmOTcyeEhVNW5w?=
 =?utf-8?B?SlAxeVMrYW80SFNmcWd1TEdRNWlaeDBjVHBFQ2xCYkxXY3dKK1QrRzJpUHM0?=
 =?utf-8?Q?b9N77CbMLZ/qQOPXDQLykmqGH3UaGwUzOM3iRD2FLlFM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L01zWjJUMW5sdmJ6cEU4aEE4ekdzM21NQWVVbVE4Zmt1bFc0Sk1aZEhtMVc4?=
 =?utf-8?B?MGVKa3lxSlhBUnFWd2pNVHZNdVFQeitWZEdBVHlsOUs0SEwrN0pmNGc5YVpP?=
 =?utf-8?B?amxjNEg4UWhjYitReG9tQ2JiZ2tKR0hyc0xRd25qYmFTTVBWYVpWZldXYjJm?=
 =?utf-8?B?bHZYelM3bUxKMGZKZ0pHUExOWVVUaHlEN2hCRnh3TVhZbTFvQjA5dk5EUTBz?=
 =?utf-8?B?dVZudksrUVJWdWR4amZJdnovdm11aldiV0NYYyswT3FhSy8rdGJTaElET3ZP?=
 =?utf-8?B?U1FsM3lSQUx6VHBaaHRGNGd5MGJJRkZaa29lTWY1RlN5S2wxTllEbVFiMlpx?=
 =?utf-8?B?cjhhNmVJWGZnNFFrY3lKRVY3Mm5VN2FWZ2xJYlQzTkIrT1ZEMUJJemxqcjYz?=
 =?utf-8?B?b0lCR0FZUXJobEhBVWc5UWUwb2ZhbGN1aXE0dlUvNndtTUdJdmJMQldZWTAx?=
 =?utf-8?B?T0NTczZkV1pGSjJFcTNpbk4zNlBac0RjZ1RyOGJlT0FsLzBoTGY2elNsOE1y?=
 =?utf-8?B?WXZzdlNDS0ttbDZZRnB3Y1dNSjB5cDNGSjhjWTRMcFJkSUprK3FGNFluYnk1?=
 =?utf-8?B?NjRLczhlLzdwMzd4T3J2TkRXOWFHWE1Pc2tPQmFiWldOektHaUxSMHpjUVV0?=
 =?utf-8?B?R3dMVVNwQ3pReW42dytUUEFsYWdCNGMwL2U2QVhIaHlQRlplRXBneExFTEdy?=
 =?utf-8?B?TnQ3MHpWcDcrQUtLM1ZOWGRJTVJhdjU3a1BjVUd3NXBoc044NW0rV2hPLzVB?=
 =?utf-8?B?TG9pcnA3bmRLaVY3enFIa2grRXFaT1RMN1hKZlhBV29ZcjFTTjB1SzE1ZkJV?=
 =?utf-8?B?eEFvcVNiZ2ZSL0t2djRUaVdQWWFaQytUU0NTSVQ4UFBtUHRveTIvbWw1OXFa?=
 =?utf-8?B?VGtQTEhHZjdTWGcrcmNvdmZ1L1puSWE3THZ2WGV2M2FWb0F5ckkwTVR2ckwv?=
 =?utf-8?B?Z2tDRFprTmVCTnZtS1BsVzNvTWprTTBHbHR0RWRtVzQ1R0R2Sjg5QnI1Y2hw?=
 =?utf-8?B?WWJnVmxXTE56eTdQS0NRc3FoUklrcFRVV2p0aWFlTlJQblVRdHIxNExXQVhZ?=
 =?utf-8?B?Y3Y0cFRKM3IrZzA4WXVBSVBQREFub3k0WGtQOEw0QVhaZW12VDVwQ0NSMUly?=
 =?utf-8?B?NEJTOE9IQjFSOXptVkVqQmE1bU5xS1dxdHF2bUNBK3B2WmwrN1dMVlJCVkph?=
 =?utf-8?B?bEowM0VIYzQvU09PZGtDbk54TU1UZGNlS212ZTFaTEY4OXR1RVVDSDRuc0p1?=
 =?utf-8?B?SEE0M09oZDFORzhTK1lPc3QxOHFrOTJ1QXBZNWhYM3o5NTdDSkFKS01lWFlq?=
 =?utf-8?B?enZBZFEzVTVyUUlpbjVPU1pMZ1IvUjhtYi9kRW9vUVE2aHA4bm1naFpKTkpT?=
 =?utf-8?B?WW9SM0VrSUdZd2NGY3dqSjBET1Q2NFVDQkFzb1hwbzU4eGR5Ky9HNUF1cVhi?=
 =?utf-8?B?SXZoVjhIemtzTER5SGdHYkNkc2pHcnVoQ3F3MGErc0czSjAvRGRUWng3Y0dn?=
 =?utf-8?B?VHNnajc2T0gvdlp5SmJmdTVzNWpsd2RoOUVUekYwWklSNTdmRkVxTEV2MFJs?=
 =?utf-8?B?WkhyZytKSytCc2xjOHFBMmRHNGlPZ3hqVTgxYUlKcXV5L2Q2Q3NvSXRtZHp2?=
 =?utf-8?B?WFN4ekc2c2FUVWFUQ3FiRTJ5U0tCdVN3bVd0cFIxMUF0VlN0TEdOa093TGVS?=
 =?utf-8?B?UTVXdHcyVXNLcEY1NC9zL0d0YTdvUysxUStVaGNHL1RXVWJROFJ3SkZlM21J?=
 =?utf-8?B?STg0Z1JMQ0tiNCtlNkF4VXQvRzBKOE1qcExuUytyWXhma1hjZXRFcGl6TjQ1?=
 =?utf-8?B?TE5XT3NIMGFHcUhEdmdYL1lRSXJoVzdOR09rSnEwdjhaZGFjWmE2SmJmVDlH?=
 =?utf-8?B?WWJFaDl6bnlueEFlWktwcURlVkh6a3NnZnRiTWtMRjJwR3h4bjU4dFNtL1JG?=
 =?utf-8?B?T0puOElLeHNvcjMxMmsrc1V1UmRtYXJzTTZ0UHR3cTZmbG5NQ2o4UGQ5RW5Q?=
 =?utf-8?B?MndJbHFOd2RMa3lHSlptSm1wQWRLTzBCdGNZbGtHRG5qQnovOFVVU1NvQkxp?=
 =?utf-8?B?Tzc4TTNjWk9kaGZnVjBaREYwYXpreVJ4V1kxSmVYUzNZNlNiRC9xY0RGbWdw?=
 =?utf-8?B?eDBoU3daT1A2SGcwQTF3SFJQR0hHZHpIaUpnQkpGY0VaQW14NU1lOW5HMEV3?=
 =?utf-8?B?c2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d7d83b-a5ec-4bf9-ac57-08dcde083568
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 08:50:01.7936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1Q40ucIZzoyTpkvUp2Skz8z507aI9LJK1Mp519bXFPMnvU2WwGgLI33yZjnBjiztp4G0WkTbXn+3XGsu6HEOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8132
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Sep 2024 08:50:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16923

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=9&day=26&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/09/cip.2024-09-12-13.02.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - brief impressions from OSS Europe / Plumbers

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Fri Sep  6 01:15:20 PM UTC 2024
  limit date: Sun Oct  6 01:15:20 PM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Wed Jul 17 01:30:36 PM UTC 2024
  limit date: Sun Sep 15 01:30:36 PM UTC 2024
  Status: *Late*
linux-4.19.y-cip: interval 30 day
  latest version release date: Tue Sep 24 09:32:37 AM UTC 2024
  limit date: Thu Oct 24 09:32:37 AM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Sep 24 10:34:04 AM UTC 2024
  limit date: Sat Nov 23 10:34:04 AM UTC 2024
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Sep  6 10:08:05 PM UTC 2024
  limit date: Sun Oct  6 10:08:05 PM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Sat Sep  7 01:56:36 PM UTC 2024
  limit date: Wed Nov  6 01:56:36 PM UTC 2024
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Fri Sep  6 10:03:04 PM UTC 2024
  limit date: Sat Sep 21 10:03:04 PM UTC 2024
  Status: *Late*
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Sat Sep  7 01:00:42 PM UTC 2024
  limit date: Mon Oct  7 01:00:42 PM UTC 2024
  Status: On track

