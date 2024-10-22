Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401ABD1CDCB
	for <webhook@archiver.kernel.org>; Tue, 22 Oct 2024 09:39:54 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.72])
 by mx.groups.io with SMTP id smtpd.web11.14463.1729589993508423811
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Oct 2024 02:39:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xMuhtk4G;
 spf=pass (domain: siemens.com, ip: 40.107.104.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQXWhy6yqutEPV5o48/nJELySW+CP2eM58Ez5fpEvbV70onQuX/oDmLprwQWSnaGFqCUHcobBwI5FBTvsN795PMFSSvjy+MgifGFMkX9Q+KP0oGY6s2X4ZHP2EslRSV7PNtnmehxfUqRARRfy4gNM30UZCT1+aVnK/Cylb0SObDCrOLzR5W7vEVGnA/eKSL3V2ZKxlLzjVmme07D04W+iJNdmISZlHb2z2xm6NzKmjEbjGbGCUYZWs2ATL5Ev/IjaJoFXZDXPygg8iFQedDJbLc/SLM7JCtPRMVNGblLvxpL5CrmkookYm9GRA3JmAHnsAqw2/yp75dgbiPbj/2ZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovhiLdj70fOY6T1y+FL7pnGU6vtarrEAARSHzevRAqU=;
 b=DCwNhh6/B704OUTSO/Kx22NQrCcaE+JmiRP0Q2b0cARZUCuZhF9K6x920+d9w/eF3mO1Idrr4BJt0E1f5QP3PUD/VykzaS3XSpNyTs9YsVYeorHy/930go8D20XJC2ijfZn8SuJVE7ux/liMoEm5bV6/o5lMjrYhRplbuIO7VXbV80FuMYjweglYi9zveIJfBIjk3vlyrCX+tshOXZiT28uCXQhT/E7RL8FucFjzRug1H1B3VjY9sjPSXvebjjGnqg6JZ+T7ac07rSsI2PNJm6eEaY7YPIlPziyzrW5dN5ShQkfy/v8wbDkCPx0O22tyxl3QrYZode0nhejpsXSq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovhiLdj70fOY6T1y+FL7pnGU6vtarrEAARSHzevRAqU=;
 b=xMuhtk4GSMwp8Q95eJObX/avPsnEb+1UcoZ/iZm9VIaviIuKy0kDujyxDRhejBnMlYLcLShthgftqMSC+GUiwzT2PlVtuufRMgbWQRjB/hvVIVoj8HwoXJ8YufnhvInOhDgLHsScssS+BcRyVc0conWsw70qFikl4FYZpnNDgy3ySRgKrtxpcueY4m9jfIYPf9xMUREKUBXoczYyzacmi6s9OqJVRtB3pEempiACOf0tlNcnbg97LCASru/f86+DuhOgcOJ8r0rwIZH0wjqRUbHBrcmVJ2k0GvQ46O67yghJOaFfyjBXam/r+Z9zKZXLtNJLhRouc8jyGD3ITCDGlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8237.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Tue, 22 Oct
 2024 09:39:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 09:39:50 +0000
Message-ID: <7a9eee8e-1917-49b9-9abc-d16aa367b2df@siemens.com>
Date: Tue, 22 Oct 2024 11:39:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: cip-core: Something fishy with qemu devices?
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>,
 Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
References: <88ea7ac6-a855-4b2e-92ae-0698a91928d1@siemens.com>
 <TYYSPRMB0010816199991F38C90CA81FB7432@TYYSPRMB0010.jpnprd01.prod.outlook.com>
 <1fb9c7f6-81eb-4f3a-941f-ccbe97112816@siemens.com>
 <TYYSPRMB0010E7B364227D25124D5A4DB74C2@TYYSPRMB0010.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYYSPRMB0010E7B364227D25124D5A4DB74C2@TYYSPRMB0010.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df036c5-9f5b-43ab-d6e9-08dcf27d79bb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?K28wS1RtNDA0YXpTQ3R3VVNVbWFmMlZ3ZVRjQ0NBVUVXWkpWTmZROWdDSVVF?=
 =?utf-8?B?TlNGaWRhelQyYlZGRUEzdmdHUW5vUUtLanBzYjZ6Vi9vUys5aHFJUTB5VjFK?=
 =?utf-8?B?aXRwZEJ5VUU4TkM0anZrdHhJbDF0WnNSaFlaWUkxbVQwc1JnNTRER2tnK3JG?=
 =?utf-8?B?T05xYXhnNVBUVTBmOGVIOHh2cGVoZGR1Uk9Ua2FMdFcxRHZQSkpJUFFQb3I2?=
 =?utf-8?B?VmdJV1ZILzlZSnpnYzRKZTcxQUwzdzM2ays2Nzg4T1E2azNvRHJKc1FZaThZ?=
 =?utf-8?B?OHlyWVU1VUxLM2cyNzAyT253K3p2eWpLaFZGalg0S2hUT2NmYks0Y2RvWGMy?=
 =?utf-8?B?cURzR0k4M203ZWZ3TXRwL0loSmFWMlliSHV0WFFYbWZhR05FNDk0djFzZjc4?=
 =?utf-8?B?MDBya2hpclIvZ252TnNJb3dBSHJyV1FCOWFlTG1lL1ZaSlRVS3BSQU40SS9Z?=
 =?utf-8?B?L3BVNWxRTmZweWFhOGh4dTV5ZGtFZnJzVFpJMU1pRkpKT05BQXI0V3A4c1dk?=
 =?utf-8?B?bHBrSi9HTlpNMmhzNXhTVDIxMU95OXIyeGRVYjJweGhUc25UMEhiUzdDYnRN?=
 =?utf-8?B?K0xpY1F2MWhwOGQrS2lVdnFtb09iQVRXc25yTFh0TmtUMTZWMjQ3VFNnZnVZ?=
 =?utf-8?B?SEl5dG83dWRUTHVwWnEyL1NNaUFodndlQUd5N1VEcGN2QzFUdy9XekVJUXhy?=
 =?utf-8?B?S2pKSDEzMkRRWW1tRE1oM3doYkVMSExPRFo0ekVuSms1c2EvcnFMRGJDcTdK?=
 =?utf-8?B?UFhid2tIRjdrdjNWeDE0TDRKSXFCOHU5dVA5YjFDT3FlWG5LcjNaRld6V2dx?=
 =?utf-8?B?V2dtYm9ENE9ucGxkS1NSMTJtN2hrT3c0dDREZWZVK0MyYk9tV2lKTzhWT24x?=
 =?utf-8?B?WFFIK2pta3lydDZsZGhXcTZBYXpnZU1QOU42Y3FVVGg0T3RMMDZra3NtSzhw?=
 =?utf-8?B?YUc3ZVhGdERxZWNmU1BoVmNWNUo4KzRWZGZGdEdicDIvOVlhUUhvV0J2NzN0?=
 =?utf-8?B?N1NJU0RNZDlncnR0NXlVZ0VNSTI4WXI1ZGRianlSQ25vMkluTjNYdDBabnlU?=
 =?utf-8?B?amRMb20vYVJjTjhNcC9RcStGN1lNNVgzR21uQmtVWDV1dUFrN0kyVWRQSXFI?=
 =?utf-8?B?dTl6RWVONjVlRW1Oa2RhR3dnZkdVSDhMVHMwWmRvQ0hYRTlFc1hPcWZycDhp?=
 =?utf-8?B?RVpXQ0U5b2JOQzZqTEpyRmhxYnpWcElQeWtBZ1pJNWZ1YnBFaDIvOXgzaFVF?=
 =?utf-8?B?dXFENVNKcUw3NENsWVpVTzFBMExxMW1nUkJveEdQbU95VXpOazNqTW9IN2Nw?=
 =?utf-8?B?TmxBNVlvSE8wNmtjOXV5dFR2N3dTQXhxbVFMeUJOd3BzY1BqNC9JRDJzSUEr?=
 =?utf-8?B?bTBwL0tWNG1GUytSTDF5VjFFYXQxWE0rTm92T0ZqUzhnc0hNNGxLeHFmbUtN?=
 =?utf-8?B?cWxmVXFjeWRTdkl6WFhqek5nelpjUDdDL0NSZFNhbWhEMHhNSGh0VEpqNVAw?=
 =?utf-8?B?ckNYaGR4ejhrQVVURmRuK01iS3M1WTFtdC85WHhSbEl3VTVPUHdyUXE5YjZM?=
 =?utf-8?B?L2lFODhYUVVjMy9udjBHS29qczJPSlBVb01lSFQ0dFNvYW9zdXh5MHFJMFhL?=
 =?utf-8?B?dUJWMjlhZGZHYTI1NElOKytyenpZRjBvWlU4M0dSbldmVW5Gb0ViTFZvRnlY?=
 =?utf-8?B?R0Zid1hWL1cwZnQ0Q2xacGp4bVRrcC9BcnBaZEtZVXhCTnZTSFFmK3NSbkhw?=
 =?utf-8?Q?8ZOLX+l8e8nm0asONL9LfyRni1PTJp2yYGQCGOU?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VlpLUXpDZXhhV2NuaTVSWWVZNHQrMEJoVFdSS0tXZlhjSFpPcFBJQVVyekdz?=
 =?utf-8?B?ejVmaDJwRm45ZC9QOERLOEdQM21EL3lIc1dFbVZPQ0g3RkJqbWxEc2JPY1d1?=
 =?utf-8?B?cHQ0cGtNMUYyZGhheVJQUTVXbnFCbFUrUDZEYVJwOWJ3V0hSTDlpM2NWQm8z?=
 =?utf-8?B?R1VucFBCWGJPbXpVa0VSbTJLalNXbDZpZ3ozcDNQNzBJVHdUcjNEUE5KUHQv?=
 =?utf-8?B?c2lNWXROMFNnc2pidkIxZzVpRk81MHBGUzJXd24xRDEzQ0lhdWJ3ZWx1VnRk?=
 =?utf-8?B?V3I3aHJxRWh1aGt5S3FiV1orUEMzVWdXbHM3SXhja1dvbG15Sm9hYVBOeGhy?=
 =?utf-8?B?bHM3RGtDMnhEaTQzdWVEZTNmU240eWJrNlM2ellRaEtZUkJQZ2JXTzEzWVFF?=
 =?utf-8?B?MWY1MVFmZmdsUmhCcVZPaXdQVGQrSk5CWVd2V2dnd2ZEVGJuQTJUamFrb0ps?=
 =?utf-8?B?SGd4TExDY1dkN2JmQmhQQ21CTytMR096UEdkTEpqcDQ2MTllR3V0UEFoY2JI?=
 =?utf-8?B?ZndGMngyd1lycFpLb1kvVk1tNjk0M0l4ektCem5GMXMwN2x3ckVtKzVLOHhI?=
 =?utf-8?B?dHBTMUZ0SmxhYVZBTUxEdWZMVjliRjFQVFBleklveW44Uk5jSkJWWWZES3dN?=
 =?utf-8?B?L0dNdjBPcGZUSHl5Q2tjamtxSnF4ZWVaQW9lNG1JclRjbDU0UUlkaWJROHJo?=
 =?utf-8?B?VHRKNW5XQTBubEN6S2pjUWFSbEt2c0lYZnV6dDVhdU9TMmtndEpMTUZHVTJM?=
 =?utf-8?B?ckg5TFVMcXlwdWpWL2d4eXJqbHF3R1c0NjJFdnM5Qzg2emVhTjU5NkxMQTZE?=
 =?utf-8?B?bnRoK0kzSXBBR3R5VExxSkFLcDhqK0NQWHJvQTVIS3laN25mZGdFblhOUDdm?=
 =?utf-8?B?cGw1YjBqYk9XbEpZNDI5R3JwK3IrOFBqcmtJcHU0VE5QZlpxMFdFS2ZSRTVz?=
 =?utf-8?B?RWwzZVJ2M0xHSWtUeHN1ajdWMTA0elVybmZLQmJoN2xtMWpVS2xwMWg1TUww?=
 =?utf-8?B?MzZsNmFKYmt3ZmplODlYL2hQeDVTMjBHZFFvVFY1cjZnYVhjTkpMY1NjdnY0?=
 =?utf-8?B?Tk1GU2ZHUFBlZVNDbGo1UW9iRXRnQm1QM1pvUDhNZTJXZG5neUUzTTBVK0h2?=
 =?utf-8?B?cERjZEJBQk1mU05XUnVVMzJMdE9HN1JCTmxwSXBIZVJpS05zNFdSNG9MUUVy?=
 =?utf-8?B?WVJIY3p4YTV1MFdVL2M3ZUhmVDA3d0VVZm9qb2NONGNLYXdUMXZibjlQTFZn?=
 =?utf-8?B?NStITEEwbVdtam1aQmdhUm5naE5nR3llS20xbUxuQzltR0M4d3RnTjRsTG93?=
 =?utf-8?B?TVRYN1Z3YXJmaVRlVEVrVFpRUVhwblpMYWpRK0ZzSU1LTUhFOG5aYVl3bGtR?=
 =?utf-8?B?ZlZnck5vNXhuUDdPL3JYeVFRYlBNNHNpd1ZVNjByb1JGM2NoUlh0TndyeEl6?=
 =?utf-8?B?dkdjako3RnJWRHNveE5FUC9BZ1FSWm1pSzh0UzA1a3AzQ2p3dGlrem12YWNq?=
 =?utf-8?B?dnhCT0k4MzNBVmk0RjFUVFdmN2g4S1RMaEFMUUZFRnFxcFljZExDVWZ4UUUv?=
 =?utf-8?B?S0lyaTh1aGdZZlhraGZwTU9jN254SlkwMVRqNGo3Qjl2YW1xS1NJQkFrdnlv?=
 =?utf-8?B?cCt1aHMwYmNsRUt3dXZmYWF3Ujd5SjU0YS9CY2NqOHNOeDRubktPWmcyeEpN?=
 =?utf-8?B?S2hXYzFVd0RDTmhxRCswQXF1aW9kUDlxcDJWNUVDUGtWTEZ2dWJPYzBUUW82?=
 =?utf-8?B?WVFiZ2pNcGdwaGtodldMazJ4OXJJUnNOQjZ3OEQwajRRMllCV3BVTndFY243?=
 =?utf-8?B?SHRXUmxNVDdBcWp5bUNyL0lqR1pObGI3eFdTcVFOZTVldmlmMUlrMEFPSW5C?=
 =?utf-8?B?WVVCSGFOdHJwK2RiRzFrSTZBeDA3Y2ZHYUhZQ1RieVRQZTZwNUx0U1U4OU12?=
 =?utf-8?B?dlpWKzVXc1ZhMFM1YUNPVUpLRzl1SHpQNUZmVUI5bmxtM05vQkJGUTIrd21H?=
 =?utf-8?B?ajhMSEt4STBDZHBsbGpxNDJheUxUUDJyMU5ndG1CdlRBVkNKTmQ2MzY1Ukp6?=
 =?utf-8?B?bm5WUDNxQzdtUzRpV3UrQUxRUUk3bFg3bjV5c1BUT3piNXJQY3FycnRrN3Vk?=
 =?utf-8?B?aXJQbDltSjVHdHFnNCsxak9PSVNIWFdMaTdubVBPNnA5Q0UraDRTcDE0aFlm?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df036c5-9f5b-43ab-d6e9-08dcf27d79bb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 09:39:50.8870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWmyd1YAPJce6ocDeYXUjCknS3/W890RJfuTnLTjzJbRIPgtF27VvpepzjMfwKOavcZrIpe5+fukBfAQgkS6pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8237
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Oct 2024 09:39:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17066

On 22.10.24 11:26, Chris Paterson wrote:
> Hi Jan,
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 21 October 2024 11:25
>>
>> On 21.10.24 09:31, Chris Paterson wrote:
>>> Hi Jan,
>>>
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Sent: 19 October 2024 08:45
>>>>
>>>> Hi all,
>>>>
>>>> I had countless errors with qemu targets while trying to test the
>> latest
>>>> cip-core image, see e.g.
>>>>
>>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/8129814767
>>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/8129786943
>>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/8129777118
>>>>
>>>> After hitting retry often enough, this pipeline now seems to pass.
>>>>
>>>> Any ideas what is going on there?
>>>
>>> I've been seeing some constant very high CPU usage on our LAVA server of
>> late, and I'm still trying to work out what is driving it.
>>
>> Hmm, hope it was not hacked and is doing illegal things now.
> 
> Me too!
> 
> However, looking in more detail it looks like we're seeing a lot of CPU "steal" from other virtual machines.
> We're on a shared, burstable EC2 instance and my guess is our neighbours are a lot busier than they used to be.
> At least that's what I can work out from my limited understanding of "the cloud".
> 
> We're going to change the setup so we get more guaranteed CPU usage on Wed night.
> So hopefully it'll all be better again by the end of the week.
> 

Thanks, appreciated! I was even unable to complete the current pipeline
of next/master/v1.5 due to constant failures (but the related setup was
fortunately tested earlier already).

Jan

-- 
Siemens AG, Technology
Linux Expert Center

