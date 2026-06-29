Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7C7C43602
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 05:22:50 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.60])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.85875.1782710562348122299
 for <cip-dev@lists.cip-project.org>;
 Sun, 28 Jun 2026 22:22:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=qzcH3yhR;
 spf=pass (domain: siemens.com, ip: 52.101.72.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5aTCU9hzywByyqM/CTYr279U8Q1L6LDMzIhiYmk5kBwZWmq6/PswNXLDXgT0A3BSGq+gn/Ng17b1d8VRuyqppj4ERr1at0VVPiygmCuvyQOfB0pktdgKLc1xregnYmiSXHIFEy+fOKv5H+GwR4b3MYhEwE4nIbG6Zeqj+XVVQ9sCcn2ccj7Nk6k3h7ZsReNdlmBGVFEcE2CiP2UZYC3V56U/EFVbWz0OA+xmCZSeImrXaUvJ9MYtevEf0qRHUvoPrNwJnS70ivLnsLFvgMkmBwsZvuCY3gC0BIW/TJ7lRGzy0ZinNKxqEfoR8C8w0BCymhEeDqHgwM8uAHsib3zsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65epsJ+IecmjUUEPWWQEuZh9qEstqJKY6j+n1kG4uME=;
 b=Wku6WE+aFbYv2AHgMdesYsXehrDPPQc03TyK5oGMP07XfgbLzZu+qh+4jV9XLPCXec8WOGX8sNlL1UbHxx2GFOTQt1geu004JFYx9YaK3QzCt74QNpOkBrMvK+oi5YmMcGsjUdyxSwq0CctxAcsVVssLGh+7WAJEAsgebdWmbdbQil8ZvheKJl21zsZ64M8ATn7qr6aPsG3rYSaWHtivHQ5etpjxhlXBAoXR+UmgWVftB1u9Ck3cyXiKyfWe8TwGqpFwghBhMpPpL0RRMZ5jwV+pX6rXw6an3kZsZIZ7PGLBmYO7G3vQwdCFntslbK8FYkNMnsoafLtREaCRJf/HSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65epsJ+IecmjUUEPWWQEuZh9qEstqJKY6j+n1kG4uME=;
 b=qzcH3yhRsbkrTQml126mm14I7gTa28+IxSYmOC5Sorl7TA/OSww17zvwaDZNU1EmjGnRsLwjyxNJDfH1/+0BZqBtkQ6VHZ8UtTbZDxwIym4swwrWLTZZOLeHvdg1TYXd2W0Ekg4pT6bEM5IPBQXnQBx4c/Wo3/Q5YbpznoNx3/O+7baJgzIlJ95q1ik9MuF13Mpz6vu42tDJHVeWBZTptcLMBcamPT/+pLm1qU/JTTq8eIMu3LxYPkrUI0u6mqnnBPRVDNF9R9KdYrj/WoUjpv062p29ncOpaPbYA6yTtLVCaHrpiCOn0RsAQO6kaXdXCbkS0iHkQbTwwFrg0z0HGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8333.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:236::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Mon, 29 Jun
 2026 05:22:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 05:22:38 +0000
Message-ID: <d44159cd-a908-4412-ab51-ca4e491f69a1@siemens.com>
Date: Mon, 29 Jun 2026 07:22:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] Add missing MACHINE to install
 swupdate-config*
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, cedric.hombourger@siemens.com
References: <20260626163330.523726-1-Quirin.Gylstorff@siemens.com>
 <71292516-320c-4da2-8e7f-7079b4293909@siemens.com>
 <43d2827c-d9ea-4fd7-b5eb-9a2181c6b4a9@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <43d2827c-d9ea-4fd7-b5eb-9a2181c6b4a9@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0387.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 5797cb39-4e1d-4feb-98bd-08ded59e6f41
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|55112099003|22082099003|18002099003|56012099006|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 
	QnzibCiMXrZiZkpsMJR0CBtlZsoVe2Fu0ijchaJxsMNDki/mkS6U8PPxEz3aHcFZzUcJHT2MJ6Ll5sdXu85tX9JqKcwkHK5dWL89T7YrvdSbn2BaWNwwIA1AGiz6/nJfay1yS55fU2sCyEYTvZorSWx4vfYcMjIOwqpJ1paryH0DMYqH8V2uq1MHyVNkUjl4lDGIiP3bu7u36xeVcfaUOWc8ZPtbXZouhHxz48oeYMne+85RdUdzEUEPgCih/NG03KYzMZUNeraS+R7YKtEIzjGCFpfNRe4DV3kgNxGTBDitc3ngLRVedmnWsvqQdxYfuM6hVBA9BLH9A9mlsqVW8Tc44WEFTb3oCtj0XHnTAcDk2jXtLZE9Mh3g+6M9xWk5TK9JJok5y/ZDqASJY2t7LNpW4VQy3zKjWJJWyzGwgh6aFtjZ/+PSiPU8wQiq3dSrpLC1V7cl7iy4aSHwVfJWmFruaZdFzpzJMQ1rcXU5G2o7iBOvvExwkQ2gKCoOMpJsFny9QvlBUD767TyGpQbGddXyVO6PqqAUsesIbl10lR+fclRf0cWPMOMehS7H2Px5xeuWWm4InuEz1IC/6sYYMd5nwkVgeBFcAuE433HM5fswNEWpVRZBtu2C01q93L9Mu1gJMTprgu3jg4M4uSm93nR8HPayBKqn+zzNk6wAN0Y=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(55112099003)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iXx02+f4FVVYbp9ZLUEG12FFsnWsr2Qw7il2lHZBUrJpe84aR3tVPAPWAMfj?=
 =?us-ascii?Q?Mlr1p+L3pIN9MRPV/ZJ31H9yQC7EfbIVFfyLTTQJxGeyJOR4MXejkMJtkGAf?=
 =?us-ascii?Q?WQrNEAvqhDYtgbnWrFkfa8Ho1ppnPlVSCTnTbE9wYMnO06sv5knwA6CB3zQ6?=
 =?us-ascii?Q?4X7TXm4UNmmdTtIVzITK6S+2Xo/VdaW6NSRo8NIJeSPQ7rlsBJIpc15+6QzC?=
 =?us-ascii?Q?DZWKZrH+9WuX35xNpeIY+7MLDZqRN6AwPxVWSQf383jlmzDdedkXG4raKC7V?=
 =?us-ascii?Q?UrauME7fs+IKI6IQIovKBYWDKxGTHCH6ubaFEU4kiNtkPL8XDco3J6oXEDT+?=
 =?us-ascii?Q?DoWHR7BDHUyDKKr3gPQLk5IL61gcrVIHKWLifxtzDV5BymOlf4vauV50yoPw?=
 =?us-ascii?Q?MFjwdYt0cHGoSry0CQz4sRhEhqLZ++hLJSk5J/StBtxGp4dpKh3f2/LHzylk?=
 =?us-ascii?Q?y+CDkXzSVyAAQDYQjqqT/n7Cm30pA/oZvcrGda/UxcvVRHx4RmwB8bUqFkjC?=
 =?us-ascii?Q?oPJP0gMmrq9Qguy16A/VOmjG9qACHzRSQMcQw9D98fR2sL5xfqqt7d1idVlx?=
 =?us-ascii?Q?ri5O7rkFvdbA0j3FFPAvhJ3n+bMTvASh0tmDJRszJRFGX9mktH0EbvGc3lDP?=
 =?us-ascii?Q?CzyBwHPq6Zy4/60QRkj6m1jJYBUhJZk1MTUV2oyhieAL6mEQhLzQ2oSw9Mi5?=
 =?us-ascii?Q?8XloXKh0iXA1PTNK7NF2UuaSpeu1NduT/dEMI1BJjuT+tIyRRz796xOR2N4h?=
 =?us-ascii?Q?2GaT4fVZ4nbUOOwVFq24T9mRVUzsfs71j8SR40BpmAdv5EJs2zjf3elNlYIO?=
 =?us-ascii?Q?zSXDtHS4S18CxUkHygWiecpP/qvM+6YXuO44LX33GtMaYJ1Gqhw8fwga5gqt?=
 =?us-ascii?Q?KKnf7BxprqDlR3mjpeKQo/juRCGn7WVFdIbt/YisIsY/2RflDu3VnAlT8Xhi?=
 =?us-ascii?Q?NWVeeE/M0FmTcV6ZPwTkDUuyZMd+JK4JUNSaSQ83wooXGIHWEuDxLpOhCwyh?=
 =?us-ascii?Q?UWGlvvllv/9xQZrYDgOKwqY8C30NjN7GTD8cJCLpd00vmFQmHFuGoUYoKHO/?=
 =?us-ascii?Q?7LJnRf8qY3HGZTtH+SVhunZc6PoP12ZUH9RoeWXyhN3ChJgA7d7zLoGQ1yFB?=
 =?us-ascii?Q?TmVFgbrUdXAiBzbRfw/pn2f4mi2O7Mm1gqemGVEwybZjkBabytmbo1iz/Fbc?=
 =?us-ascii?Q?c7gqi7hYCScrAxstA9I1iW4vKxudjbMcN19/ICtw21iUvNkTUmUJF1zfJEmP?=
 =?us-ascii?Q?dMfPkbUay7gQlic0q4dfCRieg44pTCu3MaDfLV675URN3aZFoCfCaBhJgeHp?=
 =?us-ascii?Q?mDBe9hHqD9VquCVTCuE/fnPuhn0mZroVriVEOzYBylHFS40kL9Vmjm1cCHQd?=
 =?us-ascii?Q?hjjCC3bxOdwQxn1+n2IQjknu8M9Ge4DfAibyLntr+MuaEMJ070F2RQBfAsiI?=
 =?us-ascii?Q?msGL6nJr17avfvVtJtWUD9cYLul6T6NQcaRreB6gSJdbYcDSoj4KScjmLHuj?=
 =?us-ascii?Q?DnCUdtnXXCgYqI0FqGkCdi2Cz/RNxnepGeQFBIb0rVzMoQNGTz1LmEscCJjl?=
 =?us-ascii?Q?FezoU/GM7Hcz08btOIvYlhmQuPltIlNUVr2MnEO3b6xT8d3PUrWtHjNKTPF6?=
 =?us-ascii?Q?gVdFei0jSsEH6lL4t+uOoQrhIIioKqFylPCRr27mlK8iHIc6H14j/9CzMaOj?=
 =?us-ascii?Q?hcazUY6vnSw8iY8MPQI10l0MPJmgM9TBqYjPt4UL9LrjcHBXLaMT6rF+z4Uq?=
 =?us-ascii?Q?epiV+awvtg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5797cb39-4e1d-4feb-98bd-08ded59e6f41
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 05:22:38.2550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ko9GDApJYSjRk2hILOpjlVrd4wMQS247+CkOVjU46lt0T0IWMhw49kasFPSEVnLFT5PjUXJdFon1+jJGbf8FJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8333
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 05:22:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23295

On 26.06.26 20:28, Quirin Gylstorff wrote:
>=20
>=20
> On 6/26/26 7:13 PM, Jan Kiszka wrote:
>> On 26.06.26 18:33, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This fixes an issue when building swupdate-config* for two different
>>> architectures, for example arm64 and riscv64.
>>>
>>> The reason is that both package are ARCH all and provide the virtual
>>> package `swupdate-config` which leads to the following error during
>>> installation in the rootfs with Debian sid:
>>>
>>> | Building dependency tree...
>>> | Reading state information...
>>> | Package swupdate-config is a virtual package provided by:
>>> |=C2=A0=C2=A0 swupdate-config-qemu-riscv64 0.2
>>> |=C2=A0=C2=A0 swupdate-config-qemu-arm64 0.2
>>> |
>>> | E: Package 'swupdate-config' has no installation candidate
>>>
>>> To be compliant with the Debian standard the conflict field is missing.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>>
>>> v1 was 'swupdate-config: Set DPKG_ARCH to any'
>>>
>>> Changes v2:
>>> =C2=A0 - set explict recipe name in image creation
>>> =C2=A0 - remove DPKG_ARCH setting in swupdate-config
>>>
>>> =C2=A0 recipes-core/images/swupdate.inc | 4 ++--
>>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/
>>> swupdate.inc
>>> index 00e972e..006d622 100644
>>> --- a/recipes-core/images/swupdate.inc
>>> +++ b/recipes-core/images/swupdate.inc
>>> @@ -59,7 +59,7 @@ IMAGE_PREINSTALL:append =3D "${@'' if
>>> bb.utils.to_boolean(d.getVar('SWUPDATE_SELFB
>>> =C2=A0 =C2=A0 WFX_URL ??=3D ""
>>> =C2=A0 # check for wfx url to enable support for wfx backend based upda=
tes
>>> -IMAGE_INSTALL:append =3D "${@' swupdate-config-wfx' if
>>> d.getVar("WFX_URL") else ''}"
>>> +IMAGE_INSTALL:append =3D "${@' swupdate-config-wfx-' +
>>> d.getVar("MACHINE") if d.getVar("WFX_URL") else ''}"
>>> =C2=A0 =C2=A0 IMAGE_INSTALL +=3D " swupdate-handler-roundrobin"
>>> -IMAGE_INSTALL +=3D " swupdate-config"
>>> +IMAGE_INSTALL +=3D " swupdate-config-${MACHINE}"
>>
>> Shouldn't we then also retire the virtual packages?
>>
> This could break downstream. Also I currently have no better solution tha=
n:
>=20
> +DEBIAN_PROVIDES:remove=3D"swupdate-config-wfx"
> +PROVIDES:remove=3D"swupdate-config-wfx"
> +RPROVIDES:remove=3D"swupdate-config-wfx"
>=20

I agree that it may break downstream, and we shouldn't no longer do that
late in the RC cycle. But we should do that for one of the next
releases. We could start by warning in the next release if the
machine-less version of the recipe is pulled by any recipe.

For this release, I've now merged the patch as-is.

Thanks,
Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

