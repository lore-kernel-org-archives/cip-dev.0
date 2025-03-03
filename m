Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0219C282C5
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 08:01:53 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.46])
 by mx.groups.io with SMTP id smtpd.web10.48585.1740988905613519978
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Mar 2025 00:01:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=SwlAiAaO;
 spf=pass (domain: siemens.com, ip: 40.107.22.46, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzlWaxWx19CYtIBs3GIpyMiloJdE+JxQPVxScr19eurzkrE3Kt2K/2A8wdjC0bPQ/tYPCHQMpO9eIYALa7RbIRs+p2xrwNyQIVDu0VJAEIHYRTcyY+b3b7N7TanIJFJhJq8UgDTvJcmXA7jto0uINCAGaU+kNh44rcd/oD6tLulM6O5P3PIGZ3v09KtEb6grVSyf9+bUXSvOi/O2SQeCEkh/GyKQkw81OkTJP9IGEnnN3oqokOY1V1q0JQbqqhyJpPwUEpyu7KHazfsogc+RiIb8GrRyWfF2PkhK9TggwjCfO16KeIYlYpBaFrhedy941EuBWMUg2KbXGUFDGu6/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP6dhO32CC3hYJEJNQ3rBuwY/Mrhdk0+NCZi5F3Q31g=;
 b=Nkmcnrn3fLsAqzTxNPCgngz8xm+JmIFHsseY4R2Mq3P2MIl5ma/nsWFqOBoX+S3mCbgD1Hf80ZDVWbXSfnYh/s83KMuu+T2q+1YlQY/T8VjXj/2xPBAQxmNuAmFvV0tqVQ3+7KJTudWr82Dc+/aKwHmFjbHgPeLXQQy1ocBDMhHgZGMF5EpTV1xnUedGWikoryCCtvVObXUnjsWPbHCgeY4CwbJjA3Wz2dNa7vJ8+fs+LFoRAvcbOV6YJY2gOJVWJfZaMPsGeZdQc+vR0O6hlLzHFQvLcFQBsmpuLCnnR+o86JHUFHMGc2oHNYntc+BCBjqKH4XEUYlUe3ymQ8n8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP6dhO32CC3hYJEJNQ3rBuwY/Mrhdk0+NCZi5F3Q31g=;
 b=SwlAiAaOYhTrFsCmEYQr3bYkC88RBSksyl5el7K3Fut+J3W3zrudlIivPrMXGpV7F37jIrT8q6gyeErfRGh3N99BRI8bnDcVSrR3XWhu+1NKEifNGIgrv74g/+YVPlCoKUw3lOQrP5CwJAKYDmB3PULeb3+xugzlwcYZDsXmvOWChVnMiANtQMwN99UVMVxsuuwgVkNLl+p09IA8LoCWYdH0EYddqAkalppjOtjRLJvqQOugEGKXQ/U1gZnvNUVkaJw94EVaGN4O0B2g0OvJqMfwN15zytsutGSxrCOMlXvT4HUVIdBr0jR3STLvOEDDKJk2N4+9dbmj2ZjZsBvwVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI1PR10MB7855.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 08:01:42 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 08:01:42 +0000
Message-ID: <05fd7241-962f-4ce9-8657-b9e3bbd6633c@siemens.com>
Date: Mon, 3 Mar 2025 09:01:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3] initramfs-crypt-hook: Optimize disk
 encryption in combination with expansion of last partition
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Kiszka, Jan (FT RPD CED)" <jan.kiszka@siemens.com>,
 "Kowalsky, Clara (FT RPD CED OES-DE)" <clara.kowalsky@siemens.com>
References: <20250226232812.374892-1-alexander.heinisch@siemens.com>
 <ab056b18-b274-4e42-8d68-9eff0d1dccf7@siemens.com>
 <AM7PR10MB332086987071787C6ED4365286CC2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <AM7PR10MB332086987071787C6ED4365286CC2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::17) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI1PR10MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: dee1bccd-577c-4180-8d65-08dd5a29a23d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OC9SZ3krV21wUC9SVG8wTGdVNmlaMDY5bVV5M0tPTi9lOEwvOHc2YlJDMmw3?=
 =?utf-8?B?N01UQjhWRUFUMW8xMGVyWCtPVENSOWdjeEpZMGxaZllKd0tVK1JaMkVzL05X?=
 =?utf-8?B?YVNwejJ3RkUxS3VFZkJqa2cyOW5TbXBDOEdJSzRvMjF5WlVPNVE5Rng4SFNH?=
 =?utf-8?B?K2ppcnJTY1dsYkloYlhka0dmZldKTHZIb1FzY0tYeHJFVHZEK2xPdzh1K0ll?=
 =?utf-8?B?cjZmeXhkSjhVVFJzWXVhMTRZRWVxT3ZCbkhJUjVUZXVkTGEzYnZCMkQrd0RG?=
 =?utf-8?B?eVFISTBoY3B0M3FLOU9uMld1eHp6Y1g0VXlEa2NMaDhVN2dFL3VmdU9xbmcz?=
 =?utf-8?B?cjEydHMwNVU4dGRaNjZZVjBMYyt3MENmRXI3Z0pOVjZMczViRFA4K093cXpX?=
 =?utf-8?B?WlY4MGRmeHhiamlVSzQvbG8yM2Y0QU5yWjdqRnRSVFFsVEtpV1Q5Mi9lemMw?=
 =?utf-8?B?b3NQZXpYSEovWGkxanVOVEcrc1k1SWtYYzBUZ28wNXVXK2pJSGVwalNadzRr?=
 =?utf-8?B?bFYrMTBZMFhLeEduWW05Q2lOZzJVVzN5SEhMVGgwV2lNQzBpKzlqVXlVT0o0?=
 =?utf-8?B?M1ZCVXkydXlGd2oxN28yMmZYbmlVODB2VWJhVnZJYWQ3bE1qeTNTYXJuRnNN?=
 =?utf-8?B?SnBleHFyM3lVRXhWQStyR253dEd4RUJ6VTAzN2cyL0d0bndPeU1veU53em5Y?=
 =?utf-8?B?Z2N2SndvangwV0I3MnQyNTlmb1JwWGVuK0I1a3NzMzRwSmQ5WnIrNCt4b2Z5?=
 =?utf-8?B?YkNnNVlCVEx3cDd6aTFDYWRIUXJDYUdadWRaaW1xcWpXRTZUamlDbTB6Sm9B?=
 =?utf-8?B?NmpVY2xoOUVpdjRiVE1uMDBOTnF4Z1IzK0UwWEdQcm9TM1NoNVVVSWJTU1Rz?=
 =?utf-8?B?ditON3A4VjRiejdYL05KQ0YxZmdJbjNDaEFRdjlITFd3UC8zdDNwUWdiR2lp?=
 =?utf-8?B?UTVXbktoSitmcVhBemJMSndQTjdLeVA3RXBNcGFvKzlLV0Zsc0Y0N0diSGN3?=
 =?utf-8?B?V3lEMnZJSElFYXZkei8xcFV1YnI3ODlZeVcyY09NNmM1N3lHdzV3cW5HeVNG?=
 =?utf-8?B?WXpybmVldWFqakpKcUs3bjV1ZFB2SFVHUnBkWGR1SHYvNzNsZ1A4ODFXZ3Nr?=
 =?utf-8?B?NEtiaVl6WkhYR0l1ZkdobDhRYnZPR2tHempscXJEUlRpUTc0Rng3cCtkMHRN?=
 =?utf-8?B?cjRVSVNCNVZWRHpmOTFWOGN4Y2lKQW1CR1cvQXFKc2wrSFBRUDh1Y1RNeHRu?=
 =?utf-8?B?UmRUdEx1NmtkZVpEZkRGaHYzTFJ1a21PT2hLY2V3eCtlUktLdVQyTFlvSzRS?=
 =?utf-8?B?b0lGbHBYQWRMdXJkOGh5bjUzT2tMTU5qZ0ZjdmdZUlY5d0l5YWl4ZzZWdW5j?=
 =?utf-8?B?MUxXdUFWOEM1YldCVFN5dnJlV1RzN2RCSS9GN0Jhanl1NGZlV1I0dk9acGVo?=
 =?utf-8?B?MVlEYjMrZzVRa1ZXU1pzNXJUL1hkb1pCOFY1eGR0cHBpcEhCZUk2Rm9SNUdy?=
 =?utf-8?B?L3U4YWQ4czBLeThvQjRoYmZIRUp1QmRWSW5GeGNxN2JOdFBpb0xadGhmUjdL?=
 =?utf-8?B?cEdUeU5rZXpBalpTQm55ZWlzZURlSURkYUk0ZXRJUDJlTDIxa3lCUmRiWVNR?=
 =?utf-8?B?YTlQRTZEc2ZFckRZWTBMWVVmcjNLd1YzOHUyS0xRcHR5akl4V0Flbld6OFdw?=
 =?utf-8?B?U2ovelA4UlRNNmp2OGxrQjZIUEk2VkY4Q2tyc0tjS21kK0NwRGpaaE1xd200?=
 =?utf-8?B?Y1NZWDJKOTVBbEU4aGVkdjg1ZDVZUzNNTDVxUnZRdU9NelBGTzZ3d2VnNjRQ?=
 =?utf-8?B?YVROTyszbVVvcys1YmE3SmJwOHFDOTZnc01UeDFzWlROOW9rNDlIQUN2bDVD?=
 =?utf-8?Q?lY5pvWfEDLNzX?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RmQxc1daNDcwcyt5Q1g4S1NaOXV0VFlBc1h1SmF3aU54MkRJY0JqenVmanBm?=
 =?utf-8?B?ZklrckFacEJ4M2xHWXhqZ3hqYzBPZEdDd2QyTTlwdGFPQm1KakZjTDR3a09F?=
 =?utf-8?B?VUkybW1BZGVZMGFDQ1RWUHFXYjNmc09oYXRnZE94TlJocHpMbDBvd1FUcElF?=
 =?utf-8?B?WnJRcUtNbFZkNGNPMFRIaTh1cWxLT2EzaDhaNXgvMUZ3KzdoalluZ1lPL2F4?=
 =?utf-8?B?SldlV1o2MU95Zzc2a0tVeVRFVVVyaG5CWk8zSTJ4aDgzTjZjS213M3VIdVQ4?=
 =?utf-8?B?VEVYc05RYUtRenF2a0dNMGFodk9TbFlzM05RR041a0tJd1luV2k5VC9Pd3ZW?=
 =?utf-8?B?ZUFKK1NOOW1FK3c2S1p6N3g5aEVuWjVNUGhGMHlWOFZUYUdPMWEzV0p3czNo?=
 =?utf-8?B?V1c5T1EyZWlXL2NEaXF2RXovdzV4VFgzbFJnNzBQdVRyc2F0clpQZkFmekpH?=
 =?utf-8?B?a3pxUEhkemlLRWVjTU5hbVBGVjQyT01PRkdydmsvTGM4akRNYU16bjRuSzhS?=
 =?utf-8?B?KytqOVp0QkkyRFBtOTlwSm5PcStacWVkWEtTanNmZlh2S3l0U1NmRWdoR3px?=
 =?utf-8?B?RlNKZEYrZXFUcjZwT1BhUnVnVXB4RXlLVFNzKzFheE1PZEtwd1Q4MlM4NXlm?=
 =?utf-8?B?dkhiWEw0YVdYR2trakNuMU0xZmZVVzhBQ1BhQlo5Y1B3RG5pTDhpMFVSS1pa?=
 =?utf-8?B?eS9iY05lVGd0WWZyNzluUFUwR0RmTkdIVTNhRjZLNVc5MHZVcVJCV0R1Njcx?=
 =?utf-8?B?YmhJYVNSeEhIam1IdVBnMjUwN3JqdW9mdjNFVVNWMjNEU05qYXU3b21jVEx4?=
 =?utf-8?B?djRLWnJOZ3IrNDVFRWNUVzJMRENrWUEzeURVVnVLcFJ5THkyS0h5NTRiRGZL?=
 =?utf-8?B?S2V4YWlIeHZyc2x0UXM2UVJOdktqeEZJaUVQWFY5ekgvdnV6WXl4czVBSmJq?=
 =?utf-8?B?dFFuRmRlRGw0U2w0U200TTg4SUl2QUFCaVc2MzZzYU4xZUV0VXVCMEZjRG5W?=
 =?utf-8?B?aFdNZTFVSithOTkybTRMcXRVMmIwdU5oNDE2Tm5YTGdra2tLOXRxZGZzeHZP?=
 =?utf-8?B?b2N1dXUvcU9yYnA2MDlZajVBMEtOc1hxekgxY09jWGQ3UkJSTzBlR3ZUaTJ4?=
 =?utf-8?B?NWlaZTJSYy9UdzBuamFjMWI0cEdyMWZwb2dkOTFlb3J3bGRWSnd0YkdsSERI?=
 =?utf-8?B?LytMRFNnS1BRb3AyWlNjclI0RFBxSGx2N0JVSWF2YnVlREw3bVhQdzRPWStX?=
 =?utf-8?B?SFJYT3ZZUWJEcWs0SXdSOCs0T1BuQnlSSWtjdjExZFJyYlRIVndaSFQwRnpy?=
 =?utf-8?B?MHdRdXd2eTVDZDYvTHpIVlNEQ0J0bEtUelNSUENCQWROZXkxQ0RlRThWeFRW?=
 =?utf-8?B?WGpESFpycHZ5aVVOMDhKdWZiYWNUQkRuV01Nb1pwdW4zU1NRei82OFI4NjZq?=
 =?utf-8?B?OGxjS2ZXa1NScjRKVm9Xa3RUa0FXZFlDbkNkanZtSHpMemtINGVIWFBXVjQy?=
 =?utf-8?B?d3F4MjZzSkQ1MnZsVUNMbkxjUGxjVllodlBCTy9BQVBGVWJ4UklmK2JzL3ZJ?=
 =?utf-8?B?WkxNMzgvSkN3eG1yOU9uWGF0N0ZLZmlmOGovTEliRTdBMlhGSUtWUCtIWGRO?=
 =?utf-8?B?cW85bWlmNkdPRkdIMzViQ29MQnk4YmVYb2dYMmtiV1oyK1UyVzRPWGNDVTNG?=
 =?utf-8?B?aXpta2gzWEtSVTMrdUVRb29Gd1NidmF4VlVBcGJSVGNJZ21rYk5VOFk1cTRa?=
 =?utf-8?B?SzZjeE1iUU92dlBBZ09id1RPWjZHajl0UnIvWklQdHV4cHpTOUZkZi9oNmtF?=
 =?utf-8?B?c1hDQmxJMzdXcVVPMDd4NFBTQ3RUU1RhQnFOYlgvWllNSVhWZ0IwZGVlRlJt?=
 =?utf-8?B?czBJQUZMV1doVWdBcjY1WWVDbkJKeDMrUThVTWdhZ2dwSzg5NE9LOStMZitx?=
 =?utf-8?B?VWdFQnRMaEo0OUhKSW8yN1hFMkJpTjV3ZkhSRjZtbzNMVVpudTI5dU9EZWdq?=
 =?utf-8?B?NDRJeEx3UjVFc3E5aGFJV3NsZHZHLzc0SmR4RlpDSFFjKzduOE9FVXZDS0Jj?=
 =?utf-8?B?ZUhlMng5OStKSWs0UHR2MHJGOWhEekVZa0tqVmRUcTZvVE8yVmlHWnpndDBX?=
 =?utf-8?B?S1lZM1dUenUvWUlTbnF1RkQ2ODQ1dC9EOTBTNkpwcGM3K0MzdVJVUFRhWHlz?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee1bccd-577c-4180-8d65-08dd5a29a23d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 08:01:42.0667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoDCKkSUGbuDiDUbWWwAWjyPmsKQ56t+7+1Ip4XpUKNqbzADKpXpGg5MpuPIEHMZWwz25dZP966wZn/cjEMNtyn6jt4hjXCx6hNxBWSWAf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7855
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Mar 2025 08:01:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17994



On 2/28/25 13:15, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>> On 2/27/25 00:28, alexander.heinisch@siemens.com wrote:
>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>
>>> In the current implementation (since: 284175c3) disk expansion logic
>>> is done before the actual disk encryption.
>>>
>>> This results in reencrypting the full expanded size of the disk,
>>> instead of only reencrypting the sections containing the actual data.
>>> This results in a drastic increase of time (approx 20x on our systems ) needed for reencryption!
>>>
>>> Since relevant disk contents are only available in the sections of the
>>> disk available before the expansion, it is sufficient to reencrypt them only.
>>>
>>> This patch changes order of encryption and disk expansion resulting in
>>> faster encryption (since only the necessary parts are encrypted).
>>> The resize operation does not reencrypt the added disk parts but just
>>> extends the LUKS container (cryptsetup resize) to reflect the maximum
>>> available disk space.
>>>
>>> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
>>> ---
>>>
>>> Changes v3:
>>> - Provide key to cryptsetup resize for clevis based setups.
>>> - removed export of EXT2FS_NO_MTAB_OK=1
>> Why? is it not necessary?
> 
> The implementation of `e2fsprog` used first reads `/proc/mounts` and only reads `/etc/mtab` if that fails.
> 
> Thus, `EXT2FS_NO_MTAB_OK` only has effect if either the file `/proc/mounts` or in addition to that `/etc/mtab` do not exist.
> 
> The file `proc/mounts` and`/etc/mtab` exists on all supported distros.
> 
> Thus, imo, `EXT2FS_NO_MTAB_OK=1` has no effect in our setup.
> 

Can we removed  `EXT2FS_NO_MTAB_OK=1` also from the ISAR upstream recipe?

Quirin
> But, even if it had some impact, the hook would have failed already
> at `resizefs` during the actual crypt setup in `reencrypt_existing_partition()`.
> 
> BR Alexander
> 
>> Quirin
>>> - Added support to expand partitions with btrfs
>>>
>>> Changes v2:
>>> - Reuse get_fstype from mkinitramfs scripts/functions.
>>>     Therefore, we could also get rid of mounting the partition
>>> - Dropped support for btrfs (compared to v1) since crypt hook
>>>     does not support btrfs anyways
>>>
>>>    .../files/local-top-complete                  | 37 +++++++++++++++++--
>>>    1 file changed, 33 insertions(+), 4 deletions(-)
>>>
>>> diff --git
>>> a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> index 5ef7ca4..fac6db6 100644
>>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> @@ -102,6 +102,8 @@ reencrypt_existing_partition() {
>>>    }
>>>    
>>>    expand_partition() {
>>> +	key_file="$2"
>>> +
>>>    	boot_device="$(echo "${part_device}" | sed 's/p\?[0-9]*$//')"
>>>    	last_part="$(sfdisk -d "${boot_device}" 2>/dev/null | \
>>>    		     tail -1 | cut -d ' ' -f 1)"
>>> @@ -155,6 +157,33 @@ expand_partition() {
>>>    	# Inform the kernel about the partitioning change
>>>    	partx -u "${last_part}"
>>>    
>>> +	last_part_device_name=${last_part#\/dev/}
>>> +
>>> +	mapping_name=$(cat /sys/class/block/"$last_part_device_name"/holders/*/dm/name)
>>> +	# systemd based systems do not need to have the
>>> +	# key_file provided since systemd backend for
>>> +	# cryptsetup resolves the passphrase directly
>>> +	cat $key_file | cryptsetup resize "$mapping_name"
>>> +
>>> +	last_part_mapped=/dev/mapper/"$mapping_name"
>>> +	fs_type=$(get_fstype ${last_part_mapped})
>>> +
>>> +	case ${fs_type} in
>>> +	ext*)
>>> +		resize2fs "${last_part_mapped}"
>>> +		;;
>>> +	btrfs)
>>> +		mkdir /.mnt-tmp
>>> +		mount -t btrfs "${last_part_mapped}" /.mnt-tmp
>>> +		btrfs filesystem resize max /.mnt-tmp
>>> +		umount /.mnt-tmp
>>> +		rmdir /.mnt-tmp
>>> +		;;
>>> +	*)
>>> +		log_warning_msg "Unrecognized filesystem type ${fs_type} - no resize performed"
>>> +		;;
>>> +	esac
>>> +
>>>    	log_end_msg
>>>    }
>>>    
>>> @@ -217,10 +246,6 @@ for partition_set in $partition_sets; do
>>>    		echo "ROOT=$decrypted_part" >/conf/param.conf
>>>    	fi
>>>    
>>> -	if [ "$partition_expand" = "expand" ]; then
>>> -		expand_partition $part_device
>>> -	fi
>>> -
>>>    	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
>>>    			| grep -q "luks2"; then
>>>    		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
>>> @@ -260,6 +285,10 @@ for partition_set in $partition_sets; do
>>>    		 ;;
>>>    	esac
>>>    
>>> +	if [ "$partition_expand" = "expand" ]; then
>>> +		expand_partition $part_device $tmp_key
>>> +	fi
>>> +
>>>    	finalize_tpm2_encryption "$part_device"
>>>    done
>>>    
> 


