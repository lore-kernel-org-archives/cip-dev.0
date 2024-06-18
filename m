Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07215C2BB85
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 04:40:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.78382.1718685606000541268
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jun 2024 21:40:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=eF62Ec/k;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1718685599;x=1719895199;bh=KEAVhr4eKJ1ZP65YS2twZhZtSig/5uwVkh40jqv
	76Sc=;b=eF62Ec/kg2QhmX6W6Ga7BP5ALensIeBqE5picgkO8F1+X/9K/C6WLvo8OiokvaBv4b5EM
	fKtdHIfBw7tfRFvv3nMAALcw8OhU2YmBWk911vCpjiiYhelg6Uku3ysKUJiOnF1om8cSBq43chdPG
	NV4b5Lk5mmPlBv2WQBf9w42Asc6jZwjw1cBNDjibkIn50I8FV4d+E87yH75vWKDFZnn31OibIf40U
	cPBozooGCPwaxTYZrzU3WByl52LBiKuSbFeMdyByac3kC7D7oZlKegzyhgwiO18NRTYY7T6g8sz3Q
	c20imNrU4o/B55vholT0wQbK/8Agz3GchcQySLZrCg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 45I4dxGR852415; Tue, 18 Jun 2024 13:39:59 +0900
X-Iguazu-Qid: 2rWhGbqYjXbexnx3uJ
X-Iguazu-QSIG: v=2; s=0; t=1718685599; q=2rWhGbqYjXbexnx3uJ; m=JMezpYOMp36uCA0vM73irfOWxHScIwmlmi5anE8D7IE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 45I4dwM53241471
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 13:39:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwskNkUR/AVp1yhZjf4V+tm1GaizV7A39UVgVYTgUJZCe51+NEjPDiCwI5gqsjAVVZ1OkE+oNVxp858LRUBflsEXLg/8WcC+Y0meEsLRpZMPHpQHFUutYpnQBrqwHjk9+CeO4oN6M4vfG+lcPhsRErsMyNGvoYKBi69aF7VywboRJZcMZrs1VgeuVkkouLLftMA7bi3bZGeP4dgXn8TT3DYidD/5GNYp8pWXhlLQN76tpRt5g0c9FiUEIVrskpR5WIBw7I9w3jtg0OVR+sPWMo+sGB07L0/KJwiLBkO5K6NoLXRoYJmg1xp38ZhB56oUk3dCBFQCPge4Csp0AO5opQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaKDaSybz+UfxeDZsBSmqB6Kt11Ih6B2SXsaAyoBacc=;
 b=eHMXYOwmUVku9xSfdfecQM/4sSICZK/7bqjkycIgITE6SddfRacPY1oNpM3Gp9s59Om9vI6qypTykRxu4O3ba3UY/Ewmf/hB0coNXbx9XvGyTlDYsQnzeGAJeb+2atBq7zmT1KH06e8hXYzDcWaEjR1/ii6DbjGYnCq4k+RSC11ckqhMEF3728IHi5h0U+FcogX8DsV/BNrG7JeM+8Dh//pcLEltm7asZY3h7ExqRG9FKkyGZ7InhTHAIwwOuzSuO4j1ojuGKeuehj/XvkmsLE+4iaC7RXhatuys0LoRaVBQlOn0g5CobMlgBrk06tx4UtG4/XD7RttD9sagYs+E4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/8] Add Display support for SMARC
 RZ/{G2L,G2LC,V2L}
Thread-Topic: [PATCH 6.1.y-cip 0/8] Add Display support for SMARC
 RZ/{G2L,G2LC,V2L}
Thread-Index: AQHavkRFmcbq60bzL0qUB1PRFCZs3bHM9i/g
Date: Tue, 18 Jun 2024 04:39:54 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388AE7E377B73FA6D232BAF92CE2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240614101845.40656-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20240614101845.40656-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB10683:EE_
x-ms-office365-filtering-correlation-id: 02d00452-dd08-4cb9-c4c2-08dc8f50b318
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|376011|366013|1800799021|38070700015|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?cmQvL0hSdVQ4L29pVFd0dUFUTXVNMlVpRFYzZkRvdE9SL0svSUlQdUdq?=
 =?iso-2022-jp?B?dUQySEQ2L3Q2M3hZMVZZTmJSbzlnWWVaNkNpVXJNNVZKT1huZkRJQTFL?=
 =?iso-2022-jp?B?RnphSysvRVNRUENQUDI5ckJJdkRTb3FFN1RFT293b3F6UEVhVFcvQXZW?=
 =?iso-2022-jp?B?L2pMaGYxcStMWkp3Y0FXY280Y3JxMSsxQ3lNMWdTK2RWSnc2SGdqMWVk?=
 =?iso-2022-jp?B?SnhkL29UanhLZjU0NC9XYThuYjU1cGRkN3JpakpwK3pkRnN1UFpva2xy?=
 =?iso-2022-jp?B?ZzBjdUQybHQ1MlRCT3pIYTVyYUI3a01sanM0NVdJd0p3VHNVSE9xWnY2?=
 =?iso-2022-jp?B?UEprc3dxRko0K2hEc1lWaHJzZTJKYkJXYnZzUkNERnA3azU1cHptMFZH?=
 =?iso-2022-jp?B?a1JuRzRpMC82NlZLUzYyNXNIbGloYlNtalVBampLYXJzMk0xRk90dlhv?=
 =?iso-2022-jp?B?N1ljRUVQSVZkK3dtQ0F4U1FYb2tmYjJwcFV3N084Szh1UUd5cHIyZTJr?=
 =?iso-2022-jp?B?dWN2MkxSNks4dXRXOXZCcFAvUXFBUVhWd1ZrQ3JFSmNMS2d4SElNVmdP?=
 =?iso-2022-jp?B?OGZWWFQwRjVZUjNBajRaR1o2a0lrLzNZUTd2VjRJQjVwOU0vWVRqWGFp?=
 =?iso-2022-jp?B?QlZneUs1S050TVFXL1BBMTZzNGkxYVJ5OHhCa3dvVCs0SzVLOEl5eVZD?=
 =?iso-2022-jp?B?ekRVMjBuUGIyMEduaGRnSndZVm1VTUczRFNUMGlhTklML2cvNCtsVVow?=
 =?iso-2022-jp?B?YVlxbGhVdjFYWUg4VTJ3QW1IZjQ0REVOSWZxREQ1S3JrZmp2M1cxcGkx?=
 =?iso-2022-jp?B?TEVVVjFUK1dqK0Z1azByTllvc2JkY1RBem1sQktuU3dwZTFpeis1aUNa?=
 =?iso-2022-jp?B?cFEyTFUvbHlvNGRxT09zNUVyeVN5SHpzYy9EQzlYR2IxNW1zOVNLSVhG?=
 =?iso-2022-jp?B?RGNTNjV3TXRNa3A1OGJxUmUrSVhROHc2SlltTGs0K0YzREQ5VjFsaDdF?=
 =?iso-2022-jp?B?M1dCblVkakdUZ2FVS3lnYUF6QzJpd0dHNmtoT3ZFcVR6UzZUVU04WGcr?=
 =?iso-2022-jp?B?aS8zWERvQjVudnpXQWJRRHdabFU4UGl2bHhZNzkrcHlXNERLR1pOeVU4?=
 =?iso-2022-jp?B?TzQ5RUFsdG9OU0hUWklpNC9TejVLdW5FZFpacDRkeFl3VzlyanJFVzVQ?=
 =?iso-2022-jp?B?SHN3Z2dqdkF2bFhKdU5NUFRFS0lBMEtDRHMxR2VKdFZxQno5NFM4YlpE?=
 =?iso-2022-jp?B?cDVsb0dPdTFocTc5SzRHangrQkRVa2ZkUFBpUkZWV2R5MjltUTMyVi9H?=
 =?iso-2022-jp?B?R0ZORWFhZkJsbHBnOG5qZy8vNFh1ZmY4bXpJREFIeVFOK3dEVDk1ZUI0?=
 =?iso-2022-jp?B?N0VZanZ1d1NQaEdmc0dZdmNEQmhCTzJSOXNicktpRzh6SlAxc2RvVzNu?=
 =?iso-2022-jp?B?YnVRWjdLVEdlME1Gb3U5SnhxUmwrL29laVNteFBPLzd6TUVMMTduaTNW?=
 =?iso-2022-jp?B?d0EyWjdBTm9PZHpOblNFa0hlSjlSZ3RSTVovbmp4RElaYjhWM2pRaHUr?=
 =?iso-2022-jp?B?aFJqdVJWQVd1N01PNzZ4bVVlNTM1bWR3UEJ0VzluSWRRTmJPWWNtRmZS?=
 =?iso-2022-jp?B?b2VVcGJIcDhFL3Q2QWNHZkFzMHZoSEZyWlZ4ZXdzemhLZ2M2RFUwVEVW?=
 =?iso-2022-jp?B?TFFxYjRuakJLek94VWZOeENES1p2a3lPay9wNzRpTGRlV3FBSERvMmpV?=
 =?iso-2022-jp?B?WXd3eks5VzdlY3VSSDNPQjVKSDJvc0ZzcmNzS2Uyam5TNzQra2ZkNEFN?=
 =?iso-2022-jp?B?WHVpT3ROWHc0NzRxVVg0ZVRmQk9mMUMzVFpmTHRlbUpUaW9vaVZ1SHk0?=
 =?iso-2022-jp?B?SmZtK1MyZ2VKdS9KZVBQVkQyeEtyWEc3YUhvWW1iTXZDMXR2MktwY01p?=
 =?iso-2022-jp?B?NGJxc3cveUVuUlVJYVRkclMxNkEvZHkrMnhrV0xPdkJsczFzOFRJajJy?=
 =?iso-2022-jp?B?aGg5SUNkVjVhc0I1by9HZXo2U1E5Rm5YUnNSYjFQM1JYWjdqbVF5amt4?=
 =?iso-2022-jp?B?RHc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QStsekxoQmtIUlFtU3lIWHNDYVY3d2w1RWVRQVB3MEozTnRldE8wWFlm?=
 =?iso-2022-jp?B?NWpnYjFxeFJ2WkpYNU1qVHFhcDd2cVd1MkozSVNzdW9xWXIvSEkzaDRZ?=
 =?iso-2022-jp?B?cTJkYzc3czRtQTh0VG5oYU5FWWVTZE4yL0lNQ3pDMnVYMkJhWkVBS2pq?=
 =?iso-2022-jp?B?dTk3dVQ4YVhEc2hjYllLMlN1NnZkZTcwd1pkV2ZiNkRnd0VXUml2U3VH?=
 =?iso-2022-jp?B?VEpoZmN2eXFOSW4xK1cySld0Vy9aTWlHb2ZaKzdoQVlmendOeU9jQlI5?=
 =?iso-2022-jp?B?L2c2b2FTYUdJajdQVVdqVmlZeXNNWVk5aUpLMjFwOGVNY0JNKzd3elNZ?=
 =?iso-2022-jp?B?M0FUYk1CTFBYRzY1VEw5aWhsa2N5YWEyMjBRVnB1cDZkNHl4RFJmQktS?=
 =?iso-2022-jp?B?Zml1eUtzNlIzSE80aGVGbGg2VDlLTWRKWlFLK21pTE9nUjE4eVFwb2Ev?=
 =?iso-2022-jp?B?bWVzekZXdk5Days2MDkzeUprK1VPNUZxempmeXlmSlFuNUJOQVVuWmJs?=
 =?iso-2022-jp?B?RGtpbU1aZHRwSFg0d21MMmhobnZkMVFwblY0ZEdHMytWUTVOS082dTZE?=
 =?iso-2022-jp?B?L3lYSkZZdUJGSHJrZUE4aE5JY3d1NU8zRERwQzZZbTBZOTBLZ2ZPWGtt?=
 =?iso-2022-jp?B?c3dGNDVKWkU5Nit3RG4zWTUrY1hnMllOalY4NHJSZHd0K0p1WThXd2E0?=
 =?iso-2022-jp?B?ZXJQbEEvSmxEOCtiV1dQSE9kTzk5L21qMGNheW81eWRYNG5lSWp0UFpD?=
 =?iso-2022-jp?B?bVNHU1NJWWt2WGdvUWJ2OGYxbTlQelhPZllxSWFuNy8zWXpQNzNkTWU5?=
 =?iso-2022-jp?B?cDVRSjZMVTNlU3BYbVE3R3RhR29pVkRQSzg2a0M5TFE3YXpzZDdtenpr?=
 =?iso-2022-jp?B?VHFzcWVEU3dEMmhGWlBRYVpYTHJvRk0vZmJSSFBTc2VaZ09lR0JjODAy?=
 =?iso-2022-jp?B?RW5vZGkrUG4rN3hraW41aXJNT256OXV6RlozUUZwNC9QVXNEZlRaa3JN?=
 =?iso-2022-jp?B?WW82QWZ0U2pjaStwWmwzQUdXMU1OTWJPMUNRRGlHZUpCdk1rajFwb1Zj?=
 =?iso-2022-jp?B?eThkM21iV05maTAzREdVemVDYVFmVUpBT3J4TnFXMHg3eFBhN3owSXJk?=
 =?iso-2022-jp?B?Rk44NUNHN0JBNmxnYjNtZlpTRUwzaTlmVE8yY2JqbWEvRE53b3VQL0Yy?=
 =?iso-2022-jp?B?bUI4QjMvaGF3L0haZnZJN0tKVDVhSW5EU1R3TnRrdXlUcUl2cU0zaGNB?=
 =?iso-2022-jp?B?K0RaeDJlRjMzZnc1YWVCQjlwN3RkSWpER09yZ3ppUk9XZldENURGelN6?=
 =?iso-2022-jp?B?V3JXL3VUNzc3aFZOdlpEdjV2Tmx4YU5UUTcwUGFidmVsVnFSSTF6M01F?=
 =?iso-2022-jp?B?dk82OTRpa1d3Z0plUmtnMlJOdFVUeUgybklUYTB5UFVxWVJXajdmYS9z?=
 =?iso-2022-jp?B?WVc1ay82NUtadElMZ3lRNkJscjlRRFBhV2hGRWYxZjZTbFc2Y0JnOHRV?=
 =?iso-2022-jp?B?RFh2b3lQa1czMjJVOW94T1NCdmkwUGlXWHNDeWhONktrVVZzZWNWYVpX?=
 =?iso-2022-jp?B?MTFDSzJ1TWR6V2lwaUFTZ01BYmZ2ZEpPTlBPemdBaEFCYzlzREZ0V0dE?=
 =?iso-2022-jp?B?ZmRlMHN2U1B1cmlrb1hNZWJFWkh2WU9kU1NVT0tjQjExTGd5b0svZ0dx?=
 =?iso-2022-jp?B?ekVSK0J2NWFlNWVLOVVwcmd3OEp3Z3BLQzlTZUhOTkQxaDEzSEhIdTc1?=
 =?iso-2022-jp?B?Z0RUaWhxanVKWnF3M2dqSGZvbmpiQUhmRUNzQnVxbTFzZG9xcjNlWGFG?=
 =?iso-2022-jp?B?Y0pSRVpabkhxM2lCUGExVHhsQlA0NGk4ZDB2UDk4LzJkN0NDQXMzcW5Q?=
 =?iso-2022-jp?B?cWRTbDZrUlEva1VrUUlwSGFIVXVzYzdXM3V6RkpnTHI2UU5nWDhPYW43?=
 =?iso-2022-jp?B?WU9lbnZVRC9SSFNINjRlcURTbm1yVkN5YlMyN1RNeEFGUi96VlFVZTlO?=
 =?iso-2022-jp?B?dnVwNFJ2YlFoOS9wSDZYRVpFUGhVcmpIbkdkaVdCWFNwVVVNLy83MTYr?=
 =?iso-2022-jp?B?NDBzV1hUZHZtQTFrd3c3ZVpnUVlSaUx0R2JrWTFJYVFOZWsxNll5N01M?=
 =?iso-2022-jp?B?ME5WeklrdnUrYzcrbzVyRWpxRjZucXpCVjZWSlU0QWdMTE9xTUJVSEVy?=
 =?iso-2022-jp?B?UFlyVUNNUFRhd2pzdmgzWm1NM3crR0dvS2pYNnRRR0M0SHRxWUhpcFF4?=
 =?iso-2022-jp?B?VDFmdFhzaTdORUl5aUxLdVk3dkpWREcvdVFxa21MbnBuQWFBVW5McDN6?=
 =?iso-2022-jp?B?ZXdRNmxkd1JUSTk3NWpCbndTYXdZM3JrL2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d00452-dd08-4cb9-c4c2-08dc8f50b318
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 04:39:54.4166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zq7llqcOm6raFZ1C4tRFnhYucDHfxxIulHLUaeYSbnYebfwaZfDOONLrHY4MKPKGWjgabcJexJ/VwnAVUN1CsVP5GLLpx4Dtc/A0q0MiKP7myAzHyXdOUsvQ/ncY42vK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10683
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jun 2024 04:40:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16271

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Friday, June 14, 2024 7:19 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 0/8] Add Display support for SMARC
> RZ/{G2L,G2LC,V2L}
>=20
> This patch series aims to add Display support for SMARC RZ/{G2L,G2LC,V2L}
> EVK platforms.
>=20
> All the patches are cherry-picked from the mainline.
>=20
>=20
> Adapted header files/KConfig changes for 6.1 kernel in patch#4
> (0004-drm-renesas-Add-RZ-G2L-DU-Support.patch)
> similar to rcar_du and shmobile drm drivers.
>=20
> Biju Das (8):
>   drm: Place Renesas drivers in a separate dir
>   dt-bindings: display: Document Renesas RZ/G2L DU bindings
>   dt-bindings: display: renesas,rzg2l-du: Document RZ/V2L DU bindings
>   drm: renesas: Add RZ/G2L DU Support
>   arm64: dts: renesas: r9a07g044: Add DU node
>   arm64: dts: renesas: r9a07g054: Add DU node
>   arm64: dts: renesas: rzg2l-smarc: Enable DU and link with DSI
>   arm64: defconfig: Enable Renesas RZ/G2L display unit DRM driver

I reviewed this series, I don=1B$B!G=1B(Bt have any comment.
So, I can apppy this series, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


