Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2DDC4345F
	for <webhook@archiver.kernel.org>; Fri,  3 May 2024 16:54:30 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.74])
 by mx.groups.io with SMTP id smtpd.web10.18325.1714755262502002267
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 May 2024 09:54:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Z7gFwtfY;
 spf=pass (domain: siemens.com, ip: 40.107.13.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHWPYV0bRJJZmLbEZEJd0lxq7nt+BaLD2+8P/c6r3uPBRnGVRGsj0eVw5CCfBtT3WJVyb+vDtTA3bkvOtW6IfAH78wSz79CTWbjfWOzWqJiWTvt7cQgSXQQEpN8Biz50HVTNgy4mqwg0RnOlaz0v0ZLMCI0CvNFHm+83L0depQdCSaEDa0gAThjsNIhLHZcyfJzZb3QjHhiwicQI+LO71gHMTax67+jwX9odvSQULmjFH1A3Lrqg/SnGLaZ+gfwrHOm/cVBNOGiCanuAzSPgkBBzmwgpBVfCSDdfpjwmxexYj3gO0ijea8WYdK0IxKSXN5qlYSMNrCWWNFabThGgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VOkloD7/asBCOPUA4OeIadIrjcxRt5e6se9w623Nl8=;
 b=AgJ/3Hb1dC7kKG3xXF0MMH75VOcn5+djwJYnebYXLqLf8qT5e7UC2DzgykxAVWotMjNq7X6LYZLmQonSQ4nui+8TQa3DZEMyd1lMuaJwPUbG+fBqfKmu88kcBlI+5g/hUmwk5Sm0qSo3WvUPTBqX0Gqv9c3TqNDm40bWUtqHuFs5kQ7hIKsRN1o7OExwZr05hY4iYLdn0bItPbkcXHOdLfnkuLG4hoNiCRBWWX9pPjTrmuewbGt42Ahs9U2YEWdX2obebRtaXovkIXkd5vuEXomy064Ysn+sdcA45e09pDgAWWJ5gKkKMUV5rj5x3Bwbaxyld9xwQ1uO9sO32oCqtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VOkloD7/asBCOPUA4OeIadIrjcxRt5e6se9w623Nl8=;
 b=Z7gFwtfYJ5cKmpA8Lo22pActEY4X0JjJjL4doUiZq6fmYjjF01jE1ePLQbcxvaFOKS85rW6rgmhwmJZfXbx24pfoG6n1p16jFpDC9CnPxds1KFCGh3ZCXYnuG9OD6qixzQ09Fv5YTuZnzo+bYRSWMf/xExLtKkORYwfFWtTnMgp9CD9fbYWzaX3ofVQVlNwg5of0s4K+ODxTUIurLTNe8Myk0pEMRjK4fc1jK7c45dibNAekWnKNZxWDN3WN3LemQmwhswrYsqFaouNTc9W+hRDII++5bDRMIhj+U+UHuRw66xYS9Qgj/Sa71dl4iE72d+4E8HR0hHlRulib5WkS9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB7571.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Fri, 3 May
 2024 16:54:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 16:54:15 +0000
Message-ID: <045cdff0-0e76-4795-951b-ebdfdf9d50f1@siemens.com>
Date: Fri, 3 May 2024 18:54:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] wic/plugins/efibootguard*:
 Take --size and --fixed-size into account
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240503145416.663757-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240503145416.663757-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0407.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a3a376-83f2-4b9a-b1cd-08dc6b91aa96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S092Z29oV0ZGdm01dVpObU90WGtIbmY2TmVBVTN2VDBYOWg4Y1NYQWVmZndk?=
 =?utf-8?B?VUhISzBSUVduUnk1MFVPOEdSb0FtWWoxeExBaFdSSk5ZOUxmZWNpWDNINTcv?=
 =?utf-8?B?QU5VL1F3QXM3WEpaN3ZudEVGeW9ibTVFNnZndVd3bzA0Z3J0aWtEMnJ5TWM1?=
 =?utf-8?B?WG9SWm5SSmJJWXR6ck5aUXNRV09kaFRWZUxJQmwvRHhyMXlHRzA0dDdzUlJ1?=
 =?utf-8?B?ZDZvRVBnWEF0UklUSklhb2FLUkIzcmdPWVQ1bEZNZmh5c2oyaldxTFM2WmhN?=
 =?utf-8?B?QXVENFo4ZWt6UnlSR0J4QXVXaVNQYkdEeVdPNkJVUDk3cWsyVlJwSGxycGRU?=
 =?utf-8?B?cmxrcStaYnhsMjUrcHVWeHRveURBVjI1VnYzd2s2S1FwQzV2TGk2MERCTVpz?=
 =?utf-8?B?Zk5wUk0wLzZoUktqZHRTOFpKUVNsZzBiUjkwN1NxUHZOUk1RUWo0eno0YzN4?=
 =?utf-8?B?RjJYcVdXaUk1SjRjZDZDR2RCZmVaTHlwMFRGM3kyL0NtSytUa1dEL1pqRFFK?=
 =?utf-8?B?SWdaU3ZhOEphR3g4RGNMOXFXQkNHclRwN2dOY3lhdTFUVW9iZGZrOHBiVTN3?=
 =?utf-8?B?QW1KRGY3UGxLdVg5N1BIWXFEbmN0Um5oM0phUHdGaUVlZ1BpNEhZOFlsQ3lQ?=
 =?utf-8?B?KzJ5QTRHQWRBYkJtK0JKcHZWVlVpZUE4Z21GY3FUc3pFQmtCTDdxWXdPL3FH?=
 =?utf-8?B?aWhFYVlXMnVXVmJzS1pPRi8rZjBJdUQvWUY0b3dDTFJhZE9IS0hwVG0vUzBP?=
 =?utf-8?B?RE9HN2FEZkp5OXpFemgvejcxY1hDWXRFYTVNMlpENXJieVFzWkhXMW9JUHM5?=
 =?utf-8?B?WlB5ZTVPL2RLNk94LzZMZHFvSTdpaEJ3enA3ZHUyZk1OblZQaUp0THZ3alpX?=
 =?utf-8?B?OTZOV0ZDLzUwdnRJL1J3aWdNQUpSSklZQVA3a21yRXFsVWNsS1ZWRjFIRHdi?=
 =?utf-8?B?S2o3eXdQS0sxV1pRTitvbW1Vc2hMd0Z4WmdXRWZ0WU9MVlRINlVvbWpOSmRx?=
 =?utf-8?B?TTNNbkVwQi9KVTY0SVF2enkzY1J2LzluMHREYlI1MHltUkVGb0t3eVpNSHVV?=
 =?utf-8?B?T1E4dlpFU1I3SW1QS1pFK0w2eStpZTg2T0pyMnhhT29Gbk5YY1pHU1FJRzAx?=
 =?utf-8?B?T0N1YUNjdzh4Vk5PakdRRE1ZZkJ3Z3NxaVhYb05mdlBmZENoUnN0Rm8xUXho?=
 =?utf-8?B?SlFPL3BmSHovREk2NzA3cUZiUDk5Q0UxSDhhQkxMNTRwcVdMWitHbFgzekRM?=
 =?utf-8?B?am9HTGxpZjR4a0dUVnBwQTUzb3hqbFlFMWxtcXlocHlackJoVlRqekV1K24y?=
 =?utf-8?B?MFlKVU1hS3ZQdW9jQWthYmtZVUkrNXdYcnFxRGc2S0tEWmVpYzFhSlBwN1FP?=
 =?utf-8?B?aVR4bnljMFBoZHptNXl1K2QzdFZIVG0rbktoRnVQT1NtVmpOUGxlN3pxdHdX?=
 =?utf-8?B?WXdWZmpkSjlTZWNWNCtWWEF3QnJudFQrZUhjUmI0a2JwZlBIQkhvWkRpWEV5?=
 =?utf-8?B?b1R4dWhuVXdvMUdicGZCcWRkaDBvQ3AxOTcrVjA0MDRNVFVCWElXNWZkb1du?=
 =?utf-8?B?UlAvSS9tS3VWYTVmbkdiRTVMSmRxRS9aM0huaWVLdGFSME05aU0zOUIwdy82?=
 =?utf-8?B?a0tOZk5YVUIxbHIybmZFYzdoQ3IwL1E9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SHBySzBIZW1GOUdXZSt0OVFxVlNpZkYzcldEcGhxSVpNM0pwejRWcXd1dVJE?=
 =?utf-8?B?dHBGbFpQSnJ2bHRJenhZZEVCc0dMdEZLSzQwSHd5cUwwc3FJOVJleUZYaFBE?=
 =?utf-8?B?MkMwQllzdUcxV3RkeDZlRmRCcGhsVERVQkhSeVFQcUVDWkpCaWV6cE9DK3pm?=
 =?utf-8?B?d1c3YjFsWHFqQ1AvRXY4MVlBQ1FUUGxxbDdKY1ByUWx1MG9lNFRTdmxRMkxm?=
 =?utf-8?B?UU9wYnZCc3BFRWhESEgvQ1VSencrdEI2L04wZnZkbFd3VUVSdmduYUpra0xE?=
 =?utf-8?B?eUhqb0lxZXBiUFFVV21Lc0NOZGJUSDNoN3NycSt0RzFKdzlBYlFoZE1pelNt?=
 =?utf-8?B?a1RSMnhUcmNXNWIraW4weDBvbWMzelVGQlBwbnBrZ28wRGJGY05KMDNaNEFs?=
 =?utf-8?B?Uzl3RklaTFkvUmczMFNCeFRBNlJuVGNaRFZKbUk5d1Njang5Z3FqR0xCVi92?=
 =?utf-8?B?OFVrYmF0OW1XS292WU9iREE2WG1DQXlnajVuR24wek1Ncy90eDl2V3AzNFpz?=
 =?utf-8?B?UGZWaWU1THRRbWdtU054ZSs3UTJWd3BMNTBLWDE5dlNvUXIzUkthc2VLdFpI?=
 =?utf-8?B?NWpZaE5od0pmeFJFdXJURUlDNjU4ZVJHVEorNWNHWnlUR1I4WVo0aUNDOFBr?=
 =?utf-8?B?NWJWQXpUM1VjN0hkOGNzMEZsYStKUzFjWE4wRkQyaHNpSnVrRm1Md24xbDJ5?=
 =?utf-8?B?cXRBU1RvUVA3c0VraDMzM3FNL2tlalBITXZ5TVdjYlBiS0thMWdMUXBPekc1?=
 =?utf-8?B?VldzS0gwSTBxS2xCMHB0OWhPYWtwS2EwR2xwd3JKN2ZLQXJDUHA2cDlxRXVX?=
 =?utf-8?B?Nk1COTE3TlBlZFY4UDJoTE5LVVFrOGhld0lEdmdCNDRhankwaDFSTXJyUHZG?=
 =?utf-8?B?am1QVlBrU3hJclNMT2RMNWozQytCU013eWZOQ2doSm5NbkowOUVPOHRpcnpN?=
 =?utf-8?B?TnQ2UUZpZjRZb0VDSlBxaTZHbXNGQnFlNHp3S081WklUZ2hUQ21TSkRBYmp0?=
 =?utf-8?B?ODRDazVOek4wOHQvSkw4MDZyWDFJWGxOb2lWY0hHZWpEZXY4bnZlMXI5Z2NE?=
 =?utf-8?B?V0cyRWFZUXc2dFoyQTM5UUZFamhyRVRndnMrY0JGc29aWVVSMGl4bHhJenV4?=
 =?utf-8?B?dWcwemtuVUZ3dFFMdnJPUExCTnp1cyt2d0Y0SHNHbi81cURWMzd1UWlCZEJM?=
 =?utf-8?B?eXk0YUQ2QkEyN1d1UUJoZTNQK2pFTWtwM3lSTGZRRnVybGVlZFpsYWJPMUJE?=
 =?utf-8?B?dW1rNXVPYzFmRFVwRmRHbzlPdU9qSXB2dUIyb0piYUc2ZTQzbTJjK2VuTUU1?=
 =?utf-8?B?NVNweVlHbWlESndDQ3VYaHovOFE2OUNoaWxSc05nWjh2VDk4R2s0NXJTemM5?=
 =?utf-8?B?ZjJWMXQ0SVFpWUR2cmJ3ZTROSWxnM290cmwzZWJ1bm5oOExUczBmSjFFb3pp?=
 =?utf-8?B?RTNOWEVYaHBXYklaMjJSN3lDeUlBaEFvZzg5YTFUZDRsWkFBdktOZkxRU2FH?=
 =?utf-8?B?cXJkMlljdXYzSDd0MGVGZjdEYVlxMmFzNm9SQVpwQjUrQnFrdGRsUDhYdEJP?=
 =?utf-8?B?d2tmZGI2N1hDNGMyUUtJelBiTnZTek9Cc1pvaVREajh5a0dRYnpxWi9PWmVK?=
 =?utf-8?B?d1BPRlNmS05kWlhOSk91S2kza1c5eDdlSXV4TksraUIxU3RSL3NBc1VVcnZG?=
 =?utf-8?B?QUJSVkNXOWh0blViUVlpUFdXYVQ4b29Yem52d2p1TXdXQkJvNEM4Y1I2Q3Ni?=
 =?utf-8?B?dGRYOEZsMDFWUkpRa095Rk1vNThpOTViS24xL0NiOWtoL2NoRFQ3TXlHVDBx?=
 =?utf-8?B?dUN6VzA3WERGUlJuUndxKytiQ3NRcDFuMi9rTml6OXYyY1c0bE9JTzc2R3dZ?=
 =?utf-8?B?djFpWVJrdTdoQTc5TllZNnlzalltMlB0dFZ5aSt0bkJIelArUjh3anNpa25H?=
 =?utf-8?B?aUdCeTB2UVRnR29ITlYvZEsvTE1meG5KMVZkcWFyK3MzczBhV2ZuVVBBc2dO?=
 =?utf-8?B?dHdhUmRsZyt0SHBhdHhGR1hGYlM2TG5GUms2Z1NqRFVzeTZrd1BtTFNPa0dl?=
 =?utf-8?B?UFRralcreVRMS1NJQTlRZGcvZ3J3ak51OXh3RU8zVXF6cEJTLzZkU0JBTWVF?=
 =?utf-8?Q?mbpBNNKDyDy6ViOr/LyK5IVf+?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a3a376-83f2-4b9a-b1cd-08dc6b91aa96
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 16:54:15.7241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDyU9hsYPsq6TlffxQjev/uJMJ7YGwuTaJltHAmP5U+2q7GMZWlwUiAPxyK5HkanTiC5vq/uce5uS5GXip4OMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7571
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 May 2024 16:54:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15824

On 03.05.24 16:53, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes the issue that wic arguments --size and --fixed-size
> are not correctly interpreted.
> 
> This fixes issue #104.
> 
> [1]: https://github.com/ilbers/isar/blob/26e9653eb5e096e8b367ebd73054b2fd2310e9bc/scripts/lib/wic/partition.py#L104
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> I tested it with qemu-amd64 and qemu-arm64
> Changes v2:
>  - replace size calculation with part.prepare_rootfs_msdos
> 
>  .../wic/plugins/source/efibootguard-boot.py   | 37 +++++--------------
>  .../wic/plugins/source/efibootguard-efi.py    | 30 +--------------
>  2 files changed, 11 insertions(+), 56 deletions(-)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index 4e3aefb..1101f38 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -136,40 +136,21 @@ class EfibootguardBootPlugin(SourcePlugin):
>                  msger.error("file %s not found in directory %s",
>                              boot_file, kernel_dir)
>                  exit(1)
> -        cls._create_img(part_rootfs_dir, part, cr_workdir)
> +        cls._create_img(part_rootfs_dir, part, cr_workdir,
> +                        native_sysroot, oe_builddir)
>  
>      @classmethod
> -    def _create_img(cls, part_rootfs_dir, part, cr_workdir):
> -            # Write label as utf-16le to EFILABEL file
> +    def _create_img(cls, part_rootfs_dir, part, cr_workdir,
> +                    native_sysroot, oe_builddir):
> +        # Write label as utf-16le to EFILABEL file
>          with open("%s/EFILABEL" % part_rootfs_dir, 'wb') as filedescriptor:
>              filedescriptor.write(part.label.upper().encode("utf-16le"))
>  
> -        du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
> -        blocks = int(exec_cmd(du_cmd).split()[0])
> -
> -        extra_blocks = part.get_extra_block_count(blocks)
> -        if extra_blocks < BOOTDD_EXTRA_SPACE:
> -            extra_blocks = BOOTDD_EXTRA_SPACE
> -
> -        blocks += extra_blocks
> -        blocks = blocks + (16 - (blocks % 16))
> -
> -        msger.debug("Added %d extra blocks to %s to get to %d total blocks",
> -                    extra_blocks, part.mountpoint, blocks)
> -
> -        # dosfs image, created by mkdosfs
>          bootimg = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
> -
> -        dosfs_cmd = "mkdosfs -F 16 -S 512 -n %s -C %s %d -i %s" % \
> -            (part.label.upper(), bootimg, blocks, part.fsuuid)
> -        exec_cmd(dosfs_cmd)
> -
> -        mcopy_cmd = "mcopy -v -i %s -s %s/* ::/" % (bootimg, part_rootfs_dir)
> -        exec_cmd(mcopy_cmd, True)
> -
> -        chmod_cmd = "chmod 644 %s" % bootimg
> -        exec_cmd(chmod_cmd)
> -
> +        # create a fat16 partition with a sector size of 512
> +        part.mkfs_extraopts += '-S 512 -F 16'
> +        part.prepare_rootfs_msdos(bootimg, cr_workdir, oe_builddir,
> +                                  part_rootfs_dir, native_sysroot, None)
>          du_cmd = "du -Lbks %s" % bootimg
>          bootimg_size = int(exec_cmd(du_cmd).split()[0])
>  
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> index e82e990..48f7523 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -100,35 +100,9 @@ class EfibootguardEFIPlugin(SourcePlugin):
>                                                 name)
>          exec_cmd(cp_to_deploy_cmd, True)
>  
> -        du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
> -        blocks = int(exec_cmd(du_cmd).split()[0])
> -
> -        extra_blocks = part.get_extra_block_count(blocks)
> -        if extra_blocks < BOOTDD_EXTRA_SPACE:
> -            extra_blocks = BOOTDD_EXTRA_SPACE
> -        blocks += extra_blocks
> -        blocks = blocks + (16 - (blocks % 16))
> -
> -        msger.debug("Added %d extra blocks to %s to get to %d total blocks",
> -                    extra_blocks, part.mountpoint, blocks)
> -
> -        # dosfs image, created by mkdosfs
>          efi_part_image = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
> -
> -        dosfs_cmd = "mkdosfs -S 512 -n %s -C %s %d -i %s" % \
> -            (part.label.upper(), efi_part_image, blocks, part.fsuuid)
> -        exec_cmd(dosfs_cmd)
> -
> -        # mtools for buster have problems with resursive mcopy.
> -        # Therefore, create the target dir via mmd first.
> -        mmd_cmd = "mmd -i %s ::/EFI ::/EFI/BOOT" % (efi_part_image)
> -        exec_cmd(mmd_cmd, True)
> -        mcopy_cmd = "mcopy -v -i %s -s %s/EFI/BOOT/* ::/EFI/BOOT" % \
> -            (efi_part_image, part_rootfs_dir)
> -        exec_cmd(mcopy_cmd, True)
> -
> -        chmod_cmd = "chmod 644 %s" % efi_part_image
> -        exec_cmd(chmod_cmd)
> +        part.prepare_rootfs_msdos(efi_part_image, cr_workdir, oe_builddir,
> +                                  part_rootfs_dir, native_sysroot, None)
>  
>          du_cmd = "du -Lbks %s" % efi_part_image
>          efi_part_image_size = int(exec_cmd(du_cmd).split()[0])

Nice consolidation! I'll wait a bit for feedback on the original issue,
then merge it.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


