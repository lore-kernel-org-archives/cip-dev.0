Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE9BC47079
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 15:20:25 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.86])
 by mx.groups.io with SMTP id smtpd.web10.9412.1704727216284592701
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jan 2024 07:20:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bCw5W6+c;
 spf=pass (domain: siemens.com, ip: 40.107.22.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EURh/YveW0dpgUa+bxfgAIw30vv6WnWk5hwRynMXtSbmh9B2J0f66CKPtA+cIg+9p8dF7oghDXJ/D6jfUQTLMs++I607II6yCppJjnjzD+92vK9h679hpBJRG62agMiyu7JUe+TK7tZ6h+F6kaoYoNW/GkwWeb0RH8qwI5gBL6ukvhMxUVQj2knUyH79jyL0B7kTlqTElw6cD+NH504Z1oLmbomopSpAcGGWh+FEk8aUGJtCsOweqB44r6ViMwvs/Mktlfw0+Fiw4jybx53m2JS43HawRkz5Ln2bh35KKJtZT+RMLo1iUHw0dsaRifeG7tTW01WEkfzjEJEznR8uqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLHoQtncXFZdfph6ZKU1PFJ3Q0SE740UNp/fq/bxJIs=;
 b=V0UEROxtwORDEHIEETswntUHsMxWdgX+v6G+d5qI2SjrdA4t3d8HqDD7g/xDEuGPpPMtMesqfjXa2XCj8R+PxudoUx/g6HlDkHk7XBmKSH7LQhwaWlfVY+YJDe1HvHydXhwcKFPh+LuGo2lAQAK9GG2OvL8zd3BKaenMQvWsHcLGAG51ISu5eGxuhmfdEY/P3gl7Cc9ucWgFyonvGbG+wtHXkO/JQx2+LnkbMPxD7bnmwn08WLQ0N46JXS1A3Gm/4uOoFr7BNGGtAHVm+GDwLklaHltKaDreXOFolXhch15FOLwzUPAqtO9vEnqei6rewylrBHdusAgCh/iRcLj+lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLHoQtncXFZdfph6ZKU1PFJ3Q0SE740UNp/fq/bxJIs=;
 b=bCw5W6+cib+oCLiNuNz2M8Vp4LQsmRpp340tvSyOgyMwehQkqZaMKRqlvwXBtaV92j2jyYKQxHZWmLmoP0b+W/k/ktioxGNlun2GMP80mZCXaVU56dLifCV5R5g/43fQRuBcZ+iPX3XIzhQ1Fet/4x1c4PsP3s6s+AifPNKnZwmzLA9sQXfV971Sg/6ySB0nMWiMTnisdKKpciGpcwdmCwVG6nbfDE7HyHz0RplndxGm0Kfoo8ISQ2q2noC7TKkc9RQ7n9T0v1oqVoIVdT1xWEMY05zWGlhS+IrZc1f6f8YloR6rgX2ig/1USMMqO/kkj0qfTrpsIm6379FcMQ1Kzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7210.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:310::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 15:20:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 15:20:12 +0000
Message-ID: <055cfc48-fa79-4ef9-b24b-7bce4a8e9b68@siemens.com>
Date: Mon, 8 Jan 2024 16:20:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 0/6] Add Bootloader to
 sw-description
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20240108102638.2966221-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240108102638.2966221-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:610:60::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 284712b3-30d2-4947-66e3-08dc105d4f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	x3L7j9Xf4UbH6Th6fnbCWfwEltU5WKPNV43DhXPQsVkYXWOfPsXt8LR2MIzynp488uqbfVDApZLntH4TMv/xSdaD1a99BG6Nu5QrkjAO058sBjx6Tj54wR+WSjZb8E1ANmKgtaOXQghNbiBvvluk9WuqxrdFiCrSAia/sDydQy9hUw4iCl4gIm24VoFLij2qMcl4e8QNaffcfcj8utbz/Tsa/m3a2AWb4yl6W3NB+4CkNUzsrFDi5DDN40AIEeaNUg4gEJd6Drm4AHouVryP2HSH4b7apbJub6ZNtgeVU3EfsqvzEqN+5ab8tORtFoxIUGkmxJCDill/Hbs9GAdUQpS2kFOfZ2ZerJaNAZ3bl9PBfh/gcN9/PztnQAAUtyhjRd8aX0anA2FCex2cboBOifHnAxJq72TMmXXnHFjwxzYWI/g9v37jsJ8LXr8k1PFnZ48NmRgmtBi1Aw3fMTalL58Q38HqGtFsrs9qnwgZmGuqGcm8mSC+shMSyc6efzABFlJ+q4mFKOQVrnkmr1iIFjXqcXK208oVo1/c4NYAr7wEo+1fUbmhJxDmA/pBznaZItF2tWqxTDRI6aClBTi0UvhhURfIQ+q5l5pMYff29AKgtoHCHk3HKutKGnykvpLySda09yNy25Aubaw6wstZJyvffe7AvBZ53gTH9gYYXTFYXi+pWQ2gCBhUI3PiCRTp
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(396003)(39860400002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82960400001)(41300700001)(86362001)(8936002)(6486002)(8676002)(31686004)(31696002)(2906002)(5660300002)(26005)(2616005)(36756003)(66556008)(66476007)(316002)(66946007)(6512007)(478600001)(6506007)(83380400001)(6666004)(53546011)(44832011)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dW5Xd3N0SXdtc2NSS1dRd1ZQNkhLcTZRVWNpVUtiNTdjcThWem9kMEkzNXNu?=
 =?utf-8?B?ODBGUW5iWVhQaldnLzJGNFFTclNPZ0wrVGlpaVRLSElQaTlMbHVLcWFJUmNv?=
 =?utf-8?B?c0tpTlJZa0tvRmtiUXZ3L09LUE1BMTZEUC9VT0c4ek0wSUtqNTUzcUdkVHJh?=
 =?utf-8?B?LzZWanF0cmF0cFQraTE3c2t4SElKd2k3dGRXS3ZoUHRTSlUzanMvM2g3b1hZ?=
 =?utf-8?B?dEF4WkhQbHhGL3lCY2IyOHMrODFPTGNXcENEQmJFU2JKSlhFTUFzcFF3R0pM?=
 =?utf-8?B?elUvV0Nma3dhdmRyZzZ2V2VtQkdvSjdWZEFLUUUwZHRJS2dwQkNOTXFYd2My?=
 =?utf-8?B?b0FUWG9LUXJSTjBCL3BvTjRkZmYxMTQxMzdzUzN1aUlBZUwrOGFlT2tQN1pT?=
 =?utf-8?B?L1VxcmREMkRRNGNQanBXYmpDNFFCSW5pQnZFU3ljbnAvWFlvNWhuQ2ZlQms1?=
 =?utf-8?B?TVRNU1ZPRytwSHpXblFiSTQrTisvaEt6MjRkL2pOdlEvNUNUSXJicUNlWG1J?=
 =?utf-8?B?Tjc3bVNvV2MzcjhjWk1kNk5zaWZKbHZjQURycHpwalZjMmRicjdBSW9tODR2?=
 =?utf-8?B?SFQ2dWlla25HSEdBYytXME15OENiWGxFbUNtVHRta2U5aUhrR29Pa1JjT09U?=
 =?utf-8?B?QU83cDBKTVErVFlpRnBMeDJvZ0M3dWlScndOdDlYL1lIMERrVXphUHVBanFy?=
 =?utf-8?B?UW9jZDEzNWZHZlZVNnVIMno3RkNuSUN4QTBuZmpITHNVQXUxV3BiZ2c1QzN6?=
 =?utf-8?B?QUY2YjE3WWlqUnVubGViUFhpRGdxVDMrbWg3cENjNXpMU3pSeXQyYjBjV0Rs?=
 =?utf-8?B?ejM1QnR3REYwNnhhT3IwYlBqVVcxY1o4Z2hsVU5JaUFRVjhZbExPWlhhRFpr?=
 =?utf-8?B?YkdjaldMM0ovUFZwZ24rYnVIdU53NWQ4ZG13eHlxNjBXVUp0cDZDZjVjWVFK?=
 =?utf-8?B?TFVsQUVacHFXak4xbDNRTlRMTGEzYy9XMHNveSs3dWljR1I4QzRWbTNUd2Zw?=
 =?utf-8?B?WnNmYS8wdno5SVVYNHBBdEtDUldZRVhiSXpzTVZHWXhTWFVlbk84TGVnTHQw?=
 =?utf-8?B?ck5jTjc3N0poN2hxeGlUejVXV0tmOHdvWWQ1K1IyY20wRUR2ZlFseGR6V0Zh?=
 =?utf-8?B?NzhOZXhGMzZZWjBXUmpvdEJmdkhaVFlYbFJFdEwvRk8xZHpMcGRpd0Jnb3Zs?=
 =?utf-8?B?YXpvVlFqTlVpYnJBVDI0dGVZQkVjaEQ0OUJWaHEyZ2xYaWpnL2NqYXlGVklJ?=
 =?utf-8?B?cGIzUzk0Tm5FK013RXlVdExIUkVXems3VmFMczJJaFFpM3BZMi9ENXpuK1FH?=
 =?utf-8?B?WjBYc09hblZnNFg5WTBGTE10amY5OXNZbjBTMlRIaytKVVl2YzA5SE1YY2k0?=
 =?utf-8?B?RWpXWVVZWEV2YXZqaytGeTRST01KeVJLQ0g0STlINFZBOFRlb2s3eEhPbnRT?=
 =?utf-8?B?d1FBNUxQeExFWWRIdFJ3K3NOWVNXT1J0M25nbnJtcnpmMWJIVTVDanBGZWp6?=
 =?utf-8?B?SXkvYi9ZbHJDOVZQbFBUSHRVV2pydmVxajRXUXROaDlOcDdIcnZWaldsbXNt?=
 =?utf-8?B?RzFrN2xnVnNOV2xiQ1pIZytkdkhvenMrbkFOS1dMeVJuNlJPNjBnWW5rZldy?=
 =?utf-8?B?YUlybHZXTE1jckhsMFFDVENiMGdXTTNFaGNjN3l4UWIzZys2dS9KckM1TzYy?=
 =?utf-8?B?cmJ2SlJlaG1WRjJSMEh3cTJ4WUJtcnZKRHhhYnR2Z213NjFYT0NPWFZDVEc0?=
 =?utf-8?B?VS85Qm52VEQzR3NEbjdKZG9MUUxMcnZzVTZhM28waVRBSFB3MkVrQ3B4dDNm?=
 =?utf-8?B?b0MxL1MyUmkrbHR1Z2o2L2ltd29FZUxmL1BtaXVuam1HVmd2MW9DOU5mVzRy?=
 =?utf-8?B?VmJ5NTgvb1FRQ2p3OXVaVkViOWpYeG1hU2RWUlNhZVZ6NWxMWGUxWmo2aFBM?=
 =?utf-8?B?NTdnc3ErelUrQnltRVFXRVUyd0VnN0JVZ042a3Ivd20vYldjTGxNdmV0MUZI?=
 =?utf-8?B?cFpSUEhSdTBNczJlNEZKd0FOeDMxUUoxcnVKcHQxRXNjWXdCRzNvTDRGSWJk?=
 =?utf-8?B?VWZENlVqQ290dDNqZ2JRaGx1S3FhMDN0c2REWTBWS00vbGlWOG5CMjgvR2xj?=
 =?utf-8?B?TTE2dmljc2ZRVy83QzVxV3FDM3FjS3BIeXR3ME9NRUQrWk5nZnFuWHJQSGNl?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284712b3-30d2-4947-66e3-08dc105d4f00
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:20:12.5006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5b+ws6znFia3xMqNGQxsQHv2QnvxUZU7sPgu/G6jj3YCTVivGb5fg6DiyqWq/kXPXVL1DJRyiNE9BryBJl9HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7210
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jan 2024 15:20:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14287

On 08.01.24 11:25, Quirin Gylstorff wrote:
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

This looks viable to me - but we really need some documentation for
that, it's only coming as code. And we need a Big Fat Warning for EBG
updates along that.

Jan

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
> Quirin Gylstorff (6):
>   Move efibootguard specific settings from include to class file
>   efibootguard.bbclass: Add functions to generate the EFI_ARCH and
>     EFI_LIB_ARCH
>   efibootguard-efi.py: copy signed ebg binary to DEPLOY_DIR
>   swupdate.bbclass: Add SWU_EXTEND_SW_DESCRIPTION
>   swupdate: Extend sw-description to update efibootguard
>   classes/swupdate: Generate swu containing only efibootguard
> 
>  classes/efibootguard.bbclass                  |  42 +++++
>  classes/swupdate.bbclass                      | 143 +++++++++++++-----
>  recipes-core/images/efibootguard.inc          |   9 +-
>  .../images/swu/sw-description-ebg.tmpl        |  17 +++
>  recipes-core/images/swu/sw-description.tmpl   |   2 +-
>  .../wic/plugins/source/efibootguard-boot.py   |  29 ++--
>  .../wic/plugins/source/efibootguard-efi.py    |  50 +++---
>  7 files changed, 209 insertions(+), 83 deletions(-)
>  create mode 100644 classes/efibootguard.bbclass
>  create mode 100644 recipes-core/images/swu/sw-description-ebg.tmpl
> 

-- 
Siemens AG, Technology
Linux Expert Center


