Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287C5FA3741
	for <webhook@archiver.kernel.org>; Thu, 27 Oct 2022 17:08:29 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.81])
 by mx.groups.io with SMTP id smtpd.web10.71.1666890504863692137
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Oct 2022 10:08:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=R5awVH6O;
 spf=pass (domain: siemens.com, ip: 40.107.13.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4LOyLaB26/K+mqEz8Z8MjeP5Q70ile1G4FvLkk2xfPmleQextRXGg/i7/TiPHvNowLMFezahc3PSw33IvKuPpR+Lus0G8T1ezFkaT6AGBBy0PI7a0qcTTEnge0ZblO58Ca/w4OX0uOQy2N/OSxndFUgWWAZQX13Y8pWMpFybroE8ho6ljC1tULC31LOWxrTL+1XMw/XFYSZRiltdUdUFF9reeRP+PhMOBNl58CnpXmKcttJP9HrJEC6Rfx4DwYrnmzcUjPvdOYwG+v8juELNpwx1sr1NrwICa8VIviwYoAekFa89fOXutYvpgoHNKNBvqVvlBXAF6JpYmScMvSARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eczd8iI4wCf8Ty26NkVGTg/SK8Xdg41cPtQy1EVBGP4=;
 b=oVEjh7dOLJR1so4rYh9IMdNjnIMv1ZfyeCk2TOIE/5hBnDAaPb5slPsKU4Pzzxki2A/ssxUOeKmio1xsDvmIsPFZUk90qoWD/M/CoQwT4Mk/1azR4mPVL25SfGreGfrh7jQzXw4fRxBGIev5L40fvIGscyf9+VRypstwr96dckfeR84EhyuRX7KXfyyWrL2klzdlhCnPrVDTTpe7NRKL+gEvSIFY2T52MbxyeOqFsvUHVgVAjRe9shEz3fd4FKYWM6PKDRQh/g5xMapjjQxgwSCFIBcOfxWY2BlHws8veKDTzU9GMg35o3cGxzRNgp8AeOroDvCl81nvs/BfGlMIYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eczd8iI4wCf8Ty26NkVGTg/SK8Xdg41cPtQy1EVBGP4=;
 b=R5awVH6OjKK8vo+4SKL5OAU4HQZHDPVsVew+nMGZRwC6FYMkaq6sb9URZjLnHAlG6n44q7EDDUBVy8TzFV6Iw5i7rr+bLhk8aAgs298FZnwk+oocHqHirKTEZqbUdtrR+9EMZMcN6W4gm6EAOhVoGftsOhucgFDkqOnj0dRDQuTGhvFXl11yLkEBtKFzfVi9ldbJa7B2UjzubR6ouo1Zhe2azUDxgrZusH+S+gZH5myBNzi9P+kSln5e8NDOxGvp2t+SgzmLJLjjiZWxQ316SqIcLWK04TyGmrzWkBpJCFKAbWFj/+LsQ2MFBjdLoxMaCRRRTEK46NlXBv+gnNDDdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3538.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:158::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 17:08:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b72:e60b:1f2a:b2fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b72:e60b:1f2a:b2fe%6]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 17:08:21 +0000
Message-ID: <7f1082ba-d68d-9944-7cc1-4dd6f174ac2d@siemens.com>
Date: Thu, 27 Oct 2022 19:08:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [isar-cip-core][PATCH 1/8] add recipe for edk2
To: "Schultschik, Sven (DI PA DCP R&D 2)" <sven.schultschik@siemens.com>,
 "Su, Bao Cheng (DI FA CTR IPC CN PRC4)" <baocheng.su@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
 <20221024122725.383791-2-sven.schultschik@siemens.com>
 <677bccb9114b709612cfd7b404fecc4d0e8d8b56.camel@siemens.com>
 <PAXPR10MB50374CAB4D5D604A25B7003190309@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
 <2b44a657cd32ba83a1427ed32090ac71da3fad5e.camel@siemens.com>
 <DU2PR10MB50308AB333670EFF00D6E57890339@DU2PR10MB5030.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <DU2PR10MB50308AB333670EFF00D6E57890339@DU2PR10MB5030.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3538:EE_
X-MS-Office365-Filtering-Correlation-Id: bac05950-ca0e-425d-41f3-08dab83dd9f4
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sjHA2Ymkgv6fUgtpLN3sxWfNXseWFcrJEXko3loN6uurdEU7T77Jsh2iQ6X1k2VAMWtkdhhwrkSthYkFGLsoWPgH5gCoA1V6vH9LKlrvGwxDLxzQxaz2p0w5HDe6cC9eKVh0N9WGTqz5KvGgFH80rguq0SUxWdVQME9xLahtbIcauYHn+7hG7XJ9d+Fw0/06tbMI3BgAy9uK/6KZWrGjvAF4O59Osg5bW3h2kmSee+lbemXAVej+OqNVPC26KDFdM+t3lvyuqRW6WOuFWsrLLgLL5SADLr9tErFtL3SBb4mKSPxLKFCDgHAe623fRKguo86Xem4U5m7r8Y1AcakcPTmEyuwS1xLUrwGR/iGDgLoZTdFLWv7QHjqKbGJ8At40eAwcmYS3wqaSDgdyXUKtX3ECfzQa8mrgWzU69eZEXwireKtDyKKwVLtwj1TcyhMAnUqmcik64Gl0tkRlNMeX4LP0hg5/i/dhg6JFH8zEoXl7yXSP2cF866tr0WgprTsoMoyc/JhmeT44nmvONC4rueWNa2vRx6E6IM9yZc+x2WateftVoKzwh2VFg16lElZ8Q/YADS9JtMiibYJ/WjwBQUJTPdXqiJn1FYnVKHYG4KF2zZegJskOY8DHtfd6tQng7mr7YgygOBQxPugwHWKfygt25HTklSIhWLstvavseN7o7X9dvzK11EZHsygBmc/rPPK0R7z2MJnDFAbLO400wabuoDRbh09vd3/guwDpgafImGYNzGtLtyPJA/p6bwXZ/dBZwtAcnyiw9+VdsrpslBWhNRkGkNy7YEjyTsM/clTczvFGmJbupB5jdettlFf9Erd3cDiApMv7Y5+LvLDyIg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199015)(2906002)(53546011)(41300700001)(110136005)(6506007)(55236004)(82960400001)(36756003)(5660300002)(31696002)(66476007)(4744005)(44832011)(8936002)(966005)(316002)(6486002)(86362001)(8676002)(66946007)(38100700002)(478600001)(26005)(66556008)(31686004)(2616005)(6512007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L2JJQkh4WDYrRXkvelV4L05Rb01IQnpHb1liY2NNR0tmUWg2Qm5DMTMwV1hE?=
 =?utf-8?B?YnVLT0pNNjRkZW5wcGFQdm5BQVA4WDIrRm9Eb3Q5ang0eVFlYlNNS1F5dEVS?=
 =?utf-8?B?YS8wNmRMWDAzblNDTWJvZnNOMmt6bUd1UW9xMXk4K1V4VWtVZjF3V0xsdVRQ?=
 =?utf-8?B?SnVZcDdma002MmhNdTI3aG16RjU3dFJ3Uk9wcCt4blBBRU11SlV6dnkrVjNo?=
 =?utf-8?B?cnkzd2psVFRac0dPLy9KWE5FS2FIa2cwV3VJdjJocU1pcUl4NWprNFpSS1dq?=
 =?utf-8?B?aGt2U2E4d1ZWSXYyQ3l5dzROYjhKOFkyS2plRFlOSDRka2tvazB0b2cyT3NU?=
 =?utf-8?B?aHhHZWo3Q25mUVppSWtheGNaNm02SFh0YXc2bmZjNnRveC8xOEhEZFgrcExL?=
 =?utf-8?B?Njkwb0trc0ppM1pab05ac2xYWU5BaVUvZW1RbXhpWEFCS3o2Ym9NNyt6M0Ra?=
 =?utf-8?B?QzNwckNjU0NHUUJzbFZxMW50K1BIZEd5ODRkSXAzdHBxeHFVcUdQdzFxSmhs?=
 =?utf-8?B?OGxkMy9mV0w0dkJhL1RXV3o4Q3MxVDVKUGNjWnJYME5mQmlZK2FoRTV3NEU3?=
 =?utf-8?B?Mkh6SUtvWEFZNGxmMVBqVnl2UTJxNnpTSDIzVDdZVTZGWE42TlVOMk5LcG9H?=
 =?utf-8?B?ckp0Z255Ym55SnlsZ1ovOEhJMUZ0NXdHbkd0VllOb3BsQmhwY0VWMGlnNjd5?=
 =?utf-8?B?cndlWWhNcXUwZS9yVnVWVGppcGRrSXFlV2hDRmlieWlSN011NlNpZlZiUUlC?=
 =?utf-8?B?SUcvMS82d1NONHNydlM2WDYxZXRMQUVjQ0lkdjQ2bzhrYlE4Slk3RnZydEs4?=
 =?utf-8?B?d2RxUXc1Vk1aMXJUZldXbUt2TzlwaXd4eVlhYVNKQTR5bElETTc1SkgxS3hp?=
 =?utf-8?B?VGsrSnhFNnBqQzgwZ1MybE5icWQ1Vm42cTZ2VitOMWVjZ08wSUZ0YXZldGlL?=
 =?utf-8?B?U3NTY1JhU0xqNjNWd1FSZ04xaVZTZjhJbm9tWWZpOElINTMydE10MDl3N3hF?=
 =?utf-8?B?SW15dG1NM1FhRU9hTkg1Nmd5WHdWVjVrYWhsTWFzODY3S2FtL3NpN2pvNjlt?=
 =?utf-8?B?MURsWUIxTXNXTVYrcG9neTQ1MldNYkRRVk42dGlTS1cra04xTk52ZUIwaVJ3?=
 =?utf-8?B?QnkwQzV1enptVXdtU3laL2lMVTBYSHZCV1E3ZkdXVmtIaEI4U20rM0Judlp6?=
 =?utf-8?B?TlA4eUd3SWJtWGxFb05IM1BjNVJzb0xlRHlPRGlBVm9vT1p2QkVkeU4wOThB?=
 =?utf-8?B?SmErZHB3NzZNSnR0ZXB4YU5hWU1FblBUV21NaUZCYVZ2b0FjM3loMTlzWXIx?=
 =?utf-8?B?QnRVVXVYeWltSHM1aWI0NS9PanlVM01xMUtyNVR6YjFJQjZrZElaNUlvb3lH?=
 =?utf-8?B?bDA2bldWSExJNDVCWkNGKzRmcE9oWS9lcHFEd2FYVFNweDFIODcxd2hRUDJh?=
 =?utf-8?B?ZmpmN0JNTmpGT3pBL3pJNmtnZzRyUHppdjRuOWdhbExzenB4eVZudWgxdmpB?=
 =?utf-8?B?QzlYcXVGWHhDUUN4UWgzR1pxRzQ1Z1VuTTVmaFA4VkhJNWQ1OTVrL2VkRUNj?=
 =?utf-8?B?S3BFb0xUR0Rmbmx3ck5DOTRUVlpRelN4d3ovdktIakYrREovTVYrekhwcVlM?=
 =?utf-8?B?MDVyTTd4eXZUQ2pHMDEvblJTajhOcE9lS1NkejlIK1dNaU1UMmx0KzdoTFpI?=
 =?utf-8?B?WEUwVG1sWXJGcDdDa0czTlI5aGNxTDU3MjdxNTZBeDEybXlCRXpWUktNQllE?=
 =?utf-8?B?ZDdqWGQ1dDBIcUtwNjExVzhuR1IveWpGTlFTY2lFZysxYzlLdXp5YjBZaTBy?=
 =?utf-8?B?ZjJIK3FXamZQVTFOMjhBMTBjNXJjMnRtWTYwRUpiTUtxZldPSFZXQjFsOGJw?=
 =?utf-8?B?VHVuY0ZyZWRrWEN5SzY1RUx6bzZGY21EeHdkTExSV05TbDJqYkhQT3FidTA1?=
 =?utf-8?B?N1Y0OTVubW1YbEIwWFBBdzZBZGwrdjc1aHcrMmVieHMvVkRzVUFKbDFpQ2M5?=
 =?utf-8?B?bk5yellUbGR4V0JJKzR2SDl2L1dHL2FTSWxRMk8ydkRsMmxXbndGd1dveGEz?=
 =?utf-8?B?YUZSazFKUUk5R0pHTmpqMVUvZVBJVkVxdEFXVUF0eENWeHMzQTR3VzhYR0N5?=
 =?utf-8?B?bFpVcnhOUW52MzlBazlneDArWG81SGFRR0l6UkxMQjAxRFpUMmlLYUFNNDZP?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac05950-ca0e-425d-41f3-08dab83dd9f4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 17:08:21.6788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxRRpBKrWDx/6ijaMCSwdho3Bj2UJnYNZMrfT/qIXF/Pve1cKEmKscmtqeddoG7oL4YcXzl2Bwl5Dsoyu4z+Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3538
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Oct 2022 17:08:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9879

On 27.10.22 18:14, Schultschik, Sven (DI PA DCP R&D 2) wrote:
>>> The last release they had was in Aug 27 2020 and the commit used in
>>> edk2 Is from Januar 10, 2022.
>>> So google/brotli would be added as git again, trying to get all at the
>>> right spot.
>>> I don't think that you would safe speed and space and you would add
>>> Complexity.
>>
>> I think you can use below link to get a commit:
>>
> https://github.co
>> m%2Fgoogle%2Fbrotli%2Farchive%2Ff4153a09f87cbb9c826d8fc12c74642bb2d8
>> 79.tar.gz&amp;
>>
>> which results in:
>>
>> -rw-r--r--  1 *** *** 501K Oct 27 09:32
>> f4153a09f87cbb9c826d8fc12c74642bb2d879.tar.gz
>>
> I reworked with tarballs. But I only added those needed for this build
> scenario
> to keep the complexity low.

Sounds like a good improvement.

We are only building part of EDK2 here, right? Then please rename the
recipe accordingly.

> 
> Therefor I would keep it as bb.

?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


