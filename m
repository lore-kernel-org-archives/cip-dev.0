Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B61C46CD2
	for <webhook@archiver.kernel.org>; Tue,  2 Jan 2024 12:40:47 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.61])
 by mx.groups.io with SMTP id smtpd.web10.27867.1704199239658965970
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jan 2024 04:40:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NM0s20Vc;
 spf=pass (domain: siemens.com, ip: 40.107.22.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6wtZt+SXopPmGXWrR0zv7ZZbozmsMz+K5ECwub5VS9h8UP26kCr5YtnTcvHomaP/eXZ3oNFlnntNOwHwas42aRJVp6LeT51XUrlEDF7ky62ADL5xlqhNHy6svCdR9L5QSimGjcVxqCIy6KNOJtEi2hjpAThUTA5ceh01veDt05s53azL+Z43H7rlt8GoALakrvzJXDjZBiw75R3u/bcqWPum3BTlRYcQ/2JmVpErfyZhJRTFKuw+HuSev8cDugnNOmxjFrSJqFSOUMK2KN+YvxTX95NQVRfUdI6dhIbIbk5R/V2zfdSQSA5/dCpTLGNRjdYBpDyMuRiJ3Ah8rZKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjJ3k4+uocNkYdYjcs6hykbLOBDTNxXIrzB1cHUGndg=;
 b=bSrJYoRJZNatF8nKs02157IXYUSTQFiXnMcaXVZsyyctjs8M2s3502c71JwPQCqD73mfGuiv5J4oiUCtNxSVa5XWvtsgWKEflyNeuoRJnhkmyw7z8e6X7bgW5glIXdHZpfDV++Zn7zNiNqUECGl0yQnt0qg7TG9jsDKd1otsBCkdwFsWq1xJ3bX3HFJrmZEUnOpu6y6dabTcV1Sj3A4hsPCBVGQWhyi0NBLYYrVMN6EbwtabE3CYQXV9mEdnYu8wCqo9GJekIleTlbTDW6dNIQ/UwQlx7bvJLZwHVOyPr36qCqDWD+q+nbW8TebaZno7V8IIYAf1flw0nbw77OeeNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjJ3k4+uocNkYdYjcs6hykbLOBDTNxXIrzB1cHUGndg=;
 b=NM0s20VcvPlzICd/EORRks4LZu0QeZLM2/gLtHy6sKdcO6p5r0TOrnUW/C+3STTNadGHB6P0S97OHJzBiFKaVoEwoL6G7jBj6L2QFTluhqsKyOSjxFV01xLTeAQB9MX8j5xYf0xRp97ywWN0u4qsZ603on72kHApn9rp0/LNf843Yb+aD/11vFXj/Gcxw8I3ipu+ea0dFzNqh7PAepALtDS+qSvCvzspClou/3pxKh+Hn+D4PhPzcBmv1LS3rZMx2xXdOaq17k8rPiYxqndDKJIr3sc8xIdU1IeW6CZeOj3J+u1lR3PZzU6puN3guEG8w3QCWtNN9PdQTsgEl7y1bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5528.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 12:40:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 12:40:36 +0000
Message-ID: <9884aab9-22d5-436e-9606-9b8fbc550471@siemens.com>
Date: Tue, 2 Jan 2024 13:40:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v3 5/5] images/swupdate.inc: Add
 variables to generate the sw-description
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20231229123111.400555-1-Quirin.Gylstorff@siemens.com>
 <20231229123111.400555-6-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231229123111.400555-6-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5528:EE_
X-MS-Office365-Filtering-Correlation-Id: ef823612-e595-40d6-e654-08dc0b900489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ojsoRu6lVmD4JumCcfi6frOQ7x3zuBuNwKV+yAOQSrXldy7w6FpMxwYSKtQe4dNpL1PYmg8GHv9z+EHijXRCgFJE+5DxXiZNlW4Ga/ohE//SubB56kMBEuvmcUvIdX3mS8XjhF6267a6gaJs+fxQqdTqwqLj5LmW42bCORP8SVsrYNEL7fXxDDULql1gLCqQ+iMQKDLf4UbZYCRUSWZWOzncPlEpJ21vbCg0fkHVTMqiP7MlTkohRvXogfbDZEjZgEHceOC0r56bwyha99qjoRcAy5XYnKikO2lfbIG3WAIcv2woAvtOIcJHAqZNam22FaiIVdptsFPC1sYF52Eczrj83CE7b+thcD1sH5u8zaps2LO57ezJTWs+PqfS3ho4GGpO1A6ycvkwccEMPcRJWV6/zYMOBu2j6Awmc5iIqmlYizzfgJFhdeE90Sql2JVsV0MWpEoHcNqEX4brUS6fpJAyWPpEpsZji1lABP+BJVerYPhvrIpdhi65PP+jChvYAsGcHSqFYqRIUX81oWfXFZGvqiuebM8UbEmHzNsx990XDh9a3R/LknGDBvJDGuZPUGfHgNI+RFcPjs5A+Vlqg/ze06HrU1Wcz4I17XTV6jKTfq+oh7AJUGXa3yCNsZJlI55z0w5uSXfV+VMTvWiVPw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66946007)(66476007)(66556008)(6486002)(44832011)(316002)(8676002)(8936002)(2616005)(26005)(6666004)(83380400001)(478600001)(53546011)(6512007)(2906002)(41300700001)(5660300002)(6506007)(36756003)(38100700002)(82960400001)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?LzVVSjd5OEFZcDFzUkVhZUtobThMYjRDbmlSYUdvVGFKZDZ3YXNGR3J1VDN0?=
 =?utf-8?B?VHhYdTFlTUltMmFQc2N0S1J3aTVzNjFLZjBsZmtlVndjM3VncmdwTWxyUy95?=
 =?utf-8?B?NS9EWnZWcUNaVTBqbHpuMTlVdDV3QWd6dlh5VDV2eFA4bG5Sc212NS9iLzhk?=
 =?utf-8?B?ak1QTWlsMzF3OGVCaWxrNU1LMTM3aVIrZVlCSm9JQ3VtL2JaSFA4V29pK0ZL?=
 =?utf-8?B?MWhFdFZOWCs4aHlQMG85akdJZnVjaE5qL2xiY3lXUUpZdENLUEFNSjNSWnFT?=
 =?utf-8?B?NGtBaGJUaEgyWWx2dVRxSUxQWTloZEFtSy9CNkQ5T0ZieEprWjlzNjVKcHpO?=
 =?utf-8?B?cG05R0Z6UllsVy83VjZxMG1hM2ZhWkRRdElXa2ZzeEZ6WldlV1dObVlXK1Vj?=
 =?utf-8?B?UlZJc3lTejUrSDZ3ZGRpME5lNlVzRGhFcXJsS0ZtSFZFUklKUGhmemhpN1hD?=
 =?utf-8?B?V3M0a2NJenA2VG9vdUdyS29rVUF3TXpRUStIMFc3cm91QUdIeG15RUh3QUIr?=
 =?utf-8?B?VEtLUmd5TUZwMHJaVUpiZlFjeVdvK3BvTjVLWTBrSkR1SFp2eDhtNlJKZHZR?=
 =?utf-8?B?eVN5RGhLdVZsYkhwVHd6QWIyWmx2L3pxaWxOYjFGZ0hrTlFpTk1XeTkzZm9v?=
 =?utf-8?B?RTB4U3dvWjlqQ2Q2WjZFOEZUZ0JFUi94MWJWZGdHME8xUWxUa2hGMmpKTlRO?=
 =?utf-8?B?Tm0rVyswNk9UcWZZVGJIVGJsMXl4dXV3aXpnUGVlSEQ2QzVPWU9vQnNBcUNN?=
 =?utf-8?B?TFJjcWRhQWUxQlJqWEMwWHB2K3Y4SzRLL3BjSXFWeGZ0c3R3TXllemlmV3kv?=
 =?utf-8?B?L3NFSGdydWZKZ2k1SHVqaVR2QlZIL0JJUVMvOGxGSkZIemkvdEIzWFhxS21z?=
 =?utf-8?B?K1ZhU1g3d2NublJacGtJa2ZXSkptZG9nTHFtNEQ4UzBWWmFaTE9NeWVKMWc5?=
 =?utf-8?B?b3ZnYm14aGsxQk52ZmtoOVpUZWFpUDhlV2Z1bnVaczhaRm4rcFJjRHZ3S3lq?=
 =?utf-8?B?R01mQ2t2YVhHV1ZnUFF4U2pBY3hwOVg0RCsxTWhTVStXQVNUUlhDRFBRc0JC?=
 =?utf-8?B?TDlMclczN09oT2tLMHBEVm9QSkFjOWVSWDY5TTlyMWdDQUFZam9qNHpmKzFY?=
 =?utf-8?B?OXUweFJMUWJQQ2xsdGN5VStUZEVueGhKSFdKVHNoK3RhY3pBZHpvVjQ1eEpr?=
 =?utf-8?B?bUI2b3A5ZFVmYXRlYy9wWTZIWUJ6MjNYdWpsdlI4aDk1bnE4QTFndnlWOHdZ?=
 =?utf-8?B?VElVclNubUlJZ0VRdHhpazdDUnp2RmtNSzl3SXkyWERVcFEwNW1wMnl2L2RR?=
 =?utf-8?B?ZGZzMDNWUU1XZVgvVjdUZ0c5dFFoOWJhM244S28xZklKUU9XczNXSDF6RzRM?=
 =?utf-8?B?dXVxSnNyWG93b3VkYXE3TFY3L1oxc2cvbjhZQXpZaVJPWHFuQWxoQlNwRThW?=
 =?utf-8?B?UllKM05zM2tlcDZFazVPRVJ4ZlBtV2kwZTZoS2Y3bXBCRzlYSk9LSlFWdERy?=
 =?utf-8?B?bnFnTHNrWHowYnRwUkx2ZmI2TFZKZ3JZZzdDMTZZQlo3OWJxVjZYd3dpZW1N?=
 =?utf-8?B?NktGUG5Jc2Q1TGtlUk5ZV25JeDZ3YTVucDE3SnBIZGl3RU95d0Fwd3MwUkdp?=
 =?utf-8?B?eU9wTy9QMGtCVnI3MjQ4UHNDcitVSjlRTGdOQWl2YVZtTnRqLzdrbE50WjJj?=
 =?utf-8?B?SUkxVnM4ZlRZZFpSeHlCWjlTcmhFK0tvZ2lwaTFqUWlnNHdSdEN6aWxjK2l5?=
 =?utf-8?B?cWI4enBvZ0tNZWRTWk5ZYmVmaDdyb3puMVZaL291SlVSRTlaOVJHZHlyOHpw?=
 =?utf-8?B?UmZ4Kzczd1lKYW5Eb2lnZlcrQUJTZzNueGRKY3VuWkFpRUtmUGpuc0VETlJy?=
 =?utf-8?B?NU5WbTA3Z21BZVM0TWU1SDNqUUZrcU51ajg4SThZOVVlY0dzTHRudFp3WXA5?=
 =?utf-8?B?L2ZzQzBkblpCSnM2VjlaeVFETjFJVVVRbVY5T21KMHZQcitHNkx6dzVzUGVO?=
 =?utf-8?B?Y0ZsYnczeHBNeDZWeDZmTjV1N2VmZjI2YVRRZm0rMzkxOWtDSGFHT00vaWd1?=
 =?utf-8?B?UmJBU0V5Ty9qMUUvbkFZZU1IM0VmUnFtWVl5bnBIbjN1eHJteDc4aWRQNnEv?=
 =?utf-8?B?Q2h2RGFxQU9ud0NTTjdra1dlTW1YWmNKazJMNWpSdEE5VGVaZXQ2dVlBOUZH?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef823612-e595-40d6-e654-08dc0b900489
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 12:40:36.0183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HeHhBVqYpktNGWOl0PPJiE6wa2Dj5pmGYTDZWUqxP/4JAJls5C3BXed1L3C53JFFBRACOGnvbOsyJ7ewc5Zsvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5528
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jan 2024 12:40:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14227

On 29.12.23 13:30, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This done for all distributions except Debian buster.

Why not buster?

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/images/swupdate.inc | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 4983f7c..388faad 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -11,6 +11,33 @@
>  
>  inherit image_uuid
>  inherit read-only-rootfs
> +inherit ${@'' if d.getVar('BASE_DISTRO_CODENAME') == 'buster' else 'sw-description-generator'}
> +
> +SWU_IMAGES += "rootfs"
> +SWU_IMAGE_rootfs[filename] = "${SWU_ROOTFS_PARTITION_NAME}"
> +SWU_IMAGE_rootfs[device] = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}"
> +SWU_IMAGE_rootfs[type] = "roundrobin"
> +SWU_IMAGE_rootfs[compressed] = "zlib"
> +SWU_IMAGE_rootfs[properties] += "subtype:image"
> +SWU_IMAGE_rootfs[properties] += "configfilecheck:/etc/os-release@not_match@IMAGE_UUID=${TARGET_IMAGE_UUID}"
> +
> +SWU_FILES += "kernel"
> +SWU_FILE_kernel[filename] = "linux.efi"
> +SWU_FILE_kernel[path] = "linux.efi"
> +SWU_FILE_kernel[type] = "roundrobin"
> +SWU_FILE_kernel[device] = "C:BOOT0:linux.efi->BOOT0,C:BOOT1:linux.efi->BOOT1"
> +SWU_FILE_kernel[filesystem] = "vfat"
> +SWU_FILE_kernel[properties] = "subtype:kernel"
> +
> +EFI_BOOTLOADER_NAME = "${@efi_bootloader_name(d)}"
> +SWU_ADDITIONAL_FILES += "${@d.getVar('EFI_BOOTLOADER_NAME') if bb.utils.to_boolean(d.getVar('SWU_EBG_UPDATE')) else ''}"
> +
> +SWU_FILES += "${@'ebg' if bb.utils.to_boolean(d.getVar('SWU_EBG_UPDATE')) else ''}"
> +SWU_FILE_ebg[filename] = "${EFI_BOOTLOADER_NAME}"
> +SWU_FILE_ebg[path] = "EFI/BOOT/${EFI_BOOTLOADER_NAME}"
> +SWU_FILE_ebg[device] = "${SWU_EFI_BOOT_DEVICE}"
> +SWU_FILE_ebg[filesystem] = "vfat"
> +SWU_FILE_kernel[properties] = "atomic-install:true"
>  
>  SWU_SIGNED ?= "1"
>  

Not yet clear to me what we gain by this approach.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


