Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5D4C982ED
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 12:54:43 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48062.1789995276243952960
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Sep 2026 05:54:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LVlRDcmS;
 spf=pass (domain: siemens.com, ip: 52.101.65.23, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JL2A8HHUMoz5Z/ZpeCGUhgzECne1ePkt5MMAppkd693VJJF6aoWmMCbKtguusZfY7Xa/QpqkXzG/f9t40m0V9X4mwyA7isMbyR1loyZxp77IZHG7FxW4PdC0TN96R9SeYE6sxxsiLKfIIW9xqLOz9RBJOVlg1dCaB6U6PRK9GdVKFBcIvqIIn/wsb7SHskNhaso5LORJ31n6itwtKJS9acHA9o29T9jRqsWY1ozUPMqubzTnwOrKfIJ+cTtVS60fxzfZbokYQXsbNqoNHQiYobMJZMD3FQbN+4MTG1gRPDm+QtjUIvZgZ5/EuAPdtJg4JmWKvu4TSS57Yj9jbGz4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZOoDgwT8g2utQoMdD/omOZPL6eKswtdrIAoqN7gjQM=;
 b=Y64NTe72NfMAGAMyZ31gQUXbfNjr5y9iQBGWQOCehVTHi/uWj2MoL3yA/zarlI71l8bB/5vsDDHEFq924nsTuqpeKN/ZiQ+E18x7T+TQDqCeVUuhZPRgfiOh1XkcXNrMwWYA2s0ZojPWjI/Zh9KNrtxcq77pdwlFg5tPb0TukTgP3zj18S2bwUQBoCk7wPEKfWfqYZU6wIeUkeA3obTZgDCOgy8ilMzTDW0Q5+QfU5MazkOb/LgmlP0cMRbkjuDdZhEYPIO6/HbcuqRFsEWtXtlamW6Ao+eefPvEhqn06m3wCa0rH+RXLHxTPWMiCtyhLuLuV2j26wqJNiQjbc5B+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZOoDgwT8g2utQoMdD/omOZPL6eKswtdrIAoqN7gjQM=;
 b=LVlRDcmSYIAd82MX0gED5A15LSmz7VRTWxcMAQb9JZykQLeGm7mhvlj/WK0mfQFlh/cEEDRy4XbWSvwr344LuA9/0U0SzH1Vy2nra8pSIVKQM10PmTUjsBuU1RPPYrB06ZN0RyvZGY57azyZ8zbKpYiv97e1fZx775qJXqLwrQHzfetYNfWXike23QfSRUOD01p7TBR4zVaaMZaFFKKX+sMMJSxcZKVo3aBFbk5IbM72BX9f6nSZlnituB7xoxIRBT7eHhK8ZQtlQTbZTSWhLW9+zeb2EBv54Zn+TCbNgNd5dNGsE/FUtJjU1cZ/x0Az3M0eH7mNeumCPXlMQOQVhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7163.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:313::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 12:54:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 12:54:31 +0000
Message-ID: <1e4a54c8-da88-4121-b0a1-62565db51966@siemens.com>
Date: Mon, 21 Sep 2026 14:54:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] scripts: update-linux-cip: Add automatic
 GPG key setup
To: Gourav Singh <gouravsingh@siemens.com>, cip-dev@lists.cip-project.org
References: <20260921123135.2365505-1-gouravsingh@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260921123135.2365505-1-gouravsingh@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 635e469a-3257-4604-a6b6-08df17df7a8b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	HurvT69NUdQN2orh+zgn3rvionusCR5q0AXDwanDVJo8O9sIBWRlsDIJDXAv48kYPfbsZzhp9B52v5pVZ2ORc3IxCKs6gCfUHETTTi2URjhSV7YWngtPBtcsoVHCgQWfGRei/3EkeWrm5xYOGFn/CwOYmAuUoPznPCtm79p9Bi8YlVWeJUo8OV44V1nauG22Av7tedrmuEgMnW0U+K/rJiazHHKbxu8ZbRvWCXp/i0s/m+whZndqPMPMuL1hdQc62mBcNRF+rBiDpCIHJmbyt8/oDMa9Zv5rsoNCEdtURzFfX4bxtSURg9mwue+T6HqFRJ6Rao/V5CGsn4WbuJ93QivdGCHUtSGAXS7SzK+ehqh1ylIuKf8BLoxLxfBeFIF0EjhppA4aAzTS5x8wG2neHLzwo8AgYbzqnLsgU7GpeLfEVi8UpXOoKbrJG0sPUUc+5yWOL4OIUQS4FVdzCFOSY6kzCMSkAeSyZhfcwhpih5ylxkZujUu7VNoJ++KvpLMjXQHGa/ZdMrOUpc9aGAXMHyF5Pr2umIVw1R7EsFnpqjl13JsBLSBzjEWn1FpLDyNjrsJryU1aK8LOiNPM4OsUpzQJmpqi3w9uNjRd6s0ZsIN4bZ/4D0vQNKX6K52ee+3EtP6I4ND8S6Tncc4ViEd0hHsJItwRtNS5oetOnjrpOCs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OVBlWDM0cE4yVGdFUTNsU081aWhYNUp3WkxESEE4ekdOcFNmY1lSL21kMTVM?=
 =?utf-8?B?bVJqMXVIcFpjdlp1d1BuQ0ZMUUlzNTc4alluRWRWZzdPT2VTbDREamI2QU1O?=
 =?utf-8?B?ckdmcjAvVm9VMFNWZTgzUE5vakFhZUpzY2dlb0xWbGV0T1k3SjlxeStPN2E4?=
 =?utf-8?B?R1dKeWFkWFdGRmhUWDRBajVOZEtaeWluM1BGYUt5cWJ6UVRlVTBEYU9KOHk4?=
 =?utf-8?B?Q1B3OEpMYzVaUFFJRjVJZUlRSjhnTUs5eEhjc2JIRFJBY0JldnNKdXhoQXJU?=
 =?utf-8?B?SWxTU25ZUU8xVlpueVlwR21Gd3MwMVM4b2RQYjluWGQ0c2hxZCtsN1ZwMGU4?=
 =?utf-8?B?ZUhQSXBHbERWSlkvQVhpeXdWOW44S0RSUVUzVjBBT1JDakluRTU0bDRPemhC?=
 =?utf-8?B?VzNRdm1UaE95NzVtVUUrTHVha1JLT2NhYy92Rmk4bkt5a1lGaitOMEdiN2I3?=
 =?utf-8?B?Q0NDS0ZTQUJvQUU3cGl1U3JnK05CK0FMN3hHQjE4SjcxeVhwVUVZN1pZQkNC?=
 =?utf-8?B?WDZMVmRKK04wZ3RlTmxhSmQ1L2FodmpFV2M4ekRQU3ArNlIyOG9BeFlwaEVh?=
 =?utf-8?B?T2VCVFJIdUsrVkkrYXZZTVFKWVo4eDdBYTlVNmt6cjhPci9KUDc5czAxd3dV?=
 =?utf-8?B?aU9LbG1UVUsyeVVReCtLZXV2VytSR1AvcjNwZEpiUEZRSXQwM29DazIwVy9j?=
 =?utf-8?B?VVEwMEhDbFlDMFZnL0JxN0gyVHZwU25mQkRHRVpOMUlDUHA1UmdkeXpzSHZ4?=
 =?utf-8?B?S2xCRFg2VVA3RFl4WGZsTjk3MXJZeWdEbVc1MHFoZnM2WW0wQ1NkYVRNUWl1?=
 =?utf-8?B?Z3NtZkRaa2VuSnFMNTBOY0t6ajkyZmFLb3FNVmNXUkxHNk9wNnhIL0JDK3pu?=
 =?utf-8?B?VVU1VklmUkoycmhNYWg2VnlmR0JCWkRiOXhkZFZON2VPQmhmOThTZDVJTmlF?=
 =?utf-8?B?TjdDaEZ0bmlxRVhIakQxK0VZcDAwTmFrcStEV1JxRW9NSm5ValBOTEhpVEJS?=
 =?utf-8?B?N3llOGh4RDJjQ2VqNzduR1BMdGx6RGhna252ZDUyVjFEN1dKYUJ3WEhmUkxI?=
 =?utf-8?B?OE1ZRzRPalhmOFU4QVJ3alg5UzZXQm1TR21pcEVMZFQvRHJEMm1QaGEzUmpV?=
 =?utf-8?B?Tk5GU1V4Wmh0WnNIRlBMUXRDZGNzNkxjT0VlWFdEYnBHL2lyMlV0OFBGNUV2?=
 =?utf-8?B?YWdESVEzMjcyMVV4amFQaVpHZlBidlpOWFJobklvMStIQjNQNUhUNDkwZ1lj?=
 =?utf-8?B?M2Z2QjJFMmdGUVppMUp4KzdnbWtMTVZKUUxzRzhBVWZSczBWYmFrallGRXZj?=
 =?utf-8?B?ZHpOZzA3Mm5jY2wxUVlLNTdCUkJxRE43RXF2Q0t1VkpPU1E4K1dvQ283ZzFX?=
 =?utf-8?B?aHN2T08zbVhYRWpudHU3OC90Um43MmkvdEJrOXZydVRpaXFaaWI2amRMdVho?=
 =?utf-8?B?ZUNCckZBMnhaMEE5OEJWdktJQTZXbEVwK0FaRi9ZMXo1TzhoWkRPK081U2RU?=
 =?utf-8?B?b0FYenMxSGdlek1PV25PU3E0SVZLdzVwYzQ3S3ZGVi9mTC9uL3JIaHRNR2hh?=
 =?utf-8?B?TU1BdEFIV21jajNuVU05N2xMTjdtb0tOeWFUeUpTbUI4SWxSOGVSOWdmNzZO?=
 =?utf-8?B?Wm0vUlA2NFpyNml2UFNFWkNWNVk5blRLU0xnajM3Q1htNlZKMFRTOS8wSzZO?=
 =?utf-8?B?YTVxMVdTVThBT0tBWmp1dnp5dUY0blNiLy9hRi9XQlBaWHVRZWV0V2dkbkk0?=
 =?utf-8?B?L3pwamNkTUtkZVlhaVdBR21HOHVIV3lYajJLUzdZM3BXSnlUUXM5bDArL05Q?=
 =?utf-8?B?SUg2Zjl4ejU5UXYxNE1UcHp6dTMvSDNSMGVjOEZRVFk4cTJQYmwrRmUzNThK?=
 =?utf-8?B?eFRtNTRHODB1SDVvWituMVNDK3E1S2djZi9UY2lDd3lSSG9BM3ZReFZSK25Y?=
 =?utf-8?B?QXlIVDNLRDY5OUxVOEVEaTdnT21kYjNqazRXcHhOUjh0Q00rUmd0eFRCMmVv?=
 =?utf-8?B?Y1BXVUJaOVdFcUlkTFpaNytFSTM5b29YMG1jYUNUZEpPWlZWNWlVdG5QTkFr?=
 =?utf-8?B?MVl5djU3djhQWXZYck9YaFhNL0VSTmJsblBRRFlkTG9lV2tKTU15dFVLc1Zt?=
 =?utf-8?B?b3pxL21wNzRHZHVFT0ltMWhIa214bmlRdFdUYWtZNElHeUVBRERoRDNIMk5p?=
 =?utf-8?B?K2tCVmtINjA2aXhycjZSb1dVT1BuMU9oNXlNWlVuampjcHZFVmJ5SHNNOUpW?=
 =?utf-8?B?a2RaYTVMSFhFSUlqeGFScXp1SWlCbkpuNEJxaHd2aktXZ3NGMWtsMklhb0Nk?=
 =?utf-8?B?Q1JjdGRod29PR3B1S3JiYTk3ejg0Vmhya1ZpeHVOU0xCeER3bDZPZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 635e469a-3257-4604-a6b6-08df17df7a8b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 12:54:31.3929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtHuJNN8lgoeEIsBx3lmAvGW2Mh9ss5W8Q5xnFy72prFhM9beYACBY+wryk+3far2+eMY5d4a1EzZ8Nb0Eg/5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7163
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Sep 2026 12:54:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24259

On 21.09.26 14:31, Gourav Singh wrote:
> - Check if GPG is installed, prompt user to install if missing
> - Automatically import CIP kernel GPG key on first run
> - Skip import on subsequent runs if key already imported
> 
> Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
> ---
>  scripts/update-linux-cip.sh | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/scripts/update-linux-cip.sh b/scripts/update-linux-cip.sh
> index 1de5a41..5ceb7c6 100755
> --- a/scripts/update-linux-cip.sh
> +++ b/scripts/update-linux-cip.sh
> @@ -2,6 +2,31 @@
>  #
>  # SPDX-License-Identifier: MIT
>  #
> +
> +# Setup GPG keys before processing
> +setup_gpg_keys() {
> +    local GPG_KEY_EMAIL="autosigner@kernel.org"
> +
> +    # Check if GPG is installed
> +    if ! command -v gpg &> /dev/null; then
> +        echo "Error: GPG is not installed."
> +        echo "GPG is required to verify the authenticity of kernel sources."
> +        echo ""
> +        echo "Please install GPG and run the script again:"
> +        echo "  sudo apt-get update"
> +        echo "  sudo apt-get install gnupg"
> +        exit 1
> +    fi
> +
> +    # Check if key is already imported
> +    if ! gpg --list-keys "${GPG_KEY_EMAIL}" &>/dev/null; then
> +        echo "Importing GPG key for ${GPG_KEY_EMAIL}..."
> +        gpg --locate-keys "${GPG_KEY_EMAIL}" &>/dev/null
> +    fi
> +}
> +# Setup GPG keys
> +setup_gpg_keys
> +
>  REPO_ROOT=$(git rev-parse --show-toplevel)
>  pushd "${REPO_ROOT}"/recipes-kernel/linux >/dev/null || exit 1
> 
> --
> 2.39.5
> 

Thanks, useful - at least once for everyone :). Applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

