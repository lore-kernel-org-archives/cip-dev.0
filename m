Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE07E10A3D96
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 15:08:53 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.8])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50670.1774537731273389152
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Mar 2026 08:08:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=S3JOGpeq;
 spf=pass (domain: siemens.com, ip: 52.101.84.8, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvaNDZpN+JVFBMSlILYtO6ZFL+bQMi0Xh8a+kwc5RUBx6jimpdi5uS83UNs64u/CJ5mrKtXAM87HY7zE0sy5XMTeNGTxGyJDN46yEgFGafk4hexTgCVGukBPjut8+Yqas+zPcmlDXSrSq1mLVbi1P/mHroccr14pIl7p6YStGzy3NRjLRSkZrWi6rQE6Gmf4T8zL7lLjsrOqTlPcO6fbDGuo0CJjKhUldCdDN0t7fLAO/7xLAROMjJtU4Xa18HQEqwRfFeEkB427kxh5YMfFYuEz8ETwoliejjaydf2BHdkiV3qcLRUCGFAAb8gagTZxTTPJMDg27GUadDdJ9hvcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tf2SPQNjHy9YhYxXxNZVRKWctKFdKCOQXtERvYNvirc=;
 b=J0Xfq8207Fn2QSKEyfEtDVy3CUuPAX+XxHho1Yll9NoaV6X9IwPGGXb6+su9VscW76S8ByfOcikfpmg5de2uxTlM97to+YgJlKvhqpRhR9X0zy7on5DI1g/wnH2UZiB2XrZjCLm7eZzF5MY64+oKalRFbNni3UKoxv3+XSCL7usrNhn+5cPqav/rjVwyHBtTLxZn0K0EK2Z3ymvRUDn40vrjdkFDW8rsVRto8eNjNzrAr2wHhyLRiAWH+PNSAakHgEkRgNC1AQMd4QocLEtczzYe/Fq15I7kMWl+fg+4k4P6IvM0Q2RabgZM/w3p2+ANsfS3Q1D5Om3JA8sglg9sxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tf2SPQNjHy9YhYxXxNZVRKWctKFdKCOQXtERvYNvirc=;
 b=S3JOGpeqhJRQhQ32CmlawKOjBl8rLeq40RONw1YaJTLW3YsP1+zw76xLUFXvP9V69ri5vn7B0AuFdj4fPI+cPDwzqDs774WJQ6cNCbB71Hvrii/WdybOWie7vt51h24BP4S3Axgn1IkmY4IfbxgOOAk6hziZAckAKl3ew23xOeuNxixdk6JbFuEL0EbuLmk0ybpfT019lHCC4tDxHrUX1MMeh9un39Hd7AwPd5D0z0a5CP/uiZNiIq3f4y7ve7lW2Xmv+7RVeJfgBqdKY6+05uP0t8lxTfOmK9LgpKAODCHrVxWew67VN85VdS99jm3AzRHvzPqnPzotMz6Rb/DDdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB8018.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:568::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 15:08:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 15:08:44 +0000
Message-ID: <36dcddf6-8c3a-4226-ad6e-82b3e6bccf4b@siemens.com>
Date: Thu, 26 Mar 2026 16:08:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] chore: run swupdate in all tests
 with loglevel 5
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260326144129.853123-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260326144129.853123-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0728.namprd03.prod.outlook.com
 (2603:10b6:408:110::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: d47cab2e-c003-43e3-d0c4-08de8b4992ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	G1frs5UXln/vDkWN5RYP2pXtKtbbMebNHcppK3QibLr/vRTWEoXcwIiUgKyINEWnVCTzCVCZI/zSfUndU01gBgpJvOr8xPbIuX3v8kamtKiYhUi1sW07HR3C30ePLqVASfFv2Tka75Gj6/VWc4CtzQg26pBAPR0m583Ur/LDbG5mFDuDTnzxrri0woEA+LKxQKL5n6wII5pltUHwgZqEGFebWiBNxWewzrp9OlMYCL5ephMehjtMRV7cNDx6SsDpopgqxRzG0eVD7SJExdBd8e32p/Wst85Qi/yjgvw74BOh8S17aAeZ8FlKiFBs0rcf0Iov33x93d799dg7CabTBZ6vLX586xr2vpD2xywUj8f+qg2jUGoIVmdhOb5yOv2KMGIz0d7DTCoPqr9I8kCpC81Eyuft1XTVGAYQ+lhKpp313J8locg0VizzvCLlljRgBWC4FIP/2uNuYFTt1gOrYji44kE3uLn8j6bBhxAxArrTBS8VtTGexxN/qRPP25DfbGD/2wUWB9ZJat9A1lE9hWHMLHLmUuBo/H4CB3aJHA3DkjxcVnyBg+2lTWZ9XbdMiz9nyDFW/DapZOX5h65ennIWk/mKNih636cb+wSD1ekTZSCeRanJgugov0rMhQNrealIO9zEaFE6bwOYZnEBmrVzulbChM15LfPNh6KRiw0V3F0VB2rj69tF6Fgs7XI6Cto4B1Uuf5Q6XDGRYOG3FHYU82eBnm/fVLvZVy1VwaQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z2hKajdGZTVRSHBkYXpmMkxqYkdzYWExZUVxV3lENzRzY2dpNTZnZGU3N1Yz?=
 =?utf-8?B?V2IxS2dQUTFpUkV6bGlDaFY0RDNlOUd1UWlaaWY1Q0FOcWdSWGI0YzBTOEVi?=
 =?utf-8?B?M3NQMnhKYXJlc0ZGaU54MnczMDNpdkRmaFN4Sk5KblJWZ1d1WTVGYmM4cUth?=
 =?utf-8?B?Q1hMZjdTT1pIUzJ0Z3J2MDlHSkpYcW8zUG5pR3YrdjdDeWVkT09abzlsRVkw?=
 =?utf-8?B?emNwbDNZVlc4Ri9WdDVKWXJtNHpBSGU4ejZVT1cvbWxud2tBbHpWZCtZNW92?=
 =?utf-8?B?OExXbHVlTTZ4citFYlh4NVpybTZJWlAwYXlJbDgxaGhjcWhKVEI1U2FaN3gw?=
 =?utf-8?B?ZURyblJpU21IL0xrNExtOUFsQnFZWHNmbmYwdWtqS0lrV3RSdDJZUkJ6V0pl?=
 =?utf-8?B?N01zNDdrcGdhd3V5U1pjRVlTTnlxZE56ekZwVWoyVDdRcmVFTU9SaTlOQktu?=
 =?utf-8?B?QnhKM280a1ljc3BBTEtrelM3VEtobjlQZFI0cEhRamlBeHlsTmRPVGhYcHBL?=
 =?utf-8?B?TmhOMjZ1M0x5R3RncFhXaHV2ejdWOXV0ZmZWeXpvQ2dQamZpaEduR2hmbXp0?=
 =?utf-8?B?bWs4azVGUExaVDdTMlF0emJsY1B4SnRmbkxSUGlwdWc5SzJCbThuZm5PSHIv?=
 =?utf-8?B?SkQrRTZyOFJtNWptcmJ0N0ZIelFOcnVtVHMvODF0TjU3MXdhQjlXR3RSTThO?=
 =?utf-8?B?U2R0QitGckVEMzNMazhybytyTDk2NVBlNWRaUkdCYUY5NUg2cVRmT0dDbjV0?=
 =?utf-8?B?dko4WFZxd0hyZ1ludDJkSHBybkRhbWlrYkx6T3F0b2xOaTk5dnRBTU5MUitM?=
 =?utf-8?B?S0hxREo1OXNBTU03WlRYSHAyN3R1dWg2SUswTzlUQ1pUZHY0NGZ1ZXljZ0tZ?=
 =?utf-8?B?TjYvSjB3TU9iSGJ0WEV0UzlmcXFOdHd1QmQveUk3SzUxQTRUb2hEZFpVMFlw?=
 =?utf-8?B?OGJlMVpZZGJLMFcvZ1RBSUdNYUZZNjlQQllWeTAyOUE5bG9qczRGWDluM2RP?=
 =?utf-8?B?aTlGb1lIcnlTUS9TSVYzclozTFpYei96VmZ6SjhCaURYblp4a2E5bWwzMXg2?=
 =?utf-8?B?SlhuMUlOOGhlbWlYSm15Tkw0Mm1RSVV6WjVQdzlLQkdwNTVCQS9PQXJ5MGxE?=
 =?utf-8?B?Q3R4QmMvQXdUemtPQ3FwbFk0Nk1FcGdpWkl4VWdiLzdHY0NBTjdpeTFBV2hO?=
 =?utf-8?B?UVdaZHROSkVrQTF5UEhYcjAybTZFUTdqYTMxeDhBY3N1TjZ3anM0cGkwM3BU?=
 =?utf-8?B?d1BHQW9mVGxMVC82VmZURkhFcGkvS3VFZm9TRDdRZU0zWkNOeG53bkxlNUJQ?=
 =?utf-8?B?emlaSk15NWQ2c1FraGtHQUxvdmRCS1luL1ZVcVpwUG1BeVB6T0tpaGZZT2M3?=
 =?utf-8?B?QU01Q0MvdWxXeGd1WDZQNTY3anBQOU1zejRxcG00cERhS1FOQS8vNk1POVRU?=
 =?utf-8?B?aytNSmFWK2I2VHI3M2lJWmdPdFBTSUg0ekhONE1mTGJ4ekVYNzRPRU9mZzdX?=
 =?utf-8?B?RWpCelkwVTBTTEc3VjQwWFdvRHdTbTZ1S0orb3NsdE84c2dmUFkycmUveGdm?=
 =?utf-8?B?YkJwNXQ2MFdhaFZodmV2S3lWay9NZVk2N3oxS2UzOVNuMVl4aHU2OE9MRHNP?=
 =?utf-8?B?TXFzVDZDSXJNVy9vejNkWGNwUXJjUWtCRVZ0TnIyREVvU3NlSVcrUjlJdFVM?=
 =?utf-8?B?T21TSmM1VVZOOGhNVTdxL0FOTmlYSnlqR0JWWDJxN0U1aWhnNFNwc1o0WU10?=
 =?utf-8?B?cUpQa0ZwaGxiN3lHUEY0dGdWRy84aEhhWlRrWEhMQ1FYbWIxd2JzU2kwbzIv?=
 =?utf-8?B?TDB5SmlLcEpMaGRRWVpETFZGYW8rdTlvdmpGN2Vpd0luajBGWXh2MHlhVDEy?=
 =?utf-8?B?NFZ5TlU5TmlHbEgvVnpxK1JmZ1IwNUFmcGJYT05RbVN1b05Scm4vaGVjUWN4?=
 =?utf-8?B?a0pMZUtnZ3NxT0owdHNqdVFsQ3VVSUJnSXlRVjdsZCtEaHJsVDJkbzZlRFcz?=
 =?utf-8?B?TEZ0OEZ0eG1DSzlBR1J3UzBrZVpDNkd0WkFFNVFPVW5vVk03Ti92R0VHYlhN?=
 =?utf-8?B?c2dlYnV3Wnpna1JSVy9QSlNGMnJFdkRodkRwR3h6UFZWc2w1WG1TRUIwV3kz?=
 =?utf-8?B?aENJN0lMUzd1STh0UGNmQnB6OExGbU8vN1lIOEY4QW9pU0h6L0FFWmxuMUpu?=
 =?utf-8?B?NDZubWpwOU5HU0NKY2dsWnN6ZFFBL1h5VHRieFVOTG9LbzlPMFF4OGJPL1Mw?=
 =?utf-8?B?eWx1emhsaW5zNVJnZWY3c2djSW9YYUl0WmwzWWhMN0d2SXM3TU1aRys5MzRt?=
 =?utf-8?B?Vjk1RkdIUGhNejBHaXpVdDRaejJpbVp4V2ZXdEZPS21Ba2dMZkIzZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47cab2e-c003-43e3-d0c4-08de8b4992ca
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 15:08:44.6484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UndHEVPiaC0OTkpOlDTNvy4OyJdddrCg6ompyY1RwnWQ80ExJbykEuKHZmVhSF92DCyoyUqDCGsSwkykYaRn6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB8018
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Mar 2026 15:08:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22585

On 26.03.26 15:41, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows to debug test errors.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  tests/templates/swupdate-test-action-M-COM.yml | 2 +-
>  tests/templates/swupdate_template.yml          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/templates/swupdate-test-action-M-COM.yml b/tests/templates/swupdate-test-action-M-COM.yml
> index 69c9cb7..f86c4fa 100644
> --- a/tests/templates/swupdate-test-action-M-COM.yml
> +++ b/tests/templates/swupdate-test-action-M-COM.yml
> @@ -15,7 +15,7 @@
>          run:
>            steps:
>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-x86-uefi.swu --output test.swu
> -            - if swupdate -i test.swu; then echo software update is successful!!; else lava-test-raise "Fail job"; fi
> +            - if swupdate -l 5 -i test.swu; then echo software update is successful!!; else lava-test-raise "Fail job"; fi
>        from: inline
>        name: sample-test-1
>        path: inline/sample-test.yaml
> diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupdate_template.yml
> index 9a3366b..d62d312 100644
> --- a/tests/templates/swupdate_template.yml
> +++ b/tests/templates/swupdate_template.yml
> @@ -73,7 +73,7 @@ actions:
>            description: "Test software update"
>          run:
>            steps:
> -            - if swupdate -d "-u #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.swu"; then echo software update is successful!!; else lava-test-raise "Fail job"; fi
> +            - if swupdate -l 5 -d "-u #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.swu"; then echo software update is successful!!; else lava-test-raise "Fail job"; fi
>        from: inline
>        name: sample-test-1
>        path: inline/sample-test.yaml

Thanks, applied as critical debugging tool.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

