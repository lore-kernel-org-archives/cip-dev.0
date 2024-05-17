Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D716C25B74
	for <webhook@archiver.kernel.org>; Fri, 17 May 2024 02:47:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.31420.1715914037854893892
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 May 2024 19:47:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 44H2lFA3009775; Fri, 17 May 2024 11:47:15 +0900
X-Iguazu-Qid: 2yAbxjwjvlORGxbhT9
X-Iguazu-QSIG: v=2; s=0; t=1715914035; q=2yAbxjwjvlORGxbhT9; m=VwO/9T8kX+x1KicZ2tHBYPNwooS6fZdOBlSESQUnB+Y=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 44H2lEjY051309
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 17 May 2024 11:47:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4pZC4OnfTi6d5Ic4OXF/5SK9xNmb+CAoXELgO4t5BlIZvCnYbvxcCFciTJB7F1DwF80PlvtFAzwyY49CFB6Sh3AMWesqUbNoy1beF4lnbdJhfLsmFGw1tTGlWCNAslxvLqQtMqPGcSSUP9pZuAQLLKI88WSu1LrE7b7ea/AOqIeivlQCEy7KIeUu8WnOSPqG4R5rHUUiliaqY4OOO56TxsJNV/aZpVO7NHMTS9QC+LsqLJgYiTTm+K51R1SX1IDsqzNylEVPTLpCKcNTKaPOAXB05TmSEPltrMYfdOoKPyCUjNaZ+000PwulcFFM7aI6MG+7DLLTIlcJv0bH6DlzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PteOSxbMOLENp/t70ouiIrReajPNC4i3B0MyJHC3xHQ=;
 b=J93MN7Sv39fDLkRVzPSaPWofiS64pDr7iXb8fH1Yl2QJ7ihNGoCSmGVHNRkxSjX51Bf3CZeDClAbyqB7wmMfSRxx4RULeEiIrntfe/O9UAqekH+iADzvxU5swI/ixj/E2ZG/6VupYsZvWGNppaGS67hg0/ItSxmxQ3gUQnfdZFm6FNmwG+aVCEHIwyCuiHlWGlwdVXhOlfXM8RQTfgo49TC0bko8VRDoPTvdtABKAFtxf3ap1Q9PrIOfOWAfKCLx+d/tYgeEmiOtWxLM5pIqAet6E1vTmqdLxm5JlbJzjGe6YJ0YfrDCR71aQAUsaibQyAx7oF3D27aE6NLEcboAIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: Preparing test evidences for CIP Core packages for IEC 62443-4-x
 assessment
Thread-Topic: Preparing test evidences for CIP Core packages for IEC 62443-4-x
 assessment
Thread-Index: AdqngyKNF2gl+sOgQmW8Zvoy0bqzgAAfUtvA
Date: Fri, 17 May 2024 02:47:11 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB113852C6B7DC0548305FB8A0DE1EE2@TYCPR01MB11385.jpnprd01.prod.outlook.com>
References: 
 <TYCPR01MB9669D37EC2865C6595EFD118C4ED2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYCPR01MB9669D37EC2865C6595EFD118C4ED2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|TYYPR01MB12288:EE_
x-ms-office365-filtering-correlation-id: 32624e8a-81b6-42c2-3de3-08dc761ba692
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|366007|1800799015|38070700009|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?anJwR2p2ei9PU1dwd2F4Znp4ZHRmdkFVbnJNYmhZelJNOXN0ZjV4TmxF?=
 =?iso-2022-jp?B?cDl2dHNURDN6L1ZFMVJPTFlSNklPWStQZ0tBMjdrTTkreVREakRoNnNR?=
 =?iso-2022-jp?B?c2NRWmd0TmdhZFZhdHBUUVpYSHJHRW0rVHZuTVdOSkpmNlUvdi84b2Vl?=
 =?iso-2022-jp?B?cllYWTFoOGVUZWZGUW00NW5acFh3Q1Y3SXJldkdqQklqK1BtQ1lZTit5?=
 =?iso-2022-jp?B?blZXN3dWRkdEV3puMUdRanh4bk9PZnVDeTllUVdQc28zU3drMWYvWmhu?=
 =?iso-2022-jp?B?VTFxdWxCbWxtUEtQR09ZY0dHUm1Ob3QxNjNja2I5QTljazdRbnNUUUpi?=
 =?iso-2022-jp?B?YXA1UjNNYTYvV0ZabGxLV24rYlNxY1o3NVN2WnlwN1kvMThicDRFV2da?=
 =?iso-2022-jp?B?Vk43K09TMFBtSlFKM3lpSkY0R2JUTFRadGlIZHp5R1pkRWx3cWkyaDYw?=
 =?iso-2022-jp?B?Mzc2UEpFMDJJVXFqQzd3cFNMSkZNUzIzd2tGQlNBcVplTnhTQUR6MHpS?=
 =?iso-2022-jp?B?RjNyOHhDMjM5Z0ZaOWFkRDhYOWhoVm1jK3UvUG5tV0JjYmYrNWtlZEN6?=
 =?iso-2022-jp?B?eDAwZENJSEZjK3h2VTB3TzRQTFFQZ0kwaU51TUtDUnFSRkUvMlllM0wv?=
 =?iso-2022-jp?B?T0NQUXJrNm13S0pIRXpIU1hjU1ZoVnBXZ2IyZDJ6d3RDQkwwYnQ0UEda?=
 =?iso-2022-jp?B?cnZJU2dVVHl1aWtNR3dvRGJoWWd2UnkwdnVUZ2YrR2dYSVR2aWRESFI0?=
 =?iso-2022-jp?B?OVoyckFpYjRaeVg2RTA0ZVdNcG5CS1ptV3hrSUgzbjFFZHQwMnNHQUJT?=
 =?iso-2022-jp?B?QkRrdzZRY3Q0L1krTnFwSkdvd2djSzdlNzlKUWZrSitVMlZnWVptSWI0?=
 =?iso-2022-jp?B?anVNbWdhK1RKczg2cUIyS3d5L2JEc0hQd3pJZks2V2FIVHQ4ZFdtbmhn?=
 =?iso-2022-jp?B?eGNDRm10ZCtXMnNyYlEyWFVsN2lzSXloWjVXL1VGQmhkcExYdHRzcXRi?=
 =?iso-2022-jp?B?VFRUQXJxRDVpRnhIQnR5aFJ2ZHhIWFhXTG9Vd1FKcTJJKytMd28vay9a?=
 =?iso-2022-jp?B?U25TMURqTjBMS2Q2elZCWGZGQlBuU0ZYUTlUNmkvSUhwL0E1eGRrNWJu?=
 =?iso-2022-jp?B?L3NRUlU2Z1F3amwxVG5xT1k3UHVlSTQwbFcweFp6b2NpeG9VZkdEV3Y1?=
 =?iso-2022-jp?B?cDNVVmxHUWxFTG1DKy9ydURLMjhNUDY2c0VWdllMSWpVQndmc1NMSDVE?=
 =?iso-2022-jp?B?L0VGM0ZmNFo5WkIyWmpvekNKS3UydktDeFhxOUc5TVpaNjJlZC84YTRv?=
 =?iso-2022-jp?B?Qzd6VWk2THlhejVKVTFVd1pTSWVrZ1M4a2UvN0MzSDMxUkc0WnBQL0gz?=
 =?iso-2022-jp?B?cnhvT2l5UFgxZDdnRGVITkM5bmVMdENTOElJRHVqSVNGb05hbkNlOFFm?=
 =?iso-2022-jp?B?WjdOaVdUeEZsM2xqUU5TVTBXSEpZZm5BOUl2ZGlYRlFITEJHQnhGMmFN?=
 =?iso-2022-jp?B?bGNyTjVsM2ZpNVNrK3dXRSt3bG1mVk5ZSmdmb0VhcE4xVmFybVpMTGxr?=
 =?iso-2022-jp?B?ZHoxc3hTZC84Rng5UzB6eFB2QU9iTXlvYmJtSmlKNGduNWtQSnZlTkE2?=
 =?iso-2022-jp?B?dlhxQWRidXdrTUNnNFN0RHdqM1pQNmVFdUl2b3VCUkZGWlk2dU5Lby9h?=
 =?iso-2022-jp?B?bEpwRmhmaFJnYXl1M2l1aUY0SFdWUE90MTIxanFtc2wzYkRuMGV0dWJW?=
 =?iso-2022-jp?B?QXVRRWprbkF6NGdndWZWY0pwNXJBTXBndmRyYm01Y3I2cWxZOVg0VVNk?=
 =?iso-2022-jp?B?VFprU3UvNGlrbGhncVg1cWxON1VZNGhPdkUzZVRNU2FXMEJ4WjJaWWVi?=
 =?iso-2022-jp?B?d2tNWVdyU2t3NEhWVml1K0VlQmNqVGo3WjVSTkZibXF3MWFKSmkxOHlS?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YWtZZm9CMzJ3c0YyRm9hWC9ZV0tYWXNhQnprOCtzcmx2cVNRdXp2ZUFw?=
 =?iso-2022-jp?B?TVE4QjNBeDRhT3BRMHBGdU9UZmdwVk9DS3dITTFrSHlsYjJEQzJCVWZH?=
 =?iso-2022-jp?B?UlVrYnlWTThrRDBQbENSQ2dsYWIxRlhBc1k4SURmdnlRMmZ4azZzcFVT?=
 =?iso-2022-jp?B?cElobWJnV21XUVJsWHBVLzZQVU5FWmhrUXhaZ0I2a3hxbUZoVXVhV1di?=
 =?iso-2022-jp?B?RlprZVpvUXpoSnh3NkdGdnlaRzFaVUI4R1FyUGxzbmpDL1kzRDVQQTY3?=
 =?iso-2022-jp?B?RG5FSFRZUHlzNUZ1NkhWNllqMDVPTThNWXpxUFZIN2tmMElaajgxMEFh?=
 =?iso-2022-jp?B?QWRzYjlaNkw4WWtGckNiRXpBSmtvQW5RamNOTG1URjVaWWdTTXEyakR1?=
 =?iso-2022-jp?B?azVrN3BVNmEwcFY3c1U0VkFaSTg3dTE0aEFuYkp6SG54MUZDd1pnVFRX?=
 =?iso-2022-jp?B?cmNEYjRoMDVqVENYMkU3dEVVenlDemNqNVZmVXBIdnhpL0ltSS9xaHc3?=
 =?iso-2022-jp?B?bXpmeVRQRk4rVmorY2NoU01LUUppSjBjUUp1UGNGTUJNRFJhV3F2L3Nq?=
 =?iso-2022-jp?B?aFpYL1VuNWliVmZSMk81Z1JMOVR0WCtPTURkNmFoQ25GMGJqVW9sRU04?=
 =?iso-2022-jp?B?T2Y4YlBVY2pVWU9JRG9CQmdOY01uNWRHS28rd0VSOWpBQ082UGxnbGEx?=
 =?iso-2022-jp?B?UGMyUjAxOVkyVXkwRHU1K09UK2I3VUZaeUZmdDJXd2ZTYjVGNm01aFhp?=
 =?iso-2022-jp?B?dHRaOTNJZ0VYRGlaK3psdXNtMXZTUUhKZ3M3dVVmNVJXUnpWOFFxcE1v?=
 =?iso-2022-jp?B?YW5RMlBIYXRBOSsrNEUxbDVuUVBGZy9OenJIRFNtMVlXa2ExZTEvdHJz?=
 =?iso-2022-jp?B?enk4T1VzZjdIWlVNV0ZKbkJkdGs2UGZNUWVFV3REcTMzOTBaUmdpbWlG?=
 =?iso-2022-jp?B?OC9BcW1xMFRFVmtTaUh5K2Y2NlgxcnEvMHlldWd6Vi94NGhkVExlNzdD?=
 =?iso-2022-jp?B?eERaVkpZNThEY2Q5Y3NYUWtkdXA3TThUb3p5TXN1ZW15eFF0ZnV4NGJB?=
 =?iso-2022-jp?B?enlqS0xKUVJneEwydmxSSlZncy95dFgwRXVzelBncUdpcVpRekVweVBv?=
 =?iso-2022-jp?B?TTk0MXJYdk1TcEU5cHJrWXhRTHJzdU03QVJtNld4ZWZZMnpMUFB4ZEdj?=
 =?iso-2022-jp?B?UzUrV1hTVEkrU0U1SzZaWXBXRVlZVjhMR0tWRm1XcE4wVzNsZmdRNFo0?=
 =?iso-2022-jp?B?aERoQzgwMzJnYUllMUVxV3E0OWlwZUMrd3RqQWpIb2cxZUhGSEtlQXdY?=
 =?iso-2022-jp?B?NlhsRVpZdUt2QUJkUDhiYzBqNlF5SHRvRVhlWXh3cFV2Q0hvaGxwWFVY?=
 =?iso-2022-jp?B?S0krUjZiNU1CanRMVWZta1hLVFlWZHpLdFA0Ri9iWlNuMml5QjVLVkIy?=
 =?iso-2022-jp?B?WUVwZXd1K0dPWWIzMEFNendBV2x0YnNqbzhUOUJuUUxwRUlLUm41MWs5?=
 =?iso-2022-jp?B?aHVXMkNINk55andoS1NPRkhsVkNVZmJJSG41YisrK2Uxb2tHbWl1M2hw?=
 =?iso-2022-jp?B?V1IvRlp6UDlQRGluNzZqZW1oVTExYTZVZkFYN05HZ0NlQkZMbmo3VThK?=
 =?iso-2022-jp?B?VmNjYWMxdmxZYXNMTWY1MHgvd052R2FSWWFCcCt5M3lmY3I1SENVVlpH?=
 =?iso-2022-jp?B?QUdnWGpKRDBFVnRWbTJUcWZKSzV4MWxpdEZ2U2lZNmk1UGZqSXB4a29D?=
 =?iso-2022-jp?B?ME94MWxMYitvRFRmOGVuUG9uYy90SXkrdi9aNFpPa0VYZ2pGK2tpSkxY?=
 =?iso-2022-jp?B?c3BaaXk5eTIrNDdhcFRYcUczbURvM0VkNjN4dEFnTnlUMm9NZnVRQTZ3?=
 =?iso-2022-jp?B?SjU0QTdOUm41WVdYeitaRjV2OXdTaWs4Y0lPZkptTmpUNHoxWmJqYnJB?=
 =?iso-2022-jp?B?eU55VjM0SXh4NjFnRnNQdXdLbVA0RFJiZVBtSDJYd0dhcnUrSDU1Mzha?=
 =?iso-2022-jp?B?eU9zQW9iOFBJYVRNYzR0REdEZ2J4NTA2cnR6QS8wVGtvWjhYNmZTTnZp?=
 =?iso-2022-jp?B?UHMrYnZPWW5BLzJBcmg3aTBYK1B0eFFRbEVJUDZLWngwMlVBaTAxYzVj?=
 =?iso-2022-jp?B?TUY3TUtaaVF1N3Z3RVhoekdPaTZQTHlBcFdid1UwWWhNajJkWjZhbUtn?=
 =?iso-2022-jp?B?SE5LcEdldlQ5bkpUZks1aTcyai9BeHJFQXYxbFNxVXZBNlE4aWVUWWZL?=
 =?iso-2022-jp?B?NTNPK1pHQmtkTzJTSjZWREdHTS9NOHVXemgrb2NSazYvait1OWQwY1N1?=
 =?iso-2022-jp?B?ZXA3L1ZFQmFNNEFkTm81QVZwOHdFMEFna0E9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB113852C6B7DC0548305FB8A0DE1EE2TYCPR01MB11385jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32624e8a-81b6-42c2-3de3-08dc761ba692
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 02:47:11.0515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hYEN7gohOGK0rl3CK5Q2jhQ5V9DppUAOdLtTPmoivZopSfnTNiO+1xnfYj1497WaeYCXoYChBU50M3YVxrYbWyyrK4wjSlptMMOLmo3VECDymHmeBJM15PHW2ysylcU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12288
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 May 2024 02:47:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15908

--_000_TYCPR01MB113852C6B7DC0548305FB8A0DE1EE2TYCPR01MB11385jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Adithya,

> We would like to understand your opinion on the next steps to take or oth=
er distributions to target for tests for the above listed packages.

It=1B$B!G=1B(Bs better to define what should be tested from IEC perspective=
.
e.g. python3 does not provide any functions and just for controlling other =
packages (like a meta package).
See the package description and contained files: https://packages.debian.or=
g/bookworm/python3
No need to prepare any tests for such package at all (at least for OS secur=
ity).

Some packages like base-files only contain data, which may be hard to test =
without concrete methods to use them.

Best regards,
Kazu

From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Adithya Balakumar
Sent: Thursday, May 16, 2024 8:40 PM
To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I#T=
!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
Subject: [cip-dev] Preparing test evidences for CIP Core packages for IEC 6=
2443-4-x assessment

Hello Iwamatsu-san,

Hope this message finds you well.

We at the CIP Security Workgroup have been working to collect test evidence=
s for CIP Core packages included in CIP Security image as part of IEC 62443=
-4-x assessment.

To summarize the work done by CIP SWG so far, CIP SWG investigated the numb=
er of packages in CIP Security image and tried to understand the number of =
packages that have test results available in debian and number of packages =
for which we have to run the tests ourselves and provide the results. I am =
including the summary of the packages below:


  *   Total packages in CIP Security image - 242


  *   Custom CIP packages (from isar-cip-core recipes) - 13

     *   These packages are created by recipes in isar-cip-core or isar tha=
t are deployed into image as a .deb file.


  *   Packages with Debian CI autopkgtest - 140

     *   97 packages with functional tests, 41 packages with non-functional=
 tests, 2 packages with no tests running in debian CI


  *   Packages without tests in Debian CI - 89

     *   70 packages have tests available either in debian salsa or upstrea=
m.


  *   Packages without tests in upstream as well - 19

There are a few packages that do not have tests defined in either debian sa=
lsa or upstream. I am listing the packages that do not have tests defined i=
n either debian salsa or upstream below:

Binary Package name
Source package name
Are there Debian CI results ?
Are upstream tests available
Remarks
base-files
base-files
NO
NO

base-passwd
base-passwd
NO
NO

hostname
hostname
NO
NO

libmnl0
libmnl
NO
NO

libnsl2
libnsl
NO
NO

libpam-passwdqc
passwdqc
NO
NO

libpam-pkcs11
pam-pkcs11
NO
NO

libpasswdqc1
passwdqc
NO
NO

libpython3-stdlib
python3-defaults
NO
NO

libreadline8
readline
NO
NO

librtmp1
rtmpdump
NO
NO

linux-base
linux-base
NO
NO

media-types
media-types
NO
NO

net-tools
net-tools
NO
NO
Few functional tests in ubuntu: https://git.launchpad.net/ubuntu/+source/ne=
t-tools/tree/debian/tests
Autopkgtest running in Ubuntu CI https://autopkgtest.ubuntu.com/packages/ne=
t-tools<https://git.launchpad.net/ubuntu/+source/net-tools/tree/debian/test=
s>
python3
python3-defaults
NO
NO

python3-minimal
python3-defaults
NO
NO

readline-common
readline
NO
NO

sysvinit-utils
sysvinit
NO
NO

tpm-udev
tpm-udev
NO
NO


As suggested by you in the previous TSC meeting, we are looking for any tes=
ts available for the above packages in other distributions as well. So far,=
 we have checked ubuntu, where we found a test suite for the net-tools pack=
age. The rest of the packages do not have tests defined in ubuntu as well.

We would like to understand your opinion on the next steps to take or other=
 distributions to target for tests for the above listed packages.

Thanks and Regards,
Adithya Balakumar


--_000_TYCPR01MB113852C6B7DC0548305FB8A0DE1EE2TYCPR01MB11385jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:PMingLiU;
	panose-1:2 1 6 1 0 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:=1B$B^b%4%7%C%/=1B(B;
	panose-1:2 11 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=1B$B^b%4%7%C%/=1B(B";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@PMingLiU";
	panose-1:2 1 6 1 0 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0mm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0mm;
	margin-right:0mm;
	margin-bottom:0mm;
	margin-left:36.0pt;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.20
	{mso-style-type:personal-reply;
	font-family:=1B$B^b%4%7%C%/=1B(B;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:215094890;
	mso-list-type:hybrid;
	mso-list-template-ids:633612152 67698689 67698691 67698693 67698689 676986=
91 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l1
	{mso-list-id:234517559;
	mso-list-template-ids:1227887794;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2
	{mso-list-id:551232803;
	mso-list-template-ids:-1253508426;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3
	{mso-list-id:869028216;
	mso-list-template-ids:2112013394;}
@list l3:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l3:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4
	{mso-list-id:937980210;
	mso-list-template-ids:-641943412;}
@list l4:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l4:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5
	{mso-list-id:964039364;
	mso-list-template-ids:736917648;}
@list l5:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
ol
	{margin-bottom:0mm;}
ul
	{margin-bottom:0mm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026">
<v:textbox inset=3D"5.85pt,.7pt,5.85pt,.7pt" />
</o:shapedefaults></xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"JA" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:bre=
ak-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B">Hi Adithya,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B">&gt; We would like to understand your opinion on the next steps=
 to take or other distributions to target for tests for the above listed pa=
ckages.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B">It=1B$B!G=1B(Bs better to define what should be tested from IEC=
 perspective.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B">e.g. python3 does not provide any functions and just for contro=
lling other packages (like a meta package).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B">See the package description and contained files:
<a href=3D"https://packages.debian.org/bookworm/python3">https://packages.d=
ebian.org/bookworm/python3</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B">No need to prepare any tests for such package at all (at least =
for OS security).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B">Some packages like base-files only contain data, which may be h=
ard to test without concrete methods to use them.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B">Best regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B">Kazu<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0mm 0mm 0mm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0mm =
0mm 0mm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;mso-ligatures:none">From:</span></b><span lang=3D"E=
N-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:non=
e"> cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&gt;
<b>On Behalf Of </b>Adithya Balakumar<br>
<b>Sent:</b> Thursday, May 16, 2024 8:40 PM<br>
<b>To:</b> iwamatsu nobuhiro(</span><span style=3D"font-family:&quot;PMingL=
iU&quot;,serif;mso-ligatures:none">=1B$B4d>>=1B(B</span><span style=3D"font=
-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">
</span><span style=3D"font-family:&quot;PMingLiU&quot;,serif;mso-ligatures:=
none">=1B$B?.MN=1B(B</span><span lang=3D"EN-US" style=3D"font-family:&quot;=
Calibri&quot;,sans-serif;mso-ligatures:none"> =1B$B!{=1B(B</span><span styl=
e=3D"font-family:&quot;PMingLiU&quot;,serif;mso-ligatures:none">=1B$B#D#I#T=
#C=1B(B</span><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;=
,sans-serif;mso-ligatures:none">=1B$B""=1B(B</span><span style=3D"font-fami=
ly:&quot;PMingLiU&quot;,serif;mso-ligatures:none">=1B$B#D#I#T=1B(B</span><s=
pan lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-=
ligatures:none">=1B$B!{=1B(B</span><span style=3D"font-family:&quot;PMingLi=
U&quot;,serif;mso-ligatures:none">=1B$B#O#S#T=1B(B</span><span lang=3D"EN-U=
S" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">=
)
 &lt;nobuhiro1.iwamatsu@toshiba.co.jp&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org<br>
<b>Subject:</b> [cip-dev] Preparing test evidences for CIP Core packages fo=
r IEC 62443-4-x assessment<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hello Iwamatsu-san,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hope this message finds you wel=
l.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">We at the CIP Security Workgrou=
p have been working to collect test evidences for CIP Core packages include=
d in CIP Security image as part of IEC 62443-4-x assessment.<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">To summarize the work done by C=
IP SWG so far, CIP SWG investigated the number of packages in CIP Security =
image and tried to understand the number of packages that have test results=
 available in debian and number of packages
 for which we have to run the tests ourselves and provide the results. I am=
 including the summary of the packages below:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<ul style=3D"margin-top:0mm" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0mm;mso-list:l0 level1 =
lfo3"><span lang=3D"EN-US">Total packages in CIP Security image - 242<o:p><=
/o:p></span></li></ul>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<ul style=3D"margin-top:0mm" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0mm;mso-list:l0 level1 =
lfo3"><span lang=3D"EN-US">Custom CIP packages (from isar-cip-core recipes)=
 &#8211; 13<o:p></o:p></span></li></ul>
<ul style=3D"margin-top:0mm" type=3D"disc">
<ul style=3D"margin-top:0mm" type=3D"circle">
<li class=3D"MsoListParagraph" style=3D"margin-left:0mm;mso-list:l0 level2 =
lfo3"><span lang=3D"EN-US">These packages are created by recipes in isar-ci=
p-core or isar that are deployed into image as a .deb file.<o:p></o:p></spa=
n></li></ul>
</ul>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<ul style=3D"margin-top:0mm" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0mm;mso-list:l0 level1 =
lfo3"><span lang=3D"EN-US">Packages with Debian CI autopkgtest - 140
<o:p></o:p></span></li></ul>
<ul style=3D"margin-top:0mm" type=3D"disc">
<ul style=3D"margin-top:0mm" type=3D"circle">
<li class=3D"MsoListParagraph" style=3D"margin-left:0mm;mso-list:l0 level2 =
lfo3"><span lang=3D"EN-US">97 packages with functional tests, 41 packages w=
ith non-functional tests, 2 packages with no tests running in debian CI<o:p=
></o:p></span></li></ul>
</ul>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<ul style=3D"margin-top:0mm" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0mm;mso-list:l0 level1 =
lfo3"><span lang=3D"EN-US">Packages without tests in Debian CI &#8211; 89<o=
:p></o:p></span></li></ul>
<ul style=3D"margin-top:0mm" type=3D"disc">
<ul style=3D"margin-top:0mm" type=3D"circle">
<li class=3D"MsoListParagraph" style=3D"margin-left:0mm;mso-list:l0 level2 =
lfo3"><span lang=3D"EN-US">70 packages have tests available either in debia=
n salsa or upstream.<o:p></o:p></span></li></ul>
</ul>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<ul style=3D"margin-top:0mm" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0mm;mso-list:l0 level1 =
lfo3"><span lang=3D"EN-US">Packages without tests in upstream as well &#821=
1; 19<o:p></o:p></span></li></ul>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">There are a few packages that d=
o not have tests defined in either debian salsa or upstream. I am listing t=
he packages that do not have tests defined in either debian salsa or upstre=
am below:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<table class=3D"MsoNormalTable" border=3D"0" cellspacing=3D"0" cellpadding=
=3D"0" width=3D"1261" style=3D"width:946.0pt;margin-left:-.15pt;border-coll=
apse:collapse">
<tbody>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid black 1.0pt;border-bottom:none;background:#8EAADB;padding:0mm 5.4p=
t 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;color:black;mso-ligatures:none">Binary Package name=
<o:p></o:p></span></b></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:solid black 1.0pt;border-left:none;border-bottom:none;border-right:s=
olid black 1.0pt;background:#8EAADB;padding:0mm 5.4pt 0mm 5.4pt;height:15.0=
pt">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;color:black;mso-ligatures:none">Source package name=
<o:p></o:p></span></b></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:solid black 1.0pt;border-left:none;border-bottom:none;border-right:s=
olid black 1.0pt;background:#8EAADB;padding:0mm 5.4pt 0mm 5.4pt;height:15.0=
pt">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;color:black;mso-ligatures:none">Are there Debian CI=
 results ?<o:p></o:p></span></b></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:solid black 1.0pt;border-left:none;border-bottom:none;border-right:s=
olid black 1.0pt;background:#8EAADB;padding:0mm 5.4pt 0mm 5.4pt;height:15.0=
pt">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;color:black;mso-ligatures:none">Are upstream tests =
available<o:p></o:p></span></b></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:solid black 1.0pt;border-left:none;border-bottom:none;border-right:s=
olid black 1.0pt;background:#8EAADB;padding:0mm 5.4pt 0mm 5.4pt;height:15.0=
pt">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;color:black;mso-ligatures:none">Remarks<o:p></o:p><=
/span></b></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;heig=
ht:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">base-files<o:p></o:p><=
/span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er:solid windowtext 1.0pt;border-left:none;background:white;padding:0mm 5.4=
pt 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">base-files<o:p></o:p><=
/span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er:solid windowtext 1.0pt;border-left:none;background:white;padding:0mm 5.4=
pt 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er:solid windowtext 1.0pt;border-left:none;background:white;padding:0mm 5.4=
pt 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er:solid windowtext 1.0pt;border-left:none;background:white;padding:0mm 5.4=
pt 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></spa=
n></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0mm 5.4p=
t 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">base-passwd<o:p></o:p>=
</span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">base-passwd<o:p></o:p>=
</span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></spa=
n></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0mm 5.4p=
t 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">hostname<o:p></o:p></s=
pan></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">hostname<o:p></o:p></s=
pan></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></spa=
n></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0mm 5.4p=
t 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">libmnl0<o:p></o:p></sp=
an></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">libmnl<o:p></o:p></spa=
n></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></spa=
n></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0mm 5.4p=
t 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">libnsl2<o:p></o:p></sp=
an></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">libnsl<o:p></o:p></spa=
n></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></spa=
n></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0mm 5.4p=
t 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">libpam-passwdqc<o:p></=
o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">passwdqc<o:p></o:p></s=
pan></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></spa=
n></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0mm 5.4p=
t 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">libpam-pkcs11<o:p></o:=
p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">pam-pkcs11<o:p></o:p><=
/span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></spa=
n></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0mm 5.4p=
t 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">libpasswdqc1<o:p></o:p=
></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">passwdqc<o:p></o:p></s=
pan></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></spa=
n></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0mm 5.4p=
t 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">libpython3-stdlib<o:p>=
</o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">python3-defaults<o:p><=
/o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></spa=
n></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0mm 5.4p=
t 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">libreadline8<o:p></o:p=
></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">readline<o:p></o:p></s=
pan></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></spa=
n></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0mm 5.4p=
t 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">librtmp1<o:p></o:p></s=
pan></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">rtmpdump<o:p></o:p></s=
pan></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></spa=
n></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0mm 5.4p=
t 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">linux-base<o:p></o:p><=
/span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">linux-base<o:p></o:p><=
/span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></spa=
n></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0mm 5.4p=
t 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">media-types<o:p></o:p>=
</span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">media-types<o:p></o:p>=
</span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></spa=
n></p>
</td>
</tr>
<tr style=3D"height:45.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0mm 5.4p=
t 0mm 5.4pt;height:45.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">net-tools<o:p></o:p></=
span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:45.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">net-tools<o:p></o:p></=
span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:45.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:45.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"559" valign=3D"bottom" style=3D"width:419.0pt;border-top:none;=
border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid wi=
ndowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;height:45.0pt">
<p class=3D"MsoNormal"><u><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;color:black;mso-ligatures:none"><a href=3D"https://=
git.launchpad.net/ubuntu/+source/net-tools/tree/debian/tests"><span style=
=3D"color:black">Few functional tests in ubuntu: https://git.launchpad.net/=
ubuntu/+source/net-tools/tree/debian/tests</span><span style=3D"color:black=
;text-decoration:none"><br>
Autopkgtest running in Ubuntu CI </span><span style=3D"color:black">https:/=
/autopkgtest.ubuntu.com/packages/net-tools</span></a><o:p></o:p></span></u>=
</p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0mm 5.4p=
t 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">python3<o:p></o:p></sp=
an></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">python3-defaults<o:p><=
/o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></spa=
n></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0mm 5.4p=
t 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">python3-minimal<o:p></=
o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">python3-defaults<o:p><=
/o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></spa=
n></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0mm 5.4p=
t 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">readline-common<o:p></=
o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">readline<o:p></o:p></s=
pan></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></spa=
n></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0mm 5.4p=
t 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">sysvinit-utils<o:p></o=
:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">sysvinit<o:p></o:p></s=
pan></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></spa=
n></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0mm 5.4p=
t 0mm 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">tpm-udev<o:p></o:p></s=
pan></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">tpm-udev<o:p></o:p></s=
pan></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></=
p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0mm 5.4pt 0mm 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></spa=
n></p>
</td>
</tr>
</tbody>
</table>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><br>
As suggested by you in the previous TSC meeting, we are looking for any tes=
ts available for the above packages in other distributions as well. So far,=
 we have checked ubuntu, where we found a test suite for the net-tools pack=
age. The rest of the packages do
 not have tests defined in ubuntu as well.<br>
<br>
We would like to understand your opinion on the next steps to take or other=
 distributions to target for tests for the above listed packages.<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks and Regards,<br>
Adithya Balakumar<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>

--_000_TYCPR01MB113852C6B7DC0548305FB8A0DE1EE2TYCPR01MB11385jp_--


