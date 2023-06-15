Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87751EB64DB
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 08:13:09 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.43])
 by mx.groups.io with SMTP id smtpd.web10.13129.1686816783479741997
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jun 2023 01:13:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="no key for verify" header.i=@siemens.com header.s=selector2 header.b=lDnp3j59;
 spf=pass (domain: siemens.com, ip: 40.107.8.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZFaK/5Lny2ucSgselNBYtN8P1i8aNHe76x36tFL3lh1A/IwiFOkqRrH0+NiKr4T3RxJdxfLB58j7vJKG0+TAK46r2wQh98amcaJ7cv+BNXoophZRZK5XZTS1PCr9YFbA4NHzzh33Eu9FB+Bozx07CmWFS+IKKG3uUmGqeRUkjldm3Mj78IoeIbic4banqcuL6M8985B63YJt2pguUlsN8i7y4XTCPZ9MRDxClQnEFIqo4z+2Sxc0XewJFw0864+3OZUaENLxPbfvcsCE+Yay18YAKh7QRRVvm6+OdCb+aPw2V9mgf8w89DPLyGmq4QG4dydjH27z43qR7p8DT6/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myBMHhweH4N/8QxmkCN74TlSwMPSYPLrSDE4lEyutKk=;
 b=XhkB3fQqMxEjAsUESOW51RaxukbxbzNhlStKDI5stOfo9o1iryLxGcX8oda4kaLTyh4d1zJmYdjDlwzGtFq+iDhDV5btiWnajALpOCtjbRo1PVivmkHOIQ/gp9j4E/tpKE7FFgb56eTsc1upFB+ijay9DHTJ2oV3DIG83jVemYYm7EFM0OSvoQgipRWzrrip92fqffMC/MGeZgVGjI80QcjsA8wf2000hZr99o4+e2RJChkZ4VKY8YUc7nVz9fE4xz07tFj6cUzN5IJDdOCD+FxX3DumYIihvo3L39tIKisYfYSxOy8GR/QHJkVov1hnajoPcnkm2oRvHZfISSaSgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myBMHhweH4N/8QxmkCN74TlSwMPSYPLrSDE4lEyutKk=;
 b=lDnp3j59O4A0d2U87SFOPROnOSGaUrJcS97Q0eZDIXib7DYqpRS2ncsFWra9K1KqB113PJalziomQrmPlscyVFT5pYRtn6CTRB4tluNk1HNfwE9nX/6UIv75HrRuM3vDvLSXAG3Oe1dOO4L9/fRol0jQXXaJe/FeHDKpdaZoDAl1BNmhaDja1DOdLM3ILkzCcSiCRGWuB7MAeUeB/GBTZ0GJxptzyK5HRRbuizBUJ3FHv5qWr/Vwi0ML9KmwGA/kmM8ZtFrmEhCOntbpVoEVSkPev4uocCQ82tl7tC0aIeIo/OpFKXd5L8KvZaVB6zvZWlW0R/+j1RoY2Rh7+jhlWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 08:13:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 08:13:00 +0000
Message-ID: <c2e312c1-e5e8-0f60-6117-5d8e62ae139e@siemens.com>
Date: Thu, 15 Jun 2023 10:12:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: 73119005-1b69-401d-d947-08db6d785563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VfG572eUunQ34XR/WRD+xDBQ/5Fjo/tc9wfaUCXRO6WYrbxUvy4DfxpHX+6iSXZCi+sAB0IY2MWg7HGpBklMn77Rw5Vh6c963j9JSW+7S4skrTeu7qp9E6BeZd7iYCzqzWQxBiUVk19gPh/x23Lk2N842wSQv/5VGfsVpI2q5sQsX3F3gKLR1HYDt5ViKkO1riQZM3+ySHLQieMpDMaEt0+2wZtGdUmqeIDmwGdED40DTtyhPb40j4yD3npzurFsGIvlP7nmYQWEqsT7dbjDakomtKVk4kjiECeIh2D3m264O2hZQflub38j4osfKqimSuoobbpayt3nrNxsET+Dvr/ytUjxhQAhUGIlfmYp2d45D5eS3zr/Gr4PjOzKXwXLBbjZv0qYINDLikBn0AxUa26key7ehAefXuSpI8D5prehrgze2Gx1dIe697p9k4fXcVgOcTNq+zOU7wms6av21BEM81CqJMJEIt4f46I90qDxFYRvx3aR5oqR+e4w52AAOPaja4Kolw9Qr7HgBaUsYTMpbVJC39Z4/5cXo61ALkzLXRXB9CTrk35e3zsvPkBv7WFGAZmgQ0NMfOuyZBJwUnH1iVPDnEq1QgdqIS+VA4Lk3fEixJiiiQcn6CKdKpgWLv1ZekFyRJHbBCH2apz+aw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(31686004)(83380400001)(82960400001)(41300700001)(316002)(38100700002)(6486002)(6506007)(26005)(6512007)(966005)(6916009)(66476007)(66556008)(66946007)(31696002)(8936002)(86362001)(44832011)(36756003)(8676002)(2906002)(5660300002)(478600001)(2616005)(4744005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TDd4YlR0OFl6NnE1aW5NaTR6MDRCbzUxQVd2TlpMbTZURDNvRCtRZmRYdmwx?=
 =?utf-8?B?ZTArSGdrV0NVS1pwU1NWZE5UOXZpdGdpZTgxM0VudDFjVCtSS0loWE1OaVBJ?=
 =?utf-8?B?MHZ3Yk8zYVdkOUl4Yi9qcHFKSG5uQjdHcXRIaERGWTR5dThxMjVFeUY2V2t6?=
 =?utf-8?B?Zm9NU3pRR2hQU2h5MGxuenVPVURIMzRTUFFEK3ZJR3hTc1U3bnI1R2hDT2o0?=
 =?utf-8?B?WEtwR2xXTkFEbjMxLzIzU1NpSHptSXlQVmxSRVVJVWdTQTR2WTVRcmtiS2w3?=
 =?utf-8?B?eG9GMXRReTFDa1RSWE5WVEZwUG94K2liSDVmSlhKUExWRTJqcGNQYURpRkd1?=
 =?utf-8?B?bW51b3lOM0plbVJuT1J1UW92Zkg4S0tKNmhCaGxsZDAxSno3bzFrZE9ZN0pp?=
 =?utf-8?B?YzZrT3pLMkovRGowem56TG93VUl6TEhCTW5hMXZuVHBpRURmdkVnc3ZPS3FE?=
 =?utf-8?B?LzNuZDdodkNrc3MxZmpDUEVnMVpaRDkybFAyaGxWUWR0UncydE5Wd3lLWU1H?=
 =?utf-8?B?WGcwaVZ3TkRyaTl3bEp1V0gzK2RGRUFteVAyZVQ2NjYxbFlWcXZWRERFN2N3?=
 =?utf-8?B?b1VXNFk0MEFUbDdYWEszTGFIdzIva2h2c2VBZEcrL2Jhb1F4SVN4UU9lRWZr?=
 =?utf-8?B?K2FwUk9SQmJSTkZuRGgxS0ZhdW9VdTVUQm5BUTl3MEpFSWxKTEoyRUVVazZN?=
 =?utf-8?B?QzJmMkhuWGljUERKVE5kVTJmeDEyVzFTZTYxakdSTkozd1hReGh4OEl1a1Mz?=
 =?utf-8?B?WDdGN0IwOFNkRzJTLy9ibU4wSEM0UXc1MGZxTTFoN0dLbitnRUNxNzJzdFV0?=
 =?utf-8?B?OTBIYkwvU2dPUGNzQ015WkZGa1lLcnJHR3ZGMmJSRVU4Wm54TGMraWVOV2kx?=
 =?utf-8?B?SUQ1RG9zell4RWdGTEFNNlZCdGRXVkRjMnVDZk5Bc2ZXZFhWbDVId3RIMi93?=
 =?utf-8?B?WjU4MDl1YTkyY3MvVEJXaWdmQkEvTXFod2VNZTVTM0V5Nzd0SGpibDY2WXVt?=
 =?utf-8?B?RVZzdFNJRkFkcnMySXE1cENtTlgyT2dNYTFEMzhYNGFxT3RkL3c3RDBtdlNY?=
 =?utf-8?B?OUVGRkJOaFpZTFZCcEtMblJQeTR1MDlkRGxTWEdvV3F2MEdyb0ZDUm5ZaDVa?=
 =?utf-8?B?ZmhJeHlSek5GU1JKQnlUNzNoOTRXemlxMGU1cmhmRkUydDJ6bklnVVRGT1Fm?=
 =?utf-8?B?M2twb0ZqR3RFbEJjcG1oL3VUOXFZN2ZjZUZyVjFSSE9QMXFqQVB1UkpWZVN1?=
 =?utf-8?B?cUhFQ0srMjRodktBb25MaEZBUzJOemlTaEVOU3RIYy9IbDdveGxUT2xZTXhC?=
 =?utf-8?B?aEUzQ1FLY2JVaFVmV09qLy85K3hJUlIyRkVPbUxGYTRHZjFXMFovdGN1OXFi?=
 =?utf-8?B?ZmlzZ2RGV0VMb08zdVVybDUrblRKN0dKQm8yWk5TZkYrbWs0MWJwc09TbEVN?=
 =?utf-8?B?QkRBN1FuUElmTUg4YmJQNmFuSVRlNlZDU3UrK2luMkJ1NlFvQW5iZXc3MW5y?=
 =?utf-8?B?MTdRQjlQamhoS3ZxMTFCek9UTUFqay9uK0pSK0dHajJaWmwrWDE3R2ppdStX?=
 =?utf-8?B?OGc4Q09zbjB1UytlMytpV1I5UEJIQVhkbWpYdmZZdFhmL1NydDZNOHhGa0E4?=
 =?utf-8?B?c3lyeEMvTE04K2tQVytaUUNkYjNrY1M2eEduYWVKcHp2TXpuOWR6bHBMY002?=
 =?utf-8?B?NmhEVjZ0VVNtV1BrZXBUY0FPalQwUEQ4MTZJK09vOHc3dUlKN3h4NkFpZHY1?=
 =?utf-8?B?eHNXUE9CS3c0U3gxd3JCazU4eGRJaFUwdUVGYWJsS2R1SDJ6VXVoYndPcDh4?=
 =?utf-8?B?dGQrTFFYZDJzbFhhSWVVNEZleTY2ZmFJVlJ5VHZWWmhJT1dzeTBtd0R4S0xa?=
 =?utf-8?B?MTExWUZwZFU1MGZXc1VEUmExRk1vNWYwa1AwSHo1QWpjamdERUVGbDZnZGdH?=
 =?utf-8?B?T1VYaC8zQk1vbkxtME16NzlIcVJCK3RlWHROb0NpZ3VRRVBXR1U0OEo0ZEsr?=
 =?utf-8?B?dXh6aUNybWxIU2VheDE5SWZQVVlkNTQrL3M0VVgzQUgxS25zMW1FdzhsLzNv?=
 =?utf-8?B?KzltZTcxVUVmbjlia0YzNWt4bVZ3T3BOdk5OTVFkV3Q1SVRtL3NtRFdmWjNn?=
 =?utf-8?B?a1NtWkRDNEc5dkNJNW5YblFydXJvQU5seVh4QXNjeDBQYVhMcmVjUitFbnpG?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73119005-1b69-401d-d947-08db6d785563
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 08:13:00.0480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWGWIA0M/j+B4RRxOOS0Ak1LdZU8FV2c1beFY2Dj+hH97tSGBOggilbNctTswdjlOvV5FaAMUgIrrGhM9SOeNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6693
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 08:13:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12040

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=6&day=15&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/06/cip.2023-06-08-12.03.log.html

* Action items
  1. create kernelci pipeline for buster images (arisut)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  [- 6.1]
* Kernel testing
* AOB

Jan

