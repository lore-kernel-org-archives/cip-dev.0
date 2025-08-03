Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04654C87FCB
	for <webhook@archiver.kernel.org>; Sun,  3 Aug 2025 20:54:50 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.50])
 by mx.groups.io with SMTP id smtpd.web10.3972.1754254481412591523
 for <cip-dev@lists.cip-project.org>;
 Sun, 03 Aug 2025 13:54:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=dSN7AYpC;
 spf=pass (domain: siemens.com, ip: 52.101.84.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TT5ikOdwD30SbdEIQWHMOyiMOTukuQE7sXq8hVkcd2a4HWL4KEQyBBcQ7Yvh/xlUApMD+e4/lTV4y8UhVspqc2HRePzxvSbCGIo5vwCs3ar2VKbQZf2pxxKiLDLdlMa6WIi2fWzY0r4UARv9mWnwF+2FIThYFWUjuemGGu1iuuEpb8TXi9vnv99Z62nRQ75e56EZSp7sfzu9UmQEAMPBrNTJVGCXXSyaf5ycYkh5Jk+g4QkGwLtprvFaMUijaGUPlr73i2nAEKS9Zss0dgMrDHWIhf26gvRclyatNxni+d6OWP9Du7Gxmk5eI1M5BnQN4NXXmWz2+XQYg2Q8sps9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXQDnPYKz6BzA2buHrNCCOSZm0HlAlxF/zaXaGNGz/c=;
 b=uipjrVq8LPQoyff2FsxvBDzRRcS6YiVMenS5hA06uHyeHbudhR4NVnlnEU8UcOu+NtkeKXZB9kemaePkjsNBhdGo2yH9OYZIDpYxGEqxHokfPoZ7wn5WVF4m33OITOLl//JMLddA5RpKSFwbwFqc3cP/FCfDefYIG721O1eFiLzsC3jvxGYTRULyZxmk+EjTJN1zBX0MaTyAUxhFo4arHIF6Plhwec5dnbDb9VSgx7d7b27YPKOgAjE1wpT/PpyTjRSnSXtM7lv/Fd8vouQnxn4wzpMCCna+s3irofgIm160iEsfF8GpeLd0lJp7rgJOEdwtMh9Hv2gu+jrMm3iZ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXQDnPYKz6BzA2buHrNCCOSZm0HlAlxF/zaXaGNGz/c=;
 b=dSN7AYpCS75RJHpXXvM4kNz8us9FzTbO+yCQ7Vs4ThWH0O764/a+khv/vzzdzRWosf2tiaWjUP9pYKIcnsTITDFtVk+oNu0hmaAWgkE4O3GeaJV2yuv0JbgZ0f7PZGmzlttVI4u4EK4FG3jkuRN7h7Jlu+R6gzN9nBb+vUHuHxMg66Hc8B6bF35TT72fk/UbVzchuayeFpgVLMSCN5CCjmLCkrRZ7JEbGmdEB20O1CxJVceHikCHdnfe6Ssr+jRWdKejHdi5ryOsm3Glm2tzFYvyC1mhpwv1LA3JcYD92CDwVW0U4I2HbHpGTY4YuKaMIfx1mSHphKgv2KTnkEKu/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB9136.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:420::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Sun, 3 Aug
 2025 20:54:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.017; Sun, 3 Aug 2025
 20:54:37 +0000
Message-ID: <9bbceb24-c6f6-4584-8d08-9903c0ec4de0@siemens.com>
Date: Sun, 3 Aug 2025 22:54:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 4/4] ti-am62px-sk: enable data
 encryption
To: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>,
 cip-dev@lists.cip-project.org, vigneshr@ti.com
References: <20250722101551.1727649-1-s-adivi@ti.com>
 <20250722101551.1727649-5-s-adivi@ti.com>
 <9bec0162-625e-4796-97d5-0cd364b3ad2a@web.de>
 <d40cd721-9403-404a-8a5d-83820646ab33@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d40cd721-9403-404a-8a5d-83820646ab33@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 085f4f9b-8dfa-4adb-af81-08ddd2cff590
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?D3qDAldoRaZ28vfHso58dwUz4ffOENRsy93IVENeE8Jdm1mn2MgMhxHhpftY?=
 =?us-ascii?Q?dI8kzm4Nd3GUN/6BgdPCP5yqEzqebDkMvsFMGLzo7P67wdSXqcpkz5SiTiJQ?=
 =?us-ascii?Q?scN1EQWR/JYwSlxj/UNXau1Vi9iHRb6pbeEBSGczxY32TIEJB/HtxucA6pKu?=
 =?us-ascii?Q?FuUXSapO93skiMR5lYlCwoY+QUDgo2bDfy+SG7o8YHELPOTF/O51K0E2ZhFo?=
 =?us-ascii?Q?XlB0otyh8gUiLQWGlJIVxpoHuphaeoy0DayFgZ2zv0QEefbDlfbAguag78FR?=
 =?us-ascii?Q?WOecEiPJ7W2H+J3Xa9E8d9HJqH8dh40eGr3fYWxacYnVjdMkAw4mdo2Er6Fk?=
 =?us-ascii?Q?jKLDhuZZ18a27HLis2puxdpLvoU5rCqHPNSrEPTcpc+jCzbenmCEQU2KSDvQ?=
 =?us-ascii?Q?O2yeOl5ye3dW8DHKjImewNyY4UK7bnMCfwvf/3ebz1XdFOxgiIlOsHB+Kbv4?=
 =?us-ascii?Q?fz1sb0BPh7blpfWKwxH0R9WDUISLMj3QDWUGw1w+Pe+1mDuoFmY7Btmfk3Uh?=
 =?us-ascii?Q?Z1kJhvj+UYCw1fq/9frG1nmBjGMheU67+MjfcT7i4Mn1Y7FP8jnVn2Ec5GUY?=
 =?us-ascii?Q?WgR8/1ErRHv2qfdCPLiKmlxYAnjsxjPeOQ7bwqxQYpa6iL/ltNCk1ghN2ryS?=
 =?us-ascii?Q?MMhB0fsIovrDXglIcC01j7RgJ15qM7Ov+H9IGkKahE3fVXb9ueAyjXMk2WuC?=
 =?us-ascii?Q?VjrFUAD07V4EzuK6k2wlDo5yY8+gZs0xu90IQ+lTw5bKihq8wl3Vz1pxSQGi?=
 =?us-ascii?Q?SOycROO2ZfSCiXKzTwDxh2UNMUIaAYzuoiLpECVgzE01ie0cMBLz3K0CmPXP?=
 =?us-ascii?Q?xpYKpvLwfSE3zTX7kn08gP2LZVXJaRNavncAmSjkwISGVYxKqxcEaCdPTUyR?=
 =?us-ascii?Q?62tu7Q3vxxrq7GzvhLSRQ6eIxw+7sYHDMwlr4WeCXuk8GSofM4/O+ZrEvcly?=
 =?us-ascii?Q?PYZW2AXLZZ16IvahnDGccs6kqnpeg05+8a4HJXyfPNZY5Aru7cmSz0iZYorS?=
 =?us-ascii?Q?7Hqx8qWV5ELKymwDbFtLBdQuTWjj5HQ5xrPicxeOYFwbFhsofNo5R1EAGCdR?=
 =?us-ascii?Q?fae+mT3OnM6Q7BOx9MVg4iqQntFQwAvVd2Js3NV1E7ruEC0Xar4/zNB9Qn5n?=
 =?us-ascii?Q?dQ9Z532cibMWG7/iLHdwJVAymoZkTYP3Gqpftd841giH0eCRbhUllOSBE0yR?=
 =?us-ascii?Q?v+bkQnH7GglH6CLeQ+O0a08EQFbDvTLa7MFsZ0w22RdrZj9N6bVR5iKE6UI+?=
 =?us-ascii?Q?GKsoqgpbelY99NOEOk012+Aak46A+P/mDNYZFpCFRppslJ4rTjw8l7WRKfWX?=
 =?us-ascii?Q?B+aHjtZDW2NyNBFWQsEHGU8OghlBdEmpxP4vOERtylmx8bCexMuWSHzrQ+27?=
 =?us-ascii?Q?GN9/Zy36x3vKVQ1wtuwpPvFxhc0pOVOk51jgPLNHEtadXDrw5ee4HW7w+VoK?=
 =?us-ascii?Q?c+I3bQUgAk8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?51f4Xk4I/Nx+Ugwt2msQExYj5n4bW437U1DJ/nZFrWRyrM53Abq4UynTm01Q?=
 =?us-ascii?Q?spzo7we1ChyDHctH21gwAucBmK1JHm5cRZ+Zg5+PWoW8maaP1TsS/dTlEFoe?=
 =?us-ascii?Q?D5LDem+dOInQdrK6GTaW3X8bvOL/V0QMxnYculVN7n2Tp2xSDjx6uI4eUpje?=
 =?us-ascii?Q?nevR9CV7DibKHEQzcQmV0EpaP8drgCTDnrumTH2284sFHwWg4UHoc2speH38?=
 =?us-ascii?Q?lz24zYnb4oGgW6lKTzm+3kYjXq1WNQEAM2sAMBMKlZ5Ye4PCsLEmEHcJed7R?=
 =?us-ascii?Q?+1C6aeOEzdODtx375+0x1p0pQSVXSsidCAQdgATgYsidCDgTJCsOz+BExG4J?=
 =?us-ascii?Q?51PFDf9GovzE3MxoYyS1EoOdFHaEbjXAQ/Stu536bnkebbn+K+f7dOfw1JkK?=
 =?us-ascii?Q?ivgKyULjZ182GF1PdBRrrWF12ZkwHngB2LoLum6FLKB40zxedYa6yB4sxj4c?=
 =?us-ascii?Q?IZkwH79DNS8cTj05xuZpcIS2v8MYCvaEkgjUmEaEDzNIvGeysbGX1C7S4+a2?=
 =?us-ascii?Q?z+NW/uus684Mz1GyU5TKguq5t06lbjkTPjfOttyYaN040whZE5ghl+F5C3zj?=
 =?us-ascii?Q?iATYsUN94gsC6aUOn6RHqt7dMjMUl9NSE1I4JLmxpFiTPbITMs3lcMKIkzs3?=
 =?us-ascii?Q?0xztOBVroI13Hjqm5mq/6dIH+2mKmSNQfvtKAvbxTbket3hQsxeTQcKPYzsL?=
 =?us-ascii?Q?UDrUXz5x6KfvwexQBSjgiS38oq6UScvOZI4fYRAU+L6cWh9WeB2rwcITs0Hb?=
 =?us-ascii?Q?3fK/0tkhakj54U/P1ES7qItpfxEdud1OWjkoKyXFrpX8XsyW9lzvXUIqjBjS?=
 =?us-ascii?Q?tpqg4s4xBqlfoIHIS/XjOmRSBTRA3+cWNtT0pePJLQ1j2MI1MlvHKVHjb7v5?=
 =?us-ascii?Q?BBwlzUSvQXnb6VMHxIBH6fmVfQ6Tt+EnZivPctXpKMHm5BNszt0TYgqs/C2E?=
 =?us-ascii?Q?RdsZ8OXzwtu7XBR4u8Ygy1RZLEv8NV5m/hR7X08ytVxAWoswzGrW478sIHV+?=
 =?us-ascii?Q?IcuJi4BjqqEZ3ZqHm0oG3ZRF5UMuq+/mR5zFRK7B+HW+MO7P23U47zWij0sB?=
 =?us-ascii?Q?DIdqczOcvU3coUlOKaDGcFB/DBk+r4bnof9gQX+kWcdMK2V/Zlv6Rj3TngAT?=
 =?us-ascii?Q?TH26r8FY1JVVn6UbDly7Sv4yK2iyBKWyIXhtwsCzz0Y1trSctZ2S2eqYT+QV?=
 =?us-ascii?Q?bHebo/ClqRRRMlZ6y77GzG0mOv6EpU9+8KUt0MbBLxKzcDrrqJH31Np/r0Vf?=
 =?us-ascii?Q?xfa6VuhHA3lenagXwJR2oXPPogKYnT3w540W1YeNDk4KGkhMEAa5/8HBZcde?=
 =?us-ascii?Q?05DmXbw0riCO8VSXiw7CcIvEn5UgOJCtfmoksO1eN3tB8vtmltpqgtgvVsyS?=
 =?us-ascii?Q?f3VxlYWaf1ZGB7md2ICyxWzXapNRAJQnZCWiv039P90T6iloqyyjVYc5RnJo?=
 =?us-ascii?Q?eo5Te4D38okNXS+DZb0+Sr5/D2s4kAQnBOShT9xNieuo7q4tV24o8fQyI64s?=
 =?us-ascii?Q?co8SEHdZN33iH4N6fZ6fONWI8n+HJlkex9Id61uMSuSF6XAJn8uZbVTH8NBw?=
 =?us-ascii?Q?H3vCT71cTUIIFjPFf7xO+6JDFKn16QJ1Ogguo1c3SCAela1nd4p00LiVlQAP?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 085f4f9b-8dfa-4adb-af81-08ddd2cff590
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2025 20:54:37.9066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKcmqqcKemTUdnxqXe95S+1hOp3ujTw7NZvR8PwH96ahMZyUJp0Xe/aZEsjWZct+aKSRMoHF/6xfxrgd7mlRzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9136
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 03 Aug 2025 20:54:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19651

On 01.08.25 07:27, Adivi, Sai Sree Kartheek wrote:
>=20
>=20
> On 7/23/2025 3:38 AM, Jan Kiszka wrote:
>> On 22.07.25 12:15, Sai Sree Kartheek Adivi wrote:
>>> - optee-client, optee-ftpm:
>>> =C2=A0=C2=A0 - This integrate Microsoft's reference implementation of t=
he TCG
>>> =C2=A0=C2=A0=C2=A0=C2=A0 TPM2.0 as an OPTee trusted application.
>>> =C2=A0=C2=A0=C2=A0=C2=A0 Since the OPTee secure storage on TI AM62Px SK=
 is RPMB-based, and
>>> =C2=A0=C2=A0=C2=A0=C2=A0 the RPMB accessing is provided by linux tee-su=
pplicant, this TA is
>>> =C2=A0=C2=A0=C2=A0=C2=A0 only discoverable when tee-supplicant is runni=
ng.
>>>
>>> - optee-os, optee-os-tadevkit:
>>> =C2=A0=C2=A0 - refactor optee-os recipe and add one for optee-os-tadevk=
it which is
>>> =C2=A0=C2=A0=C2=A0=C2=A0 required for optee-client
>>>
>>> - u-boot:
>>> =C2=A0=C2=A0 - New patch to add ftpm node in the am62px device tree
>>> =C2=A0=C2=A0 - Add rpmb-setup.cfg for setting up additional configs req=
uired for
>>> =C2=A0=C2=A0=C2=A0=C2=A0 enabling FTPM.
>>>
>>> - cip-core-image-security:
>>> =C2=A0=C2=A0 - Add newly added optee ta packages to cip-core-image-secu=
rity
>>>
>>> - Kconfig
>>> =C2=A0=C2=A0 - Enable security features (data encryption, full encrypti=
on) for
>>> =C2=A0=C2=A0=C2=A0=C2=A0 TI AM62Px SK
>>>
>>> Co-authored-by: Ayush Gupta <a-gupta4@ti.com>
>>> Co-authored-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>> ---
>>> =C2=A0 Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++--
>>> =C2=A0 .../optee-client/optee-client-ti-k3_4.6.0.bb=C2=A0 | 16 ++++++++=
+
>>> =C2=A0 .../files/0001-add-enum-to-ta-flags.patch=C2=A0=C2=A0=C2=A0=C2=
=A0 | 27 +++++++++++++++
>>> =C2=A0 .../optee-ftpm-ti-k3_0~231017+git.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 33 +++++++++++++++++++
>>> =C2=A0 .../optee-os/optee-os-tadevkit-ti-k3_4.6.0.bb | 12 +++++++
>>> =C2=A0 recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb=C2=A0 | 29 ++++++++=
--------
>>> =C2=A0 recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.inc | 29 +++++++++++++=
+++
>>> =C2=A0 .../files/0001-Add-tpm-node-in-uboot.patch=C2=A0=C2=A0=C2=A0 | 3=
0 +++++++++++++++++
>>> =C2=A0 recipes-bsp/u-boot/files/rpmb-setup.cfg=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 12 +++++++
>>> =C2=A0 recipes-bsp/u-boot/files/rules-ti-am62px-sk=C2=A0=C2=A0 |=C2=A0 =
2 --
>>> =C2=A0 .../u-boot/u-boot-ti-am62px-sk_2025.01.bb=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 9 +++++
>>> =C2=A0 .../images/cip-core-image-security.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 13 ++++++++
>>> =C2=A0 .../cip-core-initramfs/cip-core-initramfs.bb=C2=A0 |=C2=A0 7 +++=
+
>>> =C2=A0 13 files changed, 207 insertions(+), 18 deletions(-)
>>> =C2=A0 create mode 100644 recipes-bsp/optee-client/optee-client-ti-
>>> k3_4.6.0.bb
>>> =C2=A0 create mode 100644 recipes-bsp/optee-ftpm/files/0001-add-enum-to=
-
>>> ta-flags.patch
>>> =C2=A0 create mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-ti-
>>> k3_0~231017+git.bb
>>> =C2=A0 create mode 100644 recipes-bsp/optee-os/optee-os-tadevkit-ti-
>>> k3_4.6.0.bb
>>> =C2=A0 create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.inc
>>> =C2=A0 create mode 100644 recipes-bsp/u-boot/files/0001-Add-tpm-node-in=
-
>>> uboot.patch
>>> =C2=A0 create mode 100644 recipes-bsp/u-boot/files/rpmb-setup.cfg
>>>
>>> diff --git a/Kconfig b/Kconfig
>>> index 68c4309..b59ca59 100644
>>> --- a/Kconfig
>>> +++ b/Kconfig
>>> @@ -204,7 +204,7 @@ config IMAGE_SECURITY
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IMAGE_SWUPDATE
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IMAGE_SECURE_BOOT
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IMAGE_DATA_ENCRYPTION
>>> -=C2=A0=C2=A0=C2=A0 depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 |=
|
>>> TARGET_QEMU_ARM || TARGET_X86_UEFI
>>> +=C2=A0=C2=A0=C2=A0 depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 |=
|
>>> TARGET_QEMU_ARM || TARGET_X86_UEFI || TARGET_TI_AM62PX_SK
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This enables security, encry=
ption, secureboot and swupdate
>>> for IEC 62443-4-2.
>>> =C2=A0 @@ -260,13 +260,13 @@ config KAS_INCLUDE_DELTA_UPDATE
>>> =C2=A0 =C2=A0 config IMAGE_DATA_ENCRYPTION
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Encrypt data partitions on first b=
oot"
>>> -=C2=A0=C2=A0=C2=A0 depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 |=
|
>>> TARGET_QEMU_ARM || TARGET_X86_UEFI
>>> +=C2=A0=C2=A0=C2=A0 depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 |=
|
>>> TARGET_QEMU_ARM || TARGET_X86_UEFI || TARGET_TI_AM62PX_SK
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This enables LUKS encryption=
 for the partitions /var and /home.
>>> =C2=A0 =C2=A0 config IMAGE_FULL_ENCRYPTION
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Encrypt rootfs and data partitions=
"
>>> -=C2=A0=C2=A0=C2=A0 depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 |=
|
>>> TARGET_QEMU_ARM || TARGET_X86_UEFI
>>> +=C2=A0=C2=A0=C2=A0 depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 |=
|
>>> TARGET_QEMU_ARM || TARGET_X86_UEFI || TARGET_TI_AM62PX_SK
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IMAGE_DATA_ENCRYPTION
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This enables LUKS encryption=
 for all non-boot partitions on
>>> first boot.
>>> diff --git a/recipes-bsp/optee-client/optee-client-ti-k3_4.6.0.bb b/
>>> recipes-bsp/optee-client/optee-client-ti-k3_4.6.0.bb
>>> new file mode 100644
>>> index 0000000..6b9d640
>>> --- /dev/null
>>> +++ b/recipes-bsp/optee-client/optee-client-ti-k3_4.6.0.bb
>>> @@ -0,0 +1,16 @@
>>> +#
>>> +# Copyright (c) Texas Instruments Incorporated, 2025
>>> +# Copyright (c) Siemens AG, 2023
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Su Bao Cheng <baocheng.su@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +require recipes-bsp/optee-client/optee-client-custom.inc
>>> +
>>> +SRC_URI +=3D "https://github.com/OP-TEE/optee_client/archive/
>>> ${PV}.tar.gz;downloadfilename=3Doptee_client-${PV}.tar.gz"
>>> +SRC_URI[sha256sum] =3D
>>> "a970338c9f69861901336716d89684646e4480b9970996a5b3581ae7d49fdaa3"
>>> +
>>> +S =3D "${WORKDIR}/optee_client-${PV}"
>>> diff --git a/recipes-bsp/optee-ftpm/files/0001-add-enum-to-ta-
>>> flags.patch b/recipes-bsp/optee-ftpm/files/0001-add-enum-to-ta-
>>> flags.patch
>>> new file mode 100644
>>> index 0000000..57917ba
>>> --- /dev/null
>>> +++ b/recipes-bsp/optee-ftpm/files/0001-add-enum-to-ta-flags.patch
>>> @@ -0,0 +1,27 @@
>>> +From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
>>> +From: Maxim Uvarov <maxim.uvarov@linaro.org>
>>> +Date: Fri, 17 Apr 2020 12:05:53 +0100
>>> +Subject: [PATCH] add enum to ta flags
>>> +
>>> +If we compile this TA into OPTEE-OS we need to define a flag
>>> +that this TA can be discovered on the optee bus.
>>> +Upstream-Status: Submitted [https://github.com/microsoft/MSRSec/
>>> pull/34]
>>> +
>>> +Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>>> +---
>>> + .../ARM32-FirmwareTPM/optee_ta/fTPM/user_ta_header_defines.h=C2=A0=C2=
=A0=C2=A0 | 2 +-
>>> + 1 file changed, 1 insertion(+), 1 deletion(-)
>>> +
>>> +diff --git a/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/
>>> user_ta_header_defines.h b/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/
>>> user_ta_header_defines.h
>>> +index 92c33c1..e83619d 100644
>>> +--- a/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/user_ta_header_defines.h
>>> ++++ b/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/user_ta_header_defines.h
>>> +@@ -44,7 +44,7 @@
>>> +
>>> + #define TA_UUID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TA_FTPM_=
UUID
>>> +
>>> +-#define TA_FLAGS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (TA_FLAG_SI=
NGLE_INSTANCE |
>>> TA_FLAG_INSTANCE_KEEP_ALIVE)
>>> ++#define TA_FLAGS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (TA_FLAG_SI=
NGLE_INSTANCE |
>>> TA_FLAG_INSTANCE_KEEP_ALIVE | TA_FLAG_DEVICE_ENUM_SUPP)
>>> + #define TA_STACK_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (64 * 1024)
>>> + #define TA_DATA_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (32 * 1024)
>>> +
>>> diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_0~231017+git.bb
>>> b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_0~231017+git.bb
>>> new file mode 100644
>>> index 0000000..14df4d4
>>> --- /dev/null
>>> +++ b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_0~231017+git.bb
>>> @@ -0,0 +1,33 @@
>>> +#
>>> +# Copyright (c) Texas Instruments Incorporated, 2025
>>> +# Copyright (c) Siemens AG, 2023
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Su Bao Cheng <baocheng.su@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +require recipes-bsp/optee-ftpm/optee-ftpm.inc
>>> +
>>> +SRC_URI +=3D " \
>>> +=C2=A0=C2=A0=C2=A0 https://github.com/Microsoft/ms-tpm-20-ref/archive/
>>> ${SRCREV}.tar.gz \
>>
>> We need to migrate to https://github.com/OP-TEE/optee_ftpm.
>=20
> I'm still working on this part. Running into some issues (optee-ftpm ta
> is not discoverable. So doesn't probe.). Do we have this enabled on any
> other platform or qemu?

Likely not, thus there might still be problems in transition. Did you
already discuss this issue with upstream?

>=20
> Meanwhile, I've posted a v2 fixing other issues. I'm ok if you want to
> merge the first 3 patches in the v2 and leave the data encryption patch
> out until I migrate to optee-ftpm.

I'll have a look the next days.

Thanks,
Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

