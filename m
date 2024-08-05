Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C731C3DA4A
	for <webhook@archiver.kernel.org>; Mon,  5 Aug 2024 15:21:48 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.79])
 by mx.groups.io with SMTP id smtpd.web10.10642.1722871299202711097
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Aug 2024 08:21:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CP3gvO78;
 spf=pass (domain: siemens.com, ip: 40.107.20.79, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnUQJbP9iVue/mBn6bz2TSwXKiIXLW6Gkn+yN599ZuVZPCv3xMhpeQ+F0jnOQ8NGNvHyRjn0JgN7ZRhy1TlznXbXidRhRUp5CF67mi2ACy5LWh3Z7no7/MRDSec8gb8qXCGOyR6TsycFf07njQEkRz23syWUHBGYdqzrZMynxS8Px91UoqFr3Vdq/7DgyV4ZecrFmlV9hKqhxK9Gx6amAM7nstjPaq5E9G2xaD+ISuzDs9E32NkZujWJl7zFxIoaRLGjwumWGquQ8ILnPejfQtkGDPmkWXgGN3UXLZUL+bcilH0oWTffadiQt9L0te6Be9OoKBAy8GRWY06ZoDS2MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWLrszJr7bXNBrya1aRVhGFYHwmdPbniR/WXUNNFib4=;
 b=VdgY6QEeSCjqiCRsa+rARqyHM8U3jeMc2dldg2V6swWoqjLnjOkKfEuST9mfV6eM0JBngpU/AUBrUwk8EReiUbRjmCpcFx2SFqJDGx/zPIIdaor5tSsERzeJ9y3Na1ZhjRRs04oV2SM6jqaX713k2SZB18e0aRLDKoFMN4/N2zy4smgv3yf6JG8qpFbn1DbC2Y8jBHWkcsqYMaJAH/qRzA5tpNG/IR5nCl3GdDCRPue9HNadeCc/Skae8B0LiMnGcYcscojqYkFMQBksh4b0gBm5njt+0z+z1hoWDbDDTeF5Zjmu7J9H5kQ3d90JGSz1liXf3yTY9Pjr7qNk07w+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWLrszJr7bXNBrya1aRVhGFYHwmdPbniR/WXUNNFib4=;
 b=CP3gvO78qlf9XNO1dqDalo2P0DR1YAWgMmxSjEtkwghYKVkWyzsE9CNydBznezsKxXa+Cd9X8oGVEEZPPJYoF+j3cj3BRQHVDpxUrxnA2oIH509yvEeYLoHD41q0U56NeGlsfFE5hFV91md0pnpMmQKwDAx/xZ8d3ig0iOivxXUYrkkV+naQYJSoUdC8hAE1dCYeQpelbK2woBAy2P3Enlcw5pvg4u937ZCUbOmEFER9Y52So+hWu9wJUfPG9myyaa3MeYhjIAFAH6Jj9Q2eKZLxjUaD4Hychwdp4dgbAV23DMBhy3JFGnrDDe4i0cOXfyBO1DrLgrxYXzsiQMqTng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB6680.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:400::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 15:21:36 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 15:21:35 +0000
Message-ID: <a04a7285-89df-4f2a-8a66-4a1afcc2040e@siemens.com>
Date: Mon, 5 Aug 2024 17:21:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] fix: initramfs-abrootfs-hook
 correct install dependencies
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
References: <20240805151706.778686-1-Quirin.Gylstorff@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <20240805151706.778686-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0326.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::19) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: fa398368-acac-4103-94e7-08dcb5624b26
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|4022899009|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MW9tejJoUUVYU2hpQW1wU0RRNkxTRy9hSUZ5dHR4alNkamUvTmRvS3VmNlpW?=
 =?utf-8?B?ZERWV0Y0M21ScEpqenNrRUlTNHVMcUZlUnpUbnQ2cHo0YVZ6WnFSWTJqcnN6?=
 =?utf-8?B?M1cwK3Z1UWNkaGUrc1MvZ3JXUy9XOHF4aGJlS2xQQnEwcWExUnlQZU1Manlm?=
 =?utf-8?B?OENVMk5aZ3lubFNsLy9QZUdYejhWMHhRVmxWY29YcndKMmtGSjNBVDZCZWVU?=
 =?utf-8?B?bUpTRTZMRkp1SGxMTUd6RlUwR2FrNXBPMyszYjlENzVydDMvMjRKRy9MN3V5?=
 =?utf-8?B?V1lhajVuSnB1SnBkVVpyb0c3UExETzIzd3AzM09iVzJGNDk1ZkFsNXRMZUZB?=
 =?utf-8?B?QUhWUjlFQzBKTllSdFAxbmJ5V2tIYm9JS3NwZHBWUlFRbXFiVHNwcUI2U1hV?=
 =?utf-8?B?akZHUjgyWFE5N0YzbGptZHR1Q25zTkllMXhBZUU1anE2UXEyMVhlRyt1Nm9z?=
 =?utf-8?B?eFZxOTl2TWJ6L2JWZ3B6aVhQdE00MnNac1UwY2VuaCs0L3BUVktxak1nK0Zu?=
 =?utf-8?B?OVBTQTlvYzF6cDh0STdNUGR2VjhOUjlkREZQa3V5b0owUE1TMldDVG5MRHkz?=
 =?utf-8?B?UWdacEdvUjBib1daaFNLcUhuSkhERlIxV2FZR3NxUkRmRy9XMjVIZnJNOWJ6?=
 =?utf-8?B?eEhVUVA4N0NFSHdyOEhXS1RaS3h5VHJFTmVQd2gzSWZDRnFUUHRITnYybFl4?=
 =?utf-8?B?TkFKUDU0dG9BTzA3Q3MyYVVycVRTNmQxS1lXaVdkNkZnQXdoL0tmcWZlTTJ0?=
 =?utf-8?B?bVFsZWhYR21mODQzdDZGODdVREhNTkN3U0I5cWYwOGhaaGkyUnZkbDV5NzQy?=
 =?utf-8?B?NHhjb1lkTTJVM3U4cVVKZDlQcllVREFxNVUwWUVTV0lGQW1mMC9WMG50TnI1?=
 =?utf-8?B?TjgwcGtHQ1VZckl1QlNldTlvK1RmdjRlY3hnakdSd0ExT1pmbzBNUEZvWGht?=
 =?utf-8?B?Qitvdm5NaGZtRENSWW9ENVkzRFh0MGlaUXMwTWRCVi9KTEhaT2VXOVM4bHFS?=
 =?utf-8?B?N1EyeldLUmJpTzE2NzlFVmpiQ1BiU1g3YVRiZWkvVEpNeWxrQTdsb0dKRk5p?=
 =?utf-8?B?UThlOHpxZzZVZTVVT01HQW1DYkIrbDE2bUdMOERZTmpIc3lrTDI2YWJHTmM2?=
 =?utf-8?B?elBwZnJobSt3YmVDeVhkbndId0J5SWpWamdYaHRUaTROSHhVTThZY2ZpWDJk?=
 =?utf-8?B?WWcrdTd5YVFqWWl6Znp6ZGVSOHU5VUJxRUtoSlJjVnl5Y3NtTk1oSWsyaWRB?=
 =?utf-8?B?SXRRTExSdmYzWUNPYVRGRWVXWFZXODkxT2xhWTY5QjljaGFELzhhRHlTSGFx?=
 =?utf-8?B?SnpiQkZRZmVtT0N1NDAwVXBtMDhDTmdWbUQ1d2xXNXdVTmFpVGMvclhjSmVB?=
 =?utf-8?B?akFnRU1DV2lkUG51bTBmTGxWUTZQejlWZnVZZHhnTXErRjJlZ0hzZVR0ZlRD?=
 =?utf-8?B?Y3hxYWpnRWQrcldPdXJQT0R3ZVgyT3RyWkpmY1IxSElzcUlIM1dnYW8yWVFv?=
 =?utf-8?B?OWZDL1lDSkhHVU00YVNVcnIyaTVLbmpvY0t2Ri9oN1ZpUDZ1QUlBZlRMeFVU?=
 =?utf-8?B?czI0UFZrZ3RoZk52dW4zRm9NUk85T3BXa1VHNzJteU5PQUNtTTVFWlZIdjl0?=
 =?utf-8?B?QWQ5Z1RacFpIMlFoRU1UQTU5eDhBZG5RMUZTZkhqUUdndEkyTFQ4T1FkM2cz?=
 =?utf-8?B?UjQ1MVJNa1pLUkEzcmpFUkQ2Zmh6QkR4TnlxUHdOR2xTNyt3NTFOMW04c0Ns?=
 =?utf-8?Q?mYu8BoVWcQMW1bXGcc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(4022899009)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SUJ0N1NxdTFuV1JVRWd6OVI1ckN3d3ArODkwQk44ajVJbWx6dWxhVC9LUGdD?=
 =?utf-8?B?Q1J6YmtQcWN6c0pkVG0rVWViZktBa09TTXdkSlJ1R0E0UzJCYWwrTFFHeHZO?=
 =?utf-8?B?RlBqaGpvdDRUbklSTG0reGN2K1c5UzA3YytpeEtiVXk4RFNlK1VpcW1Eczg4?=
 =?utf-8?B?K1JVTmhscHFUbERreEF3RFZNTlhNaFF5ZWlsM2xKdzVuMXdwNFFwamxyZEx3?=
 =?utf-8?B?Yk5JR0Y0d1E5aldVT1RiYzNoQ25MQWZyZ3pGSkN4bHB0N2FoRTN5emVORjJy?=
 =?utf-8?B?S3F5dnRLRDlCZjVMZmJIdW9Ka0xITERPaytFN09rblNydVVWRWI3WnhKbTUy?=
 =?utf-8?B?c1o2SDcxMnR0YmhESGhycmVHNVhSd0tCWlJpL2ZxNEhBVDJFdG5vY2RFN0Fl?=
 =?utf-8?B?R3U1RDIya2h3N3JURFN0MFV0NDF1QzlTV0g5ek5ETXRDM0NXYjJzWldpMEVZ?=
 =?utf-8?B?UWpZUnZ6c0I3QzNnNXFJSGpRWEJkMk0vRmxLN3RuUmdNUUxnTE04TVdQZ2VH?=
 =?utf-8?B?QWllNVdGQzVYT1ViSXFMU3FtUW8rWDBFQXNmbW1BODIzUWNuMjlJWmJCdHZL?=
 =?utf-8?B?OERBWnlxS045Tk05LzFNQjhqVnBrYndlWGxKVDhiMWNyWmlGaUF5OXBSTk0v?=
 =?utf-8?B?MFh4ZEdjb2V0V3BGZUU0bE8xR2d4SS96ajJ3SXQ4TDNIdktrWTFKcksxUTc1?=
 =?utf-8?B?K2l1Ti9GWWlqTUdPdytscTg5U1RIV3gzK1ZEaUE5dGdLNFBrUEtrUzdWdmFC?=
 =?utf-8?B?Qys5NGc5Ry9pbjhmdU14TCt3bjhwLzdoNEVma2UybVlQdlExWFJOaThuWDJ4?=
 =?utf-8?B?RDVKSkxHdXhkU1IvWHZ0d0V1TXY5VS8zUVZzZ0t5dVN5aHBRNE5ZUXBKVGhQ?=
 =?utf-8?B?bXlMN0JzaG0raFIzNjByeWE2OTh5amNnY2toclRTSkd3NXFQOFd6NVpJU3lo?=
 =?utf-8?B?M1g5d2I2bUMxS0JZcVNLU1F4RGxUUHZDeFdhbmR6bVVYd2cwQ0t0KzU3R0xP?=
 =?utf-8?B?aTBVYkZjeEVKQmFxbzJ0NkRGb1RWbWM1RTRIU0hha3haN0NueERodytWakZQ?=
 =?utf-8?B?ZnIxUzVRNFdaYm1sTWhFcG94N2NYbysrY2NoUnBhczEwYXZpU2RSY04zQXp4?=
 =?utf-8?B?SCswaGlpRUZTSkRlSVJKV1NVdGIwbDMxRGFkMG04b2s1NFRqbzVaK1lpLzRM?=
 =?utf-8?B?MkQ5VEhUcVZ0cHZ2WTExazllSjN2anZEOFJ1bU9uTUtCWm5mOHNJYlU5NWRM?=
 =?utf-8?B?NmhLbEh5V2k3NGx1cUcrazZyUnA3MCtYQnlEdWlXdkRGYmJRWGw0ZTdCamxC?=
 =?utf-8?B?cFFlRWVldm56N2k0akt4Q3BQMW5kcElPcnM3d0FTNEdFTU9jOXRTNEpZR1lj?=
 =?utf-8?B?ODZNOXhzcHR6VlplMDBOdGtOOHFraFFIaXZwa2pBSDF3SUVXbUJVSVB0aFFS?=
 =?utf-8?B?aUFOOE9zYzdYRTltOTE3QWNhRWZVUEZaOXF2d21TMkJSQk5GZFk3eUdCbS94?=
 =?utf-8?B?MjNxK1dQTEpJaURCTFNKbTVObFhXbDZiRWwxQVpKRC90eG5WOFlBdEU3LzdT?=
 =?utf-8?B?SmdTanc0WmVmaVBYQ3ZxbXVVdFlUNElQL2YvVUFGRklEbFlyQ2dkeGZYTTRD?=
 =?utf-8?B?Wm9yQVFpSWsvWUlyaklINmE4bjhSelRjamYxTDVYcEFOME1wWjBQejNueENH?=
 =?utf-8?B?S0E0NmMyb0wxS2MvVEZiK05QUnNCaTROdVVsVzhKNnF0dytOeUc1Z0MxWW1I?=
 =?utf-8?B?dnFndlVlUW9YeWNDZHN0OWREdjRTakVvdG84ZStlZlNzejRFZmE0b2xTMEha?=
 =?utf-8?B?UDZHSTVMTndEdmVaY3lnUjdaOXNsY3JBdzhxbjA1enMxZ3FWdTU3Um9IMVV0?=
 =?utf-8?B?VWVaZG55eWZEUWR0VTVRdWI5TWl6ZUlXZXZFNENiTWFpVmRnSlduYmZkUmRX?=
 =?utf-8?B?M2o3TG40LzN4NTQxbUlsdkk1dGlsWlRHR2ZERFB4ejVuNUNqQVpsQWQ4bHJp?=
 =?utf-8?B?bGdZZkw4NmswWkFXOW8rUlFBUzNscVQvQWpkeGlEMUM5YTkrVzJ6UU1TY3Vw?=
 =?utf-8?B?aVB2R01XSStJamVuRFF0NExqdEYvOHNXT3NQSmpJWWVud0ZLM3B6TnNzaGRD?=
 =?utf-8?B?U3YwaXMwRDR0ZlVGaHRJM2NlMnRFVDVwTVk4MWRKbUdTN2J4L0xxNlBjNUlp?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa398368-acac-4103-94e7-08dcb5624b26
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:21:35.3533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0azzU7IffDKeqyMkCnBA5hHVWKKCXdZE9xKbGJSZUtyDESUwN1bTrd4mtkMPDfnrq0v6xEKiSyx4s+aF+fCv3wk86EB+XCMzipF16lajtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Aug 2024 15:21:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16721

unnecessary, my problem a clean dir was missing on my machine.
Quirin

On 8/5/24 5:17 PM, Quirin Gylstorff via lists.cip-project.org wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes a regression introduced with
> b16c77c77761896e42fa4d2f9738f20c24e80d03 (classes, recipes-initramfs: remove do prefix for adding task)
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   .../initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb      | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
> index 17c60da..fb27f94 100644
> --- a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
> @@ -26,7 +26,7 @@ IMAGE_FULLNAME ??= "${ABROOTFS_IMAGE_RECIPE}-${DISTRO}-${MACHINE}"
>   
>   IMAGE_UUID_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.uuid.env"
>   
> -do_install[depends] += "${ABROOTFS_IMAGE_RECIPE}:do_generate_image_uuid"
> +do_install[depends] += "${ABROOTFS_IMAGE_RECIPE}:generate_image_uuid"
>   do_install[cleandirs] += " \
>       ${D}/usr/share/initramfs-tools/hooks \
>       ${D}/usr/share/abrootfs \
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16720): https://lists.cip-project.org/g/cip-dev/message/16720
> Mute This Topic: https://lists.cip-project.org/mt/107733749/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

