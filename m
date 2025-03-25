Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D2EC35FFC
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 14:56:43 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.34])
 by mx.groups.io with SMTP id smtpd.web11.67706.1742914600947369189
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Mar 2025 07:56:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Uvj+cJ8Z;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.34, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBVi5+SGZZq4I/NfftRAGnssaULzhHPwRewEL288wAXjJzjmb0szeJVD2rXoUb7TLwv0a6rNhUkewQ1BH27z5DjVRT3RxWkIZfiVafk8bML7yIaJR0PFneFrUMfRkkHY2Nh2sQ5w2U/0dljhp6QFb9zMusCTwiMMAjBVLZecUVkadczsrcRpWKTmQXX+N3ym9uyIMMpg2Cgyusf5kKXufK3JSd8mHptZwbzrop0md+UCHz0y+SO7POMl99FqhUC9sz6rcQqPz6Uh4DtLBimJIkvkeuXs8L7N/WEjdAS0dg4LsZqKJOwhmlF54B7eOMYgI8ltrJ4nrbR+9SP/dcFIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdekhuPYKKzBu5Si4o0eHfffXC09WZTek7fxmyK1YaU=;
 b=uZvxyF6dMSMl5sVJD2Biw7KJeV6bToVid9UqMaljrITaiOqZqfQ57WMxpDMSuvVgNEuYHxGZ3p2QR4/ynV3kotO6Bw1j/NkmuSQVP8bq5v7aw8EqhkdoHQu7F8kzT12evDds7FoX5CBPL+YV3UESrqZ8M8Z0zmfP98/ZXc3wfdLwQu765t38AyQSptb7jZvvTWjjG2zoGj4ulTam5F8X3CNqzNJD87R/QEJxkpPXOo5bLXpjulYBI8m7x/CsDc8npfdjRuBBj+WV1YAD5wW3uNkM5onCTuQZ0QQRtdqBCos5dy5uyUZwsYeLCbosVfJUZNp52COt+8YmXyaHK60vYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdekhuPYKKzBu5Si4o0eHfffXC09WZTek7fxmyK1YaU=;
 b=Uvj+cJ8ZnHNt3bN+yuaf+pOi3c0HuXfdFfsV9MDHSgC9hHO5lvdtguIk7t+3iJ9HjcK2Rhi7iznfAh2aJtPSIF/pG5r9/PjCiL14EExe1+yriyeGR1SB0fS6c1iUUXbSaA/YTKFZiAijy8IQDxzIzxfJ+bisZGLwXyGYCSCGoSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB13248.jpnprd01.prod.outlook.com (2603:1096:405:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 14:56:33 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:56:33 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 00/16] Add support for Renesas RZ/G3E SoC and SMARC-EVK platform
Date: Tue, 25 Mar 2025 15:55:54 +0100
Message-ID: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB13248:EE_
X-MS-Office365-Filtering-Correlation-Id: c36f7ec2-e6db-40e0-1c01-08dd6bad3b91
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IW3a1VY7SZoUIvPpoVj2Vv9staoIeA8ED8bTG1MNV5gC9YcRhAS9sIc7f+5G?=
 =?us-ascii?Q?D4ikSQLK8MK4Z8r/nSoVN/LdVmVpzl2j59avBGTTFNOvHL74tX5tnUg7t8Ha?=
 =?us-ascii?Q?6z0FvGa4c7azelH5kxPv1P3ybOuJbA+RRa8LSUkeaXguPwsvbFr027ZpBjnR?=
 =?us-ascii?Q?Ukro8PKvo5EFCgGHScp4+PnyWMeuGU/u1JKfy3a/oWnadNVA+6XEFiK28INL?=
 =?us-ascii?Q?E7f3Ag1f46VQN1kQl37eLHnipw4tvpp2Rd5npnf5Rx0uBBSRK9yq9hDm28kK?=
 =?us-ascii?Q?lHKRVoNGr1uf5x8Gph7zzb5gL6UTDaWaEYtgi6pccfS+C3RF+L7tVTN6uuCg?=
 =?us-ascii?Q?kgcbie/SBuw+GmtefnmaFRGvFTx+ESdfIv2VipK+JdyRRtWZ/0I2x/C6J9VG?=
 =?us-ascii?Q?f2fKx7iXD+IicSFnCZObkeh0jYgWZ7u2fzOm40m2cf4mr+SmDXNbPFEHupH7?=
 =?us-ascii?Q?lFXRTS2ZBqRTt4MEcesgiwR4gu7g/RPDXXxMfNeEdB+VuOzkPd0q/ayFa46s?=
 =?us-ascii?Q?Iv6aKItbq7jvk8Wf7E7hF6z+EeTgKrN4A2StNqGnvw6bfDyF487spewdyrdO?=
 =?us-ascii?Q?lfNKNiyX73boWD8kngKdqGnOWaccDwNh2uht3I+E+q8LRMEU0DceOAU4RdSx?=
 =?us-ascii?Q?tOQz30DJ1KPa4KNwHzvH4HnRGH/M+v20jGzlcEYvHuvM0rbPz5Iv16mJlMyL?=
 =?us-ascii?Q?0TdxUhFLqB9G1eLrE5l1+xXiPOXOz+VQYC/2MiSIYMNgEvKscQIgjKK6biQ+?=
 =?us-ascii?Q?2JsDMKSeY9ULbYnUEHPx/CkjSnp4mp6EhpstljGJ/UBQ7+rAZGnrrU0GnNkR?=
 =?us-ascii?Q?c+6tFaZvy+HZjp1HRRJ7DYN3uljst6IhPPiccramWZEDLilN+xTRBTCqYmAl?=
 =?us-ascii?Q?0j6lZ5ZEsnhl+13uXANU/cBxa8vLwAXf28yrBv3MWusGEoeb0IsXuPidXU+e?=
 =?us-ascii?Q?i1+a0iKR+TsWxlB3acb+vAMJqY/qFOq7QZMEBYJDqVta8zvyq6keOx04S+Uz?=
 =?us-ascii?Q?xRlROTrWvloZ9Q7rjk9+F/26ydW+8d/ZgxLJOl3xOv9f4gTlFY+D4qUBCa6k?=
 =?us-ascii?Q?0R94+bi0Jhpe7LC4097KueK7cH/jISyY3EL++l7Z1g8kEyhNMf3tRtS05WYK?=
 =?us-ascii?Q?kzo5Z0/M1oCQDJjlUMmWxhoCIuUcP5MzuX5Du61F2aC1vDjRSP/hx8gRQ0NK?=
 =?us-ascii?Q?1DALN+lWAneMta4Uc7AAuassZF+SfGLyJcbsUpsfSry1ST0LWA6FDimvoDes?=
 =?us-ascii?Q?5gkOsBZFpkcJIooe8tXdMKTx42kzEemIvWFtR/ZMLsmCxOfxLfgn7+s5I4qC?=
 =?us-ascii?Q?YLsTzl0KDVlBMhxv2CJE5ITO5uzB0v02tLyoRrmRud8aKm+DuUFmdn1Jbzo7?=
 =?us-ascii?Q?s80fD0C9SUCxXfVBDKUm9HgQsa91cOTSTQYwbpby/nXTwmNPDrqJhnTMK2tj?=
 =?us-ascii?Q?ccHoUtxG8Hc/Ue8EbeI6Rk4JplxrA8dV?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iW58jCsyZnga9omNMXBnNBKD+QgxzO5lf0u5vg996y77P6v5kET/uY2ezj0K?=
 =?us-ascii?Q?rSxGjkxmc2H9jYadqofBFqFR4EY2Nox02wsqkmINWM314DbVpN/jrGcM7JQA?=
 =?us-ascii?Q?SnOO/j5ZhRBJDubEXZMf+VEopraIhcbTQuH04Nbal9nA7eGi1wkssdXItYoH?=
 =?us-ascii?Q?Q4umsxKtUTWvYvTrREYYKbz/XEqo7fM/GLrV633imgGugizsaxRIDakurbt+?=
 =?us-ascii?Q?VghLvHKm9XjvRbrXCMfr0LXLLU7GtL+gHR6u9mAoLx8BBNtjS9n/C0iOSeJK?=
 =?us-ascii?Q?TKlnxZ0dWvCYg8hbx+hz6xnEFyG+JEWwhRM6sKjoiM4CZ8lF2lTupjt8BZd1?=
 =?us-ascii?Q?mOMXdaAlnhWUy3H6ZSIR5HB3rzzBn+U8kUskN3+qqsk7CIBo3kxONll90L9X?=
 =?us-ascii?Q?hwrQJ2XmWIXtHpykChAbtCOQCyDqHDN9jfUeq4oH8NSinE06lVOuZeabBb0f?=
 =?us-ascii?Q?LQHbkp6+sgV2a71fXRh0x+1ED+PM1yAEonZAMU2885H6i1kteiUyua19a8a8?=
 =?us-ascii?Q?y7LEqlrNC/KFAtjmS6kKcR0Jw75xDG/HHiw88tvyWHOJGXQihvnKyOAqnE1D?=
 =?us-ascii?Q?thGaNgX1vvKNRT5UG7NlyhhXpyxsH6yNBEsjo1NrwGjdyTnRoAs47jvqaQhy?=
 =?us-ascii?Q?I8afzmWx2q0MiptoZp3jEQeIqEpJNoti/ceGF/aIyzdFwltsy0abnteYbzNL?=
 =?us-ascii?Q?5kWOcXI7F76DzrcAPI1rU9ki0MajgIDuxoyPkn8imIukU6a4sr1a6Hbw7ZGC?=
 =?us-ascii?Q?Yao3oTDn1LG5GvMNeemDC8dXZne4ISS++T23yv8SUrxSIKNL99D/P2n8QpLp?=
 =?us-ascii?Q?BDe4j1lgh/rpM1Jh9aoMy3bDPxCxzVpFh6T1vJNB0F7r64dnNy88KSsfDB7p?=
 =?us-ascii?Q?cSB7TO8QKNQrcQ0tsxPmpcI0Gjzu0jgB9hmkzJHTtQYLvFdQ5uQvh9yHRjVO?=
 =?us-ascii?Q?6pWpKENkk4+MJAaXYHFOdyyTKO6uzCKtx8IwNEk039QDIamvnm1WL5S1+7VO?=
 =?us-ascii?Q?HBfn6hR8kiXIbTDEDH3W68wNl/5Te1CSQCTsg2Ix4J7exH1aSRExY5iwPm9g?=
 =?us-ascii?Q?MNTdXQsvZHPy3DKYlWARXWL7Kj6MzHG77L+GlF0ic2tP7WB3NHARl99X3OqG?=
 =?us-ascii?Q?ar6XASRnO+L4QnB6p0Ka7uQJMWK5cd8ghTTaadBfi9c5eXZ9Iv0AFOXLR+yy?=
 =?us-ascii?Q?uTwuwh5C/ACDlW3OYs949XCWXqvWQWwDBtYhH+2r3kZqZpRxtou7aT0afyFy?=
 =?us-ascii?Q?KMxO0UjIcVvxBGnzKJ58iMbSqZlzWbPVmBLlmOiaQvZMQUKKveHE1SrGqXw/?=
 =?us-ascii?Q?SCmT/JXS1SL5eVjZBcTV53fG9BJQvqPFBYYV92v06TlELUR7zQJw0nu7fvDg?=
 =?us-ascii?Q?RJdQmuiqnOr5HsgCjx7xmNdwy6qI85QpFej4fl/Ht+ADk3qoGh2tgEcwcXht?=
 =?us-ascii?Q?+J5HmuDs1CutPLPfbuCH0pwO6zA/YyuyZ/GgHC1kLV/L+zhH0jaNEQH5rRPt?=
 =?us-ascii?Q?leOU9lRQut2z/diWGERg4VB32eaV+Wt7UW8kpaW+7mjaiNYTu9SA/QkFlmCR?=
 =?us-ascii?Q?H0JBeFh7w0HuXYJPpgIQJpLV1n1sbjSHcPanu2x0+AeseNkFRNJsRokHtsw4?=
 =?us-ascii?Q?FU7F5ZlXfG4kBUMh8AzMp58=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36f7ec2-e6db-40e0-1c01-08dd6bad3b91
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:56:33.0836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApJ5Bu/v1zuPydOGAIf1LVVJgj/758iWubPcXBYBPdAfm/WO/5jqKfkyHjSVG4N/eXT3eM1NXXJ+h+dNec27HXHhs9bZQ2EJb2widsKvI2U3JRJAwg1Gnf3MkYgD7v3E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13248
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Mar 2025 14:56:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18351

Dear All,

This patch series adds initial support for the Renesas RZ/G3E SoC and
RZ/G3E SMARC EVK platform to linux-6.12.y-cip kernel. The RZ/G3E device is =
a
general-purpose microprocessor with a quad-core CA-55, single core CM-33,
Ethos-U55 NPU, Mali-G52 3-D Graphics and other peripherals.

All patches are cherry-picked from mainline kernel.

base commit: be95b49207284 Add configuration for gitlab-ci.

Test logs from linux-6.12.y-cip:

root@smarc-rzg3e:~# uname -r
6.12.19-00045-gabf61442f552

root@smarc-rzg3e:~# cat /proc/cpuinfo
processor       : 0
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp a=
simdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 1
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp a=
simdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 2
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp a=
simdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 3
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp a=
simdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

root@smarc-rzg3e:~# cat /proc/meminfo
MemTotal:        3883788 kB
MemFree:         3565028 kB
MemAvailable:    3499708 kB


root@smarc-rzg3e:~# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 11:       2780       2944       2562       2246     GICv3  27 Level     ar=
ch_timer
 14:          0          0          0          0     GICv3 561 Level     11=
c01400.serial:rx err
 15:          1          0          0          0     GICv3 564 Level     11=
c01400.serial:rx full
 16:       1524          0          0          0     GICv3 565 Level     11=
c01400.serial:tx empty
 17:          0          0          0          0     GICv3 562 Level     11=
c01400.serial:break
 18:         73          0          0          0     GICv3 566 Level     11=
c01400.serial:rx ready
 19:          0          0          0          0     GICv3 563 Level     11=
c01400.serial:tx end
IPI0:       225        437        170        261       Rescheduling interru=
pts
IPI1:      2928       3415       1858       3132       Function call interr=
upts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop NMIs
IPI4:         0          0          0          0       Timer broadcast inte=
rrupts
IPI5:       278        353        190        188       IRQ work interrupts
IPI6:         0          0          0          0       CPU backtrace interr=
upts
IPI7:         0          0          0          0       KGDB roundup interru=
pts
Err:          0


Thanks & Regards,
Tommaso


Biju Das (12):
  dt-bindings: soc: renesas: Document Renesas RZ/G3E SoC variants
  dt-bindings: soc: renesas: Document RZ/G3E SMARC SoM and Carrier-II
    EVK
  dt-bindings: clock: renesas: Document RZ/G3E SoC CPG
  clk: renesas: rzv2h: Add MSTOP support
  clk: renesas: rzv2h: Add support for RZ/G3E SoC
  clk: renesas: r9a09g047: Add CA55 core clocks
  arm64: dts: renesas: Add initial DTSI for RZ/G3E SoC
  arm64: dts: renesas: r9a09g047: Add OPP table
  arm64: dts: renesas: Add initial support for RZ/G3E SMARC SoM
  arm64: dts: renesas: Add initial device tree for RZ/G3E SMARC EVK
    board
  soc: renesas: Add RZ/G3E (R9A09G047) config option
  arm64: defconfig: Enable R9A09G047 SoC

Fabrizio Castro (1):
  clk: renesas: r9a09g057: Add clock and reset entries for ICU

Lad Prabhakar (3):
  clk: renesas: rzv2h: Add selective Runtime PM support for clocks
  clk: renesas: r9a09g057: Add CA55 core clocks
  clk: renesas: r9a09g057: Add support for PLLVDO, CRU clocks, and
    resets

 .../bindings/clock/renesas,rzv2h-cpg.yaml     |  15 +-
 .../bindings/soc/renesas/renesas.yaml         |  17 ++
 arch/arm64/boot/dts/renesas/Makefile          |   2 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 185 +++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a09g047e37.dtsi |  18 ++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  18 ++
 arch/arm64/boot/dts/renesas/r9a09g047e57.dtsi |  13 ++
 .../boot/dts/renesas/renesas-smarc2.dtsi      |  24 +++
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  28 +++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/Kconfig                   |   7 +-
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r9a09g047-cpg.c           | 118 +++++++++++
 drivers/clk/renesas/r9a09g057-cpg.c           | 192 +++++++++++++----
 drivers/clk/renesas/rzv2h-cpg.c               | 196 +++++++++++++++---
 drivers/clk/renesas/rzv2h-cpg.h               |  44 +++-
 drivers/soc/renesas/Kconfig                   |   5 +
 .../dt-bindings/clock/renesas,r9a09g047-cpg.h |  21 ++
 18 files changed, 830 insertions(+), 75 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g047.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g047e37.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g047e57.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
 create mode 100644 drivers/clk/renesas/r9a09g047-cpg.c
 create mode 100644 include/dt-bindings/clock/renesas,r9a09g047-cpg.h

--=20
2.43.0


