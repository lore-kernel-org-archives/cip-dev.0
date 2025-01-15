Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FB7C02180
	for <webhook@archiver.kernel.org>; Wed, 15 Jan 2025 13:57:13 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.50])
 by mx.groups.io with SMTP id smtpd.web10.21359.1736949427057910432
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jan 2025 05:57:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=iQ59s+kT;
 spf=pass (domain: renesas.com, ip: 40.107.74.50, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEL0nNSz4cIhWUqt1KeE0ujcE7bxAWRxs4MJCW9Hj8jrJe85LhPtLNyuX1uAE1q8qHLlU4gEwp5eSFn6y0dT5dQwx5XQaLoY7OJWlJB1Fij2xxBDO5QdWRLCCU+lqCPzC8jn/vfkXtbO8+FHadEuoeCXrGfdH9H2hG+IZ8GrKhW0r7IIR8sPBUzz4jpJDAdrnYz7KW84Ig856ePfxhrQzrVB41EJ+wPrXrWAeqkfRskXHjOl4iZzjKXScBb1S9sy2Sox1Z1GRW/BjmelzthEvnfwBIhvjvODskzJBn0tuqDqcT1ZkTzIYvp4haOGuP7E9mf0FYGNb8TtS+nUvjjvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=op8F+jI7I0ZUjdIEWIAt41fJyjQfYPZVqmJ0QeDTzqw=;
 b=ZwuquN8Ih0LMgfV9D0COH8kIS6fKQ3sC164ObkDInryuQUbqjQL7UTXRGyHQm4jiQu7GrAbsqf/Ti3fH8kyeVOO2GrtyJv0N0sH6ikoNlLjvCfaIrHKLgjJm4MuRmoJpikDeqenZPL8o+Qg7cppGuSgLxjb3dUASiiP4XUUvYCQ4kMOF49bPQrw8LfT2VbyQ1TrZ8BP/nRZ46p3CuGdrqap/1s2bNXcuBM3iev1oa6TdeeOs5qmTIt41qYdebqnD1oXKEbVEBTXj4YuWjKFHouzrW7l5pAtMtHc8EzGoa5v/pRUdh+CQ/bCvnM70oLsi1sDsFcShXxm2sZk6mhEFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op8F+jI7I0ZUjdIEWIAt41fJyjQfYPZVqmJ0QeDTzqw=;
 b=iQ59s+kTlHkLovUQNCDTkPAcdxktZZ02X/wzZZUOoFRQtn9LJe573l/3UO5bAPxIU+yZEiiBbunYp+6TsA0bpd0HYkUrDlfuxixSW6uzqIQVNRv5ymA8OdwCHJAHepwv46vofgNB3gY+xw3vGP14unMUpsNZPP55c3NNJx8gaTQ=
Received: from OSZPR01MB8401.jpnprd01.prod.outlook.com (2603:1096:604:16f::7)
 by OS3PR01MB8303.jpnprd01.prod.outlook.com (2603:1096:604:1a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:57:03 +0000
Received: from OSZPR01MB8401.jpnprd01.prod.outlook.com
 ([fe80::c9a:aa8b:f8ea:998b]) by OSZPR01MB8401.jpnprd01.prod.outlook.com
 ([fe80::c9a:aa8b:f8ea:998b%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:57:03 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
CC: "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
Subject: RE: ltp (syscall) failed test in CIP Security image with
 isar-cip-core v1.6 on M-COM
Thread-Topic: ltp (syscall) failed test in CIP Security image with
 isar-cip-core v1.6 on M-COM
Thread-Index: AQHbUuTAhee4QvOabkGKuX6gapV/KLLvWeRwgCiiEZA=
Date: Wed, 15 Jan 2025 13:57:03 +0000
Message-ID: 
 <OSZPR01MB84010B4C962BC73DD1466779B7192@OSZPR01MB8401.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AAC4C7533384E6C3CE8CC2072@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OSZPR01MB85159B1B29203FFAC3458D6ABF072@OSZPR01MB8515.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSZPR01MB85159B1B29203FFAC3458D6ABF072@OSZPR01MB8515.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8401:EE_|OS3PR01MB8303:EE_
x-ms-office365-filtering-correlation-id: b7ce731a-4ae7-4a83-26c7-08dd356c7d3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?TmkwZ3YyYVBZYjB2QWtVRzhwWmhaL3E4c1crcVAxOHp5SHZHZmtVcW9x?=
 =?iso-2022-jp?B?UmdPa3BBVjRtNzB5MG42U25sMW92STlPK3RzQjA0WE94TEFrZzFPOG8w?=
 =?iso-2022-jp?B?cmkxeVdTdVpYN2ZzSUxSYmVKSUJ6Y0JrY0NpNTUzRUNNa2FXV2VHZ0c1?=
 =?iso-2022-jp?B?SXNLcWJvbnNpMCt5RC9OS1JCNUtXdjRvUGZNVSswakRtUXkrM2NNR1JI?=
 =?iso-2022-jp?B?Z0xqcVVCMnpWVW9od1U1cW43dU94cElTTmtBQkRqWkpmTkFjcTlCSXNY?=
 =?iso-2022-jp?B?TnhVZ3MrWThPWmV0bkxqc3NqU2NsKzd4aG5ybW5zYWZSNkxpOExnZkdW?=
 =?iso-2022-jp?B?TjBUaGo1cCs3bTVnMHR4T3lmV3Uxb3IrbEp0S2ttRHI0RHJlNytCWG9y?=
 =?iso-2022-jp?B?dzJWMGhBRGlxRTB4cGdldCtZek4yZWhYYVMxVW9oTzMrdjdLS1JXYlFN?=
 =?iso-2022-jp?B?dlVvNmNaRWMxYmhoRk9YVkNuSjhaSzAzN1FFVVYvQkJyOGZqeTE0a0or?=
 =?iso-2022-jp?B?K3FISFpuT2lXN2ozazlVNGo2MWtvM0d3WDFwMGgwNzlhd2oydWRVUzVL?=
 =?iso-2022-jp?B?NGRtOUpVNkYwNm5rY2NvRTdKQ2pnWnZBajRFWEtEemJoOXdiQW9CYm85?=
 =?iso-2022-jp?B?enJiQjVwZkpmdkJNN3E0ODZGL2xhdm9ialVGaGNtV29iRmRzaFUvS0Ev?=
 =?iso-2022-jp?B?QnNabVlBQlh2c3p6MmVUT2RTWHVTbTlOOXVqOVRjVjZPZXdJeWxNSGxV?=
 =?iso-2022-jp?B?WS9SREZJQ0ZEblkyaVo1UXQ3WFhob0dSN3R4Yis0b21Rck1JM253QllM?=
 =?iso-2022-jp?B?SUVNYkxhRlFJbVY3a1VNSWRUUmNYVG9HR0NDeHZUckJnd3h1SllxaW0v?=
 =?iso-2022-jp?B?OGtsNVc1dWtjL1dWZWRPV21jd0ZRZTZ1MHRnUGhqOGIxcTZldDlWT1Fu?=
 =?iso-2022-jp?B?TUNmTU5pbythb2NuK2FtYUx1azV0RExCb2VUUG1lK0Jzb2tHaGhyRFor?=
 =?iso-2022-jp?B?UW5VVDR2RDRkRlZ2SXdUL2Q3OSt4OGgwZFJLV0I0MTJwWHZaa3hWZ2tm?=
 =?iso-2022-jp?B?d1lPUDIwdG03NlozdGNoNUgzd2ovamR2Mmt1RHFPUHV1bS80bzBXektX?=
 =?iso-2022-jp?B?Q3FmZXFERlJDWDJLejhBMkN5dFBpdTRFalZtcVpKblZuRVJuQnlacEZW?=
 =?iso-2022-jp?B?cGxaYkw2ZExQMDJhY1AwaEx4YU4zTTk2QmdGcHBnMDJVNlUxbzhmYTh1?=
 =?iso-2022-jp?B?MjNQSFo4a0ZONjZreFYvZlc3enUrRkdYdEF4NE1SNGc3R3E5WUc2R1lV?=
 =?iso-2022-jp?B?SGhOZ2I3QTVYZnFyTG9wUFA2ZEk1UkhBRzZSTkZzNlFDRGpQK1NLT0ZJ?=
 =?iso-2022-jp?B?K1VLWkJyakdrVmIvVW93bTBFMEZGRzlGTUJod3hiY1FkNEZGUys2d1ND?=
 =?iso-2022-jp?B?WU5wSzY1NmVsWmszMGVIeTdFTG96cXBQeG43QlU2MDNZUkJ0Q1pPSjhs?=
 =?iso-2022-jp?B?Ui9hc3drOWtlRCtaaEI1NjNiclBITlF3b2tDQlJLWFd4blpzajducHI0?=
 =?iso-2022-jp?B?WEpLR3FkT2Jvdkp2QytiRWE4Tk82Ly9TUW1wYUx6cUNLdklhU3FEQUhK?=
 =?iso-2022-jp?B?ekFzcTgxL1hlUjI0c01CVzAyc1JERHNTNVR5S2JSR0RxbENTdXZqTFkw?=
 =?iso-2022-jp?B?a2Z1UzI1RnNxTlRvWTNVVTBxNE1ITDJmaWs1Qlh1VjNRMDgvWUJobDlX?=
 =?iso-2022-jp?B?ZmFKc29FT1I2NlhJS1hBcjdFM0VxTFBEOWJSMU1yT21vT21pMzA5Q0J3?=
 =?iso-2022-jp?B?dU15TTJZaVdoM0o1UzVGanhrSWd0RzJZbWMwei8rWm1EN25yYVZHWlNE?=
 =?iso-2022-jp?B?WTV0b0VSdHJKQ2RoNkw2OTdqOHdpRDNJYnFYVnJYZFBRcUVtMU01NFBw?=
 =?iso-2022-jp?B?dTRjMmJrREgrMjVzU1lDSUpTNkhBRThJem05RTNqcGFxVWxFckhLT0cx?=
 =?iso-2022-jp?B?L0ZON3dMTTF2YlFONDArMDJUd3pCVGdLU053Rk5CcFVCNmk1QlZjRDFX?=
 =?iso-2022-jp?B?dnc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8401.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SEdaTkZvZlgxdXVibGV6SDArSmNhOEgxbDkzbm9tbW5YMDZmQlFXTHYw?=
 =?iso-2022-jp?B?WWE3R05sZFlXN3c2YlhyaUQxZGhQaG90TWhWd0R3MVBIZlA4SUVreTF4?=
 =?iso-2022-jp?B?cXlLYUd0N0swdG1MbDdEQXE2SHhBNjNuWnVQS2swVExTMUV1c1ptb2du?=
 =?iso-2022-jp?B?UXh1VElYWncveWN0QWM0R3VQYnJOcHZYVXBtaXhLTU5vSUNxdGFSakxN?=
 =?iso-2022-jp?B?Mkh6eWJvNkIybWVRTEFxdHFjNXV2ZE0zcnZPTlp0blVhN1BiODFSaFB3?=
 =?iso-2022-jp?B?a2FPZkVWanBuSEsrc3NOUGIvYmVGU09ZQkNzenhvaGsyYWpvMlZUK3c2?=
 =?iso-2022-jp?B?L0JDSWkxZFVMNm15dkx5K2UzZk9xS3FtVWk0VTRaWW1PNUt6R084SjdC?=
 =?iso-2022-jp?B?cWFYRU9kQ2xVdUtqaGNMZVc3OXA0K0xaYWZiSHcvYm4wVzlQdnFWSmta?=
 =?iso-2022-jp?B?aWxvK2V5Y0NlbHBHYlk0azcvcHhwcXZLQzBzRDNmSCtLMGVNTmVNUlBr?=
 =?iso-2022-jp?B?Z2Ria0VEUXNiYlc5K29tRTdJaTZEUngrU2c2RXBrcWFsOEFBWTRPTFYy?=
 =?iso-2022-jp?B?czFOQnlhWXZESjFVRlJCZi82RkdpQjJRa05naytrRmNZU3NMV1FkcVdE?=
 =?iso-2022-jp?B?bGNjL25EZXJENEYyZ0FWalRoSWxvOTNBRy9UV0E5TzJ5cEJkQnVvZ0NC?=
 =?iso-2022-jp?B?YTVxTlMyY1llRVlxNGxkOHN6THhPZk41YVFwY2R5RTkxRXlUQmlqYzBl?=
 =?iso-2022-jp?B?NlhJOVpZdjJDRml2c3ByWFd4MmFTc2xJeXQ0RzdLZHUzZ1BIN1g4eW5V?=
 =?iso-2022-jp?B?cUVyU3VRT2F6eWkyMUdkcEtMSGdLSXRXM05Eb28xem1laS9GVWtpU0Ri?=
 =?iso-2022-jp?B?NVRDK3lvbExPSEFhemxmbFBFWkdwZWlzUFhEU1R5N1RnaDA4SjVKT0NG?=
 =?iso-2022-jp?B?cjY2eFhlNkpKSDJFTEFJa0VNbDdVMTVONDVPODVrUTBjK1BGOVZxWDFL?=
 =?iso-2022-jp?B?OHBjSFZMQStiZ2Ruc3BVL2IraDBBbDlMODNZUnpjb2RvaENFNlkxM2Rm?=
 =?iso-2022-jp?B?aTU1ZjdoNm9Pekc3ZkRHcTcxM1RiazNyRS9sR2N5WDlXaElZcWgySTNG?=
 =?iso-2022-jp?B?MWVTckxCc0pYcm13SlBKZ280bFlJT3liQUtwL2MyenNmamhDN201VW5H?=
 =?iso-2022-jp?B?UWFDUFZxeG8rbWZ2L00vbGtFOTVyVGQ1NzZ3R05zdGdVYS9nL0RSNWYv?=
 =?iso-2022-jp?B?d2k3cGpVcVpUcmtiVW9WY2QvZXVjQnYwUHlMelFHRUFOdjkzZ2wzVE1z?=
 =?iso-2022-jp?B?MUU1N3hsTVJNZ0FXUlc1emY5ZWhoeHl5bXIrTkp1dmI1RXZWUG51MWp0?=
 =?iso-2022-jp?B?MGloVmlnT1dEby8yY0tyOUgwci9zVEdXdWNJSkFxcFdkcGlJRGZEMS9Z?=
 =?iso-2022-jp?B?a3NnYkR3WDRuL3BnbFRHOTc0eG9CajJuMm1DNzB6Z013c0ZFcEZCazRE?=
 =?iso-2022-jp?B?WnRlTDQveHVYMGplUzVnZzhNYzFzRUxKaDNUdFRLc0xlS0xtYVhpdmtP?=
 =?iso-2022-jp?B?a092Vitla2hjczI1aEtDT05ZeER2K0V4ME90Mzl2M2laRXI3RXZMVnIr?=
 =?iso-2022-jp?B?OGdRWWxFUVdDcEpBRlR4eFNPdDQrejlUa0hzWG14S2tUREh0Yjh3YTlY?=
 =?iso-2022-jp?B?amVLWkY2MzZKMndsM1Y0dUlZbXhOekVsbEZHaGVUT0lIT2Q2ejQ3RnU1?=
 =?iso-2022-jp?B?aHJObEZrTUUySGlabEN1Z28yZHlnN09rZHQ4a3BDaUwxcHN3RmtmT3VT?=
 =?iso-2022-jp?B?N1pDMGFaSVl2MGF2ZlJrNk5LdDZydFVKS3dDRGtoK3NHVm80Y3Nwam9r?=
 =?iso-2022-jp?B?bjNzblZEckMyb3ZudFhtU3pRWXA5VmZHSVcxaDJXbXNXZE9NRVZVaW1m?=
 =?iso-2022-jp?B?R1Bqb1FBZzEva2I2Sjh5Z0FZdk5KWndaVHI2MGthMVgvS00yZjJqZHI2?=
 =?iso-2022-jp?B?VEpZazZ3TmJvcVNWYnRLOE5rOERIcXprK3h4UldpRXJCTHRLRTNLUy9s?=
 =?iso-2022-jp?B?ejVjSzZFbUlCZTBBVzhYa2huYkY3N1RlRE1ULzUzU3VLYmZ5YmcvRHVm?=
 =?iso-2022-jp?B?WU1YTW13eFlGWUJJUDFST0VTWExUWElHNHpVZnlYbnY3UjkyT1FzcWVv?=
 =?iso-2022-jp?B?VzhyZ3NicXppK09nY2RCSHVoODZUMFVISnlJK0dCZWt4cHM2UGMxMkR6?=
 =?iso-2022-jp?B?bTAydEhkSWlaWmNPYjlRUVRubmpCYnRQQm9Ma295d1pnZWZqRkFET3Jn?=
 =?iso-2022-jp?B?TE5LTmV1MW4ycENROHNZLzkzYmYwMHhFM3c9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OSZPR01MB84010B4C962BC73DD1466779B7192OSZPR01MB8401jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8401.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ce731a-4ae7-4a83-26c7-08dd356c7d3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 13:57:03.0365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQ5HKgVZIkgXHbeg6CmGK8zRvLizCYtYE5HBK/GFwRMFQ5d5l/pPbfgG67IULzRjvKA+RyeeD9fMUWvnxkQcTfVEuBlQiu6msviD81kIjBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8303
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jan 2025 13:57:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17538

--_000_OSZPR01MB84010B4C962BC73DD1466779B7192OSZPR01MB8401jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Dinesh, Sai,

I=1B$B!G=1B(Bve created a MR that adds build/test support for the x86 merge=
d config [0]. Please look for exactly what=1B$B!G=1B(Bs been done.
Currently it adds support to all the CIP kernels.
Do you also want support added for the stable kernel versions?

I=1B$B!G=1B(Bve kicked off various pipelines to test these changes. Links c=
an be found in [1].

[0] https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/merge_=
requests/65
[1] https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/merge_=
requests/65#note_2298307207

Kind regards, Chris

From: dinesh.kumar@toshiba-tsip.com <dinesh.kumar@toshiba-tsip.com>
Sent: 20 December 2024 16:56
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: kazuhiro3.hayashi@toshiba.co.jp; cip-dev@lists.cip-project.org; Sai.Sat=
hujoda@toshiba-tsip.com
Subject: RE: ltp (syscall) failed test in CIP Security image with isar-cip-=
core v1.6 on M-COM

Hi Chris,

Please reply to this email as by mistake Ashrit included SWG.

Regards,
Dinesh Kumar

From: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com<mailt=
o:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Friday, December 20, 2024 7:43 PM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>; cip-members@lists.cip-project.org<mailto:cip-members@lists.cip-p=
roject.org>
Cc: hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro=
3.hayashi@toshiba.co.jp>>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Portin=
g) <dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>; c=
ip-security@lists.cip-project.org<mailto:cip-security@lists.cip-project.org=
>; cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
Subject: ltp (syscall) failed test in CIP Security image with isar-cip-core=
 v1.6 on M-COM

Hello Chris,

Hope you are doing great.

SWG locally executed LTP tests on M-COM x86 device booted with CIP security=
 image. The kernel used in this image is built with cip x86 merged defconfi=
g<https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master=
/6.1.y-cip/x86/cip_merged_defconfig?ref_type=3Dheads>. After generating the=
 results, we found some failed tests in the syscalls suite.

We wanted to compare them with kernel test results in LAVA and noticed that=
 cip x86 merged  defconfig<https://gitlab.com/cip-project/cip-kernel/cip-ke=
rnel-config/-/blob/master/6.1.y-cip/x86/cip_merged_defconfig?ref_type=3Dhea=
ds> is not being used to run LTP tests on x86 targets. Can you please look =
into that ?

I am attaching a document with the results summary of LTP tests when run on=
 M-COM x86 device with v1.6 security image. Please have a look at it. I am =
also attaching the failed test cases in syscalls suite.

We need opinion from members if we need to hold back from sharing the v1.6 =
x86 generic isar-cip-core evaluation to BV members in case those LTP test f=
ailures are effective.

Thanks and regards,
Sai Ashrith


--_000_OSZPR01MB84010B4C962BC73DD1466779B7192OSZPR01MB8401jpnp_
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
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle20
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
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Hello Dine=
sh, Sai,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">I=1B$B!G=
=1B(Bve created a MR that adds build/test support for the x86 merged config=
 [0]. Please look for exactly what=1B$B!G=1B(Bs been done.<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Currently =
it adds support to all the CIP kernels.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Do you als=
o want support added for the stable kernel versions?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">I=1B$B!G=
=1B(Bve kicked off various pipelines to test these changes. Links can be fo=
und in [1].<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">[0]
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-=
/merge_requests/65">
https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/merge_requ=
ests/65</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">[1]
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-=
/merge_requests/65#note_2298307207">
https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/merge_requ=
ests/65#note_2298307207</a><o:p></o:p></span></p>
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
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> =
dinesh.kumar@toshiba-tsip.com &lt;dinesh.kumar@toshiba-tsip.com&gt;
<br>
<b>Sent:</b> 20 December 2024 16:56<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> kazuhiro3.hayashi@toshiba.co.jp; cip-dev@lists.cip-project.org; =
Sai.Sathujoda@toshiba-tsip.com<br>
<b>Subject:</b> RE: ltp (syscall) failed test in CIP Security image with is=
ar-cip-core v1.6 on M-COM<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">Hi Chris,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">Please re=
ply to this email as by mistake Ashrit included SWG.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">Regards,<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">Dinesh Ku=
mar<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> =
ashrith sai(</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$B#T#S#I=
#P=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&q=
uot;Calibri&quot;,sans-serif">)
 &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshib=
a-tsip.com</a>&gt;
<br>
<b>Sent:</b> Friday, December 20, 2024 7:43 PM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;;
<a href=3D"mailto:cip-members@lists.cip-project.org">cip-members@lists.cip-=
project.org</a><br>
<b>Cc:</b> hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font-size:11.=
0pt">=1B$BNS=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt;font-fa=
mily:&quot;Calibri&quot;,sans-serif">
</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$BOB9(=1B(B</span><s=
pan lang=3D"JA" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif">
</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$B#D#M#E=1B(B</span>=
<span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&qu=
ot;,sans-serif"> =1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-size:11=
.0pt">=1B$B#D#I#G=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt=
;font-family:&quot;Calibri&quot;,sans-serif">=1B$B""=1B(B</span><span lang=
=3D"JA" style=3D"font-size:11.0pt">=1B$B#M#P#S=1B(B</span><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">=
=1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$B#M#P#4=
=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-s=
ize:11.0pt">=1B$B#T#S#I#P=1B(B</span><span lang=3D"EN-US" style=3D"font-siz=
e:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> TMIEC ODG Porting)
 &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-=
tsip.com</a>&gt;;
<a href=3D"mailto:cip-security@lists.cip-project.org">cip-security@lists.ci=
p-project.org</a>;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a><br>
<b>Subject:</b> ltp (syscall) failed test in CIP Security image with isar-c=
ip-core v1.6 on M-COM<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:black">Hello Chris,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:black">Hope you are doing great.<o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black">SWG locally exec=
uted LTP tests on M-COM x86 device booted with CIP security image. The kern=
el used in this image is built with
<a href=3D"https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/bl=
ob/master/6.1.y-cip/x86/cip_merged_defconfig?ref_type=3Dheads" title=3D"htt=
ps://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master/6.1.=
y-cip/x86/cip_merged_defconfig?ref_type=3Dheads">
cip x86 merged defconfig</a>. After generating the results, we found some f=
ailed tests in the
<b>syscalls </b>suite.&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black">We wanted to com=
pare them with kernel test results in LAVA and noticed that
<a href=3D"https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/bl=
ob/master/6.1.y-cip/x86/cip_merged_defconfig?ref_type=3Dheads" title=3D"htt=
ps://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master/6.1.=
y-cip/x86/cip_merged_defconfig?ref_type=3Dheads">
cip x86 merged&nbsp; defconfig</a>&nbsp;is not being used to run LTP tests =
on x86 targets. Can you please look into that ?<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black">I am attaching a=
 document with the results summary of LTP tests when run on M-COM x86 devic=
e with v1.6 security image<b>.</b>&nbsp;Please have a look&nbsp;at
 it. I am also attaching the failed test cases in syscalls suite.<o:p></o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black">We need opinion =
from members if we need to hold back from sharing the v1.6 x86 generic isar=
-cip-core evaluation to BV members in case those LTP
 test failures are effective.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black">Thanks and regar=
ds,<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black">Sai Ashrith<o:p>=
</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_OSZPR01MB84010B4C962BC73DD1466779B7192OSZPR01MB8401jpnp_--

