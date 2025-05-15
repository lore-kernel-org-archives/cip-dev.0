Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDB0C3ABC9
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 16:25:25 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.52])
 by mx.groups.io with SMTP id smtpd.web11.17044.1747326318775364862
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 May 2025 09:25:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=KUyPA2sC;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.52, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaTfB3u0dn/e6rPHFoZbsQzwF/8rhgSarfPnlO1xTPt+m6IdeETAWT9FrWM1XEC8wQSU3mPiLQrqmvpaBt4lR+tpCzoeGbPfi+Pz5fYbjPrjVFrOBCeBKHo0CMcJW6E/Adsd0qwB2nTFw2uYG4AF2pKQpNOnoR0D5wbaFqDSVvR4KHPsx2xiBSiF6y+GSKWrINwpfHGmNQ439NwTEiMIkP3eQgafEbJtCiZbLpJyxsz/+Unds1CLjv8y39x+UnYWtcBSroewaTBA6OQVmOLL2Cyvv04ngRMbyrA+QYomJ2pJBvZTM6Fl2Ng7xKODXLMdQKfZi2d9PSrWX/9/aA+hzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJLbBV+XM2iJPK9pM4VmETm7zlKGOWHv5/dKkYYt1Bs=;
 b=dv9nmkJ2iSJ07DTnk1DB7ND/uFH2Zidh9032H8mEt2BLIpZZlODdb6yTli2v5Q989nHIX8HGbNj8o0X635rQFgJE/MDHtm5ccgHVCsS01aRXXufiMW9wHXiFlLoRs8mv5CZ7Jtj+3oy+W3BfKvG8+Z9Jqd14NtFEH80b6nSIsMWREkmfGmUoXgBSGXfRuwcNpuW4m3bLiNyNTl4iklKBEeGmtYk+fBx17rT9k33aV3i4p82k4oOOlUmq/RCKFKCCiQNfC8iiUCOmVGJyjZuULq3SpiiwFvCcSNErAayO1T/7J/AqGIazNpERnnmBXz7h9ciB4McNXZf1MpFFRHTEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJLbBV+XM2iJPK9pM4VmETm7zlKGOWHv5/dKkYYt1Bs=;
 b=KUyPA2sCidJspp5UC1BHuLsSYC6rDtbbRgHDqC6DQcYsg1XwGjPhdE3yAODrEmTeIsia1ya2Ft3FAoJrbrMmekYUtx/xZ8j//RyUcOieQYyzirwPJXiioexTi76VwYlOmCCFk3iqaBHSNuteClqTVRXcofm/2XoRCYJ+S0ELNT8=
Received: from TYYPR01MB7024.jpnprd01.prod.outlook.com (2603:1096:400:dc::9)
 by OS3PR01MB5813.jpnprd01.prod.outlook.com (2603:1096:604:c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 16:25:14 +0000
Received: from TYYPR01MB7024.jpnprd01.prod.outlook.com
 ([fe80::39ac:b8e5:61e:8037]) by TYYPR01MB7024.jpnprd01.prod.outlook.com
 ([fe80::39ac:b8e5:61e:8037%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 16:25:14 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Ulrich Hecht <uli@fpond.eu>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH RESEND 4.4.y-cip] ARM: shmobile: smp: Enforce
 shmobile_smp_* alignment
Thread-Topic: [cip-dev] [PATCH RESEND 4.4.y-cip] ARM: shmobile: smp: Enforce
 shmobile_smp_* alignment
Thread-Index: AQHbxZckhhAdOVf5V06nJaEMEim67rPTpB4AgAA8S5A=
Date: Thu, 15 May 2025 16:25:14 +0000
Message-ID: 
 <TYYPR01MB70240CE4E2B02471C4BAD66AAA90A@TYYPR01MB7024.jpnprd01.prod.outlook.com>
References: <20250514094308.60634-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1605143841.341243.1747313065539@webmail.strato.de>
 <1520612430.341765.1747313306566@webmail.strato.de>
In-Reply-To: <1520612430.341765.1747313306566@webmail.strato.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB7024:EE_|OS3PR01MB5813:EE_
x-ms-office365-filtering-correlation-id: 2adc79f7-00c9-490c-d632-08dd93cd1252
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Lzhjc0RhWFFodmtEZ3J3V2xFWWVSL3JjNmV1OEw3eDgrdnBqVlJweTZrQmpq?=
 =?utf-8?B?M1ZCZitRUDFPbUsrSUQ1SldBMDZqL3FadzRqa3ZrTE5vbUF5am5LSkY4a1Jk?=
 =?utf-8?B?VWNUZTRTV05uNUR4YUI1UDRFMnZoMFZWTFZxemVWM1dnWWZGQ3pGNHdkTU1s?=
 =?utf-8?B?NVRQRWtlSXlYM1V0RlgzM0hqcmhzMXdycFdOME1OczBmNmNDTkc0bUx2ZVc0?=
 =?utf-8?B?dHhyTkw2aVVCK0JZMVowQ2FlZEpzSzgvMUtDQU4xc2hqZ1ErOFVlWFd2QUZj?=
 =?utf-8?B?eVBCRmlLQTFqbmpRcVFGTWNLMGhxMWhzeGc2QnVrb3gvR2ZNVWdVWEtySXpR?=
 =?utf-8?B?ZC82RllGbU5oVEg4b1lxR3VqQmJYMnNjWGJVQnhjbEVBa0hTaEYzOEo0UlQ4?=
 =?utf-8?B?cUFTWWd2WXVqRFc2MEpGWGZaWGVVUi9ub0p4NnUydXBoTERacmgrMTdBQXI2?=
 =?utf-8?B?V3FLRmtncUlZMXljdHBvSnZFY2QxSlR2MkkrZmZDaHk5dldYQUQ1dVppRk94?=
 =?utf-8?B?cWRXcktoZCs5eVJiRW1iTCs5b0dtM0YvVWNjcVEzTHZ4ZEFDSG01LyszTk9W?=
 =?utf-8?B?Ump2MlFKQWFkMzJ4TGlLa2JxMzdGdjlsbnVhUEhHRlJ1K01vR2pwMnVGeTVM?=
 =?utf-8?B?UG9IdS9BZGNBVlI1dytKeTdCWjd0WVhPMU4vbXZTNVgxNituUkY3ZW5CTFNp?=
 =?utf-8?B?UXVqdzJiK0tkcmRxdDZpbEZ5U3E3WWl1eENMVkJpaTlFTUJDMS9ZZndTQklL?=
 =?utf-8?B?Ny9QWFQrdk5QTmxPN0V4MEo0NnNMUFJ3UFU4L1I2NWdQUXM4b1Jkc2xvdjN4?=
 =?utf-8?B?bmZCK1pPbVFyb0VCbkZGRFBtVHZlOFdNZEdPbzJOOU1oYlJBbGMrRVZwcHZR?=
 =?utf-8?B?bnp6REZGMFZJM0lzWmpJaURZVDVFckVLcFpzVGNacW9FckpNOHpSQXJTQlFl?=
 =?utf-8?B?WTdraEFuM1Q2L2ZBV1NUQ2VKYzN2L3crUTRLWFVnekNtMWVid0pRc0pLLzgx?=
 =?utf-8?B?MjZ1MUphZEc4Ly9OTHlRUjRSQm4xQ3RpRUlRT3NKeG1KTWhESVRVV28zaTZy?=
 =?utf-8?B?TzdVNnVFSEcxR0VRVjJnRDBRM0o3bVJ2MmpsaXo4ZnAwQWI0L0FhOXN6YVgy?=
 =?utf-8?B?amMzMDg2QnpSSmJON1lqNGxESlNMOHowV3ZHck9yOW13b29zMEpjM3pQMC9a?=
 =?utf-8?B?RjZ5VldybHhGY2dES01WU2NyR1RqMStNQlUrNmVVdkJadUh0Y285NjR5NE1T?=
 =?utf-8?B?V1NHNWJ6VXhzNjQ0ZWp6di9qUWlMRlhBUUJ6L1FTSXMzanpZUWt5Nk15N0pm?=
 =?utf-8?B?d3MwK2U1S1VUWXEyNVMvZzFEa0JKZjdMd096cDJCRkhsdzFoWDRhcm1oZG5z?=
 =?utf-8?B?SkI2S2NjaWdqc3VBNklBT0VSbUVGdlY5eno4NmM4SXlkdVNCRXYzcCtFWHZT?=
 =?utf-8?B?WTM3b25yYlp1SXM2eVc5UjhEQVdhNTU4NnJmOW5XTVE1V0Y1MWVvUG1VTGhz?=
 =?utf-8?B?bXJkaTdYcGlwQkJZZGQwMXFLOEZXSmtPd1IycmNWdlhXM1NySUQ5aTBWZ1hk?=
 =?utf-8?B?Mno0SlJvK3A0VkdidEEwQW1FSnZCRzJLR3JNbHpQcktwZjlWQmRSYXFTZEtN?=
 =?utf-8?B?OUU1NlNtV29LRFRlQVFWQkEwSmZobXpSamVzYjNweUxvRE9oYkNDSGZMSDNL?=
 =?utf-8?B?c25UdDR5bDJmN3FUN3hhMkI0V1FlcVlTUlpDRENpNGk4WHlhODV6T0E3ZDlJ?=
 =?utf-8?B?UUJueHdmanUwaXJOemJGSkRSUXNxS1d5YVlmRm1FYnFSWWxFL3dOTDhmelpP?=
 =?utf-8?B?NSthZ1NVRi9KMVNzRE93ZGlxTDlQTkg2Nk1LUHhyMm9aOHg3Y3RNZWdsNzhE?=
 =?utf-8?B?eTZQRWVpNnFwN3pQWG0rK3pJRlFSeHZmblArNlpOZzBPelNvNmZ4ZVBZLzlp?=
 =?utf-8?B?OFA4MHlLdE02VEVpVEl6V3pmMDVBVm5WOWdVU3M2OHdzRVdrWkhkTjJTY1JS?=
 =?utf-8?B?dEpFL0V3TnFBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7024.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?R0VUeUNCb1NjY0huMUgwYWg5WFdTbFFOM0czeVRsMFpGano1bEpBQ29PVzl0?=
 =?utf-8?B?L1kwaHN6Um1KL2lJUTJiYTdmaDUwS0hlalVwbk16RDltT3lnMFJiKzZ0bndH?=
 =?utf-8?B?M3JsdWM0T0l4OUJ3b3JCajVSR0srTFF0bUZ4UStvNWFmYStiMGY5RHI5NFc5?=
 =?utf-8?B?eHVPa01vZDNrdDl1N2dPa1NBZzJrQ2pGT3luckpXR2d0VXUvSnY3amZ6dWFK?=
 =?utf-8?B?eUgvdzg1K0o1ekhKUDF4UW9ZMzk3OXZTL2diRitHNWd4NzFrZTVJbkw3aVU0?=
 =?utf-8?B?YWJ0bE85aDYvQ1MvdUVKK09tWTlQVC84ODFTdDJuTEkrSmp2SVF5bEg0S2VW?=
 =?utf-8?B?YkZlYTRMN1hvWXFzSjdNUk5ZT1VCZnZIbU9XYy9XTklLbGdhNTJ5UnpQZGZJ?=
 =?utf-8?B?RW1IT3lsRWJiUkNTeUNnUlVRMmpuWjN2QlFzSFVYT3pGWWVLS2xCbHcvbHcy?=
 =?utf-8?B?ZzZ1YzJBME9uNzFaN1VqVzlsbFQ3YmxxWDhpNEk2QlZFaTQ0R2k2WGp2N1ZI?=
 =?utf-8?B?N2N2WHZ6WkRVYzY2Z1dEemhoY2FIcmdqQ0VnL3lXK2hIMDN0L1JQSWN4MGJo?=
 =?utf-8?B?d3V1ZlN0M2N3djVPcG1MN1FFNXpMSHNFdDJNdDd1L0Q1Tzgzdm1BRGhibmtU?=
 =?utf-8?B?alhlUzVUdW5MQ3kzRWpTWlMzSWEvKy8zRlZaNy9jOVR1OWVjUkxtd1QwN1Ax?=
 =?utf-8?B?RTgrN0s5VTN6d0JPZWszOXdiaklRcFc5QmpXMStsN1pWRnFrcE94Zm5pd2lp?=
 =?utf-8?B?a3FpUXMvUFFOTG9KRzd1bnhnU1J6MUFzR1NhZHZ2bUJMTWZORUp0YTBKOWV3?=
 =?utf-8?B?MXRrSDdLR29pd3ZlMFZRcnE1WjJtSk82Q1FyVk15NHhPWnJJN282NWpSeGRu?=
 =?utf-8?B?ZjFzWVFMVjl3TnhFNjR6Y0lsN0l3QUNxVjVHdW9HSHdiM3YwcklGenlnaHhK?=
 =?utf-8?B?YmR2SDQvdm90YmxBb2FHRGN2SWIrdTNSNUc4ZWo4b1d2ZDNpZTBtMElWdmJo?=
 =?utf-8?B?TlFubTFsWGVqM0s2THFVWU10bzlQOEd1dzdwZmJYdisrMS9BYVFmRGM5eVJI?=
 =?utf-8?B?bWp0SzVZZE50T1BhcHBHMHlIV2xFTS9ueWFLSDRxb0UrMlpZcjJyeGlCYzFG?=
 =?utf-8?B?My9KNmJjcU9Bdm9BU1hhejZvdGYrVlhpOWdXL1c1bDlMTWRLSlo4amY1NVQ5?=
 =?utf-8?B?ajB6QTZ6UmRYaWhKbitSZW5obkNDbWRpSlAxTktpcW1FcVZCMTcwY3FKMkZ4?=
 =?utf-8?B?ODl1U3pEMDNFbGkrcFN3dmwxS01MZ2tLaERMeGVCTmhGeWt4SnVsaWpWU1Mv?=
 =?utf-8?B?YWRQOUdaMm5VNmRjNkFUZExMRjNNM2JFNTUvRlZseHh0amdObSsyVkl2aGVD?=
 =?utf-8?B?N0dvb0JEWHMyZXMvclE4eWhrbXpPZ21zWER4MHQzUkROS3dDZ2g4M01QTkEr?=
 =?utf-8?B?NFprRjc3L1BWaE5IazhiQjUzZ3Z6bmFsalZxSVNiUW43ekJhUElUZzI4a0dJ?=
 =?utf-8?B?QUt5eXd1eHdSMk5GZ0N0ZjNGcDUzQUZLaU1BeTltRW9MMGRnbmpGVFNxamU5?=
 =?utf-8?B?eE1ibU13dkhub2V4aThXZ2dFdjZwTGdlRk5CVkp1eTd5dUxGY3BLcGdhMTBp?=
 =?utf-8?B?ZDl4R1RZeWc3aklUZTQraFFuR0Y1bURIWWs5SVFzMFdnTG9ZdkpYQ3BKQ3ov?=
 =?utf-8?B?K01Td2JyS1M0clpkOGR6SndTVHJrdGFtUW0zZnFTN2xZQVJyc2xuUTEzN2l4?=
 =?utf-8?B?eDdqSU5TZE44T2dhTG4zZ1JpK1VCTktRRjg5aURPSndZYTVDZEE2MXNDTmRy?=
 =?utf-8?B?UTdjWmVVR2tralZ4R0g2UlV1UVlXRGo1SVhrMS9VN0w1bFY4WmpzVTdwdGZG?=
 =?utf-8?B?V1p2YnpEN3NUaWJ2aEcxY1JBdS9wWjF6VWd2bWVZZDc4QlE4c0dtZWRLVGcy?=
 =?utf-8?B?bFBiakVjRXdVVytSYXpLWURtZHdVUUtaZWdoYnNLUjF6QVU5QjAyQm9pMGd5?=
 =?utf-8?B?SFhDUXhHTkN0TGttaFZURndJVFRVSUozdWtqNnovYzFFa0ZIc2pIcUlUUXRL?=
 =?utf-8?B?VStlbWxuRWp6RWtuR3pPdnhrcWNuUHVLWTdvbzltNlhWWnJDUjllbzFUa1VW?=
 =?utf-8?B?cHJ3OTlZK3p0MlB1L3R5VlZ1T08zendCVmxEZ085c2lhTWZFdFJlcXk1V3Fl?=
 =?utf-8?Q?qx78BPhCKdj+ask0Q7LnGIo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7024.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adc79f7-00c9-490c-d632-08dd93cd1252
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 16:25:14.1214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: loFA4AgAK+CrnKsiKSFPcPbnN/+s2+m/BhDFJmyghGq6QSzcLrSr4Uw7qHEo+x/fbLSPom5PdJnkqp7j9/V9XcN+b3X13y/AbH7IddXHOg2NIMrvoi9d6ilNHEBYP9nQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5813
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 May 2025 16:25:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18917

PiBGcm9tOiBVbHJpY2ggSGVjaHQgPHVsaUBmcG9uZC5ldT4NCj4gU2VudDogMTUgTWF5IDIwMjUg
MTM6NDgNCj4gVG86IFByYWJoYWthciBNYWhhZGV2IExhZCA8cHJhYmhha2FyLm1haGFkZXYtbGFk
LnJqQGJwLnJlbmVzYXMuY29tPjsgY2lwLQ0KPiBkZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBO
b2J1aGlybyBJd2FtYXRzdQ0KPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+OyBQ
YXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+DQo+IENjOiBCaWp1IERhcyA8YmlqdS5kYXMuanpA
YnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW1BBVENIIFJFU0VORCA0
LjQueS1jaXBdIEFSTTogc2htb2JpbGU6IHNtcDoNCj4gRW5mb3JjZSBzaG1vYmlsZV9zbXBfKiBh
bGlnbm1lbnQNCj4gDQo+IA0KPiA+IE9uIDA1LzE1LzIwMjUgMjo0NCBQTSBDRVNUIFVscmljaCBI
ZWNodCA8dWxpQGZwb25kLmV1PiB3cm90ZToNCj4gPiBTb3JyeSwgSSBmb3Jnb3QgdGhhdC4gOigN
Cj4gPiBBcHBsaWVkIGZvciB0aGUgbmV4dCByZWxlYXNlLCBzZWUNCj4gNWJlN2YzMzQwYTQxY2U2
NzMxODU1ZGI1NzhlMzYwMDRkZmU3ZDQ0MS4NCj4gDQo+IDgzNTgzYTdiNjM5OTU5YjI0NjFhZTQ3
Zjk1NDhlY2UxZjg4MjFkMDQsIGFjdHVhbGx5Lg0KDQpUaGFua3MgVWxyaWNoLg0KDQpDaGVlcnMs
DQpQcmFiaGFrYXINCg==

