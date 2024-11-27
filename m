Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C57D609A6
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 06:52:58 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.49])
 by mx.groups.io with SMTP id smtpd.web10.66373.1732690374281316315
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Nov 2024 22:52:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=k8eTiIv3;
 spf=pass (domain: siemens.com, ip: 40.107.20.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJTJPyS9yA3o7bMncm1kmigPSQsUnEC2npHzDA8azeowuAl5HfQWn4wH3LIjk5LpkEI2HgCe+lI0JflvkVaxBpdYbJ+PUegAeNqhD8CHNyZ/0dhBoHV1gTAqDMa/svkotDXyomCqSQoXmLUsa6WXBSckkttgn3M/j1Rz5+hApg/JGJ2nbaamej+wgfgF3WFXUtvrm43XNpg8xHtoJ0dUr10mjJuSeX9tfdSNLokHymyLL/QqTlRphaYmbAA0TFaL4Ub750/a2Fhhwgskc73lVDkxJ2CUhK8y5xhkpUd+vEbpW574X+7n/rrrEnqsFkyQiyQvHe4bSXNJXJkD96YGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBcX+JrY1NM7WCQzJU4cCSm1KP+JkSOpDvVHVZIgloE=;
 b=ZvU6dtpdUNaEF71aXAVeiOjl+A2raPYfILEu9KhXcbqhl4+T5Cc7YXEexbK7wGIekWLla4TQydvV4Ajyp9QvZ7/0iyqSbchnpwy6ORpWvDxO1MEt1T5T5Q7PiyqV4P13AVTJ2HWu7q28sDJaTK/5JOWjd0+Dp/ui81e1sukY7BelObC9bcA7uqzqA4hGZFBr7x/okVVdnlyOUHE4qqXg+sPsSIBKPqEfiGCS9V2diKHdlsvGUGT7++tTTYxheUFv0OaY3wOj4JVENBqA94++ivlxKZ6R9/yWPU7lB6e7FG2wOhlhwDa8DmdEUuPVxMrDIVTyPGrpOMmnRQpweU9aFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBcX+JrY1NM7WCQzJU4cCSm1KP+JkSOpDvVHVZIgloE=;
 b=k8eTiIv3XbwEvZimPuDkcm/VhOGoihLHvedLFXkqIF8zvYic4cn3JNxazis/Sq7kJVSvZGl0RZwxHTGnPEVx93AavAE1RX+ebP/NBSWJd6iNZ0C4D0YV9OAZ5o9Tb8LIn/eux4lxbt5s/3TiavqRgnObTIk2VcL5MeQxC+8kVeC99AXPyjBRPCFI9emaYvxLUTs0SmYZS9oUej6hq5YmusHq6z5n2ueu6jlvoJGEcd/Og07LWhzj3DotgSoHbUOyNcKenlwoZ+TLOvIazPcJFoKm8E6OdluGGR4NGjuOYynG33Y/vnUT/Exks/P10v4+Rwcj8SYnxhsW1QnMqiFdvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6650.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:564::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.11; Wed, 27 Nov
 2024 06:52:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8207.009; Wed, 27 Nov 2024
 06:52:48 +0000
Message-ID: <150e80bb-129f-4393-9967-e025d847c494@siemens.com>
Date: Wed, 27 Nov 2024 14:52:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 0/2] Switch qemu-targets to
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20241126151751.1747275-1-Quirin.Gylstorff@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241126151751.1747275-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed8d7c0-c82e-4aa0-f1d3-08dd0eb01afe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bTN0MXFYcDBsUGNBZDh3bEZxZnZrYkkrcTVEMjNYcXFCaEV5N0dsdVcva05J?=
 =?utf-8?B?bjRUTEZzaG5zQkpaaFRKRVBLVktWZ0hsTFVJT21TRmZMOCtibzRTcXBVUmJ6?=
 =?utf-8?B?SnpXQWw1cFdKdXVRa3FFUG5MYThPRkFjOE1hZDUxU1FJZTRqSmMwZ2JhUkZT?=
 =?utf-8?B?L05wZzFadHpHZlFKTDlyalJpckE0WERkUW5JOC9ON3dhRFJHSDJkR2hsclZN?=
 =?utf-8?B?ZFZtc25sckhHR1lZWjNJQkF6SlRoN3pGUTdqN2RqVlpvS2k3ZEFENmpFeVhr?=
 =?utf-8?B?QTNFV01uVXVaTENiQU5qQ0dhajNvYkJhcFZJZmNEaDRQQUhxdEpJZUtTVGp5?=
 =?utf-8?B?bnFpajRqZlFaZFN1RXlhMXE4UlhDdTBlSVZqYWJad2lRbGlmTnc0RXEwZFR0?=
 =?utf-8?B?bS9yVDFESTZUWHFlWjl5bzc1RUFPRXdlcHpOcDU2VEhRYTZMZFc1Z3FoczBu?=
 =?utf-8?B?YTF0bm1tcFUxZkh0NnljSzM0Q3picWsvZTlwRHE2d29sRDI5eXJOeWM2U3ZY?=
 =?utf-8?B?N0h2VnFmak5haDcxdjd2R09hcUNlSm53UEl3bzkyOHBkVE1SVU5NZ0F2WGo1?=
 =?utf-8?B?QjNzVlNlWkZKUW5FL2ZwZEdjdVB2aUNLNUhGWkNjL1JNUzg3c1BNK2pwNUVl?=
 =?utf-8?B?L3UyZmRqTzExbkhrQTR6WmVGalNnUUxtcEdvQ2ZweHBQRzRVU0hEQVFScXI1?=
 =?utf-8?B?SmdjODFrN1lUVzJxUFVUWkpucEQrUzY3amN3TE5MVW1vU0ZTM3QwUmVyNzRK?=
 =?utf-8?B?Z092L2ZDaDBpcDRReFF3MTQ4cHoxa0dLYXBmd1EwaFlQZ24rdVQxelRsak9s?=
 =?utf-8?B?eGsvOEJSUUwxS2lROEk1UzBrSjVXcm9tYU1nZ0VwLzkyTzlQSzlmUER1RHNQ?=
 =?utf-8?B?NVhURnFhNGM0YkZVZHhaVk5ubGdKUHVVVVdNOEFOb1RCU2FLcCtFWHJkT3Zz?=
 =?utf-8?B?M1lUeE1Fa1dvd2dzTmE4YVJBVlV1VnJFbjZrMExBclJCTlpaMXgrZ3JSU3VB?=
 =?utf-8?B?amt0S2tNampmbGNJL2JKU1JXejBHNVdjakRHeGRYU0lKZmlnVnZLdXhRUFJT?=
 =?utf-8?B?MmJTRGl5MzhXdnFicG5IcDBnTWU5YnkvS0tJN0dpekJPUGJvR1Q1NDdYSENZ?=
 =?utf-8?B?Z3Nyd3c1c1JPTnVVYlpZLzFvb3cvTm5GTXpzT25JTXBjOTNDaTNyLzZHUmZR?=
 =?utf-8?B?T2xObXJydVBaMjR3cnk5bTVGUVlEWTN5dlQ3YXdZT1lqcjVXNFJHYlpIazN6?=
 =?utf-8?B?emdrQ3RKMjR0NWhCVnVPbjJkeXZodlM1dS9MQkdXdm5KWnptdGNWelNYYnRi?=
 =?utf-8?B?cXR5WWdqV1VCRGNsYWhrNmZHVWtZYzRvUHAwaitvZU9lYWlINDFLdUVHN2Vo?=
 =?utf-8?B?aE05YnlnOU5vS2REWi84WXh1eFFxOGxZejJ5dkVTenpucUo1V09vaThDWWZP?=
 =?utf-8?B?Vk9lTWJYR1FiaVJPNnNCRVBUYzNYajN1SEZDYkhoUXlvMEdpNmJtNmZTaENn?=
 =?utf-8?B?UUp3ZTN4VXFuNjlzdUZjc1R6c0llRy9JanRrN0lobmloNWJaTVAxNXY0OXBv?=
 =?utf-8?B?cG82Y1Q1dkpVZ0NZc3NxcWorRkdHTUp6YnROd1ZLWEtYNjdLUHdwT0IrM3Zo?=
 =?utf-8?B?a2toVVZMWC9lV0hHckR4d3JWU3htWHVxbkdxNFdXT29nU3VPQWR5WkVHc1Ra?=
 =?utf-8?B?K1hhVW4yS2F1MVVzamVzMUpiWG9DdGc0UWtROGwrUW5HNkNldG1JdWppRHY3?=
 =?utf-8?Q?91q6KR/T3eLBfObF4c=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZGgwcUU5aXI2ekZtQ0hpZU12bjgyOHlQSkJwbSt1YmNJNURrY1dISXpLWFNs?=
 =?utf-8?B?VVNCeTBFcmlLTGs2QUFFUGxWR1RkODZoYkVtSXBRV2dURDl0dHVVRDRXZ0tU?=
 =?utf-8?B?RXpRcjV6MzRWWVVlVkpDeWJuQlk0TGZrSE9TT1p3MHZXTi9mcVYvUVdtZkpa?=
 =?utf-8?B?eGREd2MxZFlmT2dlYmhGRFpZcU5CRXNRa3JLeE92VW9NRVM5TXd5VHppQkli?=
 =?utf-8?B?U2JXZC83cE44eDIvRHlOaXdHWkFxVUtncUY2UkhMUVQrTmt4RmZudzVZd0ZU?=
 =?utf-8?B?bkxPK1RRVXZUUGkxdzkwYUpNaWNjM2ZiZktmalNEQmt2ZEZzN1QyODlDR00r?=
 =?utf-8?B?QWdFMkNWNjJrT01GeFFkeGl2cGJkclEweEZFa1JyN1A4Z2ZDdFcxU3BOOERW?=
 =?utf-8?B?eGlWZHlqUU5TMldRS0JIakhZbWtRNEVFVEZvRXRkWHlwTlB0N1JUZDVpSTJm?=
 =?utf-8?B?UjZQZ1h4Z1gvMG1aZkNjdmlRRWFXOTYzRHlST2lSKzJIb1FlR0JndStva3A0?=
 =?utf-8?B?cGtvZG5SYUMweVMzQ2dIcyswa2JiSmRaWW8waEhaa0xhOGpWY3JNcUtOQ2Jl?=
 =?utf-8?B?dU4yVUlQZEwrbFordEtOcEFpcCtHYmo4aUduR3A0SFZMVEViQ1IySkplYWc3?=
 =?utf-8?B?YThiMDVDN1ZVUFgyQnM5VjdvZjIyTXkyczRCQ1N4MWJJZEk1SmlrZDBsVitL?=
 =?utf-8?B?MlY0clI0NU9vYUpVVjMwY2dNYUdUQ0Rmekw1Mm1PaVlNcjB1NE5tLzRpZkQy?=
 =?utf-8?B?dEVnTE1QbnFMSGRKOFVxcno3d3N0ZGF5cWFxNEpFalpRM0I1REw5bTVZVVBa?=
 =?utf-8?B?NVl6dy9sNVp2RjdHc1A2anhBQXNDazJCL0ZXK1BnSGFYSjZKbFJ3V0xmeXRq?=
 =?utf-8?B?WjVZLzN2LytGelFyL1UwdXBBS1VoNUlpY1dJaWdNellHaWVZQy9kODNKQmJL?=
 =?utf-8?B?R24rNUhZR1N0azlyTVM1d1d6Qkk3anp3M1AzVjRWT01qTldzeUpQcENMeVl1?=
 =?utf-8?B?NVJkTzZ6WS9qUVhsYXdESllLM2dPajBxeG9qajAvUUxwRGdUdkdOaVhRQlpX?=
 =?utf-8?B?L1hQNXRCYnZwVlExTTh6WGg0Z014UzY5bS9nL3l6RTRSMU4rRWwrUDlSRHNh?=
 =?utf-8?B?Z01hNjR6VmFlYlYwL1NVWTRNekpnQjRCTFhVcFQ4NlZhOFAxaDVNamVRZTdr?=
 =?utf-8?B?VHo2Y1lZazBuOTFXZWRNcEJuRXE0V0NackcwQXhnYTlCQWdSU0YrUTZpUTJO?=
 =?utf-8?B?MGdTWXdwb2U5NUhUMlR5bXRnSFhETHlWZ1dmWXVMTnBidWRWZlBlZHU2WWhW?=
 =?utf-8?B?aXdrdXozYWg1VTNseTBJUlc3K3VhZkJ3ZmxQS2VFNU9GZUpvL3lxWGd3OG5m?=
 =?utf-8?B?WmVSVjlMSlYrdzBVVnVoSnBROTR5Mk1KN0VZY0lYdWxFTGJhNDB6VWpJUjB6?=
 =?utf-8?B?N2J0dy9ncnphSGVPL0hBN3RLNHZXWVYzQllOQUVzdmEvNkNBZDVtSEoyQnJX?=
 =?utf-8?B?RDRkcUp6M0xCb2kvNmNpNkpSeGE0ekk5cWlwdHNnQlFNdXllOVRBOS9OaUpl?=
 =?utf-8?B?dVJZMzJNUExvS3Q4ZmNpUGltK0dHSStUU21jbnpKQ0tveGZROE5ybFpTRWxV?=
 =?utf-8?B?cDBtOFZQZ1dOWTAvWk9hdnpKLzd1NE9pWHllVXdnSHFzaTBsNGQ4UjNSV0lK?=
 =?utf-8?B?dWhibEhZazQ3V2R3VlVHTlFabkloTTNDMk9IRnRTdzk1SlFoeEE0ZUM5bzBW?=
 =?utf-8?B?ZmtYQ2dVNE1qMUNBbDd2OTJyWGs0Q2Y0RklOeUhkYmRxcWI1WW1WaDBBTmFP?=
 =?utf-8?B?eS9COFhWOFZYK3JDQlhwR00xR3pEVWJ1TUF3a3I5clNkV2FIL3JMTXRyMWZ3?=
 =?utf-8?B?bnpFenhVeFhHNXFiSTA4NUtSMm45b2poVEcxb0NFN3pXU2NIRitJUnRiQkFx?=
 =?utf-8?B?ZlhrM0VSODgyTGY5c04wS2NkTzYxZW1LRjNldyt1dCs3OGFRSUk2YjMwbmJF?=
 =?utf-8?B?bUw0eTNSa3pJNHlYMG5FTGZpL3d0NWlYZ2VpNFFNUmxneFNCTUV2ZVphYUJP?=
 =?utf-8?B?WkxtaGM2azFNZTlRWGtkVys5K2JnRGFZcVpmZ0ZzVUh2TFJZYTZBZEQ2eDRy?=
 =?utf-8?Q?v/eld64LlpFczpPV2k5nLO/CH?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed8d7c0-c82e-4aa0-f1d3-08dd0eb01afe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 06:52:48.7480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FhWf1ddJt6AtRm73xkoDIhu2comHcYx+wZqg4A9F/F2kF+9JEr57A88C410fgwWEP0CfhPfaPT68K+3TuFzUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6650
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Nov 2024 06:52:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17286

On 26.11.24 23:16, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This enables the cip_merged_defconfig for all qemu targets to reduce
> the number defconfig under test. This is a followup from https://patchwork.kernel.org/project/cip-dev/patch/fa83e565-8950-4ca7-837b-1c513a119bfa@siemens.com/
> 
> 
> Quirin Gylstorff (2):
>   update cip-kerne-defconfig to lastest version
>   use cip_merged_defconfig for qemu_*
> 
>  conf/machine/qemu-arm.conf                 | 2 +-
>  conf/machine/qemu-arm64.conf               | 2 +-
>  conf/machine/qemu-riscv64.conf             | 2 +-
>  recipes-kernel/linux/cip-kernel-config.inc | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 

Thanks, applied (after
https://lore.kernel.org/cip-dev/14e07f5b-e464-4a7d-89d6-b53d5d7630b5@siemens.com/T/#u).

Jan

-- 
Siemens AG, Technology
Linux Expert Center

