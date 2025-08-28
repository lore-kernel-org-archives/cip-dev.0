Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43546CA0EED
	for <webhook@archiver.kernel.org>; Thu, 28 Aug 2025 10:48:24 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.9])
 by mx.groups.io with SMTP id smtpd.web11.17910.1756378100361113917
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Aug 2025 03:48:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FlYOVzo3;
 spf=pass (domain: siemens.com, ip: 52.101.84.9, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJeIwODSB4Sj17Jx2x0zN1+zvLEEAKJJAMy5a448kcaADT+vQb5bsZKY3flNIJAJyfxXSo9f3ceZXiUJ+M0DiUxX3rpiM1GzKcRFTrzJcaxNmlF807rVbmclGBRxJwB/rrOZEEUMd3UnJPvhtTVlSTyb1Cxf0f9pwbM0Yuq4N/AsaWhOlIqaB55Mm3Wx4RIkvd2QLv6Va5M0jPA6lWD2HC50wYITroOloqq+MCIXBQT+bsSOD7yY7UWx480QnzSKvX6ibSppDSWxDhFTBG87V+tudXQtSMtHSoDgt76uE9aZJlVzaC1wkxanV9zF3YNCHWAjgdnG6vPujUYK5ipDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMEYpWMJtZJdNwr1HiDgNYR/CucyJDaI8AYU5SeJr3w=;
 b=qeqv7fNgoAWFw+3Nd9OMXnm/YUVPDBhrgpyoryNzq+tPVMbJ03qfvaZdcYPZlMtYglRCTLggmjV7+a0hJfe/fbceuvXoi/gfschIIVJDzz77ZKh/SZAljtboSP7/xhhF+ox88F0JYs+dhguhHEeKIkbOObC+xvkTvAkTziQA63sefwpRNw+QZ3xJJHGOqBQnsmegHPQSQTMjbeOir9DlwzJrTLM6eUYSCZd+Db8W2TsqVYf1n6ygaKtvKXvl6u5YPZlmglyewqLRfjmuMH1odZDa6klEWXwhoJ6bI1ouPt46hBC/C5dZ9TItdPcAqN1iNEuaz+MPvSSHI2ivw2ii6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMEYpWMJtZJdNwr1HiDgNYR/CucyJDaI8AYU5SeJr3w=;
 b=FlYOVzo321zAvoqK5b92uP73FBLsMfGvpQ2Liac21wxDieE6qxnxfmqQUYa4tOnh3u3Tz/bdAzuD+nFFBP6FFahh7T/weQwydT4TTug5iq8c/8NkifLYF5J3znE0zdxcc6iuTjF3+t6W+6T32LeIyHfMhoyRHysgTVWjyIcsfhP28xgBI2Xiw2OpDtoWOaMmj8UDKTR+f+9VL2y2y/Yr2Tb+SP1hYdQOKO3yebXX7XyVcX9HXTEViNYfTPJuGVrgNXEtJtObFlbCpbTMLhcE0Y5O7CBzVEzBQ8F6Z4AFsr/aMEPNTjm5Bfm9hwUsHzFasC6H7TfRjLd9RM2p3fGROg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
 by AS4PR10MB7965.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 10:48:15 +0000
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a]) by AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a%6]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 10:48:14 +0000
Message-ID: <9c8db4bc-145d-4f9a-a18b-6133310626f4@siemens.com>
Date: Thu, 28 Aug 2025 12:48:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][QUESTION] initramfs-overlay-hook: tmpFS for
 overlay storage
To: Jan Kiszka <jan.kiszka@siemens.com>, d.kauschke154@googlemail.com,
 cip-dev@lists.cip-project.org
References: <unkY.1747720394864813878.o3iY@lists.cip-project.org>
 <74d5d67b-6432-4777-9b7b-0057c6f41dbe@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <74d5d67b-6432-4777-9b7b-0057c6f41dbe@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB6023:EE_|AS4PR10MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: f99699af-f4fb-4848-8d7d-08dde6206333
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AoByEClZ9wrPtIe1ZFLkADV1eXw2GwkWHdPg9+gz3tUEyMwoqfacAzs5/Ekd?=
 =?us-ascii?Q?Xnf8GVDa2UnRe3dme+l+X1pVxx6eQ4AYubuvT9uBZd6K4C3F4SHiMGgkAly5?=
 =?us-ascii?Q?hs/m1Xw535QiRjtItC4eHg1ds1fMvL4NswjQe0g+mPm3I1d3bRgOSng/D6Hl?=
 =?us-ascii?Q?7DpKcOrMlskkXXhOTKmM4loCdcZ7uFjmT341E2SYgvjDjm9KE4Ob0QuOlwGB?=
 =?us-ascii?Q?oUsjfZMfHhlsgPC69rPrVnb1mkzGaYRgZqbVwWnejlWJAh/33ADv2FqNBcmf?=
 =?us-ascii?Q?0zTXD9vtcntsqeeuXLNUF1dlMi/hZs7WBtr8XEofRhyZle2DvURYaIu0lHN9?=
 =?us-ascii?Q?jpCD235ktX87vu4sf4LZf+Ee6wKQuyBiunD1JisBwa5lhUgmwNsBLWBvV9FE?=
 =?us-ascii?Q?OaveFFoJQ/p5UCLnA2lwVM/bE59doY6eunH9uydQ6a5NSSKy0nwldivZXGGr?=
 =?us-ascii?Q?dCk/iPZeRs4+pJfSyZgauVAYQ9HLlR4u0ww5q10v2EMjGCrH7GDOjyJdii8A?=
 =?us-ascii?Q?wzes5PoMPjJnNvIzjTV3cSwdsChEhz85xCMoQZK17bZwtHSJun8jlA4VEy6b?=
 =?us-ascii?Q?DR/AhalSuARWMWVfWHrP0SIlNZdZGHq7LyWV7GsRnV6mKPP9Rm6uH9JnXNZ9?=
 =?us-ascii?Q?rBe8eNvzVfxxS2/MV4wI8FjzHMMcEIR7s1M5QF0HrsxOfGg4VrIFQurXSduy?=
 =?us-ascii?Q?lmIU7lLhGrRqxSh+KamwrLoMP/SJw/eqoz+Jx5kd5LtHZ4gHuUC0G1T6f5m3?=
 =?us-ascii?Q?WzQ7a6Bli9dMlYSAQ7a1KWqwetQvSQqvkQLI3WZm8jOjMXsdBiPWI0Nzxjfa?=
 =?us-ascii?Q?Rf4I4LrcHSfWGQ6iYlLcNV89jdrOTjsf0v4ihU0kS4zx5RywJaUNwALLd3lg?=
 =?us-ascii?Q?TFCwW/v/C4AsGAnWNLLJGsicWc9eG27WmCkOG34Joziu3FUA71jnTRn6Pb1u?=
 =?us-ascii?Q?Xt8XzbW/xVR0e2FmZu857NNn7sQm+e1Nh3/eYqfZr7lARNi3X4Kxj3yeUSfB?=
 =?us-ascii?Q?ZwR4+UqVv58PiZrUaZKpn6SR8E9O3O1vhp0q3RohWT+vawVWEUzgMQ9SSR93?=
 =?us-ascii?Q?lAqYr4q85U++5P2sW+PK8lRazX54EdpNpM26MJjW08ZeGqzTm05xqxCeKvtg?=
 =?us-ascii?Q?yPmWqhxp2SCq36/PSecJplAgXaoPrQ/VKwR4EruUFccdIVn1c8l21OYixwiT?=
 =?us-ascii?Q?pJkt8f93z0Yd3cagItQ34/i0mqeP3G9gRR7WMILNEGx8xozY+Q8kTPqXNFsc?=
 =?us-ascii?Q?rIsOQZHjBz+9YhJwGmVaOQAwouZ1xaacjYPYdI3qtvTbPzE8GxdkNa3+LqKQ?=
 =?us-ascii?Q?Xv+OlmHzObo07Ws4osPPErFTezaVwwXXu+XzIOpUt1HwS9Bc26pWf/mBh0yL?=
 =?us-ascii?Q?Oa7yhaylqQZyG8wXAmvtaW20x8fwp0tvzKAxQaIaRXKFBdxaSnRMZgwuU1wg?=
 =?us-ascii?Q?JIkI6EMI98g=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JoHoXqMRYZeZCflFa16cppWdQxRGbI+b1kIBvOA2Cxb6qb5JNP3vWuUIeGGV?=
 =?us-ascii?Q?TrAO29gltLpAV6fD1/cWPE+2MaA+UfW2Gm4ScOQSfWbyDlqy6FlNLOlac0lM?=
 =?us-ascii?Q?CSqPPC/GDRKUN8+wz3tGfo2YkwBXpoe+FXp2J6KZ2cQ0vOY3vAmzDNbStEnf?=
 =?us-ascii?Q?TRY/dH8KDRnG2YWl17JvLvFX8RFwEscb8XTzjzqvkoxt7C/f5smR2vgmQfLG?=
 =?us-ascii?Q?lldHQkdeITAWSnl8PNPJdYeJV1y1bZE/UEzvniaYNJG+STOcV8zrQj4jBtj/?=
 =?us-ascii?Q?LMnQm2r+vOmRAPZOCvX9D1hzCaLUzJScE+LJJA7VOZQ4JVKp1K09SCbz538G?=
 =?us-ascii?Q?aTAMi+vHRoEf9/NDx0VHhJVDOBPI8sc2+rxvApOEmMn5fSmYM4wTaPAq+AuS?=
 =?us-ascii?Q?qFuubcknawoGRUy3XFcL6UH/lXZ8bpFkQGVVfJVUztxFgLJy78vxSkbS3wvA?=
 =?us-ascii?Q?yIXHsANo2cJrJoLNzHStVgrfICc0JCS64jRvCLwRkm6H4kTyzni9xYaMEy/q?=
 =?us-ascii?Q?9+vOX6ZH5QLdcHE5keF0CWVjbtuZVZWBTe9vyMy0v9N0I81RFfDWiJTcJ0QX?=
 =?us-ascii?Q?3frR0gL25WAiJygjoGFJk3bRn+6jEMG9J8ZTonBM8bfCMAQglVeqAiQK/ZqJ?=
 =?us-ascii?Q?gwv/dvtxhMwFipsw7oh66rlDr1uMh3a/0RW3v1o5pDGdrht0RiFyT3izm7UX?=
 =?us-ascii?Q?9OuGk7rvuD2tXYrSCd8+j4PrfK8ccWSfH3dTxs2jhEro9gEEmLh+MmtuIf1u?=
 =?us-ascii?Q?jmCFvBiaEgPNo+fA8MKb8z5CINoH2AJ+/Kw2OdDh7z73jWYjoRq/xW8RoUiB?=
 =?us-ascii?Q?HYSHdFeQx09Ov41b54ZM0fJFWwtHLJSeefpSWlVMuxVRzI1fO/KY2gr7itM1?=
 =?us-ascii?Q?LVj5yBnfXOZCRfsh6NLku5qr6rM+cCQ8aVbEouxtwZF+yAR9ABrKb9GyknPu?=
 =?us-ascii?Q?6cD56bDby9e1Wgwm/0ilPg8sIT29+Ixod1/LEUH3/F8tNOsIaUVGJxKkyU4j?=
 =?us-ascii?Q?EUbVHGf192oepqJNcasqTW9zsciz5VIhFO1Wji9QrVHKJkhVdpnUob0d8JSD?=
 =?us-ascii?Q?Kr01+b81Dga/Z2u7dT0dflyAvKqafPiFMc/iSnzsmDMfhv7qo36bCnOqHxpp?=
 =?us-ascii?Q?XrvVw1ToayfMsr+OPer/CrPizyDjN/HuS+bASqY9fn5iuRPrVyUZhUryd20/?=
 =?us-ascii?Q?Li0rBsguCqqfra3Wn1R6TKgYlJ7cbDyBkQ4XnCwrr1mM2LEsivV7VOWnyU4i?=
 =?us-ascii?Q?hW4MrPZKb5x82QYAbxmT4Fllcd+wvXoQE4d6QVg5FlRR9y6HMEU4kkNjlB6U?=
 =?us-ascii?Q?fwG1RSWA6ICjl5t+9LPdsvn1f6mREPWt5czlkZSTGhuP/C3RIESgKDnciHpM?=
 =?us-ascii?Q?iSzLmZg81KbsA/i1ajBkujeZGxuvqxWP8SjynozMPhy1B4z0QO2x/C6wEhAO?=
 =?us-ascii?Q?tkvQ9SFNLoJ/TXRO8Q+pVhBQLtGL4/uSriioGubSQiZkEJx+IRvKGQEuHaXr?=
 =?us-ascii?Q?jYiXttwh/4hMbdmq784GNbQ9XXw17/j5IGtbsoubVw15U2SWNdYIRJFotIX/?=
 =?us-ascii?Q?Fv5OSm47Uw7VHcgkndZkc60nFFAAHawMDyd+Jn79Vc+ic4e0Vo1/AyRMTfEJ?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99699af-f4fb-4848-8d7d-08dde6206333
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 10:48:14.6390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8aeoDEuH13zr3d92cPe1uLXIa44SKw/DrfQewRTyEnS18+2v2G6MCyYVWkmqdvFja5Sxr+cFLHuSNSI57vzFoTZqeES4078Zg1Iys7biYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7965
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Aug 2025 10:48:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19979



On 8/24/25 12:16, Jan Kiszka wrote:
> Hi David,
>=20
> oops, I think no one replied to this question back then, right? Was the
> topic resolved in the meantime, or is it still open?
>=20
> On 20.05.25 07:53, d.kauschke154@googlemail.com wrote:
>> Hello all,
>>  =20
>> I have some questions regarding the use of the initramfs-overlay-hook
>> feature in CIP Core:
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/
>> recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
>> <https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/
>> recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb>
>>  =20
>> Currently, I=E2=80=99m using the default behavior where the overlay=E2=
=80=99s upper
>> directory is located on a separate, persistent /var partition.
>> An wic example setup can be found here:
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/wic/
>> bbb-efibootguard.wks.in <https://gitlab.com/cip-project/cip-core/isar-
>> cip-core/-/blob/master/wic/bbb-efibootguard.wks.in>
>>  =20
>> At runtime, /etc/fstab includes an entry:
>>  =20
>> overlay on /etc type overlay (rw,relatime,lowerdir=3D/root/etc,upperdir=
=3D/
>> root/var/local/etc,workdir=3D/root/var/local/.etc-atomic,uuid=3Don)
>>  =20
>> In this setup, the root filesystem is mounted read-only, and directories
>> like /etc are made writable via an overlay.
>>  =20
>> This works well from a functional perspective, but due to the use of
>> persistent storage for the upper and work directories (on /var),
>> all runtime modifications are retained across reboots.
>> For example:
>> /etc/machine-id can be modified as expected,
>> but also a file like /etc/systemd/system/attacker.service could be
>> dropped during runtime by someone with physical access to the flash of
>> the device.
>> These files would then persist across reboots, undermining runtime
>> integrity.
>>  =20
>> Questions:
>> 1) Is there an existing way to configure initramfs-overlay-hook to use a
>> volatile overlay backed by tmpFS for the upper directories?
>> 2) If not, would it be feasible or acceptable to extend the recipe to
>> optionally support such a mode?
>> 3) Are there known reasons why a tmpFS for overlay storage was not
>> implemented yet?
>=20
> Not sure if there is anything preventing to specify some folder on an
> existing tmpfs mountpoint as backing. With trixie, /tmp should be
> available for that, e.g.
>=20

You can simple set the variable INITRAMFS_OVERLAY_STORAGE_PATH in=20
configuration(distro, kas or machine ):

```
INITRAMFS_OVERLAY_STORAGE_PATH =3D "/tmp"
```

Quirin


>>  =20
>> The goal is to ensure that the system always boots into a clean and
>> controlled state,
>> without retaining any changes made during runtime =E2=80=94 for improved
>> security and integrity.
>>  =20
>> Thank you for your time and expertise.
>>  =20
>> Best regards,
>> David
>=20
> Jan
>=20


