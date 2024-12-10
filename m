Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AFAE7717F
	for <webhook@archiver.kernel.org>; Tue, 10 Dec 2024 12:24:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.9053.1733833474478333329
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Dec 2024 04:24:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=PKcsiuc9;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1733833469;x=1735043069;bh=FU8bi0twrnygO0oD2N8kXZC5Sc0A9Z6mo4rNcgE
	yJYk=;b=PKcsiuc9cx7/08CmuKrR2DS+rSCh5tcJAyUsFqV9+MHAwct2Stp8rGoBtZ9lZ9MbfTbzn
	xi7wlTWcNKUd6eboE0rPHP6utQWlUpu2w3/0Mbkv5CB0kpQXidvEHE1etMYX/40yxEOIIyx6/HjWH
	xg/ZCD/NnPZJdZ4KJ7Hd7dAJ1MBQv8tbONJXA73pCNb9kGBDiw8vwvUJv7JOgYnsBUnBMsSXDi+2A
	EdPUrVmaGaYjG8t7qAs9P85xj0f3HTV3REdWrDCTRk8ioB+y+PkX//39ZyJ3FhTnt45R+SLlogTTu
	Exza91MdKNm1mjsYY69jbmx5JCGlc3hQPtWFhhjOCw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 4BACOSbJ1882407; Tue, 10 Dec 2024 21:24:29 +0900
X-Iguazu-Qid: 2yAbUt1VCDhaT2l91O
X-Iguazu-QSIG: v=2; s=0; t=1733833468; q=2yAbUt1VCDhaT2l91O; m=GIthDCVOVNt0yWcc9+iacQAm9Q/v4ykFa+mNXVKb+OY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 4BACORmH2109770
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 21:24:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcUrQM91B+PBSrAQ5WbzCiQ6En+mgqLjrxtuma0PakonqOmd7tOa27fdqplbS2a/r9njDwybluOFpXlJcv27TnuBfs+g89/lUfvPsF6uas43OaQh8W7s2rEH2JYsOvWuOPivCt/GsT8kgT3Z2USneAjj0/aNPZcBogwGNgw5J8BKFD/NSoTPqTNLlkS7vKVL/yueWShFFcuSTv0u1kD4l+Eb1QSx92DXVh1sFOL5SsriOMT3oCeNJw4fQjCp0gUDR+xPV/PmkSQT+tXoch2argVGg+HZ/TEhdnZ/uhXghjnhijUR+U5APPRi18L4YyjlgEiSj2fwdsp2770l7zaQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFlTABkK5JYNB5mdvHJoV5x9DV4FNi89a9nIX0hoA/g=;
 b=evr9cAeWefXJjCBx1/sTJsnTcLk2EVN33LT2bQ+s92sL8L+ErgeJWRiYpysEZG0MyssoQOtRu0YFRpff365cexWgCs5FUjsvWVAkHu8IMn+JZS4n9SoYPU8QbbRTsLjk0MQ6K11Q+mLQ6gS7SB0n16bL2tuDjJq4axHb7rskkDuMtzzoh4pK/lLU6kZLiY1IZHxMzzRb0ikVANrnsu7tqiaVV3Ka8+gfXu4gcG1ypT+XO7oHD2CHvuDXD/6pKxtkBRuFn9aWUbts6kJxf7D9tjZYksdF9DMkNukuNgyAwlV+fmyulBy7CytIOzgY2bEQIRifxKrba7kyxL4MEnLFQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] arm64: dts: renesas: rzg2l-smarc-som: Enable
 4-bit tx support
Thread-Topic: [PATCH 5.10.y-cip] arm64: dts: renesas: rzg2l-smarc-som: Enable
 4-bit tx support
Thread-Index: AQHbSmSVIlNxGE+6/kKKg9ggyK99KLLfZ/9Q
Date: Tue, 10 Dec 2024 12:24:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638890ED7F37DB2EFBD288AD923D2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20241209180235.20418-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20241209180235.20418-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TY3PR01MB10222:EE_
x-ms-office365-filtering-correlation-id: eac06b3b-73f0-4561-5c94-08dd191595aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bUJ0V3JYZmVMYmplMGtpS0YzZU8xZFFSRmRpMGtoaHozZ1Voam9PMzE4?=
 =?iso-2022-jp?B?NFYyN0UyNnhtQ3g0aitBcFg4T3hTY2ZtSWxCczlZckhJV0NDaGxwRzIz?=
 =?iso-2022-jp?B?eFlKbmR0TlN0RklDVG8ranZYYVZrWFpNbmVWaEJWNDIwTStiRjVBbElT?=
 =?iso-2022-jp?B?RmhTeTZKTi9nUTQ5TXdhRkR4ZkRVZ294c3dYaHk2dU1mV3o5bEdLKzZ6?=
 =?iso-2022-jp?B?cWtCSGE2bXVpd1hCUmFwMUQwdklkMnMyWllTR3kzaGZQUC9LNjI1djhs?=
 =?iso-2022-jp?B?dlBGb3I5cjBVajM1SFNYNlI4amdiZjYxM3p4bngwK1l3cVFMdHdKa05Q?=
 =?iso-2022-jp?B?bW5tN1pFd3ZmVXdtZEl2VDYrbzZVSlY4ZHVnQ3NjbW1OOSswN2w1M1k4?=
 =?iso-2022-jp?B?bEFDcFpGa29zT1gvL0Y1NnpFTmhpM3BlMERlclFnWWdtemhKQ3Rtc1pv?=
 =?iso-2022-jp?B?SkRKRmI4VWUrMjF3cVJVdjhwSmppSmF4VmxLajNRZGxCUmhHbUdrNTIz?=
 =?iso-2022-jp?B?K3N5K3gxVnl5MzdXeEoyb2JpSXBTWnpWcjBac3dFdXlyU0N0bE9SQlRp?=
 =?iso-2022-jp?B?SFp3MGoxbm9PV21DTFVhNVNkVzM1T3VhZHUvQk05RjJXRDNORk1mOUlY?=
 =?iso-2022-jp?B?TDFHMzdEcGl0TGRhbklkQjZLZ0xhRTZOUDFSb29QeUpWTGxGTGg0R3g5?=
 =?iso-2022-jp?B?OVViUG1YUkFsdmtrSCtscXVVZTFnN1hmREJJZ2xFQmgrOExtRFFER1Fu?=
 =?iso-2022-jp?B?MndkTUFjazNMOGg2bXFyb2Y2SnFLeXJFMmM5OTRPQUU2SURvbGFjaXBM?=
 =?iso-2022-jp?B?Q05ZVHNva1ZDenBJMVh3d2FjL052bFRRbk9aQk42Y0FoQUYrcEp4WkxG?=
 =?iso-2022-jp?B?ZGR2WldRaExoY1ZQSnlCelplaUhsckNxYTc2dFdvOGg3YWNIS2F0UTdL?=
 =?iso-2022-jp?B?dUlvQnNKWDZseGVxNDBtZXRSdk5YVnJVN1FIbk1FRlZvQ0dzc3V5SUJB?=
 =?iso-2022-jp?B?VWc1UDdQbnRjVlFNdzY0ZWt1aE4yNGkrK2NwTCsrWW96ZGo1LytwZURw?=
 =?iso-2022-jp?B?UTltMk91YTFpVFJtRitzQ1VUYllpVzk3MzNuRnN0RVFNR2RoYzNyQ0lU?=
 =?iso-2022-jp?B?RjFhN2FKZFl4dnVJMGZ5UnZnbVk5c0JaNGRkTUQrdWQ0dW9mSHl3NjN5?=
 =?iso-2022-jp?B?cGJsNXBVd21aemxLbWJvOHBoTklsMWhsRVMwYW9zc0dlTlZHMHVnSk1p?=
 =?iso-2022-jp?B?WFBCbTZiWklKN0VtVnpvQVJocVlJSFkwaWFwYTF5cnV5MDlHT3NNcS8z?=
 =?iso-2022-jp?B?dmdLa0N1aHlyd3dablZZTlVMbTM3Qk5mdnAwc1JZczd1RzZJM0VDSWdC?=
 =?iso-2022-jp?B?VG42Wm45a25VVDMxTGNqZnBtY2NPSEQ5dHNiMkFJRmNIcjhic1FyM3Rn?=
 =?iso-2022-jp?B?VlFkdVpFRFFJQzdwMzl5UWI5dXlSQXh4VmwxblhLWnZsTURYMjdCQmNH?=
 =?iso-2022-jp?B?dXRGWHNnUXFiQ2NWZWsvYTJOVk5yeGF3NFR0c1VOU0REK2RsU0pNRHc4?=
 =?iso-2022-jp?B?R2haTWRRQ0VoVm1rYktOcEJ5UjByMTRVUWRpczZ6M2cxbTByZng5MUtw?=
 =?iso-2022-jp?B?RTRzeHVBSlFPOVFkZFA2NndQUFR5V3dwQ09xSG12UUhlbkhMT2ozVk1B?=
 =?iso-2022-jp?B?Z3JuTUhPR0hqcmpmVUE0RWFrMDVIUmNxUmxWMEI2bUxYSUNEQk15Yndx?=
 =?iso-2022-jp?B?a1RtelI3SzNHZnZKL1VHUUhRL0JlNG52RU5zWDVsYk5mMFl5MmZYR09z?=
 =?iso-2022-jp?B?VmtYQWdOQWJhOXdIMi9EOWxVMjhjdk1qa1hoMEc2S0luclhxZ1lJWWpN?=
 =?iso-2022-jp?B?dnlEOGY5YmFNcHB3WFFYbWZzekJJZDNLNUFpdEYyYTI4VmUvZjdpV0th?=
 =?iso-2022-jp?B?VnZsL2pzVVhtY1JaQTRXUXNKWVkwUG1Rd3R4aER5RVFqZjI2dm9LZ0dE?=
 =?iso-2022-jp?B?a3ExQ2x5RWFJRENnQkhUOXp4L1RzMlF1ZEpETnI1WVlqajBMVlBLTlpk?=
 =?iso-2022-jp?B?M1pHa2ptcUpGcXJaMnBZdXI2SGZXTnM9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dVppb1NGcjJybUNEM1FrZ0RYWUJYQXM0SDdYMnk1Q2JnWi9rUVpQd1dR?=
 =?iso-2022-jp?B?blNmTndraHFwNTdrc0NGbzJ2VXBtWSsrMC9mZFhaMnJISXdCVlRiUENj?=
 =?iso-2022-jp?B?THJiVDZUZWdhNVFoc0lndkpqZXoybnFHSG1WWmlMdEk5Qmp6L0t5dGxZ?=
 =?iso-2022-jp?B?Wi9FalJJeWFYQTRPdXY5aUhnazhTTWNGZEFmTkVSb1FPZFh0aU83MFR3?=
 =?iso-2022-jp?B?a1JyVElQeHNWdWFQZ0xHbU1CWlFBSmNaRU0wMHpWMStSaU9mc21pNTZR?=
 =?iso-2022-jp?B?M1A0dUpYSWsxZkpMUEF3ZnlLMThtcG9XQVBqQndiem9mdmFOVkdENWZy?=
 =?iso-2022-jp?B?ZFUxdjgxNGk1eEt4c1d3STBnSDZYZTlPNFVVTlByc01wTy95SlphajNO?=
 =?iso-2022-jp?B?THFzaUtyYUExdWpFLzhLYSt1TmNZTlR2Tk1Uek93bjVwRXpjWDJEUXhE?=
 =?iso-2022-jp?B?RUFlY01vWnJZOUowMS91akw5QWd6Y1lqc3EvZEdXNUNVSmwzazlnUlA5?=
 =?iso-2022-jp?B?S0ZOUkZvVzAzVXRXdFI3KzBvcWc1MlhUaFV5R05CbDM1dy94UjVwN3g0?=
 =?iso-2022-jp?B?OHFsVGlNZEtRajNwUVg0UjRjNTFrRWVEZXlwNWVpTEFlSWRIVWpVdCt3?=
 =?iso-2022-jp?B?RUNlc1cvQ0V4WFhFZlNYbnJEV2k5bW5TeWQxQnNZaVhjWGE3Y1NWY3ZE?=
 =?iso-2022-jp?B?ajRTWmd4VnpXOVNyQTRBQmNPSER6ZkVWbXBoSTFyQ0xwK0NlNit0VkFy?=
 =?iso-2022-jp?B?clYwMDlDYlBWellzV0pwS2NxbGh6bjQwZGl3Vzg5NHcwdG45ODVyekdC?=
 =?iso-2022-jp?B?WFlCRnJPSEJBTzZEbGsrcHZjRlFoVHV0NlpWbUxrdXlxbVhiT3d0WFNO?=
 =?iso-2022-jp?B?NUFQeFhsNzBXNHgxS0kwa2hWcWZVTk9DQnpFNnQvWFhUbnAyTmJUcjBL?=
 =?iso-2022-jp?B?U0tIVHdabHJYaXZGZDg0eG5sdnhwdDByTDlwc09BNEZpdmlNS0o2M3RL?=
 =?iso-2022-jp?B?aG1Ld0VlYmxpcVJMdVgvTVNMYVhmRUc0ZU5rMGNzMlRXVktqUzJZNlpM?=
 =?iso-2022-jp?B?QVY4cWxtR0VjeHN5USs1TGxGNEtjbUIrZWxvSDJZUk9JT1psc0JtN1pQ?=
 =?iso-2022-jp?B?ZlMweGdBbmlKY29YSDBiNmRRcXlEY1pLcmxseFdZYzhLcFR2VVc4V0hP?=
 =?iso-2022-jp?B?OXNrYnBRWFlFS1VEcGRWV1E5aE1jalVQdG81LzhrN1pXMlBsdWFYTXNH?=
 =?iso-2022-jp?B?YUkyTGE4NEUvOGp1enBVQ28yYnJJVkZya0pyMzZ4OWtPbUpqQVgyb3pS?=
 =?iso-2022-jp?B?ZjJMa1g2WUV1RzZmUlFSU0JucTZVd1JRTU1oUEdkR09MdXc1dzNSWFRU?=
 =?iso-2022-jp?B?N0JWOTRFUlgwNFNha2xWeUl3SDlyNDlxZDcrdU9kUVZITm9ZNlBXOUVM?=
 =?iso-2022-jp?B?WGJKcU5xd0RodnMra1RmYlMyMTNQUk5raTh5eU9lNE9FUkw5WWZCYWxZ?=
 =?iso-2022-jp?B?U01DQlFzNXJnclpLRlk2a2l2T0Z1K2xDTU1jUS9lczkxL0NkR2RneW04?=
 =?iso-2022-jp?B?Wlo4Q3B2ZjRTRUQvdDRjYTFETU4wc0x1NS9xSGxkTU56Nit5ZVN2Wjgz?=
 =?iso-2022-jp?B?NVVaTXI5b2ZPR21QZXNma2NXT1U5YmdHTTFPSm94ZHByekphK1pBUy9j?=
 =?iso-2022-jp?B?bG54ZnVQKzFWd3BGTmlXU0dKTWFMcEhJM1FvL1haRXlUandjQkpiU2xl?=
 =?iso-2022-jp?B?THk5blc5YUdyTURrYmwzRjJ6dVl1eDJRN2lXNnpTZHZpTEJYT0g0STZ5?=
 =?iso-2022-jp?B?WWdKa2poNkEzVHFzMkZJdDVBSkFyb2hSRFllblh3VXlnMlUrbTB2Wko5?=
 =?iso-2022-jp?B?d282WkFYcGNQcFh4aHhxQ0syWVFhK2I5d2VUNmJ6YVgxMk1rSEtueUFn?=
 =?iso-2022-jp?B?VFI1MHEvaTFSeFhpMUJLVnl3WnpsQWFSVzR0ektBSFRSMVFKdTdjdXhp?=
 =?iso-2022-jp?B?d3lkR2JWVmhUZUEyWUU1Q3VBbmNvdGNmWWErR1NGVkt5bG15eWFmbG1T?=
 =?iso-2022-jp?B?ckdPQ3RZcUxJMktQK0lwRlVYQVNMOE5hM2w3TTIwQWR4eGRpU0hPWEhj?=
 =?iso-2022-jp?B?cEZpakVPZE94T1dCT1lVdzZ1VjRWQ3gvZTlabEpUb1lTUWdtZUE5U2Zv?=
 =?iso-2022-jp?B?ZmttdWF0OUhWSGVUOCtVS0k1cVJrNDJZalRlaENpVWxvZ21jbnlGNTZp?=
 =?iso-2022-jp?B?aldxVHZCcEN4bkxuWjJZMnNPY0s1YVI5WHM0QnJ2T2xtSEJWQnNzcmxY?=
 =?iso-2022-jp?B?WjAwUDdDcElsemJ0Y3JSckhhRHVMUG5QOHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac06b3b-73f0-4561-5c94-08dd191595aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 12:24:25.2319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWwtzf9pfsfEEOz8Ttzue0e0wnhHq/kUS6aQwipky9n/RFpte72xa1WsvXVL7DKPXUB24DVa8GcNZn2fkHOuBLeM3j4KzQ/P/GCNYMyaF/I9o9rm4QjlZkfE/fTFFNmW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10222
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Dec 2024 12:24:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17391

Hi all,

> -----Original Message-----
> From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Tuesday, December 10, 2024 3:03 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip] arm64: dts: renesas: rzg2l-smarc-som: Enable
> 4-bit tx support
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> commit ce3adea16612a677dd50bdad6861f37f5dc878c3 upstream.
>=20
> Enable 4-bit tx support for sbc node.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link:
> https://lore.kernel.org/r/20231108172232.259301-2-biju.das.jz@bp.renesas.=
c
> om
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> index c1f290b53b56..e4d0ac6fe702 100644
> --- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> @@ -312,6 +312,7 @@ flash@0 {
>  		m25p,fast-read;
>  		spi-max-frequency =3D <50000000>;
>  		spi-rx-bus-width =3D <4>;
> +		spi-tx-bus-width =3D <4>;
>=20
>  		partitions {
>  			compatible =3D "fixed-partitions";
> --

Looks good to me. I can apply this if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


