Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1CFC021A0
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 09:26:38 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.58])
 by mx.groups.io with SMTP id smtpd.web10.47610.1739784389370831768
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Feb 2025 01:26:29 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=buLOebXQ;
 spf=pass (domain: siemens.com, ip: 40.107.22.58, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktqKScS398UN5Ane1aNFM5Sse1mQPKvE26E/UCXrslYFQymnrD1W54WLePOZm8Vn/md/b9wV1cDdVcLiU0Tz4h/aUaKPrZlZVT+MS92xiMq2E1gUTuJ/T6ehPNouGsaly6RIIclpT82ojtrA3yFsP/oEdv4aXT1zQFTT51B3ETZcZBzuKIY9lxH31m3xntHmELjBSK7Um2XHQ9MdWgkvO7uMCbGDhijNi5JqiPMKUnZNFE1Ndq7mVLHSF/eEpdEChN4nAGZR0KrPPd6OTBi8ZTh8vsmwCAGy2zja7Dq9qYsjn/b55FMimi0OdfQJNXNSu2EtMbqguQjXnpm/LSo6YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VN2WtvQz8K0VrQB2B1FZkogWhWZ450FTQ+Q63gEMD3w=;
 b=FyhMzvft5sCPg2nCGxyS74mzHVUU2rFCzEmaP20vqWgwx1J61sYjMXjeZBXV1ebb0+zpsatFFWkyrMZcTziD7yW+z/t9+dh1Xm8sDKhndeV481GOmIywSYtc6tnBhFdpCcXus9uEV1PZvZ6WpwitcBDzX4CITGUrdQTftEE+dKYM/Em4tLBse3GYLCx8bQvGMVJ13qlpEK3AzjjwQrYGp0VKdQbLuYvGtB3tv4xJhX9bQrpd1FCvGhLAUteQgbGXbplLKn7xnj+oyzC62qag567zZ1lkOJIXjMGVevPLTFNC32tkCxeJL7SRyvLa3d7x6H0xvlw8fricc699bTYoow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VN2WtvQz8K0VrQB2B1FZkogWhWZ450FTQ+Q63gEMD3w=;
 b=buLOebXQfmysBRasoIdCC376YvyUWS335K23bB52MB05EL8MoGEA9zz8O9EXsSqC90TGZ3pNM8hx42a9b0pLUGxKSta1v8yuLiK/ahA9YrOa7dorN750hseNQ56VQGIB09OKMMjNV946AFMbMJ07fL628LSLUiM3P1YvVwowFzAbzPo5ox23oc8pPrejzkr8pCjhacAxEJb9UOhuMp8UsYKpi4KVyQlCb5INDx3W7onqb00RSAx1y7YOBn5ILNztunAMJL8w9ui/+IGzFOgFpBtgJ3q/qDTcHR31SSP1gMolrRoiwVA5YgfqpdIGUbYBLJF1FXRmb0OvgJX2I4j+fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB6979.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:417::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.11; Mon, 17 Feb
 2025 09:26:25 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8466.009; Mon, 17 Feb 2025
 09:26:24 +0000
Message-ID: <1a1e5325-0565-4909-98a9-f1c7ccf82b98@siemens.com>
Date: Mon, 17 Feb 2025 10:26:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] update cip-kernel-defconfig to the latest
 version
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "Arjunan, Srinu (FT FDS CES LX PBU 2)" <srinuvasan.a@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20250214053127.1152501-1-srinuvasan.a@siemens.com>
 <59c46970-e5da-45d5-84b5-edbe763c1792@siemens.com>
 <PUZPR06MB574734D2FC5651C2195AD6FA88FB2@PUZPR06MB5747.apcprd06.prod.outlook.com>
 <70321418-f36b-4dd3-a6fa-ddda267c1a14@siemens.com>
 <22f263c0-94fe-45d1-8da2-02f05ba83be8@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <22f263c0-94fe-45d1-8da2-02f05ba83be8@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::15) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 6752d695-3786-4900-6b7a-08dd4f3525b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?OwTrVJs8zSK6XrMkoB4MNYZQ7bEkMxk95uhCeUfzIjVhQ35k+KNxemFvwoXX?=
 =?us-ascii?Q?afd80H4q5DTYqVh7R9eLqX32J+jtiyhRTfD/Duj4dCrKguNMxMicUozsZSgu?=
 =?us-ascii?Q?ZIQMmQ1tElHS0fxOsLijf0B1BVdnQpnp1DtHsEP4lzMrc8oRagoHjoZsVrg/?=
 =?us-ascii?Q?dCBuVzCOS9EDAUiTW8fvUmYZsOVEIL1WSB31fhApRzaKO0vtu3TuTICgdM+5?=
 =?us-ascii?Q?hQ7aD2y4JOgE5dFR4JPisBBW6SX5eykiADjDfiyZMDNZ+qkDTTIrD1q7wW07?=
 =?us-ascii?Q?K1gMTn9QHmB2vBziilcNPjJ9bQBHmMzBrVihTF/y30ZJrXQAJcW0/KsCUUce?=
 =?us-ascii?Q?NnhGKfQnDCaLwtMUkNdQB2gdz1XUptKwXep561/FwLEL/Er2UGfW8/I1UaGR?=
 =?us-ascii?Q?rWo5Ql3vY5V7QaDBxA05F4u/v1S5QrNvq1HyRYPKG1HsrQvorcU1KAytVRNe?=
 =?us-ascii?Q?w8czn5o/cmlNkVrMxD8nynLtCggwX+Qvb64grP9oZGyXA1TFzoK4XyS7J0yR?=
 =?us-ascii?Q?OdOccVdDrhYIkOc5WrVz6J+zs3DUSMLDyK74Joyyf1QedqmEkufpTIs2JgI3?=
 =?us-ascii?Q?BOLyi636XI5GbrWxp9zPR6TB2whceXk1yjNytm7L8CRXyh2f9tzpXQLpkJ0j?=
 =?us-ascii?Q?6M/9oGCaoE49jnW3iQhv0iJXLHk9+3pDe06jxhuktZ1c1PWEe1x5MtL/wEnh?=
 =?us-ascii?Q?kM10vJ5eUpN4gXMo7bupR8HoRt7MsF4Fkpuchbxr3eiAWl32hbuINrcswv/p?=
 =?us-ascii?Q?Yt5nTRrosvt3hol22cWW/omFb7rQBjmqDisk8BEJS505kIOuTEFovV6ttHy9?=
 =?us-ascii?Q?1TCbBuxOykj/xHMiuScYtG7KENhS30ztRPiRVNKgzrM0pu650UXHPmBhdmIz?=
 =?us-ascii?Q?CsODBCld8psCQxq1MvdGu1LXt7DnRhyTG3tUsL6xrpjEmo/6nOYsaxPF9dwn?=
 =?us-ascii?Q?gTSgcRN7DpWhNW7zIskq/u9jjEx6pwgdUfmcNb0JVDo/KLDwdimfSYZlFpsv?=
 =?us-ascii?Q?LCYbgaiWHfKTmhreH2hcLKL2imsusLW/mFoTvkafK37j1sB588KiY6JJ/Dxo?=
 =?us-ascii?Q?BWEwI7N8ztl9LooXAoMbL0vkv736WCIPOsSjTj2NpjFgs+lBRkEyobbf+GWR?=
 =?us-ascii?Q?Hjlruw+5Ra91IgeR5Z7s8F713qMcoqnq89J2yJCvODRLeMqw1ICqzLF86gSj?=
 =?us-ascii?Q?RnG11IsUFBWCXNNCjjpBumrOxPVfK9zqgn52d4icV0KKErTZ/SU1YffW4RpK?=
 =?us-ascii?Q?fFSTLg2yHv9w1NUDWGPFuGCqucTj8OWFZVJq8QbubtGX5ThTnZO5LMEgTvbn?=
 =?us-ascii?Q?sXrXNOSukHPAh0ELeTEeHZiGCYhUCqsa/+PrbG3HMoTGygz+9SyCY17/hZeP?=
 =?us-ascii?Q?wz/CrgkmalYaj5o0hE/OWK65+Ifv?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?F8+BiFh1Ucvl4fFrf0lGsBI2nVmMNLBpQ9kVHbAjqVl1YVCifKBcMuktVjgt?=
 =?us-ascii?Q?EapiPsxGRWeVA22lcKCsNA4XcV1pNtO8bUGw05LF24d4NZylhkGIyX5vQmNA?=
 =?us-ascii?Q?AYHfzvzC8eWn7HooaJV8/c6LG+PNL5KdCzzOz9eP8gyomfIW4u2Xtj9T+WOC?=
 =?us-ascii?Q?Vc+PBils2dME/gfAYq++zv8iH3Yk9/2xT4N04eQj6jTK3BGerGGvdUTE3Y4g?=
 =?us-ascii?Q?4JaGhuWa4EFEFjm7rCyDdIy6R+Eq5CmwQcM921vzKigcyFRqU1N76axcENq7?=
 =?us-ascii?Q?jPR1J35YYDlCazXwIAsRIYq/XhxLfdDZrLPT7tTFcVIMoo3rMNyybwuux7w9?=
 =?us-ascii?Q?RbFHzidaGXykJt43C5xLtLgpELuSffxCPWs9+uJDhIYdpayaxodvsiVufXKw?=
 =?us-ascii?Q?3PcuLcHfoTqbFOOMbTRmowpgU+0tS5EXLkAl0xy74gqfHgz6KtNAGwq3s25R?=
 =?us-ascii?Q?MI1zGt+57CASW9+devnHVhiUj+PCo11RcV1duGfvh8LLBijEGl+ZCuLkpQ2F?=
 =?us-ascii?Q?P7kP2oxT8pfkD8026XDXzjiYI1h+za6oTR8i2cChRJxBfbQT0SQGrD/okPX/?=
 =?us-ascii?Q?pBQYGsWa6FjqsYdBPMJOm+BXjK+YgKpVN2gIZazhbjAgGusS1zk9nBocgPLi?=
 =?us-ascii?Q?fAuJXqCSdY9XlSWDY4ErzVZ6y50U3sNdBf459WGqtFhuDdep6YKU9lTDi9Hd?=
 =?us-ascii?Q?atwX0VYhkHaxZjnkbPA1Iq7eDdwdWDBdElgiRScBsjkCz4svf9yJrUmTHQI8?=
 =?us-ascii?Q?YaGRRQNPr5MmHCYhxlEX7snDOEkyBAJqAQ0xArri1qAbj1VY/IefmAW9S3pA?=
 =?us-ascii?Q?e2IJwSF9pXyfP3epn9Y/+vLwCcmQw7mBQp383j9L0hgOZ4HEFci3r6bhppK1?=
 =?us-ascii?Q?c+KL3UofWn28C8VnIvCtjQHeajT3ePydr3TWTmQsWI9PNsggcogdTpBkogiV?=
 =?us-ascii?Q?22ikw9t3imAfGhFzXGlx4ExvdctmU5iVruusmSzOeN9Wtdv5Bq5N7Lztp4Ks?=
 =?us-ascii?Q?DHZ6N/7mQE+5eyIqNbPuQYuWmhtRxlwcWUcqji1It+9sG5QfddImXUnqDT1x?=
 =?us-ascii?Q?LQQZeVe12TgbrOI+21U8zdKmvvt6YqD3d/MgusJ5Qx2Wn4JAUxpl3x5rR0Oa?=
 =?us-ascii?Q?lUdwe7fcOYh7lpbElOF6rN14cqxYSxD+ObB0D/zqDN1kOaIEPPb0ZT/FoTuC?=
 =?us-ascii?Q?npxSis3wT0Jx2KxUvsCWoyfN2xhl90mlP7dotWMvbdbNUanO/fNIXUPN41WB?=
 =?us-ascii?Q?QRFO8Y95lanVhv4uXyK63Vb/0/utxUzXd8ZBBLCQCzU27TKfGycdhPRgT57/?=
 =?us-ascii?Q?dxZYmz3IVgVx4aOaO9m80q8UMUoGhhxN0odWpXO5OmHS6FCvhyzLjdaNQybo?=
 =?us-ascii?Q?r7U8tNaUALn/yHNFExra6h/RlVUZj/H7xfKSqBu7xVUmIUluja6Sv/ah7epY?=
 =?us-ascii?Q?qFIlS0pbLIuHr3BcokXRJo8CuTM8T+BuS/oJvfdZL3ENaH3oOgXe7jYStfTN?=
 =?us-ascii?Q?JfHU9+A2j1Yc540kaZA9MnJ4AWDXf1IW3rbA2fGqPBn/rklPAPyT+pvI55aC?=
 =?us-ascii?Q?Gghq0RPhemBo+Untrza62lG6VFYH+yag87TCZcOjh/DbVtwf8Bv8l5Xip9nJ?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6752d695-3786-4900-6b7a-08dd4f3525b1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:26:24.1822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMQ2WFqeXsHrewVvfZY4/u4Ba4w9Ye25VtVODamPAjO8gB3fXsEtoh9f6ERlCPoUF7p1sXMoaqNtd05EE7LqSGHQiidg2/TQO02fH6VRajI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6979
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Feb 2025 09:26:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17854



On 2/17/25 10:15, Jan Kiszka wrote:
> On 17.02.25 10:05, Quirin Gylstorff wrote:
>>
>>
>> On 2/17/25 06:37, Arjunan, Srinu (FT FDS CES LX PBU 2) wrote:
>>> Hi Jan,
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 You meant this cip_merged_defconfig is generated one?,
>>> in that case, is this sufficient to enable the required configuration
>>> in siemens_ipc227e_defconfig to use the mokutil in IPC targets?,
>>> Please provide your thoughts.
>>>
>> Normally you would adapt siemens_ipc227e_defconfig and then regenerate
>> all cip_merged_configs.
>>
>> Also if you adapt 6.1.y-cip you should also adapt the version after that
>> also(6.6 ... 6.13 at time of writing).
>>
>> Quirin
>>
>>
>>> Many thanks,
>>> Srinu
>>>
>>> -----Original Message-----
>>> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
>>> Sent: 14 February 2025 13:47
>>> To: Arjunan, Srinu (FT FDS CES LX PBU 2) <srinuvasan.a@siemens.com>;
>>> cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
>>> <nobuhiro1.iwamatsu@toshiba.co.jp>; Gylstorff, Quirin (FT RPD CED OES-
>>> DE) <quirin.gylstorff@siemens.com>
>>> Subject: Re: [isar-cip-core][PATCH] update cip-kernel-defconfig to the
>>> latest version
>>>
>>> On 14.02.25 06:31, srinuvasan.a@siemens.com wrote:
>>>> From: srinuvasan <srinuvasan.a@siemens.com>
>>>>
>>>> This revision brings the CONFIG_EFIVAR_FS to read the EFI (Extensible
>>>> Firmware Interface) variable information via sysfs.
>>>>
>>>> Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
>>>> ---
>>>>  =C2=A0 recipes-kernel/linux/cip-kernel-config.inc | 4 ++--
>>>>  =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/recipes-kernel/linux/cip-kernel-config.inc
>>>> b/recipes-kernel/linux/cip-kernel-config.inc
>>>> index 53bee8f..e761957 100644
>>>> --- a/recipes-kernel/linux/cip-kernel-config.inc
>>>> +++ b/recipes-kernel/linux/cip-kernel-config.inc
>>>> @@ -1,7 +1,7 @@
>>>>  =C2=A0 #
>>>>  =C2=A0 # CIP Core, generic profile
>>>>  =C2=A0 #
>>>> -# Copyright (c) Siemens AG, 2022-2024
>>>> +# Copyright (c) Siemens AG, 2022-2025
>>>>  =C2=A0 #
>>>>  =C2=A0 # Authors:
>>>>  =C2=A0 #=C2=A0 Jan Kiszka <jan.kiszka@siemens.com> @@ -14,7 +14,7 @@
>>>> SRC_URI:append =3D " ${@ \
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if d.getVar('USE_CIP_KERNEL_CONFIG') =
=3D=3D '1' else '' \
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }"
>>>>  =C2=A0 -SRCREV_cip-kernel-config ?=3D
>>>> "e486c93a916cb6f78b4917b7345e8818f96069f9"
>>>> +SRCREV_cip-kernel-config ?=3D "6b5db480b7a43e0217b1fa58f487f0bb997743=
c7"
>>>>  =C2=A0 =C2=A0 do_fetch[vardeps] +=3D "SRCREV_cip-kernel-config"
>>>>   =20
>>>
>>> Argh, the commit to cip-kernel-config is broken: We must not patch the
>>> merged configs only anymore, they are generated.
>>>
>>> Quirin, I suspect that plathome_obsvx2_defconfig's disabling of that
>>> switch causes the merged config to turn it off again. I though that
>>> was fixed?
>>
>> There are two configs which disable in 6.1.y the EFI_VARS_FS:
>> - cip_container_defconfig and obsvx2_defconfig.
>>
>> As we take all config into account this will deactivate EFI_VARS_FS.
>>
>=20
> ...and that would be a bug in the generator script: default-y in one
> config must be handled like explicit-y. And explicit-y + explicit-n must
> be y in the merged config.

I tested the script with the changes from srinu and the option is=20
correctly set  EFI_VARS_FS to m. Save defconfig removes it again so=20
there is some dependency problem which needs to be look at.

>=20
>> At a other note we should look into automatic the config generation.
>=20
> You mean as part of cip-kernel-config CI, or what?
>

Yes for example or as bot.

Quriin

> Jan
>=20


