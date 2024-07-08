Return-Path: <schilling.benjamin@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3811AC3DA41
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 19:17:13 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.79])
 by mx.groups.io with SMTP id smtpd.web11.2155.1720466232086625094
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jul 2024 12:17:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XhxZjNrm;
 spf=pass (domain: siemens.com, ip: 40.107.21.79, mailfrom: schilling.benjamin@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4UNxewSxj13lLEMcWokV26PJ7XDAlspVmOjuIN1D2+OWd42yzrInBH/zS0EchuEwxNifUncXkLEj7FaulA8wl7p2cqtpKD3Q/d6nB5uTqR+t8TirxURSspZM63hBVznT44OkGMmGh7ywB2PfJVQoV1qWo9elMQot4/Tc0VDA/ZrRqX41Ww+rkb4Tj11ujPP1Pvgc8t4VNGg2+ZDuNsYTvOD/T3/54I6gZmHfOVgCX6Ia9hn99CAzTtr4JGXGz8n292MwCpKku/+u61RxRgtkhln+33YdSOJsL2Ay43OmYK4BSout278xukv2U35w3Pp8t6woDUEgVbPEW++IyHRZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oD8jDe533WS/9QTnyTWVXMMlUSqWQqZimW/oGCgbWlE=;
 b=M97D3uQa4e0Qjs8PFUjUsp3n+LFDZ0fQyWM9ijBHOEx/D2qXP2GzPQ1y532r0Z+4M2x+aJeUUvnRBXLVV75BbpFPaNpG01QdVqXdui4KVxiKR8XkgVSTAnDM7td+AKAO0p/YKjctAsTmubD+2ecTOYIwrx/5dz4y3f2TP1Jfdwj3P1IjhGe9Tv3cDhHMg2CHlGn2NWQE9UHWp6N3AnSPNpE+lW6KFDhJs2Uo24p71/P40C52zlaOQn7LFptOPFfRzZm3XbQ5lmXfSkE9QSTpUlXoFboRCCUkCtteH2mth0oKeFc9px9dxSWZzcCX75rUUFTm+JIY5T/FGzfznAPd2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oD8jDe533WS/9QTnyTWVXMMlUSqWQqZimW/oGCgbWlE=;
 b=XhxZjNrmadH5Xq5drP2zT6DTA2h9DLCNWbun2aP+DOruoN7Wm05fHaG6Wm/i+5WaOw8lDhi2TJ9Wix7M70SxCF0FCduMYe6rWfw6cbNRyVGV13JTyy/HTUGPg3/Oy5XToUK3rrHkwBrkUgrjLh/YPHfZeHi2yUW0MGqH5uteX0m9Lt2LSmKzQuvbf7Kn5TSkq77ZZpOOuB0EAmInI0AtiLJ3UZoJVaK58tvakPJsbK3JAQUcgqu9llTUvxSpnfN+xq2vRxFEX3sJxNSyv7fL3qfk1IQNIc0G5+w0hFOAIyPV4rfGUpnc47iHFJmRex3cBJIKE2fYYtETb4Uf4ECnEg==
Received: from GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6d::17)
 by DB9PR10MB7409.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:462::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 19:17:04 +0000
Received: from GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8e3f:ee20:5b20:8a7b]) by GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8e3f:ee20:5b20:8a7b%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 19:17:03 +0000
From: "Schilling, Benjamin" <schilling.benjamin@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: [PATCH] README.m-com-x86.md: Add hardware details
Thread-Topic: [PATCH] README.m-com-x86.md: Add hardware details
Thread-Index: AQHa0WoMtLneHGC5O0mPJoBUkEeQPQ==
Date: Mon, 8 Jul 2024 19:17:03 +0000
Message-ID: 
 <GVXPR10MB58372489E9C91ECFC0AB51A588DA2@GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-07-08T19:07:17.1778584Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXPR10MB5837:EE_|DB9PR10MB7409:EE_
x-ms-office365-filtering-correlation-id: 6d520350-3b3f-4de3-0b1e-08dc9f828cee
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?ht+Zj07WWxF6cQGkfOw9G4cb8wjDWu3owozUt95IqVcAZudnGvvuIx6jV0?=
 =?iso-8859-1?Q?ddupF774z1+RcJwvKIi8CDP8NaNFjhRDL98OsyZl5zgO/7+plj1d2a/+LB?=
 =?iso-8859-1?Q?Ci8GFcjrkvj59eTimX1SnNAbx+Z34WkWQVrmHeN9rm2IEc9ZQMN4tanj6n?=
 =?iso-8859-1?Q?FHUBwOmRzJgg4Lb1SSlzWmzmbw8+5vjPHHpoRT17fZ0TfX/qbJEU90Vf2B?=
 =?iso-8859-1?Q?VTS6VC5LqBz2WhdzJOD7evfLcpABKC1Ywz2eU8yeuoMAbFmlYQnv6aerZX?=
 =?iso-8859-1?Q?6kg+6kaFxV9DTbf13L2ap42P3i3/KosFEDjhTGozUftNlMcgBTJk3N7uwi?=
 =?iso-8859-1?Q?iiZJ6nYzIhdhX+5ARkCVjsXgsKfRj2sWDDnNJqRtmIU/ryMlKVndC5bYQg?=
 =?iso-8859-1?Q?R4er/UIxXNRcu7jtkaOhsxi50nUPwTCLsK1enfNjdvIhk/CdaJrvY5souz?=
 =?iso-8859-1?Q?k/4LqVqyxMTDlyjLz6sXBd3yJzv0WUX2yDWfX+mNuCyagQYWg5UZWnkZt5?=
 =?iso-8859-1?Q?IL+hkcpec/RXAAle2M/iP5mCwAyCkfU//VrJhsiY5dKiwvCXB0SQyhRbQz?=
 =?iso-8859-1?Q?Z0ZBx6enbacvDOtqjpUv4oS6hKbUZjyhcfX/wItvd52PvegXkZ+XHYA9c/?=
 =?iso-8859-1?Q?sqMjqXePpfVQ8rkqasdCTQYR4SXNvZnlRM5y3Ovzvl08Fk853qgHSJNooH?=
 =?iso-8859-1?Q?Fd97RlXSuQs3XsncX8tBrRirDVlM6NUnX0N763QTXKEyEWxfzPxVuP5UzI?=
 =?iso-8859-1?Q?e9O0ofk0NLCiHbg12IMHOrGZqpsPXbO3Fd5z5SxPcOzkjAY5h7ehwWEvZN?=
 =?iso-8859-1?Q?kvWDQFj32r0gPoYbWnunU7OjZmTMtq+hoOaw9MbpFxUQVFOCZUbyPR9FS9?=
 =?iso-8859-1?Q?meZeZBSZCi1GBiilrVrsHxbS7c0CDB89LX98M+MOneC3JGu1xZkvs4DeTE?=
 =?iso-8859-1?Q?Mzusldnk17jbbRy47P/0+2RlyhS9hG7566LLwgMWYT2KEPF/BgZ9f8K74G?=
 =?iso-8859-1?Q?rkf+kV8skPXhbeuZNZsSi63HQ62djZSSu/ijRuyuYl52D1c1bGG3BjBnAM?=
 =?iso-8859-1?Q?oSGwfLVvVxZAeO5wbiMumQ43FReNLzEviCnsDWT5g9D1MtS3l9w0J1Hs8l?=
 =?iso-8859-1?Q?/9QfNkVSMdromgmthb7K8mrPR5SrGP3Od7J8uTeW2HDpC2rTyhfjfbKWre?=
 =?iso-8859-1?Q?4EJ3PbJIdwO+TnXj/yzBIvl8sIHHxm4EyPhUOz55NET+duCaCPBcAcpSuQ?=
 =?iso-8859-1?Q?/agPBzmJ/+RdAPIEdFa8xUiYDZoKjdUdExJPrM792qZuKlyuaOwcrE8S6q?=
 =?iso-8859-1?Q?DCr9d2RVJeQ0nLdrk/Vr5ZY5fMilyP4BWk6Hm82zSL3qPFxnQrgnhpZ9h0?=
 =?iso-8859-1?Q?o2fJP5jnrF+VGGbFpbNv45LBmWD74AnEtr/rYr1MSNEeqP+ao1pHSmGLHA?=
 =?iso-8859-1?Q?gIPz3ZTpDFAUcuejGMgc2QH/HwoIQdSp4PtIgg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?T6A1GLKe30W/BqxVMPbABJeNctxcWp2B3osgptrpOIoV7EGXfG4QvPetoW?=
 =?iso-8859-1?Q?3hHNtSVQTrhJo0NnciRzg1Zhqa68JV2QyUsoi1vKwGKsHL3gYuRwA3oCHu?=
 =?iso-8859-1?Q?uXH21oQ2uouRlfcdr0USZxIPiz5S3G9zNMpqvUS4NoPdH+Hd5IclmM224r?=
 =?iso-8859-1?Q?8oj6rdZlRjsh5uiBiZ120OMklZtCKak8pS7tJXXSIBpjebYg/WMvnsZh8C?=
 =?iso-8859-1?Q?xdDRohuLkhHkmdpF3MirkPn829dwiDlcJ0zSRQ2rRpRuvOSfXid3dNoQWl?=
 =?iso-8859-1?Q?vJMPrnHRkLJkXnQhkuYqEZcGwWhuXcLYCbf18QWzoW725QqgsWuD+H4OA/?=
 =?iso-8859-1?Q?fwnpsJNZTV6tlvW4+u/y7wr0htoo6XUbQXPKuZyE+myHb1XIqWjkS8mNf1?=
 =?iso-8859-1?Q?IPHgzx90T/DZVpUyY1/CMSQG30vMPTWHII07Zz7yAFY43EtYnx2G9LhEBT?=
 =?iso-8859-1?Q?K2iKMvz8MMlzuu4qbnkvKRv5dJkoQl9q/eR/ZSC947FLtKW/0Qhe7pHVah?=
 =?iso-8859-1?Q?0WdmEFzSQedi+yfK5jnL2AUjGsVkWTiTaDeFdEren0+uYbBvzvY5ky1uW2?=
 =?iso-8859-1?Q?B8aApetDxDIA2Ljtg/84sHITXDNs3nFYyCPb4ktaObUOD5Udfss19ucfm9?=
 =?iso-8859-1?Q?h+GUjOh5KRdA7xyt/GPcFeIetNtt5ekuldTTkpKQY/fHBVqP68g+6oPDNb?=
 =?iso-8859-1?Q?zLnztu4vpZlhW0UTuFcAKxNhyMiTVM/RYj+moSB5jhakKMLNYi3txcw+RT?=
 =?iso-8859-1?Q?kVA4urbQB3YMG1mAUprRdHPY2072IPHwtr596+JKfL48yx27+7oh5NhuQT?=
 =?iso-8859-1?Q?63DgwDeRwefadsDfaHWb2fBsI9ceDPyuhbSQIL9rcqOosR0EjgDkYVn7uF?=
 =?iso-8859-1?Q?v1RnmWhU0nnwnFxHqo+oUZtd9ErOI8rf0CRU/mYbzEabqed3uG7uC/9mjZ?=
 =?iso-8859-1?Q?KWyry3LXJDEVko+5zXRGI3ehBl07iCjVm8MfgWXhVrCKDuaxZok2MczkZ1?=
 =?iso-8859-1?Q?WP61KfdQLBktW7PzmMQWyySzCqvbIxlRAMYp9QUySLye94LWnvjDhKi8Ps?=
 =?iso-8859-1?Q?Dvu8COSgMtY8mYGEuu1lQ3jN1X/D17Wh2Np0Z2HgZLwTfXtxYVbY18qPsL?=
 =?iso-8859-1?Q?uRDLhtWJFTgUZKh0lO8DKbkby8rzw1sfgPeAIwjGGTB9NmZxGABQw33kD1?=
 =?iso-8859-1?Q?vFGdqg3ai53+fFLS5llCZTN0CiibpHQcL8XWb6KWTBAv0ZghwoGOaHsiZc?=
 =?iso-8859-1?Q?VC8csalrB6JamLZ04xquJrPnHTmC9oh9M5eAiMFHcpjLgaJ807X8o/bcjq?=
 =?iso-8859-1?Q?tcMA4Jag2XPOq6u7MFNY0+pQ/C5RvWn55V8gQRDvQlhv3jmwr8hBMMI5+Q?=
 =?iso-8859-1?Q?qhjISsBiZYJkG7BZ4ctDWaxo6kqB3bAlzAG+jHiA5h2E6K9qwOltD4H9J2?=
 =?iso-8859-1?Q?DA0i0xM9vVwH+cixMArlNK5qaq4yhFmGAR064fksw4/LY3KPAaSRkfPoTV?=
 =?iso-8859-1?Q?47UvxX3FBc2J3tr3sKDkV9y2c3OoVaFyMSgLk3zIKqnVrpjiPXxEwBc4pk?=
 =?iso-8859-1?Q?axTEwp9iN0MMEYzXnErmtgX4F/6GBws+ygVe+cH1mq7C1JlUGnmLjSiEqo?=
 =?iso-8859-1?Q?i5XyBB4i/xa55FG5KvX1oWnTaqO3H+Bd9iHucT4mEHYAXfKAiFNeaQEHow?=
 =?iso-8859-1?Q?ODvEvEosOmNfhpb20q0=3D?=
Content-Type: multipart/alternative;
	boundary="_000_GVXPR10MB58372489E9C91ECFC0AB51A588DA2GVXPR10MB5837EURP_"
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d520350-3b3f-4de3-0b1e-08dc9f828cee
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 19:17:03.8146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2u2MCcpEgbj4BAXD+N74L2NBAR8hy6uYPy0yL2/dVf6KbD1OAom1+PurMCu94hUJKcPgv2Iw7+OyuwAgO2nd4AioSlz4jYw38TePLFbnlT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7409
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jul 2024 19:17:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16437

--_000_GVXPR10MB58372489E9C91ECFC0AB51A588DA2GVXPR10MB5837EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From 4e6b957569e0a4dd617cc1f4fd716c769681f6dc Mon Sep 17 00:00:00 2001
From: Benjamin Schilling <schilling.benjamin@siemens.com>
Date: Mon, 8 Jul 2024 21:00:14 +0200
Subject: [PATCH] README.m-com-x86.md: Add hardware details

Signed-off-by: Benjamin Schilling <schilling.benjamin@siemens.com>
---
doc/boards/README.m-com-x86.md | 131 ++++++++++++++++++++++++++++++++-
1 file changed, 130 insertions(+), 1 deletion(-)

diff --git a/doc/boards/README.m-com-x86.md b/doc/boards/README.m-com-x86.m=
d
index cbd74ad..d677b76 100644
--- a/doc/boards/README.m-com-x86.md
+++ b/doc/boards/README.m-com-x86.md
@@ -1,4 +1,73 @@
-# ISAR CIP Core: Instructions for M-COM RT X86 V1
+ISAR CIP Core: Instructions for the Siemens Mobility GmbH M-COM RT X86 V1
+
+## About the M-COM RT X86 V1
+
+The M-COM RT X86 V1 is an industrial grade PC.
+It is designed to be installed on-board of trains and can be used for comm=
unication and processing purposes or as a security gateway.
+
+## Hardware Specifications
+
+- Intel Atom E3950 CPU
+- 8GB DDR3 DRAM soldered, ECC
+- Trusted Platform Module V2.0
+- 3 Gigabit Ethernet ports (M12 X-coded)
+- 1 USB 3.0 on front
+- -40=B0C to +70=B0C, fanless
+- EN 50155 compliant (railways)
+- 16 GB eMMC storage
+- Input voltage range: 24 - 110 V DC EN50155
+
+### Power Plug Pinout
+
+M12 B-coded Plug
+
+| Column 1 | Column 2                    |
+| -------- | --------------------------- |
+| 24-110V  | Edge triggered power on |
+| GND      | Not connected               |
+
+#### Powering the device
+
+The device must be connected to a powersupply providing 24V to 110V output=
 voltage at the "+" and "-" pins.
+The "switch" pin is used for edge triggered power on.
+It can be hardwired to the power supply 24V to 110V to trigger power on of=
 the device.
+
+### LED Matrix:
+
+| Column 1       | Column 2       | Column 3       | Column 4      |
+| -------------- | -------------- | -------------- | ------------- |
+| Power STBY     | Power ON       | WD-Trigger     | Error 1       |
+| ETH0 Link/Data | ETH1 Link/Data | ETH2 Link/Data | RS232/RS422   |
+| Module1        | Module1        | F1             | M.2 Used/Data |
+
+Power STBY (Yellow):
+- Standby: on
+- Powering down: flashing
+
+Power ON (Green):
+- Operation: on
+- Powering up: flashing
+
+WD-Trigger (Yellow):
+- Trigger pulses: flashing per pulse
+
+Error 1 (Red):
+- WD-Permanent-Reset: flashing 4 Hz
+- WD-Disabled: flashing 2 Hz
+
+ETHx (Yellow/Green):
+- Link: on
+- Data transfer: flashing
+
+Module1 (Yellow/Green):
+- Module-specific
+
+F1 (Yellow):
+- Controlled via Software
+
+M.2 (Green):
+- Module installed:on
+- Data transfer: flashing
 ## Build the CIP Core image
@@ -100,3 +169,63 @@ After boot, check the dmesg for Secure Boot status lik=
e below:
root@demo:~# dmesg | grep Secure
[    0.008368] Secure boot enabled
```
+
+## Internal interfaces
+
+The M-COM contains an internal serial port that can be used to access the =
devices kernel console for debug purposes.
+
+To access it, the backside of the device has to be unscrewed.
+Afterwards it can be connected using a Mini-USB cable.
+Make sure to have the appropriate FTDI driver installed.
+
+## Software Interfaces
+
+The following chapter describes interfaces accessible from software level.
+
+### Controlling the watchdogs
+
+The M-COM RT x86 contains two watchdogs:
+
+- Custom Hardware Watchdog
+- UEFI watchdog of efibootguard
+
+The UEFI watchdog is controlled via efibootguard variables.
+It can be configured for both partition sets using `bg_setenv -p <partitio=
n number> -w <timeout in seconds>`.
+To confirm the new watchdog configuration use `bg_setenv -c`.
+To disable the watchdog set the timeout to 0.
+The watchdog is fed via `/dev/wdog`.
+
+The custom watchdog is controlled via I2C.
+The following scripts can be used to control it.
+
+Enable watchdog:
+```bash
+#!/bin/bash
+
+# i2cset <i2cbus> <chip-address> <data-address> <value> <mode>
+
+# i2cbus       =3D 2
+# chip-address =3D 0x3c
+# data-address =3D 0x00 (Status Register)
+# value =3D 0x8000
+# mode =3D w
+
+# enable watchdog
+i2cset -y 2 -m 0x8000 0x3c 0x00 0x8000 w
+```
+
+Disable watchdog:
+```bash
+#!/bin/bash
+
+# i2cset <i2cbus> <chip-address> <data-address> <value> <mode>
+
+# i2cbus       =3D 2
+# chip-address =3D 0x3c
+# data-address =3D 0x00 (Status Register)
+# value =3D 0x0000
+# mode =3D w
+
+# disable watchdog
+i2cset -y 2 -m 0x8000 0x3c 0x00 0x0000 w
+```
\ No newline at end of file
--
2.45.2


--_000_GVXPR10MB58372489E9C91ECFC0AB51A588DA2GVXPR10MB5837EURP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-ligatures:none;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"DE" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:bre=
ak-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">From 4e6b957569e0a4dd617cc1f4fd=
716c769681f6dc Mon Sep 17 00:00:00 2001<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">From: Benjamin Schilling &lt;sc=
hilling.benjamin@siemens.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Date: Mon, 8 Jul 2024 21:00:14 =
+0200<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Subject: [PATCH] README.m-com-x=
86.md: Add hardware details<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: Benjamin Schilli=
ng &lt;schilling.benjamin@siemens.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">doc/boards/README.m-com-x86.md =
| 131 ++++++++++++++++++++++++++++++++-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">1 file changed, 130 insertions(=
+), 1 deletion(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/doc/boards/README.=
m-com-x86.md b/doc/boards/README.m-com-x86.md<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index cbd74ad..d677b76 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/doc/boards/README.m-com-x=
86.md<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/doc/boards/README.m-com-x=
86.md<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -1,4 +1,73 @@<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-# ISAR CIP Core: Instructions =
for M-COM RT X86 V1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+ISAR CIP Core: Instructions fo=
r the Siemens Mobility GmbH M-COM RT X86 V1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+## About the M-COM RT X86 V1<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The M-COM RT X86 V1 is an indu=
strial grade PC.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+It is designed to be installed=
 on-board of trains and can be used for communication and processing purpos=
es or as a security gateway.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+## Hardware Specifications<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Intel Atom E3950 CPU<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- 8GB DDR3 DRAM soldered, ECC<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Trusted Platform Module V2.0=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- 3 Gigabit Ethernet ports (M1=
2 X-coded)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- 1 USB 3.0 on front<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- -40=B0C to +70=B0C, fanless<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- EN 50155 compliant (railways=
)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- 16 GB eMMC storage<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Input voltage range: 24 - 11=
0 V DC EN50155<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+### Power Plug Pinout<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+M12 B-coded Plug<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+| Column 1 | Column 2&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+| -------- | -----------------=
---------- |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+| 24-110V&nbsp; | Edge trigger=
ed power on |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+| GND&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | Not connected&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#### Powering the device<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The device must be connected t=
o a powersupply providing 24V to 110V output voltage at the &quot;+&quot; a=
nd &quot;-&quot; pins.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The &quot;switch&quot; pin is =
used for edge triggered power on.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+It can be hardwired to the pow=
er supply 24V to 110V to trigger power on of the device.<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+### LED Matrix:<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+| Column 1&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | Column 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Column 3&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Column 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+| -------------- | -----------=
--- | -------------- | ------------- |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+| Power STBY&nbsp;&nbsp;&nbsp;=
&nbsp; | Power ON&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | WD-Trigger&nbsp;&nb=
sp;&nbsp;&nbsp; | Error 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+| ETH0 Link/Data | ETH1 Link/D=
ata | ETH2 Link/Data | RS232/RS422&nbsp;&nbsp; |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+| Module1&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | Module1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
 F1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 | M.2 Used/Data |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+Power STBY (Yellow):<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Standby: on<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Powering down: flashing<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+Power ON (Green):<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Operation: on<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Powering up: flashing<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+WD-Trigger (Yellow):<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Trigger pulses: flashing per=
 pulse<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+Error 1 (Red):<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- WD-Permanent-Reset: flashing=
 4 Hz<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- WD-Disabled: flashing 2 Hz<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+ETHx (Yellow/Green):<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Link: on<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Data transfer: flashing<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+Module1 (Yellow/Green):<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Module-specific<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+F1 (Yellow):<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Controlled via Software<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+M.2 (Green):<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Module installed:on<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Data transfer: flashing<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;## Build the CIP Core ima=
ge<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -100,3 +169,63 @@ After boot=
, check the dmesg for Secure Boot status like below:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">root@demo:~# dmesg | grep Secur=
e<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[&nbsp;&nbsp;&nbsp; 0.008368] S=
ecure boot enabled<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">```<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+## Internal interfaces<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The M-COM contains an internal=
 serial port that can be used to access the devices kernel console for debu=
g purposes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+To access it, the backside of =
the device has to be unscrewed.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+Afterwards it can be connected=
 using a Mini-USB cable.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+Make sure to have the appropri=
ate FTDI driver installed.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+## Software Interfaces<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The following chapter describe=
s interfaces accessible from software level.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+### Controlling the watchdogs<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The M-COM RT x86 contains two =
watchdogs:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Custom Hardware Watchdog<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- UEFI watchdog of efibootguar=
d<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The UEFI watchdog is controlle=
d via efibootguard variables.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+It can be configured for both =
partition sets using `bg_setenv -p &lt;partition number&gt; -w &lt;timeout =
in seconds&gt;`.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+To confirm the new watchdog co=
nfiguration use `bg_setenv -c`.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+To disable the watchdog set th=
e timeout to 0.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The watchdog is fed via `/dev/=
wdog`.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The custom watchdog is control=
led via I2C.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The following scripts can be u=
sed to control it.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+Enable watchdog:<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+```bash<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#!/bin/bash<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# i2cset &lt;i2cbus&gt; &lt;ch=
ip-address&gt; &lt;data-address&gt; &lt;value&gt; &lt;mode&gt;<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# i2cbus&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =3D 2<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# chip-address =3D 0x3c<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# data-address =3D 0x00 (Statu=
s Register)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# value =3D 0x8000<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# mode =3D w<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# enable watchdog<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+i2cset -y 2 -m 0x8000 0x3c 0x0=
0 0x8000 w<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+```<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+Disable watchdog:<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+```bash<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#!/bin/bash<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# i2cset &lt;i2cbus&gt; &lt;ch=
ip-address&gt; &lt;data-address&gt; &lt;value&gt; &lt;mode&gt;<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# i2cbus&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =3D 2<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# chip-address =3D 0x3c<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# data-address =3D 0x00 (Statu=
s Register)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# value =3D 0x0000<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# mode =3D w<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# disable watchdog<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+i2cset -y 2 -m 0x8000 0x3c 0x0=
0 0x0000 w<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+```<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">\ No newline at end of file<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-- <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2.45.2<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_GVXPR10MB58372489E9C91ECFC0AB51A588DA2GVXPR10MB5837EURP_--

