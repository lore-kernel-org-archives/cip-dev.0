Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D156BD0D14B
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 17:26:57 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.37])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11605.1767806807482100320
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 09:26:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JcMSsZ3I;
 spf=pass (domain: siemens.com, ip: 40.107.159.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXV9ASxbo7N1WkshalkpjdprS+FawY7w37W9+ukBg9QOHdE3DBrmYJU5qUYCpBgYcYjmQeVfrzunAZNKIYib7IsoU/bNrizO3RbX36wo67oafPVtprhw/m2PqgMAEKeiHaX+/ew+IQ7J4fZBvDBpRxghscO/oVmMDowJ6n/moKyHxBqHXKOSrVSgM7390/JnraiLZEbn6xb6Fe4XbN8vsUvDoMHFdsgEows5oJijc/fosz5ACfTN+QtAebYxcdR5L/VCuFAp+D9UMBJGNPdSHvmtwmxq0wECBnkXkhA240BL3XXQ5hi366t/h3QLLOAxndjQVAUtSGo/8+Cp3QBOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TtFVxqlFEfWpzDN6a3PZrIELlmzthgCM2Ddm3vBPFI=;
 b=Tt4Ez1bLhkFPkHDMKlj93qSoFIqC+8hs9fQlITOTZ0QJ0JbeAMtM0G62yNCmxateKJu2HzB9GHAt7xldK6EtMUnK/230PEdFOeLEKoIBX5s4RVvrIAb0AUy+er5lhlEtXNFR19DBu/zovg5DlHpH4xxljOJWR3b2Y/IK/qmC4ilEFDt2OUa1ouJCoX/tHjYw6dhPoAXj0eDa9hulvCAHbKnBppnRpvT4LpAG8CQwVbh4kha7V3jGXZ1T+qpvOQnYQtMarMxKDUCZAfiAySaFRcIS/vypHPfSmytGQRZRW9ETkg4LEPTkYeIAd1ZSCDEpafMjA95Of/wCz3zy5gy8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TtFVxqlFEfWpzDN6a3PZrIELlmzthgCM2Ddm3vBPFI=;
 b=JcMSsZ3IoW9rHu7QGQBsIeZW6ZafMp3toywAZkFJcyVay4NLJ5ap5+U/OI9N6Pii9MuJ+iJrcf6AreRez07vSk9Kh9PzgfO737kzVJs+qA7zdZGovaWpbSLI7jALrLBQuDewjIj0gKPFfylIw737CjCXjwWUul3PrdvmdZFPyczHlDg2cf0gej78dZHLVDFACOrRdtvWnhE4QhzPfFP0BDaRVHSzubLxvt0wgW4+If+bz8jhcJi2SH+D9HzeZhF9Vo6WQHTN80rFWQLdA0Nii6jLcQCToykR1goOdp+vwLAOqlWdY36tNxdiE+sWcVdo+OjbIuXzxRgyNQliw9u43w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7289.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:26:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 17:26:44 +0000
Message-ID: <cc467907-43fd-41f8-893c-84fb5a085a3a@siemens.com>
Date: Wed, 7 Jan 2026 18:26:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 2/7] Move RO_ROOTFS Options to
 swupdate.inc
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 clara.kowalsky@siemens.com, cip-dev@lists.cip-project.org,
 benedikt.niedermayr@siemens.com
References: <20260107132707.733180-1-Quirin.Gylstorff@siemens.com>
 <20260107132707.733180-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260107132707.733180-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:610:4c::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b45e91-290c-424f-e4a5-08de4e11ed74
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YnNnU0JoTTlaUTcrTmNXNnJ3cWIwYnE5eDkrd1RjWGZ2QVF6UTl3Tkp4QTdN?=
 =?utf-8?B?eUZMekdyempqUnFMSW5VYVdCZWZxNmZpdG80ODZnWXd1SngrbVM4SFdBSmtS?=
 =?utf-8?B?dUpNN2Z4dDBjYzZvVUZLdnc3WjY5cExaTkw3aVh5V1Nnbjl6L0NjRldyVnpW?=
 =?utf-8?B?SW9QZUV0eFRnc0UycVA0WVBJb050MHBvaEFNeWpGZnRzc3VMZnZPN3gzb25q?=
 =?utf-8?B?YTFHVFEvZTVGUEVkV3pVdnNBbW9BU2NmY2owK3dodTJ2dnM0NXVwTnNMa2Y3?=
 =?utf-8?B?WkRmUXduR1AzU1RCelNlQlZWdkJGQ3BTWDRWYTdMZ0FPSjJMVXZHd3lReEZY?=
 =?utf-8?B?bGtIRVViYUVteTZzZEdidjBKdG14dlBvajJRdlFTZ3kraUgrTWY4RWd3S3Bi?=
 =?utf-8?B?WVVnWHBBVkhpNVlySytEUkZqM3FqMGZkUkxJYXNqclZRK2xmeGMxcThTWm02?=
 =?utf-8?B?SkRINEhhZCtaS25tb2RCQ1lsdlBJYnFvWkUzQTVuMXQ2RnNGQy84QTA2NGFt?=
 =?utf-8?B?c1daMENrTHI1WFJjRUFaUjd3b0tCUzV0c1ZrWWJMY0hYaHk0WkhRLzJZanRm?=
 =?utf-8?B?UmppZ0l0WnhjNzFXZjNNMG1xa2VkWUFHRXd2dVNSM1Z0T090ZmZGeTZMSGJn?=
 =?utf-8?B?WUQ0M2dXaDN5SkEvbkJmQklKdUJaMWswSzlhNkthM0RqcHNLVFJQamphMTZn?=
 =?utf-8?B?U1krblF4WDVOeHF5cWllVmhaOUZ4SFgyeFNsMmFBaTRCdjFNR1JMMnUyN21U?=
 =?utf-8?B?UWE2QTBmR21rYVlmSGsrSkIwQ0p0ckFOTzBjZEJOaTZCUUVrNmlVZUx3ZGxN?=
 =?utf-8?B?bXVKcld5Rm41TDk0N2Zub3VQeEoyVERJczhpTGpTQWVRWDRDV01nMW5yMlRM?=
 =?utf-8?B?MUxaaGdVZWw1MkRKOHRMcHlXdXQ3RGNELzc3T3FWYUp2M0FjNlZJZFpXNE40?=
 =?utf-8?B?bUMvMFRFWmFwVDNDZm9hK1F4UnFwRmtxbDJ2S0JuUEVPK2tENnNraHYwaVky?=
 =?utf-8?B?OHZkZ2dMS0YrTmhZajNKY0J6Zi9NV0svUjhEZXBmcnJ4eHZOc2I3cU9LemhY?=
 =?utf-8?B?bWFpaGUwaU9vK2FQYklXYjV2ZWRQbWVBRXBMZ3FKWnZzc1AvUlY2eVIyUHIw?=
 =?utf-8?B?WnJNV3RVQ3FpOGJ1cndMUWhpN1dPUE82dURoTFk4Y2psNmcrOGVqb3JZRkdz?=
 =?utf-8?B?RjNNSEYwNWtYdWpDMHNrVERUQSt2cDJpNXRUZHpsclR3Q2o1Sk9xUG1sQzdU?=
 =?utf-8?B?aXpBNXZibEJDNnFXaG5NQTdoVWRTbGdVd2xsU0l4dzRtSmtMTjA3WlhqY1pW?=
 =?utf-8?B?UDFnL3V1eVBQSUl1N0hxUHZ6TU1ETTVxZ2JUb3F4czBldVp2YnAvUzNuZFpr?=
 =?utf-8?B?QkcvOXdyQzNnWVp2YUc4RWJmS05IS2pxZitkVS9weHRNVWc1aHNOOUFUQjBH?=
 =?utf-8?B?ZDZXNFpoR092N0Z3VWV5SVpVSEFEdWFXTmF4SXJhYlNPeUF1U1MzQTZHdUlp?=
 =?utf-8?B?RytKVkdoTGk0UXIxbTNBZG5YVUtkRnFGL0ZLUXp0dlBWa045djEzTEV2MVVV?=
 =?utf-8?B?R2JhUHJieG1ucE8zeXZWK25xbTdGSDNSTldjWCtzcTFqZ0JoSXd1VkJHeHlP?=
 =?utf-8?B?ZGRPamNYMFFYU3hiQzcyYWszc1VhMmowTkNZQ21kRE5YZnliUVdhSm02NTZR?=
 =?utf-8?B?YWp4cVYzbWI2S3VuTTFDd0dJVDF3Wm5yVnRpbzczSzJGZSt4ZndxMHE2cFZv?=
 =?utf-8?B?dVB4SDE2Q3NXR2V2MVAvQ0oyZXpuaUNIZUVPRXVnZGMrbXg1bDVwVFR5OVQw?=
 =?utf-8?B?NFdkUzFJREZ0bjZOeXlIaGRlL3plWXNBUXpiUWJvbjRxZVdaNWFTWDJJWHZE?=
 =?utf-8?B?c0ovZkw4bXJDQ3h4TmNkdnp0QzZ1WkViVjBvMWV3Rk13d2I3YmQxbDRoMHY2?=
 =?utf-8?Q?mru6NeQU4WytxsrOdHxGeoPP91pBXvYv?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V2FzSmhsazNaMUsrN1I1d2VWZnE0YjRpRlVEdmFpMitCM3BGemdGTm9Vakwr?=
 =?utf-8?B?MnlJYmVMaWFwb2JsWXZsalFIMFFTbmxkMGdTUE1OcS9rNzNIV3c4OGplSXk2?=
 =?utf-8?B?QVN2MHRubzB6SEdMTmVhSG1XUWZFUGtMV2hsb0h6U0VwVnhKZVUyVnpkN0s3?=
 =?utf-8?B?K3p4SUhvQlVCa3h1MGd3UHJsTXZrQWxBcExzbklROGswZGNtUnphdWtsVzky?=
 =?utf-8?B?VnlPZmJmZUU1MXF1Vm51NHRRTXVhN0lXaFpjUHo5U2dIZkVwdW1LcDhxWmJu?=
 =?utf-8?B?ek9KalVLS1p6MloyRTdNZDVvWTN5ZzdrVDZWVXVpT1BVclJtOFZpVnppb2ti?=
 =?utf-8?B?TDFkSjNRU1hDYnJqMTN2eEs3a01PUEx6amxUVjJFTWtGM090TlNNQVZ2TmM3?=
 =?utf-8?B?R204UktnT0JHSWNkTXhQaE8rZ1g5NGR5K1VnY1dYZ2Q4cUppdi9nbG94SXNR?=
 =?utf-8?B?LzBNWkpINXN1VkFLbGZCdFA1bnppL29OYnEvd00yRkUzSHdINi9aV0Z6MlRj?=
 =?utf-8?B?OE03U3p6T1FrZTFZVmhaSWVkNDlsTk1wY0M3OU9KeXBPanNTbG5UR3FlOGpG?=
 =?utf-8?B?M2tyZjYyZ3hNWmtqUHZieEJ2cDg1dGxoSVlJNVgwU3FCS3VZZlV3Q0JpTjNo?=
 =?utf-8?B?QnUxT2wvOFl6Mk12ekFBQkw4MnVKL1JZY1RxM0tHbHVCcEVuZDJ1bWdaeFVO?=
 =?utf-8?B?VFVPV1FLMnE2Y2JsVktEbUJBTXkyZUc0TEVaZ1lRa20yZm1nNDc2OFdFM3lG?=
 =?utf-8?B?bEsxWDN0a2p5RFowU0E2WkNwVDBRTVJuRGdnNUxHQmR0d3dBNWlRL1o0c1Nq?=
 =?utf-8?B?QWQrbWpKQmY0dlBqWFZuT0c1UWpxY21SOVVOQVBTOEtKdmY4dDNhM1pNRU5C?=
 =?utf-8?B?dzdva2pFT3EzeWtMcWhNbjBCMlN2UnVSR2o2S0ZINE9KUDNTUmFyMjZ3cWl1?=
 =?utf-8?B?SnlyKzYySjBscHl1NWRyTmx4L1Y5a1BueGRqdHRyalMxVzVxOS9NZGhjT0ZK?=
 =?utf-8?B?TmJCbWJmOCtTaW45d1Fobkk2MkxBYmpORGhhRWRNdG16S0x1NldkK2VKWjdz?=
 =?utf-8?B?MHNGSklvS253Uzl6VGZXRHNzU04xVzFZOEE2Ky9OT0FpSXB0TUhvRlA1R3lF?=
 =?utf-8?B?QjJUQk85bllrdWo1MW0ycFFRaGFaOFRsREdVQUJidTltcUxWOTRWRlp6OHo1?=
 =?utf-8?B?VE9yVVpnYjBsZzNidWpjakc3Nk5LQnc4bXh1Mi9pOGhpckRQdTYrZmVjTzUy?=
 =?utf-8?B?TXBzQ2J4WkpuTlVacnhabmRuTW5aa0RLQXowcHhWRlRVNnY3VEVNWFh4RTZk?=
 =?utf-8?B?TXAvSXhaRVQvRjYxR29qT1VRYnRKQlVvT1VoRzRoZkxDS3EzaE51ay80RzlO?=
 =?utf-8?B?TEpucllaVnpJVmg2R041OCs1WFpXNS9adTZwQngyQkdjSC9sMWFnZmtQY3hx?=
 =?utf-8?B?bTJWN2ZDdDhmeitjLzhnZjJBVjA2dU9jd3h5dit0UHdRdjNNbGh3VjdVS1lo?=
 =?utf-8?B?NkhhamN1ZERYZnZ0QzZzWXBxZGdtR0dZTjZXMlhQVUFnNFRTSnA0cE10V200?=
 =?utf-8?B?aksrSy9kTW53blJQN2FSdzlmUmZRRHBsL2FwOVBJN05mSUVnUjd5VTJBRUpn?=
 =?utf-8?B?VDdxbGxWU1pRQXR4OGcvMTY5RFZ4R0liRmN2V2FiTnZpWG5NeDUwZFVrUDV4?=
 =?utf-8?B?SnFGRWYyRTBTeVVXY1RodDhnYVl6ejY0RFhaeXIwTi9EOEt1dVNhSkZta1ZR?=
 =?utf-8?B?bmprUG84cys3YVp3VlAxY09qdUxTVkxocVhFdWxTQnhLQkFNY2FVTW1kR2pC?=
 =?utf-8?B?SlNnajhhNE5RdjkzejdoRksxek1EK0ZQSlo3dWdQaC9SaHFqWDIzc3JFZURs?=
 =?utf-8?B?MjZoOVlMSEFBd1UyY2Z4S3ZOK1FXMDZVbGM3M2lValZYUFB1V3FaNzNjcWk4?=
 =?utf-8?B?aXYwWlcySGN5L0Zxd2ozMUVKSGVYYkVaRjhUVEJxMm9zeWY3eVo3QzdWMVE3?=
 =?utf-8?B?N3JHaHA0dzFjSDdnZUxKZk0wbFFIeDBSOHZWaHVCVFZkTm5ZQzREaUNVeTFq?=
 =?utf-8?B?U1NZT0VMZU1FSGYyYXVJOElQR1p6dGViaER4UkZYajk0Z21mamF5d2lBR3VT?=
 =?utf-8?B?enFscHk3SHROVHl0S3RYMi9OUG4vQXNlQlBDamF4V3VhTlFsUmhsUmoxMGtN?=
 =?utf-8?B?T3hvRTU2K1VhYXptZEVON1J0eStWK0dkVzdxYkp5dGJHalQ2Z08wYlFuV1RI?=
 =?utf-8?B?RUdaY2NvNjN1ZUQ1NkNuR04xTzBKUXphSk15SHVNNG9ZbDRiMHRzMmdHbGF0?=
 =?utf-8?B?bllWL0FUTy9WQVlxdTAvM2MvWVVJTTV0RWtoWSsycDEyR0ZJVXI3VUVVL0NB?=
 =?utf-8?Q?+mpGX8nOq6aWLE3o=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b45e91-290c-424f-e4a5-08de4e11ed74
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 17:26:44.0664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHsvK8I/6QTuQZcyNffxBTCOP2R5TTFLoF5XrQBO1AJ0RSUvyOXgMGj6gUHn2gVpRqaJQ25+WVR7H9ODQNcPqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7289
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 17:26:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21416

On 07.01.26 14:26, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> These defaults should always be set and there should not be
> part of the kas option file.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/swupdate.yml                               |  5 -----
>  recipes-core/images/swupdate.inc                   | 14 ++++++++++++++
>  .../cip-core-initramfs/cip-core-initramfs.bb       |  2 ++
>  3 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index f1f3f77..4a128f1 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -20,11 +20,6 @@ local_conf_header:
>      OVERRIDES .= ":swupdate"
>  
>    wic-swu: |
> -    RO_ROOTFS_TYPE ??= "squashfs"
> -    IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
> -    IMAGE_FSTYPES:append = " swu"
> -    # input is already compressed
> -    SWU_COMPRESSION_TYPE = ""
>      WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
>      ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
>      ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 75be566..fa35458 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -12,6 +12,20 @@
>  inherit image_uuid
>  inherit read-only-rootfs
>  
> +SWUPDATE_BOOTLOADER ??= "efibootguard"
> +python __anonymous() {
> +    bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"

Nit: Do we actually need the "or None"? bootloader will be None already
if there is no SWUPDATE_BOOTLOADER, won't it?

Jan

> +    if not bootloader in ["efibootguard"]:
> +        bb.error("swupdate: SWUPDATE_BOOTLOADER set to incompatible value: " + bootloader)
> +}
> +
> +include recipes-core/images/swupdate-${SWUPDATE_BOOTLOADER}.inc
> +
> +IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
> +IMAGE_FSTYPES:append = " swu"
> +# input is already compressed
> +SWU_COMPRESSION_TYPE = ""
> +
>  # read-only rootfs with /home and /var
>  # as separate partitions is used
>  # /boot is excluded as an unified kernel image
> diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> index 9d53394..076f14a 100644
> --- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> +++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> @@ -11,6 +11,8 @@
>  
>  inherit initramfs
>  
> +RO_ROOTFS_TYPE ??= "squashfs"
> +
>  INITRAMFS_INSTALL += " \
>      initramfs-overlay-hook \
>      "


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

