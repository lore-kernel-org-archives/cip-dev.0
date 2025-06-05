Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A28C5B543
	for <webhook@archiver.kernel.org>; Thu,  5 Jun 2025 03:33:38 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.35653.1749094407909458628
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 20:33:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=wig0VV/h;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1749094385;x=1750303985;bh=KI
	6qUQHdvNE1k0acPkl5jO4g202XPLVW8/5NSBd5Exo=;b=wig0VV/hpCYQ8CGOsPJb6gKRVaZQ54WA
	6cHIT1K/YZkKBeLeZupE7Tyli89VYNhHoLi2Fb8dY40bFMFHneOieC85QZuRLN8bNhMvMvhoMe73Z
	+fafCcD0KJRpwO+ZkI24u+gE03sxfcH6QWH7vSLolAm6FjPVz05hkzBKAxna0/fyKFy/cJ2/O0Y+I
	rE119OW84Ry3QSmApA9/qnGLo+50fNJK0euKKduPAV0D3FHUVh0iEEHqJYo1gzfxbAnWZEMcCadVN
	6gFaCdyvaX4kgbMY62pLFTPZWNboAimYgtz1Z0Rq0x/DbuC5hQyC0wf70fdBTrV+runW5nh6GmTvX
	5w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5553X4212966017; Thu, 5 Jun 2025 12:33:04 +0900
X-Iguazu-Qid: 2yAbj3N9aouTP6UYOX
X-Iguazu-QSIG: v=2; s=0; t=1749094383; q=2yAbj3N9aouTP6UYOX; m=qnfpgG06l0yzBZz3wbH3WyGCLinoiMSaBvY1wP0a8rM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 5553X1os1533357
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 12:33:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DElBwzVg1UEKgtsLClQ3NAzWILoHRloarT10KS1H5Z1RSOQ6ZQBg2uOgDP/5312OC2g3R4arGYfqIOKWIjCO8pLdOVbZMtwP2t46tBuXJsa0NGQmgBoRldiWbplqoo++vwp9ZE+g5jPw4xSBg9bFwh1YI1cMo0dersD1Inw3ysX6/IUuN+ub2/LyMCPvkvRTlQMERR3EBYw9f8VwtGhagWX4nj7EMTuTyuiBqIB19w4cJ0pJ/f7F/UDRZPHP4T4xTesXhcyinSsi9Gew/OVXJ2l4GpeNFgxti9R8EEhK8vnGDPcRz21Kv2CjJHuHouygWNjfEi691h6xkeQGApYjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3umcVhCEiRNa0V3Abduer/BAc60HHyzEobkcPBoe2I=;
 b=fYvfSb4INBFhIqraTwQeZb8IKSS+RY7vlRESxesXooKY+SAaPedrAKdu4MqHIDKxCl0fUri6Z3GILmTVNWXRkcGaOzlcRXmhKuDZWOdFPF+qsCSx50MkZdSevII0xb9YlkFLtCxQ6EV91pGdNX4vtY0IOUdZE5hrNw2S3g4IzFhyn7OHT/ONYorcb+GLI/vkw8YaxlDcpdqbUYkSpQVdLS+MHcmtU7sSps1fW6+oxdaqar23d3T85LkKjyGp1vwe6vj7liVGoBg0TOm6UOq+ANKaHpi+lsWqv+zsj6UMk6kQcSj7w9DhqwPMa71IEfDGU/0hpbLpucqevCVEqeXCtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <chris.paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v6.12.32-cip2
Thread-Topic: [ANNOUNCE] Release v6.12.32-cip2
Thread-Index: AdvVym8akiQBzzvZTUKk1yyM8cB6Yg==
Date: Thu, 5 Jun 2025 03:32:57 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818FFBB42BB9B0FEB500A59926FA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYAPR01MB6428:EE_
x-ms-office365-filtering-correlation-id: 05452fcb-f771-4ae3-99e3-08dda3e1aa0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?cmVNcG45TEIyL2RVNk5DSnp5a2pCZzloOFZtYzRialA0cUN1TDcvbkFC?=
 =?iso-2022-jp?B?eHF1VkliMnJvZWR4YW1ydCsyVWZiaE5uMGFhV3NIaEdTMk83SnBBdmVX?=
 =?iso-2022-jp?B?ZFN5Y0VWV0l4eGhrcm1sdlR4bTFGN1lvczlPTkVtYVZKYWQrOW91V2E5?=
 =?iso-2022-jp?B?cFdaejJTV0pWTXhGekg4blQ3SmRqZmdlLzgyK3hkSTBjaDhhbXZHZG4y?=
 =?iso-2022-jp?B?R3dLcGNRVWZWbld3K2o4OUxENFo4UllPdlRrRGxDa0QyYmtQN0NQVExL?=
 =?iso-2022-jp?B?RE9JbHZxdEN0aEx0UlYvQlBtVWJlU3RQcm1kWkNwazZpOWtQSXQwQnhp?=
 =?iso-2022-jp?B?Vk94Y3dFanltRW4xaXNtTnJxTWxrOThTbndnOWVMQmRNN0ZtOTczV3NN?=
 =?iso-2022-jp?B?TEJHQ0lGSDFRUzcxZHJoMzZRT0JmVmpJSzFvVjJUWGtuOHNmVSs2MktJ?=
 =?iso-2022-jp?B?ejJDS2NaK1djSXFPL25jSjdCaG1QRVVCTzIxTXJJUm1iVmJXYjRFRTlS?=
 =?iso-2022-jp?B?aVgyT0hFUDJGV29ycnBBS3BUMVdGTVdEMWNpYUt1OGFNYjN5OUU2UzVw?=
 =?iso-2022-jp?B?OEVFM1lUbEEyT0YwTVhRV1N1RHV0YkZEbUtYSXhrUmhVME5GNCtNYUlW?=
 =?iso-2022-jp?B?cHB2cnlBaWNTU1VqbzZ6ZGt2c2V1WTN6ZUpCV2xlSG1lOVFOY25ESC83?=
 =?iso-2022-jp?B?OXFPeks1bE9pOWE4UFEySTdPTEREcWRKOC9tMzhmcGFPQTBhUzFVaEpD?=
 =?iso-2022-jp?B?L01rZnIxeHBpNG1EV3BTQytoVmprZVM4SFQ0em5vU1U0bERWQkN0amQ1?=
 =?iso-2022-jp?B?UktlQ2Rua1ZYZUtzb0JGMmRpOXFML1lybndwalRtTlRUMVB0a3FLcm5M?=
 =?iso-2022-jp?B?RHFXMFM0enFqczhtQlRvVGc2U1Uwczcza0w2UTdSd1phTEQveEtSVWNW?=
 =?iso-2022-jp?B?VmxWKytRWUNUbFQyWGZKMmtkL2FyUEhNd2wvYSsxbW1QQWU2dGJOS29r?=
 =?iso-2022-jp?B?cCtFa2ttcGJPRG1IZERHbUMwZllwdVlGenpVc1ZwRVlqU09WMkw2SmxW?=
 =?iso-2022-jp?B?Tk96RFBrRmdrMVdXeEJmZm9oemt0aXJsUkJySG9TYnFkRCs4TXJvRnhu?=
 =?iso-2022-jp?B?VHUrQ3Vsc2YrU3Qxb0lESGg0SEZIR013Yyt2dFpJVjVoRlRrV1RPZkJD?=
 =?iso-2022-jp?B?K2JrSjl1T2cvVkF2aHUrVTI5blo5ejg3Sjk4eWNMZzRjckZVU3NIZWpz?=
 =?iso-2022-jp?B?aEk2MmlUNlRXSGdaZVR1ZW9iY0xDZEF6MHJZWVlaYkFWSEM0cTlDRzVo?=
 =?iso-2022-jp?B?ODZReEhKSGQ2Zm5vMm9vNE9GN2Rkdm9HMjJaVndUWjdjaW1NUFZncEZz?=
 =?iso-2022-jp?B?aWlsVFlOc0dQZmtwVDZUVzd6VHR0d3Q3MFE4OTh6OWRPNG5SaFVQd01J?=
 =?iso-2022-jp?B?TE5SQktVSU9ZaG82QUVBUkxDSHQrR25rYWYrTThhRVN4cmFDV1hZOHdD?=
 =?iso-2022-jp?B?ZVl1Z0M2MDdQM1pNMkFoc1Qxck5QeGZvUUd5Z2ljRzBxQUM4OXZvZXBp?=
 =?iso-2022-jp?B?amVwVmF4T0FZYjIzU2Fuc2MwVm9TdnEwaWI5dXRpc0E3UERoS01wRE8y?=
 =?iso-2022-jp?B?WjZmRFRGbEdFWThHazdvOVozTld2MkhKM2xtNXFxRWFKRjZuMTZ5cXUv?=
 =?iso-2022-jp?B?bE56VkpadTFCdVlBTVhYbHpQaENZZGw2Vm1wM0tOeDVJWUlMcFhha2Ew?=
 =?iso-2022-jp?B?bDUxNEN3Ly9ad2VqUkgzQjUxbzVSMFVrMEJRa2p2TDBHNnAzVUh5SWxq?=
 =?iso-2022-jp?B?QitTTkYzZlN4Y1NIZEluMFR5TkhJbkpIY1M3dVZ6SEplSmtVc2s0aFM4?=
 =?iso-2022-jp?B?Mm1mNitoU01TV01yRFRZTWdkM004bXJCVlVUZUpLS0ltMzlYNVdyQzFO?=
 =?iso-2022-jp?B?TGY5eUpSaXVwN2t0L2pTdHBvOVVhNEJTN2VRVDZsNHBWOVk0WXRRa1h5?=
 =?iso-2022-jp?B?dkNJR2xaSTR6aHErY29iNmRrNDRqeFhLYnpLU00rMlJaSERsSEk0T0dN?=
 =?iso-2022-jp?B?MTZwZUlGRDFDbmNNV1NUMVNOcGhTSnZkcmZJelZ2QWtrRTRnNUxSaHIz?=
 =?iso-2022-jp?B?dC81emR1U2hjYlZLS3NHYTBpVUdyVTRJTVVEVGhhM29DQ1VtaTJzc3RS?=
 =?iso-2022-jp?B?T3c4PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?US9IdGU1aDIyNGNNSlNmZ0p3L1RXcGdTTWZCSmM0cGorbWlxVCtOQmsw?=
 =?iso-2022-jp?B?TmJsOVdxVk4yOERyOXhjQ0JNa3lGN05FdDZ4dVpTSVJPSHpZZ1NYYkhU?=
 =?iso-2022-jp?B?V1N2QUs5Rnd1eHdQNDFQdnBWT2pubHVCNVNRN2tVdzN4bllhN2FnamMw?=
 =?iso-2022-jp?B?WUF0MTV1VGJFTkJRN1FGTVhZSVdGeE02b2ZsSDZ3OUdkTkMvVzBxNnIr?=
 =?iso-2022-jp?B?RkpWaGF1cFFNNlRNSktTUGhmVW1CWmNEZjgrY3lLbHFCaGhxSzB4cmlM?=
 =?iso-2022-jp?B?QnBGOHRJQnM1K2paY2R6aWNLakFDYzBnZ3d5ZnFRRnNKdlVpcnRJTDl4?=
 =?iso-2022-jp?B?Q1A3TFM5cU40MTZ5ajYrVVkxeGtjeUF6ZXJFdFBZcmVsOWN2aDY1UnlJ?=
 =?iso-2022-jp?B?cGYxQTlIQWJ6Y3RHZlRCNmFhaUQ0bTNUQkVzejZYVC80akxwc0hjbTlj?=
 =?iso-2022-jp?B?T1Y3ZDBQRHowTS9MWmJpWUVXeHA4S2xLMXVYOW10aEpuZ051UGV3MkdG?=
 =?iso-2022-jp?B?alpsay9tRVRGcEZmd3l4OGJzcTRzWFpSSWVWWjByUUp5VnNHNzlZZEZq?=
 =?iso-2022-jp?B?SUtwV2hDS2Urc1ZWQ0s0YmNoN1R4N01xM0oxVjNjNlpYelJCK090NE5G?=
 =?iso-2022-jp?B?L1JPRm4vUmRQM1hmMWFYUDJMNWM4RjY5Q0RZbUxJT2ZhRXJPUTIrTkFt?=
 =?iso-2022-jp?B?NzZjMzJERkU1RFNRcEZOVlhoZHVnNEZ3blNFNWlRV0JvaCtuMVErbHFU?=
 =?iso-2022-jp?B?WDYzekMyR2xwTzcxejBkb2g0QWRUaWxWeTJGbFRZaTlGYzZSeXNkNkl1?=
 =?iso-2022-jp?B?OGJCT1VYc01RWFJYWStnT2NpQjhpeGZ0YmIvaDdta1FnV0JUN3RMOS9m?=
 =?iso-2022-jp?B?VXdnZkR2Q1pFMjlLR3hHKzNlMWhSelZqekNQaW1hR2JVbVZ6OVFpSysv?=
 =?iso-2022-jp?B?M1VKclFJU0sxK3h5OHJSdWFiRkl2RUlJZittQ2JWWDJiNlB5Z0VOVDBx?=
 =?iso-2022-jp?B?ZUNxZkt4aktNek9TcEZsVmZMdndxd014V3NuTUx5cjNGR0lYY2dsSmUz?=
 =?iso-2022-jp?B?cFN3clI2NzV1aEJHZVExclBTaTZwM1JYOFR5bmFqT2hDRjNhaE8vTlZh?=
 =?iso-2022-jp?B?ZzNLRzIzY3pDQTdWTWJWMUxtNm8xblQrSWo0RUN1ZGp5OUVjNkhVWlYy?=
 =?iso-2022-jp?B?UDhrbUZ5dmVOVUM5Yi8zT3JhckxnbXZUb0hJWStLUTI4dFRtdHAxRkp3?=
 =?iso-2022-jp?B?bkJWcjAxOXFXaitLQjZjbUtxS1hrSTBkaXF6YkMvVTczVGl0UFladEVu?=
 =?iso-2022-jp?B?TVpEenNQbEZjZTUyM3NvaEZSMjdTZndHNTYzNjVYN2hIV0RaQlVRSjBz?=
 =?iso-2022-jp?B?TG1MYVYyN3dTQTJPS2F5c0dJVGIwYTVGd2pOREU0UXNVWVhyVi9HSUNS?=
 =?iso-2022-jp?B?dHAybWdmL2pPRW8vOWFHWnlwa3FMYkdzdnpXRHNUUDJqWWlFTGxNVVc5?=
 =?iso-2022-jp?B?MUFkNjV4TnB3ekI2OXE4cXZnbWprVWJ0cXhKcW1MTTlVdVloMlh2b0g0?=
 =?iso-2022-jp?B?OW9SQzJEVlBVN1hlZkVPR1c2aXpaTjFoRTlxcjA2NkV6bXRxVDNFKzBD?=
 =?iso-2022-jp?B?UGtPaHVRL3VVSXJQUTZCUS80ZkYzSGs1Rlg2ZlB0RWRwdU5ocndLRitY?=
 =?iso-2022-jp?B?aFRPaGNPNlZ6SFRLVW8rZG4xL0tyckErbGV2WFlTeGwwV28yS2pUVTUw?=
 =?iso-2022-jp?B?dzZYODE1UGg2bkRNd0o3U3JoTi9iRDEyZ2NndTljZ2d1VmFlNmhSNXpx?=
 =?iso-2022-jp?B?V256TFFXb2JEbHpGNVY5T0liRXdzSHlCTlJOL1E1NVcyWGh4VmErck5T?=
 =?iso-2022-jp?B?dzM0WXlHRFFTUjVpaWxXZ1VieFovdktxWGhYaG5aeUJOZ0MzSStWMlBL?=
 =?iso-2022-jp?B?K1doa0Rwdm9PN0RpYm5uRSsrWmRuVHBZdkRMWjNmM2ZXdEVHRC95QnNy?=
 =?iso-2022-jp?B?Uy9uNnJIS1l0KzRETlRaZDl1cHh1UnBIbFU1Tld2dU9PcHJjYmxWM2pB?=
 =?iso-2022-jp?B?N2pEODhZSm9mcmh5Y2ZXOTZwV053SDZXYXQveTV3WDJhMzN4WWs2S3pt?=
 =?iso-2022-jp?B?aGtDZWUvRlRoMWtUQmFLVi9xWktUcnUyQWxaNkg0N1dkQXZ4VFFrVHZZ?=
 =?iso-2022-jp?B?Nk40SG1ybzFydjFpNWpWZWZLY1J4MmJnNFVDeThrOElOdXJHSEI3d2tB?=
 =?iso-2022-jp?B?SkhIOXZSMDZYUlh1c2w2R0xrY2JUOUgrN0VaaGtHUXFKbUpQc2dTQmV1?=
 =?iso-2022-jp?B?YW1WbXE3clNHbUNKNEtxaWxGT1NnSzAxUUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05452fcb-f771-4ae3-99e3-08dda3e1aa0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 03:32:57.1876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TdxfNToPJpTjqJdnWLD3zqx4DDkSboCEFNZXK6f7vtrwMuqBR5AZ7Ok+Gv6fTWWOK6BkkCb0T73hX+mAdNqUzkMbsaOhmnCL4r1JGrDyM3C3ka7If0zeQhPJrOag9/yc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6428
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Jun 2025 03:33:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19018

Hi all,

CIP kernel team has released Linux kernel v6.12.32-cip2.
The linux-6.12.y-cip tree has been updated base version from v6.12.29 to v6=
.12.32.
This release includes SCIF updates for Renesas ARM SoCs.

You can get this release via the git tree at:

  v6.12.32-cip2:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      0645c849aadd029e3382b5ab5dd785b2007cd9bf
    fixed CVEs:
      CVE-2025-37967: usb: typec: ucsi: displayport: Fix deadlock
      CVE-2025-37968: iio: light: opt3001: fix deadlock due to concurrent f=
lag access
      CVE-2025-22102: Bluetooth: btnxpuart: Fix kernel panic during FW rele=
ase
      CVE-2025-2312: cifs-utils: cifs.upcall makes an upcall to the wrong n=
amespace in containerized environments
      CVE-2025-37992: net_sched: Flush gso_skb list too during ->change()
    added commits:
      CIP: Bump version suffix to -cip2 after merge from stable
      arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1
      arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
      arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe d=
ifferent switches
      arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
      serial: sh-sci: Save and restore more registers
      serial: sh-sci: Update the suspend/resume support
      clk: renesas: r9a08g045: Add clock, reset and power domain for the re=
maining SCIFs

Best regards,
  Nobuhiro



