Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A3EE7C4F1
	for <webhook@archiver.kernel.org>; Thu,  5 Oct 2023 06:44:34 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.49])
 by mx.groups.io with SMTP id smtpd.web11.9792.1696488263643396151
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Oct 2023 23:44:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GgAcKVXC;
 spf=pass (domain: siemens.com, ip: 40.107.247.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ndyhy80jSd8rs8guTY0Oz3z2ROdFXdTzM/de6Lx+wZCfkY5n7neg4ZHFqPmWm/hi/kELXBreCZQTnG085XLsZcNqbuXsLyNaLbBhTjbvJNCoenv75ayE53kOOn2d5tEReJo+EDLGmv+Qi+Zz1KmVHc6rCAwQ57gHXl1EdDt57U/c5xLctAXigpSJX8q9hLSoIpSo05QS2uK9Uxa0oYaBcdPYYxi2uPhFakd7QHJ08DNSUT51ZK/NyE0/9QbQjyslQkH1qPu/y9K5q09y5nD9Lw9Po6aMRFTtszf62FxYsVykO6Y6zLuOR3J4rvmv+mjlX9FRZHM18cNxlHRs/ekyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crv7drSV2F5bpuVkiLh48vbb2LRTfMf0VdwTk81Y28E=;
 b=k2TI1g+HQ6lRQD8iAvu/5HDlAJ7EJONAdZvCILThW1I+roKBcFzE6uL/CDkm049fDsl46xIui3v2mOUcve0ZODFDIJ9gRa8FuoC6m3kgG/B7jIRYnV3PxzEBkdiKQQyGazxHXavQMxxlcYY7xvK7Pc8y1O0bxDPDKbIST59NwIgO7SWmjC1NZI5POTsHsXzl9b3U/ae/Cd+N6NwPVqpj5LZ/ya24ffVJIAwFBwtz0wSsjJIICCsk+kGzGcP3mZ4Qr9x4BM08mNvDFrGnTc2xII07y1j50NSHyIWN1/n9zaDk4Er4H0iahlJJqGf6opNmmw/Alz5d4cXa3pQ7/lgpzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crv7drSV2F5bpuVkiLh48vbb2LRTfMf0VdwTk81Y28E=;
 b=GgAcKVXCnpx7nn9OL4HjGK72HUR/K/NqEBh6GVUFTonj+fmMn8es6nfs8SABE7/efYymcgK6qu47tpkKm38wKu2oPqlvusOtw5WUQKvtmcTioSlZG79S0y4R2kY4GPnzYJLP/Wsbt/wFegBkGZ8oFbfpheKksDMwCm4qYUJD5spmj1w41foDCRbimuSLHf5Cj6u/UI06orrISxRnQRHuj08AEo38jlofKSLsUjNj+Cerebf3CQpG/SGtobNyG7oJ5koHqHXZFnHVQvK1SM/FXlv4O/20vYRcEszlLGDYskEmfa+M8Ad+gJQjk5Drv7Lygl05yxKxJG6x0Uaq9Jq2pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6655.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:401::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 06:44:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 06:44:20 +0000
Message-ID: <47a75839-8fc4-4d01-9910-d58b6bbe59c8@siemens.com>
Date: Thu, 5 Oct 2023 08:44:18 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e321db-2fcb-4a49-8a68-08dbc56e80b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Qbsalel60Lip6Ouv4QF7H+BqAJPHc5e5tUbGQEFzSp/p5+YXrkpOTp4AC26bpCHMX6V5Z8KcmFHKJ3sMPj8XFTYGa70tbsztVX9wtxvYdLMAb0rM1iC6PMUuWsMw4vemJ5EOuPUbbOt6KvZuwVEKktfygYUgmdGuI/5jX1PBKK1DQimzr4rI6G38tmU7qVwkHdr+nJ4iIQuy7KMAXlI3JHDU7Z0MobmDYlq4dciQn0RNVxPGnWXE3shyRbojBssbxqBXU2tr0d5YXOyjNwax9fSng9sVJANWFsmdo1MNZL4QgqQX2HZvRRzhh0tJ9ZKeAN2YjJFbAnv8ptQU6SbxLg1Jpj1CPzsYbvSgtYSGA1VjFWpx6lbGpg4JLuruEeChFMHZ+na2D5zQEBQrbUheZb0DBXAH4SXZJKbHiSXmW+R4JcIkD6AOV9FFefL7M2lTP9zBElSGNb+F9YF2BFSszZVW9c5mLpMu0KadeW3cUeph9ZSY9O9kF5bcd4Dl1sATAJXVJIBh2EaxQqVfqAw/4y/ovV17JBHiEV58barkdT1EadyrduMOmuLshN8zU8m7jBvU1t/+6F208RKeVBJDR42B/Ok4Cz36HbPWpOdSGPk8if9uN2guakTmhY9ZYDKCkU/P671ad9G+ple47OEZig==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(6512007)(966005)(6506007)(6486002)(478600001)(31696002)(86362001)(38100700002)(82960400001)(2906002)(83380400001)(26005)(4744005)(2616005)(36756003)(44832011)(66556008)(66476007)(6916009)(66946007)(5660300002)(41300700001)(8676002)(8936002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V0phS09Mc3hQSDFJdXRZRGE2REdmYXVybVNINFVoc0loWlM1ekZtMVBvZzF4?=
 =?utf-8?B?ZHo1R1dEN1JRM3ZybGdKbGF3L2o3UEFReUxCdjF5N2FEdzdKNmFmRyttaU56?=
 =?utf-8?B?NFIwSTRXTUZBQXNlWHArTlZnRGgxb2tPTlpldlllOENQU1JNTklLRFl0bkJi?=
 =?utf-8?B?SDRwdS83VXllNC8wZExWK1RGSEZyby9ZMzJNdlJMTnFJNEQvUXlTck9Ta1dB?=
 =?utf-8?B?UXhrTXdTOFpFUW5CWDRDZjlIUVl1WERqbG5XalJtbHhONGMrYU9ZUXlJS05m?=
 =?utf-8?B?OXlCREJJSkwzaEFIdGtOblYvanVEODc5OEJmeGt1MlNsSm5WRnoySXZyWWxR?=
 =?utf-8?B?S0NXMCtJaExXUngwTnY4eENqMzgwZmZSVEp3WlJLYUNqR25tRXNDS1V0WXcz?=
 =?utf-8?B?aitPNzhKQUpvYmlhL3JTL2pkRkpDNjVRYzJkem9WNUN2V253bklmVm9KN2Jw?=
 =?utf-8?B?R29qeWtPSUgwbi81RVZ2N3N1NUJYclpHbHBWSTBTQWp2bVlwengyMlZuUkVM?=
 =?utf-8?B?ak1WQjRrUkJqVUZRMTZ6S2d2S3NYenFrVGt4MkNXWEFGZ0lpUVFpb2g5Vmlp?=
 =?utf-8?B?dDZuUll3S3BoMzNhY2Y0eFE4TStxeFNWUGFPUU93MDZZL0N6Rm0zZEU2WUpL?=
 =?utf-8?B?Ukk1WGFVVFlGajRXeDZ2cVVXTVo2eE9acGpVNEFlVmlROVhmUDRmOGNXbmt5?=
 =?utf-8?B?NERVNys4a3YvNmVlaGd5Mk1yK2lIWERmZXVqaHhRVCtsd256T3g3TFFBZlV1?=
 =?utf-8?B?a0hscjlmUnJuNjBHWVpvMTNKZzdhRkpMYW1TeXFtdHYrTkViNlEyVEtSZEph?=
 =?utf-8?B?dXpiWkVzQ1huc0Y0MlIrZ2hZSkpIcytZMFpwdHE2aTBFYVUzTkpBN0hLTnd0?=
 =?utf-8?B?eXZNaklDZkpxVExtR2Nuaitmdm1Na1BhbGZtaG44RU5selE4QWNpcmU2Y0xM?=
 =?utf-8?B?WFlkYklHNlNocDI5NjRXMGVyUFRTb3VVdE1XRVhlczh4c0NFZHN2TkIybFdY?=
 =?utf-8?B?QWZvVExtaVZvM0luSlNLRGJrUUVuZ0dqYTRvMjVST1c1a2hjbS9xTThuSy9S?=
 =?utf-8?B?YXVoK2E1Q0UyOFlQRVVTUXdKbm9XZUl5bWtrZDdibDV3R1RGY0pyc0lIZTE3?=
 =?utf-8?B?VVZBdnE3NnY0SkNBWXh4Ylh1WUpqUDBPMTQ4V3B6aEhiL1EwYmR6VWEzSk40?=
 =?utf-8?B?U1QwZEduVUZ4aWJVTXZ2RWpYWVRlVEFwZE00VnVOSkNLdlh0QUJNaGNEM3o2?=
 =?utf-8?B?R1hFbFhuZVMrTDZkMjc4bkF5dHBQVThySnhKeVJRenFhWnFDdkdPMTJ0RTVB?=
 =?utf-8?B?dGsrZ2ZIalNQTHBZMk5HZUJRYzRtU2VWUVRCUi9PbVM3Q2tkRkg2dFl4aDdh?=
 =?utf-8?B?UXhTclFLSi8xUTRaM0pVaFo4c3lkMkQrV05DZ3Y2SWJpa3RuN3dlM1JNamtY?=
 =?utf-8?B?TUVuQVpNby8zc3ZJNnJvQlUvb3crc0Jqb3RnamlwdXJqZGZxZDZNYWdvV2Vx?=
 =?utf-8?B?YnpQaFBPU3Y2bnc2U0llcmRnWlp2NGMyUG15NGtkVHlubW9iMkVZUnE2ZUNq?=
 =?utf-8?B?bmlLRkc3QzFoWkZQWWRabytoMktWL3FCK1pIR2xDd040SXBQVnBLUFN6NUVI?=
 =?utf-8?B?NmFFT29JYTlGRFJYczdPM1ZFUWFPT2ZwK3hrRDNSeGFrTytDTnhWeDBIYmVL?=
 =?utf-8?B?ZE8vT3JBaStxYkVEZ1Z3czVOeGhvUFZkZ0k1NjJYVlQwOUpOK1pWbTZoSXdS?=
 =?utf-8?B?OVEzUlUyOW9BRkhEMHplNHVHMUwzdmxDem4vKzY5VGZaZy9jbmhpcGEvUlpp?=
 =?utf-8?B?Wms5OWhuVGFlUmJ2UHhlV2xFL0o0ZDZoNUJnNmtDUWdVYW04NURxUXdFald4?=
 =?utf-8?B?dWNDSnVWVThoMU8zaTl4b2pwVGRYOGpQVVBRbnU0RkxCVmZzYjM5WlNsc0lY?=
 =?utf-8?B?cUQ3aXFZT1ZqUmRJSzRjRi9CdmRkN28yMzlReHhTM0hJWDhibDdkbks5NTMr?=
 =?utf-8?B?L1FnQW9YT2ZsVjlSbFFvVEJHNlRDNUhSZlJTaTJOM2JmZy85VTl4Q2taVXZn?=
 =?utf-8?B?dmlnN0hLMkwxK3ZZWWxRZ25PYlQ5ZVlZblVwZm5ROXJCSWpZaE1xS2xPODk5?=
 =?utf-8?B?VkIxYkQxWGYwZ2w1cXFpSHN3WG15WXFnc25YQkY4dHJ1bDlXbmVRWTd1cUU3?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e321db-2fcb-4a49-8a68-08dbc56e80b4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 06:44:20.1872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjDMCOI88RxJuj7/d7UTzlJuXudT8p97EMM4f17+oHjfa2qGRtAJ2LqHc/ey3MgeigW/rOf7PYJ93jsBkOlS2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6655
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Oct 2023 06:44:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13291

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=10&day=5&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/09/cip.2023-09-28-12.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB

Jan

