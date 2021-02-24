Return-Path: <SRS0=40Eq=H2=lists.cip-project.org=bounce+64572+6191+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D39BC433DB
	for <cip-dev@archiver.kernel.org>; Wed, 24 Feb 2021 12:50:34 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFD1964EEC
	for <cip-dev@archiver.kernel.org>; Wed, 24 Feb 2021 12:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD1964EEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6191+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id f6LLYY4521723xEOvkVam9Ml; Wed, 24 Feb 2021 04:50:33 -0800
X-Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.89])
 by mx.groups.io with SMTP id smtpd.web12.6480.1614171032357634453
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Feb 2021 04:50:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmWMyDqwjCrNnhFKPV+y9uR3TkFpJyD0tpDmeza2jN1P5sIPG5mmmAXCaFFtuVkl/UvJe4PWecNFVzKLkVrKaAx/gyU1Qu5hAyEzATDGiOJw6OyZV/eeV6vVxUISYruca96JVR2BToZSqged7hGuglM88MAeqZQ3SXIek3VWNtftuWGD477xl2KAmhqbbntspGE7KKRxFnAQ379YOLtkYmcmVyvw248Hlxe7Sujvp+9ias8/jfCe1VKWUHvQr1DRtcuKzKHJRj+89NPaurKodOEFGunqnbBy32bOMKI3WHMsLgcfwL7NVKT9XHvPL57zugPr9NACB499XIw/GcwJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqBjdG0plVAgG4YKCGLO6+eVpBQjzCRh3lPqOee0MV0=;
 b=TR1va2LjTGUzvAbUaalT/F4t/AaN5WHqXroV6XeNLUBQ2IqPB84vDG6znvVLpIXL/B0LHCl9qa3K+fWsPdFZagX67SRXK2EBSWsgq4BLcVnPepeqFt5upPPOLRQGtPbGfqGLQveXuG3TTmABGVwe7yzihnuaHlLtSgwyIwP0Dxo9BLnq6cSBrWlztLNCMX0BN6pJMh1fzrfCcG/TFfSNnmpW7RHqSxTiTxgjarMBRdqdPz/4pFWFqu44V8Y3E/2ZjqfLJw2ozXO/zjG0ZGHJ82pLJWoK1xSYPO+NPer5VWLrF+zCJZ7bkjMJo8zqT7/T51o0nsjOz8sHvR1qdfWu+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
X-Received: from AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:49::10)
 by AM0PR10MB3202.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Wed, 24 Feb
 2021 12:50:29 +0000
X-Received: from AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc9b:2590:a1cf:3301]) by AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc9b:2590:a1cf:3301%7]) with mapi id 15.20.3890.019; Wed, 24 Feb 2021
 12:50:29 +0000
From: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"henning.schild@siemens.com" <henning.schild@siemens.com>,
	"florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Subject: [cip-dev][cip-kernel-config][PATCH v2 2/2] 5.10.y-cip: Removing XEN guest support for siemens_ipc227e
Thread-Topic: [cip-dev][cip-kernel-config][PATCH v2 2/2] 5.10.y-cip: Removing
 XEN guest support for siemens_ipc227e
Thread-Index: AQHXCquhpck/n30iP0e+oSQWp5NCRg==
Date: Wed, 24 Feb 2021 12:50:29 +0000
Message-ID: <20210224125022.75785-1-florian.bezdeka@siemens.com>
References: <20210218183455.GA22234@duo.ucw.cz>
In-Reply-To: <20210218183455.GA22234@duo.ucw.cz>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [178.27.123.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a0a1e7d-1128-49d6-8b61-08d8d8c2c3ed
x-ms-traffictypediagnostic: AM0PR10MB3202:
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <AM0PR10MB3202DA74ECD6BCCDE86B28ABF69F9@AM0PR10MB3202.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 frDsgd6QcG34vziIHCMvcN4mHGPwlZW1sfbLP1Hf5NZyOuFeYnZ2wwHUvgd6acLIwLZuOYsQWDw/6fn2Qpeq3FgcNHazR2eiiOfDE08KdOWK1M1KbQ9Ja2EL6A5DmcgwfAaB6J5HI2+gkWY9eK4WbUTCTNCzfjI98J3rxqJRbd3VYGu22N2ni6DtJGVOdCzZSRTawL8buoxcRyOgEEUKsZMDb/qyC21WnQPVdOn8DX4Rm763FdhTf868OBHSM7EYXc5VJwEwxXbum5y7ZWjeyM/p3UVwLYeX5Xn4YSrPNyCfSUE+DVvK1Ehs7S321z94AZ2f0TfIts2/HJoW69FZQOw79xazIIoDL0MOElsLSobOENPInEemtRrjZljRFn8fuxKPamTBeQQmdcaJUco3k+4oiHG77W1niKunLzMZoWWJLx2zQ26vPT6iW6bVcLqvBjJFdBtcOF1AoJSGFGU7FaEM5krElr70wGzEpupwhjGeSLhjt2A0uJR0PWfpAKtdok2V4yPOQwirITtNRCUDdA==
x-ms-exchange-antispam-messagedata: 
 =?iso-8859-1?Q?oLo6lTxIro426yQu+7EJgap8scpbKaXm7PleKDepDKJzD5sYKeUG6IwlIy?=
 =?iso-8859-1?Q?6bnaYQ880/MTJP+h+dkJJ57YcsGOcP/qoZW449iZN2v9c0REYn5p8EaXyM?=
 =?iso-8859-1?Q?w8fn+UiQ99k/4q/O1tsrIvwAoB8dk8MyHE2a+Ho6x+64QRsRcY9/90FNpC?=
 =?iso-8859-1?Q?KTqOM7iKpbZEyQ5VmUejngl+SPNbfVbgo7q4cWq3+eKAzePYDx5hjIUW3p?=
 =?iso-8859-1?Q?osYVRh7awkwB3FNLHZ/MBwwf+xCp5AimcX+/lGnuTJpPx1f+c7q604Lof2?=
 =?iso-8859-1?Q?2twjJZHHE8CBqO8/uBcGviWpew6fyV4xnBfA0lxIb1vcu7DH7+ydsCBPk3?=
 =?iso-8859-1?Q?bD9kwnWybyVAnDk+M/ruAt5OCUQn2lLLUxVEiTHX3zXMV/RcEhikCNz2UT?=
 =?iso-8859-1?Q?3SLcAP/CqqBt7Uxm+EYOnXxVvKnDcCG083UFnwo3Nn8dQ54qvnw6lr+Qvf?=
 =?iso-8859-1?Q?v9lBQl526xjMSw/+B6qcuAIroJhdhIemyT0xhBYpNEuMvII3mRoOK+x3cc?=
 =?iso-8859-1?Q?nTMjHlmuF/L7jMAFexqDMuT3pxTYG48Lhix0iSMAnNX2yoIHUZ8x5oNEPB?=
 =?iso-8859-1?Q?lokdZYKm5B+2pD2WPOANTsJmPfQgunlupGfBjoUrAHdrvyJ48clD8WwFqu?=
 =?iso-8859-1?Q?oylTYgSSP3KsgmAWWiUw6cI7zF9FpvkA7k7G7NO8FpDoprXTgI0qoUu2Hy?=
 =?iso-8859-1?Q?Rgo/m5dsZ8fPJFFiUsovrqzZzp7RCiKDQKGVsWbMLWCZdv21SSE+VUXvW8?=
 =?iso-8859-1?Q?1d10BFTfP+wuGU+9oRzf21D6Zaxj/jOUyy0kUJS6839gwiObF8jE8/UJAT?=
 =?iso-8859-1?Q?vKX69UOn80nRfqpTPR8HejQCYdeJM7odIuLuiWHGpdUOlap5yEYAWUshTL?=
 =?iso-8859-1?Q?Iz3/WdVyM0e/otydhhq4St+vFhlhxGeMP7nM6jyDLITPYSkhnnzqJJQ3FU?=
 =?iso-8859-1?Q?fCIhXa4vW0xrN4bc6eFxkjHw5ECsaG67ie2EO0INSr4Ip0KNz6WDXLc4T8?=
 =?iso-8859-1?Q?zsvAusm9dZZ8di593+Eoe8Ib4LnqklkvZg/XwMH/VVKhBr371HuwMSaDwm?=
 =?iso-8859-1?Q?jR1qM0CzQtYV/FPh5E7ZE0fna0MdFZnUOi+QFOS73fHUy5RVfNA8NRktcl?=
 =?iso-8859-1?Q?WD/4bNAcV585RsgJRXtbe/koZHz61Soxl8NRMedD6pJ6NM02BYWg1RBTY5?=
 =?iso-8859-1?Q?r31/5BGHDqnwvJnq6+u8mRUm9a+dFiKUJnMfN502zc8YG7HwTjClfPs+3Y?=
 =?iso-8859-1?Q?RT9XszgYyqL70BFzpCo39M6Y3JYo2z1uIHQWdNtPdzTi2NjkA4cYGNyVnt?=
 =?iso-8859-1?Q?6Z0X4sioaendVlA9Yc05iJBGQsUlgwLEpRS+NWf2925YAWRk0sCMOyODJ4?=
 =?iso-8859-1?Q?atnekL0MD2Vdt3C4mpsqxwN7i3jDfO/g=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0a1e7d-1128-49d6-8b61-08d8d8c2c3ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 12:50:29.4475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7nO1ahVTPRy6D2SZuxOaBYNFniotDS2Q0mPrSJCbbgmSHWePS36V28//0TCQ9OcQas5D6l7kNHXyF6oFZqszqA/l7uNnMJnYDDK1vBcLfyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3202
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PE5ogMWqWGILlH9G076dcD1ix4520388AA=
Content-Type: multipart/mixed; boundary="hJ8E7AXICZiVVypH8nqM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614171033;
 bh=0eFaasWHMymb6FSD6SqlgUDpUAp4YsfdeIsa6exV+9Y=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=hzSxCj/zQ+P4S4vX8MiTlskgkVRyCSyfCnLSmjGbUC18+KB/THLj/YzdIkaw7NWFkug
 ghWAt+NEjOzyyKimzHKm5Aa3uzhxDHk+BSICQJ36GHNT3Ui8sprzT4gEr/wme0Svp3PCU
 J1WoEWvuJzrpcJhja4yw4bozLF+6ofAj5o0=

--hJ8E7AXICZiVVypH8nqM
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: Florian Bezdeka <florian.bezdeka@siemens.com>

Remove XEN guest support which is not needed and helps to keep
maintanance simple.

There are some relocations because this file was based on a 4.19
defconfig before.

Notable changes:
  - CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
    Depends on: <choice> && (!X86_INTEL_PSTATE [=3Dy] || !SMP [=3Dy])
    Dependencies are no longer fulfilled, so no longer enabled

  - CONFIG_IA32_AOUT
    Depends on: IA32_EMULATION [=3Dy] && BROKEN [=3Dn]
    Dependencies are no longer fulfilled, so no longer enabled

  - CONFIG_PCIEAER is now set to "y", CONFIG_ACPI_APEI_PCIEAER needs it
    and was already part of the defconfig

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---

 Changes in v2:                                                            =
    =20
  - resend due to local tooling problem

 5.10.y-cip/x86/siemens_ipc227e_defconfig | 69 ++++++------------------
 1 file changed, 17 insertions(+), 52 deletions(-)

diff --git a/5.10.y-cip/x86/siemens_ipc227e_defconfig b/5.10.y-cip/x86/siem=
ens_ipc227e_defconfig
index 83cc71c..6a0b67e 100644
--- a/5.10.y-cip/x86/siemens_ipc227e_defconfig
+++ b/5.10.y-cip/x86/siemens_ipc227e_defconfig
@@ -14,7 +14,6 @@ CONFIG_IKCONFIG_PROC=3Dy
 CONFIG_NUMA_BALANCING=3Dy
 # CONFIG_NUMA_BALANCING_DEFAULT_ENABLED is not set
 CONFIG_MEMCG=3Dy
-CONFIG_MEMCG_SWAP=3Dy
 CONFIG_BLK_CGROUP=3Dy
 CONFIG_CFS_BANDWIDTH=3Dy
 CONFIG_CGROUP_PIDS=3Dy
@@ -43,22 +42,17 @@ CONFIG_X86_AMD_PLATFORM_DEVICE=3Dy
 CONFIG_HYPERVISOR_GUEST=3Dy
 CONFIG_PARAVIRT=3Dy
 CONFIG_PARAVIRT_SPINLOCKS=3Dy
-CONFIG_XEN=3Dy
-CONFIG_XEN_PVH=3Dy
 CONFIG_GART_IOMMU=3Dy
-CONFIG_CALGARY_IOMMU=3Dy
 CONFIG_NR_CPUS=3D512
 CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy
 CONFIG_MICROCODE_AMD=3Dy
 CONFIG_NUMA=3Dy
 CONFIG_NUMA_EMU=3Dy
-CONFIG_X86_INTEL_MPX=3Dy
 CONFIG_EFI=3Dy
 CONFIG_EFI_STUB=3Dy
 CONFIG_EFI_MIXED=3Dy
 CONFIG_KEXEC=3Dy
 CONFIG_KEXEC_FILE=3Dy
-CONFIG_KEXEC_VERIFY_SIG=3Dy
 CONFIG_CRASH_DUMP=3Dy
 CONFIG_LIVEPATCH=3Dy
 CONFIG_HIBERNATION=3Dy
@@ -80,19 +74,9 @@ CONFIG_ACPI_APEI_MEMORY_FAILURE=3Dy
 CONFIG_ACPI_EXTLOG=3Dy
 CONFIG_SFI=3Dy
 CONFIG_CPU_FREQ_STAT=3Dy
-CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=3Dy
 CONFIG_CPU_IDLE_GOV_LADDER=3Dy
 CONFIG_INTEL_IDLE=3Dy
-CONFIG_PCIEPORTBUS=3Dy
-CONFIG_HOTPLUG_PCI_PCIE=3Dy
-CONFIG_PCI_REALLOC_ENABLE_AUTO=3Dy
-# CONFIG_XEN_PCIDEV_FRONTEND is not set
-CONFIG_PCI_IOV=3Dy
-CONFIG_HOTPLUG_PCI=3Dy
-CONFIG_HOTPLUG_PCI_ACPI=3Dy
-CONFIG_HOTPLUG_PCI_CPCI=3Dy
 CONFIG_IA32_EMULATION=3Dy
-CONFIG_IA32_AOUT=3Dy
 CONFIG_X86_X32=3Dy
 CONFIG_DMI_SYSFS=3Dy
 CONFIG_EFI_VARS=3Dm
@@ -105,6 +89,7 @@ CONFIG_MODULE_FORCE_LOAD=3Dy
 CONFIG_MODULE_UNLOAD=3Dy
 CONFIG_MODULE_FORCE_UNLOAD=3Dy
 CONFIG_MODVERSIONS=3Dy
+# CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_BLK_DEV_BSGLIB=3Dy
 CONFIG_BLK_DEV_INTEGRITY=3Dy
 CONFIG_BLK_DEV_THROTTLING=3Dy
@@ -125,7 +110,6 @@ CONFIG_SGI_PARTITION=3Dy
 CONFIG_ULTRIX_PARTITION=3Dy
 CONFIG_SUN_PARTITION=3Dy
 CONFIG_KARMA_PARTITION=3Dy
-CONFIG_CFQ_GROUP_IOSCHED=3Dy
 CONFIG_MEMORY_HOTPLUG=3Dy
 CONFIG_MEMORY_HOTREMOVE=3Dy
 CONFIG_KSM=3Dy
@@ -136,7 +120,6 @@ CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=3Dy
 CONFIG_FRONTSWAP=3Dy
 CONFIG_MEM_SOFT_DIRTY=3Dy
 CONFIG_ZSWAP=3Dy
-CONFIG_ZBUD=3Dy
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
 CONFIG_UNIX=3Dy
@@ -159,9 +142,6 @@ CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dy
 CONFIG_IP_PIMSM_V1=3Dy
 CONFIG_IP_PIMSM_V2=3Dy
 CONFIG_SYN_COOKIES=3Dy
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_TCP_CONG_ADVANCED=3Dy
 # CONFIG_TCP_CONG_BIC is not set
@@ -172,9 +152,6 @@ CONFIG_IPV6_ROUTER_PREF=3Dy
 CONFIG_IPV6_ROUTE_INFO=3Dy
 CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
 CONFIG_IPV6_MIP6=3Dy
-# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET6_XFRM_MODE_BEET is not set
 # CONFIG_IPV6_SIT is not set
 CONFIG_IPV6_MULTIPLE_TABLES=3Dy
 CONFIG_IPV6_SUBTREES=3Dy
@@ -213,13 +190,19 @@ CONFIG_CGROUP_NET_PRIO=3Dy
 CONFIG_BPF_JIT=3Dy
 CONFIG_HAMRADIO=3Dy
 CONFIG_LWTUNNEL=3Dy
-# CONFIG_UEVENT_HELPER is not set
+CONFIG_PCI=3Dy
+CONFIG_PCIEPORTBUS=3Dy
+CONFIG_HOTPLUG_PCI_PCIE=3Dy
+CONFIG_PCIEAER=3Dy
+CONFIG_PCI_REALLOC_ENABLE_AUTO=3Dy
+CONFIG_PCI_IOV=3Dy
+CONFIG_HOTPLUG_PCI=3Dy
+CONFIG_HOTPLUG_PCI_ACPI=3Dy
+CONFIG_HOTPLUG_PCI_CPCI=3Dy
 CONFIG_DEVTMPFS=3Dy
 CONFIG_CONNECTOR=3Dy
 # CONFIG_PNP_DEBUG_MESSAGES is not set
 CONFIG_BLK_DEV_LOOP=3Dm
-# CONFIG_XEN_BLKDEV_FRONTEND is not set
-# CONFIG_SCSI_MQ_DEFAULT is not set
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=3Dm
 CONFIG_CHR_DEV_SG=3Dm
@@ -249,14 +232,12 @@ CONFIG_VETH=3Dm
 # CONFIG_NET_VENDOR_ARC is not set
 # CONFIG_NET_VENDOR_AURORA is not set
 CONFIG_NET_TULIP=3Dy
-CONFIG_PCI=3Dy
 CONFIG_IGB=3Dy
 # CONFIG_NET_VENDOR_SEEQ is not set
 CONFIG_FDDI=3Dy
 CONFIG_HIPPI=3Dy
 # CONFIG_USB_NET_DRIVERS is not set
 CONFIG_WAN=3Dy
-# CONFIG_XEN_NETDEV_FRONTEND is not set
 CONFIG_FUJITSU_ES=3Dm
 CONFIG_ISDN=3Dy
 CONFIG_INPUT_MOUSEDEV=3Dy
@@ -274,7 +255,6 @@ CONFIG_INPUT_PCSPKR=3Dm
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIO_RAW=3Dm
 # CONFIG_LEGACY_PTYS is not set
-CONFIG_SERIAL_NONSTANDARD=3Dy
 CONFIG_SERIAL_8250=3Dy
 # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_FINTEK=3Dy
@@ -285,6 +265,7 @@ CONFIG_SERIAL_8250_MANY_PORTS=3Dy
 CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
 CONFIG_SERIAL_8250_RSA=3Dy
 CONFIG_SERIAL_8250_DW=3Dy
+CONFIG_SERIAL_NONSTANDARD=3Dy
 # CONFIG_HW_RANDOM is not set
 CONFIG_HPET=3Dy
 CONFIG_I2C_I801=3Dm
@@ -321,9 +302,7 @@ CONFIG_FB_MODE_HELPERS=3Dy
 CONFIG_FB_TILEBLITTING=3Dy
 CONFIG_FB_VESA=3Dy
 CONFIG_FB_EFI=3Dy
-# CONFIG_LCD_CLASS_DEVICE is not set
 CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
-# CONFIG_BACKLIGHT_GENERIC is not set
 CONFIG_FRAMEBUFFER_CONSOLE=3Dy
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
 CONFIG_SOUND=3Dm
@@ -333,9 +312,9 @@ CONFIG_SND_HDA_HWDEP=3Dy
 CONFIG_SND_HDA_INPUT_BEEP=3Dy
 CONFIG_SND_HDA_PATCH_LOADER=3Dy
 CONFIG_SND_HDA_CODEC_HDMI=3Dm
-CONFIG_SND_HDA_PREALLOC_SIZE=3D2048
 CONFIG_HID=3Dm
 CONFIG_HID_PID=3Dy
+CONFIG_USB_LED_TRIG=3Dy
 CONFIG_USB=3Dm
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy
 CONFIG_USB_DYNAMIC_MINORS=3Dy
@@ -345,7 +324,6 @@ CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
 CONFIG_USB_STORAGE=3Dm
 CONFIG_USB_UAS=3Dm
 CONFIG_USB_GADGET=3Dm
-CONFIG_USB_LED_TRIG=3Dy
 CONFIG_NEW_LEDS=3Dy
 CONFIG_LEDS_CLASS=3Dy
 CONFIG_LEDS_TRIGGERS=3Dy
@@ -359,14 +337,6 @@ CONFIG_DMADEVICES=3Dy
 CONFIG_INTEL_IOATDMA=3Dm
 CONFIG_ASYNC_TX_DMA=3Dy
 CONFIG_VIRT_DRIVERS=3Dy
-CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=3Dy
-# CONFIG_XEN_DEV_EVTCHN is not set
-# CONFIG_XENFS is not set
-# CONFIG_XEN_GNTDEV is not set
-# CONFIG_XEN_GRANT_DEV_ALLOC is not set
-# CONFIG_XEN_PCIDEV_BACKEND is not set
-# CONFIG_XEN_ACPI_PROCESSOR is not set
-CONFIG_XEN_MCE_LOG=3Dy
 CONFIG_STAGING=3Dy
 CONFIG_STAGING_MEDIA=3Dy
 CONFIG_CHROME_PLATFORMS=3Dy
@@ -405,8 +375,8 @@ CONFIG_NFSD=3Dy
 CONFIG_NFSD_V3_ACL=3Dy
 CONFIG_NFSD_V4=3Dy
 CONFIG_NLS_DEFAULT=3D"utf8"
-CONFIG_NLS_ASCII=3Dy
 CONFIG_NLS_CODEPAGE_437=3Dy
+CONFIG_NLS_ASCII=3Dy
 CONFIG_NLS_ISO8859_1=3Dy
 CONFIG_NLS_UTF8=3Dy
 CONFIG_PERSISTENT_KEYRINGS=3Dy
@@ -423,11 +393,9 @@ CONFIG_IMA_DEFAULT_HASH_SHA256=3Dy
 CONFIG_IMA_APPRAISE=3Dy
 CONFIG_DEFAULT_SECURITY_DAC=3Dy
 # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
-# CONFIG_CRYPTO_ECHAINIV is not set
 CONFIG_CRYPTO_CRC32C_INTEL=3Dy
 CONFIG_CRYPTO_CRC32_PCLMUL=3Dm
 CONFIG_CRYPTO_CRCT10DIF_PCLMUL=3Dm
-CONFIG_CRYPTO_SHA256=3Dy
 CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=3Dm
 CONFIG_CRYPTO_DEV_CCP=3Dy
 # CONFIG_CRYPTO_DEV_CCP_DD is not set
@@ -441,23 +409,20 @@ CONFIG_BOOT_PRINTK_DELAY=3Dy
 CONFIG_DYNAMIC_DEBUG=3Dy
 CONFIG_DEBUG_INFO=3Dy
 CONFIG_STRIP_ASM_SYMS=3Dy
-# CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_MAGIC_SYSRQ=3Dy
 CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=3D0x01b6
 CONFIG_PAGE_EXTENSION=3Dy
 CONFIG_PAGE_POISONING=3Dy
+CONFIG_SCHED_STACK_END_CHECK=3Dy
 CONFIG_DEBUG_MEMORY_INIT=3Dy
 CONFIG_HARDLOCKUP_DETECTOR=3Dy
 CONFIG_SCHEDSTATS=3Dy
-CONFIG_SCHED_STACK_END_CHECK=3Dy
 CONFIG_DEBUG_LIST=3Dy
 # CONFIG_RCU_TRACE is not set
+CONFIG_STACK_TRACER=3Dy
+CONFIG_MMIOTRACE=3Dy
 CONFIG_FTRACE_SYSCALLS=3Dy
 CONFIG_TRACER_SNAPSHOT=3Dy
-CONFIG_STACK_TRACER=3Dy
 CONFIG_BLK_DEV_IO_TRACE=3Dy
-CONFIG_MMIOTRACE=3Dy
-CONFIG_MEMTEST=3Dy
 # CONFIG_X86_VERBOSE_BOOTUP is not set
-CONFIG_EARLY_PRINTK_EFI=3Dy
-CONFIG_OPTIMIZE_INLINING=3Dy
+CONFIG_MEMTEST=3Dy
--=20
2.29.2

--hJ8E7AXICZiVVypH8nqM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6191): https://lists.cip-project.org/g/cip-dev/message=
/6191
Mute This Topic: https://lists.cip-project.org/mt/80875483/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--hJ8E7AXICZiVVypH8nqM--
