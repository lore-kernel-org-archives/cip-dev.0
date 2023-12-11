Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F89C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 13:45:23 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.78])
 by mx.groups.io with SMTP id smtpd.web10.8489.1702302317709398409
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 05:45:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ob4Z4AiS;
 spf=pass (domain: siemens.com, ip: 40.107.241.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjtTBeBRUWo+7NUplpLZNmBmJMa1uP8BXJsFO+4KVF9z5EBLs3Q1IL6UyGdP6osBv4nVpZHPCK49LAbk9c6V8vmUtXdV+fEvDV5mX+5BhlzDKSNfC1LVHgAAdD1YENlVsD9UlHTuZlhAnYeN5OzGSwKpne6xpSKgddRmnLzlT4MIEIH0AFavojPxC/gDBL2ftL78gj45QFew9mpVZeNYYqyd+cdYlqtaVEjm+383G45WPBI7O7HwFjsN+bJdCQaPq/4TRktHu9LriJAnhKVrf1VM9O/tcLt+V0c1Dnw/UNUswZlNPTSt52qVTRm2/gHrWpnPqypMcnpd61h372v1hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0gmyXau+2nluvRNQTiCr1gYtyQPcTvd4/9PaCSYrzI=;
 b=mOe8+d2UPiP5KuBhfJpZDD9//L8wZ71zY2Px7WFycLDqjaDfllj1XX9dQjmxijYt52gG3X0ty1GX/dnee/ATFMvNw0kz8x70FeNCJTX5FKtIKYaOV36+J8B4Z0sNQeEfWb5Xq4/p7LLeSgaFdoiGPclwcmD6recyoV7C0DCrqvr3ohsOa7f4ukTcsN1fBcgNGakgQ9UBlRitin+fivI5L7snJx9MNegR3Gc6Xo08x7pJ3ljXS/kxH0TlzDmggfsACp0gDfLEAKKFMRm7rrUUTG8OgIPEmfR7I+euasi4l9GOUBsBFGSGov5C66JUlEK97esBA3+PVWbmY1UhtPm6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0gmyXau+2nluvRNQTiCr1gYtyQPcTvd4/9PaCSYrzI=;
 b=Ob4Z4AiS/O/Hg2+Yy/9IF5QqINAQ/E2S0T5jesKniiEofgJLOOi/cp5bh8wceRGFIGs8+odDcmpMSr0lwmbOAH/UFScXUWIBEDtcr5wXGUzUfFFLVEq72hMRF5+IwLgeoX7qFI/GUWazkCx1nvWWemnGOrGBg2/2VCdzz+ajsme7nP7sbIJV1rFAiQpydFPu0RiV6Vwlmmq951Oafere1ZCEBYArZMrZaqtwQtRbx2kwPM1mAMuEWkeFGkNFAkGjtwJqAUw5XeR90NjbwX5/d8mK8azLHIPzBtBaxPaV3aLUNo4+0xQoNMy6PRQwIvWNPwX84aqmsqWgjpLWkqmz0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3786.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 13:45:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 13:45:14 +0000
Message-ID: <1b67beec-20b1-41be-b8b5-614121e8d1c7@siemens.com>
Date: Mon, 11 Dec 2023 14:45:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dec][isar-cip-core][RFC v2 2/3] swupdate.bbclass: Add
 SWU_EXTEND_SW_DESCRIPTION
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
 <20231211122528.486786-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231211122528.486786-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3786:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af1a822-2600-4d82-2c20-08dbfa4f6706
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cgpAfspqw+g+E2OBCrU0W7cUZMtvyMf/bvFGThApbn3Whtijxu8I9c7kvDJtYGC+0VtDIHbZLDfygkH5ACQLVrN14fDFFXt9vZ8nPHAPGyKrlu7Tu1YF8Hw/A4gK4DbTHRfL40Tv0XEpR/GcJsGEaNGMI8RkgZPaddFom0TopKHJgfqfI4HUxvubmuD6Zi9obOLeiD3aZoeoRWIZSTERKeUb/quHtRBlSKUnszbT0Pmuw6Q6ukWGYcFBHSpD3e8Kbi7ZXfmrz5mtyhT6Sj/UUVItsyeQ2un3vjexApT00whZDpOpBr6cEDlQ1sBSRhKwATdb1C0SJd0ySbSpGS8P3dy4P0h/sBj6bv+IA9Ubih/AF9eBCN3IF7ZYDXjHnj3jRB1ID+qzAvEuJeuD/MRZPtx8coY+vS9MI/wfOVEdNtST4RZ7QIPYfi8ou8aWDcUEx0dS7ISWsQ1aXQQZrdHprcGJSAFq3dPcTuYOHVMab6Dw5s8nKwzPrRpwjh6Dt6+G/rgvfqxNKfIOmXcxvbLfd5qOCd4VIKtyX2PdNNXAvF8E37h3Z5h1VnkpA0KhWhsn2i4njSTa44or1J8Cza2/YFeAj+HBEnY99F9mkL1M1gCs0k34HboMNO/4jNqgnqUSV9nUpdKR8cbJn8kZ/4GwqAetyVTf0z3Ck3gwOFOBacYJk1DdhIsudeoIR7HsdTTd
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(41300700001)(38100700002)(31696002)(36756003)(86362001)(82960400001)(2616005)(6512007)(26005)(478600001)(53546011)(6486002)(83380400001)(6506007)(5660300002)(44832011)(316002)(66556008)(66476007)(66946007)(8676002)(8936002)(31686004)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cFBzQmpqNHhzVUtOSDIxVHNmdEp6WlI1V2ZrRVBLMlhIMXh6Rm5yMCtRejlD?=
 =?utf-8?B?bXlMWU1Ja3pZcDM1RHMxS1hFTjhnejk4ODc2dytuRHZqcDJaTGExNEJud1Y0?=
 =?utf-8?B?M1BwL055UVFqaFpWenhXY1VzbHhqeUsvMlFBRURhU3dTODArcytEZHhnV1FU?=
 =?utf-8?B?d0xJa1NwZlN2OENwTU5Cd05IWU5wdGIzYS8xVUNpeFJWVENpb2RWNlZraEJG?=
 =?utf-8?B?a0dpTXliWXBvbXV2enlsRUxVNGpkbUJjQXlyMDZRMERma1NFTUFFU1l1aVNK?=
 =?utf-8?B?WmF6VzdyQlNBaDlOSElGQVN0YVUvOXRxMDd0a3ZWK05PeXllVCtCQit4Yllw?=
 =?utf-8?B?d25YQUxnd3AvSXBXZ05aSjg1WVJKTU44RC9QY1BpR25aRmFEMUxVUEZjU1JN?=
 =?utf-8?B?QlVwODNIdjNkWnkvOHJOMWRrbVpxYWZ3dGFyK1p3NnpzQWMzME40K1g1WWRi?=
 =?utf-8?B?d1FPOGpKOXByRUpBVEtJRS9BRFpCZWFqZ2Q3M0RBdytaazNETmg0eVJqQzBn?=
 =?utf-8?B?TjFLMTVOOXZuZDlvNVQ2RVFjUTZhVzNybDNuVnV6ZFhLbzdxTlk3NnFQTmRm?=
 =?utf-8?B?aTBFL2dwb3dNZmt6T2wwcGo0Z2pJMUNneFBkb1AvR2JBeUsvL3dyTTViM3JH?=
 =?utf-8?B?dHBqbFU5R0JWWCsrNDBDRGppamhlaHYwOUM3YUtEQjNCYW9oc2gwMm1JSUpz?=
 =?utf-8?B?bDUwakQ1bHl1ODB1anJSVXdJVEthUmF5RlViQ3dtT0U5bDJXTW4rZlBoSDAr?=
 =?utf-8?B?YmVUb1M3VEw3Z3BlaDUzSk9uZmFjT1lhcXViN3RYZ0pxU3g5a2FINGtSajBM?=
 =?utf-8?B?RnlzK1VkRGhScVBFR2pyT05aS1VBc0c4a0xtT2JYWExWcHF6K3dkYUFYZHNx?=
 =?utf-8?B?R0hldWxzSDR4cFVkR29KbFQxV0gvOXBXdzdoWU9jWW5GMVlaT1ZXL2ZMenFB?=
 =?utf-8?B?TlQrQ2VNVHlNZ3ZVVGU1ekFPZjBNRmlCelc2QVlwYWFEL0lKMVI4ZEV2OFV2?=
 =?utf-8?B?WkErR0t0U0JFS3B6ekJHS2ZjYVo3R1IzT1d4WTRxUmMydWd4SEpmeVh5WFNO?=
 =?utf-8?B?Vktxbk50dm01djgxZFRnam44SkZBSHRoeDJER09pNW1FS1Vrd2kzZ0ErelhK?=
 =?utf-8?B?akNBMVc2czBIamRGT2RjSEloV3J2czVzamM0S3Q2ZXFTNGRyeVQ5UDBhMis5?=
 =?utf-8?B?MmRuaHowVGozN05FSTJqWWZhMjZ2WXg4QjhuWEVMaEJzOEh0OUlMT1VBWnY5?=
 =?utf-8?B?ZzIwTmNJZjJDZmFVRWtMSm5lM21ReUVLMGYzdWpPa1hDZGwvMGFuL0VqR0tw?=
 =?utf-8?B?ZEdralJ4cW8yWTBKbzZQNzN4Nmt3VURwVWNNczhrYXk5TGNQNFFCRTljOHJV?=
 =?utf-8?B?RmlpR2V5VFV1SmlGT2IxYi9EckVEQ3NDQ3Qvd3J3TTRkVXZrUGQ5V2NoVGdK?=
 =?utf-8?B?UEY5YUpaNkVZNUpRcGtjbU11TFJNelRvclBCL0FRaU9LSFJ1ak42aHJDYzR1?=
 =?utf-8?B?Nisrdm5uRWxyUHgvR3Jjc3VGYnZ1eFlvQ1p6aGlJbEcvSUtveG8rM0ZoQmhI?=
 =?utf-8?B?d3BSbVpzbHlscFRhRFRHWnUwTHpsYUsvYUpyUFBFMHRQbmhmODdMUXd1dnpw?=
 =?utf-8?B?cHczbk15QkErL0Y0ZEs1MCtBMHR1a0cyYitGSFZlL1RHekxCaGVBOGZHNWhj?=
 =?utf-8?B?dnNwakhoMUdvaHJoUzBpVDJLMGN3L3MxZXY3QS9scHJsNndJc1FqOTk3NmNs?=
 =?utf-8?B?QThpaE5EbXNIaTI5QWoyZWF1ZkpwaFRiUlBERkNxeFNRMGxRQWRLZHBSOUNH?=
 =?utf-8?B?UnhqM1BiVWxvWTVuYjM3S2dQSnR6WFdUUjlXWkJNTXlIVnpwZEVLa1ppT0tz?=
 =?utf-8?B?SjN6YzJxdWVwdlhmdGsxaitac2QxVjlUQjh0QkNTUDhZR2MwbzFGd0Uvejd5?=
 =?utf-8?B?QlVNNGZlTjEwYVNOSHhBQzljS09MRlpudjNJVENUZTZMS1pkdEk1OGpjUVJJ?=
 =?utf-8?B?aWhrVGxaZktwellYY3A3L3hULzlMZjEyODg0OWUyMVFyZFJySWk3Y2VZVm40?=
 =?utf-8?B?YXdZVkR4ZURreklHaXFFZzJFZ0J3OHkycjkrcjhHU2VqRGNHNzYwWVJCZ2Nj?=
 =?utf-8?B?QlFkRUwwblRhWExJV0VNUEVkWGpMVEszWVh0YlZIQWpuYWFFNkdXUzRHOWFC?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af1a822-2600-4d82-2c20-08dbfa4f6706
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 13:45:14.1799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6jUjL5rtStRXELrJU5CGPEUfnNMLFUW1/gwzDY56oavEoPUjPC6lmqaoC7DTMEv4Vw+5JTWSNJ3R+Ne6HnPdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3786
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 13:45:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14024

On 11.12.23 13:19, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The elements of the new variable are called as functions. This
> allows the user to extend the sw-description file with new template
> variables and new entries.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/swupdate.bbclass | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 117f9fe..0e95e3c 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -22,6 +22,7 @@ SWU_NAME ?= "cip software update"
>  # space separated list of supported hw. Leave empty to leave out
>  SWU_HW_COMPAT ?= ""
>  
> +

Spurious newline here.

>  SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.swu"
>  SWU_DESCRIPTION_FILE ?= "sw-description"
>  SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
> @@ -53,6 +54,16 @@ IMAGE_TEMPLATE_VARS:swu = " \
>  addtask do_transform_template after do_generate_image_uuid
>  
>  python(){
> +    cmds = d.getVar("SWU_EXTEND_SW_DESCRIPTION")
> +    if cmds is None or not cmds.strip():
> +        return
> +    cmds = cmds.split()
> +    for cmd in cmds:
> +        bb.build.exec_func(cmd, d)
> +}
> +
> +SWU_EXTEND_SW_DESCRIPTION += "add_swu_hw_compat"
> +python add_swu_hw_compat(){
>      # create SWU_HW_COMPAT_NODE based on list of supported hw
>      hw_compat = d.getVar('SWU_HW_COMPAT')
>      if hw_compat:
> @@ -61,7 +72,10 @@ python(){
>              'hardware-compatibility: [ ' + hw_entries +' ];')
>      else:
>          d.setVar('SWU_HW_COMPAT_NODE', '')
> +}
>  
> +SWU_EXTEND_SW_DESCRIPTION += "add_swu_compression"
> +python add_swu_compression(){
>      # create SWU_COMPRESSION_NODE node if compression is enabled
>      calgo = d.getVar('SWU_COMPRESSION_TYPE')
>      if calgo:

Jan

-- 
Siemens AG, Technology
Linux Expert Center


