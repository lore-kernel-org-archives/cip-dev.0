Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B75EB64D9
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 07:31:48 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.89])
 by mx.groups.io with SMTP id smtpd.web11.16462.1688628707189292278
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jul 2023 00:31:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=brvUk/qB;
 spf=pass (domain: siemens.com, ip: 40.107.14.89, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKBpwf3KK5VKK45J2A7YErPinwTKd2YXezwQuVEShgcavJtstpjJhbhzJCvqcIlkaSCoxmmpzlJnljlJP8aRMHjim25/yR6mgkhmZOKH4i8LfFhvekKXF6YhzMS6AvGvA0ouf0tTuRV0ds1vfbqG/6EEdIE+CJfLYf/aIP1afyf0R02K/kDhL75gLx3jNk2dKKYON0F2zmvnWokcGqLQa6z2OsYasLlP1KDKkEko/WLGLFsqm+dY+Lbj8ihbyVd56UvpKc9rCv/LWENMgOhMaOhuN2YchXjpVxAoHqqw4jnVMAEplhMV9kIbhLPHDnpkxOWqy6aInmAOQUSgJDNxHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Trsl0ZAmevi7EoytmHqklxEsfn+Yho5LU/4tkeLKcbk=;
 b=SD6s8YvQxEuf9LLlQj5DqiXUqqVZof19AryxwXnKKJ6JHKgsxP0FL+FxFO9WFO9iaIXvzXbaXonbXZV+TOCjLHGS4RprwTCow/3UbGwrJ/uc5qB8HrYNq0vxMp+JmFT+C8BiYhhIJtV6aQ08fT9cYn/zLijUa7EOpxGCGXEZx10C5+1h2fOeHKJm1YlOzkNVH3I9hnf8waAU84zJQW7e8t4B8SFkGlM/X2WaAUF17KeBSxA9ofnyDS/jxQDXXHYHAErenCu67nJriOUKXriiks8vstN57oqk3br3PeykHAUARbv/JVrxEZx6pKcZWhwsAShE1gn2FYFMyQysNbJdpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Trsl0ZAmevi7EoytmHqklxEsfn+Yho5LU/4tkeLKcbk=;
 b=brvUk/qB3ejt7zuZr55OeTapqH1qTIZ/Kk7QPSFgsVCHDe8QqvSfvtcqb0hkyuPrC23dJnLnDVyMJFk1540ADkrP3Ll1XREhv1e4LIq/9uohr1XXY2o7f0LeessckXkI2n4xwHU6mx48jeM8rqO6H/EU6iF5pSCKYtJcNxrLg7gIynmXG6cL7twWajH3XYGAnUbFVoR6Z4AK/CLWQZfYGuTD4ejtQICi5rSK7S4Umo9fwTpJyRqP4fX2+QW/QGg9piVe8lraPkauBQ510AULjJX0QH+pOZFe7POQjCxN2ZIlnREQ3uk8E0Rdl3gz8n/eeiOBOnhAL6xV85vLOnqmCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3357.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:31:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:31:43 +0000
Message-ID: <a5ced839-1588-934e-5c4a-e2a967210aa6@siemens.com>
Date: Thu, 6 Jul 2023 09:31:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [isar-cip-core v2 0/2] Modifying security customizations due to
 deprecation of libpam-cracklib from bookworm
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230705073358.16663-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230705073358.16663-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3357:EE_
X-MS-Office365-Filtering-Correlation-Id: ebab51b5-7f94-4e9c-828b-08db7df30bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	24yNQ2dKc7xDEjHBAS0BBorR2P+C18gjZnCm3lYgYrr/qVCOxg3QV2Cbt89+fTsg1OZdjrkSmgmcvmrI1XES9BG2kTCiWOzBtjB0La3DakkAqy4un93SPQgwyMINTUm7bSf3FYOiVdbf97S5InUqE9YIr+g5E3GEht74thQp08+pHvZY6Vy3mGpDQBc2jSi2k+iGefRdVb9aQC2paoLpmGh42956jSkKUiDKSfCWWTz3TQ6hR5r0qh6VHJb+ls4kyhbHmLsXeQVFjX/rb0DlVDxvk4cUqQUOYUC41LzGNh3RmnKkC8v4JrxORANF1RVO0nUzvh2TwdzHU8DpYHWclZvAJNb+ja0hTFFhKqI0I+Ik4Qurib5ANSgl/kiGc/lG8V66pM+mW/fBMgcrnZzvh+ubjoRB2LT/UMhnaCTLAdLgFKW+vmNqgy2cf1WABWmQkHfCChCY/RJo2nERMQE1hqV6vWJ5CNC5xDSbpYB4iv0FLt8oxnzUTSiV4+qq9kSGc+yxlNzpPP1xUUCpcR+f3RyyiklbJS5/NcOi/SGzHoKZ42hpD2edSAUHNJG2QvNg/Tr4T273QfzqgaUpp3Yp1pdDd59yuj+mHWp0QHoHcZeHbL+cvY+Ri9dmEdy1M+h+vL+1KRvxnroaiX8EA/Ed/g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(478600001)(6486002)(2616005)(83380400001)(36756003)(31696002)(86362001)(31686004)(2906002)(4744005)(15650500001)(26005)(186003)(6506007)(66946007)(6512007)(41300700001)(53546011)(82960400001)(38100700002)(316002)(66476007)(4326008)(66556008)(5660300002)(8676002)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OGszaGx5Z0tmbTFqVmcvd05oRmRmcG1kbFczclZpc0dRVzhZbDNDQlJYNnpH?=
 =?utf-8?B?Y0FMMGYwYlRGUnNBVytYeHppamYzeXdodEJmdjhZUkVoVXBtRE5TV1BRTUhJ?=
 =?utf-8?B?UDlBaWU0cXZKY1ZqSEZKbVRydTZYbWxnK3dRdytaOXBQdS81RFRPeDNXUk95?=
 =?utf-8?B?MXJTNy92RCtzOU9lNFVIY0R3WHpqMHBvMmRTd044eFJZMjNhZWZ6RUt3MGE3?=
 =?utf-8?B?aERha0xkSHNKUlZPK0lZalFpcjlwZXhUZXpCWFRDOHg5YnFQeHBwTmtQbHoz?=
 =?utf-8?B?ZGVXNElIRGZoaWVaSURkditiVnJqclBPTUJTUFpQSEdBN3RKYmwrSktzWmVn?=
 =?utf-8?B?Uk5aSGRnWUt2REVtMC9xaWJoTVYwMGVPenhGSXZvVGdpQktkM2JIaWdoYmpp?=
 =?utf-8?B?cjJoeWRxcmpDcnRZTnlQMnpsZ3VTdENqNHMyZDZjZisvc0hxbUo4dFVuUkhs?=
 =?utf-8?B?ZDdOZ25mSVFwcEV1Y01ZbDlxUjJ3eU43M0dEK2dqVXo1Q0QwQXh2dUxFa08w?=
 =?utf-8?B?NWU3dmZqUmNsZVZhL28xcGN3dHVnYTZuQU4zeSszcFNrOXRPSTlFaWhlN1Ur?=
 =?utf-8?B?RjRQM21HQ3VqRnZEOGFCYjcvcnk0SkpSQVFBVmM4Ry9LVmYrbEZFd210TEtj?=
 =?utf-8?B?L3NZQWszcWdaZnl6emZ5aVpodzhqUkpBbE9EMXdUU25xUFNTZVNabjNxUUd2?=
 =?utf-8?B?dGVYNGR2blB0bC96UHJtYlF2WU5YTWUyRk4vK0ZHU3l5OWlnM1ZnS2doejNs?=
 =?utf-8?B?a2RrelhwZnBHT1ltVHRJNUNTOHd2WkpqL0JuWGdaS3UwY05jbjd2RU9pUTFv?=
 =?utf-8?B?NWsvMWZzQUhQU3dicGFmQ01SalRTQU5tTGR3cS96eEtxR1VVcWMyZjlKQlhn?=
 =?utf-8?B?aHNzNG5rb2ZoNll2dFpFQS93UFYxbzdzWXAxWlZ2SXdMMEpUR2RML054Si9R?=
 =?utf-8?B?V0VBeHA2Z1B0TFo5L0ZRN3BSeURMZDdmT282R09qZlhyVDEzSmVuYzlIWTlo?=
 =?utf-8?B?NzRxQTJHV0Z6SnZjN3JGelV3NmJ2YVJnQks2QkVKeFN2Zk9IdUJIRjNJeHZx?=
 =?utf-8?B?TFAzek9rNjUxTzU5SG51TDRpUm5wZWcyclQ2dHhjQ2VBeTU1WXNtc0N1MDBq?=
 =?utf-8?B?Q2psaEtWVlg1cys0UExabXNNNkRmeG9uenAwemRJMEljcGNrNWdtNkdvc2tT?=
 =?utf-8?B?QmdlNlhDR2pYeGRleFVYM0FOOG5GbFJkVHRUTi9ybUtHTlJtN0s3OHhtYnJj?=
 =?utf-8?B?QWhWU2MvSHlVNkZrN1lRSFBaNWNOUitQS2JSS25KZk5GMy9wYzRwMVRYeVdy?=
 =?utf-8?B?R1lSMFpKcGdMV2tqbnVURnRHUDRQWWVEU2dQUXFzRGs0aTN1eTdRM1pBaDBX?=
 =?utf-8?B?ZzlWd2NZK3dPVmNmbXZpRVpCYW4xbDdCeG95NnhybW5aSk9aekdkUnBYajVZ?=
 =?utf-8?B?aC9BRGdpQXgvNEx2TEVuSkh3OGtBRzFSWW5vd2R6TitPWm96dzhKTjhkRDNK?=
 =?utf-8?B?d3VNZXE3QXcwYUpKNkh2Z0xnc2tXUlFMT3BPK01jcTVKNFI5N0EzRXdzSHg4?=
 =?utf-8?B?QzI2eXhzNGxYWm5BVWJWSnkxKzd3K0syVWVwcTdZdHpGTWp5WmNSa3FKdGxD?=
 =?utf-8?B?ZWVGL0NPaDUwVGxJbEJzRDBaTU1JZklNSUpnbU5hMENaNmdwQWdxdk1saVNQ?=
 =?utf-8?B?enArQ0NSMzhaRHNmU0JiVjVaanlwVzYrK3lTOStLcHd0T2xUa1gwS042SzJS?=
 =?utf-8?B?amw1S0M0UmcvVUFWbklMdDVqeVlyTlJNQ3dNeU5Fa3huQ1VCRElYc1VJMk1Q?=
 =?utf-8?B?RTMwZHNTN1I1bWNsSmFhM1NENXNXd3Z5L2hUY0I1NUpZc1h2aXFOd0dNL2tC?=
 =?utf-8?B?V3AzVUIxa0svRE9XdVdVSG80djRxU1RtMjU3RGkreVEwNXNuYjVXaEtqdGxG?=
 =?utf-8?B?RlpZcVU3b2RLanlxcTlJRllTT0tDdUM3NzE5c01BUzE1MmVoK3o1Tk51d211?=
 =?utf-8?B?WHd3a2k3VFFzbEZCNmR3ZWJUcVRhUXQ5M3gxOUhZcW1YY2FRSjUyazFhcXVu?=
 =?utf-8?B?aU1OOWs2T3NNQTNMYkdaNFZmZTlrbHBxZWNkMWNTdG55aHl1YmFaVFNZSWE5?=
 =?utf-8?B?Wk44Sno4NlVCWjlVRy92NlJBeDdQNnZBbTNrRDh5MGJ5REdJYnRmUHZjYWNU?=
 =?utf-8?B?UGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebab51b5-7f94-4e9c-828b-08db7df30bf4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:31:43.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: comxcickWLhOpiD//svFabcu0BcC3c+Ixi70Nj6H3uILH9nOBRY0SbAvNo5Ow3rBGIZkJT0INZZvmHYH6MdgYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3357
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 07:31:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12252

On 05.07.23 09:33, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
> 
> When compared to previous version, this v2 series of patches has the correct order
> of patches. An extra change to display the latest password at the image login is
> also added in patch[1/2].
> 
> Sai (2):
>   kas/opt/security.yml : Change password to fit pam_passwdqc policy
>   cip-core-image-security.bb : Add pam-passwdqc package for bookworm
> 
>  kas/opt/security.yml                          |  2 +-
>  .../images/cip-core-image-security.bb         |  9 ++++++---
>  .../security-customizations/files/postinst    | 19 +++++++++++++++----
>  3 files changed, 22 insertions(+), 8 deletions(-)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


