Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185ACC35FF3
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 05:39:57 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.56])
 by mx.groups.io with SMTP id smtpd.web11.45481.1742189992764349395
 for <cip-dev@lists.cip-project.org>;
 Sun, 16 Mar 2025 22:39:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YCdHMs4T;
 spf=pass (domain: siemens.com, ip: 40.107.22.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5+tnstFsxneqjtdhxFulZe2Z2E42OCltQm1GryHPazksVylIlijl+ce4Lyy+Fm3qn3NFzA9Uy/WFB0AuHZ3YqxYpmzrGsteM4lv+i3DNcNo1yJcg7uD2Ky0/d380GW3yrmm4X9gBjIylFBJCN+s6xsCnDTtFXs2R8kKWYm2eS/0uasMoa3jBVcsEpPVnKIDqRBihHsVb9rW6mFKpwtar5xkLPlgTaIeIWWXkakhUeL3QGzg4EmnYbGN6yUcZKAXHo9czE7cmV+1B8JAndl4d3qpJgA/o2eLtgK3rJsDVJtE548Vv2iwoEHd1V6dqWnS40nZK7/tfhXt90oBZ9VyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95mMe8mjohF3IQ2q7CNiQiMUPIkY9JGvnwxZOAo2yLg=;
 b=J6pBXBaWEp/WNy2igwPNl+sK4diBidX2kjXmQo6k0go6S7N/s1VBOug0j7S0kCiRDG59DRHGuujuXXrAJDi3kr3r9Cdec62X78L7jajqV3hC5Snsyv2i5VEgJ3ms62vN+IB1mG8MY6cZJeUGn86eiuxKtDVH2lY78KORYT0hXX2DnVOn1LN7T0u1oizAeBC1BGCbb2sl+NsSmkrUFlKzjKkJxoQDA1Dn4NXYegpMD4wDHD94zK+dxcNxpThxyTl1gBd3R33QkhuwKkmRKlWqrD9frPkpuE8leULvjiaa2/MBK/mmO8vW2oMWRFVHSBQ7tWqbguRmM2lNXuyYVOqfHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95mMe8mjohF3IQ2q7CNiQiMUPIkY9JGvnwxZOAo2yLg=;
 b=YCdHMs4TybExrBOa6YpzQrcOFuEe2F3pZ5d3sFl0TGi8iH8VBo6sno3OabTtFoYoyQHpn2/FaQbfgp0WGSS2c5Zu8h388QapyF80wmBZOsiEFxSYaSrpZXuGe6WfeNtHbw1IfQ2ClpFkeU2G9yUxkzJK+Zcb93Gm4ER6eQo8NxlhR8bH3ip2BaWPD7xyt3t4e5VBxaPc9OD6guQwWhs/eSCM9xaDyCDGdLWICi3J52BiCfO0GfjPxfDRDaGktdxCcS2KBeSo5jg3o3rWSvAeK+lltvO4lDu03ySDQJrHHbAoqwB4wOkiO8wHSxhAa5ZIMUAiYEWyMMsBS1DgywVdSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8060.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:114::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 05:39:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 05:39:49 +0000
Message-ID: <4e2e5aed-75a0-4dc6-9034-85385af51973@siemens.com>
Date: Mon, 17 Mar 2025 06:39:48 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Drop unused preferences.bbb.conf
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe79e97-bf47-4397-a9ab-08dd65162202
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cGNXT0VNUUFGQjZVYVg4V0RpaDBxQXRrNmF2blV3Q0FNMDNjTE1TUmxpaGQ3?=
 =?utf-8?B?T0ZQYW9IR1ExTkNSTTd2VXA1UXc2c1ZpRHVVVkpvMnBzRjZNRUVUV0hZL2Fa?=
 =?utf-8?B?WHFUVTl5d0h6enh1SS9MeGg0R2ZnVFFnN1hwdXBGVlNxRkE5M0ZNa2FJTzlE?=
 =?utf-8?B?c3dWRGd4eXJmSFlnbWpqbCtJMU9JL0k1Vkx1MGlqRmljRlpzRUM4bUJzR1dL?=
 =?utf-8?B?blpxZ3hydUR2bmRpbndPd0FPcitDRE9ueDhXVU5RMk4yQ1REQjBqUHlpT2RQ?=
 =?utf-8?B?Ukl0VHlqRHQxMWxFa1FBV1ZUTXk0RFZheFRtQlNjQ0JSeHhLTzQrT2N3bHBs?=
 =?utf-8?B?QXByMndHM05xOWFOdUFNaSs5cUtIZEpUSTVrNGJSMHYyYjhUWHJUZnFlbm13?=
 =?utf-8?B?cnF3anR6SGNoZDJ1eGZBWmRmeFV6NG0zbGxlUVA4MjZ4VXZ2d1plUnNsN2N6?=
 =?utf-8?B?MGd5UXlScEVwMVRpSjhrT1VyV0VZR0J1SnAwMVhOY2pFaWZ1dmpGaWlJeUdr?=
 =?utf-8?B?dlpvWG0wZTVrVXpBaVpGVHM4Z2lsM3lzNFh1bWVNRVJ4aU8vV1NSam5HS2pH?=
 =?utf-8?B?Q003d3RHNjlMYnRlTituR3V5WVRsSS9Hd1E1a3lqZ09nSW9QY09XUnZiclJs?=
 =?utf-8?B?cVg0US9CT3RKZjBBeUtyeXI1RHVsZ2lZVDZMRjhqRi9pNEp3YThFazhtT3FM?=
 =?utf-8?B?Ni9yanJIUnRIeS9vMkt5bFN2K3NZR2ZjeW54MGVabU04d1FGQ0NzRVBPWHdm?=
 =?utf-8?B?cmxUWDZqWWdzK2xuclRyMHlqLzBmUEIrak83cmxiSzYwb0tTN05ISXBxSUxP?=
 =?utf-8?B?N1ZkT0IzWXcyVHBtSVJTREJ5aU1ySWEzZTV3S3JaZnZXOG52UVJxZ0NZeUFJ?=
 =?utf-8?B?bUwwTDUwd2xsZitKZ2QwWlM1Q0FTWGZhVzd6OS9qRzk0L3lvNitXYkpWYUlx?=
 =?utf-8?B?YkhDSkl5K1I4dVE2V1o5b0gvMVIxcElGQi9HR2FsOE5jNit6UFdib1JSeEFt?=
 =?utf-8?B?S2w5OGoxT1I0YTFxajhGWU1XYlZDemhWUXBoeGdvZnc4ZmJLellzQWNsQ1dQ?=
 =?utf-8?B?RmNza010YU0ycW1nYmY0T0w4RnhVMG16UXA1ZUxoVDd1OHIvUm54dm91K0FZ?=
 =?utf-8?B?U2dMT0FibkxKRDhPV0ozU24wRThkNklZNnlKcm9uaElRUDlKY2ZUdE9nL2ts?=
 =?utf-8?B?OXhTeTM3bDVBY1hjT1dPRWdvKzUwTGJoNXFYTE5sU3FNSEJVdVB4TzNlUDAx?=
 =?utf-8?B?b3JRS3hNOXhZbFk1OGRrSmhxbkFySTl1MWFlalplR2pBUThqR3E3RzA2eDEv?=
 =?utf-8?B?ek1seThEVWpoYUFORkgyRXBGalNXT2JlMkFVaFB4Q2pqZkEreTJablpkck9m?=
 =?utf-8?B?cGp4c2thZFJ4QzFRWm1IUm9UWVhPN1djT253TExUK0R2TWsxNUpObkRVVlFv?=
 =?utf-8?B?VkhYOW5sbEVUQXU2TXRDYm9nc3RaU3Y2WGlYVlVHbXBvM2pvVDRiNU5PSllT?=
 =?utf-8?B?bk05aEpSUjNkMm9vMkVCSXRscy9KRkV2eThQVGRmd1I5TjV0cXhXVCswQmZF?=
 =?utf-8?B?VDRXSjFEQ3dKZUNIMW1nZml1enJkUVJiZWRmMG1EaFo1ZG5Rb0R4Q2JKSTA5?=
 =?utf-8?B?cHRFNG42NllvREdyZktJNGNyamZrNDNXQ25tWEdma3p5WlcyUXJtcmR1SEtu?=
 =?utf-8?B?bXY2QzZZeThaWlNZcUI4aGVzSG1mZGxIaWZnZE91R1RBRHFGeE9FaDFndnU2?=
 =?utf-8?B?ZzBDM21NMjRGRzQyeVFabktKdGlMRWswSzczTUVmck5aay96aXJXRXRvUW5v?=
 =?utf-8?B?NVNMQ0Zoa1VybkV6VjlFbEJWT1FabGdmMDRQM2tYZmVLOFNvTjNqTmJMOUVV?=
 =?utf-8?Q?xnzsB8XoDwd8B?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T00yRUZjQjlWeEZvRzlMV2xjdkZmNTBYQ3lZS2NXYmExZEVpdEh4alpZOThh?=
 =?utf-8?B?VlNLU1JpdWlVa0F5WEpseU14djBubVM4ZHZtRFpDU3VNaTlxWXM3QWlRMFdu?=
 =?utf-8?B?WTdYYTZEZ3hya0NidThhM3FWREMzNE1qU1lIcm5RVUE1YWJOZmMxNml5UjVo?=
 =?utf-8?B?djF6WGhWUmhjTUx2T2pRc09WUTVQeTEvcVltUmUwa24rYkJueWpqaUNaOHo2?=
 =?utf-8?B?QkZONTZoVmhCZ3k2aER5Zy80KzdhMFAvb3BMMlBXWmpIU2dnZ0dUWnJUMmVt?=
 =?utf-8?B?STBVaDlyazI3TnBQbmEzWG1LOUtFY2NUVi9nNmRaY0FTTjV4bzlxNEo0bnVP?=
 =?utf-8?B?OHY5TDNTVVN6aHR5OW1neXJKQ3RjaXFQamRiUjNMWUVhWnBjblBrczdlKzN2?=
 =?utf-8?B?OUx0dmcrb2tZQzhzMCtTbW5sNmJ4alc3dUhYak9icjNaV2tXdXIwMXdOTHhC?=
 =?utf-8?B?Y2pSQ0RuenlWejZUUmtJbWIyaDZ1TDdsbk1LUk9RRGk3WnNnblhNVldBeTlK?=
 =?utf-8?B?VElINEh1V3NtUER4VzJTbXhkVkVjOHZ6WktTeSttU3p1cmwvd1lveEhMellH?=
 =?utf-8?B?bXpLTGJCQzFMU1QzSkF6ckN3NFFpY0xrVFlHWWZKQlM3cWlHZXNhSkhIckVK?=
 =?utf-8?B?L2xrTHVsRXMvaUptNlJzREE4T3JPcEZDc0NSeHFOOHlDR3V3dkNqcDZRUHBU?=
 =?utf-8?B?US96NllGRHJQZjVhWVdyU0JPT0FSZFpyL0RESWo0ZklqUjJBcHFiQWFKZEJV?=
 =?utf-8?B?MWVWRURJZzd6eUpwNFNtV0NaM3ZEWElRdW9HOUF3TDY0Z0lTeEYzNjYzTVZK?=
 =?utf-8?B?UmpIVUY0blpkbk9TVWdpNTRhWUo1SkZuMjlOUW8vQ2g5cjBPd2ExdWtYVzdV?=
 =?utf-8?B?UjRQNUUzYjVoZTYyNFNQNWpLQ0c0bjkvV2JjajhSY2lHbitoM1pzMlkxTlhK?=
 =?utf-8?B?NXFGck5XbnpUODgvcjZyWmpsRGpRcjNrd1hJckEvMG8yQkNwMWZHa0pTdTBz?=
 =?utf-8?B?c0hLcTV1OU9FcW5FMzRxWWpmSmRyNW04Q2FXQWRocFlIMktkWUJsWkdvVTE1?=
 =?utf-8?B?TVlpZVhBL3grZEkzRzJyWFhhWmswZ2xiNm1JcUVSSFJScXZVRTFXMmUyY1Ri?=
 =?utf-8?B?NEpGL216WG9FdEtoYWJuMktoTEJxWWFrK1ZuT1NBa0tjVkZyYzVNVmhUWFJF?=
 =?utf-8?B?UEVrbFNuRG1GMHBoZUtQV0tJeTM4azhyTUM2ZTZhb0MwZnpDbXg0K2VTOCtr?=
 =?utf-8?B?NFBscTRwZ0lwczBGeVNyOGFrR2FaYzlSa1VEYkVlUDFhK05Cb2JXZTV3VS9l?=
 =?utf-8?B?MnFPZ1d0ZUFtUjllbkpyckoycmZlRkg3SitXY3Y4R0xTNmtFR0lXb0pFcXFl?=
 =?utf-8?B?bHBUeVVFYUFuOGFBN3JMR0VNTWw4SVBNdVFINHdXVHlTVnhJQUpuRnZqbDRz?=
 =?utf-8?B?OHh0eU9icVBJS1JzbE1ZaGUxVDlvSEpNc0IyWERIcC9MRmFGb0MzT3QrNHEw?=
 =?utf-8?B?WGFuTVVsL2k4NlAwQzRSV2Z0c0lYcGtKS2ZHVXVqTDFQb3dmdjdReTFwbTNL?=
 =?utf-8?B?UG1ydzloM0Z5NUVPb09VUzhKNjBja2xQRG9sd0hQeWhtNjZabFBuejVSdkVt?=
 =?utf-8?B?WFI2RW1pMFhxQ2R5RG1MMERHRitUelFJYUNOcDlndFhzVkpoUjB2Q3F0N0xL?=
 =?utf-8?B?b3kxQit4OWhrZUVNdks3cFVtQnRGaU5nVDVuWmloZENFaERPZEwwNzZKMmpk?=
 =?utf-8?B?ZlYyZlh0NFYyU2hCejVvTDB1aFV5Z1o1akpFTFZvN1NEcDQ3MWNheGtvSFlO?=
 =?utf-8?B?WDlubTM1Z3BPV0R1NXNmV1R5dUJlVmJEelZvRG1zMk8ybFJZSitMRGtDcG4w?=
 =?utf-8?B?dWQ1TTVJS0NSeDUrK0VMRmdMOUVMZjZCL3FZbEdhNmNhWmpEeVJCRjd5OEpo?=
 =?utf-8?B?TWdHQk5OUGhmdWsxYk5uYzMvT1QvZ2FBcWJPUzZGMkpSbEJVVy9tTmd0Vk81?=
 =?utf-8?B?bXhpSHBsdEdxcXI1aVJFRVNTYUFXekY3WG1tTVNUcFpYUXRpWm5GV3BURTZF?=
 =?utf-8?B?TG9FSkZtblBIMjdZM0tXVEVLdWNBUTFSUHpTY29OamNxOUIzWkU3RFJkMUJX?=
 =?utf-8?Q?e8pjO8Yn/ms/UWoy91rC+KnPg?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe79e97-bf47-4397-a9ab-08dd65162202
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 05:39:49.2170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqgReMpJyUJ/WN92kKAn3yDIfVNfKHJbICuCx37dj7MsXw+2J6A7NOWcU62kM8ULXKcwVeur7NLEkk8DLDvICw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8060
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Mar 2025 05:39:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18220

From: Jan Kiszka <jan.kiszka@siemens.com>

This was obsoleted long ago by b7bb7945c705.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/machine/preferences.bbb.conf | 7 -------
 1 file changed, 7 deletions(-)
 delete mode 100644 conf/machine/preferences.bbb.conf

diff --git a/conf/machine/preferences.bbb.conf b/conf/machine/preferences.bbb.conf
deleted file mode 100644
index 78b09881..00000000
--- a/conf/machine/preferences.bbb.conf
+++ /dev/null
@@ -1,7 +0,0 @@
-Package: u-boot*
-Pin: release n=buster
-Pin-Priority: 502
-
-Package: *
-Pin: release n=buster
-Pin-Priority: -1
-- 
2.43.0

