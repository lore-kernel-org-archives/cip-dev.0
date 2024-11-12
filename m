Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF1ED42B86
	for <webhook@archiver.kernel.org>; Tue, 12 Nov 2024 14:09:28 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.59])
 by mx.groups.io with SMTP id smtpd.web10.87277.1731420559845262078
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Nov 2024 06:09:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=E14HOLL+;
 spf=pass (domain: renesas.com, ip: 52.101.228.59, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOdaI0zig5c62uN3BxZ429J/zWelbzWkkouKLaCDbEO1/wHFUxCRaoBMWpMj1/RzPcwMdvITIc2mY+47ZzHQXwQelctVF2st17vC/uDo+edY6UR/qC39bc8t2waXkMhFTn7+MNWsmc7UaEmmcuMDAtLyzNi3x+TLtY3sAbYBnYFB37oRy75x5rmyBhguHWHA7vehQHX603/n4UYk/769zc/Z95GKqXtE8HQUNNwOPm3kZFQ8wv+7xjD+A3clmeLceRIdQuoW3PqJsWDIkJtrSMwK1NX7WqMnVocgjQ/hb1pV1f5r74BrATru3Ootmet6dgNPt5Fh1u50GN8fKZNHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPBuORAt6BZTmm3sGCeYgEgpMtKWlW+V+1Hy4ObVbwY=;
 b=mXOyjfrBK6MdZA6WBhwnTP2VWtWX7RYf66xVKfjTCxqDHv2CEINyP0/BJdZiFF3MavQ/s+OUs780IlMyRrRGd9UfOoFXfdnEFQI4h19Ri6/0zM3T2Uf9dglKnmZLPwtXp05a/CyptC1ITa1rCmad8kzmYdn4gSSmrLfUQBpiQN0zLqH8ynjwR7+dwmzN1+7l7oSiOOziF3IZUueW+XFmPZyc0fbJzSbq1ky1YDjdajApjp9ZtLCKZy9Lnv7aVmfnWZIDj3D53iyuOQFpBRukRWNIy95UATFhvlqEvTSyVzvnv8WPcMSiiCEm1AvR/u+JwLOqp5U5FVzO99M92XQHyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPBuORAt6BZTmm3sGCeYgEgpMtKWlW+V+1Hy4ObVbwY=;
 b=E14HOLL+RH4+NUCIp8RO5ATHaajX0YC1APM1ECxw6lAKOE3wnOZYu+1rA906rPrCgX8r2VhTmcYIGedxodjx4S3Z4qvQiNiPre/wyJoRcVwYu/qScVqbioiIUV0JpACJ+GT8UEyPnRYH/rGsbgempheW2+WuSIIWt/D7eW9EbSk=
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com (2603:1096:405:f7::12)
 by OS3PR01MB8302.jpnprd01.prod.outlook.com (2603:1096:604:1a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Tue, 12 Nov
 2024 14:09:14 +0000
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87]) by TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87%6]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 14:09:14 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
Subject: RE: Manually run Kernel and IEC tests on M-COM x86 and generate
 results
Thread-Topic: Manually run Kernel and IEC tests on M-COM x86 and generate
 results
Thread-Index: AQHbNLcv3vC8deZB0Ua07zkQ6b5nXrKzrb4Q
Date: Tue, 12 Nov 2024 14:09:14 +0000
Message-ID: 
 <TYYPR01MB1240281691D569EB3FFF1BF46B7592@TYYPR01MB12402.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AC4F03F328776A6DFBCBC2592@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6103AC4F03F328776A6DFBCBC2592@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB12402:EE_|OS3PR01MB8302:EE_
x-ms-office365-filtering-correlation-id: 14c779fc-e8e9-4d5b-f22f-08dd03239690
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|4022899009|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZWc5ak04VzRlY25uWW04RHY3TDlvUHEzaDQ5SVYrazRseFlQWGU4OWRl?=
 =?iso-2022-jp?B?Zk9YVWdKNjF5a3c1U1c4V05CRnYxVnJweFU4djY1OG1Eb0ZnSDJoR2sw?=
 =?iso-2022-jp?B?MzNBTVVmV0dVTWRqS05yVS9Tci9tUVRrOEUwOHNnOVdTT2xOVUkrWUZ1?=
 =?iso-2022-jp?B?U3RMd1djWENHWXpNVGxkSzZLOVkwcGxkWk15NE8wRFlwMkJXSzgrWEFT?=
 =?iso-2022-jp?B?RS9Wc1BIaHV3SVY1cHk0bWNnQ3k2ZzE5dG9pTzlzYnR0dVlNWmN0VE9S?=
 =?iso-2022-jp?B?cUVTNGxiYWFnazBjdTNSajY5bjhHcExWeGFhd1JxUGhPZ0VLK1hsVzBZ?=
 =?iso-2022-jp?B?MktoRE9jMUVpeVNPYW9JMThjdXI0Uk1ROHYrWUNvQzRNQlY0TzFtY0tD?=
 =?iso-2022-jp?B?aUc2bmxMUmJoQytzZTc4Tm1jMUZqcUpSUmtDT2lkdW9ZTDZ3V2lHb05l?=
 =?iso-2022-jp?B?VnNpd1h2RWxXSFlmOWpWUHlIcDBsUC9xQktDMjhudnR2YklrMWlaVjlB?=
 =?iso-2022-jp?B?eTZ4QkNKODJLOSs1MnZvZnBpMVlHQVBYYjFZd01qN1Jpa0o5Z2JMc29H?=
 =?iso-2022-jp?B?VjVwbFhlZy9UeU94UE5TTEFyWHMrZklsLzZJYnE3S0lWaVhIcS9wWm9D?=
 =?iso-2022-jp?B?YzlseU04SjJQQTE2ZEI1OFRXc3duQUptRkR0a1p1NzlBQVZUSElveHJZ?=
 =?iso-2022-jp?B?TDhUV2d3QXI3alRWTWN6VTVxMWJ6VmIydUNTSGNVaEFvUDNtVkVjNE8w?=
 =?iso-2022-jp?B?NEx2L2t2cTgvTTgxdEJxUlVMZFRlSTIzRUVLUFY5c0xHRTJOdzNyWVRr?=
 =?iso-2022-jp?B?ZkU0SUdYUjkrd1JkdUtjY1I1QzVZS2w3V0NBYkYvN0NyZG5DQUt3bTJI?=
 =?iso-2022-jp?B?T0tsYllWK3MxbjNwUDhRSS9PYkJGd0E2cDRoTU1EMHNwNHpma0hNUm92?=
 =?iso-2022-jp?B?Uzk4N3EzNE1FVUdBNThCTWJqSTQ3ZmEybGgyTUtkbGxkU1NJZFpLS1dy?=
 =?iso-2022-jp?B?Wjd1NElzRVh2N2JaWE1PbW9aZGlJVGdGSEtpYjdqVG1qV0VIb2dNajRX?=
 =?iso-2022-jp?B?TDErT3pQQm1nSHYzODU3VmJQNlNZMHNaZUFOTDc2U1lHTGJWeFdPQ0dt?=
 =?iso-2022-jp?B?MXkwSlFZT3VjQlhCcnBvWVY4c2M2dlpDUUFBMk1tci9aemZnTXNieHZm?=
 =?iso-2022-jp?B?eFIwT2Vpbm9BZms1MDRNUGZtMGRtMUY0R09XZVpsWnloUWNzVUY0aGEx?=
 =?iso-2022-jp?B?SDFMSnJFa3g5RUU0bmg1ckdKd0Q4SW5PeHBqZUIxR01DRjZ4ZEx5YkNy?=
 =?iso-2022-jp?B?NUM0eStscFcxd2VOeVlOL3JIL2EwbisyRHFLQTQ5SHF1WXd1b0NaeStz?=
 =?iso-2022-jp?B?aWFNbkpoSnV4YkljTWQ0eU9GUTNBVUhGLzV1OEhjODRsWlp0QkhnemNY?=
 =?iso-2022-jp?B?Y3RxOHVsWkcxRi9xSWxQZzFrV3hRK0JSNjdTRElpL3FlZDdqOWQ2YlFs?=
 =?iso-2022-jp?B?MzFQWGpkZlVVQU1CYTR4WWxWS0ZlOGl3Q2pIQ3JtRWhJeXR6cjBIcXkx?=
 =?iso-2022-jp?B?T1lUZ2V3YjI5RE1LQ0tUNE01R2V3SzViYUpxZkd5WlVnVUxtUlNMZWtX?=
 =?iso-2022-jp?B?WC9uUmc0UEw3L3ZYSmw4SG1XWXRxYnFzbVNyc3NPYlgxLzFLMjl5dUhi?=
 =?iso-2022-jp?B?MjR2MFlKM0V4a1BLK2V5a3hYekdBN1laWXNWeUNJSWY3ZWxpTTZ0TGZJ?=
 =?iso-2022-jp?B?ZHdjU1hGcC9IL1NJdlAvMTUybXFNQ1BJdjl2S2ZyRmdZSUxtZWIxQWhs?=
 =?iso-2022-jp?B?OUlnSkxkNE1rZVU3TVRWdThNVHgxbGZzdmhYZmhrZVlGRUNEVDlWQU9l?=
 =?iso-2022-jp?B?Nmt2MlhkUjlPYjhkY1BXWVdlbkRYeHlUbS9nT3BucDZOWitHbU42Z3BV?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB12402.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ekd1THY4dFdid3hWWkEvUGM0UGdDbVJPY3dVdVFXU0pXc3M5dlZKbFVa?=
 =?iso-2022-jp?B?dS8vNkdoUUk5WlowbmlOV1hMbmQvdS8zUXVZSDUxanNpcDVhMTVpYXZ5?=
 =?iso-2022-jp?B?MFJQSkdEMFY4R3F4RUNiRks0OUpWZm5CTUM4SmVQYjd2Q0hrVzhzWEk0?=
 =?iso-2022-jp?B?ZTNnbXkrTkkyNkl6RlJrVllHVlRDQlZRMUluNnlpYVhSVUZzcGY3T2hX?=
 =?iso-2022-jp?B?Sks2OEt6SVQ3WVJnV1pQU2x2Ylo5ZGxKT1ZSaTNHekJ2akx4VHYxdm11?=
 =?iso-2022-jp?B?TitNdy81VTZHS2ZKekxrSDlERXh3VjlkQ1JIazFEUXZpOFRyRG9qR0xK?=
 =?iso-2022-jp?B?RklFNkROL1J6eUJUNm5oT3Vhd29SMFIxcFloWDlObk1scWQ2RkN3Q2NT?=
 =?iso-2022-jp?B?UGZVOFplTFdkTjkrSUVoS3c3cTVDYVdxaUNRT2RPTExVMHBoTTdvUHpG?=
 =?iso-2022-jp?B?WCtUNU4rQlVIVE5IQjBLV3VSOSszbVU5eDJiaENIejUzV3RLdjRFb0FM?=
 =?iso-2022-jp?B?Mitkd2ZDSFRoK24wZ0pSQ1BKZHlmS3BrRGxWaHhaR3pzZUUvd3ZHbFUr?=
 =?iso-2022-jp?B?cndrNzVvWjIyVVdDRVRWcTNjWUtLZnpOTnI1WWpVWG5aY0hpcFBpekxS?=
 =?iso-2022-jp?B?emNIYllMaVlMdFl4NDByMVN4eU1KdU4xUURyV0J0R2dyTUVWRU80Z2t6?=
 =?iso-2022-jp?B?ZldSaU1YS0k4dVgwWC8xbFQ3VHRsajlpdjNuUExoMG1TNG1lRDdzdWdq?=
 =?iso-2022-jp?B?K2QxRjM4aHBzellvQTRMN2xHT2NvZndiOURPb24zYnZxaVlUZmhKWHdz?=
 =?iso-2022-jp?B?cWFXUzVBN01PSVNSK3JKaVlUbEkxYVQycndRSXQybGlDT3RIc1lOM2hT?=
 =?iso-2022-jp?B?b1ZxSHdjSXVSM2xEZ0xCNDRuVHUzZzNEeW85NTUvaHRQRzNMWUt1MXNL?=
 =?iso-2022-jp?B?OVFwZ3NudmFGSUFwdnE0TnpnbnQrTFRkNDQ5MFVCcjVNNjBBeU1KbW5a?=
 =?iso-2022-jp?B?aUFnUVBlbWNjVkZjMWhmRGhZbGlsOCtXblNBbTN1dWROb2ExMzh2NXlB?=
 =?iso-2022-jp?B?UFhhdEFEeEZUUWgvY05DSEdQK3UydHUrMm5Ra05VTW15TmtNNXE3MU8v?=
 =?iso-2022-jp?B?TjVmRTUvSU9iTm5JaUkveEFnNTYrdlNUUC9oc2szSklvTkRmYkRqRzRq?=
 =?iso-2022-jp?B?VGxFcjJYUGt3Myt6Y2JDNnZ5aFlQOVE5UVlrNVdzdHdXcjBob0pyMWJP?=
 =?iso-2022-jp?B?ZmNzV2V5K3VEUHB5eGxIc3lVSDU4WjZYeng3OVNUSVg1R2NVWFIvTllp?=
 =?iso-2022-jp?B?L3lFZVhvVWtWM0xsQTZKaUorMjAva1Fidlg4aUZTd1NPOTVHZGV2T0VW?=
 =?iso-2022-jp?B?VHJuTkF2c0xvdjREZmhrZVVuaVBiN0RxeUdyVmNJZFdmUTUwZzNQVmhD?=
 =?iso-2022-jp?B?OUpXZGF5VTBBY1dxQUZPWk80UkFWaFc1eVhNK0M5WWFMdVVYRnNIL1Rz?=
 =?iso-2022-jp?B?MjVHaDc2RWJQazNFWlFjRnlVNEdPZWNxcjIzclk3cGp0eFM0WEhwUWkz?=
 =?iso-2022-jp?B?UHhwQWk2aUZLenRySFVCNEtsUFdWTC9MUFFRT3IyTGt2aVRiMFhjOTBG?=
 =?iso-2022-jp?B?eTFFUFJuRm8yVkNHZ0NETDNQTkM3b2ljRFdBRmJ5QmlPeG0rM2ZjZFZj?=
 =?iso-2022-jp?B?b0wyZUxFYU93WGVuZ3hRVmUwYlNoNGtvTkdqUDg2WEdsaW5HMUdqRU1E?=
 =?iso-2022-jp?B?bUNtTG5teUxhTmtqUTBLTFk1Qi8vMm10NE96cC9VS0lzNW5aNmtVVHVr?=
 =?iso-2022-jp?B?UWJOMURGWEhJbVJWUWV6S1dKYm9jVmJrbWNSTTVCU0dodFBPaWd0R1pU?=
 =?iso-2022-jp?B?QjI1cHc4V1ZZc2VpRjBCUXpJZitGdmd3VGNwaVcvMnNSNUhlNTVvVlls?=
 =?iso-2022-jp?B?dVl5WS9udk1ZR2VqNVFPdG9QVkd3OHlSTmg1Q3FPQ2xFRncxbjUyR1l6?=
 =?iso-2022-jp?B?a3BVSGUrSGdOVUw5WlU5SXo2N25NUGVickpWVmNpWWZHQ2N3WEczMDN2?=
 =?iso-2022-jp?B?TnpjcVE5WEh4QjJCMXYzalRrREV2ak43OGpwNHRQWlRrUTM0aHRkTjZZ?=
 =?iso-2022-jp?B?Q2tuR1hueTcwRGx0TG4rZzhoZUsyN2x0bmdEZysyWVNXMy84OHROcjIz?=
 =?iso-2022-jp?B?U2creWM0aFhlWE9MaXZnU25XZFplVjJ6S0g1d0NqeVlPVGZ2SWdxVHcy?=
 =?iso-2022-jp?B?UER0LzdvS3AzSXhFNG1KV3BEZzZnYXl2VG9yL0dWNnYyK2tZd2pHeUoy?=
 =?iso-2022-jp?B?eThGSm1iS0h0dW03RmwwYWp0NWJOTnRVbGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB12402.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c779fc-e8e9-4d5b-f22f-08dd03239690
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 14:09:14.0759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y224FoBZF164a1acPdDQJGjJeGC2Fo65TrCuB+TK00vg0c4sTlV3zZi5cSOPousfSfwe+nlU4qUO3Lg1M400mlKNrbMt9SlZo1M942x+tBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8302
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Nov 2024 14:09:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17241

Hello Sai,

> From: cip-security@lists.cip-project.org <cip-security@lists.cip-
> project.org> On Behalf Of sai ashrith sathujoda via lists.cip-project.org
> Sent: 12 November 2024 04:14
>=20
> Hello Chris,
>=20
> Hope you are doing well.
>=20
> Regarding IEC 62443-4-2 certification, the certification body has asked
> for Kernel and IEC test results on M-COM device. Based on my current
> knowldege, I believe that the test suites mentioned here
> https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-
> /blob/master/submit_tests.sh?ref_type=3Dheads#L55 <https://gitlab.com/cip=
-
> project/cip-testing/linux-cip-ci/-
> /blob/master/submit_tests.sh?ref_type=3Dheads#L55>  shall run for every
> updated kernel image on different CIP reference hardware in LAVA.
>=20
> Since availability of M-COM device on CIP LAVA Lab still needs some time,
> we are manually running each test suite i.e SMC, Smoke, LTP etc. from
> https://github.com/kernelci/test-definitions

As Jan said - we now have one in CIP's LAVA.
If you have issues using it please let me know.

>=20
> There are no issues with running SMC, Smoke tests but while running LTP
> tests it is trying to install some dependency packages to the root file
> system. Currently it shows it is a network issue but even if it gets
> resolved, the packages cannot be installed because the security image has
> read-only root file system.

So you'd either have to use a writable filesystem or pre-install everything=
 into the original image.

>=20
> Another idea which needs to be discussed is, since Kernel tests by name
> means focusing on testing only the Kernel, we can try to use a different
> root file system to run these tests. But this is just an idea, this needs
> to internally be discussed within SWG and with Certification body.

There's no harm in using a different rootfs, or in improving the one curren=
tly used for Kernel testing.
Indeed I believe Iwamatsu-san created separate images for LTP testing previ=
ously anyway.

>=20
> I request you to provide any suggestions regarding the attached LTP
> issues.

You'd need a working internet connection to solve the specific issues in th=
at log.

Kind regards, Chris

>=20
> Thanks and regards,
> Sai Ashrith (T S I P)
> _._,_._,_
> ________________________________
>=20
> Links:
>=20
> You receive all messages sent to this group.
>=20
> View/Reply Online (#2295) <https://lists.cip-project.org/g/cip-
> security/message/2295>  | Reply to Group <mailto:cip-security@lists.cip-
> project.org?subject=3DRe:%20%5Bcip-
> security%5D%20Manually%20run%20Kernel%20and%20IEC%20tests%20on%20M-
> COM%20x86%20and%20generate%20results>  | Reply to Sender
> <mailto:sai.sathujoda@toshiba-tsip.com?subject=3DPrivate:%20Re:%20%5Bcip-
> security%5D%20Manually%20run%20Kernel%20and%20IEC%20tests%20on%20M-
> COM%20x86%20and%20generate%20results>  | Mute This Topic
> <https://lists.cip-project.org/mt/109529918/881120>  | New Topic
> <https://lists.cip-project.org/g/cip-security/post>
> Your Subscription <https://lists.cip-project.org/g/cip-
> security/editsub/881120>  | Contact Group Owner <mailto:cip-
> security+owner@lists.cip-project.org>  | Unsubscribe <https://lists.cip-
> project.org/g/cip-security/leave/8129290/881120/939984059/xyzzy>
> [chris.paterson2@renesas.com]
>=20
> _._,_._,_

