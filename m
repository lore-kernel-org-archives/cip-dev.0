Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB50C19F20
	for <webhook@archiver.kernel.org>; Tue,  2 May 2023 20:55:45 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.62])
 by mx.groups.io with SMTP id smtpd.web11.2258.1683060937117707948
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 May 2023 13:55:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YxrrMqJe;
 spf=pass (domain: siemens.com, ip: 40.107.22.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwBZ2UD8XrikVDX4hJ7DSfgICb9podchjzKKeJt6Mce1q6mh1YYDyLNYo5LxevYYyIlHgMbwk1zPBHkMCAJIbEx3F4NGLgYcvD6zGRwDmm4h9/XNGq4LTYAXczqrGJeJKd0o+1G+MbItEInFmXKVWXwhRcwqXlWVc8obHNTyvsHS4tkqBC2FcinDgrpWHZ0J7xfeW/hSdZF3ScDqhvZXmM19ocki5r29j3BS7HcbvbZDuZzinhjgfbG9fC/uVj7Ut9bsFjRRFqIo+ci/G6aFsgBu7Kx1YbHZnNPsO6gusPVi4W3CLeNMaqcSLwyhevJlvv/w827vVnyQejL6MJp8ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kf+wbDQSEwJ2WpvOcexxmbTGWGeDqTM1qqEVzwLd/RU=;
 b=e36gvAGqJ5pcpdvf5eMYbpQkm7qIS0LMA887LGQDJqWw/sJMpuxo/KyEGz376aarenrzJ+2p+dUAiFdCYUjjo2foqGTpOw1uBdEXSuzoV7KGpv7k7krwuU8BEmYUd3OsMgQ5JhXV4OZ6dTjBPE0p5ku3Eg6ScKCicCungwMr4LFdav9E5SdowC5+ikPbjdzTnd9ZLPhWSh99fgrXwcXDeNd+FRs9AfwpomcCWO0Pwp8UtleUIvScFGB+IwskvOH+WFxoKfpcJsfEH3sWx7Eho4QHzlcICVkYvLJj02rIf7BbLZyFHYHIRQEIhw1tRmQLbgMGbCM35lFdfXE2zEelIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kf+wbDQSEwJ2WpvOcexxmbTGWGeDqTM1qqEVzwLd/RU=;
 b=YxrrMqJeq0mFTCyHIxN+KihJ/4TAZHnvOLg8w1ldVxOeq61+WGmpKYA4p9/XlckIr/7GZXbFC1faZwn7nryfn9XAI0AL40MLfvYuYSwYZsFe2kJ+hRlkzF6abTd7uYB+gw3naj2tCfcZ9dNASE4MRc8cVtCOaYOm3aD26qCfNSZiRm2EEdhxN96OAcQJ8JqxpQyLKBq+v+wJt2NcA6852KtQOYF3l7MyUNU2gZWQkE3P3upL3jPtlgmyrPO7fzTWderDRgMopCaG6kjDPLgneV81sPpT5Y4+NSBuQ7CvvY2ZFbVJWY/kiZYpeKB6Zq32g9Q9bj5qq10nA5DF7ypviA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3851.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 20:55:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 20:55:34 +0000
Message-ID: <80872a58-d8ec-313d-7b9b-2dd327cd64f3@siemens.com>
Date: Tue, 2 May 2023 22:55:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [cip-dev] Potential 4.4 regression
Content-Language: en-US
To: Ulrich Hecht <uli@fpond.eu>, cip-dev@lists.cip-project.org
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Pavel Machek <pavel@denx.de>
References: <af817b46-e9b1-5a3b-a66f-3f677933c606@siemens.com>
 <1373319794.2397136.1683037244247@webmail.strato.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <1373319794.2397136.1683037244247@webmail.strato.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0132.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::37) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3851:EE_
X-MS-Office365-Filtering-Correlation-Id: b6153c3c-04bc-40c8-07e9-08db4b4f92d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iGCJQUM6vigrU74/MJ97nf9BdrBHFvqBQ9PqC647tyVV/4S5Est81eQJ/p8MvVpqONKuekE5c4cauPem03PTVeta5ImS9eQXsD6q9/Tc60tW5uVlziTZ4zkiC6J57fgxW1JhcLBiKggiFd5NwLL2XnqMy/Qrcvs7JnsLE5q6D+DKDn+dOdZMNfo/b64PIdC062kqXkbzWbJTBnk97F1JId7m/NbV/YnlCRrd6VVNdOgUz2g5Aoh0HgG+SSP7ShlMeOlLBOT+jjtZosvQB/vQhuhePOjjjsbbBn4civBpEY7aqJJP6IgtJuRSsqq6RvGxzyFfXpMNTfN6TacWwHIbyynOjwIPq1/b/nqmjrdsqA2vGDmvRehsG/qgoX9CWUGCrGmVsrp+h1ADvUhCYDfORyalb64AxtGgTvp8GlfiuOoCxNJPTjtPDaYamOk/YylODbIBswqA6ZFjN9PIP6c3iqZTkcLCYTZB8ScM9Pq+ckXgwRvcZfsf3NiX2N1TlLEglElMmGzr74pCKy0MnfzeTYFfUdnUhmaZLnQLmlcfcZP3P2/YdPzItdRbqWldLo3wf2Z3gzBX9eNQmStL0+KHnDXfcbrulD8oo+zIXkdX6mblUwtjk/7MMbv9IPFcKEIPcNCrIWEiw3fyaV5jVR8LvQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(478600001)(31686004)(36756003)(316002)(5660300002)(38100700002)(2906002)(8936002)(8676002)(31696002)(86362001)(66556008)(66476007)(4326008)(82960400001)(66946007)(966005)(44832011)(41300700001)(83380400001)(54906003)(6506007)(186003)(6512007)(26005)(53546011)(6486002)(2616005)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YVZnMSt2WFV1OHBaZXlFSGZKZ1NJTy9BUkZyM3h4NjQ0S29FaGRtdWFDUG0z?=
 =?utf-8?B?UHFDVDE0bEVaN3dyZDc1Q3hEZEZDWGl6dzVpSkVuVm1xWTBBUUpDaFRHVjIw?=
 =?utf-8?B?VjQxNm9TbitsWXBub29FeWh6NG4zZXdhMVF2OW1nV1IrRzI0NzI0WDJIaHpm?=
 =?utf-8?B?V1VHRjFSUVphUDhCSmxuMzMyZnNtaktIc1pkdXJHT09KZTF4eDlVWGZqWlk2?=
 =?utf-8?B?eitYa3VRUlg5U0xjMklTZ2JZM1hoRjBOb1BCQzdJaitiS085UWFkb3FKbjh2?=
 =?utf-8?B?bVA0MEdCeXdtQzhSbWpJRVA2aEJQbDBFK3Q2Z2ExZ0hwMFRDQW5kOHdHOC9a?=
 =?utf-8?B?NVA3U29mR0xPb1NzN0tnWG96eXA3RFhkV0N2Rm45ckdBV0pmQytiWnZabXJX?=
 =?utf-8?B?b1VMSS9jbnVTdlMydFlhbjRiNHhnbVlPcWNpR1l5alFDcnBuNVZFS2ZWSGxu?=
 =?utf-8?B?RURkWW9XTEE1YVMzdU1HV3Z5S0EzUnljcUZNNGdaSHRYN2tXbkg2TUdJTlFi?=
 =?utf-8?B?bUxhS2RvWVRmMnJKeXZkWXZXR25hdjQ4Vk96d3Iyakh6Y1VuV1YwYlVhT3JT?=
 =?utf-8?B?ZzRmSUlMWi9icko1TThZZWFNb0RGaDkvVWJNQWdqMVhUeHdwdzk0eXJ2Uktz?=
 =?utf-8?B?L3czbmJhNmdvbVpBZ0pPWEdjQTZEcEQwVm1qMUZuRHFjbWpMbGJtcy9VSTJZ?=
 =?utf-8?B?N2JIZkpKZ09ma1ZzVk5pVE04eHpQQWZ1bVBlYVhNbnpkeGhxUU96anpxeVkx?=
 =?utf-8?B?OWVTTjhOWnZCMFdlY21CSm5saEN3d0xDUGlIdDlYT3BMZGpwSDUyRTJhelJw?=
 =?utf-8?B?RGhQSzNrWnhUUFYyVTdoZ1UydjdReXREeS9jLzdKQm84d0k0TzFLOFRwcndq?=
 =?utf-8?B?Zll1eGdGWjRiTGN6S2lLdmk4NGZtWGhmMnlFRC9QU2lQSklDR2c2L3NzMG9k?=
 =?utf-8?B?NHA2V1VRbEhuQWgzL3BzNXo1aVVSenUrZmpRMDNEYWdGTGdoM1pIMXBDN2dj?=
 =?utf-8?B?Sm5lNkhUMXJRd2xtblFjM1pXSUlzSVV3OWJSVnd0Sk01RlV2QUdFK3BFN0cz?=
 =?utf-8?B?aitJZm9nVTlZMlRWd1NFdDMxQjVJWi9Qb1MrTDFKOWcrZE1pcE9FZUl3Z0ln?=
 =?utf-8?B?Uk9qNmJZVlh0UU90SjZRdlREZE5jUVoxVFhxSW40TmoyMlNwcVZXczFYOXJk?=
 =?utf-8?B?QmJSVk9QQ0g2R3hGbjcvZktGdjhGQnhlSDZBME55WVdWT3N4OTZUaHhCM242?=
 =?utf-8?B?eVBKUVZadTVtZGZwd0hiMzJpWGlncm0wcjZFSUNjTlV3dXNqcDNPUFh3aFRi?=
 =?utf-8?B?N3NUOHFjdUUzV1Y5cWxEU2ZLZGZWWGZOSGlGYlU4blRSUFdTbmZWMU9Nd0pY?=
 =?utf-8?B?SXowZUZBUHhYS2o4L2hKTWY2eUlhNTdFT00rTEJCT0VMUjhKS2phMkx0TnBh?=
 =?utf-8?B?L0xZQ0tJaDNMNlBwNStLYW9XTXZ5cnNWSHZuelJPc1ZVOW9CNVV0alJlY296?=
 =?utf-8?B?OGJ6Ym1uZGJmSGFQREZ4Nkh2b2lZelNZdWtEUVVrUlVyZUVkaDR0Q2JWNUhw?=
 =?utf-8?B?eE9HOFQyMmtqWWpjcXZqdGtWQ3M3MFFCblhKQ3g1MmkvWGkrdVFTOG1lS1Nv?=
 =?utf-8?B?VU0wVnkzSDRsWTRKeFpzd0JYMlE1SWhaZzZNdnlwWWdyeks3NFFINURhM3Bv?=
 =?utf-8?B?a3JzV1dDLzRRZG1xR2dwTmoycW4vb093cnVleS9pcVpMcXlzTlNNZjQvMXpy?=
 =?utf-8?B?cEhyNE1za05OOTMzd2g1emIrazF1a2pkVWRSbHA3OEdvMmsvR1Y0aGwyVUF3?=
 =?utf-8?B?K1k1M0krYm93djdIMzRWaWJFVWxFNWpyczRTeUJjVjBPdE9NNTVybGhWbnUz?=
 =?utf-8?B?TGFURWxBeFVOYUdManhVQURvWDVUVDE5L3ZtUmxwM0I5MFQ3MEVqR2J2RmU5?=
 =?utf-8?B?Tm1mbWt0NXc0ajc1cVhrckhKSFZtaExWc1RxaU9NMVhrNld3aGdQc2FFQUhK?=
 =?utf-8?B?RUJheHdiTUtMbDlBbDNSWkFYVGQrUGhXTVdNYnhCUG85MVg3aEdia3VBSzFT?=
 =?utf-8?B?OGRzRk4wRmErbHFuSGZ1c2lHQnJmMmwyQ0YxNk9XUk8rbGIxdjFXdzVrWVdy?=
 =?utf-8?Q?YTgfFmyH5ngqvhtynL+gNqUM9?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6153c3c-04bc-40c8-07e9-08db4b4f92d9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 20:55:34.3187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbLyaGkOKpaoTJ5B7g/mGVQ2e9oX5oyC5zHJFrTKzzCXq38YeTJsrTNHXWc3OiCFWM7pCdO6tS4oimU6oDQb0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3851
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 May 2023 20:55:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11389

On 02.05.23 16:20, Ulrich Hecht wrote:
> 
>> On 05/02/2023 3:59 PM CEST Jan Kiszka via lists.cip-project.org <jan.kiszka=siemens.com@lists.cip-project.org> wrote:
>> we are seeing
>>
>> [   31.479488] ================================================
>> [   31.505101] [ BUG: lock held when returning to user space! ]
>> [   31.510778] 4.4.302-cip74-st39+ #1 Not tainted
>> [   31.518272] ------------------------------------------------
>> [   31.526443] systemd-udevd/207 is leaving the kernel with locks still held!
>> [   31.550597] 1 lock held by systemd-udevd/207:
>> [   31.560126]  #0:  (&dev->mutex){......}, at: [<ffffffff816cd4c3>] read_descriptors+0x43/0x120
>>
>> since 4.4.302-cip74. -cip71 was fine. That kernel is patched (Xenomai/I-
>> pipe), but the error is rather pointing to a vanilla issue. How about 
>> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?id=572efb3c45b5c741f0642c63553d3979b2cb27b6 ?
> 
> Yes, that looks like a mangled commit. Could you try this:
> 
> diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
> index 1d207c0b151cf..c7c32326d50ca 100644
> --- a/drivers/usb/core/sysfs.c
> +++ b/drivers/usb/core/sysfs.c
> @@ -825,7 +825,6 @@ read_descriptors(struct file *filp, struct kobject *kobj,
>          * Following that are the raw descriptor entries for all the
>          * configurations (config plus subsidiary descriptors).
>          */
> -       usb_lock_device(udev);
>         for (cfgno = -1; cfgno < udev->descriptor.bNumConfigurations &&
>                         nleft > 0; ++cfgno) {
>                 if (cfgno < 0) {
> 
> 
> ...and see if it works then?
> 

Yep, the error message is gone with this applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


