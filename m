Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BAFEF5877
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 17:10:28 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.17])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17148.1771348221070954348
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Feb 2026 09:10:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=A6Mi0wkM;
 spf=pass (domain: siemens.com, ip: 52.101.65.17, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E62AEBWdwLniWbMnfkyxEH+wxnIzMMkWMDyO2WQ6U3FsTDNk7RjmUOy9M5X5IsNTIKG/HlfSCMSQlzhoq/n4A2e5Izrhr822pnxNgIbbcDAQsAp/n3KmWSEZoOFbN78ikB7+5RQPIrtoih/6a77x4ubz442y3PcqnpRhb+UsEwm+lsaxE8qwppC5+gHMmvrvV5ZXeqF3yZLyRE6y01X5myB4eazJe9uJGTZ3tm1DKS+1FvTW04hjQvfRTwhDEZvFO8JCORuHNQ9I+enhKWg7c4PZ/uH2ZOmg8/QdemnpzdYtmf6YYn2t3bmcyFksTq3jqgsCvgnsb/hvpWjrNwsWmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1BrUqUb6ige6yUYt9Euc0rQ3m2IYdxVsC5E5SMbnpY=;
 b=aZ35aFAMy3KHnD4HwGMdlYmEL8QNuUuX6Qz0cQRKzvybB9Af2u2tlTClTj8VUk3ngQaCqECNny2K0TVJycgXCRGHAMoWuTxjwy5H28lJkXwTyt5npS9NLbTfqENRmpInxNQ66INhoRSxsZTYk7tcbiisOvpgtYCyMIIf81EvkEM7RbjBkzz2PlU/gOtt0dFu1my55bFDo8jAEHO/8fibJV+bXWLquh8/Rnloun7LjeStxbxDWMxtokLs2JSApw/B838yUOg4b+RuVGtb+tf1aT2x7oCTwp/BIQ4koZdYF0/o5u5Vz5pGrnx0aTmecZFhmNAyhuv4fDIEYAx6jy9bOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1BrUqUb6ige6yUYt9Euc0rQ3m2IYdxVsC5E5SMbnpY=;
 b=A6Mi0wkMFMU1PJvPkZVn0NCMEWj9EcQG2lZpBgp9zsR2s5dJlQaTbJpQSYb1tIkCCqVIPuMjPnL+CLAU4qyByLzX24i6itdxqBNHEl0ee9zuSRdZwBw3GT7mHgbzGGTtHF1coxCmCHDoXJqFBYBa8wPj7u6t4q0pi0faBFvgzaH6g7ovGJT/1lEeY2rIdjBjkiNDQZKbOKNll6yVbXqJXEwfSdNJIy0GzLJgPZmYaYjYUmVx6fjIkR3S1l486UHdGq1Gw454idMcguElOG4fZCA68sAiu+jHY6jQaXg0g69SoagCivujf8kj6V5QNkWfYfGOlWt6D/jCXX7rNYOQtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by AS2PR10MB7501.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:593::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 17:10:17 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b57f:1a19:e3c8:fbb6]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b57f:1a19:e3c8:fbb6%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 17:10:16 +0000
Message-ID: <e2bf1e86-4e26-44f5-a752-9b6ed50ca101@siemens.com>
Date: Tue, 17 Feb 2026 18:10:15 +0100
User-Agent: Mozilla Thunderbird
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Chris Paterson <chris.paterson2@renesas.com>
Subject: mtda-mcom in maintenance
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0028.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::18) To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|AS2PR10MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 2414c0ed-1d90-4ad6-2418-08de6e476be4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cW5vK24xbkRXMm9TRU43VGlQZTRMRGhFd3U5aUN1aDR2enVuV3R0ajdOM3dL?=
 =?utf-8?B?ZEttQUR2V3dkdnFOZ0hwblhDYkIxTGpEUnBoSHg4bm5mWVZqZisvY2JvZDFn?=
 =?utf-8?B?QUlsNkhqZExLUWNvam1sVGpGMjV5TStHWTdLckRtOVRBRVhqb0QrYXVXU0ZJ?=
 =?utf-8?B?T0tXK3JEcmJNcjQvYWhtU3BRcWdjRUF3THFFd2dzU1laNmlvM1BuSmRtcGtB?=
 =?utf-8?B?YXU3T3dDVm12M0QxUXdzZkJSYUFhYU91YW9hakk0R015ZHRMRzVtMHpWZWV3?=
 =?utf-8?B?ZHVjRTVma1p3OVNFMERKRXJFa3I0RUd6YUhxZi95VlpabkoyQnZKZ2YrOUFw?=
 =?utf-8?B?dVh4aUczUDFLTTNjZ0NUWGdkZStIMHJjQzU1SjhlZDJEMmwydVhLODFxZ04r?=
 =?utf-8?B?WVQzTFR5STgxZjVpMzR6NlRSeXJjcUFMVisyWVlYWjBUVDJKekI2bHdPU0NE?=
 =?utf-8?B?SC9YejFDUVphWElrY2x4MjdCenVONFd5eG5XVWJINFU2TWR4VDZxYVhpM1Rs?=
 =?utf-8?B?ZGhWTUV4RmtjamFPZU51WWNLMS9BNjRDYytOYmZWTzlTK094WUp2TEF3TmtT?=
 =?utf-8?B?dyt4RWphc1dLYVRVMys1QjhWZklQY3R4VFZoaUtqSU5YN3h6RXgrZWZxMVhF?=
 =?utf-8?B?bm1WcGJjd3VUTlNhMmYwRXZwV1FqcnhSYWpHTDhBN29UOGN2c295Q2RONmVv?=
 =?utf-8?B?SmtEaTA2cGFPQnRhY3d3bUtGNXVPeU1sdzB6RGtMaVhqc3JHdzZXUkltREFX?=
 =?utf-8?B?czBkS1ZGOStCTGM1bDhLckNoeWNhRFlUWkxDanhJd25TcE1tSkxOTUpkM01C?=
 =?utf-8?B?dDJoME1uNmRucHhYdmxDWXNNQUJ6TWlNalFsNk9uQjlkYzA0S29pNzFxSUJJ?=
 =?utf-8?B?RXFPY3kzM2pvMkZIZTh3anlKLzcxS2RUZDF2MVVtb2I4UTA0WTVvRlZsV25q?=
 =?utf-8?B?aHAvbkY5VFpPMm9jVS9xbFVOdTB5djQwTlBzWWZ6cHBWdGVEV1NaZHliY1V6?=
 =?utf-8?B?dHhkVjhRN1BxTHVoY2hFWHZtVk1BcitsL2dHdVlsV0RUTUNjWTYyWitwQWZt?=
 =?utf-8?B?d0FCUHhNbzhQRWNTS1NtV1VmNnB3VUloVHA2VG1uSG0rQ0p6a1VjK3NCN1J1?=
 =?utf-8?B?UmFIQUJyaE5iV09VTWJrZFRvQUV2RklDT3U0SVpHRS8ralVxc0Jsd2g3ZTFo?=
 =?utf-8?B?NERSb2R2NVRuY1R6YXJLcWFXTWNIK0hPVWdIUm1WalJ4RjlzaXZiYTA4MUJ1?=
 =?utf-8?B?TFJwdWtCV01SZ0ZZSmxMR2h1dWVQd1N0OU1qcTcweEtVVEcxcmlVVFRoRFlQ?=
 =?utf-8?B?VVJJQklmMHNJSmdDd281QnNGKzh6bEd1SlVtZWcrUktwTTZaT05lVktzZ00x?=
 =?utf-8?B?NThLa0ZrS2lBR1NPdytKeGZHOWk5SmNpNXBtWEFGZmJpWVpRbXZqeGV6Wk5D?=
 =?utf-8?B?b1o0UFlqTGxKSkFXZVFpMEtUTUQvMFhNc3Q4VzlOV2RxVVVsM2QvWklrOFJE?=
 =?utf-8?B?eUFvdFdZNTlGUmNLMnd2eCs2T0hNNG9zUG1iTUEyYlkzM3dwMGFOSFdWWFJJ?=
 =?utf-8?B?Y0tVdXZYekRzL3F5eWhPSTdteGg5THd1TkZZdm4zQjh5MS9tRHNObDNidVBX?=
 =?utf-8?B?MUdLVHpFbURrN2NWQmR4dnVZRGhGZWdKdWNuUDdJVHZMV1d5S0lpQ1NBaVA5?=
 =?utf-8?B?Y3dudW9tN0tiY2dtbE9YbWdtY2pYZU9yanFLM3NBZEFZUDczZG1ERUFSOFdZ?=
 =?utf-8?B?SEIwU3hFeFIzaGxrbUNEdWRJcEw4UFhBcXcxUFhyeVVVWGpHQWNZTFpmNGI4?=
 =?utf-8?B?d29KWXB6eFdXdWlRSjVLYXhlbXFLZHFNOEw5VzdWNUVnM2FHanV0akk3eXBS?=
 =?utf-8?B?QVR5cTc1bHhtTm84VnhFQTBLTlhSVFc2RitCTmo2M2toWWNWQkNTbG92eEJk?=
 =?utf-8?B?TWNrZHgxaXVYYXlMK2NEQWtPUVFZRDR6QnlqZzVGdDU1bEptbk10RlhaanJq?=
 =?utf-8?B?ZnRraGc1R0NpZ2RpVlBHSGJxODl1L1ZNN0cwcWk2Q3BkT1dvQ05PTFJHR1di?=
 =?utf-8?B?UG9uaERDUVpBTVN1Y28zblZuY2FUcU9uSzVhNXhKL2Ftd2ZpZThPNDJYcFdo?=
 =?utf-8?Q?O5og=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cmk4OWs3ais1bXNZTjVWN0VnZDV4UjlkeGZLbktmejhsSGU2VzJGNTU4ZEdD?=
 =?utf-8?B?ZnllcDdJK0J6OWkvOUdtMDJueUV2REtyQVd1elJIYWdvcy94bXFWRWNZQkxm?=
 =?utf-8?B?aG5WNjE4N1kyTWxWQnp5akVaeVV0NmJlL2lOR1dobzFORkYvNHFsa2RiM1FP?=
 =?utf-8?B?ZjdITTFSYVMySUcwa1YrN29xYkt0QVJXb0pTUHZacXBiWTRxNk0yNnA2Qmwv?=
 =?utf-8?B?R0ZIZXdBWUdPZUpnMEdSbFgxenNlcGRFbXFOZkY1TFhnVW1aTCs5RDAwZWtz?=
 =?utf-8?B?eUpYVFZCZTBJUW45ZWpNeGJaNHNlYm9pWkVhWjFBNzBBaHgwck9ua3NCUWor?=
 =?utf-8?B?clR2OHhzR3NUQTFkS0NYa0QxVXFyR2tleWhtK2RpSCtRVDRUVVM3Y3h2RUl3?=
 =?utf-8?B?Vy80Y1hjUEdyTk1ZNGdic0hBdlRwbjdleGNheFMyamJoWjRRaDcrZHc2QWdk?=
 =?utf-8?B?Y0JQUW1QQmhBTEFvSmkwS0hNWWdKNnBBSHp1ZzRCZnFvMnVpZkRJbEE3d09I?=
 =?utf-8?B?SWwyQjlmck9QNWhUR0VyS2hUQ2lUQlBnbWNiaS8wWnZCcldTM0prckd4UjBY?=
 =?utf-8?B?Tm9DZmVQcHgwbmN0RFVpbmxyTGx1YjhPOWpNZWV4aG1SMzdDd2p2VE9LVnFu?=
 =?utf-8?B?bGZPS01pTEM2dEhhdlBjQjNBQW56dGJqUHpCaFo3L3ZTOHpmRHBxUmMvaGRI?=
 =?utf-8?B?WVBPUkJ2OUl4VVcrSFliYnRaNUlDdkU2b2wrVXFRWVBlWkd0NTRHSlBycXdZ?=
 =?utf-8?B?NDh4bDZkU3lseFJDMG4zOXFDWjlJSndFOHp2SEhFajV0Q3ZlZnNzZWpnbWNQ?=
 =?utf-8?B?eTFmSDNFWklDRWhhMEVDeVNuUDBIRHl3TFBpeDR3a29JMUUwWTRWUjFIZCtk?=
 =?utf-8?B?L0s5NllMRGZVdFNQbW1KcWhOOGZPY2hMVExSTDVyOWxSRVM2Yzd5R295dmdx?=
 =?utf-8?B?bDNlUU41S0lLdmNLYW1PU0tDajVkWFAzd2hVeXlQNHUzcXNtdjVlWmpBbEx1?=
 =?utf-8?B?VE13Rm5UYmRHYklzcHM5NjZSQ05vQlVtUURVanU0WnJrbDNadG5wNW1jSmxD?=
 =?utf-8?B?QUdmWERBUHp3UjJHaUNJSjFEL1lWdkREeEorRUMzWVVBSUt1TEptdnFIV0Fx?=
 =?utf-8?B?VmNkSXpHczFzTHd3Y2dvL2lQZm9OZnZ6SGNTb0QzVStTN2FVTmxxTXU1aUM4?=
 =?utf-8?B?Y1BnbER1MHc3aEdTU21kOFExK05rUFFhdHdRcWdYZTNxZHgwb2lWNFEzOXAz?=
 =?utf-8?B?dERNb2lpZVMvb1hxUG5CRnB1ZGRiL1ZiYmFubXpPMDFFaTFZK2dLcUlVYy9O?=
 =?utf-8?B?NjYrR3VZSEJPWDBYdHNNS2ZuUFNnRm9zRFA3V1J0c2ltWGJpUko3L1NseW5Z?=
 =?utf-8?B?L3p0TVBwV2FDTXd4NmdMWVVXSXVuNnBQUmVDTEsyTXJpaEE1S2lvMVVoNGhZ?=
 =?utf-8?B?TXliU1BmTGxsb1E1UDhrcm1GUHpKQTNFN3FsTUVkTlhyemN4Sm5pWWwzZy9C?=
 =?utf-8?B?WmpoWFJiNlNRYkZJVnlzSGlwMHJmaWZKRVgzdmliYWU0K3dBRGF0WkpjcURI?=
 =?utf-8?B?WGI4TGdJNnVibXQ4aVJUcExkZ1dzZ1ZRUkFtdHFXdlVlZmRFV2NvRHlxWkFo?=
 =?utf-8?B?OHNxTkdoS3dNdGlmQ1JPNkwrSm5DRzZBS3d6ZmRFRkhXS1NxcUtVNENYb0Vp?=
 =?utf-8?B?WXRQMFJwRGtheHpLSmRpeGtuMUZTck9PVWdkd2Uxakc4NzgyelZBUitnTFNj?=
 =?utf-8?B?WGxjNHlVcXRkaXpCbVJOVEowTWYxZ2hUZW9uUElpV2ExZktWNnU5b2JHc2g5?=
 =?utf-8?B?SHlNUnNPcHAwMmVWVHp0a0JIR25OTG5VclpOSlJaa2VOYUlpNmovV1QxYnpJ?=
 =?utf-8?B?T3d1QUlSQXllTEZQNm1qT0h0djVLbWNsSUV0NmJDNVZ3K2tEY3lwNHdtSytw?=
 =?utf-8?B?ZmZtZi9VaTY4eGtncHNjaGhMQklKZGNVdmJFVDA0WjVwMUdmTmdHWkNPWllT?=
 =?utf-8?B?bnZnVFZLZE5IeHNIYzEwSURBbUFoYUdLM1ZpbXZVV1AycSsxTTdUcU1HN1E2?=
 =?utf-8?B?TThqQ3BaSHNveml5TW5rOUthWDVtaVEwcWlURStEMC9jVDZuWC9tdVN0QXVU?=
 =?utf-8?B?VmZ4KzRTOXdoN0Ftb3lZa3VkL0t4bnlhb3o4VjVrTVc4T0xKUFFqck1YRktV?=
 =?utf-8?B?T256K2xHVGk1TnIzOHJMbE52bGpGRzRodDdnSXdqdUVDTEQvSGdieDlUTVB5?=
 =?utf-8?B?NXBZSFlzYUpBNmZvNFFIazI2dmJTUldMSDg3M2xheElvb1ZJZTZOQk5SOE5r?=
 =?utf-8?B?eHQyRTljSHhwMi8zUTQ2RHlmemlUSmtDSkExZVhxVmliUk1ISDVUcmg5NmRw?=
 =?utf-8?Q?pX8ysKJ5EpGIarYk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2414c0ed-1d90-4ad6-2418-08de6e476be4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:10:16.7500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuknuuV/semnVpNwB1VuwaFHYlrh753Fi7IRGagDaZWj2QuLAHbrUpo8BUpa35ceYMGCCeXKWfGBKPGZXpeIE07tQnLhGIm8YeV401GRJ1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7501
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Feb 2026 17:10:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21891

Hi all,

the mtda-mcom is in maintenance as the mtda device sd card is no longer 
readable. I will flash a new one and install it next week.

Best regards
Quirin

