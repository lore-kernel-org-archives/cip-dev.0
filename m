Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E3AD609D6
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 11:12:29 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.24])
 by mx.groups.io with SMTP id smtpd.web10.69546.1732705944374524720
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Nov 2024 03:12:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=RYbxm6/3;
 spf=pass (domain: renesas.com, ip: 40.107.74.24, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9IZnqa9Oy/bf1h4y1vXgBU/mbuwIGin889fUSk1upREmZNhdVQHFG3r/bfCR6JbnO9BWM1mm/jvBzJvj5VFjyVjHwhJMev4CBf447e9NWP5SmYT0zHfzRbs7hGRbJeRnx7K0pcDrHSkkHNXxI/ZZvaeNL2EgZpbBenlXziilz6BGEOJf7AWshlThniv/AjuTm55oM/CTYZ8AlS+3eoUFOmJeVVrSYxhqu61B3FW/NKfpN39LeDmIuTFuDUQKGA5bGWN2vEbxAULZzvSz3lmm1Ih1acQrDim9vJAMP+QgixHGUIAIVRL8j9AZPcq+9kDC8sFCfZiydqsnvLVm4LFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ly7bReGL+0NjLylvGewuC0UwkMlN8ni87BbcTWPyaEo=;
 b=etCTJsHLuTUZ2PGtnibgiIgfZTRZgnTlbTq06Fe3rNwnb5yq+qyqaWq6q32qdZjC606YfTghpWh+NcZJOXIzrYFiezopl2r7c7Wb79Rn/EsKFVaZuWO9puBCgK/qm0RfXYm6TO9qmvkX8oEpRYYKgoyJhQ0034blL+RV9p6KIKVI/hvBhjjepROKXnnzlynU8SxT+I5ci/6EdGOH84Yqyca4NZRvJOhhjqyFYi2AseMhuN22a5S0da7uD+trC/Pf7NpTHanh38eBnX3oa8btQ5I0VgBAxyKNpAqr4CP3QmwQEbyXMiMgpcaYxuFFg870srtL8/hZ8NdZGlgfdm2vrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ly7bReGL+0NjLylvGewuC0UwkMlN8ni87BbcTWPyaEo=;
 b=RYbxm6/3TWYiZ42LcLlD0y2oCLhPKV5ykRRNslpEBBzNuuqyqmjZklucu5xPD62Dk0h6l49A7E91irwh/rwvp21xinfjJSlHvB22TjDG+yk67rh0vXrvVRuQO4ebBfYXcWQBqS0yvLomYjiQOFNln1M9qFdBjmKyceoclcnJq+4=
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com (2603:1096:405:f7::12)
 by TYWPR01MB10807.jpnprd01.prod.outlook.com (2603:1096:400:2a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 11:12:18 +0000
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87]) by TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 11:12:18 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>
CC: "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-security] [cip-dev] Manually run Kernel and IEC tests on
 M-COM x86 and generate results
Thread-Topic: [cip-security] [cip-dev] Manually run Kernel and IEC tests on
 M-COM x86 and generate results
Thread-Index: 
 AQHbNLcv3vC8deZB0Ua07zkQ6b5nXrKzrb4QgASohfaACXHRW4AGb/wQgADAbziAAhgG8A==
Date: Wed, 27 Nov 2024 11:12:18 +0000
Message-ID: 
 <TYYPR01MB1240272631FDD5B23D4725D37B7282@TYYPR01MB12402.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AC4F03F328776A6DFBCBC2592@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB1240281691D569EB3FFF1BF46B7592@TYYPR01MB12402.jpnprd01.prod.outlook.com>
 <1808283AFE02050D.20097@lists.cip-project.org>
 <OS3PR01MB6103A8419829A8FDDCC767FDC2222@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB124029C5A19C30B588BCFB6DFB72E2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
 <OS3PR01MB61038562D6A34A0313834A60C22F2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB61038562D6A34A0313834A60C22F2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB12402:EE_|TYWPR01MB10807:EE_
x-ms-office365-filtering-correlation-id: 36739c5c-eb5d-429c-b757-08dd0ed45b49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|4022899009|376014|1800799024|366016|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?ks_c_5601-1987?B?Z1MydXhoSllpUmdjVVFSampJZUxhMVFVcy85Zk8zMlhnWTRDU1FY?=
 =?ks_c_5601-1987?B?S0tuVHgxR3BqUERWcjkzbHVrS1RWR3RIOHY5YU9DYUp4b2M4aVcv?=
 =?ks_c_5601-1987?B?VUszM25hTnczOXh2bEU5L3RBMVhQa0NSWFZJZGFaeTA2SGwvSExK?=
 =?ks_c_5601-1987?B?UWNhNjRWL3diVGhNaFl6eExlalczcjJTQm9DaVNTV2VhelR2TzEw?=
 =?ks_c_5601-1987?B?OTEvNzNIRm5HSml2UHc4eWxxQnNZRVVOUm9oaE5JK1FUOVI5RnFO?=
 =?ks_c_5601-1987?B?eVY0b1lDWDBkUHV1c1BBYUZuSFU4TnpkMjN2NnhaQ0N5alk0VC9V?=
 =?ks_c_5601-1987?B?Y25NV2k4WXZWR0RXYUNDUExNVHlIUEFqSXRWeVV5ZVo3cFZxQ1Ex?=
 =?ks_c_5601-1987?B?ZnYwejJDTkR3OVlXeHVkNWtGMnJTNjl6STlBVlBGSGtHM2ptTWgv?=
 =?ks_c_5601-1987?B?S1BuUmIrdCs1c3N6c2NtazBBYi9FS1Y0cjVLNHlDeU5Sb0FnRnpS?=
 =?ks_c_5601-1987?B?L1NVUVpGOTVmVjRiTEJUaFVHNmNQdW9pWi9FdDkwelhldEVjNkVL?=
 =?ks_c_5601-1987?B?Vm5vZnJNTXV1ZGRGSlFlRmtYTVh5S3ROWWpFQ1VSVE1lc3Z2YTZt?=
 =?ks_c_5601-1987?B?dzY1TVU4WUFLaVVYd1FIOHlFekFuOHQybWgyMUp5NlJnRGhXVWdx?=
 =?ks_c_5601-1987?B?V2dSN0FLSCtSVEd6ZDZoVndCaEwrUEQ1bzlsWW1lRUxEeXNFcTU3?=
 =?ks_c_5601-1987?B?ckRTbkVickdsYnNIbUs5bnRlRVdSNDZtM09YWmhGaUpjRmpKcU1Z?=
 =?ks_c_5601-1987?B?SkxhZ1NJR08wS3lBRXE0Z0t3cUMwUGJxMyttQmxUNWNuM3NXa3NY?=
 =?ks_c_5601-1987?B?MEpBZHBoZ21oT0g5cS83dytnbEdqQnZYUWZGL0ViQWJVNkx5V3do?=
 =?ks_c_5601-1987?B?ejc0bVBBbk95Yi9xeWJla2RtNEU0bkhZSU9QVzRpU3RoYnN3SXh2?=
 =?ks_c_5601-1987?B?TFRGWDVvUmtFQjhvdnpLM2IvOEkrK2p5NDdtL3V4U0FCcjZtWVRh?=
 =?ks_c_5601-1987?B?YmVtbTNIZElTclVQZUFFTHgwbUtRODZVYUJ6VlRkZWFjTEhRajhu?=
 =?ks_c_5601-1987?B?cDN6Q2RvTVRjNmhsNlB5NTMxZy9TTkZUVThnT3NKbE50NDdLNDd3?=
 =?ks_c_5601-1987?B?bklLOTN3ZWZnbUU0Uk94ZytHS0ZkckQ1bkpxTnU1RFVjRitadXUx?=
 =?ks_c_5601-1987?B?eHRtM1krSzFBS0l3cGpUOVNaVlRHNm1Id2huV056ZWN1VWhyaHBq?=
 =?ks_c_5601-1987?B?MFhEQjUxNk5HMjM2Z21iUHpyNmlSTEM2N1dWY1ljcHhyaWZHVTN4?=
 =?ks_c_5601-1987?B?OHY2TXUvcnA3NHZubVo3RUFybFVHbExsNGF1UWhOSlA0NEdmRWF5?=
 =?ks_c_5601-1987?B?S1pnWURnQW9LdHpjT1dxYWpBNHVUSDNkNTNPbmovekRXckRFeDRn?=
 =?ks_c_5601-1987?B?MFUyUExDbDAvK2VBSWoxWFVMY1RVdlJocXRvRldnT0ZIY3BUMmpO?=
 =?ks_c_5601-1987?B?RHdIRkNzVmticXdrb1JuU3FIR1JlU2Z3aExtbEdOeE1td01RS3dw?=
 =?ks_c_5601-1987?B?Qm13YTNZTlhVbHcrNVFHUzdMcjZRNkVqRmN6dVp3WDU0cjIwd1E5?=
 =?ks_c_5601-1987?B?cXRCWTY1Rm5ZeVozWElib25IcmhWV0xCNE1kSVRaanVZUkY4Y2Ns?=
 =?ks_c_5601-1987?B?cFI4OVRkUnA1TFh1aTBnRENzZGRNZzNzRnBDODNEYWg2eVprWmtS?=
 =?ks_c_5601-1987?B?ZTEyNThhNU81aFVYQjZXODFHMFhxSjhsZGxxbDNjZFY3Y3ovV3BW?=
 =?ks_c_5601-1987?B?RkVoaHJyOEc1WXdSTU96emZJT1NvV3BlNzdTWDJqRVdNMzlaUDF1?=
 =?ks_c_5601-1987?B?aVlPQkpHYlJkODA5aGZ1dVlpSVAzVDVoMkVUTmRISjVEY2ZvT3hW?=
 =?ks_c_5601-1987?B?Y1JqeEE0MGdVbG5GZG9RV20yZXY2TnVsSm9CTmFjaDRmMUJmRVVz?=
 =?ks_c_5601-1987?B?TU1TcmU4bFNiZDMvUWxMU0F1dTRJbk1ERWd6S1NJMkdEaUY1L3Bi?=
 =?ks_c_5601-1987?Q?M9OPAm24dOFFk/FuSXmU8w=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB12402.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(1800799024)(366016)(8096899003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?ks_c_5601-1987?B?c21kVFpaY3FjZkU4dEhwZjZPUEJReVBvUDAvekpMbEhCZUdabzA4?=
 =?ks_c_5601-1987?B?clpuMjh3cnhvK0xYaXVtTEhoWjJXeHZySkVycUFRRFZlMDVObjdM?=
 =?ks_c_5601-1987?B?SGJlczY1NWhQaC9RSm56UUNIcnQzZ3hDL05NYW9XZjVsR2FPeWRo?=
 =?ks_c_5601-1987?B?VUd0WnJrcml4Z010ZFIzUHJkVi8xekM2OWN0NkJNRjdBd09MOFpo?=
 =?ks_c_5601-1987?B?VE9WSzZMRkt5bUREblJRODhteVA2RTluOXNhNFZ3SDVJSlhqYUxx?=
 =?ks_c_5601-1987?B?S3lNRGNlMEFrSVZQYWZHVEJYZXNUaTY2WE4wdU1leFVkOERReVJK?=
 =?ks_c_5601-1987?B?Y1poZ2EzV2F2b0sraWdmMkNpZGphLzNmWG42TVhxMTJXQWtSSGJX?=
 =?ks_c_5601-1987?B?b1dqcXB5SCtsUnFxVkY5Um96VVBsREk2cEpZdVRzR2E1dW4yKzla?=
 =?ks_c_5601-1987?B?TitTSE42OEc3WVFsVzM0MVl2eEtEZE9NVDhlQnExYnVhcUhPMnl2?=
 =?ks_c_5601-1987?B?dFFtTzZiM3c4d2FLRUFCYTNkN1NQTFhNWFdzZnN6MkZ5L2RUeXFm?=
 =?ks_c_5601-1987?B?WjZ2a2FTYlFlNU9WcWpUdURSU3NWMGNNdVd1NnhQRGVMeDA0cUN5?=
 =?ks_c_5601-1987?B?OW9SclFFa1FkcFQ3SUJuY3FCdWxUb3NvZExPLzVZZmRCdG1LVzQx?=
 =?ks_c_5601-1987?B?eVZuNW5rUEdUcWJoQjE2SVlleDRsdFlqUm0wLy9TUy9uTHNiSjlq?=
 =?ks_c_5601-1987?B?UWZoN3VtRHZMNmlGRGxVbUpwQnA3dDBmSHYvQVgyZmR1Vi9pNWpn?=
 =?ks_c_5601-1987?B?UHVSM0dESjUyd3JhTXczaW9KRHhkcTFtdElpNFBhYWtpY1NQOFBS?=
 =?ks_c_5601-1987?B?UzBmaXY2c0FmdTlITGNPbXp3aVNSYU1QRkcyNzRYVHVObDZCMFZ1?=
 =?ks_c_5601-1987?B?b0ZHZngvdS8ySlB1YjZkVkhZYWc5czhHbDhkTEhldGFBdnV5M1BF?=
 =?ks_c_5601-1987?B?Ni9hWVZXdE5za2JHdFc1eGhMS3gxamZUSGVPV2ZOOTgzVTlpNUFX?=
 =?ks_c_5601-1987?B?WHhPLzBidEUxOVFoSVY1bDltbFBkNjJvakFGbFpHMlpWeWdrcVdS?=
 =?ks_c_5601-1987?B?M0hmVmV5YnFFbUp2Ny9HRmZibDBtcER4YkJNQ1JpTWdtM3BhQ1Vl?=
 =?ks_c_5601-1987?B?NkVrbHFHS2RHNEVwelRYRk0yckNPWEM2K1plckxmblRNdzBsdWlC?=
 =?ks_c_5601-1987?B?TnVvUVB0MDVSWUNiYURwZHR4dzFoS0JkOHhKODdKUVVSalhzODRJ?=
 =?ks_c_5601-1987?B?RnFHUHFmclUyU3dpV1UrUVc4YTR0Y0F1bUJNUFNSdXNoZTl4MEsz?=
 =?ks_c_5601-1987?B?dUVtWE82SXlXSS81UXpyV0hpNDJIaWs2Z1dEUWxUQXVFdjlZaU9K?=
 =?ks_c_5601-1987?B?bUgvNHFwV1hLd2h5SGhRTUl0NmxNYUFqLy9ieFRMQ2ljWWhja0JO?=
 =?ks_c_5601-1987?B?QnBBK25TdG1ZS3lYRUN6SThWWnA0Z3FTaGk1L0pWa0dvcS81VWJG?=
 =?ks_c_5601-1987?B?SFhVTlowRWJuNTdhYVhHdFVxU3pQZzliVW1EYi9hS2V4cVVMT1JU?=
 =?ks_c_5601-1987?B?dXpOY0tTUnA2ZWJUOFU5ZHgveWhZOUt3bFM0ODRIVEtoNisrY0dR?=
 =?ks_c_5601-1987?B?bXJJd3BHNFh1SGV5L2VWSVBzWSt4bFR4SUdFMjdGbWlrc2M5K1No?=
 =?ks_c_5601-1987?B?bDh0MzU1T3p6c3RkOVFWSUxCSkk5THpNM0pMWVNOR2ZTeEphek40?=
 =?ks_c_5601-1987?B?TGZxZWRqUnNZaUNPNmVhSVp6S041enBiNEJpaEdhK0JRRTRqTlRI?=
 =?ks_c_5601-1987?B?Sm9MVngwRCtJaVd0ZzM5M2ZuU3JUeVlGRkNDeHdsMFRKRnl5azd5?=
 =?ks_c_5601-1987?B?V2tZV0txcjRtRStZSWQ2b3hRenpPWVo2LzQrcTRFdXdaaDhTcXNv?=
 =?ks_c_5601-1987?B?NHQvc1NzOEpuTGJuMjhFRVhvelMrdUs4aFFJV25JMjVwbWZDMVN4?=
 =?ks_c_5601-1987?B?UjQrUWlSVTMrek1uWlNnWURoRU5QSG9wcmNCWVVJMk9pSDBIMmlR?=
 =?ks_c_5601-1987?B?Z3huK21PWHUxa0dGaFVya3FJblNqRTVtd1JvWFgxMmg1dnZFaXZs?=
 =?ks_c_5601-1987?B?TTFycW1reFNOMU1wdFVHVGNvRFowY3RDNURSbk1SWDRJV1M3aVRS?=
 =?ks_c_5601-1987?B?WkI0Wk9hZ2t2UHlpbGptNjd0REtnZDFBYm84K3h2UVhYMzNIMGgz?=
 =?ks_c_5601-1987?B?N3VpczZjM1BtTkt1WHJnUkowQmQyVnFtR2l4czROS0ZNUFBTTm9m?=
 =?ks_c_5601-1987?B?RWRKU0FTbXFNeTQ3NlNTM2VqMFNsZGlTM29qa2swSjJlVitudnZC?=
 =?ks_c_5601-1987?B?MU05dUEvYVdVMm1WTDBuampaUlFkYWhDWW5uNE82ZjN4WXM0Yjhr?=
 =?ks_c_5601-1987?B?WDFraHlFSnhBT3ZmU1F0SDErRnZTT1E9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYYPR01MB1240272631FDD5B23D4725D37B7282TYYPR01MB12402jp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB12402.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36739c5c-eb5d-429c-b757-08dd0ed45b49
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 11:12:18.3615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0I3oFLkp1XuxOa21OzcwhCjMuwc3p2jEejRQI/dn8a0IH5SNvivNaArH3UsE1mMfFWrLyQPwS5kxV1EtchTSlKBYIDjqHw5wY4s+syZcexM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10807
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Nov 2024 11:12:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17288

--_000_TYYPR01MB1240272631FDD5B23D4725D37B7282TYYPR01MB12402jp_
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64

SGVsbG8gU2FpLA0KDQpUaGFuayB5b3UgZm9yIHRoZSB1cGRhdGUuDQpXaWxsIHlvdXIgaXNhci1j
aXAtY29yZSBicmFuY2ggYmUgc3RheWluZz8gT3Igd2lsbCBpdCBiZSBtZXJnZWQgaW50byB0aGUg
bWFpbiBicmFuY2g/DQoNCldlIHRoZW4gY2FuIGdldCBsaW51eC1jaXAtY2kgdXBkYXRlZCB0byBh
ZGQgc3VwcG9ydCB0byB1c2UgdGhlIHJvb3RmcyB3aXRoIExUUCB0ZXN0cyBmb3IgdGhlIG1jb20g
ZGV2aWNlLCBhbmQgdGhlbiB1cGRhdGUgb3VyIGNpIHBpcGVsaW5lcyBhY2NvcmRpbmdseS4NCg0K
S2luZCByZWdhcmRzLCBDaHJpcw0KDQpGcm9tOiBjaXAtc2VjdXJpdHlAbGlzdHMuY2lwLXByb2pl
Y3Qub3JnIDxjaXAtc2VjdXJpdHlAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbiBCZWhhbGYgT2Yg
c2FpIGFzaHJpdGggc2F0aHVqb2RhIHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcNClNlbnQ6IDI2
IE5vdmVtYmVyIDIwMjQgMDM6MTgNClRvOiBDaHJpcyBQYXRlcnNvbiA8Q2hyaXMuUGF0ZXJzb24y
QHJlbmVzYXMuY29tPg0KQ2M6IGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA7IGRpbmVz
aC5rdW1hckB0b3NoaWJhLXRzaXAuY29tOyBjaXAtc2VjdXJpdHlAbGlzdHMuY2lwLXByb2plY3Qu
b3JnOyBub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcDsgY2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmcNClN1YmplY3Q6IFJlOiBbY2lwLXNlY3VyaXR5XSBbY2lwLWRldl0gTWFudWFs
bHkgcnVuIEtlcm5lbCBhbmQgSUVDIHRlc3RzIG9uIE0tQ09NIHg4NiBhbmQgZ2VuZXJhdGUgcmVz
dWx0cw0KDQpIZWxsbyBDaHJpcywNCg0KSG9wZSB5b3UgYXJlIGRvaW5nIHdlbGwuDQoNCkkgaGF2
ZSBjcmVhdGVkIGEgY3VzdG9tIGJyYW5jaCBpbiBpc2FyLWNpcC1jb3JlIGZyb20gd2hpY2ggSSBj
cmVhdGVkIGEgeDg2IGdlbmVyaWMgdWVmaSByb290ZnMgdGFyYmFsbCB3aXRoIExUUCBiaW5hcnkg
aW5zdGFsbGVkLCBodHRwczovL3MzLWV1LWNlbnRyYWwtMS5hbWF6b25hd3MuY29tL2Rvd25sb2Fk
Mi5jaXAtcHJvamVjdC5vcmcvY2lwLWNvcmUvc2FpLWRlcGxveS14ODZ1ZWZpLXJvb3Rmcy1sdHAv
eDg2LXVlZmkvY2lwLWNvcmUtaW1hZ2UtY2lwLWNvcmUtYm9va3dvcm0teDg2LXVlZmktdGVzdC50
YXIuZ3oNCg0KSSByYW4gTFRQIHRlc3RzIG9uIE0tQ09NIG9uIExBVkEgZm9yIDYuMS4xMTUtY2lw
MzEuDQoNClBsZWFzZSBoYXZlIGEgbG9vayBhdCB0aGUgbGlzdCBvZiBqb2JzIHJhbiByZWNlbnRs
eSBvbiBNLUNPTSBMQVZBIHwgU2NoZWR1bGVyIHwgRGV2aWNlIFR5cGVzIHwgeDg2LXNpZW1lbnMt
bWNvbTxodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2RldmljZV90eXBlL3g4
Ni1zaWVtZW5zLW1jb20+DQoNClRoYW5rcyBhbmQgcmVnYXJkcywNClNhaSBBc2hyaXRoIChUIFMg
SSBQKQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KRnJvbTogQ2hyaXMgUGF0
ZXJzb24gPENocmlzLlBhdGVyc29uMkByZW5lc2FzLmNvbTxtYWlsdG86Q2hyaXMuUGF0ZXJzb24y
QHJlbmVzYXMuY29tPj4NClNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMjUsIDIwMjQgOToxNyBQTQ0K
VG86IGFzaHJpdGggc2FpKKPUo9OjyaPQKSA8U2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29t
PG1haWx0bzpTYWkuU2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb20+Pg0KQ2M6IGhheWFzaGkga2F6
dWhpcm8o1/kg+/rO2yCjxKPNo8UgodujxKPJo8eh4KPNo9Cj06Hbo82j0KO0KSA8a2F6dWhpcm8z
LmhheWFzaGlAdG9zaGliYS5jby5qcDxtYWlsdG86a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5j
by5qcD4+OyBkaW5lc2gga3VtYXIoo9Sj06PJo9AgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gu
a3VtYXJAdG9zaGliYS10c2lwLmNvbTxtYWlsdG86ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5j
b20+PjsgY2lwLXNlY3VyaXR5QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzxtYWlsdG86Y2lwLXNlY3Vy
aXR5QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gPGNpcC1zZWN1cml0eUBsaXN0cy5jaXAtcHJvamVj
dC5vcmc8bWFpbHRvOmNpcC1zZWN1cml0eUBsaXN0cy5jaXAtcHJvamVjdC5vcmc+PjsgaXdhbWF0
c3Ugbm9idWhpcm8o5Nvh5iDj4eXHIKHbo8SjyaPUo8Oh4KPEo8mj1KHbo8+j06PUKSA8bm9idWhp
cm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA8bWFpbHRvOm5vYnVoaXJvMS5pd2FtYXRzdUB0b3No
aWJhLmNvLmpwPj47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPG1haWx0bzpjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPG1h
aWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4+DQpTdWJqZWN0OiBSRTogW2NpcC1k
ZXZdIE1hbnVhbGx5IHJ1biBLZXJuZWwgYW5kIElFQyB0ZXN0cyBvbiBNLUNPTSB4ODYgYW5kIGdl
bmVyYXRlIHJlc3VsdHMNCg0KDQpIZWxsbyBTYWksDQoNCg0KDQpBcG9sb2dpZXMgZm9yIHRoZSBz
bG93IHJlc3BvbnNlLg0KDQoNCg0KV2VsbCBkb25lIGZvciBnZXR0aW5nIHRoZSBMVFAgdGVzdHMg
cnVubmluZyBsb2NhbGx5Lg0KDQpJZiB5b3Ugc2VuZCBtZSB0aGUgdGFyYmFsbCBvciBsaW5rIG1l
IHRvIGl0IEkgY2FuIHVwbG9hZCBpdCB0byBTMyBmb3IgeW91Lg0KDQoNCg0KS2luZCByZWdhcmRz
LCBDaHJpcw0KDQoNCg0KRnJvbTogU2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPG1haWx0
bzpTYWkuU2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb20+IDxTYWkuU2F0aHVqb2RhQHRvc2hpYmEt
dHNpcC5jb208bWFpbHRvOlNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNvbT4+DQpTZW50OiAy
MSBOb3ZlbWJlciAyMDI0IDEzOjM4DQpUbzogQ2hyaXMgUGF0ZXJzb24gPENocmlzLlBhdGVyc29u
MkByZW5lc2FzLmNvbTxtYWlsdG86Q2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tPj4NCkNjOiBr
YXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPG1haWx0bzprYXp1aGlybzMuaGF5YXNoaUB0
b3NoaWJhLmNvLmpwPjsgZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb208bWFpbHRvOmRpbmVz
aC5rdW1hckB0b3NoaWJhLXRzaXAuY29tPjsgY2lwLXNlY3VyaXR5QGxpc3RzLmNpcC1wcm9qZWN0
Lm9yZzxtYWlsdG86Y2lwLXNlY3VyaXR5QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz47IG5vYnVoaXJv
MS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPG1haWx0bzpub2J1aGlybzEuaXdhbWF0c3VAdG9zaGli
YS5jby5qcD47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPG1haWx0bzpjaXAtZGV2QGxp
c3RzLmNpcC1wcm9qZWN0Lm9yZz4NClN1YmplY3Q6IFJlOiBbY2lwLWRldl0gTWFudWFsbHkgcnVu
IEtlcm5lbCBhbmQgSUVDIHRlc3RzIG9uIE0tQ09NIHg4NiBhbmQgZ2VuZXJhdGUgcmVzdWx0cw0K
DQoNCg0KSGVsbG8gQ2hyaXMsDQoNCg0KDQpIb3BlIHlvdSBhcmUgZG9pbmcgZ3JlYXQuDQoNCg0K
DQpUaGlzIGlzIGp1c3QgYW4gdXBkYXRlIHJlZ2FyZGluZyBteSBwcmV2aW91cyBxdWVyeSBpbiB0
aGlzIG1haWwgdGhyZWFkLg0KDQoNCg0KSSB3YXMgYWJsZSB0byBydW4gTFRQIG9uIHNlY3VyaXR5
IHRhcmdldCBpbiBteSBtYWNoaW5lIGFmdGVyIGluY2x1ZGluZyBrYXMvb3B0L3Rlc3QueW1sIKGk
IG1hc3RlciChpCBjaXAtcHJvamVjdCAvIGNpcC1jb3JlIC8gaXNhci1jaXAtY29yZSChpCBHaXRM
YWI8aHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUv
LS9ibG9iL21hc3Rlci9rYXMvb3B0L3Rlc3QueW1sP3JlZl90eXBlPWhlYWRzPiB3aGlsZSBidWls
ZGluZyB0aGUgaW1hZ2UgYXMgaXQgY29tZXMgYWxsIHRoZSBkZXBlbmRlbmNpZXMgcmVxdWlyZWQg
dG8gcnVuIHRoZW0uDQoNCg0KDQpGb3IgTEFWQSwgSSB3aWxsIHRyeSB0byB1cGxvYWQgYSByb290
ZnMgdGFyYmFsbCB0byBjaXAtcHJvamVjdCdzIFMzIHN0b3JhZ2Ugd2l0aCBidWlsZDp4ODYtdWVm
aS1iYXNlIGNvbmZpZ3VyYXRpb24gYWxvbmcgd2l0aCBleHRlbnNpb246IHRlc3QuIEkgaG9wZSBJ
IGNhbiBydW4gTFRQIHRlc3RzIG9uIE0tQ09NIHg4NiBvbiBMQVZBIHdpdGggdGhpcyBtZXRob2Qu
IEkgcmFuIFNNQyB0ZXN0cyBvbiBNLUNPTSB4ODYgd2l0aCA2LjEuMTEyLWNpcDMwIGtlcm5lbCAt
PiBodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvcmVzdWx0cy8xMjIyNjE2LzBfc3BlY3RyZS1t
ZWx0ZG93bi1jaGVja2VyLXRlc3QNCg0KDQoNClRoYW5rcyBhbmQgcmVnYXJkcy4NCg0KU2FpIEFz
aHJpdGgNCg0KDQoNCg0KDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0K
RnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1kZXZAbGlzdHMu
Y2lwLXByb2plY3Qub3JnPiA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNp
cC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPj4gb24gYmVoYWxmIG9mIHNhaS5zYXRodWpvZGFA
dG9zaGliYS10c2lwLmNvbTxtYWlsdG86c2FpLnNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPiA8
c2FpLnNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPG1haWx0bzpzYWkuc2F0aHVqb2RhQHRvc2hp
YmEtdHNpcC5jb20+Pg0KU2VudDogRnJpZGF5LCBOb3ZlbWJlciAxNSwgMjAyNCA3OjE0IFBNDQpU
bzogQ2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tPG1haWx0bzpDaHJpcy5QYXRlcnNvbjJAcmVu
ZXNhcy5jb20+IDxDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb208bWFpbHRvOkNocmlzLlBhdGVy
c29uMkByZW5lc2FzLmNvbT4+DQpDYzogaGF5YXNoaSBrYXp1aGlybyjX+SD7+s7bIKPEo82jxSCh
26PEo8mjx6Hgo82j0KPTodujzaPQo7QpIDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpw
PG1haWx0bzprYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPj47IGRpbmVzaCBrdW1hciij
1KPTo8mj0CBUTUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29t
PG1haWx0bzpkaW5lc2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT4+OyBjaXAtc2VjdXJpdHlAbGlz
dHMuY2lwLXByb2plY3Qub3JnPG1haWx0bzpjaXAtc2VjdXJpdHlAbGlzdHMuY2lwLXByb2plY3Qu
b3JnPiA8Y2lwLXNlY3VyaXR5QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzxtYWlsdG86Y2lwLXNlY3Vy
aXR5QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4+OyBpd2FtYXRzdSBub2J1aGlybyjk2+HmIOPh5ccg
odujxKPJo9Sjw6Hgo8SjyaPUodujz6PTo9QpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5j
by5qcDxtYWlsdG86bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+PjsgY2lwLWRldkBs
aXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3Jn
PiA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnPj4NClN1YmplY3Q6IFJlOiBbY2lwLWRldl0gTWFudWFsbHkgcnVuIEtlcm5l
bCBhbmQgSUVDIHRlc3RzIG9uIE0tQ09NIHg4NiBhbmQgZ2VuZXJhdGUgcmVzdWx0cw0KDQoNCg0K
SGVsbG8gQ2hyaXMsDQoNCg0KDQpIb3BlIHlvdSBhcmUgZG9pbmcgd2VsbC4NCg0KDQoNCkFmdGVy
IGdvaW5nIHRocm91Z2ggTGF2YSBqb2IgZGVmaW5pdGlvbnMgd2hlcmUgbHRwIHRlc3RzIGFyZSBy
dW4gb24gQ0lQIHJlZmVyZW5jZSBoYXJkd2FyZSBvbiBDSVAgTEFWQSwNCg0KDQoNCkkgbm90aWNl
ZCB0aGF0IGx0cCB0ZXN0cyBhcmUgYmVpbmcgbW9zdGx5IG9uOg0KDQoNCg0KcmVuZXNhc19yOGE3
NzQzLWl3ZzIwZC1xNw0KDQpyZW5lc2FzX3I4YTc3NGExLWhpaG9wZS1yemcybS1leA0KDQp4ODZf
Y2lwX3FlbXUNCg0KDQoNClVzaW5nIHJvb3RmcyB0YXJiYWxscyBzdWNoIGFzOg0KDQoNCg0KaHR0
cHM6Ly9zMy1ldS1jZW50cmFsLTEuYW1hem9uYXdzLmNvbS9kb3dubG9hZDIuY2lwLXByb2plY3Qu
b3JnL2NpcC10ZXN0aW5nL2xhdmEtaGVhbHRoY2hlY2tzL3Jmcy9jb3JlLWltYWdlLW1pbmltYWwt
cWVtdWFybTY0LWx0cC50YXIuYnoyDQoNCmh0dHBzOi8vczMtZXUtY2VudHJhbC0xLmFtYXpvbmF3
cy5jb20vZG93bmxvYWQyLmNpcC1wcm9qZWN0Lm9yZy9jaXAtdGVzdGluZy9sYXZhLWhlYWx0aGNo
ZWNrcy9yZnMvY29yZS1pbWFnZS1taW5pbWFsLXFlbXV4ODYtNjQtbHRwLmV4dDQueHoNCg0KDQoN
Ci4uYWxvbmcgd2l0aCByZXNwZWN0aXZlIGR0YiBmaWxlcy4NCg0KDQoNCkJ1dCBjdXJyZW50bHkg
bS1jb20gaGVhbHRoIGNoZWNrcyBhcmUgdXNpbmcgaHR0cHM6Ly9zMy11cy13ZXN0LTIuYW1hem9u
YXdzLmNvbS9kb3dubG9hZC5jaXAtcHJvamVjdC5vcmcvY2lwdGVzdGluZy9jaXAtbGF2YS9yZnMv
cm9vdGZzLXNpbWF0aWMtaXBjMjI3ZS50YXIuZ3ogcm9vdGZzLg0KDQoNCg0KSSB0cmllZCB0byB1
c2UgIFNLSVBfSU5TVEFMTDogImZhbHNlIiBpbiB0aGUgdGVzdCBkZWZpbml0aW9uIGJlY2F1c2Ug
bHRwIHRlc3QgY2FzZXMgYXJlIG5vdCBwcmVzZW50IGluIGV4cGVjdGVkIGZvbGRlcnMsIGV4OiAv
b3B0L2x0cCBhbmQgZGVwZW5kZW5jeSBwYWNrYWdlcyBhcyB3ZWxsIGV4cGVjdGluZyB0aGV5IHdp
bGwgYmUgaW5zdGFsbGVkIGluIHRoZSBpbWFnZSBhZnRlciBib290LiBCdXQgdGhlIGpvYiBmYWls
ZWQuIGh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIvam9iLzEyMjMxNDkjTDEz
MzkNCg0KDQoNCkkgcmVxdWVzdCB5b3UgdG8gaGVscCBtZSBpbiBwcmVwYXJpbmcgYSBzaW1hdGlj
LWlwYzIyN2Ugcm9vdGZzIHRhcmJhbGwgd2l0aCBsdHAgdGVzdHMgYW5kIHJlcXVpcmVkIHBhY2th
Z2VzIGFuZCBwdXNoaW5nIGNpcC1wcm9qZWN0IHMzIHN0b3JhZ2Ugc28gdGhhdCBJIGNhbiBydW4g
bHRwIHRlc3RzIG9uIG0tY29tIGRldmljZS4gUGxlYXNlIHN1Z2dlc3QgaWYgeW91IGtub3cgYW55
IGFsdGVybmF0ZSByb290ZnMgY2FuIGJlIHVzZWQgdG8gYm9vdCBvbiBtLWNvbSBkZXZpY2UuDQoN
Cg0KDQpUaGFua3MgYW5kIHJlZ2FyZHMsDQoNClNhaSBBc2hyaXRoDQoNCg0KDQpodHRwczovL3Mz
LWV1LWNlbnRyYWwtMS5hbWF6b25hd3MuY29tL2Rvd25sb2FkMi5jaXAtcHJvamVjdC5vcmcvY2lw
LXRlc3RpbmcvbGF2YS1oZWFsdGhjaGVja3MvcmZzL2NvcmUtaW1hZ2UtbWluaW1hbC1xZW11YXJt
NjQtbHRwLnRhci5iejINCg0KaHR0cHM6Ly9zMy1ldS1jZW50cmFsLTEuYW1hem9uYXdzLmNvbS9k
b3dubG9hZDIuY2lwLXByb2plY3Qub3JnL2NpcC10ZXN0aW5nL2xhdmEtaGVhbHRoY2hlY2tzL3Jm
cy9jb3JlLWltYWdlLW1pbmltYWwtcWVtdXg4Ni02NC1sdHAuZXh0NC54eg0KDQoNCg0KDQoNCg0K
DQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KRnJvbTogY2lwLWRldkBs
aXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3Jn
PiA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnPj4gb24gYmVoYWxmIG9mIENocmlzIFBhdGVyc29uIHZpYSBsaXN0cy5jaXAt
cHJvamVjdC5vcmcgPGNocmlzLnBhdGVyc29uMj1yZW5lc2FzLmNvbUBsaXN0cy5jaXAtcHJvamVj
dC5vcmc8bWFpbHRvOmNocmlzLnBhdGVyc29uMj1yZW5lc2FzLmNvbUBsaXN0cy5jaXAtcHJvamVj
dC5vcmc+Pg0KU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTIsIDIwMjQgNzozOSBQTQ0KVG86IGNp
cC1zZWN1cml0eUBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1zZWN1cml0eUBsaXN0
cy5jaXAtcHJvamVjdC5vcmc+IDxjaXAtc2VjdXJpdHlAbGlzdHMuY2lwLXByb2plY3Qub3JnPG1h
aWx0bzpjaXAtc2VjdXJpdHlAbGlzdHMuY2lwLXByb2plY3Qub3JnPj47IGl3YW1hdHN1IG5vYnVo
aXJvKOTb4eYg4+HlxyCh26PEo8mj1KPDoeCjxKPJo9Sh26PPo9Oj1CkgPG5vYnVoaXJvMS5pd2Ft
YXRzdUB0b3NoaWJhLmNvLmpwPG1haWx0bzpub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5q
cD4+DQpDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1kZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnPiA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRv
OmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPj47IGhheWFzaGkga2F6dWhpcm8o1/kg+/rO
2yCjxKPNo8UgodujxKPJo8eh4KPNo9Cj06Hbo82j0KO0KSA8a2F6dWhpcm8zLmhheWFzaGlAdG9z
aGliYS5jby5qcDxtYWlsdG86a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4+OyBkaW5l
c2gga3VtYXIoo9Sj06PJo9AgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gua3VtYXJAdG9zaGli
YS10c2lwLmNvbTxtYWlsdG86ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+Pg0KU3ViamVj
dDogUmU6IFtjaXAtZGV2XSBNYW51YWxseSBydW4gS2VybmVsIGFuZCBJRUMgdGVzdHMgb24gTS1D
T00geDg2IGFuZCBnZW5lcmF0ZSByZXN1bHRzDQoNCg0KDQpIZWxsbyBTYWksDQoNCj4gRnJvbTog
Y2lwLXNlY3VyaXR5QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzxtYWlsdG86Y2lwLXNlY3VyaXR5QGxp
c3RzLmNpcC1wcm9qZWN0Lm9yZz4gPGNpcC1zZWN1cml0eUBsaXN0cy5jaXAtDQo8bWFpbHRvOmNp
cC1zZWN1cml0eUBsaXN0cy5jaXAtJTBiPj4gcHJvamVjdC5vcmc+IE9uIEJlaGFsZiBPZiBzYWkg
YXNocml0aCBzYXRodWpvZGEgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50OiAxMiBO
b3ZlbWJlciAyMDI0IDA0OjE0DQo+DQo+IEhlbGxvIENocmlzLA0KPg0KPiBIb3BlIHlvdSBhcmUg
ZG9pbmcgd2VsbC4NCj4NCj4gUmVnYXJkaW5nIElFQyA2MjQ0My00LTIgY2VydGlmaWNhdGlvbiwg
dGhlIGNlcnRpZmljYXRpb24gYm9keSBoYXMgYXNrZWQNCj4gZm9yIEtlcm5lbCBhbmQgSUVDIHRl
c3QgcmVzdWx0cyBvbiBNLUNPTSBkZXZpY2UuIEJhc2VkIG9uIG15IGN1cnJlbnQNCj4ga25vd2xk
ZWdlLCBJIGJlbGlldmUgdGhhdCB0aGUgdGVzdCBzdWl0ZXMgbWVudGlvbmVkIGhlcmUNCj4gaHR0
cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC10ZXN0aW5nL2xpbnV4LWNpcC1jaS8tDQo+
IC9ibG9iL21hc3Rlci9zdWJtaXRfdGVzdHMuc2g/cmVmX3R5cGU9aGVhZHMjTDU1IDxodHRwczov
L2dpdGxhYi5jb20vY2lwLQ0KPGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtJTBiPj4gcHJvamVjdC9j
aXAtdGVzdGluZy9saW51eC1jaXAtY2kvLQ0KPiAvYmxvYi9tYXN0ZXIvc3VibWl0X3Rlc3RzLnNo
P3JlZl90eXBlPWhlYWRzI0w1NT4gIHNoYWxsIHJ1biBmb3IgZXZlcnkNCj4gdXBkYXRlZCBrZXJu
ZWwgaW1hZ2Ugb24gZGlmZmVyZW50IENJUCByZWZlcmVuY2UgaGFyZHdhcmUgaW4gTEFWQS4NCj4N
Cj4gU2luY2UgYXZhaWxhYmlsaXR5IG9mIE0tQ09NIGRldmljZSBvbiBDSVAgTEFWQSBMYWIgc3Rp
bGwgbmVlZHMgc29tZSB0aW1lLA0KPiB3ZSBhcmUgbWFudWFsbHkgcnVubmluZyBlYWNoIHRlc3Qg
c3VpdGUgaS5lIFNNQywgU21va2UsIExUUCBldGMuIGZyb20NCj4gaHR0cHM6Ly9naXRodWIuY29t
L2tlcm5lbGNpL3Rlc3QtZGVmaW5pdGlvbnMNCg0KQXMgSmFuIHNhaWQgLSB3ZSBub3cgaGF2ZSBv
bmUgaW4gQ0lQJ3MgTEFWQS4NCklmIHlvdSBoYXZlIGlzc3VlcyB1c2luZyBpdCBwbGVhc2UgbGV0
IG1lIGtub3cuDQoNCj4NCj4gVGhlcmUgYXJlIG5vIGlzc3VlcyB3aXRoIHJ1bm5pbmcgU01DLCBT
bW9rZSB0ZXN0cyBidXQgd2hpbGUgcnVubmluZyBMVFANCj4gdGVzdHMgaXQgaXMgdHJ5aW5nIHRv
IGluc3RhbGwgc29tZSBkZXBlbmRlbmN5IHBhY2thZ2VzIHRvIHRoZSByb290IGZpbGUNCj4gc3lz
dGVtLiBDdXJyZW50bHkgaXQgc2hvd3MgaXQgaXMgYSBuZXR3b3JrIGlzc3VlIGJ1dCBldmVuIGlm
IGl0IGdldHMNCj4gcmVzb2x2ZWQsIHRoZSBwYWNrYWdlcyBjYW5ub3QgYmUgaW5zdGFsbGVkIGJl
Y2F1c2UgdGhlIHNlY3VyaXR5IGltYWdlIGhhcw0KPiByZWFkLW9ubHkgcm9vdCBmaWxlIHN5c3Rl
bS4NCg0KU28geW91J2QgZWl0aGVyIGhhdmUgdG8gdXNlIGEgd3JpdGFibGUgZmlsZXN5c3RlbSBv
ciBwcmUtaW5zdGFsbCBldmVyeXRoaW5nIGludG8gdGhlIG9yaWdpbmFsIGltYWdlLg0KDQo+DQo+
IEFub3RoZXIgaWRlYSB3aGljaCBuZWVkcyB0byBiZSBkaXNjdXNzZWQgaXMsIHNpbmNlIEtlcm5l
bCB0ZXN0cyBieSBuYW1lDQo+IG1lYW5zIGZvY3VzaW5nIG9uIHRlc3Rpbmcgb25seSB0aGUgS2Vy
bmVsLCB3ZSBjYW4gdHJ5IHRvIHVzZSBhIGRpZmZlcmVudA0KPiByb290IGZpbGUgc3lzdGVtIHRv
IHJ1biB0aGVzZSB0ZXN0cy4gQnV0IHRoaXMgaXMganVzdCBhbiBpZGVhLCB0aGlzIG5lZWRzDQo+
IHRvIGludGVybmFsbHkgYmUgZGlzY3Vzc2VkIHdpdGhpbiBTV0cgYW5kIHdpdGggQ2VydGlmaWNh
dGlvbiBib2R5Lg0KDQpUaGVyZSdzIG5vIGhhcm0gaW4gdXNpbmcgYSBkaWZmZXJlbnQgcm9vdGZz
LCBvciBpbiBpbXByb3ZpbmcgdGhlIG9uZSBjdXJyZW50bHkgdXNlZCBmb3IgS2VybmVsIHRlc3Rp
bmcuDQpJbmRlZWQgSSBiZWxpZXZlIEl3YW1hdHN1LXNhbiBjcmVhdGVkIHNlcGFyYXRlIGltYWdl
cyBmb3IgTFRQIHRlc3RpbmcgcHJldmlvdXNseSBhbnl3YXkuDQoNCj4NCj4gSSByZXF1ZXN0IHlv
dSB0byBwcm92aWRlIGFueSBzdWdnZXN0aW9ucyByZWdhcmRpbmcgdGhlIGF0dGFjaGVkIExUUA0K
PiBpc3N1ZXMuDQoNCllvdSdkIG5lZWQgYSB3b3JraW5nIGludGVybmV0IGNvbm5lY3Rpb24gdG8g
c29sdmUgdGhlIHNwZWNpZmljIGlzc3VlcyBpbiB0aGF0IGxvZy4NCg0KS2luZCByZWdhcmRzLCBD
aHJpcw0KDQo+DQo+IFRoYW5rcyBhbmQgcmVnYXJkcywNCj4gU2FpIEFzaHJpdGggKFQgUyBJIFAp
DQo+DQpfLl8sXy5fLF8NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpMaW5rczoN
Cg0KWW91IHJlY2VpdmUgYWxsIG1lc3NhZ2VzIHNlbnQgdG8gdGhpcyBncm91cC4NCg0KVmlldy9S
ZXBseSBPbmxpbmUgKCMyMzA2KTxodHRwczovL2xpc3RzLmNpcC1wcm9qZWN0Lm9yZy9nL2NpcC1z
ZWN1cml0eS9tZXNzYWdlLzIzMDY+IHwgUmVwbHkgdG8gR3JvdXA8bWFpbHRvOmNpcC1zZWN1cml0
eUBsaXN0cy5jaXAtcHJvamVjdC5vcmc/c3ViamVjdD1SZTolMjBSZSUzQSUyMCU1QmNpcC1zZWN1
cml0eSU1RCUyMCU1QmNpcC1kZXYlNUQlMjBNYW51YWxseSUyMHJ1biUyMEtlcm5lbCUyMGFuZCUy
MElFQyUyMHRlc3RzJTIwb24lMjBNLUNPTSUyMHg4NiUyMGFuZCUyMGdlbmVyYXRlJTIwcmVzdWx0
cz4gfCBSZXBseSB0byBTZW5kZXI8bWFpbHRvOnNhaS5zYXRodWpvZGFAdG9zaGliYS10c2lwLmNv
bT9zdWJqZWN0PVByaXZhdGU6JTIwUmU6JTIwUmUlM0ElMjAlNUJjaXAtc2VjdXJpdHklNUQlMjAl
NUJjaXAtZGV2JTVEJTIwTWFudWFsbHklMjBydW4lMjBLZXJuZWwlMjBhbmQlMjBJRUMlMjB0ZXN0
cyUyMG9uJTIwTS1DT00lMjB4ODYlMjBhbmQlMjBnZW5lcmF0ZSUyMHJlc3VsdHM+IHwgTXV0ZSBU
aGlzIFRvcGljPGh0dHBzOi8vbGlzdHMuY2lwLXByb2plY3Qub3JnL210LzEwOTcwMzMyNS84ODEx
MjA+IHwgTmV3IFRvcGljPGh0dHBzOi8vbGlzdHMuY2lwLXByb2plY3Qub3JnL2cvY2lwLXNlY3Vy
aXR5L3Bvc3Q+DQpZb3VyIFN1YnNjcmlwdGlvbjxodHRwczovL2xpc3RzLmNpcC1wcm9qZWN0Lm9y
Zy9nL2NpcC1zZWN1cml0eS9lZGl0c3ViLzg4MTEyMD4gfCBDb250YWN0IEdyb3VwIE93bmVyPG1h
aWx0bzpjaXAtc2VjdXJpdHkrb3duZXJAbGlzdHMuY2lwLXByb2plY3Qub3JnPiB8IFVuc3Vic2Ny
aWJlPGh0dHBzOi8vbGlzdHMuY2lwLXByb2plY3Qub3JnL2cvY2lwLXNlY3VyaXR5L2xlYXZlLzgx
MjkyOTAvODgxMTIwLzkzOTk4NDA1OS94eXp6eT4gW2NocmlzLnBhdGVyc29uMkByZW5lc2FzLmNv
bV0NCl8uXyxfLl8sXw0K

--_000_TYYPR01MB1240272631FDD5B23D4725D37B7282TYYPR01MB12402jp_
Content-Type: text/html; charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dks_c_5601=
-1987">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Gulim;
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@Gulim";
	panose-1:2 11 6 0 0 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Gulim",sans-serif;
	mso-fareast-language:KO;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0cm;
	font-size:12.0pt;
	font-family:"Gulim",sans-serif;
	mso-fareast-language:KO;}
span.EmailStyle24
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
<body lang=3D"EN-GB" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Hello Sai,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Thank you =
for the update.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Will your =
isar-cip-core branch be staying? Or will it be merged into the main branch?=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">We then ca=
n get linux-cip-ci updated to add support to use the rootfs with LTP tests =
for the mcom device, and then update our ci pipelines
 accordingly.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-GB">Kind regards=
, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> =
cip-security@lists.cip-project.org &lt;cip-security@lists.cip-project.org&g=
t;
<b>On Behalf Of </b>sai ashrith sathujoda via lists.cip-project.org<br>
<b>Sent:</b> 26 November 2024 03:18<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> kazuhiro3.hayashi@toshiba.co.jp; dinesh.kumar@toshiba-tsip.com; =
cip-security@lists.cip-project.org; nobuhiro1.iwamatsu@toshiba.co.jp; cip-d=
ev@lists.cip-project.org<br>
<b>Subject:</b> Re: [cip-security] [cip-dev] Manually run Kernel and IEC te=
sts on M-COM x86 and generate results<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Hello Chris,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Hope you are doing well.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">I have created a custom branch in isar-cip-core from which=
 I created a x86 generic uefi rootfs tarball with LTP binary installed,
<a href=3D"https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/=
cip-core/sai-deploy-x86uefi-rootfs-ltp/x86-uefi/cip-core-image-cip-core-boo=
kworm-x86-uefi-test.tar.gz">
https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/cip-core/sa=
i-deploy-x86uefi-rootfs-ltp/x86-uefi/cip-core-image-cip-core-bookworm-x86-u=
efi-test.tar.gz</a><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">I ran LTP tests on M-COM on LAVA for
<b>6.1.115-cip31.</b><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Please have a look at the list of jobs ran recently on M-C=
OM
<b><a href=3D"https://lava.ciplatform.org/scheduler/device_type/x86-siemens=
-mcom">LAVA | Scheduler | Device Types | x86-siemens-mcom</a></b><o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Thanks and regards,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Sai Ashrith (T S I P)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Chris =
Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Paterson2=
@renesas.com</a>&gt;<br>
<b>Sent:</b> Monday, November 25, 2024 9:17 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"KO" style=3D"font-size:11.0pt;c=
olor:black">=A3=D4=A3=D3=A3=C9=A3=D0</span><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif;color:black">) &lt;<a href=3D"ma=
ilto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsip.com</a>&gt;=
<br>
<b>Cc:</b> hayashi kazuhiro(</span><span lang=3D"KO" style=3D"font-size:11.=
0pt;color:black">=D7=F9</span><span lang=3D"KO" style=3D"font-size:11.0pt;f=
ont-family:&quot;Calibri&quot;,sans-serif;color:black">
</span><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=FB=FA=CE=
=DB</span><span lang=3D"KO" style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,sans-serif;color:black">
</span><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=A3=C4=A3=
=CD=A3=C5</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&q=
uot;,sans-serif;color:black"> =A1=DB</span><span lang=3D"KO" style=3D"font-=
size:11.0pt;color:black">=A3=C4=A3=C9=A3=C7</span><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">=A1=E0</span=
><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=A3=CD=A3=D0=A3=
=D3</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black">=A1=DB</span><span lang=3D"KO" style=3D"font-size:11=
.0pt;color:black">=A3=CD=A3=D0=A3=B4</span><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif;color:black">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"KO" style=3D"font-s=
ize:11.0pt;color:black">=A3=D4=A3=D3=A3=C9=A3=D0</span><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> TMIEC =
ODG
 Porting) &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar=
@toshiba-tsip.com</a>&gt;;
<a href=3D"mailto:cip-security@lists.cip-project.org">cip-security@lists.ci=
p-project.org</a> &lt;<a href=3D"mailto:cip-security@lists.cip-project.org"=
>cip-security@lists.cip-project.org</a>&gt;; iwamatsu nobuhiro(</span><span=
 lang=3D"KO" style=3D"font-size:11.0pt;color:black">=E4=DB=E1=E6</span><spa=
n lang=3D"KO" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,san=
s-serif;color:black">
</span><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=E3=E1=E5=
=C7</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black"> =A1=DB</span><span lang=3D"KO" style=3D"font-size:1=
1.0pt;color:black">=A3=C4=A3=C9=A3=D4=A3=C3</span><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">=A1=E0</span=
><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=A3=C4=A3=C9=A3=
=D4</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black">=A1=DB</span><span lang=3D"KO" style=3D"font-size:11=
.0pt;color:black">=A3=CF=A3=D3=A3=D4</span><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif;color:black">)
 &lt;<a href=3D"mailto:nobuhiro1.iwamatsu@toshiba.co.jp">nobuhiro1.iwamatsu=
@toshiba.co.jp</a>&gt;;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.=
cip-project.org</a>&gt;<br>
<b>Subject:</b> RE: [cip-dev] Manually run Kernel and IEC tests on M-COM x8=
6 and generate results</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">Hello Sai,</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">&nbsp;</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">Apologies for the slow response.</sp=
an><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">&nbsp;</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">Well done for getting the LTP tests =
running locally.</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">If you send me the tarball or link m=
e to it I can upload it to S3 for you.</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">&nbsp;</span><o:p></o:p></p>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;A=
ptos&quot;,sans-serif;color:#7030A0">Kind regards, Chris</span><o:p></o:p><=
/p>
</div>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">&nbsp;</span><o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"xmsonormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;f=
ont-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN=
-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsi=
p.com</a> &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujo=
da@toshiba-tsip.com</a>&gt;
<br>
<b>Sent:</b> 21 November 2024 13:38<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hay=
ashi@toshiba.co.jp</a>;
<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.=
com</a>;
<a href=3D"mailto:cip-security@lists.cip-project.org">cip-security@lists.ci=
p-project.org</a>;
<a href=3D"mailto:nobuhiro1.iwamatsu@toshiba.co.jp">nobuhiro1.iwamatsu@tosh=
iba.co.jp</a>;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a><br>
<b>Subject:</b> Re: [cip-dev] Manually run Kernel and IEC tests on M-COM x8=
6 and generate results</span><o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">Hello Chris,</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">Hope you are doing great.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">This is just an update regarding my previous query in thi=
s mail thread.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">I was able to run LTP on security target in my machine af=
ter including
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/mas=
ter/kas/opt/test.yml?ref_type=3Dheads">
kas/opt/test.yml =A1=A4 master =A1=A4 cip-project / cip-core / isar-cip-cor=
e =A1=A4 GitLab</a>&nbsp;while building the image as it&nbsp;comes all the =
dependencies required to run them.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">For LAVA, I will try to upload a rootfs tarball to cip-pr=
oject's S3 storage with build:x86-uefi-base configuration along with
<b>extension: test</b>. I hope I can run LTP tests on M-COM x86 on LAVA wit=
h this method. I ran SMC tests on M-COM x86 with 6.1.112-cip30 kernel -&gt;
<a href=3D"https://lava.ciplatform.org/results/1222616/0_spectre-meltdown-c=
hecker-test">
https://lava.ciplatform.org/results/1222616/0_spectre-meltdown-checker-test=
</a></span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">Thanks and regards.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">Sai Ashrith</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"xmsonormal"><b><span style=3D"font-size:11.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font=
-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.=
cip-project.org</a>&gt; on behalf of
<a href=3D"mailto:sai.sathujoda@toshiba-tsip.com">sai.sathujoda@toshiba-tsi=
p.com</a> &lt;<a href=3D"mailto:sai.sathujoda@toshiba-tsip.com">sai.sathujo=
da@toshiba-tsip.com</a>&gt;<br>
<b>Sent:</b> Friday, November 15, 2024 7:14 PM<br>
<b>To:</b> <a href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Paterson2@r=
enesas.com</a> &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Pat=
erson2@renesas.com</a>&gt;<br>
<b>Cc:</b> hayashi kazuhiro(</span><span lang=3D"KO" style=3D"font-size:11.=
0pt;color:black">=D7=F9</span><span lang=3D"KO" style=3D"font-size:11.0pt;f=
ont-family:&quot;Calibri&quot;,sans-serif;color:black">
</span><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=FB=FA=CE=
=DB</span><span lang=3D"KO" style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,sans-serif;color:black">
</span><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=A3=C4=A3=
=CD=A3=C5</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&q=
uot;,sans-serif;color:black"> =A1=DB</span><span lang=3D"KO" style=3D"font-=
size:11.0pt;color:black">=A3=C4=A3=C9=A3=C7</span><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">=A1=E0</span=
><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=A3=CD=A3=D0=A3=
=D3</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black">=A1=DB</span><span lang=3D"KO" style=3D"font-size:11=
.0pt;color:black">=A3=CD=A3=D0=A3=B4</span><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif;color:black">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"KO" style=3D"font-s=
ize:11.0pt;color:black">=A3=D4=A3=D3=A3=C9=A3=D0</span><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> TMIEC =
ODG
 Porting) &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar=
@toshiba-tsip.com</a>&gt;;
<a href=3D"mailto:cip-security@lists.cip-project.org">cip-security@lists.ci=
p-project.org</a> &lt;<a href=3D"mailto:cip-security@lists.cip-project.org"=
>cip-security@lists.cip-project.org</a>&gt;; iwamatsu nobuhiro(</span><span=
 lang=3D"KO" style=3D"font-size:11.0pt;color:black">=E4=DB=E1=E6</span><spa=
n lang=3D"KO" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,san=
s-serif;color:black">
</span><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=E3=E1=E5=
=C7</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black"> =A1=DB</span><span lang=3D"KO" style=3D"font-size:1=
1.0pt;color:black">=A3=C4=A3=C9=A3=D4=A3=C3</span><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">=A1=E0</span=
><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=A3=C4=A3=C9=A3=
=D4</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black">=A1=DB</span><span lang=3D"KO" style=3D"font-size:11=
.0pt;color:black">=A3=CF=A3=D3=A3=D4</span><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif;color:black">)
 &lt;<a href=3D"mailto:nobuhiro1.iwamatsu@toshiba.co.jp">nobuhiro1.iwamatsu=
@toshiba.co.jp</a>&gt;;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.=
cip-project.org</a>&gt;<br>
<b>Subject:</b> Re: [cip-dev] Manually run Kernel and IEC tests on M-COM x8=
6 and generate results</span>
<o:p></o:p></p>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Calibri&quot;,sans=
-serif">&nbsp;</span><o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">Hello Chris,</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">Hope you are doing well.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">After going through Lava job definitions where ltp tests =
are run on CIP reference hardware on CIP LAVA,</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">I noticed that ltp tests are being mostly on:</span><o:p>=
</o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">renesas_r8a7743-iwg20d-q7</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">renesas_r8a774a1-hihope-rzg2m-ex</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">x86_cip_qemu</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">Using rootfs tarballs such as:</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black"><a href=3D"https://s3-eu-central-1.amazonaws.com/download=
2.cip-project.org/cip-testing/lava-healthchecks/rfs/core-image-minimal-qemu=
arm64-ltp.tar.bz2">https://s3-eu-central-1.amazonaws.com/download2.cip-proj=
ect.org/cip-testing/lava-healthchecks/rfs/core-image-minimal-qemuarm64-ltp.=
tar.bz2</a></span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black"><a href=3D"https://s3-eu-central-1.amazonaws.com/download=
2.cip-project.org/cip-testing/lava-healthchecks/rfs/core-image-minimal-qemu=
x86-64-ltp.ext4.xz">https://s3-eu-central-1.amazonaws.com/download2.cip-pro=
ject.org/cip-testing/lava-healthchecks/rfs/core-image-minimal-qemux86-64-lt=
p.ext4.xz</a></span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">..along with respective dtb files.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">But currently m-com health checks are using
<a href=3D"https://s3-us-west-2.amazonaws.com/download.cip-project.org/cipt=
esting/cip-lava/rfs/rootfs-simatic-ipc227e.tar.gz">
https://s3-us-west-2.amazonaws.com/download.cip-project.org/ciptesting/cip-=
lava/rfs/rootfs-simatic-ipc227e.tar.gz</a> rootfs.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">I tried to use &nbsp;SKIP_INSTALL: &quot;false&quot; in t=
he test definition because ltp test cases are not present in expected folde=
rs, ex: /opt/ltp and dependency packages as well expecting they
 will be installed in the image after boot. But the job failed. <u><a href=
=3D"https://lava.ciplatform.org/scheduler/job/1223149#L1339">https://lava.c=
iplatform.org/scheduler/job/1223149#L1339</a></u></span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">I request you to help me in preparing a simatic-ipc227e r=
ootfs tarball with ltp tests and required packages and pushing cip-project =
s3 storage so that I can run ltp tests on m-com
 device. Please suggest if you know any alternate rootfs can be used to boo=
t on m-com device.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">Thanks and regards,</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">Sai Ashrith</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:white"><a href=3D"https://s3-eu-central-1.amazonaws.com/download=
2.cip-project.org/cip-testing/lava-healthchecks/rfs/core-image-minimal-qemu=
arm64-ltp.tar.bz2">https://s3-eu-central-1.amazonaws.com/download2.cip-proj=
ect.org/cip-testing/lava-healthchecks/rfs/core-image-minimal-qemuarm64-ltp.=
tar.bz2</a></span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:white"><a href=3D"https://s3-eu-central-1.amazonaws.com/download=
2.cip-project.org/cip-testing/lava-healthchecks/rfs/core-image-minimal-qemu=
x86-64-ltp.ext4.xz"><span style=3D"color:white">https://s3-eu-central-1.ama=
zonaws.com/download2.cip-project.org/cip-testing/lava-healthchecks/rfs/core=
-image-minimal-qemux86-64-ltp.ext4.xz</span></a></span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"xmsonormal"><b><span style=3D"font-size:11.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font=
-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.=
cip-project.org</a>&gt; on behalf of Chris Paterson via lists.cip-project.o=
rg &lt;<a href=3D"mailto:chris.paterson2=3Drenesas.com@lists.cip-project.or=
g">chris.paterson2=3Drenesas.com@lists.cip-project.org</a>&gt;<br>
<b>Sent:</b> Tuesday, November 12, 2024 7:39 PM<br>
<b>To:</b> <a href=3D"mailto:cip-security@lists.cip-project.org">cip-securi=
ty@lists.cip-project.org</a> &lt;<a href=3D"mailto:cip-security@lists.cip-p=
roject.org">cip-security@lists.cip-project.org</a>&gt;; iwamatsu nobuhiro(<=
/span><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=E4=DB=E1=E6=
</span><span lang=3D"KO" style=3D"font-size:11.0pt;font-family:&quot;Calibr=
i&quot;,sans-serif;color:black">
</span><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=E3=E1=E5=
=C7</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black"> =A1=DB</span><span lang=3D"KO" style=3D"font-size:1=
1.0pt;color:black">=A3=C4=A3=C9=A3=D4=A3=C3</span><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">=A1=E0</span=
><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=A3=C4=A3=C9=A3=
=D4</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black">=A1=DB</span><span lang=3D"KO" style=3D"font-size:11=
.0pt;color:black">=A3=CF=A3=D3=A3=D4</span><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif;color:black">)
 &lt;<a href=3D"mailto:nobuhiro1.iwamatsu@toshiba.co.jp">nobuhiro1.iwamatsu=
@toshiba.co.jp</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip=
-dev@lists.cip-project.org</a>&gt;; hayashi kazuhiro(</span><span lang=3D"K=
O" style=3D"font-size:11.0pt;color:black">=D7=F9</span><span lang=3D"KO" st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:bl=
ack">
</span><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=FB=FA=CE=
=DB</span><span lang=3D"KO" style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,sans-serif;color:black">
</span><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=A3=C4=A3=
=CD=A3=C5</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&q=
uot;,sans-serif;color:black"> =A1=DB</span><span lang=3D"KO" style=3D"font-=
size:11.0pt;color:black">=A3=C4=A3=C9=A3=C7</span><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">=A1=E0</span=
><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=A3=CD=A3=D0=A3=
=D3</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black">=A1=DB</span><span lang=3D"KO" style=3D"font-size:11=
.0pt;color:black">=A3=CD=A3=D0=A3=B4</span><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif;color:black">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"KO" style=3D"font-s=
ize:11.0pt;color:black">=A3=D4=A3=D3=A3=C9=A3=D0</span><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> TMIEC =
ODG
 Porting) &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar=
@toshiba-tsip.com</a>&gt;<br>
<b>Subject:</b> Re: [cip-dev] Manually run Kernel and IEC tests on M-COM x8=
6 and generate results</span>
<o:p></o:p></p>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Calibri&quot;,sans=
-serif">&nbsp;</span><o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt">Hello Sai,<br>
<br>
&gt; From: <a href=3D"mailto:cip-security@lists.cip-project.org">cip-securi=
ty@lists.cip-project.org</a> &lt;<a href=3D"mailto:cip-security@lists.cip-%=
0b">cip-security@lists.cip-<br>
</a>&gt; project.org&gt; On Behalf Of sai ashrith sathujoda via lists.cip-p=
roject.org<br>
&gt; Sent: 12 November 2024 04:14<br>
&gt; <br>
&gt; Hello Chris,<br>
&gt; <br>
&gt; Hope you are doing well.<br>
&gt; <br>
&gt; Regarding IEC 62443-4-2 certification, the certification body has aske=
d<br>
&gt; for Kernel and IEC test results on M-COM device. Based on my current<b=
r>
&gt; knowldege, I believe that the test suites mentioned here<br>
&gt; <a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-">=
https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-</a><br>
&gt; /blob/master/submit_tests.sh?ref_type=3Dheads#L55 &lt;<a href=3D"https=
://gitlab.com/cip-%0b">https://gitlab.com/cip-<br>
</a>&gt; project/cip-testing/linux-cip-ci/-<br>
&gt; /blob/master/submit_tests.sh?ref_type=3Dheads#L55&gt;</span><span styl=
e=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">&nbsp;</s=
pan><span style=3D"font-size:11.0pt"> shall run for every<br>
&gt; updated kernel image on different CIP reference hardware in LAVA.<br>
&gt; <br>
&gt; Since availability of M-COM device on CIP LAVA Lab still needs some ti=
me,<br>
&gt; we are manually running each test suite i.e SMC, Smoke, LTP etc. from<=
br>
&gt; <a href=3D"https://github.com/kernelci/test-definitions">https://githu=
b.com/kernelci/test-definitions</a><br>
<br>
As Jan said - we now have one in CIP's LAVA.<br>
If you have issues using it please let me know.<br>
<br>
&gt; <br>
&gt; There are no issues with running SMC, Smoke tests but while running LT=
P<br>
&gt; tests it is trying to install some dependency packages to the root fil=
e<br>
&gt; system. Currently it shows it is a network issue but even if it gets<b=
r>
&gt; resolved, the packages cannot be installed because the security image =
has<br>
&gt; read-only root file system.<br>
<br>
So you'd either have to use a writable filesystem or pre-install everything=
 into the original image.<br>
<br>
&gt; <br>
&gt; Another idea which needs to be discussed is, since Kernel tests by nam=
e<br>
&gt; means focusing on testing only the Kernel, we can try to use a differe=
nt<br>
&gt; root file system to run these tests. But this is just an idea, this ne=
eds<br>
&gt; to internally be discussed within SWG and with Certification body.<br>
<br>
There's no harm in using a different rootfs, or in improving the one curren=
tly used for Kernel testing.<br>
Indeed I believe Iwamatsu-san created separate images for LTP testing previ=
ously anyway.<br>
<br>
&gt; <br>
&gt; I request you to provide any suggestions regarding the attached LTP<br=
>
&gt; issues.<br>
<br>
You'd need a working internet connection to solve the specific issues in th=
at log.<br>
<br>
Kind regards, Chris<br>
<br>
&gt; <br>
&gt; Thanks and regards,<br>
&gt; Sai Ashrith (T S I P)<br>
&gt; </span><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:white">_._,_._,_<o:p></o:p></sp=
an></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"100%" align=3D"center">
</div>
<p class=3D"MsoNormal">Links:<o:p></o:p></p>
<p>You receive all messages sent to this group. <o:p></o:p></p>
<p><a href=3D"https://lists.cip-project.org/g/cip-security/message/2306" ta=
rget=3D"_blank">View/Reply Online (#2306)</a> |
<a href=3D"mailto:cip-security@lists.cip-project.org?subject=3DRe:%20Re%3A%=
20%5Bcip-security%5D%20%5Bcip-dev%5D%20Manually%20run%20Kernel%20and%20IEC%=
20tests%20on%20M-COM%20x86%20and%20generate%20results" target=3D"_blank">
Reply to Group</a> | <a href=3D"mailto:sai.sathujoda@toshiba-tsip.com?subje=
ct=3DPrivate:%20Re:%20Re%3A%20%5Bcip-security%5D%20%5Bcip-dev%5D%20Manually=
%20run%20Kernel%20and%20IEC%20tests%20on%20M-COM%20x86%20and%20generate%20r=
esults" target=3D"_blank">
Reply to Sender</a> | <a href=3D"https://lists.cip-project.org/mt/109703325=
/881120" target=3D"_blank">
Mute This Topic</a> | <a href=3D"https://lists.cip-project.org/g/cip-securi=
ty/post">
New Topic</a> <br>
<a href=3D"https://lists.cip-project.org/g/cip-security/editsub/881120">You=
r Subscription</a> |
<a href=3D"mailto:cip-security+owner@lists.cip-project.org">Contact Group O=
wner</a> |
<a href=3D"https://lists.cip-project.org/g/cip-security/leave/8129290/88112=
0/939984059/xyzzy">
Unsubscribe</a> [chris.paterson2@renesas.com]<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:white">_._,_._,_<o:p></o:p></sp=
an></p>
</div>
</div>
</body>
</html>

--_000_TYYPR01MB1240272631FDD5B23D4725D37B7282TYYPR01MB12402jp_--

