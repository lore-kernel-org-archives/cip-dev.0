Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436A1C369B2
	for <webhook@archiver.kernel.org>; Thu, 17 Apr 2025 05:15:55 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.47])
 by mx.groups.io with SMTP id smtpd.web10.1933.1744866951480378201
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Apr 2025 22:15:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dDlU8/eJ;
 spf=pass (domain: siemens.com, ip: 40.107.20.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6kIW52JR9fjEayzHmYg2BkYEeuM+aCxoSHlHjuIEFNp8HarEdiRpe3Fs5axOuAraZPq6K34kS1PiOXjrdwbONjLNxIF6Kz7cmP+NIkSE9wqUj6tPnh5BuIAWyGmTfngGzBoZ71+6J1VIejwcLgi6iddAjiZ6RJ24uX2tMf1F8STittzP6OmCUtLcH0gfXPlEiURs9zrr+8Nw8s92/W/2brX3A80LPRhJDBP9rPIWwvC9qQbaq6yszDMSWWKTYhDXFYDC+1x7eVcBz5sXNUS8nH5Vjuh0CqZ5aES4N4M5nFQp1w/lZUypc5Vr4UF48A6HJQR1N018Uk9KAii2f4F9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXqqAjSOD/EZ4uqMXaU735wMto1an+La6i1D9SZ+Epo=;
 b=Ja37jZilITrhHo9bfwlgCmh+BP45YpTvmTjEJE57qFH5+UcXbok7Nw92DY0n0ZYC9FJifreYWpQ5feBR1trgw3e79SNND16sFOo37HtVDljHup8hzRbv/I0gDnb6nPmpYH4IqflW84w75FPFkDoDVulpP9+WmOVNH3ZLtsMILL0YZhW83ql2jHkV++ptK/8D0LnfECJ5TJQLnpoINMy04UxFY8JuQNZy4+JCcf1Z9UpTxkf/cF7QRMAdkOWYDebatUfvvgozuWcGAcXjhFXCpmmmxO3aD/vipIHudOTnk2SJvRg+PqkB8r27XyCi+399QZ8+G9UAyb+24JHVe68R5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXqqAjSOD/EZ4uqMXaU735wMto1an+La6i1D9SZ+Epo=;
 b=dDlU8/eJVRpHOrTgh/hqQBLFhVtX5s5t5y0kz7ppvOHHU2cNS60AUo2y3gPc/dkWZjEWEfNftjjwx+z0osp5WvfnBLZDftUCgTPCbdzAtsUEY52geA8kfgsXXM12Ru9n5UzhVnJbqDguPXBMY7nOpPCRDjJ1DEOO6oFU2Xb04+P66Yxw5uoFGD/j87dTbYrXi61++iOwludQWtJG9gExtlZQ4j3eadrcXsUZIZz8Du4sZydphJ8vwr8iqe8kuCFULRxj9ldgys76gD7ro/3Pq6it7DiSHUP5ZeG7jFgYpVVGhZ/xscGvRdqI22npu9BxC+2Uhkpg5SzIuPtiIK61Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB4064.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 05:15:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 05:15:48 +0000
Message-ID: <492df690-c43b-4ea4-9305-836ec2d66762@siemens.com>
Date: Thu, 17 Apr 2025 07:15:47 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ff322e-faf9-4a28-17f7-08dd7d6eea01
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eWZDbDVmanBIZGdiUGdmOE41WmtNUEU5aHlOeXAyNHlESmthTW0vbGhDRERs?=
 =?utf-8?B?NHpaaEhIMlBZdVo4eEs1ZFBGSnRnWEFmTG5aNFhNTHgwb2UwUnZGTzFLMENl?=
 =?utf-8?B?bnhTdXZwQ1haSFZrRExPNWh3UE1ibnEya0dlL3FCNTl4MkdaY2djdVZrcGxI?=
 =?utf-8?B?R092SXBSU3Z4V2RNWUVVWmYycXNINU5GL1ZXTFM2YksvdTZRZnNtT0dKSk5N?=
 =?utf-8?B?ekt2QXNuT2hTR20xM0pjRDlPWlVEeTBPK3R5VW10dzN3TkppK2xCaTlHVmh3?=
 =?utf-8?B?ZFV3K3JpMHA2T1NMQmhQYVN0bEN1MktPdHh0V1RPN1gvVm5TMEZiMWVmV3ox?=
 =?utf-8?B?TVN0dFhVaCtrZnVQVkNadjYyemZyaEVDMU1pTFpXN2pwUVF2cmNUdVJyMGFQ?=
 =?utf-8?B?Sk5ZMnVqOUtwdGRXbEZBZnNZb2gxSFp2YXV3Qm45aEppMWxtVlRFbkxMak4w?=
 =?utf-8?B?TTA1UVBrR3VWUUxLNmZiNlF2bnVBL3pudTNBNFFpdkhQRGg2czBQU00rY3Np?=
 =?utf-8?B?SndBZFZITGtxbUtraFNGdDEwT0JCNlc4VGFoVlJmV25QUW9LMC9JQmp6RHlL?=
 =?utf-8?B?dFA5Z0dTOUF6b1Rkb3JMOHYxcWprTHRQbUp2S3BDSG5xTXZ1UFlESXZxTWlh?=
 =?utf-8?B?NWpMUENXZnJ6WTVQOUJlYWdzMVVTRlNJbG9sblJuLzJtZTd3MHBETm9ZdExs?=
 =?utf-8?B?Qk96SWNOR05qSHdNd1JKc0grQUp6dUpkVDZwdFpKU1lRUmFjQTVuN05Tb2ZK?=
 =?utf-8?B?TktSVFNQRHNVNisxVy81VWg0V1RVTlV4VjdaZmYwYUtldldHaTJuZG5mVG5L?=
 =?utf-8?B?cGNPZmJPNnJiK2FienNRaDdNSmNnUVBNbFBYQ1RUbXZXeG1WNFFNS09McHV0?=
 =?utf-8?B?dDNXM1VlSnQ3aVNCYkpJQlNpMVNGR0NZbDEwRzZXS3lpeEZMNDY4U3BJdzNj?=
 =?utf-8?B?VXhXRHhJd2M5bkY2T3NLai9XY1luNC83bEdDaVB5OVJnYXl6NEpWUDI5UW1C?=
 =?utf-8?B?ZGRKNFBGN29pTlFYR05pNGx2bEV3WGFpNDhrcmFUbXIvOUUwTmJPWlMrQ2dx?=
 =?utf-8?B?K2p3NXpFWlhWUHJWMWErdmlIckFpNG9sQk1rTDkyQStDVlg0YkY1VUhRUUpT?=
 =?utf-8?B?MUpRK1hPVXV3R3BGaGZMWVVNa1pCVTF0dDkzaVM5NkprbW9GMHF4Yk1JcThJ?=
 =?utf-8?B?M0Z4cENPUlJCWXIyTEV2NHlwV0gxdVEwOERwK2FpdG5TOVhzbWJybG1oVGIx?=
 =?utf-8?B?MTRibFRQWnF5elVTWEMybnR0ZmorN0hPZlF2ZjMyVUxHSlNmOWRPa2cya0Nu?=
 =?utf-8?B?dzNFL3c3WE5BMXhibWVrWlN0T1Ezbkt0enppSDVVRnl4VVo3UktXYVNxMnky?=
 =?utf-8?B?Nk5nOG1qSURGMk51OHFQR2llTm5uWUIyUGxtNENieEExQmp3c0xESG1CK2FS?=
 =?utf-8?B?N1o4b2JsVEQzSThBdEVObkJXeFFYTUxacDMrV1BNamM4TmNaeFRuZ2Vqb2Vh?=
 =?utf-8?B?U0djeW1zdWhTNWM2RHIrckx4OGNMeU8rL0tYbVRDK3YyWjB1WmpaV2Vuc1d6?=
 =?utf-8?B?eDBITDZtL1BtTmdDT09zN3JWcXZFL092RVFrb1VDclN0eEtiN0JpcmUwWE12?=
 =?utf-8?B?Tm1BelAyWVA3NkxtU2ViTmV2N1RHTjRmeDJOQjRQVUZWZkJYV0pYSXpMejA3?=
 =?utf-8?B?U0VvenRqUkJ0REdGVFA4SlZxb2JBTHo4d1hzeHh4QU5vM01RY1huMkhLY0lB?=
 =?utf-8?B?Tzh2NkFHYlVWeHN1Ym01UDlSNnA1QmtIaHpOd0o4ZWh2ZS8ydHBlZzMyOWd0?=
 =?utf-8?Q?hrfCrvt7VMNB4rGUY1kIo35NxNzu0+J6LEnPs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ais1VHRXSk53aFV3TUkrMHI1emp4dzN5V1BDZThXZHEwS2hKSDlYSHplV1Ru?=
 =?utf-8?B?M3IxeWo5eFlFQjYxMHhiODY0aXFUbUEzM0tCMWtrWTRhbzhyWjJYbjNZcEoz?=
 =?utf-8?B?dUtYVFV5TWZJNURmbW9NazZRQVl3dDYzWU84WGV0RjNKUkVvOUkzR1pDcHRv?=
 =?utf-8?B?cFRNUzZBZDZIeEZjTWtCRS9FREd4enIzOVk5WXM0L3dBOUNDM1dJNGlQa2pU?=
 =?utf-8?B?Z0draGN1M1FPZlQ1Y3Y1Y0xVazIzbFdMVmVVS1RVQzl1bUV5amFCL1MvVkxZ?=
 =?utf-8?B?VFF4WFJ1bE5ldXBkamlJd2pzNnJJejg3bHE5c2dpbjRzaWo2Q0dldFhqWmpw?=
 =?utf-8?B?VFRNSHJyVVJEQ3M1VC9UT2RYVmZFUkF4emZhVkVUSVZZbUVRS2xIeXVSTE5F?=
 =?utf-8?B?djArZ3Z1U1lFMHdoTndnb2FrbDdDYjN1aldVblg2VG5jNndOUWZYQ1VKVTds?=
 =?utf-8?B?QnN3d3BOQnRZb3ZoYTd4bGttcENiaWZsUnJxREZYZjA4aVhWTHVWOFIwSTJZ?=
 =?utf-8?B?Z0t2Wk5mR2hDUUR3dWFkWkllaDV3bWplcGE2Q0h4bnBNalNwL3JpVzFNQWdu?=
 =?utf-8?B?anUzUTAwRTFzdjd0NVpJZ2N5V2MrNkRSQWt2VkNXa2Q2dlR5SlNnWU1PbSsr?=
 =?utf-8?B?dk42WHpmdlNxL0pXT0gwVGNBWFZlN0xIMHB2WHkxZmNyR284SXAwV3NFUUtX?=
 =?utf-8?B?WTVSSmN0eEE3bmM0U2doNVdITm01K1V4bHZycld1OFVNK3BMZkhRT0ttM085?=
 =?utf-8?B?RTNmemwrY2FNQldRR0x4aktESlhGTWxDS1grR29IWmlBUmRGeE9QSjU2cHZM?=
 =?utf-8?B?azA0cWpOS3ZvUlhmZGsxOFN4VnhNRUovejB3bGJOY1RWWld2V2oySENCVzFB?=
 =?utf-8?B?ZEVzSVdTWXQyN2lPWTR1bTM4WWhabjlPMjZ1TlZHVGhCSFVZRUd2TnJOVVo0?=
 =?utf-8?B?S0dKNVkvQlRtWnhGZXlOWnZ4K3lNWXZ6QjdrWndJZVpndlB3TnJuRjk1WHp4?=
 =?utf-8?B?aXBPMkpjMktRZmF6SWprcE1Dck9YWTZhWjZlQlhELzZFa3g0ejBmQlk0NFI2?=
 =?utf-8?B?LzlQMFUvRWxGdXJxalVESFpaVmFvaVc0T3RZWHorSHBXelhrSks1RGhjWEFG?=
 =?utf-8?B?dDI4NHBRaVByejVqb0RyUEllRlFxTzJIWEJyMkZHVUdpWmtwYUNtZzZFZmg2?=
 =?utf-8?B?Q1ZQYU9JWFdFRGlWZXhOaEhwY3QzZEVpMUZxZGlIM1FmajdrUXE4TGszRmR1?=
 =?utf-8?B?OHdZZEdzMFkvK3Rpa09EN0JUMndicWIrc3JleGRHeXI1WHoxYU5HajdCSGZv?=
 =?utf-8?B?M0Zwa1RmdDBIY0MxQXZxc0ZQRDBZQmZFeWVHQ2lBc0tSM1JLRkVVTkkydTc1?=
 =?utf-8?B?YUFsR2p6RWpNKzRaS2hhZWEwazA3U3FRc1YvYXNPV0ZCWGVNZlRNWWNvcVJJ?=
 =?utf-8?B?dkVoRVgraVV1RHA5alNwUVQwYVAwMnhoY3B6eTJ1UWVpMmQ5V3dnRXpBRDF3?=
 =?utf-8?B?MDF3QUY1MmtWdkY0TWZBTUdVcitQN3d3VGZaOUY0U1ZoYjZSSEpFUDVsMm9z?=
 =?utf-8?B?bkYxMmVoaElqU0JpM1VQaHlONnFxWmlSeTFES2ZTQVZnOWsxcDdrQnFjc2NZ?=
 =?utf-8?B?UXFGazN5bTlJNkVpZnY1d05DMDZsRmJtNGtPd2NnMmNnNlpFaFN5VE1hbEFw?=
 =?utf-8?B?Q1ZHN2xQQ0xWVVUwM3E1bkZRSlRLSmZGMW1XWUxyQVJKMWJWSHFtaExzSHVS?=
 =?utf-8?B?TXZNTHdSNENKbVVDcnB0NjVVYml6SzlyT0s4citydjQ5MjI5RWtkK1VmMXow?=
 =?utf-8?B?ZE5CcHBsOVFVdXJDa3NrTDhOVzQxTzBXcFQvWEo0YytteEFiWGZyb3Fpc0Ur?=
 =?utf-8?B?dldhTVM5ck5wUXZIRWNUdkQrNnk4OXk2TDdkd0dUc3dlM2U3U1NZcTRKTWFs?=
 =?utf-8?B?bk4vazlBYjFKVmdOTlMxdWt5ZnFQelRpM2lGSjJ1anZUWE11c1RZTys5WURR?=
 =?utf-8?B?aFVKL1RHdkVIMGExM3pYWXhMSzNRc1VZSmtZRGcveXJrWkZKR2h3N2h0TGRz?=
 =?utf-8?B?NWNMWWJmNWtabnRvdHFXR1phYjFqVnFwdlltczZrSVd0OE0zSjFtYTlPK2dT?=
 =?utf-8?Q?H8rCosmfuQvdT0p33r1XMmpZB?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ff322e-faf9-4a28-17f7-08dd7d6eea01
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 05:15:48.4370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ku1b/sTiz0FDobyww7vAx8/gWntEsjBS22OfqjRAGvBtQyMLFaacYcidHvMEvY7anygveUT4KDBCwFG/yTjrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4064
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Apr 2025 05:15:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18517

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=4&day=17&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/04/cip.2025-04-10-13.00.log.html

* Action items
  - check release scripts/procedures shared by iwamatsu-san [pavel]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Tue Mar 18 02:02:02 PM UTC 2025
  limit date: Thu Apr 17 02:02:02 PM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Tue Feb 18 08:21:29 AM UTC 2025
  limit date: Sat Apr 19 08:21:29 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Apr  7 12:49:49 PM UTC 2025
  limit date: Wed May  7 12:49:49 PM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed Mar 19 01:02:44 PM UTC 2025
  limit date: Sun May 18 01:02:44 PM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Tue Mar 18 09:47:53 PM UTC 2025
  limit date: Thu Apr 17 09:47:53 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon Mar 17 09:54:04 PM UTC 2025
  limit date: Fri May 16 09:54:04 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Thu Apr  3 10:12:44 AM UTC 2025
  limit date: Fri Apr 18 10:12:44 AM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Thu Apr  3 11:32:00 AM UTC 2025
  limit date: Sat May  3 11:32:00 AM UTC 2025
  Status: On track

