Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D82CAC58E
	for <webhook@archiver.kernel.org>; Thu, 11 Sep 2025 16:09:23 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.37])
 by mx.groups.io with SMTP id smtpd.web10.1525.1757606960790388057
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Sep 2025 09:09:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kJ8ToVuM;
 spf=pass (domain: siemens.com, ip: 52.101.70.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGZ6/+u9ziYjvurtiMaijgegAlkZDFJ7sDUH9C9pLHkkv9cz5+nT2dOkdFRy1G1scDpasEdlgm08GXSost/g8fklTobiqi+4OKFE4n7CzEpY2O32+O+gT9UnnGiHfE/63DPeKYg9y8E5s3/Ja2NFCB/w1nTPAqHFggHev7ovxfbSm7P3XrmX2HWtXaTTPaDgxw7N+BxiWKjOxRwtIu9JfOsysgN7cSjH5Vn3qbtR3mZT2bingFIsQtwofc0cHpSXQqZ7xo6/svmPdrOPJO5l3N2OLzWCFDCb/drJ9sBiq05+X+4yBUDNhCxxXmdw6VmJ+BAyw3ot3GAw4bywmkNsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXffO4WONfYtO9F6oX8B+xhI5LQ+hcxpb2tWcZZ7NGo=;
 b=u892rc9j6ptCS66rRc90bHgM1YbnKwuKcYmZD4JfPhJFFhssxFqNH8qMRT4VV60xS/Dbdn2lBPvxM1MODS/e2XHbOAWs97FnDksq9qYYwyYtsgXhJulsHl5AosVr43vvWr03oxNUCL3kA4fZwsUKJn5cMbWH0pJr+92M2G8Ey0VDOuWRQcrbQiKlUsGYLUX5+L5sz5uy5p3grAom6ffLanOB/oyxGIZORAQptmRvOgNCDBKcK0dSD35welkSgq+3wEL7HfcNsTxbKIR+SLbj/uJO1XLf0u5q6QmCUxFrrAq0qy3GRv2qSNYkEtwZjKvk+8A3xBBvuM9/ddwdHliD2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXffO4WONfYtO9F6oX8B+xhI5LQ+hcxpb2tWcZZ7NGo=;
 b=kJ8ToVuMB9yqsS2ubiK/R2KFxdJG1f8fhes/jTDKftXwT0XrMgadsoShC2AHvGunoH+KqGr7MdOoKj+WPKv44e9AFaWs+F60u2zKhurh7lDifQ6BKCwi2JR+3cP6TBl4Gq4Y3CuCrNIdv9PucdxHsePiVzMpQzcC7GzLzFXSFn864hy27taiZFWe3KiAmPDJhapR3NhXNnEaDr+gR+yhf/xT45RPXJSTbAuzb7ZNR5P4lLBQa5WCHYB8vY4TLMGqnmCHb+L07f2kCGMqfzn9DxK46n01Iha7s1+o+hzM05XMPBUeMX9+Fu01mWX04D+p8/2vnZgwuRHIAEop5S7h1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4097.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 16:09:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 16:09:17 +0000
Message-ID: <fe05ede0-4c30-4100-949c-077f2ace0111@siemens.com>
Date: Thu, 11 Sep 2025 18:09:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 1/7] Add factory-reset-helper
 to set the Marker correctly
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250904095231.2039819-1-Quirin.Gylstorff@siemens.com>
 <20250904095231.2039819-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250904095231.2039819-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb5cd8b-89a1-47cd-b6e9-08ddf14d8ef2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YXBpK1MyekRiRXJOY1J1WitnUUs3b3VBUWRnNkVTQVNFSTBwMnpYWFA4Visy?=
 =?utf-8?B?UWtybmJQanAvTnpQWGJYVisyUUpVbVBhVDRrcmRqcnY0dGtHelJ1MytZZG9J?=
 =?utf-8?B?VnQ0UnVUbjZXdGdEcms4NjJaS05IeGJ5MldyQU40aVJaUG9RdFJ4Z09ySitO?=
 =?utf-8?B?ZkRvU3RHNmNjZDRkak1aOXUwcE13T1EyUW5BR01CeUtsS0RFVWJsVWZBWXA0?=
 =?utf-8?B?Vk85WjlqQnpMNFhlZU1wREhrZnpnNmw3SmtpK2pLWnFSYmlRcWdkKzBhTjd3?=
 =?utf-8?B?b0xIdEtaY1BxZkFuUkloN0Z3N1JDUVZqWS9EZ00yNEMxTjJWdzlZL0x5dlRC?=
 =?utf-8?B?V3ZCMnEzbkIwTm9ua3oramtjWnVDMzVUckFwMEpFTWZSNnM5emtVZnRucUZF?=
 =?utf-8?B?cFlrVXVodCtqVVd3b0xjTFB0R2ZXVVdHcDBaMnpiT2lQdlRxRDFJQUFSTXFz?=
 =?utf-8?B?djBaQ3JPblByWmxFSmluQWNycWwzbFZvZElHNnBCNmorQ0ExRURHSDV6bnJ3?=
 =?utf-8?B?aHUrYjc3Mk5EUzdjaFJZaGNGQUl0TWZvZGNLS0U0aUdQVFVZSmFBWmRqVDVy?=
 =?utf-8?B?UGhTSVBRMlBVUVhYeFI5cjY2amx2KzExcU9DeklScXhDeWJDendpNnV4SE80?=
 =?utf-8?B?QmdKZTVzZ09MSXpXaU9PK0w2aUpnTFAwRlRTaWZJU3NCWE5UQzVSYWNqcU9E?=
 =?utf-8?B?M3VPNW1kdUl3bm1ReE9Bd3ovNmUwVE5zdDNPdWIySW44ZS9FZk5QVHFJZ0Zo?=
 =?utf-8?B?M1loQUt6YnJpZ21mRzJKWnFRaC9IbU1aWnB3cXBNMS9HRWxyaDN4am9iNk1r?=
 =?utf-8?B?ODljR3VlYWIzcE5UTmEydjRHSi9hUy9TQ3d0SVlYRFlpUlJic1VGNmNYT3hj?=
 =?utf-8?B?WlNRS2FiVCs1K1BnOE90UjJrMGVCbXNvWEdOL1FMenlrWFlaMk90Sktjb25Y?=
 =?utf-8?B?TkpuM3pLV1Vjamh6cElKSE82bjVVNlhHK2MzRTlmQi83eldLTWp1a2w3RkRO?=
 =?utf-8?B?bmpOcEJiMzFueVoyTkZvUVBXM3N6cHAvNFBRS0VjcUNCbUhWRkVIVnlXL0hF?=
 =?utf-8?B?WEtuclAzUXIzOW1OSEwwN1ZoUXFzSk9OSUZJZVNhK3FOdXlwdkd0WWg2dTFV?=
 =?utf-8?B?NzYxSkVubTZQR29kd1dscEdUMVViVm4xRmVEV2RBWWRCM0VQMlV6TlhhcHd0?=
 =?utf-8?B?QmpMTUVROFNZUUpLcTFPVzlkYi83QWdLcUJsbWFnRVh4Y05BTVFrUU14L0Vh?=
 =?utf-8?B?RllaQjVrcmhleW1lRTB1cHJsU2dIQ1ErdVRCdGVJZ3doZ2J1aVphZ2c4dEk0?=
 =?utf-8?B?STJsbVl5R3hFZiszL3lxUkdtNXhadENPMEpZT1JycHlGbU1zMWRzdEdJTWxs?=
 =?utf-8?B?eUM3ZVA2V1h5MzN0Qm1GaFJYZnhvODlUN0c5Y0hjTEorUGhWR2NsZE5nWUZw?=
 =?utf-8?B?ZktDck9JSTF3N0dodWFtN2pCQkdlSUJQUUlXb2VNajBJSW1vejBTd0g4TzE2?=
 =?utf-8?B?TXRJdjREN0UrSmRwMTZneVBISDNlcTZ0NnZiVEtxNXQ0TXZ2eFZJaEhYZTZ2?=
 =?utf-8?B?WUpwNmZjbUQ0V2hOMnV0MTY5N2dHUTJiWXV2RmdRUzhiSmFydXFURzJyZFlp?=
 =?utf-8?B?SnB0OU9aeDh5N0w1WGNLWjJ0WXQyZHQ2c2R1RThFZ1lIMVZweXJKZll4S0Fy?=
 =?utf-8?B?YWpkdzBnLzNjZ3JIajFrY2ZIM3ZPR0ZFVW1kTGZwK0p0WEhWem1oUDdjUzBV?=
 =?utf-8?B?R3A5V3dhTGhGUkdLY3pyb2ZMc2toRXdicGNlaE9zWUxVZEdLWUxYd3NuNlhy?=
 =?utf-8?Q?kDvt8CItitIlRhZeX54qJib5hjMwteRVDym00=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QllxdXNpaUd5aXRHNTRCa3A5eXdicCtCTTl1aGY4dUJWS0lQQjRna0VVaVNP?=
 =?utf-8?B?QUdaWG5qdEcyQlc5V2Z3emZ2VEczZWNFVk5MUHVsUzFwNGhRRWVoYUJGeDVO?=
 =?utf-8?B?OWRaR2JHenZHUlpFamNxaXJlL3lLR3JiN2RnVzBDdlJ3bW5uSElobUgraU5S?=
 =?utf-8?B?U1N6N0twMnArdk1yVGU1TkdzcnFTMDNEaWI2dnErT1JDbGRuRlhlQWpma2xw?=
 =?utf-8?B?RGVWNWdqK0ZsVEc0Zytyc1NxeFg0dkU2VE9EOGlJcVkwbnMxSlBacHluendm?=
 =?utf-8?B?cStaK1FwdXJ1cUVraGdsQTQ1N0h3QVhmaWZQVVB6VXVxanZNYnlQYmVGMklV?=
 =?utf-8?B?Y1FVcURLS0FmMnYzTmF3Ujh5WnljbmZ3UnNYNjZrTTgyU2Z3K2ppTW1RV0hX?=
 =?utf-8?B?TnVpcjQweVhJenhCSDdMVFFUZkwwbFRSSVRGVEd5T1dic0piR2ZhRG9yWFk5?=
 =?utf-8?B?NTUvSllkUzd1R2tMTTRCaGExTURBRkVOUDRUZ25RejNMbFhOa0NjZktzWEY1?=
 =?utf-8?B?UUQreFdyQlNUMlFYUnM1QmhSWUpDNFlRWE5XdmI0NUQxNGVxd24wZWQ2Ti85?=
 =?utf-8?B?V2V3UWhEbklIK2R5akczdUFoKzVGTHBWMEdlV3BXRmp3N0hsSVV5THhmUy9y?=
 =?utf-8?B?VUQvWUhSRTBoZmZQVkROaFpIeFJYYlJaUmtmOGplMUZiUHR2SVovUmNUNlUz?=
 =?utf-8?B?QTVTdGdIN3FQd1dQMGFSeWVNaFQ4TGhEUElqRTgrcXVxK2FyeUNIUThaRU1H?=
 =?utf-8?B?eTFmNFc4czNQbEF2TFVhZytpZUlyWXNMS0VqRWtpK0pGc0lrdE9nbG5ZZzds?=
 =?utf-8?B?RUR0MUhKZHRXTWYvdFRkckVSaEFRSWFpR1FSNFN4alJzbnA3bzJtandZYnh3?=
 =?utf-8?B?TmpuZG92TEFTQ1ZnS3VoMjQzOUlCUTJBeFVKUVY2S3NZRGxKN2dFZFJ3THVE?=
 =?utf-8?B?ZVNoZHVtUGVYZjNLdWtESVpOTGtac2tkVEcvWmxhWDBUOGhEaWFic25DR1kx?=
 =?utf-8?B?RGMvSk9XM2hSNk1yRE5zYXJNV3lIcnorUEo0NmluSUFYZUM5VjkvVWtaV3NZ?=
 =?utf-8?B?YkFieDh3Z0JIRnc3VjhNTzdadENXaG9sTForKzIrYkx4TUxyblFWUlBsUHNy?=
 =?utf-8?B?TVFVVHJkV0tYUGRYQ1VxVjlvVEFsdzBYbWZoOVdpMnplSHpxQWE1aGgzdGJs?=
 =?utf-8?B?dGRjb2lyWEhSUnBjR2l0Njl3V1JuQWpPTnlnMlBndXBjUVNXd2UvL2c5VFlx?=
 =?utf-8?B?WGcrZUwzZUJrekJ1U2Rub2xCRkQxOFRtRzZsbEhFNmxHM2hPYmJENVhHeEw2?=
 =?utf-8?B?eVBDRG1MZzJwbG12QTlFVkYxQ1dOZExsNkx6YitrOVlhVms1ekM4ZGpqbk5z?=
 =?utf-8?B?ZnY4bGxmcXJLUC9TeG1vT3FWRHVYL2JLSFpqUlNleGRGaTJTalFjWnRDRXBm?=
 =?utf-8?B?QjZpR0dOM2ZNVTZnNERJQU9hR2ptYzJDVkwvYVV3MU53cDdlbm9HY2hlMDVx?=
 =?utf-8?B?Sko5YU13UCt1YlprMW5heFpMK0orQk11ZW40VVlXbDJ5NmM3aVc3MFVzR0Yx?=
 =?utf-8?B?RzhsY1kydm8vOFRoOTRpSUp2UkJYUGRDQm9LQ0FBVFV5dUVoNjc1S1dnVHZR?=
 =?utf-8?B?Q3BWNFdFU0k4M1NzTThWZEFUZ0FKWTBkQ3VLZHozbWNsQVNkeXVKN2RKQno3?=
 =?utf-8?B?MHJFNkdtWnlDTnhjR1dEMHBmZDBWK3BlUFZXa3E4ZjlkN3dHL284YXZBMDJF?=
 =?utf-8?B?NE5iVFAzK0o1Mnl0T3dLT1hlUk9mN2l2RGZQM3VEdjBiRTlqSG9talkxYzd1?=
 =?utf-8?B?NjhTTDhrSDhqN2ozckhjbnlaUWI0MkRWbGhjLzVJNUlKMGV0ZDEwaUhuQ0RU?=
 =?utf-8?B?Z09OV0FsUSswdkt5OW10WWVBZVVKd1JyRkZJUllvc2R1WkxTMUtuMkttZmhH?=
 =?utf-8?B?bENuaThMRGhadGtBZUg2dFloNGpNVmJWeUNXQlI0enhRemtndHNKaUkwcllM?=
 =?utf-8?B?N2JCYmpmWXJRTVQ0aEVZa05DcTB1VGNhUWtKeVpOaGV5M3IzM0I4ZHJGWUtl?=
 =?utf-8?B?Y1lza0wvclhDTGRZY2FaUXVVQ29oTndLVzh1N0tLOThJcDhSdTRJL1o5RXhU?=
 =?utf-8?B?b01GRms3cWtrSUpDR2ZlK05jMisyaEowdmJVOW9keHlZRWI1K0pCK0VCVCt3?=
 =?utf-8?B?OFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb5cd8b-89a1-47cd-b6e9-08ddf14d8ef2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 16:09:17.2117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfDGVD7HQyzZiyexZ/dDpQFVyPBSHLmLNwK3+76BU6E4blXACezG5TBaxcQsvgYcbr91x/QPNtw8jZoF/u3ltA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4097
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Sep 2025 16:09:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20040

On 04.09.25 11:39, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The factory-reset-helper provides:
> - set-factory-reset.sh to set the marker
> - get-factory-reset.sh to get the marker
> 
> The helper provides a EFI and file based flavor. The
> EFI based flavor should be preferred. The file based flavor
> is used to set the factory-reset on targets where the EFI variables
> can not be written, e.g. QEMU for arm64.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../factory-reset-helper-efi_0.1.bb           | 22 +++++++
>  .../factory-reset-helper-file_0.1.bb          | 18 ++++++
>  .../factory-reset-helper.inc                  | 34 +++++++++++
>  .../files/get-factory-reset-efivar.sh.tmpl    | 25 ++++++++
>  .../files/get-factory-reset-file.sh.tmpl      | 49 +++++++++++++++
>  .../files/set-factory-reset-efivar.sh.tmpl    | 60 +++++++++++++++++++
>  .../files/set-factory-reset-file.sh.tmpl      | 57 ++++++++++++++++++

These scripts fail under shellcheck.

>  7 files changed, 265 insertions(+)
>  create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
>  create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
>  create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper.inc
>  create mode 100644 recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl
>  create mode 100644 recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl
>  create mode 100644 recipes-support/factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl
>  create mode 100644 recipes-support/factory-reset-helper/files/set-factory-reset-file.sh.tmpl
> 
> diff --git a/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb b/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
> new file mode 100644
> index 0000000..d9bd84d
> --- /dev/null
> +++ b/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
> @@ -0,0 +1,22 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +require recipes-support/factory-reset-helper/factory-reset-helper.inc

Blank line after this looks nicer.

> +DEBIAN_CONFLICTS = "factory-reset-helper-file"
> +
> +# use systemd-factory-reset as default
> +# https://www.freedesktop.org/software/systemd/man/devel/systemd-factory-reset.html#EFI%20Variables
> +# The efivariable is defined by ${FACTORY_RESET_MARKER}-${FACTORY_RESET_EFIVARS_GUID}
> +FACTORY_RESET_MARKER ?= "FactoryResetRequest"
> +# Use a new vendor id instead of the one from systemd
> +FACTORY_RESET_EFIVARS_GUID ?= "abc688c9-fee3-41f7-87d3-1076e4a29e8f"
> +FACTORY_RESET_TYPE = "efivar"
> +
> +DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, bsdextrautils, efivar"
> diff --git a/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb b/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
> new file mode 100644
> index 0000000..3e8650b
> --- /dev/null
> +++ b/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
> @@ -0,0 +1,18 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +require recipes-support/factory-reset-helper/factory-reset-helper.inc

...and here

> +DEBIAN_CONFLICTS = "factory-reset-helper-efi"
> +
> +FACTORY_RESET_MARKER ?= ".factory-reset"
> +FACTORY_RESET_MARKER_STORAGE_DEVICE ?= "/dev/disk/by-partlabel/efi"
> +FACTORY_RESET_TYPE = "file"
> +
> +DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, bsdextrautils"
> diff --git a/recipes-support/factory-reset-helper/factory-reset-helper.inc b/recipes-support/factory-reset-helper/factory-reset-helper.inc
> new file mode 100644
> index 0000000..29ebf77
> --- /dev/null
> +++ b/recipes-support/factory-reset-helper/factory-reset-helper.inc
> @@ -0,0 +1,34 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dpkg-raw

...here as well

> +DPKG_ARCH = "all"
> +DESCRIPTION = "helper script to execute a factory reset"
> +
> +PROVIDES = "factory-reset-helper"
> +DEBIAN_PROVIDES = "factory-reset-helper"
> +
> +SRC_URI = "file://set-factory-reset-${FACTORY_RESET_TYPE}.sh.tmpl \
> +           file://get-factory-reset-${FACTORY_RESET_TYPE}.sh.tmpl"
> +
> +TEMPLATE_FILES += "set-factory-reset-${FACTORY_RESET_TYPE}.sh.tmpl \
> +                   get-factory-reset-${FACTORY_RESET_TYPE}.sh.tmpl"
> +
> +TEMPLATE_VARS += " FACTORY_RESET_MARKER \
> +                   FACTORY_RESET_EFIVARS_GUID \
> +                   FACTORY_RESET_MARKER_STORAGE_DEVICE"
> +
> +do_install[cleandirs] += "${D}/usr/sbin/"
> +do_install:prepend() {
> +    install -m 0700 "${WORKDIR}/set-factory-reset-${FACTORY_RESET_TYPE}.sh" \
> +        "${D}/usr/sbin/set-factory-reset.sh"
> +    install -m 0700 "${WORKDIR}/get-factory-reset-${FACTORY_RESET_TYPE}.sh" \
> +        "${D}/usr/sbin/get-factory-reset.sh"
> +}
> diff --git a/recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl b/recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl
> new file mode 100644
> index 0000000..4af5500
> --- /dev/null
> +++ b/recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +marker_file="/sys/firmware/efi/efivars/${FACTORY_RESET_MARKER}-${FACTORY_RESET_EFIVARS_GUID}"
> +
> +if ! mountpoint -q /sys/firmware/efi/efivars; then
> +	if ! mount -t efivarfs none /sys/firmware/efi/efivars; then
> +		echo "Could not mount efivarfs"
> +		exit 1
> +	fi
> +fi
> +if [ -e "$marker_file" ]; then
> +	echo "factory-reset was triggered"
> +	chattr -i "$marker_file"
> +	rm "$marker_file"
> +fi
> +
> diff --git a/recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl b/recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl
> new file mode 100644
> index 0000000..281ea3d
> --- /dev/null
> +++ b/recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl
> @@ -0,0 +1,49 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +marker="$(basename ${FACTORY_RESET_MARKER})"
> +marker_storage_device="${FACTORY_RESET_MARKER_STORAGE_DEVICE}"
> +storage_mnt="$(findmnt  --first-only --output TARGET --noheadings "${marker_storage_device}")"
> +tmp_mount=$(mktemp -d)

Blank line here.

> +# check for marker
> +if [ -z "${storage_mnt}" ]; then
> +	time_elapsed=0
> +	while true; do
> +	    sleep 1
> +	    if [ -n "$(blkid --output value --match-tag TYPE "${marker_storage_device}")" ]; then
> +		break
> +	    fi
> +	    time_elapsed="$((time_elapsed+1))"
> +	    if [ "${time_elapsed}" -ge 30 ]; then
> +		break
> +	    fi
> +	done
> +	if ! mount -t "$(blkid --output value --match-tag TYPE "${marker_storage_device}")" \
> +		 "${marker_storage_device}" \
> +		 "${tmp_mount}"; then
> +		if [ $(type -t panic) == function ]; then
> +			panic "Can't mount ${marker_storage_device}!"
> +		else
> +			exit 1
> +		fi
> +	fi
> +	storage_mnt="$tmp_mount"
> +fi
> +if [ -e "${storage_mnt}/${marker}" ]; then
> +	echo "factory-reset was triggered"
> +	# delete marker
> +	rm "${storage_mnt}/${marker}"
> +fi
> +if mountpoint -q "$tmp_mount"; then
> +	umount "$tmp_mount"
> +fi
> +rmdir "$tmp_mount"
> +
> diff --git a/recipes-support/factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl b/recipes-support/factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl
> new file mode 100644
> index 0000000..3427dcc
> --- /dev/null
> +++ b/recipes-support/factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl
> @@ -0,0 +1,60 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +usage() {
> +  echo "$0 --create|--delete"

Indention is off.

> +}

Blank line

> +marker_file="/sys/firmware/efi/efivars/${FACTORY_RESET_MARKER}-${FACTORY_RESET_EFIVARS_GUID}"
> +
> +create_marker() {
> +	if [ ! -e "$marker_file" ]; then
> +		tmpfile=$(mktemp)
> +		echo "FactoryReset" > $tmpfile
> +		efivar --write --name=${FACTORY_RESET_EFIVARS_GUID}-${FACTORY_RESET_MARKER} --attributes=7 -f "$tmpfile"
> +	fi
> +}
> +
> +delete_marker() {
> +	if [ -e "$marker_file" ]; then
> +		chattr -i "$marker_file"
> +		rm "$marker_file"
> +	fi
> +}
> +
> +if [ $# -eq 0 ]; then
> +  usage
> +fi
> +
> +if ! mountpoint -q /sys/firmware/efi/efivars; then
> +	if ! mount -t efivarfs none /sys/firmware/efi/efivars; then
> +		echo "Could not mount efivarfs"
> +		exit 1
> +	fi
> +fi
> +
> +while [ $# -gt 0 ]; do
> +  case $1 in
> +  -c|--create)
> +  create_marker
> +  shift
> +  ;;
> +  -d|--delete)
> +  delete_marker
> +  shift
> +  ;;
> +  -*|--*)
> +  echo "Unkown option '$1'"
> +  usage
> +  exit 1
> +  ;;
> +  esac

Indention is completely off

> +done
> +
> diff --git a/recipes-support/factory-reset-helper/files/set-factory-reset-file.sh.tmpl b/recipes-support/factory-reset-helper/files/set-factory-reset-file.sh.tmpl
> new file mode 100644
> index 0000000..7777c84
> --- /dev/null
> +++ b/recipes-support/factory-reset-helper/files/set-factory-reset-file.sh.tmpl
> @@ -0,0 +1,57 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +usage() {
> +  echo "$0 --create|--delete"
> +}
> +
> +marker="$(basename "${FACTORY_RESET_MARKER}")"
> +marker_storage_device="${FACTORY_RESET_MARKER_STORAGE_DEVICE}"
> +
> +tmp_mnt=$(mktemp -d)
> +if [ -n "$marker_storage_device" ]; then
> +  marker_mnt="$(findmnt  --first-only --output TARGET --noheadings "${marker_storage_device}")"
> +  if [ -z "$marker_mnt" ]; then
> +    mount "${marker_storage_device}" "$tmp_mnt"
> +    marker_mnt="${tmp_mnt}"
> +  fi
> +fi
> +
> +if [ $# -eq 0 ]; then
> +  usage
> +fi
> +if [ -z "${marker_mnt}" ]; then
> +   marker_mnt=$(pwd)
> +fi
> +# shellcheck disable=SC2221,SC2222
> +while [ $# -gt 0 ]; do
> +  case $1 in
> +  -c|--create)
> +  touch "${marker_mnt}/${marker}"
> +  shift
> +  ;;
> +  -d|--delete)
> +  rm -f "${marker_mnt}/${marker}"
> +  shift
> +  ;;
> +  -*|--*)
> +  echo "Unkown option '$1'"
> +  usage
> +  exit 1
> +  ;;
> +  esac
> +done
> +
> +if mountpoint -q "$tmp_mnt"; then
> +   umount "$tmp_mnt"
> +fi
> +rmdir "$tmp_mnt"
> +

Inconsistent indention in this file.

And then:

[...]
Applying: Add factory-reset-helper to set the Marker correctly
.git/rebase-apply/patch:140: new blank line at EOF.
+
.git/rebase-apply/patch:195: new blank line at EOF.
+
.git/rebase-apply/patch:261: new blank line at EOF.
+
.git/rebase-apply/patch:324: new blank line at EOF.
+
warning: 4 lines add whitespace errors.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

