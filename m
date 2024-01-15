Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08A6C3DA79
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:24:04 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.86])
 by mx.groups.io with SMTP id smtpd.web11.72625.1705307040177983555
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jan 2024 00:24:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=M3fsUaru;
 spf=pass (domain: siemens.com, ip: 40.107.22.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBdqwjbzJ2fTkUPuBjn389AzPKwLaON7IFVo/4zlz34whVtS7hmo1QGgH80723AVRDyfQUf3qeHRD7ZwDoQr9hqWGWuLl+3AZUXjoelys4dVJZi/Mz1XaRfv68TcmlLFOZNMmavUrKSTO7h92BTfd1eVtthdSomYBVuWMNLyYBG29hPuqg9Nv/1tQykS0J7tRLMG2RGmSnKfxITdlkXCcYBgOLbqnbOy3fClYXZPI4dQscbKylhBSjrYPkzu3vCtQ/6qK9S4WwThfPZqb1LQk4viZlsc5FCOe5zOcHrUqwzmKB7/9+MR2aIZp+7ghXSosy/FrqvDjJQ3GUzDynj6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRYvAiyCo//aDkgRav9iH0ABxMf/idxOIyv8t2kXmLM=;
 b=iJ179JNk1izxikw5luq7damyhqeG+0twwHFMu/nxiyBDW1WeOfN9bWmMYG9Z3lOV4P6aD8sHqWu1v2SPfeNnT7U47w9Mhc7K1IRWq35Kbg57i46aOloq1xxP3PXMfAlQ0dkv+86Z4gqMe4FQ8fc/Jw3/w1462oo3l3vheGVUSS5FiY90zND1nWA6F+G23fZ7/qILb85OJJN8E1W69qMg+mj0lKsXUkL5Rwl5Ne+1XjgaZ4ORKaQmshzHgY9bRDVUczjOyyrIReF4zzdLET+Msn0bHRkxIDQp5ulwgNzo2aN72fNgc+F17SJAy4NGIop7v7a/Lf7PwnNapa5+JUqquQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRYvAiyCo//aDkgRav9iH0ABxMf/idxOIyv8t2kXmLM=;
 b=M3fsUarufpz8rr07SN7a+6OrBZMHCC9rSitmRA9plvToxSqME0cUKL0y9AKHrOaKI/oDgKakpF8UvR81HyONf230lrKjGsk/PMmNt4p6KZ04ikjwB8B/j7z7Hplz85maTchHNkaVLU15FenIKO03YumTJwE0io2LEfF4VsP6P7T74ARFXN4GZawBAKCeJ+5wkW7jjfEuIQztFJdSXD+qii25hbcr75Y97aqvZFBiCb6wLgLkqvwrWIeDWv2m5N5bQ/SplutcyHGLp5nCqACwaxs3OWC2VsCn/1M8Kwmz50JXOW8PrMu+8woK76HxJZIB4ARL9TU2Jcn5w3hM3D8dew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6386.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 08:23:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 08:23:56 +0000
Message-ID: <6e91adf7-64f1-4819-bed6-667962d1666c@siemens.com>
Date: Mon, 15 Jan 2024 09:23:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 0/7] Add Bootloader to
 sw-description
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20240111200015.190376-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240111200015.190376-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a6499c-48f1-4bdb-4182-08dc15a35140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lGhETSiq4mIXU9O/i10GC5CwCytUDrrNFuldLkM6cnVyvz6XeGJkvDyrY44uF4V1tJi9GHrTWR58cNh/q9tKFX0qjlHF650/0D14djIuDUaEdFPjva5xMTYfLfSpqZR38vk0XBSHHcctA0JnD3X34gy9uF7B1h7iE23Ux+pjAvTppjpMAETmMm5Cib1/PgqyGNdEkyv057IvcHLU/vdSg7/CHRSv3t4dfcay4CeVlN21nE8NI/FzCzMiXwskCUlVse5cn6koeBS5zse97ZehR5Dsy79NV/tKGFFKkBAucASZwCRpQrDnJJ8gvdBddbHiIFcUq5JYwAfBP0b1NSPWitmEw/eszDQbztI/315AdYhXWsfhY8y1P3shC6wxwHhQa5S3ysmboa37TKNLdjZHHTz/GSpCxeY+zxzACXzG4prwpIoa96Sp8B5evLNxXXm+Qm2zjZE2Ty5t82mbG5WK93egVDETQM9MAmjf1wNZrSQjHAk3FkdeJsIeQJlVKX71dRfSGfs4OH3D7oyLSZA/zOFRiHvBxhhysD9aKBF/wYBBLcn2TmX/YSNlYQjte+QDHnO0f73+tzPKBkwCT6JerHD7xyb3F52x5uEpNElBbhRlRPGF/jLaGzkuSJFFn1FuyGjXcjPN3Wj1NQ6xHbcKrA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(83380400001)(86362001)(31696002)(31686004)(82960400001)(2616005)(36756003)(26005)(6486002)(53546011)(6512007)(6506007)(316002)(44832011)(8936002)(8676002)(66946007)(66476007)(66556008)(2906002)(5660300002)(41300700001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NzEwSmVzeVVwYU54WHNaTGlheVBaNURQM1BvUVlEYUJKMmVsRWREMGx5RWNF?=
 =?utf-8?B?ZmlhOWpRMnFsbVhQektCZTBYM21yNGFmcW81MHhURi94ZmxKSnBLbmltTjYx?=
 =?utf-8?B?RDJTQnEvNHRKVTFSSlBhZnJUNEFzbVRYV3V2TUV6SHNhbytqQ3Vla2hsVTBa?=
 =?utf-8?B?eU5rQ25DSWpESFZtWWRJdWdrbEY4bFdVaHhGbWlOKzUwRy8yb2RrdXltMi9u?=
 =?utf-8?B?UDRGeHlzNjEwVncrMHl4NTN0NXIrTWhvd3dUdXlzWnJKR1VmeUtHWVNicnZM?=
 =?utf-8?B?cFRZdFZUdGsyT3liYnJ0d2ZaYkVRZW93aFB6UXh6NER0UGFSekJHYzFjSk1m?=
 =?utf-8?B?VU5XQTg4MFNKU1NqUVAzcFBkUTh1aFBrNmQzMzZHVFZlUndEZ2lpWTcwbjYy?=
 =?utf-8?B?R0xKUU0xL0RCSklmRitXMzdEa0ZvM0ZWV2hiTUU5ajAyZmh1NjJ2YThJSFpj?=
 =?utf-8?B?QjBxci9TSysxY3hkbEg4V2V0R2Qzb0Vzd1V6NjY1NEgyNVFnc3RXVWp5emo5?=
 =?utf-8?B?VkIzem1HOU01djVmbXc0NDkyd05XZVVWdE9pcUVsaHp0eFh0enhNbVdPeW1o?=
 =?utf-8?B?ZjdwMFRZWVdZMmVqOUEwbTE3b0t4VklXbDkvSDhKVW9MRmQwbzBaekx5d3Qz?=
 =?utf-8?B?cnB1K0svakxOVFRsOW4rZTYyZFdydDlRd2YwNnRabkEzNktOY2J5SUxKSHln?=
 =?utf-8?B?RVF3U2N5azJXTnhMelh2NEQ5R3Jubnk4WFlWaDBEZnJ2Y25sOWxDRDNQZFAr?=
 =?utf-8?B?SW1YMFhqRjB0SWhScHQ2ekNMN3pPNFd5UFFNWVpleW54OWwxNnBkcnVjODl2?=
 =?utf-8?B?cGQxV0FpOTV0RFc4SUFNWkNnUERteFhuYSs1eHVTTUROZGptU1ErajlDa0Jk?=
 =?utf-8?B?dVhqUFVjSmN0QUErSVIxVkFHdVlSUzBjaUlXeFo3a0FueE5QQlpoZ0RYV2tI?=
 =?utf-8?B?RTM2UWN4eU00WjAzditrbjBXRmlkelRNQVRscFJFUHM2eG9FbERLY3BHQ2ZZ?=
 =?utf-8?B?R2JPbHorOXhVQm9aZEJsNjBOOWNYakphenovNkhiWTk2SnJtdmFidjVuaE9Z?=
 =?utf-8?B?blpmTFNKRTZyNytKMVJuekx1WTFYQ09PdWtNMmRFR2NHcHYxbTlZYjVnMDVJ?=
 =?utf-8?B?K3N6NS9jb0JtWTM0SWxpTUN3OVZxNzM3OFlPaVBTVm9ici9tSlVwYXB3TEsz?=
 =?utf-8?B?a0N6NWNpdmRRTERNUVhKTkxhVmt3VzhXd3VydFV5clAzM3lWaTZ3dW9QOVU0?=
 =?utf-8?B?Qk4zM2M2V0lUZG5MS2QzZG9tZzN1NHJBd0ZGYjYwN0ZTem5EaUZFMkxmeGJW?=
 =?utf-8?B?ZW5oc1NVYVNhVm1JNzNjZERaTWhxc254SG9saUpIckRDRXdHUlMzSE9NWDF1?=
 =?utf-8?B?WmR5bGVWdS9HMytndG1lRit4SU0zQmNZdm9uRzFOVEFja2VyRStINHBSRXNx?=
 =?utf-8?B?d3dzcEFVb0g2UmY4SU5Id0hwcDBYcFBRTWE1OGw4ZHphUGlTbE05eEh3b2hl?=
 =?utf-8?B?Z0JZTHN3cWJ6bWt4RDNMRDRLb2FwR3NtU28xeDFkWUdsbWtqL1Zya05lajE2?=
 =?utf-8?B?ekttQThEaU9XaG9CTHFzbWtTb29vOVM5bW9hLzRVZ1N6TFpYSCtCd2NKT0tx?=
 =?utf-8?B?c3Fhb2NuNEdNQVp6cXZsOHFqUm45K2U4TVZETFBJRVFBQVc4eHdVcmswWWZM?=
 =?utf-8?B?ZFM1dVU3MHVTNWNJdi9qSTFXWjdKREdnaUJCMUREYk5YU3kzZUt2RzEzQ0JW?=
 =?utf-8?B?bVVzM00zUkpUVnpJQ0ViRG9EUXBnTlNnbENEbTZlMm5mUkhoUGp0TFNkc1ZP?=
 =?utf-8?B?Vno3TUQzYm1wOHgzcG1EM29wZEtBeERyaXZEYmt5Y1FrOXBtNUtwSUV5eTEr?=
 =?utf-8?B?MWV0TG8yRUk0T00vcnlXZ3dWRjM0YVBqK1JNbm1MTjNGYkVSNUpLeGpQWW5R?=
 =?utf-8?B?Mm9aQVN2WkxnSy9Ja3Bpc3k5NGZ3VFoxYlgyMzV2MXFhRHVUeXUwMHAyRUR5?=
 =?utf-8?B?eXZtYWN0ZWM5Sk84c0lXMGxZa3p5SnlyUUZFWjZRMHJKcmR2VU9pT3BpcVVD?=
 =?utf-8?B?OHF4Nk4xd3AwbzVmN09sTlYwYTdUMjcrS0R4YVVZZkNsNURvMDJrbXRxRDVV?=
 =?utf-8?B?UTV3OXlxQ1Rna0MxMkFIdW80N0Z3c2FEa05YWDlmczY2UjF2WnFUYkE0ZEFk?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a6499c-48f1-4bdb-4182-08dc15a35140
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 08:23:56.7848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNBqquFEx8mtgYjWIUJIskRzUeXrG4hUsOQP+oQWb85eqF+wfIVebbFLpYA0VWKHmeVBH2Q4aJwFPLEYhfM7BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6386
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jan 2024 08:24:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14381

On 11.01.24 20:59, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This series adds the, possible signed, efibootguard binaries to the deploy dir
> and adds them to swu file and sw-description to update the bootloader.
> 
> The new entry contains following information:
> {
>            filename = "{efi_boot_loader_file}";
>            path = "EFI/BOOT/{efi_boot_loader_file}";
>            device = "{efi_boot_device}";
>            filesystem = "vfat";
>            sha256 = "{efi_boot_loader_file}-sha256";
>            properties: {
>                 atomic-install = "true";
>            };
> }
> Changes v5:
>  - Add efibootguard section to README.swupdate.md
>  - remove whitespace
>  - Move variable EFI_ARCH and EFI_LIB_ARCH to correct patch
> 
> Changes v4:
>   - Rebase to latest next
>   - Remove the generator for sw-description -> if requested this can be
>     added as a new patchset
>   - Add new class containing the efibootguard specific settings
>   - Add variable EFI_ARCH and EFI_LIB_ARCH to reduces dupilicated code
>   - Generate a additional swu only for the bootloader. This will be
>     always generated. If the bootloader should be added to the
>     <rootfs>.swu the variable SWU_EBG_UPDATE needs to be set.
> 
> Changes v3:
>  - Add Generator for sw-description instead of using a template for
>    Debian 11+.
> 
> Changes v2:
>  - The efibootguard file is only added if the new variable `SWU_EBG_UPDATE` equals `1`
>  - Add the variable `SWU_EFI_BOOT_DEVICE` to set the device containing
>    the efibootguard binary
>  - Add the variable `SWU_EXTEND_SW_DESCRIPTION` to all extension of the
>    sw-description file
>  - use atomic-install to update the binary atomically
> 
> 
> Quirin Gylstorff (7):
>   Move efibootguard specific settings from include to class file
>   efibootguard.bbclass: Add functions to generate the EFI_ARCH and
>     EFI_LIB_ARCH
>   efibootguard-efi.py: copy signed ebg binary to DEPLOY_DIR
>   swupdate.bbclass: Add SWU_EXTEND_SW_DESCRIPTION
>   swupdate: Extend sw-description to update efibootguard
>   classes/swupdate: Generate swu containing only efibootguard
>   doc/README.swupdate.md: add new section for bootloader updates
> 
>  classes/efibootguard.bbclass                  |  42 +++++
>  classes/swupdate.bbclass                      | 143 +++++++++++++-----
>  doc/README.swupdate.md                        |  13 ++
>  recipes-core/images/efibootguard.inc          |   9 +-
>  .../images/swu/sw-description-ebg.tmpl        |  17 +++
>  recipes-core/images/swu/sw-description.tmpl   |   2 +-
>  .../wic/plugins/source/efibootguard-boot.py   |  29 ++--
>  .../wic/plugins/source/efibootguard-efi.py    |  50 +++---
>  8 files changed, 222 insertions(+), 83 deletions(-)
>  create mode 100644 classes/efibootguard.bbclass
>  create mode 100644 recipes-core/images/swu/sw-description-ebg.tmpl
> 

Thanks, applied. I will send another small cleanup on top in a minute.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


