Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAC7C282DE
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 17:24:44 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.84])
 by mx.groups.io with SMTP id smtpd.web10.19806.1741281882469119152
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Mar 2025 09:24:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ho6A7qvR;
 spf=pass (domain: siemens.com, ip: 40.107.21.84, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePGrajYb48gqU2lWZJwaSMiO1H28l+iyG7/OnDs/EUeZP6PTNZ9SkxLHmRq5znh/vuI8zhTv3jIK64vefRhBs5A3ah7FgOs2OPHXp4whn9t6deKjRKxAAEc0vZHhjwxahuUBL1QjSgFy4WZgvif7bP9sVyzzo0q4eRyNmAk/Bew9TYTq7CPp3qTsAP39wLRjUmZCx1owaERvltSO10UVkNwKH6LhIVuokXhk/pWT8JyOGBfwECvKYaWqH3OSxYUU0k1EEyzFCTiMA6Bl4uoz0lx+GIk2qRimfOtBxopJ3gN9cnNSPYXwnVTervxcXVJCtbf0wm9ZYLNvrncowhmkjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhBA9Jbb9LUppM6OlLdk+rqTEVwbcPsQc81zisrbqMY=;
 b=UFJjvhCC9V0o9KehCkjwHG1Jg1SnWV8KNn4ONdCjUMte+reidhievFNGWQJ8T2OX2ybxEQl5xPbWn2obaoOVPJp4naftY1voTUxE41k194H3Vri94mE3YdN9726TZmdqUmG7kaBTBZl38LZg3WPqgZitTlturjj3O9wrz8a4bRQHlFfyinEjmp7MA8w8VQhubormQ6GDogu+E59G7/kbswWar5hMFEDsl6sdLRGYESQpKH+Ih+C7/KwWb+b49u5zURpiuALZE+bNAwztiM279sDOiIL7Dz+yC4ybNIgsDatYJd7mgz6QUCDmpDuZj8qV7qKmnp7CoROQRMsY8oEM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhBA9Jbb9LUppM6OlLdk+rqTEVwbcPsQc81zisrbqMY=;
 b=Ho6A7qvRehrvMxI0m/QYiPpgZRTXDPoydd0My9RXZpqaruTZ+RFBnjGs9zMCosoPWTDBq8mjzjAIrZFzShiIJJKRCn7mYjQT+esvBbuhef4Eelsc//sthWcCXBFRM4PbOCWALxj6L5N15TlJX6bXvFoABLaG7w+eYkq3/XsdfULqId1A+/g2fDlUuxNeiHAUpFvvN/BAs3OIkDCHcxJnVoId2DfGLS5LomW/sFTV998LBhoVmV7yQkkaRCOo/TbWaIJ69NzxqWWmRIgtQXhsJ+FHzKhZuDxc1Oyb7VBaOsXXRcYDefAqxFN/c6wzs26p4bPgduGU3lBdVZJPQ64Zyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by VE1PR10MB3967.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:14a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Thu, 6 Mar
 2025 17:24:38 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 17:24:38 +0000
Message-ID: <dbdfd4e8-6aee-4c65-9bbb-8c589bcba739@siemens.com>
Date: Thu, 6 Mar 2025 18:24:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to signer
 provider that hooks sign-secure-image
To: Gokhan Cetin <gokhan.cetin@siemens.com>, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20250306093516.3232063-1-gokhan.cetin@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250306093516.3232063-1-gokhan.cetin@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::11) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|VE1PR10MB3967:EE_
X-MS-Office365-Filtering-Correlation-Id: b751eaf7-5e86-4f3c-253f-08dd5cd3c591
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bHZnUzhpUEJyUk8wTXlSY2dTSFBPYWdaUzhLV3NPWWdDa3FqWkZUUnJHczVp?=
 =?utf-8?B?d0hBNzF3K2lLVGp0NzFOZkR6WTkwQXhPN3krVnc2S1M5aTgwbC9BSk1LdDFL?=
 =?utf-8?B?ZUdkRUxmRmYweU1HZ1dlMENTMlNoWUkvSXl6T2wyeFJKT2cwOE9hU0QwTmRF?=
 =?utf-8?B?QWRzZjRWY1hPcDY2K0FiRk5nRno1eEdXOFhGOCtwQWRSZUtmaWpTeVBKdHFj?=
 =?utf-8?B?dWZMUHJ5SG05b3ZHQjBDUWNOa0NBTW9iQ2tQaG93REliT0JzVHdGUUR2UEow?=
 =?utf-8?B?SmMydGVkdFozS3poR1BiUzNrdGxCNjM0WDN2Ti9SUzhBTy9Qa0NxSTlDSzdE?=
 =?utf-8?B?dGhpb3dGWmV0QUJ5anhQZ3BkWnVUZXdqZHEzMktZdzJGOGY1c0NXTEdobUFj?=
 =?utf-8?B?OFY0VjRuN0MzaEpxZmg4b0RqRm5RdHQxK2QwUlBROGw4ZUFZTnFyWFF1YzBF?=
 =?utf-8?B?MjBZR05CRjdZRlVMd0xEenNJWDczR0RuNlRNUXM5RVk3R1VlZW9jVDVFSGUv?=
 =?utf-8?B?RU9CQzA3TGpIUnY3K3d1UFo0dXlYcU45NHNEdGkwYWFSM0VReHJRSjNYUlJk?=
 =?utf-8?B?ZjVHUzh4WTZha3ZZN2h2ZFNRc0tFbGMvQXkyRHBSbFRpb24zbGI1N1FEcTNL?=
 =?utf-8?B?QWJOUWIyRWMva1VKRU1RQkFzVjE0UWlTcWdBYmpEemp5dFoxTDFaRDAwTnN2?=
 =?utf-8?B?eWJxaXZ1TVFhcWlXd1JkVUFWYjA2SExmSW1aOGpXcDBkSkZBdmxpRGlFcWE1?=
 =?utf-8?B?ckJ6RFlKYmlKaFpJSWlGUHRDUEgzWmFsRkNPYXFBUnRXekZWNDNxN3lxWURo?=
 =?utf-8?B?ZTkvZmtRRGJQN0d3aGNzczdRU3hNelhHT2FGQ0x2YVNvMmI3MU8zeVJLVUtt?=
 =?utf-8?B?ZmJSN3Bvek9MUE9WbVozMDdId3RPelVzeHJvT09SeEhEVy91QnNmQ1ZtdTRS?=
 =?utf-8?B?bDQ2NHdRSUMwU0dQTE1lU09RSDlJQng1WmRCZkV0NkM2Z1pva3p2MlhVSHFJ?=
 =?utf-8?B?OURrbXgyUFlXU2MwK25vRUNRUXlNZExCamgyOHFJS0tuTnFoLy9BK0JJRTAr?=
 =?utf-8?B?blVTS2xQTWt4N3Y5T2hkNkNJNVhrcjdaZkFFcEtTUjdkeFpYNzhwL05vV3Vk?=
 =?utf-8?B?YllJTTdBR1JaM2d4K2pVLzF6T1hoS2hUcXRRR0dUeWNRb2Y2ZktyN1cwMVJm?=
 =?utf-8?B?WElFb2JqR3BUdDYyWW1JZlAvRXBzb1pYbHBydlRIMkJDcXhwSUF1ZFUwaW5n?=
 =?utf-8?B?dXBURWpvZDZrcysvZFQvVGIyU29LV0d1S3hubTBBSklIYmFXcHZpY2xjalVS?=
 =?utf-8?B?cUVUY2wrell6TjRhRGEwclB1enVNRVVKVGtOTHJVakdNZlZRMW01ajJzOVM3?=
 =?utf-8?B?bm1GWXVxVk0ra3ZUY01zTGwwSWp2UExVUHFkeVZBMnMyN3pRUVF6c2VDOStH?=
 =?utf-8?B?bmw0R3l5czRBL3BBT0hvSitONDJnWWZjWm84MW5SeDFjT0NGWVdKQVhYcFNz?=
 =?utf-8?B?ODFDaXhpbnhMWTVSWEVkeSs1TVVQekNSVFVCTXNGNnJLbkZhVkdZTll6V2hT?=
 =?utf-8?B?SGhMRHJ6bEFCOGxBZUZ4U1RSNmtWbTFXRGY4SVpLdVFvcUhCZDFFWkVSbGx6?=
 =?utf-8?B?OVN3djFYVXNmWkNHMXBNVGtqMlgzZ1hUanpPdFlwcDF3RGZ5bEpUUllyWWdW?=
 =?utf-8?B?Q1lZUnZBL1FGT1RBYnJScVRiVVRhSXphcXN5eXRPL2I0bGluVmZTQW15dnVv?=
 =?utf-8?B?TE04YnoxaHZqZ05uUHpibS9xRkFFYmt1OStwa2V2TUhOUUkya3o5bXZLT3Yx?=
 =?utf-8?B?ei80Yk9JcTNWcjlaS3BNNElCTzRuN3hFMDVBbEVUTW1iMk9kRG9LSjRQYUMx?=
 =?utf-8?Q?qLeDKyhIgjfXU?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bDBlaGNhNGs5eUdTSmN3cjYrbzFZQjBMZFIwc21QSkJkeTZxK2VPZFl5N3RW?=
 =?utf-8?B?YjFKdnhNcnlHUWczUXFQK0RTK21kTVRHNURZam90ZTlvWjcrWkhtZGJGSjdY?=
 =?utf-8?B?WENIT1NwcmU2eFM4dy9NRVUxSFpxR09MeXpaTHpGb0dZZXZSdkhPOFUxRnNG?=
 =?utf-8?B?YjRiNFl5Q0MrelNFUUZrUStEL1cra2lsU0hsRXpXc3Q1WllQWXh5L0VHNENq?=
 =?utf-8?B?dzVHakduZit6bmlic2lxdktueU5nY3JUNm5JQUtXSmMraUhFU0QyVE04SCs2?=
 =?utf-8?B?ZXhXNHpnVUNwU0YvWlE3Qlc1VWkxekk4MFlsKytsSFZ1dHVBWFlET2FjT3ZQ?=
 =?utf-8?B?L3lCaW1vNFR3a08rN2JzYjc2djRHZTNQWU1SQkwyL2tUL0xOdnFYMGI4QVox?=
 =?utf-8?B?TkVEdHArdlZQa0FHYklKMGZySXlBQXhyY2xteEhiVDZvNExrSlE4bnFJNW5R?=
 =?utf-8?B?SlRNdHJUdUFUVFNKcUZyNkVkTnU4Rk5xOUdCZ3Q3b3d5VXdiTTU2NFJnYXUz?=
 =?utf-8?B?WUo1MS8wRitBNVphL0phaHRZV2hMSHNVN3JVa3F5bWw4Vm9VWWdUV1lpTXNx?=
 =?utf-8?B?RHJlZjAwUXZIbmFPd25LTjZIRzhzOUxLb1JNTnl4bkhwSWtYOHhHOXoxcEw5?=
 =?utf-8?B?TmVCODFxRFMvanVyQ1gxZ3FpUjVwRUdYcTdMcEM5VWx3OW85dU1DcGRPbFlo?=
 =?utf-8?B?cUZuMjN5K016T0hJeFE4RzlFVStvRXVERThWZXRnUklpZlNtY2VRU1ZNQUw1?=
 =?utf-8?B?cjFiMTIvbkNrY2xSUGxPL29WWnEvdjFIMGtEUGpUQ29NQldaZzVNaTJ6TmI4?=
 =?utf-8?B?R3lmLzRuKzcrdWJFOUhoY25vSGcyZEdTQzhkVERqWkcxT0RxUFZYZWl0bzJ3?=
 =?utf-8?B?OGNKb2JiNmtBKzVHd2VBZWtjenFxMWZLbk45UEU4ZFJFSFc3Y2toOVhtakp4?=
 =?utf-8?B?STJZUXJZdk1NcFZwL1VxNzlmUzFvdjkwZXBJRWNhSWM1RmI4K09wZDVOY2Q5?=
 =?utf-8?B?bnpUOWFoeXRNZzlYRXl1bnB1S2FhRERCRng2UGp5SGR0Y2J3alFBVm1zZWRL?=
 =?utf-8?B?a1Q3ZTUzSmo5cHNDOVlvKzBmNlBOQ25DWUtzWExZRTFOdytBb295RlAzeVRC?=
 =?utf-8?B?bjUwK2lCcjNNaHlvcFN4TGVYUWh2cllISmlvSkphNHVTS29Rd1kyUExoM1Q5?=
 =?utf-8?B?RHZVZVJTRHZsODRaaWVrbzlJL1NaNUIzSjVNd0dMell1YkFaejZNeGpIbkRT?=
 =?utf-8?B?L2pyNk9xVUNTMDJPeS81UFdrcS9zbkpEckVEaGpPTU95STVNbFRyZ3huY3VJ?=
 =?utf-8?B?WlVKVDh1ckRCYllMRjJPaFYvMjhvaEtpZGZpSW9oRnpPNWthdS8rais4VDR0?=
 =?utf-8?B?d21DWHZZc3MrUTdXREVMWFE3M2htWFhpMXA1NEVRQW9UTmR2ci8zTzNkcFlC?=
 =?utf-8?B?ZmNLNDg2ektlaWVQSW42Y3cxcUxHVEc2cS9odnpPSUhSSkhsNForMDA2d24r?=
 =?utf-8?B?dWRybTJuSzRhcTRGcmdXK3JmMmJ3Q0dyNDBadmtIb1B4ek56UVczeXIrWEtz?=
 =?utf-8?B?cGllbTVRRG9DclUrcC8zYnE3Q2M2QXRkbGtiRXZsMHZvUmZHNXdRR1gwNUdl?=
 =?utf-8?B?bWpORVQxNWRBUGFwY2lOMzFjaUExWGkvbHFBL0JsTWNUdzlxY2IvQ0kyME43?=
 =?utf-8?B?bnVFekJlM3Yxa1hzNko2V3pWK0gyN1JFT0ZGYmhsLzF4bVRXSEVVbnFoNTE4?=
 =?utf-8?B?L29FbTlMNzVnM0RPazJBczZraCtvODIwMHl3Wm1PRnkyQlRqanlVYXlDWFRN?=
 =?utf-8?B?czV1RGtPaE5ab0lWNjFVNTMvdFVhcERaN29PcEllSFMzUVBISUQrNGxwS0JJ?=
 =?utf-8?B?YmltckpyeVRVczdsb09vZW5UZHJBV0E3WndtcVBuQWU5Wkc2K0tVVkZMa1Vo?=
 =?utf-8?B?UEJKQlJqeEs3VWkrMk81ZTNDQjBzZzRqUGFmWm82UGlPSVFRTFROSGE3V3NJ?=
 =?utf-8?B?eVZDZDQ5a1NDa2tvbU4zU1Y5UEZEWitWNmtub2VOMmxMeFFVeXhmMU5GNEhl?=
 =?utf-8?B?S29OMlRnWk1lWExIZTRmTmZERlhiQVdqVFB1SWhrMXBRbEQvbG0ycEs4b045?=
 =?utf-8?B?MzZIdzQ4eGNVemUzc3loVjJEVEpJMy9zUUNia0RUSGJWUnoxdWhpOGxTOGo3?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b751eaf7-5e86-4f3c-253f-08dd5cd3c591
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 17:24:38.3254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6z9Sa7Pw6PMbzu5BiwaBRCEIuV8mGbi0dWzN5v+r+AC+Ks+FpF9WR1wn/l/hnu72DZf8PxjbQ5p2aX/E2mKnRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3967
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Mar 2025 17:24:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18060

On 06.03.25 10:35, Gokhan Cetin wrote:
> These changes split the signing process into two stages.
> In the first stage, the `sign-secure-image` script called by the efibootguard wic
> plugin now uses a hook to create a detached signature.
> 
> This allows downstream layers to provide their own signer scripts in a similar manner
> for the second stage, without having to overwrite signer script or partition's source parameter.
> 
> Signed-off-by: Gokhan Cetin <gokhan.cetin@siemens.com>
> ---

...

> -faketime_cmd=""
> -if [ -n "$SOURCE_DATE_EPOCH" ]; then
> -    faketime_cmd="faketime -f \"$(TZ=UTC date -d @$SOURCE_DATE_EPOCH +'%Y-%m-%d %H:%M:%S')\""
> -fi

You are also dropping this, breaking reproducibility (see also [1]).
Another reason to carefully refactor while providing reasons, not just
replace existing code.

Jan

[1] https://github.com/rhboot/pesign/issues/125

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

