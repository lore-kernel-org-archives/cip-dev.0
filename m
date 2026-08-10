Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D040C5AD55
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 13:07:08 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.29070.1786367225340840590
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Aug 2026 06:07:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=wD+jMLq0;
 spf=pass (domain: siemens.com, ip: 52.101.70.31, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGxR09oEBuXeXtd/roKHoBI7JZ2MAgc8byYFp4FA+c66hi33T7TtEaOoFeqNF0R49gd/BGCVS9QOUqMrzcVKm34ZbO4MfmLKVewVoptRLP5oqeSIHB8mphlYX2siIjmsIPy5vFNZQvgfCaSWSWevbMlWZmmR99SvvTzDsk7AR2iPDUiZ+oJz4LNtzy3ysIJSjDk88Js8vyAujhxcR2NX+M7fatQs8+Hn5j48GsnKnc1GDOJPcOe/NhhtgYNQAIkAwMTJqUD1cJnLop2OmNPJHWzLg9L8FkLR+xtYGFMscE7oepLQnwFwWExlHYHmemkCHOOSxCfjDrdI7/HkIx/YZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Og7xmcoUimAk5IVIFYRBPz+R7ReDcw4tWrIvAF+pUcc=;
 b=sDIiE4Q2RjvHPXLaC5LgVXtJ6OvZrIlCkMuYqv3wLoK8TfzrrftE5KPWzl3RzydHT3KNYubBm98ZoDsK2mde5ovkOnP12ljRFmJWpwhKidMp4zslhG4pvjdGXxPvLpfbUfQkkZ5SGPVe0UrK2+xCdTay4RLXoZ37cWKBWGl2QKR9X7liumseJz9weRq57tMsqdELY4r6+cJQTDqQhBoz+vmO3SH9z+i7K/Vb0FQXMfNFtxVJQr2gN1oVmzU1/GeD9XX5hHC1rR0OnTpkn+ZLytMkNJ11OvsVLCP0/8oJKiRbP418W9AQpPelcyXvtanrxKjoQSgWPaD6O8xisOsIWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Og7xmcoUimAk5IVIFYRBPz+R7ReDcw4tWrIvAF+pUcc=;
 b=wD+jMLq0xprO8lqTMcGlzm+kJCT9WjJ4LW/Q2SHqyTGz0oTzxS43Lud40yHLYVVezgJEeEQr2xvmITLDeUDalHxuIza88IdzSi4FjL4ea2gFRkyKh74E/HteK6fqVAQk8/iKk+FSfpv8Ky+Y7mrRrouVgGnPKlDJq+aBVbjS0qlSOmLA7iIFRSzAqRqN+WKexJgH4HWUse6BO/LrXxEyyIq7Rv0gdjqxjEqcza7J/iki2DaFxmTV48bkBs9Iy3oPS9nJPUT2zxLLQJs/e32Z3FZiuvzfXpm2aFlVeRs5zvJUd44tzAO4mfCOowRZHEK3CLRfDMSdR9WxoRTjbcQTtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6725.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:403::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:07:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:07:01 +0000
Message-ID: <5eedc605-7ae1-425d-876a-62c183e3a79e@siemens.com>
Date: Mon, 10 Aug 2026 15:06:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 0/2] Remove unsupported combinations for
 factory-reset from Kconfig and document them explicitly
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20260807154439.625212-1-alexander.heinisch@siemens.com>
 <31174e6a-78c9-4fce-8d1f-dff403e1f6aa@siemens.com>
 <b45b4dd0-03cc-4df8-94e5-ca3405e2732b@siemens.com>
 <4400621d4db82ea3313ff1907d4ef664ca0cdaab.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <4400621d4db82ea3313ff1907d4ef664ca0cdaab.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0407.namprd03.prod.outlook.com
 (2603:10b6:408:111::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ff9693-623a-49b5-7d3e-08def6e04408
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|55112099003|22082099003|18002099003|56012099006|10067099003|11063799006|5023799004|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	vopg+q35H3NkSqSRK+bug2QITEsAaYGqFpVU2f8dGxiddNph7Rw9+8AE2b7OkPgV578q2SVAkeg0FXCGUivXJVHqfisKuL06HZZ0Xy7e0ZX/DTpa8QQ4ixixhAUqOnRG1Bf2qunHiuIEOBPEK9h1q1IH1gBOrjG75pH5X7TTZqV9tyPHtgQJYQgKm3X03sACKbVpxkdbgq5riTjx3EE9MqbVtG9+RiVghl8p1B4Oh2wpQJiDBvl0m3ol/ZcPaMPOkt/Swgqex6Qj93gufrtl3bPJqHhZEB4sbY13hMOiYKhB4Bhu25ZDdt+kzI5KTg0+hyf4SjkhJt2uC3S0q8M64taTNvMNqHDWgW8CxcjF5xN+RFVFPFcl1HlGW4rkvDMq7SksKVpsC/9SecUvTGjTeydUdz//EUhg9LkubW8i4SEkLV1iulKsGZZPcRCnY9bHj7nKIyU2uZheXIWEQrYwIVAgbFyohwUhsBdn1in0QuDW6WlahUaL1M5q+QnWOsdeEKt+hmgfY2NSowOVtx5KSgWW4OyYr9mT4d3rQnTFW8sgMpQqp7mmncVYKv7zUnJpS8WAl7T1T4ous1BKvcdpoXnuRbLRc4cmQtAwSqzINrK4s+yunRSlwKrR7tytgWOtcUZCoH4sc8xksNpG31lKl8IXUYr9E4HzKz65g/pkc68=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(55112099003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(5023799004)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pmQ+001BH8dXH8OrZcPgUmM0mcUW7/OXZTA++E2G2oLfIoFRYUrEy77Qvrms?=
 =?us-ascii?Q?UuJazvUgcuy9K4DowSo/KLzhJzFUjWG+8ab4z4za9rxtTY1bTZYOWaZ5xx5t?=
 =?us-ascii?Q?6xQ96LgfFXcWhKmKCTqotRYaCD6Oh1efX/cNQi3EpZbJE7hl8nlHpm7wNmTe?=
 =?us-ascii?Q?pCAcQS3kkGd4WM0c+vzFMUMNO4D+9tjq051yHL57QtKmv3ddqxuYp1X+63Ih?=
 =?us-ascii?Q?vthZxgS63iTTKSUPPjQuNIk2DkBnuoMYYUtrDdVvGCt389iAuogCSGBLWX6b?=
 =?us-ascii?Q?eQnXCJywMcPVQ0a+qztT2sOG8DXp87+XrdWkscGvoFK1aoZn/rCCnNr6i/Fz?=
 =?us-ascii?Q?RZIsByuaRD31RPkUhNVyhAnV2q6mqxCYRLDhcaFoaytqLPtL3mSeGxJIzxQ7?=
 =?us-ascii?Q?rlpNbPYsbnOl2wdlVsVcdj8uSO31JT5SSCe3JJg0MP4ZZ/bBdoHrvRZEyuY0?=
 =?us-ascii?Q?bMK5yqrJ6PGCc5cNklyNu3XwsUcm+9D9nIVBZwRYOgMD0xCwbKLv1XPojyoE?=
 =?us-ascii?Q?PJ0bmiuYHEMiMxJIjkEXpF0Qg4DAJQrMYMTz1IHHeiTehnYzK09IAzUZPhyr?=
 =?us-ascii?Q?eklnMonMaj2TYx1uWvEJbgedYRBIQLUcJZSj4cOopoBQ9gOoBwRNasZ5yJE7?=
 =?us-ascii?Q?JNrKtPdO1WtgELUlKLhIK3S4tOa9viOz0W9e94kR/GVSkms6B6mnMCdnCYa0?=
 =?us-ascii?Q?DJPN3fYu6Vcid0n/A3KY/A7mjAFl2fNyfn3P15t5908QrBOAAwHb/pGg2J5X?=
 =?us-ascii?Q?0GzLQoTMSQZwq6/sVOJ4pk7uTPbPP5mlrIR3U9f62Dgdrspt59mHGXRNBg6k?=
 =?us-ascii?Q?+hL1b5PEOVLS4WKx2XFfAUz4WdqHwPLtb1ThNEwqYqIKdUe16S/wEtXipEUX?=
 =?us-ascii?Q?oOWiDqMQGiCljgRQp4Ul+64PKr1GFE/JXfHYjoBsALyndfInNYNW3nFto5MC?=
 =?us-ascii?Q?0v0NKonLfzf5hdQtqSFERd4OaODNsvIo9mIGASvAUZR8igETKICgiMgxBYem?=
 =?us-ascii?Q?WjiL0RxY4+c6mzZC9CWAH3eaGtl33lBD0ylkZrN7Hnb0Bo1RKYYyRLLK+jNN?=
 =?us-ascii?Q?ikhiGpxqP4S7V2lekmyvAgeETgS7hn6CkOTv7fulLFbDcJqfzYjfU1f4iyzK?=
 =?us-ascii?Q?XykktAH412eE+7RFHTxN5bg34AYUQFESzpTfqXT4orLraOOxqMTArur/atOb?=
 =?us-ascii?Q?ftS7qECdn1ni99PRma/I06kTG8EzywbLduXBSGMwq3ujkh1O+8F1njlhhCkW?=
 =?us-ascii?Q?iEM4VIVgmjRMwwj4064JOELhbn1DIuX62DqwJa1U9KfHp9p0srKyUQWaf9KC?=
 =?us-ascii?Q?t/JsxcpTyoRbrGOYmosgBzQB+YdWRiVxLEZxSfCY4mz91aBHOb+a8rr4mmvX?=
 =?us-ascii?Q?EsyLJqjoMsPfsXkeht2fcKgg2TNDQ6KZEKSF8skKaFgkvsD8qNdnIsd4DDrZ?=
 =?us-ascii?Q?aMAsksrq/UsxQk/phDL1YbfphlGkuTnVLt5R+lUEAD3X6iVmvExDwSp4eRt6?=
 =?us-ascii?Q?9Hkrb1e4b48LOIfDLnzPPHWH4wKx2dZt/D17VbQZF2LZPEo4kC7DQNja+TCp?=
 =?us-ascii?Q?DtCbsmd6J7eVgOE11PHbkRJzg+smoNSiSCiZI1+b5iqWV0TlNk2F/D2X5C0v?=
 =?us-ascii?Q?ZWy+TWnTxr8qaqvAmV5f6ALzH0rOY3XSoNolSTIDH2fsua0Hz5FJaHX07SOn?=
 =?us-ascii?Q?a+7J6VhssvNqCCKc9/0sGhXi/WKhhWykSD3nFA2tMZ2azCmYmpnBQqPYOZkA?=
 =?us-ascii?Q?VK4L2qbJSk0jvKTQaAlJ1NTX6Fe94j4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ff9693-623a-49b5-7d3e-08def6e04408
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:07:01.0016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkEGQsg7x0pIvIldjcH0+DNC9guzt58L8XTyEHJn24KE1WJLdXnofJp83+W6Ux/kzGqHkY5uymQIjpTSt3HtHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6725
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Aug 2026 13:07:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23886

On 10.08.26 14:02, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
> On Mon, 2026-08-10 at 12:39 +0200, Jan Kiszka wrote:
>> On 10.08.26 08:55, Quirin Gylstorff wrote:
>>>
>>>
>>> On 8/7/26 5:44 PM, alexander.heinisch@siemens.com=C2=A0wrote:
>>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>>
>>>> By default factory reset clears the tpm. Therefore, keys needed
>>>> to
>>>> decrypt the immutable A/B rootfs in full disk encryption setups
>>>> cannot be retrieved anymore. Thus, the boot fails and the device
>>>> cannot be recovered.
>>>>
>>>> This patch series removes such combination from the kconfig and
>>>> documents
>>>> the issue explicitly.
>>>
>>> This was never in scope of the factory reset. You could implement
>=20
> Probably, but it was part of the configuration options. Imo, those
> shall serve as a demo for isar-cip-core functionality, and only include
> valid/supported scenarios.
>=20
>>> it by
>>> moving the keys into the boot partition. But this move will create
>>> another can of worms.
>=20
> Temporarily moving the keys to boot partition, is not an option.
> How are they secured there?
>=20
> A reencrypt with new keys stored in TPM after TPM clearing of the
> partitions holding the rootfs after they got unsealed could be an
> option. But yes, that implies major rework of the factory-reset
> workflow in initramfs and potentially has side effects / dependencies
> on crypt hook local-top. And yes, there may be a small chance to brick
> the device when the device powercycles at the wrong time.
> Else, a more graceful removal of keys from TPM could also be an option.
>=20
> All things, we need to think about in much more detail, also
> considering the number of use cases for a true factory reset support
> with full disk encryption in place.
>=20
>>>
>>
>> We already have an option to skip TPM reset if not desired or
>> problematic. Why not use that, or build smarter on top of it?
>=20
> Yes,=C2=A0there is an option to bypass TPM clearing. That's also document=
ed.
>=20
> The patchset is only about to document that the default factory-reset
> config does not support full disk encryption setups and not to offer a
> demo config option for this non-supported case.
>=20
>>
>> Factory reset has already way too many limitations. I would rather
>> likto
>> work in more cases than in less.
>=20
> Without major rework, the only option is to disable TPM-clearing for
> factory-reset in FDE setups, but that hides the fact, that it is no
> complete factory reset. So either Kconfig shall be explicit about that,
> or not offer the option for FDE + factory-reset at all (what I did).
>=20

Resetting the TPM is the poor-man's approach to factory reset anyway. It
is not needed to reset the disk encryption keys, also for the data
partition, and we are so far too lazy to identify and delete other
resources in the TPM in a more targeted manner. Or was there anything
technically preventing an "all-objects-except-for" TPM reset?

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

