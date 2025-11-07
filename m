Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1B2CCF9F8
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 12:19:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9885.1762517938378182088
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Nov 2025 04:18:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=Ul5zkcZX;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1762517932;x=1763727532;bh=mXEG20gjWlLjKEhx4KlGgM2q73l7spzAAYIEg
	q1vJ3Y=;b=Ul5zkcZXQJ86UoszxBQSRG84/k/+kvJEZrfOYH3+kWITFX1BXIsXzsxc1fGmjngKvnX
	hd9M7+uizuPMiILLrhiHDWj1uR12eFeRNx7FiONnSjVS1M/dKpqAjkyWbMIFT6BOrBiIdK2EMfAuL
	RE8WiRAnFMZ3QNPQJ07WAycwtiD03MZNHJeHBYAQPE7dpCBQiqjyeiFRCpCPzo1bKD0ebsucTpNZ7
	KNCi6Mt5At3xQc92Ka+5vgpCOxFQVGBr/7VP1qO9a+E/QTxQvQfANBeQLdfTUcc07VcDOm1JnTcJx
	p9kXU6qOTmCfJuJ3Pwef0+5ycpFEJp8/n1rVtOK0XFAA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 5A7CIqKi2948383; Fri, 7 Nov 2025 21:18:52 +0900
X-Iguazu-Qid: 2rWgiXlvbLD9pZuOzA
X-Iguazu-QSIG: v=2; s=0; t=1762517932; q=2rWgiXlvbLD9pZuOzA; m=g7Uqs5q6yQq4slwgwACmZ68tkR0n5sLiOIm+aiYIzUg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4d2ylb6m00z1xnZ; Fri,  7 Nov 2025 21:18:51 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0NenZ8butg7qYEVxcFYxnSuAhSpRnCX5+r1q/ONC97IBJFC6RoJzebqrbgpO8yHW5SAKt9U8L6yFmY/ltJUjs4Uvga9V39bQpIrOAN0H/fFqBikGjSDrku4JTZNbEJdng6h/CTi8EuiMbBnNuzFeXdLkFrbv6QurEYAb/uA8hefU/PRJI9BxsM1m/HN0tVKKr6WYpJdMuQ3LTF3D1BAL1HBmk5pqkr1TJIOkva1TMpyc967dn9JEz3i9xBe2h0P6vpDn9Ag0at5P3gcdOVpN9KJADr4F1vC4b6CnrjFHcdPG62I8ViwmPMbAHr7bmh9Be215tJDrWL1W2soEmx0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oa215765c0YQUw3chQZ7rnHwhz/2xuEqGVxOf8mRgfQ=;
 b=F8WssBztTY0n6H5ffr+lTNFeNh92OD7oeAWVbcJrCZ5pzTYle12Cp8SJoBMapYZT0rwoNUX5Zkkf+Mtli0IJfgyKrC4zFoaRALDy77sXUo0yoB2uiQzxYd1r7EvjkapjJZqoWx/rudAlbeoE7kp933TZA1JBCOHLV/CBeGCJr/MNYLniGkQlZ/qswoc402nF6gajAPU8+TA7c+qCWAOIXOOppj2nNn/oyaFc7lVzYalaMrTZk3wPKUgzhXiCOcelBWUURSPCXUeyH4K0LQOEXmeastPRTNuMt3sdvykvQT1MTqMmulDgXLQgLmu/x7sqZ9w/XxZD+hEkX53BVY7rzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: RE: [PATCH 6.1.y-cip 0/9] Add RZ/V2H GBETH support
Thread-Topic: [PATCH 6.1.y-cip 0/9] Add RZ/V2H GBETH support
Thread-Index: AQHcTwloEMTQZXJatkKW8c2ENKpHWbTnIyEw
Date: Fri, 7 Nov 2025 12:18:49 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148187CA80E39D402B7A18BAECDC3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251106103738.28911-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251106103738.28911-1-ovidiu.panait.rb@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB7331:EE_
x-ms-office365-filtering-correlation-id: fe060bfe-2dd5-494e-9ef5-08de1df7ceee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?TjI0THZ2dzlPQjJTcGJwaVZXYlM2UzlIVTBZYjJDNEdZWlFsZncyaGM4?=
 =?iso-2022-jp?B?ZXdrY01pT00xWU0rNll4M2k5a0MvaVRzeWYvN2t5amxHbXVCU21hbjd0?=
 =?iso-2022-jp?B?VGVaRFp0cS9ZVzd1RUFvQzU4Q3l4SVRpVFZPRnp1T2pFeHZCTWQzV0dL?=
 =?iso-2022-jp?B?Y1ZaVVAzSEFyamlxMmQvL1N4a3BrYWwwcVcvU0hMbExzQUVTaW5HR3Nv?=
 =?iso-2022-jp?B?Y1FmTDZFblJjSDBUY3R1OHI1amdFVU1qVTVzdjZNZUlrd3hBRXdkK3NL?=
 =?iso-2022-jp?B?L1JZenBzNHI1cXVxaEtjUkpvN2RmeGVVV01hbjh2QnBJQ0U4U043aE0v?=
 =?iso-2022-jp?B?NHRQR2tsVU91ZDltRlV0NVRmS2NGVlpmVGluWVkwMHE4K2k1bGRTVHp0?=
 =?iso-2022-jp?B?TEErU29JZVBUSmVsWStjdXFDQjFIME9OMlRxRjAwU0FEUlh1aTJ5U0hH?=
 =?iso-2022-jp?B?NWVXUFNMby9QTDUyeW9qdWpKcksydGV6Q0lZMWNJVXBaUE1JL3FNdFEw?=
 =?iso-2022-jp?B?ZGZYbG9kRkJOVVZFamdlSSt5QWRUS01SYnZPWXN1SC9sNnhmQTZtc3Z5?=
 =?iso-2022-jp?B?NVVEZnNpMlUrdWliOUxFdkpuY3hLVFNtYlFuaGhuZ0plMmgxYUI2Qmt0?=
 =?iso-2022-jp?B?cU55bHhnSnZMNCtqVk5mcFo0cUM3VlZoZjZoWDF5UmIzT2JIajhuSWND?=
 =?iso-2022-jp?B?by8vNFY4SG03SDUydkVia2w3K0x1MWhaZDFmUWRIcnQ3ZzYzcGx0K2xS?=
 =?iso-2022-jp?B?V2xWa2dMYUgzemZad3Z3U3ZYMm9XN0xQNUYzVGNobDBTL2pnYjRrRmxj?=
 =?iso-2022-jp?B?VnZmSDFqNFcyNm91QytQU3hoR0ZlZVNyR2VhRVpMZWdpN2txMHRvREtC?=
 =?iso-2022-jp?B?QzYxSEk3ZDRTYTAvSldxbkJjYXAxQ1ZHV3FJNUJLeW03QnZaTW00RWQ1?=
 =?iso-2022-jp?B?RGdiMGxlYUFUenVwQlhEekE1eFpCY0d6OC82cWVvZFIvZUJPbDZvaHZT?=
 =?iso-2022-jp?B?bnYwK3Q1Mlc1Q0tCNDlJV2JXa29Mc0R3Vm42UHhLQlBKcDVkeG5pRGlu?=
 =?iso-2022-jp?B?bGNyclFoWDA5UWJiOVpzYzFJT3hPZjVlbjQ2aEFqaTA5Qys3dUdhY2VG?=
 =?iso-2022-jp?B?bDhZYXFoZm9BbnNIUXo2YkJyWUllQ0gxcU9YaXhwNWp4MVNxMXJoTitY?=
 =?iso-2022-jp?B?djY1MWlld1NQaTlzeUJFcHdUTGhGL29JU3ROSkZ0dkhjRGZ5bGVuRE5x?=
 =?iso-2022-jp?B?ZWpDZmNodTc3WFRjSTlGaGJET0hHaUxjTE1TdkZEakxGR2tWb1c3cG9n?=
 =?iso-2022-jp?B?WjBkQ0hwVnFJYTZaKzFRcDIwQUhpZUVLWGdISWlucXZDWFRiSVREendR?=
 =?iso-2022-jp?B?UUhISzJIZitTcm9EMzNGY2dRQ0xlWlNmWkorR1IxS0VqeXhDRnl2Wmox?=
 =?iso-2022-jp?B?anN2UEtlZFh4dGU3WXZPaXBQL3B6Y2NJcDF6WHdpa2I0cTZmdEttVlRL?=
 =?iso-2022-jp?B?Zkl3Ris5SHVPbWlNZU9MVGVyaVZ1MlVPRTJsY3V4bFM3NGljZG56QTVY?=
 =?iso-2022-jp?B?K0poVm1IU1Z6dm1iYVR0MHhtNWI4Q01jOGI5ZVJxT2lIVmx0MXB2dE4w?=
 =?iso-2022-jp?B?dE52NXQ1eVU4eUg0MWJ6dys5cHQxYzVjaE45NDNud2NnQ3I5d3gzOVRu?=
 =?iso-2022-jp?B?UUpQbGJXOE1ZWjFOVE9lcVlKbnkwQ1gxZmZTMEFHcUg2c3dEZ2lacHI2?=
 =?iso-2022-jp?B?anhFMlQrWjRIY0R6NTJNT1RnK3Y5UXlGMWNFS294RDcyd01XaGt4S3Fl?=
 =?iso-2022-jp?B?NHExb2VESGl6YjlFWXRseVRLaTRSMnhOa1RSMDUrcnFpc1VqUU82R1BO?=
 =?iso-2022-jp?B?SnhqRmJUemE1WHZrU3JpUWhEcUZQS000bktlZkZEQWV6U0tNZzFRamE4?=
 =?iso-2022-jp?B?UFl0L0VHTzdaWW1qTkI2c1pHQXBJSTNWclIySFpFMFRRS241NGh1cUs4?=
 =?iso-2022-jp?B?a3BNUmszWG0yQStzRVFiYTVha1lQb21nNHdRTFphcDVjZHVPOE91SXVn?=
 =?iso-2022-jp?B?SFdhc3p3NkpMczNUcWJoUGdad2pBODNhcWdyMjNLT0FEeUpoSGw0MzNr?=
 =?iso-2022-jp?B?bGk0c0xjZHFBRHNoOVd6V3FaWDdVdUNrRWpmN2JBQmRHTnk4dWtVRFBY?=
 =?iso-2022-jp?B?aE02RENCVXVSdEVJaVJhS0Rka1BmdHBL?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Q09aOSt4YXM2cVBuei9jbWNueVhyYmVTTnlXRjNqWHh3RGRyRXZkaXBK?=
 =?iso-2022-jp?B?SWRsUENETHVDWUU3bkpUang5NzhiZ2FRUnJMNzdqQUJSaWlyMzJtaTNu?=
 =?iso-2022-jp?B?YXAzRmdNNVgyWTFWZVRBaTdMTXlRMWJBMlZVVk13ZUo1YTVKR1kyL0Mr?=
 =?iso-2022-jp?B?bVJXSjQ0NGNOQXZ6ajZyOTVzY3ZpSDZKYWdnSjMvVmZJRnZ4ei9BYXVS?=
 =?iso-2022-jp?B?ZU5tY1NJNytoWjg0cTh0U3FpM3Z5d25zUFBoeHlhZTIwRUpJVjVQQlA1?=
 =?iso-2022-jp?B?b2dZenEvODlaWTJFa1ZMejZ2NVhuRmtYODdLRlNGWEQwMSttUlBwZzQ3?=
 =?iso-2022-jp?B?SnRzOXJWenUwZURQdHdRUUpGMUdNTzRRaGUwWHRrUlgxbXpkOWJDeWNE?=
 =?iso-2022-jp?B?K2dESUNvZlV5MHBnUU43ZFh0WEdMRGlhb0pmMVdkSXB3c1hQakpBYUxi?=
 =?iso-2022-jp?B?dG9BVENnT2NFUzg5aTZhS0EyS1dRSDE0K2t1UWk2cDQ1a2FYS2p3WGJK?=
 =?iso-2022-jp?B?QTJHcUdRcTNJRFZlY0lreENjd0lnbGdBSVlkazRnVE5LL09VakxpSGxN?=
 =?iso-2022-jp?B?UHY4akcrbUVQRVA1dEFEdklGRTBhOURUeWJUM0MvQkEwK2hld0Q4T1BY?=
 =?iso-2022-jp?B?Z1A3OVliKzl6akZqZHVKOXgyZWhEVnNLL0V3OHpvSDdMM3RYaWUwcXI2?=
 =?iso-2022-jp?B?OGZiUCtCL2N1eTdkSjlaekw5VTRPVnVaYjJHMzhNRUp5N2J2V21Od3RD?=
 =?iso-2022-jp?B?ZVdlNzE4OTJIUXBjZFdCQVZRcllVZUNOWk0zMkhQWWdVZW11b2l6UU9Y?=
 =?iso-2022-jp?B?eUZLcFZIbWVqbXBuNHREb3BIK0U1RElLd0x6UkFERzBXbzAyTHI2ZjZR?=
 =?iso-2022-jp?B?bU1JTVdhVUkzR21WbG5KWktrMlRYMzFGMzJIbFNqVWJJbFNTOUxBb0JP?=
 =?iso-2022-jp?B?bnNjZEVYZ2dLTHNHTGpseXZ0VElBRE9hQkRZbk90WUptUmQrcHhBcUl5?=
 =?iso-2022-jp?B?YWtmNXZtbmF1OVk3VWU3bUJhdFA2U0YzVC8yWkVzR2FUOWU5U3k1bGtW?=
 =?iso-2022-jp?B?dFEyNXlZL1l0U3NnQmw0Ry9pTVVsdlZSUnlTeFkwVTRSaENWNmxxOGlL?=
 =?iso-2022-jp?B?c0tUK1orT0VRcHE5T2NSbXZZMzFVQWZqTG9RL201dGRmbjZPSG14SGs1?=
 =?iso-2022-jp?B?SVhUVW1tZGZ4YjNtWE84OUR6SWtBV1FzTnM5cXJyeWUxZzhZMzEzVTE2?=
 =?iso-2022-jp?B?MzFpODJ4M1FNNjlsT2ZuYVV4ckFiZVZYci82T3FsbHUxRldWK0JCK1ZU?=
 =?iso-2022-jp?B?bG5Ya0Z1bE9Ham53TGM3TTU1bEdOd1QyZ3JDZ2NrSDVsZVBhWGE1eEhx?=
 =?iso-2022-jp?B?YXZRRjB6RnhTNlJCL1lEZ2VRNG8xekpSUUdoSXlGdjdrb0VlT0tDRVU5?=
 =?iso-2022-jp?B?VkdPdTV4UmlhMWs4dlVPS1JtVitzaXpldlAxaVF2c3Y0NnNOVHExNldR?=
 =?iso-2022-jp?B?MHhZOEFSNnZkYlMxNnFKRzVGV3EwQ0Z5YWVaa2llbXVzeFB3MWlsN3F0?=
 =?iso-2022-jp?B?NEFpUXZrUDdqYmg2NkJQWVdxMHhoS1FxaG9XbTJVTm1PVlJYcnRUMVp4?=
 =?iso-2022-jp?B?V3dqb3puTUxwWW5vQzhmeHJISVQwWnJzOTBiTFJycWc0LzVjOHQ0Rjlm?=
 =?iso-2022-jp?B?SjBsYVRJKzBvSzlEZXkvZW1Pa0oraEFRZkMxOUQ4ckMyK0xpTzNkOXRO?=
 =?iso-2022-jp?B?dWh0S0UwL1BLWnZNbmUzRkhPeE0wOUZtRUFEai9tS0plM1hkcFVjZi9S?=
 =?iso-2022-jp?B?NHl3djFHcDNhRGh5bXBsWnROSS95bGZRTE9aY3RJZncyeUoxZ1MzOXFS?=
 =?iso-2022-jp?B?SEt3ZHczbFZwU1h2a1U1b1A5MnQxejBXRC9NTkw5UlVJeDVKajBQaHcv?=
 =?iso-2022-jp?B?TGJXZFBIdllrYTZ5TWxsQUtrd0JjQ0tvREdxdk0yNFprWWN0ZEFNYWFJ?=
 =?iso-2022-jp?B?SEFQWnFPTkFhUHdDNVpGOHE4ZzBpUVhRTkltZnVBVytNVEpESldXOWk4?=
 =?iso-2022-jp?B?eVR2ZVU0Z29FaG8xcFdsaStiOWFCdDA4N1paRS8yU2s4T2VuS3oyZ3Mx?=
 =?iso-2022-jp?B?aHc2Vngrb1ZJcGZsNklScnRrYTFWdTArVEtUYUpSamUxVFBzczZQbVA2?=
 =?iso-2022-jp?B?ZU5OakgrMHY3TCt4UWZDZVExT2MxSHJzZGdJZmlUZ1N1NU0vYnEvRTho?=
 =?iso-2022-jp?B?c3k0WGs2U2Z5VTVJS1FhYXdOcnA2eCtvQ1pBT3RITFJzYlNFRkdROTMz?=
 =?iso-2022-jp?B?cXZzTVd3Y1hjWmk1MVpqVGNZSG1WSGF0YXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe060bfe-2dd5-494e-9ef5-08de1df7ceee
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 12:18:49.8790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rg9yw5gB43JKdjG6LJyh13wRUnyrcjWkpSrhvzx9rJijlB69o8GxovEyUd9Yvn5SpjI8zI9nsRPJPzFycCYcArHPX6Mo2Dx5n64cRyelaf14soGQ9jYg9AaQ+IfTA21s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7331
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Nov 2025 12:19:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20471

Hi all,

> -----Original Message-----
> From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Sent: Thursday, November 6, 2025 7:37 PM
> To: cip-dev@lists.cip-project.org; pavel@denx.de; iwamatsu nobuhiro(=1B$B=
4d>>=1B(B =1B$B?.=1B(B
> =1B$BMN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.to=
shiba>
> Subject: [PATCH 6.1.y-cip 0/9] Add RZ/V2H GBETH support
>=20
> Hi,
>=20
> This patch series adds GBETH support for the Renesas RZ/V2H SoC, to the
> linux-6.1.y-cip kernel.
>=20
> Patches were cherry-picked from mainline kernel.
>=20
> Note: this series depends on the following RZ/G3E series:
> https://lore.kernel.org/cip-dev/20251103113608.36240-1-john.madieu.xa@bp
> .renesas.com/
>=20
> Best regards,
> Ovidiu
>=20
> Biju Das (1):
>   arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Replace RZG2L macros
>=20
> Lad Prabhakar (8):
>   dt-bindings: clock: renesas,r9a09g057-cpg: Add USB2 PHY and GBETH PTP
>     core clocks
>   clk: renesas: r9a09g057: Add clock and reset entries for USB2
>   clk: renesas: r9a09g057: Add clock and reset entries for GBETH0/1
>   dt-bindings: net: Define interrupt constraints for DWMAC vendor
>     bindings
>   dt-bindings: net: dwmac: Increase 'maxItems' for 'interrupts' and
>     'interrupt-names'
>   arm64: dts: renesas: r9a09g057: Add GBETH nodes
>   arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable GBETH
>   arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Fix pinctrl node name for
>     GBETH1
>=20
>  .../bindings/net/amlogic,meson-dwmac.yaml     |   6 +
>  .../bindings/net/intel,dwmac-plat.yaml        |   6 +
>  .../bindings/net/mediatek-dwmac.yaml          |   6 +
>  .../bindings/net/nxp,dwmac-imx.yaml           |   8 +
>  .../bindings/net/rockchip-dwmac.yaml          |  10 +
>  .../devicetree/bindings/net/snps,dwmac.yaml   |  22 +-
>  .../devicetree/bindings/net/stm32-dwmac.yaml  |  10 +
>  .../bindings/net/toshiba,visconti-dwmac.yaml  |   6 +
>  arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 209
> ++++++++++++++++++
>  .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    | 102 +++++++--
>  drivers/clk/renesas/r9a09g057-cpg.c           |  84 ++++++-
>  .../dt-bindings/clock/renesas,r9a09g057-cpg.h |   4 +
>  12 files changed, 447 insertions(+), 26 deletions(-)
>=20
I reviewed this series, looks good to me.
I can apply this series if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


