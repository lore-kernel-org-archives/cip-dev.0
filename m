Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE83C2BD09
	for <webhook@archiver.kernel.org>; Thu, 27 Jun 2024 07:46:11 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.69])
 by mx.groups.io with SMTP id smtpd.web11.2945.1719474366436812291
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jun 2024 00:46:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OokyshCh;
 spf=pass (domain: siemens.com, ip: 40.107.22.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0mT36n4Hs86P7F+ZGdyvSFqe4R8+hzzPh302abvUARcTaP8SwGSH3tefq+a+3KB9OWZ98Rtw2iTblzaK8agXhCUIijSekDlH1OXb9XhFhkHXchUZTFO7M5ntEYZN3HUCIg96PL1TnlPMlxXAQj0NSIGOR4qmU7kgut5LdxeyIOyMQyan9BKRYpShzUcYpIDSx2RpKmHjSBA5QUQtDgWtNCk7nlwbIk/VR2hlKW0kjKqtTO+qZ4WxB5J7tylXIJurYBsMz1vgmsOL/LFi8+6mLzGA5Fie7zD4ABmQDQvlB9ZGfOcpEHOtxNYtJCrNd+icMREubNwttqaAEzet8MLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKr56rWEzAfJ1oyG4z4iMV3xcyna6V5t/PXn1JP78Y4=;
 b=IN69u4L260M++szJrQm9MEe5pkvaxiFboMvWouTgi6TXJC+79Zj3Us3jtgSpZrvbTHKfiUdX+ld8+xWZsFClKRVYQMLNMwi5AuKD/sxrzX0BD0p28vU2VbgreY5MimNw+0DbZbDW+IEklXXJmYpUq/8Dp9NrBMjPRDypDMdgsh87l80eBOiXi4ihfL0g/xQcZVRjj+wwjQCYns/JFVDuHQl0oW7pAbZRx520EKqHbc5gWnfjv2qPTsMlGMY4dd/uGnXcvfr/0ijsKIPO5jSGqlf5NkLqYkwmyK5BxUEJD+Oe4FDun3AcPx0/0w1ZZe/eN+9WlLCDIvOJl3UmbsM1SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKr56rWEzAfJ1oyG4z4iMV3xcyna6V5t/PXn1JP78Y4=;
 b=OokyshChWDkt6ZwiQ4PEyo8s8EAUGJ0wfjPlMDuFiBxjH/jq7PytN95tA2ppfcTlVyGvPMRPU8sWsT7G0W+xW6zt4oRrEQDwWEeoEEdoKku8ZGcHSdRQWuy64QoFen4Np1vXbfn6Ce2MgZwX46xh7YqPz4J9RcYjRhdUSkn8L+Yd6vXenHp0elU2T+IfIa8FQAIPLHgHpyIfdMJ279usdL3FVl84VduGQVEyC0XBLGnNR86ymbS7Hb1KZk3y6xUMUG8aJTJW0qeru826mRX6ao6W3yI24Vm8Dci5oqEea+2FJTR9B8azgwQWcbKsxZ8UZMLnkm0/vXYqUWgaRBxDHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3748.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:173::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 07:46:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 07:46:03 +0000
Message-ID: <277126e5-ccf2-488b-a0cf-51c1885fb379@siemens.com>
Date: Thu, 27 Jun 2024 09:45:59 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3748:EE_
X-MS-Office365-Filtering-Correlation-Id: eb671e1e-6ee0-422c-b684-08dc967d31ed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TVFzcTM4QnFramZ3QzV1UTV1WGJCbWwwMHJueit4YnN5OUllb0RGZE9sZ0Zq?=
 =?utf-8?B?L0RML3ZJVThLNE54VTRmbXV0U3dnSFlsUU8vOU9McXBhV0ovUFh0OG9NOEJZ?=
 =?utf-8?B?b2l5L3Rsbys4aUhtdllUOHFuOE1panlrTzBHT084bmZkTGtMb09mZTd2MzlD?=
 =?utf-8?B?KzhvbzZuYVkrRFhYUFJvWDBYNk83bllvTXp1N3llS3ZMYVA2VjFDdVYzblNL?=
 =?utf-8?B?d29GaGZIRnhnczc2OUx6WUVCYkMrbGdJeHNSU3V3UGEwV00rQTB5bjV4cDdV?=
 =?utf-8?B?bTlralh0cGx6UTR6aTk2WUY1WmZYeU1IMEp1VStwRWhJNTkzN3pnREh2eUtT?=
 =?utf-8?B?dG5aQVdZOVJhaUJUd05ONXJqOG5FVjg1Mm9WYXlwYjIxWVExRkVSdkFmNU9Z?=
 =?utf-8?B?MDF1SGtTbzUyaU9nZVBFZEJ2aENkOHVFWmtFcElQMmJSd3QvVnBUYTR3WXZr?=
 =?utf-8?B?eUdDeVNmUzZ2Ky9OUEdYYUxMV2NMbGdMSWtERnlpWm15eUlKYXROUzZjbSs1?=
 =?utf-8?B?bGdaUGJiZ3NLZ3N1U2NmOXduOXY0QUFXWTE1RmdxTXdkU2ZGN25Pa0xwTFlP?=
 =?utf-8?B?a2hLeFcxU2w1TEF3eFBSMWdVYUphQW1ZUjdpVW9PT0s1R2JRVWhUdXBtVmlO?=
 =?utf-8?B?cUphR1lOWm9aZnFEaDlhQVdrNm9CdUxzdFJ0OW11ZTJudDA1dnFhNlBPZ3V2?=
 =?utf-8?B?N3lDZWtTTTBDMzlWUnJkVHZIcHdENGJpM2thRE1UVG9TNm4vQ2dLQy9nR1k4?=
 =?utf-8?B?dStmSXAzc2Nqb0p3TkdSalM1NTFmM00ySmk5dHhDOFFTOUtNNFBvWlFDeCtu?=
 =?utf-8?B?YnpGQjU0eHNEa2NVVno5TjkrSWxYUC9mYXJ0OXkwTzNUWjFkSnZMT05hV1VG?=
 =?utf-8?B?SDdCMTVNZ20vK2RodWkvNlh5TngwTkJtcmdVdk5ZUWJsS0MvVmFOWi8yUGMy?=
 =?utf-8?B?eXM0cy9KK0xUaVA3UFJROVJvdHlaOHBJaUIvOU1heVhzc1MySVVPMGczSU9j?=
 =?utf-8?B?L29WTk5ydko0RkEyQWVGNEpCQjZ2YWZraGlZUE1UT1B1UEZhYVJXdFF5YXA5?=
 =?utf-8?B?R2dDVElMQldpWDBid1Z0aDRzM2RLRG1BQnpheWhKaVdDbU1TZTdOQ2Mwello?=
 =?utf-8?B?L2JESjRMcnY4QWlCSE0zWTdsQzMrckZSTmorMTRLajdUNWUzTTRNeEYrcVpu?=
 =?utf-8?B?UkxuVTFYNmx6eERjQ2NiWk9VR0ZDRkRKQSt3QnBuZS9wcGZjbHhkMTI5bTRB?=
 =?utf-8?B?dUNaOGFaN3REWkVPb2tmZC9wRnRVMWxYYW0rcVJXeVk4Nmx4UVRLR0luMVRw?=
 =?utf-8?B?bG1udGtERkJ2MmpFRXVqOTkvU2p0YzBscjU5RWFHYzI0NnJZRGsraDV3RmpH?=
 =?utf-8?B?ZHpGRkFhTW9PaGUxNmNNWFZOMGVURlhYZ3lZTEZnNWN0M2t2SDREbjNBWGI0?=
 =?utf-8?B?SnMyWk5saWY5OTNOZ1pYUlk3aENXVnRJRDZYOUpKeUZhcndEMndSc2hoMS9G?=
 =?utf-8?B?SHB5b2FHdDZxWUErQ0VIbUo4LzBQZ0RQbW5hbEMwdFRkcWxmZkdVOGR1VFVx?=
 =?utf-8?B?WktpSFZXOWNhZXNNMEg4N2g0TlNVOThQV3M5WmVONzdPaE1UcThhR1ZSNkJ1?=
 =?utf-8?B?UG91S1FaWS9JRXlsc3VoeXZnTXYvS0ZXZUdWVzRyVFozU3dMZno1a0g2Q2l5?=
 =?utf-8?B?Uk5VR1BKR1dnc0tyYUkvaUlQRms1bW1NeG5NSzZvdDlUbWdSTzhlZEJJb3hl?=
 =?utf-8?Q?WzeuKJ25GcXkzg9zN8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a1lxVlBSb1Y1bHRVampHMjNValV0UzlySHVCaU1rTGNlSm1McEd6Z3RyK3FX?=
 =?utf-8?B?REZDWEMwdGFPeG1KVENoUWs5OXBJY214Qit0RU1ic3NhSFAvQWRWZVUzZDNR?=
 =?utf-8?B?czJidDlGRFdoN0k3U3l1c3M4ZXBYcWZ5RGh4YXpDSEQ5MjlQNytaaWtFUmpC?=
 =?utf-8?B?SXVCb20zTklXb3FGWFA1Vk9jd0ZrdWRLNUYzeG1iQWdCWHJxYkFGd01EZGRX?=
 =?utf-8?B?Y3NMc0hUSXBxVytvTkdyZzJoUk9mUEZpY3FXd2Z2QzVCaFVkS2RPeVdiT0dt?=
 =?utf-8?B?YmtDYzNMbUdqUk4xc1Izb2Y4WHZzc0J3aGpqNmNBRjVqdXJFT2dpY1p5Rnhj?=
 =?utf-8?B?eE9SRHo3WU5ySTJYcGwyN0dPWWJTT2M4bzBkQklyUGd4NDNSM0FmQ1UvQ1hC?=
 =?utf-8?B?UVhsLzdrTlRHSFdIM3IweGFycEQzdUEvMTNJZVFlTmJpQzBIRUJvdjRRQ0E5?=
 =?utf-8?B?NHFuWDB1VGlFWnJaaXFrZXlyQVVPUnF5NEJCK2RLLzJMeGQxM3kwMEZtRGlR?=
 =?utf-8?B?ODVrUnRDOC9qSk43dmFZYkpmRkNVWm1kMVplUHhyUEovazA1OEdpWVhYQnla?=
 =?utf-8?B?b1ZmZXJwanhFNThoZ3JzYmZBY1ZXTVllUjAxb1pKbnhEM2NKYzVEQjBPVFJU?=
 =?utf-8?B?cktiN3JPeHFEamhoWE1tdWlJMFNHbHpTNWEzSVZzaDJHRFZCTUZBc3ZrRjNP?=
 =?utf-8?B?WWhBSmpDbWZpcXhNUHBNeTRISGoySG9qdEhGdml1aVI5VmxTQkpmV1dZVHRI?=
 =?utf-8?B?dStZMEhNRjVkUTZYSG9XZzRaWnNhMzN1d250SHNyTXZTTlhOaCtqZU04VTZx?=
 =?utf-8?B?RlYzaUZNS3NKeEJjSzFaYk1pS2x1bmJZT2NNQ1UrZWJ4VUFYVElJOHRvM3Y2?=
 =?utf-8?B?MC9KbkdqWTFBTXFlN3RzM2ZCS1lrcE5DV1pmcDZTaVFBeVFidEJiVnpLTXIx?=
 =?utf-8?B?Y1lxQUlCUjJoSm1aMmU3KzFVaXpBUE9Vejl6dlF5Rnl2dERLd2VNOFdSZ2Nt?=
 =?utf-8?B?cjRVN0ZjVGhDTjFBOGZXWXppV3Bka2d5ZTFRbjhiWXBGcEY1R0YrSStIbWR6?=
 =?utf-8?B?UTBlMVU1SEhSMXUzekdLbHU2L1lPSWErV3Zzdmg4MldVZEVyczJXMzl6NWx3?=
 =?utf-8?B?NGVLWUFucFNuZ0xGYTg5V0NnM2pzUEFnbklTRnhjL213MUFEVnpYNzd5SUZX?=
 =?utf-8?B?blAvRFAxSFIzTTV2U1hxcmFYSEUxdlJlQlk5UDlrUHhnU21POW1oNmVQTm9I?=
 =?utf-8?B?UXY5VGZYc3FZenFKR21uL25hbXlwNHRSWXdnei8rVitab0l6U3hjaFRWVGlW?=
 =?utf-8?B?MHJkc25LeGZhbllnbERLeHQ0anlSVGhHOGtObGVqQXZHeTZ0bE90MlZ2dGdv?=
 =?utf-8?B?MGY3WGVVcXhKaFJRN3kwRmdJbEJKVEZ0enFyL3pKODFPNkRicnJKYS94bk1m?=
 =?utf-8?B?NHBiSjliLzFiU2QxbEZWaklvK0hodkt3eGRjY2tsS2VOeXUraGQvUHpINjJn?=
 =?utf-8?B?UnhKeDBITWRRT095eWovODdZeHNib2VTSHlOS1M2YlRiQmlNZ0NiQ1NOejdl?=
 =?utf-8?B?Q0g5T2QwQkp6NkpEc3pmTWx0WjE3Mkt4UmdUaVVFNlkwNk5LWUZVRjVjRTkz?=
 =?utf-8?B?L3Y3VXZOZDRPM3ZiaWhJQUlkTHQyYy9Mc3ZuNGxKSTRIdVdEYi8rNnNWRHRN?=
 =?utf-8?B?WEEyOXJLTUk4eVB2MlZHeTh3MkhqbmtoTXczMUxrZVA4d1hqZlRBbnRQeVB2?=
 =?utf-8?B?ZTBFdEpldDVzblR6ck5NaCtlUXA1S01XYTZOSm0yK1pPMk5VZEt4aTlrekxE?=
 =?utf-8?B?bWlzc1krclVidW1TbmhQdmJUNlltUjFXQW1JMUU1UTBwQUZtRExZOG5IRUQy?=
 =?utf-8?B?d0hTVmJFVUhIbWdINVlZLytiak5JMEprS1hOVDdUQVo4ay9hNThKdHRiOE1i?=
 =?utf-8?B?ZmV6NmZodFdEZ3ZWemdGNHhDLzBnREpZRklzWG9CU1hVTnNFczlzS1JNTUln?=
 =?utf-8?B?N29DSkRHVExLZzZ0RHllOWdkSm14U1I2clRvZlRGSnJNbFFHck9CU21HR09I?=
 =?utf-8?B?MU40bkN6NXk0amQ3MHVqQ0M4cHlYOTIrL0ZIeXVjMUFEUUx0RzRzNUtOKzgy?=
 =?utf-8?B?Mlk3a3JBVHQ0QzhZSzV0NTExc0s3OEdIL0xZUCtCZHgybFJTM1RVd2JjRUdI?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb671e1e-6ee0-422c-b684-08dc967d31ed
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 07:46:03.3729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0avYyfiMBzcQ0YZRyVVmJZYs/crj0gU2x3HQzz/1YZQFSk/MLv/vXO1Qk+PwupWHcoWIxmX9S0gEz+YlFe5JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3748
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jun 2024 07:46:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16336

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=6&day=27&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/06/cip.2024-06-20-13.02.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Mon Jun 17 08:01:45 AM UTC 2024
  limit date: Wed Jul 17 08:01:45 AM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon May 13 07:50:32 AM UTC 2024
  limit date: Fri Jul 12 07:50:32 AM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu Jun  6 12:19:51 PM UTC 2024
  limit date: Sat Jul  6 12:19:51 PM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Thu May 23 09:06:28 AM UTC 2024
  limit date: Mon Jul 22 09:06:28 AM UTC 2024
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Jun  5 08:14:01 PM UTC 2024
  limit date: Fri Jul  5 08:14:01 PM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Thu Jun  6 09:43:37 AM UTC 2024
  limit date: Mon Aug  5 09:43:37 AM UTC 2024
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Thu Jun 20 07:33:33 AM UTC 2024
  limit date: Fri Jul  5 07:33:33 AM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Tue Jun  4 09:25:36 PM UTC 2024
  limit date: Thu Jul  4 09:25:36 PM UTC 2024
  Status: On track

