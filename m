Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E76C54E69
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 11:26:14 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.68])
 by mx.groups.io with SMTP id smtpd.web11.40775.1710761169775004410
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Mar 2024 04:26:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xmXK1EcG;
 spf=pass (domain: siemens.com, ip: 40.107.104.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffccufGEdhRXpPMs9g5n3uI05MZJnrQkfgQ6/DePN4dHljF1Ja346C66R0QG8PiabsCrL5znTw9zKLHmnphlITutVmes4vbPc3ZlPmB07xa+NvNdxAQye05jAGuAkIw+up4QBPe/DI83eIhtVtAiWiCvHXU0WkoBe2XcqCaJ9urfEtGiyQpguSpWJQeY33XREyXG0hDkiqBgX+G1DxeDfi2AHCljH0ebNscYIlSp2hBc5Ypb+bsHs46hIPRq6IU48czts55YNCpMO1pt4sA+2tXXLwxgF51QhNvwUTffxa/RB9X6N1JZxazKtVxA9KCy+wSDSS0w5AeB7aR3HJ48kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcuCq0RYDJQ8ykIYl82Xuuk2i2s6HwanXYr6MGOy3hQ=;
 b=QMjCsdv8JoTuSK9yvAvoe4rSvLFxsSCUwnvisE3xC7/C0Yfz0KAKJjx/xOZPEoGHb1xOxzRJPKR9kRnmWo20DbnP3M8d2NlWNxRpCewcbBs07ek2ED281Dg5GAHHr41nkIqeP3SP3d7i5p8DtjNXccP21HWFZaDrxEfY9IXU4HMtCjfkmfJTuS7OywnkBFG93Ec0R9etS8nvmPVBwj4tilW/p9NOJZWbwAELlcHqF/peIg7Nd9Tp8w0LXEHBWSWorkSeuBbS2XmpWxV5a6dD15C9iux5/iYBrRXsu/odXvPFSIeGLv+1LUClf6wgdHqTvGKkaRhf3M5FD0iqcwyuRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcuCq0RYDJQ8ykIYl82Xuuk2i2s6HwanXYr6MGOy3hQ=;
 b=xmXK1EcGFPclq0zWKnZsxfeL19a6ENXwtjrBLJfOcazDMtGThWQla2+a7bpBr1z13HgZlqD5Us1b0tV3EmVOHYHlVSzlG+C5mDs6zBDZie89ABUcIiDgKscCHXoDWvwc/nYFiA3AF6WVjeFiDypW8/YL8ss/oeExZFBn5dK0RFVRMYsv+E36iPddU/2P+m66Iera3KVsGP441dlwgMDfgjD2TVvOdF3QlNxs3w1sb0IX0POjN9LnDlJu11Av1nG+0RXwW7ZN13qJ45+vQxhD4TfDnIbxGPj3LC7sltlC9nu2Er62demeNbY/Hv+m+4+G2p/bTMQGDSkKOvMSaR0oOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5206.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 11:26:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 11:26:06 +0000
Message-ID: <1eb165ec-4d65-41d8-932a-64d9da2159b9@siemens.com>
Date: Mon, 18 Mar 2024 12:26:05 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip85 and
 5.10.212-cip45
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b4e262-9787-4b73-4fd7-08dc473e3429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cD+pq4rLq4aasVNpdJQ0932Q/PPbMpT+ovWt54ChjDxcTaKDvmzA6H9iRQR2uO2WGxh1YxMtCtX0VMUq5AqokPs4Um0WomX/sBsP3FxQzHfZWj2gH6pnMdAyKpILIBhvrHH1L/7iMb30mhDmFXnttLQ+vk5jKliAY2J3ogRBXL/8xLApiDg86nyovt0kFuXSlx0TMOLqsEYidZGdDXHMVpbYKbJ8K9+M41kuF5zF64iYYunysfxrkmMQV6ieUD7piBAUyfJHgUGBDtdIU+RW1e3Yt5HoyR38T63An86W8PV3O7g9IvQxuv9qzp0cBFPxfv/dZOLboFod4/fccJNRvtIyTfdIBHx8FOXX9Sp5t6zpliaxbSsNM53x7nxVVYB9rqSjgzi9N/Wdp5x4SIxFpdZpTHmQf+wXBl9jTdlgIGuLdaggSVzg4RU7PUP4gvEAW8NB6kB+Lif53NABy0QPAvZ0zKJoE6HkWQupQDw/h6JlzC+fCEGskEDOh/IjWESS6eEBdMgNgn2twlOU63Fx39Q8ER8jD9Exiruk87vDcbWf1lZho8ZVjFKVLThTx6hV1iqCUAKQKshQwUAqEMmjvJTZAerGNc1icE2hAvF/O1mxG+mXo1NArEMdwLl5wmwidb/GRgVEq/0gVoygEYTvxQkp9vBzkwv8+LrwnfEyRJY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dXphTSttbDlnUlBmWFJqWGh5WE00eVdDVDFRQTBCR0t5WUhEa1k3eFBTbFhI?=
 =?utf-8?B?eCtTK2JXcTA4U1FzMXlyVDFqUi8xSUNiTHJGcmUybnlxL0lVSG5pdE1Fby9W?=
 =?utf-8?B?c3RPZFgxRWNsMTcwZndyNUU3dmhaY1d2U1grSUl3VFgxQy9rbWcwQ2hZM3NP?=
 =?utf-8?B?ZFFqbG5YOXpBRE5WaHBSOXFhY0dESlFJQ2tFeExNSytydlNDL1plUDJ5Qk9k?=
 =?utf-8?B?SGNMSUdmR3czZnJOM0FXb3UvRmpSYS80OXAwc1h6eUpWUjdpUXUyK0s0UjFQ?=
 =?utf-8?B?TE5aSjF4eWtiSGRpbHM3QWVDNVdISFcvM2RDZGhPbW4wOURDcGY3LzB5Mk83?=
 =?utf-8?B?QTV4LzBHNlNqM2wyVThZWWJZbFVDaWltdVlPV0RYbUphcytiK0ZZcFN6MTJ5?=
 =?utf-8?B?cGlIVkJJalgwa1FtdWFkQWlxMjNWaHljVVJucktkRFpEOUdycThQN1BvWE1X?=
 =?utf-8?B?cW1ZTnErTTlUVm5vTjRrd3d2VHA4aW11Y2RQbTFIcURBWERiMEVyWUFtZVd1?=
 =?utf-8?B?aDhnWHVRelVtSERmZVNPYUI1R0FOR2Zkek1pMnJaN2h5bDAyL252VHhORTBj?=
 =?utf-8?B?cjYzdzZWTFVPWm5BdDNYM1BNWHhNS3dmYVNaUmR6dkIybWd6MHpLenNyL2lw?=
 =?utf-8?B?S3lzVjBONWVja0VCSTdSaHZINitOSDh4NlorblBSaGhzdUZKY29HVTYrcUp5?=
 =?utf-8?B?YlE3Z2wzaEJkRmNXWXZNUUNlRWFIcjFTcXljYWdDT01YSzFZYnBBMUV6a2p5?=
 =?utf-8?B?TDBadWJHMFRDK2hvUENKQlY4Q3BZNzNPYTh5YnJNKzNuR1ovNUttbHpFTVV2?=
 =?utf-8?B?NXFRYkV3a3p1WmNFSWVWWTBEajJwZG0xenZsNzRNM011TU1pQ0lzY2ZzRTZp?=
 =?utf-8?B?VWRJTWx2UWZ2WTNpZFFUa0IvcVZDNG5oQjdxaThOcEpaTlhBSm93YnVKQUFr?=
 =?utf-8?B?bGluUHRKbU51ZUpPVVJrYk83ZDQ1U2NGZkhMeHFsc2RPWUZxem00a0U1YjhR?=
 =?utf-8?B?OHdOSnVadmJjTUdlMVppLzB4b2lFdGRoOTRXMUNLSENkdWp6bE1xQ2VxODB4?=
 =?utf-8?B?dU82ODdpRzZiK2FIVk5jYzZwbC9Bdjhrbk02a004U3prYVVmb2FLRE9jWHl1?=
 =?utf-8?B?M1VtV0QyNjdURVhvTjNCTTAxUmZsKzlDYmw4SnZrcHRtT3I2STArcGtMOFdC?=
 =?utf-8?B?TFUzUnErOEdZcGY0KzAwSitVYXc2NC9adTJmVHAwa0RRMGxpTkk5TVlYSjNX?=
 =?utf-8?B?R0dnRXJZQXNNeTJwTUVHNXZyMVB5eDhvbWF0ZjFzZEJRR1o4TUpQR1Q5Q0Qy?=
 =?utf-8?B?K1V1UTUrM0xwR05kcWJFLzBDUnNQUjR1RUszNVBBaDlNTlJOVUFZUzd5ZmpT?=
 =?utf-8?B?OG1zbktqU0lsVkpZT1l1U3hUQ0pCRmlERmdOMU16aktMVFU1MjV2K1B4Vlhv?=
 =?utf-8?B?VHRaRDhQZGZaV2NRSVNrSHU4K1hCaS9jTTh2ZTV6c2hucjhacDhVL2xCVVgv?=
 =?utf-8?B?cnZtazVBMGRaZkdiaDZrUllvaDlYMkxRQ2hNVG40OElUc2F4UFRVYTkxSzBN?=
 =?utf-8?B?UGhnTDlKSGxjeDRLeWJiWExDTTBhaW4rMDd0Ti9UbVYyR3hzZG5pYUhXWFE4?=
 =?utf-8?B?YUpTZVg5SldYTDFKZ0ViSmRENUYwWUJ1VzFWdUJTekRMNnpPcjJEL2lVUWNE?=
 =?utf-8?B?dlZ0VllmS3VZeXhrUHNYR09XSnoyQmVuMkVXeG85WllBUHJTM201SU5pa2di?=
 =?utf-8?B?TWJwUDZBOEk5SERFTUN4UVJwTU0wV0tINXZ0ZTR1Rm1vY3Z3b09vWkVSQXRE?=
 =?utf-8?B?bnd0MDhjNDd3b2xqTGM4Wnd4cGFwcWk4RWNzTFBvOURHUUdMRmt5RTZTNkFz?=
 =?utf-8?B?cFdxVlY5VG9GYmxQakIvdmhlSXpUYm82cE91T2g5UnNyUDdVb2xqZFFPNHBH?=
 =?utf-8?B?ZitLSmV4SkNpZzR5M1J2bmhmRlRyK0R1ZlJVYjFqVTF2YzBPc2RacFJhOEdY?=
 =?utf-8?B?c1l4bDRrZXZhME4rL1lVQVp2cTdnakdKRlBVUmRVTGRHc3hkNlEzejVkVTk0?=
 =?utf-8?B?ODdRWC9HWnNiRlhQa0txemNOVVA4bWlBTDFEcm5xUFVsTkQwTm1BWjlUVWJy?=
 =?utf-8?Q?QmCT+Jed7SRzOV8N9bUG0Pwnp?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b4e262-9787-4b73-4fd7-08dc473e3429
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 11:26:06.9302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 233CMCeb6p4SSFJy38YLpOUYZk3QLWmuFjDvfeE0TL3Zj+hCsazYP3atGH2nPRJuTJPDGojJuuDlXilCOc0onQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5206
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 11:26:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15339

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../{linux-cip_4.4.302-cip84.bb => linux-cip_4.4.302-cip85.bb}  | 2 +-
 ...{linux-cip_5.10.209-cip44.bb => linux-cip_5.10.212-cip45.bb} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip84.bb => linux-cip_4.4.302-cip85.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.209-cip44.bb => linux-cip_5.10.212-cip45.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip84.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip85.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip84.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip85.bb
index 0ea0a0fd..b71ef9fd 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip84.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip85.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "aa11943e7a262482b474d205b5cf0e1ff5a7ee17aa04dca9a09fcdd154cb2840"
+SRC_URI[sha256sum] = "ea131a2e907c5cbc05fb756d00a007b1473160e4d250d7332dd050f549c09408"
diff --git a/recipes-kernel/linux/linux-cip_5.10.209-cip44.bb b/recipes-kernel/linux/linux-cip_5.10.212-cip45.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.209-cip44.bb
rename to recipes-kernel/linux/linux-cip_5.10.212-cip45.bb
index 15d45e89..111866a2 100644
--- a/recipes-kernel/linux/linux-cip_5.10.209-cip44.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.212-cip45.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "25774a60893652d1412dafc8330f8f1fa41e2e3db794c5596283d83f0496bb86"
+SRC_URI[sha256sum] = "904e4b2547eed965998236bebbfbbd60ae8bd800d11ad46fbeeeb0d67a4fcae1"
-- 
2.35.3

