Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C7ECCD1BF
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 12:29:38 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.41])
 by mx.groups.io with SMTP id smtpd.web11.7270.1761654574240180472
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Oct 2025 05:29:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NBoeXe+n;
 spf=pass (domain: siemens.com, ip: 52.101.72.41, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZEegNcA82Y5pGNTj2lqNH4teUtnFoICKu2pA8vw4HT+UtCGGYPsLoqTp7gGKti7HjZKqtzVrwZmsAnttpZVqN7r+SIZrFb1c4wG7LUuXeKgET4hDLkqnDdp1WHXq4hc1edvK9Qey0VhUmouFXVD5eS3FS87MVteDUQUnB6jTcfntJJCDlq6Iv0jXvX57a9HGQY+VUpikAAlhwv5aMRuKg5rk2VrBV3aYSSfvY/NEolGI7BI8jE13xauIT7j74A+lXO1dwuoIsk47SrZg1zt6nGzIfjP03ONNiRIJ5jLNyu1VVCCaqFwNGGK9BMsp8BtHHhCJohSP84w8CqXt8MYBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAdSgaD4560YNISDW4+9Iqrti3gCCL0LxPYzbdBcuW4=;
 b=h8LZXW+Ey3sYBaPoSI9JRttCpH8gIaYKfYMhHYmZjgB7FpCIAStQ59o/tLLboQ9nVDNnDUgnrjtfPYglihuVITw+FhZhruZ8nADcnYPY8Gv5JFfNIi2TPdwRntAQzZXqwWFtAfFzXkMy/AMe7uMAUX0Nebr+SX0nVVppNG5qhd4Hqy2CjBJzxdH8aF+Wnsn7vKMDiuwfJjrL9tfrS2uR35xTr9d53zyCDejqomjZf6P+IY/dr7NYJNQx0q4Xq4YC4JHHpXFJJ7ARCL79feiPgZ8YaDKuTLYSoeyuAC7y4t+dJ/NQrxqHHG+noLtp0Uf/dROqiQgdbvRLqt29ljgYrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAdSgaD4560YNISDW4+9Iqrti3gCCL0LxPYzbdBcuW4=;
 b=NBoeXe+n1dk2yAt7IiGdqrO2zDYDoqUXa2L8Swz8xYFOede6aqf7WOlGp0pK0Mla7aBblGLA9dGCUT7CjQbodsl3stXgxIAwFQINBgG8iCawZBIGOLTzKMWwzPujAC8j8WUzsyCswpaay5CtD9IujzvacxPDpA54TvF1gTwgTi9pdagP2WECfQZU4gG6TRnuv22OPpAeEHDxteFg0qoGTDamrgI3uPDG/sN8e+chuq0sTeIAjPMyC/Kmf2Bi9n/iJU11TF8Bcx17yfXnNf6575xonn+9C7z271GuX6DCzHi+0ecHeRhDznGd8fxSyfOxx4zMbnxBE+xnyx5HM4JaFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
 by PA1PR10MB9386.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 12:29:31 +0000
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a]) by AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a%7]) with mapi id 15.20.9253.011; Tue, 28 Oct 2025
 12:29:30 +0000
Message-ID: <fbfa1ea9-b74f-4c24-8ed9-cf03bda6f2e5@siemens.com>
Date: Tue, 28 Oct 2025 13:29:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v1 1/5] SWUpdate: Use self-built
 SWUpdate 2025.05 for trixie
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
References: <20251021125233.1528087-1-Adithya.Balakumar@toshiba-tsip.com>
 <20251021125233.1528087-2-Adithya.Balakumar@toshiba-tsip.com>
 <0f2a33fc-dcca-423e-a3f6-efc12a3a6d50@siemens.com>
 <TYCPR01MB966928ACDB11A20191951248C4FCA@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <ea2de6f2-5574-44e9-8c96-29d1ec0d3084@siemens.com>
 <TYCPR01MB9669C1BBAD337197C9365A91C4FDA@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <TYCPR01MB9669C1BBAD337197C9365A91C4FDA@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0238.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::13) To AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:525::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB6023:EE_|PA1PR10MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd2bb9b-8806-4153-7550-08de161da4c7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eVBKcVR2dnlrZWJ6Ulkra3RZRlhyd2dEQlpEWm8yMTFFVU9pejBWODR2dXBM?=
 =?utf-8?B?Tit2cVVEN1JOcjA5ay9JMitjc1VJdWdabHlDRldFbDBFemVZdCtEdHFsTlZh?=
 =?utf-8?B?cFlKVC9VN1ljTkluWFQ5cE5hT3NtYVgvS0JuaHZJOG04Qk9HQjlvc3c1RnpR?=
 =?utf-8?B?T09pdlkxV0VTWDJ6cmtMNDE5dGdVT0ZaVnA0aVpDZGZrQkxwajhzdXlhWDcy?=
 =?utf-8?B?TDZoUyt5c1l1Q1VKSWpweXZuNVJxam80aVBqRmFIL3pmcmdEMXRWeXZNOHFU?=
 =?utf-8?B?SmpkdVZJL01rVHdaNERGZnAzRkc2M2FROTc0RkdsdGl4LzZNaXArWHBmTWJn?=
 =?utf-8?B?dTcwbGE0NmovWHg5NkxWcEJLamJtMk9JUHNNTm5BYnRCMGxwVlJtMERxb3Uv?=
 =?utf-8?B?T2lWUytqM1BxWklUWkdkck1rUXB5d1Fkb1VjdzF0bzBmNDlMRXlQWmliQzRm?=
 =?utf-8?B?RVU0U0FZV0dHTllScUE1VU1TR1lTY0Zac3JMS1ErcXRKR2czWnNjSE5kYm52?=
 =?utf-8?B?bUVnejR2elYwZ3dCZTJ3SG5LQkhoeStJdXZMMHJ4YnE0aGtSc0pGZy9FYzRj?=
 =?utf-8?B?elBaeDMybGVTeEU3cFJaR3BzZjF6UUNoYnBOQTN5OXJVVnk0QWNyTUpRNjkx?=
 =?utf-8?B?bWV5MEJjbHJQaEJaZGJUUGE5cndkZXhXb1NUdDhUR1Y3ZWtUM2ppTm9BVUdl?=
 =?utf-8?B?MlZ6d1creHB6VTQwa0hONjA3WXRCMUVnQjJkY2NxMkRBeE8zNG1WdW1ucFdu?=
 =?utf-8?B?SjhaRGo3K1RaYmo5VTQ4L1hBZTNFT20xU1ptaVBHeW1pNEt2RXVGckJZOWxp?=
 =?utf-8?B?Myt3em9OMnRpTkR3bDZvRFp5anZmaUZxVWlEMWJEVGo0SHVsUFk0MUxjTnZ1?=
 =?utf-8?B?djE1WGViZyt1enNRbWJaeHFmTGpRNzNUaUozWFR3UnAvVFovYnh0OW5sR2J3?=
 =?utf-8?B?QVFxR3U2T0pFL2xRYjV5N2U3Z2YxUWJlZXFXQkhRaGx5ZEdUeWYrNG5zQkpj?=
 =?utf-8?B?bUQ5TTJGMUJXVnBWS0x5Q3ZrOHNjSUFnWHpjUUF1U0o4UWRnSEV5V0thUlhS?=
 =?utf-8?B?bHlqZ3pFR1FxSm9xUzZCVHgveUJScktTMkpmUHkwREsxM3hnakw3ME5CQ3Fu?=
 =?utf-8?B?MnZKb1hmUm1wU2djM3Q1ZmR3T2dueUY5Z1R0elVHdWcyTVJkOTVERWhndnM2?=
 =?utf-8?B?WmsyalRnQTl6WnV3UkNiYTZ3UmIyU29kdzlNanF0YTJwRUNYUTdzTzhVTDA1?=
 =?utf-8?B?ZkdIRFVCeUJpd0xmbDhXWU42OFg2TnNRU1BGcWJCUDBpMWhDcDI1ZGc0L3d3?=
 =?utf-8?B?dDFYQnVDNTBHL1Vwc1VpVDdoeE10SzJHS3hjcmc1b0pyb0dVenF4OWZ0Z1NG?=
 =?utf-8?B?U25ZWXlaZWQrRlRjcGtMR2JVUnhXTnFCa3hWZHVlZ3kxVENUek9uTlVSalRU?=
 =?utf-8?B?NkhURmJ0cG85cmd4c1l5ZFMzNnVXTXQ0Z3RudHJ0dHJFb1o2MTZOaGVNTWdW?=
 =?utf-8?B?SEZkbnF4Yk1VempZUFc4SDNMTS9uYjB3K0MzYTlheEFIdmhveThmTm1PaFRm?=
 =?utf-8?B?ZUZxc0N6dXEvNDMzcnlZY0dPUGFGNWpnRkQ3OEZCQjBKZ1h0STk4N1ZSc1l5?=
 =?utf-8?B?RTdMY3NqcUExR3lpTmJVUWhjZWhVM3YyeFphODlVRXREeFFsem1INXFOVGdh?=
 =?utf-8?B?Q01vT28vaFhQOU5qN3BnR1ZGVXJkUFV4c1FDR3JPcTl0WVljeGh1T1U1ZStu?=
 =?utf-8?B?SGE2VzB6WjVYczlzYnNDZ3BoRnhrRTRINEJxYm5hNGZuS3RRNUU2VE9pY3pS?=
 =?utf-8?B?ekcvd0tkb0xJMmZDL2ZvTWZ0SUdCa2VrUnQ4bWgxaTJUVVE4WjI0MUU1Nkgy?=
 =?utf-8?B?cU1rSXZPdmNKbmRMSXpRSzF2L0szbG1XUFNNVTNSb1pZYzhBdHIzaVNmcU9T?=
 =?utf-8?Q?bZmUlmcLtnxm1Zg5JmNl29YhkHNTrPMD?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K0J3R2l1ZjhrZTdoSFVwZFpqYmpncjNmQkg2MlRSQlRGckw0aTRRSGFqNEFH?=
 =?utf-8?B?NXpQT2crNkhNM2dFYUFwOHZ6VFd0djRjMmJrSkFVdHoyakhKZWIrNGxndUx1?=
 =?utf-8?B?MjhveTNuSTdXdWJpanNraE51QkVOWWIzWEgxMkpoSjFEMW92V2xhWmN5MFBF?=
 =?utf-8?B?RitRdkJLdm1aR0xTSVJTdmJ0NnRyQkREWTljRjRVakx5K0VGQkFhVHM5a2t3?=
 =?utf-8?B?VFk4QVhwOUtwK3dyUGRKNlFRdTdNVUJCU1RRRFVEaEEvaDZHcGhFYUFFTUlL?=
 =?utf-8?B?VW1uTE9MR1RvSllZV0FpUVRYS1RNcWZVL0ozYlFYb0taUk5uU0hxY3IzcWxt?=
 =?utf-8?B?QmVPbkoyNCtJNHR2RTcrZTBiWVd1YjVucG1tWFh2TElhdjZxblFtRnZqSHFR?=
 =?utf-8?B?NUl3a1pzZXNRSlVlY1NicjdPOWVzYWlRMzcwTmF6YjlZeEo2OUs3YTAwUG44?=
 =?utf-8?B?a0QwWWx1eEd5MExtZnVXanpkc1FXWlc5Szhhbk85QTVFOWxXSDYyWm9HMzFi?=
 =?utf-8?B?UDR2dlY0ZEt5RjRjL3BkdWNFbFNyYlNWVGo1Zm9tNEJqRW1IRUp1VnRibWRk?=
 =?utf-8?B?Q3E0N1VjaG1UTnU1dW5GSDg2b3NCUFVGWnM4K0ROZzR1THNqWnp0ZWYwSWtB?=
 =?utf-8?B?eFVDOWxwWlM3ODhXWkxwU1JSWFVMSXJzMTdkdWtML1lKVnF5eHlNZEdsZkNx?=
 =?utf-8?B?ZFFGZ3V3QWNrYUVkNWQ2Q0hEVms1c29hL1RnQmFPSXhraFE1REw0NXFSVTJk?=
 =?utf-8?B?NEcwYzZ1aXhtc1Jhb3RFdy9JNGt2SFliQktQdlM0cVEvV0paUU1rWFdiVXdz?=
 =?utf-8?B?Z0V2NEx2NFVMR2VST21jVnJNU0ZKeC9Jci9iczV4UldjNWhQV1FxTS9QdkpQ?=
 =?utf-8?B?V3RiN2EvSlpwbHd1SzZTN3dCNUZ6SnZOREF0c3JuMWx3QzN0eEFEQ3Nwb1I3?=
 =?utf-8?B?MXBhSDlTd0pWdWpSdHpKdjQybmNxTmtWMVUvMGxWbjJ4Z0pXN01EMnVGWHFa?=
 =?utf-8?B?MkJ1NU42SnpuRGNLVjJaZG52aGpLcU4xalZOK2t4ZmZUY3ZYZDFqYXkrU2VP?=
 =?utf-8?B?WmtGSVRiVjJPT29QejkySEVRQUY4VmtKZG94dDRUajA0Y3BmMVdNaHJlM0VQ?=
 =?utf-8?B?bWxmRU4ydTN2WGhYbHprem5pN2M2OTJabCtEa1lUeFE2bHByTW5VT3lrakoz?=
 =?utf-8?B?TnRqUXdpbnJEeHAxY0FUWTA5SVFRUzQwSGhqazUzbThsVHdTcTZuK3pEWWM4?=
 =?utf-8?B?aTdiVXlCZGpZN2oxa2VOSERodFlNS0JQZHFFbWN6RTJQZ0lTeEZxUEJEK0NT?=
 =?utf-8?B?VDhtTVJiTXVKK2kwbW9ZTWZ3RmFVSENFZXZJcllYSHhFR0xtbzVqS0t1YkNi?=
 =?utf-8?B?QWdjSFY3ektDZmJqUjJxTmFGYVZWZVZPUER0SzVpK3lSN25xUzNjZExLT1BG?=
 =?utf-8?B?YWxuRjNaeGZyUG5BYlRDSFlPYlB5cGZiMDFGMGUvajhzbjRqQVNMRzlXNG9F?=
 =?utf-8?B?ZDZRS1VtTzZpUW9saTF2bjBVMGkxYmY4ODh2TWJqOFhKeCthUERMelpudGUz?=
 =?utf-8?B?dUFtUEFnNU5GdnpCMmwwSWxCSFJ5ZkdCazVwVXl6M205ZmE2SlBFWGhBSGtn?=
 =?utf-8?B?SEViOEpUaHRXWlg4cDB0OWtvS3NaQlBldkw4OGdiSFI5eDJUbm1VdWE3VlEz?=
 =?utf-8?B?d3BBQW1OM0hibkpKN0FXemwxT29zc1F0M0hMdjIzUklLSjlETVJSMmhQeTBB?=
 =?utf-8?B?VGZRYU5pMTNCQmg1VmZ4UU9jTm00anFnM05lN1RMZ09XekdXa2dtVTZIaGlq?=
 =?utf-8?B?TmxKaGZ4bVBlTTd0QzVYRVpaQkpaRGx2bHYwUm5yVXpTNU5ObzhGT2t0TVFu?=
 =?utf-8?B?bC9JVzVjWVZjKyt6cC96anpFVlJ5VFVjbmQ5QWJxWm5xWXVIa09DaU1BSkcz?=
 =?utf-8?B?MDNOWVF1L0V3d0xmVXc0ZzcvUXphUmlFRTlCQVlCZjI4bWYrczZoVlg3QXJB?=
 =?utf-8?B?dFo0eGtBQ0k1SjdFYmpXdUs0WkEvcmFVU29qVzgvcUR4LzhGZWxOWmhJamRa?=
 =?utf-8?B?ZlBhRU4rQmtKa0dDVWEyZ25jbnkyZU9ZZGtIcllONVpDN281NGM3U21DKy9r?=
 =?utf-8?B?SHB1UEZJdG9SWHlQUjdaL0dyMDNTTFVOM0Fsemg4dXFicitYVlN6ZmliOU93?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd2bb9b-8806-4153-7550-08de161da4c7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 12:29:30.8991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGmubxyP1OV/RUZ0YYZzepYTY+YeHuIq17jkInOJMXno0pIcBZ7dzM/kdEtsZqgI7WxnlSN1r5ZkgBhPvQa4XBfvPVmM3732C/VQGhQhgIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9386
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 12:29:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20261



On 10/28/25 13:23, Adithya.Balakumar@toshiba-tsip.com wrote:
> Hi Quirin,
> 
>> In my opinion, we should avoid build package from source. These packages
>> will increase our maintenance effort of isar-cip-core.
> 
> Understood, Thanks.
> 
> And thanks for initiating the discussion with Bastian regarding the possibility of backporting the fix to trixie.
> 
> Now if the fix is indeed backported to trixie, in my understanding it would be available through trixie-backports (Apologies if I am mistaken).
> Previously there were concerns about installing backported packages as they receive best-effort updates.

I would try to fix 2024.12.1 in debian trixie.

Quirin>
> Thanks and Regards,
> Adithya Balakumar
> 
> 
> 


