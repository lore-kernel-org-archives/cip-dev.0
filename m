Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40981EF48D9
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 07:00:10 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.66483.1770966007353422615
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Feb 2026 23:00:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Wfu1Kuw3;
 spf=pass (domain: siemens.com, ip: 52.101.66.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYusyJ4YVInvt7PIRB76qNsBml3fbzj6evajhyWEKKCpf8yU8gVtW6tG5aMi8kADaYoedKmgMUy+1oJwPAlM1XrMF4p4MqxdfFukcsHDQKUh5SoUmqVYW6UQlwVY77BqV6hLIv6Zy/heGFj1RAzLt4lYfESiVuBkatEoBJvNdLlbIDWKhz0kSBtbKB4kgf85Cx5DzjuoY3FYJTijOXS8c88cdxySXSzC/XtZFRT+2kTxBzq+m346NNKgudq8HJ/rghBVIOmhDdia/gx3+A7I4G1Dp+egCrjWqPRe1q5WwzOffOU4jKBLChvulpS41dBei8NmFk/iHeCZ5JbLDY/4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fpy1XSvRUV53hLI/sYk6FumBDm8dA8Xck+4k1SZdszk=;
 b=uIsWW2qVO179jqyzN87SkxaDDhr+R8Rq+GIMBHN4WxXFJNJk3H4/j1NxoSu+hcgMMyyRt2MFhEgvTXewOCiTcdLW97LUb3wbVng4QElNxXU736gw3gvRS/ptUUFcjuj3vnIp5kxcXmGpF6P8Lcu7ESVP70nyqLbbYAYa8VMEVGF5ZZKx4tFrPjIb5WZFvhlAJENOZt7BgIr/4uAl3EB++3GnsfjreBI9ebgznuyk8jz6vfcf5JUfhioHdsjFGqO9EUmq28aDSJr5OeImtZ7P+Dq54kRod/qMHr7M3erbBjkChbKaWqeEYxzpvNcq97h2FkFLQciVwGpOACWK5d2DkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fpy1XSvRUV53hLI/sYk6FumBDm8dA8Xck+4k1SZdszk=;
 b=Wfu1Kuw3byrfVmefzUSNMgLvlGNoAR1rkWIFehBXQWT4CKywVLbt4Ndx3/dBG6115cqK6ETr1a+8oEXcS2Vk9HfaO5V7D/fZBiMpqQ59K+e1UaoetxaRMPYY04B7ppH18fyibJcwYNeDhhV0uDZWF/nbxCd1mw/RYCGFY43ld0GnIr9e62ioDsf2QV17BQ74vw0F1Tp81XhhTgwcZAFDXoIjDWHmnOxge6C7mQDKelDKcMIf8AjA9RhP41R4MUzC6B+1JxKu/gXWO2IW3Bu57yvj4CYDGoLEPXdKs13Op6UZ8K8L+0MdYD/nmbnNj+2BDSuBWmwd6aczvZ3BI6iinA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9076.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:233::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 07:00:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9587.013; Fri, 13 Feb 2026
 07:00:03 +0000
Message-ID: <779171e4-d002-44b1-a7e0-879af3bed946@siemens.com>
Date: Fri, 13 Feb 2026 08:00:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3 1/1] swupdate: Enforce signing and
 verification for swupdate by default.
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org,
 quirin.gylstorff@siemens.com
References: <20260212214003.734787-1-alexander.heinisch@siemens.com>
 <20260212214003.734787-2-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260212214003.734787-2-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8c0af2-865e-435c-4e71-08de6acd82d9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Nk5LNTlxZUFxRWhvSjJSN2ZaUFRBWjJUK0pKcExOMTY5QWZBYzF3bFhrM252?=
 =?utf-8?B?RXNWRFp5c2pQblI4WG9td2d0bmY3SnRzVThmeTZKN0Iyck9EWlI0WHRYL1lw?=
 =?utf-8?B?ajNJUEtmUnlNbmFlMTJMdFJLUG9VQURrUGVkeStZYXNqNFNKVEtQSE5QbDdk?=
 =?utf-8?B?MklIbHQwZS82NjdtT0hYUG5GNkt3NFVSS3dDWEJwN2JyMG5yS21ZdDF4L0Fr?=
 =?utf-8?B?ZmtlS08zcmtjV3cvbEFFbElWcXhSMFNzT3Fac2tROEhJU2ZwbHlMMFdpQWNF?=
 =?utf-8?B?WVZ1SHpSVnlsdnV6bzVkSzdlTEFENTB6aFBQNVNpYWVjK3NXNHhtYWI2eG9F?=
 =?utf-8?B?MXdpV0RrbGg1ekp2eVlwVWtMRGVzWXJZRitJNk1aR0hPS2htL3JuK0tDUFA3?=
 =?utf-8?B?dmoxNWNISi9VSTdKNTRuZUhPb3ZxbnZtNzBDM2N6MkNpQVNYZW8yaFpWSlR3?=
 =?utf-8?B?c3prTC9UOWFlRk4vblNrdHBRai9kSURBdFJtbytQd1lqS2xFeXNzWlRXK1VW?=
 =?utf-8?B?TWRsRHRTZmJZS1RpWGpiNkgyenBTa1J5QjVXUGRRdkRIWXgyaDFrWndsU1RP?=
 =?utf-8?B?ZVFoRHgvekRCVm5HU1J2ZFFiSEdldjd0c0QwYjFONWZETHlxbzlWZWF3RDRU?=
 =?utf-8?B?NTBDUUxBVEs1bXdjNDYwT2FCRVM1cElqa2NvM2JHWk5sYkZpVEFLQllVekJw?=
 =?utf-8?B?M3R0N3lUM01DS2xYdHZISmtEaUJWdlZFTUZIazNXSVhYZk9wUkthajJLT1Zo?=
 =?utf-8?B?K2pQS2FOSkNZaVRhNVhSelhsRG42dWhHU1ZIM2NKa2c2Yy82NGpMRnFOQmd6?=
 =?utf-8?B?MCtJbGRMNWVEdkNrRklzK1U2c21VZzZnaXRVRURhSWtJZHJYSmdWN0FXa2pF?=
 =?utf-8?B?ODNnMTg5c3N3Yi9kVHJra0tCakRJWkJZQnFBMHUxdDZDUmM2SUd1SmgwbnpE?=
 =?utf-8?B?K01qbmdIQWt4OUlDRFhTKzhXeUhzaktINTZDd1YxZkkrQVM4OXFFeWpRRmky?=
 =?utf-8?B?WTZLbUZlVS9FTkRWM1hYUEdTT1pxV1ZDTU50bkJFd0RvcHlqL01lVkQzNDBV?=
 =?utf-8?B?WXRPSmxxd0pnaEJtUUtIdjc3dHFOZy82Mldud1ZGdkcxRnJDQTI0bk14dFNm?=
 =?utf-8?B?aE0vbk8xcG41Zmc2YndBdWpXUjdvTFZKMWJXeTZPRkNISlltcTM3QmJkdUZ3?=
 =?utf-8?B?SEgrbTBPWmNYMG85SVlHSXRXY3VBaXJmODZQa3hwa1VXWGh5dURjU2xuYkhj?=
 =?utf-8?B?dWQ0SFNUcXBRa1JJSmlxVlNlWXg5MlczbThhUUpTblBlNDR0Skk5eldrZ29j?=
 =?utf-8?B?QUpKTjFQbTB6MDUwZ1Z5NmthMHdXUHFaMmU4N3pmMllYamtNdXB3MnFEYTcx?=
 =?utf-8?B?eTVTbW9CZjd3UllxMVY5NDhld0VTUm1oOU1aRUdHRTRLeWZ2MFlkMzRZMi8y?=
 =?utf-8?B?bENFVitpT05nUzFqcnB5ZlIyUVYrbkRzUzNaYk5xK2xhN3RIcmxvNUFMUlJN?=
 =?utf-8?B?M1E3RUFiSGVTZU81MUVvQVFnUmlEa2d1dng2dnFpQmxuZjRUWUJoc095YWRR?=
 =?utf-8?B?SzhUM0V5MTNNNlNqdVFkQzljanV4Z0crNkNpMjZsY1JJWER0U2p2WHY1dnVy?=
 =?utf-8?B?aDNnSlJBZ1hyR1dmVFlIWDA4b1JSV2htcjRZd3lUcW0vZlN2U0Z6ZFRmTGJK?=
 =?utf-8?B?UGJpMmRpWE1lc1dKbHBLRHVhaXNEeW16czl4U0diQVE5RlNmRmRqcGo5QW96?=
 =?utf-8?B?Tkw5YWYweUl5L3huQURzZFZvWXdpNHRpOXJjRW1TT0R0Q3JiU0dpYnFFNWdo?=
 =?utf-8?B?bUN6ajZQcDFDU1o4ZFJlcUh1TXNNK3dpS1BBa05rR2V6WWNaRW9UR1JoTmds?=
 =?utf-8?B?ekdWdFpESWJmTzBBUnJkMFFZUS9NUU5ia01sRThhdmhRWjJ4bTB0NzgvK1hK?=
 =?utf-8?B?UmUyQlBJREtXM2YvMEFIdk5tN2U1M1JDN2RiK09LTFRqWmxOVkR4eUNvZXgv?=
 =?utf-8?B?anh0cHQzUXg4anRkSWJ6QUl6QndNKzZnZHRpbCtmL3VIanVmdVAyZWJNbUVr?=
 =?utf-8?B?dWxpcDdHamhSNWRWa2lwMVdVTzI0M1p0QW5QTkYyYjdJelVZZWhDQ1VEVGdJ?=
 =?utf-8?Q?29uE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N2YwdUM2czVqam9ITDhOT3NFcUpxZmhBWWl0WjZidDA0TFByMGFDeXpuMnlw?=
 =?utf-8?B?ZXVzVDBxSkpLcW1xZ0xidXlXcWpqU1EyMGxjeDZmV3pEWlRicnkyUVZqVnpR?=
 =?utf-8?B?eTUyRUZIWDBieEdzdzZVWkRKRGdDc3hiYXJqTnhaa0gxZUsvMW45Y2J5U1J2?=
 =?utf-8?B?eFpxdXVKemlRbnlIZHdWK3pPWFlydXIxemxXdmpkUzZBQm1WemRmWWdsVGx1?=
 =?utf-8?B?bzlHTkhJdWZ1aCtNWDBwZ1NFd2REYnlLVXpDdmgxZnQ4VHc2L25IYU5RQmoz?=
 =?utf-8?B?Yk9OVEZMb3RPRG9iQVljZTcxcXRjVFB3eVFxQWhiSWU5UzZ5WVdMQ2dWRTRz?=
 =?utf-8?B?ak5vM1FxUXRCOXhkUkhrdGMzQzdMVnFOR0VZYlJpdG9iUDJPcDU0eHBZTUNB?=
 =?utf-8?B?VElNUFJoaURDa29tenVvRVd6YThMUkoxbXRLSVpta1FxejhjUmRZT21LMEtH?=
 =?utf-8?B?T1RmdG96a3pDUnc3UkViejU2R0Mya05UWWg1ZytPRVFhVkxUamluVEQ4S29J?=
 =?utf-8?B?eUJFMnNCQUhRRHlob1RzbzVGT2hRdVZ6OEhiejl3eXI3QlZPTjQzS3BGU0sv?=
 =?utf-8?B?ajRSbXNDejUwV09MREppZU1RajZtYXBYNmRZWGpuSk9GLzZxUTY2M3BhMTBL?=
 =?utf-8?B?N2I0cDlhUTdpNlpYaDE1YTg1bHpNTU5wQ25MR2NUNXpMM2EwUFpJalZhdUU4?=
 =?utf-8?B?ckxReHRiYmJSMmdSYnVBSmxUdWhqRU5mdHpkQ0NOZk5nenlkU3Y1Z1p6c0c4?=
 =?utf-8?B?RnlERlNIOTBCYXI0SGYyR0x0WEhkbUlTTXRCNXVmT1dPR1RkSlhSKy9DWjBx?=
 =?utf-8?B?RFdSOHZobmNOUG9qU1NXZUd4dGJWR0J6c2dkeFJQRS9xZTlQVU9rQ05TUEE4?=
 =?utf-8?B?UkVpMmhBc01DUnJ0K3lKK3UwNUlFb25aV1BlSVpRNEw5cFVqSERxZXZMYVRP?=
 =?utf-8?B?eXdHNnBhQ09rZ3QybGNtV3QvNklXZ2JCbmFJWHRGeVZuSldEVXpQVEs0cWRW?=
 =?utf-8?B?ZnZIckt2MCtPMFJVanpxakhzaXVTdnBhelNuMnJsd3MxQ2x6UTkrWjNCSDNW?=
 =?utf-8?B?aHdoRW8ySmxoakltcEs1L2RqQmtKWUJyU2M1eGJha2dPWWF5VlVEanMvUjl3?=
 =?utf-8?B?bFlQcThXMlFram1uNnZGWXRicWFHa3VJd3YzM3RMalRCTmVxVUJuMGNLYlhh?=
 =?utf-8?B?cVc1RWRCTkFkWUlHeFdxS0dQSHpROGxINFhsUUNxWWI3alZwQXZzMFdwekpj?=
 =?utf-8?B?VGVWcVNMMzgxdG5SVStkRGlGeEh6RTN0S0J2QWRQYlpKOUNQc2VUM2c0WFNI?=
 =?utf-8?B?R3p3RGVXend1SmZ1U0JQc1B5RFQ5Z0tNYXg3YnNVaHdWZjJ2ZUFGbDFRdUZZ?=
 =?utf-8?B?bTJtcW9EVERxK3pJcEd0ME5xbGZKVnA0UGNkSFNtQkRNUWszZjFhazllL3Fl?=
 =?utf-8?B?aG1wYWFhZVRuTU1RVWpTQXRyNWhLOWlPMDdiSXpOck55TkdTa3BhT0xLdVhR?=
 =?utf-8?B?TnVkL3Bjd2NiM1hDeDJaN056WGE1WGR3bllJWWEvdTdicGdyOHFzYWNmZldO?=
 =?utf-8?B?c3dPbUNpUmtKdzVhazh1MFpJMlMvZnV5N3VRS0k0M2ZBb0s5NVN3U21JMTVs?=
 =?utf-8?B?c2MxZFUvMUUwN2U1dXVYbjRDUENYSHp0Y1ZVYUkvSU94OEswS1BzTG83WEY3?=
 =?utf-8?B?UlNqK0VvdmFmdUlUak5nS0grRENsTDlUQUVBOHU3dlpyTEVMU0FzQWpFbjUz?=
 =?utf-8?B?Y2w5bmNXZ3ZXWXZ4K2piZHRXS1RlM2hJYnJBRlAwWTNsZ0ZEKzFBWFU3dmtr?=
 =?utf-8?B?NWt4aEQyeUI2aVp1c1hlUytuUllyVERKUzZCbGhHSVQ5YyttamliWk9nbkps?=
 =?utf-8?B?ZmVZMGVXRU1GRHlEMkJINm1BZ1V2bmNUeDRkakNsRzNpeDJxSGhWM2lueUlC?=
 =?utf-8?B?R1FYbGxFNlBFM2tKeTM2NGJTT2ZhM005cWJLS2gvbm9DOFhKN0NoRk12d1ZY?=
 =?utf-8?B?dTZHaTVSOXhYVkR4Ty9OWDQrajBYQzFVTzdaeTE0TGJReUpkcjI0YmhFSmtj?=
 =?utf-8?B?MVVSS0RreUtIaDY1Uy9rcWRKeWhqQ05ySGF3SWJyYkx0NDMzWTYrNG1XemVi?=
 =?utf-8?B?VGZqNW5tcWQ1REZDMjgxb05TNnZlRmlWVzhMWlg3MlRueWJtbXNTdXNUOHRT?=
 =?utf-8?B?b2lydVR1cUkzWkRRUmhCc1RTOFRneDhObGZvVHVBaWxhQ2lBMkRyMmlpOU1E?=
 =?utf-8?B?N3IyTDFwRFFkcjZzZi9TWFFSeXQyNHpBVmpCcUNCTWxsZlNvakdKbVNtOUNa?=
 =?utf-8?B?Zm0vNWcxdHVXT1lkdGFpUGp6WDBaTWYrZ0R3ejdXR3IySHhUNVpkQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8c0af2-865e-435c-4e71-08de6acd82d9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 07:00:03.1044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dE/VuhRms32JVWeQVjo7lG5BV9f2nAj3twl884E0+tup0n+LPImXP75tYwIFqDG3ggxwLDAz4euKR50jb5BAPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9076
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Feb 2026 07:00:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21870

On 12.02.26 22:40, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> Aligned defaults for SWU_SIGNED to enforce signing of swu files
> as well as verification in swupdate binary.
> 
> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
> ---
>  classes-recipe/swupdate.bbclass    | 4 ++--
>  recipes-core/swupdate/swupdate.inc | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/classes-recipe/swupdate.bbclass b/classes-recipe/swupdate.bbclass
> index 59dab9f..d92d55f 100644
> --- a/classes-recipe/swupdate.bbclass
> +++ b/classes-recipe/swupdate.bbclass
> @@ -39,6 +39,8 @@ SWU_KERNEL_ARTIFACT_NAME = "${@ '${SWU_DELTA_UPDATE_KERNEL_ARTIFACT}' \
>  SWU_IMAGE_FILE ?= "${IMAGE_FULLNAME}"
>  SWU_DESCRIPTION_FILE ?= "sw-description"
>  SWU_ADDITIONAL_FILES ?= "${SWU_KERNEL_ARTIFACT_NAME} ${SWU_ROOTFS_ARTIFACT_NAME}"
> +
> +# Including swupdate.inc in CIP_IMAGE_OPTIONS enables signing by default.
>  SWU_SIGNED ??= ""
>  SWU_SIGNATURE_EXT ?= "sig"
>  SWU_SIGNATURE_TYPE ?= "cms"
> @@ -52,8 +54,6 @@ IMAGE_TYPEDEP:swu = "${@ '${SWU_DELTA_UPDATE_ARTIFACT_TYPE}' \
>      else '${SWU_UPDATE_ARTIFACT_TYPE}' }"
>  
>  IMAGER_INSTALL:swu += "cpio coreutils"
> -IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> -

Ok, this removal deserves a separate commit and an explanation why we
got here (@Quirin) and why this is safe or even required to drop now.
Introducing commit was 980cd0089ed0b0318977522882c4f9d520f6688e.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

