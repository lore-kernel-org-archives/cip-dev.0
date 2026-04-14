Return-Path: <Chris.Brandt@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C45CF531FB
	for <webhook@archiver.kernel.org>; Tue, 14 Apr 2026 11:14:01 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16446.1776165230933668974
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Apr 2026 04:13:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=UslOtR27;
 spf=pass (domain: renesas.com, ip: 52.101.125.14, mailfrom: chris.brandt@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqsHBftI2EizXAA0RToTF25xxEQNTZEiPskdK+uj3gscJAKDl8Ow5Hd9TCFsoI51rrFbB5eL/bW8VfjkkcBsEcLL9GG1wT6DmQY+lKTlOqUJ+NN40SQJjODYqv0tWlu6N9d7hIkLOeSnebfdHFsxpbQ4L5RlhxjBnNKdHcGt8pRUQuFaNWJLEtAWZ8NaTqUHyCOiW2Lg7h0zvopGBZ3w2FUdyps36w2UELpu4QxQ3PFm5e9CFnSyrns9IY1IiclfVOspJr9QRNYcdVPiy8ouJUHRUVNGUUlEvRU/irGkDQexokLjMvsNi05gLvWMhkUktOaOSUzNlox6NokFUuGakQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHrxJQjbxyw3Zj3WW1W2ftcAfNeStwDqpOEnBsTKTFw=;
 b=eN3VaN6PqlU5kEFOG6g7ddj585vmgj2Hm8h3PXp/T2fQ6/N/kEdQ+PCKTYPAJ1SNEhDmFMlmfUo7o4JG2YFhecT0Ke16bs6IGbNdZ0cAz0SZftg+khyTjDZE+TZyd0MHcH1VzN2oLS3LklNB6RJLkKSbofLucidWQjGqs0aDZ4KsfZTkKSb+oGTpmE9QPDJOTvL3CazDzWphjB8kAU3lbfT4MtKf+YQEv/8GITJWP+fIKApUt+DyfVCLfqPjTzbx+qoO/iyyRxgOz5/Ym+eCsFWEO2anws5eZhbkWlAFyQfe0u8JX+HgsX5KkMKcp/25QhGADuAr/eFtoDucVAfjHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHrxJQjbxyw3Zj3WW1W2ftcAfNeStwDqpOEnBsTKTFw=;
 b=UslOtR27DrVMqi6phqkR4ub/e7LMAADdt3FoEcz/lwd6mPu0MktKUSaIpW6lgOfm2YAJDH/vQmMB6lP8GKicurihBzia3epVDELEJLJ1nIIfZsHVYP7cNyJWPgIFFSmDFQvSrDj5/be0wExFyugmZd5O8lMEbuXkX3T5z1EAdaM=
Received: from OS3PR01MB8319.jpnprd01.prod.outlook.com (2603:1096:604:1a2::11)
 by TYYPR01MB12693.jpnprd01.prod.outlook.com (2603:1096:405:15e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 11:13:46 +0000
Received: from OS3PR01MB8319.jpnprd01.prod.outlook.com
 ([fe80::6473:1660:bdc2:c983]) by OS3PR01MB8319.jpnprd01.prod.outlook.com
 ([fe80::6473:1660:bdc2:c983%4]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 11:13:44 +0000
From: Chris Brandt <Chris.Brandt@renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: RE: [PATCH 6.12.y-cip 1/7] drm: renesas: rz-du: Add atomic_pre_enable
Thread-Topic: [PATCH 6.12.y-cip 1/7] drm: renesas: rz-du: Add
 atomic_pre_enable
Thread-Index: AQHcy+3VFJdZEmS1dkGW9zeTV8iumbXeXiBw
Date: Tue, 14 Apr 2026 11:13:44 +0000
Message-ID: 
 <OS3PR01MB83192447CA12421CDC15BB538A252@OS3PR01MB8319.jpnprd01.prod.outlook.com>
References: <20260413171733.3088070-1-chris.brandt@renesas.com>
 <ad4DVpSwzcEoXo0l@duo.ucw.cz>
In-Reply-To: <ad4DVpSwzcEoXo0l@duo.ucw.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8319:EE_|TYYPR01MB12693:EE_
x-ms-office365-filtering-correlation-id: fd2c48f5-6ee7-446f-c486-08de9a16e441
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18096099003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 BhN/BOUy4636xcjxdiwYDQxVuwL/3Fus2L3HUyxrFqI5lshgp4aAthwxfCWje9I2UH+849PQaE+Jeo42R055L+3522TefGX69l3xPLYKwRIR62sKXR1vpOJgknpaNwHQZeVgK/nCZaGVfWuidA21dRla9EUaBj4OLUhTwXWbANePcOQkimkR19ATqSfpUBleVt/WTpFJnv3J01Y8O4EADY4pTY+3qZRLZFK6RnlpaLuMzAbLeymXejlCMBeEhZSnZgu0sArlwBnaSRQKdSklZv/0LEson8yVRWeiRTOoNTJHbVCV5VTlnuifRh6U2tYlcnmj548pXFeNzxIIFQKUTjUnzQ4g4w+3JtrWdhhh4eig+8y0ujC/SMGvdT4MVyZzCO0PBxo9rqCKnjrQBgp64LzVJGSEWc6qRQzfeAr3+1bjWbDARJYjytYxM/LvKVxV0Gy06kgwZyYgz6zMhYtT/cjl6/68XKcjyWf/jL5/Gvn+12nFpuwEPmwtPMEZSBCW3Ghi5dToB4ebYy74XBCIfUAR9XbZ8SSvC0og5oJXhP98a+OmZU4U5EbfW7gJ8iaxK/FNGOCZ+y3IpghQeN0ZN9+20jtRXQ/THTSKE343aCGf1pmC4zD95sys4Vi+n3Mx+GzKOm5leiYCUi0wrVUaWgn/Gy9oXzLa5D4oA0okmzqioPPx6bysNj5PkwVYx+m/4faquDiq/vldxrs0BXA2BZRKhpyQuJE4ChqeEwYPIDervr9UeD+kg6eR2uSYkMAxSDcUdxkvZLJnkHGeRkY/oaslzpGdPByihElo7nL7CGM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8319.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18096099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?dZMxGa7iMwonPe9KEylgaJTG8i1HM8o+4wC8xveDZ4yu1N95kNs5on7zVtfY?=
 =?us-ascii?Q?32Ydm1m+28Q0VHpiMRqcAvIfmaaunyZjR/YGK3jyxGPVsl7vjgvpb5TKe4if?=
 =?us-ascii?Q?U8EPK8ZT199fMjaZ5vRV/bMY+HzyWa/ciryydtoyROY6OGaFTY6YWaZBSXkj?=
 =?us-ascii?Q?1t4uLxOx9zZaZCk2SYNvtnC2u3EYGSk6fZy0VF2phw9UXUY8AtGIKt0ieDg3?=
 =?us-ascii?Q?zGLWo581qNQUfaZHT9AVk3m320NWWU5pYxGOLHN/cX5yS28HwepivCYpktQ4?=
 =?us-ascii?Q?+OCCF3aHR8YF516X+arK4qY9hYb06ljhFxlh1JEIN+5FvXpcEcXLb/vMAa44?=
 =?us-ascii?Q?652uyVfTC0hemnqmozVYqUUNLeedmBIYyH831wivsSYRyqcfiq8sCpioGBeb?=
 =?us-ascii?Q?PuJ0K2LJNoRZpWZh47ODWU+CEVjlAFd4+BSqcSy98cM+E9lCGqzp2q2qj6Jy?=
 =?us-ascii?Q?NyJXrsWu2Zhlmd7s53UeFN5rUPGpcSZXkDSf/l89korQgneWN2Z+yz8u86JS?=
 =?us-ascii?Q?c+6FDOOvPIm3u88JFCDJO3aIJbOy2hsg16jmxvTDJLjnVJARQXWFl9Sho0iw?=
 =?us-ascii?Q?BNO3nVXf8xcsK+mTYCwOCiPHoU5WrZ8hzrcfiqZWXymOwZwjBxCSq3xl47rg?=
 =?us-ascii?Q?ny9FRY5/f3yGPK7Dfu7gd3Z0L7DAQz5NVZBqgaUMhbtnuik/TcpRttt+PAC4?=
 =?us-ascii?Q?LWKOxfmJWXjGndv+hRXv1VNaenedAqFSksph2oA3Kv+/gz08tu/x1q9793/G?=
 =?us-ascii?Q?rb4fTzdFLaxyzY3xQ8ua2llrNCmKmZxB1XTYLrw3BmO5vlRyltv/fzv5niJk?=
 =?us-ascii?Q?/qSBHZd3SS3iSjn2MQHvN+ird9FhZ6gscbFLLLdrCBCp/K8JngqgPBj2p9wg?=
 =?us-ascii?Q?PbK8ZbajW7k9/jUJl4xRD/pGXp2+nUMs2Lw/DIYeRTCFvqYrHImSHV611uIk?=
 =?us-ascii?Q?imXDsNCq36CxWO2hGvpZ0u5kwn0YHn4PITByYp0xoIUBJgLs7xGr/Iv7u6mE?=
 =?us-ascii?Q?YEjw2agiWKD6/kURWyagDnruQWNpp6A91xDuNOlk0s3iNDkyvIFevnXGmfSy?=
 =?us-ascii?Q?cxJCJHtgScYR9UW+zD68kAa7meADeCURju/umwHuQN6eVVA0qUj9j0j0Good?=
 =?us-ascii?Q?iNxCUBliZq8gl1wCznBPvy74xtayaDwGStfpU1BqLhhaVeS7Co2jbZDwpbLC?=
 =?us-ascii?Q?egPmZxs98CLGE4+1/320SRkoVFKyfn0f81iM3rFiiaPdEjsQA7DTjBKmAr2m?=
 =?us-ascii?Q?8V/ri/ezNMsET5CRj+E6Ghe/dyP4b0e5uUs6bVP/H6n8uB+Z+EzNeCKDNLrc?=
 =?us-ascii?Q?uy3KQfCycLrtoLK4zTmcbnLkrcH9J52hbmMz3vybvnLm72NSOYsYi0TXu8PR?=
 =?us-ascii?Q?V/gdWLIIGj6OMFnPqe3hh9xpzJqKps3xi/iBZPoW2o4+b+OwwiN2f0gXU2/h?=
 =?us-ascii?Q?v1+njBnP3g0D+JQ0dbaE4EwnmE5xAN+1WOHsHflXGDkvbBcPp+N7KEx900gi?=
 =?us-ascii?Q?i7UKdnO0JmhY44YBFBxoZd7osI/xX9RdJAkUMFpVZFvB4rAf0OlSCQ80i4+n?=
 =?us-ascii?Q?NWnGMYIAOhP1r6ErqsTMseomYSknzgTvjXSLbzXayzN7DHstAzJ6gawrF47e?=
 =?us-ascii?Q?F5wWDZ2PkIpO5PdGifxnHupz11CVCWor3dTdacMv8A1q7ODiy+Lva7A15Pd0?=
 =?us-ascii?Q?4iDD4JZGlngR6rfWQqboriaHl0Jk/bIDjsQYZT2ayeTJIMKoITw5DrjYRyaH?=
 =?us-ascii?Q?5pv3IElvyQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8319.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2c48f5-6ee7-446f-c486-08de9a16e441
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 11:13:44.2505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C74hlr4rpUED7TinxRZPJsnYkppILr6EG81ULx4I2hZG9Ldbval4x0bQ+0pAHOcuI6GeIMXXuh0TGlcr0umD+K5dnDblbNJ6ZBX3kY+LXbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12693
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Apr 2026 11:14:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22700

Hello Pavel,

> It seems I got this series twice. If there's any difference between them,=
 let me know.

That is because I sent it first without being registered to the cip-dev lis=
t and it did not show up on the archive site.
After I registered, and then sent it again.
They are the same patches.


> It would be also useful to know why this series is need.

Sorry for not including a cover letter.
There was important functionality missing from the MIPI-DSI display driver =
and also the clock driver.
Since everything is now accepted in mainline, I decided to backport to CIP.

Chris


