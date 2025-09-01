Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA7FCA0FFD
	for <webhook@archiver.kernel.org>; Mon,  1 Sep 2025 09:29:59 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.3])
 by mx.groups.io with SMTP id smtpd.web10.47362.1756718991727292973
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Sep 2025 02:29:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MSz5H3rv;
 spf=pass (domain: siemens.com, ip: 52.101.65.3, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgxxFLZlrZz3OGI2n2bcNdiOHozMgzjo2Fi1vIEXzN2CphW1hnj6YB+j0L+JJ28iA6h2P1f2d0fNIi4FKmcWv7zcw6rjQAawEFnorZCW1j/+2b27lHN8pZ12sppig/5CvBDblc/be146ldTg+qxATbXXH3FKZsRS017sZKiHBv0zFcwXNwaK9Qg+W3sIaPTaQaXt9HlqFDMh23CWcz+8c0WFXAgmhHZaBvmtRxVycVCKR/ezNHeQoD0x3z5l20KD9b2Gt9xcE0piDyAwLAvGlR8HJO0Pm/t/Ghi/5Vw69b4z/u9BzjwiK/tqHJs9hhfpo5TgnOjnuaf4ZhClw73c2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w80C/jvANuRwIyFbn/l5+36ftyhzF66K02a1JlL2GlQ=;
 b=xeASE38326Osdm18vnJVkbKJdm51OjP9Zg7heKi0kZryywyhNjumki1vEWdN4dawFdAgP2j2kBb+D/tUbiAqQwmoRMMJaJGETPYS3/UgyKpMtCkYW/aakJfDeU6rdNTw2xNFdyUsdfEA2fafa8yTN5GtOfpewkc/PC6wocHWJ2D21eViD+0FtPJFQxaZHAsKTbWTQbTihloKCaNT/TuqWgjU8Z6LMZkAaeCU4vPlP2buCSXBRK7wwmb4sogFbgOqbWmS8FKym5AWzLDMiBAHfp2qbKHc47QxL8zM7ZSFgkopefblsNIqGreMn39us3TFxUsWadeKCeZ4KUumrHST0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w80C/jvANuRwIyFbn/l5+36ftyhzF66K02a1JlL2GlQ=;
 b=MSz5H3rvlsLSsDRQhorjY6WCB5hx6+RcSIl2zEWwgM2qP5f5TN9qxBv9wku5nw6KShYeqYEqoxvsByUKTYQCSo/1zCOHIe6CVlNn3rC0e0f0nbxNnwjPzOhqtG7sfojJ1RnqQvT9uMsYAPkyVW7qrZHIvQ2MCIr2PESvuVRju2lrXvbLtxwDZKo1fQyFKOEifJfYHMc0Nz8nS00dN+tMCN/ufQ/fqDTAyMLOGiiDlwodvduBtRtEWgXD9fK7RlmlspVIsIMj86GPVPNLOzty3Pph804Do11C8nzruif7ppir4hJtEU86saliYs68z1JN7k3/xGAXRdUG9o9IGAk9vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
 by DB8PR10MB3193.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Mon, 1 Sep
 2025 09:29:48 +0000
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a]) by AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a%3]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 09:29:47 +0000
Message-ID: <37ffa0d6-9591-467f-922f-4201358e9d48@siemens.com>
Date: Mon, 1 Sep 2025 11:29:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 2/7] Add factory-reset
 initramfs hook
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 gokhan.cetin@siemens.com
References: <20250828110712.392641-1-Quirin.Gylstorff@siemens.com>
 <20250828110712.392641-3-Quirin.Gylstorff@siemens.com>
 <ccd932f7-27e7-48fa-b0b6-5e19881a8f8b@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <ccd932f7-27e7-48fa-b0b6-5e19881a8f8b@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::9) To AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:525::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB6023:EE_|DB8PR10MB3193:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7d283c-bf41-4ef4-d93c-08dde93a17fe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RDR2bERhdXB3QTllSDRzVjF0clBsVjd1YnJadWh6YTNhR09rMkw3Rnd1dnRB?=
 =?utf-8?B?QThHM3ZWMlJjMnhkUUltV2FxQzlHcUN4Vi9ENVlJL21UanpEc0p2MEcydytw?=
 =?utf-8?B?bVlsTGd2WTlRK3ZCVzA0bHdtVzdEeC9idzFVOEpJOUZNWEVjSXZCVWpHYXRO?=
 =?utf-8?B?WWRBdUhROFoxWEh6R055blNzcUtjRjFKRGdkd1FDTVd4R1ArYk0zbTROL1lD?=
 =?utf-8?B?M2VycHJ0L1NoUFRjY0owcHRmNjFjT0lMSU45YXFRSHZuUFdicm1pTFhTNUlO?=
 =?utf-8?B?ZmtnMVpkRlpiUjZvVGFhcW5xNlFjL2FuTnlxR0dwU0d6UzhtWmpwY1NyQlRY?=
 =?utf-8?B?aXdTaTNtOFNsWWdDQlFRMC8yUnk2bXNFWi83WGkrUkxoYVFWMStyYmdodCsr?=
 =?utf-8?B?TTZNRU9kWWUxWldJWnVDTGswV3huMWhGaVVlM0JpcklTY3VCZHRjS09qcktO?=
 =?utf-8?B?Z3FYekdRRlNYM0VyVC9rTDhtVU9SaW4rVkNXVks1enFpa1dVenFBdCtNRVdl?=
 =?utf-8?B?UEN3QVk3UDhxTXZ2eGVBMGFFS05zKzFpTndZSk54L3d6NDZidHlwTzdFM2lM?=
 =?utf-8?B?THc0QWFrQVB6V1J2a3ZzWTJDSkFiR2VEZlgrUkM2UExYYWNmdnpHT3BQeUZi?=
 =?utf-8?B?L1NVd3E3aGZHNkRXeGFSUW9MS0VpUi95RU13U3RERW9mYnViVlJIb2t2VkNi?=
 =?utf-8?B?dGc4S0MybGw3TzA0VVZuUUlUSlkzK3NaRFgvM2c5djR3QkNEOUpGdnFjWFo4?=
 =?utf-8?B?OW9MR1NvSXo2Qk5leUhmQmpSVHJ0TzhlRURxK21sQnZVOUxlS0FnejdldE5T?=
 =?utf-8?B?MEpzU0ZKWC9qOFQ1SGZEcCtLeTB3RUZBZVE0T0xZa1phMW9rQ2kwdHVUMmdh?=
 =?utf-8?B?WkloNiszR0d5dGVDUit2ZDNTY1BHbnl1MGE1RXNHSlRpd3dxZXplQXBUUFFk?=
 =?utf-8?B?YURLclBRb3k0eC9yTW82dmJLSWt0UXlGUFRETE84SDVVNzdHdlptQUlSZGNw?=
 =?utf-8?B?Q2w2djRtNXRDbUI4aWVVSHA1eFBNV1hVbUlEVkNRTnFuQm5XK2pKNFNaN3E4?=
 =?utf-8?B?R28wcHdjSURBS2NuZGcvMmp2cXhWSTYzZjdrSkN5RVFBNC9PN3c2QlRWR2V5?=
 =?utf-8?B?aGtQdmhDRURpQWRjWFZjNG8wbExxRHppYlJ0NFdtR1loUUxISnBscnpibGtl?=
 =?utf-8?B?WnBoRmxDZ1BmNlRndEU5UnZ4dERaQkV2NWhZS2crYzhBeUh0NVE0YU9nUkYx?=
 =?utf-8?B?dnAvVkhSL3ZoZ3JkS1Z3NzIxaEhZVXVLNkFxTVdwSWdidW83RFdMWlVDcUhY?=
 =?utf-8?B?blV0QS9TaG9DQVJOUjQwWjIyUHlpaWErTUliU21BOEFzcFlMeWRTRDdHOG9l?=
 =?utf-8?B?bk9ySFIzNWhuaVdiV0g4VEhMbXluYUg3ZGR1YWpqTTljL3psTkRwMmZIdmtj?=
 =?utf-8?B?OVVJQWZVZnlEMDZwQUpTeEZtWGZxUUNSOCtDdUpVSFZUUWJnL2FnVjVGWERY?=
 =?utf-8?B?eWxrMk1vREd2K3RDYTZyRXJPTkh6cG5YNUdEVDUyOTZ4aXhnNjZIdERUb1VS?=
 =?utf-8?B?WXQza0VHeUxWZEY3OWxaRWxIM2VOMlMydHkvOE9VS0hQTzk4dXYrQ0NrcGRN?=
 =?utf-8?B?MVhPQVZ1UkRTWVdIY3JTbXdTcCtjRHRITU9jamFIa2l5dEJ5MVlHR2VkRjN3?=
 =?utf-8?B?SHdtWnR3dUlxUWVMUnk4NTFLR2FEOTJ6MGhCZXMzY2xVVXRmNjViNUtrMU4x?=
 =?utf-8?B?MW91RGtpYVpEV0FhVUhsclVTU0QxVlRpdmJCWlB1eTdzZzJ1VGdSZWVqem82?=
 =?utf-8?B?NVFJU3FZZk9UR0lMRlRsRzUwWU9nbkZZUzdHUnhWZ3VscTdiUS8zK3VtNENU?=
 =?utf-8?B?ZmkwUUFGN2hqZnF4aS9lQ0hDRTROTGtUVExDa0NxdGVCeGc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eDEzWm9pRk5rM252RWUxSFdEME1Gb2JhZTNkWU8vV3dDWTBSejVKTkdWT3Fl?=
 =?utf-8?B?dFBWMXdpYTJRV3lsUVgxZXVMZE9YRVNOL3ZpVUNLNzN6V1Q4ZTFkS0ZZOXF4?=
 =?utf-8?B?ajFWY0hsaXpXb2hxeHpLWlNNWG11Z3QwQkNDMG1nMmorVEJieXVJTVkrQ285?=
 =?utf-8?B?RDhORmc2aXBPVjNndDVaVkFRODIxZmtYSTNTbGFORXg2cWVsNUJ1eVZkRTV2?=
 =?utf-8?B?WjFDT2ZYY1ZMdHRWMWUrc0JGRDFrRUlzQ1A1dDVoVmYwaXdYYW15QUd6RTlP?=
 =?utf-8?B?cUMyS0dnZFY0ODUvSnhQZ21KUklya09MOWVETWhKd0wxUy8xckRpUS8wRUlQ?=
 =?utf-8?B?Z2RVcjFvczM3dDBwakJXcGVTRlk4UHBNbC8vRDJmVHNySnJ4dXNHRGRTZE8x?=
 =?utf-8?B?MC9WMlVLQ2hMZEpEVlNWN0pjZVo2Uys1SGRxQ2dUbmRkelI1bWpQendZbTZK?=
 =?utf-8?B?TGJ6bmg4OXBxa2V1QXBRalRidnAwYlUvRDQxelAxZThIOENkTUFwMHZ0NGpB?=
 =?utf-8?B?bWo3aFoybVRPdzF1bGZTb2hCdFdTYlNmVTdaSUdzbmY0L0FjM3FFVjFZSjAy?=
 =?utf-8?B?azJJd2lrb3NVY2RLTXQ2QitZNm96RzYrTXVTckszMTVLemZ3YWk1RXlDcG5q?=
 =?utf-8?B?b0FpdEN0MTViMXoySnZZL3dyd3dsZ1daUFR0OEYzVWZkaGt2OU5vZ3NNSCs4?=
 =?utf-8?B?dHJQM1UvYlh0Q0pPSERFTTExMDVJSTFCeXJkSnd3S2ZFK1dDWjJybnNDVzJ4?=
 =?utf-8?B?OVpyTlBvZHhrOWE1L2ZDdDlMbGFtdVZ3NkdIUG83UHpuYzNlelZkOGRKTUc2?=
 =?utf-8?B?U2d4ZXRUN2NuNWJraTM2VTl1b0xIRVdqTDc2OENYMXpKSC9xWDlyYndzaXdz?=
 =?utf-8?B?UjZSQmhhOTBJU2J3Y0U0ajhBMTloY28zQTkyQXdEWU05TCtjMDFsejlRS0M1?=
 =?utf-8?B?RGkwWjA0eVUwM3BMSVZ0Z1pIdFJTU0ZSNzNwamxIaVVvcmJRVENxZDltWFRp?=
 =?utf-8?B?RFNqYzgvanhvcGtNYjBZZklYZWREOUxvTDc5Wms1YzVBOEFtYUlWT0NJcXVt?=
 =?utf-8?B?azd4WFFZS085OWExclJmNjNVMnl0cmR1Z09SSmZtRFN1MnpDZDgyclBlYzcy?=
 =?utf-8?B?dU8xM1hXaFFGaHZlMzZBa00wa3Z0ZDdkN0JVdnpsdjJvNnV2NEs5WGVjeXln?=
 =?utf-8?B?czdVcmZpREN6dWYrUVhsemJxRXVYQStPQXg2cFY4NnpCNVVzVWptdlFTN1Ra?=
 =?utf-8?B?MjBMWFlWbTI3ZW1tUnhaNndhNlRodWVyOEszVkJwZ0UxNWZQMjFMYVJmMUhB?=
 =?utf-8?B?RUNpbXBTYUxWeTRCM2tuTWdsbjhrQURub3BmdzhEcHIrWnVocVVQblJnRFQ3?=
 =?utf-8?B?K1h3eStRRTV0dVF1bXNoRGRRVzBGM2VtbXpsZjEvNFpTNTV1d0ZCSEVidmtw?=
 =?utf-8?B?VGZuNkZVNWk4eEpudWxPcjloVzhFelBhTkFGa2ZqcnBXdG1tRGRqOVJRQlAw?=
 =?utf-8?B?QU9lZThKOVBRSTRqQnQ0TDUzenNBKzlWajlIMFJmNGxjNHY4S2dGRURYTUNr?=
 =?utf-8?B?dGRqREE2TDVDcFJKVEpRREJINHlzWnBQL0dCSDZTcXNjWEE0RGF4UjJTZFlK?=
 =?utf-8?B?ZWNrNndTZ0RIMFFRZjRLL1hQT3hpU09wSHUrN1NGOHAyUHNVODNuY3BwUXZs?=
 =?utf-8?B?cC83VnNIbHMzaU1YR2FwUCt5dDczM1A2ZHFaaERKcnFqcFMvSEk3aUJaRVo2?=
 =?utf-8?B?UUVpTkJwMHhWOVBFcXhMdzZDZ0FBZnowbWhlK0lTSjZYWVgyM3FaeUkwT05t?=
 =?utf-8?B?amV0NGFQRzdkdEVIVHFPNlFqbWQ5L3gwUUgwTWZPeEkzR2o4ekNPVEUrR0o1?=
 =?utf-8?B?RWJldFlBY1lPalV3MEhiVGFnTTU0cUkyeWxpbFc3dXpraGI0SzloSm9WczFF?=
 =?utf-8?B?RHQxd1pKZjlPN2o0amhhOWhTNVhEMTJoRER4RGtSeUd0bGord2dpTllDdE1y?=
 =?utf-8?B?MGtnSThQeGVLTjlSdHhjd1p2QUkwQ2VxQitJMndSbmNhWlhxby81dytWUW90?=
 =?utf-8?B?eE1TODFLSDBRU2lOb2tkV3JhNzNRbHVhOFhlTFY1VklDMGlpMDNOZ003cStx?=
 =?utf-8?B?QXZoZnovbmVEU2RteDE1VERSd2NCTXZLZXNDZjJiNm5SWlkwak9LUXJKVXBT?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7d283c-bf41-4ef4-d93c-08dde93a17fe
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:29:47.8518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knQSIAlgV7ONOAy1q7IIUymVeEUat5g6b2kJrqeLRfhS2UvSjcGkVfVIn+SnsJEhHohoPLk4b1XHoP9lQWBnjTZl2sq8Rs1hMTNSpTpgM4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3193
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Sep 2025 09:29:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19990



On 8/31/25 15:10, Jan Kiszka wrote:
> On 28.08.25 13:06, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows to reset the device back to first boot by
>> formatting the persistent partitions.
>>
>> The reset occurs if a file defined by the variable
>> INITRAMFS_FACTORY_RESET_MARKER
>> exists in the device INITRAMFS_FACTORY_RESET_MARKER_DEVICE.
>>
>> In case of disk encryption it will invalidate the keys
>> stored in the TPM.
> 
> I wonder if this needs some finer control: We only clear the TPM in case
> that :encrypt-partitions override is set. What if a user if this
> infrastructure would clearing also in other cases? And what if only the
> encryption key should be wiped from the TPM?
> 
> I'm a little bit concerned about what "factory reset" may imply for
> users. In some cases, it may actually mean to wipe anything that made
> the device "unique". In others, it may be needed to return to the state
> that was programmed in the factory, and that may include bits in the TPM
> that should be kept in such a case.

Ok this would be more of a data-reset functionality, then a 
factory-reset. I can add that functionality as a separate option or in a 
separate MR. It needs a separate script as it requires a change in the 
ordering.

Quirin
> 
> Jan
> 


