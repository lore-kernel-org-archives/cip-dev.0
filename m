Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE482CF855C
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 06:19:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.5311.1727936331576270928
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 23:18:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=GDar5j1D;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1727936323;x=1729145923;bh=A2RWaOsNvvBf36ouVPy1QeBm3vpbZVBA+uV80JV
	srFg=;b=GDar5j1DdUsRJH+ZdlRYpQ7fI6gtHVFwbW/rc+E7kDZfQo4jyhQ5jSLEjErwlCSvTDYEe
	f7qQGqACxU0xoFppOKDMsZvCF67znaUAQWu2Mo7+/KyPZ0LZIgGvdC9guyg4/XcEyMu3vHcrFEbb3
	ELocBpshvw9fMwoZJbWqck7QQZ8X5jAJn+M6oHSKaRqL5NbgB3zjiKfU9xT21j04Zomsn/E19YQal
	MhMZcTVwTsu7GnKlWwrSFRbDarb24CIJRH3rsKgN5Av1reRVvEhlWJhzlVA+8KQeA55ZtSK+ZW3kY
	A/GU9dch/7XpQR9vv18Ax5bJvVlAjQQgecP6ftabXA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 4936Igl21224371; Thu, 3 Oct 2024 15:18:42 +0900
X-Iguazu-Qid: 2yAaKAjYsUm3kLpucz
X-Iguazu-QSIG: v=2; s=0; t=1727936322; q=2yAaKAjYsUm3kLpucz; m=Dn399fDcwapdT0+kpSCWxE88H5CutgxOeBcqMzqLzM0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 4936IdWF3593699
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 3 Oct 2024 15:18:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCrvULTJ2esy7uOwuY+fIBzwQpBKPXyL2VAMci8t2p7M7LD6W3NMrMfLEYK6EDPmai3FLyS3DcXiclGaKEFjbAMzKCuxhXT4kg8dWrTu7l7XPDJ3xp90sogdPbs54cx+R0kO90YwNTOxT6UI9SAIxGTtLnb6a0yFC2uuke5EOUkSgmC09nR9Eym/rcz+Zv8CYlhv1LKrk5mOe/s0vvZjkP6N8z3E0Q8ox5M42/sZITFq/XXuRQITm8AqpFCfe+Vc7bGTFt6yU+v9NDtwCB9REUJ/kKTXxpnB6+9a9X06DU8fbYUvR3gGtV1JW7UdpZjbZVIXWt+5+dPot3qG2X4F6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4wQooPq1kFYnIX6jCmt/X9A7OEIcYca8NHh9u+jEbI=;
 b=uWDfjgJTqt1r0+xDbUpeYLrpd1G3oC+3iPQq6ZgWPEHNbfAKdmJPAJRp3QgR+kDmHbD7cMGePOLDsGcqLOXwnUr/WXipoWbysxLsRFvPMMzyqhTKeX+YKHe6d6J6ZF5/8Nb/5xcGgPFnPuJRpQSBjqLubfkYb0yLzrwcjUoB2nmfwMxo21EY6C60KkIBmdv7aKkFUkjbmLa2Yo+6HfPPMbS/H0CMFfmEpZfyY2SlcYCNtPx8GlmGa9eGbkoBbm9TjTVEfAxlSiPxu1rqbCdflqZTkEuMqfjRepuyuMV7MNOQN2uTuEPu2PQP/Q3ThKU2yjiwTy00W9FbTPJC9IZiGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 03/15] ASoC: sh: rz-ssi: Add full duplex
 support
Thread-Topic: [PATCH 5.10.y-cip 03/15] ASoC: sh: rz-ssi: Add full duplex
 support
Thread-Index: AQHbFO2Zo5RDsBGV90qClx8ximlPu7J0jF4w
Date: Thu, 3 Oct 2024 06:18:37 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388556A5A29232D4FB90B7292712@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
 <20241002170712.655449-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20241002170712.655449-4-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSZPR01MB8138:EE_
x-ms-office365-filtering-correlation-id: b0b76fd2-8b03-4119-b27b-08dce37337d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?cEN4c3FzOFdDeWdQR1c5Z2ptcVQrUXJucDU0bkp5MDVlVTVubTcrTENi?=
 =?iso-2022-jp?B?byt5aUdxRjNXQVpNeGllcGdETHNMSC9sN3ZvVDhVVzJkUlpmekNWNmE3?=
 =?iso-2022-jp?B?WWh2ZjBuQzRTL2psK1dtWmU2Q3ZJMTAzczNkekR3MEJLTlJibGhvamdU?=
 =?iso-2022-jp?B?K3RyMDRHMVc2R0NKNU1ONVJESlhDRFBmQzJlOEVYNmE5Vk9XNENiYlk3?=
 =?iso-2022-jp?B?WW9vRGJpaERRaUtacVh6ZFFsd3YvMkFYRmM1K1Y4Q0pPNGU5Ym5PenNF?=
 =?iso-2022-jp?B?Ylg0K3doSXgzcDVFdWxLVWtlUDMxeHJNTFNDeUJTUDVaR2FLK1lVMW5n?=
 =?iso-2022-jp?B?eXlhVGZmUFYrTkVUNk95cXNkOVZHQlZwV1ZiOEJEcXkwQVhoMXRHTTlv?=
 =?iso-2022-jp?B?YnN0djNrWlZMSWIzMmFHRWI3OWl2TlYvTmQrbVVxRWJCSURpbzBpVG8v?=
 =?iso-2022-jp?B?OUtwenRMQy8zc3R0ejlQOWUwbGpoYUo1Mm5wUkV1WjliUHpsVUtsKzZZ?=
 =?iso-2022-jp?B?QWp4U0xOUlhPMFJmeitaWTltcld6eEV6MnN2YXo1YXRSLzE3cVloaUY5?=
 =?iso-2022-jp?B?OUt6UTlzY1ZXNVdvZjRNL3ZjdHprMFlFYSs0QTZhZXYyQitqQnNoRU5p?=
 =?iso-2022-jp?B?emFOSHpFUWtXZjUxQ0pGNFZHNDdNdnE5clJ1U3pCa2I5WnV6TDg1emlV?=
 =?iso-2022-jp?B?T2J0UnlWQlpYSE9GT1lzQWNkS1VuWjZ4MCtjQ1pyWWFsUjBJTUpDTXJB?=
 =?iso-2022-jp?B?SkhqRDNsN0FRNEdCcTNsSHlvWGhDd0xLU2JLWHJvekpqaE9qRG1UaHZZ?=
 =?iso-2022-jp?B?aTZKa3NJSnNVUTAwM2M2VkhFc0VpVUhIdktVdlZKa25BUHBIRWhoTGJa?=
 =?iso-2022-jp?B?R0xtVDMxd2JNdDU3NndRTDRWYjl4bVlQN0IxNG45NGU4elFMQmdvSzla?=
 =?iso-2022-jp?B?YXJyQkp5ckVIeUxDeUJDNno1TDhCeEpVUERWYmtZR1NWeUN1SHpIdWxk?=
 =?iso-2022-jp?B?dE82aGhuRERLUktCUjQ0V0tEbDJZd2RvVllOMUR2Q010UjUrU3ZsQ0du?=
 =?iso-2022-jp?B?bkI1V2RoZmZLc21PUlQ4S1h4eUVkQ2p0a0dvY0tqWUl4VUVwbUJCMkhm?=
 =?iso-2022-jp?B?VzRUM2lTbTdrYjhPdlFkMWQrUHlib0FBSklLZjRETnZHMDhTbXlkSVZ4?=
 =?iso-2022-jp?B?clhvek13dXJ4OEE4WmoveklkNjIwbE9DTEhzTFNxYUdZL3hCV2JpNVpT?=
 =?iso-2022-jp?B?RUM0ZTVuTi9nKzJpSEZ2UWQ4YXA2RU1HcGpHZ2wvZzdEQnFsc2VyQ3F0?=
 =?iso-2022-jp?B?YkJRNmlCZ1dhR2J4QXo1d2Fka29vQlM4d21tQVlYUVdITkEvYlF5TEdh?=
 =?iso-2022-jp?B?NGUzdzZtVjNnb1FCNmJteFh0UlRreG5ObytuOEp3NGg4NDBnM2YvaXVK?=
 =?iso-2022-jp?B?NFRST1hoa0doK20xdDlhalN5WTMvVDEyQXVYaVo4Y1pHSW1pSk53RDZN?=
 =?iso-2022-jp?B?MnRvdG5RNkdQR3MySWJLV1RQdUp2dlFDWklUbEh1eUFBNlVHVlY4Q2VK?=
 =?iso-2022-jp?B?Unl2RVU3UEFKSkJvZzBFUGJuaHg0YkV3ajFhWHFieUFMdjFGczNIRFFC?=
 =?iso-2022-jp?B?Mk00U0RneDViZVRrSHJuVFd1VzB1dCtkZ3puOVBNbFlJL1BYK2NzeXRu?=
 =?iso-2022-jp?B?T0NGSUFwYlY1OVJlV2dsNjlxNklJTVpuM0grcWRSOGN2RjlNUmY0cEhO?=
 =?iso-2022-jp?B?Q0tnbG1PZGhPRTF0WkY5UmkrcGN0QzlKdWdJbnY4VzFSdWFFM2xWSHFk?=
 =?iso-2022-jp?B?VmpIdzFibUF3WTI4akhQdEJ5a1hmYWFnZVpzMGxMK1Myay82Zk9FQUlI?=
 =?iso-2022-jp?B?dVRNd25YL3dPQzN5NFZKNHg3cGNLb3hrV1NFaDBacGx4WmVRZE9laFgr?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?b2RNRFBMb3ZsbnVuWFRMUW8yaWU2K0R3eURrMCt2TzkyWnFaazZoUzB6?=
 =?iso-2022-jp?B?eHgrVUZxclBVMHd1azBOUzMrSmZIdDBUdG9HY0w4RGNBSnVmdGRHY2hU?=
 =?iso-2022-jp?B?RzV1ejdkd2d4R0JBT250R05ZNk45TVNVUXdpbE5RSzdmSWcyblExWnF0?=
 =?iso-2022-jp?B?L0RVdzh3TFBFK3lYaVp6YTYrT1o0UXg4QVdkTjlxeEVJR1pqWTZLUERB?=
 =?iso-2022-jp?B?RGdoYU1YMlZmbDdBZVMvTkZzbXQwQTUvNmtzTlZtTk5aa2Z3VlZUUk9m?=
 =?iso-2022-jp?B?ajQ5OXRMa3ZsK1RqYUZBLzZVcWhEZlN6M3o3M1U1RDhYV3c4M0IxRXJj?=
 =?iso-2022-jp?B?eGcrWTJkWlFOaXo3bVhtYm9aMTZBcHJZamR0UGN5NG96TFo3WUZabnFs?=
 =?iso-2022-jp?B?cXVSYVI1SXNWYUpxRWV3ZDBXWGZmeGFHQ3BPNlpSV1FkSDRGRXRXTHJl?=
 =?iso-2022-jp?B?ald1V0IvS3h3eWRjeEVoTlc1Q25oYkxpVTRVT3Y1b3hlSzU3UWxMRHhW?=
 =?iso-2022-jp?B?a0hYMzRUSWY5ekJMVmJ3eGw4aURkRURvci8rcHdoenNoaEdnYVVpbEFX?=
 =?iso-2022-jp?B?RmViZ0E1WmEzM053WmxaYms5ZjRIek5hd2lJODl6aDVadXNMbHRTaTJH?=
 =?iso-2022-jp?B?Rzc0RzNCdkVwbUMvbm43NzJ1U0dnQTZ4NnZpWGFqT3ZlZnNocEdzN2tE?=
 =?iso-2022-jp?B?K0dxSXltSFhiTzdMRGVVWSthYWVUcktRREJTTnpzRmFBbTZHMUZtR040?=
 =?iso-2022-jp?B?Y2dqbmliT2wzUUU4cEhEN0FvRVJLYUNmQnl5Z094YlhTcHVkM3VITEdj?=
 =?iso-2022-jp?B?SkhsMk94OVptekZPWVdIUjRBNGVsTmNlUlJJUkU1SU1wS2pncnhEam9p?=
 =?iso-2022-jp?B?NWk2VmNNUkt4T3VyWUZ2V3gwb2tGUXFEekFJTjdZWHJwMzdYQmVxWlpX?=
 =?iso-2022-jp?B?dmRkR08wdnMvTkFtdTR2K3doK1oweThCY3BLNW9NeW1reERNOVZkc0Fs?=
 =?iso-2022-jp?B?Z2VaOFFWL3ppSExzOHQ3bUJIMjJDd29GSktkRXVycUppSkl1dld4d0pP?=
 =?iso-2022-jp?B?eENtTUpLc2hDUXlBMmRqNnBSYXhGSXhaNk9kQjhPdkkvNTN0K1AzT0tO?=
 =?iso-2022-jp?B?c2ZIM2lGTGtuK01MMGp6UWFTQjVoZHlGRlVPK3RSWVIrMXhyZDJOb2d2?=
 =?iso-2022-jp?B?Y2duM3NyYisyYWxqak0vaEdsMGJQS2N2NTAwWmY1RFBqMkJ2dE9jQXo5?=
 =?iso-2022-jp?B?V1lkN0hBL1NXL2tvdFZZdzJrWDU5Y280QzRuQjVJakE5elhnTzR2UWhv?=
 =?iso-2022-jp?B?ZjY1Q2kreTZjdkJqTDRORkFTcHVHZys5UTMyZmFUQlFSTkRTU0diN2xS?=
 =?iso-2022-jp?B?dHZjU25EL1VxQmdHaUR0MVhFVDBBVk1LMWYzcnVQU0tydVhITWFxeG5U?=
 =?iso-2022-jp?B?YVgvdlU2QU8zdzJMa1dGY0hscHZ2LzVWZ3k3cGtXUkNMeCtMb1JGRHhm?=
 =?iso-2022-jp?B?N3dpY0hNN0xpeHBYa0VIU2F5QkRUV2FLSWU1bU9SQThLVVIxV3VyWGMz?=
 =?iso-2022-jp?B?bi8zcFgvREt0S2ZvZGF6T2NKTjcrenNjc3NmUjJWdmJRa2UwVWpST2E0?=
 =?iso-2022-jp?B?bExkdGR0TGZJd2IvMGNBVC9aWHVoVmNKOGhkZGo2dzNaUFFJaUVkWjVr?=
 =?iso-2022-jp?B?WDRMd0FPQ1lvSVBHSkpsdWJscGFEU1JWeDBrbTZtZHVRSEgraWxVd1dj?=
 =?iso-2022-jp?B?V1d4eWo5NjYzMGhQRUtUemVXbzhDQ2FGVVgxU1BleDFxL0FmQXpoWDBQ?=
 =?iso-2022-jp?B?NHQ3c3BpNC9JRk8veE5zK3E3L0sxTG9vTWdpbXp1UXA3eWd3cW02NHQ2?=
 =?iso-2022-jp?B?S0N1bE1xMkZRNmg5MkZpbmRIcnVVUW84MVBZcjFVZXk5YVRtTm5NVDJ4?=
 =?iso-2022-jp?B?RklTY015VkVJT1ZvNlFVbUkrbVd6cGlLKzVNRnkrY3FYK3FJRncwTXZy?=
 =?iso-2022-jp?B?ZUdZZjdkWklGaUs0YURXYXJ0TVNaYnFBLzExN3dBTEFZYlA3WnNKamYv?=
 =?iso-2022-jp?B?N2dOUzJiY0trL0Z3UFNjdmRTQndHa0tkM0wxZzNrRGxMWDZ4U0pTK0p6?=
 =?iso-2022-jp?B?eUVFVVB2K2dCYVRHN0ovRjg0ZXY4akI0d2lKMDJpSGxHTGZ2SGcwR2l0?=
 =?iso-2022-jp?B?Nll6UE9vQUo5czNMa0lIMmJ6MUFBTzNabHIwUXRNaGNqUWVadkFYWllL?=
 =?iso-2022-jp?B?S043VEF5akpPdXV1REhRUFpFa2RIYUVsOGtURUpVa2kwRllvTTNWZFh5?=
 =?iso-2022-jp?B?bzEwaldRSEtiaE5QbjQrbG1OYWhLZE4za0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b76fd2-8b03-4119-b27b-08dce37337d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 06:18:37.6929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +AFALUJdq6y/50V7tSKDx6uvRv5QiFvexmZ88pxnEuIVXPmVMTTlXqxdmG8orDBNWPNUy2QclqGibnW7Nngbs0JTXBOo9lVlMMzjTmR+0zNcA/m+JrYYn1E8/WsAHFlz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8138
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Oct 2024 06:19:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16987

Hi,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Thursday, October 3, 2024 2:07 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 03/15] ASoC: sh: rz-ssi: Add full duplex suppo=
rt
>=20
> commit 4f8cd05a43058b165b83f12f656e60415d2ff5be upstream.
>=20
> Add full duplex support, to support simultaneous playback/record on the s=
ame
> ssi channel.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Link:
> https://patch.msgid.link/20240715092322.119879-1-biju.das.jz@bp.renesas.
> com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  sound/soc/sh/rz-ssi.c | 257
> ++++++++++++++++++++++++++++++------------
>  1 file changed, 182 insertions(+), 75 deletions(-)
>=20
> diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c index
> ff5a650ac2b1..ce0233e8879d 100644
> --- a/sound/soc/sh/rz-ssi.c
> +++ b/sound/soc/sh/rz-ssi.c
> @@ -53,6 +53,7 @@
>  #define SSIFCR_RIE		BIT(2)
>  #define SSIFCR_TFRST		BIT(1)
>  #define SSIFCR_RFRST		BIT(0)
> +#define SSIFCR_FIFO_RST		(SSIFCR_TFRST | SSIFCR_RFRST)
>=20
>  #define SSIFSR_TDC_MASK		0x3f
>  #define SSIFSR_TDC_SHIFT	24
> @@ -131,6 +132,14 @@ struct rz_ssi_priv {
>  	bool lrckp_fsync_fall;	/* LR clock polarity (SSICR.LRCKP) */
>  	bool bckp_rise;	/* Bit clock polarity (SSICR.BCKP) */
>  	bool dma_rt;
> +
> +	/* Full duplex communication support */
> +	struct {
> +		unsigned int rate;
> +		unsigned int channels;
> +		unsigned int sample_width;
> +		unsigned int sample_bits;
> +	} hw_params_cache;
>  };
>=20
>  static void rz_ssi_dma_complete(void *data); @@ -209,6 +218,11 @@ static
> bool rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
>  	return ret;
>  }
>=20
> +static inline bool rz_ssi_is_stream_running(struct rz_ssi_stream *strm)
> +{
> +	return strm->substream && strm->running; }
> +
>  static void rz_ssi_stream_init(struct rz_ssi_stream *strm,
>  			       struct snd_pcm_substream *substream)
> { @@ -304,13 +318,53 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *s=
si,
> unsigned int rate,
>  	return 0;
>  }
>=20
> +static void rz_ssi_set_idle(struct rz_ssi_priv *ssi) {
> +	int timeout;
> +
> +	/* Disable irqs */
> +	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TUIEN | SSICR_TOIEN |
> +			     SSICR_RUIEN | SSICR_ROIEN, 0);
> +	rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_TIE | SSIFCR_RIE, 0);
> +
> +	/* Clear all error flags */
> +	rz_ssi_reg_mask_setl(ssi, SSISR,
> +			     (SSISR_TOIRQ | SSISR_TUIRQ | SSISR_ROIRQ |
> +			      SSISR_RUIRQ), 0);
> +
> +	/* Wait for idle */
> +	timeout =3D 100;
> +	while (--timeout) {
> +		if (rz_ssi_reg_readl(ssi, SSISR) & SSISR_IIRQ)
> +			break;
> +		udelay(1);
> +	}
> +
> +	if (!timeout)
> +		dev_info(ssi->dev, "timeout waiting for SSI idle\n");
> +

We do not need to process to timeout?

> +	/* Hold FIFOs in reset */
> +	rz_ssi_reg_mask_setl(ssi, SSIFCR, 0,
> +			     SSIFCR_TFRST | SSIFCR_RFRST);

We can use SSIFCR_FIFO_RST instead of SSIFCR_TFRST | SSIFCR_RFRST.

> +}
> +


Best regards,
  Nobuhiro


