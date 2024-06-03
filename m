Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3C4C25B75
	for <webhook@archiver.kernel.org>; Mon,  3 Jun 2024 09:09:16 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.75])
 by mx.groups.io with SMTP id smtpd.web10.78874.1717405754836654605
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jun 2024 02:09:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ryrCWPgP;
 spf=pass (domain: siemens.com, ip: 40.107.6.75, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkI7WBqEPBKyHJSG2UPcw3xsNxVlRAtfKDuZkWkFZCUgF1A1wZ86awoiTtY7mQc3LjAAmwzMgXJu/exg1zIY2Mfzq/bjxIVP0X0SJ8Oes88MXmradVotF/ClH682ea7vTepWJxMbeLua8HxWdcb5eg78rmUOkMY/sDIoqsAqMviZkwfAElmsgxsoVZepbBuMVSP/+Oa9ArXRTVB/9ukxJ5hS/PC7tY9iJWjkqbSkySKOd7BEJJciKJPnfeIDCIT+0FCRIY4TrdbzJKdm6i2WpcODBau1wD2ZaUr4FFK8S4YvCWoEn5Jf9FSAKuE27SGNnYU0eBBSef1b8/oQwLYIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abjmsoTtj7DYJSEK0J6mRKm3xOdmGMsURpfriuOBGO4=;
 b=GahIp9kZRnAUtnvy73RCACJJU+fMd0woL7fuCO/aOyX5GLOjgBPPr8oUofF59v2v+VUsZuiQu0ManULzBqN0xIALFoYRk7M6RM7dLtjvk/Wv+uid+eFRcfyKfq05aeA4pj6PqtAJ7jZ4gmiDUrypV6SzoWrum+46CTZUewt/aBGVjgRt1lSof13uLyZ6znXnZVuFK40Q0RfHxUs2SWUvM+TLPGcrwqn0SBMkAshlVMhOVy74g22TCvvQu5zxacHvcpmRE3U+LHPNHIu2vHUPxT4d9z73wQ67ZOSAKCda4ThyL+1VvYrXyIB1LmdWEp9Q+i5Gg1T/+XXdht9ZHtYH6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abjmsoTtj7DYJSEK0J6mRKm3xOdmGMsURpfriuOBGO4=;
 b=ryrCWPgPlrPxb1KiEROaTgAWPKZTsnlGZlSHrUZ6Ul8ySGW1echwMIE8oGXDdbvwZDUC7VkNTvDfaCiafJdznwDxOoRZ5cA746WCoe5tVvboTqqXX/fEKq7wb3joKBtzHCBmrVMHrWfzVd3IgIJOx8XLH/T76jVGXFtzPboUkHJ7nSjlWGMD38lPiBjUjjTubmDGNysKXVCdfwF/TSI6cAjQaPKU6GvSPeZ7Y6/b63d1C4jxuoDQOU4lOZu0Nhp6P/lGLSUUMdCl+HhxAP5P5wdDmyjI5usy8LebYqwIPK9O+kY9izGfmKD1YWgHoyEONCdN4z7Ud8EjwWku61ASag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7920.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 09:09:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 09:09:11 +0000
Message-ID: <41e33c3b-6f1f-46b3-9061-a1368fa8a088@siemens.com>
Date: Mon, 3 Jun 2024 11:09:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 1/3] test/templates: Include functionality based
 templates
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240603070920.2942859-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240603070920.2942859-2-Sai.Sathujoda@toshiba-tsip.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240603070920.2942859-2-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 958ca7c1-71d5-4a24-87e8-08dc83acd570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dUE4M01RVUVwZHp4aDNwVHJlNGpHSk5EZ1NsdnphNGtxWjhCVEFDQzBNZEo3?=
 =?utf-8?B?eVFsNW5WMEpxYVRRMXVZckRLcStrYTd4TUhDRkNMM1dybmRFYmx5Ykxxc3hu?=
 =?utf-8?B?c0g1REdmSGVuUjQ0U2NKY1Rrd0I4bFd1UTRNcXJDbm1WRWdxUkgySlEyNXUy?=
 =?utf-8?B?cXk2b2ZxSGt4aE1wd1FrcU9UY0JrUUU1ZmF6Tm42K2JsbVV6aGppV1hiN3hP?=
 =?utf-8?B?SEZiVjU5WHZYeVVidjBjUXlObzVmTjF2WW12UjNocjhvVi9TRW1CYlFxWWRU?=
 =?utf-8?B?NmNmK0dBOHVhYXJ2bHlLM1p1RW14SVl3dVdBUW51MTFPZFZzMzkvRzY4WUVh?=
 =?utf-8?B?Qmw5MThZRndINU9jVzVmaHpJTGNNN2ROMzJDaE5kSVgyV1lQbjgrTHJ2c3FW?=
 =?utf-8?B?NGpMZU9qdFFhdzNQbG9jSjhVaGFmZTQvMFQ3Z0ZqRzhBaXlGUjdGRnkyVWNH?=
 =?utf-8?B?RGh1QUs0eUlPMXlXSytsMXJTOUkzSXkwN2I4MHVueUkwZDJueVRGVnJIT1RQ?=
 =?utf-8?B?NHZrL2xsQWRvVFJNemNzSEdxSk5IMVQ0eGVLWHN5WThWeDQ3d2ttbEtjd1Jy?=
 =?utf-8?B?QVZKUHBHK3gzZXRhWDBTbDVzcm5lWlF0Z25KR0hObEdKTTdkcWFFTHUzTlU1?=
 =?utf-8?B?aURna3JKSlF5YlFmV1YrNGpzMis5V1dzQ1dMQVVTQm1jSXVJdTNrelplY2lr?=
 =?utf-8?B?bTRoay80d2E2dzZJR3doYzA4MjRKMHJDakRYSEZTdWw2MW9IaHA1SjROVUZ3?=
 =?utf-8?B?eUNWOHYydSsrUXVvZk8xcnpZNFM2djUwbERva3E4ZnpXbnY2b3lGZW5wOHhN?=
 =?utf-8?B?WHVTRm9QNkFlanhNQi9sVjNkYkNVVWk0bzhQUXlhelBJa2NORWFFOGROem8z?=
 =?utf-8?B?Q2hNRTFrY2VabzBMZWRNaStoRkpMem1TY1I5ZHJwQWZMcG5aOWFxVjFsTm9w?=
 =?utf-8?B?S3ZhRXNrdW5zK2NseERIVWNpRHpEbHNWbm1aL0UwdWxLQkk1d2xmcDVlS21U?=
 =?utf-8?B?VXJlYjNxM3dHcE9CM1ZvdFJNaDBNV0xIV2g2aHdLdytXblltT2JPWDAzYUIz?=
 =?utf-8?B?VWlsdTJWWG41VTZQOTdMaG1IN29DdlVQRFlUcm5aM2orNzFXQjJ0a1U2Nllz?=
 =?utf-8?B?NzNsZjBKV29LVUVvaDhzWFJ4dmJFK1NpMmp6R3N5MGU4RmZYYXhjamQ5Uzl5?=
 =?utf-8?B?Q2hQQ0Q5N2FDNiszVk05aVR2cXJnM05VTTNTeUNwSWp2WUV4YXBacVZRb0FU?=
 =?utf-8?B?NlJNakRjemM1UW92UkE0T3JvQkJHNzVOY2NwZzRuTFg0VlNGdVZyZjhLTWFW?=
 =?utf-8?B?bnYycGRpTXNnZ2IxWmNwLzFoL00yMkkvc045ZzBjM2J0TWRuWENrZ2xod0VO?=
 =?utf-8?B?djFCUXpnWllmM2x2UEVUZnpRNkdxRXh1QnB1K0FBMVQxU1I5Wm0wSGhWemNN?=
 =?utf-8?B?STdDREdZOTMzaThnWWpuaXhvMVJ5bVlyWDdOZTlINmV3N1Nvd2R1THpnZGlV?=
 =?utf-8?B?RVRKT0poMjdkZ2lieHZ1V1FKZ0ZPVXNQTTF0OGY5L2FQNXNyWjRmYUxtYWN5?=
 =?utf-8?B?byt2ZTk5MEtkZFhNZ3JaT1l2ams5OUVVM1RFTHo4anZocjhwdjdTVzBQOG9t?=
 =?utf-8?Q?CZS8Txs1Pd5jpK6Awa0z69iI+rBDlZqbDwYVsEm7P9r0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RC9nclMyTVk4YzdadFdSS3hTYzhEazJYRlBXMFRqM2o1THV0cEord2JvYUxh?=
 =?utf-8?B?a3FTL3lKMWd6MG5uZXRmK09PZ0w5VkhIV0RUY1BJMHJFcklkZ2FVa2JTQzR4?=
 =?utf-8?B?RXNvbFQvM2NWaktvTjlFSDU2eGFPSlc5SzFYRXkwTE1OTGkrWnN0b1VNcHNM?=
 =?utf-8?B?RHNRRkR4c1kzTlBPdEZUbHJrRXFrN0FGTjUyZGh4MW9PaHI5SkEvTTR2T0NX?=
 =?utf-8?B?cy9lNjBCOWJTV0pwNlJob1J4djlCZEh0SHUrWHNYRkwwek5iUEtlMTJwQVBF?=
 =?utf-8?B?c1pPQzdmT25td3FSbzZhSm5HNGEvWEZkVEVLZTNuM2k2dXVaUUNYT3R2QTU0?=
 =?utf-8?B?MFhXeXZGL0NKVnZxUzBwT3RzWVR5eFI0empSYXlKQVluWDlIVWVpRVgyNFh6?=
 =?utf-8?B?SU9JNlhpQzRwNnJMVlpRRTl5Vk1zZG9vajF4N0UrMjhWZU8xU1IrT1J4UU51?=
 =?utf-8?B?ZWN2bVJEWFZIeU1SVElwSTBGTThzcHdZRVVmeVZOdHBNeElKcmxRSXRMSFZC?=
 =?utf-8?B?MlI2Uk5Cb1Y0dXAwK3VGZVdGSzMwbnQrSUNHbXZxaU42MlFLOCtoNjZKNGpq?=
 =?utf-8?B?ZlRCT0hzUzBkb0g5d0lKaXFLeExESVJaUDdrNml1dkU5ZXA5RnJDMWJvcnla?=
 =?utf-8?B?RlBpSWJVbHN3S1VGRzZsTElBVnBwRXBkVTlERVhlMHpYc3hBczAyNDlZeFJI?=
 =?utf-8?B?WFpmTitSRm16NW12c2pXT1ZvNkIyYWZnZTl1YlBEOGZqcW4vTTk3VmVWbGw4?=
 =?utf-8?B?dHh5ZURYSXk1cUgrU09ncGR4ZUVIYUhUYlE3ai9jNUUzOC9kSklTampFWmVZ?=
 =?utf-8?B?RHBUMCtZQVlFZVE5eFBjMDl5NmFVM0ZxeXdrbHNtSVVKOWVQa2VoMnpEckpC?=
 =?utf-8?B?bDJjemhWTU9MbzdFMFJCdnZrS3BzMzJneG5pYVJSVnRoNkFUYnFVcUlUVnBX?=
 =?utf-8?B?Q0hNcngrRWJCN213K2pMQmhrQ3FzOENjdVZxdVdxbm9ibDNDNUxwNGNtQjQv?=
 =?utf-8?B?THlSNUs1a093bVk4bkdRYUgwV0ZYWWRNOUlpSnJZeVloSElXbDVzMWlyWUZk?=
 =?utf-8?B?MHZic24yK1NpajNaMDVEWXhFYWxSTm90bDhLRkJla3gzQjJKYlFQV1piMk5r?=
 =?utf-8?B?UVhZTHUxQ0N3T3RnU05iM1hDeUdpRUIyYm9nMVVXY0U2NVlSNzdkMHFrNnNt?=
 =?utf-8?B?QVhRWHdhOHNScmxxVWdML0JXZjN3T1o4ZzJTQlJsWWcwZ05GaTJRUjBMSHBI?=
 =?utf-8?B?N2p1MDdqSkRZT1g0R09GU09TK3FWYy9CcXlUb1ppLzN3Nzlyelc2YUlja3hM?=
 =?utf-8?B?UlFHUUxCQzlnelFMdFdlVWdyMXlMb0dZQWJVVVFjWTkwRUt6V0F1MlA3aXRk?=
 =?utf-8?B?YjVpbWRtQnNiRVdwNllaZDhlNDlXMEpwaitUZ21jUloyUVpMNGptY0M2N2ZZ?=
 =?utf-8?B?cXhML2ZoNVR2em05MFcvSlU2N0FXQ1FxT3BzOHp4dElLM2VRbUxNOXkzWURU?=
 =?utf-8?B?eDgwbFI0Rk1YeGpvWlhTWHh1WUluTlVDR0h5SUZxMGtUK1Q1ejBuWVRVY05z?=
 =?utf-8?B?K1VJMGx0djlVRlc3aFhGSGVPelpId2ZRUEFCS3l6dUJUdzc0RzAzd05lbi95?=
 =?utf-8?B?MHZCMFhrb1luYmkzay9uVXZYaGQ4TTJ0UjFiTk5haEdXOVArQmJPd1FVT2Vw?=
 =?utf-8?B?ZnpQb2dKdHl2RnRPcTh3MVVWWXlPeWUxSnN5YTRMaTV4NG9uSnhzejBMZHVI?=
 =?utf-8?B?U3dLVFFYZHlQclpUVnVUeUpLb3RGVkpUd3d5dVNYc0NhSDk3cmFOemFOeVFT?=
 =?utf-8?B?NmxtY1RmdDdKd1ZUUVlGeWhtT1liYnFIM21SOHZYYTF4NSsrUmxoUTRPUm9Y?=
 =?utf-8?B?WXhWWGdoUEsyTDdNWElGMnR1NVp6SHJNaU83YnMrQjZ3Vy82VVU5NW9uNVEr?=
 =?utf-8?B?eERhT0gyNEhta3NkTkVxR0dmVks3WnQwUGg4ZTJZTStJQlF4anoybDlQWjI3?=
 =?utf-8?B?anZUazFxTkJHMTNYSFN5RUF5dE5rcjZ5cit3dzB6UVdORE5zU01mUzIveW5Y?=
 =?utf-8?B?bXdUd3hHYkdUR0lvOFhTZ2h6a2tYY0ZxaWE5ekFwSnFZR0NkaGtUWTVNMkJW?=
 =?utf-8?B?UUQ1WmNxbFBwYmFIWHVDZ0JZK3dYK29uNWZ0SUFtUm9IMXJTL1dTMllLeXBz?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958ca7c1-71d5-4a24-87e8-08dc83acd570
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 09:09:11.9136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwCHx6x3kCTn3FYkRqxGZigdw5NHd1YOrA6ZzdedpcMK0y47uwRlpYdQUyrK/c8C9xUzVg3XLT/AN4kvZ4/iug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7920
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jun 2024 09:09:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16088

On 03.06.24 09:09, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> These templates shall be extended to form architecture specific LAVA job
> definitions
> 
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  test/templates/IEC_template.yml        |  72 +++++++++++++++
>  test/templates/secureboot_template.yml |  63 +++++++++++++
>  test/templates/swupdate_template.yml   | 123 +++++++++++++++++++++++++

tests/

And a short README about what is expected in this folder, how to use it
would be nice. Similar to
https://source.denx.de/Xenomai/xenomai-images/-/blob/master/tests/README.md,
but you can start shorter.

>  3 files changed, 258 insertions(+)
>  create mode 100644 test/templates/IEC_template.yml
>  create mode 100644 test/templates/secureboot_template.yml
>  create mode 100644 test/templates/swupdate_template.yml
> 
> diff --git a/test/templates/IEC_template.yml b/test/templates/IEC_template.yml
> new file mode 100644
> index 0000000..7f930cc
> --- /dev/null
> +++ b/test/templates/IEC_template.yml
> @@ -0,0 +1,72 @@
> +device_type: qemu
> +job_name: qemu #architecture# IEC layer testing
> +timeouts:
> +  job:
> +    minutes: 30
> +  action:
> +   minutes: 20
> +  actions:
> +    power-off:
> +      seconds: 60
> +priority: medium
> +tags:
> +- swtpm-jobs
> +visibility: public
> +notify:
> +  criteria:
> +    status: finished
> +  recipients:
> +  - to:
> +     method: email
> +     email: cip-testing-results@lists.cip-project.org
> +
> +# ACTION BLOCK
> +actions:
> +- command:
> +    name: start_tpm
> +    timeout:
> +          minutes: 20
> +
> +# DEPLOY BLOCK
> +- deploy:
> +    timeout:
> +      minutes: 15
> +    to: tmpfs
> +    images:
> +      system:
> +        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4 -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'

This is a really long line. Can we wrap this around somehow? Maybe with
the help of 'image_arg: |'?

> +        url: https://s3.eu-central-1.amazonaws.com/download2.cip-project.org/cip-core/next/qemu-#architecture#/cip-core-image-security-cip-core-#distribution#-qemu-#architecture#.wic.xz

This hard-codes the origin, project and even branch. When someone wants
to instantiate this downstream, all that needs patching, no? Can we use
variables for that as well?

> +        compression: xz
> +
> +      #Firmware#
> +        #Firmware_args#
> +        #Firmware_url#
> +
> +# BOOT BLOCK
> +- boot:
> +    timeout:
> +      minutes: 15
> +    method: qemu
> +    media: tmpfs
> +    prompts: ["root@demo:~#"]
> +    auto_login:
> +      login_prompt: "demo login:"
> +      username: "root"
> +      password_prompt: "Password:"
> +      password: "CIPsecurity@123"
> +    
> +# TEST_BLOCK
> +- test:
> +     timeout:
> +       minutes: 30
> +     definitions:
> +     - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
> +       from: git
> +       branch: master
> +       path: iec-security-tests/Singlenode-TestDefinition.yaml
> +       name: Security-Testcases
> +
> +context:
> +  arch: #architecture#
> +  guestfs_interface: virtio
> +  lava_test_results_dir: '/home/lava-%s'
> diff --git a/test/templates/secureboot_template.yml b/test/templates/secureboot_template.yml
> new file mode 100644
> index 0000000..124ad15
> --- /dev/null
> +++ b/test/templates/secureboot_template.yml
> @@ -0,0 +1,63 @@
> +device_type: qemu
> +job_name: qemu #architecture# secure boot testing
> +timeouts:
> +  job:
> +    minutes: 30
> +  action:
> +   minutes: 20
> +  actions:
> +    power-off:
> +      seconds: 60
> +priority: medium
> +tags:
> +- swtpm-jobs
> +visibility: public
> +notify:
> +  criteria:
> +    status: finished
> +  recipients:
> +  - to:
> +     method: email
> +     email: cip-testing-results@lists.cip-project.org
> +
> +# ACTION BLOCK
> +actions:
> +- command:
> +    name: start_tpm
> +    timeout:
> +          minutes: 20
> +
> +# DEPLOY BLOCK
> +- deploy:
> +    timeout:
> +      minutes: 15
> +    to: tmpfs
> +    images:
> +      system:
> +        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4 -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
> +        url: https://s3.eu-central-1.amazonaws.com/download2.cip-project.org/cip-core/next/qemu-#architecture#/cip-core-image-security-cip-core-#distribution#-qemu-#architecture#.wic.xz
> +        compression: xz
> +
> +      #Firmware#
> +        #Firmware_args#
> +        #Firmware_url#
> +
> +# BOOT BLOCK
> +- boot:
> +    timeout:
> +      minutes: 15
> +    method: qemu
> +    media: tmpfs
> +    prompts: ["root@demo:~#"]
> +    auto_login:
> +      login_prompt: "demo login:"
> +      username: "root"
> +      password_prompt: "Password:"
> +      password: "CIPsecurity@123"
> +    parameters:
> +      kernel-start-message: "EFI stub: UEFI Secure Boot is enabled."
> +
> +context:
> +  arch: #architecture#
> +  guestfs_interface: virtio
> +  lava_test_results_dir: '/home/lava-%s'
> diff --git a/test/templates/swupdate_template.yml b/test/templates/swupdate_template.yml
> new file mode 100644
> index 0000000..3284977
> --- /dev/null
> +++ b/test/templates/swupdate_template.yml
> @@ -0,0 +1,123 @@
> +device_type: qemu
> +job_name: qemu #architecture# software update testing
> +timeouts:
> +  job:
> +    minutes: 30
> +  action:
> +   minutes: 20
> +  actions:
> +    power-off:
> +      seconds: 60
> +tags:
> +- swtpm-jobs
> +priority: medium
> +visibility: public
> +notify:
> +  criteria:
> +    status: finished
> +  recipients:
> +  - to:
> +     method: email
> +     email: cip-testing-results@lists.cip-project.org
> +
> +# ACTION BLOCK
> +actions:
> +- command:
> +    name: start_tpm
> +    timeout:
> +          minutes: 20
> +
> +# DEPLOY BLOCK
> +- deploy:
> +    timeout:
> +      minutes: 15
> +    to: tmpfs
> +    images:
> +      system:
> +        image_arg: -drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4 -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock -tpmdev emulator,id=tpm0,chardev=chrtpm '#imageargs#'
> +        url: https://s3.eu-central-1.amazonaws.com/download2.cip-project.org/cip-core/next/qemu-#architecture#/cip-core-image-security-cip-core-#distribution#-qemu-#architecture#.wic.xz
> +        compression: xz
> +    
> +      #Firmware#
> +        #Firmware_args#
> +        #Firmware_url#
> +
> +# BOOT BLOCK
> +- boot:
> +    timeout:
> +      minutes: 15
> +    method: qemu
> +    media: tmpfs
> +    prompts: ["root@demo:~#"]
> +    auto_login:
> +      login_prompt: "demo login:"
> +      username: "root"
> +      password_prompt: "Password:"
> +      password: "CIPsecurity@123"
> +
> +# TEST_BLOCK
> +# Sleep 200s is added to make the job incomplete with a timeout if software update application failed
> +- test:
> +    timeout:
> +      minutes: 5
> +    definitions:
> +    - repository:
> +        metadata:
> +          format: Lava-Test Test Definition 1.0
> +          name: sample-test
> +          description: "Test software update"
> +        run:
> +          steps:
> +            - if swupdate -d "-u https://s3.eu-central-1.amazonaws.com/download2.cip-project.org/cip-core/next/qemu-#architecture#/cip-core-image-security-cip-core-bookworm-qemu-#architecture#.swu"; then echo software update is successful!!; else sleep 200s; fi
> +      from: inline
> +      name: sample-test-1
> +      path: inline/sample-test.yaml
> +
> +# qemu-swtpm.sock will be gone after soft reboot.
> +# So the swtpm socket need to be started again for proper reboot
> +# To start the swtpm daemon, first the existing one should be killed
> +- command:
> +    name: manual_kill
> +    timeout:
> +          minutes: 1
> +# Start the swtpm daemon
> +- command:
> +    name: start_tpm
> +    timeout:
> +          minutes: 1
> +
> +- boot:
> +    timeout:
> +      minutes: 5
> +    method: qemu
> +    media: tmpfs
> +    prompts: ["root@demo:~#"]
> +    auto_login:
> +      login_prompt: "demo login:"
> +      username: "root"
> +      password_prompt: "Password:"
> +      password: "CIPsecurity@123"
> +    parameters:
> +       kernel-start-message: "kernel: C:BOOT1:linux.efi"
> +
> +# sleep 180s is added to make the job incomplete if ustate is not 2 in the updated partition
> +- test:
> +    timeout:
> +      minutes: 5
> +    definitions:
> +    - repository:
> +        metadata:
> +          format: Lava-Test Test Definition 1.0
> +          name: sample-test
> +          description: "check boot loader environment variables"
> +        run:
> +          steps:
> +            - if [ $(bg_printenv | grep ustate | awk 'FNR == 2{print $2}') = 2 ]; then bg_setenv -c; else sleep 180s; fi
> +      from: inline
> +      name: sample-test-2
> +      path: inline/sample-test.yaml
> +
> +context:
> +  arch: #architecture#
> +  guestfs_interface: virtio
> +  lava_test_results_dir: '/home/lava-%s'

Jan

-- 
Siemens AG, Technology
Linux Expert Center


