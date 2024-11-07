Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D517BD43359
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 12:33:34 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.86])
 by mx.groups.io with SMTP id smtpd.web10.70851.1730982805894932322
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 04:33:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KCM6gLNt;
 spf=pass (domain: siemens.com, ip: 40.107.22.86, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sze29coa5Q/97U3DaYevl8Ba6puln1lPUKuSbWFelr8Yp64DTQsNv0KOWBZzHayJWgFtbJX97fKv6THQltr9dxc13JfDIQu1goUYyqvNUFNAkquJ+zDUttXwSLCylGValQLJqf3FIpVptUsNzV3YRRdRexYx9Y1ZRHprw7E/TFoiy37nKqpdyyVsJt2hqSmr5uW2aucslZoNQDgsx3zjC2bh44Cg+7OQOHoe7PjzTaYHm62DeEA9jncubg/oCvA9DNN1LoenkEktw4j2zQvidVxb5GXF7/CTqil9S+YEU1BiP1j6FsWEM04Tsqc/HQVp1jWg9al1fax8DJ7NVdtaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwA01Jh9ZOe3L1Ablwzt2wd+i0dQHkinnsDCwd6TEPc=;
 b=Wh+i2M8+gqHlp1rPGRHZ+RbiVW1AFWrGb+wnND4OZpadvdxs1Sc+8UwcfSQZBJB3DKsuhQ8clRiRBqAthytuS7lwTDDyoX+g+7olGjLu+qbYJc3a76hr0Dw3flmzUq9dUznwMJcqvR6ovP6u8YCcjxe9TXFaWM7OrKCkDrdrGP4h5JHxkXUxAAIWokC5TIQNDyka1q62zlbfFTDEqyEaTuUGPSE8qMHtrrBNm1e3jmESmJS+Kxk4juDdbFRuDlnDWBJkOO7j70BqAySbyV7DvCocS8VD7l1MJ/fA/wrtGB1zdtcmYNCh9mgF55ZeTDkN9/eAsual7vGavf5X1uJ5YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwA01Jh9ZOe3L1Ablwzt2wd+i0dQHkinnsDCwd6TEPc=;
 b=KCM6gLNt6ydKOtIP+ibRNoHUjTOWLHzTPC4nSm+6iTIUt1atFr62JXhVPjZY/8RC+xJcBoNUvxh0hPWi2BL2rlc9O2CJv3/3OoQ2yGAnVL7OuBv0Cag6qpRZXQQDjFkOg22HEEhkVTrOrwEAB8wKQacuMfMbLCt7eR6Am07oTK11nNMfR7ScSHCj3jZWKMfKCr1bVoA8OdSKbIVskDPPsm7UC3PN3zLPZ1qjT6nkY+7NPJxcT7TURVVHirfKQDQgKa9MutJdguMymDOb5lp4FaGhNVR87/Uv8ZKIvnVZ16znnRiJkY38hn/o2o8ey7wUCAgKg5n75QTh/H3TMIc+ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAWPR10MB7367.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17; Thu, 7 Nov
 2024 12:33:21 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8137.014; Thu, 7 Nov 2024
 12:33:21 +0000
Message-ID: <244a95ad-fcdc-4ec7-b3e4-bf5e6e5bcb49@siemens.com>
Date: Thu, 7 Nov 2024 13:33:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 2/9] swupdate: Control self-building via
 boolean var
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Cc: Cedric Hombourger <cedric.hombourger@siemens.com>,
 Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
References: <cover.1730977077.git.jan.kiszka@siemens.com>
 <c6ab307ddf903298d2fe23ad93b1e6a251ecc6b1.1730977077.git.jan.kiszka@siemens.com>
 <af85d99b-c02f-462d-b668-7a41ca966dd9@siemens.com>
 <e5081064-f132-4d95-9254-e2962ae7bcc9@siemens.com>
 <690f991a-a496-483a-8125-8245991ab25b@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <690f991a-a496-483a-8125-8245991ab25b@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::16) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAWPR10MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dde9e15-6b2a-41ea-e8fa-08dcff285d99
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VWFxcE1yTGpRbWViNTdCVjNTQWJJWUM1Y0RYQVNrL2dyNmxZQzR2SkdCUmZN?=
 =?utf-8?B?elpxdTU5M0ZsOFBzVS8zbWI2RUNjM1UzZzRqTnpieGRzaFhoUFN3MnFZVWVw?=
 =?utf-8?B?blBzZGRBTEhMSDlNQkp2cmdiK3lML3RnKzBTb3Z4SHl2Yy9vQjE4NHhaeDFh?=
 =?utf-8?B?Q2tMZDBycVovYXBNbW02ekMzdlhHUnd6ZUlnNUplOEs5cmhlOWkxTThpaURm?=
 =?utf-8?B?NkxwWm54NWxuQWg1MitJdzZ4dXhDUEMvNzVZR0JmRyt5YnhFZHc2NDBQUmNw?=
 =?utf-8?B?Z2xrNDUvT21Ia28rb3R6YlFaNzM2Wm1XVTFMMGJaUUJCVU9ZemU2YXBCTWlK?=
 =?utf-8?B?NFcrUzRBcWhLcExoTVF6bkRzRk9heU1WOVZLbkdiMUxUNlJESkVScStGZUJB?=
 =?utf-8?B?d1FJMjhyeHorcGk4Y21jLzM4cVdMU05YMGN3WXN6dmxhaFJrV21XWjlhRUth?=
 =?utf-8?B?dEZoSGZQWFM1TmZGTUxHQ2tBVWZRL2duWHFFS0wwZzVVa2F3MUNlTXRTL0VV?=
 =?utf-8?B?UzdaOXYyRVl1WGtTYU5rZmlKZ0I5OTVSUThGR0hBRGJzNmZNYm1xR3FoNncr?=
 =?utf-8?B?dlRSbi9iM0g5Z0hiNFp2UlNxbldkRElmdkFad1ZCMDloRFQ2UHZHSlB2NFQ4?=
 =?utf-8?B?NW1WalhNRXNKTFJKUTU2Mnk5c1IrZTMxZ0hTNlMweHV1WHFubjJJYlpDYnlN?=
 =?utf-8?B?TmsxVlJQUFp3Y2JUUHo4ZU84YXNTdm5vTGJaSDc2M3NhUlVGZDZNM3VIc2ZK?=
 =?utf-8?B?emx0UUc5ZUpEZDRKN0hmcHhQclQvcDQ4Rm5oQ3B0cGdrT0RjUkJ0L0JXT1Vm?=
 =?utf-8?B?TEt1SmdhczNQZzVnQ0t5M1dMUmZLSUVQQXRVQ3JZT2RkSUQzRjIxRWFqanZm?=
 =?utf-8?B?OTJNOXd3RWgwZWtIaUtmcTJ0SHRYOEp6NmV5enQrT1V6S3hTTFROckEvaC9D?=
 =?utf-8?B?a3lDaTgxdmExNCtrNUhNLzd0OHd3L0REUUJud1MzV2NYVGROeWdaL1o2V1BO?=
 =?utf-8?B?RGdyQ3RJZzNRaXdZTzZHelRCandCUWV6eE5WNDM0RHgzMVdwNVc3cUsyYmd1?=
 =?utf-8?B?dWtMMktaUmtTZ0l1MHdSRVZEcUYxMlNqUzcwWjlYNE1VOCsxWmVVcm1ydmR1?=
 =?utf-8?B?OE5YeHJ0QjBCUUNiUW9kQ0R1NFVqbFpNcXEyRGhEZmN4MkkxcHdYM3pMRzNx?=
 =?utf-8?B?UXdaUU5DbWRIMHNXOHNycDBrYkROZXpVdTRNL2h3V2Z5bzNHUGxTSnVieHpp?=
 =?utf-8?B?aVJWbllSNjZkMjdsK3VYYjNCTzlGY3laUjVOb0JNMXJBa24raTRLOGZ5SElm?=
 =?utf-8?B?TVZrRWUySXNFb3JkTEdxbGxCRkNMY2RXS1NaeXQ3c2VTQTEySkNWdUtkNjlR?=
 =?utf-8?B?TmVaNWUxaWdyS3V6S1NVbGNtZktubXRqMWR4RThkSkVZcmxjbEoxdTJpelBF?=
 =?utf-8?B?NWlnSWZRdEZ6VGdzNFVlSzlKMTM0dTNaSzl3OTZyTzFoc0ZJT3hQSFJhS25J?=
 =?utf-8?B?VVMwZTJHaC9FdndrTU5NNUNPYWhvYnJwdXJLQlVGbWhKQkNpbDgwb1pPTDhO?=
 =?utf-8?B?SHVJajRIL2g4ZXF3MmIxNmlJME9ha2gwWHlmUWc0VzBlWTVCUGRMdWNTSU84?=
 =?utf-8?B?cWZBNEsybmZUZWtVeXo5YWFVY29VS3c0MkNCUXJHUVdHWUE4ZXRxOHNrT2xL?=
 =?utf-8?B?ZWkyYjhpMnlVelczTEkwcXNjSW5xYUxJV2hMU1UrZ0t4WVBjMzIzTGM0K3hp?=
 =?utf-8?Q?xBxZymclJ90CFKP9yY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d2hwOFdQLzRLVlZtRFY3VGliOG9ORUVybE8vaUdKQk4rTnRwMkozQ3BmelZk?=
 =?utf-8?B?Q3A2bkJndFFmSEpNaTFXVittNmtGQm1sTm1VWjlTQTFhNWR0TWRkNmt1ek4v?=
 =?utf-8?B?bkFrOXdjWUNmRWVxYWxWTjZOcGFuTWI1ajljSi9Sa1BLb1A4VHdjMFpVRkJ3?=
 =?utf-8?B?V3NCNklycnlUMWZVdXlwczFmSlA2c2l4WmdIeXpnZ1hCZENpeThFVmF5ZFFy?=
 =?utf-8?B?NktlVWFQMHFTd3JmMytHQkEvM2czY3REWVVjZ3dieW16QVpKRW85VkdUMis2?=
 =?utf-8?B?N29hNDVJM3VvekZjV1VlYmpJWk93ZHpEbkFsWEFuSTFHaUJCOVZwTWNTTSs2?=
 =?utf-8?B?Rkg5dHBteGE3MDhhM2dkSjNzOFVGdFRraSt3SFRCbFBIN3VBNjd5MlJBblY0?=
 =?utf-8?B?WGE3Vm9ZTkUxUTlTZEpRNEdSOFVWdU9icjNSanVMUmczeWlpODhGRW5DZmh1?=
 =?utf-8?B?K1Z4VDB5eUZVM3hwSytpV1YxVzlRVXE3MlVRK0djNityZS9uNUNKc3JleUZj?=
 =?utf-8?B?SG1pUjgwL0FoRSs0RldjcXA4WVhGemdwWDNMaHZqRG05WmZmMTdIRU14bi8z?=
 =?utf-8?B?N1BQR2NPWmNVZGlLYVpjMkFvYjM0QktLZlN4bDV4cEh0VjczNnJJUzUyS2cy?=
 =?utf-8?B?dUx3anRtbEJZRW5Gb3JtQzhENDYvcGh4L21VWkZyVmNlSmozY21wRXRLbkRv?=
 =?utf-8?B?Q2MwVUJGOG4wWXhSVktPakNsVXRxWW5PTUo1ZzRNa0lyKy9BZ3VEeG5JNU1u?=
 =?utf-8?B?MDlBL2t4U0UvZ09Icm1YcTRRUDU2TDN1eWtyV080U1N4TjYwK2U5RDFVQjVn?=
 =?utf-8?B?VUZZRmVOTnlvSGFRaXJOVHQ1ZEVZS3p0S0dQemlMTG85aDZnSTc1NDZJV3J3?=
 =?utf-8?B?S1FsWmY4ZHNOZzRUMjhocW1IRlFSVnRHUll0SThkbGo3ckg4QldjbHBwSzcx?=
 =?utf-8?B?QW1aWTU0aSt4cXF4cmxtZEY5Unk5Q0RqRVE3dzNFdGExU2pHZzcxV2lzdjBP?=
 =?utf-8?B?NjQ2K3lRK0svRDE3NEk3ZG41UnR2c3J4NzFWVERUZVdWRVFWMGVacVA0YmUw?=
 =?utf-8?B?T1FJMFl1TCswT29zTTVvMjArcGY0QjdZakwwaWdRTHNvSjFzdDBYeEtucXJB?=
 =?utf-8?B?WG0yc280czhTZ2g3RmNzaHZpeEhsaWxzL1ZNeVREV3hiUkRadVFaMEFENUVa?=
 =?utf-8?B?Y2JOZ241WWhWNHdGUDliK3lyeTJHTkwzcFNhYVRiTmxEcyt6b2FOOCt1N3Fm?=
 =?utf-8?B?WUc5aXF3MVJ6ZUl0NCtiOGRFOVowSEhQMXFQTS9zSC94bUFHN2E4R0JMQWxp?=
 =?utf-8?B?bldVRXB3dlIzQ09MbjBLVVpkUmVxUjAxNzNkdHFUekR6Y24zT2F2L0tsK0FW?=
 =?utf-8?B?UFJ0d0RJMnJQTCtPYmNNc0JFbnBSd0hTdDc1NlAyQWlRRkNlUkljK0tNK2Ez?=
 =?utf-8?B?RlpsTzZ5dVlON0JrQ3BhOS9ZRWhUSmNrNldwK2xITHRaLzV0UGEwREhuQkg5?=
 =?utf-8?B?ZWl4em1nNVRZaEVrWDBBcjNFZVNUNFoyUzAvUVovVldrMFdZT0s2VU82ai9z?=
 =?utf-8?B?dURqQUlxV0JkdnZtckRMcnFhV0tXa0IxUXVRVStISGlSNWtIbkxYZ2hqNWxI?=
 =?utf-8?B?MEFrVHpXT1YraXBaUGhBSDJNSzhGazlETXViajhoQmpORWRGbkZmQ01udnRr?=
 =?utf-8?B?OHh4ZEY5V1g3RzVPYmdvbExQYlljR1NiT1FsWWtBMGVTYjVpRWtDWDlSbGdI?=
 =?utf-8?B?U2h3aWZFQnNiaDRGRUxHbXR0Y3dnVEpqZUVZRUxEbDRUbmxqVG1OREZjOHVM?=
 =?utf-8?B?bVp2UXNnWjlibXR0eWlCL0ROOGVXa3R2Mk5wMStUSVNKbFZQc1hLb1d4Y0dC?=
 =?utf-8?B?dzk4dzFjb2pWQS9YeU1ZR1ZoMnpQUjlPS1lGa0xjQWNCdTJ3QVpYL3o1dXBn?=
 =?utf-8?B?eFpvOXFvdTBmamZWN0t1cVZIZm80a1VxTWpiU1pJNTZhQTRZU3Z1eXFiY0xH?=
 =?utf-8?B?NVVpRnQ2TFIvSkFST1ZnSkV4aVNZcmRDUldHbjVOL3BMZUIrUWhxQ3h0Q1Rp?=
 =?utf-8?B?a3JmTTdkWmlvOGd0dnowckFnUHZ6SG9WYVpETGl3TEt6NWEwMU4ySW9nOW9m?=
 =?utf-8?B?VS9BNWYwcTBoR1hkVExDb29Ya0NWL2ZNYTlwbXJLdE9YQjR1ZXhQY3ZJYmJl?=
 =?utf-8?B?NVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dde9e15-6b2a-41ea-e8fa-08dcff285d99
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 12:33:21.5291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSdu3yVpeo3C+nqRm5EDGXmVLcyRZf2rNjJ04udL4r2+BY08ieRRbOdO6v6TCyrkMdRQnBrODOQLJ0f52Mx/Am+nADs0AXRNIulQw5v+wcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7367
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 12:33:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17218



On 11/7/24 13:17, Jan Kiszka wrote:
> On 07.11.24 13:11, Jan Kiszka wrote:
>> On 07.11.24 12:30, Quirin Gylstorff wrote:
>>>
>>>
>>> On 11/7/24 11:57, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Under the assumption that future versions of Debian will deliver us the
>>>> needed versions of SWUpdate, this eases to opt-in for self-building.
>>>>
>>> Do we need some additional logic for SWU_SIGNED = 0? As swupdate from
>>> trixie requires signed updates?
>>
>> You mean we must enforce SWU_SIGNED = 1 from trixie onward?
>>
> 
> ... or do you rather mean we should switch back to self-building if
> someone selected SWU_SIGNED = 0? The latter comes with the risk that
> self-building for >= trixie could quickly become untested and start to
> silently break.
I think documenting it would be enough as SWU_SIGNED = 1 is already the 
default. If you want to deactivate signing you would need to set 
SWU_SIGNED = 0 and activate self-building.

Quirin

 > > Jan
> 


