Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F628FA1FFC
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 21:45:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.93718.1776894321126695656
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Apr 2026 14:45:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=faYO+GEY;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1776894318;x=1778103918;bh=TXvMBAopAVgrFDD7Fwjd8KHcmyfc/le/SGAT3
	NnMu98=;b=faYO+GEYCA3qfLMV1pHfc9o50Uj8hC+IRPBcUtwddnFxgBA8JQ8EIXJ1HsKKUcVzvuF
	Zkw6tiBXvfp5gbCy8aFPSr9ja9H945PF33kQEGiHBpTyWF8nxhZQl6YKvj+XpRoP06f3VYMfHNmE2
	4LTTTwPL0VjPnZD+JoTwWHZLkEw46u6y5HRVls7WF9uB10DpPt1pks3LCP8wrqSousOwm7uIFXHr4
	qimTGoLmWRssFRh34eha9wvrLsEBJRqEh3Rvj2lv/Mg42jm+hleQr84UvJlFXr6K0o9lUM9xi3i9U
	+BpE9lFFQ+VltxizyWjoA/WNj3iyPJs2053BP++2hKsw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 63MLjHMd2593600; Thu, 23 Apr 2026 06:45:18 +0900
X-Iguazu-Qid: 2rWhfSiM7ehQ0Ug21g
X-Iguazu-QSIG: v=2; s=0; t=1776894317; q=2rWhfSiM7ehQ0Ug21g; m=zxVLu/b8q0MGcIW8QkBJd3MwVkCl6eiMx1Nn0+01P2o=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4g1CSY01jBz1xnZ; Thu, 23 Apr 2026 06:45:16 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nu7/7GTOwCE+YeJ3WXk3C/Asls5jCMWXjkjKleV/6IuZ738YMSq+d5EqwYn3jkN1761Mh+F/qUDMpg41ELCoWLclSXNeRaf0+wwCJwXTWYt9+3933Tb5FDFSfiCwVvXWqeqXepFNvI06yXhHdkLoGtMilejazadB0B0D59KsVMUFGO524Xy+mUAQuqwsg7w1V1947Vg99pvNZuOsP0V9T6GVzXp61N4vqqh1gFvvLDbZEiVq5ewVC/nTXHCAU6iTEdhlLNMmK0nnfdtIFyugLMcxbMuCCH+0KajgvQpVhWhDcq22qTqJz0/Vm1YyBEPr7Rh30fcPAyEimqXhVsocrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCRI384bEl+Rq+Cb9P9MqR87c5xuX9ea0QHnci7ZhGU=;
 b=ttZVNaZFMQMWCsKOcAtFqR82SGzB2ZpA+HXHqVvtl5r6rtfCUjez5LDGTKS2IYluHRvp18QazKPsTdTNqqg5GVGH0vSaJDhBlEv0QwTvUh47M7n5SfwDbVARGIOpoAJpHvRP6cBlLeK+xudZHk1OSpnTujIR5EgYA3ADKckJkU8bNpW+tjveJmcljv2wZbGedUuobvi7IZJWVus5sCvmOVDViHXDGv6Dd2D9QwnOIJ64/Kv6m7qhi9cuvgQ2x8UgzVGsF2Eys3WW1DkvjphHgtigBiPOW8CO3K/hss0RQ6qjI2mGpmeaW9D1y93zbSF5wUGQzoo3hX/ZitIeSThgDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <chris.brandt@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
Subject: RE: [PATCH 5.10.y-cip 08/10] clk: renesas: rzg2l: Select correct div
 round macro
Thread-Topic: [PATCH 5.10.y-cip 08/10] clk: renesas: rzg2l: Select correct div
 round macro
Thread-Index: AQHczQRFHz9zrOM3bkyXAJLtNEYRuLXrqGcQ
Date: Wed, 22 Apr 2026 21:45:14 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818CD89850F844BC750F8D9CD2D2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260415181810.4073807-1-chris.brandt@renesas.com>
 <20260415181810.4073807-9-chris.brandt@renesas.com>
In-Reply-To: <20260415181810.4073807-9-chris.brandt@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB9535:EE_
x-ms-office365-filtering-correlation-id: cf6433f1-fb58-4719-a204-08dea0b86ff5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info: 
 pucnqXs7u30qoaTX7ESAdYgNmB/gpbSTJvXlhqJkgrxtVhqsQpeEYJw5/h5Wpo4XgNkFy+PzzvYGZXbWDWTulgW9jYgS4wLryaDV7q/PuvPvlcKIah7I8jlFb/CEKYA2FhjtxflymjfdXCkBn/STJrZvlB5Z00ruasK8yh6w1FmKbpmaTcGWcCx/AclG+/ADuE32FLYjbMsmCiL3Hen4dUVWOWyrSxvBMmMtjq1CtxTspucfXQy1xtp39yAkuXOoTQFS0N1x28J3LlK54HLb6+NU0PIRbEImM/J0WqPS9ITIq9EqStFX2hmHZ/ypC54C5Kgxtc9IGgMtckTcwcLUrTqPhJICsl+/3JbNV+LGBqfyCeiJ/MzaySlV+9NZs1zaFf3ekeN5hQi9948cEbZBRQAKJBS1PXS3e9BDMix3z4A9IyV0NtM8GI/Q+z6S7q4Exm9CEN3XtcYliMwExiWfekCKalVrXD1fhRwgtIuaT6HvVHAE8ckbpss88UjlSsE7QCaQwkrLOXX6fGqq3fj6Z0Pfkdz7oNkBVOkqwj0SMYOeVORxFy/cw4Tl6eLVqN7TA4Qcc4f0g03bJn5htuXhA2niDO2BXWx2KWy/ioldmtOlooEY/iPjd2HYL2ISCDaR9XeLCxdPKOH2MHh0v+M07wQI9TabLfm7U/7VlaVNvRBr1dFFtwY3YdNQqPtEnvTAwWk3Ef5pnlwNwUU1wsKUPdUSxnrZsAb51cSAEyz2aCmlut9+wVXvwVjU2oOzFS5L
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(38070700021)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?S3RLVi9NZXFwOGlxcjZrc01MS00wRTlMc2s1K3FmNDNQSGJab3pCQmly?=
 =?iso-2022-jp?B?Q29ycEpyNnF6cW5XTUZOUUxFcWlCajNPN2ZqUGg1dW9QUjFreTAzcmhI?=
 =?iso-2022-jp?B?amZFNW5KOFFlYlk4aGFidGtJSUhiUTg0Rjc1WjJVbEJrYStpY0RERWVL?=
 =?iso-2022-jp?B?amgyY1pBeUt6WE1VK1FhbE5pQVA2ZlpCOTV0OGlBeHk1d2dkTlg5eHli?=
 =?iso-2022-jp?B?WmJXa2crZU5ZZnFPeWY3V3V6Q1VsNTZ4MncxNldiZjNsaGJMd0tYR2dQ?=
 =?iso-2022-jp?B?NGV4NUpzVUlsa2tlRHJkUFJDalUyeWZmUit4TkVFdTUwM1BFakZZL2RG?=
 =?iso-2022-jp?B?cS9RTktqTWpCYTlId3VNM3A1SERwTUdYblhzSG9qck1XMnBzYnoreTFk?=
 =?iso-2022-jp?B?Y0xIQnprWXkya2RZc25uZGVDZXNSbFJvb29IMlJscjJMSmdaeHVDMWo3?=
 =?iso-2022-jp?B?NWt0bmcvM0YzaDVCTmg3b3BWZzJoVEdQWWxheWRmaGlaS2xCTDI2T2I1?=
 =?iso-2022-jp?B?em1xZHR1aHp3dmlNeGdIaE02dDF6QTZRbGsvV1pGeWd4UHlFNEdjT2hv?=
 =?iso-2022-jp?B?RlphY0tWQWNsckFoWVpyejRIUHhsY3BXUWREUjNwSVhyRVd2djZnMkp1?=
 =?iso-2022-jp?B?RnFQMEZ1dk1Tamlzdk9mOFpvbi9BNkdnRGtVTW9YUG11NzA0QklRYmxo?=
 =?iso-2022-jp?B?Y1lMWUl5YVJqaEovOWptWUZFVEVmQXdteVhuMVJSZHZRTjdCTngrOTVY?=
 =?iso-2022-jp?B?WVUwVVg5dlNwY3NFWWQ4akliNG9aL3JpZlVPS0Eyd213NWxFcVJ5TWdZ?=
 =?iso-2022-jp?B?Z2VObVhQRlc0YndLbGlpdE94RHNYVXB3aEl1NDNDYnc0WmZJMGIreVN1?=
 =?iso-2022-jp?B?OUJSekpTcHNqVXdKU2JJbC9yWmYyN1YwVlJ0NmRndmFJazJrbDljYjJC?=
 =?iso-2022-jp?B?d2R3NUpqRlM0TXV4Skd1N2J6cjJTN2Rab2dMbUZJS1loOTEyNWpaZGRv?=
 =?iso-2022-jp?B?MWRnSWR5VWsxQXVFSlNYMnF1cDFnRDRCTVY2MkFSa2VML2FhalExWEw3?=
 =?iso-2022-jp?B?cjl3VElSYmZ4ZHVjVkNIWml3dk5QeEZXWWI5dWhnOHBiTGZUQ0ZmeTNz?=
 =?iso-2022-jp?B?TFgwV2IzNTluUUZKYWVBTTdobHFSa1QrZ3loZHRHVERqNjR1endGK0N0?=
 =?iso-2022-jp?B?VTBJN2RES1VFVUdoN256QWdCaTNOcW0zM0IyV2tCQ2hJTU9wT0N6ck0r?=
 =?iso-2022-jp?B?d2V4aEtscDNhYWVodEZkZ0lsNVVrbWNvbnhSTVNUWmZGVTh3cDNkWGpw?=
 =?iso-2022-jp?B?ejhCWkVqR21oSHJQa0ZKRkJhWWd6Z3dpL0Rnekd2M05tSVI0UWVBRmFP?=
 =?iso-2022-jp?B?VUR1MUoyZG1sakI3cjQzRzIvM2s0MzdjWFVYMjNKVCtoelhoOEtWc2F5?=
 =?iso-2022-jp?B?Q2Z2VlNPLzZiZmRxOGR0S3VQSXJzMkNNSTYyUzFlUlZ3L3RaejVJZURL?=
 =?iso-2022-jp?B?V0E1c1BkbzVOZm5ZRFN6NWhZNUJsNTNBNjRxZklhR3ppZnlDSHRCSWs0?=
 =?iso-2022-jp?B?aElZUmxkbjZmUmJJTno0QW54WG5nVGxEUVJZbjFyU3htSlRuYVF3ZUlS?=
 =?iso-2022-jp?B?Wi8vQ0szWlhwVDZuMHdIVU9KbnRGUnV6Q0tYTVFEY1BTM0IxUW1YejQv?=
 =?iso-2022-jp?B?ZEZYNzhoM01EbFhwSHR2bU5nSGVJRjZPQkM3KzFVSmRMZy9NOFFmbEth?=
 =?iso-2022-jp?B?a1J3dHNuMldXZm9udzlTWGpUZkdNTjFHazFKZFpyNFZwZjZMNXZremNF?=
 =?iso-2022-jp?B?S0tBY3grT2FsMnRHN1g5ZEFHcVNkYTRROWlrREplV0NnNjNmRkRMWTFv?=
 =?iso-2022-jp?B?bmtTSnEyRTk0cEJGMmoxUEhick53ZW9EYmJmODVJMHYxT3dYTUtxb3pL?=
 =?iso-2022-jp?B?MXkzNVZrRloyOUJBOWVJZ05ydmVzL2pkTGVaL2VhNHUrZmdGaGJIekNZ?=
 =?iso-2022-jp?B?SGd4WnFvWGppWGI1TkluOEVHdUpnRVRVRm1hL203SVdjOWwyQ1c5eTBH?=
 =?iso-2022-jp?B?aTBPTGgxaG05cWREK3RFemd2SnRrTUtUV3ZwV3FyNUNwM1RRMTBDNis0?=
 =?iso-2022-jp?B?dzJ2Y202Qkk3NmJXeE1BWmd0eGtXeG9OWXNqQlBlQWpWRVIwQWhVUlIy?=
 =?iso-2022-jp?B?a2pwVVV0TEdCckRCNCtPcElaVlFZUGNnUmxRQ3dOY0ZJd3hPS2pGaUVH?=
 =?iso-2022-jp?B?S0MvYW9weEYxanRhZzJwMWNTTzdaY3BrSGdoWHNOWmVCcmdVdlkxU0xQ?=
 =?iso-2022-jp?B?MTQ0LzJMeFAxem5nRkFjSysxQ1c5bkE1YWNNQThFMlJIZUNrQ1Q2d3cz?=
 =?iso-2022-jp?B?OC93aHZvaEZyZWxUYkRSQW9MNlI0dkRqM1dLZ252Zk45NUxtUE5wbHhT?=
 =?iso-2022-jp?B?eGdvekNRS09Ra0pkNDV6V29HVERiWkUzWmRaaHN4bkNGbGhaa0l0d1Fu?=
 =?iso-2022-jp?B?b2c0WEREcXpZbW52ejNmK0lqbDZWaVoyT0QxakhkMEdqSzUzeEtMMGt2?=
 =?iso-2022-jp?B?cjdseXhWVT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Uu+aJVZEck+RwMejbpmpqblEr2Zn6+ZWy/+uBVwscyhDNOMbs0MvY6vlQvp52T0kqeyt0JKP1cehlJk8pEdlq/U2AsrmKc7p5qSWG/5jLFIybadCH0NkqURYMuT4ghO4J4QFofMxx0L7t36gzAMtpRG3NjaHWsIH8AA35CVZe+BG5Dt9PzNMUwjVfLqoWu9D1e4evNxWMNBK/Lf9CZ3rhqHFQ9yrCqtM34BpWrvH74ZWWCPbX8jTx938CCwh+rJqC3gstXO14TxdT8AkYR96kh2vlRDeSKVg19fqjcJ6i70u5WrBDsYJ2xuyq4AFzyX+Y54FjAEDQljP6HUrxSFqwg==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6433f1-fb58-4719-a204-08dea0b86ff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 21:45:14.5550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3vBeOQ1CsEa3fi6ZTYNjerFqgfEtgvbBWKnBOe2zvTzbJGsdKkiVrTyn8kUqigCLb6993ldiraTMHiFhxIBPA2WhFqLU2thqS9Cnr2B0EM1eacy+HA03IRct8kMUznT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9535
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Apr 2026 21:45:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22786

Hi,

> -----Original Message-----
> From: Chris Brandt <chris.brandt@renesas.com>
> Sent: Thursday, April 16, 2026 3:18 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>
> Subject: [PATCH 5.10.y-cip 08/10] clk: renesas: rzg2l: Select correct div=
 round macro
>=20
> [ Upstream commit f9451374dcfdfe669ee55b58ee6c11e8638980e4 ]
>=20
> Variable foutvco_rate is an unsigned long, not an unsigned long long.
>=20
> Cc: stable@kernel.org
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Closes: https://lore.kernel.org/CAMuHMdVf7dSeqAhtyxDCFuCheQRzwS-8996Rr2Nt=
ui21uiBgdA@mail.gmail.com
> Fixes: dabf72b85f29 ("clk: renesas: rzg2l: Fix FOUTPOSTDIV clk")
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://patch.msgid.link/20251114194529.3304361-1-chris.brandt@rene=
sas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

It looks like you're backporting patches from LTS.
Could you please backport them from the upstream kernel?

> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Best regards,
  Nobuhiro



