Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE00AC54E64
	for <webhook@archiver.kernel.org>; Thu, 28 Mar 2024 10:14:47 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.88])
 by mx.groups.io with SMTP id smtpd.web11.12225.1711620884865957523
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Mar 2024 03:14:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Y4DkoRFk;
 spf=pass (domain: siemens.com, ip: 40.107.8.88, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbnYakt7ToOW4BzJuqbyLzkfMbJQjlD3KAutKMfF9MJlUmio3rn4kKF4jnHIbmbyb59jE2hPaI8q0uRGSCCZD8gyZ34g6/dpQVooqDIAn7GkhXBmw1cVHOuzi54GhV4awZFt8ESpfshwj4rnUlu3KIICV9rUeIcPpYnncCRMv5MJLD0fl1UWwhh3yDINfe81iPkTr8UPR8c4k8fGdeig5fPZCQVT/GqCOaxmd+kTCHw0hzj6iDk21GWW4u6ipVL7ULD5YL6k7ZEJMbZvb512MNA9E4Gd25WosMoPHOVTNqbxPtSySwHlJb4nKSlzXtqh7DBjg3wTgj902sn9h52B4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBnZRuZuhI+EneF8ueZCKzhNbAZcLSGoUeiaB8WS2q8=;
 b=nuzNel48rM1J6SdpYdBXnBKKKsHNjJ393vLqJPuZ02UQviMKi/YUiNXSIMj01sZmkg+j2NCk1ryJ8C9kzNF0blWZA0z+0hWXKs0qQY/FTPQe380evGUMit9d/1OS49Ej/IS4t0+8B93yTQOGX1ODeFsAe0YLLhAgtSDgRBFV259YQVHrGZxSftplbZAgfpLWCmKVYFVbj4YRLhYdc6TYroeBpbNe5YNaQ5Ah9zdvr4rhJ1obp79Ey4Cwimq9uUOim1SYsW6r59yl1PivJzm3IXpjKRZ8/NZlcDqKIhvbkDS0HtQEbphZu/2n4AzO3dVK9Y0F6Amgx1kn88j51IQjbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBnZRuZuhI+EneF8ueZCKzhNbAZcLSGoUeiaB8WS2q8=;
 b=Y4DkoRFkt+QJKLy2cc9Oc03hezfRyPEm4Tc582dUKGe6MqcNFjDgC9OOZTQwmMVqnCXXFvcps9H7EEc3i5N8xl58OYLGcpYHvSfqXAtRSF/+rRbh47iEq2WXCj+/RJGr17QawMOniWtoghmRuKI8BsGAj4dhFi7C/wEPwAUaaHLYR8B478AwIC0PwxVnv8YCjEEcs66JUAoOSCb8m+PHRPYRC0XlfS83E8fKAHnYSiCmAkWaU4ktFw1fLKC1LOHAAtgfcsVIw1EOFCSw0PteUPY978qJ98hamh6cx1MTniLebIeL3s2P15g2VF2Fki/1D6C6sI4sXobHPuNM2RxN5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI1PR10MB7669.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 10:14:40 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 10:14:40 +0000
Message-ID: <e8168d5e-515f-4983-a1d8-7fd260633810@siemens.com>
Date: Thu, 28 Mar 2024 11:14:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC 8/8] Add example to encrypt the
 rootfs
To: cip-dev@lists.cip-project.org
References: <d7cc79e4-ef20-4d31-befe-229ca3274fb7@siemens.com>
 <1141.1711388896493643788@lists.cip-project.org>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <1141.1711388896493643788@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::20) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI1PR10MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: 839bf474-b93c-44be-fa46-08dc4f0fe153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JJ/1MJAg3wSQcxrrguRuHSomfGZIrphl/v9kMWnHlllKwonwfHPnHG12ZgUmAhBWiBqwg30y8FhwYH1x//hPB7Ez8JWRecBZQdgkNEz7dBLbY5jt7f0kmAvpWNhIWlalNpOtFJxKWmydqZ5XTj1UbvndufTnBcAU+Z094OuK/cAjO+EeV4oOL2lo6BDPbq/RhrDbXJjY0MCOoI5zxGmS8KLRnSeRDryvvzQW1JWCwH6rEkWS5fwJnTX7G34Y5ItHxoJqAL40YfcAx6ynabKo8ha03mqnbx1M8h1gJ0+CTffH2g+/ne1LK3RlA4V5Dhj3Rnkrhti3mk0fRZ2PBRNysYZDpFutCNvdgD+RAlW/+XMdNL9q4i4vBJ6sKF5NlHl69VDoNWn/6SGoj+PIwKOzz8iEttuPrz+1sRheWUCpJuV0K0SpItMxqKIC0oKhIrMF5l+wrIyIpjBIaHFaJtQEWxyOfFWroEki9VIzTB1TMVmh6VQui3LChTLl2NGTmSTb40z+d7VsWATJBqkWWD14Tosv4ojwZ1sR4P3Ruul6oTMLj5KfNiUlVSqMYUU2+EkQOfsGHBglnuooq7VqRBkhyAOq7Z4vqCSxbHCxZd9S3XY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ay90RzYrZ0hOb2w4NzhHdXNvSnBFRUNXVlpiY2paa3N5RlN2ZjlQc1p5ejBQ?=
 =?utf-8?B?MkU1b0VOTndQRmQ3RTBwYVE2aXluM0RFYnZ0TERMMmRxbjRHbVpERisvR1hV?=
 =?utf-8?B?TUVNYjBycHdrZ21xSlBhU0ViQldTaXEyT1pWUU82ckhXUHhUOUc2TG03V2Fv?=
 =?utf-8?B?bFpjUHJsbTJNQjRwSTVVRXN5bGhab1pzMXYzL1pYY1BrajFtT29ydXJHWkJE?=
 =?utf-8?B?Y01SSUNNRlZjbFhWWnVLTU93VHlya3VBcTl2Vm5Eem1UTk9IQ0o2SnU3UDJn?=
 =?utf-8?B?dFNqa0owNlZuZlJ1d0xiSElOY2RzYTE5WXdqZ0h2Sm41MmFLamgrSDU3czlv?=
 =?utf-8?B?SkpTVXRQMWx3ZTlaYWpHbm9hZEo2NkRPdERza09nNXdUNGlUM21BOG41V3dP?=
 =?utf-8?B?ZEJuV05TSGZrOTFQbnNMTkw2RU4vN1ZRMlp0eHQ5KzdLT0g2T3djVys1VHIx?=
 =?utf-8?B?V1ZWcGgyVDZ0SUlMQWhRQTFJVVhkMmxHeU1EQXBxYW55Y25iRENxM0R4TEI2?=
 =?utf-8?B?a05nUGRXb2RHMHAvMWh1TFNWR25HbGpWUXRWeitCRDVsOG1iejJIUVRPT2wy?=
 =?utf-8?B?VHhudnRidUlOa2YwR0xrRUFOb0FxS0VzbW81d09xTGoweHIzTmlMRi9UazUx?=
 =?utf-8?B?eXErbEc3V2trWnphN2ZRM1U2TTJIN0ZwZURyS1pQVnRqZFRpbnVFUVNVMzNx?=
 =?utf-8?B?SHlXUnYyMmVqcXRjUkF3R2NqTEdHSjlPVW5CZm91cSs1TXFBODNzc2Qyc0Ix?=
 =?utf-8?B?bmwwMVFlR3lWUHJNYjFsWTNPMHYybmhTcVdhb0JWdDd3WFJXRjBQWTJWL2xW?=
 =?utf-8?B?NE1SRk9MTGREL1VrT0VXVVlmKy9IUnNmZHJnVy9uekVnQTNjZUFpb0UzbnV6?=
 =?utf-8?B?eVZkRWRlU0tsd0owQlU0L2s1V0laVEFlRjd3TmtQNDZpM1orb2R1SEZENTJu?=
 =?utf-8?B?L0Q3YmtsY2lSc3hidHJFdUI4QnByNkd4NUl1a255cFN6aHR2cEU5bmpDWHcv?=
 =?utf-8?B?ZUZCampiOXpVKzlkTnVCUnA0aC9HZU8zVEdsckk4cDkxTFYyMzVqZ0Uwc0Nt?=
 =?utf-8?B?ZGRIcXpGU3hEeEVoU2xQMjVUZktHRjR1ZW1YUDNsVXNXNWJkWWFNNU84WitR?=
 =?utf-8?B?Wnd0YXNTN1V1VkJLeG1odElWcU9rY1p3cGZndVVLZDI5MUtLYjVJc0llR2dO?=
 =?utf-8?B?UWtpNEhrdlJSQTBSODRJWDI0TEQ3UTJrNXB3TjlQMExva3UrZkN0OXNqWlF5?=
 =?utf-8?B?QzhYQnBoNFRzUmU5UnRNMXBCbExuKzI4WWllZmV6UWwydTQvSUJJdmpxSkdv?=
 =?utf-8?B?RlJzeHhiNmlpUFdDVUlYMkMydFYvS0xyRHMxWk1ieHpFTkRJankyeWdmR1hP?=
 =?utf-8?B?YVd6YU9udDkyYTVrUlBDbk5MbWIyQlZ2VEgvRnBMejkvcnFFMU50Vm9Ma3dp?=
 =?utf-8?B?YWV5YlQ1a1NCK252MkZHUnFvREtGSnlEcEhiZHUwQ0V6dlpqQlRjYUYrcHVr?=
 =?utf-8?B?eUR0aTFzNWtKUkZOU3YxYlV4elRjRHVmTjJFZVV1cVhHbHh4TmxrdzB2VEhS?=
 =?utf-8?B?QlN3V0p6dmZuWUsvWGRzcDRGNUczUGRCOEs0bSswOE1OTmUwL0swSTZFeWtS?=
 =?utf-8?B?VjdxUFFoSDBQQ2pTTkdOWE9NY21jbUc2bXJobXBkRGMzdnJScHFxL2RqUzVo?=
 =?utf-8?B?Q01PSytpVjBNS3BUWW5NQzJzN3FEcVZIMjZoaUdmODZHbUw3Z1pVUXAzbnlQ?=
 =?utf-8?B?WjBienVvWTZPcDF2SDdiUWUxYUduYVR4TUlMSGxHajc1YUhwbXBMVDEvQ3d5?=
 =?utf-8?B?Q25udDYrTDRPdGhXdkFpR1ZPSGFuWngzWVllSHg1Wm9jditDaVdzbVZkaHRv?=
 =?utf-8?B?Vi9DMmJ4a3IxczcwR2V3YUNFUjdBWGsrR2Q3VXI5aUtWTTF3S1ZmTXQ4VjR1?=
 =?utf-8?B?cDFRTGQ4T1NNZFdpYWRwZHEwKzJJd01vVEp4UWxTY3JDbFNNWmN3SDRObzFv?=
 =?utf-8?B?Y2daWEpCSFY2ejBRaEpELzV1M29sOUwyNGNrL3ZhMmN4NFl2Qm9JbFJoTWlO?=
 =?utf-8?B?RmRLUHJYLzE3RENmYTJQMnFidWU3ZkRnRjJtdVF6UWtsSDAzWSthV3RFZVR2?=
 =?utf-8?B?UXNFVFVBamxFT3JpQ1MrdHRPT3pvSmgxQ1ZjL29DNXZkUTJPSWd0SGZzajdt?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839bf474-b93c-44be-fa46-08dc4f0fe153
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 10:14:40.4952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYUCrZJb/RVSoC1Snxi8fnUn1FVqO6slrHNKrklJcr5REb37O3mwLvw2gAMQdSEWMhUDnuiiVGM++5OTe5gcBDnCGBmEKV1WNlsjMNqofv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7669
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Mar 2024 10:14:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15474



On 3/25/24 6:48 PM, JohnW via lists.cip-project.org wrote:
>     This should build an rootfs without efibootguard and with systemd-boot:
> 
>     ```
>     kas-container build
>     kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/encrypt_rootfs.yml
>     ```
> 
> I tried this build and tried to boot this image from USB with secure 
> boot disabled in BIOS. The boot stuck at
> 
>     EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
>     EFI stub: Measured initrd data into PCR9
> 
> I currently have a image build based on ISAR with grub boot loader that 
> has secure boot working properly with all of my test devices. Is it 
> possible if I can add the /opt/encrypt_rootfs.yml into that build?


This should not be necessary - the only changes necessary to encrypt the 
rootfs ontop of v2:
  - using the custom initrd for the initrd changes
  -     CRYPT_PARTITIONS = "platform:/:reencrypt home:/home:reencrypt 
var:/var:reencrypt"

Quirin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15413): https://lists.cip-project.org/g/cip-dev/message/15413
> Mute This Topic: https://lists.cip-project.org/mt/105029665/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

