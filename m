Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F220C30658
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 07:33:46 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.78])
 by mx.groups.io with SMTP id smtpd.web10.12246.1720164823628919381
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 00:33:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ZjCE1RC0;
 spf=pass (domain: siemens.com, ip: 40.107.241.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5UfddZEcAeoHnJmZsjqh7oAsaokgmHZAMHpQ0mdS8Rti7iZ/sg3okllfpMwpsBFmHEjK7WErZw9/R+AyYYyBVt5gWiHXStAxlXGDM3I9wipkxfDIF9efn2WjOP6aTsJPN92bvoE/iYCRNZl783SrXlupzNYMFTWgBZMawlqB8J6gFYPuaT2V/xlF2zqGejRSad2b/+MfcHLWWgKTpZ4NQFttPTE7J61WBxueVqHgi/uTDHl02BzwN4LBeNIOOMm5nXVwKryxDAanrCjkAGecRli2i9yphkFZ6P/NeZZ6CRUnLAnsb8/+dgDqaA88RURLdIHcPw/htUA6EmWCBxoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgv3FEIRAORmPcBN+PXzwtVVHS1SDB6pwqYei/PkxCA=;
 b=J8BLOFXXTD2NDFuW5bpHY9hIbXq7Q4uDPfET8rElnlZM7bC+kvaA+iXJynDvxVIYDEQc/vIYxwaUatMfp7HIheXorZGJ8d3NI42SQjqAsusEu97G7PNJjiT2sGcH7/EtKKrwNvMA2ibY7V/rHojYV3p6SFBJoboUT8a2uqbhjIMlKP11GmDoeG5GyAyexraI2weD1f1cdHnnPlodv+t/jJBeaIZAbpCEy3NqtNq/khl1u9shoqiNxZvxfamIpNYTUFbJrKjjbTSN5Z5Sa2tZd7NfvUmjrgN+wzpNrxlMzskC1re1c9vFhZpw1Md7lamxmYxeKxKr9xu3AiiXP2fmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgv3FEIRAORmPcBN+PXzwtVVHS1SDB6pwqYei/PkxCA=;
 b=ZjCE1RC0avQGwUlJO4WqxcP3vfOnPA2L4eVGti47Wgb5LUYB4+8CRp/Jt+PMzO6hKXR8rt6EO0Yp5n79heQn3t5VA80Iqd1HhtlwkylnvxsWVY6imvJZP7irqHM2F45fs5xoktfdHryVYGnfgZ0PPRgNWlo4znwRD2EYj4BtBc5W967MQwMEwhvidTIrySxAfvLKYt54Q9R8qfpPgPnFg/v8swUbjb0ZXqfZlYdf0iYoTP3Bo6ZXjZoU+Ee7Qt6GNJxnll5qAI5bUNfRxXPAACfx2t2kLXLbU3iVQNVGDEt1R3HQPoDh1vknLpeaWbLD+hV+2f/kRNP3a12POMx4Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7130.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 07:33:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 07:33:40 +0000
Message-ID: <59266e26-b615-49b9-8826-935a5fa56130@siemens.com>
Date: Fri, 5 Jul 2024 09:33:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core] Kconfig: Refactor Kconfig options
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240704091803.3250609-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <68a430ab-afc1-4594-847d-bd823d44f965@siemens.com>
 <TY3PR01MB11075ADF741232B7FD668B5C3C7DE2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <434ca8c8-b1c6-4fee-8838-ee052666221b@siemens.com>
 <TY3PR01MB1107571B579722017185157BBC7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <ce96a45d-edbb-4401-842e-93117ab1f9cc@siemens.com>
 <TY3PR01MB1107551C9D25C7CC82540F20EC7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <6845d328-860d-46eb-90ce-b994da7c3508@siemens.com>
 <TY3PR01MB110759B742A4217C518ADA6C0C7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB110759B742A4217C518ADA6C0C7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b07f766-6a68-46b7-b7f4-08dc9cc4ca5a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ReoGwfvjsTAyNSvOnRdFCEbG7zGNVWOq2xvTFR/ymJRgtSn/O6SVYaRsT77R?=
 =?us-ascii?Q?i7VlcuxpaKHytEyWXff1AFFvqvU8ai/P4zW3V+CE7fTPpKPalgvd8vG3mnxw?=
 =?us-ascii?Q?t0yxk5Y6gjAul2WIlZmH94gRbFdG8/AVwRL2pL34v02E9bMrFBe874EwHTXe?=
 =?us-ascii?Q?E4zZ6Iw+HoVxR1WIHO3szUDjo45ArEBixaVTlawhMo+zM4Iyb0CwtyfQWbAN?=
 =?us-ascii?Q?EzmQCN1zDWlC/RArZRZrjEZthG5e0vGWooxuUX7MQjQ9UzjeEJwn18gFPUEw?=
 =?us-ascii?Q?yJkMFaDwTKsV4pJ1O+JqZ2uzo6AcPxtBxei5CQrujRK0Q7WazEHIH69R6AXX?=
 =?us-ascii?Q?DQC4G1E53HvGBJGDLfEkp39c7WiIvOEivvDoyOOPrkPplhG0ajFldqzzWCYy?=
 =?us-ascii?Q?3QNY6vTHLQUOmyrWWQNDxXfn+/8LSPoZxKW2ihHs8h1pWTjkT0Htfck4BMQc?=
 =?us-ascii?Q?RdJ9cudqb7ZJYUAGO9+9jqD7K6Gd8e5HKwQEctVkGZwu/Yx0NtyWZpl3+DgL?=
 =?us-ascii?Q?LgJ+a8A270EV+ooeGgLHvvCDq2XUWRF6au/LWwD+8jqRsihtPh2qPRROxAir?=
 =?us-ascii?Q?Jo1P+m5zEspZoTMxQhqTI+1sK/qu2dE0Lp62OzTyKGCDyVF6JvG9jtMKQk4u?=
 =?us-ascii?Q?q4xlpLc2dLUSAS1eXx3UHzHQG3x+SIpmdK8qEDCSGNv13mlzmIPYonM0XV7H?=
 =?us-ascii?Q?x/vnuTfHmEip2qanNzecdkbI5cjKA2ITVYePovH6T0A4liXYHHfuADP2CyJA?=
 =?us-ascii?Q?Pg/+Y+aYJU+pdx98ctZ0IQxfp9ckRfAL2tAdJtayWKCL+j4HuBqs67P4++KN?=
 =?us-ascii?Q?QQQuJakykpsZTWA9/NXR/ajWdzSR3jKncOE8m4rrpbr0JUjruQ+lyPhl2tnZ?=
 =?us-ascii?Q?T5cBnA4ZdXTuGOwstvg2JSmBWDiVZ+eWeig5H1vVb8dZsW6Zs1XTrQebsnZy?=
 =?us-ascii?Q?T9Ro56lXmR1k0IBftnfES3wUjReKt38SZJekasTfW2cVfblitF7lsHMFJy0P?=
 =?us-ascii?Q?JDZjWX46nGf5W/L7NAz1SbFCGfaFr3r+yacq0HW+iBHESdgFr493eoolhnwf?=
 =?us-ascii?Q?MF4rCfHJ39poS246Sx8ANbpYTvX63I2kkCDbzrrGf0SFiPR5lIYNB1gANIvG?=
 =?us-ascii?Q?pk3PzDqquSzQv/5LzRYpzVkJyX8nZulvHsnSduYywKQXW6NbumhZf7WLnFCG?=
 =?us-ascii?Q?dq3gOHUKNXIqILtw3IwkUAQtm/iXxhnJh0/KRC4PuEN20MnRb5cRAQYS35bg?=
 =?us-ascii?Q?yzC7qUvJ8D7iY+CWgEKizv5XiA5gQAXHmWpm9KK9xwD0NhK6aw1NE4XbaYu/?=
 =?us-ascii?Q?iFcyjlM8PSXA92Iy4Zi6QY9gU5uDmZ8RxD0hVXmnhahxzw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LTFKcpLUZxMXQ5xPr0t4iXgOguMp/30slW3iH56BjwGtUmUjRkPjQt+sPny0?=
 =?us-ascii?Q?OItEWpzGeaIMc+3V1zoTmCM/N8D2r893HJ1mnfkYPSM9WcgI88E8W22g5VW6?=
 =?us-ascii?Q?GQQ8yrUJdlXjEbXkZHXm4iqxxVFq2iAteGDZIN7MxxnokOY8LUTp/mtJMXlz?=
 =?us-ascii?Q?Cs9ww4usqakXs9YLP79vForToqnAazz4wM5E9Bo4UMy41v7DdZaUSVAigYeE?=
 =?us-ascii?Q?HGVa+lQr69FRmKEUiNktacveJag/Lb+pdGFs+GWyGtZXhvjniOkjBsu/ZayA?=
 =?us-ascii?Q?OFG1kkMlq9YHUBXFuQ7lUu34twhawQiSmDzmqvgpq4phWijyQPY3SbbpL/04?=
 =?us-ascii?Q?9ebrvmr9t2wukXUQVn76wZ2kNS1wAS61Nzn8HI3ZdLV8gIgarR/ju1GUExn+?=
 =?us-ascii?Q?3v5Fc2oP4MApF1/W2ujM28mCtoKX2MzeXSlwqHoaixZ4kWAE+2QjkBtfEx48?=
 =?us-ascii?Q?HnLtu9oXfo1P67xsaWS89Qbj0cIjA6XIWJHUXkf8EbjExDWH3VrNYEOs/HFP?=
 =?us-ascii?Q?vNY2ZMl8sv+0xUmfnuX6MBlmOV+FwjHHgaeYkau+5f97L1PgqoNT9dccWwYw?=
 =?us-ascii?Q?j+FifdUAxyg8nuTICegbWIoAvx4wuhMhs7kA5R4ylSEssLcbaPhKcor9vs8G?=
 =?us-ascii?Q?7ewXZ3sknuEkVYGkwWHX9LspN3VC0KLtU+D6nNqqeZLvgCNTaGN+tZJMNJxt?=
 =?us-ascii?Q?LPDvF8gUk4J5vj8jG/mneEHEoH+xgfEGPykAML7o/ujcOTVas+zspNsibzTL?=
 =?us-ascii?Q?4C3u6ufbeU7U01zw6ni9pctyG3K8TEvZAPEFTL40c1gfvALL/vB5YGW+IbJy?=
 =?us-ascii?Q?Rx1J58zyL+4gxZrGl0WFDP7PhVDWDpXX7shlIXH/PTWCdVUYTRoCiiNOaD34?=
 =?us-ascii?Q?lg25jzDmgjoY8L20Z6W/mq2+0MgdCGnCry5re3EKNarUvUUFOej0vU5KxTGb?=
 =?us-ascii?Q?c6Bt/88MGIGm80+yNlC3RAq+9vWNzYLLWVF90GGX4nJikDb0irDSbLpoBkFp?=
 =?us-ascii?Q?WqY1283Htgty80nFyX8x45R4dN0FsCLHOw/3fmTcMlOjI5P54HTZWn4sEmX3?=
 =?us-ascii?Q?pO8zRGNsmKzlLD8X1RamrCvH1go+/YGvKUkdyelsmDX7W0NSK2ndDy63UH2x?=
 =?us-ascii?Q?kIFkuKpCtN86SqajsCpYCxjzEs0OmhIUpMmkNe9ai86dP9PCWsVhYwLk5MHv?=
 =?us-ascii?Q?Qa+WyU3NlWZ0IARJ4CnfOVvxBpYT+8fuyfZMxN/LL39znotnOriyIIfwCgsg?=
 =?us-ascii?Q?jwyDFPBd4M8wpTuPy92qT4/OFy6hRF+CGdqGhTT/lNJHUNmG5bdxO0/Qd5o9?=
 =?us-ascii?Q?lnKXFeX1HLOh/1sUxrb5qUTeAcILjiwgupb7AuDgKIafzlyZJM2bFoDLg+Bj?=
 =?us-ascii?Q?xb0PrZ9flO7z+l07Kt/dr/RVv4Jog4EJ/EmqwM+j1lNv2Y2N++EtcaJoLWo0?=
 =?us-ascii?Q?i9LbxPuMvMFLqfApeKTOM6Lz+quQsgRLkWn9zPYMIWAU3qPvpM2suDE6hC0G?=
 =?us-ascii?Q?PmAgnC0INemhNsLgz5LSZwU1up6wPd6NC9ehNfX4KW/aUnOe1+3XTttCtXzV?=
 =?us-ascii?Q?PFnNLTwBbeid3XyxEhnCHZRaicamK1IhIzdAJ8UgP+T4LFjKINDuzbxgkHdx?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b07f766-6a68-46b7-b7f4-08dc9cc4ca5a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 07:33:40.2947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VyaRmL5DCkufZveN3dGSRUs/yS7YHdrJFOUqsyt8sLFOl2SVnTGNRqSxZuTonk93pECL545DTuccL9ZE3nMHMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7130
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 07:33:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16386

On 05.07.24 09:23, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan,=20
>=20
>> Not really: we should still select secure boot from the security image.=
=20
>=20
> You mean the below change is still valid? if so, I will send the v2 patch=
 for this change only.=20
>=20
> config IMAGE_SECURITY
>         bool "Security extensions"
>         select IMAGE_SWUPDATE
> +       select IMAGE_SECURE_BOOT
>         select IMAGE_DATA_ENCRYPTION
>         depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_=
ARM || TARGET_X86_UEFI
>=20

Sure!

Jan

> Thanks & Regards
> Shivanand K=20
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>=20
> Sent: Friday, July 5, 2024 12:47 PM
> To: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Po=
rting) <Shivanand.Kunijadar@toshiba-tsip.com>; cip-dev@lists.cip-project.or=
g
> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) =
<dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=
=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=
=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhi=
ro3.hayashi@toshiba.co.jp>
> Subject: Re: [cip-dev] [isar-cip-core] Kconfig: Refactor Kconfig options
>=20
> On 05.07.24 08:57, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>> Hi Jan,
>>
>>> This is by design: We do not support secure boot without SWUpdate. Whil=
e is technically possible, our recipes and conf files are not preparted for=
 that. Therefore, you have to select SWUpdate first before being able to ch=
oose also Secure Boot.=20
>>
>> Ok, thanks. It is clear now why secure boot option is not showing in Kco=
nfig menu by default.   =20
>>
>>> Ok, it's getting clearer: kas/opt/security.yml includes=20
>>> kas/opt/ebg-secure-boot-snakeoil.yml, thus already enforces secure boot=
 while the kconfig menu suggests that it can be disabled as well. That shou=
ld be fixed visually by selecting secure boot in Kconfig.
>>
>>> Now, if you enable (or select) secure boot for the security image,=20
>>> you include kas/opt/ebg-secure-boot-snakeoil.yml (and=20
>>> kas/opt/swupdate.yml as well as kas/opt/swupdate.yml) once again. This =
looks redundant but is actually harmless because the statements in those ka=
s files are automatically de-duplicated by kas. Just check the effective bu=
ild/conf/local.conf.
>>
>> Understood, then there is no issue if it includes redundant yml files as=
 it will be handled by kas.=20
>>
>> You can ignore the patch, sorry for the inconvenience.   =20
>>
>=20
> Not really: we should still select secure boot from the security image.
>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Linux Expert Center

--=20
Siemens AG, Technology
Linux Expert Center


