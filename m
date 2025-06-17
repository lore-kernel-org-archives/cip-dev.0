Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA04C7114A
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 04:43:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.11045.1750135434291206188
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jun 2025 21:43:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=nSuP7fZA;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1750135412;x=1751345012;bh=gu
	L4o2e1Kugz6boUG8STg4Rspzhb2HFRKJjLrhud8Eo=;b=nSuP7fZAqqMMCtIc7ugyLJw+TwS/d6Z4
	DzoQ91SyklKKwcwj6Lb6v7jKWkNtYKlzkE79vUHMfoRclq1zj3BEMdoFEwpuiNpENRPqRbL+Q+MdJ
	SITi16QyuoOsFaMwoNhvncXFoDB7fWwm72nrIGUeFE+7cS54PXKnsHAXb2Oj67HtcIWcw4srCWJ1U
	cuMy3YE02S4/J1zRLd40q23Tk37xr6GzTn/uTGHag/iQuDfy9pwQYpcNUH8RBbsnf1rRhmwJ2uiYB
	ZrixoF8icNnC7k+Ul5Gmp6p7QZHSrSF1oWPgsbHQSmn6vLe0cu1EYFAZ2pMEv60SnxqVZMsjkk674
	jQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 55H4hVpo3315667; Tue, 17 Jun 2025 13:43:31 +0900
X-Iguazu-Qid: 2rWhMjEQLnXQoqNgjh
X-Iguazu-QSIG: v=2; s=0; t=1750135411; q=2rWhMjEQLnXQoqNgjh; m=/QTRnDRdXj0s+j1BG/D7GumKjr8NWlfxGyGoaZdbdnQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 55H4hTZe2526611
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 13:43:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X586AZ7k1vJ5DZtgBOpW9/Cf3kKfzyAAoKXZcMzc+R1kRGNtiq0RfdXon+BEA1/9fYNvbsHjuaSjRnWPHKq5JPHjVVmfiS9MFCAkgLj3AWm6JUPyPG/1DHd6Burk9VcMob85vvuqNhGDGcdLY92opqvYzSzekizdkpMFrWYWhAVrQgdo2aoPgJGOeuNVOQJ6i9hch2VFYs34BGX4TB0L2nH4i8ATtQRfZWK0fm+3K3ZtJV4se3x44eSJ8p75ERrwVxua6A+tF+LMMetFWKFh+Sg+5EXqgOk1jUNFWKl5IXjOvjcw9HKQVU82EbPLKCS0NMYINrXkvfGUlMDlxcDYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CxrDO1t/GFl6D+cG8q6mxEw208jQcpXPyGDsJVB2dQ=;
 b=v21SzFZlK+XbR4mswdHo/2Fej15rVuKBe3t6tiXs/ns96Ka5CbcyTnkDWh3aO9dHY24piW2QfizXQOeL4FpDcuHDenc11auRuRqsYDA74ZbFrniYfCFxMtJANDHdSaPsvf4F0VaMShL87CwXwisnuZy59gyobvxKbjOj7Yv3/HyCwDjtmQBjnq1ebSRpEwLVTqXOW+kH3xpfkRwvqMF+SJVLAlLQqkKedDzfVgcsujLI1oZAe4CD4Qd09Bi8OqCHHfup/ReMY2i0HjIKr12oUPzgHhbkRqlOit3oPz41B0S+r9sH+njcYqcosHszYBVkDDIvS0wy0jfJxBwqnBnHhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>,
        <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v5.10.238-cip61
Thread-Topic: [ANNOUNCE] Release v5.10.238-cip61
Thread-Index: AdvfHqHOU58EPMYxQeCxFG0sXwRgWg==
Date: Tue, 17 Jun 2025 04:43:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818C1CE607FE8B8AEF4BFCB9273A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS0PR01MB5986:EE_
x-ms-office365-filtering-correlation-id: a192f45a-91de-4571-b338-08ddad597f21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Smh5RFhqeXZYUXdPVGoxRm9RUnRQWlVtN2FUYkdOa2tIMnJzVWRWbTgy?=
 =?iso-2022-jp?B?TVVaWkVudUtlcVdlTS9pRjBFYWJhOG1yWC9qWk9DTlJwZW9BVDkxbWdk?=
 =?iso-2022-jp?B?bjY4RGJzZFVrWHlKT2pYUjlOaWdDOGZ1VGpVZHZ5S3BiUjdxUUZ6RlNB?=
 =?iso-2022-jp?B?MTFjY2VDNUd2QnJSaEhHTjRJbnVyVC9LeE1sanZFNThjcGFIWEJPdHc5?=
 =?iso-2022-jp?B?akV6RSthUmYydVJLSkp4YndsbHJscWdsY0E1Qm5OeExUbzBqcTJEVlFE?=
 =?iso-2022-jp?B?NHU5d3R2WUJGN0ppeGd4ZWh6L1ArNC9QZ0FIUkRveXRjbFhINjJBbmE3?=
 =?iso-2022-jp?B?a1kzOFVydWNyeWxJeGtHN0wrZDQ4UzJwdlZTTXl1alRjZlVzQkxIb0Fq?=
 =?iso-2022-jp?B?QmdRMGZ4KzNVdkJmdzJsWUdNQktCWXk3S0J1OWFYK0I1YjZNaEJOeDEy?=
 =?iso-2022-jp?B?ZWI3SnVrdklwSWZXZmZocElUMjRtSDFUR0VhMFJsczdvdkNaQTNjYldo?=
 =?iso-2022-jp?B?cTFLdDhrK1hoUzlITVZtbFdkVU15VmtWS0h3eGVyd0JYWFpkVVRGcUlY?=
 =?iso-2022-jp?B?ak1vM3c3Q2dlTEJiU0hWTERUbmUzdGRFNzNnalNmQ0txQ01yeGphejdi?=
 =?iso-2022-jp?B?WTNBVW93aHhrMHBaTlVCbTE2YXp4QTF0VW0zVUFWcUZJeEpBRzcrcHJp?=
 =?iso-2022-jp?B?TS95eW9hMGxJSFd6ZndKNXRmSUdOUllQS0w2UnlLL3NSSWE4ZzVwTW5Y?=
 =?iso-2022-jp?B?VldlSXp2RExxVS9WSkJrN3B3b0d5c1owSE1aNzUxOC9xQWpjTDUrVlJ3?=
 =?iso-2022-jp?B?USs3SWRTUHZvZndXTTlUVi9EbGwvczZYeURiODNSL3owTGpOV00vVEhP?=
 =?iso-2022-jp?B?b29TUUlWQzBleG5URUJnYUVUR1JZQXhMdXRlRWtjTDQ0M2tveFBoc1c4?=
 =?iso-2022-jp?B?YXlTU1hDbEVZTE5ONjlZeWRzeFd2MWJWUTQ1V1lZNnpjajZaUTJtRDZh?=
 =?iso-2022-jp?B?bzdSeDgyb0JpV0toQTNhUjc4NEpRcTYwRHJ1dFNHSDhqNGF3WFpDeGd5?=
 =?iso-2022-jp?B?bnJCME9MMys5RkVLVkZ4ejh4aExBN1U4dU5iNnhYbTJKU0NjNVI4NEFN?=
 =?iso-2022-jp?B?aDZicE5Nd21XbzQ4R3VhOEtFbWp5RnF3VEJ2YU1XalprVVY1OGxNZmVD?=
 =?iso-2022-jp?B?eEJGb3FJeGZlazczL1lBNlBYY0dtSGNPMnpLeWtvYncyRC9wSWNLdG5H?=
 =?iso-2022-jp?B?ckxjYnovK3VzUnl5eG15T0gzYlVIcXVkVnhjYmp2M3RnVXVIa0FvSEpo?=
 =?iso-2022-jp?B?c1hFeFJPdGZ3bFlGeGJ2VUlXbVFaTXRSdGdTSjU3aHlKeGlubnVPS1Ji?=
 =?iso-2022-jp?B?RkxkMjJEQjNxY2JlYVNSTG1CQ2IyWVN1Q2UyZjFySTNsNmtQazFZcVhv?=
 =?iso-2022-jp?B?L1JGeU5hOWZYcmFIeVFvS1dXRWlYZndRRzJXNjlCZ2h4Q1VsVHRJNW42?=
 =?iso-2022-jp?B?dzRKVCswVmV4bTd0QVF6Sk1SRGVLLzhNL0ZyUkV1MDJuWThmeWZsbkt0?=
 =?iso-2022-jp?B?aVRodGV0UTczUUNTOHZNYXc0YXd2UW4xNm1zYi9sdlRnRlROR3JhVm9P?=
 =?iso-2022-jp?B?SElqVzhaWXJ4Nkgyb21iMDR5cUhlYUtIUyszVzFCeUlCUENmdkhGUmY4?=
 =?iso-2022-jp?B?eEhNRmxVVTdCUzFQZkNoQ1ZFNk03NWh1aHhKUDd0UjZ2WFQxUnk3VEpP?=
 =?iso-2022-jp?B?MzVRRE8rTHBEM1ZJc0VHTzBaRlBVTDlzNDRzbFpUcFA4YVlyZUxoMjF0?=
 =?iso-2022-jp?B?MkUyOHdma3JkQ1I4NWljbEJ5bXh6SVdUVWliakczNlJJaUZMZFVqVm5z?=
 =?iso-2022-jp?B?cmk4ZGFmcWEveDArdXM2RFo3QTJWd0QvVW5BUkxQa1Z2elo5amVrZ0I5?=
 =?iso-2022-jp?B?Y1RHQkpRVVZDUzRaUU5lL2V3V1c4WCtRNXZjbjNsNlRDc1hVUThOR0k5?=
 =?iso-2022-jp?B?b3lmRnZxenplek4xaS9xNlB6aG1hbHNSblBkdVk2dHRrd05la1ZvcUQw?=
 =?iso-2022-jp?B?OTJwUkEvRFZGNkw5VVg3azBrSlpHRXZaQUZ0M1NLWmExZzJaNXBJWTlD?=
 =?iso-2022-jp?B?bXVtOHpUMlZFeGZjUzBON1N1clhOMzFkcW5aNHpFbzYzUG9acTNTV1d3?=
 =?iso-2022-jp?B?YWVZPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?alh2b0lmejhyTUFxQWpUejhVdkRyMWFTZEtXSEhFa2JsTVdwWVB6TVRv?=
 =?iso-2022-jp?B?M3VDbC81OEZlWFFVRFFtRXFGUWY0RmVMYzlrVnNGenphYU5VeWc5bE9m?=
 =?iso-2022-jp?B?UHNiMU1Xa1dFaEhNaW9mQTM0U3F5MitnVUhJRE9HNjZxOHJtdUxjejdM?=
 =?iso-2022-jp?B?d204U1FKb29uQkpoQ3ViMTdmTGExSFN0aXFQZHp5TnR1Y2RGSHArbjYx?=
 =?iso-2022-jp?B?NjFNVjUveU5ENkhEbTNMTGNxRGZ3ZHlMMUxYZmpIcWlUV2o3d1hDeGxn?=
 =?iso-2022-jp?B?OEc5V0F1bUFHbXB4dVNjblZxZm92RkZBZDFnYXREclBrclNFL1R1K1Y0?=
 =?iso-2022-jp?B?dk5SeC8wK25ZQ3c3eFAzcnZrdndkSEtadFZCTFFGdjlud0szQjZIbkda?=
 =?iso-2022-jp?B?WmN0bXR5c29wd2V2a0VZN1dEVDhlUXhRNlVyN3lHUXc0bGlVY3RyVWI0?=
 =?iso-2022-jp?B?RDBVQURJazJ1M3c4WTFCaUdSek01Sm41cW9QVzNIb2N0NjVmUUNWT3lL?=
 =?iso-2022-jp?B?Z3pjQ2F2M0ZDTys4TERld2xBWGRKNmZTYUpDNFE5TW9JNm5rcm9oNGRX?=
 =?iso-2022-jp?B?SDdqelR2QVRrVEVQUlBqeEFHa0dsVlFwc0tOa09ZVEI2QkJYNllJd2Uv?=
 =?iso-2022-jp?B?WVI2VlROQ1drK01leFZJMWs2bUJrOFRwNFRRRFQ0ZWdLZ2RNK25xTk9I?=
 =?iso-2022-jp?B?RFB5RlZ1eFludjRLcnBzTThJcGNWQUtIdkxKc2VubWl2YmZNTW5NSzBz?=
 =?iso-2022-jp?B?S3ZWT0VGSmI1MG9ld2ZicmdiYW5EcjhIWEtpZFdGZk95M1ZMenZWK1V0?=
 =?iso-2022-jp?B?TkpUSUY2dDJrYVVtZEE1OWx4RmM3MS96dFQ0MUdTbEsrcTZOZDgvVG5L?=
 =?iso-2022-jp?B?cXV4dVdvY2lCV3A1Nkk2MTIza2o4N0NyQUJlOEd2LzcxYjdRQldxMVBv?=
 =?iso-2022-jp?B?OVhPa2dEaVEyL2VRY0FGVWhvK1BXOSt1T1FTMXhCRFFaVHl4YUdNYXdK?=
 =?iso-2022-jp?B?WHlOejVzSzZBeDNqeWdoZExaWVV1bXluNkdDYTNuWEM1d1AwN1lneUs1?=
 =?iso-2022-jp?B?OWVxUTEzNXZiOGNYQVNBQVRtUnJ1b3VtYmxGZy9PZjNLY2VCUFhRMEMz?=
 =?iso-2022-jp?B?RUVSamg4anQraXhZQWoybFNOQzZYUlRucnNUOERCMDlLWXF2VHlGdS9P?=
 =?iso-2022-jp?B?UkxYK3lUbnFoM0IyUHBpSXBxaWhLMXNDSGhyTUh2L2VaSFg1aTF3UWN3?=
 =?iso-2022-jp?B?a2VtOWluY2pDUWxUOWxRM1ZkZHMzRTdPTjU4U25icURhYzI2TFIyenVG?=
 =?iso-2022-jp?B?Ly9WT1UxemdQbUV4Q3VOb0hIdk4zRnN3K1lnVnhJRjlTVVhFOE44ZDBV?=
 =?iso-2022-jp?B?SjFKb1BETmdjVXNVcU9ja1l3RnMvN0h4N1ZLT25TRU1JSlE3OGNYMVNw?=
 =?iso-2022-jp?B?K0l0c3QzRXh5RUt4M2dJMjF5L25QNlhjL3B4V3hJOTJiK0pyRis2Um1S?=
 =?iso-2022-jp?B?N012a3p1djJ3czQvQ2lFdFlkZk9HWjl1TXloTW9pVWViN0p4TVJQN2w1?=
 =?iso-2022-jp?B?dnczbXdvWmNLTHpxYnUyUUNtUDFSbTdaNUt3eno4aHRqaFR0cDFlbnBW?=
 =?iso-2022-jp?B?cEFNR0VYTjZkYkVwWEpRMks0M2JEckRlNjlxSm5ya3lmTlo3K1Iwc3Mx?=
 =?iso-2022-jp?B?ZW5Rby9VYW9BcHFmL1lsbHJ5djlKWXpkSkFmd0Z4NS9wVWt3YW9Rclcy?=
 =?iso-2022-jp?B?WEMrVDhSZlBKT1IwVkxLb2wrNmRjMm1GM0V4dk4zSXRnWHg0K0IxZk5u?=
 =?iso-2022-jp?B?N3cwREZnVmRkcVZPNTFGa1AyQjh0Y0ExaDdkKzNJQjZUL3FFdUxKWFBT?=
 =?iso-2022-jp?B?R2RwOUxNc0lpUFB2WHlsR2YzbUg4aTBJYXNYaUF6cXBOMUJ1UEYyb1pp?=
 =?iso-2022-jp?B?WGlJc1U2Y2RKMTVNdkwxbHdFL25lNFlKQ1EvNFN6ZmJHZU1xUVA5OG9y?=
 =?iso-2022-jp?B?UkhTSThJMHR6OEpaRUxrcHIrZWxmYzVIalB5M2dXQk9MWHdGYWM5aVFU?=
 =?iso-2022-jp?B?aCtKRmF1d3hmWjBxbWxRSVFseDNBYUEwTDY4SjNsY1hZcndqeGtvMkJD?=
 =?iso-2022-jp?B?ZmJuNTMyajNkUkZzNEIwZ3hRdUxVc2gyeDNKRDNtLzVrZmkwbFpaUHRV?=
 =?iso-2022-jp?B?NFN5eDRZYzZFNXhxWjBnRUhqVlBwZ2M2a2ppSjRERzNTdGtRNWNjaU80?=
 =?iso-2022-jp?B?dEY5bk1QNWJ6dGNhSWovZzhKZytMMm5Vd28zSDhIZjd4bmRSY0d3YnB6?=
 =?iso-2022-jp?B?WTRKMVRFYklieXd0L25ZK3JQY0pTbVZkTFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a192f45a-91de-4571-b338-08ddad597f21
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 04:43:25.2767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5LkkdH/kF1gLp2xGtgjf1/EcuJzNN2ZalgnzVBHpW8dLSLHvdkLeMjf/tmJAdGk2IS2qIHkzm1O3Db0mL+pD0XDd6ZRx7c/z9wtyeeUdRKcN/0xxCAxW+NW36H09G4uB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5986
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Jun 2025 04:43:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19114

Hi all,

CIP kernel team has released Linux kernel v5.10.238-cip61.
The linux-5.10.y-cip tree has been updated base version from v5.10.237 to v=
5.10.238.
This release includes fixes for ADC and SCIF (UART) device drivers for Rene=
sas
ARM64 SoC.

You can get this release via the git tree at:

  v5.10.238-cip61:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      65fb4abcfb5dd50e63101c206c32c3fe87733380
    fixed CVEs:
      CVE-2025-37913: net_sched: qfq: Fix double list add in class with net=
em as child qdisc
      CVE-2025-37909: net: lan743x: Fix memleak issue when GSO enabled
      CVE-2025-37994: usb: typec: ucsi: displayport: Fix NULL pointer acces=
s
      CVE-2025-38000: sch_hfsc: Fix qlen accounting bug when using peek in =
hfsc_enqueue()
      CVE-2025-37991: parisc: Fix double SIGFPE crash
      CVE-2025-37915: net_sched: drr: Fix double list add in class with net=
em as child qdisc
      CVE-2022-21546: scsi: target: Fix WRITE_SAME No Data Buffer crash
      CVE-2025-38003: can: bcm: add missing rcu read protection for procfs =
content
      CVE-2025-37890: net_sched: hfsc: Fix a UAF vulnerability in class wit=
h netem as child qdisc
      CVE-2025-37997: netfilter: ipset: fix region locking in hash types
      CVE-2025-37969: iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6d=
sx_read_tagged_fifo
      CVE-2025-38001: net_sched: hfsc: Address reentrant enqueue adding cla=
ss to eltree twice
      CVE-2024-43863: drm/vmwgfx: Fix a deadlock in dma buf fence polling
      CVE-2024-53203: usb: typec: fix potential array underflow in ucsi_ccg=
_sync_control()
      CVE-2025-37970: iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6d=
sx_read_fifo
      CVE-2025-37927: iommu/amd: Fix potential buffer overflow in parse_ivr=
s_acpihid
      CVE-2025-37998: openvswitch: Fix unsafe attribute parsing in output_u=
serspace()
      CVE-2025-37930: drm/nouveau: Fix WARN_ON in nouveau_fence_context_kil=
l()
      CVE-2025-37949: xenbus: Use kref to track req lifetime
      CVE-2025-37995: module: ensure that kobject_put() is safe for module =
type kobjects
      CVE-2025-37990: wifi: brcm80211: fmac: Add error handling for brcmf_u=
sb_dl_writeimage()
      CVE-2025-37923: tracing: Fix oob write in trace_seq_to_buffer()
      CVE-2025-37819: irqchip/gic-v2m: Prevent use after free of gicv2m_get=
_fwnode()
      CVE-2024-38541: of: module: add buffer overflow check in of_modalias(=
)
      CVE-2024-35790: usb: typec: altmodes/displayport: create sysfs nodes =
as driver's default device attribute group
      CVE-2021-47037: ASoC: q6afe-clocks: fix reprobing of the driver
      CVE-2024-46751: btrfs: don't BUG_ON() when 0 reference count at btrfs=
_lookup_extent_info()
      CVE-2025-37914: net_sched: ets: Fix double list add in class with net=
em as child qdisc
      CVE-2025-38004: can: bcm: add locking for bcm_op runtime updates
      CVE-2024-26739: net/sched: act_mirred: don't override retval if we al=
ready lost the skb
      CVE-2022-49063: ice: arfs: fix use-after-free when freeing @rx_cpu_rm=
ap
      CVE-2025-37992: net_sched: Flush gso_skb list too during ->change()
      CVE-2024-56655: netfilter: nf_tables: do not defer rule destruction v=
ia call_rcu
    added commits:
      CIP: Bump version suffix to -cip61 after merge from stable
      arm64: dts: renesas: rzg3s-smarc-som: Enable ADC
      arm64: dts: renesas: r9a08g045: Add ADC node
      iio: adc: rzg2l_adc: Add support for Renesas RZ/G3S
      dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3S SoC
      iio: adc: rzg2l_adc: Add suspend/resume support
      iio: adc: rzg2l_adc: Add support for channel 8
      iio: adc: rzg2l_adc: Prepare for the addition of RZ/G3S support
      iio: adc: rzg2l_adc: Enable runtime PM autosuspend support
      iio: adc: rzg2l_adc: Use read_poll_timeout()
      iio: adc: rzg2l_adc: Simplify the runtime PM code
      iio: adc: rzg2l_adc: Convert dev_err() to dev_err_probe()
      clk: renesas: r9a08g045: Add clocks, resets and power domain support =
for the ADC IP
      media: mc: Provide a helper for setting bus_info field
      arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1
      arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
      arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe d=
ifferent switches
      arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
      arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
      serial: sh-sci: Save and restore more registers
      serial: sh-sci: Update the suspend/resume support
      clk: renesas: r9a08g045: Add clock, reset and power domain for the re=
maining SCIFs

Best regards,
  Nobuhiro


