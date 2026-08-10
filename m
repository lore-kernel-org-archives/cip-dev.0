Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF0AC5AD55
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 11:59:15 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.3])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28131.1786363152321483167
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Aug 2026 04:59:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=z1TrF9m+;
 spf=pass (domain: siemens.com, ip: 52.101.72.3, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dANiRB6Vp4FWf4St/H44Gv/6wwd9aiSRxdZFr4RPY+Vv8FXP+JyZ+2k4qLjVsCwjne49PrWdi1O01OotpAmSmbhaHj+5klLH00+FXi5HNYJ6Q2XcWb0rJdUb9IBA9O4HRHcb7C/X8HOKqlCZNpcgrU4MoA2CTiTnHe+ptkd4k75RYZR4WpzuJL6onresvQFqknfoYcE2yTV5vj8n6GkEwfB6ETBvY/RTi7CaOUmV/7Pgbm7n7zr7cTriYomE16jomg846k3S372BEqtb+zsU8htfWQ7P8kU5ZnzBIO2dLOd3S7UqLRqPFlxdAf5+4PrIKJaSMU5xQdpXCBpqtel4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jobFyLZzb4P2d8UjiUYKOYVmNalI3ZYJu5TSCJGAF8Y=;
 b=Mj9M+tLLnpYNuVqD1J8+S6dIpsR3CaqsO/gdZSnqKn3y3F95xWW0eXjuAW8WEcmPFO/1EaQTGdcfY/PtB8RSsvxaclNx5XHtSV71bUKTsqdvtrVjV5s4x4uWnM2grFjuJLR32X1AbNiNP7pXuBCuf28q1vo53mctvgaejezr/YKKE6C9wzkC6uJHwfqgYAiO6RXmA3LdqZpdVbdL2MvAbIgEkmASvIs4qCqPXCa6aLmMjYJbipaBJ+o3bYUcGed20/yGHX611QPpJs0/qoyeYowecsDygbv8kVJ84KCbEytAle4bhCVuei3Pt0Aa6YeI/55AYVUe3074k272lwz0CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jobFyLZzb4P2d8UjiUYKOYVmNalI3ZYJu5TSCJGAF8Y=;
 b=z1TrF9m+1TGwpQqbW4BtGOgl+skvX0E3URBtavQ4l8lHsXC1BVZv6AttFP//lrQyvh7xvsgCiCqxn0WyvG4qG7vmOMmEJylylpU3LqgM0xJ1Dr1a7IOtw9OmY2YGMXq6AOK0YXXylgh7zzzap5s1E8rBJwXU5kAK+Rifu/mvWug+xD6Q0lLP0KcY9Lx2PQ8gWmRYK2WqmFQiFHPu8xgNVI7N9Hc8KU+qLTc42HSh8QVemkCTMDvDL5k+eSHhJX0ZjnbFhHxCDjcs9k8PsYIUZiC+UXJrxSIXO3EqUDU8q39NZpYMlPtrb0Ih80BQXUQJXntI7swgTj0dMbAiAAqoMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7725.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 11:59:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 11:59:09 +0000
Message-ID: <a4b7722d-93a7-41c2-8860-9c045b345d3b@siemens.com>
Date: Mon, 10 Aug 2026 13:59:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip113-rt62,
 4.19.325-cip135, 5.10.263-cip76, 6.1.182-cip59, 6.12.101-cip29
To: Badrikesh Prusty <badrikesh.prusty@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260809085235.525338-1-badrikesh.prusty@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260809085235.525338-1-badrikesh.prusty@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 8027deef-b2dc-4c9f-ad50-08def6d6c916
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|55112099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 
	KXwrUMQJoDl2l4WAxHTzNUBuiLYlBCI7IO3ggHjJ8F76ic6E4gSeX0r24aBiDj+b0xZIzqHJyYE8m1AIwwg8W5fU8YPlFQmDEMQhYob8SaCmzSx/AKk1U1lobIB3ZjJtoydifASKqIYmYii5yTdMxU1MxDDn+72QxaBnX8BxFIb8KeTmCWqIcsl41Q9Ukd94Sle4T9bcImdzLDd6F6K+SxblvIHo0PnqWmyanWT3pseiBugm3xchVmc7NZBwQ+8Oc4ZwNMIdDALEyBN2h/Ef+RIWLRQSPIaFm1Xjc4yQY+WIO7knRUo1Im4jmcporbvPoIWR9vEjqYLDSOan01Ly0V86eC8QQqWAJZLjAT1ECf48g3pfS/blPCaadP2fwIgNDhYi3uGGKAOyCz4bH99H6qIiXqMNaBPZ2ypk9nZeujO2Dd8ZrUmlrViQNraUhxe4jtdlPksNv1d6g3DnDYKiVOqTZ9Kt3wHkPBLIPfvJjcevA4PuCLFC3Ux7md4KvQnNzVRr/j5rs57hST/gouZPM8wgZJ/A9kHE3FPhA7APLHUhEgx8sek8R8a1un0tMWX+DNrUlAgsrmOUANvGjNRaNlvpPlZDiBcZEi+ZavfBmR+EVxDosDmXO/wGR/LdQT3he2UFf8diGxTxLe0qU3P0ZtwFW2rgiQD2YJYLC3yYXbw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(55112099003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Wnh3TTNoZTFPMXNaSWo0QjhwSlFnQXNhQzB0bGFIcnpnaUVVUEtiamx2RURD?=
 =?utf-8?B?RU5Qb3hvWElEQm5jc01PbmRKUUIrWUVjMnBrN0IveStUMFI2dHVwVTJCQ3Bu?=
 =?utf-8?B?YTNlMmRmU0NSSkgycXlIYm5McE1TbkVsbXNrOXMwUVpmcGZQNG40NlZiZ3NK?=
 =?utf-8?B?R0RDTkQ1VVF5b1VYckdrNk1vTWhKb3d2MW9Nc1FMYjFodWVUSUk1ODBLZUFq?=
 =?utf-8?B?YVhsSlpQSnFqbDlKOW04V25IQWFQSEorUzNES1MwSUM4YmZ4TmpTdEZpcGE1?=
 =?utf-8?B?ck5XT3g2RERQVDUwVDZLMGhhTFFaMmFCUlFrY2RGS0ZuVisrQUJRdTdQVzdI?=
 =?utf-8?B?dnBlSlNQSit5OGR1V2VpcU4xVVpVeWNQSVNDNEVRQmVRT0cxWmsrZkdNNnBQ?=
 =?utf-8?B?UzVoaGFaZWNGdi9mbzdEVW5tWXhkb1NwNExGc1RrL0xoSlgrMmMvYVdmK3FD?=
 =?utf-8?B?UEFvaXJ2b1AvMjMweFBRS1hNdFk4VU5xbGcxamtMUVFaNlcxU0p1bFJBVS9D?=
 =?utf-8?B?UXI1ZHpJLzg3bWFvclJVUFJVYzYzUnJkbFJBZGxEeUdlK0lyVkllUmloYlJk?=
 =?utf-8?B?L0E5dGZMUi9nVVMrOEVrYzNSY1dYR0FTQUVhSHlpMHJxaDg4OWRIcUExbm9Z?=
 =?utf-8?B?ZWpTLytsRHpwb2VlQ0RtU1JmaW96NXJ6OGYwanJGaUhaTDI2RXhkem5OdGdR?=
 =?utf-8?B?eDRQUVErU3BuQitHb08ydnIxRlhyNjRSWmlFYVZheGNab3JuNVhJMWY4ZmlJ?=
 =?utf-8?B?alVLUStYS1NycFJuMWE0cjlsYnZ4YVkvY04vVlR2ZTliTjFrdUFlbzdDcHhk?=
 =?utf-8?B?b1pVemlsVERBNjBHTGp0eVNYd2RPNjFUZ0lnSTc3djZXRjFRa2toaTVhOXhT?=
 =?utf-8?B?dHZUTG9lNkYvTlJtMVhzdmJoaWFJbTZ1QUVGd0VFV0hJeklmdEQ0Nm1wcEY0?=
 =?utf-8?B?OWJGRE0yRkZEcVFSVVFQbko5bVdmVFhwSFNJdVk5SWpDV1hhZHk5RldUSm8w?=
 =?utf-8?B?VW9WMFdkNEpGVUsxa3I5Z0trZ1R0RFU1K2laZzVUWFJtS05KYTVNVG9HQVI1?=
 =?utf-8?B?aWJnemVTVjUrNTVpaERsNW1JSFlPcmh6bHM0VFppYStxVm1nZHI5ek15ZzZ3?=
 =?utf-8?B?U0dyYXZnQmFOay9JMmxlaGNpUUczM1R6WGYraG82bm9uUzZLcjZSNFNSM2hO?=
 =?utf-8?B?V2RvMWs4UG5FZlpsZWJ4ZUZyN1p2U1VJUktIQWhGeXF3eU54cm5rRjh4SE11?=
 =?utf-8?B?NGR5QmpNMjF2Mm1vbmFidEVpU2NXNXhWYlI2WURiUkF4N3VqWW5uTzhWY3U2?=
 =?utf-8?B?L0pTRm9MY05sTXlGa3V0aFZKa3BIU1FBYTRnbmQ1Rjh5ZkJoTzVXb3BmdEw1?=
 =?utf-8?B?WFJpNVRINEY5QTRHTUVESTV0MENRMGI3c3djTktlYnhsK3NlZEcrUXBMcHky?=
 =?utf-8?B?dXdiaXVjcFFkb2dlU1p4dHBHcVJMVG5yRXVTdmdTRFpqUDJHL0JzN0Ezd1lj?=
 =?utf-8?B?empwWDhDdUZFNEFuNFBlWTUvQnlUVUp4NlVuVExHTGlsengzNUV0elpKMmtJ?=
 =?utf-8?B?VU9EdzBTSldnbVRITWdHV3NZUjA1L3E4Rkdxbnd4TUhyK1VLUXBxY1FRSkhn?=
 =?utf-8?B?aDA4SEFxWGlDbitlWWRaZjdhR3lyRTNEaUhCRlJ6NzF6c1FYNlpKaHJDTC96?=
 =?utf-8?B?MjFKaGNaTDdCMnpzcE1TWWZtbmZ1Ykl4SGJNRU1sNEo2ZklXNHF0WURSMkN6?=
 =?utf-8?B?ZjU0b1pwclRBckZYdmx4OHdjQmltM2prU21IVUdyZDRPUDRiMnpCNHYwWDdP?=
 =?utf-8?B?bHRFVG8vd245QkVJclVFZldJbVVhTENBS3JnamNJK091NlZjZ3ZDWStlUXJP?=
 =?utf-8?B?blFmRnVNakkzSzVJQzN1TlB1RXNFUTVPZmRvSm9hRG5XTHZnWHdXaHZPVGpY?=
 =?utf-8?B?SzZ4QkVTL3prZTlyOUU2Ui84VVJwai9CNnJCR2Fnb0NzUXVid09pT0g1VXNS?=
 =?utf-8?B?UHJIU3lySnQxQS96dEVZT2N4UVBFdldtb3A0c1JhbHdaSjhtUHFBY1ljVTND?=
 =?utf-8?B?SXluRFFHeGo4cUdjOGxWUjQraUFkZmJiUGhqajRDTVNXbm91MTB1TSt5QWt2?=
 =?utf-8?B?dGU3WndST3VSbU03T2QrM1ZwS2lDMVBpZWpFc2VlbnFFVFRmVmw2cEVJZGpw?=
 =?utf-8?B?MEtmMVZYV1ZZM0tiN2M3dnJDS0FUV2VCVXRsSE5LVFBFSHd4d3FkNlRSTnFT?=
 =?utf-8?B?b1k1TXE0RW5ZLzJTS3lWTE5IYmMwa0ExRzFuanRiTUF2NGphTFBjU09SbVBV?=
 =?utf-8?B?MXIzYTgyRDFmYWVCcEUzcFhjQlZuZGw5QUVORjJlVmh2bkRFZnQ0UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8027deef-b2dc-4c9f-ad50-08def6d6c916
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 11:59:09.2715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7hBjHcnrlVFKK55DIjmWN2A3UIpUPlfqJhZDEWEAUHhPMzSxwk4UeHGbx4ir9BT6mFfgVToccrTk6TAWVizQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7725
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Aug 2026 11:59:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23884

On 09.08.26 10:52, Badrikesh Prusty wrote:
> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> ---
>  ...4.302-cip111-rt61.bb => linux-cip-rt_4.4.302-cip113-rt62.bb} | 2 +-
>  recipes-kernel/linux/linux-cip-rt_6.12.101-cip29.bb             | 1 +
>  recipes-kernel/linux/linux-cip-rt_6.12.95-cip27.bb              | 1 -
>  ...inux-cip_4.19.325-cip134.bb => linux-cip_4.19.325-cip135.bb} | 2 +-
>  ...{linux-cip_5.10.260-cip75.bb => linux-cip_5.10.263-cip76.bb} | 2 +-
>  .../{linux-cip_6.12.95-cip27.bb => linux-cip_6.1.182-cip59.bb}  | 2 +-
>  .../{linux-cip_6.1.177-cip58.bb => linux-cip_6.12.101-cip29.bb} | 2 +-
>  7 files changed, 6 insertions(+), 6 deletions(-)
>  rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip111-rt61.bb => linux-cip-rt_4.4.302-cip113-rt62.bb} (68%)
>  create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.101-cip29.bb
>  delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.95-cip27.bb
>  rename recipes-kernel/linux/{linux-cip_4.19.325-cip134.bb => linux-cip_4.19.325-cip135.bb} (68%)
>  rename recipes-kernel/linux/{linux-cip_5.10.260-cip75.bb => linux-cip_5.10.263-cip76.bb} (68%)
>  rename recipes-kernel/linux/{linux-cip_6.12.95-cip27.bb => linux-cip_6.1.182-cip59.bb} (59%)
>  rename recipes-kernel/linux/{linux-cip_6.1.177-cip58.bb => linux-cip_6.12.101-cip29.bb} (59%)
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip111-rt61.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip113-rt62.bb
> similarity index 68%
> rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip111-rt61.bb
> rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip113-rt62.bb
> index af553fd..039d5d0 100644
> --- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip111-rt61.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip113-rt62.bb
> @@ -11,4 +11,4 @@
>  
>  require linux-cip-release.inc
>  
> -SRC_URI[sha256sum] = "d82994372165c85e4de9bd76b8d785beb9590c0f96404e47de92e917c408193e"
> +SRC_URI[sha256sum] = "1e3e83a7dd31b9043849089e982f95a1158de530c31cb74b32c6362989fe0453"
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.101-cip29.bb b/recipes-kernel/linux/linux-cip-rt_6.12.101-cip29.bb
> new file mode 120000
> index 0000000..82a1b15
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip-rt_6.12.101-cip29.bb
> @@ -0,0 +1 @@
> +linux-cip_6.12.101-cip29.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.95-cip27.bb b/recipes-kernel/linux/linux-cip-rt_6.12.95-cip27.bb
> deleted file mode 120000
> index 4280432..0000000
> --- a/recipes-kernel/linux/linux-cip-rt_6.12.95-cip27.bb
> +++ /dev/null
> @@ -1 +0,0 @@
> -linux-cip_6.12.95-cip27.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip134.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip135.bb
> similarity index 68%
> rename from recipes-kernel/linux/linux-cip_4.19.325-cip134.bb
> rename to recipes-kernel/linux/linux-cip_4.19.325-cip135.bb
> index 0d60731..4ac075e 100644
> --- a/recipes-kernel/linux/linux-cip_4.19.325-cip134.bb
> +++ b/recipes-kernel/linux/linux-cip_4.19.325-cip135.bb
> @@ -11,4 +11,4 @@
>  
>  require linux-cip-release.inc
>  
> -SRC_URI[sha256sum] = "5a5a9570fb597f77229b7fc5ed0926e354cd0ed337bdf07099f53b8d71c31293"
> +SRC_URI[sha256sum] = "6e3e5003854bd28e7f3b4880ab5f779e4e31ac7d4770f2fd1035a9b51c0d53e9"
> diff --git a/recipes-kernel/linux/linux-cip_5.10.260-cip75.bb b/recipes-kernel/linux/linux-cip_5.10.263-cip76.bb
> similarity index 68%
> rename from recipes-kernel/linux/linux-cip_5.10.260-cip75.bb
> rename to recipes-kernel/linux/linux-cip_5.10.263-cip76.bb
> index 45ae236..a5fd834 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.260-cip75.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.263-cip76.bb
> @@ -11,4 +11,4 @@
>  
>  require linux-cip-release.inc
>  
> -SRC_URI[sha256sum] = "8b6200b2820ed0dee04bb3824b797e77e010f586fb3195cc5965b2b8316b6482"
> +SRC_URI[sha256sum] = "bd235da3e82d643c4ef0bc71a6d21a11c6ad1c6e644ff625c72ba74daeeb96eb"
> diff --git a/recipes-kernel/linux/linux-cip_6.12.95-cip27.bb b/recipes-kernel/linux/linux-cip_6.1.182-cip59.bb
> similarity index 59%
> rename from recipes-kernel/linux/linux-cip_6.12.95-cip27.bb
> rename to recipes-kernel/linux/linux-cip_6.1.182-cip59.bb
> index e10e788..28391df 100644
> --- a/recipes-kernel/linux/linux-cip_6.12.95-cip27.bb
> +++ b/recipes-kernel/linux/linux-cip_6.1.182-cip59.bb
> @@ -7,4 +7,4 @@
>  
>  require linux-cip-release.inc
>  
> -SRC_URI[sha256sum] = "4b396f0d3505a3c119e16cc67d53f9c71d9da652b07ffe96a9c150c80aad783e"
> +SRC_URI[sha256sum] = "d69fded945b0e9e905e3301918802ffbade6d8f3342c571accfe12a066370005"
> diff --git a/recipes-kernel/linux/linux-cip_6.1.177-cip58.bb b/recipes-kernel/linux/linux-cip_6.12.101-cip29.bb
> similarity index 59%
> rename from recipes-kernel/linux/linux-cip_6.1.177-cip58.bb
> rename to recipes-kernel/linux/linux-cip_6.12.101-cip29.bb
> index 3e1da8f..29268b0 100644
> --- a/recipes-kernel/linux/linux-cip_6.1.177-cip58.bb
> +++ b/recipes-kernel/linux/linux-cip_6.12.101-cip29.bb
> @@ -7,4 +7,4 @@
>  
>  require linux-cip-release.inc
>  
> -SRC_URI[sha256sum] = "6b22d939962adfe33a036016ea93089e4982d931c711109b1b1268ec2a59e03a"
> +SRC_URI[sha256sum] = "b4f48eb4a0212bb308ac9e01f090c19ca3798281548d8778c4c9df80c18b7bed"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

