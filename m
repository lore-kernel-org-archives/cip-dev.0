Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D58C0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 07:23:18 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.77])
 by mx.groups.io with SMTP id smtpd.web10.10762.1738221794565394037
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jan 2025 23:23:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ym+qVMVP;
 spf=pass (domain: siemens.com, ip: 40.107.105.77, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+xVVhG5PpPWdAePKbV5F0wVxOirg9CTzS6zIb3yJosRLav2yDQaMFjmoBhYwkdSUAusp46EO1af+a8yfW8fVbvYtWnFWY2+NMadyaQlgntCJROU9cW+lDN497hW2pa3IabYUnvTYc/s1Mlx/QXG7G9VokYCW3X9HJ3pXaGE+KXLtjlNl1N9/XSvH+yEGzX1PGRSRdRNpb9hqvkeaVWZWzx7ak+zwNdXlcNzu8y0juFz4Ke79ThBufWsQMhuosEh8goJ9C9g0df94/iqWzjaa2NnihsTEdA0jR2DWHKzbbkfRJFR8FslWBXzEI6QBaViEf+gyk0s496lASVMxXrnsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ustWpdp7v2n3D7GaggWwOJTdasDrUiihRJbkTGzyrsY=;
 b=rxGw9jUllMmjUAokFeLey2iicaO7wMCyVwE1eaUENII2lchNNx+L78f6Dbpbxo/nZ7phi5tokpY1e4h/eBEfX7AXwM4+5IkD8kDvVwV2lgQoSml8gOV+ttrcIKnAjfl7HEPqG8VZEhuTM7yQI5nGFELZF7xpsH5RGAUvCKy0YylFW8qtPsSFRTEhGmAMegHPQeAqu+VbTKRbUI4nu6o6EA1+AScnNQo+sZfYr1RcTzvPi3so+n8YpyXknZUS9+l/g5jcb7P0jC+wNRe9fCjWjs/liPL9Fx0afBv6UgHPyN81NKXp+KNtahBJAI/eAzxx6fnhiDqCHQ+JbtEEC6Jz+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ustWpdp7v2n3D7GaggWwOJTdasDrUiihRJbkTGzyrsY=;
 b=Ym+qVMVPmo5hvp7Ksay9FB5W4rdfjq2Vkki6bo3M60CewrVilDmFDCVhJFcy175Jr0KCfSCeWfpGCjuqH69OJAESjoqzRUaukzCxqmDvpKkPgKlzjqg6cqBa2Q66K96njqGXwljcpAZltJc3EoSOwjE3jBrxtG4Mf6fQR+BGDXvyNufWuN2OpHI2nGYYW5WM4298C8krLlDR1apVa2Mt9q6eOC4mhcfIo+oZNIFPlqsebPpaFtW2f1g9fUrK6tM32p8We1Lmm6miZoFm1d2saWGdZFYybF/JOiTa5DGOTBgZ5YHxNFdzVlKdFl1LgiqZNSGJ6dAGxt289/fzHMOcnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GV1PR10MB8904.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 07:23:11 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8422.005; Thu, 30 Jan 2025
 07:23:11 +0000
Message-ID: <a57c6f8f-47ce-4202-9fb8-fab2c33fbe7c@siemens.com>
Date: Thu, 30 Jan 2025 08:23:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/3] build x86-uefi with secure
 boot
To: Jan Kiszka <jan.kiszka@siemens.com>, Sai.Sathujoda@toshiba-tsip.com,
 cip-dev@lists.cip-project.org
References: <20250124132246.64738-1-Quirin.Gylstorff@siemens.com>
 <20250124132246.64738-2-Quirin.Gylstorff@siemens.com>
 <38e3b2ea-9dad-4f14-8e73-9dc8f4c05f9d@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <38e3b2ea-9dad-4f14-8e73-9dc8f4c05f9d@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23)
 To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GV1PR10MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 165d5f08-b236-4db7-ecdf-08dd40fef3ad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UTdGaXZMdjVOd2dXQ2NzM3VXdVljY0Qzc0QxMWQ3eVUvMldTNFRiU1hQTERU?=
 =?utf-8?B?N2VTM0RXeXpwWHhNZlJCcFJGRlhwdlpOa25DY2g0Q1BQL1QvMXVkbFRTWlhD?=
 =?utf-8?B?K1VNY2tuSGtERTVjVml0dTdoa1hNYkVNZGxLTmovUHFSSDFxV3VJbXhSdlRN?=
 =?utf-8?B?NWlDckd6SEhBckVoeFJUMFlQOUs2RlBZNzZ6TGdBb3ZCNm42cnZZaG92RXdL?=
 =?utf-8?B?N2pQVkpCbWVWNldBR1AvRzVSSGxBRWQ3OE5tcXNQbzNaN0xlQnFhcjZvc0U0?=
 =?utf-8?B?alNCOW9hY0dKazY0VlhlUEpieHJRQ05YMlRtQ3dTcnQxWG95VjJxR2JkQ3dB?=
 =?utf-8?B?YUdseHFKQU9WRGpFYzNWL1JIMFh5d1RvWGcvalBhQnlwS2RpSXQ1bit4cUwr?=
 =?utf-8?B?K0REaGRQVHhWdXdWZjJSVnJQaVE0QjBEOExoVTduQlYwRnk5dkZqV1JuVE0r?=
 =?utf-8?B?bDBsUTAxb091aUZnS0xzZ01XbkVpSWlScmk0cmxOQkZ0bmZ6L3BERnN4Q25o?=
 =?utf-8?B?STNwVHorVnc4ditzTEY1NWdBMjJpaHQ1NTFUaUVFc0lBWmFZTWZxTU10U1pV?=
 =?utf-8?B?RWxGSU1nb2ZwSVIrUGw3am5Gek1xR3pIRjZFM21MdG03eXZ3T2VNd0lCelRi?=
 =?utf-8?B?TCsrRTVjMFR1TTRBcGdKSEZZWlJqRkQ2bjlvS3JreldNRExiMkxVN3dPdzdK?=
 =?utf-8?B?UWxKUGUrVk9mVjZWN2hkbk8yWGUyRFpTRlNEcm0vemJhV2hoUTIvenVqaXdJ?=
 =?utf-8?B?VVV5QS90bFQ4aVFrcW1CK2ZJZldlQkQzeCtaaGVUVWExTkgvU1oxdEVzNmFW?=
 =?utf-8?B?UnRPU1pwWHBmTEtFbHhMRnp4dWtzV0FPdkw2NElvMERTRXQzZHdEMDZQUDhD?=
 =?utf-8?B?VDVrTTVQcE0vSHlkVzdwWjVBc085U29hZUxObStsN1hBaDFWOFdLKzYzaEp3?=
 =?utf-8?B?ejlCTm5uMnhCZ1BpQjRDNjJGcVY0Qlp1RHl0cDN5UUQ3QjdueDRBTlM0aHFa?=
 =?utf-8?B?Wm9DdloyR2c0R1NsRG9xOTFHN1pUTFFFZTY1UjdIdGZsWlRIRVZZNFJqQk1Z?=
 =?utf-8?B?VmpuSXNHZk9ZN0JEQUtVQUV5S1VsZ2o5RXV5eXliY3Q0OW9wSlRNbCtCWDdS?=
 =?utf-8?B?eHBNOHBxTS9XdGorRmdCdWFXdDR2WXJjWUJLRzBjVmh0VTFSN3kyb1dMcnNW?=
 =?utf-8?B?d21ZK29xZVRWMW9OR2Flck0zMGlzcDhEOHRlOFVQcS9mdTJ6anVGVVh4RzZP?=
 =?utf-8?B?VkM2ZnRiaTJmaEdkeDdYbHBpQlc0L1RlZ0VKTU9JcWV6bnZ0REd5a3VOUlFx?=
 =?utf-8?B?Nm10OEJ4N2J2SHFhQWxmcGcyTFFQU3QrRkdvdUtIN2pZbXZsNnphSnZ6c1Ju?=
 =?utf-8?B?RHZob0dEbUFLRnVtajVETzlkY3NUMUdHYUJwN2haR291K0JHQUUyZGtKTDFQ?=
 =?utf-8?B?UEdBSndnUTM5Z0YreGlRZFBLRHgrWlVtODhkUHBadHlydWpXaHQ2alIxSzY2?=
 =?utf-8?B?MEcwdWNTWjVlUSt1YVVVamhyVlRiWFJiNGllVjFQZTE3am93SHRJbG9aUmdo?=
 =?utf-8?B?NW9zaGhsUU56K2daS1lROTVzNjZ0YmxocXBxaXV1dG1Idnk3UVdrdUZzMlRP?=
 =?utf-8?B?TStGWVJ4dXo2bnhjMkhuWUFqL2R2UzNMUUsyTHlDQ0RXaGhaSk1CSnlqWWhK?=
 =?utf-8?B?eUZ3M0NUNFBlMzBGbUNYdkNBRXZVWmw3Q0Y1ZElhOHdnaUU0Si82MFJXcVVh?=
 =?utf-8?B?MDBUdGNnY3hydlBXV21mODU0djBSem8yL2dmMlNpNE9LWmtNanBoSHRWYzE3?=
 =?utf-8?B?RGhJaWQ5a1NtMGRreWNrdXZRR09iY1crN0RHTzVjZ2g3VUo5VHNCY3RZSjVh?=
 =?utf-8?Q?C1iKETXEG2v0t?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cGx6RlJQbE9vcUdneGhoS2FGdVoxZDJ5TXFLKzI1akc4RlZIZTYyc0ZLdzBD?=
 =?utf-8?B?TGhDV2Nib0RERm5GUzJDUXN0MVVNZFpubG1uc24vSUxBZktUV1RoZ0NpK3hv?=
 =?utf-8?B?cEJuamdwQmp1b3pqcGF1RTdaZ3VKNEhpblY3VDdOVWdleW5kMGVPYXNkMDlZ?=
 =?utf-8?B?U3JIVWJCMGJ5NEt2YXdBSExlMW5oVVExTi9PSjdRUy9DQjBuWm5QOVZBTWpq?=
 =?utf-8?B?NkpndUVHRU5ILzMremIrTTEzbHFXYlZBcllxWEtEQjllYWFCR2Uxbk9VK3Q1?=
 =?utf-8?B?Z0xJUFZwYzExTFZOREFjdHlsZnpEN0Mxc2ZYUnlGN1RYZTdsYUxibzdEb3BE?=
 =?utf-8?B?dndVa0UzcTZzanRlWU4zNGJUTllmUGZBbW51Yjl6U0Q1NmxOdXJTV3h3SGNH?=
 =?utf-8?B?Y3AvZ3FQNHBWUzhyVkptdUsxUVd6ZTdlYkdCcTIwTU5EYUUzdXVYTjlyRFkx?=
 =?utf-8?B?T0ptc1pybmVaazBVSnpXR0piRmdxb2tVa2d6a3BWNVhHcEVJNVdYRTNSbkto?=
 =?utf-8?B?TWdLeEtrSDBhREoyR0dIdEEzd2Q3cUU0V2prOFNUSG91amlKa2srWVdGaVF5?=
 =?utf-8?B?aFNHVS9CR3dMWk9hcVhtOE9pZTBqVzU0RzFGdzY1YWJ0QlRuM0lBa0pXZXNZ?=
 =?utf-8?B?OWpxS3JRMU1ENkUreFh6QWxmajVKZFNkRzhRdmZvR1VKVkhUS2U3bDI0bnlU?=
 =?utf-8?B?QlFkeVVJUzBHTEsveC9aVmx0Q3FsVWFLdU5yUlpyWEhsdlZ6Y0s1MWk5dUxZ?=
 =?utf-8?B?bTBkZEJ4eFVudnZjbi9ISzJpU2pIYUo2NkpTNDlIWnlNZWRLdmFONUNsNzJJ?=
 =?utf-8?B?bGVVdE0zRk1OalNtNVA1bTV4TG5xcFJlWlUyb1ZKc04zaFRtQWlQdDFpN3Yy?=
 =?utf-8?B?MXZYU1VRVjF4L0JWWVQxUzFJcnRic3lSOFFUb2xuQ1FqUXBhRU05YlFwRER2?=
 =?utf-8?B?Zm9xbGJ2RjVtUDZueVBRRDlpdHhhV0kxUnpSaTdqQ1EySGtPQ0h0L3BwSjBE?=
 =?utf-8?B?dXdEWU5iUXFSS0tqSFRyWWZCWmIxOVBxSzlGMEtITjdqWUN4aWg3aDUySWh1?=
 =?utf-8?B?clVjanFBYnpPRHlTWGgvZUxma2l0TkVnSjE3NTJ1THNRa202djBJbmswbHpF?=
 =?utf-8?B?cUJYQ0JJTVBJVXljaDRCZ1Zxc2FtZmp5RkpQbVBzYkJjeGhmRmtTWTQ0Lzcw?=
 =?utf-8?B?eWk5QW5wVkZ2cDlUT1B4K0s3Qmk3cHFhL2lpTEN0c3RSY3pmN2wvSHFnTERH?=
 =?utf-8?B?bDUweE94NGhPNmdOU3BnZVV6SEgvK0FEME5HaHAzMkVmTVBTMXViNkphT1R1?=
 =?utf-8?B?cWdUeFZYYWJQU05ibVdTdFgxcExDOFZBSzJuN2hNaVMrN05FRXlEME5sWHo0?=
 =?utf-8?B?RjduMkNHczJDZFQyUTcvZXJoMG1od0tYT0t0cTZhL2FhK1R0UEF5OFNhYWhM?=
 =?utf-8?B?SmFuRWtLbmFYM2lRMEk2ODhsamFCNEJQSFlwaUVJRmg1WUxaR2hEN0NWYUxp?=
 =?utf-8?B?Z0FPZ0J4cmljTnNDNkVLaW82c2U5L1NILzg3bExLWEZJcGJoLytZekdLeC92?=
 =?utf-8?B?TVBERWNRWlpoZEEwODRmb3hRa29uY2o0QU9rYWhkQXdlbExiYmhraDRoUENw?=
 =?utf-8?B?NVVUWkU0ZnpyOGNNLzl0ZVViNThMb1NKM0MwNm9YTEl6VjNwaWZLeDFSZHY4?=
 =?utf-8?B?ME1ycCs0TTZuaHdzbktjbjF5c3FTRlU0ZFJobWIybFA2ejg1d1FpZGVrWXVF?=
 =?utf-8?B?UEhkYmU4RkZ5QzRCRXJWOUpoUktpbnJucmlCN2NMWDZhUTdxYTZiS2hoMmh4?=
 =?utf-8?B?YVlkRlMyU2NIWHhpUTBoVjByelJ6QzBPdmNBVy9XY3BZcnZnWVd0ek8yOGRF?=
 =?utf-8?B?OEs1Y0xZN2VIQXJ4Q2pyZmsxbHpBUWxyQ1hFS1cvNmcxbGVtYjRiRFp0VVIy?=
 =?utf-8?B?bE5yWk84Ry82QklJVVZoVngxUUpsQUsrZStuL2c4U0hFbktxRUtEYmlBL1VX?=
 =?utf-8?B?YUd5S1l1WDZlYVJKSm1BbENRUFBKL3pvNmtwNDl1WDUyUk05ZXFBN3pjYS92?=
 =?utf-8?B?U29mZmZScmJBRUwwc3NxUERveFdzUUw0OFhseGdFbW9uZXdMTkFZNUFhMWVW?=
 =?utf-8?B?b0dDeUk5RHpKK1VLUUxOWGxPVzZTVFBTWWJqWVVQQ2ptb3ZjMnBtTWtHcW5o?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165d5f08-b236-4db7-ecdf-08dd40fef3ad
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 07:23:11.1859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZ1yLHzKCugLz8gX1kxeyrqE2x/JbyNCnYjPuPGvIH74alz07Gt0zO/2wRqV9j+rhq5Osnc/97yyCOR2BAQi107hDBMQuaKqlO/OvVKsS8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 07:23:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17686



On 1/30/25 06:29, Jan Kiszka wrote:
> On 24.01.25 14:22, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .gitlab-ci.yml | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index d4bd283..42e247d 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -241,6 +241,16 @@ build:qemu-amd64-secure-boot-encrypt:
>>       deploy: disable
>>       encrypt: enable
>>   
>> +build:x86-uefi-secure-boot:
>> +  extends:
>> +    - .build_base
>> +  variables:
>> +    target: x86-uefi
>> +    extension: security
>> +    use_rt: disable
>> +    targz: disable
>> +    encrypt: disable
> 
> Why without encryption? And can't we replace
> qemu-amd64-secure-boot-encrypt with this physical target? I'm looking
> for ways to avoid building more variants.

Last time I look the qemu target was also tested.
@Sai can we drop the qemu-amd64-secure-boot-encrypt ?

> 
> BTW, you are dropping "encrypt: disable" in patch 3 again - it's the
> default anyway.
That was a copy paste from the build:qemu-amd64-secure-boot-encrypt:
  target.

Quirin

> 
> Jan
> 


