Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBBCE77173
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 08:24:59 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.55])
 by mx.groups.io with SMTP id smtpd.web11.32628.1733473497423875580
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 00:24:58 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=vKasw6yb;
 spf=pass (domain: siemens.com, ip: 40.107.21.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLDXXoYfKuH1GrxHcKjzx4SwLe6mUssWfqfXro6klAh/W+aC/y0r2xavRDc/xkgAArC4Yv2qbcuAEC1HMpTminvOS6YUyTlwA2PVTEdHTaVgUS7gLPeH9/JIP2fzY3I4Kb+tJZ1CcQrRrcM83FIuWuv/GVKYItY8XxCvG0Th/XqGg/rGxsMA1R0AkDofHu1roon92XRt+7CnWRWoHSgV6Nrgs8WYm/S2v5c7M1NUeRWOzPS6Hi/39imACQi7v9aM4CjgGrrwTMHb2Joz8aEEF2mhDHLwVaFYel8SfIMvkYLbszTsZtV5zI8AY2sb/ShShqau54eKJgTwWBVDvISKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1eUzjfSgZ06zzttIGstqT26DT9eYhqVN17wzRtFed4=;
 b=ImCR3dvpcGVUOpgzH/wKjQeFUW0cFCrzVEubkSNfc5corQKLsVPftCiXdSP9pNAz9FMqCOob7fPg4cZBo4YdkLIo1DXEOckPjBvlCMnS1P+LbMZnMlAC7bkvCQ99rVloWMUt/Ovb1/bolNH5J4fcdarn8pyzrnC7Y/gifRMDXRM+xSTjjJnFkKaQ0zw29WP1joQOli2AVOcLkANrp7/fr7DBc5TGUGbzTQG/mC5cBEVbq2xMoeDQIYYuNrob9EFaWsSAPKah81wmna91rF9KVmxaXvyFEVGA0E7Is2pBxNOaJ/zAQcWq3EIgOlidaOoQsbY1WgftDGmhTKvcdvfWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1eUzjfSgZ06zzttIGstqT26DT9eYhqVN17wzRtFed4=;
 b=vKasw6ybuVHN4SqcXf97eYdbYgkGo/rQjVuprY+kSwR8Ck5kiXwBtLprrcajnxDXgBNqxiOvA/HTZkPYqcMbMUbmSJ2B4GVaHt+iFqAjBmw+QQOHsCVOqwb4m3dtOrLisdL9aysMuk2eY1F/2LrPqaO1ea9dwcnEgHt15peGPMNlzZBa+iu1RSi045Ze7uOn5/pz89E+DGWyaPKKtmXc8zixAsoMvyMiB8eLgmEhDQZr+figBlhIGcUEq59YTrpTVp1lZHTwLckh+yIprmujG2l2RYUaeq5a+tSiKXFbRp4+XYLHvg2PRz6LXhsr36czd9l89cooWYUEtW0zzZjX8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3672.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:134::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.8; Fri, 6 Dec
 2024 08:24:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 08:24:54 +0000
Message-ID: <0508b098-c584-4abe-aa26-cd56539ad097@siemens.com>
Date: Fri, 6 Dec 2024 09:24:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 10/10] initramfs-crypt-hook: invalidate
 PCR7 after unlocking partitions
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>,
 =?UTF-8?Q?Bl=C3=A4se=2C_Fabian?= <fabian.blaese@siemens-healthineers.com>
References: <cover.1733151072.git.jan.kiszka@siemens.com>
 <cc43a620895a8ddcf6745c7eb4564344ecdf74af.1733151072.git.jan.kiszka@siemens.com>
 <AM7PR10MB33200735E8FEECBF4CF8023086302@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <AM7PR10MB33200735E8FEECBF4CF8023086302@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P195CA0027.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3672:EE_
X-MS-Office365-Filtering-Correlation-Id: fcfbbb67-a4b9-473a-a4d2-08dd15cf75ed
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHhFdnJDZExjci84dE9GcC9RaUNoN0llYzVCQVlYTnptMGNBSFl0VFk0RHVs?=
 =?utf-8?B?MDg2UnpNVFBqSkJ4cWthVUlYTnMzd0hML1BFb1lVUnF5RFFMMUlBZy80c25h?=
 =?utf-8?B?MW90MVZ5TzNtVFN1M0w4eTlsQlNWZzZ6RVBrQWUydWNXdUNDZ0JvTWlNUDZL?=
 =?utf-8?B?ZmwvbXprY1Npa0xjdmFjRkJiQjlIbE11VnUyMytCajlDZUZuZmdGekQ5SXRI?=
 =?utf-8?B?OExaQ1F3b2I4OHFXUTUwa1JmeG5kWU1NendaSHRhY2lnaGtmVnVXc0Z4cC9K?=
 =?utf-8?B?MndiOHNRSDVmbUJCSCtJbXp1NmU5TlAwS0liaHJHZEhZK3pYYTVVeC9WTEVF?=
 =?utf-8?B?V0x5TG9QVmtBaUdkYW9KdDhqTU9qTGdPenRweEJRVlVIMjlyMVV2V0FreUJm?=
 =?utf-8?B?dTRPZzQ5bVZlUERmQVBRWFkyRjBObWt5blBYMmlZNWFpUmhQN3lXZzVYdWJ1?=
 =?utf-8?B?WkJVenp0dFdZZ0pobmJVd1NqR2dYVndTekFlMzRwYXRnV3lVUVFaL1EzY01q?=
 =?utf-8?B?UksrdndLYWpiWjRNazdrMDc0T3VmWFc0dUpYWVdiaDU2dTVsMHVMZUphbzg0?=
 =?utf-8?B?K0cxVWFEaWg3OW5MSWd2dGUreklHaWIyV3JLb2JuMUtXcXhYT0o5OG9WaG1J?=
 =?utf-8?B?TCthV29VZjNoeksvOVlrb3pwelFJU2pNVVlxaU1KL3AvYmM4bXROb2V4RG43?=
 =?utf-8?B?dnEwa1dTNTFuRExuVSs5ck0vSEdlbUxUSi9nSXVjVlRLUWxXV0xsanF6Nm5y?=
 =?utf-8?B?WWpJc1lJTVlHZU9hQ3VyWVBKUmh6UkFsNklVSWZhU09qd1lyQ1pKMHg3cUxm?=
 =?utf-8?B?amJWQ24xdStrcFhwZlBwNmEwaHI4bzVnOU1RYlY2cHVORFEwbGs2UUtwNUww?=
 =?utf-8?B?RTVPWUJ3elZZUGVKTnR2OXVYUU8veGlJN3UvWHdiRkxPL1dGQ3J1ZUJBMFM1?=
 =?utf-8?B?M2dobWxrM04yaE5ZbkNEdEx2bG5uRjMzdkc3SncwV21UVjlwS0RsWDRnOC9D?=
 =?utf-8?B?OXM5SW5nNnIwRzRBYWh0bkhYcnlNL09aeHBWajNpNGpHWmh0YVEyRmhBNC9K?=
 =?utf-8?B?elBvdGM4SzNRbVdNblVLajZKNzBaNFJBYURpZUxRYUcxZHFYWnM3ODFkL0VI?=
 =?utf-8?B?ZzdjejJsWHlPdmNBSHNtdmgyb0RYY09BdnZGd3NhVnhtb1FBWHdBbEF5VS9K?=
 =?utf-8?B?NHl5SUVZYU54QmNveUoxNXRnY1VvaHBmb3h3VWpPYmVKMC9meFNSQkhNU2dT?=
 =?utf-8?B?ejc1Z0duWlZFUVBBRE1uK0lPa3NpUDA0Nkx1YkpXT2RVS0VJcmVvb0FRL1Iv?=
 =?utf-8?B?Y2pwOVduMzBjYmpGSE4yUEQySU5xZkhSVHpUWXNOdkVPaGtuaVlkMVNHVTZy?=
 =?utf-8?B?K1JRMVM5YTNzTDJOdXFXNURhNjZYVGdLaFhrMUVlSXlUdmtKSzZqOTBLS084?=
 =?utf-8?B?bW1tblR1eWF1Qlp2bFNpMXpBVUI3SmtXMG5pdi9mSFRUeDE2d3FOcUowaFN3?=
 =?utf-8?B?ck05MmE3T0Flcko1Z2h1aTA0VCtGTEkwOXIvamk3ZEV0azF1WUFOZjZibEsz?=
 =?utf-8?B?SVpMOWx3VmNGaWpPZHhZQVlsOHNIdGV0QkZWb1I2MHZqdG1WV2xmVFNIV1NJ?=
 =?utf-8?B?bUpnU1VGU0xaeVlkemEwT2loWXFWdVZSQVRwbFdERzlaOTF4OXlQQVBXMW13?=
 =?utf-8?B?cjVvTW56dmpOdmxFTGdGVzA1bDdNcSt4d3pYV2JYaWFFcVF6TWJIeXlYZytz?=
 =?utf-8?Q?E47NukrS/OSmL1M0no=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1NYQkZYSzhGbnZKMlFCcS9LUlR0d1V0M0FhdFJFcDFDbW1yaklKS011ak1K?=
 =?utf-8?B?VlUxUGc0eFRmTUNBbkcxY2pUSDZqeHlHamVpdmQyQ2N4ZXRJa1Z4ekViUkQr?=
 =?utf-8?B?L2owSnNjUG9HQTJtTXBSUDZYUHJkMmtaK1dVdVZWY3FFK1Ewb1VxZi83M01m?=
 =?utf-8?B?bmRNenZKaHZBZ05vbGRhbVhtM25qRk9QNklUVE9mc0pmZHFpMUNreG4zU3Q3?=
 =?utf-8?B?eWV3QnRtUDUrcGw3bUtOc1Y0QzZWb3hWUllOMENHekRZRnh3UGl2Y2k4UG1D?=
 =?utf-8?B?UnZPbGRUc3ZWZ01FRE0rYXFpdWpQY0tlTjgvZE1IcWFqL0JuVTZ1L25mV3hR?=
 =?utf-8?B?dm4xWERDSUlOc2V4YnZWWFNkREFRdWlnL0k4M0syUVRQb284UlBQUHhaWUNL?=
 =?utf-8?B?a0tjSUhsOGd3SnpMRnNLL0psU04vSFpSM1JQbjFCODVuNkE1YUZCVEw2YTNj?=
 =?utf-8?B?dnFzdDVyRjR1RWQ3RDg5VVluR1l0RWpwTWVVSXlCRDJ3MVUzRmVnL0Myei9T?=
 =?utf-8?B?REU2VUowTkQxZUt0dCtZeExtZ1dia1IzK1BNTGIzaVlMQlZDVHg2Q25Vcmo5?=
 =?utf-8?B?WklvckppL3U1NVg2NWNkQVpZQzF0bVJHcjF1bUdBZXFlVk9Sc0htTzc4dGVh?=
 =?utf-8?B?QXJBelp3Qk5rYVpnQkwvYmwxMzZ0bU9rU2pjZUl0eFNkQlQ5R044WDh6LzhZ?=
 =?utf-8?B?a0x0akJUci9kVjc1K2xlL1I0SXlieG9yeEdrOTNOTDdzRmNmdC9ZTVc5cGtn?=
 =?utf-8?B?c2ZGMW5pRkQ4eloxbUEwUkNuMlMyc1NlOWV3ampYMzc5QUhwdkR1eFRjMzY3?=
 =?utf-8?B?OWdTRkpkajQvbEpiaW9RcCtNeUN6TTdJUmNJL1NuSW1ick05cnF6Q0daTyti?=
 =?utf-8?B?MXkrRlJrRDd6bGJ1VE5IWHprbitJbzlEOXFZd3JuSE8xTWhtdDVXY0tlRTNS?=
 =?utf-8?B?eTA1bmQwem53eERQOUpnajZSdHFrcldZNytmblJnL2VPQ2t4MkNLcng3czBw?=
 =?utf-8?B?QXltQXJmQnlKQnF1NFliY2JDNmE1S1hoR3QxN0p4ZHI4bER2SitOVGY3YzdB?=
 =?utf-8?B?Wk5ZcXdNZ3ZUKzlqOGh2S3o5ZU5NT1o5aEhUckhtYmdXNTNpU2VnMXU5eDAx?=
 =?utf-8?B?SVZickIrNExoYXVONFZycmozd3cxMWlPcVpBVzV6NE9lSGZJU3RLNTZUSTJk?=
 =?utf-8?B?TjBBTUhhRVg2MUh1OTRFejRydjByeisxdU9uaEF1d3BzRDRLZ1UxOUMwV0Jn?=
 =?utf-8?B?Zm0yMEdvSzBXOU1ScytaV3RsUkVqWDNQSFd2dXB5YXZTWnV0Tkx6U0pOWVl5?=
 =?utf-8?B?WUVwME14RU04d0tHMjFJQW9mWnJjdFA3SVBOdlhxSHdMbjBaenF6N2xrcmpX?=
 =?utf-8?B?TE5rSzlZcVh6QndTVURSY3k4aWxTdjdQWDRXcnd6WmNiOG9NRTRPa2VxYk5R?=
 =?utf-8?B?dDcwcHlZVlpIZjFMK1dhTWNVMVFSM2VkeGdCcTIrZm9yRXd4OFROQmFUT3RW?=
 =?utf-8?B?dG9yQWJ4V3JJNkxncW5lRXY3b0FMMGlmRURIVVRrMm9UVG1UNUZYLzg5cHZ1?=
 =?utf-8?B?alVqSjQ1RVQ2NlBIb1c3bWY2VzYrMGxKSVh4UUFmUFFLeFQ2akRSaTJxZVpH?=
 =?utf-8?B?WmszWXUwUXFIWTk4eUVVdnBmdXVGaXl5YkMyem54TUFtT1NqNXhCY3NNN01M?=
 =?utf-8?B?MGR6c3lvZ3dSTGZkR1JjZWxBVDlrdzE4aHRqZXFzaEo0WTBqRWRwZFJielNH?=
 =?utf-8?B?UTFNYlRuaHJSZ3YwM25mU3RNa3IvTERRYTFCbVJ0N0kyZnV2Q3FOYStML3Zy?=
 =?utf-8?B?SDdlVm84RW0zYXYrdHRXMnpPRTRVWW81VFhnWlI4aTZwOFZXQklBbW5YeWNG?=
 =?utf-8?B?Z3pMSndXWGYyODRFU3VNQUVVUzdTRm9XczdXQXdFdmNkeGFtRG50dmw5NUdF?=
 =?utf-8?B?OEh0MHRGNnNSWTRVK1NvcTBUd3VVR2FvbkxLNzRSajV1M1l2SEZ4aEJweDE4?=
 =?utf-8?B?eTJyelF2TnNyN1hkdExCNU5qd0lWRktVRmxBSEZZRG1XZTJNcWR5MXpUeHhx?=
 =?utf-8?B?MEJqVmhCdmpJdnBEZzdJK2l6ampOaC9saG5qekhxcFBLbUNMRUh0NHNRM0Ja?=
 =?utf-8?Q?1r3LPY36X5Am/ImxHyqfZzkCA?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfbbb67-a4b9-473a-a4d2-08dd15cf75ed
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 08:24:53.9768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHbXMYNDBQu00gyeFnnXXe9vTY5lnMvhflXNbkQqEKI4Kzh2y+fDChsb8NDvp7J5JusQSayOvmMBdxEx1/Rd4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3672
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 08:24:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17332

On 05.12.24 11:05, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>
>> This avoids that the running Linux can still access the partition keys a=
nd possibly leak them. In the future, we may better address that by measure=
 boot.
>=20
> Makes sense to lock the key once we leave initramfs
>=20
>>
>> Suggested-by: Fabian Bl=C3=A4se <fabian.blaese@siemens-healthineers.com>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  .../initramfs-crypt-hook/files/local-top-complete              | 3 +++
>>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb           | 2 +-
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-comp=
lete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> index 834dea22..4bcb4277 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -258,6 +258,9 @@ for partition_set in $partition_sets; do
>>  	finalize_tpm2_encryption "$part_device"
>>  done
>> =20
>> +# invalidate PCR7 to lock access to the disk keys tpm2_pcrextend=20
>> +7:sha1=3D1111111111111111111111111111111111111111,sha256=3D111111111111=
1111
>> +111111111111111111111111111111111111111111111111
>> +
>=20
> From TCG Platform Firmware Profile Spec [1]:=20
>=20
> "Integrity measurements of the pre-OS environment MUST NOT be extended to=
 the PCRs allocated to the
> operating system. Any Host Platform configuration change that occurs afte=
r the Host Platform transfers
> control to an operating system, or while resuming from other power states=
, is the purview of the operating
> system and measurements of those events are extended to the PCRs allocate=
d to the operating system.
> PCR[0-7] are exclusively for the use of platform firmware. Operating syst=
em and OS present software
> should never use those PCRs"
>=20
> Since systemd uses PCR 11 to measure things done in initramfs, including =
events like
> enter-initrd and leave-initrd, I recommend binding to PCR 11 in addition =
to PCR 7 to lock.
>=20
> Working on a patch...
>=20

Looking forward!

Thanks,
Jan

> BR Alexander
>=20
> [1] https://trustedcomputinggroup.org/wp-content/uploads/TCG-PC-Client-Pl=
atform-Firmware-Profile-Version-1.06-Revision-52_pub-2.pdf
> [2] https://github.com/systemd/systemd/blob/main/docs/TPM2_PCR_MEASUREMEN=
TS.md
>=20
>>  if [ -n "$watchdog_pid" ]; then
>>  	kill "$watchdog_pid"
>>  fi
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook=
_0.5.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.b=
b
>> index 71ee44db..2145a6e5 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb
>> @@ -42,7 +42,7 @@ HOOK_ADD_MODULES =3D " \  HOOK_COPY_EXECS =3D " \
>>      openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoin=
t \
>>      e2fsck resize2fs cryptsetup \
>> -    tpm2_pcrread tpm2_testparms tpm2_flushcontext \
>> +    tpm2_pcrread tpm2_pcrextend tpm2_testparms tpm2_flushcontext \
>>      /usr/lib/*/libgcc_s.so.1"
>> =20
>>  HOOK_COPY_EXECS:append:clevis =3D " \
>> --
>> 2.43.0
>>


--=20
Siemens AG, Technology
Linux Expert Center

