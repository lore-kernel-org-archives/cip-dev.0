Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4A5C2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 09:31:51 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.85])
 by mx.groups.io with SMTP id smtpd.web11.3956.1720776702834913388
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 02:31:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VALV3d8b;
 spf=pass (domain: siemens.com, ip: 40.107.241.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sp84Hoz1Kfa4KhbuzMllX1x1x/AOsv+WRCig5cAEx/UrWQ6MjVArWICXgnU3A01Ejl1+ulAUH4DaIu6Z/jcSFB5mk1JqoqO+/JJqlDYU7EAd9NWPdSAXnF4KrmCXzXYwvTMlJR8xXcpQbn+I00OtkIC+R6v6dn/rLY7rmDb9lbw/1GRC6l/AHgNHQHFrovLa8YJmO8uWUcBvt9bHFmWNKGSmx2IvMl9gXgZWpnKMsmgzWL4jrAr/o9J8lyDz+OoGd48F2P91putqzv6VHALAc/1sYg/j5lDA0GDfNrhucimWiwQgp0U/d7Af8uz+1GrQYxEh8J4b9dZzxDrQP6WQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6O1U2DXalRvLcxqZQZsxrMjfpBaa9dDoj25EmgxZrj8=;
 b=A6q//cKN6CYA41za4XbR+mCEc9rCbuv9QfQaJ7gjMUSpe7kyiv48+8KdKdZFV+MlAw2UMM5fC6GMhKAgm8ChC3V9pRJ/jpoB5Ed3zTlN0SpSMmgqEa17a2UKh0sJAVD7GAyFOieDAYBF+NrTlUzJw9Xzn9THw+KL7ZA6l7R/FZsGP4ZkVPk+2cke/QxjJTzreM+0vTFaDwxYZoHpw+NsDEsNXWSpDRP9v/eOAr9pftG8yThk3OhWnyPKse9V074mU6E74ErweVdefKXHzBcZCQh7GOxW55Ml+LzBE++NbbuG8iI19iiMf58dnVbpEo4TGFn7UhKIQliVFgNCZ3rYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6O1U2DXalRvLcxqZQZsxrMjfpBaa9dDoj25EmgxZrj8=;
 b=VALV3d8bhsJN6ZBZSWj2fdVvuCy092E9vUmGgyhCSvNN2cCFl1fi5yn18/LiuvU5fwTjCmBTbCHqTVQ8Q8C7b1HU75WIhlM7MoNBnUfVNfUtqbIpajZRJiSBj/EluZrJrubZ0mRQTe/WPkYMWRqdAbxkCZL4AIA7QGcuvIiQmU9yqqj56Jm7bR5Hfk7r3RTatSZbM9ndSdli7x4vFXorV/5wl5Vr6u9cSyWpLnMTSAcivwu4JFXfX7wnkCAPG7XIMUg5AifDtDDw3ySTkOUVinOx4viC3Xs42Mhnwdx6NquMeyZPSJoGCoQNeMO8fcshIRGAwEv1BxNRKYFNHupHug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV1PR10MB6561.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:81::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Fri, 12 Jul
 2024 09:31:39 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 09:31:39 +0000
Message-ID: <4211a5be-1684-401a-804d-7d6449e923a0@siemens.com>
Date: Fri, 12 Jul 2024 11:31:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] initramfs-crypt-hook: Provide full losetup executable
To: Stefan Koch <stefan-koch@siemens.com>, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, christian.storm@siemens.com,
 michael.adler@siemens.com, simon.sudler@siemens.com
References: <20240712081143.1376952-1-stefan-koch@siemens.com>
 <20240712081143.1376952-3-stefan-koch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240712081143.1376952-3-stefan-koch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0303.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::16) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV1PR10MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 7583f0e7-db1a-4467-de61-08dca2556ebf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MFllYXlWSitNaFR3RkNVYnRaK1N0bUhJVVU5TlFaL0ljMVNkV2JGalJPQVFa?=
 =?utf-8?B?NG9NaU9Yc21KWGM1bDRJNDJERnFtbjFGUWZsdWZEOVR6R2E4TzZHYUNMV0N0?=
 =?utf-8?B?clBuc1Jnb1RtMkU4YVZzK3hlU25iVnpINWJXRHp5MXUwU0hxZEdxaG5iVVpG?=
 =?utf-8?B?Rm1EaEVBMkV1aWsyVzNlM0g0bDBHYTQxUFZzSXlkWnFVekg3RjQrampWMkZa?=
 =?utf-8?B?c2xJNGY4SDRwbk9xbTB0WmhEaHdrSm9rTkZOcnFHcXAzbitweVVZV2FWd0ly?=
 =?utf-8?B?OWNadm5nMEM4MkFOVGIxVmV1ZnhpakZrOUt2cXNiZUZNT2dRL3Z2UVh6dktk?=
 =?utf-8?B?LzBFczJmL1JMM2VUdVNtVVo5QjBUcXFEa0tWdFRmMjJoUHhUalVCVFlDM2F0?=
 =?utf-8?B?SzUxWjBGYVNqY2swTUxka3RmN1pyandrM0ZEeGVTUFk5ckJaUDNEdk1PcVpN?=
 =?utf-8?B?akVnTWxNZmQwcURIbDFvUG1saFI2enh2Q0k2R2dlYU91WGFmRnl1Y0ZzWVI3?=
 =?utf-8?B?bTZBNG5rTkdwcHlqOVRnT01md0hDZXZaS0ZSSWlZOTZiUjhWODgwcHdTWW1i?=
 =?utf-8?B?YlF1eStwQ2RBdG5RbkoyejVPcUJxcGJuWW1mZzFSSG5Ja2hGNWlGQWpJUHJI?=
 =?utf-8?B?bFV2UUpyMG9peHF3dm9VbFQ4cFptMDBWWENnRlVwVlJkV1MvOWVrNnRpNHdW?=
 =?utf-8?B?b0FxQUdLcldGT3BUUWV1WEhFY0pLckFnSURlVGR4bzNDTFlyRDhWVWRkY2ov?=
 =?utf-8?B?OStBUUs2aW9RNTVzalY0Z1RhZjI0OEdmZFB3WGpYYVozY0RJTXVzZ1ZyVGh6?=
 =?utf-8?B?Y2UwamRwVVJzc29jYlRLZ0p2WWxtYUlaendIL1YvUk1ualhrQ3lUbVFmYXBl?=
 =?utf-8?B?VE1FcUpGeWxDM3Mybk1KckxiRDN4YitrRXBobjZqQ29ORis1S2l0NXFiekE4?=
 =?utf-8?B?T2NTamhqM0JUdWZyTHQ4TjJ4K3M3UUNvYThWM1B1NHJVSnRCQlRLTUZQWjhG?=
 =?utf-8?B?eFFLSmU1bEEzSmZlRnRYNFRvS0thNlJDSHNYRDg4YWJDUFhnbk83VkxuL1I1?=
 =?utf-8?B?emNLUHU3Z1dlSW5FMkRNRVRRd0cwQ1pjbHNabXQrQTF3NUhnbE95QVRrellG?=
 =?utf-8?B?ZWNOVGpvTHNqRm9nMU9MbnJpaGlJT0Juc2ZEa1ptZ1ZWSW4wN011VEZaNFpT?=
 =?utf-8?B?TmRxQUVFcE0zM0h6L2d5OGVob2Z5YjlxV2Y0N0o4a0FSN282OHNFam14VmQw?=
 =?utf-8?B?ZU10Vkw4M0ZUMkt0ZlRRQWxscU8zVFBBS0RGTlVUbWM5N2F6U3JkRVhvWnMr?=
 =?utf-8?B?R004UXBONS9PM1QwaVloV3dzeXJ4bHZoN0RhOTNycEJPcDFOSEVuV2Fna00v?=
 =?utf-8?B?bjIwWFFqc0hSNFRQMGxlMFhtNUwyZm9xQjUyNmRHeXlsYUduYmM1ditGT1px?=
 =?utf-8?B?UHd6NFN3Z2pUUTNFOFlrNzZxYlZzV3VlZE9ZY0tQMjYySzljTzdUTUFhVXYz?=
 =?utf-8?B?Z0RjSjlxb29qM0xsZTZMdlgzaDlSR2RlejRXdXd4RFRocG8vU01XRlU2Qk1u?=
 =?utf-8?B?bXNWVnlucWtnTlo1eVlCWDZtRW52QkEycWZPVTlhUnBpRGlEZFZqb0MwbFVs?=
 =?utf-8?B?S1EvVTJZQmNWUzI2bFZ3UHY2aFlESm9CYVVPU2RwM1R1UzVlQS9rMGFya05F?=
 =?utf-8?B?K09NdWliTmdKcy9HS09IS2VVMnRJSFdCQ0c5U0V3blRRd3NCZ3BqMHZhVG5T?=
 =?utf-8?B?c1IwWHpIZGJFcTNPU1NhLzhJeUNHWjB4aDN0WC81aEgyY0I0dTRvVTNXazJi?=
 =?utf-8?B?TzJ6WXIzLzM0QTdCWTVyUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QzVhSVNJNHIwSUV5NUIwZTIxTW4zdGY4SW1EZVFvMStVY0pLaEtZQks5UVAz?=
 =?utf-8?B?L1JzZ2JVVGQyTDBod0Vvbis0ZVRJbWdwVTNrN0dGZUZndmJDby80d1R3YmVS?=
 =?utf-8?B?M1JWT2RJWWhvZG1XRVJ3aWYrU0ExZDRmWExGZ1BudmN3dURGNmx3SVU1UURJ?=
 =?utf-8?B?SkZ3VHBoakJIVFBRQWdaQlc1SEdTMTRPWlMrZ092WU9nV1FNeTArTFJUeUZr?=
 =?utf-8?B?ekhWT3RLai9rbW4yaUp4b2lkZWIyU1JOS3FOVW5ySGY4ZmFTRVVDc2cyZmZL?=
 =?utf-8?B?cVF4RTgzQ3ZWYXQ4cmRJYThBZUlmdksyRUhkUWx1Ni9FbGR2OVo1T2NicHM3?=
 =?utf-8?B?YTRiekxLK09hZElPTzNrblM1REJvcWZLblp0TmVMcWRQU2RjTXNncXRRc1l2?=
 =?utf-8?B?YXc4YnlOWU1MWUgxZ0hTNmV5UHRtaVAwWWxDMVQvcHNRWmVkeElIbFFZckdx?=
 =?utf-8?B?TVgvaEZaVytvNkJKbUJjU2grOUNvWDdJc3BESHB5Q3NPMDRSRFlaOGlOY2Iz?=
 =?utf-8?B?YlFidTcvdzlrSk5MRy8ySWdDendYSVpITnRJbjE2NFEyeDBpZ3hyUm8xSUNF?=
 =?utf-8?B?L2MyczR5c2FIazEwVnJ4THhKNHozTmhhTGlZR3hCSEQzczVxZUNnWmRrcWFN?=
 =?utf-8?B?TWxMRHdaVnNGU0hvQUVkaEg0bzJSWUxCOE1mZWRiM3Q3Z1VOd0FyQ0lyV0dx?=
 =?utf-8?B?cDJBUk42MnBaajdaM0kxNFpEejZwTUZ2cDVZMC9rTU9hVWEwMEFmazVpdkRQ?=
 =?utf-8?B?dDhMRG1TVWh3U09RdHNUdTJMS0VCclA2Q1ZqUURFTU5ER2JDN1EvZWlvNDQr?=
 =?utf-8?B?VVVQVkpENWNQbEpZQ2tnL1g5SFhTdEhJa0lEbVZOM3V2aEJGNFpnNU1Id0ly?=
 =?utf-8?B?d0FOTUNYUGVwMTdxWGJMZzJ6NEZWRmZ0dE5wVlIvMDQxZlZkNDNCS0dwQVFR?=
 =?utf-8?B?YkRYN3dxSld4NThuV0t3TVJUZUt2SGhmRTFDQ1l4WWhsSEl5UW5uK091aVMx?=
 =?utf-8?B?djRNdGNhMVJuRlJTM1IyL0hrb2FqRVZuQnI3OGltT2JEWkJBNm9admNPRllK?=
 =?utf-8?B?NEZJTS8xYmFVT2poT2gyVmVHeDJHc0YybG00ZUtJdVIvWVNGNWxVVlppQ3RE?=
 =?utf-8?B?NDAyU3BteWd2OW9rWHJrcWE3OXN1bWxQNXdXTnpMbzZVV0w5M3RFT0ZCOEMr?=
 =?utf-8?B?OWt2VWluL2R2KzdSV1ZuR0RoN01YVngwOXFEWTUybFdpc0V0TWhrcFB6dk9r?=
 =?utf-8?B?aDNnampWbkk0WnRyZlh5UmttbXRRVHhHRmZlTjdTQlduOUFCNW9oRmR5aklM?=
 =?utf-8?B?ZFNPdFZMb3BGRUJyY1ZmQ0dhbFA3ZXdNZGpHQzVjWS9qTUdJbGcvRDZuYzFm?=
 =?utf-8?B?MmRiVVVLWm1CZ1pBdkY1bUFMYmxQVk5BUzQrTEFydGdaSXpubE85Vitwc25w?=
 =?utf-8?B?dW5GV29OMVA0TEd0dnBPcno4QkRmUG1ERDNFZ2c5bEtLaWhPTTFEZnd6eHI5?=
 =?utf-8?B?SVh4UUVSWXVzMS80ay9XY3MvaDkzYk51eWpYWVQ5WU5hTko5TFFWVFRJanow?=
 =?utf-8?B?aXF5VXJUeVlNWjVoUWp5K01JU3pYV3hpL0N4eVl1OWVGbkFEQnBQajJsbUVG?=
 =?utf-8?B?QVZ4TFZKZnZhOWNkbHFmU2N2M1cwSndSN1dvenEvbE1FeDZIanZUYkNmTXlX?=
 =?utf-8?B?clkyVXBSc0JROGZjMzFJblhGeWUyTVBzNXpZRmRqZndMK1l4bG43ZjNmQjRE?=
 =?utf-8?B?WU4zMlJjM3RQSkRxZXVpUk5WTHRqR0xSSmFVU0hpQjk3YW95dDQ4RkdaeEtE?=
 =?utf-8?B?QTVqZmhQSXg2Z0V2NERTSmFWbklhb25vM28rM3dIR3duLy9rVVJ5WmZSQW4v?=
 =?utf-8?B?dnNWQy9nS2lMVjdvbEJJRXo2UTRuVGNPaXNNazBueE1Fd2pyMHk5YXM2V3FI?=
 =?utf-8?B?aXVQMm9mcEdFUGpTeFJxOXU5OVlmZlZmUVN3MnJ0bThGMzA3Q0NpRzZKQ0ZU?=
 =?utf-8?B?YWhHdTBaRUdueW83aDd3MndVeWFIWWgzdzJTU3M3Y29Dd25hazRnL2pJaG8w?=
 =?utf-8?B?Q01HOE9GbUpFYTlvWmRpQkt1SFBOM2piYlJmMTROVyt1MVpYejlWY1VmajU1?=
 =?utf-8?B?Qm43WUVhRGt5V1k0YWlPb01zZlZsdk4xSWlpcGl5VTU4OXQzTzUxNWltZHVp?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7583f0e7-db1a-4467-de61-08dca2556ebf
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 09:31:39.5254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bfh/h+Ju111Znl6RyU3KWO0QXQ0duxyIeHJNkqWLkDAC0XxfU2iuUixz+TCopWEkRaYYWgbWu3qmKNPcJ97mEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6561
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 09:31:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16467

On 12.07.24 10:11, Stefan Koch wrote:
> - The busybox losetup doesn't support "--sizelimit" parameter
> 

...which will be needed for the succeeding patch, right? Full sentences
please, also logically.

Jan

> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/encrypt_partition.env.tmpl    | 1 +
>  .../files/encrypt_partition.systemd.hook                     | 4 ++++
>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb         | 5 ++++-
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> index bb93361..72033d1 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> @@ -5,3 +5,4 @@ WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
>  HASH_TYPE="${CRYPT_HASH_TYPE}"
>  KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
>  ENCRYPTION_IS_OPTIONAL="${CRYPT_ENCRYPTION_OPTIONAL}"
> +LOSETUP_PATH="${CRYPT_LOSETUP_PATH}"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> index be8c117..2ace533 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> @@ -19,6 +19,9 @@ esac
>  
>  . /usr/share/initramfs-tools/hook-functions
>  
> +# get configuration variables
> +. /usr/share/encrypt_partition/encrypt_partition.env
> +
>  hook_error() {
>      echo "(ERROR): $1" >&2
>      exit 1
> @@ -47,6 +50,7 @@ copy_exec /usr/bin/sleep || hook_error "/usr/bin/sleep not found"
>  copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
>  copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs not found"
>  copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not found"
> +copy_exec /usr/sbin/losetup "$LOSETUP_PATH" || hook_error "/usr/sbin/losetup not found"
>  copy_exec /usr/bin/systemd-cryptenroll || hook_error "/usr/bin/systemd-cryptenroll not found"
>  copy_exec /usr/lib/systemd/systemd-cryptsetup || hook_error "/usr/lib/systemd/systemd-cryptsetup not found"
>  copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> index 72de5b6..1679133 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> @@ -9,7 +9,7 @@
>  # SPDX-License-Identifier: MIT
>  
>  inherit dpkg-raw
> -DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, \
> +DEBIAN_DEPENDS = "initramfs-tools, mount, cryptsetup, \
>      awk, openssl, libtss2-esys-3.0.2-0 | libtss2-esys0, \
>      libtss2-rc0 | libtss2-esys0, libtss2-mu0 | libtss2-esys0, \
>      e2fsprogs, tpm2-tools, coreutils, uuid-runtime"
> @@ -57,6 +57,8 @@ CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
>  # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
>  # in a newly formatted LUKS Partition
>  CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
> +# Path to full (non-busybox) losetup binary
> +CRYPT_LOSETUP_PATH ??= "/usr/local/sbin/losetup"
>  # Timeout for creating / re-encrypting partitions on first boot
>  CRYPT_SETUP_TIMEOUT ??= "600"
>  # Watchdog to service during the initial setup of the crypto partitions
> @@ -68,6 +70,7 @@ CRYPT_ENCRYPTION_OPTIONAL ??= "false"
>  
>  TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
>      CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
> +    CRYPT_LOSETUP_PATH \
>      CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
>  TEMPLATE_FILES = "encrypt_partition.env.tmpl"
>  

-- 
Siemens AG, Technology
Linux Expert Center


