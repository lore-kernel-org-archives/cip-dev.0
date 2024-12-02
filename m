Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B25D78321
	for <webhook@archiver.kernel.org>; Mon,  2 Dec 2024 13:38:59 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.61])
 by mx.groups.io with SMTP id smtpd.web11.173902.1733146729996778950
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Dec 2024 05:38:50 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=QZTERH4R;
 spf=pass (domain: siemens.com, ip: 40.107.247.61, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZM+3AWF7lRU3/ne0oI2L7Op4k8A+fGggDZGUomt6o9gouXAnwjfW3baAj43Up5SB0slzIo74mAkwlzJ2189PrsqPPGZ8BJ4YhFo3FialIhdVUmZwbm2wUsQIdoD9X/hCSz7o2EQ5FBMAJEXnnjKBHrDwJWOC/+Y2YHkF5WZJRDesfsWFG1mgCA4usMEJbIXr/3oH5myqttnHQXcctMmGsePs3lnk1KAwzZ56YDbAJ3M6zq6pCT1fyVo6BcyZNw/9GMsNauoC6D3GP9weDX+OimLe+0EC6UbRAfHNFWNnwG/w+OqFSHk7kny0Ht031ZcvvOvtzqIkxetrVL1Ic6QKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXU/6QumLsThZ4q1SwahozjD1TWMWW5yg2ni8YhgM+8=;
 b=kVEIvgClUl3vV3nJ7bW6rBcedSHe5YJ73fvrxDCgG22QluXIpdkrQod+V/XliDYWDAg8nkEnYWf9H5kpefIjGLmIWLlcycQOEd7SY0IJ7c1pbfgQHM1zjY2utB7dE4QM0tDicFTcPUvYBY7KplKvs65GDFlkB75U3NV7Dz9Z8EI+4+gcumL5dsiJSssSfIQxC4d/TUDIWDYekJfpW+tCV+3eIHsn5KVYXcCBAHeKhg3vlsBrmPbhE0SIGUHVkDonGSU5EI10R6oJad6WqLGIkfUEYAa/s8hkehO7n9fG7FDk0iWowdkNNTsADgG40HP3yrrIaJJaYAWerIQ7tQ6oKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXU/6QumLsThZ4q1SwahozjD1TWMWW5yg2ni8YhgM+8=;
 b=QZTERH4RcwPFNQWXo72HfBu+Wztc+WLilbasxVzQ4x7u3N1wgyL0qsZlTRszWPtMDR4oTQMNFdWbq07ioG6dc8p+i1Cd6OrHa6Dd5knCMdFmFaxoIZCemPhx2npAcHs1iGkSLOg2fkg/NRZJmQrjzuObfIPPv1IYASFYz4x9KtGL4Gl8L0UPVJJiE3Gxri7SZXZRt+qeAaHhBpxrDscS4AkGetydpNlwBQQJ9Zip85KIr8HP/0RU5xlIC44b8pfy3P4rwEzbFedtztWjv6oODu4qBhNmLe1FZWe7dtQjCAUlGXUti0DZOStDUHUwsY1LrvMyvf4HchF2LvLXZUeJaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AM9PR10MB4134.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.8; Mon, 2 Dec
 2024 13:38:46 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.8230.008; Mon, 2 Dec 2024
 13:38:46 +0000
Message-ID: <b23ea3ed-d394-4ff9-bed0-61d4c6257971@siemens.com>
Date: Mon, 2 Dec 2024 14:38:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Booting security image (.wic) on M-COM x86 in LAVA
To: cip-dev@lists.cip-project.org
References: <OS3PR01MB6103FB47A8576B2CFA3275F6C2282@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <434bc0cc-a0b6-4095-834c-ddd6a3fb2b09@siemens.com>
 <OS0PR01MB6100E150797AAB51AD72A3B9C2352@OS0PR01MB6100.jpnprd01.prod.outlook.com>
 <15dbcfce-757a-46d5-9d08-d4a8298348fb@siemens.com>
 <OS0PR01MB6100597A316A2139498736C6C2352@OS0PR01MB6100.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <OS0PR01MB6100597A316A2139498736C6C2352@OS0PR01MB6100.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AM9PR10MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: e50f1d4c-c5ee-4a5b-dad1-08dd12d6a513
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|4022899009|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/ZKunfE7bBlhRV8YCIKqzT6nOF3089S8ym8+nD6cZLoKfqZrla5R6OVvXE3L?=
 =?us-ascii?Q?kl01cffbXe9M6yhNnH2n2AS9rLxO3simdZuX5uXE8RtNCR+4jRKpvqK267lv?=
 =?us-ascii?Q?e2Ljp7mktfjletjzCl2qmmKfMVx3I5fiXe9rZxPhM2K5adYOcHkBsQknTd6M?=
 =?us-ascii?Q?THZNJcozHu6ijnl8jjN0lnJ3ZyE2hM0AsUWekFbxi40IJFuLWAzeivQYfN+i?=
 =?us-ascii?Q?2W/5NpZ0EtR2gC+p86Ks96wjQC6IrlC0mbuOkeyOyRw3TCFRD3QmuZdOsqO0?=
 =?us-ascii?Q?OD4JXYxylPYOJ+rFGm3EMx4m/pfzzDrUcKyGIpAEByz0qb4jHPksy52Cs8MQ?=
 =?us-ascii?Q?3zgNJrhCWIvKgGpaHJUerULvkiCrVgnlxsce+gpEgdTcAUBYPtLvFwBp6WWL?=
 =?us-ascii?Q?Ix4m3yE+BzbCNb1EGtIMsj5zLiQCPoL8djKVY4uprEX7Ys82AncvgcWpOJSI?=
 =?us-ascii?Q?DDXou9GLRppF+Vza69U9bTygabmVNchaZp6V95B67SRZcP65h0frGyf+41zs?=
 =?us-ascii?Q?cHdmd7lao4CEdRfBq9CiZGYX7JcFYGFtwncrB46dibwcmjZmUm7FnmpHuFvN?=
 =?us-ascii?Q?WphGqP9sPPm76bFjcNbw92nJoV5sB71wa2PUCZovREZzkMxg++BnDD+aSgfz?=
 =?us-ascii?Q?PCcSxD+jSf3H0BNWoVXKXeoP6RE/4phmNnKe5s4Op7v7wglaz4UgYmgN9WY7?=
 =?us-ascii?Q?G7oT1o072IfobBYl8Di/UFmCGhwuBcrp1rcb0VHkPMMiTw0IehCX2PEttlZf?=
 =?us-ascii?Q?8EbdWB1IhYFmT6WvFeJ4a+cQLP0vrenyBcmJT5fEyiOrrYY/ETwEpLz9W+tk?=
 =?us-ascii?Q?xb0UxjJ4YmgafBETQZXVHqbwxgLhlb77OFZ8i+Lrrq0OIHqaDAtfXKutYWvz?=
 =?us-ascii?Q?WNq4hW7d4/ZDb5G8ML075Oh+HZ1Pd+9cIpmTeBPrufbNYb8kVosyxT5NIBy0?=
 =?us-ascii?Q?OtbJHYYif6KuJXWGduipUdGTOLfpdjWVCq6efC9v5ucUiQuFu3yFIx7vbJqx?=
 =?us-ascii?Q?F7yXPVM5uCcu+mhs2zyscPaRxPqOzjUcGHRLmNUU6q/MFx4GqarH07iD0D/Z?=
 =?us-ascii?Q?UBewk9jkg759cC9d/NKiWdBoLx7yITVhI1XupFeT4K940nXhdSks7VWUKQ2O?=
 =?us-ascii?Q?mtudwKleTzVV8PUSe9iRFR3Jeb+9xKr3908wQTNbsyAmq1xeWUN0oApiLt9O?=
 =?us-ascii?Q?EmAHDjVBfDYT4kl2inNt8eH3hyatwgsrKQD1D7mNzAB5E6XPJm9Vktz6bbc2?=
 =?us-ascii?Q?PIQ1WAkNqoWv5P5qKDZud63QRGVQopLBiYdfb2bduortn+WNvX6XZ7It6MrR?=
 =?us-ascii?Q?tjA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(4022899009)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6KZvJlARnvB8SHCWiCo17E8oSucTdL3WAIVB7Q+mteSxVCQI1Edo9jAiFph2?=
 =?us-ascii?Q?d1xkIydGx4Ar8TNfiJPS52Q7OkkJH2+roYfcJ8Kb0hWHFra7vvBFmMJfXxN7?=
 =?us-ascii?Q?5w41IS026i7KPDP/bAmvdVkDCKWcV5ZgYX/EQIE32lQkrA2N+BpiDISTmBV0?=
 =?us-ascii?Q?WTvpIY5mKKf3Z4ALAsUtAoUYV93nRAaQYV/vbdIIoVlvq8yKIq6wkwyHqx7k?=
 =?us-ascii?Q?GU4z7WEL1u9h4t6w/pnw4bfeMcZ5a1ZbhN4aMNLKdjK6+lduq+Hqf7gZ+L0d?=
 =?us-ascii?Q?3vgKzbgzcldNSJxg2/4EzJTRJiZX+l5S3SAalOMMwGMxSLJtYIgp+/n7PSSR?=
 =?us-ascii?Q?nnuizTk/UnVqxgkxcSPNUSH6Thv19lHCWZUH1AGlasmufnuSlyNufXcuI/Pe?=
 =?us-ascii?Q?GLyBB5qQWcoAWTnVLOBR/rzl69fPBVW9TCfEQxZp6LW3SlQNDfX5QlME7dRO?=
 =?us-ascii?Q?0N0dfemepGRvQ4BuWPlGn8bU0HqynS6n35IiDhMNOj9YPC/w9iJVuYw8lC6L?=
 =?us-ascii?Q?H3L8ojiWdnQUavAxCtr6AjuBpscYSm7rp32URQ6V3NjNgKcHJsmy1ulFqGqp?=
 =?us-ascii?Q?6FmvY5vBDUxI/jvzR2zBrP7nZMheVXzTexrRLwsTaWQvt/v1er/zOehrhMd1?=
 =?us-ascii?Q?7Uy6TESKr5FMr6nbtosbVYRbiKlKB7J4Bo5z5ZezOa6uOLdwMpiih37q8wS5?=
 =?us-ascii?Q?HJmTiC3vwUEVK4tAHqCT6uHiB4ohgNeEjIVbR3hUgkeQvpPsXl0lt2ffvF+U?=
 =?us-ascii?Q?FJ/4r2f9meKzmahF4kDANQgi7PziwU7Pqu5hadYDnDAO/xrKcQoVYpkFg9LR?=
 =?us-ascii?Q?MCaDJsNOQ2WPDAG4HOD/QKWPlMymVcylIvxBZwnxXXZnAh6DW35tqUuCl25V?=
 =?us-ascii?Q?gzSpdloUqfoS3HKw42XzH/bQDbldfIr/Kv3+FWdiXFjOMr2/fMqibz1+U2xA?=
 =?us-ascii?Q?wgnHQjoRnmS2lSy/0W5hB+Fn4eYfxZ/JEFGg5B6/59QAVVlLQCbRUrjw9Pt2?=
 =?us-ascii?Q?+RTQOad9bVSDpcC0nc0sbD+0Ry+vJLAxbs4ugFCNf3dk0cyBU2onTVIUIDd5?=
 =?us-ascii?Q?WVciOTAX1FhPo8R2QDzHrxBOqa4TvuNM0TM/J8295HhhP1dNmKRWScfNzGUu?=
 =?us-ascii?Q?nw2EGj2XbgisnSykHlj0Io2t92txhRz/NzHKyTK9qgjhOIhfEQ2uudNOd3Nk?=
 =?us-ascii?Q?howXvGtr0x5Qar4vhWgzLcojY3cAprsoib951nw5wbo258y0tdMximO1QaYO?=
 =?us-ascii?Q?fIpEfVNPQATinDLYNTg38zvv2loxinbn9lzxk35eUFzV48EBOZ5GQM8U2CiB?=
 =?us-ascii?Q?BuSpUTZiD/vephT6Fq5cILwjypKG5bynup2caAlO3+9gOmj+apXUc21R7Txd?=
 =?us-ascii?Q?yYidAqie2YOLoRBngjUZQzd1uYDVCJiWeIdb9rvxtYxN3f1K6Su0feT/8UEH?=
 =?us-ascii?Q?UlRJNtUaizppcfK+oNl9thwNt7TjcDMaD2HUjmK2S836xtWLoDxRhDqA3itN?=
 =?us-ascii?Q?uNGIE9T/yipb5EkJMc+ndFMrMkOkdALoa++zaQUR3Mvq9xLc6gXrpEfbcmIx?=
 =?us-ascii?Q?9b+GtnyJ1VNVrSoYKJTLMrGY5726/sOeo/byDJptCRaO5/sGFpLepi38TVMZ?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50f1d4c-c5ee-4a5b-dad1-08dd12d6a513
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 13:38:46.2974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQiin4wZUN/pCoGE/D4YaFq5pavH6kUMDAoZJMHjw2Fm3cLLp27RA5qpbkZUGurFppXPfY79JZn0oCC8Kx8sotm4DzE5eEgJcmwn/c3d9sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4134
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Dec 2024 13:38:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17308

Hi Sai Ashrith,

can we separate the testcases which require secure-boot or wic images?
So that we have a test base which we can test now. In the mean time we
can check how to get secure boot and image based testing for the mcom=20
into the lab.

Best regards,
Quirin

On 12/2/24 14:33, sai.sathujoda via lists.cip-project.org wrote:
> Hi Quirin,
>=20
> Currently we have only one test case where we verify the secure boot=20
> enabled message in the boot logs.
>=20
> Regards,
> Sai Ashrith
>=20
> ------------------------------------------------------------------------
> *From:* cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on=
=20
> behalf of Quirin Gylstorff via lists.cip-project.org=20
> <quirin.gylstorff=3Dsiemens.com@lists.cip-project.org>
> *Sent:* Monday, December 2, 2024 6:54 PM
> *To:* cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>;=20
> Chris.Paterson2@renesas.com <Chris.Paterson2@renesas.com>
> *Cc:* hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=EF=
=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=
=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)=20
> <kazuhiro3.hayashi@toshiba.co.jp>
> *Subject:* Re: [cip-dev] Booting security image (.wic) on M-COM x86 in LA=
VA
>=20
>=20
> On 12/2/24 14:09, sai.sathujoda via lists.cip-project.org wrote:
>> Hello Quirin,
>>=20
>> Thanks for your help. We will go through https://github.com/siemens/mtda=
 <https://github.com/siemens/mtda>
>> <https://github.com/siemens/mtda <https://github.com/siemens/mtda>>=C2=
=A0to=20
> understand how this can be used
>> with LAVA to flash and boot the WIC image.
>>=20
>> As you said, the secure boot image can be booted on a device with=20
>> "Secure boot disabled" in the BIOS but we have a requirement to automate=
=20
>> secure boot testing as well, so we need to figure out if there is a way=
=20
>> to configure BIOS through LAVA before booting the image.
>>=20
>>=C2=A0 =C2=A0If there were multiple devices, then this could have been ha=
ndled=20
>> using tags where security image related testing can be directed to a=20
>> certain device with all secure boot related pre-configurations done in=20
>> BIOS where as the non-secure images testing can be done on the other dev=
ice.
>>=20
> How many test case really require secure-boot enabled? Most test case
> should be written in a way that the don't require secure-boot enabled.
>=20
> Quirin
>=20
>> We can start a discussion thread in lava-users mailing list to check the=
=20
>> possibility to implement this.
>>=20
>> Thanks and regards,
>> Sai Ashrith
>>=20
>>=20
>>=20
>> ------------------------------------------------------------------------
>> *From:* cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on=
=20
>> behalf of Quirin Gylstorff via lists.cip-project.org=20
>> <quirin.gylstorff=3Dsiemens.com@lists.cip-project.org>
>> *Sent:* Wednesday, November 27, 2024 7:39 PM
>> *To:* cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>;=20
>> Chris.Paterson2@renesas.com <Chris.Paterson2@renesas.com>
>> *Cc:* hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=
=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=
=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)=20
>> <kazuhiro3.hayashi@toshiba.co.jp>
>> *Subject:* Re: [cip-dev] Booting security image (.wic) on M-COM x86 in L=
AVA
>>=20
>>=20
>> On 11/27/24 12:07, sai.sathujoda via lists.cip-project.org wrote:
>>> Hello Chris,
>>>=20
>>> We are planning to run software update, secure boot verification and IE=
C=20
>>> layer tests on M-COM x86 device in CIP LAVA.=C2=A0 To achieve this we b=
elieve=20
>>> there are two main challenges.
>>>=20
>>> *Booting a disk image (.wic) on M-COM x86 in LAVA*
>>>=20
>>> We went through the existing job definitions running on CIP reference=20
>>> hardware on LAVA to re-use if any disk image is being booted on them bu=
t=20
>>> did not find any. In every job definition, the root file system tarball=
=20
>>> and kernel image are deployed separately to tftp. We are going through=
=20
>>> LAVA documentation to figure out proper method to boot=C2=A0 =C2=A0enti=
re disk=20
>>> images on LAVA.
>>>=20
>>> Can you please provide your suggestions on how to do this, if you have =
any ?
>>> Once we are able to boot a disk image, then next task is to boot a=20
>>> security image.
>>>
>>=20
>>=20
>> I would suggest that you check out https://github.com/siemens/mtda <http=
s://github.com/siemens/mtda>
>> <https://github.com/siemens/mtda <https://github.com/siemens/mtda>>. Thi=
s
>> provides
>>=C2=A0 =C2=A0 the necessary tools to flash a device over USB/SD.
>>=20
>> We would need to adjust the lab setup for this.
>>=20
>>> *Configuration of BIOS settings on the device's firmware to boot a=20
>>> security image*
>>> *
>>> *
>>> Basically, CIP security image has secure boot feature enabled, so befor=
e=20
>>> booting such image there are some settings that need to be done in BIOS=
=20
>>> such as:
>>>=20
>>>=C2=A0 1.
>>>=C2=A0=C2=A0=C2=A0=C2=A0 Enabling secure boot option
>>>=C2=A0 2.
>>>=C2=A0=C2=A0=C2=A0=C2=A0 Adding secure boot keys in EFI storage.
>>>=20
>>> Only after these steps, a security image can be booted on M-COM x86=20
>>> hardware. I am mentioning these steps based on our current experience=20
>>> with local setup. But I am not sure how to achieve this on LAVA.
>>=20
>> You don't need to enable secure boot for testing - an image with secure
>> boot will also boot on a device which has secure boot disabled as the
>> image does not check the state of secure boot.
>>=20
>> Best regards
>>=20
>> Quirin
>>=20
>>> One idea is to pre-configure the above-mentioned settings in the device=
=20
>>> present in *lab-cip-siemens-prag *but in that case I believe health-=20
>>> checks and all other tests running on M-COM x86 can boot only secure=20
>>> images.
>>>=20
>>> Is there a way to change the bios settings through some arguments in th=
e=20
>>> LAVA job definition ? If not, then can you please provide your opinion=
=20
>>> on the above-mentioned approach.
>>>=20
>>> Thanks and regards,
>>> Sai Ashrith (T S I P)
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>=20
>>=20
>>=20
>>=20
>>=20
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17307): https://lists.cip-project.org/g/cip-dev/messa=
ge/17307
> Mute This Topic: https://lists.cip-project.org/mt/109804627/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/175364=
0/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


