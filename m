Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D64C3DA42
	for <webhook@archiver.kernel.org>; Wed, 17 Jul 2024 11:24:34 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.15])
 by mx.groups.io with SMTP id smtpd.web10.12953.1721215467478223421
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jul 2024 04:24:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=oRi+6bJZ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.15, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecHSgGdp1Oh7g+gskh0UXKz6pCM57ltcD662gQcokOusQLydb9uxhEWM0AyWnkQAcHRd203blZi5xb+2Fa4d5clqo3jxGHNl1Tt57SrdXuQ3UkdOhDR0MiyZDkeJpJgK7PpW1GMjlsbgRZxAmbHxujR0TkvQLvmPZ9Z4U3332R8d7Xf/MidUh4VGZERTITz7C4XRz1DvrZTs+OxgkCNR3oGsu7CgCEyScNTQQUY+DOb8oUuUdDDcF+HBhWcV3cBBcpwK+ab6jYUTMHCmtXn6cFnisrX6mwCYJvRSeaXx5dBY+571Pz99rapfpPhse/Wn60EVsf5B2K2RAZaRpFyDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlPhjxYYvSDIU79M5hCunfXXjDiP1Yczsd/17R5w0TU=;
 b=RJmJD0nnkmk7zrGx8VSHXKE4rm6jDjrln7IsounEsX85aJcoUtfPIzLJmghoWGFF3m9vyBdDdkiiMeW4qDQR+kjCEXu0P/AePFFe8bzVw2J0NYe/bp5qIxUFFVTpL494TYR1q7p26FlJkZyPAEVMUoj74xU0oT09Oa6zOD1h9Uf/oX9oRlSQGxQGtBe2Rs6sytrUQSF03ZlPmdX8vOxDOW3xERrX6LqOkQkmmrM/cDCW0eG2JuTrAO1DJqtD8Zt5leDlApH7KsWfwL/nnd31i+nTDN1+l77Qq4Aap1nCVLO3DEBmfRPE8CqOrlzy8afDigYJ2xmPNUMr2zzP53pApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlPhjxYYvSDIU79M5hCunfXXjDiP1Yczsd/17R5w0TU=;
 b=oRi+6bJZfIvfrlrcjdCKQO9WOsS7gso/R5sDP8XlJLlk4Pn/JENVPccauFpk5L0SaP+bI4bemCNY/SYKSOB2B6yDqBRtH5lKRVGQjo7zadKXLGNo+8fyJ6nocn8RW2DUQqIOAx2dvzuZTnKbwtClcaZUIg3skZoLC5yh2ECSPxQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB11875.jpnprd01.prod.outlook.com (2603:1096:400:40c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 11:24:22 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 11:24:21 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek
	<pavel@denx.de>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip 22/31] dt-bindings: mfd: Convert
 da9063 to yaml
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 22/31] dt-bindings: mfd: Convert
 da9063 to yaml
Thread-Index: AQHa11l8xWIefydXWki1NN0L/gmgorH6xaaAgAACi1A=
Date: Wed, 17 Jul 2024 11:24:21 +0000
Message-ID: 
 <TY3PR01MB11346270FF6DC0EF0FEC8A5DB86A32@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
 <20240716082255.56551-23-biju.das.jz@bp.renesas.com>
 <ZpenDV9i+M/VRqAR@duo.ucw.cz>
In-Reply-To: <ZpenDV9i+M/VRqAR@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB11875:EE_
x-ms-office365-filtering-correlation-id: 7840cb11-df90-4e25-ead8-08dca653017f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?MHQ/f8isOOrFSbvotMRPY0IqNJxfUBG4xaIZEw4RZM5EPl8pMFrZ+yL/Mi+p?=
 =?us-ascii?Q?tFwAVU8SiUmebgCFg/Pfn4WBGgQZ+wFfkK4n+VYBUlAy2E0OrZwG8KULNkhM?=
 =?us-ascii?Q?ba7m4HrbA+OziU+bOLW4zG4KuqelS4nbltPapH2ts55ZBtgM/ZL1w1ud5CLc?=
 =?us-ascii?Q?WqRkHa7RG3KIbXdYGFkVBzuACIDErHcOS/13APLQcY7wElSrOhqLdoQ7A3yM?=
 =?us-ascii?Q?if5wO4GBODpK2+tXi91zErlS0pR/aRD621/OqMe1EUMBtJD+Gs8QrpEp5gbQ?=
 =?us-ascii?Q?x3YFcMOb9xHV/NhLToIlqtF1xhKfTFR4aHkPiH2n1rXpPANSbzmxs1yiI1Mt?=
 =?us-ascii?Q?JrHBNF/Oc+le7Mz06ZYnHGkFQrM+NTi1tvIH/jUcLZZjUdHqMnXUOu+EQSbF?=
 =?us-ascii?Q?bWou0YaGpGGOpWmRxaLUtpCDw6sE2pRniwq+t4x5FQh2azR0oAiuYqqIQ6CY?=
 =?us-ascii?Q?uIyRe39MOXjWclJFDoPFRC363gYHfTw0B1vweTlDP7lZ/nFMOctlnXdA2iU5?=
 =?us-ascii?Q?wrbu0Z9Khx0Gvsa6gjnUvKQckTG4FuRIlzHNjdJtPdx5A2mUMTs1GVU+Cqli?=
 =?us-ascii?Q?A5HVdTpcUhHsbW4vQSo/Ld4ZsTzXB4uOOFnWXNdPIxUmG1fvBTDYvTMhPhMi?=
 =?us-ascii?Q?LSVCKMwILTNR9rzvI1Ko5OntkR1tSw7XJWmO8puwOvoaSaTJ6ie9FUTPji8I?=
 =?us-ascii?Q?C72UcvxPB7D5yf2Yu9gMwMHxALa8PHCxMT+TVWynY2zuuD0miIR0wOkwzU1D?=
 =?us-ascii?Q?WAAEuub1Tqdt2JQcZiBne5TuiFC8FXN1N/ryF4TusYLmbothKdELp4VU+gvg?=
 =?us-ascii?Q?Y/ajqOvYHuSYaNWj8VZqwXZez2QmN2qeotWrneFyRkd69ipoptDhQZo4Ghu4?=
 =?us-ascii?Q?CCY72VQO4a56ic+/XIfbf4ImHxp7t9C7/uns0a2s+tzx/O5V9tZl3N19+g2C?=
 =?us-ascii?Q?A3ULlRP2e5Oh74lTjVfPBweHFI+9J7VG6WZK1GYT7gLrbrrhOvmQPakd6Rfw?=
 =?us-ascii?Q?xExXny9Ac8k4MADlxTnw8l2QLDi3SIEGfNXXrCRsA2AxV3S8JrXq2Jx6zPv0?=
 =?us-ascii?Q?WcFwnFoRAQd5cJ9yJNOcS6PeJpzY29y/J1y38OCzbMm6pmOXWZTMUoerbBrv?=
 =?us-ascii?Q?Mouf54+eHV+lTsOPHSeH8kJrJFxTIxzGhaqn32zMkX3TBIn0b+ocNk4uOyfF?=
 =?us-ascii?Q?khwfwMxeIbYCoYEmpEOq+MPpb72mfnquesj2RhcxuF0wj1tGVxMX6RMi2nUy?=
 =?us-ascii?Q?sYQhEHydH03QbO9vJ1yAtxg7/FQiHAfsPGacNlLfthYu96/+LzR2Uu7d6hZL?=
 =?us-ascii?Q?KjguKRctIogNj/8oPKh15Wc0MyRtkt1kxk6nXmFAcTffj1fEvdsFLXuz3yFT?=
 =?us-ascii?Q?3Sx5akvIZSny+TWTnx/gxurLhhPjqCqoxHjyNW7yUElDpLeBDA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?KKbtFYcIyGumnsC3P33njURLY+qNnVWh6R8mzqRoewPc4a9XqgtCo4EgN3IM?=
 =?us-ascii?Q?veW68MdKQ54nHEXCgb8kjiYE+7EPyBkrsYnSdkFJwblkZJf4XmI3OLpYbiYe?=
 =?us-ascii?Q?Eq9FKj5ekJStajVUoa4Mb+pIcI1qRcVKO+WDFou95wABnkCy7ucegHuGBJA4?=
 =?us-ascii?Q?wulntupdEcK7Wd9mqQpDBOExL6QnHe/fWauUV5ptLxloN1kULli4ZKEjEYMo?=
 =?us-ascii?Q?vTNSGAeF/aMI4T4mRlV/KbEiPmePTVLJiRHvianVD1WvL4v0PKcA1XKauJT5?=
 =?us-ascii?Q?/LcXkEcHoaJHWyPGiEt7YhVtFfZ31iGZZ1c/YDJTvqFWPG/DyZqdQo4hy1LN?=
 =?us-ascii?Q?1+b5EYjrS2gNK45zQQv6dgbwotPUxaxLlEZDvJXTl9gDYoOsftSuU4UWGM4Y?=
 =?us-ascii?Q?dSD83OsH13hJKO/azJw+YaW61hkKC6+TSHaHdeLhvfMcHRNtjd++/euNzwzL?=
 =?us-ascii?Q?ZInPu3F+b70FKSUh5GegeQLbgYFneAmCJnHvirgoW4T+TtazLPUUjGSpJWqv?=
 =?us-ascii?Q?XP51jlO0SgiSrl2C79inPSBR4Tib1slaM3vgo6tDWl5fOgVxRXZwStzIShWJ?=
 =?us-ascii?Q?z/g4KNi41PAtsVERfWPdCUU5a44xseNVkpFsEbRWC5h5yGqL/iwqTReusdhc?=
 =?us-ascii?Q?2hnYltqsiOl0x62VY4axTfyLo+qEVuYG3tbg7ov5H43RDoCTvYtPcjb1htY3?=
 =?us-ascii?Q?ZU6f4oXe7ajLCyTAI17IL5Ar1p7tk15reQs/du4l21NhPDQsOpnGhXUOq07g?=
 =?us-ascii?Q?H3++UT+ziHAsQzcO8LT6HK6xgcXkxqem4/Td/PKjsc7fYQfW8G3g+Jg+Q5R/?=
 =?us-ascii?Q?8rPLHJD1Z+Z+M+K98oiUBBDV154PlNWWDb6TATz7g9ciJOG60r9qYj/KchHP?=
 =?us-ascii?Q?9MBU20YTacpIUlXIiL6ahS6rB5IxPWj7ZAOBSHcVSmOIKTkJlymTgEKmE9sT?=
 =?us-ascii?Q?kLkBBW81xtZvHxERrxb0jqjwAc2Xuv/o+fmGIUbJK0gk/atab+Wj8yPBaUSS?=
 =?us-ascii?Q?SxqZSroj6plISwLpKJ4w2VeAxYNZHHWjp8gUIIlwD4/i3iYy396cWAFRLuVA?=
 =?us-ascii?Q?7M/NsVaIA3S6ZVONxSAmAZ+JyIhzm9W7Qy43odvj05KsgSuNIUztOtTviAIN?=
 =?us-ascii?Q?qlWii34tuM1w1ODCqxP2ia+pLsVj+g5Vi3pzXtHJbGglesqSICcgu/LwQmuu?=
 =?us-ascii?Q?7Aq/5UiRz/tiSasiQotjM/o4p0d4vh9OdKwXmQ0gWa/dLgwH6zy6BmzZY2Xb?=
 =?us-ascii?Q?ipccr5Hotj0iDoEpk8PienhkZPWzku/0//daPFGqN2S3dmPPJS/xnvcVupEz?=
 =?us-ascii?Q?hHi5plZT9bZf8MURDOizrbIJGz5/R3yHHUnbiLY/QYCuWZDUDfLCj897XKnE?=
 =?us-ascii?Q?rf8Y7Rj759MR3kPcOkLaxW28yLlPsIbEBrvxEEZaq9rZZ6pgKm3ynp2C76T8?=
 =?us-ascii?Q?JooNDzRritLcKr1c9Tto3KlPTKLxR3sQRghSyk/OKT8F6vo8ZRhkBITxP+Dj?=
 =?us-ascii?Q?+RsKFFV3UGiTFfvgOVULb8ksLBYEpGCKUaXd9SEaA7tsADGTkcmCmgpFi1u3?=
 =?us-ascii?Q?RCKvt6+zciJfb1N45JkDaSuh8NtcCotLjwNP9hXtLjqqV+RB+iMN/JtrhBJ8?=
 =?us-ascii?Q?+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7840cb11-df90-4e25-ead8-08dca653017f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 11:24:21.7018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vN/8OIg08wVeuaywYfDKOtaxDF07nGAvX4iGeNTj6l2tOrKSvnTAVmSaxBJ90ICAv6FEuBGFogHqmr/GM7r+ZusAWZzp4Lv4ddjljfMEcpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11875
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jul 2024 11:24:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16565

Hi Pavel,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via
> lists.cip-project.org
> Sent: Wednesday, July 17, 2024 12:12 PM
> Subject: Re: [cip-dev] [PATCH 5.10.y-cip 22/31] dt-bindings: mfd: Convert=
 da9063 to yaml
>=20
> Hi!
>=20
> These tables do not seem to be translated to the yml. Similar tables are =
also gone from 28/ .

You mean drop this patch and stick with .txt?? Please let me know

In this patch the tables are translated to yml.

properties:
+  compatible:
+    enum:
+      - dlg,da9063
+      - dlg,da9063l
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  dlg,use-sw-pm:
+    type: boolean
+    description:
+      Disable the watchdog during suspend.
+      Only use this option if you can't use the watchdog automatic suspend
+      function during a suspend (see register CONTROL_B).
+
+  watchdog:
+    type: object
+    $ref: /schemas/watchdog/watchdog.yaml#
+    unevaluatedProperties: false
+    properties:
+      compatible:
+        const: dlg,da9063-watchdog
+
+  rtc:
+    type: object
+    $ref: /schemas/rtc/rtc.yaml#
+    unevaluatedProperties: false
+    properties:
+      compatible:
+        const: dlg,da9063-rtc
+
+  onkey:
+    type: object
+    $ref: /schemas/input/input.yaml#
+    unevaluatedProperties: false
+    properties:
+      compatible:
+        const: dlg,da9063-onkey
+
+      dlg,disable-key-power:
+        type: boolean
+        description: |
+          Disable power-down using a long key-press.
+          If this entry does not exist then by default the key-press trigg=
ered
+          power down is enabled and the OnKey will support both KEY_POWER =
and
+          KEY_SLEEP.
+
+  regulators:
+    type: object
+    additionalProperties: false
+    patternProperties:
+      "^(ldo([1-9]|1[01])|bcore([1-2]|s-merged)|b(pro|mem|io|peri)|bmem-bi=
o-merged)$":
+        $ref: /schemas/regulator/regulator.yaml
+        unevaluatedProperties: false


Cheers,
Biju

>=20
> > -DA9093 consists of a large and varied group of sub-devices (I2C Only):
> > -
> > -Device                   Supply Names    Description
> > -------                   ------------    -----------
> > -da9063-regulator        :               : LDOs & BUCKs
> > -da9063-onkey            :               : On Key
> > -da9063-rtc              :               : Real-Time Clock (DA9063 only=
)
> > -da9063-watchdog         :               : Watchdog
> > -
> ..
> > -- regulators : This node defines the settings for the LDOs and BUCKs.
> > -  The DA9063(L) regulators are bound using their names listed below:
> > -
> > -    bcore1    : BUCK CORE1
> > -    bcore2    : BUCK CORE2
> > -    bpro      : BUCK PRO
> > -    bmem      : BUCK MEM
> > -    bio       : BUCK IO
> > -    bperi     : BUCK PERI
> > -    ldo1      : LDO_1	(DA9063 only)
> > -    ldo2      : LDO_2	(DA9063 only)
> > -    ldo3      : LDO_3
> > -    ldo4      : LDO_4	(DA9063 only)
> > -    ldo5      : LDO_5	(DA9063 only)
> > -    ldo6      : LDO_6	(DA9063 only)
> > -    ldo7      : LDO_7
> > -    ldo8      : LDO_8
> > -    ldo9      : LDO_9
> > -    ldo10     : LDO_10	(DA9063 only)
> > -    ldo11     : LDO_11
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

