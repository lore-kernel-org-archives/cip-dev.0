Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D07C25B75
	for <webhook@archiver.kernel.org>; Mon,  3 Jun 2024 04:46:44 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.72])
 by mx.groups.io with SMTP id smtpd.web11.75703.1717389998321879699
 for <cip-dev@lists.cip-project.org>;
 Sun, 02 Jun 2024 21:46:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JbMZJNCU;
 spf=pass (domain: siemens.com, ip: 40.107.249.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+NuqawsQWxKIjlr5mtMI88bj77JjIagIliKV+xqJvS6//GXUzWKfMy9ImRNJJ8tqtxdLtrku2q3Y4Zne94arZfkVPLR4RmipwhV5gbCpwapCeF07jmfAmbJMJFC54mF/thTgsqsnU6C8Aw9UW2rd+Nuwaoj6wQS3ZpUQOmviLnF4jRqug1hrzYd9VmIkl8BgthMAXLP66l14nZAROxtVhn8jEXyEjwYreZyaRitos9AktKSSBXckXHIIC9/XkATWepPbbiYUHQfcARrONEBeazW8EHu+kNc8qBPkml1HsZo6ye7BL2GTRBTpQhqHuSBHBW1dJ40MM5b9Vk+YeW9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJhqFP68N8W5Bm0XEv0SblxgJY4jjvsHq1MnZyIRU18=;
 b=OoGmAaj5KBSfQg6eLp3hX5MgNlnktqSXhRPGvR0/DySbrw5n2fug1NmToCvzlUtiyVWa70CXMyCpspoPrK1Q779CkLKrwcxxgBCotxW3umjBJPSzVM1NnQTk27b/fTN2TdfDtKYT4zBbdHDhlm04SXfU03Ra4Y+dlGZVLwS1OF/ixBlWDv+um9JqC6P7wDcNSNi13GEyXg8xebcyVvt+bsC1ARDwubyulnSrayvi6dxuaUAtB7bSBUqKxDwecviGF5K8WlBn2clrBnRQXumiaf80gS5nBUfwzw8Mh93jkWjkv6Zhw1WOZ7vjb86O6WkPeospDYgDYdgUh+JPqxmpFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJhqFP68N8W5Bm0XEv0SblxgJY4jjvsHq1MnZyIRU18=;
 b=JbMZJNCUj9Cu2j5FQ5bEjTBcCRqUeDzOV2pFLwNx89Y6/ZdcymdNglNlPJSJRqdzxWDsvq6faJ2wO2wG1tvE7jfFT4kWDY3YL6rgou+YgkmgC77sN0GEg3Um1D0PcwIRbekwG41qaBaN+9Jow+SmNpE5uTivT+ZkOnkNqBNu0yj3Fa+dUL5xAcyUaKRPtskt7mciptWTpkzYZmFGnZ9p9H1KFRfM7eaEggSv3SxIPvJ19tZxsCpgzkoJsv9HQ57XiDF5JuvJAjybnyT4cGdXX8LfGLpzaeQY0ThNAAgIOFDUB9NRMXT74ODYoE5G7dGg24NzTuGgkKqi3yj/HJG9vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6528.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Mon, 3 Jun
 2024 04:46:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 04:46:35 +0000
Message-ID: <99f545b1-ee28-4a23-be6b-68999d8218c3@siemens.com>
Date: Mon, 3 Jun 2024 06:46:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Siemens targets timing out?
To: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: Chris.Paterson2@renesas.com
References: <ZkTwEKwobEIumswy@duo.ucw.cz>
 <TYWPR01MB11862A1D29648613FB34FD137B7F52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <ZlDjWu5tzsNV4dqE@duo.ucw.cz>
 <OS0PR01MB6388374CDAD1095B2F98A9DD92F32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <ZlhfLfL7fmsHShTx@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ZlhfLfL7fmsHShTx@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7842c0-198e-42e0-f22c-08dc83882592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d2pDcGVYOG5PSUxmaWdhU1dRb2lDUGpjSm04UU9NSUYyZ1hXL1NhZ243L2dC?=
 =?utf-8?B?b3Jvd1NjY2k1VkNZUyt4U3l4VnZ6dkxFQzRXZjQ4OUZLam15ekErRDN0M2tv?=
 =?utf-8?B?NnFnMkJiV1BDai9VMmkvd011WnpjK3dGYnVDWDd1VUVWQzRsM0FKZDB3MTUr?=
 =?utf-8?B?WnJqRE4yd2Jjd2lLVU90dlI1QmRXZUFxN3M2dEhWdjVPeHU0a1RGVW5uUTVy?=
 =?utf-8?B?U2lKVEUvaENvNkFnOWk1cXN3UnB6V0h6a1dRaXNDMlZEUVRPVVN0RUIrZURJ?=
 =?utf-8?B?R1RGWUt4OE53OXpwSElNWWN1RVFsQVRxUFVUUEdUd3lOVU16c1pIVHdSang3?=
 =?utf-8?B?U0xaZ3VxWlh4SWJhMlFya3JtbjhSMFZKK01vYnhML0s3UUQ5QlB3OWRadXRZ?=
 =?utf-8?B?Y3EwcWZTc3A1bnVKMTc1bVdZRFFNSkVpUVZkbDQwMlkwb25qUjdudnZ5L3Z0?=
 =?utf-8?B?bndnVEVMYWVzSlJaS3Q4QXdGTUJUR01BSkZXK3FSVVdUQjhsYjQycExtK0cv?=
 =?utf-8?B?TUoxM25XOVlRVjdGQWladXJkSnVLbzNLNUdJMnN1Nnl2bTZxekxwRWcyQmNN?=
 =?utf-8?B?L3VDbEVURUFIcXpEamZTWGozcmp5b1FJZGpGcEh6RngyS2pVbnYyd29xNSta?=
 =?utf-8?B?REluYVFoV3ZrdzhDUzJqQ2VGQXJYYjArYjhCWDN1Y3lNQWRacHFla3dPcE5Y?=
 =?utf-8?B?MWg2cDAyWm1RaXlyMHBDRkV5U0xnM2VLc1RVbi9HRG9XS2xpdEQ0bGZlUHBH?=
 =?utf-8?B?ZGk4Nlp1dGRiS2psK1ZXZ0dpSHNabHJKN1NLUHRVQlhHSGZ0Nk9UTFZib3dP?=
 =?utf-8?B?UGVaSGQ3NE1jOEhqWTV5ZnNWOTBPSEhNUFRIa2NDZStkTytIWVVHN0NRaVR1?=
 =?utf-8?B?Q2EyeEtHVzVvL1BWWENTZW1XMUtRdnNPT0QvZ0NybzAzN2hNVjA1VWpYMlhL?=
 =?utf-8?B?dnFDcGw4ZHBwenU5S05HcnNSeHhvTHc3a0xoZ29xb0o1TzdaS0hFbU5OQVR5?=
 =?utf-8?B?NWdOckNsTWNZSzFlaU1iMXd6bS8xWCtCZGlXS2JnTjh3dDREK1oySTZ5dGpV?=
 =?utf-8?B?Njd2NzIxVmZEN1NxWnJpdE1MQm90TnBwSlJ3MkpZemlON3FHcmxNMzhTZVMw?=
 =?utf-8?B?ZndLdkdSNE1WZ3NlZ2lyL2pnL0lDdEZmOGRYLzhrMDJtVEUvTm12c2dIQzF4?=
 =?utf-8?B?Uk94NHNWenRWVXlpYTZMa3NmaDVpeGh0RUMybmlWRUVsbjJvTlZlaGIzSmQ3?=
 =?utf-8?B?bU1MYkF6d1hQYmpBZUtIQ0xGellQRHA0VTdFQ0NhMnV4VzMycnA2NmVVbkNT?=
 =?utf-8?B?WExuOHdiWXB5M3pMK1RmMFlQSFZETlMrQVNKU2NUMmxjNlpTZlN2dXNSQkZ2?=
 =?utf-8?B?aUhVS1NJSzEyd0NxOFZWY0FYb1FKa0tqMUxDS3liQTF0cGg1K3BSa01CeCt3?=
 =?utf-8?B?bk5lZUxlNWtPU20rZUtITjZhVTV6RUVMbzVWNEdVVUFPV2FUa3JzUTJQTGNW?=
 =?utf-8?B?ZVpoVGJtSWo5Rkl0YzdSVE5sMlJYeXFLMDJsVkpGZWx4eGdEY1hGcnN6Uk5U?=
 =?utf-8?B?U3hHNXBYN0hYMW54bFJYckozZjgrWVFoT3ZjOGNaSXlRL0pEZEI1bmZ3RFc5?=
 =?utf-8?Q?y1+jfAycQWRiPawsOxyitDtoJCadzdwf5aSDM0Aaz9Po=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TTJza0J1L0RqaWVvYk4zTHA4L1UycFNoTGsvNERaR1gxYnFQNjVmaUUwQVd0?=
 =?utf-8?B?QmIreDBhWTVJN24xdUpESmNPYVBMSGRYWEFMWlhaQjY4VkZXOWNVTVRCVUNZ?=
 =?utf-8?B?Z3N0dWhIMUlRVERnWXlDZW5ucGxjdk13R1lRaDFUTDFOOCtuTFM0NGdlV21Q?=
 =?utf-8?B?TmI4SFRYMUdpQVpJQk1vRWlxWkRUTEpwMWRoMXNkR2dGVGtnYjZQMmJ3clBB?=
 =?utf-8?B?RVRaZlM1OFJrTHJ3RVdKYXhNY3NtTUpScXdzbG4xREtad1NZNEw0UE1ybUpD?=
 =?utf-8?B?Z2NnYkJtbTJnSWlwcktPajZDVTVSS2FsaSsybjY0TkNXVmdCR0RPYVdBM1pD?=
 =?utf-8?B?ay92Q28zZ213U09RT3o4NnNxK1daRFZCT1RZeUJZZUxQQW84dWIzZnhmUzJK?=
 =?utf-8?B?M3NBT3E4RWN3STRHRCthcG1Gc2l4UE9hUVYxU3piUFVDSEVFRVVES0F6TytB?=
 =?utf-8?B?eUdCYnNjdnYzK25WSmQxYkRwODAycXRIcjFMQTdpOEw2VjlISEU4eHFtR2dj?=
 =?utf-8?B?NnpWL2dWMzBzdm1sSFR1TS9TQVgzMXN1RGhvclhBWWg0V0podHo5K0djRVlS?=
 =?utf-8?B?bDI1c0pTNkVCYzhiSCtQOGpuakRGeTR2YVVsb1F0S05LZG0wanRmS2VaaStI?=
 =?utf-8?B?TlZTN0cxRHJpMnRMang4TjlBR1F4bVU2WHpHcXFuN3RJOGRBa254b2FGL0hF?=
 =?utf-8?B?WlkzOXlOZE9PSFRpSVNMZGpWQVBQRVV6VzhMK0lpdUhmeGttNG9XWmxTQkpX?=
 =?utf-8?B?Zk1GMEM1bm5wUHREb2FjR2FUYWdGZ2RZMjhlbmloZDd2ZitLUk5QcVNGeGhC?=
 =?utf-8?B?cVRLQnllQ1Mrb2lrc2tYMnR4WXBuMG1qMW5HNFRKQk9STDAzcTRhVDRxOE9T?=
 =?utf-8?B?NTlwUHQ0MTRFYk51QVdnRkgrRVk5TnE3YVFzaElaVmZSYnpBTUZQblhmQUUz?=
 =?utf-8?B?dG53WW9xNWVnSmppdE1RNEhScGE4bmpWeFM0RlBackZxODlta3Q0ZmJ2eWNm?=
 =?utf-8?B?amxmdWZYTEVlZWtNa1FIbFlkS3ozR2VEVnNwWW5hbkRGak1SQks3Zk1hNnla?=
 =?utf-8?B?cnNNY3QzaGxtTFdiaWl4OWo2Yjh6RERucG1sWk9Yckl4L2ZXOVIyOUV1UmxI?=
 =?utf-8?B?emlob2VxOFFsZE9sMmhqTHNWaWE1bzBTbHc4R0lpdmVqZ2o0VTNOTW9lQnVv?=
 =?utf-8?B?Unh2MnNYcW1rMGxVbEZQOVZPeGRhZG1YcHZFY0VEUml0VFc1RlFVOEpYa1Y0?=
 =?utf-8?B?UC9yT3pHN1BLcVM0cG9PWVZML2dpTTNvMFRXU3o3U2ZZZHA5T1l0VU9tMk91?=
 =?utf-8?B?cFN4bzd0TFk1T3IzZXZycmpHbFRMQ0hVakV3azFmdnoxR3M5a1RNMnBoZjJy?=
 =?utf-8?B?R1pmQ2NWTXBaQ3Jqa2FuRDJYZVI2U2d2UnlOZy9XcUFsZUpmbStBUVo3YndC?=
 =?utf-8?B?VnRlN0dFUGZ5TW80TTVwTjFyT05yeDZTV2dUWis2dnhoWXhtY3NKWXpqU1Fi?=
 =?utf-8?B?QXZGbzM1TlFXNUJvYnNrMVV1VTNtVzdwTHZrUkMrMnozK2svZFdOQTUvRjRE?=
 =?utf-8?B?amFrRmRsdmpyb01KNFduUk53SmtVYWNtZkxXTll6OCtJYjA2R0FiR1BWNkc3?=
 =?utf-8?B?RUNjUk9ab25EWmRuVzJXRmxQN1NvOG1yQXpMNzFiWWxnOE95dDQ5MjFZYmx6?=
 =?utf-8?B?bmNMOTJSVXZZY2FFL01TZ2w4VXhFSkRnY01VeHgyeDNkVjJwSFNCQm1VWGc4?=
 =?utf-8?B?TWtyMFVzbjRMTXFFRUphL0MvRmR1dDEwUGc4UjlxZWZSY1hmUWRoV0RJSGdq?=
 =?utf-8?B?WTBkTW02aXorZkZBQktYN1g3ZzRUbDNubC91QytOSnJJWEpDVFVubHFrdE45?=
 =?utf-8?B?MGgxVnhMZmQ2Y25yeFh4UWlYUkdra1UzeG8zMVBtN3IwUXdWa09DMWpKNUY1?=
 =?utf-8?B?RzliZ3krcURzaWpTcWduQjJnamlRRFM2ZE1BRng2dVFxeEFHSE1KRE9neDl3?=
 =?utf-8?B?dVhvZnEzM2VYNnd0Q2h3ckZYTUpRU0Jnb05SZnpuSHczc1RucU9RamZabGxn?=
 =?utf-8?B?NVdWUUcxNlozKzlDYWhTNGxQQllmSXlsMHdjbE81b09BdUsvTkFva3ZGVVNs?=
 =?utf-8?Q?OkFsOCxXvQasxFXlvwJM/+4g7?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7842c0-198e-42e0-f22c-08dc83882592
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 04:46:34.9827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +czuYV78EeoWORT7dnfuj/4vRvKM866oj86a0GL+AfrimkpGFv8Lg9k3v68LVqSnrOPriQskitIpYmLPeo0Vww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6528
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jun 2024 04:46:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16080

On 30.05.24 13:12, Pavel Machek wrote:
> Hi!
> 
> I'm trying to test Renesas Ethernet changes, but Siemens targets cause
> timeouts. Can anyone take a look?
> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1310801626
> 

I thought our lab was still offline (internal IT...) and only about to
be relaunched. Quirin?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


