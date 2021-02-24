Return-Path: <SRS0=c5b8=H2=lists.cip-project.org=bounce+64572+6190+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799EFC433E0
	for <cip-dev@archiver.kernel.org>; Wed, 24 Feb 2021 12:50:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C916364E6F
	for <cip-dev@archiver.kernel.org>; Wed, 24 Feb 2021 12:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C916364E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6190+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JSlFYY4521723xMUrCfZELgG; Wed, 24 Feb 2021 04:50:14 -0800
X-Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.44])
 by mx.groups.io with SMTP id smtpd.web11.6321.1614171013431295696
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Feb 2021 04:50:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2t2HZAUJlwH82UVZQ6mYSKt0RE1UM0CHJJLszj2lBCZ4YkU6m9pb+htVX85p0BPPG4zN9WXoOXiO5AVI99MLDssFPPIP0qBiMQu/pmiZmBjZIJivG1xybfsK9BjovJ55NLRI4jiO9GJRIpS3zFkfXEOzNE5flsgvUKk7aQVPFfidpMcCw1b9IJkjSl/WIFf4+ZQaww+QU3ycmd7iKF1yXFqyfn2HTxeSwmRZDUCCoylLTKncPgiPv6LVqgaRV+eUeRnGwMRpAH5ovC/CntD5H3pLSwHAU+61PGF/CJNOEBmURM886dSxpuKzaaV4r0AshoozOLjZwz8wROVGedfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynf8LFJRYFzYetqQczRc4qOGZNlIPhiSKZUT4KWL14Y=;
 b=iuY2Tw6mL1taA7QaxHQvYgCihp6CIRq9ZKAosbLBB5tj0UYG5ztFElUF2BgMqxWDzqsm2AIOZugt7Oa51S2zLsgdnna3zQRxs/w/kMOedxCvMnOBEFL+QXL56Bk6jRo+PugCPrZMGKcLr5faOut8LjqYjX3w7A1/rJSJ9PWLmQ2VMxythqDqpkXxyvAlauywbcKZvXT4eHmwUiMiJU8y6TDqtWTuwDMd+FfotHSTCB3q0LR8TRlJYwtAvHCG4OoL6Ld8ZZDwd/BnoCGy1QvPQjlwqWgqriotyRKmfR/Ajl10AC4xA53gPTM4e0d/GhHZ07bsCM9BYsKr+IXja3MJJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
X-Received: from AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:49::10)
 by AM0PR10MB3491.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 12:50:09 +0000
X-Received: from AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc9b:2590:a1cf:3301]) by AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc9b:2590:a1cf:3301%7]) with mapi id 15.20.3890.019; Wed, 24 Feb 2021
 12:50:09 +0000
From: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"henning.schild@siemens.com" <henning.schild@siemens.com>,
	"florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Subject: [cip-dev][cip-kernel-config][PATCH v2 1/2] 4.19.y-cip: Remove XEN guest support for siemens_ipc227e
Thread-Topic: [cip-dev][cip-kernel-config][PATCH v2 1/2] 4.19.y-cip: Remove
 XEN guest support for siemens_ipc227e
Thread-Index: AQHXCquVCvobOmtPxkKFQnSvc6P9RA==
Date: Wed, 24 Feb 2021 12:50:09 +0000
Message-ID: <20210224124958.75586-1-florian.bezdeka@siemens.com>
References: <20210218183455.GA22234@duo.ucw.cz>
In-Reply-To: <20210218183455.GA22234@duo.ucw.cz>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [178.27.123.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2cc063fe-62c5-44d6-2b33-08d8d8c2b83b
x-ms-traffictypediagnostic: AM0PR10MB3491:
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <AM0PR10MB3491DBE84AE8776E28DB6230F69F9@AM0PR10MB3491.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 U+TLuL4u/QvTgTxTFvZw+pl8zvDrUAwTkYBMJUfxdEOIrq0XlKzGIPw9+61OmF9r+fMvdxYQHDz5Tf5o7mCdHlT0EO1oey2WaAqPe4XrijfDtP/wXWQl/aV6rvIYVL2ivSUY4MVMU5wGMwlHBcR8p60s5qQKgVDlCj8K88O4WL4vGEIIkk2k/+g0BDmou94WpiA2riy71qHeNugVc40FFYh2J/C/KVpQ2CAg0QuhhhpjFSbEKpwIg5pNAJCspHNpXz9dmqBDp6rmapBh2oHWUnGcTJ/mjr/Orni7CU6jBifWAaxA6mWlR0EP6FqQLQBqmax4sL0YqR2rt/+NfYRERGmPE5HMXDHKlSWGiEafVMIzIHuZt+/ER55C24+V13Xxs01iqrL4rgZq44XiPMAYZeycBFvGknwMWO8DkqksaGb0+6WI+I6VCxdPNUSWOHLEktYBRkEzb2I5ZMbCG+hXc/+C4KCghlOgMMmiTAMkAPHIaOC1d2vWzYenfzEJJAeZvMFtki8LisyUy/MPbcomtQ==
x-ms-exchange-antispam-messagedata: 
 =?iso-8859-1?Q?DXL9nL2VStNI5rm4iKbTf5EX/TRAd6ABks6bQeSUc6PMiKfWsWrmseo1cF?=
 =?iso-8859-1?Q?F++L4mu8mMuYAmyYr3XEIlapLTWO7nGf9beKgoiiyPKk9as8BpW2mYOmEL?=
 =?iso-8859-1?Q?eZ0o6DtdgqDsJbk8FeUjkDkXTnywLPTx4vB/y+4g+trxRCzDDmulunftzq?=
 =?iso-8859-1?Q?oQnUm5GejlNAMrjQKUKN8F9kB7uPI/4csxJ7+JII5UVBReMTnPE3Pp5hVc?=
 =?iso-8859-1?Q?VKZ93zIbNii3egvbs8tMpQTs4FqIC2bSSi9j0IK0PAMFS/K95/LMpV7aD4?=
 =?iso-8859-1?Q?+l9PL839ZxsbW++zI/uSf/C7HT6zMrTdhY7YRFM4uuYAARsNThbLWquDuX?=
 =?iso-8859-1?Q?k69utOhNdZFihBu9ILNBRDd3V423WgpCucRbDEjVZuDeVhoUd/DSPJBKwN?=
 =?iso-8859-1?Q?h/Xil5bLzOFzeRLff6GZGm5LFIORkoXTYXAuDfecgjaXqt/BXPno5yt1cB?=
 =?iso-8859-1?Q?wirXod49xXExbYbzorTgB3bsMh82SRT2cHLVOj/nf6Rj22P8RTKctyMral?=
 =?iso-8859-1?Q?ljzOAQj4YaaYcj7sQ65jdyW71DkkpIha7oMCcnk+vbZRq7CfJ2cIvtpkLb?=
 =?iso-8859-1?Q?itYAjvzicGhdAgVRHMgeyqmf7eitB4f2Zr+PBdJz7eWs/ZQeO10dZAKekB?=
 =?iso-8859-1?Q?OVfOb2nwi8VeHV2FeNI20zQtIGC16w/8TwUHa+ejQCoPO/aQjbmnqB1Smw?=
 =?iso-8859-1?Q?p1CE0gKEJSSIL7JrveqSYk3E4zYtyyiSru/PXlH4iScIV0sSPAmH1o50V+?=
 =?iso-8859-1?Q?ePMHGwUseLY/Cpb4XvwChSx+VjY1FMjAUXIoBP7fXxdx36gCCd+MM8R8qX?=
 =?iso-8859-1?Q?MVpmdCiZG2w3cpVHS60vjdYjeZZFoqJvg8fb0m6YtpRbLJy9jObxnxdZmO?=
 =?iso-8859-1?Q?WzVfs8aD8bM2Qnq+DMm9Q6SY035s/KB6COjRU8K9hAp9+vSo78BigyOt5z?=
 =?iso-8859-1?Q?Qp19bew0J88M53lwacM3VNh79fUdfEjDfZ28CEkjDIXIcV5dRnHTcfNKNX?=
 =?iso-8859-1?Q?VW8dRLI55Et0mJ4hbZz7MITr5I/t7tKs3VRYZ0mzGXFnYkaeX7Oeouh79s?=
 =?iso-8859-1?Q?yv2IcbK+M4nEllOM8xmAlHGTaSvwU5WI1UEmRUNTJQJeWtrHeYhhuxFE4c?=
 =?iso-8859-1?Q?5n/C5SfrUcDyYKRgBNwTQVvk52ScZAG51NfRP43z1JDUMuI4GPQnzDeqPd?=
 =?iso-8859-1?Q?KW5jdBYnDBbkosjWy0Eoegey4YBmxDDeo0jR0yMU8O5mw1wVzGvqBWEtso?=
 =?iso-8859-1?Q?FQMZQsHXKC32GSWP2/4wk/oWEz5oXFDqvOzM3PpWdViFRaVRQinj+ILUUT?=
 =?iso-8859-1?Q?sR/vdGJg5QAX3liSwJZXUZ2Dyw4pcC8EOX45VO9BIJ+DZknTKamAfEeDor?=
 =?iso-8859-1?Q?k2NDfwOiXc?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc063fe-62c5-44d6-2b33-08d8d8c2b83b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 12:50:09.8515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dqHL3mohCNkSqRz5betRt7Xk+Qcku6qxi2RsabBXgPAaSAqRH6G3EaVsYIRIi7BQKQfokKSOYG18KSOUxFAniJxa7R2D3KUxPqp0eHb/3oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3491
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 03113jmfpebSe3BXtXyu6CTpx4520388AA=
Content-Type: multipart/mixed; boundary="0LXETbhiqGN1pUEqhSwz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614171014;
 bh=X7WRxLadLVXe7lBdt51IxoP1lmUJu9tTUjfFyeJ7Z7w=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=eMpM8X336q0gEXJGqpQfo+3LsCGQ8OQTdOGvfCVYWskdigplS5jTrUqA1aqDNeh8/jW
 46MtDG+h/KvgorwVaeT8N3lcrgc1e7LJFbvixQxM0CJS3H1GSAYQ3lHThK9egUfwW67ai
 0KWiKHnjgadSceuAbNwJ2nBCtTi9oQHRo/Q=

--0LXETbhiqGN1pUEqhSwz
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: Florian Bezdeka <florian.bezdeka@siemens.com>

Remove XEN guest support which is not needed and helps to keep
maintanance simple.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---

 Changes in v2:
  - resend due to local tooling problem


 4.19.y-cip/x86/siemens_ipc227e_defconfig | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/4.19.y-cip/x86/siemens_ipc227e_defconfig b/4.19.y-cip/x86/siem=
ens_ipc227e_defconfig
index 273d20e..5d069f0 100644
--- a/4.19.y-cip/x86/siemens_ipc227e_defconfig
+++ b/4.19.y-cip/x86/siemens_ipc227e_defconfig
@@ -43,8 +43,6 @@ CONFIG_X86_AMD_PLATFORM_DEVICE=3Dy
 CONFIG_HYPERVISOR_GUEST=3Dy
 CONFIG_PARAVIRT=3Dy
 CONFIG_PARAVIRT_SPINLOCKS=3Dy
-CONFIG_XEN=3Dy
-CONFIG_XEN_PVH=3Dy
 CONFIG_GART_IOMMU=3Dy
 CONFIG_CALGARY_IOMMU=3Dy
 CONFIG_NR_CPUS=3D512
@@ -86,7 +84,6 @@ CONFIG_INTEL_IDLE=3Dy
 CONFIG_PCIEPORTBUS=3Dy
 CONFIG_HOTPLUG_PCI_PCIE=3Dy
 CONFIG_PCI_REALLOC_ENABLE_AUTO=3Dy
-# CONFIG_XEN_PCIDEV_FRONTEND is not set
 CONFIG_PCI_IOV=3Dy
 CONFIG_HOTPLUG_PCI=3Dy
 CONFIG_HOTPLUG_PCI_ACPI=3Dy
@@ -218,7 +215,6 @@ CONFIG_DEVTMPFS=3Dy
 CONFIG_CONNECTOR=3Dy
 # CONFIG_PNP_DEBUG_MESSAGES is not set
 CONFIG_BLK_DEV_LOOP=3Dm
-# CONFIG_XEN_BLKDEV_FRONTEND is not set
 # CONFIG_SCSI_MQ_DEFAULT is not set
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=3Dm
@@ -255,7 +251,6 @@ CONFIG_FDDI=3Dy
 CONFIG_HIPPI=3Dy
 # CONFIG_USB_NET_DRIVERS is not set
 CONFIG_WAN=3Dy
-# CONFIG_XEN_NETDEV_FRONTEND is not set
 CONFIG_FUJITSU_ES=3Dm
 CONFIG_ISDN=3Dy
 CONFIG_INPUT_MOUSEDEV=3Dy
@@ -358,14 +353,6 @@ CONFIG_DMADEVICES=3Dy
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
@@ -404,8 +391,8 @@ CONFIG_NFSD=3Dy
 CONFIG_NFSD_V3_ACL=3Dy
 CONFIG_NFSD_V4=3Dy
 CONFIG_NLS_DEFAULT=3D"utf8"
-CONFIG_NLS_ASCII=3Dy
 CONFIG_NLS_CODEPAGE_437=3Dy
+CONFIG_NLS_ASCII=3Dy
 CONFIG_NLS_ISO8859_1=3Dy
 CONFIG_NLS_UTF8=3Dy
 CONFIG_PERSISTENT_KEYRINGS=3Dy
--=20
2.29.2

--0LXETbhiqGN1pUEqhSwz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6190): https://lists.cip-project.org/g/cip-dev/message=
/6190
Mute This Topic: https://lists.cip-project.org/mt/80875472/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--0LXETbhiqGN1pUEqhSwz--
