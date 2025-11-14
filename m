Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AE8CE7B13
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 14:19:09 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.21])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.80.1763129912111319534
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 06:18:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Pkindvu7;
 spf=pass (domain: siemens.com, ip: 52.101.72.21, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdvGjaXBgC7o4KaqgVGl39qpryAnCGzUPqKCpBWcDJ4Dbj0UIu6GxS6jz6qjOy+b9gOieKpp6RLXEZHZEZrzlKakQ0uVWstjo/W+PEb08b8XqStQMCMkrVxYYXIwiB8SSAusqV8ym0IKM5bL/xgwTz6vPEQNGqIv3AcQsE/mPRCUglGCqSUH76u1AkhLUCfj00IS/AkW3BEMvqHpaxCbt8sXGwJLMk9YuPTncQ8EfhhFNfU2A3vusNv8lQrwuJwamnUygJCQvDLNsUVc39EjJPI8MBi0sKzYIvjzt/NV/VZP2ZUXz8/N2QnT6GifHZSxmCFKEI9dGFSnZphq3as0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kbqNEQ855NjjQXg10HjVTcaVFMEBljWNaRYtoENyFg=;
 b=joyfGVQrgijhr1UWJRXsvuCuRywyxoGuIdzpIviBreeKEsOXpUVkBLCdaAZqTcducsKb+PbuNqycy+FshfQDlc4ui/Klhk+I5GZZmpViSr0vquBf83cyeAT8dWLhOLm1eLuQ30Piq9Zq+9hfuZ7lcJ4djpE4+KR19RLGaRdeqp4si+du38KipbSY7jziEwU0k3o1OYD7SL4FNKJUf2EyWecsjgc/MfBZzFsNwR6dslZya5QuI8AIwQ0RLIBy1ZYMYRTwm9WL3CLULTzRcofCSoYaq4EdBvQxuUImbiOnBM4JpRDNbCCChsVRiGlY9cKMvEs7VeXjzAbPZBokQF7uvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kbqNEQ855NjjQXg10HjVTcaVFMEBljWNaRYtoENyFg=;
 b=Pkindvu7kLmQ+W9BItLOm6fTWHkyjLdErrCUstwvtSbJ97xlqyzeBr7Iy96wuJ2xGWUm4yuSM06wajybHimPxnJ3F2bxT+gpLjWypUJVJsMRT/+R1H1IKlD+Wemotq3LqDXWnChXS+AcenBNqv4JBFpHVeoKQzBFm76PrG/m+nEHwx7EwR3+HrIpRVueriX6r8XkeKe+21Hl3qSVx7jeqmh/yYh/jON4y7h3SIVvTNijMuvj9g3FdrAbkunU+1qhHRJrNU++ixU6nAPP2ROkqsps7d58cdZshktTNUmDLbQkw9Wg4eS5sHbFYOICLQTSwcKIVI1M+wmXESnP9md1Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5642.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 14:18:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 14:18:28 +0000
Message-ID: <70790d7a-1ac9-4c7b-acc6-2ee4edc4a472@siemens.com>
Date: Fri, 14 Nov 2025 15:18:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Testing isar-cip-core on the iwg20d
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <a0f4d994-2f70-4bad-b823-b3bf1a373fce@siemens.com>
 <5cd84b25-4709-4813-9d38-2652810874bf@siemens.com>
 <TY3PR01MB11346468D1012CFB886455D8286CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <52e217f0-5cbb-451d-ad56-4c30927b99f3@siemens.com>
 <TY3PR01MB11346CDEF02F029DD1B64560786CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB11346CDEF02F029DD1B64560786CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0036.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f2dee3-19d1-4f3c-a37e-08de2388ae3d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q0J4TGJLbE9VOHVxWDFSNW95RG0xdkpDdi9GSnF5SlQ0MVVBWlFobEFmSnVa?=
 =?utf-8?B?RjdmWEV5QVlkRnNqMUVmd2taNnpiNU1DQlUwdjBvLzcyN2QrWHpjdEZDMzAw?=
 =?utf-8?B?WlBRMldlL2VBaEdMTWg5S2RvMlc5Q04zWnZROUdjejdRTm15YUlJMXFQYnpH?=
 =?utf-8?B?cjcwaVBXbDcyd1VsRHdENzlWb0pJeVE5a282azRWbW4zOFo5akVSVzQ5c011?=
 =?utf-8?B?dXpXQlFMMmRDczUyQzBxYWZ5cEZ4MGtVVGY0VGZsYmQvSjhmUTVsNUZXUURY?=
 =?utf-8?B?UTNCS2FSYm1TUkJKdklXL1N0UFd6UXFieitCLy9meGJFTWxDSzZVbjNQTC9B?=
 =?utf-8?B?MHZpLzh5Q1NlSmtXVUhVUEdtT08vWkp5L0VDVmYrNzFzbTdHTE5FRGtaVy9S?=
 =?utf-8?B?S2Y4MUlZMTVSaEtxVkRyMkczWlRkNEIxNzkxMnpid2hiS1BPZTlhSzFrd014?=
 =?utf-8?B?TzBOOU9PWmxwaXZ3Mi96L0dTSkVIQzJaYXpVMEJBdnU5bytOaG1STmlQSm9u?=
 =?utf-8?B?TFJFUDh3ZzJwWDVnZTFGaUJxWGwxWnp4ZzNtTG9VNCtEZ1ZjVm90Z3Q0TExR?=
 =?utf-8?B?ZFhOTTl2S3lCSXZqTjU0amFPbTF4bzUrakhHR0FXR2JIS1Z5c1Q5a21USEdx?=
 =?utf-8?B?VXJuZjB4VWQ5WUhCek9uM3RjRkpMYXZka2VNRVkwd2VNTGdLY0NrSHkxWWFF?=
 =?utf-8?B?RS9JVVBCQ0RZS2d5RmNXKzVVTzF6M0pJTWc5Uzl0VzR3aWtZSExoQ0R0Yzla?=
 =?utf-8?B?dHNHVVZZekhCRzloZGNhWnJ0V1dHTWh5Q3dmaGREMTc0T1ZuTmZiRGsvUTQ4?=
 =?utf-8?B?RzF5MUhxekFqYVp0d1B5NG9meEx1NDRjYjZ5UXQ1Qmdnbk9VTllMNjZad3Bz?=
 =?utf-8?B?SU45QnhZLzFYLzI5VU1GQnRjczl2MzllRlJSUUxpL2xPaFkxTFJsRXRpcDdP?=
 =?utf-8?B?WGpCOUd1amFLRFR5L2U2MmNIQ1VBeHRtNjNRa0s3VDIwMDBIK0hxVGZKNVI4?=
 =?utf-8?B?ZnpaY2xiWWZtN3I1cVFTUmFUbnhxNGxUaVNCekVqZmZkV3Z1bHhtNEMvbHhY?=
 =?utf-8?B?dE9UZTIybEc4M0JVekwxRTlPNFVpcFZiQWZlZ0s1aTAyQjJ6Kzl2Q3c2R3NQ?=
 =?utf-8?B?a2J5VHpEZjlscnNkWXBHNzRNNlRqMFFJWkptVkdGaHVFRGptYWltSWVyc2Vp?=
 =?utf-8?B?VFhxM2VmL21MZ3lWT0hkK3hEZFdFTTZmLzRrSklPd0xPZDF3NVpsYnFReklv?=
 =?utf-8?B?YitPaEFZcWVhdEc0cTRjMUFVY2xkbzhXRXQxYUE3bk5pRGJ0K1ArazBLMkNs?=
 =?utf-8?B?ZFExRW5UMm5kRGNSOFZmdTlITWkxams3Y3R1YmVzcDBWS2E3QkFxRnJ4dXBr?=
 =?utf-8?B?WnNIYjQzeHpBNnpXKzRMNnErL2ZGc1JIaG90ZEREUHFSUWVHYXl3Wm11RS9r?=
 =?utf-8?B?bmI0b2NIU01WZ0luMExyUGU5SGZRYmwrWURWZCtKTzdSQ0E3cnd6UGo5VWJU?=
 =?utf-8?B?dTBwWWwzclM5d1AyTUJ6ekl4YlltOWphWndLWVVwUDBheFNmc2dLQXBHTlBY?=
 =?utf-8?B?UXdkSG9BeTU5cE4zbDlRQ3QyVlJhZXBrRW9MMUVwUGFvVnNXZkF2ZkxUN1oy?=
 =?utf-8?B?RGp1bS9FSmpxeVBES05BME9GOGlpelY2Z0NJKzRkWHBPZ1lrSWo4aEs0QTlZ?=
 =?utf-8?B?dHo3bHgreGdZMGZ6T3ZoRWxUT2xKNmlmUlg2d0lNdEgybTJZWVdjZ2RGMldW?=
 =?utf-8?B?bU1PK2ExOU9vL0dsd0FZN2tSUFVaOTJwVnV2L1lrYXk3WkxZcVRqZDE5aUNH?=
 =?utf-8?B?MWJyVXljQnlMVktpTkJ0c3RiMTFaWEZmUGM1Q2ZRMXRHeUZyYmlaZTlRc3pT?=
 =?utf-8?B?bWtwYTJFaUpZTkpMeHI0MzBLK29ZemhNY29UUGFzOE42QTdsbWhmSDh0UzFR?=
 =?utf-8?Q?uBRem47r3ZO+ol3bSrzcP9AXcS3k8FM4?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TjBVSFUrbUZ1MTZBOHltQ2d1SGVyT25wanBjZmFsNGVsQ2o5VmtFdU0rK3Fv?=
 =?utf-8?B?cVVzMEJVbUZ0amhZNTRlZXhiT0diLy9VREhvdEoyam0rbDdrTGZvbDNWOE84?=
 =?utf-8?B?NGc2TGViWTZPd013VmFuc0NLVnJ2K1ZoQ3NPUTByV3JwWVMzbXE3WXE0dUI0?=
 =?utf-8?B?WXBoTEE0TW5MK3RNVStoZXkwdjlWRTV6UnFVVFAva1pxUnlEaWRsRTBRbEJC?=
 =?utf-8?B?Q3pmeHlzU1BuMENzdWdQMVFvWFJPa3k1Q25vVTRaU3NzcjQ2MHJMMkVIWGtv?=
 =?utf-8?B?OUduVWRwcTZMczNSS01ybXdvaDdEdU9TNVROMHc2aUdBRVdWUDVmNUk4SU9D?=
 =?utf-8?B?dERiY1BMdWtseVZyR0NRY1F6aUNCM0ordXRtN1hNS1lhV0lXalZqdzJzRW5u?=
 =?utf-8?B?OTd3ZlV4bGt4Y0ZlOGVuc0xOYzQyN2hwalRXZnJ0K1lWMHc1T2ZKNHg3UTJL?=
 =?utf-8?B?Wks2cC9JNis2ZElDemdqbFM4ck1xSlF6MUJQbVVWUWpNMUNkZjVkUnBDNHBa?=
 =?utf-8?B?YTBURHdIU1pDZzc1aEtJRWZWWGNNM252cWxBVlNORDdmMUtzL1diWmhzNHN6?=
 =?utf-8?B?RWh3V2NrU1pUUzZQWHNsUVB1TWJFeVZpRkdHNWxKUlVWOWpnQzg3NXJBTWxj?=
 =?utf-8?B?SGhxUGY0TzI0aXZuUTZSamZUTlpuS24ybXNnczUwUWlWNnByMG1GOXpuM21L?=
 =?utf-8?B?Y2NUbHlTbG9UR0hQUzFCbmlISDkxZDQ5eGZpVDU5c1VNdGxMYnFUcFZzcXZp?=
 =?utf-8?B?YlhsbUJRU1ExdDdNanlvMUJHRzMrZk5KcmdMZnJMVWExVCttazFacUJ4OENo?=
 =?utf-8?B?UjBvS2l2dFRveW5lSkJIUk8yU1l2SlJwV1VSNS8zLzNPaHQyMzVuQmM2YzIz?=
 =?utf-8?B?TElmdzMybkl3WVpSTVZZTlE5WWh6V094ZTZrb2xzNXhOSU1hV3JuUlpRQ3FU?=
 =?utf-8?B?V0o3Z052STFSNE5kbDlZMVdSaksvWkNTNXhJYmlkbDZsVlBmNzEwNWNlcjdV?=
 =?utf-8?B?Z1l0cEE0L3lHVDF5Rm8rdkhuT1piMUxPV0FaU3E0YllTVDA3Rzh3Tjg5R3ds?=
 =?utf-8?B?SVFIeEx0Wm1VUncrQWxuMTVtdENnYUl0czd6QlBmQTdTODBodjZWL3JYYzNY?=
 =?utf-8?B?SyszZ1VTY3NMVWpoK25Yc2VwMEpaK1F2cE9OMFNCMU1rRnpveGEzTTV6aEZT?=
 =?utf-8?B?UmhXRjFFOXk4ZWhOREVSZjR1QTA3TkxQL3h4QkNtamd4WEhlaVFzTDFkcUE5?=
 =?utf-8?B?R0xsN0ZIZHN4dVlzWDhHNkg1ZjArMWVRazh6NWRNcnJDTEFtOFFQRUZVMlVZ?=
 =?utf-8?B?b1d0eWFaVXVtQUhKN2l2ZDNCR1QwZWVJd0hocnlhbmRwUkZoRFkrNlJoK2M4?=
 =?utf-8?B?S1o5dlE4d3ZiSXFmVVg3WlRNRTJFajNoWi93S21EK05JUTFyWkpYOGRiZ2Nl?=
 =?utf-8?B?SXUwYXVXN040QUVDR1dBSVhJVlp0ZmpRV3dRZC9ZdGtUclYxeGM2RHZkZGZu?=
 =?utf-8?B?YjlLcS9vazRsdjR4UVlYRm5JNThEQWpiSHZGNjQ4SzBxK1FucW9aRGVzdzBQ?=
 =?utf-8?B?WlgySGkra0UzdlYrc3RrOW5GaTMrdHFNSEc1cGpzbUJmRTA3anozalhjcXJH?=
 =?utf-8?B?ZmRldkVUeDlpNWFUS0JGby8wRW05K1RrbDN5TEw4aWV5VVQrQjNxZHpNODNP?=
 =?utf-8?B?eUJ4YUVTN3lIYnBldmg0Z0JKRUpRRGJ3b1d1a2VEcXVQUWZuWWgrOUxTY1VO?=
 =?utf-8?B?U0JyY25iUHpxZFZ2MDR6NXRVVnByQyt5d3hOQmVjQmtHYVRCN2pMNnFkbzNR?=
 =?utf-8?B?ZW8vV1dpNHJ2V3pKd0JXMVpZWlFTL2VVdWVUNmNwMHlsVHE2OWpCVDZOeVBl?=
 =?utf-8?B?MDFVOGM5N0VLSkFlVFJvV0toanhBV21jSmFLVmM0cHRxaytNQ0pzSy82RTNE?=
 =?utf-8?B?MWgrSXJZNnRXSCtYeHgyQytONkIrV3dxZWViR2RmTXk4TjVTY2ZWMGdTbGtz?=
 =?utf-8?B?STQ1V2xQOWlsRmFLK3NuNlVFUGFSSmNTdXpjdzlxblQzbHdJZXBEQlRwUlpM?=
 =?utf-8?B?Q0JORVJPbGw1ckxodnpnOU8xN1hHOEROMHN5Z29OT2ZEcHJRZmhpZHoxazYv?=
 =?utf-8?B?Nk1EL2FFWmFKWGlOUldNMGI4RDEzdmd3cVQ3NE1HTlhFMG53aDRDY3JDSjJC?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f2dee3-19d1-4f3c-a37e-08de2388ae3d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 14:18:28.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9uJB4PPvSnMnu/E240TZTtGCPtmnUZz8s9TqbsMIGNEGnOf0hOb3I/VZeyQyFMRuMBmtsIc+ztU8s3PkM87oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5642
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 14:19:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20559

On 14.11.25 11:03, Biju Das wrote:
> 
> 
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Behalf Of Jan Kiszka via
>> lists.cip-project.org
>> Sent: 14 November 2025 09:54
>> To: Biju Das <biju.das.jz@bp.renesas.com>; Chris Paterson <Chris.Paterson2@renesas.com>; cip-dev <cip-
>> dev@lists.cip-project.org>
>> Subject: Re: [cip-dev] Testing isar-cip-core on the iwg20d
>>
>> On 14.11.25 10:48, Biju Das wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
>>>> On Behalf Of Jan Kiszka via lists.cip-project.org
>>>> Sent: 14 November 2025 09:35
>>>> To: Chris Paterson <Chris.Paterson2@renesas.com>; cip-dev
>>>> <cip-dev@lists.cip-project.org>
>>>> Subject: Re: [cip-dev] Testing isar-cip-core on the iwg20d
>>>>
>>>> On 14.11.25 10:05, Jan Kiszka wrote:
>>>>> Hi all,
>>>>>
>>>>> as I still have the boards with me, I "quickly" wanted to renovate
>>>>> and test isar-cip-core on iwg20d. But the board I picked from the
>>>>> stack has an ancient u-boot pre-installed (2013.01.01) and has no
>>>>> clue about GPT or the right name of dtb file to load etc. etc.
>>>>>
>>>>> Can this board only boot U-Boot from SPI? How do I refresh that safely?
>>>>> Or can I also make it load U-Boot from SD card?
>>>>>
>>>>
>>>> With some tricks, I meanwhile loaded the zimage that isar-cip-core is
>>>> generating via the old u-boot, but that is not giving any output
>>>> during
>>>> boot:
>>>>
>>>>
>>>> iW-RainboW-G20M SPI_LOADER(DDR3) V0.20 2015.07.16
>>>> BSP Version     : iW-PREWZ-SC-01-REL2.0-Linux3.10.31-PATCH004
>>>>  DEVICE SST25VF016B
>>>>
>>>>
>>>> U-Boot 2013.01.01 (Nov 04 2016 - 22:21:05)
>>>>
>>>> CPU: Renesas Electronics R8A7743 rev 3.0
>>>> CPU: Temperature 50 C
>>>> Board: RZ/G1M iW-RainboW-G20M-Q7
>>>>
>>>> DRAM:  1 GiB
>>>> MMC:   sh-sdhi: 0, sh-sdhi: 1, sh_mmcif: 2
>>>> SF: Detected SST25VF016B with page size 4 KiB, total 2 MiB
>>>> *** Warning - bad CRC, using default environment
>>>>
>>>> In:    serial
>>>> Out:   serial
>>>> Err:   serial
>>>>
>>>> Board Info:
>>>>         BSP Version     : iW-PREWZ-SC-01-R3.0-REL2.0-Linux3.10.31
>>>>         SOM Version     : iW-PREWZ-AP-01-R3.3
>>>>
>>>> Net:   ether_avb
>>>> Hit any key to stop autoboot:  0
>>>> iWave-G20M > pri
>>>> baudrate=115200
>>>> bootargs=console=ttySC0
>>>> bootargs_base=console=ttySC0,115200n8 ignore_loglevel vmalloc=384M
>>>> bootargs_mmc=setenv bootargs ${bootargs_base} root=/dev/mmcblk2p2
>>>> rootwait rootfstype=ext3 rw bootcmd=run bootcmd_mmc bootcmd_mmc=run
>>>> bootargs_mmc;run fdt_check;mmc dev 2;fatload mmc 2 ${loadaddr}
>>>> ${kernel};fatload mmc 2 ${fdt_addr} ${fdt_file};bootm ${loadaddr} -
>>>> ${fdt_addr}
>>>> bootdelay=3
>>>> bootfile=uImage
>>>> bootm_low=0x40e00000
>>>> bootm_size=0x100000
>>>> ethact=ether_avb
>>>> ethaddr=00:01:02:03:04:05
>>>> fdt_addr=0x40f00000
>>>> fdt_check=if test ${fdtforce} = "0"; then dynamicfdt;fi;
>>>> fdt_file=r8a7743-iwg20m_q7.dtb
>>>> fdtforce=0
>>>> kernel=uImage
>>>> loadaddr=0x40007fc0
>>>> stderr=serial
>>>> stdin=serial
>>>> stdout=serial
>>>> ver=U-Boot 2013.01.01 (Nov 04 2016 - 22:21:05)
>>>> vin2_camera=ov5640
>>>>
>>>> Environment size: 803/8188 bytes
>>>> iWave-G20M > run bootargs_mmc;run fdt_check;mmc dev 0;fatload mmc 0
>>>> ${loadaddr} zimage;fatload mmc 0 ${fdt_addr}
>>>> r8a7743-iwg20d-q7-dbcm-ca.dtb;bootz ${loadaddr} - ${fdt_addr}
>>>> mmc0 is current device
>>>> reading zimage
>>>> 15151616 bytes read in 685 ms (21.1 MiB/s) reading
>>>> r8a7743-iwg20d-q7-dbcm-ca.dtb
>>>> 41327 bytes read in 5 ms (7.9 MiB/s)
>>>> ## Flattened Device Tree blob at 40f00000
>>>>    Booting using the fdt blob at 0x40f00000
>>>>    Loading Device Tree to 40ef2000, end 40eff16e ... OK Unable to
>>>> update property <NULL>:mac-address, err=FDT_ERR_BADPATH Unable to
>>>> update property <NULL>:local-mac-address, err=FDT_ERR_BADPATH Unable
>>>> to update property /iwg20m_q7_common:vin2-ov5640,
>>>> err=FDT_ERR_NOTFOUND
>>>>
>>>> Starting kernel ...>
>>>>
>>>> Tried kernel 6.1-cip and 5.10-cip already. I guess I should put this aside...
>>>
>>> You need to load r8a7743-iwg20d-q7.dtb by updating u-boot env variable.
>>>
>>
>> Already tried that as well - same result.
> 
> Can you try setting this in u-boot?
> 
> bootm_low=0x43e00000
> bootm_size=0x100000

No change, still.

I'm using bootz here as the input is a zImage - does that make a difference?

Also, could you provide me a known-to-work recent u-boot.bin? Then I
would dare to rewrite the SPI flash.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

