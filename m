Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFDCC3064D
	for <webhook@archiver.kernel.org>; Tue,  2 Jul 2024 13:04:49 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.70])
 by mx.groups.io with SMTP id smtpd.web10.23781.1719925485741315003
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jul 2024 06:04:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=lsp2lLiZ;
 spf=pass (domain: siemens.com, ip: 40.107.103.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nra2aMXN9alECrH+mHaAQL/PcPKtT0Vkr92Wt8UzeFY5GahkWRh4GedMu2RRowagMo3HZEZTyZFDuZV4hOwrEJTsT0bKAKD6JBMja/GkybHAnq2vSRQEQalTI1COECScI5aIlFqAE8bMhcTm3q803J1BdXeqRp0th2zmYEpd/kogxBpfqJS6xV3I266hAKfQACfh/E9EQZ/snJlHHJR6C7528IF1/E+l+BpwK9ngERhC+epj9zLfSgXhjrH7FV4JA+cEnMBha6CgqBjMY4KVYUjIr3OEA4nLf1eJeXMSyumKidqP6GJjR5boq9mDNgk0I8DuE4TuSda5Kt+jHs+8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4HqdHdKPsvDPyHtYqEgtl/EubccSBJK49DiQDJFluM=;
 b=lpGdHu/5hsyHkxkB8fP/VWij8YD6DR3qrVdz25/lEeRvmO4KLgF9k4nAvBRNSbtO//ueK0cnYNkPasXhWGQCe1C0IAvGn6aFKz3M25nE7PU/3KjKPtf0OICtePW7OfuZ/zJbwOsQgtQCjOVr+nonSzW5CeDMjZtsfwGfvJrwo9R0+gz+5Y+dbZBAXeSR8WLbmwsXrmQG029nSBq7M8+i4zX+z6UdZNAvWlbUpVo1kXS805qPihYydc0T2Zb+UiMBMC/jJPblG7CewJgP+s8wV+ndypF6g2m8jEv8pQNthvbAem2pr3vVc4hqonZCGCK2lwz5VDi5zyFPIkpLbS+Jgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4HqdHdKPsvDPyHtYqEgtl/EubccSBJK49DiQDJFluM=;
 b=lsp2lLiZMIKqL8iJLXH03qpkwb0IO8/H0BWHWlX8+MEZdBiruUVULUx6D7BtjtjKijZ2621FkhdZQ6s5xkdT1yaN6ShtEfjA36n8PjTkejDY/q924SB5DAr+1wYV6dNAu7AiCrOhMV2UHroMJQGY01SHsDvuiBjmoDJEgDm4teLvSvzr4TjA6LLQoAONC9ZkyGSunxaPdS8LknhBzgYfYE/+oAM4z+14mxetPHxGoBPRLOdYnLsxbumLpLsQi/xIXA5UCm76ZSQED9agW9FAMfj2NcM5Wj7MxJiRpMta5B6lbXgyM6ToQn88YffNf0yGcAKkZjMQq/mplGzR3ep8uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4053.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Tue, 2 Jul
 2024 13:04:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 13:04:21 +0000
Message-ID: <16f681f4-d400-45ba-9d2b-1464cebb3b84@siemens.com>
Date: Tue, 2 Jul 2024 15:04:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] doc/REAME.secureboot.md: Add MCOM specific secure
 boot details
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
 quirin.gylstorff@siemens.com
References: <20240701064005.1651999-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <0fd02bc4-7ddd-4269-8915-f465d5f4d1e8@siemens.com>
 <TY3PR01MB11075CC2D445AA900D10E8569C7DC2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB11075CC2D445AA900D10E8569C7DC2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c99a289-1d3a-41de-4bf8-08dc9a977d8f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yJmYW6SrwcQerRFvcyIp3qhpeGY2vgAJIIjaO04fMGuZQcP4Gh6Nz+eHe3Re?=
 =?us-ascii?Q?Sd0WEx3U8DZA91A1zH6ldiDlwXcDMxxMe/ZNCsvQaIvWy8ArzASRO6WKx2m6?=
 =?us-ascii?Q?OLYGI2hW0GHxOCRI6q2OtUZ7SxMp3C9K+Q1T+VYhKjgRzAWS37zD8rBQtr/6?=
 =?us-ascii?Q?7AQrCesV2CZQY1tC2iFTBpbuhRI0fCTzVZ+ccH3PAk6TOC4JAPd0BtHD3I0D?=
 =?us-ascii?Q?1PeFvWggoFlzi3ltFx1AEdYSmUs67T8MUnDhdMvhH/VpONQ07C5yn8qUrFcR?=
 =?us-ascii?Q?eBayipEmzhrdFauhMXY09HmqZkSW8/eqjov/OWi+DJtL76oP4CHJ2SY/KL9I?=
 =?us-ascii?Q?uKADKG4GqJ4bKJ7Ool1fJP94CmBW7axyAtE5VYRLBNr7u43fQQezIlV4pqdn?=
 =?us-ascii?Q?vBnXNIhcE498iTF0LrdrmWByeggzpciI8BcYVGurPin2zCCZgjq2Ay+LttaQ?=
 =?us-ascii?Q?iJdlt4iMVItYcMJjOQXRrVcLcTrEFYBs0gyGqgd0Zr9Z3IK1ep546mmBuQwr?=
 =?us-ascii?Q?hzzhgPmOceI4pW+5g4OuPwczQ35AHgUr3cL/+E8c4yU4LwdIKUOC55rBdtoX?=
 =?us-ascii?Q?0dpwqjtIsYI5s8Ci0G69bPscYAz8LFeSTb2gehKzqDcFsshtz4+s4rtm/9nt?=
 =?us-ascii?Q?XIhsrXvxPbY8jb7y4XjtKcrJNL2FNu+0CVs1IF2vatoFdebbOUPtcqKJ1QD1?=
 =?us-ascii?Q?2KFdk/UE3p/pr1svKUj4WG0phbZoamGk/EEMd9Yd3xfYTuk06dFUqqHCNCLT?=
 =?us-ascii?Q?IU3yZ78AwN3r0XQrjtqjokXeY0Q6DJYdR1dzFpcIrjhiPg2nJfW4f69Vmqed?=
 =?us-ascii?Q?p1kWBOikmgdlqdPeJBi/bDIBr3uRWBGAac8WhyAloOMXtq65LXXZnn2FpQiG?=
 =?us-ascii?Q?Rd0ZFbuwwo7UuHUmgmuoYe5ls78WPwU2OZKt2am/aZFAClHk3mFwrY9E4UHd?=
 =?us-ascii?Q?/dw+68DcqK983bZXomZxfKaNew3IV35kRqNe+Z8wZZjMb6jo2EeX0ln4ppG2?=
 =?us-ascii?Q?E2jy4kF7Rgc8C/2AlG0sWT8Xu3V0c4vmpGcp7KCp8Ji6lKfwTaDNGS7K+dPT?=
 =?us-ascii?Q?LscvGqDOAfZ5JLLa307YXiry132rO8fypRk9iJOiEwZFPE8iC3b8iiTqHHDQ?=
 =?us-ascii?Q?DnjRizn9xejknpYJksfHGowyP+o+d89UAygeFqfe52hSDQFeqR0ImrYBcT/z?=
 =?us-ascii?Q?v2yetlM9g5dZQHNfPd1UHzO6uD0iN04INycyZMEi0NtGACkbncjl+txni58u?=
 =?us-ascii?Q?kxdhKZUtG3Ny37qnnbQuWZFR7seekADoS26cfVkDKPJSxBaAMwTnlvl2hd+O?=
 =?us-ascii?Q?/sM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ldqlXqTW1UY2H3WkclU6LC0XzIzvNk66Br13Z+5LFbMSQovwn3M/b93ZuK8i?=
 =?us-ascii?Q?eyZU+cvo+AXnBs7KwE2rzTMKwOPZf5LClPXUteQ70ESyddKBFAT+uT18RW4r?=
 =?us-ascii?Q?G3+WI355gTQoJunD60F1+UkK5gLYLO9ZLLGriGjsLKG91P6U444Fxd2VvI1q?=
 =?us-ascii?Q?rDd7vPhluyJJSeVfb1NAhOn6JBvXCHsiH+cBpSY7BnRLPuCZmNIdYPNAjeiK?=
 =?us-ascii?Q?HXRmM9u5cLGp8aQ89RHRTaKh5pH4rHx0GeRkKgn152kx3A+7YKbEVDwkl972?=
 =?us-ascii?Q?qGXJRPaURNf8r7e6/otjNFyeMb38oCcSIb5XW7BvGwrH+XVO5DkjpeL88drb?=
 =?us-ascii?Q?t3XNGVcOpZGUE6ebStKEDjDAHb/HwxVjNzd/msE3GHrWPBlLBm4Wi6u0ooN+?=
 =?us-ascii?Q?rgvI8JT3dWWZJtXnNl4c4ifWJzCgbFLcBbVoFtmlR0XCBzeA7jHBX2eLpGu3?=
 =?us-ascii?Q?pIunq0c7eYK03Ro2LPEiz0YH2Hk1uG5rd7c/agKOs6TWMSstJvvKe6p8ISBz?=
 =?us-ascii?Q?fEAmtJNyftQvmmIWfxy59u3lfRHX25m2KQxVsK1o1MJT+enyFm1sbO4hTB4Y?=
 =?us-ascii?Q?lbqS7N7Mr4QAb9pmdx+cCvLxiX3tztQ4uhMa9C9XmCou/dZbYxrz5DsFxEg2?=
 =?us-ascii?Q?VcJf0n2AeMcAxgDX1OzO4f6JJyr+drQRDoNIBT3tMVk4aEFxNl2MUgTvSp+k?=
 =?us-ascii?Q?gEyQkg1GQGLvRVfq0rLGnRnbtEfebzf61YhU4XdZYRK72Q8G4C2XVi14TMNr?=
 =?us-ascii?Q?DTYFttRo6NmcVvT3JJVZkoHrYRx+iiwLQ92pQFbXRrHRkxdONvLvVUTKD1+W?=
 =?us-ascii?Q?O7emDLE9NqotMYC3MnHGGbl0xfTUbe4+ZVSO2dYjkJ5O2Sun1RAzNkzSiHIo?=
 =?us-ascii?Q?on0MH9nT6eAXl6n9eE61F8GmvXbo/uKDYFy/2V919qjAKFsDGuLV3/zi6bht?=
 =?us-ascii?Q?cCxE+2kBXROkmkGehePhwtJmKIGkbcL44gtAlSGGLnw3ck3asbuqws026yK/?=
 =?us-ascii?Q?/64p/QfMzEfNiVAggKFsl4rGYvIpJtW5jKXUFk3RgmBpqUd0n+jxePhOntq7?=
 =?us-ascii?Q?L/abrpQcHyq7S9AbZVbUvd82K9vKMkq3cu21/Smq5yQ/MTRwmCfY0cg6H4NN?=
 =?us-ascii?Q?GMDqwswUjcYDf8Ntqv8bvuzzFi5CCMEiEGs9xH3wpDOEX8s2xBHV5gbK0Ucx?=
 =?us-ascii?Q?n5wTg26+5k4+Of8fxWdLAO/y5v016uIbDMU7vWnU5Ob8f51hEZjdlOkVgbWS?=
 =?us-ascii?Q?azxTC0kwauHPSMLGKCZrBDDEE4lCR7mc2Ddcfdg7+Er/+BSdpGdU3aCzstDs?=
 =?us-ascii?Q?llNkeB3+rIdBCXvM7vFIUsazbucvJ2tH+06R9X9ETdt/ltg5E8Z9xfZslI4e?=
 =?us-ascii?Q?GGKWhz8Ig0/lDxCd1/rauymlBm4C08odAoHZtGO+nBFw7ru28JOIf6N7sov+?=
 =?us-ascii?Q?aoT0gJ5pe0LA/HSFkcvd4Lnwsg6zwnrCsknfqcoWvuo+JNvAyj4J53r2PeGk?=
 =?us-ascii?Q?okLfjFveU8xZPrONqgL9WUkH6b+aqNE6QlulJStUBNhW77QOjOawcRDj4Q6t?=
 =?us-ascii?Q?oTRaRo3mbL5J0insB9V2z71KhzEC5TLcT3lgBi8ooBr+hQ4zzSdw0STtTnrD?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c99a289-1d3a-41de-4bf8-08dc9a977d8f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 13:04:21.7958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qu7V7m0MWbsnQ4zf/uzUUrmcckVrgytGUWPFggRyBiECbPTGDHcVPQJ8PTQ6Ae7GIVujSXXOUS5RZRqV7s9LJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4053
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jul 2024 13:04:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16360

On 02.07.24 08:40, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan=20
>=20
> The changes that I have included in the patch file are specific to M-COM =
device. The steps may or may not be same for other x86 machines. =20
> As you can see there is separate section for M-COM secure boot which expl=
ains about enabling secure boot, injecting keys and verification part.=20
> If someone who is new to M-COM and if he wants to verify secure boot then=
 this kind of detailed steps are necessary I feel.=20
> Also these steps will be helpful for BV members if they want to verify se=
cure boot.=20
>=20
> I understand that the current secure boot README is generic so, we have t=
wo options now,=20
>=20
> - Create separate REAMDE similar to iwg20m[1] and keep all M-COM specific=
 information    =20

If we really need to document these partially obvious things, they
should go into a separate file, maybe doc/boards/README.m-com-x86.

> - Extend the pdf document shared by Benjamin to include secure boot relat=
ed information, but here maintaining and updating the pdf file is slightly =
complex. Also we need to check where should we keep this document. =20
>=20
> What do you think about these options, please let me know.     =20
>=20
> I have also added an alternate option for keys enrolment using KeyTool.ef=
i with detailed steps. I feel this would be fine in the current Secure Boot=
 readme.=20

As a workaround, but I would prefer some automated key enrollment over
READMEs mid-term. Everything except for the BIOS settings to enable
secure boot can be automated, via UEFI or via efitools from Linux.

Jan

> Please let me know your opinion on this.=20
>=20
> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/d=
oc/README_iwg20m.md?ref_type=3Dheads=20
>=20
> As you mentioned about generic installation stick, right now I don't have=
 much idea on how it will enable secure boot (basically BIOS changes) and i=
nject the keys to M-COM device.=20
> Once we have that generic installation stick ready then we can think of r=
evising/removing these M-COM device specific steps based on the situation. =
What do you say?  =20
>=20
> Thanks & regards
> Shivanand K
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>=20
> Sent: Monday, July 1, 2024 1:17 PM
> To: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Po=
rting) <Shivanand.Kunijadar@toshiba-tsip.com>; cip-dev@lists.cip-project.or=
g
> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) =
<dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=
=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=
=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhi=
ro3.hayashi@toshiba.co.jp>; Quirin Gylstorff <quirin.gylstorff@siemens.com>
> Subject: Re: [isar-cip-core] doc/REAME.secureboot.md: Add MCOM specific s=
ecure boot details
>=20
> On 01.07.24 08:40, Shivanand wrote:
>> Add separate section to configure and verify secure boot on MCOM device.
>> This section includes the detailed steps to enable secure boot via=20
>> BIOS and inject keys using Keytool.efi and finally the verification part=
.
>>
>> Signed-off-by: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>
>> ---
>>  doc/README.secureboot.md | 85=20
>> +++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 84 insertions(+), 1 deletion(-)
>>
>> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md index=20
>> 3ae4154..7917207 100644
>> --- a/doc/README.secureboot.md
>> +++ b/doc/README.secureboot.md
>> @@ -322,7 +322,28 @@ The following keys need to be enrolled onto the dev=
ice:
>> =20
>>  The enrollment can typically be achieved with the help of
>> =20
>> [efi-updatevar](https://manpages.debian.org/bookworm/efitools/efi-upda
>> tevar.1.en.html) -on the device. Otherwise, consult the manual of the=20
>> specific UEFI Firmware.
>> +on the device.
>> +
>> +If the device supports built in EFI shell then the enrollment of keys c=
an also be done by KeyTool.efi tool like below:
>> +
>> +Format the USB memory stick
>> +
>> +```
>> +host$ sudo mkfs.vfat <usb device>
>> +host$ sudo mount -t vfat /dev/<usb device> /mnt/ ```
>> +
>> +Copy the KeyTool.efi binary and self signed Secure Boot keys to USB=20
>> +stick
>> +
>> +Here the folder "keys" contains Secure Boot keys(DB, KEK and PK).
>> +```
>> +host$ sudo apt install efitools
>> +host$ sudo mkdir -p /mnt/efi/boot
>> +host$ sudo cp /usr/lib/efitools/x86_64-linux-gnu/KeyTool.efi=20
>> +/mnt/efi/boot/KeyTool.efi host$ sudo cp -r keys /mnt/ host$ sudo=20
>> +umount /mnt ``` Launch KeyTool.efi binary from the built in EFI shell=20
>> +and follow step-4 from the section [Add Keys to OVMF](#add-keys-to-ovmf=
) to inject Secure Boot keys. Otherwise, consult the manual of the specific=
 UEFI Firmware.
>> =20
>>  Use the recipes [secure-boot-key](###secure-boot-key) to provided the=20
>> keys  to the signing script contained in @@ -334,3 +355,65 @@ During=20
>> building a efibootguard based wic image the scripts contained in  the=20
>> recipe ebg-secure-boot-signer can be used to sign the bootloader and =20
>> unified kernel image(UKI). If the keys are stored in a HSM the script=20
>> can  be exchanged to sign the artifacts in a more secure way.
>> +
>> +### Secure Boot configurations and verification on M-COM(X86)
>> +
>> +**Note:**
>> +* All the steps are specific to M-COM RT X86 V1 device hence consult de=
vice specific manual for other devices for Secure Boot verification.
>> +
>> +Copy KeyTool.efi and UEFI keys into USB stick as mentioned in [Secure=20
>> +boot key enrollment](#secure-boot-key-enrollment)
>> +
>> +Insert USB memory stick to M-COM device.
>> +
>> +Power on and Press F12 key to Enter BIOS setup.
>> +
>> +**Note:**
>> +* if you want to restore the default BIOS settings then Under "Save &=20
>> +Exit" tab, Click on "Restore User Defaults" and select "Yes" to restore=
 default values.
>> +
>> +Enable Secure Boot and enter to Setup Mode by following below steps
>> +
>> +**Note:**
>> +* Due to following step, old keys will be deleted hence it=E2=80=99s re=
commended to take backup of old keys to avoid any data loss.
>> +
>> +Under Security tab,
>> +* Enable Secure Boot if disabled. The System Mode will be "User" by def=
ault.
>> +* Click on "Reset To Setup Mode" to remove existing keys.
>> +   Select "Yes" to delete all Secure Boot keys database
>> +* The System Mode should change to "Setup" once we delete all Secure Bo=
ot keys.
>> +
>> +Under Save & Exit tab,
>> +* Go to "Boot Override" and click on "UEFI: Built-in EFI shell" which w=
ill launch the EFI shell.
>> +* In the EFI shell, run KeyTool.efi from the USB stick and add all Secu=
re Boot keys from USB. Follow the step-4 from the section [Add Keys to OVMF=
](#add-keys-to-ovmf) to inject the Secure Boot keys.
>> +
>> +Exit from the KeyTool.efi and built-in EFI shell to BIOS.
>> +
>> +Optionally you can confirm the injected keys like below:
>> +
>> +Under security tab,
>> +* Click on "Secure Boot" and then "Key Management" to confirm the injec=
ted Secure Boot keys (DB, KEK and PK).
>> +
>> +Under Save & Exit" tab
>> +* Click on "Save Changes & Exit".
>> +
>> +Now the keys are injected, remove the USB stick.
>> +
>> +Flash the Secure Boot image to USB stick and insert the USB memory stic=
k to M-COM device.
>> +
>> +Power on and Press F12 key to Enter BIOS setup.
>> +
>> +In the BIOS, Configure the device to boot from USB by following below=20
>> +steps
>> +
>> +Under "Boot" tab,
>> +
>> +* Select "Boot Option #1" as USB device from the "Boot Option Prioritie=
s" section.
>> +
>> +Under "Save & Exit" tab,
>> +
>> +* Click on "Save Changes & Exit". The M-COM board starts to boot the im=
age from USB.
>> +
>> +After boot, check the dmesg for Secure Boot status like below:
>> +```
>> +root@demo:~# dmesg | grep Secure
>> +[    0.008368] Secure boot enabled
>> +```
>=20
> This does not scale if we have to add a device-specific section to this f=
ile for every reference device. Can you write this more generic what was mi=
ssing in the setup guide so far?
>=20
> And for the deployment process, we really need a generic installation sti=
ck. The manual steps should already be described, though.
>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Linux Expert Center

--=20
Siemens AG, Technology
Linux Expert Center


