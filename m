Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEC5CEACEF
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 11:40:22 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.24])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7291.1763379611911109939
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 03:40:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=P1/KEWsy;
 spf=temperror, err=temporary DNS error (domain: siemens.com, ip: 40.107.130.24, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LML6L/AU3JbToNvmHKX4hzkHHkJsr99qhGFLcWQqw/yuQlj1AB84naO+IrTA9WSCzC29Lp/LBVLgfGVOv2qNYm54qdMxDW9TlvNXNYdh1os9TpkiKxHo+YS3+vSCrLKGaI/4til3Dx7vG6e8O0SyflqRsyv7LRG6zEAmWt+BKoj4X6yHcAiyPzLHd6zNzmClk/lry6KI3p+rkdXHbrojaZhOCYEhysX2tsgOdWNwJxGN9JFqFgdftc+LygoZv+AOjU3FXrsxosic1nHuOLUcmHxXMaA4Pk4qcvs2tkXyFAipViT1kgRLkXEJ4oPHkE16W33kjyrQmO3B/+MCgBdi0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S06UuEtQS5bX6CTx7ldb9s1GPSBKV2h0FF+1cQJ/r/8=;
 b=xGOrEluarjYuDbSkKo8379yfqDDiV3VZ6loQ66ulhYcY4I8CEfLrJelTT9YS10sri/Gh7yKDWGMwjU9MQyJUSn+v0osBtDQN96WAug8kCS+sVbesMGdz2cWiP82R3hEZ4sNHZnB5NdCywvFB7zTj67LgS2Cj8ADy2fh3gQHbvEjA7r+FML2g/z1enzfEHd9xGhMfw6y69DhXf1TgjFDsEaAKfBROKNQaTMltNfe4CX9nrFSQpS35kuEd3ZFjx/e4FQ56HqJqhpUixHLEZCDtoew35JEYVm9DcdjkrHOObPuHBP8cgDm+9NG46+wl8cOy2+BBU8ypQzmHeXrHbpLFQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S06UuEtQS5bX6CTx7ldb9s1GPSBKV2h0FF+1cQJ/r/8=;
 b=P1/KEWsyE4eoM6kkUqXJLTSVQRTwPg3ugfGTc8+MKtC0rSRB3MsZUv2lQbuXmordmBPiaEzzmyr6hB3NAXWO0siWgBHl8VaIki8VZBn7xvzSxoy3NX0QQfi/C5vEG4H1ZpQMgN4xQZXs+YYAzP24vFmyArKq5CQROWS1Fz/XdIErwh2g3EZ1i5zNVmLONvrU5Uem/OuMN0L5akoMKWuta4f5DUsc03FWYXuAHWvXP6kRTY+OzOelBEmuFxFBd++cQxmFryGMBQQC6NaubssmjOtNEeMMGRbEHzliIm4J98TXhAc7VTSC4w5RH30NOjILEPVyq1r+hbY7a2hU8I73Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Mon, 17 Nov
 2025 11:40:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 11:40:06 +0000
Message-ID: <0b5b6fa4-28a6-49ae-b9a2-72bbc0adbf79@siemens.com>
Date: Mon, 17 Nov 2025 12:40:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 4/4] ti-am62px-sk: Add support
 for secureboot & data encryption
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 vigneshr@ti.com
References: <20251114090509.2935933-1-s-adivi@ti.com>
 <20251114090509.2935933-5-s-adivi@ti.com>
 <07b0cdc9-6aa1-4ec5-b9cf-44fcd5a663f3@siemens.com>
 <6aacb3eb-9f12-470d-86ad-5ca712f6aaf1@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6aacb3eb-9f12-470d-86ad-5ca712f6aaf1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3645:EE_
X-MS-Office365-Filtering-Correlation-Id: ef92ba00-b5b5-4b2f-b0df-08de25ce0df6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?j6Ps5GyLa/urUpIZ7h9e/WtNVYmibUy41iGZsm/fY8/4fKqePWGN5a29nZfA?=
 =?us-ascii?Q?mbc4ESO99Z/8zX0Jn4bj6uM901acfU48rCwbPKAujS9UIjCAxIdDLDncfceT?=
 =?us-ascii?Q?NDN6ULrUfdJuJsDv8WEd8yviLAfo+7KsY56xUG1+7A0Iu7Z2UcFNH0wQGWgl?=
 =?us-ascii?Q?MkXhAtQGlrugS5kdm0CJ5NabRdTkn/NNNBtKcppPK2TtL2+FT9XSK71Z4VaP?=
 =?us-ascii?Q?cQk37hBarZbWHdgaHz0gj3gjFMHK+mJlQtRtlJ2P1mJCWr5L5UrmTTxGG/+k?=
 =?us-ascii?Q?fglVRH2DZKTDlCWkd/FJ9dR1r8EuQrXEndk6TJ2Yx0K7N65liLksudPzi/FU?=
 =?us-ascii?Q?6NCw5wB49i/ATuVWzohlY53dPEKMMNVKXoGdfEmZBuz0gJt8hy9mkqhowTY/?=
 =?us-ascii?Q?86vIYMNIIom4bFJMZMsKKLMlUi70Y/JZ0MtwgwB3VP03prjuDjbDeuoJuFta?=
 =?us-ascii?Q?cRUK6E08qGMYSk78GWv13Vtqb7Fyx42TlnUI6YmndKBT/uSkAjgFUGJSUTdp?=
 =?us-ascii?Q?MyFIFfQeCECDBy7/c4DGO6UWXM4sRXjDvO76f3bQHdaKKbaDR1LTw1Cvgxh3?=
 =?us-ascii?Q?q5XqfzZXkoY/vGEx4KRlfprvzgsen8KxHWUmkiIFrXa6C2KOe3Rmm2+7LmLM?=
 =?us-ascii?Q?SFCINtOdo4PrIDYsLdFCMRfO1E/XJ4HBbDo3ATW+JvoJbgn2CCaHQNd+XbCB?=
 =?us-ascii?Q?kh85z3m0d8Q7MJFwUMmysZ/gCiQvbS0NUyjWO1Diva+wFisElM2taUIr9ZKD?=
 =?us-ascii?Q?qd+Q2AArCIZmwXa7nSJLjHKjcDc1o9OH0JV+NtYdtyfNZNVdNP2uDnyv0+z9?=
 =?us-ascii?Q?NwoX2YuAASEdy8o373OS/6/Q79J/pVln1BhDNDOR/vL8zszu6I57z08jkKYd?=
 =?us-ascii?Q?uC+vjIbZzwh/svblf6suIyFI4ulXPOipTiqBWBWcfHlYNA6qX1yxIzutnMdc?=
 =?us-ascii?Q?HlIKR0w2qYJeecRkCK3DyaHLK00HMD46ud5zmNbWQCilNp18GPurHKT7SHlh?=
 =?us-ascii?Q?hzJww3PfuUPFgDIug+7J+6BbN3gD93oigXqoLGLjgN5oc/ZTc9oZ85QdBWy+?=
 =?us-ascii?Q?eIG3bgt2vQRqXA+EkDrbeeDAASJnbFgNBSlay7H/TU6Gm1GQ7kP/sOqgX1m0?=
 =?us-ascii?Q?jwW3DbdgxHtsQwK9eaRJbBXavUbrDdunbWgYv9DjlvuDEJGksFagqo7vWYlY?=
 =?us-ascii?Q?k6aWS7+RBtaLKrJbb/owxa2AjyHIOS3SsRRnzfQvPKXdy/9EVtkIlFnGKpko?=
 =?us-ascii?Q?vLyvjF2BeQRwfX0eR81+OXhgFfv3VQiyb2qypFJTAqWuTs+lPWCMWmQ6LXgD?=
 =?us-ascii?Q?r1/8FB9RDpdS21tJVkb8cylQPEvicQjV10by0DTqiqjimbDFqBEXIcNt01F8?=
 =?us-ascii?Q?IGUFZ8Lu309tP9K6mxEZ94VzyzyjzYVr/duMPm8QmXr1abige4RQtYGj5Lbn?=
 =?us-ascii?Q?0Zf5hV6MP5ohQp4QT6UVUJ2mzXM7UdaI19JTuXXSapcygDG5J7g0uQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nMgb/Ltkpt9SmQChinuo4Z0ywiBNeCOwpLoechvVPc05t4uf523bxlWdyGHA?=
 =?us-ascii?Q?alwBtZUQlqY39jivclpYguFWhvmipINglkVbXfqSKJX7coYeIKBANQtQqwU8?=
 =?us-ascii?Q?IBJ1XCvvKHkFCySldw7EmZjtllbs0Q/pknsOzDYw/hOmUCwihDrss1L1B8Ut?=
 =?us-ascii?Q?MqYDxR4o6kvO28zRuNyDRrYSZsyAS+1J1/nTrjxJsw+pjnz6oQ6ZUsqM3eEE?=
 =?us-ascii?Q?KWAuOtgGt3htDxH+bhr9Mwcv4Zt6kRYZVhoCaoiF0OmUXgMFPRyUob8Ob5gs?=
 =?us-ascii?Q?ZLu1zVb5fy3mc6DHxRnaUBZK9VoFHNnpog6DCxpsTpmGdZK+iW755OxvHDM2?=
 =?us-ascii?Q?+ZLBTd9xAXua96oLuFEk8btcYyISjGer6hSOkEvu9Olrk+v+Nhc/DHk6came?=
 =?us-ascii?Q?5nU8R5YN8Dakc9OQZLI+pKUQdewBAbCMZMunSt8rB5KbKyX4LAQ1KhUCFIke?=
 =?us-ascii?Q?AD/RibSe6Njn0RpnmdpcZZIBW9ejp91jyPLh6tGnp8jJvi98262gp3au8tXT?=
 =?us-ascii?Q?uL+wii5h1y+d1DfnlzW1aWDqC6tNmI0xCrL3I3ij0mBU2lcEgFSob5nBz/Dg?=
 =?us-ascii?Q?xF4PYygC1yBGLpH68wkujZ7WmvTRb+3Nlt4r19j2AfRi1iZBB4TKo/4BwTjY?=
 =?us-ascii?Q?eKdVd/JZIyr9s7EuwjKzXM7uwsalZLRbM/SOgN7nEnbUDiKT289OeNsKKYdy?=
 =?us-ascii?Q?s7ckMzJYWcMB5GbKHtN/ffCxvA3lfgS2j2JWpDMVdKmdrwHtasP82iyagjLC?=
 =?us-ascii?Q?Anh5SdvpXAlPVcKJjgaNJBJvby3PkYavTjPCwCkiXjqgNgTmTGEYVY6NVTrq?=
 =?us-ascii?Q?LJ+eGSqI7d2YqA+hbPtL/8xSkG8PDBCnsiHbiDTUgetzEeJx3QxlFYg0IZ6U?=
 =?us-ascii?Q?5rvVW1R8J6TMNmKt4aHA94YUpwd5Tsq2yIprwLFY9xUm1F9kP5CcuJLmRtFG?=
 =?us-ascii?Q?b1uL2+5ke21peP9KB+c2dN4UCHyQv+eTUnbZoYO2rYJQZZ6taQuEYFKf3ueu?=
 =?us-ascii?Q?8EnLqDWMgIGA/CKjEyCpwhgNzPP6JeigFumjApLTCxW1PqDW+dB/BANZ2bsC?=
 =?us-ascii?Q?tqq5B2ygcQ8snCkIktnGGHQzZTa5feyrenCZCwGXiBJAIYMgPvZyXSSxk2cp?=
 =?us-ascii?Q?RjgZ0iZKvnC+XveuL3+SZXO1RKlg2WUu64I69CLOiXUVs+gAcrwuiPbSihWL?=
 =?us-ascii?Q?qFZIwjWqKhXcYMLwnNTCReuoi38bz3PMg99SQASbuwlstk7UDP9vkWAxpHlU?=
 =?us-ascii?Q?9pTSpiqz7pDhaKuzYCqaOiBbdKR0OIINhXD2mBzLjotD8ruocNZOnObhdHt9?=
 =?us-ascii?Q?5k/Tur5lgrh99HVnTMxJ8p1xR+5XsjNARLPRDV7XSARwo3oGT6OETjuQKKYd?=
 =?us-ascii?Q?BVWTNd3bg0w2q49laOK4fJ5emRb99tWIlExisSXehZkCV5PTrWA5ZTdE5PRO?=
 =?us-ascii?Q?9yZp0VW+XAR4keOIgziD4hCI76Lh0YhFYE6XkxSjYgKFMf4fObwD2pamUDsE?=
 =?us-ascii?Q?lujd8aNLCKeckI83mK492Ijyt4PSBhrHC35hykj6QJVXn9XXNLSwTxjCn/f1?=
 =?us-ascii?Q?du66+ZOEU5VAfqPuaNwwpzH80GdfbOlDg1DvoffWxwZmXSB1Ylgw02/ec2mo?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef92ba00-b5b5-4b2f-b0df-08de25ce0df6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:40:06.3325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdIA1zMag+VwnCvsJOuddzaWc086tXDfhhQG4rSW8DfzdTVeNlXed2tfQuAfrpoVuevONoCImzBKFPfIRdt+dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3645
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Nov 2025 11:40:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20579

On 17.11.25 12:13, Sai Sree Kartheek Adivi wrote:
>=20
>=20
> On 11/14/25 23:07, Jan Kiszka wrote:
>> On 14.11.25 10:05, Sai Sree Kartheek Adivi wrote:
>>> - Add new recipe for optee-os-tadevkit, optee-ftpm
>>> - Integrate OPTEE-fTPM, StMM
>>> - Add ti-extra.cfg for enabling RPMB, FTPM and StMM related configs
>>> - Update Kconfig to enable secureboot
>>> - Add wks file for use with secureboot
>>>
>>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>> ---
>>> =C2=A0 Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++
>>> =C2=A0 ...ptee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb | 28 +++++++++++++=
++++++
>>> =C2=A0 .../optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb | 13 +++++++++
>>> =C2=A0 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb=C2=A0 | 16 ++++++++=
+++
>>> =C2=A0 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc |=C2=A0 5 +++-
>>> =C2=A0 recipes-bsp/u-boot/files/ti-extra.cfg=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 19 +++++++++++++
>>> =C2=A0 .../u-boot/u-boot-ti-am62px-sk_2025.07.bb=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 +++
>>> =C2=A0 ...i-am62px-sk-efibootguard-secureboot.wks.in | 23 +++++++++++++=
++
>>> =C2=A0 8 files changed, 111 insertions(+), 1 deletion(-)
>>> =C2=A0 create mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-ti-
>>> k3_4.8+v1.62r1-48-ge9fc7b8.bb
>>> =C2=A0 create mode 100644 recipes-bsp/optee-os/optee-os-tadevkit-ti-
>>> k3_4.8.0.bb
>>> =C2=A0 create mode 100644 recipes-bsp/u-boot/files/ti-extra.cfg
>>> =C2=A0 create mode 100644 wic/ti-am62px-sk-efibootguard-secureboot.wks.=
in
>>>
>>> diff --git a/Kconfig b/Kconfig
>>> index d322a94..536162d 100644
>>> --- a/Kconfig
>>> +++ b/Kconfig
>>> @@ -104,6 +104,10 @@ config TARGET_TI_AM62PX_SK
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Texas Instruments AM62Px SK"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_ARM64
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAS_SWUPDATE
>>> +=C2=A0=C2=A0=C2=A0 select HAS_SECURE_BOOT
>>> +=C2=A0=C2=A0=C2=A0 select HAS_DISK_ENCRYPTION
>>> +=C2=A0=C2=A0=C2=A0 select HAS_OPTEE
>>> +=C2=A0=C2=A0=C2=A0 select FTPM_STMM
>>> =C2=A0 =C2=A0 endchoice
>>> =C2=A0 diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-ti-
>>> k3_4.8+v1.62r1-48-ge9fc7b8.bb b/recipes-bsp/optee-ftpm/optee-ftpm-ti-
>>> k3_4.8+v1.62r1-48-ge9fc7b8.bb
>>> new file mode 100644
>>> index 0000000..2cfff21
>>> --- /dev/null
>>> +++ b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.b=
b
>>> @@ -0,0 +1,28 @@
>>> +#
>>> +# Copyright (c) Texas Instruments Incorporated, 2025
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +require recipes-bsp/optee-ftpm/optee-ftpm.inc
>>> +
>>> +SRC_URI +=3D " \
>>> +=C2=A0=C2=A0=C2=A0 https://github.com/OP-TEE/optee_ftpm/archive/
>>> ${SRCREV}.tar.gz;downloadfilename=3Doptee_ftpm-${SRCREV}.tar.gz \
>>> +=C2=A0=C2=A0=C2=A0 https://github.com/microsoft/ms-tpm-20-ref/archive/=
${SRCREV_ms-
>>> tpm}.tar.gz;name=3Dms-tpm;downloadfilename=3Dms-tpm-20-ref-${SRCREV_ms-
>>> tpm}.tar.gz \
>>> +=C2=A0=C2=A0=C2=A0 "
>>> +SRCREV =3D "04cbc8a136e8fe6731a536f5fe145e2862feafd7"
>>> +SRCREV_ms-tpm =3D "e9fc7b89d865536c46deb63f9c7d0121a3ded49c"
>>> +
>>> +SRC_URI[sha256sum] =3D
>>> "7adfa71c4b49affef7d4db2436d8d6b93cdc3aaa9bdc9cf795c0bf7488a4cac6"
>>> +SRC_URI[ms-tpm.sha256sum] =3D
>>> "b77d092c0dde362adf6bc88a580ca7c8abe124d69bb734bf28f8904ae30494a4"
>>> +
>>> +S =3D "${WORKDIR}/optee_ftpm-${SRCREV}"
>>> +MS_TPM_20_REF_DIR =3D "ms-tpm-20-ref-${SRCREV_ms-tpm}"
>>> +
>>> +OPTEE_NAME =3D "ti-k3"
>>> +
>>> +TA_CPU =3D "cortex-a53"
>>> +TA_DEV_KIT_DIR =3D "/usr/lib/optee-os/${OPTEE_NAME}/export-ta_arm64"
>>> diff --git a/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb b/
>>> recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
>>> new file mode 100644
>>> index 0000000..6e396fa
>>> --- /dev/null
>>> +++ b/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
>>> @@ -0,0 +1,13 @@
>>> +#
>>> +# Copyright (c) Texas Instruments Incorporated, 2025
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +OPTEE_ENABLE_APPS =3D "0"
>>> +
>>> +require recipes-bsp/optee-os/optee-os-tadevkit-custom.inc
>>> +require optee-os-ti-k3_${PV}.inc
>>> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb b/recipes-
>>> bsp/optee-os/optee-os-ti-k3_4.8.0.bb
>>> index f8cd973..e73a7bf 100644
>>> --- a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
>>> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
>>> @@ -9,3 +9,19 @@
>>> =C2=A0 =C2=A0 require recipes-bsp/optee-os/optee-os-custom.inc
>>> =C2=A0 require optee-os-ti-k3_${PV}.inc
>>> +
>>> +# StMM integration, required by UEFI auth variable management
>>> +DEPENDS:append:optee-with-apps =3D " edk2-standalonemm-rpmb"
>>> +DEBIAN_BUILD_DEPENDS:append:optee-with-apps =3D ", edk2-standalonemm-
>>> rpmb"
>>> +OPTEE_EXTRA_BUILDARGS:append:optee-with-apps =3D " \
>>> +=C2=A0=C2=A0=C2=A0 CFG_STMM_PATH=3D/usr/lib/edk2/BL32_AP_MM.fd \
>>> +=C2=A0=C2=A0=C2=A0 "
>>> +
>>> +# OP-TEE fTPM integration
>>> +DEPENDS:append:optee-with-apps =3D " optee-ftpm-${OPTEE_NAME}"
>>> +DEBIAN_BUILD_DEPENDS:append:optee-with-apps =3D ", optee-ftpm-
>>> ${OPTEE_NAME}"
>>> +FTPM_UUID =3D "bc50d971-d4c9-42c4-82cb-343fb7f37896"
>>> +OPTEE_EXTRA_BUILDARGS:append:optee-with-apps =3D " \
>>> +=C2=A0=C2=A0=C2=A0 CFG_EARLY_TA=3Dy \
>>> +=C2=A0=C2=A0=C2=A0 EARLY_TA_PATHS=3D/usr/lib/optee-os/${OPTEE_NAME}/ta=
/
>>> ${FTPM_UUID}.stripped.elf \
>>> +=C2=A0=C2=A0=C2=A0 "
>>> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc b/recipes-
>>> bsp/optee-os/optee-os-ti-k3_4.8.0.inc
>>> index 444f6b3..5ee5020 100644
>>> --- a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
>>> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
>>> @@ -21,7 +21,10 @@ OPTEE_EXTRA_BUILDARGS +=3D " \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CFG_ARM64_core=3Dy \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CFG_USER_TA_TARGETS=3Dta_arm64 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEE_IMPL_VERSION=3D${PV} \
>>> -=C2=A0=C2=A0=C2=A0 CFG_TEE_CORE_LOG_LEVEL=3D1 \
>>> +=C2=A0=C2=A0=C2=A0 CFG_TEE_CORE_LOG_LEVEL=3D1 CFG_TEE_TA_LOG_LEVEL=3D1=
 \
>>> +=C2=A0=C2=A0=C2=A0 CFG_CORE_DYN_SHM=3Dy CFG_CORE_HEAP_SIZE=3D524288 \
>>> +=C2=A0=C2=A0=C2=A0 CFG_REE_FS=3Dn CFG_RPMB_FS=3Dy \
>>> +=C2=A0=C2=A0=C2=A0 CONFIG_INSECURE=3Dy \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "
>>> =C2=A0 =C2=A0 DEBIAN_BUILD_DEPENDS +=3D ", device-tree-compiler, python=
3-
>>> cryptography:native"
>>> diff --git a/recipes-bsp/u-boot/files/ti-extra.cfg b/recipes-bsp/u-
>>> boot/files/ti-extra.cfg
>>> new file mode 100644
>>> index 0000000..faff390
>>> --- /dev/null
>>> +++ b/recipes-bsp/u-boot/files/ti-extra.cfg
>>> @@ -0,0 +1,19 @@
>>> +### FTPM + RPMB + StandaloneMM setup
>>> +CONFIG_TEE=3Dy
>>> +CONFIG_OPTEE=3Dy
>>> +CONFIG_OPTEE_SERVICE_DISCOVERY=3Dy
>>> +CONFIG_TPM=3Dy
>>> +CONFIG_TPM_V2=3Dy
>>> +CONFIG_CMD_TPM=3Dy
>>> +CONFIG_TPM2_FTPM_TEE=3Dy
>>> +CONFIG_CMD_OPTEE_RPMB=3Dy
>>> +CONFIG_SUPPORT_EMMC_RPMB=3Dy
>>> +CONFIG_EFI_MM_COMM_TEE=3Dy
>>> +CONFIG_MEASURED_BOOT=3Dy
>>> +CONFIG_CMD_NVEDIT_EFI=3Dy
>>> +CONFIG_CMD_MMC_RPMB=3Dy
>>> +CONFIG_EFI_TCG2_PROTOCOL=3Dn
>>
>> Some of those are part of ftpm-stmm.cfg which you get anyway. Maybe you
>> can drop them in a follow-up patch.
>>
>> Then you don't need TPM support in U-Boot for our integration - or do
>> you have scenario for that? Doesn't do any harm, just curious.
>>
>> Did you already test if measured boot works for you?
>=20
> I've enabled TPM support in u-boot because measured boot depends on it.
> And no, measured boot is not working yet and it's still a wip. Do you
> want me to remove these configs and re-enable them with measured boot
> related patches?
>=20
>>
>>> +CONFIG_BOOTCOMMAND=3D"setenv pair_rpmb_key 'setenv -e -nv -bs -rt
>>> pairing 1; setenv -e pairing'; run pair_rpmb_key; bootefi bootmgr"
>>
>> This looks suspicious on second glance: pairing with the RPMB should not
>> be done in production but via a special firmware. Critical here is
>> optee, but I see that you are not setting CFG_RPMB_WRITE_KEY=3Dy (unlike
>> we do for testing of qemu-arm64). Still, do we want that code above in
>> the regular, secured, likely signed firmware, even though it should
>> never trigger there?
>=20
> you are correct, this is a leftover from my earlier experiments. Will
> post a patch to remove this line along with the redundant configs that
> you mentioned above.
>=20
>>
>>> +
>>> +# workaround for v2025.07
>>> +CONFIG_USB_STORAGE=3Dy
>>> diff --git a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb b/
>>> recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
>>> index 8fecee8..b97b70f 100644
>>> --- a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
>>> +++ b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
>>> @@ -20,6 +20,7 @@ SRC_URI +=3D " \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/TexasInstruments/ti-l=
inux-firmware/raw/refs/
>>> tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-
>>> enc.bin;downloadfilename=3Dti-fs-firmware-am62px-hs-enc.bin;name=3Dam62=
p-
>>> sysfw-enc-hs \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/TexasInstruments/ti-l=
inux-firmware/raw/refs/
>>> tags/${TI_FIRMWARE_PV}/ti-dm/am62pxx/
>>> ipc_echo_testb_mcu1_0_release_strip.xer5f;downloadfilename=3Dipc_echo_t=
estb_mcu1_0_release_strip.xer5f;name=3Dam62p-dm \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://rules-${MACHINE} \
>>> +=C2=A0=C2=A0=C2=A0 file://ti-extra.cfg \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://0001-configs-KASLR-OPTEE-RNG-supp=
ort-for-K3-devic.patch \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "
>>> =C2=A0 @@ -56,4 +57,7 @@ do_prepare_build:append() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp ${WORKDIR}/ipc_echo_testb_mcu1_0_rele=
ase_strip.xer5f
>>> ${TI_LINUX_FIRMWARE}/ti-dm/am62pxx
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp ${WORKDIR}/rules-${MACHINE} ${=
S}/debian/rules
>>> +
>>> +=C2=A0=C2=A0=C2=A0 sed -ni '/### TI extra config/q;p' ${S}/configs/${U=
_BOOT_CONFIG}
>>> +=C2=A0=C2=A0=C2=A0 cat ${WORKDIR}/ti-extra.cfg >> ${S}/configs/${U_BOO=
T_CONFIG}
>>> =C2=A0 }
>>> diff --git a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in b/wic/
>>> ti-am62px-sk-efibootguard-secureboot.wks.in
>>> new file mode 100644
>>> index 0000000..52fcb09
>>> --- /dev/null
>>> +++ b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
>>> @@ -0,0 +1,23 @@
>>> +#
>>> +# Copyright (c) Texas Instruments Incorporated, 2025
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +# Boot partition containing Bootloader binaries
>>> +part /boot/firmware --source bootimg-partition --fstype=3Dvfat --label
>>> firmware --active --align 1024 --size 16M --overhead-factor 1 --
>>> extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-
>>> F92DF00215AE
>>> +
>>> +include ebg-signed-sysparts.inc
>>> +
>>> +# ABROOTFS partitions
>>> +part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.verity"
>>> --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-
>>> type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
>>> +part --source empty --align 1024 --fixed-size 1G --uuid
>>> "${ABROOTFS_PART_UUID_B}" --part-type
>>> 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>>> +
>>> +# var and optional home are extra partitions
>>> +part /var --fstype=3Dext4 --label var --align 1024 --fixed-size 512M
>>> --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-
>>> b9b3-4615-85be-2a4261fa32d9
>>> +${WIC_HOME_PARTITION}
>>> +
>>> +bootloader --ptable gpt --source hybrid-boot --timeout=3D0 --append
>>> "rootwait rw console=3DttyS2,115200n8"
>>
>> My questions are comming late, so I'm taking this as is. Please try to
>> follow up on the points I made, patching on top where needed.
>=20
> Thanks, will do.
>=20

I have some other cleanups pending that are also affecting the TI board.
Just trying to validate them on another reference board first, but you
can already find them in 'next' for preview.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

