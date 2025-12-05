Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59071D2E00F
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 06:58:19 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.470.1764917896013253952
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 22:58:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EjMIbVim;
 spf=pass (domain: siemens.com, ip: 40.107.162.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICMwKMX2aU0IvOmW1vgb5s/1A+eBLhe8D75vMP3pdmRSkLJeh9wUXYpHbTJA1/zlu2a91sYX4Gqx9mkddLcRi0LDh+tOOjsuZQp/fpiEKOFNCtapmaMrxCUat9QJajvmZFGPyFBhGx6Gbp3Ifypo2+75zUnhOTrMFhRa8tkhXymu0YPW4RBqUUoQ6YMyuflzLyLkoeOGcVS4WvXQa70ch0SwjT3kf77pgphosmFcw2r4goxBQ1GYjPESWB/RhHgDKkaGJA0AdF5d8FC1oVPLlEE9aboBq5ZnWxeAwqHVy7aI9UaThznFntuskYRLQM+WhDBY7ElKoyswo3vjrcpxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1j8meH9S3zlH8qi51tlBgmEuYsWBGAGXI0wCG88ruI=;
 b=hqpAC1fXsgSRM/wDKCYjG9oH9lyGVmyYaGa/RqavGHXHcaWN4hh1Fiekarf2Nliqs/0Kl5vrZ1P8DAmWn6AujedIGH3CxgX+m34PixFf4iCNj2CocGia6pHn3OyTNY6HyP1URzjKOnsi/n3knsDG7/heVoQFCF42fcg1iER2Qz5DGLb/gLMUzNO3FDeM4vDSnn/eK+U5zckpdwjXOmXI3400+ZvTGgWjlnJAIpTjSCBZNcDLBU8FVdNdEaR1kDL9vTOmVVx+s2HvvSfevWEjanOt/gbXKHg0B1d1aqhKPX1ZE5UiSiJPQ3S9O3aRkfarxhUIRL60meMIdOXrfDWt4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1j8meH9S3zlH8qi51tlBgmEuYsWBGAGXI0wCG88ruI=;
 b=EjMIbVim8MZpqCKJ9fhw/Tk+UqU+tb5H2MxFeAs0sHkR9DOv88iFFUSnY96Bp3uHG3DxifPcBAzfWmEA1jTtSY9FEbd22JTCw6SB+f+KYT/LOLllEpk5Lkk2quBqnfLuPumxc3HD68hfXKBtYRjWem3ewKNUNcXmqYbcu6b2u28wEe0WFXrTmo6E5xPsNet4Qmo6JGNY+wbroQLczu1p6DM+Li/mJFrPP//e3VtfJuhqva9g0OlAq4sL960fhpIiew3vgnAFcQ73cDTZeDd2KLYwwVebeflMkJlNXQag4sx7K4vah8WUBZbUD/2dcbFNKGP+LIX9pOHEIqjKLrTvfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 06:58:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 06:58:13 +0000
Message-ID: <b0f28221-4545-4efb-bd0e-c542e8730fd5@siemens.com>
Date: Fri, 5 Dec 2025 07:58:12 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core] Freeze for v1.10 ahead
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0226.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3172:EE_
X-MS-Office365-Filtering-Correlation-Id: 2707d92c-5fe1-49a6-4fa6-08de33cba8b4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UmtLUzBONWFGRUExakI0U3V6eUpqekxuWi9lMUZRbFY1ZElHZHFKZEEyYUZD?=
 =?utf-8?B?Z0xTY293MENtMlBHaEZ4WURidVh4UEhBZ1ppS2RGWHVHZU1oVE93MTdQN1ZN?=
 =?utf-8?B?YW1sblVaWC8zWEJHeHZxempra2VNQng3YWJpa0lBc2c5ejQxUWpyYUhpSTlL?=
 =?utf-8?B?cFNISmg5RWNaNUpRV3RyZXJCcEJ3aVcrZVl3QXVUdEVyUkVjaWVKZ203VGFy?=
 =?utf-8?B?by9wbVQ0UElQbFk0N1hoamNZa1gyakZoN0tqNUx1cGF4d2s2dXd4V25ZY2Fr?=
 =?utf-8?B?bC9xTEZxMkhaZHNORjJxVlAxUXZ2NWZGZm1tUnhORzFtSEtOMWpPc3g3Wmsw?=
 =?utf-8?B?YTZ5YitRNlJ1RFRqTngxS1gzbUxtL1ZYOENiUXZBYmFxeERCTER0SFZBV3g5?=
 =?utf-8?B?RThHWHpkQ2xaV2tqNm5OMnBWZVRac0E4VEVMU3pkYVc1RjBqeWxFdlEwampr?=
 =?utf-8?B?MzUvT2k1eVBVL3JnV2kyN0JqNFFxbWFINVoyNzEzT0lWQ04vWXBZQzczYThm?=
 =?utf-8?B?TThLVzg2d3JRbnhFUGJ5RlA2czFDbFFtVzNtY3c0NGhNbUtaSDBudEVwZHhl?=
 =?utf-8?B?bmNTbkVvWlhqN1FINUpjSDVjS05yRE1FazRHN1FpT2tWVHYxbXZUQXBROXVW?=
 =?utf-8?B?Y2dySUJ1a0w4WXVuSFRWMlgrcHFpdS9XZ3dTM2VqaHhSSGNNNFRGU0VORmky?=
 =?utf-8?B?dTR1TUNDR3lvZkswY3FKUlh1N2RQL0xTcVJDRHlUd2h2Y3UrS1Q1WWVkSHFR?=
 =?utf-8?B?ZXBYTVdDYzdpcUh1VW81bkt2a3loUU85TUdzMTR0dm5FL1NOaUFiQU1SUE11?=
 =?utf-8?B?WFdoREpjdkpISit4WHR4N2ROcStITWlZVk5PL0RxK1cvb1BNZ1gxRnJJa1JC?=
 =?utf-8?B?SWZRY2VCL1ZtVTVUbDhwd3I0S0p1UWJta1NpeFc0VHppcTNaa0dpbjB0V1ha?=
 =?utf-8?B?NkZ5bjlGcVBnWW8xRTJFNDd5SVV2L2t3ZHhyNVlwMVdWWkZDVnIyenFteVhU?=
 =?utf-8?B?cUxXUGZPZWRreDEyNkVSdG1yR1ViKy8zK3Z4Uk9nL1N4SnVMZFVORHpxVXRF?=
 =?utf-8?B?eUhXUFJCa1BnUnEvNnQ4TDVXbVNUYldOU3loeTJHbHA5TmlQSkNVbmlucWxO?=
 =?utf-8?B?cXZHbm84TlNZb2JHYzc0Q1g5MlZzWnM3SU4yaEFwc1JLMjBBdDFDQzFHYktF?=
 =?utf-8?B?UUpoUzVvV05zeFZFd250Mzc4SUVXL0pLTXJZV1V2SFZwM1A1bmlTVGpiQjQz?=
 =?utf-8?B?YVBoSW5tYy9xcndYRmZvK1VERGg5UmVWSmV2TktINnFtYmVBdmp1QlFPNnV1?=
 =?utf-8?B?cERTOWJJa1pSeGtTS0U3L1N4bWsyK3ZHRGxnWFlEVlFCUGs1SElWSmpjbXB0?=
 =?utf-8?B?SGFGb2hNYUE0NkVEK0FCNVJzb3dXdkxzeHgzbWxTdTlDOVBOZnBwODBTdmcz?=
 =?utf-8?B?SEh0QzJTZTJaUzVvS3M5Ulh3eXo3eFZYd2M0Z3l6UjhpN1FRUFhlcURweEQ5?=
 =?utf-8?B?dkZ0bVJMbXhBYlgzZVdXWkt6RXdwSHhCSk9EU25KcnZhaXF1citaRGtQRGNj?=
 =?utf-8?B?QWs5cWFVNEhWeW95VG03MUNVb01QK2JhZU1LZktwbUJzWDlUbjkyTHZyTjlX?=
 =?utf-8?B?bW9jR3VXSWk1Ym5rUGV6eDZjbFJLeU9IQ2NXbkNEWUtVS1hoWFBqaDhmQ3hI?=
 =?utf-8?B?eDVoWTRGT1VLSUxjajhOTFlaVStVM29QL09tb0MwK3JGYVhVTVNrOXhTeTdG?=
 =?utf-8?B?UUplQmcwRlMrc05wLzBQK3hQcnhDWlUzVW83SHJVcjRjQXhPQWFrbHNvUzA3?=
 =?utf-8?B?U0xVRU13MEhMQnZqcWlFUy9WamFrOW9xcU1EZHFTTGNqYXR4dERHOHQ5V3ZC?=
 =?utf-8?B?TUxlZ1lJeFY2TGppWnFvdTJSOCtrVDRtTEtJRitrKzZSSmh0WE5RbndYWUk3?=
 =?utf-8?Q?sZyhJyVL33Z/RrODN5K4KBzv0hVmw0XR?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q0xIZmhGMVdEbXIrR2lHclVVd2NDS3lkQnJUTWZsSWNGY3lFcWhzZ0ZORkV0?=
 =?utf-8?B?OExBYnlCOWJJZVN6cS8wcEVEUEQvM2ZkcHRuWHdPZFMyWmJObmdTWHlMaHJp?=
 =?utf-8?B?dHVzajY0NVFHb1hlUG0vaGc0RXVXbnFiSHZOaUl6L1FGR01yVEZob0xkV1hZ?=
 =?utf-8?B?ME5UVkZHZzdSVXZYWEhzY0J0VENnYk82WDZhMmorN3p4a2c0NzhucVhyZUFM?=
 =?utf-8?B?eThvQ1RqSnkwWWY4T1YrWnNtNG5teEZ2WVcvVkl6S3dLUDMrZ3dPTWNRWnhp?=
 =?utf-8?B?Mk4rYmJPcjJNWUNWcG5BOHVoNjdkdEhseklBYXdERjIxbE43alJzWEFYNUNR?=
 =?utf-8?B?ZXcwTERyZkZXdmxVUjJaT24wV2RRTTh2aFZRVnlIbVM4YjRHK0drWUd2Ukkv?=
 =?utf-8?B?Yk45Z3ZhRXFOa1pPNDliTzJGVXEyWWwyYmdFY3N4cUZSZDNma2NYSUxYc3Nn?=
 =?utf-8?B?bm5nQTc3YnRTZ2FqV2V1Q3hEcFZhaVBYN1VRV25ZU2RCaWRhdm9DSlNGeEVz?=
 =?utf-8?B?R3B5Z3cvUXhMYUVIMzVGOVJEc09OVUNYMnRtV3Vmd3pZVXBoQ3Q1alQrM1NH?=
 =?utf-8?B?eEJrZUw0eVd5TEZWemZDaE13ckN3UU5uUDU0ZEN3YXRVL3RSdS81ZjJvSElH?=
 =?utf-8?B?ZkszTk1BbHgvZTgrakZmaHVPTEpVd0tqbjhCUElsNDlhWUVxUHRITEhlQ1Zs?=
 =?utf-8?B?OHNPdEJ6NlgwcFlMSHZaNkZFelpSRFRmQ2ZFUERWckhubUlZb3VGZUNJNTkv?=
 =?utf-8?B?aUk5clQxY2EvbEIrN1VmVG1LRlJSNVpuNHhoZkJZV1RxbXNQU3ZYUmpkR0lS?=
 =?utf-8?B?eDE0S1o4eWFIa2srbndkNTVMbVpBTEhTZS9EdUEwL0YwZDJOV3JxbzdKRFcr?=
 =?utf-8?B?Yjc5cS9jOFhkUjZOYmtERUNwUmkvQXlEbC9QVU93L0lacHhLeXpVUGRJMEFG?=
 =?utf-8?B?MDRqR3k5ZHNaZzZuMjJBQnZOV212TzIzZUlac0JOenpBTWVZcUVRYzdzOU1C?=
 =?utf-8?B?UEVPbk90L0tibHFyTUR1eUlwSTRhclk3dGo0OTR5ay83OFphZStYVEx3R0RV?=
 =?utf-8?B?L3RyMGRSQzJOUVBiSjA3cG1XZ2JrTWE3eTN2RXFuQitHajRnZmRIRXA4aWxt?=
 =?utf-8?B?WUJadzg4Q3I1ZWUxZkRDbmd0aU9CVGNEVTc4RkcxbzYzWXIzcE8vRlpmdTh5?=
 =?utf-8?B?ZjZlSWYyK0pzMVhGTXZ1d1lZcGNXK2RnaHUxeEx3eVQrSlN1YVhONHQzVEJJ?=
 =?utf-8?B?TGFHamhYWmdyNWtyeVo1SW9DbytTV1phQmtlYlc1SWJSMWxWQnBrU1FzWm5F?=
 =?utf-8?B?YUhtZHEwL2J6aFJwY0tWbGRIWExDZFpyTzB4K1JWSkN5K05wY1pybTVib0o5?=
 =?utf-8?B?UFVWUjg5TmpLMDk2N0UwL1Rtc0pKU0p6TStDUDBKaThBcHNkRDBwZkJ1c0xi?=
 =?utf-8?B?ZFRZK0xoOEhFdVVLS3EwdjVQTktBUEp1ekJUMXhhYWhDWTA3Q0tmcUZEMnRu?=
 =?utf-8?B?VXBQZEJvay9GMTZ3OXhkbWxWWEYxbWtTTkNHeFJvVHM0bGlONmRHVUQvT3ps?=
 =?utf-8?B?eER0MTUxaG1hRk9XNDBpZnpHNUk2b1ZHbE92c25VQitlR256RVo2aDBGQmNJ?=
 =?utf-8?B?UldRYUdlaGU4d0tUb1B1OElKdVJCb2UvT1ltcUJxakZHNEJUaGRiTWpEUS9w?=
 =?utf-8?B?ZldIU1FuMDltc1JrUkE4RUVmTUt1VGVFYndRb29YRTYrK1N2Nmw1eXozT1JO?=
 =?utf-8?B?a2JzRW9rS0VwZTdBVTV0VzdzK0FaRWR1R1Z6VUdlL1lSUU5qR2pqMjFtYS9D?=
 =?utf-8?B?cktxT1VIaDN3M0xOM1BMRUtCR2poWTdnb00vaDFNeTJMQXhURmYxUHYrOU9Z?=
 =?utf-8?B?V1hxUm4rZWo3M1gzVWxkb3JNTnYzYWUxV1ZqNmpaRkdZWEgwdlpTWFNJY3By?=
 =?utf-8?B?eVBUcFdWTFRPTHBaeWZNWW9INnFLcE1FaEJmRURvTVlXaUF0YkxBbTZ2NjRV?=
 =?utf-8?B?MFRBbk5XWXVqZGszQjhsS1BwdmVhb3pScWpFVSt5VDNZQ3YxcWhnSS95M2RG?=
 =?utf-8?B?di84TExaVmI2WWMyU2UvMGQ4QTRPeVExTjVRaGxZc014cFdueXhTSWRvdnZ6?=
 =?utf-8?B?V2gxUXpvZjJuOWN5MDl5MzR4UnZVNS81WS92bHpmNFV6LzA4NzhFalFhNllv?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2707d92c-5fe1-49a6-4fa6-08de33cba8b4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 06:58:13.6469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhH2LUN+ZlQycm/7CZLC08kah6WsDBrJ/pW061V6KeieLF2UGA41LJbmUynXlWt5XhinYt60P44hRDjw5hvGUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3172
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 06:58:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20907

Hi all,

I'm planning to tag v1.10-rc1 mid of next week so that there is a chance
to have the final release before the vacation phase.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


