Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030F3C54734
	for <webhook@archiver.kernel.org>; Tue, 27 Aug 2024 13:35:03 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (APC01-PSA-obe.outbound.protection.outlook.com [40.107.255.81])
 by mx.groups.io with SMTP id smtpd.web11.77880.1724765697238437550
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Aug 2024 06:34:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vb4t5K9d;
 spf=pass (domain: siemens.com, ip: 40.107.255.81, mailfrom: srinuvasan.a@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxYhS4PwWj/Yka1LM2Bka67Yzx+CJxo//8Uv9OPDVQ3YjiIHGIUuk+6b/KBCahnBX387mCPaAT5LyYhb2uBpgp4uKblr86nFeMCoxq8F75scG4HVg6HC3bTwQyWFIesIdIyhaGvAj6tIA99FA4dME7NVicyElo41glgQYCjz/cRJ4ML59iJaVhDNZkzw9TAE/Mg1oro26GwGOpz6YF4R9NiLHPDXH5eGXLg0P0hDumVR311NFUVjYPhD9GPlgBsulJWo0kZhtIhGPP6rMEV3Dbd0KP2U3tJe6L3AWvyKqMD12FdOuDRQJlnAADXfN6+a/mq2c3h58zAmrAzJI9QUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1CFbq4t19RyZ627EXk1IjaqB0BcfXjTrsABmAwlqAM=;
 b=rKJIBgpFl7dgSQRFiXaNG0zdWxgC7hfG2eKmbXtzPRVTXPZgnLj/nedD57ec5BfJM+Nrt+QgQL5pkhydxarLP+mpNH/YL1eP/2kBtiEGHp228+WjIjt63jG8lmxHGKNMay8A42d56IKkV4y/pVllZGAUM5HRLKwzVk0vbD4n7wdagC6KqumuxUNiMZ8pk6TaHqZ/TPCONdvYcd6HZOz0TUEGujQ+v9l4ZBAtzTlXlv+M6hhivnOL9mkO8QvcVSDPl5wPdxutaABw2P4o1KqDHlzafODnSr554KAoII7nQUxC8z4wbVtGPWLSE/0f8hX/OhxLO1lM85aO9yT2SXhzdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1CFbq4t19RyZ627EXk1IjaqB0BcfXjTrsABmAwlqAM=;
 b=vb4t5K9ddgZs6hwBTT+/TxZuCZoLkQxfSI5NYf9mVUr918DOe7AFVtv/mNaUdb5WGWIYR9bPYRYyAMcWLl7FPfqpwmx7Q8PlvIeCGs21oB0JyXpWWzxnOBreDouZmZQwG7w+0fLv6PtIhVf/pjjdlTL0hOG/+fefphVAcgY1VHAVHQWOyng/4GqSzPPDxAU+0qnschCuBtfOtvXlT3GytYjNaWCVvHeeJXEPbUpF9aAAktTfyPRKHhkVfYZuto9dc3avy0nUXTxF1meDi59jORuauk3penu54npeOunQ8QCJrWXT/Zh3Bq/7MzBwPWYpxynqJl47giEytcpw2R6mKQ==
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com (2603:1096:301:f4::12)
 by TYZPR06MB5637.apcprd06.prod.outlook.com (2603:1096:400:28b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 13:34:52 +0000
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::d3a4:b94e:29d0:29e5]) by PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::d3a4:b94e:29d0:29e5%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 13:34:52 +0000
From: "Arjunan, Srinu" <srinuvasan.a@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [PATCH][isar-cip-core] recipes-core/images/cip-core-image.bb:
 install cryptsetup package
Thread-Topic: [PATCH][isar-cip-core] recipes-core/images/cip-core-image.bb:
 install cryptsetup package
Thread-Index: AQHa+H7MGIC8Eg8TRUmnQMk5MKFby7I7GcsAgAAAt1A=
Date: Tue, 27 Aug 2024 13:34:51 +0000
Message-ID: 
 <PUZPR06MB574715A2A2BAFDC2D54463F888942@PUZPR06MB5747.apcprd06.prod.outlook.com>
References: <20240827124407.810136-1-srinuvasan.a@siemens.com>
 <3d0967bb-328f-4d15-a9e6-d57f84e595f3@siemens.com>
In-Reply-To: <3d0967bb-328f-4d15-a9e6-d57f84e595f3@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-08-27T13:34:50Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=5e11207a-8dd5-48c6-8e47-19e3e389a600;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5747:EE_|TYZPR06MB5637:EE_
x-ms-office365-filtering-correlation-id: 56c0d622-ad9e-41f6-5e36-08dcc69d07b3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?G8ursPkXpDEjAkrP8Z/EntI6KI/fZGoiYa8h2aeDR5f7jbJ224ebBXOi0ZEw?=
 =?us-ascii?Q?pdzwE7Hg3g+2Gr24kMW3imLAwuh2jBjlmjVmhW6ZRFsd65hyYnKG+0i+0yvr?=
 =?us-ascii?Q?XCZ4J2uiJDpEjFHa22imwhTcOd5yVmUSj0wjphijDy+VQHlqFw3FNa2632yz?=
 =?us-ascii?Q?sKUnpatJMYr8jM/u8g2YShTeiAmcldU6DMaTS2Qu5iQU/SUhUjIa2IR48Fjv?=
 =?us-ascii?Q?4S1iDGiJEXvoof2WoiwjZeYzPkuqTo3pRtc+60sjnLp1ZABqKDsEEkXHG9ho?=
 =?us-ascii?Q?TlbmzR7qtLuV5kFROBMBaREm7ZNC1eHgPca8yPhaD29c8QM9UNE/KoshDKMa?=
 =?us-ascii?Q?7WTFypTQsHETmmI3+Rm6nanheGimaUUPrDFIy1eHBRrcPZzf6GtFr0tlZ7l4?=
 =?us-ascii?Q?BNof5q1Thb9Ph5LsXFWJg1yeOPMOQMtNdsUUFnwPQ3h1rClNn+eW0sqcqOlb?=
 =?us-ascii?Q?NXx/m+t69E7Vlh3PmMyrBqeaaXTDByY+ocrL6lZeDYkEfYzw31Wt0D81OXAo?=
 =?us-ascii?Q?rclCdE4dA8wx6RrIuaOJMJS9vl64U+BnJEnbSpRvsjmsOWJ9EuH6thm0CMuV?=
 =?us-ascii?Q?H4QCANnGw9WU5enz+mPppXb+dwKWXiSauQLhxcYqvThqptBm7drMl1zzzjQz?=
 =?us-ascii?Q?CWY2vqkd/ZxajlfyrTMtW/DurAtmMP9xlYOOrxjrccvCEs3cwiXOlE5cPrJW?=
 =?us-ascii?Q?CA7PWPh9TLydyNsftAVLuyvDY3vjubG55hE07ff72ZGtr9grIlUUEv+QrSTc?=
 =?us-ascii?Q?/Fg9odRfduBPTuf4784hbhATGEhaJSMcxsu9ItiDJiK33b1szPlMixF01/XX?=
 =?us-ascii?Q?x1Qfns8lToHNP4eaSu4vkA+D0QR919FHofeeV6SjYuQ7D6tsv05dtgtMeU3I?=
 =?us-ascii?Q?9gYrjbbtOZGsFN4GcAtKEgJiVF1r2f6nTkVI3twwE46KxOnTro7HA/uxM4i+?=
 =?us-ascii?Q?k5MuYRCxhv2UqvDI7zDwbCNtd2M1q64pjONiqBLHu/7Sz6SZtt1GspfRCZcI?=
 =?us-ascii?Q?T3h8crKLQaZFDYuw4GMfnogYRwycysHa5Z+/enQSJrBArEp2+JNope7MfANq?=
 =?us-ascii?Q?9fjT7kBjKYOmzfdA2brRut5TKq38hMOuRzzM3J+nY3d77Edk4ExGMkpNCjba?=
 =?us-ascii?Q?V+ge7kwzUFPL9muMCOdsOEKyriUlc5Z84qrKjeIUzf7u1TR6wQ2XyoMc5Szy?=
 =?us-ascii?Q?FTddcqbOc55yJl/MnkYuHbSN/eA4/l1mYC4yMkkAi7irtSciQgk7x9S0jzn2?=
 =?us-ascii?Q?OoZyeMpx1QE1pKtt9HFbFxUZ5V65ubDQzfPF84065pJW/vg7xz05EbKftzC9?=
 =?us-ascii?Q?xArPcqPYRhZl0zAj2LymE/vODGEZYgpbSnzxFnYHQA4Xdm+/UDKnh5IXd55l?=
 =?us-ascii?Q?J3bXuWc=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5747.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?a8a5d6d4rmQYzv2M6QwEJ5yDUq4qi8WY2AmbuhjHzt+JJFBrhgROVlKJhFNF?=
 =?us-ascii?Q?OY1/iB8QZFS/6/xPhDcX+ji4WMqTXHDHiu3BI74YJLQRjel3ym1hiC5TDcpa?=
 =?us-ascii?Q?KD0MD+l/JbC4wtj2r39EukHmwioSEtyyPNmT2jxaRapebMXevOsqssFzJXcg?=
 =?us-ascii?Q?fHioTrqM6lU8jFkDBrS1+0S9q8qPhCX2FIW9biAiMaYEmmsCKnAnbyKqI2uu?=
 =?us-ascii?Q?0vzg7wRFhO4W7DCdx5j3vrQrHErLyCm8opUEJtapt/+hOY6alTfdNr76XSeJ?=
 =?us-ascii?Q?wuTL2HtAQiYtTFAPABKLkCWACwkUMsucLT6RgtY/Wl79DBPZKPenIO/lWI8T?=
 =?us-ascii?Q?x6ZSPgyk8oKi3CCK4hJfxot11c4jKlz1Um7CUzYdqtXwG0p+3oj4+0VKTcpp?=
 =?us-ascii?Q?NVDAfWgICE1Lo4C8P5GqTB59ZIZAZtEd+IHPhsuANVU1yhyyOiFFZ8sLKQ82?=
 =?us-ascii?Q?st0JBdIEXFElrYLO2w5hnU7RqZh68nIFtkn9ccCXOJjEY9IJtVYkCCprzz6v?=
 =?us-ascii?Q?XFO9pTYrEjEp28o1RxbbV2iB2DKMPGvgOfbwppknxsz3p97xM2PGVf2k2BAF?=
 =?us-ascii?Q?XXTu6z/w2suSMVJkdLjNgVIA8IfUN7eCiVqeBggfvYmTwImVPEIH2UhmqxRy?=
 =?us-ascii?Q?JD8oZLEOykbRpbNwX2wVWxvzkvrypDJRQ8UdCQnWRkZbegvFEVKQswFsC8kv?=
 =?us-ascii?Q?klrg0YcGQZ4JqF2UxjerVxRrsw7XxGil0U5jAPVAqFjKkkEKCe6m2LvDL7OM?=
 =?us-ascii?Q?PXufkBS/N1atah5j6UALBqpfYo4W9h/osEQjb42x4bKu9haozaPnE74EludJ?=
 =?us-ascii?Q?QIjsNoFwEmBzQn1Cz73UJUXdEeMJTHvjHi8hF0klVPXWWLQKrlqglhJ/hOQM?=
 =?us-ascii?Q?ELbi9tt3V+ICgzy1zALu7VfXUTy+4KxefumRaBJ198ysF3mLlSBdBJ+XO0V2?=
 =?us-ascii?Q?dp0kHOOO3X6aTn5uHEgCov3Q4PphEMYzDi/ItYUj2vY5TcahB14d2hc6z+i8?=
 =?us-ascii?Q?I7br41A2WEf09i+sOF0Imn7j/im/X4Z6B6zedfg98zrMWeBKsg6VBx/j46+7?=
 =?us-ascii?Q?RamqGMDNb2IctdKW/XQPAV8HsXQbFf02bqlTBebsPsf9F6acpY4lfGhKkidL?=
 =?us-ascii?Q?a+HH+36OvhV49t4kwUt6DnshekdIsOsVotJSpS2hxAcCWhCNjF4dMIkWtcCX?=
 =?us-ascii?Q?BBDnp7oA/pmzPSaIBryPzUsCVesFFctCo7L4z6C7/gaQPI7vguTVneniv+0m?=
 =?us-ascii?Q?J/ju5UJnkjyuA6/6PGMzji0TrdjD86U6rn40OpSGbadqaXkC3NSQSB2xsAhw?=
 =?us-ascii?Q?cTtlE4LSYPf3dzDkjrQ+pTa4BL71Vlp79R/lsY5XSKnlN4EVkrjwd07ervqf?=
 =?us-ascii?Q?f8YOzNkMmtnxsTzOAIGnXcZFVKP7cmWOvuAc/JHce9OgGy+ZjPHnYRged+X+?=
 =?us-ascii?Q?3FBV9dwz8+ZQBoS9211qN8aINuiBOJgmyfI30KTSYlIisRvtJ4NEWFY1MrqV?=
 =?us-ascii?Q?+boEMNJ61+5v8jYCndbhz9n98/Hnz4plB1nvXVxI+S+vG6a4Cw8Eh3UcsEmP?=
 =?us-ascii?Q?BwUxq/gWHkJ829HLR4erQORTUnbfrFRR3mC8dHFi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5747.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c0d622-ad9e-41f6-5e36-08dcc69d07b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 13:34:52.0624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lzngNvLwvWAe1vVp+bBYNhlXx4/MruUsZlZgZ2Y802qUNET9MONW2NEiWVEO3P5S3GUJpQrxZSEYr9ZEnxB4OcvgsK3PrRz9q9/LRtN3RXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5637
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Aug 2024 13:35:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16817

Okay, thanks for pointing the patch.

Many thanks,
Srinu

-----Original Message-----
From: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
Sent: 27 August 2024 19:01
To: Arjunan, Srinu (DI CTO FDS CES LX PBU 2) <srinuvasan.a@siemens.com>; ci=
p-dev@lists.cip-project.org
Subject: Re: [PATCH][isar-cip-core] recipes-core/images/cip-core-image.bb: =
install cryptsetup package

On 27.08.24 14:44, srinuvasan.a@siemens.com wrote:
> From: srinuvasan <srinuvasan.a@siemens.com>
>
> When we validate expand-on-first-boot with encrypted partition, the
> last encrypted partition is not expanded due to cryptsetup package not
> availabe, hence added the package in the rootfs.
>
> Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
> ---
>  recipes-core/images/cip-core-image.bb | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/recipes-core/images/cip-core-image.bb
> b/recipes-core/images/cip-core-image.bb
> index 4a9cea9..28f5f3c 100644
> --- a/recipes-core/images/cip-core-image.bb
> +++ b/recipes-core/images/cip-core-image.bb
> @@ -15,5 +15,7 @@ DESCRIPTION =3D "CIP Core image"
>
>  IMAGE_INSTALL +=3D "customizations"
>
> +IMAGE_PREINSTALL:append:encrypt-partitions =3D " cryptsetup"
> +
>  CIP_IMAGE_OPTIONS ?=3D ""
>  require ${CIP_IMAGE_OPTIONS}

Please see this thread:
https://lore.kernel.org/cip-dev/20240823161906.1168642-1-alexander.heinisch=
@siemens.com/

Jan

--
Siemens AG, Technology
Linux Expert Center


