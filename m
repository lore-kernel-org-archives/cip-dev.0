Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA4DC54E67
	for <webhook@archiver.kernel.org>; Fri, 15 Mar 2024 16:22:32 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.54])
 by mx.groups.io with SMTP id smtpd.web11.211.1710519741764729386
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Mar 2024 09:22:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aM9Q/A6r;
 spf=pass (domain: siemens.com, ip: 40.107.7.54, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6jk/R8zftaGBawbgBay/JiMerlXezxNsSN+h8xaUsJcFQyJueIfAJKnr/n8uvG6d08HS7rIKoRjYYP2/BjkaOwi/JeFckidYOJ2XNpBHXFULQwS7wNiJebPre4KfxIrlLWy88Yu3xZLm2hJdS3fT39Emk3pH5jMtce4hYMwKkNJnsrzbrOyuqg8tCm7tPYdKIYSHeGJQpuebjTOzcQpSjr7rZswOr212xfvmO6WW3a0BVKsTGmdOzFNQEG77FUOAkg/yuDaLSgyQsPxTm1OJN10VtZ/Ceqz8XnXwujU/KTEL1lnyUhdtVLhmF+OqnE3KF4tmRi/24zp10NzhruhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5PCE6U6OkEKJ5OTJp7GMJvpEkjZUlkV4UPTzALkthk=;
 b=IquHvAsLv2juYJ1DUD45i4a6D9PjyauFxHfZMV38pwpuvmTDhjVhTWlLT0nNggeNe4pZhHfPTilKY5/ZgJFszXLV0v6W4eHhpc2b10Z7if/WHc0RQkiLhNL1g4nggaFE1kY+ts9FpmIxyelyxSDzDReCyVtPT8y2zFrq7QMUKScKWme5z+nem70pOUjSZfC0d+tXb321NauLSTumCB+waBQVu3pgFc4vYMI5ti1fCldSfoM/jxraY3afEgICe68umYGkYlrPLropDN1g3wVpaMQfoYsPGxkCuHU8dePX6GvuT36EeiftOvHjwW+Jt970y3aqGn1/6NS0iXcw8ptHag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5PCE6U6OkEKJ5OTJp7GMJvpEkjZUlkV4UPTzALkthk=;
 b=aM9Q/A6rQIBd56guDEPhyhESnBIB2rWbKPUuIfWkqnAPURCMZIz91MKGY1nOhq2IuCoBtwzdSVk/YkhiTjZXDgLVwXdsF83T1XUkxqXa7m4f5cdItNC13iZKJJLGPYag1gQh7OTnwRuXtsnnzqaZkfB7+/UnxeTvd5RYTB8H6r/5Dav6mGQrpMuJMBl3MTCL67/kVvEkQyIs5hqqZQlsVhZM3Qcwyts07cJIGKrdISANhQwSQWjcAeycE6b8AyUWDgAO+jD1+FPvkhIt2NErwDkSuWr33NpH5l3byjFOARD9t9ABxKAZw7JgfZ8CAwA64UE6ej1K3xMnH3sZ0tSbXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI1PR10MB8205.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Fri, 15 Mar
 2024 16:22:17 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 16:22:17 +0000
Message-ID: <d18ce6d7-5375-44ac-a00d-2c30e6673733@siemens.com>
Date: Fri, 15 Mar 2024 17:22:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][isar-cip-core] recipes-initramfs/initramfs-crypt-hook:
 remove unwanted directory
To: Jan Kiszka <jan.kiszka@siemens.com>, srinuvasan.a@siemens.com,
 cip-dev@lists.cip-project.org
References: <20240315095246.275065-1-srinuvasan.a@siemens.com>
 <115947c5-1b60-419f-9e4f-f4a7ba504263@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <115947c5-1b60-419f-9e4f-f4a7ba504263@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::9) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI1PR10MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2161c5-220e-442d-3c4d-08dc450c1508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WsIwOzufgvdwhOwTw7s7yQ4E1OtNAcKR4aMOwvBH/AbTeCOfyvvEdKyztU3unep05xeqRVaJqWfmpVrJx6th3U8bdDhEFakU8HFIuLtN184XVc0lfb3mbcj6oiNbe7mk3K5lrLDF5AvPCbvDRXShum3tNZ7AX1zW8jLMgVsdiVNsb2EcKC6/gvk5O7ORXiC3T/VVdntlmC4O/9xi89tlvkyRdwt5ovYC+H+yfIBIBXF4ZVm6A3L08hkg2w/1S9g9jZ3tbFhsAtMxpin8rxOewX+oo/rUMm2TnZY+XDfYQi1Q9gHoyk9uUnMM3uFeuM6wLFJQK6A9n0L6d18H1DHwrN0TsyMTqGHhGE/vV9MmOgGSwKP0Mp0bQ3nANO2cKCSPISkSf9MKBVmcak2FsWaPkQObtOkKVrrxQmAvkjLmn9Lqewt7nsJ5CfHBtDBZM/Qe21K1ZdtFXXDeSW39weueDK8kjP5Y2tS0KJQ+aK4hDKuTUMTCyb97ZR2OGBF9dsHU4Thh0jto8ZreKIAQfSPx1pAHNIVCV2otT7FQ7nXVkyQrmui1ETmm7VzhJUEpHs9HBUclLWaksDyGESZ/v4pj74a+kFSopND8Y1moRzy0kvZb3Qf5ptbALs48m0Ktho8++kJQzIwB5ON2fetzK1UpQYQ2LNZObWvu5z/0kIQGVNY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T0Z1azBvam5lT3NCV2x1VG5rYWhCb1YzU2FEdFFYSVdSeXZUTkl4bVRXL3lI?=
 =?utf-8?B?Q2JhMlNhbHIwdlZQVXNudXdsYkFqUkRkNjR0d2dVQ3o2K3Jnd2pOWGsxNHF6?=
 =?utf-8?B?RjE0VHVLNGd4Q1d1Z3VhbUMyZVZNUTdZalNhdFpHQnVQSjBaR1lQMjNUU3Y1?=
 =?utf-8?B?NDVFYnRGdkk2THpHdVhVRE9lRzJvZ216RTl3bFJ4NUU5L0liWjRUU1h6K0Jl?=
 =?utf-8?B?TzRxNVIyRVBvd1F6U2pjVmhjZms0cU54Tmw4VHpNRHRpZjVjcGZyLzN0bUpP?=
 =?utf-8?B?YWs0UStsT3d5YlFhUUdnSXduVTc1R2lmcWhVeWFTMHAzY2RCYjZHeEJyeDJh?=
 =?utf-8?B?Nll3em9JTjdDT2x6QldOcXB4MXlFZlY2USs0dzBoRSsvZStOSE9jZlQvYU93?=
 =?utf-8?B?VzVLd2o1YklVM2NGMVBPWDJ3QWVUeGNvZm1JSjVNaFYvNGZPWUpMaERmaTUx?=
 =?utf-8?B?a09nQnZSb0FyQjFMV1RlT0lCbkxoWDhoZzBNZ0dWN21sVkpkaTFpMndZYWk2?=
 =?utf-8?B?YTRNaCtuaTBhaFlLSjZEU0RTdHhiT2hUbmZ6TTh4VUJxQjRWRk1rTmlLWUxh?=
 =?utf-8?B?azRHVy9ndFBWZTRkTkVzSHFycHhnOTErYklXTEhqZ0Z4TzFlTG1NWlJwSVZk?=
 =?utf-8?B?RUFwK1hUN2hzLzhvcWNVSkNhZ1hXRzlDSjZMNjJ0NytzTHRoT0J0bmxOZm5F?=
 =?utf-8?B?dFEwNUJ0MDh5SS93OXBvdnNGUStmTkVKbVduMFhoaGtGTDdYR0VMbnd3UWNC?=
 =?utf-8?B?WDBUMENKRXQrSURlb1NGeDc5RE95TVZ5aFpBMHlqcjJoNk43bDJkbHA3WGY2?=
 =?utf-8?B?WEFSdE1wM1o5RlgyNnk3NEZ5ZUZ4TTZkaXRVTEpWRmFxZ1U4Ull6cnlKL0Fx?=
 =?utf-8?B?Wk5jOCthMEg1YVZQS3VrSEtCS1h0TnF4NzJLVDN2V0FhaS9MZ3JvQWdHekw5?=
 =?utf-8?B?YVBxaUlhQ2dMSkR1eldZVksyRVB5cUh2Y3poY2xDeG1ialZKWkUxMnZXblZm?=
 =?utf-8?B?bk54Skt5d2xGb1MzRzZBWHB1R0M2S0JGZVBNbldEWmEwSndRWnpPN0JvV3pQ?=
 =?utf-8?B?K0RMalMzMUVnWDFRK1loZVpwVytwWEE3VWpqbHRyVVJwK2dzMkRRbDdweHlK?=
 =?utf-8?B?RVZKQVdWWk5FczU0blV2Y1NKZHk4L3JwUS9IcUNkdHNiekkvOU5tZGl2LzBV?=
 =?utf-8?B?NE5TaUNlV3Z0SmU3Q1JoZnQ4K2JldTk5dldEYmxodktWWnIxaFZaT3dsQVlJ?=
 =?utf-8?B?QTBnOUJ6Si9Pa0x0UkQzMzJnNTVGbW9DNzgvbHVwYXJlQzJUM2d6OUxlbU1q?=
 =?utf-8?B?aUl6KzBtcTE4TUw1ZWdQZHF1RnVGeVlXN2ErdjlmSXJVMUVkTFRUeTVsSDg3?=
 =?utf-8?B?T3h2K1puVUZQNStKR1BwbHF4bHpFL2xWL3ZlT2xidUlWSWNPRWpmdlJsaWxo?=
 =?utf-8?B?dUQ4M2d4SFlYOC80MC9FT280Z2RKcHU0dlBxYjk4eXdLek5hMkVRcERkRklr?=
 =?utf-8?B?STBSaktqUTUxczBFc2tNVm02Y1p3aHVnOTZ3bkJLNGdrRHdUR3Z5ODlMMVNr?=
 =?utf-8?B?RjVrOGJJdjJTcWZ2Q3B5c1lyenpjVjJIU2MwVGJkUTBMVXlwa2JCMXU0R1lN?=
 =?utf-8?B?NkkzQmlzOXZZc3MzZVN6aTU0Z2lVbnhERTVGR3lXRkZZdjJRR0VORWtZcmZ5?=
 =?utf-8?B?bVNmOVJrUWowMVNDTUQ3T1BLVHRSdmNGa1lsek1XekxCcUYzT0JPZm9vOEp0?=
 =?utf-8?B?THFXbkp0Vjh3bXFGYUdWcVlHS05ORVdnakJkTXkvMVdxWjZUUXVCdUxrckpz?=
 =?utf-8?B?SUluUlErdi95THYxeHBTdDRESVFCd0JmRGtzSXJYY2dFcXBtOVlCSFRvd0Za?=
 =?utf-8?B?L0JMZys0U1B1aHlLT0ZjWmFGeFNKV0gydWJNeVdvYUFYc1pXWjJQQkZPdWZh?=
 =?utf-8?B?VTM5cGRzQXY5ZFd5blJKYWxodHY5TTRzby9kTXJJeE5xTzkxRnYrT2JKQ0Z4?=
 =?utf-8?B?bGk3cjdaRzB1YVZTanByRWZnZEJRUTQ3N3VLUktNNC9wVFh4NVNJZldIbXFW?=
 =?utf-8?B?S3k5blRFS3pqWU5FNndheVZJbnlJek1zeG4xQkJiL2pERFBOMXFkNW9EcnBV?=
 =?utf-8?B?M3FiMVpUdkRhcHg4YjJtam9KL3dZVFVva2I1Sm5ZRmdiQTFZQVNSU0c1Y3BR?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2161c5-220e-442d-3c4d-08dc450c1508
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 16:22:17.6233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyc8VqmT5HBtAIRuFsI9NDAKM2po7FIq9el/z34oIm8KcJ1AyYFe4KWsqZvTNPWuc0HjO/1pAyorcVF2Dp7lHuOnMK5AzpCz/Wyq0DSv+So=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8205
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Mar 2024 16:22:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15327



On 3/15/24 11:00 AM, Jan Kiszka wrote:
> On 15.03.24 10:52, srinuvasan.a@siemens.com wrote:
>> From: Srinuvasan A <srinuvasan.a@siemens.com>
>>
>> We are not installing any file under "${D}/usr/lib/encrypt_partition",
>> hence removed from the do_install[cleandirs] part.
>>
>> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
>> ---
>>   .../initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb          | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>> index 3b2e6fa..b275c0f 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>> @@ -48,8 +48,8 @@ TEMPLATE_FILES = "encrypt_partition.env.tmpl"
>>   do_install[cleandirs] += " \
>>       ${D}/usr/share/initramfs-tools/hooks \
>>       ${D}/usr/share/encrypt_partition \
>> -    ${D}/usr/share/initramfs-tools/scripts/local-bottom \
>> -    ${D}/usr/lib/encrypt_partition"
>> +    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
>> +
>>   do_install() {
>>       install -m 0600 "${WORKDIR}/encrypt_partition.env" "${D}/usr/share/encrypt_partition/encrypt_partition.env"
>>       install -m 0755 "${WORKDIR}/encrypt_partition.${CRYPT_BACKEND}.script" \
> 
> This dates back to 98974a68ab9b644830be7f1325df9a22acd78cd3 - Quirin?

It can be removed - it is an development artifact.
Thanks,

Quirin
> 
> Jan
> 

