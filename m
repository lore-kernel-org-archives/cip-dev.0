Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D52C02198
	for <webhook@archiver.kernel.org>; Tue, 18 Feb 2025 11:01:10 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.41])
 by mx.groups.io with SMTP id smtpd.web10.16887.1739876466570004723
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Feb 2025 03:01:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=xRk0z0qC;
 spf=pass (domain: siemens.com, ip: 40.107.159.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Grr7ghrTHMlpNSf5xLc7r0jLqDn2AlKZOaaGR1xvIxsjruhOyXxY4ogWwIatwEoj5ZVdKUQULJ3Ij8wvz3zISxw4AoI4zQKkljr//LFZZkVePW0qyWCfFrHgB5cxeGiHWiYbOM9l3bHHnMR9PNSiPzJ7D+wam+wF6iu0aGC66ZH7LK72RmNFtAETKCUGqFR6KVg8UtOIyAlZFSOvztoHP+NEiE7I1FJhc4yHK76rMrzPsMDb6YEK94K6OTnLnWXNwerkAX6mA3dNaU1cyFKS3aNU7H3RbDlEbR+mzHbKvGo2TWR+KJg/i+8UOwiMXwn4/ofb7hNXr5ANioeoTZ3mFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb0d0cx5Ahj6gxXqLqambeRH11PtiHcwtyf7F84PXV8=;
 b=pImlzNL2S6sQ/nf3FNYl93jhP0gF1VodCHjZGfrNqnbSEkAskzSWe/QvJ4Jt6afbcvHwjmL+uNLXWtiKFzLoi/CoFztPAKvMZJgY6XX1yIAMuPmE4rQoJ5K3FA5ynfrcgFWgip3zqM36TG0AsZDYRlNih9E/F2F802LncySS/QJaPrY+hhW6IdnK/Z13kfdu2PyVwVV23mZPOlpCVM5dDtZtfnh+vV/q/CO2Nyf1R2vbbHKjOeQt8BRJInHYfcDiNtuIFqlQ3qdAAtgdeNuyNa3oCwJmBzlw/Nqo/x9roy/tF09CvgIb/58Bf65dsaemYrQfQZGL+isLctmvSMydiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb0d0cx5Ahj6gxXqLqambeRH11PtiHcwtyf7F84PXV8=;
 b=xRk0z0qCXjqDsutLgRl+S/FntxO5I8OquuoUNHsKaXkIRwMnj8/oYJfdibnevBItjIl+E7uJcswLXwwrAqvtqDkZ1kbZavotH9Cyox/rXZhSgce+mBlCEHOdd01YPn621q+rFdJzF7yCSCdqlDAKsdYFQV33L/fzc/qvK0NgWoH6zVLIPRYR6laQfBwyUWsAPytDUfeow/n5BuvWuqTIl6X2qR7XpnqPEz+IzPtv/XwD2etFD2gmWiCI4W0OQ/tbRanZL2lAPGVdJ5w/ij81GyuyHZr5bygK/WfHWDVGpH1eqSWMuy/wKMmznqAP6aAZZZQL7jIJYTQ3DPnEcDlLlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8565.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.12; Tue, 18 Feb
 2025 11:01:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.009; Tue, 18 Feb 2025
 11:01:02 +0000
Message-ID: <dc476b85-46c8-4a8d-8269-da7aa26ace35@siemens.com>
Date: Tue, 18 Feb 2025 12:00:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH] update cip-kernel-defconfig to
 the latest version
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org,
 "Arjunan, Srinu (FT FDS CES LX PBU 2)" <srinuvasan.a@siemens.com>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20250214053127.1152501-1-srinuvasan.a@siemens.com>
 <59c46970-e5da-45d5-84b5-edbe763c1792@siemens.com>
 <PUZPR06MB574734D2FC5651C2195AD6FA88FB2@PUZPR06MB5747.apcprd06.prod.outlook.com>
 <70321418-f36b-4dd3-a6fa-ddda267c1a14@siemens.com>
 <22f263c0-94fe-45d1-8da2-02f05ba83be8@siemens.com>
 <1a1e5325-0565-4909-98a9-f1c7ccf82b98@siemens.com>
 <fdfa34e7-6ccd-4374-9231-6c4d1b2d8e13@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <fdfa34e7-6ccd-4374-9231-6c4d1b2d8e13@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:610:cd::35) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 594b1702-f9fc-472b-c9c3-08dd500b889c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?foikovy4VsfGN1lWTXgPI2QyChOLZD4dNmIGlAVL2uWF8uzICCl7QwxH0KAy?=
 =?us-ascii?Q?wD9fWf8aLwZRgmL/g+yuLhH3SiDu1ltthNHepkL7TMLF82OMkFIgTzyryc3H?=
 =?us-ascii?Q?rpu+VGIoU1xdCChTguvw5Hd4QbEqvFSHk+t8HGlzkms2e7Hx5jHqDrucchQx?=
 =?us-ascii?Q?BuLq9NO51ykhiAdubJRwuabEaEIsedU3WLhLiABwzklZCdfaV5T16dWSfjfs?=
 =?us-ascii?Q?0hyWi3XpCaUEBGXs0GCBcG7LeBlIXuAybwdizJkSZzkYwGewPUYB1b07YqOr?=
 =?us-ascii?Q?I+LwxHEc2jUvgpbkrLh4+NabTqA4I7JknQeLuZb7wA9SkUXFOtZX0vQDMjFT?=
 =?us-ascii?Q?DoAh7vPZBPaZa3hgdVLboa1Jaxheeq9RTZl3XpNaZsCycKWrHstuURm/nY3z?=
 =?us-ascii?Q?qo7rVW6EUDZkOs0kMT+hlt/Qu9QevAymSGw5VlDeceR88P3kcyFGRj9e6m8P?=
 =?us-ascii?Q?Gpp7OYoiBslrvjZtMduU0cKLUtjp3O4yKRxy3Ow63xQQquDLKZYymOeBIkII?=
 =?us-ascii?Q?m0/aSnx2Mm+2tUNqyfOHU8ml59EpN3lje4o5AXdQjn4yRKm6ot+QAuXjrsh9?=
 =?us-ascii?Q?PIW9HGjbFpc5edaJhf6xkCOY8egthTU1eid3lhhpkbby6d/DEBDcql6ZQuZ6?=
 =?us-ascii?Q?wJ5JLP9+l7YIAAhV1wAho3rjH5v9BpHVOZkc4zfwEzy0u6cejSbAHNgn0Cjc?=
 =?us-ascii?Q?xqscFr0ENI5kSpZ61oRwC+V2k8NTGWWmUmc+E+zedFlysbCFWo48Hg6dNbUd?=
 =?us-ascii?Q?c6SKO/rixKwrOI/u7Essx4PMazOJK03VNuJTkEvcpHTOyjmb3qvq0CQDh31s?=
 =?us-ascii?Q?YJWy4Xa2GEQD06I0tPf7H2jWA0Edadbi5JN0pfrp7IBzgmJ/jsZ0OjUKJKyj?=
 =?us-ascii?Q?AHztXQ5X25ErXGlSud5Fi0VvDTVhcxV3wCI8sOB7UytDHBCKTdWNkPlS6KDp?=
 =?us-ascii?Q?C8Xnjy2zu8xsGA1omfmcQity0rwlKxhJxzM+DoMn7xNSpDT06fmgmRgK3JnI?=
 =?us-ascii?Q?KCBTYT9R/8vdvOv/rKYiIocaomLeAjeVyWLkZnA8YNkVS38P1u3TrragI+jN?=
 =?us-ascii?Q?Smw6dCtgxCj/JWB7irRq6ZgOnqLYfPagxGq/oNTPi+fy8uyubkXbILSAI89o?=
 =?us-ascii?Q?HzaZBoF0ls5+oXPoZHjeXVCFlAxHSIDPCkMb8WHfxIwUAMBhVRZWF8w8EbmA?=
 =?us-ascii?Q?OubVDFYwqeO3C/L+QTWdPHReuSBMFjpuxtuq1KymH+/4GIbq56SSWwGWAkvK?=
 =?us-ascii?Q?HCuUdEJ43LHPAP3umZetV8eep2FO+uEEWoGi1uHSFsAEJ2aGmy+Z9yaFEywK?=
 =?us-ascii?Q?7EkvICds69N7QZSADm+rX+pBNhmBlOUkybhidnBld3fVsPDRrL4GP426rPtm?=
 =?us-ascii?Q?RErArblIt1NZWGQVARk3hLS0fvrj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dB9eg41UdTxaFP+uq4XDaGJYJdlIJXNbsa43U13FO3wx86uNyfKe+lYnSVzV?=
 =?us-ascii?Q?xOYECkBm+tjlViVUtrw5e2uhnjcu92ClY6tkIEaL+jWAGa+1tVaDkEvONRdB?=
 =?us-ascii?Q?rc3va9NxMnd4flYkxjOWXaY0CjKKBZltjzlFu326DB+stlykCTW99RxKr08X?=
 =?us-ascii?Q?k+vniYvSG0aXp2xHoeOL7Rh0hFXjxcWhmoD/HAqwOMVPhiOvc06Kr8g6/tpd?=
 =?us-ascii?Q?4SZMmqbub7dTa/rrW9GyIbhzruupCezACF6eYFGEddPtI608me/oi3olUL/B?=
 =?us-ascii?Q?uAZyOIIDVFCRthPMUL09R5WYVW+4jiwx9rnE+RP2+NmhKFp/Qilqn6htx+SU?=
 =?us-ascii?Q?3mGbiMlT0MzUJ0/SMyjdGqF3bBKVxC9W/ifIx3CM/FWG9YtrF2p/9X9a6/vp?=
 =?us-ascii?Q?2HcSnTKII8gKjObwWbocT6VMwiZY56i6YEfjgjW+2qPLTyV4URdnDlf+13us?=
 =?us-ascii?Q?bS9VJyljvMFAZa4niwlOzfq+wwVkkJzmB3PHLluCgT6aiDNTYwwkA/sRr0fD?=
 =?us-ascii?Q?4z/QV8L1ZLe3fGVuvr8UdTKA37/IvHo5BHv8jIqXOsVhJsury7r8l8SUAcrf?=
 =?us-ascii?Q?0S2W46XWKEOVNVIEEsFJ/FdX8m9mdEtKMj907kdijVoE/VM1WhDDUdyfus6j?=
 =?us-ascii?Q?NU0WIynrtha3Ii62zRs/WYOpNEdiJRvD8vQJ9C7iBT9CE5yXAdPcXaWyO0As?=
 =?us-ascii?Q?sMdsahvQoWjO/qncgRvvqOP2AXFyWrUatIzKvoLHXigVpPE7PHYxpXt1Z09I?=
 =?us-ascii?Q?5uXEzFDghPkiZd0c3je0f65dlb5lvZ3JRbNBSX6H44wUwmc3/yE18GQoNn7R?=
 =?us-ascii?Q?/Up1p1t/W99O+LxYK3O4Yl5nzJi9b+/PhxGnrRE8DQlvF9tDcU8wXSHhwaF4?=
 =?us-ascii?Q?r6OVdAcSAxEiFIVXCsUYsmI4Pjn9RFG+cng8br3Y/aH41Auc3TAgcyK2/eb3?=
 =?us-ascii?Q?Nvqihw7NQZ5hOFeTOPWXZzITXtYEK9u2yMJncHC+5EGpOlgrS1Yns+GPd/Qs?=
 =?us-ascii?Q?IZJN+NrauGi/JuEJO0zq5AT5zlocDQ85bN23GefCd1Ze4Jv95wvz0Cp/0TNS?=
 =?us-ascii?Q?I4vDoxKSfpw+v9nzLnaQ2WA5/3hE0D6xpw7xKXqojFOdIVm59hxVetwu2p6f?=
 =?us-ascii?Q?rut99KFr8R5zxZhxuoi5lnxslDJAxcND2fuJbsZsyzgsiCcXNwt/+AaRbMv+?=
 =?us-ascii?Q?Q0YA0rLqnBUeRrJqJS5SAtOaqxNM+dAO7SQXsNDFLj4rFqoyeUr60/Jh7P/z?=
 =?us-ascii?Q?xFvCqO5w650fArGSJ5Br3x6MiyIWSr9uWaXWw9IbvP1bnC5MjTc3ECE4LED7?=
 =?us-ascii?Q?gc/bWNB4kDP5PVK6456AqP3g57dASZ2Syb+4pou4I46ILBmb2Chc+KiWdDiE?=
 =?us-ascii?Q?F9shcUFHc0tZ9OmKf431L9cNa/dP16snHrfnF6+Rbe2Uvkbms9crxHhQKtTC?=
 =?us-ascii?Q?aOUEKTL2YzNbwsd6kmj4zKn1kuv4MzGD/iutQmrguejxbrcKJ0IdoMEOtcZD?=
 =?us-ascii?Q?iESjk2bvwKMKC3UERy11dFz+dqzFX3/v6hDsgkAeMxEnVQ8Z59EmpU4MJKpH?=
 =?us-ascii?Q?oNZrDUDVll7mt/jWjnbQG6TGIK0ayo3sSbgcZKSb8qLwU/gj2Plf5MeUuJ06?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594b1702-f9fc-472b-c9c3-08dd500b889c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:01:02.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uwl2bYFqoLwFtHTawzPyr0hZC0z4mYpdmW57vdDG2Yf0jMFd68FaJbF5hIAh4u5uDH/G/HYuAIeOFRAgRwOCKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8565
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Feb 2025 11:01:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17865

On 18.02.25 10:33, Quirin Gylstorff wrote:
>=20
>=20
> On 2/17/25 10:26, Quirin Gylstorff via lists.cip-project.org wrote:
>>
>>
>> On 2/17/25 10:15, Jan Kiszka wrote:
>>> On 17.02.25 10:05, Quirin Gylstorff wrote:
>>>>
>>>>
>>>> On 2/17/25 06:37, Arjunan, Srinu (FT FDS CES LX PBU 2) wrote:
>>>>> Hi Jan,
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 You meant this cip_merged_defconfig is generated one?=
,
>>>>> in that case, is this sufficient to enable the required configuration
>>>>> in siemens_ipc227e_defconfig to use the mokutil in IPC targets?,
>>>>> Please provide your thoughts.
>>>>>
>>>> Normally you would adapt siemens_ipc227e_defconfig and then regenerate
>>>> all cip_merged_configs.
>>>>
>>>> Also if you adapt 6.1.y-cip you should also adapt the version after
>>>> that
>>>> also(6.6 ... 6.13 at time of writing).
>>>>
>>>> Quirin
>>>>
>>>>
>>>>> Many thanks,
>>>>> Srinu
>>>>>
>>>>> -----Original Message-----
>>>>> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
>>>>> Sent: 14 February 2025 13:47
>>>>> To: Arjunan, Srinu (FT FDS CES LX PBU 2) <srinuvasan.a@siemens.com>;
>>>>> cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
>>>>> <nobuhiro1.iwamatsu@toshiba.co.jp>; Gylstorff, Quirin (FT RPD CED OES=
-
>>>>> DE) <quirin.gylstorff@siemens.com>
>>>>> Subject: Re: [isar-cip-core][PATCH] update cip-kernel-defconfig to th=
e
>>>>> latest version
>>>>>
>>>>> On 14.02.25 06:31, srinuvasan.a@siemens.com wrote:
>>>>>> From: srinuvasan <srinuvasan.a@siemens.com>
>>>>>>
>>>>>> This revision brings the CONFIG_EFIVAR_FS to read the EFI (Extensibl=
e
>>>>>> Firmware Interface) variable information via sysfs.
>>>>>>
>>>>>> Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
>>>>>> ---
>>>>>> =C2=A0=C2=A0 recipes-kernel/linux/cip-kernel-config.inc | 4 ++--
>>>>>> =C2=A0=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/recipes-kernel/linux/cip-kernel-config.inc
>>>>>> b/recipes-kernel/linux/cip-kernel-config.inc
>>>>>> index 53bee8f..e761957 100644
>>>>>> --- a/recipes-kernel/linux/cip-kernel-config.inc
>>>>>> +++ b/recipes-kernel/linux/cip-kernel-config.inc
>>>>>> @@ -1,7 +1,7 @@
>>>>>> =C2=A0=C2=A0 #
>>>>>> =C2=A0=C2=A0 # CIP Core, generic profile
>>>>>> =C2=A0=C2=A0 #
>>>>>> -# Copyright (c) Siemens AG, 2022-2024
>>>>>> +# Copyright (c) Siemens AG, 2022-2025
>>>>>> =C2=A0=C2=A0 #
>>>>>> =C2=A0=C2=A0 # Authors:
>>>>>> =C2=A0=C2=A0 #=C2=A0 Jan Kiszka <jan.kiszka@siemens.com> @@ -14,7 +1=
4,7 @@
>>>>>> SRC_URI:append =3D " ${@ \
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if d.getVar('USE_CIP_KERNEL_CON=
FIG') =3D=3D '1' else '' \
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }"
>>>>>> =C2=A0=C2=A0 -SRCREV_cip-kernel-config ?=3D
>>>>>> "e486c93a916cb6f78b4917b7345e8818f96069f9"
>>>>>> +SRCREV_cip-kernel-config ?=3D
>>>>>> "6b5db480b7a43e0217b1fa58f487f0bb997743c7"
>>>>>> =C2=A0=C2=A0 =C2=A0 do_fetch[vardeps] +=3D "SRCREV_cip-kernel-config=
"
>>>>>
>>>>> Argh, the commit to cip-kernel-config is broken: We must not patch th=
e
>>>>> merged configs only anymore, they are generated.
>>>>>
>>>>> Quirin, I suspect that plathome_obsvx2_defconfig's disabling of that
>>>>> switch causes the merged config to turn it off again. I though that
>>>>> was fixed?
>>>>
>>>> There are two configs which disable in 6.1.y the EFI_VARS_FS:
>>>> - cip_container_defconfig and obsvx2_defconfig.
>>>>
>>>> As we take all config into account this will deactivate EFI_VARS_FS.
>>>>
>>>
>>> ...and that would be a bug in the generator script: default-y in one
>>> config must be handled like explicit-y. And explicit-y + explicit-n mus=
t
>>> be y in the merged config.
>>
>> I tested the script with the changes from srinu and the option is
>> correctly set=C2=A0 EFI_VARS_FS to m. Save defconfig removes it again so
>> there is some dependency problem which needs to be look at.
>=20
> EFI_VARS_FS is set to m as a default, therefore `make savedefconfig`
> removes the entry from the defconfig.
>=20

Sure, and that needs to be taken into account somehow when generating
the merged config.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

