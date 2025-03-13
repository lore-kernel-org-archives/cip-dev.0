Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914D5C28B2E
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 14:32:21 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.5])
 by mx.groups.io with SMTP id smtpd.web10.16382.1741876338253983472
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 07:32:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=anNjtFG6;
 spf=pass (domain: renesas.com, ip: 52.101.229.5, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsN8XBYNUTfDSp3GeexUIeP+B1DezkI30yptX5Qeye9iQBjvkhsmVLkzjtLxdDWBAlCrIBRW/4Cc4YziGKOY52s8Gh6HIEutE6kjizrXcZhF4C9syMbkhDHSiD5HzwpyFBrTSMwWda7mOVJiKMFs9EE+prh3ZEb5B0t7Y5WpyCojt1zuU98ADmRG6EvaY/Qmp9Z002SMVcljTJD6/iMD73XGRjmEaaNydmM4TzeWWt5Klr0B2W5QEMP4jfeIXQxViwZ7cZMTNaFJ4aW0l9V5ubw2FqKz16N6QqbK/lgWSRMU9mtTTiyYXQ3S3lS/HJpq5dnxVzkuBH7gwO4ZODgliA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uTE6VO+2rLgspWANbQ555ZLpSZR46fgBDE38sBUfNw=;
 b=tJ2vPDMXnVYb3+JTKdqikc6c9cUDIdKlHljz+gMsLWy9meNqYa5jy1qJ6yLrNIMsv9oPGHvUfWiDQOQwFweI3vIe4TbhtLTMTOXj/GnT4mgOQyolo4tCUGbMKiHIV4Cv9gN/jQ48+7FUUnyU/zKdfRI9s+Xj7d9S1aUBYn6LnVPp6zUxdyWeYb0N8fZ1JADlgRxPyEaRsrt0JemAp6GypqYUpnNdCfGuyRZRPY+nSUcyWe1z2CJ9ptKaTlTfvdR2XxBJqkMFlR0PhX+RjcRNyHRnc3Tl9vRO0BfR3l2F32Sdy8ViBNk1f4zeIMrVd+6fUP+Ue3DZkP+aeo3w8raVYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uTE6VO+2rLgspWANbQ555ZLpSZR46fgBDE38sBUfNw=;
 b=anNjtFG6Ac0wqee0VsOkQu9n0Wofkk8Vow5aaQZq91iIjypgmBGPwF65f5wylKee7SS+TBR2kcXFhZaHVwIgGr6xqAmK+DFW0S4tZq6dx5rl8Xd6ZzDckG5khlE2osL/ZWgbny/90nUvb2S1x/XiZvMWgGSxuT2iqYTWLpS5sYQ=
Received: from OS3PR01MB5896.jpnprd01.prod.outlook.com (2603:1096:604:c6::8)
 by OSCPR01MB12850.jpnprd01.prod.outlook.com (2603:1096:604:33c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 14:32:13 +0000
Received: from OS3PR01MB5896.jpnprd01.prod.outlook.com
 ([fe80::1b62:57c6:c2cf:641b]) by OS3PR01MB5896.jpnprd01.prod.outlook.com
 ([fe80::1b62:57c6:c2cf:641b%5]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 14:32:12 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Shivanand.Kunijadar@toshiba-tsip.com"
	<Shivanand.Kunijadar@toshiba-tsip.com>
CC: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: LAVA templates in isar-cip-core
Thread-Topic: LAVA templates in isar-cip-core
Thread-Index: AduPX1w73+S62qd1SRCs5UMrnumWmAExQNUw
Date: Thu, 13 Mar 2025 14:32:12 +0000
Message-ID: 
 <OS3PR01MB5896036E5C860F3FC32E5C71B7D32@OS3PR01MB5896.jpnprd01.prod.outlook.com>
References: 
 <TYWPR01MB11063DCBCB8B1B68822A14A84C7D52@TYWPR01MB11063.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB11063DCBCB8B1B68822A14A84C7D52@TYWPR01MB11063.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB5896:EE_|OSCPR01MB12850:EE_
x-ms-office365-filtering-correlation-id: 796a65a1-386f-4293-0f1b-08dd623bd85a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|7053199007|8096899003|13003099007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?akVOV2hlT3FDRlVyR0NtYXVoUE0zZHNRUGdiN01yNnIvWFQzWGljWUxr?=
 =?iso-2022-jp?B?VVgvQUtUTFc0VjFDSkFGN09SUkZ3TkQ3Qk5jeWovc1Vjek1IT1JXMzl0?=
 =?iso-2022-jp?B?VFg3TkRsbkFBZ2lDZDk3VCs2SkwvbzkwUkdYNjZQNG5ycmsxcU1HbVR4?=
 =?iso-2022-jp?B?TzZzNXd0djl1NTk4bDhRV3o2MGkzVkRkeHZmQ3BIUWZJbUhlSGVuVmxV?=
 =?iso-2022-jp?B?WnlhclBoZmpHSlJOYWNIM1VpVjdORDZ2bkx3TFJva2V4VEovRmg2SjAy?=
 =?iso-2022-jp?B?YWNwMjJUU0FueUFwTllSaHFCQldTR0NUWGw1M1ZDVVB2aWYzV0tFSnN0?=
 =?iso-2022-jp?B?V0VXWm13V0g2Yy9RZ1I2eUlHRU5qT2FRaXhIZE5mamdYWDNieHVxUThE?=
 =?iso-2022-jp?B?Sm11N3FZMUJMUmpUaXp3ZVVXbDRnS0Z6aWw0Zm5JbzFBWHVMdWNoOEdm?=
 =?iso-2022-jp?B?aUZ5Nm1PZ3QxR1lTQXZSVzdHeFpUQzNDclprQ3FBTWVJUzFjQktCaDEy?=
 =?iso-2022-jp?B?ejJJZ0tIR3ZiK21xUU9oUXVVM3FkRVVMMlc5Q20rTHlDbzBFRkt2MUNo?=
 =?iso-2022-jp?B?ZUc0VlR5TzI5RUs5di9rK0FYZDdibjFPMTQ3cko2c0pLTXEvblZDdHM3?=
 =?iso-2022-jp?B?U0ZzOGRkZmI0OFZiM1poYXM5ZU1XcFp4RS8xY0pZU2JFVk5VZHAvZ3Fp?=
 =?iso-2022-jp?B?OXNmNGNWNmVJU3RpNW5tc0dXRGdIK2dzamoxSjRmZ05PdFpvWXVyVGE5?=
 =?iso-2022-jp?B?MnFjelJLS2M4VmhiTlpUMUNJRElOMElHTEN0bElQZkFiVnIweUlNZjZ4?=
 =?iso-2022-jp?B?M1NoaVBFaU5nN09RY25BNm5KSWlFZG1KR1pFSEFiQXlmMmhWSXQ4WnVI?=
 =?iso-2022-jp?B?VHpYZWN0NG4welZrcE5ua1hoT2E5Lzd0OExzVFlibFVFUGhhU0hBdkxO?=
 =?iso-2022-jp?B?ME94eXFyNVVSeFp2UXlPbkhsRzVOTllWQWFBUW1UZjUweE50Rk50T2Ey?=
 =?iso-2022-jp?B?SU9oeGFVRGF5VXhJOFFWVG4zSEVTT0V6NTU0UGdZcEIyRzArRGE0ZjZU?=
 =?iso-2022-jp?B?WVhVRFNKdkEvazJsNEN6RzhxUTJmNEUrQ1FZb1FnMm1PMUFQUWxrZk9J?=
 =?iso-2022-jp?B?NlRTNlRWUkpodVFuT3FPM0xrQzR0S1pvdDNESTY0OEFrWHREZGpGekJk?=
 =?iso-2022-jp?B?YVI2akNDdEJoQjN6ZEM5VzRDUDdsc0I3MUhudDdXTG5KRUt3eW9hQlYv?=
 =?iso-2022-jp?B?R2x2Ums3Ylg3NnlBaDZHSXo0RWkzQlBNdktXbEcxdHY5dWRPV1FtQnlF?=
 =?iso-2022-jp?B?RlJJU1NCdDZpRnVoemdPalk4d0tSQ1FmL3FLUXg3SXp2ZnJJYlplWDlh?=
 =?iso-2022-jp?B?bndmdFZ3LzZtcXRDc3NsaEtWK3dNV1F3VE9zc3h5NkNDTDZOSkpSV2h2?=
 =?iso-2022-jp?B?eVlCeGdCWENSS0pINlBIYXR4OW90WWtvV1R0OHRNUm9sVVdJZEJuTmwr?=
 =?iso-2022-jp?B?ZThZSjMxRndQZEhKekh5RFBKY2Q0dWFJbHNrTWZaMFc5L3FRSENEQkdp?=
 =?iso-2022-jp?B?Q25KOFRGNW5oZ2VwOGxjVTVFakhlMDVwang2Sm9Iakt1a0NROUtqaTBy?=
 =?iso-2022-jp?B?cFhOendYblV3WjFrQUxtWWc5UCtETFJWN3JCYnlMOWdDU0hTK3dibjg5?=
 =?iso-2022-jp?B?WndRTlYwWGlvVUwxQURNMWlkU0tFN1RaMkJVWUZyVTl1WklVdnpYYm1O?=
 =?iso-2022-jp?B?eVFGZWJPWDVxaC9FRHY5alpuNXpzY0s1VWVrWmJOMG52eEZUeUR2MDEv?=
 =?iso-2022-jp?B?WFFoSGdGZ3o3QzhVWTJFdFlESENveXkrU2EvTlUxQmNESkF4cTQwSWxB?=
 =?iso-2022-jp?B?NEV1cS83UTJaQUt1aEcvWkpORGFMVWx5M3JxUElvVGpvSTZZN3EwZCtW?=
 =?iso-2022-jp?B?N0lwc21EY3JyZWFWYUpUZkJjajB0V1pvcCtHYUJtT0NKZjRHK01TeHVz?=
 =?iso-2022-jp?B?WUlhMlZVd2xkRkRnZU1lcWJBRjBlWGIzQndjNHU4MGhtS1kyNjJuWEh0?=
 =?iso-2022-jp?B?clE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB5896.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007)(8096899003)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Z1ZkOGRNcWMrRlRPSTRHWldKaTh3RDRLTHlxYnVxbG8zdXRwSDVEUFN0?=
 =?iso-2022-jp?B?T0NHOTVHckRrT1JISzJRNThoaWxwdWlvd3ZHRDhMUlJPOFJDTllTdEg4?=
 =?iso-2022-jp?B?alExNzV4ZEphMG5ZNDkrL2s1ZnVQUCs4OEt4bGtZQWdlS0d0OGZvd3JS?=
 =?iso-2022-jp?B?eVZ5YjEzQnNwK3ZMMUZlQTgvVTNGUmwwejNvb1lwSnd5SGdtdzNUa3RY?=
 =?iso-2022-jp?B?ZnhaRThkU3Z6VEpkblFYZi9JckNJbWo0OGtpTXlYdXRvZDdLamhKR1pE?=
 =?iso-2022-jp?B?aVBqYmsrcVpLM0FpLzVzT201eEV3dmNON2ZWODNlbXhiejRPL0ptQ1Z4?=
 =?iso-2022-jp?B?QTRyWGJLYWFuenZoNUN0Um5HVVZrWU8zMzdteklacXdMUEpBUXcxRThZ?=
 =?iso-2022-jp?B?TXY4N3ZOREp6cVp3d3A2YTVHRm0wenQ1ZkJheW5ZMWZFaDVDR09LTkRi?=
 =?iso-2022-jp?B?S2d1L20wWEcvL2FoYmkxUWxCTDBqSzIxaEZXeVFIaC9URzRNVUFKWVhD?=
 =?iso-2022-jp?B?Q3ZsTWdiNW1Dajd3L0hWMkdMeng5Ump5ZVNyRE9xWXZJVjczUFVmamlv?=
 =?iso-2022-jp?B?VnpmWUsxQ01zSEk4b2hTUnEvVlJnQkpDS1NRb2lyUGRBUWsvVXo1VjZi?=
 =?iso-2022-jp?B?L0luYWRUMngwcEpEdERWQjV0b3VyR0VuT3VUSnljbHhNV3RqODhUSDRO?=
 =?iso-2022-jp?B?d2tpUzhNVFpkZzUwanI2YjJRWmozQXkrSU9nTWVtK3I1RzVtc2x1b2tq?=
 =?iso-2022-jp?B?QnY3aWNkSGI2M3N3blk3THdOT3pKeVJDRDBGV01mKzU3MWlmbitqems0?=
 =?iso-2022-jp?B?SWNMZzVtTllDRURZdFlJRmlPQ1dybVN5L0tSOTBOWThTWUhSdGNuQ25K?=
 =?iso-2022-jp?B?WTNldFE1TCtNc2FoVnZNNjNPbUZSdW5GUjFQNVFVakFGclNsbXU0UTFF?=
 =?iso-2022-jp?B?c2xsSlNWSnAxZCt5bVZvNUo1L1pGdXpmT3JpOWgwOHljWG16cmxxREta?=
 =?iso-2022-jp?B?Z3RjOVZ6TC9QQ2RwMk83VU1obW1BNmp6UkU0QzVFYm9La1U1WER1NGh1?=
 =?iso-2022-jp?B?eDBURWhZelFXUlM3SlNTOEJva1JsbTFtb0tkN0QwWlNPSXpuUUhPNC8x?=
 =?iso-2022-jp?B?OXFVdENXOHMrRWg2b3JOSkxLU2FQSjFhMUZ0eGVwKzdSQWEyRVFFMkVW?=
 =?iso-2022-jp?B?OFVzUm9wQTV6enhvZisxWlRCeDRPN3JVeVM1WHhWTHhqOXFlYjY4Rm9u?=
 =?iso-2022-jp?B?U01HdGI3K1U4cGk5T0xpZmxpRlRxNTJWY3VoMFl5ekdHQmVLMXFCVWYw?=
 =?iso-2022-jp?B?ZFBjSFhjaHRSQXFSRmlad3N4VUVUWmZ6ZzJzTUJxd01jcWZPUnBhNjFk?=
 =?iso-2022-jp?B?VXovZStpbEtFQ3MrbTBqS1FtZThISXRXakY3cytDZnF4TjVZT1dlSEhG?=
 =?iso-2022-jp?B?ekNhcU1tSnYwVUZGR1hpQ3lDLzFPRnBCR2pUWXdrSnRwUzJ4bkxRa3V1?=
 =?iso-2022-jp?B?QmE0Zk9QU2l6bXlCTE1JOXFjN2M4WVptLzBlOUxmajRnZms2VFdYZE0z?=
 =?iso-2022-jp?B?c3hSVjJkSTBWRy9EOHpnMzNaeWJYTnFOUFVpUm5BMWdCTHpnRGs3eTVw?=
 =?iso-2022-jp?B?NER5YmVycXN4eElxNzhUaHFjanVwdnQ1QTZsTjM0bWM5eEFlNXVMcWUy?=
 =?iso-2022-jp?B?Tm1xU1J6T3hWSEVZSDlaTG5BRkRUR2JRNnAzcmR2ZHlLWVNIYUhtOWF1?=
 =?iso-2022-jp?B?Mm5UYURjb0hhSS9UcUtMWkcrQkdHU0RlVXNtSEo0dWFuWDU3eit1anNI?=
 =?iso-2022-jp?B?UnpOQ3VYNlFNMUpWSFFIYUt5Z09WZ3VQNklyWlRlQVF5THdPU2dDMlFM?=
 =?iso-2022-jp?B?TEZNMzhXV0gzT3piamVhdlVZWkZ2dUtzQlg5VjZaSnlWWVdYQTArY25E?=
 =?iso-2022-jp?B?TW5vckhYNWM1aFBNUW1XeVdEOWxZNjU2QmFMTHFFaG9JaVYvcUhtTU12?=
 =?iso-2022-jp?B?a2pOaHh5andrWWVmdjROaFRDVHNWVm9PcnNNdEdDUThYODRTWDRJWmM1?=
 =?iso-2022-jp?B?NHJUazg2TThnUUoyTnZ2QTJxUWZ1N09NK29Eam91UHJYSEhJQXc0KzMy?=
 =?iso-2022-jp?B?SDVVZ0lFN1F3TmNMZU1sRTZYNGZMUkxnanZ5S0pOa01wY3dZSndFeXFB?=
 =?iso-2022-jp?B?VXZOODFxWWcwYTQ2YlVCZzdRcXlQM2hBOHVjbWhzR1A4NzRwN2hocjB1?=
 =?iso-2022-jp?B?Q1oyU0hnME9DTnRVVW5qNkVoMkRHSWQrczlxcVNpRXlvMVEweGV3ek8v?=
 =?iso-2022-jp?B?SFhNWGMwOE1pb0Y3OVIyK0U3R01WamY1Qmc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB5896036E5C860F3FC32E5C71B7D32OS3PR01MB5896jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB5896.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796a65a1-386f-4293-0f1b-08dd623bd85a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 14:32:12.8425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mq/Dv4AGCvkdR2TxTQenUXMXWEtO35T6GUyVTMmZH/0FGD+Gv1J+H2SHwtBxt4+NYGznvnlsVqmIXph+JvEucU/X93LLitMlSRyqChfFpnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12850
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 14:32:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18199

--_000_OS3PR01MB5896036E5C860F3FC32E5C71B7D32OS3PR01MB5896jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Shivanand,

I=1B$B!G=1B(Bve no objections if you=1B$B!G=1B(Bd rather use complete job d=
efinitions rather than stitch various templates together.
You just need to take care to modify all relevant definitions when applying=
 changes in the future that should be made for all jobs etc.

Kind regards, Chris

From: Shivanand.Kunijadar@toshiba-tsip.com <Shivanand.Kunijadar@toshiba-tsi=
p.com>
Sent: 07 March 2025 14:27
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: dinesh.kumar@toshiba-tsip.com; kazuhiro3.hayashi@toshiba.co.jp; jan.kis=
zka@siemens.com; Sai.Sathujoda@toshiba-tsip.com; cip-dev@lists.cip-project.=
org
Subject: LAVA templates in isar-cip-core

Hello Chris,

This is regarding the LAVA templates and preparation of LAVA job definition=
s in the gitlab CI.

At the moment, in isar-cip-core repository, the LAVA jobs definitions are g=
etting prepared by using template files.
I understand that this is to avoid code duplication. However the template f=
ile approach doesn=1B$B!G=1B(Bt work well with all the test scenarios.

As part of improve test coverage of swupdate/secure boot[1], we identified =
some test cases and written LAVA job definitions for them.
Each scenario requires different steps/action block or some other changes b=
ased on the test scenario. It will be difficult to handle all these changes=
 using templates approach.

At present, there is a script in isar-cip-core =1B$B!H=1B(Bsubmit_lava.sh=
=1B$B!I=1B(B[2] which modifies few things based on the architecture, distri=
bution(i.e using sed command) even after deriving the job definition from t=
emplates. If we consider to integrate negative test cases of swupdate and s=
ecure boot which makes the submit_lava.sh script more complex and also the =
readability[3].

We may have to add additional test scenarios in future as well so, by consi=
dering all these things I think It would be better to keep the entire job d=
efinitions in the repository instead of deriving it from templates.
Basically we can make use of templates if the changes across multiple jobs =
definitions are less, otherwise we can keep the entire job definitions(comp=
lete .yml) itself in the repository for each case.

What do you think about it?  Please provide your opinion.

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/120
[2] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/scr=
ipts/submit_lava.sh?ref_type=3Dheads
[3] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/1e8788d5=
c54ce2eb76048ea2cae11af079a4dbe6

Thanks & Regards
Shivanand K

--_000_OS3PR01MB5896036E5C860F3FC32E5C71B7D32OS3PR01MB5896jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#7030A0;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0">Hi Shivanand,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0">I=1B$B!G=1B(Bve no objections if you=1B$B!G=1B(Bd rath=
er use complete job definitions rather than stitch various templates togeth=
er.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0">You just need to take care to modify all relevant defi=
nitions when applying changes in the future that should be made for all job=
s etc.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-ligatures:none;mso-=
fareast-language:EN-GB">Kind regards, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">From:</=
span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans=
-serif;mso-ligatures:none;mso-fareast-language:JA"> Shivanand.Kunijadar@tos=
hiba-tsip.com
 &lt;Shivanand.Kunijadar@toshiba-tsip.com&gt; <br>
<b>Sent:</b> 07 March 2025 14:27<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> dinesh.kumar@toshiba-tsip.com; kazuhiro3.hayashi@toshiba.co.jp; =
jan.kiszka@siemens.com; Sai.Sathujoda@toshiba-tsip.com; cip-dev@lists.cip-p=
roject.org<br>
<b>Subject:</b> LAVA templates in isar-cip-core<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Hello Chris, <o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">This is regarding the LAVA temp=
lates and preparation of LAVA job definitions in the gitlab CI.<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">At the moment, in isar-cip-core=
 repository, the LAVA jobs definitions are getting prepared by using templa=
te files.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">I understand that this is to av=
oid code duplication. However the template file approach doesn=1B$B!G=1B(Bt=
 work well with all the test scenarios.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">As part of improve test coverag=
e of swupdate/secure boot[1], we identified some test cases and written LAV=
A job definitions for them.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Each scenario requires differen=
t steps/action block or some other changes based on the test scenario. It w=
ill be difficult to handle all these changes using templates approach.<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">At present, there is a script i=
n isar-cip-core =1B$B!H=1B(Bsubmit_lava.sh=1B$B!I=1B(B[2] which modifies fe=
w things based on the architecture, distribution(i.e using sed command) eve=
n after deriving the job definition from templates. If we
 consider to integrate negative test cases of swupdate and secure boot whic=
h makes the submit_lava.sh script more complex and also the readability[3].
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">We may have to add additional t=
est scenarios in future as well so, by considering all these things I think=
 It would be better to keep the entire job definitions in the repository in=
stead of deriving it from templates.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Basically we can make use of te=
mplates if the changes across multiple jobs definitions are less, otherwise=
 we can keep the entire job definitions(complete .yml) itself in the reposi=
tory for each case.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">What do you think about it? &nb=
sp;Please provide your opinion. &nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">[1] <a href=3D"https://gitlab.c=
om/cip-project/cip-core/isar-cip-core/-/issues/120">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/120</a><o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">[2] <a href=3D"https://gitlab.c=
om/cip-project/cip-core/isar-cip-core/-/blob/master/scripts/submit_lava.sh?=
ref_type=3Dheads">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/scripts=
/submit_lava.sh?ref_type=3Dheads</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">[3] <a href=3D"https://gitlab.c=
om/cip-project/cip-core/isar-cip-core/-/commit/1e8788d5c54ce2eb76048ea2cae1=
1af079a4dbe6">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/1e8788d5c54c=
e2eb76048ea2cae11af079a4dbe6</a>
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Thanks &amp; Regards<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Shivanand K<o:p></o:p></span></=
p>
</div>
</div>
</body>
</html>

--_000_OS3PR01MB5896036E5C860F3FC32E5C71B7D32OS3PR01MB5896jpnp_--

