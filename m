Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9DFD3F075
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 14:44:43 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14907.1769611473015867364
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 06:44:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=CNSGcH8O;
 spf=pass (domain: siemens.com, ip: 40.107.130.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djsDNT6e3xaB5kAE+6rjSwzMq/RqDDI6P5DZuyfGhfr5GYyPR1A2HU7LWKw6IKGGx7uZUCkLS+YuODYqpXZ7adVX54EY9BnMGPXFJbF418L67O9jzhTHoyOqeqsgaFcTIEE+2hM3tYJxwYrlSBOM6mqTinIpJWzyYQT6yqc6K8Aup5BBPGgBdBnVCTFflVSzTanGKS8/FTfmQQiXecubMBSXNmi0cSNU5qVxIoAg7pMbFZR78UbXCLRYmPu0Wk7RJS5lljj6/Ui5/EnelgvLCAxZTjAeKAvhfE6XAHj6bHaz+vXF55I+P/bxOFyuU7TUwYDROp5FsARVL0N4/iJmaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+AvSos7YqXWM/QP8Rme72sPuN/c+GJ3S6mRzJa1lgA=;
 b=MomyEB5Al/bC1zpXn8hdJZbYbTnI6JvA6I2hylwczsI8f1muo6TUsXz05MKZk2cc7lk2RndeD3YCO7wHrNi15mbsuizhXx4xiT6FeeedGtI0kvEvzE28tpZaGPs3hNo6bG6Utb3LEJktVVkl1dYBaL72p7Pa+auH5fCeNrqUfWhtn5avz1eWShZyPYU+jmhZ5NVRZhLdfTmMMQGnb8OZRE63J8hBxKF2XJsUoTe2pMkZBp529Yd9176DdqQLHLdBuSvxe8CuMr5OyLBwi/rs1C0BRfjOezpqFhhy7lrDeJ0YosumjMMEd0O9snpAXGRq3x6IXJoegd+XfjgKNXxytQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+AvSos7YqXWM/QP8Rme72sPuN/c+GJ3S6mRzJa1lgA=;
 b=CNSGcH8OLx3A+NmCry2Qd0VynPxLCidwW3y1D3JdyiALvjUtZkSIjeZJG7L+kTq0aNV1hFyuOGYiPU2QGuO/O00st5SM16n2/wVdKE1NJdIJQtONNFu/8TT8FFF9n2ro5lB4FeSkbhTCMmLeQorkbv/lTa5XgzxY2fQMD5C/tmYHtXQM7VIGMYPp8zsKffBtvcD+Fon3E2vaml4YjUbMLAqcmIUoHmbgwdocZ3b1K7hIPeEGJqnFA8eEK1CWk6z3MLg25+wNfY1rfXuLzX8ZXLgzxZe3a1kynetmKFb4boIfto7bnG2Jh94xgbzByfUEeEkECTa17oych0Kkr9PCDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7366.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 14:44:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 14:44:28 +0000
Message-ID: <442bbdc5-5d46-4ce6-85be-dabe01ce52e4@siemens.com>
Date: Wed, 28 Jan 2026 15:44:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 0/2] swupdate: Enforce signature
 verification
To: "Heinisch, Alexander" <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
References: <20260119162444.672037-1-alexander.heinisch@siemens.com>
 <32bacc829a084a0ea04f52ccc568e3f2adb27acc.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <32bacc829a084a0ea04f52ccc568e3f2adb27acc.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b30aa72-7552-4021-cdd1-08de5e7bbd7c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5BhBw+9SRCN8/gMKy/VMxFELtcA6fQm0V6ZFMQNsU2FInf0ThUtEy7vOPhwz?=
 =?us-ascii?Q?AXXEiNrSDp/J2NGx9RQNm7rYZJSAmePrlSKCueMjLbWIWKpBeZiOiRB8bkzr?=
 =?us-ascii?Q?gTzoXPK1hqGPoMblxMFJQYvTDS64YNeAE9LUL50uKAuoV2/wXVt7J/9OPDvt?=
 =?us-ascii?Q?WM0eBOI85w8cpniPdqxuuAfbvovpCKkePaW7AzKAIvsdrMekltqRIBn+sGsb?=
 =?us-ascii?Q?D2mpTR8YBMlN4L+OT2q0q0+E8H01b+WCXF5xPZCTciS7z8XBmfwsKjnKTVwW?=
 =?us-ascii?Q?K536YEpB86e91UAKLU4BgfHUQUsCYREiTdMF9Zs24ps7DFQJ9EN/fh03dW64?=
 =?us-ascii?Q?lj0RnugZNDBYTX9LMt6wCUVAk4DKRg+6DsR9J7QEMkwHEbInivhdTwSK4X0W?=
 =?us-ascii?Q?vh0v1qQv1OZARYMvYOcwY20vGfCeT279zR/lh4BcF/nHaERh3o7dxELr3Fh9?=
 =?us-ascii?Q?3Kh1yn2B/e0XBq0sdPpzDiVyNBVmOg4HtfYr+qDgRK31ut1f8CCCP9YTF32D?=
 =?us-ascii?Q?ytQQbG/MP9UH3PXh+pSY6Ls8e6rzR+ZZeBcPrzA7LRu+vJSyL9X8qFDzmuGP?=
 =?us-ascii?Q?OalXSD8Hd7lBeF9ylOj16k/vbML9a523tyrGZ+e3BBinxrim+OSwT+TULD4S?=
 =?us-ascii?Q?b7rHQvhL5UQ5+pFgep6k78EkBtCR5xH63BZysqiMezMT/coONAE0VBcPIfZh?=
 =?us-ascii?Q?H2WFl1twurO1TewJ25J4MWpyH2fc3zsoWpJYL/6hZRp6mGxYRjc3Rk4BtT1N?=
 =?us-ascii?Q?7onjsvxPqlr6b2EecIq1xmIF1BQziCpZEjiIOFa5jfLJHm7jl+ZFcwevVr09?=
 =?us-ascii?Q?5XHwLDSH8Sl7dkDkR9Zg+Wgp5J5KKrC38fcrnxOaH3yAmCO3Vuj6xmQU9zqA?=
 =?us-ascii?Q?N7HP5lKTL9Wv6RD6YTDoOSLnd+0pgddR3Uo1V/a/uSvCIgdyZGvxtmTUnp7I?=
 =?us-ascii?Q?GsyjEmsxswGceBUoG8MXfZVAsSLqmQjy5WhGYis6Fb4r0o6xRsEacsojZfbs?=
 =?us-ascii?Q?nONtmEuWGMBjS8qbgepBnZPN7LrgM2bSPWg6coRZ+8zvIqjhhnqhxfDIjQ2Y?=
 =?us-ascii?Q?JTH90D8dr3C4AeoAe4cQS4dBPS1oWeJPuAbk4YoSu0s/cCqKt4l59IsdENkI?=
 =?us-ascii?Q?63JdBxeeK0/Hw1inOx15asArcLnVXj9vZbI1X1VNUI34WziWfrhTBRzmE6QQ?=
 =?us-ascii?Q?lHiO/VnefHjklBd7lQ0yZEaaCK7kzewq7rCuFgqhotWGFaeL/LmPhUEX8ENl?=
 =?us-ascii?Q?h8r46Ru5U5rwHq8qGWrEzPuiCXgvWXE0UISf9DgPT4YCsrhh5SfynUw6bePe?=
 =?us-ascii?Q?va6UQ9CWcGC7KqoHJ2RtO4z6MguwyOJO94FwbBBdP22BabUUPGA4sJGOrqk3?=
 =?us-ascii?Q?UqCmgVTEn0k1+b+keP6UMII1vgakiPPZciDZTj9JfR77rcRK3vFQmZp3t9tZ?=
 =?us-ascii?Q?zSZfpZvPXAs1j9CzYtMnlVwcASrIeHBKZn+KlSGRSiyAa8fY9fA0FliBQWky?=
 =?us-ascii?Q?nX4XzbQvSB+AbVH7wTboz6xZxpR6imJlZNxEwZ8LxOFc56JciMWhahSM5lxq?=
 =?us-ascii?Q?m5GCwfRYE5O4U2WB3IE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lsvpyOI7F4Oq54F2RcnJMGDnC2Dp5WxKcoW7vfGjq3WS2akTsMJ7L7EhE9eA?=
 =?us-ascii?Q?otQl0JKlLTqK5zY++in9KlcPkMGZLtIFcH+1WcgOo7Qgh1xB8JmA7Cxu6AD/?=
 =?us-ascii?Q?N6GKElCThz6tZfGENKLlE++RdW9Yc2pLMF7YQc6Ioh7Nze+yS5p2xyMRL+vV?=
 =?us-ascii?Q?4bTiwYT20sv7KMHcYLsBBrkBPr9Qn16943T+9sWDOBOMCCb6ZWEGbjyWFDBX?=
 =?us-ascii?Q?q6yPStP49tonOgodW6sDAHpSVqmPXfBwjx/0wAyiGEiZ1TtWF8iS0CMruXGV?=
 =?us-ascii?Q?fZRLx0b7KXx0UW8/i1wMrqQ//DKtqvp6ov2EW0giRO1pxMv0i8SPD7Z/npw6?=
 =?us-ascii?Q?Ge3GDayS0qsNNAvy4jqqsKj1tqNtKu3nH7aM7+tgg2LtK66sjvg5zY2QKOwj?=
 =?us-ascii?Q?gKmi3QVH2K9fTHdwpRuoGJpdZeNSJtgHIDp2Zo0XVSZkSSA8I/FaJqExNRF7?=
 =?us-ascii?Q?cqPanfiVu8wiTyKQgI1D9II4v3wzSwzBd4RYNqNwgl4EZ7P39i7KMcdblUkn?=
 =?us-ascii?Q?fvNC068+d8rDfM5UdGyfGzSJznwL+aLmx9+K/fQug12atQXZB1XKoCnhv5qy?=
 =?us-ascii?Q?k6cHh81qddVBnyEAuvfCRbnIzTkBb8Rw3Au4PGIuuvdx5FlWw2EK5GgcXkZt?=
 =?us-ascii?Q?78z6V4qM4zeBlaJ/wibvmUaNb+2dWtHw/o305dyq3iaK8GqMdc7jws613e4+?=
 =?us-ascii?Q?6ZoswXsLIGfkoQ3Uks70DFEB5mHX3zyQxDkUN04iMnrnGP113Vl9nW5a6rcm?=
 =?us-ascii?Q?JGAXN27eHtpVcaBualrJG7/GVDW6Et7KU3aTEe9HA7jFeRg8V5Xi98VVRmOu?=
 =?us-ascii?Q?5SPwm+ZpaCiLMf1qJMjN1o7nz/ufy4b0IWpy19NsJXoUgm0f4M5ez1Mk4z2d?=
 =?us-ascii?Q?PbrAJJhMGKlbYHLvVCzsZDRg5ImfniUDhieciGB1CEkH7X3mhisVhZ+6CUiN?=
 =?us-ascii?Q?D97rFU+Dsyk2QLoPuA6+alB4ZO9rJAVtA6IZ5Kr8KGhFRnKjCKacQ+iEviQw?=
 =?us-ascii?Q?doFwfdO82oRg0W2kYLcgwNubyk3YlhGCZ1oNhgFjV0Y4yl6c+tIqDV1rUN7H?=
 =?us-ascii?Q?N7juQV4PdNYud+yCcs+phcALsSqMfz4z6mIn4gEGHwj/3xvMnL5C/2limSZ4?=
 =?us-ascii?Q?sY+0bnBa9syXQu8zwAniEMvkohn0gSdB1YWoVYvBp2uwT6as4H8y/jXv+UIC?=
 =?us-ascii?Q?PXmzoU4/AUbFXl9Vbtxh00lKeQ7HHZCWP6W6nNyrbAXNgqZalts9SvCPJS82?=
 =?us-ascii?Q?bhAB68WR+2gwEbDYLJJ7SQYQn6am1VL7AbdX39jFxrzkhJJOU6IcRSLhSd77?=
 =?us-ascii?Q?pjHjmr89V+MQervEOfJP73XnFhDViTvzItpprsLF0wq0gGe7sc+ekLexzyP+?=
 =?us-ascii?Q?aKowwALOeqh4k7oX9BAUkyqsTNhv3owQmpnFtOsypHzZFwAD8Ufi8apVc8V+?=
 =?us-ascii?Q?PMqRniYEG79IJAk61pLTZsCJTo5gLvDhsoz8Q3PMz0/OIwIQYOcjgRE8Yp7h?=
 =?us-ascii?Q?Ir8qcixknlcMDI2LPc5x/q5eaJt3FFYBWHoRGAJbrdThi8xwyQHfmAcc2NFl?=
 =?us-ascii?Q?lRlE8Ilh4NnP3MuEVegc7z3IgbvjRTywpnhtW9k1XH3nHhGHoMsVDYGAgGoU?=
 =?us-ascii?Q?fcpF5IqUpLGyMC6t21tAnhzQPEuDj3I9BjA9XOoVwNVHp0nr1IQyIDvvnMtm?=
 =?us-ascii?Q?5WfwJj3VZM1QCooKug4N+sZoUu1A81Y7KCmga2aIwiB6ahdkkalObXF6ihpg?=
 =?us-ascii?Q?jMqG0kepqA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b30aa72-7552-4021-cdd1-08de5e7bbd7c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:44:28.7870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/MFfnJbYbEDHeYo/RQxptyOeFkp/D2cwE1PNtMJvB9r+7hm9cx6iCW9Ar4F1yuS5j6QivMPD2Rn44BYP/vdOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7366
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 14:44:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21765

On 28.01.26 12:15, Heinisch, Alexander wrote:
> Any comments on that?
>=20

Quirin?

And why do we need need to flip SWU_SIGNED in both kas configs and the
recipes? Isn't the latter sufficient?

Jan

> On Mon, 2026-01-19 at 17:24 +0100, alexander.heinisch@siemens.com
> wrote:
>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>
>> The self built versions of swupdate (used by default in distros <
>> trixie)
>> do not enforce signature verification.
>>
>> ```
>> $ sudo swupdate -n -v -i demo.swu
>> [DEBUG] : SWUPDATE running :=C2=A0 [read_settings_file] : Reading config
>> file /etc/swupdate.cfg
>> [DEBUG] : SWUPDATE running :=C2=A0 [read_module_settings] : Reading conf=
ig
>> settings for module globals
>> [TRACE] : SWUPDATE running :=C2=A0 [swupdate_dgst_init] : public key /
>> cert /usr/share/swupdate-signing/swupdate-sign.crt ignored, you need
>> to set SIGALG
>> ```
>>
>> This patch series enables signature verification by default for
>> swupdate.
>> The series is split into two patches:
>> 1) Build swupdate with signature check enabled.
>> =C2=A0=C2=A0 This simply fixes the provided demo build configuration in =
the kas
>> file
>> =C2=A0=C2=A0 (+ ./kas-container menu).
>>
>> 2) Enforce signing and verification for swupdate by default.
>> =C2=A0=C2=A0=C2=A0 This patch modifies the swupdate configuration files =
to enforce
>> signature
>> =C2=A0=C2=A0=C2=A0 verification by default, which may break downstreams =
relying on
>> unsigned
>> =C2=A0=C2=A0=C2=A0 swupdate images. However, the diverged default config=
 for signing
>> and
>> =C2=A0=C2=A0=C2=A0 verification of swu files is probably not desired any=
ways.
>>
>>
>> Alexander Heinisch (2):
>> =C2=A0 swupdate: Build swupdate with signature check enabled.
>> =C2=A0 swupdate: Enforce signing and verification for swupdate by defaul=
t.
>>
>> =C2=A0classes-recipe/swupdate.bbclass=C2=A0=C2=A0=C2=A0 | 2 +-
>> =C2=A0kas/opt/swupdate.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
>> =C2=A0recipes-core/images/swupdate.inc=C2=A0=C2=A0 | 2 +-
>> =C2=A0recipes-core/swupdate/swupdate.inc | 1 +
>> =C2=A04 files changed, 4 insertions(+), 2 deletions(-)
>>
>> --
>> 2.47.3
>=20

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

