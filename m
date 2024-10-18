Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF91FD3F2B4
	for <webhook@archiver.kernel.org>; Fri, 18 Oct 2024 21:57:44 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.40])
 by mx.groups.io with SMTP id smtpd.web10.33327.1729288663946913388
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Oct 2024 14:57:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Sbps3p4d;
 spf=pass (domain: siemens.com, ip: 40.107.22.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fdnha+y6X0rlON8MrpmaJIE/DMhMB7y3ugHGZzvH3WmtKUBC8FDaB9w2fMY8HZ4Me/2Z3WcpS2Echb5RJ8ePNP5wkq70dCyZBFuK6q+2FFrN/PyKHjWUXPCEAtTrhP7hat5khDRzlDZax5eCxkaM+peQ5tZyfSxlE7mZ7+3ZXbUlP1cVWBflPQkOcRJuYiTlTuJK1bMt5CuSkVYyhS6KpXKFITaTCEXFbmF/ukFb8ploVQmroov5Zn7HRZURXYRnp9brMQcSmjyvvYPgmg0BPBOffUocQEj0b93BbYFKGVuTqXgcbhzWeQ/esSMHJUcthEiA2NHkcfw5nbKq8y+IXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TO+lpvzyvZ1aCmLyLBb09eaZ+fKOSIG3ZmGfc9LmkiE=;
 b=DmTS1cps8gxNd+2+5fN5wzjfgyAz6g/v/8e4ZliPM+4vv6wOPgIymvELE3B81XWQr5tJsGn6FuXQ/pVgESba/mW+Uo1oa4dr44FXpmvcngXyQ2yExnbp4sPHBJN5QzoaqkAWmTk9djiMbWBtRktk++z5vnSU0EDvsvO3vSRqwEFAXvSeLYgt0IIxXHA+vLITX2is9qCm+aIFQKnCuI4HuPQvyLT2u127pnYDGfxayx4QPGr6SaGDVpvOs5w95w55ArJadze7P4IufJHf/jpesTghVrScji7/GtGY6LvUxC7/0ObWivnpPRUV8PkueHLB2ABPzYh29kCQBZZ+sa5bzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TO+lpvzyvZ1aCmLyLBb09eaZ+fKOSIG3ZmGfc9LmkiE=;
 b=Sbps3p4d3CFrrynPqQ4+m5i2nDDa3WN2L1pplh7DbAsunWMTX0qMSnkBccW+Xv6x5Yz5WL5C9FdP82LY46kIKpDUJQhoPQY2LkQpKRvU5qEOGSAj8zI50t9pERG99kT2r9Qrcflz13wGAs4xH0iVLMQZsrZIpJ9pnSwyxWPYjkraMIK/9PS3Lli0h2vKjSb7wVnLeF/m/yBRhtp+PY2DXERRYQOJx4f1n6aQmKk2T23eGSPSEmUlpZvubHC10RZTyqjB9GJe3pQI+y1QJl5bPzNG5Jd+D51hC0qJiALdm63Nwq2YVG7pfOAon0nn/OVuqYckmwrdc/uOekfMAIN4uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4040.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.9; Fri, 18 Oct
 2024 21:57:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.000; Fri, 18 Oct 2024
 21:57:41 +0000
Message-ID: <6127876f-6afc-4231-b8d5-585826021e22@siemens.com>
Date: Fri, 18 Oct 2024 23:57:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Kconfig: Update default kernel version to
 6.1.y
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 cip-dev@lists.cip-project.org
References: <1729057450-4949-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1729057450-4949-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: cc35b89c-6142-476c-d604-08dcefbfe36b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aXllekJ1MUNEdFlSVndoMGRkM2lPRWgwMXg3bHR6OGVvWTkxSm9lWkVHQnI4?=
 =?utf-8?B?R0xCc3ExSlUwbE5FT3JNYU1NeUxqUVhVU2xZdEdKTmRkMzZQY1kydDRzQ2Fi?=
 =?utf-8?B?Z25FeW1aanJlYmF2eGdJbGJPcmpKQUxrL3laRXlqck5aUmErQnp2YTdsaWVx?=
 =?utf-8?B?VUM0SHM5Uy9udmZDUSs0dVkzM3VxL1k4S1pSWlo5N2tXVFZWU2dFWUcwdHFI?=
 =?utf-8?B?czU0VS9RUjVHRmw2VUplK2YwY3Fndi9DcXdjNWZQdjhwbjkzdzl4TTIwWEdP?=
 =?utf-8?B?S2pTWWZ5Qzh3RUo3YUQ0TEJoblNrMkJIbDNNWk1TYVZodlhiaWNsVThTOS9q?=
 =?utf-8?B?SlhTdTNyUXQvNWZxVFFzams1L0ZVM1pDSFI1VWhteTFMdzM4U01VTU1ZMWFt?=
 =?utf-8?B?VVZTUkVVQjdZelo3bkNsd1NjNGVIckg2WE1ydXJhS0l4U0VkOXZ2ZnMzWVNy?=
 =?utf-8?B?Qm5LeWhMS2xxVkhoQVlFY0JBbTMycWpxK3UyNWdlMnE1VXVwT0lNU2pKUWxo?=
 =?utf-8?B?MnBIOHhteEZwUWRSTzNXV3VkcFNhSWgvdlVqV1hRM1RKNG1QYkF4d2FDclUr?=
 =?utf-8?B?Rm1nVFc5RWNUT3B6ODFFTzd4bUh1blhYV2RnTzcxaEdZWTBUQ3YrSWJFblQ2?=
 =?utf-8?B?Z1dtMnFRK0M3OVJ6UjRZUGdqKzRpMm4zalYxZkNFd1JrMTRTQWM0aGJjQzNL?=
 =?utf-8?B?eUg1MlFsZzR1NmR0NlYrWjJaQWZaaSs2YzVaRFp2YmluZnRLVU5ZNU5CWGhH?=
 =?utf-8?B?YitDR2I2cWNjZEdWbVQyd0JTKy9ubnN2SEFXRHZhN0dHUUtBYUxWQncxTkQr?=
 =?utf-8?B?QWtXMUswcE53QlE1UzFFQTAwNmtCY3NoOTlneEIvV2NKOWJmRzRhei85ck15?=
 =?utf-8?B?RW1kenlhNXQ1ZjFtZXhvT1ZOWTBuK3Q5U0NMeUxJb0poa2dPam1mODZqYm80?=
 =?utf-8?B?OXMwZkgzMEFmbklsZmZzbTc5ejFaT25xNVplVGVxSzBiZm5kSFRrdWtuQXNv?=
 =?utf-8?B?WW1OYTV1RlBuRFVBUXM2VnJqbGV2U0p3RXU5MjYxNGp0L2taS09pbUxnanFB?=
 =?utf-8?B?TU1WenlhVll5bVUwajNKcmZFWk9iNnhBYkx2U2U1QXlEQzkra0FaVW15NnI1?=
 =?utf-8?B?a3JHcmI1bWRuV0JyNHpEWklaUkpqZFFMWTc0eEVIRktZZ3RqVzgzRHJiWkFD?=
 =?utf-8?B?V0YvSU1WLzFDdVVGcHVPcjhsV0x1cDBFOFZLSlE2ekdCbGo0eHBMYmF5eis3?=
 =?utf-8?B?blNOa3V5TUhOZFBmTzdVeXNLYWJ6bXkwVFpYMEFiNDg5WUQ0a0ZVVnl3RWsy?=
 =?utf-8?B?RlVPU0daQmlsc1E3bUNVbjlxVjIvakVOVHJpRk1xc0VaeDdGM05JQTdBcHVu?=
 =?utf-8?B?REZKazBsQk01amNOMkFHdmwxNWZrbmk0SFB6RFpOR0NMZk0xdllkazBWd09W?=
 =?utf-8?B?S25SMWh5enArbW5xK2RGUkwrYkZxc3d2WUUwZ3RWbnpQREdhMm8xKzIyZ1Fj?=
 =?utf-8?B?QzBnS0RqNkdZSFQva3dPY3NCWHNCcXJrOXExZDZhcTF2OEdVL3JBaVY1TXQ1?=
 =?utf-8?B?dkJDYUkyNjhoUHNUSzJHdytqTXZCLzQxYnJtdWxhZXo4VVR5N2x5ZGZONm9F?=
 =?utf-8?B?dklmbWdjQ1lucWk0VWppNENIN3NiQlVBR1lLVHdmQ3hsREtIMmFlcmZhV08x?=
 =?utf-8?B?cjg2TlZxYnhRM3FiQjIyQnNzcWJxV1k2VlNFWUkvQUlOcmlyanUzenZyREpW?=
 =?utf-8?Q?atzB/8O4bw534iS92OWL5R16tWnW6lwNr1/3goF?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aDAzdlc2VUlRb1ltamQrNnQzRG44aG9MTW9LMnVibFpnMVkreTVJSUNieTZQ?=
 =?utf-8?B?NzF3QnRuT1BRZmlYZmVGL2RURVhSYittclZjR1RTK2pMb1JuSnJtVUxxZ21H?=
 =?utf-8?B?QW1QaFFHN2dNUC9Ob3JBNUw5ZHEzQzV4MkZlQzkveUlicC9MaFJMdGQyd2lH?=
 =?utf-8?B?aUVUSjFuK0g2YzZIMUljdG1JR2FnU24zM2kzVHdIZk8zd1pPdUpYS3BRZGxq?=
 =?utf-8?B?UFZOSC8vWTlFQ05NVkVSZGtlZjBQQmRPYmFacFY5aVk4MEsyaE5YSnNIZW1F?=
 =?utf-8?B?UG96WksrV2MwOUZZNUdhVTJxZmc4YkRnUEF4VnNaN1QzUEZlS1VXUlcvSm1m?=
 =?utf-8?B?UTBWSkl6RHUyS0t2WVNwUGNlVjRXSWU5ZURhNU9jaXpvS0F3YTUyME51aDhp?=
 =?utf-8?B?SUdBd0d3eUYvWGhQa2cxTXRBcmJpeW9CV0dmVHNGL1M5N0p1cStXV2JEM1Nx?=
 =?utf-8?B?SzZrSmJrRlo0T1AxRm13eVFFdWdhTzNUSnlWN3NqQzdBZlFXWWx0RVNYNnYy?=
 =?utf-8?B?UHdwK2VGS0wvVXV5K1dWUVNVOHU5cTdTVVRseDFKczdidnRUaDFmTWNVcndJ?=
 =?utf-8?B?ZXJJOCtJcUNXY1lmaW5ENzZOZytqYWVOQzBNMWZQUGpJa2NkTEdrVHFBc3lD?=
 =?utf-8?B?aEswUXNkUVNBUjNZeENUeWZrcis1MC9ZQUcwanBKVVE0ZmFFcGt1UVhscktk?=
 =?utf-8?B?aDZDdkN1c1NVSFUrVmw3bGJ2S0MvL3NoQ3dBbCttNmRuMVlUMjNkWEd0SERx?=
 =?utf-8?B?b2dSei9JWWJHZ3JVWm54V1kxcnJEV25sbm50VExsU1puK2ZHbjFKWGJiUlpN?=
 =?utf-8?B?SkU2WDF6QjBldDIzKzBXREU5ME1QeU50RzFjMEVCRzZIS0JvT1pHTy9DVXFP?=
 =?utf-8?B?eXJ6QjNoZmNaMjd3bFVReUYreW1sak5oVW9SNDRKemNEZ0cyMlQ1TUp5bFdB?=
 =?utf-8?B?K1hCZDB3VDI1b1J1dmhtRnRMY3dhZEd4Um93NUk2WW1OSXJhNmVpaUNiKzBZ?=
 =?utf-8?B?cHRqem84VFMyRFJvUnIzN0RyUHd0YlZJRzRSRFZBb21YY2h1Vm1obFVqV0xR?=
 =?utf-8?B?OHNXd2pXTHFPR0dBa0Z3U1JQaS80dnpmdFlWMzFDYWF0dUwvWDd1Q082elRs?=
 =?utf-8?B?c3hFVWlJOGZZdDcvcThaMXMrcHVCY1FpMkFCekgxNTdhb3NhZnVkTHhQUjVz?=
 =?utf-8?B?bUUyaExRanZnbVJLRjhpQW02U29wWXdzYVYvMEZtd21LS001ZVdHSUNFQ2pt?=
 =?utf-8?B?VXBsWjJTdWFqK3o4WjFRNWNzdU5BdUdNdlZIdkdEUFZtYm1qNlQ0TUtrdjRC?=
 =?utf-8?B?U0FGeTQvQlR1SkM3Qis5WUlPbHRRdzdMcjd3K2cyR0lQb0lNY3BTc0Q3bENI?=
 =?utf-8?B?QVRvS2R0SDlsWklLVmJtYjl5SGlJeDJoSmxaVlpmTytWMGRraEY2Y1NuaWlU?=
 =?utf-8?B?UE0wL3hDeDd6Z3RaRGVUejMxT2tpQ24zNGpINDJrMklxUi9tZjl5T0dTMm9m?=
 =?utf-8?B?VHMwYlJEZ1NoNzMyODY2RGJsUFEzaTFYNWFELzNLL01lOHovV0VXUjh0dTQz?=
 =?utf-8?B?YXlINVFpV2hhTkRobmhXTWEzMmowMytjU1NodnR4WUZhWm1GQVJkVlhMTDF4?=
 =?utf-8?B?V2dBLy9BaG8vSHhYNnh3YjJVZXY3ZXFiMm9tQjBoeXByVDQzenlQd2Z0Q2Q4?=
 =?utf-8?B?TnVnRldhemhYNFI2WnNOaklrQ05tS1pyTkl2bVNnTVl2LzdYbzFWSzZsUXZM?=
 =?utf-8?B?bkV1Yi9RRWNsM3M5dlA5U3hCd3pOYk4zMTZjMzNoY3NreWtqTkUyakpxVWQx?=
 =?utf-8?B?QXYvSWJsd0NTQ1VYbU9JRHVpNXRxWXlweE5XdVhSY2o0ZzZQQ1loOXNVUncy?=
 =?utf-8?B?a0xKdzYzZXZaRGxrV1lHNU5zUDZMeG12RWRxYmRlOXEvUEgwc3lFdEhDL1hB?=
 =?utf-8?B?emtabmNYUVVBdGJZcXk3OWJERVAycmpaVDd2T3A4UGQycU9vbm5MV055dmFa?=
 =?utf-8?B?amlCVUV0Vi9CcFVGME9yV3JScy8rTHk1OXNrdzJCYzdhZVg2MWpLVnl2NCtT?=
 =?utf-8?B?aHltSCthV0w3Nms2RDhadVRRbit5RWpLK3pKOEFDVWowdENZZjVwQ0pxeXFy?=
 =?utf-8?Q?aWC3DKwghtV23s2zQO4Jf+80U?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc35b89c-6142-476c-d604-08dcefbfe36b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 21:57:41.3979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLfJnEzrrKzhKng1YjXU2FH8Gl0a4HqAi00GpjcuphemDNHFRc/8roql/jPTlaip4bwrc0SiFomSuszFMKh3Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4040
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Oct 2024 21:57:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17051

On 16.10.24 07:44, Nobuhiro Iwamatsu wrote:
> The default Debian version is bookworm in Kconfig, so we should also set
> the default kernel to the same version used by bookworm.
> This updates default kernel version to 6.1.y in Kconfig.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Kconfig b/Kconfig
> index a70ce22..8062cdb 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -84,7 +84,7 @@ comment "Kernel options"
>  
>  choice
>  	prompt "CIP kernel version"
> -	default KERNEL_5_10
> +	default KERNEL_6_1
>  
>  config KERNEL_4_4
>  	bool "Kernel 4.4.x-cip"

Good catch. Applied, thanks.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

