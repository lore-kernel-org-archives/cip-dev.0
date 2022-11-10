Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92617C4332F
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 14:11:01 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.50])
 by mx.groups.io with SMTP id smtpd.web12.7905.1668089451907810180
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Nov 2022 06:10:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZP103j4o;
 spf=pass (domain: siemens.com, ip: 40.107.22.50, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFX12BbeixskwZhBiUQ7CcUN9Ts2S3nIahjRi7a+JOW8AIL/ziQZ7kbUPfZxZERnVZvOZgzHpLeQrkr4+5Vd+h//4Qwf3rUnqf79IQd9Zmty09g/MjLRq7JVbzTXd7KpZODb9Wo9ieXf4ExE1ooVnZhcfINggvFD8BjXFF+m6hoj+C/fM+pgyJ7Xk87X76xRAHBC2JCNdqjtpPl7H13Y8vBvTe2BYornF9yuA2IYVYkRVH2SXZSeXhIbwqM7kXoyS7I5Z7hggURjZoflek8Xb/rgMSrqKnjen8z4Br9JgL2PMlOx8eWi02eNLNjh0sP6ZkVNRzANGpUtRfnaU2rd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfZzTZtGO2emDZ9LqX2eFlDt1kjC15gK/rqhLY8Cv2Q=;
 b=he6MzKZDRgK2UQX0pQFi8O4K8VriZC0nbnqKs/jI6XQSO+eqt2oRNJrodHoeo4Jf9IFVGitSzEkgS8yXXjuk7HH2LlYiN0kfCniJPII4WSwC8O9XTMMjomHcPtxvK8O+JuQ6U1o2CHThj2C8nk21s69sUftLMZosLzL0INaQH5NAkDq9zTHkO2lxZ1+MXxHr8GPI6Mcju23SsR1FMzpWIZnUyBch5OHbumkklR7QCXPf9dBKKuCIX3SgjQ09g/L0TIU5C8zBRALdiBCLWCN/qdV2/wafQ9v2eQNNADP22Cg56ETFt/BHnm1SwyUdOr/Ll/EiCux/560cXH+9qE5FmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfZzTZtGO2emDZ9LqX2eFlDt1kjC15gK/rqhLY8Cv2Q=;
 b=ZP103j4oyKzEsbuJ5PHhE+kwj2rkn/f2XHqk9nIrH+CpnD2S+CXl1Rsf/Uzfg5bMqWTuoVET7HwF86rpyeyPRGKwEJSAM+fSAKJcS/bXoeKkcTcmo2ksgMS96LPzBAixCgaXfR+ksfRX0DhrGJniCoslWx17hHyMNM1QS03BjSgGpNA5rUEN8q45mslga1FvijjhvFPIEtwBkSBVXqbMmTVZ812JMsjcCqC1uDbY/0QEr1hXcUd79n/xsFPMd1o6NNudZ+6TnJZe6GeWQb+PWx2WBCJ62RFvH4KClGlKUceqiEAYw/rn00nwu/NqLBaKW9PbxCOL6gzSD3qH9nTt2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::7)
 by DB8PR10MB3322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 14:10:46 +0000
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::943f:70f7:47f7:be5d]) by PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::943f:70f7:47f7:be5d%3]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 14:10:46 +0000
Message-ID: <ae850f0c-e776-62a0-9d48-6fcb31bc106f@siemens.com>
Date: Thu, 10 Nov 2022 15:10:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [cip-dev][isar-cip-core][RFC 5/5] recipe-core/images: Integrate
 uuidcheck into sw-description
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com, christian.storm@siemens.com
References: <20221110124503.274124-1-Quirin.Gylstorff@siemens.com>
 <20221110124503.274124-6-Quirin.Gylstorff@siemens.com>
 <5eff709b-2022-8caa-7951-061cc273dd8b@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <5eff709b-2022-8caa-7951-061cc273dd8b@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:610:e5::29) To PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:a5::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR10MB4096:EE_|DB8PR10MB3322:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba31d1b-bab6-412b-4356-08dac3255cb4
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GhtpGia+XAv/kmxngrbZUOVCKA329/C4Cmlu3EykN3cdArOS1ui/8lOtVEmtYasKoHaPzTKoqKD/R9q7hLDtC62GyMr/LixN5ZMvrF9Er2tW2UlsOUEfq/eEiFgqp9jdv4xgQWQn72vs57MThO2JqFJM5Yuv3y5QITpoCqF0ve4B3CpOO/NZljSuSpf1O5j034l+dAW/2smNOE+gP6QPLNt5uniG2H6O5XC3Spg23ZV5lx1S6ck5ZbR8p3xMzP3MXv1oEz/NKxcJCRgv7cOK/d62i8rrQHzAzPie7PqD1sqhP5j/PEvDI6gv/qJlm87BiTiCtURYEYV6NY43KbaZSgY6wkhcJl8U9Fp+1UedVUREIqrWo6uKG51JwjDICtJXv6rkdANlEd8CzZjgWhM8C97bzBrkjYP2LKXZ7aBB/vnKFtz+/c8pL5oqjO3O44CIU1HKvZos5oTxuBap0d5kB98e4nU603xXwrJ/8/Jo3ia+aqfqrYZo+h6kxQ6aOikg9ytcA0Dhs5W2u+2usQpb1WMvHxCLjm14LtISgE0JAZ7DJZI1Eo3k+u5xjZQsi96kqTHph3MfsscH1jk2mgju0jp0G9bfkUKz/t76oCsSXfW8Fp1LzYTrjfwX8ejb2MLu61O10ww7M4Bp+mXDGsfX3SLBH0GbFNJLYaDChRg4hnlVhyQJEj//49nObGSRfjY3Q+2GM3Kp5CJMYyFFTW4bA3boyHOmPahYOv0LM5YCodOzew4Jb0LKSRd1xaR4W6kxJW4WJjWufIDZRwX9Upk3kkkaAz7hAKcmPeFWGvMBIsamIV/Vm/nUddqikVTIGRGBSHFyj/cM9/v11FFbRedU2T6nR4uy6VfWaQe4pAHsjzY0fkR3fY6n2yIXrflLSwGa
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(6486002)(478600001)(6666004)(6506007)(6636002)(31686004)(186003)(36916002)(53546011)(82960400001)(31696002)(66556008)(66476007)(38100700002)(8676002)(66946007)(41300700001)(8936002)(83380400001)(5660300002)(316002)(15974865002)(2906002)(2616005)(36756003)(6512007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VjRBTzJKdGg4b21acmxoamNQbC9jRHdtVVdyWHd3dHdpalp4Y0JZOVlnNGRH?=
 =?utf-8?B?dDlBUlZ3QTdPekdScWl4SDRPWk9IVG1sSHZDaThubkxEaG1PTno4eUg1S1JX?=
 =?utf-8?B?cUZEb3U1Vy9hUW00eDZ2V2J5ZGI4M1pSZUhYcDR3T1BpQ2ZCMTZWYnliNkc5?=
 =?utf-8?B?TGJQYVoxcW5MNFYrUDFGT3l3ZGtnNDJQTHppenFYdlBYcU4wdkloM2V1a0xJ?=
 =?utf-8?B?aG9hYzVyTmN4TjlFakFpdUtvUHpPdmdmV0hWekJoSEJZV0wxYVBqeEpQSzJT?=
 =?utf-8?B?bHFtOTJtQ0NGMmhZUHhhdXBhTkVobXN3T1FObGRwbFZzVVBLVWpYVXg5NTlo?=
 =?utf-8?B?SW9GTzJ6QnVJd3d4bzFaNjN2VkdFTC9yU0ZUNjZCUFlZUkg0eDNuZFNNMmdU?=
 =?utf-8?B?alhFMnVVTURaQ3YzTjBRb2VEMVFETWtEaG1PMnQwWGgvekJ1eWpDeDZBUnUv?=
 =?utf-8?B?QVltK2NlVjFZTFhLWE9FRUFHcVpjQktwV3g2WjlTVGtKWFpwUXlFT0gxcnBU?=
 =?utf-8?B?a3Y5SHdRY2ZUV0FUZVpxTzlaVzlsMmEwM3ZwVnNCbThJUUtUajIrazduQXdl?=
 =?utf-8?B?bnZ5dWtXUER3VkgwN3hEMFcyVzJjM0t6Zk9CaVM4dGQ0ZnBDK3dUZVY1K1cv?=
 =?utf-8?B?cDl5UUtNYUdnc2o0WGFIN1VsVThQT1VWb2JKUzJQRHRhOEU5QTgvYStVTVZ0?=
 =?utf-8?B?Vkh4MVlmZW02R3hNN3h5Uk1rdmtyeGxUWk9lUXVaS3pWVVhsaUhoVk9Gbmg1?=
 =?utf-8?B?UDBUdFdjQmkxbWlxUHRxcHRCbkhpR0lMQVdrQXhNVGM5dC9yL05Jc2VvS1Bi?=
 =?utf-8?B?THJ3ZzJEbHpuQUlpQWE4Z0RIVS84S0p5dnVpd1F3OUNHVjNlZEdMZE94dFha?=
 =?utf-8?B?d1l2OXJQdVAxQXdjQ29ibkNBK2xOQW5HSkJ1V0trSE4rcWNLQ1UxaVJrMktW?=
 =?utf-8?B?SHNaQmUwdlRtUEdkdUtZN1pQZENHMjdKejlvc01RWFpSSWpRY21jenp0TFo4?=
 =?utf-8?B?ak90eG5RZ211cmNLU3FzLzNLOEluTURlTEwzcnF6WUt6L3NteDhoVmlXZ0o3?=
 =?utf-8?B?c0ZkcWp2OWcwNHRISUkwSFZONUhERDFlRnU2dHhqbXZjaS83YXFDcmdJYnpa?=
 =?utf-8?B?TVhnRWlVcWtuWWpCOEJlcEJIYnE3SGlRd0R0RW5Yeng5SG9VaW95Ykw4T1cr?=
 =?utf-8?B?NjQyc3U3dXhaSWxJc2d5MHFrK1hxOVJBZkRaTTcyaVN1ck1BQllScklQcHBD?=
 =?utf-8?B?ZHdNOEkwNEUzdXdxZFBHa0xCUFNBeURlWjhJUVJXdzJHR05LckU4czJPNUpS?=
 =?utf-8?B?Qjc0NHliRGg0WHB6ZnhoaWlSYXQvTGtCYlIxRGc2Q2JoRzBEOGF5NXZienlC?=
 =?utf-8?B?clRLdExvaU5FZmJGczVhMkJkWXNVeDYzbDhjUkVkRVpmd2h5bVRibUU4aHZW?=
 =?utf-8?B?VnZaZ3RhS1daU0RyaTJueTZTQzhiM3p6NU9MODRaNTJlUFR3L2YzS1F5Ny9O?=
 =?utf-8?B?RWhSV0piMnBQU1NPdnBsamk0WksyVzVHLzhReUlVMHQ1cnZKMEVHN0RFaUdw?=
 =?utf-8?B?Y3pOcjl0Zm1YbnpwRlVsWGVlOVhPMFRlWENvb0t1T0NQYXphWlVnTnlVWnQr?=
 =?utf-8?B?SWo3SWhPbmYvdGFpYjZOVmk3VGpsV0hHWTc2WSt0SzhkQm5xb0V3ei9DMHZu?=
 =?utf-8?B?V1BJNGlXYmdwOEpHN2cwdWNpTnBteUgzQlhjTTNNM2VDaEE3ODBtdGFYZ2hr?=
 =?utf-8?B?SmdyeWJXMWVwOGt6OFlCK0s2Z3pJL1JOa1ZuTWg5M0RpV2ZQR3lEcnVQYXVv?=
 =?utf-8?B?Ulh2a2ZMWnRZNS9RcXYvWGgzTlhvRXRxYktFQ1NaY1V4ejRMaU9pZVJOZU9Y?=
 =?utf-8?B?K0ZpVEE5WWthWTdMQzJVUlJOL29XaE5YbnUyL01GRXY1OEJkM2lycXNKRjgr?=
 =?utf-8?B?ZGlVcXZoMCtrdHNvM2RSNVkvRHN0cHllaW1PNjZHMjN3dFVqQlFHRmM0WFlY?=
 =?utf-8?B?RjMzMitxVW1KRmJZdG43VUlzd2k5V2ZlMUxMNHZsMGhvQlVkYk0yVDBKbmNt?=
 =?utf-8?B?UzdJZGY5TUpsa1FpZFVRZWVETG9laDIyWFdZc1FQRXh0WHJmcG1KY2dvNThO?=
 =?utf-8?B?UVNab3JXVlJrKzhucENDVllrUDZSaEJGSTJUTERJWnE0eEd3eFE4QlZDMUpV?=
 =?utf-8?B?YkFibmtBTHIwWGMzeG1mTFgxdmlvTk9mamQ2eW5lMnpvUEkyMytpM1M2Umts?=
 =?utf-8?Q?8JcOUm/R8sY19njG2k5j58h+V1uX9AYP3ophrH48GA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba31d1b-bab6-412b-4356-08dac3255cb4
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 14:10:46.4911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fXxu++sW9W+3Nm8EDY5EbENS2cU6ssuB0166s1ROeD+Xr3/ZxtLqOlNsd+J9PQvS/dY4SdEuopkWBTwsqiClXopEfxFH/rsBqMB8FVW/fE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3322
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Nov 2022 14:11:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10011



On 11/10/22 14:58, Jan Kiszka wrote:
> On 10.11.22 13:45, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   recipes-core/images/files/sw-description.tmpl | 1 +
>>   recipes-core/images/swupdate.inc              | 5 ++++-
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
>> index 1c0db02..a9a6069 100644
>> --- a/recipes-core/images/files/sw-description.tmpl
>> +++ b/recipes-core/images/files/sw-description.tmpl
>> @@ -20,6 +20,7 @@ software =
>>               filesystem = "ext4";
>>               properties: {
>>                           subtype = "image";
>> +                        uuidcheck = "${TARGET_IMAGE_UUID}";
>>               };
>>               sha256 = "${ROOTFS_PARTITION_NAME}-sha256";
>>       });
>> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
>> index 6cf9bb1..0ba3a0e 100644
>> --- a/recipes-core/images/swupdate.inc
>> +++ b/recipes-core/images/swupdate.inc
>> @@ -23,6 +23,9 @@ FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
>>   SRC_URI += "file://sw-description.tmpl"
>>   TEMPLATE_FILES += "sw-description.tmpl"
>>   
>> -TEMPLATE_VARS += "ROOTFS_PARTITION_NAME"
>> +do_transform_template[vardeps] += "TARGET_IMAGE_UUID"
> 
> This continues my question on patch 4: Does that work as one would
> expect, ie. TARGET_IMAGE_UUID is executed again, right before
> do_transform_template is supposed to be run (or skipped)?

The TARGET_IMAGE_UUID is executed right before do_transform_template.

Quirin
> 
> Jan
> 
>> +addtask do_transform_template before do_swupdate_binary after do_generate_image_uuid
>> +
>> +TEMPLATE_VARS += "ROOTFS_PARTITION_NAME TARGET_IMAGE_UUID"
>>   
>>   SWU_ADDITIONAL_FILES += "linux.efi ${ROOTFS_PARTITION_NAME}"
> 

-- 




With best regards,
Quirin Gylstorff

Siemens AG
Technology
Research in Digitalization and Automation
Smart Embedded Systems
T RDA IOT SES-DE
Otto-Hahn-Ring 6
81739 Muenchen, Germany
Mobile: +49 173 3746683
mailto:quirin.gylstorff@siemens.com <mailto:quirin.gylstorff@siemens.com>
www.siemens.com <https://siemens.com>

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim
Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and
Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P.
Thomas, Judith Wiese; Registered offices: Berlin and Munich, Germany;
Commercial registries: Berlin-Charlottenburg, HRB 12300, Munich, HRB
6684; WEEE-Reg.-No. DE 23691322

Important notice: This e-mail and any attachment thereof contain
corporate proprietary information. If you have received it by mistake,
please notify us immediately by reply e-mail and delete this e-mail and
its attachments from your system. Thank you.




