Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B426CCF258C
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 06:01:14 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.512.1763532071609209313
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Nov 2025 22:01:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=gYnZobRp;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1763532057;x=1764741657;bh=eTGLU3Doyt0gCJ42w1CCJvBA4pX3cnsZ1aLAJ
	grscWA=;b=gYnZobRp9BV+V3tRsiow8CySJbERvrFgS3dEQM9+sff2Q9lVbf2/sxNK4pnbvC90bsv
	EK8nxqQm19IFja262O5ZjylVQZu5W0BYF/ksHiRR93iRQqwULxk9I9eBl6jkRBMHu9QbCo5S/Wz4x
	9okx3cnADgPsgksF/TkwAWuoFcO2p0gpfsKCVfR2OcadUwoGHb9fgzNSOsYpb7cxuvcGpWWwFgL1x
	JAeI8r0nSP0IAru2K7vVqkOQhjCtPpt63jm8b25Mkr7kTmJn6bH5iLgHjVTzA3cmlKCs0yUbymU/4
	MW5H6svsqobM5c9gLrY2PwCA6KorAZ8Q6YuS0ZJSxOIA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 5AJ60uVK284789; Wed, 19 Nov 2025 15:00:57 +0900
X-Iguazu-Qid: 2rWg9DyHEXmJQoXI90
X-Iguazu-QSIG: v=2; s=0; t=1763532055; q=2rWg9DyHEXmJQoXI90; m=ktuZ5g6MPUwNcneoUTBo/lOiqCkY9XDmHc/Tyrl26bk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dB9ny25Lmz4vyh; Wed, 19 Nov 2025 15:00:54 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMfDtKaUO0PsG5H997E0SXi0FLuYVKwAvg2RPDIHMXG38hQY+PaFqP88/RQ5bd1zsNF3KP9k8b9vahsjkFjZ8o6S8PMkhBhdQEg65wN/PVxAy985Kiv/5+MITDO4nmyVh9INPze1IYVZvlDo6XziR+VYH941ywp+4ttGGnWDEYgiLptgast80NG3BNRNJdJCemFN+xtSz8gVhHvWSH0pHLGYD/6QfBQDAacel3UVQsr6+wqpWWBBjL1NyRFqEVSk4ju9KkgF5yd5yMRNtGO9erwUtIKFgPmi5RK2fUvemWzXUnm6k40HlHZ1VAUv37jnQD5KNMA2K0eTKEA/SnH7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URv0eBKmymofXCDeMtK4Sot52AKC8fvOsEX9CPgpJTk=;
 b=wFFEUx50a53ydkNfK/WkhYQxNpJV7uJVxAQ5xW2tmWxt6CufhYl1JF7jTu28s3LQlSBqELPDdKcV8G8/Y6isu33MWz0E/wZ+fsypYjb4ERQpWIbyTa1/8uHG6s1OnMfglHjkau9wEm4pwQQ/vR7K+G/fgqMcGlsCpNhkpXR0/Zdt2DX9XpGFhFBSufYiBTD8p1LwpnQVq86PZcHpFixkmsxTlMxQYFxFOGxuTxSIwhRlLA+VgaTzR5yLlIWQlsVRNTtCbrdQqEfMfiZPWe4RkqK9eRir6C8bEgcm5gnFtC/LthN4qbJRj7gbqPGwdX3Ku6E6Rprm6ZvrbDsQjYmflQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: RE: [PATCH 6.1.y-cip 0/2] Add RZ/V2H eMMC support
Thread-Topic: [PATCH 6.1.y-cip 0/2] Add RZ/V2H eMMC support
Thread-Index: AQHcVVfGrVRAEfyY5kKjT6RWM2DiGrT5iI2g
Date: Wed, 19 Nov 2025 06:00:51 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148184357312FADB4809BCD1ECDD7A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251114111343.74438-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251114111343.74438-1-ovidiu.panait.rb@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB10071:EE_
x-ms-office365-filtering-correlation-id: 508953d6-e880-402c-47d3-08de2730fea5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Q0RsZG1OTFRKbzNwMUtHeE9SRlZZeGhaY0R1a0lzM24wby9HYW51Tlc5?=
 =?iso-2022-jp?B?UXRGZGwweWtRZE5nNnF4MjB5Ny92SzhMNlVtci9wWFM5Y2pjaVg5VkJt?=
 =?iso-2022-jp?B?bFl5c29WeHNweDN0eEhzNkFsTWVRKzR0NjgxN2g4aUZBbCtVLytjRWZ2?=
 =?iso-2022-jp?B?SW5TeWhMVXNnVlhtdERPcU1RV0l3TzNqRjVSSkx5VlBVYjB4dUVOS3Mx?=
 =?iso-2022-jp?B?VVZPMHNTSmIzbXhwVFdIYUdNU0M4b0JQUFFrTFRDelkwbitRWU1xNlZ4?=
 =?iso-2022-jp?B?Q3plWlluamx0d25wbjZLQ2JzU2pRekVpakJHTFpBd3ZwOE1TczYyRVVJ?=
 =?iso-2022-jp?B?Zk95TWZONEdwYkt4bXozTUJ1Y01ZcTRReU1UK1ZtT3czWjB0NUQ3WjI0?=
 =?iso-2022-jp?B?Q0tPb0k3VnNjTnQvU3ppSXh0c2doaVMyTjRVeDJoMkZ6aVYrak9iZmlE?=
 =?iso-2022-jp?B?N1o5NDJTaFBnVHViTnd4QThkZm1JZ3M1N2JmVmg5SkVsTGZ4dUdmcUpS?=
 =?iso-2022-jp?B?Z2lLNUZyY1B6NVRneTRKUmtUTkpQdmd5ck5ORlcrMEJMWit1eGc4dFhp?=
 =?iso-2022-jp?B?MlUrVDV1bGJWR2t0eTdSRW5qRHRrQUV5aGtINUVoMFY1OU02WWNSWXFj?=
 =?iso-2022-jp?B?Unh5OEFDR2ZabWhCRzYyZUF0Z1FEZTczVCtoNnBFS0RpRjFCMEc3MnF6?=
 =?iso-2022-jp?B?REh1NDIwdEJHUHJ0dzBzUFNzd3JnTHRXblNhRXRsOWdMRnZlUThzK1dw?=
 =?iso-2022-jp?B?Vm5pNWFVUmo5cmhHeDgraWlJVHBFd3lMUUlaUlh3WVhKc3V6dERiUmRN?=
 =?iso-2022-jp?B?aEJMdlB0bTZrNDB2ZDdVNGJMdVk5eUtpenNXQkU5eU45SnVNRVJRa1ly?=
 =?iso-2022-jp?B?d0F3MHZJcHJ3aDZQQVVVdHJjUk5XSUdsT1dzT1lKSjlaYk1aei9BVFBL?=
 =?iso-2022-jp?B?MWtBZll1blpCS3V1Tzk5ck14a0w1YU9FdGVhSUlrZHdxMFZyRWJtbFhj?=
 =?iso-2022-jp?B?VTFyTU5JUGpHNitsTE1oSmJlaHZJQzJCMFJRbDQxc1IrandCUnczUnBu?=
 =?iso-2022-jp?B?cmZVTmVoSS9DZ3FQZkJYTVBoSkV0c3hJeTl5RGk4eEFsNTIxUjhXLy91?=
 =?iso-2022-jp?B?NlpSZ05ZOG1Mdk14bTc5RHFaUkptUXkwU2tvSUdObVUweW42eVo2cUI0?=
 =?iso-2022-jp?B?bDNyQ3ZUM0g2RHhZYTNVWjEwYjVJcnBsSlpsWnZHMTAraDJCWkQ2Y2tQ?=
 =?iso-2022-jp?B?bVRoTTd3cE1NN2I1OTZHTm5DbTNMaVI4YldwWHNQWERUc2JwbndSUkRN?=
 =?iso-2022-jp?B?TWRFWkdZWFNwZXp2WkFBN2VnNjdRMSt3ZVp4SFErdHd5R1kwOFVjU09l?=
 =?iso-2022-jp?B?Rm14bmNUYUNtVXNOZmdkWUN5Q3lmbUprOGlIMzZ5NjlRS09KZnJEUWJL?=
 =?iso-2022-jp?B?aVBlaWRmdDl0c2M2ZlFRYkhzZU1ONiszT3o4ellYb1FoYmwxRmNxUDl3?=
 =?iso-2022-jp?B?cDR5TnlJdVgzeEEvZWxzNnhSZ1kxM1dhWmtBczdKeTIyM0VtNUhjaWZD?=
 =?iso-2022-jp?B?WmdHSUJickZVWlZHNXNuaCtLSEtEUGJ4elcyUTVXemtMaUh5b0RzRTZj?=
 =?iso-2022-jp?B?ZWpScUduM3FwVUtHNUtObGJ0ZmFNenYrNDJaK3Z0TmVacFh2cDkreTNK?=
 =?iso-2022-jp?B?eDZDdm5QUWg4ZjFYTEpjR01HL1JFV3g2bzBSb2R6UUo3V1J1ekpYeVB5?=
 =?iso-2022-jp?B?UVFxZzZKUmdjaHNKd2x5S2FLbllsdzdVSG1jL0I3WlZRYTZYUnBhdDF5?=
 =?iso-2022-jp?B?UXY5YjZIMHNUY2FBMXFEWHM4dTh6OXZsRnFVZXgvelgxQ0pUZHBVZWVE?=
 =?iso-2022-jp?B?emllTU1jcXlEdTFVcE01eHVud1h4M0oxYmxObTdqdFMvbHUrUmttTUJr?=
 =?iso-2022-jp?B?bVRYSWt3Q3U2WG12c3VKak03dlZmUlU4R3RrZXhlamp5eFd3aGJaMldN?=
 =?iso-2022-jp?B?YVZtWUtkVWloVHI0aGp3MkY4WWtxakJRTWxRYXI1aVZwWWFINW9iTDdk?=
 =?iso-2022-jp?B?c1M5a1M2dWIvNFd0dEp3YVNXbXVKaE1xM1F2SnVyTFRSNkUvUnVvb3VE?=
 =?iso-2022-jp?B?b0Y1RytSUTkxQ21mdUZBc2RVUXdKdjVtNExCeTVoTWhRSm9FS3hoWS9O?=
 =?iso-2022-jp?B?NUxjK1VxeVFPUU5TN0NpZVQ2RFY0M2lu?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WFFueUlGN2hlL1loRUp1NGc4ZWhGSWxFLzYrYytHZEFsc21BTFljTnhE?=
 =?iso-2022-jp?B?dkE5dzFSWFRSOG4wSTZZeE1nSjFiOTVHemU2a1ZCYWJmcUJxR3crRUJL?=
 =?iso-2022-jp?B?b1FpWDhQY09uTnlUY2FhL05DalZCbVFDRU9DTUN3cGMyeFZ6aWYzRFlD?=
 =?iso-2022-jp?B?QjVSRCtia1k2allLTGFBUTUwbWxLNzJydlp0Rk1VU0hEVVJuWEJHMCt6?=
 =?iso-2022-jp?B?T21ib3djeEllN2w3aDRETXRFM3JXNzl1Z0ZObDBTeUVNR0VndVNGYWwx?=
 =?iso-2022-jp?B?RUc2SlMwOTJqTHd3bXlJeE5sZlgybGJNOXllMFljSjJqbUd0SWkyUGNv?=
 =?iso-2022-jp?B?S1poZ1ZGdFF6UHFDTjBHWFozbXFNU2Y5RTd6YS9sdFF5ZVZiR0Q1NXlZ?=
 =?iso-2022-jp?B?cjJQYnhXNW1qcVJjdDZwUGllKzRENmhDVXNCMFhsM2UrdzlNMG9OWDEr?=
 =?iso-2022-jp?B?Qng2aWJnREs3UnVNRzlSckordHN0dWRkY25PNkZTMXlKdUM3SmRoTUtn?=
 =?iso-2022-jp?B?a1p0KzVoOERZcHNpLzlmaFBCNXhFeVJCWndnMXhQelpDdGQ4YUJ0R1F3?=
 =?iso-2022-jp?B?Nis4b0liZ1cvUHdoM3pldkdRZlN6N210NFNnSWc3Rmh4WWRubERFTFgx?=
 =?iso-2022-jp?B?dnVxM2lXcndLNTBjcUNseDZQc2pQTTZFcm9ZWGRIZUFBU0hWdExkVnBT?=
 =?iso-2022-jp?B?dzZrT2Eza2ZlY01odnQ3WlJKSVFLTE11N2VETVZYZ2toRWVnOXcwVXUr?=
 =?iso-2022-jp?B?VTZjUlN4ekhqa1A0d0dwQTl5UGd3TXZJQVBjaGcwQ2dqbmFtREZ3bGNr?=
 =?iso-2022-jp?B?Z1lFL1RRSGNnOTkrS0tsS3h6di91MGxoM3J3amFwQ1BxNVFBMndPL1V0?=
 =?iso-2022-jp?B?UzZONk45UVUwYUEwSmF6NER1dmhGcnVjbHdzNGxBbnlxUXFPaUdzR3M3?=
 =?iso-2022-jp?B?L0RmR2pKR2R3VXFRMGp3SlpmSHNwSTJPT0UrSXIzenF1eHpoeGVwT2N1?=
 =?iso-2022-jp?B?Z28xNW5rdnBmbHVteHhHUXZFQ3R2OXF6dlpFdDNrSzJwRGFOZnNKL0F2?=
 =?iso-2022-jp?B?dHV4RE5QN2NLZ3JQQVZYZFgvNUg5QWdpSUcrMCs0NVIzYjdvVDl6dWFX?=
 =?iso-2022-jp?B?enFGVldpUU13K01vZndTRnFVU3hLN21yTXRzZ3VXUndyS2RzUGZxNHEv?=
 =?iso-2022-jp?B?QUtTbjVIYUFyeXZXdnVsMUdTWUZuZk5YSGpIVG9kb3pORVp0QVE0a2hn?=
 =?iso-2022-jp?B?WWRXb3VuVy8zdjhRM2Jtamp3MTdUdnNEWHBJZ1BmS29jRE1FeHUxeVNy?=
 =?iso-2022-jp?B?ZlZIRnE4amoxd0ZOWjFVUy82L1JvT2l0MEFucitseU96clNIaGlEU2ph?=
 =?iso-2022-jp?B?a3o1S0x6WHhhMWZTYjJTcitkOTFQaE1Da0FhcC80Y2FWcmQ0dlhlaFIr?=
 =?iso-2022-jp?B?M0pyWEZzRDdTbUFBTU8xN3RlRlg4VjNFOVdJM0dnVnozRyt0TThRblZx?=
 =?iso-2022-jp?B?UHdlRTRZWEg1aE5ER01nTVMxbXFXSzk2QXVwdElCWnBsMHFDYkNTN2lL?=
 =?iso-2022-jp?B?QldDeURDeTNmZE5JVWJJc3crZ3d4SXVQRnZMeEJuNDlzVjE4cGhsVEQ5?=
 =?iso-2022-jp?B?ZVlQdXdKWjFQYytqZ2JnODROSU12U3BaK1VXTVRMU0dNK2xMQ1FldmYz?=
 =?iso-2022-jp?B?NzJIVlJ4dlhXS1VYN1hjL2wzV3NyaFJWVEs0VmZhTDBCY3lFVmczbnUz?=
 =?iso-2022-jp?B?ZlR1NGpjbWNqemt6MGU4bS90MkFrREVCOFU0dk1IeE13Q3lWeW5uTXRy?=
 =?iso-2022-jp?B?eDN5T1JrQXBGQlNYTU8wNTdxT1J0NEp1akVEQzlTUXJTT1ExblZNREtq?=
 =?iso-2022-jp?B?aFNZOG43L3IrZ2V5SlVJZkI3dUUyYkJ6ZGpIcGZFNGhvVDFxZGtUbHh6?=
 =?iso-2022-jp?B?b0ZYb1dzSW9ya0lYUEhHTVRjNjBrL0Q1Z3NLUmpmVUw2a00vOWtvY0ZC?=
 =?iso-2022-jp?B?RXZaZSsxdmp1SHhKeXBnc2R0N2FQb1p1R0V5SGx3cCtObnVFWVp6LzVn?=
 =?iso-2022-jp?B?bmdxWnJJeElqNWtQRVZXS09xWXR5YTBSSXFCRXV0YTZBZ1dqN2RER0Q2?=
 =?iso-2022-jp?B?SzRQQ3BVWDlGUnpGeWRob3I2RXRQNm5ySGdIenlLWUo4V0lrZnBpTjhX?=
 =?iso-2022-jp?B?Mzhyc0NVNFg1ci9waVlnVEFYS2g1NkF3cnN3bWR0Zk1JS055NVRDNXJv?=
 =?iso-2022-jp?B?VmVQdzRTOURSUlJ3a2FRUEhwcGFWYmtmTmYyRkxQdnE2Ni9FcnYwblJT?=
 =?iso-2022-jp?B?SzVNYk0rSmdUdVZaV04zTmV0MDA4aXJERWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508953d6-e880-402c-47d3-08de2730fea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 06:00:51.7030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yBnItfFDyckmYQKtiLGjJrcIXsVe8lUc88M1IrxQcCpoHH4jemeJkjO6pDyUwJGgx1IMbwOcXBybNnW97MelmYA7VFYDzbW7VbZHpb9RKk9I24GqRZ+ENHClAZlDVDMz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10071
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Nov 2025 06:01:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20623

Hi all,

> -----Original Message-----
> From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Sent: Friday, November 14, 2025 8:14 PM
> To: cip-dev@lists.cip-project.org; pavel@denx.de; iwamatsu nobuhiro(=1B$B=
4d>>=1B(B =1B$B?.=1B(B
> =1B$BMN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.to=
shiba>
> Subject: [PATCH 6.1.y-cip 0/2] Add RZ/V2H eMMC support
>=20
> Hi,
>=20
> This series adds support in 6.1.y-cip for the eMMC and microSD sub-boards
> connected via the CN15 connector on the RZ/V2H evaluation kit.
>=20
> Patches were cherry-picked from mainline kernel. Note that only the RZ/V2=
H
> part of the eMMC patch was backported, as there is no support currently f=
or the
> RZ/V2N SoC in 6.1.y-cip.
>=20
> Best regards,
> Ovidiu
>=20
> Andrew Davis (1):
>   kbuild: Allow DTB overlays to built from .dtso named source files
>=20
> Lad Prabhakar (1):
>   arm64: dts: renesas: Add CN15 eMMC and SD overlays for RZ/V2H and
>     RZ/V2N EVKs
>=20
>  arch/arm64/boot/dts/renesas/Makefile          |  6 ++
>  .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    |  9 +++
>  .../boot/dts/renesas/rzv2-evk-cn15-emmc.dtso  | 50 ++++++++++++++
>  .../boot/dts/renesas/rzv2-evk-cn15-sd.dtso    | 69
> +++++++++++++++++++
>  scripts/Makefile.lib                          |  3 +
>  5 files changed, 137 insertions(+)
>  create mode 100644
> arch/arm64/boot/dts/renesas/rzv2-evk-cn15-emmc.dtso
>  create mode 100644 arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso
>=20

I reviewed this series, looks good to me.
I can apply this series if there are no other comments.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


