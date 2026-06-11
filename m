Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CC0CD98C6
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 06:01:08 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.15])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39281.1781157666261465492
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Jun 2026 23:01:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=r2mnJC9b;
 spf=pass (domain: siemens.com, ip: 40.107.159.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUaEvaCoBYcxFiwtfvJpiEpmUJfUJ0WRPnWbint8K3S32qZwTRRP0OIEoLDFq+c6sJKjeqdOgXrbzGK3kPQDERDl56AW66EblmNTNThDOMdUHAKJp1giCze3h75Xoolum6JXYKBv29ibJYYny+dW3p3TbjE4sNl7j7GwFvsKNIYDgEy3lgrNFMjOTH4QiA0mRy8qcAbkPmSsnZSBsJqfU6pHqKb6jG2JzlHjmkogKJtAGzSB2K4F0xgBjNN8DDSBkF7xjEACuNNbOC0cAzlRTJLFlTeu+DC2jLXDD5d+n8meiH9mOwju3ZdHPgyDBJAtT0AYpmLwutlHLgp5dkHfjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goCk2nZl1Jim/XGxz30S8WCCE8jLZ0+YZoUXDlc9rnQ=;
 b=LI6IzNzpSMKvChuWjksGnUt6R8xXgc2toCPQEd7ws8QijvRmdGJOhUjmPZbQplnL0vp5L4nyFT7GMWxOL36YlHVMk5jekn4WVMi/MSen0HtgI9ozTfMzJFu6eVrLqBOMw6A+7ECNjBUjQfE9txWp0QZlIq1e+uf0SqxMDUlsTPeMCmRo0Z8ipDq0up1IQs/2JenuJTpeBkisv2VLM00qqBnT6nM3Ez7dvVPMl3ulUGKuw/nDPAsvJW8/m9KHVkVVsW1CSglwIefO3CJyrxh5+i9AvLNjSyDm4J7vfvdh47FHIJuLkxTz6dUDFSZC0reeey7RyhqhE30DYi7fzg4kGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goCk2nZl1Jim/XGxz30S8WCCE8jLZ0+YZoUXDlc9rnQ=;
 b=r2mnJC9biBvk+HQGr1hWICOwV/Sx1kXjGfdXP5uMdVYrIA32e5s0hQAoSsSFe/RhfFDiFegnBBa3pNgYUKOI11dv7teLlRj5yzaajryrHwFQaMQPwQpvy/oT+OvZXbiZADjR5IWoiMLljTcYYJVoaxt9Lr1nNa6Lz4cxCT1AFhrbhVFPubq3AbfAMRMLXnIIs6t3UlHrj637ZKSWW6lC/zrxFAUIYazJyaA+fJEP55njEWl2d4AKRpqFwMLLWbCUmR78KveszmRcCv24sCz/9U73V5u1s9PlaqFipcqtoGTDleNprwZb6AaezzaqrPdN0tt6uOJVILA04SuEkYp6FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8566.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 06:01:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 06:01:01 +0000
Message-ID: <7baa2d90-e789-468c-a14c-cf7cd26c129b@siemens.com>
Date: Thu, 11 Jun 2026 08:01:00 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: cf47ff37-0a90-416c-ca8c-08dec77ed0e9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|55112099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	+9tnatnXFVhwT7D503sMfHHlYNmPQaTamg9BJMy0lzHedzlUMS8jCQ5GkejicqkT4wqwrsm81A820QyCmm7vSRiZC3ezaX/HNYD+L0yhcmywmg81AOteOG64D8VO6tBPYfYpO45KxIyniiEkxtucsf1HGRUMJV7JzbU0QgpSxvGARz46Hm1LM1U9q15MVTNuDvbDEqR2DtS/UhYaZIskIm6wQOs9cyWlOoMznTlDmZk5/RP5AtT+wDzfTrZjhmsrax308jZHybbBKDqVqhxaeV/ZiIjk0FftGKHWtxLfCJlbUwNipduhKGHiz2NHiPJsvLmcFgAkeVKCLHsQQLwD9Rw4OCV/xATJOthwBu4+BXGYb2aOV9ueZ2Sj+PE3FW1kuqoIqL0F6tPrjo3WJDgqGhQCs+a9x/02SsLioJiNlPpHJ/oR63lY+sIFOwh22Gf/EcQL+ACxXSCvzpu/A2K25iD30JPoIekGrLDV5qGZOWU7ZcjKKN1AReLtHlnEZ/PlRX8ELfNiXmkESSxJ8Dh+1arZGHU1PfpJjcL0QKO8bU1zszi6kL+UzG27YJxUD29kd+IHMgmbPBTJ1S1IzZvIQZsxOg8W/7rXlE56ZV3z1Z/u7iA5Dv5+kDd2bZdxgyw6e6Ve1E78eXpOZJuWNDq1VQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(55112099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UVZKMWsybGlDUFBNOWFrNWxBdGptYmx6Qm4vSm9JOFF0ZVJZOEE4N2QxSmdq?=
 =?utf-8?B?TFM1NlJPNSs3ck83WE1hZ25FKzJSVE81K2FQQU5IRnpZMSt4ZFJraitXUE1C?=
 =?utf-8?B?bHZkSnlWN09DamVtZUljWEtNYm01cWljSThXV2ErU0kvS0NuZHhZc1drSU5U?=
 =?utf-8?B?cldwNUhZd1VSN2hSSXVuWE9ESmRSNUxobkxpcUZXeWFpVkxlbHR3VU05SHYv?=
 =?utf-8?B?a3JsaTN0dmhmWkpBTmtpOGU4TWlaM1pHNkE5K3NBdGkxWXZyblVoY2w3UzlC?=
 =?utf-8?B?d1kvZU00SGJubzdUY1B2VjR0b09JcmRaN295TFNsa3BiRWswVWQrZC85YnpU?=
 =?utf-8?B?d0ZrNlNwc2lySm1RRUVGbElZdnlVWnVxT29GZG92ZWtWYVkyZmQvTjZ5MGtX?=
 =?utf-8?B?ZEoxKzE3b3JhYXlOMEoyUlFwN04xSTYzT25jYXBTdzhUZ0lxeWMyeFczRStN?=
 =?utf-8?B?UGZRLzhvdHFSQnJ1aXFhTGVhbHhDbXM2bnlBeHVaNGpxTHJoS2ZWZ0NOTmds?=
 =?utf-8?B?bHA5VThlY2VVN2dPcnBTZkpvT09tWFJpQlJ1eWVqSjVFcDhIVkEwUWdjOFI2?=
 =?utf-8?B?Z1BOM0M4TVNNRzl5d2NQclJwUUhqK1dQZUJHTUdQbGJUMEZCNTkvV1lYNzd4?=
 =?utf-8?B?eU52UGRrMWVjbXlkNEt4WnF5c2NLc2ZyVy83VjFzTCtXL2lLNXZrT1Z1OWox?=
 =?utf-8?B?dDdtQmpqY0MvZ3RlNlVybGZMdk5Gb2RwSFNqZ2pFV2NncmZiRVFPZS94a1Q4?=
 =?utf-8?B?aHFiU2U2Y1l5ZGZNK1ViVjEvaHY5dW5GcmZEQWtlS3VDZ2c2Q1BPaGhJUmpu?=
 =?utf-8?B?VnRyNFpxbWEvT1pjVUk1KzZwUVBXcEdWdEtBZEJ3cUUraUlFVzduZWYrdU5h?=
 =?utf-8?B?VjhyTWtOUEU2OVB5WUNEb054UElFbWpnUCtHTWdadTdqaldRcWh2SXY3Qmsw?=
 =?utf-8?B?bDlTUC9VRUUvK25CTFZnSXhZTkF4bE1Zei91b0duZ0JFb0V5MkErU1QrMWJh?=
 =?utf-8?B?YUJTeWJpT2luQVNiWW9IYkdLeGFkc1FQeEVrN3VyZGp5ZHZ1cm9XbC9qNHhQ?=
 =?utf-8?B?M3M1cEkxb3kwUVo3QTF3TmZVK0MxbHdycldqRDlXZG5uV1R4STlsak03MXh5?=
 =?utf-8?B?Z21OUXpoS01wMGR5aHd0Y0xXU3lpN2ZKaTlYSkpTbU1ERElIRDVMcjZtMmdu?=
 =?utf-8?B?dWhJdWZqOFBaMUtTQXdEVkZKRnl3UHZoT3ZwSlpPSjNkMlZzTTJMaVMvTkhx?=
 =?utf-8?B?ZHJSeTN5WXF3Rk12RnZXQTRyVDVEQ01scXVHcjZQSlA2S0RLa1k5MWU4emdr?=
 =?utf-8?B?WmlrZ2Z2ZTFlbmxOWlRENUxNUVlnUWtFcU9qQ2ZUam44VVU1dnZGNXY5alNQ?=
 =?utf-8?B?cnlQZkNzOUJubHpvRHpMcDJyK3F4dGVhd3VIelN4cENTOWlsNUY4WWxvOU9t?=
 =?utf-8?B?RG9oQTF3Qkw2alY2RS9WZFBwMTVBSTNwZkZBL2NxekkyKzdaKzREbC9uOTg1?=
 =?utf-8?B?TlYwMlIwa05DK2F5YUFOcDRTeXBLN254MUoydUhwNmhEZkNmc2QrM3d4Qkgv?=
 =?utf-8?B?cnM4N3pqQTZ5Q1lMa1k0S1l2UzFWQ0xhYnFZVGdEUVMwYk53VW9YYnR6aEIx?=
 =?utf-8?B?cGF3TnM5dGk5Qk9WVGt1aExzTjZwM0tYVnpvV3FNWkJaSjljUGJZdVJyV1Vk?=
 =?utf-8?B?OFFwRVlOdSttenVoYSttMEdCNzhhNW1vdjJXWmdMTmpZaVN1QkkwTW1PZ1Jz?=
 =?utf-8?B?bFZBZko5T1pYWWxHS1Q4cFZKUWgxRG10QjJhTVZ1TXJsU1RRc0dEYlhHcDFq?=
 =?utf-8?B?NkNOSzZCLy9Qb1dIV1d2amJxcVVWenVFTVFmRHQvaWxaREUvZ2hTeUZRWlpH?=
 =?utf-8?B?dkx6SW1wU1AyS29hcWNuK2pqUU12ak9heE16UDA5b3FheGgyY3FFMmdwWUxu?=
 =?utf-8?B?QWRseTBDR05xbVV2VjFsbnVoZWRKOS9uNnNTWllXeEQxVld2SmxucDNTeVNj?=
 =?utf-8?B?S0lVcTNVdWhGa21pOU85bm5TY2RLSUhYY2lkTFlFSGt6WWpGT2JmYjJSQ3FI?=
 =?utf-8?B?QWVpVGpiaUI0R2hIUCtOQkUrZFIxbnl1SkI0MEN4L016dlprcVI5ZlRSNDBG?=
 =?utf-8?B?QXl5cVFLR1B3M2tMaFBNa2dXbG9OS0p3bjh4YTZrV3I0dGJWNS9oZ2Z5ZGlI?=
 =?utf-8?B?SHVpamNMem9ZRmthRTJXWVdOY2t5UGxyRkkwUDdxSk1ScVcxSW9YQU8rYjhm?=
 =?utf-8?B?WjVncXdHRVJoWkw5T1FMOGljZDg3RVlWV0Nya3JNcm94QW1uQ2FhZXBadW1w?=
 =?utf-8?B?UkIzWmdYVXV0YVVtTmF6UDFFUUlVN0N3M016YmxoR2FrbHpYZFdEQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf47ff37-0a90-416c-ca8c-08dec77ed0e9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 06:01:01.9029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGdARMzrj3JkRhuqx7NbjoTGR0j/pyF29ozIkYAzF45gKhCq86I4K2ftvXquSzYL0ydG4hSGjwpEjIItv1BZlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8566
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 06:01:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23058

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=6&day=11&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/06/cip.2026-06-04-12.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
   - AI-assisted backport reviews, continue discussion

Jan

[*]
Date the data is created: Thu Jun 11 06:00:40 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Tue May 19 02:53:20 PM UTC 2026
  limit date: Thu Jun 18 02:53:20 PM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon May 25 11:40:18 AM UTC 2026
  limit date: Fri Jul 24 11:40:18 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu May 28 07:36:48 AM UTC 2026
  limit date: Sat Jun 27 07:36:48 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue May 12 11:56:37 AM UTC 2026
  limit date: Sat Jul 11 11:56:37 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri May 15 10:25:33 PM UTC 2026
  limit date: Sun Jun 14 10:25:33 PM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon May  4 10:49:51 AM UTC 2026
  limit date: Fri Jul  3 10:49:51 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Fri May 15 10:28:23 PM UTC 2026
  limit date: Sun Jun 14 10:28:23 PM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Mon Apr 13 11:43:31 AM UTC 2026
  limit date: Fri Jun 12 11:43:31 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Tue Jun  9 12:04:00 AM UTC 2026
  limit date: Wed Jun 24 12:04:00 AM UTC 2026
  Status: On track

