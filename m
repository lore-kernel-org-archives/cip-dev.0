Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712B8C19F32
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 07:14:27 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.51])
 by mx.groups.io with SMTP id smtpd.web11.5656.1741331665113583105
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Mar 2025 23:14:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=p4s0Z4MU;
 spf=pass (domain: siemens.com, ip: 52.101.66.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgtnBdGE1W1msrEfi+cBPSqJ9XAR8ov+V4jnfhyPF9NkB+2+lUy54HdsfbROnc0SIZ6hEWOq0JLfXxdZUzdD68Wh3+k2tEdmOrGkMgvL/2Pph9YI258rpTBsn7XNEJyrRM+7J18vWZc3CLieATvsyAdDpFq94zoF262/5HlnueawbupUsGeAu4FZI4DR/gCyWA6CY2Jy26FmUyBcDxvO1XZW68ZZvCrNBOs0siBZk8B7vk7lDCvDevrywmvDcybIjdYclfdkJDW7r2FsFGxziYOT+95JQiKq2+CRLUFVBfqKUO9d12u8AP2w4hKdpjoXfPUCRHLfCeh6pcq18TL8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prXwDWJ+pXtfTTdsYrZ1v6OfAIaoqB3cGSWqIR2d9pg=;
 b=nQqlbqFDCUFuzzrVXyddC40U8GTHto3E8fYoHVmbn2dFcRzDwn0OAXt940gQYJCVhSKHpV16SVdVGMD/IBjHV9DaShrwVl77l0mYlKsKZm8tiTtAuoS23k1ACKl4aFoStCaeO/E6u8WeA7JyHBdqf31kpXCsMy3BvLD8ynsDFNV7l+8fHqENIG0L+yvdbB5YmeaA9u83nu+M2I1F8VGDCY2OxbQF/YO+Nwn54S7SzA6XktCKaB4Ab83majk1+tTUupzEGaLSF8ruNRCEaDVnaTIwdhK6ONEOvLmNcm85yFOuFWBpk9lZB5/goE4HubDLTYN7nrItB/LuPBp+MtBUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prXwDWJ+pXtfTTdsYrZ1v6OfAIaoqB3cGSWqIR2d9pg=;
 b=p4s0Z4MUnMQJoBnzBobnnxxUDZQtogdT6Ujue0hFCEINoowuj/URJBEcUbxxXTLDD2jfKC3JLo7KM04OodIIZq2KbGv7ZehTWQuIMOmjSGOKSJZnAUY40wBW7YiiYbZ5Xr+iRK0S66EJ5jwKlnzXDeSQS999E1I/gX/zwRr/nOW0aJM8cIXsDIgUiyCzWZG4C90BVMebsZksFlCuxWlZDADCCnT8AWEQg90akcEjtun5RzEyx15dhdvGz/6aHURdqGIFvU6DubAh3rf3NgsR9+OQ24b1MoyIfFv8rz7pRICW9xD1vtyiRXiyOXJcq5EEkIJemsE/MNDOw9a3DcrmwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8148.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:678::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 07:14:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 07:14:22 +0000
Message-ID: <45a5b4b1-6957-496a-a100-03850a72150e@siemens.com>
Date: Fri, 7 Mar 2025 08:14:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] scripts: Add automated recipe updates
 for LTP
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 cip-dev@lists.cip-project.org
References: <1741312315-25979-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1741312315-25979-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a9c3fb-aca4-4e7a-1993-08dd5d47af7d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TU1YOExMUVNGU2h4Mm1ERzZyTWlQNG5LUVJuZXIxSEJFYnNacExaZTZSNXRi?=
 =?utf-8?B?OG1OcWdSWjJKZnJadHlrQXRDZmpGV2pyZEt4OWpJNEdWaFdjeTRlVy9PekxX?=
 =?utf-8?B?WjUxTkhOZ3JaTENabXBLeUNIaWJjcTJtcEUwalNEYTBQR1hFdlFodVdFWmI3?=
 =?utf-8?B?cmdNVE1DSVpMNTNVT3IwOGFBRE1tZ1BzU2pIdURtNzlObTFYSUgwWlZMblVv?=
 =?utf-8?B?bFFFVWdXWVlscm1VSUI3NWNFd2dSalNPa0UzelltSGdyejJDSHJXWVBtWnMr?=
 =?utf-8?B?VDhqS29NVTNhYldua1pHNHdGSDR6MmFOem5zaXdLbldyN3lJUjFlbW00KzBY?=
 =?utf-8?B?eW5QaEpVRVJlQ09KSWg3YnRCRXEwR2dhZWpQS3pMWjhTK1oyRlZmOVhLTktv?=
 =?utf-8?B?dUhaU0pXVW1LTFIrT0ZGOFlzaWdqcGwrSGl1YXNBa29ybEJwWk1saytSaGQy?=
 =?utf-8?B?Mlg1YitKOW9GSFZ3QnU1bUlDUDYzREEyZnJJNm9taExMNmkwMDZlOXN4QUE0?=
 =?utf-8?B?aTdTWmp0Z2FLRWZGMmV4NzlDODdQenptMUV2aitXQnd6dnRLQWlmOVBmV1lX?=
 =?utf-8?B?T0NYL0VrVWF0SHlKV3R6NG1VaXRkVFVWUXpxd0kwc0FHc2dNblpjQ0JGVWJB?=
 =?utf-8?B?T0luT0c0ckhFM1dlYnptVGVXbUlsOU5nS00zRCtqRUl6a2xzR1lTRG5ncUEr?=
 =?utf-8?B?V3NyTzRUenF4a0kyVTc2KzY1Wm9wSVpSMUlyazhrZk5IZkJ2UkxLeTVZS2cz?=
 =?utf-8?B?dzVXWVBZVjBPcGMwUlNaZ0ZabjRhSWduS2RnamZ2Wk5TK3VlN09MdjFFQllR?=
 =?utf-8?B?QXZETG5XZmdOMVRxd0lhMTY0dVhYZUN2dTlZTENZTFp6K3pReWh1RWxZT1BL?=
 =?utf-8?B?ZFBqT2N2ZnNhaHN0Q0N3ejI2RlV3R2l4aThWMXdmdTViTExXdTdBWlRTamw2?=
 =?utf-8?B?OEg1VUhIclRYQm45MEd0aW5EU3V3QkZ2Wjl6UExOVE43TmhBb2ZSSW9kMTRZ?=
 =?utf-8?B?RFVUbVY1R2krcjZFSzhmUmpKdHpaSkFLWTdOU2JBM09sTnlLNzhZYlVoT1Bk?=
 =?utf-8?B?dkUxYXZvMVRCckhaREROR1h6blhUM2NUUDVRQ2VLT1B6V2lXdzlwYjEyUkRI?=
 =?utf-8?B?Z3VDcHROZW8wYmpzUGdHc0NzUVIyOTdGbHNBOGhvY2MwTUNxeHFJSmVMdnFv?=
 =?utf-8?B?bFJrZTdpWUFkVzJuWXgwL21LUVl6M3dNb09LSVR2WGdrMDY0UXBkYzR2MzMy?=
 =?utf-8?B?NU1zcFFrVEdXTU9KQnlBSlRBaGd2b3FBYXZwSGROblFkY0tiUmtMOE5jQVdV?=
 =?utf-8?B?dzJ2YU12aHZoRVg2c1p6c0pmbTVDdm1nazFYNHZDTDlBdy9IMEtkYmV6NkpR?=
 =?utf-8?B?bVV5SzRMSFVYc1Q5dzNva25NVDlMemhpSHJ2cHl2djE3anhpemxqVlhmTUhI?=
 =?utf-8?B?SWJkN2oxaGRvVHh4dnRKdHRxUUZiRklEVjhJcGRNWkFBUm1NQmVJYWtjZ2JL?=
 =?utf-8?B?TFdrT2dXRXNBbksySitIUTBBdFdRQXgvUlVvWWNtVFpNbU55OHNWRVN1ZFAv?=
 =?utf-8?B?YjlFeTFwNWprbWw2dEp5dnJVZHl1UzBIYWxEWnZOUVhkOTlYYTNUdjdGMFo1?=
 =?utf-8?B?dzVndkJBY0hWSG9aUjRRYTg4WGsvRjNseXQzK2o0Z1A0R2NjaXVTM0dsQ1Rj?=
 =?utf-8?B?dUsvWm1UQUJHQjJPQ2xlRHVGcnRnb2Fnb2cyR2wzU3k5Y0VVdjdQeFVpRGhH?=
 =?utf-8?B?VUZJTGF1NnVmWGFncmE0Q0NiNWlHejY2Ulpzdm94UEtiSmtQWldsQjd0UXNL?=
 =?utf-8?B?QVc2OEVCQkhGS0xyZTUzbGZhRkJyQk45Qlh3aTRGTWpMWXBPU2hIY3dEUkRL?=
 =?utf-8?B?NnBTdkFUeFI3NzFTRlQ2UEtFbXgvRzBIdzRsR1hTekZtU2c9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SGlSd1ZiUlJ6b0RmeTZDZ3kvUFJLdUpkaU9uNkJRZUNGU0U1ei95MGIxaWU3?=
 =?utf-8?B?a0xaVVNiQkRxV2RRMklPSlVqNS9hSFkxVTcyZVU3dkdYWk5EYW4xYWZGSmlC?=
 =?utf-8?B?Q3IxSVNYZlJtT0Fxajk0QWkxcHkzR1hKZ2JvNUdxcnJoRHQ2VWtLYkhRTDVL?=
 =?utf-8?B?czYvVmszZnc0VC91TDZ0YTdYUW1LQnFKYURjbHVlKzhHNngvc1Q3enFLT1k3?=
 =?utf-8?B?aWpCZnN2Z0tNTkFXRE51M1BzYWJFSUNBSXB4UmhGbFo0T1dVQnVOL0xBQTVh?=
 =?utf-8?B?OU1ZVFNETmV0NGpidm12cjhNcXpGQy9WVnV4azQ5NUZWQkF6UVp0Q1pJZnlQ?=
 =?utf-8?B?TExtNUE3cWZKcVViWGZ1WEtrbHZFbFJHd1RmYUR3V0RiV0JKZG14ZjJHNXAz?=
 =?utf-8?B?VW5lN2ZrRGZGVDRULzNQV25VUWpYNWk3eWhOMStQbXo2VzVmNzBPTjNBTWRl?=
 =?utf-8?B?N0VvQjhxN3ZSUWZxZEZ5dW5jTnhMbVl1akkzRXdxMXNhZWQyR3ZMWUErUjhN?=
 =?utf-8?B?T1A0ZDQrN2dxallla2F0NzdwRE93MVhXc2hRTXRRcEFpZVFCYU1aN1RlZURQ?=
 =?utf-8?B?Z0RldzRUQkV4YmVFd0V0cThhYTBWS3JBdi9nZ1RxcnR3MjdpSjdMTVVSNnhN?=
 =?utf-8?B?VzZ1NGU4T3JiU0dFZC9IdWg3RmloeGROcGtaUVVuQ0JSZHZrSFFKRnNXUyt2?=
 =?utf-8?B?cWhZV2dkc3hQY3pXSlp2d0NJTHJoNDQxQUlBVGU4RzdFbEFLY0QwYVliWjFP?=
 =?utf-8?B?cXBtV3JZS0wyY24wanRUbVhPSCs3Skg3L2RKNS9DUUI5OThwYVVSVE5DQWM2?=
 =?utf-8?B?OWp4TzFMR1BCMVFjK2ZpamZDYkIvcUhXcmpzbGRQajNUTTJ6RUtpaW1IQm5Z?=
 =?utf-8?B?eEtjRUFIK081U1hSY2tQb2FHalNyTDVGZGJHWGNkOE9BWWxIZUkyWklmT3NS?=
 =?utf-8?B?RWtxTkp4SktSMUN1cCszVnU1MXdEUkJmUjBrZ014d1VOTmFIUW9RclpDenpM?=
 =?utf-8?B?ZkFUT3VhU292dWR1TzEyVHUvcDk0Y01UbHBqQldkTGphVGozQmMwY3R6QUUz?=
 =?utf-8?B?TmFteDFIOGtMNWxub25YOUU0M1dkbnZka3hMaFRocjB3Vlh0d0VhZElGVnlt?=
 =?utf-8?B?TDFBTHBiOHlIZWpyclpXWXdGSXBoNjMyWWZ2MFdjSGtZcWpkRjF0RWJMQ2hJ?=
 =?utf-8?B?eE53SEk3My9sZXFpNDgwdklzL3owcmZHSjl3bEFlQ0NoalJScmUwaEZ2UmNl?=
 =?utf-8?B?ZHVBbnltbWJIamZYUkFFOUpOODVHRUQ2NUMwdWxLRGZZdGJya29veEIwbmNw?=
 =?utf-8?B?SDgwYVJFY2huMUx2R1JNME00Vnh5b00rbTJSdEF6cEFUU2cvUzFNNUFaRWFD?=
 =?utf-8?B?dG5xQkxrNWh5eTRmV2NMTGh0a1doM0ZwMktXWEVicUg0dUxaWXlmVG9jZ3ZE?=
 =?utf-8?B?VmlSUC9GTm1UdVhhZlY5dlRiV0NVczJWQWEvM0lqeUk5VjdlcnFvVHZrQysx?=
 =?utf-8?B?dU44Y1FuV0E2QzU0SC9tanVXS3FxMEl0eVIvRlN6b3JIcnVFMGtPa1lKMTMr?=
 =?utf-8?B?Q3prclQzR2c4TmNuWTNCMHY4SXFlM0JPOVFKbjhrRGw0MHpsN1hsTVlWUWlH?=
 =?utf-8?B?bUVUc3BlTmtGM3ZmZGNURHJnK3NBa2FtSFhPMURkNG0zanV2VlZxaTd6NFFx?=
 =?utf-8?B?YlpBRkl2TjczcW5MaGFMRTB1UXR3aThzWC80MmVua3ZpWC9LRVNGdFp4aldo?=
 =?utf-8?B?YzZ6UXRLbXJPVVFKQjRlY3B2c1RtOFc5STh4WU1Za0tYZGNlbUV4akVQUks4?=
 =?utf-8?B?N3hSTGl4RW85NEk1Qis1bGcvRXFQYU12c3hpSDZER2YrRFNWVU5RZkhZTDZF?=
 =?utf-8?B?QzNzaU96OFBxTXdReEFlMnVVY1hoZ2EvT05VeTFiUmFIbUFIaDlFUEYyTFor?=
 =?utf-8?B?dTYvMHAxTmhCUnZsMDhnS2VWR3dtYmpqbVo3TlNnSk1WNkR1ZnBYZGJZTXVF?=
 =?utf-8?B?NDRHSVl3aVA4a2VvaU9HR2h0SFpidEJmaG5ncDBma0JVYjJVQkJGeXRMRkpH?=
 =?utf-8?B?MittSjFsZFhRZlVZeXAvQ0dYMVFaLzRtTklYc0tJWXlVMFNOTmJDaFZOS3Bq?=
 =?utf-8?Q?9jfR6FpeLeu8fm0Jp5SgOjxRB?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a9c3fb-aca4-4e7a-1993-08dd5d47af7d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 07:14:22.6138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZjLuF+41QlsWenltUKovB3QiiLuyOJZjtt4Ae2oXW57Da4pLJYaJg1neOghMEh9TkfXXSl67mOb5wJ7IKKk1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8148
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Mar 2025 07:14:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18067

On 07.03.25 02:51, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> 
> ---
> 
> v2:
>   - Update with shellcheck
> 
>  scripts/update-ltp.sh | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100755 scripts/update-ltp.sh
> 
> diff --git a/scripts/update-ltp.sh b/scripts/update-ltp.sh
> new file mode 100755
> index 0000000..dc8b947
> --- /dev/null
> +++ b/scripts/update-ltp.sh
> @@ -0,0 +1,29 @@
> +#!/bin/bash
> +
> +REPO_ROOT=$(git rev-parse --show-toplevel)
> +pushd "${REPO_ROOT}"/recipes-core/ltp > /dev/null || exit
> +
> +LATEST_VER=$(git ls-remote --refs --tags  https://github.com/linux-test-project/ltp.git | \
> +	cut --delimiter='/' --fields=3 | \
> +	sort --version-sort | tail --lines=1)
> +
> +SHA256FILE="ltp-full-${LATEST_VER}.tar.xz.sha256"
> +rm -rf "${SHA256FILE}"
> +
> +wget -q "https://github.com/linux-test-project/ltp/releases/download/${LATEST_VER}/${SHA256FILE}"
> +
> +SHA256SUM=$(cut -f 1 -d " " "${SHA256FILE}")
> +RECIPE="ltp-full_${LATEST_VER}.bb"
> +
> +if [ ! -f "${RECIPE}" ]; then
> +	git mv ltp-full*.bb "${RECIPE}"
> +
> +	sed -i 's/\(SRC_URI\[sha256sum\] = "\).*/\1'"${SHA256SUM}"'"'/ "${RECIPE}"
> +	git add "${RECIPE}"
> +
> +	git commit -asm "recipes-core: ltp: Update to ${LATEST_VER}"
> +fi
> +
> +rm -rf "${SHA256FILE}"
> +
> +popd > /dev/null || exit

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

