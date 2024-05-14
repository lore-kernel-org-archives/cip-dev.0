Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A4CC25B75
	for <webhook@archiver.kernel.org>; Tue, 14 May 2024 08:24:30 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.45])
 by mx.groups.io with SMTP id smtpd.web11.10215.1715675066371222629
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 May 2024 01:24:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=tybholk0;
 spf=pass (domain: siemens.com, ip: 40.107.20.45, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WY210wmG6kAvuQ1h0z80FemPmFGWuwHUn/C7vH8wL9UEhGaEhze6UZo/aIBn0HQzvV8H5WHO4YQivSl15e3ZuW8IrCGj31cShTO9cS8qQEovS0blRyVX65mxApp8/IJCRWVM08VxxiGm1DNbE+StVMgtxogWLFt8FOOe2AmTo8ogMciryRDZKxPzg3ZozqrNmgK3tH2eINyux6aU2vlf3+N5id4TXmTlqkaBdiT1nP4p/Fei3MZx06J6P7F3ayjPeHO7TVqgn1xd9YXw7N4lFXZ1zw6trLA9Z56xWGGHQZZmir9wn3sF0gOi2tmC8aQOjmpOxP9VmFVhRbMAh+0YYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hSQgdGSGohC2ky/wZahEvhm3W4VqIPUoXCnrDrO74M=;
 b=DPuthV1Hs4+/N35X/nsP0NfSZ+2sdFrrI0gWfGjXzhj+MAA35MMarz0MQSUz15vSJ60HmnccLM6mGrtE3Do7EPyY6u4hm4WcczQKUamQohmLXk75Bri1/CuQo3j3uiiR17hlFlZIroaay8/cnJaPp8ogXIz1AU4fzIuDNIhAMnd9d2V18u3Ox/QG7A2x58s9FDfttpduzlpI+Ek14uqLOfHmnZauerGIHkFyujDRgq9sqd/VYOnEBLlr3dIa86SUet8Bf9YTiTGhRkXX6u68zW7ue0hOyJ8FsLo0D7TkotpQrODZjU1pphjGoNHweUdwYrjRJdyPOzmGsYCp2aFT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hSQgdGSGohC2ky/wZahEvhm3W4VqIPUoXCnrDrO74M=;
 b=tybholk0MurOXYK3qN6NrnEJE6uZvx0HS14kAhplj9NVtD9Z12+G5C/zQxqeEkKlvLrb53GiZAKSozkz5sPIVz7JXTl+xMw9IhPaQpnN0K5ECQjZGxpn09agPsC39yjgraWCczbFJ4o3lxc5iLL2wUk+VzIxBECWX16VtCMJy+82U1q79nR4zzNXa3ZNem81QlvnG5YRmk2CYq5bpzevZ58TV6ZinlxVDe1CuI60SJ7qdNNTzB85PG//dQ2qd1tSHg3CqwpUiYuvT2gDpHmgnzMh6mKecttX6vaDbZC8ky4Z8xzAbrKDB3WpATEQbWg6+AVxa7WhF8ndSJJ1dv83TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PA1PR10MB8595.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:24:23 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:24:23 +0000
Message-ID: <d0335e75-97d1-494d-b60e-99f16b0a359e@siemens.com>
Date: Tue, 14 May 2024 10:24:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Generic x86 kernel configration
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 jan.kiszka@siemens.com, Chris.Paterson2@renesas.com,
 schilling.benjamin@siemens.com, dinesh.kumar@toshiba-tsip.com,
 iwamatsu@nigauri.org
References: <04b43c19-f26d-49c9-a12c-71cf3ba22e63@siemens.com>
 <TYWPR01MB1186261BB1B3D572F59B287E5B7E52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <078e13fd-59cc-4955-be45-9ad5906eaf29@siemens.com>
 <AM9PR10MB4085D362B7DC095E040E755F81E52@AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM>
 <TY3PR01MB11075F2400D6FB592B37DE2A5C7E62@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <TY3PR01MB11075F2400D6FB592B37DE2A5C7E62@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::12) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PA1PR10MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: db0008b6-45d3-40a6-0e3a-08dc73ef427f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IDq+7MNnwdq39zyMT/e0hL50Vxh0tsmMUBfsA0XXA2rsCzH72+NlMazuIHFn?=
 =?us-ascii?Q?hjkirIGTrLCNFxbfGBFGrwZeM4Uyp4aDe0dsmjcvON7LeNYug0ZZQ8BL8psh?=
 =?us-ascii?Q?EXjdekzenmLy4GosNxkjnLpWKk2BvKNoInKq9000z2shH+S7qR5HIHXlQl3O?=
 =?us-ascii?Q?82heiNmU2RgFEXcBtg3mbyFTkmTFjHcMr5wE0w0haXYcfg7SyuoxiMxxJjvk?=
 =?us-ascii?Q?5y6JUrWttaAW6C4W18z6OAmhWBX14YEevZk8nLYV0aS6KWB9AtmbqeZcCHHp?=
 =?us-ascii?Q?uCeg4ZsaUFt/gRCpK/3mR90XlskHhMWmo0zj+zfrch4PSgZvIn9TPlEF2EC3?=
 =?us-ascii?Q?+APXhj4pSbOIrXfscSZ8O8veYlxMPSWGN1NptQOtkyhKrP2c0k3sC8t6CSiV?=
 =?us-ascii?Q?A4UZrBk7OBXGfqCV3lWog49kInZJx+CFo7ICjmdVA1YstwU9CVuBxDcnXPCM?=
 =?us-ascii?Q?ikB7lckdi65TlLBZZR822z17RMq2W/r47EiUfFtjQ0LKkexLJkBrlPkPLMhP?=
 =?us-ascii?Q?i9sQxN+u0HZ7OtojCEsOzlyXEpaVw1jUqH1eosMpRHYbgPS09tnWBfmDA5ib?=
 =?us-ascii?Q?RI8ddeez0/FfKdFl8t1RGV1pBibhITAbRAe8ihG9ilwJ1ObXUEzq+dMkus/R?=
 =?us-ascii?Q?ZtNpQh2LlzGoimQ0eauegthHngv5rdsIGmIVtDi9UN9OGqM4Sw3QM6+PCEsv?=
 =?us-ascii?Q?6gqxXzrcpkRhqrtnnlWHttQ090HpJfijzGt12JDX5FOUMlaeJYSczFppLUXn?=
 =?us-ascii?Q?Qt4mZM+J9UjwkkNzWBLVZBjc5Dx3f2mV9WP7mxv3c9zmE6EdweYkJXEAmWmI?=
 =?us-ascii?Q?UeKiMOSMEBaxwSS8/DniDBgi7LDwA9JA9rMt5yJkexAncTUpqE7YuhKUSUVd?=
 =?us-ascii?Q?kJBq2NuufQlq7rWnIS1471uNavBSN+1+K/1YFMjPR1QvpA9bAo9IzMRXQLDc?=
 =?us-ascii?Q?yjaEfSjDRzjjK6iTBPvXmf2QsiBZcK/3b0X476Ckji8Rhp+GCZ57T5tFrpMh?=
 =?us-ascii?Q?nQ41vHuKifwEWheqK6Q4fbLr/rppT8CDJrYp6vjemCu+cyNS9tlxe+mGKTA7?=
 =?us-ascii?Q?lRIzDui3p/Y6VzN1PMDMMiWJwGyUzRQL1iSfwxQRYblAOkBS2oDU4VmsMfqh?=
 =?us-ascii?Q?Ks/LpkEplKJYukz60FEHutvyf7QtoddA3tAFMm9nIoF2hPgUJIxg385pW3aJ?=
 =?us-ascii?Q?gkBkDJU/aGMPfb7n2w/kcjZWr+qftwyNK/OssuOHNCOk00kwO4HyDit0Q6c?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0ymR2UfbRDN5wOoIOCPagXqzWaBp3TDUPkDXJfKH6gHJoD6RWjeGZDTnEsWN?=
 =?us-ascii?Q?vGyOMD31RoRN0CywEMRNKsQVI2WijetArneYclgD2vw8WYaTEVZ73oxvDs68?=
 =?us-ascii?Q?dwCtpeKjLyv+FG4Nus4R6UA5oASvzgMcX8uNrJ/S9gUkAmovTn/wWTWRx6WE?=
 =?us-ascii?Q?Gb2Y0rCoPTy3rMeaAtdKzK1GKaipiXcm5uFm8rqSLdpXpT5xwOf+ZZXb20TF?=
 =?us-ascii?Q?/OHeY8DvL3EFdYZYTGJc20/xsLSkTf+zGBOFnRFRf/eC00uK1UFBa++TsrVe?=
 =?us-ascii?Q?Ecq+cpqA12BPHG05aWieke6uhxbxexnMV6QxchLxxU6kixUXERsVpGaHodoi?=
 =?us-ascii?Q?qDrnkBX2TWWRJb1zTkEiYY/ySamwn5szYHGRg5Es1fggoffZaU+hLhQhTIJ/?=
 =?us-ascii?Q?hhefVntOsS/9ykN6Yzl208WxhaCySZngsClyFo08WkNOO16cEzyzgJagHFR5?=
 =?us-ascii?Q?33l5slAEfgGBKXBA4lrSe50z1tFV+95Ft/73YIA6nEqWSbXkqYPl4JIT0H+4?=
 =?us-ascii?Q?HBY+aOf186g3wogxB7CWFrfbgi44Ca/HNxoTm7cHn0ZyI5m4lk00AErDmeUp?=
 =?us-ascii?Q?kfFpfD4yXmlhli6JqTkPL7+cectAqOGf+V6GtrJ0Wp2qeGZG6FUKnnzzd6t5?=
 =?us-ascii?Q?F59o5g4iWgMaQoAYCWXLw1dMmJfGquGC6wZtfu0ZtlxGqRPgrP59TfpOG1Yb?=
 =?us-ascii?Q?MUBLGX3dRuM3oUjJFqOnW9xBXVEy5dv/Hjmn6oOceLfKed8d9OXesWIOO0ls?=
 =?us-ascii?Q?ScWGgXg/aoiphQy99hLm2+x6+eQwQ91vrHSeeo0JQXAgP5NRtbiDEzTTBRYc?=
 =?us-ascii?Q?3MteRQvyFD45S41gzzpyEvY+++yjjXRRrvlFodfRgSGOsV6b4E1+mJEaoKxh?=
 =?us-ascii?Q?oWYOTfL8qozZ98U61bKsHDtrN6PWWV4BD9Dyg8mHW8qOvcbzoztoLUioG2D7?=
 =?us-ascii?Q?NdeUC7pdvIWioN3RSq2ku0KkDkyLosJUK8+NNwzwDBZaLtPEd+sOpVKMuVm5?=
 =?us-ascii?Q?dlOvT5AB6xwFdRsM0jLsgZZtWkmmwENgAGZdIzDvzATIZQRg9WrlaKp20c35?=
 =?us-ascii?Q?hCP/z1xc+16ragWT7WJjqcfWPC5ZOZLWBlTlg9oOhCabI8++2Fl0o/4FlN2B?=
 =?us-ascii?Q?maEzqvtp5HgLrRrHnhwczM7z7dso5UGs/Y2dLj1weNjQh7cu0Js+KLnxe4xO?=
 =?us-ascii?Q?+E5AcI854AqMjUqGS7NSAnJVXhs4g3CCXbKPZliio6SBCL8lvpPgTstMFNZO?=
 =?us-ascii?Q?hob99GZnEtUEqN1hGWM7PS7NemB16zhp28w1J8xqWR1Q6EsnHveY0iX7ko4I?=
 =?us-ascii?Q?PZJSELXLH9ri+LlUf0ejUX+k3MMWDS/p4nOCQdnTHOqyVSXyaLUYOxAGoHmR?=
 =?us-ascii?Q?3sKq990KPB9Oqz/xXup7ztY4tyeDd2CjxccvNAWKxC6zNm8gdsBlL0/GwboC?=
 =?us-ascii?Q?Iofi1Em4BxHnFS845clilz9vphMe4Go+7utg+kr2GWg1CYGRozQ0zm1U0DbU?=
 =?us-ascii?Q?mPGE21NLLFsCB1VvUZwIpQqg6Xce+a8914WoeGIWrk9Z3LPS8T5hUaYUFkfx?=
 =?us-ascii?Q?Pc9MZEsO8Q6bkQJMi8tZTIf7c8t0Voj3BcuBDl6l9H9uHYoPJwZ8q2ml5+XX?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0008b6-45d3-40a6-0e3a-08dc73ef427f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 08:24:23.2745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kb/yrbpU+nhRirL4Z3STzEzVCXqX4AjrVSJCprfZ+zcB/1NZt5wViF/x8um79NXqd65e20sgy6wlBldDZFB5mGUE8d/1uPNRlJdCSTuXfog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 May 2024 08:24:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15888

Dear all,

On 5/9/24 10:54 AM, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Quirin, Chris
>=20
> @Quirin Gylstorff <mailto:quirin.gylstorff@siemens.com> Thank you for=20
> creating a branch to test generic kernel configs for x86.
>=20
> I checked out your branch =E2=80=9Cqg/merge_kernel_configs=E2=80=9D and c=
reated image=20
> for qemu-amd64.
>=20
> Locally I also tried to boot the image but it failed with below message.
>=20
> Booting from ROM...
>=20
> This kernel requires the following features not present on the CPU:
>=20
> movbe
>=20
> Unable to boot - please use a kernel appropriate for your CPU.
>=20


I created a merge request which should contain the fixes for the
movbe problem.

https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_request=
s/92

Best regards
Quirin

> Thanks & Regards
>=20
> Shivanand K
>=20
> *From:*cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> *On=
=20
> Behalf Of *Quirin Gylstorff via lists.cip-project.org
> *Sent:* Wednesday, May 8, 2024 9:46 PM
> *To:* Kiszka, Jan <jan.kiszka@siemens.com>; Chris Paterson=20
> <Chris.Paterson2@renesas.com>; Schilling, Benjamin=20
> <schilling.benjamin@siemens.com>; dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=
=A9=EF=BC=B0TMIEC ODG=20
> Porting) <dinesh.kumar@toshiba-tsip.com>; Nobuhiro Iwamatsu=20
> <iwamatsu@nigauri.org>; cip-dev@lists.cip-project.org
> *Subject:* Re: [cip-dev] Generic x86 kernel configration
>=20
> I will investigate it. =C2=A0I think this be one of the cases were automa=
te=20
> merging will fail.
>=20
> Quirin
>=20
> ------------------------------------------------------------------------
>=20
> *Von:*Kiszka, Jan (T CED) <jan.kiszka@siemens.com=20
> <mailto:jan.kiszka@siemens.com>>
> *Gesendet:* Wednesday, May 8, 2024 6:03:38 PM
> *An:* Chris Paterson <Chris.Paterson2@renesas.com=20
> <mailto:Chris.Paterson2@renesas.com>>; Gylstorff, Quirin (T CED OES-DE)=20
> <quirin.gylstorff@siemens.com <mailto:quirin.gylstorff@siemens.com>>;=20
> Schilling, Benjamin (SMO RI R&D F SEC) <schilling.benjamin@siemens.com=20
> <mailto:schilling.benjamin@siemens.com>>; dinesh.kumar@toshiba-tsip.com=20
> <mailto:dinesh.kumar@toshiba-tsip.com> <dinesh.kumar@toshiba-tsip.com=20
> <mailto:dinesh.kumar@toshiba-tsip.com>>; Nobuhiro Iwamatsu=20
> <iwamatsu@nigauri.org <mailto:iwamatsu@nigauri.org>>;=20
> cip-dev@lists.cip-project.org <mailto:cip-dev@lists.cip-project.org>=20
> <cip-dev@lists.cip-project.org <mailto:cip-dev@lists.cip-project.org>>
> *Betreff:* Re: [cip-dev] Generic x86 kernel configration
>=20
> On 08.05.24 18:00, Chris Paterson wrote:
>> Hello Quirin,
>>=20
>> Thank you for your work on this.
>>=20
>>> From: Gylstorff Quirin <quirin.gylstorff@siemens.com <mailto:quirin.gyl=
storff@siemens.com>>
>>> Sent: Friday, May 3, 2024 4:58 PM
>>>
>>> Dear all,
>>>
>>> I have used a forked version of [1], which you can find here[2] to
>>> merge the following x86 kernel configs together:
>>>
>>> cip-kernel-config/5.10.y-cip/x86/siemens_server_defconfig'
>>> cip-kernel-config/5.10.y-cip/x86/toshiba_atom_baytrail_cip_defconfig'
>>> cip-kernel-config/5.10.y-cip/x86/siemens_ipc127e_defconfig'
>>> cip-kernel-config/5.10.y-cip/x86/plathome_obsvx2_defconfig'
>>> cip-kernel-config/5.10.y-cip/x86/cip_qemu_defconfig'
>>> cip-kernel-config/5.10.y-cip/x86/siemens_ipc227e_defconfig'
>>> cip-kernel-config/5.10.y-cip/x86/siemens_iot2000_defconfig'
>>> cip_core_merge_kernel_config/recipes-kernel/linux/files/mcom.cfg'
>>>
>>>
>>> I have tested the v5.10.214-cip46 version of the config with qemu-amd64=
.
>>> The next step would be to check it in the cip lab on the real hardware.
>>>
>>> The script takes the Kconfig entries of the specific kernel version int=
o
>>> account. It also adds all dependencies to the config. You can find to
>>> log of the merge at [3] and the diffs to each configuration at [4].
>>>
>>> An first integration into cip-core can be found at [5].
>>>
>>> Any comments from your side?
>>=20
>> I had a go at building/boot testing the linux-cip 6.1 kernel in our GitL=
ab CI setup using your merged config:
>> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/12834768=
01 <https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1283476=
801>
>>=20
>> It built and booted okay on the ipc227e.
>> However, it didn't boot on the qemu setup in our LAVA lab:
>> https://lava.ciplatform.org/scheduler/job/1129968=20
> <https://lava.ciplatform.org/scheduler/job/1129968>
>> "This kernel requires the following features not present on the CPU: mov=
be"
>>=20
>> I don't know if that's an issue with our qemu setup or with the kernel c=
onfig.
>=20
> The CPU type the kernel supports/expects is a choice. I suspect that
> merging multiple configs shifted us from "works with generic x86"
> towards "only works on Intel-whatsoever". Combine that with a
> restrictive CPU type selected for qemu/kvm, and you get that kind of erro=
r.
>=20
> We should likely tune the common config for generic x86.
>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center
>=20

