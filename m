Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F83CA5FD4
	for <webhook@archiver.kernel.org>; Thu,  1 Oct 2026 23:52:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.803.1790898742173188501
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Oct 2026 16:52:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=ca6+RyU+;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1790898740;x=1792108340;bh=bo7I2xJ402HLeoVNnacZLjhPiJOD0z1s7dpjx
	WgfP+Y=;b=ca6+RyU+Srh3jnbNP0dgRJzgnyd4aX8QCQkBC4rNPfZK/6f/kcWJgqY8NKnGVXbUWL1
	y7qEinYal5Yni60ZYYTMdopFMnuAixSwMAEzKIQGeQvP7v4Y1GJkBj3/z0NIMI5oSOyFsfxaVqgGe
	zAfoyP/batvsVBIZ0i9HF94+j3eJE+s2RfSzUvFYINL+j4tPljbaePjXRVG3dh5sD0HSqlwydIrJD
	v6FTEQpgux09h++lFkYBi0m1WaVaZAZ3OA/zCEBFkdzOKv8/14xjBwC0B/TnhKk1zCzwzydxiL6Vc
	TuJ3hGvbswUVDW6yoF/jPJhpfrYYQvFdxswHwgder5og==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 691NqJDw1743084; Fri, 2 Oct 2026 08:52:20 +0900
X-Iguazu-Qid: 2yAa5wMLqafVeRVHqp
X-Iguazu-QSIG: v=2; s=1; t=1790898739; q=2yAa5wMLqafVeRVHqp; m=A0AhfjSiB5vLedA2VIj8CIlhRlq8JfF33M15UPiFKho=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hwpcM350ZzyPg; Fri,  2 Oct 2026 08:52:19 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfQjmi4Cl/cl/oWyP1PSzVaF/rBSu13jw0P4WR2QLaRuZV6ejXsCpwdrsd/MNKyZ6Ih0CQ859g94OGgmA1yavb6VF0A4q5+eZCU8KwgLfz0RIGnMlnz/SvyRV/hhVF0Z6SYrzOu/uQE0Hwbqsy3Sx2na/ZpXrxvY4HaoG/SKpjIIHhcYmBzZ22ESCHWdRkJh666qkxqaD/yBGHTWE9aooR9cEwoYZ8yEDwEMu2+JrI3wluJPvHWiMwb+dOCfITKDgFUdyXBEcdlgpRCsA4QqFBpi2zZ9628wV1JyzAbuv3boCAPw21zaSnDYHdZjqDMPfmJa4TnR6Pr+KKsg2xMcMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdYl3R6nnlS/9+kG+WVdMvzRXwMeSfILGHoutTFI1VE=;
 b=gh3lwBKlbDpwnGD/GT2MF6MHvftnHbCcDS1fHgRI7vbz6uyMcNEkvIiMJW8wPe7VsSJG+FQOhxbJKp29U+uhbIhxq7wLvBU8jno4WxGA5cYupf1cj7xRGbQU4Yk5xrkxiYeJ7rcOPSH450HvdGWnT6wZdCBD3wQ9kMNuhS/VZ5kBtIfZU6B12M627o/Bc0xje1pE0ojRi4K1NvkPAb+AK/lQgcgSpPJF+x7S52pifltnIhHxDRU7Kv4yWiAaQQmO4yjwUOz4o39R+CXV2jJJtmTscceQxYVPm5H6cXX2EpEOKxnBJe5DiA+HXcOrm8/mc6AQLfTKZlKpvs42p36EgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <claudiu.beznea@tuxon.dev>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/4] Backport RZ/G2{E,H,N,M} iommu
 properties
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/4] Backport RZ/G2{E,H,N,M} iommu
 properties
Thread-Index: AQHdUO3CUVgTGKivW0SnllkM4nrM0LboeiQAgADjq/A=
Date: Thu, 1 Oct 2026 23:52:17 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481878A487DAE1C80A446825CD8A2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260930150941.597025-1-claudiu.beznea@tuxon.dev>
 <ar4zHjT3PnfpYR62@duo.ucw.cz>
In-Reply-To: <ar4zHjT3PnfpYR62@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY1PR01MB10704:EE_
x-ms-office365-filtering-correlation-id: 44c30158-aac1-4631-a684-08df2017064d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 Km29EWTDFFJ8OibhoZAwogrpAJZvofvhqmSbUWFbADP4LYNfpqdf2rHZUMS3CWFodhmna0FDKRD6s8ekyrQeo9vA9broKSbfL/ts8GjAJFiHTEcs8gwQk4jXsWozdFMojokLJ2Rl+UkC/ZMdFlzfpJBkcKQqvZY6cGFUqkn+P0dpvCnybo1tNLVMPUxL7mvnWhYREDmpN0nfOyojtpqKhEiiar3luWOAAl1lnDd77rpPhdAN+8g9C24Xmyfg1rKE5bqWJYm4TtUe7usdULaJZ/eDBYPQDG+XpkSRBe9KaD8UCSaAs/C3rB1B6TfCCMLUlgaLdx9WEFkjNXIH0z/5kUUhS8p7oYWRpan8czQTdVK1Qz8BnRUOMYm1gs61UHPpc6BE1FYCyMLvRl2dUjLfrJhp6hjK7Xzc9f2DI/y05sqCsUNsWYO7tIROEcroH5SJOfmLV+DLdDQs1LIvoy466eEw4UBWpasXmc2pE//BCuq5teqC5El8GMOmRC4AkOMKkRXsg7qikCHOcD4EsO8p25Qhrgr2BcYdpNKVJE4lfBdgzs9z4QSnMUjL1S9t4RgqE3W/iPNpPV788VQQCxCe4HSLgBd6Xmp11splro+N8vr3yVYb4Hd4k5CLRjFWkJnkBhMVTWBLXcddm/tUWgyCX3woLi/tqyzrtGP2xnlJz6iyjn6TorNJnXc6vBTMtxS8nKWItWfIRwMkn2louXXIbQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dndIRTluM3A1TXVpRUtjNS9ML241enJnVHVVNVdKZEtLczQwUmZHRktP?=
 =?iso-2022-jp?B?OWlva254NlNTN1hUcnlpTENtOG1oWWcrQXl1OWVGZGZoNmgwWE5MNjRR?=
 =?iso-2022-jp?B?ZTBkMUpkTi9ZNzZxZVFuVnlxLzhJQXBTMXhHM3VlN1BZNSs1UStFRFE2?=
 =?iso-2022-jp?B?VkUybXBES1F0Q2ZWd0xvc1dsYWNveG1BNU5vMzEzek1HalJYM2xuNTlF?=
 =?iso-2022-jp?B?QlZPcHVyY2Z2T0M0eWU2VE9XQkYrSmhLN25YRi9JaUdnWUNKeHZZUkdH?=
 =?iso-2022-jp?B?aHM4L3pQeEhkeTZCRUo3bTBySE9nT3JBK0lJK29Oc2dPRDdhZU84eEp5?=
 =?iso-2022-jp?B?Y3FvWUx4cW0xdGJGcXp4cjdnZ0RxS1FjZ3U0aGxDVy8wMHdpZ01tcXkz?=
 =?iso-2022-jp?B?ajhYeC9YZUVqci8rK3lhWTJhdWU5aUxYZ015YWFIbGRMWklic0txQTFm?=
 =?iso-2022-jp?B?V2ZrREZLMTRGczloUnhucmczM2lrWDFhcmhQMlIyUkJENkVtdjFLYlNO?=
 =?iso-2022-jp?B?VTF2d1c3YWIrODhReU1lQmRJbTRKc1ByWXJCZno2Z3ZKRWl4dHlyZE5O?=
 =?iso-2022-jp?B?NWUzTkF6SHE0K2xkMUFScEw1NktYeTJFK3FNLzE1bTh4cDA0MkxQcGFz?=
 =?iso-2022-jp?B?dVgzWVQ1SnovZmMyWTJqM2hpUldWOU40YzZhQ2Q0R2paNTZSMVJyakQ3?=
 =?iso-2022-jp?B?L0RMSFEwcTMvN21aZzBEZ3k2R2h0NWxRdHlMQjlpZDFwcndKN1FIeE1P?=
 =?iso-2022-jp?B?SFZKbjhKdDhzTWt0TExxU0RtUkZPTnBXNkMwSkVJV0JvS08wQjFuZ2VE?=
 =?iso-2022-jp?B?dXhoVVA5NTdFcDRVaXpJd2VRV0VybFZBK2EvbjN1NEp3M1pDVWdEWnFW?=
 =?iso-2022-jp?B?aWpRSnVFbUpYeGpETWxndVFHeWNJS3lldkVROGs0bGZQdEZMZDNrdmsx?=
 =?iso-2022-jp?B?YmhyRXlLUWhhNTRCWk9wUXpncGFpdWRYamVXS1RPZDRhalNIM3ZacHly?=
 =?iso-2022-jp?B?NldBaDA1T2MrdmttZjN6dldQTlZ1YTlydmIvL2ZUK2NWem9YMlFIMVVR?=
 =?iso-2022-jp?B?UjhLS0ltbVpGYm4wZmxzRGNUcElta25tZEgvV0trOXRHTHh3Q2gxc2VS?=
 =?iso-2022-jp?B?ZDF2L2p4U0pDZ3RlYXJUNkNDbGh3WDh2NkFtV1NLY09pU29hNk9XelBJ?=
 =?iso-2022-jp?B?K3FrclVQOHdsYU5kOFhlZGVtUktOeDZaZCsvSllZMjBJYnpuZWFBYlJY?=
 =?iso-2022-jp?B?Z2ZuMWZCUjlDZzd3T0hZVkovckIwLzlxajk0Zk5kZUJHbHZ5MCtSVW9i?=
 =?iso-2022-jp?B?N0Jyamd6dVhMV0lTbmpHN2pZcldNL3RxdngzMExFdEtlTjJDV3JIK1Uy?=
 =?iso-2022-jp?B?a1VSWXBUNTluTkkxRkRwRXlDYmgvM2FPcURCVnBra3FJSHJsanFMQVNE?=
 =?iso-2022-jp?B?RGhoYW1qN1RtQXVCN0RBQy9xYm1OV0V5R1hFYXh2ZnZ3SWcrOGw2Mkdv?=
 =?iso-2022-jp?B?OTR6bVROd21XNWpVZE9ydldRVVRwWlpybzcxd21MOTZudDkzQS8xSnBv?=
 =?iso-2022-jp?B?WEJPa3p3QkltWk5kaGFEeXRFdUpkTS9oTkxHVkhRUTdtVDh6OWtZN2dF?=
 =?iso-2022-jp?B?dDhMU3NhZmc2S1FWMWxxTEU3U0t4T0QyOXptYi9SQTNFaTFOVFYrZ1VQ?=
 =?iso-2022-jp?B?aGUxV2xxeVA3WlhKaHFrNHJYMkpQOTRncGRUTzN6UFlQSFphUjVDejg5?=
 =?iso-2022-jp?B?YVZFMWcyc2VBc1B6dHBCZnp5eWlnV3JhQ1hVUzF3dktob3JWeWhLSjh3?=
 =?iso-2022-jp?B?U1N3K0dDZjFXYkdxN1R5d21Vbk11bzdib0RqSStWM3ZVQkpidHgyN01S?=
 =?iso-2022-jp?B?Z29WNWZNSk04VFFjdzhTZkt6MUwzankvSmVxaHErUi9zSnUvbzhIblN5?=
 =?iso-2022-jp?B?TktyczFQdG9XMkpoU0IwbkNUNHJZZlhOVDhyOGsyd1RyWjRzbzh6b1pE?=
 =?iso-2022-jp?B?WUtLbmJMczgxb01IRGxETGJsWitYL2p6THQ1b241ZHdncHptN1BiTmFF?=
 =?iso-2022-jp?B?WUZkNmhxMHJPaVdGN3pJczAzUnQzVExNbVZMcy9CVTJISHBzYlZzSjZy?=
 =?iso-2022-jp?B?NUxjZmJGU0NLZi9VUnppbUZ1aEZlNVljYmJPSW1XM2JKT1ZlQnUyTzNk?=
 =?iso-2022-jp?B?UVhoeERFYktWQnFpdWJHQ3Y5dXIrSzlpanBDVStjYWdqdXpscnBqbWlv?=
 =?iso-2022-jp?B?WDZYNVdjSVZDc2JOMmxTV2xnOHVUVzBFQ1NwZkpNL0N3Q2kwT0xqVW1Z?=
 =?iso-2022-jp?B?RHdiTUdCQUFxSXNabkZRUlp1QWFDbU9YRzNRdk9tVlQzT3VQaEQxTlBo?=
 =?iso-2022-jp?B?RElUeElqUVZxTDFuU2FRM0RJRUIwbUJ2Zk5uclZDYzNOU1NpMGF4K1ll?=
 =?iso-2022-jp?B?UmJTdjdIQ3ZoTytuakRWb3JSQjk2Q0lYbkZwUUFPWWl0RDJkVG9sdzJw?=
 =?iso-2022-jp?B?TXdXV3dIQnV5cDYzc1RLVmgzRFdaanhWd1hYZE40Q2NmVGNBRFNLclU5?=
 =?iso-2022-jp?B?Zkxza3ZiVT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	a8M4BQ/hFMrU3ct/1f6HNfauQ+cMHdl+frq9tN87KC3cTd8txb/RIwBZIu6ZVCZzAlHtQlIStthCcMmwEqgsQRHUa8gzt+f4pd2O1yunlc7ejSO9xol6yciC3GahWDRsK+q8rB1GNmEN6k2YrErdQDqemgls7j2sMYjB9sTSpvbuvKZ4t3+7ytXewe3nZgwT8AZnoGoFVjVVZeUZJfAhLUq8yw1C0Vxe4S8YCDDt4SNwyr3e1pgrcasTsa8D52FKlMikQjN9dHH4fkBr5kbBL+VBwknbrInBvxhf59u9EzJTY+ljKUKXSdrXZWPsNsx+tiS5sIGr8HRk6TijUMukxw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c30158-aac1-4631-a684-08df2017064d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 23:52:17.1952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vd01vS0ZkoKxFNxTfzzdNawjyzrZInqyloj0c6f6ctU4XLBGZDSxHHr4nzGWwWXbMwGTjr3ODXohzamdNinyZQscErq+rFmOhD+11Fs7roHYJEBNoQCpPSKmYHgrGu2t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10704
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Oct 2026 23:52:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24401

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Thursday, October 1, 2026 7:17 PM
> To: claudiu beznea <claudiu.beznea@tuxon.dev>
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@nabladev.com;
> cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/4] Backport RZ/G2{E,H,N,M} iomm=
u
> properties
>=20
> Hi!
>=20
> > Series backports the missing IOMMU properties for RZ/G2{E,H,N,M} SoCs.
> > Without these, some boards fail to boot when CONFIG_MODULES=3Dy and no
> > other modules are enabled.
>=20
> > Patches are present in v6.12 CIP.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I also reviewed this series. Looks good to me too.
I applied with Pavel's Reviewed-by tag.

Best regards,
  Nobuhiro


