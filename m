From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 27 Nov 2017 17:08:16 +0100
Subject: [cip-dev] [PATCH] wireless: change cfg80211 regulatory domain
 info as debug messages
In-Reply-To: <20171127154644.4503-1-mosipov@ilbers.de>
References: <20171127154644.4503-1-mosipov@ilbers.de>
Message-ID: <6994977a-8d6f-e284-c5e8-61a04c094af5@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This is not your patch, is it? Then you are missing the From: line to
preserve the original authorship. Otherwise...

On 2017-11-27 16:46, Maxim Yu. Osipov wrote:
> commit 94c4fd641e1bc438092f0214bb5ec77ea73b13cf upstream.
> 
> cfg80211 module prints a lot of messages like below. Actually printing
> once is acceptable but sometimes it will print again and again, it looks
> very annoying. It is better to change these detail messages to debugging
> only.
> 
> cfg80211: World regulatory domain updated:
> cfg80211:  DFS Master region: unset
> cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp), (dfs_cac_time)
> cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (N/A, 2000 mBm), (N/A)
> cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (N/A, 2000 mBm), (N/A)
> cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (N/A, 2000 mBm), (N/A)
> cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (N/A)
> cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (0 s)
> cfg80211:   (5490000 KHz - 5730000 KHz @ 160000 KHz), (N/A, 2000 mBm), (0 s)
> cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz), (N/A, 2000 mBm), (N/A)
> cfg80211:   (57240000 KHz - 63720000 KHz @ 2160000 KHz), (N/A, 0 mBm), (N/A)
> 
> The changes in this patch is to replace pr_info with pr_debug in function
> print_rd_rules and print_regdomain_info
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

...your signed-off would be missing as first entry.

Jan
-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
