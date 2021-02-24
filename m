Return-Path: <SRS0=nM4g=H2=lists.cip-project.org=bounce+64572+6189+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FC6C433E6
	for <cip-dev@archiver.kernel.org>; Wed, 24 Feb 2021 12:43:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3009464EC3
	for <cip-dev@archiver.kernel.org>; Wed, 24 Feb 2021 12:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3009464EC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6189+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id WoflYY4521723xURWz9ERQHa; Wed, 24 Feb 2021 04:43:05 -0800
X-Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.48])
 by mx.groups.io with SMTP id smtpd.web09.6278.1614170584830012156
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Feb 2021 04:43:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3hNE70+oRpcpTDW6VUBvxJ6Rl+ZcXbrXvb0K2so72bye59K+RoXZp5RE06Snxh1biw/vGS6R/R0p49j3BitymMAtCpvSYSEwUU4XCMSLx6sPE0MJlnneLbIyOGiR1xf9j2dD8nNTz5yczB1CT7ZuQuYyuPQdOh2ZSguxghkYiD6EXxpGDgw2vuqT9CrRMjgQiHk0c0Zar7NZ0ywsD8mYniShmYQotfkfzMue912v6GB7xC++52O1E8t5+NiJNZwGSkCc3CH7fy5vbFqTHft49aeqLWAaoJS8KKe0bVgWpeUKVXyhFULmm0s+D4PLOZpUl8oJuji7BeWri1F87zYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuUQUqS2iHR0aYdqha0bKO7iC1uZZnXO6a7QuxxpNxs=;
 b=lVANiA0NQ6DH87+Nq8ATyL4oawQhC5JoRiQCq40hGsji8x1ElapJ59QQhqlDE2w0dg2LLDNyV3AIHMV2PqhxI2pkWCAJ6OfTieqC4Mw/fXmUvwp4l/pfm5RbhAB5nQkDabZr3x+4z0scCF639PVNnrj3558sMl5nGVWRS/+KvgL7jCNFqbT8eDueBNDgeqQu2YdauJqTrG1Cqc0XmQx6rD06KgrwncfRldch+1MlbenRxZ4GUMOQO5BvBXyJGhTi1Ddoyx5OE3CVBpiOBGcTI0sfLWV3Q2UB9FqnMDh2v1LBgCkDxTBCb+VlO/S3N8t/JsvtapwfnKrXCPaGTvfGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
X-Received: from AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:49::10)
 by AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28; Wed, 24 Feb
 2021 12:43:01 +0000
X-Received: from AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc9b:2590:a1cf:3301]) by AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc9b:2590:a1cf:3301%7]) with mapi id 15.20.3890.019; Wed, 24 Feb 2021
 12:43:01 +0000
From: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"henning.schild@siemens.com" <henning.schild@siemens.com>,
	"florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Subject: [cip-dev][cip-kernel-config] 2/2] 5.10.y-cip: Removing XEN guest support for siemens_ipc227e
Thread-Topic: [cip-dev][cip-kernel-config] 2/2] 5.10.y-cip: Removing XEN guest
 support for siemens_ipc227e
Thread-Index: AQHXCqqWj/DP1g/6yUOR3dTHT3ajbQ==
Date: Wed, 24 Feb 2021 12:43:01 +0000
Message-ID: <20210224124255.71809-1-florian.bezdeka@siemens.com>
References: <20210218183455.GA22234@duo.ucw.cz>
In-Reply-To: <20210218183455.GA22234@duo.ucw.cz>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [178.27.123.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39155b83-ae7a-45d2-436b-08d8d8c1b8e8
x-ms-traffictypediagnostic: AM9PR10MB4184:
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <AM9PR10MB418437295E51887E5BBC26EBF69F9@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 tgB8xdIhZpyzOUyyftuQL2mJqU5zw+yVi2kWfbg5KXofcP1HnXTZOz+pQx8mhKWh/BiIsfZ9e59Ow2Akn7H4qdLBREbsv5MwHk5Mll/dsY4uOG0MY8owHn9sUlPVUzOEQoZ+ORERFCXUS3ma91cFCwaEr4cg6arO/Xje0wAg3kmm0Qa01KBcMgSqr6S86jV19jiwiBrJJddNHIFNkCLJEpCg/qK4Obk/g7IFveLZ+uKdJoWqQt7wLkPPCbnM3AJrBCKQieF0eS6rBUwl4U2Voifk8LTaYIiuTxyOCtnnVn0XJc0jZSBQnmds/ifupsgh/Vzv7QS+vFiY4baCScLI3nlmOR8VmPrr+zCsyu3I3SuJTGPGnnlOwvwz/7LvNKl8HS0NPMDqk/Qo4BMAwIVoFqg+FyAtt8tjVB59jCSwVZVLfAYLuUyhPIIunsEJHRDPILG4r6qOTsh5FeQcZ0FhCeyySgYuRU3Ksoj9vDLGuEohdLCDm3QaMzkq17KCHHaGF7RGB3mfyXme3SpjTeUuCA==
x-ms-exchange-antispam-messagedata: 
 =?iso-8859-1?Q?Y+iYRoUpQsNrbYPQj07yk21H4jrzv+9mOTIp9eUQ9Ma9YpVh/UDjAsg5Wl?=
 =?iso-8859-1?Q?r/lhto1axz48PqORKDcM/V5F+V3Enm3y+Qa6t94rOTfsS8k2DkEVsRWMum?=
 =?iso-8859-1?Q?55Z3x7O38lwnmB5A10d7822reZgP2/B9u/s0yhipF3MZMcg4dzpovaFmYa?=
 =?iso-8859-1?Q?OPfB9PTTdFuPT16lhKhgAUO7oOOHI1CaFT3Rua1YJBzm8hmoX0ofRIiiUq?=
 =?iso-8859-1?Q?LYpPFlx9d3CLXodjb0hgW162YFfaVCdLeuAItDFXEpJxffc8n6V+5jzOB8?=
 =?iso-8859-1?Q?jacUSVRQPp2ggZy2ahQJ1we7m5XqaPoK2Nej/u49MvjZf8FLWRxJ6uJz++?=
 =?iso-8859-1?Q?DBKwq1InqhE2cPr82dcjAzihQHjyfqi+f5cAenvxvxY1Bsmg9gnbsgpP9F?=
 =?iso-8859-1?Q?a187j2Fu1Vv7hvBsIZ2IxNK+8kG1US1Q8TE9hHGjU5S721GjXbp0A9OH5S?=
 =?iso-8859-1?Q?Ekmq6+7xGfdFcFa916rFuC3ZhREZ5MpthLSzv61hwWislyiXiJPVdDnJGK?=
 =?iso-8859-1?Q?VsS8/8mdKaZQu7J68P+YiijEiAybPFehQOOnlkqfKLGdelqbo9ur5A05RJ?=
 =?iso-8859-1?Q?Po/p8OXeCOH25NbUf30pjWvYOrUez1hoZtBAQAMD0Foy5BDxBdEdzqTj93?=
 =?iso-8859-1?Q?Mwc0PryQZY5xnIipJDpy+M58wwQAWgNzRsv+D8z151RDfrxMClEPnpB5HS?=
 =?iso-8859-1?Q?rtNI3HceOjzV1WSEfVqe94WdNdjTrSu94nCO0Y03+mFpVzT9EpvTyKKrFn?=
 =?iso-8859-1?Q?KlzOjsfTxDh3+lVbZ3YewdClHx9Bm4S3HsLXB8ggvakUNMNgiiHbjZAtqZ?=
 =?iso-8859-1?Q?gU9F+nMWstA9lmuR0qWWt2YhsyX1WNPARgLZWitm6EKF3WvM+n5xIHLsP5?=
 =?iso-8859-1?Q?1DCpacN1ewq6aYGByYQ1Njm698CmwiRYX4Wfipta97qRvWJzsi0FyrSehZ?=
 =?iso-8859-1?Q?glRRCYCiMxoMzwZXMBglQLFb2s18swXp2S6ius+xgLGza+zrjpSrZH8C5G?=
 =?iso-8859-1?Q?vefUgu0HIi/y2ujTXBo1Q47XoE2qhK8h5Nn4BCWCaamQqUjwF56GYoXKB0?=
 =?iso-8859-1?Q?OKl7X2701aMr6hjEdhyrqjMLl/XtlwCmi0Qd3W4+uayP3F8z1GaYFretUc?=
 =?iso-8859-1?Q?nvopAvBRDw7RhWC16ycDpGOFkW4K0Tk3hUophyL8bzEQH5kKlZ3j4uBU8s?=
 =?iso-8859-1?Q?2gmlCBiCz9LmKWNj6AToESSEZba423TkYnLlLiKdVt6aKOZ/TQZk2VIGbM?=
 =?iso-8859-1?Q?F1WFWR3+KwzYcEC0ZMVUM036XLWKo9V0EgfVC+2j5DfMB9z+lcvfyNAh7X?=
 =?iso-8859-1?Q?voPrRlW+LnihpNsQkucAhvAOMNQXVN4ytvKWY5uqGo0x9GUZCike/YzGIf?=
 =?iso-8859-1?Q?TO1Ok3gn2g?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 39155b83-ae7a-45d2-436b-08d8d8c1b8e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 12:43:01.4572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1dmir7vnboHodYx35XsBqkc5zXdySpb/hrzwuZrgq1E9banaxbMbauRZIJ/w7S2dAtZByyKsu5SJbjz0v/WNJdQ01ZhrVd+8xupC7GFJsGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4184
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: kTP7StkKL4aVXo3qot668bQ2x4520388AA=
Content-Type: multipart/mixed; boundary="zpUTtkYhuKFeaifPZcZd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614170585;
 bh=FgtOPOR6D9EuTyPBX3JjWoyhd+ABYJj+hrxSOTj813w=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Lfi70x+KpWLQUAa1rMZLj/VAtCJVS4Q978cx8yjQejGM+OEE3yxSJv6jBHoRfRDi3Pf
 Jj8zw7uegLrw96KWLOUglm8pM0uZvN5Lo5WeavyxStMOCirmzpIwf7NZqnhHBVVkd5H/M
 o9frK2VqJ/DGOks6qYrPxQb6qd17e+SBI0w=

--zpUTtkYhuKFeaifPZcZd
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

--zpUTtkYhuKFeaifPZcZd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6189): https://lists.cip-project.org/g/cip-dev/message=
/6189
Mute This Topic: https://lists.cip-project.org/mt/80875381/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zpUTtkYhuKFeaifPZcZd--
