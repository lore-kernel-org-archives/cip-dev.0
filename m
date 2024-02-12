Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A7FC4829E
	for <webhook@archiver.kernel.org>; Mon, 12 Feb 2024 18:46:50 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.81])
 by mx.groups.io with SMTP id smtpd.web11.14748.1707763600560738470
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Feb 2024 10:46:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NC+45KUJ;
 spf=pass (domain: siemens.com, ip: 40.107.249.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ld5plhBy3xFwbaSSj6JCmk5TQUTrM0LFsYayN8TOXQiWdtnb4SRzNIdjrKVGxhvxVSqnhNFQ/1/YZONjxnY1SlIdl03gu4gOudVMfOkPgt994aEzbrnIovsIxgdb289aguGtF5zMHuFB2aUUOLKpviKbJ+b2riSw2lL4JecWovECs8Zxq3UPeJj3lYWQhrmduXXNAV/o0hO0l89LmFmk/Q274DPoPwPCcB3B0E2AXcCMp4kyxfIUHKuDfwuoOFu+opuWn8bd7yGp/mEx4qz5w3QxwOj2C3Its4Uayrfsmjfxnix8uISO9laJyXgSIJSJuAPV91sGy318mnt+7ISFWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgLhX2f16kIr4M/X1so3aXzeMPKYNhhTKfdHKS4RogE=;
 b=KROpBvZmmsmqwEr7Kg/I0YON3ji5TNgXQp/DKRZQupeMblB7zaXWINPo55etigzLPUjUjCack3L5S0x/8K4GEnSBMEwFvq/J/HM2bwMW5RZK74wOcnzAB8bhoMyxdHHe1GxWnk3nlr2GsFcvJP8IEGkzHo0oJOn2V3XJYyXJ2HuS883jk9YNWKsWnYb0D5rmkmhpISNclthaVFh3LXPYbYi7r5D1jb7o3WURCpVBm07/fto0u1nht2FjBk1vNaXHRGzEb1dIQECZNm5irZ/SSB6+dRSGJ2/xOjDE8sPzUdn8M4HmHklnPXHse74WtcndZYgvriDoARnxrVes9SO3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgLhX2f16kIr4M/X1so3aXzeMPKYNhhTKfdHKS4RogE=;
 b=NC+45KUJ6F10RpViuZ34qyDl1uUsmes0i2FNIT6BNCiM5YJwDGcD+SlHcMP9IFDz8pRoLDcYEmsI/uDE+10FhJGn+9bPbqZSFV/yA06/+Nmx937tryLOD8YnDvTz3F+JrjYBc5nAr8Fdq/+xkL+uobK2rP7/GgT1Swaw3ZK18EAXqHpUnNOhENT08Y4vJC68CAfDZgVc+t0YxC918rkKExUom4CtIa7UmHx+DxufmCBdL8iVXEJnoU2OJ+2vGa+P/2aeyLHQ+5VUGnI5rIACywvwwGq2sVKmFodoTWjOAAumxhzcPzzQPDU7SwTWygj58aHwCsL6yw5lxZpRvdIN3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6196.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Mon, 12 Feb
 2024 18:46:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.028; Mon, 12 Feb 2024
 18:46:36 +0000
Message-ID: <a07df7ad-47a6-4449-9645-bbfb87c762b3@siemens.com>
Date: Mon, 12 Feb 2024 19:46:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 2/3] swupdate: set
 SWU_HW_COMPAT
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20240207134505.3286003-1-Quirin.Gylstorff@siemens.com>
 <20240207134505.3286003-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240207134505.3286003-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 243752d6-2981-4044-a4ae-08dc2bfaf0c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IvsBaixm3bPkcLz096d6SRZfsEbehLkDRFb2j+PHChTtBiBUXHhBY33QLAZ06nqj0ql8evImvfEDuueHyL/ZXbh3a70HlM6l58yckStd/3IORNTG5WuMS6tuuVGSeg/PEd6teRYDUg8dkhI6YvM+iJbYS8uQsMoIZjSpsaMr7JGj0yNvLcmvXnIkg3hkW23m29W9e6YDT6Z1CzrXtOVScL2YvRtP7b8Vc9dKR26J2c8b9wKoCqhnIsfJJQhEdXphB0WvmnePLNOdD6fJEFXEu3PoZ5w9fypCu/kAj8A3LF+A5qRHUyngj+Fnqp1U3UMB6XuierSv9QEAnB2LpKoouSNCSXUFjied1iKPKVeLE2DuEaLMlSkrYcw1xmBDxSlnCOEkgNm+Av9VGj4CW9FmEjFzakQ4BxW1UCkIlXCzcZfYmebkW0f/7DakVk4HETbYqGbr9PYLaX01HOLy97qh66Wz02yeKgcrh2s5nWv65v6cjFP+HlNIW3bTxdyY9ZYGpUiL2nk/nkhURw7MrcNt+HPNmWqXmjI4WtrFmYumUV/OKWOvZ3QPQbAFhARH+jsE
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(86362001)(31696002)(38100700002)(31686004)(82960400001)(41300700001)(2906002)(316002)(6512007)(6486002)(478600001)(83380400001)(6506007)(53546011)(26005)(2616005)(36756003)(8676002)(8936002)(5660300002)(66946007)(66556008)(66476007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S1FZZFlreWprM245ays1YnIwNWMrZkdxUVlDL3llempQakhRaCtOcmN2R3Bt?=
 =?utf-8?B?RjY1cmdoYXU5Y3A1dTZSRkZldWRxZ0ltNDIvcFg5U2VUT0FxVXlDa0tzZWZX?=
 =?utf-8?B?eUY0d1FML05OZ2oxUWxTL29WYXNIWXJLbXNiRzlJY3c3Nm4wdW5ES3VXM3M3?=
 =?utf-8?B?VW9YcjlOL1ZtckFmb0R1T2lrajQyenhsMEtUVmdrUFV6Zms1UCtXR2dLRklu?=
 =?utf-8?B?ZHJGeHlZTEgxOHNpaXVuK0lkNHp1bVJBSmdpemk3UDliZUs3cnQ5a3N0OGp4?=
 =?utf-8?B?VXNPT3N4ZHkvWTdWZTNyeGpUMW9wdGMwTzArVWNzSDJQUVlwUHRzKzcrMGc2?=
 =?utf-8?B?cnFiUUo3d3RoQWs2YjhDbmlkcjlLaE1yRTdxZUR0b0ZlK1liQXhRN2l5cmk4?=
 =?utf-8?B?Z2lMQzJUajFkV2dmb2lTNkRFMXpWeDRTUmp3Mi9HZVRmQWMzSnNMM2w1bCts?=
 =?utf-8?B?aEpKNFhDWFVUYWtMK0s5eU9ZNXpjUmJGSk1mbDVHN3ZOTEozTmp0cjFiYXBE?=
 =?utf-8?B?Z0pOM2lENzlDQU8ySVpVdURjNUdjbTY3Y3VHU1AwcXpTVFpWcjA1QnN0UTFr?=
 =?utf-8?B?SFk3QkJHcjVLSmpLWFlKVjRWcEpZS2NBV2xBOFc1cUpwb1VmSkpWeUNQRUFs?=
 =?utf-8?B?NjREekxBUzhZMUI1cDZheks3aVJmM1FwcVlJODYzVS80TTcweGZzc1FFMjRN?=
 =?utf-8?B?Y3NpUmFiNURpVVRWZjZBdFVnZStHM1BkNkFMUTRuSVg1czZDN0FHVVJ0RVhQ?=
 =?utf-8?B?T2lwSU15a3pEaHBWbVRiYndwTFphd0dRMGx0UW94WVdGaGEvdmF3SjdqWXVm?=
 =?utf-8?B?aWpkY0VaZ0l1dHdxdXllcE92bHRTT0NSVldKZEZkT0ZkZ2JNUkFIcXRBdGlj?=
 =?utf-8?B?WDBnMVlyaDJZM2JoS1pwbFptM1Q4R2ROY2phdXFmZHd5aU5vRXZmd29QeUtY?=
 =?utf-8?B?OFVHb0o3a0hGcW9YS3BLWW1SZlpXU1hoVmsrY1dyeHBmSisxQWw5NHJnT25m?=
 =?utf-8?B?T2Nwd3dBOGZRMzQ0bzgwbXdtdndpVHVDMlpQSk4zdU5CV0hFZzF5dko3UlN1?=
 =?utf-8?B?bUtrK2NyRytLRDZLdERsNm45RGRhR2VtME11Qk5rekJOQUF0dC9nb2hVRHV5?=
 =?utf-8?B?cS9peXlIOHlZQ0VRbzBnb20wNENUMmROeUN2aDVuRjlPb0k2WU5TbW0zdk1q?=
 =?utf-8?B?cExBdUV5KzcvS3hYR1lDZGRxVUxUaVU4ZVlCSlE1ZXZzUXdOYzZkMDkxVDFu?=
 =?utf-8?B?WUdzYlhCRDZ6S09MdEFoUm9ndmgvUS9ad29NNmwwR2E5b2pXZmRKanVISk0r?=
 =?utf-8?B?Vks5dXlEZTh3QWdCRkt4a0c4MmlKZGtnU0hLYlFsWDV5SUtyZnBXYkVBTVIv?=
 =?utf-8?B?MVUzQ1hQSE5sV21PQ2FGVyttU1B3T2R3NFpDUWJDQ1BNTy95N0VVYktaelBt?=
 =?utf-8?B?WnVuQnlGbkRPTDQ4enJjRmZiSjd0SkRFeFE1Vk43Z0NMeUJxazRCdEJvUTZV?=
 =?utf-8?B?V1hZSGNFaTRtY2pQblUxMTZpeUZ0dDhLTWtUU0JFUkY1N1E2dGxrM213d0dl?=
 =?utf-8?B?bG9RSTF4bnhWVW1OT3pjU05OdDNOS3lkUXBZYVhoV3hmbm5xeFBWQ1Z2VTMz?=
 =?utf-8?B?ZDM2R1NTZVZiaFkzUkZ6Y0d0d2U1cktpUlF5a0RqY0dscUpJMXVLWHNjYkN1?=
 =?utf-8?B?aHpnSTZ0R2NTZU10eEMxbnRpRGpUbE43TmpOQlhteTV3R0VWWDdRQmNLZ0d5?=
 =?utf-8?B?R3JNdUREZkxBTEVTbXZFWUpjR2VsN1Z6UU1GcmpPdUpyN05zcVhHb0tvVTJv?=
 =?utf-8?B?R0EyQko4S3B0Y3hJMjRXb0ZDY1BDMVUvVjByY2ROUVNwcC9qWVNDa1ZYWDUv?=
 =?utf-8?B?TytuaHVVZlVpU3VoV0VaRmF6Qi9IYXRYdWpOdW5kbFJyTmNYZTB5Q2w1T1ZL?=
 =?utf-8?B?dU0wSEpqR2FTUGY1QkpyVGhhUXdONnNNMzljRm9IV2JRa3VNbHZRbTFOVFpH?=
 =?utf-8?B?c1U3UXJLQlhpbjVVcHdjancvRk1ZOW1Fbm9FUlRBT0tkaGxsSlpGN2gwbUpP?=
 =?utf-8?B?bCtYVXBpNlZ2Y25iRGRBVlVuS2Y2V2owRUVVVU9zYXhuZXNuYXA1ZDl1TURw?=
 =?utf-8?B?d1JDQlFBeU9rM0dyMWlEb2NkUTI3d2VHL24wUUlRWTJWT2grZ2xDWGxFM3ZQ?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243752d6-2981-4044-a4ae-08dc2bfaf0c6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 18:46:36.2110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXJe4+ZyLiWXLDAMvTZ4jcAWfJjqQfMmLoWB5Dq2iHVfEh23JWokqvnwozBDDVAlnU8quJaFGp8f0pbkIVS1IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6196
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Feb 2024 18:46:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14930

On 07.02.24 14:44, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> With this item SWUpdate from Debian can be used in place of a
> build from isar-cip-core.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/images/swupdate.inc                    | 2 +-
>  recipes-core/swupdate-config/files/hwrevision.tmpl  | 2 +-
>  recipes-core/swupdate-config/swupdate-config_0.1.bb | 2 +-
>  recipes-core/swupdate/swupdate.inc                  | 3 ---
>  4 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 4983f7c..183503b 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -13,7 +13,7 @@ inherit image_uuid
>  inherit read-only-rootfs
>  
>  SWU_SIGNED ?= "1"
> -
> +SWU_HW_COMPAT ?= "cip-core-1.0"

What is "1.0" in this context?

Jan

>  IMAGE_INSTALL += " swupdate"
>  
>  IMAGE_INSTALL += " swupdate-handler-roundrobin"
> diff --git a/recipes-core/swupdate-config/files/hwrevision.tmpl b/recipes-core/swupdate-config/files/hwrevision.tmpl
> index ec1d667..1eb0996 100644
> --- a/recipes-core/swupdate-config/files/hwrevision.tmpl
> +++ b/recipes-core/swupdate-config/files/hwrevision.tmpl
> @@ -1 +1 @@
> -cip-${MACHINE} ${IMAGE_HW_VERSION}
> +cip-${MACHINE} ${MACHINE_HW_VERSION}
> diff --git a/recipes-core/swupdate-config/swupdate-config_0.1.bb b/recipes-core/swupdate-config/swupdate-config_0.1.bb
> index 6991321..260c0f1 100644
> --- a/recipes-core/swupdate-config/swupdate-config_0.1.bb
> +++ b/recipes-core/swupdate-config/swupdate-config_0.1.bb
> @@ -14,7 +14,7 @@ inherit dpkg-raw
>  SRC_URI = "file://swupdate.cfg \
>             file://hwrevision.tmpl"
>  
> -MACHINE_HW_VERSION ??= ""
> +MACHINE_HW_VERSION ??= "cip-core-1.0"
>  TEMPLATE_FILES += "hwrevision.tmpl"
>  TEMPLATE_VARS += "MACHINE MACHINE_HW_VERSION"
>  
> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
> index cb1716b..818b431 100644
> --- a/recipes-core/swupdate/swupdate.inc
> +++ b/recipes-core/swupdate/swupdate.inc
> @@ -34,9 +34,6 @@ DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d
>  
>  DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not d.getVar('SWU_SIGNED') == '1' else ''}"
>  
> -# deactivate hardware compability for simple a/b rootfs update
> -DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
> -
>  # add cross build and deactivate testing for arm based builds
>  DEB_BUILD_PROFILES += "cross nocheck"
>  

-- 
Siemens AG, Technology
Linux Expert Center


