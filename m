Return-Path: <Chris.Brandt@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAC3FAD3EB
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 01:48:08 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3500.1776908882061550622
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Apr 2026 18:48:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=G8/KaWXS;
 spf=pass (domain: renesas.com, ip: 40.107.74.41, mailfrom: chris.brandt@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nm2gD4u4JME6emR7va5byyvaLZG6McMsBYbBfgSSf28wG1UKZzkdZ1pjwF4qlFAIPG7S6Rp1SVUUnERifIA1dERx1ug7nRtq7gemGhP7pkkgOur67VdAOElSA7NzY4VGLfPaJrveQK8kQeJ8VUx4fGNEl882wnhNALmAXa4R4GmSlAMshnZVUZHuavRwBOM6cyssJ1BmBEBiRtDYCxTpCrICLemudYL1pN1IqK+ZgHV0Jd2/YgHOSyLJpifsTE139K82H1IacMxlFzBb6cxaFNz6Dl44dBXrM7MBmg39feGlLUtjNsw0jhcY49g2in1U7p/c0lWCFn8RJiIMCnELAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5NRAS0WpOvA71IEyevb904ook95GsYjzDna6aYdhTc=;
 b=D6OcHUzhSSn88Djz6UdRDE5zwtj8PZ96s7yQaIjRem+50AyTVoqgFUbNoFSKwreY+iEhznAIz3fzLAkaC2DThL9+o0keIq0XV3CQY/VptSfd4ZDGt2lChstyyThMOiCQqK7DpS1tPfNfqE0blJiNtodkkYYgZoji9/AY7UCBWT5TMMgULHw17zLycLZ54KLHfY9jMgW4kA9p65YtDEGayIkXA1yyLiYu4/3k8yUB97NOKxdLhn0+8NmSBJKc9BmqXxZHpwthpCKoyHwWHFCx/vfkTHvZsJGp7Eq23XZK9hJHMfezTieEz/0nnooFYXYMR9KqFIMVE4vDdF5Xmz8TMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5NRAS0WpOvA71IEyevb904ook95GsYjzDna6aYdhTc=;
 b=G8/KaWXSpm8wPyySqivmcXMLBpLyaFW/cgU+smU+TpHpgcgCQrykNMan1hy9kCkiHaYMdUMqjEqtQu3xVjklRzl4uQwkTLkqesdrGtO4QNhQI3JhbbCeQWuGbepKrm7tudrrYF2M3gj5O5cnC7mvgkZ4P/IOuQGOOn+GLUDVwBI=
Received: from OS3PR01MB8319.jpnprd01.prod.outlook.com (2603:1096:604:1a2::11)
 by TYWPR01MB9936.jpnprd01.prod.outlook.com (2603:1096:400:236::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 01:47:54 +0000
Received: from OS3PR01MB8319.jpnprd01.prod.outlook.com
 ([fe80::6473:1660:bdc2:c983]) by OS3PR01MB8319.jpnprd01.prod.outlook.com
 ([fe80::6473:1660:bdc2:c983%4]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 01:47:54 +0000
From: Chris Brandt <Chris.Brandt@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 06/10] clk: renesas: rzg2l: Fix intin
 variable size
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 06/10] clk: renesas: rzg2l: Fix
 intin variable size
Thread-Index: AQHc0qDrSinnKLPep0mZrIfCwV0oP7Xr37oL
Date: Thu, 23 Apr 2026 01:47:53 +0000
Message-ID: 
 <OS3PR01MB8319CE5D43B757DE104545318A2A2@OS3PR01MB8319.jpnprd01.prod.outlook.com>
References: <20260415181810.4073807-1-chris.brandt@renesas.com>
 <20260415181810.4073807-7-chris.brandt@renesas.com>
 <TY7PR01MB148187DC9C6369DD3CFCEFD29CD2D2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB148187DC9C6369DD3CFCEFD29CD2D2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8319:EE_|TYWPR01MB9936:EE_
x-ms-office365-filtering-correlation-id: 4cf58562-e54e-44d7-de21-08dea0da55fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|8096899003|13003099007|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 
 WEln5ARRlC9BPu2hh/znu30vBzR8n257pU3AU63oQfjVAowCH/7f0SOeqdGvafO83HXz2E3ALFA77fOs3OGo5Ww13HfaJwWIXnqhrERw45sGRiFhpq/Sy/7hnEb1z/P1N6o56XItQaylinZvg/HX0AiHjZ3XjQx6EFxzGgKecOdwGSC64GRl9gkNbIXFHzcSL6LM/1vMrMkrFcimz3MbdfRHTMYoMuzxYFV5VUSKHp50loG0CgqBk0q01AV+kicHWG8s/3bgXuGYNkj6NjVDI9q3sytxYWTW2i5jVzP2fMf+82sE+zgi1z+7s1U76KS2u3NUT19D4iUSdOjHt3R7LEV0glRW8/2qRvH1QF9DWn5dlv9ee9cZkuHHXlrsFF4zQe3vyn+6Il0pmmvDT6PuQXx/2jNIT3DS1bBcIuL1q8p5LuFOKD5nqbAhwhBEfqLqy/oCfQQ+xU8dGOCWEbDjDmzHCXsE1jbKujtob6g2RM+arl2fPwLd3wYvd2TIwyhwd0XJ6rR2AWBo4qgiMyUWLJNG65m3CJFR2/XR8Gx5deZGsyBZTRT8BtFq/yNd5g06z1LaHmHQ/qw0JkoKsX1HnlVaIDeJCc/l9gYhkZtO/nzSeamb9998RtzMqdfgAc5Xnv9PJzfCnUnWbH058gk+WZP1y6MXNzLBrby0TXrfd049OFE+mwVtK3Cg0lJ1KZEsT+fVdphw3SQcUU3Oj0Rm+YbMu4UDwnCrssAeQ77snw9dr3XAV3jxOiS3Gev0Oa6D
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8319.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(13003099007)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QXdzemlyd0o3WVZraFE2YmpFL2o4UGc4U1ZNRU1vR0VRSUJDc1VwSGc4?=
 =?iso-2022-jp?B?NkhEYkRjbmJWRFlxVFVUTXRIenhIakZqKzl0SGlRSSs5SWVta201UXJq?=
 =?iso-2022-jp?B?ZktBOVZMR282YUQrZjVHRndhYVBicUFEcWJNRHZZU3JncDhLK2ZJTFFU?=
 =?iso-2022-jp?B?Z0U5VjNtT3R3OVJJaE1QSVlxNVRVUkswbWUvTkhKcUMxUmRzMEZxY3Nx?=
 =?iso-2022-jp?B?ekZUYUNkMzYvVUhnY1Y0cmFZbE5JRzM5aStJVFV6eFRTSUsrSEdjL1Yw?=
 =?iso-2022-jp?B?aUZMY295cndNSHBIYVY1N1BNSjZMTEYxdlBKSkwvQ3pCNzlxYk4rSDlK?=
 =?iso-2022-jp?B?VExaL2JhRWdSWHdCRmY0UFd5QlRjbmMrNjM3VFYwVlFPSkdTRkRVVVlZ?=
 =?iso-2022-jp?B?a3UrR2JMZ0J5Yy91QU5sUUFqREVSSDdadzQ0YzFoMXVZd3JJQW82b3pI?=
 =?iso-2022-jp?B?TGtJZ2M1TkR2Nk1GN3BNcnBPT1hrVWMvZm9MM0FuM3J4Tk9VMms0Nmt5?=
 =?iso-2022-jp?B?UlY3a0RlT0hwbnJqNFBMeVZNQXM3Sk9CU0JlRHJNcVpSTk5OQ3ZNSkY1?=
 =?iso-2022-jp?B?VTNzcTRCcGtuOUF5ZUkwME1TUTdvL3pTRlptQjRVT2RSa3ptVzJteXdX?=
 =?iso-2022-jp?B?ZzVyZ3Q3RmgyY0wrOTRJd1RuTTYyalBxNytJRzBJQU9JLzU4Z2hzWHBk?=
 =?iso-2022-jp?B?QTYyYzY4ZDFIRU4vQkZQQm5nNFhZV2lmUkN4eXFuN0RERmwycHkydjd0?=
 =?iso-2022-jp?B?ZGxuZXpacnE2YkxYT21XTHFlL21LaGhTZzQyN2ZQRmY4K210aHVFUkZa?=
 =?iso-2022-jp?B?V2hWNDlmYnlOb3lBUXdUYWVDL0MzNGdNNjVsZWdYTlVXZkR4OWxuNEFu?=
 =?iso-2022-jp?B?MUVpemN6Y2NNVVBYMmhONzI1UTR3ODRVTFhEbnFjSjgwRVRxcEJUekt0?=
 =?iso-2022-jp?B?Uk1zMVFGcUY4TGVxSWRxTEpOalRRRjRvZUx4TTMyUHg5djdHTkJZazhz?=
 =?iso-2022-jp?B?L1Q1Wi9Wa1FVallWSGpiYk1helowRXlEeGVIRU5lQXZ6S0xnaU93dFha?=
 =?iso-2022-jp?B?WnBsWG1ldTNQeEFnZldWRDlCVWMxQi9sWVNGR1ozSHU3bStLZG1OQzdx?=
 =?iso-2022-jp?B?Z21oUEt4cUxmOHVTT2JCRG02ZG9Qem4vVm1jODFzQW9mbXFrdldNOXdO?=
 =?iso-2022-jp?B?c2UvL0R5V0dMTmhEMU03dFJDWjh4T3BaVTV5QlJvb1VEaFhmVjBOQXZR?=
 =?iso-2022-jp?B?MHBxbndnVGJPV0tvcTE2akFZQXJmZStkQk1UR3RaRlFyazhoSjJQVFEy?=
 =?iso-2022-jp?B?eHJzT3B2aWt2cUg1dDVpK1RPRUhHcDF0Z3RjWkVKb3JHSnFReklxNnEy?=
 =?iso-2022-jp?B?YXBYTnRjMkNSZUVsZ2U0Mjc0Z0thR2VEVFpNR0JhYWJBcnF4WEdZTkY0?=
 =?iso-2022-jp?B?SlpvMXE2ejJ3N2dqWWNOVEczZWNzNm5vSHFqNlpxQ1dSVjZoaUNnclNx?=
 =?iso-2022-jp?B?eS9sQ0pBRUR2YVFKN1VqYkEvckUxUUd4am9nczVCSnNLTVd6VXA3SlNF?=
 =?iso-2022-jp?B?NW5PVXRXZ0xkbS8yNjQvRHV0a0U0RndtRHlEQnNXUnhvbXN2c0c2QlBt?=
 =?iso-2022-jp?B?NjJFK2xWaXlreW5VK1VyT0wzUzJTaElCSjA1bUtpN3B3blNTM3hDU2xS?=
 =?iso-2022-jp?B?NmxOMUU1MDJDZWJCcmJRck50WUFkaTlaZGpYdWI1U1Q5TDlLMDcxbWtR?=
 =?iso-2022-jp?B?Mlk5RjBqQ2VaalVtd3MzT0xNYzNaRzZ5YmlqZm5RK3hRbnFya3Y5UDhT?=
 =?iso-2022-jp?B?bHlONWJ0MVYxZE40blZtMTdpem42bGtMYjZ4dFBtbnJhU3VmRGdPNitl?=
 =?iso-2022-jp?B?eGE2ZjYwMmR3N3YvdnlSSTFUSzZJREZKNEY4SGZDclRxaHhRK2syblZ2?=
 =?iso-2022-jp?B?bTUyNXllR1hDbG5pd3I2TUp5SVNKamM0Y1Y0T2pMUVJGbzV5V1JOK3pN?=
 =?iso-2022-jp?B?aE5Yem9sQ1FsYVBIVnBJTGh2UlQ4aDJvMHpWdjB6ZjFZaGJEMWVLUkI2?=
 =?iso-2022-jp?B?SHpUVmY1NUVIdzIyZzI2SUFkdkltaFZYT3pCQU1CSTJEQ2ZNK3pFNDVF?=
 =?iso-2022-jp?B?aWNxOUYwRHJwNW1MUGNKaHBxaXFYYXZ6amVNNW1kdUxDRGxlY242MDlG?=
 =?iso-2022-jp?B?amtRNitoeVNZNUdyUTNpQzBDR3FvNGJ5K2J1d0pNeGY5QXI4b0o5VzRH?=
 =?iso-2022-jp?B?alp1ODRGemd5akQxbmlMck1vaGxHU1VsQzI4dW10QWg3TnJlTlJDNGp4?=
 =?iso-2022-jp?B?Z2NpbFJXL0s4N1pXMzhwR0hQTUJmdmNmbXlDN1RHclErSjA5ZHh2WmZm?=
 =?iso-2022-jp?B?Zmk4MUFRek5OQmJDd1JOelNsTFF3b3kwQ2VzWlY4TUxmdHkxMVc4QTNQ?=
 =?iso-2022-jp?B?ejFzTmRaaTBjSFA0c2lkWkppbFF1N1JST2hkRzE4cnN3NDhxTWlBRm12?=
 =?iso-2022-jp?B?Rmp1SVV1alpWeXlFM3lJN2F2RXA5aU0wRExJdz09?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB8319CE5D43B757DE104545318A2A2OS3PR01MB8319jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8319.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf58562-e54e-44d7-de21-08dea0da55fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 01:47:53.8532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9P5uXs8eaerHzdtUHPDCBwW07YfagW/9YJc2GGkWFWneo1BLPnwIjRuhMtMwkMFqubRWymQEYECTGXU9bnAldcWwL31JzUb1TWz15hHHHSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9936
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Apr 2026 01:48:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22789

--_000_OS3PR01MB8319CE5D43B757DE104545318A2A2OS3PR01MB8319jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi,

> It looks like you're backporting patches from LTS.
> Could you please backport them from the upstream kernel?

Since this is just a 1-line change, all I need to do is update the commit m=
essage.
The commit hash is from the upstream kernel.

So, all I have to do is remove this line from the commit message:

> Signed-off-by: Sasha Levin <sashal@kernel.org>

Do you want me to re-submit the entire series? Or just this patch?


Chris


________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Nobuhiro Iwamatsu via lists.cip-project.org <nobuhiro.iwamatsu.x90=3D=
mail.toshiba@lists.cip-project.org>
Sent: Wednesday, April 22, 2026 5:42 PM
To: Chris Brandt <Chris.Brandt@renesas.com>; cip-dev@lists.cip-project.org =
<cip-dev@lists.cip-project.org>; pavel@nabladev.com <pavel@nabladev.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 06/10] clk: renesas: rzg2l: Fix in=
tin variable size

Hi,

> -----Original Message-----
> From: Chris Brandt <chris.brandt@renesas.com>
> Sent: Thursday, April 16, 2026 3:18 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>
> Subject: [PATCH 5.10.y-cip 06/10] clk: renesas: rzg2l: Fix intin variable=
 size
>
> [ Upstream commit a00655d98cd885472c311f01dff3e668d1288d0a ]
>
> INTIN is a 12-bit register value, so u8 is too small.
>
> Fixes: 1561380ee72f ("clk: renesas: rzg2l: Add FOUTPOSTDIV clk support")
> Cc: stable@vger.kernel.org
> Reported-by: Hugo Villeneuve <hugo@hugovil.com>
> Closes: https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Flore.kernel.org%2F20251107113058.f334957151d1a8dd94dd740b%40hugovil.com&=
data=3D05%7C02%7CChris.Brandt%40renesas.com%7C5800573b6dfd43099f3b08dea0b81=
c1d%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C639124909762951163%7CUnkno=
wn%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMi=
IsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DAubj6SDPhuTOrs1Zp7w=
dfyFQUSYQxi0UeAiqCOUPAac%3D&reserved=3D0<https://lore.kernel.org/2025110711=
3058.f334957151d1a8dd94dd740b@hugovil.com>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fpatch.msgid.link%2F20251114193711.3277912-1-chris.brandt%40renesas.com&dat=
a=3D05%7C02%7CChris.Brandt%40renesas.com%7C5800573b6dfd43099f3b08dea0b81c1d=
%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C639124909762976580%7CUnknown%=
7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsI=
kFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DMwsosum%2FweloQSkzyLfC=
LpNo52mw7ZImb%2FcdbTlk430%3D&reserved=3D0<https://patch.msgid.link/20251114=
193711.3277912-1-chris.brandt@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

It looks like you're backporting patches from LTS.
Could you please backport them from the upstream kernel?

> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
>  drivers/clk/renesas/rzg2l-cpg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-=
cpg.c index 0c0d9d76c4d6..c45c22190fcd
> 100644
> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -121,8 +121,8 @@ struct div_hw_data {
>
>  struct rzg2l_pll5_param {
>        u32 pl5_fracin;
> +     u16 pl5_intin;
>        u8 pl5_refdiv;
> -     u8 pl5_intin;
>        u8 pl5_postdiv1;
>        u8 pl5_postdiv2;
>        u8 pl5_spread;
> --
> 2.52.0

Best regards,
  Nobuhiro


--_000_OS3PR01MB8319CE5D43B757DE104545318A2A2OS3PR01MB8319jpnp_
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
Hi,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; It looks like you're backporting patches from LTS.<br>
&gt; Could you please backport them from the upstream kernel?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Since this is just a 1-line change, all I need to do is update the commit m=
essage.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The commit hash is from the upstream kernel.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
So, all I have to do is remove this line from the commit message:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Signed-off-by: Sasha Levin &lt;sashal@kernel.org&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Do you want me to re-submit the entire series? Or just this patch?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Chris</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-proje=
ct.org&gt; on behalf of Nobuhiro Iwamatsu via lists.cip-project.org &lt;nob=
uhiro.iwamatsu.x90=3Dmail.toshiba@lists.cip-project.org&gt;<br>
<b>Sent:</b>&nbsp;Wednesday, April 22, 2026 5:42 PM<br>
<b>To:</b>&nbsp;Chris Brandt &lt;Chris.Brandt@renesas.com&gt;; cip-dev@list=
s.cip-project.org &lt;cip-dev@lists.cip-project.org&gt;; pavel@nabladev.com=
 &lt;pavel@nabladev.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [cip-dev] [PATCH 5.10.y-cip 06/10] clk: renesas: r=
zg2l: Fix intin variable size</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">Hi,<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Chris Brandt &lt;chris.brandt@renesas.com&gt;<br>
&gt; Sent: Thursday, April 16, 2026 3:18 AM<br>
&gt; To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =
=1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)<br>
&gt; &lt;nobuhiro.iwamatsu.x90@mail.toshiba&gt;; Pavel Machek &lt;pavel@nab=
ladev.com&gt;<br>
&gt; Subject: [PATCH 5.10.y-cip 06/10] clk: renesas: rzg2l: Fix intin varia=
ble size<br>
&gt;<br>
&gt; [ Upstream commit a00655d98cd885472c311f01dff3e668d1288d0a&nbsp;]<br>
&gt;<br>
&gt; INTIN is a 12-bit register value, so u8 is too small.<br>
&gt;<br>
&gt; Fixes: 1561380ee72f (&quot;clk: renesas: rzg2l: Add FOUTPOSTDIV clk su=
pport&quot;)<br>
&gt; Cc: stable@vger.kernel.org<br>
&gt; Reported-by: Hugo Villeneuve &lt;hugo@hugovil.com&gt;<br>
&gt; Closes: <a href=3D"https://lore.kernel.org/20251107113058.f334957151d1=
a8dd94dd740b@hugovil.com" id=3D"OWA5b39e24f-a592-d92f-3645-71b69f64a385" cl=
ass=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.ke=
rnel.org%2F20251107113058.f334957151d1a8dd94dd740b%40hugovil.com&amp;data=
=3D05%7C02%7CChris.Brandt%40renesas.com%7C5800573b6dfd43099f3b08dea0b81c1d%=
7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C639124909762951163%7CUnknown%7=
CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIk=
FOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&amp;sdata=3DAubj6SDPhuTOrs1Zp7w=
dfyFQUSYQxi0UeAiqCOUPAac%3D&amp;reserved=3D0</a><br>
&gt; Signed-off-by: Chris Brandt &lt;chris.brandt@renesas.com&gt;<br>
&gt; Reviewed-by: Geert Uytterhoeven &lt;geert+renesas@glider.be&gt;<br>
&gt; Link: <a href=3D"https://patch.msgid.link/20251114193711.3277912-1-chr=
is.brandt@renesas.com" id=3D"OWA57cd9a55-ac16-8042-27c2-8728c2c3b380" class=
=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch.m=
sgid.link%2F20251114193711.3277912-1-chris.brandt%40renesas.com&amp;data=3D=
05%7C02%7CChris.Brandt%40renesas.com%7C5800573b6dfd43099f3b08dea0b81c1d%7C5=
3d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C639124909762976580%7CUnknown%7CTW=
FpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOI=
joiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&amp;sdata=3DMwsosum%2FweloQSkzyLfC=
LpNo52mw7ZImb%2FcdbTlk430%3D&amp;reserved=3D0</a><br>
&gt; Signed-off-by: Geert Uytterhoeven &lt;geert+renesas@glider.be&gt;<br>
&gt; Signed-off-by: Sasha Levin &lt;sashal@kernel.org&gt;<br>
<br>
It looks like you're backporting patches from LTS.<br>
Could you please backport them from the upstream kernel?<br>
<br>
&gt; Signed-off-by: Chris Brandt &lt;chris.brandt@renesas.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/clk/renesas/rzg2l-cpg.c | 2 +-<br>
&gt;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg=
2l-cpg.c index 0c0d9d76c4d6..c45c22190fcd<br>
&gt; 100644<br>
&gt; --- a/drivers/clk/renesas/rzg2l-cpg.c<br>
&gt; +++ b/drivers/clk/renesas/rzg2l-cpg.c<br>
&gt; @@ -121,8 +121,8 @@ struct div_hw_data {<br>
&gt;<br>
&gt;&nbsp; struct rzg2l_pll5_param {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 pl5_fracin;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u16 pl5_intin;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 pl5_refdiv;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u8 pl5_intin;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 pl5_postdiv1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 pl5_postdiv2;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 pl5_spread;<br>
&gt; --<br>
&gt; 2.52.0<br>
<br>
Best regards,<br>
&nbsp; Nobuhiro<br>
<br>
</div>
</body>
</html>

--_000_OS3PR01MB8319CE5D43B757DE104545318A2A2OS3PR01MB8319jpnp_--

