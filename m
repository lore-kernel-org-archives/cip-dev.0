Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA94C4332F
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 08:08:26 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.54])
 by mx.groups.io with SMTP id smtpd.web11.25865.1698912501045745025
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Nov 2023 01:08:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Rpyngesk;
 spf=pass (domain: siemens.com, ip: 40.107.104.54, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lh1Y0IVJEGwnQU6RnvXRJpOO+w2LPGEtIUAFjGie+InoE3KaKL51lgx5eb/aWvd3T06w06I7UhWMgukIpBjIJEhR8kUm1A4KmyIbYcz19JLZNuYyom3Y3hSvvk8qqL9DBKA65df9eyFKApOSiig2ol8ke8eHzXaGfqJ4wuvpg9Dkt4O7lfayzPm6TX6/HrCzYRnghsC/YrOjDdaCZrLR/mZwiQnHqE4pOr+2iDS1cq9uZiJlzzsCn8gUOcgSBtPJpj9maUpR8LS+XyEsxroipr7Beodu09JyWTvV9NktyfpEvbkbPyGraWSF1FsmSeY3OkqS2+vyBsxV85KJGYxP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/K1F3YTBOJo78vc5ygqR+mjT2DALFQ6na45nwtSkMY=;
 b=fsIzHQcl8hJKSnuDzaY/t6HwnoqWar2r7nXN4gld+IEP3SbN4E0xn3EuhTxQGMydVp1IZnra/c9ysqmgPTNIzLnhgaqcTc9HY6fZ8TRosZxowxjIJKuHrK9Q/RjdD63v5oFlvP1dbMVw+wJlyRtUuWEl13BCwwfF+UfFwU10PDArKuWok3afHLW7k15c33/D+/ryfvWtU8axhbfcyDqSksKoGseC9p5is7tw5dy5Cv5TyNipsDHT+v83Lvxz8bWPQq2oKmwfYfEFndszpGIS22+hkDolHktdOwY3rIlacV+rpociZHzzyMX0GHTAH+D4mQ32sZWEBdO2RC9LvX3IlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/K1F3YTBOJo78vc5ygqR+mjT2DALFQ6na45nwtSkMY=;
 b=RpyngesklBuUUtnQ0lAGZRLA305IQ50bbsNrfiFXxXOnzMpwKzqbxzxvXop/7P/Q72ieu/iYYpL36y0vbBbnxO3JnREGitWYQ68USyZIK0HDL2CKMicAOHpnUOHalh8/Ad6umUdpX4gc+2Go3ehIYzv5C76qHL6zrsRz8hBc83iCPsVex0OdGfYcXZoANtINJ9RIL1TXq/tKmwm0+LyE/jV0+Ew/yM2DfiGFm9x+JVj4DbTVL16pH/tU94qEKYCY1GbhwfFf2sI/96a9CW3zkiRnqSuBEuG6AESR63s6PrdUMFEZQS6D8JK5JRBz/qFY4HlzsJUiwiPPNKw5VwQZqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PRAPR10MB5179.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:279::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.20; Thu, 2 Nov
 2023 08:08:18 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d28:13c2:1583:fabc]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d28:13c2:1583:fabc%7]) with mapi id 15.20.6954.020; Thu, 2 Nov 2023
 08:08:18 +0000
Message-ID: <588aaf59-facb-49db-bbfe-2c70c9866452@siemens.com>
Date: Thu, 2 Nov 2023 09:08:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] added pcr_bank for clevis
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "Sari, Sercan (ADV D EU TR C&E)" <sari.sercan@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <DU0PR10MB6898A9738AF1110D653D5DE5F0A7A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
 <f1a52e61-3404-41df-85fc-7453be0d4be7@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <f1a52e61-3404-41df-85fc-7453be0d4be7@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::10) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PRAPR10MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: 8843f8be-cfed-41a1-2f5b-08dbdb7adf25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YvJvGIy24AhuacspXjI1EkI3dK5aOjkHN9Syhgx5dNbe8g7S2q5CUJIEkBwEJfSXNerVDmwPXU2qSdzy+GG8IiZcyOB8LaoJf1cBXHzu2ifX9JwtmWuWuRHNN3m4pWGte7DWjLXItxwqqxCSH9q4byalDEbkyzr0VvZt5pYKw0Rj7UxWo3g5vQ+mA5MYqj+Jyh+/+cDHh7RSnwtpzvq8vUirZ2yMHE1wejsmLvViJH4OMVE6Yt0YE9FgtZdosgEMLO0Xss7EW9NypGo6Kqf6h+Mvu3+T+FGAL+cVj37INjupSg7tSmP3SmuXW0O03XK+6XUpje0wzrp5TdaogisB7BCmapYXztDw+gPf4Ti5TBX14V0jU737GP2W0sJ37R8AUGyl8w2YMCGb2MyV4UE/wUNHt2ogCuf+aypU729bS88vWokMNjdDicplL/1Je6njfTZQsHNkmJ45wwDL5eHYHDeSW7IQOf5HOpYBAtivCBttFdjjKOrjDdDYevWCzoHT+Q3X8Fmp6NJCD7yw8gY3zvdDVLfL0WYguOCWkczKjGCDaSQDZ9aOyF1cdEZ6g16fyIACiHY73XR3Rn9WadTcF4XPchWbzSqdkM5cZk51zTLRVBNAudcgyJsm6vi/6iVFJlN4Mt860tRj4+yjqZQndg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82960400001)(38100700002)(86362001)(36756003)(31696002)(41300700001)(6666004)(478600001)(53546011)(6506007)(2906002)(6486002)(5660300002)(26005)(2616005)(6512007)(8676002)(8936002)(110136005)(66476007)(66946007)(66556008)(316002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aHcrVFFoZlZkdnhyYjlLUmpnNlJTWUdCT3FTYUYrMlI4a0w2U1puSDJ2Uk9q?=
 =?utf-8?B?dlRXV2hyT0tuaFNRN09RcHBweis2ZGtFb0YwTFI5NEJUaUpCTWZxUUNobE5H?=
 =?utf-8?B?dVVHMTI2aHNnNXdYOW02YnpiVjFBQ0tkemtNbkw4T2hyK0FyekNKMzBpZ3pE?=
 =?utf-8?B?VVJ1N3gyY2ZGaVByWFVZVHBrWW9UejJXVzZEc0ZWSk1FNkJhcHhCbExWYUVz?=
 =?utf-8?B?ekhSYi9IL0FTajJ6TTBCZjV3Q0xMYkhjOFd5YmlDajArZGZUbnllOGJNTmpa?=
 =?utf-8?B?bkVVbFF6aGgrSVRUUGw2eTVQUzlIRlAvVWxNc2MvRk5OeS9EVnYreGZtbmhY?=
 =?utf-8?B?QUMvQjRTWHNOcHJKYVlFL0dnVm84cUszc2Zob3E3VXFpVjFCSDIxSjN5UEh3?=
 =?utf-8?B?ZHhVdFlPSyt0RzNCVytrcHVNZjV2ZjZXdFFHbHIvcWJ0SXVTZFlNcmxkdVJU?=
 =?utf-8?B?UTlPSTYxS3MrRzZ3ME9jZS93YjR1c3ZQRkVGUkxuNi9MSkxzWlZsU1V4NHFS?=
 =?utf-8?B?M1RrM3BkZk5mMGpMaGhSWXJnUWx2dzRjYURJRWpOSkUxcGF2akV4RVlpc1Z1?=
 =?utf-8?B?d2RHcWpOZVRnS0xkMFBadlhwdHEzVTg1YkREQllKVytXTUtnSHNKaElraEt3?=
 =?utf-8?B?SkJsbVhoRndpSUxkSlF6Mm8vbjNXS3NzempqcDc2cVMrc3UySTd4TGtCTmtE?=
 =?utf-8?B?Tk00c3ovV1dlNWhNT0xyUDZqTEVORVZad0FYcFZvSXFOTkNhbGJyUklzMDNj?=
 =?utf-8?B?VW9qSllDeWgzL0dMb0Z1MGQ4cElqWlVFdm9jOEhLSEppWnhSakV4U3YzUlMr?=
 =?utf-8?B?bGJodWNRdVhzZkJ0ZjcxVFFEOHQ1Ui9EaDN1NkFCcFZnVGdtVG9ubUNJRXVG?=
 =?utf-8?B?cVRqYlAvRko2V3dqUHNDM3FwTGtGaXFNNUgrTUpjQ3FwcjNRMEYxT2xqZFlU?=
 =?utf-8?B?R2hyZzNOM2ZXT1VlZG5TSGxhbi9HSkpMZVpndG1vYXNTUUh6WFRKWnEvcmpW?=
 =?utf-8?B?cnZHTzl3bVAwb3o4LzBOakJBcEplbXZBSDRlMHcwNUtKdW5LcDZ3MEIxMjVj?=
 =?utf-8?B?cjBnTVR3NWZ0djZBSUVHRVlKd0hDQVU3YmUvNm1mZ28rQmRIZFBOdVRHdmRP?=
 =?utf-8?B?a3I4U1M1QTVodTZ6T0ZWT2x5bjRCWjBENFFRTUgvYXZURllwY2tITkRWbGtG?=
 =?utf-8?B?REpWbTkxNzZFUWlxRlA4cXJZZm4rYitVbFRGYW9FR3NhWFIvRHNUbkN4eFpD?=
 =?utf-8?B?ZHpSczNURE9zSDg3aVloaFBsdE55OVlwaFF2OGd3dVBVVENwZ1ZyZG1GL0Fw?=
 =?utf-8?B?dUNKeDFjSGY2OHQwbXVmVXJhMHpnR2E3NjFyTjJXazJ3WVNtdXVGL2lsZ0du?=
 =?utf-8?B?Rm5XMElVcDdHMVd4TGVhOHBvaU1aMXZPTEdZTGhzRDRmQU1tWlFUc1Ftcmt6?=
 =?utf-8?B?QjZQdG96TDJFQTZTdS8zbkRrZFpKdXQ0aHIwQnMrL0RrRGJpRThFMkkyaFJH?=
 =?utf-8?B?QkNIVkFOaFBtd2w2emxOcEZMQ2E3allkR25LeC8vOTNKczdJWXdhMXR1K0Rq?=
 =?utf-8?B?WFppSWVySTZ1R0xZUEdQVnlHN3JCcVA2NVRQM001T1gxM29MdzZtY2crdlZi?=
 =?utf-8?B?MGprQmFSTzNZQUFTaFFhWWtlZ0ZnT3lKOC8wUFZKeHZReEJLUjhkdGFyMDZh?=
 =?utf-8?B?V0U5RDd1c2YzVE01TDFaWmw5emRGTTI3RndjSFBHZlJ1ak9nVHA5NEU3VkdD?=
 =?utf-8?B?R2MvT0NlZXBxZXpNZzJPcG1Pb1FoWmMzOEpMQjFyN25GV3RWWXR0dkdyM0xX?=
 =?utf-8?B?cWFJSDRVVTdmSm13OUdqQzhFVTVMazdNRytQWlVhemt6bG84REJaQ1B5V2Ft?=
 =?utf-8?B?MGNOdHA1aUs3Z09RTnZpVFlmNXprQWJ2WGt2RkFhQ1JkQTRKNTJVU09ISEVP?=
 =?utf-8?B?VTdlL3hqcGFIK0JodmZxYzRTMEIweGZMVlFLblJ4eW9GenBkRFlxVG5jcTUr?=
 =?utf-8?B?YUVlK29RQmhxUHRIMzNHb1lreE9pUk96RVJWcmxqSzlmd1VPQ2toMTlWQVFW?=
 =?utf-8?B?WTR4bExhM1llb09TY1VDZlFPZHRWbEdHK0JwSm1UTUw1c2JKQmhCL1M5ZDNW?=
 =?utf-8?B?S1dGTytyUFdzalZDelVtNFEreFVuRnZ2cVV0SDc2MGErWG5Bb0ZyZTB2L1hk?=
 =?utf-8?B?WkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8843f8be-cfed-41a1-2f5b-08dbdb7adf25
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 08:08:18.0710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IaEFit+pSsHsIVfzM0X+c3GetS2ePybYQsa4Dc07iGfMHH7TE3NA2oqCZEu8zmnOqUGcRN1qe/r57qAwboG0oksjTfp7sfNaYFTDpUhtWO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5179
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Nov 2023 08:08:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13513



On 11/2/23 07:10, Jan Kiszka wrote:
> On 01.11.23 18:17, Sari, Sercan (ADV D EU TR C&E) wrote:
>>
>> clevis will fail to encrypt data when the TPM has multiple banks, such as SHA1 and SHA256, adding the pcr_bank information resolves this issue.
>>
>> Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
>> ---
>>   .../initramfs-crypt-hook/files/encrypt_partition.clevis.script  | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
>> index 899f20e..957a3fd 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
>> @@ -61,7 +61,7 @@ open_tpm2_partition() {
>>   
>>   enroll_tpm2_token() {
>>   	if [ -x /usr/bin/clevis ]; then
>> -		 clevis luks bind -d "$1" tpm2 '{"pcr_ids":"7"}' < "$2"
>> +		clevis luks bind -d "$1" tpm2 '{"pcr_bank":"sha256", "pcr_ids":"7"}' < "$2"
>>   	else
>>   		panic "clevis not available cannot enroll tpm2 key!"
>>   	fi
> 
> Is sha265 the only reasonable setting here? Just asking as we are
> hard-coding.
> 
> Quirin, any remarks?

I would make it configurable. clevice supports SHA1(default) and SHA256.
Quirin

> 
> Jan
> 

