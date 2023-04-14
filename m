Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655FAC77B6E
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 13:12:21 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.74])
 by mx.groups.io with SMTP id smtpd.web10.8759.1681477939766176378
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Apr 2023 06:12:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WCPTwR8z;
 spf=pass (domain: siemens.com, ip: 40.107.8.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZAwHwWSNyYMusI8SsAv+7R9W2rmlKSxl3ezeURIBNNEuNzes0rqStnQ+VMvaMB10o5UDUn+fzLTY6ytmPq0/62XKPrpEsh+Wd01yMD7e7Ab8Qs+O49yJWKc95HWwv999vCkAcgEocYx9kzl8nV3vSQPU8X8qJN9tLuZmLM0pPCu8V4hBMH370qNEKkG5HxRTh+yt3P+j3xsd0PBV6ylXXY2gQNmm9r8mHk9DWVtjoEYP1xCAWo2b2MMRIhoUxQu5EQM/+HF21jdBafgVxNMG2YsUh09hKvP18ehQlLWHbC6muBEwel9iHfs1R+GPL6oygXAzgc3nA61kNs/LBsSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2X2h17Vf6S00gYLB+flchy55oKATNtP/2rB6RSrGBR4=;
 b=MCHWnAJFGb6zYB4AFvaiXydJRXpQ9UmFoaswb67lCkPMyTqmW/E9GRPqIaLRXRTpmUIAG4oX16qjMWj3Y07+GLZE1vYUBrEWxAriDrU/Tgme3eoIvLFH2l6xgrpU1P5aWg1c4m/hu77bpnmy+nWwNW3xdcxdHomguz1zUMWzomU73G9V4SIjgBLexiyUllGIapldaED5b+PBNYzM+ainnXI1eFRU/1ZPYBUG/O/ZMWX5oD5342FSA7uWIL3glgXu/4xuyPi37kYj0DMmugAxEAUR4hb/Kvx//G80bTywqSZxvcy/8e6pntZEgOXfIul/geW1Pn/QVAtHTq/TIKGE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2X2h17Vf6S00gYLB+flchy55oKATNtP/2rB6RSrGBR4=;
 b=WCPTwR8zcFlx7waoR0Y6Tr7krod8bmNGzqf9H+dxGw92y2IdahaJkBj2IXQaBnN+x/Q47jZjLMMqa/jKxNB7/EwSbwTNF/EbIpV3utApn7M1YDPmpZflInJq+ktBTPQGnKFjcqoIViTISlZcyjW82RCqVKsDumAc6Zny1CERH6g6vpkG2Q6q7lqZNBZFnKabfiyHj4n3uLXb4jZWq36w4y8syk9Q60nryeHvfss48GlCbsWfdZrfx0+067oQIUVSl/BsGjs4/BwqTE/VFr3NS0J4v/ppDI9XaXbQk51Sul/Juk93OzIS7f1zD7nAyqtq0XKmzBcEnBUWzz0Gp1pCXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7378.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.4; Fri, 14 Apr
 2023 13:12:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.004; Fri, 14 Apr 2023
 13:12:16 +0000
Message-ID: <0f3d8c05-e93d-24a3-95fc-f934023a9e09@siemens.com>
Date: Fri, 14 Apr 2023 15:12:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [isar-cip-core][PATCH 3/3] disable compression of squashfs swu
 artifact
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20230414091348.676809-1-felix.moessbauer@siemens.com>
 <20230414091348.676809-3-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230414091348.676809-3-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0143.eurprd05.prod.outlook.com
 (2603:10a6:207:3::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: a58d6460-435c-4eae-1b64-08db3ce9de69
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iOq5IhNZna9XY0Of9ZnoL0bQZV9QmotMqBsu+2NhGVX+oi6+KZp/bgqVQdWK+shUr3RufVi6j1vRiMfg1AjRuYoCpBZd7kjGxxomLW6JBFblhXsyb8mKmS+hzECiP63SG1KTx1cHJGYZovpvoR+h7s9XcuGOLp1bwzxNtAnuXvu0xeQLrehtxe4ba048s2qS5jkpLlIzE4ijr1TGxI69j3qwhO6I+LsnLV50QXuMysUP0TANZbP6LSgnU2vTGLj3HVNy/cd8tMQn9JYr8pqcFKKzN+iLNy8V1FwoS7EXlgBosfQIftASqhQCN46gf+QjQzlt2+OSV3qp0X2eQwtr8OBKn62c9DCEEBZhtYWzrKxPozy6DuOEfdOY/oGla11c7JrvLglo3sCJE0Ixe9S7PF0SUg68GLc/GZMLwwh+u8auG8aHR7gAVSafPQoYsZYqYBdt73mcsRSdRejyNzzItX7i1tEjPhN22NCGck/ltrVdrS55i3wjkFUOtHovkM4A/dAroa7E8EzjxYROa20OfyxsusaLA9eeY4GaRhkLAFKEaEZTVgegbe/V56w4zaAUqFbeq1SACwkfRAeblfmOQGmFQsUG/dW9sG3A388hCaF6N5kpJvq47JeXyUJ6KH0vLDyvpPYRyRJJH2iVQsgN0A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199021)(316002)(4326008)(38100700002)(82960400001)(66556008)(66946007)(66476007)(44832011)(5660300002)(41300700001)(2616005)(6666004)(31686004)(36756003)(86362001)(6486002)(31696002)(107886003)(26005)(186003)(6512007)(53546011)(6506007)(2906002)(83380400001)(8676002)(8936002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TXRpOEs0MzVJSzRXL2JlY0p6bzFnaVp5cUpDSlVyUTlhYm1PYnBvYVBpU254?=
 =?utf-8?B?K1prekZKemVGY3NXeGI5M1R4VDJkRmptd1pTMzB1UFZQRzUrTHlDUDNJUmc1?=
 =?utf-8?B?Umx0U3lMSW5TemoxdGRaRTRDcld3eTlTMkVxTFNUSmZNc0N6aGhRYVBxM1hx?=
 =?utf-8?B?V2NSN2FLTUZoT1FnbFphTUJxb0Vyb0tKRFVTSUtqb085a1NuODh2Z2lvRGVY?=
 =?utf-8?B?ZnFFQ0RsTnpRK2NjNkowYjVycEZwS2s5SkgvU0YrbnV5TEVOVm9WRDkxYlUw?=
 =?utf-8?B?NjZhZDlQVS9LN2psdEJpWC91dEdVYmUzN3lRUXhRc2UyWXY0ejdQVmVXWHpZ?=
 =?utf-8?B?V0FCczMrbVhkN0JtaWFjN0dMaW44SnpsZUYxZ3F0eEdQTjZ4d240ajZIZSsr?=
 =?utf-8?B?T09reS9XYTlDREYxTkFJZU1FUnBRTng5WFAySVYxcGlKT2tCN0xNNUdHRXpX?=
 =?utf-8?B?enFVc0xMdlJLV1V6a0hBYlM5ZExxa1lQclZncE9heXBWQ2wzKzhONkJrKzdO?=
 =?utf-8?B?enlIWFgveFB2TnAzRHI1VVZCVDVMSmppejhmQ1FhKzhzS1QrTDA2bk9lbEpN?=
 =?utf-8?B?QjArdm9qMituQXNOR29oQmRqakRHMkhpWWRLRFIvVjJhZXRYV0pURm4rYis1?=
 =?utf-8?B?N1gyQzBBNVFETE1mSy9razg5VmZQdndFNmlBNGprZ3ltZWV2aEJGSDVaTmxJ?=
 =?utf-8?B?NjVkWU90NU9WU2pmNVVVRm9CeFhwTngxdkxmNEcrMlMrQ2o1ampteWtBOVdl?=
 =?utf-8?B?aFdUejdmY09BWm12MzQyYmtRcXM3dTI2VENhbEtnMTJSdis4VUtqdDR0RzJo?=
 =?utf-8?B?eEdMeGJEUTVxSTQ2VG9IU2Y3NFV0VXdQTENsM29JVVgxalpOVVZoZjZLc2k4?=
 =?utf-8?B?NVlicC85dVZsbzZaeGtnMFZuOHJmMCtOTzJpT0VmMjR0MUNOcHpFSVAzUm1P?=
 =?utf-8?B?ZCttZ05DelhOTVpZcHZCZDM1T2REWjVnWW9SdS83VGU3R01NcDRYazVSUDdv?=
 =?utf-8?B?czNxaE1NRUpzNFJUanY1SHRVWFNxdE9mRnVXamVkS2kwZE5UNkE1M2ErZmw5?=
 =?utf-8?B?M1RnUjdlaUh1QVZ2Q1ZLd2JMUkpFSW1kWXEwT3JhbjZHa1pqY3RUQW5Uc2pC?=
 =?utf-8?B?YlA5ZlB1ZnpVbmVhYUpsRGFxSGJHQUhqU0VEalVhRHd1UUt3K2xueFFhUTZR?=
 =?utf-8?B?cGJMTysybkF1bHVvQnpjM3cyNHFtSzYwTlJBWWs0WTlvd2ZrRzVMUUpzZzZM?=
 =?utf-8?B?NEtMcGlYVzk0UWtORWhuV1NXYnZJaEhWTlFvb0laR1c2ZGVkVk41WUplenlW?=
 =?utf-8?B?dWRVNzgrMTBaeXMxQ0NsSFBiVHBJa0QrMEplangxMVBhbGw5QkFUSzZpOVkv?=
 =?utf-8?B?SUhwcGgyb3JST1dKNHJtR2Z4TU9sdU0yVmtMSWJHcEFlakhRbWZWMTZ4MDE0?=
 =?utf-8?B?NUEzdGx3dTBCSXFTVVp5VkkrK1MzVW1rd2FmNkhqZ2FISXRtRHFqaUVPdjhO?=
 =?utf-8?B?MjdJcDZNS1dMT0FSRUVpR25MSXVTYTgxRm1uMmliRzF0cm5ENWUxRXpkdVFq?=
 =?utf-8?B?WTRNQkVTcUVIK3BtS3R6ZnRxWm85YzhJV21CTEhNNWpSZzZqcTVPSTZtYWIy?=
 =?utf-8?B?SWw2dkZUMVFDV21tOHpscVlaQ1Bmd0kycG1wbTVoc21KQi93V0Fmd0lZSS9Z?=
 =?utf-8?B?TklMZEM1NTFQcE03d3VXTkhsVG9vTHlzd3daajdlWXJqbUk3N0NKU0tWTldC?=
 =?utf-8?B?WHlSV0J0bTk0YnFvQ2JsM1pabzBjMm83bUVlM2x2eS9heVo3QUdQYVVzUzhy?=
 =?utf-8?B?ZU1wT0dYdXlMVUVaQTl5V0M1bmd3cDVEUTBOM1l5OG1Td3FvWmtJZ2xEbFVz?=
 =?utf-8?B?d1cvOHY2VWFhMjAzL2RaMGIxYjR2dU5JVEtmRXc5ZFNBVmVwSldRQU5EUi9s?=
 =?utf-8?B?N2UzczhzRHMzdGJ3R0dvcUtZZk1GUCtWMytyTkRWNkRCejNUd2VPNlhXY0NQ?=
 =?utf-8?B?MHFEZitEK0FHdFVUMlgvL3ZXV2grM2dmM1JMSmhyNStYTVE0MWx0VGp3NVUr?=
 =?utf-8?B?dm92Vk0vTzgzOGJWeTNIZGhtTyswK2tocTRJcGtEMTNKbUFtOG1URlRSM1du?=
 =?utf-8?Q?N10AoxKD/jT1+hPTdaMSKE2hf?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58d6460-435c-4eae-1b64-08db3ce9de69
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 13:12:16.1788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hfuyj5Kzc2utgoDn+ROL4q0VV3Ysp6oVVUGBl3B3tCwArlbKOHVYHE7bJcgNbOFIqpw9OS/0CHbV+j0wOLa37Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 13:12:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11225

On 14.04.23 11:13, Felix Moessbauer wrote:
> The squashfs itself is already compressed in the default configuration.
> By that, an additional compression of the artifact put into the .swu
> file is not required. By disabling this compression, less temporary
> space is required when flashing the image onto the target and also the
> overhead of the decompression is avoided.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  kas/opt/swupdate.yml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index 236b3c4..2899d6c 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -21,6 +21,8 @@ local_conf_header:
>    wic-swu: |
>      IMAGE_TYPEDEP:wic += "squashfs"
>      IMAGE_FSTYPES += "swu"
> +    # squashfs is already compressed
> +    SWU_COMPRESSION_TYPE = ""
>      WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
>      INITRAMFS_INSTALL:append = " initramfs-squashfs-hook"
>      ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"

Thanks, all 3 applied to next - while fixing up a trailing whitespace in
patch 2.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


