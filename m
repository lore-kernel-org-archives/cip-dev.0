Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E757C43458
	for <webhook@archiver.kernel.org>; Fri, 26 Jun 2026 15:27:58 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37559.1782487669497450876
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Jun 2026 08:27:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ex9WlDBI;
 spf=pass (domain: siemens.com, ip: 52.101.66.6, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWzrTNTPLrLZhky25MCzVBRpfnefwAKUPtGa1udng+G2ddVDqu/isIsTaa7PFnxMM1SmXZD1dSqcuUmGsTqkVEmlqs+RuSgr+1N4vf5fB782ezG1Xj8WRhIHxd1CZFLSDKV8xKsGhj805WH1AYNpq6LplFj7oeyrERiQ+LXBfoj9w4wzOj9vJuykS9q7uETDO+CsPaooqXazeICL7D9J89r/5WvXSHzXK5F2dzFygdqLaxbzKpOrs3gM52jGwAgRjnObOgpfvGhZwlQLLeAvS5tPW4uH9S12M8u56iRCwx+pvVJxmiOeFMNzmyY9ZLKYj/pJCYjkM4i2hIbDSM5k0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9r3RHM7/+H8D9BvFCRcPiaqY2S5DNDuxVqHNDX0hqA=;
 b=R3NnEmph34R126Q6lCJgH3n5yB26IWwtK+As/MKp/01zwmLXyv+14hJ06pM+HWHTh5/BJJAVcQI2ZDW5mV1JGBD4OcWkv0ItliLMPWHurkcSfVAjMiLOps+Yd42n69iF75MbOKwWbr1amMEReNfHGtWYlslJjSprKysypOgGXe93uqBTkxY4isk7JqFGQTk/wvltfpEb8J5UEeFwUeD1eWzYhjpLjHb7DDV5yl+EVjrc95Wju6EdsOU1zGxgR1dqZb7mWGoAaYGHka5K3Cf0tXl2tCcc+OnA5vaqskjYqi3+3Oxbd5UbYVFEAsJmUtuZzb3YsYB7WZgvU57QrnMLvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9r3RHM7/+H8D9BvFCRcPiaqY2S5DNDuxVqHNDX0hqA=;
 b=ex9WlDBIP7m+3zLLpt4CfqW/SVEW2wrnHykU9AhwMAaM5XXYVVXDldbhFB2Cr9aDax7oHZv3CZhiyDO8MtMzCOTfKqwEEJRwaW/LsL12CuQL/mH+KY0rrTC5mQHAGEnDjx29o2bqt1WMA7X1bbwcRfadrZruCBfEQ911mLaa988cQlJosN+ilzabFwrTEHRrLdA4M0gRe7zN/pMHol4ZJFZ8OGKW/B/n/ThoGuD6WCTaU0yszn6SxzOKcpBeOwRgRamrzCAadsABxHOmjojMyJePG3ypbEVqI1LTZaL5+7xnfUwmi5vft+iti36iIoNyozyQwDSKxHscHyoSSbq4vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DU4PR10MB8544.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:567::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 15:27:46 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 15:27:45 +0000
Message-ID: <c0a1c68f-5aa5-443d-b58c-f942dbf37ec9@siemens.com>
Date: Fri, 26 Jun 2026 17:27:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate-config: Set DPKG_ARCH to
 any
To: cip-dev@lists.cip-project.org
References: <20260626152038.103044-1-Quirin.Gylstorff@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <20260626152038.103044-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::7) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DU4PR10MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d92eb5-d280-4993-0342-08ded397791d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|366016|4022899009|376014|56012099006|11063799006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	FMSdxu0eFPwT67lV6AT+yaPAlYb8wOjMBhXI++kU5s4LRgcP1Lul4zuUmAz/kM73M5LzneGGSFVD1w5iBVLGHmqlf+z9QT+6G2gPLelDAWoSsJU4JLwGIzRQWESK7YqVlhdpuoZ5OlzgE/mbiVKkxQ3CxvKAefvqkXXLxgDWzdJJozP2CbflYOmDf1laq40PWxyCA4u5sNUXms/bKde3U7lWU8CiytZe+vaha46xxT2mAaJET2Bcq5mkbwW49btEPgVzUYXQ1dXs/TVTlFjTLiKE4S/uOEI0FU2pbfvzFNiTHTqJyRTOpZfTArUtmAFzZMVVAUDjLUUyKfIaDFX2BzOQv5PGMbesOl9UY1yGt31EKnxh4TWXg8yBP1/fBXl4RT5n+BeW3Wthd/zpzTGjUKCJsKyfDlHeDg3DGMy7BsNfsHob/2t1OOXWISGFPfTsf5P+FukyuUcZlD4Gbu/Vu6hhsUbUCuqf0Uv/jK4hn62/5icWNqkmCucJtgGEULVagIryBPkU2amBoVa1EKP2/6QCzQO7+09vcgfsJEeCCHp4e65sbaI2FGjAGYn+c31skHTGvwewdPRKyisnc25toFhGmw56/nVHuJjR90Wa/ihRMBa7JSAljHz+kR6cYq/V
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(4022899009)(376014)(56012099006)(11063799006)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VldqV0RPMWl2MzV3UVlnbWVqa0owQytPTnBkd2VselV0RW8rRTVyb0U4NXIx?=
 =?utf-8?B?TVIwQVV6Y1hGRlE1dUp4WmFHZFVaRlhROElTZXJ3aDUxYktEN0RFa2JTbGR0?=
 =?utf-8?B?dlFMVXlNeERzYVhoUTNuT0t5ZE84RzZrbERGT0VaU29maUZXeTkyeUdRYnRM?=
 =?utf-8?B?MzViVC9xcTRIN2RBRVdWMS9FV3hMWWQrT3NjcXhIWU55U3hlNFZmN0VKSXAy?=
 =?utf-8?B?Rlh4Y1Q0QUkyWHdWaGk2ZXdMc2wrVnZnKzlGMkVWR0ZQdUpjV1IrRnJXS0xj?=
 =?utf-8?B?a0xXK3RCQ3dZNno5NllBam9Rckw4d1gveGl6dFdMMlJPVEJha29EUE5oUTND?=
 =?utf-8?B?OWtYUmxMNm96S0cxWlFRNkNJbURWbW9NMkNNMHErVFA3TGdnTzR0QWZWV1I1?=
 =?utf-8?B?THlCb25rR2xlWUI0cDlLM2pQVHpqTWpXaUFmL0oxd2VNcFE2VlpiRG13RmE0?=
 =?utf-8?B?NFplQ0lYNmp1dGhQMU9BTy9WL1NNOEVublZrWnc0bGxWL1VIWnB1N2VRajUv?=
 =?utf-8?B?eW9iK0VoRTZrT28vSVByV2NFeXI2UUdnY3pJNktMOWdzNFl0RnlkLzU3eDJp?=
 =?utf-8?B?TGJhYVU4RVMxZWdBMW56SHo3ZVhPVlJwUWZVaURvU1RPZTdxL0FTL2xtamFy?=
 =?utf-8?B?N3loQlV3RGV6alUzUW9GN252OXhFZGZtRnJwdy8rTjFoOU1ORE44RXNQN2kz?=
 =?utf-8?B?MWQ4L0ZoTlFwRWJyeitwWHJyZEl2ajVjTHN0c1JpVXdXc21yUmtFN1BqVWlp?=
 =?utf-8?B?ZnZUUkV5SS85SnFvVHpTbjMzS2x2TE1ZYWQxditrV3RkdXgwekczdncwTEF6?=
 =?utf-8?B?ci9XU0xXSDJOOE9qbW51THVQQzl0QmIvek8zMVBodU10eG9ZYWwyY21aK0N1?=
 =?utf-8?B?TDZnaitwZnk3WXB4L0hSUmM5VUJDMXJXMDdmMEpUZ1krbEV0U1l3Um9xNVpo?=
 =?utf-8?B?ZkZxTEUyaWh0R2tOdlNQTmdmeDA0Y29KOHAxQUJLK20yd1hIakZJaGZWMHRt?=
 =?utf-8?B?a003NVRtNUd3dkNpRlR2V2grYWVXSTBtYjdzUzNGVmc1amtiTHdoRG82NDht?=
 =?utf-8?B?OEE1L0tOUlBPcWJTcnBqUzk2SWNVWU1MaysySEhnM2pxa3hhQ3hSaEpaYTQz?=
 =?utf-8?B?TFNvTkF2ZzRhSXdPSVRpZVEvS214NmQ4cHFCcFRaeStQTVEyeGNERnpiTkR2?=
 =?utf-8?B?blhaRXk0VDMvVlJwdUpVRjdza2ZnbzdHalgvaWw4UzN3NVNLV25TNCtBK2Ev?=
 =?utf-8?B?Q21qY3hOUUNzbXF2d05TYlQzTk9PSlR3amRhOGMxdlZreGNYQW9LZTZBTFRL?=
 =?utf-8?B?TkFCL005RUdpbWphVlFYQTNseTdQYS8xVUF6TG1YR1dRQXI0N083Uk1mSFpZ?=
 =?utf-8?B?OS8rMkNxYWkrMUlvS2JNZHdvM205WEo4ZXROL1ZPTFNCOUFmZkpLSGNHdjZ5?=
 =?utf-8?B?Q0FxVmhSQ2w4T1k3blVSaks4cDIxN0dKemh1TVpBbFFncjRXSHB4Z0g2ZFNs?=
 =?utf-8?B?WWtGdm9zc2dWT0VGOC83Z0puczVsS3FEdzJnaVhsWVRzSmtlOHFKT1RSL0d6?=
 =?utf-8?B?U09pdVRldCtsTE4zNmQ3MFBwY3NLTHlPYVVzUndTQ3cyMmRWLzFoMWtGRmww?=
 =?utf-8?B?MTVwOURBQ2M2Vms2VThWSWpseG81b2paVFUwSy92N0ZuOFF1SC9ud0VQcURC?=
 =?utf-8?B?NVQ0UmxIR3NwQmNDS0poV1hjTENmQjJsTzZPQ3JIVk1MSjY3V1lmckg0THFk?=
 =?utf-8?B?THpRdmpMM2Q0SFpPNkZYdHFWVmgzc1p4UjRQcHlUMFdxMGFvRm9Pbjd5RVlQ?=
 =?utf-8?B?dEYrTlFQdWVrL21OL3A3Q2FPdmRGcmhUVU5qNHNjU0tlbUZwcHlJZG0walZh?=
 =?utf-8?B?S1YveEd4UW8yYThXcW0zYi8rbGZVYzBOZ01UZzk3ZnB2M3B5eDdTa0xqUFFE?=
 =?utf-8?B?VE1BWnVoY3dJUkRxb2ZDdkxWd2Q5NmIxNW9tK29tVkZ2S3Z5UTNWVS9FYUEr?=
 =?utf-8?B?SVBGQnZodnBkeE9vanNSREJPaVlEYmcxbGJ6MmFVZHhNZFRodm11YW5BY2Nn?=
 =?utf-8?B?ZDFVWTF4c1pRcVc4S0I2TjFxQUpXTS9TNkdJYzYvMEo5bk9Hb1U1eFBNMjlP?=
 =?utf-8?B?WkZhcjVXZG1uaWF4b0tLcmRid2l3RzhIbjBKeCtleVN4L1JaM0Rhek1zL21K?=
 =?utf-8?B?a1l2MVBhNTNRSUk3OEJiaEFHUE1vN3ozajhGV0JqeDVmMnY3V0JMclJVVDZo?=
 =?utf-8?B?SitDelZxQkkwNWxISnpnenAwbCtqM0JUMG12cmJ4SjRxRmVlT1RUbStibTJt?=
 =?utf-8?B?ZkxYV1NZSmlSVllaSnU2eUxnM0Zjc1pLVWJxTnowdlhPTkU4a3BzeU0vdWRO?=
 =?utf-8?Q?itRnHYw7p0jS6SSY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d92eb5-d280-4993-0342-08ded397791d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 15:27:45.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lu4vnhabG95LZ26pUFF5EaTuRovMOPnB2bdl3bXlV+xpRrnk1lDrsuBHQgF9mf2xAt5/1bvOkQheR72Zm+2SGfItEZ/rzLuCGnnR2Uhll/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8544
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Jun 2026 15:27:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23284



On 6/26/26 5:19 PM, Quirin Gylstorff via lists.cip-project.org wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This avoids the following error.
> 
> | Building dependency tree...
> | Reading state information...
> | Package swupdate-config is a virtual package provided by:
> |   swupdate-config-qemu-riscv64 0.2
> |   swupdate-config-qemu-arm64 0.2
> |
> | E: Package 'swupdate-config' has no installation candidate
> 
I need to send a v2. The error occurs with Debian sid when you build 
arm64 first and riscv64 afterwards. As a virtual package with 
recipe-name is created this leads apt seeing two packages with provides 
the content as both packages are providing an _all package.

Quirin
> This solution works in this case, but to confirm with the Debian
> standard we would need to add a conflict to all other versions of
> this packages.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   .../{swupdate-config_0.2.bb => swupdate-config_0.3.bb}         | 3 +++
>   1 file changed, 3 insertions(+)
>   rename recipes-core/swupdate-config/{swupdate-config_0.2.bb => swupdate-config_0.3.bb} (90%)
> 
> diff --git a/recipes-core/swupdate-config/swupdate-config_0.2.bb b/recipes-core/swupdate-config/swupdate-config_0.3.bb
> similarity index 90%
> rename from recipes-core/swupdate-config/swupdate-config_0.2.bb
> rename to recipes-core/swupdate-config/swupdate-config_0.3.bb
> index b48e3d1..013b957 100644
> --- a/recipes-core/swupdate-config/swupdate-config_0.2.bb
> +++ b/recipes-core/swupdate-config/swupdate-config_0.3.bb
> @@ -19,6 +19,9 @@ DEBIAN_PROVIDES := "${PN}"
>   
>   PN .= "-${MACHINE}"
>   
> +# architecture specific package as it depends on the machine
> +DPKG_ARCH = "any"
> +
>   SRC_URI = "file://swupdate.cfg \
>              file://hwrevision.tmpl"
>   
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#23283): https://lists.cip-project.org/g/cip-dev/message/23283
> Mute This Topic: https://lists.cip-project.org/mt/119991285/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


