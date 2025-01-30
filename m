Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370E5C0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:41:39 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.56])
 by mx.groups.io with SMTP id smtpd.web11.12083.1738230089567779883
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 01:41:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yFulMDCl;
 spf=pass (domain: siemens.com, ip: 40.107.21.56, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTTdO4RUWUwxFHsqGsc5TqAsM8E4syWa77oUrKh7Wqh76QjRc922nqhGpjKAbuQCYz9HjhRLGiRhisFlFi7HavaG7D1eAbfCJBqaXZSv2zmU1fXBsZtQD8Lc35uyTWb30hyPV4Gy6nUl/Q/zNHUsvnyXBUWVMH5dKXRLoQY7E8HGwqCkDKkUzOe+HG6EaadY199u0GFhZiWurgHpVuudFf34Suk/Z04sXil+nKS/E5vekQNk86UHHSHx5U7fEozuPmH4YbeEwOjoAGcFX9yrNl0o0polMCpb62yt40dTOOwAkERKgEFP/HKWRUBJBHvp+Mvznw8d7Pxq4oCrpNGUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3l8mEtxzLocOQP+fPvsbHPcCLgGAuWr/CMLUC73jbU=;
 b=k8qJBPelTuHBaIN1D8FHa666V0u19WRG333HuWhOkO4DuKWHQN6a1iK3YwxWiHznXHfDdX2WRJS6ygNh1gbcc7lVJUDaB/iPW8YQaAXInnfWQGll9NpC7UKcmftEYV1w3CwDOxphVGa6j3li0YNPonDccUdQxMnJ/bV14UkFvAat+kRql80Zb6eFFA0y859KaNwwjct671tklRIlUg/tFgqCzM7VsbkJx7l3ngv72SbOh6LMo2/DoLHAePcaXoVEWhKyTlOT4lZu+H2wtJXzt9MW1DU7kkhjDO/bTpO49VFPkuKTWED6nPhz9sChkAJyrAPc1oj9UzHcbVVQv/vOeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3l8mEtxzLocOQP+fPvsbHPcCLgGAuWr/CMLUC73jbU=;
 b=yFulMDCl/dw2qOmzDlj/qLLNlDEsMOk3BgACR1Hsw1f+UiDc2fjxxMNBfCynDIcU//jSK4L5P2OsrFHcf8krglPQXeCEX91JfOzd11V0iQ/VltRONN7Sgb531eFZei23gOH+AoA9kleGyAqOHyRY308AvPekHRnwm2tdH3r8oqtLgQjqG2xXvjFwSIzoBQcpsyLYyZDcfT5esNObHbLmXNyjFg7IXKTLkoizupSvqvbRJfoQGL2X5220XCcZLYECabG6G2CuYqgo9l9rDRJMkiExhZpjUlLzIQ4eKsyR71ftnIMZwoCuit8OjJGj16nc1p48le6UyLhetVigUMK2ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AM7PR10MB3192.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Thu, 30 Jan
 2025 09:41:26 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8422.005; Thu, 30 Jan 2025
 09:41:25 +0000
Message-ID: <87f1d4cb-522f-4643-9a43-93ea44e64670@siemens.com>
Date: Thu, 30 Jan 2025 10:41:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] read-only-rootfs.bbclass:
 Exclude boot,home and var from the erofs and squashfs
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 ludwig.nussel@siemens.com, felix.moessbauer@siemens.com
References: <20250130085342.2806658-1-Quirin.Gylstorff@siemens.com>
 <023fca75-ae89-4101-82af-d59e111bfedc@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <023fca75-ae89-4101-82af-d59e111bfedc@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0406.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::11) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AM7PR10MB3192:EE_
X-MS-Office365-Filtering-Correlation-Id: 79dc5ddc-4a18-4d36-344b-08dd411243ab
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YlZDV3h6VlFDODRLS2QzM0NoOXgwMytyOStzN1hjUW9RYVpNNmFmRTNDaXNk?=
 =?utf-8?B?QlE0Q1lIaXR5R0xXVVllbzlaUG43dThoTzFWQXJVK1JydkVVdnE4blRkckVz?=
 =?utf-8?B?RkJ1RVc1RU1aTFBvcnFicnRZTGNjRHZOd2hqZGgrbnNiTkJObEd0WHVEbjJx?=
 =?utf-8?B?WGltZHNCcUFZeGFzQnp5VWZmYlp2K3lhZURyWStWNE5KbVNNMjM1RWNBWTgx?=
 =?utf-8?B?clJnSnRvd1pNZUx2ZGVBb2wvZHFIY0ZuckdCaXJadGJUOVFmamF2bW91UXRp?=
 =?utf-8?B?OGFqTTFXalhOMy92TVJxTVVkNTBnSFphZmk3dkpSdGxBZ0RuQ3BVdUhrNmVL?=
 =?utf-8?B?QWtmUDBlSHZPVUJQelJ6Ni9OS2NZSW1qQ3k0cWhPZTAyc3ZvMHJWZGVtRkFC?=
 =?utf-8?B?WjQyZ1hMSzJxRmRBNlVJVXBsc015MEhtbVBMeStZTlIxYklxQW1WSjBIOEd2?=
 =?utf-8?B?MTdYRE5teXFSUjZpdjNDL0VWQzZuNUk5dFJxbmxFalZPcE1ITVJQNUErMWpY?=
 =?utf-8?B?Q2Z4V3I3STNYbWZaVGM1N2x0NFcrcTJhaHRyZkp3RmM4N2dmakpmcjlNNWM3?=
 =?utf-8?B?QUJJbjBWY243THRSejc4TzRudE9IUWZTMEZjZzlWTFhlTGdUb0l0b1ZXZTdy?=
 =?utf-8?B?bVRMMmNoclV2bGVHSWlZd3c5VGJEUFhqYlpsaUtMTm9JUEI4SXVWMzZLR2No?=
 =?utf-8?B?d0ZESGF3MXpjTk5YaW5tU2NIY0pvc3ZrS1E2bFRwWkZob1A4dzRVRHhSL1A3?=
 =?utf-8?B?M2VEdVFZbENWdWxLelBQS3ViVlZqQkhQTGNLaFhFWmdIQVFjZ0JsNUpOa2VI?=
 =?utf-8?B?YVNOZlV1eCtqMXVlYVdWUVp1V1V4K2J1WFpoeXg3Rk1OLzRZSUYyN0hscWdz?=
 =?utf-8?B?VGl0azhpVUdSc0lheUU0SVJwVUtQVXc4cEdMNGtmbG1Ea0JvditERGJOQ1Nh?=
 =?utf-8?B?T09iUTFUeWNaaEMxbTB4bnh0RHp3eDV1SndjbXVCc0VMRmkxRVUyZnVJWlNZ?=
 =?utf-8?B?aUpqYWRoNFRuODJRT0Q2VmxqUVBtZG81N0kwNFhrQm5md09udlA2YTg3MVlK?=
 =?utf-8?B?UkQyMlBxYSthcWd0WVc1Tjhubi9aWTFGL05Ca0dwN1J3cG9xb1l3K0EyTEVL?=
 =?utf-8?B?MkljcXFJM2ZYQzIwLzVxQVFtNkNwcE5wZUJ1QXFSSEhqNWJnTlZYTTVXUDBI?=
 =?utf-8?B?YkdJb2VZY0g1RFFMN1J5dGlSMWZaRER1NTdiQ2J3ZDJGa2lSYkxaSG9lRVlo?=
 =?utf-8?B?OWVqeG1RcHhjOEpoSlBLcnNpenl3SzN4V2V3THVJdk03MG1oSWY2empGWVQw?=
 =?utf-8?B?TUV6L2M2eDB0KzUweGN1QkxhVmFzOVNXWVdrMzhjNWQ1UXcveS9jT0dzVUZJ?=
 =?utf-8?B?a3FSOHBUM3AvWEpzbytUMERablFFM2pNUTVEaGJhUUxjZjhDakNmbktBaEdy?=
 =?utf-8?B?TDJzRjF3VEJTS3dSYm5UejlONUpEVldiWWpkMmwrRUVya25pd0RPaGlXeVg0?=
 =?utf-8?B?dUNOK0ZOeVZTMFJLUmpiQmNsUFZsbENUQ3NvaFRCSEZ1NktxMzY3OUM0ZVNt?=
 =?utf-8?B?cStndDFyY0EvcXhxekI4Q3U1ZEtnRWtGbExjbkg3U0JNQUxpMWY3Vk03ZXRt?=
 =?utf-8?B?M0tPMkhMNTBaYzhLQTZZRTZlYU9Vd2Vlek9EbUhMNmhnRkd1U1R5L3R1aFdQ?=
 =?utf-8?B?MFBzUU91dmoveVE0bWw5bWk1NzNTY0VkNTgwdVlEdVBNRlQxRTJoS01LbW9K?=
 =?utf-8?B?VFR1NW5DRXptc1NRY0R6Y0VFVEJheDhTTkYwbVFBczdESGF6LzRoMWEvUnZP?=
 =?utf-8?B?SW9vYjh4MmxHbUUvZTYrM0ptbGdqeU92SWRkc0hXTVlETTA5OHVEbmdaSzMw?=
 =?utf-8?Q?wj90F8EMs9xJU?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YWdWaWFyaGs3N3pxTVZMSDJLTXh4L0h2ZnhjSzZLSVdmWGRDcEVmcmhBK2hW?=
 =?utf-8?B?dERVckZFbTF3RFkrQm1KNGpTa1dhS3VCWUloSzFlK2oyeDBrblJmUC9LOXVH?=
 =?utf-8?B?d3FJcFU3QmpjaCsrUGk5cFFMSVlDbWZFQndRMElBWnUxOVpGRGhIaGhDTGtI?=
 =?utf-8?B?SGZORTFJeUR3UnlFdFFQTXFVMExLcE9jREJIcHMvYUx1cjhxY1BiQWp4M3dL?=
 =?utf-8?B?WlFGQ2ZqZHFCWnNlNUlNNEJXWGtTbmJ5anhlMnRkTnZYUEMzM2dMWE1DdTZK?=
 =?utf-8?B?Q1JuMnVwaUdwUmVmaFpqYXVVc0c4OU42ZUlkVjZ5UDhXeWFPOW5hRTVlcWlH?=
 =?utf-8?B?ZUovM1QveTNZZW5vS0dTM0g2bXdrV0RBTHk0aTFuYUZxbUNyeEZsZ0E1eG9E?=
 =?utf-8?B?YzFYQi90bFFPSWlqemJDLzJockhsYVE2Z05YSXBpckJhcFM5UG15aGUwa2Np?=
 =?utf-8?B?V09nazlzQ21KU3FwNWxPZFdJWVJrdWwzNE5NSC9SUlI4alpUbWx6b3VTMkRo?=
 =?utf-8?B?blFwMU5hSGVlaE1relk3eEtaWkR6ODIxQkdBZ1RZYlFIcnp4bjNNeFg2S3Qr?=
 =?utf-8?B?c09iV3ZMTElGRHVQTk82U1NlQnJabjZVN2RXcVBFU1p2K3VLdmNTS0ZkSWd3?=
 =?utf-8?B?amdGR1ZUNUpObE91aEFiVVBnUnp0VG8vZ2lOTFI1VDkxNmFYaTR3ZUs4U3h1?=
 =?utf-8?B?bTd2S0xuZEo2MEU2QS8zWU5pZUtpaGFCY2U5S08rQUN6UTBnM2xYVC9QZ0Zu?=
 =?utf-8?B?aU4xQTZaaDRxNVAyNE9Bc2RqS1h3MElXT2xvMEpEL0NxWXRuVG9sNjhTeWor?=
 =?utf-8?B?RUdVdUhXbHM0Vkg3TCtqcG9YeHk5YTM4RFdFOFYvYmpQcXRnQWJOeW13WWZI?=
 =?utf-8?B?bG1QVEkyVG1rYjdOUDdZVnN0TnAzdHN4cUNiSGV3MW1IcmZzdTdlbDV5TXR4?=
 =?utf-8?B?UG5NajFTODJQUml5OU9kWVRLd2Q4d1gwc0JUODFZNmZNcEZLWGFTN20yMXk5?=
 =?utf-8?B?U3lrNnpoc2RSVVVkNVR6M0V3aC9KWVFsMU1vMWp0bXEzVDFLMkluM0xmNFdT?=
 =?utf-8?B?M0R0OWh3eDRyRStTTFluL255MmtqdjB4YTNjNGxUZTZYc0d5T2dkajlHRzdk?=
 =?utf-8?B?NUZlQUVISW1hV2ZsSVVTNCtRbWcwdStLTEhXb1RUTCtZSHFFMGtnTDRlenBv?=
 =?utf-8?B?aG1haUt6cGtyNVNNcWtaMC95TW1IVTFxMmZxZTQyY1gvcitUUHNLOGkwMGJr?=
 =?utf-8?B?YzhjcTRPcHJ3WmVpTTM3WXRVcGNjZG0yY1dtYmo5emZWTktnWFJ6TjZQRXNi?=
 =?utf-8?B?ek9rczQwWmNiMW5kZU44cE5XdHYrc3lVVTdiSk5tTGhXOGJsQ01NeW16Z1ZO?=
 =?utf-8?B?VEROQmxFemM0aHNXRnNIMTM4dmxzS3pjSVpEbEpvUi9jTnhaVEpNcGdWcHNW?=
 =?utf-8?B?dEEvN2RlSW1SL1QvT3V2c2xXaUZpcXVuZW8rbkgyU2J6TGRXQXk3UUJaZmFt?=
 =?utf-8?B?cS8rdGk5d0xnbmhTK3J6ZjZieFZybWdtL0pjMjB6alNaNEl3RERzdXpXREZp?=
 =?utf-8?B?eTVOckUwaGJxbk5ZYVZPV0NIVEROK0VEZnF0K0dvVzdOMVMzUktwTFgwV1l0?=
 =?utf-8?B?a3o4UmhTYW1hYmM5bnBZK2NyRUJpcXh0YkNIN214TVd4NUppcTZHK3ViRzBE?=
 =?utf-8?B?WWNkamlHMzFYd3BDc2pPOGNZbmNTbXZsUTltMzQrMDZmNkZaMTdmQnMyMFZM?=
 =?utf-8?B?bjFkQ255dEdlMHdpMnNIRFBLczNSOWxvclFReGJUazQySU5mWGN0d2M2V1Bq?=
 =?utf-8?B?LzVnWkpHT3QwMEpTbGxiOXNHcUdWamlxVytacnlkZSt0cjFzbUxaZUFVSjZQ?=
 =?utf-8?B?WU1LbFN5MHhiOEFOY3JuVThuQ2ZkejRWRkl0NkFNZEhIV1BRTTEwMzhJSEdk?=
 =?utf-8?B?TDF5WjRmS0ZSSjBaQjh6NXdpQThacm02NTNLMlI1V21jeTRBVWN3bittZVZ6?=
 =?utf-8?B?RHRqQ3dyOUU2eTNTZXFmclNGTFVrbTZsUFpBUVFObi9TVTJZaUZuWjJ0bVlZ?=
 =?utf-8?B?Vm9pRFBMMDNZQ1Y5TnQzc3IyVDdRdVFxOERKSkhxeEdjelBxazRlbitxcjY3?=
 =?utf-8?B?UHQzVXlOdkdTVXNlTEx5RHVhaVhBRTVVbU5nSVMxTjBRa25EbU1hQkFNN0Rz?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79dc5ddc-4a18-4d36-344b-08dd411243ab
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:41:25.7928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: up+3W8/2AGdiFC/NpkBkl/UPoCVag4kEFJGXDqVeCmW/GZIY63NPTgoPM50jQZ7WnPovecLiaR/QJsKiRYNKTmLmz6aeeRjVTAusC+Y1xFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3192
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 09:41:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17709



On 1/30/25 10:39, Jan Kiszka wrote:
> On 30.01.25 09:51, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This excludes the content of boot,home and var from the root file
>> system. Home and var are stored in separate partitions and boot
>> is not necessary as we use a unified kernel image(UKI). This UKI
>> is stored twice in separate partitions.
>>
>> It should fix issue #126.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> Changes v2:
>>   - Also exclude /boot
>>   - define empty RO_ROOTFS_EXCLUDE_DIRS in read-only-rootfs
>>   - define excluded partitions in recipes-core/images/swupdate.inc
>>   - Update Copyrights
>>   - Add information to commit message
>>
>>   classes/read-only-rootfs.bbclass | 6 +++++-
>>   recipes-core/images/swupdate.inc | 8 +++++++-
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
>> index 9ebcadc..35a3ab3 100644
>> --- a/classes/read-only-rootfs.bbclass
>> +++ b/classes/read-only-rootfs.bbclass
>> @@ -1,7 +1,7 @@
>>   #
>>   # CIP Core, generic profile
>>   #
>> -# Copyright (c) Siemens AG, 2020
>> +# Copyright (c) Siemens AG, 2020-2025
>>   #
>>   # Authors:
>>   #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> @@ -34,6 +34,10 @@ copy_dpkg_state() {
>>       sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
>>   }
>>   
>> +RO_ROOTFS_EXCLUDE_DIRS ??= ""
>> +EROFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
>> +SQUASHFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
>> +
>>   image_configure_fstab() {
>>       sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
>>   # Begin /etc/fstab
>> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
>> index 81c3365..07dbe97 100644
>> --- a/recipes-core/images/swupdate.inc
>> +++ b/recipes-core/images/swupdate.inc
>> @@ -1,7 +1,7 @@
>>   #
>>   # CIP Core, generic profile
>>   #
>> -# Copyright (c) Siemens AG, 2023-2024
>> +# Copyright (c) Siemens AG, 2023-2025
>>   #
>>   # Authors:
>>   #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> @@ -12,6 +12,12 @@
>>   inherit image_uuid
>>   inherit read-only-rootfs
>>   
>> +# read-only rootfs with /home and /var
>> +# as separate partitions is used
>> +# /boot is excluded as an unified kernel image
>> +# is used. This images are stored in seperate partitions.
> 
> separate - spell checking editor?
No the user should follow the instructions of the editor :-D
Quirin
> 
>> +RO_ROOTFS_EXCLUDE_DIRS = "boot var home"
>> +
>>   SWU_SIGNED ?= "1"
>>   SWU_HW_COMPAT ?= "cip-core-1.0"
>>   IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> 
> Looks good to me but more comments welcome.
> 
> Jan
> 


