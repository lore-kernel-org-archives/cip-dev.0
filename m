Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D123CC83F1A
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 11:36:12 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.66])
 by mx.groups.io with SMTP id smtpd.web10.18741.1752838568763674825
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jul 2025 04:36:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=u1c2Q6U0;
 spf=pass (domain: siemens.com, ip: 52.101.70.66, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfjOPOX4hZVEZFRhixIT/PVK7JNTvMIDz8LEizL1utJtKUqLJ+Pum/KJUrNoqk6Tb0VSNyVmQjGhW1WKMoZ3FfiJBmKiQKOa+GfiwwUy9bnrqwHCUyI2+uonab/WSIhYiq6joH4/F0yCIa0c9a71GhAlusce3k21LVLHmuWGLpuM/w44M1zjOHST7l5xnL9eLbrX1c8F6vec+7SdqfMK84vcmDpi2DlivBpvFeYP6805hLIeF5jti36lxBvxhN6Phm3i88Yr8VnJJqFISmREQCjjl2tfdcBCgAEXNTjETksxiT3w4dmcjI7dei6/1sXOKT28Y+iY6NFKdwfhUBVeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAbALfuCp93Eok8cUhR/EAexz4DzKZ9KorbmynO663U=;
 b=nTN4PE8vJ87pIBt7dKA5872zSbLIiVGqeBZqUK9qeXVJMkmAMcHI0ZffS9pO8e0P7VZueAYAPOmj9pd+q4K5fSQZYAg4rughCarFZ9FkkCk2HLfjynPvSfuTQxddS3L74t+HhL2nNNXWH0K8m3df5midHHYoXbl3BXDeSzOdrxJmMg8kZ3SecNdz/z0CqrVSThC9pwG8mPpIkk4YzCgpvTbKRaHFxCfVZvnA96xTO1WE+eanrQ6QGd4wkuRW6KkQht+2w8rONH3wDznF1NeobtsAWsjvuy/l0+G0Ioobzt0bBf+AQz3QNmr14JVY6+RfxO17/aIG1/yo+Yxj96U8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAbALfuCp93Eok8cUhR/EAexz4DzKZ9KorbmynO663U=;
 b=u1c2Q6U0Y3lURAnbKjY2zkeQUNEh39krC/xvJFtiPFFjmfCyc9keYXKiAz1sEIP7k6HNw7MJRhbGv2yZbu05WVh5Cq7kmT6sOL+NiyER6aCFdryvleunctlTigeEwnRD3wPsSUHh62j8z0EvS4phzel+j32yVm22I/O+PBi2YmAV6jWcdP/gA7FgJqwByK6jF8lNBg9Cu9bkuyIsbspcGHqu5f3oM3zW5RhzJ7YUWJ2hnvj2vQBCKP4EkRJhbjTNspui3FTjnQBnRgyasQemRuzqkLBei1q5nZ8Qnb23KIn5TpDDuG4wMfgO0yhJDv7Xfndi7h13e2sa+5+7RlqmWQ==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DU0PR10MB6558.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:405::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 11:36:05 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%5]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 11:36:05 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>,
	"cedric.hombourger@siemens.com" <cedric.hombourger@siemens.com>
Subject: Re: [isar-cip-core][PATCH 2/2] immutable-rootfs: disable daily
 package update checks
Thread-Topic: [isar-cip-core][PATCH 2/2] immutable-rootfs: disable daily
 package update checks
Thread-Index: AQHb98zppggqiq5MtEeFTTCgOgKoXrQ3u3YAgAAFOQA=
Date: Fri, 18 Jul 2025 11:36:05 +0000
Message-ID: <1fdb1d29524875f932d8b894b3904eecbba13190.camel@siemens.com>
References: <20250718101525.1270424-1-felix.moessbauer@siemens.com>
	 <20250718101525.1270424-2-felix.moessbauer@siemens.com>
	 <816a6e9c-9d3b-4cfa-a2f4-6cd685cde9df@siemens.com>
In-Reply-To: <816a6e9c-9d3b-4cfa-a2f4-6cd685cde9df@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.1-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DU0PR10MB6558:EE_
x-ms-office365-filtering-correlation-id: a3fa18f9-3969-4209-15d7-08ddc5ef480d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?N2kvUzBRS0Q3YXZtVFFNeG5FTHhISndPNkhGUVZUSnEzMStUdHBRL2p4eUpm?=
 =?utf-8?B?VzhDa1ZDbmNTQzYvSmRJSXo1THpCeWNkUTdIVWsvUHR5aWJWSkx4b0F6ckQ5?=
 =?utf-8?B?MFNZckVUanNYZU9QR3J4MWpnQTJWSENWRWwrZWIvMGxSbjNHb3l2QkEzRFpx?=
 =?utf-8?B?dHQwL1hJdU1VSlRIM2VoTXcrY1lHRGxZNFc2TFRRbE91N1V2MFJ1ZGZNRXJZ?=
 =?utf-8?B?dCtzNmpGU3hIZHA2eS9kMUtWa2pLbGxRaUtOV0E1SUgyajdKY003a0VHd2tq?=
 =?utf-8?B?SzUvODVnVVZpUjJxdGVraXVlT3htNUtkMzUwK29JelpYeEZjQUJDSzRvSjFJ?=
 =?utf-8?B?V2N5SUxXVndteHh1WmVaODYxcmJQYWZuQ0huYk1vbVErcGdFalk4a1ZRbVNm?=
 =?utf-8?B?blY1WmFvQ2tidURYQ2xBMVlwZHJJRm55VU9aOU5zbVkydENTMHBiK1VUOHN2?=
 =?utf-8?B?Z3hJeVlLdmJLY3pBaVVIVmh3OUd0ZUlJNXc0OCs0bFFmRTZxcENqYzk5MWFZ?=
 =?utf-8?B?ZVA4Wi9DTFNFKzh5L01KUDhBb0MyTnJZQllIYXJQWS9qOGN2TmtzQkI2NEFv?=
 =?utf-8?B?Mms0OTYvMUJldm9ZYktWc1UyWHczM1V2RkNaWnNMRnRUcldrYUs5TzRPdDYy?=
 =?utf-8?B?VUsyNGk3aElteXBxbDZHeXc3akEvVmpvdnpRb1FZVko1R01Xd3dvRDRISFdD?=
 =?utf-8?B?QjVJSzc3bEFPSlN6aFU5UENvYUhJS3MvR0QvbERkNHc3N05JYTdXdERjSUds?=
 =?utf-8?B?d1JVOWtTbUxGblN1QUt2dTVHRWlmNzFRbTd6Z0FUb1RhOXp6SGVQTWVxUjNE?=
 =?utf-8?B?dHBOSUQxRnFUSVFyMnpDcVZvRlZEQVl3b0RxdDhEcklVd0RkQlJPNkVheTBK?=
 =?utf-8?B?ZDk5Zk9Kb29yQzhBbkhyZmN2UHVCS0R3YTIxVEMwck1EWHB3SkRSbHU3cGNn?=
 =?utf-8?B?dHdidjh1aEtLQXhHWlB1WnI3SEJHSVJUUzdNTW5DSG9vdFhKa3pDa29kL1FV?=
 =?utf-8?B?OUQ0bzZKVHpyeVZ3R045NkU2S3ZjcDJ3OVFEQ1dRb1JjTjJJcHlDSmhDVzBH?=
 =?utf-8?B?a1lOTWhQWHdWUGNMdXdESjBqbm9mSmhrZjZMb1J0THFxbEVCaENOWFVTelQr?=
 =?utf-8?B?NTdvUFdzOUZZTThwSXRxeG5jYXlERHFNUXdEQTc4SVh4QWZYZTYzOCtYMFBY?=
 =?utf-8?B?RUhzdG15WERtR0ZqMHN4L2c4VHJCSjFJeW1Fb2NGU3kyekNiNWpiSDNtcmpG?=
 =?utf-8?B?alZZSUpMTlZQUGQzQjhqTmdaUGhPcW5VekhvZ2pubWY2S3lIdVBoSVNjOXB2?=
 =?utf-8?B?dWE4akFpTHU1a3hnL2hqaEpXYlJJeVU5UUsvL3BvQVBaRkFDY3NCbVNhVWpG?=
 =?utf-8?B?ZUpxNDB1am56Z21zMjJveGQrbTVFYzFmd1RvdTN0alNNbFF0OEM1U2xrS0dG?=
 =?utf-8?B?MTdQNEs1RWNQVEtMQ2w1ZVo4ZVVIQ3dwcFZOMGN3eDRWejJJSzdyRVlWeUpY?=
 =?utf-8?B?NGVaYjNvRExOd3RnZnpMbUpsNVQvaEh2eGR1TS95c2JsalhJaGxGNGZyMHhF?=
 =?utf-8?B?UGFEaFFZOXVBYUozR1BIemJtR2xGOEVTa3c1ZVp5WE54bjVESi9MSXZyQmVF?=
 =?utf-8?B?YUkrLzdSSDR3N2pvZ3NHTFJFM01hK2RVS2xqL3U0VW1JSVBmK3RsZTZqWHNN?=
 =?utf-8?B?SVNFNXRuMFZSRW50MGMzd0YvRmFxZitHcmhtZFVGbFBkQzVyMStFc2hJL0RC?=
 =?utf-8?B?dEZHS0U0eWIxbmdtUnhsVlhjdXRlc2wycnFNTmV3d3daZkNGT3cvaVl6Z1dE?=
 =?utf-8?B?Mm9mYnQ3aC80Zm0xRS9UdGJpZ3puM2w5T0YxZTFBMVJNNXZKZGI3VCtvVGc4?=
 =?utf-8?B?d1MrdkJMVnd4L3puMmRaL2c5WmVXaXl4R1BzNDZNOU0vRUsyOXJwcnJIZ2dE?=
 =?utf-8?B?eFlDVXpxV0ZhLzNoT0E2R1U3Wk8rT3A3RjVrVC90UlRRSHNHRzVvQ2NFR0Vq?=
 =?utf-8?B?QUFvRld1MEZBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RkNKZXlQTzJVT1JLSUpSQk5td1VjSUxRYnZrSnNIVWs3WnhHaXphVlRNTEVx?=
 =?utf-8?B?cFlMUWxLdCtkT3cyMkdtdE1vMGRxZWV4UXYrWkx6SXdjYWdFZWlrbUVjTFdQ?=
 =?utf-8?B?NHlNUWg5MkcwdzlyUTRxbVdvakJvQTE5M2oyclV2N3VTSlNXeVFETGllcG9C?=
 =?utf-8?B?OUMyMUZsQnVCeFpQNjJza3djY1BQTy9tcE1XZGxaUC9FMnpjY25udnpDVGg3?=
 =?utf-8?B?STlqVmQwZ0lhWE5mbFFLVy9jSHlGT0ZYSlZVL1o0c1Ivbi9qellWWlFHak5t?=
 =?utf-8?B?amVvRFN5UkMxSXFpN2dBVFJMUE8vRGxSd1JMM1V3cDVUZVJRbnU4cHdxRkUv?=
 =?utf-8?B?WlVQSm5DZW9wc21xVms0VDIzdXBmenhWWXB5eis5NXFvMzRPMWNUUy82RU9T?=
 =?utf-8?B?OGg1bzdLbWVsT3BJK0VDa1Z5VXdPQklQQkkzRUlPcjFxUjRSQ1VPZERzQzFL?=
 =?utf-8?B?OEE0Mk1rM1BDVTRobk85UE4rYWtGTmJIYzByWllUL3VLVFNja3p6NFFnUDBY?=
 =?utf-8?B?aUxXRVV6U08vSkdadlNDUXd3WXUrVThnRlRtQVRySnplSFZ6Tk92M25ITzB1?=
 =?utf-8?B?ODZMd2ZjdW5aVENNamVXUy85YzVVM0ZnZUpEQng3M1VTVlNiaG9OU3NiYVRQ?=
 =?utf-8?B?czN0YUt1a0lZOUJLT05Ua3RmOEpMOTkxQkF5aHBFUnVHYjRNSnRubTVWU09O?=
 =?utf-8?B?TTZDaDAraGdVQ2dMOTNwY3RlcVFpYVdBNEw0eGZnWDRZZkxaYjdnT09tUFZN?=
 =?utf-8?B?TmNsVlVaQzFzRjNuTmdVMnNkNFVTZ2t3anVKYW5ON0lBelhIMjcrOW45ZUxi?=
 =?utf-8?B?RmdOUC9aN2tuelp5NGJIMzB5M0dEeTBrVU1UK2x3TndjNVVBcHlpWG9CbjJv?=
 =?utf-8?B?Q0hheWQyMXBpWnpTRGxiLzNiaGdZUGJmdVU2ZnZocmlhamNNUFRMc3gxbDdO?=
 =?utf-8?B?b2RrdlFPN210djl2ajVEZUoxa0s0T1NoZlliWFU1K3JaMm1KcC9LU3BOWUFT?=
 =?utf-8?B?UytDSHhpcjJqNys2dGQ4MmVMa25JK2FjK0tDeWdwMThiQUd5cnFpRkZzWVpX?=
 =?utf-8?B?dTFCWVBhb0hLVWc3R0FNSy85Mkg2VWR3cjhERktuZWcwN1RlK1A0dHhPWlRu?=
 =?utf-8?B?TGVvOU9wRHdyT01YM1BBbHNFcGlOZ1FmTmg3YXFQQkQ0SDN6dkFvNkhFTDZL?=
 =?utf-8?B?VXdQQk0yRlE1UW1zWmtndlhiakJFc1c5ZUpVZzBVUnlxOWpPckdYZDN0WVQz?=
 =?utf-8?B?QTh2aTA2L0Uvbm1BV2txdnNXVUN0aGlqN29YYjNINTdNMEU2dDR1bWhkY0Ju?=
 =?utf-8?B?ODNiYzNRUlNnT2JML0dqM0JJUlpwNW53YldmMVNTc2lLTnVpVzJBYVBMRzZD?=
 =?utf-8?B?K1VSV2VyQjVES2lpUkl5YloyMms5dXdCRTkxcWE3VHpKL3lFVkk1aDRVcitY?=
 =?utf-8?B?WjlHYy80OXdrM2RmYlE2ZXcvZUFSNWZXdTd2Y2Q5RDd3dWh1UWtBdVI0cHl3?=
 =?utf-8?B?VUxybDk5alRsc1ZzTWg4cWZCOUFpY3N3U3pnbkoreE04U21TL1Noc1hHc21u?=
 =?utf-8?B?TEZSTU56MnVCQW52UlFjL1BScDhtbUNqWmRBeWZVM0R1TGR3VHBkeWhmMEdu?=
 =?utf-8?B?aDd1dFdGOWNpWXJyTnBDNzVUWHNtTWNOak1mUFZuczFqbTZpYXlqSWQ3amYv?=
 =?utf-8?B?c0xhaHVrK0dhcGhoVy9DUGgzVWc0NlhGQVh2K28rZFVFNG96RDUrd3EvVlIr?=
 =?utf-8?B?eDlyL1k2UGdmWUI1N3dyUE9mUExQcjhjN0RxWHo0M3hCU0IxZUtwM09mdUo2?=
 =?utf-8?B?d01neFk0N2RWMUlLcDk5VFhTbkdyckZVWXVqY2hJNWg1Z3JwdHZWNHVhSndw?=
 =?utf-8?B?TFFHbTExWHVJWlEwVEN1dkVRTFcxYkROVFNNSXRsbnVrMFBOZ1BsdUc4c1Ju?=
 =?utf-8?B?U0tpUmpYalFPZ3hqR29OYjZ4TUF0bUdOS2tXNEczaUZVVUNFcmIzV3JEWXRH?=
 =?utf-8?B?cTR0Vm52N2dkamJiVlV6N20vY09IdS9yZlNzZ1dGK29oYW1WQlNWY2d4eFov?=
 =?utf-8?B?S0thYUl5MEhFSGtkSWFDenRaUVNGc1NlaHVEYWhqVERPNW1XWU1FSGFpN3N4?=
 =?utf-8?B?MlJER0FyaGlHeUlWY252cWJGMjhzK0pMWFZIT3ZCc2dDVTF5NTZOdXZxeW1C?=
 =?utf-8?B?UFpWdjB6SXRheFJEQ2RFT0RRVWR3cHpXQklNVHhoYzBkTE05dVVsbTE1dkdi?=
 =?utf-8?B?OE1pOU81ckpDUi9QSXh2WmRUZDB3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03F11A466C29D043A7221D35E7C9DBFB@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fa18f9-3969-4209-15d7-08ddc5ef480d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 11:36:05.2513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y+F7dhwo7HXLpe2PfjcC69StVWnKggxbnrlPy9837uKhcRRoDSA3I5Kml6dmOf48tknXHiBnPFt650esdo0QF3OffpkR+w4edcf08kGFYFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6558
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Jul 2025 11:36:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19567

T24gRnJpLCAyMDI1LTA3LTE4IGF0IDEzOjE3ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxOC4wNy4yNSAxMjoxNSwgRmVsaXggTW9lc3NiYXVlciB3cm90ZToNCj4gPiBXaGVuIHJ1bm5p
bmcgb24gYW4gaW1tdXRhYmxlIHJvb3Rmcywgd2UgZG9uJ3QgYWxsb3cgcGFja2FnZQ0KPiA+IHVw
ZGF0ZXMuDQo+ID4gTm9uZXRoZWxlc3MsIGFwdCB0cmllcyB0byB1cGRhdGUgdGhlIGRhaWx5IHBh
Y2thZ2UgbGlzdCBhbmQgdXBncmFkZQ0KPiA+IHNvbWUNCj4gPiBwYWNrYWdlcy4gVGhpcyBpcyB0
cmlnZ2VyZWQgYnkgc3lzdGVtZCB0aW1lcnMsIHdoaWNoIGFyZSBib3RoDQo+ID4gbWFudWFsbHkN
Cj4gPiByZWdpc3RlcmVkIGluIC9ldGMsIGFzIHdlbGwgYXMgZGVwbG95ZWQgdmlhIHN5c3RlbWQg
dmVuZG9yIHByZXNldHMuDQo+ID4gV2hpbGUgaXQgYW55d2F5cyBtYWtlcyBubyBzZW5zZSB0byBy
dW4gdGhlIHVwZGF0ZSwgaXQgYWxzbyBtaWdodA0KPiA+IGZhaWwNCj4gPiBmb3IgdmFyaW91cyBy
ZWFzb25zLCByZW5kZXJpbmcgdGhlIHN5c3RlbSAiZGVncmFkZWQiIGFmdGVyIHNvbWUNCj4gPiB0
aW1lLg0KPiA+IA0KPiA+IFdlIGRpc2FibGUgdGhlIHRpbWVycyBhbmQgYWxzbyBkaXNhYmxlIHRo
ZSBkcGtnIGRhdGFiYXNlIGJhY2t1cCwgYXMNCj4gPiB0aGUNCj4gPiBkYXRhYmFzZSBpdHNlbGYg
aXMgYWxzbyBpbW11dGFibGUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRmVsaXggTW9lc3Ni
YXVlciA8ZmVsaXgubW9lc3NiYXVlckBzaWVtZW5zLmNvbT4NCj4gPiAtLS0NCj4gPiBQUzogSXQg
aXMgdmVyeSB1bmxpa2VseSwgdGhhdCB3ZSBjYXRjaCB0aGlzIGtpbmQgb2YgZXJyb3JzIGluIG91
cg0KPiA+IHRlc3RzLA0KPiA+IGFzIHRoZXkgb25seSBzaG93IHVwIGFmdGVyIHJ1bm5pbmcgdGhl
IHN5c3RlbSBmb3Igc29tZSB0aW1lLiBXZQ0KPiA+IGZ1cnRoZXINCj4gPiBkb24ndCByZWxpYWJs
eSBrbm93IHNldmVyZSB0aGUgaW1wYWN0IG9uIHByb2R1Y3Rpb24gc3lzdGVtcyBpcywgYXMNCj4g
PiBzdGlsbA0KPiA+IG1hbnkgZG9uJ3QgcmVseSBvbiB0aGUgb3ZlcmFsbCBzeXN0ZW1kIHN0YXRl
IChlLmcuIHRvIGJsZXNzIGFuDQo+ID4gdXBkYXRlKS4NCj4gPiANCj4gPiBGaXJtd2FyZSB1cGRh
dGVzOiBUaGlzIHBhdGNoIHdpbGwgYWxzbyBjbGVhbnVwIHRoZSB0aW1lcnMgb24NCj4gPiBkZXBs
b3ltZW50cw0KPiA+IHdpdGggYW4gL2V0YyBvdmVybGF5IGJlY2F1c2U6DQo+ID4gDQo+ID4gLSB0
aGUgdGltZXJzIHByZXZpb3VzbHkgZ290IGluc3RhbGxlZCBieSBkZWJpYW4gLSBoZW5jZSBhcmUg
cGFydCBvZg0KPiA+IHRoZQ0KPiA+IMKgIGltbXV0YWJsZSByb290ZnMgKHRoZSBsb3dlcmRpciBv
ZiAvZXRjKQ0KPiA+IC0gdGhlIHN5c3RlbWQgcHJlc2V0cyBkaWQgbm90IGluc3RhbGwgdGhlIHRp
bWVycyBiZWNhdXNlIHRoZXkgd2VyZQ0KPiA+IMKgIGFscmVhZHkgaW5zdGFsbGVkIC0gaGVuY2Ug
dGhlIGZpbGVzIGFyZSBub3QgY3JlYXRlZCBpbiB0aGUNCj4gPiB1cHBlcmRpci4NCj4gPiANCj4g
PiBCZXN0IHJlZ2FyZHMsDQo+ID4gRmVsaXgNCj4gPiANCj4gPiDCoC4uLi9maWxlcy85NS1kaXNh
YmxlLXBhY2thZ2UtdXBkYXRlcy5wcmVzZXTCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDMgKysrDQo+
ID4gwqByZWNpcGVzLWNvcmUvaW1tdXRhYmxlLXJvb3Rmcy9maWxlcy9wb3N0aW5zdMKgwqDCoMKg
wqDCoMKgwqAgfCAxMg0KPiA+ICsrKysrKysrKysrKw0KPiA+IMKgLi4uL2ltbXV0YWJsZS1yb290
ZnMvaW1tdXRhYmxlLXJvb3Rmc18wLjIuYmLCoMKgwqDCoMKgwqDCoMKgIHwgMTENCj4gPiArKysr
KysrKysrLQ0KPiA+IMKgMyBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgcmVjaXBlcy1jb3JlL2ltbXV0YWJsZS1y
b290ZnMvZmlsZXMvOTUtZGlzYWJsZS0NCj4gPiBwYWNrYWdlLXVwZGF0ZXMucHJlc2V0DQo+ID4g
wqBjcmVhdGUgbW9kZSAxMDA2NDQgcmVjaXBlcy1jb3JlL2ltbXV0YWJsZS1yb290ZnMvZmlsZXMv
cG9zdGluc3QNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL2ltbXV0YWJsZS1y
b290ZnMvZmlsZXMvOTUtZGlzYWJsZS0NCj4gPiBwYWNrYWdlLXVwZGF0ZXMucHJlc2V0IGIvcmVj
aXBlcy1jb3JlL2ltbXV0YWJsZS1yb290ZnMvZmlsZXMvOTUtDQo+ID4gZGlzYWJsZS1wYWNrYWdl
LXVwZGF0ZXMucHJlc2V0DQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAw
MDAwLi43ZTZlOWVmDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL3JlY2lwZXMtY29yZS9p
bW11dGFibGUtcm9vdGZzL2ZpbGVzLzk1LWRpc2FibGUtcGFja2FnZS0NCj4gPiB1cGRhdGVzLnBy
ZXNldA0KPiA+IEBAIC0wLDAgKzEsMyBAQA0KPiA+ICtkaXNhYmxlIGFwdC1kYWlseS50aW1lcg0K
PiA+ICtkaXNhYmxlIGFwdC1kYWlseS11cGdyYWRlLnRpbWVyDQo+ID4gK2Rpc2FibGUgZHBrZy1k
Yi1iYWNrdXAudGltZXINCj4gPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL2ltbXV0YWJsZS1y
b290ZnMvZmlsZXMvcG9zdGluc3QNCj4gPiBiL3JlY2lwZXMtY29yZS9pbW11dGFibGUtcm9vdGZz
L2ZpbGVzL3Bvc3RpbnN0DQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAw
MDAwLi5hNmUxOTYyDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL3JlY2lwZXMtY29yZS9p
bW11dGFibGUtcm9vdGZzL2ZpbGVzL3Bvc3RpbnN0DQo+ID4gQEAgLTAsMCArMSwxMiBAQA0KPiA+
ICsjIS9iaW4vc2gNCj4gPiArDQo+ID4gK3NldCAtZQ0KPiA+ICsNCj4gPiArIyBUaGVzZSBzZXJ2
aWNlcyBhcmUgaW5zdGFsbGVkIGJ5ICJhcHQiIHRvIGVuc3VyZSB0aGUgc3lzdGVtDQo+ID4gcmVj
ZWl2ZXMNCj4gPiArIyB1cGRhdGVzLiBBcyB3ZSBkb24ndCBhbGxvdyB1cGRhdGVzIG9uIGFuIGlt
bXV0YWJsZSBzeXN0ZW0sIHdlDQo+ID4gbmVlZA0KPiA+ICsjIHRvIGRpc2FibGUgdGhlbS4NCj4g
PiArZGViLXN5c3RlbWQtaGVscGVyIGRpc2FibGUgYXB0LWRhaWx5LnRpbWVyDQo+ID4gK2RlYi1z
eXN0ZW1kLWhlbHBlciBkaXNhYmxlIGFwdC1kYWlseS11cGdyYWRlLnRpbWVyDQo+ID4gK2RlYi1z
eXN0ZW1kLWhlbHBlciBkaXNhYmxlIGRwa2ctZGItYmFja3VwLnRpbWVyDQo+IA0KPiBXaGF0IGlm
IHNvbWVvbmUgZG93bnN0cmVhbSAoYW5kIEkgaG9wZSBldmVudHVhbGx5IGFsc28gaW4gaXNhcg0K
PiB1cHN0cmVhbSkNCj4gaGFzIGRyb3BwZWQgZHBrZyBhbmQgYXB0IGZyb20gdGhlIHN5c3RlbT8g
VGhlbiB0aGlzIHdpbGwgZmFpbA0KPiBhbHRob3VnaA0KPiBpdCBzaG91bGQgcmF0aGVyIGp1c3Qg
YmUgaGFwcGlseSBkb2luZyBub3RoaW5nLg0KDQpkcGtnIGlzIGFuIGVzc2VudGlhbCBwYWNrYWdl
IC0gc28gZHJvcHBpbmcgaXQgaXMgdW5kZWZpbmVkIGJlaGF2aW9yDQpmcm9tIERlYmlhbiBwZXJz
cGVjdGl2ZS4gVGhlIHBvc3RpbnN0IHNjcmlwdCBpcyBydW4gYnkgZHBrZyBpdHNlbGYgYXQNCmlu
c3RhbGwgdGltZSwgaGVuY2UgdGhlIGxhc3QgbGluZSBjYW4gcmVtYWluLg0KDQpJIHdvdWxkIGV2
ZW4gYXJndWUgdGhhdCB0aGUgaW1tdXRhYmxlLXJvb3RmcyBpcyBhIHBhY2thZ2UgdGhhdCBvbmx5
IGlzDQppbnN0YWxsZWQgZnJvbSB3aXRoaW4gaXNhciAtIGFuZCBieSB0aGF0IHdpdGggYXB0IChp
biBmYWN0IGl0IG9ubHkNCndvcmtzIHRvZ2V0aGVyIHdpdGggSVNBUiByb290ZnMgcG9zdHByb2Nl
c3Mgc3RlcHMpLiBJZiBhcHQgc2hvdWxkIGJlDQpkcm9wcGVkLCBpdCBoYXMgdG8gYmUgZG9uZSBs
YXRlciBvbi4gVGhhdCBkb2VzIG5vdCBicmVhayBhbnl0aGluZyBhcw0KZGlzYWJsaW5nIGEgc2Vy
dmljZSBpcyBqdXN0IHJlbW92aW5nIHRoZSBzeW1saW5rIGluIC9ldGMuDQoNCkZvciB0aGUgc2Fr
ZSBvZiBlcnJvciBjaGVja2luZywgSSBwcm9wb3NlIHRvIG5vdCBkcm9wIHRoZSBjaGVja3MuDQoN
Cj4gDQo+ID4gKw0KPiA+ICsjREVCSEVMUEVSIw0KPiA+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWNv
cmUvaW1tdXRhYmxlLXJvb3Rmcy9pbW11dGFibGUtcm9vdGZzXzAuMi5iYg0KPiA+IGIvcmVjaXBl
cy1jb3JlL2ltbXV0YWJsZS1yb290ZnMvaW1tdXRhYmxlLXJvb3Rmc18wLjIuYmINCj4gPiBpbmRl
eCBjODQ3ZjQ0Li44NWY2MTg0IDEwMDY0NA0KPiA+IC0tLSBhL3JlY2lwZXMtY29yZS9pbW11dGFi
bGUtcm9vdGZzL2ltbXV0YWJsZS1yb290ZnNfMC4yLmJiDQo+ID4gKysrIGIvcmVjaXBlcy1jb3Jl
L2ltbXV0YWJsZS1yb290ZnMvaW1tdXRhYmxlLXJvb3Rmc18wLjIuYmINCj4gDQo+IExldCdzIGJ1
bXAgdGhlIHJlY2lwZSByZXZpc2lvbiBhdCB0aGlzIGNoYW5jZS4NCg0KSWYgbm8gdjIgaXMgbmVl
ZGVkLCBwbGVhc2UgZG8gc28gd2hpbGUgbWVyZ2luZy4NCg0KRmVsaXgNCg0KPiANCj4gPiBAQCAt
MTUsNyArMTUsMTEgQEAgaW5oZXJpdCBkcGtnLXJhdw0KPiA+IMKgTUFJTlRBSU5FUiA9ICJGZWxp
eCBNb2Vzc2JhdWVyIDxmZWxpeC5tb2Vzc2JhdWVyQHNpZW1lbnMuY29tPiINCj4gPiDCoERFU0NS
SVBUSU9OID0gIkNvbmZpZyB0byBsaW5rIHZvbGF0aWxlIGRhdGEgdG8gaW1tdXRhYmxlIGNvcGll
cyINCj4gPiDCoA0KPiA+IC1TUkNfVVJJID0gImZpbGU6Ly8ke0JQTn0udG1wZmlsZXMudG1wbCIN
Cj4gPiArU1JDX1VSSSA9ICIgXA0KPiA+ICvCoMKgwqAgZmlsZTovL3Bvc3RpbnN0wqBcDQo+ID4g
K8KgwqDCoCBmaWxlOi8vJHtCUE59LnRtcGZpbGVzLnRtcGwgXA0KPiA+ICvCoMKgwqAgZmlsZTov
Lzk1LWRpc2FibGUtcGFja2FnZS11cGRhdGVzLnByZXNldMKgXA0KPiA+ICsiDQo+ID4gwqBEUEtH
X0FSQ0ggPSAiYWxsIg0KPiA+IMKgDQo+ID4gwqBJTU1VVEFCTEVfREFUQV9ESVIgPz89ICIvdXNy
L3NoYXJlL2ltbXV0YWJsZS1kYXRhIg0KPiA+IEBAIC0yNSwzICsyOSw4IEBAIFRFTVBMQVRFX0ZJ
TEVTICs9ICIke0JQTn0udG1wZmlsZXMudG1wbCINCj4gPiDCoGRvX3ByZXBhcmVfYnVpbGQ6YXBw
ZW5kKCkgew0KPiA+IMKgwqDCoMKgIGNwICR7V09SS0RJUn0vJHtCUE59LnRtcGZpbGVzICR7U30v
ZGViaWFuLw0KPiA+IMKgfQ0KPiA+ICsNCj4gPiArZG9faW5zdGFsbCgpIHsNCj4gPiArwqDCoMKg
IGluc3RhbGwgLXYgLWQgJHtEfS91c3IvbGliL3N5c3RlbWQvc3lzdGVtLXByZXNldA0KPiA+ICvC
oMKgwqAgaW5zdGFsbCAtdiAtbSA3NTUgJHtXT1JLRElSfS85NS1kaXNhYmxlLXBhY2thZ2UtdXBk
YXRlcy5wcmVzZXQNCj4gPiAke0R9L3Vzci9saWIvc3lzdGVtZC9zeXN0ZW0tcHJlc2V0DQo+ID4g
K30NCj4gDQo+IEZpbmUgd2l0aCB0aGlzIG90aGVyd2lzZS4NCj4gDQo+IEphbg0KDQotLSANClNp
ZW1lbnMgQUcNCkxpbnV4IEV4cGVydCBDZW50ZXINCkZyaWVkcmljaC1MdWR3aWctQmF1ZXItU3Ry
LiAzDQo4NTc0OCBHYXJjaGluZywgR2VybWFueQ0KDQo=

