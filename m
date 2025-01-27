Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601A5C0218F
	for <webhook@archiver.kernel.org>; Mon, 27 Jan 2025 09:36:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.48251.1737970579261648451
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jan 2025 01:36:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=eFwMw1+H;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=kazuhiro3.hayashi@toshiba.co.jp;s=
	key2.smx;t=1737970577;x=1739180177;bh=184gj8T/tpEc0XzdUH5BvbY71KvPpwQ/osrfIQR
	uF/A=;b=eFwMw1+HY6jKsjQvadZQyQBscOdMMupeWqotvKjYNI3A318YOGPPqwYk7v0JD8UAun6dY
	8ZPui92ZQeJatSrctKOMOKg/dKouuK7EzChQ5FVj5JKiQcgjkhLH/2ZF/HFP8Gx11L8d/hNTvtNn8
	gV9C1z/B+cR9n08K5IXbbdisqXlCsqfWwbFiS97f7Q4lVRx2KEWKZbX4QOC32a+gZ2mRsET6bNdL7
	Jv1Miilezb7Q9s1HuGxqgLv40iJ2z6AHY0mYi4auR0mfQ7Q/xcetTw9TU0qS9xWF9faZQeT+i9svM
	qSXussCP2GkHqoPbW7uojLcwMrKtG44r58v0BYo/FQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 50R9aF7p2637396; Mon, 27 Jan 2025 18:36:17 +0900
X-Iguazu-Qid: 2yAbuzQy0Mq6Ux7kjg
X-Iguazu-QSIG: v=2; s=0; t=1737970575; q=2yAbuzQy0Mq6Ux7kjg; m=5002bsD7Sap3xPJjOp5lvwaTIOF/+fE9SV8X0mlMk5k=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 50R9aEEY461304
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 18:36:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AR/+KKJQH2B6m1PmdwDHhxqL7UKyHmehlftqcqXgnWBd2lK3fPiK7jfBf6wALjdqfgM2hhqM59OMAW9Luqi5kHvZflYk3SzFe+fLVZkA2+nHIfRFCUINEgms5UxYO1MO2O8qlYyfdo1gC19Kfj8jxiVcMpnH4pqtF0opIcwC3fzjS1b0p+4J3g0YT5LowTndKodxy5rPHGqa3aShdufiJdshfgMQBx/rbCKLi6i81RI4cY677n+7obH6A5vSObOIV4AGyq6/AR+/4B+SHJcD0L8UF49yP5Gj7R0CPmLYFjUcPahzJ01f0reTYZOOc56juK35wSVlKdI3eeduKoo5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=184gj8T/tpEc0XzdUH5BvbY71KvPpwQ/osrfIQRuF/A=;
 b=v4+zRlXLYY4wE798FlH/FJvBUW6guPQKxk+ZaVnAsP2sYLovO8B1Pjp9B1Q3nHDlzV0J0ixCzrOv5rQOtn8xCPkCtzzqXsYSpEI/tS/mWspfrp40hiLZHokPRPLT4dgXJWDvbBHU6YO+t1omPWktMoAYejommRhuN4EMUfVKhDkUOYhYz6TQO+u40qmQwc7j0posNDWKano9MeoDefvveOFtsxn91fHI5I4ugg9CGxTknu5fN9P2XkRCJuooEejBJhrU/9/UDI5uOj0RCKJHUkvvwhlKMP+J5Vm5nhr73iPPMVQztuJkqXtMKgFlZ6yomWt5kY28OZvwbzTTtpEVmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <christian.storm@siemens.com>, <dinesh.kumar@toshiba-tsip.com>,
        <yoshitake.kobayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core][RFC][PATCH] Add security policy
Thread-Topic: [isar-cip-core][RFC][PATCH] Add security policy
Thread-Index: AQHbZ3phdI55t/h0q0CEFyoW2Nhu1LMatHMAgA+xdzA=
Date: Mon, 27 Jan 2025 09:36:12 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB11385BE704222D624609D5185E1EC2@TYCPR01MB11385.jpnprd01.prod.outlook.com>
References: <1086822b-1cd7-4424-a1d3-5ae0ce8371ad@siemens.com>
 <2cdda104-b4da-40ee-bc5a-f837967807e6@siemens.com>
In-Reply-To: <2cdda104-b4da-40ee-bc5a-f837967807e6@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|TYCPR01MB8341:EE_
x-ms-office365-filtering-correlation-id: 41346175-07ac-45a4-c9cf-08dd3eb60986
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Vmsyc0VKRW9WZ0N2VDhJeStTZTliK21GL0plSWxla1pMMkpLR2xja3ZXWURs?=
 =?utf-8?B?cWM3MXNBZmxxNVpQTkFONWxWb1lqZlV6ZWhOdFpLcFk3QkJzS2hHWERrcTlY?=
 =?utf-8?B?K2ZkeVkrZ1hwU3JyeU8wcEtjTnB3clpXWE54Njg5OEgrelhVWlQwRjFiajFK?=
 =?utf-8?B?b21Sd0h5LzBwYmdRUWRzclltK3prMVovQ3VNMjhJVnVaWmFncUZsNUhQa2c4?=
 =?utf-8?B?UU1MZWd2RTJTeSsxelcwWmpTYjZadWhzNXc0UUt0U216MFdLTUxnWjZQZWFz?=
 =?utf-8?B?a08vWDNtdm9mYndkb3o5YTdPbDdkOGRIVSsvTlpTbGVQM2Z4ZllaN2grUXZs?=
 =?utf-8?B?UGMvVkZhQ2R0L2dxYlJHSkRWRFlKVE8vYm9NZUlLVzdLeEgvQVY1ZXlmSkJD?=
 =?utf-8?B?OUtyTDJxOWgxbW9pKzlHRkhKYXR4RE1aaENhdWFSVTZKQ25UOURlRTB4ZUVF?=
 =?utf-8?B?SW8zVzhoNEVLOHhDd3NhQ2pnTENZdGF0OS9LU3U4YVVCSEtveTRrcGpBQWlW?=
 =?utf-8?B?YndmTUMzMWNJWFo4aHJrOVpTeUJpY0tBZVYzSTgzU0EzbHNHUE1wb1VwRkhs?=
 =?utf-8?B?ajg5LzRUTk53eTlUaXdGd1BpRm1ZSXNwVjg0ZTl5Y290OGlXL20ycGVHMnBa?=
 =?utf-8?B?bHkvdGRuOVloMmRRbGZnOVdNa3ByM1FyMGFMeGxCRTRGNUsrbjNiSDcxeWVE?=
 =?utf-8?B?NjRXUDd5UFBmbks5ZktFK1I1ZmZkQmhtWjBtMWh0ZlpqTzluRU5IYW9iZkJr?=
 =?utf-8?B?d0RSU3pjZWRYK01RaHVPZG5iSWowQ2poT2NCRDhiR0xyekgwdVFBcEhDMCtU?=
 =?utf-8?B?dXRKeW1tTE5xdGh4MzRCcHBkREtHeEJMVk9mWC82K3E3T2s5SUJnRXk3alZo?=
 =?utf-8?B?M0t2MmhqUFcwVTc1YjhHYkJxRlZrbVg0TDg4QlRheXZwSnZ3d3ByU3N4Nmcw?=
 =?utf-8?B?WEtDZkhad29hOENFR3lOZi9qL252bUQ5UWNXaDlTbjE0Q0lTZmRpYytETjkx?=
 =?utf-8?B?VnhRc1NxT29VUTFiRGhNMFg3b3MvWjFlK0NlSHFjU0pVSDIzRGV1Yms2ZHpB?=
 =?utf-8?B?MjlneVdTMExMc25qdVdRVDRzS2NZSWJ1RXMzeHBKMTEyTUJsWlJYQnJHUUc2?=
 =?utf-8?B?bWFzcEF4U2YrclQ2em1pSlNqQWhtNHlvOUxKaEdDWU1FVENVSWpmdENVSmtn?=
 =?utf-8?B?VlIwS1BvdURMMm13N0V4SXI4bU9rV0hocTdYeVloOTVNTFVkWGFnMzR6Mk5B?=
 =?utf-8?B?amNCaGxIdUpHRGxXZEkvZTVBOXpTOVQ1a0V5NmtlZ0t3Q2xqZE93OTBaRDBn?=
 =?utf-8?B?WjV6V0hCMVAzQlZQR212NTJFZ1VuSVI3VHdDUW85UE9xellvVmdMdXBrK25Q?=
 =?utf-8?B?ZnFneHRDUmJLNkREVWQ2djJBdEM5emJkd3hkelFmYS9UejZ6c1J0VDlJWFVi?=
 =?utf-8?B?S2tpVWZ0eG5LSEZRaFVjUUhib3AzTDhwOEpKV2dtVHdLZTBXUWNvL3VFY1RS?=
 =?utf-8?B?Q3g1Tmd0OFB6czUweGw2dUtsVC9xeGdTVzB4Y0NteUVORUlNWWFxNk5BZ2ts?=
 =?utf-8?B?cmFVc0t4N3VKOGhQRkFoVS9DYTBpSnBUK3dOdUg2UnN2QldtTjFlRUNUMFJ2?=
 =?utf-8?B?V2xraWt5SGQ1b0RRRUI2QVBOQVlzazFhZVBLUUkrMG1qSU1sTXppcUJwaCto?=
 =?utf-8?B?OVRkeFNLVEpldFp5RENmdkViazVHQlFPaFdtMHIyTFZaeHFpRjB1VGR4VWdz?=
 =?utf-8?B?WXhLdGY3eW9QNk0yREdlSGE4VzFtdzAyc3Q1NVB4bDQ3SGU1alc2WEFvaG15?=
 =?utf-8?B?MSs2bFNFUnpobDRlUmVLVFRNcEtXSndrTjNZbjkxMjExRlJTRTlJNnl6RjZW?=
 =?utf-8?B?ZDlMVnJ1Y0F1WWFrRDFzWDlvTXlJODlYSWMya0tmbDRrdGp3cnZ3MCtEUGdu?=
 =?utf-8?Q?5UalMwP5aTJF9kZuvMF7ufJ3/znxR0R5?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YUV1V2UrSS9DdzZETk0rL2lmVkFEU01nZjJVRWZzbWNEeXdsemdmVUZPR1Ir?=
 =?utf-8?B?S0dBQkNRMHp3QnZINHBCdTJRQ05VVmNFNDY3bEQ3YzY1cUNURmxKNUFCRXFp?=
 =?utf-8?B?U25oZ0djaVR5YmNyUy81QVBNTVljWFErTG55VXZUVHR1MlUyNitpb1F5WUts?=
 =?utf-8?B?QmFsNmRBL0U4YUx0MjFSVlJFNEd2VEpqeFhJenlwVzNwa0Q3ZUlBSEprcTF2?=
 =?utf-8?B?VjR1bFFKOXUrMG1xZk1VUnJoeXlVcjJFWkxObWxKaGFWWUlIb1Rkc2hTcEh1?=
 =?utf-8?B?Mk51YnQyVGU2Q0YzKzBsU0J4eEw0TjRaQjdqN0ZUbzZMQkpJc2I4R3JFSVdN?=
 =?utf-8?B?OGpzcnY0WWl0VVRIbFhZSGNGOC8ydkYrTVJOM1FscHdxRVNOelRCclpFYm56?=
 =?utf-8?B?dXpZTDNSbll4czRsUXRJTVFzc1l1aVpzTC9BdmhveUNXdFlET3ZaV3NzdXNX?=
 =?utf-8?B?ejVPNTRWOVlMbGFXMlBCYk5ybFpuWEkxb0QvdTVjUkpMZnRpNFgxMWtGY0Yw?=
 =?utf-8?B?Rk1VZUpoNWRDUUxjV0tSTTNEdVZtRUlLaksxZEV6cVdWQ25CNGorTTY5SVlq?=
 =?utf-8?B?WGcvdGJ5b1BhckRTMHpDQy9kM1BLdXE5VGtzWlhONFd1L1RhVnEyRE5aMnFK?=
 =?utf-8?B?NFIwSmhMTjVsS0ZyOGVoeXdnWFd4VmY2UjlUblVkOUJHWXMwR1phMFJBcjV0?=
 =?utf-8?B?ZFV3ZCtoRFZqbkVBdXVqR2d1ZHhHbW01aXF3Z2h5c3Awa2ZMbGtGWlVuNHdv?=
 =?utf-8?B?a0hmNnpPSGEwOHhVNFdQazdFT29QSU9sUUVtcTlkMGFjUndBdVh0R1RsRkJj?=
 =?utf-8?B?clUyaHJLbk9TSFV5QkZqb0gxVnpjYXBjYmNwZ3Rpb0JnbXNyc3ZqNkFoSnZI?=
 =?utf-8?B?bmxEV05jbDR2bU0wamJyYnF2NS9ERUFoUWZzZmtUaUpDUXZURVlYSmNLZGJz?=
 =?utf-8?B?VHlNcGNveW9TeGcwY3hTTTNpMHhaT1R6UmN4SGZ2MVlqYVZSZW5hVnJDVXFq?=
 =?utf-8?B?LytCYTFEQU1uTi9TNWlIWUJwaUtONjdSdVN1eTZkMG9wWDE3Y1owUCsvL0Vm?=
 =?utf-8?B?YlJhVWdicWRrNzJFVzBCZklUMWlVNlFkQS9CSmxodjVPSEpYNFg1WUsrbUd3?=
 =?utf-8?B?dDhZMEFPcE5iSUZlWm84Q1E5NDk4YUxkN2hLVmlJYjFKeU9saWFYbXpWVFhE?=
 =?utf-8?B?Z0JNTkRyT28yYTF0eEQ4WllEY3p1aDFTbm8yam41ZTJnZjhhZWF3aG9ZUTVT?=
 =?utf-8?B?bU1Xc0poY0dHRnR4M2NJa2pKZnUzVVpGamtwVUFWRE5YS3AyYXZ2MXpFZFpj?=
 =?utf-8?B?OUQwUnEwZDNUWG9zYkhWUDdOVlpoTUNoK1RWVkhpU0RHWlFBQUx6a1ZhQ3Qr?=
 =?utf-8?B?Q29rUU5NTVRHUW12aVdTVXRDV3FXc1cyUkFKUzRoZitIeDZlNFl3NGhjN2Nr?=
 =?utf-8?B?WU5OQ3E0VmJ6L21EOFFSWHVvNzJ3czlIdkRiY0xmQ2t1cFhQVkpoMEYrMWs4?=
 =?utf-8?B?MFovK1Y0U0xmWkRUTVVyVTdjaDFETGZIWVIzRGlnZXJ4Q0pIa1RzYTVWRzhp?=
 =?utf-8?B?azQ1Q0hMZVhCWFY4ZlhCWjB1QlFWQkxqQW9zRVkwRjBzOC9CNzdTa3R4c0xr?=
 =?utf-8?B?cTZUVStRb21PQllxL0lMdnBPY0RwcTRIQU9oS2k3WVduL0VubXp6SG1TVmpJ?=
 =?utf-8?B?N1QvRzFlOUFmVGNoK3BJbDB3SlVuU2VzTjRDRHBnbzlBVk10VmJHeTNoYStO?=
 =?utf-8?B?c1pkdklEak5NcDZEdTVzMEwwazR4V0F1Y2paOUNMZ1BkQlJQTm5YOG8xa3hn?=
 =?utf-8?B?WXBGd0pEQmZGcS82WUN5Nk4ra0FBWG1qYXVZaWRabUpqdnl0MTVLd055M3FJ?=
 =?utf-8?B?bDlnZUtPaHhrNGhMMk1kbi9GcXVhS21VQTZ4ZGhuazlyQThxakJHUEY2R0JK?=
 =?utf-8?B?eU5CZjdsVU83ckZCUUl2SlVjMDVLZ0Z2bEFYdkhnRjhDWUplalZGbVFFUEsy?=
 =?utf-8?B?RGJWclF5OXBmNjI0UW8wZE5NVDRzQm5TSll1Y0FkRjE4VGh2czFzOThNODAv?=
 =?utf-8?B?MFZyelUveVlJaCtTdlZqbDhHMEFTVCs1cUlXVTJ3WlhJSmt6WVVpdDAxd0Vv?=
 =?utf-8?B?WHJQazFsb2pzM010VkRTYWRGdUxra3FxQ2o3RElZZmszNjJKV2xTSjNIUU9R?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41346175-07ac-45a4-c9cf-08dd3eb60986
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 09:36:12.1032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+ppIrFPj3JASYUxCIZ7ISedxj21O9S0Cg6hA+ILBDUMnJWrIW/772owukklsDytj5yXO/w6rsBf8j++EZwcXzSQGNlwMtPg4ViCALWhwquNCqzmaHAL5Ly0YHpDCNUi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8341
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jan 2025 09:36:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17668

SGVsbG8gSmFuLA0KDQpTb3JyeSBmb3IgbXkgbGF0ZSByZXBseS4NCg0KPiA+IEthenUsIGFyZSB5
b3UgZmluZSB3aXRoIGJlaW5nIGEgc2Vjb25kIGRpcmVjdCBjb250YWN0PyBBdCBsZWFzdCBhcyBs
b25nDQo+ID4gYXMgd2UgZG8gbm90IGtub3cgeW91ciBzdWNjZXNzb3IgYXMgV0cgY2hhaXIuDQoN
ClllcywgaXQncyBPSyBpZiBuZWVkZWQuDQpJbiB0aGF0IGNhc2UsIEknbGwgcHJvcG9zZSB0byBj
aGFuZ2UgaXQgb25jZSB0aGUgV0cgY2hhaXIgbWlncmF0aW9uIHdpbGwgYmUgY29tcGxldGVkIDop
IGJ1dC4uLg0KDQo+IFdlIGRpc2N1c3NlZCB0aGF0IHllc3RlcmRheSBpbiB0aGUgSVJDIG1lZXRp
bmcsIGFuZCBhIHBvc3NpYmx5IGNvbW1vbg0KPiBzb2x1dGlvbiBmb3IgYWxsIENJUCBzdWJwcm9q
ZWN0cyBjb3VsZCBiZSB0byBjcmVhdGUgYSBwcml2YXRlDQo+IHNlY3VyaXR5QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZyBsaXN0LCBwcm92aWRlZCB3ZSBjYW4gY29uZmlndXJlIGl0IHRvDQo+IHBlcm1p
dCBwb3N0aW5ncyBmcm9tIG5vbi1tZW1iZXJzLiBUbyBiZSBkaXNjdXNzZWQgaW4gdGhlIG5leHQg
VENQDQo+IG1lZXRpbmcsIEkgd291bGQgc2F5Lg0KDQpub3cgeW91IHByZWZlciB0byB1c2UgdGhp
cyBjb21tb24gbGlzdCBpZiBwb3NzaWJsZT8NCkkgYWxzbyBhZ3JlZSBvbiB1c2luZyBzdWNoIGNv
bW1vbiByZWNpcGllbnQgdG8gc2hhcmUgdGhlIGluZm9ybWF0aW9uIHdpdGggbWVtYmVycyBpbW1l
ZGlhdGVseS4NCg0KS2F6dQ0KDQo=


