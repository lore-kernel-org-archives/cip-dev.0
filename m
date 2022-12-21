Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59670C4332F
	for <webhook@archiver.kernel.org>; Wed, 21 Dec 2022 13:02:03 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.49])
 by mx.groups.io with SMTP id smtpd.web11.17802.1671627719455975803
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Dec 2022 05:01:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MiQJFeIG;
 spf=pass (domain: siemens.com, ip: 40.107.249.49, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJieRw1Xqh+bpV4UbuW3LcgCWNIlToXlPTlwS7TLxwFuUpkDxFiWr34uygmiE0oRiO7rYTIshpY0sMO+MA1bNTWjR9la4pf4BdFqiMty99ecf3Vps4XxANcEHC7QcecNElhi2xTPtg2HVAegqLLrk8gA9vckMVge2O5CWGICXg0cXo1/whiVxJO92djXmZY+Kadz8Mb682IFwp+vHekkKrVEMZcyC3q4KxsQXC3QKdqYZKaXnPl/X29QeLU5ZRVO9DNbyENm/BpFgha9XUUps7rNq61AU3uCNOQD3jxVqwRl2ED/PegiuWXDO6hD3rOStTmoZrkQofMcom65bufiaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVNJlQKvim5p524jOVC7s5aZK6pAAPjucjkp6Wmd2Nc=;
 b=TY0ql/13u38JX43RfgJvwQPJkbI5D7KzPn0swVoGQUoLca/QqQciPXfTWlr8v110DLLLpAhqlXVsxbvxaX7yNPraWwa8cP5hYZjLmLonApmZPdpgMgGnyympEpTHM7mceTPfntrdEqb3rpoXei13l7dM/4tXhcap7VyfU200pZGcuOSe0CkYn0Dz1Lw6yZycHyZxqoArIZkDt1CDJFRYMXQYmqWgGU7z2QBgy5DhculNivnKnzB7ioE2pNBBjkaWP14FNXCXRq67T9qDC1SrYMTlCYNaf+t2SACJGfPDnGxnBN8zf78Af/K6gwvBrudXCUHXO+PkQBc9uIlyj/9jKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVNJlQKvim5p524jOVC7s5aZK6pAAPjucjkp6Wmd2Nc=;
 b=MiQJFeIGJvRpxGm5usmkO3Uce+pV/EhZen/4YjtPhPPKS0GU+2m2Be1R6qcEpd4iSvjk3UIZ52cz2AapNCAK3eeCUwVgh1gV+8Dc62RPjnMNNPaa3uz9Q4xQozYNJs12EXL4kkIDe9sxMU4CB1iZypjI/JCJ3G4pP6oHhasdicI0loPPvtQ9N0FBAITLY4bNSCP9h4FL3ZWbr3ckoIumKijrLv98aZum1mrG6YdnX7jCwBtnH8om/xjIN3jJ4pfZLPKkglBTl1R3E56ligDw0rboCbfuRhIhAlqhQeN28jXejYb/B4aTMqTASqNyZbvJBIZnCq5mo+ec7JFDLzQrPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB5429.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:328::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 13:01:56 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::793f:57e:21e9:3741]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::793f:57e:21e9:3741%3]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 13:01:56 +0000
Message-ID: <8a8848a0-a801-78bf-e4db-162c19aa3f31@siemens.com>
Date: Wed, 21 Dec 2022 14:01:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [cip-dev] [isar-cip-core][PATCH 0/6] improve root home moving for
 layers
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org,
 "Kiszka, Jan (CT RDA IOT SES-DE)" <jan.kiszka@siemens.com>
Cc: Wang Jing <wangjing@siemens.com>,
 Henning Schild <henning.schild@siemens.com>
References: <20221129122451.32155-1-henning.schild@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <20221129122451.32155-1-henning.schild@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::9) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB5429:EE_
X-MS-Office365-Filtering-Correlation-Id: f88e9d91-89dc-4bb1-76fd-08dae35389cd
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cJgcRYxXqx6fPDgB5lSfVchKRup0qZvDfH3kullL2MSKIDvBlIK13hj5wK2JizGXR0JuhIcdOj3RpNhOrKP+y6/TDKscFS7nRrq9TYfAUDWWKhGB3WsObHau77U851oul/hYrbxA4FQRsqNLSUW1ZBjviLzPnGns7jnxgIIROq+JABEB+1nYQiyQYq4jZ0V4rXA7Xoz1yeTmyD6FljxC9Lh5stI4udgw8Odh2MAorIMcbTYbXj8OIqSiT/jFKfigqOe+gXvlJEncp3p54O47OmvnTLLBgaQQLFn9SeVKC8GizEEW5goO7H76ASK8hS5+VywFEMfuHdHsH6j/SFn5h8UCatdr/K5NFAxF30M1AdYZPzvDUs/e5GiuMsN4mO8lfCgq2+brpco8v94M/yA8Cgqspjqe1jNwD4CY+drVkfpyulcReWmarsCYMtpq/r4te0jBbwpYJ7IOs2o/IR1BlUbNofx1csZ8r+KqYKj4/7LkmnB/BaSlkdAxvK/Y3cfSw55Tf/veBkdiid03mqbu4eL8UpdLexpnYEr92I7loO392xl9K42/auSbEtEigFzfLBndUdHTRGO0f0hh9wWTYS5koz11clrIQGrmwkjiHCgDXAxZVCugLTlhX/1CHAn9Nt1eANUeaQWk5ovb3lKqFOntaGAftNUXfILJHNMuTDkvPuJKg/NJdf0QvjCIxbIpbrtkdxI+aYwiarTZI0aDOl5kAFWQb7vxY1cazXmpTuU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199015)(66556008)(66476007)(66946007)(4326008)(31696002)(8676002)(316002)(6862004)(5660300002)(37006003)(36756003)(8936002)(86362001)(41300700001)(2616005)(53546011)(186003)(6512007)(107886003)(6506007)(36916002)(26005)(83380400001)(38100700002)(6636002)(54906003)(82960400001)(478600001)(6486002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TWpJQ3BsTDQ3ak9ZeXphdklSL2lsaUM3Y0JGMi9qakVWOGg0bkFyaERYQkEx?=
 =?utf-8?B?SWkrM1ZzZitzM2pFazhvdElRRUZnL2RyVWxjSGpiM1Bjb0FFeC9ZVityd0M4?=
 =?utf-8?B?OWdFZDZkY1VUNEFsVFR3U2Jxa254NFZrVktna0liK29jNWpGc0ZIUkdGSHZt?=
 =?utf-8?B?YnRqa3pER3BVdHRJaVRVVjEwUytZWENsUit4N3F1MmhjaFliSWpxVk4xK2hN?=
 =?utf-8?B?TkNRd0NwV0Nid0c5SzQ4SGZnQmJmOGIvcHBCeExrRGh2NExaS3QvTDZDSnlx?=
 =?utf-8?B?V0ZwMVlUT0R6cXoycytoMmRLOThTaml6Z0xoUkJrQTNDSHcranZXT3lCTlFm?=
 =?utf-8?B?QzIvZDJITWk0Ykc1SlJaU2ZmcHJxcE12Tkt6TlRmb0ZZb1pXRVgvSTYwc3lG?=
 =?utf-8?B?bGVsVnlmSndWYlpYY3dtYjJITWtQR3FsMDdwWGs1UjNUYUh4SjljTlJZU28x?=
 =?utf-8?B?RXVmSytkTFBUcEQ2L3JnUkw4Rko1ZDNUUEUxMWtHdlNBK2FaN1JUQ1FSbkxR?=
 =?utf-8?B?SGptRDVEMHh3a0lNb2hDcWg3MFJ4S25QRjZyQTk1Y3h4WUVoQlE2T3hqRExa?=
 =?utf-8?B?Um1JNlBCWVMzZm5ibnpaOXhWcGZQN2ZvdnRyd3gyN2t2Z2NNbERUVXVwaGFz?=
 =?utf-8?B?dVpHcnFuL2Rkc0lSYlc5VGloUzJjY24raHpCeVEvczN3NEZ4dktDaFJ3UndN?=
 =?utf-8?B?MkpjUm5xTG9FUFl2anB1ZFhvN3BOcjNXWTVBaHFHYmRrK1NBM0doODNYK0Zp?=
 =?utf-8?B?MGVneFJCNzJJa2NzejFsMlg1WGhuc0N6akhabjRLb0hZd2lVdlVlZTBtUUo1?=
 =?utf-8?B?T1Z6SlRoaks4cWFVb21aQjE3enpLRUxjMXpXSGN6OXhQdHk5R0gwaHVQQlY1?=
 =?utf-8?B?TVZzZmY1aEV0NXlua3NYZGREOWIzVlU3L0FDeUc0NUpyMld3MUl0QXhGeURB?=
 =?utf-8?B?SFhhZGpWbFFNV2VqQkRpckhGTjNuUS9QUGxwNU5vdmx0eEpDZkczOGlucnEz?=
 =?utf-8?B?NGNjRzVieEVCOGZ3NjNxeWVGR0tIL01XWDhMYW1RMlR6RTFESFBQSWxYWmFl?=
 =?utf-8?B?TGpkUjZ1NzR2RGFQd0xleUpsM2Q4M2hkclU2UldSUlRLYUZiNTVXTSt5YkhX?=
 =?utf-8?B?RWt5ejlMckIxcjRVMENMNHBjc0V1THFSU2RESXZJMGpWUnhMOGtiVUVRYzFM?=
 =?utf-8?B?S2dhWVkwbU5kVzA5UjY3MmpIYlMyYmZSbzB5aVNwOXd2cThBQlpwSy9HdzBt?=
 =?utf-8?B?bDdWTEovTEprYUg5d0ZJSjhOQVN4WFNhWjV5UWUvL2kwZ0lGMzkrUWd5Ryt4?=
 =?utf-8?B?ZG5KbWRNcVFYUHd4SmlEOWI5aXAzTndOM3JIUlBXeXQ0dkg0NVhwK0djQTlj?=
 =?utf-8?B?L2VQU0c2cWpiSUVTVHpUSmxKRWxMd0tHU2ZGZnF4Y0I3OHhpNXFGbE82MjNs?=
 =?utf-8?B?Z01HQXN2VmlZWVRTN1VRY1VvNWVXSk95UEZDRzlFOU4rOW1nR1pUNGVlMXpJ?=
 =?utf-8?B?czg4OEdKMUxPYjdCVzN5N05iYnFYTmVuRUhuNGp6eDMwMHdka0FYQXdjZTlX?=
 =?utf-8?B?TldhSWw4NnVyZTBjd1d6R24xa21xRmxjdnZZcWM0K1pjYzE4UGplVURpR080?=
 =?utf-8?B?Y25EckxaYkxsMk9pUnlrcml2a3hCNFVWSkFYTHlqZWVBV2ZPb2tnUndrTGc2?=
 =?utf-8?B?TklVS0VxV29QMHg5M01lVlNKeGxCcFpMaWVsemlUZWdkV1ovMjFqaTgwQkFp?=
 =?utf-8?B?aWNORkZJRk1reDYzN0dSd1ZDZFRsUlNZVUhOY2pDY3N0MkRZOFhjSVByWFNQ?=
 =?utf-8?B?VmJCamMwT2I1U3FqQmVjektrYlkvMUZ1UmcxTHhVTm1tam1jUTA2YkFHVFlo?=
 =?utf-8?B?bTE5TUVVKzBvS3hmRXgxeExjQ3A1VEFnSS9oRDBoK3MrcjNFMHYzZTQ3ajZU?=
 =?utf-8?B?R0pUc3ROSmFwMU5WVTVRdlhJekVPb084L3BpOU9uT1FlR3VWSmtiTzBlSHor?=
 =?utf-8?B?T1BOdFhQaC9aLzV3UXl0Mm1HMHBCak9FVEt2ekRWb1BxTkRoam5EZ3gxM3pi?=
 =?utf-8?B?cTNSMnJvQ0VrODFmeVlUeVhNaUExQXJNaXFwTVRqZVE2dlNjc3NQMzFQYTZx?=
 =?utf-8?B?SXJvUXFkS1pxWTlVSTFGMDB3WFhCaklqNFlnWnpsTE1YVXJRdEJISlNQZE5G?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88e9d91-89dc-4bb1-76fd-08dae35389cd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 13:01:56.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEdFkEVggCrFhQRqset81yKtTa7Ad9oHhoIeUYfUWfC1JeFGHHx0EPkrqZYo83Osw/IFHT53cu6Naj0tWjT/q5LyzLPnZW39abiIAJiW9+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5429
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Dec 2022 13:02:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10256



On 11/29/22 13:24, Henning Schild via lists.cip-project.org wrote:
> The original idea was to make the rootfs home dir move and symlink
> reusable in another layer, while also playing back some findings from
> that other layer.
> 
> That is p1...p4
> 
> p5 and p6 are drive by findings, feel free to pick in any order i do not
> care about them too much
> 
> Henning Schild (6):
>    customizations: make postinst idempotent
>    customizations: make postinst script report all potential errors
>    customizations: comment why we can not actually change home easily
>    change-root-homedir: split root home move into own package
>    kas: set clear text root password
>    CONTRIBUTING: fix note on patch prefixes
> 
>   CONTRIBUTING.md                               |  2 +-
>   kas-cip.yml                                   |  4 ++--
>   .../change-root-homedir.bb                    |  5 +++++
>   .../change-root-homedir/files/postinst        | 21 +++++++++++++++++++
>   recipes-core/customizations/common.inc        |  5 +++--
>   recipes-core/customizations/files/postinst    | 10 ++++-----
>   6 files changed, 37 insertions(+), 10 deletions(-)
>   create mode 100644 recipes-core/change-root-homedir/change-root-homedir.bb
>   create mode 100644 recipes-core/change-root-homedir/files/postinst
> 
> 
> 

Looks good to me. Tested with qemu-amd64.

Acked-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Quirin

