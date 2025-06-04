Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E826EC5B552
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 06:09:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.9688.1749017342420994767
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 23:09:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=OFD1bRtp;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1749017328;x=1750226928;bh=Ic3VABtYIZftI4MvEl9SMdSfqca7OmHFnfzkQOL
	CWQ4=;b=OFD1bRtpxj9885CWhkum8yKgzdGHgVgaGZuUs8YbCx+B5Ucna2uRNrXDIIiXwYGHjSkzG
	4x+ylBYUCRclu1/e2oQbHkPDiTzbOJpfJF3VdRg864fEBXGSlWVoygjOfMVfaKj77gJjZyDo+m4J0
	BDDJk9Urr+t07QGeq6gP9MoQ7z94OD8BdX+FwqyWD9OdBr9zztCuk9wsG88ZwdwUwla4SUhMj9k8c
	aNu628gySeTXR7/okEcZOYvFumiYl2A0Nx/CRMKvmyr2zBahwrdjvdJY75vsDeCzTy8XFT8HbzlS0
	pMHrrLrU4qYghMjsJMbNaIfPW4WvxA/V1/qzHaaI3w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 55468mEx1799078; Wed, 4 Jun 2025 15:08:48 +0900
X-Iguazu-Qid: 2rWhqikyfvAZlfD6G9
X-Iguazu-QSIG: v=2; s=0; t=1749017327; q=2rWhqikyfvAZlfD6G9; m=pt1jS0vBtZ1IHuAPQrcShzjCgW/BptXnAiTp34SCCdY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 55468krF3511039
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 4 Jun 2025 15:08:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GeWoXFOCYPextdcSni2R7jcLX2z4HScBgHWDtAGwg4Ukue6zxRqyTOmYtRZ6oXLp4MtCrZxkDbZ7Rb64OzbqTxshWeC3FCyJOctPOEwIY2T9MqNX/UdWljP4vlPLf8SYZEZv0Z31q0qmeCO1bouIL8wAd0rZNOpu/pxbK/4nkWgz7fTL+OjhM7m0kxbfATzmZCFts9vv7n7KByV9sTBA9aj1TyCpKY5CLXWeKAKXDjEC9ZPMhjlvsVnOhMYP60evlW5Qk6TLyufwIbdsg4yCL8KYoV7s7QrPupCN0ZkdY4I4nq5jfhGFbXJpolwZECkWrZiOBh3IHAW58mWI+tSXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/VLtihfIbDWbMMCS08AnqiWKv/kxZovWwwY4RvPd4U=;
 b=Yg6MJhR+DbwU6L9He2FBCX5BD5vLTDdxbCrDnv2h6WTrKLzN0krmX22LnfDjbsotSk7NHR0Gg0/0CK61AhTAzit3khLYYvROCNMY8SW12c24QxmRDj3cDoFd9PBrTSpp1t2uWg4RkYC6hEelcnfH3RKRYhjw6Og3sqsAh4MV2ErKsUU+J/enNn58ISqe/lgkF0V+JIbzCBEfiPIxzlS/GoUnxbTVk/QgzqxfHq7Y8RYuldahQ8CUusJEvIuDl+HWZRNZCGE+mU3B/Q9Ppo+CtjGpQWxnj5uXnQ2Khw5kyNGCXN/aYGKW0cditRRE8t4Hsm2ee9LqjnULAhjDH8NxCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <claudiu.beznea@tuxon.dev>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 5.10.y-cip 0/8] RZ/G3S: Backport SCIF support
Thread-Topic: [PATCH 5.10.y-cip 0/8] RZ/G3S: Backport SCIF support
Thread-Index: AQHb1GiVraiTMyrAD0KDMzF3YZz7aLPygocQ
Date: Wed, 4 Jun 2025 06:08:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818FD9A1E03EE9BF60F7EF1926CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB14718:EE_
x-ms-office365-filtering-correlation-id: bb1e9be5-d1f7-4c0f-0343-08dda32e4299
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?eFYrbTBaOXBYZUovVmRjZVRvNXlzcXd0V1QrQzl6UjQrenhBcFJwMzN5?=
 =?iso-2022-jp?B?ZGtmYWVVTmNLL1dMQzc3TklRVVBLb0lTdzlXa2VOQVJickxzSnFWNnp1?=
 =?iso-2022-jp?B?MmhtSTlWN3ZSZjNuTll0anpBTFBGV1lPVlJST3RTVm9nVlVUSFF6anFC?=
 =?iso-2022-jp?B?Q3BqZUhBZnZSTmlWWFNJaE1zQUI3TDU2SUttU1hKY2xRUVZ0VmEwc1E2?=
 =?iso-2022-jp?B?Nm9yS2IwNmlTeWowYUxZYmc5a0NYeThkbytzMVdhVGMxZFZXTElOVVRC?=
 =?iso-2022-jp?B?N2wrV3NGc3Z5RiswWFloNzFxa1JEUkMvaDVFMHJyY3ZUWnIydmdnbFcw?=
 =?iso-2022-jp?B?YWsvLzhmaXRIcTEzdlRMVEoyNEV4dVJrbnhsV2NQN1JKWUFLRUxJS3VR?=
 =?iso-2022-jp?B?SEpxck9QTW1aZVdLVXFaMk9vdFRvRkdad0lvQnlXSVV0R1lYblpSemZh?=
 =?iso-2022-jp?B?NzZ4RTBJRmtaMUY3ZEFvUGJxVnlMaUY0ZUJFb3VmM041V1NJOXZKcEU3?=
 =?iso-2022-jp?B?b0xxNUhLZk5XK2VNZGVWcXRya1ROS2xkVjBQeVBwRXF3TGRXUDh1MVpX?=
 =?iso-2022-jp?B?dEI1bEdjTnUyeEVQYWhvR0hrbGZSNVZibnlLWkdrSitpODQ3TG9SWlhk?=
 =?iso-2022-jp?B?N1EvZlU0eHh3NU5URktveHVoOVRDWjhGaTd4TTVjeW50eTIzcHF4Mk5z?=
 =?iso-2022-jp?B?ZXdIREs5WUV4T2hNeHp2MkFsY3VTREVkaHRtbWxtSk1xQVhjZHY4dWpL?=
 =?iso-2022-jp?B?OGEzQ1pOZ04rZTVDcllZNjNIQU92clJSMXZvYzZPYWR3R3EzT3dFbkNV?=
 =?iso-2022-jp?B?dG1KTW1MbUI1c0p2bDFYbzNMblVGcEd4L1Y5eUNzdTJ2Z0lhTzcwTkkx?=
 =?iso-2022-jp?B?TzRoVlhKQk5UY2xhQU81L0t6cGtMMXdmRWIrcGlZZ1djMG9hYncvemcw?=
 =?iso-2022-jp?B?cjgwKzRKWlM1anZneGVQdm5YSG52SlVXM2RPSnlhRGJvRDU3SlQvREVj?=
 =?iso-2022-jp?B?d0hkVmpCaHBEWjhyYi96QzY4R1cyWlVTWjVhVzJsT1FPKzdZY2pSRzQx?=
 =?iso-2022-jp?B?djBaNmxXbEpSZmZ5bnArbzIycWNqRERobmtiNktBUXV1Qm5DNk8xOHl1?=
 =?iso-2022-jp?B?L0NZSU9vNmFlbEdRQ2JPREM4ZUV0b0o5YWhycCtIRUdSTWNObEpGa201?=
 =?iso-2022-jp?B?TnZyMTdMN3dHK1JwMEk3SmZBZFd4cUMvTWxwVGZQenUxeTlzbDJxZUw3?=
 =?iso-2022-jp?B?SHBzQm0remV6MVZ0Nk9VakpLcXBrOWlmWkRibGg5S1hHaFBRR1k0WXEv?=
 =?iso-2022-jp?B?T2lVK004VENxc0FnazhCcnM3MWZsWnpWZ3lHMkNVZTJQdXNmZ1V3OFhq?=
 =?iso-2022-jp?B?clZyS0tkeGQvNEVReWk3TW9vdVVDaHNnUnMyOFByVFBLVXJXT3F4dGEy?=
 =?iso-2022-jp?B?a28waE9RaHdBOURXUGMyWkwwSEI3ZytIWGNtYWZvR3I0TE5ESHhnRitB?=
 =?iso-2022-jp?B?SlB6V1VDbFFWZmVyUThRM0lDZlFZd1FSMzFFVUR4dG44Wm9CeGxteHhH?=
 =?iso-2022-jp?B?QVplRUdXa2NQQjlsZ05TUlpBOEFDbDRwYUdhOHoyY0FBdzJlSUpIMlZE?=
 =?iso-2022-jp?B?b1d3RmRZaHVQek5BaU1QWEVtbG5oaUFrV1JGcGR4Vk4xaEU0aTBaVk5H?=
 =?iso-2022-jp?B?elR2R3NkQ1k1SGdWQ0xwSEhRU0ZDN1d6aWtZY0oxV2tCcnBhOTIrcmZn?=
 =?iso-2022-jp?B?c1dUQ05Wb3lZekE2QWMvQmxCbHFUcjYxZzJLZ3VsdEdiOXNWbndoUWpp?=
 =?iso-2022-jp?B?WkFvdzdlbkcwazFxNk5IbE9ncngxOXV6SFkzaFNtTGhNVUxrR08relJp?=
 =?iso-2022-jp?B?bHM2ZnFRNTZBUkx5NHNuM0VEdlJPQnhzM1NQbDJnTVdBRWI4dDJna1oz?=
 =?iso-2022-jp?B?UHoraFZmZmdxVC9GMEtndkllcjduQ0FFU0dGZStoQUxvTUZvNWFBcnAz?=
 =?iso-2022-jp?B?cWtvdlFITnBiTGoyb283NlpjdDE0NjhLWG8rTFlBNFBXR0k4SnhaWnhq?=
 =?iso-2022-jp?B?dGh3bkgzMWdHbW9aZHJuSnUwYXFJYTA9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?di9ia25XMy81TkxiVHUxOFEvbndoMG5jMVQ2bFBHMWt4TndxVlFXQnUv?=
 =?iso-2022-jp?B?VHJLTlNNZkExcjFKc3BHeUdXNGdFRld3Z2dXTGxNTVpjczVPSU5QQjJl?=
 =?iso-2022-jp?B?UGhBWWlqVHN0L0JjSS9CbVdYMHVtZTBFMmdJc3ozbXdiM3B2b0VMYzc3?=
 =?iso-2022-jp?B?eVc1dmcrTGZkRHNzVHUvUG4yd05pcDZsNFFYSXNnbk9URm90U2t0MjMw?=
 =?iso-2022-jp?B?Yzl1K2ZQYVBac0dPWVFWZjdqb0ZOSlJpNDE5V2FyMmdZVHNid2pxcWN2?=
 =?iso-2022-jp?B?dUJSZTJ5RmZpWlRGM0N3aUx4Mm5NM2FsOHJaM2c4MmVJWkx6dTFOSG8y?=
 =?iso-2022-jp?B?cEY1SG1td1JwZkRaZjlPMU1JRkdBeDZjSkJpY290UHBxTWpIV3c2R2da?=
 =?iso-2022-jp?B?VlBRS01mUkIxWUtpdG9DSjNRd3pyRFc5aW5ldjBiK1VJcjVlQ2FMQlVj?=
 =?iso-2022-jp?B?Tm5tc1FrMWdVRS9vamJZVmg4OW03azZZVnJKS3NaY3poYTBuUjljZFN4?=
 =?iso-2022-jp?B?dFdPVGw0TXlaU2xOMmxEczBKN3N5Sm0rcWJnZ2xBUGR2SUFha2lBZjM4?=
 =?iso-2022-jp?B?OHQydnRibGM1dkZleVFodkpxRzR4cE1IRGJHTFltWVNDRTQwc1lZd1FO?=
 =?iso-2022-jp?B?YkRNTEtuOGxNNjlxK2c0TlZ4OFBmRUQ2UlZWUkxSOW1TZjNBZ1ZXRzR1?=
 =?iso-2022-jp?B?REpSQ1hWWDR3UDJJU2U1R2xsRzlSY3pNNVhVNUx6dGJ2ampTT0VxM2N3?=
 =?iso-2022-jp?B?N25Ka1ltYnhweVVCeFgwZVdJSGlVNFZHZGtTdWdsZGRHZFhxSC90a3ph?=
 =?iso-2022-jp?B?YWdDa2tvdEhVOE5PNml1REV3eGx6STU0c2tHRCtaYmMydlFyUXl1WWx6?=
 =?iso-2022-jp?B?ZWlHb2c3VURGeGRxTzBGek9NL0JrcVNMenFvZWhkRDlsQ0R0WmpTSi9k?=
 =?iso-2022-jp?B?Unlnb1lGQkRvUThvS2FQRGhXdlN0RGhLc0c0djhFTC94WCtvTHdYRWpB?=
 =?iso-2022-jp?B?SjhqcjJuMG9kNkFEd21jc0VjZnZ5OUtxUTRpR3prcHl5TlNhTHJweUxq?=
 =?iso-2022-jp?B?RWZWTEI1WFAzWUhnZ3dmS21yaVhhenBBakJZdDVnalQvRkYydXJ5dDln?=
 =?iso-2022-jp?B?RHJrNUJNTjhGMThMR3c1eXA2T2lIdy9iWk1wdXQ5V1hqNFpRa0NFY29v?=
 =?iso-2022-jp?B?OEU4a0RTTS9qUEpyU3ZEdUhFb3dVQVFNQjJlOHk2SW8zMjJhb3ZCODhq?=
 =?iso-2022-jp?B?ekUxZkZZY3dnWWpHeHQzY1BxM2FsSkREcnFWU2RZam5XbFkrdHphbkZo?=
 =?iso-2022-jp?B?TnR3TmsydUxBZWVLMFM3cGQxQVBzbk9lL0NrOGZhWFZsa2FSVmo2NVll?=
 =?iso-2022-jp?B?UWlaMnQ4TFFQRklwOEtjRDBGMkh1ZVYvWkRWd0xuTnAyc0Jic3lpdEkv?=
 =?iso-2022-jp?B?Q0JZbXdOZkhyZVR2dytXZWpVRlpYWFFaaWhMS0lmY1Z0YytsMGlTWmZR?=
 =?iso-2022-jp?B?WmNIRExQb0hXaU91OG1JdGNMNFY3VDRvWTFUVjFuRjdMb3ptODJwMXZx?=
 =?iso-2022-jp?B?aExTSXFEaFdCb0lKbkxJcjQ4eEx1Rm44dEVXODk4Z0NkVURXd3hiTm1X?=
 =?iso-2022-jp?B?N3dBb0ZDRkpNUEZkLytxVFlVUUwvbzZNRHg4Q0hXTlVja3QvS3BROURV?=
 =?iso-2022-jp?B?bTR0bGVKVnExclE4L1FEUjdaRUxDSjdPeUE2clRzMngwamdxOGlpVmla?=
 =?iso-2022-jp?B?Y3UyamNieGxodk5LdG1EU3NwV1ZSaDdNeWE1dHk0VHRmTXB2Y2NmaWJu?=
 =?iso-2022-jp?B?TUR6ZEc2ZVZPeU5BVnBMN3BibndpNlM2bjlkVE1UMGUrUVF6aDNXZ0tm?=
 =?iso-2022-jp?B?SGprSmNtUFRzVkdTUmhPSlJnSVErM3VFckdHZXFDZ3YrTWxiSUZzeit1?=
 =?iso-2022-jp?B?MUlMdlczNFE3dzlVaE5GNHR6RDBmZzVvUnN1S0cza0xPcWcwWiswZUNS?=
 =?iso-2022-jp?B?OFFNUE9LcVA1VTNNUkx6ZmFnN1VxaHBmYkVGeklORkN2MVdUZEJKQk5I?=
 =?iso-2022-jp?B?aXIyamkzSmZUeEdxdm5qWFJmNmpuUkF2MG5JMGNuNU9wNEQ0Q0F0aUFp?=
 =?iso-2022-jp?B?OEdzS0I3N0MvdEhyNVRrY0pUelNFTi8zUTRyZEQ5Mk5aQnZma1dHY2JH?=
 =?iso-2022-jp?B?N2tOQzFGeStZOGd6NFBYamlTS3ZrWXZ5NjZBUnVUSWI1R0tUcnJxZ1c4?=
 =?iso-2022-jp?B?SzlsYTFrbXB2YnJ6UWFnSGE3YnVNbElybjhzNkFZcGh3NmJ5anFGOUsr?=
 =?iso-2022-jp?B?Zlc3ckdlalF5a0dWcytVZmM3MDVybEwxNXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1e9be5-d1f7-4c0f-0343-08dda32e4299
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 06:08:43.7108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PifbvXvWhovgbkZfHhyaFnCBCnov90J9VsBNjfqNOtJgYFIxlJzxcbKOpxUx6rzOheQXCHmvNUW5i1M+Fwq9G+SnYErnEpd7zOGmH+5YbuhJ6NukFLVBfC2hBMx4a/Zz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14718
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 06:09:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18996

Hi all,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Tuesday, June 3, 2025 6:19 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.de
> Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org
> Subject: [PATCH 5.10.y-cip 0/8] RZ/G3S: Backport SCIF support
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Hi,
>=20
> Series backports the Renesas RZ/G3S SCIF support to v5.10.y CIP.
>=20
> Thank you,
> Claudiu Beznea
>=20
> Claudiu Beznea (7):
>   clk: renesas: r9a08g045: Add clock, reset and power domain for the
>     remaining SCIFs
>   serial: sh-sci: Update the suspend/resume support
>   arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
>   arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
>   arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe
>     different switches
>   arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
>   arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1
>=20
> Geert Uytterhoeven (1):
>   serial: sh-sci: Save and restore more registers
>=20
>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 90
> +++++++++++++++++
>  .../dts/renesas/rz-smarc-pmod1-type-3a.dtsi   | 45 +++++++++
>  .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 25 +----
>  .../boot/dts/renesas/rzg3s-smarc-switches.h   | 40 ++++++++
>  arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 21 +++-
>  drivers/clk/renesas/r9a08g045-cpg.c           | 10 ++
>  drivers/tty/serial/sh-sci.c                   | 96
> ++++++++++++++++++-
>  7 files changed, 300 insertions(+), 27 deletions(-)  create mode 100644
> arch/arm64/boot/dts/renesas/rz-smarc-pmod1-type-3a.dtsi
>  create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h

I reviewed this series, looks good to me.
I can apply this, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Test:
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/185234238=
0

Best regards,
  Nobuhiro



