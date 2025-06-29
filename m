Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E386C7EE30
	for <webhook@archiver.kernel.org>; Sun, 29 Jun 2025 07:25:29 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.38])
 by mx.groups.io with SMTP id smtpd.web11.13442.1751181920659575599
 for <cip-dev@lists.cip-project.org>;
 Sun, 29 Jun 2025 00:25:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=SjrZNVJo;
 spf=pass (domain: siemens.com, ip: 52.101.70.38, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s45tu3T0EmY2NJvxWrPRQmobMOmC5oOZbRoHAT2CjA53QU/INDcxW4hQ/HA8w/QiP/75jL0rvL+vOGlWnEReJkfjf/pOu/OpxdyhxUWptruWuIpP7kFsWBl6HkXhn1b4DPV05O5HK2QO9EDUcUBX06KhKLTaDazig8LQRsSd8CajE3IC8C9CyXmIoTRuZDjSGz4WHApEk16sGnntY1bIvImT8+IqGiaHmBCYpjGwP4Mau3JXJj/u2CdErO1pkQqGx9p3Fn9mN2fkrODlupsd1nsTwKJ9UINXhkROaS/5Qr+EJUslHo1Pp9JBrs2mVzp5f5sqZF+d4wHbrXGifaxESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5esS9VByPbszJwe/c6MSo4AjR35vT9y50Cri4y6hfQ=;
 b=NxvbiPNZnWC3ibi4AVjYemEdkSZgxLPsBWJLitQogVpJtMacHhoBrOzWe+zUx7xZZyuUFx6m1DPYWnnbdT1R+jXllG+arRTsLHjjy8B/BhkixFgVe6GG+VGOgrwr9x+o6mZwNzIJrgt5Y29ajfQJUfKB3CYRSdYgM/zNObTxRH1x+sUpucMBKMf5P/ohyY+Fgc3utoSGsReMNVdo4XIAO3y4znjk488qJ4Y5hVMYtfpGdPRLJ7SA9EUZs5+GvTu4ba5Ab+XOkh/sdZogHnBFDuIxpdQ9kxv0JTAFHkdpFGoKKQ86BWamZkso8nYLpMR50zGyXLwdZfkXeFASjfwREg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5esS9VByPbszJwe/c6MSo4AjR35vT9y50Cri4y6hfQ=;
 b=SjrZNVJofRtXiNqr5D9aDqixkgn666+jFiA4p08wZ6QqokXAHoodJhezp7Aze0m7Gwo5WtosCnPhBmM/cN4FlmxFpMwd/yBiPdUxbHXz5PVfFXGtK3nCiEL+n6Cxn9FrB804vgEDwkB6mj8du/40WpDWpThlkn7NYzE16JH/qj8Duo0ctiTxE7aTJbhPLyLl0i//DhsuwbKmIoK9NStQmMxlQ+AOLxrM5l0R/pNx8NbT4oTykha6TothQb5bFjvGb8QoNqUuy0UXcoK7M3fvtQgkebDkGOPyL70wU0xiZP8wr+vu0w0NeVXoTQEOIEYzJdKQpvullrauB1U3irIXLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6183.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Sun, 29 Jun
 2025 07:25:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8880.021; Sun, 29 Jun 2025
 07:25:16 +0000
Message-ID: <d8a6d28d-4d36-4b98-8142-8629e6c01f58@siemens.com>
Date: Sun, 29 Jun 2025 09:25:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Troubles with isar build for bbb
To: Nikola Trifunovic <nikola@trifunovic.at>, cip-dev@lists.cip-project.org
References: <c8233945-77ac-4a82-8016-f67a79054849@trifunovic.at>
 <61bd7c9a-b18e-44db-ac28-fb10941ed141@siemens.com>
 <90defef6-da71-4669-afd1-a1a5d180b802@trifunovic.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <90defef6-da71-4669-afd1-a1a5d180b802@trifunovic.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0391.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ded70b-2f99-44d1-9922-08ddb6de17f1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MWxlTk5SdzRKQWVHcS9TdFd3cWhOQm0reURrUVVDcmhBR1poT2Q2Q0NyNHhR?=
 =?utf-8?B?SGRpTnVLQ2lOQ1dMNm5Rd29yTWxaN09CZmZlcXdqcUpueXRRQ29Fc3JrZ3lE?=
 =?utf-8?B?d3hmbkpQRlFabkk2aURaWEc0NU9mcHc5VjEyQWE5Q0N3bW4xYlZacXlZMkRt?=
 =?utf-8?B?OW5XaENqM2ZjU1FXVVc3a1RDWkpGSDRBa1JPem1KSzFIMXVsYWFWbEk4N3cz?=
 =?utf-8?B?aWc5N0d2U1gxaHBsMmRkT0ZOZTJJQUV1UGM3cmI1MW45RUgyVTRNSUxQTmFP?=
 =?utf-8?B?eDcrUnlwUHMvbmpCRkZyK1cwQ3dhTFI4TmtXY3NNc1RtdjNyM1Yrd2IxY2Ja?=
 =?utf-8?B?MFBCQ2RzQUd4Z0w3RmUyMCtmMTN6UHlpOHBiWDAzY2pmaDJvRGEydVprczZx?=
 =?utf-8?B?TjFiRXVITVdkWUdVVEZick5aS0VoYTBVd3JsSFIvMzVoZmd5bmdDLzhkQ3d3?=
 =?utf-8?B?ZG5HanI5TUZwSFF2NGorL0Z1ZnRwVktmNTZqMXhuMGkxcmZYTjFNN2dsayt6?=
 =?utf-8?B?RzZrK3pRQzBBcFJwSGM5Y3p6TDVaQ0RSbUd5allFSmtZcnBBNzltTi9VRitk?=
 =?utf-8?B?TDNYOVJEQ0NjS2U4VjNjbU9sREtCMjBScjFzVW5lcVV4NnJ3ZjlRQzlVb1g2?=
 =?utf-8?B?aW16dW1aa1k3SnZ1S0RpK3F3bFZyWnROMGQ3N0FQWVlZcHp4TnhMZnZvbTdR?=
 =?utf-8?B?azlvVGJaTkxGOWY3Y0tmSVR0WWdhcWp2U3E1NzJiL3BaaGJ0NHhTOXRQbUJy?=
 =?utf-8?B?OWxXZjhsUk15ZDk1MEVZZGtQbWw5MjJmNWVBQ2FNNC9JTkRLNlFtWjZrU3Ez?=
 =?utf-8?B?UWJvZFhXcDhMd2loZ0ZyYlg1cVpEeGJJV283NVNXQStveFQyZDZ2VFhNaWlV?=
 =?utf-8?B?Um5NMDFyL25na00rVjNxOUhHdTlMUEMrOXhuU3RBRG1GSDhiV2FORFR4NkYw?=
 =?utf-8?B?OU1VZnVYOXJ3SFJ4TkU2T1RBSkVvU1R5OU9VbXpaSGl4QVYyRHpQaW8zbmgr?=
 =?utf-8?B?Uno1NTkvR2paR2hobnNubVhpZWRkbXgxOWI1L1dOV2xMZGpodFNmTGs0WTBi?=
 =?utf-8?B?RnVMTEJPSkxrRzFLY09GU0xVZzVSZ1oydGJmSDcvbzNwYVVrVDhhcHUxZ0k4?=
 =?utf-8?B?UlRMdTUzdnI2cVRubEQxeE1Cb1hpNnc2NUI5TmVEK29Yem5wM0V4TUN6V2hB?=
 =?utf-8?B?VjViM1JndnI4YkFqV21zVUducmVtY3F3Zk4vTnM1eW53WExoa00vNVNBakp4?=
 =?utf-8?B?MjFNWU9pYjZUREVrU3hUUEtFTzdKVFhSTVdKOWdCaUdIWTJGOGhFTklyWnpP?=
 =?utf-8?B?bUx6dWprNkZNZWZOellwOW41ajhCbS80ODlsSkk4QlY4WUVKcFY1a0k4MGds?=
 =?utf-8?B?YlRVMDhrSGtRZHhNRzd4OHh6UVMraWhOTGQyWlhQQ1hrSHluLy9UemJHdDU1?=
 =?utf-8?B?anRBZ0R6V2JwVk5DYlZ2eGVPblRoaDJZOHNoRlhHQkk5bVRKSXJYWlRYSENU?=
 =?utf-8?B?ZVNiVWRhK3JnYmd5V1FmTStmMXZuaFRYbXlVaEdXVVl1SzVmRFZ0L29PcVlw?=
 =?utf-8?B?aUhFako5M3JNMHg0dzFHS0lTL2I2M0YvVzJOb29WSGVTWUVKdFZ6YmNqeS9p?=
 =?utf-8?B?L1VDd3hUWlZSMFovZExLbkx2cHFMcXRmNTR0ejRubTBiWEZ1UkczV0tDRi9U?=
 =?utf-8?B?SDQwNGQ5YjdQK2pEV2VNNjBOaEFyay8vQXd4SUFNRDVQSkJ4M2dZOEU2Z2to?=
 =?utf-8?B?dHdNdXhzNWtXQXVGNTdvRERPZ2lLalM0VC9CTlQvLytkQlIwK08vVFN0WFBo?=
 =?utf-8?Q?2jjwq7Cd4c0XXQKGSoMD6VU0jV/v2ascDMpY4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QytyN21tS2RIOUN3Q1VqejN1S3NPUG1RRWtxY0ppZEJtTmJTVTJWcUF6Zndy?=
 =?utf-8?B?aGhXS3BNb25wN21iR2p2YUpGeUtnMmRreUVJQ0l4VnllalBjSUxWY2w0dDEy?=
 =?utf-8?B?Q0R3amlxQU1pZEMvaVNtNGNsNGplYkpJSXJ6dVBiN0phMzNjOFQvTzFpa2ZQ?=
 =?utf-8?B?bm1STjdKSWFRZnk0YmM4cnd0VktJdzJuN2xMUGVCaDd3MU4vMUZxQXU5Zmpx?=
 =?utf-8?B?SnN1ZXhURGxvM3FvUGF1T0V5dWJ1aWNsYlArcGwwV214ZWZsMmU3NkpxY2Vs?=
 =?utf-8?B?TlpaOFNWUTFNWW1sbGczZnVrZElnUEdTT0c3djZYYm1CYzhCcWQ2c3hrZi9h?=
 =?utf-8?B?SkEvOWZpdE9ESU5Cdk9WSHVjN0N5cFNUQjJJeVNSS053UUVNaVRTcHVFSjZs?=
 =?utf-8?B?b3JGQUQ4MXBmVWZxemU3RnRtTW9uZXlJT2hwbXV3emdqZ0ZYeVZZZDRSQmI1?=
 =?utf-8?B?cXVwNitOdUNOdHJzczF2UEtwZ2VhRWpHdThlMHV0eTVTVy95NGNndVdOWXdC?=
 =?utf-8?B?bEx1NU1KSm1tMWwwWUxnQzFVZ3VJbmF1OEtpTjFieTNNdW1OZXdxa0RIa241?=
 =?utf-8?B?eHovTzlyVS9uVGhjVExEamZzdGROTWNsa1NRRk53bGlZMTBCVXpuNHdDcS9u?=
 =?utf-8?B?T0UvVXo4QVUvRHNhNkpseFpQN3d3QlVaR2tpMnk0OUFCV2w3R2RxZXo1NjBT?=
 =?utf-8?B?RXpvRzAvUkZFNUIrbW5rOTVPV0lrbmR5c01sa3RrYnd5MlhDWThyZUZGOHRv?=
 =?utf-8?B?NUdZNUk1VUlSbmk2Y3hySS9SOHlqOHFvZURvck5kcFFqa3RNZU13dDcvN2Jp?=
 =?utf-8?B?RUI4TG1sZGZQazBVUDFpN2FicytRTm43UHpwMnIvRlR1amRsRnBjTDgrRGc4?=
 =?utf-8?B?OUppbEdValowaG5oMW9zako5Y0UwZCtzanpwa21GOS9jUm1UYVFlZkhKQk9T?=
 =?utf-8?B?TEJMZ01nUVltWXNNZnh2c083YmlVdS9FZlNFM2VDRTZrY3ZRTmtBVHFMQ3VG?=
 =?utf-8?B?dGR1alBsTExKZ2JGbEV2UUJ4MEFERzQrbVBOT2lGeGV2MDJNenpYbHJ2YW5M?=
 =?utf-8?B?OHhYQUpqTTFUOHI1a3R4YklDaWtkcFhRVkM2cXJiRnpHMVJDNDBDYXVINEcz?=
 =?utf-8?B?aUdURllDWUhuNTNHTGlSTXVIWGFXdzBqT2VNUmNKanA3eHMxd2tRb1Btd3V2?=
 =?utf-8?B?NFZKeUYyMEZvZDhmNk1DU2diS0JtZ2RQKzB5dGhYQmxhbWRINUc3ZldmRjlw?=
 =?utf-8?B?NUMyRS9NaTZFZHZmajlsTkwzL05xSmJHREM4RlA0ajRMeDZOY3gzQ2ZBdFNQ?=
 =?utf-8?B?Z3ZMOXF5UDI4cW5WZnhGUG5RZ3RCYWQ0cktWMUk2eVMxKzVqSmpMVXFUWCtH?=
 =?utf-8?B?MVhkQXZReS9uZHdKempCazNaRkZZbmZOaXlPODhwaWJYdjh0elpYdThIeVVs?=
 =?utf-8?B?Q3c1dDJjRDhvL2NBK2tIc0Z3ODJ6WlQwZWlBbWJHc2c4eG91Q1NIYUZFWTBH?=
 =?utf-8?B?WjRLRmlkbGJFMU5OQk5ydGE3TGRCY2lVblU2RDZiRzZhZlNXdFJnZFE4bHYr?=
 =?utf-8?B?Z1JRbjJka21yY2N3Tzh6ajlXL0JobWUxQUo3NFNlQkdMMlVrUmwzeVhIM2Vt?=
 =?utf-8?B?MWlVZS9OUmd6VEowa3hZK21PZVZNZVkzOUNaeVZYeVhlZFVrZGk4UThOc0xV?=
 =?utf-8?B?bDJGM2VPb1o0eWgzQTd0Uno1Zmx1Nm1JOHY2d1luNG56Y282M1JNeklyME1J?=
 =?utf-8?B?c05DUWtISjMxSCtRcUVQRWFoaE5COFlQY2ZkRzdENnpzaUlCVFZHNitJYmhM?=
 =?utf-8?B?bkhnYnYyaWxrcFhJZ2dpdU5QN0hNR21mTzY2bXV5dWZ6R09ITzNhTlZad0li?=
 =?utf-8?B?Z2tFa3M5eC9jWSt0M3dFSXVLc05JL0R1UkFGZXI5T25hMk9GRGFmbVVPdFhK?=
 =?utf-8?B?b2hTTXhWdDJVK3I4ZmpzVlFEaSszNVFCeVlKWWgwV2xWZldYZnl5NXpmY0RK?=
 =?utf-8?B?WHBaeUthM3lZQk9BMFFPZHFwRDZVcFJrRHY3Z1RSRHBGRFhVTEJrdlAzODhZ?=
 =?utf-8?B?Smg3OGpqWUZlbzR5WkFFaDN4bzhoSmlnRU5nMlZpaml4MGxVWW0wMGI5Y3kr?=
 =?utf-8?Q?oEECNf23SIvwu17AlO5NACuc6?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ded70b-2f99-44d1-9922-08ddb6de17f1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 07:25:15.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUFL6ajopuLZptCOHg5KCALlavJPBpUaQcqfQf56wDO+qThhg1IRKAKXXKCJ53iP7OteeMhyQWj/L/wzMvrYSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6183
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 29 Jun 2025 07:25:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19249

On 28.06.25 23:04, Nikola Trifunovic wrote:
> Hello Jan,
> 
> many thanks for the fix. The following build worked
> 
>   * Kernel 5.10 with Buster
>   * Kernel 6.1 with Buster
>   * Kernel 6.1 with Bookworm

But all of them only worked with the reverting patch below, none with
vanilla isar-cip-core, right?

Jan

> 
> Please find attached the boot log of the last combination.
> 
> Cheers,
> Nikola
> 
> 
> On 22.06.25 20:51, Jan Kiszka via lists.cip-project.org wrote:
>> Hi Nikola,
>>
>> On 20.06.25 23:37, Nikola Trifunovic wrote:
>>> Hello,
>>>
>>> I am having trouble getting my BeagleBone Black to run with the 5.10
>>> kernel and Buster distribution. The boot process ends with an ALERT in
>>> initramfs. I have attached the boot log to this email.
>>> I have tried two different builds, one with and one without the 'Head of
>>> selected CIP kernel branch' option.
>> Can you try without the part-uuid?
>>
>> diff --git a/wic/bbb.wks b/wic/bbb.wks
>> index b46282dd..a797e95f 100644
>> --- a/wic/bbb.wks
>> +++ b/wic/bbb.wks
>> @@ -9,6 +9,6 @@
>>  part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/MLO" --no-table --align 128
>>  part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-table --align 384
>>  
>> -part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 25d57b24-f34d-412e-8c88-28629f23aa0d
>> +part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
>>  
>>  bootloader --append "rootwait console=ttyO0,115200"
>>
>> If that allows to boot, please also check if kernel 6.1 (the latest one 
>> when that change was introduced) is working with --uuid and only our 
>> 5.10 (config) has an issue.
>>
>>> I followed the instructions at https://gitlab.com/cip-project/cip-core/
>>> isar-cip-core, but the only difference is that I do not have a *.img
>>> file. The only file that looks like an image is "cip-core-image-cip-
>>> core-buster-bbb.wic".
>> Outdated README, indeed. Patch sent.
>>
>>> I assume that I am making a mistake or missing some steps.
>> We unfortunately have no CI-driven image testing for the BeagleBone 
>> Black, and that might have allowed some regression to sneak in.
>>
>> Thanks,
>> Jan
>>
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#19158): https://lists.cip-project.org/g/cip-dev/message/19158
>> Mute This Topic: https://lists.cip-project.org/mt/113750203/9398619
>> Group Owner: cip-dev+owner@lists.cip-project.org
>> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [nikola@trifunovic.at]
>> -=-=-=-=-=-=-=-=-=-=-=-
>>
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

