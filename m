Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09938C25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 09:11:02 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.89])
 by mx.groups.io with SMTP id smtpd.web10.23593.1716801049991846500
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 May 2024 02:10:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yj8eEyVM;
 spf=pass (domain: siemens.com, ip: 40.107.7.89, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O09BRDfCiDv+HP61W0H+IZewCVQwtT/1XfXejIVgnCE4cggKCco4y/6GUVqzi+sVwFeLu0dpYQBNeN3Hl5M01zcxlTjvCUieQKrqPVHvig6m6yZRjMcZJVMBKefDZoQz+R7MMuSVx0sXgMy/FH0kTcZV7I/pKzzFeAMguR7SpKcWisTk5N6FGzxXnpTwSu3ti87hG4qPkoGh+wI5Wfin840ChZasVF1YmTQwoZGPXR/Z5EKVkBNW5rVagnVeqNdXS5vJJ4jQPsFTIQP0jVrGRLJ3V9ETtmFxDuic5vNXjwmSpKE+7ZbaUgk+uEMVf7Qp6YGbPJFm++4D9gR3wpkNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVN2rlSTSleNQRk9YwBx/ir15wwPK1yrXpTIOepQ208=;
 b=Ec/p3PcmCh00gLSGBoTVRYwEGw2Mlgmh7GdNDOukmL6xFLCiyeodLjjaQMG9M2FVGqgQ+E8V7GioL3Slof/tH8HS9S+cL/uJzDkNJfRLeI1n5Ml65kjp0prkd8JVIWaKQeOuKqle8MUf3BnV7N/vqa/TlV2WIcoyrVCA5yOmJSfX7MID+xVrggIfEFNLz8r25Y95ubHNMc0I/1Z0GpeSbrB6N1NWjkYwDrHVo688oIrLyeLKFcu5GABVId483Jdcw9F4xEP3YMDRUg/+QzZxYgMgXr2hfkEwJV6Q4YlueoY+861ysJApj+2ZDohxdCPSp5Qa3cHvR84nWj7s9WXerw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVN2rlSTSleNQRk9YwBx/ir15wwPK1yrXpTIOepQ208=;
 b=yj8eEyVMb9p4naIuJ2DaPMS+4tadNLBy0Itb5CR/Thz4Dp+12uoO2ptxLQz3ckX477B1z5SscvezfiQdkX8MBs7LP3ui0g+TUKIQDf9SGyM9JB3IlUDTJIxHhSmlmWIEsznWp2T333hzrJBjxgdzHI1DGSufzJb6Tmduth/F7tWDV4Eur6CtgPcrdAPyN/tMIyBfyMpRED2N2BeKfOLBPY/YutGqB7r006OyX3EL4TcyiU1v5ztn76Oc0lFgPM18qwVC9fkpPs6Ja62cnnx/r7+1avUi5b+2Z0gnGtlS826XigkMiKj9XHl0l1Eer07oZ1TA9FJmI6ajAzZWJW6t4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB3PR10MB6834.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:43a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 09:10:46 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 09:10:46 +0000
Message-ID: <bef0ebc2-46c4-4dc7-b503-d1128c6be327@siemens.com>
Date: Mon, 27 May 2024 11:10:45 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: "Kiszka, Jan (CT RDA IOT SES-DE)" <jan.kiszka@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
 "sai.sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>,
 "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
 "Schilling, Benjamin (MO MM R&D SYS SEC)" <schilling.benjamin@siemens.com>,
 stefan.ss.schroeder@siemens.com
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core]: Proposal: Replace security-customizations
 with recipes-security
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB3PR10MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 1753be92-154e-446b-92a3-08dc7e2ce4fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007|3613699003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S3RuT2FlYVZ5aXpDdGNNNkJIU29hM1AxWjNZektoT2lmelBjSzM4ZW53Sy81?=
 =?utf-8?B?THE5TEhTa1ZiWDNkTHAwclBTVS94RnU0T21RU0VQWVJBTU9ZRTU3MTBpd1RR?=
 =?utf-8?B?dUNFblFJL0pjRUpQLzJobnV6bmtyQ0s0ZVFvQldJZDVlK3lnTGZnZ05jaHU3?=
 =?utf-8?B?aThRa3dPL0I3NTlIeFJyOEY2RWMrTjhzRm45TnkxRy83cXB6KzdsK3VaeEc1?=
 =?utf-8?B?b3ZmdHNZZW5MVHZRRWFXWU15NDdzcFFmWFRZaXZBM1h0MWMwMzdzOVprYUNR?=
 =?utf-8?B?b3hXOXA4Rk5kWTQ1R0VOWmFUZXMyUWlJbVFEWm5sb3FuemJEYVdLNEgvcjV2?=
 =?utf-8?B?TFpzYkhIT0hoWGsrbTg1UkwrTXlUU1BVa045SjJ0UTZKVDJWelQ4UFR5dmtq?=
 =?utf-8?B?eUV6VnQxQjlXM096SjlTV0lGdG1ZSjlpSFYvRkpGOW5IWFZvUG1HektSTUs5?=
 =?utf-8?B?eE1WMkxLdDhEdndNSndnNkJhSy8vajhpYS9HRUxzK0lwNlVPcDdGZkJXNSt5?=
 =?utf-8?B?UVEvR3UyY1JDajZUZmhIOXJUYWx2YWNleVFJcVBjZS82c3VNeEUzSXFaWnda?=
 =?utf-8?B?NDBFVVdJbkk3Mjd6ZGVxQTRWUTFUN044SlZNZVJLN1NHaGp2NVp1aVNXbHph?=
 =?utf-8?B?ZGhaTzBXcFVCRmRidEZ1Yngrc0huU01ndUh4MmFpK2FRT1hlMnBERU8rVjdG?=
 =?utf-8?B?TFpVMENPZWM2aFk4cTh1QWVuU0VJdXRtd3c0eS9DWHFmZm1taVBCMEhaakNE?=
 =?utf-8?B?OHRNbXZIR0ttK3JlN2p3OEJENHFxOEQ5YVhkbzlsZEczVEhhd0NqU2c4SU9Y?=
 =?utf-8?B?ZnE3WHJqOHFuR3RYK3FSeEpXNW5BeFV4YlpzUmo4L2NDdnoxK09leVhycFdi?=
 =?utf-8?B?WVJuU3cySDd0SlZNUm0rd3pRYmovTlhVRFhWUk5NMlY5bXBHL1Q2UEZPWDlt?=
 =?utf-8?B?VTR5SlFzdG5Qa2paNzRKb0RsMU9keHlXR2VOWWJQRmk2VTJjeVVCZEZBbUFn?=
 =?utf-8?B?V1RIcUJ6cDA5T1dZbkwxbm9qelpacS9sWjVqdUV5WGVjZnNQRExLTngzWC9I?=
 =?utf-8?B?ajY3VlN5TXJ1WVFtRitLbXF5QUpXQ2F5SzFhUitNTUFlajdKL0dYQmh5SWxp?=
 =?utf-8?B?RWNJbzFocW9mNjZqT3YzT1BzVllzbzRiRnAzbFlvaUQxMG9QWUpQQllJUm8z?=
 =?utf-8?B?ek5GNlp3MFBHUTY3T0hXeW1qKzU2RDdRV0U0NzdjNmNJL0o5RHZ3b3JibStp?=
 =?utf-8?B?VkdrRWd0ckQwOVFxTVRZK09YZXZudU1JVWhUUFV1ZmhMSDUxZ3RsOXRLeFBm?=
 =?utf-8?B?SkZtVVI0bi9LeEVvMndSU09JN1ZtRDIxR0srWUlSbFYrVklyL2ZYT2svbEgx?=
 =?utf-8?B?QUVEd2h0amREUzZkK3FTdFNmSjF3QTh5T1dnSXF2RUpWa0I0WGFadlNlM2Uv?=
 =?utf-8?B?SEV5Q1VNWlRHSHRSb2lYa2orTlJVQUE0TzZQMHpYVU5id1RsNFVTQzE2T2R3?=
 =?utf-8?B?cmVlcVRzdWZ3WnJUYkFER1UzTzJiUEx4ODh6eDVDdDI4b1FvS2Y4cDZOMkJO?=
 =?utf-8?B?SVNOWmp3aGw2am80T2FWRzMyVXFDVWNvaFRRSkFPYVJvcUx4QlVHbUN4L1pM?=
 =?utf-8?B?NHQ3ZWp1L2ZBUXc4YXVSWXB4OWF0S2ZNWVlER1d1c0xRNCsxaGpRMUtkZXht?=
 =?utf-8?B?Q0F6K29QWUU2eHFtRUV3TW1kWEk1OG5SelpFZDQ5aEhicVdMNlVzUXdnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZWFWUHFJU0NLMXhISm8vTytuakJoM0Vkcm5haHVOYUdsU2o2WHJIcHA0NWRj?=
 =?utf-8?B?b1FNSXRlYWJ4QjA0cFVJcloxeWRaRFgrd2N4WjFGYzAyWTlnVkR3VmZ4TC8x?=
 =?utf-8?B?dk9qVzRvcWx6VHNzbjNHTnpGbnByTllFTWFobGNOcVQ5UUQ0aHhWdFcvSVRT?=
 =?utf-8?B?dWRWWWZkWWlVZW1tQTZVSHhMNDE1Nm1peEZhV205YlZaK04xTXpiYXBWRUtR?=
 =?utf-8?B?SGl0dThnQWhYeXhON2tvZjV3YVRiS1ptVzdVbjFIOEFRNllGdTMzTHAvSTFn?=
 =?utf-8?B?SzlpTXFwU0l6RGJDcHh6VWhVYXVDcWh4R095QnhmaC9SaHNNNnkxWVdwMWhP?=
 =?utf-8?B?bGFyaUhyRGdueXIxL3VxeVM0NGdUYjV1WlZWc3dQdUgvYzFOejVSMUlxU1Mz?=
 =?utf-8?B?aDU5Tk5UUktZcXNoQlZ1NlJpSGdIa2xQc05BWE9SbDNLb3REaitRUHBONW5z?=
 =?utf-8?B?bStnZ3kzMkhhemExeVZsNVlXVWNVV2RkS1NWVmgxakY5VTUrS2FTR1NyaUlG?=
 =?utf-8?B?QlZmM2FCTndZVnBhVUI2Wm5yQ3JrcmxZOFhPRzd4Y2lqcTBuWEMyV09vNGQ0?=
 =?utf-8?B?SlVsNjFpc3VBNWlHbGZURGVtRUMrdyt2dHQ0enNFTFRaRzJVZyt5dWpHOU5U?=
 =?utf-8?B?bTZ0TlNPbSt0MnZoUk9xYmw4NC9Zdmh5OThTckx4eUlSdXBJV0dyUkFFU3dM?=
 =?utf-8?B?QkZVZXVlTE9UcVBybFpxRERMZjhsWEtGT1B4cVVzeVgyU2tBNWxXRmdueTRU?=
 =?utf-8?B?TWg2MldHcEZ1cTdIZk85cEoyZWwvSCtZalBQNEQ4SnZWYldwTnFQYjRtdXht?=
 =?utf-8?B?emtYbERGcDdzeHNZbmk2ZzVoeHloY25KTDFTcjJFTy9OMTU3OUx1Nnl5ZTVa?=
 =?utf-8?B?TTlIU2lXWVI5dG82MHlzVW9Dem1XenFyRTBUV1BSYlRmdURISnNsRDNJcDYw?=
 =?utf-8?B?NUpOVFBNSGVjbm1LV2xLb0RITlNQdE1YbEJsTmtXdWo0SDVGYytycFRTSHhS?=
 =?utf-8?B?UEwrdER3QkZyRVdxTkR6RWJtWGxqYWZSbkdVMjJLL29QWFFycDZsWlF4cWlO?=
 =?utf-8?B?SUNpMUMza1d3L1JodVNPaUxIT3NFYlNhaWVHVm1CTUdnUUF3dlY2TUM0bUd0?=
 =?utf-8?B?cDlqMTI4UmVaZWQybG1QTkZBYzBmSUwrR0pyS3hMRHBuZjZIdW1PUUVqUmdw?=
 =?utf-8?B?QSsxbXdnWTViRmhZS3VsWi9RN1hzWW5IVS9KWG15ZlhuaGt0V1JIN0cxUi9q?=
 =?utf-8?B?dWQvUk94QXJSSVBadEtiVkVNdWgvK3BGUlFQNURQNjBDUkduQlE2dmgrZ29Q?=
 =?utf-8?B?OVlrL0FhQXVqVzdBcDFPTmYxZVR4bFMraTROcVhXOUhZZTRJNm1oWWlHVEJV?=
 =?utf-8?B?MUpCOG9JK0FILzNWSUlRMmE1dld5WXI0YjF2K0h2WmQxUWlKV1hEM09hL2lB?=
 =?utf-8?B?NVh2cDc5aHZROXhlMy96TWxQSlhZejZKYjJIdFE4RFhkN2ozcmpJRkRyVUxo?=
 =?utf-8?B?eWFkUy9STzBIRjdpODVYSXgxY0Q3ZGxQZHBqcTVnM2ZLK25qM1ZMRTNmZTBk?=
 =?utf-8?B?OGZ2dnhhN0s4NnQ2anZWSVlNekRwRERsTTRobWQ2OGdJYkR4N3M5K1NKbW4w?=
 =?utf-8?B?RHFYL3VySnlVa0dncklBVFBrZHpjV0w3dW9nQ1ppbTNKTUFXSFFGaHhzR0JF?=
 =?utf-8?B?Q3N1d0dxQ2svTWpvTWV5ZjZBOFI4STRHQlU4dm44NnhxYTk4Q0VSQ3BnQmpo?=
 =?utf-8?B?aWE4bDJ3ZkZoTVdwNzNCTWhZc0VQRi9BNk40OWdVZUYvU2dWUmFyTE1aUGRr?=
 =?utf-8?B?NS9QQnU3VmlUaEx5KzNMU2J6V2VrbU5BU3d6ODVwem5sRUtnWVZ0TE8yZFZI?=
 =?utf-8?B?Z3RUcmFWT084NS9SdEh1eHk5aldmMStBM015YkdIcWU4dk96U0pIbTJxdUVZ?=
 =?utf-8?B?bUtmanBZS21VSit3TXBNU00xLy9BdW9HWWM2TmtLWDJCS0VrWVNQRGJHTWlL?=
 =?utf-8?B?Z2QyL1IxQkdqWldMTmErUFFZODFJdmNRT3p6ZjdqVzBJZVU0dXJCQUs4dGkx?=
 =?utf-8?B?N3dXcC9jZ3ljazloVWM0cGttc01zZ1RVOFBkL3pZaEUxNHowQ2MvQ3lCWGxE?=
 =?utf-8?B?bEJPQ25LajFuYnNZZWZMNnhlWnZSb0dBVHhGcWhSd25HZVdxTlBWL1kvTWxC?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1753be92-154e-446b-92a3-08dc7e2ce4fa
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:10:46.6148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fDzwb5U+82F+4Ieue+RESC1tpYZPYmmDAeGKpjVJqDoyD8al5sm0Wg7y7OTVmntCKbl3ovaFMs2PoStLA6lhm8h8i79KQuTvFS20sNGFfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6834
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 May 2024 09:11:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15953

Dear all,

Currently the dependencies and modifications related to 
cip-core-image-security are unclear. To clear up the dependencies and 
make it more maintainable and usable for downstream. create a 
recipe-security folder which contains for each adaptation an own config 
package. This also allows us to create profiles (e.g., ssh profile) for 
specific use cases.

See also 
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/108.

Best regards,


-- 
Quirin Gylstorff

Siemens AG
Technology

