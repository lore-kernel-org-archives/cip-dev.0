Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C689C47DDB
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 11:50:41 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.47])
 by mx.groups.io with SMTP id smtpd.web11.13466.1706788234921208432
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Feb 2024 03:50:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xy7aZurc;
 spf=pass (domain: siemens.com, ip: 40.107.7.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auP0Yi0ocDQf+9wAmKrAd7n6i2t64wwZeNA2hTQqwOTCKHTbMvrFaTaaRHOD2Bn1KG5wRzI6BSM0bL9iz9ZnlaQANUeqC9BU3BoTVy1UJ16HPbDlUEGU1qkUEkB/3O666wBiYiKcMDi/a1e9DidKKEcTznUWemjoCcRuKG4iJNzbQYNhA3uVw+1PlXRWnnTkriF9QaFfPiBqGYqvsoYMUEnStDxVcWeb29krRLZUmS31feITe51oTJM1CUdA8InJwuuD5HaSOkoYmJ/vlGzLTH2SRpXlyxO5c2+1VbS8DeFREM3hZRfTvkte8yXAAzhEJhKC8PXpNW+g/a2IK6UCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAtvInlJmG5AjlLWkex9b+F9mmifq6YgLb3pEzgtnjY=;
 b=ZkUcMr9MfuX6VloUcURXOcOh/FCJV72qSEh1iJUu5vp8q9YX3lPhxS/9oBk2YRQ0nPz/56CZqR28oeFFfrCRamwVWpKiS6LH/XUo0OTDEkP5sfGoawQVJIad6aDo3UKLzQK87YWV7LbDT6cYPhF1nWhn0XwzgFGEDmRW1efyh6eieSnFI9eNwPs8QqyDiHyjExAG3x82ZBycsR/CORH2TaYgSxzlnqmyjubF40/a/yZjbR6GVg6SWZieSkAtR/H1MdPXZbzeXWhFebeGAFup2qPQICWZu7kDOBB0xmMFTeTb72/oLvKFjo5xjbJQvlq6SVOxeCqrPKDLiwjKTJZDtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAtvInlJmG5AjlLWkex9b+F9mmifq6YgLb3pEzgtnjY=;
 b=xy7aZurcZGhyBMJn0WHZe2BsKRmlXT9r3CnD+ramtEqbSPXy1dGBR/vwy3b77axRbQg/yxk7tBbTe/AJpOfqimsQQ7FW8pWTD44kpDlzr6POoTv4v1PApCYpJ1tUeRdImVi8J91q1BkfXBa4F9IhfMx2ouh9uzKwLUac33mO8Tks1l/tEUmdx21elSCwnrPPhwX2WBL121UxZGKTitXuslyf/MWd8OKeuV6JWlUS7D2MGTJyNZ/Pb9pr6Ws7sk56rEC3/dYnNwEALI8pB4kuOJ8TABDkt3Da52l2uzjPBp/+t7FYfEnzsClpcmGKtlpdWGnMiNlEeY11WGqgHxMqiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 11:50:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 11:50:31 +0000
Message-ID: <630f7236-f31c-4fe1-b865-b5da0b7808f3@siemens.com>
Date: Thu, 1 Feb 2024 12:50:30 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f47523f-97ce-48df-b332-08dc231bfe24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pQHvEqVqDWilFg900fniiGD3GWqXVW21cIEJ01Atasyp6KK68j95J4xOkSlSJnVHeQCV5MbUP39TeDI6joV5iwXj3mv3fuGfwFJE9E+2riASw+Ds4IBUbdfscw21AhLV8sTGzTartQ98RvT+3vCap9WCUnMjagKzcWVxoBzMbdsWsAbwrP/rYbcf9MIa24ZruCM4sCNmd70FfYpo3GtFqhi450c2UfWXWF5HZaKhJPm2bZpKPY67ECTM8CuOJzAf6Xa5sPNEv3osgHKzqomWhOcDHsF1SxlYHztezFGk4zFhNi2DCB+aCM1hA1+zg+oB3GMh6sx9/uEQ5lAK0jcOKQH0h72ieOSRt6Hqv2uBtYFcJuD/hAqRwxf6aZ3pTo4CAaxqcTp2PWdMphyYLav/PjBx07LQrBbi0w3Fb97UrmTtnvSimZRUYWFey7HDnb9K35AvCtQHli4/OOL1A1i3HWkHAvwBbirEhu6t5Ny9OW2VyQIIKB23PZlwcr198TnCEApKAXVHc+2nlECrCGjJBCaoA79i8PYOopjDgjWCt0MTp/TOBC3siZxZhrqeSwBHO2F2mgSdhrxUFxPUbrjswIU6ZV77Ja8aS37zAWC6oWBrhH3fHWnm1LcrWkwV3czyTWiRtYLJ/cGrUA6AiuQmTg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(38100700002)(31686004)(478600001)(86362001)(6486002)(6506007)(6916009)(966005)(31696002)(8676002)(66476007)(66556008)(5660300002)(316002)(26005)(8936002)(2616005)(44832011)(4744005)(2906002)(66946007)(6512007)(83380400001)(36756003)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dG4xMGE5M1k4THJHbitNcENpaTMzWFNwWEMwcGRTQUI5VDdzRWlxemw2RGUz?=
 =?utf-8?B?OXJGc0VTbFF4SW9VOWRTbk1STm5ESXdlQnJSWWt1OHZ3UVZlQituRDh3WnpW?=
 =?utf-8?B?eXRZWm5GR0FUazJyR0xqeEEvQm5uME55TkNYN3ltQzZPRnpPeEZkc1JTVlh6?=
 =?utf-8?B?M3h5Mzc2VTFJN1Rpc0QxMCt6THFjNVJQQjFFcXp3eXBSaWtWTzlpNWRhcWNI?=
 =?utf-8?B?VGxSNVhqSit0NUtRcDdZTGdqS3B5dHRNQTJQcDNYZXFUb1F3VkhwZGhBaEZa?=
 =?utf-8?B?SUFkamxyL1JRb3JCMmdhTWMydmJ1UFlickRZZ3RmdFV0TnVEU2FZUjdGZDZa?=
 =?utf-8?B?cHB4RE1ZOWxYSlBBaGVDQ3R1aVh3NXBqYzcycHcrbGFUd0g1SWdDcnUwSEpG?=
 =?utf-8?B?aHhveTdvK2wyRlpDN0VSdnVneWlBWkRqNitzekJGQ0dNa2ZIQUxJb1FxRGFR?=
 =?utf-8?B?WnRJaU5jTVN3Y2s2TFV6NlhVRk95ZUtjS2VScGRXRGNnNytNSEJqb2FWR1o5?=
 =?utf-8?B?WW5xLytYRGR0Rk0rRXJWVDMwcGozdTREajI0cGI1WGxNOTZhREtjUTJrajlW?=
 =?utf-8?B?WEtSc2JXbE4vcjVKNXIwY2xwemdGY1lncnRCdFR2SHhEbjZwd3lKSXZkSHBu?=
 =?utf-8?B?bExzei9lekVrRjZwYm01SUt2Q25OUXFiSTkwOEhRUXdoWGZqcFplK1Q4YkIv?=
 =?utf-8?B?UE12QWlUS1dFS3BPeGhpcE1wZkp5cERSMXdtdVpmQ2V1WnNXMXZwZWYyMzB1?=
 =?utf-8?B?ZW1vQXZjOW5ZVTRaMWVGOUV4OXpYTVFESnc1ajNMQTdsZE9YN0JXY0krakJr?=
 =?utf-8?B?cTlNbUFKMXVZSG0zSnN0YzZpS2owRWZLL2dDdVRNTGR0R0VxdVBDTUEyQmR6?=
 =?utf-8?B?Vk41czJRdzltd1BVQ282dnVMSVpkaTNwZjFaUm96c0NSL1VGREI1VDhHY3pj?=
 =?utf-8?B?bkJVRE54VmpMRVd6SFIxL3FUeDd3Y2JUVGJYTTRobCtqcFhLRStVUU1nT3F1?=
 =?utf-8?B?S0FQMWI4RVJGNTBCSlRBTndvYm5iaTN1K09YVVJRYnN6WlV2c2VsT1JETTMr?=
 =?utf-8?B?RElKZFVhUmoyVHhpUGcvUVc2dUFJMUtPcmNTU1Jhc0Y0Q0tPaDdTbHNWSlZS?=
 =?utf-8?B?cWswOHV5Lzg2NkpERG9Xa3VtS0k1TmpOaFpOaVJFSVdJcFFZaUpabUFaR0l2?=
 =?utf-8?B?S1lZRm5RejRYNEk3aFdDRUFHeFQxQUhnWXVZc252dmNtL01IV244ZmR6ZFBv?=
 =?utf-8?B?MHVJQW1UMFlocHVXOHh0OFR5bXI2ZFJFN2VlSHVwNGZjRXRCRDRkNEJ6bVZK?=
 =?utf-8?B?TFRlMlVwYnpGWW9XZnhSQ2QzblJWTTgyNFlHUytzeUo2bWZDR29haldQWVJF?=
 =?utf-8?B?YVlvQ2Nxc216aGZaSWw5WGY2K0x1RUsyMExtbjZhUUNlS1JhUWlGQytTZkRq?=
 =?utf-8?B?ZWFsdVFIVTZTM3pITVBtRkxBck5mNnNPTE5uRzVVd2FpTzREMW03MHhIQkJi?=
 =?utf-8?B?MmpIMWl5OWlhbFRONEZxclZ0MkpwdWVaY3RvamJ5VlRpd29tYWErb1JVaFd4?=
 =?utf-8?B?N1RTZ3U4ZDg2bk4xaXMyLzVvcmRRSUtlVmgrdlpKYVJYS05jSFJqY1ZGZHE1?=
 =?utf-8?B?bkhoeDMzekdZWUVBM1pvNStBRC8wTVg3SVhBa3luc1ZxTU4vd3NoeUFYVUc4?=
 =?utf-8?B?QVJTTFJCZFArOWJibFZxNkRjcWo1L0RyamxCSjZJdU12MDNnbWlncHliTmNs?=
 =?utf-8?B?TStBNEpkc2w2Nko1R1JTWWI4and6T2lZOGZpKzY4bGx5K2grYUxTblZ4VERX?=
 =?utf-8?B?ajBXaHpPQVY4a2Z1cDNER1Y1aTNmY3phekF1c0xzSG53aHIvVjFHVklrdkRz?=
 =?utf-8?B?emNOcGlGMVZUWVplMXN2ZDV2TlJJWXVOeDBqQkhlcm1SRmYrcDhXVEdSeDVF?=
 =?utf-8?B?Z3BoRkwyUXB2dm9aQjdmSEFPMHZoNjVjQk1VOUFybGZ1c3ZOclpubTFRY3Rt?=
 =?utf-8?B?alc4Y0tCUVhka0dLblNsLzc1VERDajZtR1lwVFZxZGVhNUpwV01kR0lsK0s1?=
 =?utf-8?B?TVNXZ3RId2Nqa3pJODlDdGxTTE5BQ3dvQzFQclZ3RGpodHNGcHRZdldnWThM?=
 =?utf-8?B?RXZrSm1zTzJETTJXY0FhTEFOT3lKL09WVUl1MDRST3JmaGcrcFM2MFVMaGdR?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f47523f-97ce-48df-b332-08dc231bfe24
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 11:50:31.5649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEBAu5wnzYy6wpUHgXrPFLceid2hImr8oThntKuNDyWn8urN2Z94vgOj4mbgo1BjLJIr36Wc9bEB7KfK/4/Glg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7082
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 11:50:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14578

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=2&day=1&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/01/cip.2024-01-25-13.05.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB

Jan

