Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F166C021A4
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 23:26:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.8330.1739489180662609942
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Feb 2025 15:26:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=ryUmAgXP;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1739489153;x=1740698753;bh=x0
	JFWKA4thZ09Y6sHB0vnq8dbm/ra+thmSfnC9CIiMo=;b=ryUmAgXPeJaegRCgtxRC5gR3B/pKTjSw
	29h5iQhXzBf2NEidP/7xWn0Igc7fZ/ae6A5NLzp9LTAMIqL+UURWAZDb5nePo9F/r8w4jT9TKCY67
	z6cf6Ho9n/SkzXzc1me3eYv/8WQ9Ult/cqH4if/8W6/d7OBfM6/uxg5VeoDcEa50+uKYkgQaFrsl3
	7brdPnsX4splNdkAaZYa1w0okVYDamExHs8FtjdJEHiAUfwAlbLYaa4RZ8p9kswjrJuxBEiqilfeH
	iOEguWbY5EYy9r7xoI16C00036jgyrC+1t9FAA/DVK2lbp4aCNwoocJ9IDKPGxLv3QJtoZcYXbx6N
	4g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 51DNPqFa1264689; Fri, 14 Feb 2025 08:25:52 +0900
X-Iguazu-Qid: 2rWhyCKR4qD9Y8k6MA
X-Iguazu-QSIG: v=2; s=0; t=1739489152; q=2rWhyCKR4qD9Y8k6MA; m=LY/nWXVEeQHdOeqqp2u4MNQ/3t87Tt/hjNhwqjmpUXI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 51DNPoaG3344614
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 08:25:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzL1VSx3GZOd8evBUmLf9ULyiXjMfet8j7DtCBZLHrkYdzebxXKx9X30GJ5P8hZoymVfg881vE1GwMlANrlKkg1PjvdAK4WUgfvz5uI9YEW+T1uaoopgvypaVpZDLZgCMBUt7A8GIFhWPOQZJTcJjZZc4a0GR9lTbFXetjKCNGrmknZQz06bi1zAxHGRLa61KAjJW7ohQ4vR2aPy/JMBJnfUQDMZKpBxD3CHCRNyMIvK3C6VUaIqiRqBqvJOu1xowYNayJmatVSJxxz4qiwFCZnS0IbmppmKWZXTYWfWBGuOXuDmKdxqSefIIvwkIJWFE04HdmlSYCP5CLedWGjDfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2FVVEYEGIKoFxi949u5yBBYwwNWl8Hqy4j2UCgyobo=;
 b=n6WyWE7dgCGxmj5Zv6W9pXuVfeOd4zEdZq/ciLV9TKWevM4dMaI9+fHjSSQRi9ZQu8NtWF62qvag3B6G4fZ593EX0yPy8kOaCLbe95G2GFB1GK/Y5z0vOh1O4Yg2WJ4phloIF0J8q/HYYT7oaXvw49K07E4knJpy/GYoJ90QxqqxbhMYYuIEFQBcNvjeo7Q95ujIlfvx9VbdLXeJMM4Ms8j9WBaZcbFU3YWX1a1e6qdIMbxSqtLX3Lrjsh7kH67XToUFx5eEOpAkRE1i0woWRu2FKZWcR4mSRxJvKazKpn5AnJYLDvkEEXM+cVbLJ9odE8S2OLhe0dAtN00yQdxjFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v5.10.234-cip57
Thread-Topic: [ANNOUNCE] Release v5.10.234-cip57
Thread-Index: Adt+boZhdB4hJpW6SdyqgU8tDt7OHA==
Date: Thu, 13 Feb 2025 23:25:45 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388E2B35D5851C6682313CB92FF2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYYPR01MB8232:EE_
x-ms-office365-filtering-correlation-id: 09d3cd80-a4af-413c-d383-08dd4c85be12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?NDFFQ09nWitvZFRkNEQyMXZOZFMwMjJPR0p1OHlubSszeDU4d3p1QkQ4?=
 =?iso-2022-jp?B?eDMxYkd6cTVFaWtHWStYcFlzZzlhZ3duRk1PV3Z6dnFGVWJndjZuckZv?=
 =?iso-2022-jp?B?ZjRJcGJrenlqb3M0aDdZVmNqUGxPUEszVmMzSDNlZWVIeFFPdThMa05K?=
 =?iso-2022-jp?B?Vm5QUDBIT05KN3dpTnFQY3U2NXFydHhMNjhtT2MxVWtNZnY2SXU1Qk91?=
 =?iso-2022-jp?B?dlkxa3RuRm5qclBRRlEwZy8vdmZHQkpwL3htbE04YUlOWjluTnFHNkNy?=
 =?iso-2022-jp?B?dE4yaWcrMTY2cUc4am8rZEp6QnQyV0VuRFFJVnFnQ3h5OFlLcElmTkNF?=
 =?iso-2022-jp?B?cjRWNFNSd0FrWTJDNmVtQnJiaG5hRG8wT2trMjlHTytHUzgwcTFINEd3?=
 =?iso-2022-jp?B?bWhyWC9xSWNZTDRiRy9VWnNVVGRiVGNLWUN1Q3R1WngzNmphTkRyK2Jt?=
 =?iso-2022-jp?B?a0RVN1doSWxXT1hpbFQrd1lvQ0htY0dvYWVkTWJNTDFOUXZhZDNUM3dT?=
 =?iso-2022-jp?B?dnFSZXpmWXEwOGgwd2dueDIycHpScVhYNG1yOStqSzZySEZiRFhVcm9p?=
 =?iso-2022-jp?B?WTFyTWlvaVlIb09COWhyM005SldhRVdXbUJPSGpjTEVkbGptUHJVZ3B4?=
 =?iso-2022-jp?B?MVAvcDZLbzNvNjloOUdZUVZ0Q1VtQStkTFpPcjN6aXhCTXdYWWxuSlBU?=
 =?iso-2022-jp?B?RFdYUW0rTDFJbTk3dWhsb21NUEE2OXZVcys3RkZUYU1veTB6MHdabnhu?=
 =?iso-2022-jp?B?eWR6dm1OdmxKRThMaHNlV2V4c29vVGZkbWZQSXNCVC9QNW9tdzh3bW1u?=
 =?iso-2022-jp?B?MER0ZjVTVzZPK1VZSEJibGdVclp6TjNNTTRyY2p6akNocldMeGR3ZFoz?=
 =?iso-2022-jp?B?SWo1S0tOK1FLaC9pSEFYNkE5OUI0ZTR0eFBlY3FQWDlFRjNoanJ1bmdK?=
 =?iso-2022-jp?B?dkVwSG1JQ1JiYzVrNlkxWlVFT3FpK1BuOXdTUXZxWGxhSVFXa1BmYjNV?=
 =?iso-2022-jp?B?NU9qbXR5c2t2VFNhaWdKMlZTdjFPVU5xZkQzTXNjR0dTQWhIemJLVHpn?=
 =?iso-2022-jp?B?aXZmK1V3UXVWOFJaWStNSWloK3FaWWx1cEZNdmFMeTZUdUVrNU92N29B?=
 =?iso-2022-jp?B?UklJeno3ajliVHpyTDNxOHF3YmJXdGQ4aFdiQ0RKc094dDhwa2RnRGRt?=
 =?iso-2022-jp?B?SnRsa3JJblJKdW84bDQ3OUk0TDRxTk5jdFFiUUc5M1NWUko4QVVxcWs4?=
 =?iso-2022-jp?B?TTBnTjJyT0VYY1QvUGk2RVladERkOTNvZDdla2pSRlI3b2dscXE5V2lv?=
 =?iso-2022-jp?B?Q2V5OHFWaVRzWVB1L294SDBSYW1qS0ZIZTRFc0czTTBKNXpuV25CL0tJ?=
 =?iso-2022-jp?B?TjRsWkM3WXpOeDROMU9Ud1RXWWlPMmEwRGRCMGFUakZOVk00MWRvZHkz?=
 =?iso-2022-jp?B?QzBJZHRkcDZTeFhDK3F2bmJBRGsyTTg2d2FUcWdzSW5MNkNUYURZOVpt?=
 =?iso-2022-jp?B?VWVGVnRjRW9LYytPZk5BaTU4VER2L01xcnliTTJlTDlzYmdiZDRmVlox?=
 =?iso-2022-jp?B?OGNLRU8zSVNKbDRMdzFOSzJRRENLOUFHY1hGWkE4TGVjcm9Nby9OejFD?=
 =?iso-2022-jp?B?RWppQm1CWWFWODBmcXhQdkFPaFkzaXFGSVNlMm5uQWxRREtncG1TdWU4?=
 =?iso-2022-jp?B?LzNjRUk0cHhvak5JRnVvMmJsUnFEOWZjbVE5WWVPRzJ5SVY3WWxMdUNR?=
 =?iso-2022-jp?B?SUdVYzJjOVF3UWlmempERks2blM0WURDTjZ3Y0RUTW9tK1ZxQTlYQ3hp?=
 =?iso-2022-jp?B?REUwZExUOVpoY3lwakI3c0YyT2YwSnFXUlZacmpJb3lDUldOM050MFRX?=
 =?iso-2022-jp?B?ZGJ2NU94dkFINk1zR2d3ZkVtWm5xTldlNHR0ajNkbENobnlHaHlnOXRq?=
 =?iso-2022-jp?B?SFFWa2VRNERhWXNLY3dnU21naytYRDlIcUV5RlZTMHNzRGZRUnBPR0gr?=
 =?iso-2022-jp?B?UjBSdERnUnM1Q3lhLzVBUWJWQXZYNXNBYkJyWmlkeWVQZFVEcWgxR0Vv?=
 =?iso-2022-jp?B?WGQyZWdweG9FZHRWRG5SeDlXRWpyaE1wdjVKSFE3ZVozVEdjY3c4NTJh?=
 =?iso-2022-jp?B?TDkvbytwOUpxQUVJUkF6VmJmaVRNVnNnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Nnd4eGtEM2NWaVRJSG90UnpJeDRMT1lsMzhOMS8zemJndURHaVBGUVVx?=
 =?iso-2022-jp?B?NEFsMm9ESXhIa3pkZ1AyK1ZqYzlmM2s1VndQRFYxU2JmbXdvRWRhTmow?=
 =?iso-2022-jp?B?bHBGLzkvWVF1blljQndZbGdFVlNCbytuU3VsVmFKMFoxR0g2aUJGeWhp?=
 =?iso-2022-jp?B?SFZ4SEExVkNVOE1YT1hjbUZ3Y1RmNDFiY3hTbjFOTTg5Tm9LbDRDZmtJ?=
 =?iso-2022-jp?B?YlY1K3BZR2JQVTlRcmJGYTcvMkFYWnBlR1NUdXBBMlYxUks0ZjNkMHk0?=
 =?iso-2022-jp?B?QnJvNjB1U1lDS2xZTVBBc3ZEbHIyV1pVVksxTXJEWUFJYzE0alpXbC9V?=
 =?iso-2022-jp?B?ZVppcXhDZFZuNmVXWEM5NnN5cEdiRC9YMXdCaWw5VlFpeFFyc2dUQXlj?=
 =?iso-2022-jp?B?TVJzdkVLdVZnQXNkamFVYmFJR05jdzdMSW1mV1R0MTVlTmVuK1hYRGNk?=
 =?iso-2022-jp?B?c0QrY1RWTVJoM0kzcVBiejJxQjJ2VW5KaVN2RnpOYTZ0SEhDM3ZTajht?=
 =?iso-2022-jp?B?MU8rTStIaTczcVRmcU5FWnhLMkMrdkdWQ20xb2JaNk81L3Q0RExoMnc4?=
 =?iso-2022-jp?B?RzhVWDVmUEVhOFRqQTZObnlLV015YUNUSDlLOEJoVGFXWmFuckZvdEFU?=
 =?iso-2022-jp?B?V2NPemVsakltcmVRSU42K1NwMWJqZW02bXpPV1JwUTBWKzN5cmlSWWF2?=
 =?iso-2022-jp?B?bjcyUmd3V0hKWXNlYm5Yc1VWOU5iUWxOaVV5ZW5rem1OdUIxWWMyT3V0?=
 =?iso-2022-jp?B?aGYwZys4Mm42ZjEveHZQc1dvZ2pEdlBaS0FMbVBRelJkc0xuSzQwdmlV?=
 =?iso-2022-jp?B?MEF1ZWJhVCtUNitPK0tkbzA1a3VzWWNaT1pxT092M0xnQ0pOQWtyRks4?=
 =?iso-2022-jp?B?OWtFUGJQUDVMSmZsT05Vd1hIdlVrSjFzVEtMS1Rqb3pWZVRMTjFEZEx3?=
 =?iso-2022-jp?B?eGlPVkxtd2ZPY2NJbWQ5Y01rK0FxRVBnV2hqTmtKdDhQelFYOFJ3N1pH?=
 =?iso-2022-jp?B?K2JiazBXZ3VmVjVuWXY3TFpua29tdU1DUzBWZEtjZGdCM2Jja252VVp2?=
 =?iso-2022-jp?B?cU9maThvU2U5N2lveER1SU1oQnNuRXRxRFVCMWJNbTUyeDJnU3RwZnJI?=
 =?iso-2022-jp?B?NUJFQUxkNDhUd01rdVUyQm1vZEhIQ0w0czdtbk1sRnhVZW9KNUxzeUxL?=
 =?iso-2022-jp?B?SW9HYXJwUnkwTlByUzhsVG15T1ZndndadlEzcjU3MTlSSFRJMXA3Z0NJ?=
 =?iso-2022-jp?B?THgzU2pNVTE3Q3dkZzU2MlFNYnRiVmhYZTZia1pkUHRtdENNU0dBUTF6?=
 =?iso-2022-jp?B?N01aK1JlUit1c2FtVlJXc3NFWTZiT3NybGFnekJ1Y091emxITThqeGI4?=
 =?iso-2022-jp?B?UWV6TVdGUEQxUFNnZjJqeGlDNVZwYkhibjR5ajdBMVpzMVRrd2Yxby9B?=
 =?iso-2022-jp?B?TjdYSmpKKzZMQXB1aDRLMWpSQzVQV1FBbTViZmdqSFQyYVI5aGloMlYw?=
 =?iso-2022-jp?B?OW1KaE53N2g4UDVqSXFsT1R4Q01RdTdIWlBpNHZFSENsODlMKzZSeUdE?=
 =?iso-2022-jp?B?NDF4NVdqMmF3VFMyT3loUkdtTUxCUHZFUCtuTTZ5cGt2ZlVudE5TY1Zi?=
 =?iso-2022-jp?B?T25qZXhza0J6UGhhNFB5cmkyamlwVlE1YWQ3NXo1NVhEMWZwclBCWjBk?=
 =?iso-2022-jp?B?YkIvQkZEZDJDOFRUcXFMYjFQNlBzTUpsTVA5VXp5R0t0WDBPNlFQTDJ4?=
 =?iso-2022-jp?B?UFFjRmZtSVJ3ZFZsZmRCV3pOeHhhVHBuVENNTjFocHpLVEJSNlJNREdw?=
 =?iso-2022-jp?B?MWJyOTI4TXd4VjJVNUZSS0hURDZLSGYzaFBkdnk2dGh6RjhlTmhLRHd5?=
 =?iso-2022-jp?B?L1BRamRINm1NVU5YM3lUZlRpVDdaQllrcVpqTDVaTCtvTVFyUVp0dHI2?=
 =?iso-2022-jp?B?UVBYZUpMMFJ3WGYzOHhLVm5yaGtldUFJbEdsbWVzYTFpdk9KY2VLVnRw?=
 =?iso-2022-jp?B?bzhXSjVrKzRZcWR0VnpsUlZLVlNFVVBoamFCcmlONGpXRGVMaE00ZkpU?=
 =?iso-2022-jp?B?aVVSZ3RmbUkvNlVqMXNuRWFXUXBrOFVJZlFZa0plU0ZnbStscTAxR2I0?=
 =?iso-2022-jp?B?WXp3L0pML1I4bGZtd1JYVFZGK2JUbW9YcldwRGNyT1VhaVpuUklBQXU1?=
 =?iso-2022-jp?B?QjREYm1KMGJZMjFjVEpEbVpmZks5WU9qUjhuVXdJV045eXN6TTZQZU5B?=
 =?iso-2022-jp?B?RDd3TXZFK3QrMStLN0ZjSjJ2ZytsVWNlMmhsZFBndERLajFncVJaUWFO?=
 =?iso-2022-jp?B?SVUwN0RvMmloQnlZQUprb0tlV3orSHVtZGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d3cd80-a4af-413c-d383-08dd4c85be12
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 23:25:45.9708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gCe3zKCu/oavpUk9TmvdBhXEtBG994CmeQ9Y4YxIaFbpsA+ENEFMkE+/MFDJdn8JeaeRYb8K7MNDTaE0vTW/USbZTj6l5Eaoc4vuka1cbQDzxPG8rEg1Wx3Z2VjxQVPK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8232
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Feb 2025 23:26:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17833

Hi,

CIP kernel team has released Linux kernel v5.10.234-cip57.
The linux-5.10.y-cip tree has been updated base version from v5.10.233 to v=
5.10.234.
This release also adds the rtca-3 RTC driver for Renesas arm64 SoCs.

You can get this release via the git tree at:

  v5.10.234-cip57:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      f9ff2e9e3f65a5e6d7480becf629532229ef463d
    fixed CVEs:
      CVE-2025-21664: dm thin: make get_first_thin use rcu-safe list first =
function
      CVE-2025-21646: afs: Fix the maximum cell name length
      CVE-2025-21697: drm/v3d: Ensure job pointer is set to NULL after job =
completion
      CVE-2024-23307: Integer Overflow bug was found md/raid/raid5 modules
      CVE-2025-21692: net: sched: fix ets qdisc OOB Indexing
      CVE-2024-57908: iio: imu: kmx61: fix information leak in triggered bu=
ffer
      CVE-2025-21666: vsock: prevent null-ptr-deref in vsock_*[has_data|has=
_space]
      CVE-2024-57887: drm: adv7511: Fix use-after-free in adv7533_attach_ds=
i()
      CVE-2024-36899: gpiolib: cdev: Fix use after free in lineinfo_changed=
_notify
      CVE-2024-57906: iio: adc: ti-ads8688: fix information leak in trigger=
ed buffer
      CVE-2024-57951: hrtimers: Handle CPU state correctly on hotplug
      CVE-2024-57939: riscv: Fix sleeping in invalid context in die()
      CVE-2025-21639: sctp: sysctl: rto_min/max: avoid using current->nspro=
xy
      CVE-2025-21694: fs/proc: fix softlockup in __read_vmcore (part 2)
      CVE-2024-57907: iio: adc: rockchip_saradc: fix information leak in tr=
iggered buffer
      CVE-2025-21688: drm/v3d: Assign job pointer to NULL before signaling =
the fence
      CVE-2024-53124: net: fix data-races around sk->sk_forward_alloc
      CVE-2024-50304: ipv4: ip_tunnel: Fix suspicious RCU usage warning in =
ip_tunnel_find()
      CVE-2024-56631: scsi: sg: Fix slab-use-after-free read in sg_release(=
)
      CVE-2024-57912: iio: pressure: zpa2326: fix information leak in trigg=
ered buffer
      CVE-2024-56672: blk-cgroup: Fix UAF in blkcg_unpin_online()
      CVE-2024-57911: iio: dummy: iio_simply_dummy_buffer: fix information =
leak in triggered buffer
      CVE-2024-57910: iio: light: vcnl4035: fix information leak in trigger=
ed buffer
      CVE-2025-21648: netfilter: conntrack: clamp maximum hashtable size to=
 INT_MAX
      CVE-2024-57904: iio: adc: at91: call input_free_device() on allocated=
 iio_dev
      CVE-2025-21698: Revert "usb: gadget: u_serial: Disable ep before sett=
ing port to null to fix the crash caused by port being null"
      CVE-2024-57929: dm array: fix releasing a faulty array block twice in=
 dm_array_cursor_end
      CVE-2025-21683: bpf: Fix bpf_sk_select_reuseport() memory leak
      CVE-2024-57948: mac802154: check local interfaces before deleting sda=
ta list
      CVE-2024-57940: exfat: fix the infinite loop in exfat_readdir()
      CVE-2024-47707: ipv6: avoid possible NULL deref in rt6_uncached_list_=
flush_dev()
      CVE-2025-21653: net_sched: cls_flow: validate TCA_FLOW_RSHIFT attribu=
te
      CVE-2024-35966: Bluetooth: RFCOMM: Fix not validating setsockopt user=
 input
      CVE-2025-21669: vsock/virtio: discard packets if the transport change=
s
      CVE-2024-53685: ceph: give up on paths longer than PATH_MAX
      CVE-2025-21687: vfio/platform: check the bounds of read/write syscall=
s
      CVE-2025-21638: sctp: sysctl: auth_enable: avoid using current->nspro=
xy
      CVE-2024-44940: fou: remove warn in gue_gro_receive on unsupported pr=
otocol
      CVE-2024-57915: usb: gadget: u_serial: Disable ep before setting port=
 to null to fix the crash caused by port being null
      CVE-2024-57922: drm/amd/display: Add check for granularity in dml cei=
l/floor helpers
      CVE-2025-21689: USB: serial: quatech2: fix null-ptr-deref in qt2_proc=
ess_read_urb()
      CVE-2025-21699: gfs2: Truncate address space when flipping GFS2_DIF_J=
DATA flag
      CVE-2024-38591: RDMA/hns: Fix deadlock on SRQ async events.
      CVE-2024-57892: ocfs2: fix slab-use-after-free due to dangling pointe=
r dqi_priv
      CVE-2024-57913: usb: gadget: f_fs: Remove WARN_ON in functionfs_bind
      CVE-2025-21640: sctp: sysctl: cookie_hmac_alg: avoid using current->n=
sproxy
      CVE-2024-41060: drm/radeon: check bo_va->bo is non-NULL before using =
it
      CVE-2025-21678: gtp: Destroy device along with udp socket's netns dis=
mantle.
    added commits:
      CIP: Bump version suffix to -cip57 after merge from stable
      arm64: defconfig: Enable VBATTB clock and Renesas RTCA-3
      arm64: dts: renesas: rzg3s-smarc-som: Enable RTC
      arm64: dts: renesas: r9a08g045: Add RTC node
      arm64: dts: renesas: rzg3s-smarc-som: Enable VBATTB
      arm64: dts: renesas: r9a08g045: Add VBATTB node
      rtc: renesas-rtca3: Fix compilation error on RISC-V
      rtc: renesas-rtca3: Add driver for RTCA-3 available on Renesas RZ/G3S=
 SoC
      dt-bindings: rtc: renesas,rzg3s-rtc: Document the Renesas RTCA-3 IP
      clk: renesas: r9a08g045: Add clock, reset and power domain support fo=
r the VBATTB IP
      clk: renesas: vbattb: Add VBATTB clock driver
      dt-bindings: clock: renesas,r9a08g045-vbattb: Document VBATTB
      clk: mux: Introduce devm_clk_hw_register_mux_parent_hws()
      clk: Add devm_clk_hw_register_gate_parent_hw()
      clk: gate: Add devm_clk_hw_register_gate()
      clk: fixed-factor: add fwname-based constructor functions
      clk: Add devm_clk_hw_register_gate_parent_data()

Best regards,
   Nobuhiro



