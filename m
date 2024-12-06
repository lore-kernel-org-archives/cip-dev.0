Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC832E7717B
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 13:54:41 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.59])
 by mx.groups.io with SMTP id smtpd.web11.37068.1733493276016759674
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 05:54:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=e/wrwTtQ;
 spf=pass (domain: siemens.com, ip: 40.107.20.59, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZl8eRrTRHxSAxRP6hcGlmeXeQ8IcHDsNUj2/E7jr4yVLg7e1DBPkvBznO36EoHlFLS7cJSGjujENAYVtHAa2LvLQvyUnP4RoorOCqsoU3WTtYb2NglNvtVONFQCrowDsbL/VtevNhRq9cOMHhrh1M2vh07/mT4OzlngywYD/1FAVMKKz7YWXZmJ+VyAVyUBtLpRq3HGTUDHTWPaLZz/bHx1RMoq3r7ywIGmixSdlk0MK2A6S+OoLvJgzilQUKbBASXoQu5MJbzykFeUprL+IwFKV7Bk5YvQ4c3AGFb1Mk6x1+9tzvNI/y0zZW5MVtOC7jArr9FwUFbreMCggi1o3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeFmWGcMqt2Tad1eh69ZY+Rv+ZyAQ0TcJtgeakmb2VA=;
 b=ooeZE4D3p1gbe9PsI/k2XBoX0h5BtZig1Hsjsi/3b9fXoXhYH7hraN4RlZdO4fL7ub3a/9ZaZ9ZQ9lbbn98OBn6xVqgjwta4cuz46dXWJY9OyoYVKkzBNJGZnsCo1x9AFgIl5cpXerTThdAxfwG8LmkKgpxgk481y5RwCUfptstgQuX5NJSYOdmPsOT8Fr7yzN8YhcoV0FWulu88zJabeYrgzWT7Wv/rpO/zS2x2L5zpraiKjOHtT98VcoKGf6d3nwRLNdGJlUyRInObWAJCVUDXCRPyX+/vjEP9O4JE1zi+7h5+T5xqUihXwGwoYnP8vYfbC49wY3dApdZ5p1fmeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeFmWGcMqt2Tad1eh69ZY+Rv+ZyAQ0TcJtgeakmb2VA=;
 b=e/wrwTtQUpAtdD8nO57fsEQx/R8j4z8ANckVyNJLc1c0JeqIgT6Hh4B0MzXwtpiBqD8ppmWC/Tlclv1pSe+mMX9MkL8Ii+viGIqPk/3RTCkUYqE+QRHaXS8S67a6a/alYxwpKvzw1diRY2g5SkP4XfwQxQZ9cUZ/LRpiV0b0wFmtl4iFf3MqEcEn0Kmh5CEBx8Lc9RIj0tlWFR8X+7dN0uVnXmZABL5G+3qN5UuEn8gRNWzlmt82pIIqsg4ymKnr+w8piQNp5t5+3+k56IGZ3sKYIXFTQev0rVCMQrUcoYDymuGdrCE2MY0RZ+/oPwBABB4TPP4k7L3uBdg5OHObhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAWPR10MB6784.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:338::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.8; Fri, 6 Dec
 2024 13:54:32 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.8251.007; Fri, 6 Dec 2024
 13:54:32 +0000
Message-ID: <36bbafe0-518d-46e1-8921-ef52c8036a6e@siemens.com>
Date: Fri, 6 Dec 2024 14:54:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Booting security image (.wic) on M-COM x86 in LAVA
To: cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
CC: kazuhiro3.hayashi@toshiba.co.jp
References: <OS3PR01MB6103FB47A8576B2CFA3275F6C2282@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB1240202744B87D2E939DAD687B7282@TYYPR01MB12402.jpnprd01.prod.outlook.com>
 <OS0PR01MB6100DDA81973DC6533408914C2352@OS0PR01MB6100.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <OS0PR01MB6100DDA81973DC6533408914C2352@OS0PR01MB6100.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::21) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAWPR10MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be6d6c7-906c-42cc-0e52-08dd15fd8310
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|4022899009|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yFRHJ0JRJZnpUofcQcbWrydcY6J6iALT8Hhz90PJVpZ6rDMj0H2zGdMstoOV?=
 =?us-ascii?Q?2pKWxVNdevCb5iwp2F/vG7Ki5uu4myLrtn/3tFGI8uDlwaK1AaEu6pMnIQDJ?=
 =?us-ascii?Q?g+RycBP5h4RMIJI5Ax1FcAWjpR8DvEUzmdNm1JwY259ZlreDiNUX69FjXr1o?=
 =?us-ascii?Q?79lKkvyVYBqDk+1cy5Tu+xdvgKK3ixxs4Pm6CMi/0nR+1CWi2tMmZsnfFm0o?=
 =?us-ascii?Q?rZK5rNtOk/TZQ6W9Sm5jWYf9YuNq0TBQ7rdHyMxs8Omn88JRllsAWrraDEjd?=
 =?us-ascii?Q?mFyIwyFDpJZGRe0xNGx+96klZZ284SfH/qxwJjzUQwvkaAYlHADM5SIW+4B8?=
 =?us-ascii?Q?9Jba320Bh2JGpN5EJGCafHt5uau2FEY+V6+ICMrujdqY6M8BhLJmp6ko9HBj?=
 =?us-ascii?Q?hkDp1rMYfZd+vPyAPqIgxwlB/U/51iaO38Hry6xukMqjhKVxg9zatcQEvab6?=
 =?us-ascii?Q?JBrmwqi2olWo+MGpdZYK7Fn1fECoHheVgWUKqW8jw3Qxnv1a6Xwyc15JvPsV?=
 =?us-ascii?Q?FwdI1xRPSIbKnhDq56wbGD8qdAYQzDJzjwWhSNq4JQ+PnaiorgaDP3lp8Srb?=
 =?us-ascii?Q?v6Ie79m4LIPNGfEZooubEhzM5YFOjCzLsPHZjWTQJlO4gLy29telb8f7pMss?=
 =?us-ascii?Q?FSfJuCnMq9cNp3gr38+aFfyrUJHsxjx+vDiFJHdwlCxKXe5Y8C3ZHSMun8Rr?=
 =?us-ascii?Q?QpEiTQb2tSQTnhH1AZlEN9VJJcJUs09Nq4cqIOBmYGyIH+b1ovWaD/YqiewX?=
 =?us-ascii?Q?nilXPPlwI6BVJonbXFluNEZCc/IRzvR3cbBk859mTb8TzQu11krNJ8WWJ9WC?=
 =?us-ascii?Q?hfX0GcC/+TmPtnAUYvVh8T761RmcEZa6fYGY2sOx74OhRGn8+cneSvXd/TPy?=
 =?us-ascii?Q?ousVxFT8+rwBX1hB0pZ2Vr+AAC2R9s5UUrO4O3q9qElHw/Nqn33LFiQMoQuw?=
 =?us-ascii?Q?qLGtN+blDxxK/kXUOpZv/WnYKa5IZ9Jn7tiG+N7t+t34sHQO1nB1cS7/ljPu?=
 =?us-ascii?Q?GwZjPUjDlFnTiTar6lnXYrJqkvDoP0g/Ny187ItmU8lWkfV1JJmQt5asHGJG?=
 =?us-ascii?Q?O4p44KvrvILhC61/buHYmGuFa9FTK63EVtJzpOS/V1QQ+5HT9kI+SU7fz5ay?=
 =?us-ascii?Q?42WoHFOM0w7/exXCCn7H4FzHiq6y2N94QeuKe530KbL22kXZO1SX/X9uBFuz?=
 =?us-ascii?Q?3408ys2F2dAmchmuydiQyQ17r9AA7EoP8lDmm0tcEQoQmBOyqUXZpmD3EVoa?=
 =?us-ascii?Q?fC3huboZtZVfS23u21PfWqBnjehq0GCkAVenUNca2tTnkLnwLHz1gnOHYDrj?=
 =?us-ascii?Q?KKM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(4022899009)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?njUwod9LrUGk1vK/ZQg79QUOdN4jPaPaaT8s0ozKWQ6vswM8oe+wGCqFsNrG?=
 =?us-ascii?Q?GuWt96QE5vNBrywowQAQAV1LRpvuCFarW/VfE3ralEQPkUgjwJ0CsLj+cN0A?=
 =?us-ascii?Q?9+DlEjwbMrKbPV1i/KlbXp18RY8y+ByBX5tMOODgV9inBfaC5xLvjKYkgyg8?=
 =?us-ascii?Q?RduyN8NM+RnfXBfX7o8ySIf29OUNdAuKw2dqfBlwRJaPl5pMxJKkVofVQ/XK?=
 =?us-ascii?Q?tr6Rc0dEDy9WmXXW3uar13kdFeQZ5iywXqDywpdCD5knpmKkR04U2MGuKwtM?=
 =?us-ascii?Q?HwpmdJMKFO4hoNFldz8DqI9slxL4GW9oTAmIpISyWtKB1wuHasuk0QltE107?=
 =?us-ascii?Q?pfFRr2pE8aEhBn3AP7sZD+tqBEmdKfX2k46qkErQ7hVZW6vm6pwt5WTWLozE?=
 =?us-ascii?Q?rKHrrvXozomW3nFcL8oPyNnDrR/EmwKzCjPDh8muo0Ipg/g72GV+6XE6E3Lq?=
 =?us-ascii?Q?MvFG3EBYES2IEaEih0I4W0BU2l2bLT+EpjzoMrE72QMb8w0bSzfGyEg5HHdM?=
 =?us-ascii?Q?vf4no6P51G37XaqPRatkznlI/39pizsAT+9JPfonG2yP0CDpe5tM05L89unD?=
 =?us-ascii?Q?TZRLk2AGy9hVSDEGDiqIxsmne/jUWyGLo563zr6BtjhTON6Mv6pQK+nNHNk1?=
 =?us-ascii?Q?lnsy3w6o2Rev7Obl4iYNvTlJ8e3CzYor6FPLouJw0ssCCifeQJX6scRIuMmV?=
 =?us-ascii?Q?AhIwHkbJsKQoM1lv2I54jC6JS/ta/CsEbsa9+xdGKDudaaz89ijmffhYTZl2?=
 =?us-ascii?Q?LM48S0OmydVucN+fjxNEsiIqaWd8zG5EfmO/EarrdghlfKLpqvOjeF8qRZNO?=
 =?us-ascii?Q?tAGosgDbcqohv+uguY06xISjawqs9IQb0a5ZI554tz137DDHuYlMA4g5vmyx?=
 =?us-ascii?Q?okTzUbrXRinmh5Hs5oMdQ+3nB+B/mWy54fUW6TZd2OdR/UXV7E7AK74b4UGf?=
 =?us-ascii?Q?/X+ZZ3Cfl3FhLgJl+WbHQ9woJArQBLtsfFiYS4PKWCCv8G9lzJejLH9PM2/J?=
 =?us-ascii?Q?8hHJE6NqmxF0py22i1yxnvaTBxqf3DhS5FXtUdHNSzY9evdh12GM6ReCfNGI?=
 =?us-ascii?Q?fFJoVkUd6R0vBJmRms03MqBghAMRUDLJZ2w/RqPBrs+UkHT5RNLTiBGtqPpf?=
 =?us-ascii?Q?dZmEu6K2fnN9sn1PQGHengAHmr6d/biZ4Q2JYpqEWWvzRZDYCn5o2D7JvJwC?=
 =?us-ascii?Q?1LPPlMr0bQb/ng5yc8qkkdK21AW3QC0/GxCu2g2pv9OOzlRhBWUsUyMeJ0Xx?=
 =?us-ascii?Q?Vy0umQMgEyY9LBuq22JI9peArWbSVRCKHazdGzToshdvboxyDTxAlswuupp6?=
 =?us-ascii?Q?/gF2YMIgXgWvdNe0J27cWy8VHiJSaK2qwKWEtYn8UZAuchHC/xQU3eAbey0a?=
 =?us-ascii?Q?EeDAqzth5BkzWBBSMkELSBFJZRMKlcB3GGbBNQahwdLqE6HuJyXtdKJVOotr?=
 =?us-ascii?Q?9/+n5tiKEh2QrH1qCmx/IhrlRBS3kFt0u57jeQ33UkImcn+ICr72+09VTncQ?=
 =?us-ascii?Q?lZiJkTanbj6Z6VEQzgK/BuEswj04ZjPb+5Qqlb+/meTqU1Uv9dXh51dC0c1I?=
 =?us-ascii?Q?KLNyJhXuGU4rlp3i+IxSCxEHvNQAfuGud0uFpAy34eRLfpAl5oXI/DOeylbX?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be6d6c7-906c-42cc-0e52-08dd15fd8310
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 13:54:32.8324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5Cm6J401yMLzeE2filGPdJRsGWNFwnNZECMawUGtPwoBNDZTm90bWiJm0Puzrt/XwPpAAkIgb63gZktMWlBkcrz13z2yqMsbVQW45/Wpdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 13:54:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17368



On 12/2/24 14:30, sai.sathujoda via lists.cip-project.org wrote:
> Hello Chris,
>=20
> As of now, we think flashing to USB and booting from it can be one=20
> option as I did not find any eMMC deployment methods in the=20
> documentation. Need to check this further.
>=20
> As you said I saw similar discussions in lava users mailing list where=20
> they suggested to first boot into a normal system and then flash the wic=
=20
> image into some sort of permanent storage and then rebooting the device=20
> to boot from newly flashed storage. I will go through those discussions=20
> to see if we can get any leads.

That is possible with a special installer image which flashes onto the=20
internal storage  - I don't know home many cycle the emmc has.

Internally we use the mtda[1] for boot devices during deployment and=20
then do the normal testing. which remove the need of the special installer.

> By this statement *"We could duplicate the amount of hardware so that we=
=20
> have some permanently configured in secure boot mode, and some in=20
> "normal" boot mode.", *I believe you are referring to multiple M-COM x86=
=20
> devices connected LAVA Lab, but I am not sure about that.

I would also suggest additional targets for testing secure boot and all=20
other test on normal targets. As we need to prepare the target with=20
special testing keys.



best regards
Quirin
[1]: https://github.com/siemens/mtda/blob/master/docs/integration.rst#lava
>=20
> Thanks and regards,
> Sai Ashrith
>=20
>=20
>=20
> ------------------------------------------------------------------------
> *From:* Chris Paterson <Chris.Paterson2@renesas.com>
> *Sent:* Wednesday, November 27, 2024 6:28 PM
> *To:* ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@to=
shiba-tsip.com>
> *Cc:* hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=EF=
=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=
=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)=20
> <kazuhiro3.hayashi@toshiba.co.jp>; cip-dev@lists.cip-project.org <cip-=20
> dev@lists.cip-project.org>
> *Subject:* RE: Booting security image (.wic) on M-COM x86 in LAVA
> Hello Sai,
>=20
>> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
>> Sent: 27 November 2024 11:08
>>=20
>> Hello Chris,
>>=20
>> We are planning to run software update, secure boot verification and IEC
>> layer tests on M-COM x86 device in CIP LAVA.=C2=A0 To achieve this we be=
lieve
>> there are two main challenges.
>>=20
>> Booting a disk image (.wic) on M-COM x86 in LAVA
>>=20
>> We went through the existing job definitions running on CIP reference
>> hardware on LAVA to re-use if any disk image is being booted on them but
>> did not find any. In every job definition, the root file system tarball
>> and kernel image are deployed separately to tftp. We are going through
>> LAVA documentation to figure out proper method to boot=C2=A0=C2=A0 entir=
e disk
>> images on LAVA.
>>=20
>> Can you please provide your suggestions on how to do this, if you have a=
ny
>> ?
>=20
> Where do you plan to flash the wic image?
> What does it include? (bootloader/kernel/rfs etc.)
>=20
> If you are flashing the wic image into some sort of permanent storage I=20
> guess you could boot into a "normal" system using tftp/nfs etc., flash=20
> the wic image into some sort of permanent storage and then boot again=20
> using the newly flashed storage?
>=20
> Maybe the USB or SATA deploy methods could be utilised?=20
> http://10.226.36.177:55555/static/docs/v2/actions-deploy.html=20
> <http://10.226.36.177:55555/static/docs/v2/actions-deploy.html>
>=20
> Perhaps this use case could be of interest to others and new deploy/boot=
=20
> methods could be integrated into LAVA.
>=20
> If an SD card can be used as the boot medium, another option is to use a=
=20
> tool like SDMux. This allows flashing to the SD card whilst it's=20
> connected to the LAVA worker, and then switch the SD card to be=20
> connected to the MCOM. I think there are also USB versions available.
>=20
>> Once we are able to boot a disk image, then next task is to boot a
>> security image.
>>=20
>> Configuration of BIOS settings on the device's firmware to boot a securi=
ty
>> image
>>=20
>>=20
>> Basically, CIP security image has secure boot feature enabled, so before
>> booting such image there are some settings that need to be done in BIOS
>> such as:
>>=20
>>=20
>> 1.
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enabling secure boot option
>> 2.
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Adding secure boot keys in EFI=
 storage.
>>=20
>> Only after these steps, a security image can be booted on M-COM x86
>> hardware. I am mentioning these steps based on our current experience wi=
th
>> local setup. But I am not sure how to achieve this on LAVA.
>>=20
>> One idea is to pre-configure the above-mentioned settings in the device
>> present in lab-cip-siemens-prag but in that case I believe health-checks
>> and all other tests running on M-COM x86 can boot only secure images.
>=20
> This is one option.
> We could duplicate the amount of hardware so that we have some=20
> permanently configured in secure boot mode, and some in "normal" boot mod=
e.
>=20
>>=20
>> Is there a way to change the bios settings through some arguments in the
>> LAVA job definition ? If not, then can you please provide your opinion o=
n
>> the above-mentioned approach.
>=20
> To be honest my history is almost 100% with Arm devices, so BIOS isn't=20
> my strong suit.
> If there is a way to remotely configure the BIOS over seral then it=20
> _should_ be possible for LAVA to do this configuration. It may just need=
=20
> some customisation work done.
>=20
> Perhaps see if anyone on the lava-users mailing list has any suggestions=
=20
> for either topic?
>=20
> Kind regards, Chris
>=20
>>=20
>> Thanks and regards,
>> Sai Ashrith (T S I P)
>>=20
>>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17306): https://lists.cip-project.org/g/cip-dev/messa=
ge/17306
> Mute This Topic: https://lists.cip-project.org/mt/109804627/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/175364=
0/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


