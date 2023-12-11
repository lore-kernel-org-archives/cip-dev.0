Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59A2C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 13:46:53 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.44])
 by mx.groups.io with SMTP id smtpd.web11.8499.1702302406762440518
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 05:46:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=F3tKBl5i;
 spf=pass (domain: siemens.com, ip: 40.107.8.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yhv2u5EtE2I/YJJl2vwSkWqjdfNb1n9EjwW+ooyIc+1jp+DorUSub9UXJf/5qROCnZDN4utjUmRQpYiJFinkFyEXGA0oM5QAABdmbSQ9Wk+uL/NFEXCis9xwgri5TMqDkq4d1KGM4e5vCCcKJ0pG7DaDuIAIXJWszhwa2x2Empe7RpdJDgEvcsivmzx27pZ0is8fU6ffRY9n75I7PeV8oWwsqIKFt5qATAyqrHC5aSS+beoN/vyANFP60hP9YXqfPOCZcUO6FphZ43WXrif3m4dXEc7jMsLse/KSXuJHnLCvoqHY50h6envTdEhow5Ne4tokJ2iG9e9A77vpt+Maww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MwgyiHuaXg59/2HIS1wWHgK6VPMUlGcMstPPDZlctw=;
 b=TAtVVwbmrzLLgpfO/eFBeCaWuOkAj83jWcLi+vaVMO9OAEjl/I7T/vdK4959RqimgEd3pxFUtBI6tKjPMyqx4CU+heGulpuOjAOEljAKrq6utmcMmgehCvQnbrtf8gh5wnKv60I3soRgetLmO/iRUXnt0e/yV7cKPzyh10dM8b+7uJMd+2iasY6Vo/ZUe711jt4IWEpDEdWiS/hDAC4zROdTgZCqP4pEOWVPG5Yu4N0pckP9942yyLLiQf3svlbfcCq/mLJAErAhXTPsDQBndYG7GQBZ0kYxvnWuqX+vjztnUKxm219YmZIW+ujxfb82ExZrhJ3nvxsLzYrfc9bIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MwgyiHuaXg59/2HIS1wWHgK6VPMUlGcMstPPDZlctw=;
 b=F3tKBl5iI2TTCvdIIB236Wx7Egeg098TRlxNknkOhkxl+u9bkbo40DzFz1iFRGN94L+6zPXFuDPYodlFYR69FpPLvJKBbigLVjw2bnhkJ/nCrM4Ohyeh+QB70esHa8ObphFcob0Fh6TyVrcJAas6Bd+SJMd3kIYihkWDO8xSwew3VS7+BOIEJgPFOjxDuPLvTqXXvQCM9F6Pb6OjL9eF2/qP8wXWXJ7Emg4K0W3nq56SGXocePf6zsQuQMMAd0UeqBc1W+t4R+NgMVZqk0129Hs6ap1Yglwgkd21sGv3ZoipG9uXsolwrexisv4h3X3ImqmgnQzXjhoJT2wj1oiOFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5379.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:334::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 11 Dec
 2023 13:46:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 13:46:43 +0000
Message-ID: <570fc651-6525-4273-ad9a-aeef4737272c@siemens.com>
Date: Mon, 11 Dec 2023 14:46:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dec][isar-cip-core][RFC v2 0/3] Add Bootloader to Update
 binary
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5379:EE_
X-MS-Office365-Filtering-Correlation-Id: 77257673-7359-4140-947d-08dbfa4f9ba7
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sJ5DLnQSl1zbJYV5umTYLd2iALH76gkko+0m3OFWR0thMtjNP2r4DSRIXymXyD+y1zm1R8dbtEU+yqq+TXBdb77VvcNgOYL5odjsCaYrhMF0VtURVj7e5InSmg+zWyGVdg56F/MriqJz6QzPeyI9CFLiDob11D+fWnDsvZ67diL3luX7piIgo7gN+yGE5j22KjDRf0o7fkGbSSb2XmXCbtCJ1jhZGWS9pillmEdiQKavRzhTf7PBRtrsjZf/4/wrp6Lt9+GUPMVGlygSfqV/ULBuq6m/jldZkRIllBBaPINoOgmBFOglJcDrVpcB3XLDdoCGFjWDNRValX0wpmJyF4ofKpA1KrFtpBOMFsHAqFzyazUtKlVcl3mYAnDapC8Nupj6pAL8FpBmvkTweuwoaxo4BRwFISpgcU+2nC9uFTP3Zh+l3LZ2L31RpAqwepN7syIp8Tgbwm3/A0ngLS4SapC/+zEzXAWB9i3XSq4kUsHfmicg1f6l37dgRAy2dYreDPDxUxeQ0GNu884c69NIRsXA6QujASZvlzR87gPxv71cJqDci+oHLHRnKBG5s1dOj/2+4SaFT24VwoLCw9XY8bPpNbbMI1a4Llz8iabHcWGhI1DGeFvFmR39JKYPhBru94EyEOsuAjkAaa4m3iG2ug==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(6486002)(478600001)(6512007)(53546011)(2616005)(6506007)(26005)(31696002)(316002)(66476007)(66556008)(8936002)(86362001)(41300700001)(66946007)(8676002)(36756003)(15650500001)(2906002)(44832011)(38100700002)(31686004)(5660300002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z2l1amZIM0U1cFZaVEJtUThROXI3dmxTWkVTMkJLMndiRHVUUklyTFk5ekF2?=
 =?utf-8?B?WURGTUMxdU1ESjkrcXRoaDhSeEd3ZlVMUGdUVjZUV2k3TUVQVzRoRTZUSWIv?=
 =?utf-8?B?K2ZDMENTNGZneVdLV3RxTmFMcUJEZTJ4eXd1a2JpaHl4dzhZSzlXK2tHc2ZB?=
 =?utf-8?B?SklUcll3NXBmd2VvVkdaaTVDb1lpa2ZwSXlpa2swTjRzdHU5bi9XMmV1bkYr?=
 =?utf-8?B?QWJqbEFHSy9yMEdLaGV4UzFqNWkwMEt3enFIV0hQcWcwWU4zNlQvSU5yWlhQ?=
 =?utf-8?B?ejF1eCt3R1VubE56cU5JUGt2QUdtalZUNlQzREFvZHFqWW1lWlIwbDFTb2hr?=
 =?utf-8?B?MGZCOWJydFFRMERZVlpaVnpKMER5V1g5S2xJUU9LMm1kMDhmQkZ5c3RCR3Bx?=
 =?utf-8?B?UDBSMkozZXAzK0Joc0ZZa1VQT3hESXlSUUVZQ3lacWFwY2RuUTgvQ1kxb0U2?=
 =?utf-8?B?b056QnNXY0pFd0RwMlNDMWVpa1dEV3k5MEY5V1gwMnVWcmI0Nll3T1ZRTE8r?=
 =?utf-8?B?SU1qWlVkUk9JakczenA3TkhNM0g5cGlYbGVOVzc0S202eHJrMHJNRjh2NTVP?=
 =?utf-8?B?dDBSbkNlQ1RKR3JUdnIxbEUzVG1iTnQ5T1lKUWpUM256M3ZqZmtLbUoxenha?=
 =?utf-8?B?eERJTis0RnZYWnBPZFczSVlNZWh5SVZJR2ZwWWtOWTdxQk94ZW41YitWN29Q?=
 =?utf-8?B?SnNwMEpRc3RkbGRIZTlGR2VIK0diSjlsUlN3dGJGdERrWWFqVTFOeUFZK1lL?=
 =?utf-8?B?d1FNVDFFendxSzl1cXNyMTdxY0VBUHdhUjQxNGg0N2JoOEl2WnZUUktkclJ0?=
 =?utf-8?B?VWpmcGhBaDZZVDg4UCsvWDJGbXhGOXJvVjM2UHE0ZXBMWWZDRVNEa0psaDBW?=
 =?utf-8?B?OUNqYitTeFByQ0lGaURBSkltOW0xb0ZWTU1qdzNqK290NC9QcGkyS3puYlBt?=
 =?utf-8?B?ZGFxaDZQN3AwUnc2dm1nMGl5TG5TUWpiYUhzcHdlcURtZjZsN0xlcFRCRXBi?=
 =?utf-8?B?b2tDSWg4RjJISTMxYkN3dW12T1UyWHdycXNhSGg5Ny8wWWJmdkRXdlZyZGdj?=
 =?utf-8?B?STdrbWtxK0Z1c25rNnIzS04ySHNNM2hPaGtmbW5aS0hoVzFEbVdQSjVzYlFj?=
 =?utf-8?B?MU92eTBiRlB3WmkyRk5GS3hvK3FadGZNRStmNEtZR1crQ3l6UVV1OWdGWXlU?=
 =?utf-8?B?OHRVdHNNSXJxWUVEN2I0dFdqRGN3azZVb3VtbHZZYkR3bU5jZ0pnS0thU3Vs?=
 =?utf-8?B?KzlXVkVJaTZjVVFONHF5TTU2K2QrTGxJWlhjRytOWHpmVjJKVy8zUy9CSmJX?=
 =?utf-8?B?SXkyZ1UwRTJqS0Jrck9zd2FqVXl3UzFuTlMyQkx5N2pDd01ZVm5ucElLSjB5?=
 =?utf-8?B?c0NJSEhGcnc3cTkwTExhVHdKdm9wYTBqazl0SWM4SXZrcUNIYlNzbE9SbGZx?=
 =?utf-8?B?eC84VFU0cXgrVjVPTCszSVEyQUQ5Q0NHeDBrNE4wYWFvOE5xMUU3WGU2aDc5?=
 =?utf-8?B?eG5Gb25RNndWb1h0N200Y2RyUzZvY05hdXhJZFdhbHlQbmVOZHpIS1k4TGZ1?=
 =?utf-8?B?V1VVVzB3bklJeVlMSEhXY29YN2dTT1ovT0Z2cHo4NFBDaDhKK1JFOUZzTkky?=
 =?utf-8?B?TU44aEJxRS92TXNMN1JkRGMwOVBsNldwSSt0ZXRnQzhiaXZHZUFCdTRaZDlr?=
 =?utf-8?B?RXdjM2ExNVpaRGJ6bmprQWtaYm1yNU1sTVJZdWtHOWpBQklwM3pHSTNzd1Fz?=
 =?utf-8?B?MDk3NjBZRTM3RXZaSEJGWkxiV0h2Rm8rYmhzbHhZWFEyMlp2RmpYajdWdVdm?=
 =?utf-8?B?aE5SL3IwbXA5NkxRT043bWU1dkdSWkJheDFzS09vRGxkNld6YUhLaklaOUNl?=
 =?utf-8?B?K0tDQmJNYXpDalRBKzYyY01VcW43a0lNc0lLT0ZNUDB6VldGcHQ5NUhMK00z?=
 =?utf-8?B?S3dGSUsxbEw0a09FcDR0Mm1lelZNZGw0c085ZlhLUklLblVyWWpoOGxlVXNX?=
 =?utf-8?B?bXNCdkNtMXFvVlBKaGxRcnZ2Vm0zV1JuUHhTT2pYTlBuYW1CcTJPRCs4aDE0?=
 =?utf-8?B?QnVwSzFLb0JkbjhQaytacmJYNXR3bXRTMVlSOG5rVlUvTG9QN0VzYmcyVVd4?=
 =?utf-8?B?RStwYm5Qa05wYkNvN2RMOFczTWJWdGhSanRQeEswYkN1dFpGZzZBNHp2MlhQ?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77257673-7359-4140-947d-08dbfa4f9ba7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 13:46:42.4909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJH4vAkdYFo/1Gv8q5FgWd41O/03R1eFQorWTbyPznF7qR2zmf8GyahMw2HurOPz6V8cKC+mwyDd0U9g89QNsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 13:46:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14026

On 11.12.23 13:19, Quirin Gylstorff wrote:
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
>                 atomic-install = true;
>            };
>     }
> Changes v2:
>  - The efibootguard file is only added if the new variable `SWU_EBG_UPDATE` equals `1`

What about only updating EBG, rather than always bundling it with a
rootfs & friends?

Jan

>  - Add the variable `SWU_EFI_BOOT_DEVICE` to set the device containing
>    the efibootguard binary
>  - Add the variable `SWU_EXTEND_SW_DESCRIPTION` to all extension of the
>    sw-description file
>  - use atomic-install to update the binary atomically
> 
> Quirin Gylstorff (3):
>   efibootguard-efi.py: copy signed ebg binary to DEPLOY_DIR
>   swupdate.bbclass: Add SWU_EXTEND_SW_DESCRIPTION
>   swupdate: Extend sw-description to update efibootguard
> 
>  classes/swupdate.bbclass                      | 47 ++++++++++++++++++-
>  recipes-core/images/swu/sw-description.tmpl   |  2 +-
>  .../wic/plugins/source/efibootguard-efi.py    | 13 +++++
>  3 files changed, 60 insertions(+), 2 deletions(-)
> 

-- 
Siemens AG, Technology
Linux Expert Center


