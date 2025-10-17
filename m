Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E165ACCD195
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 08:22:28 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.49])
 by mx.groups.io with SMTP id smtpd.web11.10806.1760689342377910235
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Oct 2025 01:22:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=a7ObQ91T;
 spf=pass (domain: siemens.com, ip: 40.107.130.49, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMdlcq/tzb32ARX2Vpyg6/qA2ZsNSvtjH50Zve8sCny52gJ7BmyLGAQbdcn48lk6nautLBzYmJ/nvSjLgYHNCFKccHWoFrmmqYnky963WAXrmZpkRnDXfI4/f5+uj12QNV8Ay9Dp/7iDZWz4fvuTaV5ue6c5gpLEKoVgEDlQsoQVfO1KxUePLp87QHP/VaxMacsrRfseP9xvbY+9XyaiLaLRn2o3HBAeuwIT7Fo/OTIWRRj+qRfI0qseg9ecq4ipeWx0AAPF02L2PZxBb3WZVFbchDFUG5vCxv+R6B7znRKtBUXVTufzWVhWPYnv4CPz2yqEwsDqK1YdIMYWNiAPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut29GqbgkD/mWpohBHWpyhcCLRKWYIEKK/2ZFwuN5wc=;
 b=kc9BBQAdINxsNBy7HNeH53U5+gfcriGrDqT0i3k8UmLGn8MUquYY8KKgl/KaxIejc8Ut0bUoVgQNIGWgxPdXRnSzM6uiScyzyK9nNQd7122LxPS+tCC8XgFwQWhNlIWk3Z4MilHV9DhZUZCibR0s4BVoP0lxo+euRQfZHYAI7TO4NG/SVYU7kGm0gl37J0cR/jWuVey4iB8hAwLZ89249Xlki9vnalrwJpEkQ5HBdkcaETU+YS8Nn6rc4AHpYDhplprsx0kJVVAN8/2QtpbmraLnNzHwPfrF5o2Z/FTVUANgO9D+YzIMX4RTE4+ewp6QYL2Te33dSDtuv8ygvB6Iiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut29GqbgkD/mWpohBHWpyhcCLRKWYIEKK/2ZFwuN5wc=;
 b=a7ObQ91TSa36YS3hJY15XEQcj8hjw5Ig8CdZP0z/lG3pQT1xg+rhH3jJgeGLX/Iy0pHCqtyZjVREgGLPd+NGeNOwEyjl6cuEFh7I/fb+A7uQHP8UryDyIro/cMUHjG1acjqDLd+y4AXqL4OEznCy4rSpw2LLic94+6DuMhwLHum5Nd+LR1Ahu5mJJiHr4tqjHutQwaajd58Rg+/PpIt0e5KqUX2wScCt/bqCowr3Cg/QF2q+wCcy7u+Ls3NTBkfuWHxwbeQZwaZ/d+LN/1FliyZBx3Vms0hcYlYVa9Xo3PyASJkfl4d0SwDSVsAwda18UtFE1c0xh6DbDX/FbmppPQ==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AM7PR10MB3748.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:173::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 08:22:16 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 08:22:16 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "Steiger, Christoph" <christoph.steiger@siemens.com>
Subject: Re: [isar-cip-core][PATCH 1/1] make apt cache world readable
Thread-Topic: [isar-cip-core][PATCH 1/1] make apt cache world readable
Thread-Index: AQHcPqRW6DIp+EaI8UCmq+UC7JcIe7TF/F8AgAAEooA=
Date: Fri, 17 Oct 2025 08:22:16 +0000
Message-ID: <a932e10b6317d2fbbc52135f44532d68df6fcf9d.camel@siemens.com>
References: <20251016135349.2030862-1-felix.moessbauer@siemens.com>
	 <1898f0f3-cc2e-44fe-9fce-33720bd182d3@siemens.com>
In-Reply-To: <1898f0f3-cc2e-44fe-9fce-33720bd182d3@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-5 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AM7PR10MB3748:EE_
x-ms-office365-filtering-correlation-id: 0181ace7-ea12-49af-c6a8-08de0d564846
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cEUyc3o4M1g0Witzc3VhNVorbDFHVWZWdWlKMHNxbklpcWhSVFRqUng5d2M4?=
 =?utf-8?B?UE5oeWpVWmZTTnp0Q2lQQzZHZnVWV25KOHVBempsVGxwVmwwemZrSHNucFZG?=
 =?utf-8?B?THF1dnRlNHhUMi9jeFJSaDRqTnlXS09LcDZvUHdhTWdOOS9oUkF6NTFXZ0pk?=
 =?utf-8?B?V09mMDhTRlNYV0FJWTdjMUlCdXpEcUpqOWpzMFZCbjFyWldrTGc0MTBTU2p1?=
 =?utf-8?B?MUpuMm9ON1RmL0pxbEk4Z1EvUFkzbmpnM3EvNnFpZDMrU0pvbDNQVTVFTW91?=
 =?utf-8?B?OVdsakkvUmk3YzZvVm80a1lGZ2dCN3AyV2hIcGdLamUyWnNmSUJhZktRL1Zo?=
 =?utf-8?B?WEx3ZEdVTkdkelJQS2hTNHE4aXJHUEdrSzJaZjdYakJWdDdRTms0TkoxaDBq?=
 =?utf-8?B?T3ZXeG0yQU9XK1Aya3NVdHpzOTFiVlJiaTNJUzdiNEZ6SXFBVWxQRVg2alQz?=
 =?utf-8?B?YU05aTNYakNEaTczS3phZTgzR2V0Q0hZaG1QR2dNYlBDb09HcXBGQlJIRVJw?=
 =?utf-8?B?MVVhUmtBV1VSWWc3TktEcHJoeWJXUkNzVVpEOWVoaWF5WExUaHR5UHRSV3hs?=
 =?utf-8?B?WVZmclBPNkVZVm9NL3BWV1BTYjk3allVT1RtMDU3dVhicm5xL0h4Sjc2eTdm?=
 =?utf-8?B?WmNaZElXaUtST3lhMWkxSlhCWTBwN1MvQXhCMVBVb3I0Y3doTHQycFZHVCtK?=
 =?utf-8?B?alNjUzRhWnNHaHhjVVM0ZkJ4QkQzVGJlWVhySi8yS05sTTVSWnRkMlZER2R2?=
 =?utf-8?B?L3hMVzVEVmZLZ2t2MjFhTnB5RUkxRUErbStaZ1E5WW9RRXlSaW5uNDQ0bGtP?=
 =?utf-8?B?RCtBK3p6SWsxMlROU1RHVnFScnhvRUhQVHREZGJ3Nk41dG02NVJNNlplS3Bl?=
 =?utf-8?B?SjU2aittcmM0M2tJRk5kVmJkdEtDSzYvMGp6VkdtMkRKSUtaVkozWjRuT3JG?=
 =?utf-8?B?MGNNTlhGUVFNbllrZzliKzd4MUJjV21iRmNTbk1QbEF1NVcxQ2tzN2xXNlRj?=
 =?utf-8?B?Mk5nN0Zya3NhS0ovanhCbmZ2L0lGR0t2bldKTlhJUG0vTy9sN0VmWDEvY2FR?=
 =?utf-8?B?TkdZOU45V2U2bDRva0hyQ2JRanRab21TbWtwZU1WcDlFS0REVEk0eE5SeHZw?=
 =?utf-8?B?anc1cENFQXhDL29VNTI4YmxzNjdxK2dXKzc5dTRSQS8veG5GWnJ3TGlsdzBZ?=
 =?utf-8?B?Wk1la2JaM0h5MEg5YUcrSkhqSWZFaXNleXg1R1k3a2JCVXJxZ3Y5dkZCdm5l?=
 =?utf-8?B?SFRJU2V6RHE3NTVUSFE5ZWJMQlhZaWxhZEhOcXZldktCZWg4azF5MEFnck1m?=
 =?utf-8?B?VTdxcWV5MHRyTjNxeTRmV0tjZHdyT3BRdUZqdmtDY3BxSUNacDZDMkhWUjEw?=
 =?utf-8?B?ZXZEMVlMUjBITXl4ZWVGMFV4NzI3RG5uN1J6OGEzR0ZmQVdUT2RTamN5NnVa?=
 =?utf-8?B?TWxHOE1vaG5RVEVFbDh1WlJYcFJxWmhKZTYrMXVqNXdxRUFYVnlhS25VWFo5?=
 =?utf-8?B?bWYwMEFsQjdwem5LUzJadEt6SUIra0VGekFHOWtmbmxURUpkUU4wbEdJSFpy?=
 =?utf-8?B?Q3Z4Rlc3QWNVSTFhZmIyb3F3UDJRd3JWMW1RN3BncXRHMGVERktNeW1QRVdC?=
 =?utf-8?B?V3dVeXRtNStyVk0vRmRPMjdaeGpuMmVtN1BsR1Bsd3VSSndNR1U4TnozeFIr?=
 =?utf-8?B?cWxEcS9wVXFheVU3WmVwNlF0LzVuUEZJMGJXd1VwN01TaXJaVUhEY3M0NFdH?=
 =?utf-8?B?SE0zOGplc2NDVEVKZUplNWhhclZnTThQSUJxQlZhTEZPWFkvSGRqUXE5aGRi?=
 =?utf-8?B?V3JJbUkzVm1UN2xxMXFGNFUvMzZzTlFsQjIvVGlhUTQvVDEyWkdlbWE3c0xQ?=
 =?utf-8?B?QVpMYWs1aDZwbVVxWWRTNkExeHZWc1FnWFQwdlhFcVdRTWFqSm9OV1dsTnJt?=
 =?utf-8?B?YnRLMkErWWIyOGo4bFluVXRVNVlwLytsYk13ZDNydXU3VExQVXFTbW9RblFT?=
 =?utf-8?B?WUZuQjcreDVTQWVDb21MRERTOW9XY1BqQ2RDVHFRTFZBVUR6aTBZWEg0WkJx?=
 =?utf-8?Q?yx1IP+?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RVljeGF2Y2c0NWJZMGY1N2pzRFZ1TnlaaVFWRmZybXZQVHlnMkM3bzJuOFlT?=
 =?utf-8?B?UHhWM3NJMUg4TldWL2ZvWWh3VTdnNzJoMFg1K3ZUaGRySTBHalBRaVpFSGIx?=
 =?utf-8?B?RlJsQ0tja3Vsbkt0RjlNTlk1aUVRVjBTNGlRd3ZOSUJmeWZrRENvRVRzNy8y?=
 =?utf-8?B?eVRrcEVzMEhqdkFmTzNhTjl5RGlxVzJnbjl0TG53V29ZUXljL0Jobi9QUmJL?=
 =?utf-8?B?UmdIbEJIQ2RYOHEzWCs1dFU5bW5jZzV0Z1FaZnM4Wm1aL3kvbVpDeUp4MjhX?=
 =?utf-8?B?L1BoZVd4WmJObStBc01UUkNPdUY5cXUxOW9DZ2tDMGFFcHdGRDZsY1E3bmxP?=
 =?utf-8?B?MVhmZ2x3MUQ4KzZ1NytUSTlCdHFoOFhXbllSUVM0SWFrSXNVUlM3TWl3R0JZ?=
 =?utf-8?B?WHhNaVhJa0g1VGROQXpGUFNwTThWVFFtN1ptNUdCQ2VObGpMWHZsN3Y0ckxF?=
 =?utf-8?B?SEluU0Q5R1prQUJ0MEkxdGhUTllJWW9DSEZVRk82RDdQV08wUHMzeGJOLzAw?=
 =?utf-8?B?QUE1aXZtSFVDeHlBc1Nyb0QvNmdseWFvVURuOHppVDY1SkFMVzE3V0JkZUYw?=
 =?utf-8?B?L1NRZnFYZFByeFh4emNCZUw1MVhZNm1lazBjaE52c0RYZndXVjhWT2YwdTZq?=
 =?utf-8?B?Z1IrMnZFaDlIc0tyNEJPWFEvcTkyTU90N1pLZG9IaWluZkY5VWQySmxXQ1Vx?=
 =?utf-8?B?bEZzdEthaHVkck9uNzg3cmpqUzZhSzVLV3ZVOGZWWmg4UFMvRnpJN3RFR2ZO?=
 =?utf-8?B?L2NXV2c2OVFtNCtPTDdSZkRLc1JFVWdndHdwdTN0RXRqdmhoVVd4TlQxY0tX?=
 =?utf-8?B?UUdndS93KzZqYnBhbE9OaFk5ak5EeTV4UE1PMXorWUR5L1FzNkZ3c2FLTnZu?=
 =?utf-8?B?UGVEcUtNZzRhU29ySFVyMG1sVFk5THpJUkFwcTNUai9WY0tSRTI0NnhqMXds?=
 =?utf-8?B?R3Q1M2kxZThuRndjVVB5a1VDWmN0M1BxVWVNbFloYkNBVlpLeWZZSWtEa0ZE?=
 =?utf-8?B?ZnZhZWtHZzY4M2dGZm9zWnB3NTUzOUpDY1lTeEhhK1RPdmRhbjl0TWd1WkhQ?=
 =?utf-8?B?SnVuSmV1Qk5uRVdWMC94cUxteFk4SFdYQ1FIWmpsMUlMMS9vbmYrR2NEam5L?=
 =?utf-8?B?VVQ0YkhjVU9NM3liL2NZOXp6b3ltUERuOEcrU0p6WWpIbWZyZ29aTXg3Kysz?=
 =?utf-8?B?L1F5T3cwQTNGR01NYktPSW9TbUd2V2RxaC95cGVRQ0dUenh0YXQzTmJKVjdC?=
 =?utf-8?B?aytLcHVCd3hnT0NzUzhnY2lDcHFHQllTTnlQVjJuWC8xdGNtQVZWZjdxWXEy?=
 =?utf-8?B?OUpITUs2RVl3L0ptMFVCbnpFMEwvS1RDYTl6Ujl0WXZqY0R3cDgzemFTUXhE?=
 =?utf-8?B?OGlQcnR5d1Z4S3p2Ym5tR05LcVpCSGJueHEyT3RWVVFSQVRJNG54UkhPUFdR?=
 =?utf-8?B?dUpwTGF3WmtsdGdUM0lCbUVVeVo3WkY1WGVuam5vdWpUeWljRXNIMDVLNFpw?=
 =?utf-8?B?STlhbGpBTTVMaVdTMHZJNjdydXVrWnZva09rQ0k2UGVqQmxQZEE0RVdQS0dW?=
 =?utf-8?B?aFc2cmM5ZEtITVZ3V0JjdnZlem9vWE5KZ1BYWXZOQ3Jha0NDOE5oZFQ5dis0?=
 =?utf-8?B?aWdScys0aHF5VEFNSTBweXNyS0FZd053R1A2b1RmUTZ2aVZhYVg4NGdScm0x?=
 =?utf-8?B?S0ZxZzc2WG40alB6VDBldkwrNXpTK25wS1R3dVBMTkFOSS9xeFZrVGcrZEtv?=
 =?utf-8?B?aWtMOStvU3krajBkclF3a1pmVE1lU2hKeEFZQ1phb0IwMUMzdkJ0UHJMd09F?=
 =?utf-8?B?WnRxTUJCbVBUUlg0MjYxV0xPNGJkMnlaNXYvTm5sc05YZE1CNVYvc2IwKzlr?=
 =?utf-8?B?QUdkY2NRaVlwdkVicmwrbkJ4dlkvTFhQWi9OVjIzeTBtTmhVYmdhNERQeklw?=
 =?utf-8?B?UXJ1UW9peHk0YzU0TTFDTVJjamFhajd0c2dVNXR1VmdxZEIyd3lRV3R3UjRC?=
 =?utf-8?B?bUZkb1dBblhSK1Z1RVIxd2VQeEZpSDBCSFlKc1BvTGwwT25oeXBNTTZhVEd5?=
 =?utf-8?B?ckl3cUlXT3QxS256WkdWSlltSkQvb2dWcUs3blNzQ2lwSVJHWm5zYm5YalFh?=
 =?utf-8?B?c1Jla0p2WncvVWpRc3l3STBVSHNzS3g5NUlPZUhWL0FUZHBZbzNsOEpBS0h3?=
 =?utf-8?B?bjZIQ2JtVWNzcmZURUFLN1dmTkFPSktyYTJrakVkbGdxbzNoWW1GN0liQ05U?=
 =?utf-8?B?WHMwc2FsOEFXbVMyN01zUW9GeVRBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2A441F14D07854790632FB7A589ABA0@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0181ace7-ea12-49af-c6a8-08de0d564846
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 08:22:16.3959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Mr5CPS4IznJpenXR/Ahj2k5Sp7pWqvTlKNYasmZS4MSui5PgTaV9h9kO6SDhXEsDUaP+JCpm2EClsOnrjDeiqMJXo2cj5wrvqr0sg6psOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3748
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Oct 2025 08:22:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20194

T24gRnJpLCAyMDI1LTEwLTE3IGF0IDEwOjA1ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxNi4xMC4yNSAxNTo1MywgRmVsaXggTW9lc3NiYXVlciB3cm90ZToNCj4gPiBUaGUgYXB0IGNh
Y2hlIGRpcmVjdG9yeSBpbiAvdmFyL2xpYi9hcHQgaGFzIGRlZmF1bHQgcGVybWlzc2lvbnMgb2Yg
NzU1DQo+ID4gb24gbm9uLXJvIHN5c3RlbXMuIEJ5IHRoYXQsIHVucHJpdmlsZWdlZCB1c2VycyAo
b3IgdG9vbGluZykgY2FuIGFjY2Vzcw0KPiA+IHRoZSBhcHQgY2FjaGUuIFdoZW4gcnVubmluZyBv
biBhIHJvLXJvb3Rmcywgd2UgbmVlZCB0byBjcmVhdGUgdGhlDQo+ID4gZGlyZWN0b3J5IHVzaW5n
IHN5c3RlbWQgdG1wZmlsZXMsIGFzIHRoZSBzeXN0ZW0gaXMgZGVwbG95ZWQgd2l0aCBhbg0KPiA+
IGVtcHR5IC92YXIuIFRoaXMgc2hvdWxkIGJlIGRvbmUgd2l0aCB0aGUgc2FtZSBwZXJtaXNzaW9u
cyBhcyBiZWZvcmUuDQo+ID4gDQo+ID4gTm90ZSwgdGhhdCB0aGlzIHNob3VsZCBub3QgaGF2ZSBh
bnkgZWZmZWN0IG9uIHRoZSB0YXJnZXQgc3lzdGVtcywgYXMNCj4gPiB3ZSBhbnl3YXlzIHdpcGUg
dGhlIGFwdCBjYWNoZSBiZWZvcmUgZGVwbG95aW5nLiBIb3dldmVyLCBhcyB0aGlzDQo+ID4gdG1w
ZmlsZXMgc25pcHBldCBjb21lcyBhcyBhIHBhY2thZ2UsIHRoZSBsaW1pdGF0aW9uIGFscmVhZHkg
YXBwbGllcyBhdA0KPiA+IGFzc2VtYmx5IHRpbWUsIHdoaWNoIGJyZWFrcyBCT00gc2Nhbm5lcnMg
dGhhdCBydW4gYXMgYSByb290ZnMNCj4gPiBwb3N0cHJvY2VzcyBjb21tYW5kLg0KPiANCj4gQnV0
IG5vdCBhcyByb290IGluc2lkZSBpdCwgcmlnaHQ/DQoNClllcywgZXhhY3RseS4gVGhlIHRvb2xp
bmcgaXMgZXhlY3V0ZWQgYXMgbm9ybWFsIHVzZXIgKGJ1aWxkZXIpIHRvDQpyZWR1Y2UgdGhlIHJp
c2sgb2YgbGVhdmluZyB0cmFjZXMgaW4gdGhlIHJvb3Rmcy4NCg0KRmVsaXgNCg0KPiANCj4gPiAN
Cj4gPiBGaXhlczogMjY3NjNiMyAoImNyZWF0ZSBhcHQgZGlyZWN0b3J5IGFzIG5lZWRlZCBieSBh
cHQtZGFpbHkiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IE1vZXNzYmF1ZXIgPGZlbGl4Lm1v
ZXNzYmF1ZXJAc2llbWVucy5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9pbW11dGFibGUtcm9vdGZz
L2ZpbGVzL2ltbXV0YWJsZS1yb290ZnMudG1wZmlsZXMudG1wbCAgICAgICB8IDIgKy0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL3JlY2lwZXMtY29yZS9pbW11dGFibGUtcm9vdGZzL2ZpbGVzL2ltbXV0YWJs
ZS1yb290ZnMudG1wZmlsZXMudG1wbCBiL3JlY2lwZXMtY29yZS9pbW11dGFibGUtcm9vdGZzL2Zp
bGVzL2ltbXV0YWJsZS1yb290ZnMudG1wZmlsZXMudG1wbA0KPiA+IGluZGV4IGU4ZTU4YjMuLmU2
ZDI1ZDIgMTAwNjQ0DQo+ID4gLS0tIGEvcmVjaXBlcy1jb3JlL2ltbXV0YWJsZS1yb290ZnMvZmls
ZXMvaW1tdXRhYmxlLXJvb3Rmcy50bXBmaWxlcy50bXBsDQo+ID4gKysrIGIvcmVjaXBlcy1jb3Jl
L2ltbXV0YWJsZS1yb290ZnMvZmlsZXMvaW1tdXRhYmxlLXJvb3Rmcy50bXBmaWxlcy50bXBsDQo+
ID4gQEAgLTEsMyArMSwzIEBADQo+ID4gIEwgL3Zhci9saWIvZHBrZyAtIC0gLSAtICR7SU1NVVRB
QkxFX0RBVEFfRElSfS92YXIvbGliL2Rwa2cNCj4gPiAgZCAvdmFyL2xvZy9hdWRpdCAwNzAwIHJv
b3QgYWRtIC0NCj4gPiAtZCAvdmFyL2xpYi9hcHQgMDcwMCByb290IHJvb3QgLQ0KPiA+ICtkIC92
YXIvbGliL2FwdCAwNzU1IHJvb3Qgcm9vdCAtDQo+IA0KPiBUaGFua3MsIGFwcGxpZWQuDQo+IA0K
PiBKYW4NCj4gDQo+IC0tIA0KPiBTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVz
DQo+IExpbnV4IEV4cGVydCBDZW50ZXINCg0KLS0gDQpTaWVtZW5zIEFHDQpMaW51eCBFeHBlcnQg
Q2VudGVyDQpGcmllZHJpY2gtTHVkd2lnLUJhdWVyLVN0ci4gMw0KODU3NDggR2FyY2hpbmcsIEdl
cm1hbnkNCg0K

