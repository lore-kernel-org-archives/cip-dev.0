Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA12CA0EE9
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 05:02:51 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb.securemx.jp [210.130.202.129])
 by mx.groups.io with SMTP id smtpd.web11.1584.1755560454982128481
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Aug 2025 16:40:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=UAD+BlVt;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.129, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1121) id 57IMSNh7143536; Tue, 19 Aug 2025 07:28:24 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1755556074;x=1756765674;bh=
	o+gZx/4Ifx2CiHRdpeqQlT6bAXeAf4UMbEP0X5mj388=;b=UAD+BlVtuqcBz+scZXtScp6lsVd/79
	0sIbsc8s5kqrknI3KeWNmuH/BOyFp/EKG7JaymdVfaNKzXNCMMD7f2VYWF3d0g01A+2oQ3g9oZEa7
	iLQV+dAM1fl6fedu5iz3Walc00UySk2uqk1+nH+mzsQXz5E/woisF3KGVx95JQoxVhDZlzgOF4P3R
	3wvvgF7JudrK8pFgfzHXDER/hv1w0uA9yvZnSkSEUCe4tFP80sCLfS07EAO58sS7DE6cmLxCtwdkV
	v5V/nfA5MKNKjnwixKC/2GZojdFTg49xvzvDbzDBrQi6+fu3h7xOrAiBMfMtZMceUQsO6r/KpbAEE
	t9BA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 57IMRriu873045; Tue, 19 Aug 2025 07:27:53 +0900
X-Iguazu-Qid: 2rWhWAeBojNHTk5QeG
X-Iguazu-QSIG: v=2; s=0; t=1755556073; q=2rWhWAeBojNHTk5QeG; m=3pQdzuMdbu7M6eW39ALV3qeIYbA71GbLh+DjPlKgfgM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 57IMRoO6135278
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 07:27:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdUHNMxW3oYjcRrN26JR8XPgRFiHXzYJqCvNDQjtIaXRIJ8QgmvlkSuNYnTcPb/nN2R9vabH9Ud8pm6qKqx6C1PnKR61pCi0wOQW7qtvvKH8A0AzD7JT6WOs5Aq9PgwvPpGWHcP7FCH42NG6fwizNqBN8tUpKFv5Mibfk0CArneKzDoBJGf7jUKsCHzUCMkU+R/W3IolbzaSmtKXEsdQ5ijUdSQZwAFNyjEXCybOp+GNprO/dek6DTY3m6UKBCtkYak+YukFUgGyW1u2s/ODyh7PtHNMLchXNzWQXnFjtrF+SlbN8PnnGx90KleLw7+SMzFDFcc8gwzKD5fNfTWP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFmM9s8bKvLHaMevAy1QpJai+hTHB+mMYWtpDCJIU5w=;
 b=XmiEuo3ikFAf2rgD7dR15JSM3qaTNa0BOhDrO/AOz/JjYcaykP3MA0KR77Q+A/28VkhdUfI5sraNQKwC6WFEGm8Klm+k1nBsl5+Etx0QvQsPqVLPPAy09gcNzxpHfxt5Opl3wmjBCc88nCM2cl3bsEhy+ub11jpW6K7ihhhyruhQWhPXFNRx/Cf5Tmc0DMR7HBYApfZ2sIYc4XwDSJMLIgogPsiJva0KoyMKX3jdXvmHNxCrN9ghgD1EX7wwDEdUqa6Scgen/bi2IV5XiYvJJ62QxC0anxNUkkP+IDiZ/ZLhVxAXRJ2qAMkueUtaiZ108Szw8/cC4AbKQwpKGKf/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.1.148-cip45
Thread-Topic: [ANNOUNCE] Release v6.1.148-cip45
Thread-Index: AdwQjzkzj2jTkLGMTCSvaGUKrqWbNw==
Date: Mon, 18 Aug 2025 22:27:46 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148182511FA1B0AC6AB88832BCD31A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB12559:EE_
x-ms-office365-filtering-correlation-id: 22bb80f6-3017-4741-8fd8-08dddea674bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ajlIUmgvdy9Ienk2VDY1LzJIWlpVd0VlYWlWT1VvNmVKTHdmR3dLZk1z?=
 =?iso-2022-jp?B?OEJ5UDRrdzhJaVQzbzhhSkhsa2JGVkpYVFNFSkRyTU56RUgxbTcvbEhX?=
 =?iso-2022-jp?B?UnN1OE02R1d5OGJWT25wWDIyMzFpY1lDNk9FbllUTXZlaEswNlIyc1FH?=
 =?iso-2022-jp?B?WEJMWnVPOW4rRWlLaEZ4UDBLQ1oveWY3c1RKemhLLy92WHphSllGZWh3?=
 =?iso-2022-jp?B?eEtsVERudTZlL0VrNXF3bExDL080YVJhMUNxeCtFMXZmTDJwaTZZamxq?=
 =?iso-2022-jp?B?RVR1blU5VE1hbllUZ0JPUUFnQytrQWNTWFArMlJDYjNPNWxBa1B2TFR5?=
 =?iso-2022-jp?B?ZG1ZOTNkK2JhM2ZsY3o0OExka3ZlVktrNDJEYW5QcXFya3JDaDk2eFk2?=
 =?iso-2022-jp?B?OFRUU2ptbDN6ajM1Z01jS3ZES2ExSnVVZGhUYk5qS0c1U29aUk41cEZt?=
 =?iso-2022-jp?B?blRSZjlyNkhqNk1xZzZLWlRkT1dYS3VXWjhPcitYOEYzbGh3NGcxYWFk?=
 =?iso-2022-jp?B?dWlBUjRRditSYURUVStvL1ErQnBoeFYwZHpDZHBPYjZPVENFWEJ5MG1l?=
 =?iso-2022-jp?B?K2VnQUhJemNlZFFXMlFhM3BBTGwzQXZneEtkQnpnbTc0Y1RBYTZpQXpO?=
 =?iso-2022-jp?B?aFRSdWU1OFg5eDVMZG1BTXpXdnRieEpaaW9PT0JFdE5lRHdmRy9RMHBs?=
 =?iso-2022-jp?B?MmJNVnNYVm8ySGowT2U4Z09WbnFWMzlBaVQwVWNqR1hLSTRySzZPOXI3?=
 =?iso-2022-jp?B?K1Mrcy9DSzJrKyt3WGlpb21JRi9IaS9oMExEcnVlZ2ZidmovY3U5RXhR?=
 =?iso-2022-jp?B?VVNjK1ZWVS9IUTU1RWNvMFlkMnJHR3VaUXpFcWExM0RNaEZQQThubjFC?=
 =?iso-2022-jp?B?RHdpeFJ6YTU3N2lDam4yVWFrSUFJSDJQTmZZYTN3WXJXUStlRHdKeHlR?=
 =?iso-2022-jp?B?bXgreHcyMFV3RHMrY2dPV3F1RXBIU0hKeEt2Vm9UYWdqSDBVUHFoWkty?=
 =?iso-2022-jp?B?dmVWM3FqZXo0Ujdzejd6WktWUzI0NWVrK29mVjAxOE5qcHpGRkQzOVRw?=
 =?iso-2022-jp?B?ZStqT0ZxcTZGTzZ5eVRjamRXbEV5TWp1QUhiaHk4dWNqV3ppMG9FRDAw?=
 =?iso-2022-jp?B?Tno2cTd3bjA4VmtuUlY2cE1heWxhOHI4ZG5ER0pQWS9RT2lEWWd1ei8v?=
 =?iso-2022-jp?B?Skg5ZFFobEFoS0NhbTluek5YMXQwMFU3bEVMNDhJSlF5Qmh4K1poK2cy?=
 =?iso-2022-jp?B?Nlovam9zUnFPMkIxSDB0RjVFL3E0K0hicnQ4Rm5Kc1A4Uzl5K1VrVFFw?=
 =?iso-2022-jp?B?RlV1LzVLV3VWS1dQN2J1WmpYL1lQUlhVN0FXRWw1enZ5RCtwN3ZKVzNk?=
 =?iso-2022-jp?B?YU85MjFJdnJJdTlxRCtGQWtIRnZvait2UDBpVXBsWFgrZlBZTzlNNk9o?=
 =?iso-2022-jp?B?S0tlZXhpVk5IU0FSd2VGNVV2aDRNWGgzV2tMU1ZnZTZkNFdsOUE4a001?=
 =?iso-2022-jp?B?SEZEdVFqWHZiSi9PWE1EYXZSYkgvZzdsd29LZnVKbjdrR3N1VUI4dVJM?=
 =?iso-2022-jp?B?cndKYzhtT3E1QU1TaHIrT0dVdEd1QUtNSjYyOUlta0pwelhIbDlNdnhF?=
 =?iso-2022-jp?B?dk1NQllOUGVJVkdtTXhGa3ZjYXFPYzI0ZlZEMVRibkIwcXhnUUU3a1dw?=
 =?iso-2022-jp?B?VW9mMnFBcUxpaERtc3JHVmprVTVzWWFZYk5qZHIxUVN5bnV0c1hRSkRB?=
 =?iso-2022-jp?B?dlpWU1ljb1Avd2xmY29rbHRML3ZQNUtzaDJBakd4MWo2bTRXZzYyd2Fr?=
 =?iso-2022-jp?B?VGs4THJhWXFwSGNaTjNKTzFPckpUcjlkRDdTTXZOeGpmb0NxeU1rSmFM?=
 =?iso-2022-jp?B?NUF4NW5PY2Ric2lNTWlqckdscDl4SEZXUFdjTmY0dHlrajNXTTVEaE5O?=
 =?iso-2022-jp?B?WHY3b0lzRHhPQ1BMVHpuWlpqS0hKcEtNTEJXUUdMcW1FaXhaTUNHWENF?=
 =?iso-2022-jp?B?dTllOGRZaWtFbm9BYVRCenpMV08wTGp0azhUYTFvN1JQZ09uZ2p2eVlT?=
 =?iso-2022-jp?B?bjZKaHhsUUZnMFdyNzY5VHdQWGlLSE8xbWsvemd4YWhycUg0VXlML2lG?=
 =?iso-2022-jp?B?TzlZU0ZDZU9GRlRlRHFnMnJkVkxiK3AvdmdlUlgvUlRTdVdsaWVDYzlw?=
 =?iso-2022-jp?B?dUYwPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?em9FVU5CbEcvakNzQjhaVndLSHk3WjVTNk5KSnVXR0lxZmN4QmJTdUtx?=
 =?iso-2022-jp?B?UkpiTHpDS2ZGV0s1aFFXWktsS2hBRVp6bk5aaitidlZNdnR6dWVpNlBS?=
 =?iso-2022-jp?B?cnZMQ3FyZ0FHWmIrNkM3azYvODQ2QXZuUXVQVHh5MXBzd0QyK0h6Y2pE?=
 =?iso-2022-jp?B?QlN0UG5WWlIvMTViOFV1a1Y4dUJ0NVdaeS92STNWd0UySVpqZDIwb2Fv?=
 =?iso-2022-jp?B?YWduUGxta3d5SjlUQm1DQlQwVmpVRjhhUzUraGVGL1ViZUcyWHY0YkJU?=
 =?iso-2022-jp?B?QXZCMjNmVTdrc0NtMml4Y3FoM0JtTVI4Zmw5dkwyQjhTWmRBU1NZT25z?=
 =?iso-2022-jp?B?WGp1bDBOb0xmMzVWSC92cUFYUjJlaXFWcnhxTGFwQkw3dnBMVWZsd3lo?=
 =?iso-2022-jp?B?NUdUMERnZVNBREJJUlpKYnd5UXJFMG1ZVHNuYlB2dHE1cm5SUHFlYktQ?=
 =?iso-2022-jp?B?aEFuMzJjMUU5OUY4YzliREdCa2pYa2l3WXZOeUJLaGxKeVEyMGMvUG54?=
 =?iso-2022-jp?B?WTIrY3RXdGNhRkorcENhaXJaN3ZiTTV2bTRVUFJqVzFMT2Z4bG0wYVVM?=
 =?iso-2022-jp?B?ZjU1NUZWb2FLWGRVejNjWG9sd2c2QnRmR1B0QWRlT0FreFVFMytlMG9i?=
 =?iso-2022-jp?B?OEFFNk9NTjlsdWR4dzU5MzhFZE9HYktnTE1RdG5IbU1OU3F1U1ZLU2hV?=
 =?iso-2022-jp?B?Tkloa29pL0ZaMCs0UmxVMGxFV1RTL3puMjRiUEVwRnA4dGRoS0JhdXlz?=
 =?iso-2022-jp?B?aW5VbDU0dnJTU01BS3hXUmV6UFVPdmFJL1dZb3Q3S2JzT3pVU2szRnpl?=
 =?iso-2022-jp?B?MGs0dFBwR2JNbzlHZHJraENlNGV1dHdGREVxNGZFcDRsSmtJUmRMNDVp?=
 =?iso-2022-jp?B?Y0ZvRmx0M2FXWGwzb1U3UlIwcHh6ZXZnc2V5SHpnT1ZtdjZ4bk8yNmYz?=
 =?iso-2022-jp?B?NGxUNW00Zm13MjAxRGd4bjJudVk4Q1lRQUhva0NMOU5GSkU4ZE9Vb1p2?=
 =?iso-2022-jp?B?dm9Za1hSRmZSNk9LY3FJNEdLYkMzK3BoOEN1QTBzdGNvUHpvdkxRUmt1?=
 =?iso-2022-jp?B?dXNiZm91VERpeWV6NHNDNWR1dkNJN3ByT1p5Yyt3Y3llR2IvOE45YkNu?=
 =?iso-2022-jp?B?L2hLN2cwMDFqK0RaVE9URDNpbjhRZmVTOUVyZ1JYMVp4NERvNHVzTUUy?=
 =?iso-2022-jp?B?a0dNT0lXV1BtMWNzOE5NMlV3MGovR2NzWjg0L013S0xwcW1IUWR2UVBI?=
 =?iso-2022-jp?B?eElXb1lha3pzUGdHVWRvenY1MXduUlFUTExJSWFHTkMvUU40S3hydUtm?=
 =?iso-2022-jp?B?L3VyZkNuRnNHTENaYzNNZ1BOckxlVzNQYVhxdHVXQWhiSGpMaEVvK2dp?=
 =?iso-2022-jp?B?WEFnRlpZUnhRTCtydmNaOG1ZK3pvajFWcEdPQzdaQzViREViV3RNd1J1?=
 =?iso-2022-jp?B?K2NqTW54VVBhS1N0emF2MGFRUnNReEM5OFJ4akpYZTJ3WWQyRWUvWFU1?=
 =?iso-2022-jp?B?enQzN0ZiN2lUMk4wa0ovT1dzZ2JmenJWZ0UxdXliZVpJZGpSeW5QbmhK?=
 =?iso-2022-jp?B?c0VJYktIMnQ5eHZpRVU3UDIvZlM1VGRDWEo4WUpvM25WckN3S1R0MmhK?=
 =?iso-2022-jp?B?SnRhaHdSKzIyWFNRd3VBM0NVQWpwMzdjQ0J5eUNRelljNjJnbjRaVG14?=
 =?iso-2022-jp?B?WFhNeEt4dk9iS2hidVdnQ3laMGljK0g4TW1XSGlmaUxyZGYxT0pXdWxp?=
 =?iso-2022-jp?B?QmRSM09hUjR5UE0vUmtRSmRpVXR3b1AzZ0pwK1U0aUh0QkJjMnVJSXNC?=
 =?iso-2022-jp?B?Wnl3bzQ4QlJrT0E0NldUM3lReS92MUxTTDVKdDRvTGtxRUJiWityKzJk?=
 =?iso-2022-jp?B?L1pvNXBWc0dpWDBiaDd3RXJIUVFzUG13YTl2L3pJem1yMXdDMFZ5UHdu?=
 =?iso-2022-jp?B?d25xbW5Ra0RsVWlGeVVrbWYyOVk0ZnBiS1hqYWowc3lxQjNrSHd0L3VQ?=
 =?iso-2022-jp?B?dVZVanpENWRYOW1tQzJFcTI1eG92dHFvazcyRmRLYkg1eW9zTkRXeUgx?=
 =?iso-2022-jp?B?VmY1aHpVdnRjT0oxSTBBRCtoTk80ZEpOOThaaXQ4ajhvUjVJN1dBblds?=
 =?iso-2022-jp?B?dkR1OTlqTFJoeGhsQkt4NDZDekVnb1FGbk8wRnZkRWZ5bFM3OXhFV1ZQ?=
 =?iso-2022-jp?B?dUhndm13VGZiTDlBWTUvVnlXQnVsa1lKRHg3UEVZMjRxSGxaZ0pMbC9C?=
 =?iso-2022-jp?B?MHhaYnZwdHFBdXBIRkxDcFR4RTI2Y09LQlNETzg0NzZwcDBtTDIxSHhz?=
 =?iso-2022-jp?B?VVN3dVRhOVgrZmJlOGpCMnVwZUprOERxbVE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22bb80f6-3017-4741-8fd8-08dddea674bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 22:27:46.0901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QcwYjKdWiG6rU7ktFjtZn+RtDnnYLmgmy3Xj87OWdWu/wU056kNftkckX/7KeCn0FkM9VaLLbRKw9p8zqqd8oSGJRzi7cCdmHJI16hRW2/fb9tYHplXJws5i+GHAAIRB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12559
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Aug 2025 05:02:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19763

Hi all,

CIP kernel team has released Linux kernel v6.1.148-cip45.
The linux-6.1.y-cip tree has been updated base version from v6.1.145 to v6.=
1.148.
This release adds CANFD and Clock updates for Renesas ARM64 kernel SoCs.

Information about this release is as follows:

  v6.1.148-cip45:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      4d0a8db08c739a7353c078fbdcce2a2e7e5b7363
    fixed CVEs:
      CVE-2025-38467: drm/exynos: exynos7_drm_decon: add vblank check in IR=
Q handling
      CVE-2025-38437: ksmbd: fix potential use-after-free in oplock/lease b=
reak ack
      CVE-2025-38458: atm: clip: Fix NULL pointer dereference in vcc_sendms=
g()
      CVE-2025-38459: atm: clip: Fix infinite recursive call of clip_push()=
.
      CVE-2025-38441: netfilter: flowtable: account for Ethernet header in =
nf_flow_pppoe_proto()
      CVE-2025-38457: net/sched: Abort __tc_modify_qdisc if parent class do=
es not exist
      CVE-2025-38510: kasan: remove kasan_find_vm_area() to prevent possibl=
e deadlock
      CVE-2025-38464: tipc: Fix use-after-free in tipc_conn_close().
      CVE-2025-38546: atm: clip: Fix memory leak of struct clip_vcc.
      CVE-2025-38542: net: appletalk: Fix device refcount leak in atrtr_cre=
ate()
      CVE-2025-38444: raid10: cleanup memleak at raid10_make_request
      CVE-2025-38462: vsock: Fix transport_{g2h,h2g} TOCTOU
      CVE-2025-38074: vhost-scsi: protect vq->log_used with vq->mutex
      CVE-2025-38455: KVM: SVM: Reject SEV{-ES} intra host migration if vCP=
U creation is in-flight
      CVE-2025-38503: btrfs: fix assertion when building free space tree
      CVE-2025-38461: vsock: Fix transport_* TOCTOU
      CVE-2025-38465: netlink: Fix wraparounds of sk->sk_rmem_alloc.
      CVE-2025-38460: atm: clip: Fix potential null-ptr-deref in to_atmarpd=
().
      CVE-2025-38067: rseq: Fix segfault on registration when rseq_cs is no=
n-zero
      CVE-2025-38513: wifi: zd1211rw: Fix potential NULL pointer dereferenc=
e in zd_mac_tx_to_dev()
      CVE-2025-38543: drm/tegra: nvdec: Fix dma_alloc_coherent error check
      CVE-2025-38456: ipmi:msghandler: Fix potential memory corruption in i=
pmi_create_user()
      CVE-2025-38516: pinctrl: qcom: msm: mark certain pins as invalid for =
interrupts
      CVE-2025-38512: wifi: prevent A-MSDU attacks in mesh networks
      CVE-2025-38445: md/raid1: Fix stack memory use after return in raid1_=
reshape
      CVE-2025-38364: maple_tree: fix MA_STATE_PREALLOC flag in mas_preallo=
cate()
      CVE-2025-38466: perf: Revert to requiring CAP_SYS_ADMIN for uprobes
      CVE-2025-27558: IEEE P802.11-REVme D1.1 through D7.0 allows FragAttac=
ks against mesh ...
      CVE-2025-38443: nbd: fix uaf in nbd_genl_connect() error path
      CVE-2025-38448: usb: gadget: u_serial: Fix race condition in TTY wake=
up
      CVE-2025-38515: drm/sched: Increment job count before swapping tail s=
psc queue
      CVE-2025-38540: HID: quirks: Add quirk for 2 Chicony Electronics HP 5=
MP Cameras
      CVE-2025-38439: bnxt_en: Set DMA unmap len correctly for XDP_REDIRECT
      CVE-2025-38514: rxrpc: Fix oops due to non-existence of prealloc back=
log struct
      CVE-2025-38451: md/md-bitmap: fix GPF in bitmap_get_stats()
      CVE-2025-38396: fs: export anon_inode_make_secure_inode() and fix sec=
retmem LSM bypass
      CVE-2025-38538: dmaengine: nbpfaxi: Fix memory corruption in probe()
      CVE-2025-38488: smb: client: fix use-after-free in crypt_message when=
 using async crypto
      CVE-2025-38535: phy: tegra: xusb: Fix unbalanced regulator disable in=
 UTMI PHY mode
      CVE-2025-38481: comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too =
large
      CVE-2025-38528: bpf: Reject %p% format string in bprintf-like helpers
      CVE-2025-38468: net/sched: Return NULL when htb_lookup_leaf encounter=
s an empty rbtree
      CVE-2025-38527: smb: client: fix use-after-free in cifs_oplock_break
      CVE-2025-38550: ipv6: mcast: Delay put pmc->idev in mld_del_delrec()
      CVE-2025-38480: comedi: Fix use of uninitialized data in insn_rw_emul=
ate_bits()
      CVE-2025-38495: HID: core: ensure the allocated report buffer can con=
tain the reserved report ID
      CVE-2025-38530: comedi: pcl812: Fix bit shift out of bounds
      CVE-2025-38487: soc: aspeed: lpc-snoop: Don't disable channels that a=
ren't enabled
      CVE-2025-38499: clone_private_mnt(): make sure that caller has CAP_SY=
S_ADMIN in the right userns
      CVE-2025-38474: usb: net: sierra: check for no status endpoint
      CVE-2025-38477: net/sched: sch_qfq: Fix race condition on qfq_aggrega=
te
      CVE-2025-38494: HID: core: do not bypass hid_hw_raw_request
      CVE-2025-38539: tracing: Add down_write(trace_event_sem) when adding =
trace event
      CVE-2025-38470: net: vlan: fix VLAN 0 refcount imbalance of toggling =
filtering during runtime
      CVE-2025-38483: comedi: das16m1: Fix bit shift out of bounds
      CVE-2025-38529: comedi: aio_iiro_16: Fix bit shift out of bounds
      CVE-2025-38472: netfilter: nf_conntrack: fix crash due to removal of =
uninitialised entry
      CVE-2025-38473: Bluetooth: Fix null-ptr-deref in l2cap_sock_resume_cb=
()
      CVE-2025-38478: comedi: Fix initialization of data for instructions t=
hat write to subdevice
      CVE-2025-38485: iio: accel: fxls8962af: Fix use after free in fxls896=
2af_fifo_flush
      CVE-2025-38497: usb: gadget: configfs: Fix OOB read on empty string w=
rite
      CVE-2025-38476: rpl: Fix use-after-free in rpl_do_srh_inline().
      CVE-2025-38548: hwmon: (corsair-cpro) Validate the size of the receiv=
ed input buffer
      CVE-2025-38471: tls: always refresh the queue when reading sock
      CVE-2025-38482: comedi: das6402: Fix bit shift out of bounds
      CVE-2024-36331: x86/sev: Evict cache lines during SNP memory validati=
on
      CVE-2025-38501: ksmbd: limit repeated connections from clients with t=
he same IP
      CVE-2025-37925: jfs: reject on-disk inodes of an unsupported type
      CVE-2025-38335: Input: gpio-keys - fix a sleep while atomic with PREE=
MPT_RT
      CVE-2025-38520: drm/amdkfd: Don't call mmput from MMU notifier callba=
ck
      CVE-2025-38500: xfrm: interface: fix use-after-free after changing co=
llect_md xfrm interface
    added commits:
      CIP: Bump version suffix to -cip45 after merge from stable
      arm64: dts: renesas: rzg3e-smarc-som: Add RAA215300 pmic support
      arm64: dts: renesas: rzg3e-smarc-som: Add I2C2 device pincontrol
      arm64: defconfig: Enable CAN PHY transceiver driver
      arm64: dts: renesas: r9a09g047e57-smarc: Enable CAN Transceiver
      arm64: dts: renesas: r9a09g047e57-smarc: Enable CANFD
      arm64: dts: renesas: r9a09g047: Add CANFD node
      can: rcar_canfd: Add RZ/G3E support
      can: rcar_canfd: Enhance multi_channel_irqs handling
      can: rcar_canfd: Add external_clk variable to struct rcar_canfd_hw_in=
fo
      can: rcar_canfd: Add sh variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add struct rcanfd_regs variable to struct rcar_canfd=
_hw_info
      can: rcar_canfd: Add shared_can_regs variable to struct rcar_canfd_hw=
_info
      can: rcar_canfd: Add ch_interface_mode variable to struct rcar_canfd_=
hw_info
      can: rcar_canfd: Add {nom,data}_bittiming variables to struct rcar_ca=
nfd_hw_info
      can: rcar_canfd: Add max_cftml variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add max_aflpn variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add rnc_field_width variable to struct rcar_canfd_hw=
_info
      can: rcar_canfd: Update RCANFD_GAFLCFG macro
      can: rcar_canfd: Add rcar_canfd_setrnc()
      can: rcar_canfd: Drop the mask operation in RCANFD_GAFLCFG_SETRNC mac=
ro
      can: rcar_canfd: Update RCANFD_GERFL_ERR macro
      can: rcar_canfd: Drop RCANFD_GAFLCFG_GETRNC macro
      can: rcar_canfd: Use of_get_available_child_by_name()
      can: rcar_canfd: Remove superfluous parentheses in address calculatio=
ns
      can: rcar_canfd: Improve printing of global operational state
      can: rcar_canfd: Simplify clock handling
      can: rcar_canfd: rcar_canfd_probe(): fix plain integer in transceiver=
s[] init
      can: rcar_canfd: Improve error messages
      can: rcar_canfd: Add transceiver support
      phy: Add devm_of_phy_optional_get() helper
      phy: Remove unused phy_optional_get()
      can: rcar_canfd: Add helper variable dev
      can: rcar_canfd: Sort included header files
      can: rcar_canfd: Fix R-Car Gen4 CFCC.CFTML field width
      can: rcar_canfd: Fix R-Car Gen4 DCFG.DSJW field width
      can: rcar_canfd: Add support for R-Car Gen4
      can: rcar_canfd: Abstract out DCFG address differences
      can: rcar_canfd: Fix R-Car V3U CAN mode selection
      dt-bindings: can: renesas,rcar-canfd: Document RZ/G3E support
      dt-bindings: can: renesas,rcar-canfd: Simplify the conditional schema
      dt-bindings: can: renesas,rcar-canfd: Add transceiver support
      dt-bindings: can: renesas,rcar-canfd: R-Car V3U is R-Car Gen4
      dt-bindings: can: renesas,rcar-canfd: Fix number of channels for R-Ca=
r V3U
      dt-bindings: can: renesas,rcar-canfd: Document RZ/Five SoC
      clk: renesas: rzv2h: Use both CLK_ON and CLK_MON bits for clock state=
 validation
      clk: renesas: rzv2h: Use str_on_off() helper in rzv2h_mod_clock_endis=
able()
      lib/string_helpers: Split out string_choices.h
      clk: renesas: rzv2h: Support static dividers without RMW
      clk: renesas: rzv2h: Add macro for defining static dividers
      clk: renesas: rzv2h: Add support for static mux clocks
      clk: renesas: rzv2h: Fix a typo
      clk: renesas: rzv2h: Sort compatible list based on SoC part number
      clk: renesas: rzv2h: Simplify rzv2h_cpg_assert()/rzv2h_cpg_deassert()
      clk: renesas: rzv2h: Improve rzv2h_ddiv_set_rate()
      clk: renesas: rzv2h: Rename PLL field macros for consistency
      clk: renesas: rzv2h: Add support for enabling PLLs
      clk: renesas: rzv2h: Remove unused `type` field from `struct pll_clk`
      clk: renesas: rzv2h: Update error message
      clk: renesas: rzv2h: Adjust for CPG_BUS_m_MSTOP starting from m =3D 1

Best regards,
  Nobuhiro


