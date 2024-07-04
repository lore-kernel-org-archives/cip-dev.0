Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0585C30653
	for <webhook@archiver.kernel.org>; Thu,  4 Jul 2024 11:37:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.8240.1720093052639012710
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jul 2024 04:37:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 464BbUNp4011018; Thu, 4 Jul 2024 20:37:31 +0900
X-Iguazu-Qid: 2yAaDGEE0j75Kn4g8v
X-Iguazu-QSIG: v=2; s=0; t=1720093050; q=2yAaDGEE0j75Kn4g8v; m=SGoyYHvliNAz7oS1P+0i19KdaW2WyEG46mqldI2T0gI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 464BbTTq3427527
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 4 Jul 2024 20:37:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQjMRZITfKUlvaYPUq7gvgBj7IE/sbNo8rL/wFYfnY8mzhAMU0ONX+klskbMlxGOvyZJI7uF31tb13ew5eAjvLjQaJA6hgBdpIyDLMr+ty2ZpaAWemYlqFy7SASfbf9uZbp8HwxI5yITTZaztbWiHg7c0rKqxNhH/LqPcfK7tU6ewjTx+hnUARLT1ntAZygs2sikc9DQi/LI+oixMT7SKcpuhtpeJxvrI1Fb8FFkfEd6LSWyeb+GAFTTmLoHwJSDlVU89lx6xGHz8ZPKIGo4JZbT8nEPwrpGc8I+Fk19FejA97Qe+cNgfrQSrKNGzmM6tSHBaJ/73UIxyJAhRQ3EMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8878jK3e0OzUaBqw8aK70pM87hYULJlsjmBJNSYaihc=;
 b=k7ZSD92B9qh9idXSDryuTfB7cBhnj3vW+jxt/ulvFAvDiM8XcaZp1oUYYM1AgJd3P3feTuUOGaR9+TiLL1c6/rozRG9a4JJr7KLJBxdNO+iKr3+/S98fEl0/ZKU50NAc3RtTTrFCDxkOJnNduhfu1XwsRy5n8bx/+aEox0NlaY7OFfM/dj1SD2hRmSHCbM73U+NZdIAraumVlt2qf6bOEghNNqdMIkAlXKVgFXVV7nAfZyXZgG6g/BSuPcRzh+lJXrcw6acWKUXVnXS8IFCxctQ2ANO5zafXNKS4zkjMetsymzJadkGeJUPWDtyzb4sY5CykG2Va3M80VmvR257aIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core] Kconfig: Refactor Kconfig options
Thread-Topic: [cip-dev] [isar-cip-core] Kconfig: Refactor Kconfig options
Thread-Index: AQHazfoVk99fsaMHdE2T5O7XjqyfgbHmXT/Q
Date: Thu, 4 Jul 2024 11:37:26 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB11075ADF741232B7FD668B5C3C7DE2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <20240704091803.3250609-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <68a430ab-afc1-4594-847d-bd823d44f965@siemens.com>
In-Reply-To: <68a430ab-afc1-4594-847d-bd823d44f965@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|OS3PR01MB9316:EE_
x-ms-office365-filtering-correlation-id: e84f65cd-f588-4746-1325-08dc9c1dae0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SWpHVGMxWWd6TTZ0c2Vhb1ZMb0RHSWRKODRkRi9yTm5BOEVmN25LMFA4?=
 =?iso-2022-jp?B?WWpHMTVuUGJ4OXF3S0RSTGFGQjdKbzZPWXNJUWpYZG5zaHhGTzV0dUU4?=
 =?iso-2022-jp?B?V1ZlR0VYWWo1aVNMTmdUTmR3ckdJVFhvQzZEYnBLOUIzbDA2cEZiMkQ0?=
 =?iso-2022-jp?B?OWJiSWMxYUdrS1JKbUd1dmI1Y0l6NU1HSFZPeG1MejdkWXNHa0NROW40?=
 =?iso-2022-jp?B?WG4rcFBXeHpwNk5GVi9JY1pmY3BGRHZXUnBlRzNsaFNraDRvUUY4VjlY?=
 =?iso-2022-jp?B?THUwL1RaTXFwMENXcXI4S3krUUlFTXRnZWNWUHNuaDlhajUzY3drYWpP?=
 =?iso-2022-jp?B?WEx2Yyt6OFc1QXhxTktiZnVlelVrK1N5dko1VDdHdGxTYWxRaVpjaC9h?=
 =?iso-2022-jp?B?VG8yWEQxaTZLajFjRUxqU05UZ1FjM2VVeUdJSkhxUHF2cXdldXpESTRT?=
 =?iso-2022-jp?B?WGJMUnVGYldVaTl1Tk5nWEVLcmF2bHZSZ0g5M3ZJT0tFTnQ1bS93Y0pQ?=
 =?iso-2022-jp?B?Q016R0dhc3dwRVlxSXQrT0xrNDQ5ZkNkajZPL3haWXJiTVo4aXZOaFUr?=
 =?iso-2022-jp?B?VzJqaC9SV0V1L2RKRlV6dkY0dVZJZTJOdGlzTzExc3J5YVBoejFocTVM?=
 =?iso-2022-jp?B?bW9YV0g5NUtUK2dVOFNURWR4UUFkOS9QWkJZamVuV0U5Z1hOMlU3WGZx?=
 =?iso-2022-jp?B?czB4TU83YlNXTkFnOXp0YkVYb2dkaVRxamhrVmtpaUZpRzhwRkRTRDdv?=
 =?iso-2022-jp?B?Q0pxa2JTaUU2SVRJVUtJTTNKeFErTVFhRG1xdWdDZWxKY0pkVytqK3Zy?=
 =?iso-2022-jp?B?enR1QjZsUlZtcjl2c1M4SjNVUUlQYTFWcGliMnZ1MnNVbzhvNWczNE9U?=
 =?iso-2022-jp?B?cDhwaGhZQm5tVmZ2KzJWaWxqdFpPZTdnc1ZrRWFKZStRV0xxOGdQQ09j?=
 =?iso-2022-jp?B?aUkyUmdDWlBjN25CTU91eXoxU0dQTWVBWXV5bS95Y3B6NG80eU8yTW9O?=
 =?iso-2022-jp?B?MFZXV0Zya09COVZXcG1YZjdneXRnZVo5Y2N6cVF5TnBnNE5nV1pjcDhy?=
 =?iso-2022-jp?B?RnpPeGo1TG1vTUVYeXBrUnNHUm9zM2lPVHpQRHdoRnJxWmZ2RGMxSGxm?=
 =?iso-2022-jp?B?VTRrSEhTSUo2d1VkVlZqaGVBSkRTZ2dyb1d1U1FtSjA4dGM1d1RBc2s0?=
 =?iso-2022-jp?B?UVd6cnlXbkxlZ0xZK3VNOVJEcm1rY2dWSXNrVTZYRzMzOW1oUjRvRld1?=
 =?iso-2022-jp?B?V0R0WHF2Q0t1aTdoeEUrSmZCODFaaGFZUTh0RlFSR1BZempDOVluVm1p?=
 =?iso-2022-jp?B?MHNSYU1sYnFPVzJVMVdsREd2SlpUSjAxZHJSS3ZGMzZsY1ZBcXUxOXpo?=
 =?iso-2022-jp?B?RmNwbmVraE9YVmc5T1pHdzA4SytNR1JlUmpyd3dsb1lHZHlHeVJKSU5u?=
 =?iso-2022-jp?B?emptemZoRFh1aDdPWGJuakNlYzQxQng3OTQ2S0dxMkx0bTFLdnNLNEhK?=
 =?iso-2022-jp?B?b2tEQ1krTnZpQlB6YWp4UGp0R2t6bnlITlh2WU5vNXVQWUNPb25GdGIr?=
 =?iso-2022-jp?B?enpjOXZKamM2T3JwMjlJeGlyOUtqa3V6SW82YjBVUUxIZ0lDcGZ4bEpr?=
 =?iso-2022-jp?B?VVVQSkwvTzhaZ2dFTHJBOVJENDdPa2pNTnJnazhsS0YxcFdrSUYzZ0o4?=
 =?iso-2022-jp?B?UnMxbE4wUkZuYUlRZkwzVGFpbU9WWmNNaEdnekl5eFloWG1vRXpEaVdU?=
 =?iso-2022-jp?B?VjBlNkZmVUoyK1VOZXZUTEpMV0krT1lVNXJHUTBUSUs2RkFQUlVhQVBo?=
 =?iso-2022-jp?B?NnBWZGh4WTZ1MUE3Z0dZSVJrWUpFcFVJeVVYeDFIY2xrQWZPQVEraW1x?=
 =?iso-2022-jp?B?a0V0Y3YvRWpHQTgzWE9oNU1RNWxJZDlqSXFtNXRWMDdWd1o3TGpkS3gx?=
 =?iso-2022-jp?B?Vy8rRENTait1K1Z5QmpRK0JmSWkrenc1WlFKZE5aZmNsQ0NwbnFyRk9Q?=
 =?iso-2022-jp?B?NU56dlowYU84THU4YmhtSC9OWk5LMnlrTUdzZitidFFSdmRRUEw1Mk5M?=
 =?iso-2022-jp?B?UHc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?K0VkbFBzWCt1VmNMdzdDcTVOWWt6SXJWTHNoUk9WNGZ5SHlxSStmL0NX?=
 =?iso-2022-jp?B?YnFhaFMxYW9mck5udmNxcFR2d3Nibkd5cHRoMndSVVhaYlhOMDZqK2F0?=
 =?iso-2022-jp?B?RUdtV1VDUHNSTkVReG9acVBCMk5aWFIzaVZqRTgwUFRNRm80blNucEFp?=
 =?iso-2022-jp?B?b3A1ZEZoem8xNGtYUUlnaFhndGlmSVBodFBZRXQxaVhMMElNRy9ld0RG?=
 =?iso-2022-jp?B?NURVcmNIdVhkMERVai9iaHdGaHY5V3V3MHRCRFFkbVFiS0lTWXI4YkxK?=
 =?iso-2022-jp?B?S24zM1VCS0t1emN0T1BpeXo0a0w5M2FvQ1lwRDFLR3Z1ZzZIcGN4djhN?=
 =?iso-2022-jp?B?cjdZUlpUazlaWVBHZENWZ0NmZTFPcU1RTVRpYUVDRXNkVTFyb3h2dDZF?=
 =?iso-2022-jp?B?WTd1WEd4aXRvM3NoWlpacm9NaG1rcmplMDEvaUpWeThoTmEydTQvMlAz?=
 =?iso-2022-jp?B?YU9kZ09KY3ErUTE4V24zR3FJV3ZpajhPcU81M0k3a3JLcHpoNTRiQ0Jz?=
 =?iso-2022-jp?B?SDZJNTRPaUNxbDdpYTFPdW1MZ2JobkkyWThRQ3VhU1lGNzhob2VibEEv?=
 =?iso-2022-jp?B?aWVFYzd0SWJ5WGdyU3JoZTJiY0VEQ0RTWDN3TW5RVUtQWjBiVjFiVkRL?=
 =?iso-2022-jp?B?Y2pnUkhtWTdGV2FJdWpCS1lTNHRhenJWNTU5M2FtRUp6WmI0Q0ZCaG5O?=
 =?iso-2022-jp?B?Zm1QcWltM3VvYmc1SXVwclVybGdTNWk0bkpDSlhHc2d1Y3ZBZW5XR0I4?=
 =?iso-2022-jp?B?OFZQSTFHa01DZzk3Q3BYam9OcnVQaVpHbTlWaTh4OE5uZ1ZxM1VmLzVS?=
 =?iso-2022-jp?B?LzFIUnZPbGxKM0dkUlY3ZU90NlRJYW1mbWF6U1MrV3BKb2E1Z3JqSFBV?=
 =?iso-2022-jp?B?OXdIZHpacjVOdHRpeGRrTVhCQzNIL1hDenNsWFRBTWhKWXV0cW40Q1Zy?=
 =?iso-2022-jp?B?bTJFL1NFaXB5L09tektKOFJmTDZ0NU9IalFOSm92ejMzdmZKR0hVd0t3?=
 =?iso-2022-jp?B?TU83NE81dDJxRUN2UllXRGwyT0lkZ2ErU0EvWVJkMGwyclFHOVpLTXQ0?=
 =?iso-2022-jp?B?U21JMDROWFo1clduN3R5dlFxK3lzMG1UM01BOFpmd3F1V1FXZzVCZUVZ?=
 =?iso-2022-jp?B?UXdzSFlXdnJvZWt6bGM0c0ZRREwyVDBrY0tXa2s2RERjV3VocUFiNkph?=
 =?iso-2022-jp?B?ajk2K0tlZ3g5Sklub3VlVGc0N2dQRTNPMW0zSmlmRlZtRGJpZHJBMk5C?=
 =?iso-2022-jp?B?OEJPQ0h4dWxmczNWaWFhYmlLYWtkTTJSYnZRN1poZWw0bTY5aGp6Vm5u?=
 =?iso-2022-jp?B?MC9TR0RxTXpBZEc4ajlXaFZzUklqYktkV3RPZEFHTnlweVZCeWlzSE9I?=
 =?iso-2022-jp?B?YWhpWUdESTViMlpzWnpBcXBuWlBTaGtXSk1SSmk2Uk51bFZIUmR2Y25q?=
 =?iso-2022-jp?B?azR1aW5rTWhEL2xlTWVseWE5UGZTWEt5VERsd2dtdWFuL0ZYU2dvY2Vq?=
 =?iso-2022-jp?B?YlhtU0FjUVo4VnBSM1l6OHFlNkpGbW9kUENvcm10bVRvNTFHOFd6SjFr?=
 =?iso-2022-jp?B?QmxUK2hqQjB2Mk5YM05ESW9sbk9TbklkRitzcW5iOW9ZaHUzVG1NYktm?=
 =?iso-2022-jp?B?QmlrT09yMEFsVDdSdXFXTGkzQXV5YXhxdFJDanNLWThDN1kvREZGTm9T?=
 =?iso-2022-jp?B?VUxzU2c4SkJER0NlbTdyK0l5VDhmMUxDK0pyUGIzV2VNSUNFcS9pL2Zi?=
 =?iso-2022-jp?B?U25MdVA5ME40RU8rWXlYSzF6dzVHYS93N294dHY5Nk1jdWZZcjVPQ0tu?=
 =?iso-2022-jp?B?UDBnTGJYTXZZWGUvRnA3TGNPN2I5UUtoR3VyOE00Q2kzRGZONm9EMDZQ?=
 =?iso-2022-jp?B?Y2xmck82WU5kbXNoSVovOW1iUmZPcTFrZ3hmTEpvR1RuZSt0NTRLNjFa?=
 =?iso-2022-jp?B?NUtvOUtkZDVzcGZjTnYwTmg0R1ZlSWNMZVV4Sk96R0VoWW5CTlJxTFNE?=
 =?iso-2022-jp?B?RXJyYUJVaVJqYXUxMUptd2NUZEFGK1FPRFJTU1VwSm1pU2NBQlROVGZN?=
 =?iso-2022-jp?B?S1RISGc2aitNM1ViKzJ1VkhIMnRNN21ndXd2NWFiY1FRUnBKVktRamhz?=
 =?iso-2022-jp?B?NjUxblpUbjVBeWtYalU2T1JkME5sZ2JnVXFEa3lMTTR4QlYxS1ZVQUpJ?=
 =?iso-2022-jp?B?TWZYcCtzeE1Jdzd5M1J2QndpY2Q2RDlzTUZ6WHNvajFtdkQ1Y0J6Z3ZJ?=
 =?iso-2022-jp?B?b2pra002LzJMNEE4dXc2U21DcW81RWlhakUrQTVmNnBxaWRXNjZSTC9B?=
 =?iso-2022-jp?B?MndieitwUXFNbUExVEoyS0ZINGs2NzhNcWxYbFExU0xLZ3FaWEFPRyts?=
 =?iso-2022-jp?B?K2RsK1dtdFdUeE9ocWFJQlp3R28zeTRNbkwxQVczZXFxeHpyZ1QyejdG?=
 =?iso-2022-jp?B?QTdOSlBoZTdNQ2NmQUI2c3dRZytvNi9OQ2hvPQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84f65cd-f588-4746-1325-08dc9c1dae0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 11:37:26.7320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x7JO69whMiGZXJ012+GviZx8NJmGxSIHcQKGixQrw0g3rMLsTptGVcePC6qza26TI66mqI1WcSzmt9bFo5JrpIzP3aVN0R3mw/OpPtWVQGOJMFPZvUITPgTpC8A6ZBos
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9316
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Jul 2024 11:37:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16373

Hi Jan,=20

Let me explain the reason behind this patch.=20

My understanding is that the security image should include SWUpdate and Sec=
ure boot features by default.=20
Re. https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/b95e256a=
5b05f87aab48b7bf3e7e4d8d45566ad3=20

I found there are some minor issues as below,=20

1. In the current menu when security extensions is selected, SWUpdate is en=
abled by default and secure boot is disabled.=20
If I build with security extensions option, the build system is creating th=
e image with secure boot enabled along with SWUpdate. The reason is securit=
y.yml internally includes "kas/opt/ebg-secure-boot-snakeoil.yml" kas option=
 file. It is creating the wrong impression that the secure boot is disabled=
 in the menu but in the final image it is enabled.=20
So that is the reason, the secure boot is also enabled by default for secur=
ity image now.=20
> IMAGE_SECURITY
>  	bool "Security extensions"
>  	select IMAGE_SWUPDATE
> +	select IMAGE_SECURE_BOOT

2. In the current menu, there is no provision to select secure boot option =
without security extensions. It will show only when security extensions is =
selected.  =20

The patch changes will help to fix these issues.=20

On top of my changes I confirmed things like,
- SWUpdate and Secure boot options are visible along with security extensio=
ns option in the menu.=20
- User can select SWUpdate alone and  SWUpdate + secure boot features=20
- SWUpdate and Secure boot features are enabled by default for security ima=
ge   =20

> -config KAS_INCLUDE_SWUPDATE_SECBOOT
> -	string
> -	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
> -	default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT

While testing locally it was adding same .yml file multiple times to the fi=
nal .config file which is not necessary, so I removed this structure to fix=
 it.   =20

Kindly check and let me know your view on this.=20

Thanks & Regards
Shivanand K

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Jan Kiszka via lists.cip-project.org
Sent: Thursday, July 4, 2024 3:38 PM
To: kunijadar shivanand(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <Shivanand.Ku=
nijadar@toshiba-tsip.com>; cip-dev@lists.cip-project.org
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =
=1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev] [isar-cip-core] Kconfig: Refactor Kconfig options

On 04.07.24 11:18, Shivanand wrote:
> The security target should include both SWUpdate and Secure boot=20
> options by default, so add the missing secure boot dependency in the=20
> security option. Also enable kas-container menu in such way that user=20
> can select individual features without security option.

This is too unspecific.

>=20
> Signed-off-by: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  Kconfig | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>=20
> diff --git a/Kconfig b/Kconfig
> index 96f590a..f73c8f2 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -163,11 +163,25 @@ if !KERNEL_4_4 && !KERNEL_4_19  config=20
> IMAGE_SECURITY
>  	bool "Security extensions"
>  	select IMAGE_SWUPDATE
> +	select IMAGE_SECURE_BOOT

Why is this change along not enough?

>  	select IMAGE_DATA_ENCRYPTION
>  	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM ||=
 TARGET_X86_UEFI
>  	help
>  	  This enables security, encryption, secureboot and swupdate for IEC 62=
443-4-2.
> =20
> +config KAS_INCLUDE_SWUPDATE
> +	string
> +	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE
> +
> +config KAS_INCLUDE_SECURE_BOOT
> +        string0
> +        default "kas/opt/ebg-secure-boot-snakeoil.yml" if=20
> +IMAGE_SECURE_BOOT
> +
> +config IMAGE_SECURE_BOOT
> +        bool "Secure boot support"
> +	select IMAGE_SWUPDATE
> +        depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 ||=20
> +TARGET_QEMU_ARM || TARGET_X86_UEFI
> +

Inconsistent indention.

>  config KAS_INCLUDE_SECURITY
>  	string
>  	default "kas/opt/security.yml" if IMAGE_SECURITY @@ -189,15 +203,6=20
> @@ config IMAGE_DELTA_SWUPDATE
> =20
>  endchoice
> =20
> -config IMAGE_SECURE_BOOT
> -	bool "Secure boot support"
> -	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM ||=
 TARGET_X86_UEFI
> -
> -config KAS_INCLUDE_SWUPDATE_SECBOOT
> -	string
> -	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
> -	default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT
> -

These structures and dependencies exist for reasons. My feeling is that you=
 are breaking things, but maybe you just need to explain better what you wa=
nt to achieve (besides enforcing secure boot for the security image).

>  config KAS_INCLUDE_DELTA_UPDATE
>  	string
>  	default "kas/opt/delta-update.yml" if IMAGE_DELTA_SWUPDATE

Jan

--
Siemens AG, Technology
Linux Expert Center



