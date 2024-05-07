Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3610C25B5C
	for <webhook@archiver.kernel.org>; Tue,  7 May 2024 06:23:13 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.61])
 by mx.groups.io with SMTP id smtpd.web10.5222.1715062986952830285
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 May 2024 23:23:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ESlCqrqc;
 spf=pass (domain: siemens.com, ip: 40.107.105.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcD3cGM0IcIOr6MqR/OIJYBndxwu/4urN2C76rffKrQhsVDKp+xK6A9tsR0ZeqEiZLtpoivi0HdNG6CTe5u94WXRvfz+erZkkZpLW/jlDj6gf3jru6TCMgX8d8mwkfa4b884k0/f0o9Peg2Y/87x107KIlBYO+niJVxWAnzNS18O9eT+YcFSIpJxDgfoGAvr2sBrb26G9Kh+cYPx0zWKnRhIkWuSrNrRLvvTnpNW258SrW6t4S2L8vZkSMkUM1o09TcboYq/18VYK69b5c6wvzmh3sWgPCBU3KVy9YV1pVXu/bihjtC9aqBjfBLoCGQEosX+OhtXNkNe/3abIbGhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Na6arsI0Cvq5HDz8KXCO0+t9mbs0US/Y1/aA3QjxN+0=;
 b=nES5xrOzolYuqoLmprgGgzYFZG42uKM6wJXhlS52vhNvk6RBiVs7tcHfdkGIqfXvpfVHyRDbpoVIEfD+OrBN+OGO5V2jNTDuP6lWhEBkm9QroNtUrU0nIWdiqSroniXiiaF9VWSX/5tOsvO//BfUkSB350kcVTHTeQEFkAPEOxXP4lVmpJqS3y+FvIJcKhME2FERSP31f51wjJlSA7Ko88C/F20BZHwAa0QiEKS2SyEuscQ0Wxrniy1m8Efe4eSp5NRPsBZrZkO3NWRgCa0dnHjSL0HQ82CsRejIdmo+k0n+5kWZTMPXplkRD1wARA1Epwy7YM11M+g5HScRRxu2Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Na6arsI0Cvq5HDz8KXCO0+t9mbs0US/Y1/aA3QjxN+0=;
 b=ESlCqrqcw9l2BTJ2DxvK/LuD8M6mfM5bLXvNxdw13nKJEDaOA3WIOIvac5GCy5EP4afv95uX/9CNBAUMvTHs5mc1wqHRrt8LfW+3ZZVtMJ3Hf2cTPfdKjKMgRAAzS+Xe0qTSE2/7aOk0NAUWzLveepq/VDwb9hpbiPXCy72Z4xAFdvXJERYIlNOQqDQKKTpM2X0y/mReXC2EaGX1g9jrGo0/5S0Fpbb/YTIUNAHUFbMrzXCQpTBXR4Tva4/AM9DpefxuxJ/rR5p5xU44pJWYy6R8JMftvqk214FkCHNCzrZwj6Z1kgXyJr6KKSaMW1YOrXHq3x4VhdZKQbAGd6XAxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3797.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 06:23:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 06:23:03 +0000
Message-ID: <7295582b-bee6-428c-aeef-6e4b39d4e15b@siemens.com>
Date: Tue, 7 May 2024 08:23:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v5 0/4] Integrate Delta Update with
 rdiff_image and delta handler
To: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, felix.moessbauer@siemens.com,
 shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240506154130.840349-1-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240506154130.840349-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0414.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3797:EE_
X-MS-Office365-Filtering-Correlation-Id: 84399b88-a6f7-4e49-367b-08dc6e5e26cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?enJDNXNNMjJCVmhMQzlENlA1b2RNN2xmWWovTmRtUzNXbUFydk1qaHlHeWRq?=
 =?utf-8?B?NVJXZHY5UTQrdXdqZUdRWnpqVnk3WXdGR2d6a3hPN2ZiMUx3eTNmaHFGdjZN?=
 =?utf-8?B?NmRHVlJNSlJTV3JNOWpzd0lvV3ErVlVnODladnRDeFRiRUJwUVFGMXVxcS9S?=
 =?utf-8?B?Q0Zib051OWZidzk1QXJCSmNnVzJBOTkvaVlWeUVKZk1hRXpQWEFyMkxxclow?=
 =?utf-8?B?MXVxRnBBV1RUMk1ZbEc0S3ZVV1RyK25pV3hKOVhna1ZvUFVGczJSaHlHcWw5?=
 =?utf-8?B?eUU2ZkFjTS85amptSnhVRXNib2xYdDg1Zm9HbTdZTWhYQVpqbXkxNldkc2dz?=
 =?utf-8?B?YUw0UGs4WlpEZDIvMVNDTkJWT0hvS0pzQ1lmdmx1TVlibTJFV3dFcHJUbjIz?=
 =?utf-8?B?NXJteUJqNUhLWlJmbWVDSnduTDhXd0FHSFZCbm1KcGt2alhCcXZCRjdGckRF?=
 =?utf-8?B?eld6TGtFR0NGRldVQlRtYzR1c0owWGNFMDJBZVNKekRXTjdVMU51d3dLaytU?=
 =?utf-8?B?VW5NalQ0WjBUQjdZT3Blb0JqdnVsNTRpNGFmTFhNOWE2bm8wRjVLTE1zTmxa?=
 =?utf-8?B?Z1dPVEN6V0lONXBEOTVvbDI1LzZmQTZQR2NGVXMzZmttenhDZlNPdUYvQTRF?=
 =?utf-8?B?RW1BbytWYkI3UU0vN1lyRHNjdnNmRUxRWVBaV0o3T2JSblUyTmZNNVN2R1lC?=
 =?utf-8?B?cWUxSmZqMUQxZlRZVkNSemZuR2p1TkduNmdCMVA2NzNxczI2UnA2VkQraEJM?=
 =?utf-8?B?Um9mR25jYk9TYUZRNkxjS2p2bnNBUy9ydGtnQjVtaWZweVB4UmlpbTRPY3Va?=
 =?utf-8?B?UzBvdTM3RU84NjNrZVdqd3JEdm9YelZRSzE0OUdNbWVDTDJFRSsxTDlydGlF?=
 =?utf-8?B?QS9oL2E3cE5TcWMxYWFQTFU4cVpnK09IV2pibXNUa29QR3kxRU55VUtOdkg0?=
 =?utf-8?B?MXhxaXNrNHhzN1Vodmpja1lRUTZrR2hVTkJhL1c0UnZMc0UyQnJ6QTZ2K01v?=
 =?utf-8?B?U1BxVyswRHdSRWU4L3JyQWcxb3JXUldrQUxrazJVazUzcU0vUk8zWEU3UExV?=
 =?utf-8?B?YVRxZVZ5ZG51WXJBREVFTlFOTUFNT2k3dkIvWkdpckVmQjg2aWJlTnJUMGJj?=
 =?utf-8?B?ZXRwVU9pRHBXSkVoUXJTTlFYN2ZreXhEWE5NYSt5aXZ0YkRZQjZpQVIzWUMy?=
 =?utf-8?B?MUNvUjNnYytUd1NldlRVT01ra1VMdXo1RHJkWEhTajh3cnhPNHlZMk1ZSHNr?=
 =?utf-8?B?NkVScVhEL2RLWldzSkdJRW5OT2JFWlY0SDZZcmsvS1l3VHhwZGRGd3BWZFVn?=
 =?utf-8?B?M0hoaEl2cVpVQlRIbGU3dzE2MXlBNXMxencrQkV5Yml0cm9SNjV4NnlBWGdw?=
 =?utf-8?B?NStxallReHhrWG5LRFlUQUFXejNZdU4wb1FWUHZyeTBKSVdnNlR3N3pBRUdk?=
 =?utf-8?B?eG9kdXA3My9PNmM2WUtySmtndGZZZDFJTHY2NDNSV0RsQVB3WEdMQ09ZZS9G?=
 =?utf-8?B?OHd6Zm5pdkZCNGNITmxCUjVhbGR2R2ZRNTdBNHlpSnAweUtyTVh4OWpLbTJn?=
 =?utf-8?B?RGEyOUpLN0V5Vy9ZRFk4WTF4NXk2SG9JWlFqS2FTWlBZRmY3UTVEZW9vTmRY?=
 =?utf-8?B?VnFwUklBN1RmWk43WFFlM3o0Q0ZSU3BlNzZyU2FTcTlEOVhEeFQ1L2tsSzhj?=
 =?utf-8?B?Q2dpQ3hES0kzbDFWZFRKVzh5UEFFam9PaFNPSlFBOC9FbDRWSUttWXdnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?elhkS1RadlY4a0R5UUlnNktPYStZRlRJbU4wYS9EK0tCUnJ5MGF5emJQbFF6?=
 =?utf-8?B?dlNTYXc1bWR4QjYrczMrUUVhbTlqT3h1R2RJQmhuWDA3cHhNT3FvM2dXaVc1?=
 =?utf-8?B?bDE3a1hsWi9EWEFFNkJTRlgvTmhzNmgwSitxaWxXSmVOb29iRVRqZEdwV01p?=
 =?utf-8?B?S2x1WGFBWm00VHUzMm02WUlFTmpvTzIxZGEyM2NzM0FwREFQOGk4M3RvZUlY?=
 =?utf-8?B?Nk15V0x3MmZLT2V6RHAydzBIYmZLQjVNMkpnaGNBQURDLzFvNHVrU09JblZ2?=
 =?utf-8?B?T2pTRzhyaWhqejBXOFhKZnJvQ1IvZVVsUlpKQ1ZMVzN2VzdqL1NXSlFnT0dI?=
 =?utf-8?B?Y2c5d0ttcVE0NzROemxHd3NNMFJHQUZOK0JxekFZcFlycmtXb3pSUVdhYWx6?=
 =?utf-8?B?K25UeU10aFhGblNVOWVWQkovZjZCL1pVVXNRSWIwcDJjVFdIZ0NSVjNjWnNF?=
 =?utf-8?B?Z1llbzB4czBxeStObmN0OEhPQzN3N2dUek5IWUdXaElNeTFzd0RybVFrcWFw?=
 =?utf-8?B?WnZlUGNFSHRUY24renh5OHpjeFh4N2t6Ujk2WU5pN2lyYUdHYjhZSXh5TktS?=
 =?utf-8?B?clhseC9yWTFlck1Mbk5qM0JjRGNKMmlZY2lMbGxVeHV1eTk2SDMrYUxYQVVZ?=
 =?utf-8?B?a2RwNkhMZ0NiUHVUaXVDZUhWQ3BWSGNiMXVzMm1zVXhORHgxUDBiV1BSL2ZU?=
 =?utf-8?B?WEovRk1mWEs2aEVTYU95WXlBaUloTk43Ti93MG45aFg1UklObGEvRTJrODRo?=
 =?utf-8?B?c1doQ2NOWlIyak1CWE1WbElVOC8xQlluM0hQMzh5bTVXZDdHS0M3RVVZTWdn?=
 =?utf-8?B?aU45OUswS09Ua0w0enhpb1ozY1BkeE9Cd082OTMrUWprcHVNVzVTUHVDNStF?=
 =?utf-8?B?b2xwdXlkY3luWk05cURUblVCSy9TMk9zK1o3QVBNZWZVSHhVSjk4d2tJNVZW?=
 =?utf-8?B?aDQ5cG05UExkM01hTEpLeHhLZTdXTGxuUnMxUUpEVWdnWjlLWTdCN0ppbXc4?=
 =?utf-8?B?K3dVbFJVTmhJR3c5R1krQXU4N2J1eHBSZ0dKTzB1QTl1S2cvNGhLdzVSZUJX?=
 =?utf-8?B?d1BNdE51RjF1S1pvMVBYajJSOTRodDlyZGJoUGJLZEl6TnBMOFNtYzlZY2Fm?=
 =?utf-8?B?TUJOYUV0SERYVkVLSVVvRENDZUlqcFFGZ3YzdTdUT3pTbEJ5d1poUmNFSExT?=
 =?utf-8?B?aCtuMXFFOTZFeEpMU3RSWFZqano5dDA4Wm5NYUlzaFRHQm1QSmU5N1BsR3Zr?=
 =?utf-8?B?YWFlVWJDM25wK0R3NkUrR3BhMENyeno5VWlHNklJektheGN2QXEwdjZ0aitq?=
 =?utf-8?B?bEZVV29ScVd1WUxCK1NCS0NDVy8rcTN3dWhEWGFGbzdIR1VLV2VWUVVWYXZo?=
 =?utf-8?B?UFJqMDRFWVZPV3NDQ1hXNWlObVlaMG80R0N5UTFnWTR6WjQ1TE1ucytLWGtj?=
 =?utf-8?B?QkZPTGs0Mm9vM0hSSW5Oa3UrUWhxK2JpbEViY1M1U2xXUkVQaHV2YW93SWtW?=
 =?utf-8?B?MlhUYkdXR1hWcFNSZFNYZ0crenZtYUZiallWNk1mUCtaakwwV0xtRnRiM0RF?=
 =?utf-8?B?V1BRS0ExT3MrQThLdmV4S0xUZGN1cTVBb29xNW40Q0VldmdZcXJGejBvOG5l?=
 =?utf-8?B?SVJCY1paWFpvTHdseGd4OTdkZStGZ2RrWmlVdStyK2ZFSWZ1eTFubDZSbVo3?=
 =?utf-8?B?cVVzQ1dUSTNhaFFveHBzU0RqaGROQkZLeXMvcnByTFJpRnJuZGV0NC84OGtO?=
 =?utf-8?B?QzJmNlBNd1ZaVTlZQWN4a0N4cHVacGc3Q3MxNG9MTWVHamc5cUN3QXlVT01X?=
 =?utf-8?B?cHF1R040MXo3aUFxd3FZRVhWLzN2clZmMmlUQUJxMlpwZGl4bXZNSEtPNjQv?=
 =?utf-8?B?TE9LN0N6ZVBMVHZhdkcvMlFoQ2dSbFIreVI3eWMyM2l0cEl1UjZxc0t1VWpD?=
 =?utf-8?B?bXpkdmw5bzBkeHBIbGVJazNqUzEzVEhucG5CRElpNUtWMkJmeDdGb29nWGc2?=
 =?utf-8?B?UVdOSEtSeTRNN1dJUGhyUTZFbWFuVnhPRjBYcko1YVVrWkVpdUhLdktQTlgw?=
 =?utf-8?B?RUV3VGR1L0lTWGNQS0RFVmd4WkNDc0RqelpqSGlJQ2FCa2FJMUJ4d2lkK01y?=
 =?utf-8?B?aUh6RFF6NjRpaCtDSzQ5WEp3UUowUFcwK3JNL25pTzYwQ1NRUnlyTWhiVUJJ?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84399b88-a6f7-4e49-367b-08dc6e5e26cb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 06:23:03.7425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FDOygITRToSwD7+zPXgr5RLi6VffCbxY8Q/5pXOxstIke4WA7u5Yib7OEGXputACzItubiy7+s3JxsmiVAw4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3797
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 May 2024 06:23:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15848

On 06.05.24 17:41, Adithya Balakumar wrote:
> These series of patches enable the support for delta update for the root file system with swupdate's
> rdiff_image and delta handler(zchunk).
> 
> A couple notes about the implementation:
> - In this patchset, Delta update is only supported for the root file system.
> - The newly added delta-update.bbclass handles the creation of the delta update artifacts.
> - The update handler type i.e rdiff_image or delta handler is set in the variable "DELTA_UPDATE_TYPE"
> in the delta-update.yml file along with some variables required for each handler.
> - The creation of delta artifact for the rdiff_image handler requires a reference image (against which
> the delta is computed). Currently the reference artifact file (.squashfs/.verity) is passed to the
> build system by placing the artifact in the path "${TOPDIR}/previous-image" and setting the name of the
> artifact in the variable DELTA_RDIFF_REF_IMAGE in the delta-update.yml file.
> - zchunk based delta update is only supported for sid onwards.
> 
> Changes in v5:
> - Introduce delta-update.yml file for delta update related configs.
> - Set rdiff as the default for delta update type.
> - Add delta update option in Kconfig menu.
> 
> Changes in v4:
> - Create only 1 .swu file, either delta or complete swu.
> - By default complete update swu is created.
> 
> Changes in v3:
> - Rebase to current next branch (61e998e1e0541e2713c05fcbf21df39fbc882a0a)
> - Set "${TOPDIR}/previous-image" as the path for the previous image artifact for rdiff update.
> - README updates to verify delta update.
> 
> Changes in v2:
> - Removed zchunk support for bookworm (due to use of backports). Currently zchunk based update only supported in Sid.
> - Removed delta-update.yml file. Related variables have default values and can be set in manually swupdate.yml file.
> - Using .squashfs file (.verity file in the case of Secure boot) for rdiff delta creation instead of .wic file.
> - rdiff is set as default for delta update type, the build system looks for the v1 artifact in a default path (image-v1/<artifact_name>).
> - Created a separate template file for sw-description of delta update.
> - Renamed delta_update.bbclass to delta-update.bbclass.
> 
> 
> Adithya Balakumar (4):
>   Add Delta update support with rdiff_image and delta handler
>   swupdate.bbclass: Generate swu for delta updates
>   doc/README.swupdate.md: Update steps to test Delta software Update
>   Kconfig: Add delta update option
> 
>  Kconfig                                     |  16 +++
>  classes/delta-update.bbclass                | 102 ++++++++++++++++++++
>  classes/swupdate.bbclass                    |  32 +++++-
>  conf/layer.conf                             |   2 +-
>  doc/README.swupdate.md                      |  59 +++++++++++
>  kas/opt/delta-update.yml                    |  20 ++++
>  recipes-core/images/swu/sw-description.tmpl |   5 +-
>  7 files changed, 230 insertions(+), 6 deletions(-)
>  create mode 100644 classes/delta-update.bbclass
>  create mode 100644 kas/opt/delta-update.yml
> 

I've tested it yesterday, and it worked nicely (even with secure boot
enabled). I just have two small comments on patch 1 now.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


