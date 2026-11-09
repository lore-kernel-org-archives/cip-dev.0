Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.27])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2867.1794217801115826254
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 01:50:01 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=lEX+p1N1;
 spf=pass (domain: siemens.com, ip: 52.101.69.27, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiYmubB4QW+e7OkUG52IuomPWVuS72G5/d9+PJpoB63tGrGGbYbPQerNDKtpjYl1fbzSJNyX/iDYMUXIQP1AurmxdHo4L/SxSaZbn8JmlVBMXBO+onaW6FQ0YdeVnHNkypCzWYwyCai09YF1yNU+RrVySDhpFDTeMOAFTf6QTJr37pCaW6cVM4pu7C/PkRaOC1nswZAAPs+NYPHQF7PZqK++9om0/O9+yXC5d/aGB4bC8X5BJhAtxGoOuwlF4QxxwV6Pi7QPBgC4Om4Ado7wOpjXBRALpUWy9S+THaiDR8SpuKLvbPkxAHmIgIbF2j3k5HbYU0YykTo/iJzPlvfzFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emjfCB3SBNQ8HMO98y+QZaHlKuNlhmXZYidBYpEYf+0=;
 b=cz91NIE97HCJh1DohWJPFOP5ng+7VoSnorW5A2ga0GxkIdar8d/yS6haJns/Kc+UCMsFpVzGaWWMUuKUA2vQ88RXAENDbvTXUqTdltHRM3rTJMkaLUyfBayWFZqKLhIIxknMQRQF/skV9bz8/tKUf/7FJxFnk0HYbtbFe4a4q6LjuoBq2ycjaWI0Nol+4J+8l+kUfJKZ81BaHAEIZAMXHFETojH+diuVta5XVZfhzmC3w9uojKChC59Nx+dDeeiIaQQdkwZqpPRb7xnSBfLmuS9diHUx83gCWHqknQaPgeknnYwGv6wLiMF8Bb7uG/3eb+VszAb5rprVur7nr8GQXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emjfCB3SBNQ8HMO98y+QZaHlKuNlhmXZYidBYpEYf+0=;
 b=lEX+p1N1zvlZPhGHk2wnixI7p7MxCJBGbxu2otbgAovBzVOJ3hIHEq4hcfYfGT/zOeFY70kZrMoqwBYNrHd22wDb0IvTC82vKnlbgPMqmR9BWdSdnMUzwv1+z91vYVYx+xQ1B1HPqE+nQs8WsN37L3mILg+3Ma9XrZdTZ19mf/o5dSCKJxiIkvAU9zlyHrVgraHdp3Y6vBuOCR3CS8J7qxIgeqoZywH+3Fe8jA53nbAo3meyj5NqzDtdpUDE/J9KNjCqZAjipNgAi/HSwqJWshFwoEIhuDPrx7+CmwMEv8dsxdKvss4f1Ocq0OObl5oZIMxYvXYU+CTw4V5bdSUdlQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS8PR10MB5952.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:52f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Mon, 9 Nov 2026
 09:49:56 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Mon, 9 Nov 2026
 09:49:56 +0000
Message-ID: <762143b1-f894-4b6d-86d0-e7e5fd29cda5@siemens.com>
Date: Mon, 9 Nov 2026 10:49:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 02/12] efibootguard-boot: emit
 systemd verity cmdline for dracut
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
 <20261019102541.672620-3-quirin.gylstorff@siemens.com>
 <03a9b0ce-4087-43b5-aeae-a62e6038ca2f@siemens.com>
 <53e47dc4-32d4-4c1e-a0f7-c454e8908d98@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <53e47dc4-32d4-4c1e-a0f7-c454e8908d98@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0372.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::18) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS8PR10MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: 79358335-7b7f-4970-8b7f-08df3e46cfb8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|6133799003|10067099003|55112099003|4143699003|11063799006|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261022115727099003|261021135927099003|56012099006|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: SO/GfIIWprIHA1aAuZrMJ2vHyS+22IAF8BtZnxqK3EUmQpwu+0H07NIU1CTJMy3d71e2n1UhSYA6kvQWfMqO0XDQUO8SEinS35CHjuhyeTxe+2i6H15fcrQ6Zy0uzclAS4XY8xqXydZuWut8mnFV1iukUsfy3TVlvr1Fl5Mk0q0cRqAcFCgrxYW9MlZM7unoBuuQHgUUUo5ru6EgHVdEQ6lwS4nNGk4uvz+Qh2cu4VdH703Hl3eKKann9AFVV5jvD3OJsA0Y4JOqjgr+Da3zE/afkhQI4Q2BnO7/HrjwHdYbbyg4GyqLtX72JzuTnvbSYo+eYPEOOJJntKt0DNZMfwzu/tXaw5DG48OgVRPxp9jOWjLqwG6rmjSh5hVgKGGU8BI8pHIhFO26mZ3kgUy0N4hUI/OsE+PzkLlrAVQXQj2DikRwg2LQTZMumi/o5UVocmiZ0IE+XLOpbWfVevt7Wj6q279oLU/oFx2zkvJUpykkFDEuWxJ47AGkPEvxysrlS07I//bJCuRiy+aRKtEpXkodF18k13n1Qrz84LvtfQWJWe9Rd332j1240a1/rwXGCOvjtlENUX9fXSve485Rhhd4YS4OjXWJoHq+c8yvD28+CPqjMNYfLI6BfINxNVji4TOA+0Y+lLSjGcznqtm0hS/X/Ue3nmY0TbzzGP8/fLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(55112099003)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261022115727099003)(261021135927099003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RMTVmDDhmgk4p7hAb0co5Nm2hrTANxpK9WY1+6vFXhdS0CNuO/ORJ4sLABWw?=
 =?us-ascii?Q?lUaJRh/Z1QTeYqmaFPewnv8S1DXWgz7TrX+/lhUE0h8o4QSKbPOZKKxRngWb?=
 =?us-ascii?Q?2B7VcQ++J8dEY0gVMwxzI3HsTyiKQoAmIa5E+iA8MyMk+wqArhR3nOqSxLp5?=
 =?us-ascii?Q?UqOt6HpCuVAakPed2V9sSwJjaIWu1Kuc9K4amLfbvRGDdd7bjLTuVhgD13na?=
 =?us-ascii?Q?ONo4W+86Kd1YG/7h2Kw3QTLmPsSgxNzpsBkBiDPpuChO7e5yvMUKY4no7hHM?=
 =?us-ascii?Q?c/kWlBfScLA6mTeLh1e0MdoVRKSUeuqmHuX2TtN9ifvzLqxzVvQfbxZWG+uB?=
 =?us-ascii?Q?UsP9FaOj+kjrH+YjS1D3YkAjsN/Q4Nd3JpOHYbM5Z2oeAqTmYsL8zO6biBDu?=
 =?us-ascii?Q?NWdl8jxg3QEBxFtv93RJKcS1TyIBy8nLMLJAosUAjJ02KPqm+QmcENET987k?=
 =?us-ascii?Q?c4KAgh6L7SiDEllt6hrjthR8U4R+JM9ggj+D1t1Pz2BnrSj7ERX+h1PE4Glx?=
 =?us-ascii?Q?OgvRF6ebNrKvvKRZtsaIUYd8GNFYyMrbzBE2tRP1e44DgKVJqa01Zrkx/BUI?=
 =?us-ascii?Q?2xgWZRn1q6v64Q/cSlHXIR377dsQYwUhcqJct+qOXjMlFBAVF928Ytc0B14v?=
 =?us-ascii?Q?+DDvs6W7Kt5dnLOpfguFwsFRhSUefvaTICKPwejBMJXEywzpOsPFcSEkZq0G?=
 =?us-ascii?Q?hdN5lJmqp6I7ErJi0IvWdVFDQiKzSZR4J4K+8161Pldn/PshPzCEsmauBjDc?=
 =?us-ascii?Q?ljBIlXPqzNPC1I/ncD1GDaf1AuN22dVlpAuI91bk7PzdypiCaqd5TCE5Ixf+?=
 =?us-ascii?Q?T8K/fv3vx0s+2vr2QOr8cfcaQXaTh8Z5ZoK2j4vjIesRmvg1zZ0oMVIaDgqg?=
 =?us-ascii?Q?85NWkv6c/X3AFigceU0tcGFp9JQBwo7HMMWc+84uU4chKr1i/9ekpj137uod?=
 =?us-ascii?Q?T1HwAi4MhRSWsSalZh/JFp/T1OusZ+GBTUV5QR/Ub3zl/bhtqOYk79GKj3Jj?=
 =?us-ascii?Q?WvlHsbvHuY6vGi/dX6iZ1JoHXDkQLwBop9qTDcT1//AlecRxC3do94RBz2n8?=
 =?us-ascii?Q?FI8lQgaU766b9aYu3k8C4EZ+OVuk6D5iNNneOERWpoCl+kx2RF+WR401xRNL?=
 =?us-ascii?Q?Oeoyer9nRKOBgj+Pr4/2XWbPHmUqXg9Vybn5SzaeTsJahzMRWbdF6wMDy0Bp?=
 =?us-ascii?Q?EvygkPULtzS8G1o0gVyHt0dIp3TbBiRNN17DuEGEJS6zez2q9UCTIAFoxZpd?=
 =?us-ascii?Q?46yInoNYvT95PBEQuTP9i8PVGn/WNqHRJUi/WFwNCGHeFYOFfnuuIgg71jwr?=
 =?us-ascii?Q?2QTpNx/hqlflDDEme+sx5tkY7bGgbek8XjLIV6skSzwcVXnA1fJtXKUr1Y6s?=
 =?us-ascii?Q?pO6N9HepIk7RLumWKVsmBZ/38uoB41eVhQ6l8Fwejcxr8YaNH/aWojPIeixk?=
 =?us-ascii?Q?lpQb99hH1SS1dw5jI7NJLXxvZ+qTA8J3NFNdJ5dX0OBlwjwrLCyE98h2jlj0?=
 =?us-ascii?Q?gUPB6BZhlWwpGo8T44yU9GbX7bu3dnB07Jh0IGKM1h0WJlxKXwmy/T8hZik6?=
 =?us-ascii?Q?1/+/4aW5PJJlgXifRSu21cuwFHSEcxKVk0N5T8ir59LGzqjFk1hhro0kuPUJ?=
 =?us-ascii?Q?18uVpb+cuMVPRVpd3lcTXJni9aM1bdviuLQFXz/M49TGTUwi5LTGFlMhf8ac?=
 =?us-ascii?Q?RvQrxHFZa/7l+LWVMFPSygLmrGn3uuqjWCBJ8IhSYzrWfUUYpg/gUDVOXwks?=
 =?us-ascii?Q?YxDQBZBWBw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79358335-7b7f-4970-8b7f-08df3e46cfb8
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:49:56.4580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XeyjMWI7yw3tF1M0SqhL03/ydzRdUagGfmyZ0lwDn1yWOH4XRerxgL428YXV8KL/x8Ab7oV0LdTAcGzmC567g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5952
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 09:50:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24693

On 09.11.26 10:25, Quirin Gylstorff wrote:
>=20
>=20
> On 11/5/26 7:59 AM, Jan Kiszka wrote:
>> On 19.10.26 12:25, Quirin Gylstorff wrote:
>>> INITRD_CMDLINE_STYLE selects the kernel command line dialect for
>>> verity. The default "initramfs-tools" keeps cip.verity_root_options=3D.
>>> "dracut" emits systemd's native roothash=3D and
>>> systemd.verity_root_options=3D, with the data and hash device resolved =
at
>>> runtime by the cip-verity dracut module (/dev/cip/verity-data), plus
>>> INITRD_EMERGENCY_CMDLINE (default "rd.shell=3D0 rd.emergency=3Dreboot")=
, so
>>> that a failed boot reboots and EFI Boot Guard can roll back.
>>>
>>> Also drop the LABEL=3Dvar entry from the generated fstab. /var is mount=
ed
>>> by the initramfs (overlay and crypt hooks); the additional fstab entry
>>> makes systemd manage a second var.mount for the same filesystem.
>>>
>>> efibootguard-boot: use verity root for dracut without secure boot
>>>
>>> The dracut initramfs has no abrootfs support; dm-verity roothash
>>> matching is its only A/B root selection. Without secure boot the
>>> default wic layout (ebg-sysparts.inc) passes abrootfs_root=3Dy, so the
>>> unified kernel image lacked roothash=3D and the image did not boot.
>>>
>>> Promote abrootfs_root=3Dy to the verity root cmdline when
>>> INITRD_CMDLINE_STYLE is systemd. The wic .inc files cannot be
>>> parametrized instead, as wic does not expand BitBake variables there.
>>>
>>> efibootguard-boot: explain a missing verity env file
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 classes-recipe/read-only-rootfs.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 6 +-
>>> =C2=A0 .../wic/plugins/source/efibootguard-boot.py=C2=A0=C2=A0 | 67 +++=
++++++++++++++--
>>> =C2=A0 2 files changed, 66 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-
>>> recipe/read-only-rootfs.bbclass
>>> index 70152de2..179dcb98 100644
>>> --- a/classes-recipe/read-only-rootfs.bbclass
>>> +++ b/classes-recipe/read-only-rootfs.bbclass
>>> @@ -17,6 +17,11 @@ IMAGE_INITRD =3D "${INITRAMFS_RECIPE}"
>>> =C2=A0 =C2=A0 do_image_wic[depends] +=3D "${INITRAMFS_RECIPE}:do_build"
>>> =C2=A0 +INITRD_CMDLINE_STYLE ?=3D "cip-initramfs"
>>> +
>>> +INITRD_EMERGENCY_CMDLINE ?=3D "rd.shell=3D0 rd.emergency=3Dreboot"
>>> +WICVARS +=3D "INITRD_CMDLINE_STYLE INITRD_EMERGENCY_CMDLINE
>>> RO_ROOTFS_TYPE"
>>> +
>>> =C2=A0 WIC_HOME_PARTITION =3D ""
>>> =C2=A0 WIC_HOME_PARTITION:separate-home-part =3D "part /home --source r=
ootfs
>>> --change-directory=3Dhome --fstype=3Dext4 --label home --align 1024=C2=
=A0 --
>>> size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid
>>> c07d5e8f-3448-46dc-9c0f-58904f369524"
>>> =C2=A0 @@ -76,7 +81,6 @@ image_configure_fstab() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 run_privileged tee '${IMAGE_ROOTFS}/etc/=
fstab' << EOF
>>> =C2=A0 # Begin /etc/fstab
>>> =C2=A0 /dev/root=C2=A0=C2=A0=C2=A0 /=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 auto=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defaults,ro=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0 0
>>> -LABEL=3Dvar=C2=A0=C2=A0=C2=A0 /var=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 auto=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defaults=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 =
0
>>> =C2=A0 proc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /proc=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 proc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 nosuid,noexec,nodev=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=
=C2=A0=C2=A0 0
>>> =C2=A0 sysfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 nosuid,noexec,nodev=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> 0=C2=A0=C2=A0=C2=A0 0
>>> =C2=A0 devpts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /dev/pts=C2=A0=
=C2=A0=C2=A0 devpts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gid=3D5,mode=
=3D620=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> 0=C2=A0=C2=A0=C2=A0 0
>>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/
>>> scripts/lib/wic/plugins/source/efibootguard-boot.py
>>> index ca97d7d7..5a5ec1c0 100644
>>> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>> @@ -36,6 +36,7 @@ import logging
>>> =C2=A0 =C2=A0 msger =3D logging.getLogger('wic')
>>> =C2=A0 +from wic import WicError
>>> =C2=A0 from wic.pluginbase import SourcePlugin
>>> =C2=A0 from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPA=
CE
>>> =C2=A0 @@ -89,11 +90,20 @@ class EfibootguardBootPlugin(SourcePlugin):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 boot_files =3D s=
ource_params.get("files", "").split(' ')
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unified_kernel =
=3D source_params.get("unified-kernel") or 'y'
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmdline =3D boot=
loader.append or ''
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmdline_style =3D get_bitba=
ke_var("INITRD_CMDLINE_STYLE")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root_mode =3D cls._resolve_=
root_mode(source_params,
>>> cmdline_style)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if root_mode =3D=3D "verity=
" and
>>> source_params.get("verity_root") !=3D 'y':
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg=
er.info("efibootguard-boot: abrootfs_root replaced by "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "verity_roo=
t, the dracut initramfs has no
>>> abrootfs "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "support")
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # the verity cmd=
line format is identical to
>>> systemd.verity_root_options
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if source_params.get("verit=
y_root") =3D=3D 'y':
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd=
line +=3D " cip.verity_root_options=3Dpanic-on-
>>> corruption,%s" \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 % cls._get_verity_opts()
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if source_params.get("abroo=
tfs_root") =3D=3D 'y':
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if root_mode =3D=3D "verity=
":
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
cmdline_style =3D=3D "systemd":
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cmdline +=3D cls._get_verity_cmdline_dracut()
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 els=
e:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cmdline +=3D " cip.verity_root_options=3Dpanic-on-
>>> corruption,%s" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 % cls._get_verity_opts()
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 elif root_mode =3D=3D "abro=
otfs":
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 cmdline +=3D " cip.abrootfs_root_options=3D%s" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 % cls._get_abrootfs_opts()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if unified_kerne=
l =3D=3D 'y':
>>> @@ -152,6 +162,21 @@ class EfibootguardBootPlugin(SourcePlugin):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cls._create_img(=
part_rootfs_dir, part, cr_workdir,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 native_sysroot, oe_builddir)
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 @classmethod
>>> +=C2=A0=C2=A0=C2=A0 def _resolve_root_mode(cls, source_params, cmdline_=
style):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Return the effective root s=
election: 'verity', 'abrootfs' or
>>> None.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The dracut initramfs (syste=
md cmdline style) has no abrootfs
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 support, so abrootfs_root=
=3Dy is promoted to verity there.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if source_params.get("verit=
y_root") =3D=3D 'y':
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn "verity"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if source_params.get("abroo=
tfs_root") =3D=3D 'y':
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
cmdline_style =3D=3D "systemd":
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return "verity"
>>
>> We should better handle this compat case at recipe level, when
>> invoking wic.
>=20
> Currently these params are hardcoded in the wic files and this was an
> idea to make it compatible to old versions.
>=20
> A possible recipe solution would involve a ebg-sysparts-verity.inc and
> would not be backwards compatible.
>=20

Then deprecate the old pattern, warn about its usage, map it to a
consistent new one.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center
