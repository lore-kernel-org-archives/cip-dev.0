Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2514C4332F
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 12:20:44 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.72])
 by mx.groups.io with SMTP id smtpd.web10.25820.1699618840187235946
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Nov 2023 04:20:40 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=NeRW6k9+;
 spf=pass (domain: siemens.com, ip: 40.107.249.72, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEOgnXAQ52ydMnW574+DWkUuedRAbx3h0AZZtWCKFBCC2lB/vkTyCddzknMEItSDKOWfGBBczPCUVyVaWGlvAtVL4WutgQIZusJaHQ/pqycXkw+qYTeI8cY+zHS1po52rfAK6ASZkmViObyFTNvX70Q/Aur7gDxaSvnXkEsGIigsz7WQcGhE2b4GOmKSQIDXo0agasruAQGPEbLMATLkIrKt1di6V064fckAmTun5XC3/62VUw+YH8U1m2CpviGN/NH0SXZu9ZdN+2Z1DhlRVWBXfIa4EoaotToXZC2i+eN4aMXJBYAvWsowfz7rwjh5D+t5/7SdE+HV6HRz7x/Jvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxMVCa3iVKGa9Ytepz7PL/nblinQerMiHsQSqDBzO4s=;
 b=lN3oyh9p16RFHaBYbfMvLIq4sFmAnq5AbRqWGtrLGGMR9Cpn6ovE2ao6G3T8HUVOQRFO5I9r3X/jCLE/2O0/P7f8cKF54gwxHSacNvXf5fS4If7w871jp+pgjHJmtKKs/WpTmFisSg3jWmO5uaHW9Wu4sQuNXrC3L2+J+6tDY6SLJk693n+8FBLMtOkowW2xEj3nKjNe4PpUTalYcatlOEBvrat0IN4OkWJkNJsbwVkPDIsAp30V3lQhpqs8HKD0aroOU3ofzPUkzrJBKA+f+nsixKhlBhv0CUJGUtAGpuGHArGDnaw7kBtICrkpCpdIm0qBxAxfZyXFFWOvDL0NLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxMVCa3iVKGa9Ytepz7PL/nblinQerMiHsQSqDBzO4s=;
 b=NeRW6k9+8LV6cqv7mrGVd02mUCfe+IVPRVIToro4X0bAIkGg4a4m5N5dHoLJsYMbNGO+t17q2EOxVT6inFUNnWSSLeUa7reGWEl1g4qcxJE/Rvh6X0xuJk3MhjozGzWnXGHMsNKfSHCM2Us7EjOnPMqbb9QTTDvcAyKCFveHc8trtFDXjRLp5FkQA1LRssWSYbLVGji4sjSen2UvQkt0EYBddySZE2U6fDfAEIBrgbAsJNDSm+BgjR7b6UuBC5gBrJaEFYspEpElnLMbbn1cOfiZ3rPVc57i2RN8IhdsLMSt1y0WFEV3K/pK7Tf5/9ILcEHmM4HlS9snmM/k37217w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB4PR10MB6237.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 12:20:37 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 12:20:37 +0000
Message-ID: <872409ca-683f-4730-a7d9-a6727e267856@siemens.com>
Date: Fri, 10 Nov 2023 13:20:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] added pcr_bank for clevis
Content-Language: en-US, de-DE
To: "Sari, Sercan (ADV D EU TR C&E)" <sari.sercan@siemens.com>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <DU0PR10MB6898A9738AF1110D653D5DE5F0A7A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
 <f1a52e61-3404-41df-85fc-7453be0d4be7@siemens.com>
 <588aaf59-facb-49db-bbfe-2c70c9866452@siemens.com>
 <05341db4-c9a1-40a6-8b48-21d32ee53dec@siemens.com>
 <DU0PR10MB689816B42CDADA5720DC10D1F0AFA@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <DU0PR10MB689816B42CDADA5720DC10D1F0AFA@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR18CA0060.namprd18.prod.outlook.com
 (2603:10b6:610:55::40) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB4PR10MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f81e81-f662-4a33-fb5c-08dbe1e771ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fy9Bhb5GGfQNaqaMm7M7XQu8bT6cgwOtP1N5lfQDC502MHFUr0Ve1Sod6/TrNRZzE7QiRrWz23hKWeEJm2WAXd+17HM/6F0vTgV6luHfgqHYDGXEEmYZiz28gTBSGCXT2AYTJoqxcDWbSAZOwy41NKJ2Ge9PluXONaA4t0iXoPRlXN5sGGlwIXdMohvPY7S/dtLssrFL1dhIPjeHsHqkaFO56H9EVwWqZXFOIFd18WlVd8RXFinwYXe7mNMCZQZp3WRwkCyVD4pEr+N86sww4QQCi502cxZNCJJya/OyPD8dw03rpRJgO3RoBAldVdXgO1dLF2oKfrnk2l9dLpeQgI7oZ7y2vCtVWg+XsmPaaED0ERTb6HVfQWjvrz0BLlh4myzZRDt98FlNt4+0Ej52ihyQEbPrrQQouK1l7U2ARYgYVeVWSBHTnvskjkJ0zzb7DbeFI6BfqJ9BfDGUDgAgBGaUHTBrWyzvQlo0WWBUE5RuqtQmflOltIDAXgEfMgw69A3HvKn4U/LxtxlANV+ew55ZZLCb/Swk883tjewr+1vFXpP1IXHuXVacyJbXt8Noy8PVUdl7oPSl8g+30EDq++Db7fyIpmJcpO236lgfsrRi3Y47BsBeWVJFqy13nYqrZscu40QOMZ7xLbn8YsWNgg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(316002)(82960400001)(2616005)(26005)(83380400001)(66946007)(6666004)(478600001)(6506007)(45080400002)(966005)(53546011)(6486002)(6512007)(5660300002)(66556008)(31696002)(41300700001)(36756003)(2906002)(4326008)(66574015)(8936002)(66476007)(110136005)(8676002)(38100700002)(86362001)(6636002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EUEzMFx9jyRx432Qua0PqgHtDRXxB3Jq11Es5G6F8UECleQE0CI6IpfH/i5A?=
 =?us-ascii?Q?5DKVMQNqNd8UeycJeB3Y/m++XGr9fs8pMk5X6fxgwWksNV1eCOFXmi4jy6bK?=
 =?us-ascii?Q?fRX9nZ37AaNjVBrU6xLYcsN90bNhI5bYv1deFqDStSjAv5N4TAzkxlHE6qtJ?=
 =?us-ascii?Q?Ar7cMltg/LJiQqpdWHWflmB76LdledgQLs3h3ZbKXyXFYQJdcD3bxLcJ5Rbv?=
 =?us-ascii?Q?Y08BSMytbc/NSq1zvAcZUWWyn8mZX/taLSYiJj/rNuN9FKDLrV9VjAlKYRX6?=
 =?us-ascii?Q?b2ufoIh/qbsjzy7YmatyT+/GPuzgZQVT7SJR+/oHGqAv3+zJXvkqF1t+xpZw?=
 =?us-ascii?Q?Dh9C4PGZJzHJbcJGXPHYszc8qB/L9SN+yyX4sD/U6sdnJoqU8VIw1qTY4UBw?=
 =?us-ascii?Q?qHE6sDdfjtc4XzNdcrAPvfR1YiFAMbu54HKXiRr4zjxaQlxvv8vv0sgMjqb6?=
 =?us-ascii?Q?ls7xHRls/BMflxQxIZCFbrbFY8ZfUFOaUUuCTNO3wlItvNENbpvlO7oFUE02?=
 =?us-ascii?Q?RycEHEW+d3y4qLlcYh/gqVqG2OUUDNLzyq5Ai7ZYun8uB1Sp+kqKgKdUSA2N?=
 =?us-ascii?Q?Uw/GTxQ4BPawE727CHUBhIhkdizEbiaXJ7w3uvHv2XPnzONA2LvozJj1nQwL?=
 =?us-ascii?Q?wTTjvqu/p2CEYAy7NrPqMjUQe9EAqQB/EpHhTUGZiaKn+mjbpZjGvR1Ecya/?=
 =?us-ascii?Q?R8y97Q4rAfyuZAPVwDVvUkZ7+kYcoBlSbETJMDtQjpaPZW4akxgiVoC3+83Q?=
 =?us-ascii?Q?8zl4+HA6QRNHyGOkLCm0OC2rTnRL4dW8ZXXW0+bjXUENjBVaiPslIYIBHMV3?=
 =?us-ascii?Q?zNkCqgsd2JPl3Jrm5jJAns7Sf7ZTNVglhYVScy6z1YIdLtoKFg8Inpn8uU6/?=
 =?us-ascii?Q?vUJQb3HfNwDN5UKEg3GQKKldqET4MTvRV1pZkPnZ6kUTgYkFNnfyCsyawyQV?=
 =?us-ascii?Q?IBAdF1wMlHcSiZJQua1UFAr4i8bDzqqvTBIPdPKAyXHV/7kp/zNeUwiXVwtW?=
 =?us-ascii?Q?RwHx0GkR+xfItDrIXj9W+2hHOrCkyc3YDFdYv6YrEragqyYoquyFeD0sy23z?=
 =?us-ascii?Q?Q+Z4D1T+Vo4fpMgM5z8MJnm3K2uDmWvs3z699gDJRVHG6R9jRHH61aIR2ak9?=
 =?us-ascii?Q?1/BN0BvKG0iOiMq0s9oHBzAgW6IggimqDoBdSGMiYAcw83cTevkV3XK99EyA?=
 =?us-ascii?Q?5CcojvJtxtxuaRBHOMaoGxkviQLtLag3dIArEZHxb6J5a+LmkJePH8lIv63P?=
 =?us-ascii?Q?EX8whth0to9dgXbkOHS/irFdFCWm6+QO+rISJ1qPg4xUHGoZv2A8IlMPkKlq?=
 =?us-ascii?Q?irKwey+5/ZGu1KRwzq7EBkBVYvlNN6ijvcEkiNuLGzVhGUH7IHflzxKYLTR6?=
 =?us-ascii?Q?rY9zP8NoDwPSgIPDtQ/uJhGcrSK0u3GjdJ+Hl7UtYDEHQpNV8baAIDnqSDM9?=
 =?us-ascii?Q?cB41bHYryNNR3JX7db8PT6GJlnVg1LdphYG2vFPlUjmJSn98lITkBR1fvLqQ?=
 =?us-ascii?Q?VdevdJPsteFeY2XKjMx+iM3yCFDHMjpdeehV+yu+TuKkucjyBIVxgcrypDsl?=
 =?us-ascii?Q?AIvzqkT/nwmgk90aIpqG8G24QHvhSYggyJMYgsl0PqIsvkhfWH8MI7HBtMuR?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f81e81-f662-4a33-fb5c-08dbe1e771ee
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 12:20:36.9551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyAAlIjFeY5av+wJmZDHxpLdHBP9OHgEbbPIXEAH+MjuBgEAGZUIbUhbt5Izl1qeOPiraOSlAur5n8CMTX2CeQVSQAwB5Qv7Vzrk+Fyhcxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6237
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Nov 2023 12:20:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13567

If I look at the official documentation of Microsoft. It looks like=20
there is a possiblity :-(.
```
Windows checks which PCR banks are active and supported by the BIOS.=20
Windows also checks if the measured boot log supports measurements for=20
all active PCR banks. Windows will prefer the use of the SHA-256 bank=20
for measurements and will fall back to SHA1 PCR bank if one of the=20
pre-conditions isn't met.
```


https://learn.microsoft.com/en/windows/security/hardware-security/tpm/switc=
h-pcr-banks-on-tpm-2-0-devices

Also there are the SHA384 banks.

Quirin

On 11/9/23 13:26, Sari, Sercan (ADV D EU TR C&E) wrote:
> Is there a possibility to have a TPM 2.0 with pcr_bank: sha256 unavailabl=
e? I don't understand the exact reason why it should be configurable?
>=20
> -----Original Message-----
> From: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
> Sent: 9 Kas=C4=B1m 2023 Per=C5=9Fembe 14:24
> To: Sari, Sercan (ADV D EU TR C&E) <sari.sercan@siemens.com>
> Cc: Gylstorff, Quirin (T CED SES-DE) <quirin.gylstorff@siemens.com>; cip-=
dev@lists.cip-project.org
> Subject: Re: [isar-cip-core][PATCH] added pcr_bank for clevis
>=20
> On 02.11.23 09:08, Gylstorff Quirin wrote:
>>
>>
>> On 11/2/23 07:10, Jan Kiszka wrote:
>>> On 01.11.23 18:17, Sari, Sercan (ADV D EU TR C&E) wrote:
>>>>
>>>> clevis will fail to encrypt data when the TPM has multiple banks,
>>>> such as SHA1 and SHA256, adding the pcr_bank information resolves
>>>> this issue.
>>>>
>>>> Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
>>>> ---
>>>>  =C2=A0 .../initramfs-crypt-hook/files/encrypt_partition.clevis.script=
=C2=A0 |
>>>> 2 +-
>>>>  =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git
>>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.cle
>>>> vis.script
>>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.cle
>>>> vis.script
>>>> index 899f20e..957a3fd 100644
>>>> ---
>>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.cle
>>>> vis.script
>>>> +++
>>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.cle
>>>> vis.script @@ -61,7 +61,7 @@ open_tpm2_partition() {
>>>>  =C2=A0 =C2=A0 enroll_tpm2_token() {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -x /usr/bin/clevis ]; then
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clevis luks bind -d =
"$1" tpm2 '{"pcr_ids":"7"}' < "$2"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clevis luks bind -d "$1" t=
pm2 '{"pcr_bank":"sha256",
>>>> "pcr_ids":"7"}' < "$2"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic "clevis =
not available cannot enroll tpm2 key!"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>
>>> Is sha265 the only reasonable setting here? Just asking as we are
>>> hard-coding.
>>>
>>> Quirin, any remarks?
>>
>> I would make it configurable. clevice supports SHA1(default) and SHA256.
>> Quirin
>>
>=20
> Some follow-up already scheduled, Sercan?
>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Linux Expert Center
>=20

