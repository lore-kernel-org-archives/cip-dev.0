Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784D9C282D0
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 01:46:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.3995.1741139186068333413
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Mar 2025 17:46:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=Fb6BTlY8;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key3.smx;t=1741139172;x=1742348772;bh=sOKzwsdlsXZ8aomYXm1JqO9SxwS3XgO6WiXauoo
	+6s8=;b=Fb6BTlY8annePC4QJeYmibL7qwn+CUUQ7Sv5vGx0G5xXtVSV7A6szXw6MR5nXho5Xp1U7
	caIsSxUiXACnNyGgmrUbEfupZk4xeVE3zTKfgnseqhWWYiAAS9bbzDSNoHvrFgUaycVNbTL6AIBuy
	wiEdXUh8o+vK45Awmmt+72WvWCs+D1L2U5koftDJAu3D8WsiFH6XOf2iIqewm6F4EQtr5NqgqlWB0
	li5fznWBCRASVieV1TugXUpYQvkOUr1FJeEFBJp8Pmvc1kfmdzK79euqVkQwQVOOZllt4UZHED820
	dTVeWVFqOFkwLNyFZWsYogL5XVwew+afvPxrcD4izw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 5251kCRN3443832; Wed, 5 Mar 2025 10:46:12 +0900
X-Iguazu-Qid: 2rWhyCKR5MfWJtD832
X-Iguazu-QSIG: v=2; s=0; t=1741139171; q=2rWhyCKR5MfWJtD832; m=KrexYKRLZvmIrSiy3ilR95F2StOzKAJSUyuI53yYXmc=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 5251kAXQ2190687
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 5 Mar 2025 10:46:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZb9A/1FAYn5zdKtixtHKs0w1e6tNyHGmg0dOC2u3N011WBnbDHh5ZWhSTOe0eReZUupdaG9d61TpMRCJt+XcTbDsJNm0LVoxvfExVxvmkyhTMEaZMxN+bWLIscFTpTsN6CtewgpqaPXx53BJPRSxmC0GuQmcxzJfve8egDyebKWclyDZvglSQ7mJCi5c6ECOXpHTKy2Iasd56GKyJR7KDHt0m60nOhrygkyUkLiDCjkVPxmaPtHvfKokJbpbhRcXDJXxJ2feE5ao5jlfW9H0E5WkfYJpUff1YPwywuWTzhpVifsq7Q5hzeofKZlBKnbM6e1wjEKSlDQTRr91GkXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+2r8brrPB57BoiIAJpGFgvJuYytqhF0n3dwL7BNKbQ=;
 b=hj01caBOyCCHJTL30WL9tHU4xzhS24gpsXRNKTR6m5ns6tN4xY0eHqZfbugZeiopC7HKY+JSKlQOWhrYGWXqVcivw1vYwBE7qHErGLrq3EnXmWDkQPQ7seuuEcGJRNAvNfxj/fg/9zkeO7Tb5d58IuX/gs1tlXlj6PIpulsumjsaAtooABj+zN7otc4UxulwJO26M00ueYP2lbfQkxzSbepa0dBxCC1enm+ol6ZL+W8BztDB7VqT4P5gr09q/cuxCy8FqmoDQyHhjmee5/gP6ndrFO0wZ59WUzTH4wJKMUs7rD4Qn336ctQ4nq7FOgNtV4SX+TXyazXi56Tq1oiX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 00/12] ravb backports: MTU fix, VLAN &
 IPv6 support
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 00/12] ravb backports: MTU fix, VLAN
 & IPv6 support
Thread-Index: AQHbiS0Z2h/A+7axdUaS0103PzcyMrNhJ6tggAAE3YCAAZX4AIAADlAAgAD9AtA=
Date: Wed, 5 Mar 2025 01:46:08 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818F8FA6C72C7AFB5C503EB92CB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
 <TY7PR01MB14818285CED4A08E1A8690D2092C92@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <Z8V3nYpwV72TnVZy@duo.ucw.cz>
 <69b929e7-36c8-4705-8fa7-708395bbd5b1@bp.renesas.com>
 <Z8bYLLQBMnxUMiR8@duo.ucw.cz>
In-Reply-To: <Z8bYLLQBMnxUMiR8@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYYPR01MB13498:EE_
x-ms-office365-filtering-correlation-id: 3a18d44d-b640-441f-9e32-08dd5b87803c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7053199007|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Umh1dFpCQVZ0YkFBNTIyUS9FUVNRUFY2VTdGRjYxSXdCTmh3VDRWZmFr?=
 =?iso-2022-jp?B?YVFCWHZTZXNNK25OcEFJNWROV1JnV1JsNEo5RFRlbEpYSzlGa1dEbzh2?=
 =?iso-2022-jp?B?QkI0VzBndlVYVzExL3NBV0sycUNDbkRIdHNNN21obFJwbnBPZnFnY1pw?=
 =?iso-2022-jp?B?YmozTVVsQUgvbkVHUU9CVnYwR3ZMZ01VdXpseTJpVHhCNHNKUURMMXdn?=
 =?iso-2022-jp?B?VmdYdFdFaUM0R3k2Y2dHZGxWR3k4NVJ2cE1paXJuckZubzNaSDFGWHlz?=
 =?iso-2022-jp?B?V29xbVRhS1NjM3dMKzQyOEt4c3NOWmt2ZlVlaXQ0T2RURTJjVGVnd3pU?=
 =?iso-2022-jp?B?R1d4b29WSkVoWVNDNFpzdUpwbUlieGtnR2pKQWozM2VHYVRiWkhtL3By?=
 =?iso-2022-jp?B?OS9HNURLS3JucEVyVG1CRTQ5TlVMN3l2enJIbEovaXAwZE9UbHBvYnJH?=
 =?iso-2022-jp?B?MUR2N0VWWkUvditqQ2RHcmlWNTJxRlpJSlhNWnQ0MU5Ec0xGb3pzVFBO?=
 =?iso-2022-jp?B?V001VjRUc3FMQTVFTDNDMlpzcmpxM0ZrdHdRNGVQYTMwR24vMjQ4TlYx?=
 =?iso-2022-jp?B?TWJrNnFxK0prbUVwRElUd3ZYT2FHNVp5aXl4NG5Bd0UvaURXSjhyd1l1?=
 =?iso-2022-jp?B?b09jODRrQ3N2QlV3M3R2M3Jlek9mU2huWFZER2N5c3BCUTZyZUo5d1Rk?=
 =?iso-2022-jp?B?YzJGOGMrOW9UK1Q0RFRSZFpaVE5USU1ndFdSYm8zc2luZXQvZkU0SWVM?=
 =?iso-2022-jp?B?dE45TXJBTzZTQzJ5aXRnYmdwS2RDZ2pmd0dnaU5peFQwWWpWK1R2bmhV?=
 =?iso-2022-jp?B?RGhySWhJaW5PWUZvL25ZcE8rdnZnd0xPUUZCMHVpUXBhYm5xWExxQXky?=
 =?iso-2022-jp?B?SHJud1NPNzlFUENSeXNNL29xYnh1ajdLaXVmZDlZcStNa1FuWTlNS0Fq?=
 =?iso-2022-jp?B?Qk80N0hVSHVBRlJoRE9VbEZzZVZhSkNoZFpTOCtMOXJkZStWelJpaFpx?=
 =?iso-2022-jp?B?dE04dklpVTJDOFpVQkoveVBSZVNvOG9HU1lIbkRWN3NqTVR5Q1Zva3B5?=
 =?iso-2022-jp?B?THB4RURXc2dHcUgzQmgwSFIwbGx6ZS9UQXJ0N0E1YldRSCtSRDFrSmhF?=
 =?iso-2022-jp?B?L1hrb2gxSHRoUG5lcXIvenpYTmdmQzNVOURTdjFkeFg3bUF5TGhwWW5Y?=
 =?iso-2022-jp?B?bzhORDF1cXpHQ2VRd3U5RXMycks0STRobzQvNysyTW0yOTVhdHJiSDFm?=
 =?iso-2022-jp?B?dGxMeFhhT3NaMzNjWUJ4aGJ2MnphTis4Tm1CLzY2cEdYUzJEbFRrS3N0?=
 =?iso-2022-jp?B?UUJuMEdLc2RJaGw4NlhGVGdnTkZsaVFoY2orbXRHdzg1REtPY09VNEpH?=
 =?iso-2022-jp?B?Q1JoUzBuYUdFRTl6QmtIVFNyN0EzYk1hSTlsOGlmalRnRk0vbmpRWmls?=
 =?iso-2022-jp?B?SzRoTjhWYzNIdVcrOHYzODNUTXhjUWlVUE9sTnN4YnFqRXZCVSs3NUZ6?=
 =?iso-2022-jp?B?NC8rTEVhYncwNzgyRVF1TmRTYlRXd3M1bm9Pc1M2OW1jUjQzeUlYVHgw?=
 =?iso-2022-jp?B?a3NLRXlzT3NVZjRYU21BRm4xRTA2cThWRCtHVDFOWFdPRGhnYWQvV0Qz?=
 =?iso-2022-jp?B?WFcyK0hzWVNucWdUQlZUNm94dWFqdndHc2FTYXR5eGdxeno5RHp3eG5O?=
 =?iso-2022-jp?B?UW1EMFZJakJna24weE5ERUZhTE93eVBwMkVGdVBtNHBXRkZKM1Y1Vldn?=
 =?iso-2022-jp?B?S2NkalUzeVNncW5XOHc0RWdkUU1HMXZaTnY1UjBUNExuU250VXQ1WmZW?=
 =?iso-2022-jp?B?bE5ndHUreTZQYWZxOXdIQTR2NjgrdUNuYUdkK0JGY1c2NXA5eHNFRHBi?=
 =?iso-2022-jp?B?YUxYdXdRdHhIdTd5eGdGWW5kU0R5UWdDdS9lYk5qTVZqVU04MXIrUHBt?=
 =?iso-2022-jp?B?RVY3MlNPSm9XVWYzMlliemh2WHMrY0FFK1JIbDlWZWRQZGQrOGhEcTBw?=
 =?iso-2022-jp?B?SmlORU0reWpxRHNubXhuZlBWMjlkSzYvdExRU0RWY01QYlNJSFU3TFZH?=
 =?iso-2022-jp?B?T0RlakpuT1hyRjNaaDVaYzB3WWtzbTk2RVZlUUc0anpPZkszMVcwaGIv?=
 =?iso-2022-jp?B?dDdsNHBwZ3h4dGdoVEd2TWFrM1V6dHcyMFJSUFYvWmJFNkpTREt6RXpD?=
 =?iso-2022-jp?B?OFlzPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MkNaSTIyamgvMzN6aStoeHpmaE51RGx4Q2F5UFZuLzNNQjBFN3BzWm1j?=
 =?iso-2022-jp?B?V3ROZzdmSmhjWGtSZ3pCdEViMEplNU92bmNOOFZmUFQzODdBSWRyNXhR?=
 =?iso-2022-jp?B?d0VQemxHVFFuT2xKc2FNK2tUTGZCdVlzSzZYY1hMMGRHZVpqWjhPcWx6?=
 =?iso-2022-jp?B?bCtUMU51NTVzUmxRTUY0VUlRNERTd1JneDZIWG9YUWEzREtaZlppUFBh?=
 =?iso-2022-jp?B?SFU2RE9IVnZDditQY3RnbUtla3Vjd291bVUxa3hJclhoa3ZlclpPTUVD?=
 =?iso-2022-jp?B?elR0VW1kNkZHdGF0QURTREU1dkJ6WlJJWFQ4UGxjR2hFWVNXNXNUQ3Zx?=
 =?iso-2022-jp?B?YVZnRmNlZjJ2d1RXZEtqUTg4MkpGUGZUenhwQWliT0ptb2dENXVvK09p?=
 =?iso-2022-jp?B?VFpFYys4Y2VQcWdWaWI3anI5RkNoSEJhdXU2bXVtRFFmaWVUZjhhbFZu?=
 =?iso-2022-jp?B?OVJUOWNkTlVVcTJnTlU3TEEyZy9NaExwb2tpbkVuL2k3dW9IWEY4RWxJ?=
 =?iso-2022-jp?B?bTlpVEk0Vk0wemUrOGthQ0ZlU3NVSlo5eWZBRFUxTzFhZnpFVUI5aXIr?=
 =?iso-2022-jp?B?WFdyZXRndnRobGJPZldDMGlXeWF6d3pLNFliVitBT1RyNVByMGtvV1FI?=
 =?iso-2022-jp?B?ZEZ1c3F4ZUZXMklkRFk0eTFjQWJpcTAwRXZTeG9DOXQ0dnFlN28rd0do?=
 =?iso-2022-jp?B?L2J2RkErQk4rNkRQeE8xb3VaTXVsQXFGSHdNbFNYa2dxcE96Qmdick52?=
 =?iso-2022-jp?B?ci9FbXMrRi9LeWg3WkdVWHZVUVp5QXZneEJRU2Y1d3pDTjRBVm1wWXIv?=
 =?iso-2022-jp?B?d3pRR1JiZ2plOXZtdFBHaCtobkVwSklOeVNnT2xZdmc0RkF0UHZxNkNs?=
 =?iso-2022-jp?B?RHRlbUVRQUZTRGlyaW9LNmFKa3pXT3BobDMyb2hTemJUdTBvUDNtejBO?=
 =?iso-2022-jp?B?WE5IbGZWS2MyL1ZIQjJNWWl6blBJZ3ZOczNMdTRRbUdYcjhkc1MxOTIz?=
 =?iso-2022-jp?B?c2Vkcm12aEJWa0dzeEl2OTV4QW1pZ0swa3VNYXlYTGJ6VFROVTJORXIr?=
 =?iso-2022-jp?B?VUhveHl0WFBid0lSNXpyVnVlZ2VtM3g5TVdXTWxzbkh5Y3RyNlliNmRG?=
 =?iso-2022-jp?B?ZlFrNEw1ZE9Uci8xSXFWSERqekM2bUdwMTMvYlZkeEZySVcycXhHNnln?=
 =?iso-2022-jp?B?SUxpOGNnTEw2bkJjNnlGendFY3R6WTFXV3J3dTJoazNNM3hXNHRNQmUy?=
 =?iso-2022-jp?B?K0JiZEUvQ1pqWWZPS2RYNndBckE0cENPNDFZWklBbkEwZ2Z6Zlg1YWt5?=
 =?iso-2022-jp?B?a1QrdG9CTG5DTm96dXRKL0x4blpzVUk3RGx5QS9WTVI0NjhjdjdMUW9l?=
 =?iso-2022-jp?B?TlZaUzJVZkZxUlEzZXFYalRkN1k1QW1uZUxMT2lzVXp6aXpYeEFQU2xD?=
 =?iso-2022-jp?B?RTdJVmNlRTdobXloVUxuZzg2Y3dzZjNzRnlINFNWK0R5R3RPcm94c0k1?=
 =?iso-2022-jp?B?bUpNdUlqN0JIY1hzL0o4cURGQUpIZG4zOER1SWswOXlDU2IyZE8xMEt5?=
 =?iso-2022-jp?B?S1ppTXNMS0tncWVoWkJQMXJQSTladTBRNzVzVjEvQlJ6NnhpU1NEeURh?=
 =?iso-2022-jp?B?TkhzYlpWSTNQdUlWaEdNVkp4MGcrNUFnZWV0MGlyWFF6eDNBMmpKM0Ru?=
 =?iso-2022-jp?B?V2ZURTJ2bHo4UmhCaXN2UzRYSWJWQnJ2bytkL3BCOG45YSt3aWc2U3lZ?=
 =?iso-2022-jp?B?VDZkMm9aMFVrczYxQlg2RjFtNzJIZk1iUUtRdTg1dndlc2RyQWU1RHlp?=
 =?iso-2022-jp?B?L3V6amVrMGo4d1p3blI5aVJjcXJZa1d1QVdRK1RPaVk4dUxIYmJiQUdM?=
 =?iso-2022-jp?B?elBSQ2ErVVQ1VkVvTjdTYWVLTENEaDBhei9qUWpzYUtpdHRqdmRrMDBs?=
 =?iso-2022-jp?B?dmlkUE1OclRoWDFQaEJTMzhaSW9sUkExTTkwU3QvSjFHMDdtNEYrNjFp?=
 =?iso-2022-jp?B?ZDZnNjVFMDc3RFZJeUZJUlZ0dWVFTjFRcUp5alQ1T2JZeEhPQ0M4QTgx?=
 =?iso-2022-jp?B?cjNRNTVHaVV4dXVGYUhXOW1vMGhTNmlkK1ZqdVZqWHRoSFdMZ1d0b0pK?=
 =?iso-2022-jp?B?QmRPZkZFOXVzUVVGRGVyM3BIR29pNVFaK3NlbG83eVVKOTExSnhGT3Ux?=
 =?iso-2022-jp?B?U2VhMUJ5azNDVmVlQzN6dlhadzB0aE9DVTRWcjV5WkZrbHJkVEZBVElK?=
 =?iso-2022-jp?B?YjRMVUt1bGlDYUwzbDlBRzgyVDVqMENHVHZUNHFMWUFaSHlOdUVvRVdY?=
 =?iso-2022-jp?B?aTRvMmwyditUU2FGcDd2RTY4MDdKbk9BcEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a18d44d-b640-441f-9e32-08dd5b87803c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 01:46:08.6156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Op29s6zDJk5adFPrRqWftybdjquVNrEHZoWEn8QE5HYL6AVPbpM5o4IaxowKPq+icI4EOrHEw0cy83+qm7vYsyKSKKqJ2A8KQ+dG2wgNBPQg9hb1/2EBiBGewHEOrn3z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13498
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Mar 2025 01:46:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18025

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Tuesday, March 4, 2025 7:39 PM
> To: cip-dev@lists.cip-project.org
> Cc: Pavel Machek <pavel@denx.de>; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?=
.MN=1B(B =1B$B!{#D#I#T=1B(B
> =1B$B#C""#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/12] ravb backports: MTU fix, V=
LAN
> & IPv6 support
>=20
> Hi!
>=20
> > >>> Paul Barker (12):
> > >>>   net: ravb: Fix maximum TX frame size for GbEth devices
> > >>>   net: ravb: Fix R-Car RX frame size limit
> > >>>   net: ravb: Factor out checksum offload enable bits
> > >>>   net: ravb: Disable IP header RX checksum offloading
> > >>>   net: ravb: Drop IP protocol check from RX csum verification
> > >>>   net: ravb: Combine if conditions in RX csum validation
> > >>>   net: ravb: Simplify types in RX csum validation
> > >>>   net: ravb: Disable IP header TX checksum offloading
> > >>>   net: ravb: Simplify UDP TX checksum offload
> > >>>   net: ravb: Enable IPv6 RX checksum offloading for GbEth
> > >>>   net: ravb: Enable IPv6 TX checksum offload for GbEth
> > >>>   net: ravb: Add VLAN checksum support
>=20
> > >> Test:
> > >>
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/169648109=
2
> > >>
> > >> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/169
> > >> 6483186
> > >>
> > >> Reviewed-by: Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> > >
> > > I reviewed them, too, and code looks ok to me. I'm just wondering
> > > what the gain is here, AFAICT there are only very minor performance
> > > tweaks (is it even measurable?). What is the reason for having these?
> >
> > Performance gain from enabling checksum offload can be significant,
> > especially on the SoCs with a single CPU core such as RZ/G2UL and
> > RZ/Five. For example, we've seen up to 40% improvement in bandwidth in
> > TCP RX testing on RZ/G2UL.
>=20
> Ok, thanks for the info. I did not expect 40% improvement. Both 5.10 and =
6.1:
>=20
> Reviewed-by: Pavel Machek <pavel@denx.de>
>=20
> I expect that Nobuhiro Iwamatsu will apply the changes soon. I can also a=
pply
> them.
>=20

I pushed both version with Pavel's Reviewed-by.

Best regards,
  Nobuhiro


