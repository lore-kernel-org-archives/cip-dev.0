Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72173E784B3
	for <webhook@archiver.kernel.org>; Thu, 25 Dec 2025 01:37:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.132002.1766626652024029009
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Dec 2025 17:37:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=Lr4s62eS;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1766626638;x=1767836238;bh=wQNNt8qSPnASdT3OlP8LlN8Y75ZRMFjDFLeIP
	YY1VGQ=;b=Lr4s62eS7fIK6oUnDo83IQ1jkXzr0uMTutwSsa1toSiDUtp5GrA96KyDi1lH2S3ALpY
	Rs1AN1++zwyXvFR9AgRE7hsFjdGHmhsPkI6HQ2s9IJoLiMZjO2iGjnNmC9kr9nzZkbAyC+cfxZhaX
	UXuy94GeXjEVFx/4LPaJi6A5S0FBKAkfFFsRtUh24jj8MQndvF4Dp5tQaQt8geDXdxDFwio2Ie0mz
	hdCClqrINlnCxGT/aEWhLbG8wGg7twxmN90efKK7xMu4ByN9TqVctGJrcpg6btDhqBz6U4F6iQEF9
	9L0BnCzahCk0En9WLjlwlkWvzgYkk5EitbjUbYLbUebA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 5BP1bHxJ2574952; Thu, 25 Dec 2025 10:37:18 +0900
X-Iguazu-Qid: 2yAa7S8R4Fw41mcztE
X-Iguazu-QSIG: v=2; s=0; t=1766626637; q=2yAa7S8R4Fw41mcztE; m=xX8WUvgQE9rra3UcGgELKNTgI2yYvkJx8dW2rFS8e60=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dcBF9292dz1xnZ; Thu, 25 Dec 2025 10:37:17 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLxGYk+v0DMuF7uXLQepffiXqKYyVnL7vod3kpvcEXJWwX1O4OeDYjGThCZjDaSpzpEWoDqfNaLjh9o1zj8GCf7eticz2EtIuLJTiCjpMLvoAFiWISAx8Hn07CzsJ7+buURQpjVZu4UxburpCJSQAPQ1VtS7RDpxlQA1WdPJnsxivVi+qPK4zwX1XvkQL7erTVxgSbdsqRUq3Y/BFfl0Fl/ssIZlP/e+5c3f5hi0gYYm/gs/5wuGTq6d1xDZiYEaQs6hGADcMr6YDwkV/2rsO4CF6cXM1SuzPPoFGv0IAuQRgeZvk0bEd71CKjhKZvMH5IS6uq7Mo/R9hfAKX6SyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku79+7JVTBx6Gp8xPPEtoVR7TEFkRAQsDijH7aSqe20=;
 b=g9gBn5X9kFMVnoBt4npErKmTFpF6yBZNzQzEaTVwIPgVWQXzg8xFGoNdCsp9C1up5f7DqC8FTISlXnTWFsCWin2Gi6pr5c1H9NPzzzsiUDDxMqNP6pyUu7iJAtOd/MvcsDxApDWl+oMLsBH+ZFcVWH0AUQ1GR9dAC1ZuH8LC0jTtVq5D/EZATZQ2Yjir9NKMjvRsyasWFnykeexRhHoEyRdXQ7b3U950d4j7Gf5m94cxmqv7znET03yZPlaDf4C8442nRpwNGnS9p1riMGdQ+0bE3iwott70N+3jsKZN6KwgcD1+UMihbQw6yL2sNPQC1t5ouF5e6YamOLp82bQBxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <biju.das.au@gmail.com>, <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <biju.das.jz@bp.renesas.com>,
        <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip] net: stmmac: dwmac-renesas-gbeth: Add
 .init() callback
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip] net: stmmac: dwmac-renesas-gbeth:
 Add .init() callback
Thread-Index: AQHcbyL4DmJjqOqchEed88ckdIQ/A7Uxni9A
Date: Thu, 25 Dec 2025 01:37:15 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148186310F13C51C8FCF15658CDB3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251217070100.3680-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251217070100.3680-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYVPR01MB11213:EE_
x-ms-office365-filtering-correlation-id: 3e921370-1e5a-4e3f-47db-08de43562222
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZnBLcm9mVTdUVFNkM1g5Znc0Z1hzMUZPSERjdEJqSUxCTFlRTzQwQ1JC?=
 =?iso-2022-jp?B?ZjE2ZlFTVER6S0tYVzQ2aEYyTkhINHhNQ3BiQ29IUy9tRWJBSnhhRzN6?=
 =?iso-2022-jp?B?TUw1S0lTZDBCdi9WUFpYZHlWVkU5ZjZIZ21DVDlXQThyNUxKTnB4bXlT?=
 =?iso-2022-jp?B?czhvTFF5WmNDSEgvTnh5M2NUUnowQ0dJYjVIUXFqZGNPWllZRlhtVGIz?=
 =?iso-2022-jp?B?bUpROThLaWcwY3VlMlJ4b0hmbVAyYW5Lb1QwaFYxOEtFR2dCcGJxMWlN?=
 =?iso-2022-jp?B?a2FUbFJRNmRRdnFwZ0h1Zjk5NlNMVkhDMHNkYThzZ1NlVUpzQm1vbTA4?=
 =?iso-2022-jp?B?dHVlc0tQRUlBbXZEWkhzTHRWVVFVTDlQMEgzcjBYeE40Y1hMZEFoazlv?=
 =?iso-2022-jp?B?cGx1ci95RHZLNzJoM2xBZVBaY1ZzdWxiSTdQNHNTbys2Mm1wZEdWeERW?=
 =?iso-2022-jp?B?azlxTXN6cVV2ZkIyMlRNWTFBeE5yV3UyQXQ1WXVTamhEU20rbG12dnNo?=
 =?iso-2022-jp?B?MG1uWEdoWE1YRWZCSTZja1E0V3p1SS9zOVhLYmdKdm91eGhLdGxuR2ox?=
 =?iso-2022-jp?B?WnkydkVuZEFNQ3c1dFN6K3RLN3ZWelpUY3RGSUlQSjJhdGJtRGVGOFRp?=
 =?iso-2022-jp?B?Njh0Y0hsZU9BbUdLRThRc0FUYWVYb3ZpMFRHTnkwUmxESW8rOWIxSkVZ?=
 =?iso-2022-jp?B?d3duMU9UWUxEa2FzNko0d1k4Wi9YZVNUS2RYeDVOVUNUYS9PaWJGdFlP?=
 =?iso-2022-jp?B?OXl1elM0dUpKYUdxbGRITEx3ZjRqcEdwbWxlTTN0UG82aW1SK3Y3L1Rl?=
 =?iso-2022-jp?B?bjNXRFpMU2pFaE1KS0MwUWNJa1dDdU9CVVJTYmk3eVMrN2crWDFOWE8z?=
 =?iso-2022-jp?B?ajQ4aWJoNFVxRTBIY2IvOHE2QktrNTNhV1ZobkMyKzRkR1NKeUNjZ1hR?=
 =?iso-2022-jp?B?Mk4rZWE4dXRTZG1iUTI2M1dSajNHdjl0NU9kTG5hSHpBSUMxa0lIdGln?=
 =?iso-2022-jp?B?NFE1SUlnTzNOZmlib1UzVmVvZFFDWFVtTjZWV1FudDZCbjZxb09vYkNp?=
 =?iso-2022-jp?B?S3ZwV2g5SnB3cEgyTStIeHlIc3NlaHRTWnV5Nkp1Y0hPRENIS2ozR2pV?=
 =?iso-2022-jp?B?Z3VYeERhaGxmeWYxRmxGNG1iVFo2Rkc3WmNpVGozMGx4cmwwTk5qWjlQ?=
 =?iso-2022-jp?B?aS96S2pOT2p5aVZ6YW95b0V2d3RVVnRrYW9TTFdMNWs3UlRVRUJOa2o2?=
 =?iso-2022-jp?B?VlJ6cGV4QktLR3kwbmdFL0JyUGZaUmJtN2pKa0IyQjkvdlBiZU1pNzBL?=
 =?iso-2022-jp?B?NnZScXNjTHhBU2hYZ0RRT2xscytvV1NYR1RiVlpPMERoRmVUM1BiUlk5?=
 =?iso-2022-jp?B?cFpXVHprRFVpUlpNVDAwN09uVndZUEV3dzVEWGViQ0pBdktRajN5Nis3?=
 =?iso-2022-jp?B?Y2xJcXZiQVdPQ1prdEpob1ZwSXBBY3Q0TFh3SnUvOHAyOUIvRDFLeXJS?=
 =?iso-2022-jp?B?d1ptR09TZG5XdTdzTGlHdkxEM3ZHaFBZRUdhZ3RhbHpSV0l0QVVxWWE5?=
 =?iso-2022-jp?B?amhnTVFaR3RCN29abGlyMUFDNG9abXQwaUhodW90NEJGNWlJM2JYWlNU?=
 =?iso-2022-jp?B?REN2bFVFWnRhMmpCS2NHSXBzVExEZjZRSG4rWkJKQXIzNHNqNGs5cjVr?=
 =?iso-2022-jp?B?M3NzamxvZEVSV2RXUnl5MmtUK2l3K210K3RHaGc0M2ZLQm8wVVFMSUgx?=
 =?iso-2022-jp?B?cUJVcnk0UUhacmhOc0I5aTlHcVhaV0dDVTVuME50aURSajNncTBXZTMx?=
 =?iso-2022-jp?B?Qkc1ekU5VW13YmQreXNWT3NDSlJJRUNGRWtTQUZLMlBjWDVGN05PRDha?=
 =?iso-2022-jp?B?ay8rOHFBQkU3bzA4MkVyVFNmR3FFQngvRWtQaUk5emI4M1FKanErQ3ZG?=
 =?iso-2022-jp?B?YTNDQUM4V0pYWVNtdVBVOEYyWXNNeHBweUVVNm9wQjc0amJGMlU0RzF3?=
 =?iso-2022-jp?B?L2dRMVlKYjhPRXAyd0MvRXN2YzJOdHlQeTlTQ2NpTDM3SGhXYU1KTjE4?=
 =?iso-2022-jp?B?ZUlmUk1VS1NTaUpia1hUY0w1QnZGSDdQckY5NG1JM3c2aWo3QVltUHhr?=
 =?iso-2022-jp?B?b1JTTWNuU0t6cnYyU1lCZFlrT1FFUjhNQ3lQWUh3YXJJS3UvcUxsMHlo?=
 =?iso-2022-jp?B?cGs4bm1SZGRTbzZJTzV1a043MnJYVVVO?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Sy8xQnp4WVVoVnJQa1I0M0pMTmRpZjBVNjN2a0Erd3ErWEpWb1Fzd1RX?=
 =?iso-2022-jp?B?K3BURHZBdDdwM09zYW40d1IxTUM4YmxhMTRhY25JNTlVcE9zVHpXbmFs?=
 =?iso-2022-jp?B?RGQ3TXR6U0NWTTBGMUxVQXYrYUNhNW1KaDBsMU1acUh5aGJMS0hFeEtl?=
 =?iso-2022-jp?B?OTAxTmNMNVVkQ2FWUXZHbnR6VnZLMUU1RTMrU2FkMEErVHNMMGZLR0cx?=
 =?iso-2022-jp?B?SmJ1c3JkVkV5WWszUVpET3lQKzhKQ0xZdVRoS1dMdThVQTFabElvK1dh?=
 =?iso-2022-jp?B?Q2FHa0xVNllGZ1FpbUtkc0I3NGI2ZlQ5aEp5Q2ZyUXJ6NnJzZzlKa2d6?=
 =?iso-2022-jp?B?SEdFR2FCV2VRdDdWcks3elA1a2Z6NERxTXRteld5cHd6bnBQbGxGWUJZ?=
 =?iso-2022-jp?B?bjVOUHJuWXMrejJpL24rNjlyblBYN01UeWVteUhmYnltZE9pSnRjQ3A0?=
 =?iso-2022-jp?B?R1gwdCswZGpGbFZGV242ZmMzZk92cUxQRzFzTFd2YW1UclFreTlUdFh3?=
 =?iso-2022-jp?B?N1hjKzNiQ0x2YkFTdHpqV2U4d1MyY1Bjc3YxQXJYNnJHSk9QdHVQaytx?=
 =?iso-2022-jp?B?UWlJNXNxSytNZUREazlXSHlwcmJLV2JON2tRdS9ONXpyTTBEY0JoOGFK?=
 =?iso-2022-jp?B?QmhPMGxIU3VSaTFzd3QzaVlMcFE5anFQMXAzRjh3Q0xOV3R1UGp3UWZ2?=
 =?iso-2022-jp?B?dTVDMlJBdkw4YUJqVFI0cGxmbUlkSGwraHh3K01CRG5hTG5HVTlTOWVs?=
 =?iso-2022-jp?B?VkV0MEkyWW5jSnFwWWhFZlR6VVZsOUxRNWpLQXJPL2Fxa3ZIN2ZuNU12?=
 =?iso-2022-jp?B?MVJSbE4yRVlETTBzVksweENNeE1ka3pPeGxrbXBxcmZnUnNsZ1RCQm94?=
 =?iso-2022-jp?B?K1M5MGJRRCtVY1F1bnpKeFRnME1uTkJiWWV3Zy9oSWc3MXVvNm5hakVY?=
 =?iso-2022-jp?B?aFFCOHQxcEtTeE9BM3RCQ3Y5dzRna1pySndOOTBYOXJSTVd0dnh2SDFW?=
 =?iso-2022-jp?B?Q0JwdVN1R2Y3NGNhMDIrd2Ruc0tpdzh0N242YnFXOXd0QkVzS25zcGxk?=
 =?iso-2022-jp?B?dzdVN2c3c0t5ZXdpbjd2WDZFcG0wbTdHWU8weTZ6TDVJZlJjcVA3QmRl?=
 =?iso-2022-jp?B?ODhwaGY5N2xaL3MvREhUVTI5RFE5aVlFaXJhaHFXdVJxbjZHZEtrMXJP?=
 =?iso-2022-jp?B?ZEVnamVVd0U2ODF2RzRRYTJBYWZUTUluM2d2MFl6aU9DbHZ3S1ZpVzBF?=
 =?iso-2022-jp?B?MW95Z1U3UG4raHZ5cXAyc0RtQzZhaEJHV2hsV0tGVjliOEt4ZmR1eWd5?=
 =?iso-2022-jp?B?dXhPYjRHV1ZJNzV5cHFrQTlwc2JpSlZ2bGRYeFQ2TnVGanYraVltRWJn?=
 =?iso-2022-jp?B?cmdKR0ZLTW9hdld6a1gwMDBJNE93RzRuNzE0TjNzWmpaU2dHV1M2UEk4?=
 =?iso-2022-jp?B?YW0xa2RZMmFaeFJsTEw4a2ovVVNrZG9GSlhJWHZxbFhHV3BIK1lhNVIz?=
 =?iso-2022-jp?B?M3FwV2Q0aVE5emsrSmt1dEhkQUtnZUtFeHJuQlJaNjhxY1A3c0NvTEl6?=
 =?iso-2022-jp?B?T09YbFpkZ0VVaTB5TFRSb3FQWi9FenVYSlNUdHBCNDJUcG5BbFYwNERX?=
 =?iso-2022-jp?B?K1cvbkg5eU5PUHVGeVJzOVFURFRQa3pURE1PL1MydktpZHFEK2NwN0lr?=
 =?iso-2022-jp?B?OWMzZHRMTTVwMEFmZVdCTXhLVXp1RkV6RmRZK2F2M1h3WW5pZ1BTemZZ?=
 =?iso-2022-jp?B?WHhRczI3MDdKbGNtSDRYVVBsOXAzbDNhRnQxOWRkbUZ3T1p1Y2V3dkZO?=
 =?iso-2022-jp?B?RkxiaGMrWktjOGZqZEdYT2lRK1dFYUNsRFgzdG5WOWtNMTVmemkzQzNU?=
 =?iso-2022-jp?B?dnFsZ1V0ZUhQNGhXQkFybDNVSWRBRDAwSjQ1cjhjVW10VEk3L04xelRZ?=
 =?iso-2022-jp?B?Vlh4d0pobUpwZjdjcEVvaExWUmZ0b3RIa0l4REhvU29aMjl4anNJN21M?=
 =?iso-2022-jp?B?RmUySE1aTFRJOElwK0RsMSszMUxKUkdVQkZ1OFdKOE9TYnc3VjFJci82?=
 =?iso-2022-jp?B?eFFvS0RISjZnMS9JR3BEclVReXVZUkJBSGU3UDZnN1FyQ3cxNWRJZkdk?=
 =?iso-2022-jp?B?Y2hZNTFjRUYwMnVUbmJTb3NpcmIwcTkreHMvZTkzUHhzMUdiVjJvZXVS?=
 =?iso-2022-jp?B?TGRpMkJTUXNXMzlHcHdGTTAvOUhoZTIrSE8yZG9NUkNxY1lwVklGQjhz?=
 =?iso-2022-jp?B?VTdUWEhWNHBGa3V2ZG1Ja205aExNYlYyZDNmYmYzaW0rYTN4V1UrK0Rx?=
 =?iso-2022-jp?B?a04vazIydDB0NlY3UWZFV2E4TjlDcEhvbFZEUWZ4YUpTcEpHSmtVdlRC?=
 =?iso-2022-jp?B?UENaMmkzQnpGYnBhb0N6L2lzNCtSSjkzUzBxQVNVZ3ptSnVQM2doa1dK?=
 =?iso-2022-jp?B?M3ZUdmVOYlJtRmZDSGRIVjFEWCs1YkhzbGExR1phZ0RLNDNOckM2YTQv?=
 =?iso-2022-jp?B?MFk5MmR5UHNobTdMK0I2SnE2RXpkNE93Y0x5bEFxRGtzZnpqNVgrNFh0?=
 =?iso-2022-jp?B?cE1ZblM0VT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e921370-1e5a-4e3f-47db-08de43562222
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2025 01:37:15.2079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NntetEDacMBitb5xF7/V57bjV8hiiYx8NJ3/w5FCspV/m/+IZIk8GV5tOlMgwND6TM/7YDrxU4VfhwcjOdD/aXdjh8lDL7H3io9mgGXy19d8jnGdN86cIgw/rajCt1DE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11213
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Dec 2025 01:37:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21216

Hi Biju,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half
> Of Biju Das via lists.cip-project.org
> Sent: Wednesday, December 17, 2025 4:01 PM
> To: Pavel Machek <pavel@denx.de>
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; cip-dev@lists.cip-project.org
> Subject: [cip-dev] [PATCH 6.1.y-cip] net: stmmac: dwmac-renesas-gbeth:
> Add .init() callback
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Currently clock usage counter imbalance occurs as .exit() is called durin=
g
> suspend() and there is no corresponding .init() during resume().
>=20
> Add .init() callback to support balanced calls across suspend/resume cycl=
e.
> While at it, avoid code duplication by reusing renesas_gbeth_init() in
> renesas_gbeth_probe().
>=20
> Fixes: 709bdc1cafe2 ("net: stmmac: Add DWMAC glue layer for Renesas
> GBETH")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../stmicro/stmmac/dwmac-renesas-gbeth.c      | 37
> ++++++++++++++-----
>  1 file changed, 27 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> index 42cba9dd967c..5c591c7215bb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> @@ -31,6 +31,28 @@ static const char *const renesas_gbeth_clks[] =3D {
>  	"tx", "tx-180", "rx", "rx-180",
>  };
>=20
> +static int renesas_gbeth_init(struct platform_device *pdev, void *priv)
> +{
> +	struct plat_stmmacenet_data *plat_dat;
> +	struct renesas_gbeth *gbeth =3D priv;
> +	int ret;
> +
> +	plat_dat =3D gbeth->plat_dat;
> +
> +	ret =3D reset_control_deassert(gbeth->rstc);
> +	if (ret) {
> +		dev_err(gbeth->dev, "Reset deassert failed\n");
> +		return ret;
> +	}
> +
> +	ret =3D clk_bulk_prepare_enable(plat_dat->num_clks,
> +				      plat_dat->clks);
> +	if (ret)
> +		reset_control_assert(gbeth->rstc);
> +
> +	return ret;
> +}
> +
>  static void renesas_gbeth_exit(struct platform_device *pdev, void *priv)=
  {
>  	struct plat_stmmacenet_data *plat_dat; @@ -91,22 +113,17 @@ static
> int renesas_gbeth_probe(struct platform_device *pdev)
>  	if (IS_ERR(gbeth->rstc))
>  		return PTR_ERR(gbeth->rstc);
>=20
> -	err =3D reset_control_deassert(gbeth->rstc);
> -	if (err)
> -		return dev_err_probe(dev, err, "Reset deassert failed\n");
> -
> -	err =3D clk_bulk_prepare_enable(plat_dat->num_clks, plat_dat->clks);
> -	if (err) {
> -		reset_control_assert(gbeth->rstc);
> -		return dev_err_probe(dev, err, "Failed to enable clocks\n");
> -	}
> -
>  	gbeth->dev =3D dev;
>  	gbeth->plat_dat =3D plat_dat;
>  	plat_dat->bsp_priv =3D gbeth;
>  	plat_dat->set_clk_tx_rate =3D stmmac_set_clk_tx_rate;
> +	plat_dat->init =3D renesas_gbeth_init;
>  	plat_dat->exit =3D renesas_gbeth_exit;
>=20
> +	err =3D renesas_gbeth_init(pdev, gbeth);
> +	if (err)
> +		return err;
> +
>  	err =3D stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
>  	if (err)
>  		renesas_gbeth_exit(pdev, gbeth);
> --
> 2.43.0

Looks good to me.
I can apply this if testing is no issue and there are no other comments.
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/223210855=
6

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


