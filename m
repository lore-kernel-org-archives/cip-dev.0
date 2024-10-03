Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D1DCF6D2A
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 06:02:51 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.5131.1727935365570662548
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 23:02:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=c27Gfxyr;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1727935358;x=1729144958;bh=Y6k5d4k+Ky/re0zym9Q/4o/c9+rLLG+4oTV1OvY
	X/Zc=;b=c27GfxyrYyzs5EnZFL2uviPCXFs+rgvw9OS1yoPRHsDcPur0vm4ccm0aGNVvwZSOWe4b7
	2whEpj5GOsfqGzYQYYnfTM7rmDcBcK1AuQjhjMy4s4R7oBmav33EdWh2DyPF5s5VMqqvcVs4hw4hm
	w4eGaD+yFWWQCj/9RQzhNXBda47itAF7flw6l5Z5+WOIFhmWeB2emWsaHCjFDNf2eKbpe8cNalj6R
	HiHsap8rwLlZCEsZ7CT0SMzGGMEKNcxifrMNyzS29/8bWBV00NMiSmowpAGozZkByvIhCGP3U2Cro
	MFEwQlIIRDjVVIyjRXCytH9lkntzxIZfL8hp2VRrwQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 49362bhu2674344; Thu, 3 Oct 2024 15:02:37 +0900
X-Iguazu-Qid: 2yAb2N10ZqlrXARnG1
X-Iguazu-QSIG: v=2; s=0; t=1727935356; q=2yAb2N10ZqlrXARnG1; m=MoKoAP17x5bSsnz5uVI146ZLOzk2iQLs/7ux5su1eX4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 49362Z3k3904178
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 3 Oct 2024 15:02:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuGC/rMU+YZvxhDNrghXXsSvOoiQMEeLevv2+1vUsEOpWiqNlVPRPbRVvBtyD2+Eu59eQIZys8ZglxBHYQTMApFjBUd0U1+q8QswBNMjwMbMkIen1vthhmNP2orejd9WWtFXkcSkQBZfdyvl+115r1rEpx8b/uiIynNIshR6z/IFpT/eTqjCm0oCQ8tHAdIictL5sljZiwnOP65729NQTdyNhQe+HLi1/yclk85t4T5Q690oBJouA0i3fRnrzA3MAlJ/zJZbakcB176+HOTzsy5UBrsGEkhWbt0Mv4mb7xoGhi5UFsIzB/N5NrQB0qVufz7Dni7RFNJ7F5z36cFqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyumpTiO2GebgzlwWs57M/i5vjPjEr5q/EhHD+6ympE=;
 b=nYkAnwqz67PJHa3Z3HBmyeWKylS9eNt7zsJzB5fzdVb775pwgbFFeb6d9HA9mAv30iSsslEqBSxBjsxH7LJCcaE8awUJnhqHZgMD9IQitVZQfnnae8FQcve0DSld8EQnQrrl/QwFosgzgxouN8VPBPxyEjkNVrnmotJUnu2IqM/7QvDr31RDRUiw8XZEJvvysTlWtNoLkRLJUMtaItkizMHOetHCb8M8iE2zs+N+s6ugZjcOysChM2zhSDxvlybzCMmnSvAGOapfnJELTxvZhr07tByRfGtCllFwjkTpo/tOyhM5RX/Xo5l92qFQRN4KD6ES4niwYY+NGVXgFgflVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 02/15] pinctrl: renesas: rzg2l: Use
 dev_err_probe()
Thread-Topic: [PATCH 5.10.y-cip 02/15] pinctrl: renesas: rzg2l: Use
 dev_err_probe()
Thread-Index: AQHbFO2SKWzNr7RhIk6LzGZWXt+VObJ0iZ8g
Date: Thu, 3 Oct 2024 06:02:33 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638837327E5487B71D88A70392712@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
 <20241002170712.655449-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20241002170712.655449-3-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYWPR01MB9775:EE_
x-ms-office365-filtering-correlation-id: 74696378-23b7-4399-22fe-08dce370f8fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?TEREbWxxVjErcEZuTWZwdDBuTFVpZ2FOQWp6MzYwWHg5bzdSSmxjL3E4?=
 =?iso-2022-jp?B?c2lqejZBQWpXOFhjS09jRHpjS2Foam1NVjhWZVhLM0VYcHZVS25NS2x6?=
 =?iso-2022-jp?B?MzBaQlZlVjMzT1J3REg0Z1dUdU8zODh0N1hScFdSeTVHMndHZ09rdVZp?=
 =?iso-2022-jp?B?SWUxLzFVQWZBeDJmOGdHQjBDMmY3MWE0Y09ROVg2bUt6cHJYTS8xMGRm?=
 =?iso-2022-jp?B?SmY3ekpMUEU2OGZvb1RVU3FlYlBkVVR4N1pJQzg1bkZ2V2R1bTdPYmVR?=
 =?iso-2022-jp?B?RUt1bjBvSWFuY01uTWJ6ejFUY2pPeUpnZ1E3dVdDWmprQ1g3cnpUWmgr?=
 =?iso-2022-jp?B?ZHZ4T2tKa1VSTkVoNC9VdTNqZ3FJaXFCS0Q5OXJWOXJsTEVjSVlOcUdj?=
 =?iso-2022-jp?B?clVvWmJGa0p4RzRJbjA1WllHSWRWV0JPNCs1ejB1ZnZ4b0htSUdodFFr?=
 =?iso-2022-jp?B?dkpBUFFDNXJ5VkdLWmp1WllTZjRrRFg1QnljM0ltd05iT281aFJnSXlB?=
 =?iso-2022-jp?B?ekR6dUJJRXFROWMxdVE2aUlWRi9PL1ZzelBhcVI3MmhkcnZYd0phV0lB?=
 =?iso-2022-jp?B?OTFIeFRIcGpwQlByWVV1SWt1MVZGRnhjbXlYVGJlUzl2L2NxZnVDcU9a?=
 =?iso-2022-jp?B?VStYeDY1NG5hSC9hcXdIU0lTZGU5Q0IzUUFWeGdZbWkydzA4bWEvU0Vp?=
 =?iso-2022-jp?B?K2tHNHZWenprRitvVXNSV3F1MlpCVTlOSzBQeTdLNnZ2UDNkZ1BhODgx?=
 =?iso-2022-jp?B?VVY1K0VkSHJma2NHSk1uM1FhbCttQ3RjS1RHNWwvSUM1TWVDZHVkMlFG?=
 =?iso-2022-jp?B?RGJVR3BRS2MyU0QwNmhpVFNmYjJpakZoKzhXV3lHcGNrdWFTbXJRWSti?=
 =?iso-2022-jp?B?Qyt6emlzTnVlRDY2cXZDZzJjSnJjamFUaDJlNlQxMFVkenZMZ0d5TGxN?=
 =?iso-2022-jp?B?a2lTYm5JUEl2Zmg0NXVrZWZFeXh1R1Y1NWNCWDB0U1RIWDNOd1RlTk52?=
 =?iso-2022-jp?B?UEZYU2VqNGZMQXRGdkVzK0JqS2NvMm16QkJPWlhKbkc0di9XWExyWmor?=
 =?iso-2022-jp?B?V3U5RTRwNVgrZE43MVBUWXA2cm9Zc0lvTGVyZHNjVko2VlRJSUthV1pY?=
 =?iso-2022-jp?B?REdIbEF0N0hlblR4UEFEbldLQVp0TGNDWC8zbmxHWXZ1MEhiQTZTenF3?=
 =?iso-2022-jp?B?MjEwd3lmSEFkQVpjcGIxLy8wMkphZzJacHdlVVA1bm1VNE9VbkZEbUdS?=
 =?iso-2022-jp?B?ZFltWDZQeUlkM0h3UzEzSVZtNzlOYmtHdzhiN21BUlNkUDkwL1Z0Ui92?=
 =?iso-2022-jp?B?dnBPc211S25vZEVOeU53LzBnVlFEZWVjS0JJZmx4UmdJQ3E2M2d4aG81?=
 =?iso-2022-jp?B?UjJwZUtvemdrT1htYWhneEh3K1dnd1BnaitXa09KdUdmeDRIZkNNUjFv?=
 =?iso-2022-jp?B?dHJkdDJNN0toL0NkcXg3WGtKT0xVWTAxTUt3Y1pKNjNlQ29nb3JKc0Fm?=
 =?iso-2022-jp?B?VzhTVjFBVnJRTlNDRUptU1U4MzRjenZPTlNpMFdqY0hDaVZCcFRhYXVM?=
 =?iso-2022-jp?B?WWpCclBHRU9YR1VwbmxFVWRPZVM0cmx1QUptMnBpcC9RUFV0Q1VtNUw0?=
 =?iso-2022-jp?B?TitENTdXRWZ1YVdjTVV3RFZDM05ScFFoOERjbU1QZzA4ejBjUkhiNUxP?=
 =?iso-2022-jp?B?TFpDQnZWMFFuQ3B5d1VMZzZZcjl5R09oY3lRY1J1SWFVZTFNb0ZoMFhk?=
 =?iso-2022-jp?B?L09samNaalM3OFpTOWpsQzd1ZWIwNkV3bWxNZ2g5cU1EaDM0R2NGSTRz?=
 =?iso-2022-jp?B?bHZ2Sm5mcHJUZ1E0cnNra0dMOWpnWFAydm8rMGxybklwbW8vdVdkcmdR?=
 =?iso-2022-jp?B?K1FVQWFwL0wvU012SjNYblNtbEx4SVBqNEJxRmNWN0RKcjBhenV2TjNj?=
 =?iso-2022-jp?B?ekt1ZHI5c2lod3p2U3ljMEZPanRVcXRGRTVINEg5TWlIVlFCbDdHYW5n?=
 =?iso-2022-jp?B?YkJ6MkRISDNUM091VjgrS2dseDBheA==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dndmb3hFUm1Od09GOGZHL1IvVzE4WWI2QUFjaVg1RmhFY1hENkRXZVk2?=
 =?iso-2022-jp?B?dzFtL1g2OHBtaFd0cUNiYnNhK2hrYTJYcll4Vlh2L0RGUmRmZFZERVhr?=
 =?iso-2022-jp?B?dFBITDgvQndJVzNITXhYTXNRRG1IbEd4TC9hT0RIZUNpU1V4RnhxdTYw?=
 =?iso-2022-jp?B?NkNIaDhia3dOdGY2NEhscGdFTklpUmdTYmxZV2Fkckl4RDhMOFZjMU5z?=
 =?iso-2022-jp?B?YW52R3d6V0ZxQUludHNCVHFSazJVOWU0bExmejNmU2xJOFl0eUdzSVR0?=
 =?iso-2022-jp?B?ZlJaUjBMTFkyTDM0S01GdnBwQWVpYkRoL1NESVdjSklhemFzcmkrQW5G?=
 =?iso-2022-jp?B?WnRLbitVT0g1RTFMOVhCdW5uc2RsaWxnd2JzckdxWldIbnZFZVR5bG1l?=
 =?iso-2022-jp?B?ZVlmb2hsdVZjRnpjMWFLTEgvTTFMTlNVQzZUZjlMN1A4ZzNGNEtLWkQ3?=
 =?iso-2022-jp?B?YVNXaHBIbWM0L1MweXZjMFBSeDV3ZmNmMU5BdVk0a0hrQjY0TzY2TFZI?=
 =?iso-2022-jp?B?V1hOWUZSc1NTdlUzMVJBcmYyUDZGckY5YXlodE9XTSt1WC9wVDBFVU5F?=
 =?iso-2022-jp?B?NWwzdWVqbzZOQVpiTG1YMFBPbWlQVG5iLzJsM3BycS9ZSkJhU1FGU3NU?=
 =?iso-2022-jp?B?dlZWRnpNTmd0ZnBVOWFvdnU2L0lodk44eHZtN1dwcFd4MWpVNk5wVVo5?=
 =?iso-2022-jp?B?SlQvZi9icXlTV0lHbVBtcDFaKzk0VjEwb3FGcTR4VklrNmJlc3U3Sk05?=
 =?iso-2022-jp?B?V0FzdDUzaTNSRjcva0hqSnFsdG9mOUExdHQ5TDNYNmRaT0lSdFNEZTlD?=
 =?iso-2022-jp?B?NEl0eDJ4UmMxOWxUd29JQjliV1hNeGJrQThMQnZqL3hnYmFRTWx1Yi93?=
 =?iso-2022-jp?B?MzVNdFdibUJEQ3RmNHJPWGFTVldUbWxDZG5iNUYvOGdVb0hRdUNPMUJw?=
 =?iso-2022-jp?B?cWZPK21KQ2xOd05BYWRqbnl6V0kvTWNvTTNncGZqY3ZpeW1YRHVRZitr?=
 =?iso-2022-jp?B?K091bjFWdUFYQUlodmFrT1k3dW5ydDVsZloyb2g3ZUdleEJNT2ZjWVZ3?=
 =?iso-2022-jp?B?VnhUbFJOV2NORllSd2gyVmFEL0FkNlAyVWdRM0U0MnZSLzlmWU9NVGxF?=
 =?iso-2022-jp?B?ZTgraHBlN1AwMkxFaEtPenh2NFVHYzh2Q3JNUGlLSnUrZjRTMHZKMjhI?=
 =?iso-2022-jp?B?Q3BVQTRYell3Y1hoK0Flc2JMSUJZNWtXN2tSZUVZRm84WGtsSjd3cVBQ?=
 =?iso-2022-jp?B?ckFCOXNYRmdnUmttRHJLVjQ0emxMUUpuZWJzb3g3Nm1LY2R5K1luYnEz?=
 =?iso-2022-jp?B?WXczMU1PMVJDYi9FSnZzb3diN1NLd2VVRStTWkVUTXZNVis5NThzRzFD?=
 =?iso-2022-jp?B?eERoVGxLeXRLRnhDZW9yeWxYYmtMQ0UzRjNjanorWXFBYmp6aTIraTdi?=
 =?iso-2022-jp?B?TysyWWMvVG52Uk9HY2R3VUZldnpXZU1aaFl3dEZWZXIvUmdRUkN0OGdZ?=
 =?iso-2022-jp?B?RU5FUzNGZnV2OEhYSkJhYzdGM1NYbDNtSlNlb0o3NmJqdUIxRWtURTNY?=
 =?iso-2022-jp?B?WUVYNWIycWN1aEsrRXlDL0F2SzNubHNXVlJLUTFubWd2M1JaQ0F1UEg5?=
 =?iso-2022-jp?B?bUwrSk0xZVhmT1pNZ2JpZzF6WHNYVTU5VGt4RjRlV0pIOTRUU1kyLzcv?=
 =?iso-2022-jp?B?VVpzcGlEbElSNndMdytMUlJSOHZSdEsvNjVaOVJPRmt5aGNpZHNZeHIv?=
 =?iso-2022-jp?B?Q1ZHcVFycW5kemkxeGxYa0JscjZyeFAyMGl6VEFMS1htY1pxVVpYVnM4?=
 =?iso-2022-jp?B?dmlST25YUjlDQWxaVjZRWU5QVFVBRnk3REFPcjcrS0VoKzJDZ2JIeGNE?=
 =?iso-2022-jp?B?TEZia3JpZVV4OVQzNUd4cHAzclpmek8wY0JKV1pvTGV3RzdZc2crY2xX?=
 =?iso-2022-jp?B?YklDbFF4N0d2TjJYc3V2WkhadmM0dmVhSW9uOUFETGFiNk8wajU4NWVD?=
 =?iso-2022-jp?B?TENWbXA2SVZHeS8zVmk0MDZDbkxTZ0ZPb0FqOWg2NGpQd29ldmtjbEVL?=
 =?iso-2022-jp?B?N3kwdlhwTGpsWU1DQmJ4NFVoVHg2alg2dDZUaU5kemRMU3lYQXdCbjNW?=
 =?iso-2022-jp?B?NXBIWHlmcy9LbjBTeGRFamM1b0I2Q2twQmxPeUZwajRVQXNsVnRVeHRK?=
 =?iso-2022-jp?B?QjdYZkQ4UG5wZXRpK3NqYUloVEpDclZsYVUxYTEyM2RRZUxYQjVXNDRO?=
 =?iso-2022-jp?B?am0wNWVKSVY5M3dORXZ2V0Y2aVZ2ejRQR0RQbGdlVmllOThoNGYrT29V?=
 =?iso-2022-jp?B?MG1mSUNlZ1dlNm14TUc2QmUzMWlFNWxHZVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74696378-23b7-4399-22fe-08dce370f8fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 06:02:33.2895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7hz++PccLmNj+8934f783FdpMWowUKKI2yeSufUnyEiojeAI4QI1dWEhitgVSAW2iGK7aT26XC++PFszsESv89LARuoMD/BJbtjTc0ytLHsJtkuFRx1/zSPJgN20n7ee
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9775
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Oct 2024 06:02:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16984

Hi Biju Das,

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
> Subject: [PATCH 5.10.y-cip 02/15] pinctrl: renesas: rzg2l: Use dev_err_pr=
obe()
>=20
> commit f73f63b24491fa43641daf3b6162d2a451bd8481 upstream.
>=20
> Replace dev_err()->dev_err_probe() to simpilfy probe helper functions.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link:
> https://lore.kernel.org/20240728090421.7136-1-biju.das.jz@bp.renesas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 37 +++++++++----------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index c4d9bcb6f80f..7306a100153f 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -2200,16 +2200,13 @@ static int rzg2l_gpio_register(struct rzg2l_pinct=
rl
> *pctrl)
>  		return -EPROBE_DEFER;
>=20
>  	ret =3D of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0,
> &of_args);
> -	if (ret) {
> -		dev_err(pctrl->dev, "Unable to parse gpio-ranges\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(pctrl->dev, ret, "Unable to parse
> +gpio-ranges\n");
>=20
>  	if (of_args.args[0] !=3D 0 || of_args.args[1] !=3D 0 ||
> -	    of_args.args[2] !=3D pctrl->data->n_port_pins) {
> -		dev_err(pctrl->dev, "gpio-ranges does not match selected
> SOC\n");
> -		return -EINVAL;
> -	}
> +	    of_args.args[2] !=3D pctrl->data->n_port_pins)
> +		return dev_err_probe(pctrl->dev, -EINVAL,
> +				     "gpio-ranges does not match selected
> SOC\n");
>=20
>  	chip->names =3D pctrl->data->port_pins;
>  	chip->request =3D rzg2l_gpio_request;
> @@ -2241,10 +2238,8 @@ static int rzg2l_gpio_register(struct rzg2l_pinctr=
l
> *pctrl)
>  	pctrl->gpio_range.name =3D chip->label;
>  	pctrl->gpio_range.gc =3D chip;
>  	ret =3D devm_gpiochip_add_data(pctrl->dev, chip, pctrl);
> -	if (ret) {
> -		dev_err(pctrl->dev, "failed to add GPIO controller\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(pctrl->dev, ret, "failed to add GPIO
> +controller\n");
>=20
>  	dev_dbg(pctrl->dev, "Registered gpio controller\n");
>=20
> @@ -2325,22 +2320,16 @@ static int rzg2l_pinctrl_register(struct rzg2l_pi=
nctrl
> *pctrl)
>=20
>  	ret =3D devm_pinctrl_register_and_init(pctrl->dev, &pctrl->desc, pctrl,
>  					     &pctrl->pctl);
> -	if (ret) {
> -		dev_err(pctrl->dev, "pinctrl registration failed\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(pctrl->dev, ret, "pinctrl registration
> +failed\n");
>=20
>  	ret =3D pinctrl_enable(pctrl->pctl);
> -	if (ret) {
> -		dev_err(pctrl->dev, "pinctrl enable failed\n");
> -		return ret;
> -	}
> +	if (ret)
> +		dev_err_probe(pctrl->dev, ret, "pinctrl enable failed\n");
>=20

return dev_err_probe ?

Best regards,
  Nobuhiro


