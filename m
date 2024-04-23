Return-Path: <schilling.benjamin@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18512C4345F
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 11:53:32 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.74])
 by mx.groups.io with SMTP id smtpd.web11.16368.1713873211276125309
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Apr 2024 04:53:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=e0Lh5svf;
 spf=pass (domain: siemens.com, ip: 40.107.249.74, mailfrom: schilling.benjamin@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAesAN+6owCjwDUHo8gXewXk/j8JocXHfELrO/CdlHpJC/9M2ge/oqhPEciS44c21pXIzw3nOgUjaezbhrutd4PhQ5lSP1rBlpnhUW51esFe709L1hD645X3ZQKM0nh44IVGjOQ7UQeSMIoQaxlJyMgOcJNgXZTwPjHOXrD5TY8+F4o/fUSvKmoqzeHsjPvkrNO4Vrq7p53l8ZKiMwyEB8V2xJDsHUCb4wDDGwIOh5NR7hLV8NqkFNkk8+UvYSFaQhMMJSHK0vVaZ8d7IKG2+7wbImPMYOJGUO49Ykd9U2d8N3OLgddblau0lMY9Y/YD4wZC3naGXwf5XNAJREEN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2PxRSvSstWn2FQ9XZhBtR/H6leE+L24pVM+eduKePQ=;
 b=efS0jEkyUzejJw4195wtVWDfmZmDjjdKu1FYJ31AXwv1By7uDW8t5G556wNRMRaXvnafNLyw0Y4uNn7iJT7xYGEYZkUg6PNMnBr2mcQXIWx2vyChP6ncj5Zu5ZEMmtqGfzn/NmPi/JwOebSFwG7Div+kf6HLXks3cBMyKaXEob05YI0U2fBR2FOmBeVn8BOPmzzMyHbDC9kGTRSQNY7Mu5xAoV69sDWXF8KcSXdmMAndnBq/j/dL0JS6i77G8varHHsrzFL53cI7yvZTW12CJStrX88kPkuj47YwrE95HF/5J0maSi7FOEELNrHEGOutHrWldbaFOyQ/Bh1lAcphdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2PxRSvSstWn2FQ9XZhBtR/H6leE+L24pVM+eduKePQ=;
 b=e0Lh5svfTDuwgaY+3gUiNhjTM04ISgTXs+b6I/julzxSARNc6qHB8c8K8FhICGk9ipR7V2DhvvO5lEOlwiy2UH8Je4Frk7+tr5Ao6gchSCh8Cf6311SBjAY4D/CF2+o+7DCVC/iJHHF0xdog5v27aCSOA+Gtbx5lpFaA2ikb8vrW+Ew9pP0pswokZhoID+m3xQkBDsgiJ8pY4wtplfy4MmaQm4jWW6tX6XoiR2VZHgTnts6L8QY8RCoz/C4Xv4nEtwHMennLp2Oxo0M8VVJ3cF/0SesxPA2J2ixmVw8kHb7Hlw5uj+d6/QjOua6UsHOe3qZUnMEgu4GOwVTUwNIX+Q==
Received: from GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6d::17)
 by AM8PR10MB4113.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 11:53:28 +0000
Received: from GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8e3f:ee20:5b20:8a7b]) by GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8e3f:ee20:5b20:8a7b%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 11:53:28 +0000
From: "Schilling, Benjamin" <schilling.benjamin@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core] [PATCH] HW: add basic M-COM x86 support
Thread-Topic: [isar-cip-core] [PATCH] HW: add basic M-COM x86 support
Thread-Index: AdqVdNUVlEu9uZKuRRmK1w/6/rn/Ng==
Date: Tue, 23 Apr 2024 11:53:28 +0000
Message-ID: 
 <GVXPR10MB583719E1FC03FA839A16DF5F88112@GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=1891e4bd-18a5-4559-9f56-85bc61c79f22;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-04-23T11:32:32Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXPR10MB5837:EE_|AM8PR10MB4113:EE_
x-ms-office365-filtering-correlation-id: c0fcde46-5d5a-4f0f-38bb-08dc638bfd76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?NP03ePz+WGvlAJ35Louf42ami4v6oTdL3njeqqvvSNLWvc9nSu/2MB2cyxEC?=
 =?us-ascii?Q?kVXTpOHQBY6cvCX2+rOUAvTYkEcb3Z8BDb3PPWVBwkyM86vOczzUQZW9PFLI?=
 =?us-ascii?Q?2Gjxrn9bgY26creQkKcSs/GG9wwjSLtwEKn2fZvwSGbTlpJZpHDvAw9E1q4p?=
 =?us-ascii?Q?72OlEbtpCHXf/BqlaVZfifW9ovon2pVU20SFNbG1Pd9zOKE1QwJH3phBjomp?=
 =?us-ascii?Q?7r/TcX1n/SiPR/I+JlvVaMGHbTGch54lmdpBUA/eTQxE1olIAMeQjcgYy3wY?=
 =?us-ascii?Q?Qgcvwkf9vdUG/nAbXlOel0rj4fwxXKmF0SgPjd5JAg/x2Tw8m//ZTCvKzaBU?=
 =?us-ascii?Q?dk9SgwIjqdVsgPJNSjEfmBtzDl1pg+we6AnTzPr9Dsi7Rwkq5AjvNw55KS/y?=
 =?us-ascii?Q?PnM78Hj+iAE3PgRVKE00yYbfoPYf0wdA9qMr+tKjS5SU8ye95XMUG9BomM3Q?=
 =?us-ascii?Q?PTaAkKgZcYiSI6VPSoF/hPh0gzZSZx/yS+IY5Hzmd/Ondbwgdvg08YZ2cgvW?=
 =?us-ascii?Q?eU3o5pwY+iVgdKYbYzmeZuQF+TC9BUZ+tPmPrY8RqDsEzwZpiV+MGCIvF6sJ?=
 =?us-ascii?Q?DqtY4WyQd77i8MnMJtAK5erUB/POv2648NECfLoUX1IQE0pUHNG4KWOQG7ea?=
 =?us-ascii?Q?Cr11bPCk4NzEph5s8ACkuKu9u1wofJ5vLyMKUjeLMmNIKL//AfZp/qqy09Ej?=
 =?us-ascii?Q?PAdNKoNc07l7vbQsh1daojdpvCUr2XoEZE+irIt7/8p10T0XQ3NXjHRgWXs8?=
 =?us-ascii?Q?3KLpfF4rF5faa/YqLVjNKZWTnPBQdJm3d85a6sqjpeurIvKJbjRF0AdbI082?=
 =?us-ascii?Q?2ql3FDTLW9AU1gDmsk0c2GdS+xgeeAtsDxF5jfghNTUbVXiQqN4KbwMj6JMl?=
 =?us-ascii?Q?zNkDH+zvzyW6cL5VV1O8rdrvLSA8G1uy+GyYC+6DAaVvcg+7YRj50o/9lYoP?=
 =?us-ascii?Q?GAq6Yl3oEWQBfVCkX0WwBY5MHW0S6oStAAkgdVeDVk579H/xam9CqT3d7Ws6?=
 =?us-ascii?Q?O43WQJ0aumzs7bJkLOpzJQePCpRxoDCr2Gt38GWBRbOJnNxdFxmfzfpe71ck?=
 =?us-ascii?Q?nGw5EhUlixAiLYqJ606PVtD+dLOVO4QriZd94FEw1QKA116awT1xpLBsRRJF?=
 =?us-ascii?Q?pdHzSyVBEyhgL4MZ5svfhyyV2K5VhCe5Z18Kte8QSdTr9ziT5fNKbu+x7dm5?=
 =?us-ascii?Q?IOZtGHsJEW5kMirazWFusUIg+GMkGTiOOQWgX9/CzgBWsKCxcKYC3G01lxVu?=
 =?us-ascii?Q?FrEaMTDsloNvEqTJ/Wu2yVAHZNcuyczw/muE4jNvnN+HTHAnXpZud+DXB846?=
 =?us-ascii?Q?lkktZKF1NOpBnW+KV35DZHZBykgAfnZIeYpJtdmAgCLlnQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?vLT7JjOQbX6hensgLcqt52NqC68faFHwizGDjBck4CvKJ3tfhOmORq9NG2jX?=
 =?us-ascii?Q?UdsLG1KgVlHA9pVmnfWFUl0jh1HqOxIEZSVg/YFReeawDbe/IwE0P77XqMvF?=
 =?us-ascii?Q?GqqebLs6/BSSV5+7X05qBAw2NaFGpawp8IRiMYMfMWPtHyaBS1uW4/RXgHZy?=
 =?us-ascii?Q?C1axNnuxS4xfMzBjee9gfjievucr9XWwDxUgEs2xBqtAmEm8C5MW/0RRJoxC?=
 =?us-ascii?Q?S38kribFzif70W37zbLlohVVNR78bg1WEDedw1qd42NXClgzZKNg+ZynbtBp?=
 =?us-ascii?Q?P0PCdpK51SUKNcFxS8aB+pXPBfybihNqG9IZJ115UcAR9cqWu+Qlw+w9MiwY?=
 =?us-ascii?Q?LdLn3jpgPC628zDKOwcxCD/ijUXsBV08sMVq5B7ghfYHcNyFjDqDqv57KPcw?=
 =?us-ascii?Q?MXNAaPHRRwBFNgK4+JxNiLLGALonhWXvcoEbm5SJpXs1/dU1hxgbtRg7G0/e?=
 =?us-ascii?Q?gsIVRPr25yqVIhPATf+vDQJuOrft5ZtMlzy6L7cboNH7o7oPJb+rXrU49cqa?=
 =?us-ascii?Q?7XPLAHtBwWI2FV0VjqaQEcflpMkzfa7vMFmnuUHf1CQo+Lr5lm7qR/hC/ol7?=
 =?us-ascii?Q?NvF16CPfHB9+RdUfLnMt5Y9ghIurmYyGwXBL6BsacFIpmY256HfY4N6FGBrq?=
 =?us-ascii?Q?OWymR1z5B2kEzluviDmQYEKLrtkhGDyeP1B4NGja6ZOz8N/NQmYVrSRZNzJj?=
 =?us-ascii?Q?0J4iSBY9jkwsgT80twZsCoMd86odlcBTMxwRW7bCcWKxVa9/chCIWqH43wYj?=
 =?us-ascii?Q?PtXKySeL7noLMS/lW7I3HgLrmd1FfmZ8aNpP8Eh20EXT0hB6QXs0j8nq/B65?=
 =?us-ascii?Q?KWev6vz9DKOC4PwEWnKbC2yMu0qy/qehw4z/y6mcnirjYA23OgEtXlyEIMWs?=
 =?us-ascii?Q?OTfmEEBX16npoX7Gyna/Mh8s4UmBXQh+0VM2XSZGuFtTVtdW8wIg1bg6r3g8?=
 =?us-ascii?Q?TZZEvzMFZIJ6Xa0G9wnTcfkM6O8V9UZm0dzcUJdAPu/gzT7NWZMTRQXfTTvD?=
 =?us-ascii?Q?aVgN9Xrcuqjws1zFnq50yBLyP0ZzzeC2dL0AUUmdFVys2HhDmCPSgeCpYh89?=
 =?us-ascii?Q?wfrzRSROGdHCnaYx9eky1QV1wIrrNqBmNvkcuYtLJt3R9d2qk57nqGtShCgs?=
 =?us-ascii?Q?FVlgqIzxRQg87h4siCosZitrBG0KudyxHDFp9mIc3xj3nTtL4gBALKfKWzrr?=
 =?us-ascii?Q?ul/tMl/vTMl0PHkV5QnXHa+3SVTBACe5CblF0tRrzvg5plrXyxqlLJa8MyMk?=
 =?us-ascii?Q?HbbLgtAy7adGd4/1WmySQIOEClmDAqis9QN9M0oQxcb9pgDosyBXewM9Qn48?=
 =?us-ascii?Q?W5cZggkOqzWQ6boHhE4w0IUHYG8yvQBYqdBB6anuhwKPambrPexCjPL1P53i?=
 =?us-ascii?Q?ObpLvJTRkU5WZ1f5IwPU06G9RrGmDcs1R36wo394W4lTCQUCaJ9pnsNW4802?=
 =?us-ascii?Q?WgAliYupNMAN3kcCzL+NWuTl5fPSnlWrVf4zrkB2EvZF6C9RL+Z9s185pFC1?=
 =?us-ascii?Q?77uBCbFymb1u9W56RfjHnChC0YZLTsD0NQzZSvfjESmgrVtMnCwy1pleTrjz?=
 =?us-ascii?Q?3o6+tneI5vUUFXz/EKYVGqL+NPnEUma7FoyY1pJOieVnr95PBswCsMADBmL2?=
 =?us-ascii?Q?DA=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_GVXPR10MB583719E1FC03FA839A16DF5F88112GVXPR10MB5837EURP_"
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fcde46-5d5a-4f0f-38bb-08dc638bfd76
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 11:53:28.3678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nwRPPl2j5+av2iL9REy0O2/QD92gg0oWSmDJ1/AoPRgJYuJcfztIXj0dK+R0zJ4T5S20urytQcBXlNa0nnffuEYRG5fUAG6ESDOsLAN7gmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4113
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Apr 2024 11:53:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15739

--_000_GVXPR10MB583719E1FC03FA839A16DF5F88112GVXPR10MB5837EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From fcc60a65011c9545bb90f27fb88200d2dff72faf Mon Sep 17 00:00:00 2001
From: Benjamin Schilling <schilling.benjamin@siemens.com>
Date: Wed, 10 Apr 2024 17:21:11 +0200
Subject: [isar-cip-core] [PATCH] HW: add basic M-COM x86 support

This patch allows building and image capable of booting on M-COM x86 device
when using the following configuration:

- Siemens SIMATIC IPC227e target
- 5.10 kernel
- Debian Bookworm
- Flashable image
- SWUpdate support

This is not intended to be included as is, but to be used as a starting
point for proper integration by a separate kas file for hardware support
and respective kernel configuration in cip-kernel-config repository.

Signed-off-by: Benjamin Schilling <schilling.benjamin@siemens.com>
---
recipes-kernel/linux/files/mcom.cfg           | 35 +++++++++++++++++++
.../linux/linux-cip_5.10.212-cip45.bb         |  2 ++
2 files changed, 37 insertions(+)
create mode 100644 recipes-kernel/linux/files/mcom.cfg

diff --git a/recipes-kernel/linux/files/mcom.cfg b/recipes-kernel/linux/fil=
es/mcom.cfg
new file mode 100644
index 0000000..5c46614
--- /dev/null
+++ b/recipes-kernel/linux/files/mcom.cfg
@@ -0,0 +1,35 @@
+CONFIG_USB_ROLE_SWITCH=3Dm
+# CONFIG_USB_ROLES_INTEL_XHCI is not set
+CONFIG_MMC=3Dm
+CONFIG_MMC_BLOCK=3Dm
+CONFIG_MMC_BLOCK_MINORS=3D256
+CONFIG_SDIO_UART=3Dm
+# CONFIG_MMC_TEST is not set
+
+#
+# MMC/SD/SDIO Host Controller Drivers
+#
+# CONFIG_MMC_DEBUG is not set
+CONFIG_MMC_SDHCI=3Dm
+CONFIG_MMC_SDHCI_IO_ACCESSORS=3Dy
+CONFIG_MMC_SDHCI_PCI=3Dm
+CONFIG_MMC_RICOH_MMC=3Dy
+CONFIG_MMC_SDHCI_ACPI=3Dm
+# CONFIG_MMC_SDHCI_PLTFM is not set
+CONFIG_MMC_WBSD=3Dm
+CONFIG_MMC_TIFM_SD=3Dm
+CONFIG_MMC_SPI=3Dm
+CONFIG_MMC_SDRICOH_CS=3Dm
+CONFIG_MMC_CB710=3Dm
+CONFIG_MMC_VIA_SDMMC=3Dm
+CONFIG_MMC_VUB300=3Dm
+CONFIG_MMC_USHC=3Dm
+# CONFIG_MMC_USDHI6ROL0 is not set
+CONFIG_MMC_REALTEK_PCI=3Dm
+CONFIG_MMC_REALTEK_USB=3Dm
+CONFIG_MMC_CQHCI=3Dm
+# CONFIG_MMC_HSQ is not set
+CONFIG_MMC_TOSHIBA_PCI=3Dm
+# CONFIG_MMC_MTK is not set
+CONFIG_MEMSTICK=3Dm
+# CONFIG_MEMSTICK_DEBUG is not set
diff --git a/recipes-kernel/linux/linux-cip_5.10.212-cip45.bb b/recipes-ker=
nel/linux/linux-cip_5.10.212-cip45.bb
index 111866a..7db93a1 100644
--- a/recipes-kernel/linux/linux-cip_5.10.212-cip45.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.212-cip45.bb
@@ -12,3 +12,5 @@
require linux-cip-common.inc
 SRC_URI[sha256sum] =3D "904e4b2547eed965998236bebbfbbd60ae8bd800d11ad46fbe=
eeb0d67a4fcae1"
+
+SRC_URI +=3D "file://mcom.cfg"
\ No newline at end of file
--
2.39.2


--_000_GVXPR10MB583719E1FC03FA839A16DF5F88112GVXPR10MB5837EURP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"DE" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:bre=
ak-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">From fcc60a65011c9545bb90f27fb8=
8200d2dff72faf Mon Sep 17 00:00:00 2001<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">From: Benjamin Schilling &lt;sc=
hilling.benjamin@siemens.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Date: Wed, 10 Apr 2024 17:21:11=
 +0200<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Subject: [isar-cip-core] [PATCH=
] HW: add basic M-COM x86 support<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">This patch allows building and =
image capable of booting on M-COM x86 device<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">when using the following config=
uration:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- Siemens SIMATIC IPC227e targe=
t<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- 5.10 kernel<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- Debian Bookworm<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- Flashable image<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- SWUpdate support<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">This is not intended to be incl=
uded as is, but to be used as a starting<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">point for proper integration by=
 a separate kas file for hardware support<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">and respective kernel configura=
tion in cip-kernel-config repository.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: Benjamin Schilli=
ng &lt;schilling.benjamin@siemens.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">recipes-kernel/linux/files/mcom=
.cfg&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 35 +++++=
++++++++++++++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">.../linux/linux-cip_5.10.212-ci=
p45.bb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 ++<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2 files changed, 37 insertions(=
+)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">create mode 100644 recipes-kern=
el/linux/files/mcom.cfg<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/recipes-kernel/lin=
ux/files/mcom.cfg b/recipes-kernel/linux/files/mcom.cfg<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">new file mode 100644<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 0000000..5c46614<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- /dev/null<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/recipes-kernel/linux/file=
s/mcom.cfg<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -0,0 +1,35 @@<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_USB_ROLE_SWITCH=3Dm<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# CONFIG_USB_ROLES_INTEL_XHCI =
is not set<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC=3Dm<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC_BLOCK=3Dm<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC_BLOCK_MINORS=3D256<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_SDIO_UART=3Dm<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# CONFIG_MMC_TEST is not set<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# MMC/SD/SDIO Host Controller =
Drivers<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# CONFIG_MMC_DEBUG is not set<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC_SDHCI=3Dm<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC_SDHCI_IO_ACCESSORS=
=3Dy<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC_SDHCI_PCI=3Dm<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC_RICOH_MMC=3Dy<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC_SDHCI_ACPI=3Dm<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# CONFIG_MMC_SDHCI_PLTFM is no=
t set<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC_WBSD=3Dm<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC_TIFM_SD=3Dm<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC_SPI=3Dm<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC_SDRICOH_CS=3Dm<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC_CB710=3Dm<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC_VIA_SDMMC=3Dm<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC_VUB300=3Dm<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC_USHC=3Dm<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# CONFIG_MMC_USDHI6ROL0 is not=
 set<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC_REALTEK_PCI=3Dm<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC_REALTEK_USB=3Dm<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC_CQHCI=3Dm<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# CONFIG_MMC_HSQ is not set<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MMC_TOSHIBA_PCI=3Dm<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# CONFIG_MMC_MTK is not set<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+CONFIG_MEMSTICK=3Dm<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# CONFIG_MEMSTICK_DEBUG is not=
 set<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/recipes-kernel/lin=
ux/linux-cip_5.10.212-cip45.bb b/recipes-kernel/linux/linux-cip_5.10.212-ci=
p45.bb<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 111866a..7db93a1 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/recipes-kernel/linux/linu=
x-cip_5.10.212-cip45.bb<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/recipes-kernel/linux/linu=
x-cip_5.10.212-cip45.bb<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -12,3 +12,5 @@<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">require linux-cip-common.inc<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;SRC_URI[sha256sum] =3D &q=
uot;904e4b2547eed965998236bebbfbbd60ae8bd800d11ad46fbeeeb0d67a4fcae1&quot;<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+SRC_URI +=3D &quot;file://mcom=
.cfg&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">\ No newline at end of file<o:p=
></o:p></span></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.39.2<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_GVXPR10MB583719E1FC03FA839A16DF5F88112GVXPR10MB5837EURP_--

