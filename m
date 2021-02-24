Return-Path: <SRS0=5ueB=H2=lists.cip-project.org=bounce+64572+6188+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630EAC433DB
	for <cip-dev@archiver.kernel.org>; Wed, 24 Feb 2021 12:42:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9442C64EC3
	for <cip-dev@archiver.kernel.org>; Wed, 24 Feb 2021 12:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9442C64EC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6188+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UWDyYY4521723xZXuePVpKjw; Wed, 24 Feb 2021 04:42:09 -0800
X-Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.84])
 by mx.groups.io with SMTP id smtpd.web08.6289.1614170529061094268
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Feb 2021 04:42:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3w8Qgi6tt+PeVzlzQ5L2b5eOLuTQ+9iMP5P3ddDHhErTN9IJuDf8xp6rS7bone/M97uYeubedBq2hyCQ/hkl8qDhSIgAnPdwsVLu6ccv7mf/+ApSTeQEIo3ExK95cxtqYqdyO//HR87yJ1GCcGGi1Tdc52DugmdhWOW41eRB6fMuIUBM+mZyevWaobgkOPgIp0yxbQ7lGhnt1xLVnnJyf6dHNSqfeQTzOTogTqV/S6JjqzOSrmndpcaD4vER2KnWcBNG/psflNH8glpHDhcDbk93acREQtz7SjKrfy76aoloMV1F67BlJX2xK+ZqHwVrTfos0wV0vdmIUZdmH1/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzleFM5g8LR+9rtF9/So7J7mhENy1puebWMeDAmrlZM=;
 b=EDafoyGIhcqaJrFM3j+2KO2Lwo8bTMVc5dq0jqb4VIjkU4hqcifDbxcxkTmc0mdDPThLcoZ7p4NvaSUhyNGtScuvCmtlm1T7YRCLrYJyej0ClaV6ZW+YBioO3yLd+GuVI4W2HkghfNnmwKQTJ2QeGfl57XgOQVrC2I0yP83alY+RhHaqdhdyMy9aPgnKm5yJ2G5DQfv3hI9JuAdYmPQbese/7YITBv4KRzqpvI9hrNMtLNMVNN2oPrmx4aWfUvvCQMdv2iEYWQJ7RExs+kvg/uQjPsCQCtYz9yu9+k89MdfBWCBlO+PuwKVE8vdGFj+2Rzf7X/vuDv9sv9pKn9992g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
X-Received: from AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:49::10)
 by AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28; Wed, 24 Feb
 2021 12:42:06 +0000
X-Received: from AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc9b:2590:a1cf:3301]) by AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc9b:2590:a1cf:3301%7]) with mapi id 15.20.3890.019; Wed, 24 Feb 2021
 12:42:06 +0000
From: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"henning.schild@siemens.com" <henning.schild@siemens.com>,
	"florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Subject: [cip-dev][cip-kernel-config] 1/2] 4.19.y-cip: Remove XEN guest support for siemens_ipc227e
Thread-Topic: [cip-dev][cip-kernel-config] 1/2] 4.19.y-cip: Remove XEN guest
 support for siemens_ipc227e
Thread-Index: AQHXCqp1uw7SADtISkWbu7Ua6j93PQ==
Date: Wed, 24 Feb 2021 12:42:05 +0000
Message-ID: <20210224124158.71335-1-florian.bezdeka@siemens.com>
References: <20210218183455.GA22234@duo.ucw.cz>
In-Reply-To: <20210218183455.GA22234@duo.ucw.cz>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [178.27.123.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b0ca9ed-df85-49fe-cf42-08d8d8c197d7
x-ms-traffictypediagnostic: AM9PR10MB4184:
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <AM9PR10MB4184E23622EDA15E49A3FD99F69F9@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 v87dRSaEIm+3hR5jFJLKpcPuwL1P52kqnJqx+stnYgNsrN7gBE3/BUfyuBC8cIZD4yZRsBhrFiP6B0eQOsIkHcCRLDcQ24grxz9p84BaveBQadRwsYs/1Q9aYW1ko1IvfuncTyFRY4aA/YHvVuMvpcOZPkblUflrK7MWiP8sjFGiTk8HqsQSg/23I4pAbiyC8JG76mZQqBo1StNIyUhg4u14OVAM1JVNueIdEdoTdC3vvRJR0Kt5RMhv1cQ8UcDGOP8mPYCkanWYrJ6XtZgxSLPaHWbZ/o9TvVQT4olQ9l7cNf17ACsbt1iaEyZhTQlh5uN1AaX3HAvL0WPGM19XBnIP3gswp94RSPmM/ESgvZQ40acEh4QxYMsY8jJIAtHZoShZQqjdIvUvXECVrvrd8Hbcva1myCgSIVQANzVzMuYFl6iY/EDAGI5ULWWaUjWHKbKo/xZeY49RawB1W1mKmwIt8Lz5nHGNljYsF6eR212lMPc6L1mMpi/s4AAlUCca6z2JDpJHb9VrfiNFw48tyw==
x-ms-exchange-antispam-messagedata: 
 =?iso-8859-1?Q?LHbbWAtkIf/mFupenGG4kvRfHRu7jB3o4t/xZKVc4NR3MollFmMNlt/r9+?=
 =?iso-8859-1?Q?5Ksgfc8aajCM+q/8POc3ZeYXq2UbOXK0PQP03hbAZhViu5RNEcUDEh1ffY?=
 =?iso-8859-1?Q?Kh0Xey0J1rSGA90ZhFekJU9fO3mGeYtiofw2upk8GOOPtmbTUMt9uYE+rU?=
 =?iso-8859-1?Q?tBiHP4yJ/G/uYGMTgwZXATK6Uv+/8vSk6RI+ALDbNyoUixZm4xbODt6pLw?=
 =?iso-8859-1?Q?Cf/Kl6ZnsgoCcYgg2gEQYc982fZrZH4tYu5IChz8LLDnaIp4832x2YLXSL?=
 =?iso-8859-1?Q?b2W5RKOAqrUHSh0jy8Pt97NFPwGCqBP4WH3tsmljsfMEm22wgvfWhzCACU?=
 =?iso-8859-1?Q?AoOIAyMGFdpav4pn1S8je3fYJl9bfRaZFA1D+7ZF0m4DU75fmma6iuMuEI?=
 =?iso-8859-1?Q?CPQTx01MjWCLm9sTWzIskA+pPwfmHdMQENVG58FxB5YmjPQI8kNgppZ4XA?=
 =?iso-8859-1?Q?iS1BKY+bMjCU+zbr93lZs59QqD+px7qhWc4T2qjRYEGB3n9A6tN8Ldizjm?=
 =?iso-8859-1?Q?wmOHXzdQwmjrQLC8YQ9WdDeodismmzcyXw3BIlIKe3d3fi0sCWMGAVcjah?=
 =?iso-8859-1?Q?Q6b0YE3AcRHgT4eei/TB78H0bupxj42F8CPcQFAvwbldbPfUNwVasdhTcW?=
 =?iso-8859-1?Q?Bhj3YbrI2JCIR+w2WmkwfJgrfXvKii7WgD48wAAO71e7oon2SgsIbDi6Z2?=
 =?iso-8859-1?Q?ltQbtlJ9/zJyEPqTWfriKjwIcEqVRc3Chfm7RYUP70+LsM3PwBq/Op0UhE?=
 =?iso-8859-1?Q?P4NIbh84VvOW9xM3qLeQt6ZvsYcLQrQddlEkeMZsh6bqWouHFpn2ZmTocz?=
 =?iso-8859-1?Q?+7+fP7TBJAsYwFDZPxryz9r/rXk5VYxAFON+gFjHiqz7lBheUglbdMgNnD?=
 =?iso-8859-1?Q?a6HDMzsvxsooY9yldOR6zx59xOibtrLadvI2QxyA0wGzxSsbac5n7BkTMz?=
 =?iso-8859-1?Q?X0qjpH5tA5jdCtzHHShGBEqlBeTJtPC/bH/m/6YRbwpPZTgDoC6UvupqUC?=
 =?iso-8859-1?Q?+xr9ooxvbcYp9wat1DVy7gFq3WnuyUsZabfgk9vdf15IMrg8B3rikGOquM?=
 =?iso-8859-1?Q?Ws0uFhaZWRSNYJ1BOPYO9ajISXk05ed1c+K8nMZK+esdq+ToTM07T6bN9z?=
 =?iso-8859-1?Q?yQ0zvTJm5IbO2vMNfkNfSmB4P9P8MVVd2Lj3Qw/Wl2OJVH4Gdoz+VdTvi1?=
 =?iso-8859-1?Q?xfyuAwlLZh7nYWwgdQZVEBW1BrjR2yFYEaoEddhcr6pUQjapqC2yhLZrRu?=
 =?iso-8859-1?Q?5qMG+GwnmwN7ADDBr7lYZZggjMpI+o6yF3nCKw5nErJDb4EdeNp1xXUTNm?=
 =?iso-8859-1?Q?WIJ4Y581Pz0e3VFfbAi5DXq1snyarqdNNed7Xy9UM+OSTYksr9P6aO+3na?=
 =?iso-8859-1?Q?S1w45LpiQp?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0ca9ed-df85-49fe-cf42-08d8d8c197d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 12:42:05.9796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qHVyObDweal/lP6TinkxhzejnhTffsPviat63gbI+6PZUCcYyHVQZNR+WQFXUUR1qrawe9uC/3QeBzfc4DSixPfWpF4gQBOKHJz3p+JJILM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4184
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: yhxWCJgJdUpDdw5yk3rxVrolx4520388AA=
Content-Type: multipart/mixed; boundary="U9mYeYPohPRHkQRhagYc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614170529;
 bh=gpFacW0L85/xUR0rhnlKFp+riUt+D/DbFAxFk/rIKmo=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=MWVmFkMjj2o2A9OEqK5iRQhj7fhOKs77RxvNBjsXmu4vqRbBoW4z1lFK3QIdqfJx9sO
 nbyK7JTV+XF1H+REPwJtJPW70Hgx2stiPHD6G+ixeR1Rjo0PZS35RWoxtx2ov5E41lBoC
 GlXFbhlOS4/euOZCuShVSiycrzBKpp5oOU8=

--U9mYeYPohPRHkQRhagYc
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: Florian Bezdeka <florian.bezdeka@siemens.com>

Remove XEN guest support which is not needed and helps to keep
maintanance simple.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
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

--U9mYeYPohPRHkQRhagYc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6188): https://lists.cip-project.org/g/cip-dev/message=
/6188
Mute This Topic: https://lists.cip-project.org/mt/80875359/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--U9mYeYPohPRHkQRhagYc--
