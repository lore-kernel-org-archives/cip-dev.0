Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C67FE9126B
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 06:46:58 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15199.1770274008738856186
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Feb 2026 22:46:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NaGo89J7;
 spf=pass (domain: siemens.com, ip: 40.107.130.1, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBbke020ozOHdxazA26qoKBTAb94PHLKR08Yu+zc2wCLuws/PuIGGhUhyDdj2tf2tn15i4/KoWOWSvJInQy+lt7FUTtdp+QgpDt0Z9/tSJwN0BYASnLPSMqz1o8SEXtYTUh4gqiDLYhF+GsO0GvqtsaOgHmFoaxWecEVlf0N/4GWLn+ZV4E82Ieid+9/kPLAxL115F+RYl9XTDLkY5sIFflC6sCvmv1qlhLQhZcl9m6RXNgWQ3+i4EONV67YCIJ9Um3sED7MRrpePuqvgJC/xnW/I4ojY+Smx45vmLxM9eYoB4EU0Dqb5wRwu8VXsDqjWNvJevfRtUnvvpYmFbeIXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AlU/ENa/kiCJJwEE1qvFxgNdnSOpY8KoLcjHxprQP4=;
 b=wblVQuzvhJSLrg3nr9iTHBc6IKpQl4gFoE30lMkFs85IJgY40954NJGvJ/DgRhxTC/ywqgdSj/YBCcA7ne1XEnyvFtPSc9l/1+TceXkoqKAEqGZTQCO9bLUjQBhx3Klpm/xkMYNVUux4GyfqfpGiKksssM36k+4shnkR13S5j9Ktteh4YsshhSE2yJdFuf+9VfNdpotojKmC5NUg/ay0l1mnhavpVg2vPBmRBlgpPftILHBNDxpJpoUXWKfnk4tVUrQotGDVyVVb2k0Ja3bTv1W2Em1uEvh4zqiEH36LHPPvZ4LY61lNa8RMTXWReAsOtm4R9b4qXhguU8Kuk6UyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AlU/ENa/kiCJJwEE1qvFxgNdnSOpY8KoLcjHxprQP4=;
 b=NaGo89J7ccmwrh1XB5h2CjXOFLKTDPLDeGDMyaSrVS7857Rzdk4R6PDpcvg2UmNEFQjEpxJtcO/YBSbvspfWSI9MOTjjEjkwHuoeK47ZJBbXuGVL79v7Upeu8kogs/K4Oo2r2PdkVFErX1G0wWnnG8XmwJfM6o0FmEHqJLojTx14IavMQvmK9cGhcIcXeTIm8DdAMDJNx3zXLoL9QwPclmXfEAySLLSX1V8C6Q7sQS0XYF/Ls1dkK1CxsgiPy+bPiLkjkSgX/REBAS63CD7DMwwQ2iRzHNjEQk0P3w2Ii7IvxduWh6EAcGDcUZS6bRpnCtQaQrRGQ5TFHqk19JGK2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AM7PR10MB3686.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 06:46:44 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Thu, 5 Feb 2026
 06:46:44 +0000
Message-ID: <a2cb468e-9aad-45ca-ae41-233c410f403f@siemens.com>
Date: Thu, 5 Feb 2026 07:46:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1] doc/README.factory-reset.md: Minor
 corrections, verification steps and what to look for during factory reset
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 koshiro.onuki.h55@mail.toshiba, kazuhiro.hayashi.f74@mail.toshiba
References: <20260205044638.14716-1-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260205044638.14716-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::9) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AM7PR10MB3686:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a82765-a71b-46bd-2182-08de6482537d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?STBTUklRRFlWQTh1TEF1Z3U5YU5PdExJMlRjb2pUOGNZeEVYcXc3K0pXWGZC?=
 =?utf-8?B?WnB2VllZdGQzMklmVnhDdCsyelR6bUt3ZVBRQ2ZxQndYYTh6cWFacTY2K25N?=
 =?utf-8?B?aGJ1aldZWUo5YUxhRVNERTlTQTlhb3Zzd3d3Tm96SW04K2FvMEhMQnpodlh6?=
 =?utf-8?B?MHNiaE5KNi91ZUtIOGE3RVJwNE5rUmhTVDBWc04wN29IOCtkUTBMbi9yOEtV?=
 =?utf-8?B?UkcwZmlPUEQwRFZxVm5ETGZPVGkwK3pWb1JraXRGZjdKYmFKcHh1VzYxQXI3?=
 =?utf-8?B?elZyV2NtZ1ZadlVaOGRRbVNxakloLy9uaEdSYS8xMG9ZeFNjVHhJYzJyN2Ru?=
 =?utf-8?B?aHVQUUdnN2NYZjA1KzFURUU2Ti9jTE1yZEJNVWVHTldmc0hrVHBYMTZ4ampF?=
 =?utf-8?B?VEdOOGFkUE10azFsNHlwMFp6aFU4MTlzVnhxOXVyb014Zi94SkxLeDdNNFdU?=
 =?utf-8?B?TlJuSmVETEV6SHJxS2t0SlBROFV1eHl0N3FGcURsK01paW1EZFVXeTA2cjVJ?=
 =?utf-8?B?UEJRZUV2YnFoNEcrcit5NWw5NmxjdjdmQ2JWMm95ajRMQ0V6VkZLVkp6SkRY?=
 =?utf-8?B?UkJWMUhiSnQrWXNOY0VjY2ZzbXNvMXU5WEZoUy90R28xRS84MENZRm9CdVhW?=
 =?utf-8?B?TGxBYSttZS9UQTQyWUU1dkRQc2lPNDR5VE5QSFRESXhGZGxTemdYWDYxUDhj?=
 =?utf-8?B?V1YrOURBQUVxcUZNR2xnaDZDL0d0dlVjamdLbS80YmtuV2NXZnFkVlJTakRy?=
 =?utf-8?B?Tks0TlhDbDZPbk5yb0NBUHhzWTlIUk5rK1lJT2pDVEw4YnZWKzJGUUFDVmlV?=
 =?utf-8?B?cW1SdnFJNEpENUJaS001em5vNTZPTFJLeWprVVlGa2VvcWwzd0dFMzZoa1Js?=
 =?utf-8?B?bFYwa21zUkhTb0tzNlpGaTgvU0puSElKTHpjRnlnS24vMmEzaDEyT1NFQUti?=
 =?utf-8?B?SjZqRDNUODZiV3FXcEpFeGJrWm1RdWRkaDRzQk1kQTNGMm0rZ3pEYXBRb1Nv?=
 =?utf-8?B?cVhCdkVxZmVMalZ6b2QyeHBzNkJBZUtLM2t0UkRzZnJJRndaRE5mOE1ZbjNq?=
 =?utf-8?B?QkdORGFYTUdXSmpTY2VMai9iNmtOOFVWQXZLUDU2WXVKOXp4NWg3dEg5YXp0?=
 =?utf-8?B?RVZtMENJNTdwWUZQL3pMQzhmZkxtU3plR2dpejYyRzJmSW5wMFVjakRJeGNE?=
 =?utf-8?B?bTNMR3BWaERMcFgzcERWMkh2bjVkUFBFdjFyNlF0YmZlOEtKNGp3MWNQSE9E?=
 =?utf-8?B?ZTUxU3lUaTZIcmtPcHgvOW5MVDl4bm5NNUVKeEY2NHROS2NlZ09DakpvcVBj?=
 =?utf-8?B?eFFSZzduY0xNazF5NlpmaVVQL0hBSkdIWXpLV0JILzdhQXVVUldvYkVqNHI4?=
 =?utf-8?B?UndSejRRemZoNnl3SHVtOE1wUmZkUlp6YXdrOEVwdng3VEJDbWZ4dnhmZ1Uz?=
 =?utf-8?B?R3dOK0dWMExhRTFtcVpVRVNscHdCN1ZWRlo5d2duRi9QZk90S0RERUZobjV3?=
 =?utf-8?B?dFp5bFlLYlYxYm9STUIrcnRMUkdvYWlQU2RBK0hoV21QTGFKczdMS2drN1NI?=
 =?utf-8?B?NDRjSENGV1RVc2dGOHl4OEZLVzNwS0tzb1IxR3FldmtKYXZ4UWVGbHhHM0NC?=
 =?utf-8?B?eDJsWGJMNWoxNWp4Y1RzdnltNzFrWThkS3ZTTlJjcTgrZ3c0dXYxZzcwbFBF?=
 =?utf-8?B?L2c1K2NmZ3hVaXc3emZ3TDdOc1hjMmVYbmFrQzhEVnRHU3dSNGNMeGNSRmhC?=
 =?utf-8?B?R20yU3V3SUVtWTRtWjAzZEtRUG9BV1VmOVlGRmRkdGVzbkhoSjdPeitVZHd1?=
 =?utf-8?B?czR2Q1kvSWFHejluQXQ1MG5uQmx5a1pSdUxwbXVDYlBCRERGVURmMkVhRUoy?=
 =?utf-8?B?d01DaXFlMUQ2aDlONHRqWDNiTTlad0h0V3krR3RKcm0zQ3Zldi9TVTZaUTUv?=
 =?utf-8?B?amJuU0E4MEhvMGxxSlVKS3NhZTR5SFg3VVRLSW4rT0Y4QzJlZHA0MDBaRU1K?=
 =?utf-8?B?WEJGRUhUS1MzM2pvWERLdmhCWkFNbExKRFZUYjYzbGpSTjRpQkRuVDJlaU5S?=
 =?utf-8?B?Qmo3RGszUEgzSFhQOThkMEp1MGpDbGRScTNvVFVJcE5ESlNLT0NFYUtMWSta?=
 =?utf-8?Q?Ea24=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MU0zaWQrS3hib2c3OHV2b2JzY01LekVHWVIzbzJ4dERrUGNuaktTOTdDL1N4?=
 =?utf-8?B?Z1czWWRaS2hTTmVqbXhzL1JrVy9RVk5rd3pkR0NobFRpcTBkWWh6cDg2dW0z?=
 =?utf-8?B?QVpOVHhxd0xPblF6Zy9INXNUSFZsRG1PUDFxcWtheFI2Zngxd0pQV21VT3dz?=
 =?utf-8?B?YW5nUW5IY3FONjIxMmI5Y2JMYi85VFNpNjZ6UllFck1TUGlyUzVaVDRvbDdU?=
 =?utf-8?B?UDc3K0VoTndSWHVSVENhalNHQzNlNzMvSTZYT3QrU2pXQWhBSzVwZWpYaEhx?=
 =?utf-8?B?cTBhRWZYOHNHcFZCVm9VVmM0ZmdnQjN0U0oza0wxcStBNFRrK2ZtN3JMeHFF?=
 =?utf-8?B?cmxJOUZTb1VxY0l4clhCWlIxL3l4VUxBUHdEVmJWTzJyVWNSTzN6M2NtbWVO?=
 =?utf-8?B?L003WW9MdU1FWGp1RU1xQVY4dURQMTUzVVhHSFhZVG1NYjNFQkpXdDNaVFhm?=
 =?utf-8?B?ZWdXdEs0VEMzM1ZzL3k4RGdPZnY5NHorNHk1R0x4dGNPVjIrTXhVOHJ1bWIz?=
 =?utf-8?B?Z3hmOTdmbWxid0F2M1gvbTRxWU5EV3R3dWtDdnM4eEhVOUd0VFYvUFEwQkhq?=
 =?utf-8?B?eVQ2UmFzOStmUkRlZ3h0LzgxMGVxVmVYMmQ0QWVDTEVUdSt1bWRTaVI1T1E3?=
 =?utf-8?B?bXo2WC9wSDBuM2J4NGd4Z0N3aTVVNmNwSWtrOHBjQjFJUWdNc0cyL2tPeEZE?=
 =?utf-8?B?bEFKVUhocTQvTnJCbnR1elZFMndrbVJEdTFVTTVrK2JpbkpacGNlMzhLUVhs?=
 =?utf-8?B?MGVIZ2hWUjFhUTdkZlZRcUVuK3ZucjI1R3lISzZGckdSL0FRMGpITFpBUC93?=
 =?utf-8?B?ZWRFT1RpNnBhUXplMEdQREt3Zk9ubWRXR2RVQklWQzFkM0kxM0JWYkFWeExR?=
 =?utf-8?B?SXVvY0VCUGI2ZHZvRTM3dk0wcmp1cUFIWXZxdDFTYU1yelFNM1k0TFFTc0xk?=
 =?utf-8?B?TlBYaU5jR2hFbkFRV3NDMVJvU1lOWUFzOUlWbDBCdFdwWGFhQU1nWGhBcTVk?=
 =?utf-8?B?V3daWHdlcHhqWXVQVGVFYWduQXdJbnJKMDRrakVqNVFHYnBHc0o2dzFhbEVs?=
 =?utf-8?B?YVhBM2VRYi9tZ251T1BJdHluTi9ZNFl6b1VxQlNLenlKL2ZRVzkrZEU4UUNj?=
 =?utf-8?B?K01uU1NYRDlwZWpSVFVYdXBpMUwyVWh0UzNSaU5FSFJxc0QybWJsdGR0NTZy?=
 =?utf-8?B?L1B2SDk4K1Rma00vcTVjTUFYbHpSWjFyOStOTENnTzk2L2U3UXoyTkkxamNC?=
 =?utf-8?B?OXd3SmI1djdTdXhzMFowNVBhTCtXaUtXMXNDR2hEK2s3ckNwaUt3UUJnV3Fr?=
 =?utf-8?B?MW5LZmdzVVJPeGg4cllsMTNpZmxGVFk3Zlg1M0RJWjE0UlBuajltQjk4YTFz?=
 =?utf-8?B?eW5kUm92YWRLV3VPdkpnR256MUd6UWhhMWY5bEh0djN5L2YzRU90Nk9BNDBi?=
 =?utf-8?B?TU14akFYYnlUNTRMTi8vY2FoTWJzdEVMN0ZqZ3VESVJNcHNJUnVWaHJ0Z2w3?=
 =?utf-8?B?V01UL2JBdk1mREEzTFJITHU1TENyTzEwUUg1UEFtQXR0VTZCWWRpOHVxcTFp?=
 =?utf-8?B?QW9idjVrR1NxaE9FQlgxeHhUSnFmelpGVk85bnlwSDkxeklkYi9MNE5QbmxG?=
 =?utf-8?B?TFkzMXZVdCtwQmpxZzArc1JwdHBnREswOVM1ZGl3UTNCcDA2eGY0bnhxUnhV?=
 =?utf-8?B?YXRVYXZVbkMzWUt2TEttTUxYY1pZVHoxRWxySkpMTmpCeHl0d1MyN1BwSU1J?=
 =?utf-8?B?MGhwVGwySWZtOW1vY1pVWlBieGVoaWRLdFgxelFpeXlhWWIwaDI3WWJpanF1?=
 =?utf-8?B?dVJzdzRsSEZ6cVFEdlVCcy96N3ByeDkzS2QzZlc3V3NGSS9wTlEweEpGeEpG?=
 =?utf-8?B?QVZKK0haRGNMaVFvVXptSk83US9iZjZ0NmxxRmVVODBHazBiOWdSOUx2OG40?=
 =?utf-8?B?VTZJN20wSkFyUE9aTENoMFlWQUNiRjRrZ2xSQmlHTWNEd29ZRkJxNi9JLzFj?=
 =?utf-8?B?bCtlQUlaZEEzS0VPWGhPaGtZdGtISTg4VVluaGF4eWlROFlCWVVFYUcrUFRx?=
 =?utf-8?B?ZHN4dmtOWFVHSGtPTkYxTkJ3RGRKcXhRT1Mrd0I1K2lva2NlcVRVWFcwOXdH?=
 =?utf-8?B?N3RXN05aM3BnOXVnYlk3bHphWjNQVE84OTdQaUNUcExHKzQ2aCtJckVGNlRK?=
 =?utf-8?B?bEJMa2ZFb25yOVRSLy9uVS9JaWJRWlhoSTZldmdtQWx2VmhlV3JaQ1I0eUtx?=
 =?utf-8?B?SmVIQStETlp0d052VnFaMDhNeGFubTJsL1ozQkVaNnNERFRZb3g4bS9Helg5?=
 =?utf-8?B?T1J0VVRBWC91VnpLMUk0VjhHZUFSWlZaWU55Y3JIQkttYURYSytzUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a82765-a71b-46bd-2182-08de6482537d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:46:44.4234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqzBluW40+YJnkLS9d746ZnYdBIsxvyA8b9IXX6yqyORE3UwuVHV6NfFdt9UDTbePEVdfnNAl4fjMUJAE4FBXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3686
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Feb 2026 06:46:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21831

On 05.02.26 05:46, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  doc/README.factory-reset.md | 44 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
> index 729912b..ef35225 100644
> --- a/doc/README.factory-reset.md
> +++ b/doc/README.factory-reset.md
> @@ -1,18 +1,18 @@
>  # Enable Factory-reset
>  
>  To enable the factory-reset functionality the following two elements need to be installed:
> - - initramfs-factory-reset-hook which executes the factory-reset
> +  - initramfs-factory-reset-hook which executes the factory-reset
>    ```
>    INITRAMFS_INSTALL += "initramfs-factory-reset-hook"
>    ```
> -- factory-reset-helper which provides the helper scripts to set the factory-reset marker
> +  - factory-reset-helper which provides the helper scripts to set the factory-reset marker

The indention of items were inconsistent, but do they have to be 2
spaces? Below, you do not indent at all.

>    ```
>    IMAGE_INSTALL += "factory-reset-helper"
>    ```
>  
>  ## Technical details
>  
> -The by executing `set-factory-reset.sh --create` a marker is stored as a EFI variable or on disk (default `/dev/disk/by-partlabel/efi`).
> +The by executing `set-factory-reset.sh --create` a marker is stored as a EFI variable or on disk (default `/dev/disk/by-partlabel/var`).

"The by..." still doesn't read smoothly.

>  The marker on disk is intended for devices which do not provide the facilities to set EFI variables.
>  The initramfs reads this marker and formats the hard-drives provided by the variable `INITRAMFS_FACTORY_RESET_DEVICES`.
>  The initramfs-hook will try to detect the previous used file system and will format the partition with the detected type.
> @@ -27,3 +27,41 @@ The removal of the TPM keys can be deactivated by setting the variable `INITRAMF
>  As the factory-reset is executed before the disks are unlocked in the initramfs, the file system type must be provided with the
>  variable `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE`. The factory-reset of encrypted partition is not supported with the file based
>  marker.
> +
> +## Verification
> +
> +- Set the factory-reset marker with the below command:
> +```
> +root@demo:~# set-factory-reset.sh --create
> +```
> +
> +- Trigger a reboot as factory-reset happens in the initramfs step:
> +```
> +root@demo:~# reboot
> +```
> +
> +- Factory reset runs during the initramfs. The reset scripts format the target partition with the required filesystem. This can be observed in the boot logs similar to the example below:
> +```
> +.
> +.
> +Begin: Factory Reset ... Begin: Reset device: /dev/disk/by-partlabel/var ... [    5.834137] random: crng init done
> +mke2fs 1.47.2 (1-Jan-2025)
> +Discarding device blocks: done
> +Creating filesystem with 131072 4k blocks and 32768 inodes
> +Filesystem UUID: d4ec21bc-988b-41f8-8e71-4d2b24cb7074
> +.
> +.
> +```
> +
> +- If disk encryption is enabled, apart from the formatting of the target partition as stated above, the initramfs scripts also encrypts the target partitions. This too can be observed in the boot logs similar to the example below:
> +```
> +.
> +.
> +Device /dev/sda6 is not a valid LUKS device.
> +[    8.375556] tpm2_policypcr (224) used greatest stack depth: 11736 bytes left
> +persistent-handle: 0x81080001
> +action: persisted
> +Begin: Encryption of /dev/sda6 ... var: 12/32768 files (0.0% non-contiguous), 6385/131072 blocks
> +.
> +.
> +```

Adding Quirin to help with cross-checking.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

