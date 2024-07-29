Return-Path: <schilling.benjamin@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A22C3DA61
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 09:09:15 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.65])
 by mx.groups.io with SMTP id smtpd.web11.52366.1722244149645619813
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 02:09:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aLFJlz1Z;
 spf=pass (domain: siemens.com, ip: 40.107.21.65, mailfrom: schilling.benjamin@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKoNNqbYnr5uXxg6I4S8s62wQSzEmJdo0zyAIFtN9kM89O+o77/dZQlQmdOxCUl+v2aTktbZO7+S8cLsZwN6zj07Pb3tgZCaSkOPjw/c2HOFmDOW8WmKIXrsbRc/NWQ2pq8pDBZmnRRlXE4RMg+/jHYIgpJLKwEQFXfpPjrqToYho+sjF1X6tk4tnnvvqfcPVjRSwBXpTR3O9aJA7M6W0Aamr28Uho1SFsDkAZXxXYMBCqZqOrSk04wI9ZsaiwlFPNkSxodCoPKtZ9cIQmkBOOTVvugSPgUFea0mNEv6phwfuk1VsfEsGVzEG4evNdPz0T8Z1U5kbtfY6PPwDuDBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zp97iEvd7GjbkIdmZQEEBUSAyl24WJ3uN/dDwOlGDkM=;
 b=h+iBFJ8BczUkY+uacvXBUPLJyL4KAlpkYCz3cIr6Ur2345Af80AZtd35kGKAThu8U+wdEF7hf2LKZx4qt6KW0scuqO2+pIpGVqoAQmiwFlNaPjkHqs4kMjV/ICMyD8BbEeLvPKBP4aNjr/fR1eTmR2RSrjbDMvQnUSdDUTjY5p8JsLdWHQcBSS3iX4MxF1m23k/tr69bCPi3kJRx6ds/3pcunKsbRohisenR8MRvAhsxdHlmtI0JxIIqx6BGevF1Dq+IeZeU7ZYr+E4XSpYvBOnTa18vEMyNa3YkfqOS39/waAcaBrqAFW/akB3oq59BW7H+vxZmUr+FJzsBR/jeQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zp97iEvd7GjbkIdmZQEEBUSAyl24WJ3uN/dDwOlGDkM=;
 b=aLFJlz1ZgPzYc5+zekg95GN94VFNtO+H6ezoYj8fue6XTtVii9JwtiJqgPO+0hp65B6MA5TOAS6PbogWSTZ4LCFBmYSsXZcZrD4rjWElDI5TUOqk2j8kAi0Sem8Td2HWHK1n1pcb60/2KO4Uh/dWJe+vNM1qhbX9bTC/6IA248YPGVhcks4vKPn9be2qydB+QEBQ0kIipMIIa3j7+v1SlAVRZgOl46Qmv2AMhbieJyKxeS41imbrxMgpaxzrZMniylwj1PmUo9GzAf6RQ5gbsh/gQHvw6hkHpcqN89HHqGUuHntrqfMI+loOge6KkbyFw715ahg5VblIOuCnGVA2rw==
Received: from GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6d::17)
 by DU0PR10MB6385.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 09:09:01 +0000
Received: from GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8e3f:ee20:5b20:8a7b]) by GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8e3f:ee20:5b20:8a7b%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 09:09:01 +0000
From: "Schilling, Benjamin" <schilling.benjamin@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: AW: [PATCH] README.m-com-x86.md: Add hardware details
Thread-Topic: [PATCH] README.m-com-x86.md: Add hardware details
Thread-Index: AQHa0WoMtLneHGC5O0mPJoBUkEeQPbINivJh
Date: Mon, 29 Jul 2024 09:09:01 +0000
Message-ID: 
 <GVXPR10MB58372AC0B85BE9E5DF0E0D3588B72@GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM>
References: <17E052EC654FA61F.30444@lists.cip-project.org>
In-Reply-To: <17E052EC654FA61F.30444@lists.cip-project.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-07-08T19:07:17.1778584Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXPR10MB5837:EE_|DU0PR10MB6385:EE_
x-ms-office365-filtering-correlation-id: f95b5822-d3af-4d66-1d8a-08dcafae1689
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?WSLd/uexFYspC0+XZAZgyNKKayvhXvIEpY4hYeIUBG4c7JzmZFoLteAe?=
 =?Windows-1252?Q?ZnAsSKZKgMlPFLca8GPaJnXtz0KWMGGd5mGbosMGmJA9rOW7VXJ8/ro/?=
 =?Windows-1252?Q?F4SpfPWtFJHswei1zulPvtTFfHo494IwcorZv50ssoBv/lfroEEDUZkJ?=
 =?Windows-1252?Q?B6kWh92JvwYRiDdLjdxfRNocO86DGZxMYoK94Qg7FO5KUyHVrVeOSeFx?=
 =?Windows-1252?Q?AKU4K6hQMQ+viz/CUr0Alv7EjVcNIwDBeTz2KnWU0UJUZC2z1z78UW1H?=
 =?Windows-1252?Q?9MYpnEX/I1VgvzXQlTJFaAmkjgPWipD1GXr/UNCW5+bzgAf7fxQiXDcp?=
 =?Windows-1252?Q?7IKsROH709M241hrRvzE0nEmAiOBmy7/oINkdzxQitiBCS5N/BOLzWnO?=
 =?Windows-1252?Q?EVa/yIWFUqMPPtWM2haRn7dsqmbMPRq6GannTJcclqdXKFFz9Gao0A9p?=
 =?Windows-1252?Q?UOLlWSIJA+uAilwnHLOaz03Q4QGEIiQ5uOZMLqeBIIHYwBInPohA5ncP?=
 =?Windows-1252?Q?NddesfQ/MD13uLiJuoewg+uvujQwrFQHXppw3cONasbtnPCemgxfVGSw?=
 =?Windows-1252?Q?99CqQJsTLP/s6utYRKd2dBiBwvnFmZf71Wzos6mrWLuU8krn/qbewfOq?=
 =?Windows-1252?Q?xMhGPg/JNpi3wJMHb4Y42zhK1hbZPVjWoLpjNlzQUx0H5Ui4LDmr29/J?=
 =?Windows-1252?Q?AKfvZ+6DrvSmHE4lAfuW8GHaa3sztq+54syfAXu2yN09QceYU5Q97dPe?=
 =?Windows-1252?Q?htfNC/3+7y09Z/INQabFlsL+LgaUCiEURv9oG9ahS6SPNLiSdMzsK5kF?=
 =?Windows-1252?Q?ik+3JA4TWcwLX2vt50mQFLIOzmFdwZurjEm2ZVWFrbuOZ8TaHlJ+C8Us?=
 =?Windows-1252?Q?gu9qpCuzdIsqHZFTjBv9Xv0QFNuQXWvOfwZgr3ZFgfRDyoCV6p1P5p7B?=
 =?Windows-1252?Q?1tKSHgyyhKvsPtiNZgBu+97cYxDSFx7R9lTotWOKeMWfHc7omzOMF8ae?=
 =?Windows-1252?Q?MO4lL9F0zsNQnVKcGrwIVn6c9CfrEPE8qkvUe8d5b01Oq3krzEYpZmNT?=
 =?Windows-1252?Q?IyZqQ6o/hYPF0aX7OtGT1qZoxQ6BJcDUKgeTEymtTk8sQHRi+csuYctJ?=
 =?Windows-1252?Q?2vJug11KCA0YymmwbllvHS4R1LjEOGPTkhMHIp1wZOBVwQ9sBeOqVCf3?=
 =?Windows-1252?Q?v5HBTrhH1UoU6a0MJZhWW2ybX/SkfDuQxc/vTu6WaIQ7rhxuqb5ROVM4?=
 =?Windows-1252?Q?XgMg07QsjSGg9EvH3UdByKUqgOENYO88pB4AHdGU8WEL997Y6VyMfRef?=
 =?Windows-1252?Q?sMcSprhqgm4Zds+anRSWkZduwj2mRDaEI0s3WMzlJ11PQUgO78iAkMUk?=
 =?Windows-1252?Q?mz1wdavQX9bG8EF0LuzFydl8nIbP/s2wIGDQZj0nJecFcH9nJu8bUni+?=
 =?Windows-1252?Q?cI+yxkMUWHcaFFkARHKYZ1RQa6vde1n9x/b2Gb2BYDQ9jk+OsTMD8sfj?=
 =?Windows-1252?Q?OnFk3E6CCT/oZZgGicX6/CGcroBvYQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?IlRem7ywj1figTsct9+mlyv9r4CF/sGjnG0GRilsvxLt57txG0El0Hgg?=
 =?Windows-1252?Q?sfB/wG7HdseKi7E/b1PjwOGY2twnb4IJBHvi6TqvGtnK5BSyvHfz6DUv?=
 =?Windows-1252?Q?eDxGrYmcnKMxZV35FYlC50daw/rhcHIIuwIupNOycNAfdIkDELst2eA0?=
 =?Windows-1252?Q?NSegp77Nk55bhLZX4V3voYiGLp/uChiHKIgTC/aeOf4u56dLCT91U6Lm?=
 =?Windows-1252?Q?iN0Tt0Krrq3UVQWmv/Nq12mNS2xN4kwO/Anm6DTqdb9fd7mZTt/42jJs?=
 =?Windows-1252?Q?H3DCO+MkUkrpz2sj1d3yYrl4+JXAWLAlsuar3SYDyB55ofZEsgulTP+7?=
 =?Windows-1252?Q?v808Qtxw6sYWwq2rwuq2BL0N+6pCjFPWi4SEfSZ/CZ6oLdViJLPSPIDG?=
 =?Windows-1252?Q?DK56ZLbCnmmDSclFUzabqFaAsy2HUvRUy3oBsGaOwudNcSvsLJM8m1Is?=
 =?Windows-1252?Q?b++vd59O2oqMIE7uvHgwBL4rthWEImMbgbV1JWhsAIgO/FBfyWK5RdMq?=
 =?Windows-1252?Q?Pq6NtLoqRl7plsHNhAole88wy7c1EqlqAyX8zgMAnlXDBku7lJ/3AWkw?=
 =?Windows-1252?Q?tPYg/vql8h6pFEOaL3N0BzRFSaZhCVTQFe4IGHVAiL2eynWFEatZCwM9?=
 =?Windows-1252?Q?/lA9akKQjYJ3sDTcU1GQr7FozR8s7h/93/2Rdlzs0e1ncT4TgyLgxVUv?=
 =?Windows-1252?Q?AAIcrZpWdjIvh+0/4FFLU/coy238Dx0BwVhq2sSpNJOZkhjnbJ1Xh4f2?=
 =?Windows-1252?Q?Bg1eh8VzWIcQE6rmwqIBHsE/50gzS4DFGKedL9JWNcVeyOvhe4nWIydG?=
 =?Windows-1252?Q?u+aQ2STcEP7Am+aEFbCsO38FbcIb8NAbRajQ6zEdDpEzF9ETq5TG1Nrb?=
 =?Windows-1252?Q?915mXoi5HS3xefWVloE76fv5VFUN3KG6vMaFkPqfICa12WcOMPs0/HLF?=
 =?Windows-1252?Q?M+9yJblgEPOH28FdZMy0uAEj55j/jeKpRO7Iat5WSZTkPlZuCRpQew5Q?=
 =?Windows-1252?Q?5j5NHV7v7wzsoMvTdFj/uIDkgV0Y8J2AMd4kquz6AbiWfdn+ACU/eD4i?=
 =?Windows-1252?Q?JrSLF8BRhXl7ULTCzZdHSZgR6AMkaa8dBS8P5lfd5H67SpCLMsNiMKF1?=
 =?Windows-1252?Q?KGZrvDNaHsmVkGNSYKbcX/rvvt2mSCEg/SSx7jrCL1z3vEtE7ZVbTTdF?=
 =?Windows-1252?Q?SG5eo/9q04kfR79KCAQy3PBpZY6lxxBcrIpPdwGFpLqNIn0vnYh8L2g/?=
 =?Windows-1252?Q?9leC0+8Neq1adUbSeVbsEzeVcJA/jSxZK0VrrNQf8YUbOKBP8+6yPQCy?=
 =?Windows-1252?Q?RuAzr2dO8xQVlwWjFRM9p24E9quMoH80PevPLnpVqdDZiW4PY/tUV4Q+?=
 =?Windows-1252?Q?py85g2FjaPqALc8coi5HfzlSXFp8kl0zfs/cuAo3wAKhfCXBUBkBaXg5?=
 =?Windows-1252?Q?E8UB+Bo1J1aRVEmZZTX9nd1Mnp6k8ZMUXEcCKbSNkG5jaQ46legCBf53?=
 =?Windows-1252?Q?DFU6dSRwDn0yLX08JlMZ43FMGdwN5o54aUjOYTeN3fFwStkyBl6zyGOb?=
 =?Windows-1252?Q?9WJs+uxWD/x9kZczKgw2zeWgc1/YWtV7FITajRtB0QzzCdJj5NAsQtRE?=
 =?Windows-1252?Q?FsxvrfnEVneSatMt61MXYkkjapSsbcCoJzC4ZryUYrimEqdGAwSdBlGk?=
 =?Windows-1252?Q?MIEeh1TDpWshNYjXeTRkxP1vaq2GW227Y5D0bWz17b+S0jHbp/tnhr92?=
 =?Windows-1252?Q?4b1LN7qKUxvjsb3025U=3D?=
Content-Type: multipart/alternative;
	boundary="_000_GVXPR10MB58372AC0B85BE9E5DF0E0D3588B72GVXPR10MB5837EURP_"
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f95b5822-d3af-4d66-1d8a-08dcafae1689
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 09:09:01.6651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IM0uJTsi8DRUglijis2zFHplmG/pFr5oLPamfF3G5UIUxVRe2Xi6ni1Kau9cmZSiTfDZJqz7mAwnaKoYpTLKIVaWsT1E2tObeiq2BTnmabc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6385
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 09:09:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16631

--_000_GVXPR10MB58372AC0B85BE9E5DF0E0D3588B72GVXPR10MB5837EURP_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi all,

what=92s the status here? Anything I should change before it being merged?

Best regards
Benjamin

Von: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> im Auftr=
ag von Benjamin Schilling via lists.cip-project.org <schilling.benjamin=3Ds=
iemens.com@lists.cip-project.org>
Datum: Montag, 8. Juli 2024 um 21:17
An: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Betreff: [cip-dev] [PATCH] README.m-com-x86.md: Add hardware details
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


--_000_GVXPR10MB58372AC0B85BE9E5DF0E0D3588B72GVXPR10MB5837EURP_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
	font-family:"Aptos",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-ligatures:none;}
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
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Hi all,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">what=92s the status here? Anything I should change before it being me=
rged?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Best regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Benjamin<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">Von:
</span></b><span style=3D"font-size:12.0pt;color:black">cip-dev@lists.cip-p=
roject.org &lt;cip-dev@lists.cip-project.org&gt; im Auftrag von Benjamin Sc=
hilling via lists.cip-project.org &lt;schilling.benjamin=3Dsiemens.com@list=
s.cip-project.org&gt;<br>
<b>Datum: </b>Montag, 8. Juli 2024 um 21:17<br>
<b>An: </b>cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt;<br>
<b>Betreff: </b>[cip-dev] [PATCH] README.m-com-x86.md: Add hardware details=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">From 4e6b957569e0a4dd617cc1f4fd=
716c769681f6dc Mon Sep 17 00:00:00 2001</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">From: Benjamin Schilling &lt;sc=
hilling.benjamin@siemens.com&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Date: Mon, 8 Jul 2024 21:00:14 =
+0200</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Subject: [PATCH] README.m-com-x=
86.md: Add hardware details</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: Benjamin Schilli=
ng &lt;schilling.benjamin@siemens.com&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">doc/boards/README.m-com-x86.md =
| 131 ++++++++++++++++++++++++++++++++-</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">1 file changed, 130 insertions(=
+), 1 deletion(-)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/doc/boards/README.=
m-com-x86.md b/doc/boards/README.m-com-x86.md</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index cbd74ad..d677b76 100644</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/doc/boards/README.m-com-x=
86.md</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/doc/boards/README.m-com-x=
86.md</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -1,4 +1,73 @@</span><o:p></o=
:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-# ISAR CIP Core: Instructions =
for M-COM RT X86 V1</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+ISAR CIP Core: Instructions fo=
r the Siemens Mobility GmbH M-COM RT X86 V1</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+## About the M-COM RT X86 V1</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The M-COM RT X86 V1 is an indu=
strial grade PC.
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+It is designed to be installed=
 on-board of trains and can be used for communication and processing purpos=
es or as a security gateway.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+## Hardware Specifications</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Intel Atom E3950 CPU</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- 8GB DDR3 DRAM soldered, ECC<=
/span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Trusted Platform Module V2.0=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- 3 Gigabit Ethernet ports (M1=
2 X-coded)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- 1 USB 3.0 on front</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- -40=B0C to +70=B0C, fanless<=
/span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- EN 50155 compliant (railways=
)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- 16 GB eMMC storage</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Input voltage range: 24 - 11=
0 V DC EN50155</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+### Power Plug Pinout</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+M12 B-coded Plug</span><o:p></=
o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+| Column 1 | Column 2&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+| -------- | -----------------=
---------- |</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+| 24-110V&nbsp; | Edge trigger=
ed power on |</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+| GND&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | Not connected&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#### Powering the device</span=
><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The device must be connected t=
o a powersupply providing 24V to 110V output voltage at the &quot;+&quot; a=
nd &quot;-&quot; pins.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The &quot;switch&quot; pin is =
used for edge triggered power on.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+It can be hardwired to the pow=
er supply 24V to 110V to trigger power on of the device.</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+### LED Matrix:</span><o:p></o=
:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+| Column 1&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | Column 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Column 3&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Column 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+| -------------- | -----------=
--- | -------------- | ------------- |</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+| Power STBY&nbsp;&nbsp;&nbsp;=
&nbsp; | Power ON&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | WD-Trigger&nbsp;&nb=
sp;&nbsp;&nbsp; | Error 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+| ETH0 Link/Data | ETH1 Link/D=
ata | ETH2 Link/Data | RS232/RS422&nbsp;&nbsp; |</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+| Module1&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | Module1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
 F1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 | M.2 Used/Data |</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+Power STBY (Yellow):</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Standby: on</span><o:p></o:p=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Powering down: flashing</spa=
n><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+Power ON (Green):</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Operation: on</span><o:p></o=
:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Powering up: flashing</span>=
<o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+WD-Trigger (Yellow):</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Trigger pulses: flashing per=
 pulse</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+Error 1 (Red):</span><o:p></o:=
p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- WD-Permanent-Reset: flashing=
 4 Hz</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- WD-Disabled: flashing 2 Hz</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+ETHx (Yellow/Green):</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Link: on</span><o:p></o:p></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Data transfer: flashing</spa=
n><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+Module1 (Yellow/Green):</span>=
<o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Module-specific</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+F1 (Yellow):</span><o:p></o:p>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Controlled via Software</spa=
n><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+M.2 (Green):</span><o:p></o:p>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Module installed:on</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Data transfer: flashing</spa=
n><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;## Build the CIP Core ima=
ge</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -100,3 +169,63 @@ After boot=
, check the dmesg for Secure Boot status like below:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">root@demo:~# dmesg | grep Secur=
e</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[&nbsp;&nbsp;&nbsp; 0.008368] S=
ecure boot enabled</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">```</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+## Internal interfaces</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The M-COM contains an internal=
 serial port that can be used to access the devices kernel console for debu=
g purposes.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+To access it, the backside of =
the device has to be unscrewed.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+Afterwards it can be connected=
 using a Mini-USB cable.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+Make sure to have the appropri=
ate FTDI driver installed.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+## Software Interfaces</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The following chapter describe=
s interfaces accessible from software level.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+### Controlling the watchdogs<=
/span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The M-COM RT x86 contains two =
watchdogs:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- Custom Hardware Watchdog</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+- UEFI watchdog of efibootguar=
d</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The UEFI watchdog is controlle=
d via efibootguard variables.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+It can be configured for both =
partition sets using `bg_setenv -p &lt;partition number&gt; -w &lt;timeout =
in seconds&gt;`.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+To confirm the new watchdog co=
nfiguration use `bg_setenv -c`.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+To disable the watchdog set th=
e timeout to 0.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The watchdog is fed via `/dev/=
wdog`.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The custom watchdog is control=
led via I2C.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+The following scripts can be u=
sed to control it.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+Enable watchdog:</span><o:p></=
o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+```bash</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#!/bin/bash</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# i2cset &lt;i2cbus&gt; &lt;ch=
ip-address&gt; &lt;data-address&gt; &lt;value&gt; &lt;mode&gt;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# i2cbus&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =3D 2</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# chip-address =3D 0x3c</span>=
<o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# data-address =3D 0x00 (Statu=
s Register)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# value =3D 0x8000</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# mode =3D w</span><o:p></o:p>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# enable watchdog</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+i2cset -y 2 -m 0x8000 0x3c 0x0=
0 0x8000 w</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+```</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+Disable watchdog:</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+```bash</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#!/bin/bash</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# i2cset &lt;i2cbus&gt; &lt;ch=
ip-address&gt; &lt;data-address&gt; &lt;value&gt; &lt;mode&gt;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# i2cbus&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =3D 2</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# chip-address =3D 0x3c</span>=
<o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# data-address =3D 0x00 (Statu=
s Register)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# value =3D 0x0000</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# mode =3D w</span><o:p></o:p>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# disable watchdog</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+i2cset -y 2 -m 0x8000 0x3c 0x0=
0 0x0000 w</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+```</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">\ No newline at end of file</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-- </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2.45.2</span><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_GVXPR10MB58372AC0B85BE9E5DF0E0D3588B72GVXPR10MB5837EURP_--

