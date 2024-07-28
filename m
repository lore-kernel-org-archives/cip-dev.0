Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F38C3DA64
	for <webhook@archiver.kernel.org>; Sun, 28 Jul 2024 23:59:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.45667.1722211146071051767
 for <cip-dev@lists.cip-project.org>;
 Sun, 28 Jul 2024 16:59:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=R3onQSNV;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1722211144;x=1723420744;bh=sasiMmZ9N49G2v2mwyKiWejSHx435LRCG9ZR+6P
	pWVE=;b=R3onQSNVEGBrL0e2xMT1MrtVypTWDQ6sx6EVRk0gqhWLOQb3VhxAW4KTuUHMFVho7AWV4
	qmsDwf1so8R2yGv5DTbX3IwT64FjbRs1ki0LOgPJA5AFdkqLytVcyC7PsidE+HWAOj+S4kSoRVLwQ
	MOFaHoNRTlrUBFFHNXf8bRWhZsisQU/Ih0vWUnezrC1+NoqCwWs62wDKHwm4pDfROLw9xPrpGbGlU
	j4E21cFRrw8db1DTf9vhdfJAG3HlC1tw64RLm5GQI/eRSH4DJHLvqgt4PesPFyuBFBoVN341h0o+a
	8hmIgaev+O7+XPqNEyzlIVbePmq9FZVY2C6c3b3iqw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 46SNx3lv2140043; Mon, 29 Jul 2024 08:59:04 +0900
X-Iguazu-Qid: 2yAbzzeqWG8SL68vm3
X-Iguazu-QSIG: v=2; s=0; t=1722211143; q=2yAbzzeqWG8SL68vm3; m=ge7toE8YmBa7qPFmzRw8skF+Qzouy8JovMqvWyFy9gA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 46SNx2cS4040769
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 08:59:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAOi80qZjYdUSGNJM40t3SmqhROTsyyik1GRplLB9/032XW2eCSToVFCja/oUbCyQHh9rjmfCL2mJO5sjn1KMCTwg0cGOgUFtt83hQsmayKjd5vu7hhTm/y/09c3hvX+J31hly2bv790ux8M2T+o/pRDstWvvx3T2AOHsD+/MjIuEYK7n+JWznkODDm1pPQ+sc1ou1uPwHajTSmPMRl3etZV8ocXBB+AEQb2IFgNeoauChaj0g0uiPxTI/MoUHv98+DFvj3pyKGAG1DUXEvzGYycqX+9UKD206b67bC0iv2RC7M8rUxKncyLr4E510ZgpQMSMFCGGTmPxSvMDgr4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHXggNCToVj4R3hlD/xcSUM/Jlj3J2Dj/WqgMiExvV0=;
 b=kQT5s0UczexbfDgp4IuJ4eCQNZKuX1w7/GR1WFpEu9Zzmh9Kr8yOoV0Dt/7YDNi/LYDR/YrAeJ4j+zcol4DMuijZAVmv1RuNg4bXaV+RdnnZT+H9ECEho2XvlNXH/I5o5IzUI0vi5qzfY3paLCEdmMlG76DG5FdOP0TxQNTWy2ToO/9J+gDxrPVpBROsRszm9xE+d+cpnK0mHNXQN0fn+xTVTaskWxT0T/MkrLUisuIebvSlEDoNxWf+xuS7857WjiDTtLU/FFoljCgduitqqQ5/KAlwAKWxT7ROJZbGFujFXTZzfPndS8BpcvgjMlTT3jKMzeuYVkoJSTOmsVFK0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <chris.paterson2@renesas.com>
Subject: RE: [cip-dev] Adding tests for 6.10.x
Thread-Topic: [cip-dev] Adding tests for 6.10.x
Thread-Index: AQHa34ki20YYfA61XE2ish6knJfGibIM1AKA
Date: Sun, 28 Jul 2024 23:58:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388F7B33E56D44B35FA2B6792B62@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <ZqPp4nE4f1jOnJJI@duo.ucw.cz>
In-Reply-To: <ZqPp4nE4f1jOnJJI@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYWPR01MB9628:EE_
x-ms-office365-filtering-correlation-id: 7e65b4b4-8c86-46a6-dca4-08dcaf613fe7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZnN1OXVEa2FNV09hUXRLUC9LWUxPcm9kNFRiY0xOcHlUSFRFRm1oeGcx?=
 =?iso-2022-jp?B?ZGNybHZ4aGFQRzg2U0ZuUm9QSm9YMllPTjhKU1dVUmp6dU8xazg1M2dw?=
 =?iso-2022-jp?B?dlN5MElvV0hCdDZYK3BNYWlKQjh5eXBhNUVYbUQwZGJ1SVhlblJKZEdS?=
 =?iso-2022-jp?B?ZDZvSyt3NVF2RzdTcVhSVEU3ODRiQ1crdTRaWU9MT1ZGMEtUaEtmSzBz?=
 =?iso-2022-jp?B?cGRTMVZ6dmFSK1V6Nko4Q21YVVI2bWVjY3BJTnVZNEZwWGw0MTZwdFJQ?=
 =?iso-2022-jp?B?NmJiWmcrcS9oeFcwdUxEcUNQNjlaQ2xzT3hFVkR6U05hajVabFpaM1Nh?=
 =?iso-2022-jp?B?Q0wrSi96aUFnZmZpbHFKeEo2TDBsTWVYVVpidFlXckRPNWdYc0RPcE15?=
 =?iso-2022-jp?B?ZGYvcktNcWpvT0Y4MUx3dzhaWnc0UDJSMkU0cTdBV1hiZ2NObGc0WkVs?=
 =?iso-2022-jp?B?ZHdvTm9oZlljOFBtN1Z4dlc5MW96M21kVFlwT2FLbFRXaFVVbUN2bmcx?=
 =?iso-2022-jp?B?Q1RpbFl0cjNCbFJndzk3STFnTkFmRnpHQzVMQ2FJZ0tBM1Jrc2pQTWNZ?=
 =?iso-2022-jp?B?a1pPMVVxK1Rnc2F1V2dET1Y2elV2UnVNalJWRFNTUWhrMjlkTnk2eDdT?=
 =?iso-2022-jp?B?bTdUTFVlSXAvZGgvaHJRRlFjbUV1c1pQZ1lUc1BmK2pmaE9NK3dIYUlh?=
 =?iso-2022-jp?B?QTllMktUWFAzTDNJNm4yUEZPOW40YjhMQlVNZTdXOG5kSm0zVlpJSTZT?=
 =?iso-2022-jp?B?enRrME01bXZ0SEtzckR4V2ZSRG02eWtGcVd2VWJxV0owU0lDeTVUTnVC?=
 =?iso-2022-jp?B?bzc2blU1TDd3WkhwdllSL1pUbmZqblZTdTZpbkNlcUEvTU5odTU3WndV?=
 =?iso-2022-jp?B?SFF2dDBXMnJ1dHFhUlRBUGdPcVV0eFFLeTBjdEtCRWgxQWlDS1ZTUWRs?=
 =?iso-2022-jp?B?MHRZYVZTUTBEbmE0bU16UXRMbjIvUjhUNEJCVmVFS0xhWmtYczlJK1NM?=
 =?iso-2022-jp?B?V0ZMQjFTalRCUVk5djl4bXBsQVhGNDh1VG44ZksvSmh4QnJkVmg3OCsr?=
 =?iso-2022-jp?B?ZlJEWFNwb3dMNFRIU2szcURPQlU1MW9jVXdTMm40NXArc0hTSml2YlFI?=
 =?iso-2022-jp?B?OFprdWpLeG96MkhZKyt1S1pKSjc2ek9jR1RUaVA5OEZyaDhWRzZSZ1J3?=
 =?iso-2022-jp?B?cG9PcFVRTW1VTVlWbmFNSEx5ZjZPZDZEdnBkd2psRXdWMkE1eGV1N1lC?=
 =?iso-2022-jp?B?b3ZyNFViTUNKRWdKYnNvYlZESHV2RytLbXlWdGxMNDNqTmxZZGZtL2do?=
 =?iso-2022-jp?B?WlBKSHhwRnB0VnlBakt3N3pZaGxGaktyYnlldjFFQkliZjRkZERyR0Zi?=
 =?iso-2022-jp?B?NG5JdkFteWQwS2dKSTArdzBBLzFJTXB0MEx4VyszcjdxQjZnQlhIdlJW?=
 =?iso-2022-jp?B?L3VvT2lBbncrRXB4VDlsVUxMRzlVMmlGVENGd3VMcjh3ajRIMFJ1Wkp3?=
 =?iso-2022-jp?B?WW14OERlWHJFeUg1R2dURzFJcWtUNmRkQ0ZubU8vckt0ZmRqeTVIQXJs?=
 =?iso-2022-jp?B?S1ZMVHk4bG9SQ05sem8xSUEwSzFpMFRaMEw4QStxRkJwNG1WL1RnSjZF?=
 =?iso-2022-jp?B?dnpsRWs3RHZlT1dzUTRpdGg5ZFA5TTh1dC8yMGU1dUVpVmVuYkgwK2x0?=
 =?iso-2022-jp?B?Y1lmTVQvWUlycmk4ZU1qQVY2ZmdweUVaVDk1Um9QakZOaUpOWjdnZlQ0?=
 =?iso-2022-jp?B?by8rY1JrMlY3UStINDNaYUZoWXZqRDhEYnFmVUNPd0NiWmRCOG9mUmYw?=
 =?iso-2022-jp?B?SzB1YzM3QmpsNDBncCtyaW9QbHUyOVkyK1ZESVhNR3JJVkp1M2dRZ2RU?=
 =?iso-2022-jp?B?STM3eVRtdGtHMnA5aG9oejhoRkZnb2RGbHNweXZTZ3lndnJnTTB4QnBl?=
 =?iso-2022-jp?B?cUduUXU0UW0zL2ZyY0dNUkdtSjNoMDR4YXc4VGhGR3k4allUWXBMOFVL?=
 =?iso-2022-jp?B?bzJtNzRYam5PR21xWHR3MUpUMEpRZDZLWURVSXFEdGYxaXkvcFZQbWU5?=
 =?iso-2022-jp?B?cURCa3c0LzV0L1RKWUhpbUdEK3I4aUE9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YTJEOExkY0tXM3BEcE5qUXRCeE1INUdKQWVrczlwTnJqd0FZT1JhR3dw?=
 =?iso-2022-jp?B?WGg3YVpmTGpWSkN2NXh5Vmlvdk4zbmxLZDFqWXJVVW8xSE9UeENKbjQ0?=
 =?iso-2022-jp?B?RktUeWt0SkxuQmwxMTFvUitXamc1SndOZmJjZU9UNGd6Ynd6YWhrK1p3?=
 =?iso-2022-jp?B?SEJESGlzMm40YUl3SXkvZHZ1VHc1Ti9vN3FkNlhoYkplRFFOcHF0Rlpt?=
 =?iso-2022-jp?B?WGllZ3ZIM0VKK3pIenVTZ01aSlVLWUptQkM1WmJ3SFE2RXFlc3JyRm1k?=
 =?iso-2022-jp?B?bTYwRURXSk1FazR1SzNTeUtkT2F5T2lKM2oxb3U3UlFUWUpJdGdZNmN0?=
 =?iso-2022-jp?B?Ty95SlRES09kMDRkVEs0by9jelFhZGpqVStSa3VZbE80SWxwVkM2cllT?=
 =?iso-2022-jp?B?YkpzUjRsdlMxOHJENHBQdWpFdTlKdms5RFZkNWxWTm96MEZ4NlVqdmJJ?=
 =?iso-2022-jp?B?SUwvbDcwWlVXNXRlWjBWSkNuZWl5OE54WWEwbnRRYWNCemRkSjlEa3hr?=
 =?iso-2022-jp?B?c09ZaXpsREJDQXlNTmZ2SlVTR0JhcU5Nb1FlODNaaEhXcnRxTE5HTkEx?=
 =?iso-2022-jp?B?YVdPN1RKVVpXWE85Rll0NFd3QWdONmJBTXROSytTaUNqc09tcEJOcFFl?=
 =?iso-2022-jp?B?NkYzK2JVYWpRODFTY1hqc2k2RGRlWklxNysrYlRDUE01TVBLZVRla1Jp?=
 =?iso-2022-jp?B?Z2toL0lQWk9oRmFzbzBST1N4RWh6K1NSUzlYeFZXNWtodHpmUTM2WHlT?=
 =?iso-2022-jp?B?czlQVS9EbkFud2NFRDdrY24wR01tSFRtSVhnV0YrdWVRS3pJOVQ1UjJp?=
 =?iso-2022-jp?B?ZkhqMTlyNEE4UGx5c1ZQWFppR2VWUENROG0vaTRDVHFVMy9WNTlrU09E?=
 =?iso-2022-jp?B?amM3Y0kyMWpHNjczWnBlRE5rUUdGVFR2eUJQNVE0Mnh1blc5VnduK0t6?=
 =?iso-2022-jp?B?b1ZVUDNIMjNVT01mUXFaUU1RQU9yay95QmNTVmd2Q3NvREdIbnN4MnFN?=
 =?iso-2022-jp?B?Q0tWTGQwcDI5UXd5Mnp5RTd4UWlvajg0RjBZZHZrNFR2MlpSTXNaaUhp?=
 =?iso-2022-jp?B?NEFUdmJtNjU4bDlZYUNvcDhyL05oZGd4aU9VN3hPbTFLL0NZSkFLSFRE?=
 =?iso-2022-jp?B?OUNaL0xHbFBHb0dIRUpJdTBCSGYrK2xCVVBaZkExenNaSHhGNDRoeSti?=
 =?iso-2022-jp?B?MkFvc2x5Uk5ZckpqeUZVL1FuMjFOUG9wQUpJRDFzTy9rMXkxZ1NyOXJE?=
 =?iso-2022-jp?B?SFlEeHNUNm12dFU5dUpaMFdRQ2VkclhWN1A4N0MxaXpDMkk5emtVUXVr?=
 =?iso-2022-jp?B?VkpOMmVzQzRUcDFwdW5sMVJCRzN3Si93aUwvdEVsN0Q0emFCdTEvbXNO?=
 =?iso-2022-jp?B?ZWxtN3YvVnV3OWp5aVhrYUdCbmp3U01naThmZ1hDcFdDc3U4N0hUUXlj?=
 =?iso-2022-jp?B?bHNnczhIOFpmQkJ3bDRtSEVsUDBDN1JpRzFQZERiS1pzdEI0N01Wdk1M?=
 =?iso-2022-jp?B?bUcxWCtkZUswUUgyMjROK2JNbUNKUjY1MWVJVDRCZDFvTC9hTkpDVnpM?=
 =?iso-2022-jp?B?aG1SWjRpaEFET2VGdloyOW9QaFFRZExabUVYM0hISE5WbjRoSndRQ1hx?=
 =?iso-2022-jp?B?T1ZYQ2xzRnlZUmFpdnJiS1U2VzF5clZaNmw4b3Z4dnlkbkM3ZS9HY3M1?=
 =?iso-2022-jp?B?bFZabHBRRGVnaTJnalM2VkttY2lOaCtHRWVaeWVRM3F3eW9rd2dmdW8v?=
 =?iso-2022-jp?B?cUVjYmJOQXVKVHhqME90VlJ2Q1VZRFpOUUxQcEV1MnhvNUtpeUJ5ZVNM?=
 =?iso-2022-jp?B?dVhvL01hRzlKUDh4d2d6MkpPaUxRNmNPaVoyY2FodVFOeGVOR0RaVjc0?=
 =?iso-2022-jp?B?SVk0bWw1c2YzZWtBaVJsdG40ZERMSnlwb0dyaGxrbCtkRjByYmRvODlu?=
 =?iso-2022-jp?B?MXN2VGE1VlF3OXVEM044QytkRmZsNmRxK0I4VzB6akh4MWhlcXBMM0pF?=
 =?iso-2022-jp?B?SEsvUHQ2QnZXVWY4WVdNNkcwOXdtdzB1SXVLQXNJVDRXNXBvcTZkOG16?=
 =?iso-2022-jp?B?SDVySmtGY2dLeG9WRXdVemdZb3ZEWDlMTnI3NkZQbm1XZW9KdWZKb0Vv?=
 =?iso-2022-jp?B?OEdYY2w3eFlFR3p0MCtINGZBaTVqNXcvS2wrYm1KMUEzYWRNWkhUU29R?=
 =?iso-2022-jp?B?bFhCM1YwNjhZd3BKaE1TcU9DbVB1RURwbDR2TTMwRzRJcndzUzhMMTVT?=
 =?iso-2022-jp?B?NlZYMm5HUzZKM1c0Ym9IdXpnVXJSajU0aWJxUVdlTWlicFZwQUVjdjZU?=
 =?iso-2022-jp?B?TXduVFR1VWZLRng1V1dQNGhRWGNmdHVFM3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e65b4b4-8c86-46a6-dca4-08dcaf613fe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2024 23:58:59.8281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: giQ+FdeqKaGJNgSN/roxe1RPHQz127JOa1s6I6Y9PdNgVA8K4T0oo77NkoJLayigq2+qb/47N6GAjTMr+kmncBS5249gZ8vK5Hko+9Vs1C+X54v27IbBIZeDwN/GKAVv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9628
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 28 Jul 2024 23:59:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16630

Hi Pavel,

I sent MR for tests for 6.10.y tree.
  https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/merge_re=
quests/59

Best regards,
  Nobuhiro

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek
> Sent: Saturday, July 27, 2024 3:25 AM
> To: chris.paterson2@renesas.com; cip-dev@lists.cip-project.org
> Subject: [cip-dev] Adding tests for 6.10.x
>=20
> Hi!
>=20
> Could we start testing 6.10.x kernels? I guess 6.9.x configs could be use=
d as
> templates...
>=20
> Best regards,
>=20
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


