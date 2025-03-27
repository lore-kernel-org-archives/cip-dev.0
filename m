Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0526C36011
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 16:27:57 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.49])
 by mx.groups.io with SMTP id smtpd.web11.704.1743092872120643365
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Mar 2025 09:27:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=N4GFfhii;
 spf=pass (domain: siemens.com, ip: 40.107.20.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rl8AMImpmR42n+tkna9Vu9S7mu1g1d5sHsbJoY4gNjYIFymTn2Pf0rW0XpltN3rdom9fZ3+lb2T7OX8IErYwjN9NUuuYzx/N+pDODemYoJgdmjOGOzDfU0aDJ/FvC11ygagvClsrAyem6439kw6KTJRu6uKUOHJwb7/U3vXdhwg0A93f8wkp8fu0OWO2IYJg1NI6lHPY6heKj/FqYG2t9vqJ57kRj6yrqaC59nvalFHiiPIgoP7VGVg089reNkpr172gfqBflIYZ8qygsnRm0vnE3K+0hRTXd224sTfowbGCM5TuG4TzHMYTCD4hdSpxKqdDJinHeSPAIxxQ/XQhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daFAlvUK4SgIMwzWMACVSZBPO3+s7xuHzX3bfiT0tC8=;
 b=d6P4zjI3iDPReDrRgg2iNmhFHTK/zJErxDJoncu/7D9o/f4N99JJVjUNP4sjBv6MLPeoKgZQx6jbHmqX3LH7hvd0JnuctVK+nrEkQMjx9wxS+pt32d0OaesVb/3TwR3GaOE/NAFfpKlAu+JsYAxI953uMkJKyCkgvCcUQBTrmjoVOlDm5yEzrQR7lBSVI28tID8MAmo/P/YHVogCDN2OwJECK4Osmht0BuZH3w9ISnkNmlMqWuen92Rwv0LDYLVjbQ9caPKnGU0/fjQ062X6v1RMp4XPwuil9IM9rLY2YDL9LWQ+Of4x1DDBNTN6DoIBA+S2tWOZ3bl1Nb2pidg8Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daFAlvUK4SgIMwzWMACVSZBPO3+s7xuHzX3bfiT0tC8=;
 b=N4GFfhiiQC5PMxZiS4JvK9Io6cwJW+mNZvDB+5QEHUyXfsjCEZBTkfigfHl4P+X9AaH1LEAEfFER0dBlAWLFkVjtmsgbAee5/AKkMF1b3hF7bcl4jsJmsERb/1BlvFSkudYTujtNcxUbqMbMGqaNRGLRYnIWHAwDvmZfN5fSecxY2YXepk5A323kab6Q0Nj0V3H2jTHozByy5Wr4pwBbN8M5Y0NOJ7E6XW/NM4OD5j9ervgHamvnq1J+PFgWC4Q2YAkFjUIVIBM2yvhSrAoAupVQrp0pm5Rpsr/YBMLrptNFKG2BHDfYwcN5ABdNGoAqwG1zBhS/6GDKxzp0qh5/cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8386.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 16:27:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 16:27:49 +0000
Message-ID: <c7b75f1c-7ed0-4375-bef7-29347a3613e1@siemens.com>
Date: Thu, 27 Mar 2025 17:27:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] IEC_template.yml: Update IEC tests to latest
 revision
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250327093358.3419546-1-Sai.Sathujoda@toshiba-tsip.com>
 <f04f10cb-7df9-4308-9cd1-b77e6bb6ce7b@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <f04f10cb-7df9-4308-9cd1-b77e6bb6ce7b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8386:EE_
X-MS-Office365-Filtering-Correlation-Id: db9fc989-abb0-4401-c7f7-08dd6d4c5052
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?emlJMDNVcjFUM1N6STBDZm5tczN3dmhDNW5YRk9YNmExNmFDcDBHR0ppTzRW?=
 =?utf-8?B?blYrUWxZQ281aE44bkp1ZE9Xd2NHeGtGRzBwQXZWbTFiMVNtTktycmExRWJF?=
 =?utf-8?B?L0REMUxKNnEwbllKL3pxWjJydnRpU1E1Q2ZqNnVGa0ZWeG5rc2QxaVVzUU83?=
 =?utf-8?B?bnY0N1R0ejE3bTcvc1N4cFZ6bzNXSFFGRTB2dmg3WFRneXdUTnpQMXBkcW9L?=
 =?utf-8?B?Z2FQRnphM2hZVzQrRHRxOTJTUVgyMzJsMWh6NEdCRHhTSURRRGtlM20vWS9q?=
 =?utf-8?B?Wm1WZ1BHY1FkbDUxcFFTVDBiUE00UUVMQ1JWd2FaQnVtR1c0UElrVHN5Y1VZ?=
 =?utf-8?B?anY1SUU4a3BIc0pEMHNKMDRCK0hBaXIrQnQ4b0VxT3NKZVpJOXVEYlZkMGZs?=
 =?utf-8?B?MVJPVlNHVFVPT0tOUnZRVkJ1ZE5sZ2VhR0dDb2FJWkZ0ckl5L2JEcEVtdWE3?=
 =?utf-8?B?RXBKMW16TGU5akJPekNvUXkwdHRnZlFiVFVUQkFwZ2pvTDRFUXNPdkMzNHRu?=
 =?utf-8?B?cGJHbUhPV1hzZWRUeGN5aHpBQmpMMzJrckpnN2hTYU1aTnZ6RllSSnNVZnpQ?=
 =?utf-8?B?M09Kcyt1QUJLMVZ5MGZHS1ErWnY1MzZ5S3VVVWM0M2pucUd4Yit6YUM4bXlW?=
 =?utf-8?B?OXBBNU15d096eC9wQ2dnRmkyZE9UZUpGejFpNVQ1aFlYbndSWkF2ektQVk5N?=
 =?utf-8?B?S1B2a2ZYSWEyT2FrcUoxS2VQZFZVdHFoYkYreWRIOTk5VTVPcE1CQy9hMFBD?=
 =?utf-8?B?dkNhMXdqRWJYKzJSUEdnRHdDbm9uNW1tYzlGaUpGRTdzTDhEWmxLY01NdG11?=
 =?utf-8?B?TEErMTVSSVJqQU90Y2VtYzRDd2U5SjFHNWZINVdwaDM5SlI4Q0hLQXZray9i?=
 =?utf-8?B?dDRzaWdNUjlwREgreFhnMGZFWHAvSklaT0d4bEVIV3UzWnlLckJuSkRJZmtN?=
 =?utf-8?B?c1dxbWFqN3dvdUIwdHlDTTRwMUpleDlaVnBFVjE3Zk9kd1F4ODRsQURyRXhk?=
 =?utf-8?B?QnplMXVneDQ4c0NrdG5xdEFUeE5jaWRBL2Q0NkNOKzdDbEk0VFVHY2JuNytw?=
 =?utf-8?B?TldNQkxveTNUZUwwWGVPZ2F2TEpUVHRpdE1CNFZ6RThxVGNMeVpYZkhJam5P?=
 =?utf-8?B?b3pEODZwRGZnZ2luckJIZ0JVd0xHNm52ZzZUZkQwYWp4dHBMZXROU3JpQnhx?=
 =?utf-8?B?aklPcTI2c05iRWhUaWJBa2JlQUJtOGp2QklyZU5wT2xzNFNNY3BjaDBvM2ZC?=
 =?utf-8?B?aXRmVW4vaTFwWEZxRHpRbEtZcmQrNVRuVjlEbUU3QXBVNlp1OXRUdmJIWHFk?=
 =?utf-8?B?YVZod2VzNkJiYlV6SWhrMkJWTE1aTGZ5ZlN4dEM0Ty84TFJUVjNaMy9CMkEy?=
 =?utf-8?B?ZFdyNEowZml3VSsySFJ1aXdaN1JOV3dUL1FxUkhtNDM5MzZ1WmdjTlBKdTl2?=
 =?utf-8?B?eExhWEU0SXVzNTQ0L2pDSDFqR0tZZUMwUXdobTVacUZubjMreGxLNHZ5NHFV?=
 =?utf-8?B?ODJKcFNMZzB6S3N2MWNsS242NHdpUjUvZEROTUJoWFhUQmlyaUdXR2dNbllY?=
 =?utf-8?B?N013QUZSMjVhTjFtRGlKcnp4aTFOWmtpNTJIdHZ0eUJOZWZsSVJ1S1ZLa1FC?=
 =?utf-8?B?TE04VkFaYS9ZQ1BuY0E4UzVvTDdyM1ZhOUtpK3VLZjh4Sy9OVnN4RXI0bXZT?=
 =?utf-8?B?alhnUlgvcGV2K1hiek45ZSt5amdWL0IySWpsNko2Mk4wNVBFaE5zNFVtbXRR?=
 =?utf-8?B?ODloajhISVpVNXFLbzdlMlpvNXcyeEJ1UjJjY2xvMUJUNmFqcUlnOUZvOTB4?=
 =?utf-8?B?NEtCSi8vd0t4c3ZOY1VLUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MUUvc2svWWFlbnlhUm42aEJDbHBMRTYxYTVsRXBUUDlPUHQ3aUtUVXNTYm1h?=
 =?utf-8?B?NGdNVFBuaDlXa1J1UkJ5UUs3WU5JbnpONGxoNi9nOWlIcXN1ZmJPdFNWWHZh?=
 =?utf-8?B?aDRSM2hHYUdIeVIrTDlWQ2dWVGpPUlViV2ZqWXFxaTdacHJ4Nm9IaGx5R2tL?=
 =?utf-8?B?Q0VSWDNGc3VHZnI0WnJsbHlJZE9ZMEVuQ2VaQktIYllxeTlIMWVjUUMyZDE2?=
 =?utf-8?B?Vm9IKzMxVTNpMHdvSTh5RDM2MnVUb3F4dWxjbTVHT1VLcHVmWU9EN2ZCS1hL?=
 =?utf-8?B?MUlqRXZ2cGlDKzVWWloxTUFnczJqcG5ud0dSRGxCYWN1NVpwR2tROUsweFAw?=
 =?utf-8?B?VjJQdERhcVdmai85cnJQUFFjcjJSMk91VUkvcUxtMFdvMkllT3lJWlFXL2Iv?=
 =?utf-8?B?dEl3UDNJYmNQMktaaTJZVWhRTnR4VEVtVDlod1VPdkhvSTNRQ2dtemVIdzNN?=
 =?utf-8?B?bTNBNE9sTVR5MGg5c2ZKUkQ1S1ZZUkp6SlNuNjRGaHFMREI2K3BveU1WRUNM?=
 =?utf-8?B?VE9uRmdHSFM3UkZ4WSszR0lMNTEzZGp6TmpCcFJOWW05aisvMHM0ZHdXMFFQ?=
 =?utf-8?B?Q1NjbE1TUC9YVHdjY25WajA3MDhqdnQwV3poeFY2U01BNFpuL0hOVWNiTHMr?=
 =?utf-8?B?RGlZcFhZQVF0MlVac0JJTnFSMyt2WUprSUNvclZRYWZ4N2JFMU43enlvUkJo?=
 =?utf-8?B?UlR1TGZUVTI2Z0ppaDBkR3pXZWpvRXVnN2wwNkFFejRHc2xObmo1alhMM3Z2?=
 =?utf-8?B?MnUvQ0o1VXUvOHlZd3hpd1p3dlRaTWt3QjAvY1VXOVNHN1ZCRWRTSkxWTXpB?=
 =?utf-8?B?d0JQL3pnY3dmeHVDNnBOdE1NTWRrdHFkL0R1aFBnalVLelBzVlJwbEhJZzRX?=
 =?utf-8?B?UzhWKzRoMXlQMHRzRU1PUGtmOHBqNEYwcVpCdFN3UWcyVzBJd25SVytST1pO?=
 =?utf-8?B?UjJRdmkxYjNYNVJMa3FBTXhySGFVNlE0WGFuT2dsNFg0bFpSQ0ZQU3pZSko0?=
 =?utf-8?B?V0hGZXhxUHk5VWpHQjZIcjQ2UVAxVW5KR212bi9kVit1enRaOCtoaWQ1Ympt?=
 =?utf-8?B?SVhIenAwYVdpOHZHdmdGM1E2SElNVk92dUs2UFdnQlc1WkZnbUxDNFR0V084?=
 =?utf-8?B?R1lySHZ0TGsyUll1RHRoSHpDRjhuNXg1UkZSclIzWEdKbk05TU5tVWxIM0x2?=
 =?utf-8?B?T0E2R0NCbXFqWjhwZC9mVlRCaFd3c3RrMjdjbURqMnIvc05VVTNHcW0zV0Ny?=
 =?utf-8?B?YUJiK0xkN1hSb01USnM2Y21NR1NBMjJMVzFWaWJOQVplUTMvek4wbFJLR1Rl?=
 =?utf-8?B?bjArZ1ZCUUhnWGd2TWRwTkhwcVJYanB6WjUzdnd3NlJtRGZydmNuc2RkVDIr?=
 =?utf-8?B?bGx4VjZ4NEtrVFZHQ0lqVU56cjBxQUVnT3ZUUUFyb0Zpdm56MmNDL1VhSTlw?=
 =?utf-8?B?SkRTUUJlOVZsMEFtOVo5dFkydXk0RUIwdXZpSUNjL1VYeGxkQ0FHQWU0Q1pW?=
 =?utf-8?B?TlU0SlZzbnoxKzBlOEhPTTdmWjRPSFI2UHpFcFR2aDJBVUJVRURKYVpJY05J?=
 =?utf-8?B?MXBSU1hQT20yMVJXUHgyWUtWVGdvWitoSHpUbW12MDNCeUNzZ3dIMVN0OXRv?=
 =?utf-8?B?dFMxL25YaFdYV28yVFBFbXB2a2ZldGtnMXRFRHROVkI3dUh5REhkSjVJazl5?=
 =?utf-8?B?Rk5LRkxmWFpETmFpazJHbDdadllrVGd4YTBIVEllTUdDNzB6V1AyUHprNTJS?=
 =?utf-8?B?dHh6dmNBNnNHZDAvSkRiWEtNT0NwUWh5amxoWlRmQ1VZQUxrYXEzVHgySUFu?=
 =?utf-8?B?ejBJTnJ6cWJUSkxOYTRjMkJnZU5WZHNnVTdTYTEyMHREWnVqQWVvbDhrVmxm?=
 =?utf-8?B?ZzZNZzdZZUJuWlFHTndHMkp3ejduanVPb3Q0Mkx3SFRacEFxUVgvQlBzWDI4?=
 =?utf-8?B?TWVta0xIUHZUNjVpcmQ0dmorcUVPcmpoMUZXY1lHRGF4R3plT0xESjQ4b282?=
 =?utf-8?B?NGg1ejBQL3NrSjBHQlRaSG1UcklHUE9nZDhEOU9tZjg1UFVDZFFmR3N6b3Jr?=
 =?utf-8?B?K0RiVVREL0wra0ZxOVcwSnFSZ01PWld5QnI5VWtrbTVWK0U1MTkxWXdxNzFW?=
 =?utf-8?B?aXM4b3Y5Rktzc2lOdENvQmVJNW5XcURoRTQ0c2tUdDd2c1FadUVNMWc0bjRa?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9fc989-abb0-4401-c7f7-08dd6d4c5052
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 16:27:49.0905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Up5FhGLyNEZcMRzKlVMv7VyJ9h6OTXMrHCEfyTsuYq9SLMEchaETsNs+BEKuCqSkEj1GqZpw7sak19J/ohXFbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8386
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Mar 2025 16:27:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18380

On 27.03.25 12:32, Jan Kiszka wrote:
> On 27.03.25 10:33, Sai.Sathujoda@toshiba-tsip.com wrote:
>> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>
>> Major changes in this revision update:
>>
>> 1. Skip TC_CR2.7_1 until it is redesigned to remove dependencies on static time delays.
>> 2. Improve tests to include testing of new IEC-62443-4-2 sub-requirements.
>> 3. Fail the job if any failed test cases are found in final summary.
>>
>> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>> ---
>>  tests/templates/IEC_template.yml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
>> index 3c33773..92944da 100644
>> --- a/tests/templates/IEC_template.yml
>> +++ b/tests/templates/IEC_template.yml
>> @@ -64,7 +64,7 @@ actions:
>>       definitions:
>>       - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
>>         from: git
>> -       revision: 064a92b98127b0001ca527a83b175521bea4b626
>> +       revision: 5dbc47f55d4a43449dcbde4363e5d23d6e96344f
>>         path: iec-security-tests/Singlenode-TestDefinition.yaml
>>         name: Security-Testcases
>>  
> 
> Thanks, applied. Let's watch the pipeline:
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/1738025966
> :)

2025-03-27T15:03:09 INFO: user: 'user3' created successfully
2025-03-27T15:03:09 
2025-03-27T15:03:09 runTest: TC_CR1.9_5: Strength of public key-based authentication - map authenticated identity to a user
2025-03-27T15:04:46 Marking unfinished test run as failed

Please have a look.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

