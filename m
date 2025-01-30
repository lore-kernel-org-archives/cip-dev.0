Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A457FC0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 08:45:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.11492.1738226710753264401
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 00:45:11 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 50U8j7wl215542; Thu, 30 Jan 2025 17:45:08 +0900
X-Iguazu-Qid: 2yAbj3N9XN8Ef92JKB
X-Iguazu-QSIG: v=2; s=0; t=1738226706; q=2yAbj3N9XN8Ef92JKB; m=FBafoZTBQUlIEd3A+kavyE6EVVaZk0/K9Gwl8IWW9po=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 50U8j5nK1982032
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 17:45:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jl7Ddu+9SuClCt+MRAhPqQhvRSbnbR+ctuyUVe3va6DS+iXSZwGpylGbB1lvR8Hj0kYCe7X7unQtIAJXKXMQ83YjXPvnfGMDGkrEJtWcdcc8v+iZ8bc+HLDBumRTOH6o9NdHphCDKdv1z8eKXgZRgdopsdBg5YK7NUWDLYSIVnT0gnUUo5cGXBH9/E9s3DJ3CzST044Xf8frPI4n/BRHGGM4ThqZUaHRUCIizHQJrDRupm8yMVJUJk7Z1f84KNR4RQ+FBoZtj0XIbt9ZSXpiSG3bEQ60C9PgccKOYFNnpqrlDsukAWYBPtrbdLdYT5dOiCVNZkwpoKrkVuPEMp8Buw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lS7BV7LgpcswRO91YB7VgaqmYsXqfQu1dY+3ZgUOw8=;
 b=FoMYc26VZbjFBJDjxAx+TtJWq0CaLGfetV/KXPgWy3ApO+lqd8dfRObFtz/WaRExI7OiiKxCJ0j6LOmEd7OlpM1kDsTnDz4G6gfAIataUOzkO+IL/o8iglnMripTDhXbTT2+R5qhtRJXLdx3+zeEHZ157u9aSA1TCtexsSpINhPHVsKqIDovN/BQJsk2A9Ei5qKXH7aSP4+d0fqW1vB9GJtIj+y/pSPq5yj6myywKSUX4VKEV2UzVELG9YIPhdBMZBSTuiCCKct8Vr8jPE7CxvDtNYmFnL+C98qzmooMQuQzXpl/cxTcN5rQkzbQTtWhbR9zmsJ51rrHdPBohXDysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <quirin.gylstorff@siemens.com>, <jan.kiszka@siemens.com>,
        <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/3] build x86-uefi with secure
 boot
Thread-Topic: [cip-dev][isar-cip-core][PATCH v2 1/3] build x86-uefi with
 secure boot
Thread-Index: AQHbbmMZewYSdttZ8keyqFntS+fn+7Mu0xWAgAAfxQCAABQdgw==
Date: Thu, 30 Jan 2025 08:45:02 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61030247E8AE7BCFBDA4ECDBC2E92@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <20250124132246.64738-1-Quirin.Gylstorff@siemens.com>
 <20250124132246.64738-2-Quirin.Gylstorff@siemens.com>
 <38e3b2ea-9dad-4f14-8e73-9dc8f4c05f9d@siemens.com>
 <a57c6f8f-47ce-4202-9fb8-fab2c33fbe7c@siemens.com>
In-Reply-To: <a57c6f8f-47ce-4202-9fb8-fab2c33fbe7c@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OS3PR01MB6344:EE_
x-ms-office365-filtering-correlation-id: dcc1e3da-22b5-43a9-701d-08dd410a632f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?RkpMb1ROeFd1YThtRE5BdzBhdEgzbFBkSHR6T0VWZ1dSNEszL3hNWWlK?=
 =?iso-2022-jp?B?d1BSTjV1ZHlBd2ZmclNuRGZrall2OVBsMmQrOFJYWmZDell2Um5rQlJv?=
 =?iso-2022-jp?B?c2hteHdxNTR6UVlXdmpEdFgrbitobkFFVGtCVXVqMGx2NzNQSGFkanBO?=
 =?iso-2022-jp?B?eUNoSkhPbEhWWk5mdXBUczl1eUhMajJyOEZBRVAwZGlOaGdYSnUxZy9l?=
 =?iso-2022-jp?B?V1htOG9FM1dvbzU0SGcyd2pFWW1WdzNTRFhsWWZ1enN3SjdaZEhzbWJK?=
 =?iso-2022-jp?B?b1BZY1dZcWtnRGtiQnJwbURCbi9NQk15eXVsVXhYYnF5d1IwWnZyS0pn?=
 =?iso-2022-jp?B?VXg1bHlPbVNISkFYcjJrbEoxMjNGNmNlUTNWQUtGc1Y4YXQ4M2VmU3Q1?=
 =?iso-2022-jp?B?SldDcUhwK2tDRHEwN2IzcEJvYldFcDQvcUl1ejVqVndJNGJldjdIemR6?=
 =?iso-2022-jp?B?M1VkTWQxcExzK2NCeFY3ejMyb0NRaUtVd29LWDVicm5EUHA5SlgxdFAx?=
 =?iso-2022-jp?B?bXFuQk9NbllqMk5TUGxLN2EvakNtc0ZyUlVDVm1rOWtFbkl2bVdqcnYv?=
 =?iso-2022-jp?B?Y0t0MGx0TEVSODhPNXZKK3lXN3hrNkJDYjRuQWxtMS9KaElsa0ZFSFNC?=
 =?iso-2022-jp?B?aVlsK0RhK0ptNjZBUmNpZi9UNjMwdjM3K2YxOXhNUStJRE5LRjFzQkZT?=
 =?iso-2022-jp?B?Q1Njd1o3ZW1mUko4SFFWMmNzU3JiVG1KYW1MQWJESDRJUi9sNktGZnVx?=
 =?iso-2022-jp?B?NGEvek01KzlUNmV4MGJoQngyclM2UlZ1Q3pvV0c5cnUwMXdIcUVOaXFS?=
 =?iso-2022-jp?B?OENmSmhsZDRtbG9LZ1MxYXBFakNRd2VkSnUvbGVpS2pFakRFQ25OTmdW?=
 =?iso-2022-jp?B?UmhVcy95bDI2dGNpNXFZcEVzL2dsNHhQWnhVQWhGRVJUVVN1VjhoYjNv?=
 =?iso-2022-jp?B?b0xOeVpsb2xPS0lHR2tqNThhVU9aWGY4VXgxbDdLREo2cXczM3dJaFRw?=
 =?iso-2022-jp?B?Qno0VU1sVC9tVjV2QzcyTzkzRXBzanhFSmZsVElFdGF3eDB3dXlSQmta?=
 =?iso-2022-jp?B?dU9VYUxwNXhNYkVhY25DUzNVUGhZZFNwdnRFRXp0aEZwNGF2b1dkVjhU?=
 =?iso-2022-jp?B?N044VWtMdGdETjgzVWFJN1Rka0FEZmFRVFVPNnNKWHBEZURnOXRwaWxR?=
 =?iso-2022-jp?B?dXVYNDBrT21kU25SYWRnam1MTmtZYVNlTmhweWQwNFZFTmI1bGIwL21z?=
 =?iso-2022-jp?B?eUc4UUxoQmcrZFVRTW9Ga1ZYb2hrMTg5Y1pEQlhoVGtDSHBCSFZIUnNn?=
 =?iso-2022-jp?B?cTQvd2pjY1dFdGF1aHJJOWVzdys2WnVhZStGazNhcVdWcTE0MTBNb3FE?=
 =?iso-2022-jp?B?UlJtdCt5VFYyMFlDYXhyWmFOYXdVWHNsaXdWN0hiOHF5bkZyQXkraFVo?=
 =?iso-2022-jp?B?TysyelZTQ3VYM1JBTTY4Zm8zSUMxbkp0N0d5aEtKY2hiMTBDRkx1MHU2?=
 =?iso-2022-jp?B?dlllVkFaQjY2T0pFRGU2TEJEVExXc1lwVG9hS0ZJdUFBS1dxbUFEQTVD?=
 =?iso-2022-jp?B?aDhyNXV0TlVQcHJOaHo3bk9LL1Z4WEJ1SWtXT3ZZUUM2QThEZHQ0SHVh?=
 =?iso-2022-jp?B?QjRHT2xHMG9LWVdoM09SQXd4WVpLNTY4UnA5STNiWk1iWVBubnR1NDZl?=
 =?iso-2022-jp?B?dXlYVzlOQktEdjJoYUVqR2RMck95WU5EZUZTaGhUVHExRTRLQVp3anVn?=
 =?iso-2022-jp?B?Qlo1RmxnclRRRFpDRnQyT21LYzVTQVZaRWpMZTRVSlJuZ1l5dFo5MVdF?=
 =?iso-2022-jp?B?OEZza1JjUU9OV09wR0RXSG8rZ005QUhaRHpESk1QVlZHVkJ5UUJxYzNl?=
 =?iso-2022-jp?B?VThzd0toazV3eU9jQ1JkYTZBT3R6Q29CWUhqdnkyUmNjYUltWDgrUkdp?=
 =?iso-2022-jp?B?Q1pBZnNUZUgwUUZBY09qMXppNlF0YkJaZzFzZ2V6NlBLVTl4UVB2Lzlr?=
 =?iso-2022-jp?B?T1dSQnpIVU8veWFOWVlRN3Q4MkNob1BWaFB2WmNPak1DTlFSNXJzUCsw?=
 =?iso-2022-jp?B?dUhkYnpZV0cyV0ZmWlcxa3krS2p6Y1lpb3Y2cXFOOHgvLzIxaUdNMVBj?=
 =?iso-2022-jp?B?bHo=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dmY1R25Dck8zajVyaGFmbUlZVGJjWEVKeEw3ZkNFSnFHQjlTbmNtbDhN?=
 =?iso-2022-jp?B?aXZ3UkhySnJQU0t6ZUZxTGlRY2liMVVFSjFPRER2Y1ZDSVYzNjN3MGpF?=
 =?iso-2022-jp?B?bkZPNXRFN1BrNTNBSm8xSkl5OU92QVNpNTRZblB5U1dyQnZIWHFJT0lj?=
 =?iso-2022-jp?B?OGswcFErSmwwd0h2QkxrRzA5R1dYcVUzMEtTdDlxQWxKNHZpWFN4bzRK?=
 =?iso-2022-jp?B?d01VM0MzNXpyVTE0eGxTRlllWURkbnNIMGFBV1FkYWVTOGdrT3RJa0NW?=
 =?iso-2022-jp?B?Zy80dlJTbUt4TDFVeEcwTmxOeHlhTEU2RzVuTkhpaWxjWDdnM3kzTnZj?=
 =?iso-2022-jp?B?T25EaTJiMkJ0U29UdnU4T205aTlMT1dkYWowN1FadmlJOXRpWEdMMDJ2?=
 =?iso-2022-jp?B?WmhveFNzdnJwcHplbkJ4aThUNDM1OTYrVzRNVEEvMXdGaEhyeHk3SjJo?=
 =?iso-2022-jp?B?cTlBQWJtZWNmYXNINVVYUnMrOWNDWkFWRVk3OEVJcENOWlVyelNtR2VB?=
 =?iso-2022-jp?B?SFdsUXYvaXE5b3kvRXVUVlFmYUdUc0NLL0ZiNkw4S1R3MHF0TVBkbStV?=
 =?iso-2022-jp?B?ZGpONW4zV0dHYmJYWmprS0JsYkNJYzU2elBVTTlsajFld3cxeXpCM2JC?=
 =?iso-2022-jp?B?RTA2OHhzSkY0bWcrcUg0R3B0YkpkUCtYSDVkcjh6WEZ1bWNHSkN4cVJ6?=
 =?iso-2022-jp?B?RVJ4bmVPWmR6V205MlFVa0toSlFieHJXTGUycVdSYkFxRkFzanNuNHpE?=
 =?iso-2022-jp?B?MjZMbXduQm05TVd5cDNEZnhRdDJtTTEzWExOTkY2WHpBamJzUy9VWlpG?=
 =?iso-2022-jp?B?Z0RsUmh5OUZsY1BndEZqUHRVamlVNXROZWtDS241YlZ0OWZtbDZkSldD?=
 =?iso-2022-jp?B?Q0ZUeElJbXZZQmtKNitKZGRsRk85NFphc3lRZ2p2WFNVQXhRSTYrbjhW?=
 =?iso-2022-jp?B?RHR2Zkg0Q2dTUW9mUUV5VTIvTnZGMWU1dWs1ZVhTOGFNTC8wUDYrcTdU?=
 =?iso-2022-jp?B?UFdIVC9rZ0cxUlJ3UGg0VmIxK0czenNsZi9QY3hSc3UrdzhFa0NMUWR2?=
 =?iso-2022-jp?B?OWttM1lFQ0NBNkdTbUpjd0RQQjBLczg4dHpxcFVpak5xQmNuNlRmZmlD?=
 =?iso-2022-jp?B?UWN0ZWF5VDl6ZHN0ODJTdWwwRk9DZ29wa3htYXNWWXFzeTJLQlhnZjVm?=
 =?iso-2022-jp?B?QWVETGROZW5BUFJHc0tOcjRZZ29HcjZRUmJzUHB3aVoxVFpLZGNIN1Bw?=
 =?iso-2022-jp?B?NG1pRytaVkRaUXVqSTRHeFdWTFdLYmZmSS8vNVljbytWZUplVitFOTZj?=
 =?iso-2022-jp?B?SGdCQVpndy8zaGVQaUx1cnQ3d3V6cEVhc00wZFhKS2VDRlFzdUlCTXpk?=
 =?iso-2022-jp?B?WHpoQjkrY2RZMDJLaWozWnA4NDRLcnpHWUE3bXpNZk4vOEJIUnp4dUI4?=
 =?iso-2022-jp?B?a1dZS1oyTUhXaEwzM0FwZHhUNnB3djQyWGlYc1QyUThXMmZVc3VCNmJS?=
 =?iso-2022-jp?B?Wk1QS0RQUS9PMTdpSUhFOGw3V3F5UkgzMGhMMG5ZTmt5NmRGSnpPZWxx?=
 =?iso-2022-jp?B?YjIrZ2NpcURYaG4vaFFCVklZNnJidVNJeXBpZUlZNTBqbzlMamVzWmcv?=
 =?iso-2022-jp?B?OFh0U2l2NmdVQzd5VUVRVkJUZ1pVNlFCWCtxL2J0dkJTeGYzUk1VQVdx?=
 =?iso-2022-jp?B?bEo5SXhJRmNCY2gwblJzSll1cDByMFZkSmgwY3B5a3pkRnV3elJWclpX?=
 =?iso-2022-jp?B?ZVdIb0lrWUhjOGVtTFZ6bzh4YVdOM2RXcG1DYVR0RVNGR0RqUjQ5eVQy?=
 =?iso-2022-jp?B?ZHk4WWY1bnJVNnovRjZqdHlJdXFYaml5S0hIUjRRUU5TWExDVExnVXV6?=
 =?iso-2022-jp?B?VlFkVmFmVnU1ajZoN2FhMkNOQUF5WllQZUlkRmx5U3Yrb0VhQWhKK1Zy?=
 =?iso-2022-jp?B?WmJEU21La2xITTVBdERyZlVYQnpCZlI0aEJaOTVXK2htRlJYeklmcWMw?=
 =?iso-2022-jp?B?dElQaC91V2tnUHZYOVhPaEo3RitCTjByeThUMzFZTFZVWGFncWhMdFVr?=
 =?iso-2022-jp?B?TU82T20zQjJ1MWpMcEthWFQ5RGE5QkRvOTRmUno3NVcwc25lcnJwTDkr?=
 =?iso-2022-jp?B?QnFpeUR1SUdHdytlektxZ2czQmdTRFRhaUVmejArVmxWYW1GSDA1aFZx?=
 =?iso-2022-jp?B?Ym5rZnppUjFFMDdnYjl6K2pNRi83c0Z3NWlxTTlCSWZoRVRHczJPdXBL?=
 =?iso-2022-jp?B?bU5KNVJoZzhRNzlxNmhVZ0g1WlNuUUJRRzUzQm81NzdmZlQ4aUQxR0J3?=
 =?iso-2022-jp?B?MW44UmpWUTk4QXVLamxidWZMYWUzcVlwVGc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB61030247E8AE7BCFBDA4ECDBC2E92OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc1e3da-22b5-43a9-701d-08dd410a632f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 08:45:02.5958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idAk/4WMnTAg4hSA3qv89MBpMVw7K2CqcDweQv2iJx77unz6i0rMJEsyEnLXF8TCuw1LWmdwbYMMUrWbzBIbIxtuZkJRr92odueu0rBgm7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6344
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 08:45:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17689

--_000_OS3PR01MB61030247E8AE7BCFBDA4ECDBC2E92OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Quirin,

I believe we can drop qemu-amd64-secure-boot-encrypt, as we are not testing=
 that image in LAVA.

The target being tested in build:qemu-amd64-base, is very similar to the pr=
ior one. The only difference is build:qemu-amd64-base additionally has secu=
rity packages.

Thanks and regards,
Sai Ashrith

________________________________
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Sent: Thursday, January 30, 2025 12:53 PM
To: Jan Kiszka <jan.kiszka@siemens.com>; ashrith sai(=1B$B#T#S#I#P=1B(B) <S=
ai.Sathujoda@toshiba-tsip.com>; cip-dev@lists.cip-project.org <cip-dev@list=
s.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/3] build x86-uefi with sec=
ure boot



On 1/30/25 06:29, Jan Kiszka wrote:
> On 24.01.25 14:22, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .gitlab-ci.yml | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index d4bd283..42e247d 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -241,6 +241,16 @@ build:qemu-amd64-secure-boot-encrypt:
>>       deploy: disable
>>       encrypt: enable
>>
>> +build:x86-uefi-secure-boot:
>> +  extends:
>> +    - .build_base
>> +  variables:
>> +    target: x86-uefi
>> +    extension: security
>> +    use_rt: disable
>> +    targz: disable
>> +    encrypt: disable
>
> Why without encryption? And can't we replace
> qemu-amd64-secure-boot-encrypt with this physical target? I'm looking
> for ways to avoid building more variants.

Last time I look the qemu target was also tested.
@Sai can we drop the qemu-amd64-secure-boot-encrypt ?

>
> BTW, you are dropping "encrypt: disable" in patch 3 again - it's the
> default anyway.
That was a copy paste from the build:qemu-amd64-secure-boot-encrypt:
  target.

Quirin

>
> Jan
>

--_000_OS3PR01MB61030247E8AE7BCFBDA4ECDBC2E92OS3PR01MB6103jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hello Quirin,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I believe we can drop <b>qemu-amd64-secure-boot-encrypt, </b>as we are not =
testing that image in LAVA.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The target being tested in <b>build:qemu-amd64-base</b>, is very similar to=
 the prior one. The only difference is
<b>build:qemu-amd64-base</b>&nbsp;additionally has security packages.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Quirin Gylstorff &lt;=
quirin.gylstorff@siemens.com&gt;<br>
<b>Sent:</b> Thursday, January 30, 2025 12:53 PM<br>
<b>To:</b> Jan Kiszka &lt;jan.kiszka@siemens.com&gt;; ashrith sai(=1B$B#T#S=
#I#P=1B(B) &lt;Sai.Sathujoda@toshiba-tsip.com&gt;; cip-dev@lists.cip-projec=
t.org &lt;cip-dev@lists.cip-project.org&gt;<br>
<b>Subject:</b> Re: [cip-dev][isar-cip-core][PATCH v2 1/3] build x86-uefi w=
ith secure boot</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
<br>
On 1/30/25 06:29, Jan Kiszka wrote:<br>
&gt; On 24.01.25 14:22, Quirin Gylstorff wrote:<br>
&gt;&gt; From: Quirin Gylstorff &lt;quirin.gylstorff@siemens.com&gt;<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Quirin Gylstorff &lt;quirin.gylstorff@siemens.com&g=
t;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; .gitlab-ci.yml | 10 ++++++++++<br>
&gt;&gt;&nbsp;&nbsp; 1 file changed, 10 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml<br>
&gt;&gt; index d4bd283..42e247d 100644<br>
&gt;&gt; --- a/.gitlab-ci.yml<br>
&gt;&gt; +++ b/.gitlab-ci.yml<br>
&gt;&gt; @@ -241,6 +241,16 @@ build:qemu-amd64-secure-boot-encrypt:<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; deploy: disable<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; encrypt: enable<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; +build:x86-uefi-secure-boot:<br>
&gt;&gt; +&nbsp; extends:<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; - .build_base<br>
&gt;&gt; +&nbsp; variables:<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; target: x86-uefi<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; extension: security<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; use_rt: disable<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; targz: disable<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; encrypt: disable<br>
&gt; <br>
&gt; Why without encryption? And can't we replace<br>
&gt; qemu-amd64-secure-boot-encrypt with this physical target? I'm looking<=
br>
&gt; for ways to avoid building more variants.<br>
<br>
Last time I look the qemu target was also tested.<br>
@Sai can we drop the qemu-amd64-secure-boot-encrypt ?<br>
<br>
&gt; <br>
&gt; BTW, you are dropping &quot;encrypt: disable&quot; in patch 3 again - =
it's the<br>
&gt; default anyway.<br>
That was a copy paste from the build:qemu-amd64-secure-boot-encrypt:<br>
&nbsp; target.<br>
<br>
Quirin<br>
<br>
&gt; <br>
&gt; Jan<br>
&gt; <br>
</div>
</span></font></div>
</body>
</html>

--_000_OS3PR01MB61030247E8AE7BCFBDA4ECDBC2E92OS3PR01MB6103jpnp_--


